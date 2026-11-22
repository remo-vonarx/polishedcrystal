Route29_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_ROUTE29_NOOP
	scene_const SCENE_ROUTE29_CATCH_TUTORIAL

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route29Tuscany

	def_warp_events
	warp_event 27,  1, ROUTE_29_46_GATE, 3

	def_coord_events
	coord_event 53,  8, SCENE_ROUTE29_CATCH_TUTORIAL, Route29Tutorial1
	coord_event 53,  9, SCENE_ROUTE29_CATCH_TUTORIAL, Route29Tutorial2

	def_bg_events
	bg_event 51,  7, BGEVENT_JUMPTEXT, Route29Sign1Text
	bg_event  3,  5, BGEVENT_JUMPTEXT, Route29Sign2Text
	bg_event 23,  4, BGEVENT_JUMPTEXT, Route29AdvancedTipsSignText

	def_object_events
	object_event 50, 12, SPRITE_LYRA, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LYRA_ROUTE_29
	object_event 29, 12, SPRITE_POKEFAN_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, TuscanyScript, EVENT_ROUTE_29_TUSCANY_OF_TUESDAY
	object_event 27, 16, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route29YoungsterText, -1
	object_event 15, 11, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route29TeacherText, -1
	cuttree_event 30,  9, EVENT_ROUTE_29_CUT_TREE_1
	cuttree_event 21, 11, EVENT_ROUTE_29_CUT_TREE_2
	fruittree_event 12,  2, FRUITTREE_ROUTE_29, ORAN_BERRY, PAL_NPC_BLUE
	object_event 25,  3, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route29FisherText, -1
	object_event 13,  4, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route29CooltrainerMScript, -1
	itemball_event 48,  2, POTION, 1, EVENT_ROUTE_29_POTION

	object_const_def
	const ROUTE29_LYRA
	const ROUTE29_TUSCANY

Route29Tuscany:
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iffalsefwd .TuscanyDisappears
	readvar VAR_WEEKDAY
	ifequalfwd TUESDAY, .TuscanyAppears
.TuscanyDisappears:
	disappear ROUTE29_TUSCANY
	endcallback

.TuscanyAppears
	appear ROUTE29_TUSCANY
	endcallback

Route29Tutorial1:
	turnobject ROUTE29_LYRA, UP
	showemote EMOTE_SHOCK, ROUTE29_LYRA, 15
	special Special_FadeOutMusic
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	pause 15
	applymovement ROUTE29_LYRA, LyraMovementData1a
	turnobject PLAYER, LEFT
	opentext
	writetext CatchingTutorialIntroText
	yesorno
	iffalsefwd Route29RefusedTutorial
	closetext
	follow ROUTE29_LYRA, PLAYER
	applymovement ROUTE29_LYRA, LyraMovementData1b
	sjumpfwd Route29TutorialScript

Route29Tutorial2:
	turnobject ROUTE29_LYRA, UP
	showemote EMOTE_SHOCK, ROUTE29_LYRA, 15
	special Special_FadeOutMusic
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	pause 15
	applymovement ROUTE29_LYRA, LyraMovementData2a
	turnobject PLAYER, LEFT
	opentext
	writetext CatchingTutorialIntroText
	yesorno
	iffalsefwd Route29RefusedTutorial
	closetext
	follow ROUTE29_LYRA, PLAYER
	applymovement ROUTE29_LYRA, LyraMovementData2b
Route29TutorialScript:
	stopfollow
	loadwildmon PIDGEY, 5
	catchtutorial BATTLETYPE_TUTORIAL
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	turnobject ROUTE29_LYRA, UP
	opentext
	writetext CatchingTutorialDebriefText
Route29FinishTutorial:
	promptbutton
	; Finish the tutorial even if the Bag cannot fit the bonus balls.
	verbosegiveitems_unsafe POKE_BALL, 5
	writetext CatchingTutorialGoodbyeText
	waitbutton
	closetext
	applymovement ROUTE29_LYRA, LyraMovementData3
	disappear ROUTE29_LYRA
	setscene SCENE_ROUTE29_NOOP
	setevent EVENT_LEARNED_TO_CATCH_POKEMON
	playmusic MUSIC_ROUTE_29
	end

Route29RefusedTutorial:
	setevent EVENT_NEVER_LEARNED_TO_CATCH_POKEMON
	writetext CatchingTutorialRefusedText
	sjump Route29FinishTutorial

Route29CooltrainerMScript:
	checktime (1 << EVE) | (1 << NITE)
	iftrue_jumptextfaceplayer Text_WaitingForMorning
	jumpthistextfaceplayer

	text "Ich warte auf"
	line "#mon, die"

	para "nur abends oder"
	line "des Nachts"
	cont "auftauchen."
	done

