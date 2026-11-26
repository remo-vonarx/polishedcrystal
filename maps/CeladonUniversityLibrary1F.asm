CeladonUniversityLibrary1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6, 11, CELADON_UNIVERSITY_1F, 4
	warp_event  7, 11, CELADON_UNIVERSITY_1F, 4
	warp_event  7,  0, CELADON_UNIVERSITY_LIBRARY_2F, 1

	def_coord_events

	def_bg_events
	bg_event  4,  0, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FSignpost1Text
	bg_event 10,  0, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FSignpost2Text
	bg_event  0,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FBookshelf1Text
	bg_event  1,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FBookshelf2Text
	bg_event  2,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FBookshelf3Text
	bg_event  3,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FBookshelf4Text
	bg_event  4,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FBookshelf5Text
	bg_event  5,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FBookshelf6Text
	bg_event  0,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FBookshelf7Text
	bg_event  1,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FBookshelf8Text
	bg_event  2,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FBookshelf9Text
	bg_event  3,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FBookshelf10Text
	bg_event  4,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FBookshelf11Text
	bg_event  5,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FBookshelf12Text

	def_object_events
	object_event  6,  3, SPRITE_AROMA_LADY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary1FLadyText, -1
	object_event 11,  7, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary1FGentlemanText, -1
	object_event  0,  5, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary1FCooltrainerfText, -1
	object_event  9,  5, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonUniversityLibrary1FGameboyKidScript, -1
	object_event  3,  8, SPRITE_MATRON, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary1FPokefan_fText, -1
	object_event 11,  3, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, CeladonUniversityLibrary1FCooltrainermScript, -1
	object_event  2, 11, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary1FTeacherText, -1
	object_event 10,  7, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptext, CeladonUniversityLibrary1FBookText, -1

CeladonUniversityLibrary1FLadyText:
	text "This library is on"
	line "university"
	cont "grounds, but it's"

	para "open for anyone"
	line "to use."

	para "Isn't that great?"
	done

CeladonUniversityLibrary1FGentlemanText:
	text "Shh! Can't you see"
	line "I'm reading here?"
	done

CeladonUniversityLibrary1FCooltrainerfText:
	text "Prof.Oak used to"
	line "teach here, so the"

	para "library has copies"
	line "of all his journal"
	cont "articles."

	para "I've read each one"
	line "cover to cover!"
	done

CeladonUniversityLibrary1FGameboyKidScript:
	showtextfaceplayer .Text
	turnobject LAST_TALKED, DOWN
	end

.Text:
	text "My #dex has a"
	line "game upgrade."

	para "I'm playing Tetris!"
	done

CeladonUniversityLibrary1FPokefan_fText:
	text "We have a mutual"
	line "lending agreement"

	para "with Canalave"
	line "Library in Sinnoh."
	done

CeladonUniversityLibrary1FCooltrainermScript:
	checkevent EVENT_GOT_FOCUS_BAND_IN_UNIVERSITY
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem FOCUS_BAND, iffalse_endtext
	setevent EVENT_GOT_FOCUS_BAND_IN_UNIVERSITY
	jumpopenedtext .Text2

.Text1:
	text "I have a big test"
	line "coming up, so I'm"

	para "planning to be"
	line "here a while."

	para "I just need to"
	line "hang in there."

	para "This is what helps"
	line "me out."
	done

.Text2:
	text "If you want your"
	line "#mon to hang in"
	cont "there, give them"
	cont "that Focus Band."
	done

CeladonUniversityLibrary1FTeacherText:
	text "I'm the head"
	line "librarian."

	para "If you need any-"
	line "thing, just shout."

	para "Quietly, though."
	line "This IS a library."
	done

CeladonUniversityLibrary1FBookText:
	text "It's a book about"
	line "flower arranging."

	para "A Sunflora is on"
	line "the cover."
	done

CeladonUniversityLibrary1FSignpost1Text:
	text "Bitte störe die"
	line "Studenten in der"

	para "Bibliothek nicht"
	line "beim Lesen."
	done

CeladonUniversityLibrary1FSignpost2Text:
	text "Bitte keine"
	line "Speisen oder"

	para "Getränke in die"
	line "Bibliothek"
	cont "mitbringen."
	done

CeladonUniversityLibrary1FBookshelf1Text:
	text "Hm? Jemand hat ein"
	line "altes Foto in"
	cont "diesem Buch ver-"
	cont "gessen."

	para "Erika und ein"
	line "Mann mit sanftem"

	para "Lächeln posieren"
	line "fröhlich neben"
	cont "einem Myrapla."
	done

CeladonUniversityLibrary1FBookshelf2Text:
	text "Ein Fotoalbum mit"
	line "vielen Bildern"

	para "von #mon."

	para "“Todd Snaps"
	line "Schnappschuss-"
	cont "Mappe” steht auf"
	cont "dem Umschlag."
	done

CeladonUniversityLibrary1FBookshelf3Text:
	text "Ein Buch über"
	line "einen Mann, der"

	para "seinem #mon"
	line "beibrachte, ein"
	cont "Instrument zu"
	cont "spielen."

	para "Sie scheinen beste"
	line "Freunde zu sein."
	done

CeladonUniversityLibrary1FBookshelf4Text:
	text "Ein Buch über"
	line "Palindrom-#mon."

	para "Auf dem Umschlag"
	line "ist ein"
	cont "Girafarig."
	done

CeladonUniversityLibrary1FBookshelf5Text:
	text "Ein Buch über"
	line "Spielzeug-#mon,"

	para "die lebendig wer-"
	line "den, wenn man sie"
	cont "mit einem Wunder-"
	cont "schlüssel auf-"
	cont "zieht."

	para "Sie sehen irgend-"
	line "wie süß aus."
	done

CeladonUniversityLibrary1FBookshelf6Text:
	text "Ein Buch über eine"
	line "#mon-Puppe, die"
	cont "nicht lügen kann."

	para "“Pinpokéo” steht"
	line "auf dem Umschlag."
	done

CeladonUniversityLibrary1FBookshelf7Text:
	text "Ein Bu…"
	line "Moment…"

	para "Das ist ja ein"
	line "Videospiel!"

	para "Ein #mon-Flip-"
	line "perautomat ist"

	para "stolz auf der"
	line "Verpackung abge-"
	cont "bildet."
	done

CeladonUniversityLibrary1FBookshelf8Text:
	text "Ein Buch von einem"
	line "Angel-Guru mit"
	cont "Tipps für"

	para "neue Angler."

	para "“Haken und Ösen”"
	line "steht auf dem"
	cont "Umschlag."
	done

CeladonUniversityLibrary1FBookshelf9Text:
	text "Ein Handbuch zum"
	line "#mon-Sammel-"

	para "kartenspiel."
	done

CeladonUniversityLibrary1FBookshelf10Text:
	text "Ein Kochbuch mit"
	line "Rezepten rund um"
	cont "#mon!"

	para "Pummeluff-Pudding,"
	line "Glumanda-Gulasch,"
	cont "Mampfaxo-Muffins…"
	done

CeladonUniversityLibrary1FBookshelf11Text:
	text "Ein Ratgeber, wie"
	line "man Knurspe"
	cont "herstellt."

	para "Ein berühmter"
	line "#mon-Züchter"
	cont "ist auf dem"
	cont "Umschlag."
	done

CeladonUniversityLibrary1FBookshelf12Text:
	text "“Das geheime Le-"
	line "ben des Lachens”"
	cont "von Kalle Auer."
	cont "Wortwitzig!"
	done
