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


# --- Task 6: Polished's texts and the index ------------------------------------------------

from collections import Counter  # noqa: E402

W1 = {"map": "ROUTE_30", "event": "object", "x": 2, "y": 3}
W2 = {"map": "ROUTE_31", "event": "object", "x": 4, "y": 5}
EN = [("text", "We hope to see"), ("line", "you again!"), ("done",)]


def put(path, text):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text)


def fake_pair(label, en, de=None, where=None, structure_differs=False):
    return {"label": label, "kind": "map", "en_addr": "01:4000", "de_addr": "01:4000", "de_len": 1,
            "path": [], "where": where, "en": en, "de": de or [("text", "Hallo!"), ("done",)],
            "structure_differs": structure_differs, "de_alts": []}


def fake_text(commands, variant="both", path="maps/X.asm", label="T", partial_faithful=False):
    from asm_text import AsmText
    return AsmText(label, path, 1, len(commands), variant, commands, partial_faithful)


def test_faithful_variants_parse_both(tmp_path):
    from asm_text import iter_texts
    put(tmp_path / "maps/X.asm",
        "T:\n\ttext \"A\"\nif DEF(FAITHFUL)\n\tline \"B\"\nelse\n\tline \"C\"\nendc\n\tdone\n"
        "if DEF(DEBUG)\nD:\n\ttext \"dbg\"\n\tdone\nendc\n")
    texts = list(iter_texts(tmp_path, ("maps",)))
    assert [(t.variant, t.commands[1]) for t in texts] == [("regular", ("line", "C")), ("faithful", ("line", "B"))]
    assert all(t.partial_faithful for t in texts)


def test_inline_texts_take_their_script_label(tmp_path):
    from asm_text import iter_texts
    put(tmp_path / "maps/X.asm",
        "GenericTrainerYoungsterMikey:\n\tgenerictrainer YOUNGSTER, MIKEY, EVENT_X, MikeySeenText, MikeyBeatenText\n\n"
        "\ttext \"Becoming a good\"\n\tdone\n\nSignScript:\n\tjumpthistext\n\n\ttext \"A sign.\"\n\tdone\n")
    assert [(t.label, t.commands[0]) for t in iter_texts(tmp_path, ("maps",))] == [
        ("GenericTrainerYoungsterMikey", ("text", "Becoming a good")), ("SignScript", ("text", "A sign."))]


def test_render_round_trip():
    from asm_text import render
    assert render([("text", "A"), ("line", "B"), ("text_ram", "wStringBuffer1"), ("done",)]) == [
        '\ttext "A"', '\tline "B"', "\ttext_ram wStringBuffer1", "\tdone"]


def test_rename_counts_as_word_for_word():
    from kristall_index import classify
    pair = fake_pair("TinTowerSignText", en=[("text", "TIN TOWER"), ("done",)])
    text = fake_text(commands=[("text", "Bell Tower"), ("done",)])
    [e] = classify([text], {"texts": [pair]}, [("TIN TOWER", "Bell Tower")], {}, {})
    assert e.cls == "word" and e.pair is pair


def test_ambiguous_english_is_flagged():
    from kristall_index import classify
    a = fake_pair("A", en=EN, de=[("text", "Bis bald!"), ("done",)], where=W1)
    b = fake_pair("B", en=EN, de=[("text", "Auf Wiedersehen!"), ("done",)], where=W2)
    [e] = classify([fake_text(commands=EN)], {"texts": [a, b]}, [], {}, {})
    assert e.cls == "ambiguous" and {p["label"] for p in e.candidates} == {"A", "B"}
    [e] = classify([fake_text(commands=EN)], {"texts": [a, b]}, [], {("maps/X.asm", "T"): W2}, {})
    assert e.cls == "word" and e.pair is b


def test_same_german_twins_are_word_for_word():
    from kristall_index import classify
    a = fake_pair("A", en=EN, de=[("text", "Bis bald!"), ("done",)], where=W1)
    b = fake_pair("B", en=EN, de=[("text", "Bis bald!"), ("done",)], where=W2)
    [e] = classify([fake_text(commands=EN)], {"texts": [a, b]}, [], {}, {})
    assert e.cls == "word"


def test_choice_settles_ambiguous():
    from kristall_index import classify
    a = fake_pair("A", en=EN, de=[("text", "Bis bald!"), ("done",)])
    b = fake_pair("B", en=EN, de=[("text", "Auf Wiedersehen!"), ("done",)])
    [e] = classify([fake_text(commands=EN)], {"texts": [a, b]}, [], {}, {"T": "B"})
    assert e.cls == "word" and e.pair is b


