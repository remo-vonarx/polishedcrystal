#!/usr/bin/env python3
"""Write Kristall's German as ours, for each Polished text that is pret's English word for word.

Usage:
    python3 -I utils/kristall_write.py [PATH ...]           # dry run: what it would change, and flags
    python3 -I utils/kristall_write.py --write [PATH ...]   # change the texts in place

For each word-for-word text (kristall_index.py), Kristall's German (kristall_pairs.py):
1. is rebuilt in Kristall's order with Polished's variables and box ending (rebuild);
2. has each run of capitals re-cased: Kristall's name -> ours (name_map, from the translated
   name tables), else utils/kristall_case.tsv; a run in neither is reported, never guessed (recase);
3. is checked against Polished's charmap;
4. has a paragraph re-broken where a longer name pushed a line past the box (fit).
Anything it can't do is a flag, and the text is left alone: an ambiguous text (answered in
utils/kristall_choices.tsv), a text partly inside `if DEF(FAITHFUL)`, unknown capitals, a
character Polished can't print, a variable it can't map, a paragraph it can't fit, code inside
the text's lines. The label, the code around and `if DEF(FAITHFUL)` blocks stay as they are.

The hack's English is read from Upstream's last merged commit, so a rerun derives the same German
and changes nothing (idempotent); check_kristall.py runs the same derivation as a check.
"""
import argparse
import re
import subprocess
import sys
from collections import Counter, defaultdict, namedtuple
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))  # python3 -I leaves the script's directory out

from asm_text import ENDS, LABEL, ROOT, STRING_COMMANDS, parse_file, render, strip_comment  # noqa: E402
from check_text_width import FILE_WIDTHS, TOKEN, string_width  # noqa: E402
from kristall_index import git_source, polished_names  # noqa: E402

CASE = ROOT / "utils" / "kristall_case.tsv"
WIDTH = 18  # TEXTBOX_INNERW
DEX_LINES = 3  # lines per Pokédex page
Result = namedtuple("Result", "commands flags")
Report = namedtuple("Report", "changed flags")

# pret's spelling of a token -> Polished's (constants/charmap.asm of each)
TOKEN_MAP = {"<PLAY_G>": "<PLAYER>", "<……>": "……"}
VARIABLES = {"text_ram", "text_decimal", "text_bcd", "text_plural", "text_today"}
LINE_STARTS = {"text", "line", "cont", "next", "next1"}
LETTERS = "A-Za-zÄÖÜäöüÉéß"
CAPITALS = "A-ZÄÖÜÉ"
WORD = re.compile(f"[#{LETTERS}0-9]+(?:[-.'][#{LETTERS}0-9]+)*\\.?")


def charmap_names(root=ROOT):
    text = (Path(root) / "constants" / "charmap.asm").read_text(encoding="utf-8")
    return set(re.findall(r'^\s*charmap\s+"((?:[^"\\]|\\.)*)"', text, re.M))


def ram_labels(root=ROOT):
    out = set()
    for path in (Path(root) / "ram").glob("*.asm"):
        out |= set(re.findall(r"^(w\w+)::?", path.read_text(encoding="utf-8"), re.M))
    return out


# -- names and case ---------------------------------------------------------------------------

def load_case(path=CASE):
    """Kristall's spelling -> ours, from kristall_case.tsv (words, not sentences)."""
    out = {}
    path = Path(path)
    if path.exists():
        for line in path.read_text(encoding="utf-8").splitlines():
            if line and not line.startswith("#"):
                kristall, ours, *_ = line.split("\t")
                out[kristall] = ours
    return out


def name_map(root, pairs, base):
    """Kristall's name -> ours, for each table entry whose Polished name is no longer Upstream's
    English (a name chunk translated it). A Kristall name that maps to two of ours is left out."""
    constant_pairs = {}
    renames = Path(root) / "utils" / "english_renames.tsv"
    if renames.exists():
        for line in renames.read_text(encoding="utf-8").splitlines():
            if m := re.search(r"constant (\w+) is (\w+)", line):
                constant_pairs[m.group(1)] = m.group(2)
    now = polished_names(lambda rel: (Path(root) / rel).read_text(encoding="utf-8"))
    then = polished_names(git_source(base, root))
    found = defaultdict(set)
    for table, entries in pairs["names"].items():
        tables = [table] + (["key items"] if table == "items" else [])
        for const, (_, german) in entries.items():
            ours_const = constant_pairs.get(const, const)
            for t in tables:
                ours, english = now.get(t, {}).get(ours_const), then.get(t, {}).get(ours_const)
                if ours is not None and ours != english:
                    found[german.replace("<BSP>", " ")].add(ours.replace("¯", " "))
    return {k: next(iter(v)) for k, v in found.items() if len(v) == 1}


def is_capital_run(word):
    return len(re.findall(f"[{CAPITALS}]", word)) >= 2


