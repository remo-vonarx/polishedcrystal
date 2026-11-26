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
	text "Hallo, <PLAYER>?"

	para "Ich habe etwas"
	line "Seltsames"
	cont "entdeckt."

	para "Scheinbar gibt es"
	line "einen sogenannten"

	para "#rus, der"
	line "#mon infiziert."

	para "Es ist eine Art"
	line "Virus und wird"

	para "daher #rus"
	line "genannt."

	para "Es vermehrt sich"
	line "rapide und infi-"

	para "ziert andere #-"
	line "mon. Infizierte"

	para "#mon strengen"
	line "sich offenbar"

	para "beim Training mehr"
	line "an. Zum Glück ist"
	cont "es harmlos."

	para "Es verschwindet"
	line "nach einiger Zeit,"
	cont "also keine Sorge!"
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
	text "Übrigens, <PLAYER>,"
	line "willst du wissen,"

	para "wie dein #mon"
	line "sich entwickelt?"
	done

ElmPhoneEvoText_None:
	text "Nun, "
	text_ram wStringBuffer3
	line "entwickelt sich"
	cont "nicht!"
	prompt

ElmPhoneEvoText_Level:
	text_ram wStringBuffer3
	line "entwickelt sich,"
	cont "wenn es Level "
	text_decimal wStringBuffer4, 1, 3
	cont "erreicht."
	prompt

ElmPhoneEvoText_Item:
	text_ram wStringBuffer3
	line "entwickelt sich,"

	para "wenn es mit dem"
	line "Item "
	text_ram wStringBuffer4
	cont "in Kontakt kommt."
	prompt

ElmPhoneEvoText_TradeNoItem:
	text_ram wStringBuffer3
	line "entwickelt sich"
	cont "durch Tausch oder,"

	para "wenn es mit dem"
	line "Item "
	text_ram wStringBuffer4
	cont "in Kontakt kommt."
	prompt

ElmPhoneEvoText_TradeWithItem:
	text_ram wStringBuffer3
	line "entwickelt sich"
	cont "durch Tausch oder,"

	para "wenn sein Level"
	line "steigt und es das"
	cont "Item "
	text_ram wStringBuffer4
	cont "trägt."
	prompt

ElmPhoneEvoText_Holding:
	text_ram wStringBuffer3
	line "entwickelt sich,"
	cont "wenn sein Level"

	para "steigt und es das"
	line "Item "
	text_ram wStringBuffer4
	cont "trägt."
	prompt

ElmPhoneEvoText_Holding_MornDay:
	text_ram wStringBuffer3
	line "entwickelt sich,"
	cont "wenn sein Level"

	para "steigt und es das"
	line "Item "
	text_ram wStringBuffer4
	cont "trägt, aber nur"

	para "am Morgen oder"
	line "am Tag."
	prompt

ElmPhoneEvoText_Holding_EveNite:
	text_ram wStringBuffer3
	line "entwickelt sich,"
	cont "wenn sein Level"

	para "steigt und es das"
	line "Item "
	text_ram wStringBuffer4
	cont "trägt, aber nur"

	para "am Abend oder"
	line "in der Nacht."
	prompt

ElmPhoneEvoText_Happiness:
	text_ram wStringBuffer3
	line "entwickelt sich,"
	cont "wenn es richtig"
	cont "glücklich ist!"
	prompt

ElmPhoneEvoText_Happiness_MornDay:
	text_ram wStringBuffer3
	line "entwickelt sich,"
	cont "wenn es richtig"
	cont "glücklich ist,"

	para "aber nur am Morgen"
	line "oder am Tag."
	prompt

ElmPhoneEvoText_Happiness_EveNite:
	text_ram wStringBuffer3
	line "entwickelt sich,"
	cont "wenn es richtig"
	cont "glücklich ist,"

	para "aber nur am Abend"
	line "oder in der Nacht."
	prompt

ElmPhoneEvoText_Stat:
	text_ram wStringBuffer3
	line "entwickelt sich"
	cont "bei Level "
	text_decimal wStringBuffer4, 1, 3
	text ","

	para "aber wozu es sich"
	line "entwickelt, hängt"

	para "von seinen Werten"
	line "für Angriff und"
	cont "Verteidigung ab."
	prompt

ElmPhoneEvoText_Location:
	text_ram wStringBuffer3
	line "entwickelt sich,"

	para "wenn sein Level an"
	line "diesem Ort steigt:"
	cont ""
	text_ram wStringBuffer4
	text "."
	prompt

ElmPhoneEvoText_Move:
	text_ram wStringBuffer3
	line "entwickelt sich,"

	para "wenn sein Level"
	line "steigt und es die"

	para "Attacke"
	line ""
	text_ram wStringBuffer4
	cont "beherrscht."
	prompt

ElmPhoneEvoText_Crit:
	text_ram wStringBuffer3
	line "entwickelt sich,"

	para "wenn ihm in einem"
	line "Kampf drei Voll-"
	cont "treffer gelingen."
	prompt

ElmPhoneEvoText_Party:
	text_ram wStringBuffer3
	line "entwickelt sich,"
	cont "wenn sein Level"

	para "steigt und du auch"
	line ""
	text_ram wStringBuffer4
	cont "im Team hast."
	prompt

