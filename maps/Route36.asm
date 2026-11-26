Route36_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_ROUTE36_NOOP
	scene_const SCENE_ROUTE36_SUICUNE

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route36ArthurCallback

	def_warp_events
	warp_event  4,  8, ROUTE_36_NATIONAL_PARK_GATE, 3
	warp_event  4,  9, ROUTE_36_NATIONAL_PARK_GATE, 4
	warp_event 33, 13, ROUTE_36_RUINS_OF_ALPH_GATE, 1
	warp_event 34, 13, ROUTE_36_RUINS_OF_ALPH_GATE, 2
	warp_event 41,  8, ROUTE_36_VIOLET_GATE, 1
	warp_event 41,  9, ROUTE_36_VIOLET_GATE, 2
	warp_event 12, 12, HIDDEN_TREE_GROTTO, 1

	def_coord_events
	coord_event  6,  7, SCENE_ROUTE36_SUICUNE, Route36SuicuneScript
	coord_event  8,  7, SCENE_ROUTE36_SUICUNE, Route36SuicuneScript

	def_bg_events
	bg_event 15,  1, BGEVENT_JUMPTEXT, Route36TrainerTips2Text
	bg_event 31, 11, BGEVENT_JUMPTEXT, RuinsOfAlphNorthSignText
	bg_event 39,  7, BGEVENT_JUMPTEXT, Route36SignText
	bg_event  7,  7, BGEVENT_JUMPTEXT, Route36TrainerTips1Text
	bg_event 33,  4, BGEVENT_JUMPTEXT, Route36AdvancedTips1Text
	bg_event 16,  7, BGEVENT_JUMPTEXT, Route36AdvancedTips2Text
	bg_event 12, 11, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_36
	bg_event 13, 11, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_36

	def_object_events
	object_event 21,  9, SPRITE_WEIRD_TREE, SPRITEMOVEDATA_SUDOWOODO, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, SudowoodoScript, EVENT_ROUTE_36_SUDOWOODO
	object_event 33,  6, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, ArthurScript, EVENT_ROUTE_36_ARTHUR_OF_THURSDAY
	object_event 19, 12, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route36FloriaScript, EVENT_FLORIA_AT_SUDOWOODO
	pokemon_event  7,  6, SUICUNE, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_AZURE, ClearText, EVENT_SAW_SUICUNE_ON_ROUTE_36
	object_event 12,  6, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route36CooltrainerfChiaraScript, -1
	object_event  6, 13, SPRITE_PSYCHIC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPsychicMark, -1
	object_event 17, 14, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_TRAINER, 5, TrainerSchoolboyAlan1, -1
	object_event 37,  9, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route36LassScript, -1
	object_event 28,  9, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, Route36RockSmashGuyScript, -1
	fruittree_event  7,  4, FRUITTREE_ROUTE_36, RAWST_BERRY, PAL_NPC_TEAL
	object_event 30,  5, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSchoolgirlMolly, -1

	object_const_def
	const ROUTE36_WEIRD_TREE
	const ROUTE36_ARTHUR
	const ROUTE36_FLORIA
	const ROUTE36_SUICUNE
	const ROUTE36_COOLTRAINERF

Route36ArthurCallback:
	readvar VAR_WEEKDAY
	ifequalfwd THURSDAY, .ArthurAppears
	disappear ROUTE36_ARTHUR
	endcallback

.ArthurAppears:
	appear ROUTE36_ARTHUR
	endcallback

Route36SuicuneScript:
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	playsound SFX_WARP_FROM
	turnobject PLAYER, UP
	applymovement ROUTE36_SUICUNE, Route36SuicuneMovement
	disappear ROUTE36_SUICUNE
	turnobject PLAYER, DOWN
	pause 10
	setscene SCENE_ROUTE36_NOOP
	clearevent EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY
	setmapscene CIANWOOD_CITY, SCENE_CIANWOODCITY_SUICUNE_AND_EUSINE
	end

SudowoodoScript:
	checkkeyitem SQUIRTBOTTLE
	iftruefwd .Fight
	waitsfx
	playsound SFX_SANDSTORM
	applyonemovement ROUTE36_WEIRD_TREE, tree_shake
	end

