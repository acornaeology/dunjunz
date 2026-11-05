; Constants
osbyte_bell_channel                  = &d3
osbyte_bell_envelope                 = &d4
osbyte_bell_frequency                = &d5
osbyte_bell_duration                 = &d6
osbyte_flush_buffer_class            = &0f
osbyte_inkey                         = &81
osword_envelope                      = &08
osword_sound                         = &07
osbyte_scan_keyboard_from_16         = &7a
osbyte_escape_break_effect           = &c8
osbyte_read_adc_or_get_buffer_status = &80
osbyte_kbd_status                    = &ca
osbyte_sound_suppression             = &d2

; Memory locations
data_0000                = &00
; &00 referenced 1 time by &3826
plot_x                   = &70  ; Sprite position: screen byte column, 0-79 (two MODE 2 pixels per byte). Also used as a scratch byte and pointer low byte by other routines.
; &70 referenced 63 times by &30c4, &30d1, &36a8, &3b7c, &3c2c, &3c37, &3c3b, &44e6, &455c, &45b7, &50a1, &50ba, &50c4, &5115, &512d, &5131, &513d, &51d2, &51e9, &51eb, &5202, &520a, &520c, &520e, &5215, &521b, &5357, &535b, &55d2, &55e9, &55eb, &5602, &560a, &560c, &560e, &5615, &561b, &5757, &575b, &726d, &7282, &72c6, &72db, &72eb, &72fb, &75b8, &75d9, &75e4, &75fb, &7823, &7846, &784a, &78a1, &78bb, &78d5, &78ef, &7f8f, &7f95, &7fc1, &7fcd, &7fe4, &7ff0, &7ffa
plot_y                   = &71  ; Sprite position: pixel row from the top of the screen. Also used as a pointer high byte by other routines.
; &71 referenced 37 times by &30a7, &30bb, &36b7, &3b80, &44e2, &4558, &45b3, &50b0, &50b6, &50c8, &511c, &5135, &5143, &51da, &5208, &5219, &5221, &55da, &5608, &5619, &5621, &7269, &72c2, &75b4, &75d5, &75ec, &7603, &7797, &77a9, &77bb, &77cd, &77ef, &77f3, &78a8, &78c2, &78dc, &78f6
sprite_width             = &72  ; Width of the sprite being plotted, in screen bytes.
; &72 referenced 16 times by &304f, &3067, &5099, &50bc, &50be, &5123, &512f, &5137, &5204, &5211, &5213, &522a, &5604, &5611, &5613, &562a
sprite_height            = &73  ; Height of the sprite being plotted, in pixel rows.
; &73 referenced 7 times by &3054, &305b, &509d, &50c2, &50ca, &5129, &513b
screen_ptr               = &74  ; Screen address being written, low byte.
; &74 referenced 13 times by &305d, &306b, &306e, &3072, &3086, &308e, &3095, &3099, &30b9, &30bf, &30c1, &30d7, &30d9
screen_ptr_hi            = &75  ; Screen address being written, high byte.
; &75 referenced 9 times by &3061, &3076, &308c, &309b, &309f, &30b4, &30cd, &30cf, &30dd
row_start_ptr            = &76  ; Screen address of the first byte of the sprite row being plotted, low byte.
; &76 referenced 2 times by &305f, &3082
row_start_ptr_hi         = &77  ; Screen address of the first byte of the sprite row being plotted, high byte.
; &77 referenced 2 times by &3063, &3088
sprite_data_ptr          = &78  ; Address of the next sprite data byte to plot, low byte.
; &78 referenced 3 times by &3045, &3069, &3078
sprite_data_ptr_hi       = &79  ; Address of the next sprite data byte to plot, high byte.
; &79 referenced 2 times by &304a, &307c
sprite_number            = &7a  ; Sprite to plot: an index into the sprite tables at sprite_addr_lo, sprite_addr_hi, sprite_widths and sprite_heights.
; &7a referenced 45 times by &3040, &36aa, &38e6, &393e, &446e, &44da, &450a, &4550, &4597, &45ab, &46a9, &46f5, &4711, &51ce, &51e3, &55ce, &55e3, &7077, &70a2, &70e9, &720f, &7242, &7272, &727e, &72cb, &72d7, &72e7, &72f7, &731c, &75c0, &75dd, &75f4, &7608, &760f, &7663, &767a, &7695, &76f5, &7813, &7836, &7840, &79cb, &79fb, &7b17, &7b50
data_007b                = &7b
; &7b referenced 21 times by &449b, &44a2, &44a4, &44c0, &44c5, &7046, &7542, &767f, &77a1, &77b3, &77c5, &77d7, &77e4, &790e, &7915, &7917, &792f, &794a, &7951, &7953, &796b
data_007c                = &7c
; &7c referenced 4 times by &44a8, &77e0, &791b, &7957
data_007d                = &7d
; &7d referenced 18 times by &3832, &4472, &4504, &459b, &46a3, &46e3, &4725, &7088, &70cc, &7307, &76ea, &7738, &780c, &787a, &79c5, &7a00, &7b1c, &7b55
data_007e                = &7e
; &7e referenced 18 times by &3834, &4474, &4506, &459d, &46a5, &46e5, &472a, &708d, &70ce, &7309, &76ec, &773d, &780e, &788e, &79c7, &7a05, &7b21, &7b5a
data_0080                = &80
; &80 referenced 12 times by &388b, &3894, &3899, &38a6, &38bd, &38c2, &38ca, &38da, &5105, &510d, &5113, &5121
data_0081                = &81
; &81 referenced 11 times by &388f, &38ab, &38b0, &38b8, &38cf, &38d4, &38df, &5107, &5111, &511a, &5127
data_0082                = &82
; &82 referenced 6 times by &3838, &389e, &38e4, &38ec, &38fb, &3915
data_0084                = &84
; &84 referenced 5 times by &3840, &385c, &3862, &3873, &387c
data_008d                = &8d
; &8d referenced 3 times by &3848, &384d, &3853
level_count_copy         = &8e  ; Copy of levels_started that Coder leaves for game_entry.
; &8e referenced 4 times by &34ab, &3844, &3855, &5072
data_008f                = &8f
; &8f referenced 7 times by &34b0, &383c, &384b, &384f, &3864, &7934, &7970
data_00fa                = &fa
; &fa referenced 1 time by &3903
data_00fc                = &fc
; &fc referenced 1 time by &3901
bytev                    = &020a
; &020a referenced 1 time by &50dd
wrchv                    = &020e
; &020e referenced 4 times by &3495, &34a3, &3c1a, &3c47
os_vsync_counter         = &0240  ; MOS 1.20 counter decremented on every vertical sync interrupt. The game sets it and waits for it to run out to pace itself.
; &0240 referenced 7 times by &35a2, &35f9, &3929, &392c, &4630, &4640, &4647
os_break_intercept       = &0287  ; MOS BREAK intercept: if &0287 holds a JMP opcode the MOS jumps to &0287 twice during a reset, before and after the filing system is initialised (carry clear, then set).
; &0287 referenced 3 times by &3b9b, &3ba2, &5015
data_0288                = &0288
; &0288 referenced 2 times by &3b91, &3ba7
data_0289                = &0289
; &0289 referenced 2 times by &3b96, &3bac
hero_score_ten_thousands = &08b0  ; Each hero's score ten-thousands digit as a small digit sprite (&69 for none, &6A-&72 for 1-9).
; &08b0 used as index base 5 times by &3633, &5464, &546f, &5864, &586f
hero_absent              = &08b4  ; Non-zero for each hero switched off on the menu.
; &08b4 used as index base 8 times by &5360, &5365, &537b, &5479, &5760, &5765, &577b, &5879
levels_started           = &08bc  ; Number of levels started, kept by Coder in page &08, which survives the reset between levels.
; &08bc referenced 6 times by &34b5, &3554, &5018, &506f, &5074, &50fc
level_digits             = &08bd  ; The level number as ASCII digits for the level's filename: one digit and a space, or two digits.
; &08bd referenced 5 times by &5031, &5036, &5039, &5042, &5063
data_08be                = &08be
; &08be referenced 5 times by &501b, &5025, &502e, &5047, &5069
mos_row_offsets          = &c375  ; MOS 1.20 table of screen row offsets for 640-byte rows (row x 640, high byte then low byte, one pair per character row). Read directly by screen_address; it is not part of any documented interface.
; &c375 used as index base 1 time by &30ae
mos_row_offsets_lo       = &c376  ; Low bytes of mos_row_offsets.
; &c376 used as index base 1 time by &30b6
mos_reset_entry          = &d9cd  ; MOS 1.20 reset entry, the target of the RESET vector. Called directly to reset the machine.
; &d9cd referenced 3 times by &3baf, &5231, &5631
mos_oswrch_default       = &e0a4  ; MOS 1.20 default OSWRCH routine, WRCHV's initial value. The WRCHV handler jumps here directly instead of through the saved vector.
; &e0a4 referenced 2 times by &7fd7, &7ffc
data_e772                = &e772
; &e772 referenced 2 times by &5948, &5999
system_via_t1c_l         = &fe44
; &fe44 referenced 3 times by &38fe, &7a6f, &7aac
osrdch                   = &ffe0
; &ffe0 referenced 3 times by &3817, &533f, &573f
osasci                   = &ffe3
; &ffe3 referenced 3 times by &35f1, &37fd, &380a
oswrch                   = &ffee
; &ffee referenced 63 times by &35c8, &35cd, &35d2, &35d7, &35dc, &35e1, &37dc, &37e1, &37e6, &37eb, &37f0, &37f5, &386d, &3b54, &3b59, &3b5e, &3b63, &3b68, &3b6b, &3b6e, &3b71, &3b74, &3b77, &3bb6, &3c27, &3c2e, &3cf9, &3cfe, &3d5c, &3d61, &3d66, &3d6b, &3d70, &3d75, &500b, &5010, &504f, &5059, &5094, &50e7, &50ec, &50f4, &52b2, &52b7, &52bc, &52c1, &52c6, &52cb, &52e0, &52e6, &52ed, &52f4, &56b2, &56b7, &56bc, &56c1, &56c6, &56cb, &56e0, &56e6, &56ed, &56f4, &6f47
osword                   = &fff1
; &fff1 referenced 15 times by &3de6, &3def, &4458, &45ed, &45f6, &736d, &7376, &73b9, &73e3, &748c, &74a9, &74b2, &7586, &7634, &763d
osbyte                   = &fff4
; &fff4 referenced 27 times by &3477, &3480, &3489, &3492, &3600, &3609, &3814, &382d, &3868, &4619, &4620, &4627, &5006, &50a7, &50d4, &5333, &533c, &539d, &5733, &573c, &579d, &594f, &595d, &596c, &597a, &5989, &7c9e
oscli                    = &fff7
; &fff7 referenced 7 times by &3bbd, &3bc4, &3d05, &3d0c, &5060, &5085, &508f
data_fffc                = &fffc
; &fffc referenced 1 time by &381a
data_fffd                = &fffd
; &fffd referenced 1 time by &3820


    org &3000

; Move 1: &3000 to &08c0 for length 6272
    org &08c0
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
; &0900 referenced 21 times by &36b9, &44ea, &4560, &45bd, &51de, &51ed, &55de, &55ed, &7276, &7286, &72cf, &72df, &72ef, &72ff, &7613, &7838, &7842, &78aa, &78c4, &78de, &78f8
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
; &091d referenced 1 time by &30a4
.code_091d
    lda screen_ptr                      ; Remember where this pixel row starts...
    sta row_start_ptr                   ; ...
    lda screen_ptr_hi                   ; ...
    sta row_start_ptr_hi                ; ...in row_start_ptr
    txa                                 ; Save the row count
    pha                                 ; ...
    ldx sprite_width                    ; X counts the bytes across this row
; &0929 referenced 1 time by &307f
.code_0929
    lda (sprite_data_ptr),y             ; Copy one sprite byte...
    sta (screen_ptr),y                  ; ...to the screen
    clc                                 ; Step screen_ptr right one byte column: 8 bytes on
    lda screen_ptr                      ; ...
    adc #8                              ; ...
    sta screen_ptr                      ; ...
    bcc code_0938                       ; ...
    inc screen_ptr_hi                   ; ...with carry into the high byte
; &0938 referenced 1 time by &3074
.code_0938
    inc sprite_data_ptr                 ; Next sprite data byte
    bne code_093e                       ; ...
    inc sprite_data_ptr_hi              ; ...with carry into the high byte
; &093e referenced 1 time by &307a
.code_093e
    dex                                 ; Count the bytes across
    bne code_0929                       ; Loop until the row is done
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
; &0961 referenced 1 time by &3092
.code_0961
    pla                                 ; Recover the row count
    tax                                 ; ...
    dex                                 ; Count the pixel rows
    bne code_091d                       ; Loop until the sprite is done
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
; &0967 referenced 1 time by &3056
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
    bcc return_1                        ; ...
    inc screen_ptr_hi                   ; ...with carry into the high byte
; &099f referenced 1 time by &30db
.return_1
    rts                                 ; Return
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
; &09f0 referenced 3 times by &46ba, &46e7, &4713
.exit_saved_x
    equb &04
; &09f1 referenced 3 times by &46c0, &46ed, &4719
.exit_saved_y
    equb &2c
; &09f2 referenced 3 times by &3bed, &4650, &46d6
.exit_busy
    equb &00
; &09f3 referenced 4 times by &46fe, &4703, &470e, &4734
.exit_spin
    equb &ff
; &09f4 referenced 2 times by &471f, &4737
.exit_shrinks_left
    equb &00
; &09f5 referenced 2 times by &46de, &46fa
.exiting_hero
    equb &03
; &09f6 used as index base 1 time by &4722
.exit_offsets_x
; &3137 referenced 1 time by &3bfe
data_09f7 = exit_offsets_x+1
; &3138 referenced 1 time by &3c01
data_09f8 = exit_offsets_x+2
; &3139 referenced 1 time by &3bf0
data_09f9 = exit_offsets_x+3
    equb &04, &01, &01, &00
; &09fa referenced 1 time by &3bf3; also used as index base 1 time by &4727
.exit_offsets_y
; &313b referenced 1 time by &3c0e
data_09fb = exit_offsets_y+1
; &313c referenced 1 time by &3c13
data_09fc = exit_offsets_y+2
; &313d referenced 1 time by &3c04
data_09fd = exit_offsets_y+3
; &313e referenced 1 time by &3bf6
data_09fe = exit_offsets_y+4
    equb &00, &05, &03, &01, &00
; &09ff referenced 2 times by &3c09, &466d
.shrunk_hero
    equb &ff
.sprite_boots
    equb &00, &00, &00, &00
    equb &00, &00, &00, &15
    equb &00, &00, &00, &3f
    equb &00, &00, &00, &3f
    equb &00, &01, &13, &2a
    equb &00, &01, &13, &2a
    equb &00, &01, &13, &00
    equb &00, &03, &13, &00
    equb &03, &03, &33, &00
    equb &03, &03, &33, &00
    equb &03, &03, &33, &00
    equb &00, &00, &00, &00
.sprite_helmet
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &2a, &3c, &22, &2a
    equb &2a, &3c, &22, &2a
    equb &2a, &3c, &22, &2a
    equb &14, &14, &11, &00
    equb &14, &00, &11, &00
    equb &14, &28, &39, &00
    equb &14, &3c, &33, &00
    equb &14, &3c, &33, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
.sprite_potion
    equb &00, &00, &00, &00
    equb &00, &01, &02, &00
    equb &00, &15, &2a, &00
    equb &00, &05, &02, &00
    equb &00, &05, &02, &00
    equb &00, &05, &02, &00
    equb &00, &05, &02, &00
    equb &00, &0f, &03, &00
    equb &05, &0f, &0b, &02
    equb &05, &0f, &0b, &02
    equb &05, &0f, &03, &02
    equb &00, &0f, &03, &00
.sprite_magic_sword
    equb &00, &00, &00, &00
    equb &00, &54, &00, &54
    equb &00, &00, &00, &00
    equb &54, &00, &04, &00
    equb &00, &00, &04, &00
    equb &3f, &3f, &2e, &0c
    equb &15, &3f, &2e, &00
    equb &00, &00, &04, &54
    equb &a8, &00, &00, &00
    equb &00, &54, &00, &00
    equb &00, &00, &00, &a8
    equb &00, &00, &00, &00
.sprite_weapons
    equb &2a, &00, &00, &02
    equb &05, &00, &00, &02
    equb &00, &0a, &15, &01
    equb &00, &04, &1d, &01
    equb &01, &04, &15, &01
    equb &05, &00, &15, &01
    equb &05, &00, &15, &02
    equb &05, &00, &15, &02
    equb &00, &15, &15, &00
    equb &02, &2a, &33, &22
    equb &01, &00, &11, &00
    equb &02, &02, &11, &00
.sprite_cross
    equb &00, &0f, &02, &00
    equb &00, &0f, &02, &00
    equb &00, &1f, &02, &00
    equb &3f, &1f, &0f, &02
    equb &0f, &1f, &0f, &02
    equb &0f, &1f, &0f, &02
    equb &00, &0f, &02, &00
    equb &00, &0f, &02, &00
    equb &00, &2f, &02, &00
    equb &00, &2f, &02, &00
    equb &00, &0f, &02, &00
    equb &00, &0f, &02, &00
; &0b20 used as index base 9 times by &3612, &366b, &3670, &6f22, &751a, &751d, &7526, &75c5, &75ca
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
; &0b2a referenced 3 times by &7421, &742b, &7432; also used as index base 7 times by &3cdc, &3df4, &3dfb, &549c, &589c, &7256, &725f
.returning_hero_queue
; &326b referenced 2 times by &742f, &7438
data_0b2b = returning_hero_queue+1
; &326c referenced 2 times by &7435, &743e
data_0b2c = returning_hero_queue+2
; &326d referenced 2 times by &743b, &7441
data_0b2d = returning_hero_queue+3
    equb &03, &02, &01, &04, &10
; &0b2f referenced 5 times by &3bf9, &7cb3, &7cb6, &7cbf, &7cc2
.next_trapdoor
    equb &04
; &0b30 used as index base 1 time by &76f2
.hero_appearance_sprites
    equb &16, &17, &18, &19
    equs "defgh"
    equb &10, &10, &10, &10, &10, &10, &10
; &0b40 used as index base 4 times by &3cd2, &758d, &759e, &75a6
.monster_hit_points
    equb &10, &08, &08, &08, &08, &08, &08, &08
    equb &08, &08, &08, &08, &08, &08, &08, &05
    equb &08, &08, &08, &08, &08, &08, &08, &08
    equb &08, &08, &08, &08, &08, &08, &08, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
; &0b70 used as index base 7 times by &3618, &3690, &6f4a, &756b, &756e, &7577, &75ee
.hero_missile_damage
    equb &02, &03, &09, &03, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
; &0b80 used as index base 3 times by &6f4d, &71f0, &7591
.missile_damage
; &32cf used as index base 1 time by &79cd
data_0b8f = missile_damage+15
    equb &02, &02, &02, &03, &03, &04, &09, &09
    equb &10, &03, &03, &03, &10, &10, &10, &10
; &0b90 used as index base 2 times by &3c94, &7cc5
.trapdoor_x
; &32d7 used as index base 1 time by &79d3
data_0b97 = trapdoor_x+7
    equb &0b, &15, &17, &10, &03, &17, &0d, &1a
; &0b98 used as index base 2 times by &3c9a, &7ccb
.trapdoor_y
    equb &04, &0c, &14, &1d
    equs "% (,"
; &0ba0 used as index base 5 times by &3626, &72aa, &72ad, &72b6, &72d4
.hero_score_hundreds
    equb &1e, &1e, &1e, &1e
; &0ba4 used as index base 5 times by &3629, &729b, &729e, &72a7, &72e4
.hero_score_tens
    equb &1e, &1e, &1e, &1e
; &0ba8 used as index base 8 times by &362e, &5492, &5892, &728c, &728f, &7298, &72f4, &74cf
.hero_score_units
    equb &1d, &1d, &1d, &1d
; &0bac used as index base 8 times by &3623, &51b0, &51b3, &51bc, &55b0, &55b3, &55bc, &72c8
.hero_score_thousands
    equb &1e, &1e, &1e, &1e, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10, &10, &10, &10, &10
    equb &10, &10, &10, &10
.teleport_sound
    equb &13, &00
    equb &04, &00
    equb &64, &00
    equb &1e, &00
.food_sound
; &333c referenced 2 times by &444f, &445d
data_0bfc = food_sound+4
    equb &13, &00
    equb &02, &00
    equb &c8, &00
    equb &02, &00
; &0c00 used as index base 3 times by &3ca7, &7fc8, &7feb
.room_walls
    equs "TIKP$UTHO[KF,D]/DYW3CZD\8V\;VHRVao"
    equb &02
    equs "brlu"
    equb &07, &00, &6a, &03, &0b, &1d, &14, &16
    equb &19, &10
    equs "pgtafb"
    equb &19, &71, &19
; &0c3a used as index base 1 time by &37fa
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
; &0cd0 used as index base 7 times by &361e, &365e, &74ef, &74f2, &74f9, &75bd, &79a7
.hero_damage_taken
    equb &89, &9e, &87, &f3, &95, &9b, &92, &f7
    equb &90, &98, &8a, &8b, &85, &fd, &9a, &8a
    equb &ae, &a6, &a7, &ac, &aa, &ac, &a8, &a0
    equb &c9, &00, &00, &00, &00, &00, &00, &00
.hit_sound
; &3434 referenced 2 times by &7481, &7491
data_0cf4 = hit_sound+4
    equb &10, &00
    equb &01, &00
    equb &06, &00
    equb &06, &00
    equb &12, &00, &03, &00, &c8, &00, &0a, &00
; &0d00 referenced 43 times by &4405, &4440, &448e, &4492, &4495, &4498, &44b7, &44c2, &6f19, &6f1e, &6f25, &6f71, &6fd7, &7002, &7007, &713c, &74b6, &74c3, &74d8, &77e6, &782c, &7857, &785b, &785e, &7861, &7886, &788b, &7901, &7905, &7908, &790b, &7926, &7931, &793d, &7941, &7944, &7947, &7962, &796d, &7976, &7990, &7a89, &7ce3; also used as index base 1 time by &3be5
.scratch
    equb &a9
; &0d01 referenced 6 times by &74d2, &7503, &7509, &750c, &7829, &782f
.scratch2
    equb &30
; &0d02 referenced 54 times by &38dc, &3934, &440b, &441b, &4466, &447c, &449d, &44ac, &4511, &4578, &4588, &4698, &46ea, &4716, &6fa7, &700f, &707c, &70aa, &70ee, &7120, &715b, &7176, &71e3, &7310, &732c, &733a, &73f0, &752f, &766a, &777d, &779b, &77ad, &77bf, &77d1, &7801, &7820, &7867, &7872, &787c, &789e, &78b8, &78d2, &78ec, &7910, &791d, &794c, &7959, &797b, &7997, &79d0, &79ea, &7a48, &7b07, &7b44
.cell_x
    equb &8d
; &0d03 referenced 49 times by &38e1, &3939, &4411, &4426, &4460, &4482, &4489, &44ba, &4517, &457e, &4590, &469e, &46f0, &471c, &6fad, &7017, &7082, &70b0, &70f4, &7126, &7161, &717e, &71eb, &7316, &7332, &7345, &73fc, &7535, &7670, &7783, &7807, &7852, &787f, &7890, &78a5, &78bf, &78d9, &78f3, &78fc, &7929, &7938, &7965, &7983, &799f, &79d6, &79f3, &7a4e, &7b0d, &7b4a
.cell_y
    equb &bd
; &0d04 referenced 7 times by &7864, &786c, &786f, &7896, &78b0, &78ca, &78e4
.cell_room
    equb &08, &a9
; &0d06 referenced 11 times by &6e9a, &6f56, &6fbb, &6fe5, &7021, &7069, &7079, &79ed, &7a58, &7a95, &7af8
.previous_x
    equb &20
; &0d07 referenced 11 times by &6ea0, &6f5c, &6fc1, &6feb, &7027, &706f, &707f, &79f6, &7a5e, &7a9b, &7afe
.previous_y
    equb &8d
; &0d08 referenced 2 times by &6ea6, &7085
.previous_offset_x
    equb &be
; &0d09 referenced 2 times by &6eac, &708a
.previous_offset_y
    equb &08, &a9, &00, &8d, &bc, &08, &ea
; &0d10 used as index base 29 times by &453d, &4575, &45c9, &4678, &4695, &46b4, &5497, &5897, &6e97, &6f39, &6f59, &6f87, &6f95, &6f98, &6fa4, &6fbe, &6fe8, &700c, &7024, &706c, &70a7, &71e0, &7329, &73ed, &752c, &777a, &799a, &7bbd, &7bcb
.hero_x
    equb &4c, &10, &0d, &0d, &a2
; &0d15 used as index base 26 times by &4543, &457b, &45cf, &4680, &469b, &6e9d, &6f3f, &6f5f, &6f80, &6f8e, &6f9e, &6faa, &6fc4, &6fee, &7014, &702a, &7072, &70ad, &71e8, &732f, &73f9, &7532, &7780, &79a2, &7bb6, &7bc4
.hero_y
; &3459 used as index base 1 time by &4657
data_0d19 = hero_y+4
    equb &80, &a0, &0d, &a9, &00
; &0d1a used as index base 19 times by &4526, &4692, &5480, &5880, &6e82, &6ecb, &6ede, &6ef1, &6f04, &6f2d, &6f79, &701c, &7097, &7221, &7249, &7452, &7711, &7b67, &7baf
.hero_direction
; &345f used as index base 1 time by &4663
data_0d1f = hero_direction+5
    equb &8d, &84, &0d, &8d, &85, &0d
; &0d20 referenced 2 times by &774e, &7753; also used as index base 13 times by &4533, &548a, &588a, &6f62, &6f67, &709c, &7457, &76ee, &76ff, &771f, &772e, &7ba2, &7ba7
.hero_frame
; &3461 referenced 2 times by &775b, &7760
data_0d21 = hero_frame+1
; &3462 referenced 2 times by &7768, &776d
data_0d22 = hero_frame+2
; &3463 referenced 2 times by &7771, &7776
data_0d23 = hero_frame+3
    equb &ad, &12, &02, &8d, &2f
; &0d25 used as index base 13 times by &468d, &5485, &5885, &6e87, &6eaf, &6fc9, &6ff3, &702f, &7063, &7401, &7716, &7b64, &7baa
.hero_step
    equb &0d, &ad, &13, &02, &8d
; &0d2a used as index base 19 times by &6ea3, &6fcc, &6ff6, &7032, &705d, &724e, &7404, &745c, &7702, &7719, &7735, &7b70, &7b84, &7b8e, &7b9e, &7bd0, &7bd7, &7bda, &7bdd
.hero_offset_x
    equb &30, &0d, &a9, &06, &20, &ee
; &0d30 used as index base 20 times by &6ea9, &6fcf, &6ff9, &7035, &7060, &7251, &7407, &7461, &76da, &76e2, &771c, &773a, &7b75, &7b7f, &7b93, &7b99, &7bd3, &7be1, &7be4, &7be7
.hero_offset_y
    equb &ff
