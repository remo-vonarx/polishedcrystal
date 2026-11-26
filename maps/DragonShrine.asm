DragonShrine_MapScriptHeader:
	def_scene_scripts
	scene_script DragonShrineTakeTestScene, SCENE_DRAGONSHRINE_TAKE_TEST
	scene_const SCENE_DRAGONSHRINE_NOOP

	def_callbacks

	def_warp_events
	warp_event  4, 13, DRAGONS_DEN_B1F, 2
	warp_event  5, 13, DRAGONS_DEN_B1F, 2
	warp_event  4,  1, DRAGONS_DEN_B1F, 3
	warp_event  5,  1, DRAGONS_DEN_B1F, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  5, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, DragonShrineElder1Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  5, 12, SPRITE_CLAIR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_DRAGON_SHRINE_CLAIR
	object_event  3,  2, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, KimonoGirlMinaScript, -1
	object_event  2,  8, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, DragonShrineElder2Text, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  7,  8, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, DragonShrineElder3Text, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

	object_const_def
	const DRAGONSHRINE_ELDER1
	const DRAGONSHRINE_CLAIR
	const DRAGONSHRINE_KIMONO_GIRL

DragonShrineTakeTestScene:
	callasm .CheckUsedBackDoor
	iftruefwd .NoCutscene
	sdefer DragonShrineTestScript
.NoCutscene
	end

.CheckUsedBackDoor:
	ld hl, wPrevWarp
	ld a, [hl]
	dec a
	dec a ; warp 2? (all warps to here are from DragonsDenB1F)
	ldh [hScriptVar], a ; 0/false if used main door (warp 2), nonzero/true if used back door
	ret

DragonShrineTestScript:
	applymovement PLAYER, DragonShrinePlayerWalkInMovement
	applyonemovement DRAGONSHRINE_ELDER1, slow_step_down
	opentext
	writetext DragonShrineElderGreetingText
	promptbutton
.Question1:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	writetext DragonShrineQuestion1Text
	promptbutton
	loadmenu DragonShrineQuestion1_MenuHeader
	verticalmenu
	closewindow
	ifequalfwd $1, .RightAnswer
	ifequalfwd $2, .WrongAnswer
	ifequalfwd $3, .RightAnswer
	end

.Question2:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	writetext DragonShrineQuestion2Text
	promptbutton
	loadmenu DragonShrineQuestion2_MenuHeader
	verticalmenu
	closewindow
	ifequalfwd $1, .RightAnswer
	ifequalfwd $2, .RightAnswer
	ifequalfwd $3, .WrongAnswer
.Question3:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	writetext DragonShrineQuestion3Text
	promptbutton
	loadmenu DragonShrineQuestion3_MenuHeader
	verticalmenu
	closewindow
	ifequalfwd $1, .WrongAnswer
	ifequalfwd $2, .RightAnswer
	ifequalfwd $3, .RightAnswer
.Question4:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	writetext DragonShrineQuestion4Text
	promptbutton
	loadmenu DragonShrineQuestion4_MenuHeader
	verticalmenu
	closewindow
	ifequalfwd $1, .RightAnswer
	ifequalfwd $2, .WrongAnswer
	ifequalfwd $3, .RightAnswer
.Question5:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	writetext DragonShrineQuestion5Text
	promptbutton
	loadmenu DragonShrineQuestion5_MenuHeader
	verticalmenu
	closewindow
	ifequalfwd $1, .WrongAnswer
	ifequalfwd $2, .WrongAnswer
	ifequalfwd $3, .RightAnswer
