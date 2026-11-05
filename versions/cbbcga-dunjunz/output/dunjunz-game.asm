; Constants
osbyte_flush_buffer_class    = &0f
osbyte_kbd_status            = &ca
osbyte_sound_suppression     = &d2
osbyte_bell_channel          = &d3
osbyte_bell_envelope         = &d4
osbyte_bell_frequency        = &d5
osbyte_bell_duration         = &d6
osbyte_inkey                 = &81
osword_envelope              = &08
osword_sound                 = &07
osbyte_scan_keyboard_from_16 = &7a

; Memory locations
data_0000             = &00
; &00 referenced 1 time by &10e6
plot_x                = &70  ; Sprite position: screen byte column, 0-79 (two MODE 2 pixels per byte). Also used as a scratch byte and pointer low byte by other routines.
; &70 referenced 47 times by &0422, &0439, &043b, &0452, &045a, &045c, &045e, &0465, &046b, &05a7, &05ab, &0984, &0991, &0f68, &143c, &14ec, &14f7, &14fb, &15c3, &1da6, &1e1c, &1e77, &20c6, &726d, &7282, &72c6, &72db, &72eb, &72fb, &75b8, &75d9, &75e4, &75fb, &7823, &7846, &784a, &78a1, &78bb, &78d5, &78ef, &7f8f, &7f95, &7fc1, &7fcd, &7fe4, &7ff0, &7ffa
plot_y                = &71  ; Sprite position: pixel row from the top of the screen. Also used as a pointer high byte by other routines.
; &71 referenced 29 times by &042a, &0458, &0469, &0471, &0967, &097b, &0f77, &1440, &15c7, &1da2, &1e18, &1e73, &20c2, &7269, &72c2, &75b4, &75d5, &75ec, &7603, &7797, &77a9, &77bb, &77cd, &77ef, &77f3, &78a8, &78c2, &78dc, &78f6
sprite_width          = &72  ; Width of the sprite being plotted, in screen bytes.
; &72 referenced 6 times by &0454, &0461, &0463, &047a, &090f, &0927
sprite_height         = &73  ; Height of the sprite being plotted, in pixel rows.
; &73 referenced 2 times by &0914, &091b
screen_ptr            = &74  ; Screen address being written, low byte.
; &74 referenced 13 times by &091d, &092b, &092e, &0932, &0946, &094e, &0955, &0959, &0979, &097f, &0981, &0997, &0999
screen_ptr_hi         = &75  ; Screen address being written, high byte.
; &75 referenced 9 times by &0921, &0936, &094c, &095b, &095f, &0974, &098d, &098f, &099d
row_start_ptr         = &76  ; Screen address of the first byte of the sprite row being plotted, low byte.
; &76 referenced 2 times by &091f, &0942
row_start_ptr_hi      = &77  ; Screen address of the first byte of the sprite row being plotted, high byte.
; &77 referenced 2 times by &0923, &0948
sprite_data_ptr       = &78  ; Address of the next sprite data byte to plot, low byte.
; &78 referenced 3 times by &0905, &0929, &0938
sprite_data_ptr_hi    = &79  ; Address of the next sprite data byte to plot, high byte.
; &79 referenced 2 times by &090a, &093c
sprite_number         = &7a  ; Sprite to plot: an index into the sprite tables at sprite_addr_lo, sprite_addr_hi, sprite_widths and sprite_heights.
; &7a referenced 45 times by &041e, &0433, &0900, &0f6a, &11a6, &11fe, &15cb, &1d2e, &1d9a, &1dca, &1e10, &1e57, &1e6b, &1f69, &1fb5, &1fd1, &20ba, &7077, &70a2, &70e9, &720f, &7242, &7272, &727e, &72cb, &72d7, &72e7, &72f7, &731c, &75c0, &75dd, &75f4, &7608, &760f, &7663, &767a, &7695, &76f5, &7813, &7836, &7840, &79cb, &79fb, &7b17, &7b50
data_007b             = &7b
; &7b referenced 21 times by &1d5b, &1d62, &1d64, &1d80, &1d85, &7046, &7542, &767f, &77a1, &77b3, &77c5, &77d7, &77e4, &790e, &7915, &7917, &792f, &794a, &7951, &7953, &796b
data_007c             = &7c
; &7c referenced 4 times by &1d68, &77e0, &791b, &7957
data_007d             = &7d
; &7d referenced 18 times by &10f2, &1d32, &1dc4, &1e5b, &1f63, &1fa3, &1fe5, &7088, &70cc, &7307, &76ea, &7738, &780c, &787a, &79c5, &7a00, &7b1c, &7b55
data_007e             = &7e
; &7e referenced 18 times by &10f4, &1d34, &1dc6, &1e5d, &1f65, &1fa5, &1fea, &708d, &70ce, &7309, &76ec, &773d, &780e, &788e, &79c7, &7a05, &7b21, &7b5a
data_0080             = &80
; &80 referenced 8 times by &114b, &1154, &1159, &1166, &117d, &1182, &118a, &119a
data_0081             = &81
; &81 referenced 7 times by &114f, &116b, &1170, &1178, &118f, &1194, &119f
data_0082             = &82
; &82 referenced 6 times by &10f8, &115e, &11a4, &11ac, &11bb, &11d5
data_0084             = &84
; &84 referenced 5 times by &1100, &111c, &1122, &1133, &113c
data_008d             = &8d
; &8d referenced 3 times by &1108, &110d, &1113
data_008e             = &8e
; &8e referenced 2 times by &1104, &1115
data_008f             = &8f
; &8f referenced 6 times by &10fc, &110b, &110f, &1124, &7934, &7970
data_00fa             = &fa
; &fa referenced 1 time by &11c3
data_00fc             = &fc
; &fc referenced 1 time by &11c1
wrchv                 = &020e
; &020e referenced 4 times by &0d55, &0d63, &14da, &1507
filev                 = &0212
; &0212 referenced 1 time by &148c
os_vsync_counter      = &0240  ; MOS 1.20 counter decremented on every vertical sync interrupt. The game sets it and waits for it to run out to pace itself.
; &0240 referenced 6 times by &0e62, &0eb9, &11e9, &11ec, &1f00, &1f07
data_3000             = &3000
; &3000 referenced 1 time by &149a
level_object_x        = &6b00  ; Level file: Objects' map x (entries 1-30, entry 30 the exit).
; &6b00 used as index base 1 time by &1512
level_object_y        = &6b20  ; Level file: Objects' map y.
; &6b20 used as index base 1 time by &1518
level_object_type     = &6b40  ; Level file: Objects' types.
; &6b40 used as index base 1 time by &151e
level_door_x          = &6b60  ; Level file: Doors' map x (entries 1-20).
; &6b60 used as index base 1 time by &1529
level_door_y          = &6b75  ; Level file: Doors' map y.
; &6b75 used as index base 1 time by &152f
level_door_sprite     = &6b8a  ; Level file: Doors' sprites.
; &6b8a used as index base 1 time by &1535
level_key_x           = &6ba0  ; Level file: Keys' map x (entries 1-20).
; &6ba0 used as index base 1 time by &1540
level_key_y           = &6bb5  ; Level file: Keys' map y.
; &6bb5 used as index base 1 time by &1546
level_trapdoor_x      = &6bd0  ; Level file: Trapdoors' map x (entries 0-7).
; &6bd0 used as index base 1 time by &1551
level_trapdoor_y      = &6bd8  ; Level file: Trapdoors' map y.
; &6bd8 used as index base 1 time by &1557
level_walls           = &6be0  ; Level file: Wall map (&C9 bytes used).
; &6be0 used as index base 1 time by &1564
level_object_free_map = &6cb0  ; Level file: Map of cells without objects (&C9 bytes used).
; &6cb0 used as index base 1 time by &156a
level_wall_sprite     = &6d80  ; Level file: The level's wall block, copied to wall_sprite.
; &6d80 used as index base 1 time by &1577
level_osfile_block    = &6e60  ; OSFILE parameter block for loading the level, built in screen memory below Dunjun6.
; &6e60 referenced 1 time by &1474
data_6e61             = &6e61
; &6e61 referenced 1 time by &1479
data_6e62             = &6e62
; &6e62 referenced 1 time by &147e
data_6e63             = &6e63
; &6e63 referenced 1 time by &1489
data_6e64             = &6e64
; &6e64 referenced 1 time by &1481
data_6e65             = &6e65
; &6e65 referenced 1 time by &1484
mos_row_offsets       = &c375  ; MOS 1.20 table of screen row offsets for 640-byte rows (row x 640, high byte then low byte, one pair per character row). Read directly by screen_address; it is not part of any documented interface.
; &c375 used as index base 1 time by &096e
mos_row_offsets_lo    = &c376  ; Low bytes of mos_row_offsets.
; &c376 used as index base 1 time by &0976
mos_reset_entry       = &d9cd  ; MOS 1.20 reset entry, the target of the RESET vector. Called directly to reset the machine.
; &d9cd referenced 1 time by &0481
mos_oswrch_default    = &e0a4  ; MOS 1.20 default OSWRCH routine, WRCHV's initial value. The WRCHV handler jumps here directly instead of through the saved vector.
; &e0a4 referenced 2 times by &7fd7, &7ffc
system_via_t1c_l      = &fe44
; &fe44 referenced 3 times by &11be, &7a6f, &7aac
osrdch                = &ffe0
; &ffe0 referenced 2 times by &058f, &10d7
osasci                = &ffe3
; &ffe3 referenced 3 times by &0eb1, &10bd, &10ca
oswrch                = &ffee
; &ffee referenced 66 times by &0502, &0507, &050c, &0511, &0516, &051b, &0530, &0536, &053d, &0544, &0e88, &0e8d, &0e92, &0e97, &0e9c, &0ea1, &109c, &10a1, &10a6, &10ab, &10b0, &10b5, &112d, &1414, &1419, &141e, &1423, &1428, &142b, &142e, &1431, &1434, &1437, &1448, &144d, &1452, &1457, &145c, &145f, &1462, &1465, &1468, &146b, &14e7, &14ee, &15b6, &15bb, &15d2, &15d7, &15dc, &15ea, &15f3, &15f8, &15fd, &1602, &1607, &160c, &1611, &1616, &161c, &1621, &1626, &162b, &1630, &1635, &6f47
osword                = &fff1
; &fff1 referenced 15 times by &16a6, &16af, &1d18, &1ead, &1eb6, &736d, &7376, &73b9, &73e3, &748c, &74a9, &74b2, &7586, &7634, &763d
osbyte                = &fff4
; &fff4 referenced 17 times by &0583, &058c, &05ed, &0d37, &0d40, &0d49, &0d52, &0ec0, &0ec9, &10d4, &10ed, &1128, &1ed9, &1ee0, &1ee7, &1eee, &7c9e
data_fffc             = &fffc
; &fffc referenced 1 time by &10da
data_fffd             = &fffd
; &fffd referenced 1 time by &10e0


    org &0400

.dasmos_start
; ***************************************************************************************
; Add 1000 to a hero's score
;
; Advance the thousands digit of hero X's score. When it passes 9 it goes back to 0 and
; the ten-thousands digit, kept separately as one of the small digit sprites, goes up (to
; at most 9); that digit is then drawn below the score, with four further small sprites
; beside it.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &0400 referenced 1 time by &72b9
.add_thousand_points
    inc hero_score_thousands,x
    lda hero_score_thousands,x
    cmp #&28 ; '('
    bne return_1
    lda #&1e
    sta hero_score_thousands,x
    inc hero_score_ten_thousands,x
    lda hero_score_ten_thousands,x
    cmp #&73 ; 's'
    bne code_041e
    lda #&72 ; 'r'
    sta hero_score_ten_thousands,x
; &041e referenced 2 times by &0417, &06c2
.code_041e
    sta sprite_number
    lda #&45 ; 'E'
    sta plot_x
    lda data_7dd0,x
    clc
    adc #&18
    sta plot_y
    txa
    pha
    jsr plot_sprite
    lda #&71 ; 'q'
    sta sprite_number
    ldy #4
; &0437 referenced 1 time by &0443
.loop_0437
    tya
    pha
    inc plot_x
    inc plot_x
    jsr plot_sprite
    pla
    tay
    dey
    bne loop_0437
    pla
    tax
; &0447 referenced 1 time by &0408
.return_1
    rts
    equb &00, &00, &00, &00, &00, &00, &00, &00
; ***************************************************************************************
; Decrypt and check the level just loaded
;
; Decrypt the level at &6B00-&6DAF in place, XORing each byte with the low byte of its
; own address, and sum the decrypted bytes. If the sum does not match the level's entry
; in level_checksums, reset the machine.
;
; On Entry:
;     LEVEL_NUMBER: level loaded (1-25)
; &0450 referenced 1 time by &149d
.decrypt_level
    ldy #0                              ; Point at &6B00, the start of the level...
    sty plot_x                          ; ...low byte
    sty sprite_width                    ; Start the sum at zero
    lda #&6b ; 'k'                      ; ...
    sta plot_y                          ; ...high byte
; &045a referenced 2 times by &046f, &0475
.code_045a
    lda (plot_x),y                      ; Fetch a byte...
    eor plot_x                          ; ...XOR it with the low byte of its address...
    sta (plot_x),y                      ; ...and store it back decrypted
    clc                                 ; Add it to the sum
    adc sprite_width                    ; ...
    sta sprite_width                    ; ...
    inc plot_x                          ; Next byte...
    bne code_046b                       ; ...
    inc plot_y                          ; ...with carry into the high byte
; &046b referenced 1 time by &0467
.code_046b
    lda plot_x                          ; Stop at &6DB0, the end of the level...
    cmp #&b0                            ; ...
    bne code_045a                       ; ...
    lda plot_y                          ; ...
    cmp #&6d ; 'm'                      ; ...
    bne code_045a                       ; ...
    ldx level_number                    ; X = level number
    lda sprite_width                    ; Compare the sum...
    cmp level_checksums,x               ; ...with this level's checksum
    beq return_2                        ; Match: return
    jsr mos_reset_entry                 ; No match: reset the machine (MOS 1.20 only)
; &0484 referenced 1 time by &047f
.return_2
    rts                                 ; Return
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00
; &0490 used as index base 1 time by &047c
.level_checksums
    equb &00
; ***************************************************************************************
; Level checksums
;
; One byte per level, 1-25: the sum, modulo 256, of the level's decrypted bytes.
    equb &62, &cd, &0c, &44, &1a
    equb &22, &f6, &42, &21, &7d
    equb &5d, &d8, &a0, &f1, &0f
    equb &cc, &d3, &53, &3b, &83
    equb &71, &b2, &6f, &f3, &f1
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
    equb &00, &00, &00, &00, &00, &00
; ***************************************************************************************
; Choose the heroes and the sound
;
; Clear the left of the screen, print the menu and let the players toggle each hero (keys
; 1-4) and the sound (5 on, 6 off). SPACE starts the game if at least one hero is
; playing.
; &0500 referenced 1 time by &0e11
.hero_menu
    lda #&1c
    jsr oswrch
    lda #0
    jsr oswrch
    lda #&18
    jsr oswrch
    lda #&13
    jsr oswrch
    lda #0
    jsr oswrch
    lda #&0c
    jsr oswrch
    jsr print_menu
    jmp code_0581
; ***************************************************************************************
; Print the menu text
;
; Print the sixteen positioned strings of menu_text.
; &0524 referenced 3 times by &051e, &05c3, &05f0
.print_menu
    ldx #&0f
    ldy #0
; &0528 referenced 1 time by &052c
.loop_0528
    jsr print_menu_string
    dex
    bne loop_0528
; ***************************************************************************************
; Print one menu string
;
; Move the text cursor to the column and row in the two bytes at menu_text+Y, then print
; the following characters up to and including a carriage return.
;
; On Entry:
;     Y: offset of the string in menu_text
;
; On Exit:
;     Y: offset of the next string
; &052e referenced 1 time by &0528
.print_menu_string
    lda #&1f
    jsr oswrch
    lda data_0600,y
    jsr oswrch
    iny
    lda data_0600,y
    jsr oswrch
; &0540 referenced 1 time by &0549
.loop_0540
    iny
    lda data_0600,y
    jsr oswrch
    cmp #&0d
    bne loop_0540
    iny
    rts
; ***************************************************************************************
; Change a menu entry to NO
;
; Write "NO " at menu_text+Y.
;
; On Entry:
;     Y: offset of the entry
; &054d referenced 1 time by &05c0
.set_menu_no
    lda #&4e ; 'N'
    sta data_0600,y
    lda #&4f ; 'O'
    sta data_0601,y
    lda #&20 ; ' '
    sta data_0602,y
    rts
; ***************************************************************************************
; Change a menu entry to YES
;
; Write "YES" at menu_text+Y.
;
; On Entry:
;     Y: offset of the entry
; &055d referenced 1 time by &05ba
.set_menu_yes
    lda #&59 ; 'Y'
    sta data_0600,y
    lda #&45 ; 'E'
    sta data_0601,y
    lda #&53 ; 'S'
    sta data_0602,y
    rts
; ***************************************************************************************
; Change the sound entry to OFF
;
; Write "FF" at menu_text+Y, after its "O".
;
; On Entry:
;     Y: offset of the entry's second character
; &056d referenced 1 time by &05e4
.set_menu_off
    lda #&46 ; 'F'
    sta data_0600,y
    sta data_0601,y
    rts
; ***************************************************************************************
; Change the sound entry to ON
;
; Write "N " at menu_text+Y, after its "O".
;
; On Entry:
;     Y: offset of the entry's second character
; &0576 referenced 1 time by &05dd
.set_menu_on
    lda #&4e ; 'N'
    sta data_0600,y
    lda #&20 ; ' '
    sta data_0601,y
    rts
; &0581 referenced 6 times by &0521, &0598, &059c, &05c6, &05d3, &05f3
.code_0581
    lda #osbyte_flush_buffer_class
    jsr osbyte                          ; Flush selected class of buffer
    lda #osbyte_kbd_status
    ldx #&20 ; ' '
    ldy #0
    jsr osbyte                          ; osbyte: kbd status
    jsr osrdch
    cmp #&20 ; ' '
    beq code_05c9
    cmp #&31 ; '1'
    bcc code_0581
    cmp #&37 ; '7'
    bcs code_0581
    sec
    sbc #&31 ; '1'
    tax
    cmp #4
    bcs code_05d7
    asl a
    sta plot_x
    asl a
    clc
    adc plot_x
    adc #&51 ; 'Q'
    tay
    lda hero_absent,x
    eor #1
    sta hero_absent,x
    bne code_05c0
    jsr set_menu_yes
    jmp code_05c3
; &05c0 referenced 1 time by &05b8
.code_05c0
    jsr set_menu_no
; &05c3 referenced 1 time by &05bd
.code_05c3
    jsr print_menu
    jmp code_0581
; &05c9 referenced 1 time by &0594
.code_05c9
    ldx #3
; &05cb referenced 1 time by &05d1
.loop_05cb
    lda hero_absent,x
    beq return_3
    dex
    bpl loop_05cb
    jmp code_0581
; &05d6 referenced 1 time by &05ce
.return_3
    rts
; &05d7 referenced 1 time by &05a4
.code_05d7
    ldy #&99
    cmp #5
    beq code_05e4
    jsr set_menu_on
    ldx #0
    beq code_05e9
; &05e4 referenced 1 time by &05db
.code_05e4
    jsr set_menu_off
    ldx #1
; &05e9 referenced 1 time by &05e2
.code_05e9
    lda #osbyte_sound_suppression
    ldy #0
    jsr osbyte                          ; osbyte: sound suppression
    jsr print_menu
    jmp code_0581
.sub_05f6
; &0600 used as index base 7 times by &0533, &053a, &0541, &054f, &055f, &056f, &0578
data_0600 = sub_05f6+10
; &0601 used as index base 4 times by &0554, &0564, &0572, &057d
data_0601 = sub_05f6+11
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &4f, &06, &00
; &0602 used as index base 2 times by &0559, &0569
.data_0602
    equs "DUNJUNZ"
    equb &0d, &00, &02
    equs "HERO"
    equb &0d, &0c, &02
    equs "PLAYING"
    equb &0d, &00, &04
    equs "1 RANGER"
    equb &0d, &00, &05
    equs "2 MAGIC-USER"
    equb &0d, &00, &06
    equs "3 BARBARIAN"
    equb &0d, &00, &07
    equs "4 FIGHTER"
    equb &0d, &0e, &04
    equs "YES"
    equb &0d, &0e, &05
    equs "YES"
    equb &0d, &0e, &06
    equs "YES"
    equb &0d, &0e, &07
    equs "YES"
    equb &0d, &00, &09
    equs "TYPE NUMBER"
    equb &0d, &00, &0a
    equs "TO TOGGLE"
    equb &0d, &00, &0d
    equs "SOUND ON(5) OFF(6)"
    equb &0d, &07, &0f
    equs "ON "
    equb &0d, &03, &14
    equs "SPACE TO PLAY"
    equb &0d, &00, &0d, &a9, &63
; ***************************************************************************************
; Take the heroes nobody plays out of the game
;
; Draw any ten-thousands score digits, then put every hero switched off on the menu out
; of play, with a &64 entry in returning_hero_queue in their place.
; &06b0 referenced 1 time by &0e5d
.remove_absent_heroes
    ldx #0
    ldy #0
; &06b4 referenced 1 time by &06f3
.loop_06b4
    lda hero_score_ten_thousands,x
    cmp #&6a ; 'j'
    bcc code_06c9
    txa
    pha
    tya
    pha
    lda hero_score_ten_thousands,x
    jsr code_041e
    pla
    tay
    pla
    tax
; &06c9 referenced 1 time by &06b9
.code_06c9
    lda hero_absent,x
    beq code_06f0
    lda #0
    sta hero_direction,x
    lda #&63 ; 'c'
    sta hero_step,x
    lda #8
    sta hero_frame,x
    lda #&1d
    sta hero_health_tens,x
    dec hero_score_units,x
    lda #&1f
    sta hero_x,x
    lda #&64 ; 'd'
    sta returning_hero_queue,y
    iny
; &06f0 referenced 1 time by &06cc
.code_06f0
    inx
    cpx #4
    bne loop_06b4
    rts
    equb &00, &00
; &06f8 used as index base 6 times by &040f, &0412, &041b, &06b4, &06bf, &0ef3
.hero_score_ten_thousands
    equs "iiii"
; &06fc used as index base 4 times by &05b0, &05b5, &05cb, &06c9
.hero_absent
    equb &00, &00, &00, &00
    equs "*SAVE Dunjunz.K 400 7FF 740"
    equb &0d, &54, &50, &0d, &0d, &50, &0d
    equs "Alabel+2:LDA#255:.label JSR&30"
    equb &a2, &00, &a0, &6b, &a9, &f0, &8d, &00
    equb &6b, &a9, &07, &8d, &01, &6b, &a9, &00
    equb &8d, &02, &6b, &8d, &04, &6b, &8d, &05
    equb &6b, &a9, &20, &8d, &03, &6b, &ad, &12
    equb &02, &8d, &6d, &07, &ad, &13, &02, &8d
    equb &6e, &07, &a9, &ff, &20, &7d, &f2, &4c
    equb &00, &20, &00, &00, &00, &00, &00, &00
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
    equs "Dunjunz1"
    equb &0d, &00, &00, &00, &00, &00, &00, &00
    equb &ff, &00, &00, &00, &00, &00, &00, &00
    equb &c0, &c0, &c0, &c0, &04, &04, &04, &04
    equb &00, &00, &00, &64, &00, &00, &00, &ff
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &05, &00, &00, &00, &ff
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &ff, &00, &00, &00, &00, &f0, &00, &0e
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &64, &02, &90, &64, &02, &07, &90, &64
    equb &07, &90, &64, &02, &90, &64, &07, &90
    equb &0d, &0d, &0d, &0d, &0d, &0d, &0d, &0d
    equb &0d, &0d, &0d, &0d, &0d, &0d, &0d, &0d
    equb &0d, &0d, &0d, &0d, &0d, &0d, &0d, &0d
    equb &0d, &0d, &0d, &0d, &0d, &0d, &0d, &0d
    equb &0d, &0d, &0d, &0d, &0d, &0d, &0d, &0d
    equb &0d, &0d, &0d, &0d, &0d, &0d, &0d, &0d
    equb &0d, &0d, &0d, &0d, &0d, &0d, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &0d
    equb &80, &05, &05, &05, &05, &05, &05, &80
    equb &00, &00, &f6, &80, &80, &00, &00, &00
    equb &01, &f6, &f6, &f6, &03, &03, &03, &64
    equb &fd, &00, &f9, &80, &14, &00, &00, &00
    equb &80, &00, &00, &00, &01, &1e, &1e, &80
    equb &00, &00, &fe, &80, &80, &00, &00, &00
    equb &01, &14, &0a, &05, &02, &02, &02, &01
    equb &00, &00, &ff, &80, &80, &00, &00, &00
; ***************************************************************************************
; Plot a sprite
;
; Copy sprite sprite_number to the screen with its top-left corner at byte column plot_x,
; pixel row plot_y. The sprite tables give the address of its data and its size; the data
; is stored row by row, sprite_width bytes to a row, and is written over the screen
; contents without masking. The screen is laid out like MODE 2 with 640-byte character
; rows from &3000, so successive bytes of a sprite row are 8 bytes apart, and each pixel
; row starts one byte below the last, or 640-7 bytes on when it crosses into the next
; character row.
;
; On Entry:
;     PLOT_X: screen byte column (0-79)
;     PLOT_Y: pixel row
;     SPRITE_NUMBER: sprite to plot
;
; On Exit:
;     A: corrupted
;     X: 0
;     Y: 0
; &0900 referenced 21 times by &042e, &043d, &0f79, &15cd, &1daa, &1e20, &1e7d, &20ca, &7276, &7286, &72cf, &72df, &72ef, &72ff, &7613, &7838, &7842, &78aa, &78c4, &78de, &78f8
.plot_sprite
    ldx sprite_number                   ; X = sprite number
    lda sprite_addr_lo,x                ; Point sprite_data_ptr at the sprite's data...
    sta sprite_data_ptr                 ; ...low byte
    lda sprite_addr_hi,x                ; ...high byte from its own table
    sta sprite_data_ptr_hi              ; ...
    lda sprite_widths,x                 ; Width in screen bytes
    sta sprite_width                    ; ...for the inner loop
    lda sprite_heights,x                ; Height in pixel rows
    sta sprite_height                   ; ...for the outer loop
    jsr screen_address                  ; screen_ptr = address of the top-left byte
    ldy #0                              ; Index stays 0: the pointers themselves advance
    ldx sprite_height                   ; X counts the pixel rows still to plot
; &091d referenced 1 time by &0964
.loop_091d
    lda screen_ptr                      ; Remember where this pixel row starts...
    sta row_start_ptr                   ; ...
    lda screen_ptr_hi                   ; ...
    sta row_start_ptr_hi                ; ...in row_start_ptr
    txa                                 ; Save the row count
    pha                                 ; ...
    ldx sprite_width                    ; X counts the bytes across this row
; &0929 referenced 1 time by &093f
.loop_0929
    lda (sprite_data_ptr),y             ; Copy one sprite byte...
    sta (screen_ptr),y                  ; ...to the screen
    clc                                 ; Step screen_ptr right one byte column: 8 bytes on
    lda screen_ptr                      ; ...
    adc #8                              ; ...
    sta screen_ptr                      ; ...
    bcc code_0938                       ; ...
    inc screen_ptr_hi                   ; ...with carry into the high byte
; &0938 referenced 1 time by &0934
.code_0938
    inc sprite_data_ptr                 ; Next sprite data byte
    bne code_093e                       ; ...
    inc sprite_data_ptr_hi              ; ...with carry into the high byte
; &093e referenced 1 time by &093a
.code_093e
    dex                                 ; Count the bytes across
    bne loop_0929                       ; Loop until the row is done
    clc                                 ; screen_ptr = row start + 1: the next pixel row down
    lda row_start_ptr                   ; ...
    adc #1                              ; ...
    sta screen_ptr                      ; ...
    lda row_start_ptr_hi                ; ...
    adc #0                              ; ...
    sta screen_ptr_hi                   ; ...
    lda screen_ptr                      ; Has it crossed into the next character row?
    and #7                              ; ...(pixel row within the character now 0)
    bne code_0961                       ; No: carry on
    clc                                 ; Yes: add 640-8 to reach the top pixel row of the...
    lda screen_ptr                      ; ...character row below
    adc #&78 ; 'x'                      ; ...
    sta screen_ptr                      ; ...
    lda screen_ptr_hi                   ; ...
    adc #2                              ; ...
    sta screen_ptr_hi                   ; ...
; &0961 referenced 1 time by &0952
.code_0961
    pla                                 ; Recover the row count
    tax                                 ; ...
    dex                                 ; Count the pixel rows
    bne loop_091d                       ; Loop until the sprite is done
    rts                                 ; Return
; ***************************************************************************************
; Calculate a screen address
;
; Set screen_ptr to the screen address of byte column plot_x on pixel row plot_y: &3000 +
; 640 x (plot_y DIV 8) + (plot_y MOD 8) + 8 x plot_x. The multiplication by 640 is done
; with a table inside MOS 1.20 (mos_row_offsets), so this only works with that MOS.
;
; On Entry:
;     PLOT_X: screen byte column (0-79)
;     PLOT_Y: pixel row
;
; On Exit:
;     SCREEN_PTR: screen address
;     A: corrupted
;     Y: corrupted
;     X: preserved
; &0967 referenced 1 time by &0916
.screen_address
    lda plot_y                          ; Character row = plot_y DIV 8...
    lsr a                               ; ...
    lsr a                               ; ...
    and #&fe                            ; ...times 2 to index the table's byte pairs
    tay                                 ; ...
    lda mos_row_offsets,y               ; High byte of row x 640, from the MOS table...
    clc                                 ; ...
    adc #&30 ; '0'                      ; ...plus &30: the screen starts at &3000
    sta screen_ptr_hi                   ; ...
    lda mos_row_offsets_lo,y            ; Low byte of row x 640
    sta screen_ptr                      ; ...
    lda plot_y                          ; Add the pixel row within the character...
    and #7                              ; ...
    adc screen_ptr                      ; ...(no carry: the low byte is &00 or &80)
    sta screen_ptr                      ; ...
    clc                                 ; Add 8 x plot_x: first its top three bits...
    lda plot_x                          ; ...
    and #&e0                            ; ...
    rol a                               ; ...rotated down to bits 0-2...
    rol a                               ; ...
    rol a                               ; ...
    rol a                               ; ...
    clc                                 ; ...
    adc screen_ptr_hi                   ; ...into the high byte
    sta screen_ptr_hi                   ; ...
    lda plot_x                          ; ...then plot_x x 8 into the low byte
    asl a                               ; ...
    asl a                               ; ...
    asl a                               ; ...
    clc                                 ; ...
    adc screen_ptr                      ; ...
    sta screen_ptr                      ; ...
    bcc return_4                        ; ...
    inc screen_ptr_hi                   ; ...with carry into the high byte
