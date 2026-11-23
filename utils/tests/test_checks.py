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
    assert any('"Fire"' in p for p in check_names.check(base))  # "Normal" is German too


def test_untranslated_table_is_not_reported(base):
    import check_names
    assert not any("still English" in p for p in check_names.check(base))


def test_order_clean_on_tree(root):
    result = run(root / "utils/check_order.py", cwd=root)
    assert result.returncode == 0, result.stdout + result.stderr


def test_order_checks_german_tables(root):
    import check_order
    assert check_order.check(root, german={"key items"})  # Upstream's LIFT_KEY entries 31-34
