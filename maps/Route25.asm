Route25_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event 30,  6, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, TrainerCooltrainermKevin, EVENT_ROUTE_25_COOLTRAINER_M_BEFORE
	object_event 32,  6, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CooltrainermKevinAfterBattleText, EVENT_ROUTE_25_COOLTRAINER_M_AFTER
	object_event  7,  9, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSchoolboyDudley, -1
	object_event 11,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerLassEllen, -1
	object_event 14,  8, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSchoolboyJoe, -1
	object_event 12,  4, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerLassLaura, -1
	object_event 18,  7, SPRITE_CAMPER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerCamperLloyd, -1
	object_event 22,  9, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerLassShannon, -1
	object_event 25,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSupernerdPat, -1
	itemball_event 25,  2, PROTEIN, 1, EVENT_ROUTE_25_PROTEIN
	cuttree_event 28,  4, EVENT_ROUTE_25_CUT_TREE
	object_event 20,  2, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route25MewYoungsterText, -1
	object_event 21,  2, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SLOWPOKE, -1, PAL_MON_PINK, OBJECTTYPE_SCRIPT, PLAIN_FORM, Route25SlowpokeScript, -1

	object_const_def
	const ROUTE25_COOLTRAINERM_BEFORE
	const ROUTE25_COOLTRAINERM_AFTER

GenericTrainerSchoolboyDudley:
	generictrainer SCHOOLBOY, DUDLEY, EVENT_BEAT_SCHOOLBOY_DUDLEY, SchoolboyDudleySeenText, SchoolboyDudleyBeatenText

	text "Ich gab mein"
	line "Bestes. Ich habe"
	cont "mir nichts"
	cont "vorzuwerfen."
	done

GenericTrainerLassEllen:
	generictrainer LASS, ELLEN, EVENT_BEAT_LASS_ELLEN, LassEllenSeenText, LassEllenBeatenText

	text "Ich habe alles"
	line "gegeben. Ich kann"
	cont "mir nichts"
	cont "vorwerfen."
	done

GenericTrainerSchoolboyJoe:
	generictrainer SCHOOLBOY, JOE, EVENT_BEAT_SCHOOLBOY_JOE, SchoolboyJoeSeenText, SchoolboyJoeBeatenText

	text "Ich habe alles"
	line "gegeben. Ich kann"
	cont "mir nichts"
	cont "vorwerfen."
	done

GenericTrainerLassLaura:
	generictrainer LASS, LAURA, EVENT_BEAT_LASS_LAURA, LassLauraSeenText, LassLauraBeatenText

	text "Ich gab mein"
	line "Bestes. Ich habe"
	cont "mir nichts"
	cont "vorzuwerfen."
	done

GenericTrainerCamperLloyd:
	generictrainer CAMPER, LLOYD, EVENT_BEAT_CAMPER_LLOYD, CamperLloydSeenText, CamperLloydBeatenText

	text "Ich gab mein"
	line "Bestes. Ich habe"
	cont "mir nichts"
	cont "vorzuwerfen."
	done

GenericTrainerLassShannon:
	generictrainer LASS, SHANNON, EVENT_BEAT_LASS_SHANNON, LassShannonSeenText, LassShannonBeatenText

	text "Ich gab mein"
	line "Bestes. Ich habe"
	cont "mir nichts"
	cont "vorzuwerfen."
	done

GenericTrainerSupernerdPat:
	generictrainer SUPER_NERD, PAT, EVENT_BEAT_SUPER_NERD_PAT, SupernerdPatSeenText, SupernerdPatBeatenText

	text "Tut mir Leid… Ich"
	line "werde nicht mehr"
	cont "mogeln…"
	done

Route25SlowpokeScript:
	opentext
	writetext Route25SlowpokeText1
	pause 60
	writetext Route25SlowpokeText2
	cry SLOWPOKE
	waitendtext

TrainerCooltrainermKevin:
	checkevent EVENT_BEAT_SUPER_NERD_PAT
	iffalse_jumptextfaceplayer NuggetBridgeNotClearedText
	faceplayer
	opentext
	checkevent EVENT_CLEARED_NUGGET_BRIDGE
	iftruefwd .AfterNuggetBridge
	writetext CooltrainermKevinNuggetText
	promptbutton
	verbosegiveitem NUGGET, iffalse_endtext
	setevent EVENT_CLEARED_NUGGET_BRIDGE
