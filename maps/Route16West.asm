Route16West_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 37,  1, PSYCHIC_INVERS_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 22,  7, BGEVENT_ITEM + RARE_CANDY, EVENT_ROUTE_16_WEST_HIDDEN_RARE_CANDY

	def_object_events
	object_event 56,  9, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerLassGina, -1
	object_event 17,  9, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerLassAlice, -1
	object_event  9, 10, SPRITE_COSPLAYER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerCosplayerKuroko, -1
	object_event 40, 13, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCooltrainerfSera, -1
	object_event  6,  4, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBeautyNicole, -1
	itemball_event 42, 16, METRONOME_I, 1, EVENT_ROUTE_16_WEST_METRONOME
	itemball_event 50,  3, PP_UP, 1, EVENT_ROUTE_16_WEST_PP_UP
	itemball_event 21,  4, MAX_REVIVE, 1, EVENT_ROUTE_16_WEST_MAX_REVIVE
	cuttree_event 57,  4, EVENT_ROUTE_16_WEST_CUT_TREE
	cuttree_event 67,  3, EVENT_ROUTE_16_NORTH_CUT_TREE

GenericTrainerLassGina:
	generictrainer LASS, GINA, EVENT_BEAT_LASS_GINA, .SeenText, .BeatenText

	text "Aber meine"
	line "Riemchensandalen"
	cont "sind sooo süß! ♥"
	done

.SeenText:
	text "Sieh dir mein"
	line "neues Outfit an!"
	done

.BeatenText:
	text "Hätte ich das Geld"
	line "für Tränke statt"
	cont "für Kleider aus-"
	cont "gegeben…"
	done

GenericTrainerLassAlice:
	generictrainer LASS, ALICE, EVENT_BEAT_LASS_ALICE, .SeenText, .BeatenText

	text "Eigentlich bin ich"
	line "ein Kerl…"
	cont "Verrat's keinem!"
	done

.SeenText:
	text "Unsere Blicke"
	line "haben sich"
	cont "getroffen!"

	para "Jetzt musst du mit"
	line "mir ausgehen! ♥"

	para "Nein, warte, ich"
	line "meine, wir müssen"
	cont "kämpfen!"
	done

.BeatenText:
	text "Wie kannst du nur"
	line "so grausam sein?"
	done

GenericTrainerCosplayerKuroko:
	generictrainer COSPLAYER, KUROKO, EVENT_BEAT_COSPLAYER_KUROKO, .SeenText, .BeatenText

	text "Einmal hat ein"
	line "Trainer einen"
	cont "#ball nach mir"
	cont "geworfen!"
	done

.SeenText:
	text "Siehst du, wie"
	line "echt mein Cosplay"
	cont "aussieht?"
	done

.BeatenText:
	text "Du weißt Kunst"
	line "einfach nicht zu"
	cont "schätzen!"
	done

GenericTrainerCooltrainerfSera:
	generictrainer COOLTRAINERF, SERA, EVENT_BEAT_COOLTRAINERF_SERA, .SeenText, .BeatenText

	text "Ich war schon als"
	line "Cosplayerin unter-"
	cont "wegs, aber"

	para "das Outfit eines"
	line "Ass-Trainers wirkt"
	cont "einschüchternder."
	done

.SeenText:
	text "Glaubst du, du"
	line "wirst mit mir"
	cont "fertig?"
	done

.BeatenText:
	text "Glückwunsch! ♥"
	done

GenericTrainerBeautyNicole:
	generictrainer BEAUTY, BEAUTY_NICOLE, EVENT_BEAT_BEAUTY_NICOLE, .SeenText, .BeatenText

	text "Auch süße #mon"
	line "können stark sein,"
	cont "weißt du!"
	done

.SeenText:
	text "Sind meine #mon"
	line "nicht die"
	cont "süßesten?"
	done

.BeatenText:
	text "Sogar besiegt"
	line "sind sie süß…"
	done
