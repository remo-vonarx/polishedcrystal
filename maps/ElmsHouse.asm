ElmsHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  4, NEW_BARK_TOWN, 5
	warp_event  7,  5, NEW_BARK_TOWN, 5

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPTEXT, ElmsHouseFridgeText
	bg_event  6,  1, BGEVENT_JUMPTEXT, ElmsHousePCText
	bg_event  7,  1, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events
	object_event  1,  5, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, ElmsWifeText, -1
	object_event  4,  5, SPRITE_CHILD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, ElmsSonText, -1

ElmsWifeText:
	text "Hi, <PLAYER>! Mein"
	line "Mann ist immer so"

	para "beschäftigt. Ich"
	line "hoffe, es geht ihm"
	cont "gut."

	para "Wenn er sich in"
	line "seine #mon-"
	cont "Forschungen ver-"
	cont "tieft, vergisst er"
	cont "sogar zu essen."
	done

ElmsSonText:
	text "Wenn ich gross"
	line "bin, helfe ich"
	cont "meinem Papa!"

	para "Ich werde ein"
	line "grossartiger"
	cont "#mon-Professor!"
	done

ElmsHouseFridgeText:
	text "Hier ist etwas zu"
	line "essen. Es muss für"
	cont "die #mon sein."
	done

ElmsHousePCText:
	text "#mon. Woher"
	line "kommen sie?"

	para "Wohin gehen sie?"

	para "Warum war noch nie"
	line "jemand Zeuge der"
	cont "Geburt eines"
	cont "#mon?"

	para "Ich will es wis-"
	line "sen. Ich werde"

	para "mein Leben in den"
	line "Dienst der"
	cont "#mon-Forschung"
	cont "stellen!"

	para "…"

	para "Dies ist ein Teil"
	line "von Prof. Linds"
	cont "Aufzeichnungen."
	done
