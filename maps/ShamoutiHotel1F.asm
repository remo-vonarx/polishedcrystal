ShamoutiHotel1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, ShamoutiHotel1FRestaurantTrigger

	def_warp_events
	warp_event  8,  7, SHAMOUTI_ISLAND, 2
	warp_event  9,  7, SHAMOUTI_ISLAND, 2
	warp_event  2,  0, SHAMOUTI_HOTEL_2F, 1
	warp_event 14,  0, SHAMOUTI_HOTEL_RESTAURANT, 1

	def_coord_events

	def_bg_events
	bg_event 15,  0, BGEVENT_JUMPTEXT, ShamoutiHotelRestaurantSignText

	def_object_events
	object_event  8,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiHotel1FReceptionistText, -1
	object_event  2,  4, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ShamoutiHotel1FArtistScript, -1
	object_event  5,  4, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiHotel1FCooltrainermText, -1
	object_event 12,  5, SPRITE_LADY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiHotel1FLadyText, -1
	object_event 14,  7, SPRITE_CAMPER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiHotel1FYoungsterText, -1

ShamoutiHotel1FRestaurantTrigger:
	setmapscene SHAMOUTI_HOTEL_RESTAURANT, SCENE_SHAMOUTIHOTELRESTAURANT_MEET
	endcallback

ShamoutiHotel1FReceptionistText:
	text "Willkommen im"
	line "Hotel Shamouti."

	para "Leider sind all"
	line "unsere Zimmer aus-"
	cont "gebucht, aber"

	para "besuche doch unser"
	line "Luxusrestaurant"
	cont "Oase!"
	done

ShamoutiHotel1FArtistScript:
	faceplayer
	opentext
	checkflag ENGINE_CHANGED_TRENDY_PHRASE
	iftruefwd .SetTrendyPhraseToday
	writetext .Text1
	yesorno
	iftruefwd .Yes
	writetext .Text2
	promptbutton
	special SpecialTrendyPhrase
	setflag ENGINE_CHANGED_TRENDY_PHRASE
	jumpopenedtext .Text3

.SetTrendyPhraseToday
	jumpopenedtext .Text4

.Yes
	jumpopenedtext .Text5

.Text1:
	text "Egal, wo man hin-"
	line "geht, <TRENDY>"

	para "ist das Coolste"
	line "überhaupt!"
	cont "Stimmt doch, oder?"
	done

.Text2:
	text "Was?! <TRENDY>"
	line "ist nicht das"
	cont "Coolste überhaupt?"

	para "Was ist denn dann"
	line "zurzeit das"
	cont "Coolste?"
	done

.Text3:
	text "Oh ja! Jetzt hab"
	line "ich's kapiert!"

	para "<TRENDY> ist"
	line "echt das Beste,"
	cont "was es gibt!"
	done

.Text4:
	text "<TRENDY> ist"
	line "gerade total hip"
	cont "und angesagt!"
	done

.Text5:
	text "Na klar! Ich kann"
	line "einfach nicht"
	cont "genug kriegen von"
	cont "<TRENDY>!"
	done

ShamoutiHotel1FCooltrainermText:
	text "<TRENDY> ist also"
	line "der neue Hit?"

	cont "Wie cool!"
	done

ShamoutiHotel1FLadyText:
	text "Hast du beim An-"
	line "geln schon mal"
	cont "einen Kronkorken"
	cont "gefunden?"

	para "In Alola, wo ich"
	line "herkomme, gibt es"

	para "einen Mann, der"
	line "für nur einen"
	cont "Kronkorken mit"

	para "deinen #mon ein"
	line "“Super-Spezial-"
	cont "training” macht--"

	para "und so ihr volles"
	line "Potenzial weckt!"
	done

ShamoutiHotel1FYoungsterText:
	text "Ich habe gehört,"
	line "<TRENDY> ist"
	cont "gerade “in”!"
	done

ShamoutiHotelRestaurantSignText:
	text "Restaurant Oase"
	done
