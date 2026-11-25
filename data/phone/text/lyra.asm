LyraPhoneGreetingText_Morn:
	text "Oh, <PLAYER>!"
	line "Guten Morgen!"
	prompt

LyraPhoneGreetingText_Day:
	text "Oh, <PLAYER>!"
	line "Wie geht es dir?"
	prompt

LyraPhoneGreetingText_Eve:
	text "Oh, <PLAYER>!"
	line "Guten Abend!"
	prompt

LyraPhoneGreetingText_Nite:
	text "…<PLAYER>!"
	line "Guten Abend!"
	cont "Du bist ja noch"
	cont "spät auf."
	prompt

LyraPhoneLandmarkText:
	text "Wo bist du gerade?"
	line ""
	text_ram wStringBuffer4
	text "?"
	prompt

LyraPhoneKantoText:
	text "Dann bist du ja"
	line "weit drüben in"
	cont "Kanto!"
	prompt

LyraPhoneIslandsText:
	text "Du erkundest eine"
	line "tropische Insel…"

	para "Ich bin neidisch,"
	line "<PLAYER>!"
	prompt

LyraPhoneJohtoText_Generic:
	text "Erzähl mir später"
	line "alles darüber, OK?"
	prompt

LyraPhoneNextMoveQuestionText:
	text "Also, <PLAYER>…"

	para "Soll ich dir"
	line "sagen, wann dein"

	para "#mon seine"
	line "nächste Attacke"
	cont "lernt?"
	done

LyraPhoneNextMoveRefusedText:
	text "Haha, dann verrate"
	line "ich es nicht!"
	prompt

LyraPhoneNextMoveLevelText:
	text_ram wStringBuffer3
	line "lernt seine"
	cont "nächste Attacke"
	cont "auf Level "
	text_decimal hScriptVar, 1, 3
	text ":"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

LyraPhoneNoNextMoveText:
	text_ram wStringBuffer3
	line "lernt allein durch"

	para "Levelaufstiege"
	line "keine Attacken"
	cont "mehr."
	prompt

LyraPhoneNoEggMovesText:
	text "Eier lernen keine"
	line "Attacken! …Oder?"
	prompt

LyraPhoneEndText:
	text "Na ja… Es war"
	line "schön, mit dir zu"
	cont "plaudern, <PLAYER>."

	para "Ruf mich doch mal"
	line "wieder an!"
	done

LyraPhoneSpecialText_YellowForest:
	text "Hi, <PLAYER>!"
	line "Wie geht es dir?"

	para "Warst du schon im"
	line "Goldgelben Wald?"

	para "Ich wollte hin,"
	line "aber ich habe"

	para "gehört, dass Team"
	line "Rocket dort etwas"
	cont "im Schilde führt."

	para "Da will ich nicht"
	line "hineingezogen"
	cont "werden!"

	para "Du hast dich Team"
	line "Rocket doch schon"

	para "gestellt, oder,"
	line "<PLAYER>?"

	para "Das ist so mutig"
	line "von dir!"

	para "Jedenfalls viel"
	line "Glück auf deiner"
	cont "Reise!"
	done

LyraPhoneSpecialText_FirstBadge:
	text "<PLAYER>! Hi!"

	para "Ich habe gerade"
	line "meinen ersten"
	cont "Arena-Orden"
	cont "bekommen!"

	para "Falks Tauboss ist"
	line "stark, aber meins"
	cont "hat ihn besiegt!"

	para "Das musste ich dir"
	line "einfach erzählen,"
	cont "<PLAYER>."

	para "Oh, du hast deinen"
	line "ersten Orden in"
	cont "Kanto? Super!"

	para "Lass uns beide"
	line "weiter Orden"
	cont "gewinnen."

	para "Wir sehen uns in"
	line "der Liga!"
	done

LyraPhoneSpecialText_LyrasEgg:
	text "<PLAYER>! Hi!"

	para "Schlägst du dich"
	line "gut gegen Kantos"
	cont "Arenaleiter?"

	para "Ganz bestimmt!"

	para "Hör zu, hör zu!"

	para "Ich habe mein"
	line ""
	text_ram wStringBuffer4
	text " bei"
	cont "Oma und Opa in der"
	cont "Pension gelassen,"

	para "und sie haben ein"
	line "Ei gefunden!"

	para "Ist das nicht"
	line "toll?"

	para "Ich ziehe ein"
	line "ganzes Team aus"
	cont "#mon auf, also,"

	para "äh, falls du es"
	line "haben möchtest…"

	para "Das heißt… Wie"
	line "auch immer, ich"

	para "habe das Ei in der"
	line "Pension gelassen,"
	cont "falls du es"
	cont "willst!"

	para "Ich weiß, dass du"
	line "dich gut darum"
	cont "kümmerst, <PLAYER>."

	para "Tschüss!"
	done
