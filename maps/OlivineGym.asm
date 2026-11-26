OlivineGym_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 15, OLIVINE_CITY, 2
	warp_event  5, 15, OLIVINE_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, OlivineGymStatue
	bg_event  6, 13, BGEVENT_READ, OlivineGymStatue

	def_object_events
	object_event  5,  3, SPRITE_JASMINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineGymJasmineScript, EVENT_OLIVINE_GYM_JASMINE
	object_event  7, 13, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineGymGuyScript, -1
	object_event  3, 10, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_TRAINER, 2, OlivineGymGentlemanPreston, EVENT_OLIVINE_GYM_JASMINE
	object_event  6,  7, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_TRAINER, 2, OlivineGymLassConnie, EVENT_OLIVINE_GYM_JASMINE

OlivineGymJasmineScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_JASMINE
	iftruefwd .FightDone
	writetext Jasmine_SteelTypeIntro
	waitbutton
	closetext
	winlosstext Jasmine_BetterTrainer, 0
	loadtrainer JASMINE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_JASMINE
	opentext
	givebadge MINERALBADGE, JOHTO_REGION
	clearevent EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	setmapscene ROUTE_42, SCENE_ROUTE42_LYRA
.FightDone:
	checkevent EVENT_GOT_TM23_IRON_TAIL
	iftrue_jumpopenedtext Jasmine_GoodLuck
	writetext Jasmine_BadgeSpeech
	promptbutton
	verbosegivetmhm TM_IRON_TAIL
	setevent EVENT_GOT_TM23_IRON_TAIL
	jumpthisopenedtext

	text "…Mit dieser TM"
	line "kannst du deinen"
	cont "#mon Eisen-"
	cont "schweif lehren."
	done

OlivineGymGuyScript:
	checkevent EVENT_BEAT_JASMINE
	iftrue_jumptextfaceplayer OlivineGymGuyWinText
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iffalse_jumptextfaceplayer OlivineGymGuyPreText
	jumpthistextfaceplayer

	text "Jasmin setzt den"
	line "neu entdeckten Typ"
	cont "Stahl ein."

	para "Ich weiß nicht"
	line "viel darüber."
	done

OlivineGymLassConnie:
	trainer 0, 0, EVENT_SPOKE_TO_LASS_CONNIE, .SeenText, 0, 0, .Script

.Script:
	endifjustbattled
	checkevent EVENT_BEAT_JASMINE
	iftrue_jumptextfaceplayer .AfterText
	jumpthistextfaceplayer

.SeenText:
	text "Kicher… Ich weiß"
	line "vom Leuchtturm,"

	para "wie fähig du"
	line "bist."

	para "Jetzt zeig das"
	line "auch Jasmin!"

	para "Viel Glück!"
	done

.AfterText:
	text "Du bist toll…"
	line "Mit so viel"

	para "Potenzial solltest"
	line "du noch höher"
	cont "hinaus."

	para "Warst du schon in"
	line "Mahagonia City?"
	done

OlivineGymGentlemanPreston:
	trainer 0, 0, EVENT_SPOKE_TO_GENTLEMAN_PRESTON, .SeenText, 0, 0, .Script

.Script:
	endifjustbattled
	checkevent EVENT_BEAT_JASMINE
	iftrue_jumptextfaceplayer .AfterText
	jumpthistextfaceplayer

.SeenText:
	text "Ich wusste, dass"
	line "du kommst."

	para "Danke, dass du der"
	line "Arenaleiterin"
	cont "geholfen hast,"

	para "aber ein Kampf ist"
	line "eine andere"
	cont "Sache."

	para "Los geht's!"
	done

.AfterText:
	text "Beeindruckend!"
	line "Mit so viel"

	para "Können solltest du"
	line "noch mehr Orden"
	cont "bekommen."
	done

OlivineGymStatue:
	gettrainername JASMINE, 1, STRING_BUFFER_4
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftruefwd .Returned
	jumpstd gymstatue0
.Returned
	checkflag ENGINE_MINERALBADGE
	iftruefwd .Beaten
	jumpstd gymstatue1
.Beaten
	readvar VAR_BADGES
	ifgreater 13, .LyraToo
	jumpstd gymstatue2
.LyraToo
	jumpstd gymstatue3

Jasmine_SteelTypeIntro:
	text "…Danke für deine"
	line "Hilfe beim Leucht-"
	cont "turm…"

	para "Erlaube mir, mich"
	line "vorstellen zu dür-"
	cont "fen!"

	para "Ich bin Jasmin,"
	line "eine Arenaleite-"
	cont "rin. Ich setze"
	cont "Stahl-#mon ein."

	para "…Hast du von die-"
	line "sem Typ schon ge-"
	cont "hört?"

	para "Diese #mon sind"
	line "sehr hart, kalt,"
	cont "scharf und richtig"
	cont "stark."

	para "…Ähm… Darf ich be-"
	line "ginnen?"
	done

Jasmine_BetterTrainer:
	text "…Du bist ein bes-"
	line "serer Trainer als"

	para "ich. Das betrifft"
	line "sowohl Geschick,"

	para "als auch Fein-"
	line "gefühl."

	para "In Übereinstimmung"
	line "mit den Regeln der"

	para "Liga überreiche"
	line "ich dir diesen"
	cont "Orden."
	done

Jasmine_BadgeSpeech:
	text "Durch diesen Orden"
	line "gehorchen dir alle"

	para "#mon bis <LV>70,"
	line "auch getauschte,"

	para "bedingungslos."

	para "…Ähm… Bitte nimm"
	line "auch das…"
	done

Jasmine_GoodLuck:
	text "Ähm… Ich weiß"
	line "nicht, wie ich das"
	cont "sagen soll, aber…"
	cont "Viel Glück!"
	done

OlivineGymGuyWinText:
	text "Das war großartig!"

	para "Der Typ Stahl,"
	line "was?"

	para "Das war eine un-"
	line "heimliche Begeg-"
	cont "nung der unbe-"
	cont "kannten Art."
	done

OlivineGymGuyPreText:
	text "Jasmin, die Are-"
	line "naleiterin, ist im"
	cont "Leuchtturm."

	para "Sie kümmert sich"
	line "um ein krankes"
	cont "#mon."

	para "Ein starker Trai-"
	line "ner muss auch Mit-"
	cont "gefühl zeigen."
	done
