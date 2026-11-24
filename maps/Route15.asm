Route15_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  4, ROUTE_15_FUCHSIA_GATE, 3
	warp_event  4,  5, ROUTE_15_FUCHSIA_GATE, 4

	def_coord_events

	def_bg_events
	bg_event 19,  9, BGEVENT_JUMPTEXT, Route15SignText

	def_object_events
	object_event 10, 10, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSchoolboyKipp, -1
	object_event 15, 13, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSchoolboyTommy, -1
	object_event 27, 10, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSchoolboyBilly, -1
	object_event 33, 10, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSchoolgirlFaith, -1
	object_event 30, 12, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerTeacherColette, -1
	object_event 20, 10, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, PAL_NPC_DARK_GREEN, OBJECTTYPE_TRAINER, 3, TrainerTeacherHillary, -1
	object_event 30,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerPokefanfBoone, -1
	object_event 14,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerPokefanfEleanor, -1
	object_event 19,  5, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerTwinsKayandtia1, -1
	object_event 20,  5, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerTwinsKayandtia2, -1
	itemball_event 12,  5, PP_UP, 1, EVENT_ROUTE_15_PP_UP
	cuttree_event 43,  5, EVENT_ROUTE_14_CUT_TREE_3

GenericTrainerTeacherColette:
	generictrainer TEACHER_F, COLETTE, EVENT_BEAT_TEACHER_COLETTE, TeacherColetteSeenText, TeacherColetteBeatenText

	text "Ehe ich Lehrer"
	line "wurde, vergaß ich"

	para "immer eine Menge"
	line "Dinge."
	done

TrainerTeacherHillary:
	trainer TEACHER_F, HILLARY, EVENT_BEAT_TEACHER_HILLARY, TeacherHillarySeenText, TeacherHillaryBeatenText, 0, .Script, TRAINERPAL_DARK_TEACHER_F

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Lernen ist sehr"
	line "wichtig, aber"
	cont "Bewegung ist"
	cont "genauso essen-"
	cont "tiell."
	done

GenericTrainerSchoolboyKipp:
	generictrainer SCHOOLBOY, KIPP, EVENT_BEAT_SCHOOLBOY_KIP, SchoolboyKippSeenText, SchoolboyKippBeatenText

	text "Meine Mutter macht"
	line "sich immer große"

	para "Sorgen um mich."
	line "Ständig muss ich"
	cont "sie anrufen."
	done

GenericTrainerSchoolboyTommy:
	generictrainer SCHOOLBOY, TOMMY, EVENT_BEAT_SCHOOLBOY_TOMMY, SchoolboyTommySeenText, SchoolboyTommyBeatenText

	text "Sayonara! Das habe"
	line "ich in meinem"
	cont "Japanischkurs"
	cont "gelernt."
	done

GenericTrainerSchoolboyBilly:
	generictrainer SCHOOLBOY, BILLY, EVENT_BEAT_SCHOOLBOY_BILLY, SchoolboyBillySeenText, SchoolboyBillyBeatenText

	text "Wenn #mon ein"
	line "Unterrichtsfach"
	cont "wäre, dann wäre"
	cont "ich bestimmt der"
	cont "Beste!"
	done

GenericTrainerSchoolgirlFaith:
	generictrainer SCHOOLGIRL, FAITH, EVENT_BEAT_SCHOOLGIRL_FAITH, SchoolgirlFaithSeenText, SchoolgirlFaithBeatenText

	text "Ich bin müde vom"
	line "Laufen. Ich muss"
	cont "eine Pause machen."
	done

GenericTrainerPokefanfBoone:
	generictrainer POKEFANF, BOONE, EVENT_BEAT_POKEFANF_BOONE, PokefanfBooneSeenText, PokefanfBooneBeatenText

	text "When you battle,"
	line "you get to see"
	cont "#mon you've"
	cont "never seen before."

	para "It's so great!"
	done

GenericTrainerPokefanfEleanor:
	generictrainer POKEFANF, ELEANOR, EVENT_BEAT_POKEFANF_ELEANOR, PokefanfEleanorSeenText, PokefanfEleanorBeatenText

	text "My #mon aren't"
	line "weak! Your #mon"
	cont "are too strong!"
	done

GenericTrainerTwinsKayandtia1:
	generictrainer TWINS, KAYANDTIA1, EVENT_BEAT_TWINS_KAY_AND_TIA, TwinsKayandtia1SeenText, TwinsKayandtia1BeatenText

	text "Absolute truth--"
	line "I'm Kay! Maybe…"
	done

GenericTrainerTwinsKayandtia2:
	generictrainer TWINS, KAYANDTIA2, EVENT_BEAT_TWINS_KAY_AND_TIA, TwinsKayandtia2SeenText, TwinsKayandtia2BeatenText

	text "Maybe truth--I'm"
	line "Tia! Absolutely!"
	done

TeacherColetteSeenText:
	text "Hast du etwas"
	line "vergessen?"
	done

TeacherColetteBeatenText:
	text "Uah!"
	done

TeacherHillarySeenText:
	text "Bei schönem Wetter"
	line "würden die Kinder"

	para "lieber im Schulhof"
	line "spielen, als in"

	para "den Klassenzimmern"
	line "zu lernen."
	done

TeacherHillaryBeatenText:
	text "Ich wollte nicht"
	line "verlieren…"
	done

SchoolboyKippSeenText:
	text "Warte! Ich muss"
	line "meine Mutter"
	cont "anrufen."
	done

SchoolboyKippBeatenText:
	text "Tut mir Leid,"
	line "Mutter!"
	cont "Ich wurde besiegt!"
	done

SchoolboyTommySeenText:
	text "Lass uns kämpfen."
	line "Ich werde nicht"
	cont "verlieren!"
	done

SchoolboyTommyBeatenText:
	text "Ich hätte meine"
	line "Hausaufgaben"
	cont "machen sollen!"
	done

SchoolgirlFaithSeenText:
	text "Wir machen einen"
	line "Ausflug zum Radio-"
	cont "turm in Lavandia,"

	para "um dort etwas in"
	line "Sozialkunde zu"
	cont "lernen."
	done

SchoolgirlFaithBeatenText:
	text "Du bist unheimlich"
	line "stark!"
	done

SchoolboyBillySeenText:
	text "Sport ist mein"
	line "Lieblingsfach!"
	done

SchoolboyBillyBeatenText:
	text "Oh, nein!"
	line "Wie konnte ich nur"
	para "verlieren?"
	done

PokefanfBooneSeenText:
	text "Hey, your"
	line "#mon…"

	para "Show me. Show me."
	line "Show me!"
	done

PokefanfBooneBeatenText:
	text "Yay! That was"
	line "great!"
	done

PokefanfEleanorSeenText:
	text "All right,"
	line "#mon, time for"
	cont "a battle!"
	done

PokefanfEleanorBeatenText:
	text "Oh, well…"
	done

TwinsKayandtia1SeenText:
	text "We're the twins"
	line "Kay and Tia!"

	para "Do you know which"
	line "one I am?"
	done

TwinsKayandtia1BeatenText:
	text "Tia and Kay both"
	line "lost…"
	done

TwinsKayandtia2SeenText:
	text "We're the twins"
	line "Kay and Tia!"

	para "Do you know which"
	line "one I am?"
	done

TwinsKayandtia2BeatenText:
	text "Tia and Kay both"
	line "lost…"
	done

Route15SignText:
	text "Route 15"

	para "Fuchsania City -"
	line "Lavandia"
	done
