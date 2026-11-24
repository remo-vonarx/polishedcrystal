Route32PokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, ROUTE_32, 1
	warp_event  6,  7, ROUTE_32, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalKurtScript

	def_object_events
	pc_nurse_event  5, 1
	object_event  3,  4, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route32Pokecenter1FFishingGuruScript, -1
	object_event  8,  2, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route32Pokecenter1FCooltrainerFText, -1
	object_event  0,  5, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, Route32PokeCenter1FPokefanMScript, -1

PokemonJournalKurtScript:
	setflag ENGINE_READ_KURT_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Special Feature:"
	line "Craftsman Kurt!"

	para "Kurt does not let"
	line "anyone near while"

	para "he is making #"
	line "Balls except his"

	para "granddaughter"
	line "Maizie."
	done

Route32Pokecenter1FFishingGuruScript:
	checkevent EVENT_GOT_OLD_ROD
	iftrue_jumptextfaceplayer .DoneText
	faceplayer
	opentext
	writetext .IntroText
	yesorno
	iffalse_jumpopenedtext .NoText
	writetext .YesText
	promptbutton
	verbosegivekeyitem OLD_ROD
	writetext .AfterText
	waitbutton
	closetext
	setevent EVENT_GOT_OLD_ROD
	end

.IntroText:
	text "Das ist ein"
	line "hervorragender"
	cont "Platz zum Angeln."

	para "Du hast Leute"
	line "beim Angeln"

	para "gesehen? Wie"
	line "steht es mit dir?"

	para "Hättest du gerne"
	line "eine Angel"
	cont "von mir?"
	done

.YesText:
	text "He! Das höre ich"
	line "wirklich gerne!"

	para "Jetzt bist du"
	line "auch ein Angler!"
	done

.AfterText:
	text "Angeln ist toll!"

	para "Probiere überall,"
	line "wo Wasser ist,"

	para "deine Angel aus,"
	line "sei es am Meer"

	para "oder an einem"
	line "Fluss."
	done

.NoText:
	text "Na, das ist aber"
	line "ziemlich mager…"
	done

.DoneText:
	text "Moin, lüttes Ding."
	line "Und beißen sie?"
	done

Route32PokeCenter1FPokefanMScript:
	checkevent EVENT_GOT_LURE_BALL_FROM_FRENCHMAN
	iftrue_jumptextfaceplayer .Text5
	faceplayer
	opentext
	writetext .Text1
	yesorno
	iftruefwd .Yes
	writetext .Text2
	sjumpfwd .Continue
.Yes:
	writetext .Text3
.Continue
	promptbutton
	verbosegiveitem LURE_BALL, iffalsefwd .NoRoom
	setevent EVENT_GOT_LURE_BALL_FROM_FRENCHMAN
	jumpthisopenedtext

	text "This Ball easily"
	line "catches #mon"
	cont "hooked on a Rod!"

	para "Kurt of Azalea"
	line "Town made it from"
	cont "an Apricorn."

	para "Apricorns,"
	line "hourrah!"
	done

.NoRoom
	endtext

.Text1:
	text "Bonjour. How are"
	line "you? Do you know"
	cont "about Apricorns?"
	done

.Text2:
	text "Non? What a waste!"
	line "I will show you"

	para "how great Apri-"
	line "corns are!"
	done

.Text3:
	text "Youpi! Way to go!"
	line "I feel so great,"

	para "I want to give you"
	line "this!"
	done

.Text5:
	text "Kurt is the hero"
	line "of every Apricorn"
	cont "collector."

	para "Apricorns,"
	line "hourrah!"
	done

Route32Pokecenter1FCooltrainerFText:
	text "Was soll mein"
	line "#mon tragen?"

	para "Vielleicht ein"
	line "Item, das seinen"

	para "ANGR-Wert"
	line "verstärkt…"
	done
