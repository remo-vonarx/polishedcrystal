BattleText::

LinkBattleErrorText::
	text "Es gab einen"
	line "Fehler bei der"
	cont "Verbindung."

	para "Das Spiel wird"
	line "neu gestartet."
	prompt

BattleText_PlayerPickedUpPayDayMoney:
	text "<PLAYER> hebt"
	line "¥"
	text_decimal wPayDayMoney, 3, 6
	text " auf!"
	prompt

WildPokemonAppearedText:
	text "Ein wildes"
	line ""
	text_ram wEnemyMonNickname
	text "!"
	prompt

LegendaryAppearedText:
	text_ram wEnemyMonNickname
	text ""
	line "erscheint!"
	prompt

GhostAppearedText:
	text "Ein Geist"
	line "erscheint!"
	prompt

SilphScopeRevealText:
	text "Das SilphScope2"
	line "enthüllt die Iden-"
	cont "tität des Geistes!"
	prompt

HookedPokemonAttackedText:
	text "Das gefangene"
	line ""
	text_ram wEnemyMonNickname
	text ""
	cont "greift an!"
	prompt

PokemonFellFromTreeText:
	text_ram wEnemyMonNickname
	text ""
	line "fällt vom Baum!"
	prompt

WantsToBattleText::
	text "<ENEMY>"
	line "möchte kämpfen!"
	prompt

WantToBattleText::
	text "<ENEMY>"
	line "möchten kämpfen!"
	prompt

BattleText_WildFled:
	text "Das wilde"
	line ""
	text_ram wEnemyMonNickname
	text ""
	cont "ist geflohen!"
	prompt

BattleText_LegendaryFled:
	text_ram wEnemyMonNickname
	text ""
	line "ist geflohen!"
	prompt

BattleText_EnemyFled:
	text "Gegn. "
	text_ram wEnemyMonNickname
	text ""
	line "ist geflohen!"
	prompt

BattleText_EnemyCantEscape:
	text "<USER>"
	line "kann nicht"
	cont "fliehen!"
	prompt

if DEF(DEBUG)
DealtXDamageText:
	text "Dealt "
	text_decimal wCurDamage, 2, 5
	text " dmg"
	line "before roll."
	prompt
endc

HurtByPoisonText:
	text "Das Gift schadet"
	line "<USER>!"
	done

HurtByBurnText:
	text "Die Verbrennung"
	line "schadet"
	cont "<USER>!"
	done

LeechSeedSapsText:
	text "Die Egelsamen-"
	line "Attacke schadet"
	cont "<USER>!"
	prompt

HurtByCurseText:
	text "Fluch schadet"
	line "<USER>!"
	prompt

SandstormHitsText:
	text "Sandsturm trifft"
	line "<USER>!"
	prompt

HailHitsText:
	text "Hagelsturm trifft"
	line "<USER>!"
	prompt

PerishCountText:
	text "<USER>:"
	line "Abgesang steht bei"
	cont ""
	text_decimal wTextDecimalByte, 1, 1
	text "!"
	prompt

BattleText_UserLostSomeOfItsHP:
	text "<USER>"
	line "hat einige KP"
	cont "verloren!"
	prompt

BattleText_PickedUpItem:
	; assumes player (enemy might overflow text-wise)
	text "<USER>"
	line "hebt "
	text_ram wStringBuffer2
	text ""
	cont "auf."
	prompt

BattleText_UserRecoveredWithItem:
	text "<USER>"
	line "erholt sich mit"
	cont ""
	text_ram wStringBuffer1
	text "."
	prompt

BattleText_UserAteItem:
	text "<USER>"
	line "frisst"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

BattleText_UserHurtByItem:
	text "<USER>"
	line "erleidet Schaden"
	cont "durch"
	cont ""
	text_ram wStringBuffer1
	text "."
	prompt

BattleText_UserItemLetItMoveFirst::
	text "<USER>"
	line "handelt durch"
	cont ""
	text_ram wStringBuffer1
	text ""
	cont "als Erstes."
	prompt

BattleText_UserRecoveredPPUsing:
	text "<USER>"
	line "füllt die AP von"
	cont ""
	text_ram wStringBuffer2
	text " mit"
	cont ""
	text_ram wStringBuffer1
	text " auf!"
	prompt

BrokeLightScreenText:
	text "<USER>"
	line "durchbricht den"
	cont "Lichtschild des"
	cont "Ziels!"
	prompt

BrokeReflectText:
	text "<USER>"
	line "durchbricht den"
	cont "Reflektor des"
	cont "Ziels!"
	prompt

BattleText_ItemLowered:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	text_pause
	text_asm
	ld hl, .Verb
	jmp ScrollBattleText

.Verb:
	line "sinkt durch"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

BattleText_ItemHarshlyLowered:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	text_pause
	text_asm
	ld hl, .Verb
	jmp ScrollBattleText

.Verb:
	line "sinkt stark durch"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

BattleText_ItemSeverelyLowered:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	text_pause
	text_asm
	ld hl, .Verb
	jmp ScrollBattleText

.Verb:
	line "sinkt drastisch"
	cont "durch"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

BattleText_ItemRaised:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	text_pause
	text_asm
	ld hl, .Verb
	jmp ScrollBattleText

.Verb:
	line "steigt durch"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

BattleText_ItemSharplyRaised:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	text_pause
	text_asm
	ld hl, .Verb
	jmp ScrollBattleText

.Verb:
	line "steigt stark durch"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

BattleText_ItemDrasticallyRaised:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	text_pause
	text_asm
	ld hl, .Verb
	jmp ScrollBattleText

.Verb:
	line "steigt drastisch"
	cont "durch"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

BattleText_ItemRaisedCrit:
	text "<USER>"
	line "pumpt sich mit"
	cont ""
	text_ram wStringBuffer1
	text " auf!"
	prompt

BattleText_MegaSolCharged:
	text "<USER>"
	line "wurde aufgeladen!"
	prompt

BattleText_UserChargedWithItem:
	text "<USER>"
	line "lädt sich mit"
	cont ""
	text_ram wStringBuffer1
	text " auf!"
	prompt

