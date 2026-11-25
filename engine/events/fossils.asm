AskResurrectFossilScript::
	checkitem HELIX_FOSSIL
	iftruefwd .own_helix
	checkitem DOME_FOSSIL
	iftruefwd .own_dome
	checkitem OLD_AMBER
	iftruefwd .ask_old_amber
	jumpthisopenedtext

	text "Hey! Du hast keine"
	line "Fossilien."
	done

.own_helix
	checkitem DOME_FOSSIL
	iftruefwd .own_helix_and_dome
	checkitem OLD_AMBER
	iftruefwd .ask_helix_amber
	writetext AskHelixFossilText
	yesorno
	iftrue ResurrectHelixFossil
	sjumpfwd .maybe_later

.own_dome
	checkitem OLD_AMBER
	iftruefwd .ask_dome_amber
	writetext AskDomeFossilText
	yesorno
	iftrue ResurrectDomeFossil
	sjumpfwd .maybe_later

.own_helix_and_dome
	checkitem OLD_AMBER
	iftruefwd .ask_helix_dome_amber
	loadmenu HelixDomeMenuDataHeader
	verticalmenu
	closewindow
	ifequal $1, ResurrectHelixFossil
	ifequal $2, ResurrectDomeFossil
	sjumpfwd .maybe_later

.ask_old_amber
	writetext AskOldAmberText
	yesorno
	iftrue ResurrectOldAmber
	sjumpfwd .maybe_later

.ask_helix_amber
	loadmenu HelixAmberMenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, ResurrectHelixFossil
	ifequal $2, ResurrectOldAmber
	sjumpfwd .maybe_later

.ask_dome_amber
	loadmenu DomeAmberMenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, ResurrectDomeFossil
	ifequalfwd $2, ResurrectOldAmber
	sjumpfwd .maybe_later

.ask_helix_dome_amber
	loadmenu HelixDomeAmberMenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, ResurrectHelixFossil
	ifequalfwd $2, ResurrectDomeFossil
	ifequalfwd $3, ResurrectOldAmber
.maybe_later:
	jumpthisopenedtext

	text "Sprich mich"
	line "einfach an, wenn"
	cont "du deine Meinung"
	cont "änderst."
	done

HelixDomeMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 4, 15, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "Helixfossil@"
	db "Domfossil@"
	db "Zurück@"

HelixAmberMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 4, 15, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "Helixfossil@"
	db "Altbernstein@"
	db "Zurück@"

DomeAmberMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 4, 14, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "Domfossil@"
	db "Altbernstein@"
	db "Zurück@"

HelixDomeAmberMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 2, 15, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Helixfossil@"
	db "Domfossil@"
	db "Altbernstein@"
	db "Zurück@"

ResurrectHelixFossil:
	takeitem HELIX_FOSSIL
	scall ResurrectAFossilScript
	givepoke OMANYTE, 20
	sjumpfwd FinishResurrect

ResurrectDomeFossil:
	takeitem DOME_FOSSIL
	scall ResurrectAFossilScript
	givepoke KABUTO, 20
	sjumpfwd FinishResurrect

ResurrectOldAmber:
	takeitem OLD_AMBER
	scall ResurrectAFossilScript
	givepoke AERODACTYL, 20
FinishResurrect:
	iffalse_jumpopenedtext NoRoomForFossilPokemonText
	jumpthisopenedtext

	text "Pass gut darauf"
	line "auf!"
	done

ResurrectAFossilScript:
	writetext ResurrectingPokemonText
	waitbutton
	closetext
	memcall wResurrectFossilScriptBank
	pause 15
	playsound SFX_BOOT_PC
	waitsfx
	pause 30
	playsound SFX_4_NOTE_DITTY
	waitsfx
	pause 5
	waitsfx
	pause 30
	playsound SFX_SHUT_DOWN_PC
	waitsfx
	pause 15
	faceplayer
	opentext
	end

AskHelixFossilText:
	text "Möchtest du das"
	line "Helixfossil"
	cont "wiederbeleben?"
	done

AskDomeFossilText:
	text "Möchtest du das"
	line "Domfossil"
	cont "wiederbeleben?"
	done

AskOldAmberText:
	text "Möchtest du den"
	line "Altbernstein"
	cont "wiederbeleben?"
	done

ResurrectingPokemonText:
	text "O.K.! Ich belebe"
	line "das #mon"
	cont "wieder!"
	done

NoRoomForFossilPokemonText:
	text "Hey! Du kannst"
	line "kein #mon mehr"
	cont "tragen und deine"
	cont "Box ist auch voll!"
	done
