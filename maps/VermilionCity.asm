VermilionCity_MapScriptHeader:
	def_scene_scripts
	scene_script LawrenceIntroScript, SCENE_VERMILIONCITY_LAWRENCE_INTRO
	scene_const SCENE_VERMILIONCITY_NOOP

	def_callbacks
	callback MAPCALLBACK_OBJECTS, VermilionCitySetupLawrenceCallback
	callback MAPCALLBACK_TILES, VermilionCitySetupBattleFactoryCallback
	callback MAPCALLBACK_CMDQUEUE, VermilionCitySetUpPaletteSwap

	def_warp_events
	warp_event  5,  3, VERMILION_HOUSE_FISHING_SPEECH_HOUSE, 1
	warp_event  9,  3, VERMILION_POKECENTER_1F, 1
	warp_event  7, 13, POKEMON_FAN_CLUB, 1
	warp_event 13, 13, VERMILION_MAGNET_TRAIN_SPEECH_HOUSE, 1
	warp_event 21, 13, VERMILION_MART, 2
	warp_event 21, 17, VERMILION_HOUSE_DIGLETTS_CAVE_SPEECH_HOUSE, 1
	warp_event  8, 19, VERMILION_GYM, 1
	warp_event 18, 31, VERMILION_PORT, 1
	warp_event 19, 31, VERMILION_PORT, 3
	warp_event 38, 13, DIGLETTS_CAVE, 1
	warp_event 28, 31, SEAGALLOP_FERRY_VERMILION_GATE, 1
	warp_event 29, 31, SEAGALLOP_FERRY_VERMILION_GATE, 1
	warp_event 13,  3, VERMILION_POLLUTION_SPEECH_HOUSE, 1
	warp_event 19,  3, VERMILION_S_S_ANNE_SPEECH_HOUSE, 1
	warp_event 28,  7, BATTLE_FACTORY_1F, 1

	def_coord_events

	def_bg_events
	bg_event 15,  6, BGEVENT_JUMPTEXT, VermilionCitySignText
	bg_event  9, 19, BGEVENT_JUMPTEXT, VermilionGymSignText
	bg_event  5, 13, BGEVENT_JUMPTEXT, PokemonFanClubSignText
	bg_event 35, 13, BGEVENT_JUMPTEXT, VermilionCityDiglettsCaveSignText
	bg_event 27, 15, BGEVENT_JUMPTEXT, VermilionCityPortSignText
	bg_event 27, 24, BGEVENT_JUMPTEXT, VermilionCityPierSignText
	bg_event 22,  7, BGEVENT_JUMPTEXT, VermilionCityBattleFactorySignText
	bg_event 12, 22, BGEVENT_JUMPTEXT, VermilionCityAdvancedTipsSignText
	bg_event 12, 19, BGEVENT_ITEM + FULL_HEAL, EVENT_VERMILION_CITY_HIDDEN_FULL_HEAL
	bg_event 32,  4, BGEVENT_ITEM + MAX_ETHER, EVENT_VERMILION_CITY_HIDDEN_MAX_ETHER

	def_object_events
	object_event 37, 14, SPRITE_BIG_SNORLAX, SPRITEMOVEDATA_SNORLAX, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionSnorlax, EVENT_VERMILION_CITY_SNORLAX
	object_event 18, 27, SPRITE_LAWRENCE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_VERMILION_CITY
	object_event 18, 10, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionCityTeacherText, -1
	object_event 20,  6, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionMachokeOwnerScript, -1
	pokemon_event 21,  6, MACHOKE, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_GRAY, VermilionMachokeText, -1
	object_event 16, 16, SPRITE_ROCKER, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionCitySuperNerdText, -1
	object_event 31, 10, SPRITE_POKEMANIAC, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VermilionCitySuperNerd2Script, -1
	object_event 11,  6, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 3, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionCitySailorText, -1
	object_event  5, 22, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, VermilionGymBadgeGuy, -1
	object_event 28,  8, SPRITE_OFFICER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionCityOfficerFText, EVENT_RESTORED_POWER_TO_KANTO
	object_event 30,  1, SPRITE_PEARL, SPRITEMOVEDATA_ARCH_TREE_LEFT, 0, 0, -1, PAL_NPC_COPY_BG_GREEN, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 26,  1, SPRITE_PEARL, SPRITEMOVEDATA_ARCH_TREE_RIGHT, 0, 0, -1, PAL_NPC_COPY_BG_GREEN, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 27, 32, SPRITE_BIG_LAPRAS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_COPY_BG_WATER, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 30, 32, SPRITE_BIG_LAPRAS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_COPY_BG_WATER, OBJECTTYPE_COMMAND, end, NULL, -1

	object_const_def
	const VERMILIONCITY_BIG_SNORLAX
	const VERMILIONCITY_LAWRENCE

VermilionCitySetupLawrenceCallback:
	checkscene
	iftruefwd .done
	readvar VAR_XCOORD
	ifequalfwd 18, .done
	disappear VERMILIONCITY_LAWRENCE
	moveobject VERMILIONCITY_LAWRENCE, 19, 27
	appear VERMILIONCITY_LAWRENCE
