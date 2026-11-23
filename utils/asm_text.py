#!/usr/bin/env python3
"""Polished's texts as its asm writes them: parse them into commands and render them back.

A text runs from its start to done, prompt, text_end, text_farend or text_asm. It starts at a
text command (text, text_ram, text_far, ...) after a label, or inline after a script command
(jumpthistext, generictrainer, ...), or at any string command (line, para, ...) right after a
label; either way its label is the nearest label above it. Labels
and stop_compressing_text inside a text are passed over: the text falls through.

Each file is read twice, as the Regular ROM and as the Faithful ROM assemble it (`if DEF(FAITHFUL)`
and the rest evaluated; `if DEF(DEBUG)` blocks left out). A text the same in both is one AsmText
with variant "both"; one that differs gives a "regular" and a "faithful" AsmText, with
partial_faithful set when the difference lies inside the text.

Commands are tuples, as kristall_rom.decode_text gives them: ("text", "Hello"), ("line", "…"),
("text_ram", "wStringBuffer1"), ("text_far", "_Label"), ("done",).
"""
import re
from collections import Counter, namedtuple
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DEFAULT_PATHS = ("maps", "data", "engine", "home")

# index: the text's place among the texts of its file with the same label and variant (a script
# label can hold several inline texts), so the same text is found again after lines moved
AsmText = namedtuple("AsmText", "label path start end variant commands partial_faithful index", defaults=(0,))

STRING_COMMANDS = {"text", "line", "cont", "para", "next", "next1", "page"}
STARTS = {"text", "text_start", "text_ram", "text_far", "text_farend", "text_decimal", "text_promptbutton",
          "text_today", "text_plural", "text_pause", "text_sound"}
INLINE = {"text_start", "text_ram", "text_promptbutton", "text_decimal", "text_pause", "text_sound",
          "text_today", "text_far", "text_plural"}
ENDS = {"done", "prompt", "text_end", "text_farend", "text_asm"}
# inline commands that print nothing but change how the text plays: a pause, a wait for a button,
# a sound (Polished's text_sound SFX_…, pret's sound_item, sound_dex_fanfare_50_79, …), pret's
# text_low (Polished has none)
MARKS = {"text_pause", "text_promptbutton", "text_sound", "text_low"}


def mark(command):
    """The kind of a MARKS command ("sound" for every sound), else None."""
    if command[0] == "text_sound" or command[0].startswith("sound_"):
        return "sound"
    return command[0] if command[0] in MARKS else None
PASS_OVER = {"stop_compressing_text", "assert", "static_assert"}  # passed over inside a text

LABEL = re.compile(r"^(\.?[A-Za-z_][\w.]*)::?")
COMMAND = re.compile(r"^\s+(\w+)\b\s*(.*)$")
STRING = re.compile(r'"((?:[^"\\]|\\.)*)"')


def strip_comment(line):
    in_string = False
    for i, char in enumerate(line):
        if char == '"':
            in_string = not in_string
        elif char == ";" and not in_string:
            return line[:i]
    return line


def condition(expr, defined):
    """Evaluate an `if` expression of DEF(...) terms, !, && and ||; numbers too. None if unknown."""
    expr = expr.strip()
    py = re.sub(r"DEF\((\w+)\)", lambda m: str(m.group(1) in defined), expr)
    py = py.replace("&&", " and ").replace("||", " or ")
    py = re.sub(r"!(?!=)", " not ", py)
    if not re.fullmatch(r"[\s()TrueFalsnotdi0-9]*", py):
        return None
    try:
        return bool(eval(py, {"__builtins__": {}}))  # only booleans, numbers and and/or/not
    except SyntaxError:
        return None


def assemble(lines, defined):
    """The (line number, line) pairs a build assembles, given the defined symbols."""
    out, stack = [], []  # stack: [this branch taken, some branch taken, parent active]
    for number, line in enumerate(lines, 1):
        code = strip_comment(line).strip()
        if m := re.match(r"if\s+(.*)$", code):
            active = all(s[0] for s in stack)
            value = condition(m.group(1), defined)
            value = True if value is None else value
            stack.append([value, value, active])
        elif (m := re.match(r"elif\s+(.*)$", code)) and stack:
            value = condition(m.group(1), defined)
            value = (True if value is None else value) and not stack[-1][1]
            stack[-1][0] = value
            stack[-1][1] = stack[-1][1] or value
        elif code == "else" and stack:
            stack[-1][0] = not stack[-1][1]
            stack[-1][1] = True
        elif code == "endc" and stack:
            stack.pop()
        elif all(s[0] for s in stack):
            out.append((number, line))
    return out


def ends(command):
    """True if a command ends its text: an ending command, or a string closed by "@" (a text
    printed with PlaceString, a Pokédex entry)."""
    return command[0] in ENDS or (command[0] in STRING_COMMANDS and command[1].endswith("@"))


