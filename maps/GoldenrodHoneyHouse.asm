GoldenrodHoneyHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 21
	warp_event  3,  7, GOLDENROD_CITY, 21

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodHoneyHousePokefanFScript, -1
	pokemon_event  6,  3, BUTTERFREE, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_BLUE, GoldenrodHoneyHouseButterfreeText, -1

GoldenrodHoneyHousePokefanFScript:
	checkevent EVENT_GOT_HONEY_FROM_GOLDENROD
	iftruefwd .SellHoney
	faceplayer
	opentext
	writetext .IntroText
	promptbutton
	verbosegiveitem SWEET_HONEY, iffalse_endtext
	setevent EVENT_GOT_HONEY_FROM_GOLDENROD
	jumpthisopenedtext

	text "Mein kleiner Bru-"
if DEF(FAITHFUL)
	line "der verteilt Honig"
else
	line "der verteilt Honig"
endc
	cont "im hohen Gras."

	para "Damit lockt er"
	line "#mon an."

	para "Meistens zieht er"
	line "#mon an, die"
	cont "das gleiche Level"
	cont "wie deine haben!"

	para "Wenn er dir ge-"
	line "fällt, verkaufe"
	cont "ich dir gern mehr."
	done

.IntroText:
	text "Mein #mon ist"
	line "ein Experte im"
if DEF(FAITHFUL)
	cont "Honigsammeln."
else
	cont "Honigsammeln."
endc

	para "Ich gebe dir"
	line "etwas davon ab."
	done

.SellHoney:
	faceplayer
	opentext
	writetext .SellText
	special PlaceMoneyTopRight
	loadmenu .MenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, .Buy1
	ifequalfwd $2, .Buy10
	jumpthisopenedtext ; cancel

	text "Komm bald wieder,"
	line "Schätzchen!"
	done

.Buy1:
	checkmoney YOUR_MONEY, 1000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	giveitem SWEET_HONEY, iffalse_jumpopenedtext .BagFullText
	takemoney YOUR_MONEY, 1000
	sjumpfwd .Done

.Buy10:
	checkmoney YOUR_MONEY, 10000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	giveitems SWEET_HONEY, 10, iffalse_jumpopenedtext .BagFullText
	takemoney YOUR_MONEY, 10000

.Done:
	special PlaceMoneyTopRight
	waitsfx
	playsound SFX_TRANSACTION
	writetext .GoodbyeText
	promptbutton
	itemnotify
	endtext

.NotEnoughMoney:
	jumpthisopenedtext

	text "Du hast nicht"
	line "genügend Geld,"
	cont "Schätzchen!"
	done

.SellText:
	text "Möchtest du etwas"
if DEF(FAITHFUL)
	line "Honig kaufen? Er"

	para "lockt #mon an."
else
	line "Honig kaufen? Er"

	para "lockt #mon an."
endc
	line "Nur ¥1000 je Glas!"
	done

.GoodbyeText:
	text "Bitte schön,"
	line "Schätzchen!"
	done

.BagFullText:
	text "Hoppla! Du hast"
	line "keinen Platz mehr."
	done

.MenuDataHeader:
	db $40 ; flags
	db 04, 00 ; start coords
	db 11, 14 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "× 1   ¥1000@"
	db "×10  ¥10000@"
	db "Zurück@"

GoldenrodHoneyHouseButterfreeText:
	text "Smettbo: Boh!"
	done
