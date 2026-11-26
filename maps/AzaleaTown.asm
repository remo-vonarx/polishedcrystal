AzaleaTown_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_AZALEATOWN_NOOP
	scene_const SCENE_AZALEATOWN_RIVAL_BATTLE
	scene_const SCENE_AZALEATOWN_CELEBI_EVENT

	def_callbacks
	callback MAPCALLBACK_NEWMAP, AzaleaTownFlypointCallback
	callback MAPCALLBACK_TILES, AzaleaTownRainScript

	def_warp_events
	warp_event 15,  9, AZALEA_POKECENTER_1F, 1
	warp_event 21, 13, CHARCOAL_KILN, 1
	warp_event 21,  5, AZALEA_MART, 2
	warp_event  9,  5, KURTS_HOUSE, 1
	warp_event 10, 15, AZALEA_GYM, 1
	warp_event 31,  7, SLOWPOKE_WELL_ENTRANCE, 1
	warp_event  2, 10, ILEX_FOREST_AZALEA_GATE, 3
	warp_event  2, 11, ILEX_FOREST_AZALEA_GATE, 4

	def_coord_events
	coord_event  5, 10, SCENE_AZALEATOWN_RIVAL_BATTLE, AzaleaTownRivalBattleTrigger1
	coord_event  5, 11, SCENE_AZALEATOWN_RIVAL_BATTLE, AzaleaTownRivalBattleTrigger2
	coord_event  9,  6, SCENE_AZALEATOWN_CELEBI_EVENT, AzaleaTown_CelebiTrigger

	def_bg_events
	bg_event 19,  9, BGEVENT_JUMPTEXT, AzaleaTownSignText
	bg_event 10,  9, BGEVENT_JUMPTEXT, KurtsHouseSignText
	bg_event 11, 15, BGEVENT_JUMPTEXT, AzaleaGymSignText
	bg_event 29,  8, BGEVENT_JUMPTEXT, SlowpokeWellSignText
	bg_event 19, 13, BGEVENT_JUMPTEXT, CharcoalKilnSignText
	bg_event  3,  9, BGEVENT_JUMPTEXT, AzaleaTownIlexForestSignText
	bg_event 29, 14, BGEVENT_JUMPTEXT, AzaleaTownAdvancedTipsSignText
	bg_event 31,  6, BGEVENT_ITEM + FULL_HEAL, EVENT_AZALEA_TOWN_HIDDEN_FULL_HEAL

	def_object_events
	object_event 11, 10, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_AZALEA_TOWN
	object_event  6,  5, SPRITE_KURT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownKurtScript, EVENT_AZALEA_TOWN_KURT
	object_event 21,  9, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 2, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownGrampsScript, -1
	object_event 15, 13, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, AzaleaTownTeacherScript, -1
	object_event  7,  9, SPRITE_CAMPER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaTownYoungsterText, -1
	object_event 31,  9, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaTownRocket1Text, EVENT_AZALEA_TOWN_SLOWPOKETAIL_ROCKET
	object_event 10, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaTownRocket2Text, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event  8, 17, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SLOWPOKE, -1, PAL_MON_PINK, OBJECTTYPE_SCRIPT, PLAIN_FORM, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event 18,  9, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SLOWPOKE, -1, PAL_MON_PINK, OBJECTTYPE_SCRIPT, PLAIN_FORM, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event 30,  9, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SLOWPOKE, -1, PAL_MON_PINK, OBJECTTYPE_SCRIPT, PLAIN_FORM, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event 14, 15, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SLOWPOKE, -1, PAL_MON_PINK, OBJECTTYPE_SCRIPT, PLAIN_FORM, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	pokemon_event 14, 12, WOOPER, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_BLUE, AzaleaTownWoosterText, EVENT_SLOWPOKE_WELL_SLOWPOKES
	pokemon_event 14, 12, QUAGSIRE, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_BLUE, AzaleaTownWoosterText, EVENT_AZALEA_TOWN_SLOWPOKES
	fruittree_event  8,  2, FRUITTREE_AZALEA_TOWN, WHT_APRICORN, PAL_NPC_ENV_WHITE

	object_const_def
	const AZALEATOWN_RIVAL
	const AZALEATOWN_KURT

AzaleaTownFlypointCallback:
	setflag ENGINE_FLYPOINT_AZALEA
	endcallback

AzaleaTownRainScript:
	special Special_GetOvercastIndex
	ifequalfwd AZALEA_OVERCAST, .rain
	changemapblocks AzaleaTown_BlockData
	endcallback

