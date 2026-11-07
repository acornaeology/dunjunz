; Constants
screen_end                = &8000  ; The top of screen memory
text_end                  = &ff  ; The byte that ends TITLE's text
osbyte_inkey              = &81
osbyte_flush_buffer_class = &0f

; Memory locations
copy_from             = &70
; &70 referenced 6 times by &38da, &38e4, &3909, &3913, &3918, &391c
copy_from_high        = &71
; &71 referenced 5 times by &38d6, &3905, &391e, &3922, &3931
copy_to               = &80
; &80 referenced 8 times by &38dc, &38e6, &38ef, &38f3, &390d, &3915, &3925, &3929
copy_to_high          = &81
; &81 referenced 7 times by &38e0, &38f5, &38f9, &38fd, &3911, &392b, &392f
mode5_screen          = &5800  ; The start of MODE 5's screen memory (&5800-&7FFF)
title_picture_screen  = &5940  ; Character row 1 of the MODE 5 screen, where the logo picture is copied (&5940-&633F)
crtc_address_register = &fe00
; &fe00 referenced 1 time by &3976
crtc_register_data    = &fe01
; &fe01 referenced 1 time by &397b
oswrch                = &ffee
; &ffee referenced 4 times by &38cb, &393c, &3959, &3969
osbyte                = &fff4
; &fff4 referenced 3 times by &394d, &3980, &3989


    org &3800

.dasmos_start
; ***************************************************************************************
; Background stripe pattern
;
; One MODE 5 character cell, copied over the whole screen: even pixel rows black (&00),
; odd rows four pixels of colour 2 (&F0), which mode_vdu makes blue.
.stripe_pattern
    equb &00, &f0, &00, &f0, &00, &f0, &00, &f0  ; Rows 0-7 of the cell, black and colour 2 alternately
; ***************************************************************************************
; VDU codes: MODE 5, colour 2 blue
;
; Eight bytes sent by title_start before anything is drawn: VDU 22,5 (MODE 5) and VDU
; 19,2,4,0,0,0 (logical colour 2 shows as blue).
.mode_vdu
    equb &16, &05                       ; VDU 22,5: MODE 5
    equb &13, &02, &04, &00, &00, &00   ; VDU 19,2,4,0,0,0: logical colour 2 is blue
; ***************************************************************************************
; VDU codes: credits, title and keys
;
; Printed by title_start up to the &FF terminator. The credits go at fixed text positions
; on the striped background; the title is printed in a text window cleared to black at
; columns 6-13, rows 10-12; the keys in a window cleared to white at columns 1-18, rows
; 18-24, in black text, as four lines of 18 characters.
; &3810 used as index base 2 times by &3939, &3940
.page_text
    equb &1f, &07, &0e                  ; VDU 31,7,14: text cursor to column 7, row 14
    equs "Author"                       ; ...
    equb &1f, &04, &10                  ; VDU 31,4,16: column 4, row 16
    equs "Julian  Avis"                 ; ...
    equb &1f, &02, &1e                  ; VDU 31,2,30: column 2, row 30
    equs "(c) Bugbyte 1986"             ; ...
    equb &1c, &06, &0c, &0d, &0a        ; VDU 28,6,12,13,10: text window, columns 6-13, rows 10-12
    equb &0c, &0a                       ; CLS (to black), then down to the window's middle row
    equs " DUNJUNZ"                     ; The title, filling the window's width
    equb &1c, &01, &18, &12, &12        ; VDU 28,1,24,18,18: text window, columns 1-18, rows 18-24
    equb &0c                            ; CLS
    equb &11, &83                       ; COLOUR 131: white text background
    equb &11, &00                       ; COLOUR 0: black text
    equb &0c, &0a                       ; CLS (to white), then down a row
    equs "                   f1 Pause On/Off    5 Sound On        6 Sound Off     "  ; The keys: a blank line, then f1, 5 and 6, a line each
    equb &ff                            ; Terminator
