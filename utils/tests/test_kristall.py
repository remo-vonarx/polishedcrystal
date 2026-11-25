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
    # Kristall's text is checked by its hash and one word: Nintendo's text stays out of the repo
    assert digest(t.commands) == "6c137db10ee6" and "übergibt" in t.commands[0][1]


# --- Task 2: the lockstep walk -------------------------------------------------------------

import pytest  # noqa: E402

from kristall_rom import Rom  # noqa: E402
from kristall_script import EVENT_COMMANDS, LockstepError, walk_script  # noqa: E402

COMMAND_ID = {m.name: i for i, m in EVENT_COMMANDS.items()}
IFEQUAL, JUMPTEXT, SCALL, END = (COMMAND_ID[n] for n in ("ifequal", "jumptext", "scall", "end"))


def digest(value):
    """A short hash of a Kristall text, to check it exactly without committing Nintendo's words."""
    import hashlib
    return hashlib.sha1(repr(value).encode()).hexdigest()[:12]


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
    assert p["de_addr"] == "69:5a91" and "übergibt" in p["de"][0][1]


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
    # all 1,651 texts of pret's text sections, but the one Kristall splits; a text a pointer
    # reached first keeps that kind, so count by address
    from kristall_pairs import PRET, TEXT_SECTIONS
    from kristall_rom import read_sections
    sections = read_sections(PRET / "pokecrystal.map")
    ranges = [sections[name] for name in TEXT_SECTIONS]
    inside = [p for p in pairs["texts"] if any(
        int(p["en_addr"][:2], 16) == b and lo <= int(p["en_addr"][3:], 16) <= hi for b, lo, hi in ranges)]
    assert len(inside) == 1651 - 1
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


def test_index_on_real_data(pairs, root, base):  # Upstream's English, at the last merged commit
    from asm_text import iter_texts
    from kristall_index import classify, load_renames, locate
    from kristall_lookup import git_tree
    files, source = git_tree(base, root)
    english = list(iter_texts(root, source=source, files=files))
    entries = classify(english, pairs, load_renames(root), locate(root, source), {})
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
    assert digest(words("PotionDesc")) == "bd09ea60871e" and "KP" in words("PotionDesc")
    assert digest(words("BicycleDesc")) == "d20783a135b0" and "Klapprad" in words("BicycleDesc")
    assert "BALL." in words("MasterBallDesc").split()[:3]


def test_hyphens_dont_matter():
    from kristall_index import normalize
    assert normalize([("text", "Powers up dark-"), ("next", "type moves.")], []) == \
        normalize([("text", "Powers up Dark-type"), ("next", "moves.")], [])
    assert normalize([("text", "Heilt jedes #-"), ("next", "MON.")], []) == "heilt jedes pokémon."


def test_same_label_settles_ambiguous():
    from kristall_index import classify
    a = fake_pair("ThrashDescription", en=EN, de=[("text", "Hallo, Welt."), ("done",)])
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


def test_dex_entries_pair_with_dump(pairs):
    # Kristall keeps height and weight in 3 bytes (metric), pret in 4
    assert by_label(pairs, "BulbasaurPokedexEntry")["de"][:2] == [("category", "SAMEN"), ("text", "Da es noch klein")]
    dex = [p for p in pairs["texts"] if p["kind"] == "dex"]
    assert all(p["de"][1][1][:1].isupper() or p["de"][1][1][:1] == "#" for p in dex)


# --- Task 7: the writer ---------------------------------------------------------------------

HI = [("text", "Hi!"), ("done",)]
HALLO = [("text", "Hallo!"), ("done",)]


def word_entry(polished=HI, pret_en=HI, de=HALLO, partial_faithful=False, structure_differs=False):
    from kristall_index import Entry
    text = fake_text(commands=polished, partial_faithful=partial_faithful)
    pair = fake_pair("P", en=pret_en, de=de, structure_differs=structure_differs)
    return Entry(text, "word", pair, [pair], 1.0)


def entries_for(tmp_path, en, de):
    from asm_text import iter_texts
    from kristall_index import classify
    from asm_text import render
    path = tmp_path / "maps/X.asm"
    if not path.exists():
        put(path, "\n".join(["T:"] + render(en)) + "\n")
    return classify(list(iter_texts(tmp_path, ("maps",))), {"texts": [fake_pair("P", en=en, de=de)]}, [], {}, {})


def test_recase_non_names_and_split_words():
    from kristall_write import recase
    case = {"NACHTs": "Nachts", "ARENALEITER": "Arenaleiter"}
    out, unknown = recase([("text", "des NACHTs"), ("line", "ARENA-"), ("cont", "LEITER ist da."), ("done",)], {}, case)
    assert out[:3] == [("text", "des Nachts"), ("line", "Arena-"), ("cont", "leiter ist da.")] and unknown == []


