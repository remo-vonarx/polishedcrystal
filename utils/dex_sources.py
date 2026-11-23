#!/usr/bin/env python3
"""Find where each Polished Pokédex entry's English comes from, and that game's German.

Usage:
    python3 -I utils/dex_sources.py --cache DIR [--stats]

DIR caches PokeAPI's pokemon-species records (CLAUDE.md: a folder in the scratchpad); each species
is fetched once. Entries that are Crystal's English word for word (kristall_index.py) take
Kristall's German and need no lookup. For every other entry, PokeAPI's English flavor texts of the
species are compared with Polished's English:
- kristall: Crystal's English, edited (the word-for-word ones are "crystal"): Kristall's German;
- pokeapi: the same English in one or more games, and German for at least one of them (PokeAPI
  has German from X and Y on, and for Let's Go); the German of those games is taken;
- pokewiki: the same English, but no German in PokeAPI for those games (Gen 1 to 5): PokéWiki
  has it;
- ambiguous: the matching games' German differs;
- form: a regional form no game matches: PokeAPI keeps no form entries, PokéWiki has them;
- none: no game has this English; the closest one and its score are listed.
A game whose English holds Polished's shortened or lightly edited text counts as its source
(EDITED): the entry is marked edited, and its German needs the same edit.
Each entry's result, German included, goes to .claude/upload/dex_sources.json: Nintendo text,
never committed. The Pokédex chunk writes the German into data/pokemon/dex_entries.asm.
"""
import argparse
import difflib
import json
import re
import subprocess
import sys
import time
from collections import Counter, namedtuple
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))  # python3 -I leaves the script's directory out

from asm_text import ROOT  # noqa: E402
from kristall_index import normalize  # noqa: E402

OUT = ROOT / ".claude" / "upload" / "dex_sources.json"
DEX = "data/pokemon/dex_entries.asm"
API = "https://pokeapi.co/api/v2/pokemon-species/{}/"
Origin = namedtuple("Origin", "cls versions german german_versions score closest edited")
# Polished shortens long entries (Sirfetch'd keeps the first of two sentences), so a game counts as
# the source when this share of Polished's text is found in order in the game's (coverage).
# Measured 2026-11-23: the traced entries cover 0.89 to 1.0; the next, Dudunsparce, 0.79; regional
# forms, which PokeAPI doesn't keep, 0.63 at most.
EDITED = 0.85


def flat(text):
    """A PokeAPI flavor text on one line: a soft hyphen at a line end joins, breaks are spaces."""
    return " ".join(text.replace("\xad\n", "").replace("\xad", "").split())


def coverage(ours, theirs):
    """The share of `ours` found, in order, in `theirs`."""
    blocks = difflib.SequenceMatcher(None, ours, theirs, autojunk=False).get_matching_blocks()
    return sum(b.size for b in blocks) / max(len(ours), 1)


def origin(commands, species):
    """Where an entry's English (Polished's commands) comes from among a species' flavor texts."""
    ours = normalize([c for c in commands if c[0] != "category"], [])
    english, german = {}, {}
    for f in species["flavor_text_entries"]:
        lang, version = f["language"]["name"], f["version"]["name"]
        if lang == "en":
            english[version] = normalize([("text", flat(f["flavor_text"]))], [])
        elif lang == "de":
            german[version] = flat(f["flavor_text"])
    versions, score, edited = sorted(v for v, text in english.items() if text == ours), 1.0, False
    if not versions:
        scored = [(coverage(ours, text), v) for v, text in english.items()]
        score, closest = max(scored, default=(0.0, None))
        score = round(score, 2)
        if score < EDITED:
            return Origin("none", [], None, [], score, closest, False)
        versions, edited = sorted(v for v, text in english.items() if text == english[closest]), True
    if "crystal" in versions:
        return Origin("kristall", versions, None, [], score, None, edited)
    with_german = [v for v in versions if v in german]
    if not with_german:
        return Origin("pokewiki", versions, None, [], score, None, edited)
    texts = {german[v] for v in with_german}
    if len(texts) > 1:
        return Origin("ambiguous", versions, None, with_german, score, None, edited)
    return Origin("pokeapi", versions, texts.pop(), with_german, score, None, edited)


def api_name(constant):
    """PokeAPI's name for a species constant: MR__MIME mr-mime, FARFETCH_D farfetchd, MIME_JR_ mime-jr."""
    name = constant.rstrip("_").lower()
    name = re.sub(r"_d$", "d", name)
    return name.replace("__", "-").replace("_", "-")


