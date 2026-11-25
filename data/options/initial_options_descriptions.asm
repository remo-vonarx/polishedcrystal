; These are in the same order as InitialOptions_CallOptionRoutine.Pointers,
; not the *_OPT bit order.
InitialOptionDescriptions:
	table_width 2
	dw .Natures
	dw .Abilities
	dw .PSS
	dw .EVs
	dw .Experience
	dw .AffectionBonus
	dw .RTC
	dw .PerfectIVs
	dw .TradedMon
	dw .EvolveInBattle
	dw .ColorVariation
	assert_table_length NUM_INITIAL_MENU_OPTIONS

.Natures:
	text "Wesen erhöhen"
	line "einen Statuswert"
	cont "und senken einen"

	para "anderen um je 10%."

	para "Eingeführt in"
	line "Generation 3."
	prompt

.Abilities:
	text "Fähigkeiten können"
	line "im Kampf und"

	para "außerhalb davon"
	line "Wirkung haben."

	para "Eingeführt in"
	line "Generation 3."
	prompt

.PSS:
	text "Attacken sind"
	line "physisch oder"
	cont "speziell, egal"
	cont "welchen Typ sie"
	cont "haben."

	para "Eingeführt in"
	line "Generation 4."
	prompt

.EVs:
	assert MODERN_MAX_EV % 4 == 0
	text "FP erhöhen deine"
	line "Statuswerte um bis"
	cont STRFMT("zu %d Punkte: 1", MODERN_MAX_EV / 4) ; 252 / 4 == 63
	cont "Punkt je 4 FP."

	para "Du kannst für"
	line "jeden Wert das"
	cont "Maximum von {d:MODERN_MAX_EV}"
	cont "FP erlauben, wie"

	para "früher mit der"
	line "Statuserfahrung,"

	para "oder sie auf"
	line "insgesamt {d:MODERN_EV_LIMIT}"
	cont "begrenzen."

	para "FP ersetzten die"
	line "Statuserfahrung in"
	cont "Generation 3."
	prompt

.Experience:
	text "Die alte Formel"
	line "für EP aus"

	para "Generation 1 bis 4"
	line "skaliert nicht."

	para "Die neue aus"
	line "Generation 5, seit"

	para "Generation 7"
	line "wieder da, gibt"
	cont "mehr EP für"

	para "stärkere Gegner"
	line "und weniger für"

	para "schwächere."

	para "EP lassen sich als"
	line "Herausforderung"

	para "auch ganz"
	line "abschalten."

	para "EP-Bonbons und"
	line "Sonderbonbons"

	para "wirken dann"
	line "trotzdem."
	prompt

.AffectionBonus:
	text "#mon, die mit"
	line "dir eng befreundet"
	cont "sind, haben im"

	para "Kampf Vorteile."

	para "Eingeführt in"
	line "Generation 6."
	prompt

.RTC:
	text "Die Echtzeituhr"
	line "verfolgt die"
	cont "Uhrzeit."

	para "Unterstützt dein"
	line "Modul oder dein"
	cont "Emulator sie"
	cont "nicht, schalte sie"
	cont "ab:"

	assert 24 % NO_RTC_SPEEDUP == 0
	para "Dann dauert ein"
	line "Tag im Spiel"
	cont STRFMT("%d Stunden.", 24 / NO_RTC_SPEEDUP) ; 24 / 6 == 4
	prompt

.PerfectIVs:
	text "Statuswerte werden"
	line "so berechnet, als"

	para "wären alle DVs"
	line "perfekte 15, für"
	cont "deine #mon und"
	cont "die der Gegner."
	prompt

.TradedMon:
	text "Getauschte #mon"
	line "gehorchen dir und"
	cont "du darfst ihnen"

	para "Spitznamen geben,"
	line "aber sie erhalten"

	para "keinen EP-Bonus."
	prompt

.EvolveInBattle:
	text "Deine #mon"
	line "können sich in"

	para "Kämpfen gegen"
	line "Trainer"
	cont "entwickeln."

	para "Nach dem Vorbild"
	line "der Anime-Kämpfe."
	prompt

.ColorVariation:
	text "Einzelne #mon,"
	line "ob normal oder"
	cont "schillernd, haben"

	para "leicht andere"
	line "Farben."

	para "Die Abweichung ist"
	line "pseudozufällig,"
	cont "nicht abhängig von"

	para "den Statuswerten."

	para "Nach dem Vorbild"
	line "der Farben in"
	cont "Stadium, die"

	para "auf Spitznamen"
	line "beruhen."
	prompt

InitialOptionsDoneDescription:
	text "Auswahl sichern"
	line "und loslegen!"
	prompt
