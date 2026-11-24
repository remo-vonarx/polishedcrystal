GoldenrodBillsHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 4
	warp_event  3,  7, GOLDENROD_CITY, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 2, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BillsGrandpa, -1
	object_event  5,  3, SPRITE_MATRON, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BillsMom, -1
	object_event  5,  4, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BillsSister, -1

BillsGrandpa:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue_jumptextfaceplayer BillsGrandpaComeAgainText
	checkevent EVENT_GOT_SHINY_STONE_FROM_BILLS_GRANDPA
	iftrue_jumptextfaceplayer BillsGrandpaShownAllThePokemonText
	faceplayer
	opentext
	checkevent EVENT_MET_BILLS_GRANDPA
	iftruefwd .MetGrandpa
	writetext BillsGrandpaIntroText
	promptbutton
	setevent EVENT_MET_BILLS_GRANDPA
.MetGrandpa:
	checkevent EVENT_SHOWED_TOGEPI_TO_BILLS_GRANDPA
	iftrue .ShowedTogepi
	checkevent EVENT_SHOWED_MURKROW_TO_BILLS_GRANDPA
	iftrue .ShowedMurkrow
	checkevent EVENT_SHOWED_ODDISH_TO_BILLS_GRANDPA
	iftrue .ShowedOddish
	checkevent EVENT_SHOWED_JIGGLYPUFF_TO_BILLS_GRANDPA
	iftrue .ShowedJigglypuff
	checkevent EVENT_SHOWED_PICHU_TO_BILLS_GRANDPA
	iftrue .ShowedPichu
	checkevent EVENT_SHOWED_GROWLITHE_TO_BILLS_GRANDPA
	iftrue .ShowedGrowlithe
	checkevent EVENT_SHOWED_STARYU_TO_BILLS_GRANDPA
	iftrue .ShowedStaryu
	checkevent EVENT_SHOWED_BELLSPROUT_TO_BILLS_GRANDPA
	iftrue .ShowedBellsprout
	checkevent EVENT_SHOWED_SNUBBULL_TO_BILLS_GRANDPA
	iftrue .ShowedSnubbull
	writetext BillsGrandpaSnubbullText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	scall .ExcitedToSee
	special Special_BillsGrandfather
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	ifnotequal SNUBBULL, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_SNUBBULL_TO_BILLS_GRANDPA
	sjumpfwd .ShowedSnubbull

.GotEverstone:
	writetext BillsGrandpaBellsproutText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	scall .ExcitedToSee
	special Special_BillsGrandfather
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	ifnotequal BELLSPROUT, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_BELLSPROUT_TO_BILLS_GRANDPA
	sjumpfwd .ShowedBellsprout

.GotLeafStone:
	writetext BillsGrandpaStaryuText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	scall .ExcitedToSee
	special Special_BillsGrandfather
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	ifnotequal STARYU, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_STARYU_TO_BILLS_GRANDPA
	sjumpfwd .ShowedStaryu

.GotWaterStone:
	writetext BillsGrandpaGrowlitheText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	scall .ExcitedToSee
	special Special_BillsGrandfather
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	ifnotequal GROWLITHE, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_GROWLITHE_TO_BILLS_GRANDPA
	sjumpfwd .ShowedGrowlithe

.GotFireStone:
	writetext BillsGrandpaPichuText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	scall .ExcitedToSee
	special Special_BillsGrandfather
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	ifnotequal PICHU, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_PICHU_TO_BILLS_GRANDPA
	sjumpfwd .ShowedPichu

.GotThunderstone:
	writetext BillsGrandpaJigglypuffText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	scall .ExcitedToSee
	special Special_BillsGrandfather
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	ifnotequal JIGGLYPUFF, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_JIGGLYPUFF_TO_BILLS_GRANDPA
	sjumpfwd .ShowedJigglypuff

.GotMoonStone:
	writetext BillsGrandpaOddishText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	scall .ExcitedToSee
	special Special_BillsGrandfather
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	ifnotequal ODDISH, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_ODDISH_TO_BILLS_GRANDPA
	sjumpfwd .ShowedOddish

.GotSunStone:
	writetext BillsGrandpaMurkrowText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	scall .ExcitedToSee
	special Special_BillsGrandfather
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	ifnotequal MURKROW, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_MURKROW_TO_BILLS_GRANDPA
	sjumpfwd .ShowedMurkrow

.GotDuskStone:
	writetext BillsGrandpaTogepiText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	scall .ExcitedToSee
	special Special_BillsGrandfather
	iffalse_jumpopenedtext BillsGrandpaYouDontHaveItTextText
	ifnotequal TOGEPI, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_TOGEPI_TO_BILLS_GRANDPA
	sjumpfwd .ShowedTogepi

