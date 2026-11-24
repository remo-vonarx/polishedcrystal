ChadAnswerPhoneText:
	text "Hallo, hier ist"
	line ""
	text_ram wStringBuffer3
	text "…"

	para "Hi, <PLAYER>!"
	line "Guten Morgen!"
	done

ChadAnswerPhoneDayText:
	text "Hallo, hier ist"
	line ""
	text_ram wStringBuffer3
	text "…"

	para "Hi, <PLAYER>,"
	line "guten Tag!"
	done

ChadAnswerPhoneNiteText:
	text "Hallo, hier ist"
	line ""
	text_ram wStringBuffer3
	text "…"

	para "Hi, <PLAYER>,"
	line "guten Abend!"
	done

ChadGreetText:
	text "Hi, <PLAYER>,"
	line "guten Morgen!"

	para ""
	text_ram wStringBuffer3
	text " hier."
	line "Wie geht es dir?"
	done

ChadGreetDayText:
	text "Hi, <PLAYER>,"
	line "guten Tag!"

	para ""
	text_ram wStringBuffer3
	text " hier."
	line "Wie geht es dir?"
	done

ChadGreetNiteText:
	text "Hi, <PLAYER>,"
	line "guten Abend!"

	para ""
	text_ram wStringBuffer3
	text " hier."
	line "Wie geht es dir?"
	done

ChadGenericText:
	text "Wie geht es deinen"
	line "#mon?"

	para "Du kennst Prof."
	line "Eich, also geht es"
	cont "deinen #mon"
	cont "gut!"

	para "Meinen #mon"
	line "geht es auch gut."

	para "Aber ich möchte ja"
	line "auch ein #mon-"
	cont "Professor werden,"

	para "also ist das keine"
	line "Überraschung."
	done
