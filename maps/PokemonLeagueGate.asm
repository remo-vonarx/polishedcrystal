PokemonLeagueGate_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_POKEMONLEAGUEGATE_BADGE_CHECK
	scene_const SCENE_POKEMONLEAGUEGATE_NOOP

	def_callbacks
	callback MAPCALLBACK_NEWMAP, PokemonLeagueGateFlyPoint

	def_warp_events
	warp_event 21,  6, ROUTE_22, 1
	warp_event 21,  7, ROUTE_22, 2
	warp_event 10, 17, ROUTE_26, 1
	warp_event 11, 17, ROUTE_26, 2
	warp_event 10,  0, ROUTE_23_SOUTH, 1
	warp_event 11,  0, ROUTE_23_SOUTH, 2
	warp_event  0,  6, ROUTE_28, 2
	warp_event  0,  7, ROUTE_28, 3

	def_coord_events
	coord_event 10, 10, SCENE_POKEMONLEAGUEGATE_BADGE_CHECK, PokemonLeagueGateXYTriggerScript1
	coord_event 11, 10, SCENE_POKEMONLEAGUEGATE_BADGE_CHECK, PokemonLeagueGateXYTriggerScript2

	def_bg_events

	def_object_events
	object_event  8, 10, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, VictoryRoadGateOfficerScript, -1
	object_event  7,  5, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VictoryRoadGateLeftBlackBeltText, EVENT_OPENED_MT_SILVER
	object_event 14,  5, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VictoryRoadGateRightBlackBeltText, EVENT_FOUGHT_SNORLAX

PokemonLeagueGateFlyPoint:
	setflag ENGINE_FLYPOINT_POKEMON_LEAGUE
	endcallback

PokemonLeagueGateXYTriggerScript2:
	applyonemovement PLAYER, step_left
PokemonLeagueGateXYTriggerScript1:
	turnobject PLAYER, LEFT
	sjumpfwd VictoryRoadGateBadgeCheckScript

VictoryRoadGateOfficerScript:
	faceplayer
VictoryRoadGateBadgeCheckScript:
	showtext VictoryRoadGateOfficerText
	setscene SCENE_POKEMONLEAGUEGATE_NOOP
	end

VictoryRoadGateOfficerText:
	text "Nur Trainer, die"
	line "sich als würdig"
	cont "erwiesen haben,"
	cont "dürfen eintreten."

	para "Hast du die Arenen"
	line "von Johto heraus-"
	cont "gefordert?"

	para "Die Wachen weiter"
	line "vorne prüfen deine"
	cont "Orden."

	para "Geh nur weiter."
	done

VictoryRoadGateLeftBlackBeltText:
	text "Dieser Weg führt"
	line "zum Silberberg."

	para "Dir werden be-"
	line "ängstigend starke"
	cont "#mon begegnen."
	done

VictoryRoadGateRightBlackBeltText:
	text "Du bist auf dem"
	line "Weg zur #mon"
	cont "Liga, nicht wahr?"

	para "Die Top Vier sind"
	line "so stark, dass es"

	para "einem Angst macht."
	line "Sie erwarten dich!"
	done
