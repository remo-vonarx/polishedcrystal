PewterCity_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, PewterCityFlyPoint
	callback MAPCALLBACK_CMDQUEUE, PewterCitySetUpPaletteSwap

	def_warp_events
	warp_event 29, 15, PEWTER_NIDORAN_SPEECH_HOUSE, 1
	warp_event 12, 19, PEWTER_GYM, 1
	warp_event 23, 21, PEWTER_MART, 2
	warp_event 13, 27, PEWTER_POKECENTER_1F, 1
	warp_event  7, 31, PEWTER_SNOOZE_SPEECH_HOUSE, 1
	warp_event 14,  9, PEWTER_MUSEUM_OF_SCIENCE_1F, 1
	warp_event 19,  7, PEWTER_MUSEUM_OF_SCIENCE_1F, 3
	warp_event 15,  9, PEWTER_MUSEUM_OF_SCIENCE_1F, 2

	def_coord_events

	def_bg_events
	bg_event 25, 25, BGEVENT_JUMPTEXT, PewterCitySignText
	bg_event 13, 19, BGEVENT_JUMPTEXT, PewterGymSignText
	bg_event 13, 10, BGEVENT_JUMPTEXT, PewterMuseumOfScienceSignText
	bg_event 33, 21, BGEVENT_JUMPTEXT, PewterCityMtMoonGiftShopSignText
	bg_event 19, 31, BGEVENT_JUMPTEXT, PewterCityTrainerTipsText

	def_object_events
	object_event 22, 13, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 2, 2, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, PewterCityCooltrainerFText, -1
	object_event 19, 12, SPRITE_COOL_DUDE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 2, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, PewterCityCooltrainermText, -1
	object_event 14, 31, SPRITE_CHILD, SPRITEMOVEDATA_WANDER, 2, 2, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, PewterCityBugCatcherText, -1
	object_event 29, 19, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PewterCityGrampsScript, -1
	object_event  6, 15, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WANDER, 2, 2, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PewterCityYoungsterScript, -1
	object_event 25, 28, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WANDER, 2, 2, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, PewterCityPokefanMScript, -1
	object_event  6,  6, SPRITE_LADY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_PINK, OBJECTTYPE_COMMAND, jumptextfaceplayer, PewterCityLadyText, -1
	pokemon_event  7,  6, MEOWTH, ALOLAN_FORM, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_GRAY, PewterCityMeowthText, -1
	fruittree_event 26,  5, FRUITTREE_PEWTER_CITY_1, PETAYA_BERRY, PAL_NPC_PINK
	fruittree_event 24,  5, FRUITTREE_PEWTER_CITY_2, APICOT_BERRY, PAL_NPC_BLUE

PewterCityFlyPoint:
	setflag ENGINE_FLYPOINT_PEWTER
	endcallback

PewterCitySetUpPaletteSwap:
	usepaletteswap .PaletteSwap
	endcallback

.PaletteSwap:
	paletteswap 0, 255, 0, 13, PAL_BG_WATER, OverworldWaterPalettes, PewterCityMuseumRoofPalettes
	db -1 ; end

PewterCityGrampsScript:
	checkevent EVENT_GOT_OLD_AMBER
	iftrue_jumptextfaceplayer PewterCityGrampsText_GotSilverWing
	faceplayer
	opentext
	writetext PewterCityGrampsText
	promptbutton
	verbosegiveitem OLD_AMBER, iffalse_endtext
	setevent EVENT_GOT_OLD_AMBER
	endtext

PewterCityYoungsterScript:
	faceplayer
	opentext
	writetext PewterCityYoungsterText1
	waitbutton
	checkflag ENGINE_BOULDERBADGE
	iffalse_endtext
	jumpthisopenedtext

	text "You beat the Gym?"
	line "Then you're tough"
	cont "as rock too!"
	done

