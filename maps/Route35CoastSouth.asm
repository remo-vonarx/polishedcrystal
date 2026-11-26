Route35CoastSouth_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event 35, 14, BGEVENT_ITEM + STAR_PIECE, EVENT_ROUTE_35_COAST_SOUTH_HIDDEN_STAR_PIECE

	def_object_events
	object_event 26,  7, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerSwimmermWalter, -1
	object_event 24, 23, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfLisa, -1
	object_event 13, 18, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfJill, -1
	object_event 37,  8, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBird_keeperBryan, -1
	object_event 40, 13, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSrandjrBeaandmay1, -1
	object_event 40, 14, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSrandjrBeaandmay2, -1
	object_event 16, 10, SPRITE_SAILOR, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSailorHarvey, -1
	object_event 33,  6, SPRITE_FLOATING_BALL, SPRITEMOVEDATA_POKEMON, 0, 0, -1, 0, OBJECTTYPE_ITEMBALL, PLAYEREVENT_ITEMBALL, BIG_PEARL, 1, EVENT_ROUTE_35_COAST_SOUTH_BIG_PEARL
	object_event  6, 15, SPRITE_FLOATING_BALL, SPRITEMOVEDATA_POKEMON, 0, 0, -1, PAL_NPC_ENV_GREEN, OBJECTTYPE_ITEMBALL, PLAYEREVENT_KEYITEMBALL, GO_GOGGLES, EVENT_OLIVINE_PORT_GO_GOGGLES
	itemball_event 13, 31, STAR_PIECE, 1, EVENT_GOLDENROD_HARBOR_STAR_PIECE
	object_event 17, 31, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

GenericTrainerSwimmermWalter:
	generictrainer SWIMMERM, WALTER, EVENT_BEAT_SWIMMERM_WALTER, SwimmermWalterSeenText, SwimmermWalterBeatenText

	text "Die Sonne spiegelt"
	line "sich im Wasser,"

	para "und ich habe mich"
	line "trotzdem ver-"
	cont "brannt!"
	done

GenericTrainerSwimmerfLisa:
	generictrainer SWIMMERF, LISA, EVENT_BEAT_SWIMMERF_LISA, SwimmerfLisaSeenText, SwimmerfLisaBeatenText

	text "Im Meer ist genug"
	line "Platz"

	para "zum Angeln und"
	line "zum Kämpfen."
	done

GenericTrainerSwimmerfJill:
	generictrainer SWIMMERF, JILL, EVENT_BEAT_SWIMMERF_JILL, SwimmerfJillSeenText, SwimmerfJillBeatenText

	text "Meine Niederlage"
	line "vergesse ich beim"
	cont "Schwimmen."
	done

GenericTrainerBird_keeperBryan:
	generictrainer BIRD_KEEPER, BRYAN, EVENT_BEAT_BIRD_KEEPER_BRYAN, Bird_keeperBryanSeenText, Bird_keeperBryanBeatenText

	text "Manche #mon"
	line "rennen sofort weg."

	para "Versuche, sie mit"
	line "Kurts Turboball"
	cont "einzufangen. "

	para "Sobald ich eine"
	line "Aprikoko Wss"
	cont "finde, bringe ich"
	cont "sie zu Kurt."

	para "Er macht dann"
	line "daraus einen maß-"
	cont "gefertigten"
	cont "#ball."
	done

GenericTrainerSrandjrBeaandmay1:
	generictrainer SR_AND_JR, BEAANDMAY1, EVENT_BEAT_SR_AND_JR_BEA_AND_MAY, SrandjrBeaandmay1SeenText, SrandjrBeaandmay1BeatenText

	text "Bea: Ich bringe"
	line "May bei, wie sie"
	cont "stärker wird."
	done

GenericTrainerSrandjrBeaandmay2:
	generictrainer SR_AND_JR, BEAANDMAY2, EVENT_BEAT_SR_AND_JR_BEA_AND_MAY, SrandjrBeaandmay2SeenText, SrandjrBeaandmay2BeatenText

	text "May: Ich frage"
	line "Bea, wie ich"
	cont "stärker werde."
	done

GenericTrainerSailorHarvey:
	generictrainer SAILOR, HARVEY, EVENT_BEAT_SAILOR_HARVEY, SailorHarveySeenText, SailorHarveyBeatenText

	text "Der Einzige, auf"
	line "den du dich auf"

	para "hoher See verlas-"
	line "sen kannst, bist"
	cont "du selbst!"

	para "Ich bin so stolz"
	line "auf mich selbst!"
	done

SwimmermWalterSeenText:
	text "Ich habe die"
	line "Sonnencreme"
	cont "vergessen,"

	para "also verstecke ich"
	line "mich bei diesen"
	cont "schattigen Felsen."
	done

SwimmermWalterBeatenText:
	text "Autsch!"
	done

SwimmerfLisaSeenText:
	text "Die Angler schrien"
	line "mich an, weil ich"
	cont "sie belauschte…"
	done

SwimmerfLisaBeatenText:
	text "Ich wollte doch"
	line "nur kämpfen…"
	done

SwimmerfJillSeenText:
	text "Sehe ich in die-"
	line "sem Bikini nicht"
	cont "gut aus?"
	done

SwimmerfJillBeatenText:
	text "Hmpf!"
	done

Bird_keeperBryanSeenText:
	text "Welche Art von"
	line "#ball"
	cont "benutzt du?"
	done

Bird_keeperBryanBeatenText:
	text "Mist! Nicht"
	line "schnell genug!"
	done

SrandjrBeaandmay1SeenText:
	text "Bea: Ich mag star-"
	line "ke #mon lieber"

	para "als niedliche."

	para "Aber zusammen"
	line "haben wir nied-"
	cont "liche und starke"
	cont "#mon!"
	done

SrandjrBeaandmay1BeatenText:
	text "Bea: Stärke und"
	line "Niedlichkeit"
	cont "haben nicht"
	cont "gereicht!"
	done

SrandjrBeaandmay2SeenText:
	text "May: Ich mag nied-"
	line "liche #mon"

	para "lieber als starke."

	para "Aber zusammen"
	line "haben wir starke"
	cont "und niedliche"
	cont "#mon!"
	done

SrandjrBeaandmay2BeatenText:
	text "May: Niedlichkeit"
	line "und Stärke haben"
	cont "nicht gereicht!"
	done

SailorHarveySeenText:
	text "Hah! Deine #mon"
	line "sehen aus wie"
	cont "Leichtgewichte!"
	done

SailorHarveyBeatenText:
	text "Du hast Power!"
	line "Möchtest du"

	para "mit mir die Meere"
	line "unsicher machen?"
	done
