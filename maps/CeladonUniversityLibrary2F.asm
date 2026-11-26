CeladonUniversityLibrary2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  0, CELADON_UNIVERSITY_LIBRARY_1F, 3

	def_coord_events

	def_bg_events
	bg_event  4,  0, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FSignpost1Text
	bg_event 10,  0, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FSignpost2Text
	bg_event  0,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf1Text
	bg_event  1,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf2Text
	bg_event  2,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf3Text
	bg_event  3,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf4Text
	bg_event  4,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf5Text
	bg_event  5,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf6Text
	bg_event  8,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf7Text
	bg_event  9,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf8Text
	bg_event 10,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf9Text
	bg_event 11,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf10Text
	bg_event 12,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf11Text
	bg_event 13,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf12Text
	bg_event  6,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf13Text
	bg_event  7,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf14Text
	bg_event  8,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf15Text
	bg_event  9,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf16Text
	bg_event 10,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf17Text
	bg_event 11,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf18Text
	bg_event 12,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf19Text
	bg_event 13,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf20Text
	bg_event  1,  6, BGEVENT_RIGHT, CeladonUniversityLibrary2FComputer1
	bg_event  3,  6, BGEVENT_RIGHT, CeladonUniversityLibrary2FComputer2
	bg_event  1,  8, BGEVENT_RIGHT, CeladonUniversityLibrary2FComputer3
	bg_event  3,  8, BGEVENT_RIGHT, CeladonUniversityLibrary2FComputer1
	bg_event  1, 10, BGEVENT_RIGHT, CeladonUniversityLibrary2FComputer1
	bg_event  3, 10, BGEVENT_RIGHT, CeladonUniversityLibrary2FComputer4

	def_object_events
	object_event  3,  4, SPRITE_COSPLAYER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FCosplayerText, -1
	object_event 11,  5, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FLassText, -1
	object_event  0,  9, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonUniversityLibrary2FArtistScript, -1
	object_event  2, 11, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FSuper_nerdText, -1
	object_event  8, 11, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FCooltrainerfText, -1
	object_event 11, 10, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FYoungsterText, -1
	itemball_event  0,  1, TIMER_BALL, 1, EVENT_CELADON_UNIVERSITY_LIBRARY_2F_TIMER_BALL

CeladonUniversityLibrary2FCosplayerText:
	text "Es ist toll, in"
	line "der Stadt zu sein!"

	para "Ich kann mein Kos-"
	line "tüm in der Öffent-"
	cont "lichkeit tragen,"

	para "und keiner zuckt"
	line "mit der Wimper!"
	done

CeladonUniversityLibrary2FLassText:
	text "Beurteile ein Buch"
	line "nie nach seinem"
	cont "Umschlag."

	para "Manchmal verbirgt"
	line "die langweiligste"

	para "Hülle die besten"
	line "Geschichten."
	done

CeladonUniversityLibrary2FArtistScript:
	showtext .Text1
	showtextfaceplayer .Text2
	turnobject LAST_TALKED, RIGHT
	end

.Text1:
	text "“Jasmin blickte"
	line "in Erikas tiefe,"
	cont "braune Augen…”"
	done

.Text2:
	text "Hä? Geh weg!"

	para "Es ist unhöflich,"
	line "anderen über die"
	cont "Schulter zu lesen!"
	done

CeladonUniversityLibrary2FSuper_nerdText:
	text "Mit dem Befehl"
	line "“net send” kann"

	para "man eine Nachricht"
	line "auf allen anderen"
	cont "Bildschirmen"
	cont "anzeigen!"

	para "Hmm, was schicke"
	line "ich bloß…"

	para "“Gratis-Pizza im"
	line "Büro von Prof."
	cont "Westwood!”"

	para "Hehehe."
	done

CeladonUniversityLibrary2FCooltrainerfText:
	text "Das ist mein Buch."
	line "Und ich werde ES"
	cont "LESEN!"
	done

CeladonUniversityLibrary2FYoungsterText:
	text "Ich lese über ein"
	line "legendäres #mon"

	para "mit der Kraft, den"
	line "Raum zu verzerren."

	para "Ganz schön"
	line "gruselig…"
	done

CeladonUniversityLibrary2FBookshelf1Text:
	text "Ein Buch über"
	line "#mon eines"

	para "alten Alphabets."

	para "Hat man je eins"
	line "von jeder Art,"
	cont "sollen sie Wün-"
	cont "sche erfüllen."
	done

CeladonUniversityLibrary2FBookshelf2Text:
	text "Dieses Buch fällt"
	line "auseinander."

	para "Der Titel ist"
	line "nicht mehr lesbar,"

	para "aber man sieht ein"
	line "#mon in einer"

	para "schweren Rüstung."
	done

CeladonUniversityLibrary2FBookshelf3Text:
	text "Ein Buch mit einem"
	line "riesigen Vorhänge-"
	cont "schloss darauf."

	para "Lass es lieber"
	line "liegen."
	done

