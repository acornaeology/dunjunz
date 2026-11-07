; Constants
title_plot_reversed                  = &7b  ; Zero page flag for title_plot_star: non-zero plots each row right to left
star_x                               = &80  ; Zero page: each star's byte column (three stars)
star_y                               = &83  ; Zero page: each star's pixel row
star_frame                           = &86  ; Zero page: each star's animation frame, 0-6
star_frame_step                      = &89  ; Zero page: each star's frame step, +1 or -1
star_place                           = &8c  ; Zero page: each star's place in star_places_x
game_next_level_intercept            = &15b5  ; The game's BREAK intercept that runs Coder for the next level
spr_no_small_digit                   = &69  ; The game's sprite &69, drawn where a hero has no ten-thousands digit
opcode_jmp                           = &4c  ; The JMP opcode, which arms the MOS BREAK intercept
screen_start                         = &3000  ; The start of MODE 2 screen memory
osbyte_read_adc_or_get_buffer_status = &80
osbyte_escape_break_effect           = &c8
osbyte_set_cursor_editing            = &04
osbyte_flush_buffer                  = &15
osbyte_scan_keyboard_from_16         = &7a

; Memory locations
plot_x              = &70  ; Star position: screen byte column.
; &70 referenced 3 times by &2893, &28a0, &29bc
plot_y              = &71  ; Star position: pixel row.
; &71 referenced 3 times by &2876, &288a, &29c1
sprite_width        = &72  ; Width of the frame being plotted, in screen bytes.
; &72 referenced 2 times by &2802, &2823
sprite_height       = &73  ; Height of the frame being plotted, in pixel rows.
; &73 referenced 2 times by &2806, &2817
screen_ptr          = &74  ; Screen address being written, low byte.
; &74 referenced 16 times by &2819, &2827, &2829, &2830, &2834, &283d, &2841, &2855, &285d, &2864, &2868, &2888, &288e, &2890, &28a6, &28a8
screen_ptr_hi       = &75  ; Screen address being written, high byte.
; &75 referenced 10 times by &281d, &2838, &2845, &285b, &286a, &286e, &2883, &289c, &289e, &28ac
row_start_ptr       = &76  ; Screen address of the row being plotted, low byte.
; &76 referenced 2 times by &281b, &2851
row_start_ptr_hi    = &77  ; Screen address of the row being plotted, high byte.
; &77 referenced 2 times by &281f, &2857
sprite_data_ptr     = &78  ; Address of the next frame byte to plot, low byte.
; &78 referenced 3 times by &280d, &2825, &2847
sprite_data_ptr_hi  = &79  ; Address of the next frame byte to plot, high byte.
; &79 referenced 2 times by &2812, &284b
sprite_number       = &7a  ; Star frame to plot, 0-6.
; &7a referenced 2 times by &2808, &29c6
os_zp_fa            = &fa  ; MOS zero-page workspace, mixed into the choice of a star's place.
; &fa referenced 1 time by &294d
os_irq_a            = &fc  ; The MOS's copy of A at the last interrupt, mixed into the choice of a star's place.
; &fc referenced 1 time by &294f
os_break_intercept  = &0287  ; MOS BREAK intercept: a JMP here is called during a reset. *DUNJUNZ sets its address but leaves it disabled.
; &0287 referenced 2 times by &273a, &278e
unread_digit_table  = &08b0  ; In the game's Dunj3: four bytes set to &69 by title_start, which the game never reads.
; &08b0 used as index base 1 time by &2723
unread_hero_table   = &08b4  ; In the game's Dunj3: four bytes set to 0 by title_start, which the game never reads.
; &08b4 used as index base 1 time by &2728
unread_level_count  = &08bc  ; In the game's Dunj3: a byte set to 0 by title_start, which the game never reads.
; &08bc referenced 1 time by &2712
unread_level_digits = &08bd  ; In the game's Dunj3: two bytes set to "0 " by title_start, which the game never reads.
; &08bd referenced 1 time by &2717
row_offsets         = &c675  ; In Table, which *DUNJUNZ loads first: the offsets of the screen's character rows, high byte then low byte, a copy of MOS 1.20's table at &C375.
; &c675 used as index base 1 time by &287d
system_via_t1c_l    = &fe44
; &fe44 referenced 2 times by &290a, &294a
oswrch              = &ffee
; &ffee referenced 13 times by &2699, &26c2, &26ce, &274b, &274f, &2754, &2757, &275a, &275d, &276c, &27c1, &27c6, &27ce
osbyte              = &fff4
; &fff4 referenced 5 times by &2674, &2706, &270d, &2775, &2919
oscli               = &fff7
; &fff7 referenced 9 times by &264d, &2654, &2683, &268a, &26b1, &26c9, &2741, &277f, &2789


    org &2649

