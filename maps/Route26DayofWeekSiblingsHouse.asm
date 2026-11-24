Route26DayofWeekSiblingsHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, ROUTE_26, 4
	warp_event  3,  7, ROUTE_26, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, DayOfWeekSiblingsHousePokedexScript, -1

DayOfWeekSiblingsHousePokedexScript:
	opentext
	writetext DayOfWeekSiblingsHousePokedexText1
	yesorno
	iffalsefwd .End
	writetext DayOfWeekSiblingsHousePokedexText2
	yesorno
	iffalsefwd .End
	writetext DayOfWeekSiblingsHousePokedexText3
	waitbutton
.End:
	endtext

DayOfWeekSiblingsHousePokedexText1:
	text "Hier steht etwas"
	line "geschrieben."

	para "Lesen?"
	done

DayOfWeekSiblingsHousePokedexText2:
	text "An meine Brüder"
	line "und Schwestern:"

	para "Wir sind stolz"
	line "darauf, #mon-"
	cont "Trainern zu"
	cont "dienen."

	para "Wenn ein Trainer"
	line "mit dir spricht,"
	cont "gib ihm etwas"
	cont "Nützliches."

	para "Eure"
	line "Monja"

	para "Weiterlesen?"
	done

DayOfWeekSiblingsHousePokedexText3:
	text "Montag, Monja"
	line "Route 40"

	para "Dienstag,"
	line "Dietlinde"
	cont "Route 29"

	para "Mittwoch, Mitko"
	line "See des Zorns"

	para "Donnerstag,"
	line "Donatus"
	cont "Route 36"

	para "Freitag, Frieda"
	line "Route 32"

	para "Samstag, Samson"
	line "Ebenholz City"

	para "Sonntag, Sonnfried"
	line "Route 37"
	done
