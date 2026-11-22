LyrasHouse1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, NEW_BARK_TOWN, 4
	warp_event  3,  7, NEW_BARK_TOWN, 4
	warp_event  0,  0, LYRAS_HOUSE_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_UP, LyrasFridgeScript
	bg_event  8,  1, BGEVENT_JUMPTEXT, LyrasSinkText
	bg_event  9,  1, BGEVENT_JUMPTEXT, LyrasStoveText
	bg_event  5,  1, BGEVENT_UP, LyrasTVScript

	def_object_events
	object_event  2,  3, SPRITE_DAD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, LyrasDadScript, -1

LyrasDadScript:
	faceplayer
	opentext
	checkevent EVENT_LYRA_IN_HER_ROOM
	iffalsefwd .LyraInside
	checkevent EVENT_GOT_SS_TICKET_FROM_ELM
	iftruefwd .LyraTraining
	jumpthisopenedtext

	text "Hi, <PLAYER>!"
	line "Lyra ist nicht da."

	para "Sie hilft gerade"
	line "fleissig dem"
	cont "Professor."
	done

.LyraInside
	jumpthisopenedtext

	text "Hi, <PLAYER>!"
	line "Lyra ist oben."

	para "Sie spielt wie"
	line "immer mit ihren"
	cont "#mon."
	done

.LyraTraining
	jumpthisopenedtext

	text "Hi, <PLAYER>!"
	line "Lyra ist nicht da."

	para "Sie sammelt in"
	line "ganz Johto Orden!"
	done




LyrasFridgeScript:
	jumpthistext

	text "Mal sehen, was da"
	line "im Kühlschrank zu"
	cont "finden ist…"

	para "Tafelwasser und"
	line "Reisbällchen!"
	done

LyrasSinkText:
	text "Die Spüle ist"
	line "fleckenlos rein."
	done

LyrasStoveText:
	text "Auf dem Herd"
	line "köchelt Curry."
	done

LyrasTVScript:
	jumpthistext

	text "Es läuft ein Film"
	line "im TV: Ein Mädchen"

	para "mit Zöpfen folgt"
	line "einer gelben Zie-"
	cont "gelsteinstrasse…"

	para "Ich sollte mich"
	line "auch auf den Weg"
	cont "machen!"
	done
