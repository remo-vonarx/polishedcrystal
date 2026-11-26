YellowForest_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_YELLOWFOREST_BRIDGE_UNDERFOOT
	scene_const SCENE_YELLOWFOREST_BRIDGE_OVERHEAD

	def_callbacks
	callback MAPCALLBACK_NEWMAP, YellowForestFlyPoint
	callback MAPCALLBACK_TILES, YellowForestTileScript

	def_warp_events
	warp_event 28, 47, YELLOW_FOREST_GATE, 1
	warp_event 29, 47, YELLOW_FOREST_GATE, 2
	warp_event 19, 12, HIDDEN_TREE_GROTTO, 1

	def_coord_events
	coord_event 32, 16, SCENE_YELLOWFOREST_BRIDGE_OVERHEAD, YellowForestBridgeOverheadTrigger
	coord_event 32, 17, SCENE_YELLOWFOREST_BRIDGE_OVERHEAD, YellowForestBridgeOverheadTrigger
	coord_event 39, 16, SCENE_YELLOWFOREST_BRIDGE_OVERHEAD, YellowForestBridgeOverheadTrigger
	coord_event 39, 17, SCENE_YELLOWFOREST_BRIDGE_OVERHEAD, YellowForestBridgeOverheadTrigger
	coord_event 33, 16, SCENE_YELLOWFOREST_BRIDGE_UNDERFOOT, YellowForestBridgeUnderfootTrigger
	coord_event 33, 17, SCENE_YELLOWFOREST_BRIDGE_UNDERFOOT, YellowForestBridgeUnderfootTrigger
	coord_event 38, 16, SCENE_YELLOWFOREST_BRIDGE_UNDERFOOT, YellowForestBridgeUnderfootTrigger
	coord_event 38, 17, SCENE_YELLOWFOREST_BRIDGE_UNDERFOOT, YellowForestBridgeUnderfootTrigger

	def_bg_events
	bg_event 39, 14, BGEVENT_ITEM + BIG_MUSHROOM, EVENT_YELLOW_FOREST_HIDDEN_BIG_MUSHROOM
	bg_event 43, 36, BGEVENT_ITEM + BALMMUSHROOM, EVENT_YELLOW_FOREST_HIDDEN_BALM_MUSHROOM
	bg_event 32, 11, BGEVENT_ITEM + GOLD_LEAF, EVENT_YELLOW_FOREST_HIDDEN_GOLD_LEAF_1
	bg_event  9, 40, BGEVENT_ITEM + GOLD_LEAF, EVENT_YELLOW_FOREST_HIDDEN_GOLD_LEAF_2
	bg_event 19, 11, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_YELLOW_FOREST
	bg_event 20, 11, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_YELLOW_FOREST

	def_object_events
	object_event  7, 24, SPRITE_WALKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 1, YellowForestWalkerScript, EVENT_YELLOW_FOREST_WALKER
	pokemon_event  8, 24, SKARMORY, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_GRAY, ClearText, EVENT_YELLOW_FOREST_SKARMORY
	object_event 47,  6, SPRITE_YELLOW, SPRITEMOVEDATA_WANDER, 1, 2, -1, 0, OBJECTTYPE_SCRIPT, 0, YellowForestYellowScript, -1
	object_event 49, 26, SPRITE_BALL_CUT_TREE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_ENV_BLUE, OBJECTTYPE_SCRIPT, 0, YellowForestSurfPikachuDoll, EVENT_DECO_SURFING_PIKACHU_DOLL
	object_event 31,  8, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, YellowForestSuperNerdText, -1
	object_event 19, 41, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSchoolgirlSarah, -1
	object_event 13, 34, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSchoolgirlIsabel, -1
	object_event  4, 38, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerTeacherKathryn, -1
	object_event 43, 42, SPRITE_BREEDER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBreederSophie, -1
	object_event 15, 18, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, YellowForestCooltrainerMScript, -1
	object_event 42, 32, SPRITE_LILYPAD, SPRITEMOVEDATA_LILYPAD, 0, 0, -1, 0, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 30, 34, SPRITE_LILYPAD, SPRITEMOVEDATA_LILYPAD, 0, 0, -1, 0, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 32, 36, SPRITE_LILYPAD, SPRITEMOVEDATA_LILYPAD, 0, 0, -1, 0, OBJECTTYPE_COMMAND, end, NULL, -1
	tmhmball_event 25, 18, TM_LEECH_LIFE, EVENT_YELLOW_FOREST_TM_LEECH_LIFE
	itemball_event 32, 26, MIRACLE_SEED, 1, EVENT_YELLOW_FOREST_MIRACLE_SEED
	itemball_event 11, 23, BIG_ROOT, 1, EVENT_YELLOW_FOREST_BIG_ROOT
	itemball_event 50, 13, LEMONADE, 1, EVENT_YELLOW_FOREST_LEMONADE

	object_const_def
	const YELLOWFOREST_WALKER
	const YELLOWFOREST_SKARMORY
	const YELLOWFOREST_YELLOW
	const YELLOWFOREST_POKE_BALL5

