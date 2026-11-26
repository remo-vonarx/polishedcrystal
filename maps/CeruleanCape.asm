CeruleanCape_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_CERULEANCAPE_NOOP
	scene_const SCENE_CERULEANCAPE_MISTYS_DATE

	def_callbacks
	callback MAPCALLBACK_NEWMAP, CeruleanCapeFlyPoint

	def_warp_events
	warp_event  9,  5, BILLS_HOUSE, 1
	warp_event 38, 29, DIM_CAVE_2F, 1

	def_coord_events
	coord_event  4,  6, SCENE_CERULEANCAPE_MISTYS_DATE, CeruleanCapeDateInterruptedTrigger1
	coord_event  4,  7, SCENE_CERULEANCAPE_MISTYS_DATE, CeruleanCapeDateInterruptedTrigger2
	coord_event  9, 12, SCENE_CERULEANCAPE_MISTYS_DATE, CeruleanCapeDateInterruptedTrigger3

	def_bg_events
	bg_event  7,  5, BGEVENT_JUMPTEXT, BillsHouseSignText
	bg_event 27, 20, BGEVENT_ITEM + PEARL_STRING, EVENT_CERULEAN_CAPE_HIDDEN_PEARL_STRING
	bg_event 18,  3, BGEVENT_ITEM + BOTTLE_CAP, EVENT_CERULEAN_CAPE_HIDDEN_BOTTLE_CAP

	def_object_events
	object_event  8,  9, SPRITE_MISTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_CERULEAN_CAPE_BOYFRIEND
	object_event  8, 10, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_CERULEAN_CAPE_BOYFRIEND
	object_event 25,  8, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmermRomeo, -1
	object_event 41, 16, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, PAL_NPC_DARK_RED, OBJECTTYPE_TRAINER, 4, TrainerSwimmermMalcolm, -1
	object_event 25, 27, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmermArmand, -1
	object_event 19, 12, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBeautyBridget, -1
	object_event  1, 21, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBeautyVeronica, -1
	object_event  0, 27, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerGentlemanCamus, -1
	object_event 41, 26, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerGentlemanGeoffrey, -1
	object_event 16, 32, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerGuitaristfMorgan, -1
	object_event  7, 26, SPRITE_LADY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerLadyJessica, -1
	object_event 32, 12, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherLeroy, -1
	object_event -4, 8, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_25_COOLTRAINER_M_BEFORE
	object_event -2, 8, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CooltrainermKevinAfterBattleText, EVENT_ROUTE_25_COOLTRAINER_M_AFTER
	object_event 21, 19, SPRITE_SAILBOAT, SPRITEMOVEDATA_SAILBOAT_TOP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptext, CeruleanCapeSailboatText, -1
	object_event 21, 19, SPRITE_SAILBOAT, SPRITEMOVEDATA_SAILBOAT_BOTTOM, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptext, CeruleanCapeSailboatText, -1
	object_event 29, 11, SPRITE_FLOATING_BALL, SPRITEMOVEDATA_POKEMON, 0, 0, -1, 0, OBJECTTYPE_ITEMBALL, PLAYEREVENT_ITEMBALL, SHELL_BELL, 1, EVENT_CERULEAN_CAPE_SHELL_BELL
	object_event  8,  2, SPRITE_LILYPAD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_COPY_BG_BROWN, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 11,  2, SPRITE_LILYPAD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_COPY_BG_BROWN, OBJECTTYPE_COMMAND, end, NULL, -1

	object_const_def
	const CERULEANCAPE_MISTY
	const CERULEANCAPE_BOYFRIEND

CeruleanCapeFlyPoint:
	setflag ENGINE_FLYPOINT_CERULEAN_CAPE
	endcallback

CeruleanCapeDateInterruptedTrigger1:
	showemote EMOTE_HEART, CERULEANCAPE_MISTY, 15
	pause 30
	showemote EMOTE_SHOCK, CERULEANCAPE_BOYFRIEND, 10
	turnobject CERULEANCAPE_MISTY, DOWN
	applyonemovement CERULEANCAPE_BOYFRIEND, big_step_down
	disappear CERULEANCAPE_BOYFRIEND
	pause 15
	playmusic MUSIC_BEAUTY_ENCOUNTER
	turnobject CERULEANCAPE_MISTY, UP
	pause 5
	applymovement CERULEANCAPE_MISTY, Route25MistyApproachesPlayerMovement1
	showtext Route25MistyDateText
	applymovement CERULEANCAPE_MISTY, Route25MistyLeavesPlayerMovement1
	sjumpfwd CeruleanCapeDateFinishScript

CeruleanCapeDateInterruptedTrigger2:
	showemote EMOTE_HEART, CERULEANCAPE_MISTY, 15
	pause 30
	showemote EMOTE_SHOCK, CERULEANCAPE_BOYFRIEND, 10
	turnobject CERULEANCAPE_MISTY, DOWN
	applymovement CERULEANCAPE_BOYFRIEND, Route25MistysDateLeavesMovement2
	disappear CERULEANCAPE_BOYFRIEND
	pause 15
	playmusic MUSIC_BEAUTY_ENCOUNTER
	turnobject CERULEANCAPE_MISTY, UP
	pause 5
	applymovement CERULEANCAPE_MISTY, Route25MistyApproachesPlayerMovement2
	showtext Route25MistyDateText
	applymovement CERULEANCAPE_MISTY, Route25MistyLeavesPlayerMovement2