def test_text_far_stub_is_one_text(tmp_path):  # Review Focus 4
    from asm_text import iter_texts
    put(tmp_path / "maps/X.asm", "S:\n\ttext_far _T\n\ttext_end\n")
    put(tmp_path / "data/text/t.asm", "_T:\n\ttext \"A\"\n\tdone\n")
    texts = [t for t in iter_texts(tmp_path, ("maps", "data")) if ("text", "A") in t.commands]
    assert [(t.path, t.label) for t in texts] == [("data/text/t.asm", "_T")]


def test_faithful_variants_classified_separately():  # Review Focus 5
    from kristall_index import classify
    regular = fake_text(commands=[("text", "Come again!"), ("done",)], variant="regular")
    faithful = fake_text(commands=[("text", "See you, trainer!"), ("done",)], variant="faithful")
    pair = fake_pair("P", en=[("text", "Come again!"), ("done",)])
    entries = classify([regular, faithful], {"texts": [pair]}, [], {}, {})
    assert entries[0].cls == "word" and entries[1].cls != "word"


def test_line_breaks_and_case_dont_matter():
    from kristall_index import normalize
    assert normalize([("text", "I'm going to bat-"), ("line", "tle!"), ("done",)], []) == \
        normalize([("text", "I'M GOING TO"), ("line", "BATTLE!"), ("prompt",)], [])


def test_index_on_real_data(pairs, root):
    from asm_text import iter_texts
    from kristall_index import classify, load_renames, locate
    entries = classify(list(iter_texts(root)), pairs, load_renames(root), locate(root), {})
    by = Counter(e.cls for e in entries)
    assert by["word"] > 1000 and by["new"] > 0


def test_at_sign_ends_a_text(tmp_path):
    from asm_text import iter_texts
    put(tmp_path / "data/c.asm", '.A:\ttext "   Satoshi@"\n.B:\ttext "   Junichi@"\n')
    assert [t.commands for t in iter_texts(tmp_path, ("data",))] == [[("text", "   Satoshi@")],
                                                                     [("text", "   Junichi@")]]


def test_dex_entry_keeps_its_category(tmp_path):
    from asm_text import iter_texts
    put(tmp_path / "data/pokemon/dex_entries.asm",
        'BulbasaurPokedexEntry::\n\tdb "Seed@"\n\ttext "While it is young,"\n\tnext "it uses the"\n'
        '\tpage "stored in the"\n\tnext "in order to grow.@"\n')
    [t] = iter_texts(tmp_path, ("data",))
    assert t.commands[0] == ("category", "Seed") and t.commands[-1] == ("next", "in order to grow.@")


def test_asserts_inside_a_text_are_passed_over(tmp_path):
    from asm_text import iter_texts
    put(tmp_path / "maps/X.asm", 'T:\n\ttext "Advanced Tips!"\n\n\tassert NUM_FRAMES == 20\n\tpara "You can"\n\tprompt\n')
    assert [t.commands for t in iter_texts(tmp_path, ("maps",))] == [
        [("text", "Advanced Tips!"), ("para", "You can"), ("prompt",)]]


def test_renames_match_pret_capitals_only():
    from kristall_index import normalize
    renames = [("BERRY", "Oran Berry"), ("STICK", "Leek")]
    assert normalize([("text", "A BERRY! I stick to it."), ("done",)], renames) == "a oran berry! i stick to it."


def test_renames_apply_in_one_pass():
    from kristall_index import normalize
    renames = [("GOLD BERRY", "Sitrus Berry"), ("BERRY", "Oran Berry")]
    assert normalize([("text", "GOLD BERRY"), ("done",)], renames) == "sitrus berry"


def test_renames_follow_the_build():
    from kristall_index import classify
    pair = fake_pair("P", en=[("text", "Use ROCK SMASH!"), ("done",)])
    renames = [("ROCK SMASH", "Brick Break", "regular")]
    regular = fake_text(commands=[("text", "Use Brick Break!"), ("done",)], variant="regular")
    faithful = fake_text(commands=[("text", "Use Rock Smash!"), ("done",)], variant="faithful")
    both = fake_text(commands=[("text", "Use Rock Smash!"), ("done",)], variant="both")
    assert [e.cls for e in classify([regular, faithful, both], {"texts": [pair]}, renames, {}, {})] == \
        ["word", "word", "word"]


