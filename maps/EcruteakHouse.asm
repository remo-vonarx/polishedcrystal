EcruteakHouse_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_ECRUTEAKHOUSE_SAGE_BLOCKS
	scene_const SCENE_ECRUTEAKHOUSE_NOOP

	def_callbacks
	callback MAPCALLBACK_OBJECTS, EcruteakHouseInitializeSages

	def_warp_events
	warp_event  4, 17, ECRUTEAK_CITY, 3
	warp_event  5, 17, ECRUTEAK_CITY, 3
	warp_event  5,  3, ECRUTEAK_HOUSE, 4
	warp_event 17, 15, ECRUTEAK_HOUSE, 3
	warp_event 17,  3, WISE_TRIOS_ROOM, 3

	def_coord_events
	coord_event  4,  7, SCENE_ECRUTEAKHOUSE_SAGE_BLOCKS, EcruteakHouse_XYTrigger1
	coord_event  5,  7, SCENE_ECRUTEAKHOUSE_SAGE_BLOCKS, EcruteakHouse_XYTrigger2

	def_bg_events

	def_object_events
	object_event  4,  6, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakTinTowerEntranceSageScript, EVENT_RANG_CLEAR_BELL_1
	object_event  5,  6, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakTinTowerEntranceSageScript, EVENT_RANG_CLEAR_BELL_2
	object_event  6,  9, SPRITE_SAGE, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakTinTowerEntranceWanderingSageScript, EVENT_ECRUTEAK_HOUSE_WANDERING_SAGE
	object_event  3, 11, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakTinTowerEntranceGrampsText, EVENT_ECRUTEAK_HOUSE_WANDERING_SAGE

	object_const_def
	const ECRUTEAKHOUSE_SAGE1
	const ECRUTEAKHOUSE_SAGE2

EcruteakHouseInitializeSages:
	checkevent EVENT_FOUGHT_SUICUNE
	iftruefwd .DontBlockTower
	checkevent EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER
	iftruefwd .DontBlockTower
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftruefwd .BlockTower
	endcallback

.BlockTower:
	clearevent EVENT_RANG_CLEAR_BELL_1
	setevent EVENT_RANG_CLEAR_BELL_2
	setevent EVENT_ECRUTEAK_HOUSE_WANDERING_SAGE
	checkkeyitem CLEAR_BELL
	iftruefwd .NoClearBell
	setscene SCENE_ECRUTEAKHOUSE_SAGE_BLOCKS
.NoClearBell:
	endcallback

.DontBlockTower:
	clearevent EVENT_ECRUTEAK_HOUSE_WANDERING_SAGE
	endcallback

EcruteakHouse_XYTrigger1:
	checkevent EVENT_RANG_CLEAR_BELL_2
	iftruefwd EcruteakHouse_XYTrigger_DontMove
	applymovement ECRUTEAKHOUSE_SAGE2, EcruteakTinTowerEntranceSageBlocksLeftMovement
	moveobject ECRUTEAKHOUSE_SAGE1, 4, 6
	appear ECRUTEAKHOUSE_SAGE1
	pause 5
	callasm UpdateSprites
	disappear ECRUTEAKHOUSE_SAGE2
	end

EcruteakHouse_XYTrigger2:
	checkevent EVENT_RANG_CLEAR_BELL_1
	iftruefwd EcruteakHouse_XYTrigger_DontMove
	applymovement ECRUTEAKHOUSE_SAGE1, EcruteakTinTowerEntranceSageBlocksRightMovement
	moveobject ECRUTEAKHOUSE_SAGE2, 5, 6
	appear ECRUTEAKHOUSE_SAGE2
	pause 5
	callasm UpdateSprites
	disappear ECRUTEAKHOUSE_SAGE1
EcruteakHouse_XYTrigger_DontMove:
	end

EcruteakTinTowerEntranceSageScript:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftruefwd .CheckForClearBell
	checkflag ENGINE_FOGBADGE
	iftrue_jumpopenedtext EcruteakTinTowerEntranceSageText_GotFogBadge
	jumpthisopenedtext

	text "Wenn du nicht im"
	line "Besitz des ORDENs"

	para "von Teak City"
	line "bist, darfst du"

	para "den Glockenturm"
	line "nicht betreten."
	done