BattleText_UsersFutureSightMissed:
; used when Future Sight can't hit anything because there was
; no target (so <TARGET> is undefined)
	text "Seher trifft ein!"

	para "Doch es schlug"
	line "fehl!"
	prompt

BattleText_TargetWasHitByFutureSight:
	text "<TARGET>"
	line "wurde von"
	cont "Seher"
	cont "erfasst!"
	prompt

BattleText_MistFaded:
	text_ram wStringBuffer1
	text ""
	line "Weißnebel"
	cont "schwindet!"
	prompt

BattleText_SafeguardFaded:
	text_ram wStringBuffer1
	text ""
	line "Bodyguard"
	cont "schwindet!"
	prompt

BattleText_LightScreenFell:
	text_ram wStringBuffer1
	text ""
	line "Lichtschild"
	cont "schwindet!"
	prompt

BattleText_ReflectFaded:
	text_ram wStringBuffer1
	text ""
	line "Reflektor"
	cont "schwindet!"
	prompt

BattleText_TheRainStopped:
	text "Es hat aufgehört"
	line "zu regnen."
	prompt

BattleText_TheSunlightFaded:
	text "Das Sonnenlicht"
	line "schwindet."
	prompt

BattleText_TheSandstormSubsided:
	text "Der Sandsturm"
	line "lässt nach."
	prompt

BattleText_TheHailStopped:
	text "Es hat aufgehört"
	line "zu hageln."
	prompt

BattleText_EnemyPkmnFainted:
	text "Gegn. "
	text_ram wEnemyMonNickname
	text ""
	line "wurde besiegt!"
	prompt

GotMoneyForWinningText:
	text "<PLAYER>"
	line "erhält ¥"
	text_decimal wBattleReward, 3, 6
	text "!"
	prompt

BattleText_EnemyWasDefeated:
	text "<ENEMY>"
	line "wurde besiegt!"
	prompt

BattleText_EnemyWereDefeated:
	text "<ENEMY>"
	line "wurden besiegt!"
	prompt

TiedAgainstText:
	text "Spielt Remis gegen"
	line "<ENEMY>!"
	prompt

SentSomeToMomText:
	text "<PLAYER> erhält"
	line "¥"
	text_decimal wBattleReward, 3, 6
	text " und schickt"
	para "einen Teil nach"
	line "Hause."
	prompt

SentHalfToMomText:
	text "Die Hälfte wurde"
	cont "nach Hause"
	cont "geschickt!"
	prompt

SentAllToMomText:
	text "Alles wurde nach"
	cont "Hause geschickt!"
	prompt

BattleText_PkmnFainted:
	text_ram wBattleMonNickname
	text ""
	line "wurde besiegt!"
	prompt

BattleText_UseNextMon:
	text "Nächstes #mon"
	line "einsetzen?"
	done

LostAgainstText:
	text "Verlor gegen"
	line "<ENEMY>!"
	prompt

BattleText_EnemyIsAboutToUseWillPlayerSwitchPkmn:
	text "<ENEMY>"
	line "setzt"
	cont ""
	text_ram wEnemyMonNickname
	text " ein."

	para "Möchtest du das"
	line "#mon wechseln?"
	done

BattleText_EnemyAreAboutToUseWillPlayerSwitchPkmn:
	text "<ENEMY>"
	line "setzen"
	cont ""
	text_ram wEnemyMonNickname
	text " ein."

	para "Möchtest du das"
	line "#mon wechseln?"
	done

BattleText_EnemyIsAboutToSwitchWillPlayerSwitchPkmn:
	text "<ENEMY>"
	line "wechselt das"
	cont "#mon."

	para "Möchtest du das"
	line "#mon wechseln?"
	done

BattleText_EnemyAreAboutToSwitchWillPlayerSwitchPkmn:
	text "<ENEMY>"
	line "wechseln das"
	cont "#mon."

	para "Möchtest du das"
	line "#mon wechseln?"
	done

BattleText_EnemySentOut:
	text "<ENEMY>"
	line "schickt"
	cont ""
	text_ram wEnemyMonNickname
	text ""
	cont "in den Kampf!"
	done

BattleText_TheresNoWillToBattle:
	text "Es kann nicht"
	line "kämpfen!"
	prompt

BattleText_AnEGGCantBattle:
	text "Ein Ei kann"
	line "nicht kämpfen!"
	prompt

BattleText_CantEscape:
	text "Flucht unmöglich!"
	prompt

BattleText_AskForfeitTrainerBattle:
	text "Möchtest du wirk-"
	line "lich aufgeben?"
	done

BattleText_GotAwaySafely:
	text "Du bist entkommen!"
	prompt

BattleText_UserFledUsingAStringBuffer1:
	text "<USER>"
	line "floh durch"
	cont "den Einsatz von"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

BattleText_UserHurtBySpikes:
	text "Stachler schadet"
	line "<USER>!"
	prompt

RecoveredUsingText:
	text "<USER>"
	line "heilt sich mit"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

AirBalloonPoppedText:
	text "<TARGET>'s"
	line "Luftballon ist"
	cont "geplatzt!"
	prompt

BattleText_UsersStringBuffer1Activated:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer1
	text ""
	cont "aktiviert!"
	prompt

BattleText_ItemsCantBeUsedHere:
	text "Items können hier"
	line "nicht eingesetzt"
	cont "werden."
	prompt

BattleText_PkmnIsAlreadyOut:
	text_ram wBattleMonNickname
	text ""
	line "kämpft bereits."
	prompt

BattleText_PkmnCantBeRecalled:
	text_ram wBattleMonNickname
	text ""
	line "kann nicht aus-"
	cont "getauscht werden!"
	prompt

BattleText_PkmnCantBeRecalledAbility:
	text_ram wEnemyMonNickname
	text "'s"
	line ""
	text_ram wStringBuffer1
	text ""
	cont "verhindert die"
	cont "Flucht!"
	prompt

BattleText_TheresNoPPLeftForThisMove:
	text "Du hast keine AP"
	line "für diese Attacke"
	cont "mehr übrig!"
	prompt

BattleText_ItemOnlyAllowsMove: ; choice items
	text_ram wStringBuffer1
	text ""
	line "lässt nur"
	cont ""
	text_ram wStringBuffer2
	text " zu!"
	prompt