def parse_command(code, dex=False):
    """(command, operands) of one code line, or None. In a Pokédex file, `db "Seed@"` is the
    entry's ("category", "Seed")."""
    m = COMMAND.match(code)
    if not m:
        return None
    name, rest = m.group(1), m.group(2).strip()
    if dex and name == "db" and (strings := STRING.findall(rest)):
        return ("category", strings[0].rstrip("@"))
    if name in STRING_COMMANDS:
        strings = STRING.findall(rest)
        return (name, "".join(strings)) if strings else (name, "")
    if name == "text_farend":
        return (name, rest)
    if name in ENDS or name in PASS_OVER:
        return (name,)
    if name in INLINE:
        return (name, *[x.strip() for x in rest.split(",") if x.strip()])
    return (name,)


def texts_in(numbered, path):
    """The texts in one assembled view of a file: [(label, start, end, commands)]."""
    dex = path.endswith("dex_entries.asm")
    starts, label, previous = [], None, None
    for i, (number, line) in enumerate(numbered):
        code = strip_comment(line).rstrip()
        if not code.strip():
            continue
        if m := LABEL.match(code):
            name = m.group(1)
            label = f"{label.split('.')[0]}{name}" if name.startswith(".") and label else name
            previous = "label"
            code = code[m.end():]
            if not code.strip():
                continue
            code = "\t" + code.strip()
        command = parse_command(code, dex)
        if command is None:
            previous = None
            continue
        # a text starts at a text command, or at any string command right after a label (radio
        # texts open with `line`, printed on the box's second row)
        opens = command[0] in STARTS or command[0] == "category" or \
            (previous == "label" and command[0] in STRING_COMMANDS)
        if opens and previous != "text":
            starts.append((i, label))
        previous = "text" if command[0] in STRING_COMMANDS | INLINE | ENDS | PASS_OVER | {"category"} else None
        if ends(command):
            previous = None
    out = []
    for i, label in starts:
        commands = []
        for number, line in numbered[i:]:
            code = strip_comment(line).rstrip()
            if m := LABEL.match(code):
                code = code[m.end():]
                if not code.strip():
                    continue
                code = "\t" + code.strip()
            command = parse_command(code, dex)
            if command is None or command[0] in PASS_OVER:
                continue
            if command[0] not in STRING_COMMANDS | INLINE | ENDS and not (command[0] == "category" and not commands):
                break  # code or data after an unterminated text
            commands.append(command)
            if ends(command):
                break
        out.append((label or path, numbered[i][0], number, commands))
    return out


def parse_file(path, root=ROOT, source=None):
    """AsmTexts of one file (path relative to root); source(path) -> text, else read from disk."""
    rel = Path(path).as_posix()
    text = source(rel) if source else (Path(root) / rel).read_text(encoding="utf-8")
    lines = text.splitlines()
    if "text" not in text and '"' not in text:  # no text command and no string: nothing to parse
        return []
    regular = {(lab, start): (end, cmds) for lab, start, end, cmds in texts_in(assemble(lines, set()), rel)}
    faithful = {(lab, start): (end, cmds) for lab, start, end, cmds in texts_in(assemble(lines, {"FAITHFUL"}), rel)}
    out, seen = [], Counter()

    def add(label, start, end, variant, commands, partial):
        out.append(AsmText(label, rel, start, end, variant, commands, partial, seen[(label, variant)]))
        seen[(label, variant)] += 1
    for key in sorted(regular.keys() | faithful.keys(), key=lambda k: k[1]):
        label, start = key
        r, f = regular.get(key), faithful.get(key)
        if r and f and r[1] == f[1]:
            add(label, start, r[0], "both", r[1], False)
            continue
        partial = bool(r and f)
        if r:
            add(label, start, r[0], "regular", r[1], partial)
        if f:
            add(label, start, f[0], "faithful", f[1], partial)
    return out


def iter_texts(root=ROOT, paths=DEFAULT_PATHS, source=None, files=None):
    """Every AsmText under the given paths (relative to root). `files` lists the files to read
    (relative paths) when they don't come from the disk, as with `source` reading git."""
    root = Path(root)
    if files is None:
        files = sorted({p.relative_to(root).as_posix() for d in paths
                        for p in ([root / d] if (root / d).is_file() else (root / d).rglob("*.asm"))})
    for rel in files:
        yield from parse_file(rel, root, source)


def render(commands):
    """The asm lines of a text's commands, tab-indented."""
    out = []
    for c in commands:
        if c[0] in STRING_COMMANDS:
            out.append(f'\t{c[0]} "{c[1]}"')
        elif c[0] == "category":
            out.append(f'\tdb "{c[1]}@"')
        elif len(c) > 1:
            out.append(f"\t{c[0]} {', '.join(str(x) for x in c[1:])}")
        else:
            out.append(f"\t{c[0]}")
    return out