.CheckForClearBell:
	checkevent EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER
	iftrue_jumpopenedtext EcruteakTinTowerEntranceSageText_PleaseDoGoOn
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue_jumpopenedtext EcruteakTinTowerEntranceSageText_HeardClearBell
	checkkeyitem CLEAR_BELL
	iftruefwd .RingClearBell
	jumpthisopenedtext

	text "Ein denkwürdiger"
	line "Augenblick."

	para "Entschuldigung,"
	line "aber ich muss dich"
	cont "bitten zu gehen."

	para "…Was lindert"
	line "Seelenschmerzen…"

	para "Das Trio der"
	line "Weisen sagt stets"

	para "Dinge, die sehr"
	line "schwierig zu ver-"
	cont "stehen sind…"
	done

.RingClearBell:
	writetext EcruteakTinTowerEntranceSageText_HearsClearBell
	waitbutton
	closetext
	setscene SCENE_ECRUTEAKHOUSE_NOOP
	setevent EVENT_RANG_CLEAR_BELL_2
	clearevent EVENT_RANG_CLEAR_BELL_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	end

EcruteakTinTowerEntranceWanderingSageScript:
	checkevent EVENT_GOT_CLEAR_BELL
	iftrue_jumptextfaceplayer EcruteakTinTowerEntranceWanderingSageText_GotClearBell
	jumpthistextfaceplayer

	text "Der Glockenturm da"
	line "vorne ist ein"

	para "8-stöckiger Turm"
	line "von göttlicher"
	cont "Schönheit."

	para "Er beruhigt die"
	line "Seelen derer, die"
	cont "ihn betrachten."
	done

EcruteakTinTowerEntranceSageBlocksLeftMovement:
	fix_facing
	run_step_left
	remove_fixed_facing
	turn_head_down
	step_end

EcruteakTinTowerEntranceSageBlocksRightMovement:
	fix_facing
	run_step_right
	remove_fixed_facing
	turn_head_down
	step_end


EcruteakTinTowerEntranceSageText_GotFogBadge:
	text "Wenn du nicht im"
	line "Besitz des ORDENs"

	para "von Teak City"
	line "bist, darfst du"

	para "den Glockenturm"
	line "nicht betreten."
	cont "Ah!"

	para "Das ist der Orden"
	line "von Teak City! Du"
	cont "darfst passieren."
	done


EcruteakTinTowerEntranceSageText_HearsClearBell:
	text "Ein denkwürdiger"
	line "Augenblick."

	para "Entschuldigung,"
	line "aber ich muss dich"
	cont "bitten zu gehen."

	para "………………"

	para "Ah!"

	para "Das Läuten der"
	line "Klarglocke!"

	para "Es… ist erhaben!"

	para "Das schönste Läu-"
	line "ten, das ich je"
	cont "hörte!"

	para "Dieser Ton sagt"
	line "alles über die"
	cont "Seele des Trägers"
	cont "aus."

	para "Du…"

	para "Du könntest es"
	line "durch den"
	cont "Glockenturm"
	cont "schaffen."

	para "Schreite voran."
	done

EcruteakTinTowerEntranceSageText_PleaseDoGoOn:
	text "Schreite voran."
	done

EcruteakTinTowerEntranceSageText_HeardClearBell:
	text "Dieser Ton sagt"
	line "alles über die"
	cont "Seele des Trägers"
	cont "aus."

	para "Du…"

	para "Du könntest es"
	line "durch den"
	cont "Glockenturm"
	cont "schaffen."

	para "Schreite voran."
	done


EcruteakTinTowerEntranceWanderingSageText_GotClearBell:
	text "Der Glockenturm"
	line "bebt! Ein #mon"
	cont "muss"

	para "auf der Spitze ge-"
	line "landet sein!"
	done

EcruteakTinTowerEntranceGrampsText:
	text "Zwei Türme…"
	line "Zwei #mon…"

	para "Aber als einer"
	line "niederbrannte,"

	para "flogen beide #-"
	line "mon fort und kamen"
	cont "nie wieder zurück."
	done