; ***************************************************************************************
; Start the game
;
; Set the bell sound (the BEL character's channel, envelope, pitch and duration), save
; WRCHV in saved_wrchv and point WRCHV at wrch_handler. The code here is run once only:
; from &0D40 its bytes are then reused as the missile tables and other workspace in page
; &0D, which reset_workspace refreshes for each level.
; &0d31 referenced 1 time by &5149
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
; &34a4 used as index base 4 times by &6f53, &7209, &76b1, &7747
missile_sprite_base = sub_0d63+1
    sta wrchv                           ; ...
    lda #&7f                            ; ...
    sta wrchv + 1                       ; ...
    lda level_count_copy                ; Recover the level count Coder left in level_count_copy
    sta level_number                    ; ...as level_number
; &0d70 used as index base 1 time by &6ec1
.hero_key_up
    lda data_008f                       ; ...and level_bcd
.sub_0d72
; &34b4 used as index base 1 time by &6ed4
hero_key_down = sub_0d72+2
    sta level_bcd                       ; ...
    lda levels_started                  ; First level?
; &0d78 used as index base 1 time by &6ee7
.hero_key_right
    cmp #1
    beq code_0d7f                       ; ...
; &0d7c used as index base 1 time by &6efa
.hero_key_left
    jmp level_loop                      ; No: carry on with the heroes as they were
; &0d7f referenced 1 time by &34ba
.code_0d7f
; &34c0 used as index base 1 time by &6f0d
hero_key_fire = code_0d7f+1
    lda #0                              ; Yes: start a new game
    jmp code_0e08
    equs "eon5"
.sub_0d88
; &34cf used as index base 1 time by &465c
data_0d8f = sub_0d88+7
    equb &0d, &18, &bd, &04, &0d, &69, &03, &9d
; &0d90 used as index base 11 times by &35ad, &548f, &588f, &7236, &7239, &726f, &738e, &7391, &739a, &7506, &7724
.hero_health_tens
    equb &1d, &1d, &1d, &1d, &d0
; &0d95 used as index base 7 times by &7227, &722a, &7233, &727b, &739d, &750f, &7727
.hero_health_units
    equs "''''"
    equb &18, &bd, &08, &0d, &6d, &40, &0d
; &0da0 referenced 2 times by &779e, &7893; also used as index base 3 times by &7043, &7544, &767c
.view_room
; &34e2 referenced 2 times by &77b0, &78ad
data_0da2 = view_room+2
; &34e4 referenced 2 times by &77c2, &78c7
data_0da4 = view_room+4
; &34e6 referenced 2 times by &77d4, &78e1
data_0da6 = view_room+6
    equb &18, &0c, &68, &0c, &28, &0c, &30, &0c
    equb &00, &00, &bd, &04, &0d, &85, &71, &8a
; &0db0 used as index base 1 time by &6f50
.hero_missile_sprites
    equb &10
    equs "DLHh"
; &0db5 used as index base 3 times by &470b, &473d, &709f
.hero_sprites
    equb &00
    equs ",4<"
    equb &00, &0d, &d9
; &0dbc used as index base 3 times by &7056, &7351, &74e7
.hero_has_boots
    equb &00, &00, &00, &00
; &0dc0 used as index base 3 times by &44b2, &7923, &795f
.bit_masks
    equb &80, &40, &20, &10, &08, &04, &02, &01
    equb &b9, &30, &0d, &9d, &08, &0d, &4c, &d4
; &0dd0 used as index base 9 times by &44dc, &4552, &45ad, &7266, &72bd, &75af, &75cf, &75e7, &75fe
.hero_panel_y
    equb &0e, &3c, &6a, &98, &e8, &e0, &04, &d0
    equb &0a, &a2, &00, &ad, &40, &0d, &49, &01
    equb &8d, &40, &0d, &8e, &ff, &0d, &68, &a8
    equb &68, &aa
    equs "h(`"
.sub_0ded
; &353d referenced 1 time by &73d3
data_0dfd = sub_0ded+16
; &353f referenced 1 time by &38a0
data_0dff = sub_0ded+18
    equb &de, &dd, &df, &f0, &f2, &f1, &f3, &f8
    equb &fa, &f9, &fb, &f4, &f6, &f5, &f7, &fc
    equb &1e, &fd, &00, &a9, &00, &8d, &9f, &16
    equb &8d, &ff, &16
; &0e08 referenced 1 time by &34c1
.code_0e08
    tax
; &0e09 referenced 1 time by &354f
.code_0e09
    jsr reset_hero
    inx
    cpx #4
    bne code_0e09
    jsr hero_menu
; &0e14 referenced 1 time by &34bc
.level_loop
    lda levels_started                  ; Monster hit points = 6 + 2 x levels started...
    asl a
    clc
    adc #6
    sta monster_start_hit_points
    jmp code_0e57                       ; ...and play the level
    equb &ff, &16, &69, &01, &8d, &ff, &16, &d8
    equb &ad, &9f, &16, &c9, &09, &b0, &04, &a2
    equb &00, &f0, &02, &a2, &01, &ad, &ff, &16
    equb &29, &0f, &18, &69, &30, &9d, &d5, &16
    equb &e0, &00, &f0, &0d
; &0e45 referenced 1 time by &35c4
.code_0e45
    jmp next_level_by_reset             ; Next level: reset the machine and run Coder
    equs "JJJJ"
    equb &18, &69, &30, &8d, &d5, &16, &a9, &0d
    equb &9d, &d6, &16
; &0e57 referenced 1 time by &355e
.code_0e57
    jsr start_level                     ; Load and draw the level
    jsr draw_status_panel               ; Draw the status panel
    jsr remove_absent_heroes            ; Take out the heroes nobody plays
    lda #1                              ; Let one vertical sync pass before play starts
    sta os_vsync_counter                ; ...
    jsr play_level                      ; Play the level until it ends
    ldx #0                              ; Count the heroes who died, giving each back their starting attributes
    stx count                           ; ...
; &0e6d referenced 1 time by &35bd
.code_0e6d
    lda hero_health_tens,x              ; Dead?
    cmp #&1d                            ; ...
    bne code_0e7a                       ; ...
    jsr reset_hero                      ; Yes: reset them
    inc count                           ; ...and count them
; &0e7a referenced 1 time by &35b2
.code_0e7a
    inx                                 ; Next hero
    cpx #4                              ; ...
    bne code_0e6d                       ; ...
    lda count                           ; Any hero alive?
    cmp #4                              ; ...
    bne code_0e45                       ; Yes: on to the next level
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
; &0ea8 referenced 1 time by &35ec
.code_0ea8
    sta data_0ff0,x                     ; ...
    dex                                 ; ...
    bne code_0ea8                       ; ...
; &0eae referenced 1 time by &35f7
.code_0eae
    lda game_over_message,x             ; Print game_over_message...
    jsr osasci                          ; ...
    inx                                 ; ...
    cmp #0                              ; ...up to its zero byte
    bne code_0eae                       ; ...
; &0eb9 referenced 1 time by &35fc
.code_0eb9
    lda os_vsync_counter                ; Wait for the vertical sync counter to run out
    bne code_0eb9                       ; ...
    lda #osbyte_flush_buffer_class      ; Flush the input buffers
    jsr osbyte                          ; ...  Flush selected class of buffer
    ldx #&46 ; 'F'                      ; Wait up to &246 centiseconds for a key...
    ldy #2
    lda #osbyte_inkey
    jsr osbyte                          ; INKEY: Scan for a key with positive X, or read internal key number EOR 128 for negative X
    jmp restart_by_reset                ; ...then restart the game by resetting the machine
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
; &0ecf referenced 2 times by &3549, &35b4
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
; &0ef7 referenced 1 time by &359a
.draw_status_panel
    lda #0                              ; For each hero...
    sta panel_hero                      ; ...
; &0efc referenced 1 time by &36a5
.code_0efc
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
; &0f3a referenced 1 time by &368b
.code_0f3a
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
    bcc code_0f3a                       ; ...
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
    bne code_0efc                       ; ...
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
; &0f68 referenced 5 times by &364c, &3655, &3665, &3680, &369a
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
; &0f80 used as index base 1 time by &360f
.hero_start_max_missiles
    equb &03, &02, &01, &02
; &0f84 used as index base 1 time by &3615
.hero_start_missile_damage
    equb &02, &03, &09, &05
; &0f88 used as index base 1 time by &361b
.hero_start_damage_taken
    equb &07, &09, &06, &04
; &0f8c used as index base 1 time by &3645
.hero_faces
    equb &05, &31, &39, &41
; ***************************************************************************************
; Game-over message
;
; Eleven lines of seventeen characters, each ended by a carriage return, then a line feed
; and a last line ended by a zero byte. Two bytes of it (&0FF1, &0FF2) double as
; counters, and are overwritten with spaces before printing, so the full stop after "YOU
; ALL" never appears.
; &0f90 used as index base 1 time by &35ee
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
; &3730 used as index base 1 time by &35e8
data_0ff0 = sub_0fea+6
; &3731 referenced 8 times by &3639, &363c, &3658, &3668, &368d, &369d, &36a0, &36ad
panel_hero = sub_0fea+7
; &3732 referenced 5 times by &35aa, &35b7, &35bf, &3675, &3688
count = sub_0fea+8
    equs "YOU ALL.         "
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
    equb &0d
    equb &0a
    equs "FIND THE CHALICE!"
    equb &00
    equs "ND!"
    equb &00
    equs "&C2"
; ***************************************************************************************
; Check whether the Chalice has been found
;
; On level 25, if a hero stands on the cell where the Chalice is, play the victory
; sequence, print the ending message, wait for a key and reset the machine through the
; RESET vector. The message is not part of the program: it is the 140 bytes at room_walls
; + &3A followed by the string at object_free_map + &3A, which on level 25 hold the
; ending text instead of map data.
; &1070 referenced 1 time by &464a
.check_for_victory
    lda level_number
    cmp #&19
    bne return_2
    ldx #0
; &1079 referenced 1 time by &37c7
.code_1079
    lda hero_door_x,x
    cmp #&1a
    beq code_108a
    cmp #&1b
    beq code_108a
; &1084 referenced 1 time by &37d5
.code_1084
    inx
    cpx #4
    bne code_1079
; &1089 referenced 1 time by &37b5
.return_2
    rts
; &108a referenced 2 times by &37be, &37c2
.code_108a
    lda hero_door_y,x
    cmp #4
    beq code_1097
    cmp #5
    beq code_1097
    bne code_1084
; &1097 referenced 2 times by &37cf, &37d3
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
; &10ba referenced 1 time by &3803
.code_10ba
    lda data_0c3a,x
    jsr osasci
    inx
    cpx #&8c
    bne code_10ba
    ldx #0
; &10c7 referenced 1 time by &3810
.code_10c7
    lda data_213a,x
    jsr osasci
    inx
    cmp #0
    bne code_10c7
    lda #osbyte_flush_buffer_class
    jsr osbyte                          ; Flush selected class of buffer
    jsr osrdch
    lda data_fffc
    sta data_10e7
    lda data_fffd
    sta data_10e8
.sub_10e6
; &3827 referenced 1 time by &381d
data_10e7 = sub_10e6+1
; &3828 referenced 1 time by &3823
data_10e8 = sub_10e6+2
    jsr data_0000
; ***************************************************************************************
; Play the victory sequence
;
; Spin sprites round the Chalice with a rising tone, then dissolve it.
; &10e9 referenced 1 time by &37d7
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
    sta level_count_copy
    lda #1
    sta data_008d
; &110a referenced 1 time by &3886
.code_110a
    clc
    lda data_008f
    adc data_008d
    sta data_008f
    bcc code_111c
    inc data_008d
    dec level_count_copy
    bne code_111c
    jmp code_11d3
; &111c referenced 2 times by &3851, &3857
.code_111c
    dec data_0084
    bne code_1124
    lda #1
    sta data_0084
; &1124 referenced 1 time by &385e
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
; &113c referenced 1 time by &3877
.code_113c
    ldx data_0084
; &113e referenced 1 time by &3884
.code_113e
    ldy #&ff
; &1140 referenced 1 time by &3881
.code_1140
    dey
    bne code_1140
    dex
    bne code_113e
    jmp code_110a
; ***************************************************************************************
; Draw the ring of sprites round the Chalice
;
; Plot the current victory sprite at the twelve cells round the Chalice, changing sprite
; as it goes.
; &1149 referenced 2 times by &3870, &3917
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
; &119a referenced 12 times by &3891, &3896, &389b, &38a8, &38ad, &38b2, &38ba, &38bf, &38c4, &38cc, &38d1, &38d6
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
; &11ac referenced 3 times by &38a3, &38b5, &38c7
.next_victory_sprite
    lda data_0082
    cmp #&15
    beq code_11bb
    clc
    adc #1
    cmp #&1a
    bne code_11bb
    lda #&16
; &11bb referenced 2 times by &38f0, &38f7
.code_11bb
    sta data_0082
    rts
; ***************************************************************************************
; Clear a random byte of the Chalice
;
; Use the System VIA timer to pick a byte of the Chalice sprite, clear it, and redraw the
; Chalice.
; &11be referenced 1 time by &3879
.dissolve_chalice
    lda system_via_t1c_l
    eor data_00fc
    eor data_00fa
    cmp #&c0
    bcs return_3
    tax
    lda #0
    sta sprite_chalice,x
    jsr plot_chalice
; &11d2 referenced 1 time by &3907
.return_3
    rts
; &11d3 referenced 1 time by &3859
.code_11d3
    lda #&15
    sta data_0082
    jsr draw_victory_ring
    ldx #&c1
    lda #0
; &11de referenced 1 time by &3922
.code_11de
    sta data_120f,x
    dex
    bne code_11de
    jsr plot_chalice
    lda #&ff
    sta os_vsync_counter
; &11ec referenced 1 time by &392f
.code_11ec
    lda os_vsync_counter
    bne code_11ec
    rts
; ***************************************************************************************
; Plot the Chalice
;
; Plot the Chalice sprite at its place on the map.
; &11f2 referenced 2 times by &390f, &3924
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
; &394f used as index base 1 time by &391e
data_120f = sub_1204+11
    equs "Rx`(&1900+F%"
; &1210 used as index base 1 time by &390c
.sprite_chalice
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
; &12d3 referenced 2 times by &3498, &3c17
.saved_wrchv
; &3a14 referenced 2 times by &349e, &3c1d
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
; &1400 referenced 1 time by &3597
.start_level
    jsr sub_15b1                        ; Show the level number
    jsr check_level                     ; Load the level
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
; Check the level and set the text window
;
; Decrypt and check the level (Coder has already loaded it), and set the bottom row used
; by clear_text_area.
; &1446 referenced 1 time by &3b43
.check_level
    jsr decrypt_level
    lda #&18
    sta data_1625
    rts
; ***************************************************************************************
; Restart the game by resetting the machine
;
; Set the BREAK intercept to restart_intercept and reset the machine.
; &144f referenced 1 time by &360c
.restart_by_reset
    lda #&72 ; 'r'                      ; BREAK intercept = JMP restart_intercept...
    sta data_0288
    lda #&14
    sta data_0289
    lda #&4c ; 'L'
    sta os_break_intercept
    bne code_146f                       ; ...and reset (always branches)
; ***************************************************************************************
; Move on to the next level by resetting the machine
;
; Set the BREAK intercept to next_level_intercept and jump to the MOS 1.20 reset entry.
; &1460 referenced 1 time by &3585
.next_level_by_reset
    lda #&4c ; 'L'                      ; BREAK intercept = JMP next_level_intercept...
    sta os_break_intercept
    lda #&b5
    sta data_0288
    lda #&15
    sta data_0289
; &146f referenced 1 time by &3b9e
.code_146f
    jmp mos_reset_entry                 ; Reset the machine
; ***************************************************************************************
; BREAK intercept: reload the game
;
; Called by the MOS during the reset. On the second call (carry set) clear the screen and
; issue *DISC and *DUNJUNZ.
;
; On Entry:
;     C: set on the second call, after the filing system is initialised
.restart_intercept
    bcc return_4
    lda #&0c
    jsr oswrch
    ldx #&89
    ldy #&14
    jsr oscli
    ldx #&8e
    ldy #&14
    jsr oscli
; &1487 referenced 1 time by &3bb2
.return_4
    rts
    equs "CDISC"
    equb &0d
    equs "DUNJUNZ"
    equb &0d, &9c, &14, &a9, &ff, &20, &00
    equs "0LP"
    equb &04
; ***************************************************************************************
; Reset the game workspace for a new level
;
; Copy workspace_template into page &0D and clear the per-level state.
; &14a0 referenced 1 time by &3b49
.reset_workspace
    ldx #0                              ; Copy workspace_template to page &0D
; &14a2 referenced 1 time by &3be9
.code_14a2
    lda workspace_template,x            ; ...
    sta scratch,x                       ; ...
    inx                                 ; ...
    bne code_14a2                       ; ...
    lda #0                              ; Reset the exit and other per-level state
    sta exit_busy
    sta data_09f9
    sta exit_offsets_y
    sta data_09fe
    sta next_trapdoor                   ; First monster emerges from trapdoor 0
    lda #1
    sta data_09f7
    sta data_09f8
    sta data_09fd
    lda #&ff
    sta shrunk_hero
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
; &14d7 referenced 1 time by &3b82
.draw_view_frames
    lda saved_wrchv                     ; Restore the MOS's own WRCHV for the PLOT commands...
    sta wrchv                           ; ...
    lda data_12d4                       ; ...
    sta wrchv + 1                       ; ...
    ldx #&14                            ; Twenty PLOT commands
; &14e5 referenced 1 time by &3c40
.code_14e5
    lda #&19                            ; VDU 25...
    jsr oswrch                          ; ...
    ldy #0                              ; ...then the five bytes of the command
; &14ec referenced 1 time by &3c34
.code_14ec
    lda (plot_x),y                      ; ...
    jsr oswrch                          ; ...
    iny                                 ; ...
    cpy #5                              ; ...
    bne code_14ec                       ; ...
    clc                                 ; Next command
    lda plot_x                          ; ...
    adc #5                              ; ...
    sta plot_x                          ; ...
    ldy #0                              ; ...
    dex                                 ; ...
    bne code_14e5                       ; ...
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
; &1510 referenced 1 time by &3b46
.unpack_level
    ldx #&1e                            ; Objects 30 to 1: position and type
; &1512 referenced 1 time by &3c65
.code_1512
    lda level_object_x,x
    sta object_x,x
    lda level_object_y,x
    sta object_y,x
    lda level_object_type,x
    sta object_type,x
    dex                                 ; ...
    bne code_1512                       ; ...
    ldx #&14                            ; Doors 20 to 1: position and sprite
; &1529 referenced 1 time by &3c7c
.code_1529
    lda level_door_x,x
    sta door_x,x
    lda level_door_y,x
    sta door_y,x
    lda level_door_sprite,x
    sta door_sprite,x
    dex                                 ; ...
    bne code_1529                       ; ...
    ldx #&14                            ; Keys 20 to 1: position
; &1540 referenced 1 time by &3c8d
.code_1540
    lda level_key_x,x
    sta key_x,x
    lda level_key_y,x
    sta key_y,x
    dex                                 ; ...
    bne code_1540                       ; ...
    ldx #0                              ; Trapdoors 0 to 7: position
; &1551 referenced 1 time by &3ca0
.code_1551
    lda level_trapdoor_x,x
    sta trapdoor_x,x
    lda level_trapdoor_y,x
    sta trapdoor_y,x
    inx                                 ; ...
    cpx #8                              ; ...
    bne code_1551                       ; ...
    ldx #0                              ; Wall map and object-free map, &C9 bytes each
; &1564 referenced 1 time by &3cb3
.code_1564
    lda level_walls,x
    sta room_walls,x
    lda level_object_free_map,x
    sta object_free_map,x
    inx                                 ; ...
    cpx #&c9                            ; ...
    bne code_1564                       ; ...
    ldx #0                              ; The level's wall sprite, &30 bytes
; &1577 referenced 1 time by &3cc0
.code_1577
    lda level_wall_sprite,x
    sta wall_sprite,x
    inx                                 ; ...
    cpx #&30 ; '0'                      ; ...
    bne code_1577                       ; ...
    rts                                 ; Return
; ***************************************************************************************
; Clear the monsters for a new level
;
; Mark every monster as not yet appeared, give each the level's starting hit points, and
; clear the heroes' keys and the returning_hero_queue.
; &1583 referenced 1 time by &3b4c
.reset_monsters
    ldx #&1e                            ; Monsters 30 to 1...
; &1585 referenced 1 time by &3cd6
.code_1585
    lda #&15                            ; ...dying, so that they emerge from the trapdoors...
    sta monster_sprite,x                ; ...
    lda #&ff                            ; ...off the map...
    sta monster_x,x                     ; ...
    lda monster_start_hit_points        ; ...with this level's hit points
    sta monster_hit_points,x            ; ...
    dex                                 ; ...
    bne code_1585                       ; ...
    ldx #0                              ; For each hero: clear the returning queue, the key carried and the door-check position
    lda #0
; &159c referenced 1 time by &3cee
.code_159c
    sta returning_hero_queue,x
    sta hero_key,x
    sta hero_key_dropped,x
    sta hero_door_x,x
    sta hero_door_y,x
    inx                                 ; ...
    cpx #4                              ; ...
    bne code_159c                       ; ...
    rts                                 ; Return
; &15b1 referenced 1 time by &3b40
.sub_15b1
    jsr clear_text_area
    rts
; ***************************************************************************************
; BREAK intercept: run Coder for the next level
;
; Called by the MOS during the reset. On the second call (carry set) select MODE 2 and
; issue *DISC and *RUN CODER.
;
; On Entry:
;     C: set on the second call, after the filing system is initialised
.next_level_intercept
    bcc return_5
    lda #&16
    jsr oswrch
    lda #2
    jsr oswrch
    ldx #&e0
    ldy #&15
    jsr oscli
    ldx #&e5
    ldy #&15
    jsr oscli
; &15cf referenced 1 time by &3cf5
.return_5
    rts
    equb &f7, &ff, &a2, &e5, &a0, &15, &20, &f7
    equb &ff
    equs "`ODER"
    equb &0d, &ad
    equs "DISC"
    equb &0d
    equs "RUN CODER"
    equb &0d, &0f, &18
    equs "i0 "
    equb &ee, &ff, &a9, &1c, &20, &ee, &ff, &a9
    equb &01, &20, &ee, &ff, &a9, &16, &20, &ee
    equb &ff, &a9, &0e, &20, &ee, &ff, &a9, &11
    equb &20, &ee, &ff, &a9, &11, &20, &ee, &ff
    equb &a9, &02, &20, &ee, &ff, &60
; ***************************************************************************************
; Clear the left of the screen
;
; Set a text window over the left of the screen and clear it.
; &161a referenced 2 times by &3b4f, &3cf1
.clear_text_area
    lda #&1c
    jsr oswrch
    lda #0
    jsr oswrch
.sub_1624
; &3d65 referenced 1 time by &3b8b
data_1625 = sub_1624+1
    lda #&16
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
; &169f referenced 5 times by &34ad, &37b0, &507a, &5227, &5627
.level_number
    equb &01
; ***************************************************************************************
; Sound the exit and add a queue marker
;
; Play the exit sound and put a &64 entry in the first free slot of returning_hero_queue.
.queue_exit_marker
    ldx #<(exit_envelope)
    ldy #>(exit_envelope)
    lda #osword_envelope
    jsr osword                          ; ENVELOPE command
    ldx #<(exit_sound)
    ldy #>(exit_sound)
    lda #osword_sound
    jsr osword                          ; SOUND command
    ldx #0
; &16b4 referenced 1 time by &3e00
.code_16b4
    lda returning_hero_queue,x
    bne code_16bf
    lda #&64 ; 'd'
    sta returning_hero_queue,x
    rts
; &16bf referenced 1 time by &3df7
.code_16bf
    inx
    bne code_16b4
    equb &02, &02, &00, &00, &83, &00, &00, &00
    equb &00, &00, &00, &31, &00, &8d
    equs "LEVEL1"
    equb &0d, &0d, &70, &00, &8d, &35, &f8, &00
    equb &00, &00, &00
    equs "code"
    equb &00, &54, &12, &03, &17, &74, &00, &8c
    equb &50, &00, &00, &00, &fa, &16, &78, &00
    equb &8c, &50, &20, &00, &00, &02, &00, &79
    equb &00, &8c
; &16ff referenced 1 time by &34b2
.level_bcd
    equb &01
.sprite_sword_up
    equb &00, &00, &00, &00
    equb &00, &15, &00, &00
    equb &00, &15, &00, &00
    equb &00, &15, &00, &00
    equb &00, &15, &00, &00
    equb &00, &15, &00, &00
    equb &00, &15, &00, &00
    equb &00, &15, &00, &00
    equb &00, &03, &02, &00
    equb &00, &01, &00, &00
    equb &00, &01, &00, &00
    equb &00, &00, &00, &00
.sprite_sword_right
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &01, &00, &00
    equb &01, &03, &3f, &3f
    equb &00, &01, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
.sprite_sword_down
    equb &00, &00, &00, &00
    equb &00, &00, &02, &00
    equb &00, &00, &02, &00
    equb &00, &01, &03, &00
    equb &00, &00, &2a, &00
    equb &00, &00, &2a, &00
    equb &00, &00, &2a, &00
    equb &00, &00, &2a, &00
    equb &00, &00, &2a, &00
    equb &00, &00, &2a, &00
    equb &00, &00, &2a, &00
    equb &00, &00, &00, &00
.sprite_sword_left
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &02, &00
    equb &3f, &3f, &03, &02
    equb &00, &00, &02, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &80, &00, &00, &32, &00
    equs "eco"
    equb &00, &8e, &0b, &94, &00, &00
    equs "?&A66=(rx%-lx%)"
    equb &81
    equs "2+1:sprite%?&A99=by%-ty%+1"
    equb &0d, &03, &d4, &1d, &20, &d4, &31, &2c
.sprite_shield
    equb &3f, &3f, &3e
    equb &2a, &00, &14
    equb &2a, &00, &14
    equb &2a, &00, &14
    equb &2a, &00, &14
    equb &2a, &00, &14
    equb &2a, &00, &14
    equb &2a, &00, &14
    equb &15, &00, &28
    equb &15, &00, &28
    equb &00, &3e, &00
    equb &00, &3e, &00
.sprite_small_digit_1
    equb &01
    equb &01
    equb &01
    equb &01
    equb &01
.sprite_small_digit_2
    equb &03
    equb &01
    equb &03
    equb &02
    equb &03
.sprite_small_digit_3
    equb &03
    equb &01
    equb &03
    equb &01
    equb &03
.sprite_small_digit_4
    equb &02
    equb &02
    equb &03
    equb &03
    equb &01
.sprite_small_digit_5
    equb &03
    equb &02
    equb &03
    equb &01
    equb &03
.sprite_small_digit_6
    equb &02
    equb &02
    equb &03
    equb &03
    equb &03
.sprite_small_digit_7
    equb &03
    equb &01
    equb &01
    equb &01
    equb &01
.sprite_small_digit_8
    equb &03
    equb &03
    equb &03
    equb &03
    equb &03
.sprite_small_digit_9
    equb &03
    equb &03
    equb &03
    equb &01
    equb &01
    equb &0a, &00, &05, &00, &00, &00, &0a, &00
    equb &05, &00, &00, &00, &0a, &00, &05
.sprite_missile_icon
    equb &00, &00, &01, &00
    equb &3f, &3f, &2b, &03
    equb &00, &00, &01, &00
.sprite_boots_icon
    equb &00, &05
    equb &00, &0a
    equb &05, &00
    equb &00, &0a
    equb &05, &00
    equb &0a, &00
.sprite_level_word
    equb &3c, &00, &14, &3c, &28, &28, &14, &14, &3c, &28, &3c, &00
    equb &3c, &00, &14, &00, &00, &28, &14, &14, &00, &00, &3c, &00
    equb &3c, &00, &14, &3c, &28, &3c, &3c, &14, &3c, &28, &3c, &00
    equb &3c, &3c, &14, &00, &00, &3c, &3c, &14, &00, &00, &3c, &3c
    equb &3c, &3c, &14, &3c, &28, &3c, &3c, &14, &3c, &28, &3c, &3c
    equb &3c, &3c, &14, &3c, &28, &14, &28, &14, &3c, &28, &3c, &3c
    equb &3c, &3c, &14, &3c, &28, &14, &28, &14, &3c, &28, &3c, &3c
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &08, &00, &04, &00, &00, &00, &08, &04
    equb &00, &00, &08, &00, &0c, &0c, &04, &0c
    equb &08, &00, &08, &04, &0c, &08, &0c, &0c
    equb &1a, &35, &03, &8f, &7d, &9a, &82, &03
    equb &00, &00, &00, &6d, &19, &00, &00, &00
.magic_envelope
    equb &03, &01, &0a, &0a, &ec, &03, &03, &03, &80, &00, &00, &ff, &80, &80
.magic_sound
    equb &12, &00
    equb &03, &00
    equb &00, &00
    equb &02, &00
.treasure_envelope
    equb &03, &02, &01, &01, &01, &01, &01, &01, &80, &00, &00, &f8, &80, &80
.treasure_sound
    equb &12, &00
    equb &03, &00
    equb &c8, &00
    equb &05, &00
.pickup_envelope
    equb &03, &80, &00, &00, &00, &0a, &0a, &0a, &0a, &00, &00, &fd, &80, &80
.pickup_sound
    equb &10, &00
    equb &03, &00
    equb &0a, &00
    equb &05, &00
.key_envelope
    equb &03, &80, &00, &00, &00, &01, &1e, &1e, &80, &00, &00, &fe, &80, &80
.key_sound
    equb &12, &00
    equb &03, &00
    equb &f0, &00
    equb &01, &00
.exit_envelope
    equb &03, &82, &ff, &ff, &fe, &01, &01, &80, &80, &00, &00, &ff, &80, &80
.exit_sound
    equb &12, &00
    equb &03, &00
    equb &fa, &00
    equb &01, &00
    equb &00, &00, &00, &00, &04
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
    equb &35, &00
.sprite_ranger_left_1
    equb &00, &01, &03, &00
    equb &01, &0b, &08, &00
    equb &01, &0e, &0c, &00
    equb &03, &06, &3c, &00
    equb &02, &03, &25, &28
    equb &02, &05, &0f, &3c
    equb &02, &05, &0f, &3c
    equb &02, &00, &25, &29
    equb &00, &00, &3c, &09
    equb &00, &0a, &0c, &09
    equb &00, &0e, &0c, &00
    equb &00, &04, &00, &00
.sprite_skull_0
    equb &00, &00, &00, &00
    equb &00, &3f, &00, &00
    equb &00, &00, &00, &00
    equb &15, &15, &2a, &2a
    equb &2a, &3f, &3f, &15
    equb &2a, &3f, &3f, &15
    equb &2a, &35, &3a, &15
    equb &2a, &15, &2a, &15
    equb &2a, &00, &00, &2a
    equb &2a, &00, &3f, &2a
    equb &15, &00, &00, &2a
    equb &15, &00, &00, &00
.sprite_skull_1
    equb &15, &2a, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &15, &15, &2a, &2a
    equb &2a, &3f, &3f, &2a
    equb &2a, &35, &3a, &15
    equb &2a, &35, &3a, &15
    equb &2a, &3f, &3f, &15
    equb &00, &00, &00, &00
    equb &00, &00, &00, &2a
    equb &2a, &00, &00, &2a
    equb &15, &15, &2a, &2a
.sprite_skull_2
    equb &00, &00, &00, &00
    equb &00, &2a, &00, &00
    equb &15, &00, &00, &00
    equb &2a, &3f, &3f, &00
    equb &00, &35, &35, &00
    equb &15, &35, &35, &00
    equb &15, &3f, &3f, &00
    equb &15, &3a, &20, &15
    equb &15, &00, &00, &15
    equb &00, &2a, &00, &3f
    equb &2a, &15, &15, &15
    equb &15, &00, &2a, &00
.sprite_skull_3
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &15, &00, &00
    equb &00, &3f, &2a, &00
    equb &00, &35, &20, &00
    equb &15, &35, &20, &2a
    equb &3f, &3f, &3f, &00
    equb &15, &3a, &2a, &15
    equb &15, &00, &00, &2a
    equb &15, &2a, &15, &00
    equb &15, &3f, &2a, &00
    equb &2a, &15, &3f, &2a
.sprite_skull_4
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &15, &3f, &00
    equb &00, &10, &3a, &00
    equb &00, &10, &3a, &00
    equb &00, &15, &3f, &15
    equb &2a, &3f, &35, &2a
    equb &15, &2a, &2a, &00
    equb &00, &3f, &3f, &2a
    equb &3f, &15, &2a, &15
; ***************************************************************************************
; Sprite tables
;
; Four tables of 120 entries, indexed by sprite number: data address low bytes, high
; bytes, widths in bytes and heights in rows.
; &1ae0 used as index base 1 time by &3042
.sprite_addr_lo
    equb &00, &30, &60, &90, &c0, &f0, &20, &50
    equb &c0, &80, &b0, &e0, &10, &40, &70, &a0
    equb &d0, &00, &30, &60, &90, &cf, &00, &30
    equb &60, &90, &cf, &00, &c0, &c8, &00, &14
    equb &28, &3c, &50, &64, &78, &8c, &a0, &b4
    equb &30, &60, &f0, &c0, &c0, &00, &30, &60
    equb &90, &c0, &f0, &20, &50, &80, &b0, &e0
    equb &10, &40, &70, &a0, &d0, &00, &30, &60
    equb &90, &c0, &f0, &20, &50, &80, &b0, &e0
    equb &10, &00, &30, &60, &90, &40, &70, &a0
    equb &d0, &a0, &d0, &d0, &d0, &d0, &d0, &d0
    equb &d0, &d0, &d0, &d0, &d0, &d0, &d0, &00
    equb &30, &60, &c0, &90, &f0, &20, &50, &80
    equb &b0, &00, &24, &29, &2e, &33, &38, &3d
    equb &42, &47, &4c, &10, &60, &6c, &78, &cf
; &1b58 used as index base 1 time by &3047
.sprite_addr_hi
    equb &2d, &2d, &2d, &2d, &2d, &2d, &2e, &2e
    equb &19, &2e, &2e, &2e, &2f, &2f, &2f, &2f
    equb &2f, &2c, &2c, &2c, &2c, &04, &2b, &2b
    equb &2b, &2b, &04, &29, &2c, &2a, &2a, &2a
    equb &2a, &2a, &2a, &2a, &2a, &2a, &2a, &2a
    equb &29, &29, &0a, &29, &2b, &23, &23, &23
    equb &23, &23, &23, &24, &24, &24, &24, &24
    equb &25, &25, &25, &25, &25, &26, &26, &26
    equb &26, &26, &26, &27, &27, &27, &27, &27
    equb &28, &17, &17, &17, &17, &28, &28, &28
    equb &28, &22, &22, &21, &21, &21, &21, &21
    equb &21, &21, &21, &21, &21, &21, &21, &0a
    equb &0a, &0a, &0a, &0a, &19, &1a, &1a, &1a
    equb &1a, &18, &18, &18, &18, &18, &18, &18
    equb &18, &18, &18, &12, &18, &18, &18, &04
; &1bd0 used as index base 1 time by &304c
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
; &1c48 used as index base 1 time by &3051
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
; &1cc0 referenced 1 time by &464d
.update_game
    jsr move_heroes                     ; Move the heroes
    ldx #0                              ; For each hero...
; &1cc5 referenced 1 time by &44ff
.code_1cc5
    stx scratch                         ; ...look for a door at the cell the hero is moving into
    lda hero_door_x,x                   ; ...
    sta cell_x                          ; ...
    lda hero_door_y,x                   ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    ldx #&14                            ; Doors 20 to 1
; &1cd8 referenced 1 time by &44f5
.code_1cd8
    lda door_x,x                        ; This door's x?
    cmp cell_x                          ; ...
    beq code_1ce3                       ; ...
    jmp code_1db2                       ; No: next door
; &1ce3 referenced 1 time by &441e
.code_1ce3
    lda door_y,x                        ; ...and y?
    cmp cell_y                          ; ...
    beq code_1cee                       ; ...
    jmp code_1db2                       ; No: next door
; &1cee referenced 1 time by &4429
.code_1cee
    pla                                 ; Does the hero carry this door's key?
    tay                                 ; ...
    pha                                 ; ...
    txa                                 ; ...
    cmp hero_key,y                      ; ...
    beq code_1cfa                       ; Yes
    jmp code_1db2                       ; No: next door
; &1cfa referenced 1 time by &4435
.code_1cfa
    txa                                 ; Open the door: 7 points...
    pha                                 ; ...
    tya                                 ; ...
    pha                                 ; ...
    ldy #7                              ; ...
    ldx scratch                         ; ...
; &1d03 referenced 1 time by &444b
.code_1d03
    tya                                 ; ...
    pha                                 ; ...
    jsr add_point                       ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    bne code_1d03                       ; ...
    lda #&96                            ; ...play the food sound at a lower pitch...
    sta data_0bfc                       ; ...
    ldx #<(food_sound)                  ; ...
    ldy #>(food_sound)                  ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; ...  SOUND command
    lda #&c8                            ; ...and put its pitch back
    sta data_0bfc                       ; ...
    lda cell_y                          ; Keep the door's cell in spare bytes beyond the monster tables, as plot_at_cell changes cell_x and cell_y...
    sta data_7e4c                       ; ...
    lda cell_x                          ; ...
    sta data_7e23                       ; ...
    lda #&15                            ; ...erase the door...
    sta sprite_number                   ; ...
    lda #0                              ; ...
    sta data_007d                       ; ...
    sta data_007e                       ; ...
    jsr plot_at_cell                    ; ...
    lda data_7e23                       ; ...and recover its cell
    sta cell_x                          ; ...
    lda data_7e4c                       ; ...
    sta cell_y                          ; ...
    pla                                 ; ...
    tay                                 ; ...
    pla                                 ; ...
    tax                                 ; ...
    lda cell_y                          ; Clear the door's wall bit: room offset...
    and #&f8                            ; ...
    sta scratch                         ; ...
    clc                                 ; ...
    adc scratch                         ; ...
    adc scratch                         ; ...
    adc scratch                         ; ...
    sta data_007b                       ; ...
    lda cell_x                          ; ...
    and #&f8                            ; ...
    adc data_007b                       ; ...
    sta data_007b                       ; ...
    lda #&0c                            ; ...in room_walls...
    sta data_007c                       ; ...
    txa                                 ; ...
    pha                                 ; ...
    lda cell_x                          ; ...mask for the column...
    and #7                              ; ...
    tax                                 ; ...
    lda bit_masks,x                     ; ...
    eor #&ff                            ; ...
    sta scratch                         ; ...
    lda cell_y                          ; ...byte for the row...
    and #7                              ; ...
    tay                                 ; ...
    lda (data_007b),y                   ; ...clear the bit
    and scratch                         ; ...
    sta (data_007b),y                   ; ...
    pla                                 ; ...
    tax                                 ; ...
    lda #&ff                            ; Remove the door...
    sta door_x,x                        ; ...
    sta door_y,x                        ; ...
    pla                                 ; ...
    tax                                 ; ...
    lda #0                              ; ...and the key, which is used up
    sta hero_key,x                      ; ...
    lda #&1a                            ; Erase the key icon from the panel
    sta sprite_number                   ; ...
    lda hero_panel_y,x                  ; ...
    sec                                 ; ...
    sbc #&0d                            ; ...
    sta plot_y                          ; ...
    lda #&4a ; 'J'                      ; ...
    sta plot_x                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_sprite                     ; ...
    pla                                 ; ...
    tax                                 ; ...
    jmp code_1dba                       ; Next hero
; &1db2 referenced 3 times by &4420, &442b, &4437
.code_1db2
    dex                                 ; Next door
    beq code_1db8                       ; ...
    jmp code_1cd8                       ; ...
; &1db8 referenced 1 time by &44f3
.code_1db8
    pla                                 ; ...
    tax                                 ; ...
; &1dba referenced 1 time by &44ef
.code_1dba
    inx                                 ; Next hero
    cpx #4                              ; ...
    beq draw_keys                       ; ...
    jmp code_1cc5                       ; ...
; &1dc2 referenced 1 time by &44fd
.draw_keys
    lda #0                              ; Draw the keys on the floor, 20 to 1
    sta data_007d                       ; ...
    sta data_007e                       ; ...
    lda #&1b                            ; ...
    sta sprite_number                   ; ...
    ldx #&14                            ; ...
; &1dce referenced 1 time by &4522
.code_1dce
    lda key_x,x                         ; ...
    sta cell_x                          ; ...
    lda key_y,x                         ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_at_cell                    ; ...
    pla                                 ; ...
    tax                                 ; ...
    dex                                 ; ...
    bne code_1dce                       ; ...
    ldx #0                              ; For each hero...
; &1de6 referenced 1 time by &460b
.check_hero_keys
    lda hero_direction,x                ; In play?
    bne code_1e28                       ; Yes
    lda hero_key,x                      ; Out of play: carrying a key?
    bne code_1df3                       ; Yes
    jmp code_1ec6                       ; No: next hero
; &1df3 referenced 1 time by &452e
.code_1df3
    lda hero_frame,x                    ; Death animation finished?
    cmp #8                              ; ...
    bne code_1e28                       ; Not yet
    ldy hero_key,x                      ; Yes: drop the key where the hero fell
    lda hero_x,x                        ; ...
    sta key_x,y                         ; ...
    lda hero_y,x                        ; ...
    sta key_y,y                         ; ...
    lda #0                              ; ...
    sta hero_key,x                      ; ...
    lda #&1a                            ; Erase the key icon from the panel
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
    jmp code_1ec6                       ; Next hero
; &1e28 referenced 2 times by &4529, &4538
.code_1e28
    lda hero_key_dropped,x              ; Just swapped keys?
    beq code_1e35                       ; No
    lda #0                              ; Yes: not again until the hero moves on
    sta hero_key_dropped,x              ; ...
    jmp code_1ec6                       ; ...
; &1e35 referenced 1 time by &456b
.code_1e35
    lda hero_x,x                        ; Is there a key at the hero's cell?
    sta cell_x                          ; ...
    lda hero_y,x                        ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    ldx #&14                            ; ...keys 20 to 1
; &1e45 referenced 1 time by &4601
.code_1e45
    lda key_x,x                         ; ...
    cmp cell_x                          ; ...
    bne code_1ebe                       ; ...
    lda key_y,x                         ; ...
    cmp cell_y                          ; ...
    bne code_1ebe                       ; ...
    lda #&15                            ; Yes: erase it from the floor
    sta sprite_number                   ; ...
    lda #0                              ; ...
    sta data_007d                       ; ...
    sta data_007e                       ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_at_cell                    ; ...
    pla                                 ; ...
    tax                                 ; ...
    pla                                 ; Show the key icon in the hero's panel
    tay                                 ; ...
    pha                                 ; ...
    lda #&52 ; 'R'                      ; ...
    sta sprite_number                   ; ...
    lda hero_panel_y,y                  ; ...
    sec                                 ; ...
    sbc #&0d                            ; ...
    sta plot_y                          ; ...
    lda #&4a ; 'J'                      ; ...
    sta plot_x                          ; ...
    tya                                 ; ...
    pha                                 ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_sprite                     ; ...
    pla                                 ; ...
    tax                                 ; ...
    pla                                 ; ...
    tay                                 ; ...
    txa                                 ; Drop the key carried (if any) in this cell...
    pha                                 ; ...
    ldx hero_key,y                      ; ...
    lda hero_x,y                        ; ...
    sta key_x,x                         ; ...
    lda hero_y,y                        ; ...
    sta key_y,x                         ; ...
    pla                                 ; ...
    tax                                 ; ...
    sta hero_key,y                      ; ...and carry the new one
    lda #1                              ; Mark the swap
    sta hero_key_dropped,y              ; ...
    lda #&ff                            ; Take the new key off the floor
    sta key_x,x                         ; ...
    sta key_y,x                         ; ...
    ldx #<(key_envelope)                ; Play the key sound
    ldy #>(key_envelope)                ; ...
    lda #osword_envelope                ; ...
    jsr osword                          ; ...  ENVELOPE command
    ldx #<(key_sound)                   ; ...
    ldy #>(key_sound)                   ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; ...  SOUND command
    pla                                 ; ...
    tax                                 ; ...
    jmp code_1ec6                       ; Next hero
; &1ebe referenced 2 times by &458b, &4593
.code_1ebe
    dex                                 ; Next key
    beq code_1ec4                       ; ...
    jmp code_1e45                       ; ...
; &1ec4 referenced 1 time by &45ff
.code_1ec4
    pla                                 ; ...
    tax                                 ; ...
; &1ec6 referenced 4 times by &4530, &4565, &4572, &45fb
.code_1ec6
    inx                                 ; Next hero
    cpx #4                              ; ...
    beq update_rest                     ; ...
    jmp check_hero_keys                 ; ...
; &1ece referenced 1 time by &4609
.update_rest
    jsr sub_7305                        ; Draw the objects
    jsr move_missiles                   ; Move the missiles
    jsr update_monsters                 ; Move the monsters
    lda #osbyte_scan_keyboard_from_16   ; OSBYTE &7A: is a key pressed?
    jsr osbyte                          ; Scan keyboard from key 16
    cpx #&37 ; '7'                      ; P (internal key &37)?
    bne return_6                        ; No: return
; &1ee0 referenced 1 time by &4625
.code_1ee0
    jsr osbyte                          ; Paused: wait for P to be released...  Scan keyboard from key 16
    cpx #&37 ; '7'
    beq code_1ee0
; &1ee7 referenced 1 time by &462c
.code_1ee7
    jsr osbyte                          ; ...then pressed again  Scan keyboard from key 16
    cpx #&37 ; '7'
    bne code_1ee7
    lda #&10                            ; Restart the frame timing
    sta os_vsync_counter
; &1ef3 referenced 1 time by &461e
.return_6
    rts
    equb &f9, &60, &00, &00, &00, &00, &00, &00
    equs "<<<<"
; ***************************************************************************************
; Play a level until it ends
;
; Run one frame every three vertical syncs: check for victory and update the game, take
; any hero standing on the exit down it, and animate one going down. Return when no hero
; is in play and every death animation has finished. Each hero_enters_exit leaves its
; return address on the stack (it ends with a jump back here), so the first RTS at the
; end of a level returns into this loop, once for each hero who left by the exit, before
; the last returns to the caller.
; &1f00 referenced 4 times by &35a5, &4643, &46db, &472f
.play_level
    lda os_vsync_counter                ; Wait for the vertical sync counter to pass zero...
    bpl play_level                      ; ...
    lda #2                              ; ...and set it for three syncs from now
    sta os_vsync_counter                ; ...
    jsr check_for_victory               ; Has the Chalice been found?
    jsr update_game                     ; Run a frame
    lda exit_busy                       ; A hero going down the exit?
    bne code_1f36                       ; Yes: carry on
    ldx #4                              ; Is any hero in play, or still dying?
; &1f17 referenced 1 time by &466b
.code_1f17
    lda data_0d19,x                     ; In play?
    bne code_1f36                       ; Yes: carry on
    lda data_0d8f,x                     ; Dead...
    cmp #&1d                            ; ...
    bne code_1f2a                       ; ...
    lda data_0d1f,x                     ; ...with the death animation unfinished?
    cmp #8                              ; ...
    bcc code_1f36                       ; Yes: carry on
; &1f2a referenced 1 time by &4661
.code_1f2a
    dex                                 ; Next hero
    bne code_1f17                       ; ...
    ldx shrunk_hero                     ; The level is over: restore the last exiting hero's sprites
    bmi return_7                        ; ...
    jsr restore_hero_sprites            ; ...
; &1f35 referenced 1 time by &4670
.return_7
    rts                                 ; Return
; &1f36 referenced 3 times by &4653, &465a, &4668
.code_1f36
    ldx #0                              ; Is a hero on the exit?
; &1f38 referenced 1 time by &46d4
.code_1f38
    lda hero_x,x                        ; ...
    cmp exit_x                          ; ...
    bne code_1f91                       ; ...
    lda hero_y,x                        ; ...
    cmp exit_y                          ; ...
    bne code_1f91                       ; ...
    jsr drop_key                        ; Yes: drop their key beside it
    lda #&63 ; 'c'                      ; Take them out of play for the rest of the level
    sta hero_step,x                     ; ...
    lda #0                              ; ...
    sta hero_direction,x                ; ...
    lda hero_x,x                        ; Erase them
    sta cell_x                          ; ...
    lda hero_y,x                        ; ...
    sta cell_y                          ; ...
    lda #0                              ; ...
    sta data_007d                       ; ...
    sta data_007e                       ; ...
    lda #&15                            ; ...
    sta sprite_number                   ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_at_cell                    ; ...
    pla                                 ; ...
    tax                                 ; ...
    lda #&ff                            ; Move them off the map
    sta hero_x,x                        ; ...
    lda exit_x                          ; Hide the exit while they go down it, keeping its position
    sta exit_saved_x                    ; ...
    lda exit_y                          ; ...
    sta exit_saved_y                    ; ...
    lda #&ff                            ; ...
    sta exit_x                          ; ...
    sta exit_y                          ; ...
    jsr hero_enters_exit                ; Start the exit animation (which jumps back to play_level)
    jmp code_1f96                       ; Reached by the RTS at the end of the level
; &1f91 referenced 2 times by &467e, &4686
.code_1f91
    inx                                 ; Next hero
    cpx #4                              ; ...
    bne code_1f38                       ; ...
; &1f96 referenced 1 time by &46ce
.code_1f96
    lda exit_busy                       ; A hero going down the exit?
    bne code_1f9e                       ; Yes
    jmp play_level                      ; No: next frame
; &1f9e referenced 1 time by &46d9
.code_1f9e
    ldx exiting_hero                    ; Redraw the exit
    lda #0                              ; ...
    sta data_007d                       ; ...
    sta data_007e                       ; ...
    lda exit_saved_x                    ; ...
    sta cell_x                          ; ...
    lda exit_saved_y                    ; ...
    sta cell_y                          ; ...
    lda #&51 ; 'Q'                      ; ...
    sta sprite_number                   ; ...
    jsr plot_at_cell                    ; ...
    ldx exiting_hero                    ; Turn the hero a quarter (frames 1, 3, 5, 7)
    clc                                 ; ...
    lda exit_spin                       ; ...
    adc #2                              ; ...
    sta exit_spin                       ; ...
    cmp #9                              ; A full turn?
    beq code_1ff2                       ; Yes: shrink the hero
    clc                                 ; Plot the hero on the exit, centred for its current size
    lda hero_sprites,x                  ; ...
    adc exit_spin                       ; ...
    sta sprite_number                   ; ...
    lda exit_saved_x                    ; ...
    sta cell_x                          ; ...
    lda exit_saved_y                    ; ...
    sta cell_y                          ; ...
    ldx exit_shrinks_left               ; ...
    lda exit_offsets_x,x                ; ...
    sta data_007d                       ; ...
    lda exit_offsets_y,x                ; ...
    sta data_007e                       ; ...
    jsr plot_at_cell                    ; ...
    jmp play_level                      ; Next frame
; &1ff2 referenced 1 time by &4708
.code_1ff2
    lda #&ff                            ; Start the next turn
    sta exit_spin                       ; ...
    dec exit_shrinks_left               ; Last turn done?
    beq code_2026                       ; Yes: the hero has gone
    clc                                 ; Shrink the hero's eight sprites: one byte narrower...
    lda hero_sprites,x
    brk
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00
    equb &00, &00, &00                  ; ...three rows shorter. Next frame
; &2026 referenced 1 time by &473a
.code_2026
    brk                                 ; Put the exit back...
    equb &00, &00
    equb &00, &00, &00                  ; ...
    equb &00, &00, &00                  ; ...
    equb &00, &00, &00                  ; ...
    equb &00, &00                       ; ...and end the animation
    equb &00, &00, &00                  ; ...
    equb &00, &00, &00                  ; Next frame
; ***************************************************************************************
; Start a hero going down the exit
;
; Play the exit sound, restore any hero shrunk before, and start the animation of hero X
; spinning and shrinking on the exit. Ends by jumping to play_level rather than
; returning.
;
; On Entry:
;     X: hero number (0-3)
; &203a referenced 1 time by &46cb
.hero_enters_exit
    brk                                 ; Keep the hero number
    equb &00, &00
    equb &00, &00, &00                  ; Sound the exit and queue a marker
    equb &00, &00                       ; ...
    equb &00, &00, &00                  ; ...
    equb &00, &00, &00                  ; Restore the sprites of any hero shrunk before
    equb &00, &00                       ; ...
    equb &00, &00, &00                  ; ...
    equb &00, &00, &00                  ; ...
; ***************************************************************************************
; Restore a hero's sprite sizes
;
; Put back the width and height of all eight of hero X's sprites, which the exit
; animation shrinks.
;
; On Entry:
;     X: hero number (0-3)
; &2050 referenced 1 time by &4672
.restore_hero_sprites
    brk
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00
    equb &00, &00                       ; Start the animation for this hero...
    equb &00, &00, &00                  ; ...
    equb &00, &00, &00                  ; ...
    equb &00, &00, &00                  ; ...
    equb &00, &00, &00                  ; ...
    equb &00, &00                       ; ...turning from the start...
    equb &00, &00, &00                  ; ...
    equb &00, &00                       ; ...for four turns
    equb &00, &00, &00                  ; ...
    equb &00, &00, &00                  ; Back to play_level, without returning
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
; &2091 referenced 1 time by &4688
.drop_key
    brk
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00
; ***************************************************************************************
; Find a free cell next to a cell
;
; Starting with cell_x, cell_y, try the cells above, to the right, below and to the left,
; and leave cell_x, cell_y at the first without a wall.
.find_open_neighbour
    brk
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00
; &2100 used as index base 1 time by &3cad
.object_free_map
; &487a used as index base 1 time by &3807
data_213a = object_free_map+58
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00


    ; Copy the newly assembled block of code back to it's proper place in the binary
    ; file.
    ; (Note the parameter order: 'copyblock <start>,<end>,<dest>')
    copyblock &08c0, *, &3000

    ; Clear the area of memory we just temporarily used to assemble the new block,
    ; allowing us to assemble there again if needed
    clear &08c0, &2140

    ; Set the program counter to the next position in the binary file.
    org &3000 + (* - &08c0)


    org &51b0

; Move 2: &51b0 to &0400 for length 1024
    org &0400
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
.add_thousand_points_joy
    inc hero_score_thousands,x
    lda hero_score_thousands,x
    cmp #&28 ; '('
    bne data_0447
    lda #&1e
    sta hero_score_thousands,x
    inc data_06f8,x
    lda data_06f8,x
    cmp #&73 ; 's'
    bne data_041e
    lda #&72 ; 'r'
    sta data_06f8,x
; &041e referenced 4 times by &51c7, &5472, &55c7, &5872
.data_041e
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
; &0437 referenced 2 times by &51f3, &55f3
.data_0437
    tya
    pha
    inc plot_x
    inc plot_x
    jsr plot_sprite
    pla
    tay
    dey
    bne data_0437
    pla
    tax
; &0447 referenced 2 times by &51b8, &55b8
.data_0447
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
; &0450 referenced 1 time by &3b86
.decrypt_level
.decrypt_level_joy
    ldy #0                              ; Point at &6B00, the start of the level...
    sty plot_x                          ; ...low byte
    sty sprite_width                    ; Start the sum at zero
    lda #&6b ; 'k'                      ; ...
    sta plot_y                          ; ...high byte
; &045a referenced 4 times by &521f, &5225, &561f, &5625
.data_045a
    lda (plot_x),y                      ; Fetch a byte...
    eor plot_x                          ; ...XOR it with the low byte of its address...
    sta (plot_x),y                      ; ...and store it back decrypted
    clc                                 ; Add it to the sum
    adc sprite_width                    ; ...
    sta sprite_width                    ; ...
    inc plot_x                          ; Next byte...
    bne data_046b                       ; ...
    inc plot_y                          ; ...with carry into the high byte
; &046b referenced 2 times by &5217, &5617
.data_046b
    lda plot_x                          ; Stop at &6DB0, the end of the level...
    cmp #&b0                            ; ...
    bne data_045a                       ; ...
    lda plot_y                          ; ...
    cmp #&6d ; 'm'                      ; ...
    bne data_045a                       ; ...
    ldx level_number                    ; X = level number
    lda sprite_width                    ; Compare the sum...
    cmp level_checksums,x               ; ...with this level's checksum
    beq data_0484                       ; Match: return
    jsr mos_reset_entry                 ; No match: reset the machine (MOS 1.20 only)
; &0484 referenced 2 times by &522f, &562f
.data_0484
    rts                                 ; Return
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00
; &0490 used as index base 2 times by &522c, &562c
.level_checksums
    equb &00
; ***************************************************************************************
; Level checksums
;
; One byte per level, 1-25: the sum, modulo 256, of the level's decrypted bytes.
    equb &62, &cd, &0c, &44, &4d
    equb &22, &f6, &42, &21, &7d
    equb &5d, &d8, &a0, &f1, &0f
    equb &cc, &d3, &53, &3b, &83
    equb &71, &b2, &6f, &f3, &f1
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00
.sprite_blank
.sprite_blank_joy
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00
; ***************************************************************************************
; Choose the heroes and the sound
;
; Clear the left of the screen, print the menu and let the players toggle each hero (keys
; 1-4) and the sound (5 on, 6 off). SPACE starts the game if at least one hero is
; playing.
; &0500 referenced 1 time by &3551
.hero_menu
.hero_menu_joy
    lda #&1c
    jsr oswrch
    lda #0
    jsr oswrch
    lda #&16
    jsr oswrch
    lda #&13
    jsr oswrch
    lda #0
    jsr oswrch
    lda #&0c
    jsr oswrch
    jsr print_menu
    jmp data_0581
; ***************************************************************************************
; Print the menu text
;
; Print the sixteen positioned strings of menu_text.
; &0524 referenced 6 times by &52ce, &5373, &53a0, &56ce, &5773, &57a0
.print_menu
.print_menu_joy
    ldx #&0f
    ldy #0
; &0528 referenced 2 times by &52dc, &56dc
.data_0528
    jsr print_menu_string
    dex
    bne data_0528
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
; &052e referenced 2 times by &52d8, &56d8
.print_menu_string
.print_menu_string_joy
    lda #&1f
    jsr oswrch
    lda menu_text,y
    jsr oswrch
    iny
    lda menu_text,y
    jsr oswrch
; &0540 referenced 2 times by &52f9, &56f9
.data_0540
    iny
    lda menu_text,y
    jsr oswrch
    cmp #&0d
    bne data_0540
    iny
    rts
; ***************************************************************************************
; Change a menu entry to NO
;
; Write "NO " at menu_text+Y.
;
; On Entry:
;     Y: offset of the entry
; &054d referenced 2 times by &5370, &5770
.set_menu_no
.set_menu_no_joy
    lda #&4e ; 'N'
    sta menu_text,y
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
; &055d referenced 2 times by &536a, &576a
.set_menu_yes
.set_menu_yes_joy
    lda #&59 ; 'Y'
    sta menu_text,y
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
; &056d referenced 2 times by &5394, &5794
.set_menu_off
.set_menu_off_joy
    lda #&46 ; 'F'
    sta menu_text,y
    sta data_0601,y
    rts
; ***************************************************************************************
; Change the sound entry to ON
;
; Write "N " at menu_text+Y, after its "O".
;
; On Entry:
;     Y: offset of the entry's second character
; &0576 referenced 2 times by &538d, &578d
.set_menu_on
.set_menu_on_joy
    lda #&4e ; 'N'
    sta menu_text,y
    lda #&20 ; ' '
    sta data_0601,y
    rts
; &0581 referenced 12 times by &52d1, &5348, &534c, &5376, &5383, &53a3, &56d1, &5748, &574c, &5776, &5783, &57a3
.data_0581
    lda #osbyte_flush_buffer_class
    jsr osbyte                          ; Flush selected class of buffer
    lda #osbyte_kbd_status
    ldx #&20 ; ' '
    ldy #0
    jsr osbyte                          ; osbyte: kbd status
    jsr osrdch
    cmp #&20 ; ' '
    beq data_05c9
    cmp #&31 ; '1'
    bcc data_0581
    cmp #&37 ; '7'
    bcs data_0581
    sec
    sbc #&31 ; '1'
    tax
    cmp #4
    bcs data_05d7
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
    bne data_05c0
    jsr set_menu_yes
    jmp data_05c3
; &05c0 referenced 2 times by &5368, &5768
.data_05c0
    jsr set_menu_no
; &05c3 referenced 2 times by &536d, &576d
.data_05c3
    jsr print_menu
    jmp data_0581
; &05c9 referenced 2 times by &5344, &5744
.data_05c9
    ldx #3
; &05cb referenced 2 times by &5381, &5781
.data_05cb
    lda hero_absent,x
    beq data_05d6
    dex
    bpl data_05cb
    jmp data_0581
; &05d6 referenced 2 times by &537e, &577e
.data_05d6
    rts
; &05d7 referenced 2 times by &5354, &5754
.data_05d7
    ldy #&99
    cmp #5
    beq data_05e4
    jsr set_menu_on
    ldx #0
    beq data_05e9
; &05e4 referenced 2 times by &538b, &578b
.data_05e4
    jsr set_menu_off
    ldx #1
; &05e9 referenced 2 times by &5392, &5792
.data_05e9
    lda #osbyte_sound_suppression
    ldy #0
    jsr osbyte                          ; osbyte: sound suppression
    jsr print_menu
    jmp data_0581
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &4f
; ***************************************************************************************
; Hero menu text
;
; Sixteen entries of: column, row, text, carriage return; printed by print_menu.
; &0600 used as index base 14 times by &52e3, &52ea, &52f1, &52ff, &530f, &531f, &5328, &56e3, &56ea, &56f1, &56ff, &570f, &571f, &5728
.menu_text
.menu_text_joy
; &53b1 used as index base 8 times by &5304, &5314, &5322, &532d, &5704, &5714, &5722, &572d
data_0601 = menu_text+1
    equb &06, &00
; &0602 used as index base 4 times by &5309, &5319, &5709, &5719
.data_0602
    equs "DUNJUNZ"
    equb &0d
    equb &00, &02
    equs "HERO"
    equb &0d
    equb &0c, &02
    equs "PLAYING"
    equb &0d
    equb &00, &04
    equs "1 RANGER"
    equb &0d
    equb &00, &05
    equs "2 MAGIC-USER"
    equb &0d
    equb &00, &06
    equs "3 BARBARIAN"
    equb &0d
    equb &00, &07
    equs "4 FIGHTER"
    equb &0d
    equb &0e, &04
    equs "YES"
    equb &0d
    equb &0e, &05
    equs "YES"
    equb &0d
    equb &0e, &06
    equs "YES"
    equb &0d
    equb &0e, &07
    equs "YES"
    equb &0d
    equb &00, &09
    equs "TYPE NUMBER"
    equb &0d
    equb &00, &0a
    equs "TO TOGGLE"
    equb &0d
    equb &00, &0d
    equs "SOUND ON(5) OFF(6)"
    equb &0d
    equb &07, &0f
    equs "ON "
    equb &0d
    equb &03, &14
    equs "SPACE TO PLAY"
    equb &0d
    equb &00, &0d, &a9, &63
; ***************************************************************************************
; Take the heroes nobody plays out of the game
;
; Draw any ten-thousands score digits, then put every hero switched off on the menu out
; of play, with a &64 entry in returning_hero_queue in their place.
; &06b0 referenced 1 time by &359d
.remove_absent_heroes
.remove_absent_heroes_joy
    ldx #0
    ldy #0
; &06b4 referenced 2 times by &54a3, &58a3
.data_06b4
    lda hero_score_ten_thousands,x
    cmp #&6a ; 'j'
    bcc data_06c9
    txa
    pha
    tya
    pha
    lda hero_score_ten_thousands,x
    jsr data_041e
    pla
    tay
    pla
    tax
; &06c9 referenced 2 times by &5469, &5869
.data_06c9
    lda hero_absent,x
    beq data_06f0
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
; &06f0 referenced 2 times by &547c, &587c
.data_06f0
    inx
    cpx #4
    bne data_06b4
    rts
    equb &00, &00
; &06f8 used as index base 6 times by &51bf, &51c2, &51cb, &55bf, &55c2, &55cb
.data_06f8
    equs "iiii"
    equb &00, &00, &00, &00
    equs "*SA. DANK 400+3FF 740"
    equb &0d, &0d
    equs "740"
    equb &0d, &0d, &54, &50, &0d, &0d, &50, &0d
    equs "Alabel+2:LDA#255:.label JSR&30"
    equb &a2, &00, &a0, &6b, &a9, &f0, &8d, &00
    equb &6b, &a9, &07, &8d, &01, &6b, &a9, &00
    equb &8d, &02, &6b, &8d, &04, &6b, &8d, &05
    equb &6b, &a9, &20, &8d, &03, &6b, &ad, &12
    equb &02, &8d, &6d, &07, &ad, &13, &02, &8d
    equb &6e, &07, &a9, &ff, &20, &00, &30, &4c
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
    equs "Dun1"
    equb &0d, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00


    ; Copy the newly assembled block of code back to it's proper place in the binary
    ; file.
    ; (Note the parameter order: 'copyblock <start>,<end>,<dest>')
    copyblock add_thousand_points, *, &51b0

    ; Clear the area of memory we just temporarily used to assemble the new block,
    ; allowing us to assemble there again if needed
    clear add_thousand_points, &0800

    ; Set the program counter to the next position in the binary file.
    org &51b0 + (* - add_thousand_points)


    org &55b0

; Move 3: &55b0 to &0400 for length 1024
    org &0400
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
    inc hero_score_thousands,x
    lda hero_score_thousands,x
    cmp #&28 ; '('
    bne data_0447
    lda #&1e
    sta hero_score_thousands,x
    inc data_06f8,x
    lda data_06f8,x
    cmp #&73 ; 's'
    bne data_041e
    lda #&72 ; 'r'
    sta data_06f8,x
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
    tya
    pha
    inc plot_x
    inc plot_x
    jsr plot_sprite
    pla
    tay
    dey
    bne data_0437
    pla
    tax
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
    ldy #0                              ; Point at &6B00, the start of the level...
    sty plot_x                          ; ...low byte
    sty sprite_width                    ; Start the sum at zero
    lda #&6b ; 'k'                      ; ...
    sta plot_y                          ; ...high byte
    lda (plot_x),y                      ; Fetch a byte...
    eor plot_x                          ; ...XOR it with the low byte of its address...
    sta (plot_x),y                      ; ...and store it back decrypted
    clc                                 ; Add it to the sum
    adc sprite_width                    ; ...
    sta sprite_width                    ; ...
    inc plot_x                          ; Next byte...
    bne data_046b                       ; ...
    inc plot_y                          ; ...with carry into the high byte
    lda plot_x                          ; Stop at &6DB0, the end of the level...
    cmp #&b0                            ; ...
    bne data_045a                       ; ...
    lda plot_y                          ; ...
    cmp #&6d ; 'm'                      ; ...
    bne data_045a                       ; ...
    ldx level_number                    ; X = level number
    lda sprite_width                    ; Compare the sum...
    cmp level_checksums,x               ; ...with this level's checksum
    beq data_0484                       ; Match: return
    jsr mos_reset_entry                 ; No match: reset the machine (MOS 1.20 only)
    rts                                 ; Return
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00
    equb &00
; ***************************************************************************************
; Level checksums
;
; One byte per level, 1-25: the sum, modulo 256, of the level's decrypted bytes.
    equb &62, &cd, &0c, &44, &4d
    equb &22, &f6, &42, &21, &7d
    equb &5d, &d8, &a0, &f1, &0f
    equb &cc, &d3, &53, &3b, &83
    equb &71, &b2, &6f, &f3, &f1
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00
; ***************************************************************************************
; Choose the heroes and the sound
;
; Clear the left of the screen, print the menu and let the players toggle each hero (keys
; 1-4) and the sound (5 on, 6 off). SPACE starts the game if at least one hero is
; playing.
    lda #&1c
    jsr oswrch
    lda #0
    jsr oswrch
    lda #&16
    jsr oswrch
    lda #&13
    jsr oswrch
    lda #0
    jsr oswrch
    lda #&0c
    jsr oswrch
    jsr print_menu
    jmp data_0581
; ***************************************************************************************
; Print the menu text
;
; Print the sixteen positioned strings of menu_text.
    ldx #&0f
    ldy #0
    jsr print_menu_string
    dex
    bne data_0528
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
    lda #&1f
    jsr oswrch
    lda menu_text,y
    jsr oswrch
    iny
    lda menu_text,y
    jsr oswrch
    iny
    lda menu_text,y
    jsr oswrch
    cmp #&0d
    bne data_0540
    iny
    rts
; ***************************************************************************************
; Change a menu entry to NO
;
; Write "NO " at menu_text+Y.
;
; On Entry:
;     Y: offset of the entry
    lda #&4e ; 'N'
    sta menu_text,y
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
    lda #&59 ; 'Y'
    sta menu_text,y
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
    lda #&46 ; 'F'
    sta menu_text,y
    sta data_0601,y
    rts
; ***************************************************************************************
; Change the sound entry to ON
;
; Write "N " at menu_text+Y, after its "O".
;
; On Entry:
;     Y: offset of the entry's second character
    lda #&4e ; 'N'
    sta menu_text,y
    lda #&20 ; ' '
    sta data_0601,y
    rts
    lda #osbyte_flush_buffer_class
    jsr osbyte                          ; Flush selected class of buffer
    lda #osbyte_kbd_status
    ldx #&20 ; ' '
    ldy #0
    jsr osbyte                          ; osbyte: kbd status
    jsr osrdch
    cmp #&20 ; ' '
    beq data_05c9
    cmp #&31 ; '1'
    bcc data_0581
    cmp #&37 ; '7'
    bcs data_0581
    sec
    sbc #&31 ; '1'
    tax
    cmp #4
    bcs data_05d7
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
    bne data_05c0
    jsr set_menu_yes
    jmp data_05c3
    jsr set_menu_no
    jsr print_menu
    jmp data_0581
    ldx #3
    lda hero_absent,x
    beq data_05d6
    dex
    bpl data_05cb
    jmp data_0581
    rts
    ldy #&99
    cmp #5
    beq data_05e4
    jsr set_menu_on
    ldx #0
    beq data_05e9
    jsr set_menu_off
    ldx #1
    lda #osbyte_sound_suppression
    ldy #0
    jsr osbyte                          ; osbyte: sound suppression
    jsr print_menu
    jmp data_0581
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &4f
; ***************************************************************************************
; Hero menu text
;
; Sixteen entries of: column, row, text, carriage return; printed by print_menu.
    equb &06, &00
    equs "DUNJUNZ"
    equb &0d
    equb &00, &02
    equs "HERO"
    equb &0d
    equb &0c, &02
    equs "PLAYING"
    equb &0d
    equb &00, &04
    equs "1 RANGER"
    equb &0d
    equb &00, &05
    equs "2 MAGIC-USER"
    equb &0d
    equb &00, &06
    equs "3 BARBARIAN"
    equb &0d
    equb &00, &07
    equs "4 FIGHTER"
    equb &0d
    equb &0e, &04
    equs "YES"
    equb &0d
    equb &0e, &05
    equs "YES"
    equb &0d
    equb &0e, &06
    equs "YES"
    equb &0d
    equb &0e, &07
    equs "YES"
    equb &0d
    equb &00, &09
    equs "TYPE NUMBER"
    equb &0d
    equb &00, &0a
    equs "TO TOGGLE"
    equb &0d
    equb &00, &0d
    equs "SOUND ON(5) OFF(6)"
    equb &0d
    equb &07, &0f
    equs "ON "
    equb &0d
    equb &03, &14
    equs "SPACE TO PLAY"
    equb &0d
    equb &00, &0d, &a9, &63
; ***************************************************************************************
; Take the heroes nobody plays out of the game
;
; Draw any ten-thousands score digits, then put every hero switched off on the menu out
; of play, with a &64 entry in returning_hero_queue in their place.
    ldx #0
    ldy #0
    lda hero_score_ten_thousands,x
    cmp #&6a ; 'j'
    bcc data_06c9
    txa
    pha
    tya
    pha
    lda hero_score_ten_thousands,x
    jsr data_041e
    pla
    tay
    pla
    tax
    lda hero_absent,x
    beq data_06f0
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
    inx
    cpx #4
    bne data_06b4
    rts
    equb &00, &00
    equs "iiii"
    equb &00, &00, &00, &00
    equs "*SA. Control 400+3FF"
    equb &0d, &0d, &0d
    equs "740"
    equb &0d, &0d, &54, &50, &0d, &0d, &50, &0d
    equs "Alabel+2:LDA#255:.label JSR&30"
    equb &a9, &80, &8d, &0a, &02, &a9, &07, &8d
    equb &0b, &02, &a2, &00, &a0, &6b, &a9, &f0
    equb &8d, &00, &6b, &a9, &07, &8d, &01, &6b
    equb &a9, &00, &8d, &02, &6b, &8d, &04, &6b
    equb &8d, &05, &6b, &a9, &20, &8d, &03, &6b
    equb &ad, &12, &02, &8d, &77, &07, &ad, &13
    equb &02, &8d, &78, &07, &a9, &ff, &20, &00
    equb &30, &4c, &00, &20, &00, &00, &00, &00
    cmp #&81
    bne data_07e9
    cpx #&98
    beq data_079b
    cpx #&99
    beq data_07c6
    cpx #&b9
    beq data_07b8
    cpx #&97
    beq data_07a9
    cpx #&9d
    beq data_07d5
    jmp data_e772
; &079b referenced 1 time by &5936
.data_079b
    ldx #1
    lda #osbyte_read_adc_or_get_buffer_status
    jsr osbyte                          ; Read ADC channel X or buffer status
    cpy #&ff
    bne data_07e6
    ldx #&ff
    rts
; &07a9 referenced 1 time by &5942
.data_07a9
    ldx #1
    lda #osbyte_read_adc_or_get_buffer_status
    jsr osbyte                          ; Read ADC channel X or buffer status
    cpy #0
    bne data_07e6
    dey
    ldx #&ff
    rts
; &07b8 referenced 1 time by &593e
.data_07b8
    ldx #2
    lda #osbyte_read_adc_or_get_buffer_status
    jsr osbyte                          ; Read ADC channel X or buffer status
    cpy #&ff
    bne data_07e6
    ldx #&ff
    rts
; &07c6 referenced 1 time by &593a
.data_07c6
    ldx #2
    lda #osbyte_read_adc_or_get_buffer_status
    jsr osbyte                          ; Read ADC channel X or buffer status
    cpy #0
    bne data_07e6
    dey
    ldx #&ff
    rts
; &07d5 referenced 1 time by &5946
.data_07d5
    ldx #0
    lda #osbyte_read_adc_or_get_buffer_status
    jsr osbyte                          ; Read ADC channel X or buffer status
    txa
    and #3
    beq data_07e6
    ldx #&ff
    ldy #&ff
    rts
; &07e6 referenced 5 times by &5954, &5962, &5971, &597f, &598f
.data_07e6
    ldx #0
    rts
; &07e9 referenced 1 time by &5932
.data_07e9
    jmp data_e772
    equb &00, &00, &00, &00
    equs "Dun1"
    equb &0d, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00


    ; Copy the newly assembled block of code back to it's proper place in the binary
    ; file.
    ; (Note the parameter order: 'copyblock <start>,<end>,<dest>')
    copyblock add_thousand_points, *, &55b0

    ; Clear the area of memory we just temporarily used to assemble the new block,
    ; allowing us to assemble there again if needed
    clear add_thousand_points, &0800

    ; Set the program counter to the next position in the binary file.
    org &55b0 + (* - add_thousand_points)


    org &2000

.dasmos_start
    equb &69, &01, &a8, &aa, &69, &07, &8d, &00
    equb &0d, &de, &d0, &1b, &e8, &ec, &00, &0d
    equb &d0, &f7, &98, &aa, &38, &bd, &48, &1c
    equb &e9, &03, &9d, &48, &1c, &e8, &ec, &00
    equb &0d, &d0, &f1, &4c, &00, &1f, &ad, &f0
    equb &09, &8d, &3e, &7f, &ad, &f1, &09, &8d
    equb &5d, &7f, &a9, &00, &8d, &f2, &09, &4c
    equb &00, &1f
    equb &8e, &01, &0d, &20, &a0, &16, &a9, &04
    equb &8d, &f6, &09, &ae, &ff, &09
    equs "0, P Lv "
    equb &18, &bd, &b5, &0d, &69, &01, &aa, &a8
    equb &69, &07, &8d, &00, &0d, &a9, &04, &99
    equb &d0, &1b, &c8, &cc, &00, &0d, &d0, &f7
    equb &8a, &a8, &a9, &0c, &99, &48, &1c, &c8
    equb &cc, &00, &0d, &d0, &f7, &60, &a9, &01
    equb &8d, &f2, &09, &ad, &01, &0d, &8d, &f5
    equb &09, &8d, &ff, &09, &a9, &ff, &8d, &f3
    equb &09, &a9, &04, &8d, &f4, &09, &4c, &00
    equb &1f
    equb &bd, &10, &0d, &8d, &02, &0d, &bd, &15
    equb &0d, &8d, &03, &0d, &8a, &48, &20, &d0
    equb &20, &68, &aa, &bc, &e0, &22, &ad, &02
    equb &0d, &99, &60, &22, &ad, &03, &0d, &99
    equb &80, &22, &a9, &00, &9d, &e0, &22, &a9
    equb &1a, &85, &7a, &bd, &d0, &0d, &38, &e9
    equb &0d, &85, &71, &a9, &4a, &85, &70, &8a
    equb &48, &20, &00, &09, &68, &aa, &60
    equb &ce, &03, &0d, &20, &fc, &78, &c0, &00
    equb &d0, &01, &60, &ee, &03, &0d, &ee, &02
    equb &0d, &20, &fc, &78, &c0, &00, &d0, &01
    equb &60, &ce, &02, &0d, &ee, &03, &0d, &20
    equb &fc, &78, &c0, &00, &d0, &01, &60, &ce
    equb &03, &0d, &ce, &02, &0d, &60, &01, &3f
    equb &00, &02, &07, &07, &1f, &3f, &7d, &7f
    equb &00, &30, &78, &fd, &7f, &ff, &80, &00
    equb &00, &60, &e0, &c0, &df, &c0, &1f, &0f
    equb &00
    equs "XXX"
    equb &d8, &18, &f8, &80
    equs "v>_n~"
    equb &00, &7f, &7f, &00
    equs "ff~~ff"
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
    equb &00, &00, &00, &00, &00
.sprite_drainer
    equb &11, &33, &33, &22
    equb &33, &33, &33, &33
    equb &33, &ff, &c0, &33
    equb &33, &ff, &c0, &33
    equb &33, &ff, &c0, &33
    equb &33, &ff, &c0, &33
    equb &33, &ff, &c0, &33
    equb &33, &ff, &c0, &33
    equb &33, &ff, &c0, &33
    equb &33, &ff, &c0, &33
    equb &33, &33, &33, &33
    equb &11, &33, &33, &22
; &2200 used as index base 4 times by &3c6c, &4418, &44cb, &77fe
.door_x
    equb &ff, &ff, &ff, &04, &ff, &ff, &06, &ff
    equb &11, &ff, &ff, &ff, &1a, &03, &03, &0b
    equb &ff, &03, &09, &12, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
; &2220 used as index base 4 times by &3c72, &4423, &44ce, &7804
.door_y
    equb &ff, &ff, &ff, &0d, &ff, &ff, &11, &ff
    equb &16, &ff, &ff, &ff, &1a
    equs "#'%"
    equb &ff
    equs "+.+"
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff
; &2240 used as index base 2 times by &3c78, &7810
.door_sprite
    equb &ff, &1c, &1c, &1d, &1c, &1c, &1d, &1d
    equb &1d, &1d, &1d, &1c, &1c, &1d, &1d, &1c
    equb &1d, &1d, &1c, &1c, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
; &2260 used as index base 6 times by &3c83, &450e, &4540, &4585, &45cc, &45e1
.key_x
    equb &13, &ff, &ff, &1b, &ff, &ff, &17, &ff
    equb &1c, &ff, &ff, &ff, &02, &15, &04, &09
    equb &ff, &04, &19, &17, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
; &2280 used as index base 6 times by &3c89, &4514, &4546, &458d, &45d2, &45e4
.key_y
    equb &25, &ff, &ff, &06, &ff, &ff, &09, &ff
    equb &18, &ff, &ff, &ff, &29, &04, &0c, &14
    equb &ff, &0f, &03, &04, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
.sprite_exit
    equb &03, &03, &03, &03
    equb &02, &00, &00, &01
    equb &02, &00, &00, &01
    equb &02, &00, &00, &01
    equb &02, &00, &00, &01
    equb &02, &00, &00, &01
    equb &02, &00, &00, &01
    equb &02, &00, &00, &01
    equb &02, &00, &00, &01
    equb &02, &00, &00, &01
    equb &02, &00, &00, &01
    equb &03, &03, &03, &03
.sprite_key_icon
    equb &00, &05
    equb &0f, &0f
    equb &0f, &05
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00
; &22e0 used as index base 8 times by &3cdf, &4432, &44d5, &452b, &453a, &454b, &45c6, &45d7
.hero_key
    equb &00, &00, &00, &00, &00
; &22e5 used as index base 4 times by &3ce2, &4568, &456f, &45dc
.hero_key_dropped
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00
; &22f0 used as index base 4 times by &37b9, &3ce5, &4408, &6f9b
.hero_door_x
    equb &1a, &09, &00, &16, &00
; &22f5 used as index base 4 times by &37ca, &3ce8, &440e, &6fa1
.hero_door_y
    equb &06, &1d, &00, &09, &00, &00, &00, &00
    equb &00, &00, &00
.sprite_magic_user_up_0
    equb &01, &0a, &00, &00
    equb &03, &0a, &0b, &00
    equb &03, &00, &0b, &02
    equb &03, &00, &00, &03
    equb &03, &00, &0a, &03
    equb &03, &10, &1a, &01
    equb &01, &27, &0f, &23
    equb &01, &33, &33, &23
    equb &01, &13, &33, &00
    equb &03, &13, &33, &00
    equb &03, &03, &22, &00
    equb &03, &03, &00, &00
.sprite_magic_user_up_1
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &0f, &00, &00, &0f
    equb &03, &00, &0a, &03
    equb &03, &10, &1a, &01
    equb &01, &27, &0f, &23
    equb &01, &33, &33, &23
    equb &01, &13, &33, &03
    equb &00, &13, &33, &03
    equb &00, &03, &23, &03
    equb &00, &01, &01, &03
.sprite_magic_user_right_0
    equb &03, &00, &03, &00
    equb &03, &03, &03, &02
    equb &03, &13, &00, &0f
    equb &03, &27, &00, &00
    equb &13, &32, &00, &00
    equb &13, &27, &0a, &00
    equb &13, &27, &0a, &00
    equb &13, &32, &00, &00
    equb &01, &27, &00, &0a
    equb &00, &13, &01, &0a
    equb &00, &03, &03, &0a
    equb &00, &01, &03, &00
.sprite_magic_user_right_1
    equb &00, &00, &00, &00
    equb &00, &01, &03, &0a
    equb &00, &13, &07, &00
    equb &01, &27, &00, &00
    equb &11, &32, &00, &00
    equb &11, &27, &0a, &00
    equb &13, &27, &0a, &00
    equb &13, &32, &00, &00
    equb &03, &27, &05, &00
    equb &03, &13, &07, &00
    equb &03, &03, &07, &00
    equb &03, &01, &02, &00
.sprite_magic_user_down_0
    equb &00, &00, &03, &03
    equb &00, &11, &03, &03
    equb &00, &33, &23, &03
    equb &00, &33, &23, &02
    equb &13, &33, &33, &02
    equb &13, &0f, &1b, &02
    equb &02, &25, &20, &03
    equb &03, &05, &00, &03
    equb &03, &00, &00, &03
    equb &01, &07, &00, &03
    equb &00, &07, &05, &03
    equb &00, &00, &05, &02
.sprite_magic_user_down_1
    equb &03, &02, &02, &00
    equb &03, &13, &03, &00
    equb &03, &33, &23, &00
    equb &03, &33, &23, &02
    equb &13, &33, &33, &02
    equb &13, &0f, &1b, &02
    equb &02, &25, &20, &03
    equb &03, &05, &00, &03
    equb &0f, &00, &00, &0f
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
.sprite_magic_user_left_0
    equb &00, &03, &02, &00
    equb &05, &03, &03, &00
    equb &05, &02, &23, &00
    equb &05, &00, &1b, &02
    equb &00, &00, &31, &23
    equb &00, &05, &1b, &23
    equb &00, &05, &1b, &23
    equb &00, &00, &31, &23
    equb &00, &00, &1b, &03
    equb &0f, &00, &23, &03
    equb &01, &03, &03, &03
    equb &00, &03, &00, &03
.sprite_magic_user_left_1
    equb &00, &01, &02, &03
    equb &00, &0b, &03, &03
    equb &00, &0b, &23, &03
    equb &00, &0a, &1b, &03
    equb &00, &00, &31, &23
    equb &00, &05, &1b, &23
    equb &00, &05, &1b, &22
    equb &00, &00, &31, &22
    equb &00, &00, &1b, &02
    equb &00, &0b, &23, &00
    equb &05, &03, &02, &00
    equb &00, &00, &00, &00
.sprite_barbarian_up_0
    equb &00, &00, &3f, &3f
    equb &00, &0f, &05, &0a
    equb &01, &0f, &2d, &1e
    equb &01, &0f, &05, &0a
    equb &0b, &02, &00, &03
    equb &0f, &1a, &20, &0f
    equb &0f, &34, &38, &0f
    equb &0f, &30, &30, &0f
    equb &0f, &34, &38, &0f
    equb &0b, &1a, &25, &07
    equb &05, &03, &0b, &0a
    equb &00, &0b, &07, &00
.sprite_barbarian_up_1
    equb &00, &15, &3f, &2a
    equb &05, &0a, &0f, &00
    equb &07, &1e, &0f, &28
    equb &07, &0a, &0f, &00
    equb &03, &02, &01, &02
    equb &0f, &10, &25, &0a
    equb &0f, &34, &38, &0f
    equb &0f, &30, &30, &0f
    equb &0f, &34, &38, &0f
    equb &0f, &12, &21, &0f
    equb &01, &0b, &07, &02
    equb &00, &07, &03, &00
.sprite_barbarian_right_0
    equb &00, &0f, &02, &00
    equb &05, &0b, &0f, &0a
    equb &05, &0b, &0f, &0a
    equb &0b, &1a, &05, &0a
    equb &07, &34, &20, &28
    equb &0b, &34, &20, &28
    equb &03, &34, &20, &28
    equb &07, &34, &20, &3d
    equb &0b, &12, &05, &1f
    equb &01, &0f, &07, &1f
    equb &05, &0f, &07, &1f
    equb &00, &0f, &03, &3d
.sprite_barbarian_right_1
    equb &00, &0f, &02, &28
    equb &05, &0b, &0f, &0a
    equb &05, &0b, &0f, &0a
    equb &03, &1a, &05, &0a
    equb &0b, &34, &20, &28
    equb &03, &34, &20, &3d
    equb &0b, &34, &25, &1f
    equb &07, &34, &25, &1f
    equb &0b, &1a, &07, &1f
    equb &05, &0f, &07, &15
    equb &05, &0f, &03, &00
    equb &00, &0f, &00, &00
.sprite_barbarian_down_0
    equb &00, &0b, &07, &00
    equb &05, &07, &03, &0a
    equb &0b, &1a, &25, &07
    equb &0f, &34, &38, &0f
    equb &0f, &30, &30, &0f
    equb &0f, &34, &38, &0f
    equb &0f, &10, &25, &0f
    equb &03, &00, &01, &07
    equb &05, &0a, &0f, &02
    equb &2d, &1e, &0f, &02
    equb &05, &0a, &0f, &00
    equb &3f, &3f, &00, &00
.sprite_barbarian_down_1
    equb &00, &03, &0b, &00
    equb &01, &0b, &07, &02
    equb &0f, &12, &21, &0f
    equb &0f, &34, &38, &0f
    equb &0f, &30, &30, &0f
    equb &0f, &34, &38, &0f
    equb &05, &1a, &20, &0f
    equb &01, &02, &01, &03
    equb &00, &0f, &05, &0b
    equb &14, &0f, &2d, &0b
    equb &00, &0f, &05, &0a
    equb &15, &3f, &2a, &00
.sprite_barbarian_left_0
    equb &3e, &03, &0f, &00
    equb &2f, &0b, &0f, &0a
    equb &2f, &0b, &0f, &02
    equb &2f, &0a, &21, &07
    equb &3e, &10, &38, &0b
    equb &14, &10, &38, &03
    equb &14, &10, &38, &07
    equb &14, &10, &38, &0b
    equb &05, &0a, &25, &07
    equb &05, &0f, &07, &0a
    equb &05, &0f, &07, &0a
    equb &00, &01, &0f, &00
.sprite_barbarian_left_1
    equb &00, &00, &0f, &00
    equb &00, &03, &0f, &0a
    equb &2a, &0b, &0f, &0a
    equb &2f, &0b, &25, &07
    equb &2f, &1a, &38, &0b
    equb &2f, &1a, &38, &07
    equb &3e, &10, &38, &03
    equb &14, &10, &38, &07
    equb &05, &0a, &25, &03
    equb &05, &0f, &07, &0a
    equb &05, &0f, &07, &0a
    equb &14, &01, &0f, &00
.sprite_fighter_up_0
    equb &00, &15, &00, &00
    equb &00, &00, &2a, &00
    equb &28, &0a, &15, &00
    equb &2d, &0e, &00, &2b
    equb &39, &0e, &00, &03
    equb &39, &26, &0a, &33
    equb &39, &23, &0b, &33
    equb &39, &27, &0f, &33
    equb &00, &36, &3c, &22
    equb &00, &3e, &3c, &2a
    equb &15, &00, &0c, &15
    equb &00, &00, &0c, &00
.sprite_fighter_up_1
    equb &00, &28, &00, &15
    equb &00, &28, &00, &15
    equb &14, &00, &00, &15
    equb &14, &27, &04, &1d
    equb &39, &27, &04, &1d
    equb &39, &22, &0e, &1d
    equb &11, &32, &1a, &03
    equb &00, &27, &0f, &33
    equb &00, &36, &3c, &33
    equb &00, &3e, &3c, &2a
    equb &15, &04, &08, &15
    equb &00, &04, &08, &00
.sprite_fighter_right_0
    equb &00, &3c, &3c, &28
    equb &00, &11, &22, &00
    equb &2a, &33, &27, &0a
    equb &15, &39, &05, &00
    equb &14, &06, &08, &00
    equb &14, &0f, &08, &00
    equb &14, &0f, &00, &00
    equb &1c, &02, &00, &15
    equb &1d, &28, &00, &2a
    equb &3b, &33, &17, &00
    equb &00, &33, &0a, &00
    equb &00, &01, &0a, &00
.sprite_fighter_right_1
    equb &00, &00, &28, &00
    equb &2a, &33, &36, &00
    equb &15, &39, &33, &28
    equb &1c, &02, &11, &1e
    equb &1c, &0f, &00, &0a
    equb &14, &0f, &00, &00
    equb &14, &02, &00, &00
    equb &15, &2c, &08, &00
    equb &3b, &26, &08, &00
    equb &11, &23, &00, &00
    equb &11, &23, &3f, &3f
    equb &00, &00, &00, &00
.sprite_fighter_down_0
    equb &00, &0c, &00, &00
    equb &2a, &0c, &00, &2a
    equb &15, &3c, &3d, &00
    equb &11, &3c, &39, &00
    equb &33, &0f, &1b, &36
    equb &33, &07, &13, &36
    equb &33, &05, &19, &36
    equb &03, &00, &0d, &36
    equb &17, &00, &0d, &1e
    equb &00, &2a, &05, &14
    equb &00, &15, &00, &00
    equb &00, &00, &2a, &00
.sprite_fighter_down_1
    equb &00, &04, &08, &00
    equb &2a, &04, &08, &2a
    equb &15, &3c, &3d, &00
    equb &33, &3c, &39, &00
    equb &33, &0f, &1b, &00
    equb &03, &25, &31, &22
    equb &2e, &0d, &11, &36
    equb &2e, &08, &1b, &36
    equb &2e, &08, &1b, &28
    equb &2a, &00, &00, &28
    equb &2a, &00, &14, &00
    equb &2a, &00, &14, &00
.sprite_fighter_left_0
    equb &00, &05, &02, &00
    equb &00, &05, &33, &00
    equb &00, &2b, &33, &37
    equb &15, &00, &14, &2e
    equb &2a, &00, &01, &2c
    equb &00, &00, &0f, &28
    equb &00, &04, &0f, &28
    equb &00, &04, &09, &28
    equb &00, &0a, &36, &2a
    equb &05, &1b, &33, &15
    equb &00, &11, &22, &00
    equb &14, &3c, &3c, &00
.sprite_fighter_left_1
    equb &3f, &3f, &13, &22
    equb &00, &00, &13, &22
    equb &00, &04, &19, &37
    equb &00, &04, &1c, &2a
    equb &00, &00, &01, &28
    equb &00, &00, &0f, &28
    equb &05, &00, &0f, &2c
    equb &2d, &22, &01, &2c
    equb &14, &33, &36, &2a
    equb &00, &39, &33, &15
    equb &00, &14, &00, &00
    equb &00, &00, &00, &00
.sprite_fireball_up
    equb &00, &00, &0a, &00
    equb &00, &01, &03, &00
    equb &00, &05, &07, &00
    equb &00, &01, &0b, &00
    equb &00, &05, &07, &00
    equb &00, &05, &07, &00
    equb &00, &05, &0f, &00
    equb &00, &00, &0a, &00
    equb &00, &00, &0a, &00
    equb &00, &00, &0a, &00
    equb &00, &00, &0a, &00
    equb &00, &00, &0a, &00
.sprite_fireball_right
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &05, &0a
    equb &00, &0f, &0b, &07
    equb &0f, &0b, &07, &07
    equb &00, &0f, &0b, &07
    equb &00, &00, &05, &0a
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
.sprite_fireball_down
    equb &00, &00, &0a, &00
    equb &00, &00, &0a, &00
    equb &00, &00, &0a, &00
    equb &00, &00, &0a, &00
    equb &00, &00, &0a, &00
    equb &00, &05, &0f, &00
    equb &00, &05, &07, &00
    equb &00, &05, &07, &00
    equb &00, &01, &0b, &00
    equb &00, &05, &07, &00
    equb &00, &01, &03, &00
    equb &00, &00, &0a, &00
.sprite_fireball_left
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &05, &0a, &00, &00
    equb &0b, &07, &0f, &00
    equb &0b, &0b, &07, &0f
    equb &0b, &07, &0f, &00
    equb &05, &0a, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
.sprite_axe_up
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &15, &2a
    equb &00, &00, &3f, &3f
    equb &00, &00, &15, &2a
    equb &14, &3c, &3c, &3c
    equb &00, &00, &15, &2a
    equb &00, &00, &3f, &3f
    equb &00, &00, &15, &2a
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
.sprite_axe_right
    equb &00, &00, &00, &00
    equb &00, &14, &00, &00
    equb &00, &14, &00, &00
    equb &00, &14, &00, &00
    equb &00, &14, &00, &00
    equb &15, &14, &15, &00
    equb &15, &3e, &3f, &00
    equb &15, &3e, &3f, &00
    equb &15, &3e, &3f, &00
    equb &15, &14, &15, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
.sprite_axe_down
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &15, &2a, &00, &00
    equb &3f, &3f, &00, &00
    equb &15, &2a, &00, &00
    equb &3c, &3c, &3c, &28
    equb &15, &2a, &00, &00
    equb &3f, &3f, &00, &00
    equb &15, &2a, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
.sprite_axe_left
    equb &00, &00, &00, &00
    equb &00, &2a, &28, &2a
    equb &00, &3f, &3d, &2a
    equb &00, &3f, &3d, &2a
    equb &00, &3f, &3d, &2a
    equb &00, &2a, &28, &2a
    equb &00, &00, &28, &00
    equb &00, &00, &28, &00
    equb &00, &00, &28, &00
    equb &00, &00, &28, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
.sprite_key
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &0a
    equb &00, &00, &05, &05
    equb &00, &00, &05, &05
    equb &0f, &0f, &0f, &05
    equb &0a, &0a, &05, &05
    equb &0a, &0a, &05, &05
    equb &0a, &0a, &00, &0a
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
.sprite_treasure
    equb &03, &03, &02, &02
    equb &13, &50, &02, &02
    equb &02, &24, &17, &03
    equb &47, &00, &02, &03
    equb &12, &0d, &02, &03
    equb &02, &4f, &02, &03
    equb &06, &32, &02, &03
    equb &47, &02, &02, &03
    equb &12, &a5, &02, &03
    equb &07, &08, &17, &03
    equb &06, &b0, &02, &02
    equb &03, &03, &02, &02
.sprite_food
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &2a, &00, &00, &00
    equb &2a, &00, &00, &00
    equb &15, &00, &00, &00
    equb &2f, &2a, &0f, &00
    equb &2f, &0f, &0f, &0a
    equb &00, &0f, &03, &0b
    equb &00, &05, &0f, &03
    equb &00, &05, &07, &02
    equb &00, &00, &03, &02
    equb &00, &00, &03, &00
    equb &05, &0f, &0f, &00, &0a, &0f, &0f, &0a
    equb &0a, &00, &05, &00, &05, &30, &20, &0a
    equb &05, &00, &00, &0a, &00, &1a, &30, &05
    equb &00, &0a, &00, &05, &0f, &1a, &30, &25
    equb &0f, &00, &00, &0a, &0a, &30, &30, &0a
    equb &05, &00, &00, &0a, &00, &0f, &0f, &00
.sprite_teleporter
    equb &3f, &3f, &3f, &3f
    equb &3e, &3c, &3c, &38
    equb &3e, &3c, &3c, &38
    equb &3e, &3f, &3f, &38
    equb &3e, &3e, &38, &38
    equb &3e, &3e, &38, &38
    equb &3e, &3e, &38, &38
    equb &3e, &3e, &38, &38
    equb &3e, &30, &30, &38
    equb &3e, &3c, &3c, &38
    equb &3e, &3c, &3c, &38
    equb &30, &30, &30, &30
    equb &00, &2c, &00, &00, &00, &2c, &08, &00
    equb &00, &0c, &08, &00, &04, &0f, &0e, &00
.sprite_digit_0
    equb &04, &08
    equb &08, &0c
    equb &08, &0c
    equb &08, &0c
    equb &08, &0c
    equb &0c, &04
    equb &0c, &04
    equb &0c, &04
    equb &0c, &04
    equb &04, &08
.sprite_digit_1
    equb &04, &00
    equb &0c, &00
    equb &04, &00
    equb &04, &00
    equb &04, &00
    equb &04, &00
    equb &04, &00
    equb &04, &00
    equb &04, &00
    equb &0c, &00
.sprite_digit_2
    equb &04, &08
    equb &08, &04
    equb &08, &04
    equb &00, &04
    equb &00, &08
    equb &04, &00
    equb &08, &00
    equb &08, &04
    equb &08, &08
    equb &0c, &0c
.sprite_digit_3
    equb &04, &08
    equb &08, &04
    equb &00, &04
    equb &00, &04
    equb &04, &08
    equb &04, &08
    equb &00, &04
    equb &00, &04
    equb &0c, &04
    equb &04, &08
.sprite_digit_4
    equb &00, &08
    equb &04, &08
    equb &04, &08
    equb &08, &08
    equb &08, &0c
    equb &0c, &08
    equb &00, &0c
    equb &00, &08
    equb &00, &08
    equb &04, &08
.sprite_digit_5
    equb &0c, &0c
    equb &08, &04
    equb &08, &00
    equb &08, &00
    equb &04, &00
    equb &00, &08
    equb &00, &04
    equb &04, &04
    equb &08, &04
    equb &04, &08
.sprite_digit_6
    equb &00, &04
    equb &00, &08
    equb &04, &00
    equb &04, &00
    equb &04, &08
    equb &08, &04
    equb &08, &04
    equb &08, &04
    equb &08, &04
    equb &04, &08
.sprite_digit_7
    equb &0c, &0c
    equb &00, &04
    equb &00, &08
    equb &00, &08
    equb &00, &08
    equb &04, &00
    equb &04, &00
    equb &04, &00
    equb &04, &00
    equb &0c, &08
.sprite_digit_8
    equb &04, &08
    equb &08, &04
    equb &08, &04
    equb &08, &04
    equb &04, &08
    equb &08, &04
    equb &08, &04
    equb &08, &04
    equb &08, &04
    equb &04, &08
.sprite_digit_9
    equb &04, &08
    equb &08, &04
    equb &08, &04
    equb &08, &04
    equb &08, &04
    equb &04, &08
    equb &00, &08
    equb &00, &08
    equb &04, &00
    equb &08, &00
.sprite_door_horizontal
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &3f, &3f, &3f, &3f
    equb &3e, &3c, &3c, &38
    equb &3e, &3c, &3c, &38
    equb &3e, &3c, &3c, &38
    equb &3e, &3c, &3c, &38
    equb &30, &30, &30, &30
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &0f, &1a, &30, &20, &00, &00, &00, &25
.sprite_sparkle_0
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &15, &2a, &00
    equb &00, &3f, &3f, &00
    equb &00, &3f, &3f, &00
    equb &00, &15, &2a, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
.sprite_sparkle_1
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &3f, &3f, &00
    equb &00, &00, &00, &00
    equb &15, &15, &2a, &2a
    equb &15, &00, &00, &2a
    equb &15, &00, &00, &2a
    equb &15, &15, &2a, &2a
    equb &00, &00, &00, &00
    equb &00, &3f, &3f, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
.sprite_sparkle_2
    equb &00, &00, &00, &00
    equb &15, &3f, &3f, &2a
    equb &00, &3f, &3f, &00
    equb &2a, &00, &00, &15
    equb &3f, &00, &00, &3f
    equb &3f, &15, &2a, &3f
    equb &3f, &15, &2a, &3f
    equb &3f, &00, &00, &3f
    equb &2a, &00, &00, &15
    equb &00, &3f, &3f, &00
    equb &15, &3f, &3f, &2a
    equb &00, &00, &00, &00
.sprite_sparkle_3
    equb &3f, &00, &00, &3f
    equb &3f, &2a, &15, &3f
    equb &2a, &2a, &15, &15
    equb &2a, &00, &00, &15
    equb &3f, &15, &2a, &3f
    equb &15, &2a, &15, &2a
    equb &15, &2a, &15, &2a
    equb &3f, &15, &2a, &3f
    equb &2a, &00, &00, &15
    equb &2a, &2a, &15, &15
    equb &3f, &2a, &15, &3f
    equb &3f, &00, &00, &3f
.sprite_trapdoor
    equb &3c, &3c, &3c, &3c
    equb &29, &03, &03, &16
    equb &3f, &12, &03, &16
    equb &3f, &03, &03, &34
    equb &29, &03, &21, &16
    equb &29, &03, &03, &16
    equb &29, &21, &21, &16
    equb &29, &03, &03, &34
    equb &3f, &03, &21, &16
    equb &3f, &03, &03, &16
    equb &29, &21, &12, &16
    equb &3c, &3c, &3c, &3c
    equb &00, &00, &00, &00, &04, &00, &00, &00
    equb &20, &00, &00, &00, &fd, &14, &93, &00
.sprite_arrow_up
    equb &00, &00, &00, &00
    equb &00, &15, &00, &00
    equb &00, &15, &00, &00
    equb &00, &05, &00, &00
    equb &00, &05, &00, &00
    equb &00, &05, &00, &00
    equb &00, &05, &00, &00
    equb &00, &05, &00, &00
    equb &00, &05, &00, &00
    equb &00, &0c, &08, &00
    equb &00, &08, &08, &00
    equb &00, &00, &00, &00
.sprite_arrow_right
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &0c, &00, &00, &00
    equb &04, &0f, &0f, &2a
    equb &0c, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
.sprite_arrow_down
    equb &00, &00, &00, &00
    equb &00, &04, &04, &00
    equb &00, &04, &0c, &00
    equb &00, &00, &0a, &00
    equb &00, &00, &0a, &00
    equb &00, &00, &0a, &00
    equb &00, &00, &0a, &00
    equb &00, &00, &0a, &00
    equb &00, &00, &0a, &00
    equb &00, &00, &2a, &00
    equb &00, &00, &2a, &00
    equb &00, &00, &00, &00
.sprite_arrow_left
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &0c
    equb &15, &0f, &0f, &08
    equb &00, &00, &00, &0c
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
    equb &00, &00, &00, &00
.sprite_door_vertical
    equb &00, &3f, &3a, &00
    equb &00, &3e, &38, &00
    equb &00, &3e, &38, &00
    equb &00, &3e, &38, &00
    equb &00, &3e, &38, &00
    equb &00, &3e, &38, &00
    equb &00, &3e, &38, &00
    equb &00, &3e, &38, &00
    equb &00, &3e, &38, &00
    equb &00, &3e, &38, &00
    equb &00, &3e, &38, &00
    equb &00, &30, &30, &00
    equb &01, &00, &00, &00, &17, &00, &00, &90
    equb &17, &00, &00, &00, &00, &00, &00, &00
; &2d00 used as index base 1 time by &3cba
.wall_sprite
    equb &0f, &0b, &0f, &07
    equb &03, &0f, &0f, &0f
    equb &0f, &1f, &2f, &0b
    equb &0f, &2f, &0b, &0f
    equb &1f, &0f, &0f, &07
    equb &1f, &1f, &0f, &07
    equb &17, &0f, &07, &07
    equb &1f, &0f, &0f, &07
    equb &0f, &2f, &0b, &0f
    equb &07, &0b, &07, &0f
    equb &0f, &0f, &0f, &03
    equb &0b, &0f, &0f, &0f
.sprite_ranger_up_0
    equb &00, &03, &0b, &00
    equb &01, &00, &0a, &02
    equb &02, &00, &04, &01
    equb &01, &02, &04, &00
    equb &0b, &02, &00, &08
    equb &0b, &07, &00, &08
    equb &1c, &25, &34, &08
    equb &1c, &0f, &1e, &08
    equb &04, &3c, &29, &08
    equb &04, &3c, &0c, &00
    equb &00, &0c, &09, &00
    equb &00, &00, &03, &00
.sprite_ranger_up_1
    equb &00, &03, &02, &00
    equb &00, &00, &01, &00
    equb &00, &00, &00, &0a
    equb &05, &00, &03, &0a
    equb &05, &00, &03, &09
    equb &04, &05, &03, &09
    equb &0c, &25, &34, &09
    equb &1c, &0f, &1e, &09
    equb &04, &3c, &28, &08
    equb &04, &3c, &0c, &00
    equb &01, &0c, &08, &00
    equb &01, &02, &00, &00
.sprite_ranger_right_0
    equb &00, &04, &0b, &00
    equb &00, &0c, &0b, &00
    equb &04, &09, &02, &02
    equb &04, &3c, &02, &03
    equb &14, &1a, &02, &01
    equb &3c, &0f, &0a, &01
    equb &3c, &0f, &0a, &0d
    equb &16, &1a, &04, &0d
    equb &03, &3c, &0c, &03
    equb &03, &06, &08, &02
    equb &00, &00, &01, &00
    equb &00, &00, &01, &00
.sprite_ranger_right_1
    equb &00, &00, &08, &00
    equb &00, &0c, &0d, &00
    equb &06, &0c, &05, &00
    equb &06, &3c, &00, &00
    equb &16, &1a, &00, &01
    equb &3c, &0f, &0a, &01
    equb &3c, &0f, &0a, &01
    equb &14, &1a, &03, &01
    equb &00, &3c, &09, &03
    equb &00, &0c, &0d, &02
    equb &00, &04, &07, &02
    equb &00, &03, &02, &00
.sprite_ranger_down_0
    equb &00, &03, &00, &00
    equb &00, &06, &0c, &00
    equb &00, &0c, &3c, &08
    equb &04, &16, &3c, &08
    equb &04, &2d, &0f, &2c
    equb &04, &38, &1a, &2c
    equb &04, &00, &0b, &07
    equb &04, &00, &01, &07
    equb &00, &08, &01, &02
    equb &02, &08, &00, &01
    equb &01, &05, &00, &02
    equb &00, &07, &03, &00
.sprite_ranger_down_1
    equb &00, &00, &01, &02
    equb &00, &04, &0c, &02
    equb &00, &0c, &3c, &08
    equb &04, &14, &3c, &08
    equb &06, &2d, &0f, &2c
    equb &06, &38, &1a, &0c
    equb &06, &03, &0a, &08
    equb &06, &03, &00, &0a
    equb &05, &03, &00, &0a
    equb &05, &00, &00, &00
    equb &00, &02, &00, &00
    equb &00, &01, &03, &00
.sprite_ranger_left_0
    equb &00, &02, &00, &00
    equb &00, &02, &00, &00
    equb &01, &04, &09, &03
    equb &03, &0c, &3c, &03
    equb &0e, &08, &25, &29
    equb &0e, &05, &0f, &3c
    equb &02, &05, &0f, &3c
    equb &02, &01, &25, &28
    equb &03, &01, &3c, &08
    equb &01, &01, &06, &08
    equb &00, &07, &0c, &00
    equb &00, &07, &08, &00
.sprite_monster_up_0
    equb &00, &00, &00, &02
    equb &00, &00, &01, &13
    equb &04, &08, &01, &13
    equb &45, &30, &8b, &13
    equb &10, &30, &20, &02
    equb &1a, &30, &20, &02
    equb &1a, &30, &25, &07
    equb &1e, &30, &2d, &0f
    equb &3c, &3c, &2d, &0a
    equb &14, &3c, &2c, &00
    equb &00, &00, &0c, &00
    equb &00, &00, &0c, &00
.sprite_monster_up_1
    equb &00, &04, &08, &00
    equb &00, &04, &08, &02
    equb &45, &30, &8b, &13
    equb &10, &30, &21, &13
    equb &10, &30, &21, &13
    equb &1a, &30, &20, &02
    equb &0f, &30, &00, &02
    equb &1e, &3c, &2d, &07
    equb &1e, &3c, &2d, &0f
    equb &14, &3c, &2d, &0a
    equb &04, &08, &00, &00
    equb &04, &08, &00, &00
.sprite_monster_right_0
    equb &00, &2d, &0a, &00
    equb &14, &2d, &00, &00
    equb &14, &38, &8e, &08
    equb &14, &30, &24, &08
    equb &14, &30, &24, &08
    equb &14, &30, &20, &00
    equb &1c, &30, &20, &00
    equb &1c, &38, &8a, &00
    equb &0c, &28, &00, &00
    equb &00, &3c, &01, &02
    equb &00, &0f, &03, &03
    equb &00, &0f, &11, &22
.sprite_monster_right_1
    equb &00, &2d, &0a, &00
    equb &14, &2d, &00, &00
    equb &1c, &38, &8a, &00
    equb &1c, &30, &20, &00
    equb &1c, &30, &20, &00
    equb &14, &30, &24, &08
    equb &3c, &30, &24, &08
    equb &3c, &10, &8e, &08
    equb &0f, &00, &00, &00
    equb &0f, &01, &02, &00
    equb &0b, &03, &03, &00
    equb &00, &11, &22, &00
.sprite_monster_down_0
    equb &00, &0c, &00, &00
    equb &00, &0c, &00, &00
    equb &00, &1c, &3c, &28
    equb &05, &1e, &3c, &3c
    equb &0f, &1e, &30, &2d
    equb &0b, &1a, &30, &25
    equb &01, &10, &30, &25
    equb &01, &10, &30, &20
    equb &23, &47, &30, &8a
    equb &23, &02, &04, &08
    equb &23, &02, &00, &00
    equb &01, &00, &00, &00
.sprite_monster_down_1
    equb &00, &00, &04, &08
    equb &00, &00, &04, &08
    equb &05, &1e, &3c, &28
    equb &0f, &1e, &3c, &2d
    equb &0b, &1e, &3c, &2d
    equb &01, &00, &30, &0f
    equb &01, &10, &30, &25
    equb &23, &12, &30, &20
    equb &23, &12, &30, &20
    equb &23, &47, &30, &8a
    equb &01, &04, &08, &00
    equb &00, &04, &08, &00
.sprite_monster_left_0
    equb &11, &22, &0f, &00
    equb &03, &03, &0f, &00
    equb &01, &02, &3c, &00
    equb &00, &00, &14, &0c
    equb &00, &45, &34, &2c
    equb &00, &10, &30, &2c
    equb &00, &10, &30, &28
    equb &04, &18, &30, &28
    equb &04, &18, &30, &28
    equb &04, &4d, &34, &28
    equb &00, &00, &1e, &28
    equb &00, &05, &1e, &00
.sprite_monster_left_1
    equb &00, &11, &22, &00
    equb &00, &03, &03, &07
    equb &00, &01, &02, &0f
    equb &00, &00, &00, &0f
    equb &04, &4d, &20, &3c
    equb &04, &18, &30, &3c
    equb &04, &18, &30, &28
    equb &00, &10, &30, &2c
    equb &00, &10, &30, &2c
    equb &00, &45, &34, &2c
    equb &00, &00, &1e, &28
    equb &00, &05, &1e, &00

    org &4880
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
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
; ***************************************************************************************
; Coder: load the game and the next level
;
; Run with *RUN CODER at the start of every level. Count the level, reload Dun1 (which
; contains this code, so the bytes being run are rewritten with identical ones), load the
; level file at &6B00 (level 25 comes from the end of Stones), copy one of the two
; &0400-&07FF images and the &08C0-&1FFF image into place, and enter the game.
.coder_start
    lda #osbyte_escape_break_effect     ; OSBYTE &C8: set the ESCAPE and BREAK effect...
    ldx #1                              ; ...with X = 1: ESCAPE disabled
    ldy #0
    jsr osbyte                          ; osbyte: escape break effect
    lda #6                              ; VDU 6, 3: enable the screen, disable the printer
    jsr oswrch
    lda #3
    jsr oswrch
    lda #0                              ; Cancel the BREAK intercept
    sta os_break_intercept              ; ...
    inc levels_started                  ; Count the level
    lda data_08be                       ; Advance the ASCII level number...
    cmp #&20 ; ' '
    beq code_5036
    clc
    adc #1
    sta data_08be
    cmp #&3a ; ':'
    bcc code_504a
    lda #&30 ; '0'
    sta data_08be
    inc level_digits
    bne code_504a
; &5036 referenced 1 time by &5020
.code_5036
    inc level_digits
    lda level_digits
    cmp #&3a ; ':'
    bcc code_504a
    lda #&31 ; '1'
    sta level_digits
    lda #&30 ; '0'
    sta data_08be
; &504a referenced 3 times by &502a, &5034, &503e
.code_504a
    ldx #0                              ; VDU 23 commands that set up the 6845 for loading
; &504c referenced 1 time by &5055
.loop_504c
    lda data_5179,x
    jsr oswrch
    inx
    cpx #&15
    bne loop_504c
    lda #&15                            ; VDU 21: disable the screen...
    jsr oswrch
    ldx #&5d ; ']'                      ; ...and reload Dun1
    ldy #&51 ; 'Q'
    jsr oscli
    lda level_digits                    ; Put the level number's digits in level_command
    sta level_command_digits
    lda data_08be
    sta data_5172
    lda levels_started                  ; Leave the level count in level_count_copy for game_entry
    sta level_count_copy
    lda levels_started                  ; level_number = levels started - 1 (game_entry counts it again)
    sec
    sbc #1
    sta level_number
    cmp #&18                            ; Level 25?
    bne code_508b
    ldx #&4c ; 'L'                      ; Yes: load Stones, which ends with level 25...
    ldy #&51 ; 'Q'
    jsr oscli
    jmp code_5092                       ; ...
; &508b referenced 1 time by &507f
.code_508b
    ldx #&67 ; 'g'                      ; No: load LEVELnn
    ldy #&51 ; 'Q'
    jsr oscli
; &5092 referenced 1 time by &5088
.code_5092
    lda #6                              ; VDU 6: enable the screen
    jsr oswrch
    lda #0                              ; Copy to &0400...
    sta sprite_width
    lda #4
    sta sprite_height
    lda #&b0                            ; ...from &51B0 or &55B0
    sta plot_x
    lda #osbyte_read_adc_or_get_buffer_status  ; Read the joystick's horizontal channel
    ldx #1
    jsr osbyte                          ; Read ADC channel X or buffer status
    cpy #&80                            ; High byte &80 (a joystick at rest?)...
    bne code_50b4
    lda #&55 ; 'U'                      ; ...yes: copy the image with the joystick handler, at &55B0
    sta plot_y
    bne code_50b8
; &50b4 referenced 1 time by &50ac
.code_50b4
    lda #&51 ; 'Q'                      ; ...no: copy the keyboard-only image at &51B0
    sta plot_y
; &50b8 referenced 1 time by &50b2
.code_50b8
    ldy #0
; &50ba referenced 1 time by &50ce
.loop_50ba
    lda (plot_x),y
    sta (sprite_width),y
    inc sprite_width
    bne code_50c4
    inc sprite_height
; &50c4 referenced 1 time by &50c0
.code_50c4
    inc plot_x
    bne code_50ca
    inc plot_y
; &50ca referenced 1 time by &50c6
.code_50ca
    lda sprite_height
    cmp #8
    bne loop_50ba
    lda #osbyte_read_adc_or_get_buffer_status
    ldx #1
    jsr osbyte                          ; Read ADC channel X or buffer status
    cpy #&80
    bne code_50e5
    lda #&80
    sta bytev
    lda #7
    sta bytev + 1
; &50e5 referenced 1 time by &50d9
.code_50e5
    lda #&11
    jsr oswrch
    lda #2
    jsr oswrch
    ldx #0
; &50f1 referenced 1 time by &50fa
.loop_50f1
    lda data_518e,x
    jsr oswrch
    inx
    cpx #&14
    bne loop_50f1
    lda levels_started
    cmp #2
    bcs code_510b
    lda #0
    sta data_0080
    sta data_0081
    beq code_5113
; &510b referenced 1 time by &5101
.code_510b
    lda #&40 ; '@'
    sta data_0080
    lda #4
    sta data_0081
; &5113 referenced 1 time by &5109
.code_5113
    lda data_0080
    sta plot_x
    lda #&30 ; '0'
    clc
    adc data_0081
    sta plot_y
    lda #&c0
    clc
    adc data_0080
    sta sprite_width
    lda #8
    adc data_0081
    sta sprite_height
    ldy #0
; &512d referenced 2 times by &5141, &5147
.code_512d
    lda (plot_x),y
    sta (sprite_width),y
    inc plot_x
    bne code_5137
    inc plot_y
; &5137 referenced 1 time by &5133
.code_5137
    inc sprite_width
    bne code_513d
    inc sprite_height
; &513d referenced 1 time by &5139
.code_513d
    lda plot_x
    cmp #&40 ; '@'
    bne code_512d
    lda plot_y
    cmp #&47 ; 'G'
    bne code_512d
    jmp game_entry
.stones_command
    equs "LOAD STONES 6680"
    equb &0d
.dun1_command
    equs "LOAD DUN1"
    equb &0d
.level_command
; &5171 referenced 1 time by &5066
level_command_digits = level_command+10
; &5172 referenced 1 time by &506c
data_5172 = level_command+11
    equs "LOAD LEVEL   6B00"
.sub_5178
; &5179 used as index base 1 time by &504c
data_5179 = sub_5178+1
; &518e used as index base 1 time by &50f1
data_518e = sub_5178+22
    equb &0d, &17, &00, &01, &00, &00, &00, &00
    equb &00, &00, &00, &17, &00, &0a, &20, &00
    equb &00, &00, &00, &00, &00, &00, &17, &00
    equb &01, &50, &00, &00, &00, &00, &00, &00
    equb &17, &00, &06, &17, &00, &00, &00, &00
    equb &00, &00, &85, &70, &bd, &d0, &7d, &18
    equb &69, &18, &85, &71, &8a, &48, &20, &00

    org &59b0
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
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
; &6b00 used as index base 1 time by &3c52
.level_object_x
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
; &6b20 used as index base 1 time by &3c58
.level_object_y
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
; &6b40 used as index base 1 time by &3c5e
.level_object_type
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
; &6b60 used as index base 1 time by &3c69
.level_door_x
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00
; &6b75 used as index base 1 time by &3c6f
.level_door_y
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00
; &6b8a used as index base 1 time by &3c75
.level_door_sprite
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00
; &6ba0 used as index base 1 time by &3c80
.level_key_x
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00
; &6bb5 used as index base 1 time by &3c86
.level_key_y
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00
; &6bd0 used as index base 1 time by &3c91
.level_trapdoor_x
    equb &00, &00, &00, &00, &00, &00, &00, &00
; &6bd8 used as index base 1 time by &3c97
.level_trapdoor_y
    equb &00, &00, &00, &00, &00, &00, &00, &00
; &6be0 used as index base 1 time by &3ca4
.level_walls
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
; &6cb0 used as index base 1 time by &3caa
.level_object_free_map
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
; &6d80 used as index base 1 time by &3cb7
.level_wall_sprite
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
; ***************************************************************************************
; Move the heroes
;
; For each hero in play: continue a step between cells, or read the hero's keys (and, for
; heroes 0 and 1, the magic key) and start a step or fire a missile; check the new cell
; for walls, monsters, other heroes and objects, change view when the hero enters another
; room, and draw the hero.
; &6e80 referenced 1 time by &4400
.move_heroes
    ldx #0                              ; For each hero...
