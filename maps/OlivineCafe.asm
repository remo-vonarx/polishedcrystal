OlivineCafe_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  7, OLIVINE_CITY, 6
	warp_event  5,  7, OLIVINE_CITY, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  6,  2, SPRITE_BAKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCafeStrengthSailorScript, -1
	object_event  4,  4, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCafeLyraScript, EVENT_GOT_AMULET_COIN_FROM_LYRA
	object_event  9,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCafeFishingGuruText, -1
	object_event  9,  6, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCafeSailorText, -1
	object_event  7,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, (1 << MORN), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCafeOfficerText, -1
	object_event  7,  4, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, (1 << DAY), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCafeYoungsterText, -1
	object_event  3,  2, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCafeFisherText, -1

	object_const_def
	const OLIVINECAFE_BAKER
	const OLIVINECAFE_LYRA

OlivineCafeStrengthSailorScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_BAKER_CHELSIE
	iftrue_jumpopenedtext BakerChelsieAfterText
	writetext BakerChelsieGreetingText
	yesorno
	iffalse_jumpopenedtext BakerChelsieNoBattleText
	writetext BakerChelsieSeenText
	waitbutton
	closetext
	winlosstext BakerChelsieBeatenText, 0
	setlasttalked OLIVINECAFE_BAKER
	loadtrainer BAKER, CHELSIE
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BAKER_CHELSIE
	opentext
	jumpthisopenedtext

BakerChelsieAfterText:
	text "Ich gebe immer"
	line "Vitamine in mein"
	cont "Brot."

	para "Sie machen meine"
	line "#mon stärker."
	done

OlivineCafeLyraScript:
	faceplayer
	opentext
	writetext OlivineCafeLyraText1
	promptbutton
	verbosegiveitem AMULET_COIN, iffalse_endtext
	writetext OlivineCafeLyraText2
	waitbutton
	closetext
	readvar VAR_FACING
	ifnotequal UP, .GoStraightDown
	applyonemovement OLIVINECAFE_LYRA, step_right
.GoStraightDown
	applymovement OLIVINECAFE_LYRA, OlivineCafeMovementData_LyraLeaves
	playsound SFX_EXIT_BUILDING
	disappear OLIVINECAFE_LYRA
	setevent EVENT_GOT_AMULET_COIN_FROM_LYRA
	waitsfx
	end

OlivineCafeMovementData_LyraLeaves:
	step_down
	step_down
	step_down
	step_end

OlivineCafeFishingGuruText:
	text "Im Oliviana City-"
	line "Cafe gibt es nur"

	para "delikate Seemanns-"
	line "kost für Matrosen"

	para "auf dem"
	line "Speiseplan!"
	done

OlivineCafeSailorText:
	text "Immer wenn ich in"
	line "diese Stadt komme,"

	para "gehe ich ins"
	line "Oliviana City-"
	cont "Cafe."

	para "Jedes Gericht auf"
	line "der Karte stärkt"

	para "mich. Ich kann"
	line "nicht aufhören zu"
	cont "essen!"
	done

BakerChelsieGreetingText:
	text "Meine #mon"
	line "gehen auf wie"
	cont "Hefeteig!"

	para "Ich habe sie mit"
	line "meinem Spezial-"
	cont "Hefebrot groß-"
	cont "gezogen!"

	para "Willst du gegen"
	line "sie kämpfen?"
	done

BakerChelsieSeenText:
	text "Du wirst sehen,"
	line "was mein Brot"
	cont "kann!"
	done

BakerChelsieBeatenText:
	text "Du bist stark."
	line "Isst du etwa mein"
	cont "Spezialbrot?"
	done

BakerChelsieNoBattleText:
	text "Meine mit Brot"
	line "großgezogenen"
	cont "#mon sind un-"
	cont "schlagbar!"
	done

OlivineCafeLyraText1:
	text "Lyra: Hi, <PLAYER>!"
	line "Probier mal das"

	para "Essen hier. Es ist"
	line "richtig lecker!"

	para "Aber ich will"
	line "nicht zu viel"
	cont "essen…"

	para "Ach ja, genau! Ich"
	line "habe ein Item"

	para "gefunden, das dir"
	line "gefallen könnte."
	cont "Hier!"
	done

OlivineCafeLyraText2:
	text "Ist es nicht"
	line "hübsch? Und auch"
	cont "nützlich."

	para "Tja, ich sollte"
	line "mal los."

	para "Ich will den Gold-"
	line "gelben Wald bei"

	para "Anemonia City"
	line "sehen, bevor ich"
	cont "heimkehre."

	para "Bis dann,"
	line "<PLAYER>!"
	done

OlivineCafeOfficerText:
	text "Ich weiß, das ist"
	line "ein Klischee, aber"

	para "ich komme immer"
	line "wegen der Donuts"
	cont "hierher."

	para "Ich kann nicht"
	line "genug kriegen!"
	done

OlivineCafeYoungsterText:
	text "Diese Donuts sind"
	line "super."

	para "Die mit Marmela-"
	line "denfüllung mag ich"
	cont "am liebsten!"

	para "Nichts geht über"
	line "einen Donut mit"
	cont "Marmelade."
	done

OlivineCafeFisherText:
	text "Ich würde ja"
	line "joggen gehen, aber"

	para "ich will meine"
	line "Figur nicht"
	cont "ruinieren."
	done
