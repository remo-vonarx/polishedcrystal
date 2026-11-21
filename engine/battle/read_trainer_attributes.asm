GetOTName:
	ld de, wOTPlayerName
	ld a, [wLinkMode]
	and a
	jr nz, .got_name
	call GetTrainerClassName
	ld a, [wInBattleTowerBattle]
	and a
	call nz, GetBattleTowerShortClassName
.got_name
	ld h, d
	ld l, e
	ld bc, TRAINER_CLASS_NAME_LENGTH
	ld de, wOTClassName
	push de
	rst CopyBytes
	pop de
	ret

GetBattleTowerShortClassName:
; If the Battle Tower has a short name for [wTrainerClass], return it in de;
; otherwise keep de.
	ld a, [wTrainerClass]
	ld b, a
	ld hl, BattleTowerShortClassNames
.loop
	ld a, [hli]
	cp -1
	ret z
	cp b
	jr z, .found
.skip
	ld a, [hli]
	cp '@'
	jr nz, .skip
	jr .loop

.found
	ld d, h
	ld e, l
	ret

GetTrainerAttributes:
	ld a, [wTrainerClass]
	ld [wNamedObjectIndex], a
	call GetOTName
	ld a, [wTrainerClass]
	dec a
	ld hl, TrainerClassAttributes + TRNATTR_ITEM1
	ld bc, NUM_TRAINER_ATTRIBUTES
	rst AddNTimes
	ld de, wEnemyTrainerItem1
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld a, [hl]
	ld [wEnemyTrainerBaseReward], a
	ret

ComputeTrainerReward:
	ld hl, hProduct
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld a, [wEnemyTrainerBaseReward]
	ld [hli], a
	ld a, [wCurPartyLevel]
	ld [hl], a
	farcall Multiply
	ld hl, wBattleReward
	xor a
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	ret

INCLUDE "data/trainers/attributes.asm"
INCLUDE "data/battle_tower/short_class_names.asm"
