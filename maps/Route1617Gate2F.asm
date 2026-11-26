Route1617Gate2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  7, ROUTE_16_17_GATE_2F, -1

	def_coord_events

	def_bg_events
	bg_event  1,  2, BGEVENT_UP, Route1617Gate2FBinoculars1
	bg_event  6,  2, BGEVENT_UP, Route1617Gate2FBinoculars2

	def_object_events
	object_event 2, 5, SPRITE_PSYCHIC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route1617Gate2FPsychicScript, -1

Route1617Gate2FPsychicScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_TRICK_ROOM_INTRO
	iftruefwd Route1617Gate2FTutorTrickRoomScript
	writetext Route1617Gate2FPsychicText
	waitbutton
	setevent EVENT_LISTENED_TO_TRICK_ROOM_INTRO
Route1617Gate2FTutorTrickRoomScript:
	writetext Text_Route1617Gate2FTutorTrickRoom
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writetext Text_Route1617Gate2FTutorQuestion
	yesorno
	iffalsefwd .TutorRefused
	setval TRICK_ROOM
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpthisopenedtext

	text "Wie schade."
	done

.NoSilverLeaf
	jumpthisopenedtext

	text "Aber zuerst brau-"
	line "che ich ein"
	cont "Silberblatt."

	para "Komm wieder, wenn"
	line "du eins hast."
	done

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext

	text "Meine Technik ist"
	line "ziemlich raffi-"
	cont "niert, oder?"
	done

Route1617Gate2FBinoculars1:
	jumpthistext

	text "Du schaust durch"
	line "das Fernglas."

	para "Das ist das"
	line "Kaufhaus von"
	cont "Prismania City!"
	done

Route1617Gate2FBinoculars2:
	jumpthistext

	text "Du schaust durch"
	line "das Fernglas."

	para "Da führt ein lan-"
	line "ger Weg über das"
	cont "Wasser!"
	done

Route1617Gate2FPsychicText:
	text "Nicht weit von"
	line "hier lebt ein"
	cont "Seher,"

	para "der im #mon-"
	line "Kampf seine"

	para "Umgebung verändern"
	line "kann."

	para "Er ist mein Vor-"
	line "bild, darum habe"

	para "ich an meiner"
	line "eigenen Technik"
	cont "gearbeitet."
	done

Text_Route1617Gate2FTutorTrickRoom:
	text "Ich kann deinen"
	line "#mon die"
	cont "Attacke Bizarro-"
	cont "raum beibringen."

	para "Damit greifen"
	line "langsamere #mon"

	para "eine Zeit lang vor"
	line "schnelleren an."
	done

Text_Route1617Gate2FTutorQuestion:
	text "Ist ein Silber-"
	line "blatt ein fairer"
	cont "Preis?"
	done
