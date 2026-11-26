Route13_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event 35, 13, BGEVENT_JUMPTEXT, Route13TrainerTips1Text
	bg_event 53,  5, BGEVENT_JUMPTEXT, Route13TrainerTips2Text
	bg_event 51, 11, BGEVENT_JUMPTEXT, Route13SignText
	bg_event 17, 13, BGEVENT_JUMPTEXT, Route13DirectionsSignText
	bg_event 36, 13, BGEVENT_ITEM + CALCIUM, EVENT_ROUTE_13_HIDDEN_CALCIUM
	bg_event  5, 15, BGEVENT_ITEM + OVAL_STONE, EVENT_ROUTE_13_HIDDEN_OVAL_STONE

	def_object_events
	object_event  5,  5, SPRITE_CAMPER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCamperClark, -1
	object_event 16,  6, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerPicnickerGinger, -1
	object_event 60, 11, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerBird_keeperPerry, -1
	object_event 64,  1, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperBret, -1
	object_event 34,  5, SPRITE_CAMPER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCamperTanner, -1
	object_event 65,  9, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPicnickerPiper, -1
	object_event 52,  6, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleTimandsue1, -1
	object_event 53,  6, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleTimandsue2, -1
	object_event 38,  8, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPokefanmJoshua, -1
	object_event 14, 10, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerHikerKenny, -1
	object_event 25,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerPokefanmAlex, -1
	object_event 21, 13, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, Route13GrampsScript, -1
	cuttree_event 54,  4, EVENT_ROUTE_13_CUT_TREE

Route13GrampsScript:
	special CheckIfTrendyPhraseIsLucky
	iftruefwd .lucky
	jumpthistextfaceplayer

	text "I can't see Lucky"
	line "Island today…"

	para "But I know it's"
	line "appeared before!"
	done

.lucky
	jumpthistextfaceplayer

	text "I can see Lucky"
	line "Island today!"
	cont "What a spectacle!"
	done

GenericTrainerCamperClark:
	generictrainer CAMPER, CLARK, EVENT_BEAT_CAMPER_CLARK, .SeenText, .BeatenText

	text "Egal, wie gut du"
	line "dich vorbereitet"
	cont "hast."

	para "Wenn du verlierst,"
	line "verlierst du."
	done

.SeenText:
	text "Wasser sammeln!"
	line "Das Feuer nicht"
	cont "ausgehen lassen!"

	para "Auf wilde #mon"
	line "achten!"

	para "Los geht's,"
	line "Lagerfeuer!"
	done

.BeatenText:
	text "Pfuuuuhh…"
	done

GenericTrainerPicnickerGinger:
	generictrainer PICNICKER, GINGER, EVENT_BEAT_PICNICKER_GINGER, .SeenText, .BeatenText

	text "Statt mit Worten"
	line "kannst du mit"
	cont "#mon auch durch"

	para "Pfeifen"
	line "kommunizieren!"
	done

.SeenText:
	text "Warum muss ich"
	line "draußen immer"
	cont "pfeifen?"
	done

.BeatenText:
	text "Fiiiiiep!"
	done

GenericTrainerBird_keeperPerry:
	generictrainer BIRD_KEEPER, PERRY, EVENT_BEAT_BIRD_KEEPER_PERRY, Bird_keeperPerrySeenText, Bird_keeperPerryBeatenText

	text "Deine #mon sind"
	line "in der Tat sehr"
	cont "gut trainiert."
	done

Bird_keeperPerrySeenText:
	text "Agilität ist die"
	line "wichtigste Eigen-"
	cont "schaft von Vogel-"
	cont "#mon."
	done

Bird_keeperPerryBeatenText:
	text "Du hast mich"
	line "aufgrund deiner"
	cont "Schnelligkeit"
	cont "besiegt…"
	done

GenericTrainerBird_keeperBret:
	generictrainer BIRD_KEEPER, BRET, EVENT_BEAT_BIRD_KEEPER_BRET, Bird_keeperBretSeenText, Bird_keeperBretBeatenText

	text "Wenn du deine"
	line "#mon pflegst,"
	cont "sind sie fröhlich."
	done

Bird_keeperBretSeenText:
	text "Schau dir meine"
	line "#mon an. Sieh"

	para "ihre Farben und"
	line "ihr Gefieder."
	done

Bird_keeperBretBeatenText:
	text "Verflixt!"
	line "Nicht gut genug!"
	done

GenericTrainerCamperTanner:
	generictrainer CAMPER, TANNER, EVENT_BEAT_CAMPER_TANNER, .SeenText, .BeatenText

	text "Ich dachte, dich"
	line "umzuhauen wäre"
	cont "ein Leichtes…"
	done

