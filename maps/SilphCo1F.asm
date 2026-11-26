SilphCo1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .SilphCo1FMoveOfficerCallback

	def_warp_events
	warp_event  2,  9, SAFFRON_CITY, 7
	warp_event  3,  9, SAFFRON_CITY, 21
	warp_event 13,  0, SILPH_CO_2F, 1

	def_coord_events

	def_bg_events
	bg_event  8,  0, BGEVENT_JUMPTEXT, SilphCoElevatorText

	def_object_events
	object_event 13,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SilphCoOfficerScript, -1
	object_event  4,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCoReceptionistText, -1
	object_event 11,  3, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCo1FGentlemanText, -1
	object_event  8,  4, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCo1FCooltrainerfText, -1

	object_const_def
	const SILPHCO1F_OFFICER

.SilphCo1FMoveOfficerCallback:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalsefwd .Nothing
	moveobject SILPHCO1F_OFFICER, 14, 1
.Nothing
	endcallback

SilphCoOfficerScript:
	faceplayer
	opentext
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftruefwd .OfficerScriptAfterPowerRestored
	jumpthisopenedtext

	text "Nur das Personal"
	line "hat Zutritt zu den"
	cont "oberen Geschossen."

	para "Der Hauptstrom"
	line "ist ausgefallen,"

	para "und der Präsident"
	line "will für Notfälle"

	para "strenge Sicher-"
	line "heitsmaßnahmen."

	para "Daraus haben wir"
	line "vor drei Jahren"
	cont "gelernt."
	done

.OfficerScriptAfterPowerRestored
	jumpthisopenedtext

	text "Du hast die Strom-"
	line "versorgung wieder-"
	cont "hergestellt?"

	para "Danke! Jetzt kann"
	line "die Forschung"
	cont "weitergehen."

	para "Sieh dich oben"
	line "ruhig um."
	done

SilphCoReceptionistText:
	text "Willkommen. Das"
	line "ist das Büro-"
	cont "gebäude der"
	cont "Silph Co."
	done


SilphCo1FGentlemanText:
	text "Ich habe einen"
	line "Termin mit dem"

	para "Chefingenieur hier"
	line "bei der Silph Co."
	done

SilphCo1FCooltrainerfText:
	text "Ich versuche, all"
	line "meinen Mut zusam-"
	cont "menzunehmen, um"

	para "die Empfangsdame"
	line "um ein Date zu"
	cont "bitten."

	para "Sobald sie mit dem"
	line "Telefonat fertig"
	cont "ist…"
	done

SilphCoElevatorText:
	text "Außer Betrieb"
	done
