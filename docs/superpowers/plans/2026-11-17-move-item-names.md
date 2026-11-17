# Move and Item Names Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Every move, item, key item, apricorn, Exp. Candy, Pokégear card, wing and pocket name is German; HMs are "VM" with a bold V glyph; the Bag's and the TM pocket's A–Z orders follow the German names; the Bag tabs and the Type Chart are German graphics; the name checker covers it all.

**Architecture:**
- German replaces the English in place. The `.asm` tables stay the only place a name lives; a generator script fills them from PokeAPI, Kristall and the user's answers, and leaves every still-open name English so the checker lists it.
- A sort script rewrites the `NAM_` rank lists and `TMHMListAlpha` from the German names, keeping the Faithful variants in `if DEF(FAITHFUL)` blocks.
- Graphics (the `$CB` glyph, the Bag tabs, the Type Chart) are edited by scripts that keep each picture's tile layout.

**Tech Stack:** Python 3 (stdlib; PIL only in scratch viewers), git, RGBDS 1.0.4 (`make vc`), Azahar through `vc/gen_ctm.py` and `vc/playtest.py`, PokeAPI's CSV data, PokéWiki, the Kristall dump.

**Spec:** `docs/superpowers/specs/2026-11-17-move-item-names-design.md`; part 1's `docs/superpowers/specs/2026-11-17-name-tables-design.md` ("Name checker"); CLAUDE.md.

## Global Constraints

- CLAUDE.md governs every string: Project decisions, Source priority, Text constraints, Style, Validation, Testing in the game. ADR 0002 (Modern names, Abbreviation when too long) and ADR 0003 (ss) apply.
- Only string contents change, plus: `.HMText` (Task 3), the `$CB` glyph in the fonts (Task 3), the reordered rank lists (Task 4), `gfx/pack/pack_top.png` (Task 7) and the Type Chart graphics (Task 8).
- Name limit 12 for every table in this PR; Bill's PC item names within 80 px of the VWF.
- Sort rule: DIN 5007-1 (case-insensitive, Ä/Ö/Ü as A/O/U, ties by plain order).
- Every settled term goes into `TERMS.md` in the same commit as the strings that use it.
- Questions go to the user in question dialogs, one text per question, the pick first and marked "(Recommended)".
- Branch `move-item-names` (it holds the design commit); PR "Translate the move and item names" on the fork, squash-merged with the bare title as the subject; ask before pushing and merging.
- `$S2` is `scratchpad/names2/` in the session scratchpad; part 1's `$S1` (`scratchpad/names/`) holds the cached PokeAPI CSVs (`$S1/pokeapi/`) and the checker fixtures. Scripts, fixtures, clones, movies and screenshots stay in scratch.
- Night run (2026-11-17/18, the user away): Tasks 1–5 need no answers and run first. Tasks 6–9 wait for the user's answers; the night prepares their questions in `$S2/questions.md`.

## Scope

