Route21_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event 14, 37, BGEVENT_ITEM + STARDUST, EVENT_ROUTE_21_HIDDEN_STARDUST_1
	bg_event  5, 66, BGEVENT_ITEM + STARDUST, EVENT_ROUTE_21_HIDDEN_STARDUST_2

	def_object_events
	object_event  8, 13, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfNikki, -1
	object_event  3, 29, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmerfChelan, -1
	object_event  5, 46, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfKendra, -1
	object_event 16, 72, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerSwimmermEsteban, -1
	object_event 15, 85, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmermDuane, -1
	object_event  2, 89, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmermSeth, -1
	object_event  5, 21, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherMurphy, -1
	object_event 16, 25, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherArnold, -1
	object_event  8, 36, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherLiam, -1
	object_event  4, 55, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherGideon, -1
	object_event 15, 62, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBird_keeperKinsley, -1
	object_event  7, 83, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBird_keeperEaston, -1
	itemball_event 13, 26, STAR_PIECE, 1, EVENT_ROUTE_21_STAR_PIECE
	fruittree_event 12,  3, FRUITTREE_ROUTE_21, ENIGMA_BERRY, PAL_NPC_BLACK

GenericTrainerSwimmerfNikki:
	generictrainer SWIMMERF, NIKKI, EVENT_BEAT_SWIMMERF_NIKKI, SwimmerfNikkiSeenText, SwimmerfNikkiBeatenText

	text "Ich muss mich"
	line "vor Hautreizungen"
	cont "in Acht nehmen."
	done

SwimmerfNikkiSeenText:
	text "Falls ich gewinne,"
	line "musst du mich mit"
	cont "der Sonnencreme"
	cont "einreiben!"
	done

SwimmerfNikkiBeatenText:
	text "Ich habe Angst vor"
	line "einem Sonnenbrand…"
	done

GenericTrainerSwimmerfChelan:
	generictrainer SWIMMERF, CHELAN, EVENT_BEAT_SWIMMERF_CHELAN, .SeenText, .BeatenText

	text "Bei einem elek-"
	line "trischen Bikini"
	cont "kriegt man wohl"
	cont "einen Schlag!"
	done

.SeenText:
	text "Ich liebe Bikinis!"

	para "Mit einem elek-"
	line "trischen Bikini"

	para "könnte ich ihn"
	line "sogar im Winter"
	cont "tragen!"
	done

.BeatenText:
	text "Ooch…"
	done

GenericTrainerSwimmerfKendra:
	generictrainer SWIMMERF, KENDRA, EVENT_BEAT_SWIMMERF_KENDRA, .SeenText, .BeatenText

	text "Ob es irgendwo"
	line "Badeanzüge für"
	cont "#mon gibt?"
	done

.SeenText:
	text "Hey, Trainer!"
	line "Wie wäre es, wenn"
	cont "du auch Bade-"
	cont "sachen anziehst?"
	done

.BeatenText:
	text "Ich wollte nicht"
	line "verlieren…"
	done

GenericTrainerSwimmermEsteban:
	generictrainer SWIMMERM, ESTEBAN, EVENT_BEAT_SWIMMERM_ESTEBAN, .SeenText, .BeatenText

	text "Wir nannten unse-"
	line "ren Lehrer Profes-"
	cont "sor Quaputzi!"
	done

.SeenText:
	text "Mein Schwimm-"
	line "lehrer hatte ein"
	cont "Gesicht wie ein"
	cont "Quaputzi."
	done

.BeatenText:
	text "Tut mir leid,"
	line "Herr Lehrer…"
	done

GenericTrainerSwimmermDuane:
	generictrainer SWIMMERM, DUANE, EVENT_BEAT_SWIMMERM_DUANE, .SeenText, .BeatenText

	text "Um öfter zu ge-"
	line "winnen, muss ich"
	cont "an meiner Ausdauer"
	cont "arbeiten!"
	done

.SeenText:
	text "Schwimmen trai-"
	line "niert den ganzen"
	cont "Körper."

	para "Das macht richtig"
	line "stark!"
	done

