SeafoamGym_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 12, 20, SEAFOAM_ISLANDS_1F, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event 10, 20, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SeafoamGymGuyScript, EVENT_SEAFOAM_GYM_GYM_GUY
	object_event  7, 16, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerScientistLowell, -1
	object_event 14, 14, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerScientistDennett, -1
	object_event 19, 12, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSupernerdCary, -1
	object_event 12,  7, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_DARK_BLUE, OBJECTTYPE_TRAINER, 1, TrainerScientistLinden, -1
	object_event 10,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSupernerdWaldo, -1
	object_event  6, 14, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSupernerdMerle, -1
	object_event 12, 11, SPRITE_BLAINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamGymBlaineScript, -1

	object_const_def
	const SEAFOAMGYM_GYM_GUY

GenericTrainerScientistLowell:
	generictrainer SCIENTIST, LOWELL, EVENT_BEAT_SCIENTIST_LOWELL, ScientistLowellSeenText, ScientistLowellBeatenText

	text "Wir sind zwar in"
	line "einer Höhle, aber"
	cont "wir waschen immer"
	cont "Wäsche."
	done

GenericTrainerScientistDennett:
	generictrainer SCIENTIST, DENNETT, EVENT_BEAT_SCIENTIST_DENNETT, ScientistDennettSeenText, ScientistDennettBeatenText

	text "Zusammen mit Pyro"
	line "bauen wir unsere"
	cont "Arena wieder auf!"
	done

GenericTrainerSupernerdCary:
	generictrainer SUPER_NERD, CARY, EVENT_BEAT_SUPER_NERD_CARY, SupernerdCarySeenText, SupernerdCaryBeatenText

	text "Bitterkeit führt"
	line "zu Verbesserung."
	done

TrainerScientistLinden:
	trainer SCIENTIST, LINDEN, EVENT_BEAT_SCIENTIST_LINDEN, ScientistLindenSeenText, ScientistLindenBeatenText, 0, .Script, TRAINERPAL_DARK_SCIENTIST

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Nicht alle For-"
	line "scher helfen den"
	cont "Bösen."
	done

GenericTrainerSupernerdWaldo:
	generictrainer SUPER_NERD, WALDO, EVENT_BEAT_SUPER_NERD_WALDO, SupernerdWaldoSeenText, SupernerdWaldoBeatenText

	text "Wer in aller Welt"
	line "bist du?"
	done

GenericTrainerSupernerdMerle:
	generictrainer SUPER_NERD, MERLE, EVENT_BEAT_SUPER_NERD_MERLE, SupernerdMerleSeenText, SupernerdMerleBeatenText

	text "Ich habe nicht"
	line "gespürt, wie stark"
	cont "du bist."
	done

SeafoamGymBlaineScript:
	faceplayer
	opentext
	checkflag ENGINE_VOLCANOBADGE
	iftruefwd .FightDone
	writetext BlaineIntroText
	waitbutton
	closetext
	winlosstext BlaineWinLossText, 0
	loadtrainer BLAINE, 1
	startbattle
	reloadmapafterbattle
	iftruefwd .ReturnAfterBattle
	appear SEAFOAMGYM_GYM_GUY
.ReturnAfterBattle:
	setevent EVENT_BEAT_BLAINE
	setevent EVENT_BEAT_SCIENTIST_LOWELL
	setevent EVENT_BEAT_SCIENTIST_DENNETT
	setevent EVENT_BEAT_SUPER_NERD_CARY
	setevent EVENT_BEAT_SCIENTIST_LINDEN
	setevent EVENT_BEAT_SUPER_NERD_WALDO
	setevent EVENT_BEAT_SUPER_NERD_MERLE
	opentext
	givebadge VOLCANOBADGE, KANTO_REGION
	callstd kantopostgymevents
.FightDone:
	checkevent EVENT_GOT_TM61_WILL_O_WISP
	iftrue_jumpopenedtext BlaineFightDoneText
	writetext BlaineAfterBattleText
	promptbutton
	verbosegivetmhm TM_WILL_O_WISP
	setevent EVENT_GOT_TM61_WILL_O_WISP
	jumpthisopenedtext

	text "It's called Will-"
	line "O-Wisp!"

	para "It weakens your"
	line "foe by inflicting"
	cont "a burn."

	para "I did lose this"
	line "time, but I'm going"
	cont "to win next time."

	para "When I rebuild my"
	line "Cinnabar Gym,"

	para "we'll have to have"
	line "a rematch."
	done