.dasmos_start
; ***************************************************************************************
; *DUNJUNZ: load the private-RAM code and show the title
;
; Run by BOOT on a Master 128. Load Code2, Code3 and Table into the Master's private RAM
; (HAZEL, &C000-&DFFF), which MOS 3.20 leaves paged in for a *RUN program, then carry on
; with the start-up at title_start.
.dunjunz_start
    ldx #<(load_code2_command)          ; *LOAD Code2 (the music, at &C700)
    ldy #>(load_code2_command)          ; ...command's high byte
    jsr oscli                           ; ...and run it: Code2 into private RAM
    ldx #<(load_code3_command)          ; *LOAD Code3 (a copy of the sprite plotter, at &D800)
    ldy #>(load_code3_command)          ; ...command's high byte
    jsr oscli                           ; ...and run it: Code3 into private RAM
    jmp load_table                      ; Load Table and start the title
.load_code2_command
    equs "LOAD Code2", &0d
.load_code3_command
    equs "LOAD Code3", &0d
; ***************************************************************************************
; Run Coder, through Coder2 if a joystick is present
;
; Read joystick channel 1. A reading with high byte &80 or &81 (a joystick at rest) runs
; CODER2, which installs the joystick handler and runs CODER; anything else runs CODER
; directly. Neither returns.
; &2670 referenced 1 time by &26d7
.run_coder
    lda #osbyte_read_adc_or_get_buffer_status  ; OSBYTE &80: read ADC channel 1 (joystick 1, horizontal)...
    ldx #1                              ; ...channel 1
    jsr osbyte                          ; ...Y = the reading's high byte  Read ADC channel X or buffer status
    cpy #&80                            ; High byte &80 (at rest)?
    beq run_coder2                      ; Yes: a joystick
    cpy #&81                            ; High byte &81?
    beq run_coder2                      ; Yes: a joystick
    ldx #<(coder_command)               ; No joystick: *CODER, which does not return
    ldy #>(coder_command)               ; ...command's high byte
    jsr oscli                           ; ...and run it; the game takes over from here
; &2686 referenced 2 times by &2679, &267d
.run_coder2
    ldx #<(coder2_command)              ; Joystick: *CODER2, which does not return
    ldy #>(coder2_command)              ; ...command's high byte
    jsr oscli                           ; ...and run it; the game takes over from here
.coder2_command
    equs "CODER2", &0d
; ***************************************************************************************
; Blank the display and disable VDU output
;
; Send VDU 23,0,1,0,0,0,0,0,0,0 (6845 register 1, characters per row, set to 0) and VDU
; 21, from blank_display_vdu.
;
; On Exit:
;     A: corrupted
;     X: 11
;     Y: preserved
; &2694 referenced 1 time by &26d2
.blank_display
    ldx #0                              ; Send the eleven bytes of blank_display_vdu
; &2696 referenced 1 time by &269f
.blank_display_loop
    lda blank_display_vdu,x             ; Next byte of the VDU sequence...
    jsr oswrch                          ; ...to the VDU drivers
    inx                                 ; ...on to the next
    cpx #&0b                            ; ...until all eleven are sent
    bne blank_display_loop              ; Not yet: send the next
    rts                                 ; Return
; &26a2 used as index base 1 time by &2696
.blank_display_vdu
    equb &17, &00, &01, &00, &00, &00, &00, &00, &00, &00, &15
; &26ad referenced 1 time by &2657
.load_table
    ldx #<(load_table_command)          ; *L. TABLE (level 25, game over, row offsets, pause, at &C5A0)
    ldy #>(load_table_command)          ; ...command's high byte
    jsr oscli                           ; ...and run it: Table into private RAM
    jmp title_start                     ; Carry on with the start-up at title_start
.load_table_command
    equs "L. TABLE", &0d
; ***************************************************************************************
; Load the title screen while output is off
;
; VDU 21, *LOAD SCREEN (the MODE 2 picture, to &3280), VDU 6.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &26c0 referenced 1 time by &2763
.load_title_screen
    lda #&15                            ; VDU 21: disable VDU output
    jsr oswrch                          ; ...so the load leaves no messages on screen
    ldx #<(load_screen_command)         ; *LOAD SCREEN
    ldy #>(load_screen_command)         ; ...command's high byte
    jsr oscli                           ; ...and run it: the picture into screen memory
    lda #6                              ; VDU 6: enable VDU output
    jsr oswrch                          ; ...so later text is seen again
    rts                                 ; Return