def test_unknown_capitals_are_reported():
    from kristall_write import recase
    assert recase([("text", "Der FOO"), ("done",)], {}, {})[1] == ["FOO"]


def test_multi_word_names_are_looked_up_whole():
    from kristall_write import recase
    out, unknown = recase([("text", "PROF. LINDs Labor"), ("done",)], {}, {"PROF. LINDs": "Prof. Linds"})
    assert out[0] == ("text", "Prof. Linds Labor") and unknown == []


def test_name_swap_rebreaks_paragraph():
    from check_text_width import string_width
    from kristall_write import fit, recase
    cmds = [("text", "Das ist der"), ("line", "ZINNTURM, so hoch"), ("cont", "wie nie."), ("done",)]
    out, _ = recase(cmds, {"ZINNTURM": "Glockenturm"}, {})
    fitted = fit(out)
    assert fitted and all(string_width(c[1]) <= 18 for c in fitted if len(c) > 1)
    assert " ".join(c[1] for c in fitted if len(c) > 1) == "Das ist der Glockenturm, so hoch wie nie."
    assert fitted[-1] == ("done",)


def test_fit_keeps_a_paragraph_that_fits():
    from kristall_write import fit
    cmds = [("text", "Kurz."), ("para", "Auch kurz."), ("done",)]
    assert fit(cmds) == cmds


def test_fit_with_runtime_variable_is_flagged():  # Review Focus 3
    from kristall_write import fit
    assert fit([("text", "Der GLOCKENTURM von"), ("text_ram", "wStringBuffer1"), ("done",)]) is None


def test_unmapped_kristall_char_is_flagged():  # Review Focus 2
    from kristall_write import german_for
    r = german_for(word_entry(de=[("text", "Crème brûlée"), ("done",)]), {}, {})
    assert r.commands is None and any("û" in f for f in r.flags)


def test_structure_differs_follows_kristall():
    from kristall_write import german_for
    e = word_entry(
        polished=[("text_ram", "wStringBuffer1"), ("text", " stopped"), ("line", "evolving!"), ("prompt",)],
        pret_en=[("text_ram", "wStringBuffer2"), ("text", " stopped"), ("line", "evolving!"), ("prompt",)],
        de=[("text", "Entwicklung von"), ("text_ram", "wStringBuffer2"), ("line", "gestoppt!"), ("done",)],
        structure_differs=True)
    assert german_for(e, {}, {}).commands == [  # Kristall's order, Polished's variable and ending
        ("text", "Entwicklung von"), ("text_ram", "wStringBuffer1"), ("line", "gestoppt!"), ("prompt",)]


def test_unmappable_kristall_variable_is_flagged():
    from kristall_write import german_for
    e = word_entry(polished=HI, pret_en=HI, de=[("text", "Hallo"), ("text_ram", "wNotInPolished"), ("done",)],
                   structure_differs=True)
    r = german_for(e, {}, {})
    assert r.commands is None and any("wNotInPolished" in f for f in r.flags)


def test_partial_faithful_is_flagged():
    from kristall_write import german_for
    assert german_for(word_entry(partial_faithful=True), {}, {}).commands is None


def test_only_word_for_word_texts_are_written():
    from kristall_index import Entry
    from kristall_write import german_for
    e = word_entry()
    assert german_for(Entry(e.text, "changed", e.pair, [], 0.8), {}, {}).commands is None


def test_dex_entry_keeps_its_at_sign():
    from kristall_write import german_for
    ours = [("category", "Seed"), ("text", "While it is young."), ("page", "It grows.@")]
    pret = [("category", "SEED"), ("text", "While it is young."), ("page", "It grows.")]
    de = [("category", "SAMEN"), ("text", "Solange es jung"), ("page", "ist, wächst es.")]
    assert german_for(word_entry(polished=ours, pret_en=pret, de=de), {}, {"SAMEN": "Samen"}).commands == [
        ("category", "Samen"), ("text", "Solange es jung"), ("page", "ist, wächst es.@")]


def test_writer_is_idempotent(tmp_path):
    from kristall_write import write
    entries = entries_for(tmp_path, en=HI, de=HALLO)
    assert write(entries, {}, {}, dry_run=False, root=tmp_path).changed
    before = (tmp_path / "maps/X.asm").read_bytes()
    assert b'text "Hallo!"' in before
    again = entries_for(tmp_path, en=HI, de=HALLO)
    assert write(again, {}, {}, dry_run=False, root=tmp_path).changed == []
    assert (tmp_path / "maps/X.asm").read_bytes() == before


