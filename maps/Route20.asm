Route20_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 70,  9, SEAFOAM_ISLANDS_1F, 1
	warp_event 62,  5, SEAFOAM_ISLANDS_1F, 4

	def_coord_events

	def_bg_events
	bg_event 69, 11, BGEVENT_JUMPTEXT, CinnabarGymSignText
	bg_event 65,  7, BGEVENT_JUMPTEXT, SeafoamIslandsSignText
	bg_event 21, 11, BGEVENT_ITEM + STARDUST, EVENT_ROUTE_20_HIDDEN_STARDUST

	def_object_events
	object_event 99, 10, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfNicole, -1
	object_event 78, 13, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfLori, -1
	object_event 32,  4, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfMayu, -1
	object_event 62, 14, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSwimmerfLeona, -1
	object_event  8,  6, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmermCameron, -1
	object_event 77,  3, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmermLuis, -1
	object_event 88,  8, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmermElmo, -1
	object_event 18, 12, SPRITE_PICNICKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerPicnickerCheyenne, -1
	object_event 25, 14, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerPicnickerAdrian, -1
	object_event 13, 14, SPRITE_CAMPER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerCamperPedro, -1
	object_event 46,  9, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBird_keeperBert, -1
	object_event 69,  5, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperErnie, -1
	itemball_event 72,  3, BIG_PEARL, 1, EVENT_ROUTE_20_BIG_PEARL

GenericTrainerSwimmerfNicole:
	generictrainer SWIMMERF, NICOLE, EVENT_BEAT_SWIMMERF_NICOLE, SwimmerfNicoleSeenText, SwimmerfNicoleBeatenText

	text "Beim Schwimmen"
	line "wird der gesamte"

	para "Körper trainiert."
	line "Schwimmen ist"
	cont "gesund."
	done

SwimmerfNicoleSeenText:
	text "Im Wasser fühle"
	line "ich mich so"
	cont "leicht."
	done

SwimmerfNicoleBeatenText:
	text "Oh, nein!"
	done

GenericTrainerSwimmerfLori:
	generictrainer SWIMMERF, LORI, EVENT_BEAT_SWIMMERF_LORI, SwimmerfLoriSeenText, SwimmerfLoriBeatenText

	text "Surfer ist nicht"
	line "mehr die einzige"
	cont "VM, die du im"
	cont "Wasser einsetzen"
	cont "kannst."
	done

SwimmerfLoriSeenText:
	text "Du besitzt eine"
	line "umwerfende Anzahl"

	para "Arena-Orden. Lass"
	line "uns kämpfen!"
	done

SwimmerfLoriBeatenText: ; text > text
	text "Nein!"
	done

GenericTrainerSwimmerfMayu:
	generictrainer SWIMMERF, MAYU, EVENT_BEAT_SWIMMERF_MAYU, .SeenText, .BeatenText

	text "Ich wollte sehen,"
	line "wie lange ich die"

	para "Luft anhalten"
	line "kann!"
	done

.SeenText:
	text "Mmph? Mmmph"
	line "mmmmphh?"

	para "Mmmmph"
	line "mmmmmppphh!"
	done

.BeatenText:
	text "Pwah!"
	done

GenericTrainerSwimmerfLeona:
	generictrainer SWIMMERF, LEONA, EVENT_BEAT_SWIMMERF_LEONA, .SeenText, .BeatenText

	text "Deine #mon…"
	line "Folgst du dem"

	para "neuesten Trend"
	line "bei Teams?"
	done

.SeenText:
	text "Sieh mal! Mein"
	line "allerbester Bade-"
	cont "anzug und"

	para "meine allerbesten"
	line "#mon!"
	done

.BeatenText:
	text "Ohhh!"
	done

GenericTrainerSwimmermCameron:
	generictrainer SWIMMERM, CAMERON, EVENT_BEAT_SWIMMERM_CAMERON, SwimmermCameronSeenText, SwimmermCameronBeatenText

	text "Ich schwimme auch"
	line "in Teichen und"
	cont "Flüssen."
	done

SwimmermCameronSeenText:
	text "Ich denke es ist"
	line "unmöglich, den"

	para "ganzen Weg nach"
	line "Johto zu"
	cont "schwimmen."
	done