; &6e82 referenced 1 time by &70c6
.code_6e82
    lda hero_direction,x                ; In play?
    bne code_6e97                       ; Yes
    lda hero_step,x                     ; Out of play: never playing (step &63)?
    cmp #&63 ; 'c'                      ; ...
    bne code_6e91                       ; ...
    jmp next_hero                       ; Yes: nothing to do
; &6e91 referenced 1 time by &6e8c
.code_6e91
    jsr animate_absent_hero             ; No: dying or returning, so animate them
    jmp next_hero                       ; ...
; &6e97 referenced 1 time by &6e85
.code_6e97
    lda hero_x,x                        ; Remember the hero's position and offsets before moving
    sta previous_x                      ; ...
    lda hero_y,x                        ; ...
    sta previous_y                      ; ...
    lda hero_offset_x,x                 ; ...
    sta previous_offset_x               ; ...
    lda hero_offset_y,x                 ; ...
    sta previous_offset_y               ; ...
    lda hero_step,x                     ; Part way through a step?
    beq code_6eba                       ; No: read the keys
    jsr continue_hero_step              ; Yes: continue it...
    jmp erase_hero                      ; ...and redraw
; &6eba referenced 1 time by &6eb2
.code_6eba
    cpx #2                              ; Heroes 0 and 1 check their magic key first
    bcs read_hero_keys                  ; ...
    jmp check_magic                     ; ...
