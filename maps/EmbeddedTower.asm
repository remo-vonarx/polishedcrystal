EmbeddedTower_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6, 23, ROUTE_47, 6
	warp_event  7, 23, ROUTE_47, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  8,  9, SPRITE_STEVEN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, EmbeddedTowerSteven1Script, EVENT_EMBEDDED_TOWER_STEVEN_1
	object_event  4, 11, SPRITE_STEVEN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, EmbeddedTowerSteven2Script, EVENT_EMBEDDED_TOWER_STEVEN_2

	object_const_def
	const EMBEDDEDTOWER_STEVEN1
	const EMBEDDEDTOWER_STEVEN2

EmbeddedTowerSteven1Script:
	faceplayer
	opentext
	checkevent EVENT_BEAT_STEVEN
	iftruefwd .Beaten
	checkevent EVENT_LISTENED_TO_STEVEN_INTRO
	iftruefwd .HeardIntro
	writetext EmbeddedTowerSteven1IntroText
	waitbutton
	setevent EVENT_LISTENED_TO_STEVEN_INTRO
.HeardIntro
	writetext EmbeddedTowerSteven1TowerText
	waitbutton
	checkevent EVENT_BEAT_ELITE_FOUR
	iffalse_jumpopenedtext EmbeddedTowerSteven1NotNowText
	writetext EmbeddedTowerSteven1ChallengeText
	yesorno
	iffalse_jumpopenedtext EmbeddedTowerSteven1NoText
	writetext EmbeddedTowerSteven1YesText
	waitbutton
	closetext
	winlosstext EmbeddedTowerSteven1WinText, 0
	setlasttalked EMBEDDEDTOWER_STEVEN1
	loadtrainer STEVEN, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_STEVEN
	opentext
.Beaten:
	checkevent EVENT_GOT_MUSCLE_BAND_FROM_STEVEN
	iftrue_jumpopenedtext EmbeddedTowerSteven1AfterText
	writetext EmbeddedTowerSteven1ItemText
	waitbutton
	verbosegiveitem MUSCLE_BAND, iffalse_endtext
	setevent EVENT_GOT_MUSCLE_BAND_FROM_STEVEN
.GotMuscleBand
	jumpopenedtext EmbeddedTowerSteven1AfterText

EmbeddedTowerSteven2Script:
	checkevent EVENT_BEAT_STEVEN
	iftrue_jumptextfaceplayer EmbeddedTowerSteven2AfterText
	faceplayer
	opentext
	writetext EmbeddedTowerSteven2ChallengeText
	yesorno
	iffalse_jumpopenedtext EmbeddedTowerSteven2NoText
	writetext EmbeddedTowerSteven2YesText
	waitbutton
	closetext
	winlosstext EmbeddedTowerSteven2WinText, 0
	setlasttalked EMBEDDEDTOWER_STEVEN2
	loadtrainer STEVEN, 2
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_STEVEN
	opentext
	jumpopenedtext EmbeddedTowerSteven2AfterText

EmbeddedTowerSteven1IntroText:
	text "Hallo! Ich bin"
	line "Troy. Seltene"
	cont "Steine sind meine"
	cont "Leidenschaft."

	para "Ich komme aus der"
	line "Hoenn-Region. Es"

	para "ist ein wunder-"
	line "schöner Ort mit"

	para "dem klarsten Meer,"
	line "das du dir vor-"
	cont "stellen kannst."

	para "Du solltest mal"
	line "hinfahren."
	done

EmbeddedTowerSteven1TowerText:
	text "Troy: Ich suche"
	line "hier nach Steinen"
	cont "für meine"
	cont "Sammlung."

	para "Das ist der"
	line "Felsenherzturm."

	para "Er wurde von"
	line "Menschen aus Hoenn"

	para "erbaut, um Meer,"
	line "Land und Himmel"
	cont "zu verbinden."
	done

EmbeddedTowerSteven1NotNowText:
	text "Troy: Deine"
	line "#mon sehen"
	cont "richtig gut aus."

	para "Wenn du die Top"
	line "Vier besiegst,"

	para "komm wieder her,"
	line "um gegen mich zu"
	cont "kämpfen."
	done

EmbeddedTowerSteven1ChallengeText:
	text "Troy: Deine"
	line "#mon sehen"
	cont "richtig gut aus."

	para "Wo wir schon beide"
	line "hier sind, wollen"
	cont "wir kämpfen?"
	done

EmbeddedTowerSteven1NoText:
EmbeddedTowerSteven2NoText:
	text "Troy: Hm."
	line "Falls du es dir"

	para "anders überlegst,"
	line "ich bin hier."
	done

EmbeddedTowerSteven1YesText:
EmbeddedTowerSteven2YesText:
	text "Troy: Ich will,"
	line "dass du alles"

	para "gibst, was du"
	line "hast! Na los!"
	done

EmbeddedTowerSteven1WinText:
EmbeddedTowerSteven2WinText:
	text "Du bist ein wahr-"
	line "haft edler"
	cont "#mon-Trainer!"
	done

EmbeddedTowerSteven1ItemText:
	text "Troy: Herzlichen"
	line "Glückwunsch!"

	para "Die Gefühle, die"
	line "du für deine"
	cont "#mon hegst…"

	para "Und die #mon,"
	line "die diese Gefühle"

	para "mit all ihrer"
	line "Kraft erwidert"
	cont "haben…"

	para "Sie sind zu einer"
	line "Einheit verschmol-"

	para "zen und haben eine"
	line "noch größere Kraft"
	cont "erschaffen."

	para "Und so konntest"
	line "du den Sieg"
	cont "erringen!"

	para "Dieses Item kann"
	line "dir sicher von"
	cont "Nutzen sein."
	done

EmbeddedTowerSteven1AfterText:
	text "Troy: Mögen sich"
	line "unsere Wege wieder"
	cont "kreuzen."
	done

EmbeddedTowerSteven2ChallengeText:
	text "Troy: Wir sehen"
	line "uns wieder,"
	cont "<PLAYER>!"

	para "Ich habe ein paar"
	line "tolle Steine für"
	cont "meine Sammlung"
	cont "gefunden."

	para "Und was hast du"
	line "so gemacht?"

	para "Du hast die Top"
	line "Vier wieder"
	cont "besiegt? Toll!"

	para "Wollen wir noch"
	line "mal kämpfen?"
	done

EmbeddedTowerSteven2AfterText:
	text "Troy: Am Ende bist"
	line "du immer noch am"
	cont "stärksten."

	para "Aber ich bereue"
	line "unseren Kampf"
	cont "nicht."

	para "Denn jedes Mal,"
	line "wenn ich gegen"
	cont "dich kämpfe,"

	para "lerne ich mehr"
	line "über #mon!"
	done
