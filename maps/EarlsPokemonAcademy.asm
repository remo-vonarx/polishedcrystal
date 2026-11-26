EarlsPokemonAcademy_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3, 15, VIOLET_CITY, 3
	warp_event  4, 15, VIOLET_CITY, 3

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, PokemonJournalWalkerScript
	bg_event  1,  1, BGEVENT_READ, PokemonJournalWalkerScript
	bg_event  3,  0, BGEVENT_READ, AcademyBlackboard
	bg_event  4,  0, BGEVENT_READ, AcademyBlackboard

	def_object_events
	object_event  4,  2, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, AcademyEarl, EVENT_EARLS_ACADEMY_EARL
	object_event  2,  4, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, AcademyNotebook, -1
	object_event  2,  5, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, EarlsPokemonAcademyYoungster1Text, -1
	object_event  4,  7, SPRITE_CHILD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, EarlsPokemonAcademyYoungster2Text, -1
	object_event  3, 11, SPRITE_GAMER_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyGameboyKid1Script, -1
	object_event  4, 11, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyGameboyKid2Script, -1

	object_const_def
	const EARLSPOKEMONACADEMY_EARL

AcademyEarl:
	givekeyitem TYPE_CHART ; failsafe in case Violet City Earl is gone already in a save
	applymovement EARLSPOKEMONACADEMY_EARL, AcademyEarlSpinMovement
	faceplayer
	opentext
	writetext AcademyEarlIntroText
	yesorno
	iffalsefwd .Part1
	writetext AcademyEarlTeachHowToWinText
	yesorno
	iffalse_jumpopenedtext AcademyEarlNoMoreToTeachText
.Part1:
	writetext AcademyEarlTeachMoreText
	yesorno
	iffalse_jumpopenedtext AcademyEarlNoMoreToTeachText
	jumpthisopenedtext

	text "Gut! So lass misch"
	line "erklären!"

	para "Selbst, wenn ein"
	line "#mon nur kurz"

	para "an einem Kampf"
	line "teilnimmt, erhält"
	cont "es einige EP."

	para "Platziere schwache"
	line "#mon an der"

	para "Spitze der Liste."
	line "Tausche sie dann"

	para "im Kampf gegen ein"
	line "anderes #mon."

	para "So können auch"
	line "schwache #mon"
	cont "stark werden!"
	done

EarlsPokemonAcademyGameboyKid1Script:
	showtextfaceplayer EarlsPokemonAcademyGameboyKid1Text
	turnobject LAST_TALKED, DOWN
	end

EarlsPokemonAcademyGameboyKid2Script:
	showtextfaceplayer EarlsPokemonAcademyGameboyKid2Text
	turnobject LAST_TALKED, DOWN
	end

AcademyBlackboard:
	opentext
	writetext AcademyBlackboardText
.Loop:
	loadmenu .MenuHeader
	_2dmenu
	closewindow
	ifequalfwd $1, .Poison
	ifequalfwd $2, .Paralysis
	ifequalfwd $3, .Sleep
	ifequalfwd $4, .Burn
	ifequalfwd $5, .Freeze
	endtext

.Poison:
	writetext AcademyPoisonText
	waitbutton
	sjump .Loop

.Paralysis:
	writetext AcademyParalysisText
	waitbutton
	sjump .Loop

.Sleep:
	writetext AcademySleepText
	waitbutton
	sjump .Loop

.Burn:
	writetext AcademyBurnText
	waitbutton
	sjump .Loop

.Freeze:
	writetext AcademyFreezeText
	waitbutton
	sjump .Loop

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 11, 8
	dw .Data
	db 1 ; default option

.Data:
	db $80 ; flags
	dn 3, 2 ; rows, columns
	db 5 ; spacing
	dba .Text
	dbw BANK(AcademyBlackboard), 0

.Text:
	db "Gif@"
	db "Par@"
	db "Slf@"
	db "Brt@"
	db "Gfr@"
	db "Zur.@"

AcademyNotebook:
	opentext
	writetext AcademyNotebookText
	yesorno
	iffalsefwd .Done
	writetext AcademyNotebookText1
	yesorno
	iffalsefwd .Done
	writetext AcademyNotebookText2
	yesorno
	iffalsefwd .Done
	writetext AcademyNotebookText3
	waitbutton
.Done:
	endtext

PokemonJournalWalkerScript:
	setflag ENGINE_READ_WALKER_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Ex-Leiter Luc!"

	para "Gerüchten zufolge"
	line "zieht Falks Vater"
	cont "Luc als Vagabund"
	cont "durch Johto."
	done

AcademyEarlSpinMovement:
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	step_end

AcademyEarlIntroText:
	text "Earl, so lautet"
	line "mein Name!"

	para "Wunderbar sind"
	line "#mon, oui!"

	para "Isch werde dir"
	line "beibringen, ein"

	para "besserer Trainer"
	line "zu werden!"

	para "Was möchtest du"
	line "wissen? Willst ein"
	cont "Gewinner du sein?"
	done

AcademyEarlTeachHowToWinText:
	text "Gut! So lass misch"
	line "dir erklären!"

	para "Im Kampf wird das"
	line "erste #mon auf"
	cont "der Liste begin-"
	cont "nen!"

	para "Ändere die Auf-"
	line "stellung in der"
	cont "Liste, um dich den"
	cont "Gegebenheiten an-"
	cont "zupassen!"

	para "Möschtest du noch"
	line "mehr ören?"
	done

