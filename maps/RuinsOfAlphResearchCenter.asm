RuinsOfAlphResearchCenter_MapScriptHeader:
	def_scene_scripts
	scene_script DoNothingScript, SCENE_RUINSOFALPHRESEARCHCENTER_NOOP
	scene_script RuinsOfAlphResearchCenterGetUnownDexScene, SCENE_RUINSOFALPHRESEARCHCENTER_GET_UNOWN_DEX

	def_callbacks
	callback MAPCALLBACK_OBJECTS, RuinsOfAlphResearchCenterScientistCallback

	def_warp_events
	warp_event  4,  7, RUINS_OF_ALPH_OUTSIDE, 7
	warp_event  5,  7, RUINS_OF_ALPH_OUTSIDE, 7

	def_coord_events

	def_bg_events
	bg_event  8,  5, BGEVENT_JUMPTEXT, RuinsOfAlphResearchCenterAcademicBooksText
	bg_event  5,  4, BGEVENT_READ, MapRuinsofAlphResearchCenterSignpost1Script
	bg_event  9,  1, BGEVENT_JUMPTEXT, RuinsOfAlphResearchCenterPrinterText_DoesntWork
	bg_event  7,  0, BGEVENT_JUMPTEXT, RuinsOfAlphResearchCenterProfSilktreePhotoText
	bg_event  1,  3, BGEVENT_JUMPTEXT, RuinsOfAlphResearchCenterFossilComputerText

	def_object_events
	object_event  6,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist1Script, -1
	object_event  7,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 2, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist2Script, -1
	object_event  4,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist3Script, EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	object_event  0,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist4Script, -1

	object_const_def
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST1
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST2
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST3
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST4

RuinsOfAlphResearchCenterScientistCallback:
	checkscene
	ifequalfwd $1, .ShowScientist
	endcallback

.ShowScientist:
	moveobject RUINSOFALPHRESEARCHCENTER_SCIENTIST3, 5, 7
	appear RUINSOFALPHRESEARCHCENTER_SCIENTIST3
	endcallback

RuinsOfAlphResearchCenterGetUnownDexScene:
	sdefer .Script
	end

.Script:
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsOfAlphResearchCenterApproachesComputerMovement
	playsound SFX_BOOT_PC
	pause 60
	playsound SFX_SWITCH_POKEMON
	pause 30
	playsound SFX_TALLY
	pause 30
	playsound SFX_TRANSACTION
	pause 30
	turnobject RUINSOFALPHRESEARCHCENTER_SCIENTIST3, DOWN
	showtext RuinsOfAlphResearchCenterModifiedDexText
	applyonemovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, step_down
	opentext
	writetext RuinsOfAlphResearchCenterDexUpgradedText
	playsound SFX_ITEM
	waitsfx
	setflag ENGINE_UNOWN_DEX
	writetext RuinsOfAlphResearchCenterScientist3Text
	waitbutton
	closetext
	applyonemovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, step_up
	setscene SCENE_RUINSOFALPHRESEARCHCENTER_NOOP
	special RestartMapMusic
	end

RuinsOfAlphResearchCenterScientist3Script:
	faceplayer
	opentext
	checkevent EVENT_RUINS_OF_ALPH_CLIMAX_DONE
	iftruefwd .Conclusion
	readvar VAR_UNOWNCOUNT
	ifequalfwd NUM_UNOWN, .PrinterAvailable
	jumpopenedtext RuinsOfAlphResearchCenterScientist3Text

.Conclusion:
	jumpthisopenedtext

	text "Wir werden die"
	line "geöffnete Kammer"

	para "nach und nach"
	line "erforschen."

	para "Wir müssen darauf"
	line "achten, die Stätte"
	cont "nicht zu stören."
	done

