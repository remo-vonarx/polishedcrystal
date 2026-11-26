Route3CableCarGate_MapScriptHeader:
	def_scene_scripts
	scene_script Route3CableCarGateAskEnterScene, SCENE_ROUTE3CABLECARGATE_ASK_ENTER
	scene_script Route3CableCarGateLeaveScene, SCENE_ROUTE3CABLECARGATE_LEAVE

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route3CableCarGateMoveReceptionistCallback

	def_warp_events
	warp_event  6, 11, ROUTE_3, 2
	warp_event  7, 11, ROUTE_3, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  6,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, Route3CableCarGateReceptionistScript, -1
	object_event  3, 10, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route3CableCarGateNurseScript, -1
	object_event 11, 10, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route3CableCarGatePokefanMText, -1
	object_event  1,  8, SPRITE_CAMPER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route3CableCarGateYoungsterText, -1
	object_event  5,  3, SPRITE_CABLE_CAR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  6,  3, SPRITE_CABLE_CAR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  7,  3, SPRITE_CABLE_CAR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, end, NULL, -1

	object_const_def
	const ROUTE3CABLECARGATE_RECEPTIONIST

Route3CableCarGateMoveReceptionistCallback:
	readmem wCableCarGatesSceneID
	iffalsefwd .Nothing
	moveobject ROUTE3CABLECARGATE_RECEPTIONIST, 5, 4
	turnobject ROUTE3CABLECARGATE_RECEPTIONIST, RIGHT
.Nothing
	endcallback

Route3CableCarGateLeaveScene:
	sdefer Route3CableCarGate_PlayerArrives
Route3CableCarGateAskEnterScene:
	end

Route3CableCarGate_PlayerArrives:
	follow PLAYER, ROUTE3CABLECARGATE_RECEPTIONIST
	applymovement PLAYER, .LeaveCableCarMovement
	stopfollow
	moveobject ROUTE3CABLECARGATE_RECEPTIONIST, 6, 6
	setscene SCENE_ROUTE3CABLECARGATE_ASK_ENTER
	end

.LeaveCableCarMovement:
	step_down
	step_down
	step_down
	step_end

Route3CableCarGateReceptionistScript:
	faceplayer
	opentext
	writetext .ReadyToGoUpText
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
	setmapscene MOUNT_MOON_SQUARE_CABLE_CAR_GATE, SCENE_MOUNTMOONSQUARECABLECARGATE_LEAVE
	warpfacing DOWN, MOUNT_MOON_SQUARE_CABLE_CAR_GATE, 6, 4
	end

.ReadyToGoUpText:
	text "Die Seilbahn ist"
	line "bereit für die"
	cont "Bergfahrt."

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
	step_left
	turn_head_right
	step_end

Route3CableCarGateNurseScript:
	faceplayer
	opentext
	checkevent EVENT_INTRODUCED_CABLE_CAR_GATE_NURSE
	iftruefwd .SkipIntro
	writetext .IntroText
	setevent EVENT_INTRODUCED_CABLE_CAR_GATE_NURSE
.SkipIntro
	writetext .HealText
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	playmusic MUSIC_HEAL
	special HealParty
	pause 60
	special Special_FadeInQuickly
	special RestartMapMusic
	jumpthistext

	text "Deine #mon sind"
	line "wieder topfit!"
	done

.IntroText:
	text "Hallo! Willkommen"
	line "im #mon-Cen--"

	para "Hoppla! Tut mir"
	line "leid, die Macht"
	cont "der Gewohnheit."

	para "Hier war früher"
	line "das #mon-"
	cont "Center, in dem"
	cont "ich gearbeitet"
	cont "habe."

	para "Jetzt ist es eine"
	line "Seilbahnstation,"
	cont "aber trotzdem…"
	prompt

.HealText:
	text "Ich kann deine"
	line "#mon wieder"
	cont "vollständig"
	cont "heilen."
	done

Route3CableCarGatePokefanMText:
	text "Vor ein paar Jah-"
	line "ren habe ich die-"

	para "sem Jungen ein"
	line "seltsam gefärbtes"
	cont "Karpador verkauft…"

	para "Ich dachte, mit"
	line "ihm stimmt etwas"
	cont "nicht."

	para "Dabei war es ein"
	line "seltenes schil-"
	cont "lerndes #mon!"

	para "Ich hätte viel"
	line "mehr dafür ver-"
	cont "langen können!"
	done

Route3CableCarGateYoungsterText:
	text "Auf dem Berg sind"
	line "viele Trainer."

	para "Auch viele wilde"
	line "#mon."

	para "Man weiß nie, wem"
	line "oder was man be-"
	cont "gegnet."
	done
