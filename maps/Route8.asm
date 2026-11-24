Route8_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 10, ROUTE_8_SAFFRON_GATE, 3
	warp_event  4, 11, ROUTE_8_SAFFRON_GATE, 4

	def_coord_events

	def_bg_events
	bg_event  8,  8, BGEVENT_JUMPTEXT, Route8UndergroundPathSignText
	bg_event 10,  7, BGEVENT_JUMPTEXT, Route7LockedDoorText

	def_object_events
	object_event 12, 10, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 5, TrainerBikerDwayne, EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	object_event 12, 11, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 5, TrainerBikerHarris, EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	object_event 12, 12, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_DARK_BLUE, OBJECTTYPE_TRAINER, 5, TrainerBikerZeke, EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	object_event 19,  9, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSupernerdSam, -1
	object_event 34,  9, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSupernerdTom, -1
	object_event 43, 14, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGentlemanMilton, -1
	object_event 23,  4, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleMoeandlulu1, -1
	object_event 24,  4, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleMoeandlulu2, -1
	object_event 31,  4, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerLassMeadow, -1
	cuttree_event 23, 14, EVENT_ROUTE_8_CUT_TREE_1
	cuttree_event 34, 12, EVENT_ROUTE_8_CUT_TREE_2
	fruittree_event 45,  7, FRUITTREE_ROUTE_8, SALAC_BERRY, PAL_NPC_GREEN
	object_event  8,  9, SPRITE_BIKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route8BikerDwayneProtestText, EVENT_ROUTE_8_PROTESTORS
	object_event  9, 10, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route8BikerHarrisProtestText, EVENT_ROUTE_8_PROTESTORS
	object_event  8, 11, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_DARK_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route8BikerZekeProtestText, EVENT_ROUTE_8_PROTESTORS

TrainerBikerDwayne:
	trainer BIKER, DWAYNE, EVENT_BEAT_BIKER_DWAYNE, BikerDwayneSeenText, BikerDwayneBeatenText, 0, .Script, TRAINERPAL_BIKER_DWAYNE

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Die #mon-"
	line "Trainergilde aus"
	cont "Kanto wird"
	cont "immer existieren!"
	done

TrainerBikerHarris:
	trainer BIKER, HARRIS, EVENT_BEAT_BIKER_HARRIS, BikerHarrisSeenText, BikerHarrisBeatenText, 0, .Script, TRAINERPAL_BIKER_HARRIS

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Vermöbelt von"
	line "einem Rowdy aus"
	cont "Johto…"
	done

TrainerBikerZeke:
	trainer BIKER, ZEKE, EVENT_BEAT_BIKER_ZEKE, BikerZekeSeenText, BikerZekeBeatenText, 0, .Script, TRAINERPAL_BIKER_ZEKE

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Wir versuchen,"
	line "ab jetzt niemanden"
	cont "mehr zu stören…"
	done

GenericTrainerSupernerdSam:
	generictrainer SUPER_NERD, SAM, EVENT_BEAT_SUPER_NERD_SAM, SupernerdSamSeenText, SupernerdSamBeatenText

	text "Die Kraft von"
	line "Magneten ist"
	cont "beeindruckend!"
	done

GenericTrainerSupernerdTom:
	generictrainer SUPER_NERD, TOM, EVENT_BEAT_SUPER_NERD_TOM, SupernerdTomSeenText, SupernerdTomBeatenText

	text "Gym Badges are"
	line "proof of your"
	cont "skill at battles."
	done

GenericTrainerGentlemanMilton:
	generictrainer GENTLEMAN, MILTON, EVENT_BEAT_GENTLEMAN_MILTON, GentlemanMiltonSeenText, GentlemanMiltonBeatenText

	text "Stopping in the"
	line "road for a battle"
	cont "isn't rude."

	para "No matter what,"
	line "I am a gentleman"
	cont "first!"
	done