TuscanyScript:
	checkevent EVENT_GOT_SILK_SCARF_FROM_TUSCANY
	iftrue_jumptextfaceplayer TuscanyTuesdayText
	faceplayer
	opentext
	readvar VAR_WEEKDAY
	ifnotequal TUESDAY, TuscanyNotTuesdayScript
	checkevent EVENT_MET_TUSCANY_OF_TUESDAY
	iftruefwd .MetTuscany
	writetext MeetTuscanyText
	promptbutton
	setevent EVENT_MET_TUSCANY_OF_TUESDAY
.MetTuscany:
	writetext TuscanyGivesGiftText
	promptbutton
	verbosegiveitem SILK_SCARF, iffalse_endtext
	setevent EVENT_GOT_SILK_SCARF_FROM_TUSCANY
	jumpthisopenedtext

	text "Dietlinde: Findest"
	line "du nicht auch,"
	cont "dass er sehr"
	cont "schön ist?"

	para "Attacken der"
	line "Elementklasse"
	cont "Normal, werden"
	cont "dadurch stärker."

	para "Ich bin sicher,"
	line "du kannst ihn"
	cont "gebrauchen."
	done

TuscanyNotTuesdayScript:
	jumpthisopenedtext

	text "Dietlinde: Heute"
	line "ist nicht Diens-"
	cont "tag. Das ist"
	cont "schade…"
	done

LyraMovementData1a:
	step_up
LyraMovementData2a:
	step_up
	step_up
	step_up
	step_right
	step_right
	step_end

LyraMovementData1b:
	step_left
	step_left
	step_down
	step_down
	step_down
	step_down
	step_end

LyraMovementData2b:
	step_left
	step_left
	step_down
	step_down
	step_down
	step_end

LyraMovementData3:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

CatchingTutorialIntroText:
	text "Lyra: <PLAYER>!"

	para "Mit #bällen"
	line "kannst du wilde"
	cont "#mon fangen."

	para "Folge mir, ich"
	line "zeige es dir!"
	done

CatchingTutorialDebriefText:
	text "Lyra: So geht das!"

	para "Wenn du sie zuerst"
	line "schwächst, kannst"
	cont "du sie leichter"
	cont "fangen."

	para "Ich gebe dir die"
	line "hier. Viel Glück!"
	done

CatchingTutorialRefusedText:
	text "Och… Ich wollte"
	line "doch ein bisschen"
	cont "mit meinem Fang-"
	cont "geschick angeben…"

	para "Egal, ich gebe dir"
	line "die hier."
	cont "Viel Glück!"
	done

CatchingTutorialGoodbyeText:
	text "Lyra: Bis dann!"
	done

Route29YoungsterText:
	text "Yo. Wie geht es"
	line "deinen #mon?"

	para "Sind sie schwach"
	line "und nicht bereit"

	para "zu kämpfen, halte"
	line "dich vom Gras"
	cont "fern."
	done

Route29TeacherText:
	text "Siehst du die"
	line "Stufen hier?"

	para "Du kannst nicht"
	line "hinaufklettern,"
	cont "dafür aber"
	cont "herunterspringen!"

	para "Du kannst nach"
	line "Neuborkia gehen,"

	para "ohne durch das"
	line "Gras zu laufen."
	done

Route29FisherText:
	text "Ich wollte eine"
	line "Pause einlegen,"

	para "darum habe ich"
	line "meinen Spielstand"
	cont "abgespeichert."
	done


Text_WaitingForMorning:
	text "Ich warte auf"
	line "#mon, die"

	para "nur am Vormittag"
	line "auftauchen."
	done

MeetTuscanyText:
	text "Dietlinde: Ich"
	line "glaube, wir"

	para "begegnen uns zum"
	line "ersten Mal!"

	para "Darf ich mich"
	line "vorstellen? Ich"

	para "bin Dietlinde"
	line "von Dienstag."
	done

TuscanyGivesGiftText:
	text "Da wir uns zum"
	line "ersten Mal sehen,"

	para "schenke ich dir"
	line "einen Seidenschal."
	done


TuscanyTuesdayText:
	text "Dietlinde: Bist"
	line "du Monja meiner"
	cont "älteren Schwester"
	cont "schon begegnet?"

	para "Oder meinem"
	line "kleinen Bruder"
	cont "Mitko?"

	para "Ich bin das zweite"
	line "von sieben"
	cont "Kindern."
	done


Route29Sign1Text:
	text "Route 29"

	para "Neuborkia -"
	line "Rosalia City"
	done

Route29Sign2Text:
	text "Route 29"

	para "Rosalia City -"
	line "Neuborkia"
	done

Route29AdvancedTipsSignText:
	text "Profi-Tipps!"

	para "Drücke Unten+B im"
	line "Titelbildschirm,"

	para "um die Uhr zurück-"
	line "zusetzen!"

	para "Drücke Links+B, um"
	line "die Startoptionen"
	cont "zurückzusetzen!"
	done
