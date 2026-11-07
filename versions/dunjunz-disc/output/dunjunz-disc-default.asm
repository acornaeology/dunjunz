; Constants
level_length               = &02b0  ; The length of a level file
level_buffer_end           = &6db0  ; The end of the level file at &6B00
level_count                = &18  ; The levels *DEFAULT carries
osbyte_escape_break_effect = &c8
osbyte_flush_buffer_class  = &0f
osword_read_line           = &00

; Memory locations
tens_times_ten = &70  ; Scratch: twice, then ten times, the tens digit of the level number.
; &70 referenced 4 times by &1967, &196c, &196e, &1977
read_ptr       = &71  ; The level's copy within *DEFAULT, low byte (high byte at &72).
; &71 referenced 5 times by &1991, &1997, &199c, &19b1, &19b5
read_ptr_hi    = &72
; &72 referenced 4 times by &1995, &199e, &19a2, &19b9
put_ptr        = &73  ; Where the level is copied to, from &6B00, low byte (high byte at &74).
; &73 referenced 4 times by &19a9, &19b3, &19bb, &19c1
put_ptr_hi     = &74
; &74 referenced 3 times by &19ad, &19bf, &19c7
level_buffer   = &6b00  ; Where the game loads a level file, and where *DEFAULT puts the level it saves (&6B00-&6DAF).
osrdch         = &ffe0
; &ffe0 referenced 1 time by &19fc
oswrch         = &ffee
; &ffee referenced 8 times by &1909, &190e, &1913, &1926, &192e, &19e2, &19e7, &19ef
osword         = &fff1
; &fff1 referenced 1 time by &1955
osbyte         = &fff4
; &fff4 referenced 3 times by &191c, &1921, &19f9
oscli          = &fff7
; &fff7 referenced 2 times by &1904, &19dd
reset_vector   = &fffc  ; The 6502 reset vector: the MOS's reset entry.
; &fffc referenced 1 time by &1a07


    org &1900

.dasmos_start
; ***************************************************************************************
; *DEFAULT: restore a level file
;
; Set *TV255 1, MODE 7 and printer off; then, for each level, disable ESCAPE, clear the
; screen, ask which level to reset and read one or two digits. Accept 1-24, copy that
; level's original (still encrypted) from the copies at &1DB0 to &6B00 and *SAVE it as
; LevelN. Then offer another level, or quit through the reset vector. A leading zero (05)
; is kept in the filename (Level05), which the game does not read.
.default_start
    ldx #<(tv_command)                  ; *TV255 1: move the picture down a line, interlace off
    ldy #>(tv_command)                  ; ...
    jsr oscli                           ; ...
    lda #&16                            ; VDU 22,7: MODE 7
    jsr oswrch                          ; ...
    lda #7                              ; ...
    jsr oswrch                          ; ...
    lda #3                              ; VDU 3: printer off
    jsr oswrch                          ; ...
; &1916 referenced 4 times by &195a, &1988, &198c, &1a0a
.ask_level
    lda #osbyte_escape_break_effect     ; OSBYTE &C8 with X=1, Y=0: disable ESCAPE...
    ldx #1                              ; ...
    ldy #0                              ; ...
    jsr osbyte                          ; ...  osbyte: escape break effect
    lda #osbyte_flush_buffer_class      ; OSBYTE &0F: flush buffers (X is the old &C8 setting, normally 0: all)
    jsr osbyte                          ; ...  Flush selected class of buffer
    lda #&0c                            ; VDU 12: clear the screen
    jsr oswrch                          ; ...
    ldx #0                              ; Print the prompt, up to and including its zero...
; &192b referenced 1 time by &1934
.print_prompt
    lda level_prompt,x                  ; ...
    jsr oswrch                          ; ...
    inx                                 ; ...
    cmp #0                              ; ...
    bne print_prompt                    ; ...
    ldx #<(read_level_block)            ; Point XY at read_level_block...
    ldy #>(read_level_block)            ; ...
    lda #<(level_digits)                ; ...and fill it in: the buffer is level_digits...
    sta read_level_block                ; ...
    lda #>(level_digits)                ; ...
    sta read_level_block + 1            ; ...
    lda #2                              ; ...at most two characters...
    sta read_level_block + 2            ; ...
    lda #'0'                            ; ...from '0'...
    sta read_level_block + 3            ; ...
    lda #'9'                            ; ...to '9'
    sta read_level_block + 4            ; ...
    lda #osword_read_line               ; OSWORD 0: read the level number
    jsr osword                          ; ...  Read line from input stream (exits with C=1 if ESCAPE pressed)
    cpy #0                              ; Nothing typed (or ESCAPE)?
    beq ask_level                       ; Yes: ask again
    cpy #1                              ; One digit?
    beq one_digit                       ; Yes
    lda level_digits                    ; Two: tens digit...
    sec                                 ; ...
    sbc #'0'                            ; ...
    asl a                               ; ...x 2...
    sta tens_times_ten                  ; ...
    asl a                               ; ...x 8...
    asl a                               ; ...
    clc                                 ; ...
    adc tens_times_ten                  ; ...+ x 2 = x 10...
    sta tens_times_ten                  ; ...
    lda level_digits + 1                ; ...plus the units digit
    sec                                 ; ...
    sbc #'0'                            ; ...
    clc                                 ; ...
    adc tens_times_ten                  ; ...
    bne check_level                     ; Check it (falls through only for 00)
; &197b referenced 1 time by &195e
.one_digit
    lda #' '                            ; One digit: blank the second, for the filename...
    sta level_digits + 1                ; ...
    lda level_digits                    ; ...and the level is the digit
    sec                                 ; ...
    sbc #'0'                            ; ...
; &1986 referenced 1 time by &1979
.check_level
    cmp #level_count + 1                ; 25 or more: ask again
    bcs ask_level                       ; ...
    cmp #0                              ; 0: ask again
    beq ask_level                       ; ...
    tax                                 ; X = level
    lda #<(level_1_original - level_length)  ; read_ptr = &1B00...
    sta read_ptr                        ; ...
    lda #>(level_1_original - level_length)  ; ...
    sta read_ptr_hi                     ; ...
; &1997 referenced 1 time by &19a5
.find_copy
    lda read_ptr                        ; ...plus &2B0 for each level: level N's copy...
    clc                                 ; ...
    adc #<(level_length)                ; ...
    sta read_ptr                        ; ...
    lda read_ptr_hi                     ; ...
    adc #>(level_length)                ; ...
    sta read_ptr_hi                     ; ...
    dex                                 ; ...
    bne find_copy                       ; ...at &1B00 + N x &2B0
    lda #0                              ; put_ptr = &6B00
    sta put_ptr                         ; ...
    lda #>(level_buffer)                ; ...
    sta put_ptr_hi                      ; ...
    ldy #0                              ; Y = 0: both pointers step instead
; &19b1 referenced 2 times by &19c5, &19cb
.copy_level
    lda (read_ptr),y                    ; Copy a byte
    sta (put_ptr),y                     ; ...
    inc read_ptr                        ; Next byte to read
    bne copy_put_next                   ; ...
    inc read_ptr_hi                     ; ...
; &19bb referenced 1 time by &19b7
.copy_put_next
    inc put_ptr                         ; Next byte to write
    bne copy_check_end                  ; ...
    inc put_ptr_hi                      ; ...
; &19c1 referenced 1 time by &19bd
.copy_check_end
    lda put_ptr                         ; Until put_ptr reaches &6DB0
    cmp #<(level_buffer_end)            ; ...
    bne copy_level                      ; ...
    lda put_ptr_hi                      ; ...
    cmp #>(level_buffer_end)            ; ...
    bne copy_level                      ; ...
    lda level_digits                    ; Put the digits into the SAVE command
    sta save_command + 10               ; ...
    lda level_digits + 1                ; ...
    sta save_command + 11               ; ...
    ldx #<(save_command)                ; *SAVE LevelN 6B00+2B0
    ldy #>(save_command)                ; ...
    jsr oscli                           ; ...
    lda #&0d                            ; New line
    jsr oswrch                          ; ...
    lda #&0a                            ; ...
    jsr oswrch                          ; ...
    ldx #0                              ; Print the question, up to and including its zero
; &19ec referenced 1 time by &19f5
.print_question
    lda another_question,x              ; ...
    jsr oswrch                          ; ...
    inx                                 ; ...
    cmp #0                              ; ...
    bne print_question                  ; ...
    lda #osbyte_flush_buffer_class      ; OSBYTE &0F: flush the input buffer (X is non-zero)
    jsr osbyte                          ; ...  Flush selected class of buffer
; &19fc referenced 1 time by &1a05
.wait_for_answer
    jsr osrdch                          ; Wait for a key
    cmp #'A'                            ; A: another level
    beq another_level                   ; ...
    cmp #'Q'                            ; Q?
    bne wait_for_answer                 ; No: wait again
    jmp (reset_vector)                  ; Yes: quit through the reset vector
; &1a0a referenced 1 time by &1a01
.another_level
    jmp ask_level                       ; Another level
; ***************************************************************************************
; Prompts, the input block and the commands
; &1a0d used as index base 1 time by &192b
.level_prompt
    equs "Which level do you wish to reset ? "
    equb &00
; &1a31 referenced 1 time by &193c
.read_level_block
; &1a32 referenced 1 time by &1941
; &1a33 referenced 1 time by &1946
; &1a34 referenced 1 time by &194b
; &1a35 referenced 1 time by &1950
    equb &2a, &2a, &2a, &2a, &2a
; &1a36 referenced 3 times by &1960, &1980, &19cd
.level_digits
; &1a37 referenced 3 times by &1970, &197d, &19d3
    equb &2a, &2a, &2a
; &1a39 used as index base 1 time by &19ec
.another_question
    equs "Reset another level (A) or quit (Q) "
    equb &00
.save_command
; &1a68 referenced 1 time by &19d0
; &1a69 referenced 1 time by &19d6
    equs "SAVE Level11 6B00+2B0"
    equb &0d
.tv_command
    equs "TV255 1"
    equb &0d
; ***************************************************************************************
; Leftovers
;
; Never used: memory as it lay when the file was saved. A few bytes of text (among them
; PAGE), the end of an encrypted copy of level 3 and most of one of level 4, laid out as
; the Master side's Default holds them (level N at &1000 + N x &2B0), with other bytes
; written over parts of it, then lines of text reading SEG 0 to SEG 8 and ENDSEG.
.leftovers
    equb &4a, &93, &3e, &6f, &20, &02, &43, &45, &07, &50, &41, &47, &45, &20, &02, &50
    equb &50, &07, &0d, &7f, &83, &a0, &81, &a2, &96, &86, &94, &84, &a9, &8a, &ab, &88
    equb &8f, &9f, &8d, &9d, &93, &b0, &91, &b2, &86, &96, &84, &94, &b9, &9a, &bb, &98
    equb &9f, &8f, &9d, &8d, &a3, &80, &a1, &82, &b6, &a6, &b4, &a4, &89, &aa, &8b, &a8
    equb &af, &bf, &ad, &bd, &7d, &00, &01, &12, &0c, &0a, &18, &19, &16, &15, &16, &10
    equb &0e, &16, &1c, &1d, &02, &03, &1a, &1f, &00, &07, &14, &15, &03, &09, &0c, &0d
    equb &0f, &16, &1a, &e0, &df, &0a, &0b, &07, &01, &07, &39, &39, &35, &34, &31, &31
    equb &31, &3f, &38, &3a, &24, &22, &26, &22, &3f, &3e, &39, &3d, &3d, &3c, &39, &3a
    equb &3d, &3c, &3c, &c0, &bf, &0d, &6a, &6b, &6c, &6c, &25, &6d, &60, &61, &62, &62
    equb &64, &65, &66, &67, &78, &79, &7a, &32, &07, &06, &7f, &7f, &70, &71, &3a, &73
    equb &74, &75, &0f, &a0, &9f, &6f, &6b, &78, &78, &76, &77, &98, &97, &96, &95, &94
    equb &93, &92, &91, &90, &8f, &8e, &8d, &8c, &8b, &8a, &6e, &65, &77, &71, &71, &70
    equb &83, &82, &81, &80, &7f, &7e, &7d, &7c, &7b, &7a, &79, &78, &77, &76, &75, &96
    equb &91, &90, &93, &93, &8c, &6e, &6d, &6c, &6b, &6a, &69, &68, &67, &66, &65, &64
    equb &63, &62, &61, &60, &5f, &bc, &a0, &a8, &b5, &a9, &ad, &58, &57, &56, &55, &54
    equb &53, &52, &51, &50, &4f, &4e, &4d, &4c, &4b, &4a, &95, &9f, &b4, &9b, &b1, &b0
    equb &43, &42, &41, &40, &8b, &8e, &91, &93, &95, &95, &95, &95, &95, &95, &95, &1b
    equb &2d, &01, &1b, &2d, &00, &1b, &47, &1b, &48, &ce, &c4, &db, &ff, &c6, &cd, &ce
    equb &cc, &d6, &dd, &da, &1f, &69, &73, &43, &24, &65, &7a, &67, &17, &e9, &e9, &eb
    equb &22, &ed, &ce, &ef, &0f, &f1, &f3, &f3, &e4, &f5, &d7, &f4, &07, &f8, &63, &fa
    equb &b9, &fc, &01, &1e, &83, &85, &8b, &8a, &8d, &8c, &8e, &88, &f7, &09, &f5, &0b
    equb &0d, &f2, &0e, &f1, &ec, &11, &ed, &43, &eb, &15, &16, &17, &e5, &9c, &9f, &1e
    equb &99, &98, &9b, &e2, &a0, &a1, &dd, &b7, &b0, &b1, &b1, &b6, &2a, &2b, &d5, &2a
    equb &2d, &0c, &0f, &12, &30, &31, &42, &6c, &74, &6a, &66, &47, &7d, &7c, &7f, &fe
    equb &39, &f8, &7b, &7a, &d1, &d0, &d3, &de, &c1, &c0, &c3, &c2, &67, &61, &62, &63
    equb &67, &63, &6e, &6f, &d0, &d1, &ad, &53, &ad, &5c, &5f, &5e, &1d, &1c, &9f, &5e
    equb &99, &18, &1b, &9a, &e7, &e1, &9b, &eb, &ec, &e1, &98, &e2, &48, &48, &88, &ef
    equb &25, &46, &75, &6c, &f9, &3e, &52, &cc, &f4, &b5, &a9, &a7, &ff, &f8, &cb, &ca
    equb &4d, &4c, &8f, &6e, &04, &04, &04, &03, &05, &7b, &06, &78, &0b, &b0, &ce, &09
    equb &8d, &8d, &8e, &70, &40, &01, &b2, &d3, &14, &95, &96, &68, &87, &98, &9b, &9a
    equb &9d, &9c, &9f, &60, &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &97, &a9, &aa, &ab
    equb &ac, &ad, &ae, &af, &30, &c6, &d4, &ec, &8b, &ca, &d5, &c8, &b8, &56, &46, &44
    equb &8d, &42, &61, &40, &c0, &2c, &3c, &3e, &2b, &ba, &18, &3b, &c8, &37, &ac, &35
    equb &76, &23, &ce, &d1, &ac, &aa, &84, &a5, &a2, &a3, &a1, &87, &d8, &26, &da, &24
    equb &22, &dd, &21, &de, &e3, &1e, &e2, &64, &e4, &1a, &19, &18, &ea, &93, &90, &11
    equb &96, &97, &94, &ed, &8f, &8e, &f2, &98, &9f, &9e, &9e, &99, &05, &0c, &fa, &05
    equb &82, &23, &20, &3d, &ff, &fe, &8d, &83, &9b, &85, &89, &88, &b2, &b3, &a0, &31
    equb &f6, &37, &b4, &b5, &7e, &7f, &7c, &71, &6e, &4f, &6c, &6d, &c8, &ce, &cd, &cc
    equb &c8, &cc, &c1, &c0, &5f, &5e, &22, &dc, &22, &d3, &d0, &d1, &92, &93, &00, &d9
    equb &16, &9d, &96, &17, &48, &4e, &34, &44, &43, &4e, &37, &4d, &e7, &e7, &26, &40
    equb &8a, &69, &da, &c3
.seg_text_leftover
    equb &00, &81, &53, &45, &47, &20, &30, &0d, &0d, &81, &45, &4e, &44, &53, &45, &47
    equb &20, &0d, &00, &00, &81, &53, &45, &47, &20, &31, &0d, &0d, &81, &45, &4e, &44
    equb &53, &45, &47, &20, &0d, &00, &00, &81, &53, &45, &47, &20, &32, &0d, &0d, &81
    equb &45, &4e, &44, &53, &45, &47, &20, &0d, &00, &00, &81, &53, &45, &47, &20, &33
    equb &0d, &0d, &81, &45, &4e, &44, &53, &45, &47, &20, &0d, &00, &00, &81, &53, &45
    equb &47, &20, &34, &0d, &0d, &81, &45, &4e, &44, &53, &45, &47, &20, &0d, &00, &00
    equb &81, &53, &45, &47, &20, &35, &0d, &0d, &81, &45, &4e, &44, &53, &45, &47, &20
    equb &0d, &00, &00, &81, &53, &45, &47, &20, &36, &0d, &0d, &81, &45, &4e, &44, &53
    equb &45, &47, &20, &0d, &00, &00, &81, &53, &45, &47, &20, &37, &0d, &0d, &81, &45
    equb &4e, &44, &53, &45, &47, &20, &0d, &00, &00, &81, &53, &45, &47, &20, &38, &0d
    equb &0d, &81, &45, &4e, &44, &53, &45, &47, &20, &0d, &00, &00, &81, &53, &45, &47
