CliffEdgeGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 17, 19, CIANWOOD_CITY, 8
	warp_event  3, 19, ROUTE_47, 1

	def_coord_events

	def_bg_events
	bg_event 17,  6, BGEVENT_ITEM + OVAL_STONE, EVENT_CLIFF_EDGE_GATE_HIDDEN_OVAL_STONE

	def_object_events
	object_event 11, 16, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CliffEdgeGateReceptionistText, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	object_event  3,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ProfOaksAide3Script, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	object_event 17, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM12, EVENT_CLEARED_YELLOW_FOREST

ProfOaksAide3Script:
	faceplayer
	opentext
	checkevent EVENT_GOT_MACHO_BRACE_FROM_PROF_OAKS_AIDE
	iftruefwd .Explain
	writetext ProfOaksAide3HiText
	waitbutton
	setval16 45
	special CountCaught
	iftruefwd .HereYouGo
.UhOh
	jumpopenedtext ProfOaksAide3UhOhText

.HereYouGo
	writetext ProfOaksAide3HereYouGoText
	waitbutton
	verbosegiveitem MACHO_BRACE, iffalsefwd .NoRoom
	setevent EVENT_GOT_MACHO_BRACE_FROM_PROF_OAKS_AIDE
.Explain
	jumpthisopenedtext

	text "Die Machoschiene"
	line "lässt ein #mon"

	para "durch Kämpfe"
	line "stärker wachsen,"
	cont "macht es aber"
	cont "langsamer."
	done

.NoRoom
	jumpthisopenedtext

	text "Oh! Wie ich sehe,"
	line "hast du keinen"
	cont "Platz dafür."
	done

GenericTrainerGruntM12:
	generictrainer GRUNTM, 12, EVENT_BEAT_ROCKET_GRUNTM_12, GruntM12SeenText, GruntM12BeatenText

	text "Im Goldgelben Wald"
	line "gibt es viele"
	cont "seltene #mon."

	para "Wir schnappen sie"
	line "uns alle selbst!"
	done

CliffEdgeGateReceptionistText:
	text "Hier geht es zum"
	line "Goldgelben Wald!"

	para "Er ist ein belieb-"
	line "tes Ausflugsziel!"
	done

ProfOaksAide3HiText:
	text "Hallo! Ich bin"
	line "Prof. Eichs"
	cont "Assistent."

	para "Wenn du 45 Arten"
	line "von #mon"
	cont "gefangen hast,"
	cont "soll ich dir ein"
	cont "Item geben."

	para "Also, <PLAYER>,"
	line "hast du schon"

	para "mindestens 45"
	line "Arten von #mon"
	cont "gefangen?"
	done

ProfOaksAide3UhOhText:
	text "Mal sehen… Oje!"
	line "Du hast bisher"

	para "erst "
	text_decimal wTempDexOwn, 2, 3
	text " Arten"
	line "von #mon"
	cont "gefangen."

	para "Komm wieder, wenn"
	line "du 45 Arten"
	cont "gefangen hast."
	done

ProfOaksAide3HereYouGoText:
	text "Mal sehen… Toll"
	line "gemacht! Du hast"

	para "schon "
	text_decimal wTempDexOwn, 2, 3
	text " Arten"
	line "von #mon"
	cont "gefangen."

	para "Glückwunsch!"
	line "Hier, bitte!"
	done



GruntM12SeenText:
	text "Du willst etwas"
	line "über unsere Pläne"
	cont "wissen?"

	para "Besiege mich, dann"
	line "verrate ich sie"
	cont "dir!"
	done

GruntM12BeatenText:
	text "Du hättest doch"
	line "verlieren sollen!"
	done
