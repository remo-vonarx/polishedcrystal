VioletGym_MapScriptHeader:
	def_scene_scripts
	scene_script VioletGymFalknerAwayScene, SCENE_VIOLETGYM_FALKNER_AWAY
	scene_const SCENE_VIOLETGYM_NOOP

	def_callbacks

	def_warp_events
	warp_event  4, 17, VIOLET_CITY, 2
	warp_event  5, 17, VIOLET_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, VioletGymStatue
	bg_event  6, 15, BGEVENT_READ, VioletGymStatue

	def_object_events
	object_event  4, 15, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_DARK_CAVE_FALKNER
	object_event  5,  2, SPRITE_FALKNER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletGymFalknerScript, EVENT_VIOLET_GYM_FALKNER
	object_event  7,  7, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_LEFT, 0, 2, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperRod, EVENT_VIOLET_GYM_FALKNER
	object_event  2, 11, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 2, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperAbe, EVENT_VIOLET_GYM_FALKNER
	object_event  7, 15, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VioletGymGuyScript, EVENT_VIOLET_GYM_FALKNER

	object_const_def
	const VIOLETGYM_GYM_GUY2

VioletGymFalknerAwayScene:
	sdefer .Script
	end

.Script:
	showemote EMOTE_SHOCK, VIOLETGYM_GYM_GUY2, 15
	applyonemovement VIOLETGYM_GYM_GUY2, step_down
	showtext VioletGymGuyFalknerAwayText
	turnobject PLAYER, DOWN
	warpcheck
	warpsound
	newloadmap MAPSETUP_DOOR
	end

VioletGymFalknerScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_FALKNER
	iftruefwd .FightDone
	writetext FalknerIntroText
	waitbutton
	closetext
	winlosstext FalknerWinLossText, 0
	loadtrainer FALKNER, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_FALKNER
	opentext
	givebadge ZEPHYRBADGE, JOHTO_REGION
.FightDone:
	checkevent EVENT_GOT_TM31_ROOST
	iftrue_jumpopenedtext FalknerFightDoneText
	setevent EVENT_BEAT_BIRD_KEEPER_ROD
	setevent EVENT_BEAT_BIRD_KEEPER_ABE
	setmapscene ELMS_LAB, SCENE_ELMSLAB_NOOP
	specialphonecall SPECIALCALL_ASSISTANT
	writetext FalknerZephyrBadgeText
	promptbutton
	verbosegivetmhm TM_ROOST
	setevent EVENT_GOT_TM31_ROOST
	jumpthisopenedtext

	text "Benutzt ein #-"
	line "mon eine TM, er-"

	para "lernt es sofort"
	line "eine neue Attacke."

	para "Eine TM kann so"
	line "oft eingesetzt"
	cont "werden, wie du"
	cont "willst."

	para "TM51 enthält"
	line "Ruheort."

	para "Damit landet es,"
	line "um die Hälfte der"
	cont "max. KP aufzu-"
	cont "füllen."
	done

GenericTrainerBird_keeperRod:
	generictrainer BIRD_KEEPER, ROD, EVENT_BEAT_BIRD_KEEPER_ROD, Bird_keeperRodSeenText, Bird_keeperRodBeatenText

	text "Falks Fähigkeiten"
	line "sind unübertreff-"
	cont "lich!"

	para "Du solltest dich"
	line "nicht überschät-"
	cont "zen, nur weil du"
	cont "mich geschlagen"
	cont "hast!"
	done

GenericTrainerBird_keeperAbe:
	generictrainer BIRD_KEEPER, ABE, EVENT_BEAT_BIRD_KEEPER_ABE, Bird_keeperAbeSeenText, Bird_keeperAbeBeatenText

	text "Das ist peinlich!"
	line "Von einem Anfänger"
	cont "besiegt…"
	done

VioletGymGuyScript:
	checkevent EVENT_BEAT_FALKNER
	iftrue_jumptextfaceplayer VioletGymGuyWinText
	jumpthistextfaceplayer

	text "Hey! Zwar bin ich"
	line "kein Trainer, aber"
	cont "ich kann dir gute"
	cont "Tipps geben!"

	para "Glaube mir!"
	line "Wenn du es tust,"

	para "kann dein Traum"
	line "von der Meister-"
	cont "schaft in Erfül-"
	cont "lung gehen."

	para "Du glaubst mir?"
	line "Dann pass auf!"

	para "Typ Pflanze ist"
	line "schwach gegen Typ"

	para "Flug. Das solltest"
	line "du dir merken."
	done

VioletGymStatue:
	gettrainername FALKNER, 1, STRING_BUFFER_4
	checkflag ENGINE_ZEPHYRBADGE
	iftruefwd .Beaten
	jumpstd gymstatue1
.Beaten:
	readvar VAR_BADGES
	ifgreater 8, .LyraToo
	jumpstd gymstatue2
.LyraToo
	jumpstd gymstatue3

FalknerIntroText:
	text "Ich bin Falk, der"
	line "Arenaleiter von"
	cont "Viola City!"

	para "Man sagt, dass man"
	line "die Flügel von"

	para "Flug-#mon mit"
	line "einem elektrischen"

	para "Blitz stutzen"
	line "kann…"

	para "So etwas werde ich"
	line "niemals zulassen!"

	para "Ich werde dich die"
	line "wahre Kraft der"

	para "Flug-#mon"
	line "spüren lassen!"
	done

FalknerWinLossText:
	text "…Verflixt! Mein"
	line "Vater hat Flug-"
	cont "#mon geliebt…"

	para "Also gut."
	line "Nimm dies!"

	para "Es ist der offi-"
	line "zielle Flügelorden"
	cont "der #mon"
	cont "Liga."
	done

FalknerZephyrBadgeText:
	text "Der Flügelorden"
	line "sorgt dafür, dass"

	para "dir #mon bis"
	line "<LV>20 gehorchen,"
	cont "auch getauschte."

	para "Hier - ich habe"
	line "noch etwas für"
	cont "dich."
	done


FalknerFightDoneText:
	text "In so mancher"
	line "Stadt warten noch"
	cont "Arenen auf dich."

	para "Du solltest dein"
	line "Können in diesen"
	cont "Arenen beweisen."

	para "Ich werde noch"
	line "härter trainieren,"

	para "um der grösste Vo-"
	line "gel-Experte aller"
	cont "Zeiten zu werden!"
	done

Bird_keeperRodSeenText:
	text "Das Motto lautet:"
	line "Courage!"

	para "Sie alle hier üben"
	line "Tag und Nacht,"

	para "um Vogel-Meister-"
	line "Trainer zu werden."

	para "Komm schon!"
	done

Bird_keeperRodBeatenText:
	text "Gaaah!"
	done

Bird_keeperAbeSeenText:
	text "Lass mich heraus-"
	line "finden, ob du gut"
	cont "genug bist, um ge-"
	cont "gen Falk anzutre-"
	cont "ten!"
	done

Bird_keeperAbeBeatenText:
	text "Das kann nicht"
	line "wahr sein!"
	done


VioletGymGuyWinText:
	text "Netter Kampf! Mach"
	line "weiter so und bald"

	para "schon wirst du der"
	line "Champ sein!"
	done

VioletGymGuyFalknerAwayText:
	text "Hey! Du kannst"
	line "Falk gerade nicht"
	cont "herausfordern."

	para "Er bändigt in der"
	line "Dunkelhöhle ein"

	para "Ursaring, das"
	line "einen jungen"
	cont "Trainer angriff."

	para "Komm später"
	line "wieder."
	done
