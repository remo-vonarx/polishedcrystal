CeladonCity_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, CeladonCityFlyPoint
	callback MAPCALLBACK_CMDQUEUE, CeladonCitySetUpPaletteSwap

	def_warp_events
	warp_event  8,  9, CELADON_DEPT_STORE_1F, 1
	warp_event 22,  9, CELADON_MANSION_1F, 1
	warp_event 22,  3, CELADON_MANSION_1F, 3
	warp_event 23,  3, CELADON_MANSION_1F, 3
	warp_event 35,  9, CELADON_POKECENTER_1F, 1
	warp_event 22, 19, CELADON_GAME_CORNER, 1
	warp_event 27, 19, CELADON_GAME_CORNER_PRIZE_ROOM, 1
	warp_event 12, 29, CELADON_GYM, 1
	warp_event 25, 29, CELADON_CAFE, 1
	warp_event 29, 29, CELADON_CHIEF_HOUSE, 1
	warp_event 35, 29, CELADON_HOTEL_1F, 1
	warp_event 14,  9, CELADON_HOME_DECOR_STORE_1F, 1
	warp_event  5, 29, CELADON_UNIVERSITY_1F, 1
	warp_event 31,  9, EUSINES_HOUSE, 1
	warp_event 33, 19, CELADON_OLD_MAN_SPEECH_HOUSE, 1
	warp_event 37, 19, CELADON_DEVELOPMENT_SPEECH_HOUSE, 1
	warp_event  9,  9, CELADON_DEPT_STORE_1F, 2
	warp_event 23, 19, CELADON_GAME_CORNER, 2
	warp_event  6, 29, CELADON_UNIVERSITY_1F, 2
	warp_event 15,  9, CELADON_HOME_DECOR_STORE_1F, 2

	def_coord_events

	def_bg_events
	bg_event 11, 18, BGEVENT_JUMPTEXT, CeladonCitySignText
	bg_event 13, 29, BGEVENT_JUMPTEXT, CeladonGymSignText
	bg_event  3, 31, BGEVENT_JUMPTEXT, CeladonUniversitySignText
	bg_event 10,  9, BGEVENT_JUMPTEXT, CeladonCityDeptStoreSignText
	bg_event 16,  9, BGEVENT_JUMPTEXT, CeladonCityHomeDecorStoreSignText
	bg_event 19,  9, BGEVENT_JUMPTEXT, CeladonCityMansionSignText
	bg_event 21, 21, BGEVENT_JUMPTEXT, CeladonCityGameCornerSignText
	bg_event 27, 21, BGEVENT_JUMPTEXT, CeladonCityPrizeExchangeSignText
	bg_event 23, 29, BGEVENT_JUMPTEXT, CeladonCityCafeSignText
	bg_event 33, 29, BGEVENT_JUMPTEXT, CeladonCityHotelSignText
	bg_event 33, 21, BGEVENT_JUMPTEXT, CeladonCityTrainerTips1Text
	bg_event 21, 15, BGEVENT_JUMPTEXT, CeladonCityTrainerTips2Text
	bg_event 41, 16, BGEVENT_ITEM + PP_UP, EVENT_CELADON_CITY_HIDDEN_PP_UP

	def_object_events
	object_event  4, 15, SPRITE_RICH_BOY, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonCityScript, -1
	object_event 28, 11, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityFisherText, -1
	pokemon_event 29, 11, POLIWRATH, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_BLUE, CeladonCityPoliwrathText, -1
	object_event 24, 24, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityTeacher1Text, -1
	object_event 17, 16, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityGramps1Text, -1
	object_event 10, 32, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, (1 << DAY) | (1 << NITE), PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityGramps2Text, -1
	object_event  9, 31, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, (1 << MORN) | (1 << EVE), PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityPicnickerText, -1
	object_event 22, 13, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityYoungster1Text, -1
	object_event 27, 32, SPRITE_CAMPER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityYoungster2Text, -1
	object_event 12, 13, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityTeacher2Text, -1
	object_event 10, 22, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityLassText_PCC, -1
	object_event 45, 10, SPRITE_BIG_SNORLAX, SPRITEMOVEDATA_SNORLAX, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_7_SNORLAX
	object_event 35, 23, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonCityLassText, -1
	itemball_event 41,  7, MAX_ETHER, 1, EVENT_CELADON_CITY_MAX_ETHER
	cuttree_event 32, 34, EVENT_CELADON_CITY_CUT_TREE_1
	cuttree_event 40, 20, EVENT_CELADON_CITY_CUT_TREE_2

