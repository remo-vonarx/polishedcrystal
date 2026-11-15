# Translation Setup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Everything the first text PR needs is in place:
- CLAUDE.md carries the user's translation template, filled in for Polished.
- `TERMS.md` holds settled terms.
- The Kristall material is at hand locally.
- Two checkers catch text that's too wide or that the printer would misread.

**Architecture:**
- **Checkers:** two Python 3 scripts in `utils/` (Polished keeps its Python helpers there), ported from Crystal Legacy's `tools/`. Both read `.asm` source; they don't build anything.
- **CLAUDE.md:** rebuilt around the template's sections. Facts from the old Build, ROM space, Names and Text engine sections move into the Project profile.
- **Kristall material:** sits in a git-excluded `.claude/upload/`.

**Tech Stack:** Python 3 (stdlib only), RGBDS 1.0.4 (`make vc`), Azahar via `vc/playtest.py` and `vc/gen_ctm.py`.

**Spec:** `docs/superpowers/specs/2026-11-15-german-translation-design.md` (section "PR 2: translation setup")

## Global Constraints

- No string contents change in this PR: the build output stays byte-identical to `master`'s.
- Template source: `~/Development/Pokemon_Crystal_Legacy/CLAUDE.md` (read-only), sections:
  - Source priority, with "New content from the hack"
  - Working agreement
  - Text constraints, with "When text doesn't fit"
  - Style
  - Validation (every task)
  - Testing in the game, with "Reaching a screen"
