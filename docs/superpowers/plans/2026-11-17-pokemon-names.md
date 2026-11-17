# Pokémon, Type and Ability Names Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Every Pokémon, type, egg group, ability and nature name is German: in the tables, in the egg's and the Bad Egg's names, in the A–Z Pokédex order and in the type labels drawn as graphics. A name checker guards the tables from now on.

**Architecture:**
- German replaces the English in place, in the files under Scope. The `.asm` tables stay the only place a name lives.
- `utils/check_names.py` pairs each table with Upstream's English by position, read from git, and checks the German side.
- One code change, approved in the design: the PC's Bad Egg check tests the German name's first letter.
- One graphics change, approved in the design: `gfx/battle/types.png` gets Crystal Legacy's German letters.

**Tech Stack:** Python 3 (stdlib only), git, RGBDS 1.0.4 (`make vc`), `utils/huffman.py`, Azahar through `vc/gen_ctm.py` and `vc/playtest.py`, PokeAPI's CSV data, PokéWiki.

**Spec:** `docs/superpowers/specs/2026-11-17-name-tables-design.md` (part 1 and "Name checker"); CLAUDE.md's Project decisions.

## Global Constraints

- CLAUDE.md governs every string: Project decisions, Source priority, Text constraints, Style, Validation, Testing in the game. This plan doesn't repeat them.
- Only string contents change, plus the release check's letter (Task 2), the Bad Egg's run-length padding (Task 2), the reordered A–Z list (Task 2) and the type-label picture (Task 4).
- ß is written ss: "Mässig", "Kloakensosse", "Grossbrand", "Fussangel", "Hasenfuss".
- Every settled term goes into `TERMS.md` in the same commit as the strings that use it.
- Questions go to the user in question dialogs, one text per question.
- Branch `pokemon-names` (it holds the design commit); PR "Translate the Pokémon, type and ability names" on the fork, squash-merged.
- `$SCRATCH` is `scratchpad/names/` in the session scratchpad. PokeAPI's CSV files are cached in `$SCRATCH/pokeapi/` (fetched 2026-11-17 from `raw.githubusercontent.com/PokeAPI/pokeapi/master/data/v2/csv/`). Test scripts, fixtures, test clones, movies and screenshots stay in `$SCRATCH`.

## Scope

