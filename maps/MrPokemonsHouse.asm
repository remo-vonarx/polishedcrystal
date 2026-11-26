MrPokemonsHouse_MapScriptHeader:
	def_scene_scripts
	scene_script MrPokemonsHouseMeetMrPokemonScene, SCENE_MRPOKEMONSHOUSE_MEET_MR_POKEMON
	scene_const SCENE_MRPOKEMONSHOUSE_NOOP

	def_callbacks

	def_warp_events
	warp_event  2,  7, ROUTE_30, 2
	warp_event  3,  7, ROUTE_30, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPTEXT, MrPokemonsHouse_ForeignMagazinesText
	bg_event  1,  1, BGEVENT_JUMPTEXT, MrPokemonsHouse_ForeignMagazinesText
	bg_event  6,  1, BGEVENT_JUMPTEXT, MrPokemonsHouse_BrokenComputerText
	bg_event  7,  1, BGEVENT_JUMPTEXT, MrPokemonsHouse_BrokenComputerText
	bg_event  6,  4, BGEVENT_JUMPTEXT, MrPokemonsHouse_StrangeCoinsText
	bg_event  3,  1, BGEVENT_READ, MrPokemonsHouse_CabinetScript

	def_object_events
	object_event  3,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, MrPokemonsHouse_MrPokemonScript, -1
	object_event  6,  5, SPRITE_OAK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MR_POKEMONS_HOUSE_OAK
	object_event  4,  4, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_GOT_POKEDEX_FROM_OAK

	object_const_def
	const MRPOKEMONSHOUSE_GENTLEMAN
	const MRPOKEMONSHOUSE_OAK
	const MRPOKEMONSHOUSE_POKEDEX

MrPokemonsHouseMeetMrPokemonScene:
	sdefer .MrPokemonEvent
	end

.MrPokemonEvent:
	showemote EMOTE_SHOCK, MRPOKEMONSHOUSE_GENTLEMAN, 15
	turnobject MRPOKEMONSHOUSE_GENTLEMAN, DOWN
	showtext MrPokemonIntroText1
	applymovement PLAYER, MrPokemonsHouse_PlayerWalksToMrPokemon
	opentext
	writetext MrPokemonIntroText2
	promptbutton
	waitsfx
	verbosegivekeyitem MYSTERY_EGG
	setevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	blackoutmod CHERRYGROVE_CITY
if !DEF(DEBUG)
	writetext MrPokemonIntroText3
	promptbutton
	turnobject MRPOKEMONSHOUSE_GENTLEMAN, RIGHT
	writetext MrPokemonIntroText4
	promptbutton
	turnobject MRPOKEMONSHOUSE_GENTLEMAN, DOWN
	turnobject MRPOKEMONSHOUSE_OAK, LEFT
	writetext MrPokemonIntroText5
	waitbutton
endc
	closetext
	sjumpfwd MrPokemonsHouse_OakScript

MrPokemonsHouse_MrPokemonScript:
	faceplayer
	opentext
	checkkeyitem RED_SCALE
	iftruefwd .RedScale
	checkitem ODD_SOUVENIR
	iftrue_jumpopenedtext MrPokemonText_OddSouvenir
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue_jumpopenedtext MrPokemonText_AlwaysNewDiscoveries
	jumpopenedtext MrPokemonText_ImDependingOnYou

.RedScale:
	writetext MrPokemonText_GimmeTheScale
	yesorno
	iffalse_jumpopenedtext MrPokemonText_Disappointed
	special SpecialGiveShinyDitto
	iffalse_jumpopenedtext MrPokemonText_PartyAndBoxFull
	writetext MrPokemonText_GotShinyDitto
	playsound SFX_KEY_ITEM
	waitsfx
	ifequalfwd 1, .in_party
	special Special_CurBoxFullCheck
	iffalsefwd .BoxNotFull
	farwritetext _CurBoxFullText
.BoxNotFull
	special GetCurBoxName
	writetext MrPokemonText_SentToPC
	promptbutton
.in_party
	takekeyitem RED_SCALE
	setevent EVENT_TRADED_RED_SCALE
	jumpopenedtext MrPokemonText_AlwaysNewDiscoveries

