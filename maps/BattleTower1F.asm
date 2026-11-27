BattleTower1F_MapScriptHeader:
	def_scene_scripts
	scene_script BattleTower1FContinueChallenge, SCENE_BATTLETOWER1F_CHECKSTATE
	scene_const SCENE_BATTLETOWER1F_NOOP

	def_callbacks

	def_warp_events
	warp_event 10, 15, BATTLE_TOWER_OUTSIDE, 3
	warp_event 11, 15, BATTLE_TOWER_OUTSIDE, 4
	warp_event 10,  0, BATTLE_TOWER_ELEVATOR, 1
	warp_event  0,  7, BATTLE_TOWER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 11,  7, BGEVENT_READ, BattleTower1FRulesScript
	bg_event  9,  7, BGEVENT_JUMPTEXT, BattleTower1FStreakText
	bg_event 21,  8, BGEVENT_READ, PokemonJournalPalmerScript

	def_object_events
	object_event 10,  7, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BattleTower1FReceptionistScript, -1
	pc_nurse_event  6,  8
	object_event 14,  8, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_BP, MART_BATTLETOWER_1, -1
	object_event 16,  8, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_BP, MART_BATTLETOWER_2, -1
	object_event 18,  8, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_BP, MART_BATTLETOWER_3, -1
	object_event  6, 14, SPRITE_BURGLAR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTowerPharmacistScript, -1
	object_event 16, 13, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Text_BattleTowerCooltrainerF, -1
	object_event  2, 12, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Text_BattleTowerBugCatcher, -1
	object_event 20, 11, SPRITE_GRANNY, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Text_BattleTowerGranny, -1

	object_const_def
	const BATTLETOWER1F_RECEPTIONIST

BattleTower1FContinueChallenge:
; Triggers (usefully) if we're in an ongoing Battle Tower run.
	; Only trigger this once.
	setscene SCENE_BATTLETOWER1F_NOOP

	; Check current battle status to see if we need to resume or reset winstreak
	special Special_BattleTower_GetChallengeState
	ifequalfwd BATTLETOWER_CHALLENGE_IN_PROGRESS, .LeftWithoutSaving
	ifequalfwd BATTLETOWER_SAVED_AND_LEFT, .ResumeChallenge
	ifequalfwd BATTLETOWER_LOST_CHALLENGE, .LostChallenge
	ifequalfwd BATTLETOWER_WON_CHALLENGE, .WonChallenge
	end

.ResumeChallenge:
	; We saved in-between rounds. Resume Battle Tower challenge.
	opentext
	writethistext
		text "Wir haben schon"
		line "auf dich gewartet."
		prompt

	sdefer Script_ReturnToBattleTowerChallenge
	end

.LeftWithoutSaving:
	; The player reset the game in the middle of a battle.
	; This counts as a battle loss, and will reset the winstreak.
	sdefer .LeftWithoutSaving2
	end

.LeftWithoutSaving2:
	opentext
	writethistext
		text "Entschuldigung!"
		line "Du hast vor Ver-"
		cont "lassen des Kampf-"
		cont "raums vergessen"
		cont "zu sichern."
		para "Es tut mir Leid,"
		line "aber deine Heraus-"
		cont "forderung wird für"
		cont "ungültig erklärt."
		done
	waitbutton
	sjumpfwd Script_CommitBattleTowerResult

.LostChallenge:
	opentext
	sdefer Script_CommitBattleTowerResult
	end

.WonChallenge:
	sdefer .WonChallenge2
	end

.WonChallenge2:
	opentext
	writethistext
		text "Glückwunsch!"
		para "Du hast alle Trai-"
		line "ner besiegt! Dafür"
		para "erhältst du einen"
		line "Preis!"
		para ""
		prompt
	; Commit the challenge result even if the Bag cannot fit the prize.
	verbosegiveitem_unsafe ABILITYPATCH
	; fallthrough
