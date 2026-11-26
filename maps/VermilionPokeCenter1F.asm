VermilionPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, VERMILION_CITY, 2
	warp_event  6,  7, VERMILION_CITY, 2
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalLtSurgeScript

	def_object_events
	pc_nurse_event  5, 1
	object_event  8,  2, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPokeCenter1FSightseerMScript, -1
	object_event  2,  5, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionPokeCenter1FSailorText, -1
	object_event  9,  4, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionPokeCenter1FBugCatcherText, -1

PokemonJournalLtSurgeScript:
	setflag ENGINE_READ_LT_SURGE_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Arenaleiter"
	cont "Major Bob!"

	para "Gerüchten zufolge"
	line "war Major Bob in"

	para "seiner Heimat"
	line "Amerika Pilot."

	para "Er trieb sein"
	line "Flugzeug mit Strom"

	para "an, den seine"
	line "#mon erzeugten."
	done

VermilionPokeCenter1FSightseerMScript:
	checkevent EVENT_VERMILION_CITY_SNORLAX
	iftrue_jumptextfaceplayer .SnorlaxText
	jumpthistextfaceplayer

	text "Vor Digdas"
	line "Höhle liegt ein"
	cont "schlafendes #-"
	cont "mon."

	para "Das wäre eine"
	line "fantastische Gele-"
	cont "genheit, es zu"

	para "fangen! Aber wie"
	line "weckt man es auf?"
	done

.SnorlaxText:
	text "Vor Digdas"
	line "Höhle lag ein"

	para "schlafendes #-"
	line "mon."

	para "Aber jetzt scheint"
	line "es verschwunden"
	cont "zu sein."
	done

VermilionPokeCenter1FSailorText:
	text "Auf dem Schnell-"
	line "boot findet man"

	para "viele Trainer,"
	line "gegen die man"
	cont "kämpfen kann."
	done

VermilionPokeCenter1FBugCatcherText:
	text "Ach? Du hast da"
	line "einige Orden, die"
	cont "ich noch nie"
	cont "gesehen habe."

	para "Ah, jetzt begreife"
	line "ich es. Du hast"

	para "sie in Johto"
	line "erhalten."
	done
