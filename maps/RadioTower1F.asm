RadioTower1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 11
	warp_event  3,  7, GOLDENROD_CITY, 11
	warp_event 15,  0, RADIO_TOWER_2F, 2

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_JUMPTEXT, RadioTower1FDirectoryText
	bg_event 13,  0, BGEVENT_JUMPTEXT, RadioTower1FLuckyChannelSignText

	def_object_events
	object_event  8,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RadioTower1FLuckyNumberManScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 14,  6, SPRITE_WHITNEY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, RadioTower1FWhitneyScript, EVENT_GOLDENROD_GYM_WHITNEY
	object_event  5,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower1FReceptionistScript, -1
	object_event 17,  5, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower1FLassText, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 17,  3, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower1FYoungsterText, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 14,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM3, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 12,  6, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower1FRadioCardWomanScript, EVENT_GOLDENROD_CITY_CIVILIANS

	object_const_def
	const RADIOTOWER1F_FELICITY
	const RADIOTOWER1F_WHITNEY

RadioTower1FReceptionistScript:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue_jumptextfaceplayer RadioTower1FReceptionistNoToursText
	jumpthistextfaceplayer

	text "Willkommen!"
	done

RadioTower1FLuckyNumberManScript:
	faceplayer
	opentext
	writetext RadioTower1FLuckyNumberManAskToPlayText
	waitbutton
	checkevent EVENT_INTRODUCED_FELICITY
	iftruefwd .introduced
	writetext IntroduceFelicityText
	waitbutton
	setevent EVENT_INTRODUCED_FELICITY
.introduced
	writetext ExplainLuckyNumberShowText
	promptbutton
	checkflag ENGINE_LUCKY_NUMBER_SHOW
	iftruefwd .skip
	special Special_ResetLuckyNumberShowFlag
.skip
	special Special_PrintTodaysLuckyNumber
	checkflag ENGINE_LUCKY_NUMBER_SHOW
	iftrue_jumpopenedtext RadioTower1FLuckyNumberManComeAgainText
	writetext RadioTower1FLuckyNumberManTodayIdIsText
	promptbutton
	closetext
	applymovement RADIOTOWER1F_FELICITY, RadioTower1FLuckyNumberManGoToPCMovement
	opentext
	writetext RadioTower1FLuckyNumberManCheckIfMatchText
	promptbutton
	waitsfx
	writetext RadioTower1FLuckyNumberManDotDotDotText
	playsound SFX_DEX_FANFARE_20_49
	special Special_CheckForLuckyNumberWinners
	closetext
	applymovement RADIOTOWER1F_FELICITY, RadioTower1FLuckyNumberManReturnToPlayerMovement
	opentext
	ifequalfwd 5, .FirstPlace
	ifequalfwd 4, .SecondPlace
	ifequalfwd 3, .ThirdPlace
	ifequalfwd 2, .FourthPlace
	ifequalfwd 1, .FifthPlace
	jumpthisopenedtext

	text "Leider stimmt"
	line "keine deiner"
	cont "Ziffern überein."
	done

.FirstPlace:
	; The shared .Finish script checks for room after the prize fanfare.
	giveitem_unsafe MASTER_BALL
	writetext WonFirstPlaceText
	special ShowItemIcon
	playsound SFX_1ST_PLACE
	sjumpfwd .Finish

.SecondPlace:
	; The shared .Finish script checks for room after the prize fanfare.
	giveitem_unsafe BOTTLE_CAP
	writetext WonSecondPlaceText
	special ShowItemIcon
	playsound SFX_2ND_PLACE
	sjumpfwd .Finish

.ThirdPlace:
	; The shared .Finish script checks for room after the prize fanfare.
	giveitem_unsafe PP_MAX
	writetext WonThirdPlaceText
	special ShowItemIcon
	playsound SFX_2ND_PLACE
	sjumpfwd .Finish

.FourthPlace:
	; The shared .Finish script checks for room after the prize fanfare.
	giveitem_unsafe PP_UP
	writetext WonFourthPlaceText
	special ShowItemIcon
	playsound SFX_3RD_PLACE
	sjumpfwd .Finish

.FifthPlace:
	; The shared .Finish script checks for room after the prize fanfare.
	giveitem_unsafe RARE_CANDY
	writetext WonFifthPlaceText
	special ShowItemIcon
	playsound SFX_3RD_PLACE
.Finish:
	waitsfx
	promptbutton
	iffalse_jumpopenedtext RadioTower1FLuckyNumberManNoRoomForYourPrizeText
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	jumpthisopenedtext

RadioTower1FLuckyNumberManComeAgainText:
	text "Please come back"
	line "tomorrow for the"
	cont "next Lucky Number."
	done

