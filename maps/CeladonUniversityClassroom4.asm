CeladonUniversityClassroom4_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2, 11, CELADON_UNIVERSITY_1F, 9
	warp_event  3, 11, CELADON_UNIVERSITY_1F, 9

	def_coord_events

	def_bg_events
	bg_event  2,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom4BlackboardText
	bg_event  3,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom4BlackboardText
	bg_event  4,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom4BlackboardText
	bg_event  6,  1, BGEVENT_READ, CeladonUniversityClassroom4Bookshelf1
	bg_event  7,  1, BGEVENT_JUMPTEXT, CeladonUniversityClassroom4Bookshelf2Text

	def_object_events
	object_event  5,  2, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonUniversityClassroom4RaymondScript, -1
	object_event  2,  1, SPRITE_CANDELA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, (1 << MORN) | (1 << DAY), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom4CandelaText, -1
	object_event  2,  1, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, (1 << EVE) | (1 << NITE), PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom4TeacherText, -1
	object_event  2,  5, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom4Bug_catcherText, -1
	object_event  3,  7, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom4FisherText, -1
	object_event  5,  7, SPRITE_AROMA_LADY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom4LadyText, -1
	object_event  4,  9, SPRITE_RICH_BOY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonUniversityClassroom4Rich_boyScript, -1

	object_const_def
	const CELADONUNIVERSITYCLASSROOM4_RAYMOND

CeladonUniversityClassroom4RaymondScript:
	faceplayer
	checkevent EVENT_BEAT_COOLTRAINERM_RAYMOND
	iftruefwd .Beaten
	opentext
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
	setlasttalked CELADONUNIVERSITYCLASSROOM4_RAYMOND
	loadtrainer COOLTRAINERM, COOLTRAINERM_RAYMOND
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERM_RAYMOND
.Beaten
	opentext
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
	text "Hey! Ich bin"
	line "Raymond! Nenn mich"
	cont "einfach Ray."

	para "Ich gehöre zu den"
	line "vier besten Trai-"
	cont "nern der Prisma-"
	cont "nia-Uni."

	para "Man nennt uns die"
	line "Prismania-Vier!"

	para "Willst du unser"
	line "Können selbst"
	cont "sehen?"

	para "Lass uns kämpfen!"
	line "Außer du hast"
	cont "Angst vorm"
	cont "Verlieren."
	done

.IntroText2:
	text "Hey! Ich bin"
	line "Raymond! Nenn mich"
	cont "einfach Ray."

	para "Ich gehöre zu den"
	line "Prismania-Vier!"

	para "Du willst gegen"
	line "uns alle kämpfen?"

	para "Lass uns kämpfen!"
	line "Außer du hast"
	cont "Angst vorm"
	cont "Verlieren."
	done

.NoBattleText:
	text "Ich wusste, dass"
	line "du Angst hast."
	done

.SeenText:
	text "Los geht's!"
	done

.BeatenText:
	text "Ohhhh neiiiin!"
	done

.AfterText1:
	text "Wie kann das sein?"
	line "Ich bin einer der"
	cont "Prismania-Vier!"

	para "Ich habe zwar ver-"
	line "loren, aber meine"
	cont "drei Kumpel rächen"
	cont "mich."

	para "Such sie doch"
	line "selbst!"
	done

.AfterText2:
	text "Du hast alle"
	line "Prismania-Vier"
	cont "besiegt?"

	para "Unmöglich!"

	para "…Na gut. Das hast"
	line "du dir wohl"
	cont "verdient."
	done

.FinalText:
	text "Wer die Prismania-"
	line "Vier besiegt hat,"

	para "kann jede Last"
	line "tragen."
	done

CeladonUniversityClassroom4CandelaText:
	text "Hi! Ich bin"
	line "Candela. Ich un-"
	cont "terrichte #mon-"
	cont "Kampf!"

	para "Ich erforsche, wie"
	line "man die natürliche"

	para "Kraft von #mon"
	line "für mehr Stärke"
	cont "steigern kann."
	done

CeladonUniversityClassroom4TeacherText:
	text "Candela? Sie"
	line "unterrichtet nur"
	cont "tagsüber."
	done

CeladonUniversityClassroom4Bug_catcherText:
	text "Meine Dozentin"
	line "meinte, mein"
	cont "#mon könne mit"
	cont "den Besten mit-"
	cont "halten."

	para "Sein Potenzial sei"
	line "das beste, das sie"
	cont "je gesehen habe!"
	done

CeladonUniversityClassroom4FisherText:
	text "Der Prof sagte,"
	line "mein #mon sei"
	cont "ein Wunder!"

	para "Es ist ein"
	line "atemberaubendes"
	cont "#mon."
	done

CeladonUniversityClassroom4LadyText:
	text "Die Professorin"
	line "sagte, sie sei von"
	cont "meinem #mon"
	cont "begeistert."

	para "Es kann wohl"
	line "wirklich alles"
	cont "schaffen!"
	done

CeladonUniversityClassroom4Rich_boyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_ABILITY_CAP_IN_UNIVERSITY
	iftruefwd .GotItem
	writetext .Text1
	promptbutton
	verbosegiveitem ABILITY_CAP, iffalse_endtext
	setevent EVENT_GOT_ABILITY_CAP_IN_UNIVERSITY
.GotItem:
	writetext .Text2
	waitendtext

.Text1:
	text "Wir lernen gerade"
	line "etwas über die"
	cont "Fähigkeiten von"
	cont "#mon."

	para "Manche Arten"
	line "können mehr als"
	cont "eine Fähigkeit"
	cont "haben."

	para "Damit kannst du"
	line "zwischen ihnen"
	cont "wechseln!"
	done

.Text2:
	text "Es gibt seltene"
	line "“versteckte"
	cont "Fähigkeiten”, die"

	para "eine Fähigkeits-"
	line "kapsel nicht"
	cont "ändern kann."

	para "Aber! Wenn ein"
	line "#mon, das eine"

	para "Fähigkeitskapsel"
	line "trägt, ein Ei hat,"

	para "kann das Baby"
	line "eine versteckte"
	cont "Fähigkeit haben!"
	done

CeladonUniversityClassroom4BlackboardText:
	text "Achte im Kampf"
	line "auf diese Punkte:"
	cont "- Typentabelle"
	cont "- Attacken-Effekte"
	cont "- Kategorien"
	cont "- Statusprobleme"
	cont "- Getragene Items"
	cont "- Basiswerte"
	cont "- Fleißpunkte"
	cont "- Wesen"
	cont "- Fähigkeiten"
	cont "- Wetter"
	cont "- Sonstiges?"
	done

CeladonUniversityClassroom4Bookshelf1:
	checkevent EVENT_GOT_X_SP_ATK_IN_UNIVERSITY
	iftrue_jumptext .Text2
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem X_SP_ATK, iffalse_endtext
	setevent EVENT_GOT_X_SP_ATK_IN_UNIVERSITY
	endtext

.Text1:
	text "Dieses Bücherregal"
	line "ist ein Chaos!"

	para "<PLAYER> hat die"
	line "Bücher aufgeräumt."

	para "…Oh?"
	done

.Text2:
	text "Dieses Bücherregal"
	line "ist ordentlich"
	cont "aufgeräumt."
	done

CeladonUniversityClassroom4Bookshelf2Text:
	text "Ein Malbuch mit"
	line "#mon-Motiven."

	para "Was macht das"
	line "denn hier?"
	done
