ViridianCity_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, ViridianCityFlyPoint

	def_warp_events
	warp_event 30,  7, VIRIDIAN_GYM, 1
	warp_event 21,  5, VIRIDIAN_NICKNAME_SPEECH_HOUSE, 1
	warp_event 21, 15, TRAINER_HOUSE_1F, 1
	warp_event 29, 19, VIRIDIAN_MART, 2
	warp_event 23, 25, VIRIDIAN_POKECENTER_1F, 1
	warp_event 20, 33, ROUTE_1_VIRIDIAN_GATE, 1
	warp_event 21, 33, ROUTE_1_VIRIDIAN_GATE, 2
	warp_event 21,  9, VIRIDIAN_SCHOOL_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 17, 17, BGEVENT_JUMPTEXT, ViridianCitySignText
	bg_event 31,  7, BGEVENT_JUMPTEXT, ViridianGymSignText
	bg_event 19,  1, BGEVENT_JUMPTEXT, ViridianCityTrainerTips1Text
	bg_event 21, 29, BGEVENT_JUMPTEXT, ViridianCityTrainerTips2Text
	bg_event 24, 16, BGEVENT_JUMPTEXT, TrainerHouseSignText

	def_object_events
	object_event 18,  5, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 2, 2, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianCityCoffeeGramps, -1
	object_event 30,  8, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ViridianCityGrampsNearGym, EVENT_BLUE_IN_CINNABAR
	object_event 33,  8, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ViridianCityGrampsNearGym, EVENT_VIRIDIAN_GYM_BLUE
	object_event  6, 23, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ViridianCityDreamEaterFisher, -1
	object_event 17, 21, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 3, 3, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, ViridianCityYoungsterText, -1
	object_event 31, 23, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WANDER, 1, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, ViridianCityYoungster2Text, -1
	cuttree_event 14,  4, EVENT_VIRIDIAN_CITY_CUT_TREE_1
	cuttree_event  8, 22, EVENT_VIRIDIAN_CITY_CUT_TREE_2

ViridianCityFlyPoint:
	setflag ENGINE_FLYPOINT_VIRIDIAN
	endcallback

ViridianCityCoffeeGramps:
	faceplayer
	opentext
	writetext ViridianCityCoffeeGrampsQuestionText
	yesorno
	iffalse_jumpopenedtext ViridianCityCoffeeGrampsDoubtedText
	jumpthisopenedtext

	text "Also gut. Ja, ich"
	line "war wirklich etwas"

	para "Besonderes, das"
	line "kann ich dir"
	cont "sagen!"
	done

ViridianCityGrampsNearGym:
	checkevent EVENT_BLUE_IN_CINNABAR
	iftrue_jumptextfaceplayer ViridianCityGrampsNearGymBlueReturnedText
	jumpthistextfaceplayer

	text "Bis vor kurzem"
	line "gab es in dieser"
	cont "PKMN-Arena"
	cont "keinen Leiter."

	para "Ein junger Mann"
	line "aus Alabastia ist"

	para "hier der Leiter"
	line "geworden, aber er"
	cont "ist oft unterwegs."
	done

ViridianCityDreamEaterFisher:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_DREAM_EATER_INTRO
	iftruefwd ViridianCityTutorDreamEaterScript
	writetext ViridianCityDreamEaterFisherText
	waitbutton
	setevent EVENT_LISTENED_TO_DREAM_EATER_INTRO
ViridianCityTutorDreamEaterScript:
	writetext Text_ViridianCityTutorDreamEater
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writetext Text_ViridianCityTutorQuestion
	yesorno
	iffalsefwd .TutorRefused
	setval DREAM_EATER
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_ViridianCityTutorRefused

.NoSilverLeaf
	jumpthisopenedtext

	text "You don't have any"
	line "Silver Leaves…"
	done

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext

	text "Now your #mon"
	line "knows how to use"
	cont "Dream Eater…"

	para "…Zzzzz…"
	done

ViridianCityCoffeeGrampsQuestionText:
	text "He, Kurzbein! Ich"
	line "hatte gerade einen"

	para "doppelten Espresso"
	line "und ich bin"
	cont "total aufgedreht!"

	para "Ich brauche jetzt"
	line "jemanden zum"
	cont "Reden und zwar"
	cont "dich!"

	para "Man sieht es mir"
	line "jetzt vielleicht"

	para "nicht mehr an,"
	line "aber ich war ein"
	cont "Experte im Fangen"
	cont "von #mon."

	para "Glaubst du mir?"
	done


ViridianCityCoffeeGrampsDoubtedText:
	text "Was? Du kleiner"
	line "Frechdachs!"

	para "Wenn ich etwas"
	line "jünger wäre, würde"

	para "ich dir schon das"
	line "eine oder andere"
	cont "zeigen! Grummel."
	done


ViridianCityGrampsNearGymBlueReturnedText:
	text "Wirst du den"
	line "Arenaleiter"
	cont "herausfordern?"

	para "Viel Glück! Du"
	line "wirst es brauchen."
	done

ViridianCityDreamEaterFisherText:
	text "Yawn!"

	para "I must have dozed"
	line "off in the sun."

	para "…I had this dream"
	line "about a Drowzee"

	para "eating my dream."
	line "And…"

	para "I learned how to"
	line "eat dreams…"

	para "Ooh, this is too"
	line "spooky!"
	cont "But now…"
	done

Text_ViridianCityTutorDreamEater:
	text "I can teach your"
	line "#mon to eat"
	cont "dreams."

	para "I just want a"
	line "Silver Leaf in"
	cont "exchange."
	done


Text_ViridianCityTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Dream Eater?"
	done

Text_ViridianCityTutorRefused: ; text > text
	text "OK…"
	done


ViridianCityYoungsterText:
	text "Ich habe gehört,"
	line "dass man viele"

	para "Items im Vertania-"
	line "Wald findet."
	done

ViridianCityYoungster2Text:
	text "The leader of Team"
	line "Rocket was the Gym"

	para "Leader here for a"
	line "time, but one day"

	para "three years ago"
	line "he vanished."

	para "He wasn't usually"
	line "at the Gym anyway…"
	done

ViridianCitySignText:
	text "Vertania City"

	para "Das Immergrüne"
	line "Paradies"
	done

ViridianGymSignText:
	text "PKMN-Arena von"
	line "Vertania City"
	cont "Leitung: …"

	para "Der Rest des Tex-"
	line "tes ist unlesbar…"
	done

ViridianCityTrainerTips1Text:
	text "Trainer Tips"

	para "Catch #mon"
	line "and expand your"
	cont "collection!"

	para "The more you have,"
	line "the easier it is"
	cont "to fight!"
	done

ViridianCityTrainerTips2Text:
	text "Trainer Tips"

	para "The world is a"
	line "big place!"

	para "Don't just run or"
	line "Fly everywhere--"
	cont "look around you!"

	para "You'll find new and"
	line "exciting things!"
	done

TrainerHouseSignText:
	text "Trainer-Haus"

	para "Der Club, in dem"
	line "Top-Trainer"
	cont "kämpfen"
	done
