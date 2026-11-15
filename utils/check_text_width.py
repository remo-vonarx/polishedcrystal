#!/usr/bin/env python3
"""Report text lines wider than the 18-tile text box.

Usage: python3 -I utils/check_text_width.py [file.asm|directory ...]

Dialogue, signs and phone calls print 18 tiles per line, Pokédex entries 19,
and the few texts placed on a plain screen from column 0 (SCREEN_TEXTS) 20.
Checks maps/, data/, engine/ and home/ when no paths are given.

- A line whose width depends on a runtime value (text_ram, <USER>, {d:...})
  is skipped and needs a manual check.
- Each branch of an `if`/`elif`/`else` inside a text is checked on its own;
  text after `endc` continues from the widest branch.

Exits with status 1 if any line is too wide.
"""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DEFAULT_PATHS = ('maps', 'data', 'engine', 'home')
MAX_WIDTH = 18
DEX_WIDTH = 19  # engine/pokedex/pokedex.asm clears 5 x 19 tiles from column 1
UNKNOWN = -1000  # pushes a line with a runtime-sized part below any limit
SKIP_FILES = {'credits_strings.asm'}  # the credits have their own layout
DEX_ENTRIES = 'dex_entries.asm'
SCREEN_WIDTH = 20
# texts placed on a plain screen from column 0, by file and label
SCREEN_TEXTS = {
    'engine/menus/save.asm': {'.SaveUpgradeScreen'},
    'engine/battle/core.asm': {'.Format', '.Result', '.Total'},
}

# tiles printed for each token (constants/charmap.asm); 1 tile if not listed
TOKEN_WIDTHS = {
    '#': 4,  # "Poké"
    '#mon': 7,  # "Pokémon"
    # names typed on the naming screen, PLAYER_NAME_LENGTH - 1 for all three
    '<PLAYER>': 7, '<RIVAL>': 7, '<TRENDY>': 7,
    '<USER>': UNKNOWN, '<TARGET>': UNKNOWN, '<ENEMY>': UNKNOWN,
}
# "'d" "'l" "'m" "'r" "'s" "'t" "'v" are one tile each
TOKEN = re.compile(r"#mon|<[^>]+>|'[dlmrstv]|{[^}]*}|.")

NEW_LINE = {'line', 'cont', 'para', 'next', 'next1', 'page'}
RUNTIME = {'text_ram', 'text_decimal', 'text_today', 'text_plural'}
RESET = {'done', 'prompt', 'text_end', 'text_far', 'text_farend', 'text_asm'}
COMMAND = re.compile(r'^\s*(\w+)\b(.*)$')
LABEL = re.compile(r'^([A-Za-z_.][\w.]*)::?')
STRING = re.compile(r'"([^"]*)"')


def strip_comment(line):
    in_string = False
    for i, char in enumerate(line):
        if char == '"':
            in_string = not in_string
        elif char == ';' and not in_string:
            return line[:i]
    return line


def string_width(string):
    width = 0
    for token in TOKEN.findall(string.split('@')[0]):
        if token.startswith('{'):
            width += UNKNOWN  # interpolated symbol, like {d:NUM_UNOWN}
        else:
            width += TOKEN_WIDTHS.get(token, 1)
    return width


def display_path(path):
    return path.relative_to(ROOT) if path.is_relative_to(ROOT) else path


def screen_labels(path):
    posix = path.as_posix()
    return next((labels for name, labels in SCREEN_TEXTS.items() if posix.endswith('/' + name)), set())


def check_file(path):
    problems = []
    file_width = DEX_WIDTH if path.name == DEX_ENTRIES else MAX_WIDTH
    max_width = file_width
    screen = screen_labels(path)
    width = 0
    branches = []  # per open "if": [width before it, widest branch end, has else]
    for number, line in enumerate(path.read_text(encoding='utf-8').splitlines(), 1):
        code = strip_comment(line)
        match = LABEL.match(code)
        if match:
            width = 0
            max_width = SCREEN_WIDTH if match.group(1) in screen else file_width
            code = code[match.end():]  # a command may follow on the same line
        match = COMMAND.match(code)
        if not match:
            continue
        command, rest = match.groups()
        conditional = command.lower()
        if conditional == 'if':
            branches.append([width, None, False])
            continue
        if conditional in {'elif', 'else'} and branches:
            branch = branches[-1]
            branch[1] = width if branch[1] is None else max(branch[1], width)
            branch[2] = branch[2] or conditional == 'else'
            width = branch[0]
            continue
        if conditional == 'endc' and branches:
            before, widest, has_else = branches.pop()
            ends = [width] + ([] if widest is None else [widest]) + ([] if has_else else [before])
            width = max(ends)
            continue
        if command in RESET:
            width = 0
            continue
        if command in RUNTIME:
            width = UNKNOWN
            continue
        if command in NEW_LINE:
            width = 0
        elif command != 'text':
            continue
        for string in STRING.findall(rest):
            width += string_width(string)
        if width > max_width:
            problems.append(f'{display_path(path)}:{number}: width {width}: {line.strip()}')
    return problems


def main():
    args = [Path(arg).resolve() for arg in sys.argv[1:]] or [ROOT / p for p in DEFAULT_PATHS]
    paths = sorted(p for arg in args for p in (arg.rglob('*.asm') if arg.is_dir() else [arg])
                   if p.name not in SKIP_FILES)
    problems = [problem for path in paths for problem in check_file(path)]
    for problem in problems:
        print(problem)
    print(f'{len(problems)} line(s) too wide in {len(paths)} file(s)', file=sys.stderr)
    sys.exit(1 if problems else 0)


if __name__ == '__main__':
    main()
