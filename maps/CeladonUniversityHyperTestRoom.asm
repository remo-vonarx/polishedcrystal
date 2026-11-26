CeladonUniversityHyperTestRoom_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2, 11, CELADON_UNIVERSITY_2F, 4
	warp_event  3, 11, CELADON_UNIVERSITY_2F, 4

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, CeladonUniversityHyperTestRoomMagikarpSign
	bg_event  6,  1, BGEVENT_JUMPTEXT, CeladonUniversityHyperTestRoomBookshelf1Text
	bg_event  7,  1, BGEVENT_JUMPTEXT, CeladonUniversityHyperTestRoomBookshelf2Text
	bg_event  7,  4, BGEVENT_RIGHT, CeladonUniversityHyperTestRoomComputer
	bg_event  7,  6, BGEVENT_RIGHT, CeladonUniversityHyperTestRoomComputer

	def_object_events
	object_event  4,  2, SPRITE_WESTWOOD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonUniversityHyperTestRoomWestwoodScript, -1
	object_event  6,  7, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityHyperTestRoomScientistText, -1
	object_event  1,  6, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityHyperTestRoomTwin1Text, -1
	object_event  1,  8, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityHyperTestRoomTwin2Text, -1

CeladonUniversityHyperTestRoomWestwoodScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_DRAGON_RAGE_MAGIKARP
	iftrue_jumpopenedtext .TestOverText
	checkevent EVENT_PASSED_CELADON_HYPER_TEST
	iftruefwd .GiveMagikarp
	writetext .GreetingText
	waitbutton
	checkevent EVENT_LISTENED_TO_WESTWOOD_INTRO
	iftruefwd .HeardIntro
	writetext .IntroText
	waitbutton
	setevent EVENT_LISTENED_TO_WESTWOOD_INTRO
.HeardIntro
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	checkflag ENGINE_TOOK_HYPER_TEST
	iftrue_jumpopenedtext .AlreadyTookText
	setflag ENGINE_TOOK_HYPER_TEST
	writetext .BeginText
	waitbutton

	writetext .Question1IntroText
	waitbutton
	closetext
	reanchormap
	trainerpic SILHOUETTE
	waitbutton
	closepokepic
	opentext
	writetext .Question1QuestionText
	loadmenu .Question1MenuData
	verticalmenu
	closewindow
	ifnotequal $2, .WrongAnswer
	waitsfx
	playsound SFX_ELEVATOR_END
	writetext .CorrectText
	promptbutton

	writetext .Question2IntroText
	waitbutton
	closetext
	cry SLOWKING
	waitsfx
	opentext
	writetext .Question2QuestionText
	loadmenu .Question2MenuData
	verticalmenu
	closewindow
	ifnotequal $3, .WrongAnswer
	waitsfx
	playsound SFX_ELEVATOR_END
	writetext .CorrectText
	promptbutton

	writetext .Question3IntroText
	waitbutton
	writetext .Question3QuestionText
	loadmenu .Question3MenuData
	verticalmenu
	closewindow
	ifnotequal $4, .WrongAnswer
	waitsfx
	playsound SFX_ELEVATOR_END
	writetext .CorrectText
	promptbutton

	writetext .Question4IntroText
	waitbutton
	writetext .Question4QuestionText
	loadmenu .Question4MenuData
	verticalmenu
	closewindow
	ifnotequal $1, .WrongAnswer
	waitsfx
	playsound SFX_ELEVATOR_END
	writetext .CorrectText
	promptbutton

	writetext .Question5IntroText
	waitbutton
	writetext .Question5QuestionText
	loadmenu .Question5MenuData
	verticalmenu
	closewindow
	ifnotequal $3, .WrongAnswer
	waitsfx
	playsound SFX_ELEVATOR_END
	writetext .CorrectText
	promptbutton

	writetext .Question6IntroText
	waitbutton
	writetext .Question6QuestionText
	loadmenu .Question6MenuData
	verticalmenu
	closewindow
	ifnotequal $4, .WrongAnswer
	waitsfx
	playsound SFX_ELEVATOR_END
	writetext .CorrectText
	promptbutton

	setevent EVENT_PASSED_CELADON_HYPER_TEST
