MurkySwamp_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7, 35, STORMY_BEACH, 1
	warp_event  8, 35, STORMY_BEACH, 2
	warp_event 36,  5, UNION_CAVE_B1F_SOUTH, 3

	def_coord_events

	def_bg_events
	bg_event 20, 10, BGEVENT_ITEM + MULCH, EVENT_MURKY_SWAMP_HIDDEN_MULCH
	bg_event  2, 30, BGEVENT_ITEM + X_SP_DEF, EVENT_MURKY_SWAMP_HIDDEN_X_SP_DEF
	bg_event  5, 23, BGEVENT_ITEM + BIG_MUSHROOM, EVENT_MURKY_SWAMP_HIDDEN_BIG_MUSHROOM
	bg_event 40, 33, BGEVENT_ITEM + TINYMUSHROOM, EVENT_MURKY_SWAMP_HIDDEN_TINYMUSHROOM

	def_object_events
	object_event  6,  2, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, URSALUNA, -1, PAL_MON_RED, OBJECTTYPE_SCRIPT, URSALUNA_BLOODMOON_FORM, MurkySwampBloodmoonUrsaluna, EVENT_MURKY_SWAMP_BLOODMOON_URSALUNA
	object_event 40, 26, SPRITE_CHERYL, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, MurkySwampCherylScript, EVENT_MURKY_SWAMP_CHERYL
	object_event 17, 31, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, MurkySwampNurseBeatriceScript, -1
	object_event 22, 20, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBug_catcherOscar, -1
	object_event 25, 33, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerLassAbigail, -1
	object_event  8, 13, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerPokemaniacEnzo, -1
	object_event 37, 17, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerHex_maniacMatilda, -1
	object_event  6, 22, SPRITE_FIREBREATHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerFirebreatherOleg, -1
	object_event  4, 33, SPRITE_POKEMANIAC, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MurkySwampPokemaniacText, -1
	itemball_event 22, 13, FULL_HEAL, 1, EVENT_MURKY_SWAMP_FULL_HEAL
	itemball_event 14,  9, BIG_MUSHROOM, 1, EVENT_MURKY_SWAMP_BIG_MUSHROOM
	itemball_event 43, 23, TOXIC_ORB, 1, EVENT_MURKY_SWAMP_TOXIC_ORB
	itemball_event 14, 34, MULCH, 1, EVENT_MURKY_SWAMP_MULCH
	cuttree_event  2, 14, EVENT_MURKY_SWAMP_CUT_TREE_1
	cuttree_event  6, 19, EVENT_MURKY_SWAMP_CUT_TREE_2

	object_const_def
	const MURKYSWAMP_BLOODMOON_URSALUNA
	const MURKYSWAMP_CHERYL
	const MURKYSWAMP_NURSE

MurkySwampCherylScript:
	faceplayer
	checkevent EVENT_BEAT_CHERYL
	iftruefwd .Beaten
	opentext
	writetext .ChallengeText
	yesorno
	iffalse_jumpopenedtext .NoText
	writetext .YesText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked MURKYSWAMP_CHERYL
	loadtrainer CHERYL, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CHERYL
.Beaten
	opentext
	writetext .ItemText
	promptbutton
	verbosegiveitem POWER_WEIGHT, iffalse_endtext
	writetext .GoodbyeText
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear MURKYSWAMP_CHERYL
	pause 15
	special Special_FadeInQuickly
	clearevent EVENT_BATTLE_TOWER_CHERYL
	end

.ChallengeText:
	text "Hallo, ich heiße"
	line "Raissa."
	cont "Und du bist…?"

	para "Okay, du heißt"
	line "also <PLAYER>."

	para "Ich freue mich"
	line "aufrichtig, dich"
	cont "kennenzulernen."

	para "Ich fürchte mich"
	line "vor den Geistern"
	cont "in diesem Sumpf."

	para "Wie wär's mit"
	line "einem Kampf, um"
	cont "sie zu vertreiben?"
	done

.YesText:
	text "Ich warne dich,"
	line "meine #mon"
	cont "können ziemlich"
	cont "wild sein."
	done

.NoText:
	text "Oh, aber meine"
	line "#mon brannten"
	cont "auf einen Kampf…"
	done

.BeatenText:
	text "Die richtige"
	line "Balance zwischen"
	cont "Angriff und"
	cont "Verteidigung…"

	para "Das ist gar nicht"
	line "so einfach."
	done

.ItemText:
	text "Danke,"
	line "<PLAYER>!"

	para "Jetzt komme ich"
	line "zuversichtlich"
	cont "durch den Sumpf."

	para "Er erinnert mich"
	line "an einen fernen"
	cont "Wald…"

	para "Oh, das ist ein"
	line "kleines Danke-"
	cont "schön von mir."

	para "Bitte nimm es an!"
	done

.GoodbyeText:
	text "Ich gehe zum"
	line "Duellturm bei"
	cont "Oliviana City."

	para "Hast du schon"
	line "davon gehört?"

	para "Vielleicht sehen"
	line "wir uns dort!"

	para "Bis bald!"
	done

