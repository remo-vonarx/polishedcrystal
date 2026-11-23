#!/usr/bin/env python3
"""Read pret's English Crystal and Pokémon Kristall-Edition: ROM bytes, symbols, macro tables, texts.

Shared by the Kristall tools (kristall_pairs.py and the rest). Everything here reads; nothing writes.

- Rom: banked access to a ROM file.
- read_sym / labels_at / ram_names: pret's .sym (labels by bank and address).
- read_sections: pret's .map (section name -> bank, start, end).
- read_macros: command tables from pret's macros/scripts/{text,events}.asm, so the command set
  is never typed in by hand.
- PRET_CHARS, KRISTALL_CHARS: tile id -> glyph or <TOKEN>, as pret's asm writes them.
- decode_text: one text as a list of commands, the way asm writes it:
  [("text", "OAK: Aha! So"), ("line", "you're <PLAY_G>!"), ..., ("done",)]
"""
import re
from collections import namedtuple
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PRET = Path.home() / "Development" / "pokecrystal"
KRISTALL_ROM = ROOT / ".claude" / "upload" / "Pokemon - Kristall-Edition (Germany).gbc"
PAIRS_JSON = ROOT / ".claude" / "upload" / "kristall_pairs.json"

BANK_SIZE = 0x4000

Macro = namedtuple("Macro", "name operands")
Operand = namedtuple("Operand", "size note")
Text = namedtuple("Text", "commands length")


class Rom:
    def __init__(self, path):
        self.path = Path(path)
        self.data = self.path.read_bytes()

    def offset(self, bank, addr):
        return addr if addr < BANK_SIZE else bank * BANK_SIZE + addr - BANK_SIZE

    def byte(self, bank, addr):
        return self.data[self.offset(bank, addr)]

    def word(self, bank, addr):
        return self.byte(bank, addr) | self.byte(bank, addr + 1) << 8


def read_sym(path):
    """Label -> (bank, address)."""
    sym = {}
    for line in Path(path).read_text(encoding="utf-8").splitlines():
        if m := re.match(r"([0-9a-f]{2}):([0-9a-f]{4}) (\S+)", line, re.I):
            sym.setdefault(m.group(3), (int(m.group(1), 16), int(m.group(2), 16)))
    return sym


def labels_at(sym):
    """(bank, address) -> the first label there that isn't a local one."""
    out = {}
    for name, where in sym.items():
        if "." not in name:
            out.setdefault(where, name)
    return out


def ram_names(sym):
    """RAM address ($C000-$FFFF) -> label, the first global label at each address."""
    out = {}
    for name, (_, addr) in sym.items():
        if addr >= 0xC000 and "." not in name:
            out.setdefault(addr, name)
    return out


def read_sections(map_path):
    """Section name -> (bank, start, end) from an rgblink .map file."""
    sections, bank = {}, None
    for line in Path(map_path).read_text(encoding="utf-8").splitlines():
        if m := re.match(r"ROMX? bank #(\d+):", line):
            bank = int(m.group(1))
        elif m := re.match(r'\s+SECTION: \$([0-9a-f]{4})(?:-\$([0-9a-f]{4}))? \(\$[0-9a-f]+ bytes?\) \["(.+)"\]',
                           line, re.I):
            start = int(m.group(1), 16)
            end = int(m.group(2), 16) if m.group(2) else start
            sections[m.group(3)] = (bank, start, end)
    return sections


OPERAND_LINE = re.compile(r"\s*(db|dw|dba|dn|dwb|dbw)\s+([^;]*?)\s*(?:;\s*(.*))?$")

# Macros used inside a command macro for its operands (pret's macros/scripts/maps.asm, legacy.asm)
SUB_MACROS = {"map_id": ["db", "db"], "bigdt": ["db", "db", "db"]}

# Macros whose operands depend on `if`/`_NARG`: their full form, by hand (pret's events.asm).
# givepoke adds two pointers (nickname, OT name: strings, not texts) when its 4th byte is nonzero;
# the script interpreter reads those itself.
HAND_OPERANDS = {
    "loadvar": [Operand("db", "variable_id"), Operand("db", "value")],
    "giveitem": [Operand("db", "item"), Operand("db", "quantity")],
    "takeitem": [Operand("db", "item"), Operand("db", "quantity")],
    "givepoke": [Operand("db", "pokemon"), Operand("db", "level"), Operand("db", "item"),
                 Operand("db", "trainer")],
    "reanchormap": [Operand("db", "dummy")],
    "verbosegiveitem": [Operand("db", "item"), Operand("db", "quantity")],
}