.SeenText:
	text "Ein schneller"
	line "Kampf geht beim"
	cont "Kochen immer!"
	done

.BeatenText:
	text "Oh, ich hab"
	line "Hunger…"
	done

GenericTrainerPicnickerPiper:
	generictrainer PICNICKER, PIPER, EVENT_BEAT_PICNICKER_PIPER, .SeenText, .BeatenText

	text "So wie du gelau-"
	line "fen bist, dachte"
	cont "ich, ich gewinne."
	done

.SeenText:
	text "Wie wäre es, wenn"
	line "wir deine und"

	para "meine #mon zum"
	line "Kampf rufen?"
	done

.BeatenText:
	text "Oh, wie schade…"
	done

GenericTrainerCoupleTimandsue1:
	generictrainer COUPLE, TIMANDSUE1, EVENT_BEAT_COUPLE_TIM_AND_SUE, .SeenText, .BeatenText

	text "Finn: Wenn du sie"
	line "besiegt hast,"
	cont "musst du stark"
	cont "sein!"
	done

.SeenText:
	text "Finn: Ich gebe dir"
	line "einen kleinen"
	cont "Tipp."

	para "Meine Freundin ist"
	line "stärker als ich!"
	done

.BeatenText:
	text "Finn: Du bist am"
	line "stärksten!"
	done

GenericTrainerCoupleTimandsue2:
	generictrainer COUPLE, TIMANDSUE2, EVENT_BEAT_COUPLE_TIM_AND_SUE, .SeenText, .BeatenText

	text "Zora: Diese Stärke"
	line "von dir…"
	cont "Ich hab's!"

	para "Bist du verliebt?"
	done

.SeenText:
	text "Zora: Frauen, die"
	line "die Liebe nicht"

	para "ernst nehmen,"
	line "könnten verletzt"
	cont "werden."
	done

.BeatenText:
	text "Zora: Wa ha…"
	done

GenericTrainerPokefanmAlex:
	generictrainer POKEFANM, ALEX, EVENT_BEAT_POKEFANM_ALEX, PokefanmAlexSeenText, PokefanmAlexBeatenText

	text "Möchte nicht jeder"
	line "eines Tages einmal"
	cont "König sein?"
	done

PokefanmAlexSeenText:
	text "Verbeuge dich vor"
	line "meinen königlichen"
	cont "#mon!"
	done

PokefanmAlexBeatenText:
	text "Wie… wie kannst"
	line "du es wagen, die"
	cont "Monarchie zu"
	cont "verspotten?"
	done

GenericTrainerPokefanmJoshua:
	generictrainer POKEFANM, JOSHUA, EVENT_BEAT_POKEFANM_JOSHUA, PokefanmJoshuaSeenText, PokefanmJoshuaBeatenText

	text "Es scheint, dass"
	line "du viele #mon"

	para "hast, aber Pikachu"
	line "ist immer noch das"
	cont "Beste."
	done

PokefanmJoshuaSeenText:
	text "Hihi! Möchtest du"
	line "gegen mein"
	cont "Pikachu-Team"
	cont "antreten?"
	done

PokefanmJoshuaBeatenText:
	text "Pi-Pikachu!"
	done

GenericTrainerHikerKenny:
	generictrainer HIKER, KENNY, EVENT_BEAT_HIKER_KENNY, HikerKennySeenText, HikerKennyBeatenText

	text "Es scheint, als"
	line "würden sich geo-"
	cont "logische Gegeben-"
	cont "heiten nicht"
	cont "ändern."

	para "Aber sie ändern"
	line "sich, langsam,"
	cont "ganz langsam."
	done

HikerKennySeenText:
	text "Ich sollte zum"
	line "Felstunnel gehen"
	cont "und mir ein Onix"
	cont "fangen."
	done

HikerKennyBeatenText:
	text "Ich habe verloren…"
	done

Route13TrainerTips1Text:
	text "Tipps für Trainer"

	para "Schau! Hier, an"
	line "der linken Seite"
	cont "des Pfostens."
	done

Route13TrainerTips2Text:
	text "Trainer Tips"

	para "Some #mon need"
	line "items to evolve."

	para "If you're lucky,"
	line "a wild #mon can"

	para "be found holding"
	line "its own evolution"
	cont "item!"
	done

Route13SignText:
	text "Route 13"

	para "Nördlich zur"
	line "Schweigebrücke"
	done

Route13DirectionsSignText:
	text "Nördlich nach"
	line "Lavandia"

	para "Westlich nach"
	line "Fuchsania City"
	done
