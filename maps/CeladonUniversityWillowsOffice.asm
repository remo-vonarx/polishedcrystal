CeladonUniversityWillowsOffice_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  5, CELADON_UNIVERSITY_2F, 3
	warp_event  4,  5, CELADON_UNIVERSITY_2F, 3

	def_coord_events

	def_bg_events
	bg_event  0,  0, BGEVENT_JUMPTEXT, CeladonUniversityWillowsOfficeBlackboardText
	bg_event  1,  0, BGEVENT_JUMPTEXT, CeladonUniversityWillowsOfficeBlackboardText
	bg_event  2,  1, BGEVENT_JUMPTEXT, CeladonUniversityWillowsOfficeBookshelf1Text
	bg_event  3,  1, BGEVENT_JUMPTEXT, CeladonUniversityWillowsOfficeBookshelf2Text
	bg_event  5,  2, BGEVENT_RIGHT, CeladonUniversityWillowsOfficeComputer

	def_object_events
	object_event  0,  2, SPRITE_WILLOW, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityWillowsOfficeWillowText, -1
	object_event  4,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityWillowsOfficeScientistText, -1

CeladonUniversityWillowsOfficeWillowText:
	text "Hallo! Ich bin"
	line "Prof. Willow."

	para "Ich betreue"
	line "Candela, Blanche"
	cont "und Spark bei"

	para "ihrer Lehre und"
	line "Forschung."

	para "Vielleicht triffst"
	line "du sie in den"
	cont "Kursen."

	para "Ich erforsche auch"
	line "Lebensräume und"
	cont "Verbreitung von"
	cont "#mon."

	para "Ich bin sehr be-"
	line "schäftigt, aber"

	para "meine hervorragen-"
	line "den Assistenten"
	cont "helfen mir dabei."
	done

CeladonUniversityWillowsOfficeScientistText:
	text "Ich darf als"
	line "Assistent von"
	cont "Prof. Willow"
	cont "arbeiten!"

	para "Ich katalogisiere"
	line "meine Beobachtun-"
	cont "gen von Route 7."

	para "Heute sah ich 42"
	line "Rattikarl und"
	cont "37 Tauboga…"
	cont "und ein Vulpix!"
	done

CeladonUniversityWillowsOfficeBlackboardText:
	text "Jemand schrieb"
	line "“NICHT LÖSCHEN”"

	para "mit einem Pfeil"
	line "auf ein unleser-"
	cont "liches Gekritzel…"
	done

CeladonUniversityWillowsOfficeBookshelf1Text:
	text "Ein Buch über öko-"
	line "logische Nischen"

	para "und wie #mon in"
	line "ihre Umgebung"
	cont "passen."
	done

CeladonUniversityWillowsOfficeBookshelf2Text:
	text "Ein Werbeflyer für"
	line "die Safari-Zone."

	para "Viele exotisch"
	line "aussehende #mon"
	cont "zieren ihn."
	done

CeladonUniversityWillowsOfficeComputer:
	jumpthistext

	text "Auf dem Bildschirm"
	line "steht “#mon-"
	cont "Transfer-System”."
	done
