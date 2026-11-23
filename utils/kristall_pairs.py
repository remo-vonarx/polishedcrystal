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
from functools import partial
import re
import sys
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))  # python3 -I leaves the script's directory out

from kristall_rom import (KRISTALL_CHARS, KRISTALL_ROM, PAIRS_JSON, PRET, PRET_CHARS, ROOT, TEXT_MACROS, Rom, decode_dex,
                          decode_lines, decode_text, labels_at, ram_names, read_constants, read_names,
                          read_sections, read_sym)
from kristall_script import ENGINE_SCRIPTS, TEXT, LockstepError, Walker, where

MAP_HEADER_SIZE = 9
NULL_POINTERS = (0, 0xFFFF)
DUMP = ROOT / ".claude" / "upload" / "german_text_dump.txt"
# pret's text-only sections, read text by text from their start in both ROMs ("Miscellaneous Text"
# holds code and name lists too, so its texts are paired only through pointers)
TEXT_SECTIONS = ("Text 1", "Text 2", "Text 3", "Phone Text", "Phone Text 2", "Crystal Phone Text",
                 "Crystal Phone Text 2", "Special Phone Text", "Battle Tower Text")
PHONE_CONTACT_SIZE = 12  # class, id, map group, map number, callee time, callee (dba), caller time, caller (dba)
SPECIAL_CALL_SIZE = 6  # condition (dw, code), contact, script (dba)
OBJECT_SIZE = 13
OBJECTTYPE_SCRIPT, OBJECTTYPE_ITEMBALL, OBJECTTYPE_TRAINER = 0, 1, 2
BGEVENT_SCRIPTS = range(0, 5)  # read, up, down, right, left
BGEVENT_IFSET, BGEVENT_IFNOTSET, BGEVENT_ITEM = 5, 6, 7

# pret texts that Kristall splits into several texts in an order-paired section, with the count:
# the section walk steps over all of Kristall's parts and leaves the pret text unpaired (its chunk
# takes it from the dump). Read from both ROMs: Kristall prints "MARGIT:" (6f:4961) and
# "PROF. EICHs" (6f:496b) where pret has one text, MARY: PROF.OAK'S.
KRISTALL_SPLITS = {"_OPT_IntroText1": 2}


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


def pret_text_labels(pret_dir):
    """Every pret label (Parent.local for local ones) whose first code line is a text command."""
    starts = {m.name for m in TEXT_MACROS.values()} | {"text"}
    found, parent, pending = set(), None, []
    for path in sorted(Path(pret_dir).rglob("*.asm")):
        for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
            code = line.split(";")[0].rstrip()
            if not code.strip():
                continue
            if m := re.match(r"^([A-Za-z_][\w]*)::?(.*)$", code):
                parent, rest = m.group(1), m.group(2).strip()
                pending.append(parent)
            elif m := re.match(r"^\.([\w]+):?(.*)$", code):
                rest = m.group(2).strip()
                pending.append(f"{parent}.{m.group(1)}")
            else:
                rest = code.strip()
            if rest:
                if rest.split()[0] in starts:
                    found.update(pending)
                pending = []
    return found


# Game Boy (SM83) opcodes with a 16-bit operand, and with an 8-bit one; all others take none
# (CB-prefixed ones take one byte after the prefix, counted as an 8-bit operand).
OPCODES_16 = {0x01, 0x08, 0x11, 0x21, 0x31, 0xC2, 0xC3, 0xC4, 0xCA, 0xCC, 0xCD, 0xD2, 0xD4, 0xDA, 0xDC, 0xEA, 0xFA}
OPCODES_8 = {0x06, 0x0E, 0x16, 0x1E, 0x26, 0x2E, 0x36, 0x3E, 0x18, 0x20, 0x28, 0x30, 0x38, 0xC6, 0xCE, 0xD6,
             0xDE, 0xE6, 0xEE, 0xF6, 0xFE, 0xE0, 0xF0, 0xE8, 0xF8, 0xCB}


