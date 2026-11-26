CeladonUniversityPrincipalsOffice_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CELADON_UNIVERSITY_1F, 5
	warp_event  3,  7, CELADON_UNIVERSITY_1F, 5

	def_coord_events

	def_bg_events
	bg_event  2,  0, BGEVENT_JUMPTEXT, CeladonUniversityPrincipalsOfficeSignpost1Text
	bg_event  3,  0, BGEVENT_JUMPTEXT, CeladonUniversityPrincipalsOfficeSignpost2Text
	bg_event  5,  4, BGEVENT_RIGHT, CeladonUniversityPrincipalsOfficeComputer
	bg_event  1,  1, BGEVENT_JUMPTEXT, CeladonUniversityPrincipalsOfficeBookshelfText

	def_object_events
	object_event  2,  2, SPRITE_MATSUMOTO, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonUniversityPrincipalsOfficeMatsumotoScript, -1

CeladonUniversityPrincipalsOfficeMatsumotoScript:
	checkevent EVENT_GOT_RARE_CANDY_IN_UNIVERSITY
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem RARE_CANDY, iffalse_endtext
	setevent EVENT_GOT_RARE_CANDY_IN_UNIVERSITY
	jumpthisopenedtext

.Text2:
	text "Ich arbeite hart,"
	line "damit hier alles"
	cont "reibungslos läuft,"

	para "also entspanne ich"
	line "mich ab und zu mit"
	cont "Bonbons."
	done

.Text1:
	text "Hallo,"
	line "junger Trainer!"

	para "Ich bin Professor"
	line "Matsumoto."

	para "Ich bin der Rektor"
	line "der Prismania-Uni."

	para "Aber du kannst"
	line "mich deinen Kumpel"
	cont "nennen!"

	para "Hier, nimm ein"
	line "paar Bonbons aus"
	cont "meinem Vorrat im"
	cont "Schreibtisch."
	done

CeladonUniversityPrincipalsOfficeSignpost1Text:
	text "Prof. Matsumotos"
	line "Abschluss in"
	cont "Pädagogik."
	done

CeladonUniversityPrincipalsOfficeSignpost2Text:
	text "Ein Bild von Prof."
	line "Matsumoto vor"

	para "einem Abschluss-"
	line "jahrgang."
	done

CeladonUniversityPrincipalsOfficeComputer:
	jumpthistext

	text "Der Entwurf einer"
	line "E-Mail, die Ehema-"
	cont "lige um Spenden"
	cont "bittet."
	done

CeladonUniversityPrincipalsOfficeBookshelfText:
	text "Eine komplette"
	line "Ausgabe der"

	para "Encyclopaedia"
	line "#monica."
	done
