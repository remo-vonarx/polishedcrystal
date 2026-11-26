CeladonUniversityCafeteria_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 13,  7, CELADON_UNIVERSITY_2F, 2
	warp_event 14,  7, CELADON_UNIVERSITY_2F, 2

	def_coord_events

	def_bg_events
	bg_event 10,  0, BGEVENT_JUMPTEXT, CeladonUniversityCafeteriaSignText

	def_object_events
	object_event 11,  2, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonUniversityCafeteriaCoreyScript, -1
	object_event  4,  2, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityCafeteriaCooltrainerfText, -1
	object_event  7,  3, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityCafeteriaBeautyText, -1
	object_event  2,  6, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityCafeteriaYoungster1Text, -1
	object_event  8,  6, SPRITE_LADY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityCafeteriaLadyText, -1
	object_event 11,  5, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonUniversityCafeteriaYoungster2Script, -1
	object_event  0,  3, SPRITE_BAKER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonUniversityCafeteriaBakerScript, -1

	object_const_def
	const CELADONUNIVERSITYCAFETERIA_COREY

CeladonUniversityCafeteriaCoreyScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_COOLTRAINERM_COREY
	iftruefwd .Beaten
	checkevent EVENT_INTRODUCED_CELADON_FOUR
	iftruefwd .IntroducedCeladonFour1
	writetext .IntroText1
	sjumpfwd .AfterIntro
.IntroducedCeladonFour1
	writetext .IntroText2
.AfterIntro
	yesorno
	iffalse_jumpopenedtext .NoBattleText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked CELADONUNIVERSITYCAFETERIA_COREY
	loadtrainer COOLTRAINERM, COOLTRAINERM_COREY
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERM_COREY
	opentext
.Beaten
	setevent EVENT_INTRODUCED_CELADON_FOUR
	checkevent EVENT_BEAT_COOLTRAINERM_RAYMOND
	iffalse_jumpopenedtext .AfterText1
	checkevent EVENT_BEAT_COOLTRAINERM_FERGUS
	iffalse_jumpopenedtext .AfterText1
	checkevent EVENT_BEAT_COOLTRAINERF_NEESHA
	iffalse_jumpopenedtext .AfterText1
	checkevent EVENT_GOT_CHOICE_BAND_FROM_CELADON_FOUR
	iftrue_jumpopenedtext .FinalText
	writetext .AfterText2
	promptbutton
	verbosegiveitem CHOICE_BAND, iffalse_jumpopenedtext CeladonUni_NoRoomText
	setevent EVENT_GOT_CHOICE_BAND_FROM_CELADON_FOUR
	jumpthisopenedtext

.FinalText:
	text "Du wärst hier ein"
	line "Spitzenstudent,"
	cont "wenn du dich ein-"
	cont "schreiben würdest."

	para "Aber du hast"
	line "andere Ziele,"
	cont "oder?"
	done

.IntroText1:
	text "Ich bin Corey! Ich"
	line "gehöre zu den vier"
	cont "besten Trainern"
	cont "der Prismania-Uni."

	para "Man nennt uns die"
	line "Prismania-Vier!"

	para "Lass mich dir in"
	line "einem kurzen"

	para "Kampf zeigen, wie"
	line "wir uns den Titel"
	cont "verdient haben!"
	done

.IntroText2:
	text "Ich bin Corey! Ich"
	line "gehöre zu den"
	cont "Prismania-Vier!"

	para "Du forderst uns"
	line "alle vier heraus?"

	para "Klar, ich bin hier"
	line "eh fertig mit"
	cont "Essen."

	para "Bist du bereit"
	line "für den Kampf?"
	done

.NoBattleText:
	text "Ja, wir können"
	line "einschüchternd"
	cont "sein."
	done

.SeenText:
	text "Das wird ein"
	line "Kinderspiel!"
	done

.BeatenText:
	text "Ich habe dich"
	line "unterschätzt…"
	done

