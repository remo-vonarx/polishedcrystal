GoldenrodPokecomCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, JudgeMachineScreenCallback

	def_warp_events
	warp_event  6, 15, GOLDENROD_CITY, 15
	warp_event  7, 15, GOLDENROD_CITY, 15
	warp_event  1,  6, GOLDENROD_POKECOM_CENTER_OFFICE, 2
	warp_event  0, 15, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 11,  7, BGEVENT_READ, PokemonJournalWhitneyScript
	bg_event 24,  5, BGEVENT_RIGHT, JudgeMachineScript
	bg_event 24,  6, BGEVENT_RIGHT, JudgeMachineScript
	bg_event 24,  7, BGEVENT_RIGHT, JudgeMachineScript
	bg_event 24,  8, BGEVENT_RIGHT, JudgeMachineScript
	bg_event 24,  9, BGEVENT_RIGHT, JudgeMachineScript
	bg_event 24, 10, BGEVENT_RIGHT, JudgeMachineScript
	bg_event 25, 11, BGEVENT_UP, JudgeMachineScript
	bg_event 26, 11, BGEVENT_UP, JudgeMachineScript
	bg_event 27, 11, BGEVENT_UP, JudgeMachineScript
	bg_event 28, 11, BGEVENT_UP, JudgeMachineScript
	bg_event 29,  5, BGEVENT_LEFT, JudgeMachineScript
	bg_event 29,  6, BGEVENT_LEFT, JudgeMachineScript
	bg_event 29,  7, BGEVENT_LEFT, JudgeMachineScript
	bg_event 29,  8, BGEVENT_LEFT, JudgeMachineScript
	bg_event 29,  9, BGEVENT_LEFT, JudgeMachineScript
	bg_event 29, 10, BGEVENT_LEFT, JudgeMachineScript
	bg_event 24,  3, BGEVENT_ITEM + RARE_CANDY, EVENT_GOLDENROD_POKECOM_CENTER_1F_HIDDEN_RARE_CANDY

	def_object_events
	object_event 23, 10, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, JudgeMachineEngineerScript, EVENT_JUDGE_MACHINE_ENGINEER
	object_event  7,  7, SPRITE_BOWING_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FNurseScript, -1
	object_event  0, 12, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodPokecenter1FGameboyKidText, -1
	object_event  3, 11, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodPokecenter1FLassText, -1
	object_event 12, 14, SPRITE_MATRON, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FPokefanF, -1
	object_event 16,  8, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, WonderTradeReceptionistScript, -1
	object_event  8, 13, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodPokecenter1FSuperNerdText, -1
	object_event 27, 13, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodPokecenter1FPokefanFText_Sunflora, -1
	object_event 21,  6, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodPokecenter1FRockerText, -1
	object_event 18, 13, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodPokecenter1FGrampsText, -1
	object_event 18,  9, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodPokecenter1FLassText_PidgeyMail, -1
	object_event  3,  9, SPRITE_BOULDER_ROCK, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_POKECOM_SIGN, OBJECTTYPE_SCRIPT, 0, InfoSignScript, -1
	object_event 23,  3, SPRITE_FLOATING_BALL, SPRITEMOVEDATA_POKECOM_NEWS, 0, 0, -1, PAL_NPC_POKECOM_SIGN, OBJECTTYPE_COMMAND, end, NULL, -1

	object_const_def
	const GOLDENRODPOKECOMCENTER1F_ENGINEER

JudgeMachineScreenCallback:
	checkflag ENGINE_JUDGE_MACHINE
	iffalsefwd .Done
	changeblock 24, 0, $49
	changeblock 26, 0, $4a
	changeblock 28, 0, $4b
	changeblock 24, 2, $4c
	changeblock 26, 2, $4d
	changeblock 28, 2, $4e
.Done
	endcallback

