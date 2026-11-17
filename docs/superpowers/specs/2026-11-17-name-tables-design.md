# Name tables: design

## Intent

Almost every later text names a Pokémon, move, item, place or trainer. The name tables are translated before the dialogue, so each dialogue PR finds its names already settled and only has to use them. The spec `2026-11-15-german-translation-design.md` suggested this order ("Suggested next areas").

The tables hold about 1,800 strings, too many for one PR. The user split them into four PRs (2026-11-17), in this order:

1. Pokémon, types, egg groups, abilities and natures.
2. Moves and items.
3. Places.
4. Trainer classes and trainer names.

Each part gets its own design conversation when its turn comes. This document designs part 1 in full, and the name checker that all four parts share.

## Size (measured 2026-11-17)

Against PokeAPI's German names (its CSV data on GitHub) and the Kristall dump.

| List | Entries | Official German | Over the Name limit | Own names needed |
|---|---|---|---|---|
| Pokémon, A–Z Pokédex order | 289 | all | 0 | 0 |
| Types, egg groups | 18 + 10 own strings | all but 3 | 0 | 3 |
| Abilities | 159 | all | 0 | 0 |
| Natures | 25 | all | 0 | 0 |
| Moves | 255 | 252 | 3 | 3 |
| Items, key items, small item lists | about 320 | about 300 | about 20 | about 10 |
| Places | 144 | about 100 from Kristall | (line breaks) | about 45 |
| Trainer classes | 91 | about 40 from Kristall | ? | about 50, mostly official in later games |
| Trainer names | 965 (718 unique) | about 430 from Kristall | | about 440, plus 134 Battle Tower and 512 Wonder Trade names |

## Goals, non-goals, anti-goals

- **Goals (part 1)**
  - Every Pokémon, type, egg group, ability and nature name is German, including the egg's name and the Bad Egg's.
  - The type labels drawn as graphics are German too, so a type reads the same on every screen.
  - The A–Z Pokédex list is in German alphabetical order.
  - A name checker exists and covers part 1's tables. Parts 2–4 add theirs.