BattleText_MonCanOnlyUseMove:
	text "<USER>"
	line "kann nur"
	cont ""
	text_ram wStringBuffer1
	text ""
	cont "einsetzen!"
	prompt

BattleText_ItemPreventsStatusMoves: ; assault vest
	text_ram wStringBuffer1
	text ""
	line "verhindert Status-"
	cont "attacken!"
	prompt

BattleText_TheMoveIsDisabled:
	text "Die Attacke ist"
	line "blockiert!"
	prompt

BattleText_PkmnHasNoMovesLeft:
	text_ram wBattleMonNickname
	text ""
	line "hat keine Attacken"
	cont "mehr übrig!"
	done

BattleText_UserEncoreEnded:
	text "<USER>'s"
	line "Zugabe hört auf!"
	prompt

BattleText_StringBuffer1GrewToLevel:
	text_ram wStringBuffer1
	text ""
	line "erreicht LV "
	text_decimal wCurPartyLevel, 1, 3
	text "!"
	text_sound SFX_DEX_FANFARE_50_79
	text_end

BattleText_WildPkmnIsEating:
	text "Wildes "
	text_ram wEnemyMonNickname
	text ""
	line "frisst!"
	prompt

BattleText_WildPkmnIsAngry:
	text "Wildes "
	text_ram wEnemyMonNickname
	text ""
	line "ist wütend!"
	prompt

BattleText_ThrewRock:
	text "<PLAYER> wirft"
	line "einen Stein."
	prompt

BattleText_ThrewBait:
	text "<PLAYER> wirft"
	line "einen Köder."
	prompt

FastAsleepText:
	text "<USER>"
	line "schläft tief!"
	done

WokeUpText:
	text "<USER>"
	line "ist aufgewacht!"
	prompt

WasFrozenText:
	text "<TARGET>"
	line "wurde eingefroren!"
	prompt

FrozenSolidText:
	text "<USER>"
	line "ist tiefgefroren!"
	done

FlinchedText:
	text "<USER>"
	line "schreckt zurück!"
	prompt

MustRechargeText:
	text "<USER>"
	line "muss sich wieder"
	cont "aufladen!"
	prompt

DisabledNoMoreText:
	text "<USER>"
	line "wird nicht"
	cont "mehr blockiert!"
	prompt

IsConfusedText:
	text "<USER>"
	line "ist verwirrt!"
	prompt

HurtItselfText:
	text "Es hat sich vor"
	line "Verwirrung selbst"
	cont "verletzt!"
	prompt

ConfusedNoMoreText:
	text "<USER>"
	line "ist nicht mehr"
	cont "verwirrt!"
	prompt

BecameConfusedText:
	text "<TARGET>"
	line "ist verwirrt!"
	prompt

BecameConfusedDueToFatigueText:
	text "<TARGET>"
	line "ist vor Erschöp-"
	cont "fung verwirrt!"
	prompt

AlreadyConfusedText:
	text "<TARGET>"
	line "ist schon"
	cont "verwirrt!"
	prompt

BattleText_UsersHurtByStringBuffer1:
	text_ram wStringBuffer1
	text ""
	line "schadet"

	para "<USER>!"
	prompt

BattleText_UserWasReleasedFromStringBuffer1:
	text "<USER>"
	line "wurde von"
	para ""
	text_ram wStringBuffer1
	text ""
	line "erlöst!"
	prompt

WhirlpoolTrapText:
	text "<TARGET>"
	line "ging in die Falle!"
	prompt

FireSpinTrapText:
	text "<TARGET>"
	line "ging in die Falle!"
	prompt

WrappedByText:
	text "<TARGET>"
	line "erleidet Schaden"
	para "durch"
	line "<USER>'s"
	para "Wickel!"
	prompt

HungOnText:
	text "<TARGET>"
	line "klammert sich an"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

EnduredText:
	text "<TARGET>'s"
	line "Ausdauer mindert"
	cont "die Attacke!"
	prompt

InLoveWithText:
	text "<USER>"
	line "verliebt sich in"
	cont "<TARGET>!"
	prompt

InfatuationText:
	text "<USER>"
	line "ist zu verliebt,"
	cont "um anzugreifen!"
	prompt

NoLongerInfatuatedText:
	text "<USER>"
	line "ist nicht mehr"
	cont "verliebt!"
	prompt

ObliviousPreventedDestinyKnot:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer1
	text ""
	cont "verhindert die"
	cont "Anziehung durch"
	cont ""
	text_ram wStringBuffer2
	text "!"
	prompt

DestinyKnotInfatuatedUser:
	text "<TARGET>'s"
	line ""
	text_ram wStringBuffer1
	text ""
	cont "macht"

	para "<USER>"
	line "verliebt!"
	prompt

DisabledMoveText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer1
	text ""
	cont "wird blockiert!"
	prompt

UsedMoveText:
	text "<USER>"
	line "ben. "
	text_ram wStringBuffer2
	text "!"
	done

UsedMoveInsteadText:
	text "<USER>"
	line "ben. stattdessen"
	cont ""
	text_ram wStringBuffer2
	text "!"
	done

LoafingAroundText:
	text_ram wBattleMonNickname
	text ""
	line "faulenzt."
	prompt

BeganToNapText:
	text_ram wBattleMonNickname
	text ""
	line "macht ein"
	cont "Nickerchen!"
	prompt

WontObeyText:
	text_ram wBattleMonNickname
	text ""
	line "ist ungehorsam!"
	prompt

TurnedAwayText:
	text_ram wBattleMonNickname
	text ""
	line "wendet sich ab!"
	prompt

IgnoredOrdersText:
	text_ram wBattleMonNickname
	text ""
	line "ignoriert Befehl!"
	prompt

IgnoredSleepingText:
	text_ram wBattleMonNickname
	text " igno-"
	line "riert den Befehl"
	cont "…es schläft!"
	prompt

NoPPLeftText:
	text "Es sind nicht"
	line "genügend AP für"
	cont "diese Attacke"
	cont "vorhanden!"
	prompt