SwimmermCameronBeatenText:
	text "Yippie!"
	done

GenericTrainerSwimmermLuis:
	generictrainer SWIMMERM, SWIMMERM_LUIS, EVENT_BEAT_SWIMMERM_LUIS, .SeenText, .BeatenText

	text "Na gut! Nächstes"
	line "Mal trage ich"
	cont "meine Party-"
	cont "Badehose!"
	done

.SeenText:
	text "Ich trage heute"
	line "meine beste"
	cont "Badehose!"
	done

.BeatenText:
	text "Selbst mit meiner"
	line "besten Hose habe"
	cont "ich nicht"
	cont "gewonnen."
	done

GenericTrainerSwimmermElmo:
	generictrainer SWIMMERM, ELMO, EVENT_BEAT_SWIMMERM_ELMO, .SeenText, .BeatenText

	text "Vielleicht sollte"
	line "ich wieder angeln"
	cont "gehen…"
	done

.SeenText:
	text "Früher war ich"
	line "Angler."

	para "Inzwischen liebe"
	line "ich das Schwimmen"

	para "so sehr, dass ich"
	line "immer Badehose"
	cont "trage!"
	done

.BeatenText: ; text > text
	text "Ulp…"
	done

GenericTrainerPicnickerCheyenne:
	generictrainer PICNICKER, CHEYENNE, EVENT_BEAT_PICNICKER_CHEYENNE, .SeenText, .BeatenText

	text "Mit #mon macht"
	line "mir Verlieren"
	cont "nicht so viel aus!"
	done

.SeenText:
	text "Als Kind habe ich"
	line "nur im Haus"
	cont "gespielt."

	para "Jetzt spiele ich"
	line "gern draußen mit"
	cont "#mon!"
	done

.BeatenText:
	text "Argh!"
	done

GenericTrainerPicnickerAdrian:
	generictrainer PICNICKER, ADRIAN, EVENT_BEAT_PICNICKER_ADRIAN, .SeenText, .BeatenText

	text "Ich habe zwar"
	line "verloren, aber es"
	cont "hat Spaß gemacht!"
	done

.SeenText:
	text "Hast du es eilig?"

	para "Wie wäre es mit"
	line "einer kleinen"
	cont "Kampfpause?"
	done

.BeatenText:
	text "Aaahh… das war's."
	done

GenericTrainerCamperPedro:
	generictrainer CAMPER, PEDRO, EVENT_BEAT_CAMPER_PEDRO, .SeenText, .BeatenText

	text "Wenn du deine"
	line "Decke vergisst,"

	para "kannst du dich an"
	line "ein warmes #mon"
	cont "kuscheln!"
	done

.SeenText:
	text "Warst du schon mal"
	line "mit #mon"
	cont "zelten?"
	done

.BeatenText:
	text "Du bist stark!"
	done

GenericTrainerBird_keeperBert:
	generictrainer BIRD_KEEPER, BERT, EVENT_BEAT_BIRD_KEEPER_BERT, .SeenText, .BeatenText

	text "Das war ein un-"
	line "glaublicher Kampf!"

	para "Ich habe Gänse-"
	line "haut!"
	done

.SeenText:
	text "Gefunden! Einen"
	line "Trainer, gegen den"
	cont "ich gern kämpfe!"
	done

.BeatenText:
	text "Ich habe mit all"
	line "meiner Kraft"
	cont "verloren!"
	done

GenericTrainerBird_keeperErnie:
	generictrainer BIRD_KEEPER, ERNIE, EVENT_BEAT_BIRD_KEEPER_ERNIE, .SeenText, .BeatenText

	text "Du bist etwas"
	line "Besonderes!"
	done

.SeenText:
	text "Hey, hey. Kämpfst"
	line "du gegen mich?"
	done

.BeatenText:
	text "Das war ziemlich"
	line "unglaublich."
	done

CinnabarGymSignText:
	text "Seeschauminseln"

	para "…Was steht auf"
	line "diesem Schild?"

	para "PKMN-Arena der"
	line "Zinnoberinsel"

	para "Leitung: Pyro"
	done

SeafoamIslandsSignText:
	text "Seeschauminseln"
	done
