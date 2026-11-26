Route32Coast_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 55, UNION_CAVE_B1F_SOUTH, 4
	warp_event 17, 49, ROUTE_32_COAST_HOUSE, 1
	warp_event  8, 42, HIDDEN_TREE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event 15, 27, BGEVENT_JUMPTEXT, Route32CoastTrainerTipsText
	bg_event  5, 57, BGEVENT_JUMPTEXT, Route32CoastUnionCaveSignText
	bg_event 17, 32, BGEVENT_ITEM + LEVEL_BALL, EVENT_ROUTE_32_COAST_HIDDEN_LEVEL_BALL
	bg_event  5, 43, BGEVENT_ITEM + HYPER_POTION, EVENT_ROUTE_32_COAST_HIDDEN_HYPER_POTION
	bg_event 14,  6, BGEVENT_ITEM + ELIXIR, EVENT_ROUTE_32_COAST_HIDDEN_ELIXIR
	bg_event  8, 41, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_32_COAST
	bg_event  9, 41, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_32_COAST

	def_object_events
	object_event  9,  5, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmermMichel, -1
	object_event 18, 65, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_DARK_RED, OBJECTTYPE_TRAINER, 4, TrainerSwimmermLucas, -1
	object_event 20,  6, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmerfAlison, -1
	object_event 23, 15, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmerfStephanie, -1
	object_event 17, 21, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_DARK_BLUE, OBJECTTYPE_TRAINER, 4, TrainerBird_keeperPowell, -1
	object_event 14, 60, SPRITE_COSPLAYER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCosplayerChloe, -1
	object_event 24, 60, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherKiley, -1
	object_event  6, 20, SPRITE_CAMPER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerCamperCraig, -1
	object_event 11, 43, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerLassLayla, -1
	object_event 25, 33, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleFoxandrae1, -1
	object_event 25, 34, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleFoxandrae2, -1
	object_event  6, 59, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route32CoastLassText, -1
	fruittree_event 21, 49, FRUITTREE_ROUTE_32_COAST, ASPEAR_BERRY, PAL_NPC_BROWN
	itemball_event  5, 16, WHITE_HERB, 1, EVENT_ROUTE_32_COAST_WHITE_HERB
	object_event 21, 61, SPRITE_FLOATING_BALL, SPRITEMOVEDATA_POKEMON, 0, 0, -1, 0, OBJECTTYPE_ITEMBALL, PLAYEREVENT_ITEMBALL, SOFT_SAND, 1, EVENT_ROUTE_32_COAST_SOFT_SAND

GenericTrainerSwimmermMichel:
	generictrainer SWIMMERM, MICHEL, EVENT_BEAT_SWIMMERM_MICHEL, .SeenText, .BeatenText

	text "Lektion gelernt:"
	line "Aufwärmübungen"
	cont "machen."
	done

.SeenText:
	text "Ich habe schon auf"
	line "dich gewartet!"

	para "Los, kämpfen wir!"
	line "Jetzt!"
	done

.BeatenText:
	text "Oh, autsch!"
	line "Ich hab einen"
	cont "Krampf!"
	done

TrainerSwimmermLucas:
	trainer SWIMMERM, LUCAS, EVENT_BEAT_SWIMMERM_LUCAS, .SeenText, .BeatenText, 0, .Script, TRAINERPAL_DARK_SWIMMERM

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Regenbögen durch"
	line "Sonnenlicht er-"

	para "scheinen am Himmel"
	line "gegenüber der"
	cont "Sonne."

	para "Interessant, was?"
	done

.SeenText:
	text "Wenn Licht in"
	line "Wassertropfen re-"
	cont "flektiert und"

	para "gebrochen wird,"
	line "entsteht ein"
	cont "Regenbogen."
	done

.BeatenText:
	text "Der Kampf war"
	line "voller Farbe!"
	done

GenericTrainerSwimmerfAlison:
	generictrainer SWIMMERF, ALISON, EVENT_BEAT_SWIMMERF_ALISON, .SeenText, .BeatenText

	text "Einatmen…"
	line "Ausatmen…"

	para "Ist das nicht"
	line "erfrischend?"
	done

.SeenText:
	text "Vor dem Kampf"
	line "musst du tief"
	cont "durchatmen."
	done

.BeatenText:
	text "Blubb… Ich habe"
	line "Meerwasser"
	cont "eingeatmet…"
	done

GenericTrainerSwimmerfStephanie:
	generictrainer SWIMMERF, STEPHANIE, EVENT_BEAT_SWIMMERF_STEPHANIE, .SeenText, .BeatenText

	text "Schall breitet"
	line "sich im Wasser"
	cont "schneller aus als"
	cont "in der Luft."

	para "Toll, oder?"
	done

.SeenText:
	text "Hast du das"
	line "gehört?"
	done

.BeatenText:
	text "Buh!"
	done