RadioTower1FRadioCardWomanScript:
	checkevent EVENT_GOLDENROD_GYM_WHITNEY
	iftrue_jumptextfaceplayer RadioTower1FRadioCardWomanTuneInText
	faceplayer
	opentext
	writetext RadioTower1FRadioCardWomanOfferQuizText
	yesorno
	iffalse_jumpopenedtext RadioTower1FRadioCardWomanNotTakingQuizText
	writetext RadioTower1FRadioCardWomanQuestion1Text
	yesorno
	iffalsefwd .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion2Text
	yesorno
	iffalsefwd .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion3Text
	yesorno
	iftruefwd .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion4Text
	yesorno
	iftruefwd .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion5Text
	yesorno
	iftruefwd .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanYouWinText
	promptbutton
	givespecialitem RADIO_CARD
	writetext RadioTower1FPokegearIsARadioText
	promptbutton
	setflag ENGINE_RADIO_CARD
	writetext RadioTower1FRadioCardWomanTuneInText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, RADIOTOWER1F_WHITNEY, 15
	applymovement RADIOTOWER1F_WHITNEY, RadioTower1FWhitneyApproachesMovementData
	turnobject PLAYER, RIGHT
	showtext RadioTower1FWhitney2Text
	applymovement RADIOTOWER1F_WHITNEY, RadioTower1FWhitneyLeaves1MovementData
	turnobject PLAYER, LEFT
	applymovement RADIOTOWER1F_WHITNEY, RadioTower1FWhitneyLeaves2MovementData
	disappear RADIOTOWER1F_WHITNEY
	end

.WrongAnswer:
	playsound SFX_WRONG
	jumpthisopenedtext

	text "Oh, nein."
	line "Das war leider"

	para "falsch. Versuch's"
	line "noch einmal!"
	done

GenericTrainerGruntM3:
	generictrainer GRUNTM, 3, EVENT_BEAT_ROCKET_GRUNTM_3, GruntM3SeenText, GruntM3BeatenText

	text "Du bist zu stark."

	para "Du könntest unsere"
	line "Pläne zerstören."
	cont "Ich muss die"
	cont "anderen warnen…"
	done

RadioTower1FWhitneyScript:
	showtextfaceplayer RadioTower1FWhitney1Text
	turnobject RADIOTOWER1F_WHITNEY, LEFT
	end

RadioTower1FLuckyNumberManGoToPCMovement:
	step_right
	turn_head_up
	step_end

RadioTower1FLuckyNumberManReturnToPlayerMovement:
	step_left
	turn_head_up
	step_end

RadioTower1FWhitneyApproachesMovementData:
	step_up
	step_up
	step_left
	step_end

RadioTower1FWhitneyLeaves1MovementData:
	step_up
	step_left
	step_left
	step_end

RadioTower1FWhitneyLeaves2MovementData:
	step_left
	step_left
	step_left
	step_left
	step_end


RadioTower1FReceptionistNoToursText:
	text "Guten Tag! Leider"
	line "bieten wir heute"
	cont "keine Führungen"
	cont "an."
	done

RadioTower1FLuckyNumberManAskToPlayText:
	text "Hi, are you here"
	line "for the Lucky Num-"
	cont "ber Show?"
	done

IntroduceFelicityText:
	text "I'm Felicity,"
	line "your attendant"
	cont "today."
	done

ExplainLuckyNumberShowText:
	text "Want me to check"
	line "the ID numbers of"
	cont "your #mon?"

	para "If you get lucky,"
	line "you win a prize."
	done

RadioTower1FLuckyNumberManTodayIdIsText:
	text "Today's lucky ID"
	line "number is "
	text_ram wStringBuffer3
	text "."
	done

RadioTower1FLuckyNumberManCheckIfMatchText:
	text "Mal sehen, ob"
	line "du Glück hast."
	done

RadioTower1FLuckyNumberManDotDotDotText: ; text > text
	text "……"
	line "……"
	done

WonFirstPlaceText:
	text "Wow! Alle fünf"
	line "Ziffern stimmen"
	cont "überein!"

	para "Du gewinnst den"
	line "Hauptpreis!"

	para "Du gewinnst einen"
	line "Meisterball!"
	done

WonSecondPlaceText:
	text "Hey! You've"
	line "matched the last"
	cont "four numbers!"

	para "You've won second"
	line "prize, a rare"
	cont "Bottle Cap!"
	done

WonThirdPlaceText:
	text "Hey! You've"
	line "matched the last"
	cont "three numbers!"

	para "You've won third"
	line "prize, a PP Max!"
	done

WonFourthPlaceText:
	text "Ooh, you've"
	line "matched the last"
	cont "two numbers."

	para "You've won"
	line "fourth prize,"
	cont "a PP Up."
	done

