FuchsiaAquarium1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, FuchsiaAquariumCheckIfWeekend

	def_warp_events
	warp_event  6,  9, FUCHSIA_CITY, 12
	warp_event  7,  9, FUCHSIA_CITY, 13
	warp_event 10,  2, FUCHSIA_AQUARIUM_2F, 1

	def_coord_events

	def_bg_events
	bg_event  1,  5, BGEVENT_READ, FuchsiaAquarium1FGoldeenOrQwilfishSign
	bg_event  2,  5, BGEVENT_READ, FuchsiaAquarium1FMagikarpSign
	bg_event 13,  5, BGEVENT_READ, FuchsiaAquarium1FCorsolaSign
	bg_event 15,  5, BGEVENT_READ, FuchsiaAquarium1FTentacoolOrHorseaSign
	bg_event 16,  5, BGEVENT_READ, FuchsiaAquarium1FChinchouSign
	bg_event  8,  3, BGEVENT_JUMPTEXT, FuchsiaAquarium1FLaprasStatueSignText
	bg_event  5,  2, BGEVENT_JUMPTEXT, FuchsiaAquarium1FPoster1Text
	bg_event  6,  2, BGEVENT_JUMPTEXT, FuchsiaAquarium1FPoster2Text

	def_object_events
	object_event  1,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_TOP, 0, GOLDEEN, -1, PAL_NPC_AQUA_RED, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  1,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_TOP, 0, QWILFISH, -1, PAL_NPC_AQUA_PURPLE, OBJECTTYPE_DONOTHING, HISUIAN_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  2,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_ADMIN_MEOWTH, 0, MAGIKARP, -1, PAL_NPC_AQUA_RED, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, -1
	object_event 13,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_BOTTOM, 0, CORSOLA, -1, PAL_NPC_AQUA_RED, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, -1
	object_event 15,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_TOP, 0, TENTACOOL, -1, PAL_NPC_AQUA_BLUE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 15,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_TOP, 0, HORSEA, -1, PAL_NPC_AQUA_BLUE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 16,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_BOTTOM, 0, CHINCHOU, -1, PAL_NPC_AQUA_BLUE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, -1
	object_event  3, 9, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaAquarium1FReceptionistText, -1
	object_event  1, 9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaAquarium1FOfficerText, -1
	object_event  9,  6, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaAquarium1FCuteGirlText, -1
	object_event  4, 4, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaAquarium1FSchoolboyText, -1
	object_event  13, 9, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaAquarium1FFisherText, -1
	object_event  14, 9, SPRITE_AROMA_LADY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_ORANGE, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaAquarium1FAromaLadyText, -1

FuchsiaAquariumCheckIfWeekend:
	readvar VAR_WEEKDAY
	ifequalfwd SATURDAY, .weekend
	ifequalfwd SUNDAY, .weekend
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	endcallback

.weekend
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endcallback

FuchsiaAquarium1FGoldeenOrQwilfishSign:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftruefwd .weekend
	showtext .GoldeenText
	reanchormap
	pokepic GOLDEEN
	cry GOLDEEN
	waitbutton
	closepokepic
	setmonval GOLDEEN
	special SpecialSeenMon
	end

.weekend:
	showtext .QwilfishText
	reanchormap
	pokepic QWILFISH, HISUIAN_FORM
	cry QWILFISH, HISUIAN_FORM
	waitbutton
	closepokepic
	setmonval QWILFISH, HISUIAN_FORM
	special SpecialSeenMon
	end

.GoldeenText:
	text "Name: Goldini"

	para "Seine Schwanz-"
	line "flosse wallt wie"
	cont "ein Ballkleid,"

	para "daher nennt man es"
	line "“Wasserkönigin”."
	done

.QwilfishText:
	text "Name: Baldorfish"

	para "Es frisst giftige"
	line "Mineralien, um in"

	para "seinem Körper Gift"
	line "zur Verteidigung"
	cont "anzusammeln."
	done

FuchsiaAquarium1FMagikarpSign:
	showtext .MagikarpText
	reanchormap
	pokepic MAGIKARP
	cry MAGIKARP
	waitbutton
	closepokepic
	setmonval MAGIKARP
	special SpecialSeenMon
	end

.MagikarpText:
	text "Name: Karpador"

	para "Der Legende nach"
	line "entwickelt sich"
	cont "ein Karpador, das"

	para "einen Wasserfall"
	line "hinaufsteigt, zu"
	cont "einem mächtigen"
	cont "Garados."
	done

