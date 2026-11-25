SECTION "_FruitBearingTreeText", ROMX
_FruitBearingTreeText::
	text "Es ist ein"
	line "Obstbaum."
	done

SECTION "_HeyItsFruitText", ROMX
_HeyItsFruitText::
	text "Hey! Das ist eine"
	line ""
	text_ram wStringBuffer3
	text "!"
	done

SECTION "_ObtainedOneFruitText", ROMX
_ObtainedOneFruitText::
	text_ram wStringBuffer3
	line "erhalten!"
	done

SECTION "_ObtainedTwoFruitText", ROMX
_ObtainedTwoFruitText::
	text "2x "
	text_ram wStringBuffer3
	line "erhalten!"
	done

SECTION "_ObtainedThreeFruitText", ROMX
_ObtainedThreeFruitText::
	text "3x "
	text_ram wStringBuffer3
	line "erhalten!"
	done

SECTION "_FruitPackIsFullText", ROMX
_FruitPackIsFullText::
	text "Aber der Beutel"
	line "ist voll…"
	done

SECTION "_NoApricornBoxText", ROMX
_NoApricornBoxText::
	text "Aber du hast"
	line "nichts, um sie"
	cont "hineinzutun…"
	done

SECTION "_ApricornBoxIsFullText", ROMX
_ApricornBoxIsFullText::
	text "Die Aprikokobox"
	line "ist aber voll…"
	done

SECTION "_PutAwayTheApricornText", ROMX
_PutAwayTheApricornText::
	text "<PLAYER> steckt"
	line ""
	text_ram wStringBuffer3
	text " in"
	cont "die Aprikokobox."
	done

SECTION "_NothingHereText", ROMX
_NothingHereText::
	text "Hier ist"
	line "nichts…"
	done

SECTION "_WantToUseMulchText", ROMX
_WantToUseMulchText::
	text "Möchtest du"
	line "Mulch einsetzen?"
	done

SECTION "_UsedMulchText", ROMX
_UsedMulchText::
	text "<PLAYER> setzt"
	line "Mulch ein!"

	para "Der Baum wurde"
	line "gedüngt!"
	done

SECTION "_WhichApricornText", ROMX
_WhichApricornText::
	text "Welche Aprikoko"
	line "soll ich benutzen?"
	done

SECTION "_HowManyShouldIMakeText", ROMX
_HowManyShouldIMakeText::
	text "Wie viele soll ich"
	line "fertigen?"
	done

SECTION "_HowManyDoYouWantToSellText", ROMX
_HowManyDoYouWantToSellText::
	text "Wie viele möchtest"
	line "du verkaufen?"
	done

SECTION "_RecoveredSomeHPText", ROMX
_RecoveredSomeHPText::
	text_ram wStringBuffer1
	text ""
	line "erhält "
	text_decimal wCurHPAnimDeltaHP, 2, 3
	text " KP!"
	done

SECTION "_CuredOfPoisonText", ROMX
_CuredOfPoisonText::
	text "Die Vergiftung von"
	line ""
	text_ram wStringBuffer1
	text ""
	cont "wurde geheilt."
	done

SECTION "_RidOfParalysisText", ROMX
_RidOfParalysisText::
	text "Die Paralyse von"
	line ""
	text_ram wStringBuffer1
	text ""
	cont "wurde aufgehoben."
	done

SECTION "_BurnWasHealedText", ROMX
_BurnWasHealedText::
	text "Verbrennung von"
	line ""
	text_ram wStringBuffer1
	text ""
	cont "wurde geheilt."
	done

SECTION "_WasDefrostedText", ROMX
_WasDefrostedText::
	text_ram wStringBuffer1
	text ""
	line "wurde aufgetaut."
	done

SECTION "_WokeUpText", ROMX
_WokeUpText::
	text_ram wStringBuffer1
	text ""
	line "ist aufgewacht."
	done

SECTION "_HealthReturnedText", ROMX
_HealthReturnedText::
	text_ram wStringBuffer1
	text ""
	line "ist wieder fit."
	done

SECTION "_RevitalizedText", ROMX
_RevitalizedText::
	text_ram wStringBuffer1
	text ""
	line "ist wieder fit."
	done

SECTION "_GrewToLevelText", ROMX
_GrewToLevelText::
	text_ram wStringBuffer1
	text " er-"
	line "reicht Level "
	text_decimal wCurPartyLevel, 1, 3
	text "!"
	text_sound SFX_DEX_FANFARE_50_79
	text_promptbutton
	text_end

SECTION "_CameToItsSensesText", ROMX
_CameToItsSensesText::
	text_ram wStringBuffer1
	text " kommt"
	line "wieder zu sich."
	done

SECTION "_OakTimeWokeUpText", ROMX
_OakTimeWokeUpText::
	text "………………………………"
	line "………………………………"

	para "Zzz… Hm? Was…?"
	line "Du hast mich auf-"
	cont "geweckt. Kannst du"

	para "mir sagen, wie"
	line "spät es ist?"
	prompt

SECTION "_OakTimeWhatTimeIsItText", ROMX
_OakTimeWhatTimeIsItText::
	text "Wie spät ist es?"
	done

SECTION "_OakTimeHowManyMinutesText", ROMX
_OakTimeHowManyMinutesText::
	text "Wie viele Minuten?"
	done

SECTION "_OakTimeWhoaText", ROMX
_OakTimeWhoaText::
	text "Wow!"
	done

SECTION "_OakTimeQuestionMarkText", ROMX
_OakTimeQuestionMarkText::
	text "?"
	done

SECTION "_OakTimeOversleptText", ROMX
_OakTimeOversleptText::
	text "!"
	line "Ich habe"
	cont "verschlafen!"
	done

SECTION "_OakTimeYikesText", ROMX
_OakTimeYikesText::
	text "!"
	line "Uah! Ich habe"
	cont "verschlafen!"
	done

SECTION "ProfElmNappedText", ROMX
ProfElmNappedText::
	text "!"
	line "Mein Nickerchen"
	cont "war zu lang!"
	done

SECTION "_OakTimeSoDarkText", ROMX
_OakTimeSoDarkText::
	text "!"
	line "Kein Wunder, dass"
	cont "es so dunkel ist!"
	done

SECTION "_OakTimeWhatDayIsItText", ROMX
_OakTimeWhatDayIsItText::
	text "Welcher Tag ist"
	line "heute?"
	done

SECTION "_OakTimeIsItText", ROMX
_OakTimeIsItText::
	text ", oder?"
	done

SECTION "_NothingToChooseText", ROMX
_NothingToChooseText::
	text "Es gibt nichts"
	line "zum Auswählen."
	prompt

SECTION "_WhichSidePutOnText", ROMX
_WhichSidePutOnText::
	text "Auf welcher Seite"
	line "willst du sie"
	cont "ablegen?"
	done

SECTION "_WhichSidePutAwayText", ROMX
_WhichSidePutAwayText::
	text "Welche Seite"
	line "willst du ablegen?"
	done

SECTION "_PutAwayTheDecoText", ROMX
_PutAwayTheDecoText::
	text_ram wStringBuffer3
	text ""
	line "ablegen."
	prompt

SECTION "_NothingToPutAwayText", ROMX
_NothingToPutAwayText::
	text "Hier ist nichts"
	line "zum Ablegen."
	prompt

SECTION "_SetUpTheDecoText", ROMX
_SetUpTheDecoText::
	text "Dekoriere dein"
	line "Zimmer mit"
	para ""
	text_ram wStringBuffer3
	text "."
	prompt

SECTION "_PutAwayAndSetUpText", ROMX
_PutAwayAndSetUpText::
	text "Entferne"
	line ""
	text_ram wStringBuffer3
	text ""

	para "und dekoriere mit"
	line ""
	text_ram wStringBuffer4
	text "."
	prompt

SECTION "_AlreadySetUpText", ROMX
_AlreadySetUpText::
	text "Das ist schon"
	line "in deinem Zimmer."
	prompt

SECTION "_LookTownMapText", ROMX
_LookTownMapText::
	text "Das ist die Karte."
	done

SECTION "_LookPikachuPosterText", ROMX
_LookPikachuPosterText::
	text "Das ist ein Poster"
	line "eines niedlichen"
	cont "Pikachus."
	done

SECTION "_LookClefairyPosterText", ROMX
_LookClefairyPosterText::
	text "Das ist ein Poster"
	line "eines niedlichen"
	cont "Piepis."
	done

SECTION "_LookJigglypuffPosterText", ROMX
_LookJigglypuffPosterText::
	text "Das ist ein Poster"
	line "eines niedlichen"
	cont "Marills."
	done

SECTION "_LookAdorableDecoText", ROMX
_LookAdorableDecoText::
	text "Sehr bezaubernd:"
	line ""
	text_ram wStringBuffer3
	text "."
	done

SECTION "DecoConsoleText", ROMX
DecoConsoleText::
	text "Schön glänzend:"
	line ""
	text_ram wStringBuffer3
	text "."
	done

SECTION "_LookGiantDecoText", ROMX
_LookGiantDecoText::
	text "Eine Riesenpuppe!"
	line "Sie ist flauschig"
	cont "und weich."
	done

SECTION "_MomHiHowAreYouText", ROMX
_MomHiHowAreYouText::
	text "Hi, <PLAYER>!"
	line "Wie geht es dir?"
	prompt

SECTION "_MomFoundAnItemText", ROMX
_MomFoundAnItemText::
	text "Ich habe beim"
	line "Einkaufen ein"
	cont "nützliches Item"
	cont "gefunden und"
	prompt

SECTION "_MomBoughtWithYourMoneyText", ROMX
_MomBoughtWithYourMoneyText::
	text "ich habe dieses"
	line "dekorative Item"
	para "von deinem Geld"
	line "gekauft!"
	prompt

SECTION "_MomItsInPCText", ROMX
_MomItsInPCText::
	text "Es ist in deinem"
	line "PC. Es wird dir"
	cont "gefallen!"
	done

SECTION "_MomFoundADollText", ROMX
_MomFoundADollText::
	text "Beim Einkaufen"
	line "heute habe ich"
	cont "eine tolle Puppe"
	cont "gesehen und"
	prompt

SECTION "_MomItsInYourRoomText", ROMX
_MomItsInYourRoomText::
	text "Sie ist in deinem"
	line "Zimmer. Du wirst"
	cont "sie lieben!"
	done

SECTION "_MonWasSentToText", ROMX
_MonWasSentToText::
	text_ram wPlayerTrademonSpeciesName
	text " ge-"
	line "sendet an "
	text_ram wOTTrademonSenderName
	text "."
	done

SECTION "_BidsFarewellToMonText", ROMX
_BidsFarewellToMonText::
	text "Lebwohl,"
	line ""
	text_ram wOTTrademonSpeciesName
	done

SECTION "_MonNameBidsFarewellText", ROMX
_MonNameBidsFarewellText::
	text "sagt "
	text_ram wOTTrademonSenderName
	text "."
	done

SECTION "_TakeGoodCareOfMonText", ROMX
_TakeGoodCareOfMonText::
	text "Kümmere dich um"
	line ""
	text_ram wOTTrademonSpeciesName
	text "."
	done

SECTION "_ForYourMonSendsText", ROMX
_ForYourMonSendsText::
	text "Für "
	text_ram wPlayerTrademonSenderName
	text "s"
	line ""
	text_ram wPlayerTrademonSpeciesName
	done

SECTION "_OTSendsText", ROMX
_OTSendsText::
	text "überträgt "
	text_ram wOTTrademonSenderName
	text ""
	line ""
	text_ram wOTTrademonSpeciesName
	text "."
	done

SECTION "_WillTradeText", ROMX
_WillTradeText::
	text_ram wOTTrademonSenderName
	text " tauscht"
	line ""
	text_ram wOTTrademonSpeciesName
	text_end

SECTION "_ForYourMonWillTradeText", ROMX
_ForYourMonWillTradeText::
	text "gegen "
	text_ram wPlayerTrademonSenderName
	text "s"
	line ""
	text_ram wPlayerTrademonSpeciesName
	text "."
	done

; Oak's Pokémon Talk

SECTION "_OPT_IntroText1", ROMX
_OPT_IntroText1::
	line "Mary: Prof.Oak's"
	done

SECTION "_OPT_IntroText2", ROMX
_OPT_IntroText2::
	line "#mon-Talk!"
	done

SECTION "_OPT_IntroText3", ROMX
_OPT_IntroText3::
	line "Mit Margit!"
	done

SECTION "_OPT_OakText1", ROMX
_OPT_OakText1::
	line "Eich: "
	text_ram wMonOrItemNameBuffer
	done

SECTION "_OPT_OakText2", ROMX
_OPT_OakText2::
	line "wurde gesehen auf"
	done

SECTION "_OPT_OakText3", ROMX
_OPT_OakText3::
	line ""
	text_ram wStringBuffer1
	text "."
	done

SECTION "_OPT_MaryText1", ROMX
_OPT_MaryText1::
	line "Margit: "
	text_ram wStringBuffer1
	done

SECTION "OPT_SweetAdorably", ROMX
OPT_SweetAdorably::
	line "Wie bezaubernd."
	done

SECTION "OPT_WigglySlickly", ROMX
OPT_WigglySlickly::
	line "Wie smart."
	done

SECTION "OPT_AptlyNamed", ROMX
OPT_AptlyNamed::
	line "Wie reizend."
	done

SECTION "OPT_UndeniablyKindOf", ROMX
OPT_UndeniablyKindOf::
	line "Wie freundlich."
	done

SECTION "OPT_Unbearably", ROMX
OPT_Unbearably::
	line "Nicht zu ertragen…"
	done

SECTION "OPT_WowImpressively", ROMX
OPT_WowImpressively::
	line "Wow, faszinierend."
	done

SECTION "OPT_AlmostPoisonously", ROMX
OPT_AlmostPoisonously::
	line "Fast giftig."
	done

SECTION "OPT_Sensually", ROMX
OPT_Sensually::
	line "Wie einfühlsam."
	done

SECTION "OPT_Mischievously", ROMX
OPT_Mischievously::
	line "So schelmisch."
	done

SECTION "OPT_Topically", ROMX
OPT_Topically::
	line "Sehr aktuell."
	done

SECTION "OPT_Addictively", ROMX
OPT_Addictively::
	line "Suchterregend."
	done

SECTION "OPT_LooksInWater", ROMX
OPT_LooksInWater::
	line "Schaut ins Wasser."
	done

