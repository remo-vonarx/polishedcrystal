#!/usr/bin/env python3
"""Interpret a map script in pret's English ROM and in Kristall at once.

The two ROMs share their scripts byte for byte except for pointers (Kristall's texts are longer,
so what follows them moves). The Walker reads a script command by command in both: the command
byte and every operand that isn't a pointer must be equal, pointer operands are paired. It follows
the script pointers itself and hands every other pointer (texts, strings, menus, movements, data,
code) to `visit(kind, en_ptr, de_ptr, path)`, each pointer as (bank, address).
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))  # python3 -I leaves the script's directory out

from kristall_rom import PRET, read_macros  # noqa: E402

EVENT_COMMANDS = read_macros(PRET / "macros" / "scripts" / "events.asm") if PRET.exists() else {}

# What a pointer operand leads to, by command and operand index. Everything not listed is compared.
SCRIPT, TEXT, STRING, MENU, MOVEMENT, DATA, CODE = "script", "text", "string", "menu", "movement", "data", "code"
POINTERS = {
    "scall": {0: SCRIPT}, "farscall": {0: SCRIPT}, "sjump": {0: SCRIPT}, "farsjump": {0: SCRIPT},
    "ifequal": {1: SCRIPT}, "ifnotequal": {1: SCRIPT}, "iffalse": {0: SCRIPT}, "iftrue": {0: SCRIPT},
    "ifgreater": {1: SCRIPT}, "ifless": {1: SCRIPT}, "sdefer": {0: SCRIPT}, "stopandsjump": {0: SCRIPT},
    "writetext": {0: TEXT}, "jumptext": {0: TEXT}, "jumptextfaceplayer": {0: TEXT},
    "farwritetext": {0: TEXT}, "farjumptext": {0: TEXT}, "winlosstext": {0: TEXT, 1: TEXT},
    "getstring": {0: STRING}, "phonecall": {0: STRING}, "checkpokemail": {0: STRING},
    "loadmenu": {0: MENU},
    "applymovement": {1: MOVEMENT}, "applymovementlasttalked": {0: MOVEMENT},
    "givepokemail": {0: DATA}, "xycompare": {0: DATA}, "elevator": {0: DATA},
    "writecmdqueue": {0: DATA}, "autoinput": {0: DATA}, "changemapblocks": {0: DATA},
    "callasm": {0: CODE}, "memcallasm": {0: CODE},
}
# Commands after which a branch doesn't go on.
ENDS = {"end", "endcallback", "reloadend", "endall", "sjump", "farsjump", "memjump", "jumptext",
        "jumptextfaceplayer", "farjumptext", "jumpstd", "stopandsjump", "halloffame", "credits",
        "fruittree", "describedecoration"}
# Commands that jump into an engine script at a fixed pret label (the same address in Kristall).
ENGINE_SCRIPTS = {"fruittree": "FruitTreeScript"}
STD_CALLS = {"callstd", "jumpstd"}


class LockstepError(Exception):
    """The two ROMs disagree where they must be equal."""


def where(pointer):
    bank, addr = pointer
    return f"{bank:02x}:{addr:04x}"


class Walker:
    """Walks scripts in both ROMs; remembers every pret script it has seen, across walks."""

    def __init__(self, en, de, visit, std=None, engine=None):
        """std: StdScripts' (bank, address); engine: command -> (bank, address) of ENGINE_SCRIPTS."""
        self.en, self.de, self.visit, self.std, self.engine = en, de, visit, std, engine or {}
        self.seen = {}  # pret script pointer -> its Kristall twins
        self.code = set()  # pret code pointers met (callasm), counted, not followed

    def pair(self, en_ptr, de_ptr, path):
        """Remember a script pair; False if it was seen before.

        One pret script can have two Kristall twins: Kristall moved some maps to other banks and
        gave them their own copy of a script pret shares across maps (Route 36's gate sign uses
        Route 35's script in pret, a copy in Kristall). A new twin is walked like the first, so it
        must match pret's script command by command too."""
        twins = self.seen.setdefault(en_ptr, set())
        if de_ptr in twins:
            return False
        twins.add(de_ptr)
        return True

    def walk(self, start_en, start_de, path=()):
        work = [(start_en, start_de, list(path) or [where(start_en)])]
        while work:
            en_ptr, de_ptr, trail = work.pop()
            if self.pair(en_ptr, de_ptr, trail):
                work.extend(self._branch(en_ptr, de_ptr, trail))

    def _read(self, rom, bank, addr, size):
        if size == "dw":
            return rom.word(bank, addr), 2
        if size == "dba":
            return (rom.byte(bank, addr), rom.word(bank, addr + 1)), 3
        if size == "dbw":
            return (rom.byte(bank, addr), rom.word(bank, addr + 1)), 3
        if size == "dwb":
            return (rom.word(bank, addr), rom.byte(bank, addr + 2)), 3
        return rom.byte(bank, addr), 1

    def _branch(self, en_ptr, de_ptr, trail):
        """Run one script until its branch ends; return the script pairs it jumps to."""
        (bank, ea), (dbank, da) = en_ptr, de_ptr
        follow = []
        while True:
            here = f"{where((bank, ea))}/{where((dbank, da))}"
            ce, cd = self.en.byte(bank, ea), self.de.byte(dbank, da)
            if ce != cd:
                raise LockstepError(f"command ${ce:02x} against ${cd:02x} at {here} ({' > '.join(trail)})")
            macro = EVENT_COMMANDS.get(ce)
            if macro is None:
                raise LockstepError(f"unknown command ${ce:02x} at {here} ({' > '.join(trail)})")
            ea, da = ea + 1, da + 1
            pointers = POINTERS.get(macro.name, {})
            values = []
            for i, operand in enumerate(macro.operands):
                ve, n = self._read(self.en, bank, ea, operand.size)
                vd, _ = self._read(self.de, dbank, da, operand.size)
                ea, da = ea + n, da + n
                kind = pointers.get(i)
                if kind is None:
                    if ve != vd:
                        raise LockstepError(f"{macro.name} operand {i}: {ve!r} against {vd!r} at {here} "
                                            f"({' > '.join(trail)})")
                    values.append(ve)
                    continue
                pe = ve if operand.size == "dba" else (bank, ve)
                pd = vd if operand.size == "dba" else (dbank, vd)
                step = trail + [f"{macro.name}@{where(pe)}"]
                if kind == SCRIPT:
                    follow.append((pe, pd, step))
                elif kind == CODE:
                    self.code.add(pe)
                else:
                    self.visit(kind, pe, pd, step)
            if macro.name == "givepoke" and values[3]:  # nickname and OT name follow
                for _ in range(2):
                    pe, pd = (bank, self.en.word(bank, ea)), (dbank, self.de.word(dbank, da))
                    self.visit(STRING, pe, pd, trail + [f"givepoke@{where(pe)}"])
                    ea, da = ea + 2, da + 2
            if macro.name in STD_CALLS and self.std:
                sbank, saddr = self.std
                entry = saddr + 3 * values[0]
                target = (self.en.byte(sbank, entry), self.en.word(sbank, entry + 1))
                twin = (self.de.byte(sbank, entry), self.de.word(sbank, entry + 1))
                follow.append((target, twin, trail + [f"{macro.name} {values[0]}"]))
            if macro.name in self.engine:
                target = self.engine[macro.name]
                follow.append((target, target, trail + [macro.name]))
            if macro.name in ENDS:
                return follow


def walk_script(en, de, start_en, start_de, visit, std=None):
    """Walk one script and everything it reaches; see Walker."""
    Walker(en, de, visit, std).walk(start_en, start_de)
