AbilityDescriptions:
	table_width 2
	dw NoAbilityDescription
	dw StenchDescription
	dw DrizzleDescription
	dw SpeedBoostDescription
	dw BattleArmorDescription
	dw SturdyDescription
	dw DampDescription
	dw LimberDescription
	dw SandVeilDescription
	dw StaticDescription
	dw VoltAbsorbDescription
	dw WaterAbsorbDescription
	dw ObliviousDescription
	dw CloudNineDescription
	dw CompoundEyesDescription
	dw InsomniaDescription
	dw ImmunityDescription
	dw FlashFireDescription
	dw ShieldDustDescription
	dw OwnTempoDescription
	dw SuctionCupsDescription
	dw IntimidateDescription
	dw ShadowTagDescription
	dw LevitateDescription
	dw EffectSporeDescription
	dw SynchronizeDescription
	dw ClearBodyDescription
	dw NaturalCureDescription
	dw LightningRodDescription
	dw SereneGraceDescription
	dw SwiftSwimDescription
	dw ChlorophyllDescription
	dw IlluminateDescription
	dw TraceDescription
	dw HugePowerDescription
	dw PoisonPointDescription
	dw InnerFocusDescription
	dw MagmaArmorDescription
	dw WaterVeilDescription
	dw MagnetPullDescription
	dw SoundproofDescription
	dw RainDishDescription
	dw SandStreamDescription
	dw PressureDescription
	dw ThickFatDescription
	dw EarlyBirdDescription
	dw FlameBodyDescription
	dw RunAwayDescription
	dw KeenEyeDescription
	dw HyperCutterDescription
	dw PickupDescription
	dw HustleDescription
	dw CuteCharmDescription
	dw StickyHoldDescription
	dw ShedSkinDescription
	dw GutsDescription
	dw MarvelScaleDescription
	dw LiquidOozeDescription
	dw OvergrowDescription
	dw BlazeDescription
	dw TorrentDescription
	dw SwarmDescription
	dw RockHeadDescription
	dw DroughtDescription
	dw ArenaTrapDescription
	dw VitalSpiritDescription
	dw WhiteSmokeDescription
	dw ShellArmorDescription
	dw TangledFeetDescription
	dw MotorDriveDescription
	dw RivalryDescription
	dw SteadfastDescription
	dw SnowCloakDescription
	dw GluttonyDescription
	dw AngerPointDescription
	dw UnburdenDescription
	dw DrySkinDescription
	dw DownloadDescription
	dw IronFistDescription
	dw PoisonHealDescription
	dw AdaptabilityDescription
	dw SkillLinkDescription
	dw HydrationDescription
	dw SolarPowerDescription
	dw QuickFeetDescription
	dw SniperDescription
	dw MagicGuardDescription
	dw NoGuardDescription
	dw TechnicianDescription
	dw LeafGuardDescription
	dw MoldBreakerDescription
	dw SuperLuckDescription
	dw AftermathDescription
	dw AnticipationDescription
	dw ForewarnDescription
	dw UnawareDescription
	dw TintedLensDescription
	dw FilterDescription
	dw ScrappyDescription
	dw IceBodyDescription
	dw SolidRockDescription
	dw SnowWarningDescription
	dw HoneyGatherDescription
	dw FriskDescription
	dw RecklessDescription
	dw BadDreamsDescription
	dw PickpocketDescription
	dw SheerForceDescription
	dw ContraryDescription
	dw UnnerveDescription
	dw DefiantDescription
	dw CursedBodyDescription
	dw WeakArmorDescription
	dw LightMetalDescription
	dw MultiscaleDescription
	dw HarvestDescription
	dw MoodyDescription
	dw OvercoatDescription
	dw PoisonTouchDescription
	dw RegeneratorDescription
	dw BigPecksDescription
	dw SandRushDescription
	dw WonderSkinDescription
	dw AnalyticDescription
	dw ImposterDescription
	dw InfiltratorDescription
	dw MoxieDescription
	dw JustifiedDescription
	dw RattledDescription
	dw MagicBounceDescription
	dw SapSipperDescription
	dw PranksterDescription
	dw SandForceDescription
	dw IronBarbsDescription
	dw FurCoatDescription
	dw BulletproofDescription
	dw CompetitiveDescription
	dw MegaLauncherDescription
	dw ToughClawsDescription
	dw PixilateDescription
	dw ParentalBondDescription
	dw BerserkDescription
	dw SlushRushDescription
	dw GalvanizeDescription
	dw CorrosionDescription
	dw FluffyDescription
	dw TanglingHairDescription
	dw ScreenCleanerDescription
	dw SteelySpiritDescription
	dw PerishBodyDescription
	dw GorillaTacticsDescription
	dw NeutralizingGasDescription
	dw PastelVeilDescription
	dw QuickDrawDescription
	dw WindRiderDescription
	dw CudChewDescription
	dw SharpnessDescription
	dw ArmorTailDescription
	dw MindsEyeDescription
	dw MegaSolDescription
	assert_table_length NUM_ABILITIES