.RightAnswer:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	iftruefwd .PassedTheTest
	writetext DragonShrineRightAnswerText
	promptbutton
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	iftrue .Question5
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	iftrue .Question4
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftrue .Question3
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .Question2
.WrongAnswer:
	closetext
	turnobject DRAGONSHRINE_ELDER1, RIGHT
	showtext DragonShrineWrongAnswerText1
	turnobject DRAGONSHRINE_ELDER1, DOWN
	showtext DragonShrineWrongAnswerText2
	setevent EVENT_ANSWERED_DRAGON_MASTER_QUIZ_WRONG
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	iftrue .Question5
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	iftrue .Question4
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	iftrue .Question3
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftrue .Question2
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .Question1
.PassedTheTest:
	writetext DragonShrinePassedTestText
	waitbutton
	closetext
	playsound SFX_ENTER_DOOR
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_CLAIR
	appear DRAGONSHRINE_CLAIR
	waitsfx
	turnobject PLAYER, DOWN
	pause 30
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairWalkInMovement
	turnobject DRAGONSHRINE_CLAIR, LEFT
	turnobject PLAYER, RIGHT
	turnobject DRAGONSHRINE_ELDER1, RIGHT
	showtext DragonShrineClairYouPassedText
	special Special_FadeOutMusic
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairBigStepAwayMovement
	showtext DragonShrineClairThatCantBeText
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairSlowStepAwayMovement
	showtext DragonShrineClairYoureLyingText
	applymovement DRAGONSHRINE_ELDER1, DragonShrineElderWalkToClairMovement
	turnobject DRAGONSHRINE_CLAIR, UP
	showtext DragonShrineMustIInformLanceText
	showemote EMOTE_SHOCK, DRAGONSHRINE_CLAIR, 15
	showtext DragonShrineIUnderstandText
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairTwoSlowStepsCloserMovement
	opentext
	writetext DragonShrineHereRisingBadgeText
	waitbutton
	givebadge RISINGBADGE, JOHTO_REGION
	special RestartMapMusic
	specialphonecall SPECIALCALL_MASTERBALL
	setscene SCENE_DRAGONSHRINE_NOOP
	setmapscene DRAGONS_DEN_B1F, SCENE_DRAGONSDENB1F_CLAIR_GIVES_TM
	writetext DragonShrineRisingBadgeExplanationText
	waitbutton
	closetext
	applymovement DRAGONSHRINE_ELDER1, DragonShrineElderWalkAway1Movement
	turnobject DRAGONSHRINE_CLAIR, UP
	applymovement DRAGONSHRINE_ELDER1, DragonShrineElderWalkAway2Movement
	turnobject PLAYER, UP
	showtext DragonShrineElderScoldsClairText
	showtext DragonShrineSpeechlessText
	applymovement DRAGONSHRINE_CLAIR, DragonShrineClairWalkOutMovement
	playsound SFX_ENTER_DOOR
	disappear DRAGONSHRINE_CLAIR
	waitsfx
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	end

DragonShrineElder1Script:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue_jumptextfaceplayer DragonShrineComeAgainText
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_7
	iftrue_jumptextfaceplayer DragonShrineSymbolicDragonText
	checkevent EVENT_GOT_DRATINI
	iffalsefwd .GiveDratini
	checkevent EVENT_BEAT_RIVAL_IN_MT_MOON
	iftrue_jumptextfaceplayer DragonShrineSilverIsInTrainingText
	jumpthistextfaceplayer

	text "Sandra scheint"
	line "eine wertvolle"

	para "Lektion von dir"
	line "gelernt zu haben."

	para "Ich bin ihr Groß-"
	line "vater und"
	cont "danke dir dafür."
	done

.GiveDratini:
	faceplayer
	opentext
	writetext DragonShrineTakeThisDratiniText
	waitbutton
	checkevent EVENT_ANSWERED_DRAGON_MASTER_QUIZ_WRONG
	iftruefwd .NoExtremeSpeed
	givepoke DRATINI, PLAIN_FORM, 15, SITRUS_BERRY, ULTRA_BALL, EXTREMESPEED
	sjumpfwd .FinishElderScript
.NoExtremeSpeed
	givepoke DRATINI, PLAIN_FORM, 15, SITRUS_BERRY, ULTRA_BALL
.FinishElderScript
	iffalse_jumpopenedtext DragonShrinePartyAndBoxFullText
	setevent EVENT_GOT_DRATINI
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_7
	jumpopenedtext DragonShrineSymbolicDragonText

DragonShrineQuestion1_MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 8, 4, 19, 11
	dw .MenuData
	db 1 ; default option

.MenuData:
	db $81 ; flags
	db 3 ; items
	db "Ally@"
	db "Underling@"
	db "Friend@"

DragonShrineQuestion2_MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 9, 4, 19, 11
	dw .MenuData
	db 1 ; default option

.MenuData:
	db $81 ; flags
	db 3 ; items
	db "Strategy@"
	db "Training@"
	db "Cheating@"

DragonShrineQuestion3_MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 5, 4, 19, 11
	dw .MenuData
	db 1 ; default option

.MenuData:
	db $81 ; flags
	db 3 ; items
	db "Weak person@"
	db "Tough person@"
	db "Anybody@"

DragonShrineQuestion4_MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 8, 4, 19, 11
	dw .MenuData
	db 1 ; default option

