InitialOptionNames:
	table_width 2
	dw .Natures
	dw .Abilities
	dw .PSS
	dw .EVs
	dw .Experience
	dw .Affection
	dw .RTC
	dw .PerfectStats
	dw .TradedMon
	dw .EvolveInBattle
	dw .ColorVariation
	assert_table_length NUM_INITIAL_MENU_OPTIONS

.Natures:
	db "Wesen@"
.Abilities:
	db "Fähigkeiten@"
.PSS:
	db "Phys/Spez-Split@"
.EVs:
	db "Fleisspunkte@"
.Experience:
	db "EP-Zuwachs@"
.Affection:
	db "Zuneigungsbonus@"
.RTC:
	db "Echtzeituhr@"
.PerfectStats:
	db "Perfekte Werte@"
.TradedMon:
	db "Tausch-<PK><MN> folgen@"
.EvolveInBattle:
	db "Kampfentwicklung@"
.ColorVariation:
	db "Farbvariation@"
