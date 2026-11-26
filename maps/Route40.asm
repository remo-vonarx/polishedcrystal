Route40_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, MonicaCallback

	def_warp_events
	warp_event  9,  5, ROUTE_40_BATTLE_TOWER_GATE, 1

	def_coord_events

	def_bg_events
	bg_event 14, 10, BGEVENT_JUMPTEXT, Route40SignText
	bg_event  7,  8, BGEVENT_ITEM + HYPER_POTION, EVENT_ROUTE_40_HIDDEN_HYPER_POTION

	def_object_events
	object_event  7, 11, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, MonicaScript, EVENT_ROUTE_40_MONICA_OF_MONDAY
	object_event 13, 16, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmermSimon, -1
	object_event 18, 33, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerSwimmermRandall, -1
	object_event  3, 19, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmerfElaine, -1
	object_event  9, 25, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfPaula, -1
	object_event 11, 13, SPRITE_BEACH_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route40BeachGirlText, -1
	object_event  7,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route40PokefanMScript, -1
	object_event 13,  4, SPRITE_PICNICKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route40PicnickerText, -1
	object_event 14,  8, SPRITE_BEACH_GUY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40BeachGuyScript, -1
	object_event 16, 27, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40FisherScript, -1
	smashrock_event  8, 10
	smashrock_event  6, 9
	smashrock_event  7, 8

	object_const_def
	const ROUTE40_MONICA

MonicaCallback:
	readvar VAR_WEEKDAY
	ifequalfwd MONDAY, .MonicaAppears
	disappear ROUTE40_MONICA
	endcallback

.MonicaAppears:
	appear ROUTE40_MONICA
	endcallback

GenericTrainerSwimmerfElaine:
	generictrainer SWIMMERF, ELAINE, EVENT_BEAT_SWIMMERF_ELAINE, SwimmerfElaineSeenText, SwimmerfElaineBeatenText

	text "Ich behaupte,"
	line "dass ich besser"
	cont "schwimme als du!"
	done

GenericTrainerSwimmerfPaula:
	generictrainer SWIMMERF, PAULA, EVENT_BEAT_SWIMMERF_PAULA, SwimmerfPaulaSeenText, SwimmerfPaulaBeatenText

	text "Ich lasse mich im"
	line "Wasser treiben und"
	cont "von den Wellen"
	cont "davontragen."
	done

GenericTrainerSwimmermSimon:
	generictrainer SWIMMERM, SIMON, EVENT_BEAT_SWIMMERM_SIMON, SwimmermSimonSeenText, SwimmermSimonBeatenText

	text "Anemonia City ist"
	line "ziemlich weit"
	cont "weg von hier."
	done

GenericTrainerSwimmermRandall:
	generictrainer SWIMMERM, RANDALL, EVENT_BEAT_SWIMMERM_RANDALL, SwimmermRandallSeenText, SwimmermRandallBeatenText

	text "Schwimmen hält"
	line "deinen ganzen"
	cont "Körper fit und"
	cont "gesund."
	done

Route40PokefanMScript:
	checkevent EVENT_BATTLE_TOWER_OPEN
	iftrue_jumptextfaceplayer Route40PokefanMText2
	jumpthistextfaceplayer

	text "Hm! Das ist ein"
	line "hohes Gebäude!"

	para "Was ist das?"
	done

Route40BeachGuyScript:
	checkevent EVENT_BATTLE_TOWER_OPEN
	iftrue_jumptextfaceplayer Route40BeachGuyText2
	jumpthistextfaceplayer

	text "Der Duellturm ist"
	line "fast fertig!"

	para "Trainer aus aller"
	line "Welt kommen nach"

	para "Oliviana City, um"
	line "ihre Stärke zu"
	cont "testen."
	done

Route40FisherScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_KNOCK_OFF_INTRO
	iftruefwd .HeardIntro
	writetext .IntroText
	waitbutton
	setevent EVENT_LISTENED_TO_KNOCK_OFF_INTRO
.HeardIntro:
	writetext .QuestionText
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	yesorno
	iffalsefwd .TutorRefused
	setval KNOCK_OFF
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpthisopenedtext

	text "Dann such ich mir"
	line "was anderes…"
	done

.IntroText:
	text "Ich habe geangelt,"
	line "als #mon hoch-"
	cont "sprangen und meine"

	para "Angel ins Wasser"
	line "stießen!"

	para "Wie soll ich jetzt"
	line "was fangen?"

	para "…Na gut, wenn ich"
	line "nicht angeln kann,"
	cont "unterrichte ich"
	cont "eben."
	done

.QuestionText:
	text "Gib mir ein"
	line "Silberblatt, und"

	para "ich bringe deinem"
	line "#mon Abschlag"
	cont "bei."

	para "Wie wär's?"
	done

