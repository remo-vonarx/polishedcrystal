MountMoonSquareCableCarGate_MapScriptHeader:
	def_scene_scripts
	scene_script MountMoonSquareCableCarGateAskEnterScene, SCENE_MOUNTMOONSQUARECABLECARGATE_ASK_ENTER
	scene_script MountMoonSquareCableCarGateLeaveScene, SCENE_MOUNTMOONSQUARECABLECARGATE_LEAVE

	def_callbacks
	callback MAPCALLBACK_OBJECTS, MountMoonSquareCableCarGateMoveReceptionistCallback

	def_warp_events
	warp_event  6, 11, MOUNT_MOON_SQUARE, 2
	warp_event  7, 11, MOUNT_MOON_SQUARE, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  6,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, MountMoonSquareCableCarGateReceptionistScript, -1
	object_event 10,  9, SPRITE_HIKER, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, MountMoonSquareCableCarGateHikerScript, -1
	object_event  3,  8, SPRITE_LADY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_GRAY, OBJECTTYPE_COMMAND, jumptextfaceplayer, MountMoonSquareCableCarGateLadyText, -1
	object_event  5,  3, SPRITE_CABLE_CAR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  6,  3, SPRITE_CABLE_CAR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  7,  3, SPRITE_CABLE_CAR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, end, NULL, -1

	object_const_def
	const MOUNTMOONSQUARECABLECARGATE_RECEPTIONIST

MountMoonSquareCableCarGateMoveReceptionistCallback:
	readmem wCableCarGatesSceneID
	iffalsefwd .Nothing
	moveobject MOUNTMOONSQUARECABLECARGATE_RECEPTIONIST, 7, 4
	turnobject MOUNTMOONSQUARECABLECARGATE_RECEPTIONIST, LEFT
.Nothing
	endcallback

MountMoonSquareCableCarGateLeaveScene:
	sdefer MountMoonSquareCableCarGate_PlayerArrives
MountMoonSquareCableCarGateAskEnterScene:
	end

MountMoonSquareCableCarGate_PlayerArrives:
	follow PLAYER, MOUNTMOONSQUARECABLECARGATE_RECEPTIONIST
	applymovement PLAYER, .LeaveCableCarMovement
	stopfollow
	moveobject ROUTE3CABLECARGATE_RECEPTIONIST, 6, 6
	setscene SCENE_MOUNTMOONSQUARECABLECARGATE_ASK_ENTER
	end

.LeaveCableCarMovement:
	step_down
	step_down
	step_down
	step_end

MountMoonSquareCableCarGateReceptionistScript:
	faceplayer
	opentext
	writetext .ReadyToGoDownText
	yesorno
	iffalse_jumpopenedtext .AnotherTimeText
	writetext .StepThisWayText
	waitbutton
	closetext
	follow ROUTE3CABLECARGATE_RECEPTIONIST, PLAYER
	applymovement ROUTE3CABLECARGATE_RECEPTIONIST, .ApproachCableCarMovement
	stopfollow
	pause 15
	playsound SFX_EXIT_BUILDING
	applyonemovement PLAYER, hide_object
	waitsfx
	disappear PLAYER
	special Special_FadeOutMusic
	special FadeOutPalettes
	pause 15
	special Special_CableCar
	setmapscene ROUTE_3_CABLE_CAR_GATE, SCENE_ROUTE3CABLECARGATE_LEAVE
	warpfacing DOWN, ROUTE_3_CABLE_CAR_GATE, 6, 4
	end

.ReadyToGoDownText:
	text "Die Seilbahn ist"
	line "bereit für die"
	cont "Talfahrt."

	para "Möchtest du mit-"
	line "fahren?"
	done

.AnotherTimeText:
	text "Bitte fahr ein"
	line "andermal mit uns."
	done

.StepThisWayText:
	text "Hier entlang"
	line "bitte."
	done

.ApproachCableCarMovement:
	step_up
	step_up
	step_right
	turn_head_left
	step_end

MountMoonSquareCableCarGateHikerScript:
	checkevent EVENT_GOT_EJECT_PACK_FROM_MOUNT_MOON_SQUARE
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem EJECT_PACK, iffalse_endtext
	setevent EVENT_GOT_EJECT_PACK_FROM_MOUNT_MOON_SQUARE
	jumpthisopenedtext

.Text2:
	text "Wenn die Werte"
	line "deines #mon"
	cont "gesenkt werden,"

	para "holt die Flucht-"
	line "tasche es blitz-"
	cont "schnell aus dem"
	cont "Kampf zurück."
	done

.Text1:
	text "Als ich das erste"
	line "Mal den Mondberg"
	cont "bestieg,"

	para "gab es oben nichts"
	line "außer reiner"
	cont "Bergluft."

	para "Jetzt bringt mich"
	line "die Seilbahn im Nu"
	cont "wieder runter."

	para "Diese Fluchttasche"
	line "brauche ich also"
	cont "doch nicht mehr."
	done

MountMoonSquareCableCarGateLadyText:
	text "Dank der Seilbahn"
	line "können Leute wie"

	para "ich diesen schönen"
	line "Platz genießen,"

	para "die es nie allein"
	line "auf den Mondberg"
	cont "geschafft hätten."

	para "Ist Technik nicht"
	line "nützlich?"
	done
