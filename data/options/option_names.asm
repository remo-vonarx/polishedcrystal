OptionNames:
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
	db "Text-Tempo@"
.TextAutoscroll:
	db "Auto-Textlauf@"
.Frame:
	db "Rahmen@"
.Typeface:
	db "Schriftart@"
.Keyboard:
	db "Tastatur@"
.Sound:
	db "Sound@"
.BattleEffects:
	db "Kampfanimation@"
.BattleStyle:
	db "Kampfstil@"
.Nicknames:
	db "Spitznamen@"
.RunningShoes:
	db "Turbotreter@"
.TurningSpeed:
	db "Dreh-Tempo@"
.ClockFormat:
	db "Uhrzeit-Format@"
.PokedexUnits:
	db "#dex-Maße@"
