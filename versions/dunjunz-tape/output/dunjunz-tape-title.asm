; Constants
screen_end   = &8000  ; The top of screen memory
text_end     = &ff  ; The byte that ends TITLE's text
osbyte_inkey = &81

; Memory locations
copy_from            = &70  ; Source pointer, low byte: stripe_pattern while striping, then the next byte of title_picture.
; &70 referenced 6 times by &28da, &28e4, &2909, &2913, &2918, &291c
copy_from_high       = &71  ; Source pointer, high byte.
; &71 referenced 5 times by &28d6, &2905, &291e, &2922, &2931
copy_to              = &80  ; Screen pointer, low byte: the next character cell while striping, then the next screen byte of the picture.
; &80 referenced 8 times by &28dc, &28e6, &28ef, &28f3, &290d, &2915, &2925, &2929
copy_to_high         = &81  ; Screen pointer, high byte.
; &81 referenced 7 times by &28e0, &28f5, &28f9, &28fd, &2911, &292b, &292f
mode5_screen         = &5800  ; The start of MODE 5's screen memory (&5800-&7FFF)
title_picture_screen = &5940  ; Character row 1 of the MODE 5 screen, where the logo picture is copied (&5940-&633F)
oswrch               = &ffee
; &ffee referenced 4 times by &28cb, &293c, &2959, &2969
osbyte               = &fff4
; &fff4 referenced 1 time by &294d
oscli                = &fff7
; &fff7 referenced 2 times by &2978, &297f


    org &2800

.dasmos_start
; ***************************************************************************************
; Background stripe pattern
;
; TITLE is the title page the cassette shows between its intro and the game: PLOAD runs
; it with */, the next file on the tape, and it ends by running the next file after it,
; DUNK. Its data comes first and the code, title_start (&28C6), after it; title_start's
; banner describes the run. This first table is one MODE 5 character cell, copied over
; the whole screen: even pixel rows black (&00), odd rows four pixels of colour 2 (&F0),
; which mode_vdu makes blue.
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
; columns 6-13, rows 10-12; a note to see the inlay card in a window cleared to white at
; columns 1-18, rows 18-24, in black text, as four lines of 18 characters.
; &2810 used as index base 2 times by &2939, &2940
.page_text
    equb &1f, &07, &0e                  ; VDU 31,7,14: text cursor to column 7, row 14
    equs "Author"                       ; The author credit's heading
    equb &1f, &04, &10                  ; VDU 31,4,16: column 4, row 16
    equs "Julian  Avis"                 ; The author's name
    equb &1f, &02, &1e                  ; VDU 31,2,30: column 2, row 30
    equs "(c) Bugbyte 1986"             ; The copyright line
    equb &1c, &06, &0c, &0d, &0a        ; VDU 28,6,12,13,10: text window, columns 6-13, rows 10-12
    equb &0c, &0a                       ; CLS (to black), then down to the window's middle row
    equs " DUNJUNZ"                     ; The title, filling the window's width
    equb &1c, &01, &18, &12, &12        ; VDU 28,1,24,18,18: text window, columns 1-18, rows 18-24
    equb &0c                            ; CLS
    equb &11, &83                       ; COLOUR 131: white text background
    equb &11, &00                       ; COLOUR 0: black text
    equb &0c, &0a                       ; CLS (to white), then down a row
    equs "  See Inlay Card         For         Play instructions     and Keys     "  ; "See Inlay Card For Play instructions and Keys", four lines of 18
    equb &ff                            ; Terminator
; ***************************************************************************************
; Text: a line of spaces
;
; Eighteen spaces and the &FF terminator, the width of the white window. title_start
; prints them after its text on any machine but an Electron; they fall on the window's
; next line, which is already white.
; &289f used as index base 2 times by &2956, &295d
.blank_line_text
    equs "                  "           ; One line of the keys window
    equb &ff                            ; Terminator
; ***************************************************************************************
; VDU codes: an empty black window
;
; Printed last: a text window at columns 2-17, rows 26-28, cleared to black with white
; text. TITLE prints nothing in it, and the loader that runs next, Dunjunz1, selects MODE
; 2.
; &28b2 used as index base 2 times by &2966, &296d
.black_window_vdu
    equb &1c, &02, &1c, &11, &1a        ; VDU 28,2,28,17,26: text window, columns 2-17, rows 26-28
    equb &11, &80                       ; COLOUR 128: black text background
    equb &11, &03                       ; COLOUR 3: white text
    equb &0c                            ; CLS
    equb &ff                            ; Terminator
