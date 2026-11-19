# Place names: design

Part 3 of the four name-table PRs. Parts 1 and 2 (Pokémon and the other species tables; moves and items) are merged; the shared name checker is designed in `2026-11-17-name-tables-design.md`. This document designs part 3 only. The user approved its shape on 2026-11-18: Kristall's hyphen breaks on the Pokégear map, as an engine change, and Anime names for the places from the second movie.

## Intent

Signs, the Pokégear, Fly, the summary, the radio, the phone and much of the dialogue name places. Translating the place table first means every later dialogue PR finds the names settled and only has to use them, as parts 1 and 2 did for Pokémon, moves and items.

## Size (measured 2026-11-18)

`data/maps/landmarks.asm` holds 145 names (`rawchar "…@"` after a `…Name:` label; no Faithful blocks). Paired with Kristall's list (ROM bank `$72`, `$6a64`, 102 names; the text dump's `[names]` line stops after 14 of them) through Crystal Legacy's labels, which match Polished's, and with PokeAPI's German location names (`location_names.csv`, cached in the scratchpad):

| Source | Places | Notes |
|---|---|---|
| Kristall, re-cased | 99 | 98 by label, plus Underground Path (Kristall's "UNTERGRUND" under another label) |
| … where a Modern name differs | 5 of the 99 | Bell Tower: Glockenturm (Kristall: Zinnturm); Pokémon Mansion: Pokémon-Villa (PKMN-Haus); Diglett's Cave: Digda-Höhle (Digdas Höhle); Indigo Plateau: Indigo-Plateau (PokéWiki; Kristall writes no hyphen); Fast Ship: M.S. Aqua (Schnellboot). PokeAPI's "Radio-Turm" is an error: PokéWiki and Kristall write "Radioturm" |
| Later games, found | 8 | Glockenklangpfad, Route 47, Route 48, Felsklippentor, Felsschlundhöhle, Nabelfels, Ferneiland (the research found "Fern-Eiland" is FireRed/LeafGreen's Outcast Island; PokéWiki, PKHeX and PokeAPI agree on "Ferneiland"), Sinjoh-Ruinen |
| Later games, not yet looked up | 25 | Pokémon League Gate (PokeAPI's "Tor zur Pokémon Liga" is a Kalos gate, location 686, not this one), Violet Outskirts, House of Souls, Celadon University, Cinnabar Volcano, Cerulean Cape, Lucky Island, Yellow Forest, Quiet Cave, Cherrygrove Bay, Goldenrod Harbor, Magnet Tunnel, Route 32/34/35 Coast, Stormy Beach, Murky Swamp, Rugged Road, Snowtop Mountain, Scary Cave, Dim Cave, Uraga Channel, Route 49, Mystri Stage, Pokémon Lab. Each without a game name is Original content: an own name |
| The second movie's places | 12 | Shamouti Island, Beautiful Beach, Rocky Beach, Noisy Forest, Shrine Ruins, Shamouti Tunnel, Warm Beach, Shamouti Coast, Fire Island, Ice Island, Lightning Island, Valencia Island. PokéWiki has Anime names for the main ones: Shamouti, Insel des Feuers, Insel des Eises, Insel der Blitze |
| "?" | 1 | `SpecialMapName`, unchanged |

Eleven of Kristall's names break inside a word on the Pokégear map: eight with a soft hyphen (Einheitstunnel, Nationalpark, Strudelinseln, Drachenhöhle, Zinnoberinsel, Siegesstrasse, Seeschauminseln, Steineichenwald) and three after a real hyphen (Knofensa-Turm, Flegmon-Brunnen, Vertania-Wald).

## Goals, non-goals, anti-goals

- **Goals**
  - Every place name is German, from the sources above in CLAUDE.md's order, with Anime names ranked after the games and before own names.
  - Long names break on the Pokégear and Town Map as Kristall's do ("Einheits-" / "tunnel", "Flegmon-" / "Brunnen") and print whole everywhere else.
  - The name checker covers the place table and measures each name against every screen's room.
- **Non-goals.** Each waits for its own area:
  - Dialogue, signposts and radio or phone lines that mention a place. They stay English; the checker's `--text` lists them.
  - The crash screen's "Old Battle Tower" (`engine/movie/bsod.asm`): the menus PR.
  - Trainer classes and names: part 4.
- **Anti-goals**
  - A name silently cut, or a word split without a hyphen. One exception, the user's choice (2026-11-18): Cliff Cave's official "Felsschlundhöhle" fits no hyphen split of 11 tiles, so the Pokégear and Town Map break it as "Felsschlund" / "höhle"; every other screen shows it whole.
  - A soft hyphen or a stray space showing on a one-line screen ("Einheits- tunnel").
  - A place with two names, such as "Teak City" on the sign and "Teak" on the map.
  - A name that overflows a 19-byte script buffer: no visible fault until a phone call or script prints it.

## Constraints

Every place name is copied by `GetLandmarkName` (`engine/overworld/landmarks.asm`, 23 bytes into `wStringBuffer1`) and shown on these screens:

| Screen | Code | Room |
|---|---|---|
| Pokégear map card, Town Map | `_UpdateLandmarkName`, `engine/pokegear/pokegear.asm:716` | 2 lines of 11 tiles after an arrow (a 2 × 12 box at 8,0 or 0,0), the second aligned with the first as in English and Kristall (the user kept this on 2026-11-18 over starting the second line below the arrow); `¯` breaks the line |
| Fly | `TownMapBubble`, `engine/pokegear/pokegear.asm:1574` | one line, 16 tiles (2,1 up to the arrow at 18,1); only the 33 places in `data/maps/flypoints.asm`. The Pokémon League Gate prints Fly's own `.PokemonLeagueFlyName`, "Pokémon League" (line 1640), because its landmark name doesn't fit |
| Sign when entering an area | `engine/events/map_name_sign.asm` | one line, 18 tiles (`POPUP_MAP_NAME_SIZE`), centred; `¯` is a space |
| Summary, place of capture | `engine/pokemon/summary/orange_page.asm:71` | one line from column 1, 19 tiles |
| Oak's radio show | `_OPT_OakText3`, `data/text/common.asm` | the name and "." on one textbox line: 17 tiles. Only places with wild Pokémon |
| Places and People (radio), phone, scripts | `getlandmarkname` (79 uses), `_PnP_Text5`, `engine/phone/phone.asm` | one line, 18 tiles; scripts copy into `wStringBuffer3`–`5`, 19 bytes each (`STRING_BUFFER_LENGTH`) |

So each name:
- is at most 18 bytes, the break marks included, so it fits a script buffer with its `@`;
- shows at most 18 tiles on one line (17 for a place with wild Pokémon, 16 for a flypoint), counting `¯` as a space and the break marks as nothing;
- splits into at most 2 Pokégear lines of at most 11 tiles, counting the "-" a soft hyphen adds.

Kristall's spellings are reused verbatim except for the casing (Project decisions), ss for ß, and Kristall's break codes, which map to Polished's: its line-break `¯` to `¯`, its soft hyphen (`$1E`) to the new soft hyphen, its break after a hyphen (`%`) to the new silent break.

The Character set is full, but `PlaceNextChar` (`home/text.asm`) treats every byte from `$0a` up to `NGRAMS_START` (`$4d`) as the end of a string, and no character uses those bytes.

## Approaches

The user chose Kristall's hyphen breaks (2026-11-18) over two ways without an engine change: breaking only at spaces, which would force an Abbreviation of every long compound everywhere for one screen's sake, and a visible hyphen with `¯`, which shows "Einheits- tunnel" on one-line screens. For the breaks themselves:

1. **Two break marks in the free byte range, read by three routines.** Chosen: names stay whole and correctly spelled everywhere, about 15 lines of engine code.
2. A hyphen followed by `¯` read as "break, no space". Dropped: it covers Flegmon-Brunnen but not one-word compounds like Einheitstunnel.
3. The Pokégear hyphenating on its own. Dropped: German compounds can't be split by rule without marks in the data.

For the names, the approach of parts 1 and 2 stands: the table in `data/maps/landmarks.asm` holds the names (Fly's one short form aside), filled by a generator script that records each name's source, and the checker pairs it with Upstream's English by position.

## Decisions

### Branch and PR

Branch `place-names`, PR "Translate the place names" on the fork, squash-merged with the bare PR title as the subject.

### Break marks

- Two charmap entries in the `no_ngrams` charmap, at two bytes from the free range below `NGRAMS_START`:
  - `<SHY>`, the soft hyphen: "-" and a new line on the Pokégear and Town Map, nothing anywhere else.
  - `<WBR>`, the silent break: a new line on the Pokégear and Town Map, nothing anywhere else.
- `PlaceNextChar` skips both: no tile, the cursor stays. So the summary, the radio, the phone and every `text_ram` print the name whole.
- `_UpdateLandmarkName` breaks the line at `¯` as now, at `<WBR>`, and at `<SHY>` after printing "-".
- The sign's tile drawer skips both, and its length count, which centres the name, leaves them out.
- `¯` keeps its meaning: a space on one line, a break on the map.
- The marks appear only in `rawchar` strings, which aren't compressed, so the Huffman tables don't change.
- CLAUDE.md's "Character set" row names the two marks.

### Sources

Source priority as in CLAUDE.md, with one addition the user made on 2026-11-18: a place that exists in no game takes its Anime name (PokéWiki, the German dub of the anime or movies) where one exists, flagged as such, before an own name. CLAUDE.md's "Names" line gets that rule.

| Places | Source | Notes |
|---|---|---|
| Kristall's 99 | Kristall's ROM, re-cased, ss for ß, with its breaks | Kristall's own Abbreviation "Radioturm Lav." and its "Untergrund" stay unless a later game has the place |
| Bell Tower, Pokémon Mansion, Diglett's Cave, Indigo Plateau | Glockenturm, Pokémon-Villa, Digda-Höhle, Indigo-Plateau | Modern names (ADR 0002), spelling and hyphens included; Polished's English uses the same name in both eras |
| Fast Ship | asked | Polished keeps the Gen 2 English "Fast Ship" where HeartGold/SoulSilver say "S.S. Aqua", as with the Itemfinder: Kristall's "Schnellboot" or the Modern "M.S. Aqua" |
| The 9 found in later games | PokeAPI, checked on PokéWiki | PokéWiki wins where they differ, and the PR says so (Faraway Island is "Ferneiland") |
| The 25 not yet looked up | PokéWiki first; else an own name | Each own name asked |
| Fly's "Pokémon League" | the League's Official name, as PokéWiki writes it ("Pokémon-Liga") | Fits Fly's 16 tiles; agrees with the gate's name in wording and spelling |
| Fly's "Where?" (`engine/pokegear/pokegear.asm:1617`) | Kristall's Fly map, read from its ROM | The only other English on the Fly screen |
| The 12 movie places | Anime names from PokéWiki; else an own name | Each flagged; own names asked |

### Questions for the user, asked while planning

In question dialogs, as CLAUDE.md says, each with its candidates, the plan's pick and a preview of the Pokégear lines and the sign:
- Fast Ship: Schnellboot or M.S. Aqua;
- an Abbreviation for each name over its room, after looking for an official one;
- the Pokémon League Gate, once PokéWiki is checked: it is a gate (`data/maps/maps.asm:568`), so it shows no sign, but its name still has to fit 18 bytes, the summary's 19 tiles and the Pokégear's 2 × 11;
- each own name, and each Anime name that needs a break or a choice between spellings;
- where a new long name breaks, when it has no space or hyphen in its first 11 tiles.

`TERMS.md` gets one row per source group, plus one row for each Abbreviation, each own name and each Anime name.

### Name checker

- A new table in `utils/check_names.py`'s `TABLES`: `data/maps/landmarks.asm`, label and `rawchar "…@"` entries, paired with Upstream by position.
- A place measure in place of the plain length limit: at most 18 bytes; at most 18 tiles on one line, or 17 for a place with wild Pokémon; at most two Pokégear lines of at most 11 tiles, with the soft hyphen's "-".
- The flypoints' 16-tile limit, and Fly's `.PokemonLeagueFlyName` as a table of its own.
- `SAME_IN_GERMAN['places']`: the routes ("Route 29") and "?".
- `--text` knows the place names, matching the English with `¯` read as a space ("New Bark Town").

### Documentation

- CLAUDE.md: the "Character set" row (the two marks), the "Names" line (Anime names), the "Check scripts" row (the place measure), and a fix to the "Textbox" row: the Pokédex area page's variable-width string is the area type ("Morning", "Surfing"), not a place name.
- TERMS.md as above.

### Testing

Screens to see in Azahar, against Polished's English screens by position, and Kristall's Pokégear map card where a new Kristall game reaches it:
- the sign on entering a place with each break kind: a `¯` name (Neuborkia → Rosalia City), a soft hyphen (Einheitstunnel), a silent break (Flegmon-Brunnen), and the longest name;
- the Pokégear map card and the Town Map, with the cursor on the same places;
- the Fly menu on the longest flypoint name and on the Pokémon League;
- the summary's place of capture for a Pokémon caught in one of them;
- Oak's radio show naming a place.

Test clones (never committed) reach them with the debug radio (Pokégear cards, Town Map) and hooks that warp into a place. Screens that can't be reached are named in the PR.

## Left to the builder

- Which two bytes the marks take, and how `_UpdateLandmarkName` prints the soft hyphen's "-" (in the buffer or as a tile).
- Any other routine that walks a place name byte by byte; a grep for `GetLandmarkName` and `wStringBuffer1` finds them.
- How the checker learns which places have wild Pokémon (from `data/wild/`, or a list).
- The order of tasks, the generator's source record, and how each test clone reaches its screen.
