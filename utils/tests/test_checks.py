"""Tests of the line checks (utils/check_*.py)."""
import subprocess
import sys

import check_text_mode
from check_text_width import check_file, string_width


def run(script, *args, cwd=None):
    return subprocess.run([sys.executable, "-I", str(script), *args], cwd=cwd, capture_output=True, text=True)


def test_width_counts_g3_letters():
    assert string_width("Straße") == 6 and string_width("Grüße") == 5
    assert string_width("he'd") == 4 and string_width("he's") == 3  # 'd is two tiles since G3
    assert string_width("#mon") == 7 and string_width("<PLAYER>") == 7


def test_width_counts_freed_contractions_as_two_tiles():
    # Task 20 gave the slots of 'l 'm 'r 't 'v to á í ó ¿ ¡; only 's is still one tile
    assert string_width("auf'm") == 5 and string_width("can't") == 5
    assert string_width("geht's") == 5


def test_width_check_skips_debug_only_text(tmp_path):
    # `if DEF(DEBUG)` text is in neither ROM and stays English (CLAUDE.md)
    wide = '\ttext "This line is far too wide"\n\tdone\n'
    f = tmp_path / "t.asm"
    f.write_text("DebugText:\nif DEF(DEBUG)\n" + wide + "else\n" + wide + "endc\n", encoding="utf-8")
    problems = check_file(f)
    assert len(problems) == 1 and ":6:" in problems[0]  # only the else branch's line


def test_width_check_clean_on_tree(root):
    result = run(root / "utils/check_text_width.py", cwd=root)
    assert result.returncode == 0, result.stdout


def test_text_mode_check_clean_on_tree(root):
    result = run(root / "utils/check_text_mode.py", cwd=root)
    assert result.returncode == 0, result.stdout


def test_text_mode_flags_prompt_without_string(tmp_path):
    f = tmp_path / "t.asm"
    f.write_text("T:\n\ttext_ram wStringBuffer1\n\tprompt\n")
    assert check_text_mode.check_file(f)


def test_text_mode_flags_text_end_after_open_string(tmp_path):
    f = tmp_path / "t.asm"
    f.write_text('T:\n\ttext "Hi"\n\ttext_end\n')
    assert check_text_mode.check_file(f)


def test_names_clean_on_tree(root):
    result = run(root / "utils/check_names.py", cwd=root)
    assert result.returncode == 0, result.stdout + result.stderr


def test_german_table_with_english_fails(monkeypatch, base):
    import check_names
    monkeypatch.setattr(check_names, "GERMAN_TABLES", {"types"})
    monkeypatch.setitem(check_names.SAME_IN_GERMAN, "types", {"???"})  # "Normal" no longer allowed
    assert any('still English: "Normal"' in p for p in check_names.check(base))


def test_untranslated_table_is_not_reported(base):
    import check_names
    assert not any("still English" in p for p in check_names.check(base))


def test_order_clean_on_tree(root):
    result = run(root / "utils/check_order.py", cwd=root)
    assert result.returncode == 0, result.stdout + result.stderr


ORDER_FILES = ["constants/item_constants.asm", "constants/move_constants.asm", "constants/tmhm_constants.asm",
               "data/items/name_order.asm", "data/items/names.asm", "data/items/key_names.asm",
               "data/moves/names.asm", "data/moves/tmhm_order.asm", "data/moves/tmhm_moves.asm"]


def test_order_checks_german_tables(root, tmp_path):
    import check_order
    for rel in ORDER_FILES:
        (tmp_path / rel).parent.mkdir(parents=True, exist_ok=True)
        (tmp_path / rel).write_text((root / rel).read_text(encoding="utf-8"), encoding="utf-8")
    path = tmp_path / "constants/item_constants.asm"
    lines = path.read_text(encoding="utf-8").splitlines(keepends=True)
    key_alpha = [i for i, l in enumerate(lines) if l.startswith("; Alphabetical order")][1]
    first = next(i for i in range(key_alpha, len(lines)) if lines[i].startswith("\tconst NAM_"))
    lines[first], lines[first + 1] = lines[first + 1], lines[first]  # two key items out of A-Z order
    path.write_text("".join(lines), encoding="utf-8")
    assert check_order.check(tmp_path, german={"key items"})
    assert not check_order.check(tmp_path, german=set())  # an order is checked only once its table is German


