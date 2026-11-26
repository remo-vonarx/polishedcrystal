FuchsiaCity_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, FuchsiaCityFlyPoint
	callback MAPCALLBACK_CMDQUEUE, FuchsiaCitySetUpPaletteSwap

	def_warp_events
	warp_event  5, 13, FUCHSIA_MART, 2
	warp_event  6, 27, FUCHSIA_GYM, 1
	warp_event 11, 27, FUCHSIA_BILL_SPEECH_HOUSE, 1
	warp_event 19, 27, FUCHSIA_POKECENTER_1F, 1
	warp_event 27, 27, SAFARI_ZONE_WARDENS_HOME, 1
	warp_event 18,  3, SAFARI_ZONE_FUCHSIA_GATE, 3
	warp_event 37, 22, ROUTE_15_FUCHSIA_GATE, 1
	warp_event 37, 23, ROUTE_15_FUCHSIA_GATE, 2
	warp_event  7, 33, ROUTE_19_FUCHSIA_GATE, 1
	warp_event  8, 33, ROUTE_19_FUCHSIA_GATE, 2
	warp_event 15, 27, FUCHSIA_SAFARI_BALL_HOUSE, 1
	warp_event 22, 13, FUCHSIA_AQUARIUM_1F, 1
	warp_event 23, 13, FUCHSIA_AQUARIUM_1F, 2
	warp_event 31, 27, FUCHSIA_FISHING_SPEECH_HOUSE, 1
	warp_event 31, 24, FUCHSIA_FISHING_SPEECH_HOUSE, 3
	warp_event 32, 24, FUCHSIA_FISHING_SPEECH_HOUSE, 3

	def_coord_events

	def_bg_events
	bg_event 35, 16, BGEVENT_JUMPTEXT, FuchsiaCitySignText
	bg_event  7, 27, BGEVENT_JUMPTEXT, FuchsiaGymSignText
	bg_event 21, 16, BGEVENT_JUMPTEXT, FuchsiaZooSignText
	bg_event 27, 29, BGEVENT_JUMPTEXT, WardensHomeSignText
	bg_event 17,  5, BGEVENT_JUMPTEXT, SafariZoneClosedSignText
	bg_event 13, 19, BGEVENT_JUMPTEXT, NoLitteringSignText
	bg_event  7,  7, BGEVENT_READ, FuchsiaCityZooDratiniSign
	bg_event 13,  7, BGEVENT_READ, FuchsiaCityZooKangaskhanSign
	bg_event 27,  7, BGEVENT_READ, FuchsiaCityZooTaurosSign
	bg_event 33,  7, BGEVENT_READ, FuchsiaCityZooChanseySign
	bg_event 31, 13, BGEVENT_READ, FuchsiaCityZooSlowpokeSign
	bg_event  9, 15, BGEVENT_READ, FuchsiaCityZooLaprasSign
	bg_event 11, 35, BGEVENT_JUMPTEXT, FuchsiaCityCarefulSwimmingSignText
	bg_event 26, 13, BGEVENT_JUMPTEXT, FuchsiaAquariumSignText
	bg_event 26, 12, BGEVENT_ITEM + NUGGET, EVENT_FUCHSIA_CITY_HIDDEN_NUGGET

	def_object_events
	object_event 19, 18, SPRITE_CAMPER, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaCityYoungsterText, -1
	object_event 10,  8, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaCityPokefanMText, -1
	object_event 16, 13, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaCityTeacherText, -1
	object_event 30,  9, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WANDER, 2, 2, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaCityPokefanFText, -1
	cuttree_event 16, 19, EVENT_FUCHSIA_CITY_CUT_TREE
	fruittree_event 14, 17, FRUITTREE_FUCHSIA_CITY, LIECHI_BERRY, PAL_NPC_RED
	pokemon_event  6,  5, DRATINI, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_AZURE, EmptyString, -1
	pokemon_event 12,  6, KANGASKHAN, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_BROWN, EmptyString, -1
	pokemon_event 26,  6, TAUROS, TAUROS_PALDEAN_FIRE_FORM, SPRITEMOVEDATA_POKEMON, 1 << MORN, PAL_MON_RED, EmptyString, -1
	pokemon_event 25,  6, TAUROS, NO_FORM, SPRITEMOVEDATA_POKEMON, 1 << DAY, PAL_MON_BROWN, EmptyString, -1
	pokemon_event 25,  5, TAUROS, PALDEAN_FORM, SPRITEMOVEDATA_POKEMON, 1 << EVE, PAL_MON_BLACK, EmptyString, -1
	pokemon_event 26,  5, TAUROS, TAUROS_PALDEAN_WATER_FORM, SPRITEMOVEDATA_POKEMON, 1 << NITE, PAL_MON_BLUE, EmptyString, -1
	pokemon_event 31,  5, CHANSEY, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_PINK, EmptyString, -1
	pokemon_event 30, 12, SLOWPOKE, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_PINK, EmptyString, -1
	object_event  8, 17, SPRITE_LAPRAS, SPRITEMOVEDATA_SWIM_AROUND, 2, 1, -1, 0, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, -1