GoldenrodPokecenter1FNurseScript:
	setevent EVENT_WELCOMING_TO_POKECOM_CENTER
	jumpstd pokecenternurse

GoldenrodPokecenter1FGameboyKidText:
	text "Im oberen Stock-"
	line "werk findest du"

	para "das Kolosseum."
	line "Hier kannst du"

	para "gegen Freunde"
	line "antreten."

	para "Kampfergebnisse"
	line "werden an der Wand"

	para "ausgehängt. Ich"
	line "kann es mir nicht"

	para "erlauben, zu ver-"
	line "lieren."
	done

GoldenrodPokecenter1FLassText:
	text "Ein starkes #-"
	line "mon muss nicht"
	cont "zwingend gewinnen."

	para "Meist entscheidet"
	line "der Vor- oder"
	cont "Nachteil des Typs."

	para "Ich glaube nicht,"
	line "dass es ein #-"
	cont "mon gibt, das al-"
	cont "len anderen über-"
	cont "legen ist."
	done

GoldenrodPokecenter1FPokefanF:
	checkevent EVENT_GOT_EVIOLITE_IN_GOLDENROD
	iftrue_jumptextfaceplayer GoldenrodPokecenter1FPokefanFGotEvioliteText
	faceplayer
	opentext
	writetext GoldenrodPokecenter1FPokefanFDoYouHaveEonMailText
	waitbutton
	checkitem EON_MAIL
	iffalse_jumpopenedtext GoldenrodPokecenter1FPokefanFTooBadText
	writetext GoldenrodPokecenter1FAskGiveAwayAnEonMailText
	yesorno
	iffalse_jumpopenedtext GoldenrodPokecenter1FPokefanFTooBadText
	takeitem EON_MAIL
	writetext GoldenrodPokecenter1FPlayerGaveAwayTheEonMailText
	waitbutton
	writetext GoldenrodPokecenter1FPokefanFThisIsForYouText
	waitbutton
	verbosegiveitem EVIOLITE, iffalsefwd .NoRoomForEviolite
	setevent EVENT_GOT_EVIOLITE_IN_GOLDENROD
	jumpthisopenedtext

	text "Meine Tochter wird"
	line "entzückt sein!"
	done

.NoRoomForEviolite:
	; Refund the Mail just removed from the Bag.
	giveitem_unsafe EON_MAIL
	jumpthisopenedtext

	text "Oh… Ein anderes"
	line "Mal vielleicht."
	done

GoldenrodPokecenter1FPokefanFDoYouHaveEonMailText:
	text "Oh je, dein Beutel"
	line "sieht schwer aus!"

	para "Oh! Hast du zufäl-"
	line "lig etwas, das man"
	cont "Anara-Brief nennt?"

	para "Meine Tochter"
	line "sucht danach."

	para "Du gibst mir doch"
	line "einen, nicht wahr?"
	done

GoldenrodPokecenter1FAskGiveAwayAnEonMailText:
	text "Anara-Brief"
	line "weggeben?"
	done

GoldenrodPokecenter1FPokefanFThisIsForYouText:
	text "Oh, großartig!"
	line "Danke, Schatz!"

	para "Hier, als Aus-"
	line "gleich sollst"
	cont "du das haben!"
	done

GoldenrodPokecenter1FPokefanFTooBadText:
	text "Oh? Du hast"
	line "keinen? Schade."
	done

GoldenrodPokecenter1FPlayerGaveAwayTheEonMailText:
	text "<PLAYER> gibt den"
	line "Anara-Brief weg."
	done

GoldenrodPokecenter1FPokefanFGotEvioliteText:
	text "Danke für den"
	line "Anara-Brief!"

	para "Meine Tochter wird"
	line "sich freuen!"
	done

WonderTradeReceptionistScript:
	opentext
	writetext WonderTradeIntroText
	waitbutton
	checkevent EVENT_INTRODUCED_TEALA
	iftruefwd .introduced
	writetext IntroduceTealaText
	waitbutton
	setevent EVENT_INTRODUCED_TEALA
