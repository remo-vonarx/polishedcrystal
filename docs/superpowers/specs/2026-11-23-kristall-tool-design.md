# Kristall tool and checks: design (G4)

## Intent

The roadmap (`2026-11-23-translation-roadmap-design.md`) puts every text that is still pret's English word for word into the game as Kristall's German, written by a tool and verified by a check, never retyped (chunk K). The first attempt copied Kristall's lines by hand from a text dump; they were mostly right, but only by diligence: the dump skipped texts and nothing checked them afterwards. G4 builds the machinery so that inherited lines are right by construction, and so that every later chunk finds Kristall's line for a text Polished changed without searching by hand.

G4 writes no German into the game. The writer runs for real in chunk K.

## Goals, non-goals, anti-goals

- **Goals**
  - For every English text in pret's Crystal, Kristall's German for it, paired by structure, never by guessing.
  - For every Polished text: whether it is word for word pret's English (K writes it), changed (the chunk reviews start from Kristall's line), or new.
  - A writer that turns Kristall's text into ours: re-cased, names swapped as **Project decisions** say, re-broken only where a swap overflows a line.
  - A check that re-derives every inherited text and fails on any drift.
  - The line checks every chunk runs: width, text mode, names, order, English left.
- **Non-goals**
  - Writing German into the game (chunk K).
  - Filling the re-casing dictionary or the name map (chunks 1–5 and K, each entry asked in dialogs where it isn't obvious).
  - Pairing Polished's own content (no Kristall text exists for it).
- **Anti-goals**
  - A pair that the tool guessed. A text it can't pair by structure is reported as unpaired, never matched by similarity of German.
  - Nintendo text in git. Pairs, lookups and test data built from the ROMs stay in `.claude/upload/`.
  - A check that passes because it reads the same wrong data the writer wrote: the check derives from Upstream's English and the ROMs, not from our files.

## Constraints

- Inputs, all read-only: `~/Development/pokecrystal` at `9ce4c4e50` with `pokecrystal.gbc` (revision 1.0), `.sym` and `.map` built (`make -j8 compare`); Kristall's ROM (`.claude/upload/`, SHA-1 `accb5842…`); Polished's source tree; Upstream's English from the last merged Upstream commit (`git merge-base HEAD upstream/master`, `c321e5284` until the first merge).
- Tools in `utils/`, Python 3 standard library, run as `python3 -I`. Tests in `utils/tests/`, run with pytest from the scratchpad venv.
- Both ROMs: a text inside `if DEF(FAITHFUL)` has a Regular and a Faithful variant; both are handled. `if DEF(DEBUG)` blocks are left out everywhere.
- Characters: Polished's charmap (`constants/charmap.asm`) since G3: `ß` `$c1`, umlauts in the former Spanish slots, `'d` as two tiles. Kristall's letters: pret's charmap plus `ß` `$be`, `$f2` as the decimal point (the dump script's table).

## Approaches

Decided with the user on 2026-11-23:

- **Walk both ROMs side by side (chosen).** Kristall's map tables (`MapGroupPointers` at `25:4000`, the map headers) are byte-identical to pret's English ROM, and its map scripts and events differ only in their pointer bytes (seen on Route 26: six differing bytes, all pointers). So the tool interprets each script in both ROMs in lockstep and pairs every text pointer with its twin. Engine texts sit in 10 text sections that each start a bank at `$4000`; nine are read text by text in both ROMs, the tenth ("Miscellaneous Text", which also holds code) through its pointers. Pokédex entries and move and item descriptions come from pointer tables. Every pair is proven by structure; a mismatch stops the tool.
- **Line up the dump by order (rejected).** The n-th English text with the n-th German one per bank: a text the dump skips shifts every later pair in its bank, undetected.
- **Match by fingerprint (rejected).** Pairing by RAM references and line patterns: short texts ("…", "Hm?") look alike everywhere, so pairs would be guesses.
- **Changed lines: also looked up (chosen),** rather than handling only word-for-word texts. Every Polished text that isn't word for word gets its closest pret text and Kristall line, for the middle column of later reviews.

## The design

### 1. Pairs: `utils/kristall_pairs.py`

Reads pret's ROM, `.sym` and `.map` and Kristall's ROM, and writes `.claude/upload/kristall_pairs.json`: one record per pret text with its pret label (or `bank:address` where pret has no label), kind, both addresses, the path that reached it, and both texts decoded into commands and strings (pret's English in pret's charmap, Kristall's German in Kristall's letters).

How texts are reached, in this order:

- **Maps.** `MapGroupPointers` → each map header → its attributes → its scripts (scene scripts, callbacks) and events (coord events, bg events, object events with their scripts, trainer headers and item balls). Every script is interpreted in both ROMs at once. The command set and each command's operand layout are read from pret's `macros/scripts/events.asm` (170 macros of the form `db <name>_command` followed by `db`/`dw`/`dba`/`dn` operands), not typed in. At every step the command byte must be equal in both ROMs; pointer operands are paired, and the walk follows jumps, calls, conditional branches, far jumps, `callstd` (pret's `StdScripts` table) and every text operand (`writetext`, `farwritetext`, `jumptext`, `farjumptext`, `jumptextfaceplayer`, trainer header texts, `winlosstext`, …). It stops a branch at `end`, `endcallback`, `return` and similar, and at `callasm`/`special`/`memcall` targets (code, not followed).
- **Texts.** Each text is decoded in both ROMs with pret's text command set (`macros/scripts/text.asm`); `text_far` is followed in both, and `text_asm` ends the text (code follows). A pair is proven by where it was reached (the pointer it came from, or its place in a text section), not by its content. Kristall's text often has the same commands with different strings, but not always: of the 1,651 texts in the text sections, 119 differ in structure (Kristall opens with a variable, reorders variables, drops one, or ends differently: `_StoppedEvolvingText` drops the Pokémon's name, `_CantUseTeleportText` ends in `prompt` where pret ends in `para ""` / `done`). Such a pair is kept and marked **structure differs**, with both command sequences; RAM operands are still read with Kristall's addresses equal to pret's WRAM.
- **Phone.** The phone contact tables (`PhoneContacts`, `SpecialPhoneCallList`) lead to call scripts, walked like map scripts.
- **Text sections.** pret's text-only sections that start a bank at `$4000` ("Text 1"–"Text 3", the five phone text sections, "Battle Tower Text"; read from `pokecrystal.map`) are read text by text in both ROMs from `$4000` and paired by order; each section must hold the same number of texts in both ROMs, else the tool stops. "Miscellaneous Text" holds code and name lists, so its texts are paired only through pointers. Each text's label comes from the `.sym`. Pairs already found through scripts into these sections must agree with the order pairing, else the tool stops.
- **Tables.** `PokedexDataPointerTable`, `MoveDescriptions` and `ItemDescriptions`: Kristall's table is taken at the same address when every pointer in it leads to a well-formed entry of the expected kind; otherwise the tool stops and reports.
- **Coverage report.** Every text in `german_text_dump.txt`'s `[texts]` that no pair covers is listed as unreached, and so is every pret text label in the walked sections that got no pair. Neither is fatal; both are numbers the builder brings down before G4 ships.

### 2. Index: Polished's texts against pret's

A shared module (`utils/kristall_index.py`) parses Polished's text blocks from the asm source (`maps/`, `data/`, `engine/`, `home/`): label, file and line, the command sequence (`text`, `line`, `cont`, `para`, `next`, `page`, `done`, `prompt`, `text_ram`, `text_far`, …), both variants of an `if DEF(FAITHFUL)` block, `DEBUG` blocks dropped. pret's English for each pair comes from the pairs file, with `text_far` resolved so a stub and its target count as one text.

Normalized form, for comparing: lower case; `line`, `cont`, `next`, `para` and `page` as one space; whitespace collapsed; `#` as "poké" and `#mon` as "pokémon" on both sides; pret's `<PLAY_G>` equal to Polished's `<PLAYER>`; the box ending (`done` / `prompt` / `text_end`) compared on its own.

**English renames count as equal.** Polished renamed many Gen 2 names in English ("Bell Tower" for TIN TOWER, 21 lines; "Paralyze Heal" for PARLYZ HEAL). A text that differs from pret's only by such renames is word for word, and the writer's name swap turns Kristall's name into ours (`ZINNTURM` → `Glockenturm`), as the roadmap intends. The rename list (`utils/english_renames.tsv`, committed, English only) comes from two places: pret's and Polished's name tables (Pokémon, moves, items, key items, trainer classes, landmarks) matched by constant, with a short list of constant pairs that differ (`PARLYZ_HEAL` / `PARALYZEHEAL`); and a hand-kept part for other purely mechanical edits, each entry with its reason. Anything else Polished changed makes the text "changed".

**Where a text sits.** The walk records, for each pret text, its map and event (object by trainer constant or by sprite and position, bg event by position, coord event, scene script). The index records the same for each Polished text from its map's `def_object_events`, `def_bg_events` and `def_coord_events`. Polished often drops pret's labels (texts inline after `generictrainer` or `jumpthistext`), so this link matters more than labels.

Each Polished text gets one class:

- **Word for word:** its normalized English equals one pret text's. If several pret texts share that English (pret has 339 such texts in 136 groups, "We hope to see you again." five times) and Kristall translated them differently, the one at the same map and event decides; only where that doesn't settle it is the text **ambiguous** and flagged for a question.
- **Changed:** the closest pret text: the same map and event first, then the same label, else the highest similarity of normalized English (`difflib` ratio) above a threshold the builder sets from the data; with its Kristall line and the score.
- **New:** nothing close enough.

`utils/kristall_lookup.py <file[:line] | label>` prints a text's class and, side by side, the hack's English, Kristall's line and (empty, or the current German) ours, laid out as CLAUDE.md's review columns. Its output stays in the terminal; nothing is written to git.

### 3. Writer: `utils/kristall_write.py`

For each word-for-word text (and only those), the writer builds our German from Kristall's:

1. **Re-case.** Kristall writes names and some other words in capitals. Each run of capitals is looked up in a re-casing dictionary (`utils/kristall_case.tsv`, committed: words only, no sentences), which the name chunks and K fill: `PROF. LIND` → `Prof. Lind`, `KNOFENSA-TURM` → `Knofensa-Turm`, `#MON` → `#mon`, `des NACHTs` → `des Nachts`. A word split by a line break (`ARENA-` / `LEITER`) is looked up joined and re-cased as German writes it (`Arena-` / `leiter`). A capital run not in the dictionary is reported, never guessed.
2. **Swap names.** Where our name differs from Kristall's (modern names, **Project decisions**), the name map (built from the translated name tables against Kristall's, chunks 1–5) swaps it: `ZINNTURM` → `Glockenturm`.
3. **Fit.** Kristall's words and breaks stay. Only a paragraph where a swap pushed a line past its width (18 tiles; variables counted at their maximum, as `check_text_width.py` counts them) is re-broken, greedily, inside that paragraph; its `para` boundaries and its ending stay.
4. **Keep Polished's frame.** Label, surrounding code, the box ending and any `if DEF(FAITHFUL)` structure stay as in Polished.
5. **Follow Kristall's structure.** Kristall's lines are taken as they stand (CLAUDE.md, **Source priority** 2), so where Kristall's commands differ (structure differs), the text is rebuilt in Kristall's order: its words, its line commands, its variables. Each Kristall variable is mapped to Polished's command through the English: pret's variables and Polished's appear in the same order in their word-for-word English, which pairs each pret RAM address with Polished's form (`text_ram wStringBuffer1`, `<PLAYER>`, …). A variable Kristall drops is dropped; one it adds is mapped by its pret `.sym` name; one that can't be mapped is flagged. Polished's box ending stays even where Kristall's differs.
6. **Flags, not guesses.** A text with only part of it inside `if DEF(FAITHFUL)` is flagged, not written. Answers to flags (which pret text an ambiguous text takes, a re-casing entry) are recorded in committed files the writer reads (`utils/kristall_case.tsv`, `utils/kristall_choices.tsv`: pret labels and words, no sentences), so a rerun gives the same result.

