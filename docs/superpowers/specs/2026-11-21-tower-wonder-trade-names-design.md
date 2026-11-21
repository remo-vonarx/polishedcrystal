# Battle Tower and Wonder Trade names: design

## Intent

The last part of the name tables (`2026-11-17-name-tables-design.md`). Part 4 (`2026-11-19-trainer-names-design.md`, PR #11) translated every trainer class and regular trainer, and left two lists for this PR by the user's choice: the Battle Tower's trainers and the trainers whose names Wonder Trade Pokémon carry. Once they are German, every name a player meets in battle or on a traded Pokémon is German, and later dialogue PRs only reuse settled names.

## Size (measured 2026-11-21)

| List | File | Entries | Limit | Shown |
|---|---|---|---|---|
| Battle Tower trainers | `data/battle_tower/classes.asm` (`BattleTowerTrainers`: `rawchar "<Name>", <CLASS>`) | 134 | 9 characters (`NAME_LENGTH - 2`; a full name has no terminator) | battle texts as class + space + name (`<ENEMY>`), 18 tiles per line |
| Wonder Trade trainer names | `data/events/wonder_trade/ot_names.asm` (`WonderTradeOTNames1`/`2`, 256 each) | 512 | 7 characters (`PLAYER_NAME_LENGTH - 1`) | the trade animation (`engine/movie/trade_animation.asm`, sender and OT), the summary's OT |

- **Battle Tower names** are Polished's own: mostly real people and other references (Darwin, Newton, Sagan, Dijkstra, Kubrick, Pirsig, Tajiri), plus two official characters with settled German names, Palmer → Viktor and Thorton → Distmar (`TERMS.md`). Kristall has no Battle Tower.
- **Wonder Trade names** are references across the series and beyond: version names (Red, Gold, Crystal, Ruby, Platina, Alpha, Omega, …), heroes, rivals, professors, gym leaders, Elite Four, villains, the anime (Ash, Jessie, Delia, Tracey), Japanese names of Pokémon characters (Satoshi, Hibiki, Kotone), the series' developers (Tajiri, Iwata, Masuda, Sogabe), Polished's developers (Rangi, Sylvie, Fredrik, Drayano), and other franchises by their Japanese names (Usagi, Shinji, Miku, Haruhi, Jotaro). 59 of them already have a `TERMS.md` row from part 4 (Rot, Eich, Rocko, Falk, Siegfried, …). English entries over 7 letters are cut (Sycamor, Lysandr, Courtny, Lusamin).
- **Battle Tower pairs**: with the German classes, 129 of the 134 class + name pairs fit 18 tiles. Five don't: Cosplayerin Patricia (20), Käfersammler Darwin, Käfersammler Tajiri, Käfermaniac Satoshi and Schönheit Valentine (19 each). Twelve battle texts start a line with `<ENEMY>` (both intros, "sent out", "withdrew", "was defeated", "is about to use", …), so a long pair overflows in all of them, not just the intro.

## Goals, non-goals, anti-goals

- **Goals**
  - Every Wonder Trade name is German where a German name exists, and deliberately unchanged where it doesn't (below). The Battle Tower's two official characters are German; its other names stay (the user's choice).
  - Every Battle Tower pair fits 18 tiles in every battle text.
  - Regular trainers keep their full classes everywhere: battles, the phone list, the radio.
  - The name checker covers both lists and measures every Battle Tower pair.
- **Non-goals**
  - Battle texts around `<ENEMY>` ("möchte kämpfen!", "wurde besiegt!"): the battle-text area.
  - Dialogue that names these characters: each dialogue area.
  - Battle Tower and Battle Factory menus and their other texts: their own areas.
- **Anti-goals**
  - A regular trainer's class shortened to fit a Battle Tower trainer.
  - A name cut silently to its limit, or a reference replaced by an unrelated name to make it fit.
  - Any change to the always-loaded ROM bank (ROM0 has 47 bytes free, needed by the umlaut work).

## Constraints

- Limits from `constants/text_constants.asm`, as above; `#` and `#mon` count one byte but print 4 and 7 tiles; `<PK><MN>` is two bytes, two tiles.
- The Battle Tower takes its classes from `TrainerClassNames`, the list all regular trainers use.
- Character set and spelling per the project profile and Style (ss for ß, mixed case).
- `utils/check_names.py` must be clean and `utils/check_order.py` must pass on the PR.

## Approaches

### The five long Battle Tower pairs (the user's choice, 2026-11-21)

1. **A line break in the intro only**: rejected. The other eleven texts that start a line with `<ENEMY>` would still overflow.
2. **A general line break in the text printer** (name on the next line, the text's next line scrolls): works for all twelve texts, but costs about 20–30 of ROM0's 47 free bytes.
3. **Leave the overflow for the battle-text PR**: the user chose this first, then replaced it with 6.
4. **Shorter Battle Tower names**: loses the references (Darwin, Satoshi Tajiri) and breaks the rule that the name is never what gets shortened.
5. **Shorter classes for everyone**: about 42 regular trainers of these four classes would show an abbreviation in battles and the phone list, for five late Battle Tower trainers.
6. **Short classes in the Battle Tower only (chosen)**: Käfersammler → **Käfersamml.**, Käfermaniac → **Käferman.**, Schönheit → **Schönh.**, Cosplayerin → **Cosplayer**, the user's forms. Every Battle Tower trainer of these classes uses the short form (Kirby, Angelica and Tomoyo too), so a class has one form inside the Battle Tower. All five pairs then fit: Käfersamml. Darwin 18, Käfersamml. Tajiri 18, Käferman. Satoshi 17, Schönh. Valentine 17, Cosplayer Patricia 18.

## Decisions

### Branch and PR

One branch from `master`, one PR on the fork, squash-merged with the PR title as subject (`gh pr merge --squash --subject "<title>"`).

### Battle Tower short classes

- A table next to the Battle Tower data (in `engine/events/battle_tower/` or `data/battle_tower/`, ROMX): pairs of class constant and short name, four entries, each short name terminated and at most `TRAINER_CLASS_NAME_LENGTH - 1` bytes.
- `GetOTName` (`engine/battle/read_trainer_attributes.asm`, ROMX) copies the class name into `wOTClassName` for every trainer battle. When `wInBattleTowerBattle` is non-zero and the class is in the table, it copies the short name instead. Nothing else changes: link battles, regular battles, `GetTrainerClassName` and its other callers (phone, radio, Bug-Catching Contest, scripts) keep the full class.
- The short names are an Abbreviation of each class for the Battle Tower only; `TERMS.md` records them as such.

### Battle Tower names (the user's choice, 2026-11-21)

Every Battle Tower name stays as in English, except the two official characters: Palmer → Viktor and Thorton → Distmar (`TERMS.md`). The facility gathers trainers from everywhere, many names are references a German name would lose (the veterans Hopper and Dijkstra, the thief Fagin), and part 4's treatment of everyday names (own German names per class) doesn't apply here. So the Battle Tower part of this PR is the short-class table, the two names, and the checker.

### Who an entry is

A `TERMS.md` row applies to an entry only when the entry is the same character, never just because the English spelling matches (my call, 2026-11-21, from what a `TERMS.md` row decides). Research first identifies who each Wonder Trade entry refers to, from its neighbours in the list and from PokéWiki. Examples the builder check found: "Matthew" sits in the Polished-developer block (kept), not Veteran Matthew (Matthias); "Mikey" sits among anime one-offs, not Youngster Mikey (Dietrich); "Kris" is Crystal's heroine, not `TERMS.md`'s default player name (Krista); "Joey" next to Cal and Carrie is Youngster Joey (Julian).

### Sources

For each Wonder Trade name, the first source that has it (the project's Source priority, with the project decision that a Modern name wins over a Gen 2 name, ADR 0002):

1. `TERMS.md`, for the same character: final. About 60 Wonder Trade entries are already there.
2. The Modern name: the official German name from the latest game with the character (PokéWiki first, PokeAPI where it applies).
3. Kristall: for a Gen 2 character with no later game, or where the Modern name is over the limit (ADR 0002 amendment). Part 4's exception carries over: where HeartGold/SoulSilver renamed a character in English too and the list keeps Crystal's English name, Kristall's name stands.
4. The German edition of Pocket Monsters SPECIAL for the heroes named after versions (Gold, Crystal, Ruby, Sapphire, …), as part 4 did with Yellow (Gelb). Where the manga has no German name, the German version name (Rubin, Saphir, Smaragd, Diamant, Perl, Platin, Schwarz, Weiss, Sonne, Mond, …).
5. The German anime dub (PokéWiki) for anime-only characters, flagged as Anime names.
6. Otherwise unchanged.

### Wonder Trade names kept as in English (my calls, 2026-11-21; the user approved the approach)

- Real people: the series' developers (Tajiri, Iwata, Masuda, Sogabe) and others.
- Polished's developers (Rangi, Sylvie, Fredrik, Drayano, …).
- Japanese names of Pokémon characters (Satoshi, Shigeru, Hibiki, Kotone, Touya, …): Japanese names, the same in German.
- Characters from other franchises (Sailor Moon, Evangelion, Vocaloid, Steins;Gate, JoJo, …): the English list uses their Japanese originals, not their English dub names (Usagi, not Serena), so the German keeps those too rather than taking German dub names (Bunny).
- Greek letters and other version words with no German form (Alpha, Omega, Delta, X, Y, Z).
- Each kept name that the checker would report goes into `SAME_IN_GERMAN`.

### Over the limit

A German Wonder Trade name over 7 characters takes Kristall's name where Kristall has one; otherwise the user picks an Abbreviation in a question dialog, per CLAUDE.md "When text doesn't fit" (the full name, the limit, one or two options, why each stays unambiguous). Known cases: Siegfried (Lance, 9), Kristall (Crystal, 8), Major Bob (Lt. Surge), Flordelis (Lysandre); research finds the rest. A name already cut in English (Sycamor) is translated from the full English name.

### TERMS.md

One row per decided name that isn't already there (English, German, list, source), grouped as in part 4; the four Battle Tower short classes as Abbreviations; one row each for the kept Wonder Trade categories above and for the kept Battle Tower names. Own names and Abbreviations are flagged and listed in the PR.

### Name checker

- `utils/check_names.py` gets both lists, paired by position with Upstream's English: the Battle Tower names (9 characters) and the Wonder Trade names (7).
- The Battle Tower list counts as kept apart from Viktor and Distmar: one list-level rule in the checker (a reverted Viktor or Distmar is still reported), not 132 entries in `SAME_IN_GERMAN`.
- **Battle Tower pairs**: each Battle Tower trainer's class (the short form where the table has one, else `TrainerClassNames`) plus a space plus the name must be at most 18 tiles.
- `--text` learns nothing from these lists: most of their names are references that dialogue doesn't use (part 1's anti-goal).

### Testing

- `make vc` and `make faithful vc` with only the baseline warnings; the Huffman tables regenerated; the checkers clean.
- Azahar, test clones with hooks, never committed, German next to English (`master` before this PR):
  - a Battle Tower battle against Darwin: "Käfersamml. Darwin" in the intro and in "sent out"; a regular Bug Catcher battle in the same build still shows "Käfersammler" (for example Greg);
  - a Wonder Trade with a fixed trainer index: the trainer's name on the trade animation and the summary's OT, using a 7-letter German name.
- Kristall has neither screen, so the comparison is against Polished's English by position.

## Left to the builder

- Where the short-class table lives and how `GetOTName` looks it up, within ROMX and the routine's existing register use.
- How the hooks start a Battle Tower battle (setting `wInBattleTowerBattle`, loading a Battle Tower trainer by index) and a Wonder Trade with a fixed trainer name.
- The research split (for example one agent per source) and how its results are checked against PokéWiki.
- Grouping the abbreviation questions into dialogs (up to four per dialog, one preview per name).
