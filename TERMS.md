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
| A–Z item and TM order | German dictionary order (DIN 5007-1): case-insensitive, Ä/Ö/Ü sorted as A/O/U, é as e; a space, "-" and "." sort before letters | Bag "sort by name", TM pocket | The user's choice (2026-11-17): "Aprikokobox, Äther, Aufwecker"; "Turboball, Überreste, Upgrade". Punctuation (2026-11-18): "AP-Plus, AP-Top, Apikobeere", "Heiss-Orb, Heissbrocken", "Schwä.schutz, Schwarzgurt", as Upstream's Bag sorts it ("Black Belt, Black Sludge, BlackGlasses"; "Exp.Share, Expert Belt") |
| Map Card / Expn.Card | Karten-Modul / Zusatzset | Pokégear cards | Kristall (ROM 67:40a2, 1f:7349), re-cased |
| Lagging Tail | Schwerschwf. | Item | Official abbreviation: the item's name from Diamond/Pearl to Omega Ruby/Alpha Sapphire (PokéWiki); the modern "Schwerschweif" is 13 characters |
| Over-limit names Kristall has | Kristall's name | Moves, items, key items | The user's rule (2026-11-18), an ADR 0002 exception: when the Modern name is over its Name limit and Kristall has its own name, Kristall's name wins over an Abbreviation. Glare: Giftblick; Sharp Beak: Hackattack; BlackGlasses: Schattenglas; Cleanse Tag: Schutzband; Dragon Scale: Drachenhaut; Card Key: Türöffner |
| X Attack, X Defend, X Speed, X Sp.Atk, X Sp.Def, X Accuracy, Dire Hit, Guard Stats | X-Angriff, X-Abwehr, X-Tempo, X-Spezial, X-SpezialVer, X-Treffer, Angriffplus, Megablock | Items (battle) | The user's choice (2026-11-18): one set, the Gen 4–6 names, which are Kristall's where it had them (X-SpezialVer is Gen 4–6's X Sp. Def). ADR 0002 exception; it also replaces the modern X-Initiative, X-Sp.-Ang. and X-Sp.-Vert. |
| Itemfinder | Detektor | Key item, dialogue | Kristall; the user's choice (ADR 0002 exception): Polished keeps the Gen 1–3 English name and the Gen 3 behaviour |
| Shell Bell / Lift Key | Seegesang / Liftöffner | Item / key item | Official older names (Gen 3–7; Gen 1 and FireRed/LeafGreen), the user's choice over the shortened modern Muschelglocke and Aufzugsschlüssel (ADR 0002 exception). Liftöffner matches Türöffner and Kelleröffner |
| Fähigkeit (inside names) | Fäh. | Skill Swap: Fäh.-Tausch; Ability Cap: Fäh.-Kapsel; AbilityPatch: Fäh.Pflaster | Official word abbreviation ("Fäh.-Appell", Black/White–X/Y); a hyphen where it fits (the user's choice; "Fäh.-Pflaster" would be 13) |
| Zen Headbutt | Zenkopfstoss | Move | Official "Zen-Kopfstoß" without its hyphen, 12 with ss (Duden writes Zenbuddhismus closed too) |
| Pewter Crunchies | Marmoria-Kr. | Item | Official "Marmoria-Kräcker" shortened; the user's choice, keeping the city whole |
| Shortened item names | Schwä.schutz (Weak Policy), Offens.weste (Assault Vest), Schutzpolst. (Protect Pads), Plat.schuhe (Heavy Boots), Fehl.schutz (BlundrPolicy), Bizarroserv. (Room Service), Neutralschm. (Clear Amulet), Gez. Würfel (Loaded Dice) | Items | Official names over 12, shortened (the user's choices). Bizarroserv. and Neutralschm. keep the link to Bizarroraum (Trick Room) and Neutraltorso (Clear Body) |
| Bottle Cap | Kronkorken | Item | Official "Silberkronkorken" without "Silber": Polished has no Gold Bottle Cap, and the English is "Bottle Cap" (the user's choice) |
| Linking Cord | Linkkabel | Item | Own (the user's idea) over the official "Verbindungsschnur" (17): mirrors the English pun on the link cable; Kristall calls the hardware "Link-Kabel" |
| Fresh Snack / Fury Strikes / HealingLight | Frischsnack / Furienhieb / Heillicht | Moves (Polished's own) | Own |
| Cake of Rage / Sweet Honey / Guard Stats | Wutkeks / Honig / Megablock | Items, normal build | The official names of the same items, as in Faithful |
| Mulch / Mint Leaf / Odd Souvenir / Armor Suit | Mulch / Minzblatt / Kuriosum / Rüstung | Items (Polished's own) | Own. Mulch is German too, as in the official mulch family; Minzblatt pairs with Silberblatt and Goldblatt; Kuriosum matches Elm's "oddity" |
| Wing Case / Type Chart / OrangeTicket | Federbox / Typentabelle / Orangeticket | Key items (Polished's own) | Own |
| Harsh / Potent / Malign Lure | Herbparfüm / Kraftparfüm / Unheilparfüm | Key items, the Lure menu at Cherrygrove Bay (`engine/menus/lure_menu.asm`) | Own, after the official Lure item "Lockparfüm" (Let's Go, Sword/Shield); "Herb-Lockparfüm" and the like are over the 12-character limit. The user kept "…parfüm" (2026-11-18) |
| Medicine / TM / Berry Pocket | Medizin-Tasche / TM/VM-Tasche / Beeren-Tasche | "put … in the … Pocket" and "… is full" texts | Official HeartGold/SoulSilver (Medicine, Berry); Kristall's TM-Tasche plus the VMs. A pocket name prints on a text line of its own, so its limit is 14 |
| Bag tabs (graphics) | Items · Med. · Bälle · TM/VM · Beeren · Bas. | `gfx/pack/pack_top.png` | The user's choices; Bas. is the only Key label that fits its 16 px |
| Bag picture labels (graphics) | Items, Medizin, Bälle, TM/VM, Beeren, Basis | `gfx/pack/pack_{m,f,b,x}{0-5}.png`, all four bag styles | The user's choice |
| Type Chart (graphics) | Rows: the full type names, in pills widened by 4 px. Column heads: NRML KMPF FLUG GIFT BODN GEST KÄFR GEIS STHL FEUR WASR PFL ELEK PSYC EIS DRCH UNLI FEE. Corner: ANGR / VER | `gfx/type_chart/` | The user's choices. No official German type abbreviations exist (Kristall has no Type Chart); GEST and PFL echo "Gest." (XD) and "Pfl." (Kristall's Miracle Seed). ANGR / VER are Kristall's stat labels (ROM 14:4ba7, 0d:64a6) |
| Place names | Kristall's names, re-cased: "Neuborkia", "Rosalia City", "See des Zorns" | `data/maps/landmarks.asm`: signs, Pokégear, Town Map, Fly, summary, scripts | Kristall (its map's place names, read from the ROM). Mixed case, "des"/"der" lowercase inside a name; ss for ß ("Siegesstrasse"). Kristall's breaks stay where they were: its line break as `¯`, its soft hyphen as `<SHY>` ("Einheits<SHY>tunnel"), its break after a hyphen as `<WBR>` ("Flegmon-<WBR>Brunnen") |
| Bell Tower / Pokémon Mansion / Diglett's Cave / Indigo Plateau | Glockenturm / Pokémon-Villa / Digda-Höhle / Indigo-Plateau | Place names | Modern names (ADR 0002) over Kristall's Zinnturm / PKMN-Haus / Digdas Höhle / Indigo Plateau: Glockenturm from HeartGold/SoulSilver, the other three from Let's Go |
| Underground Path | Unterführung | Place names | Modern name (Let's Go, PokéWiki) over Kristall's map label "Untergrund" and its signs' "Tunnelpfad" |
| Bellchime Trail / Cliff Edge Gate / Navel Rock / Faraway Island / Sinjoh Ruins | Glockenklangpfad / Felsklippentor / Nabelfels / Ferneiland / Sinjoh-Ruinen | Place names | Official (HeartGold/SoulSilver, Emerald; PokéWiki). Faraway Island is "Ferneiland"; "Fern-Eiland" is Outcast Island in FireRed/LeafGreen |
| House of Souls | Ruhestätte | Place names | Kristall's sign for the same house; the Modern "Haus der Erinnerungen" (HeartGold/SoulSilver) is 21 characters (ADR 0002 amendment) |
| Mystri Stage | Trysteriumaltar | Place names | Official term from HeartGold/SoulSilver (Cynthia at the Sinjoh Ruins, PokéWiki); the game has no map name for it |
| Pokémon Lab | Pokémon-Labor | Place names | Official (FireRed/LeafGreen, Let's Go) |
| Cerulean Cave | Azuria-Höhle (`Azuria-<WBR>Höhle`) | Place names | Kristall, with a break Kristall's map didn't need |
| Shamouti Island / Fire / Ice / Lightning Island / Valencia Island | Shamouti / Insel des Feuers / Insel des Eises / Insel der Blitze / Valencia Insel | Place names | Anime names (Pokémon: The Movie 2000, the Orange Islands; PokéWiki). The islands: PokéWiki's section titles, the user's choice over its intro's "Feuer-, Eis- und Donnerinsel" |
| Fast Ship | M.S. Aqua | Place names | Modern name (HeartGold/SoulSilver); the user's choice over Kristall's "Schnellboot" |
| Silver Cave | Silberhöhle | Place names | Kristall; the user's choice (ADR 0002 exception) over HeartGold/SoulSilver's "Silberberg": Polished keeps the Gen 2 English |
| Pokémon League Gate | PKMN-Liga-Empfang (`<PK><MN>-Liga-<WBR>Empfang`) | Place names | Kristall's Route 26 sign ("#MON LIGA EMPFANG") with Kristall's Abbreviation PKMN; "Pokémon-Liga-Empfang" is 20. The user's choice |
| Pokémon League (Fly) | Pokémon-Liga | Fly's own name for the gate (`engine/pokegear/pokegear.asm`) | Official (PokéWiki: "früher Pokémon Liga") |
| Where? (Fly) | Wo? | Fly map | Kristall (its Fly map, 24:5c15) |
| Battle Factory (summary) | Kampffabrik | Place of capture | Official (Emerald, Platinum, HeartGold/SoulSilver) |
| Event #mon (summary) | Pokémon Event (`#mon Event`) | Place of capture | Official (HeartGold/SoulSilver, X/Y); the Modern "Pokémon-Veranstaltung" (BDSP, Scarlet/Violet) is 21. The user's choice |
| Cerulean Cape | Kap bei Azuria | Place names | Kristall's sign "KAP bei AZURIA CITY" without "City": 19, and Fly has 16. The user's choice |
| Celadon University | Prismania-Uni | Place names | Anime name "Prismania-Universität" (21) with one word shortened. The user's choice |
| Cliff Cave | Felsschlundhöhle (`Felsschlund<WBR>höhle`) | Place names | Official (HeartGold/SoulSilver). Neither hyphen split fits the Pokégear's 11 tiles, so it breaks there without a hyphen ("Felsschlund" / "höhle"); the user kept the English layout |
| Violet Outskirts | Viola-Stadtrand | Place names | Own; the user's choice |
| Cinnabar Volcano | Zinnobervulkan | Place names | Own, written like Kristall's "Zinnoberinsel"; the user's choice |
| Lucky Island | Glücksinsel | Place names | Own; the user's choice |
| Yellow Forest | Gelber Wald | Place names | Own, a nod to the Gelbe Edition; the user's choice |
| Quiet Cave | Stille Höhle | Place names | Own; the user's choice |
| Cherrygrove Bay / Goldenrod Harbor | Rosalia-Bucht / Dukatia-Hafen | Place names | Own, Kristall's city compounds ("Azuria-Höhle"); the user's choice |
| Magnet Tunnel | Magnettunnel | Place names | Own; the user's choice |
| Route 32 / 34 / 35 Coast | Route 32 Küste / Route 34 Küste / Route 35 Küste | Place names | Own; the user's wording |
| Stormy Beach / Rocky Beach / Beautiful Beach / Warm Beach | Sturmstrand / Felsstrand / Prachtstrand / Warmer Strand | Place names | Own; the user's choice |
| Murky Swamp | Düstersumpf | Place names | Own; the user's choice |
| Rugged Road | Steiniger Steig | Place names | Own, keeps the alliteration; the user's choice |
| Snowtop Mountain | Schneegipfel | Place names | Own; the user's choice |
| Scary Cave / Dim Cave | Gruselhöhle / Dämmerhöhle | Place names | Own; Dämmerhöhle stays apart from Kristall's "Dunkelhöhle". The user's choice |
| Uraga Channel | Uraga-Kanal | Place names | Own, the real channel's German name; the user's choice |
| Noisy Forest | Summender Wald | Place names | Own, from the forest's buzzing bugs; the user's choice |
| Shrine Ruins | Tempelruinen | Place names | Own; no game uses it on its own (Legends: Arceus has "Elysien-Tempelruinen"). The user's choice |
| Shamouti Tunnel / Shamouti Coast | Shamouti-Tunnel / Shamouti-Küste | Place names | Own; the user's choice |
| Trainer classes (list) | — | `data/trainers/class_names.asm` | Modern name (PokéWiki: the latest game with that English class), feminine for a female entry; Kristall's name where the Modern one is over 12 bytes or 14 tiles; own names asked. `#mon` (Pokémon) and `<PK><MN>` (PKMN) as in the charmap |
| PKMN Trainer | Trainer (cal, jacky, red, riley, buck, kukui) / Trainerin (carrie, euna, leaf, lyra1, lyra2, cheryl, marley, mira, anabel, yellow) | Trainer classes | Trainer: Kristall ("TRAINER"; "Pokémon-Trainer" is 15 tiles); Trainerin: the user's choice. Jacky, the non-binary player picture, gets "Trainer": the user's choice |
| Leader | Leiter (falkner, bugsy, morty, chuck, pryce, brock, lt_surge, blaine, blue, blanche, spark_t) / Leiterin (whitney, jasmine, clair, misty, erika, janine, sabrina, candela) | Trainer classes | Leiter: Kristall ("LEITER"; "Arenaleiter Hartwig" would be 19); Leiterin: the user's choice ("Arenaleiterin" is 13). Pokémon GO's Blanche and Spark get "Leiter", Candela "Leiterin", following the English; Blanche (no official gender) the user's choice |
| Elite Four | Top Vier | Trainer classes | Modern name (Karmesin/Purpur) |
| Champion | Champ | Trainer classes | Modern name (Karmesin/Purpur) |
| Strange | Seltsamer | Trainer classes | Own; the user's choice: the rival's first battle reads "Seltsamer Junge" (name "Junge"). HeartGold/SoulSilver show it as "Passant Junge" |
| Rival | Rivale | Trainer classes | Modern name (HeartGold/SoulSilver) |
| Youngster | Knirps | Trainer classes | Modern name (Karmesin/Purpur); Kristall "TEENAGER" |
| Bug Catcher | Käfersammler | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle) |
| Camper | Camper | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle) |
| Picnicker | Picknicker | Trainer classes | Kristall and HeartGold/SoulSilver ("PICKNICKER"); the Modern "Picknickerin" (12) leaves 5 tiles for a name. The user's choice |
| Twins | Zwill. | Trainer classes | Own abbreviation of the Modern "Zwillinge" (9), whose pair names reach 10; Kristall writes "ZWIL.". The user's choice |
| Fisherman | Angler | Trainer classes | Modern name (Angler: Strahlender Diamant/Leuchtende Perle) |
| Bird Keeper | Vogel-Profi | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle); Kristall "VOGELFÄNGER" |
| Hiker | Wanderer | Trainer classes | Modern name (Wanderer: Strahlender Diamant/Leuchtende Perle) |
| Rocket | Rocket | Trainer classes | Kristall ("ROCKET") |
| Pokéfan | Pokéfan | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle) |
| Officer | Polizist (officerm) / Polizistin (officerf) | Trainer classes | Modern name (Legenden: Z-A); Kristall "WÄCHTER" |
| Nurse | Pflegerin | Trainer classes | Modern name (Schwarz 2/Weiß 2) |
| PokéManiac | Pokémaniac | Trainer classes | Modern name (Karmesin/Purpur) |
| Cosplayer | Cosplayerin | Trainer classes | Own; the user's choice |
| Super Nerd | Tüftler | Trainer classes | Modern name (Let's Go, Pikachu!/Evoli!); Kristall "STREBER" |
| Lass | Göre | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle) |
| Beauty | Schönheit | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle) |
| Bug Maniac | Käfermaniac | Trainer classes | Modern name (Omega Rubin/Alpha Saphir) |
| Bug Catcher (Battle Tower) | Käfersamml. | Trainer classes | Abbreviation in Battle Tower battles only (`data/battle_tower/short_class_names.asm`), so Käfersamml. Darwin and Tajiri fit 18 tiles; the user's choice (2026-11-21) |
| Bug Maniac (Battle Tower) | Käferman. | Trainer classes | Abbreviation in Battle Tower battles only, so Käferman. Satoshi fits; the user's choice (2026-11-21) |
| Beauty (Battle Tower) | Schönh. | Trainer classes | Abbreviation in Battle Tower battles only, so Schönh. Valentine fits; the user's choice (2026-11-21) |
| Cosplayer (Battle Tower) | Cosplayer | Trainer classes | Short form in Battle Tower battles only, so Cosplayer Patricia fits; the user's choice (2026-11-21) |
| Ruin Maniac | Ruinenmaniac | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle) |
| Firebreather | Feuerspucker | Trainer classes | Modern name (HeartGold/SoulSilver) |
| Juggler | Jongleur | Trainer classes | Modern name (Let's Go, Pikachu!/Evoli!) |
| Schoolboy | Schüler | Trainer classes | Modern name (Schwert/Schild); Kristall "SCHULJUNGE" |
| Schoolgirl | Schülerin | Trainer classes | Modern name (Schwert/Schild) |
| Psychic | Seher | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle); Kristall "PSYCHO" |
| Hex Maniac | Hexe | Trainer classes | Modern name (Legenden: Z-A) |
| Sage | Weiser | Trainer classes | Modern name (HeartGold/SoulSilver) |
| Medium | Medium | Trainer classes | Modern name (HeartGold/SoulSilver) |
| Kimono Girl | Kimonogirl | Trainer classes | Kristall and Modern "Kimono-Girl" without the hyphen; "Kimono-Girl Satsuki" would be 19. The user's choice |
| Elder | Weisester | Trainer classes | Modern name (HeartGold/SoulSilver) |
| Sr.& Jr. | Sr.& Jr. | Trainer classes | As in English; the user's choice. Omega Rubin/Alpha Saphir's "Senior&Junior" is 13; pair names fit up to 9 |
| Couple | Pärchen | Trainer classes | Own; the Modern "Junges Glück" (12) leaves 5 tiles, and the pair names are 9–10. The user's choice |
| Gentleman | Gentleman | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle) |
| Rich Boy | Schnösel | Trainer classes | Modern name (Legenden: Z-A) |
| Lady | Lady | Trainer classes | Modern name (Legenden: Z-A) |
| Breeder | PKMN-Züchterin | Trainer classes | Modern name "Pokémon-Züchterin" (17 tiles) shortened with PKMN; the user's choice. Pairs leave 5 tiles for a name |
| Baker | Bäckerin | Trainer classes | Modern name (Schwarz 2/Weiß 2) |
| Cowgirl | Cowgirl | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle) |
| Sailor | Matrose | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle) |
| Swimmer | Schwimmer (swimmerm, marlon) / Schwimmerin (swimmerf) | Trainer classes | Schwimmer: Modern name (Strahlender Diamant/Leuchtende Perle); Kristall "SCHWIMMER♂"; Schwimmerin: Modern name (Strahlender Diamant/Leuchtende Perle); Kristall "SCHWIMMER♀" |
| Burglar | Dieb | Trainer classes | Modern name (Let's Go, Pikachu!/Evoli!) |
| Agent | Agent | Trainer classes | Own; the user's choice |
| Scientist | Forscher | Trainer classes | Modern name (Forscher: Karmesin/Purpur) |
| Boarder | Snowboarder | Trainer classes | Modern name (HeartGold/SoulSilver) |
| Skier | Skifahrer | Trainer classes | Kristall ("SKIFAHRER", for its female Skiers too); "Skifahrerin Gabriela" would be 20. The user's choice |
| Black Belt | Schwarzgurt | Trainer classes | Modern name (Karmesin/Purpur) |
| Battle Girl | Kämpferin | Trainer classes | Modern name (Legenden: Z-A) |
| Dragon Tamer | Drachenprofi | Trainer classes | Modern name (Karmesin/Purpur) |
| Engineer | Elektriker | Trainer classes | Modern name (Let's Go, Pikachu!/Evoli!) |
| Teacher | Lehrerin (teacher_f) / Lehrer (teacher_m) | Trainer classes | Lehrerin: Modern name (Ultrasonne/Ultramond), Kristall "LEHRERIN"; Lehrer: own, the user's choice |
| Guitarist | Gitarrist (guitaristm) / Gitarristin (guitaristf) | Trainer classes | Gitarrist: Modern name (Gitarrist: Strahlender Diamant/Leuchtende Perle); Gitarristin: Modern name (Gitarristin: Schwarz 2/Weiß 2) |
| Biker | Rowdy | Trainer classes | Modern name (Schwarz 2/Weiß 2); Kristall "BIKER" |
| Roughneck | Raufbold | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle) |
| Tamer | Dompteur | Trainer classes | Modern name (Let's Go, Pikachu!/Evoli!) |
| Artist | Künstlerin | Trainer classes | Modern name (Legenden: Z-A), feminine: Polished's four Artists are women (Reina, Alina, Marlene, Rin) |
| Aroma Lady | Aromalady | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle) |
| Soldier | Soldat | Trainer classes | Own; the user's choice |
| Waiter | Servierer | Trainer classes | Modern name (Legenden: Z-A) |
| Waitress | Serviererin | Trainer classes | Modern name (Legenden: Z-A) |
| Sightseer | Urlauber (sightseerm) / Urlauberin (sightseerf) | Trainer classes | Urlauber: Modern name (Legenden: Z-A); Urlauberin: Modern name (Legenden: Z-A) |
| Sightseers | Urlauber | Trainer classes | Own; the user's choice (pairs; Ultrasonne/Ultramond's nearest class is "Touri-Paar") |
| Ace Trainer | Ass-Trainer | Trainer classes | Modern name (Legenden: Z-A) |
| Ace Duo | Duo | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle) |
| Veteran | Veteran (veteranm) / Veteranin (veteranf) | Trainer classes | Veteran: Modern name (Legenden: Z-A); Veteranin: Modern name (Legenden: Z-A) |
| Executive | Vorstand | Trainer classes | HeartGold/SoulSilver ("Vorstand" for the English "Executive"); Let's Go's "Rocket-Vorstand" is 15 tiles. Kristall had no class (class "ROCKET", name "VORSTAND") |
| Boss | Boss | Trainer classes | FireRed/LeafGreen (class "Boss", as in Polished's English); HeartGold/SoulSilver and Let's Go have "Rocket Boss"/"Rocket-Boss" for "Team Rocket Boss" |
| Pokémon Prof. | Pokémon Prof. | Trainer classes | Kristall ("#MON PROF."); "Pokémon-Professor" is 17 tiles |
| Mystery Man | Unbekannter | Trainer classes | Modern name (HeartGold/SoulSilver); Kristall "MYSTIKER" |
| Karate King | Schwarzgurt | Trainer classes | His battle class in Kristall's data and HeartGold/SoulSilver; the user's choice over "Karate-Mstr." (Kristall's title "KARATE-MEISTER" is 14) |
| TowerTycoon | Kampfkoloss | Trainer classes | Modern name (Strahlender Diamant/Leuchtende Perle) |
| FactryHead | Fabrikltr. | Trainer classes | Modern name "Fabrikleiter" (Platinum, HeartGold/SoulSilver) abbreviated like Upstream's "FactryHead"; "Fabrikleiter Distmar" would be 20. The user's choice |
| Jessie | Jessie | Trainer classes | As in English; the battle line reads "Jessie & James" (name "& James") |
| Ex-Elite | Ex-Top 4 | Trainer classes | Own, from "Top Vier"; "Ex-Top Vier Lorelei" would be 19. The user's choice (Lorelei, Agatha) |
| Rock Hound | Steinsammler | Trainer classes | Own; the user's choice (Steven/Troy) |
| Researcher | Forscherin | Trainer classes | Own; the user's choice (Cynthia) |
| Valet | Diener | Trainer classes | Modern name "Kammerdiener" (Platinum, HeartGold/SoulSilver) without "Kammer"; "Kammerdiener Perenus" would be 20. The user's choice |
| Trainer | Trainerin | Trainer classes | Flannery/Flavia, English "Trainer": as the female PKMN Trainers; the user's choice |
| Fighter | Kämpferin | Trainer classes | Own, as Battle Girl's official "Kämpferin"; the user's choice (Maylene/Hilda) |
| Designer | Designerin | Trainer classes | Own; the user's choice (Valerie) |
| Vocalist | Sänger | Trainer classes | Own; the user's choice (Piers/Nezz) |
| Businessman | Angestellter | Trainer classes | Official class word (Office Worker); the user's choice (Larry/Aoki; Scarlet/Violet fight him as Arenaleiter and Top Vier) |
| Surfer | Surfer | Trainer classes | Modern name (Ultrasonne/Ultramond) |
| Ex-Leader | Ex-Leiter | Trainer classes | Own, from "Leiter"; the user's choice (Walker) |
| Student | Student | Trainer classes | Own; the user's choice (Imakuni; the official "Akademieschüler" is 16 tiles) |
| Collector | Sammler | Trainer classes | Modern name "Pokémon-Sammler" (15 tiles) without "Pokémon-"; "PKMN-Sammler Lawrence" would be 19. The user's choice |
| Shrine | Priesterin | Trainer classes | Own; the user's choice: "Priesterin Rei" (name "Rei" for "Maiden Rei") |
| Trainer names (list) | — | `data/trainers/parties.asm` | The trainer's German name in the latest game that has the trainer (PokéWiki, matched by place and team), else Kristall's by class and English name, else an own name. Where HeartGold/SoulSilver renamed a trainer in English too and Polished keeps Crystal's English name, Kristall's German stands (Norman Andre, Gilbert Cyrille, Jed Theodor, Miller Pelle). Trainers Polished renamed keep their official German name (the user's choice): Lo & Zoe Tia & Tara, Valencia Jutta, Reilly Hannes, Mayu Gerda, Dennett Oskar. Pair names write " & " when they fit 10 tiles, else "&" ("Jana&Nana") |
| Kristall trainers renamed in HeartGold/SoulSilver | Mikey Dietrich, Gordon Tommy, Lloyd Waldemar, Erin Nanette, Henry Selim, Bret Melvin, Kenny Hilmar, Jim Dejan, Linda Svantje, Laura Adriana, Julia Vivian, Otis Fitz, Tucker Ottmar, Duncan Pit, Shirley Hiltrude, Harris Francois, Kenji Timon; Kimono Girls Naoko Umeko, Sayo Sakura, Zuki Tamao, Kuni Komomo, Miki Satsuki | Trainer names | Modern name over Kristall's (ADR 0002): same trainer, same English name, HeartGold/SoulSilver's German. Kristall's dialogue lines that name them change too |
| Official names dropped for the battle line | French → Franz, Salma (kept), Piper → Pia (Picnicker), Viola (kept), Kinsey → Knut, Kenta (kept), Stacey → Sven | Trainer names | Their HeartGold/SoulSilver or Let's Go names (Stanislaus, Valentina, Josefine, Charlotte, Benedikt, Benjamin, Hinrich) don't fit next to their class; the class stays and they get own names. Bonita (kept) and Boone → Bonnie, female in Polished but male in HeartGold/SoulSilver (Heiner, Guillaume), get own female names. Polished's own Scientist Oskar → Otto, since Dennett is "Oskar". Swimmer Wendy keeps Kristall's "Gerda" (HeartGold/SoulSilver's "Gerarda" doesn't fit), so Mayu, HeartGold/SoulSilver's Gerda, keeps "Mayu". Lass Amanda, Polished's rename of Crystal's Fuchsia Gym Lass Alice, is Kristall's "Gabriele"; Polished's new Lass Alice keeps "Alice". The user's choices |
| Cal | Hermann | Trainer names | Kristall (Trainer House opponent "HERMANN", Crystal's Cal) |
| Falkner | Falk | Trainer names | Kristall |
| Bugsy | Kai | Trainer names | Kristall |
| Whitney | Bianka | Trainer names | Kristall |
| Morty | Jens | Trainer names | Kristall |
| Chuck | Hartwig | Trainer names | Kristall |
| Jasmine | Jasmin | Trainer names | Kristall |
| Pryce | Norbert | Trainer names | Kristall |
| Clair | Sandra | Trainer names | Kristall |
| Will | Willi | Trainer names | Kristall |
| Koga | Koga | Trainer names | Kristall |
| Bruno | Bruno | Trainer names | Kristall |
| Karen | Melanie | Trainer names | Kristall |
| Lance | Siegfried | Trainer names | Kristall |
| Brock | Rocko | Trainer names | Kristall |
| Misty | Misty | Trainer names | Kristall |
| Lt.Surge | Major Bob | Trainer names | Kristall |
| Erika | Erika | Trainer names | Kristall |
| Janine | Janina | Trainer names | Kristall |
| Sabrina | Sabrina | Trainer names | Kristall |
| Blaine | Pyro | Trainer names | Kristall |
| Blue | Blau | Trainer names | Kristall |
| Red | Rot | Trainer names | Kristall |
| Green | Grün | Trainer names | Let's Go's Green, like Rot and Blau; the user's choice over FireRed/LeafGreen's "Leaf" |
| boy | Junge | Trainer names | The user's choice: the rival's first battle reads "Seltsamer Junge" |
| Lyra | Lyra | Trainer names | Modern name (HeartGold/SoulSilver) |
| Grunt | Rüpel | Trainer names | Kristall ("RÜPEL") |
| Looker | LeBelle | Trainer names | Modern name (Diamond/Pearl/Platinum) |
| Proton | Lance | Trainer names | HeartGold/SoulSilver; not Lance the Champion, who is "Siegfried" |
| Petrel | Lambda | Trainer names | Modern name (HeartGold/SoulSilver) |
| Archer | Atlas | Trainer names | Kristall's data and HeartGold/SoulSilver (Kristall's battles read "VORSTAND") |
| Ariana | Athena | Trainer names | Kristall's data and HeartGold/SoulSilver (Kristall's battles read "VORSTAND") |
| Giovanni | Giovanni | Trainer names | Kristall |
| Oak | Eich | Trainer names | Modern name (Kristall and later games) |
| Elm | Lind | Trainer names | Modern name (Kristall and HeartGold/SoulSilver) |
| Ivy | Ivy | Trainer names | Anime name (Professor Felina Ivy) |
| Eusine | Eusin | Trainer names | Kristall |
| Kiyo | Leif | Trainer names | Kristall (Crystal's Black Belt Kiyo, class "SCHWARZGURT") |
| Palmer | Viktor | Trainer names | Modern name (Diamond/Pearl/Platinum) |
| Thorton | Distmar | Trainer names | Modern name (Platinum) |
| Battle Tower names | kept as in English, except Palmer → Viktor and Thorton → Distmar | Trainer names (`data/battle_tower/classes.asm`) | The user's choice (2026-11-21): the facility gathers trainers from everywhere, and many names are references (Hopper, Dijkstra, Fagin) |
| & James | & James | Trainer names | Anime name; the battle line reads "Jessie & James" |
| Lorelei | Lorelei | Trainer names | Modern name (FireRed/LeafGreen) |
| Agatha | Agathe | Trainer names | Modern name (FireRed/LeafGreen) |
| Steven | Troy | Trainer names | Modern name (Ruby/Sapphire/Emerald) |
| Cynthia | Cynthia | Trainer names | Modern name (Diamond/Pearl/Platinum) |
| Cheryl | Raissa | Trainer names | Modern name (Diamond/Pearl/Platinum) |
| Riley | Urs | Trainer names | Modern name (Diamond/Pearl/Platinum) |
| Buck | Avenaro | Trainer names | Modern name (Platinum) |
| Marley | Charlie | Trainer names | Modern name (Platinum) |
| Mira | Orisa | Trainer names | Modern name (Platinum) |
| Anabel | Anabel | Trainer names | Modern name (Emerald) |
| Darach | Perenus | Trainer names | Modern name (Platinum) |
| Caitlin | Kattlea | Trainer names | Modern name (Platinum, Black/White) |
| Candela | Candela | Trainer names | Modern name (Pokémon GO) |
| Blanche | Blanche | Trainer names | Modern name (Pokémon GO) |
| Spark | Spark | Trainer names | Modern name (Pokémon GO) |
| Flannery | Flavia | Trainer names | Modern name (Ruby/Sapphire/Emerald) |
| Maylene | Hilda | Trainer names | Modern name (Diamond/Pearl/Platinum) |
| Marlon | Benson | Trainer names | Modern name (Black 2/White 2) |
| Valerie | Valerie | Trainer names | Modern name (X/Y) |
| Kukui | Kukui | Trainer names | Modern name (Sun/Moon) |
| Piers | Nezz | Trainer names | Modern name (Sword/Shield) |
| Larry | Aoki | Trainer names | Modern name (Scarlet/Violet) |
| Bill | Bill | Trainer names | Kristall |
| Yellow | Gelb | Trainer names | Manga name (Pocket Monsters SPECIAL); the user's choice |
| Walker | Luc | Trainer names | Manga name (Pocket Monsters SPECIAL, Falkner's father); the user's choice |
| Imakuni | Imakuni | Trainer names | As in English: Polished drops the "?" of the Trading Card Game's "Imakuni?" |
| Lawrence | Lawrence | Trainer names | Anime name (Lawrence III., Movie 2000) |
| Maiden Rei | Rei | Trainer names | The user's choice: "Priesterin Rei" |
| PKMN Trainer (Carrie) (own names) | Carrie → Carla | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| PKMN Trainer (Jacky) (own names) | Jacky (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| PKMN Trainer (Euna) (own names) | Euna (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Youngster (own names) | Alfie (kept), Oliver (kept), Chaz → Jonas, Tyler → Timo, Arden → Arne | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Bug Catcher (own names) | Oscar → Oskar | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Camper (own names) | Craig → Gregor, Felix (kept), Amos (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Picnicker (own names) | Lily → Lilli, Piper → Pia, Zane → Zita | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Fisherman (own names) | Paton → Arnold, Kiley → August, Francis → Achim, Virgil → Ambros, Hall → Aaron, Dallas → Andreas, Carlos → Alonso | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Bird Keeper (own names) | Mick → Micha, Powell → Konrad, Tony → Toni, Julian → Jan, Kinsey → Knut, Trent → Theo, Salim (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Hiker (own names) | Seamus → Severin, Tony → Toni, Gerard → Gerhard, Dent (kept), Lester → Lothar, Grady → Gottfried, Steve → Steffen, Derrick → Dietmar, Floyd → Florian, Elijah → Elias, Maynard → Meinhard | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Pokéfan ♀ (own names) | Boone → Bonnie | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Officer ♀ (own names) | Jamie (kept), Mara (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Nurse (own names) | Beatrice (kept), Keiko (kept), Winifred (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| #Maniac (own names) | Enzo → Eiji, Aidan → Daiki | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Cosplayer (own names) | Clara (kept), Chloe → Chloé, Brooke → Britta, Kuroko (kept), Lyric → Aria | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Super Nerd (own names) | Luis → Ludger, Rory → Rupert, Foote → Folkert, Kouta (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Lass (own names) | Abigail → Annika, Layla → Lena, Rose → Rosa, Meadow → Flora, Jennifer → Josi, Gina (kept), Alice (kept), Mavis → Marlies | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Beauty (own names) | Bridget → Brigitte, Nicole → Natascha, Ioana (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Bug Maniac (own names) | Lou → Lutz, Stacey → Sven, Kenta (kept), Pierre (kept), Dylan → Dirk, Kai → Kurt | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Ruin Maniac (own names) | Jones (kept), Leland → Heinz, Petry → Petri, Glyn (kept), Smilte → Emil | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Firebreather (own names) | Jay → Jo, Oleg (kept), Tala → Theo, Cyd → Sid | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Schoolgirl (own names) | Molly → Milla, Eliza → Elisa, Faith → Frieda, Sarah (kept), Isabel (kept), Imogen → Ines | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Psychic (own names) | Leon → Léon, Uri (kept), Virgil → Virgile | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Hex Maniac (own names) | Tamara (kept), Ashley (kept), Amy → Amalie, Luna (kept), Natalie (kept), Vivian (kept), Esther (kept), Matilda → Mathilde, Bethany → Brunhild, Coryn → Morgana | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Kimono Girl (own names) | Mako (kept), Ami (kept), Mina (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Sr.& Jr. (own names) | Jo & Cath → Jo & Kati, Ivy & Amy → Ida & Uta, Bea & May → Bea & Mia | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Couple (own names) | Gail & Eli → Gabi & Eli, Fox & Rae → Flo & Ria, Joe & Jo (kept), Erik&Sara (kept), Sara&Erik (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Gentleman (own names) | Camus (kept), Geoffrey → Georg | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Rich Boy (own names) | Winston (kept), Gerald (kept), Irving → Julius, Tobin → Tobias | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Lady (own names) | Jessica (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Breeder (own names) | Julie (kept), Theresa → Tessa, Jody → Judit, Carlene → Lene, Sophie → Sofie, Brenda → Britt | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Baker (own names) | Chelsie (kept), Sharyn → Sabine, Margaret → Margot, Olga (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Cowgirl (own names) | Annie (kept), April (kept), Daniela (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Sailor (own names) | Harvey (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Swimmer ♂ (own names) | Michel → Mischa, Lucas → Lukas, Frank (kept), Nadar (kept), Conrad (kept), Romeo (kept), Malcolm (kept), Armand (kept), Thomas (kept), Ezra (kept), Ashe → Sascha | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Swimmer ♀ (own names) | Viola (kept), Alison (kept), Stephanie → Steffi, Caroline → Caro, Natalia → Talia, Barbara → Babsi, Sally → Sanne, Mayu (kept), Woda (kept), Rachel → Rahel, Marina (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Burglar (own names) | Pete (kept), Louis (kept), Pierce → Piet | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Scientist (own names) | Oskar → Otto, Braydon → Bastian, Carl (kept), Dexter (kept), Joseph → Josef, Nigel → Niklas, Piotr (kept), Sanders → Sandro | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Boarder (own names) | Stefan (kept), Max (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Skier (own names) | Maria (kept), Becky (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Black Belt (own names) | Inigo (kept), Takeo (kept), Rylan → Robin | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Battle Girl (own names) | Subaru (kept), Diane (kept), Kagami (kept), Nozomi (kept), Ronda (kept), Padma (kept), Emy (kept), Sasha (kept), Mei (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Dragon Tamer (own names) | Adam (kept), Erick → Erik, Kazu (kept), Aegon (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Engineer (own names) | Smith → Schmidt, Camden → Carsten, Lang (kept), Hugo (kept), Howard → Henrik, Graden → Gerrit, Gustav (kept), Nicolas (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Teacher ♀ (own names) | Kathryn → Katrin, Serena (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Teacher ♂ (own names) | Nolan → Nils | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Guitarist ♂ (own names) | Roger (kept), Ezekiel (kept), Biff (kept), Geddy (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Guitarist ♀ (own names) | Janet (kept), Morgan (kept), Ritsuko → Ritsu, Wanda (kept), Jaclyn (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Biker (own names) | Tyrone (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Roughneck (own names) | Brian (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Tamer (own names) | Brett → Björn, Vince (kept), Oswald (kept), Jordan (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Artist (own names) | Reina (kept), Alina (kept), Marlene (kept), Rin (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Aroma Lady (own names) | Dahlia (kept), Bryony → Malve, Heather (kept), Holly (kept), Peony → Rosalie | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Sightseer ♂ (own names) | Jaska (kept), Blaise (kept), Gareth (kept), Chester (kept), Hari (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Sightseer ♀ (own names) | Rosie (kept), Kamila (kept), Noelle (kept), Pilar (kept), Lenie → Leni | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Sightseers (own names) | Li & Su (kept), Cy & Vi (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Ace Trainer ♂ (own names) | French → Franz, Henri (kept), Connor (kept), Kieran (kept), Finch → Fink, Petrie (kept), Corey (kept), Ray (kept), Fergus (kept), Daric (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Ace Trainer ♀ (own names) | Salma (kept), Bonita (kept), Sera → Svea, Neesha (kept), Chiara (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Ace Duo (own names) | Ara & Bela (kept), Jake & Bri → Jan & Rike, Dan & Cara (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Veteran ♂ (own names) | Matthew → Matthias, Remy (kept), Barkhorn → Bernhard, En (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Veteran ♀ (own names) | Joanne → Johanna, Jonet (kept), Litvyak → Lydia, Madoka (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| Surfer (own names) | Victor (kept) | Trainer names | Own; the user's choices (2026-11-19). "Kept": the English name works in German |
| In-game trades (list) | — | `data/events/npc_trades.asm` | The OT follows the person: Crystal's trade partners keep Kristall's names for them (Mike Ralf, Kyle Tobi, Emy Carmen, Chris Paul; Tim and Kim stay). A nickname takes Kristall's where Polished kept Crystal's English nickname (Muscle Herakles, Doris; Chris's Paul → Pollo, since Kristall's OT is already Paul) |
| Trade nicknames (own) | Mimic (kept), Joey (kept), Chance (kept), Gail (kept), Clarence (kept), Batty → Schrulli | In-game trades | Own; the user's choices (2026-11-19). Polished's own partners Jacques, Hari and Jeeves keep their names |
| Mom / Bill / Prof.Elm | Mama / Bill / Prof. Lind | Phone list | Kristall ("MAMA:", "BILL:", "PROF. LIND:"); the subtitles use the class names ("#maniac", "#mon Prof.") |
| Miracle Cycle | Miracle Cycle | Phone list | As in English, a shop name; no German game names it (Kristall: "FAHRRADLADEN", PokéWiki: "Radladen"). The user's choice |
| Lyra / Buena | Lyra (Trainerin) / Buena (Disc Jockey) | Phone list | Modern name; Kristall ("BUENA:", "DISC JOCKEY"); Lyra's subtitle is her class "Trainerin" |
| Silver (default rival name) | Silber | Rival naming screen | Kristall |
| Ralph (Magikarp record holder) | Angelo | Magikarp length record | Kristall: Fisherman Ralph is "Angelo" |
| Trainer nicknames (own) | Lyra's Chicory → Endivchen, Cinder → Feuri, Toto → Nimi; Lucinda's Blossom → Bella; Niklas's Spin → Spinni, Rat → Ratti; Elisa's Silver → Silber, Tret → Wiesi; Ines's Garlic → Knobi; Uri's Hocus → Hokus, Pocus → Pokus; Corey's Bruteroot → Wurzelwut, Ray's Firebrand → Feuerbrand, Fergus's Empress → Kaiserin, Neesha's Shellshock → Granate | Trainer nicknames | Own; the user's choices (2026-11-19/20). Kept as in English: Milky, Campfire, Dopefish, VuiVui, Eon, Vee, Gold, Teddy, Lady, Audrey, Bruce, Jackie, Bulbasaur, Pilar's Spanish Antorcha, Huesitos, Luna, Linterna, and Puka |
| Yellow's nicknames | Omny → Amoni, Ratty → Ratzi, Free → Raups, Dody → Dodi, Gravvy → Geon, Chuchu (kept) | Trainer nicknames | Manga names (the German edition of Pocket Monsters SPECIAL, PokéWiki); the user's choice |
| Wonder Trade names: versions | Red → Rot, Blue → Blau, Green → Grün, Yellow → Gelb, Silver → Silber, Crystal → Kristal (squeezed from Kristall), Ruby → Rubin, Safire → Saphir, Emerald → Smaragd, Diamond → Diamant, Pearl → Perl, Platina → Platin, Black → Schwarz, White → Weiss, Gray → Grau (own), Sun → Sonne, Moon → Mond, Star → Stern (own) | Wonder Trade names | Modern names (PokéWiki) unless marked; German version names for the versions. "Squeezed": cut to 7 like Upstream's English (2026-11-21) |
| Wonder Trade names: heroes and rivals | Leaf → Grün (the user's choice), Ethan → Klarin, Kris → Krista, Brendan → Brix, May → Maike, Wally → Heiko, Lucas → Lucius, Dawn → Lucia, Hilbert → Warren, Hilda → Lotta, Bianca → Bell, Nate → Tony, Rosa → Rosy, Hugh → Matisse, Calem → Kalem, Shauna → Sannah, Trevor → Trovato, Hau → Tali, Lillie → Lilly, Gladion → Gladio, Wes → Seth | Wonder Trade names | Modern names (PokéWiki) unless marked; German version names for the versions. "Squeezed": cut to 7 like Upstream's English (2026-11-21) |
| Wonder Trade names: professors and helpers | Birch → Birk, Rowan → Eibe, Juniper → Esche, Sycamor → Platan, Samson → Heinrch (squeezed from Heinrich), Cozmo → Kosmo, Fennel → Vivian, Cedric → Ebrhard (squeezed from Eberhard), Burnet → Burnett, Krane → Klein, Brigett → Linette, Bebe → Lana, Amanita → Rubina, Cassius → Olivier, Molayne → Marlon | Wonder Trade names | Modern names (PokéWiki) unless marked; German version names for the versions. "Squeezed": cut to 7 like Upstream's English (2026-11-21) |
| Wonder Trade names: Gym Leaders, Elite Four, Champions and captains | Lance → Siegfrd (squeezed from Siegfried), Roxanne → Felizia, Brawly → Kamillo, Wattson → Walter, Winona → Wibke, Liza → Svenja, Tate → Ben, Wallace → Wassili, Sidney → Ulrich, Phoebe → Antonia, Glacia → Frosina, Drake → Dragan, Roark → Veit, Garden → Silvana, Wake → Marinus, Fantina → Lamina, Byron → Adam, Candice → Frida, Aaron → Herbaro, Bertha → Teresa, Flint → Ignaz, Cilan → Benny, Chili → Maik, Cress → Colin, Roxie → Mica, Lenora → Aloe, Burgh → Artie, Elesa → Kamilla, Clay → Turner, Skyla → Géraldn (squeezed from Géraldine), Brycen → Sandro, Drayden → Lysandr (squeezed from Lysander), Iris → Lilia, Shantal → Anissa, Marshal → Eugen, Grimsly → Astor, Alder → Lauro, Grant → Lino, Korrina → Connie, Ramos → Amaro, Clemont → Citro, Olympia → Astrid, Wulfric → Galanth (squeezed from Galantho), Malva → Pachira, Siebold → Narcise (squeezed from Narcisse), Wiktrom → Thymlot (squeezed from Thymelot), Drasna → Dracena, Ilima → Elima, Lana → Tracy, Mallow → Maho, Sophcls → Chrys, Acerola → Lola, Mina → Matsrka (squeezed from Matsurika), Olivia → Mayla, Nanu → Yasu, Hapu → Hapu'u, Noland → Kevin, Tucker → Tasso | Wonder Trade names | Modern names (PokéWiki) unless marked; German version names for the versions. "Squeezed": cut to 7 like Upstream's English (2026-11-21) |
| Wonder Trade names: Battle Frontier and Team Rocket | Lucy → Lotte, Spenser → Serenus, Brandon → Brian | Wonder Trade names | Modern names (PokéWiki) unless marked; German version names for the versions. "Squeezed": cut to 7 like Upstream's English (2026-11-21) |
| Wonder Trade names: villains | Miror B → D.Queen (squeezed from D. Queen), Matt → Wolfgng (squeezed from Wolfgang), Shelly → Kordula, Archie → Adrian, Tabitha → Kalle, Courtny → Jördis, Maxie → Marc, Cyrus → Zyrus, Colress → Achroms (squeezed from Achromas), Gorm → Caerlus (squeezed from Caeruleus), Bronius → Aquilus, Rood → Rubius, Zinzoln → Violacs (squeezed from Violaceus), Giallo → Flavus, Ryoku → Viridus, Ghetsis → G-Cis, Anthea → Minna, Concord → Elfride (squeezed from Elfriede), Bryony → Begonia, Celosia → Calluna, Mable → Magnola (squeezed from Magnolia), Xerosic → Xeros, Lysandr → Flordls (squeezed from Flordelis), Plumera → Fran, Guzma → Bromley, Faba → Fabian, Wicke → Pia, Lusamin → Samanta (squeezed from Samantha) | Wonder Trade names | Modern names (PokéWiki) unless marked; German version names for the versions. "Squeezed": cut to 7 like Upstream's English (2026-11-21) |
| Wonder Trade names: trade partners and side characters | Helios → Elio (the user's choice), Jenny → Rocky (Anime name), Daisy → Sarah, Copycat → Nachahm (squeezed from Nachahmerin) | Wonder Trade names | Modern names (PokéWiki) unless marked; German version names for the versions. "Squeezed": cut to 7 like Upstream's English (2026-11-21) |
| Wonder Trade names: side characters (Gen 2–6) | Primo → Castor, Lostele → Irrma, Selphy → Kea, Joey → Julian, Cameron → Wikbert, Mary → Margit, Reed → Bastian, Fern → Fabian, Lily → Lilly, Randy → Harald (Kristall), Maximo → Pollux, Felicty → Beate, Monica → Monja, Tuscany → Ditlind (squeezed from Dietlinde), Wesley → Mitko, Arthur → Donatus, Santos → Samson, Sunny → Sonnfrd (squeezed from Sonnfried), Li → Marek, Briney → Brack, Stone → Trumm, Wanda → Heike, Gabby → Pia, Ty → Udo, Rydel → Radla, Stern → Brigg, Aarune → Johnson, Lisia → Xenia, Zinnia → Amalia, Inver → Estefan, Chaz → Clett, Kiri → Berta, Johanna → Katrin, Rosanne → Roxana, Julia → Mona, Jordan → Eric, Keira → Julia, Fuego → Feurio, Hawes → Baldur | Wonder Trade names | Modern names (PokéWiki) unless marked; German version names for the versions. "Squeezed": cut to 7 like Upstream's English (2026-11-21) |
| Wonder Trade names: later side characters and anime | Curtis → Markus, Yancy → Sabine, Ingo → Hin, Emmet → Her, Grace → Primula, Alexa → Alba, Gurkinn → Combre, AZ → Azett, Emma → Matiere (the user's choice, Matière without è), Nita → Nuit, Evelyn → Soir, Dana → Journée, Morgan → Matin, Gester → Styler, Damian → Damien (Anime name) | Wonder Trade names | Modern names (PokéWiki) unless marked; German version names for the versions. "Squeezed": cut to 7 like Upstream's English (2026-11-21) |
| Wonder Trade names over 7 letters | squeezed to 7 like Upstream's English (Giovani, Courtny, Lysandr): a doubled letter, an inner vowel or the last letters dropped, no period | Wonder Trade names | The user's choice (2026-11-21); this list only, since its names stand in for player names typed into 7 letters. Other lists keep the Abbreviation rule |
| Wonder Trade names (kept) | as in English: real people (Tajiri, Iwata, Masuda …), Polished's developers, Japanese names of Pokémon characters (Satoshi, Hibiki …), other franchises by their Japanese names (Usagi, Shinji, Miku …), Greek letters and letter versions (Alpha, Omega, X, Y, Z), fan-game characters, names the same in German, Orange, Jade, Mind, Phil (German X/Y names him only by the title "Kamerakauz"), and the unidentified Bonnie, Clyde, Everyle, Zetsu, Karuta, Nozomi, Amos, Kei, Clara, Hana, Miyuki | Wonder Trade names | The approved design (2026-11-21); Phil, the unidentified names: the user's choices |
| Psychic Inver | Inver (kept) | Trainer names (`data/trainers/psychic_inver.asm`) | The official German name is Estefan (X/Y, PokéWiki), but `PickPsychicInverParty` hardcodes the length of "Inver@", so a longer name breaks his party; the user's choice (2026-11-21). The Wonder Trade entry for him is Estefan |
| Running Shoes | Turbotreter | Mom's scene (`maps/PlayersHouse1F.asm`) | Official (PokéWiki, Gen 3–6) |
| B Button | B-Knopf | Dialogue | Kristall ("A-Knopf", "B-Knopf") |
| Daylight Saving Time / DST | Sommerzeit / SZ (WZ for standard time) | Mom's scene, clock prompts | Kristall |
| Sunday … Saturday | Sonntag, Montag, Dienstag, Mittwoch, Donnerstag, Freitag, Samstag | Mom's weekday question (`engine/rtc/timeset.asm`) | Kristall, re-cased; the picker box is one tile wider than English to fit "Donnerstag" (provisional, the user was offline 2026-11-21) |
| Bank of Mom: Saved / Withdraw / Deposit / Held | Erspartes / Abheben / Einzahlen / Besitz | Bank of Mom (`engine/events/mom.asm`) | Kristall, except "Erspartes" (own, provisional): Kristall's "Ersparnisse" is 11 tiles, and Polished prints the amount from column 11 |
| Bank of Mom menu: Get / Save / Change / Cancel | Abheben / Sparen / Ändern / Zurück | Bank of Mom menu | Kristall |
| Champion / champ (addressing the player) | Champ, also with an article ("ein toller Champ") | New dialogue | The user's choice (2026-11-21): "Champ" counts as neutral, like "ein Star"; German games call female Champions "Champ" too |
| A talented trainer like yourself | ein Talent wie du | New dialogue | The user's choice (2026-11-21): "das Talent" is neuter, so the player stays neutral |
| The Wizard of Oz's (yellow) brick road | gelbe Ziegelsteinstrasse | Lyra's TV (`maps/LyrasHouse1F.asm`) | The user's choice (2026-11-21): "gelb" added from the German dub, so the reference survives |
| <Name>'s House (signs) | Haus von <PLAYER> / Lyras Haus / Prof. Linds Haus | House signs | Kristall ("Haus von <PLAYER>", "PROF. LINDs HAUS"); "Lyras Haus" own after that pattern |
| Elm #mon Lab | Lind-#mon-Labor | Sign, dialogue | Kristall ("LIND-#MON-LABOR") |
| Rice balls | Reisbällchen | Lyra's fridge | Own |
| Gym / #mon Gym | Arena / PKMN-Arena | Dialogue | Kristall ("PKMN-ARENA", "PKMN-ARENEN"); PKMN stays in capitals |
| Elite Four | Top Vier | Dialogue | Kristall |
| "<PLAYER> received/gained <item or #mon>" | "<PLAYER> erhält / <name>." ("!" for a #mon) | Gift texts | Kristall |
| "<PLAYER> put the <item> in the <pocket>" | "<PLAYER> steckt / <item> in / <pocket>." | Item gift texts | Kristall's frame, no article before the pocket; fits 15 tiles at the longest item and pocket |
| "The <pocket> is full…" | "Die <pocket> / ist voll…" | Item gift texts | Kristall's "ist voll…"; "Die" fits every pocket that can be full (all "…-Tasche") |
| Give a nickname to <#mon>? | Möchtest du / <#mon> einen / Spitznamen geben? | Gift and caught #mon | Kristall |
| The criminal always returns to the scene of the crime | Der Täter kehrt immer an den Tatort zurück | Officer in Elm's lab | Own, the German idiom |
| "So you're the thief?" (to the player) | "Dann warst du das also?" | Officer in Elm's lab | Own, neutral for the player (provisional, the user was offline 2026-11-21) |
| oddity (the Odd Souvenir) | Kuriosität (item: Kuriosum) | Elm's lab | Own; keeps the link to the item name |
| Pokémon League (dialogue) | #mon-Liga | Dialogue | Own, the modern compound spelling (PokéWiki "Pokémon-Liga", as in the Fly row); Kristall writes "#MON LIGA", and its reused lines get the hyphen too, like ß → ss (provisional, the user was offline 2026-11-21) |
| START, SELECT (buttons) | START, SELECT | Dialogue (Elm's lab travel tips) | Kristall: the button labels stay in capitals, as printed on the console |
| Daylight Saving Time adjust (Mom) | Möchtest du auf Sommerzeit umstellen? / Ich stelle die Uhr eine Stunde vor. / Ist die Sommerzeit vorüber? / … zurück. | Bank of Mom's "No" path | Kristall (ROM 71:634c–6417) |
| Trainer Tips (signs) | Tipps für Trainer | Signs | Kristall ("TIPPS für TRAINER") |
| Advanced Tips! (signs) | Profi-Tipps! | Signs (Route 29, Cherrygrove City, Route 30, …) | Own: Polished's own heading, next to Kristall's "Tipps für Trainer" (provisional, the user was offline 2026-11-22) |
| initial game options (title-screen reset) | Startoptionen | Route 29 tips sign | Own |
| Tuscany, Monica, Wesley (dialogue) | Dietlinde, Monja, Mitko | Route 29 and the other weekday siblings | Kristall; the Wonder Trade list squeezes Dietlinde to "Ditlind" (row above) |
| Fruit tree: "It's a fruit-bearing tree." / "Hey! It's <fruit>!" / "Obtained a/two/three <fruit>!" | "Es ist ein Obstbaum." / "Hey! Das ist eine <fruit>!" / "Du erhältst eine/zwei/drei <fruit>!" | Fruit trees | Kristall, except the counts: Polished's own, and Kristall's "<fruit> erhalten!" can't follow a count in Polished's command order. "eine" fits every fruit (all "…beere", "Aprikoko") |
| "<PLAYER> found <item>!" / "<PLAYER> gained <n> <items>." | "<PLAYER> findet <item>!" / "<PLAYER> erhält <n> <items>." | Item balls, hidden items, gifts of several | Kristall's frames |
| Move tutor: "I'll teach your #mon how to use <move> for a Silver Leaf." / "Should I teach your #mon <move>?" / "All done! Your #mon learned to use <move>!" | "Gegen ein Silberblatt bringe ich deinem #mon <move> bei." / "Soll ich deinem #mon <move> beibringen?" / "Fertig! Dein #mon beherrscht jetzt <move>!" | Polished's Silver Leaf tutors | Own |
| Hidden Grotto: "Look! You've found a narrow path! Will you follow it?" | "Sieh mal! Du hast einen engen Pfad entdeckt! Möchtest du ihm folgen?" | Hidden grottoes | Own |
| "<PLAYER> registered <name>'s number." | "<PLAYER> speichert <name>s Nummer." | Phone numbers | Kristall; the longest contact name (Rosemarie, 9) fits |
