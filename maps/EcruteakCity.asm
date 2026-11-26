EcruteakCity_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, EcruteakCityFlyPoint

	def_warp_events
	warp_event 35, 22, ROUTE_42_ECRUTEAK_GATE, 1
	warp_event 35, 23, ROUTE_42_ECRUTEAK_GATE, 2
	warp_event 23, 11, ECRUTEAK_HOUSE, 1
	warp_event 17,  9, ECRUTEAK_SHRINE_OUTSIDE, 3
	warp_event 18,  9, ECRUTEAK_SHRINE_OUTSIDE, 4
	warp_event 23, 27, ECRUTEAK_POKECENTER_1F, 1
	warp_event  5, 21, ECRUTEAK_LUGIA_SPEECH_HOUSE, 1
	warp_event 23, 21, DANCE_THEATRE, 1
	warp_event 29, 21, ECRUTEAK_MART, 2
	warp_event  6, 27, ECRUTEAK_GYM, 1
	warp_event 13, 27, ECRUTEAK_ITEMFINDER_HOUSE, 1
	warp_event  5, 16, VALERIES_HOUSE, 1
	warp_event  5,  5, BURNED_TOWER_1F, 1
	warp_event  0, 22, ROUTE_38_ECRUTEAK_GATE, 3
	warp_event  0, 23, ROUTE_38_ECRUTEAK_GATE, 4
	warp_event 29, 27, ECRUTEAK_CHERISH_BALL_HOUSE, 1
	warp_event 13, 16, ECRUTEAK_DESTINY_KNOT_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 15, 21, BGEVENT_JUMPTEXT, EcruteakCitySign
	bg_event  7, 27, BGEVENT_JUMPTEXT, EcruteakGymSign
	bg_event 21, 21, BGEVENT_JUMPTEXT, EcruteakDanceTheaterSign
	bg_event  7,  9, BGEVENT_JUMPTEXT, BurnedTowerSign
	bg_event 15, 11, BGEVENT_JUMPTEXT, EcruteakShrineSign
	bg_event 21, 11, BGEVENT_JUMPTEXT, EcruteakBarrierStationSign
	bg_event  9, 15, BGEVENT_JUMPTEXT, EcruteakCityAdvancedTips
	bg_event 25, 14, BGEVENT_ITEM + HYPER_POTION, EVENT_ECRUTEAK_CITY_HIDDEN_HYPER_POTION
	bg_event 33, 16, BGEVENT_ITEM + RARE_CANDY, EVENT_ECRUTEAK_CITY_HIDDEN_RARE_CANDY
	bg_event  1, 21, BGEVENT_ITEM + ULTRA_BALL, EVENT_ECRUTEAK_CITY_HIDDEN_ULTRA_BALL
	bg_event  6,  6, BGEVENT_ITEM + ETHER, EVENT_ECRUTEAK_CITY_HIDDEN_ETHER

	def_object_events
	object_event 20, 15, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakCityGramps1Text, -1
	object_event 20, 21, SPRITE_GRAMPS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakCityGramps2Text, -1
	object_event 20, 26, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakCityLass1Text, -1
	object_event  8, 10, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakCityLass2Script, -1
	object_event  9, 22, SPRITE_FISHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakCityFisherScript, -1
	object_event 11, 16, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakCityYoungsterText, -1
	object_event  3, 10, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakCityGramps3Text, EVENT_ECRUTEAK_CITY_GRAMPS
	object_event 11, 11, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakCityHexManiacText, -1
	object_event 11, 11, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, (1 << MORN) | (1 << DAY), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakCitySightseerMText, -1
	pokemon_event 12, 11, SMEARGLE, SPRITEMOVEDATA_POKEMON, (1 << MORN) | (1 << DAY), PAL_MON_BROWN, EcruteakCitySmeargleText, -1
	object_event 16,  5, SPRITE_BIG_SNORLAX, SPRITEMOVEDATA_ARCH_TREE_LEFT, 0, 0, -1, PAL_NPC_COPY_BG_GREEN, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 19,  5, SPRITE_BIG_SNORLAX, SPRITEMOVEDATA_ARCH_TREE_RIGHT, 0, 0, -1, PAL_NPC_COPY_BG_GREEN, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 16,  9, SPRITE_BIG_SNORLAX, SPRITEMOVEDATA_ARCH_TREE_LEFT, 0, 0, -1, PAL_NPC_COPY_BG_GREEN, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 19,  9, SPRITE_BIG_SNORLAX, SPRITEMOVEDATA_ARCH_TREE_RIGHT, 0, 0, -1, PAL_NPC_COPY_BG_GREEN, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 23, 18, SPRITE_PAGODA, SPRITEMOVEDATA_PAGODA_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 24, 18, SPRITE_PAGODA, SPRITEMOVEDATA_PAGODA_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, end, NULL, -1

EcruteakCityFlyPoint:
	setflag ENGINE_FLYPOINT_ECRUTEAK
	endcallback

