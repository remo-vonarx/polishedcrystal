CeladonPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, CELADON_CITY, 5
	warp_event  6,  7, CELADON_CITY, 5
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalErikaScript

	def_object_events
	pc_nurse_event  5, 1
	object_event  2,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumpstd, happinesschecknpc, -1
	object_event  1,  3, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonPokeCenter1FPharmacistText, -1
	object_event 11,  5, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonPokeCenter1FCooltrainerfText, -1
	object_event 11,  6, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonPokeCenter1FLassText, -1

PokemonJournalErikaScript:
	setflag ENGINE_READ_ERIKA_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Arenaleiterin"
	cont "Erika!"

	para "Gerüchten zufolge"
	line "kann man Erika"
	cont "oft schlummern"

	para "sehen, wenn man"
	line "in die Arena von"
	cont "Prismania City"
	cont "späht."
	done

CeladonPokeCenter1FPharmacistText:
	text "Das Versteck von"
	line "Team Rocket befin-"
	cont "det sich im Keller"
	cont "der Spielhalle."

	para "Oh, warte. Das war"
	line "vor drei Jahren."

	para "Wofür es jetzt"
	line "wohl genutzt wird?"
	done

CeladonPokeCenter1FCooltrainerfText:
	text "Erika versteht es"
	line "meisterlich, mit"

	para "Pflanzen-#mon"
	line "umzugehen."

	para "Eine Unachtsamkeit"
	line "wird dir bei ihr"
	cont "übel bekommen."
	done

CeladonPokeCenter1FLassText:
	text "Erika ist nicht"
	line "nur Arenaleiterin."

	para "Sie hält auch Vor-"
	line "lesungen an der"
	cont "Uni."
	done
