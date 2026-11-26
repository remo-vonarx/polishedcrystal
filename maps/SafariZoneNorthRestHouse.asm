SafariZoneNorthRestHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, SAFARI_ZONE_NORTH, 7
	warp_event  3,  7, SAFARI_ZONE_NORTH, 7

	def_coord_events

	def_bg_events
	bg_event  4,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  5,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  6,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  7,  1, BGEVENT_READ, PokemonJournalKogaScript

	def_object_events
	object_event  2,  1, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleErikandsara1, -1
	object_event  3,  1, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleErikandsara2, -1

GenericTrainerCoupleErikandsara1:
	generictrainer COUPLE, ERIKANDSARA1, EVENT_BEAT_COUPLE_ERIK_AND_SARA, .SeenText, .BeatenText

	text "Erik: Früher habe"
	line "ich mich in der"
	cont "Safari-Zone"
	cont "verirrt."

	para "Jetzt ist sie"
	line "unser liebster"
	cont "ruhiger Ort."
	done

.SeenText:
	text "Erik: Du hast"
	line "unser geheimes"
	cont "Plätzchen gefun-"
	cont "den?!"
	done

.BeatenText:
	text "Erik: Jetzt ist"
	line "es nicht mehr so"
	cont "geheim…"
	done

GenericTrainerCoupleErikandsara2:
	generictrainer COUPLE, ERIKANDSARA2, EVENT_BEAT_COUPLE_ERIK_AND_SARA, .SeenText, .BeatenText

	text "Sara: Wir hatten"
	line "unser erstes Date"
	cont "in der Safari-"
	cont "Zone."

	para "Das ist jetzt"
	line "drei Jahre her!"
	done

.SeenText:
	text "Sara: Du hast"
	line "unser geheimes"
	cont "Plätzchen gefun-"
	cont "den?!"
	done

.BeatenText:
	text "Sara: Jetzt ist"
	line "es nicht mehr so"
	cont "geheim…"
	done
