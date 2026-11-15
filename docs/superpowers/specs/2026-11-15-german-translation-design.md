# German translation: design

## Intent

The user plays Polished Crystal entirely in German on a New 3DS through Virtual Console. Where Polished kept Gen 2 content, it should read like Kristall. Where Polished added or rewrote content, it should read like a faithful German translation in Kristall's style. The Translation is built up one area per PR, the way the user's Yellow Legacy and Crystal Legacy translations were, so every merged PR is playable on the 3DS.

## Goals, non-goals, anti-goals

- **Goals**
  - Every player-visible string in German.
  - Kristall's wording wherever Polished's Source text still matches vanilla Crystal.
  - Modern names (ADR 0002).
  - The fork keeps merging Upstream's fixes.
- **Non-goals for now**
  - Building an English ROM from this fork.
  - Text that only debug builds show (inside `if DEF(DEBUG)`).
  - Title screen logo graphics.
  - The Analogue Pocket build.
  - Link and trade compatibility with English games.
  - Changing the Huffman vowel set or the n-grams.
  - The Distribution patch.
- **Anti-goals.** Each of these counts as a failure even if the build works:
  - Upstream fixes silently stop reaching German text.
  - A word, a piece of information or a nuance is dropped to make text fit.
  - Text works in an emulator but not on Virtual Console.
  - New text assumes the player's gender.

## Constraints

- **ROM size.** The ROM is 4 MB MBC3 ("MBC30", ADR 0001). Nothing may sit above bank `$FF`. Map script sections (`data/maps/scripts.asm`) and most text sections float, so the linker places them. ROM0 had 55 bytes left on 2026-11-14.
- **Character set.**
  - `Ä ä Ö ö Ü ü` are at `$C9`–`$CF`, and ß is written "ss" (ADR 0003).
  - No new glyphs without asking.
  - `#` prints "Poké", so `#mon` prints "Pokémon".
- **Text limits.**
  - Name limits come from `constants/text_constants.asm`; the `*_LENGTH` values include the terminator.
  - The text box width and where its ▼ sits must be confirmed in Polished; Crystal Legacy's box is 18 × 2.
- **Huffman tables.** Text is Huffman-compressed. After a text change, the tables are regenerated as described in `utils/huffman.py`.
- **Upstream** fixes bugs within days and is merged regularly.

## Approaches

