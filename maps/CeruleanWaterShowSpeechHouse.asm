CeruleanWaterShowSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CERULEAN_CITY, 11
	warp_event  3,  7, CERULEAN_CITY, 11

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeruleanWaterShowSpeechHouseCooltrainerMText, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  6,  3, SPRITE_POKEMANIAC, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeruleanWaterShowSpeechHouseSuperNerdText, -1

CeruleanWaterShowSpeechHouseCooltrainerMText:
	text "Misty tritt manch-"
	line "mal bei Wasser-"
	cont "shows in ihrer"
	cont "Arena auf."

	para "Das ist ein toller"
	line "Anblick!"
	done

CeruleanWaterShowSpeechHouseSuperNerdText:
	text "Ich habe auf das"
	line "Dach der Prisma-"
	cont "nia-Villa ein"
	cont "Graffiti gemalt."

	para "Hast du es schon"
	line "gesehen? Es ist"
	cont "etwas versteckt,"
	cont "hehe…"
	done