It writes in place, prints what it changed, and lists everything it couldn't do (ambiguous, unknown capitals, a fit that fails). In G4 it runs as a dry run and in tests only.

### 4. Check: `utils/check_kristall.py`

For every text whose English in Upstream's source (the merge-base, read with `git show`) is word for word pret's, it derives our German the way the writer does and compares it with the current asm. It fails on any difference: a hand edit of an inherited line, a writer bug, or an Upstream change that made a text no longer word for word. Before K it reports how many inherited texts are still English, without failing.

### 5. Line checks

- `check_text_width.py` and `check_text_mode.py` from the first attempt, adapted to this `master` (G3's characters: `ß` one tile, `'d` two).
- `check_names.py` and `check_order.py` from the first attempt, adapted. They meet translated tables only from chunks 1–3; until a table is translated, its entries count as expected English rather than failures (the builder picks how a run names which tables must be German).
- `check_english_left.py` (new): a line still equal to Upstream's English at the same label, in either variant of an `if DEF(FAITHFUL)` block, `DEBUG` skipped, limited to the paths a chunk names. Lines that are legitimately the same in German (a name alone, "OK") are listed in the script with a reason.
- The profile's **Check scripts** row lists them, how to run them, and their known false alarms.

### 6. Tests: `utils/tests/test_kristall.py`

One test per Review Focus line of the roadmap plan, plus unit tests of the decoders and the interpreter:

- `test_ambiguous_english_is_flagged`: one English text with two different Kristall wordings is flagged, not picked.
- `test_recase_non_names_and_split_words`: `des NACHTs` → `des Nachts`; `ARENA-` / `LEITER` → `Arena-` / `leiter`.
- `test_name_swap_rebreaks_paragraph`: `ZINNTURM` → `Glockenturm` overflowing a line re-breaks that paragraph, and the width check passes.
- `test_faithful_twin_left_english_is_reported`: a German Regular line with its Faithful twin still English is reported by `check_english_left.py`.
- `test_dump_gaps_are_paired`: Oak's text at Mr. Pokémon's house (65:78xx) and the Route 31 letter scene (69:5acd), both missing from the dump, are paired.

Tests that need a ROM read it from its path and skip when it is missing; fixtures built from Nintendo text live in a temporary directory, not in git.

## Calls made in this design (for the user to check)

- A pair proven by its position is kept even when Kristall's command structure differs; the writer rebuilds such a text in Kristall's order, with Polished's box ending.
- Kristall is taken as it stands where it drops or adds a variable (CLAUDE.md, Source priority 2).
- English renames from the name tables, plus a reasoned hand-kept list, count as equal, so texts such as `TinTowerSignText` are inherited with the name swapped.
- An ambiguous text is settled by its map and event where that is unique; only the rest go to dialogs.
- "Miscellaneous Text" is paired through pointers only.

## Left to the builder

- The JSON layout of the pairs file and the index, the CLI flags, and how the tools share code.
- The similarity threshold for "changed" against "new", set from the data.
- How a check run names its scope (paths, tables) and how the line checks report.
- The list of pret commands whose operands are not followed (code targets), as long as each is reported in the coverage numbers.
- Bringing the unreached counts down; what stays unreached is listed in the PR with a reason.
