RuinsOfAlphOutside_MapScriptHeader:
	def_scene_scripts
	scene_script RuinsOfAlphOutsideOpenSinjohChamberScene, SCENE_RUINSOFALPHOUTSIDE_OPEN_SINJOH_CHAMBER
	scene_const SCENE_RUINSOFALPHOUTSIDE_GET_UNOWN_DEX

	def_callbacks
	callback MAPCALLBACK_TILES, RuinsofAlphOutsideTileScript
	callback MAPCALLBACK_OBJECTS, RuinsOfAlphOutsideScientistCallback

	def_warp_events
	warp_event 11, 17, RUINS_OF_ALPH_HO_OH_CHAMBER, 1
	warp_event 19,  5, RUINS_OF_ALPH_KABUTO_CHAMBER, 1
	warp_event 11, 29, RUINS_OF_ALPH_OMANYTE_CHAMBER, 1
	warp_event 19, 31, RUINS_OF_ALPH_AERODACTYL_CHAMBER, 1
	warp_event 15, 18, RUINS_OF_ALPH_ENTRANCE_CHAMBER, 1
	warp_event 16, 18, RUINS_OF_ALPH_ENTRANCE_CHAMBER, 2
	warp_event 23, 17, RUINS_OF_ALPH_RESEARCH_CENTER, 1
	warp_event  6, 17, UNION_CAVE_B1F_NORTH, 1
	warp_event  6, 29, UNION_CAVE_B1F_NORTH, 2
	warp_event 15,  1, ROUTE_36_RUINS_OF_ALPH_GATE, 3
	warp_event 27, 22, ROUTE_32_RUINS_OF_ALPH_GATE, 1
	warp_event 27, 23, ROUTE_32_RUINS_OF_ALPH_GATE, 2
	warp_event 11, 11, RUINS_OF_ALPH_SINJOH_CHAMBER, 1
	warp_event 27, 36, HIDDEN_CAVE_GROTTO, 1

	def_coord_events
	coord_event 15, 20, SCENE_RUINSOFALPHOUTSIDE_GET_UNOWN_DEX, RuinsOfAlphOutsideScientistScene

	def_bg_events
	bg_event 20, 12, BGEVENT_JUMPTEXT, RuinsOfAlphOutsideMysteryChamberSignText
	bg_event 14, 19, BGEVENT_JUMPTEXT, RuinsOfAlphOutsideMysteriousHallSignText
	bg_event 13,  5, BGEVENT_JUMPTEXT, RuinsOfAlphSignText
	bg_event 25, 21, BGEVENT_JUMPTEXT, RuinsOfAlphSignText
	bg_event 22, 18, BGEVENT_JUMPTEXT, RuinsOfAlphResearchCenterSignText
	bg_event 25, 11, BGEVENT_JUMPTEXT, RuinsOfAlphAdvancedTipsSignText
	bg_event 11, 11, BGEVENT_IFNOTSET, MapRuinsofAlphOutsideSealedCaveSign
	bg_event  8,  3, BGEVENT_ITEM + RARE_CANDY, EVENT_RUINS_OF_ALPH_OUTSIDE_HIDDEN_RARE_CANDY
	bg_event  9, 34, BGEVENT_ITEM + NUGGET, EVENT_RUINS_OF_ALPH_OUTSIDE_HIDDEN_NUGGET
	bg_event 19, 23, BGEVENT_ITEM + BIG_MUSHROOM, EVENT_RUINS_OF_ALPH_OUTSIDE_HIDDEN_BIG_MUSHROOM
	bg_event 27, 35, BGEVENT_JUMPSTD, cavegrotto, HIDDENGROTTO_RUINS_OF_ALPH

	def_object_events
	object_event 16, 20, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphOutsideScientistScript, EVENT_RUINS_OF_ALPH_OUTSIDE_SCIENTIST
	object_event 23, 19, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RUINS_OF_ALPH_OUTSIDE_SCIENTIST_CLIMAX
	object_event  9, 18, SPRITE_PSYCHIC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerPsychicNathan, -1
	object_event  9, 33, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSuperNerdStan, -1
	object_event 14, 23, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphOutsideFisherScript, EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_FISHER
	object_event 17, 10, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphOutsideYoungster2Script, EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	object_event 19, 21, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphOutsideYoungster1Script, EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	itemball_event  6,  9, HYPER_POTION, 1, EVENT_RUINS_OF_ALPH_OUTSIDE_HYPER_POTION
	smashrock_event  4,  4
	smashrock_event  4,  9
	smashrock_event  5,  8
	smashrock_event  9,  3
	smashrock_event 10,  2
	smashrock_event 12,  3

	object_const_def
	const RUINSOFALPHOUTSIDE_SCIENTIST1
	const RUINSOFALPHOUTSIDE_SCIENTIST2