def look_up(key, names, case):
    for k in (key, key[:-1] if key.endswith(".") else None):
        if k and k in names:
            return names[k] + key[len(k):]
        if k and k in case:
            return case[k] + key[len(k):]
    return None


def recase_string(s, names, case, unknown):
    """One string with its capital runs re-cased; consecutive capital words (one space apart)
    are looked up together first ("PROF. LINDs")."""
    tokens = [m.span() for m in re.finditer(r"<[^>]+>", s)]  # <PLAYER>, <USER>: not words
    words = [w for w in WORD.finditer(s) if not any(a <= w.start() < b for a, b in tokens)]
    out, at, i = [], 0, 0
    while i < len(words):
        if not is_capital_run(words[i].group()):
            i += 1
            continue
        j = i
        while j + 1 < len(words) and is_capital_run(words[j + 1].group()) and \
                s[words[j].end():words[j + 1].start()] == " ":
            j += 1
        for k in range(j, i - 1, -1):  # longest first
            key = s[words[i].start():words[k].end()]
            new = look_up(key, names, case)
            if new is not None:
                out.append(s[at:words[i].start()] + new)
                at, i = words[k].end(), k + 1
                break
        else:
            unknown.append(words[i].group().rstrip("."))
            i += 1
    return "".join(out) + s[at:]


def recase(commands, names, case):
    """Commands with each run of capitals re-cased, and the runs found in neither names nor
    case. A word split by "-" at a line end ("ARENA-" / "LEITER") is looked up joined, with the
    hyphen first, and split again where it was."""
    out, unknown = [list(c) for c in commands], []
    done_head, done_tail = {}, {}  # command index -> where its split part starts / ends (already re-cased)
    strings = [i for i, c in enumerate(out) if c[0] in STRING_COMMANDS | {"category"}]
    for a, b in zip(strings, strings[1:]):
        first, second = out[a][1], out[b][1]
        if not first.endswith("-") or out[b][0] in ("para", "page"):
            continue
        head = re.search(f"[#{LETTERS}0-9]+-$", first)
        tail = re.match(f"[#{LETTERS}0-9]+", second)
        if not head or not tail or not is_capital_run(head.group() + tail.group()):
            continue
        left, right = head.group()[:-1], tail.group()
        for key, hyphen in ((f"{left}-{right}", True), (left + right, False)):
            new = names.get(key, case.get(key))
            if new is None:
                continue
            cut = len(left) + (1 if hyphen else 0)
            if len(new) == len(key):  # split where Kristall split it
                part1, part2 = new[:cut] if hyphen else new[:cut] + "-", new[cut:]
            else:  # a name of another length: whole on the first line, fit re-breaks
                part1, part2 = new, ""
            out[a][1] = first[:head.start()] + part1
            out[b][1] = part2 + second[tail.end():]
            done_head[a], done_tail[b] = head.start(), len(part2)
            break
    for i in strings:
        text = out[i][1]
        start, end = done_tail.get(i, 0), done_head.get(i, len(text))
        out[i][1] = text[:start] + recase_string(text[start:end], names, case, unknown) + text[end:]
    return [tuple(c) for c in out], unknown


# -- structure --------------------------------------------------------------------------------

def variable_key(c):
    return (c[0], *[str(x) for x in c[1:]])


def rebuild(polished_en, pret_en, kristall_de, ram=None):
    """Kristall's German in Kristall's order, with Polished's variables and box ending: each pret
    variable maps to Polished's at the same position in the two English texts; a Kristall variable
    pret's English lacks keeps its pret RAM name if Polished's ram/ defines it. Returns
    (commands, flags)."""
    ram = ram_labels() if ram is None else ram
    flags = []
    ours_vars = [c for c in polished_en if c[0] in VARIABLES]
    pret_vars = [c for c in pret_en if c[0] in VARIABLES]
    if len(ours_vars) != len(pret_vars):
        return None, [f"variables differ: pret {len(pret_vars)}, Polished {len(ours_vars)}"]
    mapping = {variable_key(p): o for p, o in zip(pret_vars, ours_vars)}
    out = []
    for c in kristall_de:
        if c[0] in ENDS:
            continue
        if c[0] in ("text_far", "text_farend"):
            flags.append(f"Kristall's text goes on in another (text_far {c[1]})")
        elif c[0] in VARIABLES:
            if variable_key(c) in mapping:
                out.append(tuple(mapping[variable_key(c)]))
            elif str(c[1]).split(",")[0].strip() in ram:
                out.append(tuple(c))
            else:
                flags.append(f"Kristall variable {c[1]} has no Polished form")
        elif c[0] in STRING_COMMANDS or c[0] == "category":
            s = c[1]
            for old, new in TOKEN_MAP.items():
                s = s.replace(old, new)
            out.append((c[0], s))
        else:
            out.append(tuple(c))
    last = polished_en[-1] if polished_en else None
    if last and last[0] in ENDS:
        out.append(tuple(last))
    elif last and last[0] in STRING_COMMANDS and last[1].endswith("@"):
        strings = [i for i, c in enumerate(out) if c[0] in STRING_COMMANDS]
        if strings and not out[strings[-1]][1].endswith("@"):
            i = strings[-1]
            out[i] = (out[i][0], out[i][1] + "@")
    return out, flags


