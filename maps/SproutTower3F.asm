SproutTower3F_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_SPROUTTOWER3F_RIVAL_ENCOUNTER
	scene_const SCENE_SPROUTTOWER3F_NOOP

	def_callbacks

	def_warp_events
	warp_event  8, 14, SPROUT_TOWER_2F, 4

	def_coord_events
	coord_event  9,  9, SCENE_SPROUTTOWER3F_RIVAL_ENCOUNTER, SproutTower3FRivalScene

	def_bg_events
	bg_event  6,  1, BGEVENT_JUMPTEXT, SproutTower3FStatueText
	bg_event  9,  1, BGEVENT_JUMPTEXT, SproutTower3FStatueText
	bg_event  7,  0, BGEVENT_JUMPTEXT, SproutTower3FPaintingText
	bg_event  8,  0, BGEVENT_JUMPTEXT, SproutTower3FPaintingText
	bg_event  3, 15, BGEVENT_JUMPTEXT, SproutTower3FStatueText
	bg_event 12, 15, BGEVENT_JUMPTEXT, SproutTower3FStatueText

	def_object_events
	object_event  8,  4, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_SPROUT_TOWER
	object_event  6, 13, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSageJin, -1
	object_event  6,  8, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSageTroy, -1
	object_event  9, 11, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSageNeal, -1
	object_event  8,  2, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ElderLiScript, -1
	itemball_event  4, 14, POTION, 1, EVENT_SPROUT_TOWER_3F_POTION
	itemball_event 12,  1, ESCAPE_ROPE, 1, EVENT_SPROUT_TOWER_3F_ESCAPE_ROPE

	object_const_def
	const SPROUTTOWER3F_RIVAL

SproutTower3FRivalScene:
	turnobject PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	playsound SFX_TACKLE
	earthquake 79
	pause 15
	playsound SFX_TACKLE
	earthquake 79
	applymovement PLAYER, SproutTower3FPlayerApproachesRivalMovement
	applyonemovement SPROUTTOWER3F_RIVAL, step_up
	showtext SproutTowerElderLecturesRivalText
	showemote EMOTE_SHOCK, SPROUTTOWER3F_RIVAL, 15
	turnobject SPROUTTOWER3F_RIVAL, DOWN
	pause 15
	applymovement SPROUTTOWER3F_RIVAL, SproutTower3FRivalLeavesElderMovement
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext SproutTowerRivalOnlyCareAboutStrongText
	turnobject SPROUTTOWER3F_RIVAL, UP
	opentext
	writetext SproutTowerRivalUsedEscapeRopeText
	pause 15
	closetext
	playsound SFX_WARP_TO
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear SPROUTTOWER3F_RIVAL
	waitsfx
	special Special_FadeInQuickly
	setscene SCENE_SPROUTTOWER3F_NOOP
	special RestartMapMusic
	end

ElderLiScript:
	checkevent EVENT_GOT_TM70_FLASH
	iftrue_jumptextfaceplayer SageLiAfterBattleText
	faceplayer
	showtext SageLiSeenText
	winlosstext SageLiBeatenText, 0
	loadtrainer ELDER, LI
	startbattle
	reloadmapafterbattle
	opentext
	writetext SageLiTakeThisFlashText
	promptbutton
	verbosegivetmhm TM_FLASH
	setevent EVENT_GOT_TM70_FLASH
	setevent EVENT_BEAT_ELDER_LI
	jumpthisopenedtext

	text "Flash illuminates"
	line "even the darkest"
	cont "of all places."

	para "You need not teach"
	line "it to your #mon"

	para "unless you wish"
	line "to use Flash in"
	cont "battle."

	para "Simply press A in"
	line "the darkness, and"

	para "if any of your"
	line "#mon can use"
	cont "Flash, they will."
	done

GenericTrainerSageJin:
	generictrainer SAGE, JIN, EVENT_BEAT_SAGE_JIN, SageJinSeenText, SageJinBeatenText

	text "Je stärker die"
	line "#mon werden,"
	cont "desto stärker wird"
	cont "auch ihr Trainer."

	para "Nein, warte! Je"
	line "stärker der Trai-"
	cont "ner wird, desto"
	cont "stärker werden"
	cont "auch die #mon."
	done