YellowForestFlyPoint:
	setflag ENGINE_FLYPOINT_YELLOW_FOREST
	endcallback

YellowForestTileScript:
	checkscene
	iftruefwd .underfoot
	callasm YellowForest_OverheadBridgeAsm
	endcallback

.underfoot:
	callasm YellowForest_UnderfootBridgeAsm
	endcallback

YellowForest_OverheadBridgeAsm:
	changebridgeblock 32, 16, $9d, YELLOW_FOREST
	changebridgeblock 34, 16, $9e, YELLOW_FOREST
	changebridgeblock 36, 16, $9e, YELLOW_FOREST
	changebridgeblock 38, 16, $9f, YELLOW_FOREST
	jmp BufferScreen

YellowForest_UnderfootBridgeAsm:
	changebridgeblock 32, 16, $86, YELLOW_FOREST
	changebridgeblock 34, 16, $97, YELLOW_FOREST
	changebridgeblock 36, 16, $97, YELLOW_FOREST
	changebridgeblock 38, 16, $87, YELLOW_FOREST
	jmp BufferScreen

YellowForestBridgeOverheadTrigger:
	callasm YellowForest_OverheadBridgeAsm
	callthisasm
	xor a
	jr YellowForest_FinishBridge

YellowForestBridgeUnderfootTrigger:
	callasm YellowForest_UnderfootBridgeAsm
	callthisasm
	ld a, $1
YellowForest_FinishBridge:
	ld [wWalkingOnBridge], a
	ld [wYellowForestSceneID], a ; setscene a
	jmp GenericFinishBridge

GenericTrainerSchoolgirlSarah:
	generictrainer SCHOOLGIRL, SARAH, EVENT_BEAT_SCHOOLGIRL_SARAH, SchoolgirlSarahSeenText, SchoolgirlSarahBeatenText

	text "Wären wir an"
	line "meiner Schule,"
	cont "hätte ich dich"
	cont "besiegt!"
	done

GenericTrainerSchoolgirlIsabel:
	generictrainer SCHOOLGIRL, ISABEL, EVENT_BEAT_SCHOOLGIRL_ISABEL, SchoolgirlIsabelSeenText, SchoolgirlIsabelBeatenText

	text "Wir lernen, wie"
	line "#mon in der"

	para "Wildnis zusammen"
	line "gedeihen."
	done

GenericTrainerTeacherKathryn:
	generictrainer TEACHER_F, KATHRYN, EVENT_BEAT_TEACHER_KATHRYN, TeacherKathrynSeenText, TeacherKathrynBeatenText

	text "Bei einem Ausflug"
	line "alle im Auge zu"

	para "behalten, ist"
	line "harte Arbeit."
	done

GenericTrainerBreederSophie:
	generictrainer BREEDER, SOPHIE, EVENT_BEAT_BREEDER_SOPHIE, BreederSophieSeenText, BreederSophieBeatenText

	text "Manchmal beleben"
	line "Pikachu mit ihren"

	para "Stromstößen be-"
	line "siegte Artgenossen"
	cont "wieder."

	para "Das ist so süß!"
	done

