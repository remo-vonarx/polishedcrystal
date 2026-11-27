#!/usr/bin/env python3
"""Check that every text keeps the commands of Upstream's English.

Usage: python3 -I utils/check_commands.py [--base REV]

Each text in the tree is matched with the same text in Upstream's English (the last merged Upstream
commit, --base, read with git) by file, label, build and position. Line commands (text, line, cont,
para, next, page) may change with the German; every other command must stay: the same pauses,
sounds, buffers, numbers, prompts and code, as many times as in the English, in any order (German
word order may swap two buffers). A text whose commands differ on purpose is listed in
utils/command_changes.tsv with a key of its English and the reason; it is skipped as long as
Upstream's English has that key, and fails when the English has changed since. Prints the
failures and the count compared; exits 1 on a failure.
"""
import argparse
import collections
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))  # python3 -I leaves the script's directory out

from asm_text import ROOT, STRING_COMMANDS, iter_texts  # noqa: E402
from check_kristall import english_key  # noqa: E402
from kristall_lookup import git_tree  # noqa: E402

TABLE = "utils/command_changes.tsv"
NOT_COMMANDS = set(STRING_COMMANDS) | {"category"}  # a Pokédex category is a string


def commands(text):
    """The text's commands other than line commands, counted."""
    return collections.Counter(tuple(str(x) for x in c) for c in text.commands if c[0] not in NOT_COMMANDS)


def load_changes(root):
    """The (label, English key) pairs of utils/command_changes.tsv."""
    path = Path(root) / TABLE
    if not path.exists():
        return set()
    rows = (line.split("\t") for line in path.read_text().splitlines() if line and not line.startswith("#"))
    return {(row[0], row[1]) for row in rows}


def show(counter):
    return ", ".join(" ".join(c) for c in sorted(counter.elements()))


def check(root, base):
    """(failures, how many texts were compared with their English)."""
    root = Path(root)
    files, source = git_tree(base, root)
    english = {(t.path, t.label, t.variant, t.index): t for t in iter_texts(root, source=source, files=files)}
    listed = load_changes(root)
    keys = {(t.label, english_key(t.commands)) for t in english.values()}
    failures = [f"{label}: English changed since its commands were listed ({TABLE})"
                for label, _ in sorted(listed - keys)]
    compared = 0
    for text in iter_texts(root):
        en = english.get((text.path, text.label, text.variant, text.index))
        if en is None:
            continue
        compared += 1
        want, have = commands(en), commands(text)
        if want == have or (text.label, english_key(en.commands)) in listed:
            continue
        lost, gained = want - have, have - want
        failures.append(f"{text.path}:{text.start} {text.label}: "
                        + "; ".join(part for part in (lost and "lost " + show(lost), gained and "gained " + show(gained)) if part))
    return failures, compared


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("--base", help="Upstream's English (default: git merge-base HEAD upstream/master)")
    a = ap.parse_args()
    base = a.base or subprocess.run(["git", "-C", str(ROOT), "merge-base", "HEAD", "upstream/master"],
                                    capture_output=True, text=True, check=True).stdout.strip()
    failures, compared = check(ROOT, base)
    for line in failures:
        print("FAIL " + line)
    print(f"{len(failures)} failures in {compared} texts compared with Upstream's English")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