CeruleanCapeDateFinishScript:
	turnobject PLAYER, LEFT
	applymovement CERULEANCAPE_MISTY, Route25MistyLeavesMovement
	disappear CERULEANCAPE_MISTY
	clearevent EVENT_TRAINERS_IN_CERULEAN_GYM
	setscene SCENE_CERULEANCAPE_NOOP
	special RestartMapMusic
	end

CeruleanCapeDateInterruptedTrigger3:
	showemote EMOTE_HEART, CERULEANCAPE_MISTY, 15
	pause 30
	turnobject CERULEANCAPE_BOYFRIEND, DOWN
	showemote EMOTE_SHOCK, CERULEANCAPE_BOYFRIEND, 10
	turnobject CERULEANCAPE_MISTY, DOWN
	applymovement CERULEANCAPE_BOYFRIEND, .RunAwayMovement1
	turnobject CERULEANCAPE_MISTY, UP
	applymovement CERULEANCAPE_BOYFRIEND, .RunAwayMovement2
	disappear CERULEANCAPE_BOYFRIEND
	pause 15
	playmusic MUSIC_BEAUTY_ENCOUNTER
	turnobject CERULEANCAPE_MISTY, DOWN
	pause 5
	applymovement CERULEANCAPE_MISTY, .ApproachMovement
	showtext Route25MistyDateText
	applymovement CERULEANCAPE_MISTY, .LeaveMovement
	disappear CERULEANCAPE_MISTY
	clearevent EVENT_TRAINERS_IN_CERULEAN_GYM
	setscene SCENE_CERULEANCAPE_NOOP
	special RestartMapMusic
	end

.RunAwayMovement1:
	big_step_right
	big_step_up
	step_end

.RunAwayMovement2:
	big_step_up
	big_step_up
	step_end

.ApproachMovement:
	step_right
	step_down
	step_down
	step_end

.LeaveMovement:
	step_up
	step_up
	step_up
	step_up
	step_end

GenericTrainerSwimmermRomeo:
	generictrainer SWIMMERM, ROMEO, EVENT_BEAT_SWIMMERM_ROMEO, .SeenText, .BeatenText

	text "Als guter"
	line "Schwimmer bin ich"

	para "noch lange kein"
	line "guter Trainer…"
	done

.SeenText:
	text "Bewundere meine"
	line "Fitness! Mein Sieg"
	cont "ist sicher!"
	done

.BeatenText:
	text "Ach, das war es?"
	done

TrainerSwimmermMalcolm:
	trainer SWIMMERM, MALCOLM, EVENT_BEAT_SWIMMERM_MALCOLM, .SeenText, .BeatenText, 0, .Script, TRAINERPAL_DARK_SWIMMERM

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Sag nichts, du"
	line "besuchst viele"

	para "PKMN-Arenen,"
	line "oder?"
	done

.SeenText:
	text "Meine #mon und"
	line "ich schwimmen"

	para "zusammen, aber wir"
	line "kämpfen auch!"
	done

.BeatenText:
	text "Ich wäre gern so"
	line "stark wie du."
	done

GenericTrainerSwimmermArmand:
	generictrainer SWIMMERM, ARMAND, EVENT_BEAT_SWIMMERM_ARMAND, .SeenText, .BeatenText

	text "Das Mädchen am"
	line "Ufer… Ihre Musik"
	cont "ist gut, aber sie"

	para "lenkt die #mon"
	line "ab!"
	done

.SeenText:
	text "Uff. Könnte die"
	line "Gitarristin am"

	para "Ufer mal leiser"
	line "sein?"
	done

.BeatenText:
	text "Die Gitarre hat"
	line "mich aus dem Takt"
	cont "gebracht!"
	done

GenericTrainerBeautyBridget:
	generictrainer BEAUTY, BRIDGET, EVENT_BEAT_BEAUTY_BRIDGET, .SeenText, .BeatenText

	text "Ich finde die"
	line "Aussicht hier"
	cont "wunderschön."

	para "Findest du nicht"
	line "auch?"
	done

.SeenText:
	text "Hey! Du versperrst"
	line "mir die Aussicht!"
	done

.BeatenText:
	text "Ich wollte doch"
	line "nur die Aussicht"
	cont "genießen…"
	done

GenericTrainerBeautyVeronica:
	generictrainer BEAUTY, VERONICA, EVENT_BEAT_BEAUTY_VERONICA, .SeenText, .BeatenText

	text "Sei fies zu mir,"
	line "und ich sag dir,"
	cont "wohin du dich"
	cont "scheren kannst!"

	para "Darum bin ich wohl"
	line "Single. …Haha!"
	done

.SeenText:
	text "Ich habe nicht oft"
	line "ein Date, aber"

	para "wenn, dann ist das"
	line "Kap von Azuria der"
	cont "perfekte Ort."
	done

