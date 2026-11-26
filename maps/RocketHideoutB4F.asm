RocketHideoutB4F_MapScriptHeader:
	def_scene_scripts
	scene_script RocketHideoutB4FMeetLeadersScene, SCENE_ROCKETHIDEOUTB4F_MEET_LEADERS
	scene_script RocketHideoutB4FMetLeadersScene, SCENE_ROCKETHIDEOUTB4F_MET_LEADERS
	scene_const SCENE_ROCKETHIDEOUTB4F_NOOP

	def_callbacks
	callback MAPCALLBACK_OBJECTS, RocketHideoutB4FLiftKeyScript
	callback MAPCALLBACK_TILES, RocketHideoutB4FDoorScript

	def_warp_events
	warp_event 11, 10, ROCKET_HIDEOUT_B3F, 2
	warp_event 16, 15, ROCKET_HIDEOUT_ELEVATOR, 1
	warp_event 17, 15, ROCKET_HIDEOUT_ELEVATOR, 1

	def_coord_events
	coord_event 16, 11, SCENE_ROCKETHIDEOUTB4F_MEET_LEADERS, RocketHideoutB4FMeetLeadersLeftScript
	coord_event 17, 11, SCENE_ROCKETHIDEOUTB4F_MEET_LEADERS, RocketHideoutB4FMeetLeadersRightScript

	def_bg_events
	bg_event 17,  1, BGEVENT_ITEM + MAX_POTION, EVENT_ROCKET_HIDEOUT_B4F_HIDDEN_MAX_POTION

	def_object_events
	object_event 17,  3, SPRITE_CANDELA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, RocketHideoutB4FCandelaScript, -1
	object_event 16,  6, SPRITE_SPARK, SPRITEMOVEDATA_STANDING_UP, 0, 0, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, RocketHideoutB4FSparkScript, -1
	object_event 19,  6, SPRITE_BLANCHE, SPRITEMOVEDATA_STANDING_UP, 0, 0, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, RocketHideoutB4FBlancheScript, -1
	object_event  3,  2, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketHideoutB4FYoungsterArdenScript, -1
	object_event 15, 12, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_TRAINER, 2, RocketHideoutB4FTeacherSerena, -1
	object_event 18, 12, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_TRAINER, 2, RocketHideoutB4FSuperNerdNolan, -1
	keyitemball_event 2,  2, LIFT_KEY, EVENT_ROCKET_HIDEOUT_B4F_LIFT_KEY
	itemball_event 1,  4, X_SP_ATK,    1, EVENT_ROCKET_HIDEOUT_B4F_X_SP_ATK
	itemball_event 2, 12, PP_UP,        1, EVENT_ROCKET_HIDEOUT_B4F_PP_UP
	itemball_event 4, 20, DUBIOUS_DISC, 1, EVENT_ROCKET_HIDEOUT_B4F_DUBIOUS_DISC

	object_const_def
	const ROCKETHIDEOUTB4F_CANDELA
	const ROCKETHIDEOUTB4F_SPARK
	const ROCKETHIDEOUTB4F_BLANCHE
	const ROCKETHIDEOUTB4F_YOUNGSTER_ARDEN
	const ROCKETHIDEOUTB4F_TEACHER_SERENA
	const ROCKETHIDEOUTB4F_SUPER_NERD_NOLAN
	const ROCKETHIDEOUTB4F_LIFT_KEY

RocketHideoutB4FDoorScript:
	checkevent EVENT_BEAT_TEACHER_SERENA
	iftruefwd .beat_serena
	changeblock 16, 10, $07
	endcallback
.beat_serena
	checkevent EVENT_BEAT_SUPER_NERD_NOLAN
	iftruefwd .beat_theo
	changeblock 16, 10, $07
	endcallback
.beat_theo
	changeblock 16, 10, $0d
	endcallback

RocketHideoutB4FLiftKeyScript:
	checkevent EVENT_BEAT_YOUNGSTER_ARDEN
	iftruefwd .beat_arden
	disappear ROCKETHIDEOUTB4F_LIFT_KEY
.beat_arden
	endcallback

RocketHideoutB4FMeetLeadersLeftScript:
	checktime (1 << EVE) | (1 << NITE)
	iffalse TooEarly
	applymovement PLAYER, .MovePlayerUp
	sjumpfwd RocketHideoutB4FMeetLeadersScript

.MovePlayerUp:
	step_up
	step_up
	step_up
	step_up
	step_right
	turn_head_up
	step_end

RocketHideoutB4FMeetLeadersRightScript:
	checktime (1 << EVE) | (1 << NITE)
	iffalse TooEarly
	applymovement PLAYER, .MovePlayerUp
	sjumpfwd RocketHideoutB4FMeetLeadersScript

