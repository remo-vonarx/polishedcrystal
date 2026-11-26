SafariZoneNorth_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 41, 32, SAFARI_ZONE_EAST, 3
	warp_event 41, 33, SAFARI_ZONE_EAST, 4
	warp_event 10, 37, SAFARI_ZONE_WEST, 3
	warp_event 11, 37, SAFARI_ZONE_WEST, 4
	warp_event 22, 37, SAFARI_ZONE_HUB, 7
	warp_event 23, 37, SAFARI_ZONE_HUB, 8
	warp_event 37,  5, SAFARI_ZONE_NORTH_REST_HOUSE, 1
	warp_event  4, 37, SAFARI_ZONE_WEST, 1
	warp_event  5, 37, SAFARI_ZONE_WEST, 2

	def_coord_events

	def_bg_events
	bg_event 15, 33, BGEVENT_JUMPTEXT, SafariZoneNorthAreaSignText
	bg_event 38,  6, BGEVENT_JUMPTEXT, SafariZoneNorthRestHouseSignText
	bg_event 28, 30, BGEVENT_JUMPTEXT, SafariZoneNorthTrainerTips1SignText
	bg_event 20, 34, BGEVENT_JUMPTEXT, SafariZoneNorthTrainerTips2SignText
	bg_event  5, 27, BGEVENT_JUMPTEXT, SafariZoneNorthTrainerTips3SignText
	bg_event 31, 19, BGEVENT_ITEM + LUCKY_PUNCH, EVENT_SAFARI_ZONE_NORTH_HIDDEN_LUCKY_PUNCH

	def_object_events
	object_event 18, 23, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBattleGirlPadma, -1
	object_event  7,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerYoungsterTyler, -1
	object_event 36,  9, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBeautyRachael, -1
	object_event 15, 14, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, SafariZoneNorthCooltrainerFScript, -1
	itemball_event 24, 18, EVIOLITE, 1, EVENT_SAFARI_ZONE_NORTH_EVIOLITE
	itemball_event 21,  9, PROTEIN, 1, EVENT_SAFARI_ZONE_NORTH_PROTEIN

GenericTrainerBattleGirlPadma:
	generictrainer BATTLE_GIRL, PADMA, EVENT_BEAT_BATTLE_GIRL_PADMA, BattleGirlPadmaSeenText, BattleGirlPadmaBeatenText

	text "Wenn du deine Ge-"
	line "fühle ins Training"

	para "steckst, wirst du"
	line "stark!"
	done

GenericTrainerYoungsterTyler:
	generictrainer YOUNGSTER, TYLER, EVENT_BEAT_YOUNGSTER_TYLER, YoungsterTylerSeenText, YoungsterTylerBeatenText

	text "#mon springen"
	line "hervor, wenn du es"
	cont "am wenigsten"
	cont "erwartest."
	done

GenericTrainerBeautyRachael:
	generictrainer BEAUTY, RACHAEL, EVENT_BEAT_BEAUTY_RACHAEL, BeautyRachaelSeenText, BeautyRachaelBeatenText

	text "Noch vor einem"
	line "Jahr war ich"
	cont "Schwarzgurt."

	para "Die Macht der"
	line "Medizin"

	para "ist erstaunlich,"
	line "findest du nicht?"
	done

SafariZoneNorthCooltrainerFScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_DOUBLE_EDGE_INTRO
	iftruefwd SafariZoneNorthTutorDoubleEdgeScript
	writetext SafariZoneNorthCooltrainerFText
	waitbutton
	setevent EVENT_LISTENED_TO_DOUBLE_EDGE_INTRO
SafariZoneNorthTutorDoubleEdgeScript:
	writetext Text_SafariZoneNorthTutorDoubleEdge
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writetext Text_SafariZoneNorthTutorQuestion
	yesorno
	iffalsefwd .TutorRefused
	setval DOUBLE_EDGE
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpthisopenedtext

	text "Oh well."
	done

.NoSilverLeaf
	jumpthisopenedtext

	text "You don't have any"
	line "Silver Leaves…"
	done

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext

	text "There!"
	line "Now your #mon"

	para "knows how to use"
	cont "Double-Edge!"
	done

BattleGirlPadmaSeenText:
	text "Ich mache mit"
	line "meinen #mon"
	cont "Übungskämpfe, um"
	cont "als Team besser"
	cont "zu werden!"
	done

BattleGirlPadmaBeatenText:
	text "Wir müssen härter"
	line "trainieren!"
	done

YoungsterTylerSeenText:
	text "#mon findest du"
	line "überall!"

	para "Im Gras, im Was-"
	line "ser, in Höhlen"
	cont "oder auf Bäumen!"
	done

YoungsterTylerBeatenText:
	text "Ich muss weiter-"
	line "suchen!"
	done

BeautyRachaelSeenText:
	text "Mein Sommerkleid"
	line "ist perfekt für"
	cont "einen Tag in der"
	cont "Safari-Zone!"
	done

BeautyRachaelBeatenText:
	text "Zum Kämpfen ist"
	line "es nicht so toll…"
	done

SafariZoneNorthCooltrainerFText:
	text "I caught a"
	line "Chansey!"

	para "I'm so lucky!"
	line "I'm going to teach"

	para "it to do a really"
	line "powerful tackle."

	para "Let me share my"
	line "luck with you!"
	done

Text_SafariZoneNorthTutorDoubleEdge:
	text "I'll teach your"
	line "#mon how to"

	para "use Double-Edge"
	line "for a Silver Leaf."
	done


Text_SafariZoneNorthTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Double-Edge?"
	done



SafariZoneNorthAreaSignText:
	text "Safari-Zone"
	line "Nordbereich"
	done

SafariZoneNorthRestHouseSignText:
	text "Rasthaus"
	done

SafariZoneNorthTrainerTips1SignText:
	text "Tipps für Trainer"

	para "Attacken desselben"
	line "Typs können Kör-"
	cont "per-, Spezial-"
	cont "oder Status-At-"
	cont "tacken sein."
	done

SafariZoneNorthTrainerTips2SignText:
	text "Tipps für Trainer"

	para "#mon verstecken"
	line "sich im hohen"
	cont "Gras!"

	para "Lauf im Zickzack"
	line "durchs Gras, um"
	cont "sie aufzustöbern."
	done

SafariZoneNorthTrainerTips3SignText:
	text "Tipps für Trainer"

	para "Der Rest des"
	line "Schildes wurde"
	cont "abgerissen…"
	done
