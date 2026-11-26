VermilionHouseFishingSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, VERMILION_CITY, 1
	warp_event  3,  7, VERMILION_CITY, 1

	def_coord_events

	def_bg_events
	bg_event  5,  0, BGEVENT_JUMPTEXT, FishingGurusHousePhotoText

	def_object_events
	object_event  2,  4, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, FishingGuruText, -1

FishingGuruText:
	text "Ich bin der"
	line "Profi-Angler, der"
	cont "Mittlere der drei"
	cont "Anglerbrüder."

	para "Hast du meinen"
	line "Freund, den"
	cont "Angler, am See des"
	cont "Zorns getroffen?"

	para "Er träumt davon,"
	line "das größte"

	para "Karpador der Welt"
	line "zu sehen."

	para "Falls es dir"
	line "nichts ausmacht,"

	para "könntest du ihm"
	line "jedes Karpador"

	para "zeigen, das du"
	line "fängst?"

	para "Wer weiß, viel-"
	line "leicht fängst du"

	para "das Karpador"
	line "seiner Träume."
	done

FishingGurusHousePhotoText:
	text "Das ist ein Foto,"
	line "auf dem Angler zu"
	cont "sehen sind…"

	para "Sie haben viel"
	line "Spaß beim Angeln…"
	done
