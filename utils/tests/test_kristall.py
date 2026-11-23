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


# --- Task 3: phone, text sections, tables, names, coverage ---------------------------------

def test_text_sections_pair_by_order(pairs):
    sec = [p for p in pairs["texts"] if p["kind"] == "section"]
    assert len(sec) >= 1651
    assert by_label(pairs, "_StoppedEvolvingText")["structure_differs"] is True
    assert by_label(pairs, "_CantUseTeleportText")["structure_differs"] is True


def test_tables_pair(pairs):
    dex = [p for p in pairs["texts"] if p["kind"] == "dex"]
    assert len(dex) == 251
    assert len([p for p in pairs["texts"] if p["kind"] == "move_desc"]) == 251


def test_names_pair_by_constant(pairs):
    assert pairs["names"]["pokemon"]["BULBASAUR"] == ["BULBASAUR", "BISASAM"]
    assert pairs["names"]["landmarks"]["TIN_TOWER"] == ["TIN TOWER", "ZINNTURM"]


def test_phone_scripts_are_walked(pairs):
    assert any(p["kind"] == "phone" for p in pairs["texts"])


def test_coverage_is_reported(pairs):
    assert set(pairs["coverage"]) == {"unreached_dump", "unpaired_labels"}


def test_unreached_dump_texts_are_listed():
    from kristall_pairs import unreached
    texts = [{"de_addr": "69:5a91", "de_len": 0x3B, "de_alts": []},
             {"de_addr": "6f:4000", "de_len": 0x10, "de_alts": [{"de_addr": "75:4000", "de_len": 0x10}]}]
    dump = ["69:5a91", "69:5aa0", "69:5acd", "75:4008", "6f:4010"]
    assert unreached(dump, texts) == ["69:5acd", "6f:4010"]


def test_twin_found_by_code_pattern():
    from kristall_pairs import find_twin
    en = fake_rom({0x4000: [0xE5, 0x21, 0x52, 0x4B, 0xFA, 0x60, 0xCF, 0x3D]})
    de = fake_rom({0x4100: [0xE5, 0x21, 0x55, 0x4B, 0xFA, 0x60, 0xCF, 0x3D]})
    assert find_twin(en, de, (1, 0x4000), 8, holes=(2, 3)) == (1, 0x4100)
    with pytest.raises(LockstepError):  # no match
        find_twin(en, fake_rom({}), (1, 0x4000), 8, holes=(2, 3))


def test_kristall_plus_sign():
    from kristall_rom import KRISTALL_CHARS
    assert KRISTALL_CHARS[0xE4] == "+"


def test_trainer_classes_count_every_class(tmp_path):
    from kristall_pairs import trainer_classes
    (tmp_path / "constants").mkdir()
    (tmp_path / "constants/trainer_constants.asm").write_text(
        "\ttrainerclass TRAINER_NONE ; 0\n\tconst PHONECONTACT_MOM\n\ttrainerclass FALKNER ; 1\n"
        "\ttrainerclass CAL ; 2\n\tconst CAL1\n")
    assert trainer_classes(tmp_path) == {1: "FALKNER", 2: "CAL"}


def test_pret_text_labels_come_from_source(tmp_path):
    from kristall_pairs import pret_text_labels
    (tmp_path / "engine").mkdir()
    (tmp_path / "engine/x.asm").write_text(
        "Code:\n\tld a, 1\n\tret\n\nHelloText:\n\ttext \"Hi\"\n\tdone\n\n"
        "FarText: ; comment\n\ttext_far _Far\n\ttext_end\n\nParent:\n.local\n\ttext_ram wStringBuffer1\n\ttext_end\n")
    assert pret_text_labels(tmp_path) == {"HelloText", "FarText", "Parent", "Parent.local"}  # same address


def test_code_bank_text_runs_are_paired(pairs):
    p = by_label(pairs, "BattleText_UsersHurtByStringBuffer1")
    assert p["kind"] == "engine" and p["de_addr"] == "20:4f12"
    later = by_label(pairs, "LoafingAroundText")
    assert later["kind"] == "engine"


def test_text_run_must_end_where_code_resumes():
    from kristall_pairs import pair_run
    TEXT_START, DONE = 0x00, 0x57
    en = fake_rom({0x4000: [TEXT_START, 0x80, DONE, TEXT_START, 0x81, DONE, 0xC9, 0xC9, 0xC9, 0xC9]})
    de = fake_rom({0x4000: [TEXT_START, 0x80, 0x80, DONE, TEXT_START, 0x81, DONE, 0xC9, 0xC9, 0xC9, 0xC9]})
    starts = {(1, 0x4000), (1, 0x4003)}
    assert [(e, d) for e, d, *_ in pair_run(en, de, (1, 0x4000), starts)] == [((1, 0x4000), (1, 0x4000)),
                                                                                ((1, 0x4003), (1, 0x4004))]
    extra = fake_rom({0x4000: [TEXT_START, 0x80, DONE, TEXT_START, 0x82, DONE, TEXT_START, 0x81, DONE, 0xC9, 0xC9]})
    assert pair_run(en, extra, (1, 0x4000), starts) == []  # Kristall has a text more: the ends don't meet


def test_unused_texts_between_pairs_are_paired(pairs):
    p = by_label(pairs, "GoldenrodBikeShopJustReleasedCompactBikeText")
    assert p["de_addr"] == "15:4a97" and p["path"][0] == "between pairs"


def test_gap_must_close_on_the_next_pair():
    from kristall_pairs import pair_gap
    TEXT_START, DONE = 0x00, 0x57
    en = fake_rom({0x4000: [TEXT_START, 0x80, DONE, TEXT_START, 0x81, DONE, TEXT_START, 0x82, DONE]})
    de = fake_rom({0x4000: [TEXT_START, 0x80, 0x80, DONE, TEXT_START, 0x81, DONE, TEXT_START, 0x82, DONE]})
    starts = {(1, 0x4000), (1, 0x4003), (1, 0x4006)}
    known = {(1, 0x4000): (1, 0x4000), (1, 0x4006): (1, 0x4007)}
    assert [(e, d) for e, d, *_ in pair_gap(en, de, (1, 0x4000), (1, 0x4000), starts, known)] == [
        ((1, 0x4003), (1, 0x4004))]
    assert pair_gap(en, de, (1, 0x4000), (1, 0x4000), starts, {**known, (1, 0x4006): (1, 0x4008)}) == []


def test_code_in_step_allows_moved_addresses():
    from kristall_pairs import code_in_step
    assert code_in_step(bytes([0xCD, 0x55, 0x3C, 0x11, 0xA9, 0x00, 0x3E, 0x01]),
                        bytes([0xCD, 0x3F, 0x3C, 0x11, 0xA9, 0x00, 0x3E, 0x01]))  # call moved home routine
    assert not code_in_step(bytes([0xCD, 0x55, 0x3C, 0x3E, 0x01, 0xC9, 0, 0]),
                            bytes([0xCD, 0x55, 0x3C, 0x3E, 0x02, 0xC9, 0, 0]))  # ld a, 1 against ld a, 2
    assert not code_in_step(bytes([0xC9, 0, 0, 0]), bytes([0x00, 0xC9, 0, 0]))  # out of step
