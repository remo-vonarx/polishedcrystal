#!/usr/bin/env python3
"""Sort Polished's texts against pret's: word for word, ambiguous, changed or new.

Usage:
    python3 -I utils/kristall_index.py --stats      # how many texts of each class
    python3 -I utils/kristall_index.py --renames    # regenerate the table part of english_renames.tsv

Each Polished text (asm_text.AsmText) is compared with pret's English from the pairs file
(kristall_pairs.py) in a normalized form: case, line breaks and box endings don't count, and
Polished's English renames ("Bell Tower" for TIN TOWER) count as equal.

- word: equal to one pret text, or to several whose German is the same; where several differ,
  the one at the same map and event (`locate`) decides, then the one with the same label, then
  utils/kristall_choices.tsv.
- ambiguous: equal to several pret texts with different German, nothing decides.
- changed: the closest pret text: same map and event, then same label, else the most similar
  English above THRESHOLD.
- new: nothing close enough.
A Polished text that is only a text_far stub isn't sorted: its target is.
"""
import argparse
import difflib
import re
import subprocess
import sys
from collections import Counter, defaultdict, namedtuple
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))  # python3 -I leaves the script's directory out

from asm_text import ROOT, STRING_COMMANDS, assemble, iter_texts, strip_comment  # noqa: E402

RENAMES = ROOT / "utils" / "english_renames.tsv"
CHOICES = ROOT / "utils" / "kristall_choices.tsv"
# Below this similarity of normalized English (difflib's ratio), a text counts as new rather than
# changed. Measured 2026-11-23 on the ~4,700 Polished texts that aren't word for word: below 0.7
# the best pret match is mostly an unrelated text sharing stock phrases ("which one of your
# pokémon wants tea?" / "which side do you want to put away?" 0.62); from 0.7 up mostly the same
# text edited (Drowzee's dream 0.70, Bea's line 0.71), with a few short look-alikes left
# ("poisons foes when they switch in." / "hurts foes when they switch out." 0.77) that the review
# of changed texts sorts out.
THRESHOLD = 0.7

Entry = namedtuple("Entry", "text cls pair candidates score")

VARIABLES = {"text_ram", "text_decimal", "text_bcd", "text_today", "text_plural", "text_move", "text_buffer"}
LETTER = "A-Za-zÄÖÜäöüéß"


# -- normalized English -----------------------------------------------------------------------

def normalize(commands, renames):
    """A text's words for comparing: lower case, line breaks as spaces, a hyphen between letters
    dropped (so "bat-" / "tle" and "dark-type" compare as one word), variables as <var>, "#mon"
    as pokémon, "#" as poké. Typography doesn't count: pret's <……> glyph is "……", curly quotes
    are "'", "1,500" is "1500", and spaces next to a variable or between "……" go. The box ending
    doesn't count. Renames (pret -> Polished) apply first, in one pass, to whole words written
    as pret writes the name (in capitals), so "BERRY" is renamed and "berry" isn't."""
    out = ""
    for c in commands:
        if c[0] in STRING_COMMANDS:
            s = c[1].rstrip("@")
            if out.endswith("-") and s[:1].isalpha():
                out = out + s
            else:
                out = f"{out} {s}" if out else s
        elif c[0] in VARIABLES:
            out += "<var>"
        elif c[0] in ("text_far", "text_farend"):
            out += " <far> "
    s = re.sub(r"\s+", " ", out.replace("<BSP>", " ").replace("¯", " ")).strip()
    if renames:
        table = dict(renames)
        names = "|".join(re.escape(old) for old in sorted(table, key=len, reverse=True))
        s = re.sub(f"(?<![{LETTER}])(?:{names})(?![{LETTER}])", lambda m: table[m.group(0)], s)
    s = s.replace("<PLAY_G>", "<PLAYER>").lower()
    s = re.sub(f"(?<=[{LETTER}#])-(?=[{LETTER}])", "", s)
    s = s.replace("<……>", "……").replace("“", "'").replace("”", "'").replace("‘", "'").replace("’", "'")
    s = re.sub(r"(?<=\d),(?=\d{3})", "", s)
    s = re.sub(r"\s*(<var>|……)\s*", r"\1", s)
    return s.replace("#mon", "pokémon").replace("#", "poké")


