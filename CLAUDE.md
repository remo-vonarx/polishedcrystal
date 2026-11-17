# CLAUDE.md

This fork of Polished Crystal is being translated into German, to be played on a New 3DS through Virtual Console. Vocabulary lives in `GLOSSARY.md`: use its terms in code, commits and conversation, and steer clear of its _Avoid_ words.

Everything specific to this fork lives in **Upstream**, **Project profile** and **Project decisions**. The sections from **Source priority** on are adapted from the translation template I use for every hack; they refer to those three.

## Upstream

- `master` on the fork `remo-vonarx/polishedcrystal` is the Translation. Each change gets its own branch and reaches `master` through a PR on the fork (`gh pr create --repo remo-vonarx/polishedcrystal`), squash-merged with the PR title as the commit subject; the branch is deleted afterwards.
- Upstream (Rangi42/polishedcrystal) is the `upstream` remote. It fixes bugs within days, so merge `upstream/master` in regularly and keep this fork's diff limited to the translation. German replaces the English in place, so a merge conflicts wherever Upstream changed a translated line. Large Upstream renames, such as draft PR #1652, are the main source of conflicts.
- Each Upstream merge gets its own PR, merged with `gh pr merge --merge`. A squash would drop the link to Upstream's history, and every later merge would conflict again on the same translated lines. Every other PR is squash-merged.
- **Drift guard.** Before merging, find the Upstream text that changed under the translation without a conflict:
  1. `git fetch upstream`, then `base=$(git merge-base master upstream/master)`: the last merged Upstream commit, the fork point `4a9e37b13` until the first merge.
  2. `git diff --name-only $base master`: the files this fork changed.
  3. `git diff $base upstream/master -- <those files>`: Upstream's changes to them.
  4. `git diff --name-only --diff-filter=A $base upstream/master`: files Upstream added. Those in a translated area hold new Source text too.
  5. Translate every changed or new text line from steps 3 and 4 in the merge PR.

## Project profile

If a field is empty or turns out wrong, find the right value, tell me, and propose the change.