Script_CommitBattleTowerResult:
	special Special_BattleTower_CommitChallengeResult
	iffalsefwd .WeHopeToServeYouAgain
	setevent EVENT_BEAT_PALMER
.WeHopeToServeYouAgain:
	writethistext
		text "Wir stehen stets"
		line "zu Diensten."
		done
	waitbutton
	endtext

BattleTower1FRulesScript:
	opentext
	writethistext
		text "Hier stehen die"
		line "Regeln des Duell-"
		cont "turms. Lesen?"
		done
	yesorno
	iffalse_endtext
	jumpthisopenedtext
		text "Drei #mon"
		line "dürfen am Kampf"

		para "teilnehmen. Sie"
		line "müssen unter-"
		cont "schiedlich sein."

		para "Ihre Items müssen"
		line "auch verschieden"

		para "sein. Eier und"
		line "bestimmte legen-"
		cont "däre #mon sind"
		cont "nicht zugelassen."
		done

BattleTower1FStreakText:
	text "Siegesserie: "
	text_decimal wBattleTowerCurStreak, 2, 5
	line "Rekord: "
	text_decimal wBattleTowerTopStreak, 2, 5
	done

BattleTower1FReceptionistScript:
	opentext
	writethistext
		text "Willkommen im"
		line "Duellturm!"
		para "Ich führe dich in"
		line "einen Kampfraum."
		done
	promptbutton
	checkevent EVENT_BATTLE_TOWER_INTRO
	iftruefwd .BattleTowerMenu

	; only ask once, so set the flag regardless
	setevent EVENT_BATTLE_TOWER_INTRO
	writethistext
		text "Soll ich dich über"
		line "den Duellturm"
		cont "aufklären?"
		done
	yesorno
	iffalsefwd .BattleTowerMenu

.Explanation:
	writethistext
		text "Der Duellturm ist"
		line "eine Kampfstätte"
		cont "für #mon."

		para "Unzählige #mon-"
		line "Trainer von Nah"

		para "und Fern kommen"
		line "hier zusammen und"

		para "duellieren sich in"
		line "speziellen"

		para "Kampfräumen."
		line "Im Duellturm gibt"

		para "es viele"
		line "Kampfräume."

		para "In jedem Raum sind"
		line "sieben Trainer."

		para "Besiegst du alle,"
		line "bekommst du"
		cont "Gewinnpunkte."

		para "Um eine"
		line "Herausforderung zu"

		para "unterbrechen,"
		line "musst du sichern."

		para "Falls du nicht"
		line "sicherst, kannst"

		para "du den Kampf nicht"
		line "fortsetzen."
		prompt
	; fallthrough
.BattleTowerMenu:
	; Setscene here in case the player aborted a quicksave prompted by challenge
	setscene SCENE_BATTLETOWER1F_NOOP
	writethistext
		text "Möchtest du in"
		line "einen Kampfraum?"
		done
	loadmenu MenuDataHeader_BattleInfoCancel
	verticalmenu
	closewindow
	ifequalfwd $1, .Challenge
	ifequal $2, .Explanation
	writethistext
		text "Wir stehen stets"
		line "zu Diensten."
		prompt
	endtext

.Challenge:
	writethistext
		text "Wähle die #mon"
		line "zur Teilnahme."
		prompt
	special Special_BattleTower_SelectParticipants
	iffalse .BattleTowerMenu
	writethistext
		text "Ehe du einen"
		line "Kampfraum"
		para "betrittst, wird"
		line "der Spielstand"
		cont "gesichert."
		done
	yesorno
	iffalse .BattleTowerMenu
	; Done here to ensure it's saved in case the player resets later.
	; The scene script running after the player saves but before the
	; challenge starts is harmless since there's no challenge prepared.
	setscene SCENE_BATTLETOWER1F_CHECKSTATE
	special Special_TryQuickSave
	iffalse .BattleTowerMenu

	; Initializes opponent trainers and stores player mon choices in SRAM
	special Special_BattleTower_BeginChallenge
	; fallthrough