CeladonCityFlyPoint:
	setflag ENGINE_FLYPOINT_CELADON
	endcallback

CeladonCitySetUpPaletteSwap:
	usepaletteswap .PaletteSwap
	endcallback

.PaletteSwap:
	paletteswap 14, 35, 11, 25, PAL_BG_RED, OverworldRedPalettes, GameCornerExteriorPalettes
	paletteswap 26, 255, 1, 15, PAL_BG_WATER, OverworldWaterPalettes, OverworldRedPalettes
	; The unswapped NULL case will keep whichever palette was chosen by the previous case
	paletteswap 28, 45, 21, 33, PAL_BG_WATER, NULL, CeladonHotelRoofPalettes
	db -1 ; end

CeladonCityScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_SWAGGER_INTRO
	iftruefwd CeladonCityTutorSwaggerScript
	writetext CeladonCityRichBoyText
	waitbutton
	setevent EVENT_LISTENED_TO_SWAGGER_INTRO
CeladonCityTutorSwaggerScript:
	writetext Text_CeladonCityTutorSwagger
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writetext Text_CeladonCityTutorQuestion
	yesorno
	iffalsefwd .TutorRefused
	setval SWAGGER
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpthisopenedtext

	text "Dann leb wohl!"
	done

.NoSilverLeaf
	jumpthisopenedtext

	text "…Du hast kein"
	line "Silberblatt?"
	cont "Wie schade."
	done

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext

	text "Siehe da! Dein"
	line "#mon hat Ange-"
	cont "berei erlernt!"
	done

CeladonCityRichBoyText:
	text "Ist mein Anzug"
	line "nicht umwerfend?"

	para "Alle drehen sich"
	line "um, wenn ich die"
	cont "Straße entlang-"
	cont "stolziere!"

	para "Die Leute lieben"
	line "mich!"

	para "Heute bin ich in"
	line "großzügiger"
	cont "Stimmung."
	done

Text_CeladonCityTutorSwagger:
	text "Für nur ein"
	line "Silberblatt lehre"

	para "ich dein #mon"
	line "Angeberei, damit"
	cont "es so angibt wie"
	cont "ich!"
	done


Text_CeladonCityTutorQuestion:
	text "Soll ich deinem"
	line "#mon Angeberei"
	cont "beibringen?"
	done



CeladonCityFisherText:
	text "Dieses Quappo ist"
	line "mein Partner."

	para "Sein Wesen war"
	line "früher Ruhig, aber"

	para "die Verwalterin"
	line "der Villa hier hat"

	para "uns Tee mit einem"
	line "Minzblatt gebraut,"

	para "und jetzt ist es"
	line "eher Froh!"
	done

CeladonCityPoliwrathText:
	text "Quappo: Quaak!"
	done

CeladonCityTeacher1Text:
	text "Ich habe schon"
	line "wieder bei dem"

	para "Spielautomaten"
	line "verloren…"

	para "Wir Mädchen"
	line "spielen auch an"

	para "den Automaten."
	line "Versuche es doch"
	cont "selbst mal."
	done

CeladonCityGramps1Text:
	text "Hier sind vor"
	line "kurzem Sleima"
	cont "aufgetaucht."

	para "Siehst du den"
	line "Teich da vor dem"

	para "Haus? Dort leben"
	line "jetzt Sleima."

	para "Wo kommen sie her?"
	line "Das ist ein"
	cont "echtes Problem…"
	done

CeladonCityGramps2Text:
	text "Hihihi! Diese"
	line "PKMN-Arena ist"

	para "toll! Sie ist nur"
	line "für Mädchen!"
	done