SECTION "OPT_EvolutionMustBe", ROMX
OPT_EvolutionMustBe::
	line "Entwicklung, ja."
	done

SECTION "OPT_Provocatively", ROMX
OPT_Provocatively::
	line "Wie provozierend."
	done

SECTION "OPT_FlippedOut", ROMX
OPT_FlippedOut::
	line "Wie ausgeflippt."
	done

SECTION "OPT_HeartMeltingly", ROMX
OPT_HeartMeltingly::
	line "Wie wunderbar."
	done

SECTION "OPT_Cute", ROMX
OPT_Cute::
	line "Wie niedlich."
	done

SECTION "OPT_Weird", ROMX
OPT_Weird::
	line "Wie verrückt."
	done

SECTION "OPT_Pleasant", ROMX
OPT_Pleasant::
	line "Wie angenehm."
	done

SECTION "OPT_BoldSortOf", ROMX
OPT_BoldSortOf::
	line "Wie dreist."
	done

SECTION "OPT_Frightening", ROMX
OPT_Frightening::
	line "Furchterregend."
	done

SECTION "OPT_SuaveDebonair", ROMX
OPT_SuaveDebonair::
	line "Wie weltmännisch!"
	done

SECTION "OPT_Powerful", ROMX
OPT_Powerful::
	line "Wie stark."
	done

SECTION "OPT_Exciting", ROMX
OPT_Exciting::
	line "Wie aufregend."
	done

SECTION "OPT_Groovy", ROMX
OPT_Groovy::
	line "Jetzt!"
	done

SECTION "OPT_Inspiring", ROMX
OPT_Inspiring::
	line "Wie inspirierend."
	done

SECTION "OPT_Friendly", ROMX
OPT_Friendly::
	line "Wie freundlich."
	done

SECTION "OPT_HotHotHot", ROMX
OPT_HotHotHot::
	line "Wie interessant!"
	done

SECTION "OPT_Stimulating", ROMX
OPT_Stimulating::
	line "Wie anregend."
	done

SECTION "OPT_Guarded", ROMX
OPT_Guarded::
	line "Gut geschützt."
	done

SECTION "OPT_Lovely", ROMX
OPT_Lovely::
	line "Wie lieblich."
	done

SECTION "OPT_Speedy", ROMX
OPT_Speedy::
	line "Wie rasant."
	done

SECTION "_OPT_PokemonChannelText", ROMX
_OPT_PokemonChannelText::
	text "#mon"
	done

; Pokémon Music Channel / Pokémusic

SECTION "_BenIntroText1", ROMX
_BenIntroText1::
	line "Ben: #mon-Musik"
	done

SECTION "_BenIntroText2", ROMX
_BenIntroText2::
	line "Channel! ♪"
	done

SECTION "_BenIntroText3", ROMX
_BenIntroText3::
	line "It's me, DJ Ben! ♪"
	done

SECTION "_FernIntroText1", ROMX
_FernIntroText1::
	line "Fern: #music! ♪"
	done

SECTION "_FernIntroText2", ROMX
_FernIntroText2::
	line "With DJ Fern! ♪"
	done

SECTION "_BenFernText1", ROMX
_BenFernText1::
	line "Es ist "
	text_today
	text "!"
	done

SECTION "_BenFernText2A", ROMX
_BenFernText2A::
	line "so let's jam to"
	done

SECTION "_BenFernText2B", ROMX
_BenFernText2B::
	line "Entspann dich beim"
	done

SECTION "_BenFernText3A", ROMX
_BenFernText3A::
	line "#mon-Marsch!"
	done

SECTION "_BenFernText3B", ROMX
_BenFernText3B::
	line "PKMN-Schlaflied!"
	done

; Lucky Channel

SECTION "_LC_Text1", ROMX
_LC_Text1::
	line "Bastian: Yeah! Wie"
	done

SECTION "_LC_Text2", ROMX
_LC_Text2::
	line "geht es euch nun?"
	done

SECTION "_LC_Text3", ROMX
_LC_Text3::
	line "Geht es gut, oder"
	done

SECTION "_LC_Text4", ROMX
_LC_Text4::
	line "geht es nicht,"
	done

SECTION "_LC_Text5", ROMX
_LC_Text5::
	line "die Glückszahlshow"
	done

SECTION "_LC_Text6", ROMX
_LC_Text6::
	line "ist immer Pflicht!"
	done

SECTION "_LC_Text7", ROMX
_LC_Text7::
	line "Today's Lucky"
	done

SECTION "_LC_Text8", ROMX
_LC_Text8::
	line ""
	text_pause
	text_ram wStringBuffer1
	text "!"
	done

SECTION "_LC_Text9", ROMX
_LC_Text9::
	line "Ich wiederhole!"
	done

SECTION "_LC_Text10", ROMX
_LC_Text10::
	line "Gewonnen? Kommt"
	done

SECTION "_LC_Text11", ROMX
_LC_Text11::
	line "zum Radioturm!"
	done

SECTION "_LC_DragText1", ROMX
_LC_DragText1::
	line "…Die Wiederholung"
	done

SECTION "_LC_DragText2", ROMX
_LC_DragText2::
	line "verzögert alles…"
	done

; Places and People

SECTION "_PnP_Text1", ROMX
_PnP_Text1::
	line "Orte und Personen!"
	done

SECTION "_PnP_Text2", ROMX
_PnP_Text2::
	line "Moderiert von"
	done

SECTION "_PnP_Text3", ROMX
_PnP_Text3::
	line "DJ Lilly!"
	done

SECTION "_PnP_Text4", ROMX
_PnP_Text4::
	line ""
	text_ram wStringBuffer2
	text " "
	text_ram wStringBuffer1
	done

SECTION "_PnP_cute", ROMX
_PnP_cute::
	line "ist niedlich."
	done

SECTION "_PnP_lazy", ROMX
_PnP_lazy::
	line "irgendwie faul."
	done

SECTION "_PnP_happy", ROMX
_PnP_happy::
	line "ist immer heiter."
	done

SECTION "_PnP_noisy", ROMX
_PnP_noisy::
	line "ist ziemlich laut."
	done

SECTION "_PnP_precocious", ROMX
_PnP_precocious::
	line "ist frühreif."
	done

SECTION "_PnP_bold", ROMX
_PnP_bold::
	line "ist wohl dreist."
	done

SECTION "_PnP_picky", ROMX
_PnP_picky::
	line "ist zu wählerisch!"
	done

SECTION "_PnP_sortofok", ROMX
_PnP_sortofok::
	line "ist O.K."
	done

SECTION "_PnP_soso", ROMX
_PnP_soso::
	line "geht so."
	done

SECTION "_PnP_great", ROMX
_PnP_great::
	line "ist großartig."
	done

SECTION "_PnP_mytype", ROMX
_PnP_mytype::
	line "ist mein Typ."
	done

SECTION "_PnP_cool", ROMX
_PnP_cool::
	line "ist so cool, oder?"
	done

SECTION "_PnP_inspiring", ROMX
_PnP_inspiring::
	line "ist inspirierend!"
	done

SECTION "_PnP_weird", ROMX
_PnP_weird::
	line "ist verrückt."
	done

SECTION "_PnP_rightforme", ROMX
_PnP_rightforme::
	line "ist genau richtig?"
	done

SECTION "_PnP_odd", ROMX
_PnP_odd::
	line "ist merkwürdig!"
	done

SECTION "_PnP_Text5", ROMX
_PnP_Text5::
	line ""
	text_ram wStringBuffer1
	done

SECTION "_RocketRadioText1", ROMX
_RocketRadioText1::
	line "… …Ähm, wir sind"
	done

SECTION "_RocketRadioText2", ROMX
_RocketRadioText2::
	line "Team Rocket!"
	done

SECTION "_RocketRadioText3", ROMX
_RocketRadioText3::
	line "Nach drei Jahren"
	done

SECTION "_RocketRadioText4", ROMX
_RocketRadioText4::
	line "Vorbereitung sind"
	done

SECTION "_RocketRadioText5", ROMX
_RocketRadioText5::
	line "wir bereit für"
	done

SECTION "_RocketRadioText6", ROMX
_RocketRadioText6::
	line "unser Comeback!"
	done

SECTION "_RocketRadioText7", ROMX
_RocketRadioText7::
	line "Giovanni! "
	text_pause
	text "Hörst"
	done

SECTION "_RocketRadioText8", ROMX
_RocketRadioText8::
	line "du uns?"
	text_pause
	text " Geschafft!"
	done

SECTION "_RocketRadioText9", ROMX
_RocketRadioText9::
	line ""
	text_pause
	text "Wo ist unser Boss?"
	done

SECTION "_RocketRadioText10", ROMX
_RocketRadioText10::
	line ""
	text_pause
	text "Hört er zu?"
	done

SECTION "_BuenaRadioText1", ROMX
_BuenaRadioText1::
	line "Buena: Buena hier!"
	done

SECTION "_BuenaRadioText2", ROMX
_BuenaRadioText2::
	line "Heutiges Passwort!"
	done

SECTION "_BuenaRadioText3", ROMX
_BuenaRadioText3::
	line "Moment… es lautet"
	done

SECTION "_BuenaRadioText4", ROMX
_BuenaRadioText4::
	line ""
	text_ram wStringBuffer1
	text "!"
	done

SECTION "_BuenaRadioText5", ROMX
_BuenaRadioText5::
	line "Vergesst es nicht!"
	done

SECTION "_BuenaRadioText6", ROMX
_BuenaRadioText6::
	line "Ich bin im Radio-"
	done

SECTION "_BuenaRadioText7", ROMX
_BuenaRadioText7::
	line "Turm von Dukatia!"
	done

SECTION "_BuenaRadioMidnightText1", ROMX
_BuenaRadioMidnightText1::
	line "Buena: Oh, es ist…"
	done

SECTION "_BuenaRadioMidnightText2", ROMX
_BuenaRadioMidnightText2::
	line "Mitternacht!"
	done

SECTION "_BuenaRadioMidnightText3", ROMX
_BuenaRadioMidnightText3::
	line "Ich muss aufhören!"
	done

SECTION "_BuenaRadioMidnightText4", ROMX
_BuenaRadioMidnightText4::
	line "Danke, Zuhörer!"
	done

SECTION "_BuenaRadioMidnightText5", ROMX
_BuenaRadioMidnightText5::
	line "Das Ende naht!"
	done

SECTION "_BuenaRadioMidnightText6", ROMX
_BuenaRadioMidnightText6::
	line "Bleibt nicht zu"
	done

SECTION "_BuenaRadioMidnightText7", ROMX
_BuenaRadioMidnightText7::
	line "lange auf! Euer"
	done

SECTION "_BuenaRadioMidnightText8", ROMX
_BuenaRadioMidnightText8::
	line "DJ Buena!"
	done

SECTION "_BuenaRadioMidnightText9", ROMX
_BuenaRadioMidnightText9::
	line "Ich muss weg!"
	done

SECTION "_BuenaRadioMidnightText10", ROMX
_BuenaRadioMidnightText10::
	line "…"
	done

SECTION "_BuenaOffTheAirText", ROMX
_BuenaOffTheAirText::
	line ""
	done

SECTION "Text_EnemyUsed", ROMX
Text_EnemyUsed::
	text "<ENEMY>"
	line "setzt "
	text_ram wMonOrItemNameBuffer
	text ""
	cont "ein!"
	prompt

SECTION "Text_EnemyUsedOn", ROMX
Text_EnemyUsedOn::
	text "<ENEMY>"
	line "setzt "
	text_ram wMonOrItemNameBuffer
	text ""
	cont "bei"
	para ""
	text_ram wEnemyMonNickname
	text ""
	line "ein!"
	prompt

SECTION "_AskFloorElevatorText", ROMX
_AskFloorElevatorText::
	text "Welcher Stock?"
	done

SECTION "_BugCatchingContestTimeUpText", ROMX
_BugCatchingContestTimeUpText::
	text "Sprecher: BIEP!"

	para "Die Zeit ist um!"
	done

SECTION "_BugCatchingContestIsOverText", ROMX
_BugCatchingContestIsOverText::
	text "Sprecher: Der"
	line "Wettkampf ist"
	cont "vorbei!"
	done

SECTION "_RepelWoreOffText", ROMX
_RepelWoreOffText::
	text "Schutz wirkt"
	line "nicht mehr."
	done

SECTION "UseAnotherRepelText", ROMX
UseAnotherRepelText::
	text "Schutz wirkt"
	line "nicht mehr."

	para "Noch einen"
	line "einsetzen?"
	done

SECTION "_JustSawSomeRareMonText", ROMX
_JustSawSomeRareMonText::
	text "Ich sah seltene"
	line ""
	text_ram wStringBuffer1
	text " bei"
	cont ""
	text_ram wStringBuffer2
	text "."

	para "Ich rufe an, wenn"
	line "ich ein anderes"
	cont "seltenes #mon"
	cont "sehe, in Ordnung?"
	prompt

SECTION "_SavingRecordText", ROMX
_SavingRecordText::
	text "Speichern…"
	line ""
	done

SECTION "_NoCoinsText", ROMX
_NoCoinsText::
	text "Du hast keine"
	line "Münzen."
	prompt

SECTION "_NoCoinCaseText", ROMX
_NoCoinCaseText::
	text "Du hast keinen"
	line "Münzkorb."
	prompt

SECTION "_NPCTradeCableText", ROMX
_NPCTradeCableText::
	text "O.K., benutze das"
	line "Game Link-Kabel."
	prompt

SECTION "Text_NPCTraded", ROMX
Text_NPCTraded::
	text "<PLAYER> tauscht"
	line ""
	text_ram wMonOrItemNameBuffer
	text " gegen"
	cont ""
	text_ram wStringBuffer2
	text "."
	done

SECTION "_NPCTradeFanfareText", ROMX
_NPCTradeFanfareText::
	text_sound SFX_DEX_FANFARE_80_109
	text_pause
	text_end

SECTION "_NPCTradeIntroText1", ROMX
_NPCTradeIntroText1::
	text "Ich sammle #-"
	line "mon. Hast du ein"
	cont ""
	text_ram wStringBuffer1
	text "?"

	para "Möchtest du es"
	line "gegen mein"

	para ""
	text_ram wStringBuffer2
	text ""
	line "tauschen?"
	done

SECTION "_NPCTradeCancelText1", ROMX
_NPCTradeCancelText1::
	text "Du möchtest nicht"
	line "tauschen? Schade…"
	done

