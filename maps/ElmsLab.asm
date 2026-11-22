ElmsLab_MapScriptHeader:
	def_scene_scripts
	scene_script ElmsLabMeetElmScene, SCENE_ELMSLAB_MEET_ELM
	scene_script DoNothingScript, SCENE_ELMSLAB_CANT_LEAVE
	scene_script DoNothingScript, SCENE_ELMSLAB_NOOP
	scene_script DoNothingScript, SCENE_ELMSLAB_MEET_OFFICER
	scene_script DoNothingScript, SCENE_ELMSLAB_UNUSED
	scene_script DoNothingScript, SCENE_ELMSLAB_AIDE_GIVES_POTION
	scene_script DoNothingScript, SCENE_ELMSLAB_LYRA_BATTLE
	scene_script ElmsLabAideGivesPokeBallsScene, SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS

	def_callbacks
	callback MAPCALLBACK_OBJECTS, ElmsLabCallback_MoveElm

	def_warp_events
	warp_event  4, 11, NEW_BARK_TOWN, 1
	warp_event  5, 11, NEW_BARK_TOWN, 1

	def_coord_events
	coord_event  4,  6, SCENE_ELMSLAB_CANT_LEAVE, LabTryToLeaveScript
	coord_event  5,  6, SCENE_ELMSLAB_CANT_LEAVE, LabTryToLeaveScript
	coord_event  4,  5, SCENE_ELMSLAB_MEET_OFFICER, MeetCopScript
	coord_event  5,  5, SCENE_ELMSLAB_MEET_OFFICER, MeetCopScript2
	coord_event  4,  8, SCENE_ELMSLAB_AIDE_GIVES_POTION, AideScript_WalkPotions1
	coord_event  5,  8, SCENE_ELMSLAB_AIDE_GIVES_POTION, AideScript_WalkPotions2
	coord_event  4,  6, SCENE_ELMSLAB_LYRA_BATTLE, LyraBattleScript

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, ElmsLabHealingMachine
	bg_event  6,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  7,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  8,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  9,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  0,  7, BGEVENT_JUMPTEXT, ElmsLabTravelTip1Text
	bg_event  1,  7, BGEVENT_JUMPTEXT, ElmsLabTravelTip2Text
	bg_event  2,  7, BGEVENT_JUMPTEXT, ElmsLabTravelTip3Text
	bg_event  3,  7, BGEVENT_JUMPTEXT, ElmsLabTravelTip4Text
	bg_event  6,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  7,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  8,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  9,  7, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  9,  3, BGEVENT_JUMPTEXT, ElmsLabTrashcanText
	bg_event  5,  0, BGEVENT_READ, ElmsLabWindow
	bg_event  3,  5, BGEVENT_DOWN, ElmsLabPC

	def_object_events
	object_event  5,  2, SPRITE_ELM, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ProfElmScript, -1
	object_event  2,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ElmsAideScript, EVENT_ELMS_AIDE_IN_LAB
	object_event  6,  3, SPRITE_BALL_CUT_TREE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_ENV_RED, OBJECTTYPE_SCRIPT, 0, CyndaquilPokeBallScript, EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	object_event  7,  3, SPRITE_BALL_CUT_TREE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_ENV_BLUE, OBJECTTYPE_SCRIPT, 0, TotodilePokeBallScript, EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	object_event  8,  3, SPRITE_BALL_CUT_TREE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_ENV_GREEN, OBJECTTYPE_SCRIPT, 0, ChikoritaPokeBallScript, EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	object_event  5,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CopScript, EVENT_COP_IN_ELMS_LAB
	object_event  5, 11, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ElmsLabLyraScript, EVENT_LYRA_IN_ELMS_LAB

	object_const_def
	const ELMSLAB_ELM
	const ELMSLAB_ELMS_AIDE
	const ELMSLAB_POKE_BALL1
	const ELMSLAB_POKE_BALL2
	const ELMSLAB_POKE_BALL3
	const ELMSLAB_OFFICER
	const ELMSLAB_LYRA

ElmsLabCallback_MoveElm:
	checkscene
	iftruefwd .Skip
	moveobject ELMSLAB_ELM, 3, 4
.Skip:
	endcallback

ElmsLabMeetElmScene:
	sdefer .Script
	end

.Script:
	follow PLAYER, ELMSLAB_LYRA
	applymovement PLAYER, ElmsLab_WalkUpToElmMovement
	stopfollow
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	turnobject ELMSLAB_ELM, RIGHT
	opentext
	writetext ElmText_Intro
.Loop:
	yesorno
	iftruefwd ElmsLab_ElmGetsEmail
	writetext ElmText_Refused
	sjump .Loop

ElmsLab_ElmGetsEmail:
if !DEF(DEBUG)
	writetext ElmText_Accepted
	promptbutton
	writetext ElmText_ResearchAmbitions
	waitbutton
	closetext
	playsound SFX_GLASS_TING
	pause 30
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 10
	turnobject ELMSLAB_ELM, DOWN
	showtext ElmText_GotAnEmail
	opentext
	turnobject ELMSLAB_ELM, RIGHT
	writetext ElmText_MissionFromMrPokemon
	waitbutton
endc
	closetext
	applyonemovement ELMSLAB_ELM, step_up
	turnobject PLAYER, UP
	applymovement ELMSLAB_ELM, ElmsLab_ElmToDefaultPositionMovement
	turnobject PLAYER, RIGHT
	showtext ElmText_ChooseAPokemon
	setscene SCENE_ELMSLAB_CANT_LEAVE
	end

ElmsLabAideGivesPokeBallsScene:
	sdefer .Script
	end

.Script:
	turnobject ELMSLAB_ELMS_AIDE, DOWN
	showemote EMOTE_SHOCK, ELMSLAB_ELMS_AIDE, 15
	applymovement ELMSLAB_ELMS_AIDE, AideWalksDownMovement
	showtext AideText_ThiefReturnedMon
	applymovement ELMSLAB_ELMS_AIDE, AideWalksBackMovement
	turnobject ELMSLAB_ELMS_AIDE, DOWN
	setscene SCENE_ELMSLAB_NOOP
	end

ProfElmScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_SS_TICKET_FROM_ELM
	iftruefwd .CheckMasterBall
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue ElmGiveTicketScript
.CheckMasterBall:
	checkevent EVENT_GOT_MASTER_BALL_FROM_ELM
	iftruefwd .CheckOddSouvenir
	checkflag ENGINE_RISINGBADGE
	iftrue ElmGiveMasterBallScript
.CheckOddSouvenir:
	checkevent EVENT_GOT_ODD_SOUVENIR_FROM_ELM
	iftrue ElmCheckBattleScript
	checkevent EVENT_SHOWED_TOGEPI_TO_ELM
	iftrue ElmGiveOddSouvenirScript
	checkevent EVENT_ELM_WANTS_TO_BATTLE
	iftrue ElmAskBattleScript
	checkevent EVENT_TOLD_ELM_ABOUT_TOGEPI_OVER_THE_PHONE
	iffalsefwd ElmCheckTogepiEgg
	; fallthrough

ElmEggHatchedScript:
	setmonval TOGEPI
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	setmonval TOGETIC
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	setmonval TOGEKISS
	special Special_FindThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	checkevent EVENT_TOLD_ELM_ABOUT_TOGEPI_OVER_THE_PHONE
	iffalsefwd ElmCheckGotEggAgain
	jumpthisopenedtext

	text "<PLAYER>? Ich"
	line "dachte, etwas wäre"
	cont "aus dem Ei ge-"
	cont "schlüpft."

	para "Wo ist das"
	line "#mon?"
	done

ElmCheckTogepiEgg:
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iffalsefwd ElmCheckGotEggAgain
	checkevent EVENT_TOGEPI_HATCHED
	iftrue ElmEggHatchedScript
ElmCheckGotEggAgain:
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE ; why are we checking it again?
	iftrue_jumpopenedtext ElmWaitingEggHatchText
	checkflag ENGINE_ZEPHYRBADGE
	iftrue_jumpopenedtext ElmAideHasEggText
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue_jumpopenedtext ElmStudyingEggText
	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	iftrue ElmAfterTheftScript
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumpopenedtext ElmDescribesMrPokemonText
	jumpthisopenedtext

	text "Erscheint ein"
	line "wildes #mon,"
	cont "lass deine #mon"
	cont "dagegen kämpfen."
	done

LabTryToLeaveScript:
	turnobject ELMSLAB_ELM, DOWN
	showtext LabWhereGoingText
	applyonemovement PLAYER, step_up
	end

CyndaquilPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumptext ElmPokeBallText
	turnobject ELMSLAB_ELM, DOWN
	reanchormap
	pokepic CYNDAQUIL
	cry CYNDAQUIL
	waitbutton
	closepokepic
	opentext
	writetext TakeCyndaquilText
	yesorno
	iffalse_jumpopenedtext DidntChooseStarterText
	disappear ELMSLAB_POKE_BALL1
	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	givepoke CYNDAQUIL, PLAIN_FORM, 5, ORAN_BERRY
	writetext LyraChoosesStarterText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraPicksChikoritaMovement
	pause 15
	disappear ELMSLAB_POKE_BALL3
	opentext
	getmonname CHIKORITA, STRING_BUFFER_3
	writetext LyraReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	writetext LyraNicknamedChikoritaText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraAfterChikoritaMovement
	readvar VAR_FACING
	ifequalfwd RIGHT, ElmDirectionsScript
	applymovement PLAYER, AfterCyndaquilMovement
	sjumpfwd ElmDirectionsScript

TotodilePokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumptext ElmPokeBallText
	turnobject ELMSLAB_ELM, DOWN
	reanchormap
	pokepic TOTODILE
	cry TOTODILE
	waitbutton
	closepokepic
	opentext
	writetext TakeTotodileText
	yesorno
	iffalse_jumpopenedtext DidntChooseStarterText
	disappear ELMSLAB_POKE_BALL2
	setevent EVENT_GOT_TOTODILE_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	givepoke TOTODILE, PLAIN_FORM, 5, ORAN_BERRY
	writetext LyraChoosesStarterText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraPicksCyndaquilMovement
	pause 15
	disappear ELMSLAB_POKE_BALL1
	opentext
	getmonname CYNDAQUIL, STRING_BUFFER_3
	writetext LyraReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	writetext LyraNicknamedCyndaquilText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraAfterCyndaquilMovement
	applymovement PLAYER, AfterTotodileMovement
	sjumpfwd ElmDirectionsScript

ChikoritaPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumptext ElmPokeBallText
	turnobject ELMSLAB_ELM, DOWN
	reanchormap
	pokepic CHIKORITA
	cry CHIKORITA
	waitbutton
	closepokepic
	opentext
	writetext TakeChikoritaText
	yesorno
	iffalse_jumpopenedtext DidntChooseStarterText
	disappear ELMSLAB_POKE_BALL3
	setevent EVENT_GOT_CHIKORITA_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	givepoke CHIKORITA, PLAIN_FORM, 5, ORAN_BERRY
	writetext LyraChoosesStarterText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraPicksTotodileMovement
	pause 15
	disappear ELMSLAB_POKE_BALL2
	opentext
	getmonname TOTODILE, STRING_BUFFER_3
	writetext LyraReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	writetext LyraNicknamedTotodileText
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraAfterTotodileMovement
	applymovement PLAYER, AfterChikoritaMovement
	; fallthrough

ElmDirectionsScript:
	turnobject PLAYER, UP
if !DEF(DEBUG)
	showtext ElmDirectionsText1
endc
	addcellnum PHONE_ELM
	opentext
	writetext GotElmsNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	waitbutton
	closetext
	turnobject ELMSLAB_ELM, LEFT
	showtext ElmDirectionsText2
	turnobject ELMSLAB_ELM, DOWN
	showtext ElmDirectionsText3
	setevent EVENT_GOT_A_POKEMON_FROM_ELM
	setevent EVENT_RIVAL_CHERRYGROVE_CITY
	setscene SCENE_ELMSLAB_LYRA_BATTLE
	end

