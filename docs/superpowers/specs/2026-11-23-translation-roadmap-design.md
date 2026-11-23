# Translation roadmap: design

## Intent

The user restarted the Translation on 2026-11-23: `master` went back to Upstream's `c321e5284`, the first attempt is on `archive/first-attempt`. The first attempt worked area by area and copied Kristall's lines by hand. Its inherited lines were mostly right, but only through diligence: the dump skipped texts, nothing checked them afterwards, and every area PR mixed Kristall lines, Polished's changed lines, own translation, shared texts and play-tests.

This roadmap sets the chunks and their order. Two aims:

- Every text that is still pret's English word for word goes in as Kristall's text by construction: written by a tool, verified by a check, never retyped.
- Each chunk is one kind of text across the whole game, big enough to be worth one in-game test pass once it is done (CLAUDE.md, **Working agreement** and **Validation**).

## Goals, non-goals, anti-goals

- **Goals**
  - The whole game in German, in the order below, each chunk its own PR, merged as CLAUDE.md's **Git** says.
  - Both ROMs, Regular and Faithful; debug-only text stays English and out of both.
  - Kristall's lines in place wherever Upstream's English is pret's, re-cased and with names chosen as **Project decisions** say.
- **Non-goals**
  - Each chunk's own details: exact file lists, test paths and open terms are settled when the chunk starts, in its own design.
- **Anti-goals**
  - A Kristall line typed or paraphrased by hand where the tool could have written it.
  - A chunk that bundles unrelated kinds of text because they share a map.

## Approaches

Decided with the user on 2026-11-23 in question dialogs:

- **Kristall lines: one pass after the names (chosen)**, rather than inside each chunk. After the name chunks, a tool writes every inherited text in the whole game in one task. Later chunks then hold only Polished's changed and new lines, each shown with Kristall's line in the middle column. The pass needs the name tables first, because re-casing Kristall's capitals maps its names onto ours (`PROF. LIND` → `Prof. Lind`, `ZINNTURM` → `Glockenturm` where Upstream says Bell Tower).
- **Map dialogue: trainers, signs, then regions (chosen)**, rather than everything by region. Trainer battle lines and signs are each one kind of text with one voice per trainer class; people and story scenes go by region in story order.
- **Polished's own areas: one chunk at the end (chosen)**, rather than inside their regions. They have no Kristall text, so they come last, once Kristall's style is in place everywhere else.
- **ROM space: bring back the 4 MB build (chosen)**, rather than translating until 2 MB is full. Upstream's 2 MB ROM has 24,324 bytes free.

## The sequence

Sizes measured on `c321e5284`, 2026-11-23. "Kristall share" counts text that is pret's English word for word; lines Polished only touched also start from Kristall but aren't counted.

### Groundwork

| # | Task | Notes |
|---|---|---|
| G1 | Test setup | The emulator and VC packaging, first: every later task is tested with them. The first attempt's `vc/` scripts are on the archive |
| G2 | 4 MB ROM | The first attempt's build from the archive, re-tested on Upstream's current code and in Azahar |
| G3 | Font: Ä ä Ö ö Ü ü ß | In the 7 selectable fonts and `vwf.png`, umlauts on the naming screen. The first attempt's umlaut design is on the archive; ß needs a slot (the first attempt found only `<KE>`, `$d1`) |
| G4 | Kristall tool and checks | A tool pairs every pret label with Kristall's text (both ROMs, same pointers), writes inherited lines, and a check fails on any drift; the width, mode, name and English-left checks |

### Names

| # | Chunk | Size | Kristall share |
|---|---|---|---|
| 1 | Pokémon names, types, abilities, natures, egg groups | ~290 + 18 + 160 + 25 | all 251 Gen 2 names; the rest PokeAPI |
| 2 | Move names, TMs and HMs | 255 moves | Gen 2 moves |
| 3 | Item names, key items, pockets | 258 items | Gen 2 items |
| 4 | Trainer classes and names, Battle Tower, Wonder Trade, in-game trade partners | 149 classes, ~680 trainers | Gen 2 trainers |
| 5 | Places and badges | 145 places, 16 badges | Gen 2 places |

### Kristall pass

| # | Chunk | Size |
|---|---|---|
| K | Every text still pret's English word for word, game-wide: dialogue, phone calls, receiving texts, Pokédex entries, move and item descriptions | ~46% of all dialogue (~18,000 lines), 243 Pokédex entries, 105 move and 124 item descriptions |

### The rest, by kind

From here on a chunk holds only what K left: Polished's changed lines (starting from Kristall's line) and its new ones.

| # | Chunk | Size before K | Kristall share |
|---|---|---|---|
| 6 | Receiving and shared texts: items, Pokémon, badges, PC, Pokémon Center, Mart, field moves, day care | 1,780 lines | 83% / 71% |
| 7 | Battle texts and battle menus | 930 lines + menus | 38% |
| 8 | Menus and screens: start menu, party, summary, bag, boxes, trainer card, options, naming, save, main menu, title prompts | ~390 strings, 136 option lines | options are Polished's own |
| 9 | Descriptions: moves, items, abilities | 184 + 278 + 155 | 57% / 45% / 0% |
| 10 | Pokédex: entries, categories, screens | 334 entries | 73% |
| 11 | Pokégear: phone list and calls, radio, map card, clock | 4,730 phone lines + radio | 91% |
| 12 | Trainer battle lines, all maps | ~7,600 lines | — |
| 13 | Signs, all maps | ~1,000 lines | — |
| 14 | Johto I: New Bark to Azalea and Ilex Forest | 4,200 lines with trainers and signs | ~55% |
| 15 | Johto II: Goldenrod to Ecruteak, Radio Tower | 5,400 | — |
| 16 | Johto III: Olivine, Cianwood, Mahogany, Lake of Rage, Blackthorn | 5,200 | — |
| 17 | League, S.S. Aqua, Silver Cave | 1,500 | — |
| 18 | Kanto north and east: Cerulean, Vermilion, Lavender, Saffron, Celadon | 5,100 | — |
| 19 | Kanto west and south: Pallet to Pewter, Fuchsia, Seafoam, Cinnabar | 4,100 | — |
| 20 | Polished's own areas: Celadon University, the Orange Islands, Sinjoh Ruins, Mystri Stage, Faraway Island, Navel Rock | 2,400 | 0% |
| 21 | Title screen and credits: the logo's "Polished Crystal" subtitle, the credits' roles and staff blocks, the "The End" graphic | 1 logo, 30 credit roles, 1 graphic | Kristall's credits roles |

Region sizes include their trainer lines and signs, which chunks 12 and 13 take out (about a third).

## Why this order

- Names first: every later text uses them, and the Kristall pass needs them to re-case Kristall's capitals.
- The Kristall pass right after: the largest, most mechanical part, settled before any hand translation starts.
- Shared texts and menus before the maps: every scene prints them, so a map's test shows German around its dialogue.
- Pokédex and Pokégear stand on their own and are mostly Kristall.
- Maps last in story order, Polished's own areas at the very end, in Kristall's style.

## Left to each chunk

Its own design when it starts: the exact files and labels, open terms (asked in dialogs with context), how its one in-game test pass reaches the screens, and which screens it couldn't reach.