; ***************************************************************************************
; Text: a line of spaces
;
; Eighteen spaces and the &FF terminator, the width of the keys window. title_start
; prints them after the keys on any machine but an Electron; they fall on the window's
; next line, which is already white.
; &389f used as index base 2 times by &3956, &395d
.blank_line_text
    equs "                  "           ; One line of the keys window
    equb &ff                            ; Terminator
; ***************************************************************************************
; VDU codes: an empty black window
;
; Printed last: a text window at columns 2-17, rows 26-28, cleared to black with white
; text. TITLE prints nothing in it, and DUNK, which runs next, starts with MODE 7.
; &38b2 used as index base 2 times by &3966, &396d
.black_window_vdu
    equb &1c, &02, &1c, &11, &1a        ; VDU 28,2,28,17,26: text window, columns 2-17, rows 26-28
    equb &11, &80                       ; COLOUR 128: black text background
    equb &11, &03                       ; COLOUR 3: white text
    equb &0c                            ; CLS
    equb &ff                            ; Terminator
; ***************************************************************************************
; Unused command strings
;
; Two CR-terminated OSCLI commands, *TAPE and */, that nothing in TITLE refers to.
.tape_command
    equs "*TAPE"                        ; *TAPE
    equb &0d                            ; CR
.run_command
    equs "*/"                           ; */ (run a file whose name is not given)
    equb &0d                            ; CR
; ***************************************************************************************
; TITLE: draw the title page and wait for a key
;
; Entered by */TITLE from the BASIC program DUNJUNZ. Select MODE 5 with colour 2 blue,
; fill the screen with stripe_pattern, copy title_picture into character rows 1-8, print
; the credits, title and keys, open an empty black window at the bottom, hide the cursor,
; flush the keyboard buffer and wait up to 7.67 seconds for a key, then return to BASIC.
.title_start
    ldx #0                              ; Send the eight bytes of mode_vdu
; &38c8 referenced 1 time by &38d2
.send_mode_vdu
    lda mode_vdu,x                      ; ...
    jsr oswrch                          ; ...
    inx                                 ; ...
    txa                                 ; ...
    cmp #page_text - mode_vdu           ; ...
    bne send_mode_vdu                   ; ...
    lda #>(stripe_pattern)              ; Point copy_from at stripe_pattern and copy_to at mode5_screen
    sta copy_from_high                  ; ...
    lda #0                              ; Both low bytes are 0
    sta copy_from                       ; ...
    sta copy_to                         ; ...
    lda #>(mode5_screen)                ; ...
    sta copy_to_high                    ; ...
    ldy #0                              ; Start at the cell's first byte
; &38e4 referenced 2 times by &38ec, &3901
.fill_stripes
    lda (copy_from),y                   ; Copy the pattern's eight bytes into the next cell
    sta (copy_to),y                     ; ...
    iny                                 ; ...
    tya                                 ; ...
    cmp #8                              ; ...
    bne fill_stripes                    ; ...
    clc                                 ; copy_to += 8: on to the next cell
    lda copy_to                         ; ...
    adc #8                              ; ...
    sta copy_to                         ; ...
    lda copy_to_high                    ; ...
    adc #0                              ; ...
    sta copy_to_high                    ; ...
    ldy #0                              ; Back to the pattern's first byte
    lda copy_to_high                    ; Repeat until copy_to reaches &8000, the top of the screen
    cmp #>(screen_end)                  ; ...
    bne fill_stripes                    ; ...
    lda #>(title_picture)               ; copy_from = title_picture
    sta copy_from_high                  ; ...
    lda #0                              ; ...
    sta copy_from                       ; ...
    lda #<(title_picture_screen)        ; copy_to = title_picture_screen (Y stays 0 from here)
    sta copy_to                         ; ...
    lda #>(title_picture_screen)        ; ...
    sta copy_to_high                    ; ...
