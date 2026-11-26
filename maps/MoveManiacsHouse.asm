MoveManiacsHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CIANWOOD_CITY, 7
	warp_event  3,  7, CIANWOOD_CITY, 7

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_JUMPSTD, magazinebookshelf

	def_object_events
	object_event  2,  3, SPRITE_COSPLAYER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, MoveReminderScript, -1

MoveReminderScript:
	faceplayer
	opentext
	writetext MoveReminderIntroText
	waitbutton
	checkitem GOLD_LEAF
	iffalsefwd .no_gold_leaf
	writetext MoveReminderPromptText
	yesorno
	iffalsefwd .refused
	setval NO_MOVE ; to toggle move relearner
	writetext MoveReminderWhichMonText
	waitbutton
	special Special_MoveTutor
	ifequalfwd $0, .teach_move
.refused
	jumpopenedtext MoveReminderCancelText

.no_gold_leaf
	jumpopenedtext MoveReminderNoGoldLeafText

.teach_move
	takeitem GOLD_LEAF
	jumpopenedtext MoveReminderCancelText

MoveReminderIntroText::
	text "Ich? Ich bin der"
	line "Attackenmaniac."

	para "Für ein Goldblatt"
	line "bringe ich deinen"
	cont "#mon eine alte"
	cont "Attacke wieder"
	cont "bei!"
	done

MoveReminderPromptText::
	text "Soll ich einem"
	line "deiner #mon"
	cont "eine Attacke bei-"
	cont "bringen?"
	done

MoveReminderWhichMonText::
	text "Juhu! Welches"
	line "#mon braucht"
	cont "Nachhilfe?"
	done

MoveReminderNoGoldLeafText::
	text "Hä? Du hast gar"
	line "keine Goldblätter."

	para "Manchmal tragen"
	line "wilde Knofensa"
	cont "welche bei sich."
	done

MoveReminderNoMovesText::
	text "Tut mir leid…"
	line "Es gibt keine"

	para "Attacke, die ich"
	line "dem #mon wieder"
	cont "beibringen kann."
	prompt

MoveReminderCancelText::
	text "Falls ein #mon"
	line "eine Attacke ler-"

	para "nen soll, komm mit"
	line "einem Goldblatt"
	cont "wieder!"
	done
