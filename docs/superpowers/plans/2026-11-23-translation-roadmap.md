# Translation Roadmap Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Translate Polished Crystal into German, chunk by chunk, with every inherited line taken from Kristall by a tool.

**Architecture:** German replaces the English in place (CLAUDE.md). Four groundwork tasks come first (test setup, 4 MB ROM, font, Kristall tool and checks), then the name chunks, one Kristall pass over the whole game, and the remaining text by kind. Each chunk is one branch and one squash-merged PR.

**Tech Stack:** RGBDS 1.0.4, Python 3 (`python3 -I`), Azahar with the Base CIA, poke-cia's MBC30 patch, `gh`.

**Spec:** `docs/superpowers/specs/2026-11-23-translation-roadmap-design.md`

## Global Constraints

- Textbox 18 × 2 tiles, ▼ on the border; names at their limits: Pokémon and generic names 10, player 7, moves, items and trainer classes 12 (`constants/text_constants.asm`).
- Casing as in Upstream's English, with the `#mon` token. A Kristall line keeps its words and breaks; only the case of its capitalised words changes.
- ß as Kristall writes it, its lines verbatim (`erfaßt` stays); new text in the new spelling.
- Names: modern where Upstream's English is modern, Kristall's where Upstream kept the Gen 2 name; a modern name over its limit takes Kristall's name, else it is flagged and asked with suggested abbreviations.
- From chunk K on, every text that is still pret's English word for word comes in through the Kristall tool, never typed.
- Both ROMs: `make tidy && make vc` and `make tidy && make faithful vc`, each with only the baseline warnings (CLAUDE.md, **Build**). `-Wunmapped-char` is an error.
- Huffman tables regenerated after every text change (`utils/huffman.py` docstring).
- Debug-only text stays English and out of both ROMs.
- A short script jump that `-Wtruncation` flags becomes its long form in the same PR, listed in the PR body.
- Open terms are asked in dialogs, each with its context (situation, lines before and after) and the three columns.

## Review Focus