CeladonUniversityLibrary2FBookshelf4Text:
	text "Dieses Buch ist in"
	line "einer fremden"
	cont "Sprache!"

	para "Stell es lieber"
	line "zurück…"
	done

CeladonUniversityLibrary2FBookshelf5Text:
	text "Hinter diesen"
	line "Büchern…"

	para "Nein. Hier scheint"
	line "nichts zu sein."
	done

CeladonUniversityLibrary2FBookshelf6Text:
	text "Ein Buch über"
	line "#mon mit"

	para "regionalen Unter-"
	line "schieden."

	para "Darin ist ein"
	line "Raichu, das etwas"
	cont "seltsam aussieht…"
	done

CeladonUniversityLibrary2FBookshelf7Text:
	text "Ein Buch über"
	line "Wettbewerbe für"
	cont "#mon."

	para "Ein eindrucks-"
	line "volles Gebäude"

	para "ist auf dem"
	line "Umschlag zu sehen."
	done

CeladonUniversityLibrary2FBookshelf8Text:
	text "Auf dem Umschlag"
	line "reitet ein Junge"

	para "auf einem #mon."

	para "“Dragoran zähmen"
	line "leicht gemacht”"
	cont "steht in dicken"
	cont "Buchstaben darauf."
	done

CeladonUniversityLibrary2FBookshelf9Text:
	text "Ein Buch über eine"
	line "Welt, in der nur"

	para "#mon leben!"

	para "“Pikachus Aben-"
	line "teuer im #Park”"

	para "steht auf dem"
	line "Umschlag."
	done

CeladonUniversityLibrary2FBookshelf10Text:
	text "Ein Buch über eine"
	line "Insel riesiger"
	cont "#mon-Roboter."

	para "“#mon-Robotik”"
	line "von Anne Droid…"
	done

CeladonUniversityLibrary2FBookshelf11Text:
	text "“Vergeben und"
	line "Vergessen” von"
	cont "Saul Goode."

	para "Darauf ist ein"
	line "Mann mit breitem"
	cont "Grinsen zu sehen."
	done

CeladonUniversityLibrary2FBookshelf12Text:
	text "“Schwerelosigkeit”"
	line "von Andy Gravity."
	cont "Klingt abgehoben!"
	done

CeladonUniversityLibrary2FBookshelf13Text:
	text "Ein Buch, das die"
	line "Biologie der"

	para "#mon erklärt."

	para "Es ist riesig!"
	done

CeladonUniversityLibrary2FBookshelf14Text:
	text "Dieses Buch ist"
	line "voller Spinn-"
	cont "weben."

	para "Es wurde wohl"
	line "lange nicht mehr"
	cont "gelesen."
	done

CeladonUniversityLibrary2FBookshelf15Text:
	text "Ein Buch über ein"
	line "furchterregendes"
	cont "#mon."

	para "“Absofusion und"
	line "das Tao-Trio”"

	para "steht in großen"
	line "Buchstaben darauf."
	done

CeladonUniversityLibrary2FBookshelf16Text:
	text "“Antikes #mopo-"
	line "lis: Eine Ge-"

	para "schichte ausge-"
	line "storbener #mon”"

	para "Klingt"
	line "interessant!"
	done

CeladonUniversityLibrary2FBookshelf17Text:
	text "Ein Buch mit dem"
	line "Titel “Falscher"

	para "Typ: Das Rätsel"
	line "um Mogelbaum”."
	done

CeladonUniversityLibrary2FBookshelf18Text:
	text "Ein Buch über"
	line "einen uralten"

	para "Baum, den drei"
	line "Titanen bewachen."

	para "Es wirkt beinahe"
	line "magisch."
	done

CeladonUniversityLibrary2FBookshelf19Text:
	text "Das ist eine Kopie"
	line "der ursprünglichen"
	cont "Magnetzug-Route!"

	para "Sie zeigt einen"
	line "geplanten Halt"
	cont "in Teak City."
	done

CeladonUniversityLibrary2FBookshelf20Text:
	text "Rote Bücher,"
	line "blaue Bücher,"
	cont "gelbe Bücher,"
	cont "grüne Bücher…"

	para "Bücher in allen"
	line "Farben!"
	done

CeladonUniversityLibrary2FComputer1:
	jumpthistext

	text "Ein Anmelde-"
	line "bildschirm mit"

	para "einem Karpador als"
	line "Hintergrundbild."
	done

CeladonUniversityLibrary2FComputer2:
	jumpthistext

	text "Da hat jemand ver-"
	line "gessen, sich abzu-"
	cont "melden!"
	done

CeladonUniversityLibrary2FComputer3:
	jumpthistext

	text "Eine Geschichte"
	line "voller Grammatik-"
	cont "und Rechtschreib-"
	cont "fehler."
	done

CeladonUniversityLibrary2FComputer4:
	jumpthistext

	text "Eine Webseite"
	line "darüber, wie man"
	cont "ein “l33t h4x0r”"
	cont "wird."
	done
