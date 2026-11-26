DEF FIGHTINGDOJO_REMATCH_VARSPRITE_1 EQU SPRITE_BIG_DOLL
DEF FIGHTINGDOJO_REMATCH_VARSPRITE_2 EQU SPRITE_COPYCAT
DEF FIGHTINGDOJO_REMATCH_VARSPRITE_3 EQU SPRITE_CONSOLE

FightingDojo_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, FightingDojoSetupRematchesCallback

	def_warp_events
	warp_event  4, 11, SAFFRON_CITY, 1
	warp_event  5, 11, SAFFRON_CITY, 1

	def_coord_events

	def_bg_events
	bg_event  4,  0, BGEVENT_JUMPTEXT, FightingDojoSign1Text
	bg_event  5,  0, BGEVENT_JUMPTEXT, FightingDojoSign2Text
	bg_event  9,  0, BGEVENT_READ, MapFightingDojoSignpost2Script

	def_object_events
	object_event  0,  1, FIGHTINGDOJO_REMATCH_VARSPRITE_1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, FightingDojoRematch1Script, EVENT_REMATCH_GYM_LEADER_1
	object_event  0,  2, FIGHTINGDOJO_REMATCH_VARSPRITE_2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, FightingDojoRematch2Script, EVENT_REMATCH_GYM_LEADER_2
	object_event  0,  3, FIGHTINGDOJO_REMATCH_VARSPRITE_3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, FightingDojoRematch3Script, EVENT_REMATCH_GYM_LEADER_3
	object_event  4,  3, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, FightingDojoBlackBelt, -1

	object_const_def
	const FIGHTINGDOJO_REMATCH_1
	const FIGHTINGDOJO_REMATCH_2
	const FIGHTINGDOJO_REMATCH_3

FightingDojoSetupRematchesCallback:
	disappear FIGHTINGDOJO_REMATCH_1
	disappear FIGHTINGDOJO_REMATCH_2
	disappear FIGHTINGDOJO_REMATCH_3
	checkevent EVENT_BEAT_BLUE
	iftruefwd .SetupDailyRematches
	endcallback

MACRO rematch ; person, sprite, x, y, face, palette
	moveobject FIGHTINGDOJO_REMATCH_\1, \3, \4
	turnobject FIGHTINGDOJO_REMATCH_\1, \5
	setmapobjectpal FIGHTINGDOJO_REMATCH_\1, PAL_NPC_\6
	appear FIGHTINGDOJO_REMATCH_\1
	variablesprite FIGHTINGDOJO_REMATCH_VARSPRITE_\1, SPRITE_\2
ENDM

.SetupDailyRematches:
	readvar VAR_WEEKDAY
	ifequalfwd MONDAY, .Monday
	ifequalfwd TUESDAY, .Tuesday
	ifequalfwd WEDNESDAY, .Wednesday
	ifequal THURSDAY, .Thursday
	ifequal FRIDAY, .Friday
	ifequal SATURDAY, .Saturday

.Sunday
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .SundayNight
.SundayMorningAndDay
	rematch 1, JASMINE, 3, 6, RIGHT, RED
	rematch 2, ERIKA, 6, 6, LEFT, GREEN
	endcallback
.SundayNight
	rematch 3, SABRINA, 6, 4, DOWN, RED
	endcallback

.Monday
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .MondayNight
.MondayMorningAndDay
	rematch 1, FALKNER, 3, 5, RIGHT, BLUE
	rematch 2, JANINE, 6, 5, LEFT, PURPLE
	endcallback
.MondayNight
	checkevent EVENT_BEAT_WALKER
	iffalsefwd .NoWalker
	rematch 3, WALKER, 8, 4, DOWN, BLUE
.NoWalker
	endcallback

.Tuesday
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .TuesdayNight
.TuesdayMorningAndDay
	rematch 1, PRYCE, 3, 6, RIGHT, BROWN
	rematch 2, BLAINE, 6, 6, LEFT, BROWN
	endcallback
.TuesdayNight
	checkevent EVENT_BEAT_LORELEI_AGAIN
	iffalsefwd .NoLorelei
	rematch 3, LORELEI, 6, 4, DOWN, RED
.NoLorelei
	endcallback

.Wednesday
	checktime 1 << MORN
	iftruefwd .WednesdayMorning
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .WednesdayNight
.WednesdayDay
	rematch 1, BROCK, 3, 7, RIGHT, BROWN
	rematch 2, MISTY, 3, 5, RIGHT, ORANGE
	rematch 3, BLUE, 6, 6, LEFT, BLUE
	endcallback
