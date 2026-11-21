# New Bark Town: design

## Intent

The next text area after the name tables, in story order (`2026-11-15-german-translation-design.md`, "PR 3 onward"). The new game PR ended when the player first controls the player in the room. This PR covers what follows until the player leaves town for Route 29: Mom's scene on the ground floor, New Bark Town with Lyra, Elm's lab with the starter, Elm's house, the neighbours' house and Lyra's house (all five doors in town). Every later visit to these maps (Elm after the Mystery Egg, the Togepi egg, the Master Ball, the post-League visits) is in the same files and comes along. The shared texts these scenes print come along too (the user's choice, 2026-11-21), so the opening plays in German from the room to the first route.

## Size (measured 2026-11-21)

| Part | File | Text lines | Notes |
|---|---|---|---|
| Mom's ground floor | `maps/PlayersHouse1F.asm` | 90 | Mom, Pokégear, day of week and DST, Mom's phone number, the house's later scenes |
| New Bark Town | `maps/NewBarkTown.asm` | 100 | Lyra, the town's NPCs, the sign, the rival at the lab window |
| Elm's lab | `maps/ElmsLab.asm` | 494 | the starter, the aide, the Mystery Egg, Togepi, the Master Ball, the Odd Souvenir, post-League visits |
| Elm's house | `maps/ElmsHouse.asm` | 32 | |
| Neighbours' house | `maps/PlayersNeighborsHouse.asm` | 23 | |
| Lyra's house | `maps/LyrasHouse1F.asm`, `maps/LyrasHouse2F.asm` | 42 | all Polished's own: her dad in three story states, Lyra in her room, Pidgeot, the N64, the kitchen, a TV joke about The Wizard of Oz; the user's choice to include it (2026-11-21) |
| Scene texts | `data/text/common.asm`, `engine/events/mom.asm`, `engine/rtc/timeset.asm` | about 40 | listed below |

About 40% of the lines in the first five maps are word for word in Crystal's English (pret, through Crystal Legacy's first commit `9a5b41a27`), so Kristall has them verbatim; more are Crystal lines Polished rewrapped or edited. The rest is Polished's own: mainly Lyra (New Bark Town and the lab) and extra Elm dialogue.

### Scene texts

The shared strings these scenes print, traced from their scripts (the builder confirms each by following the calls):

