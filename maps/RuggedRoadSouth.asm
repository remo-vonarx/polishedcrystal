RuggedRoadSouth_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_RUGGEDROADSOUTH_BRIDGE_UNDERFOOT
	scene_const SCENE_RUGGEDROADSOUTH_BRIDGE_OVERHEAD

	def_callbacks
	callback MAPCALLBACK_TILES, RuggedRoadSouthTileScript
	callback MAPCALLBACK_CMDQUEUE, RuggedRoadSouthSetUpPaletteSwap

	def_warp_events
	warp_event 15, 33, ROUTE_39_RUGGED_ROAD_GATE, 1
	warp_event 16, 33, ROUTE_39_RUGGED_ROAD_GATE, 2

	def_coord_events
	coord_event 27,  3, SCENE_RUGGEDROADSOUTH_BRIDGE_OVERHEAD, RuggedRoadSouthBridgeOverheadTrigger
	coord_event 27,  1, SCENE_RUGGEDROADSOUTH_BRIDGE_UNDERFOOT, RuggedRoadSouthBridgeUnderfootTrigger
	coord_event 25, 23, SCENE_RUGGEDROADSOUTH_BRIDGE_OVERHEAD, RuggedRoadSouthBridgeOverheadTrigger

	def_bg_events
	bg_event 17, 25, BGEVENT_JUMPTEXT, RuggedRoadSouthAdvancedTipsSignText
	bg_event  7, 21, BGEVENT_ITEM + IRON, EVENT_RUGGED_ROAD_SOUTH_HIDDEN_IRON

	def_object_events
	object_event  7,  7, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_DARK_BLUE, OBJECTTYPE_TRAINER, 4, TrainerBird_keeperSalim, -1
	object_event 24,  8, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerHikerMaynard, -1
	object_event 12, 18, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherCarlos, -1
	object_event 22, 24, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerHikerElijah, -1
	object_event 13, 12, SPRITE_BLACK_BELT, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_SCRIPT, 0, RuggedRoadSouthBlackBeltScript, -1
	object_event 11, 24, SPRITE_CAMPER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, RuggedRoadSouthCamperText, -1
	itemball_event  4,  9, REVIVE, 1, EVENT_RUGGED_ROAD_SOUTH_REVIVE
	itemball_event 27, 13, IRON_BALL, 1, EVENT_RUGGED_ROAD_SOUTH_IRON_BALL
	smashrock_event 26,  9
	smashrock_event 13, 10
	smashrock_event  8, 25
	smashrock_event 12, 30

RuggedRoadSouthTileScript:
	checkscene
	iftruefwd .underfoot
	callasm RuggedRoadSouth_OverheadBridgeAsm
	endcallback

.underfoot:
	callasm RuggedRoadSouth_UnderfootBridgeAsm
	endcallback

RuggedRoadSouth_OverheadBridgeAsm:
	changebridgeblock 14, 0, $d8, RUGGED_ROAD_SOUTH
	changebridgeblock 16, 0, $95, RUGGED_ROAD_SOUTH
	changebridgeblock 18, 0, $95, RUGGED_ROAD_SOUTH
	changebridgeblock 20, 0, $95, RUGGED_ROAD_SOUTH
	changebridgeblock 22, 0, $d9, RUGGED_ROAD_SOUTH
	jmp BufferScreen

RuggedRoadSouth_UnderfootBridgeAsm:
	changebridgeblock 14, 0, $aa, RUGGED_ROAD_SOUTH
	changebridgeblock 16, 0, $e4, RUGGED_ROAD_SOUTH
	changebridgeblock 18, 0, $e4, RUGGED_ROAD_SOUTH
	changebridgeblock 20, 0, $e4, RUGGED_ROAD_SOUTH
	changebridgeblock 22, 0, $ab, RUGGED_ROAD_SOUTH
	jmp BufferScreen

RuggedRoadSouthBridgeOverheadTrigger:
	callasm RuggedRoadSouth_OverheadBridgeAsm
	callthisasm
	xor a
	jr RuggedRoadSouth_FinishBridge

RuggedRoadSouthBridgeUnderfootTrigger:
	callasm RuggedRoadSouth_UnderfootBridgeAsm
	callthisasm
	ld a, $1
RuggedRoadSouth_FinishBridge:
	ld [wWalkingOnBridge], a
	ld [wRuggedRoadSouthSceneID], a ; setscene a
	jmp GenericFinishBridge

RuggedRoadSouthSetUpPaletteSwap:
	usepaletteswap .PaletteSwap
	endcallback

.PaletteSwap:
	paletteswap 0, 255, 0, 22, PAL_BG_YELLOW, PAL_BG_YELLOW, RuggedRoadSouthFlowerPalettes
	db -1 ; end

TrainerBird_keeperSalim:
	trainer BIRD_KEEPER, SALIM, EVENT_BEAT_BIRD_KEEPER_SALIM, .SeenText, .BeatenText, 0, .Script, TRAINERPAL_DARK_BIRD_KEEPER