.WednesdayMorning
	rematch 1, BROCK, 3, 5, RIGHT, BROWN
	rematch 2, MISTY, 6, 5, LEFT, ORANGE
	endcallback
.WednesdayNight
	rematch 3, BLUE, 8, 4, DOWN, BLUE
	endcallback

.Thursday
	checktime 1 << MORN
	iftruefwd .ThursdayMorning
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .ThursdayNight
.ThursdayDay
	checkevent EVENT_BEAT_PALMER
	iffalsefwd .NoPalmer
	rematch 3, PALMER, 3, 6, DOWN, GREEN
.NoPalmer
	endcallback
.ThursdayMorning
	rematch 1, BUGSY, 1, 6, DOWN, GREEN
	endcallback
.ThursdayNight
	rematch 2, MORTY, 2, 4, DOWN, BROWN
	endcallback

.Friday
	checktime 1 << MORN
	iftruefwd .FridayMorning
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .FridayNight
.FridayDay
	checkevent EVENT_BEAT_YELLOW
	iffalsefwd .NoYellow
	rematch 3, YELLOW, 6, 6, DOWN, ORANGE
.NoYellow
	endcallback
.FridayMorning
	rematch 1, SURGE, 6, 7, DOWN, BROWN
	endcallback
.FridayNight
	rematch 2, CLAIR, 2, 6, RIGHT, BLUE
	endcallback

.Saturday
	checktime 1 << MORN
	iftruefwd .SaturdayMorning
	checktime (1 << EVE) | (1 << NITE)
	iftruefwd .SaturdayNight
.SaturdayDay
	rematch 1, WHITNEY, 3, 6, RIGHT, RED
	rematch 2, CHUCK, 6, 6, LEFT, BROWN
	endcallback
.SaturdayMorning
	rematch 1, WHITNEY, 3, 6, RIGHT, RED
	endcallback
.SaturdayNight
	checkevent EVENT_BEAT_AGATHA
	iffalsefwd .NoAgatha
	rematch 3, AGATHA, 2, 4, DOWN, BROWN
.NoAgatha
	endcallback

FightingDojoBlackBelt:
	checkevent EVENT_BEAT_BLUE
	iftrue_jumptextfaceplayer BlackBeltText_ExplainsRematches
	jumpthistextfaceplayer

	text "Hallo!"

	para "Der Karate-"
	line "Meister, der"

	para "Leiter des Karate"
	line "Dojo, übt in einer"
	cont "Höhle in Johto."
	done

MapFightingDojoSignpost2Script:
	opentext
	writetext FightingDojoScheduleQuestionText
	yesorno
	iffalse_endtext
.sunday
	writetext FightingDojoScheduleSundayText
	waitbutton
.monday
	checkevent EVENT_BEAT_WALKER
	iftruefwd .monday_walker
	writetext FightingDojoScheduleMondayText
	waitbutton
	sjumpfwd .tuesday
.monday_walker
	writetext FightingDojoScheduleMondayWalkerText
	waitbutton
.tuesday
	checkevent EVENT_BEAT_LORELEI_AGAIN
	iftruefwd .tuesday_lorelei
	writetext FightingDojoScheduleTuesdayText
	waitbutton
	sjumpfwd .wednesday
.tuesday_lorelei
	writetext FightingDojoScheduleTuesdayLoreleiText
	waitbutton
.wednesday
	writetext FightingDojoScheduleWednesdayText
	waitbutton
.thursday
	checkevent EVENT_BEAT_PALMER
	iftruefwd .thursday_palmer
	writetext FightingDojoScheduleThursdayText
	waitbutton
	sjumpfwd .friday
.thursday_palmer
	writetext FightingDojoScheduleThursdayPalmerText
	waitbutton
.friday
	checkevent EVENT_BEAT_YELLOW
	iftruefwd .friday_yellow
	writetext FightingDojoScheduleFridayText
	waitbutton
	sjumpfwd .saturday
.friday_yellow
	writetext FightingDojoScheduleFridayYellowText
	waitbutton
.saturday
	checkevent EVENT_BEAT_AGATHA
	iftruefwd .saturday_agatha
	jumpthisopenedtext

	text "Samstag: Bianka,"
	line "Hartwig, ???"
	done
.saturday_agatha
	jumpthisopenedtext

	text "Samstag: Bianka,"
	line "Hartwig, Agathe"
	done

