FuchsiaAquarium2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, FuchsiaAquariumCheckIfWeekend

	def_warp_events
	warp_event 10,  2, FUCHSIA_AQUARIUM_1F, 3

	def_coord_events

	def_bg_events
	bg_event  1,  5, BGEVENT_READ, FuchsiaAquarium1FRemoraidSign
	bg_event  2,  5, BGEVENT_READ, FuchsiaAquarium1FMantineSign
	bg_event  6,  5, BGEVENT_READ, FuchsiaAquarium1FSquirtleOrSeelSign
	bg_event 15,  5, BGEVENT_READ, FuchsiaAquarium1FShellderOrKrabbySign
	bg_event 16,  5, BGEVENT_READ, FuchsiaAquarium1FStaryuSign
	bg_event 12,  2, BGEVENT_JUMPTEXT, FuchsiaAquarium2FPosterText

	def_object_events
	object_event  1,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_ADMIN_MEOWTH, 0, REMORAID, -1, PAL_NPC_AQUA_BLUE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, -1
	object_event  2,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_TOP, 0, MANTINE, -1, PAL_NPC_AQUA_BLUE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, -1
	object_event  6,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_BOTTOM, 0, SQUIRTLE, -1, PAL_NPC_AQUA_BLUE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  6,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_ADMIN_MEOWTH, 0, SEEL, -1, PAL_NPC_AQUA_BLUE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 15,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_BOTTOM, 0, SHELLDER, -1, PAL_NPC_AQUA_PURPLE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 15,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_BOTTOM, 0, KRABBY, -1, PAL_NPC_AQUA_RED, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 16,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_BOTTOM, 0, STARYU, -1, PAL_NPC_AQUA_BROWN, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, -1
	object_event 12,  8, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, FuchsiaAquarium2FPokefanMScript, -1
	object_event 16, 7, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaAquarium2FPokefanFText, -1
	object_event  2,  7, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_DARK_RED, OBJECTTYPE_SCRIPT, 0, FuchsiaAquarium2FLassScript, -1
	object_event  3,  7, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_AZURE, OBJECTTYPE_SCRIPT, 0, FuchsiaAquarium2FBattleGirlScript, -1

FuchsiaAquarium1FRemoraidSign:
	showtext .RemoraidText
	reanchormap
	pokepic REMORAID
	cry REMORAID
	waitbutton
	closepokepic
	setmonval REMORAID
	special SpecialSeenMon
	end

.RemoraidText:
	text "Name: Remoraid"

	para "Mit seiner Rücken-"
	line "flosse saugt es"
	cont "sich unter einem"

	para "Mantax fest, um"
	line "nach Resten zu"
	cont "suchen."
	done

FuchsiaAquarium1FMantineSign:
	showtext .MantineText
	reanchormap
	pokepic MANTINE
	cry MANTINE
	waitbutton
	closepokepic
	setmonval MANTINE
	special SpecialSeenMon
	end

.MantineText:
	text "Name: Mantax"

	para "Wenn es genug"
	line "Tempo aufbaut,"

	para "kann es aus dem"
	line "Wasser über die"
	cont "Wellen fliegen."
	done

FuchsiaAquarium1FSquirtleOrSeelSign:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftruefwd .weekend
	showtext .SquirtleText
	reanchormap
	pokepic SQUIRTLE
	cry SQUIRTLE
	waitbutton
	closepokepic
	setmonval SQUIRTLE
	special SpecialSeenMon
	end

.weekend:
	showtext .SeelText
	reanchormap
	pokepic SEEL
	cry SEEL
	waitbutton
	closepokepic
	setmonval SEEL
	special SpecialSeenMon
	end

.SquirtleText:
	text "Name: Schiggy"

	para "Sein Panzermuster"
	line "ähnelt einer alten"
	cont "Münze, daher hat"

	para "eine Region kürz-"
	line "lich ¥100-Gedenk-"

	para "münzen mit Schiggy"
	line "herausgebracht."
	done

.SeelText:
	text "Name: Jurob"

	para "Dieses #mon"
	line "trinkt kein"
	cont "Wasser--"

	para "es bezieht seine"
	line "ganze Flüssigkeit"
	cont "aus seiner Beute."
	done

FuchsiaAquarium1FShellderOrKrabbySign:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftruefwd .weekend
	showtext .ShellderText
	reanchormap
	pokepic SHELLDER
	cry SHELLDER
	waitbutton
	closepokepic
	setmonval SHELLDER
	special SpecialSeenMon
	end