.Fight:
	opentext
	writetext UseSquirtbottleText
	yesorno
	iffalse_endtext
	closetext
WateredWeirdTreeScript:: ; export (for when you use Squirtbottle from pack)
	showtext UsedSquirtbottleText
	waitsfx
	playsound SFX_SANDSTORM
	applyonemovement ROUTE36_WEIRD_TREE, tree_shake
	showtext SudowoodoAttackedText
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon SUDOWOODO, 20
	startbattle
	setevent EVENT_FOUGHT_SUDOWOODO
	ifequalfwd $2, DidntCatchSudowoodo
	disappear ROUTE36_WEIRD_TREE
	reloadmapafterbattle
	special CheckBattleCaughtResult
	iffalsefwd .nocatch
	setflag ENGINE_PLAYER_CAUGHT_SUDOWOODO
.nocatch
	end

DidntCatchSudowoodo:
	reloadmapafterbattle
	applymovement ROUTE36_WEIRD_TREE, WeirdTreeMovement_Flee
	disappear ROUTE36_WEIRD_TREE
	special RefreshSprites
	end

Route36FloriaScript:
	scall .FloriaMessage
	clearevent EVENT_FLORIA_AT_FLOWER_SHOP
	readvar VAR_FACING
	ifequalfwd UP, .Up
	applymovement ROUTE36_FLORIA, FloriaMovement1
	disappear ROUTE36_FLORIA
	end

.Up:
	applymovement ROUTE36_FLORIA, FloriaMovement2
	disappear ROUTE36_FLORIA
	end

.FloriaMessage:
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue_jumptextfaceplayer FloriaTextAfterSudowoodo
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iftrue_jumptextfaceplayer FloriaTextAfterSquirtBottle
	jumpthistextfaceplayer

	text "Ich bin Flora"
	line "vom Blumenladen!"

	para "Stell dir vor:"

	para "Als ich den wacke-"
	line "ligen Baum mit"

	para "Wasser benetzte,"
	line "ist er hoch-"
	cont "geschreckt!"

	para "Es muss einfach"
	line "ein #mon sein."

	para "Ich wette, es gibt"
	line "seine Verkleidung"

	para "auf, wenn man es"
	line "gießt!"

	para "Genau! Ich sage es"
	line "meiner Schwester"
	cont "und leihe mir"
	cont "ihre Gießkanne!"
	done

Route36RockSmashGuyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM50_ROCK_SMASH
	iftruefwd .AlreadyGotRockSmash
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftruefwd .ClearedSudowoodo
	jumpthisopenedtext

	text "Oje!"

	para "Ich wollte den"
	line "Baum mit einem"

	para "mächtigen Hieb"
	line "entzweibrechen."

	para "Aber ich habe es"
	line "nicht geschafft."
	cont "Ich habe versagt!"
	done

.ClearedSudowoodo:
	writetext RockSmashGuyText2
	promptbutton
	verbosegivetmhm TM_ROCK_SMASH
	setevent EVENT_GOT_TM50_ROCK_SMASH
.AlreadyGotRockSmash:
	jumpthisopenedtext

	text "Das ist der"
if DEF(FAITHFUL)
	line "Zertrümmerer."
else
	line "Durchbruch."
endc

	para "Damit kannst du"
	line "Felsen mit einem"

	para "einzigen, gut "
	line "gezielten Schlag"
	cont "zertrümmern."

	para "Sind dir irgend-"
	line "welche Steine im"
	cont "Weg, dann"
	cont "zertrümmere sie"
	cont "einfach!"
	done

Route36LassScript:
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue_jumptextfaceplayer Route36LassText_ClearedSudowoodo
	jumpthistextfaceplayer

	text "Ein alter Baum"
	line "versperrt den Weg"
	cont "nach Dukatia City."

	para "Ich wollte mir das"
	line "riesige #mon-"
	cont "Center, das vor"
	cont "kurzem eröffnet"
	cont "wurde, ansehen…"
	done