; ***************************************************************************************
; The original levels
;
; Levels 1 to 24 as the game loads them: &2B0 bytes each, encrypted (each byte XORed with
; the low byte of its address at &6B00). They are byte for byte this side's
; Level1-Level24. *DEFAULT finds level N at &1B00 + N x &2B0.
.level_1_original
    equb &ff, &0f, &0f, &0d, &06, &04, &04, &06, &15, &17, &18, &18, &02, &00, &05, &1e
    equb &1d, &1a, &17, &16, &08, &09, &0a, &06, &0a, &0a, &17, &17, &1f, &1f, &02, &e0
    equb &df, &3c, &3e, &38, &3a, &38, &3a, &3c, &3c, &3b, &3c, &3a, &3e, &3c, &3f, &25
    equb &39, &38, &3c, &3f, &37, &37, &37, &30, &3b, &3b, &3b, &3a, &3e, &3f, &23, &c0
    equb &bf, &69, &11, &6b, &6c, &6d, &6e, &6f, &61, &61, &2a, &62, &64, &2e, &66, &67
    equb &78, &79, &7b, &79, &7c, &7d, &7e, &7f, &70, &3b, &72, &73, &74, &75, &0f, &a0
    equb &9f, &60, &65, &6e, &6e, &79, &72, &6b, &6c, &96, &95, &94, &93, &92, &91, &90
    equb &8f, &8e, &8d, &8c, &8b, &8a, &6c, &62, &74, &72, &7e, &7f, &78, &79, &81, &80
    equb &7f, &7e, &7d, &7c, &7b, &7a, &79, &78, &77, &76, &75, &96, &90, &91, &92, &92
    equb &8d, &8c, &8f, &6c, &6b, &6a, &69, &68, &67, &66, &65, &64, &63, &62, &61, &60
    equb &5f, &b5, &a7, &af, &af, &ae, &b7, &a3, &b3, &56, &55, &54, &53, &52, &51, &50
    equb &4f, &4e, &4d, &4c, &4b, &4a, &bb, &a5, &b4, &b2, &a3, &a8, &b0, &b0, &41, &40
    equb &3f, &3e, &3d, &3c, &3b, &3a, &39, &38, &37, &36, &35, &34, &33, &32, &31, &30
    equb &ce, &c5, &d7, &d8, &d5, &c9, &c7, &db, &f0, &c0, &c4, &cd, &ce, &d4, &d0, &d9
    equb &1f, &60, &63, &62, &1b, &65, &66, &7a, &17, &68, &6b, &6a, &13, &ed, &ee, &10
    equb &0f, &70, &73, &72, &0b, &f5, &f6, &76, &07, &78, &7b, &7a, &03, &fc, &ff, &7e
    equb &9d, &9c, &9f, &9e, &95, &9a, &86, &9e, &f7, &88, &b7, &ae, &a9, &b0, &0e, &f0
    equb &91, &90, &92, &93, &eb, &d5, &16, &e8, &99, &98, &1b, &1a, &ed, &1c, &1f, &9e
    equb &b9, &b8, &bb, &ba, &bd, &bc, &bf, &be, &d7, &a8, &ab, &aa, &ad, &2c, &af, &d0
    equb &cf, &b0, &b2, &b3, &b4, &b2, &b2, &b3, &b9, &f8, &5b, &1a, &3d, &bc, &7f, &3e
    equb &d9, &d0, &b3, &d2, &d4, &d4, &d7, &b8, &b7, &ce, &cd, &ce, &4c, &c8, &c9, &b0
    equb &d4, &d5, &ae, &d3, &54, &d5, &d6, &a8, &59, &58, &2d, &1a, &1d, &1c, &1f, &a0
    equb &e0, &e1, &e2, &e3, &e4, &e5, &e6, &e7, &68, &69, &6a, &6b, &6c, &6d, &6e, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &79, &78, &7b, &7a, &7d, &7c, &7f, &7e
    equb &00, &01, &02, &03, &04, &05, &06, &78, &88, &89, &8a, &8b, &8c, &8d, &8e, &70
    equb &90, &91, &92, &93, &94, &95, &96, &68, &99, &98, &9b, &9a, &9d, &9c, &9f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &cf, &fc, &cd, &b4, &ca, &c9, &d5, &b8, &cb, &c4, &c5, &bc, &42, &41, &bf
    equb &c0, &bf, &ac, &9d, &c4, &3a, &39, &f9, &c8, &bf, &bc, &bd, &cc, &33, &30, &b1
    equb &b2, &b3, &b0, &b1, &be, &b5, &ad, &b1, &d8, &b3, &98, &81, &86, &9f, &21, &df
    equb &9e, &9f, &dd, &9c, &e4, &da, &19, &e7, &96, &97, &14, &15, &e2, &13, &10, &91
    equb &96, &97, &94, &95, &92, &93, &90, &91, &f8, &93, &86, &85, &82, &03, &80, &ff
    equb &00, &6f, &7d, &7c, &7b, &7d, &5d, &7c, &76, &37, &96, &d5, &f6, &73, &b0, &f1
    equb &76, &7f, &1c, &3d, &5b, &3b, &58, &17, &18, &61, &62, &63, &e7, &65, &66, &1f
    equb &5b, &5a, &21, &5c, &db, &5a, &59, &27, &d6, &d7, &a2, &95, &92, &9b, &90, &2f
    equb &4f, &4e, &4d, &4c, &4b, &4a, &49, &48, &c7, &c6, &c5, &c4, &c3, &c2, &c1, &c0
    equb &bf, &be, &bd, &bc, &bb, &ba, &b9, &b8, &b6, &b7, &b4, &b5, &b2, &b3, &b0, &b1
    equb &2f, &2e, &2d, &2c, &2b, &2a, &29, &57, &a7, &a6, &a5, &a4, &a3, &a2, &a1, &5f
    equb &9f, &9e, &9d, &9c, &9b, &9a, &99, &67, &96, &97, &94, &95, &92, &93, &90, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &94, &bd, &be, &ab, &ad, &86, &85, &91, &a1, &8a, &89, &9d, &a5, &8e, &8d, &99
    equb &b9, &92, &91, &85, &80, &a9, &aa, &bf, &a4, &b1, &8e, &a7, &9f, &8b, &b7, &9c
    equb &a3, &b7, &8b, &a0, &a7, &b3, &8f, &a4, &ab, &bf, &83, &a8, &90, &85, &ba, &93
.level_2_original
    equb &cd, &1d, &1f, &1f, &1f, &19, &0c, &1c, &11, &10, &1e, &00, &03, &0c, &10, &04
    equb &1f, &08, &0c, &0d, &0a, &08, &1a, &16, &19, &07, &06, &17, &17, &1e, &1f, &e0
    equb &df, &0b, &0b, &0a, &0d, &0d, &0d, &02, &0a, &08, &08, &0e, &0f, &08, &37, &32
    equb &29, &26, &27, &27, &27, &24, &23, &21, &2c, &30, &39, &3c, &3d, &3f, &10, &c0
    equb &bf, &69, &6a, &22, &6c, &6d, &19, &6f, &1b, &63, &2a, &63, &65, &65, &67, &1c
    equb &78, &02, &30, &31, &36, &7d, &05, &7f, &70, &71, &73, &72, &74, &3e, &0f, &a0
    equb &9f, &75, &63, &67, &70, &6c, &63, &65, &6a, &6d, &6b, &73, &7a, &64, &7b, &79
    equb &7f, &69, &63, &7a, &76, &8a, &5c, &55, &59, &66, &60, &64, &62, &61, &64, &65
    equb &97, &95, &93, &8f, &8e, &8e, &85, &83, &8c, &8c, &75, &97, &91, &90, &93, &93
    equb &8c, &8d, &8e, &8e, &89, &89, &8b, &8b, &85, &84, &86, &87, &80, &81, &83, &60
    equb &5f, &a0, &a3, &a4, &ab, &bc, &ab, &a6, &ac, &a8, &ae, &ae, &a6, &b8, &b2, &a2
    equb &ba, &bc, &ae, &b9, &b9, &4a, &95, &a9, &a1, &ac, &a7, &9c, &a5, &9e, &a5, &a6
    equb &ee, &d3, &cc, &c8, &c9, &c8, &cc, &c3, &c2, &c8, &35, &34, &33, &32, &31, &30
    equb &c0, &de, &d0, &c4, &c8, &d9, &d2, &c1, &f6, &f0, &f3, &c1, &ca, &cf, &ce, &d9
    equb &1f, &60, &63, &62, &64, &1a, &66, &64, &17, &28, &2b, &2a, &ac, &12, &aa, &fe
    equb &0f, &31, &32, &33, &b5, &08, &b3, &e2, &07, &98, &3b, &7a, &7d, &fc, &ff, &00
    equb &84, &85, &8a, &93, &87, &85, &86, &e4, &f7, &ac, &8b, &8a, &8d, &8c, &ab, &f0
    equb &ed, &ec, &ed, &13, &eb, &ee, &ed, &ec, &e7, &98, &93, &0e, &99, &94, &9f, &e0
    equb &a0, &a1, &a3, &a2, &a5, &a4, &a7, &d8, &d7, &69, &7a, &d8, &de, &db, &dc, &dd
    equb &cb, &70, &33, &f2, &4b, &31, &32, &33, &c7, &f8, &e5, &fa, &fd, &fc, &ff, &be
    equb &bf, &f5, &be, &e3, &e5, &a7, &e2, &a3, &bb, &09, &0a, &0b, &b1, &4d, &5e, &30
    equb &a4, &45, &66, &27, &a0, &55, &56, &a9, &91, &90, &91, &96, &a1, &58, &5b, &5a
    equb &e4, &fd, &96, &d5, &9b, &e2, &e5, &e6, &17, &16, &15, &6b, &6b, &6d, &2e, &0f
    equb &87, &86, &87, &4e, &c8, &ca, &c9, &7f, &9d, &dc, &df, &fe, &79, &f8, &83, &7e
    equb &00, &01, &02, &03, &7b, &7a, &06, &78, &f8, &f9, &ba, &9b, &7c, &72, &8e, &70
    equb &98, &99, &9a, &9b, &9c, &6a, &96, &68, &99, &98, &9b, &9a, &9d, &60, &9f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &cf, &dc, &cd, &cb, &b5, &c9, &cb, &b8, &97, &84, &85, &03, &bd, &05, &59
    equb &c0, &fe, &fd, &fc, &7a, &c7, &7c, &2d, &c8, &57, &f4, &bd, &b2, &33, &30, &cf
    equb &ab, &aa, &a5, &bc, &a8, &aa, &a9, &cb, &d8, &83, &a4, &a5, &a2, &a3, &84, &df
    equb &e2, &e3, &e2, &1c, &e4, &e1, &e2, &e3, &e8, &85, &9c, &09, &96, &9b, &80, &ef
    equb &8f, &8e, &8c, &8d, &ca, &8b, &c8, &f7, &f8, &46, &55, &f7, &f1, &fc, &f3, &f2
    equb &00, &bf, &fc, &3d, &84, &fe, &fd, &fc, &08, &33, &2a, &37, &30, &31, &30, &31
    equb &10, &5a, &11, &4c, &4a, &08, &4d, &0c, &14, &a7, &a5, &a4, &1e, &f2, &f1, &9f
    equb &2b, &ca, &e9, &a8, &2f, &da, &d9, &26, &1e, &1d, &1e, &19, &2c, &d5, &d6, &d7
    equb &4b, &52, &39, &7a, &34, &0d, &4a, &49, &b8, &b9, &ba, &c5, &c4, &d2, &81, &a0
    equb &48, &49, &42, &83, &04, &05, &06, &b0, &50, &51, &52, &33, &34, &25, &4e, &b1
    equb &2f, &2e, &2d, &2c, &54, &55, &69, &57, &d7, &d6, &95, &94, &53, &5d, &a1, &5f
    equb &97, &96, &95, &94, &93, &65, &99, &67, &9e, &8b, &9c, &95, &92, &6f, &90, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &85, &8e, &85, &89, &8b, &8a, &8d, &88, &83, &86, &81, &84, &87, &8e, &81, &88
    equb &9f, &92, &9d, &9c, &93, &92, &99, &90, &97, &96, &9d, &9c, &9b, &92, &91, &94
    equb &a7, &ae, &ad, &a8, &ab, &a6, &a9, &a0, &a3, &ae, &ad, &a4, &a9, &aa, &a5, &a5
.level_3_original
    equb &ff, &09, &10, &1a, &18, &07, &17, &0f, &02, &18, &1c, &17, &08, &0b, &0f, &0b
    equb &01, &17, &01, &15, &1f, &1a, &18, &0a, &06, &04, &04, &01, &01, &03, &1f, &e0
    equb &df, &20, &23, &22, &23, &29, &2d, &37, &38, &3d, &3d, &3e, &31, &30, &31, &30
    equb &2a, &15, &11, &1e, &1f, &18, &18, &1f, &10, &10, &13, &11, &16, &17, &12, &c0
    equb &bf, &69, &6b, &6b, &6d, &6d, &6f, &6f, &60, &61, &63, &63, &1f, &64, &66, &2d
    equb &78, &79, &7a, &7a, &7c, &7d, &37, &7e, &71, &70, &73, &73, &75, &74, &0f, &a0
    equb &9f, &9e, &9d, &9c, &9b, &9a, &99, &98, &97, &96, &95, &94, &93, &92, &91, &90
    equb &8f, &8e, &8d, &8c, &8b, &8a, &89, &88, &87, &86, &85, &84, &83, &82, &81, &80
    equb &7f, &7e, &7d, &7c, &7b, &7a, &79, &78, &77, &76, &75, &74, &73, &72, &71, &70
    equb &6f, &6e, &6d, &6c, &6b, &6a, &69, &68, &67, &66, &65, &64, &63, &62, &61, &60
    equb &5f, &5e, &5d, &5c, &5b, &5a, &59, &58, &57, &56, &55, &54, &53, &52, &51, &50
    equb &4f, &4e, &4d, &4c, &4b, &4a, &49, &48, &47, &46, &45, &44, &43, &42, &41, &40
    equb &3f, &3e, &3d, &3c, &3b, &3a, &39, &38, &37, &36, &35, &34, &33, &32, &31, &30
    equb &d2, &c2, &ca, &d5, &db, &cb, &d2, &c3, &db, &df, &d5, &c8, &c2, &c0, &f8, &f6
    equb &1f, &61, &3d, &33, &33, &71, &77, &66, &17, &e9, &13, &ea, &93, &ed, &6f, &40
    equb &0f, &f1, &0b, &f8, &9c, &9e, &9c, &9d, &07, &f8, &07, &06, &fd, &08, &fb, &0a
    equb &fd, &fc, &c2, &dd, &c4, &92, &92, &a3, &a0, &a1, &24, &6b, &09, &b8, &ae, &0a
    equb &1b, &11, &6d, &12, &c9, &c4, &0b, &e6, &ed, &1c, &4d, &4a, &49, &48, &43, &5e
    equb &84, &8c, &8f, &8f, &98, &a1, &d2, &a0, &2d, &dc, &3a, &7c, &bc, &de, &2c, &d5
    equb &31, &f1, &2d, &c3, &35, &cc, &37, &f2, &47, &38, &ef, &2e, &69, &6a, &eb, &6a
    equb &b4, &c4, &d7, &f6, &d1, &90, &d3, &f2, &4a, &b7, &0a, &14, &1c, &0a, &3a, &0b
    equb &95, &c4, &c7, &c6, &41, &a0, &17, &56, &2d, &5c, &2f, &1a, &1d, &20, &5f, &a6
    equb &f4, &be, &e6, &96, &e1, &d8, &e7, &da, &1d, &6d, &6f, &b6, &6d, &1e, &9e, &68
    equb &88, &7a, &8a, &72, &75, &88, &73, &93, &73, &92, &51, &d0, &57, &56, &95, &76
    equb &7d, &00, &2d, &2a, &2d, &2d, &06, &78, &77, &89, &f5, &cb, &cb, &c9, &8a, &70
    equb &77, &91, &4f, &96, &61, &f1, &92, &68, &41, &d0, &c3, &c0, &45, &9c, &31, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &ce, &92, &9c, &9c, &de, &d8, &c9, &b8, &c6, &bc, &45, &3c, &42, &c0, &ef
    equb &c0, &1e, &c4, &37, &53, &51, &53, &52, &c8, &77, &c8, &c9, &32, &c7, &34, &cd
    equb &d2, &d3, &ed, &f2, &cb, &bd, &bd, &8c, &8f, &8e, &0b, &44, &26, &97, &81, &25
    equb &14, &1e, &62, &5d, &c6, &cb, &04, &e9, &e2, &13, &42, &45, &46, &47, &4c, &51
    equb &ab, &a3, &a0, &a0, &b7, &8e, &fd, &8f, &a2, &f3, &15, &53, &93, &f1, &03, &fa
    equb &fe, &3e, &e2, &0c, &ba, &03, &f8, &3f, &88, &f7, &20, &e1, &a6, &ad, &24, &a5
    equb &1b, &6b, &78, &59, &7e, &35, &7c, &15, &e5, &18, &a5, &bb, &b3, &a5, &95, &a4
    equb &1a, &4b, &08, &49, &ce, &2f, &98, &d9, &a2, &d3, &a0, &95, &92, &af, &d0, &29
    equb &5b, &11, &49, &39, &4c, &77, &48, &75, &b2, &c2, &c0, &19, &c2, &b1, &31, &c7
    equb &47, &b5, &45, &ad, &ba, &47, &bc, &5c, &bc, &5d, &9e, &1f, &98, &99, &5a, &b9
    equb &52, &2f, &02, &05, &42, &00, &29, &57, &58, &a6, &da, &f4, &e4, &e7, &a7, &5f
    equb &78, &9e, &40, &99, &6e, &fe, &9d, &67, &48, &d9, &ea, &cf, &4a, &93, &3e, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &83, &a0, &81, &a2, &96, &86, &94, &84, &a9, &8a, &ab, &88, &8f, &9f, &8d, &9d
    equb &93, &b0, &91, &b2, &86, &96, &84, &94, &b9, &9a, &bb, &98, &9f, &8f, &9d, &8d
    equb &a3, &80, &a1, &82, &b6, &a6, &b4, &a4, &89, &aa, &8b, &a8, &af, &bf, &ad, &bd
.level_4_original
    equb &7d, &00, &01, &12, &0c, &0a, &18, &19, &16, &15, &16, &10, &0e, &16, &1c, &1d
    equb &02, &03, &1a, &1f, &00, &07, &14, &15, &03, &09, &0c, &0d, &0f, &16, &1a, &e0
    equb &df, &0a, &0b, &07, &01, &07, &39, &39, &35, &34, &31, &31, &31, &3f, &38, &3a
    equb &24, &22, &26, &22, &3f, &3e, &39, &3d, &3d, &3c, &39, &3a, &3d, &3c, &3c, &c0
    equb &bf, &23, &6a, &6b, &6c, &6c, &25, &6d, &60, &61, &62, &62, &64, &65, &66, &67
    equb &78, &79, &7a, &32, &07, &06, &7f, &7f, &70, &71, &3a, &73, &74, &75, &0f, &a0
    equb &9f, &6f, &6b, &78, &78, &76, &77, &98, &97, &96, &95, &94, &93, &92, &91, &90
    equb &8f, &8e, &8d, &8c, &8b, &8a, &6e, &65, &77, &71, &71, &70, &83, &82, &81, &80
    equb &7f, &7e, &7d, &7c, &7b, &7a, &79, &78, &77, &76, &75, &96, &91, &90, &93, &93
    equb &8c, &6e, &6d, &6c, &6b, &6a, &69, &68, &67, &66, &65, &64, &63, &62, &61, &60
    equb &5f, &bc, &a0, &a8, &b5, &a9, &ad, &58, &57, &56, &55, &54, &53, &52, &51, &50
    equb &4f, &4e, &4d, &4c, &4b, &4a, &95, &9f, &b4, &9b, &b1, &b0, &43, &42, &41, &40
    equb &3f, &3e, &3d, &3c, &3b, &3a, &39, &38, &37, &36, &35, &34, &33, &32, &31, &30
    equb &dd, &d2, &cc, &c8, &d0, &ce, &c4, &db, &ff, &c6, &cd, &ce, &cc, &d6, &dd, &da
    equb &1f, &69, &73, &43, &24, &65, &7a, &67, &17, &e9, &e9, &eb, &22, &ed, &ce, &ef
    equb &0f, &f1, &f3, &f3, &e4, &f5, &d7, &f4, &07, &f8, &63, &fa, &b9, &fc, &01, &1e
    equb &83, &85, &8b, &8a, &8d, &8c, &8e, &88, &f7, &09, &f5, &0b, &0d, &f2, &0e, &f1
    equb &ec, &11, &ed, &43, &eb, &15, &16, &17, &e5, &9c, &9f, &1e, &99, &98, &9b, &e2
    equb &a0, &a1, &dd, &b7, &b0, &b1, &b1, &b6, &2a, &2b, &d5, &2a, &2d, &0c, &0f, &12
    equb &30, &31, &42, &6c, &74, &6a, &66, &47, &7d, &7c, &7f, &fe, &39, &f8, &7b, &7a
    equb &d1, &d0, &d3, &de, &c1, &c0, &c3, &c2, &67, &61, &62, &63, &67, &63, &6e, &6f
    equb &d0, &d1, &ad, &53, &ad, &5c, &5f, &5e, &1d, &1c, &9f, &5e, &99, &18, &1b, &9a
    equb &e7, &e1, &9b, &eb, &ec, &e1, &98, &e2, &48, &48, &88, &ef, &25, &46, &75, &6c
    equb &f9, &3e, &52, &cc, &f4, &b5, &a9, &a7, &ff, &f8, &cb, &ca, &4d, &4c, &8f, &6e
    equb &04, &04, &04, &03, &05, &7b, &06, &78, &0b, &b0, &ce, &09, &8d, &8d, &8e, &70
    equb &40, &01, &b2, &d3, &14, &95, &96, &68, &87, &98, &9b, &9a, &9d, &9c, &9f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &97, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &30, &c6, &d4, &ec, &8b, &ca, &d5, &c8, &b8, &56, &46, &44, &8d, &42, &61, &40
    equb &c0, &2c, &3c, &3e, &2b, &ba, &18, &3b, &c8, &37, &ac, &35, &76, &23, &ce, &d1
    equb &ac, &aa, &84, &a5, &a2, &a3, &a1, &87, &d8, &26, &da, &24, &22, &dd, &21, &de
    equb &e3, &1e, &e2, &64, &e4, &1a, &19, &18, &ea, &93, &90, &11, &96, &97, &94, &ed
    equb &8f, &8e, &f2, &98, &9f, &9e, &9e, &99, &05, &0c, &fa, &05, &82, &23, &20, &3d
    equb &ff, &fe, &8d, &83, &9b, &85, &89, &88, &b2, &b3, &a0, &31, &f6, &37, &b4, &b5
    equb &7e, &7f, &7c, &71, &6e, &4f, &6c, &6d, &c8, &ce, &cd, &cc, &c8, &cc, &c1, &c0
    equb &5f, &5e, &22, &dc, &22, &d3, &d0, &d1, &92, &93, &00, &d9, &16, &9d, &96, &17
    equb &48, &4e, &34, &44, &43, &4e, &37, &4d, &e7, &e7, &26, &40, &8a, &69, &da, &c3
    equb &36, &f1, &9d, &03, &7b, &7a, &66, &68, &30, &37, &04, &05, &82, &83, &40, &a1
    equb &2b, &3b, &2b, &6c, &2a, &54, &29, &57, &24, &9f, &e1, &26, &a2, &a2, &a1, &5f
    equb &4f, &0e, &bd, &dc, &1b, &9a, &99, &67, &88, &97, &94, &95, &92, &93, &90, &6f
    equb &58, &61, &48, &79, &5c, &60, &49, &62, &7b, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &94, &bd, &be, &ab, &a8, &89, &8a, &9b, &a4, &85, &86, &97, &a0, &81, &82, &93
    equb &bc, &9d, &9e, &8f, &80, &a9, &aa, &bf, &a4, &b1, &8e, &a7, &90, &81, &b2, &93
    equb &ac, &bd, &8e, &af, &a8, &b9, &8a, &ab, &a4, &b5, &86, &a7, &90, &85, &ba, &93