def test_writer_finds_its_text_after_lines_moved(tmp_path):
    from asm_text import iter_texts
    from kristall_index import classify
    from kristall_write import write
    put(tmp_path / "maps/X.asm", 'A:\n\ttext "One"\n\tline "two"\n\tdone\n\nB:\n\ttext "Hi!"\n\tdone\n')
    english = list(iter_texts(tmp_path, ("maps",)))
    put(tmp_path / "maps/X.asm", 'A:\n\ttext "Eins"\n\tdone\n\nB:\n\ttext "Hi!"\n\tdone\n')  # A got shorter
    entries = [e for e in classify(english, {"texts": [fake_pair("P", en=HI, de=HALLO)]}, [], {}, {}) if e.cls == "word"]
    write(entries, {}, {}, dry_run=False, root=tmp_path)
    assert (tmp_path / "maps/X.asm").read_text() == 'A:\n\ttext "Eins"\n\tdone\n\nB:\n\ttext "Hallo!"\n\tdone\n'


def test_text_with_code_inside_is_not_written(tmp_path):
    from kristall_write import write
    put(tmp_path / "maps/X.asm", 'T:\n\ttext "Hi!"\n\tassert 1 == 1\n\tdone\n')
    entries = entries_for(tmp_path, en=HI, de=HALLO)
    report = write(entries, {}, {}, dry_run=False, root=tmp_path)
    assert report.changed == [] and any("assert" in f for f in report.flags)


def test_kristall_contraction_tiles(pairs):
    def words(label):
        return " ".join(c[1] for c in by_label(pairs, label)["de"] if len(c) > 1 and isinstance(c[1], str))
    assert "steht's?" in words("HaveGoodRodText").split()  # one word each: no Nintendo text
    assert "soll's!" in words("SailorStanlySeenText").split()
    assert "bin's," in words("BillPhoneNewlyFullText").split()


@pytest.mark.parametrize("ours, pret, kept", [
    ("Poison Moth", "POISONMOTH", False),  # spacing only
    ("FlyScorpion", "FLYSCORPIO", False),  # pret's cut at 10 letters
    ("Squatter", "HERMITCRAB", True),
    ("Shell", "SHELLFISH", True),
    ("Lava Slug", "LAVA", True),  # pret cuts only at 10 letters
    ("Hibernator", "HIBERNANT", True),
])
def test_category_polished_changed_stays_english(ours, pret, kept):
    from kristall_write import german_for
    e = word_entry(polished=[("category", ours), ("text", "Some text.@")],
                   pret_en=[("category", pret), ("text", "Some text.")],
                   de=[("category", "SAMEN"), ("text", "Ein Text.")])
    assert german_for(e, {}, {"SAMEN": "Samen"}).commands == [
        ("category", ours if kept else "Samen"), ("text", "Ein Text.@")]


def test_render_category():
    from asm_text import render
    assert render([("category", "Samen"), ("text", "Da es"), ("next", "klein ist.@")]) == [
        '\tdb "Samen@"', '\ttext "Da es"', '\tnext "klein ist.@"']


def test_tokens_are_not_capitals():
    from kristall_write import recase
    out, unknown = recase([("text", "<PLAYER> und <USER>!"), ("done",)], {}, {})
    assert out[0] == ("text", "<PLAYER> und <USER>!") and unknown == []


def test_text_far_with_asm_is_left_to_its_target():
    from kristall_write import german_for
    far = [("text_far", "Text_Gained"), ("text_asm",)]
    r = german_for(word_entry(polished=far, pret_en=[("text_far", "_Text_Gained"), ("text_asm",)]), {}, {})
    assert r == (None, [])


def test_text_far_inside_own_text_is_flagged():
    from kristall_write import german_for
    mixed = [("text", "Hi "), ("text_far", "Text_Gained"), ("text_end",)]
    r = german_for(word_entry(polished=mixed, pret_en=mixed), {}, {})
    assert r.commands is None and any("text_far" in f for f in r.flags)


# --- Task 8: the drift check ----------------------------------------------------------------

FAKE_PAIRS = {"texts": [fake_pair("T", en=HI, de=HALLO)], "names": {}}


def asm(*commands):
    from asm_text import render
    return "\n".join(["T:"] + render(list(commands))) + "\n"


def test_drift_check_passes_on_tree(pairs, root, base, monkeypatch):
    import check_kristall
    compared, derive = [], check_kristall.german_for

    def counted(entry, *args):
        compared.append(entry)
        return derive(entry, *args)
    monkeypatch.setattr(check_kristall, "german_for", counted)
    failures, _ = check_kristall.check(root, base, pairs)
    assert failures == [] and len(compared) > 1000  # it compared the German, it didn't skip it


