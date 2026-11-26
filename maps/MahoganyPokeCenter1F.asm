MahoganyPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, MAHOGANY_TOWN, 4
	warp_event  6,  7, MAHOGANY_TOWN, 4
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalPryceScript

	def_object_events
	pc_nurse_event  5, 1
	object_event  9,  4, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MahoganyPokeCenter1FPokefanmText, -1
	object_event  1,  3, SPRITE_CAMPER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MahoganyPokeCenter1FYoungsterText, -1
	object_event  2,  3, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MahoganyPokeCenter1FCooltrainerfText, -1

PokemonJournalPryceScript:
	setflag ENGINE_READ_PRYCE_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Arenaleiter"
	cont "Norbert!"

	para "Norberts zweiter"
	line "Vorname ist Weide."

	para "Sein Kampfstil"
	line "soll so biegsam"

	para "sein wie eine"
	line "Weide im Winter."

	para "Das brachte ihm"
	line "den Spitznamen"
	cont "“der Winter-"
	cont "trainer” ein."
	done

MahoganyPokeCenter1FPokefanmText:
	text "Wie? Team Rocket"
	line "ist wieder da?"

	para "Ich sah einige"
	line "Männer in Schwarz"
	cont "am See des Zorns…"
	done

MahoganyPokeCenter1FYoungsterText:
	text "Ich verhindere,"
	line "dass sich meine"
	cont "#mon zu"
	cont "rasch entwickeln."

	para "Ich bringe ihnen"
	line "verschiedene"
	cont "Attacken bei, be-"
	cont "vor ich sie sich"
	cont "entwickeln lasse."
	done

MahoganyPokeCenter1FCooltrainerfText:
	text "#mon werden"
	line "stärker, wenn sie"

	para "sich entwickeln."
	line "Aber sie erlernen"

	para "neue Attacken auch"
	line "langsamer."
	done