BlackBeltText_ExplainsRematches:
	text "Arenaleiter aus"
	line "Kanto und Johto"

	para "trainieren in"
	line "diesem Karate"
	cont "Dojo."

	para "Mach doch mit!"
	done

FightingDojoSign1Text:
	text "Es geschieht, was"
	line "geschehen muss!"
	done

FightingDojoSign2Text:
	text "Feinde, wo man"
	line "hinsieht!"
	done

MACRO rematch_script
	; rematch_script name, trainer, flag
	checkflag ENGINE_GYM_LEADER_REMATCH_\3
	iftrue_jumptextfaceplayer \1Text_Done
	faceplayer
	showtext \1Text_Greeting
	winlosstext \1Text_WinLoss, 0
	loadtrainer \2, 2
	startbattle
	reloadmapafterbattle
	setflag ENGINE_GYM_LEADER_REMATCH_\3
	end
ENDM

FightingDojoRematch1Script:
	readvar VAR_WEEKDAY
	ifequalfwd MONDAY, .Falkner
	ifequalfwd TUESDAY, .Pryce
	ifequalfwd WEDNESDAY, .Brock
	ifequalfwd THURSDAY, .Bugsy
	ifequalfwd FRIDAY, .Surge
	ifequalfwd SATURDAY, .Whitney

.Jasmine
	rematch_script Jasmine, JASMINE, 1

.Falkner
	rematch_script Falkner, FALKNER, 1

.Pryce
	rematch_script Pryce, PRYCE, 1

.Brock
	rematch_script Brock, BROCK, 1

.Bugsy
	rematch_script Bugsy, BUGSY, 1

.Surge
	rematch_script Surge, LT_SURGE, 1

.Whitney
	rematch_script Whitney, WHITNEY, 1

FightingDojoRematch2Script:
	readvar VAR_WEEKDAY
	ifequalfwd MONDAY, .Janine
	ifequalfwd TUESDAY, .Blaine
	ifequalfwd WEDNESDAY, .Misty
	ifequalfwd THURSDAY, .Morty
	ifequalfwd FRIDAY, .Clair
	ifequalfwd SATURDAY, .Chuck

.Erika
	rematch_script Erika, ERIKA, 2

.Janine
	rematch_script Janine, JANINE, 2

.Blaine
	rematch_script Blaine, BLAINE, 2

.Misty
	rematch_script Misty, MISTY, 2

.Morty
	rematch_script Morty, MORTY, 2

.Clair
	rematch_script Clair, CLAIR, 2

.Chuck
	rematch_script Chuck, CHUCK, 2

FightingDojoRematch3Script:
	readvar VAR_WEEKDAY
	ifequalfwd MONDAY, .Walker
	ifequalfwd TUESDAY, .Lorelei
	ifequalfwd WEDNESDAY, .Blue
	ifequalfwd THURSDAY, .Palmer
	ifequalfwd FRIDAY, .Yellow
	ifequalfwd SATURDAY, .Agatha

.Sabrina
	rematch_script Sabrina, SABRINA, 3

.Walker
	rematch_script Walker, WALKER, 3

.Lorelei
	rematch_script Lorelei, LORELEI, 3

.Blue
	rematch_script Blue, BLUE, 3

.Palmer
	rematch_script Palmer, TOWERTYCOON, 3

.Yellow
	rematch_script Yellow, YELLOW, 3

.Agatha
	rematch_script Agatha, AGATHA, 3

BrockText_Greeting:
	text "Am liebsten mag"
	line "ich #mon vom"
	cont "Typ Gestein."

	para "Sie sind fest und"
	line "rau, aber zugleich"
	cont "spröde."

	para "Du wirst sehen,"
	line "wie viel stärker"

	para "meine Gesteins-"
	line "#mon geworden"
	cont "sind!"
	done

MistyText_Greeting:
	text "Seit unserem"
	line "letzten Kampf"

	para "habe ich viel"
	line "Gutes über dich"
	cont "gehört."

	para "Lass mich testen,"
	line "wie gut du bist!"
	done

SurgeText_Greeting:
	text "Ich spüre gewal-"
	line "tige elektrische"

	para "Kraft am Magnet-"
	line "zug-Bahnhof!"

	para "Ich freue mich auf"
	line "einen elektrisie-"
	cont "renden Kampf!"
	done

