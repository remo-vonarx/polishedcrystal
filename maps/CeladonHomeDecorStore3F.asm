CeladonHomeDecorStore3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6,  0, CELADON_HOME_DECOR_STORE_2F, 2
	warp_event  9,  0, CELADON_HOME_DECOR_STORE_4F, 1

	def_coord_events

	def_bg_events
	bg_event  8,  0, BGEVENT_JUMPTEXT, CeladonHomeDecorStore3FDirectoryText

	def_object_events
	object_event  7,  7, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonHomeDecorStore3FClerk1Script, -1
	object_event  8,  7, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonHomeDecorStore3FClerk2Script, -1
	object_event  3,  5, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore3FYoungsterText, -1
	object_event  9,  3, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHomeDecorStore3FBeautyText, -1

CeladonHomeDecorStore3FClerk1Script:
	faceplayer
	opentext
	writetext CeladonHomeDecorStore3FClerk1Text
	special PlaceMoneyTopRight
.Start:
	loadmenu .MenuData
	verticalmenu
	closewindow
	ifequalfwd $1, .RedCarpet
	ifequalfwd $2, .YellowCarpet
	ifequalfwd $3, .GreenCarpet
	endtext

.RedCarpet:
	checkmoney YOUR_MONEY, 45000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	checkevent EVENT_DECO_CARPET_1
	iftruefwd .AlreadyBought
	takemoney YOUR_MONEY, 45000
	setevent EVENT_DECO_CARPET_1
	writetext BoughtRedCarpetText
	playsound SFX_TRANSACTION
	special PlaceMoneyTopRight
	waitbutton
	writetext RedCarpetSentText
	waitbutton
	sjump .Start

.YellowCarpet:
	checkmoney YOUR_MONEY, 45000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	checkevent EVENT_DECO_CARPET_3
	iftruefwd .AlreadyBought
	takemoney YOUR_MONEY, 45000
	setevent EVENT_DECO_CARPET_3
	writetext BoughtYellowCarpetText
	playsound SFX_TRANSACTION
	special PlaceMoneyTopRight
	waitbutton
	writetext YellowCarpetSentText
	waitbutton
	sjump .Start

.GreenCarpet:
	checkmoney YOUR_MONEY, 45000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	checkevent EVENT_DECO_CARPET_4
	iftruefwd .AlreadyBought
	takemoney YOUR_MONEY, 45000
	setevent EVENT_DECO_CARPET_4
	writetext BoughtGreenCarpetText
	playsound SFX_TRANSACTION
	special PlaceMoneyTopRight
	waitbutton
	writetext GreenCarpetSentText
	waitbutton
	sjump .Start

.NotEnoughMoney:
	writetext CeladonHomeDecorStore3FNoMoneyText
	waitbutton
	sjump .Start

.AlreadyBought:
	writetext CeladonHomeDecorStore3FAlreadyBoughtText
	waitbutton
	sjump .Start

.MenuData:
	db MENU_BACKUP_TILES
	menu_coords 0, 2, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Red       ¥45000@"
	db "Yellow    ¥45000@"
	db "Green     ¥45000@"
	db "Cancel@"

CeladonHomeDecorStore3FClerk2Script:
	checkevent EVENT_DECO_CARPET_2
	iftrue_jumptextfaceplayer CeladonHomeDecorStore3FClerk2Text
	faceplayer
	opentext
	special PlaceMoneyTopRight
	writetext CeladonHomeDecorStore3FClerk2SaleText
	yesorno
	iffalse_jumpopenedtext CeladonHomeDecorStore3FClerk2NoText
	checkmoney YOUR_MONEY, 35000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	takemoney YOUR_MONEY, 35000
	setevent EVENT_DECO_CARPET_2
	writetext BoughtBlueCarpetText
	special PlaceMoneyTopRight
	playsound SFX_TRANSACTION
	waitbutton
	writetext BlueCarpetSentText
	waitbutton
	jumpthisopenedtext

	text "Danke schön!"
	line "Einen schönen Tag!"
	done

.NotEnoughMoney:
	jumpopenedtext CeladonHomeDecorStore3FNoMoneyText

CeladonHomeDecorStore3FClerk1Text:
	text "Willkommen! Wie"
	line "wär's mit einem"
	cont "Teppich?"
	done

CeladonHomeDecorStore3FClerk2Text:
	text "Rundet ein Teppich"
	line "dein Zimmer nicht"
	cont "erst richtig ab?"
	done

CeladonHomeDecorStore3FClerk2SaleText:
	text "Unseren impor-"
	line "tierten königs-"
	cont "blauen Teppich"

	para "gibt es gerade im"
	line "Angebot: ¥35,000."

	para "Möchtest du einen"
	line "kaufen?"
	done


CeladonHomeDecorStore3FClerk2NoText:
	text "Einen schönen Tag!"
	done

BoughtRedCarpetText:
	text "<PLAYER> kauft"
	line "Roter Teppich."
	done

RedCarpetSentText:
	text "Roter Teppich"
	line "wurde nach Hause"
	cont "geschickt."
	done

BoughtBlueCarpetText:
	text "<PLAYER> kauft"
	line "Blauer Teppich."
	done

BlueCarpetSentText:
	text "Blauer Teppich"
	line "wurde nach Hause"
	cont "geschickt."
	done

BoughtYellowCarpetText:
	text "<PLAYER> kauft"
	line "Gelber Teppich."
	done

YellowCarpetSentText:
	text "Gelber Teppich"
	line "wurde nach Hause"
	cont "geschickt."
	done

BoughtGreenCarpetText:
	text "<PLAYER> kauft"
	line "Grüner Teppich."
	done

GreenCarpetSentText:
	text "Grüner Teppich"
	line "wurde nach Hause"
	cont "geschickt."
	done

CeladonHomeDecorStore3FNoMoneyText:
	text "Das kannst du dir"
	line "nicht leisten!"
	done

CeladonHomeDecorStore3FAlreadyBoughtText:
	text "Das hast du"
	line "schon!"
	done

CeladonHomeDecorStore3FYoungsterText:
	text "Dieser Teppich ist"
	line "so flauschig!"
	done

CeladonHomeDecorStore3FBeautyText:
	text "Einige Teppiche"
	line "sind aus Kalos"
	cont "importiert!"
	done

CeladonHomeDecorStore3FDirectoryText:
	text "Farbige Eleganz"

	para "2S: Teppiche"
	done
