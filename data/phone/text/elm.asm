ElmPhoneStartText:
	text "Hallo, <PLAYER>?"

	para "Übertreib es"
	line "nicht."

	para "Heile deine #-"
	line "mon, falls sie"
	cont "verletzt sind."
	done

ElmPhoneSawMrPokemonText:
	text "Hallo, <PLAYER>?"

	para "Hast du Mr. #-"
	line "mon getroffen? "
	cont "Komm heil wieder!"
	done

ElmPhonePokemonStolenText:
	text "<PLAYER>? Ich bin"
	line "sehr verärgert."

	para "Uns wurde ein"
	line "#mon gestohlen."

	para "Wie kann man so"
	line "etwas nur tun?"
	prompt

ElmPhoneCheckingEggText:
	text "Hallo, <PLAYER>?"

	para "Wir überprüfen das"
	line "Ei. Es scheint"

	para "ein #mon-Ei"
	line "zu sein."
	prompt

ElmPhoneAssistantText:
	text "Hallo, <PLAYER>?"

	para "Hast du meinen"
	line "Assistenten"

	para "getroffen? Er ist"
	line "im #mon-Center"
	cont "in Viola City."
	done

ElmPhoneEggUnhatchedText:
	text "Hallo, <PLAYER>?"

	para "Was macht das Ei?"
	line "Hat es sich"
	cont "verändert?"

	para "Ruf an, falls"
	line "etwas passiert."
	prompt

ElmPhoneEggHatchedText:
	text "Hallo, <PLAYER>?"
	line "Was macht das Ei?"

	para "Wie? Es ist"
	line "geschlüpft? Wow!"

	para "Was für ein"
	line "#mon ist es?"

	para "Komm und zeige es"
	line "mir bitte!"
	prompt

ElmPhoneDiscovery1Text:
	text "Hallo, <PLAYER>?"

	para "Ich habe soeben"
	line "eine neue Ent-"
	cont "deckung gemacht."

	para "Die Zeit, bis es"
	line "aus dem Ei"

	para "schlüpft, hängt"
	line "vom #mon ab."
	prompt

ElmPhoneDiscovery2Text:
	text "Hallo, <PLAYER>?"

	para "Es ist noch nicht"
	line "gelöst, welche"

	para "Attacken junge"
	line "#mon haben."

	para "Das untersuchen"
	line "wir jetzt."
	prompt

ElmPhonePokerusText:
	text "Hello, <PLAYER>?"

	para "I discovered an"
	line "odd thing."

	para "Apparently there's"
	line "something called"

	para "#rus that in-"
	line "fects #mon."

	para "Yes, it's like a"
	line "virus, so it's"
	cont "called #rus."

	para "It multiplies fast"
	line "and infects other"

	para "#mon too. When"
	line "infected, they"

	para "seem to put more"
	line "effort into their"

	para "training. Luckily,"
	line "it isn't harmful."

	para "It goes away"
	line "with time, so"
	cont "don't worry!"
	done

ElmPhoneDisasterText:
	text "H-hallo? <PLAYER>?"
	line "Welch Unglück!"

	para "Uh, um, es ist"
	line "schrecklich!"

	para "Was soll ich tun?"
	line "Es… oh, nein…"

	para "Bitte komm schnell"
	line "zurück!"
	done

ElmPhoneEggAssistantText:
	text "Hallo, <PLAYER>?"
	line "Wir haben etwas"

	para "über das Ei"
	line "herausgefunden!"

	para "Mein Assistent ist"
	line "im #mon-Center"

	para "von Viola City. "
	line "Sprich doch bitte"
	cont "mit ihm?"
	done

ElmPhoneRocketText:
	text "<PLAYER>, wie"
	line "stehen die Dinge?"

	para "Ich rufe an, weil"
	line "etwas Merkwürdiges"

	para "mit den Radiosen-"
	line "dungen geschieht."

	para "Sie redeten über"
	line "Team Rocket."

	para "<PLAYER>, weißt"
	line "du etwas darüber?"

	para "Vielleicht feiert"
	line "Team Rocket ein"

	para "Comeback. Nein,"
	line "das ist nicht"
	cont "wahr."

	para "Sorry für die"
	line "Belästigung. Pass"
	cont "auf dich auf!"
	done

ElmPhoneGiftText:
	text "Hallo, <PLAYER>?"

	para "Ich habe hier"
	line "etwas für dich."

	para "Schaust du mal in"
	line "meinem Labor"
	cont "vorbei?"

	para "Bis später!"
	done

ElmPhoneEvolutionQuestionText:
	text "By the way,"
	line "<PLAYER>, want to"

	para "know how your"
	line "#mon evolves?"
	done

ElmPhoneEvoText_None:
	text "Well, "
	text_ram wStringBuffer3
	line "doesn't evolve!"
	prompt

ElmPhoneEvoText_Level:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "reaches level "
	text_decimal wStringBuffer4, 1, 3
	text "."
	prompt

ElmPhoneEvoText_Item:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line ""
	text_ram wStringBuffer4
	text "."
	prompt

ElmPhoneEvoText_TradeNoItem:
	text_ram wStringBuffer3
	line "evolves by trade,"

	para "or when exposed to"
	line "a "
	text_ram wStringBuffer4
	text "."
	prompt

ElmPhoneEvoText_TradeWithItem:
	text_ram wStringBuffer3
	line "evolves by trade,"

	para "or when gaining a"
	line "level with"
	cont ""
	text_ram wStringBuffer4
	text " held."
	prompt

ElmPhoneEvoText_Holding:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "gains a level"

	para "while holding a"
	line ""
	text_ram wStringBuffer4
	text "."
	prompt

