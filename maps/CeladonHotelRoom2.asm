CeladonHotelRoom2_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  5, CELADON_HOTEL_2F, 3
	warp_event  4,  5, CELADON_HOTEL_2F, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  2, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, MrHyperScript, -1

MrHyperScript:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_MR_HYPER
	iftruefwd .IntroDone
	writetext .TextIntro
	waitbutton
	setevent EVENT_TALKED_TO_MR_HYPER
	; fallthrough
.IntroDone:
	writetext .TextAskTrain
	yesorno
	iffalse_jumpopenedtext .TextComeBackAnytime
.CheckBottleCaps:
	checkitem BOTTLE_CAP
	iffalse_jumpopenedtext .TextNoBottleCaps
	writetext .TextTrainWho
	waitbutton
	special Special_HyperTrain
	iffalse_jumpopenedtext .TextComeBackAnytime
	takeitem BOTTLE_CAP
	writetext .TextGotStronger
	waitbutton
	writetext .TextTrainSomeMore
	yesorno
	iftrue .CheckBottleCaps
	jumpthisopenedtext

.TextComeBackAnytime:
	text "Komm jederzeit"
	line "wieder!"
	cont "Mr. Super-Spezial"
	cont "freut sich immer"
	cont "super auf dich!"
	done

.TextIntro:
	text "Ich bin"
	line "Mr. Super-Spezial!"
	cont "Weißt du, warum?"

	para "Weil ich #mon"
	line "beim Super-Spe-"
	cont "zialtraining"
	cont "helfen kann!"

	para "Damit wird ein"
	line "#mon, das schon"
	cont "voll trainiert"
	cont "ist, noch stärker!"

	para "Dieses Training"
	line "steigert seine"
	cont "Statuswerte."

	para "Wenn ich deine"
	line "#mon trainieren"
	cont "soll, bring mir"
	cont "ein paar Kron-"
	cont "korken."
	done

.TextAskTrain:
	text "Was meinst du?"
	line "Willst du mein"
	cont "Super-Spezial-"
	cont "training testen?"
	done

.TextNoBottleCaps:
	text "Du hast keine"
	line "Kronkorken?"

	para "Angler ziehen"
	line "manchmal welche"
	cont "aus dem Wasser…"
	done

.TextTrainWho:
	text "Welches #mon"
	line "trainieren?"
	done

.TextGotStronger:
	text "Fertig! Das Trai-"
	line "ning verbesserte"
	cont "die Werte von"
	cont ""
	text_ram wStringBuffer1
	text "!"
	done

.TextTrainSomeMore:
	text "Noch ein #mon"
	line "trainieren?"
	done
