Route11_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 45,  8, ROUTE_11_GATE, 1
	warp_event 45,  9, ROUTE_11_GATE, 2

	def_coord_events

	def_bg_events
	bg_event  5,  7, BGEVENT_JUMPTEXT, Route11SignText
	bg_event 44,  5, BGEVENT_ITEM + REVIVE, EVENT_ROUTE_11_HIDDEN_REVIVE

	def_object_events
	object_event 32, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerYoungsterOwen, -1
	object_event 30,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerYoungsterJason, -1
	object_event 21,  2, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerYoungsterAlfie, -1
	object_event 40,  7, SPRITE_PSYCHIC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerPsychicHerman, -1
	object_event 12,  6, SPRITE_PSYCHIC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPsychicFidel, -1
	object_event 24, 14, SPRITE_PSYCHIC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPsychicUri, -1
	object_event 38,  1, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerEngineerBernie, -1
	object_event 38, 14, SPRITE_ENGINEER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerEngineerCamden, -1
	object_event  9,  3, SPRITE_ROCKER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGuitaristmRoger, -1
	object_event 10, 16, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerGuitaristfRitsuko, -1
	fruittree_event 44,  2, FRUITTREE_ROUTE_11, GANLON_BERRY, PAL_NPC_PURPLE
	tmhmball_event 44, 13, TM_VENOSHOCK, EVENT_ROUTE_11_TM_VENOSHOCK

GenericTrainerYoungsterOwen:
	generictrainer YOUNGSTER, OWEN, EVENT_BEAT_YOUNGSTER_OWEN, YoungsterOwenSeenText, YoungsterOwenBeatenText

	text "Ich habe immer"
	line "fair und ehrenhaft"
	cont "gekämpft."

	para "Ich habe es noch"
	line "nie bedauert."
	done

YoungsterOwenSeenText:
	text "Bei #mon wird"
	line "nicht gemogelt."

	para "Immer fair"
	line "spielen."
	done

YoungsterOwenBeatenText:
	text "Huch? Wie konnte"
	line "das passieren?"
	done

GenericTrainerYoungsterJason:
	generictrainer YOUNGSTER, JASON, EVENT_BEAT_YOUNGSTER_JASON, YoungsterJasonSeenText, YoungsterJasonBeatenText

	text "Im Gras werde ich"
	line "mehr #mon"
	cont "fangen."
	done

YoungsterJasonSeenText:
	text "Es juckt und"
	line "sticht, wenn ich"

	para "mit meinen Shorts"
	line "durchs Gras laufe."
	done

YoungsterJasonBeatenText:
	text "Aiyaaah!"
	line "Ich bekam Dresche!"
	done

GenericTrainerYoungsterAlfie:
	generictrainer YOUNGSTER, ALFIE, EVENT_BEAT_YOUNGSTER_ALFIE, .SeenText, .BeatenText

	text "Alles macht mehr"
	line "Spaß, wenn es ein"
	cont "Wettkampf ist."
	done

.SeenText:
	text "Drei, zwei, eins,"
	line "LOS!"
	done

.BeatenText:
	text "Spiel, Satz und"
	line "Sieg."
	done

GenericTrainerPsychicHerman:
	generictrainer PSYCHIC_T, HERMAN, EVENT_BEAT_PSYCHIC_HERMAN, PsychicHermanSeenText, PsychicHermanBeatenText

	text "…"

	para "Ich verlor, als"
	line "ich meine Augen"
	cont "schloss…"
	done

PsychicHermanSeenText: ; text > text
PsychicHermanBeatenText:
	text "…"
	done

GenericTrainerPsychicFidel:
	generictrainer PSYCHIC_T, FIDEL, EVENT_BEAT_PSYCHIC_FIDEL, PsychicFidelSeenText, PsychicFidelBeatenText

	text "Deine Überzeugung"
	line "ist stark…"

	para "Du bist stark,"
	line "weil du an deine"
	cont "#mon glaubst."
	done

PsychicFidelSeenText:
	text "Ich kann es sehen…"

	para "Ich kann alles"
	line "über dich sehen…"
	done

PsychicFidelBeatenText:
	text "Deine Stärke"
	line "konnte ich nicht"
	cont "sehen…"
	done

GenericTrainerPsychicUri:
	generictrainer PSYCHIC_T, URI, EVENT_BEAT_PSYCHIC_URI, .SeenText, .BeatenText

	text "Warum gibt mir"
	line "Prof. Eich wohl"
	cont "keinen #dex?"
	done

.SeenText:
	text "Als ein Junge mit"
	line "übersinnlichen"

	para "Kräften eines Mor-"
	line "gens erwachte,"

	para "fand er sich in"
	line "seinem Bett zu"
	cont "einem Kadabra"
	cont "verwandelt!"
	done

.BeatenText:
	text "Urbane Legende?"
	line "Was ist das?"
	done

GenericTrainerEngineerBernie:
	generictrainer ENGINEER, BERNIE, EVENT_BEAT_ENGINEER_BERNIE, .SeenText, .BeatenText

	text "Sag allen, sie"
	line "sollen Energie"
	cont "sparen!"
	done

.SeenText:
	text "Vorsicht!"
	line "Ich verlege hier"
	cont "Kabel!"
	done

.BeatenText:
	text "Das war"
	line "elektrisierend!"
	done

GenericTrainerEngineerCamden:
	generictrainer ENGINEER, CAMDEN, EVENT_BEAT_ENGINEER_CAMDEN, .SeenText, .BeatenText

	text "Eine Brücke bauen"
	line "und ein Team aus"
	cont "#mon aufbauen:"

	para "Beides erfordert"
	line "Wissen und Können."
	done

.SeenText:
	text "Ich habe an der"
	line "Prismania-Uni"
	cont "Ingenieurwesen"
	cont "studiert!"
	done

.BeatenText:
	text "Abgeschaltet!"
	done

GenericTrainerGuitaristmRoger:
	generictrainer GUITARISTM, ROGER, EVENT_BEAT_GUITARISTM_ROGER, .SeenText, .BeatenText

	text "Don't give in"
	line "without a fight!"
	done

.SeenText:
	text "Strangers passing"
	line "in the street,"

	para "by chance two"
	line "separate glances"
	cont "meet!"
	done

.BeatenText:
	text "Shine on, you"
	line "crazy diamond!"
	done

GenericTrainerGuitaristfRitsuko:
	generictrainer GUITARISTF, RITSUKO, EVENT_BEAT_GUITARISTF_RITSUKO, .SeenText, .BeatenText

	text "♪ Rock'n, rock'n'"
	line "roll radio… ♪"
	done

.SeenText:
	text "Hey ho, let's go!"
	done

.BeatenText:
	text "There's no success"
	line "for me…"
	done

Route11SignText:
	text "Route 11"
	done
