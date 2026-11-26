IcePathB3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  5, ICE_PATH_B2F_MAHOGANY_SIDE, 2
	warp_event 15,  5, ICE_PATH_B2F_BLACKTHORN_SIDE, 2

	def_coord_events

	def_bg_events
	bg_event 16,  3, BGEVENT_JUMPTEXT, Text_IcePathB3FIceRock

	def_object_events
	object_event 10,  3, SPRITE_LORELEI, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, LoreleiScript, -1
	itemball_event  5,  7, NEVERMELTICE, 1, EVENT_ICE_PATH_B3F_NEVERMELTICE
	smashrock_event  6, 6

	object_const_def
	const ICEPATHB3F_LORELEI

LoreleiScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_ELITE_FOUR
	iftruefwd LoreleiRematchScript
	checkevent EVENT_BEAT_LORELEI
	iftruefwd LoreleiAfterScript
	checkevent EVENT_INTRODUCED_LORELEI
	iftruefwd LoreleiAfterIntroScript
	writetext LoreleiIntroText
	waitbutton
	setevent EVENT_INTRODUCED_LORELEI
LoreleiAfterIntroScript:
	writetext LoreleiAfterIntroText
	yesorno
	iffalse_jumpopenedtext LoreleiNoBattleText
	writetext LoreleiSeenText
	waitbutton
	closetext
	winlosstext LoreleiBeatenText, 0
	setlasttalked ICEPATHB3F_LORELEI
	loadtrainer LORELEI, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_LORELEI
	opentext
	writetext LoreleiRewardText
	promptbutton
	verbosegiveitem ICY_ROCK, iffalsefwd LoreleiAfterScript
	setevent EVENT_GOT_ICY_ROCK_FROM_LORELEI
LoreleiAfterScript:
	readvar VAR_BADGES
	ifequalfwd NUM_JOHTO_BADGES, .AllEightBadges
	writetext LoreleiOneMoreBadgeText
	sjumpfwd .Finish

.AllEightBadges:
	writetext LoreleiAllBadgesText
.Finish
	promptbutton
	jumpthisopenedtext

	text "Wenn du sie be-"
	line "siegst, triff mich"
	cont "hier zu einem"
	cont "Rückkampf."
	done

LoreleiRematchScript:
	checkevent EVENT_BEAT_LORELEI_AGAIN
	iffalsefwd .DoRematch
	checkevent EVENT_GOT_ICY_ROCK_FROM_LORELEI
	iftrue_jumpopenedtext LoreleiRematchAfterText
	opentext
	sjumpfwd LoreleiGiveIcyRock
.DoRematch:
	checkevent EVENT_INTRODUCED_LORELEI
	iftruefwd LoreleiReintroductionScript
	writetext LoreleiIntroText
	waitbutton
	setevent EVENT_INTRODUCED_LORELEI
LoreleiAfterRematchIntroScript:
	writetext LoreleiRematchSeenText
	waitbutton
	closetext
	winlosstext LoreleiRematchBeatenText, 0
	setlasttalked ICEPATHB3F_LORELEI
	loadtrainer LORELEI, 3
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_LORELEI_AGAIN
	opentext
	checkevent EVENT_GOT_ICY_ROCK_FROM_LORELEI
	iftrue_jumpopenedtext LoreleiRematchAfterText
LoreleiGiveIcyRock:
	writetext LoreleiRewardText
	promptbutton
	verbosegiveitem ICY_ROCK, iffalse_jumpopenedtext LoreleiRematchAfterText
	setevent EVENT_GOT_ICY_ROCK_FROM_LORELEI
	jumpthisopenedtext

LoreleiRematchAfterText:
	text "Deine Reise ist"
	line "noch nicht vorbei."

	para "Du kannst in Kanto"
	line "weitere Orden"
	cont "verdienen,"

	para "neue #mon-Arten"
	line "fangen,"

	para "dich und dein Team"
	line "verbessern."

	para "#mon-Meister zu"
	line "werden, ist eine"
	cont "Lebensaufgabe."
	done

LoreleiReintroductionScript:
	writetext LoreleiRematchIntroAgainText
	waitbutton
	sjump LoreleiAfterRematchIntroScript

Text_IcePathB3FIceRock:
	text "Der Fels ist mit"
	line "Eis überzogen."

	para "Er fühlt sich"
	line "eiskalt an."
	done

LoreleiIntroText:
	text "Lorelei: Hallo,"
	line "Trainer."
	cont "Ich bin Lorelei."

	para "Siehst du den"
	line "Eisfelsen dort?"

	para "Er strahlt eine"
	line "Energie aus, die"
	cont "ich in Kanto nie"
	cont "gesehen habe."

	para "Als Expertin für"
	line "Eis-#mon musste"
	cont "ich ihn untersu-"
	cont "chen."

	para "Und was machst du"
	line "hier?"
	done

LoreleiAfterIntroText:
	text "Lorelei: Du willst"
	line "dich der #mon"

	para "Liga stellen."
	line "Verstehe."
	cont "Wie ironisch."

	para "Soll ich dein"
	line "Können testen?"
	done

LoreleiNoBattleText:
	text "Wenn du dich mir"
	line "nicht stellst,"

	para "wirst du nie den"
	line "Champ besiegen."
	done

LoreleiSeenText:
	text "Hahaha! Mach dich"
	line "darauf gefasst,"
	cont "zu Eis zu"
	cont "erstarren!"
	done

LoreleiBeatenText:
	text "Du bist besser,"
	line "als ich dachte!"
	done

LoreleiRewardText:
	text "Du weißt mit"
	line "Eis-#mon umzu-"
	cont "gehen."

	para "Dann kannst du"
	line "dieses Item"
	cont "gebrauchen."
	done

LoreleiRematchIntroAgainText:
	text "Lorelei: Hallo"
	line "noch mal, <PLAYER>."
	done

LoreleiRematchSeenText:
	text "Du hast also gegen"
	line "die Top Vier"
	cont "gekämpft?"

	para "Ich hoffe, du hast"
	line "Melanie einen"
	cont "Dämpfer verpasst."

	para "…………Du bist"
	line "jetzt Champ."
	cont "Beeindruckend."

	para "Dann muss ich mich"
	line "nicht zurück-"
	cont "halten!"
	done

LoreleiRematchBeatenText:
	text "Wie vom Champ"
	line "erwartet!"
	done

LoreleiOneMoreBadgeText:
	text "Geh nur weiter."
	line "Mit einem weiteren"

	para "Orden kannst du"
	line "die #mon Liga"
	cont "herausfordern."
	done

LoreleiAllBadgesText:
	text "Geh nur weiter. Du"
	line "hast genug Orden,"

	para "um die #mon"
	line "Liga herauszu-"
	cont "fordern."
	done