ElmsLabHealingMachine:
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftruefwd .CanHeal
	jumpthisopenedtext

	text "Ich frage mich,"
	line "wozu das gut ist!"
	done

.CanHeal:
	writetext ElmsLabHealingMachineText2
	yesorno
	iftruefwd ElmsLabHealingMachine_HealParty
	endtext

ElmsLabHealingMachine_HealParty:
	special HealParty
	special SaveMusic
	playmusic MUSIC_NONE
	setval 1 ; Machine is in Elm's Lab
	special HealMachineAnim
	pause 30
	special RestoreMusic
	endtext

ElmAfterTheftDoneScript:
	waitendtext

ElmAfterTheftScript:
	writetext ElmAfterTheftText1
	checkkeyitem MYSTERY_EGG
	iffalse ElmAfterTheftDoneScript
	promptbutton
	writetext ElmAfterTheftText2
	waitbutton
	takekeyitem MYSTERY_EGG
	scall ElmJumpBackScript1
	writetext ElmAfterTheftText3
	waitbutton
	scall ElmJumpBackScript2
	writetext ElmAfterTheftText4
	promptbutton
	writetext ElmAfterTheftText5
	promptbutton
	setevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	clearevent EVENT_LYRA_ROUTE_29
	setmapscene ROUTE_29, SCENE_ROUTE29_CATCH_TUTORIAL
	clearevent EVENT_ROUTE_30_YOUNGSTER_JOEY
	setevent EVENT_ROUTE_30_BATTLE
	setscene SCENE_ELMSLAB_NOOP
	writetext ElmAfterTheftText6
	promptbutton
	closetext
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	showtext ElmAfterTheftText7
	end

ShowElmTogepiScript:
	writetext ShowElmTogepiText1
	waitbutton
	closetext
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	setevent EVENT_SHOWED_TOGEPI_TO_ELM
	opentext
	writetext ShowElmTogepiText2
	promptbutton
	writetext ShowElmTogepiText3
	promptbutton
ElmGiveOddSouvenirScript:
	writetext ElmGiveOddSouvenirText1
	promptbutton
	verbosegiveitem ODD_SOUVENIR, iffalse_endtext
	setevent EVENT_GOT_ODD_SOUVENIR_FROM_ELM
	writetext ElmGiveOddSouvenirText2
	waitbutton
	checkevent EVENT_BATTLED_PROF_ELM
	iffalsefwd ElmAlsoBattleScript
	endtext

ElmGiveMasterBallScript:
	writetext ElmGiveMasterBallText1
	promptbutton
	verbosegiveitem MASTER_BALL, iffalse_endtext
	setevent EVENT_GOT_MASTER_BALL_FROM_ELM
	writetext ElmGiveMasterBallText2
	waitbutton
	checkevent EVENT_BATTLED_PROF_ELM
	iftrue_endtext
ElmAlsoBattleScript:
	writetext ElmByTheWayText
	waitbutton
	sjumpfwd ElmAskBattleScript

ElmCheckBattleScript:
	checkevent EVENT_BATTLED_PROF_ELM
	iftrue_jumpopenedtext ElmText_CallYou
	checkevent EVENT_BEAT_FALKNER
	iffalse_jumpopenedtext ElmText_CallYou
	writetext ElmBeforeBattleText
	waitbutton
ElmAskBattleScript:
	setevent EVENT_ELM_WANTS_TO_BATTLE
	writetext ElmAskBattleText
	yesorno
	iffalse_jumpopenedtext ElmRefusedBattleText
	writetext ElmSeenText
	waitbutton
	closetext
	winlosstext ElmWinText, ElmLoseText
	setlasttalked ELMSLAB_ELM
	readvar VAR_BADGES
	ifless 2, .Team1
	ifless 4, .Team2
	ifless 8, .Team3
	loadtrainer PROF_ELM, 4
	sjumpfwd .GotTeam
.Team1:
	loadtrainer PROF_ELM, 1
	sjumpfwd .GotTeam
.Team2:
	loadtrainer PROF_ELM, 2
	sjumpfwd .GotTeam
.Team3:
	loadtrainer PROF_ELM, 3
.GotTeam:
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	clearevent EVENT_ELM_WANTS_TO_BATTLE
	setevent EVENT_BATTLED_PROF_ELM
	startbattle
	reloadmap
	special HealParty
	jumpthistextfaceplayer

	text "Lind: Ich bin"
	line "stolz auf dich,"
	cont "<PLAYER>."

	para "Es war richtig,"
	line "dir ein #mon"
	cont "anzuvertrauen!"
	done

ElmGiveTicketScript:
	writetext ElmGiveTicketText1
	promptbutton
	verbosegivekeyitem S_S_TICKET
	writetext ElmGiveTicketText2
	waitbutton
	closetext
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	special Special_FadeOutMusic
	pause 10
	readvar VAR_FACING
	ifequalfwd UP, .Shortest
	ifequalfwd DOWN, .Longest
	disappear ELMSLAB_LYRA
	moveobject ELMSLAB_LYRA, 4, 7
	scall .LyraEntryShort
	scall .LyraAnnouncesGymChallenge
	turnobject PLAYER, RIGHT
	sjumpfwd .Continue

.Longest
	disappear ELMSLAB_LYRA
	moveobject ELMSLAB_LYRA, 4, 6
	appear ELMSLAB_LYRA
	applymovement ELMSLAB_LYRA, LyraRunsInMoreMovement
	turnobject ELMSLAB_ELM, UP
	turnobject ELMSLAB_LYRA, RIGHT
	turnobject PLAYER, LEFT
	scall .LyraAnnouncesGymChallenge
	turnobject PLAYER, DOWN
	sjumpfwd .Continue

.Shortest
	disappear ELMSLAB_LYRA
	moveobject ELMSLAB_LYRA, 5, 8
	scall .LyraEntryShort
	scall .LyraAnnouncesGymChallenge
	turnobject PLAYER, UP

.Continue
	faceplayer
	playmusic MUSIC_PROF_ELM
	showtext ElmAfterTicketText
	setevent EVENT_LYRA_IN_HER_ROOM
	setevent EVENT_GOT_SS_TICKET_FROM_ELM
	end

