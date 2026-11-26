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
	text "Hey! I'm Spark."
	line "I teach Science--"

	para "right now, it's"
	line "#biology."

	para "We're studying how"
	line "#mon reproduce."

	para "Prof.Elm has pion-"
	line "eered the field."

	para "Oh, you know him!"
	line "Is it true that he"
	cont "actually lives in"
	cont "his lab?"
	done

CeladonUniversityClassroom3TeacherText:
	text "Are you looking"
	line "for Spark?"

	para "He will be back"
	line "tomorrow morning."
	done

CeladonUniversityClassroom3ChildText:
	text "#mon inside"
	line "# Balls are"

	para "converted to light"
	line "energy, then"

	para "changed back to"
	line "matter when they're"
	cont "sent out."

	para "Don't worry, it"
	line "doesn't hurt them"
	cont "one bit!"
	done

CeladonUniversityClassroom3LassText:
	text "My instructor said"
	line "that Magneton is a"

	para "union of three"
	line "Magnemite, but"

	para "Magneton is 10"
	line "times heavier than"
	cont "Magnemite."

	para "How does that"
	line "work?!"
	done

CeladonUniversityClassroom3Super_nerdText:
	text "Have you heard of"
	line "the Electric-type"
	cont "#mon Mareep?"

	para "Its name derives"
	line "from the unit of"

	para "electric current,"
	line "the “ampere.”"

	para "Rearrange the"
	line "letters, and"
	cont "you'll see!"
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
	cont "Silktree."

	para "“Untersuchungs-"
	line "bericht zu den"
	cont "Alph-Ruinen”…"
	done
