#!/usr/bin/env python3
"""Pair every English text of pret's Crystal with Kristall's German, by walking both ROMs.

Usage: python3 -I utils/kristall_pairs.py [--out PATH]

Writes .claude/upload/kristall_pairs.json (Nintendo text: never committed) and prints the
coverage numbers. Every pair is proven by where it was reached, never by its content; a place
where the two ROMs disagree stops the tool (LockstepError).

JSON layout:
  "texts": [{"label", "kind", "en_addr", "de_addr", "path", "where", "en", "de",
             "structure_differs"}]  # en/de: commands as kristall_rom.decode_text gives them
  "names": {table: {pret_constant: [english, german]}}
  "coverage": {"unreached_dump": [...], "unpaired_labels": [...]}, "other_pointers": {kind: n}
"""
import argparse
import json
import re
import sys
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))  # python3 -I leaves the script's directory out

from kristall_rom import (KRISTALL_CHARS, KRISTALL_ROM, PAIRS_JSON, PRET, PRET_CHARS, Rom, decode_text,
                          labels_at, ram_names, read_sym)
from kristall_script import ENGINE_SCRIPTS, TEXT, LockstepError, Walker, where

MAP_HEADER_SIZE = 9
NULL_POINTERS = (0, 0xFFFF)
OBJECT_SIZE = 13
OBJECTTYPE_SCRIPT, OBJECTTYPE_ITEMBALL, OBJECTTYPE_TRAINER = 0, 1, 2
BGEVENT_SCRIPTS = range(0, 5)  # read, up, down, right, left
BGEVENT_IFSET, BGEVENT_IFNOTSET, BGEVENT_ITEM = 5, 6, 7


def map_constants(pret_dir):
    """(group, number) -> map constant, counted as pret's constants/map_constants.asm counts them."""
    names, group, number = {}, 0, 0
    for line in (pret_dir / "constants" / "map_constants.asm").read_text(encoding="utf-8").splitlines():
        if re.match(r"\s*newgroup\b", line):
            group, number = group + 1, 0
        elif m := re.match(r"\s*map_const (\w+),", line):
            number += 1
            names[group, number] = m.group(1)
    return names


def trainer_constants(pret_dir):
    """(class, id) -> (class constant, id constant) from pret's constants/trainer_constants.asm."""
    names, cls, cls_name, tid = {}, -1, None, 0
    for line in (pret_dir / "constants" / "trainer_constants.asm").read_text(encoding="utf-8").splitlines():
        if m := re.match(r"\s*trainerclass (\w+)", line):
            cls, cls_name, tid = cls + 1, m.group(1), 1
        elif (m := re.match(r"\s*const (\w+)", line)) and cls >= 0:
            names[cls, tid] = (cls_name, m.group(1))
            tid += 1
    return names


def same(a, b, what):
    if a != b:
        raise LockstepError(f"{what}: {a!r} against {b!r}")


