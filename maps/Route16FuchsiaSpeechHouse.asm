Route16FuchsiaSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, ROUTE_16_NORTH, 1
	warp_event  3,  7, ROUTE_16_NORTH, 1

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_JUMPSTD, picturebookshelf

	def_object_events
	object_event  2,  3, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route16FuchsiaSpeechHouseSuperNerdText, -1
	object_event  5,  4, SPRITE_LADY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route16FuchsiaSpeechHouseLadyScript, -1

Route16FuchsiaSpeechHouseSuperNerdText:
	text "Am Ende des"
	line "Radwegs ist"

	para "Fuchsania City."
	done

Route16FuchsiaSpeechHouseLadyScript:
	checkevent EVENT_GOT_BLUNDRPOLICY_FROM_ROUTE_16_NORTH
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem BLUNDRPOLICY, iffalse_endtext
	setevent EVENT_GOT_BLUNDRPOLICY_FROM_ROUTE_16_NORTH
	jumpthisopenedtext

.Text2:
	text "Die Berühmtheit,"
	line "die hier wohnte…"

	para "Wo sie wohl hin-"
	line "gezogen ist?"
	done

.Text1:
	text "Die Berühmtheit,"
	line "die früher hier"

	para "wohnte, ist vor"
	line "drei Jahren weg-"
	cont "gezogen."

	para "Aber sie hat"
	line "dieses Item"
	cont "zurückgelassen."
	done