YellowForestWalkerScript:
	showtextfaceplayer YellowForestWalkerSeenText
	winlosstext YellowForestWalkerBeatenText, 0
	setlasttalked YELLOWFOREST_WALKER
	loadtrainer WALKER, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_WALKER
	opentext
	writetext YellowForestWalkerAfterText
	promptbutton
	verbosegivetmhm HM_FLY
	setevent EVENT_GOT_HM02_FLY
	writetext YellowForestWalkerFinalText
	waitbutton
	closetext
	appear YELLOWFOREST_SKARMORY
	playsound SFX_BALL_POOF
	turnobject YELLOWFOREST_WALKER, RIGHT
	waitsfx
	pause 15
	cry SKARMORY
	waitsfx
	turnobject YELLOWFOREST_WALKER, DOWN
	showtext YellowForestWalkerFlyText
	playsound SFX_FLY
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear YELLOWFOREST_WALKER
	disappear YELLOWFOREST_SKARMORY
	waitsfx
	pause 15
	special Special_FadeInQuickly
	end

YellowForestYellowScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_YELLOW
	iffalsefwd YellowForestYellowBattleScript
	checkevent EVENT_GOT_LIGHT_BALL_FROM_YELLOW
	iffalsefwd YellowBattleAfterBallScript
	jumpopenedtext YellowForestYellowGoodbyeText

YellowForestYellowBattleScript:
	writetext YellowForestYellowGreetingText
	waitbutton
	closetext
	winlosstext YellowForestYellowWinLossText, 0
	setlasttalked YELLOWFOREST_YELLOW
	loadtrainer YELLOW, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_YELLOW
	checkevent EVENT_GOT_A_POKEMON_FROM_IVY
	iffalsefwd .skip
	clearevent EVENT_INDIGO_PLATEAU_POKECENTER_YELLOW
.skip
	opentext
	writetext YellowForestYellowAfterText
	scall YellowTryGiveLightBallScript
	end

YellowBattleAfterBallScript:
	faceplayer
	opentext
	writetext YellowForestYellowAfterText
YellowTryGiveLightBallScript:
	promptbutton
	verbosegiveitem LIGHT_BALL, iffalsefwd NoRoomForLightBallScript
	setevent EVENT_GOT_LIGHT_BALL_FROM_YELLOW
	writetext YellowForestYellowGoodbyeText
	waitbutton
NoRoomForLightBallScript:
	endtext

YellowForestCooltrainerMScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_SEED_BOMB_INTRO
	iftruefwd YellowForestTutorSeedBombScript
	writetext YellowForestCooltrainerMText
	waitbutton
	setevent EVENT_LISTENED_TO_SEED_BOMB_INTRO
YellowForestTutorSeedBombScript:
	writetext Text_YellowForestTutorSeedBomb
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writetext Text_YellowForestTutorQuestion
	yesorno
	iffalsefwd .TutorRefused
	setval SEED_BOMB
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpthisopenedtext

	text "Sprich mich an,"
	line "wenn du deine"
	cont "Meinung änderst!"
	done

.NoSilverLeaf
	jumpthisopenedtext

	text "Och, du hast kein"
	line "Silberblatt."
	done

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext

	text "Jetzt beherrscht"
	line "dein #mon"
	cont "Samenbomben!"
	done

YellowForestSurfPikachuDoll:
	disappear YELLOWFOREST_POKE_BALL5
	setevent EVENT_DECO_SURFING_PIKACHU_DOLL
	opentext
	writetext YellowForestSurfPikachuDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	jumpthisopenedtext

	text "Surfer Pikachu-"
	line "Puppe wurde nach"
	cont "Hause geschickt."
	done

SchoolgirlSarahSeenText:
	text "Ooh, ein Trainer!"
	line "Ich will kämpfen!"
	done

SchoolgirlSarahBeatenText:
	text "Schnief…"
	line "Wegen dir habe"
	cont "ich verloren!"
	done

SchoolgirlIsabelSeenText:
	text "Hast du auch so"
	line "süße #mon wie"
	cont "die hier?"
	done

SchoolgirlIsabelBeatenText:
	text "Du hast richtig"
	line "starke #mon!"
	done

TeacherKathrynSeenText:
	text "Du da!"
	line "Bist du Trainer?"

	para "Bring meine"
	line "Schüler bloß nicht"
	cont "zum Weinen!"
	done

TeacherKathrynBeatenText:
	text "Deswegen weine"
	line "ich nicht…"
	done

BreederSophieSeenText:
	text "Wusstest du, dass"
	line "Pikachu ein ent-"
	cont "wickeltes #mon"
	cont "ist?"
	done

BreederSophieBeatenText:
	text "Dachte ich mir!"
	done