# -- fitting ----------------------------------------------------------------------------------

def paragraphs(commands):
    """[(start, end)] index ranges of the paragraphs: from a box's first string to before the
    next para/page or ending."""
    out, start = [], None
    for i, c in enumerate(commands):
        if c[0] in ("para", "page") or c[0] in ENDS:
            if start is not None:
                out.append((start, i))
            start = i if c[0] in ("para", "page") else None
        elif start is None and (c[0] in STRING_COMMANDS or c[0] in VARIABLES):
            start = i
    if start is not None:
        out.append((start, len(commands)))
    return out


def line_widths(cmds):
    widths = []
    for c in cmds:
        if c[0] in STRING_COMMANDS:
            if c[0] == "text" and widths:
                widths[-1] += string_width(c[1])
            else:
                widths.append(string_width(c[1]))
    return widths


def fit(commands, width=WIDTH):
    """Commands with each paragraph that has a line wider than `width` re-broken greedily, its
    para/page boundary and the ending kept; None when such a paragraph holds a variable (its width
    isn't known), has a word wider than `width`, or, in a Pokédex entry, takes over 3 lines."""
    out, done = [], 0
    dex = any(c[0] == "category" for c in commands)
    for start, end in paragraphs(commands):
        out += commands[done:start]
        para = commands[start:end]
        done = end
        if all(w <= width for w in line_widths(para)) and not (dex and len(line_widths(para)) > DEX_LINES):
            out += para
            continue
        if any(c[0] not in STRING_COMMANDS for c in para):
            return None
        joined = ""
        for c in para:
            s = c[1]
            if not joined:
                joined = s
            elif joined.endswith("-") and s[:1].islower():
                joined = joined[:-1] + s
            elif joined.endswith("-"):
                joined += s
            else:
                joined += " " + s
        at_sign = joined.endswith("@")
        lines = []
        for word in joined.rstrip("@").split():
            if string_width(word) > width:
                return None
            if lines and string_width(lines[-1] + " " + word) <= width:
                lines[-1] += " " + word
            else:
                lines.append(word)
        if dex and len(lines) > DEX_LINES:
            return None
        if at_sign:
            lines[-1] += "@"
        following = "next" if any(c[0] == "next" for c in para) or dex else None
        for k, line in enumerate(lines):
            name = para[0][0] if k == 0 else following or ("line" if k == 1 else "cont")
            out.append((name, line))
    out += commands[done:]
    return out


# -- one text, and the tree -------------------------------------------------------------------

def unmapped(commands, names_ok):
    bad = []
    for c in commands:
        if c[0] in STRING_COMMANDS or c[0] == "category":
            bad += [t for t in TOKEN.findall(c[1].rstrip("@")) if t not in names_ok]
    return sorted(set(bad))


def german_for(entry, names, case, charmap=None, ram=None):
    """Our German for one indexed text, or None and why."""
    t = entry.text
    where = f"{t.path}:{t.label}"
    if entry.cls != "word":
        alts = ", ".join(p["label"] for p in entry.candidates) if entry.cls == "ambiguous" else ""
        return Result(None, [f"{where}: {entry.cls}" + (f" ({alts})" if alts else "")])
    if t.partial_faithful:
        return Result(None, [f"{where}: partly inside if DEF(FAITHFUL)"])
    far = {"text_far", "text_farend"}
    if any(c[0] in far for c in t.commands):
        if all(c[0] in far | {"text_asm", "text_end"} for c in t.commands):
            return Result(None, [])  # its words are its target's, written as a text of its own
        return Result(None, [f"{where}: mixes its own text with text_far"])
    commands, flags = rebuild(t.commands, entry.pair["en"], entry.pair["de"], ram)
    if flags:
        return Result(None, [f"{where}: {f}" for f in flags])
    commands, unknown = recase(commands, names, case)
    if unknown:
        return Result(None, [f"{where}: unknown capitals {' '.join(sorted(set(unknown)))}"])
    bad = unmapped(commands, charmap_names() if charmap is None else charmap)
    if bad:
        return Result(None, [f"{where}: no glyph in Polished's charmap for {' '.join(bad)}"])
    width = next((w for suffix, w in FILE_WIDTHS.items() if t.path.endswith(suffix)), WIDTH)
    fitted = fit(commands, width)
    if fitted is None:
        return Result(None, [f"{where}: doesn't fit {width} tiles"])
    return Result(fitted, [])


