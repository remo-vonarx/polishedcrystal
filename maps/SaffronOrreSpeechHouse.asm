SaffronOrreSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, SAFFRON_CITY, 17
	warp_event  3,  7, SAFFRON_CITY, 17

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_SILPH_EMPLOYEE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronOrreSpeechHouseSilphEmployeeText, -1
	object_event  5,  4, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronOrreSpeechHouseCooltrainerMText, -1

SaffronOrreSpeechHouseSilphEmployeeText:
	text "Ich habe von einer"
	line "Methode gehört,"
	cont "das Herz eines"
	cont "#mon zu"
	cont "verschließen"

	para "und es zu zwingen,"
	line "Menschen anzu-"
	cont "greifen."

	para "Wie kann man nur"
	line "#mon so etwas"
	cont "Schreckliches"
	cont "antun?!"
	done

SaffronOrreSpeechHouseCooltrainerMText:
	text "Wir kommen gerade"
	line "von einem"

	para "Freundesbesuch in"
	line "einer anderen"
	cont "Region."

	para "Dort gab es viel"
	line "Ärger mit zwei"
	cont "Verbrecherbanden,"

	para "aber ein talen-"
	line "tierter Trainer"
	cont "rettete alle."
	done