FuchsiaAquarium1FCorsolaSign:
	showtext .CorsolaText
	reanchormap
	pokepic CORSOLA
	cry CORSOLA
	waitbutton
	closepokepic
	setmonval CORSOLA
	special SpecialSeenMon
	end

.CorsolaText:
	text "Name: Corasonn"

	para "Es wirft ständig"
	line "Teile ab und"
	cont "wächst nach."

	para "Die Spitze seines"
	line "Kopfes ist wegen"

	para "ihrer Schönheit"
	line "als Schatz"
	cont "begehrt."
	done

FuchsiaAquarium1FTentacoolOrHorseaSign:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftruefwd .weekend
	showtext .TentacoolText
	reanchormap
	pokepic TENTACOOL
	cry TENTACOOL
	waitbutton
	closepokepic
	setmonval TENTACOOL
	special SpecialSeenMon
	end

.weekend:
	showtext .HorseaText
	reanchormap
	pokepic HORSEA
	cry HORSEA
	waitbutton
	closepokepic
	setmonval HORSEA
	special SpecialSeenMon
	end

.TentacoolText:
	text "Name: Tentacha"

	para "Sein Körper be-"
	line "steht fast nur"
	cont "aus Wasser."

	para "Aus seinen kris-"
	line "tallartigen Augen"
	cont "schießt es selt-"
	cont "same Strahlen."
	done

.HorseaText:
	text "Name: Seeper"

	para "Es baut sein Nest"
	line "im Schatten von"
	cont "Corasonn-Kolonien."
	done

FuchsiaAquarium1FChinchouSign:
	showtext .ChinchouText
	reanchormap
	pokepic CHINCHOU
	cry CHINCHOU
	waitbutton
	closepokepic
	setmonval CHINCHOU
	special SpecialSeenMon
	end

.ChinchouText:
	text "Name: Lampi"

	para "Es lässt seine"
	line "Fühler aufblitzen,"

	para "um sich mit ande-"
	line "ren Lampi zu ver-"
	cont "ständigen."
	done

FuchsiaAquarium1FLaprasStatueSignText:
	text "Lapras waren einst"
	line "wegen Wilderei"
	cont "fast ausgestorben."

	para "Dank der Zucht in"
	line "Gefangenschaft"
	cont "durch Silph Co."

	para "und neuer Schutz-"
	line "bestimmungen gibt"

	para "es heute sogar"
	line "zu viele davon."
	done

FuchsiaAquarium1FPoster1Text:
	text "Bitte nicht gegen"
	line "die Scheibe"
	cont "klopfen."
	done

FuchsiaAquarium1FPoster2Text:
	text "Bitte nichts in"
	line "die Becken"
	cont "werfen."
	done

FuchsiaAquarium1FReceptionistText:
	text "Willkommen im"
	line "Aquarium von"
	cont "Fuchsania City!"

	para "Unsere Ausstel-"
	line "lung wurde durch"

	para "großzügige Spenden"
	line "der Silph Co."
	cont "finanziert."
	done

FuchsiaAquarium1FOfficerText:
	text "Früher habe ich"
	line "#mon für das"
	cont "Safari-Spiel"
	cont "eingefangen,"

	para "jetzt putze ich"
	line "hier ihre Becken."

	para "Immerhin hat"
	line "dieser Job eine"
	cont "Klimaanlage!"
	done

FuchsiaAquarium1FCuteGirlText:
	text "Hier gab es mal"
	line "ein Octillery,"

	para "aber es ist immer"
	line "wieder aus seinem"

	para "Becken geklettert,"
	line "um sich das"
	cont "Aquarium selbst"
	cont "anzusehen."
	done

FuchsiaAquarium1FSchoolboyText:
	text "Forscher glauben,"
	line "dass alles Leben"

	para "als Mikroben im"
	line "Meer begann."

	para "Es dauerte Milli-"
	line "arden Jahre, bis"

	para "daraus all diese"
	line "Arten wurden."
	done

FuchsiaAquarium1FFisherText:
	text "Hier sehe ich"
	line "#mon, die ich"

	para "beim Angeln noch"
	line "nie fangen"
	cont "konnte."
	done

FuchsiaAquarium1FAromaLadyText:
	text "Sehen die #mon"
	line "nicht aus wie"
	cont "lebende Juwelen?"

	para "Sie strahlen sogar"
	line "ihr eigenes fun-"
	cont "kelndes Licht aus!"
	done
