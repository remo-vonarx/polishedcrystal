# Violet City: design

## Intent

The next text area after Cherrygrove, in story order (`2026-11-15-german-translation-design.md`, "PR 3 onward"). It covers the way to the first badge and on to Union Cave's door: Route 31, Violet City with its Gym, Sprout Tower and Earl's Academy, the egg from Elm's aide, Route 32 and its Pokémon Center, and the side areas that open from there (Dark Cave's Violet entrance, Polished's Violet Outskirts). The user chose this scope on 2026-11-22 (the Violet area "plus Route 32"). Later visits in the same files (rematches, post-game texts) come along. So do the shared texts these scenes print, so the first Gym plays in German.

## Size (measured 2026-11-22)

| Part | File | Text lines | Crystal's English |
|---|---|---|---|
| Route 31 | `maps/Route31.asm` | 131 | 51% |
| Route 31 gate | `maps/Route31VioletGate.asm` | 6 | 50% |
| Route 36 gate | `maps/Route36VioletGate.asm` | 15 | Polished's gate at Violet's west exit (my call: it is walked through from Violet; Route 36 itself stays out) |
| Violet City | `maps/VioletCity.asm` | 77 | 59% |
| Gym | `maps/VioletGym.asm` | 98 | 75% |
| Mart | `maps/VioletMart.asm` | 16 | 93% |
| Pokémon Center | `maps/VioletPokeCenter1F.asm` | 73 | 58% |
| Earl's Academy | `maps/EarlsPokemonAcademy.asm` | 146 | 80% |
| Houses | `maps/VioletNicknameSpeechHouse.asm`, `maps/VioletOnixTradeHouse.asm` | 22 | 64% |
| Sprout Tower | `maps/SproutTower1F.asm`, `maps/SproutTower2F.asm`, `maps/SproutTower3F.asm` | 187 | 78% |
| Dark Cave | `maps/DarkCaveVioletEntrance.asm` | 41 | 9% |
| Violet Outskirts | `maps/VioletOutskirts.asm`, `maps/VioletOutskirtsHouse.asm` | 47 | 9% (Polished's own cemetery) |
| Route 32 | `maps/Route32.asm` | 255 | 67% |
| Route 32 Pokémon Center | `maps/Route32PokeCenter1F.asm` | 58 | 43% |
| Scene texts | `data/text/std_text.asm`, `data/text/common.asm`, `engine/` | to trace | listed below |

About 1,175 lines in 18 map files, two thirds word for word in Crystal's English (measured against Crystal Legacy's English at `9a5b41a27`), so Kristall has them.

### Scene texts

Traced from the scripts (the builder confirms each by following the calls; texts already German from slices 1 and 2 stay):

