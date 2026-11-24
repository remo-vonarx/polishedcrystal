BlackthornGym1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, BlackthornGym1FBoulderCallback

	def_warp_events
	warp_event  4, 17, BLACKTHORN_CITY, 1
	warp_event  5, 17, BLACKTHORN_CITY, 1
	warp_event  1,  7, BLACKTHORN_GYM_2F, 1
	warp_event  7,  9, BLACKTHORN_GYM_2F, 2
	warp_event  2,  6, BLACKTHORN_GYM_2F, 3
	warp_event  7,  7, BLACKTHORN_GYM_2F, 4
	warp_event  7,  6, BLACKTHORN_GYM_2F, 5

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, BlackthornGymStatue
	bg_event  6, 15, BGEVENT_READ, BlackthornGymStatue

	def_object_events
	object_event  5,  3, SPRITE_CLAIR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornGymClairScript, -1
	object_event  7, 15, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BlackthornGymGuyScript, -1
	object_event  1, 14, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerDragonTamerPaul, -1
	object_event  6,  6, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerCooltrainermMike, -1
	object_event  9,  2, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCooltrainerfLola, -1

BlackthornGym1FBoulderCallback:
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_1
	iffalsefwd .skip1
	changeblock 8, 2, $3b
.skip1
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_2
	iffalsefwd .skip2
	changeblock 2, 4, $3a
.skip2
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_3
	iffalsefwd .skip3
	changeblock 8, 6, $3b
.skip3
	endcallback

BlackthornGymStatue:
	gettrainername CLAIR, 1, STRING_BUFFER_4
	checkflag ENGINE_RISINGBADGE
	iftruefwd .Beaten
	jumpstd gymstatue1
.Beaten:
	readvar VAR_BADGES
	ifgreater 15, .LyraToo
	jumpstd gymstatue2
.LyraToo
	jumpstd gymstatue3

BlackthornGymClairScript:
	checkflag ENGINE_RISINGBADGE
	iftrue_jumptextfaceplayer ClairPokemonLeagueDirectionsText
	checkevent EVENT_BEAT_CLAIR
	iftrue_jumptextfaceplayer .TooMuchToExpectText
	showtextfaceplayer .IntroText
	winlosstext .WinText, 0
	loadtrainer CLAIR, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CLAIR
	showtext .GoToDragonsDenText
	setevent EVENT_BEAT_DRAGON_TAMER_PAUL
	setevent EVENT_BEAT_COOLTRAINERM_CODY
	setevent EVENT_BEAT_COOLTRAINERM_MIKE
	setevent EVENT_BEAT_COOLTRAINERF_FRAN
	setevent EVENT_BEAT_COOLTRAINERF_LOLA
	clearevent EVENT_MAHOGANY_MART_OWNERS
	setevent EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN
	clearevent EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	end

.IntroText:
	text "Ich bin Sandra."

	para "Der beste Drachen-"
	line "meister der Welt."

	para "Ich bestehe sogar"
	line "gegen die Top Vier"
	cont "der #mon Liga."

	para "Willst du immer"
	line "noch gegen mich"
	cont "antreten?"

	para "…Gut."
	line "Auf geht's!"

	para "Da ich eine Arena-"
	line "leiterin bin,"

	para "bringe ich mein"
	line "ganzes Können ge-"
	cont "gen jeden Gegner"
	cont "auf!"
	done

.WinText:
	text "Ich habe verloren?"

	para "Ich kann es nicht"
	line "glauben. Das muss"
	cont "ein Irrtum sein…"
	done

.GoToDragonsDenText:
	text "I won't admit"
	line "this."

	para "I may have lost,"
	line "but you're still"

	para "not ready for the"
	line "#mon League."

	para "I know. You should"
	line "take the Dragon-"
	cont "master challenge."

	para "Behind this Gym is"
	line "a place called"
	cont "Dragon's Den."

	para "There is a small"
	line "shrine at its"
	cont "center."
	cont "Go there."

	para "If you can prove"
	line "that you've lost"

	para "your lazy ideals,"
	line "I will recognize"

	para "you as a trainer"
	line "worthy of a Gym"
	cont "Badge!"
	done

