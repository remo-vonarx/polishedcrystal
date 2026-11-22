# Cherrygrove: design

## Intent

The next text area after New Bark Town, in story order (`2026-11-15-german-translation-design.md`, "PR 3 onward"). It covers the first errand: from leaving New Bark Town over Route 29 and Cherrygrove City to Mr. Pokémon's house on Route 30, with the side areas that open from there (Route 46 through its gate, Cherrygrove Bay). The user chose this scope on 2026-11-21 ("3, including route 29, mr. pokemon"). Later visits in the same files (rematches, Route 30's berry house, the post-Pokédex Cherrygrove Mart) come along. So do the shared texts these scenes print, as in New Bark Town, so the trip to Mr. Pokémon plays in German.

## Size (measured 2026-11-22)

| Part | File | Text lines | Notes |
|---|---|---|---|
| Route 29 | `maps/Route29.asm` | 89 | Lyra's catching lesson and her five Poké Balls, Tuscany (Tuesday), the youngster, the fisher, fruit trees |
| Route 29/46 gate | `maps/Route2946Gate.asm` | 12 | Polished's own |
| Route 46 | `maps/Route46.asm` | 66 | trainers (Picnicker Erin's phone number and rematches), fruit trees |
| Cherrygrove City | `maps/CherrygroveCity.asm` | 113 | the Guide Gent's tour and the map card, the rival's first battle, Mystic Water |
| Pokémon Center | `maps/CherrygrovePokeCenter1F.asm` | 35 | the nurse, Polished's own NPCs |
| Mart | `maps/CherrygroveMart.asm` | 16 | |
| Speech houses | `maps/CherrygroveGymSpeechHouse.asm`, `maps/GuideGentsHouse.asm`, `maps/CherrygroveEvolutionSpeechHouse.asm` | 30 | |
| Cherrygrove Bay | `maps/CherrygroveBay.asm` | 82 | Polished's own: swimmers, a hiker, a hidden grotto |
| Route 30 | `maps/Route30.asm` | 90 | Youngster Joey's phone number, Mikey, the berry trees |
| Berry house | `maps/Route30BerrySpeechHouse.asm` | 13 | Polished's own wording (Mulch) |
| Mr. Pokémon's house | `maps/MrPokemonsHouse.asm` | 139 | the Mystery Egg, Oak and the Pokédex, the journals, post-game visits |
| Scene texts | `data/text/std_text.asm`, `data/text/common.asm`, `engine/` | about 60 | listed below |

About two thirds of the lines in the Crystal maps are word for word in Crystal's English (pret, Crystal Legacy `9a5b41a27`), so Kristall has them. Route 2946 gate, the Pokémon Center's extra NPCs, Cherrygrove Bay and the berry house are Polished's own.

### Scene texts

Traced from the scripts (the builder confirms each by following the calls):

- The nurse (`pokecenternurse`): the English `Nurse…` and `PokeComNurse…` texts in `data/text/std_text.asm`.
- The Mart (`pokemart`): the buy and sell texts the standard Mart prints.
- Phone numbers (`asknumber1m/f`, `asknumber2m/f`, `registerednumberm/f`, `numberacceptedm/f`, `numberdeclinedm/f`, `phonefullm/f`, `rematchm/f`, `rematchgiftm/f`, `packfullm/f`): the texts they print.
- Fruit trees (`fruittree_event`), cut trees (`cuttree_event`), item balls (`itemball_event`): the texts they print.
- The Guide Gent's map card, Oak's Pokédex and the Mystery Egg: the receive texts if they are shared.
- Move tutors (`Special_MoveTutor`): the tutor texts.
- The plural item text for Lyra's Poké Balls (`verbosegiveitems_unsafe POKE_BALL, 5`): see "Plurals".

Battle texts stay for the battle slice: Lyra's catching lesson runs in battle and prints battle text, as do the trainer battles.

## Goals, non-goals, anti-goals

- **Goals**
  - Every player-visible string in the 13 map files and the scene texts above is German.
  - Screens Polished kept from Crystal match Kristall by position; screens Polished changed match Polished's English layout.
- **Non-goals**
  - Violet City and later maps; battle texts; the phone calls themselves (`data/phone/`); the Pokégear's and the Pokédex's own screens.
- **Anti-goals**
  - The ones in the New Bark Town design: no changed box endings or script flow, no rewritten Kristall line that fits, no dropped information.

## Constraints

As for New Bark Town (CLAUDE.md, `TERMS.md`, Huffman tables, long script jumps, the four checkers, `make vc` and `make faithful vc` without new warnings).

## Approaches

- **One PR for the 13 maps plus their scene texts (chosen, the user's choice 2026-11-21).** The first errand plays in German end to end.
- **Cherrygrove City and Route 29 only, Route 30/46 and the Bay later:** smaller, but Mr. Pokémon's house is the errand's goal.
- **Mr. Pokémon's house in its own PR:** it is the largest file, but it holds Oak's Pokédex scene, which the trip leads up to.

## Decisions

### Branch and PR

One branch from `master` after New Bark Town is merged. The PR stays open for the user's review (standing order for the night of 2026-11-21).

### Sources, player address and questions

As for New Bark Town: Kristall verbatim where the English matches Crystal's, own translation flagged and listed, neutral player address in new lines, question dialogs only for real choices. While the user is offline, a real choice takes my recommended option, marked provisional in `TERMS.md` and the PR.

Already decided (the user, 2026-11-21): the Great Tree of Cherrygrove is "Grosser Baum von Rosalia" ("Das ist der Grosse Baum von Rosalia!"). Lure items are "…parfüm"; a generic "Parfüm" in dialogue is my call.

### Plurals

The plural table (`data/text/plural_table.asm`) holds English suffix rules, so Lyra's gift prints "5 Pokéballs". German needs its own rules ("ball" → "bälle", "trank" → "tränke", "e" → "en", …), checked against every item name. It is data, not code, but it changes every plural item text in the game. **Open question for the user**; until answered, the PR proposes a German table as a separate commit, marked provisional.

### Fitting and testing

Fitting as for New Bark Town. Testing:
- Polished, Azahar: a save after the lab (made once by movie, kept in `vc/local/saves/`) as the start of short movies: Route 29 with Lyra, Cherrygrove (the Guide Gent, the nurse, the Mart), Route 30 and Mr. Pokémon's house (the egg, Oak, the Pokédex).
- Kristall: stage saves extended past the lab to Cherrygrove and Mr. Pokémon (`vc/README.md` "Play Kristall in stages").
- The side areas (Route 46, the Bay, the berry house, rematches) through debug-build hooks where time allows; screens not reached are named in the PR.

## Left to the builder

- The exact list of scene texts, by following each scene's calls.
- The German plural rules and their test against the item list.
- The save-based movies and the hooks.