TrainerBird_keeperPowell:
	trainer BIRD_KEEPER, POWELL, EVENT_BEAT_BIRD_KEEPER_POWELL, .SeenText, .BeatenText, 0, .Script, TRAINERPAL_DARK_BIRD_KEEPER

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Mein #mon kann"
	line "auch besiegt noch"

	para "Fliegen einsetzen,"
	line "also komme ich"
	cont "trotzdem heim."

	para "Praktisch, was?"
	done

.SeenText:
	text "Ich kann nicht"
	line "schwimmen, also"
	cont "bin ich mit meinem"
	cont "#mon her-"
	cont "geflogen."
	done

.BeatenText:
	text "Oh, nein! Meine"
	line "#mon!"
	done

GenericTrainerCosplayerChloe:
	generictrainer COSPLAYER, CHLOE, EVENT_BEAT_COSPLAYER_CHLOE, .SeenText, .BeatenText

	text "Wenn ich mich so"
	line "anziehe, sagen die"

	para "Leute überall,"
	line "ich sei die"
	cont "Süßeste."
	done

.SeenText:
	text "Gefällt dir mein"
	line "Kostüm? Es ist"
	cont "sehr effektiv!"
	done

.BeatenText:
	text "Na, das war nicht"
	line "sehr effektiv…"
	done

GenericTrainerFisherKiley:
	generictrainer FISHER, KILEY, EVENT_BEAT_FISHER_KILEY, .SeenText, .BeatenText

	text "Du benötigst die"
	line "Profiangel, wenn"

	para "du gute #mon"
	line "fangen möchtest."
	done

.SeenText:
	text "Heh, heute habe"
	line "ich einen Lauf."
	cont "Lass uns kämpfen,"
	cont "Kröte."
	done

.BeatenText:
	text "Uff. Dieses Mal"
	line "hatte ich kein"
	cont "Glück."
	done

GenericTrainerCamperCraig:
	generictrainer CAMPER, CRAIG, EVENT_BEAT_CAMPER_CRAIG, .SeenText, .BeatenText

	text "Das Abenteuer"
	line "wartet vor deinem"
	cont "Zelt,"

	para "also raus mit dir"
	line "und hab Spaß!"
	done

.SeenText:
	text "Nichts geht über"
	line "die freie Natur!"
	done

.BeatenText:
	text "Ich bin ein"
	line "glücklicher"
	cont "Camper."
	done

GenericTrainerLassLayla:
	generictrainer LASS, LAYLA, EVENT_BEAT_LASS_LAYLA, .SeenText, .BeatenText

	text "Wenn du einen"
	line "Wunsch verrätst,"
	cont "geht er nicht in"
	cont "Erfüllung!"
	done

.SeenText:
	text "Wenn du einen"
	line "Wunsch frei hät-"
	cont "test, welcher wäre"
	cont "das?"
	done

.BeatenText:
	text "Aber verrate mir"
	line "deinen Wunsch"
	cont "nicht!"
	done

GenericTrainerCoupleFoxandrae1:
	generictrainer COUPLE, FOXANDRAE1, EVENT_BEAT_COUPLE_FOX_AND_RAE, .SeenText, .BeatenText

	text "Fox: Unser Team-"
	line "work als Paar hat"
	cont "diesmal nicht"
	cont "gereicht."
	done

.SeenText:
	text "Fox: Komm, Rae,"
	line "lass uns kämpfen!"
	done

.BeatenText:
	text "Fox: Du hast Rae"
	line "und mich besiegt…"
	done

GenericTrainerCoupleFoxandrae2:
	generictrainer COUPLE, FOXANDRAE2, EVENT_BEAT_COUPLE_FOX_AND_RAE, .SeenText, .BeatenText

	text "Rae: Wir haben"
	line "verloren, sind"
	cont "aber trotzdem ein"
	cont "glückliches Paar."
	done

.SeenText:
	text "Rae: Hey Fox,"
	line "wollen wir nicht"
	cont "kämpfen?"
	done

.BeatenText:
	text "Rae: Wie konntest"
	line "du Fox und mich"
	cont "besiegen?"
	done

Route32CoastLassText:
	text "Hechel, keuch…"

	para "Endlich habe ich"
	line "es durch diese"
	cont "Höhle geschafft!"

	para "Sie war größer,"
	line "als ich annahm."

	para "Ich war zu er-"
	line "schöpft, um alles"

	para "zu erkunden, also"
	line "habe ich sie"

	para "verlassen."
	done

Route32CoastTrainerTipsText:
	text "Tipps für Trainer"

	para "#mon mit der"
	line "Fähigkeit Mitnahme"

	para "tragen nach einem"
	line "Kampf evtl. ein"
	cont "Item!"
	done

Route32CoastUnionCaveSignText:
	text "Einheitstunnel"
	line "Geradeaus"
	done
