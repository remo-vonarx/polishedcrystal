#!/usr/bin/env python3
"""Check the Bag's and the TM pocket's A-Z orders against the German names.

Usage: python3 -I utils/check_order.py [REPO]

The Bag's "sort by name" reads data/items/name_order.asm: entry k of
ItemNameOrder (KeyItemNameOrder) is item (key item) k's rank, a NAM_ constant
from the "Alphabetical order" lists in constants/item_constants.asm. The TM
pocket's A-Z order is TMHMListAlpha in data/moves/tmhm_order.asm. Checked in
the normal and the Faithful variant (`if DEF(FAITHFUL)` blocks):

- entry k of each name_order.asm table names item k's own constant (NAM_ + its
  name), so a rank list can be sorted by constant name;
- each rank list holds every item exactly once (items: NAM_NO_ITEM first), in
  German dictionary order (DIN 5007-1: case-insensitive, Ä/Ö/Ü as A/O/U, é as e)
  of the names in data/items/names.asm and key_names.asm;
- TMHMListAlpha holds every TM/HM once, in that order of its move's name.

Only the tables whose names are German are checked: those in check_names.py's
GERMAN_TABLES ("items", "key items", "moves" for the TM order). Upstream's English
orders aren't DIN 5007, and Upstream's KeyItemNameOrder lists NAM_HARSH_LURE,
NAM_POTENT_LURE and NAM_MALIGN_LURE before NAM_LIFT_KEY, against the constants'
order (LIFT_KEY is 20): a bug in Upstream that the key items' chunk fixes when it
re-sorts the list.

Run it after any Upstream merge that touches items, key items or TMs: a new or
moved item makes it fail until the rank lists are re-sorted.
"""
import re
import sys
from pathlib import Path

FOLD = str.maketrans({'ä': 'a', 'ö': 'o', 'ü': 'u', 'é': 'e'})


def din5007(name):
    """German dictionary order: case-insensitive, umlauts and é as their base letter."""
    return (name.casefold().translate(FOLD), name)


def evaluate(lines, faithful):
    """The lines a variant assembles (only FAITHFUL conditions occur here)."""
    out, stack = [], []
    for line in lines:
        s = line.strip()
        if s in ('if DEF(FAITHFUL)', 'if !DEF(FAITHFUL)'):
            stack.append(faithful if s == 'if DEF(FAITHFUL)' else not faithful)
        elif s == 'else' and stack:
            stack[-1] = not stack[-1]
        elif s == 'endc' and stack:
            stack.pop()
        elif s.startswith('if '):
            raise ValueError(f'unexpected condition: {s}')
        elif all(stack):
            out.append(line)
    return out


def found(pattern, lines):
    return re.findall(pattern, '\n'.join(lines), re.M)


def between(lines, start, end):
    """Lines after the first one matching start, up to the next one matching end."""
    i = next(k for k, l in enumerate(lines) if re.match(start, l))
    j = next(k for k in range(i + 1, len(lines)) if re.match(end, lines[k]))
    return lines[i + 1:j]


def read(repo, rel):
    return (repo / rel).read_text(encoding='utf-8').split('\n')