ElmPhoneEvoText_Egg:
	text "Eier entwickeln"
	line "sich nicht, sie"
	cont "schlüpfen!"
	prompt

ElmPhoneEvoText_Pikachu:
	text_ram wStringBuffer3
	line "entwickelt sich,"

	para "wenn es mit einem"
	line "Donnerstein oder"
	cont "einem Kuriosum in"
	cont "Kontakt kommt."
	prompt

ElmPhoneEvoText_Gloom:
	text_ram wStringBuffer3
	line "entwickelt sich,"

	para "wenn es mit einem"
	line "Blattstein oder"
	cont "einem Sonnenstein"
	cont "in Kontakt kommt."
	prompt

ElmPhoneEvoText_Poliwhirl:
	text_ram wStringBuffer3
	line "entwickelt sich,"

	para "wenn es mit einem"
	line "Wasserstein in"
	cont "Kontakt kommt,"

	para "oder wenn es einen"
	line "King-Stein trägt"

	para "und getauscht wird"
	line "oder sein Level"
	cont "steigt."
	prompt

ElmPhoneEvoText_SlowpokePlain:
ElmPhoneEvoText_SlowpokeGalarian:
	text_ram wStringBuffer3
	line "entwickelt sich"
	cont "bei Level 37 oder,"

	para "wenn es einen"
	line "King-Stein trägt"

	para "und getauscht wird"
	line "oder sein Level"
	cont "steigt."
	prompt

ElmPhoneEvoText_Magneton:
	text_ram wStringBuffer3
	line "entwickelt sich,"

	para "wenn es mit einem"
	line "Donnerstein in"
	cont "Kontakt kommt"

	para "oder sein Level"
	line "in einem Magnet-"
	cont "feld steigt."

	para "Im Magnettunnel"
	line "und in der Fin-"
	cont "steren Höhle soll"
	cont "es das geben."
	prompt

ElmPhoneEvoText_Exeggcute:
	text_ram wStringBuffer3
	line "entwickelt sich,"

	para "wenn es mit einem"
	line "Blattstein oder"
	cont "einem Kuriosum in"
	cont "Kontakt kommt."
	prompt

ElmPhoneEvoText_Koffing:
	text_ram wStringBuffer3
	line "entwickelt sich"
	cont "bei Level 35 oder,"

	para "wenn es Holzkohle"
	line "trägt und ge-"
	cont "tauscht wird oder"
	cont "sein Level steigt."
	prompt

ElmPhoneEvoText_Cubone:
	text_ram wStringBuffer3
	line "entwickelt sich"
	cont "bei Level 28 oder,"

	para "wenn es mit einem"
	line "Kuriosum in"
	cont "Kontakt kommt."
	prompt

ElmPhoneEvoText_Scyther:
	text_ram wStringBuffer3
	line "entwickelt sich,"
	cont "wenn sein Level"

	para "steigt und es"
	line "einen Metallmantel"
	cont "oder einen Granit-"
	cont "stein trägt."

	para "Den Metallmantel"
	line "kann es auch beim"
	cont "Tausch tragen."
	prompt

ElmPhoneEvoText_Eevee:
	text_ram wStringBuffer3
	line "kann sich auf so"
	cont "viele Arten"
	cont "entwickeln!"

	para "Es kann mit einem"
	line "von acht verschie-"
	cont "denen Steinen in"
	cont "Kontakt kommen"

	para "oder sein Level"
	line "nahe einem Moos-"
	cont "oder Eisfelsen"
	cont "steigern."

	para "Im Steineichenwald"
	line "und im Eispfad"
	cont "soll es die geben."

	para "Und ist Evoli sehr"
	line "glücklich, ent-"
	cont "wickelt es sich"
	cont "allein durch Sonne"
	cont "oder Mond!"
	prompt

ElmPhoneEvoText_MimeJr:
	text_ram wStringBuffer3
	line "entwickelt sich,"

	para "wenn es mit einem"
	line "Eisstein in"
	cont "Kontakt kommt"

	para "oder sein Level"
	line "nahe einem"
	cont "Eisfelsen steigt."

	para "Im Eispfad soll es"
	line "einen geben."
	prompt

ElmPhoneEvoText_Stantler:
	text_ram wStringBuffer3
	line "entwickelt sich,"

	para "wenn es heftigem"
	line "Hagel oder Sand"
	cont "ausgesetzt ist."

	para "Auf dem Holprigen"
	line "Pfad und dem"

	para "Schneegipfel soll"
	line "es solches Wetter"
	cont "geben."
	prompt

ElmPhoneEvoText_AncientSinnoh:
	text "Nach seiner Ab-"
	line "stammung könnte es"

	para "sich aber auch"
	line "entwickeln, wenn"

	para "es an das alte"
	line "Sinnoh erinnert"
	cont "wird… irgendwie…"
	prompt

ElmPhoneEvoText_DunsparceSegments:
	text "Manche werden"
	line "länger als andere."

	para "Das liegt einfach"
	line "in ihren Genen."
	prompt

ElmPhoneEvolutionRefusedText:
	text "Dann entschuldige"
	line "die Störung."
	prompt

ElmPhoneEndText:
	text "Pass auf dich auf!"
	done
