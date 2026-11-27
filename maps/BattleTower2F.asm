BattleTower2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  1, BATTLE_TOWER_1F, 4

	def_coord_events

	def_bg_events
	bg_event  4,  3, BGEVENT_UP, BattleTower2FTVScript
	bg_event  5,  3, BGEVENT_UP, BattleTower2FTVScript
	bg_event 16,  3, BGEVENT_UP, BattleTower2FTVScript
	bg_event 17,  3, BGEVENT_UP, BattleTower2FTVScript

	def_object_events
	object_event  4,  6, SPRITE_CHERYL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower2FCherylScript, EVENT_BATTLE_TOWER_CHERYL
	object_event  7,  7, SPRITE_RILEY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower2FRileyScript, EVENT_BATTLE_TOWER_RILEY
	object_event  9,  4, SPRITE_BUCK, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower2FBuckScript, EVENT_BATTLE_TOWER_BUCK
	object_event 17,  8, SPRITE_MARLEY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower2FMarleyScript, EVENT_BATTLE_TOWER_MARLEY
	object_event 12,  7, SPRITE_MIRA, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower2FMiraScript, EVENT_BATTLE_TOWER_MIRA
	object_event 15,  6, SPRITE_ANABEL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower2FAnabelScript, EVENT_BATTLE_TOWER_ANABEL
	object_event  4,  6, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattleTower2FCooltrainermText, EVENT_MURKY_SWAMP_CHERYL
	object_event  7,  7, SPRITE_LADY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattleTower2FLadyText, EVENT_DIM_CAVE_RILEY
	object_event  9,  4, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattleTower2FTwinText, EVENT_CINNABAR_VOLCANO_BUCK
	object_event 17,  8, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattleTower2FSuperNerdText, EVENT_QUIET_CAVE_MARLEY
	pokemon_event 18,  8, PIKACHU, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_RED, BattleTower2FPikachuText, EVENT_QUIET_CAVE_MARLEY
	object_event 12,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattleTower2FYoungsterText, EVENT_SCARY_CAVE_MIRA
	object_event 15,  6, SPRITE_BLACK_BELT, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattleTower2FBlackbeltText, EVENT_BATTLE_TOWER_OUTSIDE_ANABEL

	object_const_def
	const BATTLETOWER2F_CHERYL
	const BATTLETOWER2F_RILEY
	const BATTLETOWER2F_BUCK
	const BATTLETOWER2F_MARLEY
	const BATTLETOWER2F_MIRA
	const BATTLETOWER2F_ANABEL

BattleTower2FTVScript:
	jumpthistext

	text "Im Fernsehen läuft"
	line "ein harter Kampf."
	done

BattleTower2FCherylScript:
	checkflag ENGINE_CHERYL_DONE_TODAY
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writethistext
		text "Oh, hallo,"
		line "<PLAYER>."

		para "Das ist lange her…"
		line "Nicht wahr?"

		para "Hättest du Lust"
		line "auf einen Kampf"
		cont "mit mir?"
		done
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_CHERYL_DONE_TODAY
	writethistext
		text "Ich warne dich,"
		line "meine #mon"
		cont "können ziemlich"
		cont "wild sein."
		done
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_CHERYL
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftruefwd .Team3
	checkevent EVENT_BEAT_ELITE_FOUR
	iftruefwd .Team2
	loadtrainer CHERYL, 1
	sjumpfwd .StartBattle
.Team2
	loadtrainer CHERYL, 2
	sjumpfwd .StartBattle
.Team3
	loadtrainer CHERYL, 3
.StartBattle
	startbattle
	reloadmapafterbattle
	jumpthistext

.AfterText:
	text "Trainer zu sein,"
	line "ist nicht leicht."

	para "Je mehr du"
	line "kämpfst, desto"
	cont "mehr entdeckst du."

	para "Aber weißt du was?"
	line "Auch dafür liebe"
	cont "ich #mon!"
	done

