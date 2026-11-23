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


# --- Task 2: the lockstep walk -------------------------------------------------------------

import pytest  # noqa: E402

from kristall_rom import Rom  # noqa: E402
from kristall_script import EVENT_COMMANDS, LockstepError, walk_script  # noqa: E402

COMMAND_ID = {m.name: i for i, m in EVENT_COMMANDS.items()}
IFEQUAL, JUMPTEXT, SCALL, END = (COMMAND_ID[n] for n in ("ifequal", "jumptext", "scall", "end"))


def fake_rom(chunks):
    """A two-bank Rom with the given bytes at the given bank-1 addresses."""
    data = bytearray(0x8000)
    for addr, values in chunks.items():
        data[addr:addr + len(values)] = bytes(values)
    rom = Rom.__new__(Rom)
    rom.path, rom.data = None, bytes(data)
    return rom


def by_label(pairs, label):
    return next(p for p in pairs["texts"] if p["label"] == label)


def test_dump_gaps_are_paired(pairs):
    oak = by_label(pairs, "MrPokemonsHouse_OakText1")
    bank, addr = (int(x, 16) for x in oak["de_addr"].split(":"))
    assert bank == 0x65 and 0x7800 <= addr < 0x7900 and oak["where"]["map"] == "MR_POKEMONS_HOUSE"
    assert by_label(pairs, "Text_Route31ReadingMail")["de_addr"] == "69:5abc"  # profile said 5acd


def test_map_text_pairs_with_dump(pairs):
    p = by_label(pairs, "Text_Route31HandOverMailMon")
    assert p["de_addr"] == "69:5a91" and p["de"][0] == ("text", "<PLAYER> übergibt")


def test_shared_text_pairs_once(pairs):  # Review Focus 1
    labels = [p["label"] for p in pairs["texts"]]
    assert len(labels) == len(set(labels))


def test_lockstep_mismatch_stops():
    en = fake_rom({0x4000: [IFEQUAL, 3, 0x00, 0x50, END]})  # ifequal 3, $5000 / end
    de = fake_rom({0x4000: [IFEQUAL, 4, 0x00, 0x50, END]})  # the compared byte differs
    with pytest.raises(LockstepError):
        walk_script(en, de, (1, 0x4000), (1, 0x4000), lambda *a: None)


def test_pointer_operands_are_paired_not_compared():
    en = fake_rom({0x4000: [JUMPTEXT, 0x10, 0x40]})
    de = fake_rom({0x4000: [JUMPTEXT, 0x20, 0x40]})
    seen = []
    walk_script(en, de, (1, 0x4000), (1, 0x4000), lambda kind, e, d, path: seen.append((kind, e, d)))
    assert seen == [("text", (1, 0x4010), (1, 0x4020))]


def test_second_kristall_twin_must_match():
    en = fake_rom({0x4000: [SCALL, 0x10, 0x40, SCALL, 0x10, 0x40, END], 0x4010: [END]})
    de = fake_rom({0x4000: [SCALL, 0x10, 0x40, SCALL, 0x20, 0x40, END], 0x4010: [END],
                   0x4020: [JUMPTEXT, 0x00, 0x50]})  # the second twin isn't pret's script
    with pytest.raises(LockstepError):
        walk_script(en, de, (1, 0x4000), (1, 0x4000), lambda *a: None)


def test_second_kristall_twin_is_walked():
    en = fake_rom({0x4000: [SCALL, 0x10, 0x40, SCALL, 0x10, 0x40, END], 0x4010: [JUMPTEXT, 0x00, 0x50]})
    de = fake_rom({0x4000: [SCALL, 0x10, 0x40, SCALL, 0x20, 0x40, END], 0x4010: [JUMPTEXT, 0x00, 0x51],
                   0x4020: [JUMPTEXT, 0x00, 0x52]})
    seen = []
    walk_script(en, de, (1, 0x4000), (1, 0x4000), lambda kind, e, d, path: seen.append(d))
    assert sorted(seen) == [(1, 0x5100), (1, 0x5200)]


def test_duplicated_kristall_text_keeps_both_twins(pairs):  # Review Focus 1
    p = by_label(pairs, "BugCatchingContestExplanationText")
    assert len(p["de_alts"]) == 1 and p["de_alts"][0]["de_addr"] != p["de_addr"]


def test_sub_macro_operands_are_counted():
    events = read_macros(PRET / "macros/scripts/events.asm")
    setmapscene = next(m for m in events.values() if m.name == "setmapscene")
    givemoney = next(m for m in events.values() if m.name == "givemoney")
    assert [o.size for o in setmapscene.operands] == ["db", "db", "db"]   # map_id, scene
    assert [o.size for o in givemoney.operands] == ["db", "db", "db", "db"]  # account, bigdt


def test_structure_ignores_line_breaks():
    from kristall_pairs import shape
    en = [("text", "a b"), ("line", "c"), ("para", "d"), ("done",)]
    de = [("text", "a"), ("line", "b c"), ("cont", "d"), ("cont", "e"), ("done",)]
    assert shape(en) == shape(de)
    moved = [("text_ram", "wStringBuffer1"), ("text", "a"), ("done",)]
    assert shape([("text", "a"), ("text_ram", "wStringBuffer1"), ("done",)]) != shape(moved)
    assert shape(en[:-1] + [("prompt",)]) != shape(en)
