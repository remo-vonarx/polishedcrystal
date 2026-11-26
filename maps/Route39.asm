Route39_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2, 19, ROUTE_39_BARN, 1
	warp_event  7, 19, ROUTE_39_FARMHOUSE, 1
	warp_event  9,  5, ROUTE_39_RUGGED_ROAD_GATE, 3
	warp_event  3, 19, ROUTE_39_BARN, 2

	def_coord_events

	def_bg_events
	bg_event  5, 47, BGEVENT_JUMPTEXT, Route39TrainerTipsText
	bg_event  8, 21, BGEVENT_JUMPTEXT, MoomooFarmSignText
	bg_event 11,  7, BGEVENT_JUMPTEXT, RuggedRoadAheadSignText
	bg_event 15, 25, BGEVENT_JUMPTEXT, Route39SignText
	bg_event  8,  9, BGEVENT_JUMPTEXT, Route39AdvancedTips1Text
	bg_event 14, 31, BGEVENT_JUMPTEXT, Route39AdvancedTips2Text
	bg_event  5, 29, BGEVENT_ITEM + NUGGET, EVENT_ROUTE_39_HIDDEN_NUGGET

	def_object_events
	object_event  7, 30, SPRITE_COWGIRL, SPRITEMOVEDATA_WANDER, 1, 2, -1, 0, OBJECTTYPE_SCRIPT, 0, Route39CowgirlAnnieScript, -1
	object_event 13, 45, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerSailorEugene, -1
	object_event 10, 38, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_TRAINER, 4, TrainerPokefanmDerek1, -1
	object_event 11, 35, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerPokefanfRuth, -1
	pokemon_event  3, 28, MILTANK, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_PINK, Route39MiltankText, -1
	pokemon_event  6, 27, MILTANK, SPRITEMOVEDATA_POKEMON, (1 << MORN) | (1 << DAY), PAL_MON_PINK, Route39MiltankText, -1
	pokemon_event  4, 31, MILTANK, SPRITEMOVEDATA_POKEMON, (1 << MORN) | (1 << DAY), PAL_MON_AZURE, Route39MiltankText, -1
	pokemon_event  8, 29, MILTANK, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_PINK, Route39MiltankText, -1
	object_event 13, 23, SPRITE_PSYCHIC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerPsychicNorman, -1
	fruittree_event  9, 26, FRUITTREE_ROUTE_39, CHESTO_BERRY, PAL_NPC_PURPLE
	object_event  4, 38, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_DARK_PURPLE, OBJECTTYPE_SCRIPT, 0, TrainerPokefanfJaime, -1
	object_event  4, 46, SPRITE_BEAUTY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route39BeautyText, -1
	object_event 15, 12, SPRITE_HIKER, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route39HikerText, -1
	object_event 25, 25, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBeautyOlivia, -1
	tmhmball_event  1, 23, TM_BULLDOZE, EVENT_ROUTE_39_TM_BULLDOZE
	smashrock_event 12, 10
	smashrock_event 15,  8

	object_const_def
	const ROUTE39_COWGIRL

TrainerPokefanmDerek1:
	trainer POKEFANM, DEREK1, EVENT_BEAT_POKEFANM_DEREK, PokefanmDerek1SeenText, PokefanmDerek1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_POKEFANM_DEREK
	opentext
	checkflag ENGINE_DEREK_HAS_NUGGET
	iftruefwd .HasNugget
	checkcellnum PHONE_POKEFANM_DEREK
	iftruefwd .NumberAccepted
	checkpoke PIKACHU
	iffalsefwd .WantsPikachu
	checkevent EVENT_DEREK_ASKED_FOR_PHONE_NUMBER
	iftruefwd .AskedAlready
	writetext PokefanMDerekText_NotBragging
	promptbutton
	setevent EVENT_DEREK_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjumpfwd .AskForNumber

.AskedAlready:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_POKEFANM_DEREK
	ifequalfwd $1, .PhoneFull
	ifequalfwd $2, .NumberDeclined
	gettrainername POKEFANM, DEREK1, STRING_BUFFER_3
	scall .RegisteredNumber
	sjumpfwd .NumberAccepted

.HasNugget:
	scall .Gift
	verbosegiveitem NUGGET, iffalsefwd .NoRoom
	clearflag ENGINE_DEREK_HAS_NUGGET
	sjumpfwd .NumberAccepted

.NoRoom:
	sjumpfwd .PackFull

.WantsPikachu:
	jumpthisopenedtext

	text "Pikachu muss sein!"
	line "Was meinst du?"
	done

.AskNumber1:
	jumpstd asknumber1m

.AskNumber2:
	jumpstd asknumber2m

.RegisteredNumber:
	jumpstd registerednumberm

.NumberAccepted:
	jumpstd numberacceptedm