def german_key(commands):
    return tuple(tuple(c) for c in commands)


# -- renames ----------------------------------------------------------------------------------

def load_renames(root=ROOT):
    """(pret, Polished) English names as each writes them, from english_renames.tsv; a row whose
    reason ends in "Regular only" or "Faithful only" is (pret, Polished, "regular"/"faithful")."""
    path = Path(root) / "utils" / "english_renames.tsv"
    rows = []
    if path.exists():
        for line in path.read_text(encoding="utf-8").splitlines():
            if line and not line.startswith("#"):
                pret, polished, reason = line.split("\t")
                build = re.search(r"\b(Regular|Faithful) only$", reason)
                rows.append((pret, polished, build.group(1).lower()) if build else (pret, polished))
    return rows


def for_build(renames, build):
    """The (pret, Polished) renames that hold in one build ("regular" or "faithful")."""
    return [r[:2] for r in renames if len(r) == 2 or r[2] == build]


def git_source(base, root=ROOT):
    def source(rel):
        return subprocess.run(["git", "-C", str(root), "show", f"{base}:{rel}"], capture_output=True,
                              text=True, check=True).stdout
    return source


def constants_block(text, first):
    """Constant names from `const <first>` to the next const_def, in order."""
    out, inside = [], False
    for line in text.splitlines():
        if re.match(rf"\s*const {first}\b", line):
            inside = True
        elif inside and re.match(r"\s*const_def\b", line):
            break
        if inside and (m := re.match(r"\s*const (\w+)", line)):
            out.append(m.group(1))
    return out


def names_after(text, label, defined=frozenset(), pattern=r'^\s*(?:li|rawchar)\s+"([^"]*)"'):
    """Names listed after `label` in the build `defined` gives, "@" padding removed."""
    lines = [line for _, line in assemble(text.splitlines(), set(defined))]
    start = next(i for i, line in enumerate(lines) if line.startswith(f"{label}:"))
    return [m.group(1).rstrip("@") for line in lines[start + 1:] if (m := re.match(pattern, line))]


def polished_names(source, defined=frozenset()):
    """Polished's English names by constant in one build: {table: {constant: name}}."""
    item_consts = source("constants/item_constants.asm")

    def names(path, label):
        return names_after(source(path), label, defined)
    tables = {
        "pokemon": (constants_block(source("constants/pokemon_constants.asm"), "BULBASAUR"),
                    names("data/pokemon/names.asm", "PokemonNames")[1:]),
        "moves": (constants_block(source("constants/move_constants.asm"), "NO_MOVE"),
                  [""] + names("data/moves/names.asm", "MoveNames")),
        "items": (constants_block(item_consts, "NO_ITEM"), names("data/items/names.asm", "ItemNames")),
        "key items": (constants_block(item_consts, "BICYCLE"), names("data/items/key_names.asm", "KeyItemNames")[1:]),
        "trainer_classes": (re.findall(r"^\s*trainerclass (\w+)", source("constants/trainer_constants.asm"), re.M)[1:],
                            names("data/trainers/class_names.asm", "TrainerClassNames")),
    }
    out = {key: dict(zip(consts, names)) for key, (consts, names) in tables.items()}
    marks = source("data/maps/landmarks.asm")
    labels = re.findall(r"^\s*landmark\s+-?\d+,\s*-?\d+,\s*(\w+)", marks, re.M)
    named = dict(re.findall(r'^(\w+):\s*rawchar\s+"([^"]*)"', marks, re.M))
    consts = constants_block(source("constants/landmark_constants.asm"), "SPECIAL_MAP")
    out["landmarks"] = {c: named.get(lab, "").rstrip("@") for c, lab in zip(consts, labels)}
    return out


