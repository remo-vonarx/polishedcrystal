ShamoutiShrineRuins_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2, 18, NOISY_FOREST, 3
	warp_event  2, 19, NOISY_FOREST, 4

	def_coord_events

	def_bg_events
	bg_event  7, 10, BGEVENT_ITEM + MAX_REVIVE, EVENT_SHAMOUTI_SHRINE_RUINS_HIDDEN_MAX_REVIVE

	def_object_events
	object_event  8, 11, SPRITE_LAWRENCE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ShamoutiShrineRuinsLawrenceScript, EVENT_LAWRENCE_SHAMOUTI_SHRINE_RUINS
	object_event 10, 17, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiShrineRuinsGrampsText, -1
	object_event 14, 13, SPRITE_LADY, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiShrineRuinsLadyText, -1
	itemball_event  4, 27, RARE_CANDY, 1, EVENT_SHAMOUTI_SHRINE_RUINS_RARE_CANDY

	object_const_def
	const SHAMOUTISHRINERUINS_LAWRENCE

ShamoutiShrineRuinsLawrenceScript:
	special Special_FadeOutMusic
	pause 15
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtextfaceplayer .SeenText
	winlosstext .BeatenText, 0
	setlasttalked SHAMOUTISHRINERUINS_LAWRENCE
	loadtrainer LAWRENCE, 1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special DeleteSavedMusic
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	opentext
	writetext .AfterText
	promptbutton
	verbosegivekeyitem SILVER_WING
	writetext .SilverWingText
	waitbutton
	closetext
	readvar VAR_FACING
	ifequalfwd UP, .up
	ifequalfwd DOWN, .down
	ifequalfwd LEFT, .left
.right
	turnobject SHAMOUTISHRINERUINS_LAWRENCE, RIGHT
	sjumpfwd .continue
.up
	turnobject SHAMOUTISHRINERUINS_LAWRENCE, UP
	sjumpfwd .continue
.down
	turnobject SHAMOUTISHRINERUINS_LAWRENCE, DOWN
	sjumpfwd .continue
.left
	turnobject SHAMOUTISHRINERUINS_LAWRENCE, LEFT
.continue
	pause 40
	showtextfaceplayer .GoodbyeText
	playsound SFX_WARP_TO
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear SHAMOUTISHRINERUINS_LAWRENCE
	waitsfx
	special Special_FadeInQuickly
	setevent EVENT_BEAT_LAWRENCE
	playmapmusic
	end

.SeenText:
	text "Lawrence: Ich habe"
	line "in vielen Regionen"

	para "versucht, Arktos,"
	line "Zapdos und Lavados"
	cont "zu fangen."

	para "Ohne das komplette"
	line "Set kann ich den"

	para "Wächter des Meeres"
	line "nicht erwecken…"

	para "Du wirst mir"
	line "helfen, meine"
	cont "Sammlung zu"
	cont "vervollständigen!"
	done

.BeatenText:
	text "Unglaublich."
	line "Du hast meine le-"
	cont "gendäre Sammlung"
	cont "besiegt…"
	done

.AfterText:
	text "Lawrence: Deine"
	line "#mon sind für"

	para "dich nicht bloß"
	line "eine Sammlung,"
	cont "oder?"

	para "Du behandelst sie"
	line "fast wie Freunde."

	para "Hast du so meine"
	line "legendären #mon"
	cont "besiegt?"

	para "Nun, ich denke,"
	line "das hast du dir"
	cont "verdient."
	done

.SilverWingText:
	text "Dieser Silber-"
	line "flügel stammt vom"

	para "Wächter des"
	line "Meeres."

	para "Sein Duft sollte"
	line "ihn anlocken, aber"

	para "nur, wenn du die"
	line "drei sagen-"
	cont "umwobenen Vögel"

	para "gemeistert hast--"
	line "die Vögel von"
	cont "Feuer, Eis und"
	cont "Blitz."

	para "So sagen es"
	line "zumindest die"
	cont "Legenden."
	done

.GoodbyeText:
	text "Mein Traum war es,"
	line "dieses #mon zu"
	cont "besitzen,"

	para "aber du hast dich"
	line "als würdig erwie-"
	cont "sen. Nimm es."

	para "Ich beginne meine"
	line "Sammlung von"
	cont "Neuem."

	para "Leb wohl."
	done

ShamoutiShrineRuinsGrampsText:
	text "Dieser Schrein war"
	line "prächtig, als ich"
	cont "ein Kind war."

	para "Doch leider wurde"
	line "er vor vielen Jah-"
	cont "ren von einem"
	cont "Sturm zerstört."

	para "Der Sturm bedrohte"
	line "die ganze Insel,"
	cont "aber wir wurden"

	para "vom Wächter der"
	line "Meere beschützt."

	para "Jedes Jahr danke"
	line "ich zu Ehren des"
	cont "großen #mon,"
	cont "das uns schützte."
	done

ShamoutiShrineRuinsLadyText:
	text "Ich musste auf"
	line "meiner Weltreise"

	para "einfach auf Sha-"
	line "mouti haltmachen."

	para "Angeblich gibt es"
	line "hier irgendwo ein"
	cont "#mon, das"
	cont "sprechen kann."
	done
