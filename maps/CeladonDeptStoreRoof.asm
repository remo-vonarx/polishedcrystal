CeladonDeptStoreRoof_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 17,  2, CELADON_DEPT_STORE_5F, 2

	def_coord_events

	def_bg_events
	bg_event 16,  2, BGEVENT_JUMPTEXT, CeladonDeptStoreRoofDirectoryText

	def_object_events
	object_event 13,  2, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonDeptStoreRoofSuperNerdText, -1
	object_event 16,  5, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WANDER, 1, 2, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonDeptStoreRoofYoungsterText, -1
	object_event  5,  3, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonDeptStoreRoofGameboyKid1Script, -1
	object_event  8,  2, SPRITE_GAMER_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonDeptStoreRoofGameboyKid2Script, -1

CeladonDeptStoreRoofGameboyKid1Script:
	showtextfaceplayer .Text
	turnobject LAST_TALKED, DOWN
	end

.Text:
	text "Ich habe mein"
	line "#mon getauscht,"

	para "während es ein"
	line "Upgrade trug."
	done

CeladonDeptStoreRoofGameboyKid2Script:
	showtextfaceplayer .Text
	turnobject LAST_TALKED, DOWN
	end

.Text:
	text "Ja! Endlich"
	line "bekomme ich ein"
	cont "Porygon!"

	para "Ich bin nicht sehr"
	line "gut an den Spiel-"
	cont "automaten. Deswe-"
	cont "gen hatte ich nie"
	cont "genügend Münzen…"

	para "Ich ziehe es mit"
	line "einem Upgrade auf,"
	cont "damit es sich"
	cont "entwickelt!"
	done

CeladonDeptStoreRoofSuperNerdText:
	text "Ein Spielautomat"
	line "mit einem"
	cont "Roulette…"

	para "Die gibt es schon"
	line "lange nicht mehr."
	done

CeladonDeptStoreRoofYoungsterText:
	text "Im zweiten Stock"
	line "kann ich spielen,"
	cont "und wenn ich"

	para "Durst kriege,"
	line "komme ich hierher!"

	para "Dieses Kaufhaus"
	line "ist toll!"
	done

CeladonDeptStoreRoofDirectoryText:
	text "5S: Dachterrasse"
	line "Spielautomaten"
	done
