#!/usr/bin/env python3
"""Check the German name tables against Upstream's English.

Usage: python3 -I utils/check_names.py [--base REV] [--text [PATH ...]]

Each table in TABLES is paired by position with the same table in Upstream's
English, read with `git show` from the last merged Upstream commit
(`git merge-base HEAD upstream/master`, or --base REV).

Default run: checks the tables.
- An entry still equal to its English is reported, unless the name is the
  same in both languages (SAME_IN_GERMAN).
- An entry wider than its table's limit is reported, counted in tiles as
  check_text_width.py counts them ("#" is 4 tiles, "#mon" 7, ...).
- A table whose German and English entry counts differ is reported, and so
  is a table that can't be found: no entries, or a missing start or end label
  (as after an Upstream rename).

--text: lists English names left in string literals under the given paths
(default: maps/, data/, engine/ and home/). Comments and SECTION, INCLUDE
and INCBIN lines are skipped, and so is anything inside <...> tokens. Names
match as whole words, case-sensitively, longest first.

Exits with status 1 if anything is reported, and 2 if the English can't be
read from git.
"""

import argparse
import re
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from check_text_width import string_width, strip_comment  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
DEFAULT_PATHS = ('maps', 'data', 'engine', 'home')
UPSTREAM = 'upstream/master'

RAWCHAR = re.compile(r'^\s*rawchar "([^"]*)"')
LABEL_RAWCHAR = re.compile(r'^\w+:\s+rawchar "([^"]*)"')
LABEL_DB = re.compile(r'^\w+:\s+db "([^"]*)"')
LOCAL_DB = re.compile(r'^\.\w+:\s+db "([^"]*)"')

# path, entry pattern, first label (None: file start), label that ends the
# table (None: file end), limit in tiles, text category (None: tables only)
TABLES = [
    ('data/pokemon/names.asm', RAWCHAR, None, None, 10, 'mon'),
    ('data/types/names.asm', LABEL_DB, 'Normal', 'Monster', 8, None),  # types
    ('data/types/names.asm', LABEL_DB, 'Monster', None, 12, None),  # egg groups
    ('data/abilities/names.asm', LABEL_RAWCHAR, None, None, 16, None),
    ('data/natures.asm', LOCAL_DB, 'NatureNames', 'NatureIndicators', 7, None),
]

# official names that are the same in English and German, and placeholders
SAME_IN_GERMAN = {
    '?000?', '?256?', '???', '---',
    # Pokémon
    'Abra', 'Aerodactyl', 'Ampharos', 'Arbok', 'Ariados', 'Azumarill', 'Azurill',
    'Celebi', 'Ditto', 'Donphan', 'Dratini', 'Elekid', 'Entei', 'Farigiraf',
    'Gengar', 'Girafarig', 'Golbat', 'Granbull', 'Ho-Oh', 'Hoothoot', 'Hypno',
    'Kabuto', 'Kabutops', 'Kadabra', 'Kingler', 'Krabby', 'Lanturn', 'Lapras',
    'Larvitar', 'Ledian', 'Ledyba', 'Lugia', 'Magby', 'Magcargo', 'Magmar',
    'Magneton', 'Magnezone', 'Marill', 'Mew', 'Miltank', 'Natu', 'Nidoking',
    'Nidoqueen', 'Nidoran♀', 'Nidoran♂', 'Nidorina', 'Nidorino', 'Octillery',
    'Onix', 'Paras', 'Phanpy', 'Pichu', 'Pikachu', 'Pinsir', 'Porygon',
    'Porygon-Z', 'Porygon2', 'Pupitar', 'Raichu', 'Raikou', 'Remoraid',
    'Snubbull', 'Starmie', 'Suicune', 'Tangela', 'Tauros', 'Teddiursa',
    'Togekiss', 'Togepi', 'Togetic', 'Ursaluna', 'Ursaring', 'Vulpix', 'Xatu',
    'Yanma', 'Yanmega', 'Zapdos', 'Zubat',
    # types, egg groups
    'Normal', 'Monster', 'Mineral',
    # abilities
    'Chlorophyll', 'Download', 'Filter', 'Hydration', 'Insomnia',
    # natures
    'Mild',
}

# English spellings in text that differ from the tables, by category
TEXT_ALIASES = {
    'mon': {},
}

SKIP_LINE = re.compile(r'^\s*(SECTION|INCLUDE|INCBIN)\b')
STRING = re.compile(r'"([^"]*)"')
TOKEN = re.compile(r'<[^>]*>')
LABEL = re.compile(r'^\.?(\w+):')