CeladonCityPicnickerText:
	text "Als Trainer der"
	line "Arena haben wir"

	para "die Aufgabe, diese"
	line "Blumen zu pflegen."

	para "Die Uni hier rech-"
	line "net uns das sogar"

	para "als praktische"
	line "Gartenarbeit an."
	done

CeladonCityYoungster1Text:
	text "Soll ich dir ein"
	line "Geheimnis"
	cont "erzählen?"

	para "Prismania-Villa"
	line "hat eine geheime"
	cont "Hintertür."
	done

CeladonCityYoungster2Text:
	text "Im Restaurant wird"
	line "ein Wettessen ab-"
	cont "gehalten."

	para "Dieses Jahr ist"
	line "eine Teilnehmerin"

	para "aus der Sinnoh-"
	line "Region dabei."

	para "Ihr beim Essen"
	line "nur zuzusehen,"
	cont "bringt mich schon"
	cont "zum Platzen…"
	done

CeladonCityTeacher2Text:
	text "Das Einkaufs-"
	line "zentrum in"

	para "Prismania City"
	line "bietet die größte"

	para "und beste Auswahl"
	line "an Artikeln."

	para "Was du da nicht"
	line "findest, wirst"

	para "du nirgends"
	line "finden."

	para "Herrje… Ich klinge"
	line "wie ein Vertreter."
	done

CeladonCityLassText_PCC:
	text "Ich liebe es, von"
	line "hohen Gebäuden"
	cont "umgeben zu sein!"

	para "Stimmt es, dass"
	line "man das #mon-"
	cont "Center in Dukatia"
	cont "vergrößert hat?"

	para "Das ist toll! Ich"
	line "wünschte, wir"

	para "hätten solch einen"
	line "Ort in Kanto…"
	done

CeladonCityLassText:
	text "In der Spielhalle"
	line "gibt es #mon"
	cont "als Preise."

	para "Die armen Dinger…"
	done

CeladonCitySignText:
	text "Prismania City"

	para "Die Stadt der"
	line "Regenbogen-Träume"
	done

CeladonGymSignText:
	text "PKMN-Arena von"
	line "Prismania City"

	para "Leitung: Erika"
	line "Die Prinzessin mit"

	para "Herz für die Natur"
	done

CeladonUniversitySignText:
	text "Prismania-Uni"

	para "“Wachstum durch"
	line "Lernen”"
	done

CeladonCityDeptStoreSignText:
	text "Im Einkaufszentrum"
	line "von Prismania City"
	cont "Findest Du Alles,"
	cont "was Dein Herz"
	cont "Begehrt!"
	done

CeladonCityHomeDecorStoreSignText:
	text "Einkaufszentrum"
	line "Anbau: Wohndeko"
	done

CeladonCityMansionSignText:
	text "Prismania-Villa"
	done

CeladonCityGameCornerSignText:
	text "Der Spielplatz"
	line "Für Jedermann!"

	para "Spielhalle von"
	line "Prismania City"
	done

CeladonCityPrizeExchangeSignText:
	text "Münzen gegen"
	line "Preise tauschen!"
	cont "Preistausch"
	done

CeladonCityCafeSignText:
	text "Restaurant"
	line "Prismania"

	para "Heute den ganzen"
	line "Tag Wettessen!"
	done

CeladonCityHotelSignText:
	text "Prismania-Hotel"

	para "Entspann dich in"
	line "unserem Pool!"
	done

CeladonCityTrainerTips1Text:
	text "Tipps für Trainer"
if DEF(FAITHFUL)

	para "Der Megablock"
else

	para "Der Megablock"
endc
	line "schützt #mon"

	para "davor, dass ihre"
	line "Werte gesenkt"
	cont "werden."

	para "Hol dir deine"
	line "Items im Einkaufs-"
	cont "zentrum von"
	cont "Prismania City!"
	done

CeladonCityTrainerTips2Text:
	text "Tipps für Trainer"

	para "Evoli ist ein"
	line "#mon voller"
	cont "Potenzial."

	para "Bring es an viele"
	line "Orte, zu ver-"
	cont "schiedenen Tages-"
	cont "zeiten und mit"
	cont "Entwicklungs-"
	cont "steinen zusammen!"
	done
