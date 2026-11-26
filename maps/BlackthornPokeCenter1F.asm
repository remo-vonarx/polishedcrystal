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

	para "Titelthema:"
	line "Arenaleiterin"
	cont "Sandra!"

	para "Mit ihrem leuch-"
	line "tend blauen Outfit"
	cont "und Umhang ist"

	para "Sandra zur neuen"
	line "Modeikone"
	cont "geworden."
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

	text "Mal sehen… Oje!"
	line "Du hast bisher"

	para "erst "
	text_decimal wTempDexOwn, 2, 3
	text " Arten"
	line "von #mon"
	cont "gefangen."

	para "Komm wieder, wenn"
	line "du 60 Arten"
	cont "gefangen hast."
	done

.HereYouGo
	writetext .HereYouGoText
	waitbutton
	verbosegiveitem LUCKY_EGG, iffalse_jumpopenedtext .NoRoomText
	setevent EVENT_GOT_LUCKY_EGG_FROM_PROF_OAKS_AIDE
	jumpthisopenedtext

.ExplainText:
	text "Das Glücks-Ei"
	line "lässt ein #mon"

	para "mehr Erfahrung als"
	line "sonst sammeln."

	para "Nutze es, um den"
	line "#dex zu"
	cont "vervollständigen!"
	done

.HiText:
	text "Hallo! Ich bin"
	line "Prof. Eichs"
	cont "Assistent."

	para "Wenn du 60 Arten"
	line "von #mon"
	cont "gefangen hast,"
	cont "soll ich dir ein"
	cont "Item geben."

	para "Also, <PLAYER>,"
	line "hast du schon"

	para "mindestens 60"
	line "Arten von #mon"
	cont "gefangen?"
	done

.HereYouGoText:
	text "Mal sehen… Toll"
	line "gemacht! Du hast"

	para "schon "
	text_decimal wTempDexOwn, 2, 3
	text " Arten"
	line "von #mon"
	cont "gefangen."

	para "Glückwunsch!"
	line "Hier, bitte!"
	done

.NoRoomText:
	text "Oh! Wie ich sehe,"
	line "hast du keinen"
	cont "Platz dafür."
	done

BlackthornPokeCenter1FGentlemanText:
	text "Tief im Inneren"
	line "des fernen Indigo"

	para "Plateaus befindet"
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
