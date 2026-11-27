CeladonUniversity1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 14, 19, CELADON_CITY, 13
	warp_event 15, 19, CELADON_CITY, 19
	warp_event 25, 12, CELADON_UNIVERSITY_2F, 1
	warp_event 21, 12, CELADON_UNIVERSITY_LIBRARY_1F, 1
	warp_event 15,  0, CELADON_UNIVERSITY_PRINCIPALS_OFFICE, 1
	warp_event  3,  4, CELADON_UNIVERSITY_CLASSROOM_1, 1
	warp_event  9,  4, CELADON_UNIVERSITY_CLASSROOM_2, 1
	warp_event 21,  4, CELADON_UNIVERSITY_CLASSROOM_3, 1
	warp_event 27,  4, CELADON_UNIVERSITY_CLASSROOM_4, 1
	warp_event  3, 12, CELADON_UNIVERSITY_LOUNGE, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_JUMPTEXT, CeladonUniversity1FPrincipalsOfficeSignText
	bg_event  2,  4, BGEVENT_JUMPTEXT, CeladonUniversity1FClassroom1SignText
	bg_event  8,  4, BGEVENT_JUMPTEXT, CeladonUniversity1FClassroom2SignText
	bg_event 20,  4, BGEVENT_JUMPTEXT, CeladonUniversity1FClassroom3SignText
	bg_event 26,  4, BGEVENT_JUMPTEXT, CeladonUniversity1FClassroom4SignText
	bg_event  2, 12, BGEVENT_JUMPTEXT, CeladonUniversity1FStudentLoungeSignText
	bg_event 20, 12, BGEVENT_JUMPTEXT, CeladonUniversity1FLibrarySignText
	bg_event 22,  5, BGEVENT_JUMPTEXT, CeladonUniversity1FTrophyCaseSignText
	bg_event 23,  5, BGEVENT_JUMPTEXT, CeladonUniversity1FTrophyCaseSignText
	bg_event  6, 13, BGEVENT_JUMPTEXT, CeladonUniversity1FTrophyCaseSignText
	bg_event  7, 13, BGEVENT_JUMPTEXT, CeladonUniversity1FTrophyCaseSignText
	bg_event 26, 13, BGEVENT_JUMPTEXT, CeladonUniversity1FBookshelfText
	bg_event 27, 13, BGEVENT_JUMPTEXT, CeladonUniversity1FBookshelfText

	def_object_events
	object_event  6,  5, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FSuperNerdText, -1
	object_event 16,  4, SPRITE_PICNICKER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FLassText, -1
	object_event 25,  5, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FCooltrainermText, -1
	object_event 13,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FYoungsterText, -1
	object_event  4, 15, SPRITE_CHILD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, (1 << MORN) | (1 << DAY), PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FChildText, -1
	object_event  6, 15, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 3, (1 << EVE) | (1 << NITE), PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FPokefanmText, -1
	object_event 14, 14, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FReceptionistText, -1
	object_event 23, 13, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversity1FCooltrainerfText, -1

CeladonUniversity1FSuperNerdText:
	text "Manche Akademiker"
	line "glauben, es gibt"

	para "Paralleluniversen"
	line "zu diesem hier."

	para "Heißt das, es gibt"
	line "ein Universum ganz"

	para "ohne #mon?"

	para "Das wäre ja"
	line "tragisch!"
	done

CeladonUniversity1FLassText:
	text "Hier kann man"
	line "alles studieren,"

	para "vom Blumenstecken"
	line "bis zur #mon-"
	cont "Psychologie!"
	done

CeladonUniversity1FCooltrainermText:
	text "Jeder an dieser"
	line "Uni ist ein"
	cont "#mon-Trainer."

	para "Um hier einen"
	line "Studienplatz zu"

	para "bekommen, muss man"
	line "eine Reihe von"
	cont "#mon-Kampftests"
	cont "bestehen."
	done

CeladonUniversity1FYoungsterText:
	text "Karpador ist das"
	line "Maskottchen der"
	cont "Uni."

	para "Es ist ein Symbol"
	line "dafür, dass jeder"
	cont "nach Größe streben"
	cont "kann!"
	done

CeladonUniversity1FChildText:
	text "Uff! Ich finde"
	line "meinen nächsten"
	cont "Kurs nicht…"

	para "Ich komme zu spät!"
	done

CeladonUniversity1FPokefanmText:
	text "Ich bin der"
	line "Hausmeister!"

	para "Vorsicht, der"
	line "Boden ist nass!"
	done

CeladonUniversity1FReceptionistText:
	text "Willkommen an der"
	line "Prismania-Uni!"

	para "Die Kursräume und"
	line "das Büro des"
	cont "Rektors liegen"
	cont "den Flur entlang."

	para "Die Bibliothek ist"
	line "rechts von dir,"

	para "die Studenten-"
	line "lounge links."

	para "Die Mensa, das"
	line "Schwimmbad und das"

	para "Krankenzimmer sind"
	line "oben."
	done

CeladonUniversity1FCooltrainerfText:
	text "Ich studiere, um"
	line "#mon-Pflegerin"
	cont "zu werden."

	para "Bei so vielen"
	line "Arten da draußen"

	para "ist die Lernkurve"
	line "ganz schön steil!"
	done

CeladonUniversity1FPrincipalsOfficeSignText:
	text "Rektorat"
	done

CeladonUniversity1FClassroom1SignText:
	text "W2 Kunst"
	done

CeladonUniversity1FClassroom2SignText:
	text "W1 Geschichte"
	done

CeladonUniversity1FClassroom3SignText:
	text "O1 Natur-"
	line "wissenschaften"
	done

CeladonUniversity1FClassroom4SignText:
	text "O2 Kampflehre"
	done

CeladonUniversity1FStudentLoungeSignText:
	text "Studentenlounge"
	done

CeladonUniversity1FLibrarySignText:
	text "Bibliothek"
	done

CeladonUniversity1FTrophyCaseSignText:
	text "Die Vitrine ist"
	line "voller Trophäen"
	cont "und Medaillen."
	done

CeladonUniversity1FBookshelfText:
	text "Hier stehen jede"
	line "Menge Jahrbücher."

	para "Studenten haben"
	line "sie überall voll-"
	cont "gekritzelt."
	done