def table_renames(pairs, source):
    """(pret, Polished, reason) for every name the two English tables write differently under the
    same constant; where the Regular and Faithful builds name it differently, one row per build,
    its reason ending in "Regular only" or "Faithful only". Names under different constants
    (PARLYZ_HEAL, PARALYZEHEAL) are hand rows."""
    builds = {"Regular": polished_names(source), "Faithful": polished_names(source, {"FAITHFUL"})}
    rows = []
    for table, entries in pairs["names"].items():
        for const, (english, _) in entries.items():
            pret = english.replace("<BSP>", " ")
            names = {}
            for build, ours in builds.items():
                look = [ours.get(table, {})] + ([ours["key items"]] if table == "items" else [])
                names[build] = next((t[const].replace("¯", " ") for t in look if const in t), None)
            for build, name in names.items():
                only = f", {build} only" if len(set(names.values())) > 1 else ""
                if only or build == "Regular":
                    if name and normalize([("text", pret)], []) != normalize([("text", name)], []):
                        rows.append((pret, name, f"table {table} {const}{only}"))
    return rows


def write_renames(pairs, base, root=ROOT):
    """Regenerate the table part of english_renames.tsv; hand rows (reason not "table …") stay."""
    path = Path(root) / "utils" / "english_renames.tsv"
    header, hand = [], []
    for line in path.read_text(encoding="utf-8").splitlines() if path.exists() else []:
        if line.startswith("#"):
            header.append(line)
        elif line and not line.split("\t")[2].startswith("table "):
            hand.append(line)
    rows = table_renames(pairs, git_source(base, root))
    lines = header + hand + ["\t".join(r) for r in sorted(rows, key=lambda r: r[2])]
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return len(rows)


# -- where a Polished text sits ---------------------------------------------------------------

EVENT_SCRIPT_ARG = {"object_event": 10, "pokemon_event": 6, "bg_event": 3, "coord_event": 3}
EVENT_KIND = {"object_event": "object", "pokemon_event": "object", "bg_event": "bg", "coord_event": "coord"}
TERMINATORS = {"end", "endcallback", "endall", "sjump", "sjumpfwd", "jumptext", "jumptextfaceplayer",
               "jumpthistext", "jumpthisopenedtext", "farjumptext", "jumpstd", "jumpopenedtext", "end_if_just_battled"}


def map_constants(source):
    return dict(re.findall(r"^\s*map_attributes (\w+), (\w+)", source("data/maps/attributes.asm"), re.M))


def locate(root=ROOT, source=None):
    """(path, label) of a text -> its Where, from each map's events and trainers."""
    root = Path(root)
    source = source or (lambda rel: (root / rel).read_text(encoding="utf-8"))
    consts = map_constants(source)
    texts_by_file = defaultdict(dict)
    for t in iter_texts(root, ("maps",), source=source if source else None):
        texts_by_file[t.path].setdefault(t.label, t)
    found = {}
    for rel in sorted(texts_by_file):
        name = Path(rel).stem
        if name not in consts:
            continue
        lines = [line for _, line in assemble(source(rel).splitlines(), set())]
        labels = label_lines(lines)
        texts = texts_by_file[rel]

        def mark(start, where, seen):
            if start in seen or start not in labels:
                return
            seen.add(start)
            if start in texts:
                found.setdefault((rel, start), where)
            parent = start.split(".")[0]
            for line in lines[labels[start] + 1:]:
                code = strip_comment(line)
                if m := re.match(r"^(\.?[A-Za-z_][\w.]*)::?", code):
                    lab = m.group(1)
                    if not lab.startswith("."):
                        break
                    lab = parent + lab
                    if lab in texts:
                        found.setdefault((rel, lab), where)
                    code = code[m.end():]
                words = code.split()
                if not words:
                    continue
                for operand in re.findall(r"[.A-Za-z_][\w.]*", " ".join(words[1:])):
                    target = parent + operand if operand.startswith(".") else operand
                    if target in labels:
                        mark(target, where, seen)
                if words[0] in TERMINATORS:
                    break

        for line in lines:
            code = strip_comment(line).strip()
            parts = [p.strip() for p in code.split(",")]
            head = parts[0].split()
            if not head:
                continue
            if head[0] in ("generictrainer", "trainer") and len(head) > 1:
                pass  # trainers are handled below, with their label
            elif head[0] in EVENT_SCRIPT_ARG:
                args = [head[1]] + parts[1:] if len(head) > 1 else parts[1:]
                i = EVENT_SCRIPT_ARG[head[0]]
                if len(args) > i and args[0].isdigit() and args[1].isdigit():
                    where = {"map": consts[name], "event": EVENT_KIND[head[0]], "x": int(args[0]), "y": int(args[1])}
                    mark(args[i], where, set())
        current = None
        for line in lines:
            code = strip_comment(line)
            if m := re.match(r"^([A-Za-z_]\w*)::?", code):
                current = m.group(1)
            parts = [p.strip() for p in code.strip().split(",")]
            head = parts[0].split()
            if len(head) > 1 and head[0] in ("generictrainer", "trainer"):
                who = {"trainer": head[1], "id": parts[1]}
                found[(rel, current)] = who  # the inline after-battle text
                for operand in parts[3:]:
                    if operand in labels:
                        mark(operand, who, set())
                        found[(rel, operand)] = who
    return found


