CianwoodCityPhotoStudio_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CIANWOOD_CITY, 5
	warp_event  3,  7, CIANWOOD_CITY, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CianwoodPhotoStudioFishingGuruScript, -1

CianwoodPhotoStudioFishingGuruScript:
	faceplayer
	opentext
	checkflag ENGINE_DAILY_PHOTOGRAPH
	iftrue_jumpopenedtext PhotoStudioAlreadyDoneText
	writetext PhotoStudioGreetingText
	yesorno
	iffalse_jumpopenedtext PhotoStudioRefusedText
	writetext PhotoStudioWhichMonText
	promptbutton
	special Special_CianwoodPhotograph
	ifequalfwd $0, .NoPicture
	ifequalfwd $1, .EggPicture
	setflag ENGINE_DAILY_PHOTOGRAPH
	writetext PhotoStudioHoldStillText
	waitbutton
	closetext
	special FadeOutPalettes
	special LoadMapPalettes
	callasm LoadBlindingFlashPalette
	pause 10
	playsound SFX_DOUBLE_SLAP
	waitsfx
	pause 10
	special FadeInPalettes_EnableDynNoApply
	readmem wCurPartySpecies
	pokepic 0
	cry 0
	waitsfx
	closepokepic
	opentext
	writetext PhotoStudioPrestoText
	special PlayCurMonCry
	waitbutton
	jumpthisopenedtext

	text "Komm doch wieder,"
	line "ja?"
	done

.NoPicture:
	jumpthisopenedtext

	text "Kein Foto? Schau"
	line "mal wieder vorbei!"
	done

.EggPicture:
	jumpthisopenedtext

	text "Ein Ei? Mein"
	line "Talent hat mehr"
	cont "verdient…"
	done

PhotoStudioGreetingText:
	text "Ich bin Kamera-"
	line "kauz Wikbert."

	para "Deine #mon sind"
	line "großartig!"

	para "Wie wär's mit ei-"
	line "nem Foto als Sou-"
	cont "venir?"
	done

PhotoStudioWhichMonText:
	text "O.K.! Und jetzt"
	line "sag: Cheese!"

	para "Welches #mon"
	line "soll ich"
	cont "fotografieren?"
	done

PhotoStudioHoldStillText:
	text "O.K. Beweg dich"
	line "nicht."
	done

PhotoStudioPrestoText:
	text "Tadaa! Fertig."

	para "Schau, "
	text_ram wStringBuffer3
	line "wirkt glücklicher!"
	done

PhotoStudioAlreadyDoneText:
	text "Ich habe heute"
	line "schon ein Foto für"
	cont "dich gemacht."

	para "Komm morgen"
	line "wieder."
	done

PhotoStudioRefusedText:
	text "Oh, schade. Ich"
	line "dachte, das wäre"

	para "ein schönes Anden-"
	line "ken…"
	done