.BeatenText:
	text "Die richtige"
	line "Balance zwischen"
	cont "Angriff und"
	cont "Verteidigung…"

	para "Das ist gar nicht"
	line "so einfach."
	done

.RefuseText:
	text "Kicher…"

	para "#mon wären ganz"
	line "erschöpft, wenn"

	para "wir ständig kämp-"
	line "fen würden, nicht"
	cont "wahr?"
	done

BattleTower2FRileyScript:
	checkflag ENGINE_RILEY_DONE_TODAY
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writethistext
		text "Hallo. Lange"
		line "nicht gesehen."

		para "Dein Blick… Ich"
		line "nehme an, du bist"

		para "bereit für einen"
		line "Kampf?"
		done
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_RILEY_DONE_TODAY
	writethistext
		text "Kämpfen ist unsere"
		line "Art zu grüßen!"
		done
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_RILEY
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftruefwd .Team2
	loadtrainer RILEY, 1
	sjumpfwd .StartBattle
.Team2
	loadtrainer RILEY, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	jumpthistext

.AfterText:
	text "Wäre ich damals"
	line "nicht in der"
	cont "Finsteren Höhle…"

	para "Wärst du damals"
	line "nicht in der"
	cont "Finsteren Höhle…"

	para "Vielleicht hätten"
	line "wir uns nie"
	cont "getroffen."

	para "Oder hätten wir"
	line "uns woanders"
	cont "getroffen?"
	done

.BeatenText:
	text "Mal kämpfen wir"
	line "gegeneinander, mal"
	cont "tun wir uns"
	cont "zusammen."

	para "Toll, wie Trainer"
	line "miteinander umge-"
	cont "hen können."
	done

.RefuseText:
	text "Na gut. Dann"
	line "warten wir, bis"
	cont "du bereit bist."
	done

BattleTower2FBuckScript:
	checkflag ENGINE_BUCK_DONE_TODAY
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writethistext
		text "Ehehehe! Da bist"
		line "du ja endlich!"

		para "Dann kämpfen wir"
		line "also?"
		done
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_BUCK_DONE_TODAY
	writethistext
		text "Ich spüre, wie"
		line "meine #mon in"

		para "ihren #bällen"
		line "vor Vorfreude"
		cont "zittern!"
		done
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_BUCK
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftruefwd .Team2
	loadtrainer BUCK, 1
	sjumpfwd .StartBattle
.Team2
	loadtrainer BUCK, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	jumpthistext

.AfterText:
	text "Fweh! Zu viel!"

	para "Ich verbessere"
	line "mein Team wohl"
	cont "weiter."
	done

.BeatenText:
	text "Hehehehe!"
	line "So heiß bist du!"
	done

.RefuseText:
	text "Hä, was? Damit"
	line "nimmst du mir den"
	cont "Wind aus den"
	cont "Segeln."
	done

BattleTower2FMarleyScript:
	checkflag ENGINE_MARLEY_DONE_TODAY
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writethistext
		text "…Oh? Ein Kampf?"
		line "Mit mir?"
		done
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_MARLEY_DONE_TODAY
	writethistext
		text "…OK. Ich… werde"
		line "nicht verlieren…!"
		done
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_MARLEY
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftruefwd .Team3
	checkevent EVENT_BEAT_ELITE_FOUR
	iftruefwd .Team2
	loadtrainer MARLEY, 1
	sjumpfwd .StartBattle
.Team2
	loadtrainer MARLEY, 2
	sjumpfwd .StartBattle
.Team3
	loadtrainer MARLEY, 3
.StartBattle
	startbattle
	reloadmapafterbattle
	jumpthistext

.AfterText:
	text "…Vielleicht kämpfe"
	line "ich gern mit dir."

	para "…Nur ein bisschen."
	line "Nur ein winziges"
	cont "bisschen."
	done

.BeatenText:
	text "…Och."
	done