class Builder:
    def __init__(self, pret_dir, kristall):
        self.pret_dir = Path(pret_dir)
        self.en = Rom(self.pret_dir / "pokecrystal.gbc")
        self.de = Rom(kristall)
        self.sym = read_sym(self.pret_dir / "pokecrystal.sym")
        self.labels = labels_at(self.sym)
        self.ram = ram_names(self.sym)
        self.texts = {}  # pret pointer -> pair record
        self.other = Counter()
        self.notes = []  # event data Kristall changed (positions, ...): recorded, not fatal
        self.context = {"kind": "map", "where": None}
        self.walker = Walker(self.en, self.de, self.visit, std=self.sym["StdScripts"],
                             engine={cmd: self.sym[label] for cmd, label in ENGINE_SCRIPTS.items()})

    # -- texts -------------------------------------------------------------------------------

    def visit(self, kind, en_ptr, de_ptr, path):
        if en_ptr[1] in NULL_POINTERS:  # no text (winlosstext's loss text, 0 or -1; Kristall may use either)
            same(de_ptr[1] in NULL_POINTERS, True, f"null pointer ({' > '.join(path)})")
            return
        if kind == TEXT:
            self.add_text(en_ptr, de_ptr, path)
        else:
            self.other[kind] += 1

    def add_text(self, en_ptr, de_ptr, path, kind=None, where_=None):
        known = self.texts.get(en_ptr)
        if known is not None:  # a second Kristall twin: kept, and flagged later if its German differs
            if known["de_addr"] != where(de_ptr) and where(de_ptr) not in [a["de_addr"] for a in known["de_alts"]]:
                try:
                    de = decode_text(self.de, *de_ptr, KRISTALL_CHARS, self.ram)
                except ValueError as e:
                    raise LockstepError(f"{e} ({' > '.join(path)})") from None
                known["de_alts"].append({"de_addr": where(de_ptr), "path": path,
                                         "de": self.named(de.commands, kristall=True)})
            return known
        try:
            en = decode_text(self.en, *en_ptr, PRET_CHARS, self.ram)
            de = decode_text(self.de, *de_ptr, KRISTALL_CHARS, self.ram)
        except ValueError as e:
            raise LockstepError(f"{e} ({' > '.join(path)})") from None
        record = {
            "label": self.labels.get(en_ptr, where(en_ptr)),
            "kind": kind or self.context["kind"],
            "en_addr": where(en_ptr), "de_addr": where(de_ptr), "path": path,
            "where": where_ if where_ is not None else self.context["where"],
            "en": self.named(en.commands), "de": self.named(de.commands, kristall=True),
            "structure_differs": shape(en.commands) != shape(de.commands),
            "de_alts": [],  # other Kristall twins: {"de_addr", "path", "de"}
        }
        self.texts[en_ptr] = record
        far_en = [c[1] for c in en.commands if c[0] == "text_far"]
        far_de = [c[1] for c in de.commands if c[0] == "text_far"]
        if len(far_en) == len(far_de):
            for fe, fd in zip(far_en, far_de):
                self.add_text(fe, fd, path + [f"text_far@{where(fe)}"], record["kind"], record["where"])
        return record

    def named(self, commands, kristall=False):
        """text_far targets as pret labels (English) or addresses (Kristall), for the JSON."""
        return [("text_far", where(c[1]) if kristall else self.labels.get(c[1], where(c[1])))
                if c[0] == "text_far" else c for c in commands]

    # -- maps --------------------------------------------------------------------------------

    def walk_maps(self):
        names = map_constants(self.pret_dir)
        trainers = trainer_constants(self.pret_dir)
        gbank, gaddr = self.sym["MapGroupPointers"]
        groups = max(g for g, _ in names)
        for g in range(1, groups + 1):
            same(self.en.word(gbank, gaddr + 2 * (g - 1)), self.de.word(gbank, gaddr + 2 * (g - 1)), f"group {g}")
            headers = self.en.word(gbank, gaddr + 2 * (g - 1))
            for n in range(1, 1 + max(m for gg, m in names if gg == g)):
                self.walk_map(names[g, n], gbank, headers + MAP_HEADER_SIZE * (n - 1), trainers)

    def walk_map(self, name, hbank, header, trainers):
        for i in range(MAP_HEADER_SIZE):
            same(self.en.byte(hbank, header + i), self.de.byte(hbank, header + i), f"{name} header byte {i}")
        abank, attrs = self.en.byte(hbank, header), self.en.word(hbank, header + 3)
        en_a = [self.en.byte(abank, attrs + i) for i in range(12)]
        de_a = [self.de.byte(abank, attrs + i) for i in range(12)]
        same(en_a[:6] + en_a[11:], de_a[:6] + de_a[11:], f"{name} attributes")
        word = lambda a, i: a[i] | a[i + 1] << 8  # noqa: E731
        banks = en_a[6], de_a[6]  # Kristall moved some maps' scripts to another bank
        self.walk_map_scripts(name, banks, word(en_a, 7), word(de_a, 7))
        self.walk_map_events(name, banks, word(en_a, 9), word(de_a, 9), trainers)

    def soft(self, a, b, what):
        if a != b:
            self.notes.append(f"{what}: {a} against {b}")

    def walk(self, where_, en_ptr, de_ptr, path):
        self.context = {"kind": "map", "where": where_}
        self.walker.walk(en_ptr, de_ptr, path)

    def walk_map_scripts(self, name, banks, ea, da):
        bank, dbank = banks
        en, de = self.en, self.de
        scenes = en.byte(bank, ea)
        same(scenes, de.byte(dbank, da), f"{name} scene count")
        for i in range(scenes):
            p = 1 + 4 * i
            self.walk({"map": name, "event": "scene", "index": i},
                      (bank, en.word(bank, ea + p)), (dbank, de.word(dbank, da + p)), [name, f"scene {i}"])
        ea, da = ea + 1 + 4 * scenes, da + 1 + 4 * scenes
        callbacks = en.byte(bank, ea)
        same(callbacks, de.byte(dbank, da), f"{name} callback count")
        for i in range(callbacks):
            p = 1 + 3 * i
            same(en.byte(bank, ea + p), de.byte(dbank, da + p), f"{name} callback {i} type")
            self.walk({"map": name, "event": "callback", "index": i},
                      (bank, en.word(bank, ea + p + 1)), (dbank, de.word(dbank, da + p + 1)), [name, f"callback {i}"])

    def walk_map_events(self, name, banks, ea, da, trainers):
        bank, dbank = banks
        en, de = self.en, self.de
        ea, da = ea + 2, da + 2  # filler
        warps = en.byte(bank, ea)
        same(warps, de.byte(dbank, da), f"{name} warp count")
        ea, da = ea + 1 + 5 * warps, da + 1 + 5 * warps
        coords = en.byte(bank, ea)
        same(coords, de.byte(dbank, da), f"{name} coord count")
        for i in range(coords):
            p = 1 + 8 * i
            y, x = en.byte(bank, ea + p + 1), en.byte(bank, ea + p + 2)
            self.soft([en.byte(bank, ea + p + k) for k in range(4)], [de.byte(dbank, da + p + k) for k in range(4)],
                      f"{name} coord event {i}")
            self.walk({"map": name, "event": "coord", "x": x, "y": y},
                      (bank, en.word(bank, ea + p + 4)), (dbank, de.word(dbank, da + p + 4)), [name, f"coord {x},{y}"])
        ea, da = ea + 1 + 8 * coords, da + 1 + 8 * coords
        bgs = en.byte(bank, ea)
        same(bgs, de.byte(dbank, da), f"{name} bg count")
        for i in range(bgs):
            p = 1 + 5 * i
            y, x, function = (en.byte(bank, ea + p + k) for k in range(3))
            twin = [de.byte(dbank, da + p + k) for k in range(3)]
            same(function, twin[2], f"{name} bg event {i} function")
            self.soft([y, x], twin[:2], f"{name} bg event {i}")
            pe, pd = en.word(bank, ea + p + 3), de.word(dbank, da + p + 3)
            spot = {"map": name, "event": "bg", "x": x, "y": y}
            if function in BGEVENT_SCRIPTS:
                self.walk(spot, (bank, pe), (dbank, pd), [name, f"bg {x},{y}"])
            elif function in (BGEVENT_IFSET, BGEVENT_IFNOTSET):
                same(en.word(bank, pe), de.word(dbank, pd), f"{name} bg {x},{y} flag")
                self.walk(spot, (bank, en.word(bank, pe + 2)), (dbank, de.word(dbank, pd + 2)), [name, f"bg {x},{y}"])
            elif function != BGEVENT_ITEM:
                self.other[f"bg function {function}"] += 1
        ea, da = ea + 1 + 5 * bgs, da + 1 + 5 * bgs
        objects = en.byte(bank, ea)
        same(objects, de.byte(dbank, da), f"{name} object count")
        for i in range(objects):
            p = ea + 1 + OBJECT_SIZE * i
            q = da + 1 + OBJECT_SIZE * i
            raw = [en.byte(bank, p + k) for k in range(OBJECT_SIZE)]
            twin = [de.byte(dbank, q + k) for k in range(OBJECT_SIZE)]
            same(raw[7] & 0xF, twin[7] & 0xF, f"{name} object {i} type")
            self.soft(raw[:9] + raw[11:], twin[:9] + twin[11:], f"{name} object {i}")  # all but the pointer
            y, x, otype = raw[1] - 4, raw[2] - 4, raw[7] & 0xF
            pe, pd = en.word(bank, p + 9), de.word(dbank, q + 9)
            spot = {"map": name, "event": "object", "x": x, "y": y}
            target = self.labels.get((bank, pe), "")
            if otype == OBJECTTYPE_SCRIPT and ("Movement" in target or target.endswith("_MapEvents")):
                # pret's Battle Tower receptionists point at movement data and at their map's events
                self.other["object without a script"] += 1
            elif otype == OBJECTTYPE_SCRIPT:
                if pe:
                    self.walk(spot, (bank, pe), (dbank, pd), [name, f"object {x},{y}"])
            elif otype == OBJECTTYPE_TRAINER and pe < 0x4000:  # home's ObjectEvent: a script, no header
                self.walk(spot, (0, pe), (0, pd), [name, f"object {x},{y}"])
            elif otype == OBJECTTYPE_TRAINER:
                self.walk_trainer(name, banks, pe, pd, trainers, spot)
            elif otype != OBJECTTYPE_ITEMBALL:
                self.other[f"object type {otype}"] += 1

    def walk_trainer(self, name, banks, pe, pd, trainers, spot):
        bank, dbank = banks
        en, de = self.en, self.de
        same([en.byte(bank, pe + k) for k in range(4)], [de.byte(dbank, pd + k) for k in range(4)],
             f"{name} trainer header")
        cls, tid = en.byte(bank, pe + 2), en.byte(bank, pe + 3)
        cname, iname = trainers.get((cls, tid), (str(cls), str(tid)))
        who = {"trainer": cname, "id": iname}
        self.context = {"kind": "map", "where": who}
        path = [name, f"trainer {cname} {iname}"]
        for k in range(3):  # seen, beaten, loss
            te, td = en.word(bank, pe + 4 + 2 * k), de.word(dbank, pd + 4 + 2 * k)
            if te:
                self.add_text((bank, te), (dbank, td), path + [("seen", "beaten", "loss")[k]])
        self.walk(who, (bank, en.word(bank, pe + 10)), (dbank, de.word(dbank, pd + 10)), path + ["after"])

    # -- output ------------------------------------------------------------------------------

    def result(self):
        return {"texts": list(self.texts.values()), "names": {},
                "coverage": {"unreached_dump": [], "unpaired_labels": []},
                "other_pointers": dict(self.other), "notes": self.notes}