EcruteakCityLass2Script:
	checkevent EVENT_RELEASED_THE_BEASTS
	iftrue_jumptextfaceplayer EcruteakCityLass2Text_ReleasedBeasts
	jumpthistextfaceplayer

	text "Der Turm, der"
	line "früher hier stand…"

	para "Meine Oma sagte"
	line "mir, dass er"
	cont "früher höher war."
	done

EcruteakCityFisherScript:
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue_jumptextfaceplayer EcruteakCityFisherText_JasmineReturned
	jumpthistextfaceplayer

	text "Es kursiert ein"
	line "Gerücht über den"
	cont "Leuchtturm in Oli-"
	cont "viana City."

	para "Das #mon, das"
	line "als Leuchtfeuer"

	para "dient, wurde"
	line "krank. Sieht so"

	para "aus, als wären sie"
	line "in Schwierig-"
	cont "keiten."
	done

EcruteakCityGramps1Text:
	text "Es gab zwei Türme"
	line "in Teak City. Ei-"
	cont "nen im Osten, ei-"
	cont "nen im Westen."
	done

EcruteakCityGramps2Text:
	text "Na, Kröte?"
	line "Hast du gelernt zu"

	para "tanzen wie die"
	line "Kimono-Girls?"

	para "Ich habe gehört,"
	line "dass dir ein ei-"
	cont "genartiger Mann"
	cont "etwas Nettes geben"

	para "wird, wenn du zu"
	line "ihrem Tanztheater"
	cont "gehst."
	done

EcruteakCityLass1Text:
	text "Ich lasse meine"
	line "#mon im Schrein"

	para "segnen. Kommst"
	line "du mit?"
	done

EcruteakCityHexManiacText:
	text "Die Geister von"
	line "#mon gehen hier"
	cont "um…"
	done

EcruteakCitySightseerMText:
	text "Teak City hat so"
	line "eine unglaubliche"
	cont "Geschichte."

	para "Farbeagle und ich"
	line "sind hergereist,"
	cont "um sie zu malen."
	done

EcruteakCitySmeargleText:
	text "Farbeagle: Smeer!"
	done


EcruteakCityLass2Text_ReleasedBeasts:
	text "Drei große #mon"
	line "sind in verschie-"
	cont "dene Richtungen"
	cont "davongelaufen! Was"
	cont "waren das für"
	cont "welche?"
	done


EcruteakCityFisherText_JasmineReturned:
	text "Das #mon im"
	line "Leuchtturm von"
	cont "Oliviana City wur-"
	cont "de geheilt."

	para "Jetzt können die"
	line "Schiffe wieder ge-"
	cont "fahrlos nachts in"
	cont "See stechen."
	done

EcruteakCityYoungsterText:
	text "Ich hörte, dass"
	line "#mon am See des"

	para "Zorns Unruhe stif-"
	line "ten. Das würde ich"
	cont "gerne sehen."
	done

EcruteakCityGramps3Text:
	text "Vor langer Zeit…"

	para "Dieser Turm ist"
	line "abgebrannt. Drei"

	para "namenlose #mon"
	line "sind dabei"
	cont "umgekommen."

	para "Ein regenbogen-"
	line "farbenes #mon"

	para "kam herab und"
	line "hauchte ihnen wie-"
	cont "der Leben ein…"

	para "Diese Legende wird"
	line "von jedem Leiter"

	para "der PKMN-Arena von"
	line "Teak City an den"

	para "nächsten"
	line "weitergegeben."

	para "Ich?"

	para "Damals war ich"
	line "ein Trainer."
	cont "Hohoho!"
	done

EcruteakCitySign:
	text "Teak City"
	line "Eine historische"

	para "Stadt, wo Vergan-"
	line "genheit und Gegen-"
	cont "wart aufeinander-"
	cont "treffen"
	done

EcruteakGymSign:
	text "PKMN-Arena von"
	line "Teak City"
	cont "Leitung: Jens"

	para "Der mystische Se-"
	line "her der Zukunft"
	done

EcruteakCityAdvancedTips:
	text "Tipps für Profis!"

	para "Manche #mon,"
	line "denen du begeg-"

	para "nest, haben eine"
	line "seltene Fähigkeit,"

	para "auch versteckte"
	line "Fähigkeit genannt!"

	para "Auch ein ge-"
	line "schlüpftes #mon"

	para "hat eine kleine"
	line "Chance auf eine"
	cont "versteckte"
	cont "Fähigkeit."
	done

EcruteakDanceTheaterSign:
	text "Tanztheater von"
	line "Teak City"
	done

BurnedTowerSign:
	text "Turmruine"

	para "Er wurde durch ein"
	line "mysteriöses Feuer"
	cont "zerstört."

	para "Bitte nicht betre-"
	line "ten!"
	done

EcruteakShrineSign:
	text "Teak-Schrein"

	para "“Das Leben ist wie"
	line "eine Flamme im"
	cont "Wind.”"
	done

EcruteakBarrierStationSign:
	text "Sperrposten zum"
	line "Glockenturm"

	para "Zutritt für Un-"
	line "würdige verboten"
	done