MrPokemonsHouse_OakScript:
	playmusic MUSIC_PROF_OAK
	applymovement MRPOKEMONSHOUSE_OAK, MrPokemonsHouse_OakWalksToPlayer
	turnobject PLAYER, RIGHT
	showtext MrPokemonsHouse_OakText1
	turnobject MRPOKEMONSHOUSE_OAK, UP
	pause 10
	applymovement MRPOKEMONSHOUSE_POKEDEX, MrPokemonsHouse_OakTakesPokedex
	disappear MRPOKEMONSHOUSE_POKEDEX
	pause 10
	turnobject MRPOKEMONSHOUSE_OAK, LEFT
	pause 10
	opentext
	givespecialitem POKEDEX
	setflag ENGINE_POKEDEX
	writetext MrPokemonsHouse_OakText2
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement MRPOKEMONSHOUSE_OAK, MrPokemonsHouse_OakExits
	playsound SFX_EXIT_BUILDING
	disappear MRPOKEMONSHOUSE_OAK
	waitsfx
	special RestartMapMusic
	pause 15
	turnobject PLAYER, UP
	showtext MrPokemonsHouse_MrPokemonHealText
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	playmusic MUSIC_HEAL
	special HealParty
	pause 60
	special Special_FadeInQuickly
	special RestartMapMusic
	showtext MrPokemonText_ImDependingOnYou
	setevent EVENT_RIVAL_NEW_BARK_TOWN
	setevent EVENT_PLAYERS_HOUSE_1F_NEIGHBOR
	clearevent EVENT_PLAYERS_NEIGHBORS_HOUSE_NEIGHBOR
	setscene SCENE_MRPOKEMONSHOUSE_NOOP
	setmapscene CHERRYGROVE_CITY, SCENE_CHERRYGROVECITY_MEET_RIVAL
	setmapscene ELMS_LAB, SCENE_ELMSLAB_MEET_OFFICER
	specialphonecall SPECIALCALL_ROBBED
	clearevent EVENT_COP_IN_ELMS_LAB
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftruefwd .RivalTakesChikorita
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftruefwd .RivalTakesCyndaquil
	setevent EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	end

.RivalTakesChikorita:
	setevent EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	end

.RivalTakesCyndaquil:
	setevent EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	end

MrPokemonsHouse_CabinetScript:
	opentext
	writetext MrPokemonsHouse_CabinetText
	checkevent EVENT_TRADED_RED_SCALE
	iffalsefwd .NoRedScale
	promptbutton
	writetext MrPokemonsHouse_RedScaleCabinetText
.NoRedScale
	waitbutton
	closetext
	end

MrPokemonsHouse_PlayerWalksToMrPokemon:
	step_right
	step_up
	step_end

MrPokemonsHouse_OakWalksToPlayer:
	step_down
	step_left
	step_left
	step_end

MrPokemonsHouse_OakTakesPokedex:
	fix_facing
	slide_step_down
	remove_fixed_facing
	step_end

MrPokemonsHouse_OakExits:
	step_down
	step_left
	turn_head_down
	step_sleep_2
	step_end

MrPokemonIntroText1:
	text "Hallo! Du musst"
	line "<PLAYER> sein."

	para "Prof. Lind sagte,"
	line "dass du vorbei-"
	cont "kommen würdest."
	done

MrPokemonIntroText2:
	text "Prof. Lind soll"
	line "das hier unter-"
	cont "suchen."
	done

MrPokemonIntroText3:
	text "Ich kenne ein"
	line "Paar, das eine"
	cont "#mon-Pension "
	cont "leitet."

	para "Sie gaben mir"
	line "das Ei."

	para "Ich war derart"
	line "fasziniert, dass"
	cont "ich Prof. Lind ei-"
	cont "ne E-Mail schrieb."

	para "Was die Entwick-"
	line "lung von #mon"
	cont "betrifft, ist"
	cont "Prof. Lind eine"
	cont "Kapazität."
	done

MrPokemonIntroText4:
	text "Sogar Prof. Eich"
	line "schätzt ihn sehr."
	done

MrPokemonIntroText5:
	text "Ich gehe davon"
	line "aus, dass Prof."
	cont "Lind mehr darüber"
	cont "weiß."
	done

MrPokemonsHouse_MrPokemonHealText:
	text "Kehrst du zu Prof."
	line "Lind zurück?"

	para "Dein #mon"
	line "sieht müde aus."
	cont "Du solltest eine"
	cont "kurze Pause"
	cont "einlegen."
	done

MrPokemonText_OddSouvenir:
	text "Oh! Dieses Souve-"
	line "nir!"

	para "So eins habe ich"
	line "auf meiner Reise"
	cont "zum Orange-Archi-"
	cont "pel bekommen."

	para "Dort habe ich auch"
	line "ein paar seltsam"
	cont "geformte #mon"
	cont "gesehen!"

	para "Hmm… Ob wohl…"

	para "Gibt es eine Ver-"
	line "bindung zwischen"

	para "diesem Souvenir"
	line "und diesen unge-"
	cont "wöhnlichen Formen"
	cont "von #mon?"
	done

