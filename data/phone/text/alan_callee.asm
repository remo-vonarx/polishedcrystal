AlanAnswerPhoneText:
	text "Ich, "
	text_ram wStringBuffer3
	text "!"

	para "<PLAYER>, oder?"
	line "Guten Morgen!"
	done

AlanAnswerPhoneDayText:
	text "Ich, "
	text_ram wStringBuffer3
	text "!"

	para "<PLAYER>, oder?"
	done

AlanAnswerPhoneNiteText:
	text "Ich, "
	text_ram wStringBuffer3
	text "!"

	para "<PLAYER>, oder?"
	line "Guten Abend!"
	done

AlanGreetText:
	text "Hallo! Ich bin's,"
	line ""
	text_ram wStringBuffer3
	text "!"
	done

AlanGreetDayText:
	text "Hallo! Ich bin's,"
	line ""
	text_ram wStringBuffer3
	text "!"
	done

AlanGreetNiteText:
	text "Hallo! Ich bin's,"
	line ""
	text_ram wStringBuffer3
	text "!"
	done

AlanGenericText:
	text "<PLAYER>, trai-"
	line "nierst du deine"
	cont "#mon richtig?"

	para "Ich habe gelesen,"
	line "dass man die #-"
	cont "mon, die man fängt"
	cont "mit Liebe und"

	para "Umsicht trainieren"
	line "soll."
	done
