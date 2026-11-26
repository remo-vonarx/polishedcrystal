Route3_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route3FlyPoint

	def_warp_events
	warp_event 68,  5, MOUNT_MOON_1F, 1
	warp_event 59,  5, ROUTE_3_CABLE_CAR_GATE, 1

	def_coord_events

	def_bg_events
	bg_event 63, 19, BGEVENT_JUMPTEXT, Route3MtMoonSquareSignText
	bg_event 11, 21, BGEVENT_ITEM + MOON_STONE, EVENT_ROUTE_3_HIDDEN_MOON_STONE
	bg_event  8, 19, BGEVENT_JUMPTEXT, Route3MeteoriteText
	bg_event  8, 21, BGEVENT_JUMPTEXT, Route3MeteoriteText
	bg_event  9, 21, BGEVENT_JUMPTEXT, Route3MeteoriteText
	bg_event 12, 19, BGEVENT_JUMPTEXT, Route3MeteoriteText
	bg_event 14, 21, BGEVENT_JUMPTEXT, Route3MeteoriteText
	bg_event 15, 21, BGEVENT_JUMPTEXT, Route3MeteoriteText

	def_object_events
	object_event 12, 11, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerYoungsterRegis, -1
	object_event 17,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerYoungsterJimmy, -1
	object_event 25,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerYoungsterWarren, -1
	object_event 30, 16, SPRITE_FIREBREATHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerFirebreatherOtis, -1
	object_event 60, 14, SPRITE_FIREBREATHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerFirebreatherBurt, -1
	object_event 44, 12, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBlackbeltManford, -1
	object_event 52, 22, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBlackbeltAnder, -1
	object_event 38, 10, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerHikerBruce, -1
	object_event 61, 23, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerHikerDwight, -1
	object_event 14, 16, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoZacandjen1, -1
	object_event 15, 16, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoZacandjen2, -1
	itemball_event 36, 18, BIG_ROOT, 1, EVENT_ROUTE_3_BIG_ROOT

Route3FlyPoint:
	setflag ENGINE_FLYPOINT_MT_MOON
	endcallback

GenericTrainerYoungsterRegis:
	generictrainer YOUNGSTER, REGIS, EVENT_BEAT_YOUNGSTER_REGIS, .SeenText, .BeatenText

	text "Ich brauche wohl"
	line "mehr Training!"
	done

.SeenText:
	text "Teenager? Meine"
	line "Güte, wie unhöf-"
	cont "lich!"

	para "Nenn mich Kurze-"
	line "Hosen-Junge!"
	done

.BeatenText:
	text "Das ist…"
	line "Versager-Junge…"
	done

GenericTrainerYoungsterJimmy:
	generictrainer YOUNGSTER, JIMMY, EVENT_BEAT_YOUNGSTER_JIMMY, .SeenText, .BeatenText

	text "Ich trage das"
	line "ganze Jahr Shorts."

	para "Das ist meine"
	line "Auffassung von"
	cont "Mode."
	done

.SeenText:
	text "Ich bin schnell"
	line "wie der Wind!"
	done

.BeatenText:
	text "Hinfortgeweht!"
	done

GenericTrainerYoungsterWarren:
	generictrainer YOUNGSTER, WARREN, EVENT_BEAT_YOUNGSTER_WARREN, .SeenText, .BeatenText

	text "Du hast gleich"
	line "einen starken"
	cont "Eindruck gemacht."

	para "Ich hatte Angst,"
	line "gegen dich zu"
	cont "kämpfen…"
	done

.SeenText:
	text "Hmmm… Ich weiß"
	line "nicht, was ich"
	cont "tun soll…"
	done

.BeatenText:
	text "Ich wusste es…"
	done

GenericTrainerFirebreatherOtis:
	generictrainer FIREBREATHER, OTIS, EVENT_BEAT_FIREBREATHER_OTIS, .SeenText, .BeatenText

	text "Bei Regen ist"
	line "eine Zündung sehr"
	cont "schwierig…"
	done

.SeenText:
	text "Ah! Das Wetter"
	line "ist so schön"
	cont "wie immer."
	done

.BeatenText:
	text "Die Sonne scheint,"
	line "dennoch bin ich"
	cont "nass…"
	done

