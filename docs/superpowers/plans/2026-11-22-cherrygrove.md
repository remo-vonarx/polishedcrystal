# Cherrygrove Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Every player-visible string in the 13 Cherrygrove-area map files and the scene texts they print is German, matching Kristall by position where Polished kept Crystal's screens.

**Architecture:** As for New Bark Town: text edited in place block by block with the scratch tools (`blocks.py list/apply/english/unchanged/endings/vars`, `region.py`, `kconv.py`, `checks.sh`), Kristall's German found by reading each map's dump region beside pret's English in file order. One new piece of data: a German plural table.

**Tech Stack:** RGBDS 1.0.4 (`make vc`, `make faithful vc`), `utils/huffman.py`, the four check scripts in `utils/`, Python 3 scratch tools, Azahar through `vc/gen_ctm.py` and `vc/playtest.py`.

**Spec:** `docs/superpowers/specs/2026-11-22-cherrygrove-design.md`

## Global Constraints

- Textbox 18 × 2 tiles; every line keeps all 18 tiles. Variables at their longest: `<PLAYER>`/`<RIVAL>` 7, Pokémon names 10, item names 12, move names 12; `#mon` 7 tiles, `#` 4.
- Source priority: `TERMS.md` → Kristall verbatim (re-cased to mixed case, ß → ss) → Crystal Legacy → PokéWiki → own translation, flagged.
- Spelling: `du`/`dein` lowercase; ss for ß; names mixed case; `#mon` for Pokémon; Avoid words in `GLOSSARY.md`.
- New lines address the player neutrally; "Champ" counts as neutral (the user, 2026-11-21).
- The Great Tree of Cherrygrove: "Grosser Baum von Rosalia" (the user, 2026-11-21). Lures: "…parfüm".
- Never change how a box ends or a script's flow; re-break lines or add `para` boxes instead.
- Debug-only text stays English; faithful-only text is translated.
- `make vc` and `make faithful vc`: only the baseline warnings; a short script jump pushed past 255 bytes switches to its long form, listed in the PR.
- Regenerate the Huffman tables after the text changes.
- Overnight standing order (the user, 2026-11-21): a new real choice takes my recommended option, marked provisional in `TERMS.md` and the PR. This PR stays open for the user.

## Review Focus

1. A changed line holding `<PLAYER>`, `<RIVAL>`, `text_ram`, `text_decimal` or a name, over 18 tiles at the variable's longest (`blocks.py vars`).
2. A shared scene text shown in other contexts (the nurse, the Mart, fruit trees, item balls, phone numbers): counted at the longest values across all callers, and no article or case that depends on a variable.
3. A plural produced by the new table that is wrong German for some item: every item name's plural is listed and checked.
4. A text whose ending or inline `text_*` commands changed (`blocks.py endings`).
5. A new line that gives the player a gender (the New Bark Town grep).

---

### Task 1: Branch, docs, tools

- [ ] **Step 1:** `git switch -c cherrygrove master` (after New Bark Town is merged); commit the spec and this plan ("Design and plan the Cherrygrove text", + trailer).
- [ ] **Step 2:** Carry the scratch tools over (`$S` stays the New Bark Town scratch directory); `python3 -I $S/test_blocks.py` → `all passed`.
- [ ] **Step 3:** List the scene texts by following the 13 maps' `jumpstd`/`callstd`/`special`/`pokemart`/event macros into `engine/events/std_scripts.asm`, `engine/events/`, `engine/items/mart.asm` and `data/text/`; write each label and file into `table.tsv`.

### Task 2: Route 29, the gate, Route 46

**Files:** `maps/Route29.asm`, `maps/Route2946Gate.asm`, `maps/Route46.asm`; the fruit-tree, item-ball and cut-tree texts; Route 46's phone texts; `TERMS.md`; `constants/huffman_text.inc`.

