#!/usr/bin/env python3
"""Report text that Polished's text printer would misread.

Usage: python3 -I utils/check_text_mode.py [file.asm|directory ...]

The printer (home/text.asm) runs a command loop: a byte below $0a is a
command, and any other byte starts a string. A string ends at "@", at a
command byte, or at <DONE>/<PROMPT>, which also end the text box. So a command
right after an open string is fine, and so is a string between commands. What
goes wrong:

- text_end after an open string: its "@" ends only the string, and the printer
  runs on into whatever follows.
- prompt while no string is open: the command loop ends the text there
  without waiting for a button.
- a text still open at the next label: the printer runs on into it. A text
  ends at done, prompt, text_end, text_farend or text_asm. A string closed by
  "@" may belong to a PlaceString text, so it counts as ended here, and
  `stop_compressing_text` right before the label marks an intended fall-through
  into a shared tail.

Plain strings (db, rawchar, li) aren't texts. Checks maps/, data/, engine/
and home/ when no paths are given. Exits with status 1 if anything is found.
"""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DEFAULT_PATHS = ('maps', 'data', 'engine', 'home')

STRING_COMMANDS = {'text', 'line', 'cont', 'para', 'next', 'next1', 'page'}
INLINE_COMMANDS = {'text_ram', 'text_decimal', 'text_today', 'text_plural', 'text_pause',
                   'text_sound', 'text_promptbutton', 'text_start', 'text_far'}
ENDING_COMMANDS = {'text_farend', 'text_asm'}

COMMAND = re.compile(r'^\s*(\w+)\b(.*)$')
LABEL = re.compile(r'^([A-Za-z_.][\w.]*)::?')
STRING = re.compile(r'"([^"]*)"')
STRING_END = re.compile(r'@|<DONE>|<PROMPT>')

# printer states
OUTSIDE = 'outside'  # no text open
OPEN = 'open'  # a string is open
BETWEEN = 'between'  # in the command loop, after a command
CLOSED = 'closed'  # in the command loop, after a string closed by "@"


def strip_comment(line):
    in_string = False
    for i, char in enumerate(line):
        if char == '"':
            in_string = not in_string
        elif char == ';' and not in_string:
            return line[:i]
    return line


def display_path(path):
    return path.relative_to(ROOT) if path.is_relative_to(ROOT) else path


def after_string(rest):
    """The state after a string command's strings are printed."""
    end = STRING_END.search(''.join(STRING.findall(rest)))
    if not end:
        return OPEN
    return CLOSED if end.group() == '@' else OUTSIDE


def check_file(path):
    problems = []
    state = OUTSIDE
    last = None  # (number, line) of the last text command
    fallthrough = False  # the last command was stop_compressing_text

    def report(number, message, line):
        problems.append(f'{display_path(path)}:{number}: {message}: {line.strip()}')

    for number, line in enumerate(path.read_text(encoding='utf-8').splitlines(), 1):
        code = strip_comment(line)
        match = LABEL.match(code)
        if match:
            if state in {OPEN, BETWEEN} and not fallthrough:
                report(last[0], f'text runs into {match.group(1)}', last[1])
            state = OUTSIDE
            fallthrough = False
            code = code[match.end():]  # a command may follow on the same line
        match = COMMAND.match(code)
        if not match:
            continue
        command, rest = match.groups()
        fallthrough = command == 'stop_compressing_text'
        if command in STRING_COMMANDS:
            state = after_string(rest)
        elif command == 'db' and state == OPEN:
            state = after_string(rest)
        elif command in INLINE_COMMANDS:
            state = BETWEEN
        elif command in ENDING_COMMANDS:
            state = OUTSIDE
        elif command == 'text_end':
            if state == OPEN:
                report(number, 'text_end ends only the string', line)
            state = OUTSIDE
        elif command == 'prompt':
            if state in {BETWEEN, CLOSED}:
                report(number, 'prompt here ends the text without waiting', line)
            state = OUTSIDE
        elif command == 'done':
            state = OUTSIDE
        else:
            continue
        last = (number, line)
    return problems


def main():
    args = [Path(arg).resolve() for arg in sys.argv[1:]] or [ROOT / p for p in DEFAULT_PATHS]
    paths = sorted(p for arg in args for p in (arg.rglob('*.asm') if arg.is_dir() else [arg]))
    problems = [problem for path in paths for problem in check_file(path)]
    for problem in problems:
        print(problem)
    print(f'{len(problems)} problem(s) in {len(paths)} file(s)', file=sys.stderr)
    sys.exit(1 if problems else 0)


if __name__ == '__main__':
    main()
