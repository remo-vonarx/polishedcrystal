SaffronCity_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, SaffronCityFlyPoint
	callback MAPCALLBACK_CMDQUEUE, SaffronCitySetUpPaletteSwap

	def_warp_events
	warp_event 26,  3, FIGHTING_DOJO, 1
	warp_event 32,  3, SAFFRON_GYM, 1
	warp_event 27, 11, SAFFRON_MART, 2
	warp_event  9, 29, SAFFRON_POKECENTER_1F, 1
	warp_event 29, 29, MR_PSYCHICS_HOUSE, 1
	warp_event  6,  3, SAFFRON_TRAIN_STATION, 2
	warp_event 19, 21, SILPH_CO_1F, 1
	warp_event  9, 11, COPYCATS_HOUSE_1F, 1
	warp_event 18,  1, ROUTE_5_SAFFRON_CITY_GATE, 3
	warp_event  0, 18, ROUTE_7_SAFFRON_GATE, 3
	warp_event  0, 19, ROUTE_7_SAFFRON_GATE, 4
	warp_event 16, 35, ROUTE_6_SAFFRON_GATE, 1
	warp_event 17, 35, ROUTE_6_SAFFRON_GATE, 2
	warp_event 39, 18, ROUTE_8_SAFFRON_GATE, 1
	warp_event 39, 19, ROUTE_8_SAFFRON_GATE, 2
	warp_event 34, 11, POKEMON_TRAINER_FAN_CLUB, 1
	warp_event  5, 29, SAFFRON_ORRE_SPEECH_HOUSE, 1
	warp_event 13, 29, SAFFRON_BOOK_SPEECH_HOUSE, 1
	warp_event 23, 29, SAFFRON_HITMONTOP_KID_HOUSE, 1
	warp_event 13, 11, SAFFRON_RICH_SPEECH_HOUSE, 1
	warp_event 20, 21, SILPH_CO_1F, 2

	def_coord_events

	def_bg_events
	bg_event 20,  5, BGEVENT_JUMPTEXT, SaffronCitySignText
	bg_event 33,  3, BGEVENT_JUMPTEXT, SaffronGymSignText
	bg_event 27,  3, BGEVENT_JUMPTEXT, FightingDojoSignText
	bg_event 15, 21, BGEVENT_JUMPTEXT, SilphCoSignText
	bg_event 27, 29, BGEVENT_JUMPTEXT, MrPsychicsHouseSignText
	bg_event  8,  5, BGEVENT_JUMPTEXT, SaffronCityMagnetTrainStationSignText
	bg_event 31, 11, BGEVENT_JUMPTEXT, PokemonTrainerFanClubSignText
	bg_event  5, 21, BGEVENT_JUMPTEXT, SaffronTrainerTips1Text
	bg_event 35, 25, BGEVENT_JUMPTEXT, SaffronTrainerTips2Text

	def_object_events
	object_event  7, 14, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, SaffronCityLass1Script, -1
	object_event 18, 30, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, SaffronCityPokefanMScript, -1
	object_event 32,  7, SPRITE_COOL_DUDE, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronCityCooltrainerMText, -1
	object_event 19, 25, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_WANDER, 1, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronCityCooltrainerFText, -1
	object_event 35, 14, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, SaffronCityFisherScript, -1
	object_event 15, 19, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronCityYoungster1Text, -1
	object_event 32, 23, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronCityYoungster2Text, -1
	object_event 14,  6, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronCityLass2Text, -1
	object_event  3, 24, SPRITE_BLACK_BELT, SPRITEMOVEDATA_WALK_UP_DOWN, 4, 0, (1 << MORN) | (1 << EVE), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronCityBlackBelt1Text, -1
	object_event  4, 25, SPRITE_BLACK_BELT, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, (1 << DAY) | (1 << NITE), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronCityBlackBelt2Text, -1
	object_event 22,  8, SPRITE_PSYCHIC, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 4, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronCitySuperNerdText, -1
	object_event 22, 22, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 4, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronCityScientistText, -1
	object_event 11, 22, SPRITE_SILPH_EMPLOYEE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 4, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronCitySilphEmployeeText, -1

SaffronCityFlyPoint:
	setflag ENGINE_FLYPOINT_SAFFRON
	endcallback

SaffronCitySetUpPaletteSwap:
	usepaletteswap .PaletteSwap
	endcallback

.PaletteSwap:
	paletteswap 0, 255, 20, 255, PAL_BG_WATER, OverworldWaterPalettes, MrPsychicsHouseRoofPalettes
	paletteswap 10, 29, 5, 18, PAL_BG_GREEN, OverworldGreenPalettes, SilphCoRoofPalettes
	db -1 ; end

SaffronCityLass1Script:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer SaffronCityLass1Text_ReturnedMachinePart
	jumpthistextfaceplayer

	text "Hier lebt ein"
	line "kleines Mädchen,"

	para "das hervorragend"
	line "Menschen nachahmt."

	para "Sie imitiert sogar"
	line "Menschen, mit"

	para "denen sie sich"
	line "gerade unterhält."

	para "Das ist sehr"
	line "verwirrend."
	done

SaffronCityPokefanMScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer SaffronCityPokefanMText_ReturnedMachinePart
	jumpthistextfaceplayer

	text "Du bist von Johto"
	line "hergekommen?"

	para "Wenn der Magnetzug"
	line "läuft, bist du"
	cont "ganz schnell"
	cont "wieder zu Hause."
	done

SaffronCityFisherScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer SaffronCityFisherText_ReturnedMachinePart
	jumpthistextfaceplayer

	text "Mampf… Mampf…"

	para "Wie ich höre,"
	line "braut sich da"
	cont "etwas im Kraftwerk"
	cont "zusammen."

	para "Mampf… Mampf…"
	done


SaffronCityLass1Text_ReturnedMachinePart:
	text "Die Nachahmerin"
	line "sieht unglücklich"

	para "aus. Sie hat ihre"
	line "Lieblings-#-"
	cont "puppe - Piepi -"
	cont "verloren."
	done


SaffronCityPokefanMText_ReturnedMachinePart:
	text "Du kommst aus"
	line "Johto?"

	para "Mit dem Magnetzug"
	line "bist du ganz"
	cont "schnell wieder"
	cont "zu Hause."
	done

SaffronCityCooltrainerMText:
	text "I went to the Gym,"
	line "raring for battles"
	cont "against trainers…"

	para "It turns out, I"
	line "stumbled into the"

	para "Fighting Dojo"
	line "next door."

	para "Boy, I was pretty"
	line "embarrassed."
	done

SaffronCityCooltrainerFText:
	text "Das ist die Silph"
	line "Co., berühmt für"
	cont "ihre #mon-"
	cont "Artikel."

	para "Team Rocket wollte"
	line "sie wegen dieser"

	para "Waren für sich"
	line "nutzen."
	done


SaffronCityFisherText_ReturnedMachinePart:
	text "Mampf… Mampf…"

	para "Wie ich höre,"
	line "braute sich da"
	cont "etwas im Kraftwerk"
	cont "zusammen."

	para "Mampf… Mampf…"
	line "Aah, ich bin satt!"
	done

SaffronCityYoungster1Text:
	text "Ich finde es"
	line "unheimlich, wenn"

	para "ich zum ersten Mal"
	line "einen engen Gang"
	cont "betrete."
	done

SaffronCityYoungster2Text:
	text "In Vertania City"
	line "gibt es ein Haus"

	para "für Trainer. Dort"
	line "treffen sich"

	para "Trainer der ganzen"
	line "Welt."
	done

SaffronCityLass2Text:
	text "Über unsere Stadt"
	line "wurde mal im Radio"
	cont "berichtet."

	para "Es ist schön, dass"
	line "für deine Stadt"

	para "geworben wird,"
	line "aber es ist auch"
	cont "ein bisschen"
	cont "peinlich."
	done

SaffronCityBlackBelt1Text:
	text "Every morning when"
	line "I wake up I run"

	para "two laps around"
	line "the city."

	para "It's a great way"
	line "to start the day!"
	done

SaffronCityBlackBelt2Text:
	text "If I was an item,"
	line "I'd be X Attack."

	para "I'm just brimming"
	line "with power, and"

	para "the X makes it"
	line "sound cool."
	done

SaffronCitySuperNerdText:
	text "There was a time"
	line "when Psychic-type"

	para "#mon were be-"
	line "lieved to be the"

	para "strongest, and Bug"
	line "types the weakest."

	para "The irony is, Bug"
	line "is super effective"
	cont "against Psychic!"
	done

SaffronCityScientistText:
	text "The original Silph"
	line "Scope had some"
	cont "bugs, so we've been"

	para "working tirelessly"
	line "on its successor--"
	cont "the SilphScope2!"
	done

SaffronCitySilphEmployeeText:
	text "Silph is named"
	line "after a mythical"
	cont "spirit of the air."

	para "What that has to"
	line "do with the com-"

	para "pany's business,"
	line "I have no idea."
	done

SaffronCitySignText:
	text "Saffronia City"

	para "Golden Schimmernde"
	line "Stadt des Handels"
	done

SaffronGymSignText:
	text "PKMN-Arena von"
	line "Saffronia City"
	cont "Leitung: Sabrina"

	para "Die Meisterin der"
	line "Psycho-#mon!"
	done

FightingDojoSignText:
	text "Willkommen!"
	line "Karate Dojo"
	done

SilphCoSignText:
	text "Silph Co."
	line "Bürogebäude"
	done

MrPsychicsHouseSignText:
	text "Haus von"
	line "Mr. Psycho"
	done

SaffronCityMagnetTrainStationSignText:
	text "Saffronia City"
	line "Magnetzug-"
	cont "Bahnhof"
	done

PokemonTrainerFanClubSignText:
	text "#mon Trainer-"
	line "Fanclub"

	para "Viele Trainer"
	line "haben hier ihre"
	cont "Namen hinge-"
	cont "kritzelt…"
	done

SaffronTrainerTips1Text:
	text "Tipps für Trainer"

	para "Das neue"
	line "SilphScope2 ent-"
	cont "larvt selbst die"

	para "am besten getarn-"
	line "ten #mon!"
	done

SaffronTrainerTips2Text:
	text "Tipps für Trainer"

	para "Setze Flottbälle"
	line "früh im Kampf ein,"
	cont "später Timerbälle."

	para "Sie kosten mehr"
	line "als #bälle,"

	para "sind aber"
	line "praktischer."
	done