.LyraAnnouncesGymChallenge
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	showtext LyraAnnouncesGymChallengeText
	applymovement ELMSLAB_LYRA, LyraLeavesMovement
	disappear ELMSLAB_LYRA
	pause 10
	end

.LyraEntryShort
	appear ELMSLAB_LYRA
	applymovement ELMSLAB_LYRA, LyraRunsInMovement
	turnobject ELMSLAB_ELM, DOWN
	turnobject ELMSLAB_LYRA, UP
	turnobject PLAYER, DOWN
	end

ElmJumpBackScript1:
	closetext
	readvar VAR_FACING
	scalltable .JumpBackScript1Table
	end
.JumpBackScript1Table
	dw ElmJumpDownScript
	dw ElmJumpUpScript
	dw ElmJumpLeftScript
	dw ElmJumpRightScript

ElmJumpBackScript2:
	closetext
	readvar VAR_FACING
	scalltable .JumpBackScript2Table
	end
.JumpBackScript2Table
	dw ElmJumpUpScript
	dw ElmJumpDownScript
	dw ElmJumpRightScript
	dw ElmJumpLeftScript

ElmJumpUpScript:
	applymovement ELMSLAB_ELM, ElmJumpUpMovement
	opentext
	end

ElmJumpDownScript:
	applymovement ELMSLAB_ELM, ElmJumpDownMovement
	opentext
	end

ElmJumpLeftScript:
	applymovement ELMSLAB_ELM, ElmJumpLeftMovement
	opentext
	end

ElmJumpRightScript:
	applymovement ELMSLAB_ELM, ElmJumpRightMovement
	opentext
	end

LyraBattleScript:
	turnobject ELMSLAB_LYRA, DOWN
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	showtext ElmsLabLyraChallengeText
	applymovement ELMSLAB_LYRA, LyraBattleMovement
	turnobject PLAYER, RIGHT
	winlosstext ElmsLabLyraWinText, ElmsLabLyraLossText
	setlasttalked ELMSLAB_LYRA
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftruefwd .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftruefwd .Chikorita
	loadtrainer LYRA1, LYRA1_1
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	reloadmap
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	iftruefwd .AfterYourDefeat
	sjumpfwd .AfterVictorious

.Totodile:
	loadtrainer LYRA1, LYRA1_2
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	reloadmap
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	iftruefwd .AfterVictorious
	sjumpfwd .AfterYourDefeat

.Chikorita:
	loadtrainer LYRA1, LYRA1_3
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	reloadmap
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	iftruefwd .AfterVictorious
	sjumpfwd .AfterYourDefeat

.AfterVictorious:
	showtext ElmsLabLyraText_YouWon
	sjumpfwd .FinishLyra

.AfterYourDefeat:
	showtext ElmsLabLyraText_YouLost
.FinishLyra:
	turnobject ELMSLAB_LYRA, UP
	opentext
	writetext ElmsLabLyraThankYouText
	waitbutton
	turnobject ELMSLAB_LYRA, LEFT
	writetext ElmsLabLyraSeeYouText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement ELMSLAB_LYRA, LyraLeavesMovement
	disappear ELMSLAB_LYRA
	special HealParty
	setscene SCENE_ELMSLAB_AIDE_GIVES_POTION
	playmapmusic
	end

AideScript_WalkPotions1:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight1
	turnobject PLAYER, DOWN
	scall AideScript_GivePotions
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft1
	end

AideScript_WalkPotions2:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight2
	turnobject PLAYER, DOWN
	scall AideScript_GivePotions
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft2
	end

AideScript_GivePotions:
	opentext
	writetext AideText_GiveYouPotions
	promptbutton
	; Finish the introductory scene even if the Bag cannot fit the Potion.
	verbosegiveitem_unsafe POTION
	setscene SCENE_ELMSLAB_NOOP
	jumpopenedtext AideText_AlwaysBusy

ElmsAideScript:
	checkevent EVENT_GOT_RIVALS_EGG
	iftrue_jumptextfaceplayer AideText_AlwaysBusy
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iftrue_jumptextfaceplayer AideText_AfterTheft
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue_jumptextfaceplayer AideText_AlwaysBusy
	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	iftrue_jumptextfaceplayer AideText_TheftTestimony
	jumptextfaceplayer AideText_AlwaysBusy

MeetCopScript2:
	applyonemovement PLAYER, step_left
MeetCopScript:
	applymovement PLAYER, MeetCopScript_WalkUp
CopScript:
	turnobject ELMSLAB_OFFICER, LEFT
	showtext ElmsLabOfficerText1
	disappear ELMSLAB_LYRA
	moveobject ELMSLAB_LYRA, 5, 8
	appear ELMSLAB_LYRA
	applymovement ELMSLAB_LYRA, LyraRunsInMovement
	turnobject ELMSLAB_OFFICER, DOWN
	showtext ElmsLabLyraTheftInnocentText
	pause 10
	turnobject ELMSLAB_OFFICER, LEFT
	opentext
	writetext ElmsLabOfficerText2
	promptbutton
	special SpecialNameRival
	writetext ElmsLabOfficerText3
	waitbutton
	closetext
	applymovement ELMSLAB_LYRA, LyraStepsAsideMovement
	applymovement ELMSLAB_OFFICER, OfficerLeavesMovement
	disappear ELMSLAB_OFFICER
	pause 10
	turnobject ELMSLAB_LYRA, UP
	turnobject PLAYER, DOWN
	showtext ElmsLabLyraTheftGoodbyeText
	applymovement ELMSLAB_LYRA, LyraLeavesMovement
	disappear ELMSLAB_LYRA
	setscene SCENE_ELMSLAB_NOOP
	pause 10
	applymovement PLAYER, MeetCopScript_GiveEgg
	opentext
	sjump ElmAfterTheftScript

ElmsLabLyraScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iffalse_jumptextfaceplayer ElmsLabLyraWhichPokemonText
	jumpthistextfaceplayer

	text "Dein #mon"
	line "ist auch süss!"
	done