.GiveMagikarp:
	writetext .CongratulationsText
	waitbutton

	givepoke MAGIKARP, MAGIKARP_MASK1_FORM, 10, EVIOLITE, ULTRA_BALL, DRAGON_RAGE
	iffalse_jumpopenedtext .PartyAndBoxFullText
	setevent EVENT_GOT_DRAGON_RAGE_MAGIKARP
	jumpopenedtext .TestOverText

.WrongAnswer:
	waitsfx
	playsound SFX_WRONG
	jumpthisopenedtext

	text "Tut mir leid, das"
	line "ist falsch!"

	para "Du kannst den"
	line "Hypertest morgen"
	cont "noch mal machen."
	done

.GreetingText:
	text "Prof. Westwood?"
	line "Das bin ich."
	done

.IntroText:
	text "Ein Forscher der"
	line "Extraklasse!"

	para "Meine Erkenntnisse"
	line "sind unerreicht."

	para "Zweifellos bekomme"
	line "ich bald eine"
	cont "Auszeichnung…"
	done

.QuestionText:
	text "Ähem. Wie bitte?"

	para "Du willst den"
	line "Hypertest der"
	cont "Prismania-Uni"
	cont "ablegen?"
	done

.BeginText:
	text "Hervorragend!"

	para "Der Hypertest be-"
	line "steht aus sechs"
	cont "Fragen, die all"

	para "deine Sinne unter"
	line "Druck prüfen!"

	para "Wenn du bestehst,"
	line "erhältst du einen"

	para "Preis, der unserer"
	line "Uni würdig ist!"
	done

.CorrectText:
	text "Richtig!"
	done

.Question1IntroText:
	text "Frage 1:"
	line "Sieh genau hin!"
	done

.Question1QuestionText:
	text "Welchem #mon"
	line "gehört diese"
	cont "Silhouette?"
	done

.Question2IntroText:
	text "Frage 2:"
	line "Hör genau hin!"
	done

.Question2QuestionText:
	text "Welchem #mon"
	line "gehört dieser Ruf?"
	done

.Question3IntroText:
	text "Frage 3:"
	done

.Question3QuestionText:
	text "Welche Medizin"
	line "schmeckt bitter?"
	done

.Question4IntroText:
	text "Frage 4:"
	done

.Question4QuestionText:
	text "Welches #mon"
	line "hat Trockenheit?"
	done

.Question5IntroText:
	text "Frage 5:"
	done

.Question5QuestionText:
	text "Welche Beere"
	line "riecht blau?"
	done

.Question6IntroText:
	text "Frage 6:"
	line "Denk gut nach!"
	done

.Question6QuestionText:
	text "Wer ist der"
	line "erfolgreichste"
	cont "Professor?"
	done

.CongratulationsText:
	text "Herzlichen"
	line "Glückwunsch!"

	para "Du hast den Hyper-"
	line "test mit Bravour"
	cont "bestanden!"

	para "Hier ist dein"
	line "Preis--ein ganz"

	para "besonders gezüch-"
	line "tetes Karpador,"
	cont "das Drachenwut"
	cont "beherrscht!"
	done

.TestOverText:
	text "Unsere Studenten"
	line "sind so zäh wie"

	para "ein Karpador, das"
	line "sich abmüht, sich"
	cont "zu entwickeln."
	cont "Und du auch!"
	done

.PartyAndBoxFullText:
	text "Oh nein! Dein Team"
	line "und deine Box sind"
	cont "voll…"
	done

.RefusedText:
	text "Nun, wenn du dir"
	line "sicher bist."
	done

