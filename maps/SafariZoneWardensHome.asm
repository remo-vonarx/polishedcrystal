SafariZoneWardensHome_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  7, FUCHSIA_CITY, 5
	warp_event  5,  7, FUCHSIA_CITY, 5

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, picturebookshelf
	bg_event  5,  0, BGEVENT_JUMPTEXT, WardenPhotoText
	bg_event  7,  0, BGEVENT_JUMPTEXT, SafariZonePhotoText
	bg_event  8,  1, BGEVENT_JUMPTEXT, WardensHouseCuriosText
	bg_event  9,  1, BGEVENT_JUMPTEXT, WardensHouseCuriosText

	def_object_events
	object_event  2,  4, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, WardensGranddaughter, -1

WardensGranddaughter:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_WARDENS_GRANDDAUGHTER
	iftruefwd .AlreadyMet
	writetext WardensGranddaughterText1
	yesorno
	iffalse_jumpopenedtext WardensGranddaughterText2
	writetext WardensGranddaughterText3
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_WARDENS_GRANDDAUGHTER
	end
.AlreadyMet:
	jumpthisopenedtext

	text "Viele Leute waren"
	line "traurig, dass das"

	para "Safari-Spiel ein-"
	line "gestellt wurde,"

	para "aber mir fehlt es"
	line "nicht wirklich."

	para "Mir fehlt nur mein"
	line "Großvater…"
	done

WardensGranddaughterText1:
	text "Mein Großvater ist"
	line "der Wärter in der"
	cont "Safari-Zone."

	para "Zumindest war er"
	line "das…"

	para "Wenn ich dir die"
	line "Geschichte er-"
	cont "zähle, versprichst"

	para "du dann, nicht"
	line "darüber zu"
	cont "tratschen?"
	done

WardensGranddaughterText2:
	text "…Verstehe…"
	done

WardensGranddaughterText3:
	text "Vor drei Jahren"
	line "kam heraus, dass"

	para "er Team Rocket"
	line "erlaubt hatte,"

	para "in der Safari-Zone"
	line "zu wildern."

	para "Die #mon wurden"
	line "dann in der"
	cont "Rocket-Spielhalle"
	cont "verkauft."

	para "Er hat sich ins"
	line "Ausland abgesetzt,"
	cont "um nicht verhaftet"
	cont "zu werden."

	para "…Das ist nicht"
	line "fair."

	para "Der Chef von Silph"
	line "soll genauso mit"

	para "Team Rocket unter"
	line "einer Decke ge-"
	cont "steckt haben, aber"

	para "er hat für gemein-"
	line "nützige Projekte"
	cont "zum Schutz von"
	cont "#mon bezahlt"

	para "und hat seinen"
	line "Job immer noch."
	done

WardenPhotoText:
	text "Das Foto zeigt"
	line "einen lächelnden,"

	para "alten Mann umgeben"
	line "von #mon."
	done

SafariZonePhotoText:
	text "Das Foto zeigt"
	line "eine große Wiese,"

	para "auf der seltene"
	line "#mon"
	cont "herumtollen."
	done

WardensHouseCuriosText:
	text "Ein Kuriositäten-"
	line "schrank voller"

	para "Fossilien und"
	line "alter #mon-Fan-"
	cont "artikel."
	done
