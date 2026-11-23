"""Tests of the Kristall tools (utils/kristall_*.py). ROM tests skip when a ROM is missing."""
from kristall_rom import (KRISTALL_CHARS, PRET, PRET_CHARS, decode_text, ram_names, read_macros,
                          read_sym)


def test_macros_read_from_pret():
    text = read_macros(PRET / "macros/scripts/text.asm")
    assert text[0x01].name == "text_ram" and [o.size for o in text[0x01].operands] == ["dw"]
    events = read_macros(PRET / "macros/scripts/events.asm")
    assert len(events) == 170 and events[0x06].name == "ifequal"
    assert [o.size for o in events[0x06].operands] == ["db", "dw"]


def test_decode_pret_text(pret_rom):
    sym = read_sym(PRET / "pokecrystal.sym")
    bank, addr = sym["MrPokemonsHouse_OakText1"]
    t = decode_text(pret_rom, bank, addr, PRET_CHARS, ram_names(sym))
    assert t.commands[:3] == [("text", "OAK: Aha! So"), ("line", "you're <PLAY_G>!"),
                              ("para", "I'm OAK! A #MON")]


def test_decode_pret_text_ram(pret_rom):
    sym = read_sym(PRET / "pokecrystal.sym")
    bank, addr = sym["ReceivedStarterText"]
    t = decode_text(pret_rom, bank, addr, PRET_CHARS, ram_names(sym))
    assert t.commands == [("text", "<PLAYER> received"), ("line", ""), ("text_ram", "wStringBuffer3"),
                          ("text", "!"), ("done",)]


def test_decode_kristall_text(kristall_rom):
    t = decode_text(kristall_rom, 0x69, 0x5A91, KRISTALL_CHARS, {})
    assert t.commands == [("text", "<PLAYER> übergibt"), ("line", "das #MON, das"),
                          ("cont", "den BRIEF trägt."), ("done",)]
