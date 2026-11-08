; Memory locations
filev                 = &0212
; &0212 referenced 1 time by &20d3
dunjunz4_start        = &08c0  ; Where Dunjunz4, the game's &08C0-&1FFF, loads.
load_core             = &0d00  ; In Dunjunz4: loads Dunjunz5 to &2000, over this loader, and falls into game_entry (&0D31).
osfile_block          = &2170  ; The OSFILE control block that load_file passes to FILEV's routine, just past the end of the file: bytes 0-1 the filename's address, bytes 2-5 the load address. Byte 6, the exec address's low byte, is never set; whatever it holds, each file loads at the load address given here or, if the byte is not 0, at its own, which is the same.
osfile_load_addr      = &2172  ; Bytes 2-5 of osfile_block: the load address.
osfile_load_addr_high = &2174  ; Bytes 4-5 of osfile_block: the load address's top half, 0.
loading_screen        = &3280  ; Where Dunjunz2, the MODE 2 loading screen, loads.
dunjunz3_start        = &6e80  ; Where Dunjunz3, the game's &6E80-&7FFF, loads.
oswrch                = &ffee
; &ffee referenced 46 times by &200d, &2012, &2017, &201c, &2021, &2026, &202b, &202e, &2031, &2034, &2037, &203a, &203d, &2042, &2047, &204c, &2051, &2056, &2059, &205c, &205f, &2062, &2065, &206c, &2070, &2075, &2078, &207b, &207e, &2086, &208b, &2090, &2095, &2098, &209b, &20a0, &20a5, &20aa, &20af, &20b4, &20b9, &20be, &20fe, &2103, &2108, &210d
osbyte                = &fff4
; &fff4 referenced 1 time by &2008


    org &2000

.dasmos_start
; ***************************************************************************************
; Prepare the screen and load the game
;
; Entered from DUNK's loader at &0740, which loads this file to &2000 and jumps here. It
; does *FX 200,3 (clear memory on BREAK), selects MODE 2 with the cursor off and the 6845
; showing 25 character rows, as in play, and makes logical colours 1-7 black and colour 8
; green, so the loading screen arrives unseen. It sets a three-row text window at the
; bottom, rows 22-24, in colour 8, then calls load_files and jumps to load_core in the
; game, which loads the last file and starts it.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
.loader_start
    lda #&78 ; 'x'                      ; A = &78...
    clc                                 ; ...clear the carry...
    adc #&50 ; 'P'                      ; ...plus &50: OSBYTE &C8, the BREAK and ESCAPE effect
    ldx #2                              ; X = 2...
    inx                                 ; ...plus 1: 3, clear memory on BREAK
    jsr osbyte                          ; *FX 200,3
; MODE 2, with the cursor off and 25 rows of text shown
    lda #&16                            ; VDU 22: select a mode...
    jsr oswrch                          ; ...send it
    lda #2                              ; ...2
    jsr oswrch                          ; ...send it: MODE 2
    lda #&17                            ; VDU 23,0: write a 6845 register...
    jsr oswrch                          ; ...send the 23
    lda #0                              ; ...0: a 6845 register follows
    jsr oswrch                          ; ...send it
    lda #&0a                            ; ...register 10, cursor start...
    jsr oswrch                          ; ...send the number
    lda #&20 ; ' '                      ; ...&20: cursor off
    jsr oswrch                          ; ...send the value
    lda #0                              ; ...then six zeros to finish the command
    jsr oswrch                          ; ...the first
    jsr oswrch                          ; ...the second
    jsr oswrch                          ; ...the third
    jsr oswrch                          ; ...the fourth
    jsr oswrch                          ; ...the fifth
    jsr oswrch                          ; ...the sixth
    jsr oswrch                          ; A seventh 0: a VDU 0, which does nothing
    lda #&17                            ; VDU 23,0: write another 6845 register...
    jsr oswrch                          ; ...send the 23
    lda #0                              ; ...0: a 6845 register follows
    jsr oswrch                          ; ...send it
    lda #6                              ; ...register 6, character rows displayed...
    jsr oswrch                          ; ...send the number
    lda #&19                            ; ...25 rows, as in play
    jsr oswrch                          ; ...send the value
    lda #0                              ; ...then six zeros to finish the command
    jsr oswrch                          ; ...the first
    jsr oswrch                          ; ...the second
    jsr oswrch                          ; ...the third
    jsr oswrch                          ; ...the fourth
    jsr oswrch                          ; ...the fifth
    jsr oswrch                          ; ...the sixth