PewterCityPokefanMScript:
	faceplayer
	opentext
	writetext .Text1
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext .Text3
	checkmoney YOUR_MONEY, 300
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	giveitem PEWTERCRUNCH, iffalse_jumpopenedtext .Text4
	waitsfx
	takemoney YOUR_MONEY, 300
	special PlaceMoneyTopRight
	waitsfx
	playsound SFX_TRANSACTION
	writetext .Text2
	promptbutton
	itemnotify
	endtext

.Text1:
	text "The Pewter City"
	line "specialty--"
	cont "PewterCrunch!"

	para "I'll sell you a"
	line "package for ¥300!"
	done

.Text2:
	text "Thanks!"
	line "They're very hard,"
	cont "so be careful!"
	done

.Text3:
	text "Are they too"
	line "crunchy for you?"
	done

.Text4:
	text "You don't have"
	line "room for them!"
	done

.NotEnoughMoney:
	jumpthisopenedtext

	text "You don't have"
	line "cash for them!"
	done

PewterCityCooltrainerFText:
	text "#mon can only"
	line "be two types at"
	cont "once, but if it"
	cont "were possible for"

	para "a #mon to be"
	line "every type, it"
	cont "would only have"
	cont "one weakness."

	para "What weakness,"
	line "you ask?"

	para "Rock-type attacks,"
	line "of course!"
	done

PewterCityCooltrainermText:
	text "This gal thinks"
	line "Rock-type #mon"
	cont "are all that,"

	para "but it's tied for"
	line "the most weakness-"
	cont "es of any type."

	para "I don't have the"
	line "heart to tell her,"
	cont "though."
	done

PewterCityBugCatcherText:
	text "Nachts spielen"
	line "Piepi beim"
	cont "Mondberg."

	para "Aber nicht in"
	line "jeder Nacht."
	done

PewterCityGrampsText:
	text "Oh, du bist den"
	line "ganzen Weg "
	cont "von Johto bis"
	cont "hierher gekommen?"

	para "Das weckt"
	line "Erinnerungen. Als"

	para "ich noch jung war,"
	line "habe ich in Johto"
	cont "oft trainiert."

	para "Du erinnerst"
	line "mich an mich"

	para "selbst als junger"
	line "Mann."

	para "Hier. Ich möchte,"
	line "dass du dieses"
	cont "Item, das ich in"
	cont "Johto fand,"
	cont "behältst."
	done

PewterCityGrampsText_GotSilverWing:
	text "Neue und un-"
	line "bekannte Orte zu"
	cont "erforschen und"
	cont "fremde Menschen"
	cont "kennen zu lernen…"

	para "Das ist das Schöne"
	line "am Reisen."
	done

PewterCityYoungsterText1:
	text "The Pewter Gym is"
	line "as rough and tough"
	cont "as rock itself."

	para "Be careful in"
	line "there."
	done

PewterCityLadyText:
	text "Pewter City stays"
	line "cool since it"

	para "lies at the base"
	line "of Mt.Moon."
	done

PewterCityMeowthText:
	text "Meowth: Miao!"
	done

PewterCitySignText:
	text "Marmoria City"
	line "Eine Steingraue"
	cont "Stadt"
	done

PewterGymSignText:
	text "PKMN-Arena von"
	line "Marmoria City"
	cont "Leitung: Rocko"

	para "Der Felsenharte"
	line "#mon-Trainer"
	done

PewterMuseumOfScienceSignText:
	text "Marmorias Museum"
	line "der Wissenschaft"
	done

PewterCityMtMoonGiftShopSignText:
	text "Hier ist eine"
	line "Nachricht…"

	para "Souvenirladen am"
	line "Mondberg"
	cont "Jetzt geöffnet!"
	done

PewterCityTrainerTipsText:
	text "Tipps für Trainer"

	para "Trägt ein #mon"
	line "eine Fähigkeits-"
	cont "kapsel, hat sein"
	cont "Nachwuchs eher"
	cont "eine seltene"
	cont "Fähigkeit."
	done