; ***************************************************************************************
; Blank the display and run Coder
;
; Blank the display, then choose between CODER and CODER2 by whether a joystick is
; present. It never returns.
; &26d2 referenced 1 time by &2791
.leave_title
    jsr blank_display                   ; Blank the display and disable output
    nop                                 ; Padding
    nop                                 ; ...the second padding byte
    jmp run_coder                       ; Run Coder (no return)
; ***************************************************************************************
; Unused
;
; Leftover bytes, never run: the tail of a *CODER call (its JSR OSCLI), then data.
    equb &27, &20, &f7, &ff, &0d, &36, &17, &00
    equb &0d, &1e, &00, &2a, &05, &14, &00, &15
    equb &00, &00, &00, &00, &2a, &00, &00, &04
    equb &08, &00, &2a, &04, &08, &2a, &15, &3c
    equb &3d, &00, &33, &3c, &39, &00   ; Not used
; ***************************************************************************************
; Set up, show the title and run Coder
;
; Disable ESCAPE, make the cursor keys return codes, set bytes in page &08 that the game
; does not read (a level counter, level digits and two hero tables), point the BREAK
; intercept at &15B5 but leave it disabled, load and show the title screen, twinkle stars
; on it until a key is pressed, then select the game's display and run Coder.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &2700 referenced 1 time by &26b4
.title_start
    lda #osbyte_escape_break_effect     ; OSBYTE &C8: ESCAPE disabled...
    ldx #1                              ; ...X = 1: ESCAPE disabled, BREAK as normal...
    ldy #0                              ; ...Y = 0: X replaces the old setting
    jsr osbyte                          ; ...so ESCAPE cannot interrupt the title  osbyte: escape break effect
    lda #osbyte_set_cursor_editing      ; OSBYTE 4, 1: cursor keys return codes
    ldx #1                              ; ...X = 1: cursor keys return codes
    jsr osbyte                          ; ...so the game can read them as keys  Set cursor editing keys
    lda #0                              ; Level count = 0, in a byte the game does not read
    sta unread_level_count              ; ...in page &08, which survives a reset
    lda #'0'                            ; Level digits = "0 "...
    sta unread_level_digits             ; ...first digit '0'...
    lda #' '                            ; ...second digit a space
    sta unread_level_digits + 1         ; ...for the level filename
    ldx #3                              ; For each hero...
; &2721 referenced 1 time by &272c
.init_hero_tables
    lda #spr_no_small_digit             ; ...no ten-thousands digit (sprite &69)...
    sta unread_digit_table,x            ; ...at &08B0...
    lda #0                              ; ...and switched on...
    sta unread_hero_table,x             ; ...at &08B4, bytes the game does not read
    dex                                 ; Next hero
    bpl init_hero_tables                ; Until all four heroes are set
    lda #<(game_next_level_intercept)   ; BREAK intercept address = &15B5, which the game does not use...
    sta os_break_intercept + 1          ; ...into the intercept's address low byte
    lda #>(game_next_level_intercept)   ; ...high byte
    sta os_break_intercept + 2          ; ...into the intercept's address high byte
    lda #0                              ; ...but disabled: &0287 is not a JMP
    sta os_break_intercept              ; ...into &0287, so no JMP: the intercept is off
    ldx #<(tv_title_command)            ; *TV 255,1: vertical offset for the title's MODE 2
    ldy #>(tv_title_command)            ; ...command's high byte
    jsr oscli                           ; ...and run it
    jsr mode2_cursor_off                ; MODE 2, cursor off
    ldx #&0f                            ; Make all sixteen logical colours black...
