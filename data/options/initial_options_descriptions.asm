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
	text "Wesen heben einen"
	line "Wert, senken einen"
	cont "anderen um 10%."

	para "Eingeführt in der"
	line "3. Generation."
	prompt

.Abilities:
	text "Fähigkeiten können"
	line "innerhalb und"

	para "ausserhalb von"
	line "Kämpfen wirken."

	para "Eingeführt in der"
	line "3. Generation."
	prompt

.PSS:
	text "Ob eine Attacke"
	line "physisch oder spe-"
	cont "ziell ist, hängt"

	para "nicht vom Typ ab."

	para "Eingeführt in der"
	line "4. Generation."
	prompt

.EVs:
	assert MODERN_MAX_EV % 4 == 0
	text "Je 4 Fleisspunkte"
	line "erhöhen einen Wert"
	cont STRFMT("um 1, bis zu %d.", MODERN_MAX_EV / 4) ; 252 / 4 == 63

	para "Du kannst wählen,"
	line "ob jeder Wert bis"

	para "zu {d:MODERN_MAX_EV} Fleiss-"
	line "punkte haben darf,"
	cont "wie bei Status-EP,"

	para "oder alle zusammen"
	line "höchstens {d:MODERN_EV_LIMIT}."

	para "Ersetzten in der"
	line "3. Generation die"
	cont "Status-EP."
	prompt

.Experience:
	text "Die alte EP-Formel"
	line "aus der 1. bis 4."

	para "Generation war"
	line "nicht skaliert."

	para "Die neue, aus der"
	line "5. und wieder ab"
	cont "der 7. Generation,"

	para "gibt mehr EP für"
	line "Siege über Gegner"
	cont "mit höherem Level"

	para "und weniger bei"
	line "niedrigerem."

	para "EP lassen sich als"
	line "Herausforderung"
	cont "auch abschalten,"

	para "aber EP-Bonbons"
	line "und Sonderbonbons"
	cont "wirken auch dann."
	prompt

.AffectionBonus:
	text "Deine #mon er-"
	line "halten Vorteile im"
	cont "Kampf, wenn sie"

	para "eng mit dir be-"
	line "freundet sind."

	para "Eingeführt in der"
	line "6. Generation."
	prompt

.RTC:
	text "Verfolge die Zeit"
	line "mit der Funktion"
	cont "der Echtzeituhr."

	para "Hat dein Modul"
	line "oder Emulator kei-"
	cont "ne Echtzeituhr,"

	assert 24 % NO_RTC_SPEEDUP == 0
	para "schalte dies aus:"
	line "Jeder Tag im Spiel"
	cont STRFMT("dauert %d Stunden.", 24 / NO_RTC_SPEEDUP) ; 24 / 6 == 4
	prompt

.PerfectIVs:
	text "Werte werden be-"
	line "rechnet, als wären"

	para "alle DVs perfekte"
	line "15er, bei dir wie"
	cont "bei den Gegnern."
	prompt

.TradedMon:
	text "Getauschte #mon"
	line "gehorchen dir und"
	cont "können umbenannt"

	para "werden, erhalten"
	line "aber keine Bonus-"
	cont "Erfahrungspunkte."
	prompt

.EvolveInBattle:
	text "Deine #mon kön-"
	line "nen sich während"
	cont "Trainerkämpfen"

	para "entwickeln."

	para "Inspiriert von den"
	line "Kämpfen im Anime."
	prompt

.ColorVariation:
	text "Jedes #mon, ob"
	line "normal oder schil-"
	cont "lernd, erhält"

	para "leicht abgewandel-"
	line "te Farben."

	para "Die Abweichung ist"
	line "pseudozufällig und"

	para "unabhängig von der"
	line "Güte der Werte."

	para "Inspiriert von der"
	line "Farbvariation in"

	para "<PK><MN> Stadium, die"
	line "vom Spitznamen ab-"
	cont "hing."
	prompt

InitialOptionsDoneDescription:
	text "Speichere deine"
	line "Wahl und leg los!"
	prompt
