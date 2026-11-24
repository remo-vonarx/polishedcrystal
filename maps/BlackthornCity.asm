BlackthornCity_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, BlackthornCityFlypointCallback
	callback MAPCALLBACK_OBJECTS, BlackthornCitySantosCallback

	def_warp_events
	warp_event 18, 11, BLACKTHORN_GYM_1F, 1
	warp_event 13, 21, BLACKTHORN_DRAGON_SPEECH_HOUSE, 1
	warp_event 29, 23, BLACKTHORN_EMYS_HOUSE, 1
	warp_event 15, 29, BLACKTHORN_MART, 2
	warp_event 21, 29, BLACKTHORN_POKECENTER_1F, 1
	warp_event  9, 29, MOVE_DELETERS_HOUSE, 1
	warp_event 36,  9, ICE_PATH_1F, 2
	warp_event 20,  1, DRAGONS_DEN_1F, 1

	def_coord_events

	def_bg_events
	bg_event 34, 24, BGEVENT_JUMPTEXT, BlackthornCitySignText
	bg_event 19, 11, BGEVENT_JUMPTEXT, BlackthornGymSignText
	bg_event  7, 29, BGEVENT_JUMPTEXT, MoveDeletersHouseSignText
	bg_event 21,  3, BGEVENT_JUMPTEXT, DragonDensSignText
	bg_event  9, 19, BGEVENT_JUMPTEXT, BlackthornCityTrainerTipsText

	def_object_events
	object_event 22, 20, SPRITE_PSYCHIC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, SantosScript, EVENT_BLACKTHORN_CITY_SANTOS_OF_SATURDAY
	object_event 18, 12, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornDragonTamer1Script, EVENT_BLACKTHORN_CITY_DRAGON_TAMER_BLOCKS_GYM
	object_event 19, 12, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornDragonTamer1Script, EVENT_BLACKTHORN_CITY_DRAGON_TAMER_DOES_NOT_BLOCK_GYM
	object_event 24, 31, SPRITE_BLACK_BELT, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornBlackbeltScript, -1
	object_event 20,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BlackthornGramps1Text, EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN
	object_event 21,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BlackthornGramps2Text, EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	object_event  9, 25, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, BlackthornLassText, -1
	object_event 13, 15, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BlackthornYoungsterText, -1
	object_event 35, 19, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, BlackthornCooltrainerF1Text, -1
	object_event  3, 29, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, BlackthornCooltrainerF2Text, -1
	object_event 31, 26, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, (1 << MORN) | (1 << DAY), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BlackthornDragonTamer2Text, -1
	object_event 27, 25, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BlackthornDragonTamer3Text, -1

	object_const_def
	const BLACKTHORNCITY_SANTOS

BlackthornCityFlypointCallback:
	setflag ENGINE_FLYPOINT_BLACKTHORN
	endcallback

BlackthornCitySantosCallback:
	readvar VAR_WEEKDAY
	ifequalfwd SATURDAY, .SantosAppears
	disappear BLACKTHORNCITY_SANTOS
	endcallback

.SantosAppears:
	appear BLACKTHORNCITY_SANTOS
	endcallback

BlackthornCitySignText:
	text "Ebenholz City"

	para "Ein ruhiger Ort in"
	line "den Bergen"
	done

BlackthornGymSignText:
	text "PKMN-Arena von"
	line "Ebenholz City"

	para "Leitung: Sandra"
	line "Die gesegnete Dra-"
	cont "chen-#mon-"
	cont "Trainerin"
	done

MoveDeletersHouseSignText:
	text "Haus des Attacken-"
	line "Verlerners"
	done

DragonDensSignText:
	text "Drachenhöhle"
	line "Geradeaus"
	done

BlackthornCityTrainerTipsText:
	text "Tipps für Trainer"

	para "Ein #mon, das"
	line "eine Prunusbeere"

	para "trägt, kann von"
	line "sich aus Status-"
	cont "veränderungen hei-"
	cont "len."
	done

SantosScript:
	checkevent EVENT_GOT_SPELL_TAG_FROM_SANTOS
	iftrue_jumptextfaceplayer .SaturdayText
	readvar VAR_WEEKDAY
	ifnotequal SATURDAY, .NotSaturday
	faceplayer
	opentext
	checkevent EVENT_MET_SANTOS_OF_SATURDAY
	iftruefwd .MetSantos
	writetext .MeetText
	promptbutton
	setevent EVENT_MET_SANTOS_OF_SATURDAY