; &6ec1 referenced 2 times by &6ebc, &76ab
.read_hero_keys
    lda hero_key_up,x                   ; Up key?
    jsr test_key                        ; ...
    bne code_6ed4                       ; No
    lda #1                              ; Yes: face up...
    sta hero_direction,x                ; ...
    jsr start_hero_step                 ; ...start the step...
    jmp step_hero                       ; ...and move
; &6ed4 referenced 1 time by &6ec7
.code_6ed4
    lda hero_key_down,x                 ; Down key?
    jsr test_key                        ; ...
    bne code_6ee7                       ; No
    lda #5                              ; Yes: face down...
    sta hero_direction,x                ; ...
    jsr start_hero_step                 ; ...start the step...
    jmp step_hero                       ; ...and move
; &6ee7 referenced 1 time by &6eda
.code_6ee7
    lda hero_key_right,x                ; Right key?
    jsr test_key                        ; ...
    bne code_6efa                       ; No
    lda #3                              ; Yes: face right...
    sta hero_direction,x                ; ...
    jsr start_hero_step                 ; ...start the step...
    jmp step_hero                       ; ...and move
; &6efa referenced 1 time by &6eed
.code_6efa
    lda hero_key_left,x                 ; Left key?
    jsr test_key                        ; ...
    bne code_6f0d                       ; No
    lda #7                              ; Yes: face left...
    sta hero_direction,x                ; ...
    jsr start_hero_step                 ; ...start the step...
    jmp step_hero                       ; ...and move