Script_ReturnToBattleTowerChallenge:
	; From this point onwards, resetting the game should count as a streak loss
	setscene SCENE_BATTLETOWER1F_CHECKSTATE
	setval BATTLETOWER_CHALLENGE_IN_PROGRESS
	special Special_BattleTower_SetChallengeState

	; Everything ready to go for challenge start
	writethistext
		text "Hier entlang in"
		line "den Kampfraum."
		done
	waitbutton
	closetext

	musicfadeout MUSIC_NONE, 8
	follow BATTLETOWER1F_RECEPTIONIST, PLAYER
	applymovement BATTLETOWER1F_RECEPTIONIST, .WalkToElevator
	stopfollow
	special Special_BattleTower_MaxVolume
	warpsound
	disappear BATTLETOWER1F_RECEPTIONIST
	applyonemovement PLAYER, step_up
	warpcheck
	end

.WalkToElevator:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

MenuDataHeader_BattleInfoCancel:
	db MENU_BACKUP_TILES
	menu_coords 11, 4, 19, 11
	dw MenuData2_BattleInfoCancel
	db 1 ; default option

MenuData2_BattleInfoCancel:
	db $a0 ; flags
	db 3
	db "Kampf@"
	db "Info@"
	db "Zurück@"

BattleTowerPharmacistScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_TRICK_INTRO
	iftruefwd BattleTowerTutorTrickScript
	writethistext
		text "Die Trainer hier"
		line "setzen getragene"
		cont "Items gezielt ein."

		para "Aber ich habe noch"
		line "einen Trick auf"
		cont "Lager: Ich tausche"

		para "ihre Items mit"
		line "Trickbetrug gegen"
		cont "meine aus!"
		done
	waitbutton
	setevent EVENT_LISTENED_TO_TRICK_INTRO
BattleTowerTutorTrickScript:
	writethistext
		text "Ich bringe deinen"
		line "#mon"

		para "Trickbetrug bei…"
		line "für ein Silber-"
		cont "blatt."
		done
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writethistext
		text "Soll ich deinem"
		line "#mon Trick-"
		cont "betrug beibringen?"
		done
	yesorno
	iffalsefwd .TutorRefused
	setval TRICK
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpthisopenedtext
		text "Sprich mich an,"
		line "wenn du es dir"
		cont "anders überlegst."
		done

.NoSilverLeaf
	jumpthisopenedtext
		text "Tse. Du hast kein"
		line "Silberblatt…"
		done

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext
		text "Jetzt beherrscht"
		line "dein #mon auch"
		cont "Trickbetrug!"
		cont "Ist das nicht"
		cont "hinterhältig?"
		done

Text_BattleTowerCooltrainerF:
	text "Es gibt viele"
	line "Kampfräume, aber"

	para "ich werde in allen"
	line "gewinnen!"
	done

Text_BattleTowerGranny:
	text "Es ist eine zer-"
	line "mürbende Aufgabe,"

	para "ohne Items kämpfen"
	line "zu müssen."

	para "Gib deinen #mon"
	line "Items. Das ist der"

	para "Schlüssel zum"
	line "Erfolg."
	done

Text_BattleTowerBugCatcher:
	text "Ich probiere, wie"
	line "weit ich nur mit"

	para "Käfer-#mon"
	line "komme."

	para "Hoffentlich treffe"
	line "ich nicht auf"
	cont "Feuer-#mon…"
	done

PokemonJournalPalmerScript:
	setflag ENGINE_READ_PALMER_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Turm-Tycoon"
	cont "Viktor!"

	para "Viktor soll in der"
	line "Sinnoh-Region"

	para "einen Sohn haben,"
	line "der wie er Trainer"
	cont "werden will."
	done
