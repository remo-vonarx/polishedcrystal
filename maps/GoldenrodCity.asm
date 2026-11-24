GoldenrodCity_MapScriptHeader:
	def_scene_scripts
	scene_script GoldenrodCityStepDownScene, SCENE_GOLDENRODCITY_STEP_DOWN
	scene_const SCENE_GOLDENRODCITY_NOOP

	def_callbacks
	callback MAPCALLBACK_NEWMAP, GoldenrodCityFlyPoint
	callback MAPCALLBACK_OBJECTS, GoldenrodCityMoveTutor
	callback MAPCALLBACK_CMDQUEUE, GoldenrodCitySetUpPaletteSwap

	def_warp_events
	warp_event 28,  7, GOLDENROD_GYM, 1
	warp_event 33, 29, GOLDENROD_BIKE_SHOP, 1
	warp_event 35, 15, GOLDENROD_HAPPINESS_RATER, 1
	warp_event  8, 25, GOLDENROD_BILLS_HOUSE, 1
	warp_event 13, 13, GOLDENROD_MAGNET_TRAIN_STATION, 2
	warp_event 33,  5, GOLDENROD_FLOWER_SHOP, 1
	warp_event 37,  9, GOLDENROD_PP_SPEECH_HOUSE, 1
	warp_event 19,  7, GOLDENROD_NAME_RATER, 1
	warp_event 28, 27, GOLDENROD_DEPT_STORE_1F, 1
	warp_event 18, 21, GOLDENROD_GAME_CORNER, 1
	warp_event  9, 15, RADIO_TOWER_1F, 1 ; hole
	warp_event 23,  1, ROUTE_35_GOLDENROD_GATE, 3
	warp_event 13,  5, GOLDENROD_UNDERGROUND_ENTRANCES, 5
	warp_event 13, 29, GOLDENROD_UNDERGROUND_ENTRANCES, 2
	warp_event 18, 27, GOLDENROD_POKECOM_CENTER_1F, 2
	warp_event  4, 16, GOLDENROD_HARBOR_GATE, 3
	warp_event  4, 17, GOLDENROD_HARBOR_GATE, 4
	warp_event 30, 15, GOLDENROD_MUSEUM_1F, 1
	warp_event 37, 19, GOLDENROD_NET_BALL_HOUSE, 1
	warp_event 33, 23, GOLDENROD_BAND_HOUSE, 1
	warp_event 11, 21, GOLDENROD_HONEY_HOUSE, 1
	warp_event 39, 27, GOLDENROD_UNDERGROUND_ENTRANCES, 8
	warp_event 19, 21, GOLDENROD_GAME_CORNER, 2
	warp_event 29, 27, GOLDENROD_DEPT_STORE_1F, 2
	warp_event 31, 15, GOLDENROD_MUSEUM_1F, 2

	def_coord_events
	coord_event  9, 15, SCENE_GOLDENRODCITY_NOOP, GoldenrodCityPanUpScript

	def_bg_events
	bg_event 15, 14, BGEVENT_JUMPTEXT, GoldenrodCityStationSignText
	bg_event  7, 15, BGEVENT_JUMPTEXT, GoldenrodCityRadioTowerSignText
	bg_event 30, 27, BGEVENT_JUMPTEXT, GoldenrodDeptStoreSignText
	bg_event 29,  7, BGEVENT_JUMPTEXT, GoldenrodGymSignText
	bg_event 26, 18, BGEVENT_JUMPTEXT, GoldenrodCitySignText
	bg_event 32, 30, BGEVENT_JUMPTEXT, GoldenrodCityBikeShopSignText
	bg_event 20, 22, BGEVENT_JUMPTEXT, GoldenrodCityGameCornerSignText
	bg_event 17,  7, BGEVENT_JUMPTEXT, GoldenrodCityNameRaterSignText
	bg_event 12,  6, BGEVENT_JUMPTEXT, GoldenrodCityUndergroundSignText
	bg_event 14, 30, BGEVENT_JUMPTEXT, GoldenrodCityUndergroundSignText
	bg_event 40, 28, BGEVENT_JUMPTEXT, GoldenrodCityUndergroundSignText
	bg_event 20, 27, BGEVENT_JUMPTEXT, PokeComCenterSignText
	bg_event 35,  6, BGEVENT_JUMPTEXT, GoldenrodCityFlowerShopSignText
	bg_event 27, 15, BGEVENT_JUMPTEXT, GoldenrodMuseumSignText

	def_object_events
	object_event 16, 22, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, MoveTutor, EVENT_GOLDENROD_CITY_MOVE_TUTOR
	object_event 28,  8, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodCityGymLassText, EVENT_GOLDENROD_GYM_WHITNEY
	object_event 11, 18, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodCityPokefanMText, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 34, 17, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodCityYoungster1Text, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 16, 16, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodCityCooltrainerF1Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 25, 25, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WANDER, 2, 1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodCityCooltrainerF2Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 25, 17, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodCityYoungster2Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 20, 10, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodCityLassText, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 15, 27, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodCityGrampsText, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event  8, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocketScoutScript, EVENT_GOLDENROD_CITY_ROCKET_SCOUT
	object_event 29, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodCityRocket1Text, EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	object_event 29, 17, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodCityRocket4Text, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 12, 15, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodCityRocket2Text, EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	object_event 20, 23, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodCityRocket3Text, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 33,  7, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodCityRocket5Text, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 35, 10, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodCityRocket6Text, EVENT_RADIO_TOWER_ROCKET_TAKEOVER

	object_const_def
	const GOLDENRODCITY_POKEFAN_M2