; &6f0d referenced 1 time by &6f00
.code_6f0d
    lda hero_key_fire,x                 ; Fire key?
    jsr test_key                        ; ...
    beq fire_missile                    ; Yes
    jmp draw_moved_hero                 ; No key: just redraw the hero
; &6f18 referenced 1 time by &6f13
.fire_missile
    txa                                 ; This hero's missile slots are 3x to 3x + hero_max_missiles - 1
    sta scratch                         ; ...
    asl a                               ; ...
    clc                                 ; ...
    adc scratch                         ; ...
    tay                                 ; ...
    adc hero_max_missiles,x             ; ...
    sta scratch                         ; ...end of the range
; &6f28 referenced 1 time by &6f74
.loop_6f28
    lda missile_direction,y             ; Slot free?
    bne code_6f70                       ; No: try the next
    lda hero_direction,x                ; Missile direction = (hero direction + 1) / 2, so 1-4, with bit 7 marking it just fired
    clc                                 ; ...
    adc #1                              ; ...
    lsr a                               ; ...
    ora #&80                            ; ...
    sta missile_direction,y             ; ...
    lda hero_x,x                        ; It starts at the hero's cell
    sta missile_x,y                     ; ...
    lda hero_y,x                        ; ...
    sta missile_y,y                     ; ...
    lda #7                              ; Sound the bell
    jsr oswrch                          ; ...
    lda hero_missile_damage,x           ; The missile carries the hero's missile damage...
    sta missile_damage,y                ; ...
    lda hero_missile_sprites,x          ; ...and sprites
    sta missile_sprite_base,y           ; ...
    lda previous_x                      ; The hero stays where they were
    sta hero_x,x                        ; ...
    lda previous_y                      ; ...
    sta hero_y,x                        ; ...
    lda hero_frame,x                    ; Toggle the hero's frame
    eor #1                              ; ...
    sta hero_frame,x                    ; ...
    jmp draw_moved_hero                 ; Redraw the hero
    equb &88, &d0, &b8
