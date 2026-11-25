ElevatorFloorNames:
	table_width 1
	dr .B4F
	dr .B3F
	dr .B2F
	dr .B1F
	dr ._1F
	dr ._2F
	dr ._3F
	dr ._4F
	dr ._5F
	dr ._6F
	dr ._7F
	dr ._8F
	dr ._9F
	dr ._10F
	dr ._11F
	dr .Roof
	assert_table_length NUM_FLOORS

.B4F:  db "U4S@"
.B3F:  db "U3S@"
.B2F:  db "U2S@"
.B1F:  db "U1S@"
._1F:  db "EG@"
._2F:  db "1S@"
._3F:  db "2S@"
._4F:  db "3S@"
._5F:  db "4S@"
._6F:  db "5S@"
._7F:  db "6S@"
._8F:  db "7S@"
._9F:  db "8S@"
._10F: db "9S@"
._11F: db "10S@"
.Roof: db "Dach@"