.MenuData:
	db $81 ; flags
	db 3 ; items
	db "Love@"
	db "Violence@"
	db "Knowledge@"

DragonShrineQuestion5_MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 11, 4, 19, 11
	dw .MenuData
	db 1 ; default option

.MenuData:
	db $81 ; flags
	db 3 ; items
	db "Strong@"
	db "Weak@"
	db "Both@"

DragonShrinePlayerWalkInMovement:
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	step_end

DragonShrineElderWalkToClairMovement:
	slow_step_right
	slow_step_right
	slow_step_right
	turn_head_down
	step_end

DragonShrineElderWalkAway1Movement:
	slow_step_left
	slow_step_left
	step_end

DragonShrineElderWalkAway2Movement:
	slow_step_left
	turn_head_down
	step_end

DragonShrineClairWalkInMovement:
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	step_end

DragonShrineClairBigStepAwayMovement:
	fix_facing
	run_step_right
	step_end

DragonShrineClairSlowStepAwayMovement:
	slow_step_right
	remove_fixed_facing
	step_end

DragonShrineClairTwoSlowStepsCloserMovement:
	slow_step_left
	slow_step_left
	step_end

DragonShrineClairWalkOutMovement:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

DragonShrineElderGreetingText:
	text "Hm… Schön, dass"
	line "du da bist."

	para "Du musst nicht er-"
	line "klären, warum du"
	cont "hier bist."

	para "Sandra hat dich"
	line "geschickt, oder?"

	para "Sie ist ein"
	line "wirklich…"

	para "Tut mir Leid, aber"
	line "ich muss dich"
	cont "prüfen."

	para "Keine Angst, du"
	line "musst nur einige"
	cont "Fragen"
	cont "beantworten."

	para "Fertig?"
	done

DragonShrineQuestion1Text:
	text "Was bedeuten dir"
	line "#mon?"
	done

DragonShrineQuestion2Text:
	text "Was hilft dir im"
	line "Kampf zu gewinnen?"
	done

DragonShrineQuestion3Text:
	text "Gegen welche Art"
	line "Trainer möchtest"
	cont "du kämpfen?"
	done

DragonShrineQuestion4Text:
	text "Was ist beim"
	line "Trainieren von"
	cont "#mon am"
	cont "wichtigsten?"
	done

DragonShrineQuestion5Text:
	text "Starke #mon."
	line "Schwache #mon."

	para "Was ist wichtiger?"
	done

DragonShrinePassedTestText:
	text "Hm… Ich verstehe…"

	para "Du kümmerst dich"
	line "von Herzen um"
	cont "#mon."

	para "Sehr löblich."

	para "Überzeugung ist"
	line "wichtig!"

	para "<PLAYER>, mach"
	line "weiter so."

	para "Ich treffe dich"
	line "dann bei der"
	cont "#mon Liga."
	done

DragonShrineMustIInformLanceText:
	text "Sandra!"

	para "Dieses Kind ist"
	line "tadellos, in Geist"
	cont "und Talent!"

	para "Gestehe deine"
	line "Niederlage und"
	cont "übergib den"
	cont "Drachenorden!"

	para "…Oder soll ich das"
	line "Siegfried"
	cont "erzählen?"
	done

DragonShrineElderScoldsClairText:
	text "Sandra…"

	para "Dieses Kind spie-"
	line "gelt das wider,"

	para "was dir noch"
	line "fehlt."
	done

DragonShrineComeAgainText:
	text "Komme wieder, wenn"
	line "du möchtest."
	done

DragonShrineTakeThisDratiniText:
	text "Hm… Schön, dass du"
	line "hier bist."

	para "Du kommst zur"
	line "richtigen Zeit."

	para "Ich habe etwas für"
	line "dich."

	para "Nimm dieses"
	line "Dratini als"

	para "Zeichen meiner"
	line "Wertschätzung."
	done

DragonShrinePartyAndBoxFullText:
	text "Hm? Dein Team und"
	line "deine Box sind"
	cont "beide voll."
	done

DragonShrineSymbolicDragonText:
	text "Drachen-#mon"
	line "sind das Symbol"
	cont "unseres Klans."

	para "Du hast bewiesen,"
	line "dass man dir eines"

	para "anvertrauen kann."
	done


DragonShrineSilverIsInTrainingText:
	text "Ein Junge deines"
	line "Alters trainiert"
	cont "hier."

	para "Er ähnelt Sandra,"
	line "als sie jünger"

	para "war. Es besorgt"
	line "mich ein wenig…"
	done

