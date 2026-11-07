; Constants
title_plot_reversed          = &7b  ; Zero page flag for title_plot_star: non-zero plots each row right to left
star_x                       = &80  ; Zero page: each star's byte column (three stars)
star_y                       = &83  ; Zero page: each star's pixel row
star_frame                   = &86  ; Zero page: each star's animation frame, 0-6
star_frame_step              = &89  ; Zero page: each star's frame step, +1 or -1
star_place                   = &8c  ; Zero page: each star's place in star_places_x
game_next_level_intercept    = &15b5  ; The game's BREAK intercept that runs Coder for the next level
spr_no_small_digit           = &69  ; The game's sprite &69, drawn where a hero has no ten-thousands digit
opcode_jmp                   = &4c  ; The JMP opcode, which arms the MOS BREAK intercept
screen_start                 = &3000  ; The start of MODE 2 screen memory
osbyte_escape_break_effect   = &c8
osbyte_set_cursor_editing    = &04
osbyte_flush_buffer          = &15
osbyte_scan_keyboard_from_16 = &7a

; Memory locations
plot_x                   = &70  ; Star position: screen byte column.
; &70 referenced 3 times by &2893, &28a0, &29bc
plot_y                   = &71  ; Star position: pixel row.
; &71 referenced 3 times by &2876, &288a, &29c1
sprite_width             = &72  ; Width of the frame being plotted, in screen bytes.
; &72 referenced 2 times by &2802, &2823
sprite_height            = &73  ; Height of the frame being plotted, in pixel rows.
; &73 referenced 2 times by &2806, &2817
screen_ptr               = &74  ; Screen address being written, low byte.
; &74 referenced 16 times by &2819, &2827, &2829, &2830, &2834, &283d, &2841, &2855, &285d, &2864, &2868, &2888, &288e, &2890, &28a6, &28a8
screen_ptr_hi            = &75  ; Screen address being written, high byte.
; &75 referenced 10 times by &281d, &2838, &2845, &285b, &286a, &286e, &2883, &289c, &289e, &28ac
row_start_ptr            = &76  ; Screen address of the row being plotted, low byte.
; &76 referenced 2 times by &281b, &2851
row_start_ptr_hi         = &77  ; Screen address of the row being plotted, high byte.
; &77 referenced 2 times by &281f, &2857
sprite_data_ptr          = &78  ; Address of the next frame byte to plot, low byte.
; &78 referenced 3 times by &280d, &2825, &2847
sprite_data_ptr_hi       = &79  ; Address of the next frame byte to plot, high byte.
; &79 referenced 2 times by &2812, &284b
sprite_number            = &7a  ; Star frame to plot, 0-6.
; &7a referenced 2 times by &2808, &29c6
os_zp_fa                 = &fa  ; MOS zero-page workspace, mixed into the choice of a star's place.
; &fa referenced 1 time by &294d
os_irq_a                 = &fc  ; The MOS's copy of A at the last interrupt, mixed into the choice of a star's place.
; &fc referenced 1 time by &294f
os_break_intercept       = &0287  ; MOS BREAK intercept: a JMP here is called during a reset. Dunjunz points it at the game's next-level intercept and arms it before running Coder.
; &0287 referenced 2 times by &273a, &278e
hero_score_ten_thousands = &08b0  ; Each hero's score ten-thousands digit, as a small digit sprite; &69 for none.
; &08b0 used as index base 1 time by &2723
hero_absent              = &08b4  ; Non-zero for each hero switched off on the menu.
; &08b4 used as index base 1 time by &2728
levels_started           = &08bc  ; Number of levels started, kept by Coder in page &08, which survives the reset between levels.
; &08bc referenced 1 time by &2712
level_digits             = &08bd  ; The level number as ASCII digits for the level's filename: one digit and a space, or two digits.
; &08bd referenced 1 time by &2717
mos_row_offsets          = &c375  ; MOS 1.20's table of the offsets of the screen's character rows, high byte then low byte.
; &c375 used as index base 1 time by &287d
system_via_t1c_l         = &fe44
; &fe44 referenced 2 times by &290a, &294a
oswrch                   = &ffee
; &ffee referenced 13 times by &26c2, &26ce, &26d4, &274b, &274f, &2754, &2757, &275a, &275d, &276c, &27c1, &27c6, &27ce
osbyte                   = &fff4
; &fff4 referenced 4 times by &2706, &270d, &2775, &2919
oscli                    = &fff7
; &fff7 referenced 5 times by &26c9, &26db, &2741, &277f, &2789


    org &26c0