.ShowedSnubbull:
	checkevent EVENT_GOT_EVERSTONE_FROM_BILLS_GRANDPA
	iftrue .GotEverstone
	scall .ReceiveItem
	verbosegiveitem EVERSTONE, iffalse_endtext
	setevent EVENT_GOT_EVERSTONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endtext

.ShowedBellsprout:
	checkevent EVENT_GOT_LEAF_STONE_FROM_BILLS_GRANDPA
	iftrue .GotLeafStone
	scall .ReceiveItem
	verbosegiveitem LEAF_STONE, iffalse_endtext
	setevent EVENT_GOT_LEAF_STONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endtext

.ShowedStaryu:
	checkevent EVENT_GOT_WATER_STONE_FROM_BILLS_GRANDPA
	iftrue .GotWaterStone
	scall .ReceiveItem
	verbosegiveitem WATER_STONE, iffalse_endtext
	setevent EVENT_GOT_WATER_STONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endtext

.ShowedGrowlithe:
	checkevent EVENT_GOT_FIRE_STONE_FROM_BILLS_GRANDPA
	iftrue .GotFireStone
	scall .ReceiveItem
	verbosegiveitem FIRE_STONE, iffalse_endtext
	setevent EVENT_GOT_FIRE_STONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endtext

.ShowedPichu:
	checkevent EVENT_GOT_THUNDERSTONE_FROM_BILLS_GRANDPA
	iftrue .GotThunderstone
	scall .ReceiveItem
	verbosegiveitem THUNDERSTONE, iffalse_endtext
	setevent EVENT_GOT_THUNDERSTONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endtext

.ShowedJigglypuff:
	checkevent EVENT_GOT_MOON_STONE_FROM_BILLS_GRANDPA
	iftrue .GotMoonStone
	scall .ReceiveItem
	verbosegiveitem MOON_STONE, iffalse_endtext
	setevent EVENT_GOT_MOON_STONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endtext

.ShowedOddish:
	checkevent EVENT_GOT_SUN_STONE_FROM_BILLS_GRANDPA
	iftrue .GotSunStone
	scall .ReceiveItem
	verbosegiveitem SUN_STONE, iffalse_endtext
	setevent EVENT_GOT_SUN_STONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endtext

.ShowedMurkrow:
	checkevent EVENT_GOT_DUSK_STONE_FROM_BILLS_GRANDPA
	iftrue .GotDuskStone
	scall .ReceiveItem
	verbosegiveitem DUSK_STONE, iffalse_endtext
	setevent EVENT_GOT_DUSK_STONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endtext

.ShowedTogepi:
	scall .ReceiveItem
	verbosegiveitem SHINY_STONE, iffalse_endtext
	setevent EVENT_GOT_SHINY_STONE_FROM_BILLS_GRANDPA
	endtext

.ExcitedToSee:
	writetext BillsGrandpaExcitedToSeeText
	promptbutton
	end

.CorrectPokemon:
	writetext BillsGrandpaShownPokemonText
	promptbutton
	end

.ReceiveItem:
	writetext BillsGrandpaTokenOfAppreciationText
	promptbutton
	end

.WrongPokemon:
	jumpthisopenedtext

	text "Hm?"

	para "Das ist nicht das"
	line "#mon, von dem"
	cont "ich gehört habe."
	done

BillsMom:
	checkevent EVENT_NEVER_MET_BILL
	iffalse_jumptextfaceplayer BillsMomText_AfterEcruteak
	jumpthistextfaceplayer

	text "Oh, du sammelst"
	line "#mon? Mein Sohn"
	cont "Bill ist ein"
	cont "Experte."

	para "Er wurde gerade in"
	line "das #mon-Center"

	para "von Teak City"
	line "gerufen."

	para "Mein Mann ging in"
	line "die Spielhalle,"

	para "ohne angerufen"
	line "zu werden…"
	done

BillsSister:
	faceplayer
	opentext
	checkcellnum PHONE_BILL
	iftruefwd .GotBillsNumber
	writetext BillsSisterUsefulNumberText
	askforphonenumber PHONE_BILL
	ifequalfwd $1, .NoRoom
	ifequalfwd $2, .Refused
	waitsfx
	addcellnum PHONE_BILL
	writetext RecordedBillsNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	promptbutton
.GotBillsNumber:
	jumpthisopenedtext

	text "Mein großer Bruder"
	line "Bill hat das PC-"
	cont "#mon-Lagerungs-"
	cont "System erfunden."
	done

.NoRoom:
	writetext BillsSisterPhoneFullText
	promptbutton
