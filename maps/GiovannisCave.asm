GiovannisCave_MapScriptHeader:
	def_scene_scripts
	scene_script DoNothingScript, SCENE_GIOVANNISCAVE_NOOP
	scene_script GiovannisCavePastBattleScene, SCENE_GIOVANNISCAVE_PAST_GIOVANNI

	def_callbacks

	def_warp_events
	warp_event  5,  7, TOHJO_FALLS, 3

	def_coord_events

	def_bg_events
	bg_event  5,  2, BGEVENT_READ, GiovannisCaveRadioScript
	bg_event  2,  6, BGEVENT_ITEM + BERSERK_GENE, EVENT_GIOVANNIS_CAVE_HIDDEN_BERSERK_GENE

	def_object_events
	object_event  5,  6, SPRITE_CELEBI, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_GIOVANNIS_CAVE_CELEBI
	object_event  4,  5, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_GIOVANNIS_CAVE_LYRA
	object_event  5,  3, SPRITE_GIOVANNI, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_GIOVANNIS_CAVE_GIOVANNI
	smashrock_event  3,  6
	smashrock_event  6,  2

	object_const_def
	const GIOVANNISCAVE_CELEBI
	const GIOVANNISCAVE_LYRA
	const GIOVANNISCAVE_GIOVANNI

GiovannisCavePastBattleScene:
	sdefer .Script
	end

.Script:
	pause 30
	turnobject PLAYER, UP
	turnobject GIOVANNISCAVE_LYRA, UP
	showemote EMOTE_SHOCK, GIOVANNISCAVE_GIOVANNI, 15
	turnobject GIOVANNISCAVE_GIOVANNI, DOWN
	showtext GiovannisCaveGiovanniIntroText
	applyonemovement GIOVANNISCAVE_GIOVANNI, slow_step_down
	showtext GiovannisCaveGiovanniMemoriesText
	turnobject GIOVANNISCAVE_LYRA, RIGHT
	showtext GiovannisCaveLyraQuestionsText
	showemote EMOTE_SHOCK, GIOVANNISCAVE_LYRA, 15
	showtext GiovannisCaveLyraRecognizesGiovanniText
	playmusic MUSIC_ROCKET_OVERTURE
	turnobject GIOVANNISCAVE_LYRA, UP
	turnobject GIOVANNISCAVE_GIOVANNI, UP
	showtext GiovannisCaveBroadcastText
	turnobject GIOVANNISCAVE_GIOVANNI, DOWN
	showtext GiovannisCaveGiovanniIMustGoText
	setmapscene GIOVANNIS_CAVE, SCENE_GIOVANNISCAVE_NOOP
	clearevent EVENT_TIME_TRAVELING
	winlosstext GiovannisCaveGiovanniBeatenText, 0
	setlasttalked GIOVANNISCAVE_GIOVANNI
	loadtrainer GIOVANNI, GIOVANNI2
	startbattle
	reloadmapafterbattle
	setevent EVENT_TIME_TRAVELING
	applymovement GIOVANNISCAVE_GIOVANNI, GiovannisCave_GiovanniStepsBackMovementData
	showtext GiovannisCaveGiovanniAfterText
	applymovement GIOVANNISCAVE_GIOVANNI, GiovannisCave_GiovanniLeavesMovementData
	playsound SFX_ENTER_DOOR
	disappear GIOVANNISCAVE_GIOVANNI
	waitsfx
	turnobject PLAYER, DOWN
	turnobject GIOVANNISCAVE_LYRA, DOWN
	showtext GiovannisCaveBroadcastAfterText
	applyonemovement GIOVANNISCAVE_LYRA, slow_step_down
	showtext GiovannisCaveLyraFeelsSorryText
	playsound SFX_GAME_FREAK_LOGO_GS
	special FadeOutPalettes
	special LoadMapPalettes
	pause 30
	special FadeInPalettes_EnableDynNoApply
	waitsfx
	showemote EMOTE_SHOCK, PLAYER, 15
	applymovement PLAYER, GiovannisCave_PlayerStepsAsideMovementData
	applymovement GIOVANNISCAVE_LYRA, GiovannisCave_LyraLooksAroundMovementData
	showtext GiovannisCaveLyraWantsToLeaveText
	playsound SFX_PROTECT
	applymovement GIOVANNISCAVE_CELEBI, GiovannisCave_CelebiFloatsMovementData
	waitsfx
	playsound SFX_GAME_FREAK_LOGO_GS
	special FadeOutPalettes
	pause 30
	waitsfx
	disappear GIOVANNISCAVE_CELEBI
	disappear GIOVANNISCAVE_LYRA
	warp CINNABAR_LAB, 30, 16
	end

GiovannisCaveRadioScript:
	checkevent EVENT_TIME_TRAVEL_FINISHED
	iftrue_jumptext GiovannisCaveRadioAfterTimeTravelText
	jumpthistext

	text "Hier steht ein"
	line "Radio, das nicht"
	cont "mehr funktioniert…"
	done

GiovannisCaveRadioAfterTimeTravelText:
	text "Du kannst das"
	line "Radio nicht ein-"
	cont "schalten."

	para "Giovanni muss es"
	line "hier zurückgelas-"
	cont "sen haben…"
	done

