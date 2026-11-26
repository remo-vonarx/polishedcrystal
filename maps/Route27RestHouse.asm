Route27RestHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, ROUTE_27, 1
	warp_event  3,  7, ROUTE_27, 1

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events
	object_event  2,  4, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route27RestHouseGranny, -1

Route27RestHouseGranny:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_SKILL_SWAP_INTRO
	iftruefwd .HeardIntro
	writetext .IntroText
	setevent EVENT_LISTENED_TO_SKILL_SWAP_INTRO
	sjumpfwd .Continue
.HeardIntro
	writetext .HeardIntroText
.Continue
	promptbutton
	special GetFirstPokemonHappiness
	ifgreater FRIEND_BALL_HAPPINESS - 1, .Loyal
	jumpthisopenedtext

	text "Falls es dir nicht"
	line "mehr Vertrauen"

	para "schenkt, wird es"
	line "schwer für dich."

	para "Vertrauen ist der"
	line "Bund zwischen"
	cont "#mon und den"
	cont "Trainern."
	done

.Loyal:
	writetext .QuestionText
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	yesorno
	iffalsefwd .TutorRefused
	setval SKILL_SWAP
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpopenedtext .RefusedText

.NoSilverLeaf
	waitbutton
	jumpthisopenedtext

	text "Du hast ja noch"
	line "kein einziges"
	cont "Silberblatt"
	cont "gefunden…"
	done

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext

	text "Wertewechsel ist"
	line "eine Attacke, die"

	para "deine Fähigkeit"
	line "mit der deines"
	cont "Gegners tauscht."

	para "Sie ist nur für"
	line "erfahrene Trainer."

	para "Setz sie ein, wenn"
	line "du dich traust."
	cont "Viel Glück!"
	done

.IntroText:
	text "Wohin möchtest du"
	line "mit den #mon?"

	para "Zur #mon Liga?"

	para "Sind deine #mon"
	line "loyal genug, um"
	cont "zu gewinnen?"

	para "Ich werde das"
	line "überprüfen…"
	done

.HeardIntroText:
	text "Lass mich deine"
	line "#mon ansehen…"
	done

.QuestionText:
	text "Ah! Dein #mon"
	line "vertraut dir"
	cont "blind."

	para "Es ist schön, ei-"
	line "nen guten Trainer"
	cont "zu treffen."

	para "Ich kann ihm meine"
	line "Geheimtechnik"

	para "Wertewechsel bei-"
	line "bringen, wenn du"
	cont "möchtest."
	done

.RefusedText:
	text "Viel Glück auf"
	line "deiner Reise."
	done