.Script:
	endifjustbattled
	jumpthistextfaceplayer

	text "Das Wetter kann"
	line "den ganzen Verlauf"

	para "eines Kampfes"
	line "ändern."
	done

.SeenText:
	text "Meine Vögel haben"
	line "uns hergeflogen…"

	para "…aber in diesem"
	line "Sandsturm sitzen"
	cont "wir fest!"
	done

.BeatenText:
	text "Ab jetzt bleibe"
	line "ich bei klarem"
	cont "Himmel."
	done

GenericTrainerHikerMaynard:
	generictrainer HIKER, MAYNARD, EVENT_BEAT_HIKER_MAYNARD, .SeenText, .BeatenText

	text "Jede ordentlich"
	line "nummerierte Route"

	para "begann einmal als"
	line "ungezähmte"
	cont "Wildnis."
	done

.SeenText:
	text "Ich nehme den"
	line "weniger began-"
	cont "genen Weg!"
	done

.BeatenText:
	text "Die Niederlage ist"
	line "ein ausgetretener"
	cont "Pfad."
	done

GenericTrainerFisherCarlos:
	generictrainer FISHER, CARLOS, EVENT_BEAT_FISHER_CARLOS, .SeenText, .BeatenText

	text "Bestimmt wird mein"
	line "Fang stark, wenn"
	cont "er trainiert ist."

	para "Vielleicht ent-"
	line "wickelt er sich"
	cont "sogar!"
	done

.SeenText:
	text "Ich bin hier hoch-"
	line "gewandert, auf der"
	cont "Suche nach einem"
	cont "neuen Fang…"

	para "Und es hat sich"
	line "gelohnt!"
	done

.BeatenText:
	text "Mein neuer Fang"
	line "war unerfahren…"
	done

GenericTrainerHikerElijah:
	generictrainer HIKER, ELIJAH, EVENT_BEAT_HIKER_ELIJAH, .SeenText, .BeatenText

	text "Ich habe es mir"
	line "nicht ausgesucht,"
	cont "Wanderer zu sein."

	para "Das Wandern hat"
	line "mich ausgesucht."
	done

.SeenText:
	text "Die Berge rufen,"
	line "und ich muss"
	cont "gehen!"
	done

.BeatenText:
	text "Davon lass ich"
	line "mich nicht ab-"
	cont "bringen!"
	done

RuggedRoadSouthBlackBeltScript:
	checkevent EVENT_GOT_PUNCHINGLOVE_FROM_RUGGED_ROAD
	iftrue_jumptextfaceplayer .GotPunchinGloveText
	faceplayer
	opentext
	writetext .IntroText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	checkitem BRICK_PIECE
	iffalse_jumpopenedtext .NoBrickPieceText
	takeitem BRICK_PIECE
	writetext .GaveBrickPieceText
	waitbutton
	verbosegiveitem PUNCHINGLOVE, iffalsefwd .NoRoomForPunchinGlove
	setevent EVENT_GOT_PUNCHINGLOVE_FROM_RUGGED_ROAD
	jumpthisopenedtext

.GotPunchinGloveText
	text "Mit dem Boxhand-"
	line "schuh schlagen"
	cont "deine #mon noch"
	cont "härter zu!"
	done

.IntroText:
	text "Hi-YAH!"

	para "Mit meinen starken"
	line "Schlägen zertrüm-"
	cont "mere ich Felsen!"

	para "Hm? Deine #mon"
	line "können das auch?"

	para "Beweis es! Bring"
	line "mir einen Ziegel-"
	cont "stein von einem"
	cont "zerschlagenen"
	cont "Felsen!"
	done

.RefusedText:
	text "Hah! Wusste ich's"
	line "doch!"
	done

.NoBrickPieceText:
	text "Hah! Du hast ja"
	line "gar keinen!"
	done

.GaveBrickPieceText:
	text "Huch! Das ist ein"
	line "echter Ziegel-"
	cont "stein!"

	para "Deine #mon sind"
	line "echt zäh. So wie"
	cont "ich!"

	para "Hier, dieser"
	line "gepolsterte Hand-"
	cont "schuh hilft ihnen!"
	done

.NoRoomForPunchinGlove:
	; Refund the Brick Piece just removed from the Bag.
	giveitem_unsafe BRICK_PIECE
	jumpthisopenedtext

	text "Pah! Dafür hast"
	line "du keinen Platz!"
	done

RuggedRoadSouthCamperText:
	text "Wieso dachte ich,"
	line "dass das hier ein"

	para "toller neuer Zelt-"
	line "platz wäre?"

	para "Ich sehe den Weg"
	line "ja kaum!"
	done

RuggedRoadSouthAdvancedTipsSignText:
	text "Tipps für Profis!"

	para "Besiegt dein"
	line "#mon den Gegner"

	para "und trägt es ein"
	line "Macht-Item, das"
	cont "den Fleiß-Zuwachs"
	cont "erhöht,"

	para "profitiert jedes"
	line "#mon davon, das"

	para "am Kampf teilnahm"
	line "oder einen EP-"
	cont "Teiler trägt!"
	done
