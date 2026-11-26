QuietCaveB1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5, 25, QUIET_CAVE_1F, 2
	warp_event 29, 23, QUIET_CAVE_1F, 3
	warp_event 19, 11, QUIET_CAVE_1F, 4
	warp_event  3, 15, QUIET_CAVE_1F, 5
	warp_event 31, 15, QUIET_CAVE_1F, 6
	warp_event 21,  3, QUIET_CAVE_B2F, 1
	warp_event 17, 25, QUIET_CAVE_B2F, 2
	warp_event 23, 33, QUIET_CAVE_B2F, 3
	warp_event 32,  2, QUIET_CAVE_B2F, 4

	def_coord_events

	def_bg_events
	bg_event 26, 33, BGEVENT_ITEM + HYPER_POTION, EVENT_QUIET_CAVE_B1F_HIDDEN_HYPER_POTION

	def_object_events
	object_event  6, 20, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, QuietCaveB1FNurseKeikoScript, -1
	object_event 25,  4, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBattleGirlKagami, -1
	object_event 21, 17, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerPokemaniacAidan, -1
	object_event 33, 30, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerHikerSteve, -1
	object_event  4,  7, SPRITE_PSYCHIC, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerPsychicVirgil, -1
	itemball_event  8,  3, BIG_PEARL, 1, EVENT_QUIET_CAVE_B1F_BIG_PEARL
	itemball_event 14, 13, ELIXIR, 1, EVENT_QUIET_CAVE_B1F_ELIXIR

	object_const_def
	const QUIETCAVEB1F_NURSE

QuietCaveB1FNurseKeikoScript:
	faceplayer
	checkevent EVENT_BEAT_NURSE_KEIKO
	iftruefwd .Beaten
	showtext .SeenText
	winlosstext .BeatenText, 0
	setlasttalked QUIETCAVEB1F_NURSE
	loadtrainer NURSE, KEIKO
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_NURSE_KEIKO
.Beaten
	showtext .AfterText
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	playmusic MUSIC_HEAL
	special HealParty
	pause 60
	special Special_FadeInQuickly
	special RestartMapMusic
	jumpthistext

	text "See how energetic"
	line "your #mon are!"
	done

.SeenText:
	text "You need a Nurse's"
	line "help?"

	para "Sure, if you can"
	line "win against me,"
	cont "I'll heal you!"
	done

.BeatenText:
	text "Do you really"
	line "need healing?"
	done

.AfterText:
	text "Also gut… Zeit,"
	line "deinen #mon"
	cont "etwas Energie zu"
	cont "geben!"
	done

GenericTrainerBattleGirlKagami:
	generictrainer BATTLE_GIRL, KAGAMI, EVENT_BEAT_BATTLE_GIRL_KAGAMI, BattleGirlKagamiSeenText, BattleGirlKagamiBeatenText

	text "Ich komme her, um"
	line "in Ruhe und Ein-"
	cont "samkeit zu"
	cont "trainieren."
	done

GenericTrainerPokemaniacAidan:
	generictrainer POKEMANIAC, AIDAN, EVENT_BEAT_POKEMANIAC_AIDAN, PokemaniacAidanSeenText, PokemaniacAidanBeatenText

	text "Manchmal kennt ein"
	line "#mon in einem"

	para "bestimmten Gebiet"
	line "eine seltene"
	cont "Attacke."
	done

GenericTrainerHikerSteve:
	generictrainer HIKER, STEVE, EVENT_BEAT_HIKER_STEVE, HikerSteveSeenText, HikerSteveBeatenText

	text "Höhlenforschung"
	line "heißt auch"
	cont "Speläologie."

	para "Dabei erkundet"
	line "man Höhlen!"
	done

GenericTrainerPsychicVirgil:
	generictrainer PSYCHIC_T, VIRGIL, EVENT_BEAT_PSYCHIC_VIRGIL, PsychicVirgilSeenText, PsychicVirgilBeatenText

	text "Die Stille hilft"
	line "mir, meine über-"
	cont "sinnlichen Kräfte"
	cont "zu bündeln."
	done

BattleGirlKagamiSeenText:
	text "Stör mich nicht"
	line "beim Training!"
	done

BattleGirlKagamiBeatenText:
	text "Nicht gut genug…"
	done

PokemaniacAidanSeenText:
	text "Meine #mon!"

	para "Ich zeig sie"
	line "dir!"
	done

PokemaniacAidanBeatenText: ; text > text
	text "Meine #mon…"
	done

HikerSteveSeenText:
	text "Man nennt mich"
	line "Wanderer, aber"
	cont "jetzt bin ich"
	cont "Höhlenforscher!"
	done

HikerSteveBeatenText:
	text "Und jetzt bin ich"
	line "ein Verlierer…"
	done

PsychicVirgilSeenText:
	text "Pst! Sei leise!"
	done

PsychicVirgilBeatenText:
	text "Warum müssen"
	line "Kämpfe so laut"
	cont "sein?"
	done
