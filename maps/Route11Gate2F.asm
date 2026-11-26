Route11Gate2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  7, ROUTE_11_GATE_2F, -1

	def_coord_events

	def_bg_events
	bg_event  1,  2, BGEVENT_UP, Route11Gate2FBinoculars1
	bg_event  6,  2, BGEVENT_UP, Route11Gate2FBinoculars2

	def_object_events

Route11Gate2FBinoculars1:
	jumpthistext

	text "Du schaust durch"
	line "das Fernglas."

	para "Was für eine"
	line "schöne Aussicht!"
	done

Route11Gate2FBinoculars2:
	jumpthistext

	text "Du schaust durch"
	line "das Fernglas."

	para "Der einzige Weg"
	line "von Azuria City"
	cont "nach Lavandia"

	para "führt durch den"
	line "Felstunnel."
	done
