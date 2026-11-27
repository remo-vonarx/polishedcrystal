WarmBeach_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 15, 13, WARM_BEACH_SHACK, 1
	warp_event  8,  5, SHAMOUTI_TUNNEL, 2
	warp_event  3,  8, WARM_BEACH_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 17, 14, BGEVENT_JUMPTEXT, WarmBeachShackSignText
	bg_event 18, 20, BGEVENT_JUMPTEXT, WarmBeachShrineText
	bg_event 19, 20, BGEVENT_JUMPTEXT, WarmBeachShrineText
	bg_event  7, 20, BGEVENT_ITEM + PEARL, EVENT_WARM_BEACH_HIDDEN_PEARL

	def_object_events
	object_event 11,  8, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSightseermGareth, -1
	object_event  4, 12, SPRITE_AROMA_LADY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerAromaLadyHolly, -1
	object_event 11, 14, SPRITE_COOL_DUDE, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, WarmBeachCooltrainermText, -1
	object_event 22, 20, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, WarmBeachCooltrainerfText, -1
	object_event 17, 21, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SLOWKING, -1, PAL_MON_PINK, OBJECTTYPE_SCRIPT, PLAIN_FORM, WarmBeachSlowkingScript, -1
	object_event 11, 20, SPRITE_PICNICKER, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, WarmBeachLassScript, -1
	object_event  6, 23, SPRITE_LADY, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, WarmBeachLadyText, -1

GenericTrainerSightseermGareth:
	generictrainer SIGHTSEERM, GARETH, EVENT_BEAT_SIGHTSEERM_GARETH, .SeenText, .BeatenText

	text "Auch außerhalb"
	line "von Kämpfen sind"

	para "diese Items schöne"
	line "Andenken."
	done

.SeenText:
	text "Ich habe gerade"
	line "ein paar nützliche"

	para "Items auf dem"
	line "Markt gekauft!"
	done

.BeatenText:
	text "Meine Items haben"
	line "nicht gereicht…"
	done

GenericTrainerAromaLadyHolly:
	generictrainer AROMA_LADY, HOLLY, EVENT_BEAT_AROMA_LADY_HOLLY, .SeenText, .BeatenText

	text "Der Geruchssinn"
	line "ist lebenswichtig"
	cont "in der Natur."
	done

.SeenText:
	text "Ich bin eins mit"
	line "den Düften der"
	cont "Natur."
	done

.BeatenText:
	text "Die Niederlage hat"
	line "ihren eigenen"
	cont "Duft…"
	done

WarmBeachCooltrainermText:
	text "Hier gibt es ein"
	line "#mon, das"
	cont "sprechen kann!"

	para "Ich hätte es nie"
	line "geglaubt, wenn ich"

	para "es nicht selbst"
	line "gesehen hätte!"
	done

WarmBeachCooltrainerfText:
	text "Ich wurde dieses"
	line "Jahr zur Festmaid"
	cont "erwählt,"

	para "also muss ich die"
	line "Melodie des Auser-"
	cont "wählten spielen."

	para "Ich bin ganz schön"
	line "nervös, deshalb"
	cont "übe ich hier."
	done

WarmBeachSlowkingScript:
	jumpthistext

	text "Eine Hose wäre"
	line "nicht schlecht…"
	done

WarmBeachLassScript:
	faceplayer
	opentext
	checkflag ENGINE_SEASHORE_SHELL_BELL
	iftrue_jumpopenedtext .Text3
	writetext .Text1
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext .Text4
	checkmoney YOUR_MONEY, 4000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	giveitem SHELL_BELL, iffalse_jumpopenedtext .Text6
	setflag ENGINE_SEASHORE_SHELL_BELL
	waitsfx
	playsound SFX_TRANSACTION
	takemoney YOUR_MONEY, 4000
	special PlaceMoneyTopRight
	jumpthisopenedtext

	text "Ein Seegesang,"
	line "nur für dich!"
	done

.NotEnoughMoney:
	jumpthisopenedtext

	text "Du hast nicht"
	line "genügend Geld…"
	done

.Text1:
	text "Ich sammle am"
	line "Strand Muscheln"

	para "und mache daraus"
	line "Seegesänge."

	para "Man sagt, ihr"
	line "Klang heilt."

	para "Sie kosten je"
	line "¥4000. Willst du"
	cont "einen?"
	done

.Text3:
	text "Heute habe ich nur"
	line "einen Seegesang"
	cont "gemacht…"
	done

.Text4:
	text "Schon gut!"
	done

.Text6:
	text "Du hast nicht"
	line "genug Platz…"
	done

WarmBeachLadyText:
	text "Die Inseln dort"
	line "drüben nennt man"

	para "die Tempel von"
	line "Feuer, Eis und"
	cont "Blitz."

	para "Das steht in"
	line "dieser Broschüre,"

	para "aber wozu sind"
	line "sie da?"
	done

WarmBeachShackSignText:
	text "Strandhütte"
	done

WarmBeachShrineText:
	text "Ein Schrein, der"
	line "dem Wächter der"

	para "Meere geweiht ist."
	done