TrainerSchoolboyAlan1:
	trainer SCHOOLBOY, ALAN1, EVENT_BEAT_SCHOOLBOY_ALAN, SchoolboyAlan1SeenText, SchoolboyAlan1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_SCHOOLBOY_ALAN
	opentext
	checkflag ENGINE_ALAN_READY_FOR_REMATCH
	iftruefwd .ChooseRematch
	checkflag ENGINE_ALAN_HAS_FIRE_STONE
	iftruefwd .GiveFireStone
	checkcellnum PHONE_SCHOOLBOY_ALAN
	iftruefwd .NumberAccepted
	checkevent EVENT_ALAN_ASKED_FOR_PHONE_NUMBER
	iftruefwd .AskAgainForPhoneNumber
	writetext SchoolboyAlanBooksText
	promptbutton
	setevent EVENT_ALAN_ASKED_FOR_PHONE_NUMBER
	callstd asknumber1m
	sjumpfwd .ContinueAskForPhoneNumber

.AskAgainForPhoneNumber:
	callstd asknumber2m
.ContinueAskForPhoneNumber:
	askforphonenumber PHONE_SCHOOLBOY_ALAN
	ifequalfwd $1, .PhoneFull
	ifequalfwd $2, .NumberDeclined
	gettrainername SCHOOLBOY, ALAN1, STRING_BUFFER_3
	callstd registerednumberm
	jumpstd numberacceptedm

.ChooseRematch:
	callstd rematchm
	winlosstext SchoolboyAlan1BeatenText, 0
	readmem wAlanFightCount
	ifequalfwd 4, .Fight4
	ifequalfwd 3, .Fight3
	ifequalfwd 2, .Fight2
	ifequalfwd 1, .Fight1
	ifequalfwd 0, .LoadFight0
.Fight4:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftruefwd .LoadFight4
.Fight3:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftruefwd .LoadFight3
.Fight2:
	checkflag ENGINE_FLYPOINT_BLACKTHORN
	iftruefwd .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_OLIVINE
	iftruefwd .LoadFight1
.LoadFight0:
	loadtrainer SCHOOLBOY, ALAN1
	startbattle
	reloadmapafterbattle
	loadmem wAlanFightCount, 1
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer SCHOOLBOY, ALAN2
	startbattle
	reloadmapafterbattle
	loadmem wAlanFightCount, 2
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer SCHOOLBOY, ALAN3
	startbattle
	reloadmapafterbattle
	loadmem wAlanFightCount, 3
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer SCHOOLBOY, ALAN4
	startbattle
	reloadmapafterbattle
	loadmem wAlanFightCount, 4
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer SCHOOLBOY, ALAN5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.GiveFireStone:
	callstd giftm
	verbosegiveitem FIRE_STONE, iffalsefwd .BagFull
	clearflag ENGINE_ALAN_HAS_FIRE_STONE
	setevent EVENT_ALAN_GAVE_FIRE_STONE
	jumpstd numberacceptedm

.BagFull:
	jumpstd packfullm

.NumberAccepted:
	jumpstd numberacceptedm

.NumberDeclined:
	jumpstd numberdeclinedm

.PhoneFull:
	jumpstd phonefullm

Route36CooltrainerfChiaraScript:
	checkevent EVENT_GOT_BINDING_BAND_FROM_ROUTE_36_LEADER
	iftrue_jumptextfaceplayer .AfterText2
	faceplayer
	checkevent EVENT_BEAT_COOLTRAINERF_CHIARA
	iftruefwd .Beaten
	checkevent EVENT_BEAT_SCHOOLBOY_ALAN
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_PSYCHIC_MARK
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_SCHOOLGIRL_MOLLY
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_TWINS_ANN_AND_ANNE
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_PSYCHIC_GREG
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_BEAUTY_CALLIE
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_BEAUTY_CASSANDRA
	iffalse_jumptext .IntroText
	opentext
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE36_COOLTRAINERF
	loadtrainer COOLTRAINERF, CHIARA
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERF_CHIARA
.Beaten:
	opentext
	writetext .AfterText1
	promptbutton
	verbosegiveitem BINDING_BAND, iffalse_endtext
	setevent EVENT_GOT_BINDING_BAND_FROM_ROUTE_36_LEADER
	jumpthisopenedtext

.AfterText2:
	text "Mit deinem Können"
	line "bin ich nicht die"

	para "einzige Elite-"
	line "Trainerin, die"
	cont "dich testen will."
	done

