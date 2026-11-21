# Trainer Classes and Names Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Every trainer class, trainer name, trainer's Pokémon nickname, in-game trade name and the few other people's names in tables are German. Every class + name pair fits the 18-tile battle line, and the name checker measures each pair.

**Architecture:**
- Only string contents change: `data/trainers/class_names.asm`, the `def_trainer` and `tr_mon` strings in `data/trainers/parties.asm`, `data/events/npc_trades.asm`, `data/phone/non_trainer_names.asm`, `.DefaultRivalName` in `engine/events/specials.asm` and `.Ralph` in `engine/menus/intro_menu.asm`.
- Scratch scripts build each name from its sources (Modern names from PokéWiki, Kristall through Crystal Legacy, the user's answers) and leave every open name English, so the checker lists it.
- `utils/check_names.py` gets the new tables and a pair measure.

**Tech Stack:** Python 3 (stdlib), git, RGBDS 1.0.4 (`make vc`), Azahar through `vc/gen_ctm.py` and `vc/playtest.py`, PokéWiki, Kristall's dump and ROM, Crystal Legacy (`~/Development/Pokemon_Crystal_Legacy`, read-only).

**Spec:** `docs/superpowers/specs/2026-11-19-trainer-names-design.md`; part 1's `docs/superpowers/specs/2026-11-17-name-tables-design.md` ("Name checker"); CLAUDE.md.

## Global Constraints

- CLAUDE.md governs every string. ADR 0002 applies (the Modern name, Kristall's when the Modern one is over the limit, otherwise one Abbreviation, asked), and so does ADR 0003 (ss).
- Limits in tiles, as `check_text_width.string_width` counts them:
  - class 12;
  - trainer name 10;
  - nickname 10;
  - trade nickname 10, padded with `@` to 11 bytes;
  - trade OT 7, padded with `@` to 7 bytes plus `$00`;
  - rival default name 7;
  - Ralph's buffer 10;
  - a phone list line 17 (columns 2–18; `PokegearPhone_UpdateDisplayList` clears columns 1–18).
- The battle line: German class + space + name, at most 18 tiles; `<RIVAL>` counts 7.
- Female classes over 12 (the user's choices):
  - Leader: male "Leiter", female "Leiterin".
  - Ace Trainer: "Ass-Trainer" for both.
  - `<PK><MN>` Trainer: male "Trainer", female "Trainerin".
- When a pair doesn't fit, an official name (Modern or Kristall) is never shortened. The class gets shorter: Kristall's form first, otherwise one Abbreviation, asked. One string per class constant.
- Trade names:
  - The OT follows the person (Kristall: Mike "Ralf", Kyle "Tobi", Emy "Carmen", Chris "Paul"; Tim and Kim stay).
  - The nickname takes Kristall's only where Polished kept Crystal's English nickname ("Doris"; Chris's "Paul" is "Pollo"). Otherwise it's an own name, flagged.
- Own names:
  - German first names in Kristall's manner that fit the pair.
  - References that work in German stay (Uri, Jones, Inigo) and go into `SAME_IN_GERMAN`.
  - The same trainer (same class constant and English name) keeps one German name.
- Every settled term goes into `TERMS.md` in the same commit as the strings that use it:
  - one row per class;
  - rows for named characters;
  - one row per class listing its own names.
- Questions go to the user in dialogs of up to 4, each self-contained, with a preview of the battle line ("<Class> <Name>" / "möchte kämpfen!").
- Out of scope: the Battle Tower and Wonder Trade names (next PR), and dialogue that names trainers.
- Branch `trainer-names`, which holds the design commit. The PR is "Translate the trainer classes and names" on the fork, squash-merged with the bare title as the subject. Ask before pushing and merging.
- Scratch locations, never committed:
  - `$S4` is `scratchpad/trainers/` in the session scratchpad. It already holds `cl_en_parties.asm` (Crystal Legacy `9a5b41a27`, pret's English names) and `cl_de_parties.asm` (Crystal Legacy's current German names, from Kristall).
  - `$S1` (`scratchpad/names/`) holds the checker fixtures (`test_check_names.sh`, 34 passing).
  - Clones, movies and screenshots stay in scratch.

## Review Focus

1. **A trainer met several times (rematches).** Expected: one German name for every entry with the same class constant and English name. Task 3's and Task 4's dry runs assert it.
2. **Male and female entries of one English class.** Expected: each entry has its own decided form. Leader is "Leiter" for FALKNER and "Leiterin" for WHITNEY; Ace Trainer is "Ass-Trainer" for both; CAL is "Trainer" and CARRIE "Trainerin". Task 2's dry run asserts these five.
3. **Pair names and tokens in the pair measure** ("Amy & Mimi", `<RIVAL>`). Expected: "&" counts as one tile and `<RIVAL>` as 7. Fixtures F33c and F34 pin both.
4. **Trade padding.** Expected: each nickname stays 11 bytes and each OT 7 bytes plus `$00`, or the table's width assert stops the build. Task 5 checks every changed `rawchar` before `make vc`.
5. **`--text` noise from short generic names** ("Don", "May"). Expected: `--text` reports class names and named characters only. Fixture F36 pins it.

---

### Task 1: The checker learns trainers

**Files:**
- Modify: `utils/check_names.py`, `CLAUDE.md` ("Check scripts" row)
- Test: `$S1/test_check_names.py` (extend `EN` and `DE_SWAPS` with the new files; add fixtures)

**Interfaces:**
- Produces:
  - Patterns:
    - `TRAINER_NAME = r'^\s*def_trainer [^,]+, "([^"]*)"'`
    - `NICKNAME = r'^\s*tr_mon \d+, "([^"]*)"'`
    - `TRADE_NICKNAME = r'^\s*rawchar "([^"]*)"\s*$'`
    - `TRADE_OT = r'^\s*rawchar "([^"]*)", \$00'`
    - `PHONE_LINE = r'^\s*(?:text|next1)\s+"([^"]*)"'`
  - `TRAINER = 'trainer'` as the limit sentinel, like `PLACE`, and `BATTLE_LINE = 18`.
  - `trainer_pairs(root) -> list[tuple[int, str, str]]`: the parties.asm line number, the German class and the name, for every `def_trainer`.
    - Classes are the `trainerclass` lines of `constants/trainer_constants.asm` before `DEF NUM_TRAINER_CLASSES`, without `TRAINER_NONE`, zipped with the `li` entries of `class_names.asm`.
    - It raises `BaseError(f'{n} trainer classes, {m} class names')` when the counts differ.
  - `named_trainers(pairs) -> set[str]`: the names of classes whose `def_trainer` entries all carry one name, tokens excluded.
  - New `TABLES` rows:
    - `('data/trainers/class_names.asm', LI, None, None, 12, 'class', 'classes')`
    - `('data/trainers/parties.asm', TRAINER_NAME, None, None, TRAINER, 'person', 'trainers')`. Only `named_trainers` enter `names['person']`; every entry gets the 10-tile limit and the pair measure.
    - `('data/trainers/parties.asm', NICKNAME, None, None, 10, None, 'nicknames')`
    - `('data/events/npc_trades.asm', TRADE_NICKNAME, None, None, 10, None, 'trades')`
    - `('data/events/npc_trades.asm', TRADE_OT, None, None, 7, 'person', 'trades')`
    - `('data/phone/non_trainer_names.asm', PHONE_LINE, None, None, 17, None, 'phone')`
    - `('engine/events/specials.asm', RAWCHAR, 'DefaultRivalName', 'SpecialTrendyPhrase', 7, None, 'rival')`
    - `('engine/menus/intro_menu.asm', DB, 'Ralph', 'InitializeNPCNames', 10, None, 'ralph')`
  - `SAME_IN_GERMAN` keys `classes`, `trainers` (with `<RIVAL>`), `nicknames`, `trades`, `phone`, `rival` and `ralph`, all empty otherwise. Later tasks fill them.
  - The pair problem reads `f'{path}:{number}: class and name too long ({n} > 18): "{cls} {name}"'`, and `--text` filters it like the other name problems.

- [ ] **Step 1: Extend the fixtures.**
  - Add minimal English versions of the seven new files to `EN`, and German swaps to `DE_SWAPS`, so F1 stays clean.
    - The class list has 4 classes: CAL "<PK><MN> Trainer", FALKNER "Leader", BUG_CATCHER "Bug Catcher", RIVAL1 "Rival", with German "Trainer", "Leiter", "Käfersammler" and "Rivale".
    - FALKNER has two entries, both "Falkner" → "Falk". BUG_CATCHER has "Don" → "Tom" and "Wade" → "Udo". RIVAL1 has `"<RIVAL>"`.
  - New cases, with exact expected lines:
    - F31: a class left English → `still English: "Bug Catcher"`.
    - F32: a class of 13 → `too long (13 > 12)`.
    - F33: "Käfersammler" + "Wolfgang" → `class and name too long (21 > 18): "Käfersammler Wolfgang"`.
    - F33b: a pair of exactly 18 → clean.
    - F33c: "Käfersammler" + "Al & Bea" (8, "&" one tile) → `(21 > 18)`.
    - F34: "Rivale" + `<RIVAL>` → clean (14); an 11-tile class + `<RIVAL>` → `(19 > 18)`.
    - F35: a trade OT of 8 → `too long (8 > 7)`; a trade nickname left English → `still English`.
    - F36: `--text` on a map file with "Bug Catcher", "Falkner" and "Don" → hits for "Bug Catcher -> Käfersammler" and "Falkner -> Falk", none for "Don" (a class with two names).
    - F37: one class name removed from the fixture's 4 → exit 2, message `4 trainer classes, 3 class names`, with no traceback.
    - F38: a nickname of 11 → `too long (11 > 10)`.

- [ ] **Step 2: Run them.** `$S1/test_check_names.sh`. Expected: the 34 old cases PASS and the new ones FAIL (the checker doesn't know the files yet).

- [ ] **Step 3: Implement** the Interfaces above in `utils/check_names.py`, and extend the module docstring with the trainer tables and the pair measure.

- [ ] **Step 4: Run them.** `$S1/test_check_names.sh`. Expected: all pass. Then run `python3 -I utils/check_names.py` on the main checkout. Expected: `still English` lines for the new tables only, no other kind of problem, no traceback, exit 1.

- [ ] **Step 5:** Add to CLAUDE.md's "Check scripts" row, after the place sentence: "It measures each trainer's class and name together against the battle line: at most 18 tiles, `<RIVAL>` as 7; `--text` lists class names and named characters, not generic trainers' names." Commit "Teach the name checker the trainers".

### Task 2: Trainer classes

**Files:**
- Modify: `data/trainers/class_names.asm`, `TERMS.md`, `utils/check_names.py` (`SAME_IN_GERMAN['classes']`)
- Create (scratch): `$S4/classes.tsv`, `$S4/gen_classes.py`

**Interfaces:**
- Consumes: Task 1's checker.
- Produces: `$S4/classes.tsv`, with columns constant, English, female (y/n), Kristall, Modern, German, source. Task 3 reads the German class per constant from `class_names.asm` through `trainer_pairs`.

- [ ] **Step 1: Research** into `$S4/classes.tsv`, with a source URL per Modern name:
  - Kristall's 67 classes come from the dump line `0b:41ee`, in pret's class order. Crystal Legacy's `constants/trainer_constants.asm` gives the constant for each position.
  - Each class's name in the latest German game that has it comes from its PokéWiki class page; cache the pages in `$S4/pokewiki/`.
  - Mark female entries from the constant (`*F`, the female leaders, CARRIE, EUNA, LEAF, LYRA1, LYRA2, …) and from `data/trainers/genders.asm`.
- [ ] **Step 2: Dry run, test first.** `gen_classes.py` applies the rules in Global Constraints, then asserts:
  - FALKNER "Leiter", WHITNEY "Leiterin";
  - COOLTRAINERM and COOLTRAINERF "Ass-Trainer";
  - CAL "Trainer", CARRIE "Trainerin".
  - Every class must be at most 12.

  It prints the classes it can't settle: a Modern name over 12 with no Kristall name, a class with no official name, and any other female class over 12. Expected: the assertions pass, and the unsettled list is short.
- [ ] **Step 3: Ask** about each unsettled class in dialogs. Each question has the English, the constant and the battle line with that class's longest trainer name as its preview.
- [ ] **Step 4: Write** (`--write`). Run `python3 -I utils/check_names.py | grep class_names.asm`. Expected: nothing. Add the classes that really are the same in German to `SAME_IN_GERMAN['classes']`.
- [ ] **Step 5:** Add TERMS.md rows, one per class: English, German, source, and the female form where it differs. Run `make vc`; expected: baseline warnings only. Commit "Translate the trainer classes".

### Task 3: Trainer names from Kristall and later games

**Files:**
- Modify: `data/trainers/parties.asm` (`def_trainer` strings), `data/trainers/class_names.asm` (only for shortenings the user approves), `TERMS.md`, `utils/check_names.py` (`SAME_IN_GERMAN['trainers']`)
- Create (scratch): `$S4/trainers.tsv`, `$S4/gen_trainers.py`

**Interfaces:**
- Consumes: `trainer_pairs`; `$S4/cl_en_parties.asm` and `$S4/cl_de_parties.asm`.
- Produces: `$S4/trainers.tsv`, with columns line, constant, English, Kristall, Kristall match (exact, name-only or none), Modern, German, source. Task 4 reads the rows left English.

- [ ] **Step 1: Kristall.**
  - Pair `cl_en_parties.asm` with `cl_de_parties.asm` by party group and position. Skip the `PKMNTrainerF` group, which Crystal Legacy changed.
  - Assert 10 pairs against the dump's `[trainers]` lines by class number and position (Youngster #1 "JULIAN", Bug Catcher entries, a Lass).
  - Look up each Polished entry by (class constant, English name). Expected: about 429 exact matches and 89 name-only.
- [ ] **Step 2: Modern names.**
  - Read PokéWiki's per-game class pages, in particular "<Klasse>/Pokémon Goldene Edition HeartGold und Silberne Edition SoulSilver", and pages from later games for trainers Polished took from them.
  - Record the German name, the place and the source URL per trainer.
  - A name-only Kristall match counts only when the place or party shows it's the same trainer.
- [ ] **Step 3: Dry run, test first.**
  - `gen_trainers.py` picks Modern, then Kristall exact, then Kristall name-only (confirmed).
  - It re-cases to "Julian", "Lea & Lia" and writes ss for ß.
  - It asserts that every entry with the same constant and English name gets the same German name.
  - It prints counts per source and the pairs over 18.

  Expected: the assertion passes.
- [ ] **Step 4: Pairs over 18.** For each class with an official name that doesn't fit, ask in a dialog: Kristall's shorter class, or one Abbreviation. Preview the battle line of the longest pair. Write the answers to `class_names.asm` and update TERMS.md.
- [ ] **Step 5: Write** (`--write`). Run `python3 -I utils/check_names.py`. Expected: no pair problems, and `still English` only for names without an official source, plus Task 5's tables. Add the trainers whose official German name equals the English ("Bill", …) to `SAME_IN_GERMAN['trainers']`.
- [ ] **Step 6:** Add TERMS.md rows: one for the trainer-name sources, and one per named character (leaders, Elite Four, Champion, Kanto leaders, rivals, Lyra, and the other story trainers). Run `make vc`; expected: baseline warnings only. Commit "Translate the trainer names from Kristall and later games".

### Task 4: Own trainer names

**Files:**
- Modify: `data/trainers/parties.asm`, `TERMS.md`, `utils/check_names.py` (`SAME_IN_GERMAN['trainers']` for kept references)
- Modify (scratch): `$S4/gen_trainers.py` (an `OWN` table, label → German)

**Interfaces:**
- Consumes: the rows of `$S4/trainers.tsv` left English after Task 3.

- [ ] **Step 1: Propose** a German name per remaining trainer, grouped by class:
  - Kristall's manner, the class's era and voice.
  - The pair fits 18, and no German name is used twice in one class for different people.
  - References that work in German stay; a reference that doesn't work gets an equivalent, flagged and explained.
- [ ] **Step 2: Ask** one question per class, up to 4 classes per dialog. The preview lists "English → German" for every own name in the class. The options are "Take them (Recommended)" and "Change some", with the changes in the notes.
- [ ] **Step 3: Write.** Re-run Task 3's dry run with `OWN`, then `--write`. Run `python3 -I utils/check_names.py`. Expected: no problem in the `def_trainer` table; the kept references are in `SAME_IN_GERMAN['trainers']`.
- [ ] **Step 4:** Add TERMS.md rows, one per class, listing its own names (English → German). Run `make vc`; expected: baseline warnings only. Commit "Name the remaining trainers".

### Task 5: Nicknames, trades and other people

**Files:**
- Modify:
  - `data/trainers/parties.asm` (`tr_mon` nicknames)
  - `data/events/npc_trades.asm`
  - `data/phone/non_trainer_names.asm`
  - `engine/events/specials.asm` (`.DefaultRivalName`)
  - `engine/menus/intro_menu.asm` (`.Ralph`)
  - `TERMS.md`
  - the Huffman tables, if they change (`utils/huffman.py`'s docstring)

- [ ] **Step 1: Research.**
  - Kristall's trade table is in Crystal Legacy's `data/events/npc_trades.asm`. Its OT names and nicknames match the person and nickname rules in Global Constraints.
  - Kristall's default rival name and Magikarp record holder: search Kristall's ROM and dump; Crystal Legacy may hold them too.
  - Kristall's and the Modern names for the phone callers: Mama, Bill, Prof. Lind, Lyra, Buena, the bike shop.
  - Each subtitle line uses the German class from Task 2, after its three spaces (Lyra: "Trainerin").
  - An official nickname for a trainer's Pokémon, if a game gives one.
- [ ] **Step 2: Ask** about own nicknames (the 51 trainer nicknames left without a source, and trade nicknames under the rule), in dialogs grouped by trainer. Each preview shows the trainer's battle line and the nickname as the battle's name field shows it.
- [ ] **Step 3: Write.**
  - Trade nicknames keep 11 bytes (`@`-padded) and OT names 7 bytes plus `$00`. Assert every changed `rawchar` before building.
  - Regenerate the Huffman tables (`non_trainer_names.asm` is `text`).
  - Run `python3 -I utils/check_names.py`. Expected: no output, exit 0.
  - Run `make vc`. Expected: baseline warnings only.
- [ ] **Step 4:** Add TERMS.md rows for the trades (sources), the phone callers, the default rival name, Ralph's replacement and each own nickname. Commit "Translate the nicknames, trades and phone names".

### Task 6: Play-test

**Files:** none committed. Test clones `$S4/clone-de` (this branch) and `$S4/clone-en` (master), with hooks in each clone only.

- [ ] **Step 1: Hooks.** Make one debug build per case, since hooks fire unconditionally. The room PC runs the case after the debug radio has given a party:
  - A battle (`loadtrainer`, `startbattle`, `reloadmapafterbattle`) against:
    - the trainer with the longest German pair (from `trainer_pairs`);
    - a female class (Schwimmerin);
    - Whitney (a leader, and her nicknamed Miltank).
  - `addcellnum` for a trainer contact, then open the Pokégear's phone list.
  - `givepoke` of the wanted species, then the trade of a partner whose OT and nickname changed (Mike).
- [ ] **Step 2: Movies and shots**, both languages. Shoot densely (every 1.5 s) and keep the changed frames, as in part 3.
- [ ] **Step 3: Compare** German and English by position, and with Kristall where a new Kristall game reaches the same screen (otherwise name it as not reached). Expected:
  - The intro line holds class and name within 18 tiles.
  - The phone list shows the name and ":", with the class below at column 5.
  - The trade screen and the summary show the German nickname and OT.
- [ ] **Step 4:** Ledger the screens seen and not reached. A fix gets its own failing check first.

### Task 7: Validate and open the PR

- [ ] The checkers (names, order, width, mode), the fixtures, `make vc` and `make tidy && make faithful vc`, with baseline warnings only.
- [ ] `python3 -I utils/check_names.py --text maps data engine home | wc -l` for the PR body.
- [ ] Final whole-branch review; the fix pass.
- [ ] Ask the user, then push and open the PR. The body holds:
  - the summary and evidence, with the screens seen and not reached;
  - the class decisions and shortenings;
  - the own names by class;
  - the `--text` count;
  - the rulings and the merge danger.
