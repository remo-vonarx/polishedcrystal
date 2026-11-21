# Trainer classes and names: design

## Intent

Part 4 of the name tables (`2026-11-17-name-tables-design.md`): the people. Every later dialogue, phone and battle-text PR names trainers ("Käfersammler Wolfgang", "Arenaleiterin Bianka"); with the names settled first, those PRs only use them.

Part 4 holds about 1,800 strings. The user split it into two PRs (2026-11-19):

1. **This PR**, "Translate the trainer classes and names": trainer classes, trainer names, the nicknames of trainers' Pokémon, the in-game trades, and the few tables of other people's names.
2. **Next PR**: the 134 Battle Tower names (`data/battle_tower/classes.asm`) and the 512 Wonder Trade OT names (`data/events/wonder_trade/ot_names.asm`). They show on few screens and need other research (characters from every generation, game titles, real people). It gets its own design conversation.

## Size (measured 2026-11-19)

| List | File | Entries | Kristall |
|---|---|---|---|
| Trainer classes | `data/trainers/class_names.asm` (`TrainerClassNames`, one `li` per class constant) | 149 (91 different English words) | 67 classes (`[names]` 0b:41ee), in capitals |
| Trainer names | `data/trainers/parties.asm` (`def_trainer <id>, "<Name>"` under `def_trainer_class <CLASS>`) | 965 (718 different) | 429 match a Kristall trainer by class and English name; 89 more match only by name; 447 have none |
| Nicknames of trainers' Pokémon | `data/trainers/parties.asm` (`tr_mon <level>, "<Nickname>", …`) | 51 | – |
| In-game trades | `data/events/npc_trades.asm` (nickname and OT per trade) | 9 trades | Crystal's trades, where Polished kept them |
| Other people | `data/phone/non_trainer_names.asm` (Mom, the bike shop, Bill, Prof. Elm, Lyra, Buena, each with a subtitle line); `engine/events/specials.asm` `.DefaultRivalName` ("Silver"); `engine/menus/intro_menu.asm` `.Ralph` (the Magikarp record holder) | 9 strings | Mama, Bill, Prof. Lind |

The Kristall match was measured by pairing Crystal Legacy's first commit (`9a5b41a27`, pret's English names) with its current German names by party group and position (Crystal Legacy took them from Kristall), then looking up Polished's (class, English name). Kristall's dump lists its trainers by class number and position (`[trainers]`, 541 lines).

## Goals, non-goals, anti-goals

- **Goals**
  - Every trainer class, trainer name, trainer's Pokémon nickname, trade nickname and trade OT name is German.
  - A trainer who appears several times (rematches, the same trainer in two places) has one German name.
  - Every class + name pair fits the battle line (below).
  - The name checker covers the new tables and measures every pair.
- **Non-goals**
  - The Battle Tower and Wonder Trade names (next PR). The Battle Tower's classes come from `TrainerClassNames`, so they become German here. The classes are settled for the regular trainers only; the next PR fits each Tower name to its class and measures those pairs. Until it merges, a few Tower intros on master overflow ("Käfersammler Darwin" is 19). The user's choice (2026-11-19).
  - Dialogue that names a trainer: map scripts, phone calls, the radio's "Places and People" show (`engine/pokegear/radio.asm:845`), the Bug-Catching Contest announcements (`engine/events/bug_contest/contest.asm:173`). Each stays English until its area.
  - Battle texts around `<ENEMY>` ("möchte kämpfen!", "wurde besiegt!"): the battle-text area.
