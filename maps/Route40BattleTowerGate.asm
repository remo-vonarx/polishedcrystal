Route40BattleTowerGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  7, ROUTE_40, 1
	warp_event  5,  7, ROUTE_40, 1
	warp_event  4,  0, BATTLE_TOWER_OUTSIDE, 1
	warp_event  5,  0, BATTLE_TOWER_OUTSIDE, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route40BattleTowerGateOfficer, EVENT_BATTLE_TOWER_CLOSED
	object_event  3,  3, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route40BattleTowerGateRockerScript, -1
	object_event  7,  5, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route40BattleTowerGateTwinScript, -1

Route40BattleTowerGateOfficer:
	text "Gehst du zum"
	line "Duellturm?"

	para "Wenn du oft ge-"
	line "winnst, erhältst"

	para "du Gewinnpunkte"
	line "und kannst sie"
	cont "gegen spezielle"
	cont "Items tauschen."
	done

Route40BattleTowerGateRockerScript:
	checkevent EVENT_BATTLE_TOWER_OPEN
	iftrue_jumptextfaceplayer .OpenText
	jumpthistextfaceplayer

	text "Bist du auch wegen"
	line "des Duellturms"
	cont "hier?"

	para "Aber du kannst"
	line "wohl noch nicht"
	cont "rein."
	done

.OpenText:
	text "Der Duellturm hat"
	line "geöffnet."

	para "Ich will hin, aber"
	line "mir fehlt noch ein"

	para "cooler Spruch für"
	line "meine Siege."
	done

Route40BattleTowerGateTwinScript:
	checkevent EVENT_BATTLE_TOWER_OPEN
	iftrue_jumptextfaceplayer .OpenText
	jumpthistextfaceplayer

	text "Ich trainiere"
	line "meine #mon,"

	para "damit ich bereit"
	line "für den Duellturm"
	cont "bin."
	done

.OpenText:
	text "Die Level der"
	line "#mon, die ich"

	para "einsetzen möchte,"
	line "sind unter-"
	cont "schiedlich."

	para "Ich muss sie jetzt"
	line "trainieren!"
	done
