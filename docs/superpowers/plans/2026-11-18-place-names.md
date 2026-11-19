# Place Names Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Every place name is German, long names break on the Pokégear and Town Map as Kristall's do and print whole everywhere else, and the name checker measures each name against every screen's room.

**Architecture:**
- Two break marks, `<SHY>` (soft hyphen) and `<WBR>` (silent break), take bytes `$4b` and `$4c`, which `constants/charmap.asm` lists as unused (`$0a - $4c`). The text printer skips them, the Pokégear and Town Map break the line at them, and the entry sign leaves them out.
- `data/maps/landmarks.asm` holds the names. A generator fills it from Kristall's ROM, PokeAPI, PokéWiki research and the user's answers, and leaves every open name English so the checker lists it.
- The checker gains a place measure (bytes, one-line tiles per screen, Pokégear lines).

**Tech Stack:** Python 3 (stdlib), git, RGBDS 1.0.4 (`make vc`), Azahar through `vc/gen_ctm.py` and `vc/playtest.py`, PokeAPI's CSV data, PokéWiki, Kristall's ROM.

**Spec:** `docs/superpowers/specs/2026-11-18-place-names-design.md`; part 1's `docs/superpowers/specs/2026-11-17-name-tables-design.md` ("Name checker"); CLAUDE.md.

## Global Constraints

