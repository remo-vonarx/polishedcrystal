ShamoutiCoast_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 22, 15, FIRE_ISLAND, 1
	warp_event 54, 11, ICE_ISLAND, 1
	warp_event 84, 13, LIGHTNING_ISLAND, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  9, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerArtistRin, -1
	object_event 12,  5, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, PAL_NPC_DARK_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfMarina, -1
	object_event 34,  9, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherDallas, -1
	object_event 39, 13, SPRITE_LADY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSightseerfPilar, -1
	object_event 66,  4, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSightseersCyandvi1, -1
	object_event 67,  4, SPRITE_LADY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSightseersCyandvi2, -1
	object_event 71, 16, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, PAL_NPC_DARK_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermAshe, -1
	object_event  6, -3, SPRITE_LADY, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
	itemball_event  6, 11, STAR_PIECE, 1, EVENT_SHAMOUTI_COAST_STAR_PIECE

GenericTrainerArtistRin:
	generictrainer ARTIST, RIN, EVENT_BEAT_ARTIST_RIN, .SeenText, .BeatenText

	text "Von den Inseln"
	line "geht eine seltsame"
	cont "Kraft aus."

	para "Die will ich in"
	line "meinem Bild"
	cont "einfangen."
	done

.SeenText:
	text "Ich male die drei"
	line "Inseln!"

	para "Bitte versperr"
	line "mir nicht die"
	cont "Sicht!"
	done

.BeatenText:
	text "Ich kann nicht"
	line "gleichzeitig malen"
	cont "und kämpfen."
	done

TrainerSwimmerfMarina:
	trainer SWIMMERF, MARINA, EVENT_BEAT_SWIMMERF_MARINA, .SeenText, .BeatenText, 0, .Script, TRAINERPAL_DARK_SWIMMERF

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Wenn ich auf einer"
	line "einsamen Insel"
	cont "stranden würde,"
	cont "würde ich…"

	para "natürlich meine"
	line "#mon mitnehmen!"
	done

.SeenText:
	text "Wenn du auf einer"
	line "einsamen Insel"
	cont "stranden würdest,"

	para "welche drei Dinge"
	line "würdest du"
	cont "mitnehmen?"
	done

.BeatenText:
	text "Abgetrieben und"
	line "aufgeschmissen!"
	done

GenericTrainerFisherDallas:
	generictrainer FISHER, DALLAS, EVENT_BEAT_FISHER_DALLAS, .SeenText, .BeatenText

	text "Egal, wo ich"
	line "angle, ich ziehe"

	para "immer nur Kron-"
	line "korken raus."

	para "Das macht mich"
	line "wahnsinnig!"
	done

.SeenText:
	text "Gah! Nicht noch"
	line "einer!"
	done

.BeatenText:
	text "Hä? Oh, nicht du,"
	line "mit dir ist alles"
	cont "gut."
	done

GenericTrainerSightseerfPilar:
	generictrainer SIGHTSEERF, PILAR, EVENT_BEAT_SIGHTSEERF_PILAR, .SeenText, .BeatenText

	text "Qué fuertes son"
	line "tus #mon!"

	para "Debes de haber"
	line "viajado un monton"

	para "para tener tanta"
	line "experiencia."
	done

.SeenText:
	text "Hola! He venido"
	line "hasta aca desde"
	cont "muy lejos."

	para "Qué tal si"
	line "combatimos?"
	done

.BeatenText:
	text "Pensé que duraria"
	line "mas…"
	done

GenericTrainerSightseersCyandvi1:
	generictrainer SIGHTSEERS, CYANDVI1, EVENT_BEAT_SIGHTSEERS_CY_AND_VI, .SeenText, .BeatenText

; text > text
	text "Cy: TODO"
	done

.SeenText: ; text > text
	text "Cy: TODO"
	done

.BeatenText: ; text > text
	text "Cy: TODO"
	done

GenericTrainerSightseersCyandvi2:
	generictrainer SIGHTSEERS, CYANDVI2, EVENT_BEAT_SIGHTSEERS_CY_AND_VI, .SeenText, .BeatenText

; text > text
	text "Vi: TODO"
	done

.SeenText: ; text > text
	text "Vi: TODO"
	done

.BeatenText: ; text > text
	text "Vi: TODO"
	done

TrainerSwimmermAshe:
	trainer SWIMMERM, ASHE, EVENT_BEAT_SWIMMERM_ASHE, .SeenText, .BeatenText, 0, .Script, TRAINERPAL_DARK_SWIMMERM

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Vor einer Weile"
	line "konnte ich gar"
	cont "nicht schwimmen."

	para "Jetzt mache ich es"
	line "so oft, dass ich"

	para "kaum noch weiß,"
	line "was ich vorher"
	cont "gemacht habe."
	cont "Haha!"
	done

.SeenText:
	text "Schwimmen? Ich?"
	line "Ja, steh ich"
	cont "drauf."
	done

.BeatenText:
	text "Ich glaub, ich"
	line "geh unter…"
	done
