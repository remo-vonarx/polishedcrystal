#!/usr/bin/env python3
"""Show a Polished text next to Kristall's, as CLAUDE.md's review columns.

Usage:
    python3 -I utils/kristall_lookup.py maps/Route30.asm:194     # the text around that line
    python3 -I utils/kristall_lookup.py maps/Route30.asm         # every text in the file
    python3 -I utils/kristall_lookup.py Route30SignText          # a text by its label

For each text: its class (kristall_index.py: word, ambiguous, changed, new), then the hack's
English (Upstream's, from the last merged Upstream commit), Kristall's German and ours (the
tree's text where it isn't that English any more), each laid out as the lines appear in the box.
Prints to the terminal only: Kristall's text never goes into git.
"""
import argparse
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))  # python3 -I leaves the script's directory out

from asm_text import DEFAULT_PATHS, INLINE, ROOT, STRING_COMMANDS, iter_texts  # noqa: E402
from kristall_index import classify, is_stub, load_choices, load_renames, locate  # noqa: E402

WIDTH = 18  # TEXTBOX_INNERW
NEW = ["(none: new in the hack)"]


def box_lines(commands):
    """A text's lines as the box shows them; "" between boxes (para, page). A variable is shown
    as <its operand>; a "text" after the first goes on in the same line."""
    lines = []
    for c in commands:
        name = c[0]
        if name in STRING_COMMANDS:
            s = c[1].rstrip("@")
            if name in ("para", "page"):
                lines += ["", s]
            elif name == "text" and lines:
                lines[-1] += s
            else:
                lines.append(s)
        elif name in INLINE and name not in ("text_far", "text_farend") and len(c) > 1:
            operand = str(c[1]).split(",")[0].strip()
            if not lines:
                lines.append("")
            lines[-1] += f"<{operand}>"
        elif name in ("text_far", "text_farend"):
            lines.append(f"(text_far {c[1]})")
    return lines


def columns(en, de, ours):
    """CLAUDE.md's three review columns, each WIDTH wide, one row per box line."""
    rows = [f"{'ENGLISH':<{WIDTH}}| {'GERMAN ORIGINAL':<{WIDTH}} | OURS",
            f"{'-' * WIDTH}+{'-' * (WIDTH + 2)}+{'-' * WIDTH}"]
    for i in range(max(len(en), len(de), len(ours))):
        a, b, c = (col[i] if i < len(col) else "" for col in (en, de, ours))
        rows.append(f"{a:<{WIDTH}}| {b:<{WIDTH}} | {c}".rstrip())
    return "\n".join(rows)


def git_tree(base, root=ROOT, paths=DEFAULT_PATHS):
    """(asm files under paths, source) at commit `base`, read with one `git cat-file --batch`."""
    names = subprocess.run(["git", "-C", str(root), "ls-tree", "-r", "--name-only", base, "--", *paths],
                           capture_output=True, text=True, check=True).stdout.split()
    files = [n for n in names if n.endswith(".asm")]
    out = subprocess.run(["git", "-C", str(root), "cat-file", "--batch"], input="".join(f"{base}:{f}\n" for f in files).encode(),
                         capture_output=True, check=True).stdout
    contents, at = {}, 0
    for f in files:
        header_end = out.index(b"\n", at)
        size = int(out[at:header_end].split()[2])
        contents[f] = out[header_end + 1:header_end + 1 + size].decode("utf-8")
        at = header_end + 1 + size + 1
    attributes = subprocess.run(["git", "-C", str(root), "show", f"{base}:data/maps/attributes.asm"],
                                capture_output=True, text=True)
    if attributes.returncode == 0:  # locate() reads it to name the maps
        contents.setdefault("data/maps/attributes.asm", attributes.stdout)
    return files, lambda f: contents.get(f, "")  # a file the tree has and base hasn't: no texts


def select(texts, target):
    """The texts a `file[:line]` or label argument names."""
    path, _, line = target.partition(":")
    if path.endswith(".asm"):
        return [t for t in texts if t.path == path and (not line or t.start <= int(line) <= t.end)]
    return [t for t in texts if t.label == target]


def show(entry, ours_by_key):
    t = entry.text
    head = f"{t.path}:{t.start} {t.label}"
    if t.variant != "both":
        head += f" ({t.variant}{', partly Faithful' if t.partial_faithful else ''})"
    ours = ours_by_key.get((t.path, t.label, t.variant))
    ours = box_lines(ours) if ours and ours != t.commands else []
    en = box_lines(t.commands)
    if entry.cls == "word":
        print(f"{head}: word for word, pret {entry.pair['label']}")
        print(columns(en, box_lines(entry.pair["de"]), ours))
    elif entry.cls == "changed":
        print(f"{head}: changed, closest pret {entry.pair['label']} (score {entry.score:.2f})")
        print(columns(en, box_lines(entry.pair["de"]), ours))
    elif entry.cls == "ambiguous":
        print(f"{head}: ambiguous, {len(entry.candidates)} pret texts with this English and different German")
        for p in entry.candidates:
            print(f"pret {p['label']} at {p['where']}:")
            print(columns(en, box_lines(p["de"]), ours))
    else:
        print(f"{head}: new")
        print(columns(en, NEW, ours))
    print()


def main():
    from kristall_pairs import load_pairs
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("target", help="file[:line] or label")
    ap.add_argument("--base", help="Upstream's English (default: git merge-base HEAD upstream/master)")
    a = ap.parse_args()
    base = a.base or subprocess.run(["git", "-C", str(ROOT), "merge-base", "HEAD", "upstream/master"],
                                    capture_output=True, text=True, check=True).stdout.strip()
    files, source = git_tree(base)
    english = list(iter_texts(ROOT, source=source, files=files))
    chosen = select(english, a.target)
    if not chosen:
        print(f"no text at {a.target}", file=sys.stderr)
        return 1
    by_label = {}
    for t in english:
        by_label.setdefault(t.label, t)
    shown, wanted = [], []
    for t in chosen:  # a stub stands for its target; a text_far inside a text needs its target
        far = [by_label[c[1]] for c in t.commands if c[0] in ("text_far", "text_farend") and c[1] in by_label]
        shown += far if is_stub(t.commands) else [t]
        wanted += far + [t]
    ours_by_key = {(t.path, t.label, t.variant): t.commands for t in iter_texts(ROOT, files=sorted({t.path for t in wanted}))}
    entries = classify(wanted, load_pairs(), load_renames(), locate(ROOT, source), load_choices())
    for entry in entries:
        if entry.text in shown:
            show(entry, ours_by_key)
    return 0


if __name__ == "__main__":
    sys.exit(main())