HasNoPPLeftText:
	text "<USER>"
	line "hat keine AP für"
	cont ""
	text_ram wStringBuffer2
	text "!"
	prompt

WentToSleepText:
	text "<USER>"
	line "schläft ein!"
	done

RestedText:
	text "<USER>"
	line "schläft und"
	cont "erholt sich!"
	done

RegainedHealthText:
	text "<USER>"
	line "erholt sich!"
	prompt

IsHurtText:
	text "<USER>"
	line "wird verletzt!"
	prompt

IsTormentedText:
	text "<TARGET>"
	line "wird gequält!"
	prompt

AttackMissedText:
	text "<USER>'s"
	line "Attacke ging"
	cont "daneben!"
	prompt

CrashedText:
	text "<USER>"
	line "macht weiter und"
	para "fällt hin!"
	prompt

UnaffectedText:
	text "<TARGET>"
	line "ist unversehrt!"
	prompt

DoesntAffectText:
	text "Es hat keine"
	line "Wirkung!"
	prompt

CriticalHitText:
	text "Volltreffer!"
	prompt

ExtremelyEffectiveText:
	text "Die Attacke ist"
	line "extrem effektiv!"
	prompt

SuperEffectiveText:
	text "Die Attacke ist"
	line "sehr effektiv!"
	prompt

NotVeryEffectiveText:
	text "Die Attacke ist"
	line "nicht sehr"
	cont "effektiv…"
	prompt

MostlyIneffectiveText:
	text "Die Attacke ist"
	line "kaum effektiv…"
	prompt

TookDownWithItText:
	text "K.O. für beide"
	line "<TARGET>,"
	cont "<USER>!"
	prompt

RageBuildingText:
	text "<USER>"
	line "verfällt in"
	cont "Raserei!"
	prompt

GotAnEncoreText:
	text "<TARGET>"
	line "setzt"
	cont "Zugabe ein!"
	prompt

SharedPainText:
	text "Die Kämpfer teilen"
	line "den Schmerz!"
	prompt

SwappedAbilitiesText:
	text "Die Kämpfer"
	line "tauschen ihre"
	cont "Fähigkeiten!"
	prompt

SwappedItemsText:
	text "Die Kämpfer"
	line "tauschen ihre"
	cont "Items!"
	prompt

ChangeIntoTypeText:
	text "Zum Typ welcher"
	line "Attacke wechseln?"
	prompt

InvalidTypeChangeText:
	text "Du kannst den Typ"
	line "dieser Attacke"
	cont "nicht wählen!"
	prompt

SketchedText:
	text "<USER>"
	line "benutzt Nachahmer"
	para "und setzt"
	line ""
	text_ram wStringBuffer1
	text " ein!"
	prompt

DestinyBondEffectText:
	text "<USER>"
	line "versucht ein"
	cont "beidseitiges"
	cont "K.O.!"
	prompt

BellChimedText:
	text "Eine Glocke"
	line "erklingt!"
	prompt

FellAsleepText:
	text "<TARGET>"
	line "schläft!"
	prompt

AlreadyAsleepText:
	text "<TARGET>"
	line "schläft bereits!"
	prompt

WasPoisonedText:
	text "<TARGET>"
	line "wurde vergiftet!"
	prompt

BadlyPoisonedText:
	text "<TARGET>"
	line "ist schwer"
	cont "vergiftet!"
	prompt

AlreadyPoisonedText:
	text "<TARGET>"
	line "ist bereits"
	cont "vergiftet!"
	prompt

SuckedHealthText:
	text "<TARGET>"
	line "hat KP verloren!"
	prompt

DreamEatenText:
	text "<TARGET>'s"
	line "Traum gefressen!"
	prompt

WasBurnedText:
	text "<TARGET>"
	line "brennt!"
	prompt

AlreadyBurnedText:
	text "<TARGET>"
	line "brennt bereits!"
	prompt

WontRiseAnymoreText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	text_pause
	text_asm
	ld hl, .Verb
	jr ScrollBattleText

.Verb:
	line "steigt nicht mehr!"
	prompt

WontDropAnymoreText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	text_pause
	text_asm
	ld hl, .Verb
	jr ScrollBattleText

.Verb:
	line "sinkt nicht mehr!"
	prompt

StatRoseText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	text_pause
	text_asm
	ld hl, .Verb
	jr ScrollBattleText

.Verb:
	line "steigt!"
	prompt

StatRoseSharplyText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	text_pause
	text_asm
	ld hl, .Verb
	jr ScrollBattleText

.Verb:
	line "steigt stark!"
	prompt

StatRoseDrasticallyText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	text_pause
	text_asm
	ld hl, .Verb
	jr ScrollBattleText

.Verb:
	line "steigt drastisch!"
	prompt

ScrollBattleText:
; Scroll the box one line up without waiting for A, then go on with the text at hl.
	push hl
	call TextScroll
	call TextScroll
	pop hl
	ret

StatFellText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	text_pause
	text_asm
	ld hl, .Verb
	jr ScrollBattleText

.Verb:
	line "sinkt!"
	prompt

StatHarshlyFellText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	text_pause
	text_asm
	ld hl, .Verb
	jr ScrollBattleText

.Verb:
	line "sinkt stark!"
	prompt

StatSeverelyFellText:
	text "<USER>'s"
	line ""
	text_ram wStringBuffer2
	text_pause
	text_asm
	ld hl, .Verb
	jr ScrollBattleText

.Verb:
	line "sinkt drastisch!"
	prompt

FledFromBattleText::
	text "<USER>"
	line "flieht!"
	prompt

FledInFearText:
	text "<TARGET>"
	line "flieht vor Angst!"
	prompt

HitNTimesText:
	text "Erleidet "
	text_decimal wItemQuantityChangeBuffer, 1, 2
	line "Treffer!"
	prompt

MistText:
	text "<USER>"
	line "ist von"
	cont "Weißnebel"
	cont "umgeben!"
	prompt

ProtectedByItemText:
	text "<TARGET>"
	line "ist geschützt"
	cont "durch"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

ProtectedByMistText:
	text "Weißnebel schützt"
	line "<TARGET>."
	prompt