.level_5_original
    equb &5a, &1c, &1e, &1d, &17, &16, &02, &03, &0f, &08, &13, &1d, &07, &07, &06, &07
    equb &14, &12, &10, &08, &0c, &10, &12, &13, &00, &12, &10, &03, &09, &1b, &1a, &e0
    equb &df, &0c, &0e, &08, &0d, &0d, &08, &0c, &02, &03, &0d, &08, &09, &08, &0a, &0e
    equb &12, &13, &10, &2d, &29, &2c, &2f, &2f, &2d, &29, &2a, &32, &32, &34, &12, &c0
    equb &bf, &69, &6b, &6b, &6c, &6c, &6d, &6c, &63, &62, &62, &62, &64, &65, &2c, &65
    equb &78, &31, &32, &7b, &7c, &06, &7d, &04, &07, &3a, &73, &08, &0f, &0e, &0f, &a0
    equb &9f, &6f, &69, &6a, &7e, &7f, &60, &7b, &70, &7c, &79, &6d, &7a, &92, &91, &90
    equb &8f, &8e, &8d, &8c, &8b, &8a, &5a, &5c, &53, &62, &63, &61, &6f, &75, &71, &76
    equb &88, &80, &7d, &7c, &7b, &7a, &79, &78, &77, &76, &75, &96, &91, &90, &93, &92
    equb &8d, &8d, &8f, &8e, &89, &88, &8a, &8a, &67, &66, &65, &64, &63, &62, &61, &60
    equb &5f, &aa, &ab, &b8, &b5, &ab, &bf, &a9, &b3, &ac, &b9, &b2, &a1, &52, &51, &50
    equb &4f, &4e, &4d, &4c, &4b, &4a, &98, &9d, &a4, &b1, &97, &a8, &92, &b0, &ba, &ab
    equb &c6, &c9, &3d, &3c, &3b, &3a, &39, &38, &37, &36, &35, &34, &33, &32, &31, &30
    equb &c8, &da, &db, &d4, &c6, &cb, &ca, &c7, &f4, &fe, &f8, &fc, &c7, &ca, &d3, &dd
    equb &1f, &19, &1a, &1b, &1c, &1d, &1e, &1f, &17, &89, &8a, &8b, &8c, &87, &84, &85
    equb &0f, &f3, &f0, &f1, &f7, &5f, &5c, &5d, &07, &e6, &f5, &fc, &0f, &ec, &ef, &ee
    equb &ff, &fc, &82, &83, &84, &85, &f9, &f8, &62, &f6, &0a, &0b, &0c, &0d, &f1, &f0
    equb &bb, &ee, &3a, &57, &14, &15, &ed, &f8, &c9, &64, &1f, &1e, &61, &18, &e3, &e2
    equb &de, &df, &dc, &dd, &a4, &9a, &99, &97, &28, &29, &d2, &d6, &21, &c0, &c3, &c2
    equb &d1, &d0, &d3, &d2, &d5, &d4, &d7, &d6, &b5, &b4, &b7, &b2, &b1, &38, &3b, &3a
    equb &f0, &f1, &fd, &c3, &fb, &fa, &f9, &f8, &a5, &a4, &a7, &4b, &a3, &a2, &a1, &a0
    equb &b1, &ae, &92, &4e, &a4, &a5, &a6, &a0, &5d, &a4, &5b, &a6, &19, &18, &1b, &a2
    equb &e7, &e7, &e4, &e5, &e2, &ba, &a7, &93, &88, &44, &67, &66, &61, &60, &93, &4e
    equb &70, &ce, &cd, &d2, &f5, &d2, &d2, &d3, &79, &c6, &c5, &c4, &c3, &c2, &79, &78
    equb &77, &2b, &02, &17, &10, &27, &47, &78, &27, &26, &25, &77, &23, &20, &03, &70
    equb &34, &35, &2d, &9c, &94, &9a, &99, &68, &9f, &9e, &e5, &fa, &fd, &9c, &7f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &95, &81, &86, &87, &91, &af
    equb &b0, &b6, &b5, &b4, &b3, &b2, &b1, &b0, &b8, &26, &25, &24, &23, &28, &2b, &2a
    equb &c0, &3c, &3f, &3e, &38, &90, &93, &92, &c8, &29, &3a, &33, &c0, &23, &20, &21
    equb &d0, &d1, &ad, &ac, &ab, &aa, &d6, &d7, &4d, &d9, &25, &3c, &3b, &22, &de, &df
    equb &b4, &e1, &35, &58, &1b, &1a, &e6, &f7, &c6, &eb, &10, &11, &6e, &17, &ec, &ed
    equb &f1, &f0, &f3, &f2, &8b, &b5, &b6, &b8, &37, &06, &fd, &f9, &0e, &ef, &ec, &ed
    equb &1e, &1f, &1c, &1d, &1a, &1b, &18, &19, &7a, &7b, &78, &7d, &7e, &77, &f4, &f5
    equb &57, &52, &52, &6c, &54, &55, &56, &57, &0a, &0b, &08, &e4, &0c, &0d, &0e, &0f
    equb &3e, &21, &1d, &c1, &2b, &2a, &29, &2f, &d2, &2b, &d4, &29, &96, &17, &84, &2d
    equb &48, &48, &73, &4a, &4d, &15, &08, &3c, &27, &6b, &c8, &c9, &4e, &ff, &3c, &e1
    equb &bf, &01, &02, &1f, &3a, &1d, &1d, &1c, &b6, &09, &0a, &0b, &0c, &0d, &b6, &f7
    equb &58, &04, &6c, &30, &37, &00, &60, &57, &08, &09, &0a, &58, &0c, &0f, &2c, &5f
    equb &2b, &2a, &22, &93, &9b, &95, &96, &67, &90, &91, &ea, &f7, &fa, &97, &70, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &53, &50, &51, &56, &57, &7e, &7f
    equb &81, &82, &81, &81, &83, &8e, &8d, &8c, &8f, &86, &85, &80, &8f, &82, &81, &84
    equb &97, &9e, &95, &98, &95, &96, &95, &95, &9b, &9b, &9b, &98, &9b, &96, &99, &90
    equb &af, &aa, &a1, &ac, &ab, &ae, &a1, &a8, &a3, &a2, &ad, &a0, &af, &af, &af, &ac
.level_6_original
    equb &d7, &1f, &18, &01, &1c, &09, &05, &04, &0b, &11, &06, &17, &16, &1f, &1f, &1e
    equb &02, &00, &00, &02, &11, &13, &12, &16, &19, &0d, &15, &18, &1a, &18, &12, &e0
    equb &df, &0f, &09, &0f, &01, &02, &05, &05, &09, &30, &36, &3a, &3d, &3a, &39, &39
    equb &25, &24, &26, &27, &21, &21, &22, &3c, &30, &3a, &3f, &3c, &39, &3f, &25, &c0
    equb &bf, &12, &6a, &68, &6e, &6f, &27, &26, &29, &1a, &61, &63, &1f, &65, &66, &67
    equb &78, &79, &7a, &7b, &35, &34, &37, &04, &0b, &39, &70, &73, &75, &74, &0f, &a0
    equb &9f, &73, &68, &61, &66, &63, &71, &6c, &6a, &6c, &6d, &60, &60, &6c, &91, &90
    equb &8f, &8e, &8d, &8c, &8b, &8a, &5d, &59, &53, &53, &58, &62, &6b, &6a, &6d, &6f
    equb &8d, &83, &85, &7c, &7b, &7a, &79, &78, &77, &76, &75, &97, &90, &90, &93, &93
    equb &8c, &8d, &8f, &8e, &88, &88, &8a, &8a, &67, &66, &65, &64, &63, &62, &61, &60
    equb &5f, &ab, &a6, &b1, &ab, &b1, &b8, &bc, &a3, &bc, &b1, &a6, &a6, &ac, &51, &50
    equb &4f, &4e, &4d, &4c, &4b, &4a, &97, &95, &ae, &bd, &b1, &af, &9f, &b3, &9d, &ae
    equb &cc, &ca, &cd, &3c, &3b, &3a, &39, &38, &37, &36, &35, &34, &33, &32, &31, &30
    equb &c7, &db, &ce, &c6, &de, &cf, &d3, &d6, &f6, &fd, &c7, &cc, &ce, &d6, &d3, &dc
    equb &1f, &61, &62, &63, &64, &45, &5e, &08, &17, &e6, &e2, &13, &64, &25, &66, &77
    equb &0f, &0e, &d2, &d3, &cb, &ca, &c9, &c8, &07, &06, &fb, &e6, &61, &60, &63, &62
    equb &a9, &88, &93, &92, &85, &94, &97, &96, &87, &89, &f4, &c8, &ce, &f3, &0a, &08
    equb &ef, &01, &02, &03, &07, &26, &05, &e4, &85, &04, &07, &06, &e1, &e0, &e3, &e2
    equb &b1, &b0, &b3, &bc, &b5, &b4, &bd, &d8, &28, &29, &2a, &d4, &3c, &3d, &7e, &3f
    equb &30, &31, &32, &c2, &25, &24, &a7, &a6, &2d, &3c, &2f, &c6, &39, &18, &1b, &3a
    equb &c0, &c1, &e0, &c3, &c4, &be, &c6, &c7, &58, &59, &15, &5f, &5b, &b2, &41, &48
    equb &a1, &a0, &a3, &52, &a5, &a4, &a7, &a6, &5d, &7c, &5f, &5e, &59, &78, &7b, &5a
    equb &de, &c3, &c0, &c1, &da, &e5, &98, &e5, &6b, &3a, &4a, &6b, &6c, &12, &11, &1f
    equb &81, &80, &73, &72, &75, &8a, &89, &74, &8d, &7c, &07, &7e, &89, &78, &83, &7a
    equb &52, &53, &70, &72, &54, &55, &56, &78, &b7, &89, &8a, &8c, &09, &ea, &ae, &70
    equb &73, &b2, &b1, &b0, &b7, &b5, &b6, &68, &9d, &9c, &8f, &8e, &89, &88, &8f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &97, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &ce, &c9, &cc, &cb, &e8, &f1, &b7, &b8, &49, &4d, &bc, &cb, &8b, &c9, &d8
    equb &c0, &c1, &1d, &14, &04, &05, &06, &07, &c8, &c9, &34, &29, &ae, &af, &ac, &ad
    equb &c6, &a7, &bc, &fd, &aa, &bb, &b8, &b9, &a8, &a6, &db, &e7, &e1, &dc, &25, &27
    equb &e0, &0e, &0d, &0c, &08, &29, &0a, &eb, &8a, &0b, &08, &09, &ee, &ef, &ec, &ed
    equb &9e, &9f, &9c, &93, &90, &9f, &92, &f7, &07, &06, &05, &fb, &13, &12, &51, &10
    equb &ff, &fe, &fd, &0d, &8a, &8b, &28, &09, &e2, &db, &e0, &09, &f6, &d7, &d4, &f5
    equb &6f, &6e, &4f, &6c, &6b, &11, &69, &68, &f7, &f6, &ba, &f8, &fc, &1d, &ee, &e7
    equb &2e, &2f, &2c, &dd, &2a, &2b, &28, &29, &d2, &73, &d0, &d1, &d6, &f7, &f4, &d5
    equb &71, &7c, &7f, &7e, &75, &4a, &37, &4a, &c4, &95, &e5, &c4, &c3, &bd, &be, &b8
    equb &4e, &4f, &bc, &bd, &ba, &45, &46, &bb, &42, &b3, &c8, &b1, &46, &37, &4c, &b5
    equb &7d, &7c, &5f, &5d, &5b, &7a, &79, &57, &98, &a6, &a5, &a3, &26, &c5, &81, &5f
    equb &7c, &bd, &be, &bf, &b8, &ba, &b9, &67, &92, &93, &80, &a1, &86, &87, &82, &6f
    equb &58, &61, &48, &79, &5c, &60, &49, &62, &7b, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &a8, &a9, &aa, &ab, &90, &99, &92, &9b, &9c, &95, &9e, &97, &98, &91, &9a, &93
    equb &84, &8d, &86, &8f, &80, &89, &82, &8b, &b0, &b1, &b2, &b3, &80, &89, &82, &8b
    equb &bc, &b5, &be, &b7, &b8, &b1, &ba, &b3, &b4, &bd, &b6, &bf, &b0, &b9, &b2, &bb
.level_7_original
    equb &ff, &00, &03, &06, &18, &1b, &04, &03, &02, &02, &07, &1d, &1e, &10, &1d, &1a
    equb &0d, &10, &14, &16, &12, &03, &03, &02, &1e, &0a, &13, &10, &11, &13, &00, &e0
    equb &df, &25, &25, &2d, &2a, &2b, &35, &31, &38, &39, &3a, &39, &38, &3e, &34, &30
    equb &2f, &15, &14, &14, &13, &15, &13, &11, &10, &17, &34, &35, &32, &33, &10, &c0
    equb &bf, &69, &6a, &6b, &6c, &6d, &6e, &6f, &60, &61, &62, &63, &65, &65, &67, &67
    equb &78, &79, &7a, &7b, &7c, &7d, &7f, &7e, &70, &71, &05, &04, &03, &02, &0f, &a0
    equb &9f, &6e, &61, &67, &61, &7d, &7f, &7d, &73, &75, &77, &75, &74, &74, &74, &74
    equb &6c, &6c, &6c, &7a, &7d, &8a, &7a, &60, &6f, &6e, &5e, &5f, &58, &59, &5a, &5b
    equb &a4, &a4, &a7, &a6, &a1, &a0, &a3, &a2, &a5, &a7, &75, &97, &91, &90, &93, &92
    equb &8d, &8c, &8f, &8e, &89, &88, &8b, &8a, &85, &84, &87, &86, &81, &81, &82, &60
    equb &5f, &a8, &bf, &b9, &bc, &bc, &bf, &bc, &b6, &b7, &b1, &bc, &b2, &b6, &b6, &b5
    equb &ad, &aa, &aa, &b2, &b5, &4a, &bf, &bb, &b4, &b5, &b5, &af, &ad, &a8, &af, &a9
    equb &d8, &db, &df, &d8, &db, &e4, &e5, &e6, &d4, &e9, &35, &34, &33, &32, &31, &30
    equb &c2, &cd, &d7, &c8, &d0, &d9, &c7, &cc, &de, &d0, &c8, &c1, &fd, &ff, &f6, &f5
    equb &1f, &61, &62, &63, &64, &65, &66, &67, &17, &97, &d6, &f3, &ec, &ed, &ee, &ef
    equb &0f, &f0, &f2, &f3, &f4, &f4, &f7, &f6, &07, &ec, &b3, &5a, &35, &ec, &bf, &fe
    equb &80, &c1, &e2, &f3, &f4, &e5, &c6, &87, &f7, &88, &8b, &8a, &8d, &8c, &8f, &f0
    equb &11, &12, &15, &1c, &1b, &12, &15, &16, &19, &18, &1b, &1a, &1d, &e2, &1f, &1e
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &d8, &28, &29, &2a, &2b, &34, &11, &50, &d0
    equb &31, &30, &33, &32, &35, &34, &37, &c8, &39, &38, &3b, &3a, &3d, &3c, &3f, &3e
    equb &c1, &c0, &c3, &c2, &c5, &c4, &c7, &c6, &88, &89, &8a, &8b, &8c, &8d, &b2, &8f
    equb &50, &51, &52, &53, &54, &55, &69, &56, &59, &58, &5b, &5a, &5d, &5c, &5f, &5e
    equb &e1, &e0, &e3, &e2, &e5, &e4, &e7, &e6, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &71, &70, &73, &72, &75, &74, &77, &76, &79, &78, &7b, &7a, &83, &82, &7f, &7e
    equb &01, &00, &03, &02, &05, &05, &06, &78, &48, &49, &4a, &4b, &4c, &cd, &ce, &70
    equb &91, &90, &93, &92, &95, &94, &97, &68, &99, &98, &9b, &9a, &9d, &9c, &9f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &ce, &cd, &cc, &8b, &ca, &c9, &88, &b8, &38, &79, &5c, &43, &42, &41, &40
    equb &c0, &3f, &3d, &3c, &3b, &3b, &38, &39, &c8, &23, &7c, &95, &fa, &23, &70, &31
    equb &af, &ee, &cd, &dc, &db, &ca, &ed, &a8, &d8, &85, &a4, &a5, &a2, &83, &de, &df
    equb &1e, &1d, &1a, &13, &14, &1d, &1a, &19, &16, &17, &14, &15, &12, &ed, &1a, &11
    equb &8f, &8e, &8d, &ac, &8b, &8a, &81, &f7, &33, &06, &05, &04, &1b, &3e, &7f, &ff
    equb &fe, &ff, &fe, &fd, &da, &fb, &f8, &07, &f6, &f7, &f4, &f1, &f2, &f3, &f0, &f1
    equb &6e, &6f, &6c, &6d, &6a, &6b, &68, &69, &27, &26, &25, &24, &23, &22, &1d, &20
    equb &df, &de, &cd, &dc, &db, &da, &e6, &dd, &d6, &d7, &d4, &d5, &d2, &d3, &d0, &d5
    equb &4e, &4f, &4c, &4d, &0a, &4b, &4a, &4f, &07, &06, &05, &04, &03, &02, &01, &00
    equb &bc, &bf, &bc, &bd, &ba, &bf, &bc, &b9, &b6, &b7, &b4, &b5, &4c, &4d, &b0, &b1
    equb &2c, &2f, &2c, &2d, &2a, &2a, &29, &57, &67, &66, &65, &64, &63, &e2, &e1, &5f
    equb &9e, &9f, &9c, &9d, &9a, &9b, &88, &67, &96, &97, &94, &95, &92, &93, &92, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &bc, &b9, &be, &bb, &b8, &bd, &ba, &bf, &b8, &b9, &ba, &bb, &b4, &b1, &b6, &b3
    equb &a8, &ad, &aa, &af, &ac, &a9, &ae, &ab, &a8, &a9, &aa, &ab, &a8, &a1, &aa, &a3
    equb &94, &9d, &96, &9f, &90, &99, &92, &9b, &98, &99, &9a, &9b, &90, &95, &92, &97
