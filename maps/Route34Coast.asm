Route34Coast_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7, 47, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmermFrank, -1
	object_event 10, 21, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_DARK_RED, OBJECTTYPE_TRAINER, 4, TrainerSwimmermNadar, -1
	object_event  7, 61, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerSwimmermConrad, -1
	object_event  8, 43, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfCaroline, -1
	object_event  8,  6, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfNatalia, -1
	object_event 12, 14, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherFrancis, -1
	object_event  7, 32, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBird_keeperTony, -1
	object_event  3, 37, SPRITE_FLOATING_BALL, SPRITEMOVEDATA_POKEMON, 0, 0, -1, 0, OBJECTTYPE_ITEMBALL, PLAYEREVENT_ITEMBALL, PEARL_STRING, 1, EVENT_ROUTE_34_COAST_PEARL_STRING

GenericTrainerSwimmermFrank:
	generictrainer SWIMMERM, FRANK, EVENT_BEAT_SWIMMERM_FRANK, .SeenText, .BeatenText

	text "Meer, Sand, Sonne"
	line "und #mon!"

	para "Was braucht ein"
	line "Kerl mehr?"
	done

.SeenText:
	text "Ich mache mit"
	line "meiner Frau Ur-"
	cont "laub, aber okay,"
	cont "ich kämpfe gegen"
	cont "dich."
	done

.BeatenText:
	text "Ist mir egal, ich"
	line "bin im Urlaub!"
	done

TrainerSwimmermNadar:
	trainer SWIMMERM, NADAR, EVENT_BEAT_SWIMMERM_NADAR, .SeenText, .BeatenText, 0, .Script, TRAINERPAL_DARK_SWIMMERM

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Schwimmen üben"
	line "oder mit meinen"
	cont "#mon"
	cont "trainieren?"

	para "Was für ein"
	line "Dilemma."
	done

.SeenText:
	text "Schwimmen ist"
	line "meine Spezialität!"

	para "#mon-Kämpfe"
	line "auch!"
	done

.BeatenText:
	text "Ich habe in"
	line "meiner Spezialität"
	cont "verloren?"
	done

GenericTrainerSwimmermConrad:
	generictrainer SWIMMERM, CONRAD, EVENT_BEAT_SWIMMERM_CONRAD, .SeenText, .BeatenText

	text "UV-Strahlen werden"
	line "von den Wellen re-"
	cont "flektiert."

	para "Denk immer an"
	line "Sonnencreme."
	done

.SeenText:
	text "Sonnencreme drauf,"
	line "Brille runter… Ich"

	para "bin Feuer und"
	line "Flamme für die"
	cont "Wellen!"
	done

.BeatenText:
	text "Uff! Diesmal haben"
	line "mich die Wellen"
	cont "erwischt."
	done

GenericTrainerSwimmerfCaroline:
	generictrainer SWIMMERF, CAROLINE, EVENT_BEAT_SWIMMERF_CAROLINE, .SeenText, .BeatenText

	text "Wir wohnen in"
	line "Dukatia City,"

	para "aber diese Route"
	line "ist ein schöner"
	cont "Ausflug!"
	done

.SeenText:
	text "Mein Mann und ich"
	line "machen hier"
	cont "Urlaub."
	done

.BeatenText:
	text "Oh! Wie schade."
	done

GenericTrainerSwimmerfNatalia:
	generictrainer SWIMMERF, NATALIA, EVENT_BEAT_SWIMMERF_NATALIA, .SeenText, .BeatenText

	text "Ich glaube, ich"
	line "habe den falschen"
	cont "Bikini gekauft."

	para "Das ist wirklich"
	line "nicht meine Farbe."
	done

.SeenText:
	text "Ich habe mir einen"
	line "neuen Bikini"
	cont "gekauft."

	para "Das ist die neues-"
	line "te Mode."
	done

.BeatenText:
	text "Pah!"
	done

GenericTrainerFisherFrancis:
	generictrainer FISHER, FRANCIS, EVENT_BEAT_FISHER_FRANCIS, .SeenText, .BeatenText

	text "Ob ich gewinne"
	line "oder verliere, ist"
	cont "egal."

	para "Ich will nur Spaß"
	line "haben und weiter"
	cont "angeln."
	done

.SeenText:
	text "Ich angle gern"
	line "#mon an exoti-"
	cont "schen Orten."
	done

.BeatenText:
	text "Oh! Was für ein"
	line "Biss!"
	done

GenericTrainerBird_keeperTony:
	generictrainer BIRD_KEEPER, BIRD_KEEPER_TONY, EVENT_BEAT_BIRD_KEEPER_TONY, .SeenText, .BeatenText

	text "Everybody's heard"
	line "that the bird is"
	cont "the word."
	done

.SeenText:
	text "Have you heard"
	line "about the bird?"
	done

.BeatenText:
	text "Don't you know"
	line "about the bird?"
	done
