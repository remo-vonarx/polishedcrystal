Route10South_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_CMDQUEUE, Route10SouthSetUpPaletteSwap

	def_warp_events
	warp_event  6,  3, ROCK_TUNNEL_1F, 2

	def_coord_events

	def_bg_events
	bg_event  5,  5, BGEVENT_JUMPTEXT, Route10SignText
	bg_event 16,  3, BGEVENT_ITEM + MAX_ETHER, EVENT_ROUTE_10_HIDDEN_MAX_ETHER

	def_object_events
	object_event 17,  5, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerHikerJim, -1
	object_event  4,  7, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerPokefanmRobert, -1
	object_event  8, 12, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerHexManiacAmy, -1
	tmhmball_event  9,  7, TM_VOLT_SWITCH, EVENT_ROUTE_10_TM_VOLT_SWITCH
	object_event 14, 19, SPRITE_CABLE_CAR, SPRITEMOVEDATA_RADIO_DISH, 0, 0, -1, PAL_NPC_COPY_BG_GRAY, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 15, 19, SPRITE_CABLE_CAR, SPRITEMOVEDATA_RADIO_DISH, 0, 0, -1, PAL_NPC_COPY_BG_GRAY, OBJECTTYPE_COMMAND, end, NULL, -1

Route10SouthSetUpPaletteSwap:
	usepaletteswap .PaletteSwap
	endcallback

.PaletteSwap:
	paletteswap 0, 255, 12, 255, PAL_BG_GREEN, OverworldGreenPalettes, LavenderRadioTowerRoofPalettes
	db -1 ; end

GenericTrainerHikerJim:
	generictrainer HIKER, JIM, EVENT_BEAT_HIKER_JIM, HikerJimSeenText, HikerJimBeatenText

	text "Ich habe Heu-"
	line "schnupfen!"
	para "Haha-hatschi!"
	done

GenericTrainerPokefanmRobert:
	generictrainer POKEFANM, ROBERT, EVENT_BEAT_POKEFANM_ROBERT, PokefanmRobertSeenText, PokefanmRobertBeatenText

	text "Sieh nur, was du"
	line "meinen #mon"
	cont "angetan hast…"

	para "Das werde ich dir"
	line "nie verzeihen…"
	done

GenericTrainerHexManiacAmy:
	generictrainer HEX_MANIAC, AMY, EVENT_BEAT_HEX_MANIAC_AMY, HexManiacAmySeenText, HexManiacAmyBeatenText

	text "Eine Hexe findet"
	line "Frieden unter den"
	cont "Geistern…"
	done

HikerJimSeenText:
	text "Hahahah!"
	done

HikerJimBeatenText:
	text "Hahaha-hatschi!"
	done

PokefanmRobertSeenText:
	text "Du magst #mon,"
	line "nicht wahr?"

	para "Ich auch!"
	done

PokefanmRobertBeatenText:
	text "Ich gebe zu, ich"
	line "habe verloren."
	done

HexManiacAmySeenText:
	text "Lavandia…"

	para "Wo die Seelen der"
	line "#mon schlafen…"
	done

HexManiacAmyBeatenText:
	text "Deine #mon"
	line "sprühen vor"
	cont "Lebenskraft…"
	done

Route10SignText:
	text "Route 10"

	para "Azuria City -"
	line "Lavandia"
	done
