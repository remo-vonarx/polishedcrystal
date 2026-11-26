LavenderPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, LAVENDER_TOWN, 1
	warp_event  6,  7, LAVENDER_TOWN, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalMrFujiScript

	def_object_events
	pc_nurse_event  5, 1
	object_event  1,  5, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, LavenderPokeCenter1FYoungsterScript, -1
	object_event 11,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavenderPokeCenter1FGentlemanText, -1
	object_event  6,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavenderPokeCenter1FTeacherText, -1

PokemonJournalMrFujiScript:
	setflag ENGINE_READ_MR_FUJI_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Redaktion: Der"
	line "scheue Mr. Fuji"

	para "lehnte unsere"
	line "Interviews ab."

	para "Er ist ein gütiger"
	line "Mann, den man in"

	para "Lavandia liebt und"
	line "respektiert."
	done

LavenderPokeCenter1FYoungsterScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse_jumptextfaceplayer .NoMachinePartText
	checkevent EVENT_EXORCISED_LAV_RADIO_TOWER
	iffalse_jumptextfaceplayer .NoExorcismText
	jumpthistextfaceplayer

	text "Der Intendant der"
	line "Radiostation war"
	cont "hoch erfreut."

	para "Er sagte, sie"
	line "seien endlich"
	cont "wieder auf"
	cont "Sendung!"
	done

.NoMachinePartText:
	text "Wenn das Kraftwerk"
	line "nicht funktio-"
	cont "niert, läuft der"

	para "Magnetzug auch"
	line "nicht…"

	para "Das bedeutet, dass"
	line "auch die Radio-"
	cont "station nicht"

	para "auf Sendung"
	line "gehen kann…"
	done

.NoExorcismText:
	text "Das Kraftwerk"
	line "läuft wieder ein-"
	cont "wandfrei, aber die"

	para "Radiostation sen-"
	line "det immer noch"
	cont "nicht."

	para "Was ist da drüben"
	line "nur los?"
	done

LavenderPokeCenter1FGentlemanText:
	text "Im Norden von"
	line "Lavandia ist der"

	para "Felstunnel. Er"
	line "führt zum"
	cont "Kraftwerk."
	done

LavenderPokeCenter1FTeacherText:
	text "Es gibt eine"
	line "Musiksendung im"
	cont "Radio, die Melo-"
	cont "dien auf der #-"
	cont "flöte sendet."

	para "Ach ja? Ah, dein"
	line "Radio braucht ein"
	cont "Zusatzset, damit"
	cont "du das empfangen"
	cont "kannst."
	done
