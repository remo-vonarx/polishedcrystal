VanceAnswerPhoneText:
	text "Ja, hallo? Hier"
	line "ist "
	text_ram wStringBuffer3
	text "!"

	para "Moin, <PLAYER>!"

	para "Setzt du Vogel-"
	line "#mon ein?"
	done

VanceAnswerPhoneDayText:
	text "Ja, hallo? Hier"
	line "ist "
	text_ram wStringBuffer3
	text "!"

	para "Moin, <PLAYER>!"

	para "Fliegen deine"
	line "Vogel-#mon?"
	done

VanceAnswerPhoneNiteText:
	text "Ja, hallo? Hier"
	line "ist "
	text_ram wStringBuffer3
	text "!"

	para "N'Abend, <PLAYER>!"
	line "Dürfen sich deine"

	para "Vogel-#mon wil-"
	line "de Sachen ansehen?"
	done

VanceGreetText:
	text "Guten Morgen,"
	line "<PLAYER>!"

	para ""
	text_ram wStringBuffer3
	text " hier!"
	line "Guten Morgen!"
	done

VanceGreetDayText:
	text "Hi, <PLAYER>!"

	para ""
	text_ram wStringBuffer3
	text " hier!"
	line "Erinnerst du dich?"
	done

VanceGreetNiteText:
	text "Guten Abend,"
	line "<PLAYER>!"

	para ""
	text_ram wStringBuffer3
	text " hier!"
	line "Hast du Zeit?"
	done

VanceGenericText:
	text "Geht es dir und"
	line "deinen #mon"
	cont "gut?"

	para "Mein "
	text_ram wStringBuffer4
	text ""
	line "scheint so stark"

	para "werden zu wollen,"
	line "dass es das legen-"
	cont "däre Vogel-#mon"

	para "herausfordern und"
	line "besiegen möchte!"
	done
