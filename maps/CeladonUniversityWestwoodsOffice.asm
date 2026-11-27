CeladonUniversityWestwoodsOffice_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  5, CELADON_UNIVERSITY_2F, 5
	warp_event  4,  5, CELADON_UNIVERSITY_2F, 5

	def_coord_events

	def_bg_events
	bg_event  2,  0, BGEVENT_JUMPTEXT, CeladonUniversityWestwoodsOfficeSignpost1Text
	bg_event  3,  0, BGEVENT_JUMPTEXT, CeladonUniversityWestwoodsOfficeSignpost2Text
	bg_event  4,  1, BGEVENT_JUMPTEXT, CeladonUniversityWestwoodsOfficeBookshelfText
	bg_event  5,  1, BGEVENT_JUMPTEXT, CeladonUniversityWestwoodsOfficeBookshelfText

	def_object_events
	object_event  4,  3, SPRITE_CHILD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonUniversityWestwoodsOfficeChildScript, -1
	object_event  1,  4, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptext, CeladonUniversityWestwoodsOfficeBookText, -1

CeladonUniversityWestwoodsOfficeChildScript:
	checkevent EVENT_GOT_RAGECANDYBAR_IN_UNIVERSITY
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem RAGECANDYBAR, iffalse_endtext
	setevent EVENT_GOT_RAGECANDYBAR_IN_UNIVERSITY
	jumpthisopenedtext

.Text2:
	text "Dann kaufe ich mir"
	line "eben Ramen in der"
	cont "Mensa."
	done

.Text1:
	text "Mir wurde gesagt,"
	line "hier gäbe es"
	cont "Gratis-Pizza!"

	para "Wo ist sie?"

	para "Ich bin so SAUER!"

	para "…Vielleicht sollte"
	line "ich weniger"
if DEF(FAITHFUL)
	cont "Wutkekse naschen."
else
	cont "Wutkekse naschen."
endc

	para "Du kannst den"
	line "hier haben."
	done

CeladonUniversityWestwoodsOfficeBookText:
	text "Liebes Tagebuch,"

	para "meine Arbeit an"
	line "den Einträgen für"

	para "den #dex wird"
	line "weiterhin gut"
	cont "aufgenommen."

	para "Ein Beweis, dass"
	line "man nicht immer"

	para "das Büro verlassen"
	line "muss, um Erfolg"
	cont "zu haben!"

	para "Mit den Berichten"
	line "anderer Leute"

	para "geht die Arbeit"
	line "bestens voran."
	done

CeladonUniversityWestwoodsOfficeSignpost1Text:
	text "Ein Porträt von"
	line "Westwood I."
	done

CeladonUniversityWestwoodsOfficeSignpost2Text:
	text "Ein Porträt von"
	line "Westwood III."
	done

CeladonUniversityWestwoodsOfficeBookshelfText:
	text "Die gesammelten"
	line "Werke von Prof."
	cont "Westwood."

	para "…Die lasse ich"
	line "lieber aus."
	done
