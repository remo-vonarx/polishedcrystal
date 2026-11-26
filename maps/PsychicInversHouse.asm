PsychicInversHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, ROUTE_16_WEST, 1
	warp_event  3,  7, ROUTE_16_WEST, 1

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events
	object_event  2,  2, SPRITE_PSYCHIC, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, PsychicInverScript, -1
	object_event  6,  3, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, PsychicInversHouseHexManiacText, -1

	object_const_def
	const PSYCHICINVERSHOUSE_INVER

PsychicInverScript:
	checkflag ENGINE_FOUGHT_PSYCHIC_INVER
	iftrue_jumptextfaceplayer PsychicInverTomorrowText
	faceplayer
	opentext
	writetext PsychicInverGreetingText
	yesorno
	iffalse_jumpopenedtext PsychicInverNoText
	writetext PsychicInverYesText
	waitbutton
	closetext
	setflag ENGINE_FOUGHT_PSYCHIC_INVER
	winlosstext PsychicInverBeatenText, 0
	setlasttalked PSYCHICINVERSHOUSE_INVER
	special PickPsychicInverParty
	loadtrainer INVER, 1
	loadvar VAR_BATTLETYPE, BATTLETYPE_INVERSE
	startbattle
	reloadmapafterbattle
	opentext
	readmem wInverseBattleScore
	ifequalfwd 0, .Score0
	ifgreater 127, .Score0 ; negative
	ifless 4, .Score1_3
	ifless 7, .Score4_6
	ifless 10, .Score7_9
	writetext InverseBattle10PointRewardText
	setval RARE_CANDY
.Reward
	waitbutton
	writetext PsychicInverRewardText
.GiveReward
	promptbutton
	; The daily reward is forfeited if the Bag is full.
	verbosegiveitem_unsafe ITEM_FROM_MEM
	endtext

.Score0
	writetext InverseBattle0PointRewardText
	waitbutton
	writetext PsychicInverZeroRewardText
	setval ORAN_BERRY
	sjump .GiveReward

.Score1_3
	writetext InverseBattle1_3PointRewardText
	setval SITRUS_BERRY
	sjump .Reward

.Score4_6
	writetext InverseBattle4_6PointRewardText
	random MARANGABERRY - LUM_BERRY + 1 ; excludes early common berries
	addval LUM_BERRY
	sjump .Reward

.Score7_9
	writetext InverseBattle7_9PointRewardText
	random NUM_STONES
	addval FIRST_STONE
	sjump .Reward

PsychicInverGreetingText:
	text "Oh. Ich habe hier"
	line "keinen Besuch er-"
	cont "wartet. Hmm…"

	para "Wollen wir einen"
	line "recht seltsamen"
	cont "Kampf austragen?"

	para "Ich nenne ihn"
	line "Umkehrkampf!"

	para "Was meinst du?"
	line "Möchtest du einen"
	cont "Umkehrkampf"
	cont "versuchen?"
	done

PsychicInverNoText:
	text "Oh, verstehe… Wie"
	line "schade."

	para "Falls du es dir"
	line "anders überlegst,"
	cont "komm wieder."
	done

PsychicInverYesText:
	text "Sehr effektive"
	line "Attacken sind"
	cont "nicht sehr"
	cont "effektiv und"
	cont "umgekehrt."
	done

PsychicInverBeatenText:
	text "Der Kampf hat mich"
	line "vielleicht noch"

	para "mehr ermüdet als"
	line "meine #mon…"
	done

InverseBattle0PointRewardText:
	text "Ich weiß nicht, ob"
	line "du Umkehrkämpfe"
	cont "verstehst…"
	done

InverseBattle1_3PointRewardText:
	text "Du verstehst"
	line "Umkehrkämpfe…"
	done

InverseBattle4_6PointRewardText:
	text "Du verstehst"
	line "Umkehrkämpfe"
	cont "ziemlich gut."
	done

InverseBattle7_9PointRewardText:
	text "Du verstehst"
	line "Umkehrkämpfe"
	cont "perfekt!"
	done

InverseBattle10PointRewardText:
	text "Bei Umkehrkämpfen"
	line "kennst du dich"
	cont "bestens aus."

	para "Ich bin kein"
	line "Gegner für dich."
	done

PsychicInverZeroRewardText:
	text "Trotzdem gebe ich"
	line "dir eine Kleinig-"
	cont "keit. Versuch es"
	cont "unbedingt wieder!"
	done

PsychicInverRewardText:
	text "Für einen Gegner"
	line "wie dich habe ich"
	cont "eine Kleinigkeit!"

	para "Hier! Nimm!"
	done

PsychicInverTomorrowText:
	text "Diese seltsame"
	line "Kraft, die Typ-"
	cont "Verhältnisse um-"
	cont "kehrt…"

	para "Ich kann sie nicht"
	line "sehr oft nutzen."

	para "Bitte komm morgen"
	line "wieder."
	done

PsychicInversHouseHexManiacText:
	text "Mein Bruder hat"
	line "eine mysteriöse"
	cont "Kraft!"

	para "Er kann Typ-"
	line "Verhältnisse um-"
	cont "kehren! Total"
	cont "verrückt!"

	para "Sehr effektive und"
	line "nicht sehr effek-"
	cont "tive Attacken"
	cont "werden vertauscht!"
	done
