DimCave5F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_CMDQUEUE, DimCave5FSetUpStoneTable

	def_warp_events
	warp_event 13, 31, ROUTE_10_NORTH, 5
	warp_event  2, 16, DIM_CAVE_4F, 1
	warp_event 27, 29, DIM_CAVE_4F, 2
	warp_event 28, 25, DIM_CAVE_4F, 3

	def_coord_events

	def_bg_events
	bg_event 12, 28, BGEVENT_ITEM + X_SP_ATK, EVENT_DIM_CAVE_5F_HIDDEN_X_SP_ATK

	def_object_events
	strengthboulder_event 25,  5, EVENT_BOULDER_IN_DIM_CAVE_5F
	object_event 13,  4, SPRITE_RILEY, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, DimCave5FRileyScript, EVENT_DIM_CAVE_RILEY
	object_event 24, 17, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSuper_nerdFoote, -1
	object_event 13, 25, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerEngineerHoward, -1
	object_event 21, 28, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerSuper_nerdDave, -1
	itemball_event 13, 13, RARE_CANDY, 1, EVENT_DIM_CAVE_5F_RARE_CANDY
	itemball_event  9, 27, DUSK_STONE, 1, EVENT_DIM_CAVE_5F_DUSK_STONE
	itemball_event 31, 14, HYPER_POTION, 1, EVENT_DIM_CAVE_5F_HYPER_POTION

	object_const_def
	const DIMCAVE5F_BOULDER
	const DIMCAVE5F_RILEY

DimCave5FSetUpStoneTable:
	usestonetable .StoneTable
	endcallback

.StoneTable:
	stonetable 4, DIMCAVE5F_BOULDER, .Boulder
	db -1 ; end

.Boulder:
	disappear DIMCAVE5F_BOULDER
	clearevent EVENT_BOULDER_FELL_IN_DIM_CAVE_4F
	pause 30
	playsound SFX_STRENGTH
	earthquake 80
	jumpthistext

	text "Der Felsbrocken"
	line "fiel hinunter."
	done

DimCave5FRileyScript:
	faceplayer
	checkevent EVENT_BEAT_RILEY
	iftruefwd .Beaten
	opentext
	writetext .ChallengeText
	yesorno
	iffalse_jumpopenedtext .NoText
	writetext .YesText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked DIMCAVE5F_RILEY
	loadtrainer RILEY, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_RILEY
.Beaten
	opentext
	writetext .ItemText
	promptbutton
	verbosegiveitem POWER_BRACER, iffalse_endtext
	writetext .GoodbyeText
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear DIMCAVE5F_RILEY
	pause 15
	special Special_FadeInQuickly
	clearevent EVENT_BATTLE_TOWER_RILEY
	end

.ChallengeText:
	text "…Und du bist?"

	para "Okay, du bist"
	line "<PLAYER>."

	para "Ich bin Urs. Ich"
	line "bin Trainer, ja."

	para "Ich besitze eine"
	line "Mine wie diese,"
	cont "daher ist das ein"
	cont "guter Trainings-"
	cont "ort für mich."

	para "Wenn du magst,"
	line "könnten wir"
	cont "kämpfen."
	done

.YesText:
	text "Wir ziehen alle"
	line "Register, um"

	para "deine #mon zu"
	line "besiegen."
	done

.NoText:
	text "Oh, na gut. Dann"
	line "trainieren wir"
	cont "hier weiter."
	done

.BeatenText:
	text "Mal kämpfen wir"
	line "gegeneinander, mal"
	cont "tun wir uns"
	cont "zusammen."

	para "Toll, wie Trainer"
	line "miteinander umge-"
	cont "hen können."
	done

.ItemText:
	text "Kenne deinen"
	line "Feind."

	para "Kennst du die"
	line "#mon und"
	cont "Attacken deines"
	cont "Gegners,"

	para "steigen deine"
	line "Siegchancen"
	cont "deutlich."

	para "Aber das eigene"
	line "Team zu stärken,"
	cont "ist auch wichtig."

	para "Das hier hilft"
	line "dir dabei."
	done

.GoodbyeText:
	text "Der Kampf mit dir"
	line "hat mir viel Spaß"
	cont "gemacht."

	para "Ich will mein Kön-"
	line "nen nun im Duell-"
	cont "turm testen."

	para "Bis zum nächsten"
	line "Mal!"

	para "Pass auf dem Weg"
	line "nach draußen auf."
	done

GenericTrainerSuper_nerdFoote:
	generictrainer SUPER_NERD, FOOTE, EVENT_BEAT_SUPER_NERD_FOOTE, .SeenText, .BeatenText

	text "Ein Leben retten"
	line "oder fünf?"

	para "Als Trainer von"
	line "#mon hast du"
	cont "vielleicht die"

	para "Macht, alle sechs"
	line "zu retten!"
	done

.SeenText:
	text "Ich habe eine"
	line "knifflige Frage"
	cont "für dich!"

	para "Würdest du ein"
	line "#mon vor eine"

	para "Lore stoßen, um"
	line "fünf zu retten?"
	done

.BeatenText:
	text "Du hast ohne Worte"
	line "geantwortet…"
	cont "Wie Zen!"
	done

GenericTrainerEngineerHoward:
	generictrainer ENGINEER, HOWARD, EVENT_BEAT_ENGINEER_HOWARD, .SeenText, .BeatenText

	text "Das Wasser fließt"
	line "vom Kap von Azuria"

	para "nach Süden und"
	line "fließt stetig bis"
	cont "zum Kraftwerk."
	done

.SeenText:
	text "Dieser Wasserfall"
	line "liefert Energie"
	cont "für ganz Kanto!"
	done

.BeatenText:
	text "Nein! Ein Strom-"
	line "ausfall…"
	done

GenericTrainerSuper_nerdDave:
	generictrainer SUPER_NERD, DAVE, EVENT_BEAT_SUPER_NERD_DAVE, .SeenText, .BeatenText

	text "Zum Abbauen"
	line "brauchst du eine"
	cont "Spitzhacke."

	para "Aber hier in der"
	line "Gegend gibt es"
	cont "keine."
	done

.SeenText:
	text "Bergbau, Schmuck-"
	line "handwerk,"

	para "Schmelzen und"
	line "Herstellen: alles"
	cont "auf Maximum!"
	done

.BeatenText:
	text "Aber nicht das"
	line "Kämpfen…"
	done
