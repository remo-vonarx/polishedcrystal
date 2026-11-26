CeladonUniversityClassroom3_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2, 11, CELADON_UNIVERSITY_1F, 8
	warp_event  3, 11, CELADON_UNIVERSITY_1F, 8

	def_coord_events

	def_bg_events
	bg_event  2,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom3BlackboardText
	bg_event  3,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom3BlackboardText
	bg_event  4,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom3BlackboardText
	bg_event  6,  1, BGEVENT_JUMPTEXT, CeladonUniversityClassroom3Bookshelf1Text
	bg_event  7,  1, BGEVENT_JUMPTEXT, CeladonUniversityClassroom3Bookshelf2Text

	def_object_events
	object_event  2,  1, SPRITE_SPARK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, (1 << MORN) | (1 << DAY), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom3SparkText, -1
	object_event  2,  1, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, (1 << EVE) | (1 << NITE), PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom3TeacherText, -1
	object_event  4,  5, SPRITE_CHILD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom3ChildText, -1
	object_event  3,  7, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom3LassText, -1
	object_event  4,  7, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom3Super_nerdText, -1

CeladonUniversityClassroom3SparkText:
	text "Hey! Ich bin"
	line "Spark und unter-"
	cont "richte Natur-"
	cont "wissenschaften--"

	para "gerade ist"
	line "#biologie dran."

	para "Wir erforschen,"
	line "wie sich #mon"
	cont "fortpflanzen."

	para "Prof. Lind ist"
	line "ein Pionier auf"
	cont "diesem Gebiet."

	para "Oh, du kennst ihn!"
	line "Stimmt es, dass er"
	cont "wirklich in seinem"
	cont "Labor wohnt?"
	done

CeladonUniversityClassroom3TeacherText:
	text "Suchst du Spark?"

	para "Er ist morgen"
	line "früh wieder da."
	done

CeladonUniversityClassroom3ChildText:
	text "#mon werden in"
	line "#bällen in"

	para "Lichtenergie umge-"
	line "wandelt und beim"

	para "Hinausschicken"
	line "wieder zu Materie."

	para "Keine Sorge, es"
	line "tut ihnen kein"
	cont "bisschen weh!"
	done

CeladonUniversityClassroom3LassText:
	text "Mein Dozent sagte,"
	line "Magneton sei eine"

	para "Vereinigung von"
	line "drei Magnetilo,"

	para "aber Magneton ist"
	line "zehnmal schwerer"
	cont "als Magnetilo."

	para "Wie soll das denn"
	line "gehen?!"
	done

CeladonUniversityClassroom3Super_nerdText:
	text "Kennst du das"
	line "Elektro-#mon"
	cont "Voltilamm?"

	para "Sein Name kommt"
	line "von der Einheit"

	para "der elektrischen"
	line "Spannung, dem"
	cont "“Volt”."

	para "Schau dir die"
	line "ersten Buchstaben"
	cont "an, dann siehst"
	cont "du's!"
	done

CeladonUniversityClassroom3BlackboardText:
	text "An der Tafel steht"
	line "“Phylogenetik”."

	para "“…#mon lassen"
	line "sich in 14"
	cont "“Ei-Gruppen”"
	cont "einteilen, dazu"
	cont "Ditto."

	para "Baby-#mon"
	line "können sich nicht"
	cont "fortpflanzen."

	para "Legendäre #mon"
	line "wurden noch nicht"
	cont "erforscht.”"
	done

CeladonUniversityClassroom3Bookshelf1Text:
	text "Ein Buch mit"
	line "Prototyp-Entwürfen"

	para "für technische"
	line "Geräte."

	para "Hey! Eine frühe"
	line "#Com-Skizze ist"
	cont "hier drin!"
	done

CeladonUniversityClassroom3Bookshelf2Text:
	text "Eine Abhandlung"
	line "von Prof."
	cont "Seidenbaum."

	para "“Untersuchungs-"
	line "bericht zu den"
	cont "Alph-Ruinen”…"
	done
