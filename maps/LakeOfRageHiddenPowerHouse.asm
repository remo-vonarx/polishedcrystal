LakeOfRageHiddenPowerHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, LAKE_OF_RAGE, 1
	warp_event  3,  7, LAKE_OF_RAGE, 1

	def_coord_events

	def_bg_events
	bg_event  5,  1, BGEVENT_JUMPSTD, radio2
	bg_event  6,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  7,  1, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events
	object_event  2,  3, SPRITE_FAT_GUY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, HiddenPowerGuy, -1

HiddenPowerGuy:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM10_HIDDEN_POWER
	iftruefwd .AlreadyGotItem
	writetext .Text1
	promptbutton
	verbosegivetmhm TM_HIDDEN_POWER
	setevent EVENT_GOT_TM10_HIDDEN_POWER
	writetext .Text2
	waitbutton
	sjumpfwd .CheckHiddenPower
.AlreadyGotItem:
	writetext .Text4
	waitbutton
.CheckHiddenPower
	writetext .Text3
	yesorno
	iffalse_jumpopenedtext .Text7
	writetext .Text5
	promptbutton
	special Special_HiddenPowerGuru
	iffalse_jumpopenedtext .Text4
	ifequalfwd $1, .Egg
	jumpthisopenedtext

	text "Ich spüre es…"

	para "Bei "
	text_ram wStringBuffer3
	line "ist Kraftreserve"
	cont "vom Typ "
	text_ram wStringBuffer1
	text "!"
	done

.Egg:
	jumpthisopenedtext

	text "Ein Ei hat noch"
	line "keine Kraftreserve"
	cont "entwickelt…"
	done

.Text1:
	text "…Du bist viel he-"
	line "rumgekommen…"

	para "Ich habe hier me-"
	line "ditiert. In mir"

	para "ist eine neue"
	line "Kraft zum Leben"
	cont "erwacht."

	para "Lass mich meine"
	line "Kraft mit deinen"

	para "#mon teilen."
	line "Nimm dies, Kind."
	done

.Text2:
	text "Siehst du? Das"
	line "ist Kraftreserve!"

	para "Sie bringt die"
	line "wahre Kraft der"
	cont "#mon zum"
	cont "Vorschein."

	para "Vergiss nicht: Der"
	line "Typ der Attacke"
	cont "hängt vom"
	cont "jeweiligen #mon"
	cont "ab."
	done

.Text3:
	text "Soll ich die"
	line "Kraftreserve"
	cont "deiner #mon"
	cont "ergründen?"
	done

.Text4:
	text "Ich meditiere…"
	done

.Text5:
	text "Welches #mon"
	line "soll ich auf seine"
	cont "Kraftreserve"
	cont "prüfen?"
	done

.Text7:
	text "…Nun gut…"
	done