def test_drift_check_passes_written_text(git_repo):
    import check_kristall
    repo = git_repo({"maps/X.asm": asm(*HI)}, {"maps/X.asm": asm(*HALLO)})
    assert check_kristall.check(repo, "base", FAKE_PAIRS) == ([], 0)


def test_drift_check_counts_english(git_repo):
    import check_kristall
    repo = git_repo({"maps/X.asm": asm(*HI)}, {"maps/X.asm": asm(*HI)})
    assert check_kristall.check(repo, "base", FAKE_PAIRS) == ([], 1)


def test_hand_edit_of_inherited_text_fails(git_repo):
    import check_kristall
    repo = git_repo({"maps/X.asm": asm(*HI)}, {"maps/X.asm": asm(("text", "Hallo, du!"), ("done",))})
    assert check_kristall.check(repo, "base", FAKE_PAIRS)[0]


def test_upstream_change_under_inherited_text_fails(git_repo):
    import check_kristall
    repo = git_repo({"maps/X.asm": asm(("text", "Hi there!"), ("done",))}, {"maps/X.asm": asm(*HALLO)})
    assert check_kristall.check(repo, "base", FAKE_PAIRS)[0]


def reviewed(repo, label, english):
    from check_kristall import english_key
    put(repo / "utils/kristall_reviewed.tsv", f"# label, key\n{label}\t{english_key(english)}\twhy\n")


def test_reviewed_hand_edit_of_inherited_text_passes(git_repo):
    import check_kristall
    repo = git_repo({"maps/X.asm": asm(*HI)}, {"maps/X.asm": asm(("text", "Hallo, du!"), ("done",))})
    reviewed(repo, "T", HI)
    assert check_kristall.check(repo, "base", FAKE_PAIRS) == ([], 0)


def test_reviewed_german_under_changed_english_passes(git_repo):
    import check_kristall
    changed = [("text", "Hi there!"), ("done",)]
    repo = git_repo({"maps/X.asm": asm(*changed)}, {"maps/X.asm": asm(*HALLO)})
    reviewed(repo, "T", changed)
    assert check_kristall.check(repo, "base", FAKE_PAIRS) == ([], 0)


def test_english_changed_since_review_fails(git_repo):
    import check_kristall
    repo = git_repo({"maps/X.asm": asm(("text", "Hi there!"), ("done",))}, {"maps/X.asm": asm(*HALLO)})
    reviewed(repo, "T", HI)
    failures, _ = check_kristall.check(repo, "base", FAKE_PAIRS)
    assert len(failures) == 1 and "T" in failures[0] and "English changed since" in failures[0]


def test_reviewed_text_that_is_gone_fails(git_repo):
    import check_kristall
    repo = git_repo({"maps/X.asm": asm(*HI)}, {"maps/X.asm": asm(*HALLO)})
    reviewed(repo, "Gone", HI)
    failures, _ = check_kristall.check(repo, "base", FAKE_PAIRS)
    assert len(failures) == 1 and "Gone: no such text" in failures[0]


def test_reviewing_one_text_leaves_the_others_checked(git_repo):
    import check_kristall
    edited = asm(("text", "Hallo, du!"), ("done",))
    repo = git_repo({"maps/X.asm": asm(*HI), "maps/Y.asm": asm(*HI).replace("T:", "U:")},
                    {"maps/X.asm": edited, "maps/Y.asm": edited.replace("T:", "U:")})
    reviewed(repo, "T", HI)
    failures, _ = check_kristall.check(repo, "base", FAKE_PAIRS)
    assert len(failures) == 1 and "maps/Y.asm:U" in failures[0]


def test_iter_texts_takes_files_too(tmp_path):
    from asm_text import iter_texts
    put(tmp_path / "maps/X.asm", 'T:\n\ttext "A"\n\tdone\n')
    put(tmp_path / "maps/Y.asm", 'U:\n\ttext "B"\n\tdone\n')
    assert [t.label for t in iter_texts(tmp_path, ("maps/X.asm",))] == ["T"]


def test_writer_matches_texts_sharing_a_label(tmp_path):
    from asm_text import iter_texts
    from kristall_index import classify
    from kristall_write import write
    put(tmp_path / "maps/X.asm", 'T:\n\ttext "Something else"\n\tdone\n\n\ttext "Hi!"\n\tdone\n')
    entries = classify(list(iter_texts(tmp_path, ("maps",))), {"texts": [fake_pair("P", en=HI, de=HALLO)]}, [], {}, {})
    write([e for e in entries if e.cls == "word"], {}, {}, dry_run=False, root=tmp_path)
    assert (tmp_path / "maps/X.asm").read_text() == 'T:\n\ttext "Something else"\n\tdone\n\n\ttext "Hallo!"\n\tdone\n'