.AlreadyTookText:
	text "Aber du hast den"
	line "Test heute schon"
	cont "versucht!"

	para "Du kannst ihn"
	line "morgen wieder-"
	cont "holen."
	done


.Question1MenuData:
	db MENU_BACKUP_TILES
	menu_coords 0, 1, 12, 11
	dw .Question1MenuData2
	db 1 ; default option

.Question1MenuData2:
	db $81 ; flags
	db 4 ; items
	db "Nachtara@"
	db "Glaziola@"
	db "Snobilikat@"
	db "Girafarig@"

.Question2MenuData:
	db MENU_BACKUP_TILES
	menu_coords 0, 1, 12, 11
	dw .Question2MenuData2
	db 1 ; default option

.Question2MenuData2:
	db $81 ; flags
	db 4 ; items
	db "Heiteira@"
	db "Baldorfish@"
	db "Laschoking@"
	db "Omot@"

.Question3MenuData:
	db MENU_BACKUP_TILES
	menu_coords 0, 1, 13, 11
	dw .Question3MenuData2
	db 1 ; default option

.Question3MenuData2:
	db $81 ; flags
	db 4 ; items
	db "Elixier@"
	db "Kalzium@"
	db "Gegengift@"
	db "Heilpuder@"

.Question4MenuData:
	db MENU_BACKUP_TILES
	menu_coords 0, 1, 12, 11
	dw .Question4MenuData2
	db 1 ; default option

.Question4MenuData2:
	db $81 ; flags
	db 4 ; items
	db "Parasek@"
	db "Magmar@"
	db "Sandamer@"
	db "Sarzenia@"

.Question5MenuData:
	db MENU_BACKUP_TILES
	menu_coords 0, 1, 13, 11
	dw .Question5MenuData2
	db 1 ; default option

.Question5MenuData2:
	db $81 ; flags
	db 4 ; items
	db "Amrenabeere@"
	db "Prunusbeere@"
	db "Sinelbeere@"
	db "Pirsifbeere@"

.Question6MenuData:
	db MENU_BACKUP_TILES
	menu_coords 0, 1, 15, 11
	dw .Question6MenuData2
	db 1 ; default option

.Question6MenuData2:
	db $81 ; flags
	db 4 ; items
	db "Prof.Eich@"
	db "Prof.Lind@"
	db "Prof.Willow@"
	db "Prof.Westwood@"

CeladonUniversityHyperTestRoomScientistText:
	text "Der Hypertest ist"
	line "ein Übergangsritus"

	para "für alle Absolven-"
	line "ten der Prisma-"
	cont "nia-Uni."

	para "Er prüft all ihre"
	line "Fähigkeiten bis"
	cont "zum Äußersten!"
	done

CeladonUniversityHyperTestRoomTwin1Text:
	text "Ich bestehe den"
	line "Hypertest vor dir!"
	done

CeladonUniversityHyperTestRoomTwin2Text:
	text "Nein, ich bestehe"
	line "den Hypertest vor"
	cont "dir!"
	done

CeladonUniversityHyperTestRoomMagikarpSign:
	reanchormap
	pokepic MAGIKARP, MAGIKARP_MASK1_FORM
	cry MAGIKARP
	waitbutton
	closepokepic
	jumpthistext

	text "Ein Karpador"
	line "schwimmt herum."
	done

CeladonUniversityHyperTestRoomBookshelf1Text:
	text "Dieses Buch hat"
	line "ein Lesezeichen."

	para "Jemand liest es"
	line "wohl noch!"
	done

CeladonUniversityHyperTestRoomBookshelf2Text:
	text "Eine Ausgabe von"
	line "Club Nintendo!"

	para "Das Titelbild"
	line "zeigt ein großes"
	cont "Pikachu."
	done

CeladonUniversityHyperTestRoomComputer:
	jumpthistext

	text "Auf dem Desktop"
	line "liegt eine Datei"
	cont "namens fragen.txt."

	para "Besser nicht"
	line "schummeln!"
	done