def code_in_step(a, b):
    """True if pret's code `a` and Kristall's `b` are the same instructions: equal opcodes and 8-bit
    operands; 16-bit operands (addresses Kristall moved) may differ."""
    i = 0
    while i < len(a):
        if i >= len(b) or a[i] != b[i]:
            return False
        if a[i] in OPCODES_16:
            i += 3
        elif a[i] in OPCODES_8:
            if a[i + 1:i + 2] != b[i + 1:i + 2]:
                return False
            i += 2
        else:
            i += 1
    return True


def pair_run(en, de, start, starts, tail=8):
    """Pair a run of back-to-back texts that starts at the same address in both ROMs: it goes on
    while pret's next text start is in `starts`, and holds only if the `tail` bytes after it are
    the same code in both ROMs (code_in_step: the code after the texts resumes in step).
    [(en_ptr, de_ptr, en, de)] or []."""
    bank, ea = start
    da, out = ea, []
    try:
        while True:
            t = decode_text(en, bank, ea, PRET_CHARS, {})
            u = decode_text(de, bank, da, KRISTALL_CHARS, {})
            out.append(((bank, ea), (bank, da), t, u))
            ea, da = ea + t.length, da + u.length
            while en.byte(bank, ea) == 0x50 and (bank, ea) not in starts:
                ea += 1
            while de.byte(bank, da) == 0x50:
                da += 1
            if (bank, ea) not in starts:
                break
    except ValueError:
        return []
    o, q = en.offset(bank, ea), de.offset(bank, da)
    return out if code_in_step(en.data[o:o + tail], de.data[q:q + tail + 2]) else []


def pair_gap(en, de, en_ptr, de_ptr, starts, known):
    """The texts between a proven pair (en_ptr, de_ptr) and the next proven pair after it: pret's
    unused texts that no pointer reaches. The chain must end exactly where `known` (pret pointer ->
    Kristall pointer) puts the next pair, else []. [(en_ptr, de_ptr, en, de)]."""
    (eb, ea), (db, da) = en_ptr, de_ptr
    out = []
    try:
        while True:
            ea += decode_text(en, eb, ea, PRET_CHARS, {}).length
            da += decode_text(de, db, da, KRISTALL_CHARS, {}).length
            while en.byte(eb, ea) == 0x50 and (eb, ea) not in starts:
                ea += 1
            while de.byte(db, da) == 0x50:
                da += 1
            if (eb, ea) in known:
                return out if out and known[eb, ea] == (db, da) else []
            if (eb, ea) not in starts:
                return []
            out.append(((eb, ea), (db, da), decode_text(en, eb, ea, PRET_CHARS, {}),
                        decode_text(de, db, da, KRISTALL_CHARS, {})))
    except ValueError:
        return []


