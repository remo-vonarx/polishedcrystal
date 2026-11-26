Route31_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route31CheckMomCall

	def_warp_events
	warp_event  4,  6, ROUTE_31_VIOLET_GATE, 3
	warp_event  4,  7, ROUTE_31_VIOLET_GATE, 4
	warp_event 34,  5, DARK_CAVE_VIOLET_ENTRANCE, 1

	def_coord_events

	def_bg_events
	bg_event  7,  5, BGEVENT_JUMPTEXT, Route31SignText
	bg_event 31,  5, BGEVENT_JUMPTEXT, DarkCaveSignText
	bg_event 13, 14, BGEVENT_JUMPTEXT, Route31AdvancedTipsSignText

	def_object_events
	object_event 28,  7, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerCooltrainermFinch, -1
	object_event 17,  7, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route31MailRecipientScript, -1
	object_event  9,  5, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route31YoungsterText, -1
	object_event 21, 13, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_TRAINER, 5, TrainerBug_catcherWade1, -1
	cuttree_event 13,  5, EVENT_ROUTE_31_CUT_TREE_1
	cuttree_event 25, 10, EVENT_ROUTE_31_CUT_TREE_2
	fruittree_event 16,  7, FRUITTREE_ROUTE_31, PERSIM_BERRY, PAL_NPC_PINK
	itemball_event 29,  5, POTION, 1, EVENT_ROUTE_31_POTION
	itemball_event 19, 15, POKE_BALL, 1, EVENT_ROUTE_31_POKE_BALL

	object_const_def
	const ROUTE31_COOLTRAINER_M

Route31CheckMomCall:
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iffalsefwd .DoMomCall
	endcallback

.DoMomCall:
	specialphonecall SPECIALCALL_WORRIED
	endcallback

TrainerCooltrainermFinch:
	trainer 0, 0, EVENT_INTRODUCED_ROUTE_LEADERS, .IntroText, 0, 0, .Script

.Script:
	endifjustbattled
	checkevent EVENT_GOT_AIR_BALLOON_FROM_ROUTE_31_LEADER
	iftrue_jumptextfaceplayer .AfterText2
	faceplayer
	opentext
	checkevent EVENT_BEAT_COOLTRAINERM_FINCH
	iftruefwd .Beaten
	checkevent EVENT_BEAT_YOUNGSTER_JOEY
	iffalse_jumpopenedtext .IntroText
	checkevent EVENT_BEAT_YOUNGSTER_MIKEY
	iffalse_jumpopenedtext .IntroText
	checkevent EVENT_BEAT_BUG_CATCHER_DON
	iffalse_jumpopenedtext .IntroText
	checkevent EVENT_BEAT_BUG_CATCHER_WADE
	iffalse_jumpopenedtext .IntroText
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE31_COOLTRAINER_M
	loadtrainer COOLTRAINERM, FINCH
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERM_FINCH
	opentext
.Beaten:
	writetext .AfterText1
	promptbutton
	verbosegiveitem AIR_BALLOON, iffalse_endtext
	setevent EVENT_GOT_AIR_BALLOON_FROM_ROUTE_31_LEADER
	jumpthisopenedtext

.AfterText2:
	text "Du hast die Wir-"
	line "kung eines Luft-"
	cont "ballons in unserem"
	cont "Kampf gesehen."

	para "Vielleicht triffst"
	line "du noch andere"
	cont "Trainer wie mich,"
	cont "die durch Johto"
	cont "ziehen."

	para "Auf der Suche"
	line "nach Stärke."

	para "Du tätest gut"
	line "daran, sie heraus-"
	cont "zufordern!"
	done

.IntroText:
	text "Ich bin ein Trai-"
	line "ner, der im Kampf"
	cont "Luftballons"
	cont "einsetzt."

	para "Ich will mich von"
	line "deiner Stärke"
	cont "mitreißen lassen…"

	para "Wenn du jeden"
	line "Trainer auf Route"
	cont "30 und 31 be-"
	cont "siegst, dann tritt"
	cont "gegen mich an."
	done

.QuestionText:
	text "Du hast also alle"
	line "Trainer hier"
	cont "besiegt!"

	para "Dann bist du wür-"
	line "dig, mich heraus-"
	cont "zufordern!"

	para "Wollen wir"
	line "kämpfen?"
	done

.RefusedText:
	text "Du willst deine"
	line "Stärke nicht mit"
	cont "meiner messen?"

	para "Ich gebe dir mein"
	line "Markenzeichen,"
	cont "wenn du gewinnst…"
	done

.SeenText:
	text "Sei gegrüßt! Ich"
	line "trete dir als"

	para "Luftballon-Nutzer"
	line "entgegen!"
	done