; &3913 referenced 1 time by &3935
.copy_picture
    lda (copy_from),y                   ; Copy one byte of the picture to the screen
    sta (copy_to),y                     ; ...
    clc                                 ; copy_from += 1
    lda copy_from                       ; ...
    adc #1                              ; ...
    sta copy_from                       ; ...
    lda copy_from_high                  ; ...
    adc #0                              ; ...
    sta copy_from_high                  ; ...
    clc                                 ; copy_to += 1
    lda copy_to                         ; ...
    adc #1                              ; ...
    sta copy_to                         ; ...
    lda copy_to_high                    ; ...
    adc #0                              ; ...
    sta copy_to_high                    ; ...
    lda copy_from_high                  ; Repeat until copy_from reaches the end of the file, &4400
    cmp #>(title_picture + &0a00)       ; ...
    bne copy_picture                    ; ...
    ldx #0                              ; Print page_text up to its &FF terminator
; &3939 referenced 1 time by &3945
.print_page_text
    lda page_text,x                     ; ...
    jsr oswrch                          ; ...
    inx                                 ; ...
    lda page_text,x                     ; ...
    cmp #text_end                       ; ...
    bne print_page_text                 ; ...
    lda #osbyte_inkey                   ; Read the machine type, INKEY(-256)
    ldx #0                              ; ...
    ldy #&ff                            ; ...
    jsr osbyte                          ; ...  Read the OS version (INKEY(-256))
    cpx #1                              ; 1 is an Electron: skip the line of spaces
    beq open_black_window               ; ...
    ldx #0                              ; Print blank_line_text up to its &FF terminator
; &3956 referenced 1 time by &3962
.print_blank_line
    lda blank_line_text,x               ; ...
    jsr oswrch                          ; ...
    inx                                 ; ...
    lda blank_line_text,x               ; ...
    cmp #text_end                       ; ...
    bne print_blank_line                ; ...
; &3964 referenced 1 time by &3952
.open_black_window
    ldx #0                              ; Print black_window_vdu up to its &FF terminator
; &3966 referenced 1 time by &3972
.print_black_window
    lda black_window_vdu,x              ; ...
    jsr oswrch                          ; ...
    inx                                 ; ...
    lda black_window_vdu,x              ; ...
    cmp #text_end                       ; ...
    bne print_black_window              ; ...
    lda #&0a                            ; 6845 register 10 (cursor start) = &20: no cursor
    sta crtc_address_register           ; ...
    lda #&20 ; ' '                      ; ...
    sta crtc_register_data              ; ...
    lda #osbyte_flush_buffer_class      ; Flush the keyboard buffer (X is &0B, non-zero, from the loop above)
    jsr osbyte                          ; ...  Flush selected class of buffer
    lda #osbyte_inkey                   ; Wait up to &2FF centiseconds (7.67 s) for a key
    ldx #&ff                            ; ...
    ldy #2                              ; ...
    jsr osbyte                          ; ...  Read a key, waiting up to 767 centiseconds
    rts                                 ; Return to BASIC, which chains DUNK
