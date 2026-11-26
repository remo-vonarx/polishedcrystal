WiseTriosRoom_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_WISETRIOSROOM_SAGE_BLOCKS
	scene_const SCENE_WISETRIOSROOM_NOOP

	def_callbacks
	callback MAPCALLBACK_OBJECTS, WiseTriosRoomCallback

	def_warp_events
	warp_event  7,  4, BELLCHIME_TRAIL, 1
	warp_event  7,  5, BELLCHIME_TRAIL, 2
	warp_event  1,  4, ECRUTEAK_HOUSE, 5

	def_coord_events
	coord_event  7,  4, SCENE_WISETRIOSROOM_SAGE_BLOCKS, WiseTriosRoom_CannotEnterTinTowerScript

	def_bg_events

	def_object_events
	object_event  6,  2, SPRITE_ELDER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, WiseTriosRoomSage1Text, EVENT_WISE_TRIOS_ROOM_WISE_TRIO_1
	object_event  6,  7, SPRITE_ELDER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, WiseTriosRoomSage2Text, EVENT_WISE_TRIOS_ROOM_WISE_TRIO_1
	object_event  7,  5, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, WiseTriosRoomSage3Text, EVENT_WISE_TRIOS_ROOM_WISE_TRIO_1
	object_event  4,  2, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerElderGaku, EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2
	object_event  4,  6, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerElderMasa, EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2
	object_event  6,  4, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerElderKoji, EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2

	object_const_def
	const WISETRIOSROOM_ELDER1
	const WISETRIOSROOM_ELDER2
	const WISETRIOSROOM_ELDER3
	const WISETRIOSROOM_ELDER4
	const WISETRIOSROOM_ELDER5
	const WISETRIOSROOM_ELDER6

WiseTriosRoomCallback:
	checkevent EVENT_FOUGHT_SUICUNE
	iftruefwd .NoWiseTrio
	checkevent EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER
	iftruefwd .WiseTrio2
	checkkeyitem CLEAR_BELL
	iftruefwd .WiseTrio2
	clearevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_1
	setevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2
	endcallback

.WiseTrio2:
	setevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_1
	clearevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2
	endcallback

.NoWiseTrio:
	setevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_1
	setevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2
	endcallback

WiseTriosRoom_CannotEnterTinTowerScript:
	turnobject WISETRIOSROOM_ELDER3, UP
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, WISETRIOSROOM_ELDER3, 20
	follow PLAYER, WISETRIOSROOM_ELDER3
	applymovement PLAYER, WiseTriosRoomSageBlocksPlayerMovement
	stopfollow
	turnobject PLAYER, RIGHT
	showtext WiseTriosRoomSage3BlocksExitText
	applymovement WISETRIOSROOM_ELDER3, WiseTriosRoomSageReturnsMovement
	turnobject WISETRIOSROOM_ELDER3, LEFT
	end

TrainerElderGaku:
	trainer ELDER, GAKU, EVENT_BEAT_ELDER_GAKU, ElderGakuSeenText, ElderGakuBeatenText, 0, .Script, TRAINERPAL_GAKU

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Ah, du behauptest"
	line "also, Suicune,"

	para "Entei und Raikou"
	line "während sie"

	para "schliefen"
	line "gesehen zu haben?"

	para "Unglaublich!"

	para "Der Legende nach"
	line "können sie während"

	para "des Schlafs nicht"
	line "gesehen werden…"
	done

TrainerElderMasa:
	trainer ELDER, MASA, EVENT_BEAT_ELDER_MASA, ElderMasaSeenText, ElderMasaBeatenText, 0, .Script, TRAINERPAL_MASA

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Es gab früher zwei"
	line "8-stöckige"
	cont "Türme hier."

	para "Den Bronzeturm,"
	line "der die #mon"

	para "erwecken sollte,"
	line "und den Glocken-"
	cont "turm,"

	para "in dem die #mon"
	line "ruhen sollten."

	para "Die Aussicht von"
	line "den beiden Spitzen"

	para "der Türme muss"
	line "atemberaubend"
	cont "gewesen sein."

	para "Zu dieser Zeit"
	line "soll sich ein"

	para "gigantisches, sil-"
	line "bernes #mon auf"

	para "der Spitze des"
	line "Bronzeturms"

	para "niedergelassen"
	line "haben."

	para "Jedoch…"

	para "Vor 150 Jahren"
	line "schlug ein Blitz"

	para "in einen der"
	line "beiden Türme ein."

	para "Die Flammen"
	line "wüteten für ganze"
	cont "drei Tage."

	para "Ein plötzlicher"
	line "Platzregen löschte"
	cont "das Feuer."

	para "Und so ist die"
	line "Turmruine"
	cont "entstanden."
	done