ErikaText_Greeting:
	text "Schön, dich wie-"
	line "derzusehen!"

	para "Wie geht es dir?"

	para "Dieser Ort passt"
	line "nicht so recht zu"
	cont "mir, aber…"

	para "vergessen wir das"
	line "und kämpfen!"
	done

JanineText_Greeting:
	text "Meine Ninja-Tech-"
	line "nik kann ich hier"
	cont "nicht einsetzen,"

	para "aber gewinnen"
	line "lasse ich dich"
	cont "nicht!"
	done

SabrinaText_Greeting:
	text "Ich wusste, dass"
	line "du wieder gegen"
	cont "mich kämpfst."

	para "Ich hatte so ein"
	line "Gefühl."
	done

BlaineText_Greeting:
	text "Meine Arena ist"
	line "noch immer weg,"

	para "also tragen wir"
	line "den Rückkampf"
	cont "hier aus!"
	done

BlueText_Greeting:
	text "Gut! Du bist auch"
	line "hier."

	para "Danke, dass du zum"
	line "Verlieren gekommen"
	cont "bist!"
	done

FalknerText_Greeting:
	text "Ich bin heute in"
	line "Topform."

	para "Es ist mir eine"
	line "Freude, wieder"
	cont "gegen dich zu"
	cont "kämpfen!"
	done

BugsyText_Greeting:
	text "Schön, dich wie-"
	line "derzusehen! Sieh"
	cont "dir meine Käfer-"
	cont "Forschung an!"
	done

WhitneyText_Greeting:
	text "Hi, <PLAYER>!"
	line "Wo wir schon"

	para "beide hier sind,"
	line "lass uns kämpfen!"

	para "Bist du bereit?"
	done

MortyText_Greeting:
	text "Die legendären"
	line "#mon haben mich"
	cont "nicht erwählt…"

	para "Aber das heißt"
	line "nicht, dass ich"

	para "keine Zukunft"
	line "habe. Kämpfen wir!"
	done

ChuckText_Greeting:
	text "Da bist du ja!"

	para "Spüre die Kraft"
	line "meines 24-Stunden-"
	cont "Trainings!"
	done

JasmineText_Greeting:
	text "Hallo, <PLAYER>…"
	line "Wie geht es dir?"
	cont "Mir geht es gut…"

	para "Wie dem auch sei,"
	line "bist du bereit für"
	cont "einen Rückkampf?"
	done

PryceText_Greeting:
	text "Keine Worte nötig."
	line "Ein #mon-Kampf"

	para "ist unsere Art,"
	line "uns zu verstän-"
	cont "digen."
	done

ClairText_Greeting:
	text "…Du bist also da."

	para "Jetzt lass uns"
	line "kämpfen!"
	done

PalmerText_Greeting:
	text "Du bist also so"
	line "weit gekommen!"

	para "Als Turm-Tycoon"
	line "muss ich dir"

	para "mein Bestes"
	line "geben."

	para "So zeigen die"
	line "besten Trainer"

	para "einander Respekt."

	para "Indem sie mit"
	line "vollem Einsatz"

	para "als treue Schüler"
	line "der #mon"
	cont "kämpfen!"
	done

LoreleiText_Greeting:
	text "Hallo noch mal,"
	line "<PLAYER>."

	para "Jetzt sind wir auf"
	line "meinem Terrain."

	para "Ich verliere"
	line "nicht!"
	done

AgathaText_Greeting:
	text "Hallo, Kind."

	para "Füllst du immer"
	line "noch einen #dex"

	para "für diesen alten"
	line "Trottel Eich?"

	para "#mon sind zum"
	line "Kämpfen da!"

	para "Zeig mir dein"
	line "wahres Talent"
	cont "als Trainer!"
	done

WalkerText_Greeting:
	text "Hallo,"
	line "<PLAYER>!"

	para "Ich habe meinen"
	line "Sohn Falk hier"

	para "wohl gerade"
	line "verpasst…"

	para "Wie wär's, wenn"
	line "wir stattdessen"
	cont "kämpfen?"
	done

YellowText_Greeting:
	text "Hi, <PLAYER>!"

	para "Mal sehen…"

	para "Ja! Du kümmerst"
	line "dich immer noch"
	cont "gut um deine"
	cont "#mon!"

	para "Du bist stärker"
	line "geworden, aber"
	cont "ich auch!"
	done

BrockText_WinLoss:
	text "Ich habe wieder"
	line "verloren…"

	para "Du bist nicht um-"
	line "sonst auf Reisen!"
	done

MistyText_WinLoss:
	text "Wow! Du wirst mit"
	line "jedem Kampf"
	cont "stärker!"
	done