# --- final review: sections pair only between proven pairs (C1) ------------------------------

def bare_builder(en, de):
    from kristall_pairs import Builder
    b = Builder.__new__(Builder)
    b.en, b.de, b.texts, b.labels, b.ram, b.notes = en, de, {}, {}, {}, []
    b.context = {"kind": "map", "where": None}
    return b


def tiny(*glyphs):
    return [0x00, *glyphs, 0x57]  # TX_START, glyphs, done


def test_order_and_pointer_pairings_must_agree():
    en = fake_rom({0x4000: tiny(0x80)})
    de = fake_rom({0x4000: tiny(0x80), 0x4010: tiny(0x81)})
    b = bare_builder(en, de)
    b.add_text((1, 0x4000), (1, 0x4000), ["Text 1", "0"], by="order")
    with pytest.raises(LockstepError):
        b.add_text((1, 0x4000), (1, 0x4010), ["map"], by="pointer")


def test_two_pointer_twins_are_both_kept():
    en = fake_rom({0x4000: tiny(0x80)})
    de = fake_rom({0x4000: tiny(0x80), 0x4010: tiny(0x81)})
    b = bare_builder(en, de)
    b.add_text((1, 0x4000), (1, 0x4000), ["map"])
    assert [a["de_addr"] for a in b.add_text((1, 0x4000), (1, 0x4010), ["map"])["de_alts"]] == ["01:4010"]


def test_section_pairs_only_between_proven_pairs():
    # pret P0 P1 P2 P3; Kristall splits P1 in two: K0 K1a K1b K2 K3, then padding; P2 -> K2 is proven
    en = fake_rom({0x4000: tiny(0x80) + tiny(0x81) + tiny(0x82) + tiny(0x83)})
    de = fake_rom({0x4000: tiny(0x80) + tiny(0x91) + tiny(0x92) + tiny(0x82) + tiny(0x83) + [0, 0, 0, 0]})
    b = bare_builder(en, de)
    b.add_text((1, 0x4006), (1, 0x4009), ["map"])
    b.pair_section("Text 1", 1, 0x4000, 0x400b)
    assert b.texts[(1, 0x4009)]["de_addr"] == "01:400c"  # P3 -> K3, after the proven pair
    assert (1, 0x4000) not in b.texts and (1, 0x4003) not in b.texts  # P0, P1: counts differ, unpaired
    assert any("unpaired" in n for n in b.notes)


def test_section_without_padding_after_it_is_unpaired():
    en = fake_rom({0x4000: tiny(0x80) + tiny(0x81)})
    de = fake_rom({0x4000: tiny(0x80) + tiny(0x90) + tiny(0x81) + [0, 0, 0, 0]})  # one text more
    b = bare_builder(en, de)
    b.pair_section("Text 1", 1, 0x4000, 0x4005)
    assert b.texts == {}


def test_known_kristall_split_is_stepped_over(monkeypatch):
    import kristall_pairs
    monkeypatch.setattr(kristall_pairs, "KRISTALL_SPLITS", {"_Split": 2})
    en = fake_rom({0x4000: tiny(0x80) + tiny(0x81) + tiny(0x82)})
    de = fake_rom({0x4000: tiny(0x80) + tiny(0x91) + tiny(0x92) + tiny(0x82) + [0, 0, 0, 0]})
    b = bare_builder(en, de)
    b.labels = {(1, 0x4003): "_Split"}
    b.pair_section("Text 1", 1, 0x4000, 0x4008)
    assert b.texts[(1, 0x4000)]["de_addr"] == "01:4000" and b.texts[(1, 0x4006)]["de_addr"] == "01:4009"
    assert (1, 0x4003) not in b.texts and any("split" in n for n in b.notes)


def test_text_1_follows_kristalls_split(pairs):
    assert by_label(pairs, "_OPT_IntroText2")["de_addr"] == "6f:4979"
    assert by_label(pairs, "_ComeAgainText")["de_addr"] == "6f:61d0"  # was 6f:61bf, the text before its twin
    assert by_label(pairs, "_NoCoinCaseText")["de_addr"] == "6f:5597"
    assert not any(p["label"] == "_OPT_IntroText1" for p in pairs["texts"])


def test_label_doesnt_settle_twins_with_different_german():
    from kristall_index import classify
    p = fake_pair("T", en=EN, de=[("text", "Bis bald!"), ("done",)])
    p["de_alts"] = [{"de_addr": "01:4100", "de": [("text", "Tschüss!"), ("done",)], "path": []}]
    [e] = classify([fake_text(commands=EN, label="T")], {"texts": [p]}, [], {}, {})
    assert e.cls == "ambiguous"