.level_8_original
    equb &ff, &03, &0a, &12, &16, &1f, &1a, &19, &15, &08, &0f, &0d, &10, &0a, &00, &01
    equb &1b, &02, &09, &09, &01, &0f, &08, &13, &1c, &09, &01, &01, &1a, &03, &1f, &e0
    equb &df, &23, &21, &22, &26, &27, &24, &22, &2e, &25, &25, &24, &23, &39, &3a, &3a
    equb &27, &22, &22, &27, &2c, &2e, &2d, &12, &1e, &1f, &1b, &19, &17, &13, &12, &c0
    equb &bf, &21, &6a, &6b, &6c, &6c, &6f, &24, &2a, &1a, &62, &63, &65, &64, &66, &66
    equb &79, &7b, &7a, &7a, &07, &06, &05, &7e, &70, &71, &72, &73, &74, &75, &0f, &a0
    equb &9f, &64, &63, &6e, &71, &79, &7f, &6d, &79, &71, &77, &71, &6e, &6e, &6c, &67
    equb &7d, &61, &69, &60, &6a, &8a, &74, &73, &7a, &7b, &7e, &7d, &76, &74, &76, &75
    equb &8e, &97, &95, &98, &9d, &9f, &9f, &98, &a8, &ac, &75, &97, &91, &91, &92, &92
    equb &8c, &8d, &8f, &8e, &89, &89, &8a, &8a, &85, &85, &86, &86, &81, &81, &83, &60
    equb &5f, &a4, &a6, &af, &b0, &ae, &b6, &ac, &bc, &a1, &a9, &b9, &b7, &b7, &ad, &ab
    equb &a8, &aa, &b3, &b9, &b0, &4a, &bb, &af, &a4, &be, &b4, &a4, &b1, &a0, &bf, &bd
    equb &d2, &c9, &ca, &d5, &cd, &ce, &e4, &cd, &ee, &ed, &35, &34, &33, &32, &31, &30
    equb &c6, &d0, &cb, &d9, &d8, &c3, &cc, &da, &df, &d6, &ca, &c7, &fa, &fe, &fe, &f1
    equb &1f, &65, &66, &67, &1b, &65, &66, &66, &17, &ed, &ee, &ef, &13, &ed, &ee, &50
    equb &0f, &f5, &f6, &f7, &0b, &f5, &dd, &62, &07, &f8, &fb, &fa, &03, &bc, &bf, &be
    equb &81, &c0, &83, &82, &bb, &8c, &8f, &8e, &b7, &a8, &ab, &aa, &ad, &ac, &ae, &b0
    equb &91, &ee, &92, &93, &94, &eb, &14, &ed, &d9, &62, &25, &20, &3d, &3c, &3f, &3e
    equb &a9, &a9, &a2, &a3, &a4, &dd, &8e, &bf, &97, &96, &b2, &b3, &b4, &a5, &a6, &a0
    equb &ca, &cb, &38, &19, &1e, &2f, &3c, &4c, &19, &18, &1b, &04, &3d, &3c, &3f, &f6
    equb &c0, &c1, &c2, &bc, &c4, &c5, &c6, &c7, &cf, &ce, &ce, &cf, &19, &e7, &1b, &e5
    equb &21, &95, &52, &53, &a7, &47, &44, &45, &91, &10, &13, &06, &95, &5c, &5f, &22
    equb &e0, &e1, &b7, &b6, &b1, &b0, &b3, &98, &68, &69, &3f, &3e, &39, &38, &3b, &90
    equb &62, &61, &20, &23, &26, &25, &24, &88, &3d, &3c, &33, &2a, &1d, &3a, &7b, &82
    equb &7f, &05, &17, &56, &11, &50, &17, &78, &77, &cd, &df, &de, &d9, &d8, &9f, &70
    equb &6f, &d5, &c7, &c6, &c1, &c0, &87, &68, &65, &dc, &cf, &ce, &c9, &c8, &8f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &ca, &e9, &c8, &b4, &ca, &c9, &c9, &b8, &42, &41, &c0, &bc, &42, &41, &ff
    equb &c0, &7a, &19, &38, &c4, &3a, &12, &ad, &c8, &37, &1c, &35, &cc, &71, &74, &71
    equb &ae, &ef, &ac, &ad, &d4, &a3, &a0, &a7, &98, &87, &84, &85, &82, &83, &81, &9f
    equb &9e, &e1, &9d, &9c, &9b, &e4, &1b, &e2, &d6, &6d, &2a, &2f, &32, &33, &30, &39
    equb &86, &86, &8d, &8c, &8a, &f2, &a1, &90, &b8, &b9, &9d, &9c, &99, &88, &89, &9f
    equb &05, &04, &f7, &c6, &d1, &e0, &f3, &83, &c6, &d7, &d4, &cb, &d2, &f3, &f0, &39
    equb &6f, &6e, &6d, &13, &6b, &6a, &69, &68, &60, &61, &61, &60, &b6, &48, &b4, &4a
    equb &aa, &1a, &dd, &dc, &28, &c8, &cb, &ca, &1e, &9f, &9c, &ab, &1a, &d3, &d0, &ad
    equb &4f, &4e, &18, &19, &1e, &17, &14, &37, &c7, &c6, &90, &91, &96, &97, &94, &3f
    equb &ad, &ae, &ef, &ec, &e9, &ea, &6b, &47, &f2, &e3, &dc, &e5, &d2, &f5, &b4, &4d
    equb &50, &2a, &38, &7b, &7e, &7f, &38, &57, &58, &e2, &f0, &f1, &f6, &f7, &b0, &5f
    equb &60, &da, &c8, &c9, &ce, &cf, &88, &67, &6a, &d3, &c0, &c1, &c6, &c7, &82, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &94, &95, &96, &97, &90, &85, &92, &87, &9c, &b5, &b6, &9f, &98, &b1, &b2, &9b
    equb &84, &ad, &ae, &87, &80, &95, &82, &97, &8c, &8d, &8e, &8f, &9c, &89, &9e, &8b
    equb &b4, &b5, &9e, &9f, &b0, &b1, &9a, &9b, &bc, &bd, &96, &97, &ac, &b9, &ae, &bb
.level_9_original
    equb &ff, &12, &1f, &01, &05, &08, &08, &08, &0f, &1f, &1b, &11, &0d, &07, &05, &1d
    equb &02, &07, &0b, &09, &03, &00, &00, &0f, &1c, &1f, &15, &14, &0c, &01, &1d, &e0
    equb &df, &20, &20, &2a, &29, &2b, &28, &29, &3a, &3b, &3c, &3d, &30, &34, &32, &36
    equb &2e, &2f, &2b, &2d, &17, &11, &12, &12, &10, &12, &12, &12, &16, &13, &12, &c0
    equb &bf, &68, &69, &69, &6f, &16, &15, &14, &61, &61, &62, &62, &64, &2c, &67, &1c
    equb &79, &78, &31, &7a, &7c, &7d, &7e, &7f, &70, &73, &72, &04, &74, &75, &0f, &a0
    equb &9f, &77, &74, &79, &60, &60, &62, &62, &66, &7b, &64, &65, &78, &79, &7a, &7a
    equb &66, &66, &79, &7f, &67, &8a, &74, &73, &68, &63, &60, &65, &62, &60, &65, &5f
    equb &a5, &a2, &a6, &a6, &a2, &a3, &a0, &ab, &a5, &a3, &75, &96, &91, &90, &93, &92
    equb &8d, &8c, &8e, &8e, &88, &88, &8a, &8b, &84, &84, &87, &86, &80, &80, &82, &60
    equb &5f, &b7, &ab, &a2, &b4, &bb, &bf, &bc, &a9, &a1, &a0, &b7, &aa, &ab, &ab, &ac
    equb &b2, &b3, &a4, &b6, &b7, &4a, &9c, &94, &96, &b8, &a0, &ae, &9d, &b7, &90, &b5
    equb &d2, &c2, &c7, &c1, &c6, &c6, &c3, &c4, &c7, &ec, &35, &34, &33, &32, &31, &30
    equb &d1, &c8, &da, &c0, &dd, &cd, &d8, &ce, &df, &dd, &cd, &ce, &f8, &fd, &f0, &f4
    equb &1f, &61, &48, &77, &4e, &71, &4c, &72, &17, &19, &93, &d7, &f2, &e2, &ee, &10
    equb &0f, &f1, &0d, &0e, &f3, &11, &d6, &4c, &07, &e8, &2b, &ea, &ed, &ec, &ef, &22
    equb &ab, &94, &a9, &fc, &9b, &9a, &99, &be, &f7, &88, &8b, &8a, &8d, &92, &8e, &f0
    equb &ab, &aa, &a9, &a8, &af, &ae, &16, &ac, &c5, &c4, &c7, &c6, &c1, &c0, &1f, &c2
    equb &90, &87, &96, &86, &90, &82, &97, &86, &d7, &6e, &7c, &ff, &7d, &72, &6c, &55
    equb &8b, &00, &53, &f2, &b5, &34, &37, &36, &c5, &a4, &bf, &be, &39, &38, &3b, &1a
    equb &e1, &e0, &fd, &e3, &e4, &e5, &f9, &e7, &32, &4b, &b4, &48, &4e, &4f, &b0, &4d
    equb &51, &00, &03, &ac, &54, &55, &03, &75, &15, &cc, &7f, &a6, &59, &58, &0b, &7a
    equb &c3, &c3, &c0, &d3, &dc, &c9, &c0, &c4, &92, &63, &c1, &cb, &cc, &2a, &6a, &6b
    equb &70, &71, &8d, &7b, &7c, &bd, &31, &37, &7d, &7c, &87, &7e, &39, &38, &bb, &3a
    equb &21, &23, &26, &2b, &24, &3a, &06, &78, &0c, &4d, &ee, &bf, &98, &72, &8e, &70
    equb &ef, &81, &82, &83, &84, &6a, &96, &68, &5d, &9c, &9f, &9e, &99, &60, &9f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &ce, &e7, &d8, &e1, &de, &e3, &dd, &b8, &b6, &3c, &78, &5d, &4d, &41, &bf
    equb &c0, &2e, &c2, &c1, &3c, &de, &19, &83, &c8, &27, &e0, &25, &22, &23, &20, &ed
    equb &84, &9b, &86, &d3, &b4, &f5, &b6, &91, &d8, &a7, &a4, &a5, &a2, &bd, &a6, &df
    equb &a4, &a5, &a6, &a7, &a0, &a1, &19, &a3, &ca, &cb, &c8, &c9, &ce, &cf, &10, &cd
    equb &bf, &a8, &b8, &a9, &bf, &ad, &b8, &a9, &f8, &41, &53, &d0, &52, &5d, &43, &7a
    equb &44, &cf, &9e, &3d, &7a, &fb, &b8, &f9, &0a, &6b, &70, &71, &f6, &f7, &d4, &d5
    equb &4e, &4f, &52, &4c, &0b, &4a, &56, &48, &9d, &c4, &1b, &e7, &f1, &e0, &1f, &e2
    equb &de, &af, &8c, &23, &db, &da, &ae, &fa, &9a, &03, &f0, &29, &d6, &d7, &a4, &f5
    equb &6c, &6c, &6f, &7c, &73, &66, &6f, &6b, &3d, &cc, &6e, &64, &63, &85, &c5, &c4
    equb &bf, &be, &42, &b5, &b5, &72, &fe, &f8, &b2, &b3, &48, &b1, &f6, &77, &74, &f5
    equb &06, &0c, &09, &06, &1b, &15, &29, &57, &22, &63, &c1, &90, &b7, &5d, &a1, &5f
    equb &e0, &8e, &0d, &8c, &8b, &65, &99, &67, &52, &93, &90, &91, &96, &6f, &98, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &81, &82, &81, &81, &87, &86, &85, &84, &9a, &a8, &98, &aa, &9e, &8e, &8d, &ae
    equb &82, &92, &91, &b2, &97, &87, &b7, &94, &9b, &8b, &bb, &98, &8e, &9e, &9d, &be
    equb &b2, &a2, &a1, &82, &b6, &84, &b4, &86, &ab, &aa, &a9, &a8, &ad, &ae, &ad, &ad
.level_10_original
    equb &ff, &03, &08, &11, &1e, &07, &0c, &15, &12, &0b, &00, &19, &16, &0f, &04, &1d
    equb &0a, &13, &18, &01, &0e, &17, &1c, &05, &02, &e6, &e5, &e4, &e3, &e2, &00, &e0
    equb &df, &23, &20, &21, &26, &2f, &2c, &2d, &22, &3b, &38, &39, &3e, &37, &34, &35
    equb &2a, &13, &10, &11, &16, &1f, &1c, &1d, &12, &c6, &c5, &c4, &c3, &c2, &10, &c0
    equb &bf, &69, &6a, &6b, &6c, &6d, &6e, &6f, &60, &61, &62, &63, &64, &65, &66, &67
    equb &78, &79, &7a, &7b, &7c, &7d, &7e, &7f, &70, &a6, &a5, &a4, &a3, &a2, &0f, &a0
    equb &9f, &9e, &9d, &9c, &9b, &9a, &99, &98, &97, &96, &95, &94, &93, &92, &91, &90
    equb &8f, &8e, &8d, &8c, &8b, &8a, &89, &88, &87, &86, &85, &84, &83, &82, &81, &80
    equb &7f, &7e, &7d, &7c, &7b, &7a, &79, &78, &77, &76, &75, &74, &73, &72, &71, &70
    equb &6f, &6e, &6d, &6c, &6b, &6a, &69, &68, &67, &66, &65, &64, &63, &62, &61, &60
    equb &5f, &5e, &5d, &5c, &5b, &5a, &59, &58, &57, &56, &55, &54, &53, &52, &51, &50
    equb &4f, &4e, &4d, &4c, &4b, &4a, &49, &48, &47, &46, &45, &44, &43, &42, &41, &40
    equb &3f, &3e, &3d, &3c, &3b, &3a, &39, &38, &37, &36, &35, &34, &33, &32, &31, &30
    equb &d5, &cc, &df, &d6, &c1, &d8, &cb, &da, &d0, &d1, &ca, &c3, &c4, &fd, &fe, &f7
    equb &1f, &60, &63, &62, &64, &65, &66, &16, &17, &68, &6b, &6a, &ec, &ed, &ee, &1e
    equb &0f, &70, &73, &72, &f4, &f5, &f6, &06, &07, &78, &7b, &7a, &fd, &fc, &ff, &0e
    equb &f1, &80, &83, &82, &84, &85, &86, &f6, &f9, &88, &8b, &8a, &0c, &0d, &0e, &fe
    equb &e1, &90, &93, &92, &14, &15, &16, &e6, &e9, &98, &9b, &9a, &1d, &1c, &1f, &ee
    equb &d1, &a0, &a3, &a2, &a4, &a5, &a6, &d6, &d9, &a8, &ab, &aa, &2c, &2d, &2e, &de
    equb &c1, &b0, &b3, &b2, &34, &35, &36, &c6, &c9, &b8, &bb, &ba, &3d, &3c, &3f, &ce
    equb &b1, &c0, &c3, &c2, &c4, &c5, &c6, &b6, &b9, &c8, &cb, &ca, &4c, &4d, &4e, &be
    equb &a1, &d0, &d3, &d2, &54, &55, &56, &a6, &a9, &d8, &db, &da, &5d, &5c, &5f, &ae
    equb &91, &e0, &e3, &e2, &e4, &e5, &e6, &96, &99, &e8, &eb, &ea, &6c, &6d, &6e, &9e
    equb &81, &f0, &f3, &f2, &74, &75, &76, &86, &89, &f8, &fb, &fa, &7d, &7c, &7f, &8e
    equb &71, &00, &03, &02, &04, &05, &06, &78, &79, &08, &0b, &0a, &8c, &8d, &8e, &70
    equb &61, &10, &13, &12, &94, &95, &96, &68, &69, &18, &1b, &1a, &9d, &9c, &9f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &cf, &ec, &cd, &cb, &ca, &c9, &b9, &b8, &c7, &e4, &c5, &43, &42, &41, &b1
    equb &c0, &bf, &9c, &bd, &3b, &3a, &39, &c9, &c8, &b7, &94, &b5, &32, &33, &30, &c1
    equb &de, &af, &8c, &ad, &ab, &aa, &a9, &d9, &d6, &a7, &84, &a5, &23, &22, &21, &d1
    equb &ee, &9f, &bc, &9d, &1b, &1a, &19, &e9, &e6, &97, &b4, &95, &12, &13, &10, &e1
    equb &fe, &8f, &ac, &8d, &8b, &8a, &89, &f9, &f6, &87, &a4, &85, &03, &02, &01, &f1
    equb &0e, &7f, &5c, &7d, &fb, &fa, &f9, &09, &06, &77, &54, &75, &f2, &f3, &f0, &01
    equb &1e, &6f, &4c, &6d, &6b, &6a, &69, &19, &16, &67, &44, &65, &e3, &e2, &e1, &11
    equb &2e, &5f, &7c, &5d, &db, &da, &d9, &29, &26, &57, &74, &55, &d2, &d3, &d0, &21
    equb &3e, &4f, &6c, &4d, &4b, &4a, &49, &39, &36, &47, &64, &45, &c3, &c2, &c1, &31
    equb &4e, &3f, &1c, &3d, &bb, &ba, &b9, &49, &46, &37, &14, &35, &b2, &b3, &b0, &41
    equb &5e, &2f, &0c, &2d, &2b, &2a, &29, &57, &56, &27, &04, &25, &a3, &a2, &a1, &5f
    equb &6e, &1f, &3c, &1d, &9b, &9a, &99, &67, &66, &17, &34, &15, &92, &93, &92, &6f
    equb &60, &41, &53, &60, &6e, &45, &56, &75, &77, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &9c, &9d, &9e, &9f, &88, &89, &8a, &8b, &a4, &b5, &96, &a7, &a0, &b1, &92, &a3
    equb &9c, &9d, &9e, &9f, &a8, &89, &aa, &8b, &a4, &85, &a6, &87, &90, &91, &92, &93
    equb &bc, &8d, &9e, &bf, &b8, &89, &9a, &bb, &a4, &a5, &a6, &a7, &80, &81, &82, &83
.level_11_original
    equb &ff, &05, &11, &02, &07, &19, &1a, &03, &06, &00, &17, &1f, &18, &13, &0f, &09
    equb &15, &1a, &18, &19, &1d, &1d, &13, &16, &06, &02, &04, &03, &06, &04, &13, &e0
    equb &df, &22, &25, &2a, &2f, &28, &29, &30, &3a, &3c, &3d, &31, &30, &36, &0f, &0b
    equb &15, &11, &13, &16, &12, &12, &1f, &1a, &10, &10, &13, &11, &16, &13, &2f, &c0
    equb &bf, &69, &6a, &6b, &6c, &6c, &24, &25, &28, &62, &62, &63, &64, &65, &66, &67
    equb &78, &78, &7b, &30, &37, &36, &37, &7e, &73, &71, &09, &72, &74, &75, &0f, &a0
    equb &9f, &73, &78, &67, &6c, &6a, &60, &70, &79, &7e, &69, &62, &76, &6e, &6d, &64
    equb &67, &72, &7b, &61, &8b, &8a, &72, &76, &75, &73, &76, &6a, &6e, &6b, &68, &60
    equb &9d, &9b, &a1, &a4, &a1, &a3, &ad, &a9, &a3, &76, &75, &97, &90, &90, &92, &93
    equb &8d, &8c, &8f, &8e, &89, &89, &8a, &8a, &85, &85, &87, &86, &80, &81, &61, &60
    equb &5f, &b8, &a9, &ae, &a8, &a9, &a2, &be, &b4, &ba, &bf, &bd, &ae, &ba, &b7, &a6
    equb &a3, &b5, &a1, &a0, &4b, &4a, &b8, &b6, &a3, &b2, &b6, &b7, &bd, &a5, &ba, &bb
    equb &ec, &e8, &c6, &c0, &d0, &cd, &c9, &dc, &ed, &36, &35, &34, &33, &32, &31, &30
    equb &db, &c4, &c5, &c3, &d7, &c2, &db, &cd, &dc, &d5, &ce, &c6, &f9, &fd, &f6, &f3
    equb &1f, &1c, &1a, &13, &04, &25, &64, &67, &17, &26, &6d, &e9, &6c, &ed, &91, &10
    equb &0f, &6e, &ed, &cc, &d4, &ca, &16, &17, &07, &5e, &5d, &5c, &db, &1a, &f9, &80
    equb &89, &80, &a2, &82, &85, &fa, &86, &87, &f7, &90, &93, &8a, &8d, &94, &97, &f0
    equb &f0, &f1, &ee, &ef, &14, &e9, &ea, &eb, &67, &66, &65, &64, &63, &1c, &1f, &1e
    equb &a0, &de, &e2, &f3, &ec, &ed, &f6, &e7, &17, &d1, &13, &52, &93, &92, &51, &11
    equb &cc, &2d, &2d, &2d, &8a, &8b, &c9, &37, &39, &38, &c5, &c4, &c3, &c2, &c1, &4e
    equb &bf, &be, &bd, &bc, &c5, &c5, &c7, &b8, &b6, &b7, &b4, &8b, &8c, &0d, &8e, &8f
    equb &58, &51, &64, &5b, &62, &55, &5e, &17, &29, &38, &7b, &3a, &3d, &2c, &2f, &20
    equb &e1, &e0, &e3, &9c, &e5, &e4, &e7, &98, &a8, &a9, &95, &94, &93, &7c, &7f, &4e
    equb &90, &91, &92, &97, &9c, &95, &89, &89, &07, &06, &05, &04, &03, &02, &83, &8e
    equb &01, &00, &03, &7c, &05, &04, &06, &78, &c9, &78, &7b, &7b, &7d, &7c, &cf, &70
    equb &6e, &6f, &62, &b3, &6c, &69, &68, &68, &6d, &7c, &9f, &9a, &9d, &9e, &99, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &b3, &b5, &b4, &ab, &8a, &cb, &c8, &b8, &89, &c2, &46, &c3, &42, &3e, &bf
    equb &c0, &a1, &22, &03, &1b, &05, &d9, &c8, &c8, &91, &92, &93, &14, &d5, &36, &4f
    equb &a6, &ef, &8d, &bd, &aa, &d5, &a9, &a8, &d8, &bf, &bc, &a5, &a2, &bb, &b8, &df
    equb &ff, &fe, &e1, &e0, &1b, &e6, &e5, &e4, &68, &69, &6a, &6b, &6c, &1b, &10, &19
    equb &8f, &f1, &cd, &dc, &c3, &c2, &d9, &c0, &38, &fa, &3e, &7d, &bc, &fd, &7e, &3e
    equb &03, &e2, &e2, &e2, &45, &44, &06, &f8, &f6, &f7, &0a, &0b, &0c, &0d, &0e, &85
    equb &10, &11, &12, &13, &6a, &6a, &68, &17, &19, &18, &1b, &24, &23, &a2, &21, &20
    equb &d7, &de, &e3, &d4, &e5, &da, &d1, &98, &a6, &b7, &f4, &b7, &b2, &a3, &a0, &af
    equb &4e, &0f, &4c, &33, &48, &4f, &48, &37, &17, &26, &3a, &3b, &3c, &f3, &90, &61
    equb &5f, &5e, &5d, &58, &53, &5a, &46, &46, &c8, &c9, &ca, &cb, &cc, &cd, &4c, &4d
    equb &2e, &2b, &2c, &53, &2a, &6b, &29, &57, &e6, &57, &54, &54, &52, &53, &e0, &5f
    equb &61, &60, &6d, &bc, &63, &66, &67, &67, &60, &61, &30, &95, &92, &91, &d6, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &8f, &8a, &8d, &84, &87, &8a, &89, &88, &87, &96, &a5, &80, &83, &a2, &85, &80
    equb &8f, &9e, &9d, &94, &8b, &8a, &99, &90, &8f, &96, &9d, &9c, &83, &92, &91, &98
    equb &af, &8e, &a9, &ac, &a3, &ae, &a1, &a8, &a7, &a6, &a5, &a8, &a7, &a2, &a1, &a0