SECTION "_NPCTradeWrongText1", ROMX
_NPCTradeWrongText1::
	text "Häh? Das ist kein"
	line ""
	text_ram wStringBuffer1
	text "."
	cont "Wie enttäuschend…"
	done

SECTION "_NPCTradeCompleteText1", ROMX
_NPCTradeCompleteText1::
	text "Yo! Ich habe mir"
	line ""
	text_ram wStringBuffer1
	text ""
	cont "besorgt! Danke!"
	done

SECTION "_NPCTradeAfterText1", ROMX
_NPCTradeAfterText1::
	text "Hi, wie geht es"
	line "meinem "
	text_ram wStringBuffer2
	text "?"
	done

SECTION "_NPCTradeIntroText2", ROMX
_NPCTradeIntroText2::
	text "Hi, ich suche"
	line "ein #mon."

	para "Wenn du ein"
	line ""
	text_ram wStringBuffer1
	text " hast,"

	para "tauschst du es"
	line "gegen mein"
	cont ""
	text_ram wStringBuffer2
	text "?"
	done

SECTION "_NPCTradeCancelText2", ROMX
_NPCTradeCancelText2::
	text "Du hast auch"
	line "keines?"

	para "Das ist wirklich"
	line "enttäuschend…"
	done

SECTION "_NPCTradeWrongText2", ROMX
_NPCTradeWrongText2::
	text "Du hast kein"
	line ""
	text_ram wStringBuffer1
	text "? Das"
	cont "ist schade, na ja."
	done

SECTION "_NPCTradeCompleteText2", ROMX
_NPCTradeCompleteText2::
	text "Großartig! Danke!"

	para "Endlich habe ich"
	line "ein "
	text_ram wStringBuffer1
	text "."
	done

SECTION "_NPCTradeAfterText2", ROMX
_NPCTradeAfterText2::
	text "Dem "
	text_ram wMonOrItemNameBuffer
	text ","
	line "das du mit mir"
	cont "getauscht hast,"
	cont "geht es gut!"
	done

SECTION "_NPCTradeIntroText3", ROMX
_NPCTradeIntroText3::
	text_ram wMonOrItemNameBuffer
	text " ist"
	line "niedlich, aber ich"

	para "habe keines. Hast"
	line "du ein "
	text_ram wStringBuffer1
	text "?"

	para "Möchtest du es"
	line "gegen mein"

	para ""
	text_ram wStringBuffer2
	text ""
	line "tauschen?"
	done

SECTION "_NPCTradeCancelText3", ROMX
_NPCTradeCancelText3::
	text "Du möchtest nicht"
	line "tauschen? Schade…"
	done

SECTION "_NPCTradeWrongText3", ROMX
_NPCTradeWrongText3::
	text "Das ist kein"
	line ""
	text_ram wStringBuffer1
	text "."

	para "Komm wieder, wenn"
	line "du tauschen"
	cont "möchtest."
	done

SECTION "_NPCTradeCompleteText3", ROMX
_NPCTradeCompleteText3::
	text "Danke! Ich wollte"
	line "immer schon ein"
	cont ""
	text_ram wMonOrItemNameBuffer
	text "!"
	done

SECTION "_NPCTradeAfterText3", ROMX
_NPCTradeAfterText3::
	text "Wie geht es dem"
	line "getauschten"
	cont ""
	text_ram wStringBuffer2
	text "?"

	para "Dein "
	text_ram wMonOrItemNameBuffer
	text ""
	line "ist so niedlich!"
	done

SECTION "_NPCTradeCompleteText4", ROMX
_NPCTradeCompleteText4::
	text "Was ist passiert?"
	done

SECTION "_NPCTradeAfterText4", ROMX
_NPCTradeAfterText4::
	text "Tauschen ist"
	line "seltsam…"

	para "Ich muss noch viel"
	line "darüber lernen."
	done

SECTION "_MomLeavingText1", ROMX
_MomLeavingText1::
	text "Das ist ein nied-"
	line "liches #mon."

	para "Wo hast du es"
	line "her?"

	para "…"

	para "Du beginnst also"
	line "ein Abenteuer…"

	para "O.K.! Auch ich"
	line "werde dir helfen."

	para "Aber was kann ich"
	line "für dich tun?"

	para "Ich weiß! Ich"
	line "werde für dich"
	cont "sparen."

	para "Auf einer langen"
	line "Reise ist Geld"
	cont "sehr wichtig."

	para "Soll ich dein"
	line "Geld sparen?"
	done

SECTION "_MomLeavingText2", ROMX
_MomLeavingText2::
	text "O.K., ich verwalte"
	line "deine Ersparnisse."

	para "………………"
	prompt

SECTION "_MomLeavingText3", ROMX
_MomLeavingText3::
	text "Sei auf der Hut."

	para "#mon sind"
	line "deine Kameraden."
	cont "Ihr müsst als Team"
	cont "auftreten."

	para "Also mach's gut!"
	done

SECTION "_MomIsThisAboutYourMoneyText", ROMX
_MomIsThisAboutYourMoneyText::
	text "Hi! Willkommen!"
	line "Ich sehe, du"
	cont "bemühst dich sehr."

	para "Ich habe dein"
	line "Zimmer aufgeräumt."

	para "Ist es wegen"
	line "deinem Geld?"
	done

SECTION "_MomBankWhatDoYouWantToDoText", ROMX
_MomBankWhatDoYouWantToDoText::
	text "Was wirst du"
	line "tun?"
	done

SECTION "_MomStoreMoneyText", ROMX
_MomStoreMoneyText::
	text "Wie viel möchtest"
	line "du sparen?"
	done

SECTION "_MomTakeMoneyText", ROMX
_MomTakeMoneyText::
	text "Wie viel möchtest"
	line "du mitnehmen?"
	done

SECTION "_MomSaveMoneyText", ROMX
_MomSaveMoneyText::
	text "Möchtest du weiter"
	line "Geld sparen?"
	done

SECTION "_MomHaventSavedThatMuchText", ROMX
_MomHaventSavedThatMuchText::
	text "So viel hast du"
	line "nicht gespart."
	prompt

SECTION "_MomNotEnoughRoomInWalletText", ROMX
_MomNotEnoughRoomInWalletText::
	text "So viel kannst du"
	line "nicht mitnehmen."
	prompt

SECTION "_MomInsufficientFundsInWalletText", ROMX
_MomInsufficientFundsInWalletText::
	text "So viel hast"
	line "du nicht."
	prompt

SECTION "_MomNotEnoughRoomInBankText", ROMX
_MomNotEnoughRoomInBankText::
	text "So viel kannst"
	line "du nicht sparen."
	prompt

SECTION "_MomStartSavingMoneyText", ROMX
_MomStartSavingMoneyText::
	text "O.K., ich spare"
	line "für dich! Traue"
	cont "mir!"

	para "<PLAYER>, bleib"
	line "dabei!"
	done

SECTION "_MomStoredMoneyText", ROMX
_MomStoredMoneyText::
	text "Dein Geld ist hier"
	line "sicher! Tschüss!"
	done

SECTION "_MomTakenMoneyText", ROMX
_MomTakenMoneyText::
	text "<PLAYER>, nur nicht"
	line "aufgeben!"
	done

SECTION "_MomJustDoWhatYouCanText", ROMX
_MomJustDoWhatYouCanText::
	text "Gib immer dein"
	line "Bestes."
	done

SECTION "_DayCareManIntroText", ROMX
_DayCareManIntroText::
	text "Ich bin der"
	line "Pensionsleiter."
	cont "Soll ich eines"
	cont "deiner #mon"
	cont "aufziehen?"
	done

SECTION "_DayCareManIntroEggText", ROMX
_DayCareManIntroEggText::
	text "Ich bin der"
	line "Pensionsleiter."
	cont "Kennst du dich"
	cont "mit Eiern aus?"

	para "Ich habe #mon"
	line "mit meiner"
	cont "Frau aufgezogen."

	para "Wir waren ent-"
	line "setzt, als wir ein"
	cont "Ei fanden!"

	para "Das ist doch"
	line "unglaublich, oder?"

	para "Soll ich ein"
	line "#mon aufziehen?"
	done

SECTION "_DayCareLadyIntroText", ROMX
_DayCareLadyIntroText::
	text "Ich bin die"
	line "Pensionsleiterin."

	para "Soll ich eines"
	line "deiner #mon"
	cont "aufziehen?"
	done

SECTION "_DayCareLadyIntroEggText", ROMX
_DayCareLadyIntroEggText::
	text "Ich bin die"
	line "Pensionsleiterin."
	cont "Kennst du dich"
	cont "mit Eiern aus?"

	para "Mein Mann und ich"
	line "haben #mon"
	cont "aufgezogen."

	para "Wir waren er-"
	line "staunt, als wir"
	cont "ein Ei fanden!"

	para "Das ist doch"
	line "unglaublich, oder?"

	para "Soll ich eines"
	line "deiner #mon"
	cont "aufziehen?"
	done

SECTION "_WhatShouldIRaiseText", ROMX
_WhatShouldIRaiseText::
	text "Welches soll"
	line "ich aufziehen?"
	prompt

SECTION "_OnlyOneMonText", ROMX
_OnlyOneMonText::
	text "Oh? Aber du hast"
	line "nur ein #mon."
	prompt

SECTION "_CantAcceptEggText", ROMX
_CantAcceptEggText::
	text "Tut mir Leid, aber"
	line "ich kann kein Ei"
	cont "annehmen."
	prompt

SECTION "_RemoveMailText", ROMX
_RemoveMailText::
	text "Entferne den"
	line "Brief, ehe du mich"
	cont "aufsuchst."
	prompt

SECTION "_LastHealthyMonText", ROMX
_LastHealthyMonText::
	text "Wenn du mir das"
	line "gibst, wer soll"
	cont "dann kämpfen?"
	prompt

SECTION "_IllRaiseYourMonText", ROMX
_IllRaiseYourMonText::
	text "O.K. Ich kümmere"
	line "mich um dein"
	cont ""
	text_ram wStringBuffer1
	text "."
	prompt

SECTION "_ComeBackLaterText", ROMX
_ComeBackLaterText::
	text "Hole es später"
	line "wieder ab."
	done

SECTION "_AreWeGeniusesText", ROMX
_AreWeGeniusesText::
	text "Wir sind genial,"
	line "oder? Möchtest du"
	cont "dein "
	text_ram wStringBuffer1
	text ""
	cont "sehen?"
	done

SECTION "_YourMonHasGrownText", ROMX
_YourMonHasGrownText::
	text "Dein "
	text_ram wStringBuffer1
	line "ist groß geworden."

	para "Es ist um "
	text_decimal wStringBuffer2 + 1, 1, 3
	line "Level gestiegen."

	para "Wenn du dein"
	line "#mon zurück"
	cont "haben möchtest,"
	cont "kostet dich das"
	cont "¥"
	text_decimal wStringBuffer2 + 2, 3, 5
	text "."
	done

SECTION "_PerfectHeresYourMonText", ROMX
_PerfectHeresYourMonText::
	text "Perfekt! Hier ist"
	line "dein #mon."
	prompt

SECTION "_GotBackMonText", ROMX
_GotBackMonText::
	text "<PLAYER> erhält"
	line ""
	text_ram wStringBuffer1
	text "."
	prompt

SECTION "_BackAlreadyText", ROMX
_BackAlreadyText::
	text "Huh? Schon zurück?"
	line "Dein "
	text_ram wStringBuffer1
	text ""

	para "sollte noch ein"
	line "wenig hierbleiben."

	para "Wenn du dein"
	line "#mon zurück-"
	cont "haben möchtest,"
	cont "zahle ¥100."
	done

SECTION "_HaveNoRoomText", ROMX
_HaveNoRoomText::
	text "Du hast keinen"
	line "Platz mehr."
	prompt

SECTION "_NotEnoughMoneyText", ROMX
_NotEnoughMoneyText::
	text "Du hast nicht"
	line "genügend Geld."
	prompt

SECTION "_OhFineThenText", ROMX
_OhFineThenText::
	text "Oh, in Ordnung."
	prompt

SECTION "_ComeAgainText", ROMX
_ComeAgainText::
	text "Komm wieder."
	done

SECTION "_NotYetText", ROMX
_NotYetText::
	text "Noch nicht…"
	done

SECTION "_FoundAnEggAgainText", ROMX
_FoundAnEggAgainText::
	text "Ah, du bist's!"

	para "Dein #mon hatte"
	line "noch ein Ei!"

	para "Möchtest du es?"
	done

SECTION "_FoundAnEggText", ROMX
_FoundAnEggText::
	text "Ah, du bist's!"

	para "Wir haben uns um"
	line "dein #mon"

	para "gekümmert und"
	line "waren sehr"
	cont "erstaunt!"

	para "Dein #mon hatte"
	line "ein Ei!"

	para "Wir wissen nicht,"
	line "wie es dahin"

	para "gekommen ist, dein"
	line "#mon hat es."
	cont "Möchtest du es?"
	done

SECTION "_ReceivedEggText", ROMX
_ReceivedEggText::
	text "<PLAYER> erhält"
	line "das Ei!"
	done

SECTION "_TakeGoodCareOfEggText", ROMX
_TakeGoodCareOfEggText::
	text "Pass gut darauf"
	line "auf."
	done

SECTION "_IllKeepItThanksText", ROMX
_IllKeepItThanksText::
	text "Gut, ich passe"
	line "darauf auf. Danke!"
	done

SECTION "_NoRoomForEggText", ROMX
_NoRoomForEggText::
	text "Du hast keinen"
	line "Platz mehr in"
	cont "deinem Team oder"
	cont "deiner Box. Komm"
	cont "später wieder."
	done

SECTION "_NameRaterHelloText", ROMX
_NameRaterHelloText::
	text "Hallo! Ich bin der"
	line "Namen-Bewerter."

	para "Ich bewerte die"
	line "Namen deiner"
	cont "#mon."

	para "Soll ich einen"
	line "Namen bewerten?"
	done

SECTION "_NameRaterWhichMonText", ROMX
_NameRaterWhichMonText::
	text "Welchen #mon-"
	line "Spitznamen soll"
	cont "ich bewerten?"
	prompt

SECTION "_NameRaterBetterNameText", ROMX
_NameRaterBetterNameText::
	text "Hm… "
	text_ram wStringBuffer1
	text "…"
	line "Das ist kein"
	cont "schlechter Name."

	para "Aber überlege dir"
	line "einen besseren"
	cont "Spitznamen!"

	para "Soll ich ihm einen"
	line "neuen Namen geben?"
	done