| List | File | Entries | German |
|---|---|---|---|
| Pokémon | `data/pokemon/names.asm` | 289 species | PokeAPI `pokemon_species_names.csv`, language 6; capitals as PokeAPI writes them. Upstream's cut "Dudunsparc" is species 982, "Dummimisel". `?000?` and `?256?` stay |
| Egg | `data/pokemon/names.asm` (the `Egg` row), `String_Egg` (`engine/pokemon/move_mon.asm`), `.EggName` (`engine/events/odd_egg.asm`), `.EggString` (`engine/events/wonder_trade.asm`), `.String_EGG` (`engine/events/daycare.asm`) | 5 | "Ei" (Kristall). `.EggString` stays 11 bytes: `"Ei@@@@@@@@@"` |
| Bad Egg | `data/pc/bad_egg.asm`; `engine/pc/bills_pc_ui.asm:2725` | 1 | "Schl. Ei", the user's choice (official "Schlechtes Ei", PokéWiki, is 13 characters). The run-length bytes spell it one letter per line, then `"@", 3` (11 − 8). The check becomes `cp 'S'`, and its comment names "Schl. Ei" and "Ei" |
| A–Z order | `data/pokemon/dex_order_alpha.asm` | 289 | The same `dp` lines, sorted by the species' German name with Python's `sorted(key=str.casefold)`. This reproduces both Kristall's order (ROM 10:4c5e: Ho-Oh before Hoothoot, Porygon before Porygon2) and Polished's English rules (Nidoran♀ before Nidoran♂, Porygon-Z before Porygon2) |
| Types | `data/types/names.asm`, `TypeNames` strings | 18 + `???` | Normal, Kampf, Flug, Gift, Boden, Gestein, Käfer, Geist, Stahl, Feuer, Wasser, Pflanze, Elektro, Psycho, Eis, Drache, Unlicht, Fee (PokeAPI). `???` stays |
| Egg groups | `data/types/names.asm`, egg-group strings | 7 + 3 + 3 | Monster, Feld, Humanotyp, Mineral, Amorph, Ditto, Unbekannt (PokeAPI `egg_group_prose.csv`). Non-Faithful: Amphibie, Fisch, Wirbellos (the user's choices). Faithful: Wasser 1, Wasser 2, Wasser 3 (official) |
| Abilities | `data/abilities/names.asm` | 159 | PokeAPI `ability_names.csv`, language 6. `---` stays |
| Natures | `data/natures.asm`, `.Hardy` … `.Quirky` | 25 | PokeAPI `nature_names.csv`, language 6. `---` and the `…Ind` strings stay |
| Type labels | `gfx/battle/types.png` | 18 | NORMAL, KAMPF, FLUG, GIFT, BODEN, GESTEIN, KÄFER, GEIST, STAHL, FEUER, WASSER, PFLANZE, ELEKTRO, PSYCHO, EIS, DRACHE, UNLICHT, FEE; the `???` label stays (Task 4) |

PokeAPI is matched by English name. Where Polished's English is shortened or spelt the Gen 2 way, match by hand and list each such match in the PR body.

**Answers** (2026-11-17, question dialogs with the design and the plan): the 4-PR split and its order; part 1's scope, natures included; the checker reads the `.asm` tables; the type labels are redrawn from Crystal Legacy's; Bad Egg "Schl. Ei"; Amphibie, Fisch, Wirbellos.

**Out**, each a later area: descriptions; the Pokédex's entries, categories (`"Egg@"` in `data/pokemon/dex_entries.asm`), labels, colours and shapes; the summary's and the trade screen's "Egg" labels; battle texts, `data/battle/stat_names.asm` and the pop-up's appended `'s`; dialogue that names a Pokémon; the Type Chart (part 2).

## Review Focus

1. **A 1-byte relative offset overflows.** `TypeNames`, `EggGroupNames` and `NatureNames` store each string as `dr` (`db \1 - @`), so a string must start within 255 bytes of its table entry. Expected: the build stays free of new warnings, and the last entries ("Fee", "Wirbellos", "Kauzig", `---`) read right on screen. Task 5 checks the warnings, Task 6 the screens.
2. **An egg keeps the English name on one path.** Expected: "Ei" after a gift, an Odd Egg, a Wonder Trade and the Day-Care alike. Task 2 runs `check_names.py --text` on the five files; a hit fails the task.
3. **The A–Z list loses, doubles or misorders a species.** Expected: the same 289 species, ordered as the Scope says. Task 2's `check_alpha.py` pins it.
4. **A type label's letters touch or cross the pill's edge, or a label slips a row.** Expected: every word inside the black pill with at least one black column on each side, on the label's own row. Task 4's `check_labels.py` pins it; Task 6 screenshots two labels side by side.
5. **The checker runs without an Upstream base and passes in silence.** Expected: exit 2 with a message naming `upstream/master`. Task 1's fixture F7 pins it.

---

### Task 1: The name checker

**Files:**
- Create: `utils/check_names.py`
- Modify: `CLAUDE.md` (profile rows "Check scripts" and "Test entry points")
- Create, uncommitted: `$SCRATCH/test_check_names.sh`, `$SCRATCH/fixtures/names/`

**Interfaces:**
- Produces: `python3 -I utils/check_names.py [--base REV] [--text [PATH ...]]`.
  - Default run: checks the tables. Exit 0 if clean, 1 on any problem, 2 if the English base can't be read.
  - `--base REV` replaces `git merge-base HEAD upstream/master`.
  - `--text`: lists English names left in string literals under the given paths (default `maps data engine home`), one line per hit. Exit 1 if there are any hits.
- Output lines, exactly:
  - `<path>:<line>: still English: "<name>"`
  - `<path>:<line>: too long (<tiles> > <limit>): "<name>"`
  - `<path>: <n> German entries, <m> English`
  - `<path>:<line>: <English> -> <German>: "<string>"` (text hits)
- Inside the checker:
  - `TABLES`: one entry per table, each with path, entry pattern, start and end label, limit in tiles, and text category (`'mon'` or none). Part 1:

    | Path | Entries | Limit | Category |
    |---|---|---|---|
    | `data/pokemon/names.asm` | every `rawchar` string, trailing `@` stripped | 10 | `mon` |
    | `data/types/names.asm` | `Label: db "…@"` strings from `Normal:` to `UnknownType:` | 8 | none |
    | `data/types/names.asm` | the same, from `Monster:` to the end, both Faithful branches in file order | 12 | none |
    | `data/abilities/names.asm` | `Label: rawchar "…@"` strings | 16 | none |
    | `data/natures.asm` | `.Label: db "…@"` strings between `NatureNames:` and `NatureIndicators:` | 7 | none |

    Parts 2–4 add rows here.
  - `SAME_IN_GERMAN`: the names that are official in both languages (Abra, Pikachu, Normal, Monster, Mineral, Ditto, the placeholders `?000?` `?256?` `???` `---`, …). Task 2 and Task 3 fill it from the final tables.
  - `TEXT_ALIASES`: English spellings in text that differ from the table, mapped to German. It starts empty.
- Tiles are counted as `check_text_width.py` counts them (`#` 4, `#mon` 7, `<PK>` 1, …). Reuse its counting or copy the rule; the counts must agree.
- Text scan:
  - It reads string literals only. Comments and `SECTION`, `INCLUDE` and `INCBIN` lines are skipped.
  - It matches whole words, case-sensitively: `(?<![A-Za-z_])Name(?![A-Za-z_])`, longest names first, so "Mewtwo" is one hit, not also "Mew".
  - It skips anything inside `<…>` tokens.

- [ ] **Step 1: Write the fixture runner and the fixtures.** `$SCRATCH/test_check_names.sh` builds one throwaway git repo per fixture under `$SCRATCH/fixtures/names/<name>/`. Each repo gets a copy of `utils/check_names.py` (and of `utils/check_text_width.py` if it's imported), with English tables committed and the branch `upstream/master` on that commit (except F7). The runner then writes the German side, runs the checker and compares the exit code and the output lines. It prints `PASS`/`FAIL` per fixture. Each fixture's tables are 3–4 entries long.

  | Fixture | German side | Expect |
  |---|---|---|
  | F1 clean | every entry translated, within limits | exit 0, no output |
  | F2 still English | `Bulbasaur` left in `names.asm` | exit 1, `data/pokemon/names.asm:<line>: still English: "Bulbasaur"` |
  | F3 same in German | `Pikachu` unchanged | exit 0 |
  | F4 too long | a 17-character ability | exit 1, `too long (17 > 16)` |
  | F5 tokens | the type `#Typen` (9 tiles) | exit 1, `too long (9 > 8)` |
  | F6 count | one more German Pokémon than English | exit 1, `data/pokemon/names.asm: 4 German entries, 3 English` |
  | F7 no base | no `upstream/master` branch, no `--base` | exit 2, a message naming `upstream/master` |
  | F8 natures | the `…Ind` strings after `NatureIndicators:` unchanged | exit 0 |
  | F9 Faithful | egg groups translated in the non-Faithful branch only, `Water 1` left in the Faithful one | exit 1, one `still English: "Water 1"` |
  | F10 text hit | `text "Bulbasaur is here"` in `maps/X.asm`, `--text maps` | exit 1, `maps/X.asm:1: Bulbasaur -> Bisasam: "Bulbasaur is here"` |
  | F11 text quiet | the name in a comment, on a `SECTION` line, inside `<…>`; `Mewtwo` in a string | exactly one hit, `Mewtwo` |
  | F12 egg | `rawchar "Egg@@@@"` in `engine/X.asm`, `--text engine` | exit 1, `Egg -> Ei` |

- [ ] **Step 2: Run the runner before the checker exists.** Expected: every fixture FAILs.
- [ ] **Step 3: Write `utils/check_names.py`** to the interface above, with a docstring in the style of `check_text_width.py` (usage, what it checks, exit codes).
- [ ] **Step 4: Run the runner.** Expected: 12 PASS.
- [ ] **Step 5: Run it on the tree.** `git fetch upstream`, then `python3 -I utils/check_names.py`. Expected: exit 1, every part-1 entry listed as still English except the placeholders, and no `too long` or count lines. Then run `--text` and save its output to `$SCRATCH/text_before.txt`. Expected: hundreds of hits in dialogue, which is the English the later areas translate. Read a sample of 30 hits; a hit caused by the parser is fixed in the checker and gets a new fixture.
- [ ] **Step 6: Update CLAUDE.md.**
  - In "Check scripts", replace "A name checker, ported from Crystal Legacy's check_names.py, comes with the name-table PR" with the checker's two runs: the default table check (clean on every PR), and `--text <paths>` for a dialogue PR's own files.
  - In "Test entry points", add: "The PC (room and Pokémon Center) and the title-screen prompts: `vc/README.md`, 'Reach the PC'". Then delete the memory `pending-profile-pointer`.
- [ ] **Step 7: Commit** `utils/check_names.py` and `CLAUDE.md`: "Add the name checker".

### Task 2: Pokémon names, eggs and the A–Z order

**Files:**
- Modify: `data/pokemon/names.asm`, `engine/pokemon/move_mon.asm`, `engine/events/odd_egg.asm`, `engine/events/wonder_trade.asm`, `engine/events/daycare.asm`, `data/pc/bad_egg.asm`, `engine/pc/bills_pc_ui.asm`, `data/pokemon/dex_order_alpha.asm`, `utils/check_names.py` (`SAME_IN_GERMAN`), `TERMS.md`
- Create, uncommitted: `$SCRATCH/gen_tables.py`, `$SCRATCH/check_alpha.py`

**Interfaces:**
- Consumes: `check_names.py` from Task 1.
- Produces: `$SCRATCH/gen_tables.py <list>`, which prints the German table lines for one list from the cached CSVs. Task 3 uses it for types, egg groups, abilities and natures.

- [ ] **Step 1: Write `check_alpha.py` and run it.** It maps each `dp` constant to its `names.asm` row through the species order in `constants/pokemon_constants.asm`. It asserts three things: `dex_order_alpha.asm` holds exactly the 289 species of `names.asm`, each once; their order equals `sorted(key=str.casefold)` of their German names; and the 251 Kristall species keep Kristall's relative order (ROM 10:4c5e, 251 bytes). Expected now: FAIL on the order.
- [ ] **Step 2: Cross-check the German names.** Compare PokeAPI's German species names with PokéWiki's `https://www.pokewiki.de/Pokémon-Liste` (cache the page in `$SCRATCH/web/`). Where they differ, PokéWiki wins and the PR body lists the difference.
- [ ] **Step 3: Write the German names** into `names.asm` with `gen_tables.py`, each padded with `@` to 10. Then `Egg` → `Ei` in all five places (Scope), and the Bad Egg's bytes and check.
- [ ] **Step 4: Re-sort `dex_order_alpha.asm`** and run `check_alpha.py`. Expected: PASS.
- [ ] **Step 5: Fill `SAME_IN_GERMAN`** with the species whose German name equals the English. Then run `python3 -I utils/check_names.py`. Expected: no line for `data/pokemon/names.asm`. Run `--text` on the five egg files. Expected: no hit.
- [ ] **Step 6: Check the Bad Egg by hand.** `bad_egg.asm` spells "Schl. Ei" followed by three `@` (11 bytes), the check is `cp 'S'`, and "Ei" starts with "E".
- [ ] **Step 7: Add TERMS.md rows:** Pokémon names (PokeAPI, equal to Kristall's for Gen 1–2), Egg = Ei (Kristall), Bad Egg = Schl. Ei (user), A–Z order (German sort).
- [ ] **Step 8: Build.** `make vc`. Expected: only CLAUDE.md's baseline warnings, no `-Wunmapped-char`.
- [ ] **Step 9: Commit:** "Translate the Pokémon names".

### Task 3: Types, egg groups, abilities and natures

**Files:**
- Modify: `data/types/names.asm`, `data/abilities/names.asm`, `data/natures.asm`, `utils/check_names.py` (`SAME_IN_GERMAN`), `TERMS.md`

**Interfaces:**
- Consumes: `gen_tables.py` from Task 2, `check_names.py` from Task 1.

- [ ] **Step 1: Run the checker.** Expected: exit 1, these four tables listed as still English.
- [ ] **Step 2: Cross-check the abilities** against PokéWiki's `https://www.pokewiki.de/Fähigkeiten-Liste`, the natures against `https://www.pokewiki.de/Wesen` and the types against `https://www.pokewiki.de/Typen`. PokéWiki wins on a difference, which the PR body lists.
- [ ] **Step 3: Write the strings** from Scope, with ß → ss. Keep the labels, the `dr` tables, the Faithful branches and the nature indicators as they are.
- [ ] **Step 4: Measure the abilities in pixels** with `gfx/font/vwf.vwf.widths` (a build product: index = character code − `$7F`, the space included). Expected: the widest is "Mega-Solarladung" at 75 of the pop-up's 80 pixels; the PR body says so.
- [ ] **Step 5: Fill `SAME_IN_GERMAN`** (Normal, Monster, Mineral, Ditto, …) and run the checker. Expected: exit 0.
- [ ] **Step 6: Add TERMS.md rows:** types (modern; Drache over Kristall's Drachen, ADR 0002; Fee), egg groups (official; Amphibie, Fisch, Wirbellos by the user), abilities and natures (PokeAPI).
- [ ] **Step 7: Build.** `make vc`. Expected: the baseline warnings only, in particular no truncation warning from a `dr` line (Review Focus 1).
- [ ] **Step 8: Commit:** "Translate the types, egg groups, abilities and natures".

### Task 4: The type labels

**Files:**
- Modify: `gfx/battle/types.png`, `TERMS.md`
- Create, uncommitted: `$SCRATCH/draw_labels.py`, `$SCRATCH/check_labels.py`

Geometry, measured 2026-11-17:
- **Polished.** Each label is 32 × 8 pixels: label *k* is rows 8k–8k+7. The PNG is 2-bit grayscale; 0 is black, 3 is white. The pill is black on rows 1–5 at columns 1–27, and on rows 0 and 6 at columns 2–26. Row 7 and columns 28–31 are white. The letters are white on rows 1–5, centred on column 14: NORMAL spans 3–25, FIGHT 5–23.
- **Crystal Legacy.** `~/Development/Pokemon_Crystal_Legacy/gfx/pokedex/types_light.png` holds 18 labels of 32 × 8 in the same type order (NORMAL … FEE). Its letters are black (0) on rows 2–6 of each label, on a light-gray pill (2). Measured widths: GESTEIN, PFLANZE and DRACHEN 25 px; ELEKTRO and UNLICHT 24; NORMAL, WASSER and PSYCHO 23; EIS and FEE 11.

- [ ] **Step 1: Write `check_labels.py` and run it.** It asserts the following:
  - The PNG is 32 × 160, 2-bit, and uses only shades 0 and 3.
  - Labels 0–17 (rows 0–143) hold Legacy's 18 words, with DRACHE being Legacy's DRACHEN without its last letter: on each label, the white pixels on rows 1–5 equal Legacy's black pixels on rows 2–6, shifted so the word starts at column `14 - width // 2` (this puts NORMAL at 3–25, as today).
  - Every white letter pixel lies in columns 2–26, so a black column stays on each side.
  - Every other pixel equals today's file with its letters painted black: the pill and its corners don't change.
  - Rows 144–159 (`???` and below) are unchanged.

  Expected now: FAIL.
- [ ] **Step 2: Write `draw_labels.py`** to produce exactly what `check_labels.py` asserts. For each label, it repaints the pill area black from today's file, then sets Legacy's letter pixels white. Run it on `gfx/battle/types.png`, then `python3 utils/grayscale.py gfx/battle/types.png`.
- [ ] **Step 3: Run `check_labels.py`.** Expected: PASS. Look at the PNG at 8× zoom; KÄFER's Ä must read as Ä.
- [ ] **Step 4: Add the TERMS.md row** for the type labels (Crystal Legacy's letters, full names, DRACHE).
- [ ] **Step 5: Build.** `make vc`. Expected: the baseline warnings only.
- [ ] **Step 6: Commit:** "Translate the type labels".

### Task 5: Build every variant and check the text

**Files:**
- Modify: `constants/huffman_text.inc` (only if it changes)

- [ ] **Step 1: Regenerate the Huffman tables** as `utils/huffman.py`'s docstring says. If `constants/huffman_text.inc` changes, then `make tidy && make vc`; a short script jump pushed past 255 bytes switches to its long form (Project decisions). Commit any change: "Regenerate the Huffman tables".
- [ ] **Step 2: Build the Faithful variant.** `make tidy && make faithful vc`. Expected: the baseline warnings only. Then `make tidy && make vc` again.
- [ ] **Step 3: Run every check.** `check_text_width.py` and `check_text_mode.py` show only CLAUDE.md's known hit. `check_names.py` exits 0. `check_alpha.py` and `check_labels.py` pass.
- [ ] **Step 4: Count the remaining English.** `check_names.py --text > $SCRATCH/text_after.txt`. Expected: exactly the hits of `text_before.txt` minus the five egg files. The PR body gives the count as what later areas will translate.

### Task 6: Test in the game

**Files:**
- Modify: `vc/README.md` (new section "Reach the Pokémon screens")
- Create, uncommitted: `$SCRATCH/clone/`, `$SCRATCH/clone-en/`, `$SCRATCH/movies/`, `$SCRATCH/shots/`

Two debug-build test clones share one hook: `$SCRATCH/clone` (this branch) and `$SCRATCH/clone-en` (`master`, for Polished's English screens). The hook goes at the end of the `if DEF(DEBUG)` block of `PlayersHouseRadio` (`maps/PlayersHouse2F.asm`), before `closetext`. It adds:
- `givepoke` for about six species. Their German names should cover both halves of the alphabet and two neighbours whose order the sort decides (e.g. Ho-Oh and Hoothoot, or Porygon and Porygon2). At least one should have an ability that pops up on entry (e.g. Intimidate).
- One `giveegg`.
- A wild battle (`loadwildmon` + `startbattle`) against a species with two types.

The radio already gives the Pokédex.

- [ ] **Step 1: Build both clones** (`make tidy && make debug vc`), package their CIAs (`vc/README.md`) and record a movie from the room movie's `base`, `speech`, `name` and `tail`, then the radio. Expected: both clones reach the room and run the hook.
- [ ] **Step 2: Screenshot the German clone:**
  - the party, with the egg named "Ei"
  - the summary of a two-type Pokémon: type labels, nature, ability
  - the Pokédex list in number order and in A–Z order
  - one species' stats page (labels, abilities) and bio page (egg groups)
  - the battle: the species name, the ability pop-up, a move's type label in the move info
- [ ] **Step 3: Take the same screens in the English clone** and compare by position (CLAUDE.md, Testing in the game). Expected: same layout, German fits, no label or name runs into its neighbour. Fix any problem in its task's files and repeat that screen.
- [ ] **Step 4: Write "Reach the Pokémon screens" in `vc/README.md`**: the hook and the movie's taps. Commit: "Document reaching the Pokémon screens". At merge, propose its pointer for CLAUDE.md's "Test entry points", as with the PC.
- [ ] **Step 5: List the screens seen and not reached** in the PR body: at least the Bad Egg (it needs a box checksum error) and Kristall's Pokédex (a new Kristall game has no Pokédex). Then open the PR.