; &2749 referenced 1 time by &2761
.black_colours
    lda #&13                            ; ...VDU 19, colour, 0, 0, 0, 0...
    jsr oswrch                          ; ...VDU 19 starts the palette change...
    txa                                 ; ...logical colour X...
    jsr oswrch                          ; ...sent as the first parameter
    lda #0                              ; ...zero, for the rest of the command
    jsr oswrch                          ; ...physical colour 0: black
    jsr oswrch                          ; ...first padding byte
    jsr oswrch                          ; ...second padding byte
    jsr oswrch                          ; ...third padding byte
    dex                                 ; Next logical colour
    bpl black_colours                   ; Until colours 15 to 0 are all black
    jsr load_title_screen               ; Load the title screen unseen
    nop                                 ; Padding
    nop                                 ; ...second padding byte
    nop                                 ; ...third padding byte
    nop                                 ; ...fourth padding byte
    lda #&14                            ; VDU 20: default colours, showing the picture
    jsr oswrch                          ; ...so the loaded picture appears all at once
    lda #0                              ; Plot the stars left to right
    sta title_plot_reversed             ; ...so title_plot_star steps right across a row
    lda #osbyte_flush_buffer            ; OSBYTE &15: flush the buffer X
    jsr osbyte                          ; ...X is whatever OSCLI left: buffer unknown  Flush specific buffer X
    jsr twinkle_stars                   ; Twinkle stars until a key is pressed
    ldx #<(tv_game_command)             ; *TV 252,1: vertical offset for the game's display
    ldy #>(tv_game_command)             ; ...command's high byte
    jsr oscli                           ; ...and run it
    jsr mode2_cursor_off                ; MODE 2, cursor off
    ldx #<(disc_command)                ; *DISC
    ldy #>(disc_command)                ; ...command's high byte
    jsr oscli                           ; ...and run it, so Coder loads from disc
    lda #0                              ; BREAK intercept stays disabled
    sta os_break_intercept              ; ...into &0287, the intercept's opcode byte
    jsr leave_title                     ; Blank the display and run Coder (no return)
    equb &ea                            ; Padding
    equb &ea                            ; ...never run: leave_title does not return
    equb &ea                            ; ...never run
    equb &ea                            ; ...never run
.load_screen_command
    equs "LOAD SCREEN", &0d
.disc_command
    equs "DISC", &0d
.coder_command
    equs "CODER", &0d
.tv_game_command
    equs "TV252 1", &0d
.tv_title_command
    equs "TV255 1", &0d
; ***************************************************************************************
; Select MODE 2 and turn the cursor off
;
; VDU 22,2 then VDU 23,0,10,&20,0,0,0,0,0,0 (6845 register 10: no cursor), from
; cursor_off_vdu.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: preserved
; &27bf referenced 2 times by &2744, &2782
.mode2_cursor_off
    lda #&16                            ; VDU 22, 2: MODE 2
    jsr oswrch                          ; ...selects a mode...
    lda #2                              ; ...mode 2: 16 colours, 20 columns
    jsr oswrch                          ; ...sent as the mode number
    ldx #0                              ; Send the eleven bytes of cursor_off_vdu
; &27cb referenced 1 time by &27d4
.send_cursor_off_vdu
    lda cursor_off_vdu,x                ; Next byte of the VDU sequence...
    jsr oswrch                          ; ...to the VDU drivers
    inx                                 ; ...on to the next
    cpx #&0b                            ; ...until all eleven are sent
    bne send_cursor_off_vdu             ; Not yet: send the next
    rts                                 ; Return
; ***************************************************************************************
; Unused
;
; Leftover bytes.
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &0a, &00, &00, &00, &0a
    equb &00, &00, &00, &0a, &00, &00, &00, &0a
    equb &00                            ; Not used
; &27f0 used as index base 1 time by &27cb
.cursor_off_vdu
    equb &17, &00, &0a, &20, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &05, &07, &00        ; Not used
; ***************************************************************************************
; Plot a star frame on the title screen
;
; Exclusive-OR a 7-byte by 28-row frame of the star animation onto the MODE 2 screen at
; byte column plot_x and pixel row plot_y, row by row and left to right (or right to left
; if title_plot_reversed is set). A version of the game's plot_sprite with its own
; frames.
;
; On Entry:
;     PLOT_X: byte column
;     PLOT_Y: pixel row
;     SPRITE_NUMBER: frame, 0-6
; &2800 referenced 1 time by &29ca
.title_plot_star
    lda #7                              ; Seven bytes wide...
    sta sprite_width                    ; ...as the plotter's width
    lda #&1c                            ; ...and 28 rows high
    sta sprite_height                   ; ...as the plotter's height
    ldx sprite_number                   ; Point at the frame's data...
    lda star_frames_lo,x                ; ...low byte from star_frames_lo
    sta sprite_data_ptr                 ; ...into the data pointer
    lda star_frames_hi,x                ; ...high byte from star_frames_hi
    sta sprite_data_ptr_hi              ; ...into the data pointer
    jsr title_screen_address            ; Screen address of the top left
    ldx sprite_height                   ; For each row...
; &2819 referenced 1 time by &2873
.plot_star_row
    lda screen_ptr                      ; ...remember its start...
    sta row_start_ptr                   ; ...low byte, to step down from later
    lda screen_ptr_hi                   ; ...high byte...
    sta row_start_ptr_hi                ; ...kept with the low byte
    txa                                 ; ...and keep the row count...
    pha                                 ; ...on the stack while X counts bytes
    ldx sprite_width                    ; ...for each byte across...
