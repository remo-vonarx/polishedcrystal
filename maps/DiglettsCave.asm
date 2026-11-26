DiglettsCave_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 37, 15, VERMILION_CITY, 10
	warp_event 39, 13, DIGLETTS_CAVE, 5
	warp_event 37,  5, ROUTE_2_NORTH, 4
	warp_event 39,  3, DIGLETTS_CAVE, 6
	warp_event 37, 31, DIGLETTS_CAVE, 2
	warp_event  5,  5, DIGLETTS_CAVE, 4

	def_coord_events

	def_bg_events
	bg_event  8, 15, BGEVENT_ITEM + MAX_REVIVE, EVENT_DIGLETTS_CAVE_HIDDEN_MAX_REVIVE
	bg_event 34, 33, BGEVENT_ITEM + MAX_REPEL, EVENT_DIGLETTS_CAVE_HIDDEN_MAX_REPEL

	def_object_events
	object_event 11, 15, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, DiglettsCaveFossilManiacScript, -1
	object_event  5, 13, SPRITE_HIKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerHikerGerard, -1
	object_event 25, 31, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerHikerDent, -1
	object_event 16, 21, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBlackbeltInigo, -1
	object_event  9, 20, SPRITE_ENGINEER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerEngineerSmith, -1
	object_event 37, 13, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, DiglettsCavePokefanMText, -1
	object_event 20, 27, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, DiglettsCaveCooltrainerfText, -1
	itemball_event 13, 28, RARE_BONE, 1, EVENT_DIGLETTS_CAVE_RARE_BONE

DiglettsCaveFossilManiacScript:
	faceplayer
	opentext
	writetext .GreetingText
	promptbutton
	special Special_ChooseItem
	iffalse_jumpopenedtext .NoItemText
	special GetFossilManiacPrice
	iffalse_jumpopenedtext .WrongItemText
	special ItemManiac_SelectQuantity
	iffalse_jumpopenedtext .NoItemText
	special MultiplyMoneyByQuantity
	writetext .OfferText
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext .NoItemText
	special TakeItemFromMemWithQuantity
	waitsfx
	playsound SFX_TRANSACTION
	special Give_hMoneyTemp
	special PlaceMoneyTopRight
	jumpthisopenedtext

	text "Hey, thanks!"

	para "I bet I can sell"
	line "this for way more"
	cont "than I just gave"
	cont "you. Ha!"

	para "That's business"
	line "for ya!"
	done

.GreetingText:
	text "Hey, check it out."
	line "I've got a sweet"
	cont "deal for ya!"

	para "You know how #-"
	line "mon fossils turn"
	cont "up in rocks?"

	para "If you find one,"
	line "bring it to me."

	para "I'll make it worth"
	line "your while."
	done

.OfferText:
	text "Hey, nice! Let me"
	line "check that out."

	para "I'll give you"
	line "¥"
	text_decimal hMoneyTemp, 3, 7
	text " for it."
	cont "Whaddaya say?"
	done

.WrongItemText:
	text "Nope, this is no"
	line "good. Not worth"
	cont "my while."
	done

.NoItemText:
	text "…Nope, nothing"
	line "cool in your Bag."

	para "Oh well. Maybe"
	line "next time!"
	done

GenericTrainerHikerGerard:
	generictrainer HIKER, GERARD, EVENT_BEAT_HIKER_GERARD, .SeenText, .BeatenText

	text "Dieser Ort macht"
	line "mich so nervös."

	para "Was, wenn mich ein"
	line "Digda aus dem"
	cont "Nichts angreift?"
	done

.SeenText:
	text "Aah! Ich glaube,"
	line "der Fels hat sich"
	cont "eben bewegt!"
	done

.BeatenText:
	text "Das habe ich mir"
	line "wohl eingebildet."
	done

GenericTrainerHikerDent:
	generictrainer HIKER, DENT, EVENT_BEAT_HIKER_DENT, .SeenText, .BeatenText

	text "Ich passe bestens"
	line "zur Muskeltruppe"
	cont "der Arena von"
	cont "Marmoria City."

	para "Hohoh!"
	done

.SeenText:
	text "Ich bin auf dem"
	line "Weg nach Marmoria"
	cont "City."

	para "Die Gestein-Arena"
	line "dort ist perfekt"
	cont "für einen Muskel-"
	cont "protz wie mich!"
	done

.BeatenText:
	text "Hohoh!"
	line "Einer mit mehr"
	cont "Muskeln als ich!"
	done

GenericTrainerBlackbeltInigo:
	generictrainer BLACKBELT_T, INIGO, EVENT_BEAT_BLACKBELT_INIGO, .SeenText, .BeatenText

	text "Lautes Geschrei"
	line "macht dich nicht"
	cont "zum besseren"

	para "Kämpfer, aber es"
	line "schüchtert deine"
	cont "Gegner ein."
	done

.SeenText:
	text "Mach dich bereit"
	line "zum Kampf!"
	cont "HUU-HAH!"
	done

.BeatenText:
	text "HIIYAAAH!"
	done

GenericTrainerEngineerSmith:
	generictrainer ENGINEER, SMITH, EVENT_BEAT_ENGINEER_SMITH, .SeenText, .BeatenText

	text "Diese Digda sind"
	line "einfach geborene"
	cont "Ingenieure."
	done

.SeenText:
	text "Wie haben Digda"
	line "nur so einen"
	cont "langen Tunnel"
	cont "gegraben?"
	done

.BeatenText:
	text "Erstaunlich!"
	done

DiglettsCaveCooltrainerfText:
	text "Look at all these"
	line "cute Diglett!"

	para "I swear I saw one"
	line "with a blue nose!"
	done

DiglettsCavePokefanMText:
	text "A bunch of Diglett"
	line "popped out of the"

	para "ground! That was"
	line "shocking."

	para "I heard Diglett"
	line "on Cinnabar Island"
	cont "look different."
	done
