SeafoamIslandsB2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 25, 15, SEAFOAM_ISLANDS_B1F, 3
	warp_event 15,  7, SEAFOAM_ISLANDS_B1F, 4
	warp_event 13, 13, SEAFOAM_ISLANDS_B1F, 5
	warp_event  7, 15, SEAFOAM_ISLANDS_B1F, 6
	warp_event 35,  7, SEAFOAM_ISLANDS_B3F, 1
	warp_event 28,  9, SEAFOAM_ISLANDS_B3F, 2
	warp_event 35, 15, SEAFOAM_ISLANDS_B3F, 3
	warp_event  4, 13, SEAFOAM_ISLANDS_B3F, 4

	def_coord_events

	def_bg_events
	bg_event  7,  9, BGEVENT_ITEM + PEARL, EVENT_SEAFOAM_ISLANDS_B2F_HIDDEN_PEARL_1
	bg_event 35, 13, BGEVENT_ITEM + PEARL, EVENT_SEAFOAM_ISLANDS_B2F_HIDDEN_PEARL_2

	def_object_events
	object_event 11,  4, SPRITE_SKIER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSkierCady, -1
	object_event 16,  5, SPRITE_BOARDER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBoarderShaun, -1
	object_event 25,  8, SPRITE_BOARDER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBoarderBryce, -1
	itemball_event 15, 16, WATER_STONE, 1, EVENT_SEAFOAM_ISLANDS_B2F_WATER_STONE

GenericTrainerSkierCady:
	generictrainer SKIER, CADY, EVENT_BEAT_SKIER_CADY, SkierCadySeenText, SkierCadyBeatenText

	text "Das war ein"
	line "heißer Kampf!"
	done

GenericTrainerBoarderShaun:
	generictrainer BOARDER, SHAUN, EVENT_BEAT_BOARDER_SHAUN, BoarderShaunSeenText, BoarderShaunBeatenText

	text "Na gut, geh bitte"
	line "durch!"
	done

GenericTrainerBoarderBryce:
	generictrainer BOARDER, BRYCE, EVENT_BEAT_BOARDER_BRYCE, BoarderBryceSeenText, BoarderBryceBeatenText

	text "Trainer gibt es"
	line "überall."
	done

SkierCadySeenText:
	text "Gegen die Kälte"
	line "helfen warme"
	cont "Kleidung und ein"
	cont "heißes Getränk!"
	done

SkierCadyBeatenText:
	text "Argh, und das so"
	line "weit hier draußen!"
	done

BoarderShaunSeenText:
	text "Hey, hey, du"
	line "stehst mir im Weg!"
	cont "Genau!"
	done

BoarderShaunBeatenText:
	text "Ich wurde herum-"
	line "geschubst…"
	done

BoarderBryceSeenText:
	text "Warum bist du wohl"
	line "den weiten Weg"
	cont "hier rausgekommen?"
	done

BoarderBryceBeatenText:
	text "Den weiten Weg"
	line "gekommen, nur um"
	cont "zu verlieren…"
	done