; &6f70 referenced 1 time by &6f2b
.code_6f70
    iny                                 ; Next slot
    cpy scratch                         ; ...
    bne loop_6f28                       ; ...
    jmp draw_moved_hero                 ; All in flight: just redraw the hero
; &6f79 referenced 4 times by &6ed1, &6ee4, &6ef7, &6f0a
.step_hero
    lda hero_direction,x                ; Move the hero's cell in the direction faced: up...
    cmp #1                              ; ...
    bne code_6f83                       ; ...
    dec hero_y,x                        ; ...
; &6f83 referenced 1 time by &6f7e
.code_6f83
    cmp #3                              ; ...right...
    bne code_6f8a                       ; ...
    inc hero_x,x                        ; ...
; &6f8a referenced 1 time by &6f85
.code_6f8a
    cmp #5                              ; ...down...
    bne code_6f91                       ; ...
    inc hero_y,x                        ; ...
; &6f91 referenced 1 time by &6f8c
.code_6f91
    cmp #7                              ; ...left
    bne code_6f98                       ; ...
    dec hero_x,x                        ; ...
; &6f98 referenced 1 time by &6f93
.code_6f98
    lda hero_x,x                        ; Note the new cell for the door and key checks
    sta hero_door_x,x                   ; ...
    lda hero_y,x                        ; ...
    sta hero_door_y,x                   ; ...
    lda hero_x,x                        ; Is there a wall in the new cell?
    sta cell_x                          ; ...
    lda hero_y,x                        ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr test_wall                       ; ...
    pla                                 ; ...
    tax                                 ; ...
    cpy #0                              ; ...
    beq code_6fd5                       ; No
    lda previous_x                      ; Yes: stay put...
    sta hero_x,x                        ; ...
    lda previous_y                      ; ...
    sta hero_y,x                        ; ...
; &6fc7 referenced 1 time by &7050
.code_6fc7
    lda #0                              ; Cancel the step
    sta hero_step,x                     ; ...
    sta hero_offset_x,x                 ; ...
    sta hero_offset_y,x                 ; ...
    jmp erase_hero                      ; ...and redraw
; &6fd5 referenced 1 time by &6fb9
.code_6fd5
    lda #0                              ; Is there a monster in the new cell?
    sta scratch                         ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr find_creature                   ; ...
    pla                                 ; ...
    tax                                 ; ...
    cpy #0                              ; ...
    beq code_7002                       ; No
    lda previous_x                      ; Yes: stay put, cancel the step...
    sta hero_x,x
    lda previous_y
    sta hero_y,x
    lda #0
    sta hero_step,x
    sta hero_offset_x,x
    sta hero_offset_y,x
    jsr lose_health_point               ; ...and lose a health point for bumping into it
    jmp erase_hero                      ; Redraw
; &7002 referenced 1 time by &6fe3
.code_7002
    stx scratch                         ; Is another hero in play in the new cell?
    ldy #0                              ; ...
; &7007 referenced 1 time by &703e
.loop_7007
    cpy scratch                         ; Not this hero
    beq code_703b                       ; ...
    lda hero_x,y                        ; ...
    cmp cell_x                          ; ...
    bne code_703b                       ; ...
    lda hero_y,y                        ; ...
    cmp cell_y                          ; ...
    bne code_703b                       ; ...
    lda hero_direction,y                ; ...
    beq code_703b                       ; ...
    lda previous_x                      ; Yes: stay put, cancel the step and redraw
    sta hero_x,x
    lda previous_y
    sta hero_y,x
    lda #0
    sta hero_step,x
    sta hero_offset_x,x
    sta hero_offset_y,x
    jmp erase_hero
; &703b referenced 4 times by &700a, &7012, &701a, &701f
.code_703b
    iny                                 ; Next hero
    cpy #4                              ; ...
    bne loop_7007                       ; ...
    txa                                 ; Has the hero moved into another room?
    asl a                               ; ...
    tax                                 ; ...
    lda view_room,x                     ; ...
    cmp data_007b                       ; ...
    beq code_7053                       ; No
    txa                                 ; Yes: change this hero's view to the new room...
    lsr a                               ; ...
    tax                                 ; ...
    jsr show_hero_room                  ; ...
    jmp code_6fc7                       ; ...and cancel the step
; &7053 referenced 1 time by &7048
.code_7053
    txa                                 ; Same room. Wearing Boots of Speed?
    lsr a                               ; ...
    tax                                 ; ...
    lda hero_has_boots,x                ; ...
    beq code_7069                       ; No
    lda #0                              ; Yes: arrive in the cell at once, with no step
    sta hero_offset_x,x                 ; ...
    sta hero_offset_y,x                 ; ...
    sta hero_step,x                     ; ...
    jmp erase_hero                      ; ...
; &7069 referenced 1 time by &7059
.code_7069
    lda previous_x                      ; No boots: stay in the old cell for now; continue_hero_step moves on at the end of the step
    sta hero_x,x                        ; ...
    lda previous_y                      ; ...
    sta hero_y,x                        ; ...
; &7075 referenced 5 times by &6eb7, &6fd2, &6fff, &7038, &7066
.erase_hero
    lda #&15                            ; Erase the hero at the old position (blank sprite)
    sta sprite_number                   ; ...
    lda previous_x                      ; ...
    sta cell_x                          ; ...
    lda previous_y                      ; ...
    sta cell_y                          ; ...
    lda previous_offset_x               ; ...
    sta data_007d                       ; ...
    lda previous_offset_y               ; ...
    sta data_007e                       ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_at_cell                    ; ...
    pla                                 ; ...
    tax                                 ; ...
; &7096 referenced 4 times by &6f15, &6f6a, &6f76, &76ae
.draw_moved_hero
    clc                                 ; Still in play?
    lda hero_direction,x                ; ...
    beq next_hero                       ; No
    adc hero_frame,x                    ; Sprite = direction + frame + the hero's sprite base
    adc hero_sprites,x                  ; ...
    sta sprite_number                   ; ...
    jsr draw_hero                       ; Draw the hero
    lda hero_x,x                        ; Can the hero's cell hold an object?
    sta cell_x                          ; ...
    lda hero_y,x                        ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr test_object_free                ; ...
    pla                                 ; ...
    tax                                 ; ...
    cpy #0                              ; ...
    bne next_hero                       ; No
    jsr collect_objects                 ; Yes: pick up whatever is there
; &70c1 referenced 4 times by &6e8e, &6e94, &709a, &70bc
.next_hero
    inx                                 ; Next hero
    cpx #4                              ; ...
    beq return_8                        ; ...
    jmp code_6e82                       ; ...
; &70c9 referenced 1 time by &70c4
.return_8
    rts                                 ; Return
; ***************************************************************************************
; Move the missiles
;
; Advance every missile in flight one cell. A missile stops at a wall, damages a monster
; or hero it meets, and bounces back off an energy drainer, wearing it down.
; &70ca referenced 1 time by &4611
.move_missiles
    lda #0                              ; No pixel offsets for missiles
    sta data_007d                       ; ...
    sta data_007e                       ; ...
    ldx #0                              ; For each of the twelve missile slots...
; &70d2 referenced 1 time by &721d
.code_70d2
    lda missile_direction,x             ; In flight?
    bne code_70da                       ; Yes
    jmp next_missile                    ; No: next slot
; &70da referenced 1 time by &70d5
.code_70da
    bpl code_70e7                       ; Just fired (bit 7 set)?
    and #&7f                            ; Yes: clear the flag...
    sta missile_direction,x             ; ...
    jsr flip_firer_frame                ; ...animate the hero who fired it...
    jmp code_70fe                       ; ...and move it without erasing (it is on the hero)
; &70e7 referenced 1 time by &70da
.code_70e7
    lda #&15                            ; Erase the missile at its old cell
    sta sprite_number                   ; ...
    lda missile_x,x                     ; ...
    sta cell_x                          ; ...
    lda missile_y,x                     ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_at_cell                    ; ...
    pla                                 ; ...
    tax                                 ; ...
; &70fe referenced 1 time by &70e4
.code_70fe
    lda missile_direction,x             ; Move it one cell: up...
    cmp #1                              ; ...
    bne code_7108                       ; ...
    dec missile_y,x                     ; ...
; &7108 referenced 1 time by &7103
.code_7108
    cmp #2                              ; ...right...
    bne code_710f                       ; ...
    inc missile_x,x                     ; ...
; &710f referenced 1 time by &710a
.code_710f
    cmp #3                              ; ...down...
    bne code_7116                       ; ...
    inc missile_y,x                     ; ...
; &7116 referenced 1 time by &7111
.code_7116
    cmp #4                              ; ...left
    bne code_711d                       ; ...
    dec missile_x,x                     ; ...
; &711d referenced 1 time by &7118
.code_711d
    lda missile_x,x                     ; Wall in the new cell?
    sta cell_x                          ; ...
    lda missile_y,x                     ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr test_wall                       ; ...
    beq code_713a                       ; No
; &7130 referenced 2 times by &71fe, &75ab
.missile_spent_pop
    pla                                 ; Yes: the missile is spent
    tax                                 ; ...
; &7132 referenced 1 time by &7153
.missile_spent
    lda #0                              ; Free the slot
    sta missile_direction,x             ; ...
    jmp next_missile                    ; Next slot
; &713a referenced 1 time by &712e
.code_713a
    lda #0                              ; Monster in the new cell (not checking heroes)?
    sta scratch                         ; ...
    jsr find_creature                   ; ...
    beq code_7156                       ; No
    lda monster_sprite,x                ; Yes, but is it alive?
    cmp #&16                            ; ...
    bcs code_7156                       ; No: fly on
    pla                                 ; Alive: hit it
    tay                                 ; ...
    jmp code_757c                       ; ...
; &7150 referenced 1 time by &75a3
.code_7150
    jsr credit_missile_owner            ; Monster killed: a point to the hero who fired...
    jmp missile_spent                   ; ...and the missile is spent
; &7156 referenced 2 times by &7142, &7149
.code_7156
    pla                                 ; Can the new cell hold an object?
    tax                                 ; ...
    lda missile_x,x                     ; ...
    sta cell_x                          ; ...
    lda missile_y,x                     ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr test_object_free                ; ...
    pla                                 ; ...
    tax                                 ; ...
    cpy #0                              ; ...
    bne code_71d9                       ; No: check for heroes
    txa                                 ; Look for an energy drainer at the cell...
    pha                                 ; ...
    ldx #&1e                            ; ...objects 30 to 1
; &7173 referenced 1 time by &71d5
.loop_7173
    lda object_x,x                      ; ...
    cmp cell_x                          ; ...
    bne code_71d4                       ; ...
    lda object_y,x                      ; ...
    cmp cell_y                          ; ...
    bne code_71d4                       ; ...
    lda object_type,x                   ; Is it a drainer (&53-&5E)?
    cmp #&53 ; 'S'                      ; ...
    bcc code_71d7                       ; No
    cmp #&5f ; '_'                      ; ...
    bcs code_71d7                       ; No
    inc object_type,x                   ; Yes: wear it down a stage
    lda object_type,x                   ; ...
    cmp #&5f ; '_'                      ; Worn away?
    bne code_71a0                       ; No
    lda #&ff                            ; Yes: remove it from the level
    sta object_x,x                      ; ...
    sta object_y,x                      ; ...
; &71a0 referenced 1 time by &7196
.code_71a0
    pla                                 ; A point to the hero who fired
    tax                                 ; ...
    jsr credit_missile_owner            ; ...
    lda missile_direction,x             ; Bounce the missile back: up becomes down...
    cmp #1                              ; ...
    bne code_71b4                       ; ...
    lda #3                              ; ...
    sta missile_direction,x             ; ...
    jmp code_71d9                       ; ...
; &71b4 referenced 1 time by &71aa
.code_71b4
    cmp #2                              ; ...right becomes left...
    bne code_71c0                       ; ...
    lda #4                              ; ...
    sta missile_direction,x             ; ...
    jmp code_71d9                       ; ...
; &71c0 referenced 1 time by &71b6
.code_71c0
    cmp #3                              ; ...down becomes up...
    bne code_71cc                       ; ...
    lda #1                              ; ...
    sta missile_direction,x             ; ...
    jmp code_71d9                       ; ...
; &71cc referenced 1 time by &71c2
.code_71cc
    lda #2                              ; ...and left becomes right
    sta missile_direction,x             ; ...
    jmp code_71d9                       ; ...
; &71d4 referenced 2 times by &7179, &7181
.code_71d4
    dex                                 ; Next object
    bne loop_7173                       ; ...
; &71d7 referenced 2 times by &7188, &718c
.code_71d7
    pla                                 ; No drainer here
    tax                                 ; ...
; &71d9 referenced 5 times by &716d, &71b1, &71bd, &71c9, &71d1
.code_71d9
    txa                                 ; Is a hero in the new cell?
    pha                                 ; ...
    ldx #0                              ; ...
; &71dd referenced 1 time by &7204
.loop_71dd
    pla                                 ; ...
    tay                                 ; ...
    pha                                 ; ...
    lda hero_x,x                        ; ...
    cmp cell_x                          ; ...
    bne code_7201                       ; ...
    lda hero_y,x                        ; ...
    cmp cell_y                          ; ...
    bne code_7201                       ; ...
    lda missile_damage,y                ; Yes: they lose the missile's damage in health...
    tay                                 ; ...
; &71f4 referenced 1 time by &71fc
.loop_71f4
    tya                                 ; ...
    pha                                 ; ...
    jsr lose_health_point               ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    bne loop_71f4                       ; ...
    jmp missile_spent_pop               ; ...and the missile is spent
; &7201 referenced 2 times by &71e6, &71ee
.code_7201
    inx                                 ; Next hero
    cpx #4                              ; ...
    bne loop_71dd                       ; ...
    pla                                 ; Nothing hit: draw the missile in its new cell
    tax                                 ; ...
    clc                                 ; ...
    lda missile_sprite_base,x           ; ...
    adc missile_direction,x             ; ...
    sta sprite_number                   ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_at_cell                    ; ...
    pla                                 ; ...
    tax                                 ; ...
; &7218 referenced 2 times by &70d7, &7137
.next_missile
    inx                                 ; Next slot
    cpx #&0c                            ; ...
    beq return_9                        ; ...
    jmp code_70d2                       ; ...
; &7220 referenced 1 time by &721b
.return_9
    rts                                 ; Return
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
; &7221 referenced 8 times by &363f, &6ffc, &71f6, &749a, &7512, &7654, &772a, &79ac
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
; &728c referenced 5 times by &3642, &4445, &73a9, &76a2, &76d4
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
; &7305 referenced 1 time by &460e
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
    lda hero_x,x                        ; Look for an object at the hero's cell
    sta cell_x                          ; ...
    lda hero_y,x                        ; ...
    sta cell_y                          ; ...
    ldy #&1e                            ; ...objects 30 to 1
