MystriStage_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_MYSTRISTAGE_NOOP
	scene_const SCENE_MYSTRISTAGE_ARCEUS_EVENT

	def_callbacks

	def_warp_events
	warp_event  6, 19, SINJOH_RUINS, 1
	warp_event  7, 19, SINJOH_RUINS, 1

	def_coord_events
	coord_event  6, 11, SCENE_MYSTRISTAGE_ARCEUS_EVENT, MystriStageTrigger1Script
	coord_event  7, 11, SCENE_MYSTRISTAGE_ARCEUS_EVENT, MystriStageTrigger2Script

	def_bg_events

	def_object_events
	object_event  6, 10, SPRITE_CYNTHIA, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, MystriStageCynthiaSafeguardScript, EVENT_LISTENED_TO_CYNTHIA_INTRO
	object_event  7,  7, SPRITE_CYNTHIA, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, MystriStageCynthiaScript, EVENT_MYSTRI_STAGE_CYNTHIA
	object_event  6,  8, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, EGG, -1, PAL_MON_BLUE, OBJECTTYPE_SCRIPT, NO_FORM, MystriStageEggScript, EVENT_MYSTRI_STAGE_EGG

	object_const_def
	const MYSTRISTAGE_CYNTHIA1
	const MYSTRISTAGE_CYNTHIA2
	const MYSTRISTAGE_EGG

MystriStageTrigger2Script:
	applyonemovement PLAYER, step_up
MystriStageTrigger1Script:
	faceobject PLAYER, MYSTRISTAGE_CYNTHIA1
	pause 10
	showemote EMOTE_SHOCK, MYSTRISTAGE_CYNTHIA1, 15
	pause 10
	faceobject MYSTRISTAGE_CYNTHIA1, PLAYER
MystriStageCynthiaSafeguardScript:
	showtext MystriStageCynthiaIntroText
	follow MYSTRISTAGE_CYNTHIA1, PLAYER
	applymovement MYSTRISTAGE_CYNTHIA1, MystriStageMovementData_CynthiaStepsUp
	stopfollow
	turnobject MYSTRISTAGE_CYNTHIA1, LEFT
	turnobject PLAYER, RIGHT
	showtext MystriStageCynthiaSpeechText
	showemote EMOTE_SHOCK, MYSTRISTAGE_CYNTHIA1, 15
	showtext MystriStageCynthiaLeadText2
	pause 10
	appear MYSTRISTAGE_CYNTHIA2
	disappear MYSTRISTAGE_CYNTHIA1
	setlasttalked MYSTRISTAGE_CYNTHIA2
	setevent EVENT_LISTENED_TO_CYNTHIA_INTRO
	setscene SCENE_MYSTRISTAGE_NOOP
	; fallthrough

MystriStageCynthiaScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CYNTHIA
	iftruefwd MystriStageBeatCynthiaScript
	writetext MystriStageCynthiaIdeaText
	waitbutton
	checkevent EVENT_BEAT_ELITE_FOUR
	iffalse_jumpopenedtext MystriStageCynthiaNotNowText
	writetext MystriStageCynthiaChallengeText
	yesorno
	iffalse_jumpopenedtext MystriStageCynthiaNoText
	writetext MystriStageCynthiaYesText
	waitbutton
	closetext
	winlosstext MystriStageCynthiaWinText, 0
	setlasttalked MYSTRISTAGE_CYNTHIA2
	loadtrainer CYNTHIA, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CYNTHIA
	opentext
MystriStageBeatCynthiaScript:
	checkevent EVENT_GOT_WISE_GLASSES_FROM_CYNTHIA
	iftrue_jumpopenedtext MystriStageCynthiaFinalText
	writetext MystriStageCynthiaItemText
	waitbutton
	verbosegiveitem WISE_GLASSES, iffalse_endtext
	setevent EVENT_GOT_WISE_GLASSES_FROM_CYNTHIA
	writetext MystriStageCynthiaAfterText
	waitbutton
	closetext
	pause 15
	showemote EMOTE_SHOCK, MYSTRISTAGE_CYNTHIA2, 15
	special Special_FadeOutMusic
	pause 15
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	pause 15
	playsound SFX_UNKNOWN_60
	waitsfx
	pause 20
	playsound SFX_METRONOME
	waitsfx
	special Special_FadeInQuickly
	pause 10
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	playsound SFX_PROTECT
	waitsfx
	special Special_FadeInQuickly
	pause 10
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	pause 20
	playsound SFX_EGG_HATCH
	waitsfx
	appear MYSTRISTAGE_EGG
	faceplayer
	pause 30
	special RestartMapMusic
	special Special_FadeInQuickly
	pause 20
	turnobject MYSTRISTAGE_CYNTHIA2, DOWN
	pause 40
	jumpthistextfaceplayer

	text "Cynthia: Könnte"
	line "das… ein Ei sein?"

	para "Haben wir gerade"
	line "genau den Moment"

	para "miterlebt, in dem"
	line "ein Ei auf diese"
	cont "Welt kam?"

	para "Einen Moment, den"
	line "noch nie jemand"
	cont "gesehen hat?"
	done