YellowForestWalkerSeenText:
	text "Hallo! Ich heiße"
	line "Luc."

	para "Ich war einst der"
	line "Arenaleiter von"

	para "Viola City, aber"
	line "das habe ich mei-"
	cont "nem Sohn über-"
	cont "lassen."

	para "Jetzt wandere ich"
	line "durch Johto und"

	para "genieße die"
	line "Sehenswürdig-"
	cont "keiten."

	para "Luc: Du sammelst"
	line "Orden, was?"

	para "Dann hat mein Sohn"
	line "gegen dich"
	cont "verloren!"

	para "Jetzt will ich"
	line "dein Können"
	cont "selbst testen."

	para "Ich habe keinen"
	line "Orden, aber du"

	para "bekommst etwas"
	line "Schönes, wenn du"
	cont "gewinnst!"
	done

YellowForestWalkerBeatenText:
	text "Meine Vogel-"
	line "#mon… Besiegt!"
	done

YellowForestWalkerAfterText:
	text "Luc: Nun, ich ver-"
	line "stehe, warum du"

	para "gegen Falk gewon-"
	line "nen hast."

	para "Du kennst deine"
	line "#mon in- und"
	cont "auswendig!"

	para "Diese VM hast du"
	line "dir verdient."
	done

YellowForestWalkerFinalText:
	text "Luc: Vogel-#mon"
	line "fliegen durch die"

	para "Lüfte, weil sie"
	line "das von ganzem"
	cont "Herzen wollen."

	para "Wenn du dir etwas"
	line "so sehr wünschst,"

	para "weiß ich, dass du"
	line "es erreichen"
	cont "kannst."

	para "Was ich will, ist"
	line "weiterzuwandern."

	para "Leb wohl!"
	done

YellowForestWalkerFlyText:
	text "Panzaeron, los,"
	line "Fliegen!"
	done

YellowForestYellowGreetingText:
	text "Gelb: Hi! Ich bin"
	line "Gelb!"

	para "Dieser Wald voller"
	line "Pikachu…"

	para "Er erinnert mich"
	line "an mein Zuhause in"
	cont "Kanto."

	para "Wo ich mein erstes"
	line "#mon gefangen"
	cont "habe."

	para "Der Trainer, der"
	line "mir dabei half,"
	cont "sagte mir etwas."

	para "Wenn du dich von"
	line "ganzem Herzen um"

	para "#mon kümmerst,"
	line "bleiben sie immer"
	cont "deine Freunde!"

	para "Ich spüre, dass"
	line "dir deine #mon"

	para "am Herzen liegen."
	line "Also lass mich"

	para "sehen, was deine"
	line "Freunde können!"
	done

YellowForestYellowWinLossText:
	text "Haha! Was für ein"
	line "Kampf!"
	done

YellowForestYellowAfterText:
	text "Gelb: Wow!"
	line "Du bist echt ein"

	para "guter Trainer."
	line "Hier ist etwas,"

	para "das deine Freunde"
	line "zu schätzen"
	cont "wissen!"
	done

YellowForestYellowGoodbyeText:
	text "Gelb: Gib diesen"
	line "Kugelblitz einem"

	para "Pikachu, um seine"
	line "Kraft zu steigern."
	done

YellowForestCooltrainerMText:
	text "Samen sind überra-"
	line "schend mächtig."

	para "Über viele Jahre"
	line "kann ein kleiner"

	para "Samen zu einem"
	line "riesigen Baum"
	cont "wachsen."

	para "Und ein großer"
	line "Samen kann einfach"
	cont "herunterfallen und"
	cont "dich treffen!"
	done

Text_YellowForestTutorSeedBomb:
	text "Ich bringe deinen"
	line "#mon für ein"

	para "Silberblatt"
	line "Samenbomben bei."
	done


Text_YellowForestTutorQuestion:
	text "Soll ich deinem"
	line "#mon"
	cont "Samenbomben"
	cont "beibringen?"
	done



YellowForestSuperNerdText:
	text "In deinem Körper"
	line "gibt es ein"
	cont "Protein namens"
	cont "Pikachurin."

	para "Was hat diesen"
	line "Namen inspiriert?"

	para "Pikachu"
	line "natürlich!"
	done

YellowForestSurfPikachuDollText:
	text "<PLAYER> findet"
	line "Surfer Pikachu-"
	cont "Puppe."
	done