SECTION "_NameRaterWhatNameText", ROMX
_NameRaterWhatNameText::
	text "O.K. Welchen"
	line "Namen möchtest"
	cont "du haben?"
	prompt

SECTION "_NameRaterFinishedText", ROMX
_NameRaterFinishedText::
	text "Dieser Name"
	line "ist besser!"

	para "Gut gemacht!"
	done

SECTION "_NameRaterComeAgainText", ROMX
_NameRaterComeAgainText::
	text "O.K. Du kannst"
	line "mich immer be-"
	cont "suchen."
	done

SECTION "_NameRaterPerfectNameText", ROMX
_NameRaterPerfectNameText::
	text "Hm… "
	text_ram wStringBuffer1
	text "?"
	line "Ein wirklich"
	cont "tadelloser Name!"

	para "Kümmere dich gut"
	line "um "
	text_ram wStringBuffer1
	text "."
	done

SECTION "_NameRaterEggText", ROMX
_NameRaterEggText::
	text "Wow… Das ist nur"
	line "ein Ei."
	done

SECTION "_NameRaterSameNameText", ROMX
_NameRaterSameNameText::
	text "Er sieht genauso"
	line "aus, wie der alte,"

	para "aber er ist "
	line "viel besser."

	para "Gut gemacht!"
	done

SECTION "_NameRaterNamedText", ROMX
_NameRaterNamedText::
	text "O.K. Der neue Name"
	line "dieses #mon"
	cont "ist "
	text_ram wStringBuffer1
	text "."
	prompt

SECTION "Text_Gained", ROMX
Text_Gained::
	text_ram wStringBuffer1
	text " erhält@"
	text_end

SECTION "Text_ABoostedStringBuffer2ExpPoints", ROMX
Text_ABoostedStringBuffer2ExpPoints::
	line "spezielle"
	cont ""
	text_decimal wStringBuffer2, 3, 6
	text " EP!"
	prompt

SECTION "Text_StringBuffer2ExpPoints", ROMX
Text_StringBuffer2ExpPoints::
	line ""
	text_decimal wStringBuffer2, 3, 6
	text " EP!"
	prompt

SECTION "Text_GoPkmn", ROMX
Text_GoPkmn::
	text "Los! @"
	text_end

SECTION "Text_DoItPkmn", ROMX
Text_DoItPkmn::
	text "Los! @"
	text_end

SECTION "Text_GoForItPkmn", ROMX
Text_GoForItPkmn::
	text "Los,"
	line "@"
	text_end

SECTION "Text_YourFoesWeakGetmPkmn", ROMX
Text_YourFoesWeakGetmPkmn::
	text "Mach es fertig!"
	line "Los, @"
	text_end

SECTION "Text_BattleMonNick01", ROMX
Text_BattleMonNick01::
	line ""
	text_ram wBattleMonNickname
	text "!"
	done

SECTION "Text_BattleMonNickComma", ROMX
Text_BattleMonNickComma::
	text_ram wBattleMonNickname
	text ",@"
	text_end

SECTION "Text_ThatsEnoughComeBack", ROMX
Text_ThatsEnoughComeBack::
	text " genug!"
	line "Komm zurück!@"
	text_end

SECTION "Text_OKComeBack", ROMX
Text_OKComeBack::
	text " O.K.!"
	line "Komm zurück!@"
	text_end

SECTION "Text_GoodComeBack", ROMX
Text_GoodComeBack::
	text " super!"
	line "Komm zurück!@"
	text_end

SECTION "Text_ComeBack", ROMX
Text_ComeBack::
	text " komm"
	line "zurück!"
	done

SECTION "_BootedTMText", ROMX
_BootedTMText::
	text "TM aktiviert."
	done

SECTION "_BootedHMText", ROMX
_BootedHMText::
	text "VM aktiviert."
	done

SECTION "_ContainedMoveText", ROMX
_ContainedMoveText::
	text "Sie enthält"
	line ""
	text_ram wStringBuffer2
	text "."

	para ""
	text_ram wStringBuffer2
	text ""
	line "einem #mon"
	cont "beibringen?"
	done

SECTION "_TMHMNotCompatibleText", ROMX
_TMHMNotCompatibleText::
	text_ram wStringBuffer2
	text " ist"
	line "nicht kompatibel"
	cont "mit "
	text_ram wStringBuffer1
	text "."

	para "Es kann"
	line ""
	text_ram wStringBuffer2
	text ""
	cont "nicht erlernen."
	prompt

SECTION "_BadgeRequiredText", ROMX
_BadgeRequiredText::
	text "Du benötigst einen"
	line "neuen Orden."
	prompt

SECTION "_CantUseItemText", ROMX
_CantUseItemText::
	text "Du kannst das hier"
	line "nicht benutzen."
	prompt

SECTION "_UseCutText", ROMX
_UseCutText::
	text_ram wStringBuffer2
	text " setzt"
	line "den Zerschneider"
	cont "ein!"
	prompt

SECTION "_CutNothingText", ROMX
_CutNothingText::
	text "Hier kann"
	line "man nichts"
	cont "zerschneiden."
	prompt

SECTION "_AskFlashText", ROMX
_AskFlashText::
	text "Hier ist es"
	line "stockfinster."

	para "Möchtest du Blitz"
	line "einsetzen?"
	done

SECTION "_BlindingFlashText", ROMX
_BlindingFlashText::
	text "Ein gleißender"
	line "Blitz erhellt"
	cont "das Gebiet!"
	text_promptbutton
	text_end

SECTION "_UsedSurfText", ROMX
_UsedSurfText::
	text_ram wStringBuffer2
	text " setzt"
	line "Surfer ein!"
	done

SECTION "_CantSurfText", ROMX
_CantSurfText::
	text "Surfer kann hier"
	line "nicht eingesetzt"
	cont "werden."
	prompt

SECTION "_AlreadySurfingText", ROMX
_AlreadySurfingText::
	text "Surfer ist bereits"
	line "eingesetzt."
	prompt

SECTION "_AskSurfText", ROMX
_AskSurfText::
	text "Die See ist ruhig."
	line "Möchtest du Surfer"
	cont "einsetzen?"
	done

SECTION "_UseWaterfallText", ROMX
_UseWaterfallText::
	text_ram wStringBuffer2
	text " setzt"
	line "Kaskade ein!"
	done

SECTION "_HugeWaterfallText", ROMX
_HugeWaterfallText::
	text "Wow, das ist ein"
	line "großer Wasserfall."
	done

SECTION "_AskWaterfallText", ROMX
_AskWaterfallText::
	text "Möchtest du"
	line "Kaskade einsetzen?"
	done

SECTION "_UseDigText", ROMX
_UseDigText::
	text_ram wStringBuffer2
	text " setzt"
	line "Schaufler ein!"
	done

SECTION "_UseEscapeRopeText", ROMX
_UseEscapeRopeText::
	text "<PLAYER> setzt"
	line "Fluchtseil ein."
	done

SECTION "_CantUseDigText", ROMX
_CantUseDigText::
	text "Das kann hier"
	line "nicht eingesetzt"
	cont "werden."
	done

SECTION "_CantUseTeleportText", ROMX
_CantUseTeleportText::
	text "Das kann hier"
	line "nicht eingesetzt"
	cont "werden."
	done

SECTION "_UseStrengthText", ROMX
_UseStrengthText::
	text_ram wStringBuffer2
	text " setzt"
	line "Stärke ein!"
	done

SECTION "_MoveBoulderText", ROMX
_MoveBoulderText::
	text_ram wStringBuffer1
	text " kann"
	line "Felsen bewegen."
	prompt

SECTION "_AskStrengthText", ROMX
_AskStrengthText::
	text "Ein #mon könnte"
	line "das vielleicht"
	cont "bewegen."

	para "Möchtest du Stärke"
	line "einsetzen?"
	done

SECTION "_BouldersMoveText", ROMX
_BouldersMoveText::
	text "Du kannst jetzt"
	line "Felsen bewegen!"
	done

SECTION "_BouldersMayMoveText", ROMX
_BouldersMayMoveText::
	text "Ein #mon könnte"
	line "das vielleicht"
	cont "bewegen."
	done

SECTION "_UseWhirlpoolText", ROMX
_UseWhirlpoolText::
	text_ram wStringBuffer2
	text " setzt"
	line "Whirlpool ein!"
	prompt

SECTION "_MayPassWhirlpoolText", ROMX
_MayPassWhirlpoolText::
	text "Das ist ein"
	line "teuflischer"
	cont "Strudel!"

	para "Ein #mon könnte"
	line "den Strudel"
	cont "durchqueren."
	done

SECTION "_AskWhirlpoolText", ROMX
_AskWhirlpoolText::
	text "Ein Strudel ist"
	line "im Weg."

	para "Möchtest du"
	line "Whirlpool"
	cont "einsetzen?"
	done

SECTION "_UseHeadbuttText", ROMX
_UseHeadbuttText::
	text_ram wStringBuffer2
	text " setzt"
	line "Kopfnuss ein!"
	prompt

SECTION "_HeadbuttNothingText", ROMX
_HeadbuttNothingText::
	text "Nein. Nichts…"
	done

SECTION "_AskHeadbuttText", ROMX
_AskHeadbuttText::
	text "Vielleicht steckt"
	line "ein #mon in"
	cont "diesem Baum."

	para "Möchtest du Kopf-"
	line "nuss einsetzen?"
	done

SECTION "_UseRockSmashText", ROMX
_UseRockSmashText::
	text_ram wStringBuffer2
	text " setzt"
if DEF(FAITHFUL)
	line "Zertrümmerer ein!"
else
	line "Durchbruch ein!"
endc
	prompt

SECTION "_MaySmashText", ROMX
_MaySmashText::
	text "Ein #mon könnte"
	line "ihn vielleicht"
	cont "zerschmettern."
	done

SECTION "_AskRockSmashText", ROMX
_AskRockSmashText::
	text "Dieser Fels sieht"
	line "zerbrechlich aus."

if DEF(FAITHFUL)
	para "Soll Zertrümmerer"
else
	para "Soll Durchbruch"
endc
	line "eingesetzt werden?"
	done

SECTION "_RodBiteText", ROMX
_RodBiteText::
	text "Uah!"
	line "Da hat etwas"
	cont "angebissen!"
	prompt

SECTION "_RodNothingText", ROMX
_RodNothingText::
	text "Nicht einmal"
	line "angeknabbert!"

	para "Weiterangeln?"
	done

SECTION "_CantGetOffBikeText", ROMX
_CantGetOffBikeText::
	text "Du kannst hier"
	line "nicht absteigen!"
	done

SECTION "_GotOnBikeText", ROMX
_GotOnBikeText::
	text "<PLAYER> steigt"
	line "aufs "
	text_ram wStringBuffer2
	text "."
	done

SECTION "_GotOffBikeText", ROMX
_GotOffBikeText::
	text "<PLAYER> steigt von"
	line ""
	text_ram wStringBuffer2
	text " ab."
	done

SECTION "_AskCutText", ROMX
_AskCutText::
	text "Du kannst den"
	line "Zerschneider hier"
	cont "einsetzen!"

	para "Möchtest du den"
	line "Zerschneider"

	para "einsetzen?"
	done

SECTION "_CanCutText", ROMX
_CanCutText::
	text "Der Zerschneider"
	line "kann hier"
	cont "eingesetzt werden!"
	done

SECTION "_FoundItemText", ROMX
_FoundItemText::
	text "<PLAYER> findet"
	line ""
	text_ram wStringBuffer3
	text "!"
	done

SECTION "_GotTheItemText", ROMX
_GotTheItemText:
	text "<PLAYER> erhält"
	line ""
	text_ram wStringBuffer4
	text "."
	done

SECTION "_ReceivedTheBadgeText", ROMX
_ReceivedTheBadgeText:
; ShowBadgeIcon covers the first line's last two tiles
	text "<PLAYER> erhält"
	line "den "
	text_ram wStringBuffer4
	text "."
	done

SECTION "WhiteoutText", ROMX
WhiteoutText::
	text "<PLAYER> hat kein"
	line "kampffähiges"
	cont "#mon mehr!"

	para "<PLAYER> wird"
	line "ohnmächtig!"
	done

SECTION "WhiteoutToWildText", ROMX
WhiteoutToWildText::
	text "<PLAYER> hat kein"
	line "kampffähiges"
	cont "#mon mehr!"

	para "<PLAYER> gerät in"
	line "Panik und verliert"
	cont "¥"
	text_decimal hMoneyTemp, 3, 7
	text "…"

	para "………………"
	line "………………"

	para "<PLAYER> wird"
	line "ohnmächtig!"
	done

SECTION "WhiteoutToTrainerText", ROMX
WhiteoutToTrainerText::
	text "<PLAYER> hat kein"
	line "kampffähiges"
	cont "#mon mehr!"

	para "<PLAYER> zahlt"
	line "dem Sieger"
	cont "¥"
	text_decimal hMoneyTemp, 3, 7
	text "…"

	para "………………"
	line "………………"

	para "<PLAYER> wird"
	line "ohnmächtig!"
	done

SECTION "ForfeitToTrainerText", ROMX
ForfeitToTrainerText::
	text "<PLAYER> gibt den"
	line "Kampf auf…"

	para "<PLAYER> zahlt"
	line "dem Sieger"
	cont "¥"
	text_decimal hMoneyTemp, 3, 7
	text "…"

	para "………………"
	line "………………"

	para "<PLAYER> wird"
	line "ohnmächtig!"
	done

SECTION "_PoisonFaintText", ROMX
_PoisonFaintText::
	text_ram wStringBuffer3
	line "hat sich von der"
	cont "Vergiftung erholt!"
	prompt

SECTION "_UseSweetHoneyText", ROMX
_UseSweetHoneyText::
	text "<PLAYER> verteilt"
if DEF(FAITHFUL)
	line "den Honig!"
else
	line "den Honig!"
endc
	done

SECTION "_SweetHoneyNothingText", ROMX
_SweetHoneyNothingText::
	text "Hier ist wohl"
	line "nichts…"
	done

SECTION "_SquirtbottleNothingText", ROMX
_SquirtbottleNothingText::
	text "<PLAYER>"
	line "verspritzt Wasser."

	para "Nichts geschieht…"
	done

SECTION "_UseSacredAshText", ROMX
_UseSacredAshText::
	text "Die #mon"
	line "von <PLAYER>"
	cont "wurden geheilt!"
	done