ElmPhoneEvoText_Holding_MornDay:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "gains a level"

	para "while holding a"
	line ""
	text_ram wStringBuffer4
	text ", but"

	para "only during the"
	line "morning or day."
	prompt

ElmPhoneEvoText_Holding_EveNite:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "gains a level"

	para "while holding a"
	line ""
	text_ram wStringBuffer4
	text ", but"

	para "only during the"
	line "evening or night."
	prompt

ElmPhoneEvoText_Happiness:
	text_ram wStringBuffer3
	line "evolves when it's"
	cont "really happy!"
	prompt

ElmPhoneEvoText_Happiness_MornDay:
	text_ram wStringBuffer3
	line "evolves when it's"
	cont "really happy, but"

	para "only during the"
	line "morning or day."
	prompt

ElmPhoneEvoText_Happiness_EveNite:
	text_ram wStringBuffer3
	line "evolves when it's"
	cont "really happy, but"

	para "only during the"
	line "evening or night."
	prompt

ElmPhoneEvoText_Stat:
	text_ram wStringBuffer3
	line "evolves at level"
	cont ""
	text_decimal wStringBuffer4, 1, 3
	text ", but what it"

	para "evolves into de-"
	line "pends on its"

	para "Attack and"
	line "Defense stats."
	prompt

ElmPhoneEvoText_Location:
	text_ram wStringBuffer3
	line "evolves when it"

	para "gains a level at"
	line ""
	text_ram wStringBuffer4
	text "."
	prompt

ElmPhoneEvoText_Move:
	text_ram wStringBuffer3
	line "evolves when it"

	para "gains a level"
	line "while it knows"

	para "how to use"
	line ""
	text_ram wStringBuffer4
	text "."
	prompt

ElmPhoneEvoText_Crit:
	text_ram wStringBuffer3
	line "evolves after it"

	para "lands three crit-"
	line "ical hits in one"
	cont "battle."
	prompt

ElmPhoneEvoText_Party:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "gains a level"

	para "while you have a"
	line ""
	text_ram wStringBuffer4
	text " in"
	cont "your party too."
	prompt

ElmPhoneEvoText_Egg:
	text "Eggs don't evolve,"
	line "they hatch!"
	prompt

ElmPhoneEvoText_Pikachu:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "ThunderStone or"
	cont "an Odd Souvenir."
	prompt

ElmPhoneEvoText_Gloom:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "Leaf Stone or"
	cont "a Sun Stone."
	prompt

ElmPhoneEvoText_Poliwhirl:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "Water Stone, or"

	para "when holding a"
	line "King's Rock, if"

	para "traded, or upon"
	line "leveling up."
	prompt

ElmPhoneEvoText_SlowpokePlain:
ElmPhoneEvoText_SlowpokeGalarian:
	text_ram wStringBuffer3
	line "evolves at level"
	cont "37, or when it"

	para "holds King's Rock"
	line "when traded or"
	cont "gaining a level."
	prompt

ElmPhoneEvoText_Magneton:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "ThunderStone, or"

	para "when it gains a"
	line "level in a mag-"
	cont "netic field."

	para "I've heard Magnet"
	line "Tunnel and Dim"
	cont "Cave have that."
	prompt

ElmPhoneEvoText_Exeggcute:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "Leaf Stone or"
	cont "an Odd Souvenir."
	prompt

ElmPhoneEvoText_Koffing:
	text_ram wStringBuffer3
	line "evolves at level"
	cont "35, or when it"

	para "holds Charcoal"
	line "when traded or"
	cont "gaining a level."
	prompt

ElmPhoneEvoText_Cubone:
	text_ram wStringBuffer3
	line "evolves at level"
	cont "28, or when it's"

	para "exposed to an"
	line "Odd Souvenir."
	prompt

ElmPhoneEvoText_Scyther:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "gains a level"

	para "while holding a"
	line "Metal Coat or a"
	cont "Hard Stone."

	para "The Metal Coat"
	line "can also be held"
	cont "while trading."
	prompt

ElmPhoneEvoText_Eevee:
	text_ram wStringBuffer3
	line "evolves in so"
	cont "many ways!"

	para "It can be exposed"
	line "to any of eight"
	cont "different Stones,"

	para "or gain a level"
	line "near a Moss Rock"
	cont "or an Ice Rock."

	para "I've heard Ilex"
	line "Forest and Ice"
	cont "Path have those."

	para "But also, Eevee"
	line "will evolve just"

	para "from the sun or"
	line "moon if it's very"
	cont "happy!"
	prompt

ElmPhoneEvoText_MimeJr:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to an"
	line "Ice Stone, or"

	para "when it gains a"
	line "level near an"
	cont "Ice Rock."

	para "I've heard there's"
	line "one in Ice Path."
	prompt

ElmPhoneEvoText_Stantler:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to harsh"
	line "hail or sand."

	para "I've heard Rugged"
	line "Road and Snowtop"

	para "Mountain have"
	line "weather like that."
	prompt

ElmPhoneEvoText_AncientSinnoh:
	text "But based on its"
	line "ancestry, it"

	para "may also evolve"
	line "when reminded"

	para "of ancient Sinnoh…"
	line "somehow…"
	prompt

ElmPhoneEvoText_DunsparceSegments:
	text "Some of them end"
	line "up being longer"
	cont "than others."

	para "It's just in their"
	line "genes."
	prompt

ElmPhoneEvolutionRefusedText:
	text "Sorry to bug you"
	line "then."
	prompt

ElmPhoneEndText:
	text "Take care!"
	done