.BeatenText:
	text "Du hast mich auf"
	line "den Boden der Tat-"
	cont "sachen geholt…"
	done

.AfterText1:
	text "Ein feiner Kampf!"
	line "Du bist ein auf-"

	para "strebender Stern"
	line "unter Trainern!"

	para "Hier ist der"
	line "Beweis unseres"
	cont "Kampfes."
	cont "Ein Luftballon!"

	para "Nimm ihn, als"
	line "Zeichen unserer"
	cont "Freundschaft!"
	done

TrainerBug_catcherWade1:
	trainer BUG_CATCHER, WADE1, EVENT_BEAT_BUG_CATCHER_WADE, Bug_catcherWade1SeenText, Bug_catcherWade1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_BUG_CATCHER_WADE
	opentext
	checkflag ENGINE_WADE_READY_FOR_REMATCH
	iftruefwd .WadeRematch
	checkflag ENGINE_WADE_HAS_ITEM
	iftruefwd .WadeItem
	checkcellnum PHONE_BUG_CATCHER_WADE
	iftruefwd .AcceptedNumberSTD
	checkevent EVENT_WADE_ASKED_FOR_PHONE_NUMBER
	iftruefwd .AskAgain
	writetext Bug_catcherWade1AfterText
	waitbutton
	setevent EVENT_WADE_ASKED_FOR_PHONE_NUMBER
	callstd asknumber1m
	sjumpfwd .Continue

.AskAgain:
	callstd asknumber2m
.Continue:
	askforphonenumber PHONE_BUG_CATCHER_WADE
	ifequalfwd $1, .PhoneFullSTD
	ifequalfwd $2, .DeclinedNumberSTD
	gettrainername BUG_CATCHER, WADE1, STRING_BUFFER_3
	callstd registerednumberm
	jumpstd numberacceptedm

.WadeRematch:
	callstd rematchm
	winlosstext Bug_catcherWade1BeatenText, 0
	readmem wWadeFightCount
	ifequalfwd 4, .Fight4
	ifequalfwd 3, .Fight3
	ifequalfwd 2, .Fight2
	ifequalfwd 1, .Fight1
	ifequalfwd 0, .LoadFight0
.Fight4:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftruefwd .LoadFight4
.Fight3:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftruefwd .LoadFight3
.Fight2:
	checkflag ENGINE_FLYPOINT_MAHOGANY
	iftruefwd .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iftruefwd .LoadFight1
.LoadFight0:
	loadtrainer BUG_CATCHER, WADE1
	startbattle
	reloadmapafterbattle
	loadmem wWadeFightCount, 1
	clearflag ENGINE_WADE_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer BUG_CATCHER, WADE2
	startbattle
	reloadmapafterbattle
	loadmem wWadeFightCount, 2
	clearflag ENGINE_WADE_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer BUG_CATCHER, WADE3
	startbattle
	reloadmapafterbattle
	loadmem wWadeFightCount, 3
	clearflag ENGINE_WADE_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer BUG_CATCHER, WADE4
	startbattle
	reloadmapafterbattle
	loadmem wWadeFightCount, 4
	clearflag ENGINE_WADE_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer BUG_CATCHER, WADE5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WADE_READY_FOR_REMATCH
	end

.WadeItem:
	callstd giftm
	checkevent EVENT_WADE_HAS_ORAN_BERRY
	iftruefwd .OranBerry
	checkevent EVENT_WADE_HAS_PECHA_BERRY
	iftruefwd .PechaBerry
	checkevent EVENT_WADE_HAS_CHERI_BERRY
	iftruefwd .CheriBerry
	checkevent EVENT_WADE_HAS_PERSIM_BERRY
	iftruefwd .PersimBerry
.OranBerry:
	verbosegiveitem ORAN_BERRY, iffalsefwd .PackFull
	sjumpfwd .Done
.PechaBerry:
	verbosegiveitem PECHA_BERRY, iffalsefwd .PackFull
	sjumpfwd .Done
.CheriBerry:
	verbosegiveitem CHERI_BERRY, iffalsefwd .PackFull
	sjumpfwd .Done
.PersimBerry:
	verbosegiveitem PERSIM_BERRY, iffalsefwd .PackFull
.Done:
	clearflag ENGINE_WADE_HAS_ITEM
	jumpstd numberacceptedm
.PackFull:
	jumpstd packfullm

.AcceptedNumberSTD:
	jumpstd numberacceptedm

.DeclinedNumberSTD:
	jumpstd numberdeclinedm

.PhoneFullSTD:
	jumpstd phonefullm

