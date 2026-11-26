GoldenrodMuseum2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 13,  7, GOLDENROD_MUSEUM_1F, 3

	def_coord_events

	def_bg_events
	bg_event  1,  0, BGEVENT_READ, LugiaPaintingScript
	bg_event  2,  0, BGEVENT_READ, LugiaPaintingScript
	bg_event  4,  0, BGEVENT_READ, BellTowerPaintingScript
	bg_event  5,  0, BGEVENT_READ, BellTowerPaintingScript
	bg_event  7,  0, BGEVENT_READ, HoOhPaintingScript
	bg_event  8,  0, BGEVENT_READ, HoOhPaintingScript
	bg_event  1,  4, BGEVENT_READ, KabutoPuzzleScript
	bg_event  1,  5, BGEVENT_READ, KabutoPuzzleScript
	bg_event  5,  4, BGEVENT_READ, OmanytePuzzleScript
	bg_event  5,  5, BGEVENT_READ, OmanytePuzzleScript
	bg_event  1,  6, BGEVENT_READ, AerodactylPuzzleScript
	bg_event  1,  7, BGEVENT_READ, AerodactylPuzzleScript
	bg_event  5,  6, BGEVENT_READ, HoOhPuzzleScript
	bg_event  5,  7, BGEVENT_READ, HoOhPuzzleScript
	bg_event 10,  1, BGEVENT_JUMPTEXT, TowerRelicText
	bg_event 11,  1, BGEVENT_JUMPTEXT, TowerRelicText
	bg_event 11,  1, BGEVENT_JUMPTEXT, TowerRelicText

	def_object_events
	object_event  4,  2, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodMuseum2FSightseerMText, -1
	pokemon_event 5,  2, SMEARGLE, SPRITEMOVEDATA_POKEMON, (1 << EVE) | (1 << NITE), PAL_MON_BROWN, GoldenrodMuseum2FSmeargleText, -1
	object_event  3,  6, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodMuseum2FScientistScript, -1
	object_event 11,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodMuseum2FTeacherScript, -1

LugiaPaintingScript:
	reanchormap
	paintingpic LUGIA_PAINTING
	waitbutton
	closepokepic
	jumpthistext

	text "  Der Leviathan"
	line "     erwacht"
	done

HoOhPaintingScript:
	reanchormap
	paintingpic HO_OH_PAINTING
	waitbutton
	closepokepic
	jumpthistext

	text "   Der Aufstieg"
	line "    des Phönix"
	done

BellTowerPaintingScript:
	reanchormap
	paintingpic BELL_TOWER_PAINTING
	waitbutton
	closepokepic
	jumpthistext

	text "   Freundschaft"
	line "   und Hoffnung"
	done

KabutoPuzzleScript:
	checkevent EVENT_SOLVED_KABUTO_PUZZLE
	iffalse_jumptext EmptyPuzzleText
	showtext .Text
	paintingpic KABUTO_PUZZLE
	waitbutton
	closepokepic
	end

.Text:
	text "Die Kabuto-Platte"
	line "ist vollständig!"
	done

OmanytePuzzleScript:
	checkevent EVENT_SOLVED_OMANYTE_PUZZLE
	iffalse_jumptext EmptyPuzzleText
	showtext .Text
	paintingpic OMANYTE_PUZZLE
	waitbutton
	closepokepic
	end

.Text:
	text "Die Amonitas-"
	line "Platte ist"
	cont "vollständig!"
	done

AerodactylPuzzleScript:
	checkevent EVENT_SOLVED_AERODACTYL_PUZZLE
	iffalse_jumptext EmptyPuzzleText
	showtext .Text
	paintingpic AERODACTYL_PUZZLE
	waitbutton
	closepokepic
	end

.Text:
	text "Die Aerodactyl-"
	line "Platte ist"
	cont "vollständig!"
	done

HoOhPuzzleScript:
	checkevent EVENT_SOLVED_HO_OH_PUZZLE
	iffalse_jumptext EmptyPuzzleText
	showtext .Text
	paintingpic HO_OH_PUZZLE
	waitbutton
	closepokepic
	end

