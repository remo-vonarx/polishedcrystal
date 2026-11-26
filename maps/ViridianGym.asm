ViridianGym_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6, 43, VIRIDIAN_CITY, 1
	warp_event  7, 43, VIRIDIAN_CITY, 1

	def_coord_events

	def_bg_events
	bg_event  4, 41, BGEVENT_READ, ViridianGymStatue
	bg_event  9, 41, BGEVENT_READ, ViridianGymStatue

	def_object_events
	object_event  7,  2, SPRITE_BLUE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianGymBlueScript, EVENT_VIRIDIAN_GYM_BLUE
	object_event  8, 41, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ViridianGymGuyScript, EVENT_VIRIDIAN_GYM_BLUE
	object_event  7, 33, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoAraandbela1, -1
	object_event  6, 33, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoAraandbela2, -1
	object_event  3, 32, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCooltrainerfSalma, -1
	object_event  3, 18, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCooltrainerfBonita, -1
	object_event  6,  8, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoElanandida1, -1
	object_event  7,  8, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerAceDuoElanandida2, -1

ViridianGymBlueScript:
	faceplayer
	opentext
	checkflag ENGINE_EARTHBADGE
	iftruefwd .FightDone
	writetext LeaderBlueBeforeText
	waitbutton
	closetext
	winlosstext LeaderBlueWinText, 0
	loadtrainer BLUE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BLUE
	setevent EVENT_BEAT_ACE_DUO_ARA_AND_BELA
	setevent EVENT_BEAT_COOLTRAINERF_SALMA
	setevent EVENT_BEAT_COOLTRAINERF_BONITA
	setevent EVENT_BEAT_ACE_DUO_ELAN_AND_IDA
	opentext
	givebadge EARTHBADGE, KANTO_REGION
	setevent EVENT_FINAL_BATTLE_WITH_LYRA
.FightDone:
	checkevent EVENT_GOT_TM71_STONE_EDGE
	iftrue_jumpopenedtext LeaderBlueEpilogueText
	writetext LeaderBlueAfterText
	promptbutton
	verbosegivetmhm TM_STONE_EDGE
	setevent EVENT_GOT_TM71_STONE_EDGE
	jumpthisopenedtext

	text "Sie enthält Stein-"
	line "kante. Die ist"

	para "nicht nur für"
	line "Gestein-#mon,"
	cont "kapiert?"

	para "…"

	para "Na gut, ich habe"
	line "mich geirrt. Du"

	para "bist echt gut. Du"
	line "bist ein guter"
	cont "Trainer."

	para "Mit acht Orden aus"
	line "Kanto kannst du"

	para "die Top Vier"
	line "erneut heraus-"
	cont "fordern."

	para "Sie werden einen"
	line "Trainer, der zwei"
	cont "Regionen besiegt"
	cont "hat, nicht"
	cont "schonen."

	para "Montags kannst du"
	line "mit mir im Karate"

	para "Dojo in Saffronia"
	line "City trainieren."

	para "Alle Arenaleiter"
	line "kommen dorthin,"
	cont "um zu trainieren."

	para "Eines Tages werde"
	line "ich dich besiegen."

	para "Vergiss das"
	line "nicht!"
	done

ViridianGymGuyScript:
	checkevent EVENT_BEAT_BLUE
	iftrue_jumptextfaceplayer ViridianGymGuyWinText
	jumpthistextfaceplayer

	text "He! Ein Champ"
	line "in spe!"

	para "Wie läuft es so?"
	line "Du hast wohl"
	cont "gerade eine"
	cont "Glückssträhne."

	para "Der Arenaleiter"
	line "hat den Champ"

	para "vor drei Jahren"
	line "besiegt."

	para "Das wird kein"
	line "Kinderspiel!"

	para "Gib alles, was"
	line "du hast!"
	done

GenericTrainerAceDuoAraandbela1:
	generictrainer ACE_DUO, ARAANDBELA1, EVENT_BEAT_ACE_DUO_ARA_AND_BELA, AceDuoAraandbela1SeenText, AceDuoAraandbela1BeatenText

	text "Ara: Ich wäre"
	line "wohl ein ziemlich"
	cont "guter Trainings-"
	cont "partner…"
	done

GenericTrainerAceDuoAraandbela2:
	generictrainer ACE_DUO, ARAANDBELA2, EVENT_BEAT_ACE_DUO_ARA_AND_BELA, AceDuoAraandbela2SeenText, AceDuoAraandbela2BeatenText

	text "Bela: Unsere"
	line "Trainingskämpfe"
	cont "haben uns nicht"
	cont "darauf"
	cont "vorbereitet."
	done

GenericTrainerCooltrainerfSalma:
	generictrainer COOLTRAINERF, SALMA, EVENT_BEAT_COOLTRAINERF_SALMA, CooltrainerfSalmaSeenText, CooltrainerfSalmaBeatenText

	text "Es gibt viele"
	line "Arenen auf der"

	para "Welt, aber diese"
	line "mag ich wirklich!"
	done

