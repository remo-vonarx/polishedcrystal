SnowtopPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, SnowtopPokeCenter1FStairsCallback

	def_warp_events
	warp_event  5,  7, SNOWTOP_MOUNTAIN_OUTSIDE, 2
	warp_event  6,  7, SNOWTOP_MOUNTAIN_OUTSIDE, 2

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalProfWillowScript

	def_object_events
	pc_nurse_event  5, 1

SnowtopPokeCenter1FStairsCallback:
	; no second floor
	changeblock 0, 6, $49
	; wooden table
	changeblock 8, 4, $24
	changeblock 8, 6, $34
	endcallback

PokemonJournalProfWillowScript:
	setflag ENGINE_READ_PROF_WILLOW_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Prof. Willow!"

	para "Man sagt, Prof."
	line "Willows Traum sei"

	para "es, unerforschte"
	line "Länder zu erkunden"

	para "und unentdeckte"
	line "#mon-Arten in"

	para "ihrem natürlichen"
	line "Lebensraum zu"
	cont "dokumentieren."
	done
