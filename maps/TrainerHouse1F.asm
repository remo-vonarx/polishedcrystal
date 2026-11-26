TrainerHouse1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 11, VIRIDIAN_CITY, 3
	warp_event  5, 11, VIRIDIAN_CITY, 3
	warp_event  8,  2, TRAINER_HOUSE_B1F, 1

	def_coord_events

	def_bg_events
	bg_event  7,  0, BGEVENT_JUMPTEXT, TrainerHouseSign1Text
	bg_event  9,  0, BGEVENT_JUMPTEXT, TrainerHouseSign2Text
	bg_event  4,  6, BGEVENT_JUMPTEXT, TrainerHouseIllegibleText
	bg_event  8,  5, BGEVENT_READ, PokemonJournalKarenScript
	bg_event  9,  5, BGEVENT_READ, PokemonJournalKarenScript
	bg_event  8,  9, BGEVENT_READ, PokemonJournalKarenScript
	bg_event  9,  9, BGEVENT_READ, PokemonJournalKarenScript

	def_object_events
	object_event  1, 10, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, TrainerHouse1FReceptionistText, -1
	object_event  8, 10, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, TrainerHouse1FCooltrainerMText, -1
	object_event  6,  2, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, TrainerHouse1FCooltrainerFText, -1
	object_event  7,  7, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, TrainerHouse1FYoungsterText, -1
	object_event  2,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, TrainerHouse1FGentlemanText, -1

PokemonJournalKarenScript:
	setflag ENGINE_READ_KAREN_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Top Vier Melanie!"

	para "Melanie soll damit"
	line "begonnen haben,"

	para "Unlicht-#mon zu"
	line "trainieren, damit"

	para "sie ihren finste-"
	line "ren Ruf loswerden."
	done

TrainerHouse1FReceptionistText:
	text "Willkommen im"
	line "Trainer-Haus, dem"

	para "neuesten und"
	line "erlebnisreichsten"
	cont "Ort von Vertania"
	cont "City."

	para "Nur Trainer haben"
	line "hier Zutritt."

	para "Du kannst gegen"
	line "die Besten der"

	para "Besten antreten!"
	line "Geh nur die Treppe"
	cont "hinunter."
	done

TrainerHouse1FCooltrainerMText:
	text "Vertania City ist"
	line "dem Indigo Plateau"
	cont "am nächsten."

	para "Man nennt es auch"
	line "das Tor zum Indigo"
	cont "Plateau!"

	para "Man hat diesen Ort"
	line "erbaut, weil ihn"

	para "so viele Trainer"
	line "auf ihrem Weg zur"

	para "#mon Liga"
	line "passieren."
	done

TrainerHouse1FCooltrainerFText:
	text "Hier unten werden"
	line "Übungskämpfe"
	cont "abgehalten."

	para "Ich würde liebend"
	line "gerne sehen, wie"

	para "Trainer aus Johto"
	line "kämpfen."
	done

TrainerHouse1FYoungsterText:
	text "Ich nehme an, du"
	line "kannst nur dann"

	para "Champ werden, wenn"
	line "du viel herum-"
	cont "kommst und so"

	para "viele Kämpfe wie"
	line "möglich austrägst."

	para "Der Champ von"
	line "Alabastia bereiste"

	para "alle großen und"
	line "kleinen Städte"
	cont "in Kanto."
	done

TrainerHouse1FGentlemanText:
	text "Puh… Ich höre"
	line "eine Zeit lang auf"
	cont "mit Kämpfen."
	done

TrainerHouseSign1Text:
	text "Übungskämpfe"
	line "werden unten in"

	para "der Übungshalle"
	line "abgehalten."

	para "Auch erfahrene"
	line "Trainer können"
	cont "gerne teilnehmen."
	done

TrainerHouseSign2Text:
	text "Bei den Trainings-"
	line "kämpfen gelten"

	para "keine Regeln oder"
	line "Vorgaben. Wie bei"

	para "den Feldkämpfen"
	line "ist alles erlaubt!"
	done

TrainerHouseIllegibleText:
	text "…Was ist das?"
	line "Eine strategische"
	cont "Notiz?"

	para "Dieses Schrift-"
	line "stück sieht aus"

	para "wie die Spur eines"
	line "Onix…"
	cont "Völlig unlesbar…"
	done
