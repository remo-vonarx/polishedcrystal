Route19BeachHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, ROUTE_19, 2
	warp_event  3,  7, ROUTE_19, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route19BeachHouseVictorScript, -1
	object_event  6,  4, SPRITE_SURFING_PIKACHU, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route19BeachHouseSurfingPikachuScript, -1

	object_const_def
	const ROUTE19BEACHHOUSE_VICTOR

Route19BeachHouseVictorScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_VICTOR
	iftruefwd .AfterScript
	writetext .GreetingText
	waitbutton
	special CheckForSurfingPikachu
	iffalsefwd .NoPikachu
	writetext .ChallengeText
	yesorno
	iffalsefwd .NoBattle
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE19BEACHHOUSE_VICTOR
	loadtrainer VICTOR, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_VICTOR
	opentext
.AfterScript:
	jumpopenedtext .AfterText

.NoPikachu:
	jumpthisopenedtext

	text "Du schaffst das"
	line "auch!"

	para "Zieh los und finde"
	line "ein Pikachu, das"
	cont "Surfer kann!"

	para "Zeig mir, dass du"
	line "das Surfen auch"
	cont "liebst!"
	done

.NoBattle:
	jumpopenedtext .NoBattleText

.GreetingText:
	text "Hallo, Freund!"
	line "Ich heiße Viktor."

	para "Ich liebe das Sur-"
	line "fen, und Puka"
	cont "auch. Das ist mein"
	cont "Pikachu!"
	done

.ChallengeText:
	text "Wow!"

	para "Dein Pikachu kann"
	line "Surfer! Dann bin"
	cont "ich nicht allein…"

	para "Super! Damit hast"
	line "du dir einen Surf-"

	para "Kampf mit mir und"
	line "Puka verdient!"

	para "Willst du es"
	line "versuchen?"
	done

.SeenText:
	text "Das Meer vereint"
	line "alle Surfer!"
	cont "Los geht's!"
	done

.BeatenText:
	text "Ich wusste, dass"
	line "du es schaffst!"
	done

.AfterText:
	text "Ich habe gehört,"
	line "dass einige Pika-"
	cont "chu in Johto"

	para "sich das Surfen"
	line "selbst beigebracht"
	cont "haben."

	para "Vielleicht kommt"
	line "meins von dort."

	para "Ich fand Puka vor"
	line "Jahren angespült"
	cont "am Strand, und"

	para "seitdem sind wir"
	line "Partner."
	done


.NoBattleText:
	text "Schade. Komm"
	line "jederzeit zum"
	cont "Surfen, Freund!"
	done

Route19BeachHouseSurfingPikachuScript:
	faceplayer
	showcrytext .Text, PIKACHU
	end

.Text:
	text "Puka: Pi-kaa!"
	done