- **Non-goals (part 1).** Each of these waits for its own area:
  - Descriptions of moves, abilities and items.
  - The Pokédex's entries, categories (including the two `"Egg@"` categories in `data/pokemon/dex_entries.asm`), labels, body colours and shapes.
  - The summary page's "Egg" label (`engine/pokemon/summary/egg_page.asm`) and the trade screen's (`engine/movie/trade_animation.asm`).
  - Battle texts, the stat names in `data/battle/stat_names.asm`, and the ability pop-up's appended `'s` (`GetAbilityNameAndPkmn`, `engine/battle/ability_gfx.asm`). Until the battle area, the pop-up reads "Glurak's".
  - Dialogue that names a Pokémon. It stays English until its area; the checker lists those mentions.
  - Trade nicknames, trainer names and Wonder Trade names (part 4).
  - The Type Chart key item, which draws the type names again in `gfx/type_chart/bg.png`. It goes with the key items in part 2.
- **Anti-goals**
  - A name silently cut to fit.
  - One thing with two names, such as an egg called "Ei" in the party but "Egg" after a gift or a Wonder Trade.
  - An Upstream merge that adds or changes a name without the checker noticing.
  - A checker so noisy that a real leftover drowns in its output.

## Constraints

- **Name limits** (`constants/text_constants.asm`; the `*_LENGTH` values include the terminator):
  - Pokémon names: 10 characters. `data/pokemon/names.asm` pads each to 10 with `@` (`table_width MON_NAME_LENGTH - 1`), so the build checks the width.
  - Types and egg groups have no constant. Their longest English entries (8 and 12 characters) set the room the screens were laid out for. No German type is longer than 7 characters.
  - Type labels: most screens show a type as a picture, not as text. `gfx/battle/types.png` (`TypeIconGFX`) holds 19 labels of 32 × 8 pixels, white capitals on black, in English cut to 6 letters ("ELECTR", "PSYCHC"). The summary (`engine/pokemon/summary_screen.asm:152`), the Pokédex stats page (`engine/pokedex/pokedex.asm:3349`), the battle move info (`engine/battle/core.asm:5581`) and the party's move menu (`engine/pokemon/mon_menu.asm:1649`) use them. The text table `TypeNames` shows only in the Pokédex search, the Hidden Power guru, Conversion and the Battle Tower.
  - Abilities print from column 1 on the summary and the Pokédex, and in the variable-width font in the battle pop-up, whose text area is 80 pixels (`SLIDEOUT_TEXT_WIDTH`). The widest German ability, "Mega-Solarladung", measures 75 pixels in `gfx/font/vwf.vwf.widths`; the widest English one measures 72.
  - Natures: at most 7 characters in German, the same as English.
- **ss** replaces ß (ADR 0003): "Mässig", "Kloakensosse", "Grossbrand", "Fussangel", "Hasenfuss".
- **Character set.** No German name in part 1 needs a character outside the charmap.
- **Bad Egg data.** `data/pc/bad_egg.asm` writes the nickname as run-length bytes: the name's letters, then `"@"` up to 11 bytes (`MON_NAME_LENGTH`), then the OT name. A German name of N characters takes `"@", 11 - N`.
- **Release check.** `engine/pc/bills_pc_ui.asm:2725` tells a Bad Egg from an Egg by the nickname's first letter (`cp 'B'`). The German Bad Egg's first letter must differ from "Ei"'s "E", and this byte changes to it.

## Approaches: where the checker gets English → German pairs

1. **The `.asm` tables (chosen by the user).** Each name lives only in its table. The checker reads Upstream's English table from the last merged Upstream commit and pairs it with the German table by position. Upstream merges conflict only in the `.asm`, as with every other translated line. Cost: the checker needs git and the `upstream` remote. A short list kept by hand covers text spellings that differ from the table.
2. **A names file, as in Crystal Legacy** (`tools/german_names.py`). It is familiar and works without git history. But every name is stored twice, and the drift guard only diffs `.asm` files, so it wouldn't notice the file falling behind Upstream.
3. **Tables generated from a names file.** Dropped: it needs extra tooling, and Upstream merges would conflict in generated files.

## Decisions

### Branch and PR

Branch `pokemon-names`, PR "Translate the Pokémon, type and ability names" on the fork, squash-merged.

The PR's first docs commit adds the pointer the user approved on 2026-11-17 to CLAUDE.md's profile row "Test entry points": "The PC (room and Pokémon Center) and the title-screen prompts: `vc/README.md`, 'Reach the PC'".

### Sources, per list

Source priority as in CLAUDE.md. For these lists it comes down to:

| List | File | Source | Notes |
|---|---|---|---|
| Pokémon | `data/pokemon/names.asm` | PokeAPI `pokemon-species` (de); PokéWiki where PokeAPI is missing or looks wrong | Kristall's 251 names equal the modern ones, apart from capitals (checked 2026-11-17). Upstream's "Dudunsparc" is cut to fit; the German "Dummimisel" fits in full. `?000?` and `?256?` stay |
| Egg | `data/pokemon/names.asm`, `String_Egg` (`engine/pokemon/move_mon.asm`), `.EggName` (`engine/events/odd_egg.asm`), `.EggString` (`engine/events/wonder_trade.asm`), `.String_EGG` (`engine/events/daycare.asm`) | Kristall: "EI", re-cased to "Ei" | `.EggString` keeps its 11-byte padding |
| Bad Egg | `data/pc/bad_egg.asm` | Own: the official "Schlechtes Ei" has 13 characters, 3 over the limit | The plan asks the user for the short form. The release check's letter follows it (the PR's one code change, approved 2026-11-17) |
| A–Z order | `data/pokemon/dex_order_alpha.asm` | Sorted by German name | Kristall's own A–Z list (ROM 10:4c5e) is a plain alphabetical sort of its names. No German name in Polished's list contains an umlaut |
| Types | `data/types/names.asm` | PokeAPI `type` (de) | Modern names (ADR 0002): "Drache", not Kristall's "Drachen"; "Fee". `???` stays |
| Type labels | `gfx/battle/types.png` | Crystal Legacy's German labels, `~/Development/Pokemon_Crystal_Legacy/gfx/pokedex/types_light.png` (also 32 × 8 each) | The user's choice (2026-11-17). Redrawn in Polished's style (white on black) with Legacy's letters: full names in capitals, the 7-letter GESTEIN, PFLANZE, ELEKTRO and UNLICHT squeezed in as in Legacy, KÄFER with Legacy's Ä, and DRACHE in place of Legacy's DRACHEN. The `???` label stays. The PNG is 2-bit grayscale and builds to 1bpp (`types.1bpp`), so it keeps its two shades; run `python3 utils/grayscale.py` after editing it, as for the fonts |
| Egg groups | `data/types/names.asm` | PokéWiki: Monster, Feld, Humanotyp, Mineral, Amorph, Ditto, Unbekannt; Faithful's Water 1–3 as "Wasser 1–3" | Bug, Flying, Fairy, Grass and Dragon reuse the type strings. Polished's Amphibian, Fish and Invertebrate (non-Faithful) get own names, which the plan asks the user for |
| Abilities | `data/abilities/names.asm` | PokeAPI `ability` (de); PokéWiki where in doubt | `---` stays |
| Natures | `data/natures.asm` | PokeAPI `nature` (de) | `---` stays. Only the names change; the indicator arrows don't |

`TERMS.md` gets one row per list naming its source, as Crystal Legacy's glossary did for its tables, plus one row for each own name and each exception: Ei, the Bad Egg, Drache over Drachen, and the three egg groups.

### Name checker

- `utils/check_names.py`, run as `python3 -I utils/check_names.py`, next to the other check scripts.
- **Pairs.** For each table it knows, the checker reads the English entries with `git show $(git merge-base HEAD upstream/master):<file>` and the German entries from the working tree, then pairs them by position. `HEAD`, not `master` (my call): on an Upstream merge branch, `master` still holds the old English, so a species Upstream just added could never pass. With `HEAD`, the new species shows up as English, and the merge PR translates it. If the two sides still have different numbers of entries, that is an error.
- **Table checks** (the default run, exit status 1 on any problem):
  - Each German entry fits its limit, counted in tiles as the width checker counts them.
  - An entry still equal to its English is reported, unless it's on an allowlist of names that are the same in both languages (Abra, Pikachu, Normal, Monster, …).
- **Text check** (`--text`, optionally limited to paths): lists English names left in text strings under `maps data engine home`. It matches whole words and skips names that are the same in both languages. In part 1 it knows the Pokémon names; parts 2–4 add moves, items, places and people. While the dialogue is still English it reports many hits. That is expected: later dialogue PRs run it on their own area's files.
- CLAUDE.md's profile row "Check scripts" names the checker and what it reports, in place of "A name checker … comes with the name-table PR".

### Testing

Screens to see in Azahar, against Polished's English screens (Polished rebuilt these screens, so Kristall matches them only in part):
- the Pokédex list, in number order and A–Z order
- a species' stats page (type labels, abilities) and bio page (egg groups)
- the party and summary (nature, ability, type labels)
- a wild battle (a German species name, the ability pop-up, a move's type label in the move info)
- an egg in the party, named "Ei"

Test clones, never committed, reach these screens the way "Reach the PC" does. The Bad Egg appears only after a box checksum error; if no test clone can reach it, the PR says so.

## Left to the builder

- The checker's command-line flags and code layout, and whether it reuses the width checker's tile counting.
- How each test clone reaches its screen, and the movie taps.
- How to cache PokeAPI's data (its CSV files on GitHub worked on 2026-11-17; the GraphQL endpoint answered 401).
- Task order within the PR.