GettingPumpedText:
	text "<USER>"
	line "pumpt sich auf!"
	prompt

RecoilText:
	text "<USER>"
	line "wird verletzt!"
	prompt

MadeSubstituteText:
	text "<USER>"
	line "generiert einen"
	cont "Delegator!"
	prompt

HasSubstituteText:
	text "<USER>"
	line "hat schon einen"
	cont "Delegator!"
	prompt

TooWeakSubText:
	text "Keine Energie für"
	line "den Delegator!"
	prompt

SubTookDamageText:
	text "Der Delegator"
	line "nimmt Schaden für"
	cont "<TARGET>!"
	prompt

SubFadedText:
	text "Der Delegator von"
	line "<TARGET>"
	cont "lässt nach!"
	prompt

WasSeededText:
	text "<TARGET>"
	line "wurde bepflanzt!"
	prompt

EvadedText:
	text "<TARGET>"
	line "ist ausgewichen!"
	prompt

WasDisabledText:
	text "<TARGET>'s"
	line ""
	text_ram wStringBuffer2
	text ""
	cont "wird blockiert!"
	prompt

CoinsScatteredText:
	text "Es liegen überall"
	line "Münzen verstreut!"
	prompt

TransformedTypeText:
	text "<USER>"
	line "wird zu einem"
	cont "#mon des Typs"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

EliminatedStatsText:
	text "Alle Status-"
	line "änderungen werden"
	cont "aufgehoben!"
	prompt

TransformedText:
	text "<USER>"
	line "ben. Wandler"
	cont "und wird zu"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

TrickRoomText:
	text "<USER>"
	line "verdreht die"
	cont "Dimensionen!"
	prompt

TrickRoomEndedText:
	text "Die verdrehten"
	line "Dimensionen"

	para "sind wieder"
	line "normal!"
	prompt

LightScreenEffectText:
	text "<USER>'s"
	line "Spez.-Verteidigung"
	text_pause
	text_asm
	ld hl, .Verb
	jmp ScrollBattleText

.Verb:
	line "steigt!"
	prompt

ReflectEffectText:
	text "<USER>'s"
	line "Verteidigung"
	text_pause
	text_asm
	ld hl, .Verb
	jmp ScrollBattleText

.Verb:
	line "steigt!"
	prompt

NothingHappenedText:
	text "Nichts geschieht."
	prompt

ButItFailedText:
	text "Es schlug fehl!"
	prompt

DidntAffectText:
	text "Es zeigt keine"
	line "Wirkung auf"
	cont "<TARGET>!"
	prompt

HPIsFullText:
	text "Die KP von"
	line "<USER>"
	para "wurden ganz"
	line "aufgefüllt!"
	prompt

DraggedOutText:
	text "<USER>"
	line "wurde auserwählt!"
	prompt

ParalyzedText:
	text "<TARGET>"
	line "ist paralysiert!"
	prompt

FullyParalyzedText:
	text "<USER>"
	line "ist paralysiert!"
	done

AlreadyParalyzedText:
	text "<TARGET>"
	line "ist schon"
	cont "paralysiert!"
	prompt

ProtectedByText:
	text "<TARGET>"
	line "ist geschützt"
	cont "durch"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

RegainedStatsWithItem:
	text "<USER>"
	line "stellt mit"
	cont ""
	text_ram wStringBuffer1
	text ""
	cont "seine Statuswerte"
	cont "wieder her!"
	prompt

CuredInfatuationWithItem:
	text "<USER>"
	line "heilt Verliebtheit"
	cont "mit "
	text_ram wStringBuffer1
	text "!"
	prompt

CuredEncoreWithItem:
	text "<USER>"
	line "hebt Zugabe mit"
	cont ""
	text_ram wStringBuffer1
	text " auf!"
	prompt

CuredDisableWithItem:
	text "<USER>"
	line "hebt Aussetzer mit"
	cont ""
	text_ram wStringBuffer1
	text " auf!"
	prompt

StoleText:
	text "<USER>"
	line "raubt "
	text_ram wStringBuffer1
	text ""
	cont "vom Gegner!"
	prompt

KnockedOffItemText:
	text "<USER>"
	line "schlägt"
	cont ""
	text_ram wStringBuffer1
	text " weg!"
	prompt

CantEscapeNowText:
	text "<TARGET>"
	line "kann nicht"
	cont "fliehen!"
	prompt

WasDefrostedText:
	text "<USER>"
	line "wurde aufgetaut!"
	prompt

PutACurseText:
	text "<USER>"
	line "zieht sich KP ab"

	para "und belegt"
	line "<TARGET>"
	cont "mit einem Fluch!"
	prompt

ProtectedItselfText:
	text "<USER>"
	line "schützt sich"
	cont "selbst!"
	prompt

ProtectingItselfText:
	text "Der Schutz wendet"
	line "Schaden ab von"
	cont "<TARGET>!"
	done

SpikesText:
	text "Stachler umgibt"
	line "<TARGET>!"
	prompt

ToxicSpikesText:
	text "Giftspitzen"
	line "umgeben"
	cont "<TARGET>!"
	prompt

IdentifiedText:
	text "<USER>"
	line "identifiziert"
	cont "<TARGET>!"
	prompt

StartPerishSongText:
	text "#mon, die das"
	line "Lied gehört haben,"
	cont "gehen in 3 Runden"
	cont "K.O.!"
	prompt

StartPerishBodyText:
	text "Beide #mon"
	line "werden in 3 Runden"
	cont "K.O. gehen!"
	prompt

SandstormBrewedText:
	text "Ein Sandsturm"
	line "entsteht!"
	prompt

HailStartedText:
	text "Es fängt an zu"
	line "hageln!"
	prompt

BracedItselfText:
	text "<USER>"
	line "macht sich bereit!"
	prompt

FellInLoveText:
	text "<TARGET>"
	line "verliebt sich!"
	prompt

CoveredByVeilText:
	text "<USER>"
	line "wird verschleiert!"
	prompt

SafeguardProtectText:
	text "<TARGET>"
	line "wird von Bodyguard"
	cont "beschützt!"
	prompt

MagnitudeText:
	text "Intensität "
	text_decimal wTextDecimalByte, 1, 2
	text "!"
	prompt