SECTION "Text_AnEGGCantHoldAnItem", ROMX
Text_AnEGGCantHoldAnItem::
	text "Ein Ei kann kein"
	line "Item tragen."
	prompt

SECTION "_AskThrowAwayText", ROMX
_AskThrowAwayText::
	text "Wie viele"
	line "wegwerfen?"
	done

SECTION "_AskQuantityThrowAwayText", ROMX
_AskQuantityThrowAwayText::
	text "Wegwerfen?"
	line ""
	text_decimal wItemQuantityChangeBuffer, 1, 2
	text_plural
	text " "
	text_ram wStringBuffer2
	text "?"
	done

SECTION "_ThrewAwayText", ROMX
_ThrewAwayText::
	text_decimal wItemQuantityChangeBuffer, 1, 2
	text_plural
	text " "
	text_ram wStringBuffer2
	line "weggeworfen."
	prompt

SECTION "_OakThisIsntTheTimeText", ROMX
_OakThisIsntTheTimeText::
	text "Eich: <PLAYER>!"
	line "Es ist noch nicht"
	cont "an der Zeit, dies"
	cont "zu benutzen!"
	prompt

SECTION "Text_YouDontHaveAPkmn", ROMX
Text_YouDontHaveAPkmn::
	text "Du hast kein"
	line "#mon!"
	prompt

SECTION "_RegisteredItemText", ROMX
_RegisteredItemText::
	text_ram wStringBuffer2
	text ""
	line "eingetragen."
	prompt

SECTION "UnregisteredItemText", ROMX
UnregisteredItemText::
	text_ram wStringBuffer2
	line "ausgetragen."
	prompt

SECTION "_CantRegisterText", ROMX
_CantRegisterText::
	text "Du kannst dieses"
	line "Item nicht"
	cont "eintragen."
	prompt

SECTION "_AskItemMoveText", ROMX
_AskItemMoveText::
	text "Wo soll das"
	line "hin?"
	done

SECTION "Text_AreYouABoyOrAreYouAGirl", ROMX
Text_AreYouABoyOrAreYouAGirl::
	text "Welches Foto zeigt"
	line "dein Trainerpass?"
	done

SECTION "Text_SoThisIsYou", ROMX
Text_SoThisIsYou::
	text "Das bist also du?"
	done

SECTION "Text_BattleUser", ROMX
Text_BattleUser::
	text "<USER>@"
	text_end

SECTION "_BattleTookSunlightText", ROMX
_BattleTookSunlightText::
	line "badet im Licht!"
	prompt

SECTION "_BattleFlewText", ROMX
_BattleFlewText::
	line "fliegt empor!"
	prompt

SECTION "_BattleDugText", ROMX
_BattleDugText::
	line "gräbt ein Loch!"
	prompt

SECTION "Text_BreedHuh", ROMX
Text_BreedHuh::
	text "Huch?"
	para "@"
	text_end

SECTION "_BreedEggHatchText", ROMX
_BreedEggHatchText::
	text_ram wStringBuffer1
	text ""
	line "schlüpft aus dem"
	cont "Ei!"
	text_sound SFX_CAUGHT_MON
	text_promptbutton
	text_end

SECTION "_BreedAskNicknameText", ROMX
_BreedAskNicknameText::
	text "Möchtest du"
	line ""
	text_ram wStringBuffer1
	text " einen"
	cont "Spitznamen geben?"
	done

SECTION "_LeftWithDayCareLadyText", ROMX
_LeftWithDayCareLadyText::
	text_ram wBreedMon2Nickname
	text " hast du"
	line "der Pensionslei-"
	cont "terin anvertraut."
	done

SECTION "_LeftWithDayCareManText", ROMX
_LeftWithDayCareManText::
	text_ram wBreedMon1Nickname
	text " hast du"
	line "dem Pensionsleiter"
	cont "anvertraut."
	done

SECTION "_BreedNoInterestText", ROMX
_BreedNoInterestText::
	text_ram wStringBuffer1
	text ""
	line "ist nicht"
	cont "interessiert."
	prompt

SECTION "_BreedAppearsToCareForText", ROMX
_BreedAppearsToCareForText::
	text "Es kümmert sich um"
	line ""
	text_ram wStringBuffer1
	text "."
	prompt

SECTION "_BreedFriendlyText", ROMX
_BreedFriendlyText::
	text "Es ist freundlich"
	line "gegenüber"
	para ""
	text_ram wStringBuffer1
	text "."
	prompt

SECTION "_BreedShowsInterestText", ROMX
_BreedShowsInterestText::
	text "Es zeigt Interesse"
	line "an "
	text_ram wStringBuffer1
	text "."
	prompt

SECTION "_EmptyMailboxText", ROMX
_EmptyMailboxText::
	text "Hier sind keine"
	line "Briefe."
	prompt

SECTION "ClearedMailPutAwayText", ROMX
ClearedMailPutAwayText::
	text "Der leere Brief"
	line "wurde eingesteckt."
	prompt

SECTION "MailPackFullText", ROMX
MailPackFullText::
	text "Dein Beutel"
	line "ist voll."
	prompt

SECTION "MailMessageLostText", ROMX
MailMessageLostText::
	text "Soll der Inhalt"
	line "des Briefes"
	cont "gelöscht werden?"
	done

SECTION "MailAlreadyHoldingItemText", ROMX
MailAlreadyHoldingItemText::
	text "Es hat schon"
	line "ein Item."
	prompt

SECTION "MailEggText", ROMX
MailEggText::
	text "Du kannst einem Ei"
	line "keinen Brief"
	cont "geben."
	prompt

SECTION "MailMovedFromBoxText", ROMX
MailMovedFromBoxText::
	text "Der Brief wurde"
	line "aus dem Brief-"
	cont "kasten gelöscht."
	prompt

SECTION "_ReceivedGiftMonText", ROMX
_ReceivedGiftMonText::
	text "<PLAYER> erhält"
	line ""
	text_ram wMonOrItemNameBuffer
	text "!"
	done

SECTION "_EggSentToPCText", ROMX
_EggSentToPCText::
	text "Das Ei wurde"
	line "auf "
	text_ram wStringBuffer1
	cont "übertragen."
	prompt

SECTION "_PCGottaHavePokemonText", ROMX
_PCGottaHavePokemonText::
	text "Du benötigst"
	line "#mon!"
	prompt

SECTION "_ContestCaughtMonText", ROMX
_ContestCaughtMonText::
	text_ram wStringBuffer1
	text " wurde"
	line "gefangen!"
	prompt

SECTION "_ContestAskSwitchText", ROMX
_ContestAskSwitchText::
	text "#mon tauschen?"
	done

SECTION "_ContestAlreadyCaughtText", ROMX
_ContestAlreadyCaughtText::
	text "Du hast bereits"
	line "ein "
	text_ram wStringBuffer1
	text ""
	cont "gefangen."
	prompt

SECTION "ContestJudging_FirstPlaceText", ROMX
ContestJudging_FirstPlaceText::
	text "Der Gewinner des"
	line "Käferturniers ist"
	text_pause
	text "…"

	para ""
	text_ram wBugContestWinnerName
	text ","
	line "mit einem"

	para ""
	text_ram wStringBuffer1
	text "!@"
	text_end

SECTION "ContestJudging_FirstPlaceScoreText", ROMX
ContestJudging_FirstPlaceScoreText::
	text ""
	para "Mit einer Punkt-"
	line "zahl von "
	text_decimal wBugContestFirstPlaceScore, 2, 3
	text ""
	cont "Punkten!"
	prompt

SECTION "ContestJudging_SecondPlaceText", ROMX
ContestJudging_SecondPlaceText::
	text "Zweiter wurde"
	line ""
	text_ram wBugContestWinnerName
	text ","
	para "mit einem"
	line ""
	line ""
	text_ram wStringBuffer1
	text "!@"
	text_end

SECTION "ContestJudging_SecondPlaceScoreText", ROMX
ContestJudging_SecondPlaceScoreText::
	text ""
	para "Die Punktzahl ist"
	line ""
	text_decimal wBugContestSecondPlaceScore, 2, 3
	text "!"
	prompt

SECTION "ContestJudging_ThirdPlaceText", ROMX
ContestJudging_ThirdPlaceText::
	text "Dritter wurde"
	line ""
	text_ram wBugContestWinnerName
	text ","
	para "mit einem"
	line ""
	text_ram wStringBuffer1
	text "!@"
	text_end

SECTION "ContestJudging_ThirdPlaceScoreText", ROMX
ContestJudging_ThirdPlaceScoreText::
	text ""
	para "Mit einer Punkt-"
	line "zahl von "
	text_decimal wBugContestThirdPlaceScore, 2, 3
	text "!"
	prompt

SECTION "_MagikarpGuruMeasureText", ROMX
_MagikarpGuruMeasureText::
	text "Lass mich dein"
	line "Karpador messen."

	para "…Hm, es ist"
	line ""
	text_ram wStringBuffer1
	text "cm"
	cont "groß."
	prompt

SECTION "_KarpGuruRecordText", ROMX
_KarpGuruRecordText::
	text "Aktueller Rekord"
	para ""
	text_ram wStringBuffer1
	text "cm gefangen"
	line "von "
	text_ram wMagikarpRecordHoldersName
	text_promptbutton
	text_end

SECTION "_LuckyNumberMatchPartyText", ROMX
_LuckyNumberMatchPartyText::
	text "Glückwunsch!"

	para "Die ID-Nummer"
	line "von "
	text_ram wStringBuffer2
	text ""

	para "in deinem Team"
	line "ist stimmig."
	prompt

SECTION "_LuckyNumberMatchPCText", ROMX
_LuckyNumberMatchPCText::
	text "Glückwunsch!"

	para "Die ID-Nummer"
	line "von "
	text_ram wStringBuffer2

	para "in deiner PC-Box"
	line "“"
	text_ram wStringBuffer1
	text "”"
	cont "ist stimmig."
	prompt

SECTION "_CaughtAskNicknameText", ROMX
_CaughtAskNicknameText::
	text "Möchtest du"
	line ""
	text_ram wStringBuffer1
	text " einen"
	cont "Spitznamen geben?"
	done

SECTION "_PokecenterPCCantUseText", ROMX
_PokecenterPCCantUseText::
	text "Dies kann nur"
	line "ein #mon"
	cont "benutzen!"
	prompt

SECTION "_PlayersPCTurnOnText", ROMX
_PlayersPCTurnOnText::
	text "<PLAYER> schaltet"
	line "den PC ein."
	prompt

SECTION "_PlayersPCAskWhatDoText", ROMX
_PlayersPCAskWhatDoText::
	text "Was möchtest du"
	line "tun?"
	done

SECTION "_PlayersPCHowManyWithdrawText", ROMX
_PlayersPCHowManyWithdrawText::
	text "Wie viele möchtest"
	line "du mitnehmen?"
	done

SECTION "_PlayersPCWithdrewItemsText", ROMX
_PlayersPCWithdrewItemsText::
	text_decimal wItemQuantityChangeBuffer, 1, 2
	text_plural
	text " "
	text_ram wStringBuffer2
	line "wurde mitgenommen."
	prompt

SECTION "_PlayersPCNoRoomWithdrawText", ROMX
_PlayersPCNoRoomWithdrawText::
	text "Du kannst keine"
	line "weiteren Items"
	cont "mehr tragen."
	prompt

SECTION "_PlayersPCNoItemsText", ROMX
_PlayersPCNoItemsText::
	text "Du trägst keine"
	line "Items!"
	prompt

SECTION "_PlayersPCCantDepositItemText", ROMX
_PlayersPCCantDepositItemText::
	text "Du kannst dieses"
	line "Item nicht"
	cont "ablegen."
	prompt

SECTION "_PlayersPCHowManyDepositText", ROMX
_PlayersPCHowManyDepositText::
	text "Wie viele möchtest"
	line "du ablegen?"
	done

SECTION "_PlayersPCDepositItemsText", ROMX
_PlayersPCDepositItemsText::
	text_decimal wItemQuantityChangeBuffer, 1, 2
	text_plural
	text " "
	text_ram wStringBuffer2
	line "wurde abgelegt."
	prompt

SECTION "_PlayersPCNoRoomDepositText", ROMX
_PlayersPCNoRoomDepositText::
	text "Es ist kein Platz"
	line "für weitere Items."
	prompt

SECTION "_PokecenterPCTurnOnText", ROMX
_PokecenterPCTurnOnText::
	text "<PLAYER> schaltet"
	line "den PC ein."
	prompt

SECTION "_PokecenterPCWhoseText", ROMX
_PokecenterPCWhoseText::
	text "Zugriff auf"
	line "wessen PC?"
	done

SECTION "_PokecenterBillsPCText", ROMX
_PokecenterBillsPCText::
	text "Die Verbindung zu"
	line "Bills PC wurde"
	cont "hergestellt."

	para "Du hast Zugriff"
	line "auf das #mon-"
	cont "Lagerungs-System."
	prompt

SECTION "_PokecenterPlayersPCText", ROMX
_PokecenterPlayersPCText::
	text "Die Verbindung zu"
	line "deinem PC wurde"
	cont "hergestellt."

	para "Du hast Zugriff"
	line "auf das Item-"
	cont "Lagerungs-System."
	prompt

SECTION "_PokecenterOaksPCText", ROMX
_PokecenterOaksPCText::
	text "Die Verbindung zu"
	line "Prof. Eichs PC"
	cont "wurde hergestellt."

	para "Du hast Zugriff"
	line "auf die #dex-"
	cont "Bewertung."
	prompt

SECTION "_PokecenterPCOaksClosedText", ROMX
_PokecenterPCOaksClosedText::
	text "…"
	line "Verbindung"
	cont "beendet…"
	done

SECTION "_OakPCText1", ROMX
_OakPCText1::
	text "Soll dein #dex"
	line "bewertet werden?"
	done

SECTION "_OakPCText2", ROMX
_OakPCText2::
	text "In deinem #dex"
	line "steht:"
	prompt

SECTION "_OakPCText3", ROMX
_OakPCText3::
	text "Ges.: "
	text_decimal wTempDexSeen, 2, 3
	text " #mon"
	line "Bes.: "
	text_decimal wTempDexOwn, 2, 3
	text " #mon"

	para "Prof. Eichs"
	line "Bewertung:"
	done

SECTION "_OakRating01", ROMX
_OakRating01::
	text "Suche in"
	line "hohem Gras nach"
	cont "#mon!"
	done

