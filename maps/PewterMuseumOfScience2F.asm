PewterMuseumOfScience2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  7, PEWTER_MUSEUM_OF_SCIENCE_1F, 5

	def_coord_events

	def_bg_events
	bg_event  3,  6, BGEVENT_READ, Museum2FMoonStoneSignpostScript
	bg_event 11,  2, BGEVENT_JUMPTEXT, Museum2FSpaceShuttleSignpostText
	bg_event  0,  1, BGEVENT_READ, PokemonJournalStevenScript
	bg_event  1,  1, BGEVENT_READ, PokemonJournalStevenScript
	bg_event  4,  1, BGEVENT_READ, PokemonJournalCynthiaScript
	bg_event  5,  1, BGEVENT_READ, PokemonJournalCynthiaScript

	def_object_events
	object_event  7,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GRAY, OBJECTTYPE_COMMAND, jumptextfaceplayer, Museum2FScientistText, -1
	object_event  1,  7, SPRITE_CHILD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Museum2FChildText, -1
	object_event  2,  7, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Museum2FTeacherText, -1
	object_event  2,  1, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Museum2FLassText, -1
	object_event 12,  5, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Museum2FPokefanMScript, -1

Museum2FPokefanMScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_SEISMIC_TOSS_INTRO
	iftruefwd Museum2FTutorSeismicTossScript
	checkunits
	iftruefwd .metric
	writetext Museum2FPokefanMImperialText
	sjumpfwd .ok
.metric
	writetext Museum2FPokefanMMetricText
.ok
	waitbutton
	setevent EVENT_LISTENED_TO_SEISMIC_TOSS_INTRO
Museum2FTutorSeismicTossScript:
	writetext Text_Museum2FTutorSeismicToss
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writetext Text_Museum2FTutorQuestion
	yesorno
	iffalsefwd .TutorRefused
	setval SEISMIC_TOSS
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpthisopenedtext

	text "Wie du meinst."
	done

.NoSilverLeaf
	jumpthisopenedtext

	text "Du hast kein"
	line "Silberblatt!"
	done

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext

	text "Jetzt beherrscht"
	line "dein #mon"
	cont "Geowurf!"
	done

Museum2FMoonStoneSignpostScript:
	reanchormap
	trainerpic METEORITE
	waitbutton
	closepokepic
	jumpthistext

	text "Meteorit, der auf"
	line "den Mondberg fiel."
	cont "(Mondstein)"
	done

Museum2FScientistText:
	text "Auf dem Mondberg"
	line "bei Marmoria City"
	cont "schlugen Meteori-"
	cont "ten ein."

	para "Einen davon"
	line "stellen wir aus."

	para "Er scheint eine"
	line "seltsame Energie"
	cont "auszustrahlen…"
	done


Museum2FLassText:
	text "Aus Fossilien wie-"
	line "derbelebte #mon"

	para "sind alle zum Teil"
	line "vom Typ Gestein."

	para "Waren sie schon"
	line "immer so, oder"

	para "liegt das am Ver-"
	line "steinerungs-"
	cont "prozess?"
	done

Museum2FPokefanMImperialText:
	text "Diese Raumfähre"
	line "flog einst 160"

	para "Meilen über der"
	line "Erde und trotzte"
	cont "der Schwerkraft!"

	para "Weißt du, was der"
	line "Schwerkraft noch"
	cont "trotzen kann?"

	para "Geowurf,"
	line "natürlich!"
	done

Museum2FChildText:
	text "Zeug und Steine"
	line "und Steine und"

	para "Zeug. Können wir"
	line "jetzt gehen?"
	done

Museum2FTeacherText:
	text "Seufz… Meinem Sohn"
	line "gefällt das Museum"

	para "nicht so gut, wie"
	line "ich gehofft hatte."

	para "Kinder, was?"
	done

Museum2FPokefanMMetricText:
	text "Diese Raumfähre"
	line "flog einst 250"

	para "Kilometer über der"
	line "Erde und trotzte"
	cont "der Schwerkraft!"

	para "Weißt du, was der"
	line "Schwerkraft noch"
	cont "trotzen kann?"

	para "Geowurf,"
	line "natürlich!"
	done

Text_Museum2FTutorSeismicToss:
	text "Für ein Silber-"
	line "blatt bringe ich"

	para "deinem #mon"
	line "Geowurf bei."
	done


Text_Museum2FTutorQuestion:
	text "Soll ich deinem"
	line "#mon Geowurf"
	cont "beibringen?"
	done




Museum2FSpaceShuttleSignpostText:
	text "Raumfähre"
	done

PokemonJournalStevenScript:
	setflag ENGINE_READ_STEVEN_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Steinsammler Troy!"

	para "Troy Trumm soll"
	line "der Devon Corpo-"
	cont "ration helfen,"

	para "die sein Vater"
	line "Mr. Trumm leitet,"

	para "indem er seltene"
	line "Mineralien und"
	cont "sogar Fossilien"
	cont "aufspürt."
	done

PokemonJournalCynthiaScript: ; TODO: move to Goldenrod Museum
	setflag ENGINE_READ_CYNTHIA_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Forscherin"
	cont "Cynthia!"

	para "Cynthia soll von"
	line "ihrer Großmutter"

	para "in Sinnoh viele"
	line "Legenden und"
	cont "Mythen gelernt"
	cont "haben."
	done