1. One English text that pret uses in two places with different Kristall wordings: the tool flags it for a question instead of picking one. Test in Task G4.
2. Capitalised words that aren't names, or names split across a break (`des NACHTs`, `ARENA-` / `LEITER`): re-cased as German writes them (`des Nachts`, `Arena-` / `leiter`). Test in Task G4.
3. A name swap that lengthens a Kristall line past 18 tiles (`ZINNTURM` → `Glockenturm`): the tool re-breaks that paragraph, and the width check passes. Test in Task G4.
4. A Faithful twin left in English while its Regular line is German: the English-left check reads both branches. Test in Task G4.
5. Texts missing from the dump (Oak at Mr. Pokémon's house, 65:78xx; the Route 31 letter scene, 69:5abc): the tool pairs them through the scripts' pointers. Test in Task G4.

## Every chunk

**Start:** branch from the current `master`, list the chunk's exact files and labels, and ask its open terms together in dialogs.

**Ship** (the last step of every task below):

- [ ] Build both ROMs without new warnings; regenerate the Huffman tables; run every check script clean.
- [ ] Play the chunk's screens once in the Regular ROM (Faithful lines in the Faithful ROM), compare each with Kristall by position, save the screenshots.
- [ ] Push the branch and open the PR on the fork: what changed, own translations (flagged), screens seen and screens not reached.
- [ ] Review the PR's diff against the chunk's list and CLAUDE.md; fix what the review finds.
- [ ] Squash-merge with one summarising sentence, as CLAUDE.md's **Git** says; check that `master` got that one line; next chunk.

---

## Groundwork

### Task G1: Test setup

- [x] Bring back the first attempt's `vc/` scripts (`build_cia.sh`, `gen_ctm.py`, `playtest.py`, `README.md`) from `archive/first-attempt`; they work with `vc/local/`.
- [x] Choose how screens are read: Azahar alone (screenshots), or a scriptable emulator that reads `wTilemap` as well, if one runs the 4 MB ROM. Propose it and ask. (Chosen 2026-11-23: both; PyBoy through `utils/pyboy_play.py` for every screen, Azahar for the VC.)
- [x] Fill in the profile's **Emulator**, **Test entry points** and **Virtual Console** rows.
- [x] Test: Upstream's ROM, packaged as a CIA, boots in Azahar to the player's room; Kristall reaches the same room.
- [x] Ship.

### Task G2: 4 MB ROM

- [x] Bring back the first attempt's 4 MB build (`layout.link` pins `"Title"` to `ROMX $FF`, `tools/bankends.c` counts 256 banks, the bank-bit-7 fixes in map setup and the script stack) and the ADR `docs/adr/0001-4mb-rom-for-virtual-console.md`.
- [x] Update the profile's **ROM space** row.
- [x] Test: header byte `$148` is `$07`; the `.sym` puts `_TitleScreen` in bank `$FF`; the MBC30-patched CIA boots to the player's room, and an unpatched one stops at the title screen. (2026-11-23: it crashes there with "Error: 001", `rst 38h`.)
- [x] Ship.

### Task G3: Font

- [x] Ä ä Ö ö Ü ü ß in the 8 selectable fonts (Unown included) and in `vwf.png` with their widths; `utils/grayscale.py` after each edit.
- [x] Charmap slots: the umlauts as the first attempt placed them, ß in a slot to propose (the first attempt found only `<KE>`, `$d1`). Ask before committing to the slots. (Chosen 2026-11-23: umlauts in the Spanish slots, ß in `'d`.)
- [x] Naming screen: umlauts and ß on the keyboards (`data/text/input_chars.asm`), layout proposed first. (Chosen: as Kristall, no ß key.)
- [x] Propose whether the Huffman vowel set takes Ä Ö Ü ä ö ü (three places, ROM0 cost). (Chosen: no.)
- [x] Update the profile's **Charmap and font** row; the first entries go into a new `GLOSSARY.md`.
- [x] Test: every new glyph in each font on the naming screen and in a text box, and in the variable-width font in Bill's PC.
- [x] Ship.

### Task G4: Kristall tool and checks

Its internals get a short design of their own before coding. Fixed here:

- [x] `utils/kristall_pairs.py`: from `~/Development/pokecrystal`'s `pokecrystal.gbc` and `.sym` and Kristall's ROM, follow the same script and text pointers in both ROMs and write `.claude/upload/kristall_pairs.json` (pret label, English, Kristall text with its commands, Kristall address). Nintendo text stays in `.claude/upload/`, never committed.
- [x] `utils/kristall_write.py`: for each Polished text whose English equals a pret text (ignoring case and line breaks), write Kristall's text, re-cased and with names swapped as **Project decisions** say; re-break a paragraph only when a swap overflows a line.
- [x] `utils/check_kristall.py`: re-derives every inherited text and fails on any difference.
- [x] The first attempt's `check_text_width.py`, `check_text_mode.py`, `check_names.py`, `check_order.py`, adapted to this `master`, plus an English-left check over both ROMs' text, skipping only `DEBUG` blocks.
- [x] Tests in `utils/tests/test_kristall.py`, one per **Review Focus** line: `test_ambiguous_english_is_flagged`, `test_recase_non_names_and_split_words`, `test_name_swap_rebreaks_paragraph`, `test_faithful_twin_left_english_is_reported`, `test_dump_gaps_are_paired` (Oak 65:78xx, Route 31 69:5abc). Run: `python3 -I -m pytest utils/tests -q`, all pass.
- [x] `utils/dex_sources.py` (asked for 2026-11-23): the game each Pokédex entry not from Crystal comes from, through PokeAPI, and that game's German.
- [x] Update the profile's **Check scripts** row.
- Result (2026-11-23): 6,017 pret texts paired with Kristall's (map 3,464, engine 671, section 653, phone 536, dex 251, move descriptions 251, item descriptions 191; a text counts under the walk that reached it first). Left unpaired: 75 texts of mobile features Polished removed, 20 unused, 46 engine texts reached only through code Kristall moved (taken from the dump in their chunks), and the radio's `_OPT_IntroText1` with its stub, which Kristall splits in two (`KRISTALL_SPLITS`). Polished's 9,362 texts: 4,633 word for word, 33 ambiguous, 959 changed, 3,737 new. The writer's dry run: 2,059 texts ready; flags: 2,509 capitals for `kristall_case.tsv` (K), 33 ambiguous, 7 partly Faithful, 4 with ";" (no glyph), 2 with a Kristall variable Polished lacks, 1 where Polished added a pause, 1 with code inside. Pokédex entries: 247 Crystal's, 1 Crystal's edited, 20 from PokeAPI's German (6 edited), 29 from PokéWiki (18 edited), 39 regional forms, 1 without a source (Dudunsparce).
- [ ] Ship (no in-game pass: the tool writes nothing yet).

## Names

### Task 1: Pokémon names, types, abilities, natures

- [x] All 251 Gen 2 Pokémon names (Kristall's table, re-cased).
- [x] All other Pokémon names (Polished's later-generation ones, PokeAPI); `Egg`, `Bad Egg`.
- [x] The A–Z Pokédex order, re-sorted for the German names.
- [x] The 18 types, the type label and type chart graphics, the egg groups (Faithful's too).
- [x] All ability names, all natures.
- [x] Test: every name in the Pokédex list, summary, party and a battle; types, abilities and natures on the summary and in the Pokédex.
- Decided 2026-11-23: Drache (not Kristall's Drachen); the four abilities renamed with Gen 9 keep their older names (Tempomacher, Fußangel, Aufheber, Hagelalarm); Regular's water egg groups Amphibie, Fisch, Wirbellos; the first attempt's type graphics (GLOSSARY.md).
- [ ] Ship.

### Task 2: Moves, TMs and HMs

- [x] All move names (Kristall's, modern names as decided).
- [x] TM and HM item names, the TM pocket's A–Z order (`data/moves/tmhm_order.asm`).
- [x] Test: moves on the summary and in the battle menu, the whole TM pocket.
- Decided 2026-11-23: Konfusstrahl, Staffette, Giftblick, Schnabel, Wandler, Gesichte; Wertewechsel for Skill Swap; own translations Frischsnack, Furienhieb, Heillicht; HM as VM, as in Kristall (GLOSSARY.md).
- [ ] Ship.

### Task 3: Items

- [x] All item names, key items, Apricorns, wings, candies; the Faithful names (Honey, RageCandyBar, Guard Spec.).
- [x] Pocket names; the Bag's A–Z order (`constants/item_constants.asm`, `data/items/name_order.asm`). The TM pocket's tab reads TM/HM: check Kristall's pocket name, since its HMs are VMs.
- [x] Test: every pocket (the debug radio fills the Bag), a Mart, both ROMs.
- Decided 2026-11-24: the item, abbreviation, own-name and pocket choices in GLOSSARY.md (Items); the Bag's tab strip and the labels under the Bag redrawn in German without a code change.
- [ ] Ship.

### Task 4: Trainers

- [x] All trainer classes and trainer names; Battle Tower classes and names; Wonder Trade names; in-game trade nicknames and partners; default player and rival names.
- [x] Test: a battle intro of each class, the phone list, a Battle Tower opponent, a Wonder Trade.
- Decided 2026-11-24 on a review page: classes, names, nicknames, trades and Wonder Trade names in GLOSSARY.md (Trainers); Psychic Inver is Estefan, with his party picker counting the longer name.
- [ ] Ship.

### Task 5: Places and badges

- [x] All place names with their break marks; all 16 badge names.
- [x] Test: map signs, the Pokégear and Town Map, Fly, the summary's met place, a badge text.
- [x] Ship.

Decided 2026-11-24 on a review page and in dialogs: Kristall's soft hyphen and silent break come back as `<SHY>` and `<WBR>` (the first attempt's code); the badge table holds whole names and its receiving text moved here from Task 6; GLOSSARY.md's **Places** section has the names.

## Kristall pass

### Task K: Every inherited text

- [x] Run `utils/kristall_write.py` over the whole game: dialogue, phone calls, receiving texts, Pokédex entries, move and item descriptions.
- [x] Answer every flagged case in dialogs (ambiguous English, a name with no Kristall form).
- [x] Test: `utils/check_kristall.py` passes on every text; in the game one screen of each kind (map dialogue in every region, a phone call, a Pokédex entry, a move and an item description), compared with Kristall by position.
- [x] Ship.

## The rest, by kind

From here each task holds only what K left: Polished's changed lines, starting from Kristall's line, and its new ones.

### Task 6: Receiving and shared texts

- [x] `data/text/common.asm` and `data/text/std_text.asm`: items, key items, TMs, Pokémon, eggs, badges; PC, Pokémon Center, Mart, day care, field moves, item balls, fruit trees.
- [x] Test: each kind of receiving text, each service, each field move.
- [x] Ship.

Decided 2026-11-25 on a review page and in dialogs: several items read "3x Trank" (GLOSSARY.md, **Receiving and shared texts**); menus, battle lines, weekdays and the SNES lines stay with Tasks 8, 7, 11 and 19.

### Task 7: Battle

- [x] `data/text/battle.asm`, the battle menus, the ability pop-ups.
- [x] Test: a wild and a trainer battle with status, weather, abilities, a catch, a run, an evolution.
- [x] Ship.

Decided 2026-11-25 on a review page and in dialogs: stat names in full with 's, the stat messages scroll by themselves like Kristall's (`ScrollBattleText`), plain P and AP in the move box, pairs of trainers in the plural (GLOSSARY.md, **Battle**). Battle Tower, Battle Factory and link record texts are done here too. Left for Task 8: the level-up box, `stat_strings.asm`, the party list's status words, Yes/No, Cancel, the forget-move list, "Waiting…!" in link battles.

### Task 8: Menus and screens

- [x] Start menu, party, summary, Bag menus, boxes, trainer card, options, naming screen, save, the main menu and the title screen's prompts, move reminder and deleter, intro, Hall of Fame.
- [x] Test: every screen and every menu state (the link trade menus only by position in the code).
- [ ] Ship.

### Task 9: Descriptions

- [x] The move and item descriptions K left; all ability descriptions.
- [x] Test: each in the Bag, the summary and the move screens.
- [x] Ship.

### Task 10: Pokédex

- [x] The entries K left, the categories, the Pokédex screens (search, area page, variable-width labels). The hidden ability's letter is V there too (`engine/pokedex/lcd.asm`); the number sign's tile (`№`) becomes Nr in every font, Kristall's own tile in the normal one (decided 2026-11-25; summary, egg page, trainer card, Hall of Fame, trade animation, Pokédex, judge machine, Valencia Island).
- [x] The entries not from Crystal: the German of the game each comes from (`utils/dex_sources.py`; **Project decisions**), PokéWiki where PokeAPI has none.
- [x] Test: entries of every kind of Pokémon (Gen 2, later, forms), every Pokédex screen.
- [ ] Ship.

### Task 11: Pokégear

- [x] The phone list and calls K left, the radio shows, the map card, the clock.
- [x] Test: calls in and out, every radio station, the map card, the clock.
- [ ] Ship.

### Task 12: Trainer battle lines

- [x] Every trainer's seen, beaten and after-battle lines K left, in all maps.
- [x] Test: one trainer of each class, every Gym Leader and the Elite Four.
- [ ] Ship.

### Task 13: Signs

- [ ] Every sign K left, in all maps.
- [ ] Test: town, route and building signs in each region.
- [ ] Ship.

### Tasks 14–19: Regions

The people and story scenes K left, in story order. Each task: the region's maps, then a test pass through its scenes, then Ship.

- [ ] 14 Johto I: New Bark Town to Azalea Town and Ilex Forest.
- [ ] 15 Johto II: Goldenrod City to Ecruteak City, the Radio Tower.
- [ ] 16 Johto III: Olivine, Cianwood, Mahogany, Lake of Rage, Blackthorn.
- [ ] 17 League, S.S. Aqua, Silver Cave.
- [ ] 18 Kanto north and east: Cerulean, Vermilion, Lavender, Saffron, Celadon.
- [ ] 19 Kanto west and south: Pallet Town to Pewter City, Fuchsia, Seafoam, Cinnabar.

### Task 20: Polished's own areas

- [ ] Celadon University, the Orange Islands (Shamouti Island and its beaches, Valencia Island), Sinjoh Ruins, Mystri Stage, Faraway Island, Navel Rock: all own translation, in Kristall's style.
- [ ] Pilar's Spanish accents (decided 2026-11-23): once no English contraction is left in either ROM, move `á í ó ¿ ¡` (and `É`, if still wanted) into the freed slots `'l 'm 'r 's 't 'v` (`$C2`–`$C7`), redraw them in every font and `vwf.png`, and restore Sightseer Pilar's lines in `maps/ShamoutiCoast.asm` ("¡Hola!", "acá", "montón", "duraría", "más", "¿Qué").
- [ ] Test: a pass through each area's scenes.
- [ ] Ship.

### Task 21: Title screen and credits

- [ ] The title logo's subtitle "Polished Crystal" (`gfx/title/logo.png`): German wording proposed and asked (Kristall's logo says "Kristall-Edition"), drawn in the logo's style.
- [ ] The credits (`data/credits_strings.asm`), what K left: the role lines as in Kristall's credits, the "#mon Crystal Version Staff" heading, and the US version staff block (keep it, or Kristall's German staff block in its place: ask).
- [ ] The music player (main menu and the GBC Player item): its labels and about 195 song titles (`audio/music_player.asm`, `data/music_player/`). Decided 2026-11-25: here, with the credits.
- [ ] The "The End" graphic (`gfx/credits/theend.png`) as Kristall's "Ende".
- [ ] Test: the title screen in both ROMs; the credits through to the end, compared with Kristall's by position.
- [ ] Ship.