.IntroText:
	text "I saw how you woke"
	line "up that Sudowoodo."

	para "You did great!"

	para "And you have a"
	line "Plain Badge."
	cont "So do I!"

	para "How about this?"
	line "Take out all the"

	para "trainers on Routes"
	line "36 and 37."

	para "Then I'll fight"
	line "you myself!"
	done

.QuestionText:
	text "So you beat every-"
	line "one else in the"
	cont "area."

	para "Then it's time for"
	line "our showdown!"

	para "I use a Binding"
	line "Band to press my"
	cont "advantage."

	para "Think you're ready"
	line "for me?"
	done

.RefusedText:
	text "Well, I'm ready"
	line "when you are!"
	done

.SeenText:
	text "You won't last"
	line "long against my"
	cont "technique!"
	done

.BeatenText:
	text "I'm the one who"
	line "didn't last?!"
	done

.AfterText1:
	text "Du hast meine"
	line "Technik durch-"
	cont "schaut und"
	cont "gekontert."

	para "Probier sie doch"
	line "selbst!"

	para "Hier, für dich!"
	done

GenericTrainerPsychicMark:
	generictrainer PSYCHIC_T, MARK, EVENT_BEAT_PSYCHIC_MARK, PsychicMarkSeenText, PsychicMarkBeatenText

	text "Ich wäre wirklich"
	line "stark, wenn ich "

	para "wüsste, was mein"
	line "Gegner denkt."
	done

GenericTrainerSchoolgirlMolly:
	generictrainer SCHOOLGIRL, MOLLY, EVENT_BEAT_SCHOOLGIRL_MOLLY, SchoolgirlMollySeenText, SchoolgirlMollyBeatenText

	text "Ich muss noch"
	line "viel lernen."
	done

ArthurScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_HARD_STONE_FROM_ARTHUR
	iftruefwd .AlreadyGotStone
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, ArthurNotThursdayScript
	checkevent EVENT_MET_ARTHUR_OF_THURSDAY
	iftruefwd .MetArthur
	writetext MeetArthurText
	promptbutton
	setevent EVENT_MET_ARTHUR_OF_THURSDAY
.MetArthur:
	writetext ArthurGivesGiftText
	promptbutton
	verbosegiveitem HARD_STONE, iffalsefwd .BagFull
	setevent EVENT_GOT_HARD_STONE_FROM_ARTHUR
	jumpthisopenedtext

	text "Donatus: Ein"
	line "#mon, das"

	para "Gestein-Attacken"
	line "benutzt, sollte"
	cont "dies mit sich"
	cont "tragen."

	para "Es verstärkt"
	line "Gestein-Attacken."
	done

.AlreadyGotStone:
	writetext ArthurThursdayText
	waitbutton
.BagFull:
	endtext

ArthurNotThursdayScript:
	jumpthisopenedtext

	text "Donatus: Heute ist"
	line "nicht Donnerstag."
	cont "Wie bedauerlich!"
	done

WeirdTreeMovement_Flee:
	fast_jump_step_up
	fast_jump_step_up
	step_end

FloriaMovement1:
	step_down
	step_down
	step_down
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

FloriaMovement2:
	step_left
	step_down
	step_down
	step_down
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

Route36SuicuneMovement:
	fix_facing
	fast_jump_step_down
	fast_jump_step_down
	fast_jump_step_down
	fast_jump_step_right
	fast_jump_step_right
	fast_jump_step_right
	step_end

UseSquirtbottleText:
	text "Das ist ein merk-"
	line "würdiger Baum."
	cont "Möchtest du die"
	cont "Schiggykanne"
	cont "benutzen?"
	done

UsedSquirtbottleText:
	text "<PLAYER> benutzt"
	line "Schiggykanne."
	done

SudowoodoAttackedText:
	text "Der merkwürdige"
	line "Baum mag die"
	cont "Schiggykanne"
	cont "nicht!"

	para "Der merkwürdige"
	line "Baum greift an!"
	done


FloriaTextAfterSquirtBottle:
	text "I'm the Flower"
	line "Shop's Floria!"

	para "When I told my sis"
	line "about the jiggly"

	para "tree, she said"
	line "it's dangerous."

	para "Oh, she lent you"
	line "her water bottle?"

	para "You must be a good"
	line "trainer then!"

	para "I'll leave the"
	line "weird tree to you."

	para "Ta-ta!"
	done

