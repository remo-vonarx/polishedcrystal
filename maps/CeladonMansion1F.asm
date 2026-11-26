CeladonMansion1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6,  9, CELADON_CITY, 2
	warp_event  7,  9, CELADON_CITY, 2
	warp_event  3,  0, CELADON_CITY, 3
	warp_event  0,  0, CELADON_MANSION_2F, 1
	warp_event  7,  0, CELADON_MANSION_2F, 4

	def_coord_events

	def_bg_events
	bg_event  5,  8, BGEVENT_UP, CeladonMansionManagersSuiteSign
	bg_event  0,  3, BGEVENT_JUMPSTD, picturebookshelf
	bg_event  2,  3, BGEVENT_JUMPSTD, picturebookshelf

	def_object_events
	object_event  1,  5, SPRITE_GRANNY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonMansionManagerScript, -1
	pokemon_event  2,  6, MEOWTH, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_BROWN, CeladonMansion1FMeowthText, -1
	pokemon_event  3,  4, CLEFAIRY, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_PINK, CeladonMansion1FClefairyText, -1
	pokemon_event  4,  4, NIDORAN_F, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_TEAL, CeladonMansion1FNidoranFText, -1

CeladonMansionManagersSuiteSign:
	jumpthistext

	text "Prismania-Villa"
	line "Suite des Managers"
	done

CeladonMansionManagerScript:
	checkitem MINT_LEAF
	iffalse_jumptextfaceplayer .NoMintLeafText
	faceplayer
	opentext
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .AcceptedText
	promptbutton
	special Special_MintTeaPickMon
	iffalse_jumpopenedtext .RefusedText
	ifequalfwd $1, .Egg
	writetext .LikedFlavorText
	loadmenu .MenuDataHeader
	verticalmenu
	closewindow
	iffalse_jumpopenedtext .RefusedText
	writemem wMintTeaLikedFlavor
	writetext .DislikedFlavorText
	loadmenu .MenuDataHeader
	verticalmenu
	closewindow
	iffalse_jumpopenedtext .RefusedText
	writemem wMintTeaDislikedFlavor
	special Special_MintTeaChangeNature
	iffalsefwd .Neutral
	writetext .TeaIsReadyText
	sjumpfwd .Done
.Neutral
	writetext .NeutralTeaText
.Done
	waitbutton
	closetext
	takeitem MINT_LEAF
	readmem wCurPartySpecies
	pokepic 0
	cry 0
	waitsfx
	closepokepic
	opentext
	writetext .MonLooksDifferentText
	special PlayCurMonCry
	waitbutton
	jumpthisopenedtext

	text "Es geht nichts"
	line "über heißen"
	cont "Minztee."

	para "Er kann sogar das"
	line "Wesen eines"
	cont "#mon ändern!"
	done

.Egg:
	jumpthisopenedtext

	text "Soll ich daraus"
	line "etwa ein Tee-Ei"
	cont "machen?"
	done

.NoMintLeafText:
	text "Oh, hallo,"
	line "Schätzchen."

	para "Ich trinke gerade"
	line "Tee mit meinen"
	cont "lieben #mon."

	para "Hättest du ein"
	line "Minzblatt,"

	para "würde ich dich"
	line "dazu einladen."

	para "#mon lieben"
	line "Minze im Tee."

	para "Sie wirkt dauer-"
	line "haft auf ihr"
	cont "Wesen!"
	done

.QuestionText:
	text "Oh, hallo,"
	line "Schätzchen."

	para "Wie ich sehe, hast"
	line "du ein Minzblatt."

	para "Soll ich es für"
	line "dein #mon"

	para "in Tee ziehen"
	line "lassen?"
	done

.RefusedText:
	text "Aber füll dich"
	line "jetzt nicht mit"
	cont "Limonade und"
	cont "Sprudel ab!"
	done

.AcceptedText:
	text "Welches deiner"
	line "#mon will Tee?"
	done

.LikedFlavorText:
	text "Welche Geschmacks-"
	line "richtung mag"
	cont ""
	text_ram wStringBuffer1
	text "?"
	done

.DislikedFlavorText:
	text "Und welche mag"
	line "es nicht?"
	done

.NeutralTeaText:
	text "Eine ungewöhnliche"
	line "Vorliebe, aber das"
	cont "kann ich brühen!"

	para "Eine Tasse für"
	line "dich und eine für"
	cont ""
	text_ram wStringBuffer1
	text "!"
	done

.TeaIsReadyText:
	text "Okay! Hier ist"
	line "dein Tee."

	para "Eine Tasse für"
	line "dich und eine für"
	cont ""
	text_ram wStringBuffer1
	text "!"
	done

.MonLooksDifferentText:
	text_ram wStringBuffer1
	text " sieht"
	line "irgendwie anders"
	cont "aus!"
	done

.MenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 9, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 5 ; items
	; this order is meaningful to calculate the new nature
	db "Scharf@" ; atk
	db "Sauer@" ; def
	db "Süß@" ; spe
	db "Trocken@" ; sat
	db "Bitter@" ; sdf

CeladonMansion1FMeowthText:
	text "Mauzi: Mauz!"
	done

CeladonMansion1FClefairyText:
	text "Piepi: Piep piep"
	line "piep!"
	done

CeladonMansion1FNidoranFText:
	text "Nidoran: Nido"
	line "nido!"
	done