class BaseError(Exception):
    pass


def git(*args):
    result = subprocess.run(['git', '-C', str(ROOT), *args], capture_output=True, text=True)
    if result.returncode:
        raise BaseError(f'git {" ".join(args)} failed: {result.stderr.strip()}')
    return result.stdout


def find_base(base):
    if base:
        return base
    try:
        return git('merge-base', 'HEAD', UPSTREAM).strip()
    except BaseError as error:
        raise BaseError(f"can't find the English base: {error}\n"
                        f'Fetch the {UPSTREAM} remote, or pass --base REV.') from None


def entries(text, pattern, first, stop):
    """Return (line number, name) for each entry of one table, @ stripped,
    and the labels of `first` and `stop` that were found."""
    found = []
    labels = set()
    inside = first is None
    for number, line in enumerate(text.splitlines(), 1):
        label = LABEL.match(line)
        if label and label.group(1) in (first, stop):
            labels.add(label.group(1))
        if label and label.group(1) == stop:
            break
        if label and label.group(1) == first:
            inside = True
        if not inside:
            continue
        match = pattern.match(line)
        if match:
            found.append((number, match.group(1).rstrip('@')))
    return found, labels


def check_tables(base):
    """Return (problems, {category: {English: German}})."""
    problems = []
    names = {}
    for path, pattern, first, stop, limit, category in TABLES:
        german, german_labels = entries((ROOT / path).read_text(encoding='utf-8'), pattern, first, stop)
        english, english_labels = entries(git('show', f'{base}:{path}'), pattern, first, stop)
        english = [name for _, name in english]
        missing = [label for label in (first, stop) if label and label not in german_labels & english_labels]
        if missing:
            problems += [f'{path}: label "{label}" not found' for label in missing]
            continue
        if not german or not english:
            problems.append(f'{path}: no entries found')
            continue
        if len(german) != len(english):
            problems.append(f'{path}: {len(german)} German entries, {len(english)} English')
            continue
        for (number, de), en in zip(german, english):
            tiles = string_width(de)
            if tiles > limit:
                problems.append(f'{path}:{number}: too long ({tiles} > {limit}): "{de}"')
            if de == en and en not in SAME_IN_GERMAN:
                problems.append(f'{path}:{number}: still English: "{de}"')
            elif category and de != en:
                names.setdefault(category, {})[en] = de
    for category, aliases in TEXT_ALIASES.items():
        names.setdefault(category, {}).update(aliases)
    return problems, names


def check_text(paths, names):
    mapping = {en: de for category in names.values() for en, de in category.items()}
    patterns = [(en, mapping[en], re.compile(r'(?<![A-Za-z_])' + re.escape(en) + r'(?![A-Za-z_])'))
                for en in sorted(mapping, key=len, reverse=True)]
    hits = []
    files = []
    for path in paths:
        path = ROOT / path
        files.extend(sorted(path.rglob('*.asm')) if path.is_dir() else [path])
    for file in files:
        for number, line in enumerate(file.read_text(encoding='utf-8').splitlines(), 1):
            if SKIP_LINE.match(line):
                continue
            for string in STRING.findall(strip_comment(line)):
                taken = {i for token in TOKEN.finditer(string) for i in range(*token.span())}
                for en, de, pattern in patterns:
                    for match in pattern.finditer(string):
                        span = set(range(*match.span()))
                        if span & taken:
                            continue
                        taken |= span
                        hits.append(f'{file.relative_to(ROOT)}:{number}: {en} -> {de}: "{string}"')
    return hits


def main():
    parser = argparse.ArgumentParser(description='Check the German name tables.')
    parser.add_argument('--base', help=f'English base revision (default: git merge-base HEAD {UPSTREAM})')
    parser.add_argument('--text', nargs='*', metavar='PATH',
                        help='list English names left in text under PATH (default: maps data engine home)')
    args = parser.parse_args()
    try:
        problems, names = check_tables(find_base(args.base))
    except BaseError as error:
        print(f'check_names.py: {error}', file=sys.stderr)
        return 2
    if args.text is not None:
        problems = [p for p in problems if ': still English: ' not in p and ': too long ' not in p]
        problems += check_text(args.text or DEFAULT_PATHS, names)
    for problem in problems:
        print(problem)
    return 1 if problems else 0


if __name__ == '__main__':
    sys.exit(main())
