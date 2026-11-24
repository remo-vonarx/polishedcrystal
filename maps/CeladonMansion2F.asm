CeladonMansion2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  0, CELADON_MANSION_1F, 4
	warp_event  1,  0, CELADON_MANSION_3F, 2
	warp_event  6,  0, CELADON_MANSION_3F, 3
	warp_event  7,  0, CELADON_MANSION_1F, 5

	def_coord_events

	def_bg_events
	bg_event  0,  3, BGEVENT_JUMPTEXT, CeladonMansion2FComputerText
	bg_event  5,  8, BGEVENT_UP, CeladonMansion2FSign
	bg_event  2,  3, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events

CeladonMansion2FSign:
	jumpthistext

	text "Game Freak"
	line "Konferenzraum"
	done

CeladonMansion2FComputerText:
	text "<PLAYER> hat den"
	line "PC eingeschaltet."

	para "…"

	para "Jemand war gerade"
	line "dabei, eine E-Mail"
	cont "aufzusetzen."

	para "…Ich hoffe, du"
	line "kommst einmal nach"
	cont "Kanto."

	para "Ich glaube, du"
	line "wärst überrascht,"

	para "wie viel sich hier"
	line "verändert hat."

	para "Man sieht auch"
	line "viele #mon, die"

	para "nicht aus Johto"
	line "stammen."

	para "An den Produzenten"

	para "…"
	done