AcademyEarlTeachMoreText:
	text "Du möschtest also"
	line "wissen, wie man"
	cont "#mon rischtisch"
	cont "trainiert?"
	done


AcademyEarlNoMoreToTeachText:
	text "Oh! Du bist eine"
	line "schlaue Schüler!"
	cont "Isch kann dir nun"
	cont "nischts mehr bei-"
	cont "bringen."

	para "Sei lieb zu deinen"
	line "#mon!"
	done

EarlsPokemonAcademyYoungster1Text:
	text "Ich mache mir No-"
	line "tizen über die"
	cont "Ausführungen."

	para "Besser, ich"
	line "schreibe auch"
	cont "alles von der Ta-"
	cont "fel ab."
	done

EarlsPokemonAcademyGameboyKid1Text:
	text "Ich tauschte mein"
	line "bestes #mon"
	cont "mit diesem Kerl."
	done

EarlsPokemonAcademyGameboyKid2Text:
	text "Hä? Das #mon,"
	line "das ich bekommen"
	cont "habe, hält etwas!"
	done

EarlsPokemonAcademyYoungster2Text:
	text "Ein #mon, das"
	line "eine Beere hält,"
	cont "wird sich im Kampf"
	cont "selbst heilen."

	para "Noch viele andere"
	line "Items können von"
	cont "#mon gehalten"
	cont "werden…"

	para "Es ist nicht ein-"
	line "fach, sich all"
	cont "diese Notizen zu"
	cont "machen…"
	done

AcademyBlackboardText:
	text "Auf der Tafel wer-"
	line "den die Statusver-"
	cont "änderungen von"

	para "#mon während"
	line "eines Kampfes er-"
	cont "klärt."
	done

AcademyPoisonText:
	text "Wird ein #mon"
	line "vergiftet, ver-"
	cont "liert es ständig"
	cont "KP."

	para "Die Vergiftung"
	line "dauert auch nach"

	para "dem Kampf noch an"
	line "und es verliert"
	cont "weiterhin KP."

	para "Um es zu heilen,"
	line "musst du Gegengift"
	cont "einsetzen."
	done

AcademyParalysisText:
	text "Paralyse reduziert"
	line "die Geschwindig-"
	cont "keit und verhin-"
	cont "dert eventuell"
	cont "jede Bewegung."

	para "Sie dauert nach"
	line "dem Kampf noch an,"
	cont "also setze einen"
	cont "Para-Heiler ein."
	done

AcademySleepText:
	text "Schläft ein #-"
	line "mon, kann es nicht"
	cont "angreifen."

	para "Es wacht auch nach"
	line "dem Kampf nicht"
	cont "auf."

	para "Wecke es mit Hilfe"
	line "von Aufwecker"
	cont "wieder auf."
	done

AcademyBurnText:
	text "Eine Verbrennung"
	line "lässt die KP ste-"
	cont "tig sinken und re-"
	cont "duziert die An-"
	cont "griffskraft."

	para "Die Verbrennung"
	line "bleibt nach dem"
	cont "Kampf bestehen."

	para "Verwende einen"
	line "Feuerheiler zur"
	cont "Heilung."
	done

AcademyFreezeText:
	text "Ist dein #mon"
	line "eingefroren, ist"

	para "es zu keiner"
	line "Handlung fähig."

	para "Dieser Zustand"
	line "hält auch nach dem"

	para "Kampf an."
	line "Um es aufzutauen,"

	para "verwende einen"
	line "Eisheiler."
	done

AcademyNotebookText:
	text "Es ist das Notiz-"
	line "buch dieses Kin-"
	cont "des…"

	para "Fange #mon"
	line "mit #bällen."

	para "Bis zu sechs kön-"
	line "nen sich gleich-"
	cont "zeitig im Team be-"
	cont "finden."

	para "Weiterlesen?"
	done

AcademyNotebookText1:
	text "Bevor man den"
	line "#ball wirft,"
	cont "muss das Ziel ge-"
	cont "schwächt werden."

	para "Ein vergiftetes"
	line "oder verbranntes"
	cont "#mon kann"
	cont "leichter gefangen"
	cont "werden."

	para "Weiterlesen?"
	done

AcademyNotebookText2:
	text "Manche Attacken"
	line "verwirren dein"
	cont "#mon."

	para "Ein verwirrtes"
	line "#mon kann sich"
	cont "auch selbst ver-"
	cont "letzen."

	para "Nach einem Kampf"
	line "endet auch die"
	cont "Verwirrung."

	para "Weiterlesen?"
	done

AcademyNotebookText3:
	text "Leute, die #-"
	line "mon fangen und in"

	para "Kämpfen einsetzen,"
	line "nennt man #-"
	cont "mon-Trainer."

	para "Man erwartet von"
	line "ihnen, dass sie"

	para "Arenen besuchen"
	line "und gegen andere"
	cont "Trainer antreten."

	para "Die nächste Seite"
	line "ist… leer!"

	para "Junge: E-he-he…"

	para "Mehr habe ich"
	line "nicht aufgeschrie-"
	cont "ben…"
	done
