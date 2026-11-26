ViridianForest_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  5, VIRIDIAN_FOREST_PEWTER_GATE, 1
	warp_event 18, 47, VIRIDIAN_FOREST_VIRIDIAN_GATE, 1
	warp_event 19, 47, VIRIDIAN_FOREST_VIRIDIAN_GATE, 2

	def_coord_events

	def_bg_events
	bg_event  4,  7, BGEVENT_JUMPTEXT, ViridianForestSignText1
	bg_event  6, 26, BGEVENT_JUMPTEXT, ViridianForestSignText2
	bg_event 28, 19, BGEVENT_JUMPTEXT, ViridianForestSignText3
	bg_event 18, 34, BGEVENT_JUMPTEXT, ViridianForestSignText4
	bg_event 26, 42, BGEVENT_JUMPTEXT, ViridianForestSignText5
	bg_event 20, 44, BGEVENT_JUMPTEXT, ViridianForestSignText6
	bg_event 32, 44, BGEVENT_ITEM + MAX_ETHER, EVENT_VIRIDIAN_FOREST_HIDDEN_MAX_ETHER
	bg_event 18, 43, BGEVENT_ITEM + FULL_HEAL, EVENT_VIRIDIAN_FOREST_HIDDEN_FULL_HEAL
	bg_event  4, 43, BGEVENT_ITEM + MULCH, EVENT_VIRIDIAN_FOREST_HIDDEN_MULCH
	bg_event 30,  9, BGEVENT_ITEM + BIG_MUSHROOM, EVENT_VIRIDIAN_FOREST_HIDDEN_BIG_MUSHROOM
	bg_event  3, 14, BGEVENT_ITEM + LEAF_STONE, EVENT_VIRIDIAN_FOREST_HIDDEN_LEAF_STONE

	def_object_events
	object_event 29, 42, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBug_maniacDane, -1
	object_event 33, 35, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerBug_maniacDion, -1
	object_event 32, 21, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBug_maniacStacey, -1
	object_event 31,  4, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBug_maniacEllis, -1
	object_event  5, 24, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBug_maniacAbner, -1
	itemball_event 14, 31, DIRE_HIT, 1, EVENT_ROUTE_2_DIRE_HIT
	itemball_event  3, 33, MAX_POTION, 1, EVENT_ROUTE_2_MAX_POTION

GenericTrainerBug_maniacDane:
	generictrainer BUG_MANIAC, DANE, EVENT_BEAT_BUG_MANIAC_DANE, BugManiacDaneSeenText, BugManiacDaneBeatenText

	text "Ziemlich beein-"
	line "druckend!"

	para "Mit diesem Können"
	line "kommst du sicher"
	cont "überall hin!"
	done

GenericTrainerBug_maniacDion:
	generictrainer BUG_MANIAC, DION, EVENT_BEAT_BUG_MANIAC_DION, BugManiacDionSeenText, BugManiacDionBeatenText

	text "Käfer-#mon"
	line "machen alle mög-"
	cont "lichen Geräusche."

	para "Für Fans von Kä-"
	line "fer-#mon ist es"
	cont "wichtig, sie un-"
	cont "terscheiden zu"
	cont "können!"
	done

GenericTrainerBug_maniacStacey:
	generictrainer BUG_MANIAC, STACEY, EVENT_BEAT_BUG_MANIAC_STACEY, BugManiacStaceySeenText, BugManiacStaceyBeatenText

	text "Hat dir schon mal"
	line "jemand gesagt,"
	cont "dass du von hinten"
	cont "wie ein Bluzuk"
	cont "aussiehst?"
	done

GenericTrainerBug_maniacEllis:
	generictrainer BUG_MANIAC, ELLIS, EVENT_BEAT_BUG_MANIAC_ELLIS, BugManiacEllisSeenText, BugManiacEllisBeatenText

	text "Wenn das so ist,"
	line "macht mir das"
	cont "Verlieren nichts"
	cont "aus!"
	done

GenericTrainerBug_maniacAbner:
	generictrainer BUG_MANIAC, ABNER, EVENT_BEAT_BUG_MANIAC_ABNER, BugManiacAbnerSeenText, BugManiacAbnerBeatenText

	text "Egal, was für"
	line "#mon es sind:"

	para "Solange du sie"
	line "magst, sehen alle"
	cont "süß aus."
	done

BugManiacDaneSeenText:
	text "Willkommen im"
	line "Vertania-Wald."
	cont "Genieß meine"
	cont "Käfer-#mon."
	done

BugManiacDaneBeatenText:
	text "Wunderbar…"
	done

BugManiacDionSeenText:
	text "Pst! Sei leise!"
	line "Die Käfer-#mon"
	cont "laufen weg!"
	done

BugManiacDionBeatenText:
	text "Puh…"
	done

BugManiacStaceySeenText:
	text "Wow, das ist ein"
	line "RIESIGES #mon!"

	para "…"
	line "…Was für ein"
	cont "Trainer?!"
	done

BugManiacStaceyBeatenText:
	text "Ich konnte es"
	line "nicht fangen!"
	done

BugManiacEllisSeenText:
	text "Nichts ist effi-"
	line "zienter und schö-"
	cont "ner als ein"
	cont "Käfer-#mon."
	done

BugManiacEllisBeatenText:
	text "Ich habe mit Stil"
	line "verloren!"
	done

BugManiacAbnerSeenText:
	text "Viele Leute mögen"
	line "harte Käfer-"
	cont "#mon lieber als"
	cont "weiche."
	done

BugManiacAbnerBeatenText:
	text "Danke für eure"
	line "harte Arbeit, mei-"
	cont "ne lieben #mon…"
	done

ViridianForestSignText1:
	text "Ende des"
	line "Vertania-Walds"
	cont "Marmoria City"
	cont "voraus"
	done

ViridianForestSignText2:
	text "Tipps für Trainer"

	para "Behalte den"
	line "Riesenpilz!"

	para "Manche Maniacs"
	line "zahlen viel Geld"
	cont "für nutzlose"
	cont "Items!"
	done

ViridianForestSignText3:
	text "Tipps für Trainer"

	para "#mon vom Typ"
	line "Pflanze sind immun"

	para "gegen Pulver- und"
	line "Sporen-Attacken!"
	done

ViridianForestSignText4:
	text "Bei Vergiftung"
	line "hilft Gegengift!"
	cont "Gibt's im"
	cont "PKMN-Supermarkt!"
	done

ViridianForestSignText5:
	text "Tipps für Trainer"

	para "#mon vom Typ"
	line "Gift können"
	cont "selbst nicht ver-"
	cont "giftet werden!"
	done

ViridianForestSignText6:
	text "Tipps für Trainer"

	para "Schwäche #mon,"
	line "bevor du sie"
	cont "fängst!"

	para "Gesunde #mon"
	line "können entkommen!"
	done
