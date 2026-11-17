# Terms

Settled English → German decisions for the Translation. Read this before every task, and add each new decision here.
The general rules are in `CLAUDE.md` (Project decisions).

| English | German | Where | Source / note |
|---|---|---|---|
| Continue | Weiter | Main menu | Kristall |
| New Game | Neues Spiel | Main menu | Kristall |
| New Game+ | Neues Spiel+ | Main menu | Own, from Kristall's "Neues Spiel" |
| Options | Optionen | Main menu | Kristall |
| Music Player | Musik Player | Main menu | Own; the user's wording |
| Time not set | Uhr nicht gestellt | Main menu | Kristall |
| Yes / No | Ja / Nein | Yes/No box, option values | Kristall; option values padded to 4 tiles ("Ja  ") |
| Nature | Wesen | Initial options | Official (PokeAPI `nature`, de) |
| Ability | Fähigkeit | Initial options | Official |
| Move | Attacke | Initial options | Kristall |
| Stat | Wert | Initial options | Short form where "Statuswert" doesn't fit |
| EVs | Fleisspunkte | Initial options | The user's choice: the official term up to Gen 4 (PokéWiki), chosen over the modern "Basispunkte" (ADR 0002 exception). No abbreviation: "BP" means Battle Points in Polished |
| IVs | DVs | Initial options | The user's choice: Gen 2's own term, matching the 0–15 scale |
| Stat exp | Status-EP | Initial options | The user's choice; no official German term exists (PokéWiki) |
| Exp. Points | EP, Erfahrungspunkte | Initial options | Kristall |
| Exp. Candy | EP-Bonbon | Initial options | Official (SV) |
| Rare Candy | Sonderbonbon | Initial options | Kristall |
| Shiny | schillernd | Initial options | Official |
| Affection | Zuneigung | Initial options | Official (Gen 6) |
| Real-time clock | Echtzeituhr | Initial options | Own |
| Phys/Spcl split | Phys/Spez-Split | Initial options | Own |
| Experience gain | EP-Zuwachs | Initial options | Own |
| Affection bonus | Zuneigungsbonus | Initial options | Own |
| Perfect stats | Perfekte Werte | Initial options | Own |
| Traded PKMN obey | Tausch-PKMN folgen (`Tausch-<PK><MN> folgen`) | Initial options | Own; "gehorchen" doesn't fit the 17 tiles |
| Evolve in battle | Kampfentwicklung | Initial options | Own |
| Color variation | Farbvariation | Initial options | Own |
| Done | Fertig | Options menus | Kristall |
| Pokémon Stadium | PKMN Stadium (`<PK><MN> Stadium`) | Initial options | The user's choice |
| Morning / Day / Evening / Night | Vormittag / Tag / Abend / Nacht | Clock, Pokégear, summary | Kristall (Vormittag, Tag, Nacht); Abend own, as Kristall has no evening |
| o'clock / min. | Uhr / min. | Clock | Kristall |
| Prof. Elm | Prof. Lind | Everywhere | Kristall; written with a space, as in CLAUDE.md's casing example |
| Prof. Oak | Prof. Eich | Everywhere | Kristall |
| Trainer Card | Trainerpass | Everywhere | Kristall |
| Your name? / Rival's name? / Box name? | Dein Name? / Gegner-Name? / Box Name? | Naming screen | Kristall |
| What's trendy? | Was ist hip? | Naming screen (Shamouti Hotel artist) | Own; the user's choice |
| Shift / Del / End | Umsch / Lösch / Ende | Naming screen key row | Lösch and Ende from Kristall; Umsch own. Columns 2, 8, 14 as in Kristall, to fit the 5-tile cursor frames |
| Chris / Kris / Crys / Krys | Chris / Krista / Crys / Krys | Default player names | Kristall (Chris, Krista); Crys and Krys only exist in Polished and stay |
| DJ Mary | DJ Margit | Radio | Kristall |
| Prof. Oak's Pokémon Talk | Prof. Eichs #mon-Talk | Radio | Kristall |
| Pokémon Channel | #mon-Programm | Radio | Kristall |
| Town Map | Karte | Player's room poster | Kristall |
| Item | Item, Items | Everywhere | Kristall |
| `<PLAYER>`'s PC | PC von `<PLAYER>` | Pokémon Center PC menu | Kristall; 14 tiles, so the PC menus end one column further right, as Kristall's |
| Bill's PC | Bills PC | PC menu, everywhere | Kristall |
| Prof. Oak's PC | Eichs PC (menu), Prof. Eichs PC (text) | Pokémon Center PC | Kristall |
| Hall of Fame | Ruhmeshalle | PC menu, everywhere | Kristall |
| Turn Off, Log Off | Ausloggen | PC menus | Kristall uses it for both |
| Withdraw / Deposit / Toss Item | Item aufnehmen / Item ablegen / Item wegwerfen | Player's PC menu | Kristall; its texts say "mitnehmen" for withdrawing |
| Mail Box | Briefkasten | Player's PC menu | Kristall |
| Decoration | Dekoration | Player's PC menu | Kristall |
| Pokémon Storage System | #mon-Lagerungs-System | Bill's PC, everywhere | Kristall, re-cased with its hyphen; the user's choice over "Lagerungssystem" |
| Item Storage System | Item-Lagerungs-System | Player's PC | Kristall, as above |
| Pokédex Rating System | #dex-Bewertung | Prof. Oak's PC | Kristall |
| Cancel | Zurück | Item lists (every scrolling menu) | Kristall |
| _N_ _items_ (a quantity) | _N_ x `<ITEM>` | PC and toss texts; every quantity text | Kristall: the number before the name, singular verb, no plural ending (`text_plural` dropped) |
| Clear all save data? | Spielstand löschen? | Title screen (Up+B+Select) | Kristall |
| Reset the clock? | Uhr neu stellen? | Title screen (Down+B) | Kristall |
| Initial (game) options | Spieloptionen | Title screen (Left+B) | Own; the user's choice. The initial-options screen itself has no title |
| Pokémon Journal | #mon-Journal | Player's room bookshelf; about 40 more places | The user's spelling, chosen over Kristall's "#MON JOURNAL" (6c:4528) |
| Pokémon names | PokeAPI `pokemon-species` (de), mixed case | `data/pokemon/names.asm`, everywhere | Official; Kristall's 251 equal the modern names apart from capitals. PokéWiki's list agrees on all 289. Upstream's cut "Dudunsparc" is "Dummimisel" in full |
| Egg | Ei | Species table, every new egg's nickname (gift, Odd Egg, Wonder Trade, Day-Care) | Kristall |
| Bad Egg | Schl. Ei | Nickname of a corrupted box Pokémon | The user's choice: the official "Schlechtes Ei" (PokéWiki) shortened to fit 10 characters; the PC's release check tests its "S" |
| A–Z Pokédex order | German names in alphabetical order | Pokédex | A plain sort, as Kristall's own list (ROM 10:4c5e); hyphens and digits sort as in Polished's English list (Ho-Oh, Hoothoot; Porygon, Porygon-Z, Porygon2) |
| Types | Normal, Kampf, Flug, Gift, Boden, Gestein, Käfer, Geist, Stahl, Feuer, Wasser, Pflanze, Elektro, Psycho, Eis, Drache, Unlicht, Fee | Everywhere | Official (PokeAPI, PokéWiki). Modern "Drache" over Kristall's "Drachen" (ADR 0002) |
| Egg groups | Monster, Feld, Humanotyp, Mineral, Amorph, Ditto, Unbekannt; the type names for Bug, Flying, Fairy, Grass, Dragon; Faithful: Wasser 1–3 | Pokédex | Official (PokeAPI) |
| Amphibian / Fish / Invertebrate | Amphibie / Fisch / Wirbellos | Pokédex (non-Faithful egg groups) | Own; the user's choices for Polished's renamed Water 1–3 |
| Ability names | PokeAPI `ability` (de), ss for ß | Summary, Pokédex, battle | Official. PokéWiki's Gen 9 names where PokeAPI still has the old ones: Gleichmut (Own Tempo), Taumelschritt (Tangled Feet), Giftheilung (Poison Heal) |
| Snow Warning | Hagelalarm | Ability | The user's choice: Polished's Snow Warning summons hail, so its Gen 4–8 name stays, over Gen 9's "Schneeschauer" (ADR 0002 exception) |
| Nature names | PokeAPI `nature` (de), ss for ß ("Mässig") | Summary | Official |
| Type labels (graphics) | NORMAL, KAMPF, FLUG, GIFT, BODEN, GESTEIN, KÄFER, GEIST, STAHL, FEUER, WASSER, PFLANZE, ELEKTRO, PSYCHO, EIS, DRACHE, UNLICHT, FEE | `gfx/battle/types.png`: summary, Pokédex, battle move info, party move menu | The user's choice: Crystal Legacy's German letters (`gfx/pokedex/types_light.png`), full names with the 7-letter ones squeezed, white on Polished's black pills; DRACHE is Legacy's DRACHEN without its N. KÄFER's Ä stays inside the pill (the user's choice): dots on the first letter row over a 4-row A, since Legacy's dots on the pill's edge showed as notches |
| Move names | PokeAPI `move` (de), ss for ß | Everywhere | Official; PokéWiki's Attacken-Liste agrees on all 253. Faithful's Rock Smash: Zertrümmerer |
| Item names | PokeAPI `item` (de), ss for ß | Bag, marts, everywhere | Official; PokéWiki's item lists (Karmesin/Purpur, Schwert/Schild, Sonne/Mond, HeartGold/SoulSilver) agree on all. Faithful's RageCandyBar, Honey, Guard Spec.: Wutkeks, Honig, Megablock |
| Mails | Blumenbrief, Surferbrief, Cyanbrief, Abbildbrief, Herzbrief, Anara-Brief, Morph-Brief, Kobaltbrief, Melodiebrief, Trugbrief | Items | Kristall, re-cased: Gen 2-only items, no modern name |
| Brick Piece / Berserk Gene / GS Ball | Ziegelstein / Berserk-Gen / GS-Ball | Items, key items | Kristall, re-cased: Gen 2-only |
| Apricorns | Aprikoko Rot, Aprikoko Blu, Aprikoko Glb, Aprikoko Grn, Aprikoko Wss, Aprikoko Swz, Aprikoko Pnk | Items | Kristall's short forms. The modern names (Aprikoko Blau … Aprikoko Schwarz) are 13–16 characters, so Kristall's forms are their Abbreviation; red's "Aprikoko Rot" is the modern name |
| Exp. Candy XS … XL | EP-Bonbon XS, S, M, L, XL | Items | Official (PokeAPI) |
| Health Wing … Clever Wing | Heilfeder, Kraftfeder, Abwehrfeder, Flinkfeder, Geniefeder, Espritfeder | Items | Official (PokeAPI) |
| Pokégear | #Com (PokéCom) | Key item, everywhere | Kristall ("#COM") |
| Radio Card | Radio-Modul | Pokégear card | Kristall |
| Item / Ball / Key Pocket | Item-Tasche / Ball-Tasche / Basis-Items | "put … in the … Pocket" texts | Kristall |
| HM | VM | HM item names ("VM01"), TM pocket | Kristall ("VM"); the user's choice (2026-11-17). The bold-H glyph (`<BOLDH>`, `$CB`) is a bold V in every font, so it also marks the hidden ability as "V" (Versteckte Fähigkeit) on the summary and in the Pokédex |
| A–Z item and TM order | German dictionary order (DIN 5007-1): case-insensitive, Ä/Ö/Ü sorted as A/O/U, é as e | Bag "sort by name", TM pocket | The user's choice (2026-11-17): "Aprikokobox, Äther, Aufwecker"; "Turboball, Überreste, Upgrade" |
| Map Card / Expn.Card | Karten-Modul / Zusatzset | Pokégear cards | Kristall (ROM 67:40a2, 1f:7349), re-cased |
