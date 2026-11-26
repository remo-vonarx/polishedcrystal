Route17South_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route17SouthAlwaysOnBikeCallback

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event 11, 69, BGEVENT_ITEM + MAX_ETHER, EVENT_ROUTE_17_SOUTH_HIDDEN_MAX_ETHER
	bg_event 10, 121, BGEVENT_ITEM + MAX_ELIXIR, EVENT_ROUTE_17_SOUTH_HIDDEN_MAX_ELIXIR
	bg_event  9, 62, BGEVENT_JUMPTEXT, Route17SouthNotice1Text
	bg_event  9, 69, BGEVENT_JUMPTEXT, Route17SouthTrainerTips1Text
	bg_event  9, 92, BGEVENT_JUMPTEXT, Route17SouthTrainerTips2Text
	bg_event  9, 99, BGEVENT_JUMPTEXT, Route17SouthNotice2Text

	def_object_events
	object_event 12,  7, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBikerDale, -1
	object_event  4, 15, SPRITE_BIKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBikerReilly, -1
	object_event 18, 22, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBikerJacob, -1
	object_event  2, 35, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBikerDan, -1
	object_event  3, 54, SPRITE_BIKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBikerGlenn, -1
	object_event 11, 63, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBikerJoel, -1
	object_event 13, 70, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBikerAiden, -1
	object_event  3, 84, SPRITE_BIKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBikerTeddy, -1
	object_event  6, 127, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event  1, 27, SPRITE_ROUGHNECK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerRoughneckBrian, -1
	object_event  6, 40, SPRITE_ROUGHNECK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerRoughneckTheron, -1
	object_event  4, 89, SPRITE_ROUGHNECK, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerRoughneckMarkey, -1

Route17SouthAlwaysOnBikeCallback:
	setflag ENGINE_ALWAYS_ON_BIKE
	setflag ENGINE_DOWNHILL
	endcallback

GenericTrainerBikerReilly:
	generictrainer BIKER, REILLY, EVENT_BEAT_BIKER_REILLY, BikerReillySeenText, BikerReillyBeatenText

	text "Wer't nicht frech,"
	line "du Null aus Johto!"
	done

BikerReillySeenText:
	text "Heh, du! Bist"
	line "du aus Johto?"
	done

BikerReillyBeatenText:
	text "Boah, du legst"
	line "aber los!"
	done

GenericTrainerBikerJoel:
	generictrainer BIKER, JOEL, EVENT_BEAT_BIKER_JOEL, BikerJoelSeenText, BikerJoelBeatenText

	text "Ich sehe zwar cool"
	line "aus, bin aber"
	cont "schwach, also bin"
	cont "ich nicht wirklich"
	cont "cool."

	para "Ich muss härter"
	line "trainieren…"
	done

BikerJoelSeenText:
	text "Wow! Das ist ein"
	line "tolles Fahrrad!"
	done

BikerJoelBeatenText:
	text "Aber du siehst"
	line "nicht nur cool"
	cont "aus…"
	done

GenericTrainerBikerGlenn:
	generictrainer BIKER, GLENN, EVENT_BEAT_BIKER_GLENN, BikerGlennSeenText, BikerGlennBeatenText

	text "Freihändig fahren"
	line "gilt als cool"
	cont "auf dem Radweg."
	done

BikerGlennSeenText:
	text "Hey! Wie wäre"
	line "es mit einem"
	cont "Schnellkampf?"
	done

BikerGlennBeatenText:
	text "Ups! Du hast"
	line "ganz schön Kraft!"
	done

GenericTrainerBikerDale:
	generictrainer BIKER, DALE, EVENT_BEAT_BIKER_DALE, BikerDaleSeenText, BikerDaleBeatenText

	text "Du bist so cool!"
	line "Du machst nichts"
	cont "halbherzig!"
	done

BikerDaleSeenText:
	text "Du wirst verlie-"
	line "ren! Ich hab da so"
	cont "ein Gefühl!"
	done

BikerDaleBeatenText:
	text "Vielleicht lag ich"
	line "mit meinem Gefühl"
	cont "etwas daneben…"
	done

GenericTrainerBikerJacob:
	generictrainer BIKER, JACOB, EVENT_BEAT_BIKER_JACOB, BikerJacobSeenText, BikerJacobBeatenText

	text "Chopper? Oh, ich"
	line "meinte mein"
	cont "Fahrrad!"
	done