FAITHFUL_TEXT = ('T:\n\ttext "{0}"\nif DEF(FAITHFUL)\n\tline "{1}"\nelse\n\tline "{2}"\nendc\n\tdone\n')


def test_faithful_twin_left_english_is_reported(git_repo):
    import check_english_left
    repo = git_repo({"maps/X.asm": FAITHFUL_TEXT.format("Hello", "Faithful there", "Regular there")},
                    {"maps/X.asm": FAITHFUL_TEXT.format("Hallo", "Faithful there", "Regulär dort")})
    assert check_english_left.check(repo, "base", ["maps"]) == ["maps/X.asm:4: Faithful there"]


def test_english_left_skips_debug(git_repo):
    import check_english_left
    text = 'T:\n\ttext "{}"\n\tdone\nif DEF(DEBUG)\nD:\n\ttext "Debug only"\n\tdone\nendc\n'
    repo = git_repo({"maps/X.asm": text.format("Hello")}, {"maps/X.asm": text.format("Hallo")})
    assert check_english_left.check(repo, "base", ["maps"]) == []


def test_english_left_passes_lines_same_in_german(git_repo):
    import check_english_left
    text = 'T:\n\ttext "{}"\n\tline "OK"\n\tcont "<PLAYER>!"\n\tdone\n'
    repo = git_repo({"maps/X.asm": text.format("Hello")}, {"maps/X.asm": text.format("Hallo")})
    assert check_english_left.check(repo, "base", ["maps"]) == []


def test_english_left_only_under_given_paths(git_repo):
    import check_english_left
    text = 'T:\n\ttext "Hello"\n\tdone\n'
    repo = git_repo({"maps/X.asm": text, "data/Y.asm": text}, {"maps/X.asm": text, "data/Y.asm": text})
    assert check_english_left.check(repo, "base", ["data"]) == ["data/Y.asm:2: Hello"]


INVER_FILES = ["data/trainers/psychic_inver.asm", "engine/battle/pick_psychic_inver_party.asm", "ram/wram0.asm"]


def copy_files(root, tmp_path, files):
    for rel in files:
        (tmp_path / rel).parent.mkdir(parents=True, exist_ok=True)
        (tmp_path / rel).write_text((root / rel).read_text(encoding="utf-8"), encoding="utf-8")


def edit(path, old, new):
    text = path.read_text(encoding="utf-8")
    assert text.count(old) == 1, old
    path.write_text(text.replace(old, new), encoding="utf-8")


def test_inver_name_shorter_than_party_prefix_is_reported(root, tmp_path):
    import re
    import check_names
    copy_files(root, tmp_path, INVER_FILES)
    assert not check_names.inver_problems(tmp_path)
    party = tmp_path / INVER_FILES[0]
    name = re.search(r'def_trainer 1, "([^"]*)"', party.read_text(encoding="utf-8")).group(1)
    edit(party, f'def_trainer 1, "{name}"', f'def_trainer 1, "{name[:-1]}"')
    assert check_names.inver_problems(tmp_path)


def test_inver_group_smaller_than_party_prefix_is_reported(root, tmp_path):
    import re
    import check_names
    copy_files(root, tmp_path, INVER_FILES)
    wram = tmp_path / INVER_FILES[2]
    size = re.search(r"wInverGroup::\n\tds (\d+)", wram.read_text(encoding="utf-8")).group(1)
    edit(wram, f"wInverGroup::\n\tds {size}", f"wInverGroup::\n\tds {int(size) - 1}")
    assert check_names.inver_problems(tmp_path)


def test_inver_check_reports_a_missing_party_prefix(root, tmp_path):
    import check_names
    copy_files(root, tmp_path, INVER_FILES)
    edit(tmp_path / INVER_FILES[1], "DEF INVER_PREFIX", "DEF INVER_HEADER")
    assert check_names.inver_problems(tmp_path)


SHUCKIE_FILES = ["maps/ManiasHouse.asm", "engine/events/shuckle.asm"]


