Route30BerrySpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, ROUTE_30, 1
	warp_event  3,  7, ROUTE_30, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route30BerryHousePokefanMScript, -1

Route30BerryHousePokefanMScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_MULCH_FROM_ROUTE_30_HOUSE
	iftruefwd .GotMulch
	writetext Route30BerrySpeechHouseMonEatBerriesText
	promptbutton
	verbosegiveitem MULCH, iffalse_endtext
	setevent EVENT_GOT_MULCH_FROM_ROUTE_30_HOUSE
.GotMulch:
	jumpthisopenedtext

	text "Ich kaufe Mulch"
	line "bester Qualität in"
	cont "Dukatia City."
	done

Route30BerrySpeechHouseMonEatBerriesText:
	text "Du weisst, dass"
	line "#mon Beeren"
	cont "fressen."

	para "Wenn man sie"
	line "pflückt, brauchen"
	cont "sie Zeit, um nach-"
	cont "zuwachsen,"

	para "aber mit Mulch auf"
	line "dem Boden geht das"
	cont "viel schneller!"

	para "Hier, ich teile"
	line "etwas mit dir!"
	done