def dex_labels(root=ROOT):
    """(the species constants, the pointer table's labels): the table follows the constants, then
    lists the forms."""
    root = Path(root)
    consts = []
    lines = (root / "constants/pokemon_constants.asm").read_text(encoding="utf-8").splitlines()
    inside = False
    for line in lines:
        code = line.split(";")[0].strip()
        if code == "const_def 1":
            inside = True
        elif code.startswith("DEF NUM_SPECIES"):
            break
        elif inside and code == "const_skip":
            consts.append(None)
        elif inside and (m := re.match(r"const (\w+)$", code)):
            consts.append(m.group(1))
    labels = re.findall(r"^\s*dba (\w+)", (root / "data/pokemon/dex_entry_pointers.asm").read_text(encoding="utf-8"), re.M)
    return consts, labels


def form_labels(root=ROOT):
    """The entries of forms (Alolan Rattata), listed after the species."""
    consts, labels = dex_labels(root)
    return set(labels[len(consts):]) - set(labels[:len(consts)])


def species_names(root=ROOT):
    """Each Pokédex entry label -> the PokeAPI species it belongs to; a form belongs to the species
    whose label starts it."""
    consts, labels = dex_labels(root)
    out, stems = {}, {}
    for label, const in zip(labels, consts):
        if const:  # the first species wins: EGG reuses Bulbasaur's entry
            out.setdefault(label, api_name(const))
            stems.setdefault(re.sub(r"(Plain)?PokedexEntry$", "", label), api_name(const))
    for label in labels[len(consts):]:
        stem = max((s for s in stems if label.startswith(s)), key=len, default=None)
        if stem:
            out[label] = stems[stem]
    return out


def fetch_species(name, cache):
    """PokeAPI's pokemon-species record, from the cache or fetched once into it."""
    path = Path(cache) / "pokemon-species" / f"{name}.json"
    if not path.exists():  # curl: python.org's Python may lack the system's certificates
        path.parent.mkdir(parents=True, exist_ok=True)
        subprocess.run(["curl", "-sfL", "--max-time", "30", "-A", "dex-source-check", "-o", str(path),
                        API.format(name)], check=True)
        time.sleep(0.2)
    return json.loads(path.read_text(encoding="utf-8"))


def main():
    from asm_text import iter_texts
    from kristall_index import classify, load_choices, load_renames
    from kristall_lookup import git_tree
    from kristall_pairs import load_pairs
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("--cache", required=True, help="folder for PokeAPI records (in the scratchpad)")
    ap.add_argument("--stats", action="store_true", help="print only the count per class")
    ap.add_argument("--base", help="Upstream's English (default: git merge-base HEAD upstream/master)")
    a = ap.parse_args()
    base = a.base or subprocess.run(["git", "-C", str(ROOT), "merge-base", "HEAD", "upstream/master"],
                                    capture_output=True, text=True, check=True).stdout.strip()
    files, source = git_tree(base)
    texts = list(iter_texts(ROOT, source=source, files=[DEX]))
    entries = classify(texts, load_pairs(), load_renames(), {}, load_choices())
    names, forms = species_names(), form_labels()
    results, counts = {}, Counter()
    for e in entries:
        t = e.text
        key = t.label if t.variant == "both" else f"{t.label} ({t.variant})"
        if e.cls == "word":
            results[key] = {"class": "crystal", "pret": e.pair["label"]}
        elif t.label not in names:
            results[key] = {"class": "no species"}
        else:
            o = origin(t.commands, fetch_species(names[t.label], a.cache))
            cls = "form" if o.cls == "none" and t.label in forms else o.cls
            results[key] = {"class": cls, "edited": o.edited, "species": names[t.label], "versions": o.versions,
                            "german_versions": o.german_versions, "german": o.german,
                            "score": o.score, "closest": o.closest}
        r = results[key]
        counts[r["class"] + (" edited" if r.get("edited") else "")] += 1
        if not a.stats and r["class"] != "crystal":
            where = ", ".join(r.get("german_versions") or r.get("versions") or []) or \
                f"closest {r.get('closest')} {r.get('score')}"
            print(f"{key}: {r['class']}{' edited ' + str(r['score']) if r.get('edited') else ''} ({where})")
    OUT.write_text(json.dumps(results, ensure_ascii=False, indent=1), encoding="utf-8")
    print(", ".join(f"{k} {n}" for k, n in counts.most_common()), f"(of {len(entries)}); written to {OUT}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