; &7337 referenced 1 time by &7473
.code_7337
    lda object_x,y                      ; ...
    cmp cell_x                          ; ...
    beq code_7342                       ; ...
    jmp code_7470                       ; ...
; &7342 referenced 1 time by &733d
.code_7342
    lda object_y,y                      ; ...
    cmp cell_y                          ; ...
    beq code_734d                       ; ...
    jmp code_7470                       ; ...
; &734d referenced 1 time by &7348
.code_734d
    tya                                 ; Found: picking up anything loses Boots of Speed
    pha                                 ; ...
    lda #0                              ; ...
    sta hero_has_boots,x                ; ...
    jsr point_at_boots_icon             ; ...remove the bolt from the panel
    jsr erase_boots_icon                ; ...
    pla                                 ; ...
    tay                                 ; ...
    lda object_type,y                   ; Treasure?
    cmp #&28 ; '('                      ; ...
    bne code_738a                       ; No
    txa                                 ; Yes: play the treasure sound
    pha
    tya
    pha
    ldx #<(treasure_envelope)
    ldy #>(treasure_envelope)
    lda #osword_envelope
    jsr osword                          ; ENVELOPE command
    ldx #<(treasure_sound)
    ldy #>(treasure_sound)
    lda #osword_sound
    jsr osword                          ; SOUND command
    pla
    tay
    pla
    tax
    tya                                 ; 20 points
    pha                                 ; ...
    jsr add_ten_points                  ; ...
    jsr add_ten_points                  ; ...
    pla                                 ; ...
    tay                                 ; ...
    jmp code_7467                       ; Remove it
; &738a referenced 1 time by &7361
.code_738a
    cmp #&29 ; ')'                      ; Food?
    bne code_73c3                       ; No
    inc hero_health_tens,x              ; Yes: 10 health...
    lda hero_health_tens,x              ; ...
    cmp #&28 ; '('                      ; ...to at most 99
    bne code_73a0                       ; ...
    lda #&27                            ; ...
    sta hero_health_tens,x              ; ...
    sta hero_health_units,x             ; ...
; &73a0 referenced 1 time by &7396
.code_73a0
    tya                                 ; Redraw the health
    pha                                 ; ...
    jsr code_7266                       ; ...
    ldy #5                              ; 5 points
; &73a7 referenced 1 time by &73af
.loop_73a7
    tya                                 ; ...
    pha                                 ; ...
    jsr add_point                       ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    bne loop_73a7                       ; ...
    txa                                 ; Play the food sound
    pha
    ldx #<(food_sound)
    ldy #>(food_sound)
    lda #osword_sound
    jsr osword                          ; SOUND command
    pla
    tax
    pla
    tay
    jmp code_7467                       ; Remove it
; &73c3 referenced 1 time by &738c
.code_73c3
    cmp #&2b ; '+'                      ; Teleporter?
    bne code_740d                       ; No
; &73c7 referenced 2 times by &73d1, &73d6
.code_73c7
    dey                                 ; Yes: find the previous teleporter in the list...
    lda object_type,y                   ; ...
    cmp #&2b ; '+'                      ; ...
    beq code_73d9                       ; ...
    cpy #0                              ; ...
    bne code_73c7                       ; ...
    ldy data_0dfd                       ; ...wrapping round to the end
    jmp code_73c7                       ; ...
; &73d9 referenced 1 time by &73cd
.code_73d9
    txa                                 ; Play the teleport sound
    pha
    tya
    pha
    ldx #<(teleport_sound)
    ldy #>(teleport_sound)
    lda #osword_sound
    jsr osword                          ; SOUND command
    pla
    tay
    pla
    tax
    lda object_x,y                      ; Move the hero to the cell above it
    sta hero_x,x                        ; ...
    sta cell_x                          ; ...
    lda object_y,y                      ; ...
    sec                                 ; ...
    sbc #1                              ; ...
    sta hero_y,x                        ; ...
    sta cell_y                          ; ...
    lda #0                              ; ...with no step in progress
    sta hero_step,x                     ; ...
    sta hero_offset_x,x                 ; ...
    sta hero_offset_y,x                 ; ...
    jmp show_hero_room                  ; Show the room they arrive in
; &740d referenced 1 time by &73c5
.code_740d
    cmp #&2a ; '*'                      ; Cross of Resurrection?
    bne code_7477                       ; No
    lda #&ff                            ; Yes: remove it
    sta object_x,y                      ; ...
    sta object_y,y                      ; ...
    jsr add_ten_points                  ; 10 points
    txa                                 ; ...
    pha                                 ; ...
    jsr play_pickup_sound               ; Play the pickup sound
    lda returning_hero_queue            ; Anyone waiting to return?
    bne code_7429                       ; Yes
    pla                                 ; No: return
    tax                                 ; ...
    rts                                 ; ...
; &7429 referenced 1 time by &7424
.code_7429
    ldy #0                              ; Take the first entry off the queue, appending 0...
; &742b referenced 1 time by &744a
.loop_742b
    ldx returning_hero_queue            ; ...
    dex                                 ; ...
    lda data_0b2b                       ; ...
    sta returning_hero_queue            ; ...
    lda data_0b2c                       ; ...
    sta data_0b2b                       ; ...
    lda data_0b2d                       ; ...
    sta data_0b2c                       ; ...
    sty data_0b2d                       ; ...
    cpx #&63 ; 'c'                      ; A &64 marker?
    bne code_744c                       ; No
    ldy #&64 ; 'd'                      ; Yes: move it to the back and take the next entry
    bne loop_742b                       ; ...
; &744c referenced 1 time by &7446
.code_744c
    cpx #&ff                            ; Queue empty?
    beq code_7464                       ; Yes: nobody returns
    lda #0                              ; Start hero X returning: out of play...
    sta hero_direction,x                ; ...
    lda #8                              ; ...from the last appearance sprite...
    sta hero_frame,x                    ; ...
    lda #&ff                            ; ...stepping backwards...
    sta hero_offset_x,x                 ; ...
    lda #1                              ; ...every other frame
    sta hero_offset_y,x                 ; ...
; &7464 referenced 1 time by &744e
.code_7464
    pla                                 ; Return
    tax                                 ; ...
    rts                                 ; ...
; &7467 referenced 2 times by &7387, &73c0
.code_7467
    lda #&ff                            ; Remove object Y from the level
    sta object_x,y                      ; ...
    sta object_y,y                      ; ...
    rts                                 ; Return
; &7470 referenced 3 times by &733f, &734a, &747d
.code_7470
    dey                                 ; Next object
    beq return_10                       ; ...
    jmp code_7337                       ; ...
; &7476 referenced 1 time by &7471
.return_10
    rts                                 ; Return
; &7477 referenced 1 time by &740f
.code_7477
    cmp #&5f ; '_'                      ; One of the magic items (&5F and up)?
    bcs code_74b6                       ; Yes
    cmp #&51 ; 'Q'                      ; The exit? Nothing to do here
    beq code_7470                       ; ...
    lda #&32 ; '2'                      ; An energy drainer: play the hit sound louder...
    sta data_0cf4                       ; ...
    txa                                 ; ...
    pha                                 ; ...
    ldx #<(hit_sound)                   ; ...
    ldy #>(hit_sound)                   ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; ...  SOUND command
    lda #6                              ; ...then put the volume back
    sta data_0cf4                       ; ...
    pla                                 ; ...
    tax                                 ; ...
    ldy #&0a                            ; ...and take 10 health
; &7498 referenced 1 time by &74a0
.loop_7498
    tya                                 ; ...
    pha                                 ; ...
    jsr lose_health_point               ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    bne loop_7498                       ; ...
    rts                                 ; Return
; ***************************************************************************************
; Play the pickup sound
;
; Define the pickup envelope and play the pickup sound, from the OSWORD parameter blocks
; at &192C and &193A.
; &74a3 referenced 2 times by &741e, &74ca
.play_pickup_sound
    ldx #<(pickup_envelope)             ; Define the envelope...
    ldy #>(pickup_envelope)             ; ...
    lda #osword_envelope                ; ...
    jsr osword                          ; ...  ENVELOPE command
    ldx #<(pickup_sound)                ; ...and play the sound
    ldy #>(pickup_sound)                ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; ...  SOUND command
    rts                                 ; Return
; &74b6 referenced 1 time by &7479
.code_74b6
    sta scratch                         ; A magic item: keep its type
    lda #&ff                            ; Remove it from the level
    sta object_x,y                      ; ...
    sta object_y,y                      ; ...
    txa                                 ; Play the pickup sound
    pha
    lda scratch
    and #7
    asl a
    asl a
    jsr play_pickup_sound
    pla
    tax
    lda hero_score_units,x              ; Keep the score's units digit, for a potion
    sta scratch2                        ; ...
    jsr add_ten_points                  ; 10 points
    lda scratch                         ; Boots of Speed?
    cmp #&5f ; '_'                      ; ...
    bne code_74eb                       ; No
    jsr point_at_boots_icon             ; Yes: show the bolt in the panel...
    jsr plot_boots_icon                 ; ...
    lda #1                              ; ...and wear them
    sta hero_has_boots,x                ; ...
    rts                                 ; Return
; &74eb referenced 1 time by &74dd
.code_74eb
    cmp #&60 ; '`'                      ; Magic helmet?
    bne code_74ff                       ; No
    dec hero_damage_taken,x             ; Yes: lose one less health per hit...
    lda hero_damage_taken,x             ; ...
    cmp #3                              ; ...but never fewer than 3
    bcs code_74fc                       ; ...
    inc hero_damage_taken,x             ; ...
; &74fc referenced 1 time by &74f7
.code_74fc
    jmp code_75ae                       ; Redraw the armour rating
; &74ff referenced 1 time by &74ed
.code_74ff
    cmp #&61 ; 'a'                      ; Potion of healing?
    bne code_7516                       ; No
    lda scratch2                        ; Yes: health tens = the score's units digit...
    sta hero_health_tens,x              ; ...
    inc scratch2                        ; ...units one more, then take a point to draw it
    lda scratch2                        ; ...
    sta hero_health_units,x             ; ...
    jsr lose_health_point               ; ...
    rts                                 ; Return
; &7516 referenced 1 time by &7501
.code_7516
    cmp #&62 ; 'b'                      ; Pile of weapons?
    bne code_756b                       ; No: a magic sword
    inc hero_max_missiles,x             ; Yes: one more missile in flight...
    lda hero_max_missiles,x             ; ...
    cmp #4                              ; ...to at most 3
    bne code_7529                       ; ...
    lda #3                              ; ...
    sta hero_max_missiles,x             ; ...
; &7529 referenced 1 time by &7522
.code_7529
    jmp code_75c5                       ; Draw the new missile icon
; ***************************************************************************************
; Show the room a hero has moved into
;
; Set hero X's view to the room containing their cell and redraw that view.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &752c referenced 2 times by &704d, &740a
.show_hero_room
    lda hero_x,x                        ; Find the room of the hero's cell (test_wall leaves it in &7B)
    sta cell_x
    lda hero_y,x
    sta cell_y
    txa
    pha
    jsr test_wall
    pla
    tax
    pha                                 ; Keep X
    asl a                               ; view_room entry for this hero...
    tay                                 ; ...
    lda data_007b                       ; ...
    sta view_room,y                     ; ...now this room
    cpx #0                              ; Redraw this hero's view
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
    inc hero_missile_damage,x           ; A magic sword: more missile damage...
    lda hero_missile_damage,x           ; ...
    cmp #&0a                            ; ...to at most 9
    bne code_75e2                       ; ...
    lda #9                              ; ...
    sta hero_missile_damage,x           ; ...
    bne code_75e2                       ; ...
; &757c referenced 1 time by &714d
.code_757c
    txa                                 ; Play the hit sound
    pha
    tya
    pha
    ldx #<(hit_sound)
    ldy #>(hit_sound)
    lda #osword_sound
    jsr osword                          ; SOUND command
    pla
    tay
    pla
    tax
    lda monster_hit_points,x            ; Take the missile's damage from the monster's hit points
    sec                                 ; ...
    sbc missile_damage,y                ; ...
    bpl code_75a6                       ; Still alive?
    lda #&15                            ; No: start it dying...
    sta monster_sprite,x                ; ...
    lda monster_start_hit_points        ; ...and give the slot fresh hit points for its next appearance
    sta monster_hit_points,x            ; ...
    tya                                 ; Missile slot back in X...
    tax                                 ; ...
    jmp code_7150                       ; ...a point to its hero, and the missile is spent
; &75a6 referenced 1 time by &7594
.code_75a6
    sta monster_hit_points,x            ; Alive: store the hit points left
    tya                                 ; ...
    pha                                 ; ...
    jmp missile_spent_pop               ; The missile is spent
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
.check_magic
    dec hero_magic_delay,x              ; Count down the magic key delay
    beq code_761f                       ; ...
    rts                                 ; Not yet: return, which leaves move_heroes for this frame
; &761f referenced 1 time by &761c
.code_761f
    lda #1                              ; Check the key every frame from now on
    sta hero_magic_delay,x              ; ...
    lda hero_magic_key,x                ; Magic key pressed?
    jsr test_key                        ; ...
    bne code_76ab                       ; No: carry on reading the keys
    txa                                 ; Yes: play the magic sound
    pha
    ldx #<(magic_envelope)
    ldy #>(magic_envelope)
    lda #osword_envelope
    jsr osword                          ; ENVELOPE command
    ldx #<(magic_sound)
    ldy #>(magic_sound)
    lda #osword_sound
    jsr osword                          ; SOUND command
    pla
    tax
    lda #4                              ; Ignore the key for the next three frames
    sta hero_magic_delay,x              ; ...
    cpx #1                              ; Health cost: 3 for the Magic-User...
    beq code_7650                       ; ...
    ldy #6                              ; ...6 for the Ranger
    jmp code_7652
; &7650 referenced 1 time by &7649
.code_7650
    ldy #3                              ; ...
; &7652 referenced 2 times by &764d, &765a
.code_7652
    tya                                 ; Take the cost
    pha                                 ; ...
    jsr lose_health_point               ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    bne code_7652                       ; ...
    lda #0                              ; No monsters killed yet
    sta magic_kill_count                ; ...
    txa                                 ; sprite_number = 2 x hero, an index into view_room
    asl a                               ; ...
    sta sprite_number                   ; ...
    ldx #&1e                            ; For each monster...
; &7667 referenced 1 time by &7693
.loop_7667
    lda monster_x,x                     ; ...find its room
    sta cell_x                          ; ...
    lda monster_y,x                     ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr test_wall                       ; ...
    pla                                 ; ...
    tax                                 ; ...
    ldy sprite_number                   ; In the room this hero's view shows?
    lda view_room,y                     ; ...
    cmp data_007b                       ; ...
    bne code_7692                       ; No
    lda monster_sprite,x                ; Alive?
    cmp #&15                            ; ...
    bcs code_7692                       ; No
    lda #&15                            ; Yes: start it dying...
    sta monster_sprite,x                ; ...
    inc magic_kill_count                ; ...and count it
; &7692 referenced 2 times by &7681, &7688
.code_7692
    dex                                 ; Next monster
    bne loop_7667                       ; ...
    lda sprite_number                   ; One point for each monster killed
    lsr a                               ; ...
    tax                                 ; ...
    ldy magic_kill_count                ; ...
; &769c referenced 1 time by &76a8
.code_769c
    cpy #0                              ; ...
    beq code_76ae                       ; ...
    tya                                 ; ...
    pha                                 ; ...
    jsr add_point                       ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    jmp code_769c                       ; ...
; &76ab referenced 1 time by &762a
.code_76ab
    jmp read_hero_keys                  ; No magic: carry on with the keys
; &76ae referenced 1 time by &769e
.code_76ae
    jmp draw_moved_hero                 ; Magic cast: redraw the hero
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
    ldy missile_sprite_base,x           ; Which hero fired it? Its sprite base says
    txa                                 ; ...
    pha                                 ; ...
    tya                                 ; ...
    cmp #&10                            ; Arrows: the Ranger
    bne code_76c0                       ; ...
    ldx #0                              ; ...
    jmp code_76d4                       ; ...
; &76c0 referenced 1 time by &76b9
.code_76c0
    cmp #&44 ; 'D'                      ; Fireballs: the Magic-User
    bne code_76c9                       ; ...
    ldx #1                              ; ...
    jmp code_76d4                       ; ...
; &76c9 referenced 1 time by &76c2
.code_76c9
    cmp #&4c ; 'L'                      ; Axes: the Barbarian
    bne code_76d2                       ; ...
    ldx #2                              ; ...
    jmp code_76d4                       ; ...
; &76d2 referenced 1 time by &76cb
.code_76d2
    ldx #3                              ; Otherwise swords: the Fighter
; &76d4 referenced 3 times by &76bd, &76c6, &76cf
.code_76d4
    jsr add_point                       ; One point to that hero
    pla                                 ; ...
    tax                                 ; ...
    rts                                 ; Return
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
    dec hero_offset_y,x                 ; Every other frame...
    beq code_76e0                       ; ...
    rts                                 ; ...
; &76e0 referenced 1 time by &76dd
.code_76e0
    lda #2                              ; ...
    sta hero_offset_y,x                 ; ...
    jsr get_hero_cell                   ; Plot the current appearance sprite at the hero's cell
    lda #0                              ; ...
    sta data_007d                       ; ...
    sta data_007e                       ; ...
    lda hero_frame,x                    ; ...
    tay                                 ; ...
    lda hero_appearance_sprites,y       ; ...
    sta sprite_number                   ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_at_cell                    ; ...
    pla                                 ; ...
    tax                                 ; ...
    clc                                 ; Step to the next (+1 dying, -1 returning), stopping at 8
    lda hero_frame,x                    ; ...
    adc hero_offset_x,x                 ; ...
    cmp #9                              ; ...
    bcc code_770b                       ; ...
    lda #8                              ; ...
; &770b referenced 1 time by &7707
.code_770b
    cmp #0                              ; Reached the first sprite (returning)?
    bne code_772e                       ; No
    lda #5                              ; Yes: in play, facing down...
    sta hero_direction,x                ; ...
    lda #0                              ; ...with no step or offsets...
    sta hero_step,x                     ; ...
    sta hero_offset_x,x                 ; ...
    sta hero_offset_y,x                 ; ...
    sta hero_frame,x                    ; ...
    lda #&21 ; '!'                      ; ...and health 33, drawn by taking a point
    sta hero_health_tens,x              ; ...
    sta hero_health_units,x             ; ...
    jsr lose_health_point               ; ...
    rts                                 ; Return
; &772e referenced 1 time by &770d
.code_772e
    sta hero_frame,x                    ; Store the frame
    rts                                 ; Return
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
    lda missile_sprite_base,x           ; Which hero fired it? Arrows: toggle the Ranger's frame
    cmp #&10                            ; ...
    bne code_7757                       ; ...
    lda hero_frame                      ; ...
    eor #1                              ; ...
    sta hero_frame                      ; ...
    rts                                 ; Return
; &7757 referenced 1 time by &774c
.code_7757
    cmp #&44 ; 'D'                      ; Fireballs: the Magic-User's
    bne code_7764                       ; ...
    lda data_0d21                       ; ...
    eor #1                              ; ...
    sta data_0d21                       ; ...
    rts                                 ; Return
; &7764 referenced 1 time by &7759
.code_7764
    cmp #&4c ; 'L'                      ; Axes: the Barbarian's
    bne code_7771                       ; ...
    lda data_0d22                       ; ...
    eor #1                              ; ...
    sta data_0d22                       ; ...
    rts                                 ; Return
; &7771 referenced 1 time by &7766
.code_7771
    lda data_0d23                       ; Otherwise swords: the Fighter's
    eor #1                              ; ...
    sta data_0d23                       ; ...
    rts                                 ; Return
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
; &7788 referenced 1 time by &3c42
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
; &7852 referenced 19 times by &38e8, &3940, &4476, &451c, &45a1, &46ad, &46f7, &472c, &7091, &70f9, &7213, &7320, &76f9, &7741, &7817, &79db, &7a07, &7b25, &7b5c
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
    bne return_11                       ; No
    clc                                 ; Yes: plot at column &23, row &67
    lda #&23 ; '#'
    adc cell_x
    sta plot_x
    lda #&67 ; 'g'
    adc cell_y
    sta plot_y
    jsr plot_sprite
; &78fb referenced 1 time by &78e7
.return_11
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
; &78fc referenced 5 times by &6fb2, &712b, &753a, &7675, &7a51
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
; &79c1 referenced 1 time by &4614
.update_monsters
    ldx #8                              ; Draw the eight trapdoors (sprite &2C)...
    lda #0                              ; ...
    sta data_007d                       ; ...
    sta data_007e                       ; ...
    lda #&2c ; ','                      ; ...
    sta sprite_number                   ; ...
; &79cd referenced 1 time by &79e1
.loop_79cd
    lda data_0b8f,x                     ; ...
    sta cell_x                          ; ...
    lda data_0b97,x                     ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_at_cell                    ; ...
    pla                                 ; ...
    tax                                 ; ...
    dex                                 ; ...
    bne loop_79cd                       ; ...
    ldx #&1e                            ; For each monster, 30 to 1...
; &79e5 referenced 1 time by &7b2d
.next_monster_update
    txa                                 ; ...
    pha                                 ; ...
    lda monster_x,x                     ; Erase it at its cell and offsets, remembering the cell
    sta cell_x                          ; ...
    sta previous_x                      ; ...
    lda monster_y,x                     ; ...
    sta cell_y                          ; ...
    sta previous_y                      ; ...
    lda #&15                            ; ...
    sta sprite_number                   ; ...
    lda monster_offset_x,x              ; ...
    sta data_007d                       ; ...
    lda monster_offset_y,x              ; ...
    sta data_007e                       ; ...
    jsr plot_at_cell                    ; ...
    pla                                 ; ...
    pha                                 ; ...
    tax                                 ; ...
    lda monster_sprite,x                ; Dying?
    cmp #&15                            ; ...
    bcc code_7a17                       ; No
    jmp advance_dying_monster           ; Yes: advance the death animation
; &7a17 referenced 1 time by &7a12
.code_7a17
    lda monster_step,x                  ; Part way through a step?
    beq code_7a23                       ; No
    jsr continue_monster_step           ; Yes: continue it and draw
    pla                                 ; ...
    jmp draw_monster                    ; ...
; &7a23 referenced 1 time by &7a1a
.code_7a23
    lda monster_sprite,x                ; Start a step: move the cell in the direction it faces, up...
    cmp #9                              ; ...
    bne code_7a2d                       ; ...
    dec monster_y,x                     ; ...
; &7a2d referenced 1 time by &7a28
.code_7a2d
    cmp #&0b                            ; ...right...
    bne code_7a34                       ; ...
    inc monster_x,x                     ; ...
; &7a34 referenced 1 time by &7a2f
.code_7a34
    cmp #&0d                            ; ...down...
    bne code_7a3b                       ; ...
    inc monster_y,x                     ; ...
; &7a3b referenced 1 time by &7a36
.code_7a3b
    cmp #&0f                            ; ...left
    bne code_7a42                       ; ...
    dec monster_x,x                     ; ...
; &7a42 referenced 1 time by &7a3d
.code_7a42
    jsr start_monster_step              ; Set the step's offsets
    lda monster_x,x                     ; Wall in the new cell?
    sta cell_x                          ; ...
    lda monster_y,x                     ; ...
    sta cell_y                          ; ...
    jsr test_wall                       ; ...
    beq code_7a87                       ; No
    pla                                 ; Yes: stay put, with no step...
    tax                                 ; ...
    lda previous_x                      ; ...
    sta monster_x,x                     ; ...
    lda previous_y                      ; ...
    sta monster_y,x                     ; ...
    lda #0                              ; ...
    sta monster_step,x                  ; ...
    sta monster_offset_x,x              ; ...
    sta monster_offset_y,x              ; ...
    lda system_via_t1c_l                ; ...and turn a random way: sprite 8 + (timer AND 7)...
    and #7                              ; ...
    clc                                 ; ...
    adc #8                              ; ...
    sta monster_sprite,x                ; ...
    and #1                              ; ...made odd (9, &0B, &0D or &0F)
    beq code_7a81                       ; ...
    jmp draw_monster                    ; ...
; &7a81 referenced 1 time by &7a7c
.code_7a81
    inc monster_sprite,x                ; ...
    jmp draw_monster                    ; ...
; &7a87 referenced 1 time by &7a54
.code_7a87
    pla                                 ; Is another monster, or a hero, in the new cell? (A hero there is hurt)
    pha                                 ; ...
    sta scratch                         ; ...
    jsr find_creature                   ; ...
    cmp #0                              ; ...
    beq code_7ac1                       ; No
    pla                                 ; Yes: stay put, with no step, and turn a random way
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
    bne draw_monster
    inc monster_sprite,x
    jmp draw_monster
; &7ac1 referenced 1 time by &7a91
.code_7ac1
    pla                                 ; Moving vertically...
    tax                                 ; ...
    lda monster_sprite,x                ; ...
    cmp #9                              ; ...
    beq code_7adc                       ; ...
    cmp #&0d                            ; ...
    beq code_7adc                       ; ...
    lda monster_x,x                     ; No: at the left or right edge of a room?
    and #7                              ; ...
    beq code_7aea                       ; ...
    cmp #7                              ; ...
    beq code_7aea                       ; ...
    jmp code_7af8                       ; No: move on
; &7adc referenced 2 times by &7ac8, &7acc
.code_7adc
    lda monster_y,x                     ; Yes: at the top or bottom edge of a room?
    and #7                              ; ...
    beq code_7aea                       ; ...
    cmp #7                              ; ...
    beq code_7aea                       ; ...
    jmp code_7af8                       ; No: move on
; &7aea referenced 4 times by &7ad3, &7ad7, &7ae1, &7ae5
.code_7aea
    lda #0                              ; At a room edge: cancel the step, so it arrives at once
    sta monster_step,x                  ; ...
    sta monster_offset_x,x              ; ...
    sta monster_offset_y,x              ; ...
    jmp draw_monster                    ; ...
; &7af8 referenced 2 times by &7ad9, &7ae7
.code_7af8
    lda previous_x                      ; Move on: stay in the old cell until the step ends
    sta monster_x,x                     ; ...
    lda previous_y                      ; ...
    sta monster_y,x                     ; ...
; &7b04 referenced 6 times by &7a20, &7a7e, &7a84, &7ab9, &7abe, &7af5
.draw_monster
    lda monster_x,x                     ; Draw it: sprite = direction + frame, at its cell and offsets
    sta cell_x                          ; ...
    lda monster_y,x                     ; ...
    sta cell_y                          ; ...
    clc                                 ; ...
    lda monster_sprite,x                ; ...
    adc monster_frame,x                 ; ...
    sta sprite_number                   ; ...
    lda monster_offset_x,x              ; ...
    sta data_007d                       ; ...
    lda monster_offset_y,x              ; ...
    sta data_007e                       ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_at_cell                    ; ...
; &7b28 referenced 3 times by &7b5f, &7cf8, &7cfb
.monster_done
    pla                                 ; ...
    tax                                 ; ...
    dex                                 ; Next monster
    beq return_12                       ; ...
    jmp next_monster_update             ; ...
; &7b30 referenced 1 time by &7b2b
.return_12
    rts                                 ; Return
; &7b31 referenced 1 time by &7a14
.advance_dying_monster
    pla                                 ; ...
    inc monster_sprite,x                ; Next death frame
    lda monster_sprite,x                ; ...
    cmp #&1a                            ; Animation over?
    bne code_7b3f                       ; No
    jmp monster_reappears               ; Yes: bring it back at a trapdoor
; &7b3f referenced 1 time by &7b3a
.code_7b3f
    txa                                 ; Draw the death frame
    pha                                 ; ...
    lda monster_x,x                     ; ...
    sta cell_x                          ; ...
    lda monster_y,x                     ; ...
    sta cell_y                          ; ...
    lda monster_sprite,x                ; ...
    sta sprite_number                   ; ...
    lda monster_offset_x,x              ; ...
    sta data_007d                       ; ...
    lda monster_offset_y,x              ; ...
    sta data_007e                       ; ...
    jsr plot_at_cell                    ; ...
    jmp monster_done                    ; ...
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
    lda #1                              ; Step in progress
    sta hero_step,x                     ; ...
    lda hero_direction,x                ; Facing up: drawn 6 rows up
    cmp #1                              ; ...
    bne code_7b79                       ; ...
    lda #0                              ; ...
    sta hero_offset_x,x                 ; ...
    lda #&fa                            ; ...
    sta hero_offset_y,x                 ; ...
    rts                                 ; Return
