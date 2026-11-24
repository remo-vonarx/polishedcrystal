EcruteakPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, ECRUTEAK_CITY, 6
	warp_event  6,  7, ECRUTEAK_CITY, 6
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalMortyScript

	def_object_events
	object_event  6,  3, SPRITE_BILL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPokeCenter1FBillScript, EVENT_ECRUTEAK_POKE_CENTER_BILL
	pc_nurse_event  5, 1
	object_event 11,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, EcruteakPokeCenter1FPokefanMScript, -1
	object_event 11,  5, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakPokeCenter1FLassScript, -1
	object_event  1,  4, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakPokeCenter1FCooltrainerFText, -1
	object_event  8,  1, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakPokeCenter1FGymGuyText, -1

	object_const_def
	const ECRUTEAKPOKECENTER1F_BILL

PokemonJournalMortyScript:
	setflag ENGINE_READ_MORTY_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Special Feature:"
	line "Leader Morty!"

	para "Morty claims to"
	line "have once seen"
	cont "Entei. He says:"

	para "“It was amazing."
	line "Entei looked me"
	cont "in the eyes."

	para "I'll never forget"
	line "its eyes. It was"

	para "like it could see"
	line "right through me,"

	para "down into the dep-"
	line "ths of my heart…”"
	done

EcruteakPokeCenter1FBillScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_BILL_INTRO
	iftruefwd .heardintro
	writetext .IntroText
	waitbutton
	setevent EVENT_LISTENED_TO_BILL_INTRO
.heardintro
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .NoText
	writetext .YesText
	promptbutton
	waitsfx
	readvar VAR_PARTYCOUNT
	ifequalfwd PARTY_LENGTH, .NoRoom
	givepoke EEVEE, PLAIN_FORM, 5, NO_ITEM, GREAT_BALL
	givepokemail .GiftEeveeMail
	callasm .SetEeveeMailOT
	setevent EVENT_GOT_EEVEE
	writetext .GoodbyeText
	waitbutton
	closetext
	readvar VAR_FACING
	turnobject PLAYER, DOWN
	ifnotequal UP, .noleftstep
	applyonemovement ECRUTEAKPOKECENTER1F_BILL, step_left
.noleftstep
	applymovement ECRUTEAKPOKECENTER1F_BILL, .LeaveMovement
	playsound SFX_EXIT_BUILDING
	disappear ECRUTEAKPOKECENTER1F_BILL
	clearevent EVENT_NEVER_MET_BILL
	waitsfx
	end

.NoRoom:
	jumpthisopenedtext

	text "Moment! Du hast"
	line "keinen Platz mehr"
	cont "in deinem Team."
	done

.IntroText:
	text "Hi, I'm Bill. And"
	line "who are you?"

	para "Hmm, <PLAYER>, huh?"
	line "You've come at the"
	cont "right time."

	para "The Time Capsules"
	line "are totally fried,"

	para "and I could use"
	line "your help."
	done

.QuestionText:
	text "Bill: This Eevee"
	line "came over just"

	para "before the Time"
	line "Capsule shut down."

	para "Someone has to"
	line "take care of it,"

	para "but I don't like"
	line "being outside."

	para "Can I count on you"
	line "to play with it,"
	cont "<PLAYER>?"
	done

.YesText:
	text "Bill: Ich wusste,"
	line "dass du es"

	para "schaffst! Noch ein"
	line "kleines Stück! Du"
	cont "bist einzigartig!"

	para "O.K., ich zähle"
	line "auf dich."

	para "Pass auf dich auf!"
	done

.GoodbyeText:
	text "Bill: Prof.Elm"
	line "claims Eevee may"

	para "evolve in new and"
	line "unknown ways."

	para "I have to hurry on"
	line "back to Goldenrod"
	cont "and see my folks,"

	para "and then it's back"
	line "to Kanto for me."

	para "Buh-bye!"
	done

.NoText:
	text "Oh… Was soll ich"
	line "tun?"
	done

.LeaveMovement:
	step_down
	step_down
	step_down
	step_down
	step_end

.GiftEeveeMail:
	db   EON_MAIL
	setcharmap no_ngrams
	db   "Please keep this"
	next "Pokémon safe!@@"
	setcharmap default

.SetEeveeMailOT:
	ld hl, sPartyMon1MailAuthor
	ld a, [wPartyCount]
	dec a
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	push hl
	pop de
	ld hl, .EeveeMailOTID
	ld bc, .EeveeMailOTIDEnd - .EeveeMailOTID
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	rst CopyBytes
	jmp CloseSRAM

.EeveeMailOTID:
	rawchar "Prof.Oak@@"
	bigdw 00001
.EeveeMailOTIDEnd

EcruteakPokeCenter1FPokefanMScript:
	checkevent EVENT_GOT_HM03_SURF
	iftrue_jumptextfaceplayer .SurfText
	jumpthistextfaceplayer

	text "Sowohl der Tanz"
	line "der Kimono-Girls"

	para "als auch die Art,"
	line "wie sie ihre #-"
	cont "mon einsetzen, ist"
	cont "wunderbar!"
	done

.SurfText:
	text "Du hoffst, hier"
	line "mehr Kämpfe zu er-"
	cont "leben, nicht wahr?"

	para "Es gibt offen-"
	line "sichtlich einen"

	para "Ort, an dem sich"
	line "Trainer treffen."

	para "Wo, fragst du?"

	para "Kurz nach"
	line "Oliviana City."
	done

EcruteakPokeCenter1FLassScript:
	faceplayer
	opentext
	writetext .QuestionText
	yesorno
	iffalsefwd .No
	checkevent EVENT_ECRUTEAK_POKE_CENTER_BILL
	iffalse_jumpopenedtext .HereText
	jumpthisopenedtext

	text "I once heard that"
	line "Bill's mother used"

	para "to be a Kimono"
	line "Girl. Maybe that's"

	para "why he visits"
	line "here so often."
	done

.No:
	checkevent EVENT_ECRUTEAK_POKE_CENTER_BILL
	iffalse_jumpopenedtext .HereText
	jumpthisopenedtext

	text "Oh… Never mind"
	line "then."
	done

.QuestionText:
	text "Do you know who"
	line "Bill is?"
	done

.HereText:
	text "Then go talk to"
	line "him! He's right"
	cont "by the counter!"
	done

EcruteakPokeCenter1FCooltrainerFText:
	text "Jens, der Arena-"
	line "leiter, ist soooo"
	cont "cool."

	para "Auch seine #mon"
	line "sind sehr stark."
	done

EcruteakPokeCenter1FGymGuyText:
	text "See des Zorns…"

	para "Das Erscheinen ei-"
	line "nes Garados-"
	cont "Schwarms…"

	para "Das riecht nach"
	line "Verschwörung!"
	done