NoAbilityDescription:
	text "Fähigkeiten sind"
	next "deaktiviert."
	done

StenchDescription:
	text "Gegner schreckt"
	next "evtl. zurück."
	done

DrizzleDescription:
	text "Erzeugt Regen"
	next "beim Einwechseln."
	done

SpeedBoostDescription:
	text "Erhöht Initiative"
	next "nach und nach."
	done

BattleArmorDescription:
ShellArmorDescription:
	text "Wehrt gegnerische"
	next "Volltreffer ab."
	done

SturdyDescription:
	text "Bietet Schutz gegen"
	next "K.O.-Treffer."
	done

DampDescription:
	text "Verhindert Selbst-"
	next "zerstörungen."
	done

LimberDescription:
	text "Schützt vor"
	next "Paralyse."
	done

SandVeilDescription:
	text "Erhöht im Sandsturm"
	next "den Fluchtwert."
	done

StaticDescription:
	text "Kann bei Berührung"
	next "paralysieren."
	done

VoltAbsorbDescription:
	text "Elektro-Attacken"
	next "regenerieren KP."
	done

WaterAbsorbDescription:
	text "Wasser-Attacken"
	next "regenerieren KP."
	done

ObliviousDescription:
	text "Verhindert"
	next "Anziehung."
	done

CloudNineDescription:
	text "Hebt die Effekte"
	next "des Wetters auf."
	done

CompoundEyesDescription:
	text "Steigert die"
	next "Genauigkeit."
	done

InsomniaDescription:
VitalSpiritDescription:
	text "Verhindert"
	next "Einschlafen."
	done

ImmunityDescription:
PastelVeilDescription:
	text "Verhindert"
	next "Vergiftungen."
	done

FlashFireDescription:
	text "Feuer-Treffer stär-"
	next "ken Feuer-Attacken."
	done

ShieldDustDescription:
	text "Blockt Zusatzeffek-"
	next "te von Attacken."
	done

OwnTempoDescription:
	text "Verhindert"
	next "Verwirrung."
	done

SuctionCupsDescription:
	text "Verhindert erzwun-"
	next "genen Austausch."
	done

IntimidateDescription:
	text "Senkt den Angriff"
	next "des Gegners."
	done

ShadowTagDescription:
	text "Hindert Gegner an"
	next "der Flucht."
	done

LevitateDescription:
	text "Immun gegen"
	next "Boden-Attacken."
	done

EffectSporeDescription:
	text "Berührung: evtl."
	next "Par, Gif oder Slf."
	done

SynchronizeDescription:
	text "Gibt Gif, Par oder"
	next "Brt an Gegner ab."
	done

ClearBodyDescription:
WhiteSmokeDescription:
	text "Kein Gegner senkt"
	next "Statuswerte."
	done

NaturalCureDescription:
	text "Heilt bei Austausch"
	next "Statusprobleme."
	done

LightningRodDescription:
	text "Elektro-Attacken"
	next "heben Sp.Angr."
	done

SereneGraceDescription:
	text "Erhöht Chance auf"
	next "Zusatz-Effekte."
	done

SwiftSwimDescription:
	text "Erhöht bei Regen"
	next "die Initiative."
	done

ChlorophyllDescription:
	text "Erhöht bei Sonne"
	next "die Initiative."
	done