BikerJacobSeenText:
	text "Meinen Chopper zu"
	line "tunen kostet"

	para "einen Haufen Geld!"
	line "Ich brauch 'nen"
	cont "Job!"
	done

BikerJacobBeatenText:
	text "Argh. Daneben!"
	done

GenericTrainerBikerAiden:
	generictrainer BIKER, AIDEN, EVENT_BEAT_BIKER_AIDEN, BikerAidenSeenText, BikerAidenBeatenText

	text "Gaon gaooon!"
	line "Buwaribaribari…!"

	para "So, meine Motoren-"
	line "Imitation hat sich"
	cont "entwickelt!"
	done

BikerAidenSeenText:
	text "Brumm brumm!"
	line "Baribaribaribari!"

	para "Wie findest du"
	line "meine Motoren-"
	cont "Imitation?"
	done

BikerAidenBeatenText:
	text "Hnnff… hnnff…"
	line "Ich bin außer"
	cont "Atem…"
	done

GenericTrainerBikerDan:
	generictrainer BIKER, DAN, EVENT_BEAT_BIKER_DAN, BikerDanSeenText, BikerDanBeatenText

	text "Ich liebe diese"
	line "melancholische"
	cont "Melodie."

	para "Sie passt einfach"
	line "zu mir…"
	done

BikerDanSeenText:
	text "Parara parapara"
	line "para-parara!"

	para "Meine Hupe hat"
	line "einen tollen"
	cont "Klang, oder?"
	done

BikerDanBeatenText:
	text "Paaraaraaaaa…"
	done

GenericTrainerBikerTeddy:
	generictrainer BIKER, TEDDY, EVENT_BEAT_BIKER_TEDDY, BikerTeddySeenText, BikerTeddyBeatenText

	text "Ich mag auch, wie"
	line "du kämpfst! Ich"
	cont "bin jetzt dein"
	cont "Fan!"
	done

BikerTeddySeenText:
	text "Hey, du fährst ja"
	line "ein cooles Rad!"
	done

BikerTeddyBeatenText:
	text "Gut gemacht."
	done

GenericTrainerRoughneckBrian:
	generictrainer ROUGHNECK, BRIAN, EVENT_BEAT_ROUGHNECK_BRIAN, RoughneckBrianSeenText, RoughneckBrianBeatenText

	text "Bis später!"
	line "Komm jederzeit"
	cont "wieder!"
	done

RoughneckBrianSeenText:
	text "Hey, wer hat dir"
	line "erlaubt, auf"
	cont "dieser Straße zu"
	cont "fahren?"
	done

RoughneckBrianBeatenText:
	text "Krach!"
	done

GenericTrainerRoughneckTheron:
	generictrainer ROUGHNECK, THERON, EVENT_BEAT_ROUGHNECK_THERON, RoughneckTheronSeenText, RoughneckTheronBeatenText

	text "Willst du in mein"
	line "Team?"

	para "Versuch es doch"
	line "mal!"
	done

RoughneckTheronSeenText:
	text "Ich mach dich"
	line "härter. Komm"
	cont "jetzt mit mir mit."
	done

RoughneckTheronBeatenText:
	text "Ich hab verloren."
	line "Verloren!"
	done

GenericTrainerRoughneckMarkey:
	generictrainer ROUGHNECK, MARKEY, EVENT_BEAT_ROUGHNECK_MARKEY, RoughneckMarkeySeenText, RoughneckMarkeyBeatenText

	text "Na also!"

	para "Der Kampfschrei"
	line "war super!"
	done

RoughneckMarkeySeenText:
	text "Hey hey hey!"
	line "Du stehst mir im"
	cont "Weg!"

	para "IM WEG!"
	done

RoughneckMarkeyBeatenText:
	text "Na gut, danke!"
	done

Route17SouthNotice1Text:
	text "It's a notice."

	para "Watch out for"
	line "discarded items!"
	done

Route17SouthTrainerTips1Text:
	text "Trainer Tips"

	para "All #mon are"
	line "unique."

	para "Two #mon of the"
	line "same species and"
	cont "level may still"

	para "look, act, and"
	line "grow differently."
	done

Route17SouthTrainerTips2Text:
	text "Trainer Tips"

	para "Open the Start"
	line "menu to stay in"
	cont "place while on a"
	cont "slope."
	done

Route17SouthNotice2Text:
	text "It's a notice."

	para "Don't throw the"
	line "game, throw #"
	cont "Balls instead!"
	done
