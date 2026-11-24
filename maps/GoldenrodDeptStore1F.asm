GoldenrodDeptStore1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  7, GOLDENROD_CITY, 9
	warp_event  8,  7, GOLDENROD_CITY, 24
	warp_event 15,  0, GOLDENROD_DEPT_STORE_2F, 2
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_JUMPTEXT, GoldenrodDeptStore1FDirectoryText

	def_object_events
	object_event 10,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore1FReceptionistText, -1
	object_event  5,  4, SPRITE_MATRON, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore1FPokefanFText, -1
	object_event  5,  5, SPRITE_CHILD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore1FBugCatcherText, -1
	object_event 11,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore1FGentlemanText, -1

GoldenrodDeptStore1FReceptionistText:
	text "Willkommen im"
	line "Kaufhaus von"
	cont "Dukatia City."
	done

GoldenrodDeptStore1FGentlemanText:
	text "Das Kaufhaus"
	line "bietet eine große"
	cont "Auswahl."

	para "Aber einige Items"
	line "erhält man nur als"

	para "Preis in der"
	line "Spielhalle."
	done

GoldenrodDeptStore1FPokefanFText:
	text "Ich freue mich"
	line "heute schon wieder"
	cont "aufs Einkaufen!"
	done

GoldenrodDeptStore1FBugCatcherText:
	text "Mama ist sehr gut"
	line "im Schnäppchen-"
	cont "finden."

	para "Sie kauft ständig"
	line "Waren unter dem"
	cont "Normalpreis."
	done

GoldenrodDeptStore1FDirectoryText:
	text "EG Info-Schalter"

	para "1S Trainer-"
	line "   Markt"

	para "2S Kampf-"
	line "   Kollektion"

	para "3S Arznei"

	para "4S TM-Ecke"

	para "5S Platz der"
	line "   ewigen Stille"

	para "Dachterrassen"
	line "Aussichtsplattform"
	done
