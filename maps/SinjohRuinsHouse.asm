SinjohRuinsHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, SINJOH_RUINS, 2
	warp_event  3,  7, SINJOH_RUINS, 2

	def_coord_events

	def_bg_events
	bg_event  1,  1, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event  2,  1, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events
	object_event  5,  4, SPRITE_CYNTHIA, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, SinjohRuinsHouseCynthiaScript, EVENT_SINJOH_RUINS_HOUSE_CYNTHIA
	object_event  5,  3, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SinjohRuinsHousePokefanmText, -1
	object_event  2,  4, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, SinjohRuinsHouseGrampsScript, -1
	pokemon_event  2,  3, ABRA, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_BROWN, SinjohRuinsHouseAbraText, -1

	object_const_def
	const SINJOHRUINSHOUSE_CYNTHIA

SinjohRuinsHouseGrampsScript:
	faceplayer
	opentext
	writetext SinjohRuinsHouseGrampsText
	yesorno
	iffalse_jumpopenedtext SinjohRuinsHouseGrampsNoText
	writetext SinjohRuinsHouseGrampsYesText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp NEW_BARK_TOWN, 15, 6
	end

SinjohRuinsHouseCynthiaScript:
	checkevent EVENT_BEAT_CYNTHIA
	iftrue_jumptextfaceplayer SinjohRuinsHouseCynthiaAfterText
	faceplayer
	opentext
	writetext SinjohRuinsHouseCynthiaChallengeText
	yesorno
	iffalse_jumpopenedtext SinjohRuinsHouseCynthiaNoText
	writetext SinjohRuinsHouseCynthiaYesText
	waitbutton
	closetext
	winlosstext SinjohRuinsHouseCynthiaWinText, 0
	setlasttalked SINJOHRUINSHOUSE_CYNTHIA
	loadtrainer CYNTHIA, 2
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CYNTHIA
	jumpthistext

SinjohRuinsHouseCynthiaAfterText:
	text "Cynthia: Was für"
	line "ein unglaublicher"
	cont "Kampf!"

	para "Du bist ein toller"
	line "Trainer, und es"

	para "würde mich freuen,"
	line "dich mal wieder-"
	cont "zusehen."
	done

SinjohRuinsHousePokefanmText:
	text "Vor langer Zeit"
	line "hatten die Men-"

	para "schen eine engere"
	line "Bindung zu den"
	cont "#mon."

	para "Mythen und Legen-"
	line "den entstanden"
	cont "über mächtige"
	cont "#mon,"

	para "und diese Legenden"
	line "wurden in andere"
	cont "Regionen getragen."

	para "Die Ruinen hier"
	line "wurden von den"

	para "alten Völkern von"
	line "Alph in Johto und"

	para "der Speersäule in"
	line "Sinnoh geprägt."
	done

SinjohRuinsHouseGrampsText:
	text "Du wirkst so fehl"
	line "am Platz und weißt"

	para "nicht mal, warum"
	line "du hier bist."

	para "Soll dich mein"
	line "Abra nach Hause"
	cont "teleportieren?"
	done

SinjohRuinsHouseGrampsYesText:
	text "O.K. Stell"
	line "dir dein Haus"
	cont "vor…"
	done

SinjohRuinsHouseGrampsNoText:
	text "O.K. Alles"
	line "Gute!"
	done

SinjohRuinsHouseAbraText:
	text "Abra: Aabra…"
	done

SinjohRuinsHouseCynthiaChallengeText:
	text "Cynthia: Hallo,"
	line "<PLAYER>."

	para "Ist es dir gut"
	line "ergangen?"

	para "Du hast die Revan-"
	line "che gegen die Top"
	cont "Vier gewonnen!"
	cont "Gut gemacht!"

	para "Ich bin neugierig,"
	line "was du seit"
	cont "unserem letzten"
	cont "Treffen gelernt"
	cont "hast."

	para "Wollen wir noch"
	line "mal kämpfen,"
	cont "<PLAYER>?"
	done

SinjohRuinsHouseCynthiaNoText:
	text "Cynthia: Komm"
	line "jederzeit wieder,"
	cont "wenn du es dir"
	cont "anders überlegst."
	done

SinjohRuinsHouseCynthiaYesText:
	text "Cynthia: Bevor ich"
	line "meine #mon"
	cont "rufe, fängt mein"

	para "Herz immer an zu"
	line "rasen…"
	done

SinjohRuinsHouseCynthiaWinText:
	text "Ich weiß nicht"
	line "mehr, wann ich"

	para "zuletzt so über-"
	line "troffen wurde!"
	done