; Logical colours 7 down to 1 black, colour 8 green: the loading screen is drawn unseen
    ldx #7                              ; From logical colour 7 down to 1...
; &206a referenced 1 time by &2082
.blacken_colour
    lda #&13                            ; VDU 19: set a logical colour...
    jsr oswrch                          ; ...send the 19
    txa                                 ; ...this one...
    jsr oswrch                          ; ...send its number
    lda #0                              ; ...to physical colour 0, black, and three zeros
    jsr oswrch                          ; ...send the black
    jsr oswrch                          ; ...the first zero
    jsr oswrch                          ; ...the second
    jsr oswrch                          ; ...the third
    dex                                 ; Next colour down...
    bne blacken_colour                  ; ...until colour 1 is black
    lda #&13                            ; VDU 19: set a logical colour...
    jsr oswrch                          ; ...send the 19
    lda #8                              ; ...colour 8...
    jsr oswrch                          ; ...send its number
    lda #2                              ; ...to physical colour 2, green...
    jsr oswrch                          ; ...send it
    lda #0                              ; ...then three zeros
    jsr oswrch                          ; ...the first
    jsr oswrch                          ; ...the second
    jsr oswrch                          ; ...the third
    lda #&11                            ; VDU 17: set the text colour...
    jsr oswrch                          ; ...send the 17
    lda #8                              ; ...colour 8, green
    jsr oswrch                          ; ...send it
; A text window at the bottom, columns 0-19, rows 22-24
    lda #&1c                            ; VDU 28: set a text window...
    jsr oswrch                          ; ...send the 28
    lda #0                              ; ...left column 0
    jsr oswrch                          ; ...send it
    lda #&18                            ; ...bottom row 24
    jsr oswrch                          ; ...send it
    lda #&13                            ; ...right column 19
    jsr oswrch                          ; ...send it
    lda #&16                            ; ...top row 22
    jsr oswrch                          ; ...send it: the window is set
    jsr load_files                      ; Load the loading screen, Dunjunz3 and Dunjunz4
    jmp load_core                       ; Load Dunjunz5 and start the game; this file is overwritten
; ***************************************************************************************
; Load a file through FILEV
;
; Load the file that osfile_block names to the load address in it, by calling the filing
; system's FILEV routine directly: its address is copied into the operand of this
; routine's own JSR, then called with A = &FF (load). With *TAPE selected, as TITLE left
; it, the file comes from the cassette. The caller sets the filename's address and the
; load address's low two bytes; this routine clears the top two.
;
; On Entry:
;     OSFILE_BLOCK: filename address and load address, bytes 0-3
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &20c7 referenced 3 times by &20f9, &211f, &2131
.load_file
    ldx #<(osfile_block)                ; X, Y = osfile_block...
    ldy #>(osfile_block)                ; ...its page
    lda #0                              ; The load address's top two bytes are 0...
    sta osfile_load_addr_high           ; ...byte 4...
    sta osfile_load_addr_high + 1       ; ...and byte 5: the I/O processor
    lda filev                           ; Copy FILEV into the JSR below...
    sta load_file_call_address          ; ...its low byte...
    lda filev + 1                       ; ...and its high byte...
    sta load_file_call_address + 1      ; ...so the JSR calls the filing system's routine
    lda #&ff                            ; A = &FF: load the file
.load_file_call
; &20e2 referenced 1 time by &20d6
load_file_call_address = load_file_call+1
; &20e3 referenced 1 time by &20dc
    jsr &3000                           ; Call FILEV's routine; the operand, &3000 as stored, is set above
    rts                                 ; Return with the file loaded