MrPokemonText_ImDependingOnYou:
	text "Ich bin auf dich"
	line "angewiesen!"
	done

MrPokemonText_AlwaysNewDiscoveries:
	text "Das Leben ist"
	line "schön! Es gibt"

	para "immer etwas Neues"
	line "zu entdecken!"
	done

MrPokemonsHouse_OakText1:
	text "Eich: Aha! Du bist"
	line "also <PLAYER>!"

if !DEF(DEBUG)
	para "Mein Name"
	line "ist Prof. Eich!"
	cont "Ich bin von Beruf"
	cont "#mon-Forscher."

	para "Ich besuche gerade"
	line "meinen alten"
	cont "Freund Mr. #-"
	cont "mon."

	para "Ich hörte, du hast"
	line "etwas für Prof."

	para "Lind besorgt, also"
	line "habe ich gewartet."

	para "Oh! Was ist das?"
	line "Ein seltenes"
	cont "#mon!"

	para "Mal sehen…"

	para "Hm, ich verstehe!"

	para "Ich weiß, warum"
	line "Prof. Lind dir ein"

	para "#mon für die"
	line "Besorgung gab."

	para "Für Forscher wie"
	line "Prof. Lind und"

	para "mich sind #mon"
	line "unsere Freunde."

	para "Er erkannte, dass"
	line "du deine #mon"

	para "liebevoll und"
	line "umsichtig"
	cont "umsorgst."

	para "…Ah!"

	para "Du scheinst zuver-"
	line "lässig zu sein."

	para "Möchtest du mir"
	line "auch helfen?"

	para "Dies ist die"
	line "neueste Version"
	cont "des #dex."

	para "Er erfaßt"
	line "automatisch Daten"

	para "über #mon,"
	line "die man gefangen"
	cont "oder gesehen hat!"

	para "Er ist eine Art"
	line "Hi-Tech-Lexikon!"
endc
	done

MrPokemonsHouse_OakText2:
	text "Triff auf viele"
	line "verschiedene #-"
	cont "mon und vervoll-"

	para "ständige den"
	line "#dex!"

if !DEF(DEBUG)
	para "Ich bin schon zu"
	line "lange hier."

	para "Ich muss nach"
	line "Dukatia City zu"
	cont "meiner Radioshow."

	para "<PLAYER>, ich"
	line "zähle auf dich!"
endc
	done

MrPokemonText_GimmeTheScale:
	text "Hm? Diese Haut!"
	line "Was ist das?"
	cont "Ein rotes"
	cont "Garados?"

	para "Es muss seine"
	line "Farbe schon als"
	cont "Karpador gehabt"
	cont "haben!"

	para "Das ist vielleicht"
	line "einzigartig!"
	cont "Ich muss es haben…"

	para "<PLAYER>, möchtest"
	line "du es tauschen?"

	para "Ich kann dir ein"
	line "seltenes #mon"
	cont "anbieten."
	done

MrPokemonText_GotShinyDitto:
	text "<PLAYER> erhält ein"
	line "#mon."
	done

MrPokemonText_SentToPC:
	text "Das #mon wurde"
	line "auf "
	text_ram wStringBuffer1
	cont "übertragen."
	done

MrPokemonText_PartyAndBoxFull:
	text "Du hast dafür"
	line "keinen Platz,"
	cont "nicht einmal in"
	cont "deiner Box!"
	done

MrPokemonText_Disappointed:
	text "Wirklich schade!"
	line "Das gibt es nur"
	cont "selten."
	done

MrPokemonsHouse_ForeignMagazinesText:
	text "Das sind auslän-"
	line "dische Zeitungen."

	para "Ich kann die"
	line "Schlagzeilen"
	cont "nicht lesen…"
	done

MrPokemonsHouse_BrokenComputerText:
	text "Dies ist ein"
	line "großer Computer."
	cont "Hm, er ist kaputt."
	done

MrPokemonsHouse_StrangeCoinsText:
	text "Ein ganzer Stapel"
	line "seltsamer Münzen!"

	para "Vielleicht sind"
	line "sie aus einem"
	cont "anderen Land…"
	done

MrPokemonsHouse_CabinetText:
	text "Eine Sammlung"
	line "seltener Kurio-"
	cont "sitäten aus aller"
	cont "Welt!"
	done

MrPokemonsHouse_RedScaleCabinetText:
	text "Darunter ist auch"
	line "die schillernde"
	cont "Rote Haut!"
	done