.MetSantos:
	writetext .GivesGiftText
	promptbutton
	verbosegiveitem SPELL_TAG, iffalse_endtext
	setevent EVENT_GOT_SPELL_TAG_FROM_SANTOS
	jumpthisopenedtext

	text "Samson: …"

	para "Bannsticker…"

	para "Geist-Attacken"
	line "werden stärker…"

	para "Es ist geradezu"
	line "beängstigend…"
	done

.NotSaturday:
	jumpthistextfaceplayer

	text "Samson: Heute ist"
	line "nicht Samstag…"
	done

.MeetText:
	text "Samson: …"

	para "Heute ist Samstag…"

	para "Ich bin Samson von"
	line "Samstag…"
	done

.GivesGiftText:
	text "Du kannst das"
	line "haben…"
	done

.SaturdayText:
	text "Samson: …"

	para "Wir sehen uns an"
	line "einem anderen"
	cont "Samstag wieder…"

	para "Aber ich werde"
	line "dann keine Ge-"
	cont "schenke mehr"
	cont "haben…"
	done

BlackthornDragonTamer1Script:
	checkevent EVENT_BEAT_CLAIR
	iftrue_jumptextfaceplayer .ClairIsBeatenText
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue_jumptextfaceplayer .ClairIsInText
	jumpthistextfaceplayer

	text "Tut mir Leid."

	para "Sandra, unsere"
	line "Arenaleiterin,"

	para "ist in die"
	line "Drachenhöhle"

	para "hinter der PKMN-"
	line "Arena gegangen."

	para "Ich weiß nicht,"
	line "wann sie wieder-"
	cont "kommt."
	done

.ClairIsInText:
	text "Sandra, unsere"
	line "Arenaleiterin,"
	cont "erwartet dich."

	para "Für einen gewöhn-"
	line "lichen Trainer"

	para "ist es jedoch un-"
	line "möglich zu siegen."
	done

.ClairIsBeatenText:
	text "You defeated"
	line "Clair?"

	para "That's amazing!"

	para "I've never heard"
	line "of her losing to"

	para "anyone other than"
	line "her cousin Lance."
	done

BlackthornBlackbeltScript:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue_jumptextfaceplayer .Text2
	jumpthistextfaceplayer

	text "Mein Radio ist im"
	line "Eimer. Seit kurzem"
	cont "empfange ich nur"
	cont "dieses eigenartige"
	cont "Signal."
	done

.Text2:
	text "Aruuu! Stimmen in"
	line "meinem Kopf!"

	para "Häh? Ich höre"
	line "Radio!"
	done

BlackthornGramps1Text:
	text "Nein. Nur auser-"
	line "wählte Trainer"

	para "dürfen hier"
	line "trainieren."
	cont "Gehe hinfort."
	done

BlackthornGramps2Text:
	text "Wenn Sandra es dir"
	line "gestattet, dann"

	para "wird auch ihr Opa"
	line "- unser Meister -"
	cont "zustimmen."

	para "Tritt ein."
	done

BlackthornLassText:
	text "Willst du, dass"
	line "deine #mon ei-"
	cont "nige Attacken ver-"
	cont "gessen?"
	done

BlackthornYoungsterText:
	text "Alle Drachen-"
	line "meister kommen aus"
	cont "Ebenholz City."
	done

BlackthornCooltrainerF1Text:
	text "Wow, du bist über"
	line "den Eispfad gekom-"
	cont "men?"

	para "Du musst ein rich-"
	line "tiger Heißsporn"
	cont "sein!"
	done

BlackthornCooltrainerF2Text:
	text "The Fairy type was"
	line "discovered only"
	cont "recently."

	para "It totally shuts"
	line "down Dragon types."
	done

BlackthornDragonTamer2Text:
	text "When our Gym Lead-"
	line "er was a young"

	para "girl, she used to"
	line "train in the"

	para "Dragon's Den non-"
	line "stop."
	done

BlackthornDragonTamer3Text:
	text "Blackthorn City is"
	line "the home of many"

	para "famous dragon"
	line "tamers, including"
	cont "Lance."

	para "He's our Gym Lead-"
	line "er's cousin, you"
	cont "know!"
	done
