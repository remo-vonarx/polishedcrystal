# CLAUDE.md

Guardrails for translating a Pokémon ROM hack into German. They apply to every task unless the task explicitly overrides them.

Everything game-specific lives in **Project profile** and **Project decisions**. The rest of this file is the same for every hack, Game Boy or GBA, and refers to those two sections: engine, emulator and tool details belong in the profile.

## Project profile

Fill in once per hack. If a field is empty or turns out wrong, find the right value, tell me, and propose the change.

| Field | Value |
|---|---|
| Hack and repo | Polished Crystal, `Rangi42/polishedcrystal` (remote `upstream`). Work happens on the fork `remo-vonarx/polishedcrystal` (remote `origin`): each change gets its own branch and a PR there (`gh pr create --repo remo-vonarx/polishedcrystal`), merged as **Git** says, except Upstream merges (see **Upstream merges** below the table).|
| Based on | pret `pokecrystal`: Polished shares pret's early git history (initial commit 2012-03-04) and has diverged since. Its English writes pret's capitals in mixed case (`Sprout Tower` for `SPROUT TOWER`, `#mon` for `#MON`), has `<PLAYER>` where pret has `<PLAY_G>`, and re-breaks or rewords many lines, so compare a text with pret's ignoring case and line breaks. Local reference clone, read-only: `~/Development/pokecrystal` at `9ce4c4e50` (2026-11-16); `make -j8 compare` builds every English ROM with its `.sym` (labels and addresses), all matching the official SHA-1s. Crystal Legacy at `9a5b41a27` is pret's English with Legacy's edits, not pret itself |
| German original | Pokémon Kristall-Edition. ROM: `.claude/upload/Pokemon - Kristall-Edition (Germany).gbc` (SHA-1 `accb5842…`). `.claude/upload/` is excluded locally in `.git/info/exclude`. Text dump: `.claude/upload/german_text_dump.txt` (`[texts]` 5,692, `[pokemon names]` 251, `[trainers]` 541 by class and position, `[names]` 393 lists; each line starts with bank:address), made by `.claude/upload/dump_german_text.py`; verbatim, but it skips texts that start with a line break or a RAM name (`text_ram`), such as Oak's speech at Mr. Pokémon's house (65:78xx) and the Route 31 letter scene (69:5abc); read such blocks from the ROM, text command by text command. The ROM uses the new spelling (`dass`, never `daß`; `Straße`), lowercase `du`/`dein`, the lowercase possessive s (`LINDs`, `BILLs`) and names in capitals (`PROF. LIND`) |
| Previous translations to reuse | Crystal Legacy's German: `~/Development/Pokemon_Crystal_Legacy`, branch `main`, German in all its maps since its slice 34; its English before translation is at `9a5b41a27`. It follows the German original (capitals, ß). The first attempt (`archive/first-attempt`) is not a source for text |
| Textbox | 18 characters × 2 lines (`TEXTBOX_INNERW`, `constants/text_constants.asm`), fixed-width font (one tile per character). The ▼ sits on the bottom border (`LoadBlinkingCursor` in `home/text.asm`, tile 18,17), not on a text tile, so every line keeps all 18 tiles. The variable-width font (`gfx/font/vwf.png`, measured in pixels) prints in Bill's PC, the battle ability pop-ups, the Pokédex (`engine/pokedex/pokedex.asm`, `area.asm`) and the judge machine |
| Text commands | `text`, `next1` (one row down), `next`, `line`, `cont`, `para`, `done`, `prompt`, `page` (`macros/scripts/text.asm`); inline: `text_start`, `text_ram`, `text_promptbutton`, `text_asm`, `text_decimal`, `text_pause`, `text_sound`, `text_today`, `text_far`, `text_farend`, `text_plural`, `text_end`, and `stop_compressing_text` before a label that a text falls through into. Pokédex entries (`data/pokemon/dex_entries.asm`): a category `db "…@"`, then 3 lines per page (`next`), 2 pages (`page`), ending in `@` |
| Length constants | `constants/text_constants.asm`: `NAME_LENGTH` and `MON_NAME_LENGTH` 11 (10 characters + terminator), `PLAYER_NAME_LENGTH` 8 (7 + terminator), `BOX_NAME_LENGTH` 9, `MOVE_NAME_LENGTH`, `ITEM_NAME_LENGTH` and `TRAINER_CLASS_NAME_LENGTH` 13 (12 + terminator) |
| Charmap and font | `constants/charmap.asm`; fonts in `gfx/font/`: the 8 picked in the options, in this order (`FONT_MASK` of `wOptions2`): `normal`, `narrow`, `bold`, `italic`, `serif`, `chicago`, `micr`, `unown`, each 114 tiles from `$80`; plus `vwf.png`. German letters since G3: `ß` `$c1` (was `'d`, so English `'d` prints as two tiles), `Ä ä Ö ö Ü ü` `$c9 $ca $cc $cd $ce $cf` (were `É á í ó ¿ ¡`). Since Task 20, `á í ó ¿ ¡` sit at `$c2 $c3 $c4 $c6 $c7`, the old slots of the contractions `'l 'm 'r 't 'v`, with Upstream's glyphs, for Sightseer Pilar's Spanish in `maps/ShamoutiCoast.asm`; `'l 'm 't` (German `auf'm`, English lyrics) now print as two tiles. The normal font's ß is Kristall's own tile; the umlauts are the first attempt's drawings. Naming keyboards (`data/text/input_chars.asm`): Ä Ö Ü and ä ö ü in row 4, no ß key, as in Kristall. `é` `$c8`, `<BOLDH>` `$cb`, `<PO>` `<KE>` and the contraction `'s` (German `geht's`) stay. `#` (`$4d`) prints "Poké", the token `#mon` (`$4e`) "Pokémon"; `<PK>` `<MN>` are one tile each. After editing a font PNG, run `python3 utils/grayscale.py <png>` (without `-I`: it imports `utils/png.py`) |
| Text compression | Text is Huffman-coded with a paired model trained on the text (`data/text/huffman_model.inc`; `docs/text_compression.md`). Upstream's English model doesn't assemble with this charmap (it names `'l 'r 'v`), so the model is trained on the German text: after a text change, `make huffman > <scratchpad>/corpus.txt` (it builds the ROM first), then `python3 utils/huffman.py <scratchpad>/corpus.txt data/text/huffman_model.inc`. An escape token covers any character, so a stale model still builds, only larger. When an Upstream merge changes the model, keep ours and retrain. `TMPDIR=<scratchpad> sh utils/check-text.sh` decodes every linked stream and compares it with the source. Only charmap bytes `$4D`–`$5C` and `$7F`–`$EB` can be compressed (the umlauts and ß are inside; a text holding another byte is stored raw). `VOWELS` in `utils/huffman.py` is the one place that treats `AEIOUaeiou` as vowels; Ä Ö Ü ä ö ü are not vowels there (decided in G3). |
| ROM space | 4 MB MBC3 ("MBC30", `docs/adr/0001-4mb-rom-for-virtual-console.md`): `layout.link` pins the `"Title"` section to bank `$FF`, so every build is 4 MB and floating sections fill the banks below; `tools/bankends` counts 256 banks. On Upstream `56d34eab0` plus the translation, the build reports 2,149,443 bytes free (51.25%), nearly all of it in banks `$80`–`$FE`. Map setup commands and the script stack no longer keep a flag in bit 7 of a bank byte; keep flags out of bank bytes in new code too, since the linker can place any floating section above `$7F`. Virtual Console needs the MBC30 patch (`vc/build_cia.sh`); unpatched, the game crashes at the title screen ("Error: 001", `rst 38h`) |
| Build | `brew install rgbds coreutils` (RGBDS 1.0 or newer, here 1.0.4). `make` builds `polishedcrystal-<version>.gbc`; `make vc` also the `_vc.gbc` helper and the VC patch. The variants `faithful`, `debug`, `monochrome`, `noir`, `hgss` and `pocket` share object files: run `make tidy` whenever you switch, also back to plain `make vc`. A clean build prints no `-Wassert` warning and, when the tools compile, 9 clang "unknown warning option" lines; a task adds no other warning. `-Wunmapped-char` is an error: the character assembles to garbage. make 3.81 compares times to the second: to force a relink, delete both ROMs and the `.patch` |
| Debug build | `make tidy && make debug vc` builds `polishedcrystal-debug-<version>.gbc`. The radio in the player's room (`PlayersHouseRadio`, `maps/PlayersHouse2F.asm`) sets the clock and gives every Pokégear card, the Pokédex, the judge machine, all key items, TMs and HMs, useful items, decorations, money and all badges; holding A+B walks through walls (`engine/overworld/player_movement.asm`) |
| Virtual Console | The deliverable is the game as a Virtual Console title on the New Nintendo 3DS: a change counts as working once it holds there. `make vc` builds the VC patch from `vc.patch.template`, which refers to labels in the link code; those labels keep their names. Base CIA: `vc/local/dumps/kristall-vc-v0.1.0.standard.cia`, the user's Kristall VC dump, never committed (`vc/local/` is ignored by `vc/.gitignore` and `.git/info/exclude`). Stock Virtual Console reaches only 2 MB; poke-cia's MBC30 patch (in `vc/local/poke-cia`) fits this Base CIA unchanged. `vc/build_cia.sh <rom> [name]` packages a `make vc` build as a CIA with that patch; `vc/README.md` has the local setup, the Azahar runs and the install on the 3DS |
| Check scripts | All in `utils/`, run as `python3 -I utils/<script>`; tests: `<scratchpad venv>/bin/python -I -m pytest -p no:cacheprovider utils/tests -q` (needs the pret clone built and Kristall's ROM). Line checks: `check_text_width.py` (every line within its box: 18 tiles, Pokédex entries, ability descriptions and the egg's summary 19, `<PLAYER>` `<RIVAL>` `<TRENDY>` at their maximum of 7; it skips a line holding a runtime value, `text_ram`, `text_decimal`, `<USER>`, `<TARGET>`, `<ENEMY>`: check those by hand), `check_text_mode.py` (box endings and text modes), `check_names.py` (name tables within limits taken from the code; reports English only in the tables listed in its `GERMAN_TABLES`, which each name chunk extends, less its `SAME_IN_GERMAN`), `check_order.py` (the Bag's and TM pocket's A–Z orders of the tables in `GERMAN_TABLES`), `check_english_left.py PATH …` (lines still Upstream's English under the paths a chunk translated, both builds, `DEBUG` skipped). Kristall tool: `kristall_pairs.py` first (pairs pret's texts with Kristall's through both ROMs' pointers into `.claude/upload/kristall_pairs.json`, about a minute; rerun after changing it), then `kristall_index.py --stats` (Polished's texts as word for word, ambiguous, changed or new), `kristall_lookup.py <file[:line] \| label>` (a text's class and the three review columns), `kristall_write.py [--write] [PATH …]` (writes Kristall's German into word-for-word texts; a dry run without `--write`; lists what it can't do), `check_kristall.py` (fails on any inherited text that differs from what the writer derives; counts the ones still English), `dex_sources.py --cache <scratchpad>/pokeapi` (the game each Pokédex entry not from Crystal comes from, and its German, into `.claude/upload/dex_sources.json`). Answers to the writer's flags go in `utils/kristall_case.tsv` and `kristall_choices.tsv`, a text whose own German was decided on in `kristall_reviewed.tsv` (`check_kristall.py` then skips it until Upstream's English changes), English renames in `utils/english_renames.tsv` (`kristall_index.py --renames` regenerates its table rows). Known false alarm: `check_order.py` fails on key items once they're German, until the chunk re-sorts Upstream's `KeyItemNameOrder` (it lists the three Lures before `LIFT_KEY`) |
| Emulator | Both, each for its own job. **PyBoy 2.9** with Pillow, in a venv in the scratchpad, checks every screen: `utils/pyboy_play.py` (library and CLI, see its docstring) runs a Polished build or Kristall headless at about 1,500 frames per second. It hands PyBoy the save as a stream (`ram_file=`; a 32 KB SRAM image or a VC `sav.dat`) and stops with `stop(save=False)`. The clock starts at day 0, 00:00 and runs on emulated time, so the same inputs give the same frames. Above 128 banks PyBoy switches to MBC30 by itself and runs the 4 MB ROM. **Azahar** 2126.2 (`vc/local/azahar`) runs the real Virtual Console from the Base CIA and shows that a chunk holds there: the chunk's CIA boots and shows one of its screens. Input by movie, screenshots by wall-clock time, no RAM access, no save states (`vc/gen_ctm.py`, `vc/playtest.py`, `vc/README.md`) |
| Reading the screen | The tilemap `wTilemap`, 20×18 tiles: `$C440` in Polished (`ram/wram0.asm`; `pyboy_play.py` reads it from the build's `.sym`), `$C4A0` in Kristall, which keeps pret's WRAM (`wMapGroup` `$DCB5`, `wMapNumber` `$DCB6`). The two charmaps give most glyphs different tile ids: `Game.cells()` decodes each ROM with its own, and `Game.compare()` lists the positions whose glyphs differ |
| Test entry points | A new game to the player's room: `utils/pyboy_play.py <rom> --new-game` presses START through the intro and title, then A, which names the player `Aaaaaaa` (Kristall `AAAAAAA`). Polished reaches map 24:5 at about frame 5,440, Kristall 24:7 at about frame 6,680, a few seconds each. Keep a state there (`--save-state`, in the scratch clone) and load it for each case; a build that changes ROM0 needs a fresh one. The debug build's radio (above). Many texts at once, in both ROMs: the scripts in `vc/local/playtest/` (git-ignored) write into the running ROM through PyBoy, so they need no clone and no hook. `texts.py` prints any labelled text from the PC in the player's room, and `battle.py` prints any battle text at a trainer battle's menu, with either Pokémon as `<USER>`. `battle_play.py` patches the room PC's script live to start a battle (`loadwildmon`, `loadtrainer`, a Safari or contest battle), gives moves, items and status in RAM, and reads the box after each input; `battle_case1.py` to `battle_case7.py` are the battles of Task 7. `menus/` (Task 8) opens any menu or screen from the same PC: `ps5.py` runs a special or jumps to a script (`sp('JudgeMachine')`, `far('VendingMachineScript')`), `debug/` does it with every item in the debug build, `kri/` opens Kristall's screens (its specials are pret's index minus 1), `boot.py` the main menu, a new game's options and Continue. `descriptions/` (Task 9) puts every move into the party's moves, every item into the Bag and every ability into Endivie's base data, and compares each description on screen with the source. `pokedex/` (Task 10) opens every Pokédex screen and entry: `pdx.py` marks all as seen and caught and saves a state in the list, `alldex.py` redirects the entry pointer (`Pokedex_GetDexEntryPointer`) to each entry and compares both pages and the category with the source, `pdx4.py` writes rare Bio and Stats values into Endivie's base data, `newdex.py` opens the page after a catch (after `opentext`, or the capitals are sprite tiles). `pokegear/` (Task 11) opens the PokéCom from the same party state: `gear.py` gives every card and contact, writes the radio knob (steps of 2) and the map group for Kanto stations, calls a contact and runs `ElmEvolutionScript` for any first Pokémon; `kgear.py` does the same in Kristall (contact ids at `$DC7C`); `run11.py` prints every changed text. The slots and Card Flip need `reanchormap` first and hSCX/hSCY at 0. In Azahar: `vc/README.md`, **Reach the player's room** (about 100 s from an empty save; Kristall about 184 s). `vc/local/saves/` holds VC saves from the first attempt's builds (`polished-before-nbt`, `polished-nbt-town`, `kristall-elms-lab`, `empty`) and `polished-sandbox-2026-11-22`, the Polished sandbox save before this setup |

### Upstream merges

- Upstream fixes bugs within days: merge `upstream/master` regularly and keep the fork's diff limited to the translation. German replaces the English in place, so a merge conflicts wherever Upstream changed a translated line.
- Each Upstream merge gets its own PR, merged with `gh pr merge --merge`: a squash would drop the link to Upstream's history, and every later merge would conflict again on the same translated lines.
- **Drift guard.** Before merging, find the Upstream text that changed under the translation without a conflict:
  1. `git fetch upstream`, then `base=$(git merge-base master upstream/master)`: the last merged Upstream commit, `c321e5284` until the first merge.
  2. `git diff --name-only $base master`: the files this fork changed.
  3. `git diff $base upstream/master -- <those files>`: Upstream's changes to them.
  4. `git diff --name-only --diff-filter=A $base upstream/master`: files Upstream added. Those in a translated area hold new English text too.
  5. Translate every changed or new text line from steps 3 and 4 in the merge PR.

## Project decisions

Settled choices for this hack. If one of the topics below is not decided yet and a task touches it, ask before translating.

- Choices from the first attempt (`archive/first-attempt`: its `TERMS.md`, ADRs and design docs) are not settled: follow the German original and ask again when one comes up. Its code (4 MB build, umlauts, check scripts, `vc/` scripts) comes back only as a task of its own.
- Name casing: as in Upstream's English, mixed case, with the `#mon` token for "Pokémon". Lines from the German original keep their words and line breaks; only the case of the words it writes in capitals changes (`PROF. LIND` → `Prof. Lind`, `KNOFENSA-TURM` → `Knofensa-Turm`, `#MON` → `#mon`).
- ß: as the German original writes it. Its lines keep their spelling verbatim: mostly the new spelling (`dass`, `Straße`), and the few older forms such as `erfaßt` stay. A word it writes in capitals gets its ß back when re-cased (`SIEGESSTRASSE` → `Siegesstraße`). New text writes ß as the new spelling does. The font has ß since G3 (see the profile).
- Names that changed after Gen 2: the modern German name where Upstream's English uses the modern English name (Bell Tower: `Glockenturm`), the German original's name where Upstream keeps the Gen 2 one (Silver Cave: `Silberhöhle`). A modern name over its Name limit takes the German original's name instead, where the original has one. Where it has none, flag the name and ask me in a question, with your suggested abbreviations as the options, proposed as **When text doesn't fit** describes.
- ROM space: 4 MB, the first attempt's build brought back as groundwork (see the profile).
- Order of work: `docs/superpowers/specs/2026-11-23-translation-roadmap-design.md`. Every text that is still pret's English word for word goes in through the Kristall tool in one pass after the name chunks, never typed by hand.
- Both ROMs, Regular and Faithful (`make faithful`, canon stats, types and names), are translated. Faithful-only text (`if DEF(FAITHFUL)`, about 50 lines) goes with its Regular twin in the same chunk, and every chunk also builds `make tidy && make faithful vc`.
- Pokédex entries: an entry that is Crystal's English takes Kristall's German (chunk K); any other takes the German of the game its English comes from, found by `utils/dex_sources.py` (PokeAPI where it has that game's German, else PokéWiki; regional forms from PokéWiki). Where Polished edited the English (marked edited), the German is adapted the same way and shown for review. (Decided 2026-11-23.)
- Debug-only text (`if DEF(DEBUG)`) stays English; the assembler leaves it out of both ROMs, and it must stay out. Where a debug line replaces a normal one (Mom's first talk in `maps/PlayersHouse1F.asm`), test the normal line in the normal build.
- Player address: the player picks one of four pictures (`PLAYER_MALE`, `PLAYER_FEMALE`, `PLAYER_ENBY`, `PLAYER_BETA`). Keep the German original's lines as they are; propose every wording that addresses the player in Polished's own text and let me confirm it.
- Characters from later games: official German names from the game they come from (PokéWiki).
- One-off NPC names without an official source: propose a German name and flag it.
- Script jumps: when longer text pushes a short script jump (`ifequalfwd`, `iftruefwd`, `sjumpfwd`, …) past 255 bytes, the build warns `Value $1xx is not 8-bit` (`-Wtruncation`) and the jump lands in the wrong place. Switch that jump to its long form (`ifequal`, `iftrue`, `sjump`, …) in the same PR without asking, and list it in the PR body. When text gets shorter and the long macro warns "… can be …fwd", switch back the same way.

## Source priority

For each string, use the first source that covers it:

1. `GLOSSARY.md`: decisions already made are final unless I reopen them.
2. Dump of the German original: if the string exists there, take it verbatim. If the hack changed the English text, start from the original German wording and change only what differs.
3. Previous translations: reuse them if they match the current English text.
4. Official German text from later games: PokéWiki (pokewiki.de); PokeAPI (pokeapi.co, language `de`) for species, moves, items, abilities and natures.
5. Own translation: allowed, but always flagged as such and listed for review. See "New content from the hack" below.

- Take each menu string from the German original's same screen, not from a glossary row for the same English word elsewhere: the original can use different words on different screens (Yellow Legacy: CANCEL is ZURÜCK in lists, ABBRECHEN on the trade screen). If the dump lacks a string, search the original ROM for its bytes and read the box setup in the code that loads it.
- PokeAPI documentation: https://pokeapi.co/docs/v2. Useful endpoints: `pokemon-species`, `move`, `item`, `ability`, `nature`. German text is in the `names`, `genera` and `flavor_text_entries` lists, filtered by `language.name == "de"` (e.g. https://pokeapi.co/api/v2/item/assault-vest).
- PokeAPI's German data is incomplete for some entries. If a German value is missing or looks wrong, check PokéWiki; if the two disagree, PokéWiki wins and you mention the difference.
- Cache PokeAPI responses locally in the scratchpad instead of requesting the same resource again.
- Bulbapedia and other English sources are for understanding context only, never for German wording.
- Never present a name as "official" without a source. If nothing is found, say so.

### New content from the hack

Text the hack added has no German original, so translate it faithfully:

- Keep the full meaning: every piece of information, instruction and hint. Add nothing, leave nothing out, don't "improve" or rewrite the content.
- Keep the tone, the character's voice, jokes and references. Write natural German, not word for word, but don't adapt freely beyond what German needs.
- Terms that already exist in the game (items, moves, places, characters) use their official German names, even inside new text.
- Wordplay, puns and references that don't work in German: propose a German equivalent that keeps the effect, explain the original, and flag it.
- Match the German original's style so new text doesn't stand out next to the old.

## Working agreement

- Code, labels, comments, file names and commit messages stay in English. Only player-visible text is translated.
- Read `GLOSSARY.md` before every task; add every new decision to it.
- State assumptions. Ask rather than guess, especially for names.
- Show every own or changed text for review in two parts, wherever a text is up for review:
  1. **Context**: the situation (where in the game, who speaks to whom, what just happened) and what is said right before and after the text.
  2. The text side by side in three columns: the hack's English, the German original and the new German, each column as wide as the textbox and laid out as the lines appear in the box, with a blank line between boxes. Write `(none: new in the hack)` in the middle column where the original has no such text.

  ```
  ENGLISH           | GERMAN ORIGINAL    | OURS
  ------------------+--------------------+------------------
  We'll be waiting  | Ich werde auf dich | Wir werden auf
  for you, <PLAYER>.| warten, <PLAYER>.  | dich warten,
                    |                    | <PLAYER>.
  ```

- Collect open questions during a task and ask them together in question dialogs (AskUserQuestion), up to 4 per dialog. Each question opens with the text's context and names the file:line, the English and the source, so it stands on its own. Its options are the German candidates, your pick first and marked "(Recommended)", each saying what differs and previewing its three columns, one text per preview.
- Scope each task to one kind of text, all of it across the game: all Pokédex entries, all Pokémon names, all types, all TMs and HMs, all receiving texts, all trainer names, everything on the Pokégear, and so on. No drive-by refactors.
- Change string contents only. Don't rename labels, reorder data or touch game logic. If a translation needs a code change (e.g. wider menu), propose it first.
- Reference material (dumps, original ROMs, previous translations) is read-only.

## Text constraints

- Never exceed the textbox from the profile. With variable-width fonts, measure in pixels, not characters.
- If the profile says the ▼ covers a text tile, a line in the box's bottom row that waits for a button (before a scroll, a new box or a prompt) holds one character less: the character under the ▼ is lost.
- Pokédex entries: follow the line limits and the ending in the profile (some engines add a closing "." themselves).
- Keep the semantics of the text commands: re-breaking lines is fine; changing how a box ends is not.
- Count variables (player and rival name, Pokémon, item and move names, numbers) at their maximum length. Take the limits from the length constants, never from memory.
- Names and fixed-width strings (menus, padded labels) must respect their length constant or exact padded width.
- Use only characters defined in the charmap. Verify that ä, ö, ü, Ä, Ö, Ü, ß and any punctuation you use map to glyphs in the font. Don't add charmap entries or font graphics without asking.
- Know the special charmap tokens (e.g. `#` for "POKé") and follow the project decisions on whether to use them.
- Avoid German constructions whose article, case or gender depends on a variable (e.g. "einen/eine <ITEM>"). Rephrase neutrally.
- If the player can be male or female, avoid gendered forms for the player, or follow how the German original handles it.

### When text doesn't fit

Never leave out a word, a piece of information or a nuance to make something fit. Work through these steps in order:

1. Fit the full words. In dialogue, re-break the lines or add another line or box before touching any word.
2. Look for an official abbreviation: the German original, later German games (PokéWiki) or `GLOSSARY.md`, in that order.
3. If none exists, suggest abbreviations yourself and ask before using them. For each, show the full word, the limit, one or two abbreviation options, and why each one stays unambiguous next to similar terms.
4. Abbreviate as little as possible: shorten one word, not several, and keep the meaning unambiguous. Use the same abbreviation for the same word everywhere and add it to `GLOSSARY.md`.

Example: *Assault Vest* is officially "Offensivweste" (13 characters); the item name limit is 12.

| Option | Verdict |
|---|---|
| Offensivwest | Bad: silently cut, looks like a typo |
| Weste | Bad: drops what makes this item distinct |
| Offensivw. | Weak: keeps the distinct part, but loses what kind of item it is |
| Offens.weste | Good: one word shortened, item type intact, still recognisable |

Ask me with the last two options, then record the choice in `GLOSSARY.md`.

When a name and a generic part (trainer class, title) share a limited space, shorten the generic part. Never shorten the name: it is what identifies the character.

Example: *OFFICER ROCKY* doesn't fit.

| Option | Verdict |
|---|---|
| OFFICER ROC | Bad: name silently cut |
| OFFICER RO. | Bad: the name is abbreviated and no longer recognisable |
| ROCKY | Bad: drops the trainer class |
| OFF. ROCKY | Good: class shortened, name intact |

Use the same class abbreviation for every trainer of that class.

Exceptions to these rules exist only where the project decisions say so (e.g. Pokédex entries that may be shortened).

## Style

- Write ß as the project decisions say.
- Match the tone of the German original; keep each NPC's voice (kids, elders, villain teams, gym leaders) consistent.
- Reuse the original's in-game terminology (e.g. "Arena", "Orden", "Beutel") rather than modern synonyms, unless the glossary says otherwise.

## Validation (every task)

- The build must succeed without errors. If a section or bank overflows because German text is longer, stop and report, unless the project decisions say how to handle that overflow. Don't move sections on your own otherwise.
- If the profile names a Virtual Console build, it must build too, without errors or warnings.
- Re-check every changed line against the textbox and length limits.
- Test in the game once the task's whole chunk is translated, in one pass over all of it (see below): translate every menu text, say, then play through the menus.
- Before a merge, run the profile's merge check, if it names one, on the PR against main. Every text it shows as changed must be one the PR touched.
- Finish with a summary: files touched, strings translated, own proposals (flagged), open questions, screens seen and screens not reached.

## Testing in the game

A text, menu or graphics change is done when you have seen it in the emulator and it matches the German original **by position**: the same characters in the same places, unless the hack itself changed that spot or the new spelling writes ss where the original has ß (dass for daß). Where it did, compare against the hack's English screen instead: same layout, German text fits. A string existing somewhere in the ROM proves nothing.

1. After any text edit, run the check scripts from the profile. Ignore only the known false alarms listed there.
2. Clone the repo into the scratchpad and do all test work there. Hooks, ROM patches and save states stay in that clone and are never committed.
3. Build the debug ROM (or the normal one if there is none) as described in the profile.
4. Drive it from a script with the emulator from the profile, with its dependencies in a venv in the scratchpad. Read the screen as the profile's **Reading the screen** says to check each position, and save a screenshot for me. Hand the emulator its save as a stream and stop it without writing a save file (the profile's **Emulator** row says how): for the original ROM, the file would land in the read-only reference folder.
5. Open the same screen in the German original ROM and compare it position by position: tile by tile with a fixed-width font, in pixels with a variable-width one. For menus, compare the box coordinates too, and every state of the menu: after a choice, markers can overwrite letters. The original ROM's RAM addresses differ from the hack's symbol file: never reuse those addresses on it. Where the two ROMs give the same glyph different tile ids (see the profile), compare by glyph. Compare screens that stay still: frames caught while text is still being typed differ by timing alone.
6. Tell me which screens you saw, and name the ones you could not reach.

### Reaching a screen

- Use the debug menu if the hack has one.
- For screens you can't reach directly, add a hook at the top of a routine that runs every overworld frame. The hook reads an unused RAM byte and jumps to a test case: a warp, a battle, or a call to any routine. Save a state in the overworld and reload it for each case.
- Battles can often be started by setting the opponent and level variables in the overworld and taking one step.
- If a warp keeps the old position (e.g. between maps with the same tileset), warp through an interior first.
- If the game has a real-time clock, set it so time-of-day and weekday texts appear.
- Screens that show saved data (a Hall of Fame list, say) need that data in the save: write it into the save RAM before booting.
- Where save states don't work (printer, link), boot from a prepared in-game save. Find walking paths in a run with save states, then replay the inputs.
- When you find a reliable way to reach a kind of screen, propose adding it to the profile.

### Link features (trades, link battles)

- Run two emulator instances joined by an emulated link cable; the profile's **Emulator** row says how.
- Save states break the link, so each run boots from scratch. Prepare an in-game save standing in front of the link receptionist.
- One side clocks the link (master), the other follows (slave), and the handshake decides the roles. Where the emulator differs from hardware and the handshake fails, patch each copy so it takes its own role, then check both roles in RAM right after connecting. Record every patch in the profile.
- If the link menu misses inputs, hold each button longer (about 12 frames was needed in Yellow Legacy).

### Printer

- If the game prints (Game Boy Printer), compare the printouts with the German original's too, not only the screens. The profile's **Emulator** row says how to capture them.

## Git

- One-line commit messages, no `Co-Authored-By` or session trailers.
- Push a chunk's branch once the chunk is verified (both builds, the check scripts, the in-game pass). Then open its PR, review it, and squash-merge it with one summarising sentence as the subject, one line and never a PR number: `gh pr merge <n> --repo remo-vonarx/polishedcrystal --squash --subject "<sentence>" --body "" --delete-branch`. Confirm `gh pr view <n> --json state` says `MERGED` and that `git log -1 --format=%B origin/master` holds only that line, update the local `master`, and start the next chunk.
