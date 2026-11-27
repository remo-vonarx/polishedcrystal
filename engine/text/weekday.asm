_PrintDayOfWeek::
	push hl
	push bc
	ld c, a
	ld b, 0
	ld hl, .Days
	add hl, bc
	ld c, [hl]
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	rst PlaceString
	pop hl
	ret

.Days:
	dr .Sun
	dr .Mon
	dr .Tues
	dr .Wednes
	dr .Thurs
	dr .Fri
	dr .Satur

.Sun:    db "Sonntag@"
.Mon:    db "Montag@"
.Tues:   db "Dienstag@"
.Wednes: db "Mittwoch@"
.Thurs:  db "Donnerstag@"
.Fri:    db "Freitag@"
.Satur:  db "Samstag@"