.BeatenText:
	text "Wer fies ist, wird"
	line "begehrt, oder?"
	done

GenericTrainerGentlemanCamus:
	generictrainer GENTLEMAN, CAMUS, EVENT_BEAT_GENTLEMAN_CAMUS, .SeenText, .BeatenText

	text "Ich war einst ein"
	line "talentierter"

	para "Trainer, doch nun"
	line "gehöre ich zum"
	cont "alten Eisen."

	para "Genieße es, so-"
	line "lange du noch jung"
	cont "bist."
	done

.SeenText:
	text "Bei deinem Anblick"
	line "denke ich an meine"
	cont "wilde Jugend."
	done

.BeatenText:
	text "Was für ein wilder"
	line "Kampf!"
	done

GenericTrainerGentlemanGeoffrey:
	generictrainer GENTLEMAN, GEOFFREY, EVENT_BEAT_GENTLEMAN_GEOFFREY, .SeenText, .BeatenText

	text "Manchmal ist"
	line "Abwechslung so gut"
	cont "wie Erholung."

	para "Ich fühle mich so"
	line "erfrischt!"
	done

.SeenText:
	text "Ich wollte etwas"
	line "Abwechslung, also"
	cont "kam ich zu den"
	cont "#mon!"
	done

.BeatenText:
	text "Ich bin trotz"
	line "meines Alters noch"
	cont "ein Anfänger."
	done

GenericTrainerGuitaristfMorgan:
	generictrainer GUITARISTF, MORGAN, EVENT_BEAT_GUITARISTF_MORGAN, .SeenText, .BeatenText

	text "Die hallenden"
	line "Klippen machen das"
	cont "Kap zum perfekten"
	cont "Resonanzboden!"
	done

.SeenText:
	text "Hör dir diesen"
	line "Hall an!"
	done

.BeatenText:
	text "Was für ein"
	line "rockiger Kampf!"
	done

TrainerLadyJessica:
	trainer LADY, JESSICA, EVENT_BEAT_LADY_JESSICA, .SeenText, .BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	checkevent EVENT_SPOKE_TO_LADY_JESSICA
	iftruefwd .SpokeAgain
	writetext .AfterText1
	setevent EVENT_SPOKE_TO_LADY_JESSICA
	waitendtext

.SpokeAgain:
	writetext .AfterText2
	clearevent EVENT_SPOKE_TO_LADY_JESSICA
	waitendtext

.SeenText:
	text "Ah! Du da!"
	line "Möchtest du gegen"
	cont "mich kämpfen?"
	done

.BeatenText:
	text "Oh nein! Mein"
	line "Kleid ist ganz"
	cont "nass geworden!"
	done

.AfterText1:
	text "Ich muss mir ein"
	line "besseres #mon"
	cont "kaufen…"
	cont "………………"

	para "Und ein neues"
	line "Kleid…"
	done

.AfterText2:
	text "Warum bist du"
	line "noch hier?"

	para "Hör auf, mich"
	line "anzustarren!"
	cont "………………"
	cont "Widerling!"
	done

GenericTrainerFisherLeroy:
	generictrainer FISHER, LEROY, EVENT_BEAT_FISHER_LEROY, .SeenText, .BeatenText

	text "Ich fange immer"
	line "nur Karpador…"

	para "Immerhin sieht"
	line "jedes anders aus."
	done

.SeenText:
	text "Ich fange die"
	line "gleichen #mon…"

	para "Vielleicht ändert"
	line "ein Kampf"
	cont "die Sache."
	done

.BeatenText:
	text "Mir gelingt ein-"
	line "fach nichts…"
	done

Route25MistysDateLeavesMovement2:
	run_step_down
	run_step_down
	step_end

Route25MistyApproachesPlayerMovement1:
	step_up
Route25MistyApproachesPlayerMovement2:
	step_up
	step_up
	step_left
	step_left
	step_left
	step_end

Route25MistyLeavesPlayerMovement1:
	step_down
	step_left
	step_end

Route25MistyLeavesPlayerMovement2:
	step_up
	step_left
	step_end

Route25MistyLeavesMovement:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

Route25MistyDateText:
	text "Misty: Aww! Warum"
	line "musst du jetzt"

	para "auftauchen und uns"
	line "stören?"

	para "Weißt du, wie"
	line "man Menschen wie"
	cont "dich nennt?"

	para "Plage! Du hast"
	line "richtig gehört,"
	cont "Plage!"

	para "…"

	para "…Oh? Die Orden,"
	line "die du hast… Sind"
	cont "das Arena-Orden"
	cont "aus Johto?"

	para "Wenn du acht hast,"
	line "musst du gut sein."

	para "O.K. Komm in die"
	line "PKMN-Arena von"
	cont "Azuria City."

	para "Ich freue mich,"
	line "gegen dich zu"
	cont "kämpfen."

	para "Ich bin Misty, die"
	line "Arenaleiterin von"
	cont "Azuria City."
	done

BillsHouseSignText:
	text "Küstenhaus"
	line "Bills Haus"
	done

CeruleanCapeSailboatText:
	text "It's a sailboat"
	line "named FriendShip."
	done
