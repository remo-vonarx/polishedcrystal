; If you change the item names, also update PluralTable (see data/text/plural_table.asm)

	; use rawchars so VWF will work in the PC
	setcharmap no_ngrams

ItemNames::
	list_start
	li "Parkball"

	li "Pokéball"
	li "Superball"
	li "Hyperball"
	li "Meisterball"

	li "Safariball"

	li "Levelball"
	li "Köderball"
	li "Mondball"
	li "Freundesball"
	li "Turboball"
	li "Schwerball"
	li "Sympaball"

	li "Wiederball"
	li "Timerball"
	li "Nestball"
	li "Netzball"
	li "Tauchball"
	li "Luxusball"
	li "Heilball"
	li "Flottball"
	li "Finsterball"
	li "Traumball"

	li "Premierball"
	li "Jubelball"

	li "Trank"
	li "Supertrank"
	li "Hypertrank"
	li "Top-Trank"

	li "Gegengift"
	li "Feuerheiler"
	li "Para-Heiler"
	li "Aufwecker"
	li "Eisheiler"
	li "Hyperheiler"
	li "Top-Genesung"

	li "Beleber"
	li "Top-Beleber"

	li "Äther"
	li "Top-Äther"
	li "Elixier"
	li "Top-Elixier"

	li "KP-Plus"
	li "Protein"
	li "Eisen"
	li "Carbon"
	li "Kalzium"
	li "Zink"
	li "Sonderbonbon"
	li "AP-Plus"
	li "AP-Top"

	li "Tafelwasser"
	li "Sprudel"
	li "Limonade"
	li "Kuhmuh-Milch"
if DEF(FAITHFUL)
	li "Wutkeks"
else
	li "Cake of Rage"
endc
	li "PewterCrunch"

	li "Energiestaub"
	li "Kraftwurzel"
	li "Heilpuder"
	li "Vitalkraut"

	li "Zauberasche"

	li "Amrenabeere"
	li "Maronbeere"
	li "Pirsifbeere"
	li "Fragiabeere"
	li "Wilbirbeere"
	li "Jonagobeere"
	li "Sinelbeere"
	li "Persimbeere"
	li "Prunusbeere"
	li "Tsitrubeere"

	li "Giefebeere"

	li "Granabeere"
	li "Setangbeere"
	li "Qualotbeere"
	li "Honmelbeere"
	li "Labrusbeere"
	li "Tamotbeere"

	li "Lydzibeere"
	li "Linganbeere"
	li "Salkabeere"
	li "Tahaybeere"
	li "Apikobeere"
	li "Lansatbeere"
	li "Krambobeere"

	li "Enigmabeere"

	li "Eipfelbeere"

	li "Jabocabeere"
	li "Roselbeere"

	li "Akibeere"
	li "Tarabeere"

	li "Beerensaft"

	li "Schutz"
	li "Superschutz"
	li "Top-Schutz"

	li "Fluchtseil"
	li "Poképuppe"

	li "Mulch"

if DEF(FAITHFUL)
	li "Honig"
else
	li "Sweet Honey"
endc

	li "X-Angriff"
	li "X Defend"
	li "X-Initiative"
	li "X-Sp.-Ang."
	li "X-Sp.-Vert."
	li "X Accuracy"
	li "Dire Hit"
if DEF(FAITHFUL)
	li "Megablock"
else
	li "Guard Stats"
endc

	li "Ability Cap"
	li "AbilityPatch"

	li "Blattstein"
	li "Feuerstein"
	li "Wasserstein"
	li "Donnerstein"
	li "Eisstein"
	li "Mondstein"
	li "Sonnenstein"
	li "Finsterstein"
	li "Leuchtstein"
	li "Ewigstein"

	li "EP-Teiler"

	li "Seidenschal"
	li "Schwarzgurt"
	li "Sharp Beak"
	li "Giftstich"
	li "Pudersand"
	li "Granitstein"
	li "Silberstaub"
	li "Bannsticker"
	li "Metallmantel"
	li "Holzkohle"
	li "Zauberwasser"
	li "Wundersaat"
	li "Magnet"
	li "Krummlöffel"
	li "Ewiges Eis"
	li "Drachenzahn"
	li "BlackGlasses"
	li "Feendaune"

	li "Berserk-Gen"
	li "Blendpuder"
	li "Flinkklaue"
	li "King-Stein"
	li "Münzamulett"
	li "Cleanse Tag"
	li "Rauchball"
	li "Fokusband"
	li "Glücks-Ei"
	li "Überreste"

	li "Sanftglocke"
	li "Shell Bell"

	li "Muskelband"
	li "Schlaubrille"
	li "Expertengurt"
	li "Lichtlehm"
	li "Leben-Orb"
	li "Fokusgurt"
	li "Metronom"
	li "Eisenkugel"
	li "Lagging Tail"
	li "Fatumknoten"
	li "Griffklaue"
	li "Wechselhülle"
	li "Grosswurzel"

	li "Evolith"
	li "Beulenhelm"
	li "Luftballon"
	li "Rote Karte"
	li "Klammerband"
	li "Fluchtknopf"

	li "Weak Policy"
	li "Assault Vest"
	li "Schutzbrille"

	li "Protect Pads"

	li "Halsspray"
	li "Fluchttasche"
	li "Heavy Boots"
	li "BlundrPolicy"
	li "Room Service"

	li "Clear Amulet"
	li "Kopierkraut"
	li "Boxhandschuh"
	li "Tarnumhang"
	li "Loaded Dice"

	li "Kugelblitz"
	li "Lauchstange"
	li "Kampfknochen"
	li "Lucky Punch"
	li "Metallstaub"
	li "Flottstaub"
	li "Armor Suit"

	li "Scope-Linse"
	li "Grosslinse"
	li "Zoomlinse"

	li "Mentalkraut"
	li "Energiekraut"
	li "Schlohkraut"

	li "Nassbrocken"
	li "Heissbrocken"
	li "Glattbrocken"
	li "Eisbrocken"

	li "Wahlband"
	li "Wahlschal"
	li "Wahlbrille"

	li "Heiss-Orb"
	li "Toxik-Orb"
	li "Giftschleim"

	li "Machoschiene"
	li "Machtgewicht"
	li "Machtreif"
	li "Machtgurt"
	li "Machtlinse"
	li "Machtband"
	li "Machtkette"

	li "Dragon Scale"
	li "Upgrade"
	li "Dubiosdisc"
	li "Schützer"
	li "Stromisierer"
	li "Magmaisierer"
	li "Scharfzahn"
	li "Scharfklaue"
	li "Ovaler Stein"
	li "Odd Souvenir"
	li "Linking Cord"

	li "Silberblatt"
	li "Goldblatt"
	li "Mint Leaf"
	li "Bottle Cap"

	li "Nugget"
	li "Riesennugget"
	li "Minipilz"
	li "Riesenpilz"
	li "Duftpilz"
	li "Perle"
	li "Riesenperle"
	li "Triperle"
	li "Sternenstaub"
	li "Sternenstück"
	li "Ziegelstein"
	li "Steinknochen"
	li "Flegmon-Rute"

	li "Helixfossil"
	li "Domfossil"
	li "Altbernstein"

	li "Blumenbrief"
	li "Surferbrief"
	li "Cyanbrief"
	li "Abbildbrief"
	li "Herzbrief"
	li "Anara-Brief"
	li "Morph-Brief"
	li "Kobaltbrief"
	li "Melodiebrief"
	li "Trugbrief"
	assert_list_length NUM_ITEMS + 1

	setcharmap default
