BillsHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CERULEAN_CAPE, 1
	warp_event  3,  7, CERULEAN_CAPE, 1

	def_coord_events

	def_bg_events
	bg_event  6,  1, BGEVENT_READ, PokemonJournalBillScript
	bg_event  7,  1, BGEVENT_READ, PokemonJournalBillScript
	bg_event  5,  1, BGEVENT_JUMPTEXT, BillsHousePCText

	def_object_events
	object_event  2,  3, SPRITE_BILL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, BillsHouseBillScript, EVENT_NEVER_MET_BILL

PokemonJournalBillScript:
	setflag ENGINE_READ_BILL_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "#maniac Bill!"

	para "Bill erfand das"
	line "#mon-Lagerungs-"
	cont "System, um seine"

	para "eigene riesige"
	line "#mon-Sammlung"
	cont "aufzubewahren."

	para "Das erste #mon,"
	line "das er fing, soll"

	para "ein Abra gewesen"
	line "sein."
	done

BillsHousePCText:
	text "Ein rotierendes"
	line "3D-Modell eines"
	cont "Porygon."
	done

BillsHouseBillScript:
	checkevent EVENT_BEAT_POKEMANIAC_BILL
	iftrue_jumptextfaceplayer .AfterText
	special SpecialBeastsCheck
	iffalse_jumptextfaceplayer .IntroText
	faceplayer
	opentext
	writetext .IntroText
	waitbutton
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer BILL_T, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_POKEMANIAC_BILL
	jumpthistext

.AfterText:
	text "Das war ein irrer"
	line "Kampf!"

	para "Jeder #maniac"
	line "wäre begeistert"

	para "zu sehen, was du"
	line "gefangen hast."
	done

.IntroText:
	text "Bill: Evoli ist"
	line "so ein faszinie-"
	cont "rendes #mon."

	para "Manche sagen, die"
	line "drei legendären"

	para "#mon Johtos"
	line "seien einst drei"
	cont "#mon gewesen,"

	para "die sich aus"
	line "Evoli entwickeln."

	para "Aber vielleicht"
	line "ist das nur ein"
	cont "Gerücht."

	para "Trotzdem würde ich"
	line "sie zu gern sehen…"
	done

.SeenText:
	text "Du hast alle drei"
	line "legendären #mon"
	cont "gefangen?"

	para "Das ist so cool,"
	line "<PLAYER>!"

	para "Glaubst du, sie"
	line "waren einst mit"
	cont "Evoli verwandt?"

	para "Mann, jetzt muss"
	line "ich dir mein Team"
	cont "zeigen!"

	para "Vergleich die drei"
	line "Legenden, gegen"

	para "die du gekämpft"
	line "hast, mit meinen"
	cont "#mon!"
	done

.BeatenText:
	text "Juchhu!"
	done