def test_pret_stub_is_not_a_candidate():
    from kristall_index import classify
    target = fake_pair("_T", en=EN, de=[("text", "Bis bald!"), ("done",)])
    stub = fake_pair("T", en=[("text_far", "_T"), ("text_end",)], de=[("text_far", "7b:4000"), ("text_end",)])
    [e] = classify([fake_text(commands=EN)], {"texts": [stub, target]}, [], {}, {})
    assert e.cls == "word" and e.pair is target
    [e] = classify([fake_text(commands=[("text", "Changed!"), ("done",)], label="T")],
                   {"texts": [stub, target]}, [], {}, {})
    assert e.cls == "changed" and e.pair is target


def test_item_descriptions_pair_with_dump(pairs):
    def words(label):
        return " ".join(c[1] for c in by_label(pairs, label)["de"] if len(c) > 1)
    assert words("PotionDesc") == "Füllt KP um 20 auf."
    assert words("BicycleDesc") == "Ein Klapprad, um schneller zu sein."
    assert words("MasterBallDesc").startswith("Der beste BALL")


def test_hyphens_dont_matter():
    from kristall_index import normalize
    assert normalize([("text", "Powers up dark-"), ("next", "type moves.")], []) == \
        normalize([("text", "Powers up Dark-type"), ("next", "moves.")], [])
    assert normalize([("text", "Heilt jedes #-"), ("next", "MON.")], []) == "heilt jedes pokémon."


def test_same_label_settles_ambiguous():
    from kristall_index import classify
    a = fake_pair("ThrashDescription", en=EN, de=[("text", "Hält 2-3 Runden."), ("done",)])
    b = fake_pair("OutrageDescription", en=EN, de=[("text", "Wirkt 2-3 Runden."), ("done",)])
    [e] = classify([fake_text(commands=EN, label="OutrageDescription")], {"texts": [a, b]}, [], {}, {})
    assert e.cls == "word" and e.pair is b


def test_text_farend_stub_leaves_only_its_target(tmp_path):  # Review Focus 4
    from asm_text import iter_texts
    from kristall_index import classify
    put(tmp_path / "maps/X.asm", "S:\n\ttext_farend _T\n")
    put(tmp_path / "data/text/t.asm", "_T:\n\ttext \"A\"\n\tdone\n")
    texts = list(iter_texts(tmp_path, ("maps", "data")))
    assert [t.commands for t in texts if t.label == "S"] == [[("text_farend", "_T")]]
    assert [e.text.label for e in classify(texts, {"texts": []}, [], {}, {})] == ["_T"]


def test_target_takes_its_stubs_where():
    from kristall_index import classify
    a = fake_pair("A", en=EN, de=[("text", "Bis bald!"), ("done",)], where=W1)
    b = fake_pair("B", en=EN, de=[("text", "Auf Wiedersehen!"), ("done",)], where=W2)
    stub = fake_text(commands=[("text_farend", "_T")], path="maps/X.asm", label="S")
    target = fake_text(commands=EN, path="data/text/t.asm", label="_T")
    [e] = classify([stub, target], {"texts": [a, b]}, [], {("maps/X.asm", "S"): W2}, {})
    assert e.cls == "word" and e.pair is b


def test_typography_doesnt_matter():
    from kristall_index import normalize
    pret = [("text", "Say 'welcome,'<……><……>"), ("line", "for ¥1500, No."), ("text_ram", "wX"), ("done",)]
    ours = [("text", "Say “welcome,”……"), ("next", "…… for ¥1,500, No. "), ("text_ram", "wX"), ("done",)]
    assert normalize(pret, []) == normalize(ours, [])


def test_longer_rename_wins_over_its_part():
    from kristall_index import normalize
    renames = [("UNDERGROUND", "Underground Path"), ("UNDERGROUND PATH", "Underground Path")]
    assert normalize([("text", "the UNDERGROUND PATH")], renames) == "the underground path"


def test_columns_match_claude_md():
    from kristall_lookup import columns
    assert columns(["We'll be waiting", "for you, <PLAYER>."], ["Ich werde auf dich", "warten, <PLAYER>."],
                   ["Wir werden auf", "dich warten,", "<PLAYER>."]) == "\n".join([
        "ENGLISH           | GERMAN ORIGINAL    | OURS",
        "------------------+--------------------+------------------",
        "We'll be waiting  | Ich werde auf dich | Wir werden auf",
        "for you, <PLAYER>.| warten, <PLAYER>.  | dich warten,",
        "                  |                    | <PLAYER>."])


def test_box_lines_follow_the_text_commands():
    from kristall_lookup import box_lines
    assert box_lines([("text", "<PLAYER> received"), ("line", "the "), ("text_ram", "wStringBuffer4"),
                      ("text", " Badge."), ("para", "Next box."), ("done",)]) == [
        "<PLAYER> received", "the <wStringBuffer4> Badge.", "", "Next box."]
