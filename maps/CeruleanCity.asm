CeruleanCity_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, CeruleanCityFlyPoint
	callback MAPCALLBACK_CMDQUEUE, CeruleanCitySetUpPaletteSwap

	def_warp_events
	warp_event  8,  9, CERULEAN_GYM_BADGE_SPEECH_HOUSE, 1
	warp_event 24,  9, CERULEAN_POLICE_STATION, 1
	warp_event 13, 13, CERULEAN_TRADE_SPEECH_HOUSE, 1
	warp_event 19, 15, CERULEAN_POKECENTER_1F, 1
	warp_event 26, 17, CERULEAN_GYM, 1
	warp_event 25, 23, CERULEAN_MART, 2
	warp_event  2,  7, CERULEAN_CAVE_1F, 1
	warp_event 13, 23, CERULEAN_BIKE_SHOP, 1
	warp_event 14,  9, CERULEAN_BERRY_POWDER_HOUSE, 1
	warp_event 19, 23, CERULEAN_COUPLE_HOUSE, 1
	warp_event 31,  9, CERULEAN_WATER_SHOW_SPEECH_HOUSE, 1

	def_coord_events
	coord_event  4,  2, SCENE_ROUTE24_BRIDGE_UNDERFOOT, CeruleanCityPrepareRoute24BridgeOverhead
	coord_event  5,  2, SCENE_ROUTE24_BRIDGE_UNDERFOOT, CeruleanCityPrepareRoute24BridgeOverhead
	coord_event 20,  2, SCENE_ROUTE24_BRIDGE_UNDERFOOT, CeruleanCityPrepareRoute24BridgeUnderfoot
	coord_event 21,  2, SCENE_ROUTE24_BRIDGE_UNDERFOOT, CeruleanCityPrepareRoute24BridgeUnderfoot

	def_bg_events
	bg_event 17, 18, BGEVENT_JUMPTEXT, CeruleanCitySignText
	bg_event 27, 17, BGEVENT_JUMPTEXT, CeruleanGymSignText
	bg_event 11, 23, BGEVENT_JUMPTEXT, CeruleanBikeShopSignText
	bg_event 29,  9, BGEVENT_JUMPTEXT, CeruleanPoliceSignText
	bg_event 19,  3, BGEVENT_JUMPTEXT, CeruleanCapeSignText
	bg_event 12, 17, BGEVENT_JUMPTEXT, CeruleanBubblerText
	bg_event 21, 25, BGEVENT_JUMPTEXT, CeruleanTrainerTipsText
	bg_event  4,  7, BGEVENT_ITEM + BERSERK_GENE, EVENT_FOUND_BERSERK_GENE_IN_CERULEAN_CITY
	bg_event 31, 15, BGEVENT_ITEM + RARE_CANDY, EVENT_CERULEAN_CITY_HIDDEN_RARE_CANDY

	def_object_events
	object_event 21, 18, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeruleanCityCooltrainerFScript, -1
	object_event  7,  6, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeruleanCityYoungsterScript, -1
	object_event 30, 20, SPRITE_COOL_DUDE, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCityCooltrainerMScript, -1
	object_event 28, 12, SPRITE_POKEMANIAC, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeruleanCitySuperNerdText, -1
	pokemon_event 20, 18, SLOWBRO, SPRITEMOVEDATA_STILL, -1, PAL_MON_PINK, CeruleanCitySlowbroText, -1
	object_event 10, 17, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeruleanCityFisherScript, -1
	object_event  2,  8, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeruleanCaveGuardText, EVENT_BEAT_BLUE
	cuttree_event 44, 14, EVENT_ROUTE_9_CUT_TREE

	object_const_def
	const CERULEANCITY_COOLTRAINER_F
	const CERULEANCITY_YOUNGSTER

CeruleanCityFlyPoint:
	setflag ENGINE_FLYPOINT_CERULEAN
	endcallback

CeruleanCitySetUpPaletteSwap:
	usepaletteswap .PaletteSwap
	endcallback

.PaletteSwap:
	paletteswap 12, 29, 0, 3, PAL_BG_YELLOW, PAL_BG_YELLOW, NuggetBridgePalettes
	db -1 ; end

CeruleanCityPrepareRoute24BridgeOverhead:
	callthisasm
	xor a
	jr CeruleanCity_FinishPrepareBridge

CeruleanCityPrepareRoute24BridgeUnderfoot:
	callthisasm
	ld a, $1
CeruleanCity_FinishPrepareBridge:
	ld [wWalkingOnBridge], a
	ld [wRoute24SceneID], a ; setscene a
	ret

CeruleanCityCooltrainerMScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer CeruleanCityCooltrainerMText2
	jumpthistextfaceplayer

	text "Das Kraftwerk von"
	line "Kanto?"

	para "Es befindet"
	line "sich am Ende von"

	para "Route 9, auf der"
	line "Straße östlich"
	cont "von hier."

	para "Es muss dort einen"
	line "Störfall gegeben"
	cont "haben."
	done