- Mom's clock questions (`Special_SetDayOfWeek`, `Special_InitialSetDSTFlag`, `Special_InitialClearDSTFlag`): `_OakTimeWhatDayIsItText`, the day names it shows, `Text_DSTIsThatOK`, `_TimesetAskDSTText`, `_TimesetAskNotDSTText`, `_TimesetNotDSTText` and their neighbours in the same exchange.
- The Bank of Mom (`Special_BankOfMom`): the `_MomBank…` texts and the menu strings in `engine/events/mom.asm`.
- Items (`verbosegiveitem`): the "received" text and `_PutItemInPocketText` (one tile over since PR #9; fixed here).
- The starter (`givepoke`): `_ReceivedGiftMonText`, `_AskGiveNicknameText`, and the naming screen's prompt for a Pokémon nickname if the new game PR didn't translate it.
- Phone numbers (`addcellnum`): the "Registered … number" text.
- The rival's name (`SpecialNameRival`): the naming prompt, if not yet German.

Neighbouring strings in the same files that these scenes don't print stay for their own areas.

## Goals, non-goals, anti-goals

- **Goals**
  - Every player-visible string in the seven map files and the scene texts above is German.
  - Screens Polished kept from Crystal match Kristall by position; screens Polished changed match Polished's English layout.
  - Every new line that addresses the player does so neutrally, confirmed by the user.
- **Non-goals**
  - Route 29, Cherrygrove and later maps; the Pokégear's own screens and the phone calls (`data/phone/`); battle texts; menus.
  - The rest of `data/text/common.asm`.
- **Anti-goals**
  - Changing how a box ends (`prompt`, `done`, `para`, `cont`) or a script's flow to make text fit.
  - A Kristall line rewritten where Kristall's wording fits.
  - A line shortened by dropping information.

## Constraints

- CLAUDE.md governs every string: the textbox (18 × 2, the ▼ tile), the source priority, ss for ß, the Kristall re-casing, mixed-case names, `#mon`, the Avoid words in `GLOSSARY.md`.
- Names come from the name tables (`TERMS.md`): Elm → Prof. Lind, Lyra → Lyra, the starters, items, places.
- Text is Huffman-compressed; the tables are regenerated after the text changes.
- Longer text can push short script jumps past 255 bytes: switch them to the long form (project decision) and list them in the PR.
- `check_text_width.py`, `check_text_mode.py`, `check_names.py` (with `--text` on the seven map files) and `check_order.py` are clean; `make vc` and `make faithful vc` add no warnings.

## Approaches

- **One PR for the five maps plus their scene texts (chosen, the user's choice 2026-11-21).** The opening plays in German end to end; the received and nickname texts are reused everywhere later.
- **Only the five maps:** strictly one area, but the shared prompts would stay English mid-scene until their own PRs.
- **House and town first, the lab as its own slice:** smaller PRs, but the lab's starter scene is where most scene texts appear.
- Matching lines to Kristall automatically without review was dismissed: Polished's rewrapped lines don't line up 1:1 with Kristall's.

## Decisions

### Branch and PR

One branch from `master`, one PR on the fork, squash-merged with the PR title as subject.

### Sources, per string

1. `TERMS.md`.
2. Kristall: find the Crystal English (pret) for the Polished line, then Kristall's German at the same place in the dump (`.claude/upload/german_text_dump.txt`; texts starting with a line break or `text_ram` from the ROM). A word-for-word line is taken verbatim (re-cased, ß → ss). A rewrapped or edited line starts from Kristall's wording and changes only what differs.
3. Crystal Legacy, where its English matches (its maps are mostly English, so little).
4. Official German from later games (PokéWiki), e.g. HeartGold/SoulSilver lines where PokéWiki quotes them.
5. Own translation, flagged and listed: Lyra, her house, Elm's added lines, and any Polished change to a Crystal line. Lyra's voice: friendly, the player's peer, "du".

### Player address and questions (the user's choice, 2026-11-21)

Kristall's lines stay as they are. New lines address the player neutrally (no gendered forms for the player).

A question dialog only where there is a real choice:
- a line whose German would otherwise give the player a gender (Elm's "a talented trainer like yourself", "A champ like you"; Lyra's "the kind of trainer you've become", "You're going to be a great Champion"): the neutral wordings as options;
- jokes, wordplay and references (the Wizard of Oz TV joke): a German equivalent, with the Source explained (CLAUDE.md "Original content");
- names and abbreviations.

Every other own or edited line (about 50 texts, most of them simply "du") is written directly, flagged, and listed in the PR for review.

The user's answers (2026-11-21):
- "Champ" counts as neutral in new lines, like "ein Star": Lyra "Du wirst ein toller Champ!"; Elm "Ein Champ wie du sollte dort gut abschneiden!".
- `ElmAskBattleText`: "Ich könnte etwas Kampfpraxis gegen ein Talent wie dich gebrauchen. Wie wär's, <PLAYER>?" ("das Talent" is neuter).
- Lyra's post-League battle: "Ich will sehen, wie stark du geworden bist!".
- Lyra's TV: "Es läuft ein Film im TV: Ein Mädchen mit Zöpfen folgt einer gelben Ziegelsteinstrasse… Ich sollte mich auch auf den Weg machen!" ("gelb" added from the German dub, so the Wizard of Oz reference survives).
- While the user is offline (the night of 2026-11-21), a new real choice takes my recommended option, marked provisional in `TERMS.md` and the PR. I squash-merge this PR once every check, both builds and the play-tests pass.

### Fitting

Re-break lines first, then add a line or a box (`para`) inside the same text; never change how the text ends. Variables at their longest: `<PLAYER>` and `<RIVAL>` 7 tiles, Pokémon names 10, item names 12. Lines with `text_ram` or `<…>` values are counted by hand (CLAUDE.md "Check scripts").

### Testing

- Polished, Azahar, a normal build: the new game movie extended down the stairs: Mom's scene (Pokégear, day of week, DST), New Bark Town (Lyra, the sign), Lyra's house, the lab (starter choice, nickname question, Potion from the aide, Elm's number).
- Lyra's house and Polished's other own screens are compared with Polished's English build (Kristall has none).
- Later scenes through debug-build test hooks in a scratch clone: the Mystery Egg return, the Togepi egg, the Master Ball, a post-League visit, the Bank of Mom.
- Kristall: the kept stage saves (`vc/README.md` "Play Kristall in stages"): stage 1 covers Mom's scene, stage 2 the lab and the starter. Compared by position; screens Polished changed are compared with Polished's English build.
- Screens not reached are named in the PR.

## Left to the builder

- The exact list of scene texts, by following each scene's calls.
- How to pair Polished lines with pret's English and Kristall's dump (scripted or by hand), and the scratch table that records each string's source.
- The hooks for Elm's later visits and the Bank of Mom, and the Kristall movie extensions.
- Grouping the user's questions (the real choices above) into dialogs of up to four, one preview per text.
