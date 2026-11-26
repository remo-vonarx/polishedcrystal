Route14_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event 15, 12, BGEVENT_JUMPTEXT, Route14SignText

	def_object_events
	object_event 13,  8, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerPokefanmTrevor, -1
	object_event 11, 22, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPokefanmCarter, -1
	object_event 11, 29, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperRoy, -1
	object_event 15, 15, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBird_keeperJosh, -1
	object_event  4, 19, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSchoolboyConnor, -1
	object_event  4, 17, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSchoolboyTorin, -1
	object_event  4, 15, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSchoolboyTravis, -1
	object_event  9, 17, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerTeacherClarice, -1
	object_event  7,  7, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, trade, NPC_TRADE_KIM, -1
	cuttree_event  4,  9, EVENT_ROUTE_14_CUT_TREE_1
	cuttree_event 10, 18, EVENT_ROUTE_14_CUT_TREE_2
	cuttree_event  3, 25, EVENT_ROUTE_14_CUT_TREE_3
	fruittree_event  5, 12, FRUITTREE_ROUTE_14, CUSTAP_BERRY, PAL_NPC_RED

GenericTrainerPokefanmTrevor:
	generictrainer POKEFANM, TREVOR, EVENT_BEAT_POKEFANM_TREVOR, PokefanmTrevorSeenText, PokefanmTrevorBeatenText

	text "Gäbe es doch einen"
	line "einfachen Weg, um"

	para "festzustellen, wo"
	line "ich meine"
	cont "#mon traf…"

	para "Oh! Ich sehe mir"
	line "einfach ihre"
	cont "Werte an!"
	done

PokefanmTrevorSeenText:
	text "Hi. Wusstest du…,"

	para "dass #mon dich"
	line "mehr mögen, wenn"

	para "du sie an einem"
	line "ihnen bekannten"
	cont "Platz trainierst?"
	done

PokefanmTrevorBeatenText:
	text "Wo traf ich dieses"
	line "Enton?"
	done

GenericTrainerPokefanmCarter:
	generictrainer POKEFANM, CARTER, EVENT_BEAT_POKEFANM_CARTER, PokefanmCarterSeenText, PokefanmCarterBeatenText

	text "Schiggy, Glumanda"
	line "und Bisasam…"

	para "Ich denke, das ist"
	line "ein ausgeglichenes"
	cont "Team."
	done

PokefanmCarterSeenText:
	text "Eines kann ich dir"
	line "sagen! Es war"

	para "harte Arbeit, mei-"
	line "ne prämierten"
	cont "#mon zu fangen."
	done

PokefanmCarterBeatenText:
	text "Uaaaah!"
	done

GenericTrainerBird_keeperRoy:
	generictrainer BIRD_KEEPER, ROY, EVENT_BEAT_BIRD_KEEPER_ROY, Bird_keeperRoySeenText, Bird_keeperRoyBeatenText

	text "Du hast #mon,"
	line "welche die VM"

	para "Fliegen kennen?"
	line "Ich beneide dich."
	done

Bird_keeperRoySeenText:
	text "Ich träume davon,"
	line "mit meinen ge-"
	cont "liebten Vogel-"
	cont "#mon zu"
	cont "fliegen."
	done

Bird_keeperRoyBeatenText:
	text "Ich kann träumen,"
	line "aber ich kann"
	cont "nicht fliegen…"
	done

GenericTrainerBird_keeperJosh:
	generictrainer BIRD_KEEPER, BIRD_KEEPER_JOSH, EVENT_BEAT_BIRD_KEEPER_JOSH, .SeenText, .BeatenText

	text "Vielleicht sollte"
	line "ich lügen und sa-"
	cont "gen, ich bin ein"
	cont "Schwergewicht…"
	done

.SeenText:
	text "Mit meinem Gewicht"
	line "bin ich ein"
	cont "Federgewicht!"

	para "…Hä? Wie, das"
	line "klingt nicht"
	cont "besonders stark?"
	done

.BeatenText:
	text "Ich habe so leicht"
	line "verloren, wie eine"
	cont "Feder schwebt!"
	done

GenericTrainerSchoolboyConnor:
	generictrainer SCHOOLBOY, SCHOOLBOY_CONNOR, EVENT_BEAT_SCHOOLBOY_CONNOR, .SeenText, .BeatenText

	text "Nichts überstürzen"
	line "und Schritt für"
	cont "Schritt gehen."

	para "Toller Rat!"
	done

.SeenText:
	text "Ich kann es kaum"
	line "erwarten, heimzu-"
	cont "gehen und meinen"
	cont "Beutel abzulegen!"
	done

.BeatenText:
	text "Ich hatte es zu"
	line "eilig."
	done

GenericTrainerSchoolboyTorin:
	generictrainer SCHOOLBOY, TORIN, EVENT_BEAT_SCHOOLBOY_TORIN, .SeenText, .BeatenText

	text "Na gut! Nächstes"
	line "Mal mache ich"
	cont "keine Fehler!"
	done

.SeenText:
	text "Es ist gut, das"
	line "Gelernte sofort"
	cont "anzuwenden!"
	done

.BeatenText:
	text "Verstehe."
	line "Verstehe."
	done

GenericTrainerSchoolboyTravis:
	generictrainer SCHOOLBOY, TRAVIS, EVENT_BEAT_SCHOOLBOY_TRAVIS, .SeenText, .BeatenText

	text "Vielleicht sollte"
	line "ich zu deinen"
	cont "Lerngruppen"
	cont "kommen!"
	done

.SeenText:
	text "Hast du nach der"
	line "Schule Lern-"
	cont "gruppen?"
	done

.BeatenText:
	text "So stark…"
	done

GenericTrainerTeacherClarice:
	generictrainer TEACHER_F, CLARICE, EVENT_BEAT_TEACHER_CLARICE, .SeenText, .BeatenText

	text "Ruh dich nicht"
	line "aus, nur weil du"
	cont "gewonnen hast."

	para "Zu Hause solltest"
	line "du alles gründlich"
	cont "wiederholen!"
	done

.SeenText:
	text "Also gut, starten"
	line "wir diesen"
	cont "#mon-Kampf!"
	done

.BeatenText:
	text "Also gut! Damit"
	line "endet der heutige"
	cont "Kampf."
	done

Route14SignText:
	text "Route 14"

	para "Fuchsania City -"
	line "Lavandia"
	done