.done
	endcallback

VermilionCitySetupBattleFactoryCallback:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftruefwd .done
	changeblock 28, 6, $f7
.done
	endcallback

VermilionCitySetUpPaletteSwap:
	usepaletteswap .PaletteSwap
	endcallback

.PaletteSwap:
	paletteswap 0, 15, 5, 17, PAL_BG_GREEN, PAL_BG_GREEN, PokemonFanClubRoofPalettes
	paletteswap 21, 36, 27, 39, PAL_BG_ROOF, GROUP_VERMILION_CITY, SeagallopFerryRoofPalettes
	db -1 ; end

LawrenceIntroScript:
	turnobject PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	showtext LawrenceOverheardText
	applymovement VERMILIONCITY_LAWRENCE, LawrenceApproachMovementData
	playsound SFX_TACKLE
	applymovement VERMILIONCITY_LAWRENCE, LawrenceBumpMovementData
	showemote EMOTE_SHOCK, VERMILIONCITY_LAWRENCE, 15
	pause 15
	readvar VAR_XCOORD
	ifequalfwd 18, .left
	applymovement VERMILIONCITY_LAWRENCE, LawrenceWalkAroundRightMovementData
	turnobject PLAYER, LEFT
	sjumpfwd .continue

.left
	applymovement VERMILIONCITY_LAWRENCE, LawrenceWalkAroundLeftMovementData
	turnobject PLAYER, RIGHT
.continue
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtext LawrenceIntroText
	applymovement VERMILIONCITY_LAWRENCE, LawrenceWalkAwayMovementData
	disappear VERMILIONCITY_LAWRENCE
	setscene SCENE_VERMILIONCITY_NOOP
	setevent EVENT_TELEPORT_GUY
	setflag ENGINE_FLYPOINT_VERMILION
	special RestartMapMusic
	end

LawrenceWalkAwayMovementData:
	step_down
	step_down
LawrenceApproachMovementData:
	step_down
	step_down
	step_down
	step_end

LawrenceBumpMovementData:
	fix_facing
	run_step_up
	remove_fixed_facing
	step_sleep_8
	step_sleep_8
	step_end

LawrenceWalkAroundLeftMovementData:
	step_right
	step_down
	step_down
	turn_head_left
	step_end

LawrenceWalkAroundRightMovementData:
	step_left
	step_down
	step_down
	turn_head_right
	step_end

VermilionSnorlax:
	opentext
	special SpecialSnorlaxAwake
	iftruefwd .Awake
	jumpthisopenedtext

	text "Relaxo schläft"
	line "friedlich…"
	done

.Awake:
	writetext VermilionCityRadioNearSnorlaxText
	pause 15
	cry SNORLAX
	closetext
	loadvar VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
	loadwildmon SNORLAX, 60
	startbattle
	disappear VERMILIONCITY_BIG_SNORLAX
	setevent EVENT_FOUGHT_SNORLAX
	reloadmapafterbattle
	end

VermilionGymBadgeGuy:
	checkevent EVENT_GOT_BOTTLE_CAP_FROM_VERMILION_GUY
	iftrue_jumptextfaceplayer VermilionCityBadgeGuyBattleEdgeText
	readvar VAR_BADGES
	ifequalfwd 16, .AllBadges
	ifgreater 13, .MostBadges
	ifgreater 9, .SomeBadges
	jumpthistextfaceplayer

	text "In Kanto treffen"
	line "sich talentierte"
	cont "Trainer."

	para "Arenaleiter sind"
	line "besonders stark."

	para "Es ist nicht"
	line "leicht, sie zu"
	cont "besiegen."
	done

.SomeBadges:
	jumpthistextfaceplayer

	text "Du sammelst Orden"
	line "der Arenen in"
	cont "Kanto?"

	para "Findest du nicht"
	line "auch, dass die"
	cont "Trainer hier stark"
	cont "sind?"
	done

.MostBadges:
	jumpthistextfaceplayer

	text "Ich schätze, du"
	line "hast diesen Wett-"
	cont "kampf der Arenen"
	cont "in Kanto bald"
	cont "beendet."

	para "Lass mich wissen,"
	line "wenn du alle acht"
	cont "Orden hast."
	done

.AllBadges:
	faceplayer
	opentext
	writetext VermilionCityBadgeGuyAllBadgesText
	promptbutton
	verbosegiveitem BOTTLE_CAP, iffalse_endtext
	setevent EVENT_GOT_BOTTLE_CAP_FROM_VERMILION_GUY
	writetext VermilionCityBadgeGuyBattleEdgeText
	waitendtext

VermilionMachokeOwnerScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer VermilionMachokeOwnerText
	jumpthistextfaceplayer

	text "Mein #mon hat"
	line "das Gelände für"

	para "dieses riesige"
	line "Gebäude vorberei-"
	cont "tet!"

	para "Wirklich schade,"
	line "dass es noch nicht"
	cont "für alle offen"
	cont "ist…"
	done