TrainerElderKoji:
	trainer ELDER, KOJI, EVENT_BEAT_ELDER_KOJI, ElderKojiSeenText, ElderKojiBeatenText, 0, .Script, TRAINERPAL_KOJI

.Script:
	checkevent EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER
	iftrue_jumptext SageKojiAfterBattleFinalText
	pause 10
	showemote EMOTE_SHOCK, WISETRIOSROOM_ELDER6, 20
	opentext
	writetext SageKojiAfterBattleQuestionText
	promptbutton
	writetext SageKojiAfterBattleSpeechText
	waitbutton
	closetext
	applymovement WISETRIOSROOM_ELDER6, WiseTriosRoomSageAllowsPassageMovement
	turnobject WISETRIOSROOM_ELDER6, UP
	setevent EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER
	setscene SCENE_WISETRIOSROOM_NOOP
	end

WiseTriosRoomSageBlocksPlayerMovement:
	step_left
	step_left
	step_end

WiseTriosRoomSageReturnsMovement:
	step_right
	step_down
	step_end

WiseTriosRoomSageAllowsPassageMovement:
	step_right
	step_down
	step_end

WiseTriosRoomSage1Text:
	text "Erstaunlich…"

	para "Suicune, Entei und"
	line "Raikou sind aus"
	cont "dem Schlaf"
	cont "erwacht…"

	para "Wird die Legende"
	line "wahr?"
	done

WiseTriosRoomSage2Text:
	text "Wir trainieren bei"
	line "der Turmruine,"

	para "aber wir haben nie"
	line "von einem Loch ge-"
	cont "hört, das sich"
	cont "dort geöffnet"

	para "haben soll. Jemand"
	line "muss das absicht-"
	cont "lich getan haben."
	done

WiseTriosRoomSage3BlocksExitText:
	text "Zutritt zum"
	line "Glockenturm haben"
	cont "jene,"

	para "die den Orden der"
	line "PKMN-Arena von"
	cont "Teak City tragen."

	para "Da Suicune, Raikou"
	line "und Entei jetzt"

	para "aber erwacht sind,"
	line "muss ich dich"

	para "bitten, nicht"
	line "einzutreten!"
	done

WiseTriosRoomSage3Text:
	text "Wir, das Trio der"
	line "Weisen, sind die"

	para "Hüter der legen-"
	line "dären #mon."
	done

ElderGakuSeenText:
	text "Die Legende be-"
	line "sagt, dass beim"

	para "Erscheinen eines"
	line "Trainers, der die"

	para "Fähigkeit besitzt,"
	line "die Seelen der"

	para "#mon zu be-"
	line "rühren, ein #-"
	cont "mon kommt, das ihn"

	para "beim Glockenturm"
	line "auf die Probe"
	cont "stellt."

	para "Die Legende ist"
	line "wahr!"

	para "Das legendäre"
	line "#mon Suicune"
	cont "ist gekommen!"

	para "Wir, das Trio der"
	line "Weisen, werden"

	para "prüfen, ob du"
	line "würdig bist,"
	cont "einzutreten!"
	done

ElderGakuBeatenText:
	text "Stärker als wir"
	line "dachten? Wer weiß…"
	done

ElderMasaSeenText:
	text "Kann man dir die"
	line "Wahrheit"
	cont "anvertrauen?"

	para "Ich muss prüfen,"
	line "ob du würdig bist."
	done

ElderMasaBeatenText:
	text "…Ich sage dir"
	line "die Wahrheit…"
	done

ElderKojiSeenText:
	text "Beweise mir deine"
	line "Kraft!"
	done

ElderKojiBeatenText:
	text "Zu stark!"
	line "Warum?"
	done

SageKojiAfterBattleQuestionText:
	text "Du… bist du der"
	line "Trainer, der von"

	para "dem legendären"
	line "#mon erwartet"
	cont "wird?"
	done

SageKojiAfterBattleSpeechText:
	text "Ich verstehe…"

	para "Wir, das Trio der"
	line "Weisen, sind ver-"
	cont "antwortlich für"
	cont "den Schutz der"

	para "legendären #-"
	line "mon. Wir gestatten"

	para "nur jenen Zutritt,"
	line "die eine reine"

	para "Seele und wahre"
	line "Kraft besitzen."

	para "Schreite voran und"
	line "betritt den"
	cont "Glockenturm."

	para "Suicune wird dich"
	line "prüfen."
	done

SageKojiAfterBattleFinalText:
	text "Schreite voran!"

	para "Suicune wird dich"
	line "prüfen."
	done