ReleasedByText:
	text "<USER>"
	line "entkam"
	cont "<TARGET>!"
	prompt

ShedLeechSeedText:
	text "<USER>"
	line "befreit sich von"
	cont "Egelsamen!"
	prompt

BlewSpikesText:
	text "<USER>"
	line "entfernt"
	cont "Stachler!"
	prompt

BlewToxicSpikesText:
	text "<USER>"
	line "entfernt"
	cont "Giftspitzen!"
	prompt

DownpourText:
	text "Es fängt an zu"
	line "regnen!"
	prompt

SunGotBrightText:
	text "Die Sonne scheint"
	line "hell!"
	prompt

BellyDrumText:
	text "<USER>"
	line "zieht sich KP ab,"
	cont "um den Angriffs-"
	cont "wert zu erhöhen!"
	prompt

BellyDrumContraryText:
	text "<USER>"
	line "zieht sich KP ab,"
	cont "um den Angriffs-"
	cont "wert auf Minimum"
	cont "zu senken!"
	prompt

ForesawAttackText:
	text "<USER>"
	line "erahnt Attacke!"
	prompt

IgnoredOrders2Text:
	text "<USER>"
	line "gehorcht nicht!"
	prompt

BecameHealthyText:
	text "<USER>"
	line "wird gesund!"
	prompt

PlayerAffectionEndureText:
	text "<USER>"
	line "hält durch, damit"

	para "<PLAYER>"
	line "nicht traurig ist!"
	prompt

EnemyAffectionEndureText:
	text "<USER>"
	line "hält durch, damit"

	para "<ENEMY>"
	line "nicht traurig ist!"
	prompt

PlayerAffectionEvasionText:
	text "<USER>"
	line "weicht der Attacke"

	para "auf <PLAYER>'s"
	line "Ruf hin aus!"
	prompt

EnemyAffectionEvasionText:
	text "<USER>"
	line "weicht der Attacke"

	para "auf Ruf von"
	line "<ENEMY>"
	cont "aus!"
	prompt

PlayerAffectionSelfCureText:
	text "<USER>"
	line "wird gesund, damit"

	para "<PLAYER>"
	line "sich nicht sorgt!"
	prompt

EnemyAffectionSelfCureText:
	text "<USER>"
	line "wird gesund, damit"

	para "<ENEMY>"
	line "sich nicht sorgt!"
	prompt

AffectionCriticalText: ; same for both player and enemy
	text "<USER>"
	line "landet einen Voll-"

	para "treffer, um gelobt"
	line "zu werden!"
	prompt

NotifyAirBalloonText:
	text "<USER>"
	line "schwebt dank"
	cont ""
	text_ram wStringBuffer1
	text ""
	cont "in der Luft!"
	prompt

TraceActivationText:
	text "<USER>"
	line "kopiert"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

BattleText_IntimidateResisted:
	text "<TARGET>'s"
	line ""
	text_ram wStringBuffer1
	text ""

	para "schützt es vor"
	line "Bedroher!"
	prompt

NotifyCloudNine:
	text "Das Wetter wurde"
	line "unterdrückt!"
	prompt

NotifyPressure:
	text "<USER>"
	line "setzt den Gegner"
	cont "unter Druck!"
	prompt

NotifyMoldBreaker:
	text "<USER>"
	line "überbrückt alle"
	cont "Fähigkeiten!"
	prompt

NotifyUnnerve:
	text "<TARGET>"
	line "kriegt vor Angst"
	cont "keine Beeren mehr"
	cont "runter!"
	prompt

NotifyNeutralizingGas:
	text "Reaktionsgas"
	line "erfüllt die"
	cont "Umgebung!"
	prompt

FriskedItemText:
	text "<USER>"
	line "durchsucht den"
	cont "Gegner"

	para "und findet"
	line ""
	text_ram wStringBuffer1
	text "!"
	prompt

PickedItemText:
	text "<USER>"
	line "hebt "
	text_ram wStringBuffer1
	text ""
	cont "auf!"
	prompt

HarvestedItemText:
	text "<USER>"
	line "erntet"
	cont ""
	text_ram wStringBuffer1
	text "!"
	prompt

FirePoweredUpText:
	text "<USER>'s"
	line "Feuer-Attacken"
	cont "werden stärker!"
	prompt

AngerPointMaximizedAttackText:
	text "<USER>"
	line "maximiert seinen"
	cont "Angriff!"
	prompt

CannotUseText:
	text "<TARGET>"
	line "kann "
	text_ram wStringBuffer1
	text ""
	cont "nicht einsetzen!"
	prompt

ShudderedText:
; since the ability works with the opponent move data,
; it is on the opponent turn mostly
	text "<TARGET>"
	line "erschaudert!"
	prompt

ForewarnText:
	text "<TARGET>"
	line "hat "
	text_ram wStringBuffer1
	text "!"
	prompt

BouncedBackText:
	text "<USER>"
	line "wirft "
	text_ram wStringBuffer1
	text ""
	cont "zurück!"
	prompt

ItemCantBeStolenText:
	text "<TARGET>'s"
	line "Item kann nicht"
	cont "gestohlen werden!"
	prompt

SuckedUpOozeText:
	text "<USER>"
	line "saugt die Kloaken-"
	cont "soße auf!"
	prompt

BattleText_EnemyWithdrew::
	text "<ENEMY>"
	line "ersetzt"
	cont ""
	text_ram wEnemyMonNickname
	text "!"
	prompt

BattleText_WentBackToPlayer:
	text "<USER>"
	line "kehrt zu <PLAYER>"
	cont "zurück!"
	prompt

BattleText_WentBackToEnemy:
	text "<USER>"
	line "kehrt zu"
	cont "<ENEMY>"
	cont "zurück!"
	prompt

ScaredText:
	text "<USER>"
	line "traut sich nicht,"
	cont "sich zu bewegen!"
	prompt

GetOutText:
	text "Geist:"
	line "Verschwinde…"
	cont "Verschwinde…"
	prompt

CalFinalPkmnText:
CarrieFinalPkmnText:
JackyFinalPkmnText:
EunaFinalPkmnText:
	text "Ich habe noch"
	line "ein #mon!"
	prompt

