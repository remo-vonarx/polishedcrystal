# New-Game Text Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Everything a new player sees from power-on until they control the player in their room is German, and so are the texts of that room's objects.

**Architecture:**
- German replaces the English string contents in place, in the files listed under Scope.
- One code change, approved with this plan: every Yes/No box grows one column to the left so "Nein" fits.
- Each string comes from the source priority in CLAUDE.md. Open questions go to the user once, as a table, before the strings are final.

**Tech Stack:** RGBDS 1.0.4 (`make vc`), `utils/huffman.py`, `utils/check_text_width.py` and `utils/check_text_mode.py`, Azahar through `vc/gen_ctm.py` and `vc/playtest.py`, the Kristall dump in `.claude/upload/`.

**Spec:** `docs/superpowers/specs/2026-11-15-german-translation-design.md` (sections "PR 3 onward: text areas" and "Project decisions")

## Global Constraints

- CLAUDE.md governs every string: Project decisions, Source priority, Text constraints, Style, Validation, Testing in the game. This plan doesn't repeat them.
- Only string contents change, apart from the Yes/No box (Task 2). Labels, code, comments and commit messages stay English.
- Debug-only text (`if DEF(DEBUG)`) stays English; `if !DEF(DEBUG)` and `if DEF(FAITHFUL)` text gets translated.
- Every settled term goes into `TERMS.md` in the same commit as the strings that use it.
- The Huffman vowel set stays `AEIOUaeiou`. Adding umlauts there costs ROM0 bytes and only improves compression.
- Branch `new-game-text`; PR "Translate the new game" on the fork, squash-merged. Commits end with the `Claude-Session:` trailer.
- `$SCRATCH` is a scratch directory outside the repo; tests, movies' scripts and screenshots stay there.

## Scope

In, by screen in the order a new player sees them:

| Screen | Strings |
|---|---|
| Main menu | `engine/menus/main_menu.asm`: the 5 items (`Continue`, `New Game`, `New Game+`, `Options`, `Music Player`) and `Time not set`. Box text runs from column 2 to 15: 14 characters |
| Initial options | `_InitialOptionsText` (`data/text/common.asm`); the 11 names in `data/options/initial_option_names.asm`; the 11 descriptions in `data/options/initial_options_descriptions.asm`; the values in `engine/menus/initial_options_menu.asm` (`.AllString`, `.Old`, `.New`; `.ModernString` is a number and stays); `Done` in `engine/menus/options_menu_shared.asm`; `YesString`/`NoString` in `home/menu.asm` |
| Clock | In `engine/rtc/timeset.asm`, everything `InitClock` prints: `Text_WokeUpOak`, `Text_WhatTimeIsIt`, `String_oclock`, `Text_HowManyMinutes`, `String_min`, `Text_WhoaHoursMins`, the four responses in `OakText_ResponseToSetTime`, and whatever time-of-day or AM/PM strings the hour line shows. The texts these point to are in `data/text/common.asm` (`_OakTime…Text`, `ProfElmNappedText`) |
| Elm's speech | `_ElmText1`, `_ElmText2`, `_ElmText4`, `_ElmText5`, `_ElmText6`, `_ElmText7` (`data/text/common.asm`) |
| Photo choice | `Text_AreYouABoyOrAreYouAGirl`, `Text_SoThisIsYou` (`data/text/common.asm`) |
| Naming screen | The 4 labels and the `Shift  Del   End` key row in `engine/menus/naming_screen.asm`; the 4 default names in `data/player/default_names.asm` |
| Player's room | `maps/PlayersHouse2F.asm`: `InitialRadioText1`–`4` and the Pokémon Journal; `_LookTownMapText` (the poster) and `_PlayersPCTurnOnText` (`data/text/common.asm`) |

Out, each a later area:
- the Options menu from the main menu (`options_menu.asm`)
- the PC menu after the turn-on line
- the Town Map screen
- Mom's weekday and summer-time questions
- the weekday names in `timeset.asm`
- the New Game+ prompt
- the VBA warning, which Virtual Console never shows
- the clear-save and clock-reset dialogs
- the copyright line
- the Music Player screen