RuinsOfAlphOutsideOpenSinjohChamberScene:
	checkevent EVENT_DO_RUINS_OF_ALPH_CLIMAX
	iffalsefwd .End
	sdefer RuinsOfAlphOutsideOpenSinjohChamberScript
.End
	end

RuinsOfAlphOutsideOpenSinjohChamberScript:
	showtext RuinsofAlphScientistClimax1Text
	follow RUINSOFALPHOUTSIDE_SCIENTIST2, PLAYER
	applymovement RUINSOFALPHOUTSIDE_SCIENTIST2, RuinsofAlphScientistClimaxApproachMovementData
	stopfollow
	showemote EMOTE_SHOCK, RUINSOFALPHOUTSIDE_SCIENTIST2, 15
	turnobject RUINSOFALPHOUTSIDE_SCIENTIST2, RIGHT
	showtext RuinsofAlphScientistClimax2Text
	applymovement RUINSOFALPHOUTSIDE_SCIENTIST2, RuinsofAlphScientistClimaxLeaveMovementData
	disappear RUINSOFALPHOUTSIDE_SCIENTIST2
	clearevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	clearevent EVENT_DO_RUINS_OF_ALPH_CLIMAX
	setevent EVENT_RUINS_OF_ALPH_CLIMAX_DONE
	end

RuinsofAlphOutsideTileScript:
	checkevent EVENT_DOOR_OPENED_IN_RUINS_OF_ALPH
	iffalsefwd .locked
	changeblock 10, 10, $2b
.locked
	endcallback

RuinsOfAlphOutsideScientistCallback:
	checkflag ENGINE_UNOWN_DEX
	iftruefwd .NoScientist
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftruefwd .MaybeScientist
	sjumpfwd .NoScientist

.MaybeScientist:
	readvar VAR_UNOWNCOUNT
	ifgreater $0, .YesScientist
	sjumpfwd .NoScientist

.YesScientist:
	appear RUINSOFALPHOUTSIDE_SCIENTIST1
	setscene SCENE_RUINSOFALPHOUTSIDE_GET_UNOWN_DEX
	endcallback

.NoScientist:
	disappear RUINSOFALPHOUTSIDE_SCIENTIST1
	setscene SCENE_RUINSOFALPHOUTSIDE_OPEN_SINJOH_CHAMBER
	endcallback

RuinsOfAlphOutsideScientistScene:
RuinsOfAlphOutsideScientistScript:
	faceobject RUINSOFALPHOUTSIDE_SCIENTIST1, PLAYER
	faceobject PLAYER, RUINSOFALPHOUTSIDE_SCIENTIST1
	showtext RuinsOfAlphOutsideScientistText
	playmusic MUSIC_SHOW_ME_AROUND
	follow RUINSOFALPHOUTSIDE_SCIENTIST1, PLAYER
	applymovement RUINSOFALPHOUTSIDE_SCIENTIST1, RuinsOfAlphOutsideScientistWalkToLabMovement
	disappear RUINSOFALPHOUTSIDE_SCIENTIST1
	stopfollow
	applyonemovement PLAYER, step_up
	setmapscene RUINS_OF_ALPH_RESEARCH_CENTER, SCENE_RUINSOFALPHRESEARCHCENTER_GET_UNOWN_DEX
	warpcheck
	end

RuinsOfAlphOutsideFisherScript:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_RUINS_COWARD
	iftrue_jumpopenedtext RuinsOfAlphOutsideFisherText2
	setevent EVENT_TALKED_TO_RUINS_COWARD
	writetext RuinsOfAlphOutsideFisherText1
	promptbutton
	jumpthisopenedtext

RuinsOfAlphOutsideFisherText2:
	text "Den Ruinen wohnt"
	line "ein großes"
	cont "Geheimnis inne!"

	para "…Ich denke…"
	done

RuinsOfAlphOutsideYoungster1Script:
	jumpthistextfaceplayer

	text "Es gibt viele un-"
	line "terschiedliche"

	para "Icognito, die wir"
	line "für unsere Geheim-"
	cont "codes benötigen."
	done

RuinsOfAlphOutsideYoungster2Script:
	showtextfaceplayer RuinsOfAlphOutsideYoungster2Text
	turnobject LAST_TALKED, RIGHT
	end

GenericTrainerPsychicNathan:
	generictrainer PSYCHIC_T, NATHAN, EVENT_BEAT_PSYCHIC_NATHAN, PsychicNathanSeenText, PsychicNathanBeatenText

	text "Ich komme oft"
	line "hierher, um nach-"
	cont "zudenken."
	done