FalknerFinalPkmnText:
	text "Aber jetzt wird"
	line "mir der Wind"
	cont "Auftrieb"
	cont "verleihen!"
	prompt

BugsyFinalPkmnText:
	text "Käfer-#mon"
	line "lassen sich nicht"
	cont "einfach unter-"
	cont "kriegen!"

	para "Auch nicht mein"
	line "Letztes!"
	prompt

WhitneyFinalPkmnText:
	text "Mo-Moment! Das ist"
	line "mein Letztes?"

	para "Aber… ich werde"
	line "nicht verlieren,"
	cont "klar?"
	prompt

MortyFinalPkmnText:
	text "Oh nein, noch"
	line "nicht!"

	para "Ich glaube noch an"
	line "einen Sieg!"
	prompt

ChuckFinalPkmnText:
	text "Ich gebe mich noch"
	line "nicht geschlagen!"
	prompt

JasmineFinalPkmnText:
	text "Mein stählernes"
	line "Herz gibt erst"
	cont "auf, wenn es"
	cont "vorbei ist!"
	prompt

PryceFinalPkmnText:
	text "Hm… das war gar"
	line "nicht schlecht."
	prompt

ClairFinalPkmnText:
	text "Nur noch eins?"

	para "Dann fängt der"
	line "Kampf jetzt"
	cont "richtig an!"
	prompt

WillFinalPkmnText:
	text "Psycho-#mon"
	line "kämpfen bis"
	cont "zuletzt."

	para "Genau das macht"
	line "sie so gefährlich!"
	prompt

KogaFinalPkmnText:
	text "Nur noch eins!"
	line "Mwahaha!"

	para "Das hier war von"
	line "Anfang an meine"
	cont "Trumpfkarte!"
	prompt

BrunoFinalPkmnText:
	text "Hau ordentlich"
	line "rein, bis du"
	cont "umfällst!"
	prompt

KarenFinalPkmnText:
	text "Freu dich nicht zu"
	line "früh!"

	para "Ich habe noch jede"
	line "Menge Spielraum!"
	prompt

ChampionFinalPkmnText:
	text "Gut so, gut so!"
	line "So ist es richtig!"
	prompt

BrockFinalPkmnText:
	text "Hahaha! Lass das,"
	line "das kitzelt!"
	prompt

MistyFinalPkmnText:
	text "Hmpf. Gar nicht"
	line "mal so übel."
	prompt

LtSurgeFinalPkmnText:
	text "Du glaubst, ich"
	line "bin am Ende?"

	para "Ich habe noch gar"
	line "nicht angefangen!"
	prompt

ErikaFinalPkmnText:
	text "Bloß keine"
	line "Samthandschuhe!"

	para "Gib mir alles, was"
	line "du hast!"
	prompt

JanineFinalPkmnText:
	text "Ich mag deinen"
	line "Kampfstil!"
	prompt

SabrinaFinalPkmnText:
	text "Mich beschleicht"
	line "eine leise Ahnung,"

	para "worauf das hier"
	line "für mich"
	cont "hinausläuft…"
	prompt

BlaineFinalPkmnText:
	text "Jetzt zeige ich"
	line "dir, was der"

	para "Kampfgeist einer"
	line "Höhlenarena"
	cont "bewirken kann!"
	prompt

BlueFinalPkmnText:
	text "Hehehe… wenn du"
	line "jetzt unachtsam"
	cont "wirst…"

	para "bist du"
	line "Geschichte!"
	prompt

RedFinalPkmnText: ; text > text
LeafFinalPkmnText:
	text "………………"
	prompt

Rival1_1FinalPkmnText:
	text "Grrr! Für einen"
	line "Schwächling hast"

	para "du ganz schön was"
	line "auf dem Kasten!"
	prompt

Rival1_2FinalPkmnText:
	text "Sieh mal einer an,"
	line "hast du inzwischen"

	para "etwa mehr Mumm in"
	line "den Knochen?"
	prompt

Rival1_3FinalPkmnText:
	text "Dafür, dass du so"
	line "ein Schwächling"

	para "bist, lässt du"
	line "echt nichts"
	cont "unversucht, was?"
	prompt

Rival1_4FinalPkmnText:
	text "Hey, Moment! Musst"
	line "du gleich so"

	para "aufbrausend"
	line "werden?"
	prompt

Rival1_5FinalPkmnText:
	text "Na gut, du"
	line "scheinst es nicht"

	para "nur durch Glück so"
	line "weit gebracht zu"
	cont "haben…"
	prompt

Rival2_1FinalPkmnText:
	text "Ich sehe schon…"
	line "du scheinst nicht"

	para "zum Spaß bis nach"
	line "Kanto gekommen zu"
	cont "sein…"
	prompt

Rival2_2FinalPkmnText:
	text "Was ist? Ein"
	line "#mon habe ich"
	cont "noch!"
	prompt

Lyra1_1FinalPkmnText:
	text "Du hast wohl noch"
	line "nie einen #mon-"
	cont "Kampf gehabt, was?"

	para "Ich könnte es dir"
	line "erklären, aber"

	para "aus Erfahrung"
	line "lernst du mehr."

	para "Gib dein Bestes,"
	line "<PLAYER>!"
	prompt

Lyra1_2FinalPkmnText:
	text "Du lernst schnell,"
	line "<PLAYER>!"
	prompt

Lyra1_3FinalPkmnText:
	text "Okay! Jetzt kommt"
	line "mein letztes"
	cont "#mon!"
	prompt

Lyra1_4FinalPkmnText:
	text "Egal ob ich ge-"
	line "winne oder ver-"
	cont "liere,"

	para "es hat Spaß"
	line "gemacht!"
	prompt

Lyra2_1FinalPkmnText:
	text "Jetzt habe ich nur"
	line "noch mein letztes"
	cont "#mon…"
	prompt

Proton1FinalPkmnText:
	text "Dass du mich"
	line "derart in die Ecke"

	para "treibst, hätte ich"
	line "nicht gedacht…"
	prompt

