.include "atari2600.inc"

.export _wait_overscan
.export _wait_vblank

;; PAL Timings
VBLANK_LINES = 34	; Exculding VSYNC
KERNAL_LINES = 248
OVERSCAN_LINES = 30
;; Total of 312 lines / Frame

;; General numbers
SCANLINE_CYCLES = 76
VBLANK_CYCLES = VBLANK_LINES * SCANLINE_CYCLES
KERNAL_CYCLES = KERNAL_LINES * SCANLINE_CYCLES
OVERSCAN_CYCLES = OVERSCAN_LINES * SCANLINE_CYCLES

;; Specific timing counters (manually tuned)
VBLANK_COUNTER = (VBLANK_CYCLES-SCANLINE_CYCLES)/64 - 1
OVERSCAN_COUNTER = (KERNAL_CYCLES+OVERSCAN_CYCLES) / 1024
END_OVERSCAN_COUNTER = (6*SCANLINE_CYCLES)/64 - 1

.proc _wait_overscan
lwait:
	lda TIMINT
	beq lwait
	;; Around end of line 302 (Scan cycle 52)
	sta WSYNC ;; Start of line 303

	lda #END_OVERSCAN_COUNTER
	sta TIM64T
	lda #$02
	sta WSYNC
	sta VBLANK ;; Turn off beam
	;; Do some bookkeeping there
	;; 5-6 lines i.e 400 cycles lost

endos:	lda TIMINT
	beq endos
	;; Around start of line 308 (Scan cycle 13)
	sta WSYNC

	;; Starting line 309
	lda #$02
	sta VSYNC
	sta WSYNC
	sta WSYNC
	sta WSYNC
	lda #$00
	sta VSYNC
	;; Starting line 0

	;; Stop 2 line before end of vblank
	lda #VBLANK_COUNTER
	sta TIM64T

	;; Would typically update music during vblank
	rts
.endproc

.proc _wait_vblank
lwait:
	lda TIMINT
	beq lwait
	;; Around beginning of line 32 (scan cycle 17)
	;; Turn on beam
	lda #$00
	sta WSYNC ;; Start of line 33
	sta VBLANK
	;; Stop near the end of Overscan
	lda #OVERSCAN_COUNTER
	sta T1024T
	rts
.endproc
