# Violet City Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Every player-visible string in the 18 Violet-area and Route 32 map files and the scene texts they print is German, matching Kristall by position where Polished kept Crystal's screens.

**Architecture:** As for Cherrygrove: text edited in place block by block with the scratch tools (`blocks.py list/apply/english/unchanged/endings/vars`, `region.py`, `kdraft.py`, `kconv.py`, `checks.sh`), Kristall's German found by reading each map's dump region beside Crystal's English (Crystal Legacy `9a5b41a27`) in file order. Two data changes: the badge-name table, checked by `utils/check_names.py` from now on, and the shared trade texts.

**Tech Stack:** RGBDS 1.0.4 (`make vc`, `make faithful vc`), `utils/huffman.py`, the four check scripts in `utils/`, Python 3 scratch tools in `$S` (the Cherrygrove scratch directory), Azahar through `vc/gen_ctm.py`, `vc/playtest.py` and `$S/hook.py`.

**Spec:** `docs/superpowers/specs/2026-11-22-violet-city-design.md`

## Global Constraints

- Textbox 18 × 2 tiles; every line keeps all 18 tiles. Variables at their longest: `<PLAYER>`/`<RIVAL>` 7, Pokémon names and nicknames 10, item names 12, move names 12; `#mon` 7 tiles, `#` 4.
- Source priority: `TERMS.md` → Kristall verbatim (re-cased to mixed case, ß → ss) → Crystal Legacy's German (`main`) where its English (`9a5b41a27`) matches Polished's → PokéWiki → own translation, flagged.
- Spelling: `du`/`dein` lowercase; ss for ß; names mixed case; `#mon` for Pokémon; Avoid words in `GLOSSARY.md`.
- New lines address the player neutrally; "Champ" counts as neutral (the user, 2026-11-21).
- Never change how a box ends or a script's flow; re-break lines or add `para` boxes instead.
- Debug-only text stays English; faithful-only text is translated.
- `make vc` and `make faithful vc`: only the 2 baseline warnings; a short script jump pushed past 255 bytes switches to its long form (and back), listed in the PR.
- Regenerate the Huffman tables after the text changes.
- The user is online: real choices are collected and asked in question dialogs once the drafts are done (Task 7); work goes on meanwhile.
- Merge when green (the user, 2026-11-22): squash-merge with `--subject "<bare PR title>"`, check `MERGED` before deleting the branch.

## Review Focus

1. A changed line holding `<PLAYER>`, `<RIVAL>`, `text_ram`, `text_decimal` or a name, over 18 tiles at the variable's longest (`blocks.py vars`), above all the trade texts (two Pokémon names and a nickname) and the badge frame with the longest badge name.
2. A shared text shown in later areas (badge frame, the four trade sets, gym statues, female phone texts): counted at the longest values across all callers, and no article or case that depends on a variable.
3. Earl's blackboard menu: German entries wider than their column (5 tiles apart in a box to column 11) overwrite the next column or the border.
4. A text whose ending or inline `text_*` commands changed (`blocks.py endings`).
5. A new line that gives the player a gender (the New Bark Town grep).

---

### Task 1: Branch, docs, profile, scene table

**Files:** `docs/superpowers/specs/2026-11-22-violet-city-design.md`, this plan, `CLAUDE.md`; `$S/table3.tsv` (scratch).

- [ ] **Step 1:** On branch `violet`, load `mattpocock-skills:writing-for-agents`, then edit `CLAUDE.md`: under "Test entry points" add the hook method (scratch clone's `maps/NewBarkTown.asm`, never committed; `bg_event`s on the save's (6,6) neighbours run `warp`, `farscall` or `farwritetext`; save `vc/local/saves/polished-nbt-town/`, restored before every run); in "Previous translations to reuse" replace "It is partial … almost all English" with the measured state (German almost throughout on `main`, 328 of 333 maps, the phone texts and most of `data/text/`, as of `ca2a1775b`; its English before translation at `9a5b41a27`). Commit spec, plan and `CLAUDE.md` ("Design and plan the Violet City text", + trailer).
- [ ] **Step 2:** `python3 -I $S/test_blocks.py` → `all passed`.
- [ ] **Step 3:** List the scene texts by following the 18 maps' `jumpstd`/`callstd`/`special`/`verbosegive*`/`givebadge`/`giveegg`/`trade`/event macros into `engine/events/std_scripts.asm`, `engine/events/`, `engine/overworld/scripting.asm` and `data/text/`; write label, file and English/German state into `$S/table3.tsv`.

### Task 2: Badge names

**Files:** `utils/check_names.py`, `data/events/badge_names.asm`, `_ReceivedTheBadgeText` in `data/text/common.asm`; `TERMS.md`.

- [ ] **Step 1:** Add `('data/events/badge_names.asm', LI, None, None, 12, None, 'badges')` to `TABLES`; `python3 -I utils/check_names.py` → 16 English badge entries (RED).
- [ ] **Step 2:** Translate the 16 names from Kristall (`[names]` lists or the ROM): the table holds the stem, the frame adds "orden" as Kristall's one word ("Flügelorden"); the frame follows Kristall's "<PLAYER> erhält / …orden." and the stem limit follows from the frame's line (≤ 18 tiles with "orden." → 12). Both `if DEF(FAITHFUL)` orders.
- [ ] **Step 3:** `check_names.py` clean (GREEN); TERMS row; Huffman, `make vc` → baseline. Commit "Translate the badge names".