.dasmos_start
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
    jsr oswrch                          ; ...
    ldx #<(load_screen_command)         ; *LOAD SCREEN
    ldy #>(load_screen_command)         ; ...
    jsr oscli                           ; ...
    lda #6                              ; VDU 6: enable VDU output
    jsr oswrch                          ; ...
    rts                                 ; Return
; ***************************************************************************************
; Disable VDU output and run Coder
;
; VDU 21, then *CODER, which does not return.
; &26d2 referenced 1 time by &2791
.leave_title
    lda #&15                            ; VDU 21: disable VDU output
    jsr oswrch                          ; ...
    ldx #<(coder_command)               ; *CODER (no return)
    ldy #>(coder_command)               ; ...
    jsr oscli                           ; ...
; ***************************************************************************************
; Unused
;
; Leftover bytes.
    equb &0d, &36, &17, &00, &0d, &1e, &00, &2a
    equb &05, &14, &00, &15, &00, &00, &00, &00
    equb &2a, &00, &00, &04, &08, &00, &2a, &04
    equb &08, &2a, &15, &3c, &3d, &00, &33, &3c
    equb &39, &00
; ***************************************************************************************
; Set up, show the title and run Coder
;
; Disable ESCAPE, make the cursor keys return codes, set the level counter, the level
; digits and the menu tables in page &08 for Coder and the game, point the BREAK
; intercept at &15B5 (the game's next-level intercept), load and show the title screen,
; twinkle stars on it until a key is pressed, then select the game's display, arm the
; BREAK intercept and run Coder.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
.title_start
    lda #osbyte_escape_break_effect     ; OSBYTE &C8: ESCAPE disabled...
    ldx #1                              ; ...
    ldy #0                              ; ...
    jsr osbyte                          ; ...  osbyte: escape break effect
    lda #osbyte_set_cursor_editing      ; OSBYTE 4, 1: cursor keys return codes
    ldx #1                              ; ...
    jsr osbyte                          ; ...  Set cursor editing keys
    lda #0                              ; Levels started = 0, for Coder
    sta levels_started                  ; ...
    lda #'0'                            ; Level digits = "0 "...
    sta level_digits                    ; ...
    lda #' '                            ; ...
    sta level_digits + 1                ; ...
    ldx #3                              ; For each hero...
; &2721 referenced 1 time by &272c
.init_hero_tables
    lda #spr_no_small_digit             ; ...no ten-thousands digit (sprite &69)...
    sta hero_score_ten_thousands,x      ; ...at &08B0...
    lda #0                              ; ...and switched on...
    sta hero_absent,x                   ; ...at &08B4 (the menu tables)
    dex                                 ; ...
    bpl init_hero_tables                ; ...
    lda #<(game_next_level_intercept)   ; BREAK intercept address = &15B5 (the game's next-level intercept)...
    sta os_break_intercept + 1          ; ...
    lda #>(game_next_level_intercept)   ; ...
    sta os_break_intercept + 2          ; ...
    lda #0                              ; ...disabled for now: &0287 is not a JMP
    sta os_break_intercept              ; ...
    ldx #<(tv_title_command)            ; *TV 255,1: vertical offset for the title's MODE 2
    ldy #>(tv_title_command)            ; ...
    jsr oscli                           ; ...
    jsr mode2_cursor_off                ; MODE 2, cursor off
    ldx #&0f                            ; Make all sixteen logical colours black...
; &2749 referenced 1 time by &2761
.black_colours
    lda #&13                            ; ...VDU 19, colour, 0, 0, 0, 0...
    jsr oswrch                          ; ...
    txa                                 ; ...
    jsr oswrch                          ; ...
    lda #0                              ; ...
    jsr oswrch                          ; ...
    jsr oswrch                          ; ...
    jsr oswrch                          ; ...
    jsr oswrch                          ; ...
    dex                                 ; ...
    bpl black_colours                   ; ...
    jsr load_title_screen               ; Load the title screen unseen
    nop                                 ; Padding
    nop                                 ; ...
    nop                                 ; ...
    nop                                 ; ...
    lda #&14                            ; VDU 20: default colours, showing the picture
    jsr oswrch                          ; ...
    lda #0                              ; Plot the stars left to right
    sta title_plot_reversed             ; ...
    lda #osbyte_flush_buffer            ; OSBYTE &15: flush the buffer X
    jsr osbyte                          ; ...  Flush specific buffer X
    jsr twinkle_stars                   ; Twinkle stars until a key is pressed
    ldx #<(tv_game_command)             ; *TV 252,1: vertical offset for the game's display
    ldy #>(tv_game_command)             ; ...
    jsr oscli                           ; ...
    jsr mode2_cursor_off                ; MODE 2, cursor off
    ldx #<(disc_command)                ; *DISC
    ldy #>(disc_command)                ; ...
    jsr oscli                           ; ...
    lda #opcode_jmp                     ; Arm the BREAK intercept: &0287 = JMP
    sta os_break_intercept              ; ...
    jsr leave_title                     ; Disable output and run Coder (no return)
    equb &ea                            ; Padding
    equb &ea                            ; ...
    equb &ea                            ; ...
    equb &ea                            ; ...
.load_screen_command
    equs "LOAD SCREEN"
    equb &0d
.disc_command
    equs "DISC"
    equb &0d
.coder_command
    equs "CODER"
    equb &0d
.tv_game_command
    equs "TV252 1"
    equb &0d
.tv_title_command
    equs "TV255 1"
    equb &0d
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
    jsr oswrch                          ; ...
    lda #2                              ; ...
    jsr oswrch                          ; ...
    ldx #0                              ; Send the eleven bytes of cursor_off_vdu
; &27cb referenced 1 time by &27d4
.send_cursor_off_vdu
    lda cursor_off_vdu,x                ; ...
    jsr oswrch                          ; ...
    inx                                 ; ...
    cpx #&0b                            ; ...
    bne send_cursor_off_vdu             ; ...
    rts                                 ; Return
; ***************************************************************************************
; Unused
;
; Leftover bytes.
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &0a, &00, &00, &00, &0a
    equb &00, &00, &00, &0a, &00, &00, &00, &0a
    equb &00
; &27f0 used as index base 1 time by &27cb
.cursor_off_vdu
    equb &17, &00, &0a, &20, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &05, &07, &00
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
    sta sprite_width                    ; ...
    lda #&1c                            ; ...and 28 rows high
    sta sprite_height                   ; ...
    ldx sprite_number                   ; Point at the frame's data...
    lda star_frames_lo,x                ; ...
    sta sprite_data_ptr                 ; ...
    lda star_frames_hi,x                ; ...
    sta sprite_data_ptr_hi              ; ...
    jsr title_screen_address            ; Screen address of the top left
    ldx sprite_height                   ; For each row...
; &2819 referenced 1 time by &2873
.plot_star_row
    lda screen_ptr                      ; ...remember its start...
    sta row_start_ptr                   ; ...
    lda screen_ptr_hi                   ; ...
    sta row_start_ptr_hi                ; ...
    txa                                 ; ...
    pha                                 ; ...
    ldx sprite_width                    ; ...for each byte across...
; &2825 referenced 1 time by &284e
.plot_star_byte
    lda (sprite_data_ptr),y             ; ...exclusive-OR the frame onto the screen...
    eor (screen_ptr),y                  ; ...
    sta (screen_ptr),y                  ; ...
    lda title_plot_reversed             ; ...and step a character cell (8 bytes) right or left
    bne plot_star_left                  ; ...
    clc                                 ; Right...
    lda screen_ptr                      ; ...
    adc #8                              ; ...
    sta screen_ptr                      ; ...
    bcc plot_star_next_data             ; ...
    inc screen_ptr_hi                   ; ...
    bne plot_star_next_data             ; ...(always branches)
; &283c referenced 1 time by &282d
.plot_star_left
    sec                                 ; Left...
    lda screen_ptr                      ; ...
    sbc #8                              ; ...
    sta screen_ptr                      ; ...
    bcs plot_star_next_data             ; ...
    dec screen_ptr_hi                   ; ...
; &2847 referenced 3 times by &2836, &283a, &2843
.plot_star_next_data
    inc sprite_data_ptr                 ; Next byte of the frame
    bne plot_star_next_byte             ; ...
    inc sprite_data_ptr_hi              ; ...
; &284d referenced 1 time by &2849
.plot_star_next_byte
    dex                                 ; Next byte across
    bne plot_star_byte                  ; ...
    clc                                 ; Down one pixel row from the row's start...
    lda row_start_ptr                   ; ...
    adc #1                              ; ...
    sta screen_ptr                      ; ...
    lda row_start_ptr_hi                ; ...
    adc #0                              ; ...
    sta screen_ptr_hi                   ; ...
    lda screen_ptr                      ; ...crossing into the next character row every eight (640 - 8 bytes on)
    and #7                              ; ...
    bne plot_star_next_row              ; ...
    clc                                 ; ...
    lda screen_ptr                      ; ...
    adc #&78 ; 'x'                      ; ...
    sta screen_ptr                      ; ...
    lda screen_ptr_hi                   ; ...
    adc #2                              ; ...
    sta screen_ptr_hi                   ; ...
; &2870 referenced 1 time by &2861
.plot_star_next_row
    pla                                 ; Next row
    tax                                 ; ...
    dex                                 ; ...
    bne plot_star_row                   ; ...
    rts                                 ; Return
; ***************************************************************************************
; Calculate a title screen address
;
; The game's screen_address, reading the row offsets from MOS 1.20's table at &C375.
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
    lsr a                               ; ...
    lsr a                               ; ...
    and #&fe                            ; ...
    tay                                 ; ...
    lda mos_row_offsets,y               ; High byte of row x 640, from the MOS table...
    clc                                 ; ...plus &3000, the screen start
    adc #>(screen_start)                ; ...
    sta screen_ptr_hi                   ; ...
    lda mos_row_offsets + 1,y           ; Low byte of row x 640
    sta screen_ptr                      ; ...
    lda plot_y                          ; Plus the pixel row within the character row
    and #7                              ; ...
    adc screen_ptr                      ; ...
    sta screen_ptr                      ; ...
    clc                                 ; Plus 8 x byte column: high part...
    lda plot_x                          ; ...
    and #&e0                            ; ...
    rol a                               ; ...
    rol a                               ; ...
    rol a                               ; ...
    rol a                               ; ...
    clc                                 ; ...
    adc screen_ptr_hi                   ; ...
    sta screen_ptr_hi                   ; ...
    lda plot_x                          ; ...low part
    asl a                               ; ...
    asl a                               ; ...
    asl a                               ; ...
    clc                                 ; ...
    adc screen_ptr                      ; ...
    sta screen_ptr                      ; ...
    bcc title_screen_address_done       ; ...
    inc screen_ptr_hi                   ; ...
; &28ae referenced 1 time by &28aa
.title_screen_address_done
    ldy #0                              ; Y = 0 for the plotting loop
    rts                                 ; Return
; ***************************************************************************************
; Unused
;
; Leftover bytes.
    equb &0d, &18, &a5, &74, &69, &78, &85, &74
    equb &a5, &75, &69, &02, &85, &75, &68
; &28c0 used as index base 1 time by &280a
.star_frames_lo
    equb &00, &c4, &88, &4c, &10, &d4, &98
    equb &15, &4a, &29, &fe, &a8, &b9, &75, &c3, &18
; &28d0 used as index base 1 time by &280f
.star_frames_hi
    equb &2a, &2a, &2b, &2c, &2d, &2d, &2e
    equb &22, &74, &a5, &71, &29, &07, &65, &74
    equb &85, &2a, &2a, &2b, &2c, &2d, &2d, &2e
    equb &22, &2a, &2a, &18, &65, &75, &85, &75
    equb &a5, &70, &0a, &0a, &0a, &18, &65, &74
    equb &85, &74, &90, &02, &e6, &75, &a0, &00
    equb &00
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
    lda #0                              ; ...
; &2904 referenced 1 time by &2908
.clear_star_showing
    sta star_showing,x                  ; ...
    dex                                 ; ...
    bpl clear_star_showing              ; ...
; &290a referenced 1 time by &291e
.twinkle_loop
    lda system_via_t1c_l                ; One time in four (System VIA timer 1, low bits)...
    and #3                              ; ...
    bne twinkle_advance                 ; ...
    jsr start_star                      ; ...start a star
; &2914 referenced 1 time by &290f
.twinkle_advance
    jsr advance_stars                   ; Advance every star
    lda #osbyte_scan_keyboard_from_16   ; OSBYTE &7A: any key pressed?
    jsr osbyte                          ; ...  Scan keyboard from key 16
    cpx #&ff                            ; ...
    beq twinkle_loop                    ; No: carry on
    ldy #2                              ; Yes: erase the stars still showing...
; &2922 referenced 1 time by &292b
.erase_stars
    lda star_showing,y                  ; ...
    beq erase_next_star                 ; ...
    jsr plot_star                       ; ...
; &292a referenced 1 time by &2925
.erase_next_star
    dey                                 ; ...
    bpl erase_stars                     ; ...
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
    lda star_showing,y                  ; ...
    beq star_found                      ; ...
    iny                                 ; ...
    cpy #3                              ; ...
    bne find_free_star                  ; ...
    rts                                 ; All three showing: return
; &293b referenced 1 time by &2933
.star_found
    lda #1                              ; Mark it showing
    sta star_showing,y                  ; ...
    lda #1                              ; Frame step +1...
    sta star_frame_step,y               ; ...
    lda #0                              ; ...from frame 0
    sta star_frame,y                    ; ...
; &294a referenced 1 time by &2957
.pick_place
    lda system_via_t1c_l                ; Pick a place at random (timer, &FA and &FC mixed)...
    eor os_zp_fa                        ; ...
    eor os_irq_a                        ; ...
    and #7                              ; ...
    tax                                 ; ...
    lda star_places_x,x                 ; ...that is free
    bmi pick_place                      ; ...
    sta star_x,y                        ; Star position from the place...
    lda star_places_y,x                 ; ...
    sta star_y,y                        ; ...
    stx star_place,y                    ; ...remembering the place
    lda #&ff                            ; Mark the place taken
    sta star_places_x,x                 ; ...
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
    lda star_frame,y                    ; ...
    adc star_frame_step,y               ; ...
    sta star_frame,y                    ; ...
    bmi star_finished                   ; Below 0: finished
    cmp #7                              ; Past 6?
    bcc plot_new_frame                  ; No: plot it
    lda #5                              ; Yes: frame 5...
    sta star_frame,y                    ; ...
    lda #&ff                            ; ...stepping back
    sta star_frame_step,y               ; ...
    bmi plot_new_frame                  ; ...and plot it (always branches)
; &2993 referenced 1 time by &2981
.star_finished
    lda #0                              ; Finished: not showing...
    sta star_showing,y                  ; ...
    lda star_x,y                        ; ...and free its place
    ldx star_place,y                    ; ...
    sta star_places_x,x                 ; ...
    bpl star_pause                      ; ...(always branches)
; &29a2 referenced 2 times by &2985, &2991
.plot_new_frame
    jsr plot_star                       ; Plot the new frame
; &29a5 referenced 1 time by &29a0
.star_pause
    tya                                 ; Pause...
    pha                                 ; ...
    ldx #5                              ; ...
; &29a9 referenced 2 times by &29af, &29d4
.star_pause_outer
    ldy #&ff                            ; ...X x 256 iterations...
; &29ab referenced 1 time by &29ac
.star_pause_inner
    dey                                 ; ...
    bne star_pause_inner                ; ...
    dex                                 ; ...
    bne star_pause_outer                ; ...
    pla                                 ; ...
    tay                                 ; ...
    iny                                 ; Next star
    cpy #3                              ; ...
    bne advance_star                    ; ...
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
    sta plot_x                          ; ...
    lda star_y,y                        ; plot_y = star's row
    sta plot_y                          ; ...
    lda star_frame,y                    ; sprite_number = star's frame
    sta sprite_number                   ; ...
    tya                                 ; Plot it, keeping Y
    pha                                 ; ...
    jsr title_plot_star                 ; ...
    pla                                 ; ...
    tay                                 ; ...
    rts                                 ; Return
; &29d0 referenced 1 time by &2972
.star_not_showing
    tya                                 ; Star not showing: pause for longer...
    pha                                 ; ...
    ldx #&14                            ; ...
    bne star_pause_outer                ; ...(always branches)
    equb &38, &38, &3e, &3e
; &29da used as index base 6 times by &2904, &2922, &2930, &293d, &296f, &2995
.star_showing
    equb &38, &38, &3e
    equb &3e, &38, &38
; &29e0 used as index base 3 times by &2954, &2966, &299d
.star_places_x
    equb &2f, &20, &05, &00, &1f, &46, &46, &14
    equb &00, &00, &00, &00, &00, &00, &00, &00
; &29f0 used as index base 1 time by &295c
.star_places_y
    equb &0f, &0f, &24, &42, &33, &0f, &48, &15
    equb &00, &00, &00, &00, &00, &00, &00, &00
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
    equb &00, &00, &00, &00, &00, &00, &00
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
    equb &00, &00, &00, &00, &00, &00, &00
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
    equb &00, &00, &00, &00, &00, &00, &00
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
    equb &00, &00, &00, &00, &00, &00, &00
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
    equb &00, &00, &00, &2a, &00, &00, &00
.dasmos_end

save "Dunjunz", dasmos_start, dasmos_end, &2700, &26c0

; Label references by decreasing frequency:
;     screen_ptr:                 16
;     oswrch:                     13
;     screen_ptr_hi:              10
;     star_showing:                6
;     oscli:                       5
;     osbyte:                      4
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
;     sprite_data_ptr_hi:          2
;     sprite_height:               2
;     sprite_number:               2
;     sprite_width:                2
;     star_pause_outer:            2
;     system_via_t1c_l:            2
;     advance_star:                1
;     advance_stars:               1
;     black_colours:               1
;     clear_star_showing:          1
;     cursor_off_vdu:              1
;     dasmos_start:                1
;     erase_next_star:             1
;     erase_stars:                 1
;     find_free_star:              1
;     hero_absent:                 1
;     hero_score_ten_thousands:    1
;     init_hero_tables:            1
;     leave_title:                 1
;     level_digits:                1
;     level_digits + 1:            1
;     levels_started:              1
;     load_title_screen:           1
;     mos_row_offsets:             1
;     mos_row_offsets + 1:         1
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
;     twinkle_advance:             1
;     twinkle_loop:                1
;     twinkle_stars:               1

; Stats:
;     Total size (Code + Data) = 2204 bytes
;     Code                     = 593 bytes (27%)
;     Data                     = 1611 bytes (73%)
;
;     Number of instructions   = 289
;     Number of data bytes     = 1577 bytes
;     Number of data words     = 0 bytes
;     Number of string bytes   = 34 bytes
;     Number of strings        = 5