DragonShrineWrongAnswerText1:
	text "Hah? Das habe ich"
	line "nicht mitbekommen…"
	done

DragonShrineWrongAnswerText2:
	text "Was hast du"
	line "gesagt?"
	done

DragonShrineRightAnswerText:
	text "Oh, ich verstehe…"
	done

DragonShrineElder2Text:
	text "Es ist schon lange"
	line "her, seit ein"

	para "Trainer die Aner-"
	line "kennung unseres"
	cont "Meisters bekam."

	para "Der letzte war"
	line "Meister Siegfried."
	done

DragonShrineElder3Text:
	text "Kennst du den"
	line "jungen Meister"
	cont "Siegfried?"

	para "Er ähnelt so"
	line "unserem Meister in"
	cont "dessen Jugend."

	para "Es liegt ihnen im"
	line "Blut."
	done

DragonShrineClairYouPassedText:
	text "Wie ist es"
	line "gelaufen?"

	para "Ich muss nicht"
	line "danach fragen."

	para "Du hast versagt?"

	para "………………………………"

	para "…Wie? Bestanden?"
	done

DragonShrineClairThatCantBeText:
	text "Das kann nicht"
	line "sein!"
	done

DragonShrineClairYoureLyingText:
	text "Du lügst!"

	para "Sogar ich habe es"
	line "nicht geschafft!"
	done

DragonShrineIUnderstandText:
	text "I-ich verstehe…"
	done

DragonShrineHereRisingBadgeText:
	text "Hier das ist der"
	line "Drachenorden…"

	para "Jetzt nimm schon!"
	done

DragonShrineRisingBadgeExplanationText:
	text "Mit dem Drachen-"
	line "orden können deine"

	para "#mon die Fähig-"
	line "keit einsetzen,"
	cont "mit der man Was-"
	cont "serfälle erklimmt."

	para "Ferner werden"
	line "dich alle #mon"

	para "als Trainer"
	line "anerkennen und dir"

	para "bedingungslos"
	line "gehorchen."
	done

DragonShrineSpeechlessText:
	text "………………………………"
	done

KimonoGirlMinaScript:
	checkevent EVENT_GOT_ABILITYPATCH_FROM_KIMONO_GIRL_MINA
	iftrue_jumptextfaceplayer .OutroText
	faceplayer
	checkevent EVENT_BEAT_KIMONO_GIRL_MINA
	iftruefwd .Beaten
	checkevent EVENT_BEAT_KIMONO_GIRL_NAOKO
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_KIMONO_GIRL_SAYO
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_KIMONO_GIRL_ZUKI
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_KIMONO_GIRL_KUNI
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_KIMONO_GIRL_MIKI
	iffalse_jumptext .IntroText
	showtext .SeenText
	winlosstext .BeatenText, 0
	setlasttalked DRAGONSHRINE_KIMONO_GIRL
	loadtrainerwithpal KIMONO_GIRL, MINA, TRAINERPAL_MINA
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_KIMONO_GIRL_MINA
.Beaten:
	opentext
	writetext .AfterText
	promptbutton
	verbosegiveitem ABILITYPATCH, iffalse_jumpopenedtext .BagFullText
	setevent EVENT_GOT_ABILITYPATCH_FROM_KIMONO_GIRL_MINA
	jumpthisopenedtext

.OutroText:
	text "Der Weg von Teak"
	line "City hierher hat"

	para "sich gelohnt."

	para "Die Drachenhöhle"
	line "ist ideal für"
	cont "mein Training."
	done

.BagFullText:
	text "…Sobald du in"
	line "deinem Beutel"
	cont "Platz geschaffen"
	cont "hast."
	done

.IntroText:
	text "Ich bin ein"
	line "Kimono-Girl."

	para "Hast du meine"
	line "fünf tanzenden"
	cont "Cousinen in Teak"
	cont "City nicht"
	cont "getroffen?"

	para "Sag mir Bescheid,"
	line "wenn du sie"
	cont "triffst."
	done

.SeenText:
	text "Wer am meisten"
	line "weiß, spricht am"
	cont "wenigsten!"

	para "Erlaube mir, dich"
	line "und deine #mon"
	cont "herauszufordern!"
	done

.BeatenText:
	text "Oh, du bist"
	line "wundervoll…"
	done

.AfterText:
	text "Du bist wahrlich"
	line "ein Trainer."

	para "Du bist dieses"
	line "Items würdig!"
	done
