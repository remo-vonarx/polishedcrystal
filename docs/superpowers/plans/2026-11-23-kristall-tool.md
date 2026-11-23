# Kristall Tool and Checks (G4) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Pair every English text of pret's Crystal with Kristall's German by structure, sort every Polished text as word for word, changed or new, and build the writer, the drift check and the five line checks that chunk K and every later chunk run.

**Architecture:** Two ROM readers (pret's English, Kristall) are walked in lockstep through map scripts, phone scripts, text sections and pointer tables, and the pairs go to `.claude/upload/kristall_pairs.json`. A parser of Polished's asm texts feeds an index that classifies each text against the pairs; the writer, the drift check, the lookup and the English-left check all read that index. Nothing in G4 writes German into the game.

**Tech Stack:** Python 3.11 standard library (tools, run as `python3 -I`); pytest in the scratchpad venv (tests only).

**Spec:** `docs/superpowers/specs/2026-11-23-kristall-tool-design.md` (approved 2026-11-23). Roadmap: `docs/superpowers/plans/2026-11-23-translation-roadmap.md`, Task G4.

## Global Constraints

- Inputs, all read-only: `~/Development/pokecrystal` at `9ce4c4e50` with `pokecrystal.gbc` (revision 1.0), `.sym` and `.map`; Kristall's ROM `.claude/upload/Pokemon - Kristall-Edition (Germany).gbc` (SHA-1 `accb5842…`); Polished's tree; Upstream's English at `git merge-base HEAD upstream/master` (`c321e5284` until the first merge).
- Tools in `utils/`, Python 3 standard library only, run as `python3 -I`. Tests in `utils/tests/`, run with the scratchpad venv's pytest: `$VENV/bin/python -I -m pytest -p no:cacheprovider utils/tests -q` (`-p no:cacheprovider`: no `.pytest_cache` in the tree).
- Both ROMs: a text inside `if DEF(FAITHFUL)` has a Regular and a Faithful variant; both are handled. `if DEF(DEBUG)` blocks are left out everywhere.
- Polished's charmap since G3: `ß` `$c1`, `Ä ä Ö ö Ü ü` in the former Spanish slots, `'d` two tiles. Kristall's letters: pret's charmap plus `ß` `$be`, umlauts `$c0`–`$c5`, `$f2` the decimal point (as `.claude/upload/dump_german_text.py`).
- Nintendo text never goes into git: pairs, lookups and fixtures built from the ROMs live in `.claude/upload/` or a pytest temp dir. Committed `.tsv` files hold pret labels, English and single German words, never sentences.
- No guessed pair: a text that can't be paired by structure is reported as unpaired.
- `check_kristall.py` derives from Upstream's English and the ROMs, never from our files.
- G4 writes no German into the game: the writer runs as a dry run and in tests only.
- Commits: one-line imperative messages, no trailers (CLAUDE.md **Git**).

## Review Focus

1. A pret text reached by two paths (a `callstd` text, a `text_far` target shared by two maps): paired once; if the two paths lead to different Kristall addresses, the tool stops. Test in Task 2.
2. A Kristall character Polished's charmap lacks (`à è ù ç ë ï â ô û ê î`, `<DOT>`): the writer flags the text instead of writing a character that assembles to garbage. Test in Task 7.
3. A name swap in a paragraph whose width depends on a runtime value (`text_ram`, `<USER>`): the fit can't measure it, so the text is flagged, not written. Test in Task 7.
4. A Polished `text_far` stub whose target sits in another file: indexed as one text, and written into the target's file, never the stub's. Test in Task 6.
5. A Polished text whose Regular and Faithful variants differ: each variant is classified on its own, so one can be word for word while the other is changed. Test in Task 6.

---

## File Structure

| File | Responsibility |
|---|---|
| `utils/kristall_rom.py` | ROM and `.sym`/`.map` reading, the two charmaps, macro tables parsed from pret's asm, the text decoder |
| `utils/kristall_script.py` | the lockstep event-script interpreter |
| `utils/kristall_pairs.py` | the walk (maps, phone, text sections, tables, name tables), coverage, writes the pairs JSON; CLI |
| `utils/asm_text.py` | Polished's asm texts: parse (labels, lines, FAITHFUL variants, DEBUG dropped) and render back |
| `utils/kristall_index.py` | normalization, English renames, map-and-event locations, classification |
| `utils/kristall_lookup.py` | CLI: one text's class and its three review columns |
| `utils/kristall_write.py` | re-case, swap, fit, rebuild by Kristall's structure, flags; CLI, dry run by default |
| `utils/check_kristall.py` | the drift check |
| `utils/check_text_width.py`, `check_text_mode.py` | from `archive/first-attempt`, adapted |
| `utils/check_names.py`, `check_order.py` | from `archive/first-attempt`, adapted |
| `utils/check_english_left.py` | new |
| `utils/english_renames.tsv` | pret English → Polished English, generated part plus hand part |
| `utils/kristall_case.tsv`, `utils/kristall_choices.tsv` | re-casing dictionary and answers to flags; empty but for their header in G4 |
| `utils/tests/conftest.py` | `utils/` on `sys.path`; ROM fixtures that skip when a ROM is missing; a session `pairs` fixture built into a temp dir |
| `utils/tests/test_kristall.py` | the roadmap's five named tests and the Kristall tools' tests |
| `utils/tests/test_checks.py` | the line checks' tests |

Shared shapes (every task uses these names):

- `Cmd = tuple`: `("text", s)`, `("line", s)`, `("cont", s)`, `("para", s)`, `("next", s)`, `("page", s)`, `("done",)`, `("prompt",)`, `("text_end",)`, `("text_ram", "wStringBuffer1")`, `("text_decimal", "wMoney", bytes, digits)`, `("text_far", target)`, `("text_asm",)`, and the other inline commands by their macro name with their operands. A ROM text's RAM operand is its pret `.sym` name; a string keeps the tokens as asm writes them (`<PLAY_G>`, `#`, `#MON`).
- `Where = dict`: `{"map": "ROUTE_31", "event": "object"|"bg"|"coord"|"scene"|"callback", "x": int, "y": int}` or `{"trainer": "YOUNGSTER", "id": "JOEY1"}`; `None` for engine texts.
- Pair record (`kristall_pairs.json` → `"texts"`): `{"label", "kind": "map"|"phone"|"section"|"dex"|"move_desc"|"item_desc", "en_addr": "bb:aaaa", "de_addr": "bb:aaaa", "path": [str], "where": Where|None, "en": [Cmd], "de": [Cmd], "structure_differs": bool}`. `"names"`: `{"pokemon"|"moves"|"items"|"trainer_classes"|"landmarks": {pret_constant: [english, german]}}`. `"coverage"`: `{"unreached_dump": [addr], "unpaired_labels": [label]}`.

---

### Task 1: ROM reading and the text decoder

**Files:**
- Create: `utils/kristall_rom.py`, `utils/tests/conftest.py`, `utils/tests/test_kristall.py`

**Interfaces:**
- Produces: `PRET: Path` (`~/Development/pokecrystal`), `KRISTALL_ROM: Path`, `PAIRS_JSON: Path` (`.claude/upload/kristall_pairs.json`); `class Rom(path)` with `.data`, `.byte(bank, addr) -> int`, `.word(bank, addr) -> int`, `.offset(bank, addr) -> int`; `read_sym(path) -> dict[str, tuple[int, int]]`, `labels_at(sym) -> dict[tuple[int, int], str]` and `ram_names(sym) -> dict[int, str]` (WRAM/HRAM labels, `$C000`–`$FFFF`, by address); `read_sections(map_path) -> dict[str, tuple[int, int, int]]` (name → bank, start, end); `read_macros(asm_path) -> dict[int, Macro]` with `Macro(name: str, operands: list[Operand])`, `Operand(size: "db"|"dw"|"dba"|"dn"|"dwb", note: str)` (`note`: the comment after the operand, e.g. `"pointer"`, `"text_pointer"`); `PRET_CHARS: dict[int, str]` (pret's `constants/charmap.asm`), `KRISTALL_CHARS: dict[int, str]` (`PRET_CHARS` with the dump script's overrides); `decode_text(rom, bank, addr, chars, ram) -> Text` with `Text(commands: list[Cmd], length: int)`.
- conftest fixtures: `root`, `pret_rom`, `kristall_rom` (each `pytest.skip` when the file is missing).

- [ ] **Step 1: Make the venv ready.** If `$VENV` (the scratchpad's `venv`) is missing, create it as `utils/pyboy_play.py`'s docstring says; then `$VENV/bin/pip install pytest`.

- [ ] **Step 2: Write the failing tests**

```python
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
    assert t.commands[:3] == [("text", "OAK: Aha! So"), ("line", "you're <PLAY_G>!"), ("para", "I'm OAK! A #MON")]

def test_decode_kristall_text(kristall_rom):
    t = decode_text(kristall_rom, 0x69, 0x5A91, KRISTALL_CHARS, {})
    assert t.commands == [("text", "<PLAYER> übergibt"), ("line", "das #MON, das"),
                          ("cont", "den BRIEF trägt."), ("done",)]
```

- [ ] **Step 3: Run them to see them fail.** Expected: `ImportError` / `NameError`.

- [ ] **Step 4: Implement `utils/kristall_rom.py`.** `read_macros` reads `const <name> ; $xx` followed by its `MACRO`'s `db`/`dw`/`dba`/`dn`/`dwb` lines; a macro whose body uses `if`/`rept` is listed in a hand table with a comment, not guessed. The decoder takes command ids and operand sizes from `read_macros(PRET / "macros/scripts/text.asm")`; inside a string, `<LINE>` `<CONT>` `<PARA>` `<NEXT>` `@`(page) start a new `Cmd`, `<DONE>` `<PROMPT>` end the text; `text_end`, `text_asm`, `text_farend` end it too; `text_far` is recorded as `("text_far", (bank, addr))`, not followed.

- [ ] **Step 5: Run the tests to see them pass.**

- [ ] **Step 6: Commit.** `git commit -m "Read pret's and Kristall's ROMs and decode their texts"`

### Task 2: Lockstep walk of the map scripts

**Files:**
- Create: `utils/kristall_script.py`, `utils/kristall_pairs.py` (walk and CLI skeleton)
- Test: `utils/tests/test_kristall.py`

**Interfaces:**
- Consumes: Task 1.
- Produces: `class LockstepError(Exception)` (where, both byte runs); `walk_script(en, de, start_en, start_de, visit) -> None`, where `start_*` is `(bank, addr)` and `visit(kind: "text"|"script"|"movement", en_ptr, de_ptr, path: list[str])`; `build_pairs(pret_dir: Path, kristall: Path) -> dict` (the JSON shape above); `load_pairs(path=PAIRS_JSON) -> dict`; CLI `python3 -I utils/kristall_pairs.py [--out PATH]` writes the JSON and prints the coverage numbers. conftest gains a session fixture `pairs` that runs `build_pairs` into `tmp_path_factory`.

- [ ] **Step 1: Write the failing tests**

```python
def by_label(pairs, label):
    return next(p for p in pairs["texts"] if p["label"] == label)

def test_dump_gaps_are_paired(pairs):
    oak = by_label(pairs, "MrPokemonsHouse_OakText1")
    bank, addr = (int(x, 16) for x in oak["de_addr"].split(":"))
    assert bank == 0x65 and 0x7800 <= addr < 0x7900 and oak["where"]["map"] == "MR_POKEMONS_HOUSE"
    assert by_label(pairs, "Text_Route31ReadingMail")["de_addr"] == "69:5acd"

def test_map_text_pairs_with_dump(pairs):
    p = by_label(pairs, "Text_Route31HandOverMailMon")
    assert p["de_addr"] == "69:5a91" and p["de"][0] == ("text", "<PLAYER> übergibt")

def test_shared_text_pairs_once(pairs):          # Review Focus 1
    labels = [p["label"] for p in pairs["texts"]]
    assert len(labels) == len(set(labels))

def test_lockstep_mismatch_stops():
    en = fake_rom({0x4000: [IFEQUAL, 3, 0x00, 0x50, END]})   # ifequal 3, $5000 / end
    de = fake_rom({0x4000: [IFEQUAL, 4, 0x00, 0x50, END]})   # the compared byte differs
    with pytest.raises(LockstepError):
        walk_script(en, de, (1, 0x4000), (1, 0x4000), lambda *a: None)

def test_pointer_operands_are_paired_not_compared():
    en = fake_rom({0x4000: [JUMPTEXT, 0x10, 0x40]})
    de = fake_rom({0x4000: [JUMPTEXT, 0x20, 0x40]})
    seen = []
    walk_script(en, de, (1, 0x4000), (1, 0x4000), lambda kind, e, d, path: seen.append((kind, e, d)))
    assert seen == [("text", (1, 0x4010), (1, 0x4020))]

def test_one_pret_script_two_kristall_addresses_stops():
    en = fake_rom({0x4000: [SCALL, 0x10, 0x40, SCALL, 0x10, 0x40, END], 0x4010: [END]})
    de = fake_rom({0x4000: [SCALL, 0x10, 0x40, SCALL, 0x20, 0x40, END], 0x4010: [END], 0x4020: [END]})
    with pytest.raises(LockstepError):
        walk_script(en, de, (1, 0x4000), (1, 0x4000), lambda *a: None)
```

`fake_rom({addr: bytes})` is a test helper: a `Rom` with those bytes at those addresses in bank 1; the command ids (`IFEQUAL`, `JUMPTEXT`, `SCALL`, `END`) come from `read_macros`, so these tests need pret's source but no ROM.

- [ ] **Step 2: Run them to see them fail.**

- [ ] **Step 3: Implement `walk_script` in `utils/kristall_script.py`.** Command ids and operands from `read_macros(PRET / "macros/scripts/events.asm")`. The command byte and every operand that isn't a pointer must be equal in both ROMs; pointer operands (`dw`/`dba` with a pointer note) are paired, never compared. It follows `scall`, `farscall`, `sjump`, `farsjump`, the `if…` branches, `callstd` (pret's `StdScripts` table at the same index in both ROMs), and hands every text operand (`writetext`, `farwritetext`, `jumptext`, `farjumptext`, `jumptextfaceplayer`, `winlosstext`, …) to `visit`. A branch ends at `end`, `endcallback`, `return`, `endall` and the jumps that don't return; `callasm`, `special` and `memcall` targets are code and are counted, not followed. A worklist keyed by pret address visits each script once; a second visit with a different Kristall address raises `LockstepError`.

- [ ] **Step 4: Implement the map walk in `build_pairs`.** `MapGroupPointers` → map headers → attributes → scene scripts, callbacks and events, each with its `Where` (map constant from pret's `constants/map_constants.asm`, positions as `macros/scripts/maps.asm` lays them out: `coord_event` and `bg_event` store y before x, `object_event` stores y+4 and x+4). Object events of type script, item ball and trainer (trainer headers: seen, beaten, loss texts and the after-battle script; `Where` = trainer class and id constant from pret's `constants/trainer_constants.asm`). bg events by their function (read → script; the `BGEVENT_IF…` forms → their script). Each text the walk meets is decoded in both ROMs, `text_far` followed in both, and stored once by pret label.

- [ ] **Step 5: Run the tests to see them pass.**

- [ ] **Step 6: Commit.** `git commit -m "Pair map texts by walking both ROMs in lockstep"`

### Task 3: Phone, text sections, tables, names and coverage

**Files:**
- Modify: `utils/kristall_pairs.py`
- Test: `utils/tests/test_kristall.py`

**Interfaces:**
- Consumes: Tasks 1–2.
- Produces: the complete `build_pairs` output: `kind` `"phone"`, `"section"`, `"dex"`, `"move_desc"`, `"item_desc"`; `"names"`; `"coverage"`; `"structure_differs"` set on every pair.

- [ ] **Step 1: Write the failing tests**

```python
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
```

- [ ] **Step 2: Run them to see them fail.**

- [ ] **Step 3: Implement the rest of `build_pairs`.**
  - Phone: `PhoneContacts` (callee and caller scripts, `dba`) and `SpecialPhoneCallList` lead to scripts walked with `walk_script`, `kind` `"phone"`, `Where` the contact's trainer.
  - Text sections: from `read_sections`: "Text 1", "Text 2", "Text 3", "Phone Text", "Phone Text 2", "Crystal Phone Text", "Crystal Phone Text 2", "Special Phone Text", "Battle Tower Text" (check this list against `pokecrystal.map`; "Miscellaneous Text" is left to pointers). Each is read text by text from its start in both ROMs; the counts must be equal, and a pair already found through a script must agree, else `LockstepError`. A pair whose two command sequences differ in anything but string contents gets `structure_differs: True`.
  - Tables: `PokedexDataPointerTable`, `MoveDescriptions`, `ItemDescriptions` at their pret addresses in both ROMs; every Kristall pointer must lead to a well-formed entry of its kind, else stop and report.
  - Names: pret's `PokemonNames`, `MoveNames`, `ItemNames`, `TrainerClassNames` and the landmark names, read in both ROMs and keyed by pret constant.
  - Coverage: dump `[texts]` addresses no pair's `de_addr` covers, and pret labels in the walked sections that got no pair.

- [ ] **Step 4: Run the tests to see them pass.**

- [ ] **Step 5: Bring coverage down.** Run `python3 -I utils/kristall_pairs.py`; for each unreached group, follow what the walk misses (a command not followed, a table) and fix it. Stop when what's left can be named with a reason; keep that list for the PR body.

- [ ] **Step 6: Commit.** `git commit -m "Pair phone calls, text sections, tables and names"`

### Task 4: Width and text-mode checks

**Files:**
- Create: `utils/check_text_width.py`, `utils/check_text_mode.py` (from `archive/first-attempt`, `git show archive/first-attempt:utils/<name>.py`)
- Test: `utils/tests/test_checks.py`

**Interfaces:**
- Produces: `check_text_width.string_width(s: str) -> int`, `check_text_width.check_file(path) -> list[str]`, `strip_comment(line) -> str`; `check_text_mode.check_file(path) -> list[str]`. Both CLIs exit 1 on any problem.

- [ ] **Step 1: Write the failing tests**

```python
def test_width_counts_g3_letters():
    assert string_width("Straße") == 6 and string_width("Grüße") == 5
    assert string_width("he'd") == 4 and string_width("he's") == 3   # 'd is two tiles since G3
    assert string_width("#mon") == 7 and string_width("<PLAYER>") == 7

def test_width_check_clean_on_tree(root):
    assert run(root / "utils/check_text_width.py").returncode == 0

def test_text_mode_check_clean_on_tree(root):
    assert run(root / "utils/check_text_mode.py").returncode == 0

def test_text_mode_flags_prompt_without_string(tmp_path):
    f = tmp_path / "t.asm"; f.write_text('T:\n\ttext_ram wStringBuffer1\n\tprompt\n')
    assert check_text_mode.check_file(f)
```

`run(script)` is a test helper: `subprocess.run([sys.executable, "-I", script], cwd=root)`.

- [ ] **Step 2: Run them to see them fail.**

- [ ] **Step 3: Restore and adapt.** `TOKEN` loses `'d` (two tiles since G3); `data/abilities/descriptions.asm` gets 19 tiles (`PrintAbilityDescription`, `engine/pokemon/abilities.asm`, prints from `hlcoord 1, 15`), as `dex_entries.asm` already has. Any other line the tree reports is checked against the code that prints it: a wider print spot gets its own width with the routine named in a comment; nothing else is waved through.

- [ ] **Step 4: Run the tests to see them pass.**

- [ ] **Step 5: Commit.** `git commit -m "Bring back the width and text-mode checks"`

### Task 5: Name and order checks

**Files:**
- Create: `utils/check_names.py`, `utils/check_order.py` (from `archive/first-attempt`)
- Test: `utils/tests/test_checks.py`

**Interfaces:**
- Consumes: `check_text_width.string_width`.
- Produces: `check_names.GERMAN_TABLES: set[str]` (table keys as in its `TABLES`; empty in G4, each name chunk adds its tables); `check_names.check(base: str) -> list[str]`; `check_order.check(repo: Path, german: set[str]) -> list[str]` (`german` from `check_names.GERMAN_TABLES`).

- [ ] **Step 1: Write the failing tests**

```python
def test_names_clean_on_tree(root):
    assert run(root / "utils/check_names.py").returncode == 0

def test_german_table_with_english_fails(monkeypatch):
    monkeypatch.setattr(check_names, "GERMAN_TABLES", {"types"})
    assert any("Fire" in p for p in check_names.check(base=BASE))   # "Normal" is German too

def test_order_clean_on_tree(root):
    assert run(root / "utils/check_order.py").returncode == 0

def test_order_checks_german_tables(root):
    assert check_order.check(root, german={"key items"})   # Upstream's LIFT_KEY entries 31–34
```

`BASE` is `git merge-base HEAD upstream/master`, computed in conftest.

- [ ] **Step 2: Run them to see them fail.**

- [ ] **Step 3: Restore and adapt `check_names.py`.** An entry still English is reported only for a table in `GERMAN_TABLES`; limits are checked for every table. Each limit keeps a comment naming the code it comes from; a limit or rule that came from a first-attempt German wording is dropped (the badge stem's "den …orden." limit; the "user's choice" note on Psychic Inver, keeping only the 5-tile limit `PickPsychicInverParty` hardcodes); the break marks `<SHY>` and `<WBR>` go (not in this charmap), `¯` stays. Verify every remaining limit against the code on `master`.

- [ ] **Step 4: Restore and adapt `check_order.py`.** It checks only the tables in `GERMAN_TABLES`. Upstream's `KeyItemNameOrder` lists `NAM_HARSH_LURE`, `NAM_POTENT_LURE`, `NAM_MALIGN_LURE` before `NAM_LIFT_KEY`, against the constants' order (`constants/item_constants.asm`: `LIFT_KEY` is 20): an Upstream bug that chunk 3's re-sort fixes. Note it in the docstring.

- [ ] **Step 5: Run the tests to see them pass.**

- [ ] **Step 6: Commit.** `git commit -m "Bring back the name and order checks"`

### Task 6: Polished's texts and the index

**Files:**
- Create: `utils/asm_text.py`, `utils/kristall_index.py`, `utils/kristall_lookup.py`, `utils/english_renames.tsv`
- Test: `utils/tests/test_kristall.py`

**Interfaces:**
- Consumes: `load_pairs`, the pair record.
- Produces:
  - `asm_text.AsmText(label: str, path: str, start: int, end: int, variant: "both"|"regular"|"faithful", commands: list[Cmd], partial_faithful: bool)`; `asm_text.iter_texts(root: Path, paths=("maps", "data", "engine", "home"), source: Callable[[str], str] | None = None) -> Iterator[AsmText]` (`source(path)` returns a file's text, so the drift check can read Upstream's base with `git show`); `asm_text.render(commands: list[Cmd]) -> list[str]` (asm lines, tab-indented).
  - `kristall_index.normalize(commands, renames) -> str`; `load_renames(root) -> list[tuple[str, str]]`; `locate(root, source=None) -> dict[tuple[str, str], Where]` (keyed by path and label); `Entry(text: AsmText, cls: "word"|"ambiguous"|"changed"|"new", pair: dict|None, candidates: list[dict], score: float|None)`; `classify(texts, pairs, renames, locations, choices) -> list[Entry]`; `THRESHOLD: float`.
  - `kristall_lookup.columns(en: list[str], de: list[str], ours: list[str]) -> str` (CLAUDE.md's three 18-wide columns); CLI `python3 -I utils/kristall_lookup.py <file[:line] | label>`.
  - CLI `python3 -I utils/kristall_index.py --renames` regenerates the table part of `english_renames.tsv` and keeps its hand rows; `--stats` prints the count per class.

- [ ] **Step 1: Write the failing tests**

```python
def test_faithful_variants_parse_both(tmp_path):
    f = tmp_path / "maps/X.asm"; f.parent.mkdir(); f.write_text(
        "T:\n\ttext \"A\"\nif DEF(FAITHFUL)\n\tline \"B\"\nelse\n\tline \"C\"\nendc\n\tdone\n"
        "if DEF(DEBUG)\nD:\n\ttext \"dbg\"\n\tdone\nendc\n")
    texts = list(iter_texts(tmp_path, ("maps",)))
    assert [(t.variant, t.commands[1]) for t in texts] == [("regular", ("line", "C")), ("faithful", ("line", "B"))]

def test_rename_counts_as_word_for_word():
    pair = fake_pair("TinTowerSignText", en=[("text", "TIN TOWER"), ("done",)])
    text = fake_text(commands=[("text", "Bell Tower"), ("done",)])
    [e] = classify([text], {"texts": [pair]}, [("tin tower", "bell tower")], {}, {})
    assert e.cls == "word" and e.pair is pair

def test_ambiguous_english_is_flagged():
    a = fake_pair("A", en=EN, de=[("text", "Bis bald!"), ("done",)], where=W1)
    b = fake_pair("B", en=EN, de=[("text", "Auf Wiedersehen!"), ("done",)], where=W2)
    [e] = classify([fake_text(commands=EN)], {"texts": [a, b]}, [], {}, {})
    assert e.cls == "ambiguous" and {p["label"] for p in e.candidates} == {"A", "B"}
    [e] = classify([fake_text(commands=EN)], {"texts": [a, b]}, [], {("maps/X.asm", "T"): W2}, {})
    assert e.cls == "word" and e.pair is b

def test_text_far_stub_is_one_text(tmp_path):     # Review Focus 4
    put(tmp_path / "maps/X.asm", "S:\n\ttext_far _T\n\ttext_end\n")
    put(tmp_path / "data/text/t.asm", "_T:\n\ttext \"A\"\n\tdone\n")
    texts = [t for t in iter_texts(tmp_path, ("maps", "data")) if ("text", "A") in t.commands]
    assert [(t.path, t.label) for t in texts] == [("data/text/t.asm", "_T")]

def test_faithful_variants_classified_separately():   # Review Focus 5
    regular = fake_text(commands=[("text", "Come again!"), ("done",)], variant="regular")
    faithful = fake_text(commands=[("text", "See you, trainer!"), ("done",)], variant="faithful")
    pair = fake_pair("P", en=[("text", "Come again!"), ("done",)])
    entries = classify([regular, faithful], {"texts": [pair]}, [], {}, {})
    assert entries[0].cls == "word" and entries[1].cls != "word"

def test_index_on_real_data(pairs, root):
    entries = classify(list(iter_texts(root)), pairs, load_renames(root), locate(root), {})
    by = Counter(e.cls for e in entries)
    assert by["word"] > 1000 and by["new"] > 0
```

`fake_pair`, `fake_text`, `put(path, text)` (makes parent dirs) are test helpers in `test_kristall.py` building the record and `AsmText` shapes.

- [ ] **Step 2: Run them to see them fail.**

- [ ] **Step 3: Implement `utils/asm_text.py`.** Text commands as `macros/scripts/text.asm` (Polished) names them; a text runs from its label (or an inline start after `jumpthistext` and the like, labelled by the script) to `done`/`prompt`/`text_end`/`text_farend`/`text_asm`; `text_far` is resolved across files to its target; a text that is partly inside `if DEF(FAITHFUL)` yields both variants with `partial_faithful=True`; `DEBUG` blocks are skipped.

- [ ] **Step 4: Implement `utils/kristall_index.py` and `english_renames.tsv`.** `normalize` as the spec's **Normalized form**. The table part of the renames comes from `pairs["names"]` (English) against Polished's English tables by constant, with the constant pairs that differ (`PARLYZ_HEAL` / `PARALYZEHEAL`, more as found) in the hand part, each hand row with its reason; columns `pret<TAB>polished<TAB>reason`. `locate` reads each map's `def_object_events`, `def_bg_events`, `def_coord_events` and `generictrainer`/`trainer` lines and follows script labels to the texts they name in the same file. `classify` as the spec's three classes, settling ties by `Where`, then by `kristall_choices.tsv` (`polished_label<TAB>pret_label`); `changed` looks by `Where`, then label, then `difflib.SequenceMatcher` ratio of normalized English; set `THRESHOLD` from the real data's distribution and say in its comment how.

- [ ] **Step 5: Implement `utils/kristall_lookup.py`.**

- [ ] **Step 6: Run the tests to see them pass**, then `python3 -I utils/kristall_index.py --stats` and keep the numbers for the PR body.

- [ ] **Step 7: Commit.** `git commit -m "Index Polished's texts against pret's"`

### Task 7: The writer

**Files:**
- Create: `utils/kristall_write.py`, `utils/kristall_case.tsv`, `utils/kristall_choices.tsv` (headers only)
- Test: `utils/tests/test_kristall.py`

**Interfaces:**
- Consumes: Task 6's `Entry`, `render`; `check_text_width.string_width`.
- Produces: `name_map(root, pairs, base) -> dict[str, str]` (Kristall's name → ours, for table entries whose Polished entry differs from Upstream's English at `base`; empty in G4); `load_case(path) -> dict[str, str]`; `recase(commands, names, case) -> tuple[list[Cmd], list[str]]` (unknown capital runs); `fit(commands, width=18) -> list[Cmd] | None`; `rebuild(polished_en, pret_en, kristall_de) -> tuple[list[Cmd], list[str]]` (flags); `german_for(entry, names, case) -> Result(commands: list[Cmd] | None, flags: list[str])`; `write(entries, names, case, dry_run=True) -> Report(changed: list[str], flags: list[str])` (`changed`: `path:label` of each text rewritten); CLI `python3 -I utils/kristall_write.py [--write] [PATH ...]`, a dry run unless `--write`.

- [ ] **Step 1: Write the failing tests**

```python
def test_recase_non_names_and_split_words():
    case = {"NACHTs": "Nachts", "ARENALEITER": "Arenaleiter"}
    out, unknown = recase([("text", "des NACHTs"), ("line", "ARENA-"), ("cont", "LEITER ist da."), ("done",)], {}, case)
    assert out[:3] == [("text", "des Nachts"), ("line", "Arena-"), ("cont", "leiter ist da.")] and unknown == []

def test_unknown_capitals_are_reported():
    assert recase([("text", "Der FOO"), ("done",)], {}, {})[1] == ["FOO"]

def test_name_swap_rebreaks_paragraph():
    cmds = [("text", "Das ist der"), ("line", "ZINNTURM, so hoch"), ("cont", "wie nie."), ("done",)]
    out, _ = recase(cmds, {"ZINNTURM": "Glockenturm"}, {})
    fitted = fit(out)
    assert fitted and all(string_width(c[1]) <= 18 for c in fitted if len(c) > 1)
    assert " ".join(c[1] for c in fitted if len(c) > 1) == "Das ist der Glockenturm, so hoch wie nie."

def test_fit_with_runtime_variable_is_flagged():      # Review Focus 3
    cmds = [("text", "Der GLOCKENTURM von"), ("text_ram", "wStringBuffer1"), ("done",)]
    assert fit(cmds) is None

def test_unmapped_kristall_char_is_flagged():        # Review Focus 2
    r = german_for(word_entry(de=[("text", "Crème brûlée"), ("done",)]), {}, {})
    assert r.commands is None and any("û" in f for f in r.flags)

def test_structure_differs_follows_kristall():
    e = word_entry(
        polished=[("text_ram", "wStringBuffer1"), ("text", " stopped"), ("line", "evolving!"), ("prompt",)],
        pret_en=[("text_ram", "wStringBuffer2"), ("text", " stopped"), ("line", "evolving!"), ("prompt",)],
        de=[("text", "Entwicklung von"), ("text_ram", "wStringBuffer2"), ("line", "gestoppt!"), ("done",)],
        structure_differs=True)
    assert german_for(e, {}, {}).commands == [   # Kristall's order, Polished's variable and ending
        ("text", "Entwicklung von"), ("text_ram", "wStringBuffer1"), ("line", "gestoppt!"), ("prompt",)]

def test_unmappable_kristall_variable_is_flagged():
    e = word_entry(polished=[("text", "Hi!"), ("done",)], pret_en=[("text", "Hi!"), ("done",)],
                   de=[("text", "Hallo"), ("text_ram", "wNotInPolished"), ("done",)], structure_differs=True)
    r = german_for(e, {}, {})
    assert r.commands is None and any("wNotInPolished" in f for f in r.flags)

def test_partial_faithful_is_flagged():
    assert german_for(word_entry(partial_faithful=True), {}, {}).commands is None

def test_writer_is_idempotent(tmp_path):
    entries = entries_for(tmp_path, en=[("text", "Hi!"), ("done",)], de=[("text", "Hallo!"), ("done",)])
    assert write(entries, {}, {}, dry_run=False).changed
    before = (tmp_path / "maps/X.asm").read_bytes()
    again = entries_for(tmp_path, en=[("text", "Hi!"), ("done",)], de=[("text", "Hallo!"), ("done",)])
    assert write(again, {}, {}, dry_run=False).changed == []
    assert (tmp_path / "maps/X.asm").read_bytes() == before
```

`word_entry(...)` builds an `Entry` of class `word` from those command lists (`partial_faithful`, `structure_differs` as keywords); `entries_for(tmp_path, en, de)` writes `maps/X.asm` with one text `T` holding `en` (unless the file exists), and classifies it against one fake pair. A Polished RAM label is known when `ram/*.asm` defines it.

- [ ] **Step 2: Run them to see them fail.**

- [ ] **Step 3: Implement `utils/kristall_write.py`.** Re-casing looks up each run of capitals (a word with two or more capitals, `#MON` included) first in `names`, then in the case dictionary; a run split by `-` at a line end is looked up joined. `fit` re-breaks only a paragraph with a line wider than 18 (Pokédex entries: their file's width), greedily, keeping its `para` boundaries and ending; it returns `None` when a line can't be measured or can't fit. `rebuild` maps each pret RAM operand to Polished's form through the two English texts (same order in a word-for-word pair) and keeps Polished's box ending. Every character and token is checked against Polished's `constants/charmap.asm` (all its `charmap` names). `--write` replaces the text's lines in place with `render`, the label and frame kept.

- [ ] **Step 4: Run the tests to see them pass.**

- [ ] **Step 5: Dry run on the real tree.** `python3 -I utils/kristall_write.py` prints what it would change and every flag; nothing in the tree changes (`git status` clean but for new files). Keep the flag counts for the PR body.

- [ ] **Step 6: Commit.** `git commit -m "Write Kristall's text as ours, re-cased and fitted"`

### Task 8: The English-left and drift checks

**Files:**
- Create: `utils/check_english_left.py`, `utils/check_kristall.py`
- Test: `utils/tests/test_kristall.py`, `utils/tests/test_checks.py`

**Interfaces:**
- Consumes: `iter_texts` (with `source` reading `git show <base>:<path>`), `classify`, `german_for`.
- Produces: `check_english_left.check(root, base, paths) -> list[str]`; `SAME_IN_GERMAN: dict[str, str]` (line → reason); CLI `python3 -I utils/check_english_left.py [--base REV] PATH ...` (exit 1 on findings). `check_kristall.check(root, base, pairs) -> tuple[list[str], int]` (failures, inherited texts still English); CLI `python3 -I utils/check_kristall.py [--base REV]` (exit 1 on failures, prints the English count).

- [ ] **Step 1: Write the failing tests**

```python
def test_faithful_twin_left_english_is_reported(git_repo):
    # base: T: text "Hello" if DEF(FAITHFUL) line "Faithful there" else line "Regular there" endc done
    # head: the Regular line in German, the Faithful line unchanged
    found = check_english_left.check(git_repo, "base", ["maps"])
    assert found == ["maps/X.asm:4: Faithful there"]

def test_english_left_skips_debug(git_repo):
    # an English line inside `if DEF(DEBUG)`, the same at base and head
    assert check_english_left.check(git_repo, "base", ["maps"]) == []

def test_drift_check_passes_on_tree(pairs, root):
    failures, english = check_kristall.check(root, BASE, pairs)
    assert failures == [] and english > 1000

def test_hand_edit_of_inherited_text_fails(git_repo):
    # pair: en "Hi!" / de "Hallo!"; base: T "Hi!"; head: T "Hallo, du!"
    assert check_kristall.check(git_repo, "base", FAKE_PAIRS)[0]

def test_upstream_change_under_inherited_text_fails(git_repo):
    # base: T "Hi there!" (no longer word for word); head: T "Hallo!", the German for "Hi!"
    assert check_kristall.check(git_repo, "base", FAKE_PAIRS)[0]
```

`git_repo` is a fixture that builds a two-commit repo in `tmp_path` (a `base` tag and a head) from synthetic text written for the test, each test passing its own base and head files; `FAKE_PAIRS` is a synthetic pairs dict. The `check_english_left` lines read `path:line: text`.

- [ ] **Step 2: Run them to see them fail.**

- [ ] **Step 3: Implement `check_english_left.py`.** A line equal to Upstream's English at the same label and variant, `DEBUG` skipped, under the given paths only; `SAME_IN_GERMAN` lines (a name alone, "OK") pass, each with its reason.

- [ ] **Step 4: Implement `check_kristall.py`.** Classify Upstream's base English; for each word-for-word text, derive the German with `german_for` and compare with the current asm: English still there counts, anything else that differs fails. A text not word for word at the base whose current asm equals the German derived for its closest pair fails too (German left under changed English).

- [ ] **Step 5: Run the tests to see them pass.**

- [ ] **Step 6: Commit.** `git commit -m "Check inherited texts and English left over"`

### Task 9: Profile, roadmap and ship

**Files:**
- Modify: `CLAUDE.md` (profile row **Check scripts**), `docs/superpowers/plans/2026-11-23-translation-roadmap.md` (Task G4)

- [ ] **Step 1: Update the profile row.** **Check scripts**: each script, its command, what it checks and its known false alarms; the Kristall tools (`kristall_pairs.py` first, then `kristall_lookup.py`, `kristall_write.py`, `check_kristall.py`); the test command from **Global Constraints**; `GERMAN_TABLES` grows with each name chunk.

- [ ] **Step 2: Run everything.** The whole test suite passes; every check script exits 0 on the tree; `make` and `make tidy && make faithful vc` still build with only the profile's known warnings (no asm changed, so this proves nothing broke); `git status` shows nothing from `.claude/upload/`.

- [ ] **Step 3: Tick G4 in the roadmap plan** with the coverage, class and flag numbers.

- [ ] **Step 4: Commit.** `git commit -m "Document the Kristall tool and checks"`

- [ ] **Step 5: Ship** as CLAUDE.md's **Git** says (no in-game pass: the tool writes nothing yet). The PR body names the unreached texts left with their reasons, the class counts, the writer's flag counts and Upstream's `KeyItemNameOrder` bug.
