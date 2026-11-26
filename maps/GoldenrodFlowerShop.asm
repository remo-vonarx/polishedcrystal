GoldenrodFlowerShop_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 6
	warp_event  3,  7, GOLDENROD_CITY, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, FlowerShopTeacherScript, -1
	object_event  5,  6, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FlowerShopFloriaScript, EVENT_FLORIA_AT_FLOWER_SHOP
	object_event  6,  3, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, FlowerShopGentlemanText, EVENT_FLORIA_AT_SUDOWOODO

	object_const_def
	const GOLDENRODFLOWERSHOP_TEACHER

FlowerShopTeacherScript:
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftruefwd .SellMulch
	checkevent EVENT_FLORIA_AT_SUDOWOODO
	iftruefwd .MetFloria
	checkflag ENGINE_PLAINBADGE
	iffalse_jumptextfaceplayer GoldenrodFlowerShopTeacherMySisterWentToSeeWigglyTreeRoute36Text
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iftrue_jumptextfaceplayer GoldenrodFlowerShopTeacherStopMySisterText
	faceplayer
	opentext
	writetext GoldenrodFlowerShopTeacherBetterThanWhitneyText
	promptbutton
	verbosegivekeyitem SQUIRTBOTTLE
	setevent EVENT_GOT_SQUIRTBOTTLE
	closetext
	end

.MetFloria:
	checkflag ENGINE_PLAINBADGE
	iffalse_jumptextfaceplayer GoldenrodFlowerShopTeacherAskWantToBorrowWaterBottleText
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iftrue_jumptextfaceplayer GoldenrodFlowerShopTeacherDontDoAnythingDangerousText
	faceplayer
	opentext
	writetext GoldenrodFlowerShopTeacherHeresTheSquirtbottleText
	promptbutton
	verbosegivekeyitem SQUIRTBOTTLE
	setevent EVENT_GOT_SQUIRTBOTTLE
	closetext
	end

.SellMulch:
	faceplayer
	opentext
	writetext WoukdYouLikeMulchText
	special PlaceMoneyTopRight
	loadmenu .MenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, .Buy1
	ifequalfwd $2, .Buy10
	jumpthisopenedtext

	text "Komm wieder!"
	done

.Buy1:
	checkmoney YOUR_MONEY, 200
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	giveitem MULCH, iffalse_jumpopenedtext NoRoomForMulchText
	takemoney YOUR_MONEY, 200
	sjumpfwd .Done

.Buy10:
	checkmoney YOUR_MONEY, 2000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	giveitems MULCH, 10, iffalse_jumpopenedtext NoRoomForMulchText
	takemoney YOUR_MONEY, 2000

.Done:
	special PlaceMoneyTopRight
	waitsfx
	playsound SFX_TRANSACTION
	itemnotify
	jumpthisopenedtext

	text "Danke schön!"
	line "Komm bald wieder!"
	done

.NotEnoughMoney:
	jumpthisopenedtext

	text "Nun… Entschul-"
	line "dige, aber du hast"
	cont "nicht genug Geld."
	done

.MenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 4, 14, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "× 1    ¥200@"
	db "×10   ¥2000@"
	db "Zurück@"

FlowerShopFloriaScript:
	checkflag ENGINE_PLAINBADGE
	iffalse_jumptextfaceplayer GoldenrodFlowerShopFloriaWonderIfSisWillLendWaterBottleText
	checkevent EVENT_FOUGHT_SUDOWOODO
	iffalse_jumptextfaceplayer GoldenrodFlowerShopFloriaYouBeatWhitneyText
	checkitem MULCH
	iftrue_jumptextfaceplayer DescribeMulchText
	jumpthistextfaceplayer

	text "Dieser wackelige"
	line "Baum war also"
	cont "tatsächlich ein"
	cont "#mon!"
	done

GoldenrodFlowerShopTeacherMySisterWentToSeeWigglyTreeRoute36Text:
	text "Hast du den wacke-"
	line "ligen Baum auf"
	cont "Route 36 gesehen?"

	para "Meine kleine"
	line "Schwester war auf-"
	cont "geregt und wollte"
	cont "ihn sich ansehen…"

	para "Ich bin besorgt…"
	line "Ist das riskant?"
	done

GoldenrodFlowerShopTeacherStopMySisterText:
	text "Meine kleine"
	line "Schwester war auf-"
	cont "geregt und wollte"
	cont "sich den wackeli-"
	cont "gen Baum ansehen…"

	para "Ich bin besorgt…"
	line "Kannst du bitte"

	para "verhindern, dass"
	line "er ihr wehtut?"
	done

GoldenrodFlowerShopTeacherAskWantToBorrowWaterBottleText:
	text "Möchtest du auch"
	line "die Gießkanne aus-"
	cont "leihen? Ich werde"
	cont "nicht zulassen,"

	para "dass du etwas Ge-"
	line "fährliches damit"
	cont "anstellst."
	done

GoldenrodFlowerShopTeacherBetterThanWhitneyText:
	text "Oh, du bist besser"
	line "als Bianka."

	para "Kennst du den"
	line "wackeligen Baum?"

	para "Wenn du ihn mit"
	line "einer Schiggykanne"
	cont "nass machst,"
	cont "greift er an."

	para "Aber da du schon"
	line "Orden hast,"
	cont "sollte das gehen."
	done

GoldenrodFlowerShopTeacherHeresTheSquirtbottleText:
	text "Oh, du bist besser"
	line "als Bianka…"

	para "Dann bist du in"
	line "Ordnung. Hier, die"
	cont "Schiggykanne!"
	done

GoldenrodFlowerShopTeacherDontDoAnythingDangerousText:
	text "Unternimm nichts"
	line "Gefährliches!"
	done

GoldenrodFlowerShopFloriaWonderIfSisWillLendWaterBottleText:
	text "Als ich meiner"
	line "Schwester von dem"

	para "wackeligen Baum"
	line "erzählte, sagte"

	para "sie mir, dass er"
	line "gefährlich sei."

	para "Ich frage mich, ob"
	line "sie mir ihre Gieß-"
	cont "kanne leiht, wenn"
	cont "ich Bianka"
	cont "besiege…"
	done

GoldenrodFlowerShopFloriaYouBeatWhitneyText:
	text "Wow, du hast gegen"
	line "Bianka gewonnen?"
	cont "Cool!"

	para "Vielleicht kannst"
	line "du dich um den"
	cont "wackeligen Baum"
	cont "kümmern."

	para "Du brauchst nur"
	line "eine Schiggykanne"
	cont "wie meine Schwes-"
	cont "ter."
	done

WoukdYouLikeMulchText:
	text "Möchtest du etwas"
	line "Mulch kaufen?"

	para "Damit wachsen"
	line "Beeren schneller!"
	done




NoRoomForMulchText:
	text "Oh nein, dein"
	line "Beutel ist voll!"
	done

DescribeMulchText:
	text "Unser Mulch ist"
	line "eine Mischung aus"

	para "bester Erde und"
	line "#mon-… äh… du"
	cont "weißt schon."

	para "Voller Nähr-"
	line "stoffe!"
	done

FlowerShopGentlemanText:
	text "Ich arbeite in"
	line "letzter Zeit oft"
	cont "lange, deshalb"

	para "kaufe ich Blumen"
	line "für meine Frau."
	done