WonFifthPlaceText:
	text "Ooh, you've"
	line "matched the last"
	cont "number."

	para "You've won fifth"
	line "prize, a"
	cont "Rare Candy."
	done


RadioTower1FLuckyNumberManNoRoomForYourPrizeText:
	text "Du kannst den"
	line "Preis nicht"
	cont "tragen."

	para "Schaffe Platz und"
	line "komm gleich"
	cont "wieder zurück."
	done

RadioTower1FRadioCardWomanOfferQuizText:
	text "Bei uns läuft"
	line "momentan ein"
	cont "besonderes Quiz."

	para "Beantworte die"
	line "fünf Fragen"
	cont "richtig, um ein"
	cont "Radio-Modul"
	cont "zu gewinnen."

	para "Stecke es in den"
	line "#Com, um"

	para "überall und zu"
	line "jeder Zeit Radio"
	cont "hören zu können."

	para "Möchtest du am"
	line "Quiz teilnehmen?"
	done

RadioTower1FRadioCardWomanQuestion1Text:
	text "Frage 1:"

	para "Gibt es ein #-"
	line "mon, das nur Vor-"
	cont "mittags erscheint?"
	done

RadioTower1FRadioCardWomanQuestion2Text:
	text "Correct!"
	line "Question 2:"

	para "Nidorina can only"
	line "be female. True?"
	done

RadioTower1FRadioCardWomanQuestion3Text:
	text "Bull's-eye!"
	line "Question 3:"

	para "Can Magikarp learn"
	line "any moves via TM?"
	done

RadioTower1FRadioCardWomanQuestion4Text:
	text "So far so good!"
	line "Question 4:"

	para "Does Kurt, the"
	line "# Ball creator,"

	para "use apricots as"
	line "ingredients?"
	done

RadioTower1FRadioCardWomanQuestion5Text:
	text "Wieder richtig!"
	line "Hier die letzte"
	cont "Frage:"

	para "Ist bei den Ein-"
	line "armigen Banditen"

	para "in der Spielhalle"
	line "von Dukatia City"

	para "ein Glumanda auf"
	line "einer Rolle abge-"
	cont "bildet?"
	done

RadioTower1FRadioCardWomanYouWinText:
	text "Bingo! Richtig!"
	line "Glückwunsch!"

	para "Hier hast du"
	line "deinen Preis:"
	cont "ein Radio-Modul!"
	done

RadioTower1FPokegearIsARadioText:
	text "<PLAYER>s #Com"
	line "kann jetzt auch"
	cont "als Radio ver-"
	cont "wendet werden!"
	done

RadioTower1FRadioCardWomanTuneInText:
	text "Höre dir bitte"
	line "unsere Shows an!"
	done

RadioTower1FRadioCardWomanNotTakingQuizText:
	text "Oh. Ich verstehe."
	line "Komm wieder, wenn"
	cont "du deine Meinung"
	cont "geändert hast."
	done

RadioTower1FLassText:
	text "Ben ist ein"
	line "großartiger DJ."

	para "Seine sonore"
	line "Stimme lässt mich"
	cont "dahinschmelzen!"
	done

RadioTower1FYoungsterText:
	text "Ich liebe Margit"
	line "vom #mon-Talk."

	para "Ich kenne aber"
	line "nur ihre Stimme."
	done

GruntM3SeenText:
	text "Endlich haben wir"
	line "den Radioturm"
	cont "besetzt!"

	para "Nun wird jeder"
	line "den Team Rocket-"

	para "Terrorapparat"
	line "kennenlernen!"

	para "Wir zeigen euch,"
	line "wie böse wir sind!"
	done

GruntM3BeatenText:
	text "Zu stark! Wir"
	line "müssen dich im"
	cont "Auge behalten…"
	done

RadioTower1FWhitney1Text:
	text "Hi! I'm Whitney!"

	para "I heard about the"
	line "quiz to win a"
	cont "Radio Card,"

	para "so I came here"
	line "to get one…"

	para "But this quiz is"
	line "so hard!"
	done

RadioTower1FWhitney2Text:
	text "Whitney: Wow, you"
	line "did it!"

	para "I thought the"
	line "fourth answer"
	cont "was apricots…"

	para "Oops! I should get"
	line "back to the Gym!"
	done

RadioTower1FDirectoryText:
	text "EG Rezeption"
	line "1S Verkauf"

	para "2S Personal"
	line "3S Produktion"

	para "4S Büro des"
	line "   Intendanten"
	done

RadioTower1FLuckyChannelSignText:
	text "Glückskanal!"

	para "Gewinne mit #-"
	line "mon-ID-Nummern!"

	para "Tausche deine "
	line "#mon, um viele"
	cont "ID-Nummern zu"
	cont "erhalten!"
	done