.introduced
	writetext WonderTradeExplanationText
	promptbutton
	special WonderTrade
	iffalsefwd .done
	playmusic MUSIC_POKECOM_CENTER
	writetext WonderTradeCompleteText
	playsound SFX_DEX_FANFARE_80_109
	waitsfx
	ifnotequal 2, .done
	setevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	setevent EVENT_CAN_GIVE_GS_BALL_TO_KURT
	playmusic MUSIC_SPIKY_EARED_PICHU_HGSS
	writetext WonderTradeForGSBallPichuText
	promptbutton
	verbosegivekeyitem GS_BALL
	writetext WonderTradeForGSBallPichuText2
	waitbutton
.done
	jumpthisopenedtext

	text "Komm jederzeit"
	line "wieder vorbei!"
	done

WonderTradeIntroText:
	text "Hallo! Willkommen"
	line "in der Wunder-"
	cont "tausch-Zentrale"
	cont "im #Kom-Center."
	done

IntroduceTealaText:
	text "Ich bin Teala und"
	line "kümmere mich um"
	cont "deinen Tausch."
	done

WonderTradeExplanationText:
	text "Du kannst #mon"
	line "mit Leuten in"
	cont "weiter Ferne"
	cont "tauschen."
	done

WonderTradeCompleteText:
	text "Das ist dein neuer"
	line "Partner."

	para "Bitte kümmere dich"
	line "liebevoll darum."
	done


WonderTradeForGSBallPichuText:
	text "…Aber was ist das?"
	line "Stimmt etwas nicht"

	para "mit der Wunder-"
	line "tausch-Maschine?"

	para "Es sieht so aus,"
	line "als hättest du"

	para "gerade mit dir"
	line "selbst ein #mon"
	cont "getauscht."

	para "Aber das kann"
	line "nicht sein… Du"

	para "kannst nicht an"
	line "zwei Orten zu-"
	cont "gleich sein."

	para "Außerdem verbindet"
	line "die Maschine durch"

	para "den Raum, nicht"
	line "durch die Zeit…"

	para "Und was ist das"
	line "für ein seltsamer"
	cont "Ball, den es hält?"

	para "Ist das ein Apri-"
	line "koko-Ball?"

	para "Hier, sieh mal…"
	done

WonderTradeForGSBallPichuText2:
	text "Es mag ungewöhn-"
	line "lich sein, aber"
	cont "ein #mon bleibt"
	cont "ein #mon."

	para "Bitte kümmere dich"
	line "gut darum."
	done

InfoSignScript:
	jumpthistext

	text "#Kom-Center"
	line "EG: Information"

	para "Links:"
	line "Verwaltung"

	para "Mitte:"
	line "Wundertausch-"
	cont "Zentrale"

	para "Rechts: <PK><MN>"
	line "Richter-Maschine"
	done

PokemonJournalWhitneyScript:
	setflag ENGINE_READ_WHITNEY_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Arenaleiterin"
	cont "Bianka!"

	para "Bianka soll Bruno"
	line "von den Top Vier"
	cont "bewundern."
	done

JudgeMachineScript:
	opentext
	special JudgeMachine
	waitendtext

GoldenrodPokecenter1FSuperNerdText:
	text "Wow, dieses"
	line "#mon-Center ist"
	cont "riesig."

	para "Sie haben es gera-"
	line "de erst gebaut und"

	para "auch viele neue"
	line "Maschinen instal-"
	cont "liert."
	done

