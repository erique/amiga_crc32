; SPDX-License-Identifier: MIT

	xdef _crc32_asm

POLYNOMIAL equ $db710641	; CRC-32/ISO-HDLC, CRC-32-IEEE

	; a0 = buffer
	; d0 = length
	; return d0 = crc32

_crc32_asm:
    move.l	d2,a1			; save d2

	subq.l	#1,d0			; dbf loop adjust
	bmi.b	.zerolen		; skip if zero length

	moveq.l	#-1,d1			; initial crc32
	bra.b	.wloop

.lloop
	swap	d0

.wloop
	move.b	(a0)+,d2
	eor.b	d2,d1			; crc ^= (*data++)

	moveq.l	#8-1,d2
.bloop
	btst	#0,d1			; & 0x00000001
	beq.b	.notset
	eor.l	#POLYNOMIAL,d1
	bset	#0,d1
.notset
	ror.l	#1,d1
	dbf		d2,.bloop

	dbf		d0,.wloop
	swap	d0
	dbf		d0,.lloop

	move.l	d1,d0

.zerolen:
	not.l	d0				; ~crc
	move.l	a1,d2			; restore d2
	rts