ElmsLabWindow:
	checkflag ENGINE_FLYPOINT_VIOLET
	iftrue_jumptext ElmsLabWindowText1
	checkevent EVENT_ELM_CALLED_ABOUT_STOLEN_POKEMON
	iftrue_jumptext ElmsLabWindowText2
	jumptext ElmsLabWindowText1

ElmsLabPC:
	jumpthistext

	text "Aufzeichnungen zur"
	line "#mon-Entwick-"
	cont "lung"

	para "…steht auf dem"
	line "Bildschirm…"
	done

ElmsLab_WalkUpToElmMovement:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	turn_head_left
	step_end

LyraPicksChikoritaMovement:
	step_right
LyraPicksTotodileMovement:
	step_right
LyraPicksCyndaquilMovement:
	step_right
	step_right
	step_up
	step_end

LyraAfterChikoritaMovement:
	step_down
	step_left
	step_left
	step_left
	turn_head_up
	step_end

LyraAfterTotodileMovement:
	step_down
	step_left
	step_left
	turn_head_up
	step_end

LyraAfterCyndaquilMovement:
	step_down
	step_left
	turn_head_up
	step_end

LyraBattleMovement:
	step_down
	turn_head_left
	step_end

LyraLeavesMovement:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

LyraRunsInMoreMovement:
	step_up
LyraRunsInMovement:
	step_up
	step_up
	step_up
	step_up
	step_end

LyraStepsAsideMovement:
	step_left
	turn_head_right
	step_end

MeetCopScript_WalkUp:
	step_up
	step_up
	turn_head_right
	step_end

MeetCopScript_GiveEgg:
	step_right
	turn_head_up
	step_end

OfficerLeavesMovement:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

AideWalksRight1:
	step_right
	step_right
	turn_head_up
	step_end

AideWalksRight2:
	step_right
	step_right
	step_right
	turn_head_up
	step_end

AideWalksLeft1:
	step_left
	step_left
	turn_head_down
	step_end

AideWalksLeft2:
	step_left
	step_left
	step_left
	turn_head_down
	step_end

AideWalksDownMovement:
	step_right
	step_right
	step_down
	step_end

AideWalksBackMovement:
	step_up
	step_left
	step_left
	step_end

ElmJumpUpMovement:
	fix_facing
	run_step_up
	remove_fixed_facing
	step_end

ElmJumpDownMovement:
	fix_facing
	run_step_down
	remove_fixed_facing
	step_end

ElmJumpLeftMovement:
	fix_facing
	run_step_left
	remove_fixed_facing
	step_end

ElmJumpRightMovement:
	fix_facing
	run_step_right
	remove_fixed_facing
	step_end

ElmsLab_ElmToDefaultPositionMovement:
	step_right
	step_right
	step_up
	turn_head_down
	step_end

AfterCyndaquilMovement:
	step_left
	step_up
	turn_head_up
	step_end

AfterTotodileMovement:
	step_left
	step_left
	step_up
	turn_head_up
	step_end

AfterChikoritaMovement:
	step_left
	step_left
	step_left
	step_up
	turn_head_up
	step_end

ElmText_Intro:
	text "Lind: <PLAYER>!"
	line "Da bist du ja!"

if !DEF(DEBUG)
	para "Hallo auch dir,"
	line "Lyra."

	para "Ich muss euch"
	line "beide um etwas"
	cont "bitten."

	para "Versteht ihr…"

	para "Ich schreibe an"
	line "etwas, das ich bei"

	para "einer Konferenz"
	line "vorlegen möchte."

	para "Aber da sind noch"
	line "einige Dinge, die"

	para "ich nicht ganz"
	line "verstehe."

	para "Darum!"

	para "Ich möchte, dass"
	line "ihr beide #mon"

	para "trainiert, die"
	line "ich vor kurzem"
	cont "gefangen habe."
endc
	done

ElmText_Accepted:
	text "Danke, <PLAYER>!"

	para "Du bist mir eine"
	line "grosse Hilfe!"
	done

ElmText_Refused:
	text "Aber… ich brauche"
	line "deine Hilfe!"
	done

ElmText_ResearchAmbitions:
	text "Wenn ich meine Er-"
	line "gebnisse vorlege,"

	para "werden wir sicher"
	line "noch weiter in die"

	para "Geheimnisse der"
	line "#mon"
	cont "vorstossen."

	para "Darauf kannst du"
	line "dich verlassen!"
	done

ElmText_GotAnEmail:
	text "Oh, heh! Ich habe"
	line "eine E-Mail!"

	para "………………"
	line "Hm… Uh-huh…"

	para "Okay…"
	done

ElmText_MissionFromMrPokemon:
	text "Hör gut zu!"

	para "Ich habe einen Be-"
	line "kannten namens Mr."
	cont "#mon."

	para "Ständig findet er"
	line "eigenartiges Zeugs"

	para "und fängt an, da-"
	line "rüber zu fanta-"
	cont "sieren."

	para "Aber jetzt hat er"
	line "mir eine E-Mail"

	para "geschickt, in der"
	line "steht, dass es"

	para "sich diesmal um"
	line "etwas Grosses"
	cont "handeln muss."

	para "Das klingt zwar"
	line "faszinierend, aber"

	para "wir sind derzeit"
	line "mitten in unseren"

	para "eigenen #mon-"
	line "Forschungen."

	para "Moment!"

	para "Ich hab's!"

	para "<PLAYER>, könntest"
	line "du der Sache"
	cont "nachgehen?"
	done

ElmText_ChooseAPokemon:
	text "Ich möchte, dass"
	line "du eines der"

	para "#mon aus"
	line "einem dieser Bälle"
	cont "trainierst."

	para "Du wirst der erste"
	line "Kamerad dieses"
	cont "#mon sein,"
	cont "<PLAYER>!"

	para "Such dir eins aus!"
	done


LabWhereGoingText:
	text "Lind: Warte! Wohin"
	line "gehst du?"
	done

TakeCyndaquilText:
	text "Lind: Willst du"
	line "Feurigel, das"
	cont "Feuer-#mon?"
	done