.weekend:
	showtext .KrabbyText
	reanchormap
	pokepic KRABBY
	cry KRABBY
	waitbutton
	closepokepic
	setmonval KRABBY
	special SpecialSeenMon
	end

.ShellderText:
	text "Name: Muschas"

	para "Es verändert seine"
	line "Form drastisch,"

	para "wenn es sich in"
	line "ein Flegmon ver-"
	cont "beißt, um sich mit"
	cont "ihm zu entwickeln,"

	para "doch das gilt"
	line "nicht als eigene"
	cont "Entwicklung."
	done

.KrabbyText:
	text "Name: Krabby"

	para "Angler ließen ge-"
	line "fangene Krabby"
	cont "frei, deren Panzer"

	para "einem zornigen"
	line "Samurai glichen."

	para "Deshalb gibt es"
	line "heute vielleicht"

	para "mehr Krabby mit"
	line "Panzermustern, die"
	cont "menschlichen"
	cont "Gesichtern ähneln."
	done

FuchsiaAquarium1FStaryuSign:
	showtext .StaryuText
	reanchormap
	pokepic STARYU
	cry STARYU
	waitbutton
	closepokepic
	setmonval STARYU
	special SpecialSeenMon
	end

.StaryuText:
	text "Name: Sterndu"

	para "In einer beliebten"
	line "Science-Fiction-"

	para "Serie für Kinder"
	line "nutzen Superhelden"

	para "Kräfte, die auf"
	line "Sterndus Juwel"
	cont "beruhen."
	done

FuchsiaAquarium2FPosterText:
	text "Am Wochenende"
	line "wechseln wir die"

	para "Ausstellung, damit"
	line "sich die #mon"
	cont "nicht langweilen."
	done

FuchsiaAquarium2FPokefanMScript:
	checkevent EVENT_GOT_EJECT_BUTTON_FROM_FUCHSIA_AQUARIUM
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem EJECT_BUTTON, iffalse_endtext
	setevent EVENT_GOT_EJECT_BUTTON_FROM_FUCHSIA_AQUARIUM
	jumpthisopenedtext

.Text2:
	text "Einmal habe ich"
	line "ein Chaneira mit"
	cont "einem Stein ge-"
	cont "troffen, und es"

	para "floh so schnell,"
	line "als hätte es einen"
	cont "Fluchtknopf ge-"
	cont "tragen."

	para "Ach, die guten"
	line "alten Zeiten…"
	done

.Text1:
	text "All die #mon"
	line "hinter Glas, aber"

	para "ich kann nichts"
	line "nach ihnen werfen!"

	para "Ich vermisse es,"
	line "im Safari-Spiel"
	cont "Köder und Steine"
	cont "zu werfen…"

	para "Bis sie über die"
	line "Lautsprecher die"

	para "Zeit ausriefen und"
	line "mich rauswarfen."

	para "Ach, das kannst du"
	line "genauso gut haben."
	done

FuchsiaAquarium2FPokefanFText:
	text "Dass der Wärter so"
	line "plötzlich wegging,"

	para "war ein Glück im"
	line "Unglück."

	para "Jetzt haben wir"
	line "dieses schöne"
	cont "Aquarium!"
	done

FuchsiaAquarium2FLassScript:
	turnobject LAST_TALKED, RIGHT
	showtext .Text1
	faceplayer
	showtext .Text2
	turnobject LAST_TALKED, UP
	end

.Text1:
	text "Remoraid hängt an"
	line "Mantax und teilt"
	cont "dessen Wohlstand…"

	para "Wie romantisch,"
	line "oder?"
	done

.Text2:
	text "Ich habe mir viele"
	line "#dex-Fakten"

	para "gemerkt, um mein"
	line "Date zu begeis-"
	cont "tern!"
	done

FuchsiaAquarium2FBattleGirlScript:
	faceplayer
	showtext .Text
	turnobject LAST_TALKED, UP
	end

.Text:
	text "Dieses Mädchen"
	line "fachsimpelt schon"

	para "seit einer Stunde"
	line "über Wasser-"
	cont "#mon…"

	para "Ob sie zum Valen-"
	line "tinstag lieber"
	cont "Fisch als Schoko-"
	cont "lade möchte?"
	done
