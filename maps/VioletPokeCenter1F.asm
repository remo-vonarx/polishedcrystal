VioletPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, VIOLET_CITY, 5
	warp_event  6,  7, VIOLET_CITY, 5
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalFalknerScript

	def_object_events
	object_event 10,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, VioletPokeCenter1FElmsAideScript, EVENT_ELMS_AIDE_IN_VIOLET_POKEMON_CENTER
	pc_nurse_event  5, 1
	object_event  9,  4, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletPokeCenter1FGameboyKidText, -1
	object_event  2,  3	, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletPokeCenter1FGentlemanText, -1
	object_event  0,  5, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletPokeCenter1FSageText, -1
	object_event 11,  5, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletPokeCenter1FYoungsterText, -1

	object_const_def
	const VIOLETPOKECENTER1F_SCIENTIST

PokemonJournalFalknerScript:
	setflag ENGINE_READ_FALKNER_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Arenaleiter Falk!"

	para "Man sagt, Falk"
	line "verehrt seinen"
	cont "Vater, der vor ihm"

	para "die Arena von"
	line "Viola City führte."
	done

VioletPokeCenter1FElmsAideScript:
	faceplayer
	opentext
	checkevent EVENT_REFUSED_TO_TAKE_EGG_FROM_ELMS_AIDE
	iftruefwd .SecondTimeAsking
	writetext .IntroText
	sjumpfwd .AskTakeEgg
.SecondTimeAsking:
	writetext .QuestionText
.AskTakeEgg:
	yesorno
	iffalsefwd .RefusedEgg
	giveegg TOGEPI
	iffalse_jumpopenedtext .PartyAndBoxFull
	setevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	clearevent EVENT_ELMS_AIDE_IN_LAB
	clearevent EVENT_TOGEPI_HATCHED
	setmapscene ROUTE_32, SCENE_ROUTE32_LYRA_GROTTOES
	writetext .GoodbyeText
	waitbutton
	closetext
	readvar VAR_FACING
	ifequalfwd UP, .AideWalksAroundPlayer
	turnobject PLAYER, DOWN
	applymovement VIOLETPOKECENTER1F_SCIENTIST, .WalkStraightMovement
	sjumpfwd .Finish
.AideWalksAroundPlayer:
	applymovement VIOLETPOKECENTER1F_SCIENTIST, .WalkAroundMovement
	turnobject PLAYER, DOWN
	applymovement VIOLETPOKECENTER1F_SCIENTIST, .WalkDownMovement
.Finish:
	playsound SFX_EXIT_BUILDING
	disappear VIOLETPOKECENTER1F_SCIENTIST
	waitsfx
	end

.PartyAndBoxFull:
	text "Oh, du hast keinen"
	line "Platz mehr für ein"
	cont "weiteres #mon."

	para "Auch in deiner Box"
	line "ist kein Platz."

	para "Ich warte hier,"
	line "bis du Platz für"
	cont "das Ei geschaffen"
	cont "hast."
	done

.RefusedEgg:
	setevent EVENT_REFUSED_TO_TAKE_EGG_FROM_ELMS_AIDE
	jumpthisopenedtext

	text "A-Aber… Prof."
	line "Lind hat nach dir"
	cont "gefragt…"
	done

.IntroText:
	text "<PLAYER>, lange"
	line "nicht gesehen."

	para "Beim Warten habe"
	line "ich im #mon"
	cont "Journal gestöbert."

	para "Der Klatsch darin"
	line "ist ein guter"
	cont "Zeitvertreib…"

	para "Jedenfalls hat"
	line "Prof. Lind noch"
	cont "eine Bitte an"
	cont "dich."

	para "Nimm bitte das"
	line "#mon-Ei!"
	done

.QuestionText:
	text "<PLAYER>, nimmst du"
	line "das Ei?"
	done

.GoodbyeText:
	text "Wir haben ent-"
	line "deckt, dass ein"

	para "#mon erst"
	line "schlüpft, nachdem"

	para "es im Ei gewachsen"
	line "ist."

	para "Außerdem muss es"
	line "sich in der Nähe"

	para "anderer #mon"
	line "befinden, um zu"
	cont "schlüpfen."

	para "<PLAYER>, du bist"
	line "die einzige Per-"
	cont "son, auf die wir"

	para "uns verlassen"
	line "können."

	para "Bitte ruf Prof."
	line "Lind an, wenn das"
	cont "Ei so weit ist!"
	done

.WalkAroundMovement:
	step_left
	step_left
	step_down
	step_left
	step_left
	step_end

.WalkStraightMovement:
	step_down
	step_left
	step_left
	step_left
	step_left
.WalkDownMovement:
	step_down
	step_down
	step_down
	step_down
	step_end

VioletPokeCenter1FGameboyKidText:
	text "Ein Kerl namens"
	line "Bill hat das"
	para "#mon-PC-Lage-"
	line "rungs-System"
	para "erfunden."
	done

VioletPokeCenter1FGentlemanText:
	text "Es war vor etwa"
	line "drei Jahren."

	para "Team Rocket hatte"
	line "etwas Übles mit"
	cont "den #mon vor."

	para "Aber die Gerech-"
	line "tigkeit hat ge-"
	cont "siegt! Ein junger"
	cont "Trainer hat sie"
	cont "zerschlagen."
	done

VioletPokeCenter1FSageText:
	text "Manche Knofensa"
	line "tragen Gold-"
	cont "blätter."

	para "Und manche Myrapla"
	line "tragen Silber-"
	cont "blätter."

	para "Gewisse Leute"
	line "schätzen sie sehr."
	done

VioletPokeCenter1FYoungsterText:
	text "#mon sind"
	line "schlau. Sie gehor-"
	cont "chen nur Trainern,"
	cont "vor denen sie auch"
	cont "Respekt haben."

	para "Hat der Trainer"
	line "nicht genug Orden,"

	para "machen sie, was"
	line "sie wollen."
	done