; ***************************************************************************************
; Load the loading screen and two game files
;
; Load Dunjunz2, the loading screen, to &3280; restore the default colours (VDU 20),
; which shows it at once, clear the text window and set colour 2; then load Dunjunz3 to
; &6E80 and Dunjunz4 to &08C0. Each file is named by one of the filenames after the code
; and loaded by load_file.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &20e5 referenced 1 time by &20c1
.load_files
    lda #<(screen_filename)             ; Filename: screen_filename, "Dunjunz2"...
    sta osfile_block                    ; ...its low byte into the block...
    lda #>(screen_filename)             ; ...and its page...
    sta osfile_block + 1                ; ...into byte 1
    lda #<(loading_screen)              ; Load address &3280, loading_screen...
    sta osfile_load_addr                ; ...low byte...
    lda #>(loading_screen)              ; ...and page...
    sta osfile_load_addr + 1            ; ...into bytes 2-3
    jsr load_file                       ; Load the loading screen, in black
    lda #&14                            ; VDU 20: the default colours...
    jsr oswrch                          ; ...so the loading screen appears
    lda #&0c                            ; VDU 12: clear the text window...
    jsr oswrch                          ; ...send it
    lda #&11                            ; VDU 17: set the text colour...
    jsr oswrch                          ; ...send the 17
    lda #2                              ; ...colour 2, green
    jsr oswrch                          ; ...send it
    lda #<(dunjunz3_filename)           ; Filename: dunjunz3_filename (same page)...
    sta osfile_block                    ; ...into the block
    lda #<(dunjunz3_start)              ; Load address &6E80, dunjunz3_start...
    sta osfile_load_addr                ; ...low byte...
    lda #>(dunjunz3_start)              ; ...and page...
    sta osfile_load_addr + 1            ; ...into bytes 2-3
    jsr load_file                       ; Load Dunjunz3, the game's &6E80-&7FFF
    lda #<(dunjunz4_filename)           ; Filename: dunjunz4_filename (same page)...
    sta osfile_block                    ; ...into the block
    lda #<(dunjunz4_start)              ; Load address &08C0, dunjunz4_start...
    sta osfile_load_addr                ; ...low byte...
    lda #>(dunjunz4_start)              ; ...and page...
    sta osfile_load_addr + 1            ; ...into bytes 2-3
    jsr load_file                       ; Load Dunjunz4, the game's &08C0-&1FFF
    rts                                 ; Return to loader_start
; ***************************************************************************************
; Unused
;
; Leftover bytes from the machine the file was saved on: the end of a filename and
; fragments of code.
    equb &6f, &6e, &32, &0d, &f4, &ff, &a9, &d5
    equb &a2, &64, &20                  ; Not referenced: "on2", a CR, then leftover bytes
; ***************************************************************************************
; Filename: Dunjunz2
;
; The name of Dunjunz2, the loading screen, CR-terminated.
.screen_filename
    equs "Dunjunz2", &0d                ; "Dunjunz2" and a CR
; ***************************************************************************************
; Unused
;
; Leftover bytes.
    equb &ad, &0e, &02, &8d, &d3, &12, &ad  ; Not referenced
; ***************************************************************************************
; Filename: Dunjunz3
;
; The name of Dunjunz3, the game's &6E80-&7FFF, CR-terminated.
.dunjunz3_filename
    equs "Dunjunz3", &0d                ; "Dunjunz3" and a CR
; ***************************************************************************************
; Unused
;
; Leftover bytes.
    equb &02, &a9, &7f, &8d, &0f, &02, &60  ; Not referenced
; ***************************************************************************************
; Filename: Dunjunz4
;
; The name of Dunjunz4, the game's &08C0-&1FFF, CR-terminated.
.dunjunz4_filename
    equs "Dunjunz4", &0d                ; "Dunjunz4" and a CR
.dasmos_end

save "Dunjunz1", dasmos_start, dasmos_end, &2000, &2000

; Label references by decreasing frequency:
;     oswrch:                      46
;     load_file:                    3
;     blacken_colour:               1
;     filev:                        1
;     filev + 1:                    1
;     load_file_call_address:       1
;     load_file_call_address + 1:   1
;     load_files:                   1
;     osbyte:                       1

; Stats:
;     Total size (Code + Data) = 361 bytes
;     Code                     = 309 bytes (86%)
;     Data                     = 52 bytes (14%)
;
;     Number of instructions   = 123
;     Number of data bytes     = 25 bytes
;     Number of data words     = 0 bytes
;     Number of string bytes   = 27 bytes
;     Number of strings        = 3