def check(repo, german):
    """Problems in the A-Z orders of the tables named in `german` (check_names.GERMAN_TABLES keys)."""
    problems = []
    consts = read(repo, 'constants/item_constants.asm')
    order = read(repo, 'data/items/name_order.asm')
    item_ids = ['NO_ITEM'] + found(r'^\s*const (\w+)', between(consts, r'\s*const NO_ITEM\b', r'DEF NUM_ITEMS\b'))
    # the key items are the const_def 1 block that ends at NUM_KEY_ITEMS
    num_keys = next(j for j, m in enumerate(consts) if m.startswith('DEF NUM_KEY_ITEMS'))
    key_start = max(k for k in range(num_keys) if consts[k].strip() == 'const_def 1')
    key_ids = found(r'^\s*const (\w+)', consts[key_start + 1:num_keys])
    item_order = found(r'^\s*db (NAM_\w+)', between(order, r'ItemNameOrder:', r'KeyItemNameOrder:'))
    key_order = found(r'^\s*db (NAM_\w+)', between(order + ['KeyItemNameOrder_end:'], r'KeyItemNameOrder:', r'\w+_end:'))
    for label, ids, table, key in (('ItemNameOrder', item_ids, item_order, 'items'),
                                   ('KeyItemNameOrder', key_ids, key_order, 'key items')):
        if key not in german:
            continue
        want = ['NAM_' + c for c in ids]
        if len(table) != len(want):
            problems.append(f'{label}: {len(table)} entries for {len(want)} items')
        for k, (got, exp) in enumerate(zip(table, want)):
            if got != exp:
                problems.append(f'{label} entry {k} (item {ids[k]}) is {got}, not {exp}')

    blocks = []
    for k, l in enumerate(consts):
        if l.startswith('; Alphabetical order'):
            e = next(j for j in range(k, len(consts)) if consts[j].strip().startswith('assert const_value'))
            blocks.append(consts[k + 2:e])
    assert len(blocks) == 2, 'expected two "; Alphabetical order" lists'

    moves_consts = found(r'^\s*const (\w+)', read(repo, 'constants/move_constants.asm'))
    tm_lines = read(repo, 'constants/tmhm_constants.asm')
    tm_text = re.sub(r'^MACRO .*?^ENDM$', '', '\n'.join(tm_lines), flags=re.M | re.S).split('\n')
    tm_order = between(read(repo, 'data/moves/tmhm_order.asm'), r'TMHMListAlpha:', r'\s*assert_table_length')
    tm_move_ids = found(r'^\s*db (\w+)', read(repo, 'data/moves/tmhm_moves.asm'))

    for faithful in (False, True):
        variant = 'Faithful' if faithful else 'normal'
        names = found(r'^\s*li "([^"]*)"', evaluate(read(repo, 'data/items/names.asm'), faithful))
        keys = found(r'^\s*li "([^"]*)"', evaluate(read(repo, 'data/items/key_names.asm'), faithful))[1:]  # "Cancel"
        tables = (('items', blocks[0], dict(zip(item_order, names)), 'NAM_NO_ITEM'),
                  ('key items', blocks[1], dict(zip(key_order, keys)), None))
        for label, block, table, first in tables:
            if label not in german:
                continue
            got = found(r'^\s*const (NAM_\w+)', evaluate(block, faithful))
            if first:
                if not got or got[0] != first:
                    problems.append(f'{variant} {label}: {first} is not first')
                got = [g for g in got if g != first]
            want = set(table) - {first}
            if sorted(got) != sorted(want):
                dup = sorted({g for g in got if got.count(g) > 1})
                problems.append(f'{variant} {label}: missing {sorted(want - set(got))}, '
                                f'extra {sorted(set(got) - want)}, doubled {dup}')
                continue
            ranked = [table[g] for g in got]
            for a, b in zip(ranked, ranked[1:]):
                if din5007(a) > din5007(b):
                    problems.append(f'{variant} {label}: "{a}" before "{b}"')
                    break

        if 'moves' not in german:
            continue
        move_names = dict(zip(moves_consts[1:], found(r'^\s*li "([^"]*)"',
                                                     evaluate(read(repo, 'data/moves/names.asm'), faithful))))
        slots = [f'{m.group(1).upper()}_{m.group(2)}' for l in evaluate(tm_text, faithful)
                 for m in [re.match(r'^\s*add_(tm|hm) (\w+)', l)] if m]
        tms = dict(zip(slots, tm_move_ids))
        if not faithful:  # TM_BRICK_BREAK is an alias of TM_ROCK_SMASH's slot outside Faithful
            tms['TM_BRICK_BREAK'] = tms['TM_ROCK_SMASH']
        got = found(r'^\s*db ((?:TM|HM)_\w+)', evaluate(tm_order, faithful))
        canon = ['TM_ROCK_SMASH' if (g == 'TM_BRICK_BREAK' and not faithful) else g for g in got]
        if sorted(canon) != sorted(slots):
            problems.append(f'{variant} TMs: missing {sorted(set(slots) - set(canon))}, '
                            f'extra {sorted(set(canon) - set(slots))}')
            continue
        ranked = [move_names[tms[g]] for g in got]
        for a, b in zip(ranked, ranked[1:]):
            if din5007(a) > din5007(b):
                problems.append(f'{variant} TMs: "{a}" before "{b}"')
                break
    return problems


def main():
    sys.path.insert(0, str(Path(__file__).resolve().parent))  # python3 -I leaves the script's directory out
    from check_names import GERMAN_TABLES
    repo = Path(sys.argv[1] if len(sys.argv) > 1 else Path(__file__).resolve().parent.parent)
    problems = check(repo, GERMAN_TABLES)
    print('\n'.join(problems) or 'PASS')
    return 1 if problems else 0


if __name__ == '__main__':
    sys.exit(main())
