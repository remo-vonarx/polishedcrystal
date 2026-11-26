FuchsiaFishingSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, FUCHSIA_CITY, 14
	warp_event  3,  7, FUCHSIA_CITY, 14
	warp_event  3,  0, FUCHSIA_CITY, 15

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaCityFishingGuruText, -1

FuchsiaCityFishingGuruText:
	text "Ich bin der ältere"
	line "Bruder des Profi-"
	cont "Anglers."

	para "Ich liiiebe das"
	line "Angeln!"

	para "Wenn du auch gern"
	line "angelst, kannst du"

	para "es gern im Teich"
	line "in meinem Garten"
	cont "versuchen!"
	done