### Task 3: Route 31, its gates, Dark Cave

**Files:** `maps/Route31.asm`, `maps/Route31VioletGate.asm`, `maps/Route36VioletGate.asm`, `maps/DarkCaveVioletEntrance.asm`; their scene texts (Wade's phone texts, Rock Smash, cut and fruit trees where still English); `TERMS.md`; `constants/huffman_text.inc`.

- [ ] **Step 1:** `$S/b english <files>` → exit 1 (RED).
- [ ] **Step 2:** Pair with Kristall (`region.py`, `kdraft.py` against `git -C ~/Development/Pokemon_Crystal_Legacy show 9a5b41a27:maps/<Map>.asm`); Crystal Legacy's `main` for lines Kristall lacks.
- [ ] **Step 3:** Write and apply; Polished's own lines (the Route 36 gate, Dark Cave) flagged.
- [ ] **Step 4:** `$S/checks.sh "<files>" "<scene labels>"` → `CHECKS-OK`; the gender grep.
- [ ] **Step 5:** Huffman, `make vc` → baseline. Commit "Translate Route 31 and Dark Cave's entrance".

### Task 4: Violet City, its houses, the Outskirts, trades

**Files:** `maps/VioletCity.asm`, `maps/VioletMart.asm`, `maps/VioletPokeCenter1F.asm`, `maps/VioletNicknameSpeechHouse.asm`, `maps/VioletOnixTradeHouse.asm`, `maps/VioletOutskirts.asm`, `maps/VioletOutskirtsHouse.asm`; the four trade sets (`_NPCTradeIntroText1`–`4` and their follow-ups) and any English trade-screen text; the egg gift; `TERMS.md`; `constants/huffman_text.inc`.

- [ ] Steps as Task 3. Elm's aide and the egg verbatim from Kristall where the English matches; the cemetery and its house are Polished's own, flagged. The trade texts counted with two 10-tile names and a 10-tile nickname. Commit "Translate Violet City".

### Task 5: The Gym, Earl's Academy, Sprout Tower

**Files:** `maps/VioletGym.asm`, `maps/EarlsPokemonAcademy.asm`, `maps/SproutTower1F.asm`, `maps/SproutTower2F.asm`, `maps/SproutTower3F.asm`; the gym statue texts (`GymStatue_…` in `data/text/std_text.asm`), the TM gift texts; `TERMS.md`; `constants/huffman_text.inc`.

- [ ] **Step 1:** Read Kristall's blackboard menu from its ROM (box, rows, columns, spacing, entries; find it by its entry strings); write the German entries so each fits its column within Polished's `menu_coords 0, 0, 11, 8`, or note the wider box for Task 7.
- [ ] **Step 2:** Steps 1–5 as Task 3. Falkner and the Elder verbatim from Kristall; Polished's added blackboard topics own, flagged. Then `make tidy && make faithful vc` → baseline, `make tidy`. Commit "Translate the Violet Gym, Earl's Academy and Sprout Tower".

### Task 6: Route 32 and its Pokémon Center

**Files:** `maps/Route32.asm`, `maps/Route32PokeCenter1F.asm`; the female phone texts where still English; the Old Rod and TM Roar gifts; `TERMS.md`; `constants/huffman_text.inc`.

- [ ] Steps as Task 3, then `make tidy && make faithful vc` → baseline, `make tidy`. Commit "Translate Route 32".

### Task 7: The user's choices

- [ ] **Step 1:** Collect every real choice from Tasks 2–6 (names without a source, wordplay, a wider menu box) and ask them in question dialogs, up to 4 per dialog, each standing on its own (file:line, English, source, where it shows, one preview per text).
- [ ] **Step 2:** Apply the answers; TERMS rows as the user's choices; checks, Huffman, both builds → baseline. Commit "Apply the user's Violet City choices".

### Task 8: Play-test

- [ ] **Step 1:** In the scratch clone `$S/pt2` (pulled to `violet`), hook cases from the town save with `$S/hook.py`, one or two cases per build: the Gym (Falkner, the badge text, the TM, a statue), Sprout Tower (the Elder, TM Flash), the egg from Elm's aide, Earl's blackboard menu and one topic, Kyle's trade, Route 32 (the Old Rod, TM Roar), a Route 31 and a Route 32 trainer, the Outskirts sign. Shots every 0.5 s, contact sheets via `$S/sheet.py`.
- [ ] **Step 2:** The blackboard and the trade screen beside Polished's English (a `master` build of the same hook); the blackboard's box against Kristall's ROM data from Task 5.
- [ ] **Step 3:** Note every screen seen and every one not reached.

### Task 9: Review, PR, merge

- [ ] **Step 1:** Whole-branch review on the most capable model with this Review Focus; one fix pass, each fix RED → GREEN (a check, a build or a screen that failed first).
- [ ] **Step 2:** `gh pr create --repo remo-vonarx/polishedcrystal --title "Translate Violet City"`; body per the `pr` template: own lines listed, the user's choices, screens seen and not reached, the profile changes; ends with the session link.
- [ ] **Step 3:** When green, `gh pr merge --squash --subject "Translate Violet City"`; `gh pr view` → `MERGED`; delete the branch; update `master`.