FuchsiaCityFlyPoint:
	setflag ENGINE_FLYPOINT_FUCHSIA
	endcallback

FuchsiaCitySetUpPaletteSwap:
	usepaletteswap .PaletteSwap
	endcallback

.PaletteSwap:
	paletteswap 9, 31, 0, 19, PAL_BG_ROOF, GROUP_FUCHSIA_CITY, GROUP_SAFARI_ZONE_HUB
	db -1 ; end

FuchsiaCityYoungsterText:
	text "Warum ist der"
	line "Wärter so plötz-"
	cont "lich gegangen?"

	para "Ich habe gehört,"
	line "er sei auf der"
	cont "Flucht vor der"
	cont "Polizei!"
	done

FuchsiaCityPokefanMText:
	text "Kogas Tochter ist"
	line "jetzt Arena-"
	cont "leiterin, nachdem"

	para "ihr Vater den Top"
	line "Vier beigetreten"
	cont "ist."
	done

FuchsiaCityTeacherText:
	text "Das Safari-Spiel"
	line "wurde eingestellt…"

	para "Immerhin ist die"
	line "Safari-Zone noch"
	cont "geöffnet."

	para "Um sie zu erkun-"
	line "den, brauchst du"
	cont "aber ein starkes"
	cont "#mon."
	done

FuchsiaCityPokefanFText:
	text "Nachdem der Wärter"
	line "der Safari-Zone"
	cont "gegangen war,"

	para "hat sich die Stadt"
	line "weiter um die Zoo-"
	cont "gehege gekümmert."

	para "Wir haben sogar"
	line "sein altes Büro in"
	cont "ein Aquarium ver-"
	cont "wandelt!"
	done

FuchsiaCitySignText:
	text "Fuchsania City"

	para "Sieh nur! Die"
	line "Rosarote"
	cont "Lieblichkeit!"
	done

FuchsiaGymSignText:
	text "PKMN-Arena von"
	line "Fuchsania City"
	cont "Leitung: Janina"

	para "Die Giftige"
	line "Ninja-Meisterin"
	done

FuchsiaZooSignText:
	text "Zoo von Fuchsania"

	para "Mit den #mon"
	line "der Safari-Zone"
	done

FuchsiaAquariumSignText:
	text "Aquarium von"
	line "Fuchsania City"

	para "Bestaune die Wun-"
	line "der der Wasser-"
	cont "#mon!"
	done

WardensHomeSignText:
	text "Safari-Zone"
	line "Haus des Wärters"
	done

SafariZoneClosedSignText:
	text "Der Wärter ist"
	line "nicht da. Deshalb"

	para "fällt das Safari-"
	line "Spiel aus."
	done

NoLitteringSignText:
	text "Verunreinigung des"
	line "Parks ist"
	cont "verboten."

	para "Hinterlasse"
	line "bitte keinen"
	cont "Abfall."
	done

FuchsiaCityZooDratiniSign:
	showtext .DratiniText
	reanchormap
	pokepic DRATINI
	cry DRATINI
	waitbutton
	closepokepic
	setmonval DRATINI
	special SpecialSeenMon
	end

