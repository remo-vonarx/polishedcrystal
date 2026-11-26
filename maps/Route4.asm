Route4_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  7, MOUNT_MOON_B1F, 8

	def_coord_events

	def_bg_events
	bg_event  7,  9, BGEVENT_JUMPTEXT, MtMoonSignText
	bg_event 20,  5, BGEVENT_ITEM + ULTRA_BALL, EVENT_ROUTE_4_HIDDEN_ULTRA_BALL

	def_object_events
	object_event 51,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerYoungsterOliver, -1
	object_event 38, 13, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerLassJennifer, -1
	object_event 28,  6, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperHank, -1
	object_event 12, 10, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerPicnickerHope, -1
	object_event 35,  8, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerPicnickerSharon, -1
	object_event 26, 13, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route4SuperNerd1Script, -1
	object_event 29, 13, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route4SuperNerd2Script, -1
	itemball_event 42,  5, HP_UP, 1, EVENT_ROUTE_4_HP_UP
	object_event 68,  6, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_BEAT_BLUE

GenericTrainerYoungsterOliver:
	generictrainer YOUNGSTER, OLIVER, EVENT_BEAT_YOUNGSTER_OLIVER, YoungsterOliverSeenText, YoungsterOliverBeatenText

	text "Die Leute sagen,"
	line "ich stelle zu"
	cont "viele Fragen, aber"

	para "das machen Kinder"
	line "doch, oder?"
	done

GenericTrainerLassJennifer:
	generictrainer LASS, JENNIFER, EVENT_BEAT_LASS_JENNIFER, LassJenniferSeenText, LassJenniferBeatenText

	text "#mon machen so"
	line "viel Spaß."
	cont "Findest du nicht?"
	done

GenericTrainerBird_keeperHank:
	generictrainer BIRD_KEEPER, HANK, EVENT_BEAT_BIRD_KEEPER_HANK, Bird_keeperHankSeenText, Bird_keeperHankBeatenText

	text "Hast du ein spe-"
	line "zielles #mon,"

	para "das du trainieren"
	line "möchtest, setze es"

	para "an die erste Stel-"
	line "le und tausche es"
	cont "sofort aus."

	para "So funktioniert"
	line "das."
	done

GenericTrainerPicnickerHope:
	generictrainer PICNICKER, HOPE, EVENT_BEAT_PICNICKER_HOPE, PicnickerHopeSeenText, PicnickerHopeBeatenText

	text "Ich hörte, dass"
	line "Piepi am Mondberg"

	para "auftauchen. Aber"
	line "wo soll das sein?"
	done

GenericTrainerPicnickerSharon:
	generictrainer PICNICKER, SHARON, EVENT_BEAT_PICNICKER_SHARON, PicnickerSharonSeenText, PicnickerSharonBeatenText

	text "……Ich sollte"
	line "wohl noch mehr"
	cont "trainieren…"
	done

Route4SuperNerd1Script:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_IRON_HEAD_INTRO
	iftruefwd Route4TutorIronHeadScript
	writetext Route4SuperNerd1Text
	waitbutton
	setevent EVENT_LISTENED_TO_IRON_HEAD_INTRO
Route4TutorIronHeadScript:
	writetext Text_Route4TutorIronHead
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writetext Text_Route4Tutor1Question
	yesorno
	iffalsefwd .TutorRefused
	setval IRON_HEAD
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpthisopenedtext

	text "Aber sie ist"
	line "besser als"
	cont "Nassschweif!"
	done

.NoSilverLeaf
	jumpopenedtext Text_Route4TutorsNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext

	text "Jetzt beherrscht"
	line "dein #mon"
	cont "Eisenschädel!"
	done

Route4SuperNerd2Script:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_AQUA_TAIL_INTRO
	iftruefwd Route4TutorAquaTailScript
	writetext Route4SuperNerd2Text
	waitbutton
	setevent EVENT_LISTENED_TO_AQUA_TAIL_INTRO
Route4TutorAquaTailScript:
	writetext Text_Route4TutorAquaTail
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writetext Text_Route4Tutor2Question
	yesorno
	iffalsefwd .TutorRefused
	setval AQUA_TAIL
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpthisopenedtext

	text "Aber sie ist"
	line "besser als"
	cont "Eisenschädel!"
	done

.NoSilverLeaf
	jumpopenedtext Text_Route4TutorsNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext

	text "Jetzt beherrscht"
	line "dein #mon"
	cont "Nassschweif!"
	done

YoungsterOliverSeenText:
	text "Hi! Wie heißt du?"
	line "Wohin gehst du?"
	done

YoungsterOliverBeatenText:
	text "Ich hab doch nur"
	line "gefragt…"
	done

LassJenniferSeenText:
	text "Ich kämpfe bei"
	line "jeder Gelegenheit,"

	para "nur um Zeit mit"
	line "meinen #mon zu"
	cont "verbringen."
	done

LassJenniferBeatenText:
	text "Huiii!"
	done

Bird_keeperHankSeenText:
	text "Ich trainiere"
	line "#mon. Trittst"
	cont "du gegen mich an?"
	done

Bird_keeperHankBeatenText:
	text "Uff! Ich habe"
	line "verloren…"
	done

PicnickerHopeSeenText:
	text "Ich spüre, dass"
	line "ich gewinnen kann."

	para "Mal sehen, ob"
	line "das stimmt!"
	done

PicnickerHopeBeatenText:
	text "Argh, du bist zu"
	line "stark."
	done

PicnickerSharonSeenText: ; text > text
	text "Ähm…"
	line "Ich…"
	done

PicnickerSharonBeatenText: ; text > text
	text "…"
	done

Route4SuperNerd1Text:
	text "#mon mit harten"
	line "Köpfen sind die"
	cont "besten!"

	para "Arkani, Geowaz,"
	line "Relaxo!"

	para "Findest du nicht?"
	done

Route4SuperNerd2Text:
	text "#mon mit langen"
	line "Schweifen sind die"
	cont "besten!"

	para "Lahmus, Entoron,"
	line "Impergator!"

	para "Findest du nicht?"
	done

Text_Route4TutorIronHead:
	text "Wenn du mir ein"
	line "Silberblatt gibst,"

	para "bringe ich deinem"
	line "#mon Eisen-"
	cont "schädel bei!"
	done

Text_Route4TutorAquaTail:
	text "Wenn du mir ein"
	line "Silberblatt gibst,"

	para "bringe ich deinem"
	line "#mon"
	cont "Nassschweif bei!"
	done

Text_Route4TutorsNoSilverLeaf:
	text "Aber du hast kein"
	line "Silberblatt."
	done

Text_Route4Tutor1Question:
	text "Soll ich deinem"
	line "#mon"
	cont "Eisenschädel"
	cont "beibringen?"
	done

Text_Route4Tutor2Question:
	text "Soll ich deinem"
	line "#mon"
	cont "Nassschweif"
	cont "beibringen?"
	done

MtMoonSignText:
	text "Mondberg-Tunnel"
	done