.MovePlayerUp:
	step_up
	step_up
	step_up
	step_up
	step_end

RocketHideoutB4FMeetLeadersScript:
	setscene SCENE_ROCKETHIDEOUTB4F_MET_LEADERS
	showtext .CandelaIntro1Text
	turnobject ROCKETHIDEOUTB4F_SPARK, RIGHT
	showtext .BlancheIntro1Text
	turnobject ROCKETHIDEOUTB4F_BLANCHE, LEFT
	turnobject ROCKETHIDEOUTB4F_SPARK, UP
	pause 20
	turnobject ROCKETHIDEOUTB4F_SPARK, RIGHT
	showtext .SparkIntro1Text
	turnobject ROCKETHIDEOUTB4F_SPARK, UP
	turnobject ROCKETHIDEOUTB4F_BLANCHE, UP
	showtext .CandelaIntro2Text
	turnobject ROCKETHIDEOUTB4F_SPARK, RIGHT
	showtext .BlancheIntro2Text
	turnobject ROCKETHIDEOUTB4F_BLANCHE, LEFT
	turnobject ROCKETHIDEOUTB4F_SPARK, UP
	showtext .SparkIntro2Text
	turnobject ROCKETHIDEOUTB4F_SPARK, DOWN
	showtext .SparkIntro3Text
	turnobject ROCKETHIDEOUTB4F_BLANCHE, DOWN
	showtext .CandelaIntro3Text
	setmapobjectmovedata ROCKETHIDEOUTB4F_SPARK, SPRITEMOVEDATA_STANDING_DOWN
	setmapobjectmovedata ROCKETHIDEOUTB4F_BLANCHE, SPRITEMOVEDATA_STANDING_DOWN
	end


.CandelaIntro1Text:
	text "Candela: Ich sag's"
	line "euch, rohe Kraft"
	cont "siegt jedes Mal!"

	para "Training muss hart"
	line "sein, wie ein"
	cont "Kampf!"
	done

.BlancheIntro1Text:
	text "Blanche: Stärke"
	line "ist ohne Strate-"
	cont "gie sinnlos."

	para "Kluge Planung"
	line "siegt, jedes Mal."
	done

.SparkIntro1Text:
	text "Spark: Ihr beide"
	line "liegt falsch!"

	para "Auf den Instinkt"
	line "kommt's an! Hört"
	cont "auf euren Bauch!"
	done

.CandelaIntro2Text:
	text "Candela: Instinkt?"
	line "Das ist doch nur"
	cont "Raterei!"

	para "Echte Trainer"
	line "setzen auf Kraft!"
	done

.BlancheIntro2Text:
	text "Blanche: Candela,"
	line "Spark, dafür ist"
	cont "jetzt keine Zeit!"

	para "Was ist mit dem"
	line "Projekt am Großen"
	cont "Baum?"
	done

.SparkIntro2Text:
	text "Spark: Genau! Der"
	line "große Kirschbaum…"
	done

.SparkIntro3Text:
	text "Moment, wer ist"
	line "das denn?"
	done

.CandelaIntro3Text:
	text "Candela: Sieht"
	line "aus, als hättest"
	cont "du Kraft!"

	para "Wo du schon so"
	line "weit gekommen"
	cont "bist: Kämpfen wir!"

	para "Gewinnst du, wei-"
	line "hen wir dich in"
	cont "unser großes"
	cont "Projekt ein!"
	done

RocketHideoutB4FMeetLeadersScene:
RocketHideoutB4FMetLeadersScene:
TooEarly:
	end


RocketHideoutB4FSparkScript:
	faceplayer
	checkevent EVENT_BEAT_SPARK
	iftrue_jumptext .AfterText2
	opentext
	writetext .GreetingText
	yesorno
	iffalsefwd .Refused
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer SPARK_T, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_SPARK
	opentext
	writetext .AfterText1
	waitbutton
	verbosegivekeyitem MALIGN_LURE
	writetext .AfterText2
	waitbutton
	checkevent EVENT_BEAT_CANDELA
	iffalse_endtext
	checkevent EVENT_BEAT_BLANCHE
	iffalse_endtext
	sjump RocketHideoutB4FDefeatedAllLeadersScript

.Refused:
	jumpopenedtext .RefusedText

.GreetingText:
	text "Spark: Hey! Hörst"
	line "du auf deinen"
	cont "Bauch? Im Kampf?"
	done

.SeenText:
	text "Super! Mal sehen,"
	line "wie weit dich dein"
	cont "Instinkt bringt!"
	done