.level_12_original
    equb &c6, &1b, &11, &08, &0b, &03, &1a, &1e, &1b, &03, &09, &0a, &15, &16, &1d, &04
    equb &1c, &12, &00, &1e, &1e, &17, &0b, &05, &1b, &1a, &00, &0e, &0e, &1b, &0b, &e0
    equb &df, &0a, &0c, &08, &0c, &0b, &03, &07, &0e, &08, &0c, &08, &31, &37, &35, &33
    equb &2b, &2f, &27, &27, &20, &21, &39, &3d, &36, &30, &3e, &3e, &3d, &3e, &2c, &c0
    equb &bf, &12, &69, &10, &6c, &1a, &6f, &6f, &1b, &63, &62, &18, &64, &12, &1d, &67
    equb &78, &0e, &79, &32, &0b, &06, &7c, &7f, &71, &70, &05, &08, &0f, &02, &0f, &a0
    equb &9f, &78, &7b, &7d, &79, &76, &60, &61, &6a, &68, &69, &71, &76, &7e, &67, &6e
    equb &72, &8e, &8d, &8c, &8b, &8a, &5a, &5c, &51, &50, &57, &57, &57, &57, &54, &5e
    equb &8c, &8a, &8f, &80, &86, &84, &79, &78, &77, &76, &75, &97, &90, &90, &93, &92
    equb &8c, &8d, &8f, &8e, &88, &88, &8b, &8a, &85, &84, &86, &64, &63, &62, &61, &60
    equb &5f, &bd, &bf, &be, &b8, &b9, &a2, &a4, &b9, &ba, &a3, &a9, &ad, &a9, &af, &b1
    equb &ae, &4e, &4d, &4c, &4b, &4a, &bc, &bd, &b1, &b0, &94, &95, &91, &af, &b0, &bb
    equb &ee, &ec, &e3, &c2, &e2, &e2, &39, &38, &37, &36, &35, &34, &33, &32, &31, &30
    equb &ce, &c2, &c7, &df, &df, &d8, &d0, &d9, &f6, &f2, &f9, &c7, &c7, &cc, &d4, &dc
    equb &1f, &41, &22, &66, &63, &62, &79, &78, &17, &e9, &ea, &0e, &4b, &0a, &09, &08
    equb &0f, &f1, &d2, &0a, &0d, &0e, &0f, &0e, &07, &f8, &fb, &1a, &3d, &1c, &1f, &00
    equb &9f, &8e, &9f, &83, &84, &9a, &89, &98, &ef, &88, &8b, &0b, &0c, &8c, &8f, &e8
    equb &e9, &e8, &cb, &13, &14, &ea, &f9, &e8, &e7, &f8, &fb, &3a, &3d, &fc, &ff, &e4
    equb &bf, &be, &bd, &bc, &fb, &ba, &b9, &b8, &cf, &ca, &cd, &cc, &ef, &ca, &c9, &c8
    equb &cf, &b0, &b3, &b2, &b5, &b4, &b7, &c8, &c7, &c6, &c5, &c4, &c3, &c2, &c1, &c0
    equb &df, &de, &dd, &c3, &c4, &da, &c9, &d8, &af, &c8, &cb, &4b, &4c, &cc, &cf, &a8
    equb &af, &ae, &ad, &53, &44, &aa, &a9, &a8, &a7, &a6, &b5, &5a, &5d, &e4, &a7, &a6
    equb &ff, &f6, &fd, &dc, &fb, &fa, &e9, &f8, &8f, &ae, &8d, &8b, &8c, &92, &91, &90
    equb &8f, &b1, &b2, &78, &7b, &ba, &99, &b8, &c1, &78, &7b, &82, &85, &8c, &87, &86
    equb &1f, &1e, &7d, &01, &06, &06, &07, &78, &76, &75, &76, &8b, &9c, &71, &72, &70
    equb &5f, &90, &93, &93, &94, &ac, &bf, &68, &61, &66, &7b, &da, &fd, &7c, &7f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &ee, &8d, &cb, &cc, &cd, &d6, &d7, &b8, &46, &45, &a1, &e4, &a5, &a6, &a7
    equb &c0, &1e, &1d, &c5, &c2, &c5, &c0, &c1, &c8, &37, &34, &d5, &d2, &d3, &d0, &cf
    equb &b0, &b1, &b0, &ac, &ab, &b5, &b6, &b7, &c0, &a7, &a4, &24, &23, &a3, &a0, &c7
    equb &e6, &e7, &e4, &1c, &1b, &e5, &f6, &e7, &e8, &f7, &f4, &35, &32, &f3, &f0, &ef
    equb &90, &91, &92, &93, &f4, &95, &96, &97, &e0, &e5, &e2, &e3, &e4, &e5, &e6, &e7
    equb &00, &7f, &78, &7d, &7a, &5b, &78, &07, &08, &09, &0a, &0b, &0c, &0d, &0e, &0f
    equb &70, &71, &72, &6c, &6b, &75, &76, &77, &00, &67, &64, &ec, &f3, &63, &60, &07
    equb &20, &21, &22, &cc, &cb, &25, &26, &27, &28, &29, &2a, &d5, &d2, &2b, &28, &29
    equb &50, &59, &52, &33, &54, &55, &56, &57, &20, &21, &22, &24, &23, &3d, &3e, &3f
    equb &40, &7e, &7d, &b7, &b4, &75, &46, &77, &4e, &b7, &b4, &4d, &4a, &4b, &48, &49
    equb &30, &31, &52, &2e, &29, &29, &2a, &57, &58, &5a, &59, &b4, &b3, &5e, &5d, &5f
    equb &50, &9f, &9c, &9c, &9b, &a3, &a0, &67, &6e, &69, &74, &f5, &f2, &73, &70, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &8f, &9d, &ae, &8c, &8a, &a9, &9a, &8a, &86, &a5, &96, &86, &90, &81, &82, &a3
    equb &8c, &9d, &9e, &bf, &b8, &99, &9a, &8b, &b4, &95, &96, &87, &80, &91, &92, &b3
    equb &bc, &ad, &ae, &8f, &aa, &89, &ba, &aa, &a6, &85, &b6, &a6, &a3, &b1, &82, &a0
.level_13_original
    equb &ff, &03, &0a, &11, &17, &17, &1b, &1d, &09, &1f, &17, &0a, &03, &03, &1b, &0d
    equb &17, &1e, &1d, &09, &08, &10, &1c, &19, &12, &00, &07, &1a, &1d, &10, &1f, &e0
    equb &df, &27, &21, &22, &25, &27, &22, &21, &22, &27, &23, &3c, &3e, &3e, &3b, &36
    equb &2e, &2b, &2f, &28, &28, &15, &16, &12, &1f, &18, &19, &12, &10, &13, &18, &c0
    equb &bf, &12, &11, &20, &6c, &6d, &6f, &6f, &63, &61, &19, &62, &2c, &65, &64, &10
    equb &03, &79, &7b, &7b, &7f, &06, &7e, &7f, &38, &70, &70, &72, &74, &0e, &0f, &a0
    equb &9f, &66, &72, &76, &71, &7e, &68, &69, &7c, &77, &6e, &77, &74, &76, &68, &67
    equb &78, &63, &76, &7a, &66, &8a, &75, &76, &7a, &73, &74, &6f, &6b, &6d, &6b, &66
    equb &98, &9d, &9d, &a7, &a4, &a1, &a0, &ab, &a4, &a5, &75, &97, &90, &90, &92, &92
    equb &8d, &8c, &8e, &8e, &88, &88, &8a, &8a, &85, &85, &87, &86, &80, &81, &83, &60
    equb &5f, &b1, &b7, &b8, &ba, &bc, &a5, &ba, &bf, &ad, &ba, &b5, &b2, &b8, &bc, &a5
    equb &a7, &b0, &bb, &a0, &a7, &4a, &97, &ab, &aa, &99, &91, &91, &bf, &90, &ae, &a5
    equb &da, &dc, &d8, &ce, &c1, &c6, &cf, &e5, &ec, &ea, &35, &34, &33, &32, &31, &30
    equb &df, &d5, &cc, &c6, &c6, &d0, &c0, &c9, &de, &d3, &d6, &c3, &c0, &f0, &f5, &f6
    equb &1f, &60, &63, &62, &65, &24, &67, &10, &17, &69, &6a, &e4, &63, &6d, &6e, &10
    equb &0f, &79, &7c, &11, &0b, &e5, &e7, &67, &07, &f8, &fb, &02, &75, &f4, &77, &d6
    equb &f7, &81, &82, &83, &f3, &85, &8e, &93, &f7, &08, &f7, &8e, &a9, &b0, &8f, &f0
    equb &8e, &95, &96, &ec, &94, &9d, &96, &ee, &31, &52, &13, &f2, &55, &54, &67, &5e
    equb &82, &a1, &db, &aa, &ad, &ac, &af, &ae, &28, &36, &da, &db, &d3, &2d, &2e, &10
    equb &38, &f9, &7d, &7b, &f8, &3d, &3a, &ff, &79, &6c, &f3, &6e, &7d, &42, &3f, &3e
    equb &c9, &c8, &cb, &ca, &cc, &cd, &ce, &bd, &68, &59, &42, &4f, &ce, &8f, &6c, &1d
    equb &18, &19, &1a, &1f, &1c, &19, &1e, &1f, &65, &be, &db, &da, &dd, &dc, &b9, &62
    equb &e8, &e4, &d0, &da, &db, &d9, &d9, &98, &e3, &61, &79, &4f, &a4, &7d, &0e, &30
    equb &be, &71, &bd, &3b, &3c, &3d, &0e, &74, &79, &78, &7f, &fa, &3d, &5c, &6f, &b6
    equb &7e, &07, &06, &0f, &0c, &0d, &0e, &78, &c9, &c8, &f6, &cf, &cb, &c9, &ce, &70
    equb &92, &6f, &92, &93, &6b, &95, &96, &68, &91, &90, &93, &82, &6d, &9c, &9f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &cf, &cc, &cd, &ca, &8b, &e8, &bf, &b8, &c6, &c5, &cb, &cc, &c2, &c1, &bf
    equb &c0, &86, &93, &de, &c4, &2a, &28, &a8, &c8, &37, &34, &cd, &be, &3b, &98, &19
    equb &d8, &ae, &ed, &ac, &dc, &aa, &a1, &bc, &d8, &27, &d8, &a1, &86, &9f, &a0, &df
    equb &81, &9a, &99, &e3, &9b, &92, &9b, &e1, &3e, &59, &1c, &fd, &5a, &5b, &68, &51
    equb &ad, &8e, &f4, &85, &82, &83, &80, &c1, &07, &19, &f4, &f6, &fc, &02, &01, &3f
    equb &f7, &36, &b2, &b4, &37, &f6, &f5, &30, &b6, &a3, &3c, &a1, &b2, &8d, &f0, &f1
    equb &66, &47, &64, &65, &63, &62, &60, &12, &c7, &f6, &ec, &e0, &61, &21, &c3, &b2
    equb &97, &96, &95, &90, &93, &96, &91, &90, &ea, &31, &54, &75, &5a, &53, &36, &ed
    equb &43, &4b, &7f, &75, &74, &76, &36, &37, &6c, &ce, &d6, &e0, &0b, &d0, &a1, &bf
    equb &71, &be, &72, &f4, &f3, &f2, &c1, &bb, &b6, &f7, &b0, &31, &f2, &93, &a0, &79
    equb &51, &68, &29, &20, &63, &22, &21, &57, &e6, &e7, &d9, &e0, &e4, &e6, &e5, &5f
    equb &9d, &60, &9d, &9c, &64, &9a, &99, &67, &9e, &9f, &9c, &8d, &62, &93, &90, &6f
    equb &60, &41, &53, &60, &6e, &45, &56, &75, &77, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &86, &8d, &84, &8f, &8d, &86, &8f, &84, &81, &8a, &83, &88, &8a, &81, &88, &83
    equb &9c, &97, &9e, &95, &97, &9c, &95, &9e, &9b, &90, &99, &92, &90, &9b, &92, &99
    equb &a9, &ad, &ab, &af, &a2, &a6, &a0, &a4, &ae, &aa, &ac, &a8, &a5, &a1, &a7, &a3
.level_14_original
    equb &ff, &14, &15, &16, &11, &13, &12, &11, &1d, &15, &0f, &11, &12, &00, &07, &14
    equb &0a, &0a, &0e, &0b, &0a, &0d, &08, &0f, &06, &01, &03, &09, &1d, &1f, &0b, &e0
    equb &df, &20, &23, &27, &21, &20, &20, &21, &2f, &2b, &21, &23, &21, &3d, &3f, &3e
    equb &24, &25, &26, &26, &21, &23, &20, &20, &2f, &25, &26, &1d, &12, &13, &38, &c0
    equb &bf, &12, &11, &10, &17, &16, &15, &14, &60, &62, &61, &62, &67, &1e, &1d, &2f
    equb &78, &79, &7a, &00, &07, &06, &05, &04, &0b, &71, &72, &70, &3f, &3f, &0f, &a0
    equb &9f, &6a, &71, &70, &77, &7b, &68, &64, &62, &75, &62, &78, &68, &6c, &66, &67
    equb &78, &8e, &8d, &8c, &8b, &8a, &79, &7d, &74, &77, &71, &6c, &60, &61, &67, &5d
    equb &a4, &a8, &ae, &a9, &a9, &ab, &79, &78, &77, &76, &75, &96, &90, &91, &92, &92
    equb &8c, &8c, &8f, &8f, &88, &89, &8b, &8a, &84, &85, &86, &64, &63, &62, &61, &60
    equb &5f, &aa, &ac, &ae, &a8, &bb, &a5, &ae, &aa, &a6, &bb, &b6, &a8, &aa, &af, &b8
    equb &ae, &4e, &4d, &4c, &4b, &4a, &bd, &b6, &b9, &b8, &b0, &ac, &a9, &9b, &9b, &91
    equb &ca, &e3, &c0, &e9, &da, &db, &39, &38, &37, &36, &35, &34, &33, &32, &31, &30
    equb &d2, &c0, &d9, &c2, &d1, &de, &c4, &ce, &d0, &d0, &cd, &c0, &fc, &f4, &f7, &f1
    equb &1f, &61, &62, &63, &6b, &6d, &6e, &6e, &17, &f9, &f5, &eb, &13, &ed, &ee, &10
    equb &0f, &f1, &0d, &f3, &04, &ed, &e6, &65, &07, &f8, &7b, &7a, &7d, &02, &7f, &7c
    equb &89, &88, &8b, &8a, &8d, &8c, &8f, &8e, &f7, &f6, &f5, &ec, &eb, &e2, &e1, &f0
    equb &80, &8e, &82, &8c, &84, &8a, &86, &88, &9d, &90, &0b, &fc, &19, &f8, &09, &90
    equb &a8, &a9, &fd, &a2, &a5, &a4, &9f, &a0, &68, &2d, &d5, &28, &2f, &2f, &2c, &2d
    equb &2f, &2e, &cd, &cc, &cb, &35, &36, &37, &bf, &ba, &bb, &c4, &fb, &3c, &3f, &3e
    equb &f9, &c0, &c3, &c2, &bb, &c5, &c6, &c7, &4a, &4b, &48, &49, &b2, &4f, &4c, &4d
    equb &6f, &71, &72, &7c, &74, &7a, &76, &77, &a7, &50, &53, &b2, &75, &b4, &57, &56
    equb &a0, &e1, &e2, &e3, &9b, &e5, &e6, &e7, &7a, &97, &f8, &e8, &e6, &ef, &ec, &fd
    equb &4f, &4e, &4d, &8c, &27, &26, &25, &07, &81, &80, &e3, &42, &8d, &9c, &b3, &62
    equb &00, &7e, &22, &0b, &64, &15, &0e, &78, &0a, &0b, &09, &08, &73, &0d, &0e, &70
    equb &90, &92, &6d, &6c, &6b, &95, &96, &68, &9d, &6c, &7f, &5e, &15, &9e, &9f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &ce, &cd, &cc, &c4, &c2, &c1, &c1, &b8, &56, &5a, &44, &bc, &42, &41, &bf
    equb &c0, &3b, &c2, &3c, &cf, &24, &27, &ae, &c8, &37, &bc, &b5, &b2, &cd, &b0, &b3
    equb &a6, &a7, &a4, &a1, &a2, &a3, &a0, &a1, &d8, &d9, &da, &c3, &c4, &cd, &ce, &df
    equb &8f, &81, &8d, &83, &8b, &85, &89, &87, &b2, &9f, &04, &f3, &16, &f5, &06, &9f
    equb &87, &86, &d2, &8d, &8a, &8b, &b0, &8f, &43, &42, &fa, &07, &00, &00, &03, &02
    equb &e0, &e1, &02, &03, &04, &fa, &f9, &f8, &70, &65, &74, &0b, &0c, &71, &72, &73
    equb &56, &6f, &6c, &6d, &14, &6a, &69, &68, &e5, &e4, &e7, &e6, &1d, &e0, &e3, &e2
    equb &e0, &fe, &fd, &f3, &fb, &f5, &f9, &f8, &28, &df, &dc, &3d, &3a, &3b, &d8, &d9
    equb &0f, &4e, &4d, &4c, &34, &4a, &49, &48, &d5, &38, &57, &47, &49, &40, &43, &52
    equb &80, &81, &82, &43, &e8, &e9, &ca, &c8, &4e, &4f, &2c, &8d, &42, &53, &7c, &ad
    equb &2f, &51, &0d, &24, &4b, &3a, &41, &57, &25, &24, &26, &27, &5c, &22, &21, &5f
    equb &9f, &9d, &62, &63, &64, &9a, &99, &67, &92, &63, &70, &51, &1a, &91, &90, &6f
    equb &60, &41, &53, &60, &6e, &45, &56, &75, &77, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &84, &8d, &86, &8f, &9c, &b5, &9e, &b7, &90, &b9, &92, &bb, &88, &81, &8a, &83
    equb &9c, &95, &9e, &97, &a4, &8d, &a6, &8f, &a8, &81, &aa, &83, &90, &99, &92, &9b
    equb &a4, &ad, &a6, &af, &bc, &95, &be, &97, &b0, &99, &b2, &9b, &a8, &a1, &aa, &a3