.AfterText1:
	text "Du bist ein"
	line "starker Trainer!"

	para "Aber ich bin nur"
	line "einer der"
	cont "Prismania-Vier."

	para "Spür die anderen"
	line "auf, um deine"

	para "Stärke wirklich zu"
	line "testen!"
	done

.AfterText2:
	text "Du hast alle"
	line "Prismania-Vier"
	cont "besiegt?"

	para "Glückwunsch!"

	para "Nimm das als"
	line "Andenken!"
	done

CeladonUni_NoRoomText:
	text "Du kannst es nicht"
	line "tragen."
	done

CeladonUniversityCafeteriaCooltrainerfText:
	text "Hier gibt's die"
	line "besten Hacksteaks"
	cont "nach Zinnober-Art"
	cont "in ganz Kanto!"

	para "Fast wie zu"
	line "Hause."
	done

CeladonUniversityCafeteriaBeautyText:
	text "Der Koch hat end-"
	line "lich wieder eine"
	cont "Ladung Spezia-"
	cont "litäten gemacht!"

	para "Vielleicht hole"
	line "ich mir noch"
	cont "Nachschlag."
	done

CeladonUniversityCafeteriaYoungster1Text:
	text "Ich habe die Cafe-"
	line "teria gebeten,"
	cont "Stratos-Eis anzu-"
	cont "bieten."

	para "Es erinnert mich"
	line "an zu Hause, und"
	cont "es ist lecker!"
	done

CeladonUniversityCafeteriaLadyText:
	text "Ich mache Diät."
	line "Heute gibt's für"
	para "mich einen gesun-"
	line "den Schlaffsamen-"
	cont "Salat."
	done

CeladonUniversityCafeteriaYoungster2Script:
	checkevent EVENT_GOT_LEMONADE_IN_UNIVERSITY
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem LEMONADE, iffalse_jumpopenedtext CeladonUni_NoRoomText
	setevent EVENT_GOT_LEMONADE_IN_UNIVERSITY
	jumpopenedtext .Text2

.Text1:
	text "Der Getränkeauto-"
	line "mat hat mir ein"
	cont "Extra-Getränk"
	cont "gegeben!"

	para "Ich teile es mit"
	line "dir."
	done

.Text2:
	text "Nach einem harten"
	line "Kampf liebe ich"
	cont "eine kalte"
	cont "Limonade."
	done

CeladonUniversityCafeteriaBakerScript:
	faceplayer
	opentext
	checkflag ENGINE_BOUGHT_LEFTOVERS
	iftrue_jumpopenedtext .Text3
	writetext .Text1
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext .Text4
	checkmoney YOUR_MONEY, 4000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	giveitem LEFTOVERS, iffalse_jumpopenedtext .Text6
	setflag ENGINE_BOUGHT_LEFTOVERS
	waitsfx
	playsound SFX_TRANSACTION
	takemoney YOUR_MONEY, 4000
	special PlaceMoneyTopRight
	jumpthisopenedtext

.Text2:
	text "Bitte schön,"
	line "Schätzchen!"
	cont "Lass es dir"
	cont "schmecken!"
	done

.NotEnoughMoney:
	jumpthisopenedtext

	text "Du hast nicht"
	line "genügend Geld…"
	done

.Text1:
	text "Was ist,"
	line "Schätzchen?"

	para "Tut mir leid, das"
	line "Abendessen ist"
	cont "schon vorbei."

	para "Es gibt noch ein"
	line "paar Überreste,"

	para "aber die kosten"
	line "¥4000. Willst du?"
	done

.Text3:
	text "Heute gibt es"
	line "keine Überreste"
	cont "mehr."
	done

.Text4:
	text "Einen schönen Tag"
	line "noch!"
	done

.Text6:
	text "Du kannst das"
	line "nicht tragen,"
	cont "Schätzchen."
	done

CeladonUniversityCafeteriaSignText:
	text "Bitte räume nach"
	line "dem Essen auf."
	done
