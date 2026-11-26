NonTrainerCallerNames:
; entries correspond to PHONECONTACT_* constants (see constants/trainer_constants.asm)
	table_width 2
	dw EmptyString
	dw .mom
	dw .bikeshop
	dw .bill
	dw .elm
	dw .lyra
	dw .buena
	assert_table_length NUM_NONTRAINER_PHONECONTACTS + 1

.mom:
	text  "Mama:"
	done
.bill:
	text  "Bill:"
	next1 "   #maniac"
	done
.elm:
	text  "Prof. Lind:"
	next1 "   #mon-Prof."
	done
.bikeshop:
	text  "Fahrradladen:"
	done
.lyra:
	text  "Lyra:"
	next1 "   <PK><MN>-Trainerin"
	done
.buena:
	text  "Buena:"
	next1 "   Disc Jockey"
	done