.PrinterAvailable:
	writetext RuinsOfAlphResearchCenterScientist3_PrinterAvailable
	promptbutton
	setevent EVENT_DECO_UNOWN_DOLL
	writetext GotUnownDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext UnownDollSentText
	promptbutton
	writetext RuinsofAlphResearchCenterScientistRewardText
	promptbutton
	writetext RuinsofAlphResearchCenterScientistInterruptedText
	pause 30
	closetext
	pause 15
	playsound SFX_EMBER
	earthquake 60
	waitsfx
	setevent EVENT_DOOR_OPENED_IN_RUINS_OF_ALPH
	turnobject PLAYER, DOWN
	turnobject RUINSOFALPHRESEARCHCENTER_SCIENTIST1, DOWN
	turnobject RUINSOFALPHRESEARCHCENTER_SCIENTIST2, DOWN
	turnobject RUINSOFALPHRESEARCHCENTER_SCIENTIST3, DOWN
	turnobject RUINSOFALPHRESEARCHCENTER_SCIENTIST4, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	showemote EMOTE_SHOCK, RUINSOFALPHRESEARCHCENTER_SCIENTIST3, 15
	faceobject PLAYER, RUINSOFALPHRESEARCHCENTER_SCIENTIST3
	faceobject RUINSOFALPHRESEARCHCENTER_SCIENTIST3, PLAYER
	showtext RuinsofAlphResearchCenterScientistShockedText
	readvar VAR_FACING
	ifequalfwd UP, .GoAround
	follow RUINSOFALPHRESEARCHCENTER_SCIENTIST3, PLAYER
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsofAlphResearchCenterLeave2MovementData
	stopfollow
	sjumpfwd .Continue
.GoAround:
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsofAlphResearchCenterScientistStepAsideMovementData
	follow RUINSOFALPHRESEARCHCENTER_SCIENTIST3, PLAYER
	applyonemovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, step_down
	stopfollow
.Continue:
	playsound SFX_EXIT_BUILDING
	disappear RUINSOFALPHRESEARCHCENTER_SCIENTIST3
	applyonemovement PLAYER, step_down
	playsound SFX_EXIT_BUILDING
	disappear PLAYER
	special FadeOutPalettes
	setevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	clearevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	clearevent EVENT_RUINS_OF_ALPH_OUTSIDE_SCIENTIST_CLIMAX
	setevent EVENT_DO_RUINS_OF_ALPH_CLIMAX
	pause 15
	warpfacing DOWN, RUINS_OF_ALPH_OUTSIDE, 23, 18
	end

RuinsofAlphResearchCenterScientistStepAsideMovementData:
	step_right
	step_down
	step_end

RuinsofAlphResearchCenterLeave2MovementData:
	step_down
	step_down
	step_end

RuinsOfAlphResearchCenterScientist1Script:
	faceplayer
	opentext
	readvar VAR_UNOWNCOUNT
	ifequalfwd NUM_UNOWN, .GotAllUnown
	checkflag ENGINE_UNOWN_DEX
	iftruefwd .GotUnownDex
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftruefwd .UnownAppeared
	jumpthisopenedtext

	text "Die Ruinen sind"
	line "zirka 1500"
	cont "Jahre alt."

	para "Aber niemand weiß,"
	line "warum sie erbaut"
	cont "wurden."
	done

.UnownAppeared:
	jumpthisopenedtext

	text "Es gibt #mon"
	line "in den Ruinen?"

	para "Das sind unfass-"
	line "bare Neuigkeiten!"

	para "Das müssen wir"
	line "erforschen."
	done

.GotUnownDex:
	jumpthisopenedtext

	text "Ich frage mich,"
	line "wie viele #mon"
	cont "wohl in den Ruinen"
	cont "leben?"
	done

.GotAllUnown:
	writetext RuinsOfAlphResearchCenterScientist1Text_GotAllUnown
	waitbutton
	closetext
	clearevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	end

RuinsOfAlphResearchCenterScientist2Script:
	faceplayer
	opentext
	readvar VAR_UNOWNCOUNT
	ifgreater 3, .GotAllUnown
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftruefwd .UnownAppeared
	jumpthisopenedtext

	text "An die Wände der"
	line "Ruinen sind selt-"
	cont "same Zeichen"

	para "gemalt."
	line "Sie sind der"

	para "Schlüssel zur"
	line "Lösung des Rätsels"
	cont "um die Ruinen."
	done

