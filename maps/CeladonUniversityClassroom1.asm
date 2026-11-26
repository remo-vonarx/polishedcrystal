CeladonUniversityClassroom1_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2, 11, CELADON_UNIVERSITY_1F, 6
	warp_event  3, 11, CELADON_UNIVERSITY_1F, 6

	def_coord_events

	def_bg_events
	bg_event  2,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom1BlackboardText
	bg_event  3,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom1BlackboardText
	bg_event  4,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom1BlackboardText
	bg_event  6,  1, BGEVENT_JUMPTEXT, CeladonUniversityClassroom1Bookshelf1Text
	bg_event  7,  1, BGEVENT_JUMPTEXT, CeladonUniversityClassroom1Bookshelf2Text

	def_object_events
	object_event  0,  6, SPRITE_IMAKUNI, SPRITEMOVEDATA_WANDER, 2, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonUniversityClassroom1ImakuniScript, -1
	object_event  1,  2, SPRITE_ANDY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1AndyText, -1
	object_event  5,  2, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptext, CeladonUniversityClassroom1Dragon_tamerText, -1
	object_event  2,  5, SPRITE_LADY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1LadyText, -1
	object_event  5,  5, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1Artist1Text, -1
	object_event  4,  7, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, (1 << MORN) | (1 << DAY), PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1Artist2Text, -1
	object_event  3,  9, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, (1 << EVE) | (1 << NITE), PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1Artist3Text, -1

	object_const_def
	const CELADONUNIVERSITYCLASSROOM1_IMAKUNI

CeladonUniversityClassroom1ImakuniScript:
	readvar VAR_FACING
	ifequalfwd UP, .Up
	ifequalfwd DOWN, .Down
	ifequalfwd LEFT, .Left
	turnobject CELADONUNIVERSITYCLASSROOM1_IMAKUNI, RIGHT
	sjumpfwd .Continue

.Up:
	turnobject CELADONUNIVERSITYCLASSROOM1_IMAKUNI, UP
	sjumpfwd .Continue

.Down:
	turnobject CELADONUNIVERSITYCLASSROOM1_IMAKUNI, DOWN
	sjumpfwd .Continue

.Left:
	turnobject CELADONUNIVERSITYCLASSROOM1_IMAKUNI, LEFT
.Continue:
	checkevent EVENT_BEAT_IMAKUNI
	iftruefwd .Beaten
	opentext
	writetext .Text1
	yesorno
	iffalse_jumpopenedtext .Text2
	writetext .Text3
	waitbutton
	closetext
	winlosstext .Text4, 0
	setlasttalked CELADONUNIVERSITYCLASSROOM1_IMAKUNI
	loadtrainer IMAKUNI, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_IMAKUNI
.Beaten
	checkevent EVENT_GOT_PERSIM_BERRY_FROM_IMAKUNI
	iftrue_jumptext .Text6
	opentext
	writetext .Text5
	promptbutton
	verbosegiveitem PERSIM_BERRY, iffalse_endtext
	setevent EVENT_GOT_PERSIM_BERRY_FROM_IMAKUNI
	jumpthisopenedtext

.Text6:
	text "Im Kampf wie beim"
	line "Tanz sind Seele"
	cont "und Rhythmus das"
	cont "Geheimnis."

	para "Hey, das klingt"
	line "ziemlich cool!"

	para "Vielleicht werde"
	line "ich Dichter!"
	done

.Text1:
	text "Hä? W…Wer bist"
	line "du denn?"

	para "Wer? Ich? Du weißt"
	line "nicht, wer ich"
	cont "bin?"

	para "Ich bin der super-"
	line "musikalische Star"
	cont "Imakuni!"

	para "Ich singe den"
	line "#rap--und du"
	cont "tanzt!"

	para "♪ La di da di da,"
	line "La di da di da… ♪"

	para "Hey! Beweg die"
	line "Füße!"

	para "Was? #mon?"

	para "Du willst gegen"
	line "mich kämpfen?"
	done

.Text2:
	text "Ach komm, sei doch"
	line "nicht so gemein!"

	para "Gleich muss ich"
	line "weinen!"
	done

.Text3:
	text "OK, aber wenn ich"
	line "gewinne, tanzt du!"
	done

.Text4:
	text "Auch wenn ich ver-"
	line "loren habe, ist"
	cont "das so schlimm?"
	done

.Text5:
	text "Hey! Du bist ganz"
	line "schön gut!"

	para "Ich gebe dir diese"
	line "Beere, also sag"

	para "keinem, dass ich"
	line "verloren habe, OK?"
	done

CeladonUniversityClassroom1AndyText:
	text "Hallo! Ich bin"
	line "Prof. Andy und"

	para "lehre, was ich"
	line "liebe--Kunst!"

	para "Denk dran: Zeich-"
	line "ne, was du siehst,"

	para "nicht, was du"
	line "zu sehen glaubst."

	para "Löse dich von"
	line "Vorurteilen darü-"
	cont "ber, wie Dinge"
	cont "aussehen."
	done

CeladonUniversityClassroom1Dragon_tamerText:
	text "Ich halte diese"
	line "Pose schon eine"
	cont "ganze Weile."
	done

CeladonUniversityClassroom1LadyText:
	text "Im Kunstkurs lernt"
	line "man ein paar"
	cont "einzigartige Leute"
	cont "kennen, aber"

	para "der Typ im"
	line "schwarzen Kostüm"
	cont "ist echt"
	cont "verdächtig!"
	done

CeladonUniversityClassroom1Artist1Text:
	text "Es ist schwer, die"
	line "Falten dieses"
	cont "Umhangs richtig"
	cont "hinzubekommen."
	done

CeladonUniversityClassroom1Artist2Text:
	text "Hatschi!"

	para "Uff. Wir hatten"
	line "gerade ein Blumen-"
	cont "steck-Seminar,"

	para "aber jetzt muss"
	line "ich ständig"
	cont "niesen."

	para "Ich bin wohl"
	line "allergisch…"
	done

CeladonUniversityClassroom1Artist3Text:
	text "Tagsüber arbeite"
	line "ich viel, also"

	para "besuche ich die"
	line "Kurse abends."
	done

CeladonUniversityClassroom1BlackboardText:
	text "An der Tafel wird"
	line "die Zwei- und"

	para "Dreipunktperspek-"
	line "tive erklärt."
	done

CeladonUniversityClassroom1Bookshelf1Text:
	text "Ein Buch über"
	line "Farbeagle, ein"
	cont "#mon-Künstler."

	para "Es ist voller"
	line "schöner Zeich-"
	cont "nungen."
	done

CeladonUniversityClassroom1Bookshelf2Text:
	text "Eine Broschüre"
	line "zeigt schöne"
	cont "Kunstwerke aus"

	para "dem Museum von"
	line "Seegrasulb City."
	done