.Text:
	text "Die Ho-Oh-Platte"
	line "ist vollständig!"
	done

EmptyPuzzleText:
	text "Nachbildung einer"
	line "Platte der Alph-"
	cont "Ruinen"

	para "(wird gerade"
	line "restauriert)"
	done

TowerRelicText:
	text "Ein uraltes"
	line "Wandgemälde mit"
	cont "einem mysteriösen"
	cont "#mon."
	done

GoldenrodMuseum2FSightseerMText:
	text "Diese Gemälde"
	line "sind wunderschön!"

	para "Ich hoffe, eines"
	line "Tages hängt meine"

	para "Kunst auch in"
	line "einem Museum, wo"
	cont "alle sie sehen."
	done

GoldenrodMuseum2FSmeargleText:
	text "Farbeagle: Smeer!"
	done

GoldenrodMuseum2FScientistScript:
	checkevent EVENT_SOLVED_KABUTO_PUZZLE
	iftrue_jumptextfaceplayer GoldenrodMuseum2FScientistSomeArtifactsText
	checkevent EVENT_SOLVED_OMANYTE_PUZZLE
	iftrue_jumptextfaceplayer GoldenrodMuseum2FScientistSomeArtifactsText
	checkevent EVENT_SOLVED_AERODACTYL_PUZZLE
	iftrue_jumptextfaceplayer GoldenrodMuseum2FScientistSomeArtifactsText
	checkevent EVENT_SOLVED_HO_OH_PUZZLE
	iftrue_jumptextfaceplayer GoldenrodMuseum2FScientistSomeArtifactsText
	jumpthistextfaceplayer

	text "Ich habe mehr"
	line "Ausstellungs-"
	cont "stücke erwartet…"

	para "Wo sind die"
	line "Reliefs aus Alph?"
	done

GoldenrodMuseum2FScientistSomeArtifactsText:
	text "Diese Artefakte"
	line "sind faszinierend!"

	para "Schade, dass es"
	line "nur Nachbildungen"
	cont "sind…"

	para "Ich würde gern die"
	line "echten aus der"
	cont "Nähe studieren."
	done

GoldenrodMuseum2FTeacherScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_BATON_PASS_INTRO
	iftruefwd GoldenrodMuseum2FTutorBatonPassScript
	writetext GoldenrodMuseum2FTutorIntroText
	waitbutton
	setevent EVENT_LISTENED_TO_BATON_PASS_INTRO
; fallthrough
GoldenrodMuseum2FTutorBatonPassScript:
	writetext GoldenrodMuseum2FTutorBatonPassText
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writetext GoldenrodMuseum2FTutorQuestion
	yesorno
	iffalsefwd .TutorRefused
	setval BATON_PASS
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpthisopenedtext

	text "Wie du meinst."
	done

.NoSilverLeaf
	jumpthisopenedtext

	text "Du hast kein"
	line "Silberblatt!"
	done

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext

	text "Jetzt beherrscht"
	line "dein #mon"
	cont "Staffette!"
	done

GoldenrodMuseum2FTutorIntroText:
	text "Bevor der neue"
	line "Radioturm gebaut"

	para "wurde, stand hier"
	line "einst ein alter"
	cont "Holzturm."

	para "Dieses Wandbild"
	line "war ursprünglich"
	cont "in jenem Turm."

	para "Es musste hierher"
	line "gebracht werden,"

	para "um ein Stück der"
	line "Geschichte Johtos"
	cont "zu bewahren."

	para "Selbst #mon"
	line "verstehen den Wert"

	para "des Bewahrens!"
	done

GoldenrodMuseum2FTutorBatonPassText:
	text "Für ein Silber-"
	line "blatt bringe ich"

	para "deinem #mon"
	line "Staffette bei."
	done


GoldenrodMuseum2FTutorQuestion:
	text "Soll ich deinem"
	line "#mon Staffette"
	cont "beibringen?"
	done
