EcruteakCherishBallHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 16
	warp_event  4,  7, ECRUTEAK_CITY, 16

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_JUMPSTD, radio2

	def_object_events
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakCherishBallHouseGrampsScript, -1
	object_event  5,  4, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakCherishBallHouseGrannyText, -1

EcruteakCherishBallHouseGrampsScript:
	checkevent EVENT_GOT_CHERISH_BALL_FROM_ECRUTEAK
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem CHERISH_BALL, iffalse_endtext
	setevent EVENT_GOT_CHERISH_BALL_FROM_ECRUTEAK
	jumpthisopenedtext

.Text2:
	text "Die Zeit mit"
	line "#mon werde ich"

	para "immer in Ehren"
	line "halten."
	done

.Text1:
	text "Ich habe ein lan-"
	line "ges Leben gelebt"

	para "und Erinnerungen,"
	line "die ich für immer"
	cont "in Ehren halte."

	para "Nimm das und"
	line "schaffe eine neue"
	cont "Erinnerung, die"
	cont "dir teuer ist."
	done

EcruteakCherishBallHouseGrannyText:
	text "Die Mode ändert"
	line "sich mit den"
	cont "Jahren,"

	para "aber Teak City"
	line "bleibt so tradi-"
	cont "tionell wie eh"
	cont "und je."
	done
