# Battle Tower and Wonder Trade Names Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Every Battle Tower pair fits the 18-tile battle line through Battle Tower-only short classes, Palmer and Thorton get their German names, every Wonder Trade name is German where a German name exists, and the name checker covers both lists.

**Architecture:**
- One small engine change: `GetOTName` swaps four class names for short forms from a new ROMX table when `wInBattleTowerBattle` is set.
- Otherwise only string contents change: two Battle Tower names, the Wonder Trade names, `TERMS.md`.
- The Wonder Trade names come from a research table in scratch. Each entry is first identified (who it is), then given its German name by the spec's source order, and written by a script.
- `utils/check_names.py` gets both tables, the Battle Tower pair measure and a list-level "kept" rule.

**Tech Stack:** Python 3 (stdlib), git, RGBDS 1.0.4 (`make vc`), Azahar through `vc/gen_ctm.py` and `vc/playtest.py`, PokéWiki, Kristall's dump.

**Spec:** `docs/superpowers/specs/2026-11-21-tower-wonder-trade-names-design.md`; CLAUDE.md; part 4's spec `docs/superpowers/specs/2026-11-19-trainer-names-design.md`.

## Global Constraints

- CLAUDE.md governs every string: ADR 0002 (the Modern name; Kristall's when the Modern one is over the limit; otherwise one Abbreviation, asked) and ADR 0003 (ss).
- Limits, counted by `check_text_width.string_width`:
  - Battle Tower name 9, padded with `@` to 9 bytes before the class (`rawchar "Viktor@@@", TOWERTYCOON`);
  - Wonder Trade name 7, padded with `@` to 7 bytes (`rawchar "Rot@@@@" ; $00`); `'l` and the other contractions are one byte;
  - a Battle Tower short class at most 12 bytes.
- Battle Tower pair: the class (short form where the table has one) + space + name, at most 18 tiles.
- The short classes are the user's, verbatim: BUG_CATCHER "Käfersamml.", BUG_MANIAC "Käferman.", BEAUTY "Schönh.", COSPLAYER "Cosplayer". They apply to every Battle Tower trainer of those classes, and to nothing outside Battle Tower battles.
- Battle Tower names stay English except Palmer → Viktor and Thorton → Distmar.
- Wonder Trade:
  - A `TERMS.md` row applies only to the same character.
  - Source order: `TERMS.md` → Modern name (PokéWiki) → Kristall (Gen 2 character with no later game, or Modern over the limit; Crystal's English kept where HeartGold/SoulSilver renamed) → the German Pocket Monsters SPECIAL for heroes named after versions, else the German version name → German anime dub (flagged Anime name) → unchanged.
  - Kept: real people, Polished's developers, Japanese names of Pokémon characters, other franchises' Japanese names, Greek letters and letter versions (Alpha, X).
  - An English name already cut to 7 is translated from the full name.
- Questions go to the user in dialogs of up to 4, each self-contained (file:line, English, who, source, where it shows), one preview per name.
- Every settled term goes into `TERMS.md` in the same commit as the strings that use it.
- No change to ROM0. Code, labels and comments stay English.
- Branch `tower-wonder-trade-names` from `master`. The first commit holds the spec and this plan. The PR is "Translate the Battle Tower and Wonder Trade names" on the fork, squash-merged with the bare title as subject. Ask before pushing and merging.
- Scratch, never committed:
  - `$S5` is `tower-wt/` in the session scratchpad: research, scripts, clones, movies, shots.
  - `$S1` is `names/`, which holds the checker fixtures. Part 4's fixtures went with an old scratchpad, so Task 1 rebuilds them.
  - The English base is `c321e5284` (`git merge-base master upstream/master`).

## Review Focus

1. **Regular trainers of the four classes.** Expected: "Käfersammler Greg" outside the Battle Tower, including in the same session after a Battle Tower battle, since `RunBattleTowerTrainer` restores the flag. Task 5 plays a regular Bug Catcher battle in the Battle Tower build.
2. **Link battles.** Expected: the class line is still the other player's name. `GetOTName` keeps its `wLinkMode` branch ahead of the swap. Task 2 Step 3 states it; the whole-branch review checks it, since link battles can't be played here.
3. **One English spelling, two people.** Expected: an entry takes a `TERMS.md` row only for the same character. Task 3's merge script lists every entry whose English matches a `TERMS.md` row but whose identified character differs, and each such entry gets an explicit decision.
4. **Padding and contractions.** Expected: each Wonder Trade entry is 7 bytes, `Li'l D` included (`'l` is one byte), and each Battle Tower entry 9 bytes. Otherwise `table_width` stops the build. Task 4's write script asserts the byte count of every changed `rawchar` before `make vc`.
5. **Viktor and Distmar under their classes.** Expected: "Kampfkoloss Viktor" (18) and "Fabrikltr. Distmar" (18) fit. The Battle Tower pair measure covers them; fixtures T0 and T3 pin the kept rule's two exceptions.

---

### Task 1: The checker learns the Battle Tower and Wonder Trade

**Files:**
- Modify: `utils/check_names.py` (module docstring, `TABLES`, `SAME_IN_GERMAN`, `check_tables`), `CLAUDE.md` ("Check scripts" row)
- Test: `$S1/test_check_names.py` (new)

**Interfaces:**
- Produces:
  - `TOWER = 'tower'`, a limit sentinel like `TRAINER`; `TOWER_NAME = 9`; `TOWER_CLASSES = 'data/battle_tower/short_class_names.asm'`.
  - `class_names(root) -> dict[str, str]`: class constant → German class. This is the part of `trainer_pairs` that zips `trainerclass` constants with `class_names.asm`, moved out unchanged with the same `BaseError`. `trainer_pairs` calls it.
  - `tower_short_classes(root) -> dict[str, str]`: constant → short class, from `^\s*db (\w+),\s*"([^"]*)"` lines in `TOWER_CLASSES`, with `@` stripped. A missing file gives `{}`. An unknown constant raises `BaseError(f'{TOWER_CLASSES}:{n}: unknown trainer class {const}')`. A short class over 12 bytes (`name_bytes`) is a problem line: `f'{TOWER_CLASSES}:{n}: too many bytes ({b} > 12): "{short}"'`.
  - `tower_pairs(root) -> dict[int, tuple[str, str]]`: `classes.asm` line → (the class shown, the name), from `^\s*rawchar "([^"]*)",\s*(\w+)`.
  - `class AllBut(frozenset)`: `name in AllBut(s)` is true for every name not in `s`. It is `SAME_IN_GERMAN['tower'] = AllBut({'Palmer', 'Thorton'})`.
  - New `TABLES` rows:
    - `('data/battle_tower/classes.asm', RAWCHAR, None, None, TOWER, None, 'tower')`: 9 tiles per name, plus the pair against `BATTLE_LINE`;
    - `('data/events/wonder_trade/ot_names.asm', RAWCHAR, None, None, 7, None, 'wonder trade')`, with `SAME_IN_GERMAN['wonder trade'] = set()`, filled in Task 4.
  - The Battle Tower pair problem reads like the trainers' pair problem (`class and name too long (n > 18): "<class> <name>"`), and `--text` filters it the same way.

- [ ] **Step 1: Write the fixtures.**
  - `$S1/test_check_names.py` clones the branch into `$S1/repo` (`git clone --shared`, then `git fetch` of `c321e5284` from the main checkout).
  - The **pinned state**, so the cases hold before and after Task 2: the clone's HEAD, plus Task 2's short table written by the harness (the four entries from Global Constraints), with `classes.asm` lines 136–137 set to `"Palmer@@@"` and `"Thorton@@"`.
  - For each case, the harness:
    1. resets the clone (`git -C $S1/repo checkout -- . && git -C $S1/repo clean -fdq`) and writes the pinned state;
    2. applies the case's edits as (path, old, new) replacements;
    3. runs `python3 -I utils/check_names.py --base c321e5284` inside the clone;
    4. asserts the lines added to and removed from the pinned state's output, and the exit code.
  - Expected lines below shorten `data/battle_tower/classes.asm` and `data/events/wonder_trade/ot_names.asm` to their file names; the real output carries the full path.
  - Cases:
    - T0, the pinned state itself: its `classes.asm` lines are exactly `classes.asm:136: still English: "Palmer"` and `classes.asm:137: still English: "Thorton"`, so Hopper (line 55) isn't reported and every pair fits. No `ot_names.asm:404` line says `too long` (`Li'l D` is 5 tiles).
    - T1: `"Darwin@@@"` → `"Darwinius"` (9 letters, fits) → nothing added. `"Darwin@@@"` → `"Darwiniusx"` adds `classes.asm:104: too long (10 > 9): "Darwiniusx"` and `classes.asm:104: class and name too long (22 > 18): "Käfersamml. Darwiniusx"`.
    - T2: the BUG_CATCHER line removed from the short table adds `classes.asm:104: class and name too long (19 > 18): "Käfersammler Darwin"` and the same for line 107, "Käfersammler Tajiri".
    - T3: `"Palmer@@@"` → `"Viktor@@@"` removes `classes.asm:136: still English: "Palmer"` and adds nothing.
    - T4: BUG_CATCHER's short class → `"Käfersammler1"` (13 bytes) adds `short_class_names.asm:N: too many bytes (13 > 12): "Käfersammler1"` and the pair lines for lines 104 and 107 (20 > 18).
    - T5: the short table with `db BUG_CATHCER, …` → exit 2, and `check_names.py: data/battle_tower/short_class_names.asm:N: unknown trainer class BUG_CATHCER` on stderr, with no traceback.
    - T6: Wonder Trade line 10 `"Crystal"` → `"Kristall"` adds `ot_names.asm:10: too long (8 > 7): "Kristall"` and removes line 10's `still English`.
    - T7: Wonder Trade line 263 (`"Shigeru"`) removed → the table's lines are replaced by `ot_names.asm: 511 German entries, 512 English`.

- [ ] **Step 2: Run them.** `python3 -I $S1/test_check_names.py`. Expected: every case FAILS, since the checker doesn't know the files yet.

- [ ] **Step 3: Implement** the Interfaces in `utils/check_names.py`. Extend the module docstring: the Battle Tower names (9), each measured with its class against the battle line, with the short form where `short_class_names.asm` has one; the list kept as English except Palmer and Thorton; the Wonder Trade names (7).

- [ ] **Step 4: Run them.** `python3 -I $S1/test_check_names.py`. Expected: all pass. On the main checkout, `python3 -I utils/check_names.py`. Expected: the five long Battle Tower pairs, Palmer and Thorton `still English`, and `still English` lines for Wonder Trade only. No traceback.

- [ ] **Step 5:** In CLAUDE.md's "Check scripts" row, after the trainers' battle-line sentence, add: "Battle Tower names (`data/battle_tower/classes.asm`, 9 characters) are measured the same way, with the Battle Tower's short class where `data/battle_tower/short_class_names.asm` has one; the list counts as kept except Palmer and Thorton. Wonder Trade names fit 7." Commit "Teach the name checker the Battle Tower and Wonder Trade".

### Task 2: Battle Tower short classes, Viktor and Distmar

**Files:**
- Create: `data/battle_tower/short_class_names.asm`
- Modify: `engine/battle/read_trainer_attributes.asm` (`GetOTName`, and the `INCLUDE` at its end), `data/battle_tower/classes.asm:136-137`, `TERMS.md`

**Interfaces:**
- Consumes: Task 1's checker.
- Produces:
  - `BattleTowerShortClassNames`: `db <class constant>, "<short>@"` per class, in the order BUG_CATCHER, BUG_MANIAC, BEAUTY, COSPLAYER, ended by `db -1`. A comment says what it is for (Battle Tower battles, GetOTName).
  - `GetBattleTowerShortClassName`: in: `[wTrainerClass]`, de = the full class. Out: de = the short name if the class is in the table, otherwise de unchanged. It may clobber a, bc and hl.

- [ ] **Step 1: Failing check.** `python3 -I utils/check_names.py | grep classes.asm`. Expected: the five pairs over 18, plus Palmer and Thorton.

- [ ] **Step 2: Write the table** with the four entries from Global Constraints.

- [ ] **Step 3: Change `GetOTName`.** When `wLinkMode` is non-zero, keep today's path (copy `wOTPlayerName`). Otherwise call `GetTrainerClassName`, then `GetBattleTowerShortClassName` when `wInBattleTowerBattle` is non-zero, then copy as today. `INCLUDE "data/battle_tower/short_class_names.asm"` at the end of `read_trainer_attributes.asm`, so the table shares GetOTName's ROMX bank ("Enemy Trainers") and `CopyBytes` reads it directly.

- [ ] **Step 4: Names.** Line 136 `rawchar "Viktor@@@", TOWERTYCOON`, line 137 `rawchar "Distmar@@", FACTORYHEAD`.

- [ ] **Step 5: Run.** `python3 -I utils/check_names.py | grep classes.asm`. Expected: nothing. `python3 -I $S1/test_check_names.py`. Expected: all pass. Then `make vc`. Expected: baseline warnings only, nothing over bank `$FF`. Check that ROM0 didn't move: `make freespace` shows the same ROM0 free bytes as `master`.

- [ ] **Step 6: TERMS.md:**
  - four rows, e.g. `| Bug Catcher (Battle Tower) | Käfersamml. | Trainer classes | Abbreviation in Battle Tower battles only; the user's choice (2026-11-21) |`;
  - one row `| Battle Tower names | kept as in English, except Palmer → Viktor and Thorton → Distmar | Trainer names | the user's choice (2026-11-21) |`.

  Commit "Shorten four classes in Battle Tower battles".

### Task 3: Wonder Trade research

**Files:** scratch only: `$S5/research/<block>.tsv`, `$S5/merge_wt.py`, `$S5/wt.tsv`.

**Interfaces:**
- Produces: `$S5/wt.tsv`, one row per entry (512), tab-separated: `index`, `line`, `english`, `who` (character and origin, e.g. "Crystal's heroine (Pokémon Crystal)"), `kind` (one of `version`, `official`, `manga`, `anime`, `real`, `dev`, `japanese`, `franchise`, `fan`, `unknown`), `german` (empty while open), `source` (`TERMS`, `modern`, `kristall`, `manga`, `version`, `anime`, `kept`), `url`, `note`.

- [ ] **Step 1: Research in blocks**, one agent each, by the list's own grouping:
  - 0–63: versions, letters, heroes and rivals;
  - 64–191: professors, Kanto to Alola leaders, Elite Four, champions;
  - 192–351: Battle Frontier, villains, trade partners and Gen 2 side characters;
  - 352–511: later side characters, anime, other franchises, fan games, developers.

  Each agent:
  - identifies each entry from its neighbours and PokéWiki;
  - fills `german` and `source` by the spec's source order;
  - sets `german` = `english` with `kept` for the kept kinds;
  - leaves `german` empty with a note where it can't decide;
  - gives a PokéWiki URL for every `modern`, `manga` and `anime` name;
  - reads Kristall's names from `.claude/upload/german_text_dump.txt`.

  Agents read `TERMS.md`, the spec and Global Constraints.

- [ ] **Step 2: Merge** with `$S5/merge_wt.py`, which writes `wt.tsv` and asserts:
  - 512 rows, indexes 0–511, `english` equal to the file's entries in order;
  - every `modern`, `manga` and `anime` row has a URL;
  - no `german` over 7 tiles unless its note says "over limit";
  - and it prints: every entry whose `english` matches a `TERMS.md` row while its `who` names a different character; every `unknown`; every empty `german`.

- [ ] **Step 3: Check a sample.** For 20 random `modern`/`manga`/`anime` rows, open the URL and confirm the German name. A wrong one sends its block back to Step 1.

### Task 4: Wonder Trade questions and names

**Files:**
- Modify: `data/events/wonder_trade/ot_names.asm`, `utils/check_names.py` (`SAME_IN_GERMAN['wonder trade']`), `TERMS.md`

**Interfaces:**
- Consumes: `$S5/wt.tsv` (Task 3), the checker (Task 1).

- [ ] **Step 1: Ask**, in dialogs of up to 4:
  - every German name over 7 with no Kristall name: the full name, the limit, one or two Abbreviations, why each stays unambiguous;
  - every entry Step 2 of Task 3 printed (spelling clash, unknown, empty).

  Each preview shows the name as the trade screen shows it.

- [ ] **Step 2: Write** with `$S5/write_wt.py`. It replaces each entry's name and pads it with `@` to 7 bytes, keeping the `; $xx` comment. It asserts each written `rawchar` is 7 bytes (contractions and `<PK><MN>` as their charmap bytes) and that nothing else in the file changed (`git diff` touches only `rawchar` lines).

- [ ] **Step 3: Kept names.** Add every entry with `german == english` that the checker reports to `SAME_IN_GERMAN['wonder trade']`.

- [ ] **Step 4: Run.**
  - `python3 -I utils/check_names.py`. Expected: no output, exit 0.
  - `python3 -I utils/check_order.py`. Expected: pass.
  - Regenerate the Huffman tables (`utils/huffman.py`'s docstring). Expected: `constants/huffman_text.inc` unchanged, since `rawchar` isn't text; commit it if it changed.
  - `make vc`. Expected: baseline warnings only.

- [ ] **Step 5: TERMS.md.** One row per decided name not already there (English, German, "Wonder Trade names", source), grouped as in part 4; one row for the kept kinds; each Abbreviation and Anime name flagged. Commit "Translate the Wonder Trade names".

### Task 5: Play-test

**Files:** none committed. Test clones `$S5/clone-de` (this branch) and `$S5/clone-en` (`master`), with hooks in the clones only; debug builds, CIAs per `vc/README.md`.

- [ ] **Step 1: Hooks.**
  - **Battle Tower build:** `WriteBattleTowerTrainerName` takes index 101 (Darwin) whatever it's given (`ld c, 101` / `ld b, 0` at its top). The room PC warps to the Battle Tower lobby, and the movie plays a real challenge. If the lobby's menus prove too long, the Battle Factory's rental mode reaches the same battle path.
  - **Regular build:** the room PC runs `loadtrainer BUG_CATCHER, WADE1`, `startbattle`, `reloadmapafterbattle` (Greg).
  - **Wonder Trade build:** `GetWonderTradeOTName` returns a fixed entry with a 7-letter German name from Task 4, and the room PC runs the `WonderTrade` special after the debug radio has given a party.
- [ ] **Step 2: Movies and shots**, German and English builds, a shot every 1.5 s, keeping the changed frames (part 3's method; `vc/playtest.py` names shots in tenths).
- [ ] **Step 3: Compare** by position with the English build. Expected:
  - Battle Tower: "Käfersamml. Darwin" on the intro's first line within 18 tiles, and again in "sent out";
  - Greg: "Käfersammler Greg";
  - Wonder Trade: the German name on the trade animation (sender and OT) and on the summary's OT.

  Kristall has none of these screens; name them as not reached there.
- [ ] **Step 4:** Ledger the screens seen and not reached. A fix gets its own failing check first.

### Task 6: Validate and open the PR

- [ ] The checkers (names, order, width, mode), the fixtures, `make vc` and `make tidy && make faithful vc`, all with baseline warnings only.
- [ ] Final whole-branch review (with Review Focus 2 read in code), then the fix pass.
- [ ] Ask the user, then push and open the PR. Its body holds:
  - the summary;
  - the screens seen and not reached;
  - the short classes;
  - the Wonder Trade sources by kind;
  - the Abbreviations and Anime names (flagged);
  - the merge danger.
