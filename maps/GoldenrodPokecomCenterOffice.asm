GoldenrodPokecomCenterOffice_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  8, GOLDENROD_POKECOM_CENTER_1F, 3
	warp_event  1,  8, GOLDENROD_POKECOM_CENTER_1F, 3

	def_coord_events

	def_bg_events
	bg_event  3,  2, BGEVENT_UP, RangiComputerScript
	bg_event  6,  2, BGEVENT_UP, LunaComputerScript
	bg_event  9,  2, BGEVENT_UP, FredrikComputerScript
	bg_event 12,  2, BGEVENT_UP, EmiComputerScript
	bg_event  6,  5, BGEVENT_UP, AizawaComputerScript
	bg_event  9,  5, BGEVENT_UP, VulcanComputerScript
	bg_event 12,  5, BGEVENT_UP, SourComputerScript

	def_object_events
	object_event  4,  4, SPRITE_SCIENTIST_F, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, PAL_NPC_RANGI, OBJECTTYPE_COMMAND, jumptextfaceplayer, AdminRangiText, -1
	object_event  7,  3, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, AdminLunaText, -1
	object_event 10,  3, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, AdminFredrikText, -1
	object_event 13,  3, SPRITE_DAISY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_EMI, OBJECTTYPE_COMMAND, jumptextfaceplayer, AdminEmiText, -1
	object_event  7,  6, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, AdminAizawaText, -1
	object_event 10,  6, SPRITE_PI, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_AZURE, OBJECTTYPE_COMMAND, jumptextfaceplayer, AdminVulcanText, -1
	object_event 13,  6, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, AdminSourText, -1
	object_event  4,  1, SPRITE_MON_ICON, SPRITEMOVEDATA_ADMIN_MEOWTH, 0, MEOWTH, -1, PAL_MON_BROWN, OBJECTTYPE_SCRIPT, NO_FORM, AdminEldredScript, -1

AdminRangiText:
	text "Rangi: Ich hoffe,"
	line "dir gefällt deine"

	para "Reise durch dieses"
	line "Spiel!"

	para "Es war schwierig,"
	line "alle Daten unter-"
	cont "zubringen."

	para "Es war kaum noch"
	line "Platz für mein"
	cont "Sprite!"
	done

RangiComputerScript:
	jumpthistext

	text "“Optimiere…”"
	line "blinkt auf dem"
	cont "Bildschirm."

	para "Das scheint eine"
	line "Weile zu dauern."
	done

AdminLunaText:
	text "Luna: Als du zum"
	line "ersten Mal mit"

	para "jemandem aus einer"
	line "anderen Region"
	cont "Wundertausch ge-"
	cont "macht hast, warst"
	cont "du da nicht beein-"
	cont "druckt?"

	para "Ich habe das Ori-"
	line "ginalsystem genau"
	cont "hier in Dukatia"
	cont "City gebaut!"
	done

LunaComputerScript:
	jumpthistext

	text "Ein Bildschirm"
	line "voller dichter"
	cont "Notizen,"

	para "Karten unbekann-"
	line "ter Orte und ein"

	para "Bild von Johto"
	line "unter Schnee."
	done

AdminFredrikText:
	text "Fredrik: Bills"
	line "PC-Boxsystem ist"
	cont "Open Source,"

	para "also konnte ich"
	line "seine Datenbank"

	para "komplett neu"
	line "schreiben und"
	cont "verbessern!"
	done

FredrikComputerScript:
	jumpthistext

	text "Ein Dutzend Fens-"
	line "ter sind offen,"

	para "jedes zu einer"
	line "eigenen Funktion."
	done

AdminEmiText:
	text "Emi: Hast du dir"
	line "die Statusseiten"
	cont "deiner #mon"
	cont "angesehen?"

	para "Ich komme aus der"
	line "Beria-Region, um"

	para "so eine Ober-"
	line "fläche nach Johto"
	cont "zu bringen!"

	para "Sag mal Hallo,"
	line "wenn du in"
	cont "Amethyst Town"
	cont "bist!"
	done

EmiComputerScript:
	jumpthistext

	text "Viel Code ist von"
	line "einer Partie Soli-"
	cont "taire verdeckt."
	done

AdminAizawaText:
	text "Aizawa: Dialoge,"
	line "Kartendesigns,"
	cont "Figuren-Sprites,"
	cont "Trainer-Teams…"

	para "Game Freak in"
	line "Kanto hat Glück,"

	para "dafür eine ganze"
	line "Firma zu haben!"
	done

AizawaComputerScript:
	jumpthistext

	text "Das Programm"
	line "Polished Map++"
	cont "zeigt eine halb"

	para "gezeichnete Tro-"
	line "peninsel."
	done

AdminVulcanText:
	text "Vulcan: Wie ist"
	line "das Wetter?"

	para "Das ist kein"
	line "Smalltalk… Ich"
	cont "habe es wirklich"
	cont "eingebaut!"

	para "Wir dachten, das"
	line "geht nicht…"

	para "Ich habe mich"
	line "selbst widerlegt!"
	done

VulcanComputerScript:
	jumpthistext

	text "Auf dem Bildschirm"
	line "ist eine Wetter-"
	cont "karte zu sehen."

	para "Sie zeigt Regen"
	line "in Johto."
	done

AdminSourText:
	text "Sour: Wie gefallen"
	line "dir die Attacken-"
	cont "Animationen im"
	cont "Kampf?"

	para "Ich will jede"
	line "Attacke zu einem"
	cont "Vergnügen machen!"
	done

SourComputerScript:
	jumpthistext

	text "Ein albernes Bild"
	line "von einem eiförmi-"
	cont "gen Mann mit"
	cont "Schnurrbart."
	done

AdminEldredScript:
	opentext
	writetext AdminMeowthText
	cry MEOWTH
	promptbutton
	jumpthisopenedtext

	text "Ein freches Mauzi"
	line "tatzelt auf der"
	cont "Tastatur herum."
	done

AdminMeowthText:
	text "Eldred: Miau!"
	done