.level_15_original
    equb &ff, &04, &08, &09, &1c, &08, &03, &02, &03, &1d, &1c, &17, &05, &1b, &1b, &15
    equb &12, &14, &10, &16, &15, &10, &1a, &1a, &19, &15, &02, &07, &00, &e2, &1b, &e0
    equb &df, &22, &26, &24, &22, &29, &33, &31, &38, &3a, &3d, &3c, &35, &35, &30, &35
    equb &11, &10, &11, &10, &12, &13, &10, &11, &16, &14, &13, &12, &16, &c2, &3c, &c0
    equb &bf, &12, &6a, &6b, &6d, &16, &15, &6f, &61, &60, &19, &62, &65, &64, &66, &66
    equb &30, &79, &78, &31, &35, &36, &7e, &7e, &39, &70, &73, &08, &77, &a2, &0f, &a0
    equb &9f, &7f, &7c, &75, &7f, &72, &65, &61, &6a, &6c, &6e, &6a, &61, &63, &79, &90
    equb &8f, &8e, &8d, &8c, &8b, &8a, &7c, &7a, &6b, &6d, &61, &5b, &5d, &59, &5a, &59
    equb &a7, &a2, &a1, &a2, &7b, &7a, &79, &78, &77, &76, &75, &96, &91, &90, &93, &93
    equb &8d, &8d, &8f, &8e, &88, &88, &8b, &8a, &84, &66, &65, &64, &63, &62, &61, &60
    equb &5f, &ae, &b6, &af, &ad, &bf, &a1, &a5, &a9, &ac, &a2, &a3, &a8, &b3, &ba, &50
    equb &4f, &4e, &4d, &4c, &4b, &4a, &b9, &bb, &a1, &ab, &a9, &9a, &95, &a3, &97, &99
    equb &df, &ea, &e3, &dd, &3b, &3a, &39, &38, &37, &36, &35, &34, &33, &32, &31, &30
    equb &df, &c8, &cb, &d4, &d9, &c8, &d9, &c2, &de, &d5, &cb, &c6, &c7, &c1, &f8, &f1
    equb &1f, &1a, &19, &18, &15, &05, &26, &3c, &17, &16, &15, &14, &2c, &15, &ae, &af
    equb &0f, &0e, &0d, &0c, &f4, &fb, &e6, &d7, &07, &06, &05, &04, &fd, &e0, &df, &be
    equb &db, &da, &d9, &d8, &df, &de, &c6, &e7, &73, &49, &75, &6f, &6c, &72, &4e, &cf
    equb &d7, &11, &ed, &13, &14, &ea, &16, &17, &99, &18, &e5, &1a, &1d, &e2, &1f, &1e
    equb &d1, &da, &a8, &e1, &be, &8f, &ac, &a9, &e8, &e8, &2d, &25, &30, &35, &1e, &0f
    equb &2c, &e5, &66, &64, &41, &20, &c3, &32, &37, &30, &33, &32, &c5, &3c, &3f, &3e
    equb &c0, &c1, &fc, &cd, &c4, &c5, &c6, &c7, &68, &48, &4b, &6a, &6d, &6f, &6c, &6d
    equb &55, &ae, &07, &52, &55, &2a, &55, &28, &59, &a0, &0b, &5a, &5d, &a2, &a1, &a0
    equb &9f, &eb, &9c, &e9, &9b, &af, &cc, &8a, &49, &68, &6b, &14, &2c, &2d, &2e, &2f
    equb &71, &70, &27, &8c, &74, &75, &76, &77, &79, &78, &2b, &86, &41, &40, &43, &42
    equb &00, &01, &7d, &03, &1b, &45, &07, &78, &c8, &de, &5d, &9c, &7c, &8d, &7e, &70
    equb &90, &11, &6d, &12, &94, &95, &96, &68, &a5, &bc, &bb, &34, &7d, &e0, &9f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &b5, &b2, &b3, &ba, &aa, &89, &93, &b8, &b9, &ba, &bb, &a3, &ba, &01, &20
    equb &c0, &c1, &c2, &c3, &3b, &34, &29, &18, &c8, &c9, &ca, &cb, &32, &2f, &90, &71
    equb &f4, &f5, &f6, &f7, &f0, &f1, &e9, &c8, &5c, &66, &5a, &40, &47, &5d, &61, &e0
    equb &d8, &1e, &e2, &1c, &1b, &e5, &19, &18, &96, &17, &ea, &15, &12, &ed, &10, &11
    equb &fe, &f5, &87, &ce, &91, &a4, &87, &86, &d7, &c7, &02, &0a, &1f, &1a, &31, &20
    equb &e3, &2a, &a9, &a3, &8e, &ef, &0c, &ff, &f8, &ff, &fc, &fd, &0a, &f3, &f0, &f9
    equb &6f, &6e, &53, &62, &6b, &6a, &69, &68, &c7, &a7, &e4, &c5, &c2, &c0, &c3, &c2
    equb &d8, &21, &88, &dd, &da, &a5, &de, &a7, &d6, &2f, &a4, &d5, &d2, &2d, &2e, &2f
    equb &30, &60, &33, &62, &34, &00, &27, &25, &e6, &c7, &c4, &bb, &83, &82, &8d, &80
    equb &be, &bf, &e8, &43, &bb, &ba, &b1, &b8, &b6, &b7, &e4, &49, &8e, &8f, &8c, &8d
    equb &2f, &2e, &52, &2c, &34, &6a, &68, &57, &e7, &f1, &72, &b3, &53, &aa, &51, &5f
    equb &9f, &1e, &62, &1d, &9b, &9a, &99, &67, &aa, &3b, &bc, &3b, &72, &ef, &90, &6f
    equb &58, &61, &48, &79, &5c, &60, &49, &62, &7b, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &83, &82, &81, &80, &92, &b9, &ba, &85, &89, &b5, &a3, &8b, &8d, &b1, &a7, &8f
    equb &86, &ad, &ae, &91, &97, &96, &95, &94, &9b, &9a, &99, &98, &9e, &8b, &a2, &a3
    equb &a0, &a0, &9e, &8a, &a4, &a4, &9a, &8e, &aa, &bf, &96, &97, &af, &ae, &ad, &ac
.level_16_original
    equb &ff, &07, &05, &05, &03, &14, &12, &11, &0a, &04, &13, &09, &07, &1a, &17, &14
    equb &0b, &1f, &08, &11, &16, &14, &0e, &16, &19, &0c, &0e, &05, &01, &03, &15, &e0
    equb &df, &20, &23, &21, &26, &24, &25, &24, &27, &20, &20, &3c, &38, &3f, &3c, &3d
    equb &23, &29, &2a, &13, &16, &12, &15, &1c, &16, &10, &16, &16, &12, &13, &12, &c0
    equb &bf, &68, &6b, &6a, &6d, &6d, &6e, &6f, &2a, &62, &29, &63, &65, &65, &66, &67
    equb &7b, &30, &7a, &7b, &7c, &7d, &36, &7f, &70, &71, &72, &73, &74, &75, &0f, &a0
    equb &9f, &60, &72, &7f, &61, &77, &7f, &6e, &72, &6c, &69, &67, &72, &65, &7e, &7a
    equb &7b, &78, &7f, &8c, &8b, &8a, &73, &72, &7d, &72, &76, &77, &6a, &6a, &67, &63
    equb &9c, &9f, &a0, &a2, &a0, &af, &aa, &ab, &77, &76, &75, &96, &91, &90, &92, &93
    equb &8d, &8d, &8f, &8f, &89, &89, &8b, &8b, &85, &84, &87, &87, &80, &62, &61, &60
    equb &5f, &a8, &bb, &bd, &aa, &ac, &a8, &ae, &bc, &a6, &ad, &b2, &b4, &a3, &bf, &b3
    equb &b1, &b0, &b3, &4c, &4b, &4a, &be, &be, &b2, &b2, &b6, &a8, &b3, &b2, &a5, &a8
    equb &dd, &dc, &ea, &d4, &dc, &e3, &ec, &ea, &37, &36, &35, &34, &33, &32, &31, &30
    equb &c4, &d6, &d1, &db, &c4, &ce, &dd, &cf, &d3, &c9, &c5, &c7, &c1, &c6, &f9, &f7
    equb &1f, &61, &62, &63, &64, &1a, &66, &67, &17, &65, &66, &07, &c0, &02, &ee, &ef
    equb &0f, &f1, &f2, &f3, &f4, &0a, &f6, &d4, &07, &38, &3b, &3a, &3d, &02, &ff, &02
    equb &b0, &81, &b5, &87, &b0, &82, &b6, &87, &08, &09, &f5, &0b, &0c, &f2, &0e, &0f
    equb &33, &32, &f1, &30, &37, &f6, &35, &34, &e5, &a4, &a7, &a6, &e1, &a0, &9f, &e2
    equb &90, &a1, &a2, &a3, &db, &a1, &a2, &a3, &28, &51, &62, &63, &e4, &65, &61, &6f
    equb &13, &92, &b2, &b3, &b4, &ca, &be, &9f, &c5, &c4, &3b, &3a, &3d, &e2, &6f, &4e
    equb &c4, &c5, &c6, &c7, &b8, &c1, &c1, &c7, &08, &36, &42, &43, &44, &45, &b6, &c7
    equb &fa, &fb, &78, &71, &6a, &77, &75, &77, &09, &08, &5b, &5a, &5d, &5c, &a1, &5e
    equb &e0, &e1, &e2, &e3, &9b, &e1, &e2, &e7, &e0, &e6, &ea, &eb, &ee, &72, &6c, &6f
    equb &57, &93, &70, &71, &7b, &fd, &f9, &f7, &85, &7c, &8b, &64, &ad, &68, &87, &4e
    equb &7c, &05, &06, &03, &78, &01, &06, &78, &88, &89, &f6, &cf, &c8, &c9, &f2, &70
    equb &10, &99, &82, &b2, &56, &91, &96, &68, &b9, &dc, &13, &8a, &bd, &dc, &9f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &cd, &ce, &cc, &cb, &b5, &c9, &c8, &b8, &ca, &c9, &a8, &6f, &ad, &41, &40
    equb &c0, &7e, &3d, &36, &3b, &c5, &39, &1b, &c8, &f7, &f4, &f5, &f2, &cd, &30, &cd
    equb &9f, &ae, &9a, &a8, &9f, &ad, &99, &88, &27, &22, &da, &24, &23, &dd, &21, &20
    equb &3c, &3d, &fe, &3f, &38, &f9, &3a, &3b, &ea, &ab, &e8, &a9, &ee, &af, &90, &ed
    equb &bf, &8e, &8d, &8c, &f4, &8e, &8d, &ac, &07, &7e, &4d, &4c, &db, &4a, &4e, &40
    equb &dc, &5d, &7c, &7c, &7b, &05, &71, &50, &0a, &0b, &a4, &e5, &f2, &2d, &a0, &81
    equb &6b, &6a, &69, &68, &17, &6e, &6e, &68, &a5, &99, &ed, &ec, &eb, &ea, &19, &68
    equb &75, &74, &f7, &fe, &e5, &f8, &fa, &f8, &a6, &87, &d4, &d5, &d2, &d3, &2e, &d1
    equb &6f, &4e, &6d, &4c, &34, &4e, &4d, &08, &4f, &49, &45, &44, &41, &dd, &c3, &c0
    equb &98, &5c, &bf, &be, &b4, &32, &36, &38, &4a, &b3, &44, &2b, &62, &a7, &48, &81
    equb &53, &2a, &29, &6c, &57, &2e, &69, &57, &a7, &a6, &d9, &e0, &f7, &e6, &dd, &5f
    equb &1f, &92, &8d, &bd, &51, &9e, &99, &67, &b6, &d3, &1c, &85, &b2, &d1, &96, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &77, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &81, &82, &81, &81, &87, &86, &85, &84, &8b, &b9, &ba, &88, &8f, &bd, &be, &8c
    equb &93, &83, &b3, &90, &95, &87, &b7, &95, &99, &8b, &bb, &99, &9f, &8f, &bf, &9c
    equb &a3, &91, &92, &a0, &a7, &95, &96, &a4, &ab, &aa, &a9, &a8, &ad, &ae, &ad, &ad
.level_17_original
    equb &ff, &03, &04, &0c, &1f, &03, &14, &03, &02, &01, &12, &0c, &0f, &1b, &1c, &13
    equb &11, &10, &10, &12, &16, &14, &1d, &0d, &00, &1b, &1f, &0c, &0f, &01, &18, &e0
    equb &df, &20, &27, &20, &26, &2b, &2a, &32, &38, &3c, &38, &33, &36, &37, &35, &37
    equb &11, &13, &10, &10, &17, &11, &14, &14, &1d, &12, &11, &12, &16, &17, &14, &c0
    equb &bf, &68, &6a, &6b, &6e, &6d, &6e, &6f, &61, &29, &62, &63, &65, &64, &66, &67
    equb &78, &79, &7a, &7b, &7c, &7d, &7e, &37, &70, &70, &72, &72, &74, &75, &0f, &a0
    equb &9f, &6b, &71, &6c, &7e, &68, &72, &64, &66, &62, &95, &94, &93, &92, &91, &90
    equb &8f, &8e, &8d, &8c, &8b, &8a, &74, &70, &6b, &6c, &63, &64, &5f, &5a, &54, &80
    equb &7f, &7e, &7d, &7c, &7b, &7a, &79, &78, &77, &76, &75, &97, &91, &91, &93, &93
    equb &8d, &8d, &8e, &8e, &6b, &6a, &69, &68, &67, &66, &65, &64, &63, &62, &61, &60
    equb &5f, &b5, &b3, &a9, &a5, &b6, &a1, &b6, &b5, &b4, &55, &54, &53, &52, &51, &50
    equb &4f, &4e, &4d, &4c, &4b, &4a, &a2, &b8, &be, &bd, &a1, &a4, &be, &98, &9a, &40
    equb &3f, &3e, &3d, &3c, &3b, &3a, &39, &38, &37, &36, &35, &34, &33, &32, &31, &30
    equb &d5, &d6, &cb, &d6, &cd, &d8, &d0, &cf, &df, &d5, &d2, &c1, &c4, &f9, &f7, &f4
    equb &1f, &26, &22, &6b, &64, &7d, &66, &27, &17, &d9, &ca, &0b, &f4, &d6, &aa, &af
    equb &0f, &0e, &cc, &ff, &f4, &f5, &76, &8e, &07, &3e, &fb, &c2, &bf, &fe, &f9, &f0
    equb &f1, &88, &8c, &83, &e4, &fd, &fe, &f7, &cc, &05, &0a, &0a, &0d, &0f, &f0, &03
    equb &54, &55, &90, &12, &14, &15, &17, &11, &27, &06, &15, &94, &1b, &52, &9d, &1e
    equb &c0, &f9, &a5, &a3, &a4, &a4, &e4, &ed, &2a, &2b, &ab, &52, &ab, &1d, &0f, &0d
    equb &38, &21, &d2, &31, &34, &d5, &2e, &32, &79, &38, &39, &34, &2d, &4c, &bd, &3e
    equb &ac, &a1, &a3, &a3, &a0, &b7, &b5, &bf, &4c, &4d, &ce, &29, &52, &5c, &6e, &8f
    equb &52, &71, &42, &5b, &44, &74, &d5, &28, &59, &5a, &59, &4c, &e3, &a2, &a1, &a0
    equb &99, &df, &f0, &f2, &d4, &ab, &c5, &a3, &74, &49, &4a, &ab, &2c, &4d, &5d, &fd
    equb &23, &22, &f2, &b3, &14, &ed, &70, &70, &87, &86, &25, &70, &75, &74, &af, &ec
    equb &04, &49, &0a, &0b, &04, &47, &61, &78, &1a, &a8, &b7, &84, &d3, &72, &71, &70
    equb &b2, &f3, &90, &71, &6c, &69, &68, &68, &89, &b8, &b9, &dc, &9f, &9a, &d1, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &a9, &8d, &c4, &cb, &d0, &c9, &88, &b8, &76, &65, &a5, &5b, &79, &05, &00
    equb &c0, &c1, &03, &30, &3b, &3a, &b9, &41, &c8, &f1, &24, &0d, &70, &31, &36, &3f
    equb &de, &a7, &a3, &ac, &cb, &d2, &d3, &d8, &e3, &2a, &25, &25, &22, &20, &df, &2c
    equb &5b, &5a, &9f, &1d, &3b, &1a, &18, &1e, &28, &09, &1a, &9b, &14, &5d, &92, &11
    equb &ef, &d6, &8a, &8c, &8b, &83, &cb, &c2, &25, &04, &84, &7d, &84, &b2, &20, &22
    equb &f7, &ee, &1d, &fe, &fb, &1a, &e1, &fd, &b6, &f7, &76, &fb, &e2, &83, &72, &f1
    equb &02, &0e, &1c, &0c, &0f, &18, &1a, &10, &e3, &e2, &61, &86, &fd, &f3, &c1, &20
    equb &dd, &fe, &cf, &f4, &cb, &fb, &5a, &a7, &de, &d5, &d6, &c3, &6c, &2d, &2e, &2f
    equb &36, &30, &3f, &3d, &3b, &04, &6a, &0c, &db, &e6, &f5, &04, &83, &e2, &f2, &52
    equb &ec, &ed, &3d, &7c, &db, &22, &bf, &bf, &48, &49, &ea, &9f, &ba, &3b, &60, &23
    equb &2b, &66, &27, &00, &2b, &68, &4e, &57, &35, &87, &98, &ab, &fc, &5d, &5e, &5f
    equb &bd, &fd, &8f, &7e, &63, &66, &67, &67, &86, &b7, &be, &d3, &90, &95, &de, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &94, &81, &be, &97, &ac, &85, &ae, &bb, &b4, &9d, &8a, &9f, &98, &99, &8e, &a7
    equb &90, &b9, &ae, &93, &80, &95, &be, &97, &8c, &b1, &8e, &b3, &b4, &89, &b6, &a3
    equb &b4, &a1, &8a, &8b, &b0, &8d, &8e, &8f, &80, &bd, &82, &bf, &84, &b9, &ae, &bb
