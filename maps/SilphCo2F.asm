SilphCo2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 13,  0, SILPH_CO_1F, 3
	warp_event 11,  0, SILPH_CO_3F, 1

	def_coord_events

	def_bg_events
	bg_event  8,  0, BGEVENT_JUMPTEXT, SilphCoElevatorText
	bg_event  2,  3, BGEVENT_JUMPTEXT, SilphCo2FDeptSignText
	bg_event  9,  3, BGEVENT_JUMPTEXT, SilphCo2FDeptSignText
	bg_event  1,  1, BGEVENT_JUMPTEXT, SilphCo2FPrinterText
	bg_event 14,  5, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event 15,  5, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events
	object_event  6,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCo2FScientist1Text, -1
	object_event 12,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCo2FScientist2Text, -1
	object_event  3,  6, SPRITE_SILPH_EMPLOYEE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCo2FEmployee1Script, -1
	object_event 12,  9, SPRITE_SILPH_EMPLOYEE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCo2FSilphEmployee2Text, -1

SilphCo2FEmployee1Script:
	faceplayer
	opentext
	checkevent EVENT_GOT_UPGRADE
	iftruefwd .GaveUpgrade
	writetext .Text1
	promptbutton
	verbosegiveitem UPGRADE, iffalsefwd .NoRoomForUpgrade
	setevent EVENT_GOT_UPGRADE
.GaveUpgrade:
	writetext .Text2
	waitbutton
.NoRoomForUpgrade:
	endtext

.Text1:
	text "Du kommst aus"
	line "Johto?"

	para "Da du von so weit"
	line "hergekommen bist,"

	para "gebe ich dir"
	line "dieses hübsche"
	cont "Souvenir."
	done

.Text2:
	text "Das ist das"
	line "neueste Produkt"

	para "der Silph Co. Das"
	line "gibt es noch nir-"
	cont "gends zu kaufen."
	done

SilphCo2FSilphEmployee2Text:
	text "Früher kamen wir"
	line "mit Teleportern"

	para "herum, aber sie"
	line "wurden abgeschal-"
	cont "tet."

	para "Zum Glück arbeite"
	line "ich im ersten"
	cont "Stock!"
	done

SilphCo2FScientist1Text:
	text "Wir arbeiten stän-"
	line "dig an neuen TMs."

	para "Manche wurden"
	line "eingestellt, aber"

	para "andere sind so be-"
	line "liebt, dass sie"

	para "sich seit über 30"
	line "Jahren nicht ver-"
	cont "ändert haben!"
	done

SilphCo2FScientist2Text:
	text "Ich programmiere!"
	line "Stör nicht meine"
	cont "Konzentration!"
	done

SilphCo2FDeptSignText:
	text "Silph Co. 1S"
	line "Softwareabteilung"
	done

SilphCo2FPrinterText:
	text "Ein Drucker."
	done
