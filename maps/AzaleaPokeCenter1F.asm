AzaleaPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, AZALEA_TOWN, 1
	warp_event  6,  7, AZALEA_TOWN, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalBugsyScript

	def_object_events
	pc_nurse_event  5, 1
	object_event  8,  4, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaPokeCenter1FCooltrainermScript, -1
	object_event 11,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaPokeCenter1FGentlemanText, -1
	object_event  8,  1, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaPokeCenter1FSightseermText, -1
	object_event  2,  5, SPRITE_MATRON, SPRITEMOVEDATA_WANDER, 2, 1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaPokeCenter1FPokefanfText, -1

PokemonJournalBugsyScript:
	setflag ENGINE_READ_BUGSY_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Arenaleiter Kai!"

	para "Kai soll das"
	line "Käferturnier so"

	para "oft gewonnen"
	line "haben, dass er"

	para "nicht mehr daran"
	line "teilnimmt."
	done

AzaleaPokeCenter1FCooltrainermScript:
	checktime (1 << EVE) | (1 << NITE)
	iftrue_jumptextfaceplayer .NiteText
	jumpthistextfaceplayer

	text "Kurt stellt zwar"
	line "#bälle her,"

	para "aber als Trainer"
	line "taugt er nicht"
	cont "viel."

	para "Er hat zwar ein"
	line "#mon, aber er"

	para "setzt es kaum"
	line "ein."
	done

.NiteText:
	text "Kurt und Prof."
	line "Eich sind alte"
	cont "Freunde."

	para "Sie stehen auch"
	line "Agathe nahe, einem"

	para "früheren Mitglied"
	line "der Top Vier."
	done

AzaleaPokeCenter1FGentlemanText:
	text "Beherrschen deine"
	line "#mon VM-"
	cont "Attacken?"

	para "Diese Attacken"
	line "können auch einge-"
	cont "setzt werden, wenn"

	para "dein #mon be-"
	line "siegt worden ist."
	done

AzaleaPokeCenter1FSightseermText:
	text "Dieser Bill hat"
	line "das #mon-"
	cont "Lagerungs-System"
	cont "für PC entwickelt."

	para "Auf Bills PC kön-"
	line "nen bis zu 20"
	cont "#mon pro Box"
	cont "gelagert werden."
	done

AzaleaPokeCenter1FPokefanfText:
	text "Weißt du über"
	line "Aprikokos Be-"
	cont "scheid?"

	para "Brich eine auf,"
	line "höhle sie aus und"

	para "verbinde sie mit"
	line "einer speziellen"
	cont "Vorrichtung."

	para "Dann kannst du"
	line "#mon damit"
	cont "fangen."

	para "Vor der Erfindung"
	line "von #bällen hat"

	para "jeder Aprikokos"
	line "verwendet."
	done
