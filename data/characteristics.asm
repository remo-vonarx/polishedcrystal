Characteristics:
	table_width 2
	dw .Chara_HP0
	dw .Chara_HP1
	dw .Chara_HP2
	dw .Chara_HP3
	dw .Chara_HP4
	dw .Chara_Atk0
	dw .Chara_Atk1
	dw .Chara_Atk2
	dw .Chara_Atk3
	dw .Chara_Atk4
	dw .Chara_Def0
	dw .Chara_Def1
	dw .Chara_Def2
	dw .Chara_Def3
	dw .Chara_Def4
	dw .Chara_SAt0
	dw .Chara_SAt1
	dw .Chara_SAt2
	dw .Chara_SAt3
	dw .Chara_SAt4
	dw .Chara_SDf0
	dw .Chara_SDf1
	dw .Chara_SDf2
	dw .Chara_SDf3
	dw .Chara_SDf4
	dw .Chara_Spe0
	dw .Chara_Spe1
	dw .Chara_Spe2
	dw .Chara_Spe3
	dw .Chara_Spe4
	assert_table_length NUM_STATS * 5

.Chara_HP0:
	text  "Liebt es"
	next1 "zu essen"
	done
.Chara_HP1:
	text  "Nickt oft"
	next1 "ein"
	done
.Chara_HP2:
	text  "Schläft"
	next1 "gern"
	done
.Chara_HP3:
	text  "Macht oft"
	next1 "Unordnung"
	done
.Chara_HP4:
	text  "Mag es,"
	next1 "sich zu"
	next1 "entspannen"
	done

.Chara_Atk0:
	text  "Ist stolz"
	next1 "auf seine"
	next1 "Stärke"
	done
.Chara_Atk1:
	text  "Prügelt"
	next1 "sich gern"
	done
.Chara_Atk2:
	text  "Besitzt"
	next1 "Temperament"
	done
.Chara_Atk3:
	text  "Liebt"
	next1 "Kämpfe"
	done
.Chara_Atk4:
	text  "Ist"
	next1 "impulsiv"
	done

.Chara_Def0:
	text  "Hat einen"
	next1 "robusten"
	next1 "Körper"
	done
.Chara_Def1:
	text  "Kann"
	next1 "Treffer gut"
	next1 "verkraften"
	done
.Chara_Def2:
	text  "Ist äußerst"
	next1 "zäh"
	done
.Chara_Def3:
	text  "Hat eine"
	next1 "gute"
	next1 "Ausdauer"
	done
.Chara_Def4:
	text  "Ist"
	next1 "beharrlich"
	done

.Chara_SAt0:
	text  "Ist sehr"
	next1 "neugierig"
	done
.Chara_SAt1:
	text  "Ist"
	next1 "hinter-"
	next1 "hältig"
	done
.Chara_SAt2:
	text  "Ist äußerst"
	next1 "gerissen"
	done
.Chara_SAt3:
	text  "Ist oft in"
	next1 "Gedanken"
	done
.Chara_SAt4:
	text  "Ist sehr"
	next1 "pedantisch"
	done

.Chara_SDf0:
	text  "Besitzt"
	next1 "einen star-"
	next1 "ken Willen"
	done
.Chara_SDf1:
	text  "Ist etwas"
	next1 "eitel"
	done
.Chara_SDf2:
	text  "Ist sehr"
	next1 "aufsässig"
	done
.Chara_SDf3:
	text  "Hasst"
	next1 "Niederlagen"
	done
.Chara_SDf4:
	text  "Ist"
	next1 "dickköpfig"
	done

.Chara_Spe0:
	text  "Ist gerne"
	next1 "schnell"
	next1 "unterwegs"
	done
.Chara_Spe1:
	text  "Achtet auf"
	next1 "Geräusche"
	done
.Chara_Spe2:
	text  "Ist unge-"
	next1 "stüm und"
	next1 "einfältig"
	done
.Chara_Spe3:
	text  "Ist ein"
	next1 "bisschen"
	next1 "albern"
	done
.Chara_Spe4:
	text  "Flüchtet"
	next1 "schnell"
	done
