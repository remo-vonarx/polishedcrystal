# Naming Screen Umlauts Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Put `Ä Ö Ü ä ö ü` on the naming screen's 8 keyboards in Kristall's layout.

**Architecture:** Pure data. `data/text/input_chars.asm` holds 8 `rawchar` grids (name 9×5, mail 10×5; upper and lower; ABC and QWERTY); one row changes in each. The naming-screen code treats no character specially.

**Tech Stack:** RGBDS 1.0.4 (`make vc`), Python 3, Azahar via `vc/playtest.py` and `vc/gen_ctm.py`.

**Spec:** `docs/superpowers/specs/2026-11-14-naming-screen-umlauts-design.md`

## Global Constraints

- New rows, identical on ABC and QWERTY pages, with their bytes (checked against the charmap on 2026-11-14):
  - Name upper, row 4: `rawchar "ÄÖÜ¥<PK><MN>★♥♪"` = `c9 cc ce ea d2 d3 ec da d9`
  - Name lower, row 4: `rawchar "äöüé'()/0"` = `ca cd cf c8 c0 9a 9b dc e0` (`'` is the plain apostrophe `$c0`)
  - Mail upper, row 5: `rawchar "ÄÖÜ<PK><MN><PO><KE>&♂♀"` = `c9 cc ce d2 d3 d0 d1 d8 be bf`
  - Mail lower, row 4: `rawchar "äöüé's¥×/()"` = `ca cd cf c8 c5 ea db dc 9a 9b`
- Every other row of every grid stays byte-identical.
- `make vc` keeps exactly the 2 upstream `-Wassert` warnings.
- Commits end with the `Claude-Session:` trailer. Work happens on branch `naming-screen-umlauts`, which reaches `master` through a squash-merged PR (CLAUDE.md "Upstream").
- `$SCRATCH` is a scratch directory outside the repo.

## Review Focus

1. **Case switch:** SELECT (and the bottom-row case key) must show the page with the matching umlauts. Task 2 screenshots both pages.
2. **Name printed later:** a name with umlauts must print correctly in dialogue (`<PLAYER>` is an n-gram filled from WRAM). Task 2 screenshots the first dialogue that uses the name.
3. **DEL after an umlaut:** it must remove exactly one character. Task 2 types `ü`, deletes it, types it again.
4. **QWERTY and mail pages:** no early screen reaches them. Task 1's byte check covers all 8 grids.
5. **Plain apostrophe vs contraction:** `'(` must assemble as `$c0 $9a`, not as a contraction token. Task 1's byte check pins `c0 9a`.

---

### Task 1: Keyboard rows

**Files:**
- Modify: `data/text/input_chars.asm` (one row in each of the 8 grids)
- Modify: `CLAUDE.md` ("Text engine": the line saying the naming screen has no umlaut keys)
- Create, uncommitted: `$SCRATCH/check_keyboards.py`

**Interfaces:**
- Produces: the new keyboards in the built ROM, used by Task 2.

- [ ] **Step 1: Keep the base build**

`make -j8 vc`, then copy `polishedcrystal-3.2.3.gbc` and `.sym` to `$SCRATCH/base.gbc` and `$SCRATCH/base.sym`.

- [ ] **Step 2: Write the failing check `$SCRATCH/check_keyboards.py <base.gbc> <base.sym> <new.gbc> <new.sym>`**

It reads the 8 tables by their labels (`NameInputUpper`, `NameInputLower`, `NameInputUpperQwerty`, `NameInputLowerQwerty`: 45 bytes, rows of 9; `MailEntry_Uppercase`, `MailEntry_Lowercase`, `MailEntryQwerty_Uppercase`, `MailEntryQwerty_Lowercase`: 50 bytes, rows of 10) from both ROMs. ROM offset = `bank * 0x4000 + addr - 0x4000` for banks above 0. It asserts:
- `assert new_row == EXPECTED[table]`: the Global Constraints bytes, at row index 3 for name tables and mail lower, and index 4 for mail upper.
- `assert all other rows equal base`.

Run it with the base ROM as both base and new. Expected: FAIL on all 8 tables ("row differs from expected").

- [ ] **Step 3: Replace the 8 rows in `data/text/input_chars.asm`** with the Global Constraints strings.

- [ ] **Step 4: Build and check**

```sh
make -j8 vc 2>&1 | grep -c warning   # expect 2
python3 -I $SCRATCH/check_keyboards.py $SCRATCH/base.gbc $SCRATCH/base.sym polishedcrystal-3.2.3.gbc polishedcrystal-3.2.3.sym
```
Expected: 2 warnings, 0 failures.

- [ ] **Step 5: Update `CLAUDE.md`**

Replace "The naming screen (`engine/menus/naming_screen.asm`) still has no umlaut keys." with: "The naming screen's keyboards (`data/text/input_chars.asm`) carry them in Kristall's layout (`docs/superpowers/specs/2026-11-14-naming-screen-umlauts-design.md`)."

- [ ] **Step 6: Commit** `data/text/input_chars.asm` and `CLAUDE.md`: "Add umlaut keys to the naming screen".

---

### Task 2: On-screen check on Virtual Console (uncommitted)

**Files:**
- Create, uncommitted: `$SCRATCH/naming.ctm`, screenshots

**Interfaces:**
- Consumes: Task 1's build.

- [ ] **Step 1: Build the test CIA**: `vc/build_cia.sh polishedcrystal-3.2.3.gbc namingtest`.

- [ ] **Step 2: Find the timing with dense screenshots**

With no save, `A` at 4 s and 6 s reaches the main menu (`New Game` selected). From there, the new-game flow goes to the initial options ("Please choose how you want to play"; START leaves the menu), then the clock ("Will you check the clock for me?"), then Elm's speech and the name choice (pick the first entry, `New name`). Tune a movie step by step with `--shots` every 2 s until the naming screen shows.

- [ ] **Step 3: Type a name and screenshot**

On the naming screen (ABC layout, upper page, cursor on `A`):
1. Screenshot the upper page: row 4 reads `Ä Ö Ü ¥ <PK> <MN> ★ ♥ ♪`.
2. Type `J` (row 2, column 1).
3. SELECT, then screenshot the lower page: row 4 reads `ä ö ü é ' ( ) / 0`.
4. Type `ü` (row 4, column 3), B to delete it, then `ü` again, then `r g e n`.
5. Screenshot the field (`Jürgen`) and press START, then A to confirm.
6. Screenshot the first dialogue line that prints the name.

Expected: all 4 screenshots show the right characters, and the field holds `Jürgen` with one `ü`.

- [ ] **Step 4: Show the user** the screenshots, each with its full absolute path.