def test_choice_by_kristall_address_takes_that_twin():
    from kristall_index import classify
    p = fake_pair("T", en=EN, de=[("text", "Bis bald!"), ("done",)])
    p["de_alts"] = [{"de_addr": "01:4100", "de": [("text", "Tschüss!"), ("done",)], "path": []}]
    [e] = classify([fake_text(commands=EN, label="T")], {"texts": [p]}, [], {}, {"T": "01:4100"})
    assert e.cls == "word" and e.pair["de"] == [("text", "Tschüss!"), ("done",)] and e.pair["de_addr"] == "01:4100"


def test_fit_flags_runtime_line_too_wide_on_its_own():  # Review Focus 3
    from kristall_write import fit
    assert fit([("text", "<USER> flieht in den Glockenturm!"), ("done",)]) is None


def test_fit_flags_runtime_paragraph_a_swap_lengthened():  # Review Focus 3
    from kristall_write import fit
    original = [("text", "Zum "), ("text_ram", "wStringBuffer1"), ("text", " ZINNTURM!"), ("done",)]
    swapped = [("text", "Zum "), ("text_ram", "wStringBuffer1"), ("text", " Glockenturm!"), ("done",)]
    assert fit(swapped, original=original) is None


def test_fit_keeps_runtime_paragraph_recasing_didnt_lengthen():
    from kristall_write import fit
    original = [("text", "<USER> nutzt"), ("line", "#MON-KRAFT!"), ("done",)]
    recased = [("text", "<USER> nutzt"), ("line", "#mon-Kraft!"), ("done",)]
    assert fit(recased, original=original) == recased


def test_text_opening_with_line_after_its_label_is_parsed(tmp_path):
    from asm_text import iter_texts
    put(tmp_path / "data/r.asm", '_RadioText1:\n\tline "Mary: Prof.Oak\'s"\n\tdone\n\n_RadioText2:\n\tline "#mon Talk!"\n\tdone\n')
    assert [(t.label, t.commands) for t in iter_texts(tmp_path, ("data",))] == [
        ("_RadioText1", [("line", "Mary: Prof.Oak's"), ("done",)]), ("_RadioText2", [("line", "#mon Talk!"), ("done",)])]


def test_empty_text_before_line_becomes_polisheds_form():
    from kristall_write import german_for
    e = word_entry(polished=[("line", "Hi!"), ("done",)], pret_en=[("text", ""), ("line", "Hi!"), ("done",)],
                   de=[("text", ""), ("line", "Hallo!"), ("done",)])
    assert german_for(e, {}, {}).commands == [("line", "Hallo!"), ("done",)]


def test_kristall_sound_takes_polisheds_command():
    from kristall_write import german_for
    e = word_entry(polished=[("text", "Got it!"), ("text_sound", "SFX_ITEM"), ("text_promptbutton",), ("done",)],
                   pret_en=[("text", "Got it!"), ("sound_item",), ("text_promptbutton",), ("done",)],
                   de=[("text", "Erhalten!"), ("sound_item",), ("text_promptbutton",), ("done",)])
    assert german_for(e, {}, {}).commands == [
        ("text", "Erhalten!"), ("text_sound", "SFX_ITEM"), ("text_promptbutton",), ("done",)]


def test_polished_added_prompt_is_not_word_for_word():
    from kristall_index import classify
    polished = fake_text(commands=[("text", "Hi!"), ("text_promptbutton",), ("done",)])
    [e] = classify([polished], {"texts": [fake_pair("P", en=HI)]}, [], {}, {})
    assert e.cls != "word"


def test_kristall_without_polisheds_pause_is_flagged():
    from kristall_write import german_for
    e = word_entry(polished=[("text", "A"), ("text_pause",), ("line", "B"), ("done",)],
                   pret_en=[("text", "A"), ("text_pause",), ("line", "B"), ("done",)],
                   de=[("text", "A"), ("line", "B"), ("done",)])
    r = german_for(e, {}, {})
    assert r.commands is None and any("pause" in f for f in r.flags)


def test_kristall_command_polished_lacks_is_flagged():
    from kristall_write import german_for
    e = word_entry(de=[("text", "Hallo!"), ("text_low",), ("done",)])
    r = german_for(e, {}, {})
    assert r.commands is None and any("text_low" in f for f in r.flags)


def test_swapped_split_name_leaves_no_leading_space():
    from kristall_write import recase
    out, unknown = recase([("text", "Der ZINN-"), ("line", "TURM ist hoch."), ("done",)], {"ZINNTURM": "Glockenturm"}, {})
    assert out == [("text", "Der Glockenturm"), ("line", "ist hoch."), ("done",)] and unknown == []


