CeladonUniversityLounge_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 11, CELADON_UNIVERSITY_1F, 10
	warp_event  5, 11, CELADON_UNIVERSITY_1F, 10

	def_coord_events

	def_bg_events
	bg_event  7,  5, BGEVENT_JUMPTEXT, CeladonUniversityLoungeBookshelf1Text
	bg_event  7,  8, BGEVENT_READ, CeladonUniversityLoungeBookshelf2
	bg_event  0,  7, BGEVENT_RIGHT, CeladonUniversityLoungeComputer

	def_object_events
	object_event  5,  8, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonUniversityLoungeNeeshaScript, -1
	object_event  3,  1, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLoungeLassText, -1
	object_event  5,  3, SPRITE_RICH_BOY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLoungeRichBoyText, -1
	object_event  5,  4, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLoungeCooltrainerfText, -1
	object_event  2,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLoungeSuper_nerd1Text, -1
	object_event  1,  8, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLoungeSuper_nerd2Text, -1

	object_const_def
	const CELADONUNIVERSITYLOUNGE_NEESHA

CeladonUniversityLoungeNeeshaScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_COOLTRAINERF_NEESHA
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
	setlasttalked CELADONUNIVERSITYLOUNGE_NEESHA
	loadtrainer COOLTRAINERF, NEESHA
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERF_NEESHA
	opentext
.Beaten
	setevent EVENT_INTRODUCED_CELADON_FOUR
	checkevent EVENT_BEAT_COOLTRAINERM_COREY
	iffalse_jumpopenedtext .AfterText1
	checkevent EVENT_BEAT_COOLTRAINERM_RAYMOND
	iffalse_jumpopenedtext .AfterText1
	checkevent EVENT_BEAT_COOLTRAINERM_FERGUS
	iffalse_jumpopenedtext .AfterText1
	checkevent EVENT_GOT_CHOICE_BAND_FROM_CELADON_FOUR
	iftrue_jumpopenedtext .FinalText
	writetext .AfterText2
	promptbutton
	verbosegiveitem CHOICE_BAND, iffalse_endtext
	setevent EVENT_GOT_CHOICE_BAND_FROM_CELADON_FOUR
	jumpopenedtext .FinalText

.IntroText1:
	text "Hi! Ich bin"
	line "Neesha! Ich gehöre"

	para "zu den vier besten"
	line "Trainern der"
	cont "Prismania-Uni."

	para "Man nennt uns die"
	line "Prismania-Vier!"

	para "Soll ich dir zei-"
	line "gen, warum wir so"
	cont "berühmt sind?"

	para "Dann lass uns"
	line "kämpfen!"
	done

.IntroText2:
	text "Hi! Ich bin"
	line "Neesha! Ich gehöre"
	cont "zu den Prismania-"
	cont "Vier!"

	para "Du hast wohl schon"
	line "von uns gehört."

	para "Dann lass uns"
	line "kämpfen!"
	done

.NoBattleText:
	text "Keine Lust auf"
	line "eine Heraus-"
	cont "forderung?"
	done

.SeenText:
	text "Wir pusten dich"
	line "einfach weg!"
	done

.BeatenText:
	text "Eine schmerzliche"
	line "Niederlage…"
	done

.AfterText1:
	text "Du bist ein wür-"
	line "diger Gegner!"

	para "Aber du hast noch"
	line "nicht alles"

	para "gesehen, was die"
	line "Prismania-Vier"
	cont "können."

	para "Such die anderen"
	line "doch und fordere"
	cont "sie heraus!"
	done

.AfterText2:
	text "Du hast also alle"
	line "Prismania-Vier"
	cont "besiegt…"

	para "Wie cool!"

	para "Nimm das als"
	line "Preis!"
	done

.FinalText:
	text "Es kommt nicht oft"
	line "vor, dass jemand"

	para "uns Prismania-Vier"
	line "wirklich fordert."

	para "Ich werde dich"
	line "nicht vergessen,"
	cont "Trainer!"
	done

CeladonUniversityLoungeLassText:
	text "Nächsten Monat"
	line "machen wir einen"
	cont "Ausflug zum Mond-"
	cont "berg."

	para "Vielleicht sehe"
	line "ich ein Piepi!"
	done

CeladonUniversityLoungeRichBoyText:
	text "Hast du dich je"
	line "gefragt, warum"

	para "Hyperbälle oben"
	line "ein gelbes H"
	cont "haben?"

	para "Weil sie auch auf"
	line "Japanisch Hyper-"
	cont "ball heißen!"
	done

CeladonUniversityLoungeCooltrainerfText:
	text "#mon mit ge-"
	line "schwächter Kraft"

	para "versuchen instink-"
	line "tiv, in einen"
	cont "#ball zu"
	cont "schlüpfen."
	done

CeladonUniversityLoungeSuper_nerd1Text:
	text "Was bekommt man,"
	line "wenn man einen"

	para "Witz mit einer"
	line "rhetorischen Frage"
	cont "kreuzt?"

	para "………………………………"
	done

CeladonUniversityLoungeSuper_nerd2Text:
	text "Ich schreibe"
	line "Skripte für ein"
	cont "Spiel."

	para "Nicht gesagt asm"
	line "benutzen!"
	done

CeladonUniversityLoungeBookshelf1Text:
	text "Hier stehen jede"
	line "Menge #mon-"
	cont "Mangas!"
	done

CeladonUniversityLoungeBookshelf2:
	opentext
	writetext .Text1
	waitbutton
	checkevent EVENT_GOT_PP_MAX_IN_UNIVERSITY
	iftruefwd .GotItem
	verbosegiveitem PP_MAX, iffalsefwd .Done
	setevent EVENT_GOT_PP_MAX_IN_UNIVERSITY
.Done
	endtext

.GotItem
	jumpopenedtext .Text2

.Text1:
	text "Dieses Buch hat"
	line "ein Geheimfach, wo"

	para "eigentlich die"
	line "Seiten sein"
	cont "sollten!"
	done

.Text2:
	text "Schade--es ist"
	line "leer."
	done

CeladonUniversityLoungeComputer:
	jumpthistext

	text "Eine Spielfigur"
	line "rennt durch ein"

	para "2D-Prismania"
	line "City."
	done