; &2825 referenced 1 time by &284e
.plot_star_byte
    lda (sprite_data_ptr),y             ; ...exclusive-OR the frame onto the screen...
    eor (screen_ptr),y                  ; ...flip the screen pixels the frame sets...
    sta (screen_ptr),y                  ; ...so plotting twice erases the star
    lda title_plot_reversed             ; ...and step a character cell (8 bytes) right or left
    bne plot_star_left                  ; Non-zero: step left instead
    clc                                 ; Right...
    lda screen_ptr                      ; ...screen pointer low byte...
    adc #8                              ; ...plus 8: the next cell to the right
    sta screen_ptr                      ; ...stored back
    bcc plot_star_next_data             ; No carry: pointer done
    inc screen_ptr_hi                   ; Carry into the high byte
    bne plot_star_next_data             ; ...(always branches)
; &283c referenced 1 time by &282d
.plot_star_left
    sec                                 ; Left...
    lda screen_ptr                      ; ...screen pointer low byte...
    sbc #8                              ; ...minus 8: the next cell to the left
    sta screen_ptr                      ; ...stored back
    bcs plot_star_next_data             ; No borrow: pointer done
    dec screen_ptr_hi                   ; Borrow from the high byte
; &2847 referenced 3 times by &2836, &283a, &2843
.plot_star_next_data
    inc sprite_data_ptr                 ; Next byte of the frame
    bne plot_star_next_byte             ; No carry: pointer done
    inc sprite_data_ptr_hi              ; Carry into the high byte
; &284d referenced 1 time by &2849
.plot_star_next_byte
    dex                                 ; Next byte across
    bne plot_star_byte                  ; More bytes in this row: plot the next
    clc                                 ; Down one pixel row from the row's start...
    lda row_start_ptr                   ; ...from the row's start, low byte...
    adc #1                              ; ...plus one pixel row
    sta screen_ptr                      ; ...as the new screen pointer
    lda row_start_ptr_hi                ; ...high byte...
    adc #0                              ; ...with the carry
    sta screen_ptr_hi                   ; ...as the new screen pointer
    lda screen_ptr                      ; ...crossing into the next character row every eight (640 - 8 bytes on)
    and #7                              ; ...pixel row within the character row
    bne plot_star_next_row              ; Not 0: still in the same character row
    clc                                 ; Row 0: moved into the next character row...
    lda screen_ptr                      ; ...so add 640 - 8 to the pointer...
    adc #&78 ; 'x'                      ; ...low byte of &278...
    sta screen_ptr                      ; ...stored back
    lda screen_ptr_hi                   ; ...high byte...
    adc #2                              ; ...plus &02 with the carry
    sta screen_ptr_hi                   ; ...stored back
; &2870 referenced 1 time by &2861
.plot_star_next_row
    pla                                 ; Next row
    tax                                 ; ...into X...
    dex                                 ; ...one row fewer to go
    bne plot_star_row                   ; More rows: plot the next
    rts                                 ; Return
; ***************************************************************************************
; Calculate a title screen address
;
; The game's screen_address, reading the row offsets from Table at &C675 in private RAM.
;
; On Entry:
;     PLOT_X: byte column
;     PLOT_Y: pixel row
;
; On Exit:
;     SCREEN_PTR: screen address
;     Y: 0
; &2876 referenced 1 time by &2814
.title_screen_address
    lda plot_y                          ; Character row x 2...
    lsr a                               ; ...divide plot_y by 4...
    lsr a                               ; ...(character row x 2)...
    and #&fe                            ; ...even, to index the table's byte pairs
    tay                                 ; ...into Y
    lda row_offsets,y                   ; High byte of row x 640, from Table's copy of the MOS table...
    clc                                 ; ...plus &3000, the screen start
    adc #>(screen_start)                ; ...the screen starts at &3000
    sta screen_ptr_hi                   ; ...as the high byte
    lda row_offsets + 1,y               ; Low byte of row x 640
    sta screen_ptr                      ; ...as the low byte
    lda plot_y                          ; Plus the pixel row within the character row
    and #7                              ; ...plot_y MOD 8...
    adc screen_ptr                      ; ...added to the low byte (no carry out)
    sta screen_ptr                      ; ...stored back
    clc                                 ; Plus 8 x byte column: high part...
    lda plot_x                          ; ...byte column...
    and #&e0                            ; ...top three bits, worth &100 each x 8...
    rol a                               ; ...rotated down...
    rol a                               ; ...towards the bottom...
    rol a                               ; ...of the byte...
    rol a                               ; ...as bits 2-0: the high byte's share
    clc                                 ; ...to add to the high byte...
    adc screen_ptr_hi                   ; ...added...
    sta screen_ptr_hi                   ; ...stored back
    lda plot_x                          ; ...low part
    asl a                               ; ...x 2...
    asl a                               ; ...x 4...
    asl a                               ; ...x 8: eight bytes per character cell
    clc                                 ; ...to add to the low byte...
    adc screen_ptr                      ; ...added...
    sta screen_ptr                      ; ...stored back
    bcc title_screen_address_done       ; No carry: address done
    inc screen_ptr_hi                   ; Carry into the high byte
