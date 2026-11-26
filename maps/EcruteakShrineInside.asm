EcruteakShrineInside_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  9, ECRUTEAK_SHRINE_OUTSIDE, 1
	warp_event  6,  9, ECRUTEAK_SHRINE_OUTSIDE, 1

	def_coord_events

	def_bg_events
	bg_event  5,  1, BGEVENT_JUMPTEXT, EcruteakShrineInsideAltarText
	bg_event  6,  1, BGEVENT_JUMPTEXT, EcruteakShrineInsideAltarText
	bg_event  4,  0, BGEVENT_JUMPTEXT, EcruteakShrineInsideSignText
	bg_event  7,  0, BGEVENT_JUMPTEXT, EcruteakShrineInsideSignText

	def_object_events
	object_event  4,  2, SPRITE_SABRINA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakShrineInsideReiScript, -1
	object_event  3,  6, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakShrineInsideGrampsText, -1
	object_event 10,  6, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakShrineInsideSageText, -1
	object_event  1,  6, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakShrineInsideGrannyText, -1
	pokemon_event  9,  6, FURRET, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_BROWN, EcruteakShrineInsideFurretText, -1

	object_const_def
	const ECRUTEAKSHRINEINSIDE_REI

EcruteakShrineInsideReiScript:
	faceplayer
	opentext
	checkflag ENGINE_DAILY_SHRINE_VISIT
	iftruefwd .ReiDone
	writetext EcruteakShrineInsideReiGreetingText
	loadmenu .ReiMenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, .ReiBless
	ifequalfwd $2, .ReiBattle
	sjumpfwd .ReiCancel

.ReiBless
	writetext EcruteakShrineInsideReiBlessText
	promptbutton
	special Special_ReiBlessing
	ifequalfwd $0, .ReiCancel
	ifequalfwd $1, .EggBlessing
	setflag ENGINE_DAILY_SHRINE_VISIT
	writetext EcruteakShrineInsideReiBlessingText
	special PlayCurMonCry
	waitbutton
	writetext EcruteakShrineInsideHappinessText
	waitbutton
	sjumpfwd .ReiDone

.ReiBattle
	writetext EcruteakShrineInsideReiBattleText
	waitbutton
	closetext
	setflag ENGINE_DAILY_SHRINE_VISIT
	winlosstext EcruteakShrineInsideReiBeatenText, 0
	setlasttalked ECRUTEAKSHRINEINSIDE_REI
	readvar VAR_BADGES
	ifequalfwd 16, .Battle3
	checkevent EVENT_BEAT_ELITE_FOUR
	iftruefwd .Battle2
	loadtrainer REI, 1
	startbattle
	reloadmapafterbattle
	sjumpfwd .AfterRematch

.Battle2:
	loadtrainer REI, 2
	startbattle
	reloadmapafterbattle
	sjumpfwd .AfterRematch

.Battle3:
	loadtrainer REI, 3
	startbattle
	reloadmapafterbattle
	; fallthrough

.AfterRematch:
	opentext
	; fallthrough

.ReiDone
	jumpthisopenedtext

	text "Rei: Bitte komm"
	line "morgen wieder."
	done

.ReiCancel
	jumpthisopenedtext

	text "Rei: Komm wieder,"
	line "wenn du es dir"
	cont "anders überlegst."
	done

.EggBlessing
	jumpthisopenedtext

	text "Rei: Ein Ei kann"
	line "ich nicht segnen."
	done

.ReiMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 4, 11, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "Segen@"
	db "Kampf@"
	db "Zurück@"

EcruteakShrineInsideReiGreetingText:
	text "Rei: Oh, hallo."
	line "Willkommen in"
	cont "unserem Schrein."

	para "Soll ich eines"
	line "deiner #mon"
	cont "segnen?"

	para "Oder möchtest du"
	line "kämpfen?"
	done

EcruteakShrineInsideReiBlessText:
	text "Rei: Gut, welches"
	line "#mon soll ich"
	cont "segnen?"
	done

EcruteakShrineInsideReiBlessingText:
	text "Rei: Mögest du"
	line "Ruhe und Frieden"
	cont "finden."
	done

EcruteakShrineInsideHappinessText:
	text_ram wStringBuffer3
	text " sieht"
	line "zufrieden aus."
	done

EcruteakShrineInsideReiBattleText:
	text "Rei: Nun gut."
	line "Böse Geister,"
	cont "hinfort!"
	done

EcruteakShrineInsideReiBeatenText:
	text "Ich gebe mich"
	line "geschlagen!"
	done

EcruteakShrineInsideGrampsText:
	text "Die Schreinmaid"
	line "hier ist meine"
	cont "Enkelin."
	done

EcruteakShrineInsideGrannyText:
	text "Zum Glück wurde"
	line "kein Halt des"
	cont "Magnetzugs in"
	cont "Teak City erlaubt."

	para "Er würde unser"
	line "traditionelles"
	cont "Stadtbild zer-"
	cont "stören."
	done

EcruteakShrineInsideSageText:
	text "Die meisten von"
	line "uns im Schrein"

	para "trainieren Hoot-"
	line "hoot und Wiesor,"
	cont "um gegen Geister"
	cont "zu kämpfen."

	para "Rei ist anders."
	line "Sie setzt Feuer-"
	cont "und Psycho-#mon"
	cont "ein."
	done

EcruteakShrineInsideFurretText:
	text "Wiesenior:"
	line "Dook-dook!"
	done

EcruteakShrineInsideAltarText:
	text "Ein Altar mit"
	line "einem heiligen"
	cont "Spiegel und"
	cont "Blumen."
	done

EcruteakShrineInsideSignText:
	text "Bitte erweise bei"
	line "deinem Besuch"
	cont "Ehre und Respekt."
	done
