GoldenrodMuseum1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6,  7, GOLDENROD_CITY, 18
	warp_event  7,  7, GOLDENROD_CITY, 25
	warp_event 13,  7, GOLDENROD_MUSEUM_2F, 1

	def_coord_events

	def_bg_events
	bg_event  4,  1, BGEVENT_READ, GoldenrodMuseum1FLodestoneSignpostScript
	bg_event  8,  1, BGEVENT_JUMPTEXT, GoldenrodMuseum1FRadioDishText
	bg_event  9,  1, BGEVENT_JUMPTEXT, GoldenrodMuseum1FRadioDishText
	bg_event 12,  1, BGEVENT_JUMPTEXT, GoldenrodMuseum1FHarborText
	bg_event 13,  1, BGEVENT_JUMPTEXT, GoldenrodMuseum1FHarborText
	bg_event  1,  4, BGEVENT_JUMPTEXT, GoldenrodMuseum1FDrillText
	bg_event  2,  4, BGEVENT_JUMPTEXT, GoldenrodMuseum1FDrillText

	def_object_events
	object_event  1,  2, SPRITE_SLOWPOKETAIL, SPRITEMOVEDATA_MUSEUM_DRILL_DOWN, 0, 0, -1, PAL_NPC_DRILL, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  2,  2, SPRITE_SLOWPOKETAIL, SPRITEMOVEDATA_MUSEUM_DRILL_UP, 0, 0, -1, PAL_NPC_DRILL, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  7,  4, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodMuseumReceptionistText, -1
	object_event 13,  6, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodMuseumOfficerText, -1
	object_event  1,  5, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodMuseum1FHikerText, -1
	object_event 12,  3, SPRITE_PEARL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_PEARL, OBJECTTYPE_COMMAND, jumptext, GoldenrodMuseum1FBigPearlText, -1
	object_event 13,  3, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodMuseum1FRocketScoutScript, EVENT_GOLDENROD_CITY_ROCKET_SCOUT


GoldenrodMuseum1FLodestoneSignpostScript:
	reanchormap
	trainerpic METEORITE
	waitbutton
	closepokepic
	jumpthistext

	text "Magnetit vom Bau"
	line "des Magnettunnels."
	done

GoldenrodMuseum1FRocketScoutScript:
	opentext
	writetext GoldenrodMuseum1FRocketScoutText1
	promptbutton
	faceplayer
	writetext GoldenrodMuseum1FRocketScoutText2
	waitbutton
	closetext
	turnobject LAST_TALKED, LEFT
	end

GoldenrodMuseumReceptionistText:
	text "Willkommen im"
	line "Museum von"
	cont "Dukatia City."

	para "Zur Feier unserer"
	line "großen Eröffnung"

	para "ist der Eintritt"
	line "frei."

	para "Sieh dich ruhig"
	line "um. Wir hoffen,"

	para "dir gefällt dein"
	line "Besuch."
	done

GoldenrodMuseumOfficerText:
	text "Ich behalte dich"
	line "im Auge, Kleiner!"

	para "Hahaha! War nur"
	line "ein Scherz!"

	para "Ich behalte alle"
	line "im Auge…"
	done


GoldenrodMuseum1FDrillText:
	text "Ein großer Bohrer,"
	line "mit dem man sich"

	para "durch extrem"
	line "hartes Gestein"
	cont "gräbt."
	done

GoldenrodMuseum1FHikerText:
	text "Ich hörte, man"
	line "musste Maschinen"

	para "wie diesen Bohrer"
	line "benutzen, um den"

	para "Tunnel für den"
	line "Magnetzug zu"
	cont "graben."
	done

GoldenrodMuseum1FRadioDishText:
	text "Eine Metallschüs-"
	line "sel zum Senden"

	para "von Radiowellen."
	done

GoldenrodMuseum1FHarborText:
	text "Ein Aquarium"
	line "voller Karpador!"
	done

GoldenrodMuseum1FBigPearlText:
	text "Eine riesige Perle"
	line "aus dem Dukatia-"
	cont "Hafen geangelt."
	done

GoldenrodMuseum1FRocketScoutText1:
	text "Hmm… Das würde"
	line "einen hübschen"
	cont "Preis einbringen."

	para "Nun… wie kriege"
	line "ich es hier raus,"

	para "ohne erwischt zu"
	line "werden?"
	done

GoldenrodMuseum1FRocketScoutText2:
	text "Weißt du nicht,"
	line "dass Glotzen un-"
	cont "höflich ist?"
	cont "Hau ab, Kleiner!"
	done