GoldenrodCityFlyPoint:
	setflag ENGINE_FLYPOINT_GOLDENROD
	endcallback

GoldenrodCityMoveTutor:
; Move Tutor
	checkevent EVENT_BEAT_WHITNEY
	iffalsefwd .MoveTutorDisappear
	checkkeyitem COIN_CASE
	iffalsefwd .MoveTutorDisappear
	appear GOLDENRODCITY_POKEFAN_M2
	endcallback

.MoveTutorDisappear
	disappear GOLDENRODCITY_POKEFAN_M2
	endcallback

GoldenrodCitySetUpPaletteSwap:
	usepaletteswap .PaletteSwap
	endcallback

.PaletteSwap:
	paletteswap 22, 39, 7, 19, PAL_BG_WATER, OverworldWaterPalettes, GoldenrodMuseumRoofPalettes
	; The unswapped NULL case will keep whichever palette was chosen by the previous case
	paletteswap 26, 41, 21, 33, PAL_BG_WATER, NULL, GoldenrodBikeShopRoofPalettes
	paletteswap 8, 27, 12, 28, PAL_BG_GREEN, OverworldGreenPalettes, GameCornerExteriorPalettes
	db -1 ; end

GoldenrodCityStepDownScene:
	sdefer .Script
	end

.Script:
	readvar VAR_XCOORD
	ifnotequal 9, .Done
	readvar VAR_YCOORD
	ifnotequal 15, .Done
	applyonemovement PLAYER, step_down
.Done
	setscene SCENE_GOLDENRODCITY_NOOP
	end

GoldenrodCityPanUpScript:
	playsound SFX_EXIT_BUILDING
	applyonemovement PLAYER, hide_object
	waitsfx
	applymovement PLAYER, GoldenrodCityPanUpMovementData
	disappear PLAYER
	pause 10
	special Special_FadeOutMusic
	special FadeOutPalettes
	pause 15
	setscene SCENE_GOLDENRODCITY_STEP_DOWN
	warpfacing UP, RADIO_TOWER_1F, 2, 7
	end

MoveTutor:
	faceplayer
	opentext
	writetext GoldenrodCityMoveTutorAskTeachAMoveText
	yesorno
	iffalse_jumpopenedtext GoldenrodCityMoveTutorAwwButTheyreAmazingText
	special Special_DisplayCoinCaseBalance
	writetext GoldenrodCityMoveTutorAsk4000CoinsOkayText
	yesorno
	iffalse_jumpopenedtext GoldenrodCityMoveTutorHmTooBadText
	checkcoins 200
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	writetext GoldenrodCityMoveTutorWhichMoveShouldITeachText
	loadmenu .MoveMenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, .FirePunch
	ifequalfwd $2, .ThunderPunch
	ifequalfwd $3, .IcePunch
	jumpopenedtext GoldenrodCityMoveTutorBButText

.FirePunch:
	setval FIRE_PUNCH
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
	jumpopenedtext GoldenrodCityMoveTutorBButText

.ThunderPunch:
	setval THUNDERPUNCH
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
	jumpopenedtext GoldenrodCityMoveTutorBButText

