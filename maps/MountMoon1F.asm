MountMoon1F_MapScriptHeader:
	def_scene_scripts
	scene_script MountMoon1FRivalBattleScene, SCENE_MOUNTMOON1F_RIVAL_BATTLE
	scene_const SCENE_MOUNTMOON1F_NOOP

	def_callbacks

	def_warp_events
	warp_event 11, 23, ROUTE_3, 1
	warp_event 22, 12, MOUNT_MOON_B1F, 1
	warp_event 11,  9, MOUNT_MOON_B1F, 2
	warp_event  4,  4, MOUNT_MOON_B1F, 3

	def_coord_events

	def_bg_events
	bg_event  2, 17, BGEVENT_ITEM + RARE_CANDY, EVENT_MOUNT_MOON_1F_HIDDEN_RARE_CANDY
	bg_event 12, 16, BGEVENT_ITEM + FULL_RESTORE, EVENT_MOUNT_MOON_1F_HIDDEN_FULL_RESTORE

	def_object_events
	object_event 10, 19, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MOON_RIVAL
	object_event  4, 18, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBugManiacKenta, -1
	object_event 11, 14, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerLassMiriam, -1
	object_event 20, 21, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSuperNerdJovan, -1
	object_event 27, 14, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBugManiacRobby, -1
	object_event 20,  2, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerLassIris, -1
	object_event  5,  5, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerHikerMarcos, -1
	itemball_event  3,  2, REVIVE, 1, EVENT_MOUNT_MOON_1F_REVIVE
	itemball_event  2, 20, X_ACCURACY, 1, EVENT_MOUNT_MOON_1F_X_ACCURACY
	itemball_event 16, 22, CALCIUM, 1, EVENT_MOUNT_MOON_1F_CALCIUM

	object_const_def
	const MOUNTMOON1F_RIVAL

MountMoon1FRivalBattleScene:
	sdefer .RivalBattle
	end

.RivalBattle:
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	applymovement MOUNTMOON1F_RIVAL, MountMoon1FRivalMovementBefore
	turnobject PLAYER, LEFT
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext MountMoonRivalTextBefore
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftruefwd .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftruefwd .Chikorita
	winlosstext MountMoonRivalTextWin, MountMoonRivalTextLoss
	setlasttalked MOUNTMOON1F_RIVAL
	loadtrainer RIVAL2, 3
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjumpfwd .FinishBattle

.Totodile:
	winlosstext MountMoonRivalTextWin, MountMoonRivalTextLoss
	setlasttalked MOUNTMOON1F_RIVAL
	loadtrainer RIVAL2, 1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjumpfwd .FinishBattle

.Chikorita:
	winlosstext MountMoonRivalTextWin, MountMoonRivalTextLoss
	setlasttalked MOUNTMOON1F_RIVAL
	loadtrainer RIVAL2, 2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	; fallthrough

.FinishBattle:
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	showtext MountMoonRivalTextAfter
	applymovement PLAYER, MountMoon1FPlayerMovement
	applymovement MOUNTMOON1F_RIVAL, MountMoon1FRivalMovementAfter
	disappear MOUNTMOON1F_RIVAL
	playsound SFX_EXIT_BUILDING
	waitsfx
	setscene SCENE_MOUNTMOON1F_NOOP
	setevent EVENT_BEAT_RIVAL_IN_MT_MOON
	playmapmusic
	end

GenericTrainerBugManiacKenta:
	generictrainer BUG_MANIAC, KENTA, EVENT_BEAT_BUG_MANIAC_KENTA, BugManiacKentaSeenText, BugManiacKentaBeatenText

	text "Früher trieb sich"
	line "hier Team Rocket"
	cont "herum."

	para "Ob der rothaarige"
	line "Junge wohl etwas"
	cont "mit ihnen zu tun"
	cont "hat?"
	done

GenericTrainerLassMiriam:
	generictrainer LASS, MIRIAM, EVENT_BEAT_LASS_MIRIAM, LassMiriamSeenText, LassMiriamBeatenText

	text "Der Mondberg ist"
	line "groß, aber du ge-"
	cont "wöhnst dich bald"
	cont "daran."
	done

GenericTrainerSuperNerdJovan:
	generictrainer SUPER_NERD, JOVAN, EVENT_BEAT_SUPER_NERD_JOVAN, SuperNerdJovanSeenText, SuperNerdJovanBeatenText

	text "Ich habe noch"
	line "keine stärkeren"
	cont "#mon gefunden."

	para "Wo die wohl sind?"
	done