def label_lines(lines):
    """Label (Parent.local for local ones) -> its line index."""
    out, parent = {}, None
    for i, line in enumerate(lines):
        if m := re.match(r"^(\.?[A-Za-z_][\w.]*)::?", strip_comment(line)):
            name = m.group(1)
            if name.startswith("."):
                name = f"{parent}{name}"
            else:
                parent = name
            out[name] = i
    return out


# -- sorting ----------------------------------------------------------------------------------

def load_choices(root=ROOT):
    """Polished label -> pret label, the answers to ambiguous texts (kristall_choices.tsv)."""
    path = Path(root) / "utils" / "kristall_choices.tsv"
    out = {}
    if path.exists():
        for line in path.read_text(encoding="utf-8").splitlines():
            if line and not line.startswith("#"):
                polished, pret, *_ = line.split("\t")
                out[polished] = pret
    return out


def is_stub(commands):
    """A text that only points at another: text_far + text_end, or text_farend."""
    return [c[0] for c in commands] in (["text_far", "text_end"], ["text_far"], ["text_farend"])


def resolve(commands, by_label, depth=0):
    """Commands with every text_far replaced by its target's commands (found in by_label)."""
    out = []
    for c in commands:
        target = by_label.get(c[1]) if c[0] in ("text_far", "text_farend") else None
        if target is not None and depth < 4:
            out += [x for x in resolve(target, by_label, depth + 1) if x[0] not in ("done", "prompt", "text_end")]
            if c[0] == "text_farend":
                out.append(("text_end",))
        else:
            out.append(c)
    return out


class Matcher:
    """The pret texts most like a normalized English, by shared words, then difflib's ratio."""

    def __init__(self, norms):
        """norms: {pret text index: normalized English}."""
        self.norms = norms
        self.index = defaultdict(set)
        for i, n in norms.items():
            for word in set(n.split()):
                self.index[word].add(i)

    def best(self, norm, among=None, keep=40):
        if among is None:
            counts = Counter(i for word in set(norm.split()) if len(self.index[word]) < 400 for i in self.index[word])
            among = [i for i, _ in counts.most_common(keep)]
        scored = [(difflib.SequenceMatcher(None, norm, self.norms[i], autojunk=False).ratio(), i) for i in among]
        return max(scored, default=(0.0, None))


