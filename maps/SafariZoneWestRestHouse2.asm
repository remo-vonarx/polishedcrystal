SafariZoneWestRestHouse2_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, SAFARI_ZONE_WEST, 8
	warp_event  3,  7, SAFARI_ZONE_WEST, 8

	def_coord_events

	def_bg_events
	bg_event  4,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  5,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  6,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  7,  1, BGEVENT_READ, PokemonJournalKogaScript

	def_object_events
	object_event  3,  4, SPRITE_FLANNERY, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, SafariZoneWestRestHouse2FlanneryScript, -1

	object_const_def
	const SAFARIZONEWESTRESTHOUSE2_FLANNERY

SafariZoneWestRestHouse2FlanneryScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_FLANNERY
	iftruefwd .Beaten
	checkevent EVENT_INTRODUCED_FLANNERY
	iftruefwd .Introduced
	writetext .IntroText
	sjumpfwd .Question
.Introduced
	writetext .RematchText
.Question
	yesorno
	iffalsefwd .Refused
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked SAFARIZONEWESTRESTHOUSE2_FLANNERY
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftruefwd .Rematch
	loadtrainer FLANNERY, 1
	sjumpfwd .StartBattle
.Rematch
	loadtrainer FLANNERY, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	setevent EVENT_INTRODUCED_FLANNERY
	setevent EVENT_BEAT_FLANNERY
	opentext
.Beaten:
	jumpopenedtext .AfterText

.Refused:
	jumpopenedtext .RefusedText

.IntroText:
	text "Hallo!"

	para "Schön, dass noch"
	line "jemand diesen Ort"
	cont "erkundet!"

	para "Ich bin Flavia."

	para "Ich komme aus der"
	line "Hoenn-Region, also"

	para "mag ich Schwüle"
	line "und heiße Quellen."

	para "In der Safari-Zone"
	line "fühle ich mich wie"
	cont "zu Hause!"

	para "Lass uns im Kampf"
	line "glühend heiße"
	cont "Attacken tauschen!"
	done

.RematchText:
	text "Hallo,"
	line "<PLAYER>!"

	para "Schön, dich wie-"
	line "derzusehen!"

	para "Eine Niederlage"
	line "entmutigt mich"
	cont "nicht."

	para "Lass uns in einem"
	line "weiteren Kampf"
	cont "glühend heiße"
	cont "Attacken tauschen!"
	done

.SeenText:
	text "Ich zeige dir die"
	line "heißen Attacken,"

	para "die ich nahe einem"
	line "Vulkan verfeinert"
	cont "habe!"
	done

.BeatenText:
	text "Puh! Kurz vor dem"
	line "Ausbruch!"
	done

.AfterText:
	text "Ich habe den Kampf"
	line "verloren, bin aber"
	cont "völlig zufrieden."

	para "Nicht oft genieße"
	line "ich einen"

	para "so hitzigen"
	line "Kampf."

	para "Lass uns irgend-"
	line "wann wieder so"
	cont "einen austragen!"
	done

.RefusedText:
	text "Na gut… Äh…"
	line "Sei nicht schüch-"
	cont "tern, wenn du"
	cont "wiederkommst!"
	done