; &099f referenced 1 time by &099b
.return_4
    rts                                 ; Return
.sub_09a0
; &09f0 referenced 4 times by &1f7a, &1fa7, &1fd3, &2026
data_09f0 = sub_09a0+80
; &09f1 referenced 4 times by &1f80, &1fad, &1fd9, &202c
data_09f1 = sub_09a0+81
; &09f2 referenced 5 times by &14ad, &1f10, &1f96, &2034, &2078
data_09f2 = sub_09a0+82
; &09f3 referenced 5 times by &1fbe, &1fc3, &1fce, &1ff4, &2086
data_09f3 = sub_09a0+83
; &09f4 referenced 3 times by &1fdf, &1ff7, &208b
data_09f4 = sub_09a0+84
; &09f5 referenced 3 times by &1f9e, &1fba, &207e
data_09f5 = sub_09a0+85
; &09f6 referenced 1 time by &2042; also used as index base 1 time by &1fe2
data_09f6 = sub_09a0+86
; &09f7 referenced 1 time by &14be
data_09f7 = sub_09a0+87
; &09f8 referenced 1 time by &14c1
data_09f8 = sub_09a0+88
; &09f9 referenced 1 time by &14b0
data_09f9 = sub_09a0+89
; &09fa referenced 1 time by &14b3; also used as index base 1 time by &1fe7
data_09fa = sub_09a0+90
; &09fb referenced 1 time by &14ce
data_09fb = sub_09a0+91
; &09fc referenced 1 time by &14d3
data_09fc = sub_09a0+92
; &09fd referenced 1 time by &14c4
data_09fd = sub_09a0+93
; &09fe referenced 1 time by &14b6
data_09fe = sub_09a0+94
; &09ff referenced 4 times by &14c9, &1f2d, &2045, &2081
data_09ff = sub_09a0+95
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &ff, &ff, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &04, &2c, &00, &ff, &00, &03, &04, &01
    equb &01, &00, &00, &05, &03, &01, &00, &ff
    equb &00, &00, &00, &00, &00, &00, &00, &15
    equb &00, &00, &00, &3f, &00, &00, &00, &3f
    equb &00, &01, &13, &2a, &00, &01, &13, &2a
    equb &00, &01, &13, &00, &00, &03, &13, &00
    equb &03, &03, &33, &00, &03, &03, &33, &00
    equb &03, &03, &33, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equs "*<", &22, "**<", &22, "**<", &22, "*"
    equb &14, &14, &11, &00, &14, &00, &11, &00
    equb &14, &28, &39, &00, &14, &3c, &33, &00
    equb &14, &3c, &33, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &01, &02, &00, &00, &15, &2a, &00
    equb &00, &05, &02, &00, &00, &05, &02, &00
    equb &00, &05, &02, &00, &00, &05, &02, &00
    equb &00, &0f, &03, &00, &05, &0f, &0b, &02
    equb &05, &0f, &0b, &02, &05, &0f, &03, &02
    equb &00, &0f, &03, &00, &00, &00, &00, &00
    equb &00, &54, &00, &54, &00, &00, &00, &00
    equb &54, &00, &04, &00, &00, &00, &04, &00
    equs "??."
    equb &0c, &15, &3f, &2e, &00, &00, &00, &04
    equb &54, &a8, &00, &00, &00, &00, &54, &00
    equb &00, &00, &00, &00, &a8, &00, &00, &00
    equb &00, &2a, &00, &00, &02, &05, &00, &00
    equb &02, &00, &0a, &15, &01, &00, &04, &1d
    equb &01, &01, &04, &15, &01, &05, &00, &15
    equb &01, &05, &00, &15, &02, &05, &00, &15
    equb &02, &00, &15, &15, &00, &02
    equs "*3", &22
    equb &01, &00, &11, &00, &02, &02, &11, &00
    equb &00, &0f, &02, &00, &00, &0f, &02, &00
    equb &00, &1f, &02, &00, &3f, &1f, &0f, &02
    equb &0f, &1f, &0f, &02, &0f, &1f, &0f, &02
    equb &00, &0f, &02, &00, &00, &0f, &02, &00
    equb &00, &2f, &02, &00, &00, &2f, &02, &00
    equb &00, &0f, &02, &00, &00, &0f, &02, &00
; &0b20 used as index base 9 times by &0ed2, &0f2b, &0f30, &6f22, &751a, &751d, &7526, &75c5, &75ca
.hero_max_missiles
    equb &03, &02, &01, &03
; &0b24 used as index base 1 time by &7624
.hero_magic_key
    equb &fe, &b6
; &0b26 used as index base 3 times by &7619, &7621, &7644
.hero_magic_delay
    equb &01, &01
; &0b28 referenced 3 times by &765e, &768f, &7699
.magic_kill_count
    equb &00, &10
; &0b2a referenced 3 times by &7421, &742b, &7432; also used as index base 6 times by &06ec, &159c, &16b4, &16bb, &7256, &725f
.returning_hero_queue
; &0b2b referenced 2 times by &742f, &7438
data_0b2b = returning_hero_queue+1
; &0b2c referenced 2 times by &7435, &743e
data_0b2c = returning_hero_queue+2
; &0b2d referenced 2 times by &743b, &7441
data_0b2d = returning_hero_queue+3
    equb &03, &02, &01, &04, &10
; &0b2f referenced 5 times by &14b9, &7cb3, &7cb6, &7cbf, &7cc2
.next_trapdoor
    equb &04
; &0b30 used as index base 1 time by &76f2
.hero_appearance_sprites
    equb &16, &17, &18, &19
    equs "defgh"
    equb &10, &10, &10, &10, &10, &10, &10
; &0b40 used as index base 4 times by &1592, &758d, &759e, &75a6
.monster_hit_points
    equb &10, &08, &08, &08, &08, &08, &08, &08
    equb &08, &08, &08, &08, &08, &08, &08, &05
    equb &08, &08, &08, &08, &08, &08, &08, &08
    equb &08, &08, &08, &08, &08, &08, &08, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
; &0b70 used as index base 7 times by &0ed8, &0f50, &6f4a, &756b, &756e, &7577, &75ee
.hero_missile_damage
    equb &02, &03, &09, &03, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
; &0b80 used as index base 3 times by &6f4d, &71f0, &7591
.missile_damage
; &0b8f used as index base 1 time by &79cd
data_0b8f = missile_damage+15
    equb &02, &02, &02, &03, &03, &04, &09, &09
    equb &10, &03, &03, &03, &10, &10, &10, &10
; &0b90 used as index base 2 times by &1554, &7cc5
.trapdoor_x
; &0b97 used as index base 1 time by &79d3
data_0b97 = trapdoor_x+7
    equb &0b, &15, &17, &10, &03, &17, &0d, &1a
; &0b98 used as index base 2 times by &155a, &7ccb
.trapdoor_y
    equb &04, &0c, &14, &1d
    equs "% (,"
; &0ba0 used as index base 5 times by &0ee6, &72aa, &72ad, &72b6, &72d4
.hero_score_hundreds
    equb &1e, &1e, &1e, &1e
; &0ba4 used as index base 5 times by &0ee9, &729b, &729e, &72a7, &72e4
.hero_score_tens
    equb &1e, &1e, &1e, &1e
; &0ba8 used as index base 7 times by &06e2, &0eee, &728c, &728f, &7298, &72f4, &74cf
.hero_score_units
    equb &1d, &1d, &1d, &1d
; &0bac used as index base 5 times by &0400, &0403, &040c, &0ee3, &72c8
.hero_score_thousands
; &0bfc referenced 2 times by &1d0f, &1d1d
data_0bfc = hero_score_thousands+80
    equb &1e, &1e, &1e, &1e, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &13, &00, &04, &00
    equb &64, &00, &1e, &00, &13, &00, &02, &00
    equb &c8, &00, &02, &00
; &0c00 used as index base 3 times by &1567, &7fc8, &7feb
.room_walls
    equs "TIKP$UTHO[KF,D]/DYW3CZD\8V\;VHRVao"
    equb &02
    equs "brlu"
    equb &07, &00, &6a, &03, &0b, &1d, &14, &16
    equb &19, &10
    equs "pgtafb"
    equb &19, &71, &19
; &0c3a used as index base 1 time by &10ba
.data_0c3a
    equs "rzjx"
    equb &1e, &78, &09, &17, &07, &0d, &64, &0b
    equb &09, &05, &07, &0d, &13, &6b, &1c, &08
    equb &1c, &02, &19, &02, &01, &1a, &1b, &1b
    equb &76, &03, &17, &79, &17, &1a, &0e, &16
    equb &1b, &0b
    equs "@5**7E!&%,J2)9N.>5R2:,V86<Z)9<:6"
    equb &ce, &c6, &a2, &d7, &cc, &cc, &d5, &a7
    equb &c1, &da, &aa, &ca, &ac, &cb, &a4, &a5
    equb &ba, &bb, &b8, &d4, &b4, &d7, &bc, &bd
    equb &b2, &b3, &b0, &df, &bc, &d4, &d8, &bf
    equb &f4, &e9, &e7, &fa, &84, &e4, &f4, &e2
    equb &88, &ea, &e5, &e5, &ff, &e4, &ea, &ea
    equb &e2, &f8, &fc, &f4, &94, &f0, &e4, &f6
    equb &eb, &f0, &f4, &fc, &9c, &e9, &f6, &f6
    equb &93, &e1, &8f, &86, &97, &96, &87, &80
    equb &8d, &e7, &9e, &83, &8d, &83, &85, &90
; &0cd0 used as index base 7 times by &0ede, &0f1e, &74ef, &74f2, &74f9, &75bd, &79a7
.hero_damage_taken
; &0cf4 referenced 2 times by &7481, &7491
data_0cf4 = hero_damage_taken+36
    equb &89, &9e, &87, &f3, &95, &9b, &92, &f7
    equb &90, &98, &8a, &8b, &85, &fd, &9a, &8a
    equb &ae, &a6, &a7, &ac, &aa, &ac, &a8, &a0
    equb &c9, &00, &00, &00, &00, &00, &00, &00
    equb &10, &00, &01, &00, &06, &00, &06, &00
    equb &12, &00, &03, &00, &c8, &00, &0a, &00
; &0d00 referenced 49 times by &1cc5, &1d00, &1d4e, &1d52, &1d55, &1d58, &1d77, &1d82, &2006, &200d, &201e, &205a, &2063, &2070, &6f19, &6f1e, &6f25, &6f71, &6fd7, &7002, &7007, &713c, &74b6, &74c3, &74d8, &77e6, &782c, &7857, &785b, &785e, &7861, &7886, &788b, &7901, &7905, &7908, &790b, &7926, &7931, &793d, &7941, &7944, &7947, &7962, &796d, &7976, &7990, &7a89, &7ce3; also used as index base 1 time by &14a5
.scratch
    equb &a9
; &0d01 referenced 8 times by &203a, &207b, &74d2, &7503, &7509, &750c, &7829, &782f
.scratch2
    equb &70
; &0d02 referenced 59 times by &119c, &11f4, &1ccb, &1cdb, &1d26, &1d3c, &1d5d, &1d6c, &1dd1, &1e38, &1e48, &1f58, &1faa, &1fd6, &2094, &20a7, &20de, &20e9, &20fa, &6fa7, &700f, &707c, &70aa, &70ee, &7120, &715b, &7176, &71e3, &7310, &732c, &733a, &73f0, &752f, &766a, &777d, &779b, &77ad, &77bf, &77d1, &7801, &7820, &7867, &7872, &787c, &789e, &78b8, &78d2, &78ec, &7910, &791d, &794c, &7959, &797b, &7997, &79d0, &79ea, &7a48, &7b07, &7b44
.cell_x
    equb &8d
; &0d03 referenced 55 times by &11a1, &11f9, &1cd1, &1ce6, &1d20, &1d42, &1d49, &1d7a, &1dd7, &1e3e, &1e50, &1f5e, &1fb0, &1fdc, &209a, &20ad, &20d0, &20db, &20ec, &20f7, &6fad, &7017, &7082, &70b0, &70f4, &7126, &7161, &717e, &71eb, &7316, &7332, &7345, &73fc, &7535, &7670, &7783, &7807, &7852, &787f, &7890, &78a5, &78bf, &78d9, &78f3, &78fc, &7929, &7938, &7965, &7983, &799f, &79d6, &79f3, &7a4e, &7b0d, &7b4a
.cell_y
    equb &80
; &0d04 referenced 7 times by &7864, &786c, &786f, &7896, &78b0, &78ca, &78e4
.cell_room
    equb &0d, &a9
; &0d06 referenced 11 times by &6e9a, &6f56, &6fbb, &6fe5, &7021, &7069, &7079, &79ed, &7a58, &7a95, &7af8
.previous_x
    equb &0d
; &0d07 referenced 11 times by &6ea0, &6f5c, &6fc1, &6feb, &7027, &706f, &707f, &79f6, &7a5e, &7a9b, &7afe
.previous_y
    equb &8d
; &0d08 referenced 2 times by &6ea6, &7085
.previous_offset_x
    equb &81
; &0d09 referenced 2 times by &6eac, &708a
.previous_offset_y
    equb &0d, &a9, &00, &8d, &82, &0d, &a9
; &0d10 used as index base 29 times by &06e7, &1dfd, &1e35, &1e89, &1f38, &1f55, &1f74, &2091, &6e97, &6f39, &6f59, &6f87, &6f95, &6f98, &6fa4, &6fbe, &6fe8, &700c, &7024, &706c, &70a7, &71e0, &7329, &73ed, &752c, &777a, &799a, &7bbd, &7bcb
.hero_x
    equb &20, &8d, &83, &0d, &a2
; &0d15 used as index base 27 times by &1e03, &1e3b, &1e8f, &1f40, &1f5b, &2097, &6e9d, &6f3f, &6f5f, &6f80, &6f8e, &6f9e, &6faa, &6fc4, &6fee, &7014, &702a, &7072, &70ad, &71e8, &732f, &73f9, &7532, &7780, &79a2, &7bb6, &7bc4
.hero_y
; &0d19 used as index base 1 time by &1f17
data_0d19 = hero_y+4
    equb &80, &a0, &0d, &a9, &00
; &0d1a used as index base 18 times by &06d0, &1de6, &1f52, &6e82, &6ecb, &6ede, &6ef1, &6f04, &6f2d, &6f79, &701c, &7097, &7221, &7249, &7452, &7711, &7b67, &7baf
.hero_direction
; &0d1f used as index base 1 time by &1f23
data_0d1f = hero_direction+5
    equb &8d, &84, &0d, &8d, &85, &0d
; &0d20 referenced 2 times by &774e, &7753; also used as index base 12 times by &06da, &1df3, &6f62, &6f67, &709c, &7457, &76ee, &76ff, &771f, &772e, &7ba2, &7ba7
.hero_frame
; &0d21 referenced 2 times by &775b, &7760
data_0d21 = hero_frame+1
; &0d22 referenced 2 times by &7768, &776d
data_0d22 = hero_frame+2
; &0d23 referenced 2 times by &7771, &7776
data_0d23 = hero_frame+3
    equb &ad, &12, &02, &8d, &2f
; &0d25 used as index base 12 times by &06d5, &1f4d, &6e87, &6eaf, &6fc9, &6ff3, &702f, &7063, &7401, &7716, &7b64, &7baa
.hero_step
    equb &0d, &ad, &13, &02, &8d
; &0d2a used as index base 19 times by &6ea3, &6fcc, &6ff6, &7032, &705d, &724e, &7404, &745c, &7702, &7719, &7735, &7b70, &7b84, &7b8e, &7b9e, &7bd0, &7bd7, &7bda, &7bdd
.hero_offset_x
    equb &30, &0d, &a9, &ff, &20, &7d
; &0d30 used as index base 20 times by &6ea9, &6fcf, &6ff9, &7035, &7060, &7251, &7407, &7461, &76da, &76e2, &771c, &773a, &7b75, &7b7f, &7b93, &7b99, &7bd3, &7be1, &7be4, &7be7
.hero_offset_y
    equb &f2
