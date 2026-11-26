MrFujisHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, LAVENDER_TOWN, 2
	warp_event  3,  7, LAVENDER_TOWN, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  1, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, MrFujisHouseSuperNerdText, -1
	object_event  3,  4, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, MrFujisHouseLassText, -1
	pokemon_event  8,  4, PSYDUCK, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_BROWN, MrFujisPsyduckText, -1
	pokemon_event  5,  5, NIDORINO, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_PURPLE, MrFujisNidorinoText, -1
	pokemon_event  1,  3, PIDGEY, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_BROWN, MrFujisPidgeyText, -1

MrFujisHouseSuperNerdText:
	text "Hier wohnt Mr."
	line "Fuji, aber er ist"

	para "jetzt nicht"
	line "zu Hause."

	para "Vielleicht ist er"
	line "in der Ruhestätte."
	done

MrFujisHouseLassText:
	text "Es gibt kalt-"
	line "herzige Menschen,"
	cont "die einfach ihre"
	cont "#mon im Stich"
	cont "lassen."

	para "Großvater nimmt"
	line "die armen, heimat-"
	cont "losen #mon auf"
	cont "und sorgt für sie."
	done

MrFujisPsyduckText:
	text "Enton: Qua-qua?"
	done

MrFujisNidorinoText:
	text "Nidorino: Nido!"
	done

MrFujisPidgeyText:
	text "Taubsi: Gru gru!"
	done
