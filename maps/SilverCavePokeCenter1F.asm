SilverCavePokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, SILVER_CAVE_OUTSIDE, 1
	warp_event  6,  7, SILVER_CAVE_OUTSIDE, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalLanceScript

	def_object_events
	pc_nurse_event  5, 1
	object_event  9,  4, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 1, 2, -1, 0, OBJECTTYPE_SCRIPT, 0, SilverCavePokeCenterGrampsScript, -1
	object_event  2,  4, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 1, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilverCavePokeCenter1FGrannyText, -1

PokemonJournalLanceScript:
	setflag ENGINE_READ_LANCE_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Champ Siegfried!"

	para "Siegfried wurde"
	line "gesehen, wie er"

	para "seine Umhänge im"
	line "Kaufhaus von"
	cont "Prismania City"
	cont "kaufte."
	done

SilverCavePokeCenterGrampsScript:
	checkevent EVENT_GOT_EXPERT_BELT
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writetext .GreetingText
	waitbutton
	readvar VAR_PKMN_JOURNALS
	ifequalfwd 0, .ReadNone
	ifequalfwd NUM_POKEMON_JOURNALS, .ReadThemAll
	jumpthisopenedtext

	text "Oh, du hast "
	text_decimal hScriptVar, 1, 2
	line "davon gelesen?"

	para "Nicht schlecht,"
	line "aber ich habe alle"
	cont "{d:NUM_POKEMON_JOURNALS} gelesen!"
	done

.ReadNone:
	jumpthisopenedtext

	text "Du hast keine"
	line "gelesen? Wie"
	cont "schade."

	para "Die meisten liegen"
	line "in den Regalen der"
	cont "#mon-Center,"

	para "aber echte Fans"
	line "wie ich spüren die"
	cont "seltenen Ausgaben"
	cont "auf."
	done

.ReadThemAll:
	writetext .ReadAllText
	promptbutton
	verbosegiveitem EXPERT_BELT, iffalse_endtext
	setevent EVENT_GOT_EXPERT_BELT
	jumpthisopenedtext

.AfterText:
	text "Der Gurt ist nicht"
	line "nur Zierde."

	para "Er stärkt deine"
	line "#mon, wenn sie"
	cont "ihn tragen."
	done

.GreetingText:
	text "In meiner Jugend"
	line "war ich selbst ein"
	cont "talentierter"
	cont "Trainer."

	para "Heute lese ich nur"
	line "noch im #mon"
	cont "Journal über"
	cont "andere."

	para "Liest du das"
	line "Journal auch?"
	done

.ReadAllText:
	text "Du hast alle"
	line "gelesen? Dann bist"

	para "du ein Journal-"
	line "Experte wie ich!"

	para "Nimm das, damit"
	line "jeder sieht, dass"
	cont "du ein Fan bist!"
	done

SilverCavePokeCenter1FGrannyText:
	text "Trainer, die nach"
	line "Stärke streben,"

	para "erklimmen den Sil-"
	line "berberg trotz sei-"
	cont "ner vielen Gefah-"
	cont "ren…"

	para "Durch ihre treuen"
	line "#mon haben"

	para "sie das Gefühl,"
	line "überall hinkommen"

	para "zu können…"
	done