.NumberDeclined:
	jumpstd numberdeclinedm

.PhoneFull:
	jumpstd phonefullm

.Gift:
	jumpstd giftm

.PackFull:
	jumpstd packfullm

GenericTrainerPokefanfRuth:
	generictrainer POKEFANF, RUTH, EVENT_BEAT_POKEFANF_RUTH, PokefanfRuthSeenText, PokefanfRuthBeatenText

	text "Weißt du über"
	line "Baby-#mon"
	cont "Bescheid?"

	para "Die sind bestimmt"
	line "super-süß!"
	done

Route39CowgirlAnnieScript:
	checkevent EVENT_GOT_PP_MAX_FROM_ROUTE_39_LEADER
	iftrue_jumptextfaceplayer .AfterText2
	faceplayer
	checkevent EVENT_BEAT_COWGIRL_ANNIE
	iftruefwd .Beaten
	checkevent EVENT_BEAT_BIRD_KEEPER_TOBY
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_SAILOR_HARRY
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_LASS_DANA
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_SCHOOLBOY_CHAD
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_BEAUTY_VALENCIA
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_BEAUTY_OLIVIA
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_POKEFANM_DEREK
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_POKEFANF_RUTH
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_SAILOR_EUGENE
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_PSYCHIC_NORMAN
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_POKEFANF_JAIME
	iffalse_jumptext .IntroText
	opentext
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE39_COWGIRL
	loadtrainer COWGIRL, ANNIE
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COWGIRL_ANNIE
.Beaten:
	opentext
	writetext .AfterText1
	promptbutton
	verbosegiveitem PP_MAX, iffalse_endtext
	setevent EVENT_GOT_PP_MAX_FROM_ROUTE_39_LEADER
	jumpthisopenedtext

.AfterText2:
	text "Aus Miltank-Milch"
	line "machen wir Käse"
	cont "und Joghurt."
	done

.IntroText:
	text "Hey! Erschreck die"
	line "Miltank nicht!"

	para "…Oh, du willst"
	line "kämpfen?"

	para "Ich mach gerade"
	line "Arbeit auf'm Hof…"

	para "Weißte was: Besieg"
	line "alle anderen von"

	para "Teak City bis"
	line "Oliviana City,"
	cont "dann kämpf ich"
	cont "gegen dich."

	para "Manche von denen"
	line "kämpfen vielleicht"

	para "nur, wenn's"
	line "draußen dunkel"
	cont "ist."
	done

.QuestionText:
	text "Ich bin mit meiner"
	line "Arbeit fertig, und"

	para "du hast die Routen"
	line "hier freigekämpft."

	para "Also, mein Team"
	line "hat Jens besiegt,"

	para "und ich schätze,"
	line "dich schaffen wir"
	cont "auch."

	para "Was meinste?"
	done

.RefusedText:
	text "Schade. Dann"
	line "zurück zu den"
	cont "Miltank."
	done

.SeenText:
	text "Ich zeig dir, was"
	line "ein Cowgirl drauf"
	cont "hat!"
	done

.BeatenText:
	text "Ich hab Milch"
	line "verschüttet…"
	done

.AfterText1:
	text "Puh! Das war eine"
	line "heftige Pause!"

	para "Danke für den"
	line "Spaß, Partner."

	para "Nimm das mit!"
	done

GenericTrainerSailorEugene:
	generictrainer SAILOR, EUGENE, EVENT_BEAT_SAILOR_EUGENE, SailorEugeneSeenText, SailorEugeneBeatenText

	text "Meine #mon"
	line "wurden eingefangen"
	cont "und sind im Aus-"
	cont "land aufgezogen"
	cont "worden."

	para "Sie begleiten mich"
	line "auf meinen langen"
	cont "Reisen."
	done

GenericTrainerPsychicNorman:
	generictrainer PSYCHIC_T, NORMAN, EVENT_BEAT_PSYCHIC_NORMAN, PsychicNormanSeenText, PsychicNormanBeatenText

	text "Du weißt von den"
	line "unterschiedlichen"
	cont "#-Fähigkeiten?"

	para "Bei den Menschen"
	line "ist das ganz"
	cont "ähnlich. Jeder hat"
	cont "unterschiedliche"
	cont "Talente."
	done

TrainerPokefanfJaime:
	faceplayer
	opentext
	checktime 1 << NITE
	iffalsefwd .NotNight
	checkevent EVENT_BEAT_POKEFANF_JAIME
	iftruefwd .Beaten
	writetext PokefanfJaimeSeenText
	waitbutton
	closetext
	winlosstext PokefanfJaimeBeatenText, 0
	loadtrainerwithpal POKEFANF, JAIME, TRAINERPAL_DARK_POKEFANF
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_POKEFANF_JAIME
	endtext