| Field | Value |
|---|---|
| Hack and repo | Polished Crystal; workflow in **Upstream** |
| Kristall | Pokémon Kristall-Edition. ROM: `.claude/upload/Pokemon - Kristall-Edition (Germany).gbc` (SHA-1 `accb5842…`), never committed (`.claude/upload/` is in `.git/info/exclude`). Text dump: `.claude/upload/german_text_dump.txt` (`[texts]` 5,692, `[pokemon names]` 251, `[trainers]` 541 by class and position, `[names]` 393 lists; each line starts with bank:address), made by `.claude/upload/dump_german_text.py`. It is verbatim but skips texts that start with a line break or a RAM name (`text_ram`); read those from the ROM. The ROM writes the new spelling (`dass`, never `daß`), lowercase `du`/`dein`, the lowercase possessive s (`LINDs`) and names in capitals (`PROF. LIND`); reused lines are re-cased per Project decisions. The Base CIA `vc/local/dumps/kristall-vc-v0.1.0.standard.cia` holds the same ROM; Azahar boots its extracted game content (`vc/README.md`) |
| Previous translations to reuse | Crystal Legacy's German text in `~/Development/Pokemon_Crystal_Legacy` (branch `main`), wherever Polished's Source text matches pret's English. It is partial: the Pokédex entries, part of `data/text/`, some move and item descriptions and the Pokégear; its maps are still almost all English. It writes names in capitals and uses ß (written ss here), so reused Crystal Legacy lines follow Project decisions and Style like Kristall lines |
| Textbox | 18 characters × 2 lines (`TEXTBOX_INNERW`), fixed-width font, one tile per character. The ▼ sits on the bottom border (`LoadBlinkingCursor` in `home/text.asm`, tile 18,17), so every line keeps all 18 tiles. The variable-width font (`gfx/font/vwf.png`, measured in pixels) prints only Bill's PC item names, the ability pop-ups in battle, and in the Pokédex the list's dex numbers and the area page's place name; Pokédex entries are fixed-width. The judge machine's stat names are drawn graphics in `gfx/stats/judge_stats.png` |
| Text commands | `macros/scripts/text.asm`: `text`, `next1` (one row down), `next`, `line`, `cont`, `para`, `done`, `prompt`, `page`; inline: `text_start`, `text_ram`, `text_promptbutton`, `text_asm`, `text_decimal`, `text_pause`, `text_sound`, `text_today`, `text_far`, `text_farend`, `text_plural`, `text_end`. The printer (`home/text.asm`) runs a command loop: a byte below `$0a` is a command and any other byte starts a string, which ends at `@`, at the next command byte, or at `done`/`prompt` (these end the box). So a command right after an open string is fine; `text_end` there ends only the string, and `prompt` with no string open ends the text without waiting. A text that falls through into the next label needs `stop_compressing_text` before that label (as in `data/text/battle.asm`). Pokédex entries (`data/pokemon/dex_entries.asm`): a category `db "…@"`, then 3 lines per page (`next`), 2 pages (`page`), ending in `@`; 19 tiles per line from column 1 (`engine/pokedex/pokedex.asm` clears 5 × 19), though Upstream stays within 18 in all but 3 lines |
| Length constants | `constants/text_constants.asm`; the `*_LENGTH` values include the `@` terminator: `NAME_LENGTH` and `MON_NAME_LENGTH` 11 (10 + terminator), `PLAYER_NAME_LENGTH` 8 (7 + terminator), `MOVE_NAME_LENGTH`, `ITEM_NAME_LENGTH` and `TRAINER_CLASS_NAME_LENGTH` 13 (12 + terminator). The exception is `BOX_NAME_LENGTH` 9: 9 characters, because the terminator isn't stored. Player, rival and trendy-phrase entry all take 7 characters |
| Character set | `constants/charmap.asm`. One tile each, except: `#` prints "Poké" (4 tiles), `#mon` "Pokémon" (7), `<PLAYER>` `<RIVAL>` `<TRENDY>` 7 each at most; `<USER>` `<TARGET>` `<ENEMY>` are battle names of runtime length. The contractions `'d 'l 'm 'r 's 't 'v` and `<PK>` `<MN>` are one tile each. The character set is full: `Ä ä Ö ö Ü ü` took the Spanish slots `$c9`–`$cf` (not `$cb`; mapping and reasons in `docs/superpowers/specs/2026-11-14-umlaut-glyphs-design.md`). Every glyph lives in each selectable font in `gfx/font/` and in `vwf.png`, where gray columns set the glyph's width; `vwf_bw.png` is unused. After editing a font PNG, run `python3 utils/grayscale.py <png>` to restore 2-bit grayscale. The naming screen's keyboards (`data/text/input_chars.asm`) carry the umlauts; layout in `docs/superpowers/specs/2026-11-14-naming-screen-umlauts-design.md` |
| Huffman tables | Text is Huffman-compressed with tables built from the current text; regenerate them after changing text as described in `utils/huffman.py`'s docstring. Its context model treats `AEIOUaeiou` as vowels, hardcoded in three places that must agree: `utils/huffman.py` (`VOWELS`), the encoder in `macros/scripts/text.asm` and the decoder in `home/text.asm`. Adding `ÄäÖöÜü` (`$C9`–`$CF`, one range check) grows the decoder in ROM0, which had 51 bytes free on 2026-11-16 |
| Build | On macOS: `brew install rgbds coreutils` (RGBDS 1.0.4). `make vc` builds `polishedcrystal-<version>.gbc`, a `_vc.gbc` helper and the VC patch. A clean build prints Upstream's 2 `-Wassert` "unnecessary `farcall GetKeyItemAttr`" warnings, and recompiling a tool prints 9 clang "unknown warning option" lines; a task adds no other warning. The `farcall` assert compares banks at link time (`macros/rst.asm`), so longer text can move sections and add or remove an "unnecessary `farcall`" warning without any code change; that isn't a text bug. The build leaves an untracked `tools/parsemap.h.pch`. make 3.81 compares times to the second and treats the ROMs as intermediate: to force a relink, delete both ROMs and the `.patch`. The normal, `faithful` and `debug` builds share object files, so run `make tidy` whenever you switch, also back to plain `make vc`; `make tidy && make faithful vc` builds `polishedcrystal-faithful-<version>.gbc` and its `.patch` |
| Debug build | `make tidy && make debug vc` builds `polishedcrystal-debug-<version>.gbc` and its `.patch`, which `vc/build_cia.sh` needs. No debug menu; the radio in the player's room gives every Pokégear card, the Pokédex, all key items, TMs and HMs, stacks of items, money and all badges (`maps/PlayersHouse2F.asm`), and holding A+B walks through walls |
| ROM space | 4 MB MBC3 ("MBC30"), because German text doesn't fit in 2 MB (`docs/adr/0001-4mb-rom-for-virtual-console.md`). `layout.link` pins the `"Title"` section to bank `$FF`, so every build is 4 MB and Virtual Console without the MBC30 patch fails at the title screen. Floating sections fill the banks below; `tools/bankends` (256 banks) stops the build if anything lands above `$FF`. Measure unused ROM space with `make freespace`. Engine far pointers store the bank as a full byte (their flag bits live in address bit 15), so content above bank `$7F` works; keep flags out of bank bytes in new code too |
| Virtual Console | The deliverable: a change counts as working once it holds on Virtual Console. `make vc` builds the VC patch from `vc.patch.template`, which refers to labels in the link code; those labels keep their names, or the VC patch breaks. Stock Virtual Console reaches only 2 MB; `vc/build_cia.sh` applies poke-cia's MBC30 patch, which fits the Kristall VC v0.1.0 Base CIA unchanged. Packaging, playtests and installing: `vc/README.md` |
| Check scripts | `python3 -I utils/check_text_width.py` and `python3 -I utils/check_text_mode.py` (both default to `maps data engine home`). Known hit, real in Upstream's English: `DownloadDescription` in `data/abilities/descriptions.asm` is 19 tiles at column 1. The width checker allows 20 tiles for the few texts placed on a plain screen from column 0 (`SCREEN_TEXTS`), and the mode checker accepts `stop_compressing_text` right before a label as an intended fall-through. Not measured, so count them by hand: lines with `text_ram`, `text_decimal`, `{…}` values or `<ENEMY>` (runtime length); lines with `<USER>` or `<TARGET>` (at most "Foe " from `home/text.asm` plus a 10-character nickname, 14 tiles in English); and box texts written as `db` strings with `<LINE>` or `<DONE>` (as in `maps/VermilionCity.asm`). Names: `python3 -I utils/check_names.py` pairs each table in its `TABLES` with Upstream's English by position (from `git merge-base HEAD upstream/master`, so fetch `upstream` first) and reports entries still English, entries over their limit and tables whose entry counts differ; it must be clean on every PR. A name that is the same in both languages goes into its `SAME_IN_GERMAN`. `--text <paths>` lists English names of translated tables left in a text area's own files; a dialogue PR runs it on its files |
| Emulator | Azahar (`vc/playtest.py`), which runs the real Virtual Console from the Base CIA: input by movie, screenshots by wall-clock time, no RAM access. A scriptable emulator that runs the 4 MB ROM and reads and writes RAM is chosen when the first screen past the new game needs one; PyBoy may mask MBC3 banks to 7 bits, which the bank `$FF` title screen shows at once |
| Tilemap symbol | `wTilemap`, 20 × 18 tiles at `$C440` (`.sym`) |
| Test entry points | A new game to the player's room, for Polished and for Kristall: `vc/README.md`, "Reach the player's room". Later screens: the debug build's radio. The PC (room and Pokémon Center) and the title-screen prompts: `vc/README.md`, "Reach the PC" |

