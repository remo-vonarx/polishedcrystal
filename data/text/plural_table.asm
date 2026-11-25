	; use rawchars so `plural` can reverse strings
	setcharmap no_ngrams

MACRO plural
	for i, CHARLEN(\1)
		db STRCHAR(\1, CHARLEN(\1) - 1 - i)
	endr
	db "@", \2, "@"
ENDM

PluralTable:
	; German keeps the name as it is. In a text, text_plural comes right after
	; the number and turns "3 Trank" into "3x Trank".
	plural "0",          "0x"
	plural "1",          "1x"
	plural "2",          "2x"
	plural "3",          "3x"
	plural "4",          "4x"
	plural "5",          "5x"
	plural "6",          "6x"
	plural "7",          "7x"
	plural "8",          "8x"
	plural "9",          "9x"
	plural "",           ""          ; names (the pluralize command)

	setcharmap default
