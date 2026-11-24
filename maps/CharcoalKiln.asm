CharcoalKiln_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, AZALEA_TOWN, 2
	warp_event  4,  7, AZALEA_TOWN, 2

	def_coord_events

	def_bg_events
	bg_event  9,  1, BGEVENT_JUMPTEXT, CharcoalKilnBucketText

	def_object_events
	object_event  1,  4, SPRITE_BLACK_BELT, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CharcoalKilnBoss, EVENT_CHARCOAL_KILN_BOSS
	object_event  4,  3, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, CharcoalKilnApprentice, EVENT_CHARCOAL_KILN_APPRENTICE
	object_event  8,  6, SPRITE_FARFETCH_D, SPRITEMOVEDATA_WANDER, 2, 2, -1, 0, OBJECTTYPE_SCRIPT, 0, CharcoalKilnFarfetchdScript, EVENT_CHARCOAL_KILN_FARFETCH_D

CharcoalKilnBoss:
	checkevent EVENT_GOT_HM01_CUT
	iftrue_jumptextfaceplayer .Text3
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iftrue_jumptextfaceplayer .Text2
	jumpthistextfaceplayer

	text "Alle Flegmon sind"
	line "aus der Stadt ver-"
	cont "schwunden."

	para "Vielleicht ist der"
	line "Patron des Waldes"
	cont "zornig auf uns…"

	para "Es kann ein böses"
	line "Omen sein. Besser,"
	cont "wir bleiben zu"
	cont "Hause."
	done

.Text2:
	text "Die Flegmon sind"
	line "zurückgekehrt…"

	para "Aber mein Lehrling"
	line "kam noch nicht aus"
	cont "dem Steineichen-"
	cont "wald zurück."

	para "Wo in aller Welt"
	line "steckt der faule"
	cont "Kerl?"
	done

.Text3:
	text "Du hast Team"
	line "Rocket vertrieben"

	para "und bist allein in"
	line "den Steineichen-"
	cont "wald gegangen?"

	para "Du hast ja Mut!"
	line "Das mag ich! Komm,"
	cont "trainiere mit uns."
	done

CharcoalKilnApprentice:
	checkevent EVENT_GOT_CHARCOAL_IN_CHARCOAL_KILN
	iftrue_jumptextfaceplayer .Text3
	checkevent EVENT_GOT_HM01_CUT
	iffalse_jumptextfaceplayer .Text1
	faceplayer
	opentext
	writetext .Text2
	promptbutton
	verbosegiveitem CHARCOAL, iffalse_endtext
	setevent EVENT_GOT_CHARCOAL_IN_CHARCOAL_KILN
	endtext

.Text1:
	text "Wo sind nur all"
	line "die Flegmon hin?"

	para "Sind sie irgendwo"
	line "zum Spielen hinge-"
	cont "gangen?"
	done

.Text2:
	text "Es tut mir Leid."
	line "Ich habe dir noch"
	cont "nicht gedankt."

	para "Das ist Holzkohle,"
	line "die ich selbst ge-"
	cont "macht habe."

	para "Feuer-#mon"
	line "wären froh, so et-"
	cont "was halten zu"
	cont "dürfen."
	done

.Text3:
	text "Die Flegmon sind"
	line "wieder da, und du"
	cont "hast auch Porenta"
	cont "gefunden."

	para "Du bist der"
	line "Coolste!"
	done

CharcoalKilnFarfetchdScript:
	faceplayer
	showcrytext .Text, FARFETCH_D
	end

.Text:
	text "Porenta: Kwaa!"
	done

CharcoalKilnBucketText:
	text "It's a bucket."
	done