GiovannisCave_GiovanniStepsBackMovementData:
	turn_head_down
	fix_facing
	slow_step_up
	remove_fixed_facing
	slow_step_right
	step_end

GiovannisCave_GiovanniLeavesMovementData:
	step_down
	step_down
	step_down
	step_down
	step_left
	turn_head_down
	step_end

GiovannisCave_PlayerStepsAsideMovementData:
	turn_head_left
	fix_facing
	slow_step_right
	remove_fixed_facing
	step_end

GiovannisCave_LyraLooksAroundMovementData:
	turn_head_left
	step_sleep_8
	step_sleep_8
	step_sleep_8
	turn_head_right
	step_end

GiovannisCave_CelebiFloatsMovementData:
	turn_head_down
	fix_facing
	slow_step_up
	slow_step_up
	slow_step_up
	remove_fixed_facing
	step_end

GiovannisCaveGiovanniIntroText:
	text "…"

	para "Ich weiß nicht,"
	line "warum ihr hier"

	para "seid, aber ich"
	line "muss euch warnen:"
	cont "Das ist kein Ort"
	cont "für Kinder wie"
	cont "euch."

	para "Lyra: Hä? Das ist"
	line "doch der Typ, den"

	para "wir eben mit dem"
	line "Jungen streiten"
	cont "gesehen haben!"
	done

GiovannisCaveGiovanniMemoriesText:
	text "Du hast einen ge-"
	line "wissen Blick…"

	para "Ich erinnere mich"
	line "an dich!"

	para "Dieses Kind vor"
	line "drei Jahren hat"
	cont "ständig unsere"
	cont "Pläne durchkreuzt,"

	para "aber du hast uns"
	line "die ganzen Pro-"
	cont "bleme überhaupt"
	cont "erst eingebrockt!"

	para "…"

	para "Ich bin auf dem"
	line "Weg nach Dukatia"

	para "City, um dem Ruf"
	line "zu folgen und"
	cont "mich meinem Team"
	cont "anzuschließen."

	para "Wirst du mir wie-"
	line "der in die Quere"
	cont "kommen?"
	done

GiovannisCaveLyraQuestionsText:
	text "Lyra: Vor drei"
	line "Jahren…? Dukatia"
	cont "City…?"
	done

GiovannisCaveLyraRecognizesGiovanniText:
	text "Das ist der, den"
	line "Team Rocket er-"
	cont "reichen wollte!"

	para "Ihr Boss,"
	line "Giovanni!"

	para "<PLAYER>, wann hast"
	line "du Giovanni schon"
	cont "mal getroffen…?"
	done

GiovannisCaveBroadcastText:
	text "“… …Ähm, wir sind"
	line "Team Rocket!"
	cont "Nach drei Jahren"
	cont "Vorbereitung sind"
	cont "wir aus der Asche"
	cont "auferstanden!"
	cont "Giovanni! Hörst"
	cont "du uns? Geschafft!"
	cont "Wo ist unser Boss?"
	cont "Hört er zu?”"

	para "Lyra: Team Rocket"
	line "hat gerade den"

	para "Radioturm"
	line "besetzt…"

	para "Du bist dort, aber"
	line "du bist auch"
	cont "hier…"
	done

GiovannisCaveGiovanniIMustGoText:
	text "Giovanni: Meine"
	line "alten Gefährten"
	cont "brauchen mich…"

	para "Wir werden das"
	line "Scheitern von vor"
	cont "drei Jahren nicht"
	cont "wiederholen!"

	para "Team Rocket wird"
	line "wiedergeboren!"

	para "Lyra: Ha!"
	line "<PLAYER> hat dich"
	cont "schon aufgehalten!"
	cont "…Wird dich auf-"
	cont "halten."

	para "Wird dich aufge-"
	line "halten haben…?"

	para "…Zeitreisen sind"
	line "echt verwirrend!"

	para "Giovanni: Genug"
	line "geplappert! Geh"
	cont "mir aus dem Weg!"
	done

GiovannisCaveGiovanniBeatenText:
	text "Was in aller Welt"
	line "bist du?"
	done

GiovannisCaveGiovanniAfterText:
	text "Giovanni: Wie ist"
	line "das möglich…?"

	para "Die letzten drei"
	line "Jahre waren"
	cont "umsonst…?"

	para "Wie kann ein Kind"
	line "wie du meinen"

	para "Traum schon wieder"
	line "zerstören?"
	done

GiovannisCaveBroadcastAfterText:
	text "“… …Hey! Wo ist"
	line "Giovanni hin?"
	cont "Ob er wohl unsere"
	cont "Sendung hört?"
	cont "… …”"
	done

GiovannisCaveLyraFeelsSorryText:
	text "Lyra: Sie rufen"
	line "immer wieder nach"
	cont "ihrem Boss."

	para "Sie tun mir leid,"
	line "weil sie nicht"
	cont "wissen, dass er"
	cont "nicht kommt."

	para "Aber in diesem"
	line "Moment besiegst"
	cont "du sie wohl,"
	cont "<PLAYER>!"
	done

GiovannisCaveLyraWantsToLeaveText:
	text "Lyra: Nicht schon"
	line "wieder…! Mir"
	cont "reicht's!"

	para "Bitte bring uns"
	line "zurück in unsere"
	cont "Zeit!"
	done
