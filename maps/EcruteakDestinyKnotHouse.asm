EcruteakDestinyKnotHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 17
	warp_event  4,  7, ECRUTEAK_CITY, 17

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_JUMPSTD, radio2

	def_object_events
	object_event  5,  4, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakDestinyKnotHouseCooltrainerFScript, -1
	object_event  2,  3, SPRITE_RICH_BOY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, trade, NPC_TRADE_HARI, -1

EcruteakDestinyKnotHouseCooltrainerFScript:
	checkevent EVENT_GOT_DESTINY_KNOT_FROM_ECRUTEAK
	iftrue_jumptextfaceplayer .Text4
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	special SpecialBeastsCheck
	iffalse_jumpopenedtext .Text2
	special SpecialBirdsCheck
	iffalse_jumpopenedtext .Text2
	special SpecialDuoCheck
	iffalse_jumpopenedtext .Text2
	writetext .Text3
	verbosegiveitem DESTINY_KNOT, iffalse_endtext
	setevent EVENT_GOT_DESTINY_KNOT_FROM_ECRUTEAK
	jumpthisopenedtext

.Text4:
	text "Der rote Faden des"
	line "Schicksals verbin-"
	cont "det dich mit den"

	para "legendären"
	line "#mon…"

	para "Bist du etwa ein"
	line "Auserwählter?"
	done

.Text1:
	text "Zwei mächtige"
	line "Vogel-#mon aus"
	cont "Johto, die je ein"

	para "Trio legendärer"
	line "#mon behüten."

	para "Legenden in"
	line "Legenden…"
	done

.Text2:
	text "Was, wenn ein"
	line "Trainer sie alle"
	cont "fangen würde?"

	para "Was für ein"
	line "unwahrscheinliches"
	cont "Schicksal!"
	done

.Text3:
	text "Was? Du hast sie"
	line "gesehen? Und sogar"
	cont "gefangen?!"

	para "Zeig mal deinen"
	line "#dex… Wow!"

	para "Das muss dein"
	line "Schicksal gewesen"
	cont "sein."

	para "Hier, das solltest"
	line "du bekommen."
	done