**Yes/No box (proposed code change).** "Nein" needs 4 columns; every Yes/No box has 3. In `home/menu.asm`:
- `HandleYesNoMenu` places the left border one column further left (`ld a, b` / `dec a`) and the right border 6 columns after it (`add 6`, was `add 5`).
- `ClearSpritesUnderYesNoBox` clears from 13 tiles (`13 * TILE_WIDTH + 1`, was 14).
- That covers all three callers: `YesNoBox`/`NoYesBox` (13–19, in the Pokégear 12–18) and the slot machine (13–19).
- `YesString`/`NoString` become equal-width (`"Ja  @"`, `"Nein@"`), so one value overwrites the other cleanly on the options screen.
- The cost is 3 bytes of ROM0. Kristall's own box shows "NEIN" (Azahar, clock question at 50 s).

## Review Focus

1. **A fixed-width field the checkers don't measure overflows or leaves letters behind.** These include:
   - the main menu items
   - option names and the value column (`OPTIONS_SHARED_VALUE_OFFSET`)
   - the naming labels and the key row, which is aligned to the keyboard
   - the clock's `o'clock`/`min.` slots
   - the Yes/No box

   Task 1 records each field's limit, and Task 4 screenshots each one, including an option toggled Ja → Nein → Ja.
2. **A Yes/No box elsewhere breaks after the widening:** the Pokégear position, the slot machine, or sprites left under the box. Task 2 screenshots the clock question, and its step lists the other two for the "not reached" list unless a movie reaches them.
3. **German text with umlauts prints garbage** because the Huffman tables are stale, or a character is missing from the charmap. Task 3 regenerates the tables, and treats any `-Wunmapped-char` warning as a failure. Task 4 needs a screenshot of at least one line with an umlaut.
4. **Text read from a bank at `$80` or above** has never run in Azahar. Task 3 lists the banks of the changed text sections from the `.sym` file. If one is at `$80` or above, Task 4's screenshot of it is the proof; if none is, the PR says so.
5. **A name or a form of address slips in unasked.** All of these go to the user in Task 1's question table before any string is final:
   - Prof. Elm's name, Glaceon, Prof. Oak, DJ Mary, Trainer Card, Town Map, Pokémon Journal
   - the default player names
   - every own translation

---

### Task 1: Draft the German strings and ask the open questions

**Files:**
- Create, uncommitted: `$SCRATCH/newgame.md` (working table), `$SCRATCH/check_scope.py`

**Interfaces:**
- Produces:
  - `$SCRATCH/newgame.md`: one row per string, with columns `File:line | English | Source (Kristall bank:address, Legacy path, PokeAPI/PokéWiki) | German | Width / limit | Flag`.
  - `python3 -I $SCRATCH/check_scope.py`: it prints `path:line: still English: <line>` for every in-scope text line equal to `master`'s, then exits 1 if any are left. It reads the in-scope labels from a list at the top of the script, taken from Scope.

- [ ] **Step 1: Write `check_scope.py` and run it on `master`.** Expected: it lists every in-scope line and exits 1. Lines meant to stay unchanged are listed in the script with a reason, such as `.ModernString`.
- [ ] **Step 2: Fill `newgame.md` by the source priority.**
  - Kristall lines are found in `.claude/upload/german_text_dump.txt`; texts that start with a line break or `text_ram` are read from the ROM.
  - Each line gets its field limit:
    - the 18-tile box
    - 14 for the main menu
    - the option name and value widths read from a screenshot of the options screen
    - the naming screen's label and key columns
  - Polished-only text is marked as Original content and translated faithfully.
- [ ] **Step 3: Stop and ask the user the question table** (CLAUDE.md, Working agreement), in one message. It covers at least:
  - the names in Review Focus 5
  - every own translation
  - every Abbreviation
  - the key row
  - the photo question's wording

  Record each answer in `newgame.md`, and each settled term in `TERMS.md`, before Task 3.

### Task 2: Widen the Yes/No box

**Files:**
- Modify: `home/menu.asm` (`HandleYesNoMenu`, `ClearSpritesUnderYesNoBox`, `YesString`, `NoString`)

- [ ] **Step 1: Screenshot the current box** with the room movie at the clock question (about 62 s). Expected: "Yes"/"No" in columns 16–18 and the border at column 14.
- [ ] **Step 2: Make the change from Scope**, with `YesString`/`NoString` set to the Task 1 answer (default `"Ja  @"`, `"Nein@"`).
- [ ] **Step 3: Build and check.**
  - Run `make vc` with no new warnings, then `make freespace` and look at ROM0 in `bank_ends.txt`. Expected: ROM0 still fits, about 3 bytes less free.
  - Take the same screenshot. Expected: the border at column 13, and "Nein" whole inside the box, matching Kristall's box by position.
- [ ] **Step 4: Commit** `home/menu.asm`: "Widen the Yes/No box for German".

### Task 3: Put the German strings in

**Files:**
- Modify: the Scope files, plus `constants/huffman_text.inc` and `TERMS.md`

**Interfaces:**
- Consumes: Task 1's answered `newgame.md` and `check_scope.py`.

- [ ] **Step 1: Replace the strings screen by screen**, one commit per screen:
  1. "Translate the main menu"
  2. "Translate the initial options"
  3. "Translate the clock setting"
  4. "Translate Elm's speech and the photo choice"
  5. "Translate the naming screen"
  6. "Translate the player's room"

  Before each commit, the checkers print only CLAUDE.md's known hit, and `check_scope.py` no longer lists that screen.
- [ ] **Step 2: Regenerate the Huffman tables** as `utils/huffman.py`'s docstring says (`make tidy`, `make -j4 huffman > $SCRATCH/chars.txt`, `utils/huffman.py $SCRATCH/chars.txt constants/huffman_text.inc`), then `make tidy && make vc`.
  - Expected: no new warnings and no `-Wunmapped-char`.
  - Commit `constants/huffman_text.inc`: "Regenerate the Huffman tables".
- [ ] **Step 3: Run `check_scope.py`.** Expected: exit 0.
- [ ] **Step 4: List the changed text sections' banks** from `polishedcrystal-3.2.3.sym`, for Review Focus 4.

### Task 4: Test in the game against Kristall

**Files:**
- Modify: `vc/README.md` ("Reach the player's room": re-tuned taps, plus reading the room's objects)
- Create, uncommitted: `$SCRATCH/newgame_shots/`, `$SCRATCH/kristall_shots/`

- [ ] **Step 1: Re-tune the room movie** for the German text. Extend it so that, in the room, it walks to and reads the radio, the Pokémon Journal, the Town Map poster and the PC.
  - Variants: one per initial option, with DOWN between them so each description shows, plus one Ja → Nein → Ja toggle.
  - Up to four clock variants, using UP to set the hour, so each time-of-day response shows.
  - Expected: a screenshot of every Scope screen that a new game reaches.
- [ ] **Step 2: Take Kristall's matching screens** with the Kristall movie from `vc/README.md`, extended: the main menu, the clock question and response, Oak's speech, the name choice and the room's objects.
- [ ] **Step 3: Compare by position** (CLAUDE.md, Testing in the game).
  - Against Kristall where Polished kept the screen: the main menu, the clock, the speech boxes, the room.
  - Against Polished's English screen elsewhere: the initial options, the photo choice, the naming screen.
  - Fix any overflow in Task 3's files and repeat that screen.
- [ ] **Step 4: Commit** `vc/README.md`: "Re-tune the new-game movie for German".
- [ ] **Step 5: List the screens seen and the screens not reached** in the PR body, with their reasons:
  - the rival, trendy-phrase and box-name labels
  - `Continue`, `New Game+` and `Time not set`
  - the Pokégear and slot-machine Yes/No boxes
