BadEggRLE:
	db UNOWN, 1 ; $c6
	db $00, 1
	db HIDDEN_POWER, 1 ; $ed
	db $00, 17
	db ABILITY_1 | QUIRKY, 1 ; $38
	db MALE | IS_EGG_MASK | UNOWN_QUESTION_FORM, 1 ; $68
	db $00, 9
	db EGG_LEVEL, 1 ; $01
	db $00, 16
	db "S", 1 ; $92
	db "c", 1 ; $a2
	db "h", 1 ; $a7
	db "l", 1 ; $ab
	db ".", 1 ; $9c
	db " ", 1 ; $7f
	db "E", 1 ; $84
	db "i", 1 ; $a8
	db "@", 3 ; $53
	db "?", 1 ; $9e
	db "@", 7 ; $53
	db $00, 3
	db $ff ; end