.UnownAppeared:
	jumpthisopenedtext

	text "Die seltsamen"
	line "#mon, die du in"
	cont "den Ruinen gesehen"
	cont "hast?"

	para "Es scheint, sie"
	line "ähneln den"

	para "Zeichnungen an"
	line "den Wänden."

	para "Hmm…"

	para "Das bedeutet, es"
	line "gibt viele"
	cont "von ihnen…"
	done

.GotAllUnown:
	readvar VAR_UNOWNCOUNT
	ifequalfwd NUM_UNOWN, .ResearchComplete
	readvar VAR_UNOWNCOUNT
	ifgreater 10, .ResearchOngoing
	jumpthisopenedtext

	text "Warum sind diese"
	line "antiken Muster"

	para "jetzt an den Wän-"
	line "den aufgetaucht?"

	para "Das wird immer"
	line "geheimnisvoller…"
	done

.ResearchComplete:
	writetext RuinsOfAlphResearchCenterScientist2Text_RadioWaves
	waitbutton
	closetext
	clearevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	end

.ResearchOngoing:
	jumpthisopenedtext

	text "Wir denken, dass"
	line "irgendetwas für"

	para "die rätselhaften"
	line "Muster in den"

	para "Ruinen verantwort-"
	line "lich war."

	para "Darauf basiert"
	line "unsere Forschung."
	done

RuinsOfAlphResearchCenterScientist4Script:
	checkevent EVENT_RUINS_OF_ALPH_CLIMAX_DONE
	iftruefwd .CanResurrectFossils
	checkflag ENGINE_UNOWN_DEX
	iffalse_jumptextfaceplayer .TooBusyText
	jumpthistextfaceplayer

	text "Untersuchst du"
	line "auch die Icognito?"

	para "Vielleicht habe"
	line "ich mit deiner"

	para "Hilfe Zeit, meine"
	line "Forschung über die"

	para "#mon-Fossilien"
	line "hier abschließen."
	done

.CanResurrectFossils
	faceplayer
	opentext
	checkevent EVENT_CAN_RESURRECT_FOSSILS_IN_RUINS_OF_ALPH
	iftruefwd .SkipIntro
	writetext .IntroText
	waitbutton
	setevent EVENT_CAN_RESURRECT_FOSSILS_IN_RUINS_OF_ALPH
.SkipIntro
	writetext .QuestionText
	waitbutton
	loadmem wResurrectFossilScriptBank, BANK(.FaceUp)
	loadmem wResurrectFossilScript+0, LOW(.FaceUp)
	loadmem wResurrectFossilScript+1, HIGH(.FaceUp)
	farsjump AskResurrectFossilScript

.FaceUp:
	turnobject RUINSOFALPHRESEARCHCENTER_SCIENTIST4, UP
	end

.TooBusyText:
	text "Manchmal finden"
	line "wir Fossilien im"

	para "Gestein, das wir"
	line "hier ausgraben."

	para "Ich würde sie gern"
	line "erforschen… aber"

	para "bisher hat mich"
	line "das Entschlüsseln"
	cont "der Ruinen zu sehr"
	cont "beschäftigt."
	done

.IntroText:
	text "Du bist doch das"
	line "Kind, das hinter"
	cont "die Geheimnisse"
	cont "der Icognito kam!"

	para "Dank dir hatte ich"
	line "Zeit für meine"

	para "Leidenschaft, die"
	line "Fossilien."

	para "Ich habe einen Weg"
	line "gefunden, aus"
	cont "ihnen lebende"
	cont "#mon zu holen!"
	done

.QuestionText:
	text "Findest du in"
	line "einem Felsen ein"
	cont "Fossil, bring es"

	para "her, dann belebe"
	line "ich es für dich"
	cont "wieder."
	done

MapRuinsofAlphResearchCenterSignpost1Script:
	opentext
	checkevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	iffalsefwd .SkipChecking
	checkevent EVENT_DECO_UNOWN_DOLL
	iftruefwd .SkipChecking
	jumpthisopenedtext

	text "Alph-Ruinen"
	line "10. Forschungsjahr"
	done

.SkipChecking:
	readvar VAR_UNOWNCOUNT
	jumpopenedtext RuinsOfAlphResearchCenterComputerText_GotAllUnown

