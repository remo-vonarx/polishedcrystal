SaffronPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, SAFFRON_CITY, 4
	warp_event  6,  7, SAFFRON_CITY, 4
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalSabrinaScript

	def_object_events
	pc_nurse_event  5, 1
	object_event 11,  5, SPRITE_FIREBREATHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, SaffronPokeCenter1FFisherScript, -1
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronPokeCenter1FTeacherText, -1
	object_event  8,  4, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronPokeCenter1FYoungsterText, -1

PokemonJournalSabrinaScript:
	setflag ENGINE_READ_SABRINA_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Special Feature:"
	line "Leader Sabrina!"

	para "People say that"
	line "Sabrina can com-"
	cont "municate with her"

	para "#mon during"
	line "battle without"
	cont "speaking."
	done

SaffronPokeCenter1FFisherScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer .Text2
	jumpthistextfaceplayer

	text "Ich bin gerade"
	line "durch den Fels-"
	cont "tunnel gekommen."

	para "Da war irgendetwas"
	line "im Gange beim"
	cont "Kraftwerk."
	done

.Text2:
	text "Die Höhlen stürzen"
	line "leicht ein."

	para "In letzter Zeit"
	line "sind einige Höhlen"

	para "verschwunden. Wie"
	line "die Höhle vor"
	cont "Azuria City."

	para "Für einen Profi-"
	line "Wanderer ist das"
	cont "Grundwissen."
	done

SaffronPokeCenter1FTeacherText:
	text "Wie sehen die"
	line "#mon-Center in"
	cont "Johto aus?"

	para "…Oh, aha. Sie"
	line "unterscheiden sich"

	para "kaum von denen"
	line "in Kanto."

	para "Ich kann also nach"
	line "Johto gehen, ohne"
	cont "mich zu sorgen!"
	done

SaffronPokeCenter1FYoungsterText:
	text "Die Zentrale von"
	line "Silph Co. und der"

	para "Magnetzug-Bahnhof"
	line "sind sehenswürdige"

	para "Orte in Saffronia"
	line "City."
	done