## Project decisions

Settled choices for this hack. If a topic below isn't decided yet and a task touches it, ask before translating.

- Name casing: mixed case, as in Upstream and current German games ("Bisasam", "Prof. Lind"). Kristall and Crystal Legacy lines reused in capitals get re-cased.
- Spelling: `du`, `dein`, `dich`, `dir` in lowercase as in Kristall; capital only at a sentence start. ß is written "ss" (see Style).
- "Pokémon": the `#mon` token, which prints "Pokémon".
- Player address: the player picks one of four pictures, boys and girls. Kristall's own lines stay as they are; new text addresses the player neutrally. Propose every such wording and let me confirm it.
- Names: a Modern name wins over a Gen 2 name (`docs/adr/0002-modern-names-over-gen-2-names.md`). Characters from later games get their official German name from that game. A name over its Name limit gets one Abbreviation, reused everywhere.
- One-off NPC names without an official source: propose a German name and flag it.
- Faithful-only text (inside `if DEF(FAITHFUL)` blocks) gets translated too.
- Debug-only text (inside `if DEF(DEBUG)` blocks) stays English.
- Translation happens on the current `master`; the drift guard catches later Upstream changes.
- Script jumps: when longer text (or regenerated Huffman tables) pushes a short script jump (`ifequalfwd`, `iftruefwd`, `sjumpfwd`, …) past 255 bytes, the build warns `Value $1xx is not 8-bit` (`-Wtruncation`) and the jump lands in the wrong place. Switch that jump to its long form (`ifequal`, `iftrue`, `sjump`, …) in the same PR without asking, and list it in the PR body. When text gets shorter, the long macros warn "… can be …fwd"; switch back the same way.

