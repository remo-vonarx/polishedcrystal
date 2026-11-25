StatStrings:
; entries correspond to stat constants
	table_width 1
	dr .health
	dr .attack
	dr .defense
	dr .speed
	dr .sp_atk
	dr .sp_def
	assert_table_length NUM_STATS

.health:  db "KP@"
.attack:  db "Angriff@"
.defense: db "Verteidigung@"
.speed:   db "Initiative@"
.sp_atk:  db "Spez.-Angriff@"
.sp_def:  db "Spez.-Verteidigung@"
