#!/usr/bin/env python3
"""Check the texts inherited from Kristall against the German they must have.

Usage: python3 -I utils/check_kristall.py [--base REV]

Upstream's English (the last merged Upstream commit, --base, read with git) is indexed against
pret's (kristall_index.py). For each word-for-word text, the German is derived as
kristall_write.py derives it and compared with the tree:
- the tree still has the English: counted (until chunk K writes them), not a failure;
- the tree has the derived German: fine;
- anything else fails: a hand edit of an inherited line, or a writer change since it was written.
A text that is no longer word for word at --base (Upstream changed its English) fails if the tree
still holds the German derived from its closest pret text: German left under changed English.
A text the writer can't derive (a flag: unknown capitals, ";", ...) whose tree text is no longer
English can't be checked; it's listed, not failed. Prints the failures and the counts; exits 1 on
a failure.
"""
import argparse
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))  # python3 -I leaves the script's directory out

from asm_text import ROOT, iter_texts  # noqa: E402
from kristall_index import Entry, classify, load_choices, load_renames, locate  # noqa: E402
from kristall_lookup import git_tree  # noqa: E402
from kristall_write import charmap_names, current_texts, german_for, load_case, name_map, ram_labels  # noqa: E402


def check(root, base, pairs, unchecked=None):
    """(failures, how many inherited texts are still English); texts that can't be derived and
    aren't English any more are appended to `unchecked` when given."""
    root = Path(root)
    files, source = git_tree(base, root)
    english = list(iter_texts(root, source=source, files=files))
    entries = classify(english, pairs, load_renames(root), locate(root, source), load_choices(root))
    names = name_map(root, pairs, base) if (root / "constants/pokemon_constants.asm").exists() else {}
    case = load_case(root / "utils" / "kristall_case.tsv")
    charmap = charmap_names(root if (root / "constants/charmap.asm").exists() else ROOT)
    ram = ram_labels(root if (root / "ram").exists() else ROOT)
    entries = [e for e in entries if e.cls in ("word", "changed")]
    now = current_texts(entries, root)
    failures, still_english = [], 0
    for e in entries:
        here = now[id(e)]
        where = f"{e.text.path}:{e.text.label}"
        if here is None or here.commands == e.text.commands:
            still_english += e.cls == "word" and here is not None
            continue
        if e.cls == "changed":
            derived = german_for(Entry(e.text, "word", e.pair, [e.pair], 1.0), names, case, charmap, ram)
            if derived.commands is not None and derived.commands == here.commands:
                failures.append(f"{where}: German of pret {e.pair['label']} under changed English")
            continue
        derived = german_for(e, names, case, charmap, ram)
        if derived.commands is None:
            if derived.flags and unchecked is not None:
                unchecked.append(f"{where}: {derived.flags[0].split(': ', 1)[-1]}")
        elif derived.commands != here.commands:
            failures.append(f"{where}: differs from the German derived from pret {e.pair['label']}")
    return failures, still_english


def main():
    from kristall_pairs import load_pairs
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("--base", help="Upstream's English (default: git merge-base HEAD upstream/master)")
    a = ap.parse_args()
    base = a.base or subprocess.run(["git", "-C", str(ROOT), "merge-base", "HEAD", "upstream/master"],
                                    capture_output=True, text=True, check=True).stdout.strip()
    unchecked = []
    failures, english = check(ROOT, base, load_pairs(), unchecked)
    for line in failures:
        print("FAIL " + line)
    for line in unchecked:
        print("unchecked " + line)
    print(f"{len(failures)} failures; {english} inherited texts still English; {len(unchecked)} unchecked")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