CeruleanCityCooltrainerFScript:
	faceplayer
	opentext
	writetext CeruleanCityCooltrainerFText1
	waitbutton
	turnobject CERULEANCITY_COOLTRAINER_F, LEFT
	writetext CeruleanCityCooltrainerFText2
	waitbutton
	writetext CeruleanCitySlowbroText
	cry SLOWBRO
	waitbutton
	writetext CeruleanCityCooltrainerFText3
	waitendtext
	end

CeruleanCityFisherScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer CeruleanCityFisherText
	checkevent EVENT_MET_ROCKET_GRUNT_AT_CERULEAN_GYM
	iftrue_jumptextfaceplayer CeruleanCityFisherRocketTipText
	jumptextfaceplayer CeruleanCityFisherText

CeruleanCityYoungsterScript:
	checkevent EVENT_FOUND_BERSERK_GENE_IN_CERULEAN_CITY
	iftrue_jumptextfaceplayer CeruleanCityYoungsterText
	faceplayer
	showtext CeruleanCityYoungsterText1
	waitsfx
	playsound SFX_SECOND_PART_OF_ITEMFINDER
	waitsfx
	playsound SFX_TRANSACTION
	waitsfx
	playsound SFX_SECOND_PART_OF_ITEMFINDER
	waitsfx
	playsound SFX_TRANSACTION
	waitsfx
	playsound SFX_SECOND_PART_OF_ITEMFINDER
	waitsfx
	playsound SFX_TRANSACTION
	waitsfx
	playsound SFX_SECOND_PART_OF_ITEMFINDER
	waitsfx
	playsound SFX_TRANSACTION
	waitsfx
	showemote EMOTE_SHOCK, CERULEANCITY_YOUNGSTER, 15
	turnobject CERULEANCITY_YOUNGSTER, LEFT
	jumpthistext

	text "Ach ja?"

	para "Mein Detektor"
	line "schlägt aus…"
	done


CeruleanCityCooltrainerMText2:
	text "Sammelst du jede"
	line "Art von #mon?"

	para "Das ist bestimmt"
	line "sehr schwer. Aber"
	cont "Spaß macht es"
	cont "sicher auch."
	done

CeruleanCitySuperNerdText:
	text "Am Kap im Norden"
	line "treffen sich viele"

	para "Pärchen. Gerade"
	line "Mädchen gehen dort"
	cont "gerne hin!"
	done

CeruleanCitySlowbroText:
	text "Lahmus: Jarah?"
	done

CeruleanCityCooltrainerFText1:
	text "Mein Lahmus und"
	line "ich sind ein un-"
	cont "schlagbares Team!"
	done

CeruleanCityCooltrainerFText2:
	text "Lahmus, mach deine"
	line "Konfusion vor!"
	done

CeruleanCityCooltrainerFText3: ; text > text
	text "…"
	done

CeruleanCityFisherText:
	text "Ich bin ein großer"
	line "Fan von der Arena-"
	cont "leiterin in Azuria"
	cont "City. Ihr Name ist"
	cont "Misty."
	done

CeruleanCityFisherRocketTipText:
	text "Ich habe so einen"
	line "zwielichtigen Typ"
	cont "zum Kap bei Azuria"
	cont "City gehen sehen."
	done

CeruleanCityYoungsterText1:
	text "Hier gibt es eine"
	line "Höhle, in der"
	cont "mächtige und"
	cont "grässliche #mon"
	cont "hausen."
	done


CeruleanCityYoungsterText:
	text "Mein Detektor"
	line "reagiert nicht"
	cont "mehr…"

	para "Da ist mir wohl"
	line "jemand zuvorge-"
	cont "kommen."
	done

CeruleanCaveGuardText:
	text "Das ist…"

	para "die berüchtigte"
	line "Azuria-Höhle!"

	para "Hier leben"
	line "furchtbar starke"
	cont "#mon."

	para "Nur wer alle acht"
	line "Arenaleiter von"

	para "Kanto besiegt hat,"
	line "darf hinein."
	done

CeruleanCitySignText:
	text "Azuria City"

	para "Umgeben Von Einer"
	line "Mystischen Blauen"
	cont "Aura"
	done

CeruleanGymSignText:
	text "PKMN-Arena von"
	line "Azuria City"
	cont "Leitung: Misty"

	para "Die Jungenhafte"
	line "Meerjungfrau"
	done

CeruleanBikeShopSignText:
	text "Trendsetter des"
	line "Fahrrad-Booms"

	para "Fahrradladen"
	done

CeruleanPoliceSignText:
	text "Hier ist eine"
	line "Nachricht…"

	para "Stoppt die Krimi-"
	line "nalität und macht"

	para "aus dieser Stadt"
	line "einen Ort, an dem"
	cont "man sicher ist und"
	cont "gerne lebt!"

	para "Ordnungsamt von"
	line "Azuria City"
	done

CeruleanCapeSignText:
	text "Kap bei Azuria"
	line "City voraus"
	done

CeruleanBubblerText:
	text "Das Wasser"
	line "schmeckt gut!"
	done

CeruleanTrainerTipsText:
	text "Tipps für Trainer"

	para "Auch ohne Detektor"
	line "findest du"

	para "nützliche Items in"
	line "Bäumen, unter"

	para "Felsen oder unter"
	line "Wasser."
	done