GenericTrainerBugManiacRobby:
	generictrainer BUG_MANIAC, ROBBY, EVENT_BEAT_BUG_MANIAC_ROBBY, BugManiacRobbySeenText, BugManiacRobbyBeatenText

	text "Früher habe ich"
	line "Käfer-#mon nur"
	cont "als Hobby"
	cont "gefangen,"

	para "aber jetzt sind"
	line "sie mein ganzer"
	cont "Stolz."
	done

GenericTrainerLassIris:
	generictrainer LASS, IRIS, EVENT_BEAT_LASS_IRIS, LassIrisSeenText, LassIrisBeatenText

	text "Ich komme jeden"
	line "Tag her, um ein"
	cont "Piepi zu fangen,"

	para "aber ich habe noch"
	line "kein einziges"
	cont "gesehen…"
	done

GenericTrainerHikerMarcos:
	generictrainer HIKER, MARCOS, EVENT_BEAT_HIKER_MARCOS, HikerMarcosSeenText, HikerMarcosBeatenText

	text "Vor langer Zeit"
	line "wurde ich von"
	cont "einem Kind wie dir"
	cont "besiegt."
	done

MountMoon1FRivalMovementBefore:
	step_down
	step_down
	step_down
	step_down
	turn_head_right
	step_end

MountMoon1FPlayerMovement:
	slow_step_up
	turn_head_down
	step_end

MountMoon1FRivalMovementAfter:
	step_right
	turn_head_down
	step_end

MountMoonRivalTextBefore:
	text "…… …… ……"

	para "Es ist schon lange"
	line "her, <PLAYER>."

	para "…Seit ich gegen"
	line "dich verlor, mache"

	para "ich mir Gedanken,"
	line "was meinen #mon"
	cont "noch fehlt…"

	para "Nun, wir haben"
	line "eine Antwort"
	cont "gefunden."

	para "<PLAYER>, wir"
	line "beweisen es dir!"
	done

MountMoonRivalTextWin:
	text "…… …… ……"

	para "Ich glaubte immer,"
	line "meine #mon so"

	para "aufgezogen zu ha-"
	line "ben, dass sie un-"
	cont "schlagbar seien.…"

	para "…Aber ich"
	line "habe versagt…"
	done

MountMoonRivalTextAfter:
	text "…… …… ……"

	para "…You won, fair"
	line "and square."

	para "I admit it. But"
	line "this isn't the"
	cont "end."

	para "After some more"
	line "training in"
	cont "Dragon's Den…"

	para "I'm going to be"
	line "the greatest #-"
	cont "mon trainer ever."

	para "Because these guys"
	line "are behind me."

	para "…Listen, <PLAYER>."

	para "One of these days"
	line "I'm going to prove"

	para "how good I am by"
	line "beating you."
	done

MountMoonRivalTextLoss:
	text "…… …… ……"

	para "Ich habe meine"
	line "Schuld bei dir"
	cont "abgegolten."

	para "Mit meinen #mon"
	line "werde ich den"

	para "Champ besiegen"
	line "und weltbester"
	cont "Trainer werden."
	done

BugManiacKentaSeenText:
	text "Ich habe hier"
	line "einen rothaarigen"
	cont "Jungen trainieren"
	cont "sehen."

	para "Hast du schon"
	line "gegen ihn"
	cont "gekämpft?"
	done

BugManiacKentaBeatenText:
	text "Du hast mich!"
	done

LassMiriamSeenText:
	text "Als ich jünger"
	line "war, habe ich mich"

	para "hier immer"
	line "verlaufen."
	done

LassMiriamBeatenText:
	text "Oh, ich habe"
	line "verloren!"
	done

SuperNerdJovanSeenText:
	text "Was! Schleich dich"
	line "nicht so an!"
	done

SuperNerdJovanBeatenText:
	text "Meine #mon"
	line "taugen nichts!"
	done

BugManiacRobbySeenText:
	text "Du musst durch"
	line "diese Höhle, um"

	para "nach Azuria City"
	line "zu kommen."
	done

BugManiacRobbyBeatenText:
	text "Ich habe verloren…"
	done

LassIrisSeenText:
	text "Hast du schon"
	line "mal ein Piepi"
	cont "gesehen?"

	para "Die sind so süß!"
	done

LassIrisBeatenText:
	text "Das ging so"
	line "schnell…"
	done

HikerMarcosSeenText:
	text "Kinder wie du"
	line "sollten nicht"

	para "hier im Dunkeln"
	line "herumlaufen."
	done

HikerMarcosBeatenText:
	text "Wow!"
	line "Du bist stark!"
	done