.NoSilverLeaf
	waitbutton
	jumpthisopenedtext

	text "Kein Blatt, keine"
	line "Attacke. Meine"
	cont "Zeit ist nicht"
	cont "umsonst."
	done

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext

	text "Abschlag schlägt"
	line "ein getragenes"

	para "Item weg, sodass"
	line "es im Kampf nicht"
	cont "nutzbar ist."

	para "Das ist so frus-"
	line "trierend!"
	done

MonicaScript:
	checkevent EVENT_GOT_SHARP_BEAK_FROM_MONICA
	iftrue_jumptextfaceplayer MonicaMondayText
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, MonicaNotMondayScript
	faceplayer
	opentext
	checkevent EVENT_MET_MONICA_OF_MONDAY
	iftruefwd .MetMonica
	writetext MeetMonicaText
	promptbutton
	setevent EVENT_MET_MONICA_OF_MONDAY
.MetMonica:
	writetext MonicaGivesGiftText
	promptbutton
	verbosegiveitem SHARP_BEAK, iffalsefwd MonicaDoneScript
	setevent EVENT_GOT_SHARP_BEAK_FROM_MONICA
	jumpthisopenedtext

	text "Monja: Dieses"
	line "Item verstärkt"

	para "Flug-Attacken."

	para "Damit solltest du"
	line "ein Vogel-#mon"
	cont "ausstatten."
	done

MonicaNotMondayScript:
	jumpthistextfaceplayer

	text "Monja: Ich"
	line "fürchte, heute ist"
	cont "nicht Montag. Wie"
	cont "schade…"
	done

MonicaDoneScript:
	end

SwimmermSimonSeenText:
	text "Du musst dich erst"
	line "aufwärmen, bevor"
	cont "du schwimmen"
	cont "gehst."

	para "Das ist"
	line "Grundwissen."
	done

SwimmermSimonBeatenText:
	text "O.K.! Onkel! Ich"
	line "gebe auf!"
	done

SwimmermRandallSeenText:
	text "Heh, du bist jung"
	line "und fit!"

	para "Surfe nicht auf"
	line "deinem #mon!"
	cont "Schwimme!"
	done

SwimmermRandallBeatenText:
	text "Oh, oh. Ich habe"
	line "verloren…"
	done

SwimmerfElaineSeenText:
	text "Gehst du nach"
	line "Anemonia City?"

	para "Wie wäre es erst"
	line "mit einem kleinen"
	cont "Kampftraining?"
	done

SwimmerfElaineBeatenText:
	text "Diesmal habe ich"
	line "verloren!"
	done

SwimmerfPaulaSeenText:
	text "Ich habe keine"
	line "Schwimmreifen."

	para "Ich halte mich an"
	line "einem Wasser-"
	cont "#mon fest!"
	done

SwimmerfPaulaBeatenText:
	text "Oh, ich fühle mich"
	line "so schwindelig!"
	done

Route40BeachGirlText:
	text "Ich habe gerade im"
	line "Oliviana City-"
	cont "Cafe gegessen,"

	para "also mache ich vor"
	line "dem Schwimmen eine"
	cont "Pause."
	done


Route40PokefanMText2:
	text "Hm! Sieh die"
	line "entschlossenen"
	cont "Trainer, die"
	cont "hineingehen."

	para "Was? Was?"
	done

Route40PicnickerText:
	text "Ich reiste mit dem"
	line "Schiff nach"

	para "Oliviana, um die"
	line "Sehenswürdigkeiten"

	para "und die Atmosphäre"
	line "zu genießen."

	para "Da es eine Hafen-"
	line "stadt ist, unter-"

	para "scheidet sie sich"
	line "von anderen"
	cont "großen Städten."
	done


Route40BeachGuyText2:
	text "Warst du schon am"
	line "Duellturm?"

	para "Ich denke, dass"
	line "sich bereits viele"

	para "starke Trainer"
	line "dort versammeln."

	para "Da du so viele"
	line "Orden besitzt,"

	para "wirst du dich dort"
	line "wacker schlagen."
	done

MeetMonicaText:
	text "Monja: Es freut"
	line "mich, dich kennen"

	para "zu lernen. Ich bin"
	line "Monja von Montag."
	done

MonicaGivesGiftText:
	text "Als Zeichen"
	line "unserer Freund-"
	cont "schaft schenke ich"
	cont "dir dies!"
	done


MonicaMondayText:
	text "Monja: Meine"
	line "Geschwister"

	para "findest du"
	line "überall."

	para "Du solltest sie"
	line "alle finden!"
	done


Route40SignText:
	text "Route 40"

	para "Anemonia City -"
	line "Oliviana City"
	done