SECTION "_OakRating02", ROMX
_OakRating02::
	text "Gut. Ich sehe, du"
	line "kannst mit #-"
	cont "bällen umgehen."
	done

SECTION "_OakRating03", ROMX
_OakRating03::
	text "Du wirst immer"
	line "besser, hast aber"

	para "noch einen langen"
	line "Weg vor dir."
	done

SECTION "_OakRating04", ROMX
_OakRating04::
	text "Vervollständige"
	line "den #dex. Fange"

	para "alle Typen von"
	line "#mon!"
	done

SECTION "_OakRating05", ROMX
_OakRating05::
	text "Du gibst dir Mühe."
	line "Dein #dex"

	para "wird immer"
	line "besser."
	done

SECTION "_OakRating06", ROMX
_OakRating06::
	text "Manche #mon"
	line "entwickeln sich"

	para "durch Level,"
	line "andere benötigen"
	cont "Steine."
	done

SECTION "_OakRating07", ROMX
_OakRating07::
	text "Hast du eine"
	line "Angel? Du"

	para "kannst damit"
	line "#mon fangen."
	done

SECTION "_OakRating08", ROMX
_OakRating08::
	text "Sehr gut! Sammeln"
	line "scheint dir Spaß"
	cont "zu machen!"
	done

SECTION "_OakRating09", ROMX
_OakRating09::
	text "Du kannst manchen"
	line "#mon nur zu"

	para "gewissen Tages-"
	line "zeiten begegnen."
	done

SECTION "_OakRating10", ROMX
_OakRating10::
	text "Es wird immer"
	line "besser. Mach"
	cont "weiter so!"
	done

SECTION "_OakRating11", ROMX
_OakRating11::
	text "Beeindruckend."
	line "Du fängst nicht"

	para "nur #mon, du"
	line "trainierst sie"
	cont "auch."
	done

SECTION "_OakRating12", ROMX
_OakRating12::
	text "Hast du Kurt schon"
	line "getroffen? Seine"
	cont "handgefertigten"
	cont "#bälle werden"
	cont "dir helfen."
	done

SECTION "_OakRating13", ROMX
_OakRating13::
	text "Wow. Du hast mehr"
	line "#mon entdeckt,"

	para "als die letzte"
	line "#dex-For-"
	cont "schungsgruppe."
	done

SECTION "_OakRating14", ROMX
_OakRating14::
	text "Tauschst du deine"
	line "#mon?"

	para "Alleine ist das"
	line "sehr schwierig!"
	done

SECTION "_OakRating15", ROMX
_OakRating15::
	text "Wow! Die 200-Marke"
	line "ist erreicht! Dein"
	cont "#dex sieht"
	cont "großartig aus!"
	done

SECTION "_OakRating16", ROMX
_OakRating16::
	text "Du hast so viele"
	line "#mon gefunden!"

	para "Du hast mir damit"
	line "sehr geholfen!"
	done

SECTION "_OakRating17", ROMX
_OakRating17::
	text "Fantastisch! Du"
	line "könntest auch ein"

	para "#mon-Professor"
	line "werden!"
	done

SECTION "_OakRating18", ROMX
_OakRating18::
	text "Dein #dex ist"
	line "Wahnsinn! Du"

	para "wirst noch zu"
	line "einem Profi!"
	done

SECTION "_OakRating19", ROMX
_OakRating19::
	text "Boah! Der perfekte"
	line "#dex! Davon"

	para "habe ich immer"
	line "geträumt!"
	cont "Gratulation!"
	done

SECTION "_OakPCText4", ROMX
_OakPCText4::
	text "Die Verbindung zu"
	line "Prof. Eichs PC"
	cont "wurde getrennt."
	done

SECTION "_StartMenuContestEndText", ROMX
_StartMenuContestEndText::
	text "Möchtest du den"
	line "Wettkampf beenden?"
	done

SECTION "_ItemsTossOutHowManyText", ROMX
_ItemsTossOutHowManyText::
	text "Wie viele"
	line ""
	text_ram wStringBuffer2
	cont "wegwerfen?"
	done

SECTION "_ItemsDiscardedText", ROMX
_ItemsDiscardedText::
	text_decimal wItemQuantityChangeBuffer, 1, 2
	text_plural
	text " "
	text_ram wStringBuffer1
	line "wurde weggeworfen."
	prompt

SECTION "_ItemsOakWarningText", ROMX
_ItemsOakWarningText::
	text "Eich: <PLAYER>!"
	line "Es ist noch nicht"
	cont "an der Zeit, dies"
	cont "zu benutzen."
	done

SECTION "_PokemonSwapItemText", ROMX
_PokemonSwapItemText::
	text "Nimmt "
	text_ram wStringBuffer1
	text ""
	line "von "
	text_ram wMonOrItemNameBuffer
	text ""

	para "und gibt ihm"
	line ""
	text_ram wStringBuffer2
	text "."
	prompt

SECTION "_PokemonHoldItemText", ROMX
_PokemonHoldItemText::
	text "Gibt "
	text_ram wMonOrItemNameBuffer
	text ""
	line ""
	text_ram wStringBuffer2
	text "."
	prompt

SECTION "_PokemonRemoveMailText", ROMX
_PokemonRemoveMailText::
	text "Entferne zuerst"
	line "den Brief."
	prompt

SECTION "_PokemonNotHoldingText", ROMX
_PokemonNotHoldingText::
	text_ram wMonOrItemNameBuffer
	text ""
	line "trägt kein Item."
	prompt

SECTION "_ItemStorageFullText", ROMX
_ItemStorageFullText::
	text "Du kannst keine"
	line "weiteren Items"
	cont "mehr lagern."
	prompt

SECTION "_PokemonTookItemText", ROMX
_PokemonTookItemText::
	text "Nimmt "
	text_ram wStringBuffer1
	text ""
	line "von "
	text_ram wMonOrItemNameBuffer
	text "."
	prompt

SECTION "_PokemonAskSwapItemText", ROMX
_PokemonAskSwapItemText::
	text_ram wMonOrItemNameBuffer
	text " hält"
	line "schon das Item"

	para ""
	text_ram wStringBuffer1
	text "."
	line "Items wechseln?"
	done

SECTION "_ItemCantHeldText", ROMX
_ItemCantHeldText::
	text "Du kannst dieses"
	line "Item keinem"
	cont "#mon geben."
	prompt

SECTION "_MailLoseMessageText", ROMX
_MailLoseMessageText::
	text "Der Inhalt des"
	line "Briefes wird"
	cont "gelöscht"
	cont "Einverstanden?"
	done

SECTION "_MailDetachedText", ROMX
_MailDetachedText::
	text "Brief entfernt von"
	line ""
	text_ram wStringBuffer1
	text "."
	prompt

SECTION "_MailNoSpaceText", ROMX
_MailNoSpaceText::
	text "Es ist nicht"
	line "genügend Platz"
	cont "für entfernte"
	cont "Briefe."
	prompt

SECTION "_MailAskSendToPCText", ROMX
_MailAskSendToPCText::
	text "Den entfernten"
	line "Brief auf deinen"
	cont "PC übertragen?"
	done

SECTION "_MailboxFullText", ROMX
_MailboxFullText::
	text "Du kannst keine"
	line "weiteren Briefe"
	cont "auf deinen PC"
	cont "übertragen."
	prompt

SECTION "_MailSentToPCText", ROMX
_MailSentToPCText::
	text "Der Brief wurde"
	line "auf deinen PC"
	cont "übertragen."
	prompt

SECTION "_PokemonNotEnoughHPText", ROMX
_PokemonNotEnoughHPText::
	text "Nicht genügend KP!"
	prompt

SECTION "_MayRegisterItemText", ROMX
_MayRegisterItemText::
	text "Ein Item aus"
	line "deinem Beutel"

	para "kann auf"
	line "Select"
	cont "gelegt werden."
	done

SECTION "_InitialOptionsText", ROMX
_InitialOptionsText::
	text "Bitte wähle, wie"
	line "du Polished"
	cont "Crystal spielen"
	cont "möchtest."
	prompt

SECTION "_ElmText1", ROMX
_ElmText1::
	text "Hi! Entschuldige"
	line "die Verspätung!"

if !DEF(DEBUG)
	para "Willkommen in der"
	line "Welt der #mon!"

	para "Mein Name ist"
	line "Lind!"

	para "Man nennt mich"

	para "den #mon-"
	line "Professor."
endc
	prompt

SECTION "_ElmText2", ROMX
_ElmText2::
	text "Diese Welt wird"
	line "von Wesen"
	cont "bewohnt, die man"
	cont "#mon nennt.@"
	text_end

SECTION "_ElmText4", ROMX
_ElmText4::
	text "Menschen und"
	line "#mon leben"

	para "zusammen und"
	line "helfen einander."

	para "Für manche Leute"
	line "sind #mon"
	cont "Haustiere, andere"
	cont "tragen Kämpfe mit"
	cont "ihnen aus."
	prompt

SECTION "_ElmText5", ROMX
_ElmText5::
	text "Leider wissen wir"
	line "noch nicht alles"
	cont "über #mon."

	para "Es gibt noch"
	line "viele Geheimnisse"
	cont "zu lüften."

	para "Darum studiere"
	line "ich #mon"
	cont "tagaus, tagein!"
	prompt

SECTION "_ElmText6", ROMX
_ElmText6::
	text "Bitte nenne mir"
	line "deinen Namen."
	prompt

SECTION "_ElmText7", ROMX
_ElmText7::
	text "<PLAYER>, bist du"
	line "bereit?"

if !DEF(DEBUG)
	para "Dein eigenes"
	line "#mon-Abenteuer"
	cont "erwartet dich."

	para "Dich erwarten tol-"
	line "le Dinge, aber"
	cont "auch harte Zeiten."

	para "Eine Welt voller"
	line "Träume und aufre-"
	cont "gender #mon-"

	para "Abenteuer erwar-"
	line "tet dich! Mach"
	cont "dich bereit!"
endc

	para "Ich treffe dich"
	line "später!"
	done

SECTION "_WarnVBAText", ROMX
_WarnVBAText::
if !DEF(DEBUG)
	text "Warnung!"

	para "Dieser Game-Boy-"
	line "Emulator hat"
	cont "Fehler,"

	para "die Polished"
	line "Crystal abstürzen"
	cont "lassen könnten."

	para "Bitte nutze einen"
	line "genaueren"
	cont "Emulator,"

	para "zum Beispiel BGB,"
	line "mGBA oder"
	cont "Gambatte."
	prompt
else
	text "Emulator test"
	line "failed."
	prompt
endc

SECTION "_ClockTimeMayBeWrongText", ROMX
_ClockTimeMayBeWrongText::
	text "Die Uhr könnte"
	line "falsch gestellt"
	cont "sein."

	para "Gib bitte die"
	line "genaue Uhrzeit an."
	prompt

SECTION "_ClockSetWithControlPadText", ROMX
_ClockSetWithControlPadText::
	text "Benutze dafür das"
	line "Steuerkreuz."

	para "Bestätigen:"
	line "A-Knopf"
	cont "Zurück: B-Knopf"
	done

SECTION "_ClockIsThisOKText", ROMX
_ClockIsThisOKText::
	text "Einverstanden?"
	done

SECTION "_ClockHasResetText", ROMX
_ClockHasResetText::
	text "Die Uhr wurde"
	line "korrigiert."
	done

SECTION "_LinkTimeoutText", ROMX
_LinkTimeoutText::
	text "Es verging zu viel"
	line "Zeit. Probier's"
	cont "noch einmal."
	prompt

SECTION "_LinkTradeCantBattleText", ROMX
_LinkTradeCantBattleText::
	text "Wenn du dieses"
	line "#mon tauschst,"
	cont "kannst du nicht"
	cont "mehr kämpfen."
	prompt

SECTION "_LinkAbnormalMonText", ROMX
_LinkAbnormalMonText::
	text "Das "
	text_ram wStringBuffer1
	text ""
	cont "deines Freundes"
	cont "scheint nicht in"
	cont "Ordnung zu sein!"
	prompt

SECTION "_LinkAskTradeForText", ROMX
_LinkAskTradeForText::
	text "Tausche "
	text_ram wBufferTrademonNickname
	text ""
	line "mit "
	text_ram wStringBuffer1
	text "?"
	done

SECTION "_WouldYouLikeToSaveTheGameText", ROMX
_WouldYouLikeToSaveTheGameText::
	text "Möchtest du das"
	line "Spiel sichern?"
	done

SECTION "_SavedTheGameText", ROMX
_SavedTheGameText::
	text "<PLAYER> hat das"
	line "Spiel gesichert."
	done

SECTION "_AnotherSaveFileText", ROMX
_AnotherSaveFileText::
	text "Warnung! Es gibt"
	line "einen Spielstand"
	cont "von einem anderen"
	cont "Spiel."

	para "Den anderen"
	line "Spielstand"
	cont "überschreiben?"
	done

SECTION "_SaveFileCorruptedText", ROMX
_SaveFileCorruptedText::
	text "Der Spielstand"
	line "ist zerstört!"
	prompt

SECTION "_GainedItemText", ROMX
_GainedItemText::
	text "<PLAYER> erhält"
	line ""
	text_ram wStringBuffer4
	text "."
	done

SECTION "_GainedMultipleItemsText", ROMX
_GainedMultipleItemsText::
	text "<PLAYER> erhält"
	line ""
	text_decimal wItemQuantityChangeBuffer, 1, 2
	text "x "
	text_ram wStringBuffer4
	text "."
	done

SECTION "_PutItemInPocketText", ROMX
_PutItemInPocketText::
	text "<PLAYER> steckt"
	line ""
	text_ram wStringBuffer1
	text " in"
	cont ""
	text_ram wStringBuffer3
	text "."
	prompt

SECTION "_PocketIsFullText", ROMX
_PocketIsFullText::
	text_ram wStringBuffer3
	text ""
	line "ist voll…"
	prompt

SECTION "_FoundWingsText", ROMX
_FoundWingsText::
	text "<PLAYER> erhält"
	line ""
	text_decimal wCurWingQuantity, 1, 2
	text "x "
	text_ram wStringBuffer4
	text "."
	done

SECTION "_CongratulationsYourPokemonText", ROMX
_CongratulationsYourPokemonText::
	text "Glückwunsch!"
	line "Dein "
	text_ram wStringBuffer2
	text_end

SECTION "_EvolvedIntoText", ROMX
_EvolvedIntoText::
	text ""
	para "wurde zu"
	line ""
	text_ram wStringBuffer1
	text "!"
	done

