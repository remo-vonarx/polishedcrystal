Route5_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 17, 27, ROUTE_5_UNDERGROUND_PATH_ENTRANCE, 1
	warp_event  8, 31, ROUTE_5_SAFFRON_CITY_GATE, 1
	warp_event  9, 31, ROUTE_5_SAFFRON_CITY_GATE, 2
	warp_event 10, 21, ROUTE_5_CLEANSE_TAG_SPEECH_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 18, 28, BGEVENT_JUMPTEXT, Route5UndergroundPathSignText
	bg_event  5, 27, BGEVENT_JUMPTEXT, Route5AdvancedTipsSignText
	bg_event 10, 21, BGEVENT_JUMPTEXT, HouseForSaleSignText

	def_object_events

Route5UndergroundPathSignText:
	text "Unterführung"

	para "Azuria City -"
	line "Orania City"
	done

Route5AdvancedTipsSignText:
	text "Tipps für Profis!"

	para "Das Berserk-Gen"
	line "ist ein starkes"

	para "Item zum Tragen,"
	line "verwirrt aber."

	para "Doch ein #mon"
	line "mit der Fähigkeit"

	para "Tempomacher wird"
	line "nicht verwirrt!"
	done

HouseForSaleSignText:
	text "Was ist das?"

	para "Haus zu verkaufen…"
	line "Hier wohnt"
	cont "niemand."
	done