.Refused:
	jumpthisopenedtext

	text "Mein Bruder hat"
	line "das PC-#mon-"
	cont "Lagerungs-System"
	cont "erfunden."

	para "Ich wollte dir ge-"
	line "rade Bills Nummer"
	cont "geben…"
	done

BillsGrandpaIntroText:
	text "Hm? You know Bill?"
	line "He's my grandson."

	para "He's in Kanto. He"
	line "does something"

	para "with PCs, so I'm"
	line "house-sitting."
	done

BillsGrandpaAskToSeeMonText:
	text "Hast du dieses"
	line "#mon? Darf ich"
	cont "es sehen?"
	done

BillsGrandpaExcitedToSeeText:
	text "Du zeigst es mir?"
	line "Wie lieb von dir!"
	done

BillsGrandpaYouDontHaveItTextText:
	text "Du hast es nicht?"
	line "Das ist schade…"
	done

BillsGrandpaShownPokemonText:
	text "Ah, das ist"
	line ""
	text_ram wStringBuffer3
	text "?"

	para "Ist das nicht"
	line "niedlich!"
	cont "Das ist nett "
	cont "von dir."
	done

BillsGrandpaTokenOfAppreciationText:
	text "Danke!"

	para "Das ist ein"
	line "Zeichen meiner"
	cont "Anerkennung."
	done

BillsGrandpaComeAgainText:
	text "Besuche mich bitte"
	line "wieder."
	done

BillsGrandpaShownAllThePokemonText:
	text "Danke, dass du mir"
	line "so viele niedliche"
	cont "#mon gezeigt"
	cont "hast."

	para "Ich habe mich"
	line "wirklich amüsiert."

	para "Ich bin froh, dass"
	line "ich das noch"
	cont "erleben durfte."
	done

BillsGrandpaSnubbullText:
	text "My grandson Bill"
	line "told me about a"

	para "short, pink canine"
	line "#mon with blue"
	cont "polka dots."
	done

BillsGrandpaTogepiText:
	text "Do you know of a"
	line "#mon that has a"

	para "shell covered in"
	line "red and blue"
	cont "triangles?"

	para "It's supposed to"
	line "be a symbol of"
	cont "good luck."
	done

BillsGrandpaMurkrowText:
	text "Do you know of a"
	line "bird #mon that"

	para "has a crooked"
	line "yellow beak and"
	cont "black feathers?"

	para "I heard that it"
	line "appears at night."

	para "I would quite"
	line "like to see it."
	done

BillsGrandpaOddishText:
	text "Ah, my grandson"
	line "mentioned a round,"

	para "blue #mon that"
	line "has leaves growing"
	cont "on its head."
	done

BillsGrandpaJigglypuffText:
	text "Bill told me about"
	line "a pink #mon"

	para "with a hypnotic"
	line "singing voice."
	done

BillsGrandpaBellsproutText:
	text "My grandson Bill"
	line "mentioned a green"

	para "#mon that walks"
	line "on its roots."
	done

BillsGrandpaStaryuText:
	text "Kennst du ein"
	line "Wasser-#mon"

	para "mit einer roten"
	line "Kugel im Körper?"

	para "Es sieht aus wie"
	line "ein Stern!"

	para "Ich hörte, es"
	line "taucht nachts auf."

	para "Ich würde es"
	line "gerne sehen."
	done

BillsGrandpaGrowlitheText:
	text "Bill erzählte mir"
	line "von einem #mon,"

	para "das seinem Trainer"
	line "gegenüber sehr"
	cont "loyal ist."

	para "Es scheint ein"
	line "guter Brüller zu"
	cont "sein."
	done

BillsGrandpaPichuText:
	text "Kennst du dieses"
	line "sehr beliebte"
	cont "#mon?"

	para "Das #mon, mit"
	line "dem gelben Körper"
	cont "und den roten"
	cont "Wangen."

	para "Ich würde gerne"
	line "sehen, wie es vor"

	para "seiner Entwicklung"
	line "aussieht."
	done


BillsMomText_AfterEcruteak:
	text "My husband was"
	line "once known as a"

	para "#Maniac."
	line "Bill must have"

	para "taken after his"
	line "father."

	para "But now my husband"
	line "won't work. He"

	para "just goofs off"
	line "all day long."
	done

BillsSisterUsefulNumberText:
	text "Bist du ein"
	line "Trainer?"

	para "Ich habe eine"
	line "nützliche Telefon-"
	cont "nummer für dich."
	done

RecordedBillsNumberText:
	text "<PLAYER> speichert"
	line "Bills Nummer."
	done

BillsSisterPhoneFullText:
	text "Du kannst keine"
	line "Nummern mehr spei-"
	cont "chern."
	done
