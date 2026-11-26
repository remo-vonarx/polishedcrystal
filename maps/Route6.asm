Route6_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 21, 11, ROUTE_6_UNDERGROUND_PATH_ENTRANCE, 1
	warp_event 12,  1, ROUTE_6_SAFFRON_GATE, 3

	def_coord_events

	def_bg_events
	bg_event 23, 12, BGEVENT_JUMPTEXT, Route5UndergroundPathSignText
	bg_event  7, 11, BGEVENT_JUMPTEXT, Route6AdvancedTipsSignText

	def_object_events
	object_event 10, 26, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 0, GenericTrainerPokefanmRex, -1
	object_event 11, 26, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 0, GenericTrainerPokefanmAllan, -1
	object_event 14, 19, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerTwinsDayanddani1, -1
	object_event 15, 19, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerTwinsDayanddani2, -1
	object_event 22, 24, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerYoungsterChaz, -1
	object_event  6, 15, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerGuitaristfWanda, -1
	object_event  9,  7, SPRITE_OFFICER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 1, OfficerfJennyScript, -1
	fruittree_event 17,  3, FRUITTREE_ROUTE_6, STARF_BERRY, PAL_NPC_GREEN

GenericTrainerPokefanmRex:
	generictrainer POKEFANM, REX, EVENT_BEAT_POKEFANM_REX, PokefanmRexSeenText, PokefanmRexBeatenText

	text "Sieh, wie grazil"
	line "sich mein Phanpy"
	cont "bewegt!"

	para "Es ist so süß,"
	line "dass dein Herz"
	cont "dahinschmilzt."
	done

PokefanmRexSeenText:
	text "Mein Phanpy ist"
	line "das niedlichste"
	cont "der ganzen Welt."
	done

PokefanmRexBeatenText:
	text "Mein Phanpy!"
	done

GenericTrainerPokefanmAllan:
	generictrainer POKEFANM, ALLAN, EVENT_BEAT_POKEFANM_ALLAN, PokefanmAllanSeenText, PokefanmAllanBeatenText

	text "Sieh, wie grazil"
	line "sich mein"
	cont "Teddiursa bewegt!"

	para "Es ist so süß,"
	line "dass dein Herz"
	cont "dahinschmilzt."
	done

PokefanmAllanSeenText:
	text "Mein Teddiursa ist"
	line "das niedlichste"
	cont "der ganzen Welt."
	done

PokefanmAllanBeatenText:
	text "Mein Teddiursa!"
	done

GenericTrainerTwinsDayanddani1:
	generictrainer TWINS, DAYANDDANI1, EVENT_BEAT_TWINS_DAY_AND_DANI, TwinsDayanddani1SeenText, TwinsDayanddani1BeatenText

	text "Kim: Du hast uns"
	line "besiegt…"
	done

TwinsDayanddani1SeenText:
	text "Kim: Wirst du uns"
	line "besiegen?"
	done

TwinsDayanddani1BeatenText:
	text "Kim: Waah!"
	done

GenericTrainerTwinsDayanddani2:
	generictrainer TWINS, DAYANDDANI2, EVENT_BEAT_TWINS_DAY_AND_DANI, TwinsDayanddani2SeenText, TwinsDayanddani2BeatenText

	text "Kiki: Sieht aus,"
	line "als wären wir"
	cont "rausgeflogen."
	done

TwinsDayanddani2SeenText:
	text "Kiki: Wir hauen"
	line "dich um!"
	done

TwinsDayanddani2BeatenText:
	text "Kiki: Eeeeh!"
	done

GenericTrainerYoungsterChaz:
	generictrainer YOUNGSTER, CHAZ, EVENT_BEAT_YOUNGSTER_CHAZ, .SeenText, .BeatenText

	text "Ich und meine"
	line "große Klappe…"
	done

.SeenText:
	text "Sehe ich da einen"
	line "starken Trainer?"

	para "Nö, hier ist nur"
	line "Müll!"
	done

.BeatenText:
	text "Der Müll war"
	line "ich…"
	done

GenericTrainerGuitaristfWanda:
	generictrainer GUITARISTF, WANDA, EVENT_BEAT_GUITARISTF_WANDA, .SeenText, .BeatenText

	text "Geh einfach"
	line "weiter…"
	done

.SeenText:
	text "Du solltest dich"
	line "lieber verziehen!"
	done

.BeatenText:
	text "Die Schlacht ist"
	line "verloren und"
	cont "nicht gewonnen…"
	done

OfficerfJennyScript:
	checktime 1 << NITE
	iffalse_jumptextfaceplayer .DaytimeText
	checkevent EVENT_BEAT_OFFICERF_JENNY
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	special SaveMusic
	playmusic MUSIC_OFFICER_ENCOUNTER
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer OFFICERF, JENNY
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_OFFICERF_JENNY
	endtext

.DaytimeText:
	text "Us Officers are"
	line "here to keep the"
	cont "peace."
	done

.SeenText:
	text "You don't look"
	line "familiar."

	para "Squirtle Squad,"
	line "attack!"
	done

.BeatenText:
	text "Squirtle Squad,"
	line "retreat…"
	done

.AfterText:
	text "Entschuldige die"
	line "Störung, Kleiner."

	para "Nachts bin ich"
	line "schreckhaft."
	done

Route6AdvancedTipsSignText:
	text "Profi-Tipps!"

	para "Manche Items"
	line "scheinen ihrem"
	cont "Träger zu schaden,"

	para "wie Eisenkugel"
	line "oder Wahlschal."

	para "Doch mit Trick-"
	line "betrug kann der"

	para "Träger sein Item"
	line "mit dem Gegner"
	cont "tauschen!"
	done