; ***************************************************************************************
; Start the game
;
; Set the bell sound (the BEL character's channel, envelope, pitch and duration), save
; WRCHV in saved_wrchv and point WRCHV at wrch_handler. The code here is run once only:
; from &0D40 its bytes are then reused as the missile tables and other workspace in page
; &0D, which reset_workspace refreshes for each level.
.game_entry
    lda #osbyte_bell_channel            ; OSBYTE &D3: bell channel...
    ldx #&11                            ; ...channel &11
    ldy #0
    jsr osbyte                          ; ...  osbyte: bell channel
    lda #osbyte_bell_envelope           ; OSBYTE &D4: bell envelope...
    ldx #0                              ; ...0, a fixed amplitude
    ldy #0
; &0d40 used as index base 6 times by &6f3c, &70eb, &710c, &711a, &711d, &7158
.missile_x
    jsr osbyte                          ; ...  osbyte: bell envelope
    lda #osbyte_bell_frequency          ; OSBYTE &D5: bell pitch...
    ldx #&64 ; 'd'                      ; ...&64
    ldy #0
    jsr osbyte                          ; ...  osbyte: bell frequency
; &0d4c used as index base 6 times by &6f42, &70f1, &7105, &7113, &7123, &715e
.missile_y
    lda #osbyte_bell_duration           ; OSBYTE &D6: bell duration...
    ldx #1                              ; ...1
    ldy #0
    jsr osbyte                          ; ...  osbyte: bell duration
    lda wrchv                           ; Save WRCHV...
; &0d58 used as index base 12 times by &6f28, &6f36, &70d2, &70de, &70fe, &7134, &71a5, &71ae, &71ba, &71c6, &71ce, &720c
.missile_direction
    sta saved_wrchv                     ; ...
    lda wrchv + 1                       ; ...
    sta data_12d4                       ; ...in saved_wrchv
    lda #&8f                            ; Point WRCHV at wrch_handler...
.sub_0d63
; &0d64 used as index base 4 times by &6f53, &7209, &76b1, &7747
missile_sprite_base = sub_0d63+1
    sta wrchv                           ; ...
    lda #&7f                            ; ...
    sta wrchv + 1                       ; ...
    jmp code_0e00
    equb &00, &00
; &0d70 used as index base 1 time by &6ec1
.hero_key_up
    equs "Dunj"
; &0d74 used as index base 1 time by &6ed4
.hero_key_down
    equs "unz5"
; &0d78 used as index base 1 time by &6ee7
.hero_key_right
    equb &0d, &00, &8d, &f4
; &0d7c used as index base 1 time by &6efa
.hero_key_left
    equb &0d, &8d, &f5, &0d
; &0d80 used as index base 1 time by &6f0d
.hero_key_fire
; &0d8f used as index base 1 time by &1f1c
data_0d8f = hero_key_fire+15
    equb &70, &0d, &00, &20, &00, &00, &6e, &35
    equb &0d, &18, &bd, &04, &0d, &69, &03, &9d
; &0d90 used as index base 10 times by &06df, &0e6d, &7236, &7239, &726f, &738e, &7391, &739a, &7506, &7724
.hero_health_tens
    equb &1d, &1d, &1d, &1d, &d0
; &0d95 used as index base 7 times by &7227, &722a, &7233, &727b, &739d, &750f, &7727
.hero_health_units
    equs "''''"
    equb &18, &bd, &08, &0d, &6d, &40, &0d
; &0da0 referenced 2 times by &779e, &7893; also used as index base 3 times by &7043, &7544, &767c
.view_room
; &0da2 referenced 2 times by &77b0, &78ad
data_0da2 = view_room+2
; &0da4 referenced 2 times by &77c2, &78c7
data_0da4 = view_room+4
; &0da6 referenced 2 times by &77d4, &78e1
data_0da6 = view_room+6
    equb &18, &0c, &68, &0c, &28, &0c, &30, &0c
    equb &00, &00, &bd, &04, &0d, &85, &71, &8a
; &0db0 used as index base 1 time by &6f50
.hero_missile_sprites
    equb &10
    equs "DLHh"
; &0db5 used as index base 4 times by &1fcb, &1ffd, &2051, &709f
.hero_sprites
    equb &00
    equs ",4<"
    equb &00, &0d, &d9
; &0dbc used as index base 3 times by &7056, &7351, &74e7
.hero_has_boots
    equb &00, &00, &00, &00
; &0dc0 used as index base 3 times by &1d72, &7923, &795f
.bit_masks
    equb &80, &40, &20, &10, &08, &04, &02, &01
    equb &b9, &30, &0d, &9d, &08, &0d, &4c, &d4
; &0dd0 used as index base 10 times by &1d9c, &1e12, &1e6d, &20bc, &7266, &72bd, &75af, &75cf, &75e7, &75fe
.hero_panel_y
    equb &0e, &3c, &6a, &98, &e8, &e0, &04, &d0
    equb &0a, &a2, &00, &ad, &40, &0d, &49, &01
    equb &8d, &40, &0d, &8e, &ff, &0d, &68, &a8
    equb &68, &aa
    equs "h(`"
.sub_0ded
; &0dfd referenced 1 time by &73d3
data_0dfd = sub_0ded+16
; &0dff referenced 1 time by &1160
data_0dff = sub_0ded+18
    equb &de, &dd, &df, &f0, &f2, &f1, &f3, &f8
    equb &fa, &f9, &fb, &f4, &f6, &f5, &f7, &fc
    equb &1e, &fd, &00
; &0e00 referenced 2 times by &0d6b, &0ecc
.code_0e00
    lda #0
    sta level_number
    sta level_bcd
    tax
; &0e09 referenced 1 time by &0e0f
.loop_0e09
    jsr reset_hero
    inx
    cpx #4
    bne loop_0e09
    jsr hero_menu
; Play each level in turn until every hero is dead.
; &0e14 referenced 1 time by &0e84
.level_loop
    lda level_number                    ; Monster hit points = 8 + 2 x (levels played)...
    asl a                               ; ...
    clc                                 ; ...
    adc #8                              ; ...
    sta monster_start_hit_points        ; ...
    sed                                 ; Add 1 to the level number in decimal...
    clc                                 ; ...
    lda level_bcd                       ; ...
    adc #1                              ; ...
    sta level_bcd                       ; ...
    cld                                 ; ...
    lda level_number                    ; One digit for levels 1-9, two from 10 (the count is incremented later, in show_level_number)
    cmp #9                              ; ...
    bcs code_0e34                       ; ...
    ldx #0                              ; X = 0: one digit
    beq code_0e36
; &0e34 referenced 1 time by &0e2e
.code_0e34
    ldx #1                              ; X = 1: two digits
; &0e36 referenced 1 time by &0e32
.code_0e36
    lda level_bcd                       ; Units digit...
    and #&0f                            ; ...
    clc                                 ; ...as ASCII...
    adc #&30 ; '0'                      ; ...
    sta level_filename_digits,x         ; ...into the filename
    cpx #0                              ; Two digits?
    beq code_0e52                       ; No
    lda level_bcd                       ; Yes: the tens digit...
    lsr a                               ; ...
    lsr a
    lsr a
    lsr a
    clc                                 ; ...as ASCII...
    adc #&30 ; '0'                      ; ...
    sta level_filename_digits           ; ...goes first
; &0e52 referenced 1 time by &0e43
.code_0e52
    lda #&0d                            ; Terminate the filename with a carriage return
    sta data_16d6,x                     ; ...
    jsr start_level                     ; Load and draw the level
    jsr draw_status_panel               ; Draw the status panel
    jsr remove_absent_heroes            ; Take out the heroes nobody plays
    lda #1                              ; Let one vertical sync pass before play starts
    sta os_vsync_counter                ; ...
    jsr code_1f00                       ; Play the level until it ends
    ldx #0                              ; Count the heroes who died, giving each back their starting attributes
    stx count                           ; ...
; &0e6d referenced 1 time by &0e7d
.loop_0e6d
    lda hero_health_tens,x              ; Dead?
    cmp #&1d                            ; ...
    bne code_0e7a                       ; ...
    jsr reset_hero                      ; Yes: reset them
    inc count                           ; ...and count them
; &0e7a referenced 1 time by &0e72
.code_0e7a
    inx                                 ; Next hero
    cpx #4                              ; ...
    bne loop_0e6d                       ; ...
    lda count                           ; Any hero alive?
    cmp #4                              ; ...
    bne level_loop                      ; Yes: on to the next level
    lda #&1c                            ; All dead: VDU 28,0,24,16,0, a text window on the left...
    jsr oswrch
    lda #0
    jsr oswrch
    lda #&18
    jsr oswrch
    lda #&10
    jsr oswrch
    lda #0
    jsr oswrch
    lda #&0c                            ; ...VDU 12 to clear it
    jsr oswrch
    ldx #4                              ; Put spaces back over the four message bytes used as counters
    lda #&20 ; ' '                      ; ...
; &0ea8 referenced 1 time by &0eac
.loop_0ea8
    sta data_0ff0,x                     ; ...
    dex                                 ; ...
    bne loop_0ea8                       ; ...
; &0eae referenced 1 time by &0eb7
.loop_0eae
    lda game_over_message,x             ; Print game_over_message...
    jsr osasci                          ; ...
    inx                                 ; ...
    cmp #0                              ; ...up to its zero byte
    bne loop_0eae                       ; ...
; &0eb9 referenced 1 time by &0ebc
.loop_0eb9
    lda os_vsync_counter                ; Wait for the vertical sync counter to run out
    bne loop_0eb9                       ; ...
    lda #osbyte_flush_buffer_class      ; Flush the input buffers
    jsr osbyte                          ; ...  Flush selected class of buffer
    ldx #&70 ; 'p'                      ; Wait up to 6000 centiseconds (60 s) for a key...
    ldy #&17                            ; ...
    lda #osbyte_inkey                   ; ...
    jsr osbyte                          ; ...  INKEY: Scan for a key with positive X, or read internal key number EOR 128 for negative X
    jmp code_0e00                       ; ...then start a new game
; ***************************************************************************************
; Give a hero their starting attributes
;
; Set hero X's missile limit, missile damage and damage taken from the starting tables,
; and their score to zero. The units digit is set one below 0 because draw_status_panel
; draws the score by adding a point.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &0ecf referenced 2 times by &0e09, &0e74
.reset_hero
    lda hero_start_max_missiles,x       ; Starting missile limit...
    sta hero_max_missiles,x             ; ...
    lda hero_start_missile_damage,x     ; ...missile damage...
    sta hero_missile_damage,x           ; ...
    lda hero_start_damage_taken,x       ; ...and health lost per hit
    sta hero_damage_taken,x             ; ...
    lda #&1e                            ; Score 000...
    sta hero_score_thousands,x          ; ...
    sta hero_score_hundreds,x           ; ...
    sta hero_score_tens,x               ; ...
    lda #&1d                            ; ...with the units one below 0, for draw_status_panel to add a point
    sta hero_score_units,x              ; ...
    lda #&69 ; 'i'                      ; No ten-thousands digit
    sta hero_score_ten_thousands,x      ; ...
    rts                                 ; Return
; ***************************************************************************************
; Draw the status panel
;
; Draw each hero's section of the status panel to the right of the views: health and
; score (by taking a health point and adding a score point, from starting values one
; beyond those wanted), face, shield and armour rating, one icon per missile allowed, and
; missile damage.
; &0ef7 referenced 1 time by &0e5a
.draw_status_panel
    lda #0                              ; For each hero...
    sta panel_hero                      ; ...
; &0efc referenced 1 time by &0f65
.loop_0efc
    ldx panel_hero                      ; ...
    jsr lose_health_point               ; Draw the health (from the template's 99+1)
    jsr add_point                       ; Draw the score (from its starting 000 and one below 0)
    lda hero_faces,x                    ; Face, at column &45, row 0 of the section
    ldx #&45 ; 'E'                      ; ...
    ldy #0                              ; ...
    jsr plot_panel_sprite               ; ...
    ldx #&4d ; 'M'                      ; Shield, at column &4D, row 0
    ldy #0                              ; ...
    lda #&69 ; 'i'                      ; ...
    jsr plot_panel_sprite               ; ...
    ldx panel_hero                      ; Armour rating 10 - health lost per hit, as a small digit on the shield
    sec                                 ; ...
    lda #&73 ; 's'                      ; ...
    sbc hero_damage_taken,x             ; ...
    ldx #&4e ; 'N'                      ; ...
    ldy #2                              ; ...
    jsr plot_panel_sprite               ; ...
    ldx panel_hero                      ; One missile icon every three rows from row &10, for each missile allowed...
    lda hero_max_missiles,x             ; ...
    asl a                               ; ...
    clc                                 ; ...
    adc hero_max_missiles,x             ; ...
    adc #&10                            ; ...
    sta count                           ; ...(end row in count)
    ldy #&10                            ; ...
; &0f3a referenced 1 time by &0f4b
.loop_0f3a
    tya                                 ; ...
    pha                                 ; ...
    ldx #&4b ; 'K'                      ; ...at column &4B
    lda #&74 ; 't'                      ; ...
    jsr plot_panel_sprite               ; ...
    pla                                 ; ...
    clc                                 ; ...
    adc #3                              ; ...
    tay                                 ; ...
    cpy count                           ; ...
    bcc loop_0f3a                       ; ...
    ldx panel_hero                      ; Missile damage, as a small digit at column &4C, row &0A
    lda hero_missile_damage,x           ; ...
    clc                                 ; ...
    adc #&69 ; 'i'                      ; ...
    ldx #&4c ; 'L'                      ; ...
    ldy #&0a                            ; ...
    jsr plot_panel_sprite               ; ...
    inc panel_hero                      ; Next hero
    lda panel_hero                      ; ...
    cmp #4                              ; ...
    bne loop_0efc                       ; ...
    rts                                 ; Return
; ***************************************************************************************
; Plot a sprite in a hero's panel section
;
; Plot sprite A at byte column X and pixel row Y + hero_panel_y - 14 for the hero being
; drawn (draw_status_panel's loop counter).
;
; On Entry:
;     A: sprite number
;     X: byte column
;     Y: row within the hero's panel section
; &0f68 referenced 5 times by &0f0c, &0f15, &0f25, &0f40, &0f5a
.plot_panel_sprite
    stx plot_x                          ; Column
    sta sprite_number                   ; Sprite
    tya                                 ; Row = Y + this hero's panel row - 14...
    ldx panel_hero                      ; ...
    clc                                 ; ...
    adc data_7dd0,x                     ; ...(read from workspace_template, which page &0D copies)
    sec                                 ; ...
    sbc #&0e                            ; ...
    sta plot_y                          ; ...
    jsr plot_sprite                     ; Plot it
    rts                                 ; Return
    equb &00, &09, &60
; ***************************************************************************************
; Heroes' starting attributes
;
; Four tables of one byte per hero (Ranger, Magic-User, Barbarian, Fighter): missiles in
; flight, missile damage, health lost per hit, and the face sprite for the panel.
; &0f80 used as index base 1 time by &0ecf
.hero_start_max_missiles
    equb &03, &02, &01, &02
; &0f84 used as index base 1 time by &0ed5
.hero_start_missile_damage
    equb &02, &03, &09, &05
; &0f88 used as index base 1 time by &0edb
.hero_start_damage_taken
    equb &07, &09, &06, &04
; &0f8c used as index base 1 time by &0f05
.hero_faces
    equb &05, &31, &39, &41
; &0f90 used as index base 1 time by &0eae
.game_over_message
    equs "FAREWELL!        "
    equb &0d
    equs "THE QUEST HAS    "
    equb &0d
    equs "FAILED AND THE   "
    equb &0d
    equs "GODS ARE IN NO   "
    equb &0d
    equs "MOOD TO RESURRECT"
    equb &0d
.sub_0fea
; &0ff0 used as index base 1 time by &0ea8
data_0ff0 = sub_0fea+6
    equs "YOU ALL"
; &0ff1 referenced 8 times by &0ef9, &0efc, &0f18, &0f28, &0f4d, &0f5d, &0f60, &0f6d
.panel_hero
    equb &2e
; &0ff2 referenced 5 times by &0e6a, &0e77, &0e7f, &0f35, &0f48
.count
    equs "         "
    equb &0d
    equs "NEW ADVENTURERS  "
    equb &0d
    equs "MUST TAKE YOUR   "
    equb &0d
    equs "PLACE,BEGINNING  "
    equb &0d
    equs "BACK ON THE UPPER"
    equb &0d
    equs "MOST LEVEL.      "
    equb &0d, &0a
    equs "FIND THE CHALICE!"
    equb &00
    equs "ND!"
    equb &00
    equs "&C2"
; ***************************************************************************************
; Check whether the Chalice has been found
;
; On level 25, if a hero stands on the cell where the Chalice is, play the victory
; sequence, print the closing message, wait for a key and reset the machine through the
; RESET vector.
; &1070 referenced 1 time by &1f0a
.check_for_victory
    lda level_number
    cmp #&19
    bne return_5
    ldx #0
; &1079 referenced 1 time by &1087
.loop_1079
    lda hero_door_x,x
    cmp #&1a
    beq code_108a
    cmp #&1b
    beq code_108a
; &1084 referenced 1 time by &1095
.loop_1084
    inx
    cpx #4
    bne loop_1079
; &1089 referenced 1 time by &1075
.return_5
    rts
; &108a referenced 2 times by &107e, &1082
.code_108a
    lda hero_door_y,x
    cmp #4
    beq code_1097
    cmp #5
    beq code_1097
    bne loop_1084
; &1097 referenced 2 times by &108f, &1093
.code_1097
    jsr victory_sequence
    lda #&1c
    jsr oswrch
    lda #0
    jsr oswrch
    lda #&18
    jsr oswrch
    lda #&10
    jsr oswrch
    lda #0
    jsr oswrch
    lda #&0c
    jsr oswrch
    ldx #0
; &10ba referenced 1 time by &10c3
.loop_10ba
    lda data_0c3a,x
    jsr osasci
    inx
    cpx #&8c
    bne loop_10ba
    ldx #0
; &10c7 referenced 1 time by &10d0
.loop_10c7
    lda data_213a,x
    jsr osasci
    inx
    cmp #0
    bne loop_10c7
    lda #osbyte_flush_buffer_class
    jsr osbyte                          ; Flush selected class of buffer
    jsr osrdch
    lda data_fffc
    sta data_10e7
    lda data_fffd
    sta data_10e8
.sub_10e6
; &10e7 referenced 1 time by &10dd
data_10e7 = sub_10e6+1
; &10e8 referenced 1 time by &10e3
data_10e8 = sub_10e6+2
    jsr data_0000
; ***************************************************************************************
; Play the victory sequence
;
; Spin sprites round the Chalice with a rising tone, then dissolve it.
; &10e9 referenced 1 time by &1097
.victory_sequence
    lda #osbyte_bell_envelope
    ldx #8
    jsr osbyte                          ; osbyte: bell envelope
    lda #0
    sta data_007d
    sta data_007e
    lda #&16
    sta data_0082
    lda #0
    sta data_008f
    lda #&e6
    sta data_0084
    lda #&32 ; '2'
    sta data_008e
    lda #1
    sta data_008d
; &110a referenced 1 time by &1146
.code_110a
    clc
    lda data_008f
    adc data_008d
    sta data_008f
    bcc code_111c
    inc data_008d
    dec data_008e
    bne code_111c
    jmp code_11d3
; &111c referenced 2 times by &1111, &1117
.code_111c
    dec data_0084
    bne code_1124
    lda #1
    sta data_0084
; &1124 referenced 1 time by &111e
.code_1124
    ldx data_008f
    lda #osbyte_bell_frequency
    jsr osbyte                          ; osbyte: bell frequency
    lda #7
    jsr oswrch
    jsr draw_victory_ring
    lda data_0084
    cmp #1
    bne code_113c
    jsr dissolve_chalice
; &113c referenced 1 time by &1137
.code_113c
    ldx data_0084
; &113e referenced 1 time by &1144
.loop_113e
    ldy #&ff
; &1140 referenced 1 time by &1141
.loop_1140
    dey
    bne loop_1140
    dex
    bne loop_113e
    jmp code_110a
; ***************************************************************************************
; Draw the ring of sprites round the Chalice
;
; Plot the current victory sprite at the twelve cells round the Chalice, changing sprite
; as it goes.
; &1149 referenced 2 times by &1130, &11d7
.draw_victory_ring
    lda #&1c
    sta data_0080
    lda #3
    sta data_0081
    jsr plot_victory_sprite
    dec data_0080
    jsr plot_victory_sprite
    dec data_0080
    jsr plot_victory_sprite
    lda data_0082
    sta data_0dff
    jsr next_victory_sprite
    dec data_0080
    jsr plot_victory_sprite
    inc data_0081
    jsr plot_victory_sprite
    inc data_0081
    jsr plot_victory_sprite
    jsr next_victory_sprite
    inc data_0081
    jsr plot_victory_sprite
    inc data_0080
    jsr plot_victory_sprite
    inc data_0080
    jsr plot_victory_sprite
    jsr next_victory_sprite
    inc data_0080
    jsr plot_victory_sprite
    dec data_0081
    jsr plot_victory_sprite
    dec data_0081
    jsr plot_victory_sprite
    rts
; ***************************************************************************************
; Plot a victory sprite at a cell
;
; Plot the current victory sprite at the map cell in &80, &81.
; &119a referenced 12 times by &1151, &1156, &115b, &1168, &116d, &1172, &117a, &117f, &1184, &118c, &1191, &1196
.plot_victory_sprite
    lda data_0080
    sta cell_x
    lda data_0081
    sta cell_y
    lda data_0082
    sta sprite_number
    jsr plot_at_cell
    rts
; ***************************************************************************************
; Choose the next victory sprite
;
; Step the victory sprite through &16-&19.
; &11ac referenced 3 times by &1163, &1175, &1187
.next_victory_sprite
    lda data_0082
    cmp #&15
    beq code_11bb
    clc
    adc #1
    cmp #&1a
    bne code_11bb
    lda #&16
; &11bb referenced 2 times by &11b0, &11b7
.code_11bb
    sta data_0082
    rts
; ***************************************************************************************
; Clear a random byte of the Chalice
;
; Use the System VIA timer to pick a byte of the Chalice sprite, clear it, and redraw the
; Chalice.
; &11be referenced 1 time by &1139
.dissolve_chalice
    lda system_via_t1c_l
    eor data_00fc
    eor data_00fa
    cmp #&c0
    bcs return_6
    tax
    lda #0
    sta data_1210,x
    jsr plot_chalice
; &11d2 referenced 1 time by &11c7
.return_6
    rts
; &11d3 referenced 1 time by &1119
.code_11d3
    lda #&15
    sta data_0082
    jsr draw_victory_ring
    ldx #&c1
    lda #0
; &11de referenced 1 time by &11e2
.loop_11de
    sta data_120f,x
    dex
    bne loop_11de
    jsr plot_chalice
    lda #&ff
    sta os_vsync_counter
; &11ec referenced 1 time by &11ef
.loop_11ec
    lda os_vsync_counter
    bne loop_11ec
    rts
; ***************************************************************************************
; Plot the Chalice
;
; Plot the Chalice sprite at its place on the map.
; &11f2 referenced 2 times by &11cf, &11e4
.plot_chalice
    lda #&1a
    sta cell_x
    lda #4
    sta cell_y
    lda #&73 ; 's'
    sta sprite_number
    jsr plot_at_cell
    rts
.sub_1204
; &120f used as index base 1 time by &11de
data_120f = sub_1204+11
    equs "Rx`(&1900+F%"
; &1210 used as index base 1 time by &11cc
.data_1210
    equb &00, &00, &05, &0f, &0f, &0a, &00, &00
    equb &00, &00, &0f, &07, &0b, &0f, &00, &00
    equb &00, &05, &0b, &03, &03, &07, &0a, &00
    equb &00, &0f, &07, &5a, &a5, &0b, &0f, &00
    equb &00, &0f, &07, &0f, &0f, &0b, &0f, &00
    equb &05, &0b, &0f, &00, &00, &0f, &07, &0a
    equb &05, &0b, &0a, &00, &00, &05, &07, &0a
    equb &0f, &07, &0e, &00, &00, &0d, &0b, &0f
    equb &0f, &07, &04, &08, &04, &08, &0b, &0f
    equb &0b, &07, &45, &0c, &0c, &8a, &0b, &07
    equb &0f, &07, &00, &0c, &0c, &00, &0b, &0f
    equb &5a, &07, &0c, &4d, &8e, &0c, &0b, &a5
    equb &5a, &07, &0c, &4d, &8e, &0c, &0b, &a5
    equb &0f, &07, &00, &0c, &0c, &00, &0b, &0f
    equb &0b, &07, &45, &0c, &0c, &8a, &0b, &07
    equb &0f, &07, &04, &08, &04, &08, &0b, &0f
    equb &0f, &07, &0e, &00, &00, &0d, &0b, &0f
    equb &05, &0b, &0a, &00, &00, &05, &07, &0a
    equb &05, &0b, &0f, &00, &00, &0f, &07, &0a
    equb &00, &0f, &07, &0f, &0f, &0b, &0f, &00
    equb &00, &0f, &07, &5a, &a5, &0b, &0f, &00
    equb &00, &05, &0b, &03, &03, &07, &0a, &00
    equb &00, &00, &0f, &07, &0b, &0f, &00, &00
    equb &00, &00, &05, &0f, &0f, &0a, &00, &00
    equb &3d, &26, &00
; &12d3 referenced 2 times by &0d58, &14d7
.saved_wrchv
; &12d4 referenced 2 times by &0d5e, &14dd
data_12d4 = saved_wrchv+1
    equb &a4, &e0, &00, &73
; ***************************************************************************************
; Font: letters A-Z
;
; Eight bytes per letter, copied into the definition of character 128 by the WRCHV
; handler.
; &12d7 used as index base 1 time by &7fc5
.font_letters
    equs "<BB"
    equb &8e, &f2, &82, &c6, &00
    equs "xDB"
    equb &bc, &82, &82, &fc, &00
    equs "<B@"
    equb &80, &80, &82, &7c, &00, &7c, &82, &82
    equb &82, &84, &84, &f8, &00, &0e, &70, &40
    equb &ce, &f0, &80, &fe, &00, &1e, &e0, &80
    equb &8e, &f0, &80, &c0, &00
    equs "<BB"
    equb &80, &9e, &82, &7e, &00
    equs "bBB"
    equb &9e, &e2, &82, &c6, &00, &1e, &08, &08
    equb &10, &10, &10, &7c, &00, &fe, &02, &02
    equb &04, &c4, &84, &78, &00
    equs "@Np"
    equb &88, &88, &84, &c2, &00
    equs "`@@"
    equb &80, &80, &82, &fe, &00
    equs "Fnj"
    equb &da, &92, &82, &c6, &00
    equs "fRR"
    equb &8a, &8a, &8a, &c6, &00
    equs "<BB"
    equb &82, &82, &82, &7c, &00
    equs "|BB"
    equb &bc, &80, &80, &c0, &00
    equs "<BB"
    equb &9a, &8a, &86, &7e, &00
    equs "|BB"
    equb &bc, &88, &84, &c2, &00, &1e
    equb &22, "@<"
    equb &02, &82, &fc, &00, &fe, &92, &10
    equs "   p"
    equb &00
    equs "fBB"
    equb &82, &82, &82, &7c, &00, &c6, &42, &42
    equb &82, &84, &48, &30, &00
    equs "fBB"
    equb &92, &aa, &4a, &44, &00
    equs "f", &22, "$"
    equb &18, &18, &24, &c6, &00, &86, &42, &32
    equb &0c, &08, &10, &70, &00, &7e, &02, &04
    equb &18, &20, &42, &fe, &00
; ***************************************************************************************
; Font: digits 0-9
;
; Eight bytes per digit, copied into the definition of character 128 by the WRCHV
; handler.
; &13a7 used as index base 1 time by &7fe8
.font_digits
    equs "<FJ"
    equb &92, &a2, &c4, &78, &00, &08, &18, &08
    equb &10, &10, &10, &3c, &00, &3c, &42, &02
    equb &0c, &30, &42, &fc, &00, &7e, &02, &04
    equb &18, &06, &82, &7c, &00, &18, &28, &48
    equb &90, &fc, &10, &38, &00, &1f, &20, &20
    equb &18, &04, &82, &7c, &00, &0e, &10, &20
    equb &7c, &82, &82, &7c, &00, &7e, &02, &02
    equb &04, &08, &10, &78, &00, &1c
    equb &22, &22, "|"
    equb &82, &82, &7c, &00
    equs "<BB>"
    equb &02, &04, &18, &00
    equs "<BB>"
    equb &02, &04, &18, &00, &74
; ***************************************************************************************
; Set up and draw a new level
;
; Show the level number, load and unpack the level, reset the workspace and monsters,
; then clear the text area, set the screen to its full 25-row height and draw the view
; frames and views.
; &1400 referenced 1 time by &0e57
.start_level
    jsr show_level_number               ; Show the level number
    jsr load_level                      ; Load the level
    jsr unpack_level                    ; Copy it into the game's tables
    jsr reset_workspace                 ; Reset page &0D
    jsr reset_monsters                  ; Reset the monsters and keys
    jsr clear_text_area                 ; Clear the text area
    lda #&17                            ; VDU 23,0,6,25,0,0,0,0,0,0: set 6845 register 6...
    jsr oswrch                          ; ...
    lda #0                              ; ...
    jsr oswrch
    lda #6                              ; ...
    jsr oswrch
    lda #&19                            ; ...to 25 character rows displayed
    jsr oswrch
    lda #0                              ; ...
    jsr oswrch
    jsr oswrch
    jsr oswrch
    jsr oswrch
    jsr oswrch
    jsr oswrch
    lda #&3a ; ':'                      ; Point at view_frame_plots...
    sta plot_x
    lda #&16                            ; ...
    sta plot_y
    jsr draw_view_frames                ; ...and draw the frames and the views
    rts                                 ; Return
; ***************************************************************************************
; Load the level file
;
; Show 23 character rows while loading, then load the file named in level_filename at
; &6B00 by calling the filing system's FILEV routine directly with an OSFILE block, and
; finally decrypt and check it. The block's byte 6 (the exec address's low byte, which
; must be 0 for the load address to be used) is not set here: it relies on
; show_level_number having cleared the screen, which the block lies in.
; &1446 referenced 1 time by &1403
.load_level
    lda #&17                            ; VDU 23,0,6,23,0,0,0,0,0,0: set 6845 register 6...
    jsr oswrch
    lda #0
    jsr oswrch
    lda #6                              ; ...
    jsr oswrch
    lda #&17                            ; ...to 23 character rows displayed
    jsr oswrch
    lda #0                              ; ...
    jsr oswrch
    jsr oswrch
    jsr oswrch
    jsr oswrch
    jsr oswrch
    jsr oswrch
    ldx #&60 ; '`'                      ; X, Y = address of the OSFILE block
    ldy #&6e ; 'n'                      ; ...
    lda #&d0                            ; Filename address = level_filename...
    sta level_osfile_block              ; ...
    lda #&16                            ; ...
    sta data_6e61                       ; ...
    lda #0                              ; Load address = &00006B00...
    sta data_6e62                       ; ...
    sta data_6e64                       ; ...
    sta data_6e65                       ; ...
    lda #&6b ; 'k'                      ; ...
    sta data_6e63                       ; ...
    lda filev                           ; Copy FILEV into the operand of the JSR below...
    sta filev_call_address              ; ...
    lda filev + 1                       ; ...
    sta data_149c                       ; ...
    lda #&ff                            ; A = &FF: load the file
.load_level_call
; &149b referenced 1 time by &148f
filev_call_address = load_level_call+1
; &149c referenced 1 time by &1495
data_149c = load_level_call+2
    jsr data_3000                       ; Call the filing system's OSFILE routine directly
    jmp decrypt_level                   ; Decrypt and check the level, and return from there
; ***************************************************************************************
; Reset the game workspace for a new level
;
; Copy workspace_template into page &0D and clear the per-level state.
; &14a0 referenced 1 time by &1409
.reset_workspace
    ldx #0                              ; Copy workspace_template to page &0D
; &14a2 referenced 1 time by &14a9
.loop_14a2
    lda workspace_template,x            ; ...
    sta scratch,x                       ; ...
    inx                                 ; ...
    bne loop_14a2                       ; ...
    lda #0                              ; Reset the exit and other per-level state
    sta data_09f2
    sta data_09f9
    sta data_09fa
    sta data_09fe
    sta next_trapdoor                   ; First monster emerges from trapdoor 0
    lda #1
    sta data_09f7
    sta data_09f8
    sta data_09fd
    lda #&ff
    sta data_09ff
    lda #5
    sta data_09fb
    lda #3
    sta data_09fc
    rts                                 ; Return
; ***************************************************************************************
; Draw the frames round the four views
;
; With the MOS's own text output restored, send the twenty PLOT commands of
; view_frame_plots, draw the four views, then put the game's WRCHV handler back.
;
; On Entry:
;     PLOT_X: address of view_frame_plots, low byte
;     PLOT_Y: address of view_frame_plots, high byte
; &14d7 referenced 1 time by &1442
.draw_view_frames
    lda saved_wrchv                     ; Restore the MOS's own WRCHV for the PLOT commands...
    sta wrchv                           ; ...
    lda data_12d4                       ; ...
    sta wrchv + 1                       ; ...
    ldx #&14                            ; Twenty PLOT commands
; &14e5 referenced 1 time by &1500
.loop_14e5
    lda #&19                            ; VDU 25...
    jsr oswrch                          ; ...
    ldy #0                              ; ...then the five bytes of the command
; &14ec referenced 1 time by &14f4
.loop_14ec
    lda (plot_x),y                      ; ...
    jsr oswrch                          ; ...
    iny                                 ; ...
    cpy #5                              ; ...
    bne loop_14ec                       ; ...
    clc                                 ; Next command
    lda plot_x                          ; ...
    adc #5                              ; ...
    sta plot_x                          ; ...
    ldy #0                              ; ...
    dex                                 ; ...
    bne loop_14e5                       ; ...
    jsr draw_all_views                  ; Draw the four views
    lda #&8f                            ; Point WRCHV back at wrch_handler...
    sta wrchv                           ; ...
    lda #&7f                            ; ...
    sta wrchv + 1                       ; ...
    rts                                 ; Return
; ***************************************************************************************
; Copy the loaded level into the game's tables
;
; Distribute the level file at &6B00 into the object, door, key, trapdoor and map tables
; and the wall sprite.
; &1510 referenced 1 time by &1406
.unpack_level
    ldx #&1e                            ; Objects 30 to 1: position and type
; &1512 referenced 1 time by &1525
.loop_1512
    lda level_object_x,x
    sta object_x,x
    lda level_object_y,x
    sta object_y,x
    lda level_object_type,x
    sta object_type,x
    dex                                 ; ...
    bne loop_1512                       ; ...
    ldx #&14                            ; Doors 20 to 1: position and sprite
; &1529 referenced 1 time by &153c
.loop_1529
    lda level_door_x,x
    sta door_x,x
    lda level_door_y,x
    sta door_y,x
    lda level_door_sprite,x
    sta door_sprite,x
    dex                                 ; ...
    bne loop_1529                       ; ...
    ldx #&14                            ; Keys 20 to 1: position
; &1540 referenced 1 time by &154d
.loop_1540
    lda level_key_x,x
    sta key_x,x
    lda level_key_y,x
    sta key_y,x
    dex                                 ; ...
    bne loop_1540                       ; ...
    ldx #0                              ; Trapdoors 0 to 7: position
; &1551 referenced 1 time by &1560
.loop_1551
    lda level_trapdoor_x,x
    sta trapdoor_x,x
    lda level_trapdoor_y,x
    sta trapdoor_y,x
    inx                                 ; ...
    cpx #8                              ; ...
    bne loop_1551                       ; ...
    ldx #0                              ; Wall map and object-free map, &C9 bytes each
; &1564 referenced 1 time by &1573
.loop_1564
    lda level_walls,x
    sta room_walls,x
    lda level_object_free_map,x
    sta object_free_map,x
    inx                                 ; ...
    cpx #&c9                            ; ...
    bne loop_1564                       ; ...
    ldx #0                              ; The level's wall sprite, &30 bytes
; &1577 referenced 1 time by &1580
.loop_1577
    lda level_wall_sprite,x
    sta wall_sprite,x
    inx                                 ; ...
    cpx #&30 ; '0'                      ; ...
    bne loop_1577                       ; ...
    rts                                 ; Return
; ***************************************************************************************
; Clear the monsters for a new level
;
; Mark every monster as not yet appeared, give each the level's starting hit points, and
; clear the heroes' keys and the returning_hero_queue.
; &1583 referenced 1 time by &140c
.reset_monsters
    ldx #&1e                            ; Monsters 30 to 1...
; &1585 referenced 1 time by &1596
.loop_1585
    lda #&15                            ; ...dying, so that they emerge from the trapdoors...
    sta monster_sprite,x                ; ...
    lda #&ff                            ; ...off the map...
    sta monster_x,x                     ; ...
    lda monster_start_hit_points        ; ...with this level's hit points
    sta monster_hit_points,x            ; ...
    dex                                 ; ...
    bne loop_1585                       ; ...
    ldx #0                              ; For each hero: clear the returning queue, the key carried and the door-check position
    lda #0
; &159c referenced 1 time by &15ae
.loop_159c
    sta returning_hero_queue,x
    sta hero_key,x
    sta hero_key_dropped,x
    sta hero_door_x,x
    sta hero_door_y,x
    inx                                 ; ...
    cpx #4                              ; ...
    bne loop_159c                       ; ...
    rts                                 ; Return
; ***************************************************************************************
; Show the number of the level about to start
;
; Clear the text area, count the level, plot the word LEVEL and print the number in the
; game's font, then set a text window and colour for later messages.
; &15b1 referenced 1 time by &1400
.show_level_number
    jsr clear_text_area                 ; Clear the text area
    lda #&11                            ; COLOUR 6...
    jsr oswrch
    lda #6                              ; ...
    jsr oswrch
    inc level_number                    ; Count the level
    lda #&1b                            ; Plot the word LEVEL...
    sta plot_x
    lda #&28 ; '('                      ; ...
    sta plot_y
    lda #&76 ; 'v'                      ; ...
    sta sprite_number
    jsr plot_sprite                     ; ...
    lda #&1f                            ; TAB(10,5)...
    jsr oswrch
    lda #&0a                            ; ...
    jsr oswrch
    lda #5                              ; ...
    jsr oswrch
    lda level_bcd                       ; Print the tens digit...
    tay                                 ; ...
    lsr a                               ; ...
    lsr a
    lsr a
    lsr a
    clc
    adc #&30 ; '0'                      ; ...
    jsr oswrch                          ; ...in the game's font
    tya                                 ; Print the units digit...
    and #&0f                            ; ...
    clc
    adc #&30 ; '0'                      ; ...
    jsr oswrch                          ; ...in the game's font
    lda #&1c                            ; VDU 28,1,22,14,17: a text window...
    jsr oswrch
    lda #1
    jsr oswrch
    lda #&16
    jsr oswrch
    lda #&0e                            ; ...
    jsr oswrch
    lda #&11                            ; COLOUR 2...
    jsr oswrch
    lda #&11
    jsr oswrch
    lda #2                              ; ...
    jsr oswrch
    rts                                 ; Return
; ***************************************************************************************
; Clear the left of the screen
;
; Set a text window over the left of the screen and clear it.
; &161a referenced 2 times by &140f, &15b1
.clear_text_area
    lda #&1c
    jsr oswrch
    lda #0
    jsr oswrch
    lda #&18
    jsr oswrch
    lda #&13
    jsr oswrch
    lda #0
    jsr oswrch
    lda #&0c
    jsr oswrch
    rts
    equb &60
; ***************************************************************************************
; View frame PLOT commands
;
; Twenty five-byte VDU 25 commands (plot code, x, y) sent by draw_view_frames.
.view_frame_plots
    equb &04, &08, &00, &fe, &03
    equb &01, &00, &00, &7c, &fe
    equb &01, &08, &02, &00, &00
    equb &01, &00, &00, &84, &01
    equb &05, &08, &00, &fe, &03
    equb &04, &28, &02, &fe, &03
    equb &01, &00, &00, &7b, &fe
    equb &01, &08, &02, &00, &00
    equb &01, &00, &00, &84, &01
    equb &05, &28, &02, &fe, &03
    equb &04, &08, &00, &66, &02
    equb &01, &00, &00, &7c, &fe
    equb &01, &08, &02, &00, &00
    equb &01, &00, &00, &84, &01
    equb &05, &08, &00, &66, &02
    equb &04, &28, &02, &66, &02
    equb &01, &00, &00, &7c, &fe
    equb &01, &08, &02, &00, &00
    equb &01, &00, &00, &84, &01
    equb &05, &28, &02, &66, &02
    equb &08
; &169f referenced 6 times by &0477, &0e02, &0e14, &0e29, &1070, &15be
.level_number
    equb &01
; ***************************************************************************************
; Sound the exit and add a queue marker
;
; Play the exit sound and put a &64 entry in the first free slot of returning_hero_queue.
; &16a0 referenced 1 time by &203d
.queue_exit_marker
    ldx #&58 ; 'X'
    ldy #&19
    lda #osword_envelope
    jsr osword                          ; ENVELOPE command
    ldx #&66 ; 'f'
    ldy #&19
    lda #osword_sound
    jsr osword                          ; SOUND command
    ldx #0
; &16b4 referenced 1 time by &16c0
.loop_16b4
    lda returning_hero_queue,x
    bne code_16bf
    lda #&64 ; 'd'
    sta returning_hero_queue,x
    rts
; &16bf referenced 1 time by &16b7
.code_16bf
    inx
    bne loop_16b4
    equb &02, &02, &00, &00, &83, &00, &00, &00
    equb &00, &00, &00, &31, &00, &8d
.level_filename
    equs "LEVEL"
; &16d5 referenced 1 time by &0e4f; also used as index base 1 time by &0e3e
.level_filename_digits
; &16d6 used as index base 1 time by &0e54
data_16d6 = level_filename_digits+1
    equb &31, &0d, &0d, &70, &00, &8d, &35, &f8
    equb &00, &00, &00, &00
    equs "code"
    equb &00, &54, &12, &03, &17, &74, &00, &8c
    equb &50, &00, &00, &00, &fa, &16, &78, &00
    equb &8c, &50, &20, &00, &00, &02, &00, &79
    equb &00, &8c
; &16ff referenced 6 times by &0e05, &0e20, &0e25, &0e36, &0e45, &15df
.level_bcd
    equb &01, &00, &00, &00, &00, &00, &15, &00
    equb &00, &00, &15, &00, &00, &00, &15, &00
    equb &00, &00, &15, &00, &00, &00, &15, &00
    equb &00, &00, &15, &00, &00, &00, &15, &00
    equb &00, &00, &03, &02, &00, &00, &01, &00
    equb &00, &00, &01, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &01, &00
    equb &00, &01, &03, &3f, &3f, &00, &01, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &02
    equb &00, &00, &00, &02, &00, &00, &01, &03
    equb &00, &00, &00, &2a, &00, &00, &00, &2a
    equb &00, &00, &00, &2a, &00, &00, &00, &2a
    equb &00, &00, &00, &2a, &00, &00, &00, &2a
    equb &00, &00, &00, &2a, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &02, &00, &3f, &3f, &03
    equb &02, &00, &00, &02, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &80, &00, &00, &32, &00
    equs "eco"
    equb &00, &8e, &0b, &94, &00, &00
    equs "?&A66=(rx%-lx%)"
    equb &81
    equs "2+1:sprite%?&A99=by%-ty%+1"
    equb &0d, &03, &d4, &1d, &20, &d4
    equs "1,??>*"
    equb &00, &14, &2a, &00, &14, &2a, &00, &14
    equb &2a, &00, &14, &2a, &00, &14, &2a, &00
    equb &14, &2a, &00, &14, &15, &00, &28, &15
    equb &00, &28, &00, &3e, &00, &00, &3e, &00
    equb &01, &01, &01, &01, &01, &03, &01, &03
    equb &02, &03, &03, &01, &03, &01, &03, &02
    equb &02, &03, &03, &01, &03, &02, &03, &01
    equb &03, &02, &02, &03, &03, &03, &03, &01
    equb &01, &01, &01, &03, &03, &03, &03, &03
    equb &03, &03, &03, &01, &01, &0a, &00, &05
    equb &00, &00, &00, &0a, &00, &05, &00, &00
    equb &00, &0a, &00, &05, &00, &00, &01, &00
    equs "??+"
    equb &03, &00, &00, &01, &00, &00, &05, &00
    equb &0a, &05, &00, &00, &0a, &05, &00, &0a
    equb &00, &3c, &00, &14
    equs "<(("
    equb &14, &14
    equs "<(<"
    equb &00, &3c, &00, &14, &00, &00, &28, &14
    equb &14, &00, &00, &3c, &00, &3c, &00, &14
    equs "<(<<"
    equb &14
    equs "<(<"
    equb &00, &3c, &3c, &14, &00, &00, &3c, &3c
    equb &14, &00, &00
    equs "<<<<"
    equb &14
    equs "<(<<"
    equb &14
    equs "<(<<<<"
    equb &14, &3c, &28, &14, &28, &14
    equs "<(<<<<"
    equb &14, &3c, &28, &14, &28, &14
    equs "<(<<"
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &08, &00, &04, &00
    equb &00, &00, &08, &04, &00, &00, &08, &00
    equb &0c, &0c, &04, &0c, &08, &00, &08, &04
    equb &0c, &08, &0c, &0c, &1a, &35, &03, &8f
    equb &7d, &9a, &82, &03, &00, &00, &00, &6d
    equb &19, &00, &00, &00, &03, &01, &0a, &0a
    equb &ec, &03, &03, &03, &80, &00, &00, &ff
    equb &80, &80, &12, &00, &03, &00, &00, &00
    equb &02, &00, &03, &02, &01, &01, &01, &01
    equb &01, &01, &80, &00, &00, &f8, &80, &80
    equb &12, &00, &03, &00, &c8, &00, &05, &00
    equb &03, &80, &00, &00, &00, &0a, &0a, &0a
    equb &0a, &00, &00, &fd, &80, &80, &10, &00
    equb &03, &00, &0a, &00, &05, &00, &03, &80
    equb &00, &00, &00, &01, &1e, &1e, &80, &00
    equb &00, &fe, &80, &80, &12, &00, &03, &00
    equb &f0, &00, &01, &00, &03, &82, &ff, &ff
    equb &fe, &01, &01, &80, &80, &00, &00, &ff
    equb &80, &80, &12, &00, &03, &00, &fa, &00
    equb &01, &00, &00, &00, &00, &00, &04
    equs "50:50:$"
    equb &0c, &0c, &08, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &0a, &00, &00, &00
    equb &00, &14, &34, &38, &03, &03
    equs "4<:%"
    equb &0f, &0f, &0f, &1e, &31, &38, &03
    equs "48<"
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &04
    equs "5?:"
    equb &18, &3f, &3a, &0c, &0c, &08, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &35, &00, &00, &01, &03, &00, &01, &0b
    equb &08, &00, &01, &0e, &0c, &00, &03, &06
    equb &3c, &00, &02, &03, &25, &28, &02, &05
    equb &0f, &3c, &02, &05, &0f, &3c, &02, &00
    equb &25, &29, &00, &00, &3c, &09, &00, &0a
    equb &0c, &09, &00, &0e, &0c, &00, &00, &04
    equb &00, &00, &00, &00, &00, &00, &00, &3f
    equb &00, &00, &00, &00, &00, &00, &15, &15
    equs "***??"
    equb &15
    equs "*??"
    equb &15
    equs "*5:"
    equb &15, &2a, &15, &2a, &15, &2a, &00, &00
    equb &2a, &2a, &00, &3f, &2a, &15, &00, &00
    equb &2a, &15, &00, &00, &00, &15, &2a, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &15, &15
    equs "***??**5:"
    equb &15
    equs "*5:"
    equb &15
    equs "*??"
    equb &15, &00, &00, &00, &00, &00, &00, &00
    equb &2a, &2a, &00, &00, &2a, &15, &15, &2a
    equb &2a, &00, &00, &00, &00, &00, &2a, &00
    equb &00, &15, &00, &00, &00
    equs "*??"
    equb &00, &00, &35, &35, &00, &15, &35, &35
    equb &00, &15, &3f, &3f, &00, &15, &3a, &20
    equb &15, &15, &00, &00, &15, &00, &2a, &00
    equb &3f, &2a, &15, &15, &15, &15, &00, &2a
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &15, &00, &00, &00, &3f, &2a
    equb &00, &00, &35, &20, &00, &15
    equs "5 *???"
    equb &00, &15, &3a, &2a, &15, &15, &00, &00
    equb &2a, &15, &2a, &15, &00, &15, &3f, &2a
    equb &00, &2a, &15, &3f, &2a, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &15, &3f
    equb &00, &00, &10, &3a, &00, &00, &10, &3a
    equb &00, &00, &15, &3f, &15
    equs "*?5*"
    equb &15, &2a, &2a, &00, &00
    equs "??*?"
    equb &15, &2a, &15
; &1ae0 used as index base 1 time by &0902
.sprite_addr_lo
    equb &00, &30, &60, &90, &c0, &f0, &20, &50
    equb &c0, &80, &b0, &e0, &10, &40, &70, &a0
    equb &d0, &00, &30, &60, &90, &cf, &00, &30
    equb &60, &90, &cf, &00, &c0, &c8, &00, &14
    equs "(<Pdx"
    equb &8c, &a0, &b4, &30, &60, &f0, &c0, &c0
    equb &00, &30, &60, &90, &c0, &f0, &20, &50
    equb &80, &b0, &e0, &10, &40, &70, &a0, &d0
    equb &00, &30, &60, &90, &c0, &f0, &20, &50
    equb &80, &b0, &e0, &10, &00, &30, &60, &90
    equb &40, &70, &a0, &d0, &a0, &d0, &d0, &d0
    equb &d0, &d0, &d0, &d0, &d0, &d0, &d0, &d0
    equb &d0, &d0, &00, &30, &60, &c0, &90, &f0
    equb &20, &50, &80, &b0, &00
    equs "$).38=BGL"
    equb &10
    equs "`lx"
    equb &cf
; &1b58 used as index base 1 time by &0907
.sprite_addr_hi
    equs "------.."
    equb &19
    equs ".../////,,,,"
    equb &04
    equs "++++"
    equb &04
    equs "),***********))"
    equb &0a
    equs ")+######$$$$$%%%%%&&&&&&'''''("
    equb &17, &17, &17, &17
    equs "((((", &22, &22, "!!!!!!!!!!!!"
    equb &0a, &0a, &0a, &0a, &0a, &19, &1a, &1a
    equb &1a, &1a, &18, &18, &18, &18, &18, &18
    equb &18, &18, &18, &18, &12, &18, &18, &18
    equb &04
; &1bd0 used as index base 3 times by &090c, &2009, &205f
.sprite_widths
    equb &04, &04, &04, &04, &04, &04, &04, &04
    equb &04, &04, &04, &04, &04, &04, &04, &04
    equb &04, &04, &04, &04, &04, &04, &04, &04
    equb &04, &04, &02, &04, &04, &04, &02, &02
    equb &02, &02, &02, &02, &02, &02, &02, &02
    equb &04, &04, &04, &04, &04, &04, &04, &04
    equb &04, &04, &04, &04, &04, &04, &04, &04
    equb &04, &04, &04, &04, &04, &04, &04, &04
    equb &04, &04, &04, &04, &04, &04, &04, &04
    equb &04, &04, &04, &04, &04, &04, &04, &04
    equb &04, &04, &02, &04, &04, &04, &04, &04
    equb &04, &04, &04, &04, &04, &04, &04, &04
    equb &04, &04, &04, &04, &04, &04, &04, &04
    equb &04, &03, &01, &01, &01, &01, &01, &01
    equb &01, &01, &01, &08, &04, &02, &0c, &02
; &1c48 used as index base 4 times by &0911, &2015, &201a, &206c
.sprite_heights
    equb &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c
    equb &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c
    equb &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c
    equb &0c, &0c, &03, &0c, &0c, &0c, &0a, &0a
    equb &0a, &0a, &0a, &0a, &0a, &0a, &0a, &0a
    equb &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c
    equb &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c
    equb &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c
    equb &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c
    equb &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c
    equb &0c, &0c, &03, &0c, &0c, &0c, &0c, &0c
    equb &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c
    equb &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c
    equb &0c, &0c, &05, &05, &05, &05, &05, &05
    equb &05, &05, &05, &18, &03, &06, &08, &06
; ***************************************************************************************
; Run one frame of play
;
; Move the heroes, open doors for heroes carrying the right key, pick up and swap keys,
; then draw the objects, move the missiles and the monsters, and handle the pause key.
; &1cc0 referenced 1 time by &1f0d
.update_game
    jsr move_heroes
    ldx #0
; &1cc5 referenced 1 time by &1dbf
.code_1cc5
    stx scratch
    lda hero_door_x,x
    sta cell_x
    lda hero_door_y,x
    sta cell_y
    txa
    pha
    ldx #&14
; &1cd8 referenced 1 time by &1db5
.code_1cd8
    lda door_x,x
    cmp cell_x
    beq code_1ce3
    jmp code_1db2
; &1ce3 referenced 1 time by &1cde
.code_1ce3
    lda door_y,x
    cmp cell_y
    beq code_1cee
    jmp code_1db2
; &1cee referenced 1 time by &1ce9
.code_1cee
    pla
    tay
    pha
    txa
    cmp hero_key,y
    beq code_1cfa
    jmp code_1db2
; &1cfa referenced 1 time by &1cf5
.code_1cfa
    txa
    pha
    tya
    pha
    ldy #7
    ldx scratch
; &1d03 referenced 1 time by &1d0b
.loop_1d03
    tya
    pha
    jsr add_point
    pla
    tay
    dey
    bne loop_1d03
    lda #&96
    sta data_0bfc
    ldx #&f8
    ldy #&0b
    lda #osword_sound
    jsr osword                          ; SOUND command
    lda #&c8
    sta data_0bfc
    lda cell_y
    sta data_7e4c
    lda cell_x
    sta data_7e23
    lda #&15
    sta sprite_number
    lda #0
    sta data_007d
    sta data_007e
    jsr plot_at_cell
    lda data_7e23
    sta cell_x
    lda data_7e4c
    sta cell_y
    pla
    tay
    pla
    tax
    lda cell_y
    and #&f8
    sta scratch
    clc
    adc scratch
    adc scratch
    adc scratch
    sta data_007b
    lda cell_x
    and #&f8
    adc data_007b
    sta data_007b
    lda #&0c
    sta data_007c
    txa
    pha
    lda cell_x
    and #7
    tax
    lda bit_masks,x
    eor #&ff
    sta scratch
    lda cell_y
    and #7
    tay
    lda (data_007b),y
    and scratch
    sta (data_007b),y
    pla
    tax
    lda #&ff
    sta door_x,x
    sta door_y,x
    pla
    tax
    lda #0
    sta hero_key,x
    lda #&1a
    sta sprite_number
    lda hero_panel_y,x
    sec
    sbc #&0d
    sta plot_y
    lda #&4a ; 'J'
    sta plot_x
    txa
    pha
    jsr plot_sprite
    pla
    tax
    jmp code_1dba
; &1db2 referenced 3 times by &1ce0, &1ceb, &1cf7
.code_1db2
    dex
    beq code_1db8
    jmp code_1cd8
; &1db8 referenced 1 time by &1db3
.code_1db8
    pla
    tax
; &1dba referenced 1 time by &1daf
.code_1dba
    inx
    cpx #4
    beq code_1dc2
    jmp code_1cc5
; &1dc2 referenced 1 time by &1dbd
.code_1dc2
    lda #0
    sta data_007d
    sta data_007e
    lda #&1b
    sta sprite_number
    ldx #&14
; &1dce referenced 1 time by &1de2
.loop_1dce
    lda key_x,x
    sta cell_x
    lda key_y,x
    sta cell_y
    txa
    pha
    jsr plot_at_cell
    pla
    tax
    dex
    bne loop_1dce
    ldx #0
; &1de6 referenced 1 time by &1ecb
.code_1de6
    lda hero_direction,x
    bne code_1e28
    lda hero_key,x
    bne code_1df3
    jmp code_1ec6
; &1df3 referenced 1 time by &1dee
.code_1df3
    lda hero_frame,x
    cmp #8
    bne code_1e28
    ldy hero_key,x
    lda hero_x,x
    sta key_x,y
    lda hero_y,x
    sta key_y,y
    lda #0
    sta hero_key,x
    lda #&1a
    sta sprite_number
    lda hero_panel_y,x
    sec
    sbc #&0d
    sta plot_y
    lda #&4a ; 'J'
    sta plot_x
    txa
    pha
    jsr plot_sprite
    pla
    tax
    jmp code_1ec6
; &1e28 referenced 2 times by &1de9, &1df8
.code_1e28
    lda hero_key_dropped,x
    beq code_1e35
    lda #0
    sta hero_key_dropped,x
    jmp code_1ec6
; &1e35 referenced 1 time by &1e2b
.code_1e35
    lda hero_x,x
    sta cell_x
    lda hero_y,x
    sta cell_y
    txa
    pha
    ldx #&14
; &1e45 referenced 1 time by &1ec1
.code_1e45
    lda key_x,x
    cmp cell_x
    bne code_1ebe
    lda key_y,x
    cmp cell_y
    bne code_1ebe
    lda #&15
    sta sprite_number
    lda #0
    sta data_007d
    sta data_007e
    txa
    pha
    jsr plot_at_cell
    pla
    tax
    pla
    tay
    pha
    lda #&52 ; 'R'
    sta sprite_number
    lda hero_panel_y,y
    sec
    sbc #&0d
    sta plot_y
    lda #&4a ; 'J'
    sta plot_x
    tya
    pha
    txa
    pha
    jsr plot_sprite
    pla
    tax
    pla
    tay
    txa
    pha
    ldx hero_key,y
    lda hero_x,y
    sta key_x,x
    lda hero_y,y
    sta key_y,x
    pla
    tax
    sta hero_key,y
    lda #1
    sta hero_key_dropped,y
    lda #&ff
    sta key_x,x
    sta key_y,x
    ldx #&42 ; 'B'
    ldy #&19
    lda #osword_envelope
    jsr osword                          ; ENVELOPE command
    ldx #&50 ; 'P'
    ldy #&19
    lda #osword_sound
    jsr osword                          ; SOUND command
    pla
    tax
    jmp code_1ec6
; &1ebe referenced 2 times by &1e4b, &1e53
.code_1ebe
    dex
    beq code_1ec4
    jmp code_1e45
; &1ec4 referenced 1 time by &1ebf
.code_1ec4
    pla
    tax
; &1ec6 referenced 4 times by &1df0, &1e25, &1e32, &1ebb
.code_1ec6
    inx
    cpx #4
    beq code_1ece
    jmp code_1de6
; &1ece referenced 1 time by &1ec9
.code_1ece
    jsr sub_7305
    jsr move_missiles
    jsr update_monsters
    lda #osbyte_scan_keyboard_from_16
    jsr osbyte                          ; Scan keyboard from key 16
    cpx #&71 ; 'q'
    bne return_7
; &1ee0 referenced 1 time by &1ee5
.loop_1ee0
    jsr osbyte                          ; Scan keyboard from key 16
    cpx #&71 ; 'q'
    beq loop_1ee0
; &1ee7 referenced 1 time by &1eec
.loop_1ee7
    jsr osbyte                          ; Scan keyboard from key 16
    cpx #&71 ; 'q'
    bne loop_1ee7
; &1eee referenced 1 time by &1ef3
.loop_1eee
    jsr osbyte                          ; Scan keyboard from key 16
    cpx #&71 ; 'q'
    beq loop_1eee
; &1ef5 referenced 1 time by &1ede
.return_7
    rts
    equb &00, &00, &00, &00, &00, &00
    equs "<<<<"
; &1f00 referenced 7 times by &0e65, &1f03, &1f9b, &1fef, &2023, &2037, &208e
.code_1f00
    lda os_vsync_counter
    bpl code_1f00
    lda #2
    sta os_vsync_counter
    jsr check_for_victory
    jsr update_game
    lda data_09f2
    bne code_1f36
    ldx #4
; &1f17 referenced 1 time by &1f2b
.loop_1f17
    lda data_0d19,x
    bne code_1f36
    lda data_0d8f,x
    cmp #&1d
    bne code_1f2a
    lda data_0d1f,x
    cmp #8
    bcc code_1f36
; &1f2a referenced 1 time by &1f21
.code_1f2a
    dex
    bne loop_1f17
    ldx data_09ff
    bmi return_8
    jsr restore_hero_sprites
; &1f35 referenced 1 time by &1f30
.return_8
    rts
; &1f36 referenced 3 times by &1f13, &1f1a, &1f28
.code_1f36
    ldx #0
; &1f38 referenced 1 time by &1f94
.loop_1f38
    lda hero_x,x
    cmp exit_x
    bne code_1f91
    lda hero_y,x
    cmp exit_y
    bne code_1f91
    jsr drop_key
    lda #&63 ; 'c'
    sta hero_step,x
    lda #0
    sta hero_direction,x
    lda hero_x,x
    sta cell_x
    lda hero_y,x
    sta cell_y
    lda #0
    sta data_007d
    sta data_007e
    lda #&15
    sta sprite_number
    txa
    pha
    jsr plot_at_cell
    pla
    tax
    lda #&ff
    sta hero_x,x
    lda exit_x
    sta data_09f0
    lda exit_y
    sta data_09f1
    lda #&ff
    sta exit_x
    sta exit_y
    jsr hero_enters_exit
    jmp code_1f96
; &1f91 referenced 2 times by &1f3e, &1f46
.code_1f91
    inx
    cpx #4
    bne loop_1f38
; &1f96 referenced 1 time by &1f8e
.code_1f96
    lda data_09f2
    bne code_1f9e
    jmp code_1f00
; &1f9e referenced 1 time by &1f99
.code_1f9e
    ldx data_09f5
    lda #0
    sta data_007d
    sta data_007e
    lda data_09f0
    sta cell_x
    lda data_09f1
    sta cell_y
    lda #&51 ; 'Q'
    sta sprite_number
    jsr plot_at_cell
    ldx data_09f5
    clc
    lda data_09f3
    adc #2
    sta data_09f3
    cmp #9
    beq code_1ff2
    clc
    lda hero_sprites,x
    adc data_09f3
    sta sprite_number
    lda data_09f0
    sta cell_x
    lda data_09f1
    sta cell_y
    ldx data_09f4
    lda data_09f6,x
    sta data_007d
    lda data_09fa,x
    sta data_007e
    jsr plot_at_cell
    jmp code_1f00
; &1ff2 referenced 1 time by &1fc8
.code_1ff2
    lda #&ff
    sta data_09f3
    dec data_09f4
    beq code_2026
    clc
    lda hero_sprites,x
    adc #1
    tay
    tax
    adc #7
    sta scratch
; &2009 referenced 1 time by &2010
.loop_2009
    dec sprite_widths,x
    inx
    cpx scratch
    bne loop_2009
    tya
    tax
; &2014 referenced 1 time by &2021
.loop_2014
    sec
    lda sprite_heights,x
    sbc #3
    sta sprite_heights,x
    inx
    cpx scratch
    bne loop_2014
    jmp code_1f00
; &2026 referenced 1 time by &1ffa
.code_2026
    lda data_09f0
    sta exit_x
    lda data_09f1
    sta exit_y
    lda #0
    sta data_09f2
    jmp code_1f00
; ***************************************************************************************
; Start a hero going down the exit
;
; Play the exit sound and begin shrinking the hero's sprites.
;
; On Entry:
;     X: hero number (0-3)
; &203a referenced 1 time by &1f8b
.hero_enters_exit
    stx scratch2
    jsr queue_exit_marker
    lda #4
    sta data_09f6
    ldx data_09ff
    bmi code_2076
    jsr restore_hero_sprites
    jmp code_2076
; ***************************************************************************************
; Restore a hero's sprite sizes
;
; Put back the width and height of all eight of hero X's sprites, which the exit
; animation shrinks.
;
; On Entry:
;     X: hero number (0-3)
; &2050 referenced 2 times by &1f32, &204a
.restore_hero_sprites
    clc
    lda hero_sprites,x
    adc #1
    tax
    tay
    adc #7
    sta scratch
    lda #4
; &205f referenced 1 time by &2066
.loop_205f
    sta sprite_widths,y
    iny
    cpy scratch
    bne loop_205f
    txa
    tay
    lda #&0c
; &206c referenced 1 time by &2073
.loop_206c
    sta sprite_heights,y
    iny
    cpy scratch
    bne loop_206c
    rts
; &2076 referenced 2 times by &2048, &204d
.code_2076
    lda #1
    sta data_09f2
    lda scratch2
    sta data_09f5
    sta data_09ff
    lda #&ff
    sta data_09f3
    lda #4
    sta data_09f4
    jmp code_1f00
; ***************************************************************************************
; Drop the key a hero carries
;
; Put hero X's key in a free cell next to them, and remove it from their panel section.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &2091 referenced 1 time by &1f48
.drop_key
    lda hero_x,x
    sta cell_x
    lda hero_y,x
    sta cell_y
    txa
    pha
    jsr find_open_neighbour
    pla
    tax
    ldy hero_key,x
    lda cell_x
    sta key_x,y
    lda cell_y
    sta key_y,y
    lda #0
    sta hero_key,x
    lda #&1a
    sta sprite_number
    lda hero_panel_y,x
    sec
    sbc #&0d
    sta plot_y
    lda #&4a ; 'J'
    sta plot_x
    txa
    pha
    jsr plot_sprite
    pla
    tax
    rts
; ***************************************************************************************
; Find a free cell next to a cell
;
; Starting with cell_x, cell_y, try the cells above, to the right, below and to the left,
; and leave cell_x, cell_y at the first without a wall.
; &20d0 referenced 1 time by &209f
.find_open_neighbour
    dec cell_y
    jsr test_wall
    cpy #0
    bne code_20db
    rts
; &20db referenced 1 time by &20d8
.code_20db
    inc cell_y
    inc cell_x
    jsr test_wall
    cpy #0
    bne code_20e9
    rts
; &20e9 referenced 1 time by &20e6
.code_20e9
    dec cell_x
    inc cell_y
    jsr test_wall
    cpy #0
    bne code_20f7
    rts
; &20f7 referenced 1 time by &20f4
.code_20f7
    dec cell_y
    dec cell_x
    rts
    equb &01, &3f
; &2100 used as index base 1 time by &156d
.object_free_map
    equb &00, &02, &07, &07, &1f, &3f, &7d, &7f
    equb &00, &30, &78, &fd, &7f, &ff, &80, &00
    equb &00, &60, &e0, &c0, &df, &c0, &1f, &0f
    equb &00
    equs "XXX"
    equb &d8, &18, &f8, &80
    equs "v>_n~"
    equb &00, &7f, &7f, &00
    equs "ff~~ff"
.sub_212f
; &213a used as index base 1 time by &10c7
data_213a = sub_212f+11
    equb &00, &1f, &1f, &03, &03, &ff, &03, &03
    equb &03, &80, &80, &80, &80, &80, &f6, &fe
    equb &f6, &7f, &00
    equs "?/77/7"
    equb &c0, &03, &c4, &86, &40, &00, &80, &c1
    equb &03, &e3, &e0, &e1, &41, &41, &00, &ff
    equb &fe, &fe, &00, &00, &00, &00, &00, &8a
    equb &00, &00, &00, &00, &7e, &7f, &7e, &00
    equb &01, &01, &01, &3f, &3f, &bf, &3f, &3f
    equb &f7, &ff, &c1, &f7, &c1, &ff, &f7, &bf
    equb &8e, &9e, &de, &9c, &9e, &8e, &8e, &80
    equs "~>~"
    equb &00
    equs "|z~"
    equb &00, &2f, &1f, &00, &00, &00, &ce, &ae
    equb &5e, &1f, &1f, &1f, &1b, &17, &1f, &00
    equb &01, &80, &80, &80, &80, &80, &80, &02
    equb &02
    equs "~z~"
    equb &00, &7e, &3e, &7f, &00, &be, &0e, &0e
    equb &0f, &0e, &0e, &be, &00, &01, &01, &0f
    equb &df, &07, &03, &01, &00, &08, &08, &5a
    equb &fe, &fe, &fc, &b8, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &08, &2a
    equb &00, &00, &00, &00, &00, &11
    equs "33", &22, "33333"
    equb &ff, &c0, &33, &33, &ff, &c0, &33, &33
    equb &ff, &c0, &33, &33, &ff, &c0, &33, &33
    equb &ff, &c0, &33, &33, &ff, &c0, &33, &33
    equb &ff, &c0, &33, &33, &ff, &c0
    equs "33333"
    equb &11
    equs "33", &22
; &2200 used as index base 4 times by &152c, &1cd8, &1d8b, &77fe
.door_x
    equb &ff, &ff, &ff, &04, &ff, &ff, &06, &ff
    equb &11, &ff, &ff, &ff, &1a, &03, &03, &0b
    equb &ff, &03, &09, &12, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
; &2220 used as index base 4 times by &1532, &1ce3, &1d8e, &7804
.door_y
    equb &ff, &ff, &ff, &0d, &ff, &ff, &11, &ff
    equb &16, &ff, &ff, &ff, &1a
    equs "#'%"
    equb &ff
    equs "+.+"
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff
; &2240 used as index base 2 times by &1538, &7810
.door_sprite
    equb &ff, &1c, &1c, &1d, &1c, &1c, &1d, &1d
    equb &1d, &1d, &1d, &1c, &1c, &1d, &1d, &1c
    equb &1d, &1d, &1c, &1c, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
; &2260 used as index base 7 times by &1543, &1dce, &1e00, &1e45, &1e8c, &1ea1, &20aa
.key_x
    equb &13, &ff, &ff, &1b, &ff, &ff, &17, &ff
    equb &1c, &ff, &ff, &ff, &02, &15, &04, &09
    equb &ff, &04, &19, &17, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
; &2280 used as index base 7 times by &1549, &1dd4, &1e06, &1e4d, &1e92, &1ea4, &20b0
.key_y
    equb &25, &ff, &ff, &06, &ff, &ff, &09, &ff
    equb &18, &ff, &ff, &ff, &29, &04, &0c, &14
    equb &ff, &0f, &03, &04, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &03, &03, &03, &03, &02, &00, &00, &01
    equb &02, &00, &00, &01, &02, &00, &00, &01
    equb &02, &00, &00, &01, &02, &00, &00, &01
    equb &02, &00, &00, &01, &02, &00, &00, &01
    equb &02, &00, &00, &01, &02, &00, &00, &01
    equb &02, &00, &00, &01, &03, &03, &03, &03
    equb &00, &05, &0f, &0f, &0f, &05, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
; &22e0 used as index base 10 times by &159f, &1cf2, &1d95, &1deb, &1dfa, &1e0b, &1e86, &1e97, &20a4, &20b5
.hero_key
    equb &00, &00, &00, &00, &00
; &22e5 used as index base 4 times by &15a2, &1e28, &1e2f, &1e9c
.hero_key_dropped
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00
; &22f0 used as index base 4 times by &1079, &15a5, &1cc8, &6f9b
.hero_door_x
    equb &1a, &09, &00, &16, &00
; &22f5 used as index base 4 times by &108a, &15a8, &1cce, &6fa1
.hero_door_y
    equb &06, &1d, &00, &09, &00, &00, &00, &00
    equb &00, &00, &00, &01, &0a, &00, &00, &03
    equb &0a, &0b, &00, &03, &00, &0b, &02, &03
    equb &00, &00, &03, &03, &00, &0a, &03, &03
    equb &10, &1a, &01, &01, &27, &0f, &23, &01
    equs "33#"
    equb &01, &13, &33, &00, &03, &13, &33, &00
    equb &03, &03, &22, &00, &03, &03, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &0f, &00, &00, &0f
    equb &03, &00, &0a, &03, &03, &10, &1a, &01
    equb &01, &27, &0f, &23, &01
    equs "33#"
    equb &01, &13, &33, &03, &00, &13, &33, &03
    equb &00, &03, &23, &03, &00, &01, &01, &03
    equb &03, &00, &03, &00, &03, &03, &03, &02
    equb &03, &13, &00, &0f, &03, &27, &00, &00
    equb &13, &32, &00, &00, &13, &27, &0a, &00
    equb &13, &27, &0a, &00, &13, &32, &00, &00
    equb &01, &27, &00, &0a, &00, &13, &01, &0a
    equb &00, &03, &03, &0a, &00, &01, &03, &00
    equb &00, &00, &00, &00, &00, &01, &03, &0a
    equb &00, &13, &07, &00, &01, &27, &00, &00
    equb &11, &32, &00, &00, &11, &27, &0a, &00
    equb &13, &27, &0a, &00, &13, &32, &00, &00
    equb &03, &27, &05, &00, &03, &13, &07, &00
    equb &03, &03, &07, &00, &03, &01, &02, &00
    equb &00, &00, &03, &03, &00, &11, &03, &03
    equb &00, &33, &23, &03, &00, &33, &23, &02
    equb &13, &33, &33, &02, &13, &0f, &1b, &02
    equb &02, &25, &20, &03, &03, &05, &00, &03
    equb &03, &00, &00, &03, &01, &07, &00, &03
    equb &00, &07, &05, &03, &00, &00, &05, &02
    equb &03, &02, &02, &00, &03, &13, &03, &00
    equb &03, &33, &23, &00, &03, &33, &23, &02
    equb &13, &33, &33, &02, &13, &0f, &1b, &02
    equb &02, &25, &20, &03, &03, &05, &00, &03
    equb &0f, &00, &00, &0f, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &03, &02, &00, &05, &03, &03, &00
    equb &05, &02, &23, &00, &05, &00, &1b, &02
    equb &00, &00, &31, &23, &00, &05, &1b, &23
    equb &00, &05, &1b, &23, &00, &00, &31, &23
    equb &00, &00, &1b, &03, &0f, &00, &23, &03
    equb &01, &03, &03, &03, &00, &03, &00, &03
    equb &00, &01, &02, &03, &00, &0b, &03, &03
    equb &00, &0b, &23, &03, &00, &0a, &1b, &03
    equb &00, &00, &31, &23, &00, &05, &1b, &23
    equb &00, &05, &1b, &22, &00, &00, &31, &22
    equb &00, &00, &1b, &02, &00, &0b, &23, &00
    equb &05, &03, &02, &00, &00, &00, &00, &00
    equb &00, &00, &3f, &3f, &00, &0f, &05, &0a
    equb &01, &0f, &2d, &1e, &01, &0f, &05, &0a
    equb &0b, &02, &00, &03, &0f, &1a, &20, &0f
    equb &0f, &34, &38, &0f, &0f, &30, &30, &0f
    equb &0f, &34, &38, &0f, &0b, &1a, &25, &07
    equb &05, &03, &0b, &0a, &00, &0b, &07, &00
    equb &00, &15, &3f, &2a, &05, &0a, &0f, &00
    equb &07, &1e, &0f, &28, &07, &0a, &0f, &00
    equb &03, &02, &01, &02, &0f, &10, &25, &0a
    equb &0f, &34, &38, &0f, &0f, &30, &30, &0f
    equb &0f, &34, &38, &0f, &0f, &12, &21, &0f
    equb &01, &0b, &07, &02, &00, &07, &03, &00
    equb &00, &0f, &02, &00, &05, &0b, &0f, &0a
    equb &05, &0b, &0f, &0a, &0b, &1a, &05, &0a
    equb &07
    equs "4 ("
    equb &0b
    equs "4 ("
    equb &03
    equs "4 ("
    equb &07
    equs "4 ="
    equb &0b, &12, &05, &1f, &01, &0f, &07, &1f
    equb &05, &0f, &07, &1f, &00, &0f, &03, &3d
    equb &00, &0f, &02, &28, &05, &0b, &0f, &0a
    equb &05, &0b, &0f, &0a, &03, &1a, &05, &0a
    equb &0b
    equs "4 ("
    equb &03
    equs "4 ="
    equb &0b, &34, &25, &1f, &07, &34, &25, &1f
    equb &0b, &1a, &07, &1f, &05, &0f, &07, &15
    equb &05, &0f, &03, &00, &00, &0f, &00, &00
    equb &00, &0b, &07, &00, &05, &07, &03, &0a
    equb &0b, &1a, &25, &07, &0f, &34, &38, &0f
    equb &0f, &30, &30, &0f, &0f, &34, &38, &0f
    equb &0f, &10, &25, &0f, &03, &00, &01, &07
    equb &05, &0a, &0f, &02, &2d, &1e, &0f, &02
    equb &05, &0a, &0f, &00, &3f, &3f, &00, &00
    equb &00, &03, &0b, &00, &01, &0b, &07, &02
    equb &0f, &12, &21, &0f, &0f, &34, &38, &0f
    equb &0f, &30, &30, &0f, &0f, &34, &38, &0f
    equb &05, &1a, &20, &0f, &01, &02, &01, &03
    equb &00, &0f, &05, &0b, &14, &0f, &2d, &0b
    equb &00, &0f, &05, &0a, &15, &3f, &2a, &00
    equb &3e, &03, &0f, &00, &2f, &0b, &0f, &0a
    equb &2f, &0b, &0f, &02, &2f, &0a, &21, &07
    equb &3e, &10, &38, &0b, &14, &10, &38, &03
    equb &14, &10, &38, &07, &14, &10, &38, &0b
    equb &05, &0a, &25, &07, &05, &0f, &07, &0a
    equb &05, &0f, &07, &0a, &00, &01, &0f, &00
    equb &00, &00, &0f, &00, &00, &03, &0f, &0a
    equb &2a, &0b, &0f, &0a, &2f, &0b, &25, &07
    equb &2f, &1a, &38, &0b, &2f, &1a, &38, &07
    equb &3e, &10, &38, &03, &14, &10, &38, &07
    equb &05, &0a, &25, &03, &05, &0f, &07, &0a
    equb &05, &0f, &07, &0a, &14, &01, &0f, &00
    equb &00, &15, &00, &00, &00, &00, &2a, &00
    equb &28, &0a, &15, &00, &2d, &0e, &00, &2b
    equb &39, &0e, &00, &03, &39, &26, &0a
    equs "39#"
    equb &0b
    equs "39'"
    equb &0f, &33, &00
    equs "6<", &22
    equb &00
    equs "><*"
    equb &15, &00, &0c, &15, &00, &00, &0c, &00
    equb &00, &28, &00, &15, &00, &28, &00, &15
    equb &14, &00, &00, &15, &14, &27, &04, &1d
    equb &39, &27, &04, &1d, &39, &22, &0e, &1d
    equb &11, &32, &1a, &03, &00, &27, &0f, &33
    equb &00
    equs "6<3"
    equb &00
    equs "><*"
    equb &15, &04, &08, &15, &00, &04, &08, &00
    equb &00
    equs "<<("
    equb &00, &11, &22, &00
    equs "*3'"
    equb &0a, &15, &39, &05, &00, &14, &06, &08
    equb &00, &14, &0f, &08, &00, &14, &0f, &00
    equb &00, &1c, &02, &00, &15, &1d, &28, &00
    equs "*;3"
    equb &17, &00, &00, &33, &0a, &00, &00, &01
    equb &0a, &00, &00, &00, &28, &00
    equs "*36"
    equb &00, &15
    equs "93("
    equb &1c, &02, &11, &1e, &1c, &0f, &00, &0a
    equb &14, &0f, &00, &00, &14, &02, &00, &00
    equb &15, &2c, &08, &00, &3b, &26, &08, &00
    equb &11, &23, &00, &00, &11
    equs "#??"
    equb &00, &00, &00, &00, &00, &0c, &00, &00
    equb &2a, &0c, &00, &2a, &15, &3c, &3d, &00
    equb &11, &3c, &39, &00, &33, &0f, &1b, &36
    equb &33, &07, &13, &36, &33, &05, &19, &36
    equb &03, &00, &0d, &36, &17, &00, &0d, &1e
    equb &00, &2a, &05, &14, &00, &15, &00, &00
    equb &00, &00, &2a, &00, &00, &04, &08, &00
    equb &2a, &04, &08, &2a, &15, &3c, &3d, &00
    equs "3<9"
    equb &00, &33, &0f, &1b, &00, &03
    equs "%1", &22, "."
    equb &0d, &11, &36, &2e, &08, &1b, &36, &2e
    equb &08, &1b, &28, &2a, &00, &00, &28, &2a
    equb &00, &14, &00, &2a, &00, &14, &00, &00
    equb &05, &02, &00, &00, &05, &33, &00, &00
    equs "+37"
    equb &15, &00, &14, &2e, &2a, &00, &01, &2c
    equb &00, &00, &0f, &28, &00, &04, &0f, &28
    equb &00, &04, &09, &28, &00, &0a, &36, &2a
    equb &05, &1b, &33, &15, &00, &11, &22, &00
    equb &14, &3c, &3c, &00, &3f, &3f, &13, &22
    equb &00, &00, &13, &22, &00, &04, &19, &37
    equb &00, &04, &1c, &2a, &00, &00, &01, &28
    equb &00, &00, &0f, &28, &05, &00, &0f
    equs ",-", &22
    equb &01, &2c, &14
    equs "36*"
    equb &00, &39, &33, &15, &00, &14, &00, &00
    equb &00, &00, &00, &00, &00, &00, &0a, &00
    equb &00, &01, &03, &00, &00, &05, &07, &00
    equb &00, &01, &0b, &00, &00, &05, &07, &00
    equb &00, &05, &07, &00, &00, &05, &0f, &00
    equb &00, &00, &0a, &00, &00, &00, &0a, &00
    equb &00, &00, &0a, &00, &00, &00, &0a, &00
    equb &00, &00, &0a, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &05, &0a, &00, &0f, &0b, &07
    equb &0f, &0b, &07, &07, &00, &0f, &0b, &07
    equb &00, &00, &05, &0a, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &0a, &00
    equb &00, &00, &0a, &00, &00, &00, &0a, &00
    equb &00, &00, &0a, &00, &00, &00, &0a, &00
    equb &00, &05, &0f, &00, &00, &05, &07, &00
    equb &00, &05, &07, &00, &00, &01, &0b, &00
    equb &00, &05, &07, &00, &00, &01, &03, &00
    equb &00, &00, &0a, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &05, &0a, &00, &00, &0b, &07, &0f, &00
    equb &0b, &0b, &07, &0f, &0b, &07, &0f, &00
    equb &05, &0a, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &15, &2a
    equb &00, &00, &3f, &3f, &00, &00, &15, &2a
    equb &14
    equs "<<<"
    equb &00, &00, &15, &2a, &00, &00, &3f, &3f
    equb &00, &00, &15, &2a, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &14, &00, &00
    equb &00, &14, &00, &00, &00, &14, &00, &00
    equb &00, &14, &00, &00, &15, &14, &15, &00
    equb &15, &3e, &3f, &00, &15, &3e, &3f, &00
    equb &15, &3e, &3f, &00, &15, &14, &15, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &15, &2a, &00, &00, &3f, &3f, &00, &00
    equb &15, &2a, &00, &00
    equs "<<<("
    equb &15, &2a, &00, &00, &3f, &3f, &00, &00
    equb &15, &2a, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00
    equs "*(*"
    equb &00
    equs "?=*"
    equb &00
    equs "?=*"
    equb &00
    equs "?=*"
    equb &00
    equs "*(*"
    equb &00, &00, &28, &00, &00, &00, &28, &00
    equb &00, &00, &28, &00, &00, &00, &28, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &0a, &00, &00, &05, &05
    equb &00, &00, &05, &05, &0f, &0f, &0f, &05
    equb &0a, &0a, &05, &05, &0a, &0a, &05, &05
    equb &0a, &0a, &00, &0a, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &03, &03, &02, &02, &13, &50, &02, &02
    equb &02, &24, &17, &03, &47, &00, &02, &03
    equb &12, &0d, &02, &03, &02, &4f, &02, &03
    equb &06, &32, &02, &03, &47, &02, &02, &03
    equb &12, &a5, &02, &03, &07, &08, &17, &03
    equb &06, &b0, &02, &02, &03, &03, &02, &02
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &2a, &00, &00, &00, &2a, &00, &00, &00
    equb &15, &00, &00, &00, &2f, &2a, &0f, &00
    equb &2f, &0f, &0f, &0a, &00, &0f, &03, &0b
    equb &00, &05, &0f, &03, &00, &05, &07, &02
    equb &00, &00, &03, &02, &00, &00, &03, &00
    equb &05, &0f, &0f, &00, &0a, &0f, &0f, &0a
    equb &0a, &00, &05, &00, &05, &30, &20, &0a
    equb &05, &00, &00, &0a, &00, &1a, &30, &05
    equb &00, &0a, &00, &05, &0f, &1a, &30, &25
    equb &0f, &00, &00, &0a, &0a, &30, &30, &0a
    equb &05, &00, &00, &0a, &00, &0f, &0f, &00
    equs "????><<8><<8>??8>>88>>88>>88>>88>008><<8><<80000"
    equb &00, &2c, &00, &00, &00, &2c, &08, &00
    equb &00, &0c, &08, &00, &04, &0f, &0e, &00
    equb &04, &08, &08, &0c, &08, &0c, &08, &0c
    equb &08, &0c, &0c, &04, &0c, &04, &0c, &04
    equb &0c, &04, &04, &08, &04, &00, &0c, &00
    equb &04, &00, &04, &00, &04, &00, &04, &00
    equb &04, &00, &04, &00, &04, &00, &0c, &00
    equb &04, &08, &08, &04, &08, &04, &00, &04
    equb &00, &08, &04, &00, &08, &00, &08, &04
    equb &08, &08, &0c, &0c, &04, &08, &08, &04
    equb &00, &04, &00, &04, &04, &08, &04, &08
    equb &00, &04, &00, &04, &0c, &04, &04, &08
    equb &00, &08, &04, &08, &04, &08, &08, &08
    equb &08, &0c, &0c, &08, &00, &0c, &00, &08
    equb &00, &08, &04, &08, &0c, &0c, &08, &04
    equb &08, &00, &08, &00, &04, &00, &00, &08
    equb &00, &04, &04, &04, &08, &04, &04, &08
    equb &00, &04, &00, &08, &04, &00, &04, &00
    equb &04, &08, &08, &04, &08, &04, &08, &04
    equb &08, &04, &04, &08, &0c, &0c, &00, &04
    equb &00, &08, &00, &08, &00, &08, &04, &00
    equb &04, &00, &04, &00, &04, &00, &0c, &08
    equb &04, &08, &08, &04, &08, &04, &08, &04
    equb &04, &08, &08, &04, &08, &04, &08, &04
    equb &08, &04, &04, &08, &04, &08, &08, &04
    equb &08, &04, &08, &04, &08, &04, &04, &08
    equb &00, &08, &00, &08, &04, &00, &08, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00
    equs "????><<8><<8><<8><<80000"
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &0f, &1a, &30, &20
    equb &00, &00, &00, &25, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &15, &2a, &00
    equb &00, &3f, &3f, &00, &00, &3f, &3f, &00
    equb &00, &15, &2a, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &3f, &3f, &00
    equb &00, &00, &00, &00, &15, &15, &2a, &2a
    equb &15, &00, &00, &2a, &15, &00, &00, &2a
    equb &15, &15, &2a, &2a, &00, &00, &00, &00
    equb &00, &3f, &3f, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &15
    equs "??*"
    equb &00, &3f, &3f, &00, &2a, &00, &00, &15
    equb &3f, &00, &00, &3f, &3f, &15
    equs "*??"
    equb &15
    equs "*??"
    equb &00, &00, &3f, &2a, &00, &00, &15, &00
    equb &3f, &3f, &00, &15
    equs "??*"
    equb &00, &00, &00, &00, &3f, &00, &00
    equs "??*"
    equb &15
    equs "?**"
    equb &15, &15, &2a, &00, &00, &15, &3f, &15
    equb &2a, &3f, &15, &2a, &15, &2a, &15, &2a
    equb &15, &2a, &3f, &15
    equs "*?*"
    equb &00, &00, &15, &2a, &2a, &15, &15, &3f
    equb &2a, &15, &3f, &3f, &00, &00
    equs "?<<<<)"
    equb &03, &03, &16, &3f, &12, &03, &16, &3f
    equb &03, &03, &34, &29, &03, &21, &16, &29
    equb &03, &03, &16
    equs ")!!"
    equb &16, &29, &03, &03, &34, &3f, &03, &21
    equb &16, &3f, &03, &03, &16, &29, &21, &12
    equb &16
    equs "<<<<"
    equb &00, &00, &00, &00, &04, &00, &00, &00
    equb &20, &00, &00, &00, &fd, &14, &93, &00
    equb &00, &00, &00, &00, &00, &15, &00, &00
    equb &00, &15, &00, &00, &00, &05, &00, &00
    equb &00, &05, &00, &00, &00, &05, &00, &00
    equb &00, &05, &00, &00, &00, &05, &00, &00
    equb &00, &05, &00, &00, &00, &0c, &08, &00
    equb &00, &08, &08, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &0c, &00, &00, &00
    equb &04, &0f, &0f, &2a, &0c, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &04, &04, &00
    equb &00, &04, &0c, &00, &00, &00, &0a, &00
    equb &00, &00, &0a, &00, &00, &00, &0a, &00
    equb &00, &00, &0a, &00, &00, &00, &0a, &00
    equb &00, &00, &0a, &00, &00, &00, &2a, &00
    equb &00, &00, &2a, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &0c, &15, &0f, &0f, &08
    equb &00, &00, &00, &0c, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &3f, &3a, &00, &00, &3e, &38, &00
    equb &00, &3e, &38, &00, &00, &3e, &38, &00
    equb &00, &3e, &38, &00, &00, &3e, &38, &00
    equb &00, &3e, &38, &00, &00, &3e, &38, &00
    equb &00, &3e, &38, &00, &00, &3e, &38, &00
    equb &00, &3e, &38, &00, &00, &30, &30, &00
    equb &01, &00, &00, &00, &17, &00, &00, &90
    equb &17, &00, &00, &00, &00, &00, &00, &00
; &2d00 used as index base 1 time by &157a
.wall_sprite
    equb &0f, &0b, &0f, &07, &03, &0f, &0f, &0f
    equb &0f, &1f, &2f, &0b, &0f, &2f, &0b, &0f
    equb &1f, &0f, &0f, &07, &1f, &1f, &0f, &07
    equb &17, &0f, &07, &07, &1f, &0f, &0f, &07
    equb &0f, &2f, &0b, &0f, &07, &0b, &07, &0f
    equb &0f, &0f, &0f, &03, &0b, &0f, &0f, &0f
    equb &00, &03, &0b, &00, &01, &00, &0a, &02
    equb &02, &00, &04, &01, &01, &02, &04, &00
    equb &0b, &02, &00, &08, &0b, &07, &00, &08
    equb &1c, &25, &34, &08, &1c, &0f, &1e, &08
    equb &04, &3c, &29, &08, &04, &3c, &0c, &00
    equb &00, &0c, &09, &00, &00, &00, &03, &00
    equb &00, &03, &02, &00, &00, &00, &01, &00
    equb &00, &00, &00, &0a, &05, &00, &03, &0a
    equb &05, &00, &03, &09, &04, &05, &03, &09
    equb &0c, &25, &34, &09, &1c, &0f, &1e, &09
    equb &04, &3c, &28, &08, &04, &3c, &0c, &00
    equb &01, &0c, &08, &00, &01, &02, &00, &00
    equb &00, &04, &0b, &00, &00, &0c, &0b, &00
    equb &04, &09, &02, &02, &04, &3c, &02, &03
    equb &14, &1a, &02, &01, &3c, &0f, &0a, &01
    equb &3c, &0f, &0a, &0d, &16, &1a, &04, &0d
    equb &03, &3c, &0c, &03, &03, &06, &08, &02
    equb &00, &00, &01, &00, &00, &00, &01, &00
    equb &00, &00, &08, &00, &00, &0c, &0d, &00
    equb &06, &0c, &05, &00, &06, &3c, &00, &00
    equb &16, &1a, &00, &01, &3c, &0f, &0a, &01
    equb &3c, &0f, &0a, &01, &14, &1a, &03, &01
    equb &00, &3c, &09, &03, &00, &0c, &0d, &02
    equb &00, &04, &07, &02, &00, &03, &02, &00
    equb &00, &03, &00, &00, &00, &06, &0c, &00
    equb &00, &0c, &3c, &08, &04, &16, &3c, &08
    equb &04, &2d, &0f, &2c, &04, &38, &1a, &2c
    equb &04, &00, &0b, &07, &04, &00, &01, &07
    equb &00, &08, &01, &02, &02, &08, &00, &01
    equb &01, &05, &00, &02, &00, &07, &03, &00
    equb &00, &00, &01, &02, &00, &04, &0c, &02
    equb &00, &0c, &3c, &08, &04, &14, &3c, &08
    equb &06, &2d, &0f, &2c, &06, &38, &1a, &0c
    equb &06, &03, &0a, &08, &06, &03, &00, &0a
    equb &05, &03, &00, &0a, &05, &00, &00, &00
    equb &00, &02, &00, &00, &00, &01, &03, &00
    equb &00, &02, &00, &00, &00, &02, &00, &00
    equb &01, &04, &09, &03, &03, &0c, &3c, &03
    equb &0e, &08, &25, &29, &0e, &05, &0f, &3c
    equb &02, &05, &0f, &3c, &02, &01, &25, &28
    equb &03, &01, &3c, &08, &01, &01, &06, &08
    equb &00, &07, &0c, &00, &00, &07, &08, &00
    equb &00, &00, &00, &02, &00, &00, &01, &13
    equb &04, &08, &01, &13, &45, &30, &8b, &13
    equb &10, &30, &20, &02, &1a, &30, &20, &02
    equb &1a, &30, &25, &07, &1e, &30, &2d, &0f
    equs "<<-"
    equb &0a, &14, &3c, &2c, &00, &00, &00, &0c
    equb &00, &00, &00, &0c, &00, &00, &04, &08
    equb &00, &00, &04, &08, &02, &45, &30, &8b
    equb &13, &10, &30, &21, &13, &10, &30, &21
    equb &13, &1a, &30, &20, &02, &0f, &30, &00
    equb &02, &1e, &3c, &2d, &07, &1e, &3c, &2d
    equb &0f, &14, &3c, &2d, &0a, &04, &08, &00
    equb &00, &04, &08, &00, &00, &00, &2d, &0a
    equb &00, &14, &2d, &00, &00, &14, &38, &8e
    equb &08, &14, &30, &24, &08, &14, &30, &24
    equb &08, &14, &30, &20, &00, &1c, &30, &20
    equb &00, &1c, &38, &8a, &00, &0c, &28, &00
    equb &00, &00, &3c, &01, &02, &00, &0f, &03
    equb &03, &00, &0f, &11, &22, &00, &2d, &0a
    equb &00, &14, &2d, &00, &00, &1c, &38, &8a
    equb &00, &1c, &30, &20, &00, &1c, &30, &20
    equb &00, &14, &30, &24, &08
    equs "<0$"
    equb &08, &3c, &10, &8e, &08, &0f, &00, &00
    equb &00, &0f, &01, &02, &00, &0b, &03, &03
    equb &00, &00, &11, &22, &00, &00, &0c, &00
    equb &00, &00, &0c, &00, &00, &00, &1c, &3c
    equb &28, &05, &1e, &3c, &3c, &0f, &1e, &30
    equb &2d, &0b, &1a, &30, &25, &01, &10, &30
    equb &25, &01, &10
    equs "0 #G0"
    equb &8a, &23, &02, &04, &08, &23, &02, &00
    equb &00, &01, &00, &00, &00, &00, &00, &04
    equb &08, &00, &00, &04, &08, &05, &1e, &3c
    equb &28, &0f, &1e, &3c, &2d, &0b, &1e, &3c
    equb &2d, &01, &00, &30, &0f, &01, &10
    equs "0%#"
    equb &12
    equs "0 #"
    equb &12
    equs "0 #G0"
    equb &8a, &01, &04, &08, &00, &00, &04, &08
    equb &00, &11, &22, &0f, &00, &03, &03, &0f
    equb &00, &01, &02, &3c, &00, &00, &00, &14
    equb &0c, &00
    equs "E4,"
    equb &00, &10, &30, &2c, &00, &10, &30, &28
    equb &04, &18, &30, &28, &04, &18, &30, &28
    equb &04
    equs "M4("
    equb &00, &00, &1e, &28, &00, &05, &1e, &00
    equb &00, &11, &22, &00, &00, &03, &03, &07
    equb &00, &01, &02, &0f, &00, &00, &00, &0f
    equb &04
    equs "M <"
    equb &04, &18, &30, &3c, &04, &18, &30, &28
    equb &00, &10, &30, &2c, &00, &10, &30, &2c
    equb &00
    equs "E4,"
    equb &00, &00, &1e, &28, &00, &05, &1e, &00

    org &6e80
; ***************************************************************************************
; Move the heroes
;
; For each hero in play: continue a step between cells, or read the hero's keys (and, for
; heroes 0 and 1, the magic key) and start a step or fire a missile; check the new cell
; for walls, monsters, other heroes and objects, change view when the hero enters another
; room, and draw the hero.
; &6e80 referenced 1 time by &1cc0
.move_heroes
    ldx #0
; &6e82 referenced 1 time by &70c6
.code_6e82
    lda hero_direction,x
    bne code_6e97
    lda hero_step,x
    cmp #&63 ; 'c'
    bne code_6e91
    jmp code_70c1
; &6e91 referenced 1 time by &6e8c
.code_6e91
    jsr animate_absent_hero
    jmp code_70c1
; &6e97 referenced 1 time by &6e85
.code_6e97
    lda hero_x,x
    sta previous_x
    lda hero_y,x
    sta previous_y
    lda hero_offset_x,x
    sta previous_offset_x
    lda hero_offset_y,x
    sta previous_offset_y
    lda hero_step,x
    beq code_6eba
    jsr continue_hero_step
    jmp code_7075
; &6eba referenced 1 time by &6eb2
.code_6eba
    cpx #2
    bcs code_6ec1
    jmp code_7619
; &6ec1 referenced 2 times by &6ebc, &76ab
.code_6ec1
    lda hero_key_up,x
    jsr test_key
    bne code_6ed4
    lda #1
    sta hero_direction,x
    jsr start_hero_step
    jmp code_6f79
; &6ed4 referenced 1 time by &6ec7
.code_6ed4
    lda hero_key_down,x
    jsr test_key
    bne code_6ee7
    lda #5
    sta hero_direction,x
    jsr start_hero_step
    jmp code_6f79
; &6ee7 referenced 1 time by &6eda
.code_6ee7
    lda hero_key_right,x
    jsr test_key
    bne code_6efa
    lda #3
    sta hero_direction,x
    jsr start_hero_step
    jmp code_6f79
; &6efa referenced 1 time by &6eed
.code_6efa
    lda hero_key_left,x
    jsr test_key
    bne code_6f0d
    lda #7
    sta hero_direction,x
    jsr start_hero_step
    jmp code_6f79
; &6f0d referenced 1 time by &6f00
.code_6f0d
    lda hero_key_fire,x
    jsr test_key
    beq code_6f18
    jmp code_7096
; &6f18 referenced 1 time by &6f13
.code_6f18
    txa
    sta scratch
    asl a
    clc
    adc scratch
    tay
    adc hero_max_missiles,x
    sta scratch
; &6f28 referenced 1 time by &6f74
.loop_6f28
    lda missile_direction,y
    bne code_6f70
    lda hero_direction,x
    clc
    adc #1
    lsr a
    ora #&80
    sta missile_direction,y
    lda hero_x,x
    sta missile_x,y
    lda hero_y,x
    sta missile_y,y
    lda #7
    jsr oswrch
    lda hero_missile_damage,x
    sta missile_damage,y
    lda hero_missile_sprites,x
    sta missile_sprite_base,y
    lda previous_x
    sta hero_x,x
    lda previous_y
    sta hero_y,x
    lda hero_frame,x
    eor #1
    sta hero_frame,x
    jmp code_7096
    equb &88, &d0, &b8
; &6f70 referenced 1 time by &6f2b
.code_6f70
    iny
    cpy scratch
    bne loop_6f28
    jmp code_7096
; &6f79 referenced 4 times by &6ed1, &6ee4, &6ef7, &6f0a
.code_6f79
    lda hero_direction,x
    cmp #1
    bne code_6f83
    dec hero_y,x
; &6f83 referenced 1 time by &6f7e
.code_6f83
    cmp #3
    bne code_6f8a
    inc hero_x,x
; &6f8a referenced 1 time by &6f85
.code_6f8a
    cmp #5
    bne code_6f91
    inc hero_y,x
; &6f91 referenced 1 time by &6f8c
.code_6f91
    cmp #7
    bne code_6f98
    dec hero_x,x
; &6f98 referenced 1 time by &6f93
.code_6f98
    lda hero_x,x
    sta hero_door_x,x
    lda hero_y,x
    sta hero_door_y,x
    lda hero_x,x
    sta cell_x
    lda hero_y,x
    sta cell_y
    txa
    pha
    jsr test_wall
    pla
    tax
    cpy #0
    beq code_6fd5
    lda previous_x
    sta hero_x,x
    lda previous_y
    sta hero_y,x
; &6fc7 referenced 1 time by &7050
.code_6fc7
    lda #0
    sta hero_step,x
    sta hero_offset_x,x
    sta hero_offset_y,x
    jmp code_7075
; &6fd5 referenced 1 time by &6fb9
.code_6fd5
    lda #0
    sta scratch
    txa
    pha
    jsr find_creature
    pla
    tax
    cpy #0
    beq code_7002
    lda previous_x
    sta hero_x,x
    lda previous_y
    sta hero_y,x
    lda #0
    sta hero_step,x
    sta hero_offset_x,x
    sta hero_offset_y,x
    jsr lose_health_point
    jmp code_7075
; &7002 referenced 1 time by &6fe3
.code_7002
    stx scratch
    ldy #0
; &7007 referenced 1 time by &703e
.loop_7007
    cpy scratch
    beq code_703b
    lda hero_x,y
    cmp cell_x
    bne code_703b
    lda hero_y,y
    cmp cell_y
    bne code_703b
    lda hero_direction,y
    beq code_703b
    lda previous_x
    sta hero_x,x
    lda previous_y
    sta hero_y,x
    lda #0
    sta hero_step,x
    sta hero_offset_x,x
    sta hero_offset_y,x
    jmp code_7075
; &703b referenced 4 times by &700a, &7012, &701a, &701f
.code_703b
    iny
    cpy #4
    bne loop_7007
    txa
    asl a
    tax
    lda view_room,x
    cmp data_007b
    beq code_7053
    txa
    lsr a
    tax
    jsr code_752c
    jmp code_6fc7
; &7053 referenced 1 time by &7048
.code_7053
    txa
    lsr a
    tax
    lda hero_has_boots,x
    beq code_7069
    lda #0
    sta hero_offset_x,x
    sta hero_offset_y,x
    sta hero_step,x
    jmp code_7075
; &7069 referenced 1 time by &7059
.code_7069
    lda previous_x
    sta hero_x,x
    lda previous_y
    sta hero_y,x
; &7075 referenced 5 times by &6eb7, &6fd2, &6fff, &7038, &7066
.code_7075
    lda #&15
    sta sprite_number
    lda previous_x
    sta cell_x
    lda previous_y
    sta cell_y
    lda previous_offset_x
    sta data_007d
    lda previous_offset_y
    sta data_007e
    txa
    pha
    jsr plot_at_cell
    pla
    tax
; &7096 referenced 4 times by &6f15, &6f6a, &6f76, &76ae
.code_7096
    clc
    lda hero_direction,x
    beq code_70c1
    adc hero_frame,x
    adc hero_sprites,x
    sta sprite_number
    jsr draw_hero
    lda hero_x,x
    sta cell_x
    lda hero_y,x
    sta cell_y
    txa
    pha
    jsr test_object_free
    pla
    tax
    cpy #0
    bne code_70c1
    jsr collect_objects
; &70c1 referenced 4 times by &6e8e, &6e94, &709a, &70bc
.code_70c1
    inx
    cpx #4
    beq return_9
    jmp code_6e82
; &70c9 referenced 1 time by &70c4
.return_9
    rts
; ***************************************************************************************
; Move the missiles
;
; Advance every missile in flight one cell. A missile stops at a wall, damages a monster
; or hero it meets, and bounces back off an energy drainer, wearing it down.
; &70ca referenced 1 time by &1ed1
.move_missiles
    lda #0
    sta data_007d
    sta data_007e
    ldx #0
; &70d2 referenced 1 time by &721d
.code_70d2
    lda missile_direction,x
    bne code_70da
    jmp code_7218
; &70da referenced 1 time by &70d5
.code_70da
    bpl code_70e7
    and #&7f
    sta missile_direction,x
    jsr flip_firer_frame
    jmp code_70fe
; &70e7 referenced 1 time by &70da
.code_70e7
    lda #&15
    sta sprite_number
    lda missile_x,x
    sta cell_x
    lda missile_y,x
    sta cell_y
    txa
    pha
    jsr plot_at_cell
    pla
    tax
; &70fe referenced 1 time by &70e4
.code_70fe
    lda missile_direction,x
    cmp #1
    bne code_7108
    dec missile_y,x
; &7108 referenced 1 time by &7103
.code_7108
    cmp #2
    bne code_710f
    inc missile_x,x
; &710f referenced 1 time by &710a
.code_710f
    cmp #3
    bne code_7116
    inc missile_y,x
; &7116 referenced 1 time by &7111
.code_7116
    cmp #4
    bne code_711d
    dec missile_x,x
; &711d referenced 1 time by &7118
.code_711d
    lda missile_x,x
    sta cell_x
    lda missile_y,x
    sta cell_y
    txa
    pha
    jsr test_wall
    beq code_713a
; &7130 referenced 2 times by &71fe, &75ab
.code_7130
    pla
    tax
; &7132 referenced 1 time by &7153
.code_7132
    lda #0
    sta missile_direction,x
    jmp code_7218
; &713a referenced 1 time by &712e
.code_713a
    lda #0
    sta scratch
    jsr find_creature
    beq code_7156
    lda monster_sprite,x
    cmp #&16
    bcs code_7156
    pla
    tay
    jmp code_757c
; &7150 referenced 1 time by &75a3
.code_7150
    jsr credit_missile_owner
    jmp code_7132
; &7156 referenced 2 times by &7142, &7149
.code_7156
    pla
    tax
    lda missile_x,x
    sta cell_x
    lda missile_y,x
    sta cell_y
    txa
    pha
    jsr test_object_free
    pla
    tax
    cpy #0
    bne code_71d9
    txa
    pha
    ldx #&1e
; &7173 referenced 1 time by &71d5
.loop_7173
    lda object_x,x
    cmp cell_x
    bne code_71d4
    lda object_y,x
    cmp cell_y
    bne code_71d4
    lda object_type,x
    cmp #&53 ; 'S'
    bcc code_71d7
    cmp #&5f ; '_'
    bcs code_71d7
    inc object_type,x
    lda object_type,x
    cmp #&5f ; '_'
    bne code_71a0
    lda #&ff
    sta object_x,x
    sta object_y,x
; &71a0 referenced 1 time by &7196
.code_71a0
    pla
    tax
    jsr credit_missile_owner
    lda missile_direction,x
    cmp #1
    bne code_71b4
    lda #3
    sta missile_direction,x
    jmp code_71d9
; &71b4 referenced 1 time by &71aa
.code_71b4
    cmp #2
    bne code_71c0
    lda #4
    sta missile_direction,x
    jmp code_71d9
; &71c0 referenced 1 time by &71b6
.code_71c0
    cmp #3
    bne code_71cc
    lda #1
    sta missile_direction,x
    jmp code_71d9
; &71cc referenced 1 time by &71c2
.code_71cc
    lda #2
    sta missile_direction,x
    jmp code_71d9
; &71d4 referenced 2 times by &7179, &7181
.code_71d4
    dex
    bne loop_7173
; &71d7 referenced 2 times by &7188, &718c
.code_71d7
    pla
    tax
; &71d9 referenced 5 times by &716d, &71b1, &71bd, &71c9, &71d1
.code_71d9
    txa
    pha
    ldx #0
; &71dd referenced 1 time by &7204
.loop_71dd
    pla
    tay
    pha
    lda hero_x,x
    cmp cell_x
    bne code_7201
    lda hero_y,x
    cmp cell_y
    bne code_7201
    lda missile_damage,y
    tay
; &71f4 referenced 1 time by &71fc
.loop_71f4
    tya
    pha
    jsr lose_health_point
    pla
    tay
    dey
    bne loop_71f4
    jmp code_7130
; &7201 referenced 2 times by &71e6, &71ee
.code_7201
    inx
    cpx #4
    bne loop_71dd
    pla
    tax
    clc
    lda missile_sprite_base,x
    adc missile_direction,x
    sta sprite_number
    txa
    pha
    jsr plot_at_cell
    pla
    tax
; &7218 referenced 2 times by &70d7, &7137
.code_7218
    inx
    cpx #&0c
    beq return_10
    jmp code_70d2
; &7220 referenced 1 time by &721b
.return_10
    rts
; ***************************************************************************************
; Take one health point from a hero
;
; If hero X is in play, take one from their health and redraw it. When it falls below 00
; the hero dies: their sprite is erased, they leave play, and their number joins
; returning_hero_queue.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &7221 referenced 8 times by &0eff, &6ffc, &71f6, &749a, &7512, &7654, &772a, &79ac
.lose_health_point
    lda hero_direction,x                ; Is the hero in play?
    bne code_7227                       ; Yes
    rts                                 ; No: return
; &7227 referenced 1 time by &7224
.code_7227
    dec hero_health_units,x             ; Take one from the units digit
    lda hero_health_units,x             ; ...
    cmp #&1d                            ; Below 0?
    bne code_7266                       ; No: redraw
    lda #&27                            ; Yes: units 9...
    sta hero_health_units,x             ; ...
    dec hero_health_tens,x              ; ...and take one from the tens
    lda hero_health_tens,x              ; ...
    cmp #&1d                            ; Below 0: the hero has died
    bne code_7266                       ; No: redraw
    lda #&15                            ; Erase the hero...
    sta sprite_number                   ; ...
    jsr draw_hero                       ; ...
    lda #0                              ; ...take them out of play...
    sta hero_direction,x                ; ...
    lda #1                              ; ...and start the death animation: step +1 through hero_appearance_sprites, every other frame
    sta hero_offset_x,x                 ; ...
    sta hero_offset_y,x                 ; ...
    ldy #0                              ; Add hero number + 1 at the end of returning_hero_queue
; &7256 referenced 1 time by &7264
.loop_7256
    lda returning_hero_queue,y          ; ...
    bne code_7263                       ; ...
    txa                                 ; ...
    clc                                 ; ...
    adc #1                              ; ...
    sta returning_hero_queue,y          ; ...
    rts                                 ; Return
; &7263 referenced 1 time by &7259
.code_7263
    iny                                 ; ...
    bne loop_7256                       ; ...
; &7266 referenced 3 times by &722f, &723e, &73a2
.code_7266
    lda hero_panel_y,x                  ; Draw the health: tens digit at column &45...
    sta plot_y                          ; ...
    lda #&45 ; 'E'                      ; ...
    sta plot_x                          ; ...
    lda hero_health_tens,x              ; ...
    sta sprite_number                   ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_sprite                     ; ...
    pla                                 ; ...
    tax                                 ; ...
    lda hero_health_units,x             ; ...units digit at column &48
    sta sprite_number                   ; ...
    lda #&48 ; 'H'                      ; ...
    sta plot_x                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_sprite                     ; ...
    pla                                 ; ...
    tax                                 ; ...
    rts                                 ; Return
; ***************************************************************************************
; Add one point to a hero's score
;
; Add one to hero X's score, carrying into the higher digits, and redraw it.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &728c referenced 5 times by &0f02, &1d05, &73a9, &76a2, &76d4
.add_point
    inc hero_score_units,x              ; Add one to the units digit
    lda hero_score_units,x              ; ...
    cmp #&28 ; '('                      ; Past 9?
    bne code_72bc                       ; No: redraw
    lda #&1e                            ; Yes: units 0, and carry into the tens
    sta hero_score_units,x              ; ...
; ***************************************************************************************
; Add ten points to a hero's score
;
; Add ten to hero X's score, carrying into the higher digits, and redraw it.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &729b referenced 4 times by &737f, &7382, &7419, &74d5
.add_ten_points
    inc hero_score_tens,x               ; Add one to the tens digit
    lda hero_score_tens,x               ; ...
    cmp #&28 ; '('                      ; Past 9?
    bne code_72bc                       ; No: redraw
    lda #&1e                            ; Yes: tens 0...
    sta hero_score_tens,x               ; ...
    inc hero_score_hundreds,x           ; ...and add one to the hundreds
    lda hero_score_hundreds,x           ; ...
    cmp #&28 ; '('                      ; Past 9?
    bne code_72bc                       ; No: redraw
    lda #&1e                            ; Yes: hundreds 0...
    sta hero_score_hundreds,x           ; ...
    jsr add_thousand_points             ; ...and add a thousand
; &72bc referenced 3 times by &7294, &72a3, &72b2
.code_72bc
    clc                                 ; Draw the score twelve rows below the health: thousands at column &45...
    lda hero_panel_y,x
    adc #&0c
    sta plot_y
    lda #&45 ; 'E'
    sta plot_x
    lda hero_score_thousands,x
    sta sprite_number
    txa
    pha
    jsr plot_sprite
    pla
    tax
    lda hero_score_hundreds,x           ; ...hundreds at &48...
    sta sprite_number
    lda #&48 ; 'H'
    sta plot_x
    txa
    pha
    jsr plot_sprite
    pla
    tax
    lda hero_score_tens,x               ; ...tens at &4B...
    sta sprite_number
    lda #&4b ; 'K'
    sta plot_x
    txa
    pha
    jsr plot_sprite
    pla
    tax
    lda hero_score_units,x              ; ...units at &4E
    sta sprite_number
    lda #&4e ; 'N'
    sta plot_x
    txa
    pha
    jsr plot_sprite
    pla
    tax
    rts                                 ; Return
; &7305 referenced 1 time by &1ece
.sub_7305
    lda #0
    sta data_007d
    sta data_007e
    ldx #&1e
; &730d referenced 1 time by &7326
.loop_730d
    lda object_x,x
    sta cell_x
    lda object_y,x
    sta cell_y
    lda object_type,x
    sta sprite_number
    txa
    pha
    jsr plot_at_cell
    pla
    tax
    dex
    bne loop_730d
    rts
; ***************************************************************************************
; Pick up the object in a hero's cell
;
; Find the object at hero X's cell and act on it: score, health, teleport, resurrection,
; energy drain, or one of the magic items.
;
; On Entry:
;     X: hero number (0-3)
; &7329 referenced 1 time by &70be
.collect_objects
    lda hero_x,x
    sta cell_x
    lda hero_y,x
    sta cell_y
    ldy #&1e
; &7337 referenced 1 time by &7473
.code_7337
    lda object_x,y
    cmp cell_x
    beq code_7342
    jmp code_7470
; &7342 referenced 1 time by &733d
.code_7342
    lda object_y,y
    cmp cell_y
    beq code_734d
    jmp code_7470
; &734d referenced 1 time by &7348
.code_734d
    tya
    pha
    lda #0
    sta hero_has_boots,x
    jsr point_at_boots_icon
    jsr erase_boots_icon
    pla
    tay
    lda object_type,y
    cmp #&28 ; '('
    bne code_738a
    txa
    pha
    tya
    pha
    ldx #&16
    ldy #&19
    lda #osword_envelope
    jsr osword                          ; ENVELOPE command
    ldx #&24 ; '$'
    ldy #&19
    lda #osword_sound
    jsr osword                          ; SOUND command
    pla
    tay
    pla
    tax
    tya
    pha
    jsr add_ten_points
    jsr add_ten_points
    pla
    tay
    jmp code_7467
; &738a referenced 1 time by &7361
.code_738a
    cmp #&29 ; ')'
    bne code_73c3
    inc hero_health_tens,x
    lda hero_health_tens,x
    cmp #&28 ; '('
    bne code_73a0
    lda #&27
    sta hero_health_tens,x
    sta hero_health_units,x
; &73a0 referenced 1 time by &7396
.code_73a0
    tya
    pha
    jsr code_7266
    ldy #5
; &73a7 referenced 1 time by &73af
.loop_73a7
    tya
    pha
    jsr add_point
    pla
    tay
    dey
    bne loop_73a7
    txa
    pha
    ldx #&f8
    ldy #&0b
    lda #osword_sound
    jsr osword                          ; SOUND command
    pla
    tax
    pla
    tay
    jmp code_7467
; &73c3 referenced 1 time by &738c
.code_73c3
    cmp #&2b ; '+'
    bne code_740d
; &73c7 referenced 2 times by &73d1, &73d6
.code_73c7
    dey
    lda object_type,y
    cmp #&2b ; '+'
    beq code_73d9
    cpy #0
    bne code_73c7
    ldy data_0dfd
    jmp code_73c7
; &73d9 referenced 1 time by &73cd
.code_73d9
    txa
    pha
    tya
    pha
    ldx #&f0
    ldy #&0b
    lda #osword_sound
    jsr osword                          ; SOUND command
    pla
    tay
    pla
    tax
    lda object_x,y
    sta hero_x,x
    sta cell_x
    lda object_y,y
    sec
    sbc #1
    sta hero_y,x
    sta cell_y
    lda #0
    sta hero_step,x
    sta hero_offset_x,x
    sta hero_offset_y,x
    jmp code_752c
; &740d referenced 1 time by &73c5
.code_740d
    cmp #&2a ; '*'
    bne code_7477
    lda #&ff
    sta object_x,y
    sta object_y,y
    jsr add_ten_points
    txa
    pha
    jsr play_pickup_sound
    lda returning_hero_queue
    bne code_7429
    pla
    tax
    rts
; &7429 referenced 1 time by &7424
.code_7429
    ldy #0
; &742b referenced 1 time by &744a
.loop_742b
    ldx returning_hero_queue
    dex
    lda data_0b2b
    sta returning_hero_queue
    lda data_0b2c
    sta data_0b2b
    lda data_0b2d
    sta data_0b2c
    sty data_0b2d
    cpx #&63 ; 'c'
    bne code_744c
    ldy #&64 ; 'd'
    bne loop_742b
; &744c referenced 1 time by &7446
.code_744c
    cpx #&ff
    beq code_7464
    lda #0
    sta hero_direction,x
    lda #8
    sta hero_frame,x
    lda #&ff
    sta hero_offset_x,x
    lda #1
    sta hero_offset_y,x
; &7464 referenced 1 time by &744e
.code_7464
    pla
    tax
    rts
; &7467 referenced 2 times by &7387, &73c0
.code_7467
    lda #&ff
    sta object_x,y
    sta object_y,y
    rts
; &7470 referenced 3 times by &733f, &734a, &747d
.code_7470
    dey
    beq return_11
    jmp code_7337
; &7476 referenced 1 time by &7471
.return_11
    rts
; &7477 referenced 1 time by &740f
.code_7477
    cmp #&5f ; '_'
    bcs code_74b6
    cmp #&51 ; 'Q'
    beq code_7470
    lda #&32 ; '2'
    sta data_0cf4
    txa
    pha
    ldx #&f0
    ldy #&0c
    lda #osword_sound
    jsr osword                          ; SOUND command
    lda #6
    sta data_0cf4
    pla
    tax
    ldy #&0a
; &7498 referenced 1 time by &74a0
.loop_7498
    tya
    pha
    jsr lose_health_point
    pla
    tay
    dey
    bne loop_7498
    rts
; ***************************************************************************************
; Play the pickup sound
;
; Define the pickup envelope and play the pickup sound, from the OSWORD parameter blocks
; at &192C and &193A.
; &74a3 referenced 2 times by &741e, &74ca
.play_pickup_sound
    ldx #&2c ; ','
    ldy #&19
    lda #osword_envelope
    jsr osword                          ; ENVELOPE command
    ldx #&3a ; ':'
    ldy #&19
    lda #osword_sound
    jsr osword                          ; SOUND command
    rts
; &74b6 referenced 1 time by &7479
.code_74b6
    sta scratch
    lda #&ff
    sta object_x,y
    sta object_y,y
    txa
    pha
    lda scratch
    and #7
    asl a
    asl a
    jsr play_pickup_sound
    pla
    tax
    lda hero_score_units,x
    sta scratch2
    jsr add_ten_points
    lda scratch
    cmp #&5f ; '_'
    bne code_74eb
    jsr point_at_boots_icon
    jsr plot_boots_icon
    lda #1
    sta hero_has_boots,x
    rts
; &74eb referenced 1 time by &74dd
.code_74eb
    cmp #&60 ; '`'
    bne code_74ff
    dec hero_damage_taken,x
    lda hero_damage_taken,x
    cmp #3
    bcs code_74fc
    inc hero_damage_taken,x
; &74fc referenced 1 time by &74f7
.code_74fc
    jmp code_75ae
; &74ff referenced 1 time by &74ed
.code_74ff
    cmp #&61 ; 'a'
    bne code_7516
    lda scratch2
    sta hero_health_tens,x
    inc scratch2
    lda scratch2
    sta hero_health_units,x
    jsr lose_health_point
    rts
; &7516 referenced 1 time by &7501
.code_7516
    cmp #&62 ; 'b'
    bne code_756b
    inc hero_max_missiles,x
    lda hero_max_missiles,x
    cmp #4
    bne code_7529
    lda #3
    sta hero_max_missiles,x
; &7529 referenced 1 time by &7522
.code_7529
    jmp code_75c5
; &752c referenced 2 times by &704d, &740a
.code_752c
    lda hero_x,x
    sta cell_x
    lda hero_y,x
    sta cell_y
    txa
    pha
    jsr test_wall
    pla
    tax
    pha
    asl a
    tay
    lda data_007b
    sta view_room,y
    cpx #0
    bne code_7551
    jsr draw_view_0
    pla
    tax
    rts
; &7551 referenced 1 time by &7549
.code_7551
    cpx #1
    bne code_755b
    jsr draw_view_1
    pla
    tax
    rts
; &755b referenced 1 time by &7553
.code_755b
    cpx #2
    bne code_7565
    jsr draw_view_2
    pla
    tax
    rts
; &7565 referenced 1 time by &755d
.code_7565
    jsr draw_view_3
    pla
    tax
    rts
; &756b referenced 1 time by &7518
.code_756b
    inc hero_missile_damage,x
    lda hero_missile_damage,x
    cmp #&0a
    bne code_75e2
    lda #9
    sta hero_missile_damage,x
    bne code_75e2
; &757c referenced 1 time by &714d
.code_757c
    txa
    pha
    tya
    pha
    ldx #&f0
    ldy #&0c
    lda #osword_sound
    jsr osword                          ; SOUND command
    pla
    tay
    pla
    tax
    lda monster_hit_points,x
    sec
    sbc missile_damage,y
    bpl code_75a6
    lda #&15
    sta monster_sprite,x
    lda monster_start_hit_points
    sta monster_hit_points,x
    tya
    tax
    jmp code_7150
; &75a6 referenced 1 time by &7594
.code_75a6
    sta monster_hit_points,x
    tya
    pha
    jmp code_7130
; &75ae referenced 1 time by &74fc
.code_75ae
    sec
    lda hero_panel_y,x
    sbc #&0c
    sta plot_y
    lda #&4e ; 'N'
    sta plot_x
    lda #&73 ; 's'
    sec
    sbc hero_damage_taken,x
    sta sprite_number
    jmp code_7611
; &75c5 referenced 1 time by &7529
.code_75c5
    lda hero_max_missiles,x
    asl a
    clc
    adc hero_max_missiles,x
    adc #&0d
    adc hero_panel_y,x
    sec
    sbc #&0e
    sta plot_y
    lda #&4b ; 'K'
    sta plot_x
    lda #&74 ; 't'
    sta sprite_number
    jmp code_7611
; &75e2 referenced 2 times by &7573, &757a
.code_75e2
    lda #&4c ; 'L'
    sta plot_x
    sec
    lda hero_panel_y,x
    sbc #4
    sta plot_y
    lda hero_missile_damage,x
    clc
    adc #&69 ; 'i'
    sta sprite_number
    jmp code_7611
; ***************************************************************************************
; Set the position of a hero's boots icon
;
; Set plot_x and plot_y to the place in hero X's panel section that shows the lightning
; bolt for Boots of Speed.
;
; On Entry:
;     X: hero number (0-3)
; &75f9 referenced 2 times by &7354, &74df
.point_at_boots_icon
    lda #&4a ; 'J'
    sta plot_x
    sec
    lda hero_panel_y,x
    sbc #8
    sta plot_y
    rts
; ***************************************************************************************
; Show a hero's boots icon
;
; Plot the lightning bolt at plot_x, plot_y.
;
; On Exit:
;     X: preserved
; &7606 referenced 1 time by &74e2
.plot_boots_icon
    lda #&75 ; 'u'
    sta sprite_number
    jmp code_7611
; ***************************************************************************************
; Remove a hero's boots icon
;
; Plot the blank sprite over the lightning bolt at plot_x, plot_y.
;
; On Exit:
;     X: preserved
; &760d referenced 1 time by &7357
.erase_boots_icon
    lda #&77 ; 'w'
    sta sprite_number
; &7611 referenced 4 times by &75c2, &75df, &75f6, &760a
.code_7611
    txa
    pha
    jsr plot_sprite
    pla
    tax
    rts
; &7619 referenced 1 time by &6ebe
.code_7619
    dec hero_magic_delay,x
    beq code_761f
    rts
; &761f referenced 1 time by &761c
.code_761f
    lda #1
    sta hero_magic_delay,x
    lda hero_magic_key,x
    jsr test_key
    bne code_76ab
    txa
    pha
    ldx #0
    ldy #&19
    lda #osword_envelope
    jsr osword                          ; ENVELOPE command
    ldx #&0e
    ldy #&19
    lda #osword_sound
    jsr osword                          ; SOUND command
    pla
    tax
    lda #4
    sta hero_magic_delay,x
    cpx #1
    beq code_7650
    ldy #6
    jmp code_7652
; &7650 referenced 1 time by &7649
.code_7650
    ldy #3
; &7652 referenced 2 times by &764d, &765a
.code_7652
    tya
    pha
    jsr lose_health_point
    pla
    tay
    dey
    bne code_7652
    lda #0
    sta magic_kill_count
    txa
    asl a
    sta sprite_number
    ldx #&1e
; &7667 referenced 1 time by &7693
.loop_7667
    lda monster_x,x
    sta cell_x
    lda monster_y,x
    sta cell_y
    txa
    pha
    jsr test_wall
    pla
    tax
    ldy sprite_number
    lda view_room,y
    cmp data_007b
    bne code_7692
    lda monster_sprite,x
    cmp #&15
    bcs code_7692
    lda #&15
    sta monster_sprite,x
    inc magic_kill_count
; &7692 referenced 2 times by &7681, &7688
.code_7692
    dex
    bne loop_7667
    lda sprite_number
    lsr a
    tax
    ldy magic_kill_count
; &769c referenced 1 time by &76a8
.code_769c
    cpy #0
    beq code_76ae
    tya
    pha
    jsr add_point
    pla
    tay
    dey
    jmp code_769c
; &76ab referenced 1 time by &762a
.code_76ab
    jmp code_6ec1
; &76ae referenced 1 time by &769e
.code_76ae
    jmp code_7096
; ***************************************************************************************
; Give a point to the hero who fired a missile
;
; On Entry:
;     X: missile slot
;
; On Exit:
;     X: preserved
; &76b1 referenced 2 times by &7150, &71a2
.credit_missile_owner
    ldy missile_sprite_base,x
    txa
    pha
    tya
    cmp #&10
    bne code_76c0
    ldx #0
    jmp code_76d4
; &76c0 referenced 1 time by &76b9
.code_76c0
    cmp #&44 ; 'D'
    bne code_76c9
    ldx #1
    jmp code_76d4
; &76c9 referenced 1 time by &76c2
.code_76c9
    cmp #&4c ; 'L'
    bne code_76d2
    ldx #2
    jmp code_76d4
; &76d2 referenced 1 time by &76cb
.code_76d2
    ldx #3
; &76d4 referenced 3 times by &76bd, &76c6, &76cf
.code_76d4
    jsr add_point
    pla
    tax
    rts
; ***************************************************************************************
; Animate a hero who is out of play
;
; Every other frame, step hero_frame by hero_offset_x through hero_appearance_sprites and
; plot the sprite at the hero's cell: forwards (+1) for a hero dying, stopping at the
; skull; backwards (-1) for a hero returning through a Cross of Resurrection. When a
; returning hero reaches the first sprite, put them in play facing down with health 32
; (set to 33 and drawn by taking a point).
;
; On Entry:
;     X: hero number (0-3)
; &76da referenced 1 time by &6e91
.animate_absent_hero
    dec hero_offset_y,x
    beq code_76e0
    rts
; &76e0 referenced 1 time by &76dd
.code_76e0
    lda #2
    sta hero_offset_y,x
    jsr get_hero_cell
    lda #0
    sta data_007d
    sta data_007e
    lda hero_frame,x
    tay
    lda hero_appearance_sprites,y
    sta sprite_number
    txa
    pha
    jsr plot_at_cell
    pla
    tax
    clc
    lda hero_frame,x
    adc hero_offset_x,x
    cmp #9
    bcc code_770b
    lda #8
; &770b referenced 1 time by &7707
.code_770b
    cmp #0
    bne code_772e
    lda #5
    sta hero_direction,x
    lda #0
    sta hero_step,x
    sta hero_offset_x,x
    sta hero_offset_y,x
    sta hero_frame,x
    lda #&21 ; '!'
    sta hero_health_tens,x
    sta hero_health_units,x
    jsr lose_health_point
    rts
; &772e referenced 1 time by &770d
.code_772e
    sta hero_frame,x
    rts
; ***************************************************************************************
; Draw a hero
;
; Plot sprite_number at hero X's cell and pixel offset in every view that shows it.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &7732 referenced 2 times by &70a4, &7244
.draw_hero
    jsr get_hero_cell                   ; Hero's cell
    lda hero_offset_x,x                 ; ...and pixel offsets
    sta data_007d                       ; ...
    lda hero_offset_y,x                 ; ...
    sta data_007e                       ; ...
    txa                                 ; Plot in every view showing it, preserving X
    pha                                 ; ...
    jsr plot_at_cell                    ; ...
    pla                                 ; ...
    tax                                 ; ...
    rts                                 ; Return
; ***************************************************************************************
; Animate the hero who fired a missile
;
; Toggle the animation frame of the hero whose missile is in slot X.
;
; On Entry:
;     X: missile slot
; &7747 referenced 1 time by &70e1
.flip_firer_frame
    lda missile_sprite_base,x
    cmp #&10
    bne code_7757
    lda hero_frame
    eor #1
    sta hero_frame
    rts
; &7757 referenced 1 time by &774c
.code_7757
    cmp #&44 ; 'D'
    bne code_7764
    lda data_0d21
    eor #1
    sta data_0d21
    rts
; &7764 referenced 1 time by &7759
.code_7764
    cmp #&4c ; 'L'
    bne code_7771
    lda data_0d22
    eor #1
    sta data_0d22
    rts
; &7771 referenced 1 time by &7766
.code_7771
    lda data_0d23
    eor #1
    sta data_0d23
    rts
; ***************************************************************************************
; Copy a hero's position to cell_x, cell_y
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &777a referenced 2 times by &76e5, &7732
.get_hero_cell
    lda hero_x,x                        ; cell_x = hero_x
    sta cell_x                          ; ...
    lda hero_y,x                        ; cell_y = hero_y
    sta cell_y                          ; ...
    rts                                 ; Return
    equb &73
; ***************************************************************************************
; Draw all four views
;
; Draw the room each hero's view shows.
; &7788 referenced 1 time by &1502
.draw_all_views
    jsr draw_view_0
    jsr draw_view_1
    jsr draw_view_2
    jsr draw_view_3
    rts
; ***************************************************************************************
; Draw the top-left view
;
; Draw the room in hero 0's view.
; &7795 referenced 2 times by &754b, &7788
.draw_view_0
    lda #1                              ; Top-left view: row 1...
    sta plot_y                          ; ...
    lda #1                              ; ...column 1...
    sta cell_x                          ; ...
    lda view_room                       ; ...hero 0's room
    sta data_007b                       ; ...
    jsr draw_room                       ; Draw it
    rts                                 ; Return
; ***************************************************************************************
; Draw the top-right view
;
; Draw the room in hero 1's view.
; &77a7 referenced 2 times by &7555, &778b
.draw_view_1
    lda #1                              ; Top-right view: row 1...
    sta plot_y
    lda #&23 ; '#'                      ; ...column &23...
    sta cell_x
    lda data_0da2                       ; ...hero 1's room
    sta data_007b
    jsr draw_room                       ; Draw it
    rts                                 ; Return
; ***************************************************************************************
; Draw the bottom-left view
;
; Draw the room in hero 2's view.
; &77b9 referenced 2 times by &755f, &778e
.draw_view_2
    lda #&67 ; 'g'                      ; Bottom-left view: row &67...
    sta plot_y
    lda #1                              ; ...column 1...
    sta cell_x
    lda data_0da4                       ; ...hero 2's room
    sta data_007b
    jsr draw_room                       ; Draw it
    rts                                 ; Return
; ***************************************************************************************
; Draw the bottom-right view
;
; Draw the room in hero 3's view.
; &77cb referenced 2 times by &7565, &7791
.draw_view_3
    lda #&67 ; 'g'                      ; Bottom-right view: row &67...
    sta plot_y
    lda #&23 ; '#'                      ; ...column &23...
    sta cell_x
    lda data_0da6                       ; ...hero 3's room
    sta data_007b
    jsr draw_room                       ; Draw it
    rts                                 ; Return
    equb &60
; ***************************************************************************************
; Draw a room
;
; Draw the eight rows of walls of the room at &7B, &7C (a pointer into room_walls) with
; its top-left at plot_y and the column in cell_x, then draw the doors.
; &77de referenced 4 times by &77a3, &77b5, &77c7, &77d9
.draw_room
    lda #&0c                            ; The room's walls are in page &0C
    sta data_007c                       ; ...
    ldy #0                              ; For each of the eight rows...
; &77e4 referenced 1 time by &77fa
.loop_77e4
    lda (data_007b),y                   ; ...take its eight wall bits...
    sta scratch                         ; ...
    tya                                 ; ...
    pha                                 ; ...
    jsr draw_room_row                   ; ...and draw them
    clc                                 ; Twelve pixel rows down
    lda plot_y                          ; ...
    adc #&0c                            ; ...
    sta plot_y                          ; ...
    pla                                 ; ...
    tay                                 ; ...
    iny                                 ; ...
    cpy #8                              ; ...
    bne loop_77e4                       ; ...
    ldx #&14                            ; Then the doors 20 to 1, in every view showing them
; &77fe referenced 1 time by &781d
.loop_77fe
    lda door_x,x
    sta cell_x
    lda door_y,x
    sta cell_y
    lda #0
    sta data_007d
    sta data_007e
    lda door_sprite,x
    sta sprite_number
    txa
    pha
    jsr plot_at_cell
    pla
    tax
    dex                                 ; ...
    bne loop_77fe                       ; ...
    rts                                 ; Return
; ***************************************************************************************
; Draw one row of a room
;
; Plot a wall or a blank for each of the eight bits of scratch, four byte columns apart,
; starting at byte column cell_x.
; &7820 referenced 1 time by &77eb
.draw_room_row
    lda cell_x                          ; Start at the room's left edge
    sta plot_x                          ; ...
    ldx #&80                            ; Bit mask, starting with the leftmost cell
; &7827 referenced 1 time by &784f
.loop_7827
    txa                                 ; ...
    pha                                 ; ...
    sta scratch2                        ; ...
    lda scratch                         ; Wall here?
    and scratch2                        ; ...
    beq code_783e                       ; No: plot the blank
    lda #0                              ; Yes: plot the wall block (sprite 0)
    sta sprite_number                   ; ...
    jsr plot_sprite                     ; ...
    jmp code_7845                       ; ...
; &783e referenced 1 time by &7832
.code_783e
    lda #&15                            ; Plot the blank (sprite &15)
    sta sprite_number                   ; ...
    jsr plot_sprite                     ; ...
; &7845 referenced 1 time by &783b
.code_7845
    clc                                 ; Four byte columns right
    lda plot_x                          ; ...
    adc #4                              ; ...
    sta plot_x                          ; ...
    pla                                 ; Next bit...
    lsr a                               ; ...
    tax                                 ; ...
    bne loop_7827                       ; ...until all eight are done
    rts                                 ; Return
; ***************************************************************************************
; Plot a sprite at a map cell in every view
;
; Plot sprite_number at map cell cell_x, cell_y, shifted by the pixel offsets in &7D,
; &7E, in each view that shows the cell's room. Cells are four byte columns wide and
; twelve pixel rows high.
;
; On Entry:
;     CELL_X: map x
;     CELL_Y: map y
;     SPRITE_NUMBER: sprite to plot
; &7852 referenced 19 times by &11a8, &1200, &1d36, &1ddc, &1e61, &1f6d, &1fb7, &1fec, &7091, &70f9, &7213, &7320, &76f9, &7741, &7817, &79db, &7a07, &7b25, &7b5c
.plot_at_cell
    lda cell_y                          ; Room = (cell_y AND &F8) x 4 + (cell_x AND &F8)...
    and #&f8                            ; ...
    sta scratch                         ; ...
    clc                                 ; ...
    adc scratch                         ; ...
    adc scratch                         ; ...
    adc scratch                         ; ...
    sta cell_room                       ; ...
    lda cell_x                          ; ...
    and #&f8                            ; ...
    adc cell_room                       ; ...
    sta cell_room                       ; ...in cell_room
    lda cell_x                          ; Column within the view = (cell_x AND 7) x 4 + offset_x
    and #7                              ; ...
    asl a                               ; ...
    asl a                               ; ...
    clc                                 ; ...
    adc data_007d                       ; ...
    sta cell_x                          ; ...
    lda cell_y                          ; Row within the view = (cell_y AND 7) x 12 + offset_y
    and #7                              ; ...
    asl a                               ; ...
    asl a                               ; ...
    sta scratch                         ; ...
    asl a                               ; ...
    clc                                 ; ...
    adc scratch                         ; ...
    adc data_007e                       ; ...
    sta cell_y                          ; ...
    lda view_room                       ; Does the top-left view show this room?
    cmp cell_room                       ; ...
    bne code_78ad                       ; No
    clc                                 ; Yes: plot at column 1, row 1 of the screen, plus the position in the room
    lda #1                              ; ...
    adc cell_x                          ; ...
    sta plot_x                          ; ...
    lda #1                              ; ...
    adc cell_y                          ; ...
    sta plot_y                          ; ...
    jsr plot_sprite                     ; ...
; &78ad referenced 1 time by &7899
.code_78ad
    lda data_0da2                       ; Does the top-right view show it?
    cmp cell_room                       ; ...
    bne code_78c7                       ; No
    clc                                 ; Yes: plot at column &23, row 1
    lda #&23 ; '#'
    adc cell_x
    sta plot_x
    lda #1
    adc cell_y
    sta plot_y
    jsr plot_sprite
; &78c7 referenced 1 time by &78b3
.code_78c7
    lda data_0da4                       ; Does the bottom-left view show it?
    cmp cell_room                       ; ...
    bne code_78e1                       ; No
    clc                                 ; Yes: plot at column 1, row &67
    lda #1
    adc cell_x
    sta plot_x
    lda #&67 ; 'g'
    adc cell_y
    sta plot_y
    jsr plot_sprite
; &78e1 referenced 1 time by &78cd
.code_78e1
    lda data_0da6                       ; Does the bottom-right view show it?
    cmp cell_room                       ; ...
    bne return_12                       ; No
    clc                                 ; Yes: plot at column &23, row &67
    lda #&23 ; '#'
    adc cell_x
    sta plot_x
    lda #&67 ; 'g'
    adc cell_y
    sta plot_y
    jsr plot_sprite
; &78fb referenced 1 time by &78e7
.return_12
    rts                                 ; Return
; ***************************************************************************************
; Test for a wall at a map cell
;
; Return the room_walls bit for cell cell_x, cell_y: non-zero if there is a wall. Also
; leaves &7B, &7C pointing at the cell's room.
;
; On Exit:
;     A: wall bit
;     Y: wall bit
;     Z: set if no wall
; &78fc referenced 8 times by &20d3, &20e1, &20ef, &6fb2, &712b, &753a, &7675, &7a51
.test_wall
    lda cell_y                          ; Room offset = (cell_y AND &F8) x 4 + (cell_x AND &F8)...
    and #&f8
    sta scratch
    clc
    adc scratch
    adc scratch
    adc scratch
    sta data_007b                       ; ...low byte of the pointer
    lda cell_x
    and #&f8
    adc data_007b
    sta data_007b
    lda #&0c                            ; ...into room_walls at &0C00
    sta data_007c                       ; ...
    lda cell_x                          ; Bit for the column within the room
    and #7                              ; ...
    tax                                 ; ...
    lda bit_masks,x                     ; ...
    sta scratch                         ; ...
    lda cell_y                          ; Byte for the row within the room
    and #7                              ; ...
    tay                                 ; ...
    lda (data_007b),y                   ; Isolate the cell's bit...
    and scratch                         ; ...
    sta data_008f                       ; ...keep it in &8F...
    tay                                 ; ...and Y
    rts                                 ; Return
; ***************************************************************************************
; Test whether a map cell can hold an object
;
; Return the object_free_map bit for cell cell_x, cell_y: zero if an object may lie
; there.
;
; On Exit:
;     A: map bit
;     Y: map bit
;     Z: set if an object may lie there
; &7938 referenced 2 times by &70b5, &7166
.test_object_free
    lda cell_y                          ; Room offset = (cell_y AND &F8) x 4 + (cell_x AND &F8)...
    and #&f8
    sta scratch
    clc
    adc scratch
    adc scratch
    adc scratch
    sta data_007b                       ; ...low byte of the pointer
    lda cell_x
    and #&f8
    adc data_007b
    sta data_007b
    lda #&21 ; '!'                      ; ...into object_free_map at &2100
    sta data_007c                       ; ...
    lda cell_x                          ; Bit for the column within the room
    and #7
    tax
    lda bit_masks,x
    sta scratch
    lda cell_y                          ; Byte for the row within the room
    and #7
    tay
    lda (data_007b),y                   ; Isolate the cell's bit...
    and scratch
    sta data_008f                       ; ...keep it in &8F...
    tay                                 ; ...and Y
    rts                                 ; Return
; ***************************************************************************************
; Look for a monster or hero at a cell
;
; Look for a monster, other than monster number scratch, at cell_x, cell_y. If scratch is
; non-zero, also look for a hero there, and if one is found take hero_damage_taken points
; of their health.
;
; On Exit:
;     A: non-zero if something was found
;     Y: non-zero if a monster was found
; &7974 referenced 4 times by &6fdc, &713f, &7a8c, &7ce6
.find_creature
    ldx #&1e                            ; Monsters 30 to 1...
; &7976 referenced 1 time by &798e
.loop_7976
    cpx scratch                         ; ...except the one being moved
    beq code_798d                       ; ...
    lda cell_x                          ; At cell_x...
    cmp monster_x,x                     ; ...
    bne code_798d                       ; ...
    lda cell_y                          ; ...and cell_y?
    cmp monster_y,x                     ; ...
    bne code_798d                       ; ...
    tay                                 ; Yes: return with Y and A non-zero
    rts                                 ; ...
; &798d referenced 3 times by &7979, &7981, &7989
.code_798d
    dex                                 ; Next monster
    bne loop_7976                       ; ...
    lda scratch                         ; No monster. Check for heroes too?
    beq code_79bc                       ; No: return 0
    ldx #0                              ; For each hero...
; &7997 referenced 1 time by &79ba
.loop_7997
    lda cell_x                          ; ...at cell_x...
    cmp hero_x,x                        ; ...
    bne code_79b7                       ; ...
    lda cell_y                          ; ...and cell_y?
    cmp hero_y,x                        ; ...
    bne code_79b7                       ; ...
    ldy hero_damage_taken,x             ; Yes: take hero_damage_taken health points
; &79aa referenced 1 time by &79b2
.loop_79aa
    tya                                 ; ...
    pha                                 ; ...
    jsr lose_health_point               ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    bne loop_79aa                       ; ...
    lda #1                              ; Return A = 1: a hero was there
    rts                                 ; ...
; &79b7 referenced 2 times by &799d, &79a5
.code_79b7
    inx                                 ; Next hero
    cpx #4                              ; ...
    bne loop_7997                       ; ...
; &79bc referenced 1 time by &7993
.code_79bc
    lda #0                              ; Nothing there: return A = Y = 0
    ldy #0                              ; ...
    rts                                 ; ...
; ***************************************************************************************
; Draw the trapdoors and move the monsters
;
; Draw the eight trapdoors, then for each monster continue its step or start a new one,
; turning a random way when it is blocked, and advance dying monsters until they reappear
; at a trapdoor.
; &79c1 referenced 1 time by &1ed4
.update_monsters
    ldx #8
    lda #0
    sta data_007d
    sta data_007e
    lda #&2c ; ','
    sta sprite_number
; &79cd referenced 1 time by &79e1
.loop_79cd
    lda data_0b8f,x
    sta cell_x
    lda data_0b97,x
    sta cell_y
    txa
    pha
    jsr plot_at_cell
    pla
    tax
    dex
    bne loop_79cd
    ldx #&1e
; &79e5 referenced 1 time by &7b2d
.code_79e5
    txa
    pha
    lda monster_x,x
    sta cell_x
    sta previous_x
    lda monster_y,x
    sta cell_y
    sta previous_y
    lda #&15
    sta sprite_number
    lda monster_offset_x,x
    sta data_007d
    lda monster_offset_y,x
    sta data_007e
    jsr plot_at_cell
    pla
    pha
    tax
    lda monster_sprite,x
    cmp #&15
    bcc code_7a17
    jmp code_7b31
; &7a17 referenced 1 time by &7a12
.code_7a17
    lda monster_step,x
    beq code_7a23
    jsr continue_monster_step
    pla
    jmp code_7b04
; &7a23 referenced 1 time by &7a1a
.code_7a23
    lda monster_sprite,x
    cmp #9
    bne code_7a2d
    dec monster_y,x
; &7a2d referenced 1 time by &7a28
.code_7a2d
    cmp #&0b
    bne code_7a34
    inc monster_x,x
; &7a34 referenced 1 time by &7a2f
.code_7a34
    cmp #&0d
    bne code_7a3b
    inc monster_y,x
; &7a3b referenced 1 time by &7a36
.code_7a3b
    cmp #&0f
    bne code_7a42
    dec monster_x,x
; &7a42 referenced 1 time by &7a3d
.code_7a42
    jsr start_monster_step
    lda monster_x,x
    sta cell_x
    lda monster_y,x
    sta cell_y
    jsr test_wall
    beq code_7a87
    pla
    tax
    lda previous_x
    sta monster_x,x
    lda previous_y
    sta monster_y,x
    lda #0
    sta monster_step,x
    sta monster_offset_x,x
    sta monster_offset_y,x
    lda system_via_t1c_l
    and #7
    clc
    adc #8
    sta monster_sprite,x
    and #1
    beq code_7a81
    jmp code_7b04
; &7a81 referenced 1 time by &7a7c
.code_7a81
    inc monster_sprite,x
    jmp code_7b04
; &7a87 referenced 1 time by &7a54
.code_7a87
    pla
    pha
    sta scratch
    jsr find_creature
    cmp #0
    beq code_7ac1
    pla
    tax
    lda previous_x
    sta monster_x,x
    lda previous_y
    sta monster_y,x
    lda #0
    sta monster_step,x
    sta monster_offset_x,x
    sta monster_offset_y,x
    lda system_via_t1c_l
    and #7
    clc
    adc #8
    sta monster_sprite,x
    and #1
    bne code_7b04
    inc monster_sprite,x
    jmp code_7b04
; &7ac1 referenced 1 time by &7a91
.code_7ac1
    pla
    tax
    lda monster_sprite,x
    cmp #9
    beq code_7adc
    cmp #&0d
    beq code_7adc
    lda monster_x,x
    and #7
    beq code_7aea
    cmp #7
    beq code_7aea
    jmp code_7af8
; &7adc referenced 2 times by &7ac8, &7acc
.code_7adc
    lda monster_y,x
    and #7
    beq code_7aea
    cmp #7
    beq code_7aea
    jmp code_7af8
; &7aea referenced 4 times by &7ad3, &7ad7, &7ae1, &7ae5
.code_7aea
    lda #0
    sta monster_step,x
    sta monster_offset_x,x
    sta monster_offset_y,x
    jmp code_7b04
; &7af8 referenced 2 times by &7ad9, &7ae7
.code_7af8
    lda previous_x
    sta monster_x,x
    lda previous_y
    sta monster_y,x
; &7b04 referenced 6 times by &7a20, &7a7e, &7a84, &7ab9, &7abe, &7af5
.code_7b04
    lda monster_x,x
    sta cell_x
    lda monster_y,x
    sta cell_y
    clc
    lda monster_sprite,x
    adc monster_frame,x
    sta sprite_number
    lda monster_offset_x,x
    sta data_007d
    lda monster_offset_y,x
    sta data_007e
    txa
    pha
    jsr plot_at_cell
; &7b28 referenced 3 times by &7b5f, &7cf8, &7cfb
.code_7b28
    pla
    tax
    dex
    beq return_13
    jmp code_79e5
; &7b30 referenced 1 time by &7b2b
.return_13
    rts
; &7b31 referenced 1 time by &7a14
.code_7b31
    pla
    inc monster_sprite,x
    lda monster_sprite,x
    cmp #&1a
    bne code_7b3f
    jmp code_7cb3
; &7b3f referenced 1 time by &7b3a
.code_7b3f
    txa
    pha
    lda monster_x,x
    sta cell_x
    lda monster_y,x
    sta cell_y
    lda monster_sprite,x
    sta sprite_number
    lda monster_offset_x,x
    sta data_007d
    lda monster_offset_y,x
    sta data_007e
    jsr plot_at_cell
    jmp code_7b28
; ***************************************************************************************
; Start a hero's step between cells
;
; Set hero X's step counter to 1 and their pixel offsets for the direction they face: 6
; rows up or down, or 2 byte columns left or right.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &7b62 referenced 4 times by &6ece, &6ee1, &6ef4, &6f07
.start_hero_step
    lda #1
    sta hero_step,x
    lda hero_direction,x
    cmp #1
    bne code_7b79
    lda #0
    sta hero_offset_x,x
    lda #&fa
    sta hero_offset_y,x
    rts
; &7b79 referenced 1 time by &7b6c
.code_7b79
    cmp #3
    bne code_7b88
    lda #0
    sta hero_offset_y,x
    lda #2
    sta hero_offset_x,x
    rts
; &7b88 referenced 1 time by &7b7b
.code_7b88
    cmp #5
    bne code_7b97
    lda #0
    sta hero_offset_x,x
    lda #6
    sta hero_offset_y,x
    rts
; &7b97 referenced 1 time by &7b8a
.code_7b97
    lda #0
    sta hero_offset_y,x
    lda #&fe
    sta hero_offset_x,x
    rts
; ***************************************************************************************
; Continue a hero's step between cells
;
; Toggle hero X's animation frame and count down their step. When it ends, move the hero
; one cell in the direction they face and clear the pixel offsets. The offsets are then
; doubled.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &7ba2 referenced 1 time by &6eb4
.continue_hero_step
    lda hero_frame,x
    eor #1
    sta hero_frame,x
    dec hero_step,x
    bne code_7bd6
    lda hero_direction,x
    cmp #1
    bne code_7bb9
    dec hero_y,x
; &7bb9 referenced 1 time by &7bb4
.code_7bb9
    cmp #3
    bne code_7bc0
    inc hero_x,x
; &7bc0 referenced 1 time by &7bbb
.code_7bc0
    cmp #5
    bne code_7bc7
    inc hero_y,x
; &7bc7 referenced 1 time by &7bc2
.code_7bc7
    cmp #7
    bne code_7bce
    dec hero_x,x
; &7bce referenced 1 time by &7bc9
.code_7bce
    lda #0
    sta hero_offset_x,x
    sta hero_offset_y,x
; &7bd6 referenced 1 time by &7bad
.code_7bd6
    clc
    lda hero_offset_x,x
    adc hero_offset_x,x
    sta hero_offset_x,x
    clc
    lda hero_offset_y,x
    adc hero_offset_y,x
    sta hero_offset_y,x
    rts
; ***************************************************************************************
; Start a monster's step between cells
;
; Set the step counter and the pixel offsets for monster X's direction.
;
; On Entry:
;     X: monster number
; &7beb referenced 1 time by &7a42
.start_monster_step
    lda #3
    sta monster_step,x
    lda monster_sprite,x
    cmp #9
    bne code_7c02
    lda #0
    sta monster_offset_x,x
    lda #&fd
    sta monster_offset_y,x
    rts
; &7c02 referenced 1 time by &7bf5
.code_7c02
    cmp #&0b
    bne code_7c11
    lda #0
    sta monster_offset_y,x
    lda #1
    sta monster_offset_x,x
    rts
; &7c11 referenced 1 time by &7c04
.code_7c11
    cmp #&0d
    bne code_7c20
    lda #0
    sta monster_offset_x,x
    lda #3
    sta monster_offset_y,x
    rts
; &7c20 referenced 1 time by &7c13
.code_7c20
    lda #0
    sta monster_offset_y,x
    lda #&ff
    sta monster_offset_x,x
    rts
; ***************************************************************************************
; Continue a monster's step between cells
;
; Toggle monster X's frame and move its pixel offsets towards zero, moving it to the next
; cell when the step ends.
;
; On Entry:
;     X: monster number
; &7c2b referenced 1 time by &7a1c
.continue_monster_step
    lda monster_frame,x
    eor #1
    sta monster_frame,x
    dec monster_step,x
    bne code_7c5f
    lda monster_sprite,x
    cmp #9
    bne code_7c42
    dec monster_y,x
; &7c42 referenced 1 time by &7c3d
.code_7c42
    cmp #&0b
    bne code_7c49
    inc monster_x,x
; &7c49 referenced 1 time by &7c44
.code_7c49
    cmp #&0d
    bne code_7c50
    inc monster_y,x
; &7c50 referenced 1 time by &7c4b
.code_7c50
    cmp #&0f
    bne code_7c57
    dec monster_x,x
; &7c57 referenced 1 time by &7c52
.code_7c57
    lda #0
    sta monster_offset_x,x
    sta monster_offset_y,x
; &7c5f referenced 1 time by &7c36
.code_7c5f
    lda monster_offset_x,x
    beq code_7c6f
    bpl code_7c6c
    dec monster_offset_x,x
    jmp code_7c6f
; &7c6c referenced 1 time by &7c64
.code_7c6c
    inc monster_offset_x,x
; &7c6f referenced 2 times by &7c62, &7c69
.code_7c6f
    lda monster_offset_y,x
    beq return_14
    bpl code_7c82
    sec
    lda monster_offset_y,x
    sbc #3
    sta monster_offset_y,x
    jmp return_14
; &7c82 referenced 1 time by &7c74
.code_7c82
    clc
    lda monster_offset_y,x
    adc #3
    sta monster_offset_y,x
; &7c8b referenced 2 times by &7c72, &7c7f
.return_14
    rts
    equb &de, &35, &0d, &bd, &35, &0d, &d0, &00
    equb &60
; ***************************************************************************************
; Test whether a key is pressed
;
; Scan the key whose INKEY number is in A with OSBYTE &81.
;
; On Entry:
;     A: INKEY key number (negative, as a byte)
;
; On Exit:
;     A: 0 if the key is pressed, 1 if not
;     Z: set if the key is pressed
;     X: preserved
; &7c95 referenced 6 times by &6ec4, &6ed7, &6eea, &6efd, &6f10, &7627
.test_key
    tay                                 ; Key number to X, keeping X on the stack
    txa                                 ; ...
    pha                                 ; ...
    tya                                 ; ...
    tax                                 ; ...
    lda #osbyte_inkey                   ; OSBYTE &81 with Y = &FF: scan the key
    ldy #&ff                            ; ...
    jsr osbyte                          ; ...  INKEY: Scan for a key with positive X, or read internal key number EOR 128 for negative X
    cpy #&ff                            ; X = Y = &FF if it is pressed
    bne code_7cae                       ; ...
    cpx #&ff                            ; ...
    bne code_7cae                       ; ...
    pla                                 ; Pressed: restore X and return A = 0, Z set
    tax                                 ; ...
    lda #0                              ; ...
    rts                                 ; ...
; &7cae referenced 2 times by &7ca3, &7ca7
.code_7cae
    pla                                 ; Not pressed: restore X and return A = 1
    tax                                 ; ...
    lda #1                              ; ...
    rts                                 ; ...
; &7cb3 referenced 1 time by &7b3c
.code_7cb3
    inc next_trapdoor
    lda next_trapdoor
    cmp #8
    bne code_7cc2
    lda #0
    sta next_trapdoor
; &7cc2 referenced 1 time by &7cbb
.code_7cc2
    ldy next_trapdoor
    lda trapdoor_x,y
    sta monster_x,x
    lda trapdoor_y,y
    sta monster_y,x
    lda #9
    sta monster_sprite,x
    lda #0
    sta monster_step,x
    sta monster_offset_x,x
    sta monster_offset_y,x
    txa
    pha
    stx scratch
    jsr find_creature
    cmp #0
    beq code_7cfb
    pla
    pha
    tax
    lda #&ff
    sta monster_x,x
    sta monster_y,x
    jmp code_7b28
; &7cfb referenced 1 time by &7ceb
.code_7cfb
    jmp code_7b28
    equb &00
; &7cff referenced 3 times by &0e1b, &158f, &759b
.monster_start_hit_points
    equb &08
; &7d00 used as index base 1 time by &14a2
.workspace_template
    equb &00, &00, &1f, &1f, &d2, &d2, &cc, &b1
    equb &07, &07, &01, &01, &00
    equs ",4<"
    equb &0b, &0b, &0c, &0c, &2f, &0b, &0c, &0b
    equb &0c, &26, &01, &03, &05, &07, &2d, &2f
    equb &01, &01, &01, &01, &5d, &00, &00, &00
    equb &00, &16, &00, &00, &00, &00, &1d, &1f
    equb &00, &00, &00, &00, &03, &05, &07, &05
    equb &07
    equs "657<>=?"
    equb &01, &82, &81, &83, &88, &8a, &89, &8b
    equb &84, &86, &85, &87, &8c, &8e, &8d, &8f
    equb &08, &48, &8a, &48, &98, &48, &ae, &ff
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &15, &85, &7a, &8a
    equb &48, &20, &00, &09, &68, &aa, &bd, &08
    equb &bf, &86, &b9, &ac, &af, &c6, &99, &9b
    equb &9e, &96, &97, &da, &ff, &a6, &98, &ca
    equb &9f, &d6, &9d, &c9, &0d, &c9, &05, &d0
    equb &09, &18, &bd, &04, &0d, &69, &03, &9d
    equs "''''"
    equb &d0
    equs "(((("
    equb &18, &bd, &08, &0d, &6d, &40, &0d, &28
    equb &0c, &28, &0c, &28, &0c, &28, &0c, &00
    equb &00, &bd, &04, &0d, &85, &71, &8a, &10
    equs "DLHh"
    equb &00
    equs ",4<"
.sub_7db9
; &7dd0 used as index base 2 times by &0424, &0f71
data_7dd0 = sub_7db9+23
    equb &00, &0d, &d9, &00, &00, &00, &00, &80
    equb &40, &20, &10, &08, &04, &02, &01, &b9
    equb &30, &0d, &9d, &08, &0d, &4c, &d4, &18
    equb &46, &74, &a2, &e8, &e0, &04, &d0, &0a
    equb &a2, &00, &ad, &40, &0d, &49, &01, &8d
    equb &40, &0d, &8e, &ff, &0d, &68, &a8, &68
    equb &aa
    equs "h(`"
    equb &de, &dd, &df, &f0, &f2, &f1, &f3, &f8
    equb &fa, &f9, &fb, &f4, &f6, &f5, &f7, &fc
    equb &1e, &fd, &00
; &7e00 used as index base 17 times by &158c, &7667, &797e, &79e7, &7a31, &7a3f, &7a45, &7a5b, &7a98, &7ace, &7afb, &7b04, &7b41, &7c46, &7c54, &7cc8, &7cf2
.monster_x
; &7e23 referenced 2 times by &1d29, &1d39
data_7e23 = monster_x+35
    equb &00, &04, &0b, &09, &1d, &08, &01, &06
    equb &07, &0a, &01, &0b, &1a, &06, &0b, &16
    equb &15, &0d, &1b, &14, &1a, &09, &1c, &0f
    equb &1e, &02, &1a, &0b, &1c, &0e, &16, &00
    equb &00, &00, &00, &1a, &00, &00, &00, &00
    equb &00
; &7e29 used as index base 16 times by &766d, &7986, &79f0, &7a2a, &7a38, &7a4b, &7a61, &7a9e, &7adc, &7b01, &7b0a, &7b47, &7c3f, &7c4d, &7cce, &7cf5
.monster_y
    equb &00, &24, &17
    equs "% $", &22
.sub_7e30
; &7e4c referenced 2 times by &1d23, &1d3f
data_7e4c = sub_7e30+28
    equb &14, &27, &0d, &20, &01, &26, &0a, &01
    equb &12, &05, &20, &29, &0d, &26, &27, &08
    equb &06, &1a, &14, &03, &1d, &07, &0d, &17
    equb &00, &00, &00, &00, &1b, &00, &00, &00
    equb &00, &00
; &7e52 used as index base 19 times by &1587, &7144, &7598, &7683, &768c, &7a0d, &7a23, &7a77, &7a81, &7ab4, &7abb, &7ac3, &7b11, &7b32, &7b35, &7b4d, &7bf0, &7c38, &7cd3
.monster_sprite
    equb &00, &09, &0d, &0b, &0b, &0b, &09, &0f
    equb &0f, &0b, &0d, &0b, &0b, &0f, &0d, &0d
    equb &09, &0f, &0b, &0f, &0b, &0b, &0f, &09
    equb &0d, &0f, &0b, &09, &0d, &0b, &09, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00
; &7e7b used as index base 3 times by &7b14, &7c2b, &7c30
.monster_frame
    equb &00, &00, &01, &00, &00, &01, &01, &00
    equb &01, &01, &00, &01, &01, &01, &00, &01
    equb &00, &01, &00, &01, &01, &00, &00, &01
    equb &01, &00, &00, &00, &01, &01, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00
; &7ea4 used as index base 15 times by &79fd, &7a69, &7aa6, &7aef, &7b19, &7b52, &7bf9, &7c0d, &7c17, &7c27, &7c59, &7c5f, &7c66, &7c6c, &7cdb
.monster_offset_x
    equb &00, &00, &00, &02, &02, &02, &00, &fd
    equb &fe, &01, &00, &02, &03, &00, &00, &00
    equb &00, &fe, &00, &00, &01, &00, &00, &00
    equb &00, &00, &03, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00
; &7ecd used as index base 17 times by &7a02, &7a6c, &7aa9, &7af2, &7b1e, &7b57, &7bfe, &7c08, &7c1c, &7c22, &7c5c, &7c6f, &7c77, &7c7c, &7c83, &7c88, &7cde
.monster_offset_y
    equb &00, &fd, &00, &00, &00, &00, &fa, &00
    equb &00, &00, &03, &00, &00, &00, &06, &03
    equb &fd, &00, &00, &00, &00, &00, &00, &00
    equb &06, &00, &00, &f7, &00, &00, &f7, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00
; &7ef6 used as index base 7 times by &7a17, &7a66, &7aa3, &7aec, &7bed, &7c33, &7cd8
.monster_step
    equb &00, &03, &00, &02, &02, &02, &02, &01
    equb &02, &03, &03, &02, &01, &00, &02, &03
    equb &03, &02, &00, &00, &03, &00, &00, &00
    equb &02, &00, &01, &01, &00, &00, &01, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00
; &7f20 used as index base 9 times by &1515, &7173, &719a, &730d, &7337, &73ea, &7413, &7469, &74bb
.object_x
    equb &00, &ff, &ff, &ff, &ff, &ff, &18, &04
    equb &04, &05, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &01, &07, &04
    equb &04, &ff, &ff, &ff, &ff, &ff
; &7f3e referenced 4 times by &1f3b, &1f77, &1f85, &2029
.exit_x
    equb &04
; &7f3f used as index base 9 times by &151b, &717b, &719d, &7313, &7342, &73f3, &7416, &746c, &74be
.object_y
    equb &00, &ff, &ff, &ff, &ff, &ff, &15, &18
    equb &19, &19, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff
    equs "**+."
    equb &ff, &ff, &ff, &ff, &ff
; &7f5d referenced 4 times by &1f43, &1f7d, &1f88, &202f
.exit_y
    equb &2c
; &7f5e used as index base 7 times by &1521, &7183, &718e, &7191, &7319, &735c, &73c8
.object_type
    equb &00
    equs "___)c_S+S((``(*b(()(++++)(()(Q"
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00
; ***************************************************************************************
; WRCHV handler: print letters and digits in the game font
;
; Installed on WRCHV while the game runs. A letter (either case) or a digit is printed in
; the game's own font: its eight-byte glyph is copied over the definition of character
; 128 (user_char_128) and character 128 is printed instead. Every other character is
; printed unchanged. Both paths finish in the MOS 1.20 OSWRCH routine at
; mos_oswrch_default, jumped to directly rather than through the WRCHV value saved at
; start-up.
;
; On Entry:
;     A: character to print
;
; On Exit:
;     A: corrupted
;     X: preserved
;     Y: preserved
.wrch_handler
    sta plot_x                          ; Keep the character
    txa                                 ; Save X...
    pha                                 ; ...
    tya                                 ; ...and Y
    pha                                 ; ...
    lda plot_x                          ; Classify the character
    cmp #&30 ; '0'                      ; Below '0': print it unchanged
    bcc code_7ff6                       ; ...
    cmp #&3a ; ':'                      ; '0'-'9': a digit
    bcc code_7fda                       ; ...
    cmp #&41 ; 'A'                      ; ':'-'@': print it unchanged
    bcc code_7ff6                       ; ...
    cmp #&5b ; '['                      ; 'A'-'Z': a capital letter
    bcc code_7fb5                       ; ...
    cmp #&61 ; 'a'                      ; '['-'`': print it unchanged
    bcc code_7ff6                       ; ...
    cmp #&7b ; '{'                      ; Above 'z': print it unchanged
    bcs code_7ff6                       ; ...
    sec                                 ; A lower-case letter: letter number 0-25
    sbc #&61 ; 'a'                      ; ...
    jmp code_7fb8                       ; ...
; &7fb5 referenced 1 time by &7fa5
.code_7fb5
    sec                                 ; A capital letter: letter number 0-25
    sbc #&41 ; 'A'                      ; ...
; &7fb8 referenced 1 time by &7fb2
.code_7fb8
    asl a                               ; x 8: offset of the glyph in font_letters
    asl a                               ; ...
    asl a                               ; ...
    bne code_7fbd                       ; Branch to the next instruction either way
; &7fbd referenced 1 time by &7fbb
.code_7fbd
    tax                                 ; X = offset of the first glyph byte
    clc                                 ; Stop after eight bytes
    adc #8                              ; ...
    sta plot_x                          ; ...
    ldy #0                              ; Y indexes the character 128 definition
; &7fc5 referenced 1 time by &7fcf
.loop_7fc5
    lda font_letters,x                  ; Copy a glyph byte...
    sta room_walls,y                    ; ...into the character 128 definition
    iny                                 ; ...
    inx                                 ; ...
    cpx plot_x                          ; ...
    bne loop_7fc5                       ; Loop for eight bytes
; &7fd1 referenced 1 time by &7ff4
.loop_7fd1
    pla                                 ; Restore Y...
    tay                                 ; ...
    pla                                 ; ...and X
    tax                                 ; ...
    lda #&80                            ; Print character 128, now showing the glyph...
    jmp mos_oswrch_default              ; ...through the MOS 1.20 OSWRCH routine
; &7fda referenced 1 time by &7f9d
.code_7fda
    sec                                 ; A digit: digit number 0-9
    sbc #&30 ; '0'                      ; ...
    asl a                               ; x 8: offset of the glyph in font_digits
    asl a                               ; ...
    asl a                               ; ...
    tax                                 ; X = offset of the first glyph byte
    clc                                 ; Stop after eight bytes
    adc #8                              ; ...
    sta plot_x                          ; ...
    ldy #0                              ; Y indexes the character 128 definition
; &7fe8 referenced 1 time by &7ff2
.loop_7fe8
    lda font_digits,x                   ; Copy a glyph byte...
    sta room_walls,y                    ; ...into the character 128 definition
    iny                                 ; ...
    inx                                 ; ...
    cpx plot_x                          ; ...
    bne loop_7fe8                       ; Loop for eight bytes
    beq loop_7fd1                       ; Print character 128 (always branches)
; &7ff6 referenced 4 times by &7f99, &7fa1, &7fa9, &7fad
.code_7ff6
    pla                                 ; Any other character: restore Y...
    tay                                 ; ...
    pla                                 ; ...and X
    tax                                 ; ...
    lda plot_x                          ; Recover the character
    jmp mos_oswrch_default              ; ...and print it through the MOS 1.20 OSWRCH routine
    equb &00
.dasmos_end

save "Dunjun4", &0400, &0d00, &0400, &0400
save "Dunjun7", &0d00, &1100, &0d00, &0d00
save "Dunjun5", &1100, &3000, &1100, &1100
save "Dunjun6", &6e80, &8000, &6e80, &6e80

; Label references by decreasing frequency:
;     oswrch:                     66
;     cell_x:                     59
;     cell_y:                     55
;     scratch:                    50
;     plot_x:                     47
;     sprite_number:              45
;     hero_x:                     29
;     plot_y:                     29
;     hero_y:                     27
;     data_007b:                  21
;     plot_sprite:                21
;     hero_offset_y:              20
;     hero_offset_x:              19
;     monster_sprite:             19
;     plot_at_cell:               19
;     data_007d:                  18
;     data_007e:                  18
;     hero_direction:             18
;     monster_offset_y:           17
;     monster_x:                  17
;     osbyte:                     17
;     monster_y:                  16
;     monster_offset_x:           15
;     osword:                     15
;     hero_frame:                 14
;     screen_ptr:                 13
;     hero_step:                  12
;     missile_direction:          12
;     plot_victory_sprite:        12
;     previous_x:                 11
;     previous_y:                 11
;     hero_health_tens:           10
;     hero_key:                   10
;     hero_panel_y:               10
;     hero_max_missiles:           9
;     object_x:                    9
;     object_y:                    9
;     returning_hero_queue:        9
;     screen_ptr_hi:               9
;     data_0080:                   8
;     lose_health_point:           8
;     panel_hero:                  8
;     scratch2:                    8
;     test_wall:                   8
;     cell_room:                   7
;     code_1f00:                   7
;     data_0081:                   7
;     data_0600:                   7
;     hero_damage_taken:           7
;     hero_health_units:           7
;     hero_missile_damage:         7
;     hero_score_units:            7
;     key_x:                       7
;     key_y:                       7
;     monster_step:                7
;     object_type:                 7
;     code_0581:                   6
;     code_7b04:                   6
;     data_0082:                   6
;     data_008f:                   6
;     hero_score_ten_thousands:    6
;     level_bcd:                   6
;     level_number:                6
;     missile_x:                   6
;     missile_y:                   6
;     os_vsync_counter:            6
;     sprite_width:                6
;     test_key:                    6
;     add_point:                   5
;     code_7075:                   5
;     code_71d9:                   5
;     count:                       5
;     data_0084:                   5
;     data_09f2:                   5
;     data_09f3:                   5
;     hero_score_hundreds:         5
;     hero_score_tens:             5
;     hero_score_thousands:        5
;     next_trapdoor:               5
;     plot_panel_sprite:           5
;     view_room:                   5
;     add_ten_points:              4
;     code_1ec6:                   4
;     code_6f79:                   4
;     code_703b:                   4
;     code_7096:                   4
;     code_70c1:                   4
;     code_7611:                   4
;     code_7aea:                   4
;     code_7ff6:                   4
;     data_007c:                   4
;     data_0601:                   4
;     data_09f0:                   4
;     data_09f1:                   4
;     data_09ff:                   4
;     door_x:                      4
;     door_y:                      4
;     draw_room:                   4
;     exit_x:                      4
;     exit_y:                      4
;     find_creature:               4
;     hero_absent:                 4
;     hero_door_x:                 4
;     hero_door_y:                 4
;     hero_key_dropped:            4
;     hero_sprites:                4
;     missile_sprite_base:         4
;     monster_hit_points:          4
;     sprite_heights:              4
;     start_hero_step:             4
;     wrchv:                       4
;     wrchv + 1:                   4
;     bit_masks:                   3
;     code_1db2:                   3
;     code_1f36:                   3
;     code_7266:                   3
;     code_72bc:                   3
;     code_7470:                   3
;     code_76d4:                   3
;     code_798d:                   3
;     code_7b28:                   3
;     data_008d:                   3
;     data_09f4:                   3
;     data_09f5:                   3
;     hero_has_boots:              3
;     hero_magic_delay:            3
;     magic_kill_count:            3
;     missile_damage:              3
;     monster_frame:               3
;     monster_start_hit_points:    3
;     next_victory_sprite:         3
;     osasci:                      3
;     print_menu:                  3
;     room_walls:                  3
;     sprite_data_ptr:             3
;     sprite_widths:               3
;     system_via_t1c_l:            3
;     clear_text_area:             2
;     code_041e:                   2
;     code_045a:                   2
;     code_0e00:                   2
;     code_108a:                   2
;     code_1097:                   2
;     code_111c:                   2
;     code_11bb:                   2
;     code_1e28:                   2
;     code_1ebe:                   2
;     code_1f91:                   2
;     code_2076:                   2
;     code_6ec1:                   2
;     code_7130:                   2
;     code_7156:                   2
;     code_71d4:                   2
;     code_71d7:                   2
;     code_7201:                   2
;     code_7218:                   2
;     code_73c7:                   2
;     code_7467:                   2
;     code_752c:                   2
;     code_75e2:                   2
;     code_7652:                   2
;     code_7692:                   2
;     code_79b7:                   2
;     code_7adc:                   2
;     code_7af8:                   2
;     code_7c6f:                   2
;     code_7cae:                   2
;     credit_missile_owner:        2
;     data_008e:                   2
;     data_0602:                   2
;     data_09f6:                   2
;     data_09fa:                   2
;     data_0b2b:                   2
;     data_0b2c:                   2
;     data_0b2d:                   2
;     data_0bfc:                   2
;     data_0cf4:                   2
;     data_0d21:                   2
;     data_0d22:                   2
;     data_0d23:                   2
;     data_0da2:                   2
;     data_0da4:                   2
;     data_0da6:                   2
;     data_12d4:                   2
;     data_7dd0:                   2
;     data_7e23:                   2
;     data_7e4c:                   2
;     door_sprite:                 2
;     draw_hero:                   2
;     draw_victory_ring:           2
;     draw_view_0:                 2
;     draw_view_1:                 2
;     draw_view_2:                 2
;     draw_view_3:                 2
;     get_hero_cell:               2
;     level_filename_digits:       2
;     mos_oswrch_default:          2
;     osrdch:                      2
;     play_pickup_sound:           2
;     plot_chalice:                2
;     point_at_boots_icon:         2
;     previous_offset_x:           2
;     previous_offset_y:           2
;     reset_hero:                  2
;     restore_hero_sprites:        2
;     return_14:                   2
;     row_start_ptr:               2
;     row_start_ptr_hi:            2
;     saved_wrchv:                 2
;     sprite_data_ptr_hi:          2
;     sprite_height:               2
;     test_object_free:            2
;     trapdoor_x:                  2
;     trapdoor_y:                  2
;     add_thousand_points:         1
;     animate_absent_hero:         1
;     check_for_victory:           1
;     code_046b:                   1
;     code_05c0:                   1
;     code_05c3:                   1
;     code_05c9:                   1
;     code_05d7:                   1
;     code_05e4:                   1
;     code_05e9:                   1
;     code_06c9:                   1
;     code_06f0:                   1
;     code_0938:                   1
;     code_093e:                   1
;     code_0961:                   1
;     code_0e34:                   1
;     code_0e36:                   1
;     code_0e52:                   1
;     code_0e7a:                   1
;     code_110a:                   1
;     code_1124:                   1
;     code_113c:                   1
;     code_11d3:                   1
;     code_16bf:                   1
;     code_1cc5:                   1
;     code_1cd8:                   1
;     code_1ce3:                   1
;     code_1cee:                   1
;     code_1cfa:                   1
;     code_1db8:                   1
;     code_1dba:                   1
;     code_1dc2:                   1
;     code_1de6:                   1
;     code_1df3:                   1
;     code_1e35:                   1
;     code_1e45:                   1
;     code_1ec4:                   1
;     code_1ece:                   1
;     code_1f2a:                   1
;     code_1f96:                   1
;     code_1f9e:                   1
;     code_1ff2:                   1
;     code_2026:                   1
;     code_20db:                   1
;     code_20e9:                   1
;     code_20f7:                   1
;     code_6e82:                   1
;     code_6e91:                   1
;     code_6e97:                   1
;     code_6eba:                   1
;     code_6ed4:                   1
;     code_6ee7:                   1
;     code_6efa:                   1
;     code_6f0d:                   1
;     code_6f18:                   1
;     code_6f70:                   1
;     code_6f83:                   1
;     code_6f8a:                   1
;     code_6f91:                   1
;     code_6f98:                   1
;     code_6fc7:                   1
;     code_6fd5:                   1
;     code_7002:                   1
;     code_7053:                   1
;     code_7069:                   1
;     code_70d2:                   1
;     code_70da:                   1
;     code_70e7:                   1
;     code_70fe:                   1
;     code_7108:                   1
;     code_710f:                   1
;     code_7116:                   1
;     code_711d:                   1
;     code_7132:                   1
;     code_713a:                   1
;     code_7150:                   1
;     code_71a0:                   1
;     code_71b4:                   1
;     code_71c0:                   1
;     code_71cc:                   1
;     code_7227:                   1
;     code_7263:                   1
;     code_7337:                   1
;     code_7342:                   1
;     code_734d:                   1
;     code_738a:                   1
;     code_73a0:                   1
;     code_73c3:                   1
;     code_73d9:                   1
;     code_740d:                   1
;     code_7429:                   1
;     code_744c:                   1
;     code_7464:                   1
;     code_7477:                   1
;     code_74b6:                   1
;     code_74eb:                   1
;     code_74fc:                   1
;     code_74ff:                   1
;     code_7516:                   1
;     code_7529:                   1
;     code_7551:                   1
;     code_755b:                   1
;     code_7565:                   1
;     code_756b:                   1
;     code_757c:                   1
;     code_75a6:                   1
;     code_75ae:                   1
;     code_75c5:                   1
;     code_7619:                   1
;     code_761f:                   1
;     code_7650:                   1
;     code_769c:                   1
;     code_76ab:                   1
;     code_76ae:                   1
;     code_76c0:                   1
;     code_76c9:                   1
;     code_76d2:                   1
;     code_76e0:                   1
;     code_770b:                   1
;     code_772e:                   1
;     code_7757:                   1
;     code_7764:                   1
;     code_7771:                   1
;     code_783e:                   1
;     code_7845:                   1
;     code_78ad:                   1
;     code_78c7:                   1
;     code_78e1:                   1
;     code_79bc:                   1
;     code_79e5:                   1
;     code_7a17:                   1
;     code_7a23:                   1
;     code_7a2d:                   1
;     code_7a34:                   1
;     code_7a3b:                   1
;     code_7a42:                   1
;     code_7a81:                   1
;     code_7a87:                   1
;     code_7ac1:                   1
;     code_7b31:                   1
;     code_7b3f:                   1
;     code_7b79:                   1
;     code_7b88:                   1
;     code_7b97:                   1
;     code_7bb9:                   1
;     code_7bc0:                   1
;     code_7bc7:                   1
;     code_7bce:                   1
;     code_7bd6:                   1
;     code_7c02:                   1
;     code_7c11:                   1
;     code_7c20:                   1
;     code_7c42:                   1
;     code_7c49:                   1
;     code_7c50:                   1
;     code_7c57:                   1
;     code_7c5f:                   1
;     code_7c6c:                   1
;     code_7c82:                   1
;     code_7cb3:                   1
;     code_7cc2:                   1
;     code_7cfb:                   1
;     code_7fb5:                   1
;     code_7fb8:                   1
;     code_7fbd:                   1
;     code_7fda:                   1
;     collect_objects:             1
;     continue_hero_step:          1
;     continue_monster_step:       1
;     dasmos_start:                1
;     data_0000:                   1
;     data_00fa:                   1
;     data_00fc:                   1
;     data_09f7:                   1
;     data_09f8:                   1
;     data_09f9:                   1
;     data_09fb:                   1
;     data_09fc:                   1
;     data_09fd:                   1
;     data_09fe:                   1
;     data_0b8f:                   1
;     data_0b97:                   1
;     data_0c3a:                   1
;     data_0d19:                   1
;     data_0d1f:                   1
;     data_0d8f:                   1
;     data_0dfd:                   1
;     data_0dff:                   1
;     data_0ff0:                   1
;     data_10e7:                   1
;     data_10e8:                   1
;     data_120f:                   1
;     data_1210:                   1
;     data_149c:                   1
;     data_16d6:                   1
;     data_213a:                   1
;     data_3000:                   1
;     data_6e61:                   1
;     data_6e62:                   1
;     data_6e63:                   1
;     data_6e64:                   1
;     data_6e65:                   1
;     data_fffc:                   1
;     data_fffd:                   1
;     decrypt_level:               1
;     dissolve_chalice:            1
;     draw_all_views:              1
;     draw_room_row:               1
;     draw_status_panel:           1
;     draw_view_frames:            1
;     drop_key:                    1
;     erase_boots_icon:            1
;     filev:                       1
;     filev + 1:                   1
;     filev_call_address:          1
;     find_open_neighbour:         1
;     flip_firer_frame:            1
;     font_digits:                 1
;     font_letters:                1
;     game_over_message:           1
;     hero_appearance_sprites:     1
;     hero_enters_exit:            1
;     hero_faces:                  1
;     hero_key_down:               1
;     hero_key_fire:               1
;     hero_key_left:               1
;     hero_key_right:              1
;     hero_key_up:                 1
;     hero_magic_key:              1
;     hero_menu:                   1
;     hero_missile_sprites:        1
;     hero_start_damage_taken:     1
;     hero_start_max_missiles:     1
;     hero_start_missile_damage:   1
;     level_checksums:             1
;     level_door_sprite:           1
;     level_door_x:                1
;     level_door_y:                1
;     level_key_x:                 1
;     level_key_y:                 1
;     level_loop:                  1
;     level_object_free_map:       1
;     level_object_type:           1
;     level_object_x:              1
;     level_object_y:              1
;     level_osfile_block:          1
;     level_trapdoor_x:            1
;     level_trapdoor_y:            1
;     level_wall_sprite:           1
;     level_walls:                 1
;     load_level:                  1
;     loop_0437:                   1
;     loop_0528:                   1
;     loop_0540:                   1
;     loop_05cb:                   1
;     loop_06b4:                   1
;     loop_091d:                   1
;     loop_0929:                   1
;     loop_0e09:                   1
;     loop_0e6d:                   1
;     loop_0ea8:                   1
;     loop_0eae:                   1
;     loop_0eb9:                   1
;     loop_0efc:                   1
;     loop_0f3a:                   1
;     loop_1079:                   1
;     loop_1084:                   1
;     loop_10ba:                   1
;     loop_10c7:                   1
;     loop_113e:                   1
;     loop_1140:                   1
;     loop_11de:                   1
;     loop_11ec:                   1
;     loop_14a2:                   1
;     loop_14e5:                   1
;     loop_14ec:                   1
;     loop_1512:                   1
;     loop_1529:                   1
;     loop_1540:                   1
;     loop_1551:                   1
;     loop_1564:                   1
;     loop_1577:                   1
;     loop_1585:                   1
;     loop_159c:                   1
;     loop_16b4:                   1
;     loop_1d03:                   1
;     loop_1dce:                   1
;     loop_1ee0:                   1
;     loop_1ee7:                   1
;     loop_1eee:                   1
;     loop_1f17:                   1
;     loop_1f38:                   1
;     loop_2009:                   1
;     loop_2014:                   1
;     loop_205f:                   1
;     loop_206c:                   1
;     loop_6f28:                   1
;     loop_7007:                   1
;     loop_7173:                   1
;     loop_71dd:                   1
;     loop_71f4:                   1
;     loop_7256:                   1
;     loop_730d:                   1
;     loop_73a7:                   1
;     loop_742b:                   1
;     loop_7498:                   1
;     loop_7667:                   1
;     loop_77e4:                   1
;     loop_77fe:                   1
;     loop_7827:                   1
;     loop_7976:                   1
;     loop_7997:                   1
;     loop_79aa:                   1
;     loop_79cd:                   1
;     loop_7fc5:                   1
;     loop_7fd1:                   1
;     loop_7fe8:                   1
;     mos_reset_entry:             1
;     mos_row_offsets:             1
;     mos_row_offsets_lo:          1
;     move_heroes:                 1
;     move_missiles:               1
;     object_free_map:             1
;     plot_boots_icon:             1
;     print_menu_string:           1
;     queue_exit_marker:           1
;     remove_absent_heroes:        1
;     reset_monsters:              1
;     reset_workspace:             1
;     return_1:                    1
;     return_10:                   1
;     return_11:                   1
;     return_12:                   1
;     return_13:                   1
;     return_2:                    1
;     return_3:                    1
;     return_4:                    1
;     return_5:                    1
;     return_6:                    1
;     return_7:                    1
;     return_8:                    1
;     return_9:                    1
;     screen_address:              1
;     set_menu_no:                 1
;     set_menu_off:                1
;     set_menu_on:                 1
;     set_menu_yes:                1
;     show_level_number:           1
;     sprite_addr_hi:              1
;     sprite_addr_lo:              1
;     start_level:                 1
;     start_monster_step:          1
;     sub_7305:                    1
;     unpack_level:                1
;     update_game:                 1
;     update_monsters:             1
;     victory_sequence:            1
;     wall_sprite:                 1
;     workspace_template:          1

; Automatically generated labels:
;     code_041e
;     code_045a
;     code_046b
;     code_0581
;     code_05c0
;     code_05c3
;     code_05c9
;     code_05d7
;     code_05e4
;     code_05e9
;     code_06c9
;     code_06f0
;     code_0938
;     code_093e
;     code_0961
;     code_0e00
;     code_0e34
;     code_0e36
;     code_0e52
;     code_0e7a
;     code_108a
;     code_1097
;     code_110a
;     code_111c
;     code_1124
;     code_113c
;     code_11bb
;     code_11d3
;     code_16bf
;     code_1cc5
;     code_1cd8
;     code_1ce3
;     code_1cee
;     code_1cfa
;     code_1db2
;     code_1db8
;     code_1dba
;     code_1dc2
;     code_1de6
;     code_1df3
;     code_1e28
;     code_1e35
;     code_1e45
;     code_1ebe
;     code_1ec4
;     code_1ec6
;     code_1ece
;     code_1f00
;     code_1f2a
;     code_1f36
;     code_1f91
;     code_1f96
;     code_1f9e
;     code_1ff2
;     code_2026
;     code_2076
;     code_20db
;     code_20e9
;     code_20f7
;     code_6e82
;     code_6e91
;     code_6e97
;     code_6eba
;     code_6ec1
;     code_6ed4
;     code_6ee7
;     code_6efa
;     code_6f0d
;     code_6f18
;     code_6f70
;     code_6f79
;     code_6f83
;     code_6f8a
;     code_6f91
;     code_6f98
;     code_6fc7
;     code_6fd5
;     code_7002
;     code_703b
;     code_7053
;     code_7069
;     code_7075
;     code_7096
;     code_70c1
;     code_70d2
;     code_70da
;     code_70e7
;     code_70fe
;     code_7108
;     code_710f
;     code_7116
;     code_711d
;     code_7130
;     code_7132
;     code_713a
;     code_7150
;     code_7156
;     code_71a0
;     code_71b4
;     code_71c0
;     code_71cc
;     code_71d4
;     code_71d7
;     code_71d9
;     code_7201
;     code_7218
;     code_7227
;     code_7263
;     code_7266
;     code_72bc
;     code_7337
;     code_7342
;     code_734d
;     code_738a
;     code_73a0
;     code_73c3
;     code_73c7
;     code_73d9
;     code_740d
;     code_7429
;     code_744c
;     code_7464
;     code_7467
;     code_7470
;     code_7477
;     code_74b6
;     code_74eb
;     code_74fc
;     code_74ff
;     code_7516
;     code_7529
;     code_752c
;     code_7551
;     code_755b
;     code_7565
;     code_756b
;     code_757c
;     code_75a6
;     code_75ae
;     code_75c5
;     code_75e2
;     code_7611
;     code_7619
;     code_761f
;     code_7650
;     code_7652
;     code_7692
;     code_769c
;     code_76ab
;     code_76ae
;     code_76c0
;     code_76c9
;     code_76d2
;     code_76d4
;     code_76e0
;     code_770b
;     code_772e
;     code_7757
;     code_7764
;     code_7771
;     code_783e
;     code_7845
;     code_78ad
;     code_78c7
;     code_78e1
;     code_798d
;     code_79b7
;     code_79bc
;     code_79e5
;     code_7a17
;     code_7a23
;     code_7a2d
;     code_7a34
;     code_7a3b
;     code_7a42
;     code_7a81
;     code_7a87
;     code_7ac1
;     code_7adc
;     code_7aea
;     code_7af8
;     code_7b04
;     code_7b28
;     code_7b31
;     code_7b3f
;     code_7b79
;     code_7b88
;     code_7b97
;     code_7bb9
;     code_7bc0
;     code_7bc7
;     code_7bce
;     code_7bd6
;     code_7c02
;     code_7c11
;     code_7c20
;     code_7c42
;     code_7c49
;     code_7c50
;     code_7c57
;     code_7c5f
;     code_7c6c
;     code_7c6f
;     code_7c82
;     code_7cae
;     code_7cb3
;     code_7cc2
;     code_7cfb
;     code_7fb5
;     code_7fb8
;     code_7fbd
;     code_7fda
;     code_7ff6
;     data_0000
;     data_007b
;     data_007c
;     data_007d
;     data_007e
;     data_0080
;     data_0081
;     data_0082
;     data_0084
;     data_008d
;     data_008e
;     data_008f
;     data_00fa
;     data_00fc
;     data_0600
;     data_0601
;     data_0602
;     data_09f0
;     data_09f1
;     data_09f2
;     data_09f3
;     data_09f4
;     data_09f5
;     data_09f6
;     data_09f7
;     data_09f8
;     data_09f9
;     data_09fa
;     data_09fb
;     data_09fc
;     data_09fd
;     data_09fe
;     data_09ff
;     data_0b2b
;     data_0b2c
;     data_0b2d
;     data_0b8f
;     data_0b97
;     data_0bfc
;     data_0c3a
;     data_0cf4
;     data_0d19
;     data_0d1f
;     data_0d21
;     data_0d22
;     data_0d23
;     data_0d8f
;     data_0da2
;     data_0da4
;     data_0da6
;     data_0dfd
;     data_0dff
;     data_0ff0
;     data_10e7
;     data_10e8
;     data_120f
;     data_1210
;     data_12d4
;     data_149c
;     data_16d6
;     data_213a
;     data_3000
;     data_6e61
;     data_6e62
;     data_6e63
;     data_6e64
;     data_6e65
;     data_7dd0
;     data_7e23
;     data_7e4c
;     data_fffc
;     data_fffd
;     loop_0437
;     loop_0528
;     loop_0540
;     loop_05cb
;     loop_06b4
;     loop_091d
;     loop_0929
;     loop_0e09
;     loop_0e6d
;     loop_0ea8
;     loop_0eae
;     loop_0eb9
;     loop_0efc
;     loop_0f3a
;     loop_1079
;     loop_1084
;     loop_10ba
;     loop_10c7
;     loop_113e
;     loop_1140
;     loop_11de
;     loop_11ec
;     loop_14a2
;     loop_14e5
;     loop_14ec
;     loop_1512
;     loop_1529
;     loop_1540
;     loop_1551
;     loop_1564
;     loop_1577
;     loop_1585
;     loop_159c
;     loop_16b4
;     loop_1d03
;     loop_1dce
;     loop_1ee0
;     loop_1ee7
;     loop_1eee
;     loop_1f17
;     loop_1f38
;     loop_2009
;     loop_2014
;     loop_205f
;     loop_206c
;     loop_6f28
;     loop_7007
;     loop_7173
;     loop_71dd
;     loop_71f4
;     loop_7256
;     loop_730d
;     loop_73a7
;     loop_742b
;     loop_7498
;     loop_7667
;     loop_77e4
;     loop_77fe
;     loop_7827
;     loop_7976
;     loop_7997
;     loop_79aa
;     loop_79cd
;     loop_7fc5
;     loop_7fd1
;     loop_7fe8
;     return_1
;     return_10
;     return_11
;     return_12
;     return_13
;     return_14
;     return_2
;     return_3
;     return_4
;     return_5
;     return_6
;     return_7
;     return_8
;     return_9
;     sub_05f6
;     sub_09a0
;     sub_0d63
;     sub_0ded
;     sub_0fea
;     sub_10e6
;     sub_1204
;     sub_212f
;     sub_7305
;     sub_7db9
;     sub_7e30

; Stats:
;     Total size (Code + Data) = 15744 bytes
;     Code                     = 6934 bytes (44%)
;     Data                     = 8810 bytes (56%)
;
;     Number of instructions   = 3181
;     Number of data bytes     = 7576 bytes
;     Number of data words     = 0 bytes
;     Number of string bytes   = 1234 bytes
;     Number of strings        = 190