SECTION "_StoppedEvolvingText", ROMX
_StoppedEvolvingText::
	text "Hmm? Die Entwick-"
	line "lung wurde abge-"
	cont "brochen!"
	prompt

SECTION "_EvolvingText", ROMX
_EvolvingText::
	text "Hey! "
	text_ram wStringBuffer2
	text ""
	line "entwickelt sich!"
	done

SECTION "_MartHowManyText", ROMX
_MartHowManyText::
	text "Wie viele?"
	done

SECTION "_MartFinalPriceText", ROMX
_MartFinalPriceText::
	text_decimal wItemQuantityChangeBuffer, 1, 2
	text_plural
	text " "
	text_ram wStringBuffer2
	text "?"

	para "Das macht dann"
	line "¥"
	text_decimal hMoneyTemp, 3, 7
	text "."
	done

SECTION "_HerbShopLadyIntroText", ROMX
_HerbShopLadyIntroText::
	text "Hallo,"

	para "ich verkaufe"
	line "preiswerte"
	cont "Kräutermedizin."

	para "Sie wirkt, ist"
	line "aber bitter."

	para "Deine #mon"
	line "werden sie nicht"
	cont "mögen."

	para "Hihihihi…"
	done

SECTION "_HerbalLadyFinalPriceText", ROMX
_HerbalLadyFinalPriceText::
	text_decimal wItemQuantityChangeBuffer, 1, 2
	text_plural
	text " "
	text_ram wStringBuffer2
	line "kostet ¥"
	text_decimal hMoneyTemp, 3, 7
	text "."
	done

SECTION "_HerbalLadyThanksText", ROMX
_HerbalLadyThanksText::
	text "Danke, Kleiner."
	line "Hihihihi…"
	done

SECTION "_HerbalLadyPackFullText", ROMX
_HerbalLadyPackFullText::
	text "Oh? In deinem"
	line "Beutel ist kein"
	cont "Platz mehr."
	done

SECTION "_HerbalLadyNoMoneyText", ROMX
_HerbalLadyNoMoneyText::
	text "Hihihi… Du hast"
	line "nicht genug Geld."
	done

SECTION "_HerbalLadyComeAgainText", ROMX
_HerbalLadyComeAgainText::
	text "Besuche mich"
	line "wieder. Hihihihi…"
	done

SECTION "_BargainShopIntroText", ROMX
_BargainShopIntroText::
	text "Heh! Bist du an"
	line "Schnäppchen"
	cont "interessiert?"

	para "Ich verkaufe"
	line "seltene Items,"

	para "aber leider sind"
	line "es nur Einzel-"
	cont "stücke."
	done

SECTION "_BargainShopFinalPriceText", ROMX
_BargainShopFinalPriceText::
	text_ram wStringBuffer2
	text ""
	line "kostet ¥"
	text_decimal hMoneyTemp, 3, 7
	text "."
	para "Kaufen?"
	done

SECTION "_BargainShopThanksText", ROMX
_BargainShopThanksText::
	text "Danke."
	done

SECTION "_BargainShopPackFullText", ROMX
_BargainShopPackFullText::
	text "Uhh, dein Beutel"
	line "platzt aus"
	cont "allen Nähten."
	done

SECTION "_BargainShopSoldOutText", ROMX
_BargainShopSoldOutText::
	text "Das hast du schon"
	line "gekauft. Ich"
	cont "habe keines mehr."
	done

SECTION "_BargainShopNoFundsText", ROMX
_BargainShopNoFundsText::
	text "Uhh, du bist knapp"
	line "bei Kasse."
	done

SECTION "_BargainShopComeAgainText", ROMX
_BargainShopComeAgainText::
	text "Schau mal"
	line "wieder vorbei."
	done

SECTION "_PharmacyIntroText", ROMX
_PharmacyIntroText::
	text "Was ist? Brauchst"
	line "du Medizin?"
	done

SECTION "_HowManyText", ROMX
_HowManyText::
	text "Wie viele?"
	done

SECTION "_PharmacyFinalPriceText", ROMX
_PharmacyFinalPriceText::
	text_decimal wItemQuantityChangeBuffer, 1, 2
	text_plural
	text " "
	text_ram wStringBuffer2
	line "kostet ¥"
	text_decimal hMoneyTemp, 3, 7
	text "."
	done

SECTION "_PharmacyThanksText", ROMX
_PharmacyThanksText::
	text "Vielen Dank!"
	done

SECTION "_PharmacyPackFullText", ROMX
_PharmacyPackFullText::
	text "Du hast keinen"
	line "Platz mehr."
	done

SECTION "_PharmacyNoMoneyText", ROMX
_PharmacyNoMoneyText::
	text "Wie? Das ist nicht"
	line "genügend Geld."
	done

SECTION "_PharmacyComeAgainText", ROMX
_PharmacyComeAgainText::
	text "In Ordnung."
	line "Bis die Tage."
	done

SECTION "_MartSellHowManyText", ROMX
_MartSellHowManyText::
	text "Wie viele?"
	done

SECTION "_MartSellPriceText", ROMX
_MartSellPriceText::
	text "Ich zahle dir"
	line "¥"
	text_decimal hMoneyTemp, 3, 7
	text "."

	para "Reicht das?"
	done

SECTION "_MartWelcomeText", ROMX
_MartWelcomeText::
	text "Willkommen! Womit"
	line "kann ich dienen?"
	done

SECTION "_MartThanksText", ROMX
_MartThanksText::
	text "Hier, bitte."
	line "Danke schön!"
	done

SECTION "_MartNoMoneyText", ROMX
_MartNoMoneyText::
	text "Du hast nicht"
	line "genügend Geld."
	done

SECTION "_MartPackFullText", ROMX
_MartPackFullText::
	text "Du kannst keine"
	line "weiteren Items"
	cont "mehr tragen."
	done

SECTION "_MartCantBuyText", ROMX
_MartCantBuyText::
	text "Ich kann dir das"
	line "nicht abkaufen."
	prompt

SECTION "_MartComeAgainText", ROMX
_MartComeAgainText::
	text "Komm wieder!"
	done

SECTION "_MartAskMoreText", ROMX
_MartAskMoreText::
	text "Kann ich noch"
	line "etwas für dich"
	cont "tun?"
	done

SECTION "_MartBoughtText", ROMX
_MartBoughtText::
	text "Erhält ¥"
	text_decimal hMoneyTemp, 3, 7
	text " für"
	line ""
	text_decimal wItemQuantityChangeBuffer, 1, 2
	text_plural
	text " "
	text_ram wStringBuffer2
	text "."
	done

SECTION "_SlotsBetHowManyCoinsText", ROMX
_SlotsBetHowManyCoinsText::
	text "Wie viel setzen?"
	done

SECTION "TMMartCostsThisMuchText", ROMX
TMMartCostsThisMuchText::
	text_ram wStringBuffer2
	text " "
	text_ram wStringBuffer1
	line "kostet ¥"
	text_decimal hMoneyTemp, 3, 7
	text "."
	done

SECTION "BTMartHowMayIHelpYouText", ROMX
BTMartHowMayIHelpYouText::
	text "Willkommen in der"
	line "Tauschecke!"

	para "Hier kannst du"
	line "deine GP gegen"
	cont "Preise tauschen."
	done

SECTION "BTMartCostsThisMuchText", ROMX
BTMartCostsThisMuchText::
	text_decimal wItemQuantityChangeBuffer, 1, 2
	text_plural
	text " "
	text_ram wStringBuffer1
	line "kostet "
	text_decimal hMoneyTemp+1, 2, 4
	text " GP."
	done

SECTION "BTMartInsufficientFundsText", ROMX
BTMartInsufficientFundsText::
	text "Es tut mir Leid,"
	line "aber du hast nicht"
	cont "genug GP."
	done

SECTION "BTMartBagFullText", ROMX
BTMartBagFullText::
	text "Es tut mir Leid,"
	line "aber dein Beutel"
	cont "ist voll."
	done

SECTION "BTMartComeAgainText", ROMX
BTMartComeAgainText::
	text "Bitte komm"
	line "jederzeit wieder!"
	done

SECTION "_SlotsStartText", ROMX
_SlotsStartText::
	text "Start!"
	done

SECTION "_SlotsNotEnoughCoinsText", ROMX
_SlotsNotEnoughCoinsText::
	text "Nicht genügend"
	line "Münzen."
	prompt

SECTION "_SlotsRanOutOfCoinsText", ROMX
_SlotsRanOutOfCoinsText::
	text "Mist… Ich habe"
	line "keine Münzen mehr…"
	done

SECTION "_SlotsPlayAgainText", ROMX
_SlotsPlayAgainText::
	text "Noch einmal?"
	done

SECTION "_SlotsLinedUpText", ROMX
_SlotsLinedUpText::
	text "Bingo!"
	line ""
	text_ram wStringBuffer2
	text " Münzen"
	cont "gewonnen!"
	done

SECTION "_SlotsDarnText", ROMX
_SlotsDarnText::
	text "Mist!"
	done

SECTION "_PhoneWrongNumberText", ROMX
_PhoneWrongNumberText::
	text "Äh? Ich habe mich"
	line "verwählt!"
	done

SECTION "_PhoneClickText", ROMX
_PhoneClickText::
	text "Klick!"
	done

SECTION "_PhoneEllipseText", ROMX
_PhoneEllipseText::
	text "……"
	done

SECTION "_PhoneOutOfAreaText", ROMX
_PhoneOutOfAreaText::
	text "Die Nummer ist"
	line "außerhalb des"
	cont "Funknetzes."
	done

SECTION "_PhoneJustTalkToThemText", ROMX
_PhoneJustTalkToThemText::
	text "Du musst diesen"
	line "Gesprächspartner"
	cont "zu Fuß aufsuchen!"
	done

SECTION "_PasswordAskResetText", ROMX
_PasswordAskResetText::
	text "Wähle Weiter, um"
	line "die Uhrzeit"
	cont "einzustellen."
	prompt

SECTION "_PasswordAskResetClockText", ROMX
_PasswordAskResetClockText::
	text "Uhr neu stellen?"
	done

SECTION "_ClearAllSaveDataText", ROMX
_ClearAllSaveDataText::
	text "Spielstand"
	line "löschen?"
	done

SECTION "ResetInitialOptionsText", ROMX
ResetInitialOptionsText::
	text "Die anfänglichen"
	line "Spieloptionen"
	cont "zurücksetzen?"
	done

SECTION "_LearnedMoveText", ROMX
_LearnedMoveText::
	text_ram wMonOrItemNameBuffer
	text " erlernt"
	line ""
	text_ram wStringBuffer2
	text "!"
	text_sound SFX_DEX_FANFARE_50_79
	text_promptbutton
	text_end

SECTION "_MoveAskForgetText", ROMX
_MoveAskForgetText::
	text "Welche Attacke"
	next "soll vergessen"
	cont "werden?"
	done

SECTION "_StopLearningMoveText", ROMX
_StopLearningMoveText::
	text_ram wStringBuffer2
	text ""
	line "nicht erlernen?"
	done

SECTION "_DidNotLearnMoveText", ROMX
_DidNotLearnMoveText::
	text_ram wMonOrItemNameBuffer
	text ""
	line "hat "
	text_ram wStringBuffer2
	text ""
	cont "nicht erlernt."
	prompt

SECTION "_AskForgetMoveText", ROMX
_AskForgetMoveText::
	text_ram wMonOrItemNameBuffer
	line "versucht,"
	cont ""
	text_ram wStringBuffer2
	text " zu"
	cont "erlernen!"

	para "Soll eine andere"
	line "Attacke zugunsten"
	cont "von "
	text_ram wStringBuffer2
	cont "vergessen werden?"
	done

SECTION "Text_MoveForgetCount", ROMX
Text_MoveForgetCount::
	text "1, 2 und…"
	text_pause
	text_end

SECTION "_MoveForgotText", ROMX
_MoveForgotText::
	text "Schwupp!"
	text_pause
	text ""

	para ""
	text_ram wMonOrItemNameBuffer
	text " hat"
	line ""
	text_ram wStringBuffer1
	text ""

	para "vergessen!"

	para "Und…"
	prompt

SECTION "_MoveCantForgetHMText", ROMX
_MoveCantForgetHMText::
	text "VM-Attacken"
	line "können nicht"
	cont "gelöscht werden!"
	prompt

SECTION "_CardFlipPlayWithThreeCoinsText", ROMX
_CardFlipPlayWithThreeCoinsText::
	text "Drei Münzen set-"
	line "zen?"
	done

SECTION "_CardFlipNotEnoughCoinsText", ROMX
_CardFlipNotEnoughCoinsText::
	text "Nicht genügend"
	cont "Münzen…"
	prompt

SECTION "_CardFlipChooseACardText", ROMX
_CardFlipChooseACardText::
	text "Zieh eine Karte."
	done

SECTION "_CardFlipPlaceYourBetText", ROMX
_CardFlipPlaceYourBetText::
	text "Worauf setzen?"
	done

SECTION "_CardFlipPlayAgainText", ROMX
_CardFlipPlayAgainText::
	text "Noch einmal?"
	done

SECTION "_CardFlipShuffledText", ROMX
_CardFlipShuffledText::
	text "Die Karten"
	line "wurden gemischt."
	prompt

SECTION "_CardFlipYeahText", ROMX
_CardFlipYeahText::
	text "Yoh!"
	done

SECTION "_CardFlipDarnText", ROMX
_CardFlipDarnText::
	text "Mist…"
	done

SECTION "_GearTodayText", ROMX
_GearTodayText::
	text_today
	text_end

SECTION "_GearEllipseText", ROMX
_GearEllipseText::
	text "……"
	done

SECTION "_GearOutOfServiceText", ROMX
_GearOutOfServiceText::
	text "Du bist außerhalb"
	line "des Service-"
	cont "gebiets."
	prompt

SECTION "_PokegearAskWhoCallText", ROMX
_PokegearAskWhoCallText::
	text "Wen möchtest du"
	line "anrufen?"
	done

SECTION "_PokegearPressButtonText", ROMX
_PokegearPressButtonText::
	text "Drücke B-Knopf,"
	line "um abzubrechen."
	done

SECTION "_PokegearAskDeleteText", ROMX
_PokegearAskDeleteText::
	text "Die gespeicherte"
	line "Nummer löschen?"
	done

