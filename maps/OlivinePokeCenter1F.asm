OlivinePokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, OLIVINE_CITY, 1
	warp_event  6,  7, OLIVINE_CITY, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalJasmineScript

	def_object_events
	object_event  8,  1, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, BeautyCharlotteScript, -1
	pc_nurse_event  5, 1
	object_event  2,  6, SPRITE_FISHING_GURU, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumpstd, happinesschecknpc, -1
	object_event  2,  3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivinePokeCenter1FFisherText, -1
	object_event 11,  6, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivinePokeCenter1FTeacherText, -1

	object_const_def
	const OLIVINEPOKECENTER1F_BEAUTY

PokemonJournalJasmineScript:
	setflag ENGINE_READ_JASMINE_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Arenaleiterin"
	cont "Jasmin!"

	para "Gerüchten zufolge"
	line "plaudern Jasmin"
	cont "und Erika, die"

	para "Arenaleiterin von"
	line "Prismania City,"
	cont "gern über Mode."
	done

BeautyCharlotteScript:
	checkevent EVENT_BEAT_BEAUTY_CHARLOTTE
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writetext .GreetingText
	yesorno
	iffalse_jumpopenedtext .NoBattleText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked OLIVINEPOKECENTER1F_BEAUTY
	loadtrainer BEAUTY, CHARLOTTE
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BEAUTY_CHARLOTTE
	jumpthistext

.AfterText:
	text "Wie cool ist es,"
	line "so ein besonderes"
	cont "#mon zu haben?"
	done

.GreetingText:
	text "Oh, bist du ein"
	line "Trainer?"

	para "Du kommst genau"
	line "zur rechten Zeit!"

	para "Mein einzigartiges"
	line "und wunderschönes"
	cont "#mon ist wieder"
	cont "gesund."

	para "Willst du kämpfen"
	line "und über mein"
	cont "#mon staunen?"
	done

.NoBattleText:
	text "Oh, wirklich? Sag"
	line "Bescheid, wenn du"

	para "mal kämpfen"
	line "willst!"
	done

.SeenText:
	text "Also gut!"
	line "Los geht's!"
	done

.BeatenText:
	text "Was für ein toller"
	line "Kampf!"
	done

OlivinePokeCenter1FFisherText:
	text "In Anemonia City"
	line "gibt es einen Typ,"
	cont "der schwach aus-"
	cont "sieht, aber"

	para "er hat meinem"
	line "#mon Stärke"

	para "beigebracht. Jetzt"
	line "kann es Felsen be-"
	cont "wegen."
	done

OlivinePokeCenter1FTeacherText:
	text "Da gibt es jeman-"
	line "den in Anemonia"
	cont "City jenseits des"
	cont "Meeres."

	para "Ich habe gehört,"
	line "wie er mit seinen"
	cont "seltenen #mon"
	cont "angegeben hat."
	done