SurgeText_WinLoss:
	text "Du bist sehr"
	line "stark!"

	para "Aber eines Tages"
	line "revanchiere ich"
	cont "mich!"
	done

ErikaText_WinLoss:
	text "Du bist noch"
	line "stärker geworden…"
	done

JanineText_WinLoss:
	text "Heute habe ich"
	line "verloren, aber"
	cont "nächstes Mal"
	cont "gewinne ich!"
	done

SabrinaText_WinLoss:
	text "Ich weiß… wir"
	line "sehen uns irgend-"
	cont "wann wieder."
	done

BlaineText_WinLoss:
	text "Waaah! Ich bin"
	line "schon wieder aus-"
	cont "gebrannt!"
	done

BlueText_WinLoss:
	text "Genau wie ich"
	line "dachte!"

	para "Kein Wunder, dass"
	line "du Champ geworden"
	cont "bist…"
	done

FalknerText_WinLoss:
	text "Mmm… Der Weg zum"
	line "besten Trainer ist"
	cont "noch weit…"
	done

BugsyText_WinLoss:
	text "Du musst viel"
	line "über #mon"
	cont "gelernt haben!"
	done

WhitneyText_WinLoss:
	text "Du bist echt"
	line "stark!"

	para "Aber beim nächsten"
	line "Mal verliere ich"
	cont "nicht!"
	done

MortyText_WinLoss:
	text "Ich habe wieder"
	line "verloren… Du hast"

	para "mehr als nur"
	line "Stärke."
	done

ChuckText_WinLoss:
	text "Wahaha!"
	line "Mit dir wird ein"
	cont "Kampf nie öde!"
	done

JasmineText_WinLoss:
	text "Du wirst deinem"
	line "Ruf gerecht…"
	done

PryceText_WinLoss:
	text "Hmm… Beachtlich!"
	done

ClairText_WinLoss:
	text "Gut gemacht."
	line "…"

	para "Jetzt gib alles!"
	done

PalmerText_WinLoss:
	text "Bravo! Das hat"
	line "mein Herz"
	cont "beflügelt!"
	done

LoreleiText_WinLoss:
	text "Wie kannst du es"
	line "wagen!"
	done

AgathaText_WinLoss:
	text "Juhuu!"
	done

WalkerText_WinLoss:
	text "Ich bin kein"
	line "Gegner für dich!"
	done

YellowText_WinLoss:
	text "Hahaha!"
	done

BrockText_Done:
MistyText_Done:
SurgeText_Done:
ErikaText_Done:
JanineText_Done:
SabrinaText_Done:
BlaineText_Done:
BlueText_Done:
FalknerText_Done:
BugsyText_Done:
WhitneyText_Done:
MortyText_Done:
ChuckText_Done:
JasmineText_Done:
PryceText_Done:
ClairText_Done:
PalmerText_Done:
LoreleiText_Done:
AgathaText_Done:
WalkerText_Done:
YellowText_Done:
	text "Für heute habe ich"
	line "genug gekämpft."
	done

FightingDojoScheduleQuestionText:
	text "Ein Trainingsplan!"
	line "Lesen?"
	done

FightingDojoScheduleSundayText:
	text "Sonntag: Jasmin,"
	line "Erika, Sabrina"
	done

FightingDojoScheduleMondayText:
	text "Montag: Falk,"
	line "Janina, ???"
	done

FightingDojoScheduleMondayWalkerText:
	text "Montag: Falk,"
	line "Janina, Luc"
	done

FightingDojoScheduleTuesdayText:
	text "Dienstag: Norbert,"
	line "Pyro, ???"
	done

FightingDojoScheduleTuesdayLoreleiText:
	text "Dienstag: Norbert,"
	line "Pyro, Lorelei"
	done

FightingDojoScheduleWednesdayText:
	text "Mittwoch: Rocko,"
	line "Misty, Blau"
	done

FightingDojoScheduleThursdayText:
	text "Donnerstag: Kai,"
	line "???, Jens"
	done

FightingDojoScheduleThursdayPalmerText:
	text "Donnerstag: Kai,"
	line "Viktor, Jens"
	done

FightingDojoScheduleFridayText:
	text "Freitag:"
	line "Major Bob, ???,"
	cont "Sandra"
	done

FightingDojoScheduleFridayYellowText:
	text "Freitag:"
	line "Major Bob, Gelb,"
	cont "Sandra"
	done