Proton2FinalPkmnText:
	text "In jeder Stadt"
	line "gibt es einen"

	para "Idioten, der sich"
	line "uns in den Weg"
	cont "stellt…"
	prompt

Petrel1FinalPkmnText:
	text "Wie jetzt? Ich"
	line "stehe im Rück-"
	cont "stand?"
	prompt

Petrel2FinalPkmnText:
	text "He, du bist gar"
	line "nicht so schlecht,"
	cont "wie ich dachte."
	prompt

Archer1FinalPkmnText:
	text "Du wirst uns nicht"
	line "aufhalten!"

	para "Nicht, solange"
	line "Giovanni nicht"

	para "wieder bei uns"
	line "ist!"
	prompt

Archer2FinalPkmnText:
	text "Ah, du bist in der"
	line "Tat stark, aber…"
	cont "ich frage mich…"
	prompt

Ariana1FinalPkmnText:
	text "W-wieso bist du so"
	line "stark?"
	prompt

Ariana2FinalPkmnText:
	text "He! Was soll das"
	line "denn werden, wenn"
	cont "es fertig ist?"
	prompt

Giovanni1FinalPkmnText:
	text "Mein #mon ist"
	line "unbesiegbar!"
	prompt

Giovanni2FinalPkmnText:
	text "Wie kann ein Kind,"
	line "das grüner hinter"

	para "den Ohren ist als"
	line "ich, so stark"
	cont "sein?"
	prompt

ProfOakFinalPkmnText:
	text "Hm! Ausgezeichnet!"
	line "Aber noch sind wir"
	cont "nicht fertig!"
	prompt

ProfElmFinalPkmnText:
	text "Es ist fast"
	line "vorbei…"
	prompt

ProfIvyFinalPkmnText:
	text "Ich bin angezählt,"
	line "aber noch nicht"
	cont "K.O.!"
	prompt

MysticalManFinalPkmnText:
	text "Zeit für eine"
	line "dramatische"
	cont "Wendung!"
	prompt

KarateKingFinalPkmnText:
	text "Yaaarggh!"
	prompt

PalmerFinalPkmnText:
	text "Bravo!"
	prompt

ThortonFinalPkmnText:
	text "Wow!"
	prompt

JessieJamesFinalPkmnText:
	text "Wir haben eine"
	line "stolze Tradition"

	para "des Scheiterns zu"
	line "wahren!"
	prompt

LoreleiFinalPkmnText:
	text "Das war erst ein"
	line "Vorgeschmack auf"
	cont "meine Kraft!"
	prompt

AgathaFinalPkmnText:
	text "Glaub nicht, dass"
	line "du schon gewonnen"
	cont "hast, Kind!"
	prompt

StevenFinalPkmnText:
	text "Ich wusste, dass"
	line "du stark bist…"
	prompt

CynthiaFinalPkmnText:
	text "Noch ist es nicht"
	line "vorbei!"
	prompt

InverFinalPkmnText:
	text "Du hast den Dreh"
	line "langsam raus!"
	prompt

CherylFinalPkmnText:
	text "Ich kann nicht"
	line "schnell genug"
	cont "heilen…"
	prompt

RileyFinalPkmnText:
	text "Dein Team! Ich"
	line "spüre deine starke"
	cont "Aura!"
	prompt

BuckFinalPkmnText:
	text "Und jetzt das!"
	line "Eine ganz heiße"
	cont "Situation!"
	prompt

MarleyFinalPkmnText:
	text "…Meine Zeit mit"
	line "dir neigt sich dem"
	cont "Ende entgegen…"
	prompt

MiraFinalPkmnText:
	text "Oh nein! Du bist"
	line "einfach eine"

	para "Nummer zu groß"
	line "für mich!"
	prompt

AnabelFinalPkmnText:
	text "Dein Talent…"
	line "Es ist echt."
	prompt

DarachFinalPkmnText:
	text "Mein letztes"
	line "Gefecht! Allez!"
	prompt

CaitlinFinalPkmnText:
	text "Was auch immer"
	line "geschieht, selbst"

	para "jetzt sollte ich"
	line "Ruhe bewahren…"
	prompt

CandelaFinalPkmnText:
	text "Auf Messers"
	line "Schneide!"
	cont "Wie spannend!"
	prompt

BlancheFinalPkmnText:
	text "Bisher bin ich"
	line "durchaus"
	cont "beeindruckt."
	prompt

SparkFinalPkmnText:
	text "Du bist gut!"
	line "Kein Zweifel!"
	prompt

FlanneryFinalPkmnText:
	text "Äh… was soll ich"
	line "jetzt machen?"
	prompt

MayleneFinalPkmnText:
	text "Das ist noch nicht"
	line "das Ende, Freund!"
	prompt

MarlonFinalPkmnText:
	text "Eine Zwickmühle!"

	para "Es gibt keinen"
	line "Ausweg mehr, aber"

	para "ich spüre dieses"
	line "freudige Kribbeln."
	prompt

ValerieFinalPkmnText:
	text "Ach herrje…"
	prompt

KukuiFinalPkmnText:
	text "Meine Seele brennt"
	line "heiß, oh yeah!"
	prompt

PiersFinalPkmnText:
	text "Bei mir gibt's"
	line "keine Zugabe!"

	para "Keine Songs, keine"
	line "Attacken und auch"
	cont "keine #mon!"
	prompt

LarryFinalPkmnText:
	text "Wenn es darauf an-"
	line "kommt, liefere ich"

	para "immer mein bestes"
	line "Ergebnis ab."
	prompt

BillFinalPkmnText:
	text "Juhu!"
	line "Was für ein Kampf!"
	prompt

YellowFinalPkmnText:
	text "Mein letztes"
	line "#mon…"

	para "Leih mir deine"
	line "Kraft!"
	prompt

WalkerFinalPkmnText:
	text "Wir können noch"
	line "fliegen!"
	prompt

ImakuniFinalPkmnText:
	text "Ich hau ab!"
	line "…Geht nicht?"
	prompt

LawrenceFinalPkmnText:
	text "Unbegreiflich!"
	prompt

ReiFinalPkmnText:
	text "Ich bin noch nicht"
	line "am Ende."
	prompt