.BeatenText:
	text "Wow, das hast du"
	line "voll drauf!"

	para "Dein Bauchgefühl"
	line "lag wohl richtig!"
	done

.AfterText1:
	text "Spark: Hier ist"
	line "das Unheilparfüm."
	done

.AfterText2:
	text "Das Unheilparfüm"
	line "nutzt kühne"
	cont "Energie."

	para "So entfache ich"
	line "den Funken der"
	cont "Kreativität!"

	para "Setz es kühn ein!"
	done

.RefusedText:
	text "Och, schade!"
	line "Lass dich nicht"
	cont "von Angst bremsen!"

	para "Komm wieder, wenn"
	line "du es spürst."
	done

RocketHideoutB4FCandelaScript:
	faceplayer
	checkevent EVENT_BEAT_CANDELA
	iftrue_jumptext .AfterText2
	opentext
	writetext .GreetingText
	yesorno
	iffalsefwd .Refused
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer CANDELA, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CANDELA
	opentext
	writetext .AfterText1
	waitbutton
	verbosegivekeyitem HARSH_LURE
	writetext .AfterText2
	waitbutton
	checkevent EVENT_BEAT_SPARK
	iffalse_endtext
	checkevent EVENT_BEAT_BLANCHE
	iffalse_endtext
	sjump RocketHideoutB4FDefeatedAllLeadersScript

.Refused:
	jumpopenedtext .RefusedText

.GreetingText:
	text "Candela: Bereit,"
	line "deine Stärke zu"
	cont "testen?"
	done

.SeenText:
	text "So ist's recht!"
	line "Zeig mir deine"
	cont "Kraft!"
	done

.BeatenText:
	text "Na gut, du hast"
	line "heute deine Stärke"
	cont "bewiesen."

	para "Ich gebe mich"
	line "geschlagen."
	done

.AfterText1:
	text "Candela: Hier ist"
	line "das Herbparfüm."
	done

.AfterText2:
	text "Candela: Das"
	line "Herbparfüm nutzt"
	cont "wilde Kraft."

	para "Das ist mein Bei-"
	line "trag zu unserem"
	cont "Projekt."

	para "Setz es weise ein."
	done

.RefusedText:
	text "Nein? Du bist wohl"
	line "noch nicht so"
	cont "weit."

	para "Komm wieder, wenn"
	line "du mehr Feuer"
	cont "hast!"
	done

RocketHideoutB4FBlancheScript:
	faceplayer
	checkevent EVENT_BEAT_BLANCHE
	iftrue_jumptext .AfterText2
	opentext
	writetext .GreetingText
	yesorno
	iffalsefwd .Refused
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer BLANCHE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BLANCHE
	opentext
	writetext .AfterText1
	waitbutton
	verbosegivekeyitem POTENT_LURE
	writetext .AfterText2
	waitbutton
	checkevent EVENT_BEAT_SPARK
	iffalse_endtext
	checkevent EVENT_BEAT_CANDELA
	iffalse_endtext
	sjump RocketHideoutB4FDefeatedAllLeadersScript

.Refused:
	jumpopenedtext .RefusedText

.GreetingText:
	text "Blanche: Ist dir"
	line "Strategie wichtig?"

	para "Sollen wir deine"
	line "Taktik testen?"
	done

.SeenText:
	text "Nun gut, zeig mir"
	line "deine Technik!"
	done

.BeatenText:
	text "Ein gut umgesetz-"
	line "ter Plan, fürwahr."

	para "Du hast mich"
	line "besiegt."
	done

.AfterText1:
	text "Blanche: Das ist"
	line "das Kraftparfüm."
	done

.AfterText2:
	text "Das Kraftparfüm"
	line "verstärkt seine"
	cont "Präzision."

	para "Das ist mein Bei-"
	line "trag zu unserem"
	cont "Erfolg."

	para "Setz es mit Be-"
	line "dacht ein."
	done

.RefusedText:
	text "Hmm, fehlt dir das"
	line "Selbstvertrauen?"

	para "Komm wieder, wenn"
	line "du bereit bist,"
	cont "vorauszudenken."
	done

RocketHideoutB4FYoungsterArdenScript:
	faceplayer
	checkevent EVENT_BEAT_YOUNGSTER_ARDEN
	iftruefwd .AfterBattle
	showtext .GreetingText
	winlosstext .BeatenText, 0
	loadtrainer YOUNGSTER, ARDEN
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_YOUNGSTER_ARDEN
	readvar VAR_FACING
	ifnotequal RIGHT, .NotLeftOfArden
	moveobject ROCKETHIDEOUTB4F_LIFT_KEY, 4, 2
.NotLeftOfArden
	appear ROCKETHIDEOUTB4F_LIFT_KEY
