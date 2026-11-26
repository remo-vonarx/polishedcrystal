RockyBeach_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 25, 20, ROCKY_BEACH_HOUSE, 1
	warp_event 29, 10, NOISY_FOREST, 1
	warp_event 29, 11, NOISY_FOREST, 2

	def_coord_events

	def_bg_events
	bg_event 22, 24, BGEVENT_JUMPTEXT, RockyBeachSign1Text
	bg_event 24, 10, BGEVENT_JUMPTEXT, RockyBeachSign2Text

	def_object_events
	object_event 21, 21, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSightseermBlaise, -1
	object_event 11, 22, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBeautyIoana, -1
	object_event  2, 21, SPRITE_LADY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSightseerfKamila, -1
	object_event 15, 18, SPRITE_AROMA_LADY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerAromaLadyHeather, -1
	object_event 15, 13, SPRITE_BREEDER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBreederBrenda, -1
	object_event 14,  7, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSwimmermEzra, -1
	object_event 23, 10, SPRITE_AROMA_LADY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 1, RockyBeachWilhomenaScript, EVENT_NOISY_FOREST_PIKABLU
	itemball_event 21,  5, FULL_HEAL, 1, EVENT_ROCKY_BEACH_FULL_HEAL
	itemball_event 32,  3, PEARL_STRING, 1, EVENT_ROCKY_BEACH_PEARL_STRING
	object_event 20, 32, SPRITE_FAT_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, (1 << DAY), PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiIslandFisherText, -1
	object_event 23, 32, SPRITE_FAT_GUY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, (1 << DAY), PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiIslandFisherText, -1

RockyBeachSign1Text:
	text "Felsiger Strand"
	done

RockyBeachSign2Text:
	text "Lauschiger Wald"
	line "voraus"

	para "Weiter zu den"
	line "Schreinruinen"
	done

GenericTrainerSightseermBlaise:
	generictrainer SIGHTSEERM, BLAISE, EVENT_BEAT_SIGHTSEERM_BLAISE, .SeenText, .BeatenText

	text "Je fais le tour"
	line "du monde avec mon"
	cont "#mon."
	done

.SeenText:
	text "Allons-y!"
	done

.BeatenText:
	text "Sacre bleu!"
	done

GenericTrainerBeautyIoana:
	generictrainer BEAUTY, IOANA, EVENT_BEAT_BEAUTY_IOANA, .SeenText, .BeatenText

	text "Ich habe von Natur"
	line "aus helle Haut,"

	para "also muss ich in"
	line "der Sonne vorsich-"
	cont "tig sein."
	done

.SeenText:
	text "Ich komme jedes"
	line "Jahr her, um an"
	cont "meiner Bräune zu"
	cont "arbeiten."
	done

.BeatenText:
	text "Da hab ich mir die"
	line "Finger verbrannt!"
	done

GenericTrainerSightseerfKamila:
	generictrainer SIGHTSEERF, KAMILA, EVENT_BEAT_SIGHTSEERF_KAMILA, .SeenText, .BeatenText

	text "Alola ist ein"
	line "Archipel weit weg"
	cont "von hier."

	para "Du solltest es"
	line "mal besuchen!"
	done

.SeenText:
	text "Alola!"

	para "So grüßen wir uns"
	line "in meiner Region."
	done

.BeatenText:
	text "Cheehoo! Du bist"
	line "ziemlich gut!"
	done

GenericTrainerAromaLadyHeather:
	generictrainer AROMA_LADY, HEATHER, EVENT_BEAT_AROMA_LADY_HEATHER, .SeenText, .BeatenText

	text "Ich habe bei Erika"
	line "an der Prismania-"
	cont "Uni Blumenstecken"
	cont "gelernt."

	para "Sie lobte diese"
	line "Insel für ihre"
	cont "heimische Fauna."
	done

.SeenText:
	text "Auf der ganzen"
	line "Insel wächst eine"
	cont "tiefrote Blume."

	para "Ist sie dir auf-"
	line "gefallen?"
	done

.BeatenText:
	text "Ein schöner Kampf,"
	line "aber was ist mit"
	cont "den Blumen?"
	done

GenericTrainerBreederBrenda:
	generictrainer BREEDER, BRENDA, EVENT_BEAT_BREEDER_BRENDA, .SeenText, .BeatenText

	text "Um ein Ei auszu-"
	line "brüten, musst du"
	cont "viel laufen."

	para "Wo ginge das bes-"
	line "ser als im sonni-"
	cont "gen Shamouti?"
	done

.SeenText:
	text "Das A und O guter"
	line "#mon-Zucht ist"

	para "eine gute"
	line "Umgebung."

	para "Und es gibt keinen"
	line "besseren Ort als"
	cont "diesen!"
	done

.BeatenText:
	text "Deine #mon sind"
	line "aus guter Zucht."
	done

GenericTrainerSwimmermEzra:
	generictrainer SWIMMERM, EZRA, EVENT_BEAT_SWIMMERM_EZRA, .SeenText, .BeatenText

	text "Ich gehe hier gern"
	line "tauchen."

	para "Es ist so toll,"
	line "unter Wasser zu"
	cont "atmen!"
	done

.SeenText:
	text "Hast du dich je"
	line "gefragt, wie es"

	para "wäre, unter Was-"
	line "ser zu atmen?"
	done

.BeatenText:
	text "Keine Luft mehr!"
	done

RockyBeachWilhomenaScript:
	generictrainer 0, 0, EVENT_TOLD_ABOUT_PIKABLU, .Text1, 0

.Text1
	text "Oh nein. Oh nein…"

	para "Mein armes Pikablu"
	line "ist verschwunden."

	para "Nein… Es kann doch"
	line "nicht in den"
	cont "Lauschigen Wald"
	cont "gelaufen sein."

	para "Zwischen den Bäu-"
	line "men finde ich es"
	cont "nie…"

	para "Oh, was soll ich"
	line "nur tun…?"
	done
