CeladonDeptStore1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  7, CELADON_CITY, 1
	warp_event  8,  7, CELADON_CITY, 17
	warp_event 15,  0, CELADON_DEPT_STORE_2F, 2
	warp_event  2,  0, CELADON_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_JUMPTEXT, CeladonDeptStore1FDirectoryText

	def_object_events
	object_event 10,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonDeptStore1FReceptionistText, -1
	object_event 11,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonDeptStore1FGentlemanText, -1
	object_event  5,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonDeptStore1FTeacherText, -1

CeladonDeptStore1FReceptionistText:
	text "Hallo! Willkommen"
	line "im Einkaufszentrum"
	cont "von Prismania"
	cont "City!"

	para "Die Übersicht"
	line "ist an der Wand."
	done

CeladonDeptStore1FGentlemanText:
	text "Dieses Einkaufs-"
	line "zentrum gehört"

	para "derselben Kette"
	line "an, wie das in"
	cont "Dukatia City."

	para "Sie wurden beide"
	line "zur selben Zeit"
	cont "renoviert."
	done

CeladonDeptStore1FTeacherText:
	text "Ich bin zum"
	line "ersten Mal hier."

	para "Es ist so groß…"

	para "Ich habe Angst,"
	line "mich zu verlaufen."
	done

CeladonDeptStore1FDirectoryText:
	text "EG: Kunden-"
	line "    Information"

	para "1S: Zubehör für"
	line "    Trainer"

	para "2S: Technik-Laden"

	para "3S: Geschenk-"
	line "    artikel"

	para "4S: Drogerie"

	para "5S: Dachterrasse"
	done