GenericTrainerSageTroy:
	generictrainer SAGE, TROY, EVENT_BEAT_SAGE_TROY, SageTroySeenText, SageTroyBeatenText

	text "Du triffst bald"
	line "auf den Weisen."
	done

GenericTrainerSageNeal:
	generictrainer SAGE, NEAL, EVENT_BEAT_SAGE_NEAL, SageNealSeenText, SageNealBeatenText

	text "Möge dein Weg"
	line "erleuchtet sein."
	done

SproutTower3FPlayerApproachesRivalMovement:
	step_up
	step_up
	step_up
	step_up
	step_end

SproutTower3FRivalLeavesElderMovement:
	step_right
	step_down
	step_end

SproutTowerElderLecturesRivalText:
	text "Elder: You are in-"
	line "deed skilled as a"
	cont "trainer."

	para "As promised, here"
	line "is your TM."

	para "But let me say"
	line "this: You should"

	para "treat your"
	line "#mon better."

	para "The way you battle"
	line "is far too harsh."

	para "#mon are not"
	line "tools of war…"
	done

SproutTowerRivalOnlyCareAboutStrongText:
	text "…"
	line "…Hmpf!"

	para "Er behauptet,"
	line "ein Weiser zu"
	cont "sein. Aber er ist"
	cont "schwach."

	para "Das muss noch"
	line "geklärt werden."

	para "Ich würde nie ge-"
	line "gen so einen Nar-"
	cont "ren verlieren, der"

	para "mir rät, meine"
	line "#mon gut zu"
	cont "behandeln."

	para "Für mich zählen"
	line "nur starke"
	cont "#mon."

	para "Schwache #mon"
	line "interessieren mich"
	cont "gar nicht."
	done

SproutTowerRivalUsedEscapeRopeText:
	text "<RIVAL> benutzt"
	line "Fluchtseil!"
	done

SageLiSeenText:
	text "Schön, dass du"
	line "gekommen bist!"

	para "Der Knofensa-Turm"
	line "ist eine"

	para "Trainingsstätte."
	line "Trainer und"

	para "#mon prüfen"
	line "ihre Freundschaft,"

	para "um gemeinsam eine"
	line "rosige Zukunft"

	para "aufzubauen."
	line "Und ich bin der"

	para "letzte Test."
	line "Erlaube, dass ich"

	para "die Freundschaft"
	line "zwischen dir und"

	para "deinen #mon"
	line "überprüfe!"
	done

SageLiBeatenText:
	text "Ah, sehr gut!"
	done

SageLiTakeThisFlashText:
	text "You and your #-"
	line "mon should have"

	para "no problem using"
	line "this move."

	para "Take this Flash"
	line "TM."
	done

SageLiAfterBattleText:
	text "Ich hoffe, du"
	line "lernst viel auf"
	cont "deiner Reise."
	done

SageJinSeenText:
	text "Ich trainiere, um"
	line "durch #mon die"
	cont "Erleuchtung"
	cont "zu finden!"
	done

SageJinBeatenText:
	text "Mein Training ist"
	line "unvollständig…"
	done

SageTroySeenText:
	text "Ich will sehen,"
	line "wie sehr du deinen"
	cont "#mon vertraust."
	done

SageTroyBeatenText:
	text "Ja, du vertraust"
	line "ihnen wirklich!"
	done

SageNealSeenText:
	text "The Elder's TM"
	line "lights even pitch-"
	cont "black darkness."
	done

SageNealBeatenText:
	text "Denken ist eben"
	line "meine Stärke!"
	done

SproutTower3FPaintingText:
	text "Dies ist ein dy-"
	line "namisches Gemälde"
	cont "von Knofensa."
	done

SproutTower3FStatueText:
	text "Eine PKMN-Statue…"

	para "Sie sieht sehr"
	line "erhaben aus."
	done