; &7b79 referenced 1 time by &7b6c
.code_7b79
    cmp #3                              ; Facing right: 2 columns right
    bne code_7b88                       ; ...
    lda #0                              ; ...
    sta hero_offset_y,x                 ; ...
    lda #2                              ; ...
    sta hero_offset_x,x                 ; ...
    rts                                 ; Return
; &7b88 referenced 1 time by &7b7b
.code_7b88
    cmp #5                              ; Facing down: 6 rows down
    bne code_7b97                       ; ...
    lda #0                              ; ...
    sta hero_offset_x,x                 ; ...
    lda #6                              ; ...
    sta hero_offset_y,x                 ; ...
    rts                                 ; Return
; &7b97 referenced 1 time by &7b8a
.code_7b97
    lda #0                              ; Facing left: 2 columns left
    sta hero_offset_y,x                 ; ...
    lda #&fe                            ; ...
    sta hero_offset_x,x                 ; ...
    rts                                 ; Return
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
    lda hero_frame,x                    ; Toggle the hero's frame
    eor #1                              ; ...
    sta hero_frame,x                    ; ...
    dec hero_step,x                     ; Count down the step
    bne code_7bd6                       ; Not over
    lda hero_direction,x                ; Over: move the cell on in the direction faced, up...
    cmp #1                              ; ...
    bne code_7bb9                       ; ...
    dec hero_y,x                        ; ...
; &7bb9 referenced 1 time by &7bb4
.code_7bb9
    cmp #3                              ; ...right...
    bne code_7bc0                       ; ...
    inc hero_x,x                        ; ...
; &7bc0 referenced 1 time by &7bbb
.code_7bc0
    cmp #5                              ; ...down...
    bne code_7bc7                       ; ...
    inc hero_y,x                        ; ...
; &7bc7 referenced 1 time by &7bc2
.code_7bc7
    cmp #7                              ; ...left
    bne code_7bce                       ; ...
    dec hero_x,x                        ; ...
; &7bce referenced 1 time by &7bc9
.code_7bce
    lda #0                              ; ...with no offsets
    sta hero_offset_x,x                 ; ...
    sta hero_offset_y,x                 ; ...
; &7bd6 referenced 1 time by &7bad
.code_7bd6
    clc                                 ; Double the offsets
    lda hero_offset_x,x                 ; ...
    adc hero_offset_x,x                 ; ...
    sta hero_offset_x,x                 ; ...
    clc                                 ; ...
    lda hero_offset_y,x                 ; ...
    adc hero_offset_y,x                 ; ...
    sta hero_offset_y,x                 ; ...
    rts                                 ; Return
; ***************************************************************************************
; Start a monster's step between cells
;
; Set monster X's step counter to 3 and its pixel offsets to one step in its direction of
; travel: 3 rows up or down, or one byte column left or right.
;
; On Entry:
;     X: monster number
; &7beb referenced 1 time by &7a42
.start_monster_step
    lda #3                              ; Three frames per step
    sta monster_step,x                  ; ...
    lda monster_sprite,x                ; First frame's offsets, in the direction of travel: up...
    cmp #9                              ; ...
    bne code_7c02                       ; ...
    lda #0                              ; ...
    sta monster_offset_x,x              ; ...
    lda #&fd                            ; ...3 rows up
    sta monster_offset_y,x              ; ...
    rts                                 ; Return
; &7c02 referenced 1 time by &7bf5
.code_7c02
    cmp #&0b                            ; Moving right...
    bne code_7c11                       ; ...
    lda #0                              ; ...
    sta monster_offset_y,x              ; ...
    lda #1                              ; ...1 column right
    sta monster_offset_x,x              ; ...
    rts                                 ; Return
; &7c11 referenced 1 time by &7c04
.code_7c11
    cmp #&0d                            ; Moving down...
    bne code_7c20                       ; ...
    lda #0                              ; ...
    sta monster_offset_x,x              ; ...
    lda #3                              ; ...3 rows down
    sta monster_offset_y,x              ; ...
    rts                                 ; Return
; &7c20 referenced 1 time by &7c13
.code_7c20
    lda #0                              ; Left: 1 column left
    sta monster_offset_y,x              ; ...
    lda #&ff                            ; ...
    sta monster_offset_x,x              ; ...
    rts                                 ; Return
; ***************************************************************************************
; Continue a monster's step between cells
;
; Toggle monster X's frame and count down its step. When it ends, move the monster one
; cell on and clear its offsets; otherwise grow the offsets by another column or three
; rows.
;
; On Entry:
;     X: monster number
; &7c2b referenced 1 time by &7a1c
.continue_monster_step
    lda monster_frame,x                 ; Toggle the monster's frame
    eor #1                              ; ...
    sta monster_frame,x                 ; ...
    dec monster_step,x                  ; Count down the step
    bne code_7c5f                       ; Not over: grow the offsets
    lda monster_sprite,x                ; Over: move the cell on in its direction, up...
    cmp #9                              ; ...
    bne code_7c42                       ; ...
    dec monster_y,x                     ; ...
; &7c42 referenced 1 time by &7c3d
.code_7c42
    cmp #&0b                            ; ...right...
    bne code_7c49                       ; ...
    inc monster_x,x                     ; ...
; &7c49 referenced 1 time by &7c44
.code_7c49
    cmp #&0d                            ; ...down...
    bne code_7c50                       ; ...
    inc monster_y,x                     ; ...
; &7c50 referenced 1 time by &7c4b
.code_7c50
    cmp #&0f                            ; ...left
    bne code_7c57                       ; ...
    dec monster_x,x                     ; ...
; &7c57 referenced 1 time by &7c52
.code_7c57
    lda #0                              ; ...with no offsets
    sta monster_offset_x,x              ; ...
    sta monster_offset_y,x              ; ...
; &7c5f referenced 1 time by &7c36
.code_7c5f
    lda monster_offset_x,x              ; Grow the horizontal offset by a column, away from zero
    beq code_7c6f                       ; ...
    bpl code_7c6c                       ; ...
    dec monster_offset_x,x              ; ...
    jmp code_7c6f                       ; ...
; &7c6c referenced 1 time by &7c64
.code_7c6c
    inc monster_offset_x,x              ; ...
; &7c6f referenced 2 times by &7c62, &7c69
.code_7c6f
    lda monster_offset_y,x              ; Grow the vertical offset by three rows, away from zero
    beq return_13                       ; ...
    bpl code_7c82                       ; ...
    sec                                 ; ...
    lda monster_offset_y,x              ; ...
    sbc #3                              ; ...
    sta monster_offset_y,x              ; ...
    jmp return_13                       ; ...
; &7c82 referenced 1 time by &7c74
.code_7c82
    clc                                 ; ...
    lda monster_offset_y,x              ; ...
    adc #3                              ; ...
    sta monster_offset_y,x              ; ...
; &7c8b referenced 2 times by &7c72, &7c7f
.return_13
    rts                                 ; Return
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
.monster_reappears
    inc next_trapdoor                   ; Next trapdoor, 0-7 in turn
    lda next_trapdoor                   ; ...
    cmp #8                              ; ...
    bne code_7cc2                       ; ...
    lda #0                              ; ...
    sta next_trapdoor                   ; ...
; &7cc2 referenced 1 time by &7cbb
.code_7cc2
    ldy next_trapdoor                   ; ...
    lda trapdoor_x,y                    ; Put the monster on it, facing up, with no step
    sta monster_x,x                     ; ...
    lda trapdoor_y,y                    ; ...
    sta monster_y,x                     ; ...
    lda #9                              ; ...
    sta monster_sprite,x                ; ...
    lda #0                              ; ...
    sta monster_step,x                  ; ...
    sta monster_offset_x,x              ; ...
    sta monster_offset_y,x              ; ...
    txa                                 ; Is anything else on the trapdoor? (A hero there is hurt)
    pha                                 ; ...
    stx scratch                         ; ...
    jsr find_creature                   ; ...
    cmp #0                              ; ...
    beq code_7cfb                       ; No: done
    pla                                 ; Yes: wait off the map, to try again next frame
    pha                                 ; ...
    tax                                 ; ...
    lda #&ff                            ; ...
    sta monster_x,x                     ; ...
    sta monster_y,x                     ; ...
    jmp monster_done                    ; ...
; &7cfb referenced 1 time by &7ceb
.code_7cfb
    jmp monster_done                    ; Done
    equb &00
; &7cff referenced 3 times by &355b, &3ccf, &759b
.monster_start_hit_points
    equb &08
; ***************************************************************************************
; Workspace template
;
; The starting contents of page &0D for each level, copied there by reset_workspace: the
; heroes' starting positions, directions, keys (hero_key_up etc. at +&70), health of 99 +
; 1 (at +&90, +&95), the views' rooms (+&A0), sprite bases (+&B0, +&B5), bit masks (+&C0)
; and panel rows (+&D0).
; &7d00 used as index base 1 time by &3be2
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
; &7dd0 used as index base 3 times by &36b1, &51d4, &55d4
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
; &7e00 used as index base 17 times by &3ccc, &7667, &797e, &79e7, &7a31, &7a3f, &7a45, &7a5b, &7a98, &7ace, &7afb, &7b04, &7b41, &7c46, &7c54, &7cc8, &7cf2
.monster_x
; &7e23 referenced 2 times by &4469, &4479
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
; &7e4c referenced 2 times by &4463, &447f
data_7e4c = sub_7e30+28
    equb &14, &27, &0d, &20, &01, &26, &0a, &01
    equb &12, &05, &20, &29, &0d, &26, &27, &08
    equb &06, &1a, &14, &03, &1d, &07, &0d, &17
    equb &00, &00, &00, &00, &1b, &00, &00, &00
    equb &00, &00
; &7e52 used as index base 19 times by &3cc7, &7144, &7598, &7683, &768c, &7a0d, &7a23, &7a77, &7a81, &7ab4, &7abb, &7ac3, &7b11, &7b32, &7b35, &7b4d, &7bf0, &7c38, &7cd3
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
; &7f20 used as index base 9 times by &3c55, &7173, &719a, &730d, &7337, &73ea, &7413, &7469, &74bb
.object_x
    equb &00, &ff, &ff, &ff, &ff, &ff, &18, &04
    equb &04, &05, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &01, &07, &04
    equb &04, &ff, &ff, &ff, &ff, &ff
; &7f3e referenced 3 times by &467b, &46b7, &46c5
.exit_x
    equb &04
; &7f3f used as index base 9 times by &3c5b, &717b, &719d, &7313, &7342, &73f3, &7416, &746c, &74be
.object_y
    equb &00, &ff, &ff, &ff, &ff, &ff, &15, &18
    equb &19, &19, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff
    equs "**+."
    equb &ff, &ff, &ff, &ff, &ff
; &7f5d referenced 3 times by &4683, &46bd, &46c8
.exit_y
    equb &2c
; &7f5e used as index base 7 times by &3c61, &7183, &718e, &7191, &7319, &735c, &73c8
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

save "Dun1", &2000, &8000, &2000, &2000
save "Coder", &5000, &59b0, &5000, &5000

; Label references by decreasing frequency:
;     oswrch:                     63
;     plot_x:                     63
;     cell_x:                     54
;     cell_y:                     49
;     sprite_number:              45
;     scratch:                    44
;     plot_y:                     37
;     hero_x:                     29
;     osbyte:                     27
;     hero_y:                     26
;     data_007b:                  21
;     plot_sprite:                21
;     hero_offset_y:              20
;     hero_direction:             19
;     hero_offset_x:              19
;     monster_sprite:             19
;     plot_at_cell:               19
;     data_007d:                  18
;     data_007e:                  18
;     monster_offset_y:           17
;     monster_x:                  17
;     monster_y:                  16
;     sprite_width:               16
;     hero_frame:                 15
;     monster_offset_x:           15
;     osword:                     15
;     menu_text:                  14
;     menu_text_joy:              14
;     hero_step:                  13
;     screen_ptr:                 13
;     data_0080:                  12
;     data_0581:                  12
;     missile_direction:          12
;     plot_victory_sprite:        12
;     data_0081:                  11
;     hero_health_tens:           11
;     previous_x:                 11
;     previous_y:                 11
;     returning_hero_queue:       10
;     hero_max_missiles:           9
;     hero_panel_y:                9
;     object_x:                    9
;     object_y:                    9
;     screen_ptr_hi:               9
;     data_0601:                   8
;     hero_absent:                 8
;     hero_key:                    8
;     hero_score_thousands:        8
;     hero_score_units:            8
;     lose_health_point:           8
;     panel_hero:                  8
;     cell_room:                   7
;     data_008f:                   7
;     hero_damage_taken:           7
;     hero_health_units:           7
;     hero_missile_damage:         7
;     monster_step:                7
;     object_type:                 7
;     os_vsync_counter:            7
;     oscli:                       7
;     sprite_height:               7
;     data_0082:                   6
;     data_06f8:                   6
;     draw_monster:                6
;     key_x:                       6
;     key_y:                       6
;     levels_started:              6
;     missile_x:                   6
;     missile_y:                   6
;     print_menu:                  6
;     print_menu_joy:              6
;     scratch2:                    6
;     test_key:                    6
;     add_point:                   5
;     code_71d9:                   5
;     count:                       5
;     data_0084:                   5
;     data_07e6:                   5
;     data_08be:                   5
;     erase_hero:                  5
;     hero_score_hundreds:         5
;     hero_score_ten_thousands:    5
;     hero_score_tens:             5
;     level_digits:                5
;     level_number:                5
;     next_trapdoor:               5
;     plot_panel_sprite:           5
;     test_wall:                   5
;     view_room:                   5
;     add_ten_points:              4
;     code_1ec6:                   4
;     code_703b:                   4
;     code_7611:                   4
;     code_7aea:                   4
;     code_7ff6:                   4
;     data_007c:                   4
;     data_041e:                   4
;     data_045a:                   4
;     data_0602:                   4
;     door_x:                      4
;     door_y:                      4
;     draw_moved_hero:             4
;     draw_room:                   4
;     exit_spin:                   4
;     find_creature:               4
;     hero_door_x:                 4
;     hero_door_y:                 4
;     hero_key_dropped:            4
;     level_count_copy:            4
;     missile_sprite_base:         4
;     monster_hit_points:          4
;     next_hero:                   4
;     play_level:                  4
;     start_hero_step:             4
;     step_hero:                   4
;     wrchv:                       4
;     wrchv + 1:                   4
;     bit_masks:                   3
;     code_1db2:                   3
;     code_1f36:                   3
;     code_504a:                   3
;     code_7266:                   3
;     code_72bc:                   3
;     code_7470:                   3
;     code_76d4:                   3
;     code_798d:                   3
;     data_008d:                   3
;     data_7dd0:                   3
;     exit_busy:                   3
;     exit_saved_x:                3
;     exit_saved_y:                3
;     exit_x:                      3
;     exit_y:                      3
;     hero_has_boots:              3
;     hero_magic_delay:            3
;     hero_sprites:                3
;     magic_kill_count:            3
;     missile_damage:              3
;     monster_done:                3
;     monster_frame:               3
;     monster_start_hit_points:    3
;     mos_reset_entry:             3
;     next_victory_sprite:         3
;     os_break_intercept:          3
;     osasci:                      3
;     osrdch:                      3
;     room_walls:                  3
;     sprite_data_ptr:             3
;     system_via_t1c_l:            3
;     clear_text_area:             2
;     code_108a:                   2
;     code_1097:                   2
;     code_111c:                   2
;     code_11bb:                   2
;     code_1e28:                   2
;     code_1ebe:                   2
;     code_1f91:                   2
;     code_512d:                   2
;     code_7156:                   2
;     code_71d4:                   2
;     code_71d7:                   2
;     code_7201:                   2
;     code_73c7:                   2
;     code_7467:                   2
;     code_75e2:                   2
;     code_7652:                   2
;     code_7692:                   2
;     code_79b7:                   2
;     code_7adc:                   2
;     code_7af8:                   2
;     code_7c6f:                   2
;     code_7cae:                   2
;     credit_missile_owner:        2
;     data_0288:                   2
;     data_0289:                   2
;     data_0437:                   2
;     data_0447:                   2
;     data_046b:                   2
;     data_0484:                   2
;     data_0528:                   2
;     data_0540:                   2
;     data_05c0:                   2
;     data_05c3:                   2
;     data_05c9:                   2
;     data_05cb:                   2
;     data_05d6:                   2
;     data_05d7:                   2
;     data_05e4:                   2
;     data_05e9:                   2
;     data_06b4:                   2
;     data_06c9:                   2
;     data_06f0:                   2
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
;     data_7e23:                   2
;     data_7e4c:                   2
;     data_e772:                   2
;     door_sprite:                 2
;     draw_hero:                   2
;     draw_victory_ring:           2
;     draw_view_0:                 2
;     draw_view_1:                 2
;     draw_view_2:                 2
;     draw_view_3:                 2
;     exit_offsets_y:              2
;     exit_shrinks_left:           2
;     exiting_hero:                2
;     get_hero_cell:               2
;     level_checksums:             2
;     missile_spent_pop:           2
;     mos_oswrch_default:          2
;     next_missile:                2
;     play_pickup_sound:           2
;     plot_chalice:                2
;     point_at_boots_icon:         2
;     previous_offset_x:           2
;     previous_offset_y:           2
;     print_menu_string:           2
;     print_menu_string_joy:       2
;     read_hero_keys:              2
;     reset_hero:                  2
;     return_13:                   2
;     row_start_ptr:               2
;     row_start_ptr_hi:            2
;     saved_wrchv:                 2
;     set_menu_no:                 2
;     set_menu_no_joy:             2
;     set_menu_off:                2
;     set_menu_off_joy:            2
;     set_menu_on:                 2
;     set_menu_on_joy:             2
;     set_menu_yes:                2
;     set_menu_yes_joy:            2
;     show_hero_room:              2
;     shrunk_hero:                 2
;     sprite_data_ptr_hi:          2
;     test_object_free:            2
;     trapdoor_x:                  2
;     trapdoor_y:                  2
;     add_thousand_points:         1
;     add_thousand_points_joy:     1
;     advance_dying_monster:       1
;     animate_absent_hero:         1
;     bytev:                       1
;     bytev + 1:                   1
;     check_for_victory:           1
;     check_hero_keys:             1
;     check_level:                 1
;     check_magic:                 1
;     code_091d:                   1
;     code_0929:                   1
;     code_0938:                   1
;     code_093e:                   1
;     code_0961:                   1
;     code_0d7f:                   1
;     code_0e08:                   1
;     code_0e09:                   1
;     code_0e45:                   1
;     code_0e57:                   1
;     code_0e6d:                   1
;     code_0e7a:                   1
;     code_0ea8:                   1
;     code_0eae:                   1
;     code_0eb9:                   1
;     code_0efc:                   1
;     code_0f3a:                   1
;     code_1079:                   1
;     code_1084:                   1
;     code_10ba:                   1
;     code_10c7:                   1
;     code_110a:                   1
;     code_1124:                   1
;     code_113c:                   1
;     code_113e:                   1
;     code_1140:                   1
;     code_11d3:                   1
;     code_11de:                   1
;     code_11ec:                   1
;     code_146f:                   1
;     code_14a2:                   1
;     code_14e5:                   1
;     code_14ec:                   1
;     code_1512:                   1
;     code_1529:                   1
;     code_1540:                   1
;     code_1551:                   1
;     code_1564:                   1
;     code_1577:                   1
;     code_1585:                   1
;     code_159c:                   1
;     code_16b4:                   1
;     code_16bf:                   1
;     code_1cc5:                   1
;     code_1cd8:                   1
;     code_1ce3:                   1
;     code_1cee:                   1
;     code_1cfa:                   1
;     code_1d03:                   1
;     code_1db8:                   1
;     code_1dba:                   1
;     code_1dce:                   1
;     code_1df3:                   1
;     code_1e35:                   1
;     code_1e45:                   1
;     code_1ec4:                   1
;     code_1ee0:                   1
;     code_1ee7:                   1
;     code_1f17:                   1
;     code_1f2a:                   1
;     code_1f38:                   1
;     code_1f96:                   1
;     code_1f9e:                   1
;     code_1ff2:                   1
;     code_2026:                   1
;     code_5036:                   1
;     code_508b:                   1
;     code_5092:                   1
;     code_50b4:                   1
;     code_50b8:                   1
;     code_50c4:                   1
;     code_50ca:                   1
;     code_50e5:                   1
;     code_510b:                   1
;     code_5113:                   1
;     code_5137:                   1
;     code_513d:                   1
;     code_6e82:                   1
;     code_6e91:                   1
;     code_6e97:                   1
;     code_6eba:                   1
;     code_6ed4:                   1
;     code_6ee7:                   1
;     code_6efa:                   1
;     code_6f0d:                   1
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
;     code_7a17:                   1
;     code_7a23:                   1
;     code_7a2d:                   1
;     code_7a34:                   1
;     code_7a3b:                   1
;     code_7a42:                   1
;     code_7a81:                   1
;     code_7a87:                   1
;     code_7ac1:                   1
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
;     code_7cc2:                   1
;     code_7cfb:                   1
;     code_7fb5:                   1
;     code_7fb8:                   1
;     code_7fbd:                   1
;     code_7fda:                   1
;     collect_objects:             1
;     continue_hero_step:          1
;     continue_monster_step:       1
;     data_0000:                   1
;     data_00fa:                   1
;     data_00fc:                   1
;     data_079b:                   1
;     data_07a9:                   1
;     data_07b8:                   1
;     data_07c6:                   1
;     data_07d5:                   1
;     data_07e9:                   1
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
;     data_1625:                   1
;     data_213a:                   1
;     data_5172:                   1
;     data_5179:                   1
;     data_518e:                   1
;     data_fffc:                   1
;     data_fffd:                   1
;     decrypt_level:               1
;     decrypt_level_joy:           1
;     dissolve_chalice:            1
;     draw_all_views:              1
;     draw_keys:                   1
;     draw_room_row:               1
;     draw_status_panel:           1
;     draw_view_frames:            1
;     drop_key:                    1
;     erase_boots_icon:            1
;     exit_offsets_x:              1
;     fire_missile:                1
;     flip_firer_frame:            1
;     font_digits:                 1
;     font_letters:                1
;     game_entry:                  1
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
;     hero_menu_joy:               1
;     hero_missile_sprites:        1
;     hero_start_damage_taken:     1
;     hero_start_max_missiles:     1
;     hero_start_missile_damage:   1
;     level_bcd:                   1
;     level_command_digits:        1
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
;     level_trapdoor_x:            1
;     level_trapdoor_y:            1
;     level_wall_sprite:           1
;     level_walls:                 1
;     loop_504c:                   1
;     loop_50ba:                   1
;     loop_50f1:                   1
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
;     missile_spent:               1
;     monster_reappears:           1
;     mos_row_offsets:             1
;     mos_row_offsets_lo:          1
;     move_heroes:                 1
;     move_missiles:               1
;     next_level_by_reset:         1
;     next_monster_update:         1
;     object_free_map:             1
;     plot_boots_icon:             1
;     remove_absent_heroes:        1
;     remove_absent_heroes_joy:    1
;     reset_monsters:              1
;     reset_workspace:             1
;     restart_by_reset:            1
;     restore_hero_sprites:        1
;     return_1:                    1
;     return_10:                   1
;     return_11:                   1
;     return_12:                   1
;     return_2:                    1
;     return_3:                    1
;     return_4:                    1
;     return_5:                    1
;     return_6:                    1
;     return_7:                    1
;     return_8:                    1
;     return_9:                    1
;     screen_address:              1
;     sprite_addr_hi:              1
;     sprite_addr_lo:              1
;     sprite_chalice:              1
;     sprite_heights:              1
;     sprite_widths:               1
;     start_level:                 1
;     start_monster_step:          1
;     sub_15b1:                    1
;     sub_7305:                    1
;     unpack_level:                1
;     update_game:                 1
;     update_monsters:             1
;     update_rest:                 1
;     victory_sequence:            1
;     wall_sprite:                 1
;     workspace_template:          1

; Automatically generated labels:
;     code_091d
;     code_0929
;     code_0938
;     code_093e
;     code_0961
;     code_0d7f
;     code_0e08
;     code_0e09
;     code_0e45
;     code_0e57
;     code_0e6d
;     code_0e7a
;     code_0ea8
;     code_0eae
;     code_0eb9
;     code_0efc
;     code_0f3a
;     code_1079
;     code_1084
;     code_108a
;     code_1097
;     code_10ba
;     code_10c7
;     code_110a
;     code_111c
;     code_1124
;     code_113c
;     code_113e
;     code_1140
;     code_11bb
;     code_11d3
;     code_11de
;     code_11ec
;     code_146f
;     code_14a2
;     code_14e5
;     code_14ec
;     code_1512
;     code_1529
;     code_1540
;     code_1551
;     code_1564
;     code_1577
;     code_1585
;     code_159c
;     code_16b4
;     code_16bf
;     code_1cc5
;     code_1cd8
;     code_1ce3
;     code_1cee
;     code_1cfa
;     code_1d03
;     code_1db2
;     code_1db8
;     code_1dba
;     code_1dce
;     code_1df3
;     code_1e28
;     code_1e35
;     code_1e45
;     code_1ebe
;     code_1ec4
;     code_1ec6
;     code_1ee0
;     code_1ee7
;     code_1f17
;     code_1f2a
;     code_1f36
;     code_1f38
;     code_1f91
;     code_1f96
;     code_1f9e
;     code_1ff2
;     code_2026
;     code_5036
;     code_504a
;     code_508b
;     code_5092
;     code_50b4
;     code_50b8
;     code_50c4
;     code_50ca
;     code_50e5
;     code_510b
;     code_5113
;     code_512d
;     code_5137
;     code_513d
;     code_6e82
;     code_6e91
;     code_6e97
;     code_6eba
;     code_6ed4
;     code_6ee7
;     code_6efa
;     code_6f0d
;     code_6f70
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
;     code_70d2
;     code_70da
;     code_70e7
;     code_70fe
;     code_7108
;     code_710f
;     code_7116
;     code_711d
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
;     data_008f
;     data_00fa
;     data_00fc
;     data_0288
;     data_0289
;     data_041e
;     data_0437
;     data_0447
;     data_045a
;     data_046b
;     data_0484
;     data_0528
;     data_0540
;     data_0581
;     data_05c0
;     data_05c3
;     data_05c9
;     data_05cb
;     data_05d6
;     data_05d7
;     data_05e4
;     data_05e9
;     data_0601
;     data_0602
;     data_06b4
;     data_06c9
;     data_06f0
;     data_06f8
;     data_079b
;     data_07a9
;     data_07b8
;     data_07c6
;     data_07d5
;     data_07e6
;     data_07e9
;     data_08be
;     data_09f7
;     data_09f8
;     data_09f9
;     data_09fb
;     data_09fc
;     data_09fd
;     data_09fe
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
;     data_12d4
;     data_1625
;     data_213a
;     data_5172
;     data_5179
;     data_518e
;     data_7dd0
;     data_7e23
;     data_7e4c
;     data_e772
;     data_fffc
;     data_fffd
;     loop_504c
;     loop_50ba
;     loop_50f1
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
;     return_2
;     return_3
;     return_4
;     return_5
;     return_6
;     return_7
;     return_8
;     return_9
;     sub_0d63
;     sub_0d72
;     sub_0d88
;     sub_0ded
;     sub_0fea
;     sub_10e6
;     sub_1204
;     sub_15b1
;     sub_1624
;     sub_5178
;     sub_7305
;     sub_7db9
;     sub_7e30

; Stats:
;     Total size (Code + Data) = 24576 bytes
;     Code                     = 7430 bytes (30%)
;     Data                     = 17146 bytes (70%)
;
;     Number of instructions   = 3424
;     Number of data bytes     = 16111 bytes
;     Number of data words     = 0 bytes
;     Number of string bytes   = 1035 bytes
;     Number of strings        = 132