.BeatenText:
	text "Meine #mon und"
	line "ich haben keine"
	cont "Kraft mehr…"
	done

GenericTrainerSwimmermSeth:
	generictrainer SWIMMERM, SETH, EVENT_BEAT_SWIMMERM_SETH, SwimmermSethSeenText, SwimmermSethBeatenText

	text "Dieser arrogante"
	line "Typ war beim"
	cont "Vulkan auf der"
	cont "Zinnoberinsel."
	done

SwimmermSethSeenText:
	text "Mach weiter so!"
	done

SwimmermSethBeatenText:
	text "Gluck…"
	done

GenericTrainerFisherMurphy:
	generictrainer FISHER, MURPHY, EVENT_BEAT_FISHER_MURPHY, .SeenText, .BeatenText

	text "Das #mon, das"
	line "mir entwischt ist,"
	cont "war riesig."

	para "Das ist die"
	line "Wahrheit!"
	done

.SeenText:
	text "Hä? Ich habe einen"
	line "Trainer statt"
	cont "eines #mon"
	cont "gefangen!"
	done

.BeatenText:
	text "Meine Angelschnur"
	line "ist gerissen!"
	done

GenericTrainerFisherArnold:
	generictrainer FISHER, ARNOLD, EVENT_BEAT_FISHER_ARNOLD, FisherArnoldSeenText, FisherArnoldBeatenText

	text "Ich gehe zurück"
	line "zum Angeln…"
	done

FisherArnoldSeenText:
	text "Angeln langweilt"
	line "mich. Lass uns"
	cont "kämpfen!"
	done

FisherArnoldBeatenText:
	text "Total versagt…"
	done

GenericTrainerFisherLiam:
	generictrainer FISHER, LIAM, EVENT_BEAT_FISHER_LIAM, .SeenText, .BeatenText

	text "Ich hätte dich"
	line "bitten sollen zu"

	para "warten, bis ich"
	line "das #mon"
	cont "an Land gezogen"
	cont "habe…"
	done

.SeenText:
	text "Wow! Es beißt!"

	para "…Hä?"
	line "Ein Kampf?"

	para "OK, los geht's!"
	done

.BeatenText:
	text "Wer zwei #mon"
	line "jagt, fängt"

	para "keines von"
	line "beiden!"
	done

GenericTrainerFisherGideon:
	generictrainer FISHER, GIDEON, EVENT_BEAT_FISHER_GIDEON, .SeenText, .BeatenText

	text "Warum bist du"
	line "#mon-Trainer"
	cont "geworden?"
	done

.SeenText:
	text "Wurde ich Angler,"
	line "weil ich geduldig"
	cont "bin, oder"

	para "wurde ich gedul-"
	line "diger, weil ich"
	cont "Angler bin?"
	done

.BeatenText:
	text "Ähm… Hmmm…"
	done

GenericTrainerBird_keeperKinsley:
	generictrainer BIRD_KEEPER, KINSLEY, EVENT_BEAT_BIRD_KEEPER_KINSLEY, .SeenText, .BeatenText

	text "Ich muss nur mehr"
	line "üben, mit den"
	cont "Flügeln zu"
	cont "schlagen!"
	done

.SeenText:
	text "Eines Tages kann"
	line "ich vielleicht"
	cont "fliegen wie meine"
	cont "Vogel-#mon!"
	done

.BeatenText:
	text "Ich konnte nicht"
	line "fliegen…"
	done

GenericTrainerBird_keeperEaston:
	generictrainer BIRD_KEEPER, EASTON, EVENT_BEAT_BIRD_KEEPER_EASTON, .SeenText, .BeatenText

	text "Wir denken, wir"
	line "setzen die #mon"
	cont "ein."

	para "Aber irgendwann"
	line "setzen die #mon"
	cont "uns ein…"
	done

.SeenText:
	text "Vogel-Profis gehen"
	line "so wunderbar mit"
	cont "ihren Vogel-"
	cont "#mon um!"
	done

.BeatenText:
	text "Das war zu viel"
	line "für mich…"
	done
