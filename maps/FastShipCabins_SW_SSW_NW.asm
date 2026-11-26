FastShipCabins_SW_SSW_NW_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  0, FAST_SHIP_1F, 5
	warp_event  2, 19, FAST_SHIP_1F, 6
	warp_event  3, 19, FAST_SHIP_1F, 6
	warp_event  2, 31, FAST_SHIP_1F, 7
	warp_event  3, 31, FAST_SHIP_1F, 7

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_READ, FastShipBed
	bg_event  7,  2, BGEVENT_READ, FastShipBed

	def_object_events
	object_event  1, 15, SPRITE_FIREBREATHER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerFirebreatherLyle, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  6, 15, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBug_catcherKen, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event  5, 27, SPRITE_RICH_BOY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerRichBoyWinston, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  1, 26, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBeautyCassie, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event  3, 28, SPRITE_ROCKER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerGuitaristmClyde, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND

GenericTrainerFirebreatherLyle:
	generictrainer FIREBREATHER, LYLE, EVENT_BEAT_FIREBREATHER_LYLE, FirebreatherLyleSeenText, FirebreatherLyleBeatenText

	text "Ich denke, Feuer"
	line "ist schwach auf"
	cont "hoher See."

	para "Das ist egal?"
	line "Wirklich?"
	done

GenericTrainerBug_catcherKen:
	generictrainer BUG_CATCHER, KEN, EVENT_BEAT_BUG_CATCHER_KEN, Bug_catcherKenSeenText, Bug_catcherKenBeatenText

	text "In Johto findest"
	line "du viele #mon"
	cont "in den Bäumen!"
	done

GenericTrainerRichBoyWinston:
	generictrainer RICH_BOY, WINSTON, EVENT_BEAT_RICH_BOY_WINSTON, RichBoyWinstonSeenText, RichBoyWinstonBeatenText

	text "Dieses Schiff ist"
	line "so trist."
	done

GenericTrainerBeautyCassie:
	generictrainer BEAUTY, CASSIE, EVENT_BEAT_BEAUTY_CASSIE, BeautyCassieSeenText, BeautyCassieBeatenText

	text "Eine Schiffsreise"
	line "ist am besten,"
	cont "um ein gebrochenes"
	cont "Herz zu vergessen."

	para "Aber eine Reise"
	line "mit dem Schnell-"
	cont "boot ist für"
	cont "die Trauer zu"
	cont "kurz."
	done

TrainerGuitaristmClyde:
	trainer GUITARISTM, CLYDE, EVENT_BEAT_GUITARISTM_CLYDE, GuitaristmClydeSeenText, GuitaristmClydeBeatenText, 0, GuitaristmClydeScript

GuitaristmClydeScript:
	endifjustbattled
	opentext
	checkbp 0
	iffalsefwd .BattleTower
	jumpthisopenedtext

	text "Apropos Radio-"
	line "station: Wie "

	para "lauten die"
	line "Glückszahlen für"
	cont "diese Woche?"
	done

.BattleTower:
	jumpthisopenedtext

	text "Ich wollte mein"
	line "Debut im Duellturm"
	cont "geben…"

	para "Ich sollte nach"
	line "Orania City zu-"
	cont "rückgehen und"
	cont "härter trainieren…"
	done

FastShipBed:
	showtext FastShipBedText1
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	special HealParty
	playmusic MUSIC_HEAL
	pause 60
	turnobject PLAYER, LEFT
	special RestartMapMusic
	special Special_FadeInQuickly
	showtext FastShipBedText2
	checkevent EVENT_FAST_SHIP_HAS_ARRIVED
	iftruefwd .AlreadyArrived
	checkevent EVENT_FAST_SHIP_FOUND_GIRL
	iftruefwd .CanArrive
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftruefwd .CanArrive
.AlreadyArrived:
	end

.CanArrive:
	playsound SFX_ELEVATOR_END
	pause 30
	checkevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	iftruefwd .ArrivedOlivine
	showtext FastShipArrivedVermilionText
	setevent EVENT_FAST_SHIP_HAS_ARRIVED
	end

.ArrivedOlivine:
	showtext FastShipArrivedOlivineText
	setevent EVENT_FAST_SHIP_HAS_ARRIVED
	end

FirebreatherLyleSeenText:
	text "Ich gehe nach"
	line "Kanto, um meine"
	cont "Feuerspuck-Künste"
	cont "vorzuführen!"
	done

FirebreatherLyleBeatenText:
	text "Zisch… Die"
	line "Flamme ist klein…"
	done

Bug_catcherKenSeenText:
	text "Ich besuche meine"
	line "Oma, um einige"
	cont "Käfer zu fangen!"
	done

Bug_catcherKenBeatenText:
	text "Oh, wow."
	line "Du bist stark!"
	done

RichBoyWinstonSeenText:
	text "Du kannst dir nie"
	line "im Leben ein"
	cont "Ticket leisten."

	para "Sieht aus, als"
	line "hätten wir einen"
	cont "blinden Passagier!"
	done

RichBoyWinstonBeatenText:
	text "Wow! Bei wem hast"
	line "du deine #mon"
	cont "gekauft?"
	done

BeautyCassieSeenText:
	text "Ich versuche,"
	line "meine Leiden zu"
	cont "vergessen. Lass"
	cont "uns kämpfen!"
	done

BeautyCassieBeatenText:
	text "Mein Herz weint…"
	done

GuitaristmClydeSeenText:
	text "Ich werde meine"
	line "Lieder bei der"

	para "Radiostation in"
	line "Dukatia City"
	cont "vorspielen."
	done

GuitaristmClydeBeatenText:
	text "Yowza!"
	line "Total verzerrt!"
	done



FastShipBedText1:
	text "Ein weiches Bett!"
	line "Schlafenszeit…"
	done

FastShipBedText2:
	text "Ah, ausgeruht und"
	line "frisch!"
	done

FastShipArrivedOlivineText:
	text "Die M.S. Aqua"
	line "legt in"
	para "Oliviana City an."
	done

FastShipArrivedVermilionText:
	text "Die M.S. Aqua legt"
	line "in"
	para "Orania City an."
	done