- [ ] **Step 1:** `blocks.py english` on the files and scene labels → exit 1 (RED).
- [ ] **Step 2:** Pair with Kristall (`region.py Route29 …`, `Route46`; pret's gate is `Route29Route46Gate`).
- [ ] **Step 3:** Write and apply; Lyra on "du"; Tuscany and the gate's own lines flagged.
- [ ] **Step 4:** `$S/checks.sh "<files>" "<scene labels>"` → `CHECKS-OK`; the gender grep.
- [ ] **Step 5:** Huffman, `make vc` → baseline warnings. Commit "Translate Route 29 and Route 46".

### Task 3: German plurals

**Files:** `data/text/plural_table.asm`; `TERMS.md`.

- [ ] **Step 1:** A scratch test `$S/test_plurals.py`: it reads `data/items/names.asm` and `plural_table.asm`, applies the table's suffix rules the way `TextCommand_PLURAL` does (first matching suffix in order) and compares each item's plural with a hand-checked list `$S/plurals.tsv` (Pokéball → Pokébälle, Trank → Tränke, Supertrank → Supertränke, Beere names → …beeren, Sonderbonbon → Sonderbonbons, …). Run it on `master`'s table → FAIL (RED).
- [ ] **Step 2:** Write the German rules (`if DEF(FAITHFUL)` rules for faithful-only names); every plural fits the buffer the engine pluralizes into.
- [ ] **Step 3:** The test passes; the build has the baseline warnings. Commit "Use German plurals for item names" (provisional; the user decides in the PR).

### Task 4: Cherrygrove City and its buildings

**Files:** `maps/CherrygroveCity.asm`, `maps/CherrygrovePokeCenter1F.asm`, `maps/CherrygroveMart.asm`, `maps/CherrygroveGymSpeechHouse.asm`, `maps/GuideGentsHouse.asm`, `maps/CherrygroveEvolutionSpeechHouse.asm`, `maps/CherrygroveBay.asm`; the nurse texts (`data/text/std_text.asm`), the Mart texts, the move tutor texts; `TERMS.md`; `constants/huffman_text.inc`.

- [ ] Steps as Task 2. The Guide Gent's tour and map card, the rival's lines before and after the battle, the Great Tree decision verbatim. Cherrygrove Bay is Polished's own, flagged. Commit "Translate Cherrygrove City".

### Task 5: Route 30 and Mr. Pokémon's house

**Files:** `maps/Route30.asm`, `maps/Route30BerrySpeechHouse.asm`, `maps/MrPokemonsHouse.asm`; Joey's phone texts; Oak's Pokédex and the Mystery Egg receive texts if shared; `TERMS.md`; `constants/huffman_text.inc`.

- [ ] Steps as Task 2, then `make tidy && make faithful vc` → baseline warnings, `make tidy`. Commit "Translate Route 30 and Mr. Pokémon's house".

### Task 6: Play-test

- [ ] **Step 1:** Build the branch's and `master`'s ROMs in scratch clones; package `cg-de` and `cg-en`.
- [ ] **Step 2:** From the town save (`vc/local/saves/polished-nbt-town/`, made in New Bark Town's play-test): Route 29 with Lyra and the Poké Balls (the plural), Cherrygrove (the Guide Gent and map card, the nurse, the Mart), Route 30, Mr. Pokémon's house (the egg, Oak, the Pokédex). Shots every 1 s; screens extended past the movie's end on a busy machine.
- [ ] **Step 3:** Kristall from `vc/local/saves/kristall-elms-lab/`, extended to Cherrygrove and Mr. Pokémon; compare by position (German | Kristall; German | English where Polished changed the screen).
- [ ] **Step 4:** Side areas (Route 46, the Bay, the berry house) where time allows; name the rest in the PR.

### Task 7: Review and PR

- [ ] **Step 1:** Whole-branch review on the most capable model with this Review Focus; one fix pass, each fix RED → GREEN.
- [ ] **Step 2:** `gh pr create --repo remo-vonarx/polishedcrystal --title "Translate Cherrygrove"`; body per the `pr` template, own and provisional lines listed, the plural question, screens seen and not reached; ends with the session link. Leave it open.
