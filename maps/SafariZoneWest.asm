SafariZoneWest_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 22,  2, SAFARI_ZONE_NORTH, 8
	warp_event 23,  2, SAFARI_ZONE_NORTH, 9
	warp_event 28,  2, SAFARI_ZONE_NORTH, 3
	warp_event 29,  2, SAFARI_ZONE_NORTH, 4
	warp_event 31, 24, SAFARI_ZONE_HUB, 5
	warp_event 31, 25, SAFARI_ZONE_HUB, 6
	warp_event 13, 13, SAFARI_ZONE_WEST_REST_HOUSE_1, 1
	warp_event  5,  5, SAFARI_ZONE_WEST_REST_HOUSE_2, 1

	def_coord_events

	def_bg_events
	bg_event 26, 24, BGEVENT_JUMPTEXT, SafariZoneWestAreaSignText
	bg_event 14, 14, BGEVENT_JUMPTEXT, SafariZoneWestRestHouseSignText
	bg_event 28,  6, BGEVENT_JUMPTEXT, SafariZoneWestTrainerTips1SignText
	bg_event 19,  5, BGEVENT_JUMPTEXT, SafariZoneWestTrainerTips2SignText
	bg_event 13,  6, BGEVENT_ITEM + NUGGET, EVENT_SAFARI_ZONE_WEST_HIDDEN_NUGGET

	def_object_events
	object_event 22, 23, SPRITE_LASS, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerLassDuplica, -1
	object_event 23, 12, SPRITE_CAMPER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerCamperAmos, -1
	object_event 12, 19, SPRITE_TAMER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerTamerBrett, -1
	itemball_event 14,  9, MAX_REVIVE, 1, EVENT_SAFARI_ZONE_WEST_MAX_REVIVE

GenericTrainerLassDuplica:
	generictrainer LASS, DUPLICA, EVENT_BEAT_LASS_DUPLICA, LassDuplicaSeenText, LassDuplicaBeatenText

	text "Ich bin richtig"
	line "gut im Imitieren!"

	para "Eines Tages werde"
	line "ich Trainerin in"

	para "der Arena von"
	line "Fuchsania City und"
	cont "imitiere Janina."
	done

GenericTrainerCamperAmos:
	generictrainer CAMPER, AMOS, EVENT_BEAT_CAMPER_AMOS, CamperAmosSeenText, CamperAmosBeatenText

	text "Ich suche weit"
	line "und breit nach"
	cont "neuen #mon."
	done

GenericTrainerTamerBrett:
	generictrainer TAMER, BRETT, EVENT_BEAT_TAMER_BRETT, TamerBrettSeenText, TamerBrettBeatenText

	text "Du musst #mon"
	line "mit Selbstver-"
	cont "trauen befehligen."

	para "Orden zu verdie-"
	line "nen kann dabei"
	cont "helfen."
	done

LassDuplicaSeenText:
	text "Um Ditto wirklich"
	line "einzusetzen, musst"
	cont "du alle #mon"
	cont "kennen!"
	done

LassDuplicaBeatenText:
	text "Ich muss noch viel"
	line "lernen."
	done

CamperAmosSeenText:
	text "In der Safari-"
	line "Zone leben jede"
	cont "Menge #mon."

	para "Ich will sie mir"
	line "alle schnappen!"
	done

CamperAmosBeatenText:
	text "Ich habe verlo-"
	line "ren, weil ich sie"
	cont "trainieren muss!"
	done

TamerBrettSeenText:
	text "Weißt du, wie man"
	line "mit aggressiven"
	cont "#mon umgeht?"
	done

TamerBrettBeatenText:
	text "Ja, das weißt du!"
	done

SafariZoneWestAreaSignText:
	text "Safari-Zone"
	line "Westbereich"
	done

SafariZoneWestRestHouseSignText:
	text "Rasthaus"
	done

SafariZoneWestTrainerTips1SignText:
	text "Tipps für Trainer"

	para "#mon vom Typ"
	line "Feuer können nicht"
	cont "verbrannt werden,"

	para "vom Typ Elektro"
	line "nicht paralysiert"

	para "und vom Typ Eis"
	line "nicht eingefroren."
	done

SafariZoneWestTrainerTips2SignText:
	text "Tipps für Trainer"

	para "Im Sandsturm"
	line "erhalten Gestein-"
	cont "#mon einen"
	cont "Bonus auf ihre"
	cont "Sp.Vert."
	done