SECTION "_BuenaAskWhichPrizeText", ROMX
_BuenaAskWhichPrizeText::
	text "Du kannst deine"
	line "gesammelten Punkte"

	para "gegen einen Preis"
	line "deiner Wahl"
	cont "eintauschen!"

	para "Welchen Preis"
	line "hättest du gerne?"
	done

SECTION "_BuenaIsThatRightText", ROMX
_BuenaIsThatRightText::
	text_ram wStringBuffer1
	text "?"
	line "Ist das richtig?"
	done

SECTION "_BuenaHereYouGoText", ROMX
_BuenaHereYouGoText::
	text "Und los!"
	para ""
	done

SECTION "_BuenaNotEnoughPointsText", ROMX
_BuenaNotEnoughPointsText::
	text "Du hast nicht ge-"
	line "nügend Punkte."
	para ""
	done

SECTION "_BuenaNoRoomText", ROMX
_BuenaNoRoomText::
	text "Du hast keinen"
	line "Platz dafür."
	para ""
	done

SECTION "_BuenaComeAgainText", ROMX
_BuenaComeAgainText::
	text "Oh. Komme bitte"
	line "wieder!"
	done

SECTION "_BallBrokeFreeText", ROMX
_BallBrokeFreeText::
	text "Mist! Das #mon"
	line "hat sich befreit!"
	prompt

SECTION "_BallAppearedCaughtText", ROMX
_BallAppearedCaughtText::
	text "Fast hätte es"
	line "geklappt!"
	prompt

SECTION "_BallAlmostHadItText", ROMX
_BallAlmostHadItText::
	text "Mist!"
	line "Das war knapp!"
	prompt

SECTION "_BallSoCloseText", ROMX
_BallSoCloseText::
	text "Verflixt! Es"
	line "hätte beinahe"
	cont "geklappt!"
	prompt

SECTION "Text_BallCaught", ROMX
Text_BallCaught::
	text "Toll! "
	text_ram wEnemyMonNickname
	text ""
	line "wurde gefangen!"
	text_sound SFX_CAUGHT_MON
	text_end

SECTION "Text_Waitbutton_2", ROMX
Text_Waitbutton_2::
	text_promptbutton
	text_end

SECTION "_CurBoxFullText", ROMX
_CurBoxFullText::
	text_ram wStringBuffer1
	text " ist voll."
	prompt

SECTION "_MonSentToPCText", ROMX
_MonSentToPCText::
	text_ram wMonOrItemNameBuffer
	line "wurde auf "
	text_ram wStringBuffer1
	cont "übertragen."
	prompt

SECTION "_NewDexDataText", ROMX
_NewDexDataText::
	text "Für "
	text_ram wEnemyMonNickname
	text ""
	line "wird ein neuer"
	cont "Eintrag im"
	cont "#dex angelegt."
	text_sound SFX_SLOT_MACHINE_START
	text_promptbutton
	text_end

SECTION "_AskGiveNicknameText", ROMX
_AskGiveNicknameText::
	text "Möchtest du"
	line ""
	text_ram wStringBuffer1
	text " einen"
	cont "Spitznamen geben?"
	done

SECTION "_ItemHappinessRoseButStatFellText", ROMX
_ItemHappinessRoseButStatFellText::
	text_ram wStringBuffer1
	line "ist zutraulicher"
	cont "geworden."

	para "Basis-"
	text_ram wStringBuffer2
	line "von "
	text_ram wStringBuffer1
	cont "sinkt!"
	prompt

SECTION "_ItemStatRoseText", ROMX
_ItemStatRoseText::
	text_ram wStringBuffer2
	text " von"
	line ""
	text_ram wStringBuffer1
	text ""
	para "nimmt zu."
	prompt

SECTION "_ItemCantUseOnMonText", ROMX
_ItemCantUseOnMonText::
	text "Dieses #mon"
	line "kann das nicht"
	cont "einsetzen."
	prompt

SECTION "Text_RepelUsedEarlierIsStillInEffect", ROMX
Text_RepelUsedEarlierIsStillInEffect::
	text "Schutz wirkt"
	line "noch immer."
	prompt

SECTION "_BlueCardBalanceText", ROMX
_BlueCardBalanceText::
	text "Du hast jetzt"
	line ""
	text_decimal wBlueCardBalance, 1, 2
	text " Punkte."
	done

SECTION "_CoinCaseCountText", ROMX
_CoinCaseCountText::
	text "Münzen:"
	line ""
	text_decimal wCoins, 2, 5
	text_end

SECTION "Text_RaiseThePPOfWhichMove", ROMX
Text_RaiseThePPOfWhichMove::
	text "Für welche"
	line "Attacke sollen"
	cont "die AP aufgefüllt"
	cont "werden?"
	done

SECTION "Text_RestoreThePPOfWhichMove", ROMX
Text_RestoreThePPOfWhichMove::
	text "Für welche"
	line "Attacke sollen"
	cont "die AP erneuert"
	cont "werden?"
	done

SECTION "Text_PPIsMaxedOut", ROMX
Text_PPIsMaxedOut::
	text_ram wStringBuffer2
	text "s AP"
	line "wurden komplett"
	cont "aufgefüllt."
	prompt

SECTION "Text_PPsIncreased", ROMX
Text_PPsIncreased::
	text_ram wStringBuffer2
	text "s AP"
	line "wurden aufgefüllt."
	prompt

SECTION "Text_PPsMaximized", ROMX
Text_PPsMaximized::
	text_ram wStringBuffer2
	text "s AP"
	line "wurden maximiert."
	prompt

SECTION "_PPRestoredText", ROMX
_PPRestoredText::
	text "AP aufgefüllt."
	prompt

SECTION "_ItemLooksBitterText", ROMX
_ItemLooksBitterText::
	text "Das ist bitter…"
	prompt

SECTION "_ItemCantUseOnEggText", ROMX
_ItemCantUseOnEggText::
	text "Ein Ei kann das"
	line "nicht benutzen."
	prompt

SECTION "_ItemOakWarningText", ROMX
_ItemOakWarningText::
	text "Eich: <PLAYER>!"
	line "Es ist nicht"
	cont "an der Zeit,"
	cont "dies zu benutzen!"
	prompt

SECTION "_ItemWontHaveEffectText", ROMX
_ItemWontHaveEffectText::
	text "Das hätte keinen"
	line "Effekt."
	prompt

SECTION "_BallBlockedText", ROMX
_BallBlockedText::
	text "Der Trainer hat"
	line "den Ball"
	cont "abgeblockt!"
	prompt

SECTION "_BallDontBeAThiefText", ROMX
_BallDontBeAThiefText::
	text "Sei kein Dieb!"
	prompt

SECTION "_BallStorageFullText", ROMX
_BallStorageFullText::
	text "Das Lagerungs-"
	line "System ist voll."
	cont "Das kannst du"
	cont "jetzt nicht"
	cont "benutzen."
	prompt

SECTION "_BallDatabaseFullText", ROMX
_BallDatabaseFullText::
	text "Die PC-Datenbank"
	line "ist überlastet."
	cont "Bitte sichere das"
	cont "Spiel."
	prompt

SECTION "Text_MonIsHiddenFromBall", ROMX
Text_MonIsHiddenFromBall::
	text "Das #mon ist"
	line "nicht zu sehen!"
	prompt

SECTION "Text_MonCantBeCaught", ROMX
Text_MonCantBeCaught::
	text "Das #mon lässt"
	line "sich nicht fangen!"
	prompt

SECTION "_ItemUsedText", ROMX
_ItemUsedText::
	text "<PLAYER> setzt"
	line ""
	text_ram wStringBuffer2
	text " ein."
	done

SECTION "_KnowsMoveText", ROMX
_KnowsMoveText::
	text_ram wStringBuffer1
	text " kennt"
	line ""
	text_ram wStringBuffer2
	text "."
	prompt

SECTION "_MoveKnowsOneText", ROMX
_MoveKnowsOneText::
	text "Dieses #mon"
	line "kann nur eine"
	cont "Attacke."
	done

SECTION "_AskDeleteMoveText", ROMX
_AskDeleteMoveText::
	text "Soll "
	text_ram wStringBuffer1
	text ""
	line "vergessen werden?"
	done

SECTION "_DeleterForgotMoveText", ROMX
_DeleterForgotMoveText::
	text "Dein #mon hat"
	line "die Attacke"
	cont "vergessen."
	done

SECTION "_DeleterEggText", ROMX
_DeleterEggText::
	text "Ein Ei verfügt"
	line "über keine"
	cont "Attacken!"
	done

SECTION "_DeleterNoComeAgainText", ROMX
_DeleterNoComeAgainText::
	text "Nein? Besuche mich"
	line "wieder."
	done

SECTION "_DeleterAskWhichMoveText", ROMX
_DeleterAskWhichMoveText::
	text "Welche Attacke"
	line "soll vergessen"
	cont "werden?"
	prompt

SECTION "_DeleterIntroText", ROMX
_DeleterIntroText::
	text "Ähm… Oh, ja, ich"
	line "bin der Attacken-"
	cont "Verlerner."

	para "Ich verfüge über"
	line "die Fähigkeit,"
	cont "#mon ihre"
	cont "Attacken vergessen"
	cont "zu lassen."

	para "Soll ein #mon "
	line "eine Attacke"
	cont "vergessen?"
	done

SECTION "_DeleterAskWhichMonText", ROMX
_DeleterAskWhichMonText::
	text "Welches #mon?"
	prompt

SECTION "Text_DSTIsThatOK", ROMX
Text_DSTIsThatOK::
	text " SZ,"
	line "in Ordnung?"
	done

SECTION "_TimeAskOkayText", ROMX
_TimeAskOkayText::
	text ","
	line "in Ordnung?"
	done

SECTION "_TimesetAskDSTText", ROMX
_TimesetAskDSTText::
	text "Möchtest du auf"
	line "Sommerzeit um-"
	cont "stellen?"
	done

SECTION "_TimesetDSTText", ROMX
_TimesetDSTText::
	text "Ich stelle die Uhr"
	line "eine Stunde vor."
	prompt

SECTION "_TimesetAskNotDSTText", ROMX
_TimesetAskNotDSTText::
	text "Ist die Sommer-"
	line "zeit vorüber?"
	done

SECTION "_TimesetNotDSTText", ROMX
_TimesetNotDSTText::
	text "Ich stelle die Uhr"
	line "eine Stunde zu-"
	cont "rück."
	prompt

SECTION "_TimesetAskAdjustDSTText", ROMX
_TimesetAskAdjustDSTText::
	text "Möchtest du die"
	line "Uhrzeit der"

	para "Sommerzeit an-"
	line "passen?"
	done

SECTION "_MomLostGearBookletText", ROMX
_MomLostGearBookletText::
	text "Ich habe die An-"
	line "leitung für den"
	cont "#Com verloren."

	para "Komm später noch"
	line "mal wieder."
	prompt

SECTION "WonderTradeQuestionText", ROMX
WonderTradeQuestionText::
	text "Möchtest du"
	line "tauschen?"
	done

SECTION "WonderTradePromptText", ROMX
WonderTradePromptText::
	text "Welches #mon"
	line "möchtest du"
	cont "tauschen?"
	prompt

SECTION "WonderTradeCantTradeSpikyEaredPichuText", ROMX
WonderTradeCantTradeSpikyEaredPichuText::
	text "Dieses Pichu"
	line "scheint durch die"
	cont "Zeit gereist zu"
	cont "sein."

	para "Es wäre riskant,"
	line "es zu übertragen,"

	para "daher bleibt Pichu"
	line "am besten, wo es"
	cont "ist."
	prompt

;SECTION "WonderTradeCantTradeEggText", ROMX
;WonderTradeCantTradeEggText::
;	text "Sorry. We can't"
;	line "accept an Egg."
;	prompt

;SECTION "WonderTradeCantAcceptAbnormalMonText", ROMX
;WonderTradeCantAcceptAbnormalMonText::
;	text "Sorry, but your"
;	line "#mon appears to"
;
;	para "be abnormal. We"
;	line "can't accept it."
;	prompt

SECTION "WonderTradeConfirmText", ROMX
WonderTradeConfirmText::
	text_ram wStringBuffer1
	text " zum"
	line "Tausch anbieten?"
	done

SECTION "WonderTradeSetupText", ROMX
WonderTradeSetupText::
	text "Suche nach einem"
	line "Tauschpartner…"
	prompt

SECTION "WonderTradeReadyText", ROMX
WonderTradeReadyText::
	text "Ein Tauschpartner"
	line "wurde gefunden."
	prompt

SECTION "SilphMartIntroText", ROMX
SilphMartIntroText::
	text "Angestellte wie"
	line "ich kommen an"
	cont "Firmenkram heran!"

	para "Möchtest du etwas"
	line "davon kaufen?"
	done

SECTION "SilphMartComeAgainText", ROMX
SilphMartComeAgainText::
	text "Komm mal wieder!"
	line "Den Nebenverdienst"
	cont "kann ich brauchen."
	done

SECTION "AdventurerMartIntroText", ROMX
AdventurerMartIntroText::
	text "Ich habe im"
	line "Ausland ein paar"
	cont "seltene Items"
	cont "aufgetrieben!"
	done

SECTION "AdventurerMartComeAgainText", ROMX
AdventurerMartComeAgainText::
	text "Schau mal"
	line "wieder vorbei!"
	done

SECTION "InformalMartIntroText", ROMX
InformalMartIntroText::
	text "Was ist? Brauchst"
	line "du Vorräte?"
	done

SECTION "BazaarMartIntroText", ROMX
BazaarMartIntroText::
	text "Komm, schau dir"
	line "meine Waren an!"
	done

SECTION "AlreadyHaveTMText", ROMX
AlreadyHaveTMText::
	text "Du hast diese TM"
	line "bereits."
	done

SECTION "MartPremierBallText", ROMX
MartPremierBallText::
	text "Du bekommst noch"
	line "einen Premierball"
	text_sound SFX_TRANSACTION
	cont "als Bonus dazu."
	done

SECTION "ItemCantBeSelectedText", ROMX
ItemCantBeSelectedText::
	text "Du kannst dieses"
	line "Item nicht"
	cont "auswählen."
	prompt

SECTION "AlreadyInThatBallTextData", ROMX
AlreadyInThatBallTextData::
	text "Dein #mon ist"
	line "bereits in diesem"
	cont "Ball."
	prompt

SECTION "CantChangeTradedMonBallTextData", ROMX
CantChangeTradedMonBallTextData::
	text "Du kannst den Ball"
	line "eines getauschten"
	cont "#mon nicht"
	cont "wechseln."
	prompt
