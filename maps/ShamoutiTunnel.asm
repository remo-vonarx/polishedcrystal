ShamoutiTunnel_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 33,  9, SHAMOUTI_ISLAND, 3
	warp_event  5, 17, WARM_BEACH, 2

	def_coord_events

	def_bg_events
	bg_event 21,  5, BGEVENT_ITEM + NUGGET, EVENT_SHAMOUTI_TUNNEL_HIDDEN_NUGGET
	bg_event 32,  4, BGEVENT_ITEM + LEAF_STONE, EVENT_SHAMOUTI_TUNNEL_HIDDEN_LEAF_STONE

	def_object_events
	object_event 15, 17, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OreManiacScript, -1
	object_event 24, 14, SPRITE_TAMER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerTamerOswald, -1
	object_event 24,  5, SPRITE_FIREBREATHER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerFirebreatherTala, -1
	object_event  6,  7, SPRITE_LADY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSightseerfNoelle, -1
	object_event  3, 16, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSightseermChester, -1
	itemball_event  3,  4, X_SPEED, 1, EVENT_SHAMOUTI_TUNNEL_X_SPEED
	itemball_event 12, 17, SMOOTH_ROCK, 1, EVENT_SHAMOUTI_TUNNEL_SMOOTH_ROCK

OreManiacScript:
	faceplayer
	opentext
	writetext .GreetingText
	promptbutton
	special Special_ChooseItem
	iffalse_jumpopenedtext .NoItemText
	special GetOreManiacPrice
	iffalse_jumpopenedtext .WrongItemText
	special ItemManiac_SelectQuantity
	iffalse_jumpopenedtext .NoItemText
	special MultiplyMoneyByQuantity
	writetext .OfferText
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext .NoItemText
	special TakeItemFromMemWithQuantity
	waitsfx
	playsound SFX_TRANSACTION
	special Give_hMoneyTemp
	special PlaceMoneyTopRight
	jumpthisopenedtext

	text "The deal is done!"
	line "I've scored an ore"
	cont "I can adore!"
	done

.GreetingText:
	text "Ore, ore, ore…"
	line "Ores that I adore!"

	para "I'll pay you well"
	line "for rare ores."

	para "Don't you have an"
	line "adorable ore that"
	cont "shakes my core?"
	done

.OfferText:
	text "That ore, it's"
	line "shaking me!"

	para "Will you sell it"
	line "for ¥"
	text_decimal hMoneyTemp, 3, 7
	text "?"
	done

.WrongItemText:
	text "Huh? What on earth"
	line "is this?"

	para "You can't shake my"
	line "core with an ore"
	cont "so poor!"
	done

.NoItemText:
	text "Hmmm. My core won't"
	line "change."

	para "I hope you sell"
	line "one to me someday."
	done

GenericTrainerTamerOswald:
	generictrainer TAMER, OSWALD, EVENT_BEAT_TAMER_OSWALD, .SeenText, .BeatenText

	text "Jetzt bin ich"
	line "Dompteur, aber als"

	para "ich im Zirkus an-"
	line "fing, war ich in"

	para "der #mon-"
	line "Trapeznummer."
	done

.SeenText:
	text "Ich wurde als"
	line "Zirkusmensch"
	cont "geboren."

	para "Jetzt bin ich auch"
	line "ein harter"
	cont "Kämpfer."
	done

.BeatenText:
	text "Ich konnte deine"
	line "#mon nicht"
	cont "zähmen…"
	done

GenericTrainerFirebreatherTala:
	generictrainer FIREBREATHER, TALA, EVENT_BEAT_FIREBREATHER_TALA, .SeenText, .BeatenText

	text "Meine Feuerspuck-"
	line "Nummer ist bei"

	para "Touristen sehr"
	line "beliebt."

	para "Manche lassen"
	line "sogar Spenden da!"
	done

.SeenText:
	text "Hereinspaziert,"
	line "hereinspaziert,"
	cont "zu meiner spekta-"
	cont "kulären Feuer-"
	cont "spuck-Show!"
	done

.BeatenText:
	text "Schon ausge-"
	line "brannt!"
	done

GenericTrainerSightseerfNoelle:
	generictrainer SIGHTSEERF, NOELLE, EVENT_BEAT_SIGHTSEERF_NOELLE, .SeenText, .BeatenText

	text "Ich mache ein"
	line "Fotoalbum für"
	cont "meine Eltern."

	para "Hey, nicht gucken!"
	line "Das ist privat!"
	done

.SeenText:
	text "Oh mein Gott!"
	line "Du hast #mon,"

	para "die ich noch nie"
	line "gesehen habe!"

	para "Darf ich ein Foto"
	line "machen?"
	done

.BeatenText:
	text "Ooch… Verloren?"
	line "Kein Problem!"

	para "Selfie! ♥"
	line "Klick!"
	done

GenericTrainerSightseermChester:
	generictrainer SIGHTSEERM, CHESTER, EVENT_BEAT_SIGHTSEERM_CHESTER, .SeenText, .BeatenText

	text "Du kommst also aus"
	line "Johto? Da war ich"
	cont "noch nie!"

	para "Vielleicht sehen"
	line "wir uns im"
	cont "Duellturm."
	done

.SeenText:
	text "Ich reise um die"
	line "Welt."

	para "Welche Region soll"
	line "ich als Nächstes"
	cont "besuchen?"
	done

.BeatenText:
	text "Was für eine tol-"
	line "le Erfahrung!"
	done