def classify(texts, pairs, renames, locations, choices):
    """An Entry for every Polished text that isn't a text_far stub, in order."""
    plist = pairs["texts"]
    pret_by_label = {p["label"]: p["en"] for p in plist}
    resolved = [resolve(p["en"], pret_by_label) for p in plist]
    # a pret stub isn't a candidate: its target is paired too, with the stub's Where
    real = [i for i, p in enumerate(plist) if not is_stub(p["en"])]
    groups = {}
    for build in ("regular", "faithful"):
        named = for_build(renames, build)
        groups[build] = defaultdict(list)
        for i in real:
            groups[build][normalize(resolved[i], named)].append(i)
    norms = [normalize(commands, for_build(renames, "regular")) for commands in resolved]
    matcher = Matcher({i: norms[i] for i in real})
    by_where = defaultdict(list)
    for i in real:
        if plist[i].get("where"):
            by_where[repr(sorted(plist[i]["where"].items()))].append(i)
    by_pret_label = {plist[i]["label"]: i for i in real}
    for p in plist:
        if is_stub(p["en"]) and p["en"][0][1] in by_pret_label:
            by_pret_label.setdefault(p["label"], by_pret_label[p["en"][0][1]])
    ours_by_label, stub_where = {}, {}
    for t in texts:
        ours_by_label.setdefault(t.label, t.commands)
        if is_stub(t.commands) and (t.path, t.label) in locations:
            stub_where.setdefault(t.commands[0][1], locations[(t.path, t.label)])  # the target's Where
    out = []
    for t in texts:
        if is_stub(t.commands):
            continue
        norm = normalize(resolve(t.commands, ours_by_label), [])
        where = locations.get((t.path, t.label)) or stub_where.get(t.label)
        builds = ("regular", "faithful") if t.variant == "both" else (t.variant,)
        found = next((groups[b][norm] for b in builds if norm in groups[b]), None)
        if found:
            cands = [plist[i] for i in found]
            germans = {german_key(p["de"]) for p in cands} | {german_key(a["de"]) for p in cands for a in p["de_alts"]}
            here = [p for p in cands if where and p.get("where") == where]
            same = [p for p in cands if p["label"] == t.label]
            chosen = [p for p in cands if p["label"] == choices.get(t.label)]
            if len(germans) == 1:
                out.append(Entry(t, "word", (here or cands)[0], cands, 1.0))
            elif len({german_key(p["de"]) for p in here}) == 1 and not any(p["de_alts"] for p in here):
                out.append(Entry(t, "word", here[0], cands, 1.0))
            elif same:
                out.append(Entry(t, "word", same[0], cands, 1.0))
            elif chosen:
                out.append(Entry(t, "word", chosen[0], cands, 1.0))
            else:
                out.append(Entry(t, "ambiguous", None, cands, 1.0))
            continue
        near = by_where.get(repr(sorted(where.items()))) if where else None
        if near:
            score, i = matcher.best(norm, among=near)
            out.append(Entry(t, "changed", plist[i], [], score))
            continue
        if t.label in by_pret_label:
            i = by_pret_label[t.label]
            score, _ = matcher.best(norm, among=[i])
            out.append(Entry(t, "changed", plist[i], [], score))
            continue
        score, i = matcher.best(norm)
        if i is not None and score >= THRESHOLD:
            out.append(Entry(t, "changed", plist[i], [], score))
        else:
            out.append(Entry(t, "new", None, [], score))
    return out


def main():
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    from kristall_pairs import load_pairs
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("--stats", action="store_true", help="count the texts of each class")
    ap.add_argument("--renames", action="store_true", help="regenerate english_renames.tsv's table part")
    ap.add_argument("--base", help="Upstream's English (default: git merge-base HEAD upstream/master)")
    a = ap.parse_args()
    base = a.base or subprocess.run(["git", "-C", str(ROOT), "merge-base", "HEAD", "upstream/master"],
                                    capture_output=True, text=True, check=True).stdout.strip()
    pairs = load_pairs()
    if a.renames:
        print(f"{write_renames(pairs, base)} table renames written to {RENAMES}")
    if a.stats:
        entries = classify(list(iter_texts()), pairs, load_renames(), locate(), load_choices())
        by = Counter(e.cls for e in entries)
        print(", ".join(f"{k} {by[k]}" for k in ("word", "ambiguous", "changed", "new")), f"(of {len(entries)})")


if __name__ == "__main__":
    sys.exit(main())