MurkySwampNurseBeatriceScript:
	faceplayer
	checkevent EVENT_BEAT_NURSE_BEATRICE
	iftruefwd .Beaten
	showtext .SeenText
	winlosstext .BeatenText, 0
	setlasttalked MURKYSWAMP_NURSE
	loadtrainer NURSE, BEATRICE
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_NURSE_BEATRICE
.Beaten
	showtext .AfterText
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	playmusic MUSIC_HEAL
	special HealParty
	pause 60
	special Special_FadeInQuickly
	special RestartMapMusic
	jumpthistext

	text "Alles wieder gut!"
	done

.SeenText:
	text "Ich bin Pflegerin!"

	line "Besiege mich und"
	cont "ich heile deine"
	cont "#mon!"
	done

.BeatenText:
	text "Aber zuerst muss"
	line "ich meine eigenen"
	cont "#mon heilen…"
	done

.AfterText:
	text "Damit es #mon"
	line "besser geht…"

	para "darum bin ich"
	line "hergekommen!"
	done

MurkySwampBloodmoonUrsaluna:
	faceplayer
	opentext
	writetext BloodmoonUrsalunaText
	cry URSALUNA
	pause 15
	closetext
	loadwildmon URSALUNA, URSALUNA_BLOODMOON_FORM, 60
	checkevent EVENT_BEAT_ELITE_FOUR
	iftruefwd .GotLevel
	loadwildmon URSALUNA, URSALUNA_BLOODMOON_FORM, 30
.GotLevel
	loadvar VAR_BATTLETYPE, BATTLETYPE_NEVER_SHINY
	startbattle
	disappear MURKYSWAMP_BLOODMOON_URSALUNA
	setevent EVENT_MURKY_SWAMP_BLOODMOON_URSALUNA
	reloadmapafterbattle
	special CheckBattleCaughtResult
	iffalsefwd .end
	setflag ENGINE_PLAYER_CAUGHT_BLOODMOON_URSALUNA
.end
	end

BloodmoonUrsalunaText:
	text "Wa-gaaah!"
	done

GenericTrainerBug_catcherOscar:
	generictrainer BUG_CATCHER, OSCAR, EVENT_BEAT_BUG_CATCHER_OSCAR, .SeenText, .BeatenText

	text "Ich kam her, um"
	line "Käfer zu finden!"

	para "Niemand hat mich"
	line "vor Geistern"
	cont "gewarnt!"
	done

.SeenText:
	text "G-g-g-Geist!"
	done

.BeatenText:
	text "Ich muss hier"
	line "weg!"
	done

GenericTrainerHex_maniacMatilda:
	generictrainer HEX_MANIAC, MATILDA, EVENT_BEAT_HEX_MANIAC_MATILDA, .SeenText, .BeatenText

	text "So geh ich in den"
	line "Wald hinein,"

	para "verlier den Ver-"
	line "stand und find"
	cont "mein Sein."
	done

.SeenText:
	text "In Finsternis, so"
	line "tief und weit,"
	cont "schenk ich dir"
	cont "Schlaf für alle"
	cont "Zeit."
	done

.BeatenText:
	text "Fufufufu…"
	done

GenericTrainerFirebreatherOleg:
	generictrainer FIREBREATHER, OLEG, EVENT_BEAT_FIREBREATHER_OLEG, .SeenText, .BeatenText

	text "Ohne Feuer ist es"
	line "kalt und dunkel…"
	done

.SeenText:
	text "Ich will ein Feuer"
	line "machen… Aber würde"

	para "das Sumpfgas sich"
	line "entzünden und"
	cont "explodieren?"

	para "Das ist zu"
	line "riskant!"
	done

.BeatenText:
	text "Ich habe es"
	line "riskiert und"
	cont "verloren!"
	done

GenericTrainerLassAbigail:
	generictrainer LASS, ABIGAIL, EVENT_BEAT_LASS_ABIGAIL, .SeenText, .BeatenText

	text "Man munkelt, dass"
	line "man eine seltsame"
	cont "rote Kugel sieht,"

	para "die wie ein Blut-"
	line "mond leuchtet."

	para "Das klingt"
	line "unheimlich."
	done

.SeenText:
	text "Die Leute haben"
	line "Angst, tief in den"
	cont "Sumpf zu gehen."
	done

.BeatenText:
	text "Iiek!"
	done

GenericTrainerPokemaniacEnzo:
	generictrainer POKEMANIAC, ENZO, EVENT_BEAT_POKEMANIAC_ENZO, .SeenText, .BeatenText

	text "Ich glaube nicht,"
	line "dass Nebulak so"

	para "ein rotes Licht"
	line "machen kann, wie"
	cont "ich es sah."

	para "Was könnte das"
	line "sein?"
	done

.SeenText
	text "Ich sah ein selt-"
	line "sames rotes Licht"

	para "zwischen den Bäu-"
	line "men, als ich nach"
	cont "seltenen #mon"
	cont "suchte!"
	done

.BeatenText
	text "Du musst keine"
	line "Angst haben."
	done

MurkySwampPokemaniacText:
	text "So nah an der"
	line "Küste ist der"

	para "Boden mit Wasser"
	line "vollgesogen."

	para "Aber wegen der"
	line "seltenen #mon"

	para "lohnt sich das"
	line "Erkunden trotzdem!"
	done