## Source priority

For each string, use the first source that covers it:

1. `TERMS.md`: decisions already made are final unless I reopen them.
2. The Kristall dump (profile): if the string exists there, take it verbatim. If the Source text differs from Crystal's English, start from Kristall's wording and change only what differs.
3. Crystal Legacy's German text (profile), if its English matches the current Source text.
4. Official German text from later games: PokéWiki (pokewiki.de); PokeAPI (pokeapi.co, language `de`) for species, moves, items, abilities and natures.
5. Own translation: allowed, but always flagged as such and listed for review. See "Original content" below.

- PokeAPI documentation: https://pokeapi.co/docs/v2. Useful endpoints: `pokemon-species`, `move`, `item`, `ability`, `nature`. German text is in the `names`, `genera` and `flavor_text_entries` lists, filtered by `language.name == "de"` (e.g. https://pokeapi.co/api/v2/item/assault-vest).
- PokeAPI's German data is incomplete for some entries. If a German value is missing or looks wrong, check PokéWiki; if the two disagree, PokéWiki wins and you mention the difference.
- Cache PokeAPI responses locally in the scratchpad instead of requesting the same resource again.
- Bulbapedia and other English sources are for understanding context only, never for German wording.
- Never present a name as "official" without a source. If nothing is found, say so.

### Original content

Original content has no Kristall text, so translate it faithfully:

- Keep the full meaning: every piece of information, instruction and hint. Add nothing, leave nothing out, don't "improve" or rewrite the content.
- Keep the tone, the character's voice, jokes and references. Write natural German, not word for word, but don't adapt freely beyond what German needs.
- Terms that already exist in the game (items, moves, places, characters) use their official German names, even inside new text.
- Wordplay, puns and references that don't work in German: propose a German equivalent that keeps the effect, explain the Source text, and flag it.
- Match Kristall's style so new text doesn't stand out next to the old.

## Working agreement

- Code, labels, comments, file names and commit messages stay in English. Only player-visible text is translated.
- Read `TERMS.md` before every task; add every new decision to it.
- State assumptions. Ask rather than guess, especially for names.
- Collect open questions during a task and ask them together, in question dialogs (AskUserQuestion), never as a table in chat:
  - Up to 4 questions per dialog, more dialogs in a row if needed.
  - Each question names the file:line, the English, the source and where it shows in the game, so it stands on its own.
  - Options are the German candidates, your pick first, marked "(Recommended)", each saying what differs.
  - Show a draft as a short preview, laid out as it appears in the box; one preview per text, never several texts in one.