IlluminateDescription:
	text "Wilde #mon"
	next "erscheinen öfter."
	done

TraceDescription:
	text "Kopiert Fähigkeit"
	next "des Gegners."
	done

HugePowerDescription:
	text "Erhöht den"
	next "Angriff."
	done

PoisonPointDescription:
	text "Kann bei Berührung"
	next "vergiften."
	done

InnerFocusDescription:
	text "Verhindert"
	next "Zurückschrecken."
	done

MagmaArmorDescription:
	text "Verhindert"
	next "Einfrieren."
	done

WaterVeilDescription:
	text "Verhindert"
	next "Verbrennungen."
	done

MagnetPullDescription:
	text "Hindert Stahl-PKMN"
	next "an der Flucht."
	done

SoundproofDescription:
	text "Immun gegen"
	next "Lärm-Attacken."
	done

RainDishDescription:
	text "Füllt bei Regen"
	next "langsam KP auf."
	done

SandStreamDescription:
	text "Erzeugt Sandsturm"
	next "beim Einwechseln."
	done

PressureDescription:
	text "Steigert AP-Ver-"
	next "brauch des Gegners."
	done

ThickFatDescription:
	text "Erhöht Abwehr gegen"
	next "Feuer und Eis."
	done

EarlyBirdDescription:
	text "Wacht schnell"
	next "wieder auf."
	done

FlameBodyDescription:
	text "Kann bei Berührung"
	next "Brand verursachen."
	done

RunAwayDescription:
	text "Sichere Flucht vor"
	next "wilden #mon."
	done

KeenEyeDescription:
	text "Kein Gegner senkt"
	next "die Genauigkeit."
	done

HyperCutterDescription:
	text "Kein Gegner senkt"
	next "den Angriff."
	done

PickupDescription:
	text "Hebt gelegentlich"
	next "Items auf."
	done

HustleDescription:
	text "Erhöht Angriff,"
	next "senkt Genauigkeit."
	done

CuteCharmDescription:
	text "Kann bei Berührung"
	next "betören."
	done

StickyHoldDescription:
	text "Verhindert Item-"
	next "Diebstahl."
	done

ShedSkinDescription:
	text "Heilt evtl. eigene"
	next "Statusprobleme."
	done

GutsDescription:
	text "Mehr Angriff bei"
	next "Statusproblemen."
	done

MarvelScaleDescription:
	text "Mehr Verteidigung"
	next "bei Statusproblem."
	done

LiquidOozeDescription:
	text "Schadet Gegnern,"
	next "die KP stehlen."
	done

OvergrowDescription:
	text "Stärkt in Notfällen"
	next "Pflanzen-Attacken."
	done

BlazeDescription:
	text "Stärkt in Notfällen"
	next "Feuer-Attacken."
	done

TorrentDescription:
	text "Stärkt in Notfällen"
	next "Wasser-Attacken."
	done

SwarmDescription:
	text "Stärkt in Notfällen"
	next "Käfer-Attacken."
	done

RockHeadDescription:
	text "Schützt vor"
	next "Rückstoß-Schaden."
	done

DroughtDescription:
	text "Erzeugt Sonnenlicht"
	next "beim Einwechseln."
	done

ArenaTrapDescription:
	text "Hindert den Gegner"
	next "an der Flucht."
	done

TangledFeetDescription:
	text "Erhöht bei Verwir-"
	next "rung Fluchtwert."
	done

MotorDriveDescription:
	text "Elektro-Attacken"
	next "heben Initiative."
	done

RivalryDescription:
	text "Mehr Schaden, wenn"
	next "Geschlecht gleich."
	done

SteadfastDescription:
	text "Mehr Initiative bei"
	next "Zurückschrecken."
	done

SnowCloakDescription:
	text "Erhöht bei Hagel"
	next "den Fluchtwert."
	done

GluttonyDescription:
	text "Regt an, Beeren"
	next "früh zu essen."
	done

AngerPointDescription:
	text "Maximiert Angriff"
	next "nach Volltreffer."
	done

UnburdenDescription:
	text "Mehr Initiative"
	next "nach Itemverlust."
	done

DrySkinDescription:
	text "Sonne kostet KP,"
	next "Wasser heilt KP."
	done

