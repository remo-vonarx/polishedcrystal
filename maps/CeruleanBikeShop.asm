CeruleanBikeShop_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CERULEAN_CITY, 8
	warp_event  3,  7, CERULEAN_CITY, 8

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeruleanBikeShopClerkScript, -1

CeruleanBikeShopClerkScript:
	showtextfaceplayer CeruleanBikeShopClerkText
	turnobject LAST_TALKED, UP
	end

CeruleanBikeShopClerkText:
	text "Vor langer Zeit"
	line "fuhr ein cooler"
	cont "Junge mit meinem"
	cont "Fahrrad herum,"

	para "und das löste"
	line "einen Fahrrad-"
	cont "Boom aus."

	para "Dann eröffnete ich"
	line "eine Filiale in"
	cont "Dukatia City."

	para "Die Räder gingen"
	line "weg wie nichts!"

	para "Aber in diesen"
	line "Laden kommt"
	cont "niemand mehr."

	para "Mir ist nur noch"
	line "eine Luftpumpe"
	cont "geblieben…"

	para "Soll ich Schwimm-"
	line "reifen verkaufen?"
	done
