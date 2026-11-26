SoulHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  9, LAVENDER_TOWN, 6
	warp_event  5,  9, LAVENDER_TOWN, 6
	warp_event  4,  2, SOUL_HOUSE_B1F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  7, SPRITE_AGATHA, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, AgathaScript, -1
	object_event  4,  2, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, MrFujiScript, -1 ; TODO: EVENT_SOUL_HOUSE_MR_FUJI
	object_event  7,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, SoulHouseTeacherText, -1
	object_event  2,  7, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, SoulHouseLassText, -1
	object_event  1,  5, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, SoulHouseGrannyText, -1

	object_const_def
	const SOULHOUSE_AGATHA

AgathaScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_AGATHA
	iftruefwd AgathaAfterScript
	writetext AgathaSeenText
	waitbutton
	closetext
	winlosstext AgathaBeatenText, 0
	setlasttalked SOULHOUSE_AGATHA
	loadtrainer AGATHA, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_AGATHA
	opentext
	writetext AgathaRewardText
	promptbutton
	verbosegivetmhm TM_SHADOW_CLAW
	setevent EVENT_GOT_TM65_SHADOW_CLAW_FROM_AGATHA
AgathaAfterScript:
	jumpthisopenedtext

	text "Ich erwarte Großes"
	line "von dir, wenn du"
	cont "es nur willst."
	done

MrFujiScript:
	faceplayer
	opentext
	writetext MrFujiText
	waitbutton
	checkevent EVENT_GOT_SILPHSCOPE2_FROM_MR_FUJI
	iftrue_endtext
	writetext MrFujiGiveSilphScopeText
	waitbutton
	verbosegivekeyitem SILPHSCOPE2
	writetext MrFujiUseThisText
	waitbutton
	setevent EVENT_GOT_SILPHSCOPE2_FROM_MR_FUJI
	endtext

MrFujiText:
	text "Mr. Fuji: Sei"
	line "willkommen."

	para "Hm… Du scheinst"
	line "deine #mon"

	para "mit Sorgfalt und"
	line "Liebe aufzuziehen."

	para "Solche, die #-"
	line "mon verehren,"

	para "zollen hier den"
	line "dahingegangenen"
	cont "#mon ihren"
	cont "Respekt."

	para "Bekunde bitte dein"
	line "Beileid für die"

	para "Seelen der"
	line "dahingegangenen"
	cont "#mon."

	para "Ich bin sicher,"
	line "das macht sie"
	cont "glücklich."
	done

MrFujiGiveSilphScopeText:
	text "Hier, ich habe ein"
	line "Geschenk für dich."

	para "Bitte nimm es."
	done

MrFujiUseThisText:
	text "Damit kannst du"
	line "die Seelen"

	para "ruheloser #mon"
	line "besänftigen."
	done

SoulHouseTeacherText:
	text "Ich glaube, hier"
	line "liegen noch andere"
	cont "#mon begraben."

	para "Es gibt viele"
	line "Kammern, die nur"
	cont "Mr. Fuji betreten"
	cont "darf."
	done

SoulHouseLassText:
	text "Ich besuche mit"
	line "meiner Mutter die"
	cont "Grabmale der"
	cont "#mon…"
	done

SoulHouseGrannyText:
	text "Die #mon, die"
	line "bei mir lebten…"

	para "Ich hatte sie so"
	line "lieb wie meine"
	cont "Enkelkinder…"
	done

AgathaSeenText:
	text "Agathe: Hallo,"
	line "Kind."

	para "Mein Name ist"
	line "Agathe."

	para "Jahrelang kämpfte"
	line "ich als Mitglied"
	cont "der Top Vier."

	para "…………"

	para "Bist du gekommen,"
	line "um ein #mon zu"
	cont "betrauern?"

	para "Es ist vielleicht"
	line "nicht mehr hier."

	para "Mr. Fuji brachte"
	line "viele der Gräber"
	cont "woanders unter,"

	para "als die Radiofirma"
	line "übernahm."

	para "…………"

	para "Er hätte für den"
	line "Erhalt des Turms"
	cont "kämpfen können!"

	para "Aber er wollte"
	line "sich nicht"
	cont "einmischen."

	para "Zu groß war seine"
	line "Angst, seinen Ein-"
	cont "fluss zu miss-"
	cont "brauchen."

	para "Dieser alte Narr…"

	para "Macht ist dazu da,"
	line "genutzt zu werden!"

	para "Du verstehst mich"
	line "offensichtlich."

	para "Ich zeige dir, was"
	line "eine starke"
	cont "Trainerin kann!"
	done

AgathaBeatenText:
	text "Oh, meine Güte!"
	done

AgathaRewardText:
	text "Du bist schon"
	line "etwas Besonderes,"
	cont "Kind."

	para "Ein starker"
	line "Trainer mit einer"

	para "tiefen Bindung zu"
	line "deinen #mon."

	para "Hier, nimm diese"
	line "TM!"
	done