TakeTotodileText:
	text "Lind: Wählst du"
	line "Karnimani, das"
	cont "Wasser-#mon?"
	done

TakeChikoritaText:
	text "Lind: Entscheidest"
	line "du dich für"

	para "Endivie, das"
	line "Pflanzen-#mon?"
	done

DidntChooseStarterText:
	text "Lind: Überlege es"
	line "dir gut!"

	para "Die Wahl deines"
	line "Partners ist sehr"
	cont "wichtig."
	done

ChoseStarterText:
	text "Lind: Ich bin auch"
	line "der Meinung, dass"
	cont "dieses #mon"
	cont "sehr gut ist!"
	done

ElmDirectionsText1:
	text "Mr. #mon lebt"
	line "ein wenig nördlich"

	para "von Rosalia City,"
	line "dem nächsten Ort."

	para "Der Weg führt dich"
	line "fast direkt dort-"
	cont "hin, du kannst es"
	cont "nicht verfehlen."

	para "Aber nur für den"
	line "Fall, dass… hier"

	para "ist meine Nummer."
	line "Ruf an, wenn es"
	cont "etwas gibt!"
	done

ElmDirectionsText2:
	text "Ist dein #mon"
	line "verletzt, solltest"

	para "du es mit Hilfe"
	line "dieser Maschine"
	cont "heilen."

	para "Benutze sie so oft"
	line "du willst."
	done

ElmDirectionsText3:
	text "<PLAYER>, ich"
	line "zähle auf dich!"
	done

GotElmsNumberText:
	text "<PLAYER> erhält"
	line "Linds Nummer."
	done

ElmDescribesMrPokemonText:
	text "Mr. #mon findet"
	line "überall seltene"
	cont "Dinge."

	para "Es ist nur dumm,"
	line "dass sie nur sel-"
	cont "ten und nicht"
	cont "brauchbar sind…"
	done

ElmPokeBallText:
	text "Er beinhaltet ein"
	line "von Prof. Lind ge-"
	cont "fangenes #mon."
	done


ElmsLabHealingMachineText2:
	text "Willst du deine"
	line "#mon heilen?"
	done

ElmAfterTheftText1:
	text "Lind: <PLAYER>, es"
	line "ist schrecklich…"

	para "Oh, was hat Mr."
	line "#mon denn"
	cont "Grosses entdeckt?"
	done

ElmAfterTheftText2:
	text "<PLAYER> übergibt"
	line "Prof. Lind das"
	cont "Rätsel-Ei."
	done

ElmAfterTheftText3:
	text "Lind: Das hier?"
	done

ElmAfterTheftText4:
	text "Aber… ist das auch"
	line "ein #mon-Ei?"

	para "Falls ja, dann ist"
	line "es in der Tat eine"
	cont "grosse Entdeckung!"
	done

ElmAfterTheftText5:
	text "Lind: Wie?!?"

if !DEF(DEBUG)
	para "Prof. Eich hat dir"
	line "einen #dex"
	cont "gegeben?"

	para "<PLAYER>, ist das"
	line "wahr? D-Das ist ja"
	cont "unglaublich!"

	para "Kein anderer ist"
	line "wie er in der"

	para "Lage, das wahre"
	line "Potenzial eines"

	para "Trainers zu er-"
	line "kennen."

	para "Wow, <PLAYER>. Es"
	line "ist vielleicht"

	para "deine Bestimmung,"
	line "der Champ zu"
	cont "werden."

	para "Es sieht auch so"
	line "aus, als könntest"

	para "du hervorragend"
	line "mit #mon um-"
	cont "gehen."

	para "Du solltest die"
	line "Herausforderung"

	para "der PKMN-Arenen"
	line "annehmen."

	para "Die nächste PKMN-"
	line "Arena befindet"
	cont "sich in Viola."
endc
	done

ElmAfterTheftText6:
	text "…<PLAYER>. Der"
	line "Weg zum Ruhm ist"

	para "lang und beschwer-"
	line "lich."

	para "Bevor du los-"
	line "ziehst, solltest"
	cont "du mit deiner Mama"
	cont "sprechen."
	done

ElmAfterTheftText7:
	text "Und ruf mich auch"
	line "mal an."

	para "Wenn du wissen"
	line "willst, wie deine"

	para "#mon sich ent-"
	line "wickeln könnten,"

	para "wird meine For-"
	line "schung unbezahl-"
	cont "bar für dich sein!"
	done

ElmStudyingEggText:
	text "Lind: Gib nicht"
	line "auf! Ich rufe dich"

	para "an, wenn ich etwas"
	line "über dieses Ei he-"
	cont "rausgefunden habe."
	done

ElmAideHasEggText:
	text "Lind: <PLAYER>?"
	line "Hast du schon mei-"
	cont "nen Assistenten"
	cont "getroffen?"

	para "Er sollte mit dem"
	line "Ei im #mon-"
	cont "Center von Viola"
	cont "City warten."

	para "Du musst ihn ver-"
	line "passt haben. Ver-"
	cont "suche, ihn dort zu"
	cont "finden."
	done

ElmWaitingEggHatchText:
	text "Lind: He, hat sich"
	line "das Ei irgendwie"
	cont "verändert?"
	done


ShowElmTogepiText1:
	text "Lind: <PLAYER>, du"
	line "siehst grossartig"
	cont "aus!"
	done

ShowElmTogepiText2:
	text "Was?"
	line "Dieses #mon!?!"
	done

ShowElmTogepiText3:
	text "Es ist aus dem Ei"
	line "geschlüpft! Also"
	cont "schlüpfen alle"
	cont "#mon aus Eiern…"

	para "Nein, vermutlich"
	line "trifft das nicht"
	cont "auf alle #mon"
	cont "zu."

	para "Es wartet wohl"
	line "noch jede Menge"
	cont "Forschungsarbeit"
	cont "auf uns."
	done

ElmGiveOddSouvenirText1:
	text "Danke, <PLAYER>!"
	line "Du hilfst uns beim"

	para "Aufklären vieler"
	line "#mon-Mysterien!"

	para "Bitte nimm dies"
	line "als Zeichen unser-"
	cont "er Wertschätzung."
	done