.level_18_original
    equb &ff, &03, &13, &1d, &05, &14, &15, &1a, &15, &17, &18, &16, &15, &08, &03, &02
    equb &01, &13, &1f, &1e, &02, &08, &17, &14, &1a, &18, &19, &0e, &06, &e2, &13, &e0
    equb &df, &22, &26, &25, &2d, &2c, &2f, &2b, &25, &24, &3b, &39, &38, &33, &32, &31
    equb &2d, &14, &12, &11, &14, &13, &1a, &1b, &15, &17, &14, &10, &12, &c2, &2d, &c0
    equb &bf, &12, &68, &6b, &26, &6d, &6e, &6f, &29, &61, &62, &63, &64, &66, &2f, &66
    equb &30, &78, &31, &7b, &07, &06, &7f, &7e, &71, &70, &73, &73, &74, &a2, &0f, &a0
    equb &9f, &68, &6c, &75, &78, &66, &6a, &6d, &7b, &65, &66, &71, &77, &6a, &68, &63
    equb &7c, &6d, &8d, &8c, &8b, &8a, &7a, &7b, &77, &77, &6a, &68, &6b, &6b, &62, &61
    equb &99, &9c, &a2, &a4, &a4, &a7, &ac, &78, &77, &76, &75, &97, &90, &90, &92, &92
    equb &8c, &8d, &8f, &8f, &88, &88, &8b, &8a, &84, &85, &86, &86, &63, &62, &61, &60
    equb &5f, &aa, &b9, &b8, &b6, &a4, &a3, &a3, &b0, &a1, &ae, &a7, &b0, &a2, &be, &a4
    equb &bd, &af, &4d, &4c, &4b, &4a, &a7, &95, &a8, &b0, &b1, &96, &a9, &9e, &99, &9c
    equb &d6, &c0, &df, &d1, &c2, &ed, &cd, &38, &37, &36, &35, &34, &33, &32, &31, &30
    equb &dc, &c4, &cf, &d7, &c0, &ce, &c7, &c4, &d9, &d4, &cf, &c3, &c5, &c3, &fa, &f2
    equb &1f, &61, &3d, &22, &05, &04, &07, &06, &17, &e9, &15, &14, &13, &2e, &2d, &2c
    equb &0f, &f9, &19, &18, &5f, &56, &49, &77, &07, &f8, &27, &26, &21, &20, &23, &e2
    equb &e9, &89, &f2, &83, &c4, &c5, &c6, &c7, &cb, &4b, &48, &49, &4e, &4f, &4c, &4c
    equb &ef, &11, &12, &13, &14, &15, &16, &e8, &c5, &58, &65, &12, &15, &14, &17, &e0
    equb &df, &a1, &a2, &a3, &88, &81, &9a, &a7, &ea, &6b, &64, &61, &52, &53, &59, &09
    equb &20, &21, &12, &13, &34, &35, &c9, &37, &b9, &92, &bb, &ae, &bd, &96, &bf, &aa
    equb &c0, &c1, &bd, &bc, &bb, &b5, &b6, &b7, &28, &cd, &b5, &b5, &86, &43, &44, &41
    equb &50, &51, &92, &63, &58, &56, &16, &13, &d9, &a6, &5b, &5a, &5d, &a2, &5f, &5e
    equb &9f, &91, &92, &93, &e4, &e5, &e5, &e5, &a2, &27, &20, &25, &12, &ed, &6e, &70
    equb &94, &35, &7c, &77, &74, &76, &06, &89, &8d, &3c, &3f, &74, &7d, &bc, &7f, &40
    equb &06, &09, &7d, &02, &05, &c5, &07, &78, &88, &89, &75, &0b, &08, &85, &1e, &70
    equb &e0, &91, &6d, &13, &14, &91, &96, &68, &99, &98, &65, &da, &dd, &9c, &91, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &ce, &92, &ad, &aa, &ab, &a8, &a9, &b8, &46, &ba, &bb, &bc, &85, &82, &83
    equb &c0, &36, &d6, &d7, &d0, &99, &86, &b8, &c8, &37, &e8, &e9, &ee, &ef, &ee, &2d
    equb &c6, &e6, &dd, &ac, &eb, &ea, &e9, &e8, &e4, &64, &67, &66, &61, &60, &63, &63
    equb &e0, &4e, &1d, &1c, &1b, &1a, &19, &e7, &ca, &57, &6a, &1d, &1e, &1d, &18, &ef
    equb &f0, &8e, &8d, &8c, &a7, &ae, &b5, &88, &c5, &44, &4b, &4a, &7d, &7c, &76, &26
    equb &ef, &ce, &dd, &dc, &fb, &fa, &06, &f8, &76, &5d, &70, &61, &32, &59, &70, &65
    equb &6f, &6e, &12, &13, &14, &1a, &1d, &18, &87, &62, &1a, &1a, &2d, &ec, &ef, &ee
    equb &df, &de, &1d, &ec, &d7, &99, &99, &9c, &56, &29, &d4, &d5, &d2, &2d, &d0, &d1
    equb &30, &3e, &3d, &3c, &4b, &6a, &4a, &4a, &09, &88, &8b, &8a, &bd, &42, &c1, &df
    equb &59, &fa, &b3, &b8, &bb, &b9, &c9, &46, &42, &f3, &f0, &bb, &b2, &73, &b4, &8f
    equb &29, &26, &52, &2d, &7a, &ca, &78, &57, &a7, &a6, &5a, &24, &27, &aa, &31, &5f
    equb &ef, &9e, &62, &18, &1b, &9e, &99, &67, &96, &97, &6a, &d5, &d2, &93, &be, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &83, &82, &81, &80, &8f, &8e, &8d, &88, &8b, &86, &81, &84, &87, &8a, &85, &88
    equb &9b, &9e, &91, &98, &97, &96, &95, &94, &9b, &9a, &99, &98, &93, &96, &91, &94
    equb &ab, &aa, &a5, &a8, &ab, &ae, &a9, &a4, &af, &a2, &a1, &a0, &af, &ae, &ad, &ac
.level_19_original
    equb &ff, &05, &01, &07, &01, &06, &02, &02, &14, &12, &17, &17, &12, &16, &13, &0e
    equb &12, &10, &10, &12, &16, &16, &10, &07, &09, &0b, &09, &0f, &09, &0b, &17, &e0
    equb &df, &30, &30, &31, &36, &36, &35, &34, &33, &35, &36, &36, &31, &33, &30, &0d
    equb &12, &12, &11, &17, &10, &11, &1b, &19, &16, &17, &14, &15, &12, &13, &32, &c0
    equb &bf, &69, &6a, &6b, &6c, &6d, &6e, &6f, &60, &61, &62, &63, &64, &65, &66, &67
    equb &78, &79, &7a, &7b, &7c, &7d, &35, &7f, &70, &71, &72, &73, &74, &75, &0f, &a0
    equb &9f, &62, &7f, &62, &75, &9a, &99, &98, &97, &96, &95, &94, &93, &92, &91, &90
    equb &8f, &8e, &8d, &8c, &8b, &8a, &66, &6e, &59, &53, &85, &84, &83, &82, &81, &80
    equb &7f, &7e, &7d, &7c, &7b, &7a, &79, &78, &77, &76, &75, &96, &91, &90, &93, &70
    equb &6f, &6e, &6d, &6c, &6b, &6a, &69, &68, &67, &66, &65, &64, &63, &62, &61, &60
    equb &5f, &b2, &b0, &b2, &b4, &5a, &59, &58, &57, &56, &55, &54, &53, &52, &51, &50
    equb &4f, &4e, &4d, &4c, &4b, &4a, &bd, &bc, &b3, &b2, &45, &44, &43, &42, &41, &40
    equb &3f, &3e, &3d, &3c, &3b, &3a, &39, &38, &37, &36, &35, &34, &33, &32, &31, &30
    equb &c0, &d2, &c9, &c0, &d6, &dc, &c3, &d5, &dd, &d7, &d5, &cf, &c7, &c5, &fa, &f4
    equb &1f, &61, &62, &63, &1b, &6d, &6e, &67, &17, &ed, &ee, &eb, &10, &e9, &ee, &eb
    equb &0f, &f1, &f2, &f3, &cf, &d5, &d6, &d7, &07, &b8, &bb, &ba, &3d, &bc, &bf, &fe
    equb &88, &89, &8a, &dc, &86, &87, &84, &87, &34, &6f, &c9, &8b, &8c, &ce, &68, &33
    equb &30, &31, &e9, &13, &14, &ed, &56, &68, &59, &58, &e5, &1a, &1d, &1c, &1f, &1e
    equb &de, &c3, &81, &81, &9a, &a1, &a2, &a3, &28, &29, &95, &2b, &2c, &22, &26, &27
    equb &70, &70, &f3, &b2, &b5, &b5, &c6, &37, &39, &38, &3b, &3a, &c3, &1c, &1f, &3e
    equb &c4, &c1, &c6, &c7, &c3, &c5, &c6, &a8, &48, &41, &42, &43, &b4, &42, &4e, &b4
    equb &40, &41, &4d, &57, &50, &a9, &56, &a0, &79, &66, &bb, &7a, &7d, &7c, &7f, &a0
    equb &e0, &91, &f2, &fb, &ec, &9d, &99, &e7, &e9, &e8, &eb, &ea, &9f, &ec, &ef, &ee
    equb &70, &71, &72, &73, &74, &75, &86, &67, &f9, &f8, &fb, &fa, &fd, &82, &f7, &f6
    equb &00, &01, &0f, &0b, &0c, &0d, &0e, &78, &89, &08, &75, &ca, &cd, &8c, &cf, &70
    equb &90, &81, &6d, &93, &94, &95, &96, &68, &91, &10, &63, &d2, &d5, &dc, &d7, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &ce, &cd, &cc, &b4, &c2, &c1, &c8, &b8, &42, &41, &44, &bf, &46, &41, &44
    equb &c0, &3e, &3d, &3c, &00, &1a, &19, &18, &c8, &77, &74, &75, &f2, &73, &70, &31
    equb &a7, &a6, &a5, &f3, &a9, &a8, &ab, &a8, &1b, &40, &e6, &a4, &e3, &e1, &47, &1c
    equb &3f, &3e, &e6, &1c, &1b, &e2, &59, &67, &56, &57, &ea, &15, &12, &13, &10, &11
    equb &f1, &e4, &b2, &b2, &b5, &8e, &8d, &8c, &07, &06, &ba, &04, &03, &0d, &09, &08
    equb &bf, &bf, &3c, &7d, &7a, &7a, &09, &f8, &f6, &f7, &f4, &f5, &0c, &d3, &d0, &f1
    equb &6b, &6e, &69, &68, &6c, &6a, &69, &07, &e7, &ee, &ed, &ec, &1b, &ed, &e1, &1b
    equb &cf, &ce, &c2, &d8, &df, &26, &d9, &2f, &f6, &e9, &34, &fd, &e6, &f9, &e4, &2f
    equb &4f, &3e, &3d, &34, &33, &32, &36, &48, &46, &47, &44, &45, &30, &43, &40, &41
    equb &bf, &be, &bd, &bc, &bb, &ba, &49, &a8, &36, &37, &34, &35, &32, &4d, &38, &39
    equb &2f, &2e, &20, &24, &23, &20, &21, &57, &a6, &27, &5a, &e5, &e2, &a3, &e0, &5f
    equb &9f, &8e, &62, &9c, &9b, &9a, &67, &67, &9e, &1f, &6c, &dd, &da, &d3, &d8, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &83, &81, &80, &82, &86, &84, &85, &87, &88, &8a, &89, &89, &8e, &8c, &8d, &8f
    equb &93, &91, &90, &92, &97, &97, &96, &94, &9b, &99, &98, &9a, &9e, &9c, &9d, &9f
    equb &a0, &a2, &a1, &a1, &a6, &a4, &a5, &a7, &ab, &a9, &a8, &aa, &af, &af, &ae, &ac
.level_20_original
    equb &ff, &11, &07, &06, &14, &18, &1e, &1a, &16, &0f, &1e, &12, &12, &10, &19, &1f
    equb &07, &01, &13, &06, &01, &0f, &15, &11, &11, &13, &0f, &0e, &08, &03, &0c, &e0
    equb &df, &23, &28, &2f, &2f, &2d, &2c, &2b, &24, &3f, &39, &39, &39, &3b, &37, &35
    equb &2d, &2f, &10, &11, &11, &13, &1e, &1c, &14, &17, &13, &11, &11, &10, &13, &c0
    equb &bf, &69, &6b, &6b, &27, &1a, &6e, &6f, &60, &28, &62, &63, &2f, &2d, &67, &66
    equb &79, &78, &7a, &00, &07, &0a, &7e, &7f, &70, &70, &09, &08, &0f, &02, &0f, &a0
    equb &9f, &6e, &66, &6e, &70, &70, &7b, &68, &7b, &75, &6c, &6f, &76, &60, &74, &72
    equb &6c, &76, &67, &69, &68, &8a, &70, &7c, &76, &73, &74, &74, &6e, &6a, &6b, &67
    equb &9e, &9c, &a1, &a0, &a7, &a2, &a8, &ac, &a3, &a4, &75, &96, &90, &90, &92, &92
    equb &8d, &8d, &8f, &8f, &89, &88, &8b, &8a, &85, &84, &86, &87, &81, &80, &82, &60
    equb &5f, &b2, &ad, &a6, &a9, &a8, &a5, &be, &b5, &a3, &bc, &bf, &b7, &ac, &bc, &a1
    equb &a9, &b2, &a7, &ad, &b5, &4a, &bc, &b0, &b3, &b4, &a0, &90, &a5, &93, &bf, &bd
    equb &d1, &d6, &c5, &d6, &db, &db, &ea, &e0, &d9, &da, &35, &34, &33, &32, &31, &30
    equb &d4, &c9, &c1, &de, &c0, &cf, &d5, &c4, &dc, &da, &d7, &cc, &c7, &c6, &f8, &f8
    equb &1f, &61, &22, &63, &24, &65, &26, &67, &17, &69, &76, &4b, &28, &69, &f1, &ff
    equb &0f, &e1, &e2, &f3, &e4, &e5, &0d, &b6, &07, &f8, &fb, &f8, &fd, &f4, &0f, &ee
    equb &cf, &89, &ca, &8b, &cc, &8d, &c9, &86, &f8, &09, &0a, &0a, &0c, &0d, &f1, &0f
    equb &51, &68, &9b, &1a, &1d, &1c, &e9, &57, &09, &08, &0b, &04, &1d, &1c, &1f, &e0
    equb &e1, &a8, &ea, &ab, &eb, &ac, &ee, &af, &28, &10, &13, &12, &35, &b5, &b6, &a6
    equb &b0, &25, &10, &72, &cb, &35, &36, &c8, &41, &00, &0b, &1a, &d3, &34, &37, &d0
    equb &8f, &c1, &82, &bc, &c4, &c5, &b9, &c7, &81, &40, &43, &b2, &4d, &4c, &b7, &b6
    equb &bf, &53, &12, &d0, &95, &57, &36, &94, &b9, &c8, &d3, &de, &dd, &a4, &db, &dc
    equb &ca, &b1, &c9, &f3, &ce, &e5, &c8, &e6, &91, &92, &93, &94, &ed, &ec, &ef, &ee
    equb &b3, &f2, &f9, &b8, &bf, &fe, &fd, &bc, &f9, &f8, &fb, &84, &f5, &f4, &f7, &f6
    equb &2b, &50, &29, &02, &2f, &10, &07, &78, &89, &b4, &d1, &d0, &b1, &a8, &97, &70
    equb &5b, &1a, &19, &6c, &1d, &14, &1f, &68, &11, &10, &13, &64, &15, &14, &17, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &ce, &8d, &cc, &8b, &ca, &89, &c8, &b8, &c6, &d9, &e4, &87, &c6, &5e, &50
    equb &c0, &2e, &ad, &3c, &2b, &2a, &c2, &79, &c8, &37, &34, &37, &32, &3b, &c0, &21
    equb &e0, &a6, &e1, &a4, &e7, &a2, &e6, &a9, &d7, &26, &25, &25, &23, &22, &de, &20
    equb &5e, &67, &94, &95, &12, &13, &e6, &58, &02, &07, &84, &0b, &14, &13, &10, &ef
    equb &ce, &87, &c5, &84, &c4, &83, &c3, &80, &07, &3f, &3c, &3d, &1a, &9a, &99, &89
    equb &7f, &ea, &df, &b5, &04, &fa, &f9, &07, &8e, &cf, &84, &d5, &1c, &f9, &fc, &1f
    equb &20, &6e, &2d, &13, &6b, &6a, &16, &68, &2e, &ef, &ec, &1d, &e2, &e3, &18, &19
    equb &30, &dd, &1d, &5f, &1a, &d9, &39, &1b, &36, &47, &5c, &51, &52, &2b, &54, &53
    equb &65, &1e, &26, &5c, &61, &4a, &67, &49, &3e, &3d, &3c, &3b, &42, &43, &40, &41
    equb &7c, &3d, &32, &77, &70, &35, &32, &73, &36, &37, &34, &4b, &3a, &3b, &18, &39
    equb &14, &7f, &06, &2f, &00, &3f, &28, &57, &a6, &9b, &fe, &ff, &de, &87, &98, &5f
    equb &54, &11, &12, &63, &12, &33, &10, &67, &1e, &1f, &1c, &6b, &1a, &19, &18, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &ab, &97, &81, &95, &93, &ae, &ad, &ac, &9f, &8a, &a1, &a0, &9b, &a6, &b1, &a4
    equb &87, &ba, &91, &85, &83, &be, &81, &bc, &b1, &8f, &8d, &b0, &a0, &9e, &9d, &9c
    equb &89, &9e, &b5, &88, &a7, &b2, &a5, &8c, &83, &96, &81, &80, &93, &ae, &ad, &b9
.level_21_original
    equb &ff, &07, &05, &08, &17, &1e, &04, &01, &0a, &1c, &13, &02, &1c, &18, &15, &11
    equb &15, &13, &10, &15, &12, &18, &02, &0f, &02, &16, &0c, &0b, &0d, &06, &0d, &e0
    equb &df, &25, &27, &20, &21, &20, &2e, &29, &39, &3b, &3f, &33, &34, &36, &37, &30
    equb &13, &15, &14, &15, &13, &14, &15, &17, &1d, &12, &10, &17, &11, &10, &1c, &c0
    equb &bf, &12, &21, &10, &25, &6c, &15, &6e, &28, &61, &2a, &62, &1f, &64, &66, &65
    equb &0f, &79, &7a, &31, &34, &7d, &7e, &7f, &70, &71, &73, &73, &74, &75, &0f, &a0
    equb &9f, &63, &67, &72, &63, &60, &64, &75, &7a, &74, &6c, &60, &74, &74, &74, &6d
    equb &7f, &7a, &7d, &63, &8b, &8a, &7d, &7a, &71, &69, &6e, &6d, &6c, &68, &6f, &64
    equb &9d, &9c, &9f, &9e, &a1, &a0, &a0, &a0, &af, &76, &75, &96, &90, &90, &93, &93
    equb &8d, &8d, &8e, &8e, &88, &89, &8b, &8a, &85, &84, &87, &87, &81, &80, &61, &60
    equb &5f, &a8, &a4, &a2, &b0, &a4, &aa, &b6, &a9, &b3, &a0, &b5, &a4, &a1, &a0, &a5
    equb &b6, &a5, &bd, &aa, &4b, &4a, &b3, &b0, &95, &bb, &b9, &bf, &a0, &b2, &ba, &aa
    equb &d8, &d4, &c8, &cb, &e6, &ee, &c3, &dd, &d3, &36, &35, &34, &33, &32, &31, &30
    equb &c9, &d3, &c9, &ca, &d6, &db, &c3, &dc, &dc, &ca, &ca, &cc, &c1, &c1, &f9, &f2
    equb &1f, &61, &62, &54, &54, &67, &63, &6f, &17, &e9, &ea, &04, &c8, &c9, &ca, &4b
    equb &0f, &f1, &f2, &0f, &f0, &f1, &f2, &f3, &07, &f8, &fb, &fa, &fd, &fc, &ff, &fe
    equb &d0, &81, &82, &fc, &88, &81, &8a, &8b, &6c, &2e, &2e, &ef, &68, &71, &4f, &4f
    equb &14, &ee, &05, &30, &5d, &89, &28, &68, &19, &e4, &c7, &96, &39, &6c, &e5, &e0
    equb &df, &ff, &ae, &af, &a0, &a9, &d9, &a7, &e4, &e5, &66, &67, &60, &61, &d2, &2f
    equb &10, &0e, &12, &13, &14, &15, &16, &12, &39, &c6, &3b, &3a, &7d, &3c, &7f, &2a
    equb &c0, &c1, &bd, &c1, &c6, &c0, &c3, &cf, &48, &49, &8a, &6b, &5c, &5d, &5e, &c0
    equb &30, &b1, &72, &73, &74, &6a, &77, &b6, &19, &58, &1b, &5a, &5d, &a2, &41, &46
    equb &e8, &e9, &ee, &eb, &e8, &9d, &ee, &ef, &e0, &e1, &a2, &83, &14, &72, &7e, &70
    equb &71, &60, &53, &62, &75, &8a, &76, &87, &63, &62, &61, &62, &61, &60, &63, &62
    equb &08, &09, &0a, &06, &01, &06, &06, &78, &f0, &69, &4a, &0b, &08, &8f, &8f, &70
    equb &83, &00, &c3, &a2, &85, &84, &a6, &68, &19, &58, &5b, &f2, &bd, &9c, &9f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &ce, &cd, &fb, &f9, &c9, &cc, &c0, &b8, &46, &45, &bb, &67, &66, &65, &e4
    equb &c0, &3e, &3d, &c0, &3f, &2e, &3d, &3c, &c8, &37, &34, &35, &32, &23, &30, &31
    equb &df, &ae, &ad, &d3, &a7, &ae, &a7, &a4, &43, &01, &01, &c0, &47, &5e, &60, &60
    equb &1b, &e1, &0a, &3f, &52, &86, &27, &67, &16, &eb, &c8, &99, &36, &63, &ea, &ef
    equb &f0, &f0, &81, &80, &8f, &86, &f6, &88, &cb, &ca, &49, &48, &4f, &4e, &fd, &00
    equb &df, &c1, &d9, &dc, &db, &da, &d9, &dd, &f6, &09, &f4, &f5, &b2, &b3, &b0, &e5
    equb &6f, &6e, &12, &6e, &69, &6f, &6c, &60, &a7, &e6, &25, &c4, &f3, &f2, &f1, &6f
    equb &3f, &3e, &fd, &f8, &fb, &e5, &f8, &39, &96, &c7, &94, &d5, &d2, &2d, &ce, &cb
    equb &47, &46, &41, &40, &67, &32, &63, &42, &4f, &4a, &0d, &2c, &bb, &dd, &d1, &df
    equb &be, &af, &8c, &a5, &ba, &45, &b9, &48, &2c, &ad, &ae, &ad, &ae, &8f, &ac, &ad
    equb &27, &26, &25, &29, &2e, &29, &29, &57, &df, &46, &65, &25, &27, &a0, &a0, &5f
    equb &8c, &0f, &ce, &ad, &0a, &cb, &a9, &67, &16, &57, &54, &fd, &b2, &83, &90, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &80, &81, &82, &83, &bb, &af, &b9, &ad, &b6, &a3, &b4, &a1, &b2, &a7, &b0, &a5
    equb &ae, &bb, &ac, &b9, &ab, &bf, &a9, &bd, &98, &99, &9a, &9b, &b6, &a2, &b4, &a0
    equb &8a, &9f, &88, &9d, &8e, &9b, &8c, &99, &82, &97, &80, &95, &86, &92, &84, &90
