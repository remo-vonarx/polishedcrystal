Route35CoastNorth_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 13, 22, ROUTE_35_NATIONAL_PARK_GATE, 5
	warp_event 13, 23, ROUTE_35_NATIONAL_PARK_GATE, 6
	warp_event  4, 10, HIDDEN_TREE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event  9, 19, BGEVENT_JUMPTEXT, Route35CoastNorthAdvancedTipsSignText
	bg_event  4, 13, BGEVENT_ITEM + BIG_PEARL, EVENT_ROUTE_35_COAST_NORTH_HIDDEN_BIG_PEARL
	bg_event  4, 22, BGEVENT_ITEM + SOFT_SAND, EVENT_ROUTE_35_COAST_NORTH_HIDDEN_SOFT_SAND
	bg_event  4,  9, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_35_COAST
	bg_event  5,  9, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_35_COAST

	def_object_events
	object_event  6, 18, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerLassRose, -1

GenericTrainerLassRose:
	generictrainer LASS, ROSE, EVENT_BEAT_LASS_ROSE, LassRoseSeenText, LassRoseBeatenText

	text "Du hast meinen"
	line "weitgereisten"
	cont "#mon wehgetan!"

	para "Ich verlange, dass"
	line "du sie in einem"
	cont "#mon-Center"
	cont "heilst!"
	done

LassRoseSeenText:
	text "Diese #mon habe"
	line "ich aus der ganzen"
	cont "Welt gesammelt!"
	done

LassRoseBeatenText:
	text "Oh nein!"
	line "Dafür bin ich um"
	cont "die Welt gereist!"
	done

Route35CoastNorthAdvancedTipsSignText:
	text "Profi-Tipps!"

	para "Du kannst sogar"
	line "vom Rücken eines"

	para "surfenden #mon"
	line "aus angeln!"
	done