.AfterBattle
	showtext .AfterText
	end

.GreetingText
	text "Team Wagemut ist…"

	para "Moment… nein!"

	para "Ich meine, ich hab"
	line "mich verlaufen!"
	done

.BeatenText:
	text "Wo war noch mal"
	line "der Aufzug?"
	done

.AfterText:
	text "Ooch, ich habe den"
	line "Liftöffner fallen"
	cont "lassen!"

	para "Candela wird so"
	line "sauer sein!"
	done

RocketHideoutB4FTeacherSerena:
	trainer TEACHER_F, SERENA, EVENT_BEAT_TEACHER_SERENA, .SeenText, .AfterText, 0, .Script

.Script
	checkevent EVENT_BEAT_TEACHER_SERENA
	iftruefwd .AfterScript
	jumpthistextfaceplayer

.AfterScript
	checkevent EVENT_BEAT_SUPER_NERD_NOLAN
	iftruefwd .DoorScript
	endifjustbattled
	jumptextfaceplayer .AfterText
	end

.DoorScript
	checkjustbattled
	iffalsefwd .skip_open
	changeblock 16, 10, $0d
	playsound SFX_ENTER_DOOR
	waitsfx
	refreshmap
	special RestartMapMusic
	end
.skip_open
	jumptextfaceplayer .AfterText
	end

.AfterText
	text "Die Teamleiter"
	line "sind nur nachts"
	cont "hier."

	para "Tagsüber arbeiten"
	line "sie an der Uni."
	done

.SeenText:
	text "Lass mich heraus-"
	line "finden, ob du klug"

	para "genug bist, um ge-"
	line "gen die Teamleiter"
	cont "anzutreten!"
	done

.BeatenText:
	text "Der Unterricht"
	line "ist beendet!"
	done

RocketHideoutB4FSuperNerdNolan:
	trainer TEACHER_M, NOLAN, EVENT_BEAT_SUPER_NERD_NOLAN, .SeenText, .AfterText, 0, .Script

.Script
	checkevent EVENT_BEAT_SUPER_NERD_NOLAN
	iftruefwd .AfterScript
	jumpthistextfaceplayer

.AfterScript
	checkevent EVENT_BEAT_TEACHER_SERENA
	iftruefwd .DoorScript
	endifjustbattled
	jumptextfaceplayer .AfterText
	end

.DoorScript
	checkjustbattled
	iffalsefwd .skip_open
	changeblock 16, 10, $0d
	playsound SFX_ENTER_DOOR
	waitsfx
	refreshmap
	special RestartMapMusic
	end
.skip_open
	jumptextfaceplayer .AfterText
	end

.AfterText
	text "Die Teamleiter"
	line "streiten viel,"
	cont "aber sie sind"
	cont "gute Freunde."
	done

.SeenText:
	text "Willst du die"
	line "Teamleiter heraus-"
	cont "fordern?"

	para "Dann musst du erst"
	line "mich besiegen!"
	done

.BeatenText:
	text "Ich hab versagt!"
	done

RocketHideoutB4FDefeatedAllLeadersScript:
	closetext
	special FadeOutPalettes
	warpfacing UP, ROCKET_HIDEOUT_B4F, 17, 7
	turnobject ROCKETHIDEOUTB4F_SPARK, DOWN
	turnobject ROCKETHIDEOUTB4F_BLANCHE, DOWN
	special LoadMapPalettes
	special FadeInPalettes_EnableDynNoApply
	showtext .FinalText
	end

.FinalText:
	text "Candela: Du bist"
	line "stärker als"
	cont "erwartet."

	para "Die Parfüms, die"
	line "wir dir gaben,"
	cont "sind mehr, als sie"
	cont "scheinen."

	para "Blanche: Jedes"
	line "Parfüm enthält"

	para "die Essenz eines"
	line "legendären Vogel-"
	cont "#mon."

	para "Sie sollen andere"
	line "ihrer Art herbei-"
	cont "rufen."

	para "Spark: Aber sie"
	line "nützen nur am"
	cont "richtigen Ort."

	para "Darum ist der"
	line "Große Baum"
	cont "wichtig."

	para "Candela: Der Baum"
	line "ist uralt,"

	para "ein heiliger"
	line "Nistplatz."

	para "Er ist mit der"
	line "Energie der Region"
	cont "verbunden."

	para "Blanche: Vögel von"
	line "großer Kraft"

	para "versammeln sich"
	line "dort seit Genera-"
	cont "tionen."

	para "Der Baum verstärkt"
	line "den Ruf der"
	cont "Parfüms."

	para "Spark: Benutzt du"
	line "sie also dort,"

	para "wer weiß, was dann"
	line "erscheint!"
	done