def read_macros(asm_path):
    """Command id -> Macro, for every `const X` whose MACRO writes `db X`.

    A macro's operands are its later db/dw/dba/dn/dwb lines, one Operand per comma-separated
    item (dn packs two items into one byte: one Operand), each with the line's comment as note.
    A macro with `if`/`rept` in its body takes its operands from HAND_OPERANDS, else it's an error.
    Constants count from const_def (0) and const_next; a "; $xx" comment must agree."""
    macros, consts, value = {}, {}, 0
    lines = Path(asm_path).read_text(encoding="utf-8").splitlines()
    i = 0
    while i < len(lines):
        line = lines[i]
        if m := re.match(r"\s*const_def\s*(\d*)", line):
            value = int(m.group(1) or 0)
        elif m := re.match(r"\s*const_next\s+\$([0-9a-f]+)", line, re.I):
            value = int(m.group(1), 16)
        elif m := re.match(r"\s*const\s+(\w+)(?:\s*;\s*\$([0-9a-f]+))?", line, re.I):
            if m.group(2) and int(m.group(2), 16) != value:
                raise ValueError(f"{asm_path}:{i + 1}: {m.group(1)} is ${value:02x}, comment says ${m.group(2)}")
            consts[m.group(1)] = value
            value += 1
        elif m := re.match(r"MACRO\s+(\w+)", line):
            name, body = m.group(1), []
            i += 1
            while not lines[i].strip().startswith("ENDM"):
                body.append(lines[i])
                i += 1
            heads = [h for b in body if (h := re.match(r"\s*db\s+(\w+)\s*$", b.split(";")[0]))
                     and h.group(1) in consts]
            if heads:
                command = consts[heads[0].group(1)]
                if any(re.match(r"\s*(if|rept|for)\b", b, re.I) for b in body):
                    if name not in HAND_OPERANDS:
                        raise ValueError(f"{asm_path}: {name} has conditional operands; list it in HAND_OPERANDS")
                    macros[command] = Macro(name, HAND_OPERANDS[name])
                else:
                    operands = []
                    for b in body[1:]:
                        if om := OPERAND_LINE.match(b):
                            size, items, note = om.group(1), om.group(2), om.group(3) or ""
                            count = 1 if size == "dn" else len([x for x in items.split(",") if x.strip()])
                            operands += [Operand(size, note.strip())] * count
                        elif (sm := re.match(r"\s*(\w+)\b[^;]*(?:;\s*(.*))?$", b)) and sm.group(1) in SUB_MACROS:
                            operands += [Operand(size, (sm.group(2) or "").strip()) for size in SUB_MACROS[sm.group(1)]]
                        elif b.split(";")[0].strip():
                            raise ValueError(f"{asm_path}: {name}: can't read operand line {b.strip()!r}")
                    macros[command] = Macro(name, operands)
        i += 1
    return macros


def read_charmap(path):
    """Tile id -> name from the main charmap (before the first pushc), first non-kana name wins."""
    chars = {}
    text = Path(path).read_text(encoding="utf-8").split("pushc")[0]
    for name, value in re.findall(r'^\s*charmap\s+"(.+?)",\s*\$([0-9a-f]{2})\b', text, re.M | re.I):
        if any("　" <= c <= "ヿ" or "＀" <= c <= "￯" for c in name):
            continue
        chars.setdefault(int(value, 16), name)
    return chars


PRET_CHARS = read_charmap(PRET / "constants" / "charmap.asm") if PRET.exists() else {}

# Kristall's letters differ from pret's English only here (.claude/upload/dump_german_text.py)
KRISTALL_CHARS = {**PRET_CHARS, **{
    0xBA: "à", 0xBB: "è", 0xBC: "é", 0xBD: "ù", 0xBE: "ß", 0xBF: "ç",
    0xC0: "Ä", 0xC1: "Ö", 0xC2: "Ü", 0xC3: "ä", 0xC4: "ö", 0xC5: "ü", 0xC6: "ë", 0xC7: "ï",
    0xC8: "â", 0xC9: "ô", 0xCA: "û", 0xCB: "ê", 0xCC: "î", 0xF2: "<DOT>",
    0xE4: "+",  # blank in pret's font; Kristall draws a plus (move descriptions: "Verfehlt evtl. + …")
}}

TEXT_MACROS = read_macros(PRET / "macros" / "scripts" / "text.asm") if PRET.exists() else {}

STRING_START = 0x00  # TX_START
TERMINATOR = 0x50  # "@": ends a string
LINE_COMMANDS = {0x4E: "next", 0x4F: "line", 0x51: "para", 0x55: "cont"}
TEXT_ENDS = {0x57: "done", 0x58: "prompt"}
ENDING_COMMANDS = {"text_end", "text_asm"}
RAM_OPERANDS = {"text_ram", "text_bcd", "text_decimal"}


