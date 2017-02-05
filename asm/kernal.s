.include "atari2600.inc"
.include "zeropage.inc"
.include "sync.inc"

.export _kernal

COLOR = tmp1			; Use zero page

_kernal:
	;; Color is passed in A register
	sta COLOR
	jsr _wait_vblank

	lda COLOR
	sta COLUBK
	rts
