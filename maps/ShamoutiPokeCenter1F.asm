ShamoutiPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, SHAMOUTI_ISLAND, 1
	warp_event  6,  7, SHAMOUTI_ISLAND, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalLoreleiScript

	def_object_events
	object_event  6,  3, SPRITE_IVY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ShamoutiPokeCenter1FIvyScript, EVENT_SHAMOUTI_POKE_CENTER_IVY
	pc_nurse_event  5, 1

	object_const_def
	const SHAMOUTIPOKECENTER1F_IVY

PokemonJournalLoreleiScript:
	setflag ENGINE_READ_LORELEI_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Titelthema:"
	line "Ex-Top-Vier"
	cont "Lorelei!"

	para "Lorelei soll eine"
	line "komplette Samm-"
	cont "lung von #mon-"
	cont "Puppen besitzen."
	done

ShamoutiPokeCenter1FIvyScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_IVY_INTRO
	iftruefwd .HeardIntro
	writetext .GreetingText
	waitbutton
	setevent EVENT_LISTENED_TO_IVY_INTRO
.HeardIntro
	writetext .OfferText
	loadmenu .KantoStarterMenuData
	verticalmenu
	closewindow
	ifequalfwd $1, .Bulbasaur
	ifequalfwd $2, .Charmander
	ifequalfwd $3, .Squirtle
	jumpthisopenedtext

	text "Ivy: Hm, ich dach-"
	line "te, du würdest"

	para "dich freuen, ein"
	line "seltenes #mon"
	cont "großzuziehen…"
	done

.Bulbasaur:
	writetext .ChoseKantoStarterText
	promptbutton
	waitsfx
	givepoke BULBASAUR, PLAIN_FORM, 10, SITRUS_BERRY
	iffalse_jumpopenedtext .NoRoomText
	getmonname BULBASAUR, STRING_BUFFER_3
	setevent EVENT_GOT_BULBASAUR_FROM_IVY
	sjumpfwd .Finish

.Charmander:
	writetext .ChoseKantoStarterText
	promptbutton
	waitsfx
	givepoke CHARMANDER, PLAIN_FORM, 10, SITRUS_BERRY
	iffalse_jumpopenedtext .NoRoomText
	getmonname CHARMANDER, STRING_BUFFER_3
	setevent EVENT_GOT_CHARMANDER_FROM_IVY
	sjumpfwd .Finish

.Squirtle:
	writetext .ChoseKantoStarterText
	promptbutton
	waitsfx
	givepoke SQUIRTLE, PLAIN_FORM, 10, SITRUS_BERRY
	iffalse_jumpopenedtext .NoRoomText
	getmonname SQUIRTLE, STRING_BUFFER_3
	setevent EVENT_GOT_SQUIRTLE_FROM_IVY
.Finish:
	writetext .GoodbyeText
	waitbutton
	closetext
	readvar VAR_FACING
	turnobject PLAYER, DOWN
	ifnotequal UP, .noleftstep
	applyonemovement SHAMOUTIPOKECENTER1F_IVY, step_left
.noleftstep
	applymovement SHAMOUTIPOKECENTER1F_IVY, .DownMovement
	playsound SFX_EXIT_BUILDING
	disappear SHAMOUTIPOKECENTER1F_IVY
	setevent EVENT_GOT_A_POKEMON_FROM_IVY
	checkevent EVENT_BEAT_YELLOW
	iffalsefwd .skip
	clearevent EVENT_INDIGO_PLATEAU_POKECENTER_YELLOW
.skip
	waitsfx
	end

.NoRoomText:
	text "Leider scheint"
	line "weder in deinem"
	cont "Team noch in"
	cont "deiner Box Platz"
	cont "zu sein…"
	done

.GreetingText:
	text "Ivy: Oh! Du bist"
	line "<PLAYER>, der neue"
	cont "Champ!"

	para "Freut mich, dich"
	line "kennenzulernen!"

	para "Ich bin Ivy,"
	line "eine #mon-"
	cont "Professorin."

	para "Ich erforsche"
	line "regionale Unter-"
	cont "schiede im Phäno-"
	cont "typ von #mon."

	para "Wusstest du, dass"
	line "manche wilden"
	cont "#mon Attacken"
	cont "können, die es nur"
	cont "in ihrem Lebens-"
	cont "raum gibt?"

	para "Und sogar zwei"
	line "gleiche #mon"

	para "in einem Gebiet"
	line "können verschie-"
	cont "dene Farben haben…"

	para "Ach, entschuldige,"
	line "manchmal schweife"
	cont "ich ab."
	done

.OfferText:
	text "Ivy: Du stellst"
	line "dich also einer"

	para "ganz neuen Arena-"
	line "Herausforderung in"
	cont "einer neuen"
	cont "Region…"

	para "Aha! Warum gebe"
	line "ich dir nicht auch"
	cont "ein neues #mon?"

	para "Welches möchtest"
	line "du?"
	done

.ChoseKantoStarterText:
	text "Ivy: Ich bin auch"
	line "der Meinung, dass"
	cont "dieses #mon"
	cont "sehr gut ist!"
	done

.GoodbyeText:
	text "Ivy: Prof. Lind"
	line "vertraute dir ein"
	cont "#mon an,"

	para "und Prof. Eich gab"
	line "dir einen #dex."

	para "Also weiß ich,"
	line "dass du gut für"
	cont ""
	text_ram wStringBuffer3
	text " sorgst."

	para "Ich muss jetzt die"
	line "Fähre zurück zu"

	para "meinem Labor auf"
	line "der Valencia Insel"
	cont "nehmen."

	para "Grüß Prof. Eich"
	line "von mir!"
	done

.DownMovement:
	step_down
	step_down
	step_down
	step_down
	step_end

.KantoStarterMenuData:
	db MENU_BACKUP_TILES
	menu_coords 0, 2, 13, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Bisasam@"
	db "Glumanda@"
	db "Schiggy@"
	db "Zurück@"