.TooMuchToExpectText:
	text "Was ist los?"

	para "Erwarte ich etwa"
	line "zu viel von dir?"
	done

ClairPokemonLeagueDirectionsText:
	text "What's the matter?"

	para "Aren't you headed"
	line "to the #mon"
	cont "League?"

	para "Do you know how to"
	line "get there?"

	para "From here, go to"
	line "New Bark Town."
	cont "Then Surf east."

	para "The route there is"
	line "very tough."

	para "Don't you dare"
	line "lose at the #-"
	cont "mon League!"

	para "If you do, I'll"
	line "feel even worse"

	para "about having lost"
	line "to you!"

	para "Give it everything"
	line "you've got."
	done

BlackthornGymGuyScript:
	checkevent EVENT_BEAT_CLAIR
	iftrue_jumptextfaceplayer .WinText
	jumpthistextfaceplayer

	text "Yo! Champ in spe!"

	para "Es war eine lange"
	line "Reise, aber bald"

	para "sind wir da! Zähle"
	line "auf mich!"

	para "Sandra setzt die"
	line "mythischen und"
	cont "heiligen"
	cont "Drachen-#mon"
	cont "ein."

	para "So leicht sind die"
	line "nicht zu besiegen."

	para "Aber angeblich"
	line "sind sie anfällig"

	para "gegen Eis-"
	line "Attacken."
	done

.WinText:
	text "Gegen Sandra zu"
	line "gewinnen ist eine"
	cont "Meisterleistung."

	para "Alles was dir nun"
	line "noch bevorsteht,"
	cont "ist die #mon"
	cont "Liga."

	para "Du bist auf dem"
	line "besten Weg, der"
	cont "#mon-Champ"
	cont "zu werden!"
	done

GenericTrainerDragonTamerPaul:
	generictrainer DRAGON_TAMER, PAUL, EVENT_BEAT_DRAGON_TAMER_PAUL, .SeenText, .BeatenText

	text "Siegfried sagte"
	line "dir, er möchte"

	para "dich noch einmal"
	line "sehen? Das kann"
	cont "nicht sein!"
	done

.SeenText:
	text "Ist das dein ers-"
	line "ter Kampf gegen"
	cont "Drachen?"

	para "Ich zeige dir, wie"
	line "stark sie sind!"
	done

.BeatenText:
	text "Mein Drachen-"
	line "#mon hat"
	cont "verloren?"
	done

GenericTrainerCooltrainermMike:
	generictrainer COOLTRAINERM, MIKE, EVENT_BEAT_COOLTRAINERM_MIKE, .SeenText, .BeatenText

	text "Ich kenne jetzt"
	line "meine Schwachstel-"
	cont "len. Danke für den"
	cont "Hinweis!"
	done

.SeenText:
	text "Die Chancen, gegen"
	line "dich zu verlieren?"
	cont "Nicht mal ein Pro-"
	cont "zent!"
	done

.BeatenText:
	text "Hm, eigenartig."
	done

GenericTrainerCooltrainerfLola:
	generictrainer COOLTRAINERF, LOLA, EVENT_BEAT_COOLTRAINERF_LOLA, .SeenText, .BeatenText

	text "Drachen sind"
	line "schwach gegen Dra-"
	cont "chen-Attacken."
	done

.SeenText:
	text "Drachen sind hei-"
	line "lige #mon."

	para "Sie sind voller"
	line "Lebensenergie."

	para "Wenn du es nicht"
	line "ernst meinst, dann"

	para "wirst du sie nicht"
	line "besiegen können."
	done

.BeatenText:
	text "Großartig!"
	done