MystriStageEggScript:
	special GiveMystriEgg
	iffalse_jumptext MystriStageNoRoomText
	disappear MYSTRISTAGE_EGG
	opentext
	writetext MystriStageEggText
	playsound SFX_KEY_ITEM
	waitsfx
	ifequalfwd 1, .InParty
	special Special_CurBoxFullCheck
	iffalsefwd .BoxNotFull
	farwritetext _CurBoxFullText
.BoxNotFull
	special GetCurBoxName
	farwritetext _EggSentToPCText
.InParty
	waitendtext

MystriStageCynthiaIntroText:
	text "Mein Name ist"
	line "Cynthia. Ich bin"
	cont "#mon-Trainerin."

	para "Und wer bist du?"

	para "…Verstehe. Die"
	line "Kraft der Icognito"
	cont "hat dich herge-"
	cont "bracht."
	done

MystriStageCynthiaSpeechText:
	text "Cynthia: Dies sind"
	line "die Sinjoh-Ruinen."

	para "Vor langer Zeit…"
	line "kamen Menschen aus"

	para "Sinnoh, meiner"
	line "Heimatregion, um"
	cont "hier zu leben."

	para "Sie müssen Heimweh"
	line "gehabt haben"

	para "und erbauten die-"
	line "sen Tempel, um"
	cont "ihre Traditionen"
	cont "zu ehren."

	para "Wir stehen auf dem"
	line "Trysteriumaltar."

	para "Hier feierten"
	line "Menschen einst mit"
	cont "Musik und Tanz."

	para "Cynthia: Ich"
	line "erforsche Mythen"

	para "über alte Stätten"
	line "wie die Sinjoh-"
	cont "Ruinen."

	para "Einer besagt, dass"
	line "dieser Altar"

	para "von der Kraft der"
	line "Schöpfung erfüllt"
	cont "ist."

	para "Er erzählt davon,"
	line "wenn “der"
	cont "Auserwählte den"

	para "Trysteriumaltar"
	line "endlich betritt…”"
	done

MystriStageCynthiaLeadText2:
	text "Cynthia: Was? Du"
	line "hast diesen Satz"

	para "in den Alph-Ruinen"
	line "gelesen?"

	para "Das ist sehr"
	line "faszinierend."

	para "Könnte “der"
	line "Auserwählte” ein"
	cont "#mon sein? Oder"
	cont "ein Mensch?"
	done

MystriStageCynthiaIdeaText:
	text "Cynthia: …Ich habe"
	line "eine Idee. Nenn es"

	para "die Intuition"
	line "einer Trainerin."

	para "Wenn du und ich"
	line "auf diesem Altar"

	para "kämpfen, wird"
	line "etwas geschehen."
	done

MystriStageCynthiaNotNowText:
	text "Cynthia: Aber ich"
	line "glaube nicht, dass"

	para "wir jetzt kämpfen"
	line "sollten. Du bist"
	cont "noch nicht bereit."

	para "Komm wieder, wenn"
	line "du die Top Vier"
	cont "besiegt hast."
	done

MystriStageCynthiaChallengeText:
	text "Cynthia: Bist du"
	line "bereit, mein"
	cont "Gegner zu sein?"
	done

MystriStageCynthiaNoText:
	text "Cynthia: Komm"
	line "wieder, wenn du"
	cont "bereit bist."
	done

MystriStageCynthiaYesText:
	text "Cynthia: Bevor ich"
	line "meine #mon"
	cont "rufe, fängt mein"

	para "Herz immer an zu"
	line "rasen…"
	done

MystriStageCynthiaWinText:
	text "Ich weiß nicht"
	line "mehr, wann ich"

	para "zuletzt so über-"
	line "troffen wurde!"
	done

MystriStageCynthiaItemText:
	text "Cynthia: Das hat"
	line "meine Erwartungen"
	cont "übertroffen!"

	para "Was für ein"
	line "außergewöhnlicher"
	cont "Kampf!"

	para "Bitte nimm dieses"
	line "Item. Ich glaube,"

	para "du weißt es gut"
	line "einzusetzen."
	done

MystriStageCynthiaAfterText:
	text "Cynthia: Aber hat"
	line "unser Kampf den"
	cont "Trysteriumaltar"
	cont "beeinflusst?"
	done


MystriStageCynthiaFinalText:
	text "Cynthia: Ein Ei"
	line "ist die Wiege"
	cont "allen Lebens."

	para "Der Planet selbst"
	line "ist in gewisser"
	cont "Weise ein Ei…"

	para "Leben, das aus"
	line "einem Ei kommt,"
	cont "wird irgendwann"

	para "enden… um neu zu"
	line "beginnen…"
	done

MystriStageEggText:
	text "<PLAYER> findet"
	line "ein mysteriöses"
	cont "Ei!"
	done

MystriStageNoRoomText:
	text "Du hast keinen"
	line "Platz dafür, nicht"
	cont "mal in der Box!"
	done

MystriStageMovementData_CynthiaStepsUp:
	step_up
	step_up
	step_up
	step_right
	step_end