| List | File | German |
|---|---|---|
| Moves | `data/moves/names.asm` | PokeAPI `move_names.csv` (language 6), matched by English name; Polished's short spellings matched by hand (`$S2/aliases.py`: DazzlinGleam, Hi Jump Kick, Disarm Voice …) |
| Items | `data/items/names.asm` | PokeAPI `item_names.csv`; the 10 Mails, Brick Piece and Berserk Gene from Kristall (`$S2/kristall_items.json`), re-cased: Blumenbrief, Surferbrief, Cyanbrief, Abbildbrief, Herzbrief, Anara-Brief, Morph-Brief, Kobaltbrief, Melodiebrief, Trugbrief, Ziegelstein, Berserk-Gen |
| Key items | `data/items/key_names.asm` | PokeAPI; Cancel = Zurück (TERMS.md); GS Ball = GS-Ball (Kristall) |
| Apricorns | `data/items/apricorn_names.asm` | Aprikoko Rot, Aprikoko Blu, Aprikoko Glb, Aprikoko Grn, Aprikoko Wss, Aprikoko Swz, Aprikoko Pnk (Kristall's short forms) |
| Exp. Candy | `data/items/exp_candy_names.asm` | EP-Bonbon XS, S, M, L, XL |
| Pokégear cards | `data/items/special_names.asm` | #dex (same); #Com (Kristall's "#COM"); Radio-Modul (Kristall); Map Card and Expn.Card: Kristall's ROM or PokéWiki, else asked |
| Wings | `data/items/wing_names.asm` | PokeAPI `health-wing` … `clever-wing` |
| Pocket names | `data/items/pocket_names.asm` | Item-Tasche, Ball-Tasche, Basis-Items (Kristall); TM, Medicine, Berry: asked |
| HMs | `engine/items/tmhm2.asm` `.HMText` | "VM" |

**Open until the user answers** (left English by the generator; `$S2/questions.md` holds the candidates):
- Over the limit: Fähigkeitstausch, Schlangenblick, Zen-Kopfstoss; Marmoria-Kräcker, X-Verteidigung, X-Genauigkeit, X-Volltreffer, Fähigkeiten-Kapsel, Fähigkeiten-Pflaster, Spitzer Schnabel, Schattenbrille, Schutzsticker, Muschelglocke, Schwerschweif, Schwächenschutz, Offensivweste, Schutzpolster, Plateauschuhe, Fehlschlagschutz, Bizarroservice, Neutralschmuck, Gezinkter Würfel, Drachenschuppe, Verbindungsschnur, Silberkronkorken; Schlüsselkarte, Aufzugsschlüssel.
- Own names: Fresh Snack, Fury Strikes, Healing Light; Cake of Rage, Sweet Honey, Guard Stats, Mulch, Mint Leaf, Odd Souvenir, Armor Suit; Harsh Lure, Potent Lure, Malign Lure, Type Chart, Wing Case, OrangeTicket.
- Itemfinder (Detektor or Itemradar); Map Card and Expn.Card if no official name turns up; the TM, Medicine and Berry pocket names; the six Bag tab labels; the Type Chart's labels.

**Answers:** (filled in as the user answers)

## Review Focus

1. **A rank list loses, doubles or misplaces an item in one build variant.** Expected: the normal and the Faithful build each rank every item exactly once, in DIN 5007-1 order. Task 4's `check_order.py` evaluates the `if DEF(FAITHFUL)` blocks for both variants and pins it.
2. **The bold V breaks one of its three uses.** Expected: the TM pocket's HM line, the summary's "1 2 V" and the Pokédex's ability marker all show the new glyph, in every selectable font. Task 3 checks every font PNG's `$CB` tile changed and nothing else did; Task 5 sees two of the three uses on screen.
3. **An item name overflows Bill's PC.** Expected: every item name within 80 px. Task 2's generator check measures each name with the VWF widths.
4. **A table changes length or order.** Expected: every table has Upstream's entry count, row for row. The checker's count check (Task 1) and its default run after Task 2 pin it.
5. **The checker misses a leftover because of umlauts or a shared same-name.** Expected: "Seelöwe" doesn't count as "Seel", and a name allowed in one table is still reported in another. Task 1's fixtures F15 and F16 pin both.

---

### Task 1: The checker learns part 2

**Files:**
- Modify: `utils/check_names.py`, `CLAUDE.md` (the "Check scripts" row, only if its wording no longer matches)
- Test: `$S1/test_check_names.py` (fixtures; extend in place)

**Interfaces:**
- Produces: `TABLES` rows `(path, pattern, first, stop, limit, category, same_key)`; `LI = re.compile(r'^\s*li "([^"]*)"')`; `SAME_IN_GERMAN: dict[str, set[str]]` keyed by table key (`'pokemon'`, `'types'`, `'egg groups'`, `'abilities'`, `'natures'`, `'moves'`, `'items'`, `'key items'`, `'apricorns'`, `'exp candy'`, `'pokegear'`, `'wings'`, `'pockets'`); `--text` categories `'mon'`, `'move'`, `'item'`.

- [ ] **Step 1: Extend the fixtures.** Add minimal English versions of the eight new files to `EN` (two or three `li` entries each, `ItemPocketNames` with `.Item: db "Item Pocket@"` and `.Ball: db "Ball Pocket@"`) and their German swaps to `DE_SWAPS`, so F1 stays clean. New cases:
  - `F15-same-other-table`: the types table allows "Normal"; a fixture move left as `li "Normal"` (English "Normal") is reported `still English`.
  - `F16-umlaut-boundary`: the Pokémon fixture gains Seel → Jurob; `--text` on `text "Seelöwe Seel."` reports exactly one hit, for `Seel.`.
  - `F17-missing-path`: `--text nope` exits 2 with one line `check_names.py: no such path: nope`, no traceback.
  - `F18-missing-table`: German `data/items/wing_names.asm` deleted → exit 1, line `data/items/wing_names.asm: file not found`.
  - `F19-no-git`: run with `PATH` pointing at an empty directory → exit 2, a line starting `check_names.py:` and naming git, no traceback.
  - `F20-li-english`: an item left `li "Potion"` → `still English: "Potion"`.
  - `F21-li-too-long`: a move `li "Abcdefghijklm"` → `too long (13 > 12)`.
  - F7's expected text becomes `git fetch upstream`.
- [ ] **Step 2: Run** `$S1/test_check_names.sh`. Expected: F1 and every new case FAIL (missing tables), F2–F14 as before.
- [ ] **Step 3: Implement** the new `TABLES` rows (limit 12; pocket names `LOCAL_DB` from `ItemPocketNames` to the file end), per-table `SAME_IN_GERMAN` (move part 1's names into their tables' sets), the umlaut-aware boundary (`(?<![A-Za-zÄÖÜäöüé_])…(?![A-Za-zÄÖÜäöüé_])`), and messages instead of tracebacks: a missing path or file, git missing or failing. The `--text` categories gain `'move'` and `'item'` (items, key items, apricorns, candies, cards, wings).
- [ ] **Step 4: Run** the fixtures. Expected: `21/21 passed`. Then the tree: `python3 -I utils/check_names.py | grep -c "still English"` — part 1's tables report nothing; the count is part 2's entries.
- [ ] **Step 5: Commit** "Teach the name checker the move and item tables".

### Task 2: Fill the tables

**Files:**
- Modify: the eight files under Scope, `TERMS.md`
- Create: `$S2/gen_names.py`

**Interfaces:**
- Consumes: Task 1's checker; `$S2/matched2.json`, `$S2/aliases.py`, `$S2/kristall_items.json`, `$S2/vwf.py` (`width(s) -> int`).
- Produces: `gen_names.py REPO [--write]` → for each table the German list (open names keep their English), and `$S2/names_de.json` `{file: [[english, german_or_None], …]}` for Tasks 4 and 6. `OVERRIDES` dict English → German for the user's answers.

- [ ] **Step 1: Write the check first:** `gen_names.py` without `--write` prints every planned name that is over 12 characters, over 80 px, contains a character outside the charmap, or is open. Run it. Expected: no over-limit or charmap line; the open list equals Scope's "Open" list.
- [ ] **Step 2: Write** (`--write`): replace each `li` string in place, both branches of the Faithful blocks (RageCandyBar → Wutkeks, Honey → Honig, Guard Spec. → Megablock, Rock Smash → Zertrümmerer).
- [ ] **Step 3: Run** `python3 -I utils/check_names.py`. Expected: only `still English` and `too long` lines for the open names, no count lines. `make vc`: the 2 baseline warnings, no `-Wunmapped-char`.
- [ ] **Step 4: TERMS.md** rows: move names, item names (source per list as in Scope), Mails/Brick Piece/Berserk Gene (Kristall), apricorns (Kristall's short forms as the Abbreviation), EP-Bonbon, wings, #Com, Radio-Modul, the three Kristall pocket names. Commit "Translate the move and item names" (open names still English).

### Task 3: VM and the bold V

**Files:**
- Modify: `engine/items/tmhm2.asm` (`.HMText`), each font PNG in `gfx/font/` that holds a `$CB` glyph, `TERMS.md`
- Create: `$S2/draw_boldv.py`, `$S2/check_boldv.py`

- [ ] **Step 1: Test first:** `check_boldv.py` compares each font PNG with `master`'s: only the `$CB` tile may differ, it must differ, it must use only the font's shades, and it must not equal any other tile in that font. Run it. Expected: FAIL (`$CB` unchanged).
- [ ] **Step 2:** `.HMText` → `db "VM"`. Draw the bold V in each font's style from that font's bold H (same stroke width and height), then `python3 utils/grayscale.py <png>`.
- [ ] **Step 3: Run** `check_boldv.py` (PASS) and `make vc` (baseline warnings only). Add a 6× contact sheet of every font's old and new `$CB` to `$S2/shots/` for the PR.
- [ ] **Step 4:** TERMS.md row "HM | VM | item names, TM pocket; bold V also marks the hidden ability". Commit "Name the HMs VM".

### Task 4: The A–Z orders

**Files:**
- Modify: `constants/item_constants.asm` (the two `NAM_` lists under "Alphabetical order"), `data/moves/tmhm_order.asm`
- Create: `$S2/sort_names.py`, `$S2/check_order.py`

**Interfaces:**
- Consumes: the German tables (current tree), `data/items/name_order.asm` (item index → `NAM_` constant), `constants/move_constants.asm` and the `TM_`/`HM_` constants (TM → move).
- Produces: `sort_names.py REPO [--write]`; `check_order.py REPO` → exit 0 when both variants are in DIN 5007-1 order.

- [ ] **Step 1: Test first:** `check_order.py` evaluates the `if DEF(FAITHFUL)` blocks for the normal and the Faithful variant, maps every rank entry to its German name (Faithful names in the Faithful variant) and checks: each item/key item/TM exactly once, order equals `sorted(names, key=din5007)`. Run it. Expected: FAIL (English order).
- [ ] **Step 2: Implement** `sort_names.py`: build the sorted sequence for each variant, then merge the two with `difflib.SequenceMatcher` into one list, writing entries only one variant has inside `if DEF(FAITHFUL)` / `if !DEF(FAITHFUL)` blocks. Key: `din5007(s) = (s.casefold().translate({ä: a, ö: o, ü: u}), s)`.
- [ ] **Step 3: Run** `sort_names.py --write`, `check_order.py` (PASS), `make vc` and `make tidy && make faithful vc` (baseline warnings). Open names sort under their English for now; Task 6 re-runs this task's script.
- [ ] **Step 4:** TERMS.md row "A–Z item and TM order | DIN 5007-1". Commit "Sort the Bag and the TM pocket by German name".

### Task 5: Play-test the night's work

**Files:**
- Create (scratch only): `$S2/clone-de/`, `$S2/clone-en/` (from this branch and `master`), a hook, a movie in `vc/local/movies/`, screenshots in `$S2/shots/`

- [ ] **Step 1:** Clone both trees; apply the same debug hook to both (as `vc/README.md` "Reach the Pokémon screens", plus: the first party Pokémon holds an item and has its hidden ability). `make tidy && make debug vc`, then `vc/build_cia.sh` → `names2-de`, `names2-en`.
- [ ] **Step 2:** One movie, both builds: radio gifts → Bag (Items list, sort by name, Medicine, Balls, TM pocket in number and A–Z order with an HM, Berries, Key Items) → party summary (moves page, ability with "V") → Bill's PC with the held item → a wild battle's FIGHT menu.
- [ ] **Step 3:** Contact sheets German/English side by side; compare by position. Expected: German names in the same places, no name past its box, the bold V on the HM line and the ability marker, A–Z lists in German order.
- [ ] **Step 4:** Ledger the screens seen and not reached. No commit (scratch only), unless a fix is needed; a fix gets its own failing check first.

### Task 6: The user's answers (after the night)

- [ ] Ask the questions in `$S2/questions.md` (dialogs of up to 4, one preview each). Record each answer under **Answers** and in `TERMS.md`.
- [ ] Add the answers to `gen_names.py`'s `OVERRIDES`; re-run Task 2's steps 1–3 (expected: the checker prints nothing) and Task 4's script and check. Commit "Settle the remaining move and item names".

### Task 7: The Bag tabs

**Files:** `gfx/pack/pack_top.png`; `$S2/draw_tabs.py`, `$S2/check_tabs.py`

- [ ] Test first: `check_tabs.py` checks the size (160 × 8), the shades, each label inside its own tab's tiles as `engine/items/pack.asm` highlights them, and the arrow tile unchanged. Expected FAIL, then draw the user's six labels in the tab font, PASS, build, see every tab highlighted in Azahar. Commit "Translate the Bag tabs".

### Task 8: The Type Chart

**Files:** `gfx/type_chart/bg.png`, `gfx/type_chart/ob.png` (and `type_chart.tilemap`/`.attrmap` only if the tile layout must change); `$S2/draw_chart.py`, `$S2/check_chart.py`

- [ ] Test first: `check_chart.py` rebuilds `bg.2bpp` with the Makefile's flags and checks that the unique-tile count and order still match the checked-in tilemap (or that regenerated maps match the picture), and that only label areas changed. Expected FAIL, then draw the user's labels (row labels in the 3-pixel font, rotated column heads, ATK/DEF), PASS, build, see the chart in Azahar. Commit "Translate the Type Chart".

### Task 9: Validate and open the PR

- [ ] The checkers (names, width, mode), the fixtures, `check_order.py`, `check_boldv.py`, `make vc` and `make tidy && make faithful vc` with baseline warnings only.
- [ ] Final play-test of every Testing screen in the design against the English clone; final whole-branch review; fix pass.
- [ ] Ask the user, then push and open the PR (body: summary, evidence, screens seen and not reached, the `--text` count, rulings, merge danger).