- Keep each task scoped to one area (one map, one data file, one menu). No drive-by refactors.
- Change string contents only. Don't rename labels, reorder data or touch game logic. If a translation needs a code change (e.g. wider menu), propose it first.
- Reference material (dumps, Kristall's ROM, previous translations) is read-only.

## Text constraints

- Never exceed the textbox from the profile. With variable-width fonts, measure in pixels, not characters.
- If the profile says the ▼ covers a text tile, a line in the box's bottom row that waits for a button (followed by `cont`, `para` or `prompt`) holds one character less: the character under the ▼ is lost.
- Pokédex entries: follow the line limits and the ending in the profile.
- Keep the semantics of the text commands: re-breaking lines is fine; changing how a box ends is not.
- Count variables (player and rival name, Pokémon, item and move names, numbers) at their longest: names at their Name limit, numbers at their most digits. Take the limits from the length constants, never from memory.
- Names and fixed-width strings (menus, padded labels) must respect their length constant or exact padded width.
- Use only characters in the Character set (profile). Verify that ä, ö, ü, Ä, Ö, Ü and any punctuation you use map to font tiles. Don't add charmap entries or font graphics without asking.
- Know the special tokens (profile) and follow the project decisions on whether to use them.
- Avoid German constructions whose article, case or gender depends on a variable (e.g. "einen/eine <ITEM>"). Rephrase neutrally.
- If the player can be male or female, avoid gendered forms for the player, or follow how Kristall handles it.

### When text doesn't fit

Never leave out a word, a piece of information or a nuance to make something fit. Work through these steps in order:

1. Fit the full words. In dialogue, re-break the lines or add another line or box before touching any word.
2. Look for an official abbreviation: Kristall, later German games (PokéWiki) or `TERMS.md`, in that order.
3. If none exists, suggest abbreviations yourself and ask before using them. For each, show the full word, the limit, one or two abbreviation options, and why each one stays unambiguous next to similar terms.
4. Abbreviate as little as possible: shorten one word, not several, and keep the meaning unambiguous. Use the same abbreviation for the same word everywhere and add it to `TERMS.md`.

Example: *Assault Vest* is officially "Offensivweste" (13 characters); the item name limit is 12.

| Option | Verdict |
|---|---|
| Offensivwest | Bad: silently cut, looks like a typo |
| Weste | Bad: drops what makes this item distinct |
| Offensivw. | Weak: keeps the distinct part, but loses what kind of item it is |
| Offens.weste | Good: one word shortened, item type intact, still recognisable |

Ask me with the last two options, then record the choice in `TERMS.md`.

When a name and a generic part (trainer class, title) share a limited space, shorten the generic part. Never shorten the name: it is what identifies the character.

Example: *Officer Rocky* doesn't fit.

| Option | Verdict |
|---|---|
| Officer Roc | Bad: name silently cut |
| Officer Ro. | Bad: the name is abbreviated and no longer recognisable |
| Rocky | Bad: drops the trainer class |
| Off. Rocky | Good: class shortened, name intact |

Use the same class abbreviation for every trainer of that class.

Exceptions to these rules exist only where the project decisions say so.

## Style

- ß is written "ss" everywhere (`docs/adr/0003-ss-instead-of-eszett.md`), also in Kristall and Crystal Legacy lines and in capitals: Strasse, gross, dass. Kristall lines with ß get one character longer, so re-check their length.
- Match Kristall's tone; keep each NPC's voice (kids, elders, villain teams, gym leaders) consistent.
- Reuse Kristall's in-game terminology (e.g. "Arena", "Orden", "Beutel") rather than modern synonyms, unless `TERMS.md` says otherwise.

## Validation (every task)

- `make vc` must succeed with no new warnings (baseline in the profile). `-Wunmapped-char` counts as an error: a character missing from the charmap, such as ß or á, assembles to garbage.
- The linker may move sections above bank `$7F`; that is fine. Stop and report only a section that fits no bank, including a map scripts section over 16 KB, which needs a split proposed first. Don't move sections on your own.
- Regenerate the Huffman tables after a text change (profile).
- Re-check every changed line against the textbox and length limits.
- Test every change in the game (see below).
- Finish with a summary: files touched, strings translated, own proposals (flagged), open questions, screens seen and screens not reached.

## Testing in the game

A text, menu or graphics change is done when you have seen it in the emulator and it matches Kristall **by position**: the same tiles in the same places, unless Polished itself changed that spot or ss stands where Kristall has ß. Where Polished changed it, compare against Polished's English screen instead: same layout, German text fits. A string existing somewhere in the ROM proves nothing.

1. After any text edit, run the check scripts from the profile. Ignore only the known false alarms listed there.
2. Clone the repo into the scratchpad and do all test work there. Hooks, test-only code changes and save states stay in that clone and are never committed. `vc/local/` and `.claude/upload/` exist only in the main checkout, so package and play the clone's ROM with the main checkout's `vc/` scripts.
3. Build as described in the profile (the debug build where its radio helps) and package a CIA (`vc/README.md`).
4. Play it in Azahar with a movie (`vc/gen_ctm.py`, `vc/playtest.py`) and save a screenshot for me. Until a scriptable emulator reads tilemaps (profile), compare screenshots by position.
5. Open the same screen in Kristall (Base CIA, same way) and compare it by position. For menus, compare the box coordinates too. Kristall's RAM addresses differ from Polished's symbol file: never reuse those addresses on it.
6. Tell me which screens you saw, and name the ones you could not reach.

### Reaching a screen

- Use the debug build's radio (profile) for anything that needs badges, items or the Pokégear.
- For screens you can't reach directly, add a hook at the top of a routine that runs every overworld frame and jump to a test case: a warp, a battle, or any routine through a far call. Azahar here has no RAM access or save states, so the hook fires unconditionally and each case gets its own test build, booted from scratch. With a scriptable emulator (profile), the hook can instead read an unused RAM byte, and one overworld save state serves every case.
- With a scriptable emulator, battles can often be started by setting the opponent and level variables in the overworld and taking one step.
- If a warp keeps the old position (e.g. between maps with the same tileset), warp through an interior first.
- If the game has a real-time clock, set it so time-of-day and weekday texts appear.
- When you find a reliable way to reach a kind of screen, propose adding it to the profile.