GenericTrainerSuperNerdStan:
	generictrainer SUPER_NERD, STAN, EVENT_BEAT_SUPER_NERD_STAN, SuperNerdStanSeenText, SuperNerdStanBeatenText

	text "Die Ruinen"
	line "sind ungefähr"
	cont "1500 Jahre alt."

	para "Niemand weiß,"
	line "wer sie erbaute."

	para "Die Bedeutung der "
	line "#mon-Statuen"
	cont "ist auch noch"
	cont "nicht geklärt."

	para "Das Ganze ist ein"
	line "großes Rätsel…"
	done

RuinsOfAlphOutsideScientistWalkToLabMovement:
rept 7
	step_right
endr
rept 3
	step_up
endr
	step_end

RuinsofAlphScientistClimaxApproachMovementData:
	step_down
rept 4
	step_left
endr
rept 7
	step_up
endr
rept 8
	step_left
endr
	turn_head_up
	step_end

RuinsofAlphScientistClimaxLeaveMovementData:
	step_up
rept 7
	step_right
endr
	step_end

RuinsOfAlphOutsideScientistText:
	text "Hm? Das ist doch"
	line "ein #dex, nicht"
	cont "wahr? Darf ich"
	cont "ihn sehen?"

	para "Es gibt so viele"
	line "unterschiedliche"
	cont "#mon."

	para "Hm? Was ist das?"

	para "Was ist das für"
	line "ein #mon?"

	para "Es sieht aus wie"
	line "die merkwürdigen"

	para "Zeichen an den"
	line "Wänden in den"
	cont "Ruinen."

	para "Falls diese Zei-"
	line "chen tatsächlich "
	cont "#mon sind, dann"
	cont "gibt es noch"
	cont "viel mehr davon."

	para "Ich weiß! Lass"
	line "mich deinen #-"
	cont "dex erweitern."
	cont "Mir nach!"
	done

SuperNerdStanSeenText:
	text "Was willst du?"
	line "Ich lerne--"
	cont "stör mich nicht!"
	done

SuperNerdStanBeatenText:
	text "Entschuldigung…"
	line "Unser Mangel an"

	para "Verständnis"
	line "frustriert mich…"
	done

PsychicNathanSeenText:
	text "Hm… Dies ist ein"
	line "merkwürdiger Ort."
	done

PsychicNathanBeatenText: ; text > text
	text "…"
	done

RuinsOfAlphOutsideMysteryChamberSignText:
	text "Rätselstein"
	line "Puzzlekammer"
	done

RuinsOfAlphOutsideMysteriousHallSignText:
	text "Mysteriöse Halle"

	para "Pass auf, wo du"
	line "hintrittst!"
	done

RuinsOfAlphSignText:
	text "Alph-Ruinen"
	line "Fremde willkommen!"
	done

RuinsOfAlphResearchCenterSignText:
	text "Alph-Ruinen"
	line "Forschungszentrum"

	para "Die Autorität in"
	line "Sachen Alph-Ruinen"
	done

RuinsOfAlphAdvancedTipsSignText:
	text "Tipps für Profis!"

	para "Der #dex ist"
	line "ein mächtiges"
	cont "Werkzeug!"

	para "Seine Gebietskarte"
	line "zeigt ein gelbes"

	para "Symbol, wenn ein"
	line "#mon genau da"
	cont "vorkommt, wo du"
	cont "gerade bist!"
	done

MapRuinsofAlphOutsideSealedCaveSign:
	dw EVENT_DOOR_OPENED_IN_RUINS_OF_ALPH
	jumpthistext

	text "There's a door-"
	line "shaped groove in"
	cont "the rock."
	done

RuinsOfAlphOutsideFisherText1:
	text "Beim Erkunden der"
	line "Ruinen haben wir"

	para "plötzlich eine"
	line "seltsame Gegenwart"
	cont "gespürt."

	para "Alle hatten Angst"
	line "und liefen davon."

	para "Du solltest auch"
	line "vorsichtig sein."
	done


RuinsOfAlphOutsideYoungster2Text:
	text "V… O… R… A… U… S…"
	line "Hmm…"

	para "Wie?"

	para "Ich dechiffriere"
	line "diese Nachricht!"
	done

RuinsofAlphScientistClimax1Text:
	text "That sounded like"
	line "it came from over"
	cont "here…"
	done

RuinsofAlphScientistClimax2Text:
	text "Incredible!"

	para "Another chamber"
	line "was hidden here"
	cont "all this time!"

	para "We could spend"
	line "years studying it!"

	para "…Although, that"
	line "was quite a loud"
	cont "earthquake."

	para "Could another"
	line "chamber have"

	para "opened up far"
	line "away from here?"

	para "I must go tell"
	line "my colleagues"
	cont "about this!"
	done