.DratiniText:
	text "Name: Dratini"

	para "Es lauert unter"
	line "Wasser, während"
	cont "sich seine Lebens-"
	cont "energie aufbaut."
	done

FuchsiaCityZooKangaskhanSign:
	showtext .KangaskhanText
	reanchormap
	pokepic KANGASKHAN
	cry KANGASKHAN
	waitbutton
	closepokepic
	setmonval KANGASKHAN
	special SpecialSeenMon
	end

.KangaskhanText:
	text "Name: Kangama"

	para "Das Junge in sei-"
	line "nem Beutel zieht"

	para "nach etwa drei"
	line "Jahren aus."
	done

FuchsiaCityZooTaurosSign:
	readvar VAR_TIMEOFDAY
	ifequalfwd MORN, .Fire
	ifequalfwd EVE, .Fighting
	ifequalfwd NITE, .Water
	showtext .TaurosText
	reanchormap
	pokepic TAUROS
	cry TAUROS
	waitbutton
	closepokepic
	setmonval TAUROS
	special SpecialSeenMon
	end

.Fire:
	showtext .TaurosText
	reanchormap
	pokepic TAUROS, TAUROS_PALDEAN_FIRE_FORM
	cry TAUROS, TAUROS_PALDEAN_FIRE_FORM
	waitbutton
	closepokepic
	setmonval TAUROS, TAUROS_PALDEAN_FIRE_FORM
	special SpecialSeenMon
	end

.Fighting:
	showtext .TaurosText
	reanchormap
	pokepic TAUROS, PALDEAN_FORM
	cry TAUROS, PALDEAN_FORM
	waitbutton
	closepokepic
	setmonval TAUROS, PALDEAN_FORM
	special SpecialSeenMon
	end

.Water:
	showtext .TaurosText
	reanchormap
	pokepic TAUROS, TAUROS_PALDEAN_WATER_FORM
	cry TAUROS, TAUROS_PALDEAN_WATER_FORM
	waitbutton
	closepokepic
	setmonval TAUROS, TAUROS_PALDEAN_WATER_FORM
	special SpecialSeenMon
	end

.TaurosText:
	text "Name: Tauros"

	para "Aus diesem wilden"
	line "Stier wurden viele"

	para "verschiedene"
	line "Rassen gezüchtet."
	done

FuchsiaCityZooChanseySign:
	showtext .ChanseyText
	reanchormap
	pokepic CHANSEY
	cry CHANSEY
	waitbutton
	closepokepic
	setmonval CHANSEY
	special SpecialSeenMon
	end

.ChanseyText:
	text "Name: Chaneira"

	para "Es läuft vorsich-"
	line "tig, damit sein Ei"
	cont "nicht zerbricht."

	para "Wenn es flieht,"
	line "ist es aber"
	cont "extrem schnell."
	done

FuchsiaCityZooSlowpokeSign:
	showtext .SlowpokeText
	reanchormap
	pokepic SLOWPOKE
	cry SLOWPOKE
	waitbutton
	closepokepic
	setmonval SLOWPOKE
	special SpecialSeenMon
	end

.SlowpokeText:
	text "Name: Flegmon"

	para "Es faulenzt gern"
	line "herum, ohne sich"

	para "um die Zeit zu"
	line "kümmern."
	done

FuchsiaCityZooLaprasSign:
	showtext .LaprasText
	reanchormap
	pokepic LAPRAS
	cry LAPRAS
	waitbutton
	closepokepic
	setmonval LAPRAS
	special SpecialSeenMon
	end

.LaprasText:
	text "Name: Lapras"

	para "Dieser “König der"
	line "Meere” versteht"

	para "die menschliche"
	line "Sprache und ist"
	cont "sehr intelligent."
	done

FuchsiaCityCarefulSwimmingSignText:
	text "Sei auf der Hut,"
	line "wenn du zu den"
	cont "Seeschauminseln"
	cont "schwimmst."

	para "Ordnungsamt von"
	line "Fuchsania City"
	done
