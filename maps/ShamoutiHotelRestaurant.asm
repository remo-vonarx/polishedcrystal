ShamoutiHotelRestaurant_MapScriptHeader:
	def_scene_scripts
	scene_script ShamoutiHotelRestaurantMeetScene, SCENE_SHAMOUTIHOTELRESTAURANT_MEET
	scene_const SCENE_SHAMOUTIHOTELRESTAURANT_NOOP

	def_callbacks

	def_warp_events
	warp_event 16,  7, SHAMOUTI_HOTEL_1F, 4
	warp_event 17,  7, SHAMOUTI_HOTEL_1F, 4

	def_coord_events
	coord_event 16,  6, SCENE_SHAMOUTIHOTELRESTAURANT_NOOP, ShamoutiHotelRestaurantLeavingTrigger1
	coord_event 16,  7, SCENE_SHAMOUTIHOTELRESTAURANT_NOOP, ShamoutiHotelRestaurantLeavingTrigger2

	def_bg_events

	def_object_events
	object_event 16,  4, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiHotelRestaurantReceptionistText, -1

	object_const_def
	const SHAMOUTIHOTELRESTAURANT_RECEPTIONIST

ShamoutiHotelRestaurantMeetScene:
	sdefer ShamoutiHotelRestaurantChallengeScript
	end

ShamoutiHotelRestaurantChallengeScript:
	applyonemovement PLAYER, step_up
	opentext
	checkflag ENGINE_SHAMOUTI_RESTAURANT_CHALLENGE
	iftruefwd .AlreadyAte
	writetext .GreetingText
	special PlaceMoneyTopRight
	yesorno
	iffalsefwd .NeverMind
	checkmoney YOUR_MONEY, 5000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	setflag ENGINE_SHAMOUTI_RESTAURANT_CHALLENGE
	waitsfx
	playsound SFX_TRANSACTION
	takemoney YOUR_MONEY, 5000
	special PlaceMoneyTopRight
	writetext ShamoutiHotelRestaurantReceptionistText
	waitbutton
	closetext
	applyonemovement PLAYER, step_left
	setscene SCENE_SHAMOUTIHOTELRESTAURANT_NOOP
	end

.AlreadyAte:
	writetext .AlreadyAteText
	sjumpfwd ShamoutiHotelRestaurantLeaveScript

.NeverMind:
	writetext .NeverMindText
	sjumpfwd ShamoutiHotelRestaurantLeaveScript

.NotEnoughMoney:
	writetext .NotEnoughMoneyText
	sjumpfwd ShamoutiHotelRestaurantLeaveScript

.GreetingText:
	text "Willkommen im"
	line "Restaurant Oase."

	para "Hier genießt man"
	line "nicht nur Essen,"

	para "sondern auch"
	line "#mon-Kämpfe."

	para "Jeden Tag gibt es"
	line "ein neues Menü."

	para "Die Gebühr beträgt"
	line "¥5000. Möchtest du"
	cont "teilnehmen?"
	done

.AlreadyAteText:
	text "Es tut mir sehr"
	line "leid, aber du"
	cont "warst heute schon"
	cont "hier."

	para "Bitte besuche uns"
	line "morgen wieder."
	done

.NeverMindText:
	text "Ich verstehe."
	line "Einen schönen Tag!"
	done

.NotEnoughMoneyText:
	text "Es tut mir sehr"
	line "leid, aber du hast"
	cont "nicht genügend"
	cont "Geld."
	done

ShamoutiHotelRestaurantLeavingTrigger2:
	applyonemovement PLAYER, step_up
ShamoutiHotelRestaurantLeavingTrigger1:
	turnobject PLAYER, UP
	turnobject SHAMOUTIHOTELRESTAURANT_RECEPTIONIST, DOWN
	opentext
	writetext .LeavingText
	yesorno
	iffalsefwd .Staying
	writetext .GoodbyeText
	sjumpfwd ShamoutiHotelRestaurantLeaveScript

.Staying:
	writetext ShamoutiHotelRestaurantReceptionistText
	waitbutton
	closetext
	applyonemovement PLAYER, step_left
	end

.LeavingText:
	text "Möchtest du jetzt"
	line "gehen?"
	done

.GoodbyeText:
	text "Danke für deinen"
	line "Besuch."

	para "Bitte besuche uns"
	line "morgen wieder."
	done

ShamoutiHotelRestaurantLeaveScript:
	waitbutton
	closetext
	applyonemovement PLAYER, step_down
	special FadeOutPalettes
	playsound SFX_ENTER_DOOR
	waitsfx
	warp SHAMOUTI_HOTEL_1F, 14, 0
	end

ShamoutiHotelRestaurantReceptionistText:
	text "Genieße ein Essen"
	line "und einen Kampf."
	done
