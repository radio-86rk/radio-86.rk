;  #############################################################################
;  ##  «¿—“¿¬ ¿  ŒÃœ‹ﬁ“≈–¿ –¿ƒ»Œ-86–  »« ∆”–Õ¿À¿ "–¿ƒ»Œ" π6 1986 „Ó‰‡         ##
;  #############################################################################
;
;  Author:  Vitaliy Poedinok aka Vital72
;  License: MIT
;  www:     http://www.86rk.ru/
;  e-mail:  vital72@86rk.ru
;  Version: 1.1
; ==============================================================================

COLD_START	EQU	0F800h
IN_CHAR		EQU	0F803h
OUT_CHAR	EQU	0F809h
OUT_STR		EQU	0F818h

SCR_DOTS	EQU	1
SCR_LINE	EQU	2
SCR_TXT		EQU	3
SCR_NEXT	EQU	0FFh

; ==============================================================================

	.org	0

	jmp	start

starts_y:
	db	1
dot_char:
	db	17h
line_char:
	db	03h

start:
	mvi	c, 1Fh		;  cls
	call	OUT_CHAR
	lxi	h, screen
	lda	starts_y
	adi	' '
	mov	b, a

out_screen_loop:
	inr	b
	mov	a, m
	inx	h
	cpi	SCR_DOTS
	jz	out_screen_dots
	cpi	SCR_LINE
	jz	out_screen_line
	cpi	SCR_TXT
	jz	out_screen_txt
	cpi	SCR_NEXT
	jz	out_screen_loop
	xra	a
	mov	b, a
	call	gotoxy

	call	IN_CHAR
	jmp	COLD_START

out_screen_dots:
	mov	e, m
	inx	h
	mov	d, m
	inx	h
out_screen_dots_loop:
	ldax	d
	inx	d
	ana	a
	jz	out_screen_loop
	call	gotoxy
	lda	dot_char
	mov	c, a
	call	OUT_CHAR
	jmp	out_screen_dots_loop

out_screen_line:
	mov	a, m		;  pos X
	inx	h
	mov	d, m		;  count
	inx	h
	call	gotoxy
	lda	line_char
	mov	c, a		;  char
	call	OUT_CHAR
	dcr	d
	jnz	$-4
	jmp	out_screen_loop

out_screen_txt:
	mov	a, m		;  pos X
	inx	h
	call	gotoxy
	mov	e, m
	inx	h
	mov	d, m
	inx	h
	xchg
	call	OUT_STR
	xchg
	jmp	out_screen_loop

gotoxy:
	adi	' '
	mvi	c, 1Bh
	call	OUT_CHAR
	mvi	c, 'Y'
	call	OUT_CHAR
	mov	c, b
	call	OUT_CHAR
	mov	c, a
	jmp	OUT_CHAR

; ==============================================================================

row1:
	db	8, 9, 10, 11, 16, 17, 18, 23, 24, 25, 28, 32, 35, 36, 37, 45, 46
	db	47, 51, 52, 53, 0
row2:
	db	8, 12, 15, 18, 22, 25, 28, 32, 34, 38, 44, 48, 50, 0
row3:
	db	8, 12, 14, 18, 21, 25, 28, 31, 32, 34, 38, 45, 46, 47, 50, 51
	db	52, 53, 0
row4:
	db	8, 9, 10, 11, 14, 15, 16, 17, 18, 21, 25, 28, 30, 32, 34, 38, 41
	db	42, 44, 48, 50, 54, 0
row5:
	db	8, 14, 18, 21, 25, 28, 29, 32, 34, 38, 44, 48, 50, 54, 0
row6:
	db	8, 14, 18, 20, 21, 22, 23, 24, 25, 26, 28, 32, 35, 36, 37, 45
	db	46, 47, 51, 52, 53, 0

txt1:
	db	"personalxnyj kompx`ter radiol`bitelq", 0
txt2:
	db	"mikroprocessor ......... kr580ik80a", 0
txt3:
	db	"ob'em ozu .............. 16 (32) kbajt", 0
txt4:
	db	"ob'em pzu .............. 2 kbajt", 0
txt5:
	db	"programmnoe obespe~enie:", 0
txt6:
	db	"- monitor", 0
txt7:
	db	"- interpretator bejsika", 0
txt8:
	db	"- redaktor teksta", 0
txt9:
	db	"- assembler", 0

screen:
	db	SCR_DOTS
	dw	row1
	db	SCR_DOTS
	dw	row2
	db	SCR_DOTS
	dw	row3
	db	SCR_DOTS
	dw	row4
	db	SCR_DOTS
	dw	row5
	db	SCR_DOTS
	dw	row6
	db	SCR_NEXT
	db	SCR_LINE, 1, 61
	db	SCR_TXT, 11
	dw	txt1
	db	SCR_NEXT
	db	SCR_TXT, 11
	dw	txt2
	db	SCR_TXT, 11
	dw	txt3
	db	SCR_TXT, 11
	dw	txt4
	db	SCR_TXT, 11
	dw	txt5
	db	SCR_TXT, 16
	dw	txt6
	db	SCR_TXT, 16
	dw	txt7
	db	SCR_TXT, 16
	dw	txt8
	db	SCR_TXT, 16
	dw	txt9
	db	SCR_NEXT
	db	SCR_LINE, 1, 61
	db	0

;  =============================================================================
;  end of file  ================================================================
