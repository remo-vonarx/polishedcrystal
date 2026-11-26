EusinesHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, EusinesHouseEusineCallback

	def_warp_events
	warp_event  2,  7, CELADON_CITY, 14
	warp_event  3,  7, CELADON_CITY, 14

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_EUSINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonEusine, EVENT_EUSINES_HOUSE_EUSINE
	object_event  5,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, EusinesHouseGrampsScript, -1

	object_const_def
	const EUSINESHOUSE_EUSINE

EusinesHouseEusineCallback:
	special UpdateEusineVisibility
	endcallback

CeladonEusine:
	special UpdateEusineVisibility
	ifnotequal EUSINE_RESEARCHING, .Gone
	faceplayer
	opentext
	writetext CeladonEusineText1
	promptbutton
	special SpecialBeastsCheck
	iffalsefwd .NoBeasts

.HoOh:
	writetext EusineLeavesCeladonText
	waitbutton
	closetext
	setevent EVENT_EUSINE_LEFT_CELADON
	special UpdateEusineVisibility
	readvar VAR_FACING
	ifnotequal UP, .PathClear
	applymovement PLAYER, .PlayerStepsAsideMovement
.PathClear:
	applymovement EUSINESHOUSE_EUSINE, .EusineLeavesMovement
	disappear EUSINESHOUSE_EUSINE
	playsound SFX_EXIT_BUILDING
	waitsfx
	end

.NoBeasts:
	writetext EusineNoBeastsText
	waitbutton
	closetext
	checkflag ENGINE_PLAYER_CAUGHT_RAIKOU
	iftruefwd .OwnRaikou
	showtext EusineShowsRaikouText
	reanchormap
	pokepic RAIKOU
	cry RAIKOU
	waitbutton
	closepokepic
	setmonval RAIKOU
	special SpecialSeenMon
.OwnRaikou
	checkflag ENGINE_PLAYER_CAUGHT_ENTEI
	iftruefwd .OwnEntei
	showtext EusineShowsEnteiText
	reanchormap
	pokepic ENTEI
	cry ENTEI
	waitbutton
	closepokepic
	setmonval ENTEI
	special SpecialSeenMon
.OwnEntei
	checkflag ENGINE_PLAYER_CAUGHT_SUICUNE
	iftruefwd .OwnSuicune
	showtext EusineShowsSuicuneText
	reanchormap
	pokepic SUICUNE
	cry SUICUNE
	waitbutton
	closepokepic
	setmonval SUICUNE
	special SpecialSeenMon
.OwnSuicune
	jumpthistext

	text "Wenn du auch nur"
	line "eins fängst, sag"
	cont "mir Bescheid."

	para "Ich zähle auf"
	line "dich, <PLAYER>!"
	done

.Gone:
	disappear EUSINESHOUSE_EUSINE
	end

.PlayerStepsAsideMovement:
	step_left
	turn_head_right
	step_end

.EusineLeavesMovement:
	step_down
	step_down
	step_down
	step_down
	step_end

EusinesHouseGrampsScript:
	special UpdateEusineVisibility
	ifequalfwd EUSINE_RESEARCHING, .Home
	ifequalfwd EUSINE_SEARCHING, .Searching
	ifequalfwd EUSINE_TRAVELING, .AfterFarewell
	jumpthistextfaceplayer

	text "Mein Enkel Eusin"
	line "ist wieder auf"
	cont "Abenteuerreise."

	para "Er wollte den"
	line "Glockenturm in"
	cont "Teak City"
	cont "besuchen."
	done

.Home:
	jumpthistextfaceplayer

	text "Mein Enkel ist"
	line "heimgekommen!"
	cont "Ich freue mich so!"
	done

.Searching:
	jumpthistextfaceplayer

	text "Mein Enkel Eusin"
	line "ist in Johto"

	para "und sucht überall"
	line "nach Suicune."

	para "Ich habe ihm alles"
	line "über die legendä-"
	cont "ren #mon"
	cont "beigebracht!"
	done

.AfterFarewell:
	checkevent EVENT_DECO_ABRA_DOLL
	iftrue_jumptextfaceplayer EusinesHouseGrampsEusineTravelingWorldText
	faceplayer
	opentext
	writetext EusinesHouseGrampsThankYouGiftText
	waitbutton
	writetext ReceivedAbraDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext AbraDollSentHomeText
	setevent EVENT_DECO_ABRA_DOLL
	waitbutton
	closetext
	end

ReceivedAbraDollText:
	text "<PLAYER> erhält"
	line "Abra-Puppe."
	done

AbraDollSentHomeText:
	text "Abra-Puppe"
	line "wurde nach Hause"
	cont "geschickt."
	done

CeladonEusineText1:
	text "Eusin: Hi!"

	para "Ich komme gerade"
	line "von meinem Heimat-"
	cont "ort zurück. Es ist"
	cont "schon lange her."
	done

EusineLeavesCeladonText:
	text "<PLAYER>, hast du"
	line "das gehört?"

	para "Es gibt neue Ge-"
	line "rüchte über ein"

	para "regenbogenfarbenes"
	line "#mon, dass"

	para "sich am"
	line "Glockenturm zeigt."

	para "Ich habe mein Team"
	line "gerade heilen las-"
	cont "sen und bin auf"
	cont "dem Weg nach Teak."

	para "Wir sehen uns spä-"
	line "ter, <PLAYER>!"
	done

EusineNoBeastsText:
	text "Ach, übrigens,"
	line "<PLAYER>."

	para "Hast du die"
	line "legendären #mon"
	cont "gefangen?"

	para "………………"

	para "OK…"

	para "Ich gebe dir meine"
	line "Forschungsnotizen."
	done

EusineShowsRaikouText:
	text "Das ist Raikou:"
	done

EusineShowsEnteiText:
	text "Das ist Entei:"
	done

EusineShowsSuicuneText:
	text "Und das ist"
	line "natürlich Suicune:"
	done

EusinesHouseGrampsThankYouGiftText:
	text "Mein Enkel Eusin"
	line "hat angerufen."

	para "Es geht ihm gut."
	line "Ich freue mich so!"

	para "Danke, dass du"
	line "nach mir siehst,"
	cont "<PLAYER>!"

	para "Bitte nimm dies"
	line "als Dankeschön."
	done

EusinesHouseGrampsEusineTravelingWorldText:
	text "Eusin bereist"
	line "gerade die Welt."

	para "Ich bin so stolz"
	line "auf ihn!"
	done