; &28ae referenced 1 time by &28aa
.title_screen_address_done
    ldy #0                              ; Y = 0 for the plotting loop
    rts                                 ; Return
; ***************************************************************************************
; Unused
;
; Leftover bytes.
    equb &0d, &18, &a5, &74, &69, &78, &85, &74
    equb &a5, &75, &69, &02, &85, &75, &68  ; Not used
; &28c0 used as index base 1 time by &280a
.star_frames_lo
    equb &00, &c4, &88, &4c, &10, &d4, &98
    equb &15, &4a, &29, &fe, &a8, &b9, &75, &c3, &18  ; Not used
; &28d0 used as index base 1 time by &280f
.star_frames_hi
    equb &2a, &2a, &2b, &2c, &2d, &2d, &2e
    equb &22, &74, &a5, &71, &29, &07, &65, &74
    equb &85, &2a, &2a, &2b, &2c, &2d, &2d, &2e
    equb &22, &2a, &2a, &18, &65, &75, &85, &75
    equb &a5, &70, &0a, &0a, &0a, &18, &65, &74
    equb &85, &74, &90, &02, &e6, &75, &a0, &00
    equb &00                            ; Not used
; ***************************************************************************************
; Twinkle stars on the title screen until a key is pressed
;
; Up to three stars at once, each at one of the eight places in star_places_x and
; star_places_y, picked at random. A star grows through frames 0-6 and shrinks back
; through 5-0. When a key is pressed the stars still showing are erased.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &2900 referenced 1 time by &2778
.twinkle_stars
    ldx #2                              ; No stars showing
    lda #0                              ; ...0 for every star
; &2904 referenced 1 time by &2908
.clear_star_showing
    sta star_showing,x                  ; ...cleared...
    dex                                 ; ...next star
    bpl clear_star_showing              ; Until stars 2 to 0 are cleared
; &290a referenced 1 time by &291e
.twinkle_loop
    lda system_via_t1c_l                ; One time in four (System VIA timer 1, low bits)...
    and #3                              ; ...lowest two bits, 0-3...
    bne twinkle_advance                 ; Not 0: no new star this time
    jsr start_star                      ; ...start a star
; &2914 referenced 1 time by &290f
.twinkle_advance
    jsr advance_stars                   ; Advance every star
    lda #osbyte_scan_keyboard_from_16   ; OSBYTE &7A: any key pressed?
    jsr osbyte                          ; ...X = &FF if none  Scan keyboard from key 16
    cpx #&ff                            ; ...no key?
    beq twinkle_loop                    ; No: carry on
    ldy #2                              ; Yes: erase the stars still showing...
; &2922 referenced 1 time by &292b
.erase_stars
    lda star_showing,y                  ; ...star Y showing?
    beq erase_next_star                 ; No: nothing to erase
    jsr plot_star                       ; Yes: plot it again to erase it
; &292a referenced 1 time by &2925
.erase_next_star
    dey                                 ; Next star
    bpl erase_stars                     ; Until stars 2 to 0 are done
    rts                                 ; Return
; ***************************************************************************************
; Start a star at a free place
;
; Take the first star not showing, if any, give it frame 0 and step +1, choose a free
; place at random, mark the place taken and plot the first frame.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &292e referenced 1 time by &2911
.start_star
    ldy #0                              ; Find a star not showing...
; &2930 referenced 1 time by &2938
.find_free_star
    lda star_showing,y                  ; ...star Y showing?
    beq star_found                      ; No: use this one
    iny                                 ; Yes: try the next
    cpy #3                              ; ...of the three
    bne find_free_star                  ; Not all tried: carry on looking
    rts                                 ; All three showing: return
; &293b referenced 1 time by &2933
.star_found
    lda #1                              ; Mark it showing
    sta star_showing,y                  ; ...in star_showing
    lda #1                              ; Frame step +1...
    sta star_frame_step,y               ; ...the frame grows
    lda #0                              ; ...from frame 0
    sta star_frame,y                    ; ...the smallest