; ***************************************************************************************
; Unused
;
; Zeros up to the picture, which starts on a page boundary.
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00                  ; Zeros
; ***************************************************************************************
; The title picture
;
; Eight MODE 5 character rows (&A00 bytes, &140 a row, eight bytes a cell, top pixel row
; first), copied by title_start to character rows 1-8. A blue frame holds a white panel
; at the left, the name BUG BYTE in large white letters and a red and blue face at the
; right.
.title_picture
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00  ; Character row 1 (screen &5940)
    equb &f0, &f0, &f0, &f0, &80, &80, &80, &80
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &f0, &f0, &f0, &f0, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &03, &03, &03, &01, &00, &10
    equb &07, &0d, &38, &38, &78, &68, &d1, &b3
    equb &50, &78, &3c, &b4, &f0, &30, &dc, &ee
    equb &a0, &e1, &c3, &d2, &f0, &f0, &c0, &b3
    equb &0e, &0b, &c1, &c1, &e1, &e1, &70, &b8
    equb &00, &00, &0c, &0c, &0c, &08, &00, &80
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00  ; Character row 2 (screen &5A80)
    equb &b3, &b3, &b3, &b3, &b3, &b3, &b3, &b3
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &bb, &88, &88, &88, &88, &99, &88, &99
    equb &ff, &00, &00, &00, &00, &ff, &00, &ff
    equb &ff, &00, &00, &00, &00, &ee, &00, &ee
    equb &ff, &00, &00, &00, &00, &11, &00, &11
    equb &ff, &00, &00, &00, &00, &cc, &00, &cc
    equb &ff, &00, &00, &00, &00, &77, &00, &77
    equb &ff, &00, &00, &00, &00, &00, &00, &00
    equb &ff, &00, &00, &00, &00, &77, &00, &77
    equb &ff, &00, &00, &00, &00, &ee, &00, &ee
    equb &ff, &00, &00, &00, &00, &00, &00, &00
    equb &ff, &00, &00, &00, &00, &00, &00, &00
    equb &ff, &00, &00, &00, &00, &00, &00, &00
    equb &ff, &00, &00, &00, &00, &11, &00, &11
    equb &ff, &00, &00, &00, &00, &ff, &00, &ff
    equb &ff, &00, &00, &00, &00, &ee, &00, &ee
    equb &ff, &00, &00, &00, &00, &11, &00, &11
    equb &ff, &00, &00, &00, &00, &cc, &00, &cc
    equb &ff, &00, &00, &00, &00, &77, &00, &77
    equb &ff, &00, &00, &00, &00, &11, &00, &11
    equb &ff, &00, &00, &00, &00, &ff, &00, &ff
    equb &ff, &00, &00, &00, &00, &ff, &00, &ff
    equb &ff, &00, &00, &00, &00, &11, &00, &11
    equb &ff, &00, &00, &00, &00, &ff, &00, &ff
    equb &ff, &00, &00, &00, &00, &ff, &00, &ff
    equb &00, &00, &00, &00, &01, &03, &03, &03
    equb &00, &03, &07, &07, &07, &0f, &07, &06
    equb &10, &10, &30, &1c, &1c, &0e, &0e, &0f
    equb &a2, &d1, &b3, &a2, &a2, &a2, &b3, &d1
    equb &22, &cd, &67, &23, &ab, &23, &67, &cd
    equb &44, &3b, &6e, &4c, &5d, &4c, &6e, &3b
    equb &54, &b8, &dc, &54, &54, &54, &dc, &b8
    equb &80, &80, &c0, &83, &83, &07, &07, &0f
    equb &00, &0c, &0e, &0e, &0e, &0f, &0e, &06
    equb &00, &00, &00, &00, &08, &0c, &0c, &0c  ; Character row 3 (screen &5BC0)
    equb &b3, &b3, &b3, &b3, &b3, &b3, &b3, &b3
    equb &ff, &ff, &ff, &ff, &ff, &ff, &cc, &ff
    equb &ff, &ff, &ee, &fe, &00, &fc, &00, &fc
    equb &ff, &f8, &00, &f0, &00, &f0, &22, &e6
    equb &ff, &ff, &33, &f3, &00, &f1, &00, &f1
    equb &ff, &ff, &ff, &ff, &77, &ff, &33, &ff
    equb &88, &99, &88, &99, &88, &99, &88, &99
    equb &00, &cc, &00, &cc, &00, &cc, &00, &cc
    equb &00, &77, &00, &77, &00, &77, &00, &77
    equb &00, &11, &00, &11, &00, &11, &00, &11
    equb &00, &cc, &00, &cc, &00, &cc, &00, &cc
    equb &00, &77, &00, &77, &00, &77, &00, &77
    equb &00, &11, &00, &11, &00, &11, &00, &11
    equb &00, &cc, &00, &cc, &00, &cc, &00, &cc
    equb &00, &77, &00, &77, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &11, &00, &11, &00, &11, &00, &11
    equb &00, &cc, &00, &cc, &00, &cc, &00, &cc
    equb &00, &77, &00, &77, &00, &77, &00, &77
    equb &00, &11, &00, &11, &00, &11, &00, &11
    equb &00, &cc, &00, &cc, &00, &cc, &00, &cc
    equb &00, &77, &00, &77, &00, &77, &00, &77
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &33, &00, &33, &00, &33, &00, &33
    equb &00, &88, &00, &88, &00, &88, &00, &88
    equb &00, &11, &00, &11, &00, &11, &00, &11
    equb &00, &cc, &00, &cc, &00, &cc, &00, &cc
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &03, &01, &00, &03, &03, &03, &01, &00
    equb &06, &0b, &0f, &06, &0d, &0f, &03, &0b
    equb &0f, &07, &0a, &14, &38, &0e, &0e, &0f
    equb &e0, &f0, &f0, &f0, &f0, &e0, &e0, &60
    equb &cd, &03, &83, &07, &07, &0f, &0f, &0f
    equb &3b, &0c, &1c, &0e, &0e, &0f, &0f, &0f
    equb &70, &f0, &f0, &f0, &f0, &70, &70, &60
    equb &0f, &0e, &05, &82, &c1, &07, &07, &0f
    equb &06, &0d, &0f, &06, &0b, &0f, &0c, &0d
    equb &0c, &08, &00, &0c, &0c, &0c, &08, &00  ; Character row 4 (screen &5D00)
    equb &b3, &b3, &b3, &b3, &b3, &b3, &b3, &b3
    equb &00, &ff, &cc, &ff, &ff, &ff, &ff, &ff
    equb &00, &fc, &00, &fc, &00, &fe, &ee, &ff
    equb &22, &80, &00, &f0, &00, &f0, &00, &f8
    equb &00, &f1, &00, &f1, &00, &f3, &33, &ff
    equb &00, &ff, &33, &ff, &77, &ff, &ff, &ff
    equb &88, &99, &88, &99, &88, &99, &88, &99
    equb &00, &ff, &00, &cc, &00, &cc, &00, &cc
    equb &00, &ee, &00, &77, &00, &77, &00, &77
    equb &00, &11, &00, &11, &00, &11, &00, &11
    equb &00, &cc, &00, &cc, &00, &cc, &00, &cc
    equb &00, &77, &00, &77, &00, &77, &00, &77
    equb &00, &11, &00, &11, &00, &11, &00, &11
    equb &00, &cc, &00, &cc, &00, &cc, &00, &cc
    equb &00, &ff, &00, &77, &00, &77, &00, &77
    equb &00, &11, &00, &00, &00, &00, &00, &00
    equb &00, &ff, &00, &00, &00, &00, &00, &00
    equb &00, &ff, &00, &00, &00, &00, &00, &00
    equb &00, &11, &00, &11, &00, &11, &00, &11
    equb &00, &ff, &00, &cc, &00, &cc, &00, &cc
    equb &00, &ee, &00, &77, &00, &77, &00, &77
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &77, &00, &33, &00, &33, &00, &33
    equb &00, &ee, &00, &88, &00, &88, &00, &88
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &33, &00, &33, &00, &33, &00, &33
    equb &00, &88, &00, &88, &00, &88, &00, &88
    equb &00, &11, &00, &11, &00, &11, &00, &11
    equb &00, &ff, &00, &cc, &00, &cc, &00, &cc
    equb &00, &ee, &00, &00, &00, &00, &00, &00
    equb &01, &01, &01, &00, &00, &01, &01, &01
    equb &0f, &0b, &0b, &0d, &07, &0b, &0e, &0d
    equb &0f, &07, &07, &0b, &0d, &02, &1c, &0f
    equb &60, &68, &68, &68, &70, &f0, &f0, &80
    equb &0f, &0f, &0d, &0b, &07, &83, &c0, &f0
    equb &0f, &0f, &0b, &0d, &0e, &1c, &30, &f0
    equb &60, &61, &61, &61, &e0, &f0, &f0, &10
    equb &0f, &0e, &0e, &0d, &0b, &04, &83, &0f
    equb &0f, &0d, &0d, &0b, &0e, &0d, &07, &0b
    equb &08, &08, &08, &00, &00, &08, &08, &08  ; Character row 5 (screen &5E40)
    equb &b3, &b3, &b3, &b3, &b3, &b3, &b3, &b3
    equb &ff, &88, &aa, &88, &aa, &aa, &aa, &ff
    equb &ff, &88, &aa, &99, &aa, &aa, &aa, &ff
    equb &ff, &88, &bb, &bb, &aa, &aa, &88, &ff
    equb &ff, &aa, &aa, &aa, &aa, &aa, &88, &ff
    equb &ff, &88, &bb, &88, &ee, &ee, &88, &ff
    equb &88, &99, &88, &99, &88, &99, &88, &88
    equb &00, &cc, &00, &ff, &00, &ff, &00, &00
    equb &00, &77, &00, &ee, &00, &ee, &00, &00
    equb &00, &11, &00, &00, &00, &00, &00, &00
    equb &00, &cc, &00, &77, &00, &77, &00, &00
    equb &00, &77, &00, &ee, &00, &ee, &00, &00
    equb &00, &11, &00, &00, &00, &00, &00, &00
    equb &00, &cc, &00, &77, &00, &77, &00, &00
    equb &00, &77, &00, &ee, &00, &ee, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &11, &00, &11, &00, &11, &00, &00
    equb &00, &cc, &00, &ff, &00, &ff, &00, &00
    equb &00, &77, &00, &ee, &00, &ee, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &33, &00, &33, &00, &33, &00, &00
    equb &00, &88, &00, &88, &00, &88, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &33, &00, &33, &00, &33, &00, &00
    equb &00, &88, &00, &88, &00, &88, &00, &00
    equb &00, &11, &00, &11, &00, &11, &00, &00
    equb &00, &cc, &00, &ff, &00, &ff, &00, &00
    equb &00, &00, &00, &ff, &00, &ff, &00, &00
    equb &00, &00, &00, &01, &01, &00, &00, &00
    equb &0d, &00, &0b, &0f, &0d, &0b, &07, &0f
    equb &0f, &0f, &07, &07, &0b, &0d, &0f, &0f
    equb &b3, &2a, &48, &0c, &2c, &3c, &78, &f0
    equb &70, &88, &ff, &aa, &22, &00, &00, &80
    equb &e0, &11, &ff, &55, &44, &00, &00, &10
    equb &dc, &45, &21, &03, &43, &c3, &e1, &f0
    equb &0f, &0f, &0e, &0e, &0d, &0b, &0f, &0f
    equb &0b, &00, &0d, &0f, &0b, &0d, &0e, &0f
    equb &00, &00, &00, &08, &08, &00, &00, &00  ; Character row 6 (screen &5F80)
    equb &80, &80, &80, &80, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &f0, &f0, &f0, &f0
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &0f, &0c, &00, &00, &00, &00, &00, &00
    equb &07, &03, &10, &00, &00, &00, &00, &00
    equb &f0, &f0, &70, &70, &70, &50, &10, &10
    equb &80, &80, &c0, &c0, &f0, &f0, &f0, &70
    equb &10, &10, &30, &30, &f0, &f0, &f0, &e0
    equb &f0, &f0, &e0, &e0, &e0, &a0, &80, &80
    equb &0e, &0c, &80, &00, &00, &00, &00, &00
    equb &0f, &03, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00  ; Character row 7 (screen &60C0)
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00  ; Character row 8 (screen &6200)
.dasmos_end

save "TITLE", dasmos_start, dasmos_end, &38c6, &3800

; Label references by decreasing frequency:
;     copy_to:                8
;     copy_to_high:           7
;     copy_from:              6
;     copy_from_high:         5
;     oswrch:                 4
;     osbyte:                 3
;     black_window_vdu:       2
;     blank_line_text:        2
;     fill_stripes:           2
;     page_text:              2
;     copy_picture:           1
;     crtc_address_register:  1
;     crtc_register_data:     1
;     open_black_window:      1
;     print_black_window:     1
;     print_blank_line:       1
;     print_page_text:        1
;     send_mode_vdu:          1

; Stats:
;     Total size (Code + Data) = 3072 bytes
;     Code                     = 199 bytes (6%)
;     Data                     = 2873 bytes (94%)
;
;     Number of instructions   = 97
;     Number of data bytes     = 2734 bytes
;     Number of data words     = 0 bytes
;     Number of string bytes   = 139 bytes
;     Number of strings        = 8