.IcePunch:
	setval ICE_PUNCH
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
	jumpopenedtext GoldenrodCityMoveTutorBButText

.MoveMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 2, 15, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Fire Punch@"
	db "ThunderPunch@"
	db "Ice Punch@"
	db "Cancel@"

.TeachMove:
	writetext GoldenrodCityMoveTutorIfYouUnderstandYouveMadeItText
	promptbutton
	takecoins 200
	waitsfx
	playsound SFX_TRANSACTION
	special Special_DisplayCoinCaseBalance
	jumpthisopenedtext

	text "Wahahah!"
	line "Good day, kid!"
	done

.NotEnoughMoney:
	jumpthisopenedtext

	text "…Du hast nicht"
	line "genügend Münzen"
	cont "dabei…"
	done

GoldenrodCityCooltrainerF1Script:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue_jumptextfaceplayer GoldenrodCityCooltrainerF1Text_ClearedRadioTower
	jumpthistextfaceplayer

	text "Hat sich dieser"
	line "Mann in Schwarz"

	para "als Mitglied von"
	line "Team Rocket ver-"
	cont "kleidet? Wie däm-"
	cont "lich!"
	done

GoldenrodCityCooltrainerF2Script:
	checkflag ENGINE_RADIO_CARD
	iffalse_jumptextfaceplayer GoldenrodCityCooltrainerF2Text
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse_jumptextfaceplayer GoldenrodCityCooltrainerFOlivineText
	jumpthistextfaceplayer

	text "I came here on the"
	line "Magnet Train."

	para "Time to do some"
	line "shopping!"
	done

GoldenrodCityYoungster2Script:
	faceplayer
	opentext
	checktime (1 << EVE) | (1 << NITE)
	iftrue_jumpopenedtext GoldenrodCityYoungster2Text
	jumpthisopenedtext

	text "Have you been to"
	line "the Museum?"

	para "It's full of cool"
	line "exhibits!"
	done

GoldenrodCityRocketScoutScript:
	checkevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	iftruefwd .RocketScout
	jumptextfaceplayer GoldenrodCityRocket4Text

.RocketScout:
	opentext
	writetext GoldenrodCityRocketScoutText1
	promptbutton
	faceplayer
	writetext GoldenrodCityRocketScoutText2
	waitbutton
	closetext
	turnobject LAST_TALKED, UP
	end

GoldenrodCityPanUpMovementData:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

GoldenrodCityPokefanMText:
	text "They built the new"
	line "Radio Tower to"

	para "replace the old,"
	line "creaky one."

	para "Now it transmits"
	line "every #gear"

	para "broadcast in"
	line "Johto."
	done

GoldenrodCityYoungster1Text:
	text "Es soll einen neu-"
	line "en Fahrradladen"

	para "geben, aber ich"
	line "kann ihn nirgends"
	cont "finden."
	done


GoldenrodCityCooltrainerF1Text_ClearedRadioTower:
	text "Gehörte dieser"
	line "Mann in Schwarz"

	para "wirklich zu Team"
	line "Rocket? Ich kann"

	para "es nicht glauben!"
	done

GoldenrodCityCooltrainerF2Text:
	text "The Radio Tower in"
	line "Goldenrod City is"
	cont "a landmark."

	para "They're running a"
	line "promotional cam-"
	cont "paign right now."

	para "They'll modify"
	line "your #gear,"

	para "so it can also"
	line "serve as a radio."
	done

GoldenrodCityCooltrainerFOlivineText:
	text "I came here on"
	line "the S.S.Aqua."

	para "It's slower than"
	line "the Magnet Train,"
	cont "but more scenic."
	done



GoldenrodCityYoungster2Text:
	text "E-he-he-he…"

	para "Ich habe Ärger be-"
	line "kommen, weil ich"

	para "im Keller des"
	line "KAUFHAUSes ge-"
	cont "spielt habe."
	done

GoldenrodCityLassText:
	text "The man at that"
	line "house rates your"
	cont "#mon names."

	para "He can help rename"
	line "your #mon too."

	para "He liked all of"
	line "my nicknames, even"
	cont "the silly ones!"
	done

GoldenrodCityGrampsText:
	text "Wow! Das ist eine"
	line "große Stadt. Ich"

	para "finde mich noch"
	line "gar nicht zurecht."
	done