GenericTrainerFirebreatherBurt:
	generictrainer FIREBREATHER, BURT, EVENT_BEAT_FIREBREATHER_BURT, .SeenText, .BeatenText

	text "Ich bin der beste"
	line "Feuerspucker"
	cont "in Kanto."

	para "Aber nicht der"
	line "beste Trainer…"
	done

.SeenText:
	text "Komm schnell her"
	line "und schau!"
	done

.BeatenText:
	text "Wow! Das ist heiß!"
	done

GenericTrainerBlackbeltManford:
	generictrainer BLACKBELT_T, MANFORD, EVENT_BEAT_BLACKBELT_MANFORD, .SeenText, .BeatenText

	text "Du hast sicher bei"
	line "einem bekannten"
	cont "Meister trainiert!"
	done

.SeenText:
	text "Mach langsam und"
	line "gib mir die Chan-"
	cont "ce, dich zu be-"
	cont "siegen!"
	done

.BeatenText:
	text "Ich wurde mit"
	line "meinen eigenen"
	cont "Waffen geschlagen…"
	done

GenericTrainerBlackbeltAnder:
	generictrainer BLACKBELT_T, ANDER, EVENT_BEAT_BLACKBELT_ANDER, .SeenText, .BeatenText

	text "Du bist den weiten"
	line "Weg aus Johto"
	cont "gekommen?"

	para "Du musst sehr"
	line "hartnäckig sein!"
	done

.SeenText:
	text "Warte mal!"
	line "Kämpf gegen mich!"
	done

.BeatenText:
	text "Du hast es"
	line "geschafft…"
	done

GenericTrainerHikerBruce:
	generictrainer HIKER, BRUCE, EVENT_BEAT_HIKER_BRUCE, .SeenText, .BeatenText

	text "Na gut, dann trage"
	line "ich meinen Beutel"
	cont "wohl wieder!"
	done

.SeenText:
	text "Mein Beutel drückt"
	line "mir auf die"
	cont "Schultern!"

	para "Ich mache Pause"
	line "und kämpfe!"
	done

.BeatenText:
	text "Pah."
	done

GenericTrainerHikerDwight:
	generictrainer HIKER, DWIGHT, EVENT_BEAT_HIKER_DWIGHT, .SeenText, .BeatenText

	text "Jemanden zu grü-"
	line "ßen, den man nicht"
	cont "kennt…"

	para "Das ist das Beste"
	line "an den Bergen!"
	done

.SeenText:
	text "Frieden!"

	para "Wenn man auf einem"
	line "Bergpfad Fremden"
	cont "begegnet, will man"

	para "doch nur Frieden,"
	line "oder?"
	done

.BeatenText:
	text "Frieden, auch"
	line "wenn ich verloren"
	cont "habe!"
	done

GenericTrainerAceDuoZacandjen1:
	generictrainer ACE_DUO, ZACANDJEN1, EVENT_BEAT_ACE_DUO_ZAC_AND_JEN, .SeenText, .BeatenText

	text "Pom: Deine Zu-"
	line "kunft sieht viel-"
	cont "versprechend aus."
	done

.SeenText:
	text "Pom: Echt, du"
	line "willst gegen uns"
	cont "kämpfen?"

	para "Du hast viel Mut"
	line "für jemanden, der"
	cont "so jung ist."
	done

.BeatenText:
	text "Pom: Du hast"
	line "nicht geblufft…"
	done

GenericTrainerAceDuoZacandjen2:
	generictrainer ACE_DUO, ZACANDJEN2, EVENT_BEAT_ACE_DUO_ZAC_AND_JEN, .SeenText, .BeatenText

	text "Cora: Ich bin ge-"
	line "spannt, was für"

	para "ein Trainer aus"
	line "dir wird."
	done

.SeenText:
	text "Cora: Hä? Du"
	line "willst gegen uns"
	cont "antreten? Super!"
	done

.BeatenText:
	text "Cora: Du bist viel"
	line "stärker, als ich"
	cont "dachte."
	done

Route3MeteoriteText:
	text "So einen Stein ha-"
	line "be ich noch nie"
	cont "gesehen!"

	para "Ist das etwa…"
	line "ein Meteorit aus"
	cont "dem All?"
	done

Route3MtMoonSquareSignText:
	text "Mondberg-Tunnel"
	done
