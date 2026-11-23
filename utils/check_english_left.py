#!/usr/bin/env python3
"""Report lines still in Upstream's English, under the paths a chunk translated.

Usage: python3 -I utils/check_english_left.py [--base REV] PATH ...

A string line (text, line, cont, para, next, page, a Pokédex category) counts as English left when
its text equals a line of the same text in Upstream's English (the last merged Upstream commit,
--base, read with git), matched by file, label, build and order. Both builds are read: a Faithful
twin left in English inside `if DEF(FAITHFUL)` is found as well as a Regular one. `if DEF(DEBUG)`
blocks aren't in either build and are skipped. A line without letters ("…", "<PLAYER>!") and the
lines in SAME_IN_GERMAN pass. Prints `path:line: text` for each; exits 1 if there is any.
"""
import argparse
import re
import subprocess
import sys
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))  # python3 -I leaves the script's directory out

from asm_text import LABEL, ROOT, STRING_COMMANDS, assemble, iter_texts, parse_command, strip_comment  # noqa: E402
from kristall_lookup import git_tree  # noqa: E402

# lines that are the same in German, with the reason; the name chunks add names that stay
SAME_IN_GERMAN = {
    "OK": "the same word in German",
    "#mon": "Pokémon is Pokémon in German",
}


def same_in_german(line):
    plain = re.sub(r"<[^>]+>|#mon|#", "", line.rstrip("@"))
    return line.rstrip("@") in SAME_IN_GERMAN or not re.search(r"[A-Za-zÄÖÜäöüß]", plain)


def keyed(texts):
    """(path, label, variant, k) -> text, k counting texts with the same path, label and variant."""
    out, seen = {}, Counter()
    for t in texts:
        k = (t.path, t.label, t.variant)
        out[(*k, seen[k])] = t
        seen[k] += 1
    return out


def check(root, base, paths):
    root = Path(root)
    files, source = git_tree(base, root, paths)
    english = keyed(iter_texts(root, paths, source=source, files=files))
    found = set()
    for key, t in keyed(iter_texts(root, paths)).items():
        old = english.get(key)
        if old is None:
            continue
        lines_en = {c[1] for c in old.commands if c[0] in STRING_COMMANDS | {"category"}}
        lines = (root / t.path).read_text(encoding="utf-8").splitlines()
        dex = t.path.endswith("dex_entries.asm")
        for number, line in assemble(lines, {"FAITHFUL"} if t.variant == "faithful" else set()):
            if not t.start <= number <= t.end:
                continue
            code = strip_comment(line)
            if m := LABEL.match(code):
                code = "\t" + code[m.end():].strip()
            command = parse_command(code, dex)
            if command and command[0] in STRING_COMMANDS | {"category"} and command[1] in lines_en \
                    and not same_in_german(command[1]):
                found.add((t.path, number, command[1]))
    return [f"{path}:{number}: {text}" for path, number, text in sorted(found)]


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("paths", nargs="+", help="files or directories the chunk translated")
    ap.add_argument("--base", help="Upstream's English (default: git merge-base HEAD upstream/master)")
    a = ap.parse_args()
    base = a.base or subprocess.run(["git", "-C", str(ROOT), "merge-base", "HEAD", "upstream/master"],
                                    capture_output=True, text=True, check=True).stdout.strip()
    found = check(ROOT, base, a.paths)
    print("\n".join(found) or "PASS")
    return 1 if found else 0


if __name__ == "__main__":
    sys.exit(main())