ALLOWED = re.compile(r"^\s*(?:" + "|".join(sorted(STRING_COMMANDS | ENDS | VARIABLES | {
    "text_start", "text_promptbutton", "text_pause", "text_sound", "text_far", "text_farend", "db"})) + r")\b")


def current_texts(entries, root=ROOT):
    """Each entry's text as the tree at `root` has it now (an AsmText, or None), found by file,
    label, variant and index: lines move as texts turn German."""
    root = Path(root)
    out, by_path = {}, defaultdict(list)
    for e in entries:
        by_path[e.text.path].append(e)
    for path, group in by_path.items():
        current = {}
        if (root / path).exists():
            current = {(t.label, t.variant, t.index): t for t in parse_file(path, root)}
        for e in group:
            out[id(e)] = current.get((e.text.label, e.text.variant, e.text.index))
    return out


def write(entries, names, case, dry_run=True, root=ROOT):
    """Write each word-for-word entry's German over its text in the tree at `root`, found there by
    file, label and variant (lines may have moved since Upstream's English). Changed and new texts
    aren't the writer's: they're skipped without a flag."""
    root = Path(root)
    charmap = charmap_names(root if (root / "constants/charmap.asm").exists() else ROOT)
    ram = ram_labels(root if (root / "ram").exists() else ROOT)
    changed, flags = [], []
    by_path = defaultdict(list)
    for e in entries:
        if e.cls in ("word", "ambiguous"):
            by_path[e.text.path].append(e)
    now = current_texts([e for group in by_path.values() for e in group], root)
    for path in sorted(by_path):
        lines = (root / path).read_text(encoding="utf-8").split("\n")
        edits = []
        for e in sorted(by_path[path], key=lambda e: e.text.start):
            result = german_for(e, names, case, charmap, ram)
            if result.commands is None:
                flags += result.flags
                continue
            here = now[id(e)]
            if here is None:
                flags.append(f"{path}:{e.text.label}: not found in the tree")
                continue
            old = lines[here.start - 1:here.end]
            extra = [line.strip() for line in old[1:] if line.strip() and not ALLOWED.match(line)]
            if extra or any(strip_comment(line) != line for line in old):
                why = extra[0] if extra else "a comment"
                flags.append(f"{path}:{e.text.label}: not written, its lines hold {why}")
                continue
            new = render(result.commands)
            if any(not line.strip() for line in old):  # Polished's style: a blank line before para
                new = [x for line in new for x in ([""] if line.startswith("\tpara ") else []) + [line]]
            if m := LABEL.match(old[0]):  # a label on the text's first line stays, with its gap
                rest = old[0][m.end():]
                new[0] = m.group(0) + rest[:len(rest) - len(rest.lstrip())] + new[0].lstrip("\t")
            if new != old:
                changed.append(f"{path}:{e.text.label}")
                edits.append((here.start, here.end, new))
        if edits and not dry_run:
            for start, end, new in sorted(edits, reverse=True):
                lines[start - 1:end] = new
            (root / path).write_text("\n".join(lines), encoding="utf-8")
    return Report(changed, flags)


def main():
    from asm_text import iter_texts
    from kristall_index import classify, load_choices, load_renames, locate
    from kristall_lookup import git_tree
    from kristall_pairs import load_pairs
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("paths", nargs="*", help="files or directories to limit it to")
    ap.add_argument("--write", action="store_true", help="change the tree (default: dry run)")
    ap.add_argument("--base", help="Upstream's English (default: git merge-base HEAD upstream/master)")
    a = ap.parse_args()
    base = a.base or subprocess.run(["git", "-C", str(ROOT), "merge-base", "HEAD", "upstream/master"],
                                    capture_output=True, text=True, check=True).stdout.strip()
    files, source = git_tree(base)
    english = list(iter_texts(ROOT, source=source, files=files))
    pairs = load_pairs()
    entries = classify(english, pairs, load_renames(), locate(ROOT, source), load_choices())
    if a.paths:
        entries = [e for e in entries if any(e.text.path == p or e.text.path.startswith(p.rstrip("/") + "/")
                                             for p in a.paths)]
    report = write(entries, name_map(ROOT, pairs, base), load_case(), dry_run=not a.write)
    for line in report.changed:
        print(("wrote " if a.write else "would write ") + line)
    for line in report.flags:
        print("flag: " + line)
    kinds = Counter(re.sub(r"^[^:]+:[^:]+: ", "", f).split(" (")[0].split(" ")[0] for f in report.flags)
    print(f"{len(report.changed)} {'written' if a.write else 'to write'}, {len(report.flags)} flags: "
          + ", ".join(f"{k} {n}" for k, n in kinds.most_common()))
    return 0


if __name__ == "__main__":
    sys.exit(main())