VermilionCitySuperNerd2Script:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer VermilionCitySuperNerd2Text
	jumpthistextfaceplayer

	text "Die Kampffabrik"
	line "ist brandneu!"

	para "Aber sie braucht"
	line "enorm viel"
	cont "Strom…"

	para "Solange das Kraft-"
	line "werk nicht läuft,"
	cont "ist sie nutzlos!"
	done

VermilionCityBadgeGuyBattleEdgeText:
	text "Es ist vorteil-"
	line "haft, wenn du"

	para "#mon verschie-"
	line "dener Elemente"
	cont "kämpfen lässt."

	para "Ich bin sicher,"
	line "dass die Orden der"
	cont "Arenen in Kanto"
	cont "dir helfen werden."
	done

LawrenceOverheardText:
	text "…Das legendäre"
	line "#mon war also"
	cont "nicht auf dieser"
	cont "Insel…"

	para "Ich muss anderswo"
	line "weitersuchen…"
	done

LawrenceIntroText:
	text "Lawrence: Ent-"
	line "schuldige bitte,"
	cont "dass ich dich an-"
	cont "gerempelt habe."

	para "Ich habe es eilig,"
	line "meine Sammlung zu"
	cont "vervollständigen."

	para "Mein Name ist"
	line "Lawrence III."

	para "Und du bist Champ"
	line "der Liga?"

	para "…Nun, der Schein"
	line "kann trügen."

	para "Legendäre #mon"
	line "sind schon immer"
	cont "meine Passion."

	para "Ich nahm die See-"
	line "sprint-Fähre nach"

	para "Shamouti, fand"
	line "aber nicht jenes,"
	cont "das ich suchte."

	para "Oh, du bist"
	line "#mon aus Johtos"
	cont "Legenden begegnet?"

	para "Dann kreuzen sich"
	line "unsere Wege viel-"
	cont "leicht wieder, als"
	cont "Gleichgesinnte."

	para "Aber ich muss"
	line "wirklich weiter."
	cont "Lebe wohl!"
	done

VermilionCityTeacherText:
	text "Der Hafen von"
	line "Orania City ist"
	cont "das Tor Kantos"
	cont "zum Meer."

	para "Hier legen Luxus-"
	line "dampfer aus aller"
	cont "Welt an."
	done

VermilionMachokeOwnerText:
	text "Mein #mon hat"
	line "das Gelände für"

	para "dieses riesige"
	line "Gebäude vorberei-"
	cont "tet!"

	para "Vor drei Jahren"
	line "war es ein"
	cont "Machollo,"

	para "aber durch die"
	line "Mühe hat es sich"
	cont "entwickelt!"
	done

VermilionMachokeText:
	text "Maschock: Guooh"
	line "gogogoh!"
	done

VermilionCitySuperNerdText:
	text "Es gibt acht"
	line "Arenen in Kanto."

	para "Das große Gebäude"
	line "ist die PKMN-Arena"
	cont "von Orania City."
	done

VermilionCitySuperNerd2Text:
	text "Die Kampffabrik"
	line "ist brandneu, aber"

	para "schon kommen Trai-"
	line "ner aus fernen"

	para "Regionen, um sich"
	line "der Herausforde-"
	cont "rung zu stellen!"
	done

VermilionCityOfficerFText:
	text "Tut mir leid, die"
	line "Kampffabrik ist"

	para "geschlossen, bis"
	line "das Kraftwerk"
	cont "wieder läuft."
	done

VermilionCitySailorText:
	text "Nichts geht über"
	line "gute Seeluft!"
	done

VermilionCityRadioNearSnorlaxText:
	text "Der #Com wird"
	line "in der Nähe des"
	cont "schlafenden"
	cont "Relaxos platziert…"

	para "…"

	para "Relaxo ist"
	line "aufgewacht!"
	done

VermilionCityBadgeGuyAllBadgesText:
	text "Gratuliere!"

	para "Du hast alle Orden"
	line "der Arenen in"
	cont "Kanto."

	para "Ich habe hier eine"
	line "Belohnung für"
	cont "deine"
	cont "Anstrengungen."
	done

VermilionCitySignText:
	text "Orania City"

	para "Der Hafen Der"
	line "Stimmungsvollen"
	cont "Sonnenuntergänge"
	done

VermilionGymSignText:
	text "PKMN-Arena von"
	line "Orania City"

	para "Leitung: Major Bob"
	line "Der Blitzschnelle"

	para "Amerikaner"
	done

PokemonFanClubSignText:
	text "#mon-Fanclub"

	para "Alle #mon-Fans"
	line "sind willkommen!"
	done

VermilionCityDiglettsCaveSignText:
	text "Digdas Höhle"
	done

VermilionCityPortSignText:
	text "Eingang zum Hafen"
	line "von Orania City"
	done

VermilionCityPierSignText:
	db "◀ M.S. Aqua<LINE>▼ Seesprint-Fähre<DONE>" ; not compressible

VermilionCityAdvancedTipsSignText:
	text "Tipps für Profis!"

	para "Dein Trainerpass"
	line "hat Platz für"
	cont "sechzehn Orden!"
	done

VermilionCityBattleFactorySignText:
	text "Kampffabrik"

	para "Gewinne alles mit"
	line "Leih-#mon!"
	done
