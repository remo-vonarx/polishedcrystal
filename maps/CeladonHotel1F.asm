CeladonHotel1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, CELADON_CITY, 11
	warp_event  4,  7, CELADON_CITY, 11
	warp_event 16,  0, CELADON_HOTEL_2F, 1
	warp_event 12,  0, CELADON_HOTEL_POOL, 1

	def_coord_events

	def_bg_events
	bg_event  7,  2, BGEVENT_JUMPTEXT, CeladonHotel1FSignpost1Text
	bg_event 13,  0, BGEVENT_JUMPTEXT, CeladonHotel1FSignpost2Text
	bg_event 17,  0, BGEVENT_JUMPTEXT, CeladonHotel1FSignpost3Text

	def_object_events
	object_event 11,  6, SPRITE_RICH_BOY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonHotel1FRichBoyGeraldScript, -1
	object_event  3,  1, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHotel1FGrampsText, -1
	object_event  7,  4, SPRITE_LADY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHotel1FLadyText, -1
	object_event 14,  6, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHotel1FCooltrainerFText, -1

	object_const_def
	const CELADONHOTEL1F_RICH_BOY

CeladonHotel1FRichBoyGeraldScript:
	checkevent EVENT_BEAT_RICH_BOY_GERALD
	iftrue_jumptextfaceplayer RichBoyGeraldAfterText
	faceplayer
	opentext
	writetext RichBoyGeraldGreetingText
	yesorno
	iffalse_jumpopenedtext RichBoyGeraldNoBattleText
	writetext RichBoyGeraldSeenText
	waitbutton
	closetext
	winlosstext RichBoyGeraldBeatenText, 0
	setlasttalked CELADONHOTEL1F_RICH_BOY
	loadtrainer RICH_BOY, GERALD
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_RICH_BOY_GERALD
	end

CeladonHotel1FGrampsText:
	text "#mon? Nein, das"
	line "ist ein Hotel für"
	cont "Menschen."

	para "Wir sind aus-"
	line "gebucht."
	done

CeladonHotel1FLadyText:
	text "Ich bin zum ersten"
	line "Mal in Kanto."

	para "In Prismania gibt"
	line "es so viel zu"
	cont "sehen!"
	done

CeladonHotel1FCooltrainerFText:
	text "Ahh, diesen Urlaub"
	line "hatte ich wirklich"
	cont "nötig!"
	done

RichBoyGeraldGreetingText:
	text "Meine Schwester"
	line "genießt den Ur-"
	cont "laub, aber mir"

	para "ist langweilig."
	line "Lust auf einen"
	cont "Kampf?"
	done

RichBoyGeraldSeenText:
	text "Dann mach dich auf"
	line "eine Niederlage"
	cont "gefasst!"
	done

RichBoyGeraldBeatenText:
	text "Immerhin bist du"
	line "nicht langweilig."
	done

RichBoyGeraldAfterText:
	text "Nächstes Mal"
	line "sollten wir in"
	cont "Oliviana City"
	cont "Urlaub machen."

	para "Ich würde gern den"
	line "Duellturm heraus-"
	cont "fordern."
	done

RichBoyGeraldNoBattleText:
	text "Hmpf! Na gut."
	done

CeladonHotel1FSignpost1Text:
	text "Prismania-Hotel"

	para "Einen schönen"
	line "Aufenthalt!"
	done

CeladonHotel1FSignpost2Text:
	text "Hotelpool"

	para "Bitte im Wasser"
	line "eine Badekappe"
	cont "tragen."
	done

CeladonHotel1FSignpost3Text:
	text "Suiten"
	line "im Obergeschoss"
	done