RuinsOfAlphResearchCenterApproachesComputerMovement:
	step_up
	step_up
	step_left
	turn_head_up
	step_end

RuinsOfAlphResearchCenterModifiedDexText:
	text "Geschafft!"

	para "Ich habe deinen"
	line "#dex erweitert."

	para "Ich habe dir einen"
	line "optionalen #dex"

	para "extra für Icognito"
	line "eingebaut. Er"

	para "speichert sie in"
	line "alphabetischer"
	cont "Reihenfolge."
	done

RuinsOfAlphResearchCenterDexUpgradedText:
	text "<PLAYER>s #dex"
	line "wurde erweitert."
	done

RuinsOfAlphResearchCenterScientist3Text:
	text "Alle Icognito, die"
	line "du fängst, werden"
	cont "aufgezeichnet."

	para "Sieh nach, wie"
	line "viele Arten es"
	cont "gibt."

	para "Du tust uns einen"
	line "Gefallen, also"

	para "bekommst du etwas"
	line "Schönes, wenn du"
	cont "alle findest."
	done

RuinsOfAlphResearchCenterScientist3_PrinterAvailable:
	text "Du hast alle"
	line "Icognito-Varianten"
	cont "gefangen?"

	para "Das ist eine"
	line "großartige"
	cont "Leistung!"

	para "Du warst unserer"
	line "Forschung eine"
	cont "große Hilfe."

	para "Ich möchte dir das"
	line "hier geben."
	done

GotUnownDollText:
	text "<PLAYER> erhält"
	line "Icognito-Puppe."
	done

UnownDollSentText:
	text "Icognito-Puppe"
	line "wurde nach Hause"
	cont "geschickt."
	done

RuinsofAlphResearchCenterScientistRewardText:
	text "Diese Puppe habe"
	line "ich selbst"
	cont "entworfen!"
	done

RuinsofAlphResearchCenterScientistInterruptedText:
	text "Du kannst--"
	done

RuinsofAlphResearchCenterScientistShockedText:
	text "Was war DAS?!"
	done

RuinsOfAlphResearchCenterScientist1Text_GotAllUnown:
	text "Unsere Forschung"
	line "und deine Hilfe"

	para "geben uns einen"
	line "tiefen Einblick in"
	cont "die Ruinen."

	para "Es scheint, als ob"
	line "die Ruinen als"

	para "Habitat für #-"
	line "mon gebaut wurden."
	done

RuinsOfAlphResearchCenterScientist2Text_RadioWaves:
	text "Unsere Forschung"
	line "hat ergeben…,"

	para "diese selt-"
	line "samen Muster ent-"
	cont "standen, als das"

	para "#Kom-Center"
	line "errichtet wurde."

	para "Das bedeutet, dass"
	line "Radiowellen einen"

	para "gewissen Einfluß"
	line "haben…"
	done

RuinsOfAlphResearchCenterComputerText_GotAllUnown:
	text "Geheimnisvolles"
	line "#mon"
	cont "Name: Icognito"

	para "Insgesamt "
	text_decimal hScriptVar, 1, 2
	line "Arten gefunden."
	done

RuinsOfAlphResearchCenterPrinterText_DoesntWork:
	text "Ein Drucker."
	line "Das Display zeigt"
	cont "“PC LOAD LETTER”."

	para "…Was soll das"
	line "heißen?"
	done

RuinsOfAlphResearchCenterProfSilktreePhotoText:
	text "Ein Foto von Prof."
	line "Seidenbaum, dem"

	para "Gründer des For-"
	line "schungszentrums."
	done

RuinsOfAlphResearchCenterFossilComputerText:
	text "“Wiederbelebung"
	line "der Vergangen-"
	cont "heit”…"

	para "Eine Abhandlung"
	line "über #mon-"
	cont "Fossilien."
	done

RuinsOfAlphResearchCenterAcademicBooksText:
	text "Es gibt viele"
	line "wissenschaftliche"
	cont "Bücher dort."

	para "Antike Ruinen…"
	line "Geheimnisse der"
	cont "Antike…"
	done