def _string(rom, offset, chars, out, first="text"):
    """Read one string from offset into out; return (offset after it, True if it ended the text)."""
    command, buf = first, []
    while True:
        b = rom.data[offset]
        offset += 1
        if b == TERMINATOR:
            out.append((command, "".join(buf)))
            return offset, False
        if b in LINE_COMMANDS:
            out.append((command, "".join(buf)))
            command, buf = LINE_COMMANDS[b], []
        elif b in TEXT_ENDS:
            out.append((command, "".join(buf)))
            out.append((TEXT_ENDS[b],))
            return offset, True
        else:
            buf.append(chars.get(b, f"<${b:02x}>"))


def decode_text(rom, bank, addr, chars, ram):
    """Decode the text at bank:addr. RAM operands are named by `ram` (address -> label)."""
    start = offset = rom.offset(bank, addr)
    commands = []
    while True:
        cmd = rom.data[offset]
        offset += 1
        if cmd == STRING_START:
            offset, ended = _string(rom, offset, chars, commands)
            if ended:
                break
            continue
        macro = TEXT_MACROS.get(cmd)
        if macro is None:
            raise ValueError(f"unknown text command ${cmd:02x} at {bank:02x}:{addr + offset - start - 1:04x} "
                             f"(text at {bank:02x}:{addr:04x})")
        values = []
        for operand in macro.operands:
            if operand.size == "dw":
                values.append(rom.data[offset] | rom.data[offset + 1] << 8)
                offset += 2
            else:
                values.append(rom.data[offset])
                offset += 1
        if macro.name == "text_far":
            commands.append(("text_far", (values[1], values[0])))
        elif macro.name in RAM_OPERANDS:
            commands.append((macro.name, ram.get(values[0], f"${values[0]:04x}"), *values[1:]))
        else:
            commands.append((macro.name, *values))
        if macro.name in ENDING_COMMANDS:
            break
    return Text(commands, offset - start)


def _glyph(rom, offset, chars):
    b = rom.data[offset]
    if b not in chars:
        raise ValueError(f"byte ${b:02x} isn't a letter (offset {offset:#x})")
    return chars[b]


def decode_lines(rom, bank, addr, chars):
    """A move or item description: lines split by <NEXT>, ending at "@"."""
    start = offset = rom.offset(bank, addr)
    commands, command, buf = [], "text", []
    while True:
        b = rom.data[offset]
        offset += 1
        if b == TERMINATOR:
            commands.append((command, "".join(buf)))
            return Text(commands, offset - start)
        if b == 0x4E:  # <NEXT>
            commands.append((command, "".join(buf)))
            command, buf = "next", []
        else:
            buf.append(_glyph(rom, offset - 1, chars))
        if offset - start > 200:
            raise ValueError(f"no end of description at {bank:02x}:{addr:04x}")


def decode_dex(rom, bank, addr, chars):
    """A Pokédex entry: its category up to "@", height and weight (4 bytes), then two pages of
    lines split by <NEXT>, the first page ending at "@" and the second at "@"."""
    start = offset = rom.offset(bank, addr)
    category = []
    while rom.data[offset] != TERMINATOR:
        category.append(_glyph(rom, offset, chars))
        offset += 1
        if len(category) > 12:
            raise ValueError(f"no end of category at {bank:02x}:{addr:04x}")
    offset += 1 + 4  # "@", height, weight
    commands, command, buf, pages = [("category", "".join(category))], "text", [], 0
    while True:
        b = rom.data[offset]
        offset += 1
        if b in (TERMINATOR, 0x4E):
            commands.append((command, "".join(buf)))
            buf = []
            if b == 0x4E:
                command = "next"
            else:
                pages += 1
                if pages == 2:
                    return Text(commands, offset - start)
                command = "page"
        else:
            buf.append(_glyph(rom, offset - 1, chars))
        if offset - start > 300:
            raise ValueError(f"no end of Pokédex entry at {bank:02x}:{addr:04x}")


def read_names(rom, bank, addr, count, chars, width=None):
    """`count` names from bank:addr: each `width` bytes (padded with "@"), or "@"-terminated."""
    names, offset = [], rom.offset(bank, addr)
    for _ in range(count):
        buf, i = [], offset
        while rom.data[i] != TERMINATOR and (width is None or i - offset < width):
            buf.append(_glyph(rom, i, chars))
            i += 1
        names.append("".join(buf))
        offset = offset + width if width else i + 1
    return names


def read_constants(path):
    """value -> constant name, for `const` lines counted from const_def (start and step)."""
    names, value, step = {}, 0, 1
    for line in Path(path).read_text(encoding="utf-8").splitlines():
        if m := re.match(r"\s*const_def\s*(-?\$?[0-9a-f]*)\s*(?:,\s*(-?\d+))?", line, re.I):
            v = m.group(1) or "0"
            value = -int(v[2:], 16) if v.startswith("-$") else int(v[1:], 16) if v.startswith("$") else int(v)
            step = int(m.group(2) or 1)
        elif re.match(r"\s*const_skip\b", line):
            value += step
        elif m := re.match(r"\s*const\s+(\w+)", line):
            names.setdefault(value, m.group(1))
            value += step
    return names