ElmGiveOddSouvenirText2:
	text "Das ist eine Kuri-"
	line "osität, die mir"
	cont "Mr. #mon gab."

	para "Er sagte, es sei"
	line "ein Souvenir von"

	para "seiner Reise auf"
	line "eine tropische"
	cont "Insel."

	para "Angeblich gibt es"
	line "einige #mon-"

	para "Arten, die es gern"
	line "tragen."
	done

ElmText_CallYou:
	text "Lind: <PLAYER>, ich"
	line "rufe dich an, wenn"
	cont "sich etwas tut."
	done

AideText_AfterTheft:
	text "…Seufz… Das"
	line "gestohlene"
	cont "#mon."

	para "Ich frage mich,"
	line "wie es ihm geht."

	para "Man sagt, dass ein"
	line "#mon, das von"

	para "einem bösen Men-"
	line "schen aufgezogen"
	cont "wird, selber böse"

	para "wird."
	done

AideText_ThiefReturnedMon:
	text "<PLAYER>!"
	line "Rate mal!"

	para "Der Junge, der"
	line "dem Professor das"
	cont "#mon wegnahm…"

	para "…ist zurückgekom-"
	line "men, um es zurück-"
	cont "zugeben!"

	para "Aber Prof. Lind"
	line "sagte zu ihm…"

	para "“Es sieht so aus,"
	line "als ob dich das"
	cont "#mon sehr mag."

	para "#mon strengen"
	line "sich bei jemandem,"
	cont "den sie lieben,"
	cont "besonders an."

	para "Ich finde, es"
	line "sollte bei dir"
	cont "bleiben.”"

	para "…Ist das nicht"
	line "rührend?"
	cont "Ich musste weinen!"

	para "Ich sah das Ge-"
	line "sicht des Jungen,"
	cont "als er ging."

	para "Er sah so glück-"
	line "lich aus!"
	done

ElmGiveMasterBallText1:
	text "Lind: Hi, <PLAYER>!"
	line "Dank dir komme ich"

	para "mit meinen For-"
	line "schungen hervor-"
	cont "ragend voran!"

	para "Nimm dies als"
	line "Zeichen meiner"
	cont "Dankbarkeit!"
	done

ElmGiveMasterBallText2:
	text "Der Meisterball"
	line "ist der Beste von"
	cont "allen!"

	para "Er ist der ultima-"
	line "tive Ball! Ihm"

	para "kann kein #mon"
	line "entwischen."

	para "Er wird nur aner-"
	line "kannten #mon-"
	cont "Forschern"
	cont "überreicht."

	para "Aber ich glaube,"
	line "du hast bessere"

	para "Verwendung dafür"
	line "als ich, <PLAYER>!"
	done

ElmGiveTicketText1:
	text "Lind: <PLAYER>!"
	line "Da bist du ja!"

	para "Ich habe dich ge-"
	line "rufen, weil ich"
	cont "dir etwas geben"
	cont "möchte."

	para "Es handelt sich um"
	line "ein Bootsticket."

	para "Jetzt kannst du"
	line "auch in Kanto"
	cont "#mon fangen."

	para "Du kannst auch"
	line "neue Arenen he-"
	cont "rausfordern."

	para "Wenn du acht"
	line "weitere Orden"
	cont "verdienst,"

	para "kämpfen die Top"
	line "Vier mit all ihrer"
	cont "Kraft gegen dich."
	done

ElmGiveTicketText2:
	text "Das Schiff legt in"
	line "Oliviana City ab."

	para "Aber das weisst du"
	line "ja schon, <PLAYER>."

	para "Schliesslich bist"
	line "du mit deinen"

	para "#mon schon"
	line "viel herumge-"
	cont "kommen."

	para "Oh, da fällt mir"
	line "ein!"

	para "Der Duellturm hat"
	line "gerade in der Nähe"
	cont "von Oliviana auf-"
	cont "gemacht."

	para "Ein Champ wie du"
	line "sollte dort gut"
	cont "abschneiden!"
	done

LyraAnnouncesGymChallengeText:
	text "Lyra: Da bist du"
	line "ja, <PLAYER>!"

	para "Ich habe deinen"
	line "Kampf gegen den"
	cont "Champ im TV ge-"
	cont "sehen."

	para "Du warst unglaub-"
	line "lich!"

	para "Das hat mich echt"
	line "inspiriert,"
	cont "<PLAYER>."

	para "Auch wenn ich das"
	line "nie erreiche…"
	cont "ich will es ver-"
	cont "suchen."

	para "Ich will sehen,"
	line "wozu ich fähig"
	cont "bin."

	para "Prof. Lind, tut"
	line "mir leid, dass ich"
	cont "hier nicht mehr"
	cont "helfen kann."

	para "Ich werde alle"
	line "Arenen in Johto"
	cont "herausfordern und"

	para "es bis zur"
	line "#mon-Liga"
	cont "schaffen!"

	para "Wünsch mir Glück!"
	line "Bis später!"
	done

ElmAfterTicketText:
	text "Lind: Nun,"
	line "<PLAYER>, jetzt"

	para "habt ihr beide"
	line "eure eigene Reise."

	para "Ob sie wohl zuerst"
	line "die Liga erreicht?"

	para "Überbringe Prof."
	line "Eich in Kanto"
	cont "meine Grüsse!"
	done

ElmBeforeBattleText:
	text "Lind: <PLAYER>!"
	line "Wie läuft deine"
	cont "#mon-Reise bis"
	cont "jetzt?"
	done

ElmByTheWayText:
	text "Wo du gerade hier"
	line "bist, <PLAYER>…"
	done

ElmAskBattleText:
	text "Ich könnte etwas"
	line "Kampfpraxis gegen"

	para "ein Talent wie"
	line "dich gebrauchen."

	para "Wie wär's,"
	line "<PLAYER>?"
	done

ElmSeenText:
	text "Zeig mir, wie sehr"
	line "du gewachsen bist,"

	para "seit du Neuborkia"
	line "verlassen hast!"
	done

ElmWinText:
	text "Erstaunlich!"
	done

