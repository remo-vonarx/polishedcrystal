GoldenrodBikeShop_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 2
	warp_event  3,  7, GOLDENROD_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  1,  2, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  0,  3, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  1,  3, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  0,  5, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  1,  5, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  0,  6, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  1,  6, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  6,  6, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  7,  6, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  3,  0, BGEVENT_JUMPTEXT, GoldenrodBikeShopJustReleasedCompactBikeText

	def_object_events
	object_event  7,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodBikeShopClerkScript, -1

GoldenrodBikeShopClerkScript:
	checkevent EVENT_GOT_BICYCLE
	iftrue_jumptextfaceplayer GoldenrodBikeShopClerkFirstRateBikesText
	faceplayer
	opentext
	writetext GoldenrodBikeShopClerkIntroText
	yesorno
	iffalse_jumpopenedtext GoldenrodBikeShopClerkRefusedText
	writetext GoldenrodBikeShopClerkAgreedText
	promptbutton
	waitsfx
	verbosegivekeyitem BICYCLE
	setflag ENGINE_BIKE_SHOP_CALL_ENABLED
	setevent EVENT_GOT_BICYCLE
	jumpthisopenedtext

GoldenrodBikeShopClerkFirstRateBikesText:
	text "Meine Fahrräder"
	line "sind erste Klasse!"

	para "Du kannst sie"
	line "überall fahren."
	done

GoldenrodBikeShopClerkIntroText:
	text "…sigh… I opened"
	line "a branch here,"

	para "but I can't sell"
	line "my Bicycles."
	cont "Why is that?"

	para "Could you ride a"
	line "Bicycle and adver-"
	cont "tise for me?"
	done

GoldenrodBikeShopClerkAgreedText:
	text "Ja? Großartig!"

	para "Gib mir bitte"
	line "Namen und Nummer."

	para "Dann leihe ich dir"
	line "ein Fahrrad."
	done

GoldenrodBikeShopClerkRefusedText:
	text "…Seufz… Oh, für"
	line "die Güte der"
	cont "Menschen…"
	done

GoldenrodBikeShopBicycleText:
	text "Ein nagelneues"
	line "Fahrrad!"
	done

GoldenrodBikeShopJustReleasedCompactBikeText:
	text "Brandneu!"

	para "Erste Klasse Kom-"
	line "pakt-Fahrräder!"
	done