1. **Edit strings in place (chosen).** German replaces the English inside the existing files, as in the user's Legacy forks. When Upstream changes a line that's already translated, the merge conflicts at that line.
2. **Copies under `locale/de/`, picked by a build flag** (Upstream's abandoned French test). About 28,000 of roughly 40,000 text lines sit in 525 map files mixed with script code. Every copied map would miss Upstream's script fixes unless it was compared by hand after each merge.
3. **A build step that swaps text by matching its English wording.** Upstream's files would stay untouched, but the tool has to exist before any translating starts.

The user picked 1: it's the workflow they already use, and git itself points at changed Source text.

## Decisions

### Storage and Upstream

- Only string contents change. Labels, code, comments, file names and commit messages stay in English. If a translation needs a code change, such as a wider menu, it's proposed first.
- Translation happens on the current `master`, not against a tagged release.
- **Drift guard.** Every Upstream merge comes with a check of Upstream's diff for text lines in already-translated areas: Source text that changed without a conflict, and new English lines. Each one gets translated in the same PR as the merge.
- **Upstream merges** (the user's decision). Each merge of `upstream/master` gets its own PR, which is merged with a merge commit. A squash would drop the link to Upstream's history, and every later merge would conflict again on the same translated lines. All other PRs stay squash-merged. The drift guard diffs Upstream from the previous merge's Upstream parent; the first merge diffs from the fork point `4a9e37b13`.
- CLAUDE.md's "Upstream" section drops its `locale/` rule and its "translate against a tagged release" rule. It gains the drift guard and the merge-commit exception.

### PR sequence

1. 4 MB build.
2. Translation setup.
3. Text, one area per PR. The first area is the new game.

Each PR follows the fork's existing workflow: its own branch, a PR on the fork, squash-merged. Upstream merges are the one exception.

### PR 1: 4 MB build

- `tools/bankends.c` counts 256 banks.
- **Fail fast.** The `"Title"` section (`main.asm:567`) is pinned to `ROMX $FF` in `layout.link`. Every build, including the `_vc.gbc` behind the VC patch, is then 4 MB from day one. A CIA built without the MBC30 patch fails at the title screen instead of hours into the game.
- `make vc` still produces the VC patch, with no new warnings.
- CLAUDE.md's "ROM space" section describes the result. Unused ROM space is measured with `make freespace`.
- **Checks**
  - Header byte `$148` is `$07`.
  - `.sym` places `_TitleScreen` in bank `$FF`.
  - A CIA from `vc/build_cia.sh` boots in Azahar through the title screen into a new game.
  - The user confirms it on the 3DS.

### PR 2: translation setup

**CLAUDE.md**
- It takes over these sections of `~/Development/Pokemon_Crystal_Legacy/CLAUDE.md` (the user's template, "the same for every hack"):
  - Source priority, with "New content from the hack".
  - Working agreement.
  - Text constraints, with "When text doesn't fit".
  - Style.
  - Validation.
  - Testing in the game, with "Reaching a screen". "Link features" waits until a link screen is translated.
- Polished's "Project profile" and "Project decisions" are filled in. Facts already in this repo's CLAUDE.md (Build, ROM space, Names, Text engine) move into the profile rather than being repeated.
- Adapted from the template:
  - The template's "Git" section isn't taken over; the fork's PR workflow stays.
  - "Style" writes "ss" instead of ß.
  - "Validation" accepts sections the linker moves above bank `$7F`. Only a section that can't fit any bank stops the work and gets reported. That includes a map scripts section over 16 KB, which needs a split proposed first.
- The previous CLAUDE.md content stays where it's still true.

**Project decisions**
- Names are in mixed case, as in Upstream and current German games: "Bisasam", "Prof. Lind". Kristall lines reused in capitals get re-cased.
- "du", "dein", "dich" and "dir" are lowercase, as in Kristall; they're capitalised only at the start of a sentence.
- ß is written "ss" (ADR 0003), including in Kristall lines.
- Pokémon is written with the `#mon` token.
- The player picks one of four pictures, both boys and girls. Kristall's own lines stay as they are; new text addresses the player neutrally. Each such wording is proposed for the user to confirm.
- Modern names win (ADR 0002). Characters from later games get their Official name from that game.
- One-off NPC names without an official source get a German proposal, flagged.
- Faithful-only text (inside `if DEF(FAITHFUL)` blocks) gets translated too.

**Settled terms** (my call). Crystal Legacy's `GLOSSARY.md` is a table of English → German decisions. This repo's `GLOSSARY.md` is the project's English vocabulary, so the decision table becomes a new file, `TERMS.md`, with Crystal Legacy's columns: English, German, where, source or note. Wherever the template says to read or add to `GLOSSARY.md` for a translation decision, the adapted CLAUDE.md says `TERMS.md`. That covers Abbreviations, NPC names and own proposals once the user accepts them.

**Sources** (the template's source priority, filled in)
1. `TERMS.md`.
2. The Kristall text dump: verbatim when the Source text matches vanilla. When Polished changed the English, start from Kristall's wording and change only what differs.
3. Crystal Legacy's German text, in `~/Development/Pokemon_Crystal_Legacy`, wherever Polished's Source text matches pret's English.
4. Official German text from later games: PokéWiki, and PokeAPI for species, moves, items, abilities and natures.
5. Own translation, flagged and listed for review.

**Kristall material.** The ROM, `german_text_dump.txt` and `dump_german_text.py` are copied from `~/Development/Pokemon_Crystal_Legacy/.claude/upload/` into `.claude/upload/`. That folder is listed in `.git/info/exclude`. The ROM's SHA-1 starts with `accb5842`, the same dump as the Base CIA's ROM.

**Checkers**
- `check_text_width.py` and `check_text_mode.py` are ported from Crystal Legacy's `tools/` to Polished's text macros and charmap. They run on the current tree; their hits on untranslated Source text are either fixed or listed as known false alarms in the profile.
- `check_names.py` comes with the name-table PR, because its name list is what that PR decides.

### PR 3 onward: text areas

- **Scope.** One area per PR: a group of maps, one data file or one menu.
- **First area: the new game.** It covers everything a new player sees from power-on until they first control the player in their room, plus the texts of that room's objects. That includes the main menu, the initial options, the clock, Elm's speech, the player picture, and the naming screen's labels and prompts.
- **Suggested next areas.** The name tables (Pokémon, moves, items, trainer classes, places), because all dialogue refers to them. Then story order through Johto. The user can reorder.
- **Every PR**
  - Translated by the source priority.
  - Checkers clean.
  - Build and VC patch without new warnings.
  - Huffman tables regenerated.
  - Screens checked by position, against Kristall where Polished kept the screen and against Polished's English screen elsewhere.
  - An Azahar playtest of at least one changed screen.
  - Open questions asked as the template's table.
  - Own translations flagged.

## Left to the builder

- The exact wording and order of the new CLAUDE.md, following `writing-for-agents`. It keeps one source of truth per fact.
- How the checkers parse Polished's macros and n-gram tokens.
- **The scriptable emulator** for reading tilemaps and reaching screens past the new game. It must run the 4 MB ROM and read and write RAM. PyBoy, the template's choice, may mask MBC3 banks to 7 bits; the bank `$FF` title screen shows at once whether it works. It's chosen when the first such screen comes up. Azahar stays the Virtual Console check.
- Area boundaries after the first area.
