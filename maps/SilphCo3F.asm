SilphCo3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 11,  0, SILPH_CO_2F, 2

	def_coord_events

	def_bg_events
	bg_event  8,  0, BGEVENT_JUMPTEXT, SilphCoElevatorText
	bg_event  4,  3, BGEVENT_JUMPTEXT, SilphCo3FDeptSignText
	bg_event 10,  3, BGEVENT_JUMPTEXT, SilphCo3FDeptSignText
	bg_event  0,  5, BGEVENT_JUMPTEXT, SilphCo3FPhotoText
	bg_event  1,  5, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  5,  0, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events
	object_event 10,  7, SPRITE_SILPH_EMPLOYEE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCo3FSilphEmployeeScript, -1
	object_event  2,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCo3FScientist1Text, -1
	object_event  9,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCo3FScientist2Text, -1
	object_event 14,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_SILPH, MART_SILPH_CO, -1
	object_event 13,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCo3FOfficerText, -1
	object_event  7,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCo3FGentlemanText, -1

SilphCo3FSilphEmployeeScript:
	checkevent EVENT_GOT_CHERISH_BALL_FROM_SAFFRON
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem CHERISH_BALL, iffalse_endtext
	setevent EVENT_GOT_CHERISH_BALL_FROM_SAFFRON
	jumpthisopenedtext

.Text2:
	text "Das ist eine sehr"
	line "seltene Art von"
	cont "#ball."

	para "Verschwende ihn"
	line "nicht!"
	done

.Text1:
	text "Ich stamme aus"
	line "einer Familie,"
	cont "die #bälle"
	cont "herstellt."

	para "Mein Vater Kurt"
	line "bringt meiner"
	cont "Tochter bei, wie"

	para "man Bälle aus"
	line "Aprikokos macht,"
	cont "während ich hier"
	cont "arbeite."

	para "Du hast ihnen in"
	line "Azalea City ge-"
	cont "holfen? Toll!"

	para "Schön, dass es"
	line "meiner Maisy gut"
	cont "geht."

	para "Nimm das als"
	line "Dankeschön!"
	done

SilphCo3FScientist1Text:
	text "Silph ist gerade"
	line "eine Partnerschaft"
	cont "mit der Devon"
	cont "Corporation einge-"
	cont "gangen."

	para "Wir haben uns ge-"
	line "genseitig Lizenzen"
	cont "für einige Produk-"
	cont "te erteilt."
	done

SilphCo3FScientist2Text:
	text "#bälle funktio-"
	line "nieren nach"

	para "demselben Prinzip"
	line "wie das Lagerungs-"
	cont "System im PC."

	para "#mon werden in"
	line "digitale Daten"
	cont "umgewandelt und"

	para "an einem neuen Ort"
	line "wieder zusammen-"
	cont "gesetzt."
	done

SilphCo3FOfficerText:
	text "Ich kann dich"
	line "nicht in die obe-"
	cont "ren Geschosse"
	cont "lassen,"

	para "auch wenn du"
	line "vertrauenswürdig"
	cont "bist."

	para "Tut mir leid, so"
	line "sind die Regeln."
	done

SilphCo3FGentlemanText:
	text "Ich bin zu Besuch"
	line "von der Devon"
	cont "Corporation."

	para "Wir arbeiten zu-"
	line "sammen, um die"

	para "#ball-Technolo-"
	line "gie noch weiter"
	cont "voranzubringen!"
	done

SilphCo3FDeptSignText:
	text "Silph Co. 2S"
	line "#ball-Technik"
	done

SilphCo3FPhotoText:
	text "Ein Foto vom"
	line "Silph-Präsidenten."

	para "Er scheint sich"
	line "über etwas zu"
	cont "ärgern."
	done