.RefuseText:
	text "…Ach, du. Ich mag"
	line "dich langsam ein"
	cont "bisschen weniger."
	done

BattleTower2FMiraScript:
	checkflag ENGINE_MIRA_DONE_TODAY
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writethistext
		text "<PLAYER>! Orisa"
		line "ist jetzt stärker!"

		para "Bitte! Kämpf mit"
		line "Orisa!"
		done
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_MIRA_DONE_TODAY
	writethistext
		text "Orisa zeigt dir,"
		line "dass Orisa sich"

		para "nicht mehr ver-"
		line "irrt, <PLAYER>!"
		done
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_MIRA
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftruefwd .Team2
	loadtrainer MIRA, 1
	sjumpfwd .StartBattle
.Team2
	loadtrainer MIRA, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	jumpthistext

.AfterText:
	text "<PLAYER>, du bist"
	line "immer bei deinen"
	cont "#mon."

	para "Darum bist du so"
	line "stark geworden."

	para "Orisa beginnt zu"
	line "verstehen!"
	done

.BeatenText:
	text "Orisa fragt sich,"
	line "ob sie es im"

	para "Duellturm weit"
	line "bringen kann."
	done

.RefuseText:
	text "Orisa ist ein"
	line "bisschen traurig…"
	done

BattleTower2FAnabelScript:
	checkflag ENGINE_ANABEL_DONE_TODAY
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writethistext
		text "Du bist wirklich"
		line "zu mir gekommen…"

		para "Dann muss ich mich"
		line "bei dir nicht"
		cont "zurückhalten…"

		para "Bist du bereit?"
		done
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_ANABEL_DONE_TODAY
	writethistext
		text "Wollen wir"
		line "beginnen?"
		done
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_ANABEL
	loadtrainer ANABEL, 2
	startbattle
	reloadmapafterbattle
	jumpthistext

.AfterText:
	text "Das hat Spaß"
	line "gemacht…"

	para "Ich hatte noch nie"
	line "einen so schönen"
	cont "#mon-Kampf…"
	done

.BeatenText:
	text "Danke…"
	done

.RefuseText:
	text "Das ist sehr"
	line "enttäuschend…"
	done

BattleTower2FCooltrainermText:
	text "Ich muss los, aber"
	line "ich kann einfach"

	para "nicht aufhören,"
	line "diesen Kampf"
	cont "anzusehen!"
	done

BattleTower2FLadyText:
	text "Was mich als"
	line "Trainerin am"
	cont "glücklichsten"
	cont "macht?"

	para "Dass mir #mon"
	line "viele Freunde"

	para "bringen!"
	done

BattleTower2FTwinText:
	text "Manche wundern"
	line "sich, ein kleines"

	para "Mädchen wie mich"
	line "im Duellturm zu"
	cont "sehen."

	para "Ich muss ja nicht"
	line "selbst kämpfen,"
	cont "weißt du?"
	done

BattleTower2FSuperNerdText:
	text "Hehe! Die Trainer"
	line "um uns herum sehen"
	cont "so armselig aus!"

	para "…Nein, mit so"
	line "einer Einstellung"
	cont "verliert man mit"
	cont "einem Treffer!"

	para "Bleib wachsam,"
	line "Pikachu!"
	done

BattleTower2FPikachuText:
	text "Pikachu: Pichuu!"
	done

BattleTower2FYoungsterText:
	text "Stark sein heißt"
	line "schwach sein."

	para "Schwach sein heißt"
	line "stark sein."

	para "Das hat mir mal"
	line "jemand gesagt."

	para "Ich verstehe es"
	line "nicht, aber es"
	cont "klingt tiefsinnig."
	done

BattleTower2FBlackbeltText:
	text "Der Karate-Gi ist"
	line "die Uniform der"
	cont "Kämpfer!"

	para "Nichts passt"
	line "besser zum"

	para "Duellturm als"
	line "dieser hier!"
	done
