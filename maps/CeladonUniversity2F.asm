CeladonUniversity2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 23,  8, CELADON_UNIVERSITY_1F, 3
	warp_event  7,  0, CELADON_UNIVERSITY_CAFETERIA, 1
	warp_event  3,  8, CELADON_UNIVERSITY_WILLOWS_OFFICE, 1
	warp_event 13,  0, CELADON_UNIVERSITY_HYPER_TEST_ROOM, 1
	warp_event 19,  8, CELADON_UNIVERSITY_WESTWOODS_OFFICE, 1
	warp_event 21,  0, CELADON_UNIVERSITY_POOL, 1
	warp_event  7,  8, CELADON_UNIVERSITY_NURSES_OFFICE, 1

	def_coord_events

	def_bg_events
	bg_event  6,  0, BGEVENT_JUMPTEXT, CeladonUniversity2FCafeteriaSignText
	bg_event 12,  0, BGEVENT_JUMPTEXT, CeladonUniversity2FHyperTestSignText
	bg_event 20,  0, BGEVENT_JUMPTEXT, CeladonUniversity2FPoolSignText
	bg_event  2,  8, BGEVENT_JUMPTEXT, CeladonUniversity2FWillowsOfficeSignText
	bg_event  6,  8, BGEVENT_JUMPTEXT, CeladonUniversity2FNursesOfficeSignText
	bg_event 18,  8, BGEVENT_JUMPTEXT, CeladonUniversity2FWestwoodsOfficeSignText
	bg_event 16,  1, BGEVENT_READ, CeladonUniversity2FMagikarpSign
	bg_event 24,  1, BGEVENT_READ, CeladonUniversity2FCuboneSign

	def_object_events
	object_event  2,  3, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, CeladonUniversity2FCooltrainerfScript, -1
	object_event  5,  3, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FCooltrainermText, -1
	object_event 17,  2, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FYoungster1Text, -1
	object_event 11,  7, SPRITE_COWGIRL, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FCowgirlText, -1
	object_event  4,  9, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FBug_catcherText, -1
	object_event 13, 13, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FLassText, -1
	object_event 21, 11, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity2FYoungster2Text, -1

CeladonUniversity2FCooltrainerfScript:
	checkevent EVENT_GOT_ANTIDOTE_IN_UNIVERSITY
	iftrue_jumptextfaceplayer .Text5
	faceplayer
	opentext
	writetext .Text1
	waitbutton
	writetext .Text2
	yesorno
	iffalse_jumpopenedtext .Text6
	takeitem FRESH_WATER
	iffalse_jumpopenedtext .Text6
	writetext .Text3
	waitbutton
	writetext .Text4
	waitbutton
	verbosegiveitem ANTIDOTE, iffalsefwd .NoRoomForAntidote
	setevent EVENT_GOT_ANTIDOTE_IN_UNIVERSITY
	jumpthisopenedtext

.Text5:
	text "Gegengift heilt"
	line "Vergiftungen bei"
	cont "#mon, aber ein"

	para "Mensch würde davon"
	line "krank werden."
	done

.NoRoomForAntidote:
	; Refund the Fresh Water just removed from the Bag.
	giveitem_unsafe FRESH_WATER
	jumpthisopenedtext

	text "Oh… Dann behalte"
	line "dein Tafelwasser…"
	done

.Text1:
	text "Ich hab so Durst!"

	para "Aber ich habe kein"
	line "Kleingeld für die"
	cont "Getränkeautomaten…"

	para "Hast du vielleicht"
	line "Tafelwasser?"
	done

.Text2:
	text "Ein Tafelwasser"
	line "hergeben?"
	done

.Text3:
	text "<PLAYER> gibt das"
	line "Tafelwasser weg."
	done

.Text4:
	text "Vielen Dank!"
	line "Hier, nimm das!"
	done

.Text6:
	text "Oh… Aber ich hab"
	line "so Durst…"
	done

CeladonUniversity2FCooltrainermText:
	text "In der Mensa ist"
	line "es ziemlich voll,"

	para "darum esse ich"
	line "lieber im Flur."
	done

CeladonUniversity2FYoungster1Text:
	text "Ich bin wieder"
	line "durch den Hyper-"
	cont "test gefallen…"

	para "Aber ich gebe"
	line "nicht auf!"
	done

CeladonUniversity2FCowgirlText:
	text "Meine Klasse macht"
	line "einen Ausflug in"
	cont "die Safari-Zone!"
	done

CeladonUniversity2FBug_catcherText:
	text "Prof. Willow"
	line "schickt seine"
	cont "Assistenten durch"

	para "die ganze Stadt,"
	line "um die #mon zu"

	para "erforschen, die"
	line "hier leben."
	done

CeladonUniversity2FLassText:
	text "Erika ist nicht"
	line "nur Arenaleiterin"
	cont "von Prismania,"

	para "sie war hier an"
	line "der Uni auch die"
	cont "Jahrgangsbeste."

	para "Ich wünschte, ich"
	line "wäre so cool wie"
	cont "sie."
	done

CeladonUniversity2FYoungster2Text:
	text "Prof. Westwood ist"
	line "etwas exzentrisch."

	para "Manchmal ent-"
	line "schuldigt er sich"

	para "bei den Porträts"
	line "seiner Vorfahren."
	done

CeladonUniversity2FCafeteriaSignText:
	text "Mensa"
	done

CeladonUniversity2FHyperTestSignText:
	text "Hypertest-Raum"
	done

CeladonUniversity2FPoolSignText:
	text "Schwimmbad"
	done

CeladonUniversity2FWillowsOfficeSignText:
	text "Prof. Willows"
	line "Büro"
	done

CeladonUniversity2FNursesOfficeSignText:
	text "Krankenzimmer"
	done

CeladonUniversity2FWestwoodsOfficeSignText:
	text "Prof. Westwoods"
	line "Büro"
	done

CeladonUniversity2FMagikarpSign:
	reanchormap
	pokepic MAGIKARP, MAGIKARP_ORCA_FORM
	cry MAGIKARP
	waitbutton
	closepokepic
	jumpthistext

	text "Ein Karpador"
	line "schwimmt herum."
	done

CeladonUniversity2FCuboneSign:
	reanchormap
	trainerpic CUBONE_ARMOR
	waitbutton
	closepokepic
	jumpthistext

	text "Das sind der"
	line "Kampfknochen und"
	cont "der Schädelhelm"
	cont "eines Tragosso."
	done