- Gym statues (`gymstatue1`, `gymstatue2`, `gymstatue3`): the `GymStatue_…` texts in `data/text/std_text.asm`.
- Gifts: `verbosegivetmhm` (Falkner's TM, the Elder's TM Flash, Route 32's TM Roar), `verbosegivekeyitem` (the Old Rod), `verbosegiveitem`, `giftm`, `giveegg` and `givebadge` around Elm's aide and Falkner: the texts they print.
- Badge names (`data/events/badge_names.asm`, printed by `_ReceivedTheBadgeText`): the whole table of 16, from Kristall (my call: one name table, all official; added to `utils/check_names.py`'s `TABLES` so it stays checked).
- In-game trades (`trade`, Kyle in the trade house): all four dialogue sets `_NPCTradeIntroText1`–`4` and their follow-ups in `data/text/common.asm`, from Kristall, and the trade screens' texts where still English (my call: one shared block; only Kyle's set is tested, the others named as not reached).
- Rock Smash rocks (`smashrock_event`, `SmashRockScript` in `engine/events/std_scripts.asm`), cut trees, fruit trees, item balls: their texts, where still English.
- Phone numbers, female variants (`asknumber1f`, `asknumber2f`, `registerednumberf`, `numberacceptedf`, `numberdeclinedf`, `phonefullf`, `rematchf`): where still English.
- Move tutors, the nurse, the Mart: German since slice 2.

Battle texts stay for the battle slice. Trainers' seen, beaten and after-battle lines live in the map files and are part of this slice.

## Goals, non-goals, anti-goals

- **Goals**
  - Every player-visible string in the 17 map files and the scene texts above is German.
  - Screens Polished kept from Crystal match Kristall by position; screens Polished changed match Polished's English layout.
- **Non-goals**
  - Route 32's coast and its house, the Ruins of Alph and their gates, Union Cave, Route 36; battle texts; the phone calls themselves (`data/phone/`); the mail screen; the status graphics (`gfx/battle/status.png`) Earl's blackboard refers to (the battle slice).
- **Anti-goals**
  - The ones in the New Bark Town design: no changed box endings or script flow, no rewritten Kristall line that fits, no dropped information.

## Constraints

As for Cherrygrove (CLAUDE.md, `TERMS.md`, Huffman tables, long script jumps, the four checkers, `make vc` and `make faithful vc` without new warnings).

## Approaches

- **The Violet area plus Route 32 and its Pokémon Center in one PR (chosen, the user's choice 2026-11-22).** The slice runs from Route 31 to Union Cave's door, so the first Gym and the Old Rod play in German.
- **The Violet area only:** about 850 lines, Route 32 with slice 4.
- **Without Dark Cave's entrance and Violet Outskirts:** about 90 lines less, side areas later.

## Decisions

### Branch and PR

One branch `violet` from `master` after Cherrygrove (merged as `70a4fa6c7`). I squash-merge the PR myself once it is green: both builds at the baseline, checks clean, screens seen in Azahar, the final review's findings fixed (the user's choice 2026-11-22).

### Profile changes (first commit)

- **Test entry points:** one entry for the hook method: a never-committed hook in a scratch clone's `maps/NewBarkTown.asm` that warps from the New Bark Town save in `vc/local/saves/polished-nbt-town/` to any scene (accepted 2026-11-22).
- **Previous translations to reuse:** Crystal Legacy's `main` is now German almost throughout (328 of 333 maps, the phone texts, most of `data/text/`, as of `ca2a1775b`, 2026-11-21); its English before translation is at `9a5b41a27`. The row says so (the user's choice 2026-11-22). It still writes names in capitals and ß.

### Sources, player address and questions

As for Cherrygrove: Kristall verbatim where the English matches Crystal's; Crystal Legacy's German (`main`) where Kristall lacks a line and Crystal Legacy's English (`9a5b41a27`) matches Polished's; own translation flagged and listed; neutral player address in new lines. The user is online: real choices are collected and asked together in question dialogs once the drafts are done, while the rest goes on.

### Fitting and testing

Fitting as for Cherrygrove. Testing in Azahar from the New Bark Town save with the hook (warps, `farscall` of a map script, `farwritetext` of a map text): the Gym (Falkner, the badge, the TM, the statue), Sprout Tower (the Elder and Flash), the egg from Elm's aide, Earl's Academy and its blackboard, Route 31 and Route 32 gifts (the Old Rod, TM Roar), Kyle's trade, the Outskirts.

The Kristall reference, by kind of screen (my call, as in slice 2):
- Dialogue: Kristall's own line breaks in the same 18-tile box, so it matches by position by construction.
- Menus (Earl's blackboard, `menu_coords 0, 0, 11, 8`, 3 rows × 2 columns, 5 tiles apart): Kristall's box and entries read from its ROM, as for the Mart (05:5f93); a wider box is proposed to the user only if the German entries need it.
- The trade screens and the badge: Polished's English screen.
- Kristall in the game: not reached; the stage saves end at Elm's lab, and Violet is a long walk with wild encounters. Named in the PR.

Screens not reached are named in the PR.

## Left to the builder

- The exact list of scene texts, by following each scene's calls.
- Which lines Crystal Legacy's German covers that Kristall doesn't.
- The hook cases.
