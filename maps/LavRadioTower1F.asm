LavRadioTower1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, LavRadioTower1FUpstairsScript

	def_warp_events
	warp_event  2,  7, LAVENDER_TOWN, 7
	warp_event  3,  7, LAVENDER_TOWN, 7
	warp_event 15,  0, LAV_RADIO_TOWER_2F, 255

	def_coord_events

	def_bg_events
	bg_event 11,  0, BGEVENT_JUMPTEXT, LavRadioTower1FDirectoryText
	bg_event  5,  0, BGEVENT_JUMPTEXT, LavRadioTower1FPokeFluteSignText

	def_object_events
	object_event  6,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavRadioTower1FReceptionistText, -1
	object_event 15,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavRadioTower1FOfficerText, -1
	object_event  1,  3, SPRITE_POKEMANIAC, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavRadioTower1FSuperNerd1Text, -1
	object_event  9,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FGentlemanScript, -1
	object_event 14,  6, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FSuperNerd2Script, -1

LavRadioTower1FUpstairsScript:
	checkevent EVENT_EXORCISED_LAV_RADIO_TOWER
	iftruefwd .Exorcised
	warpmod 1, HAUNTED_RADIO_TOWER_2F
	endcallback

.Exorcised:
	warpmod 1, LAV_RADIO_TOWER_2F
	endcallback

LavRadioTower1FGentlemanScript:
	faceplayer
	opentext
	checkflag ENGINE_EXPN_CARD
	iftrue_jumpopenedtext .GotExpnCardText
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse_jumpopenedtext .OffTheAirText
	writetext .ReturnedMachinePartText
	promptbutton
	givespecialitem EXPN_CARD
	setflag ENGINE_EXPN_CARD
	jumpthisopenedtext

.GotExpnCardText:
	text "Damit kannst du"
	line "die Radioprogramme"

	para "in Kanto"
	line "empfangen."

	para "Hahahahaha!"
	done

.OffTheAirText:
	text "Nein, nein, nein!"

	para "Wir sind nicht"
	line "mehr auf Sendung,"

	para "seit das Kraftwerk"
	line "nicht mehr läuft."

	para "Alle Bemühungen,"
	line "diese Station zum"

	para "Laufen zu bringen,"
	line "sind vergebens,"
	cont "wenn ich nichts"
	cont "senden kann."

	para "Ich bin ruiniert!"
	done

.ReturnedMachinePartText:
	text "Ah! Dann bist du"
	line "<PLAYER>. Du hast"

	para "das Problem mit"
	line "dem Kraftwerk"
	cont "gelöst?"

	para "Dir habe ich es zu"
	line "verdanken, dass"

	para "ich nicht arbeits-"
	line "los wurde! Du bist"
	cont "mein Lebensretter!"

	para "Zum Dank gebe ich"
	line "dir das hier."
	done

LavRadioTower1FSuperNerd2Script:
	checkflag ENGINE_EXPN_CARD
	iftrue_jumptextfaceplayer LavRadioTower1FSuperNerd2Text_GotExpnCard
	jumpthistextfaceplayer

	text "Hey there!"

	para "I am the super"
	line "Music Director!"

	para "Huh? Your #gear"
	line "can't tune into my"

	para "music programs."
	line "How unfortunate!"

	para "If you get a Expn."
	line "Card upgrade, you"

	para "can tune in. You'd"
	line "better get one!"
	done

LavRadioTower1FReceptionistText:
	text "Willkommen!"
	line "Schau dich auf"

	para "dieser Etage"
	line "ruhig um."
	done

LavRadioTower1FOfficerText:
	text "Du darfst leider"
	line "nur das Erd-"
	cont "geschoss erkunden."

	para "Seit der Radioturm"
	line "in Johto von einer"

	para "Verbrechergang"
	line "besetzt wurde,"

	para "mussten wir unsere"
	line "Sicherheitsmaß-"
	cont "nahmen erhöhen."
	done

LavRadioTower1FSuperNerd1Text:
	text "Viele Menschen"
	line "arbeiten sehr hart"
	cont "im Radioturm."

	para "Sie müssen ihr"
	line "Bestes geben für"
	cont "eine gute Sendung."
	done

LavRadioTower1FSuperNerd2Text_GotExpnCard:
	text "Hi, mein Freund!"

	para "Ich bin der"
	line "tolle Musik-"
	cont "redakteur!"

	para "Ich bin derjenige,"
	line "der diese wunder-"
	cont "vollen Melodien"

	para "auf Sendung"
	line "bringt."

	para "Sei so frei"
	line "und lausche der"
	cont "schönen Melodei!"
	done

LavRadioTower1FDirectoryText:
	text "EG Rezeption"
	line "1S Verkauf"
	cont "2S Personal"
	cont "3S Produktion"
	cont "4S Büro des"
	cont "   Intendanten"
	done

LavRadioTower1FPokeFluteSignText:
	text "Mach deine #mon"
	line "mit den Fröhlichen"

	para "Melodien der #-"
	line "Flöte auf Programm"
	cont "20 wieder munter."
	done

; TODO: use this text
LavRadioTower1FReferenceLibraryText:
	text "Wow! A full rack"
	line "of #mon CDs and"
	cont "videos."

	para "This must be the"
	line "reference library."
	done
