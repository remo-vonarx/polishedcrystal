PlayersHouse1F_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_PLAYERSHOUSE1F_MEET_MOM
	scene_const SCENE_PLAYERSHOUSE1F_NOOP

	def_callbacks

	def_warp_events
	warp_event  8,  7, NEW_BARK_TOWN, 2
	warp_event  9,  7, NEW_BARK_TOWN, 2
	warp_event 11,  0, PLAYERS_HOUSE_2F, 1

	def_coord_events
	coord_event 10,  4, SCENE_PLAYERSHOUSE1F_MEET_MOM, MomTrigger1
	coord_event 11,  4, SCENE_PLAYERSHOUSE1F_MEET_MOM, MomTrigger2
	coord_event  9,  1, SCENE_PLAYERSHOUSE1F_MEET_MOM, MomTrigger3
	coord_event  9,  2, SCENE_PLAYERSHOUSE1F_MEET_MOM, MomTrigger4

	def_bg_events
	bg_event  1,  1, BGEVENT_JUMPTEXT, PlayersHouse1FFridgeText
	bg_event  2,  1, BGEVENT_JUMPTEXT, PlayersHouse1FSinkText
	bg_event  3,  1, BGEVENT_JUMPTEXT, PlayersHouse1FStoveText
	bg_event  6,  1, BGEVENT_UP, PlayersHouse1FTVScript

	def_object_events
	object_event  9,  4, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_1
	object_event  3,  2, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, (1 << MORN), 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  9,  4, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, (1 << DAY), 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  6,  3, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, (1 << EVE), 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  1,  2, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  6,  4, SPRITE_MATRON, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, NeighborScript, EVENT_PLAYERS_HOUSE_1F_NEIGHBOR

	object_const_def
	const PLAYERSHOUSE1F_MOM1

MomTrigger1:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, PLAYERSHOUSE1F_MOM1, 15
	turnobject PLAYERSHOUSE1F_MOM1, RIGHT
	turnobject PLAYER, LEFT
	sjumpfwd MomEventScript

MomTrigger2:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, PLAYERSHOUSE1F_MOM1, 15
	turnobject PLAYERSHOUSE1F_MOM1, RIGHT
	applyonemovement PLAYER, slow_step_left
	sjumpfwd MomEventScript

MomTrigger3:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, PLAYERSHOUSE1F_MOM1, 15
	turnobject PLAYERSHOUSE1F_MOM1, UP
	applymovement PLAYER, .two_steps_down
	sjumpfwd MomEventScript

.two_steps_down
	step_down
	step_down
	step_end

MomTrigger4:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, PLAYERSHOUSE1F_MOM1, 15
	turnobject PLAYERSHOUSE1F_MOM1, UP
	applyonemovement PLAYER, slow_step_down
MomEventScript:
	opentext
	writetext MomIntroText
	promptbutton
	givespecialitem POKEGEAR
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	addcellnum PHONE_MOM
	setscene SCENE_PLAYERSHOUSE1F_NOOP
	setevent EVENT_PLAYERS_HOUSE_MOM_1
	clearevent EVENT_PLAYERS_HOUSE_MOM_2
	writetext MomPokegearText
	promptbutton
	special Special_SetDayOfWeek
.InitialSetDSTFlag:
	writetext MomDSTText
	yesorno
	iffalsefwd .NotDST
	special Special_InitialSetDSTFlag
	yesorno
	iffalse .InitialSetDSTFlag
	sjumpfwd .InitializedDSTFlag
.NotDST:
	special Special_InitialClearDSTFlag
	yesorno
	iffalse .InitialSetDSTFlag
.InitializedDSTFlag:
	writetext MomRunningShoesText
	yesorno
	iftruefwd .NoInstructions
	writetext MomInstructionsText
	promptbutton
.NoInstructions:
	writetext MomOutroText
	waitbutton
	closetext
	turnobject PLAYERSHOUSE1F_MOM1, LEFT
	special RestartMapMusic
	end

PlayersHouse1FFridgeText:
	text "Mal sehen, was da"
	line "im Kühlschrank zu"
	cont "finden ist…"

	para "Tafelwasser"
	line "und leckere Limo-"
	cont "nade!"
	done

PlayersHouse1FSinkText:
	text "Die Spüle ist"
	line "fleckenlos rein,"
	cont "so wie es Mama"
	cont "mag."
	done

PlayersHouse1FStoveText:
	text "Mamas Spezialität!"

	para "Zinnober-Vulkan-"
	line "Burger!"
	done

