UnionCaveB1FNorth_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  3, RUINS_OF_ALPH_OUTSIDE, 8
	warp_event  3, 11, RUINS_OF_ALPH_OUTSIDE, 9
	warp_event 15, 23, UNION_CAVE_1F, 1

	def_coord_events

	def_bg_events
	bg_event 11, 23, BGEVENT_ITEM + X_SPEED, EVENT_UNION_CAVE_B1F_NORTH_HIDDEN_X_SPEED
	bg_event 13,  4, BGEVENT_ITEM + REVIVE, EVENT_UNION_CAVE_B1F_NORTH_HIDDEN_REVIVE

	def_object_events
	object_event  9,  4, SPRITE_HIKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerRuin_maniacLeland, -1
	object_event 13, 10, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerRuin_maniacPetry, -1
	tmhmball_event  5, 22, TM_SWIFT, EVENT_UNION_CAVE_B1F_NORTH_TM_SWIFT
	itemball_event 17, 21, X_DEFEND, 1, EVENT_UNION_CAVE_B1F_NORTH_X_DEFEND
	strengthboulder_event  7, 10

GenericTrainerRuin_maniacLeland:
	generictrainer RUIN_MANIAC, LELAND, EVENT_BEAT_RUIN_MANIAC_LELAND, .SeenText, .BeatenText

	text "Eines Tages ent-"
	line "decke ich eine"
	cont "neue Ruine und"
	cont "werde berühmt."
	done

.SeenText:
	text "Ich bin einer"
	line "uralten Ruinen-"
	cont "stätte auf der"
	cont "Spur!"
	done

.BeatenText:
	text "Die Hinweise aus"
	line "alter Zeit haben"
	cont "mich abgelenkt."
	done

GenericTrainerRuin_maniacPetry:
	generictrainer RUIN_MANIAC, PETRY, EVENT_BEAT_RUIN_MANIAC_PETRY, .SeenText, .BeatenText

	text "Alte Geschichte"
	line "ist meine Leiden-"
	cont "schaft,"

	para "aber um sie rich-"
	line "tig zu erforschen,"
	cont "nutzen wir moderne"
	cont "Technik."
	done

.SeenText:
	text "Ich gehe überall"
	line "hin, um alte Ge-"
	cont "heimnisse und Le-"
	cont "genden zu erfor-"
	cont "schen."
	done

.BeatenText:
	text "Was ist das Ge-"
	line "heimnis deiner"
	cont "Kraft?"
	done
