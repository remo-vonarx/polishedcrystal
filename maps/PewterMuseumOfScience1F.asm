PewterMuseumOfScience1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 10,  7, PEWTER_CITY, 6
	warp_event 11,  7, PEWTER_CITY, 8
	warp_event 16,  7, PEWTER_CITY, 7
	warp_event 17,  7, PEWTER_CITY, 7
	warp_event  7,  7, PEWTER_MUSEUM_OF_SCIENCE_2F, 1

	def_coord_events

	def_bg_events
	bg_event  2,  3, BGEVENT_READ, KabutopsFossilSignpostScript
	bg_event  6,  3, BGEVENT_READ, OmastarFossilSignpostScript
	bg_event  3,  6, BGEVENT_READ, AerodactylFossilSignpostScript
	bg_event 12,  1, BGEVENT_JUMPTEXT, Museum1FBookshelfSignpostText
	bg_event 13,  1, BGEVENT_JUMPTEXT, Museum1FBookshelfSignpostText
	bg_event 14,  1, BGEVENT_JUMPTEXT, Museum1FBookshelfSignpostText
	bg_event 15,  1, BGEVENT_JUMPTEXT, Museum1FBookshelfSignpostText
	bg_event 17,  1, BGEVENT_JUMPTEXT, Museum1FBookshelfSignpostText
	bg_event 18,  1, BGEVENT_JUMPTEXT, Museum1FBookshelfSignpostText

	def_object_events
	object_event 18,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GRAY, OBJECTTYPE_SCRIPT, 0, Museum1FFossilScientistScript, -1
	object_event 12,  4, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Museum1FReceptionistScript, -1
	object_event 16,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GRAY, OBJECTTYPE_COMMAND, jumptextfaceplayer, Museum1FScientistText, -1
	object_event  1,  7, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Museum1FGrampsText, -1
	object_event  4,  3, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Museum1FYoungsterText, -1

	object_const_def
	const PEWTERMUSEUMOFSCIENCE1F_SCIENTIST2

Museum1FFossilScientistScript:
	faceplayer
	opentext
	writetext Museum1FFossilScientistText
	waitbutton
	loadmem wResurrectFossilScriptBank, BANK(.FaceRight)
	loadmem wResurrectFossilScript+0, LOW(.FaceRight)
	loadmem wResurrectFossilScript+1, HIGH(.FaceRight)
	farsjump AskResurrectFossilScript

.FaceRight:
	turnobject PEWTERMUSEUMOFSCIENCE1F_SCIENTIST2, RIGHT
	end

Museum1FReceptionistScript:
	readvar VAR_FACING
	ifequalfwd DOWN, .Sneak
	ifequalfwd LEFT, .Sneak
	jumpthistextfaceplayer

	text "Willkommen!"

	para "Dank einer groß-"
	line "zügigen Spende der"
	cont "Silph Co."

	para "ist der Eintritt"
	line "kostenlos!"

	para "Bitte geh hinein."
	done

.Sneak:
	jumpthistextfaceplayer

	text "Du kannst dich"
	line "nicht durch die"
	cont "Hintertür rein-"
	cont "schleichen!"
	done

KabutopsFossilSignpostScript:
	reanchormap
	trainerpic KABUTOPS_FOSSIL
	waitbutton
	closepokepic
	jumpthistext

	text "Kabutops-Fossil"
	line "(Dom)"

	para "Ein urzeitliches"
	line "und seltenes"
	cont "#mon."
	done

OmastarFossilSignpostScript:
	reanchormap
	trainerpic OMASTAR_FOSSIL
	waitbutton
	closepokepic
	jumpthistext

	text "Amoroso-Fossil"
	line "(Helix)"

	para "Ein urzeitliches"
	line "und seltenes"
	cont "#mon."
	done

AerodactylFossilSignpostScript:
	reanchormap
	trainerpic AERODACTYL_FOSSIL
	waitbutton
	closepokepic
	jumpthistext

	text "Aerodactyl-Fossil"

	para "Ein urzeitliches"
	line "und seltenes"
	cont "#mon."
	done

Museum1FScientistText:
	text "Wir sind stolz auf"
	line "drei Fossilien"

	para "seltener, prähis-"
	line "torischer #mon."

	para "Ich habe beim Zu-"
	line "sammensetzen"
	cont "geholfen!"
	done

Museum1FFossilScientistText:
	text "Wusstest du, dass"
	line "man #mon aus"

	para "Fossilien wieder-"
	line "beleben kann?"

	para "Falls du das mal"
	line "brauchst, überlass"
	cont "es ruhig mir!"
	done

Museum1FGrampsText:
	text "Das ist ein"
	line "prächtiges"
	cont "Fossil!"
	done

Museum1FYoungsterText:
	text "Es gibt zwei Orte,"
	line "die ich liebe!"

	para "Der eine sind die"
	line "Alph-Ruinen in"
	cont "Johto."

	para "Der andere ist das"
	line "Museum von"
	cont "Marmoria!"

	para "Bei beiden spüre"
	line "ich den Hauch der"
	cont "Geschichte."
	done

Museum1FBookshelfSignpostText:
	text "Dicke, viel gele-"
	line "sene Bücher!"

	para "Handbuch der Ar-"
	line "chäologie, Verlo-"
	cont "rene #mon,"
	cont "#mon-Ahnen,"

	para "Pflege an der"
	line "Lehmschicht"
	cont "Kantos…"
	done