PlayersHouse1FTVScript:
	jumpthistext

	text "Es läuft ein Film"
	line "im TV: Die Sterne"

	para "leuchten und zwei"
	line "Jungen fahren Zug…"

	para "Ich sollte mich"
	line "auch in Bewegung"
	cont "setzen!"
	done

MomScript:
	faceplayer
	checkscene
	iffalsefwd .MomEvent
	opentext
	checkevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	iftrue_jumpopenedtext MomDoItText
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftruefwd .BankOfMom
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftruefwd .FirstTimeBanking
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumpopenedtext MomErrandText
	jumpthisopenedtext

	text "Prof. Lind wartet"
	line "auf dich."

	para "Beeile dich, Baby!"
	done

.FirstTimeBanking:
	setevent EVENT_FIRST_TIME_BANKING_WITH_MOM
.BankOfMom:
	setevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	special Special_BankOfMom
	waitendtext

.MomEvent:
	playmusic MUSIC_MOM
	sjump MomEventScript

MomIntroText:
if DEF(DEBUG)
	text "Don't forget to use"
	line "your debug radio!"
	done
else
	text "Oh, <PLAYER>!"
	line "Du bist wach."

	para "Deine Freundin"
	line "Lyra war eben da."

	para "Sie sagte, dass"
	line "unser Nachbar,"

	para "Prof. Lind, nach"
	line "dir gesucht hat."

	para "Oh! Fast hätte ich"
	line "es vergessen! Dein"

	para "#mon-Com ist"
	line "von der Reparatur"
	cont "zurück."

	para "Da hast du ihn!"
	done
endc

MomPokegearText:
	text "#mon-Com oder"
	line "einfach nur"
	cont "#Com."

	para "Ein wichtiges Ge-"
	line "rät auf deinem"
	cont "Pfad als Trainer."

	para "Oh, der Wochentag"
	line "ist noch nicht"
	cont "eingestellt."

	para "Das darfst du"
	line "nicht vergessen!"
	done

MomDSTText:
	text "Haben wir"
	line "Sommerzeit?"
	done

MomRunningShoesText:
	text "Geh nach Hause, um"
	line "deine Uhr auf SZ"
	cont "oder WZ einzu-"
	cont "stellen."

	para "Übrigens, weisst"
	line "du, wie man die"
	cont "neuen Turbotreter"
	cont "benutzt?"
	done

MomInstructionsText:
	text "Ich werde die An-"
	line "leitung lesen."

	para "Halte den B-Knopf"
	line "gedrückt, um zu"
	cont "rennen, drinnen"
	cont "wie draussen."

	para "Oder stell in den"
	line "Optionen ein, dass"
	cont "du immer rennst,"

	para "und halte B, um zu"
	line "gehen."
	done

MomOutroText:
	text "Na, sind die nicht"
	line "praktisch?"
	done

MomErrandText:
	text "Wie lautete der"
	line "Auftrag von Prof."
	cont "Lind?"

	para "…"

	para "Das klingt nach"
	line "einer wahren He-"
	cont "rausforderung."

	para "Aber du kannst"
	line "stolz darauf sein,"
	cont "dass sich die Leu-"
	cont "te auf dich ver-"
	cont "lassen!"
	done

MomDoItText:
	text "<PLAYER>, du"
	line "schaffst es!"

	para "Ich werde dir"
	line "immer zur Seite"
	cont "stehen!"
	done

NeighborScript:
	faceplayer
	opentext
	checktime 1 << MORN
	iftruefwd .MornScript
	checktime 1 << DAY
	iftruefwd .DayScript
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .NiteScript

.MornScript:
	writetext .MornIntroText
	promptbutton
	sjumpfwd .Main

.DayScript:
	writetext .DayIntroText
	promptbutton
	sjumpfwd .Main

.NiteScript:
	writetext .NiteIntroText
	promptbutton
	; fallthrough

.Main:
	writetext .NeighborText
	waitbutton
	closetext
	turnobject LAST_TALKED, RIGHT
	end

.MornIntroText:
	text "Guten Morgen,"
	line "<PLAYER>!"

	para "Ich bin zu Besuch!"
	done

.DayIntroText:
	text "Hallo, <PLAYER>!"
	line "Ich bin zu Besuch!"
	done

.NiteIntroText:
	text "Guten Abend,"
	line "<PLAYER>!"

	para "Ich bin zu Besuch!"
	done

.NeighborText:
	text "<PLAYER>, hast"
	line "du schon gehört?"

	para "Meine Tochter will"
	line "unbedingt Prof."

	para "Linds Assistentin"
	line "werden."

	para "Sie liebt #mon"
	line "von ganzem Herzen!"
	done