STRING_COMMANDS = ("text", "line", "cont", "para", "next", "page")


def shape(commands):
    """A text's structure, for comparing the two ROMs: its variables and other inline commands
    (with their operands, far pointers left out) and its ending. A run of strings counts as one,
    since German breaks its lines where English doesn't."""
    out = []
    for c in commands:
        if c[0] in STRING_COMMANDS:
            if not out or out[-1] != "S":
                out.append("S")
        else:
            out.append(c[:1] + tuple(x for x in c[1:] if not isinstance(x, (tuple, list))))
    return out


def build_pairs(pret_dir=PRET, kristall=KRISTALL_ROM):
    b = Builder(pret_dir, kristall)
    b.walk_maps()
    return b.result()


def write_pairs(pairs, out=PAIRS_JSON):
    Path(out).write_text(json.dumps(pairs, ensure_ascii=False, indent=0), encoding="utf-8")


def load_pairs(path=PAIRS_JSON):
    """The pairs file with every command back as a tuple."""
    pairs = json.loads(Path(path).read_text(encoding="utf-8"))
    for p in pairs["texts"]:
        p["en"] = [tuple(c) for c in p["en"]]
        p["de"] = [tuple(c) for c in p["de"]]
        for alt in p.get("de_alts", []):
            alt["de"] = [tuple(c) for c in alt["de"]]
    return pairs


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("--out", default=PAIRS_JSON, type=Path)
    a = ap.parse_args()
    pairs = build_pairs()
    write_pairs(pairs, a.out)
    kinds = Counter(p["kind"] for p in pairs["texts"])
    print(f"{len(pairs['texts'])} texts paired ({', '.join(f'{k} {n}' for k, n in sorted(kinds.items()))}), "
          f"{sum(p['structure_differs'] for p in pairs['texts'])} with a different structure")
    for key, items in pairs["coverage"].items():
        print(f"{key}: {len(items)}")
    print(f"other pointers: {pairs['other_pointers']}")
    print(f"written to {a.out}")


if __name__ == "__main__":
    sys.exit(main())