FloriaTextAfterSudowoodo:
	text "I just knew that"
	line "wiggly tree was a"
	cont "#mon!"

	para "I was going to"
	line "shock it out of"

	para "its disguise, but"
	line "you beat me to it!"

	para "Oh well, I'll head"
	line "back to the Flower"
	cont "Shop."

	para "I'm Floria, by the"
	line "way."

	para "Ta-ta!"
	done


RockSmashGuyText2:
	text "Hast du diesen"
	line "seltsamen Baum"
	cont "weggeschafft?"

	para "Ich bin"
	line "beeindruckt! Ich"
	cont "möchte dir dies"
	cont "geben."
	done



Route36LassText_ClearedSudowoodo:
	text "Dieser merkwürdige"
	line "Baum ist spurlos"
	cont "verschwunden."

	para "Ach! Der Baum war"
	line "in Wirklichkeit"
	cont "ein #mon?"
	done

PsychicMarkSeenText:
	text "Ich werde jetzt"
	line "deine Gedanken"
	cont "lesen!"
	done

PsychicMarkBeatenText:
	text "Ich habe mich wohl"
	line "bei dir verlesen!"
	done

SchoolgirlMollySeenText:
	text "Earl hat mir bei-"
	line "gebracht, wie man"
	cont "mit #mon"
	cont "kämpft!"
	done

SchoolgirlMollyBeatenText:
	text "Meine Studien…"
	done

SchoolboyAlan1SeenText:
	text "Dank meiner"
	line "Studien bin ich"
	cont "für jedes #mon"
	cont "bereit!"
	done

SchoolboyAlan1BeatenText:
	text "Ups! Ein Fehler"
	line "in der Berechnung?"
	done

SchoolboyAlanBooksText:
	text "Mist! Ich lerne"
	line "auch fünf Stunden"
	cont "am Tag."

	para "Es gibt vieles,"
	line "das du nicht aus"
	cont "Büchern lernen"
	cont "kannst."
	done

MeetArthurText:
	text "Donatus: Wer bist"
	line "du?"

	para "Ich bin Donatus"
	line "von Donnerstag."
	done

ArthurGivesGiftText:
	text "Hier bitte. Das"
	line "kannst du haben."
	done


ArthurThursdayText:
	text "Donatus: Ich bin"
	line "Donatus von"

	para "Donnerstag. Ich"
	line "bin der zweite"

	para "Sohn von"
	line "sieben Kindern."
	done


Route36SignText:
	text "Route 36"
	done

RuinsOfAlphNorthSignText:
	text "Alph-Ruinen"
	line "Nordeingang"
	done

Route36TrainerTips1Text:
	text "Tipps für Trainer"
	line "Der Status der"

	para "#mon ist unter-"
	line "schiedlich, sogar"

	para "innerhalb der-"
	line "selben Spezies."

	para "Zu Beginn ist er"
	line "vielleicht noch"
	cont "ähnlich."

	para "Doch die Unter-"
	line "schiede werden "

	para "deutlicher, wenn"
	line "die #mon"
	cont "heranwachsen."
	done

Route36TrainerTips2Text:
	text "Tipps für Trainer"
	line "Setze den"

	para "Schaufler ein, um"
	line "an den Eingang"

	para "eines Ortes"
	line "zurückzugelangen."

	para "Das ist sehr nütz-"
	line "lich beim Erkunden"

	para "von Höhlen und an-"
	line "deren Umgebungen."
	done

Route36AdvancedTips1Text:
	text "Profi-Tipps!"

	assert NUM_FRAMES == 20
	para "Du kannst in den"
	line "Optionen aus"
	cont "zwanzig Rahmen und"

	assert NUM_FONTS == 8
	para "acht Schriftarten"
	line "wählen!"
	done

Route36AdvancedTips2Text:
	text "Profi-Tipps!"

	para "Verwöhnst du deine"
	line "#mon mit Haar-"
	cont "schnitten, Seg-"
	cont "nungen oder"

	para "Massagen, helfen"
	line "sie dir aus Zu-"

	para "neigung im"
	line "Kampf!"
	done
