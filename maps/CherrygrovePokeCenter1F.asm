CherrygrovePokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, CHERRYGROVE_CITY, 2
	warp_event  6,  7, CHERRYGROVE_CITY, 2
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalRedScript

	def_object_events
	pc_nurse_event  5, 1
	object_event  1,  6, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygrovePokeCenter1FTeacherScript, -1
	object_event  8,  1, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygrovePokeCenter1FFisherText, -1
	object_event 11,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygrovePokeCenter1FGentlemanText, -1
	object_event  9,  4, SPRITE_LADY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygrovePokeCenter1FLadyText, -1

PokemonJournalRedScript:
	setflag ENGINE_READ_RED_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "<PK><MN>-Trainer Rot!"

	para "Rot soll seinen"
	line "Rivalen Blau im"

	para "Kampf um den Titel"
	line "des Champs der"
	cont "#mon Liga in"
	cont "Rekordzeit"
	cont "besiegt haben."
	done

CherrygrovePokeCenter1FTeacherScript:
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue_jumptextfaceplayer .Text2
	jumpthistextfaceplayer

	text "Das Kommuni-"
	line "kations-Center im"
	cont "ersten Stock ist"
	cont "gerade fertig."

	para "Aber der Fein-"
	line "schliff fehlt"
	cont "noch."
	done

.Text2:
	text "Das Kommuni-"
	line "kations-Center im"
	cont "ersten Stock ist"
	cont "gerade fertig."

	para "Ich habe schon"
	line "#mon getauscht!"
	done

CherrygrovePokeCenter1FFisherText:
	text "Das ist toll! Ich"
	line "kann so viele"

	para "#mon lagern,"
	line "wie ich will, und"
	cont "das umsonst!"
	done

CherrygrovePokeCenter1FGentlemanText:
	text "Dieser PC steht"
	line "jedem Trainer kos-"
	cont "tenfrei zur Verfü-"
	cont "gung."
	done

CherrygrovePokeCenter1FLadyText:
	text "Im #mon Journal"
	line "stehen so faszi-"
	cont "nierende"
	cont "Geschichten!"

	para "Ich gehe für die"
	line "neuesten Ausgaben"
	cont "in #mon-Center,"

	para "aber die sind"
	line "nicht die einzi-"
	cont "gen mit einem"
	cont "Abo."
	done