Route31MailRecipientScript:
	faceplayer
	opentext
	checkevent EVENT_GAVE_KENYA
	iftruefwd .TutorSleepTalk
	checkevent EVENT_GOT_KENYA
	iftruefwd .TryGiveKenya
	jumpthisopenedtext

	text "…Uargh… Hä?"

	para "Heute bin ich auf"
	line "der Suche nach"
	cont "#mon zu viel"
	cont "gelaufen."

	para "Meine Füße schmer-"
	line "zen und ich bin"
	cont "müde…"

	para "Wenn ich ein wil-"
	line "des #mon wäre,"
	cont "würde ich mich"
	cont "leicht fangen"
	cont "lassen…"

	para "…Zzzz…"
	done

.TryGiveKenya:
	writetext Text_Route31SleepyManGotMail
	promptbutton
	checkpokemail ReceivedSpearowMailText
	ifequalfwd $0, .WrongMail
	ifequalfwd $2, .Refused
	ifequalfwd $3, .NoMail
	ifequalfwd $4, .LastMon
	writetext Text_Route31HandOverMailMon
	promptbutton
	writetext Text_Route31ReadingMail
	promptbutton
	setevent EVENT_GAVE_KENYA
.TutorSleepTalk
	writetext Text_Route31TutorSleepTalk
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writetext Text_Route31TutorQuestion
	yesorno
	iffalsefwd .TutorRefused
	setval SLEEP_TALK
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpthisopenedtext

	text "Na gut…"
	done

.NoSilverLeaf
	jumpthisopenedtext

	text "Du hast aber kein"
	line "Silberblatt…"
	done

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext

	text "So! Jetzt kann"
	line "dein #mon"
	cont "Schlafrede!"
	done

.WrongMail:
	jumpthisopenedtext

	text "Der Brief ist"
	line "nicht für mich."
	done

.NoMail:
	jumpthisopenedtext

	text "Was ist so beson-"
	line "ders an diesem"
	cont "#mon?"

	para "Es trägt keinen"
	line "Brief."
	done

.Refused:
	jumpthisopenedtext

	text "Was? Du möchtest"
	line "nichts?"
	done

.LastMon:
	jumpthisopenedtext

	text "Wenn ich dir die-"
	line "ses #mon weg-"

	para "nehme, womit"
	line "willst du dann"

	para "kämpfen?"
	done

ReceivedSpearowMailText:
	setcharmap no_ngrams
	db   "Dark Cave leads"
	next "to another road@"
	setcharmap default

Bug_catcherWade1SeenText:
	text "Ich habe einige"
	line "#mon gefangen."
	cont "Lass uns kämpfen!"
	done

Bug_catcherWade1BeatenText:
	text "Awwwww…"
	done

Bug_catcherWade1AfterText:
	text "Du kannst #mon"
	line "fangen, auch wenn"

	para "du bereits sechs"
	line "bei dir trägst."

	para "Fängst du eines,"
	line "wird es automa-"
	cont "tisch auf die Box"
	cont "im PC übertragen."
	done


Text_Route31SleepyManGotMail:
	text "…Zzzz… Häh?"

	para "Was ist? Du"
	line "hast einen Brief"
	cont "für mich?"
	done

Text_Route31HandOverMailMon:
	text "<PLAYER> übergibt"
	line "das #mon, das"
	cont "den Brief trägt."
	done

Text_Route31ReadingMail:
	text "Mal sehen…"

	para "…die Dunkelhöhle"
	line "führt zu einem"
	cont "anderen Weg…"

	para "Gut zu wissen."

	para "Danke, dass du mir"
	line "den Brief"
	cont "brachtest."

	para "Mein Freund ist"
	line "ein netter Mensch,"
	cont "genau wie du!"

	para "Ich möchte mich"
	line "bei dir dafür"
	cont "revanchieren!"
	done

Text_Route31TutorSleepTalk:
	text "Für nur ein"
	line "Silberblatt"

	para "bringe ich deinem"
	line "#mon bei, im"
	cont "Schlaf zu reden!"
	done


Text_Route31TutorQuestion:
	text "Soll ich deinem"
	line "#mon Schlafrede"
	cont "beibringen?"
	done







Route31YoungsterText:
	text "Ich habe ein gutes"
	line "#mon in der"
	cont "Dunkelhöhle"
	cont "gefunden."

	para "Ich ziehe es groß,"
	line "um später gegen"
	cont "Falk anzutreten."

	para "Er ist der Arena-"
	line "leiter von Viola"
	cont "City."
	done

Route31SignText:
	text "Route 31"

	para "Viola City -"
	line "Rosalia City"
	done

DarkCaveSignText:
	text "Dunkelhöhle"
	done

Route31AdvancedTipsSignText:
	text "Tipps für Profis!"

	para "Drücke im Beutel"
	line "START, um eine"
	cont "Tasche zu sortie-"
	cont "ren!"
	done
