HallOfFame_MapScriptHeader:
	def_scene_scripts
	scene_script HallOfFameEnterScene, SCENE_HALLOFFAME_ENTER
	scene_const SCENE_HALLOFFAME_NOOP

	def_callbacks

	def_warp_events
	warp_event  4, 13, LANCES_ROOM, 3
	warp_event  5, 13, LANCES_ROOM, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4, 12, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

	object_const_def
	const HALLOFFAME_LANCE

HallOfFameEnterScene:
	sdefer .Script
	end

.Script:
	follow HALLOFFAME_LANCE, PLAYER
	applymovement HALLOFFAME_LANCE, .WalkUpMovement
	stopfollow
	turnobject PLAYER, RIGHT
	opentext
	writetext .LanceText1
	waitbutton
	readvar VAR_BADGES
	ifequalfwd 16, .CheckGoldTrophy
	checkevent EVENT_DECO_SILVER_TROPHY
	iftruefwd .NoTrophy
	sjumpfwd .SilverTrophy
.CheckGoldTrophy
	checkevent EVENT_DECO_GOLD_TROPHY
	iftruefwd .NoTrophy
	sjumpfwd .GoldTrophy
.SilverTrophy
	writetext .LanceTrophyText
	waitbutton
	setevent EVENT_DECO_SILVER_TROPHY
	writetext .SilverTrophyText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext .SilverTrophySentText
	waitbutton
	sjumpfwd .NoTrophy
.GoldTrophy
	writetext .LanceTrophyText
	waitbutton
	setevent EVENT_DECO_GOLD_TROPHY
	writetext .GoldTrophyText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext .GoldTrophySentText
	waitbutton
.NoTrophy
	writetext .LanceText2
	waitbutton
	closetext
	turnobject HALLOFFAME_LANCE, UP
	applyonemovement PLAYER, slow_step_up
	setscene SCENE_HALLOFFAME_NOOP
	pause 15
	setval 2 ; Machine is in the Hall of Fame
	special HealMachineAnim
	readvar VAR_BADGES
	ifless 16, .NotATrueRematch
	setevent EVENT_BEAT_ELITE_FOUR_AGAIN
.NotATrueRematch
	setevent EVENT_BEAT_ELITE_FOUR
	setevent EVENT_RIVAL_SPROUT_TOWER
	setevent EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	clearevent EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	special RespawnOneOffs
	setmapscene SPROUT_TOWER_3F, SCENE_SPROUTTOWER3F_NOOP
	special HealParty
	checkevent EVENT_GOT_SS_TICKET_FROM_ELM
	iftruefwd .SkipPhoneCall
	specialphonecall SPECIALCALL_SSTICKET
	setevent EVENT_BATTLE_TOWER_OPEN
	clearevent EVENT_BATTLE_TOWER_CLOSED
.SkipPhoneCall:
	blackoutmod NEW_BARK_TOWN
	halloffame
	end

.WalkUpMovement:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_right
	turn_head_left
	step_end

.LanceText1:
	text "Siegfried: Ich war"
	line "schon lange nicht"
	cont "mehr hier."

	para "Hier werden die"
	line "Liga-Champs"

	para "für alle Ewigkeit"
	line "gewürdigt."

	para "Ihre mutigen #-"
	line "mon sind auch"
	cont "aufgeführt."
	done

.LanceTrophyText:
	text "Nimm dies als"
	line "Andenken an das,"

	para "was du heute hier"
	line "erreicht hast."
	done

.LanceText2:
	text "Hier und heute"
	line "wurden wir Zeuge"

	para "des Aufstiegs ei-"
	line "nes neuen Liga-"
	cont "Champs -- eines"
	cont "Trainers, der"

	para "Leidenschaft für"
	line "und Vertrauen in"
	cont "seine #mon hat."

	para "Ein Trainer,"
	line "dessen Erfolg auf"

	para "Ausdauer und"
	line "Entschlossenheit"
	cont "basiert."

	para "Der neue Liga-"
	line "Champ, der"

	para "alle Zeichen von"
	line "Größe in sich"
	cont "vereint!"

	para "<PLAYER>, darf ich"
	line "dich und deine"

	para "Partner als"
	line "Champs"
	cont "eintragen?"
	done

.GoldTrophyText:
	text "<PLAYER> erhält"
	line "Goldtrophäe."
	done

.GoldTrophySentText:
	text "Goldtrophäe"
	line "wurde nach Hause"
	cont "geschickt."
	done

.SilverTrophyText:
	text "<PLAYER> erhält"
	line "Silbertrophäe."
	done

.SilverTrophySentText:
	text "Silbertrophäe"
	line "wurde nach Hause"
	cont "geschickt."
	done