; ***************************************************************************************
; Commands: select the cassette and run the next file
;
; Two CR-terminated OSCLI commands, *TAPE and */, that title_start issues at the end. */
; with no name runs the next file on the tape, DUNK.
.tape_command
    equs "*TAPE"                        ; *TAPE
    equb &0d                            ; CR
.run_command
    equs "*/"                           ; */ (run a file whose name is not given)
    equb &0d                            ; CR
; ***************************************************************************************
; TITLE: draw the title page and wait for a key
;
; The title page between the intro and the game. PLOAD runs it with */, the next file on
; the tape; the file's execution address is title_entry, two instructions into the loop
; that sends mode_vdu, not this LDX #0 (see title_entry). The run is a straight line in
; four phases, marked by block comments below. Screen: MODE 5 with colour 2 blue, then
; stripe_pattern copied into every character cell from &5800 to &7FFF. Picture:
; title_picture, &A00 bytes, copied a byte at a time over character rows 1-8. Text:
; page_text (the credits, the title in a black window and a white window of text), then
; blank_line_text unless INKEY(-256) reports an Electron, then black_window_vdu. End:
; *TAPE, then */ runs the next file on the tape, DUNK, whose loader brings in the rest of
; the game and does not return.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
.title_start
    ldx #0                              ; Send the eight bytes of mode_vdu
; &28c8 referenced 1 time by &28d2
.send_mode_vdu
    lda mode_vdu,x                      ; Next byte of the MODE 5 and palette set-up...
    jsr oswrch                          ; ...to the VDU drivers
; The file's execution address, where */ enters TITLE: the INX of the loop that sends mode_vdu, two instructions after title_start's LDX #0. So the loop starts from whatever X the MOS enters with, plus one, and sends the mode_vdu bytes from there until X reaches 8.
.title_entry
    inx                                 ; ...on to the next
    txa                                 ; ...count into A for the test
    cmp #page_text - mode_vdu           ; ...all eight sent?
    bne send_mode_vdu                   ; No: send the next
; Screen, with MODE 5 set: stripe all of it, &5800-&7FFF, one character cell at a time.
    lda #>(stripe_pattern)              ; Point copy_from at stripe_pattern and copy_to at mode5_screen
    sta copy_from_high                  ; ...copy_from's high byte
    lda #0                              ; Both low bytes are 0
    sta copy_from                       ; ...copy_from's low byte
    sta copy_to                         ; ...copy_to's low byte
    lda #>(mode5_screen)                ; ...the MODE 5 screen's page...
    sta copy_to_high                    ; ...as copy_to's high byte
    ldy #0                              ; Start at the cell's first byte
; &28e4 referenced 2 times by &28ec, &2901
.fill_stripes
    lda (copy_from),y                   ; Copy the pattern's eight bytes into the next cell
    sta (copy_to),y                     ; ...stripes on alternate pixel rows
    iny                                 ; ...next byte of the cell
    tya                                 ; ...count into A for the test
    cmp #8                              ; ...all eight rows of the cell?
    bne fill_stripes                    ; No: copy the next row
    clc                                 ; copy_to += 8: on to the next cell
    lda copy_to                         ; ...copy_to's low byte...
    adc #8                              ; ...plus 8: one character cell
    sta copy_to                         ; ...the cell to the right, or the next row's first
    lda copy_to_high                    ; ...then copy_to's page...
    adc #0                              ; ...with the carry
    sta copy_to_high                    ; ...completing the next cell's address
    ldy #0                              ; Back to the pattern's first byte
    lda copy_to_high                    ; Repeat until copy_to reaches &8000, the top of the screen
    cmp #>(screen_end)                  ; ...at the top of screen memory?
    bne fill_stripes                    ; No: stripe the next cell
; Copy the logo picture, a byte at a time, over character rows 1-8.
    lda #>(title_picture)               ; copy_from = title_picture, at &2A00...
    sta copy_from_high                  ; ...as copy_from's high byte
    lda #0                              ; ...which is page-aligned...
    sta copy_from                       ; ...so copy_from's low byte is 0
    lda #<(title_picture_screen)        ; copy_to = title_picture_screen (Y stays 0 from here)
    sta copy_to                         ; ...low byte: character row 1, below a striped row
    lda #>(title_picture_screen)        ; ...then the page of &5940...
    sta copy_to_high                    ; ...as copy_to's high byte
