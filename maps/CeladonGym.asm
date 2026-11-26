CeladonGym_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 17, CELADON_CITY, 8
	warp_event  5, 17, CELADON_CITY, 8

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, CeladonGymStatue
	bg_event  6, 15, BGEVENT_READ, CeladonGymStatue

	def_object_events
	object_event  5,  3, SPRITE_ERIKA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonGymErikaScript, -1
	object_event  7,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerLassMichelle, -1
	object_event  2,  8, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerPicnickerTanya, -1
	object_event  3,  5, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBeautyJulia, -1
	object_event  6,  5, SPRITE_AROMA_LADY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerAroma_ladyDahlia, -1
	object_event  4, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerTwinsJoandzoe1, -1
	object_event  5, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerTwinsJoandzoe2, -1

CeladonGymErikaScript:
	faceplayer
	opentext
	checkflag ENGINE_RAINBOWBADGE
	iftruefwd .FightDone
	writetext ErikaBeforeBattleText
	waitbutton
	closetext
	winlosstext ErikaBeatenText, 0
	loadtrainer ERIKA, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_ERIKA
	setevent EVENT_BEAT_LASS_MICHELLE
	setevent EVENT_BEAT_PICNICKER_TANYA
	setevent EVENT_BEAT_BEAUTY_JULIA
	setevent EVENT_BEAT_AROMA_LADY_DAHLIA
	setevent EVENT_BEAT_TWINS_JO_AND_ZOE
	opentext
	givebadge RAINBOWBADGE, KANTO_REGION
	callstd kantopostgymevents
.FightDone:
	checkevent EVENT_GOT_TM19_GIGA_DRAIN
	iftrue_jumpopenedtext ErikaAfterBattleText
	writetext ErikaExplainTMText
	promptbutton
	verbosegivetmhm TM_GIGA_DRAIN
	setevent EVENT_GOT_TM19_GIGA_DRAIN
	jumpthisopenedtext

	text "It is Giga Drain."

	para "It is a wonderful"
	line "move that drains"

	para "half the damage it"
	line "inflicts to heal"
	cont "your #mon."

	para "Please use it if"
	line "it pleases you…"
	done

GenericTrainerLassMichelle:
	generictrainer LASS, MICHELLE, EVENT_BEAT_LASS_MICHELLE, LassMichelleSeenText, LassMichelleBeatenText

	text "Ich wurde nur"
	line "unvorsichtig, das"
	cont "ist alles!"
	done

GenericTrainerPicnickerTanya:
	generictrainer PICNICKER, TANYA, EVENT_BEAT_PICNICKER_TANYA, PicnickerTanyaSeenText, PicnickerTanyaBeatenText

	text "Oh, sieh nur, all"
	line "die Orden. Kein"

	para "Wunder, dass ich"
	line "verloren habe!"
	done

GenericTrainerBeautyJulia:
	generictrainer BEAUTY, JULIA, EVENT_BEAT_BEAUTY_JULIA, BeautyJuliaSeenText, BeautyJuliaBeatenText

	text "Wie werde ich nur"
	line "so damenhaft"
	cont "wie Erika?"
	done

GenericTrainerAroma_ladyDahlia:
	generictrainer AROMA_LADY, DAHLIA, EVENT_BEAT_AROMA_LADY_DAHLIA, Aroma_ladyDahliaSeenText, Aroma_ladyDahliaBeatenText

	text "Duflor verströmt"
	line "einen üblen Duft,"

	para "aber Erika weiß,"
	line "wie man daraus"

	para "ein süßes Parfüm"
	line "macht."
	done

GenericTrainerTwinsJoandzoe1:
	generictrainer TWINS, JOANDZOE1, EVENT_BEAT_TWINS_JO_AND_ZOE, TwinsJoandzoe1SeenText, TwinsJoandzoe1BeatenText

	text "Erika wird es dir"
	line "heimzahlen!"
	done

GenericTrainerTwinsJoandzoe2:
	generictrainer TWINS, JOANDZOE2, EVENT_BEAT_TWINS_JO_AND_ZOE, TwinsJoandzoe2SeenText, TwinsJoandzoe2BeatenText

	text "Erika ist viel"
	line "stärker!"
	done

CeladonGymStatue:
	gettrainername ERIKA, 1, STRING_BUFFER_4
	checkflag ENGINE_RAINBOWBADGE
	iftruefwd .Beaten
	jumpstd gymstatue1
.Beaten:
	jumpstd gymstatue2

ErikaBeforeBattleText:
	text "Erika: Hallo…"
	line "Schönes Wetter,"

	para "nicht?"
	line "Einfach herrlich…"

	para "…Ich könnte gleich"
	line "einschlafen…"

	para "Ich heiße Erika."
	line "Ich bin die Arena-"
	cont "leiterin von"
	cont "Prismania City."

	para "…Wirklich? Den"
	line "ganzen Weg von "
	cont "Johto? Wie nett…"

	para "Oh, entschuldige."
	line "Ich wusste"

	para "nicht, dass du"
	line "gegen mich kämpfen"
	cont "willst."

	para "Nun gut. Ich werde"
	line "jedenfalls nicht"
	cont "verlieren."
	done

ErikaBeatenText:
	text "Erika: Oh!"
	line "Ich gebe mich"
	cont "geschlagen…"

	para "Du bist außerge-"
	line "wöhnlich stark…"

	para "Ich gebe dir den"
	line "Farborden…"
	done

ErikaExplainTMText:
	text "Erika: That was a"
	line "delightful match."

	para "I felt inspired."
	line "Please, I wish you"
	cont "to have this TM."
	done


ErikaAfterBattleText:
	text "Erika: Eine"
	line "Niederlage ist"

	para "nicht sehr"
	line "angenehm…"

	para "Aber es ist ein"
	line "Ansporn, sich"

	para "mehr anzustrengen,"
	line "wenn man weiß,"

	para "dass es starke"
	line "Trainer gibt…"
	done

LassMichelleSeenText:
	text "Glaubst du, dass"
	line "eine PKMN-Arena"
	cont "nur mit Mädchen"
	cont "selten ist?"
	done

LassMichelleBeatenText:
	text "Ach nee!"
	done

PicnickerTanyaSeenText:
	text "Oh, ein Kampf?"
	line "Das macht mir ein"
	cont "bisschen Angst,"
	cont "aber von mir aus!"
	done

PicnickerTanyaBeatenText:
	text "Ach, das war es?"
	done

BeautyJuliaSeenText:
	text "Hast du die"
	line "Blumen betrachtet"
	cont "oder mich?"
	done

BeautyJuliaBeatenText:
	text "Wie ärgerlich!"
	done

Aroma_ladyDahliaSeenText:
	text "Du hast einen"
	line "faszinierenden"
	cont "Duft an dir…"
	done

Aroma_ladyDahliaBeatenText:
	text "Der üble Geruch"
	line "der Niederlage…"
	done

TwinsJoandzoe1SeenText:
	text "Wir zeigen dir"
	line "#mon-Attacken,"
	cont "die Erika uns"
	cont "beigebracht hat!"
	done

TwinsJoandzoe1BeatenText:
	text "Oh… Wir haben"
	line "verloren…"
	done

TwinsJoandzoe2SeenText:
	text "Wir werden Erika"
	line "beschützen!"
	done

TwinsJoandzoe2BeatenText:
	text "Wir hatten keine"
	line "Chance…"
	done