GoldenrodCityRocketScoutText1:
	text "Das ist also der"
	line "Radioturm…"
	done

GoldenrodCityRocketScoutText2:
	text "Was willst du, du"
	line "Nervensäge? Hau"
	cont "ab!"
	done

GoldenrodCityRocket1Text:
	text "Aus dem Weg! Ver-"
	line "schwinde!"
	done

GoldenrodCityRocket2Text:
	text "Den Radioturm ein-"
	line "nehmen…"

	para "Was? Das geht dich"
	line "nichts an!"
	done

GoldenrodCityRocket3Text:
	text "#mon? Sie sind"
	line "nicht mehr als"

	para "Werkzeuge zum"
	line "Geldscheffeln!"
	done

GoldenrodCityRocket4Text:
	text "Bald wird sich un-"
	line "ser Traum er-"
	cont "füllen…"

	para "So lange hat es"
	line "schon gedauert…"
	done

GoldenrodCityRocket5Text:
	text "Hey, Grünschnabel!"
	line "Du hast hier"
	cont "nichts zu suchen!"
	done

GoldenrodCityRocket6Text:
	text "Komm und werde"
	line "Zeuge der Macht"
	cont "von Team Rocket!"
	done

GoldenrodCityGymLassText:
	text "Whitney isn't here"
	line "right now."

	para "She bolted out of"
	line "here and shouted,"

	para "“I have got to get"
	line "a Radio Card!”"
	done

GoldenrodCityStationSignText:
	text "Dukatia City"
	line "Bahnhof"
	done

GoldenrodCityRadioTowerSignText:
	text "Dukatia City"
	line "Radioturm"
	done

GoldenrodDeptStoreSignText:
	text "Große Auswahl an"
	line "#mon-Artikeln!"

	para "Dukatia City"
	line "Kaufhaus"
	done

GoldenrodGymSignText:
	text "PKMN-Arena von"
	line "Dukatia City"
	cont "Leitung: Bianka"

	para "Ein unglaublich"
	line "hübsches Mädchen!"
	done

GoldenrodCitySignText:
	text "Dukatia City"

	para "Die festliche"
	line "Stadt mit opulen-"
	cont "tem Charme"
	done

GoldenrodCityBikeShopSignText:
	text "The World is a"
	line "Cycle Path!"

	para "Miracle Cycle"
	done

GoldenrodCityGameCornerSignText:
	text "Dein Spielplatz!"

	para "Dukatia City"
	line "Spielhalle"
	done

GoldenrodCityNameRaterSignText:
	text "Namen-Bewerter"

	para "Möchtest du deine"
	line "Spitznamen bewer-"
	cont "ten lassen?"
	done

GoldenrodCityUndergroundSignText:
	text "Underground"
	line "Entrance"
	done

PokeComCenterSignText:
	text "Connect the World!"
	line "#Com Center"
	done

GoldenrodCityFlowerShopSignText:
	text "Blühender"
	line "Blumenladen"
	done

GoldenrodMuseumSignText:
	text "Goldenrod Museum"
	line "Grand Opening!"

	para "Explore the"
	line "history of Johto!"
	done

GoldenrodCityMoveTutorAskTeachAMoveText:
	text "Wenn du möchtest,"
	line "kann ich deinen"

	para "#mon tolle"
	line "Attacken"
	cont "beibringen."

	para "Soll ich das"
	line "machen?"
	done

GoldenrodCityMoveTutorAsk4000CoinsOkayText:
	text "It will cost you"
	line "200 coins. OK?"
	done

GoldenrodCityMoveTutorAwwButTheyreAmazingText:
	text "Uah… aber sie sind"
	line "wirklich toll…"
	done

GoldenrodCityMoveTutorWhichMoveShouldITeachText:
	text "Wahahah! Das wirst"
	line "du nicht bereuen!"

	para "Welche Attacke"
	line "erlernen?"
	done

GoldenrodCityMoveTutorHmTooBadText:
	text "Hm, Mist. Ich muss"
	line "noch Geld von zu"
	cont "Hause holen…"
	done

GoldenrodCityMoveTutorIfYouUnderstandYouveMadeItText:
	text "Wenn du verstehst,"
	line "was an dieser"

	para "Attacke so toll"
	line "ist, dann darfst"

	para "du dich einen"
	line "Trainer nennen."
	done


GoldenrodCityMoveTutorBButText:
	text "A-aber…"
	done