GoldenrodPokecenter1FLassText_PidgeyMail:
	text "Ich hatte eine"
	line "lustige Idee für"
	cont "den Wundertausch!"

	para "Ich lasse ein"
	line "Taubsi einen Brief"

	para "tragen und biete"
	line "es zum Tausch an!"

	para "Wenn das alle"
	line "machen würden,"

	para "könnten Briefe mit"
	line "allen möglichen"
	cont "Leuten getauscht"
	cont "werden!"

	para "Ich nenne es"
	line "Taubsi-Post!"

	para "Wenn es beliebt"
	line "wird, finde ich"

	para "vielleicht viele"
	line "neue Freunde!"
	done

JudgeMachineEngineerScript:
	checkevent EVENT_BRED_AN_EGG
	iffalsefwd .NotBredYet
	showtextfaceplayer JudgeMachineEngineerFinishedText
	readvar VAR_FACING
	ifnotequal RIGHT, .GoLeft
	applyonemovement GOLDENRODPOKECOMCENTER1F_ENGINEER, step_down
	applyonemovement GOLDENRODPOKECOMCENTER1F_ENGINEER, step_left
.GoLeft
	applymovement GOLDENRODPOKECOMCENTER1F_ENGINEER, JudgeMachineEngineerLeavesMovement
	disappear GOLDENRODPOKECOMCENTER1F_ENGINEER
	setflag ENGINE_JUDGE_MACHINE
	changeblock 24, 0, $49
	changeblock 26, 0, $4a
	changeblock 28, 0, $4b
	changeblock 24, 2, $4c
	changeblock 26, 2, $4d
	changeblock 28, 2, $4e
	end

.NotBredYet:
	showtextfaceplayer JudgeMachineEngineerWorkingText
	turnobject LAST_TALKED, RIGHT
	end

JudgeMachineEngineerWorkingText:
	text "Die #mon-"
	line "Richter-Maschine…"

	para "Davon träume ich"
	line "schon lange."

	para "Das #Kom-Center"
	line "finanziert meine"
	cont "Arbeit, also wird"
	cont "der Traum wahr,"

	para "selbst wenn es"
	line "einen Computer so"
	cont "groß wie ein Raum"
	cont "braucht!"

	para "Stell dir vor, wie"
	line "nützlich sie für"
	cont "Züchter ist, die"
	cont "viele Eier aus-"
	cont "brüten!"

	para "Ich bin fast"
	line "fertig…"
	done

JudgeMachineEngineerFinishedText:
	text "Die #mon-"
	line "Richter-Maschine…"

	para "Endlich fertig!"
	line "Mein Traum ist"
	cont "wahr geworden!"

	para "Was sie ist?"
	line "Eine Maschine, die"

	para "die Statuswerte"
	line "jedes #mon"
	cont "bewertet!"

	para "Mit modernster KI-"
	line "Technik beurteilt"

	para "sie das angeborene"
	line "Potenzial eines"
	cont "#mon und die"

	para "Mühe, die es ins"
	line "Stärkerwerden"
	cont "gesteckt hat."

	para "Der perfekte Weg,"
	line "die Stärke eines"
	cont "#mon zu messen!"

	para "Probier sie ruhig"
	line "aus. Sie ist"
	cont "völlig sicher."

	para "Und ich mache"
	line "jetzt Urlaub!"
	done

JudgeMachineEngineerLeavesMovement:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

GoldenrodPokecenter1FPokefanFText_Sunflora:
	text "Ein Mädchen, das"
	line "ich nicht kenne,"
	cont "hat mir ihr Sonn-"
	cont "flora geschickt."

	para "Tausch dir ein"
	line "#mon, das du"
	cont "haben willst."
	done

GoldenrodPokecenter1FRockerText:
	text "Noch sind nicht"
	line "alle Maschinen"
	cont "hier nutzbar."

	para "Trotzdem ist es"
	line "toll, vor allen"

	para "anderen an so"
	line "einen angesagten"
	cont "Ort zu kommen."
	done

GoldenrodPokecenter1FGrampsText:
	text "Allein das Be-"
	line "trachten dieser"

	para "neuen Errungen-"
	line "schaften macht"
	cont "mich jünger!"
	done
