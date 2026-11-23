"""Tests of the line checks (utils/check_*.py)."""
import subprocess
import sys

import check_text_mode
from check_text_width import string_width


def run(script, *args, cwd=None):
    return subprocess.run([sys.executable, "-I", str(script), *args], cwd=cwd, capture_output=True, text=True)


def test_width_counts_g3_letters():
    assert string_width("Straße") == 6 and string_width("Grüße") == 5
    assert string_width("he'd") == 4 and string_width("he's") == 3  # 'd is two tiles since G3
    assert string_width("#mon") == 7 and string_width("<PLAYER>") == 7


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


def test_order_checks_german_tables(root):
    import check_order
    assert check_order.check(root, german={"key items"})  # Upstream's LIFT_KEY entries 31-34


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
