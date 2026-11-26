ViridianMart_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, VIRIDIAN_CITY, 4
	warp_event  3,  7, VIRIDIAN_CITY, 4

	def_coord_events

	def_bg_events

	def_object_events
	mart_clerk_event  1,  3, MARTTYPE_STANDARD, MART_VIRIDIAN
	object_event  7,  2, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, ViridianMartLassText, -1
	object_event  1,  6, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, ViridianMartCooltrainerMText, -1

ViridianMartLassText:
	text "Der Arenaleiter"
	line "hier ist total"
	cont "cool."

	para "Als Einziger hat"
	line "er sich auf keinen"
	cont "Typ spezialisiert."

	para "Er lässt die Leute"
	line "gern im Unklaren."
	done

ViridianMartCooltrainerMText:
	text "Warst du schon auf"
	line "der Zinnober-"
	cont "insel?"

	para "Es ist gleich die"
	line "nächste Insel süd-"
	cont "lich von hier."
	done
