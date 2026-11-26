ShamoutiTouristCenter_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, SHAMOUTI_ISLAND, 4
	warp_event  3,  7, SHAMOUTI_ISLAND, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_LARRY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, LarryScript, -1

	object_const_def
	const SHAMOUTITOURISTCENTER_LARRY

LarryScript:
	faceplayer
	checkevent EVENT_BEAT_LARRY
	iftruefwd .After
	opentext
	checkevent EVENT_INTRODUCED_LARRY
	iftruefwd .Introduced
	writetext .IntroText
	sjumpfwd .Question
.Introduced
	writetext .RematchText
.Question
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	setevent EVENT_INTRODUCED_LARRY
	winlosstext .BeatenText, 0
	setlasttalked SHAMOUTITOURISTCENTER_LARRY
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftruefwd .Rematch
	loadtrainer LARRY, 1
	sjumpfwd .StartBattle
.Rematch
	loadtrainer LARRY, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_LARRY
.After
	opentext
	checkevent EVENT_GOT_SWEET_HONEY_FROM_LARRY
	iftruefwd .Done
	writetext .RewardText
	promptbutton
	verbosegiveitem SWEET_HONEY, iffalse_endtext
	setevent EVENT_GOT_SWEET_HONEY_FROM_LARRY
.Done
	jumpthisopenedtext

	text "So, ich sollte"
	line "wieder an die"
	cont "Arbeit."

	para "Wenn du mich ent-"
	line "schuldigst."
	done

.RewardText:
	text "Für mich ist das"
	line "Beste am Reisen,"

	para "die regionalen"
	line "Gerichte zu"
	cont "probieren."

	para "Das Restaurant"
	line "hier in der Nähe"

	para "macht ein dekaden-"
	line "tes Dessert"
if DEF(FAITHFUL)
	cont "mit Honig."
else
	cont "mit Honig."
endc

	para "Ich gebe dir"
	line "etwas davon ab."
	done

.IntroText:
	text "Hallo."
	line "Ich bin Aoki."

	para "Mein Chef hat mich"
	line "geschäftlich her-"
	cont "geschickt, aber"

	para "ich kann es mir"
	line "dabei ja auch gut"
	cont "gehen lassen."

	para "Ich habe gerade im"
	line "Restaurant Oase im"
	cont "Hotel gegessen."

	para "Das hat mir Appe-"
	line "tit auf einen noch"
	cont "stärkeren Kampf"
	cont "gemacht."

	para "Machst du mit?"
	done

.RematchText:
	text "Hallo noch mal,"
	line "<PLAYER>."

	para "Du bist schon"
	line "gegen mich ange-"
	cont "treten, also be-"

	para "zweifle ich, dass"
	line "dich das hier sehr"
	cont "beeindrucken wird."

	para "Wie auch immer,"
	line "sollen wir"
	cont "anfangen?"
	done

.SeenText:
	text "Ich, Aoki, stehe"
	line "dir zu Diensten."
	done

.BeatenText:
	text "Nun, ich bin"
	line "satt…"
	done

.RefusedText:
	text "Vielleicht ein"
	line "andermal, wenn es"
	cont "terminlich passt."
	done
