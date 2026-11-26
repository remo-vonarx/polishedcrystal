WarmBeachHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, WARM_BEACH, 3
	warp_event  3,  7, WARM_BEACH, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, WarmBeachHouseGrampsText, -1
	object_event  5,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, WarmBeachHouseGrannyText, -1
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, WarmBeachHouseBookScript, -1

WarmBeachHouseGrampsText:
	text "TODO"
	done

WarmBeachHouseGrannyText:
	text "TODO"
	done

WarmBeachHouseBookScript:
	opentext
	writetext .Text0
	yesorno
	iffalse_endtext
	writetext .Text1
	yesorno
	iffalse_endtext
	writetext .Text2
	yesorno
	iffalse_endtext
	jumpthisopenedtext

	text "Aus dem Trio der"
	line "Inseln nimm die"
	cont "alten Kugeln mit,"

	para "denn über Leben"
	line "und Tod entschei-"
	cont "det dein Schritt."

	para "Steig zum Schrein,"
	line "das Unrecht zu be-"
	cont "zwingen,"

	para "dann heilt die"
	line "Welt durch des"
	cont "Wächters Singen…"
	done

.Text0:
	text "Die Prophezeiung"
	line "von Shamouti"

	para "Willst du sie"
	line "lesen?"
	done

.Text1:
	text "Störe nicht die"
	line "Harmonie von"
	cont "Feuer, Eis und"
	cont "Blitz,"

	para "sonst werden diese"
	line "Titanen die Welt"
	cont "verwüsten, auf der"
	cont "sie kämpfen."

	para "Obwohl sich der"
	line "große Wächter des"
	cont "Wassers erheben"
	cont "wird, um den Kampf"
	cont "zu beenden,"

	para "wird sein Lied"
	line "allein scheitern,"
	cont "und so wird die"
	cont "Erde zu Asche."

	para "Weiterlesen?"
	done

.Text2:
	text "O Auserwählter,"
	line "bringe in deinen"
	cont "Händen alle drei"
	cont "zusammen."

	para "Ihre vereinten"
	line "Schätze zähmen die"
	cont "Bestie des Meeres."

	para "Weiterlesen?"
	done
