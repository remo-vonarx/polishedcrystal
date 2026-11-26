UnownWalls:
	db $0a, $26, $48, $04, $0e, $46, $ff ; F, L, U, C, H, T
	db $02, $26, $20, $46, $62, $ff ; B, L, I, T, Z
	db $4c, $00, $44, $44, $08, $42, $ff ; W, A, S, S, E, R
	db $0a, $08, $08, $ff ; F, E, E

MenuHeaders_UnownWalls:
; FLUCHT
	db MENU_BACKUP_TILES
	menu_coords 3, 4, 16, 9
; BLITZ
	db MENU_BACKUP_TILES
	menu_coords 4, 4, 15, 9
; WASSER
	db MENU_BACKUP_TILES
	menu_coords 3, 4, 16, 9
; FEE
	db MENU_BACKUP_TILES
	menu_coords 6, 4, 13, 9