; &294a referenced 1 time by &2957
.pick_place
    lda system_via_t1c_l                ; Pick a place at random (timer, &FA and &FC mixed)...
    eor os_zp_fa                        ; ...mixed with OS workspace...
    eor os_irq_a                        ; ...and the last interrupt's A...
    and #7                              ; ...one of the eight places
    tax                                 ; ...as the place index
    lda star_places_x,x                 ; ...that is free
    bmi pick_place                      ; Taken (&FF): pick again
    sta star_x,y                        ; Star position from the place...
    lda star_places_y,x                 ; ...its pixel row...
    sta star_y,y                        ; ...as the star's row
    stx star_place,y                    ; ...remembering the place
    lda #&ff                            ; Mark the place taken
    sta star_places_x,x                 ; ...by setting its column to &FF
    jsr plot_star                       ; Plot the first frame
    rts                                 ; Return
; ***************************************************************************************
; Advance each star by one frame
;
; For each showing star, erase the frame (exclusive-OR) and step it; past frame 6 it
; turns back at 5, and below 0 it is finished and its place freed. Then plot the new
; frame and pause, longer for a star not showing so the timing stays even.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &296d referenced 1 time by &2914
.advance_stars
    ldy #0                              ; For each star...
; &296f referenced 1 time by &29b6
.advance_star
    lda star_showing,y                  ; ...showing?
    beq star_not_showing                ; No: just pause
    jsr plot_star                       ; Erase its frame
    clc                                 ; Step the frame
    lda star_frame,y                    ; ...current frame...
    adc star_frame_step,y               ; ...plus the step, +1 or -1...
    sta star_frame,y                    ; ...stored back
    bmi star_finished                   ; Below 0: finished
    cmp #7                              ; Past 6?
    bcc plot_new_frame                  ; No: plot it
    lda #5                              ; Yes: frame 5...
    sta star_frame,y                    ; ...stored...
    lda #&ff                            ; ...stepping back
    sta star_frame_step,y               ; ...step -1, so the star shrinks
    bmi plot_new_frame                  ; ...and plot it (always branches)
; &2993 referenced 1 time by &2981
.star_finished
    lda #0                              ; Finished: not showing...
    sta star_showing,y                  ; ...cleared in star_showing...
    lda star_x,y                        ; ...and free its place
    ldx star_place,y                    ; ...by putting its column back...
    sta star_places_x,x                 ; ...into star_places_x
    bpl star_pause                      ; ...(always branches)
; &29a2 referenced 2 times by &2985, &2991
.plot_new_frame
    jsr plot_star                       ; Plot the new frame
; &29a5 referenced 1 time by &29a0
.star_pause
    tya                                 ; Pause...
    pha                                 ; ...keeping Y, the star...
    ldx #5                              ; ...5 x 256 loops between stars
; &29a9 referenced 2 times by &29af, &29d4
.star_pause_outer
    ldy #&ff                            ; ...X x 256 iterations...
; &29ab referenced 1 time by &29ac
.star_pause_inner
    dey                                 ; ...count the inner loop...
    bne star_pause_inner                ; Inner loop not done: keep waiting
    dex                                 ; ...count the outer loop...
    bne star_pause_outer                ; Outer loop not done: keep waiting
    pla                                 ; ...recover the star...
    tay                                 ; ...into Y
    iny                                 ; Next star
    cpy #3                              ; ...of the three
    bne advance_star                    ; More stars: advance the next
    rts                                 ; Return
; ***************************************************************************************
; Plot star Y's current frame
;
; Call title_plot_star with the star's position and frame, keeping Y.
;
; On Entry:
;     Y: star, 0-2
;
; On Exit:
;     Y: preserved
; &29b9 referenced 4 times by &2927, &2969, &2974, &29a2
.plot_star
    lda star_x,y                        ; plot_x = star's column
    sta plot_x                          ; ...as the plotter's column
    lda star_y,y                        ; plot_y = star's row
    sta plot_y                          ; ...as the plotter's row
    lda star_frame,y                    ; sprite_number = star's frame
    sta sprite_number                   ; ...as the frame to plot
    tya                                 ; Plot it, keeping Y
    pha                                 ; ...on the stack
    jsr title_plot_star                 ; ...exclusive-OR the frame on screen
    pla                                 ; ...recover the star...
    tay                                 ; ...into Y
    rts                                 ; Return
; &29d0 referenced 1 time by &2972
.star_not_showing
    tya                                 ; Star not showing: pause for longer...
    pha                                 ; ...keeping Y, the star...
    ldx #&14                            ; ...20 x 256 loops instead of 5 x 256
    bne star_pause_outer                ; ...(always branches)
    equb &38, &38, &3e, &3e             ; Not used