DownloadDescription:
	text "Werte passen sich"
	next "Gegnerabwehr an."
	done

IronFistDescription:
	text "Verstärkt Box- und"
	next "Hieb-Attacken."
	done

PoisonHealDescription:
	text "Füllt bei Vergif-"
	next "tung KP auf."
	done

AdaptabilityDescription:
	text "Verstärkt Attacken"
	next "des eigenen Typs."
	done

SkillLinkDescription:
	text "Serien-Attacken"
	next "treffen öfter."
	done

HydrationDescription:
	text "Heilt bei Regen"
	next "Statusprobleme."
	done

SolarPowerDescription:
	text "Sonne: mehr Spez.-"
	next "Angriff, senkt KP."
	done

QuickFeetDescription:
	text "Mehr Initiative bei"
	next "Statusproblemen."
	done

SniperDescription:
	text "Verstärkt"
	next "Volltreffer."
	done

MagicGuardDescription:
	text "Nur Attacken fügen"
	next "Schaden zu."
	done

NoGuardDescription:
	text "Eigene und Gegner-"
	next "attacken gelingen."
	done

TechnicianDescription:
	text "Verstärkt eigene"
	next "schwache Attacken."
	done

LeafGuardDescription:
	text "Sonne verhindert"
	next "Statusprobleme."
	done

MoldBreakerDescription:
	text "Attacken ignorieren"
	next "Gegner-Fähigkeit."
	done

SuperLuckDescription:
	text "Erhöht die"
	next "Volltrefferquote."
	done

AftermathDescription:
	text "Schadet Gegner bei"
	next "eigener Niederlage."
	done

AnticipationDescription:
	text "Ahnt gefährliche"
	next "Gegner-Attacken."
	done

ForewarnDescription:
	text "Gibt Auskunft über"
	next "Gegner-Attacken."
	done

UnawareDescription:
	text "Ignoriert Statusän-"
	next "derung des Gegners."
	done

TintedLensDescription:
	text "Stärkt nicht sehr"
	next "effektive Attacken."
	done

FilterDescription:
SolidRockDescription:
	text "Senkt sehr effekti-"
	next "ven Schaden."
	done

ScrappyDescription:
	text "Attacken treffen"
	next "Geist-#mon."
	done

IceBodyDescription:
	text "Füllt bei Hagel"
	next "langsam KP auf."
	done

SnowWarningDescription:
	text "Erzeugt Hagel"
	next "beim Einwechseln."
	done

HoneyGatherDescription:
	text "Sammelt gelegent-"
if DEF(FAITHFUL)
	next "lich Honig."
else
	next "lich Honig."
endc
	done

FriskDescription:
	text "Überprüft das Item"
	next "des Gegners."
	done

RecklessDescription:
	text "Verstärkt Attacken"
	next "mit Rückstoß."
	done

BadDreamsDescription:
	text "Senkt KP schlafen-"
	next "der Gegner."
	done

PickpocketDescription:
	text "Stiehlt Gegnern bei"
	next "Berührung Items."
	done

SheerForceDescription:
	text "Mehr Schaden statt"
	next "Zusatz-Effekten."
	done

ContraryDescription:
	text "Kehrt Statusände-"
	next "rungen um."
	done

UnnerveDescription:
	text "Hindert Gegner am"
	next "Beerenessen."
	done

DefiantDescription:
	text "Mehr Angriff, wenn"
	next "Werte sinken."
	done

CursedBodyDescription:
	text "Blockiert evtl. die"
	next "Gegner-Attacke."
	done

WeakArmorDescription:
	text "Körpertreffer: Vert"
	next "sinkt, Init steigt."
	done

LightMetalDescription:
	text "Halbiert das"
	next "eigene Gewicht."
	done

MultiscaleDescription:
	text "Weniger Schaden"
	next "bei vollen KP."
	done

HarvestDescription:
	text "Verzehrte Beeren"
	next "wachsen evtl. nach."
	done

MoodyDescription:
	text "Ein Wert steigt,"
	next "ein anderer sinkt."
	done

OvercoatDescription:
	text "Schützt vor"
	next "Wetterschäden."
	done