.rain
	changemapblocks AzaleaTownRaining_BlockData
	endcallback

AzaleaTownRivalBattleTrigger1:
	moveobject AZALEATOWN_RIVAL, 11, 11
AzaleaTownRivalBattleTrigger2:
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	appear AZALEATOWN_RIVAL
	applymovement AZALEATOWN_RIVAL, .ApproachMovement
	faceobject AZALEATOWN_RIVAL, PLAYER
	faceobject PLAYER, AZALEATOWN_RIVAL
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext .SeenText
	setevent EVENT_RIVAL_AZALEA_TOWN
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftruefwd .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftruefwd .Chikorita
	winlosstext .WinText, .LossText
	setlasttalked AZALEATOWN_RIVAL
	loadtrainer RIVAL1, RIVAL1_6
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjumpfwd .AfterBattle

.Totodile:
	winlosstext .WinText, .LossText
	setlasttalked AZALEATOWN_RIVAL
	loadtrainer RIVAL1, RIVAL1_4
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjumpfwd .AfterBattle

.Chikorita:
	winlosstext .WinText, .LossText
	setlasttalked AZALEATOWN_RIVAL
	loadtrainer RIVAL1, RIVAL1_5
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	; fallthrough

.AfterBattle:
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	showtext .AfterText
	turnobject PLAYER, LEFT
	applymovement AZALEATOWN_RIVAL, .ExitMovement
	playsound SFX_EXIT_BUILDING
	disappear AZALEATOWN_RIVAL
	setmapscene ROUTE_34, SCENE_ROUTE34_LYRA_DAYCARE
	setscene SCENE_AZALEATOWN_NOOP
	waitsfx
	playmapmusic
	end

.SeenText:
	text "…Sag mir"
	line "etwas."

	para "Ist es wahr, dass"
	line "Team Rocket zu-"
	cont "rückgekehrt ist?"

	para "Was? Du hast sie"
	line "geschlagen? Ha!"
	cont "Hör auf zu lügen!"

	para "Du machst keine"
	line "Witze? Dann lass"
	cont "uns sehen, wie gut"
	cont "du bist!"
	done

.WinText:
	text "…Humph! Useless"
	line "#mon!"

	para "Listen, you. You"
	line "only won because"

	para "my #mon were"
	line "weak."
	done

.LossText:
	text "…Hmpf! Ich wusste,"
	line "dass du lügst."
	done

.AfterText:
	text "Ich hasse"
	line "Schwäche!"

	para "#mon, Trainer."
	line "Es macht keinen"
	cont "Unterschied, wer"
	cont "oder was."

	para "Ich werde stark"
	line "sein und das"
	cont "Schwache aus-"
	cont "löschen!"

	para "Das gilt auch für"
	line "Team Rocket."

	para "Nur gemeinsam sind"
	line "sie stark. Aber"

	para "triffst du auf ei-"
	line "nen allein, ist er"
	cont "schwach."

	para "Ich hasse sie."

	para "Geh mir aus dem"
	line "Weg. Ein Schwäch-"
	cont "ling wie du, ist"

	para "nicht mehr als"
	line "eine Ablenkung."
	done

.ApproachMovement:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

.ExitMovement:
	step_left
	step_left
	step_left
	step_end

AzaleaTown_CelebiTrigger:
	applymovement PLAYER, .WalkOutOfKurtsHouseMovement
	opentext
	writethistext
		text "Im Steineichenwald"
		line "herrscht Unruhe!"
		para "Was ist bloß los?"
		done
	promptbutton
	turnobject AZALEATOWN_KURT, RIGHT
	writethistext
		text "<PLAYER>, hier"
		line "dein GS-Ball!"
		done
	promptbutton
	writetext AzaleaTownKurtText
	waitbutton
	verbosegivekeyitem GS_BALL
	turnobject AZALEATOWN_KURT, LEFT
	setflag ENGINE_HAVE_EXAMINED_GS_BALL
	clearevent EVENT_ILEX_FOREST_LASS
	setevent EVENT_ROUTE_34_ILEX_FOREST_GATE_LASS
	setscene SCENE_AZALEATOWN_NOOP
	endtext

.WalkOutOfKurtsHouseMovement:
	step_left
	step_left
	step_up
	turn_head_left
	step_end

AzaleaTownSignText:
	text "Azalea City"
	line "Hier leben Men-"
	cont "schen und #mon"
	cont "in Harmonie"
	done

KurtsHouseSignText:
	text "Kurts Haus"
	done

