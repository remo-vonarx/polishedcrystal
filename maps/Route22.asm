Route22_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  4, POKEMON_LEAGUE_GATE, 1
	warp_event  4,  5, POKEMON_LEAGUE_GATE, 2

	def_coord_events

	def_bg_events
	bg_event  7,  7, BGEVENT_JUMPTEXT, VictoryRoadEntranceSignText
	bg_event 23, 11, BGEVENT_JUMPTEXT, Route22AdvancedTipsSignText

	def_object_events
	object_event 20, 11, SPRITE_KUKUI, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, KukuiScript, -1
	object_event 28,  2, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route22CooltrainerfText, -1

	object_const_def
	const ROUTE22_KUKUI

KukuiScript:
	checkevent EVENT_BEAT_KUKUI
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	checkevent EVENT_INTRODUCED_KUKUI
	iftruefwd .Introduced
	writetext .IntroText
	sjumpfwd .Question
.Introduced
	writetext .RematchText
.Question
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	setevent EVENT_INTRODUCED_KUKUI
	winlosstext .BeatenText, 0
	setlasttalked ROUTE22_KUKUI
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftruefwd .Rematch
	loadtrainer KUKUI, 1
	sjumpfwd .StartBattle
.Rematch
	loadtrainer KUKUI, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_KUKUI
	jumpthistext

.AfterText:
	text "Unglaublich! Ich"
	line "bin direkt auf"
	cont "dich los, und du"
	cont "hast trotzdem"
	cont "gewonnen!"

	para "Kein Wunder, dass"
	line "du Champ bist!"

	para "Ich muss härter"
	line "trainieren, bevor"

	para "ich bereit für"
	line "die Liga bin."

	para "Und dann kämpfe"
	line "ich wieder gegen"
	cont "dich! Woo!"
	done

.IntroText:
	text "Hey! Ich bin"
	line "Kukui."

	para "Du heißt also"
	line "<PLAYER>? Alles"
	cont "klar, Kumpel!"

	para "Ich komme aus der"
	line "fernen Alola-"
	cont "Region!"

	para "Bei uns gibt es"
	line "aber keine"
	cont "#mon-Liga."

	para "Darum bin ich nach"
	line "Kanto gekommen, um"
	cont "hier gegen die Top"
	cont "Vier zu kämpfen,"
	cont "jawohl!"

	para "Hm? Du bist der"
	line "neue Champ?"

	para "Wow, kein Wunder,"
	line "dass du so stylish"
	cont "aussiehst!"

	para "Mein Team und ich"
	line "sind bereit. Wie"
	cont "wär's, wenn wir"

	para "die Liga auslassen"
	line "und gleich gegen"
	cont "dich antreten?"
	done

.RematchText:
	text "Hey,"
	line "<PLAYER>!"

	para "Ich habe seit"
	line "unserem letzten"
	cont "Kampf hart"
	cont "trainiert, jawohl!"

	para "Du siehst aus, als"
	line "wärst du auch"
	cont "stärker geworden!"

	para "Wie wär's mit"
	line "einer Revanche?"
	done

.SeenText:
	text "Lass uns einen"
	line "Kampf austragen,"
	cont "der dieses Moments"
	cont "würdig ist!"
	done

.BeatenText:
	text "Ich konnte nicht"
	line "gewinnen, obwohl"
	cont "ich alles gegeben"
	cont "habe…"
	done

.RefusedText:
	text "Du konzentrierst"
	line "dich ganz auf"
	cont "deine eigene"
	cont "Reise, stimmt's?"

	para "Das respektiere"
	line "ich!"
	done

Route22CooltrainerfText:
	text "Der Name “Kanto”"
	line "bedeutet “östlich"
	cont "der Schranke”."

	para "Ich nehme an, die"
	line "Schranke ist der"
	cont "Silberberg."
	done

VictoryRoadEntranceSignText:
	text "Route 22"

	para "#mon Liga"
	line "Empfangstor"
	done

Route22AdvancedTipsSignText:
	text "Tipps für Profis!"

	para "Startest du ein"
	line "Neues Spiel+,"

	para "behältst du Geld"
	line "und GP aus dem"
	cont "alten Spiel und"

	para "alle #mon, die"
	line "im PC lagern!"
	done