- Not adopted: "Git" (the fork's PR workflow stays) and "Link features" (it waits until a link screen is translated).
- Wherever the template says to read or add to `GLOSSARY.md` for a translation decision, the new text says `TERMS.md`. `GLOSSARY.md` stays the project's English vocabulary.
- Kristall ROM SHA-1 starts with `accb5842`. `.claude/upload/` is listed in `.git/info/exclude` and never committed.
- Work happens on branch `translation-setup`, which reaches `master` through a squash-merged PR titled "Set up the translation". Commits end with the `Claude-Session:` trailer.
- `$SCRATCH` is a scratch directory outside the repo; checker fixtures and test runners stay there, uncommitted.

## Review Focus

1. **A wrong width passes German text that overflows.** Every token the charmap prints as more or fewer than one tile needs its width: the contractions `'d 'l 'm 'r 's 't 'v` are one tile, `#` is 4, `#mon` 7, `<PLAYER>` `<RIVAL>` `<TRENDY>` 7 (the naming screen uses `PLAYER_NAME_LENGTH - 1` for all three), `<PK>` `<MN>` one each. Task 1's fixtures pin these.
2. **`if DEF(FAITHFUL)` / `else` / `endc` inside a text.** Both branches get translated, and each must fit on its own. Task 1 pins this with a branch fixture.
3. **Polished's printer is not pret's.** A checker ported literally would flag Polished's normal idioms, such as `line ""` + `text_ram` + `text "?"` + `para`. Task 2's "must stay quiet" fixtures pin those.
4. **The ROM gets committed.** The Kristall ROM is copyrighted. Task 3 checks `git check-ignore` and stages files by name only.
5. **CLAUDE.md states a wrong fact.** Every profile value has a source: `.sym`, a constant or a file. Task 3's doc check verifies every repo path it names, and the step lists the lookup for each value.

---

### Task 1: `utils/check_text_width.py`

**Files:**
- Create: `utils/check_text_width.py` (port of `~/Development/Pokemon_Crystal_Legacy/tools/check_text_width.py`)
- Create, uncommitted: `$SCRATCH/fixtures/width/*.asm`, `$SCRATCH/test_checkers.sh`

**Interfaces:**
- Produces: `python3 -I utils/check_text_width.py [file.asm|dir ...]`.
  - It prints one `path:line: width N: <line>` per hit, then `N line(s) too wide in M file(s)` on stderr.
  - It exits 1 if anything is found.
  - With no arguments it checks `maps data engine home`.
  - Task 3 consumes it.

- [ ] **Step 1: Save the base ROM, then write the fixtures and the runner**

Run `make -j8 vc` on `master`'s tree and copy `polishedcrystal-3.2.3.gbc` to `$SCRATCH/master.gbc`, which Task 3 compares against.


`$SCRATCH/test_checkers.sh <checker> <fixture-dir>` runs the checker on each `*.asm` fixture. It compares the reported line numbers with each fixture's first line, `; expect: 3 7` (or `; expect: none`), and prints `PASS`/`FAIL` per fixture. Fixtures, all 18-tile lines unless stated:

| Fixture | Content (essentials) | Expect |
|---|---|---|
| `plain.asm` | `text` of 18 chars; `line` of 19 chars | the `line` |
| `contractions.asm` | `text "I'd I'd I'd I'd I'd"` (14 tiles) | none |
| `ngrams.asm` | `text "#-Ball #-Ball"` (19); `para "<PLAYER> got one!"` (7+9=16); `line "<RIVAL>, <TRENDY>!!!"` (7+2+7+3=19); `cont "<PK><MN> 1234567890123456"` (2+1+16=19) | the 1st, 3rd and 4th of these |
| `next1.asm` | 18-char `text`, then 18-char `next1` | none |
| `runtime.asm` | `text_ram wStringBuffer1`, then `text " is a long long long name"` | none |
| `branches.asm` | `text "123456789"` / `if DEF(FAITHFUL)` / `text "123456789"` / `else` / `text "1234567890"` / `endc` / `done` | the `else` branch's `text` (19) |
| `dex_entries.asm` | `db "Seed@"`, `text` 18, `next` 19, `page` 18, `next "…@"` 18 | the `next` of 19 |

- [ ] **Step 2: Run the runner without the checker.** Expected: every fixture FAILs (no such file).

- [ ] **Step 3: Port the checker to Polished.** Keep Legacy's structure (labels and new-line commands reset the width, runtime commands make it unknown) and change the tables:
  - New lines: `line cont para next next1 page`.
  - Runtime: `text_ram text_decimal text_today text_plural`.
  - Reset: `done prompt text_end text_far text_farend text_asm text_promptbutton text_start`.
  - Unknown width: `<USER> <TARGET> <ENEMY>` and `{…}` interpolation.
  - Token widths per Review Focus 1.
  - Conditionals are lowercase in Polished. `if` saves the width. `elif`/`else` note the branch's end width and restore the saved one. `endc` continues with the widest branch end.
  - The Pokédex rule applies to `data/pokemon/dex_entries.asm`, where `db` starts the category.
  - Drop Legacy's map-name check. Polished's landmark names use `¯` and other widths, so their check comes with the place-names PR.

- [ ] **Step 4: Run the runner.** Expected: all 7 PASS.

- [ ] **Step 5: Run it on the tree.** `python3 -I utils/check_text_width.py > $SCRATCH/width_tree.txt`. Expected: it finishes with the summary line and doesn't crash. Read every hit. A hit the parser causes is fixed in the checker and gets a new fixture. A real overflow in Upstream's English is kept for Task 3's profile. Neither kind is fixed in game text.

- [ ] **Step 6: Commit** `utils/check_text_width.py`: "Add a text width checker".

---

### Task 2: `utils/check_text_mode.py`

**Files:**
- Create: `utils/check_text_mode.py` (port of Legacy's `tools/check_text_mode.py`, new rules)
- Create, uncommitted: `$SCRATCH/fixtures/mode/*.asm`

**Interfaces:**
- Consumes: `$SCRATCH/test_checkers.sh` from Task 1.
- Produces: `python3 -I utils/check_text_mode.py [file.asm|dir ...]`.
  - It prints `path:line: <message>: <line>` per hit, then `N problem(s) in M file(s)` on stderr.
  - It exits 1 if anything is found.
  - Default paths and caller are the same as Task 1's.

**Polished's printer** (`home/text.asm`; this replaces Legacy's model):
- The command loop ends the text at `@`, `<DONE>` or `<PROMPT>`. Any other byte from `$0a` up starts a string implicitly.
- A string ends at `@`, at `<DONE>`/`<PROMPT>` (which end the box), or at any command byte below `$4d`, which then runs.
- So a command after an open string is fine, and so is a string between commands. Legacy flagged both.

What the checker reports:
1. **`text_end` after an open string** (no `@` in it): "text_end ends only the string". The `@` closes the string, and the printer runs on into what follows. Upstream has none.
2. **Bare `prompt` while no string is open** (right after a command such as `text_ram` or `text_far`, or after a string closed by `@`): "prompt here ends the text without waiting". Upstream has none. A bare `done` there is harmless (upstream has 5) and isn't reported.
3. **A text still open at the next label**: "text runs into <label>". It's reported on the last command's line. A text ends at `done`, `prompt`, `text_end`, `text_farend` or `text_asm`.

Plain strings (`db`, `rawchar`, `li`) aren't texts.

- [ ] **Step 1: Write the fixtures**

| Fixture | Content (essentials) | Expect |
|---|---|---|
| `runs_on.asm` | `A:` `text "abc"` `line "def"`, then `B:` `text "ok"` `done` | the `line` |
| `text_end.asm` | `text "abc"` `text_end`; then `text "Go! @"` `text_end` | the first `text_end` only |
| `prompt.asm` | `text "You got "` `text_ram wStringBuffer1` `prompt`; then `text_ram wStringBuffer1` `text "!"` `prompt` | the first `prompt` only |
| `idioms.asm` | `text "Ah, so that is"` `line ""` `text_ram wStringBuffer3` `text "?"` `para "Isn't it cute!"` `done`; `text_ram wX` `done`; `text_far Label` `text_end`; `text_farend Label`; `text "x"` `text_asm` + asm; `db "Seed@"`; `rawchar "New Bark¯Town@"`; `li "Summary"`; `jumpthistext` + blank + `text "y"` `done` | none |

- [ ] **Step 2: Run the runner without the checker.** Expected: every fixture FAILs.

- [ ] **Step 3: Write the checker** with the three rules above. It reads lines the same way as Task 1, comments stripped.

- [ ] **Step 4: Run the runner.** Expected: all 4 PASS, and Task 1's 7 still PASS.

- [ ] **Step 5: Run it on the tree** into `$SCRATCH/mode_tree.txt` and triage it like Task 1 Step 5. A label that intentionally continues a text, such as a shared tail, counts as a known false alarm.

- [ ] **Step 6: Commit** `utils/check_text_mode.py`: "Add a text mode checker".

---

### Task 3: CLAUDE.md, TERMS.md and the Kristall material

**Files:**
- Modify: `CLAUDE.md` (rewrite)
- Create: `TERMS.md`
- Modify: `vc/README.md` (new section "Reach the player's room")
- Local only: `.claude/upload/` (3 files) and `.git/info/exclude`
- Create, uncommitted: `$SCRATCH/check_claude_md.py`

**Interfaces:**
- Consumes: both checkers and their triaged tree results (Tasks 1–2).

- [ ] **Step 1: Copy the Kristall material and exclude it**

```sh
mkdir -p .claude/upload && echo '.claude/upload/' >> .git/info/exclude
cp "$HOME/Development/Pokemon_Crystal_Legacy/.claude/upload/"{"Pokemon - Kristall-Edition (Germany).gbc",german_text_dump.txt,dump_german_text.py} .claude/upload/
shasum ".claude/upload/Pokemon - Kristall-Edition (Germany).gbc" | cut -c1-8   # accb5842
git check-ignore -q .claude/upload/german_text_dump.txt && git status --short   # no .claude entries
```

- [ ] **Step 2: Write the failing doc check `$SCRATCH/check_claude_md.py`**

```python
H2 = ["Upstream", "Project profile", "Project decisions", "Source priority", "Working agreement",
      "Text constraints", "Style", "Validation (every task)", "Testing in the game"]
H3 = ["New content from the hack", "When text doesn't fit", "Reaching a screen"]
assert [h for h in headings(level=2)] == H2
assert set(H3) <= set(headings(level=3))
assert "## Git" not in md and "Link features" not in md
assert "locale/" not in md and "tagged release" not in md
assert md.count("GLOSSARY.md") == 1          # only the vocabulary line
assert md.count("TERMS.md") >= 3            # source priority, working agreement, when text doesn't fit
assert all("ss" in l for l in md.splitlines() if "ß" in l)
assert all(exists(p) for p in backticked_repo_paths(md))   # tokens with "/" or a file suffix, not ~ or <…>
assert "4a9e37b13" in md and "--merge" in md  # drift guard base, merge-commit exception
```

Also assert that `TERMS.md` has the header row `| English | German | Where | Source / note |`. Run it on `master`'s CLAUDE.md. Expected: it fails on the first heading assert.

- [ ] **Step 3: Write `TERMS.md`.**
  - A two-line intro: settled English → German decisions; read before every task; add each new decision; the general rules are in CLAUDE.md, Project decisions.
  - Then the table header with no rows.

- [ ] **Step 4: Add "Reach the player's room" to `vc/README.md`.**
  - It holds the `gen_ctm.py` schedule verified in the 4 MB PR:
    - Taps through to the naming screen.
    - Types "Jürgen".
    - A every 3 s from 128 s to 161 s.
    - Program `0004000000172800`, 180 s.
  - It notes that the player's room shows at about 170 s.
  - Then boot the German original the same way: `vc/playtest.py` accepts a `.cia`, so pass `vc/local/dumps/kristall-vc-v0.1.0.standard.cia` with a movie for `0004000000172B00`. If Azahar won't boot the CIA directly, use the CXI extracted with `vc/local/bin/ctrtool --contents=$SCRATCH/kristall <cia>`.
  - Expected: a screenshot of Kristall's German intro. Record the working command in the same section.
  - Verify the room schedule on a fresh `make vc` build. Expected: the room at about 170 s.

- [ ] **Step 5: Rewrite `CLAUDE.md`** (load mattpocock-skills:writing-for-agents first). Order as in H2.
  - **Intro:** the existing first paragraph. Add one line: Project profile and Project decisions hold everything specific to this fork, and the sections from Source priority on are the user's template, the same for every hack.
  - **Upstream:**
    - The PR workflow stays. Upstream merges go through their own PR, merged with `gh pr merge --merge`; every other PR is squash-merged.
    - Drift guard, before merging:
      1. `base=$(git merge-base master upstream/master)`: the last merged Upstream commit, the fork point `4a9e37b13` until the first merge.
      2. Translated files: `git diff --name-only $base master`.
      3. Upstream's changes to them: `git diff $base upstream/master -- <files>`.
      4. Every changed or new text line there gets translated in the merge PR.
    - Drop the `locale/` and tagged-release bullets. Keep the bullet about large Upstream renames.
    - Run the three drift-guard commands once now after `git fetch upstream`. Expected: `base` is `4a9e37b13`, and steps 2–3 print without error.
  - **Project profile:** the template's table. The lookup behind each value is in brackets.
    - Hack and repo: Polished Crystal, Upstream `Rangi42/polishedcrystal`, fork `remo-vonarx/polishedcrystal` (`gh pr create --repo …`).
    - German original: the Kristall ROM and dump as in Legacy's row [Step 1], plus "reused lines are re-cased per Project decisions".
    - Previous translations to reuse: Crystal Legacy's German text in `~/Development/Pokemon_Crystal_Legacy`, where Polished's Source text matches pret's English.
    - Textbox: 18 × 2, fixed-width font. The ▼ is on the bottom border [`LoadBlinkingCursor`, `home/text.asm`: tile 18,17]. The variable-width font (`vwf.png`, measured in pixels) appears only in the Pokédex list, Bill's PC, ability pop-ups and the judge machine [`grep -ril vwf engine`].
    - Text commands: the list from `macros/scripts/text.asm`, plus the printer model from Task 2. Pokédex entries are in `data/pokemon/dex_entries.asm`: a category `db "…@"`, then 3 lines per page (`next`) on 2 pages (`page`), ending in `@`, 18 tiles from column 1 [`engine/pokedex/pokedex.asm`: `hlcoord 1, 12`].
    - Length constants: `constants/text_constants.asm`, plus "player, rival and trendy-phrase entry take 7 characters".
    - Charmap and font: the old Text engine section's facts, plus the token widths from Review Focus 1.
    - Build: the old Build section, plus the baseline. A clean `make vc` prints 2 `-Wassert` "unnecessary farcall GetKeyItemAttr" warnings from Upstream, and recompiling a tool prints 9 clang "unknown warning option" lines. A task adds none.
    - ROM space: the old section's three bullets.
    - Virtual Console: `make vc`, the `vc.patch.template` label rule and `vc/README.md`.
    - Check scripts: both commands, each triaged tree hit as a known hit or a known false alarm with its reason, and "`check_names.py` comes with the name-table PR".
    - Emulator: Azahar (`vc/playtest.py`, screenshots by wall-clock time, no RAM access). A scriptable emulator that runs the 4 MB ROM and reads and writes RAM is chosen when the first screen past the new game needs one. PyBoy may mask MBC3 banks to 7 bits.
    - Tilemap symbol: `wTilemap`, 20 × 18 at `$C440` [`.sym`].
    - Test entry points: "Reach the player's room" in `vc/README.md`, for Polished and for Kristall.
  - **Project decisions:** the spec's list, verbatim in meaning, plus:
    - The Modern-name rule (ADR 0002).
    - Faithful-only text gets translated.
    - Debug-only text (`if DEF(DEBUG)`) stays English.
  - **Template sections, adapted:**
    - Source priority: 1 `TERMS.md`, 2 the Kristall dump, 3 Crystal Legacy, 4 later games (PokéWiki/PokeAPI), 5 own translation, flagged.
    - Text constraints: the character list drops ß.
    - Style: ß is written "ss" (ADR 0003), also in Kristall lines and in capitals.
    - Validation:
      - `make vc` succeeds with no new warnings.
      - Sections the linker moves above bank `$7F` are fine.
      - Stop and report only a section that fits no bank, including a map scripts section over 16 KB, which needs a split proposed first.
      - Huffman tables are regenerated (`utils/huffman.py`).
    - Testing in the game: compare by position using Azahar screenshots, against Kristall where Polished kept the screen and against Polished's English screen elsewhere, until a scriptable emulator reads tilemaps. Keep the template's clone-in-scratchpad and "name the screens not reached" rules.

- [ ] **Step 6: Run the doc check, both checkers and the build.**

```sh
python3 -I $SCRATCH/check_claude_md.py CLAUDE.md TERMS.md
python3 -I utils/check_text_width.py | diff - <(known width hits from the profile)
python3 -I utils/check_text_mode.py | diff - <(known mode hits from the profile)
make -j8 vc && cmp polishedcrystal-3.2.3.gbc $SCRATCH/master.gbc
```

Expected:
- The doc check passes.
- Both checkers print exactly the profile's known hits.
- The ROM is byte-identical to a `master` build saved before Task 1 (`$SCRATCH/master.gbc`).

- [ ] **Step 7: Commit** `CLAUDE.md`, `TERMS.md` and `vc/README.md` by name: "Adopt the translation template in CLAUDE.md".