def test_place_break_marks_stay_out_of_dialogue():
    from kristall_write import name_pairs
    pairs = {"names": {"landmarks": {"CINNABAR_ISLAND": ["CINNABAR<BSP>ISLAND", "ZINNOBER<TTE>INSEL"],
                                     "SPROUT_TOWER": ["SPROUT<BSP>TOWER", "KNOFENSA-<WBR>TURM"]}}}
    now = {"landmarks": {"CINNABAR_ISLAND": "Zinnober<SHY>insel", "SPROUT_TOWER": "Knofensa-<WBR>Turm"}}
    then = {"landmarks": {"CINNABAR_ISLAND": "Cinnabar¯Island", "SPROUT_TOWER": "Sprout¯Tower"}}
    assert name_pairs(pairs, now, then) == {"ZINNOBERINSEL": "Zinnoberinsel", "KNOFENSA-TURM": "Knofensa-Turm"}


def test_names_same_in_german_map_once_their_table_is_translated():
    from kristall_write import name_pairs
    pairs = {"names": {"pokemon": {"PIKACHU": ["PIKACHU", "PIKACHU"]}}}
    now = then = {"pokemon": {"PIKACHU": "Pikachu"}}
    assert name_pairs(pairs, now, then, translated={"pokemon"}) == {"PIKACHU": "Pikachu"}
    assert name_pairs(pairs, now, then, translated=set()) == {}


def test_single_capitals_are_not_a_capital_run():
    from kristall_write import recase
    cmds = [("text", "O.K., eine E-Mail?"), ("line", "I-I-Ich?"), ("done",)]
    assert recase(cmds, {}, {}) == (cmds, [])


def test_genitive_ending_follows_its_name():
    from kristall_write import recase
    out, unknown = recase([("text", "LINDs Labor"), ("done",)], {}, {"LIND": "Lind"})
    assert out[0] == ("text", "Linds Labor") and unknown == []


def test_hyphenated_compound_is_recased_part_by_part():
    from kristall_write import recase
    case = {"#MON": "#mon", "LIND": "Lind", "LABOR": "Labor"}
    out, unknown = recase([("text", "Käfer-#MON im LIND-#MON-LABOR"), ("done",)], {}, case)
    assert out[0] == ("text", "Käfer-#mon im Lind-#mon-Labor") and unknown == []
    assert recase([("text", "FOO-#MON"), ("done",)], {}, case)[1] == ["FOO"]


def test_unanswered_split_word_is_reported_whole():
    from kristall_write import recase
    cmds = [("text", "Der ARENA-"), ("line", "LEITER ist da."), ("done",)]
    out, unknown = recase(cmds, {}, {"ARENA": "Arena", "LEITER": "Leiter"})
    assert unknown == ["ARENA-LEITER"] and out == cmds


def test_compound_split_at_its_own_hyphen_is_recased_part_by_part():
    from kristall_write import recase
    out, unknown = recase([("text", "Ein Käfer-"), ("line", "#MON ist da."), ("done",)], {}, {"#MON": "#mon"})
    assert out[:2] == [("text", "Ein Käfer-"), ("line", "#mon ist da.")] and unknown == []


def test_split_compound_takes_an_answer_with_a_hyphen():
    from kristall_write import recase
    out, unknown = recase([("text", "Die FLEGMONRUTEN-"), ("line", "Suche")], {}, {"FLEGMONRUTEN": "Flegmon-Ruten"})
    assert out == [("text", "Die Flegmon-Ruten-"), ("line", "Suche")] and unknown == []


def test_answer_for_one_text_wins_over_the_word(tmp_path):
    from kristall_index import Entry
    from kristall_write import german_for, load_case
    put(tmp_path / "case.tsv", "# comment\nUND\tund\nUND\tUND\tSignText\n")
    case = load_case(tmp_path / "case.tsv")
    pair = fake_pair("P", en=HI, de=[("text", "BIS HIER UND"), ("done",)])
    sign = Entry(fake_text(HI, label="SignText"), "word", pair, [pair], 1.0)
    other = Entry(fake_text(HI, label="Other"), "word", pair, [pair], 1.0)
    case.update({"BIS": "bis", "HIER": "hier"})
    assert german_for(sign, {}, case).commands[0] == ("text", "bis hier UND")
    assert german_for(other, {}, case).commands[0] == ("text", "bis hier und")