; &2913 referenced 1 time by &2935
.copy_picture
    lda (copy_from),y                   ; Copy one byte of the picture to the screen
    sta (copy_to),y                     ; ...over the stripes
    clc                                 ; Advance copy_from to the picture's next byte...
    lda copy_from                       ; ...copy_from's low byte...
    adc #1                              ; ...plus one, carry into the page
    sta copy_from                       ; ...the picture's next byte
    lda copy_from_high                  ; ...then copy_from's page...
    adc #0                              ; ...with the carry
    sta copy_from_high                  ; ...crossing into its next page
    clc                                 ; Advance copy_to to the screen's next byte...
    lda copy_to                         ; ...copy_to's low byte...
    adc #1                              ; ...plus one, carry into the page
    sta copy_to                         ; ...the screen's next byte
    lda copy_to_high                    ; ...then copy_to's page...
    adc #0                              ; ...with the carry
    sta copy_to_high                    ; ...completing the next screen address
    lda copy_from_high                  ; Repeat until copy_from reaches the end of the file, &3400
    cmp #>(title_picture + &0a00)       ; ...past the picture's last page?
    bne copy_picture                    ; No: copy the next byte
; Print the credits, the title and the white window's text, then (except on an Electron) a line of spaces, then open the black window.
    ldx #0                              ; Print page_text up to its &FF terminator
; &2939 referenced 1 time by &2945
.print_page_text
    lda page_text,x                     ; ...this byte of the credits, title and text...
    jsr oswrch                          ; ...printed or obeyed as VDU codes
    inx                                 ; ...on to the next
    lda page_text,x                     ; ...look at it...
    cmp #text_end                       ; ...is it the terminator?
    bne print_page_text                 ; No: print it
    lda #osbyte_inkey                   ; Read the machine type, INKEY(-256)
    ldx #0                              ; ...X = 0 and Y = &FF ask for the machine type...
    ldy #&ff                            ; ...rather than a key
    jsr osbyte                          ; ...X = 1 on an Electron  Read the OS version (INKEY(-256))
    cpx #1                              ; 1: an Electron?
    beq open_black_window               ; Yes: leave out the line of spaces
    ldx #0                              ; Print blank_line_text up to its &FF terminator
; &2956 referenced 1 time by &2962
.print_blank_line
    lda blank_line_text,x               ; ...this byte of the line...
    jsr oswrch                          ; ...printed: a space
    inx                                 ; ...on to the next
    lda blank_line_text,x               ; ...look at it...
    cmp #text_end                       ; ...is it the terminator?
    bne print_blank_line                ; No: print it
; &2964 referenced 1 time by &2952
.open_black_window
    ldx #0                              ; Print black_window_vdu up to its &FF terminator
; &2966 referenced 1 time by &2972
.print_black_window
    lda black_window_vdu,x              ; ...this byte of the window set-up...
    jsr oswrch                          ; ...obeyed as VDU codes
    inx                                 ; ...on to the next
    lda black_window_vdu,x              ; ...look at it...
    cmp #text_end                       ; ...is it the terminator?
    bne print_black_window              ; No: send it
; Select the cassette filing system and run the next file, DUNK.
    ldx #<(tape_command)                ; *TAPE: the cassette filing system...
    ldy #>(tape_command)                ; ...the command's high byte...
    jsr oscli                           ; ...through OSCLI
    ldx #<(run_command)                 ; */: run the next file on the tape...
    ldy #>(run_command)                 ; ...the command's high byte...
    jsr oscli                           ; ...DUNK, which loads the rest of the game; it does not return
    rts                                 ; Not reached: DUNK's loader never returns
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
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00  ; Zeros
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

save "TITLE", dasmos_start, dasmos_end, &28ce, &2800

; Label references by decreasing frequency:
;     copy_to:             8
;     copy_to_high:        7
;     copy_from:           6
;     copy_from_high:      5
;     oswrch:              4
;     black_window_vdu:    2
;     blank_line_text:     2
;     fill_stripes:        2
;     oscli:               2
;     page_text:           2
;     copy_picture:        1
;     open_black_window:   1
;     osbyte:              1
;     print_black_window:  1
;     print_blank_line:    1
;     print_page_text:     1
;     send_mode_vdu:       1

; Stats:
;     Total size (Code + Data) = 3072 bytes
;     Code                     = 189 bytes (6%)
;     Data                     = 2883 bytes (94%)
;
;     Number of instructions   = 93
;     Number of data bytes     = 2744 bytes
;     Number of data words     = 0 bytes
;     Number of string bytes   = 139 bytes
;     Number of strings        = 8
