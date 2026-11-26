IlexForestAzaleaGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  4, ILEX_FOREST, 2
	warp_event  0,  5, ILEX_FOREST, 3
	warp_event  9,  4, AZALEA_TOWN, 7
	warp_event  9,  5, AZALEA_TOWN, 8

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, IlexForestAzaleaGateOfficerText, -1
	object_event  1,  6, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, IlexForestAzaleaGateGrannyText, -1
	object_event  8,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ProfOaksAide1Script, -1

ProfOaksAide1Script:
	faceplayer
	opentext
	checkevent EVENT_GOT_EXP_SHARE_FROM_PROF_OAKS_AIDE
	iftruefwd .Explain
	writetext ProfOaksAide1HiText
	waitbutton
	setval16 15
	special CountCaught
	iftruefwd .HereYouGo
.UhOh
	jumpopenedtext ProfOaksAide1UhOhText

.HereYouGo
	writetext ProfOaksAide1HereYouGoText
	waitbutton
	verbosegiveitem EXP_SHARE, iffalsefwd .NoRoom
	setevent EVENT_GOT_EXP_SHARE_FROM_PROF_OAKS_AIDE
.Explain
	jumpthisopenedtext

	text "Der EP-Teiler"
	line "lässt ein #mon"

	para "Erfahrung sammeln,"
	line "ohne dass es"
	cont "kämpft."

	para "Nutze ihn, um den"
	line "#dex zu ver-"
	cont "vollständigen!"
	done

.NoRoom
	jumpthisopenedtext

	text "Oh! Du hast"
	line "keinen Platz mehr"
	cont "dafür."
	done

IlexForestAzaleaGateOfficerText:
	text "Vorsicht! Verlaufe"
	line "dich nicht! Der"
	cont "Steineichenwald"
	cont "ist groß."
	done

IlexForestAzaleaGateGrannyText:
	text "Der Wald wird von"
	line "seinem"
	cont "Schutzpatron"
	cont "bewacht."

	para "Mach keine"
	line "Dummheiten!"
	done

ProfOaksAide1HiText:
	text "Hallo! Ich bin ein"
	line "Assistent von"
	cont "Prof. Eich."

	para "Wenn du 15 Arten"
	line "#mon gefangen"
	cont "hast,"

	para "soll ich dir ein"
	line "Item geben."

	para "Also, <PLAYER>,"
	line "hast du schon"

	para "mindestens 15"
	line "Arten #mon"
	cont "gefangen?"
	done

ProfOaksAide1UhOhText:
	text "Mal sehen…"
	line "Oh je! Du hast nur"

	para ""
	text_decimal wTempDexOwn, 2, 3
	text " Arten #mon"
	line "gefangen."

	para "Komm wieder, wenn"
	line "du 15 Arten"
	cont "gefangen hast."
	done

ProfOaksAide1HereYouGoText:
	text "Mal sehen…"
	line "Toll! Du hast"

	para ""
	text_decimal wTempDexOwn, 2, 3
	text " Arten #mon"
	line "gefangen."

	para "Glückwunsch!"
	line "Bitte schön!"
	done
