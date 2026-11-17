ItemPocketNames:
	table_width 1
	dr .Item
	dr .Medicine
	dr .Ball
	dr .TM ; impossible
	dr .Berry
	dr .Key ; impossible
	assert_table_length NUM_POCKETS

.Item:
	db "Item-Tasche@"
.Medicine:
	db "Med.Pocket@"
.Ball:
	db "Ball-Tasche@"
.TM:
	db "TM Pocket@"
.Berry:
	db "Berry Pocket@"
.Key:
	db "Basis-Items@"