GenericTrainerCoupleMoeandlulu1:
	generictrainer COUPLE, MOEANDLULU1, EVENT_BEAT_COUPLE_MOE_AND_LULU, CoupleMoeandlulu1SeenText, CoupleMoeandlulu1BeatenText

	text "Moe: In short,"
	line "you're just too"
	cont "strong…"
	done

GenericTrainerCoupleMoeandlulu2:
	generictrainer COUPLE, MOEANDLULU2, EVENT_BEAT_COUPLE_MOE_AND_LULU, CoupleMoeandlulu2SeenText, CoupleMoeandlulu2BeatenText

	text "Lulu: It's not that"
	line "Moe's weak, it's"

	para "that you're too"
	line "strong!"
	done

GenericTrainerLassMeadow:
	generictrainer LASS, MEADOW, EVENT_BEAT_LASS_MEADOW, LassMeadowSeenText, LassMeadowBeatenText

	text "Oh well, I'm more"
	line "worried about"

	para "having fun than"
	line "being competitive."
	done

Route8BikerDwayneProtestText:
	text "We're the Kanto"
	line "#mon Federation"
	cont "trainer group."

	para "We're holding a"
	line "protest!"
	done

Route8BikerZekeProtestText:
	text "We're the Kanto"
	line "#mon Federa-"
	cont "tion!"

	para "The cops can't"
	line "stop us from"

	para "using the Under-"
	line "ground Path!"
	done

BikerDwayneSeenText:
	text "Wir repräsentieren"
	line "die #mon-"
	cont "Trainergilde aus"
	cont "Kanto."

	para "Hier kommst du"
	line "unter die Räder!"
	done

BikerDwayneBeatenText:
	text "En-entschuldigung!"
	done

Route8BikerHarrisProtestText:
BikerHarrisSeenText:
	text "Das Ordnungsamt"
	line "hat unseren"

	para "Tunnelpfad zu-"
	line "schütten lassen."
	cont "Das ängstigt mich!"
	done

BikerHarrisBeatenText:
	text "V-vergib mir!"
	done

BikerZekeSeenText:
	text "Wir sind die"
	line "#mon-Trainer-"
	cont "gilde aus Kanto!"
	cont "Nimm dich in Acht!"
	done

BikerZekeBeatenText:
	text "Uah! Entschuldige!"
	done

SupernerdSamSeenText:
	text "Wie funktioniert"
	line "der Magnetzug?"
	done

SupernerdSamBeatenText:
	text "Ich möchte nur den"
	line "Magnetzug sehen…"
	done

SupernerdTomSeenText:
	text "Hm… Du hast"
	line "viele Orden."
	done

SupernerdTomBeatenText:
	text "Wie ich dachte…"
	line "Du bist stark!"
	done

GentlemanMiltonSeenText:
	text "Would you care to"
	line "join me in a"
	cont "quick contest?"
	done

GentlemanMiltonBeatenText:
	text "You were very"
	line "skillful."
	done

CoupleMoeandlulu1SeenText:
	text "Moe: Do I look"
	line "weak? Don't make"
	cont "me laugh!"

	para "When I'm with Lulu,"
	line "I've got a hundred"
	cont "times the courage!"
	done

CoupleMoeandlulu1BeatenText:
	text "Moe: Uwaaaahhh…"
	done

CoupleMoeandlulu2SeenText:
	text "Lulu: Moe and I"
	line "make a great pair!"

	para "You should prepare"
	line "yourself!"
	done

CoupleMoeandlulu2BeatenText:
	text "Lulu: Eeek!"
	done

LassMeadowSeenText:
	text "I like skirts!"
	line "They're cute and"
	cont "comfy to wear!"
	done

LassMeadowBeatenText:
	text "Oh my!"
	done

Route8UndergroundPathSignText:
	text "Das Flugblatt ist"
	line "zerrissen."

	para "Es ist nicht mehr"
	line "lesbar…"
	done