.Beaten:
	jumpthisopenedtext

	text "Ich traf Mauzi"
	line "nachts, genau hier"
	cont "auf Route 39."

	para "Ich weiß nicht"
	line "warum, aber es"

	para "scheint es zu"
	line "mögen, wenn ich"
	cont "hier trainiere."

	para "Es scheint mich"
	line "durch das Training"

	para "hier mehr zu"
	line "mögen, als wenn"

	para "ich woanders"
	line "trainiere."
	done

.NotNight:
	jumpthisopenedtext

	text "Ufu… Ich hoffe, es"
	line "wird bald dunkel."
	done

Route39MiltankText:
	text "Miltank: Muh!"
	done

SailorEugeneSeenText:
	text "Ich bin gerade"
	line "wieder in Oliviana"
	cont "angekommen."

	para "Wie steht es nun"
	line "mit dem #mon-"
	cont "Kampf?"
	done

SailorEugeneBeatenText:
	text "Aah!"
	done

PokefanmDerek1SeenText:
	text "Genau der richtige"
	line "Moment, um mit"
	cont "Pikachu anzugeben!"
	done

PokefanmDerek1BeatenText:
	text "Ich hatte keine"
	line "Zeit, mit Pikachu"
	cont "zu prahlen…"
	done

PokefanMDerekText_NotBragging:
	text "Ich höre mir deine"
	line "Prahlerei gar"
	cont "nicht an!"

	para "Wir #-Fans"
	line "haben ein Gelübde,"

	para "das uns verbietet,"
	line "Leuten beim"
	cont "Prahlen zuzuhören!"
	done

PokefanfRuthSeenText:
	text "Was für süße"
	line "#mon!"

	para "Zeigen wir uns"
	line "gegenseitig unsere"
	cont "#mon, und zwar"
	cont "gleichzeitig!"
	done

PokefanfRuthBeatenText:
	text "Mir macht es"
	line "nichts aus,"
	cont "zu verlieren."
	done


PsychicNormanSeenText:
	text "Zeig doch mal, was"
	line "deine #mon"
	cont "drauf haben."
	done

PsychicNormanBeatenText:
	text "He, deine #mon"
	line "sind sehr fähig!"
	done


PokefanfJaimeSeenText:
	text "Du kommst gerade"
	line "recht."

	para "Auf in den Kampf."
	done

PokefanfJaimeBeatenText:
	text "Oh, wie"
	line "ernüchternd…"
	done


Route39BeautyText:
	text "Was ist höher: der"
	line "Glockenturm in"
	cont "Teak City"

	para "oder der Leucht-"
	line "turm in Oliviana"
	cont "City?"

	para "Der Glockenturm,"
	line "ganz klar!"
	done

Route39HikerText:
	text "Nördlich von Oli-"
	line "viana City liegt"
	cont "Johtos Grenzland!"

	para "Eine harte Wande-"
	line "rung durch raues"

	para "Gelände, dann der"
	line "Aufstieg auf einen"
	cont "eisigen Berg…"

	para "Es heißt, manche"
	line "#mon haben sich"

	para "an das raue Klima"
	line "angepasst."

	para "…Aber ohne eine"
	line "Wüstenbrille zum"
	cont "Schutz"

	para "kann ich nicht mal"
	line "losgehen…"
	done

Route39SignText:
	text "Route 39"

	para "Oliviana City -"
	line "Teak City"
	done

Route39AdvancedTips1Text:
	text "Tipps für Profis!"

	para "Sandstürme stärken"
	line "die Sp.Vert von"
	cont "Gestein-#mon!"

	para "Und Hagel stärkt"
	line "die Vert von"
	cont "Eis-#mon!"
	done

Route39AdvancedTips2Text:
	text "Tipps für Profis!"

	para "Mit der Fähigkeit"
	line "Facettenauge oder"
	cont "einem getragenen"
	cont "Münzamulett"

	para "triffst du eher"
	line "auf wilde #mon,"
	cont "die Items tragen!"
	done

RuggedRoadAheadSignText:
	text "Holpriger Pfad"
	line "voraus"

	para "Nördlich zum"
	line "Schneegipfel"
	done

MoomooFarmSignText:
	text "Kuhmuh-Farm"

	para "Unsere Bekömmliche"
	line "Milch Ist Sehr"
	cont "Erfrischend"
	done

Route39TrainerTipsText:
	text "Tipps für Trainer"
	line "Benutze Kopfnuss,"

	para "um #mon"
	line "aus den Bäumen"
	cont "zu schütteln."

	para "Auf den Bäumen"
	line "leben verschiedene"
	cont "Arten von #mon."

	para "Benutze Kopfnuss"
	line "an jedem Baum, den"
	cont "du siehst!"
	done
