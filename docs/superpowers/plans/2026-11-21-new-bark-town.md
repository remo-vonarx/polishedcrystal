# New Bark Town Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Every player-visible string in the seven New Bark Town map files and the scene texts they print is German, matching Kristall by position where Polished kept Crystal's screens.

**Architecture:** Text is edited in place, block by block. A scratch tool lists each file's text blocks, applies German blocks from a per-file translation file onto `master`'s version (so re-applying is idempotent), and checks that no block's ending or `text_*` commands changed and that no block is left English. Kristall's German is found by reading each map's dump region beside pret's English in file order.

**Tech Stack:** RGBDS 1.0.4 (`make vc`, `make faithful vc`), `utils/huffman.py`, the four check scripts in `utils/`, Python 3 scratch tools, Azahar through `vc/gen_ctm.py` and `vc/playtest.py`.

**Spec:** `docs/superpowers/specs/2026-11-21-new-bark-town-design.md`

## Global Constraints

- Textbox 18 × 2 tiles; every line keeps all 18 tiles (the ▼ sits on the border). Variables at their longest: `<PLAYER>`/`<RIVAL>` 7, Pokémon names 10, item names 12, move names 12.
- Source priority: `TERMS.md` → Kristall verbatim (re-cased to mixed case, ß → ss) → Crystal Legacy → PokéWiki → own translation, flagged.
- Spelling: `du`/`dein` lowercase; ss for ß; names mixed case (Prof. Lind, Lyra, Feurigel); `#mon` for Pokémon; Avoid words in `GLOSSARY.md`.
- New lines address the player neutrally. "Champ" counts as neutral (the user's choice, 2026-11-21).
- Never change how a box ends or a script's flow; re-break lines or add `para` boxes instead.
- Debug-only text (`if DEF(DEBUG)` branches) stays English; faithful-only text is translated.
- `make vc` and `make faithful vc`: only the baseline warnings (2 × "unnecessary `farcall GetKeyItemAttr`", 9 clang lines when a tool recompiles). A short script jump pushed past 255 bytes switches to its long form, listed in the PR.
- Regenerate the Huffman tables after the text changes (`utils/huffman.py` docstring).
- Overnight standing order (the user, 2026-11-21): a new real choice takes my recommended option, marked provisional in `TERMS.md` and the PR. This PR is squash-merged by me once every check and play-test passes.

User decisions to apply verbatim (spec "Player address and questions"; the user, 2026-11-21):
- `NewBarkTown.asm:407` Lyra: `para "Du wirst ein"` / `line "toller Champ!"`.
- `ElmsLab.asm:1452` Elm: "Ein Champ wie du sollte dort gut abschneiden!" (re-broken to fit).
- `ElmsLab.asm` `ElmAskBattleText`: `text "Ich könnte etwas"` / `line "Kampfpraxis gegen"` / `para "ein Talent wie"` / `line "dich gebrauchen."` / `para "Wie wär's,"` / `line "<PLAYER>?"` / `done`.
- `NewBarkTown.asm:375` Lyra: `para "Ich will sehen,"` / `line "wie stark du"` / `cont "geworden bist!"`.
- `LyrasHouse1F.asm` `LyrasTVScript`: `text "Es läuft ein Film"` / `line "im TV: Ein Mädchen"` / `para "mit Zöpfen folgt"` / `line "einer gelben Zie-"` / `cont "gelsteinstrasse…"` / `para "Ich sollte mich"` / `line "auch auf den Weg"` / `cont "machen!"` / `done`.

## Review Focus

1. A changed line holding `<PLAYER>`, `<RIVAL>`, `text_ram` or a Pokémon/item name, over 18 tiles at the variable's longest: the checkers don't measure these. `blocks.py vars` lists each with its worst-case width; every one ≤ 18 (Tasks 2–4).
2. A shared scene text shown in other contexts (`_PutItemInPocketText` with a 12-letter item and the longest pocket name, the nickname prompt with a 10-letter species, the "received" texts with 12-letter items): counted at the longest values across all callers (Tasks 2, 4).
3. A text whose ending or inline `text_*` commands changed (a `done` turned `prompt`, a lost `text_promptbutton`): `blocks.py endings` against `master` reports 0 (every task).
4. A new line that gives the player a gender ("ein Trainer", "eine Trainerin", "ein guter", "Junge"/"Mädchen" for the player): `grep -nE 'Trainer(in)?\b|ein (guter|echter|starker)|Junge|Mädchen'` over the changed own lines; each hit is about someone else or rephrased (Tasks 3–4).
5. A script jump overflowed by longer text (`-Wtruncation` "is not 8-bit"): the build's warning count equals the baseline after each task (Tasks 2–4).

---

### Task 1: Translation tools (scratch)

**Files** (scratch, never committed; `$S` = `/private/tmp/claude-574960772/-Users-remo-vonarx-Development-polishedcrystal/16068f8f-2b74-49e7-a09c-337acc584c1b/scratchpad/nbt`):
- Create: `$S/blocks.py`, `$S/test_blocks.py`, `$S/region.py`, `$S/table.tsv`
- Commit (repo): the spec and this plan, on branch `new-bark-town` from `master`

**Interfaces:**
- Produces:
  - `blocks.py list <file>` → one row per block: `start<TAB>label<TAB>kind<TAB>ending<TAB>text`; `kind` is `debug` inside an `if DEF(DEBUG)` branch, else `normal`; `label` is the nearest label above (inline `jumpthistext` blocks take their script's label); `start` is the line of the block's first command.
  - `blocks.py apply <file> <de_file>`: reads `git show master:<file>`, replaces the blocks named in `de_file` (`@@ <start> <label>` header, then the new lines verbatim), writes `<file>`. Refuses (exit 1, message) when `start` isn't a block start in `master`, the label differs, or the new block's ending or `text_*` commands differ.
  - `blocks.py english <file>...` → normal blocks that still look English (two or more of `the you your is are to and it's I'm I'll don't can't what this that with for of` as whole words, case-insensitive, and no umlaut or German stopword `ich du der die das und ist nicht`); exit 1 if any.
  - `blocks.py endings <file>...` → blocks whose sequence of non-layout commands (everything but `line`, `cont`, `para`, `next`) differs from `master`'s block at the same index; exit 1 if any.
  - `blocks.py vars <file>...` → each changed line with `<PLAYER>`, `<RIVAL>`, `text_ram`, `text_decimal` or `@`-ended RAM names, with its width at the longest values (7 for `<PLAYER>`/`<RIVAL>`; the RAM name's constant from the comment in the text, by hand otherwise); exit 1 if any is over 18.
  - `region.py <Map> <anchor> [n]` → pret's text blocks of `maps/<Map>.asm` at Crystal Legacy `9a5b41a27` (labels and joined English) beside the next `n` dump texts from the first dump line containing `<anchor>`.
  - `table.tsv` columns: `file  start  label  source  flag  note`; `source` ∈ `TERMS`, `kristall:<bank:addr>`, `kristall-edited:<bank:addr>`, `legacy`, `pokewiki:<url>`, `own`, `user`; `flag` ∈ ``, `own`, `provisional`.

- [ ] **Step 1: Branch and commit the docs**

```bash
git switch -c new-bark-town master
git add docs/superpowers/specs/2026-11-21-new-bark-town-design.md docs/superpowers/plans/2026-11-21-new-bark-town.md
git commit -m "Design and plan the New Bark Town text"   # + Claude-Session trailer
```

- [ ] **Step 2: Write `test_blocks.py`** (plain `assert`s, run with `python3 -I`), on a fixture with a labelled block, an inline `jumpthistext` block, an `if DEF(DEBUG)`/`else`/`endc` pair of blocks under one label and a `text_ram` line:
  - `list` finds 4 blocks with labels `FooText`, `BarScript`, `MomIntroText` (debug), `MomIntroText` (normal) and endings `done`, `done`, `done`, `prompt`.
  - `apply` with a German block for `FooText` changes only that block; applying twice gives the same file.
  - `apply` with a block ending in `prompt` where `master` has `done` exits 1.
  - `english` flags `"Where are you going?"` and not `"Wohin gehst du?"` nor the debug block.
  - `endings` reports a block whose `text_promptbutton` was dropped.
  - `vars` gives 14 for `line "<PLAYER> erhält"` and flags `line "<PLAYER> erhält eine"` (19 > 18).
- [ ] **Step 3: Run it, expect failure** — Run: `python3 -I $S/test_blocks.py` — Expected: `ModuleNotFoundError` / `FileNotFoundError` for `blocks.py`.
- [ ] **Step 4: Implement `blocks.py` and `region.py`** — `blocks.py` takes the fixture's `master` text from an optional `--base <path>` instead of `git show` (the tests use it).
- [ ] **Step 5: Run it, expect success** — Run: `python3 -I $S/test_blocks.py` — Expected: `all passed`. Then `python3 -I $S/region.py PlayersHouse1F "Unser Nachbar" 3` — Expected: the first dump text is `1e:6c34  Oh, <PLAYER>…{line}Unser Nachbar,…`.

### Task 2: Mom's ground floor and her scene texts

**Files:**
- Modify: `maps/PlayersHouse1F.asm`; the scene texts in `data/text/common.asm` that Mom's scripts print (`_OakTimeWhatDayIsItText` and the day exchange, `Text_DSTIsThatOK`, `_TimesetAskDSTText`, `_TimesetAskNotDSTText`, `_TimesetNotDSTText`, `_MomBank…`, "Registered … number"), any player-visible strings in `engine/events/mom.asm` and `engine/rtc/timeset.asm` that these scenes show
- Modify: `TERMS.md` (new decisions only), `constants/huffman_text.inc` (regenerated)
- Scratch: `$S/de/<file>.txt`, `$S/table.tsv`

**Interfaces:**
- Consumes: `blocks.py`, `region.py`, `table.tsv` (Task 1).

- [ ] **Step 1: List the scene texts** by following `PlayersHouse1F.asm`'s `special`/`addcellnum`/`writetext` calls into the engine; write each label and file into `table.tsv` with its source column empty.
- [ ] **Step 2: Run the English check, expect failure** — Run: `python3 -I $S/blocks.py english maps/PlayersHouse1F.asm` plus the scene files restricted to the listed labels — Expected: exit 1, listing every normal Mom block (about 20).
- [ ] **Step 3: Pair with Kristall** — `region.py PlayersHouse1F "Unser Nachbar" 30`; record each Crystal block's dump address in `table.tsv`; Polished's own and edited blocks get `own`/`kristall-edited`.
- [ ] **Step 4: Write `$S/de/*.txt` and apply** — `python3 -I $S/blocks.py apply <file> $S/de/<file>.txt` for each file. Kristall lines verbatim (re-cased, ss); own lines flagged in `table.tsv`.
- [ ] **Step 5: Run the checks, expect success**
  - `python3 -I $S/blocks.py english …` → exit 0; `endings …` → exit 0; `vars …` → exit 0.
  - `python3 -I utils/check_text_width.py` → only the known `DownloadDescription` hit; `python3 -I utils/check_text_mode.py` → clean; `python3 -I utils/check_names.py` and `python3 -I utils/check_names.py --text maps/PlayersHouse1F.asm` → clean; `python3 -I utils/check_order.py` → passes.
- [ ] **Step 6: Regenerate Huffman and build** — `make tidy && make -j4 huffman > $S/chars.txt && ./utils/huffman.py $S/chars.txt constants/huffman_text.inc && make tidy && make vc 2> $S/build2.txt` — Expected: exit 0; `grep -c warning $S/build2.txt` equals the baseline (2 `-Wassert` lines plus tool lines); no `-Wunmapped-char`, no "not 8-bit".
- [ ] **Step 7: Commit** — `git add` the changed files; `git commit -m "Translate Mom's ground floor"` (+ trailer).

### Task 3: New Bark Town and its houses

**Files:**
- Modify: `maps/NewBarkTown.asm`, `maps/LyrasHouse1F.asm`, `maps/LyrasHouse2F.asm`, `maps/ElmsHouse.asm`, `maps/PlayersNeighborsHouse.asm`, `TERMS.md`, `constants/huffman_text.inc`

**Interfaces:**
- Consumes: Task 1's tools.

- [ ] **Step 1: Run the English check, expect failure** — `blocks.py english` on the five files — Expected: exit 1, every normal block listed.
- [ ] **Step 2: Pair with Kristall** — `region.py` per map with an anchor from its first Crystal text (`NewBarkTown`, `ElmsHouse`, `PlayersNeighborsHouse`; the Lyra houses are Polished's own, no region).
- [ ] **Step 3: Write and apply** — the four user decisions above verbatim (Lyra's goodbye, her post-League battle, the TV); Lyra's other lines own, flagged, friendly and on "du"; her dad's three states own, flagged. TERMS.md: the "Champ is neutral" rule and the gelbe Ziegelsteinstrasse equivalent.
- [ ] **Step 4: Run the checks, expect success** — as Task 2 Step 5, with `--text` on the five files, plus the gender grep from Review Focus 4 over the changed own lines: every hit is about someone else.
- [ ] **Step 5: Regenerate Huffman and build** — as Task 2 Step 6.
- [ ] **Step 6: Commit** — `git commit -m "Translate New Bark Town and its houses"` (+ trailer).

### Task 4: Elm's lab and the starter's scene texts

**Files:**
- Modify: `maps/ElmsLab.asm`; in `data/text/common.asm` the texts the lab prints that aren't German yet (`_PutItemInPocketText` and the "received" item text, `_ReceivedGiftMonText`, `_AskGiveNicknameText`, the rival's and the nickname's naming prompts if English, the "Registered … number" text if Task 2 didn't cover it); `TERMS.md`; `constants/huffman_text.inc`

**Interfaces:**
- Consumes: Task 1's tools.

- [ ] **Step 1: Run the English check, expect failure** — `blocks.py english maps/ElmsLab.asm` and the listed scene labels — Expected: exit 1.
- [ ] **Step 2: Pair with Kristall** — `region.py ElmsLab <anchor from ElmText_Intro> 120`, in two or three windows (the lab's texts span the Mystery Egg, Togepi, Master Ball and post-League visits).
- [ ] **Step 3: Write and apply** — the two Elm decisions above verbatim; `_PutItemInPocketText` fits 18 tiles with a 12-letter item and the longest pocket name (Review Focus 2), which fixes PR #9's overflow.
- [ ] **Step 4: Run the checks, expect success** — as Task 3 Step 4 on `ElmsLab.asm` and the scene files.
- [ ] **Step 5: Regenerate Huffman and build both variants** — Task 2 Step 6, then `make tidy && make faithful vc 2> $S/build4f.txt` — Expected: baseline warnings only; then `make tidy` back.
- [ ] **Step 6: Commit** — `git commit -m "Translate Elm's lab"` (+ trailer).

### Task 5: Play-test against Kristall and Polished's English

**Files:**
- Scratch only: clones `$S/de` (this branch) and `$S/en` (`master` before Task 2), movies in `vc/local/movies/nbt-*.ctm`, shots in `$S/shots-*`, comparison images `$S/*-compare.png`.

**Interfaces:**
- Consumes: the branch's ROM (Tasks 2–4).

- [ ] **Step 1: Build both normal ROMs and CIAs** — in each clone `make vc`, then `vc/build_cia.sh <rom> nbt-de` / `nbt-en` from the main checkout. Expected: two `.game.cxi` in `vc/local/out/`.
- [ ] **Step 2: Polished stage 1 (Mom)** — the room movie from `vc/README.md` extended: downstairs, Mom's intro, the Pokégear, the day, summer time, the phone; then save in the game. Shots every 1.5 s from the stairs. Run on `nbt-en` and `nbt-de` from the empty save (`vc/local/saves/` recipe, Polished's title `00172800`). Expected: every Mom box German, fitting; the same boxes at the same times as English.
- [ ] **Step 3: Polished stage 2 (town and lab)** — from stage 1's save: out of the house, Lyra's scene, Lyra's house (TV, dad, Lyra upstairs), Elm's house, the neighbours' house, the lab (speech, starter, nickname question, Elm's number, the aide's Potion). Shots every 1.5 s, 0.5 s around fast boxes.
- [ ] **Step 4: Kristall** — `k-stage1.ctm` from the empty save and `k-stage2.ctm` from stage 1's save (keep it in `vc/local/saves/kristall-pokegear/`), shots every 1.5 s; restore the empty save afterwards.
- [ ] **Step 5: Compare by position** — side-by-side images (German | Kristall where Polished kept the screen; German | English elsewhere) for Mom's intro, the Pokégear, the day question, Lyra in town, the TV, the starter question, the nickname question, Elm's number, the Potion. Expected: the same tiles in the same places, apart from ss for ß and Polished's own changes.
- [ ] **Step 6: Later scenes** — one debug-build hook clone per scene where time allows (Mystery Egg return, Togepi egg, Master Ball, post-League Elm and Lyra); each not reached is named in the PR.

### Task 6: PR, final review, merge

- [ ] **Step 1: Final review** — executing-plans' whole-branch review (most capable model), with this plan's Review Focus; one fix pass, each fix RED → GREEN with `blocks.py`/the checkers.
- [ ] **Step 2: PR** — `gh pr create --repo remo-vonarx/polishedcrystal --title "Translate New Bark Town"`; body per the `pr` template: the files, the sources by kind, own lines flagged (from `table.tsv`), provisional choices, screens seen and not reached, script jumps switched, the merge danger; ends with the session link.
- [ ] **Step 3: Merge** (the user's standing order) — only when every check, both builds and the Task 5 comparisons pass: `gh pr merge <n> --repo remo-vonarx/polishedcrystal --squash --subject "Translate New Bark Town"`; confirm `MERGED` before deleting the branch; `git switch master && git pull --ff-only`.