SeafoamGymGuyScript:
	checkevent EVENT_TALKED_TO_SEAFOAM_GYM_GUY_ONCE
	iftrue_jumptextfaceplayer SeafoamGymGuyWinText2
	setevent EVENT_TALKED_TO_SEAFOAM_GYM_GUY_ONCE
	jumpthistextfaceplayer

	text "Yo!"

	para "…Huh? It's over"
	line "already?"

	para "Sorry, sorry!"

	para "Cinnabar Gym was"
	line "gone, so I didn't"

	para "know where to find"
	line "you."

	para "But, hey, you're"
	line "plenty strong even"

	para "without my advice."
	line "I knew you'd win!"
	done

ScientistLowellSeenText:
	text "In diesem Labor-"
	line "kittel fühle ich"
	cont "mich irgendwie"
	cont "klüger."
	done

ScientistLowellBeatenText:
	text "Ein weißer Labor-"
	line "kittel ist das"
	cont "Leben eines"
	cont "Forschers."
	done

ScientistDennettSeenText:
	text "Pyro hat zwar"
	line "seine Arena ver-"
	cont "loren, aber er"
	cont "gibt niemals auf!"
	done

ScientistDennettBeatenText:
	text "Pyros Ausdauer"
	line "motiviert mich!"
	done

SupernerdCarySeenText:
	text "Wow, eine Arena"
	line "in so einer Höhle?"

	para "Die würde ich gern"
	line "erkunden."
	done

SupernerdCaryBeatenText:
	text "Eine bittere"
	line "Niederlage…"
	done

ScientistLindenSeenText:
	text "Wir haben die"
	line "Arena auf der"
	cont "Zinnoberinsel"
	cont "verloren, aber wir"
	cont "kamen hierher."
	done

ScientistLindenBeatenText:
	text "Wir nehmen die"
	line "Niederlage mit"
	cont "Würde hin…"
	done

SupernerdWaldoSeenText:
	text "Ich sammle"
	line "Kampfdaten."

	para "Kannst du mir"
	line "helfen?"
	done

SupernerdWaldoBeatenText:
	text "Ich hätte nicht"
	line "gedacht, dass du"
	cont "so gut bist!"
	done

SupernerdMerleSeenText:
	text "Ooh!"
	line "Du siehst leicht"
	cont "zu besiegen aus!"
	done

SupernerdMerleBeatenText:
	text "Verzeihung!"
	done

BlaineIntroText:
	text "Pyro: Wuah!"

	para "Meine PKMN-Arena"
	line "auf der Zinnober-"
	cont "insel ist abge-"
	cont "brannt. Meine"

	para "Feuer-#mon und"
	line "ich sind wegen des"

	para "Vulkanausbruchs"
	line "obdachlos."

	para "Buah!"

	para "Aber ich führe"
	line "meine Tätigkeit"

	para "als Arenaleiter in"
	line "dieser Höhle"
	cont "weiter aus."

	para "Wenn du mich"
	line "besiegst, bekommst"
	cont "du einen Orden."

	para "Es wäre besser,"
	line "du hast"
	cont "Feuerheiler!"
	done

BlaineWinLossText:
	text "Pyro: Gut gemacht."
	line "Ich bin"
	cont "ausgebrannt…"

	para "Hier nimm den"
	line "Vulkanorden!"
	done

BlaineAfterBattleText:
	text "Hier, das gebe ich"
	line "dir auch noch."
	done

BlaineFightDoneText:
	text "Pyro: Meine Feuer-"
	line "#mon werden"

	para "noch stärker sein."
	line "Du wirst schon"
	cont "sehen!"
	done

SeafoamGymGuyWinText2:
	text "Eine PKMN-Arena"
	line "kann überall sein,"

	para "solange der Arena-"
	line "leiter dort ist."

	para "Man braucht dafür"
	line "kein Gebäude."
	done