- **Anti-goals**
  - A class + name pair that runs past its line in the battle box.
  - A name silently cut, or an official name shortened to fit: the class is shortened instead (CLAUDE.md, "When text doesn't fit").
  - One trainer under two names, or one class with two spellings for the same gender.
  - An engine change to make pairs fit (the user's choice, below).

## Constraints

- **Class limit:** 12 tiles (`TRAINER_CLASS_NAME_LENGTH` 13 with the terminator). `<PK>` and `<MN>` are one tile each, `#` four, `#mon` seven.
- **Trainer name limit:** 10 tiles (`NAME_LENGTH` 11). Pair names ("Amy & Mimi") count whole. Rival entries are `"<RIVAL>"` and Lyra's `"Lyra"` is a fixed name; `<RIVAL>` stays and counts as 7 (`PLAYER_NAME_LENGTH` − 1).
- **Battle line:** class, space, name on one line of 18 tiles. `PlaceEnemysName` (`home/text.asm:400`) prints `wOTClassName`, a space, then the name, and texts such as `WantsToBattleText` (`data/text/battle.asm:50`) start with `<ENEMY>` on line 1. All 965 English pairs fit (Upstream even writes "TowerTycoon" and "FactryHead" to make them fit), and so do all 520 of Kristall's. Kristall's ROM prints the same space (00:11ef). Four texts already move the name to the next line when the pair is too long (`EnemyLinebreakTable`, `engine/battle/text.asm`); that stays as it is.
- **Phone list:** the name and a ":" at column 2, the class one row below at column 5 (`GetCallerClassAndName`, `engine/phone/phone.asm:374`). A 10-tile name and a 12-tile class both fit.
- **Nicknames:** 10 tiles (`MON_NAME_LENGTH` − 1).
- **Trades:** the nickname is padded with `@` to 11 bytes (`"Muscle@@@@@"`), the OT to 7 plus a `$00` (`"Mike@@@", $00`); the table's width is asserted (`NPCTRADE_STRUCT_LENGTH`).
- **Female classes:** Polished has its own entries for female trainers (`SWIMMERF`, `COOLTRAINERF`, `OFFICERF`, `VETERANF`, the female leaders, …), so each entry can take its own form.
- **ss** for ß, and only characters in the charmap.

## Approaches

### The split (the user's choice, 2026-11-19)

1. **Two PRs (chosen):** this one with everything battles, the phone and dialogue need; the Battle Tower and Wonder Trade names after it.
2. One PR with all 1,800 strings: about twice the places PR.
3. Three PRs, classes first: the classes and names depend on each other through the battle line, so splitting them buys little.

### The battle line (the user's choice, 2026-11-19)

1. **Fit like Kristall (chosen).** No engine change. Every pair is at most 18 tiles and the checker measures each one. The box matches Kristall and English by position.
2. Engine change: put class and name on two lines whenever the pair is over 18, as Polished already does in four texts. Full modern classes with any name, but the boxes would differ from Kristall and English, and every `<ENEMY>` text would need reworking. Dropped.

## Decisions

### Branch and PR

Branch `trainer-names`, PR "Translate the trainer classes and names" on the fork, squash-merged with `--subject "Translate the trainer classes and names"`.

### Sources

Source priority as in CLAUDE.md. For these lists:

| List | Order of sources | Notes |
|---|---|---|
| Classes | 1. The Modern name: the class's name in current German games (PokéWiki's class pages), in the feminine form for a female entry. 2. Kristall's name, re-cased, when the Modern name is over 12 (ADR 0002 amendment). 3. One Abbreviation, asked. | Classes with no official German name (Polished's own: Ace Duo, Cosplayer, …) get an own name, flagged and asked |
| Trainer names | 1. The Modern name: the trainer's German name in the latest game that has the trainer, usually HeartGold/SoulSilver (PokéWiki's class pages per game, e.g. "Teenager/Pokémon Goldene Edition HeartGold und Silberne Edition SoulSilver"). 2. Kristall's name, by class and position. 3. An own German name, flagged | HeartGold/SoulSilver kept Kristall's names where checked (Youngster Joey is "Julian" in both). A name-only Kristall match (89) counts only when it is the same trainer, moved to another class by Polished |
| Nicknames | Official where a game gives that trainer's Pokémon the nickname; otherwise own, flagged | |
| Trades | The OT follows the person: a partner who is one of Crystal's NPCs keeps Kristall's name for them, even where Polished changed the Pokémon (Kristall: Mike is "Ralf", Kyle "Tobi", Emy "Carmen", Chris "Paul"; Tim and Kim stay). The nickname takes Kristall's where Polished kept Crystal's English nickname ("Doris"; Chris's "Paul" is Kristall's "Pollo", since Kristall's OT is already Paul); otherwise own, flagged. My call: one person, one name (anti-goal) | Kristall's table: Crystal Legacy's `data/events/npc_trades.asm` |
| Other people | Kristall (Mama, Bill, Prof. Lind) and Modern names; the subtitles use the class names | Lyra and Buena: their Modern names |

### Female classes over 12 (the user's choices, 2026-11-19)

| Class | Male entries | Female entries | Why |
|---|---|---|---|
| Leader | "Leiter" (Kristall) | "Leiterin" | "Arenaleiter Hartwig" is 19 and "Arenaleiterin" 13 |
| Ace Trainer | "Ass-Trainer" | "Ass-Trainer" (Kristall) | "Ass-Trainerin" is 13; Kristall's name over a respelling (ADR 0002 amendment) |
| `<PK><MN>` Trainer | "Trainer" (Kristall) | "Trainerin" | "Pokémon-Trainer" is 15, "Pokémon-Trainerin" 17 |

Any other female class whose feminine form is over 12 is asked in a dialog, with these as the pattern.

### When a pair doesn't fit

The checker reports every pair over 18. For each:
- An official name (Modern or Kristall) is never shortened. The class gets shorter: Kristall's shorter form if it has one ("Leiter" for "Arenaleiter", because "Arenaleiter Hartwig" is 19), otherwise one Abbreviation. The class string then changes for every trainer of that class. That's one entry per class constant, so male and female entries may differ.
- An own name is chosen to fit its class from the start.
- Each class shortening is asked in a dialog, with the trainers it affects.

### Own names

Own trainer names are German first names that fit the class's era and voice, as Kristall chose them (Julian, Burkard, Wolfgang), and fit the pair limit. A name that is a reference keeps it where it works in German: Psychic Uri (Uri Geller), Ruin Maniac Jones, Black Belt Inigo stay, and go into `SAME_IN_GERMAN`. A reference that doesn't work in German gets an equivalent, flagged (CLAUDE.md, "Original content"). My call. A pair entry ("Amy & Mimi") gets a German pair of names. The user reviews them one class at a time: one dialog question per class, all of that class's own names in one preview, with the option to name changes. That's about 40 classes, so about 10 dialogs.

### TERMS.md

- One row per class: English, German, source, and any shortening.
- One row per list naming its source, as in parts 1–3.
- Named characters (leaders, Elite Four, Champion, Kanto leaders, rivals, Lyra and every other trainer with a story role) get their own rows.
- Own names of generic trainers: one row per class listing the class's English → German pairs, so every decision is recorded without 300 rows.

### Name checker

- `utils/check_names.py` gets the new tables, paired by position with Upstream's English as before: classes, trainer names, nicknames, trade nicknames, trade OT names, and the other people.
- **Pair measure:** for each `def_trainer`, the German class of its `def_trainer_class` plus a space plus the name must be at most 18 tiles, reported as "(N > 18)". `<RIVAL>` counts 7. The Battle Tower's pairs join the measure in the next PR.
- Names that are the same in both languages go into `SAME_IN_GERMAN` (e.g. "Bill", `<RIVAL>`).
- `--text` learns the class names and the names of the named characters. It leaves out the generic trainers' names, because many are everyday words or short ("Don", "May", "Ray", "Art"), and listing them would drown real leftovers (part 1's anti-goal).

### Testing

Screens to see in Azahar, German next to English by position, and next to Kristall where Kristall has the same trainer:
- A trainer battle's intro box with the longest German pair, and with a female class.
- A gym leader's intro box.
- The Pokégear phone list with a trainer contact (name, ":" and the class below).
- An in-game trade: the trade screen's nickname and OT, and the summary of the Pokémon received.
- A trainer's nicknamed Pokémon in battle.

Test clones reach these with hooks (a battle against a given trainer, a phone contact, a trade), one test build per case. Screens not reached are named in the PR.

## Left to the builder

- How to get pret's English trainer names by position (Crystal Legacy's commit `9a5b41a27`, or Kristall's dump with pret's class order), and how to cache PokéWiki's pages.
- The checker's code layout.
- The hooks, movies and the order of tasks.