def test_shuckie_ot_that_mania_does_not_check_for_is_reported(root, tmp_path):
    import re
    import check_names
    copy_files(root, tmp_path, SHUCKIE_FILES)
    assert not check_names.gift_ot_problems(tmp_path)
    returning = tmp_path / SHUCKIE_FILES[1]
    name = re.search(r'^SpecialShuckleOTAndExtra:\n\trawchar "([^"@]*)', returning.read_text(encoding="utf-8"), re.M).group(1)
    edit(returning, f'rawchar "{name}', 'rawchar "Kirk')
    assert check_names.gift_ot_problems(tmp_path)

def test_soft_hyphen_breaks_a_place_with_a_hyphen_on_the_pokegear():
    import check_names
    # 15 bytes with the mark; 14 tiles on one line, where it prints nothing; "Einheits-" over "tunnel"
    assert check_names.place_metrics("Einheits<SHY>tunnel") == (15, 14, [9, 6])


def test_silent_break_splits_a_place_without_a_hyphen():
    import check_names
    assert check_names.place_metrics("Knofensa-<WBR>Turm") == (14, 13, [9, 4])


def test_soft_hyphen_counts_toward_the_pokegear_line():
    import check_names
    # "Felsschlund" fits 11 tiles; with the hyphen the line is 12
    assert check_names.place_problems("Felsschlund<WBR>höhle", 18) == []
    assert check_names.place_problems("Felsschlund<SHY>höhle", 18) == ["Pokégear line too long (12 > 11)"]


def put(path, text):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text)


def text_asm(*commands):
    from asm_text import render
    return "\n".join(["T:"] + render(list(commands))) + "\n"


PUMPED = [("text_pause",), ("text", "<USER>"), ("line", "is getting pumped!"), ("prompt",)]


def test_commands_dropped_pause_fails(git_repo):
    import check_commands
    repo = git_repo({"maps/X.asm": text_asm(*PUMPED)},
                    {"maps/X.asm": text_asm(("text", "<USER>"), ("line", "Hallo!"), ("prompt",))})
    failures, _ = check_commands.check(repo, "base")
    assert len(failures) == 1 and "T" in failures[0] and "text_pause" in failures[0]


def test_commands_added_sound_fails(git_repo):
    import check_commands
    repo = git_repo({"maps/X.asm": text_asm(("text", "Hi!"), ("done",))},
                    {"maps/X.asm": text_asm(("text", "Hallo!"), ("text_sound", "SFX_DEX_FANFARE_50_79"), ("done",))})
    assert check_commands.check(repo, "base")[0]


def test_commands_reordered_buffers_pass(git_repo):
    import check_commands
    en = [("text_ram", "wStringBuffer3"), ("text", "'s"), ("line", ""), ("text_ram", "wStringBuffer4"), ("done",)]
    de = [("text_ram", "wStringBuffer4"), ("text", " von"), ("line", ""), ("text_ram", "wStringBuffer3"), ("done",)]
    repo = git_repo({"maps/X.asm": text_asm(*en)}, {"maps/X.asm": text_asm(*de)})
    assert check_commands.check(repo, "base") == ([], 1)


def listed_change(repo, label, english):
    from check_kristall import english_key
    put(repo / "utils/command_changes.tsv", f"# label, key, why\n{label}\t{english_key(english)}\tGerman plural\n")


def test_commands_listed_change_passes(git_repo):
    import check_commands
    en = [("text", "Hit"), ("text_decimal", "wStringBuffer1", "1", "1"), ("text", " time"), ("text_plural",), ("done",)]
    de = [("text", "Traf"), ("text_decimal", "wStringBuffer1", "1", "1"), ("text", "x."), ("done",)]
    repo = git_repo({"maps/X.asm": text_asm(*en)}, {"maps/X.asm": text_asm(*de)})
    listed_change(repo, "T", en)
    assert check_commands.check(repo, "base") == ([], 1)


def test_commands_listed_change_fails_when_english_changes(git_repo):
    import check_commands
    old = [("text", "Hit"), ("text_plural",), ("done",)]
    repo = git_repo({"maps/X.asm": text_asm(("text", "Hits"), ("text_plural",), ("prompt",))},
                    {"maps/X.asm": text_asm(("text", "Traf."), ("prompt",))})
    listed_change(repo, "T", old)
    failures, _ = check_commands.check(repo, "base")
    assert any("command_changes.tsv" in f and f.startswith("T:") for f in failures)


def test_commands_clean_on_tree(root, base):
    import check_commands
    failures, compared = check_commands.check(root, base)
    assert failures == [] and compared > 9000
