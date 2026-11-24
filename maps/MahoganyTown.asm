MahoganyTown_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_MAHOGANYTOWN_TRY_RAGECANDYBAR
	scene_const SCENE_MAHOGANYTOWN_NOOP

	def_callbacks
	callback MAPCALLBACK_NEWMAP, MahoganyTownFlyPoint

	def_warp_events
	warp_event 11,  7, MAHOGANY_MART_1F, 1
	warp_event 17,  7, MAHOGANY_RED_GYARADOS_SPEECH_HOUSE, 1
	warp_event  6, 13, MAHOGANY_GYM, 1
	warp_event 15, 13, MAHOGANY_POKECENTER_1F, 1
	warp_event  9,  1, ROUTE_43_MAHOGANY_GATE, 3

	def_coord_events
	coord_event 19,  8, SCENE_MAHOGANYTOWN_TRY_RAGECANDYBAR, MahoganyTownTryARageCandyBarScript
	coord_event 19,  9, SCENE_MAHOGANYTOWN_TRY_RAGECANDYBAR, MahoganyTownTryARageCandyBarScript

	def_bg_events
	bg_event  1,  5, BGEVENT_JUMPTEXT, MahoganyTownSignText
	bg_event  9,  7, BGEVENT_READ, MahoganyTownSouvenirShopSign
	bg_event  7, 13, BGEVENT_JUMPTEXT, MahoganyGymSignText

	def_object_events
	object_event 19,  8, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, MahoganyTownPokefanMScript, EVENT_MAHOGANY_TOWN_POKEFAN_M_BLOCKS_EAST
	object_event  6,  9, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyTownGrampsScript, -1
	object_event  6, 14, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MahoganyTownFisherText, EVENT_MAHOGANY_TOWN_POKEFAN_M_BLOCKS_GYM
	object_event 12,  8, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, MahoganyTownLassText, EVENT_MAHOGANY_MART_OWNERS

	object_const_def
	const MAHOGANYTOWN_POKEFAN_M

MahoganyTownFlyPoint:
	setflag ENGINE_FLYPOINT_MAHOGANY
	endcallback

MahoganyTownTryARageCandyBarScript:
	showemote EMOTE_SHOCK, MAHOGANYTOWN_POKEFAN_M, 15
	applymovement MAHOGANYTOWN_POKEFAN_M, MahoganyTownRageCandyBarMerchantBlocksYouMovement
	follow PLAYER, MAHOGANYTOWN_POKEFAN_M
	applyonemovement PLAYER, step_left
	stopfollow
	turnobject PLAYER, RIGHT
	scall RageCandyBarMerchantScript
	applymovement MAHOGANYTOWN_POKEFAN_M, MahoganyTownRageCandyBarMerchantReturnsMovement
	end

MahoganyTownPokefanMScript:
	faceplayer
RageCandyBarMerchantScript:
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue_jumptext RageCandyBarMerchantSoldOutText
	opentext
	writetext RageCandyBarMerchantTryOneText
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext RageCandyBarMerchantRefusedText
	checkmoney YOUR_MONEY, 300
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	giveitem RAGECANDYBAR, iffalse_jumpopenedtext RageCandyBarMerchantNoRoomText
	waitsfx
	playsound SFX_TRANSACTION
	takemoney YOUR_MONEY, 300
	special PlaceMoneyTopRight
	jumpthisopenedtext

	text "Gut! Genieße ihn!"
	done

.NotEnoughMoney:
	jumpthisopenedtext

	text "Du hast nicht ge-"
	line "nug Geld."
	done

MahoganyTownGrampsScript:
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue_jumptextfaceplayer MahoganyTownGrampsText_ClearedRocketHideout
	jumpthistextfaceplayer

	text "Hast du vor, die"
	line "Garados am See an-"
	cont "zusehen?"
	done

MahoganyTownSouvenirShopSign:
	checkevent EVENT_MAHOGANY_MART_OWNERS
	iftrue_jumptext MahoganyTownSouvenirShopSignText1
	jumpthistext

	text "Grandma's"
	line "Souvenir Shop"
	done

MahoganyTownRageCandyBarMerchantBlocksYouMovement:
	step_right
	step_down
	turn_head_left
	step_end

MahoganyTownRageCandyBarMerchantReturnsMovement:
	step_up
	turn_head_down
	step_end

RageCandyBarMerchantTryOneText:
	text "Hi, Zwerg!"

	para "Ich sehe, du bist"
	line "neu in Mahagonia."

	para "Du musst unbedingt"
	line "einen Wutkeks"
	cont "probieren!"

	para "Ich habe einen da-"
	line "bei. Für nur ¥300"
	cont "gehört er dir."
	done

RageCandyBarMerchantRefusedText:
	text "Dann eben nicht…"
	done

RageCandyBarMerchantNoRoomText:
	text "Du hast keinen"
	line "Platz mehr."
	done

RageCandyBarMerchantSoldOutText:
if DEF(FAITHFUL)
	text "RageCandyBars are"
else
	text "Cakes of Rage are"
endc
	line "sold out."

	para "I'm packing up."
	line "Don't bother me,"
	cont "kiddo."
	done


MahoganyTownGrampsText_ClearedRocketHideout:
	text "Die Karpador sind"
	line "zum See des Zorns"
	cont "zurückgekehrt."

	para "Das sind gute Neu-"
	line "igkeiten für die"
	cont "Angler."
	done

MahoganyTownFisherText:
	text "Wenn du schon so"
	line "weit gekommen"

	para "bist, solltest du"
	line "dir die Zeit neh-"
	cont "men, um etwas"

	para "Sightseeing zu un-"
	line "ternehmen."

	para "Geh nach Norden"
	line "und sieh dir den"

	para "See des Zorns an."
	done

MahoganyTownLassText:
	text "Besuche Großmut-"
	line "ters Laden. Sie"

	para "verkauft Artikel,"
	line "die du sonst nir-"
	cont "gends bekommen"
	cont "kannst."
	done

MahoganyTownSignText:
	text "Mahagonia City"

	para "Willkommen in der"
	line "Stadt der Ninja"
	done

MahoganyTownSouvenirShopSignText1:
	text "Just a Souvenir"
	line "Shop"

	para "Nothing Suspicious"
	line "About It"

	para "No Need to Be"
	line "Alarmed"
	done

MahoganyGymSignText:
	text "PKMN-Arena von"
	line "Mahagonia City"

	para "Leitung: Norbert"
	line "Der Lehrer der"

	para "Härte des Winters"
	done