AzaleaGymSignText:
	text "PKMN-Arena von"
	line "Azalea City"
	cont "Leitung: Kai"

	para "Die lebende Käfer-"
	line "#mon-Enzyklo-"
	cont "pädie"
	done

SlowpokeWellSignText:
	text "Der Flegmon-Brun-"
	line "nen ist auch be-"
	cont "kannt als Regen-"
	cont "macherquelle."

	para "Die Leute hier"
	line "glauben, dass das"
	cont "Gähnen eines Fleg-"
	cont "mons Regen er-"
	cont "zeugt."

	para "Laut den Aufzeich-"
	line "nungen soll das"

	para "Gähnen eines Fleg-"
	line "mons vor 400 Jah-"
	cont "ren eine Dürre be-"
	cont "endet haben."
	done

CharcoalKilnSignText:
	text "Holzkohle-Ofen"
	done

AzaleaTownIlexForestSignText:
	text "Steineichenwald"

	para "Tritt durch das"
	line "Tor"
	done

AzaleaTownAdvancedTipsSignText:
	text "Tipps für Profis!"

	para "Beim Kampfstil"
	line "“Wechsel” weißt"
	cont "du, welches #-"
	cont "mon der Gegner"
	cont "als Nächstes"
	cont "schickt,"

	para "beim Stil “Ansage”"
	line "aber nicht!"
	done

AzaleaTownGrampsScript:
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iftrue_jumptextfaceplayer .Text2
	jumpthistextfaceplayer

	text "Alle Flegmon sind"
	line "aus der Stadt ver-"
	cont "schwunden…"

	para "Ich hörte, dass"
	line "ihre Ruten ver-"
	cont "kauft werden."
	done

.Text2:
	text "Die Flegmon sind"
	line "zurückgekehrt."

	para "Vermutlich haben"
	line "sie wieder irgend-"
	cont "wo gefaulenzt."
	done

AzaleaTownTeacherScript:
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iffalse_jumptextfaceplayer .Text1
	checkevent EVENT_GOT_CLEAR_AMULET_IN_AZALEA
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text3
	promptbutton
	verbosegiveitem CLEAR_AMULET, iffalse_endtext
	setevent EVENT_GOT_CLEAR_AMULET_IN_AZALEA
	jumpthisopenedtext

.Text2:
	text "He has changed,"
	line "but he'll always be"

	para "my little Wooster"
	line "to me."
	done

.Text1:
	text "It hasn't rained"
	line "since the Slow-"
	cont "poke vanished."

	para "My poor Wooster"
	line "can't thrive in"
	cont "this weather…"
	done

.Text3:
	text "In a sudden down-"
	line "pour, my Wooster"
	cont "evolved!"

	para "Oh? You brought"
	line "the Slowpoke back?"

	para "They brought the"
	line "rain with them!"

	para "Thank you so"
	line "much!"

	para "Please take this,"
	line "you deserve it!"
	done

AzaleaTownWoosterText:
	text "Wooster: Gugyoo…"
	done

AzaleaTownYoungsterText:
	text "Gehe durch Azalea"
	line "City und du lan-"
	cont "dest im Steinei-"
	cont "chenwald."

	para "Aber diese dürren"
	line "Bäume machen es"

	para "unmöglich, weiter-"
	line "zukommen."

	para "Die #mon des"
	line "Köhlers können die"
	cont "Bäume mit dem Zer-"
	cont "schneider fällen."
	done

AzaleaTownRocket1Text:
	text "Es ist gefährlich,"
	line "da hineinzugehen."
	cont "Deshalb stehe ich"
	cont "hier Wache."

	para "Bin ich nicht ein"
	line "barmherziger"
	cont "Samariter?"
	done

AzaleaTownRocket2Text:
	text "Hast du schon mal"
	line "eine Flegmon-Rute"
	cont "probiert? Sie soll"
	cont "sehr lecker sein."

	para "Du bist sicher"
	line "froh, dass ich dir"
	cont "das gesagt habe."
	done

AzaleaTownSlowpokeScript:
	opentext
	writethistext
		text "Flegmon: …"
		para "…… …… ……"
		done
	pause 60
	writethistext
		text "…… ……Gähn?"
		done
	cry SLOWPOKE
	waitendtext

AzaleaTownKurtScript:
	showtextfaceplayer AzaleaTownKurtText
	turnobject LAST_TALKED, LEFT
	end

AzaleaTownKurtText:
	text "Könntest du nach-"
	line "sehen, was im"
	cont "Steineichenwald"
	cont "los ist?"
	done