.AfterNuggetBridge:
	writetext CooltrainermKevinSeenText
	waitbutton
	closetext
	follow ROUTE25_COOLTRAINERM_BEFORE, PLAYER
	applymovement ROUTE25_COOLTRAINERM_BEFORE, Route25CooltrainerMovementData
	stopfollow
	turnobject ROUTE25_COOLTRAINERM_BEFORE, LEFT
	winlosstext CooltrainermKevinBeatenText, 0
	loadtrainer COOLTRAINERM, KEVIN
	startbattle
	disappear ROUTE25_COOLTRAINERM_BEFORE
	appear ROUTE25_COOLTRAINERM_AFTER
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERM_KEVIN
	jumptext CooltrainermKevinAfterBattleText

Route25CooltrainerMovementData:
	step_right
	step_right
	step_end

SchoolboyDudleySeenText:
	text "Besiege alle sechs"
	line "Trainer und du"
	cont "erhältst einen"
	cont "wunderbaren Preis!"

	para "Glaubst du, du"
	line "hast das Zeug"
	cont "dazu?"
	done

SchoolboyDudleyBeatenText:
	text "Wow! Gut gemacht."
	done

LassEllenSeenText:
	text "Ich bin Numero 2!"
	line "Jetzt wird es"
	cont "ernst!"
	done

LassEllenBeatenText:
	text "Wie konnte ich"
	line "nur verlieren?"
	done

SchoolboyJoeSeenText:
	text "Ich bin Nummer 3!"
	line "Das wird nicht"
	cont "leicht."
	done

SchoolboyJoeBeatenText:
	text "Oh! Vermöbelt!"
	done

LassLauraSeenText:
	text "Der Vierte!"
	line "Bist du müde?"
	done

LassLauraBeatenText:
	text "Auch ich habe"
	line "verloren…"
	done

CamperLloydSeenText:
	text "O.K.! Nummer 5."
	line "Ich zermalme dich!"
	done

CamperLloydBeatenText:
	text "Uff! Zu stark."
	done

LassShannonSeenText:
	text "Ich bin der"
	line "Letzte, aber ich"
	cont "sage dir, ich bin"
	cont "eine harte Nuss!"
	done

LassShannonBeatenText:
	text "Du machst Witze."
	done

SupernerdPatSeenText:
	text "Uffuffuff…"

	para "Ich habe mit den"
	line "sechs Trainern"
	cont "nichts zu tun."

	para "Ich habe hier auf"
	line "dich gewartet, um"

	para "dich zu besiegen,"
	line "da du nach den"
	cont "vielen Kämpfen"
	cont "müde sein musst."
	done

SupernerdPatBeatenText:
	text "Bist du überhaupt"
	line "nicht müde?"
	done

Route25MewYoungsterText:
	text "One time I saw a"
	line "Mew around here!"

	para "You don't believe"
	line "me? Slowpoke saw"
	cont "it too!"
	done

Route25SlowpokeText1:
	text "Flegmon: …"

	para "…… …… ……"
	done

Route25SlowpokeText2:
	text "…… ……Gähn?"
	done

CooltrainermKevinNuggetText:
	text "Du hast einen"
	line "Kampf mehr be-"
	cont "stritten, als du"

	para "erwartet hast."
	line "Dennoch hast du"
	cont "gewonnen."

	para "Wie versprochen,"
	line "hier ist der"
	cont "Preis."
	done

CooltrainermKevinSeenText:
	text "Nachdem ich ge-"
	line "sehen habe, wie"

	para "du kämpfst, möchte"
	line "ich sehen, wie es"
	cont "mir ergeht."

	para "Wie sieht's aus?"
	line "Ich fordere dich"
	cont "heraus."
	done

CooltrainermKevinBeatenText:
	text "Das war der beste"
	line "Kampf meines"
	cont "Lebens!"
	done

CooltrainermKevinAfterBattleText:
	text "Der Kampf war"
	line "großartig!"

	para "Du und deine #-"
	line "mon seid ein"
	cont "perfektes Team!"
	done

NuggetBridgeNotClearedText:
	text "Hey there!"

	para "Six trainers and"
	line "I are hosting a"

	para "battle challenge"
	line "on this route."

	para "You can't skip"
	line "ahead of them!"

	para "There's a shortcut"
	line "just below us back"
	cont "to Route 24."
	done