GenericTrainerCooltrainerfBonita:
	generictrainer COOLTRAINERF, BONITA, EVENT_BEAT_COOLTRAINERF_BONITA, CooltrainerfBonitaSeenText, CooltrainerfBonitaBeatenText

	text "Sieht aus, als"
	line "hättest du noch"
	cont "Energie übrig."
	done

GenericTrainerAceDuoElanandida1:
	generictrainer ACE_DUO, ELANANDIDA1, EVENT_BEAT_ACE_DUO_ELAN_AND_IDA, AceDuoElanandida1SeenText, AceDuoElanandida1BeatenText

	text "Olli: Du bist"
	line "stärker als"
	cont "erwartet!"
	done

GenericTrainerAceDuoElanandida2:
	generictrainer ACE_DUO, ELANANDIDA2, EVENT_BEAT_ACE_DUO_ELAN_AND_IDA, AceDuoElanandida2SeenText, AceDuoElanandida2BeatenText

	text "Moni: Wenn du nur"
	line "Stärke hast,"
	cont "kommst du nicht"
	cont "weit."

	para "Strategie ist"
	line "auch wichtig!"
	done

ViridianGymStatue:
	gettrainername BLUE, 1, STRING_BUFFER_4
	checkflag ENGINE_EARTHBADGE
	iftruefwd .Beaten
	jumpstd gymstatue1
.Beaten:
	jumpstd gymstatue2

LeaderBlueBeforeText:
	text "Blau: He! Hast du"
	line "es endlich hierher"
	cont "geschafft?"

	para "Auf den Zinnober-"
	line "Inseln war mir"

	para "nicht danach, aber"
	line "jetzt können wir"
	cont "kämpfen."

	para "…"

	para "Willst du etwa"
	line "behaupten, du"

	para "hättest alle"
	line "Arenaleiter in"
	cont "Johto besiegt?"

	para "He! Dann müssen"
	line "die Arenaleiter in"
	cont "Johto ziemliche"
	cont "Jammerlappen sein."

	para "Aber - nur"
	line "keine Bange."

	para "Ich werde dir"
	line "sofort sagen, ob"

	para "du ein guter"
	line "Kämpfer bist."

	para "Fertig, Johto-"
	line "Champ?"
	done

LeaderBlueWinText:
	text "Blau: Was?"

	para "Wie zum Teufel"
	line "konnte ich gegen"
	cont "dich verlieren?"

	para "…"

	para "Also gut…"
	line "Hier, nimm das -"
	cont "es ist der"
	cont "Erdorden."
	done

LeaderBlueAfterText:
	text "Blau: Hier! Nimm"
	line "das auch noch!"
	done


LeaderBlueEpilogueText:
	text "Blau: Hör gut zu."

	para "Es bekommt dir"
	line "besser, nicht zu"
	cont "verlieren, bis ich"
	cont "dich besiegt habe!"
	cont "Klar?"
	done


ViridianGymGuyWinText:
	text "Junge, Junge! Du"
	line "bist sehr stark…"

	para "Das war vielleicht"
	line "ein erfrischender"

	para "Kampf. Er hat mir"
	line "Tränen in die"
	cont "Augen getrieben."
	done

AceDuoAraandbela1SeenText:
	text "Ara: Komm schon,"
	line "kämpf gegen uns"
	cont "und sieh, wie gut"
	cont "wir sind!"
	done

AceDuoAraandbela1BeatenText:
	text "Ara: Wir wurden"
	line "getäuscht!"
	done

AceDuoAraandbela2SeenText:
	text "Bela: Komm schon,"
	line "kämpf gegen uns"
	cont "und sieh, wie gut"
	cont "wir sind!"
	done

AceDuoAraandbela2BeatenText:
	text "Bela: Wir wurden"
	line "getäuscht!"
	done

CooltrainerfSalmaSeenText:
	text "Na, was meinst du?"

	para "So eine wunder-"
	line "bare Arena hast du"
	cont "noch nie gesehen,"
	cont "oder?"
	done

CooltrainerfSalmaBeatenText:
	text "Egal!"
	done

CooltrainerfBonitaSeenText:
	text "Wird dir nicht"
	line "schwindlig, wenn"
	cont "du dich hier"
	cont "umsiehst?"
	done

CooltrainerfBonitaBeatenText:
	text "Meine #mon…"

	para "Alle schwindlig"
	line "und besiegt…"
	done

AceDuoElanandida1SeenText:
	text "Olli: Also gut,"
	line "lass uns den Kampf"
	cont "beginnen!"
	done

AceDuoElanandida1BeatenText:
	text "Olli: Na, das"
	line "überrascht mich."
	done

AceDuoElanandida2SeenText:
	text "Moni: Ich bin"
	line "Moni! Neben mir"
	cont "ist Olli!"

	para "Zusammen sind wir"
	line "ein Ass-Duo!"
	done

AceDuoElanandida2BeatenText:
	text "Moni: Wow. Du"
	line "bist echt was"
	cont "Besonderes."
	done