PoisonTouchDescription:
	text "Kann Gegner bei Be-"
	next "rührung vergiften."
	done

RegeneratorDescription:
	text "Füllt KP beim"
	next "Austausch auf."
	done

BigPecksDescription:
	text "Kein Gegner senkt"
	next "die Verteidigung."
	done

SandRushDescription:
	text "Erhöht im Sandsturm"
	next "die Initiative."
	done

WonderSkinDescription:
	text "Status-Attacken"
	next "treffen seltener."
	done

AnalyticDescription:
	text "Stärker, wenn es"
	next "zuletzt angreift."
	done

ImposterDescription:
	text "Verwandelt sich in"
	next "den Gegner."
	done

InfiltratorDescription:
	text "Attacken umgehen"
	next "Gegner-Barrieren."
	done

MoxieDescription:
	text "Mehr Angriff nach"
	next "besiegtem Gegner."
	done

JustifiedDescription:
	text "Mehr Angriff nach"
	next "Unlicht-Treffer."
	done

RattledDescription:
	text "Unlicht/Geist/Käfer"
	next "heben Initiative."
	done

MagicBounceDescription:
	text "Wirft Status-"
	next "Attacken zurück."
	done

SapSipperDescription:
	text "Mehr Angriff nach"
	next "Pflanzen-Treffer."
	done

PranksterDescription:
	text "Erstschlag mit"
	next "Status-Attacken."
	done

SandForceDescription:
	text "Stärkt Gestein, Bo-"
	next "den, Stahl im Sand."
	done

IronBarbsDescription:
	text "Schadet Gegnern bei"
	next "Berührung."
	done

FurCoatDescription:
	text "Halbiert Schaden"
	next "von Körperattacken."
	done

BulletproofDescription:
	text "Schützt vor Kugeln"
	next "und Bomben."
	done

CompetitiveDescription:
	text "Mehr Spez.-Angriff,"
	next "wenn Werte sinken."
	done

MegaLauncherDescription:
	text "Verstärkt Aura- und"
	next "Puls-Attacken."
	done

ToughClawsDescription:
	text "Verstärkt Attacken"
	next "mit Berührung."
	done

PixilateDescription:
	text "Normal-Attacken"
	next "werden zu Fee."
	done

ParentalBondDescription:
	text "Mutter und Kind"
	next "greifen beide an."
	done

BerserkDescription:
	text "Mehr Spez.-Angriff"
	next "ab halben KP."
	done

SlushRushDescription:
	text "Erhöht bei Hagel"
	next "die Initiative."
	done

GalvanizeDescription:
	text "Normal-Attacken"
	next "werden zu Elektro."
	done

CorrosionDescription:
	text "Vergiftet Gegner"
	next "jedes Typs."
	done

FluffyDescription:
	text "Zäh bei Berührung,"
	next "schwach bei Feuer."
	done

TanglingHairDescription:
	text "Kann bei Berührung"
	next "Initiative senken."
	done

GorillaTacticsDescription:
	text "Erhöht den Angriff,"
	next "erlaubt 1 Attacke."
	done

NeutralizingGasDescription:
	text "Hebt alle anderen"
	next "Fähigkeiten auf."
	done

QuickDrawDescription:
	text "Gelegentlich"
	next "Erstschlag."
	done

WindRiderDescription:
	text "Immun gegen"
	next "Wind-Attacken."
	done

SteelySpiritDescription:
	text "Verstärkt"
	next "Stahl-Attacken."
	done

PerishBodyDescription:
	text "Berührung löst Ab-"
	next "gesang aus."
	done

ScreenCleanerDescription:
	text "Hebt beim Einwech-"
	next "seln Barrieren auf."
	done

CudChewDescription:
	text "Verzehrt eine Beere"
	next "ein zweites Mal."
	done

SharpnessDescription:
	text "Verstärkt"
	next "Schnitt-Attacken."
	done

ArmorTailDescription:
	text "Verhindert Gegner-"
	next "Erstschläge."
	done

MindsEyeDescription:
	text "Umgeht Fluchtwert +"
	next "Geist-Immunität."
	done

MegaSolDescription:
	text "Attacken wie bei"
	next "gleißender Sonne."
	done