.level_22_original
    equb &28, &12, &11, &08, &0d, &06, &18, &13, &1b, &03, &03, &01, &0f, &09, &0c, &0c
    equb &13, &0d, &08, &10, &10, &0d, &0c, &0e, &03, &16, &03, &06, &01, &03, &15, &e0
    equb &df, &0c, &09, &0f, &08, &0c, &07, &03, &09, &0d, &09, &09, &0b, &0f, &0c, &32
    equb &2b, &27, &20, &23, &3e, &30, &37, &36, &11, &3a, &13, &12, &38, &39, &37, &c0
    equb &bf, &69, &6a, &6b, &6c, &6d, &6e, &6e, &60, &29, &62, &63, &64, &65, &66, &67
    equb &78, &33, &7b, &7a, &7c, &7c, &7e, &7f, &0b, &70, &09, &3a, &77, &77, &0f, &a0
    equb &9f, &7c, &79, &7a, &6f, &73, &7a, &68, &67, &67, &67, &64, &67, &92, &91, &90
    equb &8f, &8e, &8d, &8c, &8b, &8a, &5e, &5f, &50, &58, &66, &73, &73, &73, &73, &72
    equb &8a, &86, &7d, &7c, &7b, &7a, &79, &78, &77, &76, &75, &96, &91, &90, &93, &92
    equb &8d, &8c, &8f, &8f, &88, &88, &8b, &68, &67, &66, &65, &64, &63, &62, &61, &60
    equb &5f, &bf, &bf, &b8, &a5, &be, &bd, &ac, &a4, &a5, &a1, &a2, &aa, &52, &51, &50
    equb &4f, &4e, &4d, &4c, &4b, &4a, &a4, &9d, &92, &b5, &ab, &98, &b7, &b1, &b5, &b3
    equb &de, &d9, &3d, &3c, &3b, &3a, &39, &38, &37, &36, &35, &34, &33, &32, &31, &30
    equb &df, &c4, &cf, &c5, &d9, &c0, &d3, &da, &f4, &f8, &c4, &c3, &c0, &cc, &d3, &db
    equb &1f, &02, &63, &42, &44, &44, &67, &7f, &17, &11, &6a, &6b, &ec, &ed, &2e, &97
    equb &0f, &ce, &ce, &8b, &84, &85, &0e, &0f, &07, &f6, &fb, &f8, &fd, &fa, &f9, &38
    equb &8b, &c7, &c4, &d7, &94, &9d, &cf, &e5, &6c, &45, &fd, &c9, &8b, &eb, &61, &34
    equb &ef, &ee, &ad, &0c, &9b, &99, &f6, &e7, &e7, &fe, &dd, &dc, &1f, &6e, &ed, &ec
    equb &c6, &d1, &d1, &dd, &d4, &e5, &d9, &d8, &1a, &2b, &ae, &2e, &65, &66, &05, &1f
    equb &30, &71, &d3, &da, &cb, &ca, &f9, &37, &c1, &f0, &b3, &b2, &a5, &24, &2f, &0e
    equb &c1, &c0, &c3, &ea, &d5, &ec, &c7, &c6, &d8, &e9, &eb, &8b, &8c, &cd, &ce, &8f
    equb &b0, &a1, &a3, &aa, &2b, &2d, &2e, &a6, &29, &88, &cb, &4a, &fd, &7c, &9f, &9e
    equb &e1, &c8, &f3, &ca, &e5, &e4, &e7, &ce, &ab, &d6, &e4, &e5, &f0, &91, &91, &90
    equb &91, &70, &73, &72, &77, &4a, &09, &88, &b9, &f8, &fb, &fa, &fd, &7c, &2b, &7e
    equb &11, &29, &02, &03, &04, &05, &06, &78, &77, &89, &8a, &db, &ac, &dd, &8e, &70
    equb &6f, &91, &92, &bb, &84, &bd, &96, &68, &67, &b2, &71, &64, &9d, &9c, &9f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &ad, &cc, &ed, &eb, &eb, &c8, &d0, &b8, &be, &c5, &c5, &4b, &42, &81, &38
    equb &c0, &01, &01, &44, &4b, &4a, &c1, &c0, &c8, &59, &34, &37, &34, &b5, &36, &f7
    equb &a4, &e8, &e3, &f8, &bb, &b2, &e0, &ca, &43, &7a, &d2, &e6, &a4, &c4, &4e, &1b
    equb &e0, &e1, &a2, &03, &94, &96, &f9, &e8, &e8, &f1, &d2, &d3, &10, &61, &e2, &e3
    equb &f9, &fe, &fe, &f2, &fb, &ca, &f6, &f7, &35, &04, &81, &01, &4a, &49, &2a, &30
    equb &ff, &be, &1c, &15, &04, &05, &36, &f8, &0e, &3f, &5e, &7d, &6a, &eb, &e8, &c1
    equb &6e, &6f, &6c, &55, &7a, &53, &68, &69, &57, &46, &44, &24, &23, &62, &61, &20
    equb &3f, &2e, &2c, &25, &a4, &a2, &a1, &29, &a6, &07, &44, &c5, &72, &f3, &10, &11
    equb &4e, &67, &74, &65, &4a, &4b, &48, &71, &04, &79, &6b, &0a, &7f, &3e, &3e, &3f
    equb &5e, &af, &bc, &bd, &b0, &85, &c6, &47, &76, &35, &34, &35, &32, &b3, &e4, &b1
    equb &3e, &16, &2d, &2c, &2b, &2a, &29, &57, &58, &a6, &a5, &f4, &d3, &f2, &a1, &5f
    equb &60, &9e, &9d, &a4, &8b, &a2, &99, &67, &68, &e9, &6a, &6b, &92, &93, &90, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &b3, &b2, &b3, &b0, &b6, &b6, &b5, &b5, &bb, &ba, &b8, &b8, &bf, &be, &bd, &bc
    equb &a1, &a0, &a1, &a0, &a7, &a6, &a5, &a6, &ab, &aa, &ab, &a8, &ad, &ae, &ad, &ac
    equb &93, &90, &90, &90, &97, &96, &95, &94, &9a, &9a, &99, &99, &9f, &9f, &9d, &9c
.level_23_original
    equb &ff, &09, &1a, &1e, &1e, &03, &0d, &0b, &05, &1f, &17, &10, &17, &16, &0c, &04
    equb &1a, &1f, &1f, &0f, &16, &14, &03, &05, &05, &1e, &01, &06, &00, &e2, &0e, &e0
    equb &df, &24, &23, &21, &27, &29, &2f, &2e, &26, &22, &3a, &3e, &3a, &3a, &35, &37
    equb &2c, &2d, &2d, &29, &15, &13, &16, &14, &1c, &15, &17, &16, &12, &c2, &17, &c0
    equb &bf, &69, &6b, &6b, &6c, &6d, &6d, &27, &63, &61, &63, &63, &64, &65, &66, &67
    equb &78, &79, &30, &7a, &7c, &7c, &7e, &7e, &71, &70, &09, &08, &3f, &a2, &0f, &a0
    equb &9f, &65, &61, &77, &7e, &60, &61, &6e, &67, &61, &63, &61, &67, &61, &63, &61
    equb &7f, &66, &63, &60, &7a, &8a, &71, &78, &77, &74, &68, &69, &6e, &6f, &69, &68
    equb &97, &96, &95, &94, &93, &92, &97, &95, &9a, &ab, &75, &96, &90, &91, &92, &93
    equb &8c, &8d, &8e, &8e, &89, &88, &8b, &8a, &85, &84, &87, &86, &80, &81, &83, &60
    equb &5f, &b1, &b9, &b6, &a0, &a1, &a0, &af, &b8, &a4, &a5, &a2, &a2, &a7, &a2, &a4
    equb &bb, &ac, &a0, &a7, &b0, &4a, &be, &a9, &bd, &bc, &a8, &a9, &ae, &af, &a8, &a9
    equb &d6, &d7, &d4, &d5, &d2, &d1, &ee, &d5, &da, &d4, &35, &34, &33, &32, &31, &30
    equb &c1, &c7, &c3, &df, &c9, &d0, &cb, &db, &dd, &d0, &d6, &ce, &c8, &fa, &fe, &f5
    equb &9f, &a1, &a3, &9e, &a5, &a4, &a7, &18, &17, &ed, &ee, &ec, &18, &e9, &ee, &10
    equb &0f, &f1, &e2, &23, &eb, &e5, &e6, &08, &07, &b8, &bb, &ba, &bd, &bc, &ff, &00
    equb &80, &81, &fd, &93, &94, &95, &96, &97, &08, &09, &f5, &49, &4e, &4f, &8f, &f0
    equb &10, &14, &ed, &1b, &1c, &1d, &1e, &1f, &19, &18, &fb, &3a, &3d, &3c, &3f, &3e
    equb &b0, &be, &a7, &dc, &24, &25, &26, &26, &28, &d6, &6b, &c8, &0e, &6c, &ae, &d0
    equb &38, &ce, &62, &cc, &34, &35, &b6, &c8, &19, &d8, &1b, &da, &1d, &1c, &1f, &1e
    equb &bf, &c3, &c0, &c3, &c6, &c6, &c4, &c5, &48, &49, &4a, &4b, &4c, &b2, &4e, &4f
    equb &59, &58, &53, &5a, &5d, &aa, &57, &56, &79, &78, &7b, &7a, &7d, &7c, &7f, &7e
    equb &e0, &e3, &e1, &9c, &e4, &e5, &f6, &e7, &68, &69, &95, &ab, &73, &7d, &39, &7b
    equb &71, &70, &8d, &70, &8e, &7f, &9c, &5d, &59, &58, &5b, &9a, &5d, &5c, &5f, &5e
    equb &00, &23, &16, &0b, &10, &27, &06, &78, &9d, &9c, &9f, &df, &9b, &9d, &91, &70
    equb &3a, &bb, &78, &99, &6e, &97, &68, &68, &b9, &b8, &bb, &ba, &bd, &b6, &bf, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &30, &0e, &0c, &31, &0a, &0b, &08, &b7, &b8, &42, &51, &43, &b7, &c6, &41, &bf
    equb &c0, &3e, &2d, &ec, &24, &2a, &29, &c7, &c8, &f7, &70, &55, &72, &73, &30, &cf
    equb &af, &ae, &d2, &bc, &b9, &ba, &b9, &b8, &27, &3e, &da, &66, &61, &60, &a4, &df
    equb &1f, &1b, &e2, &16, &13, &12, &11, &10, &16, &17, &f4, &35, &32, &33, &30, &31
    equb &9f, &91, &88, &f3, &0b, &0a, &09, &09, &07, &f9, &44, &e7, &21, &43, &81, &ff
    equb &f7, &01, &ad, &03, &fb, &fa, &79, &07, &d2, &17, &d4, &15, &d2, &c3, &c0, &c1
    equb &10, &6c, &6f, &4c, &69, &69, &6b, &6a, &f7, &e6, &e5, &e4, &c1, &1d, &e1, &e4
    equb &d6, &d7, &dc, &d5, &d2, &25, &d8, &d9, &f6, &f7, &fc, &f5, &f2, &f3, &f0, &f1
    equb &4f, &6c, &4e, &33, &4b, &4a, &19, &48, &c7, &c6, &3a, &04, &dc, &d2, &96, &d4
    equb &ba, &bf, &42, &9f, &41, &b0, &53, &92, &96, &97, &94, &55, &96, &93, &90, &91
    equb &2f, &0c, &39, &24, &3e, &08, &29, &57, &b2, &b3, &b0, &f0, &b4, &b2, &be, &5f
    equb &35, &34, &77, &96, &61, &98, &67, &67, &b6, &b7, &b4, &b5, &b2, &ad, &b8, &6f
    equb &70, &71, &72, &73, &74, &75, &76, &77, &78, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &bf, &bb, &bd, &bc, &bb, &bf, &b9, &b8, &b7, &b3, &b5, &b4, &b3, &b7, &b1, &b0
    equb &af, &ab, &ad, &ac, &a4, &a5, &a6, &a7, &a7, &a6, &a5, &a1, &a3, &a2, &a1, &a5
    equb &9f, &9e, &9d, &99, &9b, &9a, &99, &9d, &97, &96, &95, &91, &9c, &9d, &9e, &9f
.level_24_original
    equb &01, &1d, &18, &1f, &1c, &19, &1d, &02, &0d, &0d, &0e, &0c, &0a, &0a, &08, &0a
    equb &08, &0b, &0b, &08, &02, &01, &07, &03, &0c, &08, &1c, &19, &19, &1e, &1c, &e0
    equb &df, &0c, &0e, &08, &0f, &0c, &0e, &0c, &02, &03, &0d, &35, &31, &31, &35, &36
    equb &3d, &3d, &39, &39, &33, &33, &30, &32, &3c, &3d, &3f, &3e, &38, &39, &37, &c0
    equb &bf, &12, &11, &10, &17, &16, &15, &14, &1b, &1a, &19, &18, &1f, &1e, &1d, &1c
    equb &03, &02, &01, &00, &35, &06, &05, &04, &0b, &0a, &09, &08, &0f, &0e, &0f, &a0
    equb &9f, &9e, &9d, &9c, &9b, &9a, &99, &98, &97, &96, &95, &94, &93, &92, &91, &90
    equb &8f, &8e, &8d, &8c, &8b, &8a, &89, &88, &87, &86, &85, &84, &83, &82, &81, &80
    equb &7f, &7e, &7d, &7c, &7b, &7a, &79, &78, &77, &76, &75, &74, &73, &72, &71, &70
    equb &6f, &6e, &6d, &6c, &6b, &6a, &69, &68, &67, &66, &65, &64, &63, &62, &61, &60
    equb &5f, &5e, &5d, &5c, &5b, &5a, &59, &58, &57, &56, &55, &54, &53, &52, &51, &50
    equb &4f, &4e, &4d, &4c, &4b, &4a, &49, &48, &47, &46, &45, &44, &43, &42, &41, &40
    equb &3f, &3e, &3d, &3c, &3b, &3a, &39, &38, &37, &36, &35, &34, &33, &32, &31, &30
    equb &cb, &d2, &c0, &dc, &d0, &cd, &cc, &d4, &f2, &f0, &f9, &c6, &c7, &c9, &d3, &d8
    equb &1f, &1e, &1d, &00, &27, &65, &65, &60, &17, &1a, &0b, &67, &d3, &92, &11, &10
    equb &0f, &0d, &0b, &80, &f7, &76, &76, &3e, &07, &86, &e5, &34, &1b, &0e, &05, &0c
    equb &e7, &ce, &ed, &fc, &fa, &fd, &fe, &f6, &f7, &f6, &89, &8b, &0d, &ee, &e9, &f0
    equb &df, &ee, &ed, &ec, &eb, &e9, &f7, &d8, &ef, &be, &15, &1c, &1b, &12, &d1, &e0
    equb &c3, &e6, &e5, &cc, &e3, &d6, &dd, &d4, &d7, &d7, &d4, &d7, &d0, &d3, &d0, &d0
    equb &2f, &49, &d1, &fc, &f3, &c2, &01, &b0, &c7, &46, &05, &84, &03, &7a, &2d, &c6
    equb &bb, &b0, &b2, &b3, &b4, &bd, &b8, &b9, &b0, &bb, &ad, &25, &a8, &bb, &bc, &b4
    equb &bf, &2e, &2c, &2d, &a8, &a4, &31, &5b, &a1, &42, &09, &9c, &a3, &9c, &43, &3e
    equb &9e, &9d, &9b, &80, &83, &82, &91, &a0, &8b, &a6, &8d, &99, &9e, &8b, &9f, &93
    equb &8d, &88, &60, &37, &ba, &0b, &09, &48, &b7, &66, &0b, &be, &e1, &44, &0d, &88
    equb &43, &60, &01, &50, &7d, &79, &79, &78, &77, &76, &6a, &45, &10, &b1, &b1, &70
    equb &89, &61, &f2, &9b, &88, &8b, &69, &68, &7f, &d8, &fb, &b8, &9f, &3c, &6f, &60
    equb &a0, &a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8, &a9, &aa, &ab, &ac, &ad, &ae, &af
    equb &b0, &b1, &b2, &af, &9c, &e8, &ca, &cf, &b8, &b5, &a4, &c8, &7c, &3d, &be, &bf
    equb &c0, &c1, &c2, &c3, &c4, &c5, &c6, &3a, &c9, &c8, &cb, &ca, &cd, &cc, &cf, &ce
    equb &d1, &d0, &d3, &d2, &d5, &d4, &d7, &28, &27, &26, &25, &24, &23, &22, &21, &20
    equb &d0, &e1, &e2, &e3, &e4, &e6, &f8, &d7, &e0, &b1, &0a, &53, &34, &9d, &de, &ef
    equb &ec, &c9, &ca, &e3, &cc, &f9, &f2, &fb, &f8, &f8, &fb, &f8, &ff, &fc, &ff, &ff
    equb &e0, &86, &1e, &33, &3c, &0d, &ce, &7f, &08, &89, &ca, &4b, &cc, &b5, &e2, &09
    equb &14, &1b, &1d, &1e, &1a, &10, &16, &16, &1f, &14, &02, &8a, &07, &14, &13, &1b
    equb &30, &a1, &a3, &a2, &27, &2b, &be, &d4, &2e, &cd, &86, &13, &2c, &13, &cc, &b1
    equb &31, &32, &34, &2f, &2c, &2d, &3e, &07, &24, &09, &22, &36, &31, &24, &30, &3c
    equb &42, &47, &af, &f8, &75, &c4, &c6, &87, &78, &a9, &c4, &71, &2e, &8b, &c2, &47
    equb &6c, &4f, &22, &7b, &52, &56, &56, &57, &58, &59, &45, &6a, &3f, &9e, &9e, &5f
    equb &86, &6e, &fd, &93, &87, &84, &66, &67, &60, &df, &f4, &3f, &b0, &3b, &60, &6f
    equb &60, &41, &53, &60, &6e, &45, &56, &75, &77, &79, &7a, &7b, &7c, &7d, &7e, &7f
    equb &bc, &b5, &b6, &b3, &bc, &b1, &b2, &bf, &b8, &b5, &ba, &b3, &bc, &b5, &be, &b7
    equb &a4, &a9, &a6, &a3, &a0, &ad, &aa, &a3, &a4, &a9, &a2, &a7, &a0, &ad, &ae, &a7
    equb &98, &9d, &96, &9b, &90, &9d, &92, &93, &98, &99, &96, &9f, &9c, &95, &96, &9b
.dasmos_end

save "Default", dasmos_start, dasmos_end, &1900, &1900

; Label references by decreasing frequency:
;     oswrch:                8
;     read_ptr:              5
;     ask_level:             4
;     put_ptr:               4
;     read_ptr_hi:           4
;     tens_times_ten:        4
;     level_digits:          3
;     level_digits + 1:      3
;     osbyte:                3
;     put_ptr_hi:            3
;     copy_level:            2
;     oscli:                 2
;     another_level:         1
;     another_question:      1
;     check_level:           1
;     copy_check_end:        1
;     copy_put_next:         1
;     find_copy:             1
;     level_prompt:          1
;     one_digit:             1
;     osrdch:                1
;     osword:                1
;     print_prompt:          1
;     print_question:        1
;     read_level_block:      1
;     read_level_block + 1:  1
;     read_level_block + 2:  1
;     read_level_block + 3:  1
;     read_level_block + 4:  1
;     reset_vector:          1
;     save_command + 10:     1
;     save_command + 11:     1
;     wait_for_answer:       1

; Stats:
;     Total size (Code + Data) = 17712 bytes
;     Code                     = 269 bytes (2%)
;     Data                     = 17443 bytes (98%)
;
;     Number of instructions   = 125
;     Number of data bytes     = 17344 bytes
;     Number of data words     = 0 bytes
;     Number of string bytes   = 99 bytes
;     Number of strings        = 4
