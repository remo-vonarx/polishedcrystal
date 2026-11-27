OptionsDescriptions:
	table_width 2
	dw .TextSpeed
	dw .TextAutoscroll
	dw .Frame
	dw .Typeface
	dw .Keyboard
	dw .Sound
	dw .BattleEffects
	dw .BattleStyle
	dw .Nicknames
	dw .RunningShoes
	dw .TurningSpeed
	dw .ClockFormat
	dw .PokedexUnits
	assert_table_length NUM_OPTIONS

.TextSpeed:
	text "Wie schnell Text"
	line "erscheint."
	prompt

.TextAutoscroll:
	text "Text läuft weiter,"
	line "solange bestimmte"
	cont "Knöpfe gedrückt"
	cont "sind."
	prompt

.Frame:
	text "Rahmen der meisten"
	line "Textfelder."
	prompt

.Typeface:
	text "Die Schrift für"
	line "normalen Text."
	prompt

.Keyboard:
	text "Die Tastatur für"
	line "Namen und Briefe."
	prompt

.Sound:
	text "Tonausgabe: Mono"
	line "(ein Kanal) oder"

	para "Stereo (zwei:"
	line "links und rechts)."
	prompt

.BattleEffects:
	text "Animationen von"
	line "Attacken und"
	cont "Statusproblemen."
	prompt

.BattleStyle:
	text "Wenn ein Gegner"
	line "besiegt ist:"

	para "Folgend: Der"
	line "nächste erscheint."

	para "Wechsel: Du kannst"
	line "zuerst wechseln."

	para "Ansage: Nennt dir"
	line "den nächsten."
	prompt

.Nicknames:
	text "Ob neue #mon"
	line "Spitznamen"
	cont "bekommen."
	prompt

.RunningShoes:
	text "Halte B, um zu"
	line "rennen, wenn die"

	para "Turbotreter aus"
	line "sind, oder um zu"

	para "gehen, wenn sie an"
	line "sind."
	prompt

.TurningSpeed:
	text "Wie schnell du in"
	line "der Welt die"
	cont "Richtung änderst."
	prompt

.ClockFormat:
	text "Die Anzeige der"
	line "Uhrzeit: 12 Std."
	cont "hat AM/PM."
	prompt

.PokedexUnits:
	text "Einheiten für"
	line "Größe und Gewicht"
	cont "im #dex:"

	para "Imperial: in Fuß,"
	line "Zoll und Pfund."

	para "Metrisch: in Meter"
	line "und Kilogramm."
	prompt

OptionsDoneDescription:
	text "Einstellungen"
	line "sichern und Menü"
	cont "schließen."
	prompt
