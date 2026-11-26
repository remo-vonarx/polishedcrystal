ViridianSchoolHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  9, VIRIDIAN_CITY, 8
	warp_event  3,  9, VIRIDIAN_CITY, 8

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_JUMPTEXT, ViridianSchoolHouseBlackboardText
	bg_event  6,  1, BGEVENT_READ, PokemonJournalKiyoScript
	bg_event  7,  1, BGEVENT_READ, PokemonJournalKiyoScript

	def_object_events
	object_event  4,  1, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, ViridianSchoolHouseTeacherText, -1
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptext, ViridianSchoolHouseNotesText, -1
	object_event  3,  4, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, ViridianSchoolHouseLass1Text, -1
	object_event  5,  4, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, ViridianSchoolHouseYoungsterScript, -1
	object_event  2,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, ViridianSchoolHouseLass2Text, -1
	object_event  3,  6, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ViridianSchoolHouseGameBoyKidScript, -1

ViridianSchoolHouseTeacherText:
	text "Ich weiß, das ist"
	line "viel Stoff, aber"

	para "bitte passt auf!"
	done

ViridianSchoolHouseNotesText:
	text "Die Seite ist"
	line "vollgekritzelt."
	para "Ein Labyrinth,"
	line "Blumen, der Buch-"
	cont "stabe S…"
	done

ViridianSchoolHouseLass1Text:
	text "Warte! Ich dachte,"
	line "irgendwie alle"

	para "Feuer-Attacken"
	line "wären Spezial-"
	cont "attacken?"
	done

ViridianSchoolHouseYoungsterScript:
	checkevent EVENT_GOT_WEAK_POLICY_FROM_VIRIDIAN
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem WEAK_POLICY, iffalse_endtext
	setevent EVENT_GOT_WEAK_POLICY_FROM_VIRIDIAN
	jumpthisopenedtext

.Text2:
	text "“Was ein #mon"
	line "nicht umhaut,"
	cont "macht es stärker.”"

	para "So wirkt der"
	line "Schwächenschutz."
	done

.Text1:
	text "Die Lehrerin hat"
	line "mir mehr Exemplare"

	para "davon gegeben."
	line "Hier, nimm eins."
	done

ViridianSchoolHouseGameBoyKidScript:
	showtextfaceplayer ViridianSchoolHouseGameBoyKidText
	turnobject LAST_TALKED, DOWN
	end

ViridianSchoolHouseGameBoyKidText:
	text "Ich mache Notizen"
	line "auf meinem Handy!"

	para "Ich albere nicht"
	line "herum! Ehrlich!"
	done

ViridianSchoolHouseLass2Text:
	text "Ich sitze auf dem"
	line "Platz der Haupt-"
	cont "figur!"

	para "Warum ist mein"
	line "Leben dann so"
	cont "langweilig?"
	done

ViridianSchoolHouseBlackboardText:
	text "Körperattacken"
	line "nutzen die Werte"
	cont "Angr und Vert."

	para "Spezialattacken"
	line "nutzen die Werte"
	cont "Sp.Angr und"
	cont "Sp.Vert."

	para "Status-Attacken"
	line "richten keinen"
	cont "direkten Schaden"
	cont "an."
	done

PokemonJournalKiyoScript:
	setflag ENGINE_READ_KIYO_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Karate-Meister"
	cont "Leif!"

	para "Leif soll bei"
	line "Hartwig aus"

	para "Anemonia City in"
	line "die Lehre gegangen"
	cont "sein."

	para "Gerüchten zufolge"
	line "trainiert er noch"
	cont "irgendwo in Johto."
	done
