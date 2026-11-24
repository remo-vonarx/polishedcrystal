BlackthornPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, BLACKTHORN_CITY, 5
	warp_event  6,  7, BLACKTHORN_CITY, 5
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalClairScript

	def_object_events
	pc_nurse_event  5, 1
	object_event  8,  1, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ProfOaksAide4Script, -1
	object_event 11,  6, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumpstd, happinesschecknpc, -1
	object_event  8,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BlackthornPokeCenter1FGentlemanText, -1
	object_event  1,  4, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, BlackthornPokeCenter1FTwinText, -1

PokemonJournalClairScript:
	setflag ENGINE_READ_CLAIR_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Special Feature:"
	line "Leader Clair!"

	para "Clair's bright blue"
	line "outfit and cape"

	para "have made her the"
	line "latest name in"
	cont "fashion."
	done

ProfOaksAide4Script:
	checkevent EVENT_GOT_LUCKY_EGG_FROM_PROF_OAKS_AIDE
	iftrue_jumptextfaceplayer .ExplainText
	faceplayer
	opentext
	writetext .HiText
	waitbutton
	setval16 60
	special CountCaught
	iftruefwd .HereYouGo
	jumpthisopenedtext

	text "Let's see…"
	line "Uh-oh! You've only"

	para "caught "
	text_decimal wTempDexOwn, 2, 3
	text " kinds"
	line "of #mon."

	para "Come back and see"
	line "me when you catch"
	cont "60 kinds."
	done

.HereYouGo
	writetext .HereYouGoText
	waitbutton
	verbosegiveitem LUCKY_EGG, iffalse_jumpopenedtext .NoRoomText
	setevent EVENT_GOT_LUCKY_EGG_FROM_PROF_OAKS_AIDE
	jumpthisopenedtext

.ExplainText:
	text "That Lucky Egg"
	line "helps a #mon"

	para "gain more exper-"
	line "ience than usual."

	para "Use it to com-"
	line "plete the #dex!"
	done

.HiText:
	text "Hello there! I'm"
	line "Prof.Oak's aide."

	para "If you caught 60"
	line "kinds of #mon,"

	para "I'm supposed to"
	line "give you an item."

	para "So, <PLAYER>,"
	line "have you caught"

	para "at least 60 kinds"
	line "of #mon?"
	done

.HereYouGoText:
	text "Let's see…"
	line "Great job! You've"

	para "caught "
	text_decimal wTempDexOwn, 2, 3
	text " kinds"
	line "of #mon."

	para "Congratulations!"
	line "Here you go!"
	done

.NoRoomText:
	text "Oh! I see you"
	line "don't have any"
	cont "room for this."
	done

BlackthornPokeCenter1FGentlemanText:
	text "Tief im Inneren"
	line "des fernen Indigo"

	para "PLATEAUs befindet"
	line "sich die #mon"
	cont "Liga."

	para "Ich hörte, die"
	line "besten Trainer des"

	para "Landes versammeln"
	line "sich dort."
	done

BlackthornPokeCenter1FTwinText:
	text "Es gibt da eine"
	line "Attacke, die ich"

	para "unbedingt meinen"
	line "#mon beibrin-"
	cont "gen musste."

	para "Also ging ich zum"
	line "Attacken-Verler-"
	cont "ner, um eine VM-"
	cont "Attacke vergessen"
	cont "zu lassen."
	done