def trainer_classes(pret_dir):
    """Class number -> class constant for every trainer class but TRAINER_NONE (0)."""
    found = re.findall(r"^\s*trainerclass (\w+)", (Path(pret_dir) / "constants" / "trainer_constants.asm")
                       .read_text(encoding="utf-8"), re.M)
    return {i: name for i, name in enumerate(found) if i >= 1}


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

    def add_text(self, en_ptr, de_ptr, path, kind=None, where_=None, by="pointer"):
        """Pair a pret text with its Kristall twin. `by`: "pointer" when both ROMs' pointers lead
        there, "order" when it's paired by its place in a run or section. A second twin reached by
        pointers is kept as an alt (classify weighs their German); a second twin where either
        pairing is by order means the order pairing is wrong, and the build stops."""
        known = self.texts.get(en_ptr)
        if known is not None:
            if known["de_addr"] != where(de_ptr) and where(de_ptr) not in [a["de_addr"] for a in known["de_alts"]]:
                if by == "order" or known.get("by") == "order":
                    raise LockstepError(f'{known["label"]}: paired with {known["de_addr"]} by {known.get("by")} '
                                        f'({" > ".join(known["path"])}), with {where(de_ptr)} by {by} '
                                        f'({" > ".join(path)})')
                try:
                    de = decode_text(self.de, *de_ptr, KRISTALL_CHARS, self.ram)
                except ValueError as e:
                    raise LockstepError(f"{e} ({' > '.join(path)})") from None
                known["de_alts"].append({"de_addr": where(de_ptr), "de_len": de.length, "path": path,
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
            "en_addr": where(en_ptr), "de_addr": where(de_ptr), "de_len": de.length, "path": path,
            "where": where_ if where_ is not None else self.context["where"],
            "en": self.named(en.commands), "de": self.named(de.commands, kristall=True),
            "structure_differs": shape(en.commands) != shape(de.commands),
            "de_alts": [],  # other Kristall twins: {"de_addr", "path", "de"}
            "by": by,
        }
        self.texts[en_ptr] = record
        far_en = [c[1] for c in en.commands if c[0] == "text_far"]
        far_de = [c[1] for c in de.commands if c[0] == "text_far"]
        if len(far_en) == len(far_de):
            for fe, fd in zip(far_en, far_de):
                self.add_text(fe, fd, path + [f"text_far@{where(fe)}"], record["kind"], record["where"], by)
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

    # -- phone -------------------------------------------------------------------------------

    def walk_phone(self, trainers):
        """PhoneContacts and SpecialPhoneCallList: Kristall moved both; found by their bytes, the
        script pointers (and the special calls' condition code pointers) left open."""
        en, de = self.en, self.de
        bank, start = self.sym["PhoneContacts"]
        _, special = self.sym["SpecialPhoneCallList"]
        contacts = (special - start) // PHONE_CONTACT_SIZE
        holes = {i * PHONE_CONTACT_SIZE + k for i in range(contacts) for k in (5, 6, 7, 9, 10, 11)}
        dbank, dstart = find_twin(en, de, (bank, start), contacts * PHONE_CONTACT_SIZE, holes)
        for i in range(contacts):
            e, d = start + PHONE_CONTACT_SIZE * i, dstart + PHONE_CONTACT_SIZE * i
            raw = [en.byte(bank, e + k) for k in range(PHONE_CONTACT_SIZE)]
            twin = [de.byte(dbank, d + k) for k in range(PHONE_CONTACT_SIZE)]
            cname, iname = trainers.get((raw[0], raw[1]), (str(raw[0]), str(raw[1])))
            who = {"trainer": cname, "id": iname}
            for k, role in ((5, "callee"), (9, "caller")):
                pe = (raw[k], raw[k + 1] | raw[k + 2] << 8)
                pd = (twin[k], twin[k + 1] | twin[k + 2] << 8)
                if pe[1]:
                    self.context = {"kind": "phone", "where": who}
                    self.walker.walk(pe, pd, ["phone", cname, iname, role])
        calls = len(re.findall(r"^\s*specialcall ", (self.pret_dir / "data/phone/special_calls.asm")
                               .read_text(encoding="utf-8"), re.M))
        holes = {i * SPECIAL_CALL_SIZE + k for i in range(calls) for k in (0, 1, 3, 4, 5)}
        sbank, sstart = find_twin(en, de, (bank, special), calls * SPECIAL_CALL_SIZE, holes)
        for i in range(calls):
            e, d = special + SPECIAL_CALL_SIZE * i, sstart + SPECIAL_CALL_SIZE * i
            pe = (en.byte(bank, e + 3), en.word(bank, e + 4))
            pd = (de.byte(sbank, d + 3), de.word(sbank, d + 4))
            self.context = {"kind": "phone", "where": {"special_call": i}}
            self.walker.walk(pe, pd, ["special call", str(i)])

    # -- text sections -----------------------------------------------------------------------

    def walk_sections(self):
        sections = read_sections(self.pret_dir / "pokecrystal.map")
        for name in TEXT_SECTIONS:
            self.pair_section(name, *sections[name])

    def pair_section(self, name, bank, start, end):
        """Pair a text section's texts by order, but only between proven pairs: the section start,
        the texts pointers already paired (scripts, phone, code), and Kristall's end (padding,
        "00 00"). A stretch whose count differs between the ROMs (Kristall splits a text) stays
        unpaired, with a note: an order pairing there would be a guess."""
        en_starts, ea = [], start
        while True:
            while self.en.byte(bank, ea) == 0x50 and ea <= end:  # a stray "@" (text_end) between texts:
                ea += 1                                            # pret has an unused one
            if ea > end:
                break
            en_starts.append(ea)
            ea += decode_text(self.en, bank, ea, PRET_CHARS, self.ram).length
        if ea != end + 1:
            raise LockstepError(f"{name}: texts end at {where((bank, ea))}, the section at {where((bank, end))}")

        def skip(da):  # Kristall's stray "@"s, after _BlindingFlashText and a few others
            while self.de.byte(bank, da) == 0x50:
                da += 1
            return da
        anchors = [(-1, None)]
        for i, ea in enumerate(en_starts):
            record = self.texts.get((bank, ea))
            if record is not None:
                db, da = (int(x, 16) for x in record["de_addr"].split(":"))
                if db != bank:
                    raise LockstepError(f'{name}: {record["label"]} was paired into bank {db:02x}')
                anchors.append((i, da))
        anchors.append((len(en_starts), "end"))
        for (i0, d0), (i1, d1) in zip(anchors, anchors[1:]):
            if i1 - i0 < 2:
                continue
            da = skip(start if d0 is None else d0 + decode_text(self.de, bank, d0, KRISTALL_CHARS, self.ram).length)
            twins = []
            try:
                for k in range(i0 + 1, i1):
                    parts = KRISTALL_SPLITS.get(self.labels.get((bank, en_starts[k])), 1)
                    twins.append(da if parts == 1 else None)
                    for _ in range(parts):
                        da = skip(da + decode_text(self.de, bank, da, KRISTALL_CHARS, self.ram).length)
            except ValueError:
                da = None
            lands = da is not None and (da == d1 if d1 != "end" else self.de.byte(bank, da) == 0 and
                                        self.de.byte(bank, da + 1) == 0)
            if not lands:
                self.notes.append(f"{name}: pret texts {i0 + 1}–{i1 - 1} don't line up with Kristall's "
                                  f"after {where((bank, d0 or start))}: unpaired")
                continue
            for k, twin in zip(range(i0 + 1, i1), twins):
                if twin is None:
                    label = self.labels.get((bank, en_starts[k]), where((bank, en_starts[k])))
                    self.notes.append(f"{name}: {label} is split in {KRISTALL_SPLITS[label]} texts in Kristall: unpaired")
                    continue
                record = self.add_text((bank, en_starts[k]), (bank, twin), [name, str(k)], by="order")
                record["kind"] = "section"

    # -- texts in code banks ------------------------------------------------------------------

    def walk_code_texts(self):
        """Runs of texts in code sections (battle texts, item texts, ...): a run starts where the 8
        bytes before it are equal in both ROMs and is paired by order (pair_run)."""
        names = pret_text_labels(self.pret_dir)
        starts = {self.sym[n] for n in names if n in self.sym and self.sym[n][0] and self.sym[n][1] >= 0x4000}
        sections = read_sections(self.pret_dir / "pokecrystal.map")
        in_sections = {(b, lo, hi) for n, (b, lo, hi) in sections.items() if n in TEXT_SECTIONS}
        label_starts = sorted({w for n, w in self.sym.items() if w[0] and w[1] >= 0x4000})
        done = set()
        for start in sorted(starts):
            bank, addr = start
            if start in done or any(b == bank and lo <= addr <= hi for b, lo, hi in in_sections):
                continue
            if not self.anchored(start, label_starts):
                continue
            run = pair_run(self.en, self.de, start, starts)
            if not run:
                self.notes.append(f"text run at {where(start)}: its end doesn't meet Kristall's")
                continue
            known = [(e, d) for e, d, *_ in run if e in self.texts and self.texts[e]["de_addr"] != where(d)
                     and where(d) not in [a["de_addr"] for a in self.texts[e]["de_alts"]]]
            if known:
                self.notes.append(f"text run at {where(start)}: disagrees with script pairs at {where(known[0][0])}")
                continue
            for e, d, *_ in run:
                done.add(e)
                fresh = e not in self.texts
                record = self.add_text(e, d, ["code", where(start)], kind="engine", by="order")
                if fresh:
                    record["kind"] = "engine"

    def anchored(self, start, label_starts):
        """A run may start at `start` (the same address in both ROMs) when what precedes it is in
        step: the 8 bytes before are equal, or the code from pret's previous label is the same
        instructions (code_in_step; calls into Kristall's shifted home bank may differ)."""
        o = self.en.offset(*start)
        if self.en.data[o - 8:o] == self.de.data[o - 8:o]:
            return True
        import bisect
        i = bisect.bisect_left(label_starts, start) - 1
        if i < 0 or label_starts[i][0] != start[0]:
            return False
        p = self.en.offset(*label_starts[i])
        return code_in_step(self.en.data[p:o], self.de.data[p:o + 2]) and self.en.data[p:o] != b""

    def fill_gaps(self):
        """pret's unused texts between two proven pairs (pair_gap)."""
        names = pret_text_labels(self.pret_dir)
        starts = {self.sym[n] for n in names if n in self.sym and self.sym[n][0] and self.sym[n][1] >= 0x4000}
        known = {}
        for e, t in self.texts.items():
            known[e] = tuple(int(x, 16) for x in t["de_addr"].split(":"))
        for e in sorted(known):
            record = self.texts[e]
            for ge, gd, *_ in pair_gap(self.en, self.de, e, known[e], starts, known):
                new = self.add_text(ge, gd, ["between pairs", record["label"]], kind=record["kind"], where_=None,
                                    by="order")
                new["where"] = None

    # -- tables ------------------------------------------------------------------------------

    def routine_twin(self, label, length, operand_opcode):
        """Kristall's copy of a pret routine (its first `length` bytes, the operand of the first
        `operand_opcode` instruction left open); returns (pret start, Kristall start, operand offset)."""
        start = self.sym[label]
        code = self.en.data[self.en.offset(*start):self.en.offset(*start) + length]
        at = code.index(operand_opcode)
        return start, find_twin(self.en, self.de, start, length, holes=(at + 1, at + 2)), at + 1

    def walk_tables(self):
        en, de = self.en, self.de
        species = 251
        # Pokédex: GetDexEntryPointer's table (ld hl, PokedexDataPointerTable) and the bank list
        # right after it (.PokedexEntryBanks, one bank per 64 species); Kristall moved both
        start = self.sym["GetDexEntryPointer"]
        length = self.sym["GetDexEntryPointer.PokedexEntryBanks"][1] - start[1]
        code = en.data[en.offset(*start):en.offset(*start) + length]
        holes = {i + k for i in range(length - 2) if code[i] == 0x21 for k in (1, 2)}  # ld hl, nn
        twin = find_twin(en, de, start, length, holes)
        en_banks = [en.byte(start[0], start[1] + length + k) for k in range(4)]
        de_banks = [de.byte(twin[0], twin[1] + length + k) for k in range(4)]
        tbank, en_table = self.sym["PokedexDataPointerTable"]
        de_table = de.word(twin[0], twin[1] + code.index(0x21) + 1)
        for s in range(1, species + 1):
            pe = (en_banks[(s - 1) >> 6], en.word(tbank, en_table + 2 * (s - 1)))
            pd = (de_banks[(s - 1) >> 6], de.word(twin[0], de_table + 2 * (s - 1)))
            self.add_table_text("dex", pe, pd, decode_dex, partial(decode_dex, measures=3))
        # move descriptions: the table PrintMoveDescription loads
        start, twin, at = self.routine_twin("PrintMoveDescription", 16, 0x21)
        en_table = (self.sym["MoveDescriptions"])
        de_table = (twin[0], de.word(*twin[:1], twin[1] + at))
        for m in range(species):
            pe = (en_table[0], en.word(en_table[0], en_table[1] + 2 * m))
            pd = (de_table[0], de.word(de_table[0], de_table[1] + 2 * m))
            self.add_table_text("move_desc", pe, pd, decode_lines)
        # item descriptions: the table PrintItemDescription.not_a_tm loads (ld hl, ItemDescriptions);
        # Kristall's sits elsewhere in the same bank, its texts with it
        start = self.sym["PrintItemDescription.not_a_tm"]
        length = self.sym["ItemDescriptions"][1] - start[1]
        code = en.data[en.offset(*start):en.offset(*start) + length]
        at = code.index(0x21) + 1
        jump = len(code) - 2  # jp PlaceString: home moved
        twin = find_twin(en, de, start, length, holes=(at, at + 1, jump, jump + 1))
        ibank, itable = self.sym["ItemDescriptions"]
        de_table = de.word(twin[0], twin[1] + at)
        for i in range(self.num_items):
            pe = (ibank, en.word(ibank, itable + 2 * i))
            pd = (twin[0], de.word(twin[0], de_table + 2 * i))
            self.add_table_text("item_desc", pe, pd, decode_lines)

    def add_table_text(self, kind, pe, pd, decode, de_decode=None):
        try:
            en = decode(self.en, *pe, PRET_CHARS)
            de = (de_decode or decode)(self.de, *pd, KRISTALL_CHARS)
        except ValueError as e:
            raise LockstepError(f"{kind} at {where(pe)} / {where(pd)}: {e}") from None
        if pe in self.texts:
            return
        self.texts[pe] = {
            "label": self.labels.get(pe, where(pe)), "kind": kind,
            "en_addr": where(pe), "de_addr": where(pd), "de_len": de.length, "path": [kind],
            "where": None, "en": en.commands, "de": de.commands,
            "structure_differs": False, "de_alts": [],
        }

    # -- names -------------------------------------------------------------------------------

    @property
    def num_items(self):
        items = read_constants(self.pret_dir / "constants" / "item_constants.asm")
        return max(v for v in items if v < 0x100)

    def read_name_tables(self, trainers):
        en, de, sym, c = self.en, self.de, self.sym, self.pret_dir / "constants"
        out = {}

        def table(key, constants, en_names, de_names, strip=""):
            out[key] = {constants[i].removeprefix(strip): [e, d]
                        for i, e, d in zip(sorted(constants), en_names, de_names)}

        # GetName's NamesPointers (home bank, 8 dba entries): Kristall moved it and some tables
        nb, na = sym["NamesPointers"]
        holes = {3 * e + k for e in (0, 1, 3, 6, 7) for k in range(3)}  # the entries naming a table
        twin = find_twin(en, de, (nb, na), 24, holes)

        def names_table(entry):
            e = (en.byte(nb, na + 3 * entry), en.word(nb, na + 3 * entry + 1))
            d = (de.byte(*twin[:1], twin[1] + 3 * entry), de.word(twin[0], twin[1] + 3 * entry + 1))
            return e, d

        mons = {v: n for v, n in read_constants(c / "pokemon_constants.asm").items() if 1 <= v <= 251}
        e, d = names_table(0)
        same(e, sym["PokemonNames"], "NamesPointers' PokemonNames entry")
        table("pokemon", mons, read_names(en, *e, 251, PRET_CHARS, 10), read_names(de, *d, 251, KRISTALL_CHARS, 10))
        moves = {v: n for v, n in read_constants(c / "move_constants.asm").items() if 1 <= v <= 251}
        e, d = names_table(1)
        table("moves", moves, read_names(en, *e, 251, PRET_CHARS), read_names(de, *d, 251, KRISTALL_CHARS))
        items = {v: n for v, n in read_constants(c / "item_constants.asm").items() if 1 <= v <= self.num_items}
        e, d = names_table(3)
        table("items", items, read_names(en, *e, len(items), PRET_CHARS),
              read_names(de, *d, len(items), KRISTALL_CHARS))
        classes = trainer_classes(self.pret_dir)
        e, d = names_table(6)
        table("trainer_classes", classes, read_names(en, *e, len(classes), PRET_CHARS),
              read_names(de, *d, len(classes), KRISTALL_CHARS))
        marks = {v: n for v, n in read_constants(c / "landmark_constants.asm").items() if 0 <= v < 0x7F}
        start, twin, at = self.routine_twin("GetLandmarkName", 16, 0x11)
        lb, la = start[0], en.word(start[0], start[1] + at)  # pret: ld de, Landmarks + 2
        kb, ka = twin[0], de.word(twin[0], twin[1] + at)
        en_names = [read_names(en, lb, en.word(lb, la + 4 * i), 1, PRET_CHARS)[0] for i in range(len(marks))]
        de_names = [read_names(de, kb, de.word(kb, ka + 4 * i), 1, KRISTALL_CHARS)[0] for i in range(len(marks))]
        table("landmarks", marks, en_names, de_names, strip="LANDMARK_")
        return out

    # -- coverage ----------------------------------------------------------------------------

    def unpaired_labels(self):
        """pret's text labels (from its source) with no pair, leaving out text_far stubs whose
        target is paired: a stub holds no words of its own."""
        paired = {t["label"] for t in self.texts.values()} | {
            a["label"] for t in self.texts.values() for a in t.get("de_alts", []) if "label" in a}
        targets = {t["en_addr"] for t in self.texts.values()}
        out = []
        for name in sorted(pret_text_labels(self.pret_dir)):
            if name not in self.sym or name in paired:
                continue
            bank, addr = self.sym[name]
            if not bank or addr < 0x4000 or self.labels.get((bank, addr), name) in paired:
                continue
            try:
                cmds = decode_text(self.en, bank, addr, PRET_CHARS, {}).commands
            except ValueError:
                cmds = []
            if [c[0] for c in cmds] == ["text_far", "text_end"] and where(cmds[0][1]) in targets:
                continue
            out.append(name)
        return out

    def result(self, names):
        texts = list(self.texts.values())
        return {"texts": texts, "names": names,
                "coverage": {"unreached_dump": unreached(dump_addresses(), texts),
                             "unpaired_labels": self.unpaired_labels()},
                "other_pointers": dict(self.other), "notes": self.notes}


def find_twin(en, de, start, length, holes=()):
    """Kristall's (bank, address) of pret's `length` bytes at `start`, the `holes` (offsets) open.
    It must match exactly once in Kristall's ROM."""
    code = en.data[en.offset(*start):en.offset(*start) + length]
    pattern = b"".join(b"." if i in holes else re.escape(code[i:i + 1]) for i in range(length))
    hits = [m.start() for m in re.finditer(pattern, de.data, re.S)]
    if len(hits) != 1:
        raise LockstepError(f"{len(hits)} matches in Kristall for {where(start)} ({code.hex(' ')})")
    bank = hits[0] // 0x4000
    return bank, hits[0] - bank * 0x4000 + (0x4000 if bank else 0)


def dump_addresses(path=DUMP):
    """The bank:address of every text in the dump's [texts] section ([] without the dump)."""
    if not Path(path).exists():
        return []
    out, inside = [], False
    for line in Path(path).read_text(encoding="utf-8").splitlines():
        if line.startswith("["):
            inside = line.strip() == "[texts]"
        elif inside and re.match(r"[0-9a-f]{2}:[0-9a-f]{4} ", line):
            out.append(line[:7])
    return out


def unreached(dump, texts):
    """Dump addresses no pair's Kristall text (or second twin) covers."""
    spans = []
    for t in texts:
        for twin in [t] + t.get("de_alts", []):
            bank, addr = (int(x, 16) for x in twin["de_addr"].split(":"))
            spans.append((bank, addr, addr + twin["de_len"]))
    out = []
    for item in dump:
        bank, addr = (int(x, 16) for x in item.split(":"))
        if not any(b == bank and lo <= addr < hi for b, lo, hi in spans):
            out.append(item)
    return out


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
    trainers = trainer_constants(b.pret_dir)
    b.walk_maps()
    b.walk_phone(trainers)
    b.walk_code_texts()  # first: its text_far stubs prove pairs that anchor the sections
    b.walk_sections()
    b.fill_gaps()
    b.walk_tables()
    return b.result(b.read_name_tables(trainers))


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