- CLAUDE.md governs every string. ADR 0002 (Modern names, spelling and hyphens included; Abbreviation when too long; Kristall's name when the Modern one is over the limit) and ADR 0003 (ss) apply.
- Only string contents change, plus the break marks (Task 2) and the checker (Task 1).
- Room for each place name (the design's Constraints):
  - at most 18 bytes, the marks included;
  - on one line, with `¯` as a space and the marks as nothing: at most 18 tiles, 17 for a place with Johto grass Pokémon (Oak's show), 16 for a flypoint;
  - on the Pokégear, at most 2 lines of at most 11 tiles, counting the "-" a `<SHY>` adds.
- Kristall's names are taken verbatim except for three things: mixed case, ss for ß, and its break codes mapped to Polished's (`¯` → `¯`, `$1E` → `<SHY>`, `%` → `<WBR>`). Kristall's break positions stay.
- Source order: TERMS.md, Kristall, later games (PokeAPI, with PokéWiki winning where they differ), then Anime names (PokéWiki; places in no game only), then own names. Each Anime name and own name is flagged.
- Every settled term goes into `TERMS.md` in the same commit as the strings that use it. Questions go to the user in question dialogs, each with a preview of the Pokégear lines and the sign.
- Branch `place-names`, which holds the design commit. The PR is "Translate the place names" on the fork, squash-merged with the bare title as the subject. Ask before pushing and merging.
- Scratch locations, which never get committed:
  - `$S3` is `scratchpad/places/` in the session scratchpad. It holds `kristall_landmarks.py` (Kristall's 102 names from ROM `$72:$6a64`), `pairs.tsv` and `modern.tsv` (label, English, Kristall, PokeAPI German).
  - `scratchpad/pokeapi/locations/` caches PokeAPI's CSVs.
  - `$S1` (`scratchpad/names/`) holds the checker fixtures.
  - Scripts, clones, movies and screenshots stay in scratch.

## Scope

| Places | German |
|---|---|
| 94 Kristall names that PokeAPI confirms | Kristall, re-cased. Marked: Einheits`<SHY>`tunnel, National`<SHY>`park, Strudel`<SHY>`inseln, Drachen`<SHY>`höhle, Zinnober`<SHY>`insel, Sieges`<SHY>`strasse, Seeschaum`<SHY>`inseln, Steinei`<SHY>`chenwald, Knofensa-`<WBR>`Turm, Flegmon-`<WBR>`Brunnen, Vertania-`<WBR>`Wald |
| Modern names over Kristall's | Glockenturm, Pokémon-`<WBR>`Villa, Digda-Höhle, Indigo-`<WBR>`Plateau; Radioturm stays (PokeAPI's "Radio-Turm" is an error) |
| Kristall names to check on PokéWiki | Silberhöhle, Kraftwerk, Radioturm`¯`Lav., Untergrund (Underground Path), Route 40, Route 41 |
| Later games, found | Glockenklangpfad, Route 47, Route 48, Felsklippentor, Felsschlundhöhle, Nabelfels, Fern-Eiland, Sinjoh-Ruinen |
| To research, then asked | the design's 25 (the Pokémon League Gate among them), the 12 movie places, Fast Ship |
| Outside the table | Fly's `.PokemonLeagueFlyName` and `.Where` (`engine/pokegear/pokegear.asm`); the summary's `.battle_factory` and `.event` (`engine/pokemon/summary/orange_page.asm`) |
| Unchanged | `SpecialMapName` "?" |

## Review Focus

1. **A marked name printed by the general text printer** (summary, phone, radio, `getlandmarkname` dialogue). Expected: the whole word, with no hyphen, no gap and no cut. Task 2's play-test pins it through the summary, which uses the same `PlaceString` path.
2. **The entry sign centring a marked name.** Expected: the same left edge as an unmarked name of the same visible length. Task 2 compares "Einheitstunnel" with a 14-letter name without marks.
3. **The longest marked name on the Pokégear**, where the soft hyphen's "-" is inserted into the buffer. Expected: both lines whole and nothing written past the name. Task 2's 18-byte test name pins it.
4. **Kristall's casing around the marks.** Expected: lowercase after `<SHY>` ("Einheits-tunnel"), the capital kept after `<WBR>` ("Flegmon-Brunnen"), "des" lowercase ("See des Zorns"). Task 3's dry run asserts the 11 marked names and "See des`¯`Zorns" exactly.
5. **An Upstream merge that adds a place or a flypoint.** Expected: the checker reports the new name with its room. Task 1's fixtures F22 and F25 pin it.

---

### Task 1: The checker learns places

**Files:**
- Modify: `utils/check_names.py`, `CLAUDE.md` ("Check scripts" row)
- Test: `$S1/test_check_names.sh` (fixtures; extend in place)

**Interfaces:**
- Produces:
  - `place_rooms(root: Path) -> dict[str, int]`: each landmark label maps to its one-line limit (16, 17 or 18). It reads `data/maps/flypoints.asm` (landmark constants) and `data/wild/johto_grass.asm` (`def_grass_wildmons MAP`). A map's landmark comes from pairing `map_const` in `constants/map_constants.asm` with `map` in `data/maps/maps.asm` by order (612 each) and taking field 5. Labels pair with landmark constants by order in `constants/landmark_constants.asm` and the `landmark` lines.
  - `place_problems(name: str, one_line_limit: int) -> list[str]`: returns the messages `too many bytes (N > 18)`, `too long on one line (N > L)`, `Pokégear line too long (N > 11)` and `more than two Pokégear lines`. `<SHY>` and `<WBR>` take 0 tiles and 1 byte; `¯` takes 1 tile and 1 byte.
  - A `TABLES` row `('data/maps/landmarks.asm', LABEL_RAWCHAR, None, None, 'place', 'place', 'places')`, whose limit `'place'` selects the place measure.
  - Two more rows: Fly's `.PokemonLeagueFlyName` (limit 16) and the summary's `.battle_factory` and `.event` (limit 19).
  - `SAME_IN_GERMAN['places']`: `Route 1` … `Route 49` and `?`.
  - A `--text` category `'place'`, matching the English with `¯` read as a space.

- [ ] **Step 1: Fixtures.** Add minimal English and German versions of the files above to the fixture tree, so F1 stays clean. New cases:
  - `F22-place-english`: `NewBarkTownName: rawchar "New Bark¯Town@"` left English → `still English`.
  - `F23-place-bytes`: `"Abcdefghij<SHY>klmnopqr"` → `too many bytes (19 > 18)`.
  - `F24-place-line`: `"Abcdefghijk<SHY>l"` → `Pokégear line too long (12 > 11)`; `"Abcdefghij<SHY>kl"` passes.
  - `F25-place-rooms`: a 17-tile flypoint → `too long on one line (17 > 16)`; an 18-tile Johto grass place → `(18 > 17)`; a 19-tile other place → `(19 > 18)`.
  - `F26-place-breaks`: `"Ab¯cd<WBR>ef"` → `more than two Pokégear lines`.
  - `F27-fly`: `.PokemonLeagueFlyName` left "Pokémon League" → `still English`.
  - `F28-text-place`: `--text` on `text "New Bark Town"` reports one hit.
- [ ] **Step 2: Run** `$S1/test_check_names.sh`. Expected: the new cases FAIL, F1–F21 as before.
- [ ] **Step 3: Implement** the interfaces above. A place still English is reported by the existing still-English rule.
- [ ] **Step 4: Run** the fixtures. Expected: `28/28 passed`. Then `python3 -I utils/check_names.py | grep -v "still English"`. Expected: no output; each English place fits its room. If one doesn't, ledger it as Upstream's.
- [ ] **Step 5:** Add the place measure to CLAUDE.md's "Check scripts" row. Commit "Teach the name checker the place names".

### Task 2: The break marks

**Files:**
- Modify: `constants/charmap.asm`, `home/text.asm` (`PlaceNextChar`), `engine/pokegear/pokegear.asm` (`_UpdateLandmarkName`), `engine/events/map_name_sign.asm` (length count and drawing loop), `CLAUDE.md`
- Test (scratch): clone `$S3/clone-marks/`, its movie and screenshots

**Interfaces:**
- Produces: `charmap "<SHY>", $4b` and `charmap "<WBR>", $4c` in the `no_ngrams` charmap; the comment becomes `; unused: $0a - $4a`.

- [ ] **Step 1: RED.**
  - Clone this branch to `$S3/clone-marks/`.
  - In the clone only, add the two charmap entries and set three test names: `NewBarkTownName` "Einheits<SHY>tunnel", `Route29Name` "Flegmon-<WBR>Brunnen", `CherrygroveCityName` "Abcdefgh<SHY>ijklmnopq" (18 bytes).
  - `make tidy && make debug vc`, CIA. The movie shows: the summary of the starter (place of capture New Bark Town); the Pokégear map card on each of the three places (debug radio for the cards); the signs walking from New Bark Town to Cherrygrove.
  - Expected: every test name cut at its mark ("Einheits").
- [ ] **Step 2: Implement** in the main checkout, the charmap entries included.
  - `PlaceNextChar`: a byte in `$4b`–`$4c` jumps to `NextChar`, before the `FinishString` fall-through.
  - `_UpdateLandmarkName`: `¯` and `<WBR>` become `<LNBRK>`. `<SHY>` becomes "-" followed by `<LNBRK>`, shifting the tail one byte right; `wStringBuffer1` holds 24 bytes and names at most 18.
  - The sign: its length loop and its drawing loop both skip the marks.
- [ ] **Step 3: GREEN.** Copy the four changed files into the clone, keep its test names, rebuild and replay the movie. Expected:
  - the summary "Einheitstunnel";
  - the Pokégear "▲Einheits-" / " tunnel", "Flegmon-" / "Brunnen" and "Abcdefgh-" / "ijklmnopq";
  - the signs "Einheitstunnel", centred like a 14-tile name, and "Flegmon-Brunnen".
- [ ] **Step 4: Verify.**
  - `make vc` shows the baseline warnings only.
  - `make freespace`: ROM0 still has room; note the bytes left.
  - The Huffman tables, regenerated as `utils/huffman.py` says, are unchanged (`git status` clean).
- [ ] **Step 5:** CLAUDE.md:
  - the "Character set" row names `<SHY>` and `<WBR>` and where they act;
  - the "Textbox" row says the Pokédex area page's variable-width string is the area type ("Morning", "Surfing"), not a place name.
  
  Commit "Add the soft hyphen and silent break for place names".

### Task 3: Fill the place table

**Files:**
- Modify: `data/maps/landmarks.asm`, `TERMS.md`
- Create: `$S3/gen_places.py`, `$S3/research.md`

**Interfaces:**
- Consumes: `$S3/kristall_landmarks.py`, `$S3/modern.tsv`, Task 1's `place_rooms` and `place_problems` (imported from `utils/check_names.py`).
- Produces: `gen_places.py REPO [--write]`. It prints, for each label, the English, the German (an open name keeps its English), the source and any `place_problems`. Its `OVERRIDES` maps label → German with marks.

- [ ] **Step 1: Research.** Look up on PokéWiki, with a source URL per name, into `$S3/research.md`:
  - the 25 places not yet looked up;
  - the 12 movie places (Anime names);
  - the six Kristall names to check;
  - the League's spelling, the gate, Battle Factory, and an Anime name for "Event Pokémon" if one exists.
  
  Mark each as official, Anime or none.
- [ ] **Step 2: Dry run, test first.** `gen_places.py` asserts the 11 marked names (Scope) and `"See des¯Zorns"` exactly, and lists the problems. Expected: the assertions pass; open names are only those from Task 3's research marked "none", Fast Ship, and those needing an Abbreviation.
- [ ] **Step 3: Write** (`--write`). Run `python3 -I utils/check_names.py`. Expected: only `still English` lines for the open names. `make vc` shows the baseline warnings and no `-Wunmapped-char`.
- [ ] **Step 4:** TERMS.md rows: Kristall's places (source, casing, marks), the four Modern names over Kristall's, the later games' places and the Anime names found. Commit "Translate the place names" (open names still English).

### Task 4: The user's answers

**Files:** `data/maps/landmarks.asm`, `engine/pokegear/pokegear.asm`, `engine/pokemon/summary/orange_page.asm`, `TERMS.md`, `CLAUDE.md` ("Names" line)

- [ ] **Step 1: Ask** in dialogs of up to 4, each with a preview of the Pokégear lines and the sign:
  - Fast Ship (Schnellboot or M.S. Aqua);
  - the Pokémon League Gate, together with Fly's short form so the two agree;
  - each Abbreviation;
  - each own name, and each Anime name that needs a choice or a break;
  - the summary's two strings if no official name exists.
  
  Record each answer in TERMS.md.
- [ ] **Step 2: Fill.** Add the answers to `OVERRIDES`, then re-run Task 3's steps 2–3. Fly's two strings and the summary's two strings:
  - Fly's "Where?" comes from Kristall's Fly map, read from its ROM. If it isn't found, it's asked like a name.
  - The checker's rows from Task 1 cover all four.
  
  Expected: `python3 -I utils/check_names.py` prints nothing.
- [ ] **Step 3:** CLAUDE.md's "Names" line gets the Anime-name rule (2026-11-18). Commit "Settle the remaining place names".

### Task 5: Play-test

**Files (scratch only):** `$S3/clone-de/` and `$S3/clone-en/` (this branch and `master`), hooks, movies in `vc/local/movies/`, screenshots in `$S3/shots/`

- [ ] **Step 1:** Debug builds of both clones with the same hooks. One build per case, since hooks fire unconditionally:
  - a warp into Union Cave and one into Slowpoke Well, for their signs;
  - a party Pokémon that knows Fly, for the Fly menu;
  - the starter, for the summary.
- [ ] **Step 2:** Movies, both builds:
  - the signs: Neuborkia → Route 29 → Rosalia City, then Union Cave, Slowpoke Well and the longest name (a warp hook);
  - the Pokégear map card and the Town Map, the cursor on Einheitstunnel, Seeschauminseln, Indigo-Plateau and the longest name;
  - Fly on the longest flypoint and on the Pokémon League;
  - the summary's place of capture;
  - Oak's show on the radio.
- [ ] **Step 3:** Contact sheets, German and English side by side, compared by position. Expected: each name whole on one-line screens; on the Pokégear, Kristall's breaks; nothing past its box. Kristall's Pokégear map card if a new Kristall game reaches it, else named as not reached.
- [ ] **Step 4:** Ledger the screens seen and not reached. A fix gets its own failing check first.

### Task 6: Validate and open the PR

- [ ] The checkers (names, order, width, mode), the fixtures (28/28), `make vc` and `make tidy && make faithful vc` with baseline warnings only.
- [ ] `python3 -I utils/check_names.py --text maps data engine home | wc -l` for the PR body.
- [ ] Final whole-branch review; the fix pass.
- [ ] Ask the user, then push and open the PR. The body holds:
  - summary and evidence, with screens seen and not reached;
  - the break-mark engine change;
  - the `--text` count;
  - rulings and merge danger.