ElmLoseText:
	text "Hast du mich etwa"
	line "geschont?"
	done

ElmRefusedBattleText:
	text "Wenn deine #mon"
	line "Heilung brauchen,"

	para "benutze einfach"
	line "die Maschine hier."
	done


AideText_GiveYouPotions:
	text "<PLAYER>, ich"
	line "möchte, dass du"
	cont "das mitnimmst."
	done

AideText_AlwaysBusy:
	text "Wir sind nur zu"
	line "zweit und wir ha-"
	cont "ben viel zu tun."
	done

AideText_TheftTestimony:
	text "Wir haben ein lau-"
	line "tes Geräusch ge-"
	cont "hört…"

	para "Als wir nach dem"
	line "Rechten sahen,"
	cont "wurde ein #mon"
	cont "gestohlen."

	para "Ich kann nicht"
	line "glauben, dass je-"
	cont "mand zu so etwas"
	cont "fähig ist!"

	para "…Seufz… Das"
	line "gestohlene"
	cont "#mon."

	para "Ich frage mich,"
	line "wie es ihm geht."

	para "Man sagt, dass ein"
	line "#mon, das"

	para "von einem bösen"
	line "Menschen aufgezo-"
	cont "gen wird, selber"

	para "böse wird."
	done

ElmsLabOfficerText1:
	text "Ich hörte, dass"
	line "hier ein #mon"
	cont "gestohlen worden"
	cont "sei."

	para "Regel Nummer eins!"
	line "“Der Täter kehrt"

	para "immer an den Tat-"
	line "ort zurück…”"

	para "Oh je… Dann warst"
	line "du das also?"
	done

ElmsLabOfficerText2:
	text "Wie?"

	para "Du hast gegen ei-"
	line "nen solchen"
	cont "Trainer gekämpft?"

	para "Hat er dir auch"
	line "seinen Namen ge-"
	cont "nannt?"
	done

ElmsLabOfficerText3:
	text "O.K.! Sein Name"
	line "war also <RIVAL>."

	para "Danke, dass du mir"
	line "bei den Ermitt-"
	cont "lungen geholfen"
	cont "hast!"
	done

ElmsLabLyraWhichPokemonText:
	text "Welches #mon"
	line "wählst du,"
	cont "<PLAYER>?"
	done

LyraChoosesStarterText:
	text "Lyra: Dann nehme"
	line "ich dieses hier!"
	done

LyraReceivedStarterText:
	text "Lyra erhält"
	line ""
	text_ram wStringBuffer3
	text "!"
	done

LyraNicknamedChikoritaText:
	text "Lyra: Es ist so"
	line "süss! Ich nenne es"
	cont "Endivchen!"
	done

LyraNicknamedCyndaquilText:
	text "Lyra: Es ist so"
	line "süss! Ich nenne es"
	cont "Feuri!"
	done

LyraNicknamedTotodileText:
	text "Lyra: Es ist so"
	line "süss! Ich nenne es"
	cont "Nimi!"
	done


ElmsLabLyraChallengeText:
	text "Lyra: <PLAYER>!"
	line "Lernen wir unsere"

	para "#mon mit einem"
	line "Kampf kennen!"
	done

ElmsLabLyraWinText:
	text "Gut gemacht,"
	line "<PLAYER>!"
	done

ElmsLabLyraLossText:
	text "Juhu! Ich habe"
	line "gewonnen!"
	done

ElmsLabLyraText_YouWon:
ElmsLabLyraText_YouLost:
	text "Das war ein"
	line "spannender Kampf!"
	done

ElmsLabLyraThankYouText:
	text "Danke für das"
	line "#mon, Prof."
	cont "Lind."
	done

ElmsLabLyraSeeYouText:
	text "<PLAYER>, wir"
	line "sehen uns!"

	para "Viel Spass bei"
	line "deinem Auftrag!"
	done

ElmsLabLyraTheftInnocentText:
	text "Lyra: Moment mal!"
	line "<PLAYER> hat damit"
	cont "nichts zu tun!"

	para "Ich sah einen rot-"
	line "haarigen Jungen,"
	cont "der das Gebäude"
	cont "ausspioniert hat!"
	done

ElmsLabLyraTheftGoodbyeText:
	text "Lyra: <PLAYER>,"
	line "zum Glück hat er"

	para "verstanden, dass"
	line "du unschuldig"
	cont "bist."

	para "Hoffentlich bringt"
	line "er den Dieb dazu,"
	cont "das #mon"
	cont "zurückzugeben…"

	para "Also dann, bis"
	line "später!"
	done

ElmsLabWindowText1:
	text "Das Fenster ist"
	line "offen."

	para "Eine sanfte Brise"
	line "weht herein."
	done

ElmsLabWindowText2:
	text "Hier ist er he-"
	line "reingekommen!"
	done

ElmsLabTravelTip1Text:
	text "<PLAYER> öffnet"
	line "ein Buch."

	para "Reise-Tipp 1:"

	para "Drücke START, um"
	line "das Menü zu"
	cont "öffnen."
	done

ElmsLabTravelTip2Text:
	text "<PLAYER> öffnet"
	line "ein Buch."

	para "Reise-Tipp 2:"

	para "Speichere deine"
	line "Fortschritte mit"
	cont "Sichern!"
	done

ElmsLabTravelTip3Text:
	text "<PLAYER> öffnet"
	line "ein Buch."

	para "Reise-Tipp 3:"

	para "Öffne deinen"
	line "Beutel und drücke"
	cont "SELECT, um deine"
	cont "Items zu ver-"
	cont "walten."
	done

ElmsLabTravelTip4Text:
	text "<PLAYER> öffnet"
	line "ein Buch."

	para "Reise-Tipp 4:"

	para "Verwalte die At-"
	line "tacken deiner"
	cont "#mon. Drücke"
	cont "den A-Knopf, um"
	cont "ihre Position zu"
	cont "verändern."
	done

ElmsLabTrashcanText:
	text "Die Verpackung"
	line "des Snacks, den"
	cont "Prof. Lind geges-"
	cont "sen hat, befindet"
	cont "sich hier…"
	done