; &29da used as index base 6 times by &2904, &2922, &2930, &293d, &296f, &2995
.star_showing
    equb &38, &38, &3e
    equb &3e, &38, &38                  ; Not used
; &29e0 used as index base 3 times by &2954, &2966, &299d
.star_places_x
    equb &2f, &20, &05, &00, &1f, &46, &46, &14
    equb &00, &00, &00, &00, &00, &00, &00, &00  ; Not used
; &29f0 used as index base 1 time by &295c
.star_places_y
    equb &0f, &0f, &24, &42, &33, &0f, &48, &15
    equb &00, &00, &00, &00, &00, &00, &00, &00  ; Not used
; ***************************************************************************************
; Star frames
;
; Seven 7-byte by 28-row MODE 2 frames of the title screen's twinkling star, from small
; (frame 0) to large (frame 6).
.star_frame_data
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &15, &1f, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00  ; Frame 0: 7 bytes by 28 rows
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &2a, &0a, &2a, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00  ; Frame 1: 7 bytes by 28 rows
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &15, &2a, &00, &3f, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00  ; Frame 2: 7 bytes by 28 rows
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &2a, &2a, &00, &2a, &2a, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00  ; Frame 3: 7 bytes by 28 rows
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &15, &15, &2a, &00, &3f, &15, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00  ; Frame 4: 7 bytes by 28 rows
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &2a, &2a, &2a, &00, &2a, &2a, &2a
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00  ; Frame 5: 7 bytes by 28 rows
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &2a, &3f, &2a, &00, &3f, &2a, &2a
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00
    equb &00, &00, &00, &2a, &00, &00, &00  ; Frame 6: 7 bytes by 28 rows
.dasmos_end

save "Dunjunz", dasmos_start, dasmos_end, &2649, &2649

; Label references by decreasing frequency:
;     screen_ptr:                 16
;     oswrch:                     13
;     screen_ptr_hi:              10
;     oscli:                       9
;     star_showing:                6
;     osbyte:                      5
;     plot_star:                   4
;     plot_star_next_data:         3
;     plot_x:                      3
;     plot_y:                      3
;     sprite_data_ptr:             3
;     star_places_x:               3
;     mode2_cursor_off:            2
;     os_break_intercept:          2
;     plot_new_frame:              2
;     row_start_ptr:               2
;     row_start_ptr_hi:            2
;     run_coder2:                  2
;     sprite_data_ptr_hi:          2
;     sprite_height:               2
;     sprite_number:               2
;     sprite_width:                2
;     star_pause_outer:            2
;     system_via_t1c_l:            2
;     advance_star:                1
;     advance_stars:               1
;     black_colours:               1
;     blank_display:               1
;     blank_display_loop:          1
;     blank_display_vdu:           1
;     clear_star_showing:          1
;     cursor_off_vdu:              1
;     erase_next_star:             1
;     erase_stars:                 1
;     find_free_star:              1
;     init_hero_tables:            1
;     leave_title:                 1
;     load_table:                  1
;     load_title_screen:           1
;     os_break_intercept + 1:      1
;     os_break_intercept + 2:      1
;     os_irq_a:                    1
;     os_zp_fa:                    1
;     pick_place:                  1
;     plot_star_byte:              1
;     plot_star_left:              1
;     plot_star_next_byte:         1
;     plot_star_next_row:          1
;     plot_star_row:               1
;     row_offsets:                 1
;     row_offsets + 1:             1
;     run_coder:                   1
;     send_cursor_off_vdu:         1
;     star_finished:               1
;     star_found:                  1
;     star_frames_hi:              1
;     star_frames_lo:              1
;     star_not_showing:            1
;     star_pause:                  1
;     star_pause_inner:            1
;     star_places_y:               1
;     start_star:                  1
;     title_plot_star:             1
;     title_screen_address:        1
;     title_screen_address_done:   1
;     title_start:                 1
;     twinkle_advance:             1
;     twinkle_loop:                1
;     twinkle_stars:               1
;     unread_digit_table:          1
;     unread_hero_table:           1
;     unread_level_count:          1
;     unread_level_digits:         1
;     unread_level_digits + 1:     1

; Stats:
;     Total size (Code + Data) = 2323 bytes
;     Code                     = 659 bytes (28%)
;     Data                     = 1664 bytes (72%)
;
;     Number of instructions   = 319
;     Number of data bytes     = 1587 bytes
;     Number of data words     = 0 bytes
;     Number of string bytes   = 77 bytes
;     Number of strings        = 9
