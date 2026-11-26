AzaleaMart_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, AZALEA_TOWN, 3
	warp_event  3,  7, AZALEA_TOWN, 3

	def_coord_events

	def_bg_events

	def_object_events
	mart_clerk_event  1,  3, MARTTYPE_STANDARD, MART_AZALEA
	object_event  2,  5, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaMartCooltrainermText, -1
	object_event  7,  2, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaMartBugCatcherText, -1
	object_event  8,  6, SPRITE_LADY, SPRITEMOVEDATA_STANDING_UP, 0, 0, (1 << MORN) | (1 << DAY), PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaMartLadyText, -1
	object_event  8,  6, SPRITE_ROCKER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, (1 << EVE) | (1 << NITE), PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaMartRockerText, -1

AzaleaMartCooltrainermText:
	text "Hier gibt es keine"
	line "Superbälle. Ich"

	para "werde mit #-"
	line "bällen auskommen"
	cont "müssen."

	para "Ich wünschte, Kurt"
	line "würde mir einen"
	cont "seiner Bälle"
	cont "machen."
	done

AzaleaMartBugCatcherText:
	text "Ein Superball eig-"
	line "net sich besser"
	cont "zum Fangen von"
	cont "#mon als ein"
	cont "#ball."

	para "Aber manchmal sind"
	line "Kurts Bälle"
	cont "besser."
	done

AzaleaMartLadyText:
	text "Bei mir zu Hause"
	line "in Dukatia City"
	cont "kann ich viele"
	cont "Items kaufen,"

	para "aber um Feuer-"
	line "Attacken zu ver-"
	cont "stärken, geht"

	para "nichts über die"
	line "Holzkohle aus"
	cont "Azalea City!"
	done

AzaleaMartRockerText:
	text "Die Prototypen"
	line "von Kurts Bällen"

	para "hatten so ihre"
	line "Probleme."

	para "Sympabälle fingen"
	line "#mon desselben"
	cont "Geschlechts,"

	para "und Turbobälle"
	line "wirkten nur bei"

	para "drei verschiede-"
	line "nen #mon-Arten."

	para "Zum Glück wurden"
	line "diese Probleme"
	cont "behoben!"
	done