def test_names_follow_the_build_of_the_text():
    from kristall_index import Entry
    from kristall_write import Names, german_for
    names = Names({"ZERTRÜMMERER": "Durchbruch"})
    names.variants = {"regular": {"ZERTRÜMMERER": "Durchbruch"}, "faithful": {"ZERTRÜMMERER": "Zertrümmerer"},
                      "both": {}}
    pair = fake_pair("P", en=HI, de=[("text", "ZERTRÜMMERER!"), ("done",)])

    def german(variant):
        return german_for(Entry(fake_text(HI, variant=variant), "word", pair, [pair], 1.0), names, {})
    assert german("regular").commands[0] == ("text", "Durchbruch!")
    assert german("faithful").commands[0] == ("text", "Zertrümmerer!")
    assert german("both").commands is None  # the builds disagree: asked, not guessed


def test_answer_wins_over_the_name_map():
    from kristall_write import recase
    out, _ = recase([("text", "Das SCHNELLBOOT"), ("done",)], {"SCHNELLBOOT": "M.S. Aqua"}, {"SCHNELLBOOT": "Schnellboot"})
    assert out[0] == ("text", "Das Schnellboot")


def test_text_kristall_left_in_english_is_not_written():
    from kristall_index import Entry
    from kristall_write import KRISTALL_ENGLISH, german_for
    label = next(iter(KRISTALL_ENGLISH))
    pair = fake_pair("P", en=HI, de=[("text", "Hallo! This is the"), ("done",)])
    r = german_for(Entry(fake_text(HI, label=label), "word", pair, [pair], 1.0), {}, {})
    assert r.commands is None and any("English" in f for f in r.flags)


def test_name_map_splits_by_build(pairs, root, base):  # real data: Regular has Brick Break where Faithful has Rock Smash
    from kristall_write import name_map
    names = name_map(root, pairs, base)
    regular, faithful, both = (names.variants[v] for v in ("regular", "faithful", "both"))
    assert regular["ZERTRÜMMERER"] != faithful["ZERTRÜMMERER"] and "ZERTRÜMMERER" not in both
    assert both["BISASAM"] == regular["BISASAM"] == faithful["BISASAM"]


def test_answers_leave_no_half_capitals():  # an answer like ORDENs -> ORDENs shouts in the middle of a word
    import re
    from kristall_write import load_case
    half = re.compile("[A-ZÄÖÜ]{3,}[a-zäöüß]")
    assert [k for k, v in load_case().items() if isinstance(v, str) and half.search(v)] == []


def test_row_may_start_with_the_poke_token(tmp_path):
    from kristall_write import load_case
    put(tmp_path / "case.tsv", "# a comment\n#MON\t#mon\n")
    assert load_case(tmp_path / "case.tsv") == {"#MON": "#mon"}


def test_semicolon_becomes_a_comma():  # Polished's font has no ';'
    from kristall_write import german_for
    r = german_for(word_entry(de=[("text", "Stark; Angreifer"), ("done",)]), {}, {})
    assert r.commands[0] == ("text", "Stark, Angreifer")


def test_writer_keeps_the_indentation_of_a_nested_text(tmp_path):
    from asm_text import iter_texts
    from kristall_index import classify
    from kristall_write import write
    put(tmp_path / "maps/X.asm", 'S:\n\twritethistext\n\t\ttext "Hi!"\n\t\tdone\n\tend\n')
    entries = classify(list(iter_texts(tmp_path, ("maps",))), {"texts": [fake_pair("P", en=HI, de=HALLO)]}, [], {}, {})
    write([e for e in entries if e.cls == "word"], {}, {}, dry_run=False, root=tmp_path)
    assert (tmp_path / "maps/X.asm").read_text() == 'S:\n\twritethistext\n\t\ttext "Hallo!"\n\t\tdone\n\tend\n'


def test_a_text_can_keep_all_its_capitals(tmp_path):  # where Polished's English shouts in capitals too
    from kristall_index import Entry
    from kristall_write import german_for, load_case
    put(tmp_path / "case.tsv", "#MON\t#mon\nDIE\tdie\n*\t*\tShout\n")
    case = load_case(tmp_path / "case.tsv")
    pair = fake_pair("P", en=HI, de=[("text", "DIE #MON, LAUF!"), ("done",)])
    assert german_for(Entry(fake_text(HI, label="Shout"), "word", pair, [pair], 1.0), {}, case).commands[0] == \
        ("text", "DIE #MON, LAUF!")
    assert german_for(Entry(fake_text(HI, label="Other"), "word", pair, [pair], 1.0), {}, {**case, "LAUF": "lauf"}
                      ).commands[0] == ("text", "die #mon, lauf!")
    put(tmp_path / "case.tsv", "#MON\t#mon\nDIE\tdie\n*\t*\tShout\n#MON\tPOKéMON\tShout\n")
    assert german_for(Entry(fake_text(HI, label="Shout"), "word", pair, [pair], 1.0), {}, load_case(tmp_path / "case.tsv")
                      ).commands[0] == ("text", "DIE POKéMON, LAUF!")  # its own answers still hold
