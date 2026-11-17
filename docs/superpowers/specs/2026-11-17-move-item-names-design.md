# Move and item names: design

Part 2 of the four name-table PRs. Part 1 (Pokémon, types, egg groups, abilities, natures) and the shared name checker are designed in `2026-11-17-name-tables-design.md`. This document designs part 2 only. The user approved its shape on 2026-11-17, and after the builder check added the Bag's pocket tabs, the HM → VM change and the umlaut sort rule.

## Intent

Marts, battles, TMs, the Bag and most dialogue name moves and items. Translating the name tables first means every later dialogue PR finds these names settled and only has to use them, as part 1 did for Pokémon.

## Size (measured 2026-11-17)

Against PokeAPI's German names (its CSV files on GitHub, looked up by the full English name where Polished shortens it, e.g. "BlundrPolicy" → Blunder Policy), Kristall's item and move lists (dump `[names]`, 72:4000 and 72:5e9d, paired with English through Crystal Legacy's history) and the 12-character Name limit.

| Table | File | Entries | Official German found | Over 12 | Kristall or own |
|---|---|---|---|---|---|
| Moves | `data/moves/names.asm` | 256 (incl. Faithful's Rock Smash) | 253 | 3 | 3 own |
| Items | `data/items/names.asm` | 258 (incl. 3 Faithful variants) | 239 | 22 | 12 Kristall, about 7 own |
| Key items | `data/items/key_names.asm` | 39 (incl. "Cancel") | 31 | 2 | GS Ball (Kristall), "Cancel" (TERMS.md), about 6 own |
| Apricorns | `data/items/apricorn_names.asm` | 7 | 7 | 6 | Kristall's short forms |
| Exp. Candy | `data/items/exp_candy_names.asm` | 5 | 5 | 0 | |
| Pokégear cards | `data/items/special_names.asm` | 5 | 0 | 0 | Kristall, PokéWiki |
| Wings | `data/items/wing_names.asm` | 6 | 6 | 0 | |
| Pocket names | `data/items/pocket_names.asm` | 6 | | | 4 Kristall, 2 own |
| Bag pocket tabs | `gfx/pack/pack_top.png` | 6 labels | | | asked as one set |

- **Kristall** names the Gen 2-only items: the 10 Mails ("Blumenbrief" …), Brick Piece ("Ziegelstein"), Berserk Gene ("Berserk-Gen") and the GS Ball.
- **Own names** are needed for Polished's own moves and items: Fresh Snack, Fury Strikes, Healing Light, Cake of Rage, Sweet Honey, Guard Stats, Mulch, Mint Leaf, Odd Souvenir, Armor Suit, the Harsh, Potent and Malign Lures, Type Chart, Wing Case and OrangeTicket. The plan checks each on PokéWiki before calling it own.

## Goals, non-goals, anti-goals

- **Goals**
  - Every move, item, key item, apricorn, Exp. Candy, Pokégear card, wing and pocket name is German, in normal and Faithful builds.
  - HMs are "VM", as in Kristall: in item names ("VM01") and in the bold glyph that marks HMs and hidden abilities.
  - The Bag's pocket tabs are German.
  - The Bag's "sort by name" and the TM pocket's A–Z order follow the German names.
  - The Type Chart key item shows German type names.
  - The name checker covers these tables, and its three deferred fixes from part 1 are in.
- **Non-goals.** Each waits for its own area:
  - Move and item descriptions (`data/moves/descriptions.asm`, `data/items/descriptions.asm`).
  - Dialogue that names a move or item, including the marts' and battles' texts, and texts that say "HM". The checker's `--text` lists the move and item mentions.
  - The Bag's menus (Use, Give, Toss …).
  - The plural table (`data/text/plural_table.asm`, `TextCommand_PLURAL`). It applies English plural endings, so until their areas are translated, English mart and battle texts may print forms like "3 Beeres". Each such text drops `text_plural` when it is translated, as the PC texts did (TERMS.md: "_N_ x `<ITEM>`"). The table stays as it is.
  - Upstream's comment in `data/items/names.asm` ("also update PluralTable") stays: code comments stay English, and the table is out of scope.
- **Anti-goals**
  - A name silently cut to fit.
  - One thing with two names, such as an item called one thing in the Bag and another in Bill's PC, or a pocket named one way on its tab and another in a text.
  - A Gen 2 name used in place of a Modern name just because the Modern one is too long (ADR 0002: those get an Abbreviation).
  - A Type Chart or Bag tab row whose tilemap no longer matches its tiles.

## Constraints

- **Name limits** (`constants/text_constants.asm`): moves and items 12 characters (`MOVE_NAME_LENGTH`, `ITEM_NAME_LENGTH` 13 with the terminator). The tables use `li` (`macros/asserts.asm`), which writes `db "name@"` and asserts there is no `@` inside, so the build doesn't check the length; the checker does.
- **ss for ß** (ADR 0003) can push a name over: "Zen-Kopfstoß" is 12, "Zen-Kopfstoss" 13.
- **Over the limit** (measured), each following CLAUDE.md's "When text doesn't fit":
  - Moves: Fähigkeitstausch, Schlangenblick, Zen-Kopfstoss.
  - Items: Marmoria-Kräcker, X-Verteidigung, X-Genauigkeit, X-Volltreffer, Fähigkeiten-Kapsel, Fähigkeiten-Pflaster, Spitzer Schnabel, Schattenbrille, Schutzsticker, Muschelglocke, Schwerschweif, Schwächenschutz, Offensivweste, Schutzpolster, Plateauschuhe, Fehlschlagschutz, Bizarroservice, Neutralschmuck, Gezinkter Würfel, Drachenschuppe, Verbindungsschnur, Silberkronkorken.
  - Key items: Schlüsselkarte, Aufzugsschlüssel.
  - Apricorns: Aprikoko Blau, Gelb, Grün, Weiss, Schwarz, Pink. Kristall's own short forms (Aprikoko Blu, Glb, Grn, Wss, Swz, Pnk) are the official abbreviation (CLAUDE.md, step 2); red's "Aprikoko Rot" fits.
- **Variable-width font.** Bill's PC prints a held item's name in the VWF, in 10 tiles (80 px) at columns 10–19 (`engine/pc/bills_pc_ui.asm`). Polished's widest English item measures 60 px; a 12-letter German name about 62. Every item name must stay within 80 px.
- **TM pocket.** It prints the TM number and the move name 3 tiles further (`engine/items/tmhm2.asm`), laid out for 12-character move names. HMs show the `<BOLDH>` glyph and one digit.
- **HM → VM.**
  - `.HMText` in `engine/items/tmhm2.asm` (`db "HM"`) builds every HM's item name; it becomes "VM". `.TMText` stays "TM".
  - `<BOLDH>` (`$CB`, `constants/charmap.asm`) marks HMs in the TM pocket (`tmhm2.asm`) and the hidden ability in the summary (`engine/pokemon/summary/blue_page.asm`, "1 2 H") and the Pokédex stats page (`engine/pokedex/lcd.asm`, "1/2/H"). German calls both "versteckt" (Versteckte Maschine, Versteckte Fähigkeit), so the glyph is redrawn as a bold V in every font that has it. The charmap name `<BOLDH>` stays (code names stay English). After editing a font PNG, `python3 utils/grayscale.py <png>` restores its 2-bit grayscale.
- **Pocket names** have no length constant. `GetPocketName` copies one into `wStringBuffer3` for the "put … in the … Pocket" texts. English's longest is "Berry Pocket" (12). Kristall names four pockets: Item-Tasche, Basis-Items (key items), Ball-Tasche, TM-Tasche (with VM: the plan asks whether it becomes "TM/VM-Tasche" or stays). Medicine and Berry pockets are Polished's own.
- **Bag pocket tabs.** `gfx/pack/pack_top.png` (160 × 8, 2-bit), loaded through `PackInterfaceGFX` in `engine/items/pack.asm`, draws "▶Items Meds Balls TM/HM Berries Key" in one row. The active tab is drawn in a different shade, so how the tabs map to tiles and palettes must survive the redraw. German labels are short forms of the pocket names, asked as one set; they need an Ä ("Bälle") in that small font.
- **Sort orders**
  - The Bag's sort by name: the two `NAM_` constant lists in `constants/item_constants.asm` ("Alphabetical order"), one for items and one for key items, give each item its rank. `data/items/name_order.asm` maps item IDs to those ranks and doesn't change. Four `if DEF(FAITHFUL)` blocks place the Faithful and non-Faithful variants (RageCandyBar / Cake of Rage, Honey / Sweet Honey) at their own positions.
  - The TM pocket's A–Z order: `TMHMListAlpha` in `data/moves/tmhm_order.asm` (82 entries; Brick Break / Rock Smash under `FAITHFUL`).
  - **Rule (the user's choice):** German dictionary order (DIN 5007-1): case-insensitive, Ä/Ö/Ü sorted as A/O/U ("Aprikokobox, Äther, Aufwecker"; "Turboball, Überreste, Upgrade"), ties broken by the plain order. 22 item names contain umlauts. Part 1's A–Z Pokédex has none, so it is unaffected.
- **Type Chart** (`engine/items/type_chart.asm`, `gfx/type_chart/`):
  - `bg.png` (160 × 144, 2-bit) holds 16 row labels, 6 letters in 24 px (a 3-pixel font, 4 px per letter), and 14 rotated column heads of at most 5 letters (NRML, FGHT, PSN …), plus "ATK".
  - `ob.png` (sprites) holds "DEF", the Ghost and Steel column heads and the GHOST and STEEL row labels.
  - The 7-letter German types (Gestein, Pflanze, Elektro, Unlicht) don't fit a 6-letter row label; the column heads need short forms for all 18 types; ATK and DEF need German forms.
  - `bg.2bpp` is built with `--remove-duplicates --remove-xflip --remove-yflip`, but `type_chart.tilemap` and `type_chart.attrmap` are checked in. A redraw must keep the same unique tiles in the same order, or regenerate both maps so they match. Palettes (`type_chart.pal`) and label colours stay.
- **Faithful.** The Faithful variants are translated too: Rock Smash, RageCandyBar, Honey, Guard Spec.

## Approaches

The user chose the approach for all four parts in part 1: the `.asm` tables are the only place a name lives, and the checker pairs them with Upstream's English by position. For part 2 this means:

1. **Tables filled by a generator script from PokeAPI, PokéWiki and Kristall** (as part 1's `gen_tables.py`), with overrides for abbreviations and own names. Chosen: the same tools as part 1, and every name traceable to its source.
2. Hand-editing 576 names. Dropped: no record of where a name came from, and typos the checker can't see.

## Decisions

### Branch and PR

Branch `move-item-names`, PR "Translate the move and item names" on the fork, squash-merged with the bare PR title as the subject.

### Sources, per list

Source priority as in CLAUDE.md. For these lists:

| List | Source | Notes |
|---|---|---|
| Moves | PokeAPI `move` (de); PokéWiki where missing or wrong | Modern names (ADR 0002). Hi Jump Kick is "Turmkick" in Kristall and today |
| Items | PokeAPI `item` (de); PokéWiki | Modern names. Gen 2-only items (the Mails, Brick Piece, Berserk Gene) take Kristall's name, re-cased |
| Key items | PokeAPI, PokéWiki, Kristall | "Cancel" is "Zurück" (TERMS.md). Polished keeps the Gen 2 English "Itemfinder", which Kristall calls "Detektor" and modern games replaced with the Dowsing Machine ("Itemradar"): the plan asks which |
| HMs | Kristall: "VM" | The user's choice (2026-11-17), with the bold V glyph |
| Apricorns | Kristall: Aprikoko Rot, Blu, Glb, Grn, Wss, Swz, Pnk | Kristall's own short forms are the official abbreviation of the modern names |
| Exp. Candy | PokeAPI: EP-Bonbon XS … XL | TERMS.md: EP-Bonbon |
| Pokégear cards | Kristall (e.g. "Radio-Modul"), PokéWiki | The plan settles each |
| Wings | PokeAPI: Heilfeder … | Modern German names |
| Pocket names | Kristall: Item-Tasche, Basis-Items, Ball-Tasche, TM-Tasche | Medicine and Berry pockets: own names, asked |
| Bag tabs | Short forms of the pocket names | Asked as one set; the user chose to redraw them in this PR (2026-11-17) |

### Questions for the user, asked while planning

In question dialogs, as CLAUDE.md says, each with its candidates and the plan's pick:
- one Abbreviation for each name over the limit, after looking for an official one (Kristall, later games, TERMS.md);
- each own name, after PokéWiki has none;
- Itemfinder: Detektor or Itemradar;
- the Medicine and Berry pocket names, and whether Kristall's "TM-Tasche" names the VMs too;
- the Bag tab labels, as one set in one preview;
- the Type Chart's row-label short forms for the four 7-letter types, its 18 column-head short forms (one set, one preview) and its ATK/DEF labels.

`TERMS.md` gets one row per list naming its source, plus one row for each Abbreviation, each own name, VM, the sort rule and the tab labels.

### Name checker

- New tables in `utils/check_names.py`'s `TABLES`, with an `li` entry pattern: moves, items, key items, apricorns, Exp. Candy, Pokégear cards, wings (limit 12 each) and the pocket names (`.Label: db`, between `ItemPocketNames` and the file end).
- The three minors deferred from part 1's final review:
  - `--text` matches whole words with umlauts as letters, so "Seelöwe" no longer counts as "Seel".
  - Bad input (a missing `--text` path, a missing table file, no git) prints a message instead of a traceback, and the base-error hint names the `upstream` remote.
  - `SAME_IN_GERMAN` becomes one set per table, so a name that is the same in one table can't hide an untranslated entry in another.
- `TEXT_ALIASES` gets the moves' and items' English spellings that differ in text from their table (as "ThunderPunch" may appear as "Thunder Punch"), where the `--text` run finds them.

### Testing

Screens to see in Azahar, against Polished's English screens by position (Kristall's Bag and TM pocket only where a new Kristall game reaches them):
- the Bag: its tabs, an item list, the key items, the Medicine and Berry pockets, and "sort by name";
- the TM pocket, in number and A–Z order, with the bold V on an HM;
- the summary's and the Pokédex's hidden-ability marker (bold V);
- the battle FIGHT menu and the summary's move page (move names);
- Bill's PC with a held item (VWF name);
- the Type Chart key item;
- a "put … in the … Pocket" text, which shows a pocket name, and an HM's item name ("VM01").

Test clones (never committed) reach these with the debug radio, which gives every item, TM and key item, as part 1's "Reach the Pokémon screens" did. Screens that can't be reached are named in the PR.

## Left to the builder

- The order of tasks and how the generator records each name's source.
- How the Type Chart and the Bag tabs are redrawn: a script that keeps the tile layout, or regenerated maps.
- Which font PNGs carry the `$CB` glyph, and drawing its bold V in each font's style.
- How each test clone reaches its screen.
- Which `TEXT_ALIASES` entries are needed.
