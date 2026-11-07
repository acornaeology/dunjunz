; Constants
osbyte_flush_buffer_class            = &0f
osbyte_kbd_status                    = &ca
osbyte_sound_suppression             = &d2
osbyte_bell_channel                  = &d3
osbyte_bell_envelope                 = &d4
osbyte_bell_frequency                = &d5
osbyte_bell_duration                 = &d6
osbyte_inkey                         = &81
osword_envelope                      = &08
osword_sound                         = &07
osbyte_read_adc_or_get_buffer_status = &80
osbyte_scan_keyboard_from_16         = &7a
osbyte_enable_event                  = &0e
event_interval_timer_crossing_zero   = &05
osbyte_disable_event                 = &0d
osword_write_interval_timer          = &04
inkey_key_ctrl                       = &fe
inkey_key_keypad_enter               = &c3
inkey_key_caps_lock                  = &bf
inkey_key_keypad_hash                = &a5
inkey_key_g                          = &ac
inkey_key_underscore                 = &d7
inkey_key_shift_lock                 = &af
inkey_key_keypad_del                 = &b4
inkey_key_b                          = &9b
inkey_key_return                     = &b6
inkey_key_z                          = &9e
inkey_key_keypad_comma               = &a3
inkey_key_m                          = &9a
inkey_key_copy                       = &96
inkey_key_shift                      = &ff
inkey_key_keypad_3                   = &93
inkey_key_n                          = &aa
inkey_key_delete                     = &a6
inkey_key_tab                        = &9f
inkey_key_keypad_asterisk            = &a4
inkey_key_space                      = &9d
inkey_key_left_square_bracket        = &c7

; Memory locations
tune_ptr                        = &00  ; The music's place in the tune: the current three-byte step.
; &00 referenced 11 times by &1413, &146f, &c735, &c774, &c783, &c795, &c7a5, &c7aa, &c7f2, &c80f, &c818
plot_x                          = &70  ; Sprite position: screen byte column, 0-79 (two MODE 2 pixels per byte). Also used as a scratch byte and pointer low byte by other routines.
; &70 referenced 41 times by &0422, &0439, &043b, &0452, &045a, &045c, &045e, &0465, &046b, &05a7, &05ab, &0984, &0991, &0f68, &1458, &154d, &1558, &155c, &1da6, &1e1c, &1e77, &20c6, &726d, &7282, &72c6, &72db, &72eb, &72fb, &75b8, &75d9, &75e4, &75fb, &7823, &7846, &784a, &78a1, &78bb, &78d5, &78ef, &d884, &d891
plot_y                          = &71  ; Sprite position: pixel row from the top of the screen. Also used as a pointer high byte by other routines.
; &71 referenced 30 times by &042a, &0458, &0469, &0471, &0967, &097b, &0f77, &145c, &1da2, &1e18, &1e73, &20c2, &7269, &72c2, &75b4, &75d5, &75ec, &7603, &7797, &77a9, &77bb, &77cd, &77ef, &77f3, &78a8, &78c2, &78dc, &78f6, &d867, &d87b
sprite_width                    = &72  ; Width of the sprite being plotted, in screen bytes.
; &72 referenced 8 times by &0454, &0461, &0463, &047a, &090f, &0927, &d80f, &d827
sprite_height                   = &73  ; Height of the sprite being plotted, in pixel rows.
; &73 referenced 4 times by &0914, &091b, &d814, &d81b
screen_ptr                      = &74  ; Screen address being written, low byte.
; &74 referenced 26 times by &091d, &092b, &092e, &0932, &0946, &094e, &0955, &0959, &0979, &097f, &0981, &0997, &0999, &d81d, &d82b, &d82e, &d832, &d846, &d84e, &d855, &d859, &d879, &d87f, &d881, &d897, &d899
screen_ptr_hi                   = &75  ; Screen address being written, high byte.
; &75 referenced 18 times by &0921, &0936, &094c, &095b, &095f, &0974, &098d, &098f, &099d, &d821, &d836, &d84c, &d85b, &d85f, &d874, &d88d, &d88f, &d89d
row_start_ptr                   = &76  ; Screen address of the first byte of the sprite row being plotted, low byte.
; &76 referenced 4 times by &091f, &0942, &d81f, &d842
row_start_ptr_hi                = &77  ; Screen address of the first byte of the sprite row being plotted, high byte.
; &77 referenced 4 times by &0923, &0948, &d823, &d848
sprite_data_ptr                 = &78  ; Address of the next sprite data byte to plot, low byte.
; &78 referenced 6 times by &0905, &0929, &0938, &d805, &d829, &d838
sprite_data_ptr_hi              = &79  ; Address of the next sprite data byte to plot, high byte.
; &79 referenced 4 times by &090a, &093c, &d80a, &d83c
sprite_number                   = &7a  ; Sprite to plot: an index into the sprite tables at sprite_addr_lo, sprite_addr_hi, sprite_widths and sprite_heights.
; &7a referenced 45 times by &041e, &0433, &0900, &0f6a, &11a6, &11fe, &1d2e, &1d9a, &1dca, &1e10, &1e57, &1e6b, &1f69, &1fb5, &1fd1, &20ba, &7077, &70a2, &70e9, &720f, &7242, &7272, &727e, &72cb, &72d7, &72e7, &72f7, &731c, &75c0, &75dd, &75f4, &7608, &760f, &7663, &767a, &7695, &76f5, &7813, &7836, &7840, &79cb, &79fb, &7b17, &7b50, &d800
map_ptr                         = &7b  ; Pointer into room_walls or object_free_map at a cell's room, low byte; set by test_wall and test_object_free.
; &7b referenced 21 times by &1d5b, &1d62, &1d64, &1d80, &1d85, &7046, &7542, &767f, &77a1, &77b3, &77c5, &77d7, &77e4, &790e, &7915, &7917, &792f, &794a, &7951, &7953, &796b
map_ptr_hi                      = &7c  ; Pointer into a map, high byte.
; &7c referenced 4 times by &1d68, &77e0, &791b, &7957
plot_offset_x                   = &7d  ; Horizontal pixel offset added by plot_at_cell (in byte columns).
; &7d referenced 18 times by &10f2, &1d32, &1dc4, &1e5b, &1f63, &1fa3, &1fe5, &7088, &70cc, &7307, &76ea, &7738, &780c, &787a, &79c5, &7a00, &7b1c, &7b55
plot_offset_y                   = &7e  ; Vertical pixel offset added by plot_at_cell (in pixel rows).
; &7e referenced 18 times by &10f4, &1d34, &1dc6, &1e5d, &1f65, &1fa5, &1fea, &708d, &70ce, &7309, &76ec, &773d, &780e, &788e, &79c7, &7a05, &7b21, &7b5a
ring_x                          = &80  ; Map x of the cell being drawn in the victory ring.
; &80 referenced 8 times by &114b, &1154, &1159, &1166, &117d, &1182, &118a, &119a
ring_y                          = &81  ; Map y of the cell being drawn in the victory ring.
; &81 referenced 7 times by &114f, &116b, &1170, &1178, &118f, &1194, &119f
victory_sprite                  = &82  ; Sprite drawn in the victory ring.
; &82 referenced 6 times by &10f8, &115e, &11a4, &11ac, &11bb, &11d5
victory_delay                   = &84  ; Delay between frames of the victory sequence.
; &84 referenced 5 times by &1100, &111c, &1122, &1133, &113c
victory_pitch_step              = &8d  ; Amount the victory tone rises each frame.
; &8d referenced 3 times by &1108, &110d, &1113
victory_steps_left              = &8e  ; Rises left in the victory tone.
; &8e referenced 2 times by &1104, &1115
victory_pitch                   = &8f  ; Pitch of the victory tone.
; &8f referenced 6 times by &10fc, &110b, &110f, &1124, &7934, &7970
os_zp_fa                        = &fa  ; MOS zero-page workspace, read by dissolve_chalice to vary its random choice.
; &fa referenced 1 time by &11c3
os_irq_a                        = &fc  ; MOS 1.20: A at the last interrupt, read by dissolve_chalice to vary its random choice.
; &fc referenced 1 time by &11c1
wrchv                           = &020e
; &020e referenced 1 time by &1568
evntv                           = &0220
; &0220 referenced 1 time by &c74c
os_vsync_counter                = &0240  ; MOS 1.20 counter decremented on every vertical sync interrupt. The game sets it and waits for it to run out to pace itself.
; &0240 referenced 7 times by &0e62, &0eb9, &11e9, &11ec, &1f00, &1f07, &c6ea
os_break_intercept              = &0287  ; MOS BREAK intercept: a JMP here is called during a reset. *DUNJUNZ sets its address but leaves it disabled.
modelb_hero_score_ten_thousands = &08b0  ; Where *DUNJUNZ sets up the Model B side's per-hero ten-thousands digits, as the Model B loader does; this side's game does not read it.
modelb_hero_absent              = &08b4  ; Where *DUNJUNZ sets up the Model B side's per-hero absent flags, as the Model B loader does; this side's game does not read it.
modelb_levels_started           = &08bc  ; Where *DUNJUNZ sets up the Model B side's count of levels started, as the Model B loader does; this side's game does not read it.
modelb_level_digits             = &08bd  ; Where *DUNJUNZ sets up the Model B side's ASCII level digits, as the Model B loader does; this side's game does not read it.
scratch                         = &0d00  ; General-purpose scratch byte.
; &0d00 referenced 49 times by &1cc5, &1d00, &1d4e, &1d52, &1d55, &1d58, &1d77, &1d82, &2006, &200d, &201e, &205a, &2063, &2070, &6f19, &6f1e, &6f25, &6f71, &6fd7, &7002, &7007, &713c, &74b6, &74c3, &74d8, &77e6, &782c, &7857, &785b, &785e, &7861, &7886, &788b, &7901, &7905, &7908, &790b, &7926, &7931, &793d, &7941, &7944, &7947, &7962, &796d, &7976, &7990, &7a89, &7ce3; also used as index base 3 times by &0745, &1488, &1512
scratch2                        = &0d01  ; Second scratch byte.
; &0d01 referenced 8 times by &203a, &207b, &74d2, &7503, &7509, &750c, &7829, &782f
cell_x                          = &0d02  ; Map x of the cell being drawn, tested or moved to. plot_at_cell replaces it with the pixel offset within the room.
; &0d02 referenced 59 times by &119c, &11f4, &1ccb, &1cdb, &1d26, &1d3c, &1d5d, &1d6c, &1dd1, &1e38, &1e48, &1f58, &1faa, &1fd6, &2094, &20a7, &20de, &20e9, &20fa, &6fa7, &700f, &707c, &70aa, &70ee, &7120, &715b, &7176, &71e3, &7310, &732c, &733a, &73f0, &752f, &766a, &777d, &779b, &77ad, &77bf, &77d1, &7801, &7820, &7867, &7872, &787c, &789e, &78b8, &78d2, &78ec, &7910, &791d, &794c, &7959, &797b, &7997, &79d0, &79ea, &7a48, &7b07, &7b44
cell_y                          = &0d03  ; Map y of the cell being drawn, tested or moved to. plot_at_cell replaces it with the pixel offset within the room.
; &0d03 referenced 55 times by &11a1, &11f9, &1cd1, &1ce6, &1d20, &1d42, &1d49, &1d7a, &1dd7, &1e3e, &1e50, &1f5e, &1fb0, &1fdc, &209a, &20ad, &20d0, &20db, &20ec, &20f7, &6fad, &7017, &7082, &70b0, &70f4, &7126, &7161, &717e, &71eb, &7316, &7332, &7345, &73fc, &7535, &7670, &7783, &7807, &7852, &787f, &7890, &78a5, &78bf, &78d9, &78f3, &78fc, &7929, &7938, &7965, &7983, &799f, &79d6, &79f3, &7a4e, &7b0d, &7b4a
cell_room                       = &0d04  ; Room of the cell being drawn, as an offset into room_walls.
; &0d04 referenced 7 times by &7864, &786c, &786f, &7896, &78b0, &78ca, &78e4
previous_x                      = &0d06  ; Map x of the creature being moved, before the move.
; &0d06 referenced 11 times by &6e9a, &6f56, &6fbb, &6fe5, &7021, &7069, &7079, &79ed, &7a58, &7a95, &7af8
previous_y                      = &0d07  ; Map y of the creature being moved, before the move.
; &0d07 referenced 11 times by &6ea0, &6f5c, &6fc1, &6feb, &7027, &706f, &707f, &79f6, &7a5e, &7a9b, &7afe
previous_offset_x               = &0d08  ; Pixel offset of the hero being moved, before the move.
; &0d08 referenced 2 times by &6ea6, &7085
previous_offset_y               = &0d09  ; Pixel offset of the hero being moved, before the move.
; &0d09 referenced 2 times by &6eac, &708a
hero_x                          = &0d10  ; Map x of each hero.
; &0d10 used as index base 29 times by &06e7, &1dfd, &1e35, &1e89, &1f38, &1f55, &1f74, &2091, &6e97, &6f39, &6f59, &6f87, &6f95, &6f98, &6fa4, &6fbe, &6fe8, &700c, &7024, &706c, &70a7, &71e0, &7329, &73ed, &752c, &777a, &799a, &7bbd, &7bcb
hero_y                          = &0d15  ; Map y of each hero.
; &0d15 used as index base 27 times by &1e03, &1e3b, &1e8f, &1f40, &1f5b, &2097, &6e9d, &6f3f, &6f5f, &6f80, &6f8e, &6f9e, &6faa, &6fc4, &6fee, &7014, &702a, &7072, &70ad, &71e8, &732f, &73f9, &7532, &7780, &79a2, &7bb6, &7bc4
hero_direction                  = &0d1a  ; Direction each hero faces: 1 up, 3 right, 5 down, 7 left; 0 when the hero is not in play.
; &0d1a used as index base 18 times by &06d0, &1de6, &1f52, &6e82, &6ecb, &6ede, &6ef1, &6f04, &6f2d, &6f79, &701c, &7097, &7221, &7249, &7452, &7711, &7b67, &7baf
hero_frame                      = &0d20  ; Animation frame of each hero (0 or 1), added to its sprite.
; &0d20 referenced 2 times by &774e, &7753; also used as index base 12 times by &06da, &1df3, &6f62, &6f67, &709c, &7457, &76ee, &76ff, &771f, &772e, &7ba2, &7ba7
hero_step                       = &0d25  ; Frames left in each hero's step between cells.
; &0d25 used as index base 12 times by &06d5, &1f4d, &6e87, &6eaf, &6fc9, &6ff3, &702f, &7063, &7401, &7716, &7b64, &7baa
hero_offset_x                   = &0d2a  ; Each hero's horizontal pixel offset while between cells.
; &0d2a used as index base 19 times by &6ea3, &6fcc, &6ff6, &7032, &705d, &724e, &7404, &745c, &7702, &7719, &7735, &7b70, &7b84, &7b8e, &7b9e, &7bd0, &7bd7, &7bda, &7bdd
hero_offset_y                   = &0d30  ; Each hero's vertical pixel offset while between cells.
; &0d30 used as index base 20 times by &6ea9, &6fcf, &6ff9, &7035, &7060, &7251, &7407, &7461, &76da, &76e2, &771c, &773a, &7b75, &7b7f, &7b93, &7b99, &7bd3, &7be1, &7be4, &7be7
missile_x                       = &0d40  ; Map x of each missile (12 slots, three per hero).
; &0d40 used as index base 6 times by &6f3c, &70eb, &710c, &711a, &711d, &7158
missile_y                       = &0d4c  ; Map y of each missile.
; &0d4c used as index base 6 times by &6f42, &70f1, &7105, &7113, &7123, &715e
missile_direction               = &0d58  ; Direction of each missile: 1 up, 2 right, 3 down, 4 left; bit 7 set for a missile just fired; 0 for an empty slot.
; &0d58 used as index base 12 times by &6f28, &6f36, &70d2, &70de, &70fe, &7134, &71a5, &71ae, &71ba, &71c6, &71ce, &720c
set_wrchv_low                   = &0d63
missile_sprite_base             = &0d64  ; Sprite base of each missile, to which its direction is added; also identifies the hero who fired it.
; &0d64 used as index base 4 times by &6f53, &7209, &76b1, &7747
hero_key_up                     = &0d70  ; INKEY key number of each hero's up key.
; &0d70 used as index base 1 time by &6ec1
hero_key_down                   = &0d74  ; INKEY key number of each hero's down key.
; &0d74 used as index base 1 time by &6ed4
hero_key_right                  = &0d78  ; INKEY key number of each hero's right key.
; &0d78 used as index base 1 time by &6ee7
hero_key_left                   = &0d7c  ; INKEY key number of each hero's left key.
; &0d7c used as index base 1 time by &6efa
hero_key_fire                   = &0d80  ; INKEY key number of each hero's fire key.
; &0d80 used as index base 1 time by &6f0d
hero_health_tens                = &0d90  ; Health tens digit, as a digit sprite (&1E-&27); &1D when the hero is dead.
; &0d90 used as index base 10 times by &06df, &0e6d, &7236, &7239, &726f, &738e, &7391, &739a, &7506, &7724
hero_health_units               = &0d95  ; Health units digit, as a digit sprite.
; &0d95 used as index base 7 times by &7227, &722a, &7233, &727b, &739d, &750f, &7727
view_room                       = &0da0  ; The room each hero's view shows: a pointer into room_walls, low byte then high byte, for each hero in turn (hero x at view_room + 2x).
; &0da0 referenced 2 times by &779e, &7893; also used as index base 3 times by &7043, &7544, &767c
hero_missile_sprites            = &0db0  ; Sprite base of each hero's missiles: arrows, fireballs, axes, swords.
; &0db0 used as index base 1 time by &6f50
hero_sprites                    = &0db5  ; Sprite base of each hero, to which direction and frame are added.
; &0db5 used as index base 4 times by &1fcb, &1ffd, &2051, &709f
hero_has_boots                  = &0dbc  ; Non-zero while the hero wears Boots of Speed.
; &0dbc used as index base 3 times by &7056, &7351, &74e7
bit_masks                       = &0dc0  ; Bit masks for the cells of a room row, left to right: &80, &40 ... &01.
; &0dc0 used as index base 3 times by &1d72, &7923, &795f
hero_panel_y                    = &0dd0  ; Pixel row of each hero's section of the status panel.
; &0dd0 used as index base 10 times by &1d9c, &1e12, &1e6d, &20bc, &7266, &72bd, &75af, &75cf, &75e7, &75fe
teleport_last                   = &0dfd  ; Index of the last object to search when looking backwards for a teleporter (&1E, from workspace_template).
; &0dfd referenced 1 time by &73d3
victory_sprite_copy             = &0dff  ; Written by draw_victory_ring; not read.
; &0dff referenced 1 time by &1160
level_object_x                  = &6b00  ; Level file: Objects' map x (entries 1-30, entry 30 the exit).
; &6b00 used as index base 1 time by &1573
level_object_y                  = &6b20  ; Level file: Objects' map y.
; &6b20 used as index base 1 time by &1579
level_object_type               = &6b40  ; Level file: Objects' types.
; &6b40 used as index base 1 time by &157f
level_door_x                    = &6b60  ; Level file: Doors' map x (entries 1-20).
; &6b60 used as index base 1 time by &158a
level_door_y                    = &6b75  ; Level file: Doors' map y.
; &6b75 used as index base 1 time by &1590
level_door_sprite               = &6b8a  ; Level file: Doors' sprites.
; &6b8a used as index base 1 time by &1596
level_key_x                     = &6ba0  ; Level file: Keys' map x (entries 1-20).
; &6ba0 used as index base 1 time by &15a1
level_key_y                     = &6bb5  ; Level file: Keys' map y.
; &6bb5 used as index base 1 time by &15a7
level_trapdoor_x                = &6bd0  ; Level file: Trapdoors' map x (entries 0-7).
; &6bd0 used as index base 1 time by &15b2
level_trapdoor_y                = &6bd8  ; Level file: Trapdoors' map y.
; &6bd8 used as index base 1 time by &15b8
level_walls                     = &6be0  ; Level file: Wall map (&C9 bytes used).
; &6be0 used as index base 1 time by &15c5
level_object_free_map           = &6cb0  ; Level file: Map of cells without objects (&C9 bytes used).
; &6cb0 used as index base 1 time by &15cb
level_wall_sprite               = &6d80  ; Level file: The level's wall block, copied to wall_sprite.
; &6d80 used as index base 1 time by &15d8
saved_page_0d                   = &c400  ; The MOS's page &0D (the filing system's NMI code and workspace), saved here by Coder and copied back by load_level before each level is loaded.
; &c400 used as index base 2 times by &0748, &1485
mos120_reset_entry              = &d9cd  ; The MOS 1.20 reset entry, which decrypt_level calls on a failed checksum. On a Master, with private RAM paged in, it is HAZEL.
; &d9cd referenced 1 time by &0481
mos320_oswrch_default           = &e822  ; MOS 3.20's default OSWRCH routine, WRCHV's initial value.
mos320_osbyte_default           = &eeb1  ; MOS 3.20's default OSBYTE routine, BYTEV's initial value.
; &eeb1 referenced 2 times by &c518, &c569
system_via_t1c_l                = &fe44
; &fe44 referenced 3 times by &11be, &7a6f, &7aac
osrdch                          = &ffe0
; &ffe0 referenced 2 times by &058f, &10d7
osasci                          = &ffe3
; &ffe3 referenced 3 times by &0eb1, &10bd, &10ca
oswrch                          = &ffee
; &ffee referenced 54 times by &0502, &0507, &050c, &0511, &0516, &051b, &0530, &0536, &053d, &0544, &076f, &07c2, &07c7, &0e8d, &0e92, &0e97, &0e9c, &0ea1, &109c, &10a1, &10a6, &10ab, &10b0, &10b5, &112d, &1430, &1435, &143a, &143f, &1444, &1447, &144a, &144d, &1450, &1453, &14c1, &14c6, &14cb, &14d0, &14d5, &14d8, &14db, &14de, &14e1, &14e4, &1548, &154f, &161b, &1620, &1625, &162a, &162f, &1634, &c605
osword                          = &fff1
; &fff1 referenced 24 times by &16a6, &16af, &1d18, &1ead, &1eb6, &736d, &7376, &73b9, &73e3, &748c, &74a9, &74b2, &7586, &7634, &763d, &c706, &c70f, &c718, &c721, &c790, &c7a2, &c7d4, &c7dd, &c7e6
osbyte                          = &fff4
; &fff4 referenced 23 times by &0583, &058c, &05ed, &07d6, &07df, &07e8, &07f1, &0ec0, &0ec9, &10d4, &10ed, &1128, &7c9e, &c51f, &c52d, &c53c, &c54a, &c559, &c6d2, &c6de, &c6f0, &c75a, &c766
oscli                           = &fff7
; &fff7 referenced 7 times by &0752, &0759, &0760, &0767, &14f5, &c5a4, &c6c4
reset_vector                    = &fffc  ; 6502 RESET vector, in the MOS ROM.
; &fffc referenced 1 time by &10da


    org &0400

.dasmos_coder_start
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
    inc hero_score_thousands,x          ; Add one to the thousands digit
    lda hero_score_thousands,x          ; ...
    cmp #&28 ; '('                      ; Past 9?
    bne add_thousand_points_done        ; No: return
    lda #&1e                            ; Yes: thousands 0...
    sta hero_score_thousands,x          ; ...
    inc hero_score_ten_thousands,x      ; ...and add one to the ten-thousands digit
    lda hero_score_ten_thousands,x      ; ...
    cmp #&73 ; 's'                      ; Past 9?
    bne draw_ten_thousands              ; No
    lda #&72 ; 'r'                      ; Yes: keep it at 9
    sta hero_score_ten_thousands,x      ; ...
; &041e referenced 2 times by &0417, &06c2
.draw_ten_thousands
    sta sprite_number                   ; Plot it below the score...
    lda #&45 ; 'E'                      ; ...
    sta plot_x                          ; ...
    lda workspace_template + 208,x      ; ...
    clc                                 ; ...
    adc #&18                            ; ...
    sta plot_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_sprite                     ; ...
    lda #&71 ; 'q'                      ; ...with four of sprite &71 beside it
    sta sprite_number                   ; ...
    ldy #4                              ; ...
; &0437 referenced 1 time by &0443
.draw_ten_thousands_loop
    tya                                 ; ...
    pha                                 ; ...
    inc plot_x                          ; ...
    inc plot_x                          ; ...
    jsr plot_sprite                     ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    bne draw_ten_thousands_loop         ; ...
    pla                                 ; ...
    tax                                 ; ...
; &0447 referenced 1 time by &0408
.add_thousand_points_done
    rts                                 ; Return
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
; &0450 referenced 2 times by &14f8, &c5a7
.decrypt_level
    ldy #0                              ; Point at &6B00, the start of the level...
    sty plot_x                          ; ...low byte
    sty sprite_width                    ; Start the sum at zero
    lda #&6b ; 'k'                      ; ...
    sta plot_y                          ; ...high byte
; &045a referenced 2 times by &046f, &0475
.decrypt_level_loop
    lda (plot_x),y                      ; Fetch a byte...
    eor plot_x                          ; ...XOR it with the low byte of its address...
    sta (plot_x),y                      ; ...and store it back decrypted
    clc                                 ; Add it to the sum
    adc sprite_width                    ; ...
    sta sprite_width                    ; ...
    inc plot_x                          ; Next byte...
    bne decrypt_level_next              ; ...
    inc plot_y                          ; ...with carry into the high byte
; &046b referenced 1 time by &0467
.decrypt_level_next
    lda plot_x                          ; Stop at &6DB0, the end of the level...
    cmp #&b0                            ; ...
    bne decrypt_level_loop              ; ...
    lda plot_y                          ; ...
    cmp #&6d ; 'm'                      ; ...
    bne decrypt_level_loop              ; ...
    ldx level_number                    ; X = level number
    lda sprite_width                    ; Compare the sum...
    cmp level_checksums,x               ; ...with this level's checksum
    beq decrypt_level_done              ; Match: return
    jsr mos120_reset_entry              ; No match: call &D9CD, the MOS 1.20 reset entry; on a Master it is private RAM that no file of this side fills
; &0484 referenced 1 time by &047f
.decrypt_level_done
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
; &0500 referenced 1 time by &0e11
.hero_menu
    lda #&1c                            ; VDU 28: a text window over the left of the screen...
    jsr oswrch                          ; ...
    lda #0                              ; ...
    jsr oswrch                          ; ...
    lda #&18                            ; ...
    jsr oswrch                          ; ...
    lda #&13                            ; ...
    jsr oswrch                          ; ...
    lda #0                              ; ...
    jsr oswrch                          ; ...
    lda #&0c                            ; ...VDU 12 to clear it
    jsr oswrch                          ; ...
    jsr print_menu                      ; Print the menu
    jmp menu_key_loop                   ; Read the players' choices
; ***************************************************************************************
; Print the menu text
;
; Print the sixteen positioned strings of menu_text.
; &0524 referenced 3 times by &051e, &05c3, &05f0
.print_menu
    ldx #&0f                            ; Fifteen strings, then one more by falling through
    ldy #0                              ; ...
; &0528 referenced 1 time by &052c
.print_menu_loop
    jsr print_menu_string               ; ...
    dex                                 ; ...
    bne print_menu_loop                 ; ...
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
    lda #&1f                            ; VDU 31: move the text cursor...
    jsr oswrch                          ; ...
    lda menu_text,y                     ; ...to the string's column...
    jsr oswrch                          ; ...
    iny                                 ; ...
    lda menu_text,y                     ; ...and row
    jsr oswrch                          ; ...
; &0540 referenced 1 time by &0549
.print_menu_string_loop
    iny                                 ; Print the characters...
    lda menu_text,y                     ; ...
    jsr oswrch                          ; ...
    cmp #&0d                            ; ...up to and including the carriage return
    bne print_menu_string_loop          ; ...
    iny                                 ; Point at the next string
    rts                                 ; Return
; ***************************************************************************************
; Change a menu entry to NO
;
; Write "NO " at menu_text+Y.
;
; On Entry:
;     Y: offset of the entry
; &054d referenced 1 time by &05c0
.set_menu_no
    lda #&4e ; 'N'                      ; "NO "
    sta menu_text,y                     ; ...
    lda #&4f ; 'O'                      ; ...
    sta menu_text + 1,y                 ; ...
    lda #&20 ; ' '                      ; ...
    sta menu_text + 2,y                 ; ...
    rts                                 ; Return
; ***************************************************************************************
; Change a menu entry to YES
;
; Write "YES" at menu_text+Y.
;
; On Entry:
;     Y: offset of the entry
; &055d referenced 1 time by &05ba
.set_menu_yes
    lda #&59 ; 'Y'                      ; "YES"
    sta menu_text,y                     ; ...
    lda #&45 ; 'E'                      ; ...
    sta menu_text + 1,y                 ; ...
    lda #&53 ; 'S'                      ; ...
    sta menu_text + 2,y                 ; ...
    rts                                 ; Return
; ***************************************************************************************
; Change the sound entry to OFF
;
; Write "FF" at menu_text+Y, after its "O".
;
; On Entry:
;     Y: offset of the entry's second character
; &056d referenced 1 time by &05e4
.set_menu_off
    lda #&46 ; 'F'                      ; "FF" after the O
    sta menu_text,y                     ; ...
    sta menu_text + 1,y                 ; ...
    rts                                 ; Return
; ***************************************************************************************
; Change the sound entry to ON
;
; Write "N " at menu_text+Y, after its "O".
;
; On Entry:
;     Y: offset of the entry's second character
; &0576 referenced 1 time by &05dd
.set_menu_on
    lda #&4e ; 'N'                      ; "N " after the O
    sta menu_text,y                     ; ...
    lda #&20 ; ' '                      ; ...
    sta menu_text + 1,y                 ; ...
    rts                                 ; Return
; &0581 referenced 6 times by &0521, &0598, &059c, &05c6, &05d3, &05f3
.menu_key_loop
    lda #osbyte_flush_buffer_class      ; Flush the input buffers
    jsr osbyte                          ; ...  Flush selected class of buffer
    lda #osbyte_kbd_status              ; OSBYTE &CA: keyboard status &20, CAPS LOCK on and SHIFT LOCK off
    ldx #&20 ; ' '                      ; ...
    ldy #0                              ; ...
    jsr osbyte                          ; ...  osbyte: kbd status
    jsr osrdch                          ; Wait for a key
    cmp #&20 ; ' '                      ; SPACE?
    beq menu_space                      ; Yes: start, if anyone is playing
    cmp #&31 ; '1'                      ; Ignore anything but 1-6
    bcc menu_key_loop                   ; ...
    cmp #&37 ; '7'                      ; ...
    bcs menu_key_loop                   ; ...
    sec                                 ; X = 0-5
    sbc #&31 ; '1'                      ; ...
    tax                                 ; ...
    cmp #4                              ; 5 or 6: the sound
    bcs menu_sound_key                  ; ...
    asl a                               ; 1-4: Y = offset of the hero's YES/NO, 6 x X + &51...
    sta plot_x                          ; ...
    asl a                               ; ...
    clc                                 ; ...
    adc plot_x                          ; ...
    adc #&51 ; 'Q'                      ; ...
    tay                                 ; ...
    lda hero_absent,x                   ; Toggle the hero
    eor #1                              ; ...
    sta hero_absent,x                   ; ...
    bne menu_hero_off                   ; Now absent?
    jsr set_menu_yes                    ; No: YES
    jmp menu_reprint                    ; ...
; &05c0 referenced 1 time by &05b8
.menu_hero_off
    jsr set_menu_no                     ; Yes: NO
; &05c3 referenced 1 time by &05bd
.menu_reprint
    jsr print_menu                      ; Reprint the menu
    jmp menu_key_loop                   ; Next key
; &05c9 referenced 1 time by &0594
.menu_space
    ldx #3                              ; SPACE: is any hero playing?
; &05cb referenced 1 time by &05d1
.menu_space_check_hero
    lda hero_absent,x                   ; ...
    beq menu_done                       ; Yes: return and start
    dex                                 ; ...
    bpl menu_space_check_hero           ; ...
    jmp menu_key_loop                   ; No: next key
; &05d6 referenced 1 time by &05ce
.menu_done
    rts                                 ; Return
; &05d7 referenced 1 time by &05a4
.menu_sound_key
    ldy #&99                            ; Sound: Y = offset of the second letter of ON/OFF
    cmp #5                              ; Key 6 (A = key - "1")?
    beq menu_sound_off                  ; Yes
    jsr set_menu_on                     ; Key 5: ON...
    ldx #0                              ; ...with X = 0 to enable the sound
    beq menu_set_sound                  ; ...
; &05e4 referenced 1 time by &05db
.menu_sound_off
    jsr set_menu_off                    ; Key 6: OFF...
    ldx #1                              ; ...with X = 1 to suppress it
; &05e9 referenced 1 time by &05e2
.menu_set_sound
    lda #osbyte_sound_suppression       ; OSBYTE &D2: sound suppression
    ldy #0                              ; ...
    jsr osbyte                          ; ...  osbyte: sound suppression
    jsr print_menu                      ; Reprint the menu
    jmp menu_key_loop                   ; Next key
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &4f
; ***************************************************************************************
; Hero menu text
;
; Sixteen entries of: column, row, text, carriage return; printed by print_menu.
; &0600 used as index base 7 times by &0533, &053a, &0541, &054f, &055f, &056f, &0578
.menu_text
; &0601 used as index base 4 times by &0554, &0564, &0572, &057d
    equb &06, &00
; &0602 used as index base 2 times by &0559, &0569
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
; &06b0 referenced 1 time by &0e5d
.remove_absent_heroes
    ldx #0                              ; For each hero, keeping a count of absent heroes in Y...
    ldy #0                              ; ...
; &06b4 referenced 1 time by &06f3
.remove_absent_heroes_loop
    lda hero_score_ten_thousands,x      ; Score of 10000 or more?
    cmp #&6a ; 'j'                      ; ...
    bcc remove_absent_heroes_check      ; No
    txa                                 ; Yes: draw the ten-thousands digit
    pha                                 ; ...
    tya                                 ; ...
    pha                                 ; ...
    lda hero_score_ten_thousands,x      ; ...
    jsr draw_ten_thousands              ; ...
    pla                                 ; ...
    tay                                 ; ...
    pla                                 ; ...
    tax                                 ; ...
; &06c9 referenced 1 time by &06b9
.remove_absent_heroes_check
    lda hero_absent,x                   ; Switched off on the menu?
    beq remove_absent_heroes_next       ; No
    lda #0                              ; Yes: out of play...
    sta hero_direction,x                ; ...
    lda #&63 ; 'c'                      ; ...never to be animated (step &63)...
    sta hero_step,x                     ; ...
    lda #8                              ; ...frame 8...
    sta hero_frame,x                    ; ...
    lda #&1d                            ; ...dead...
    sta hero_health_tens,x              ; ...
    dec hero_score_units,x              ; ...score units digit back one...
    lda #&1f                            ; ...at x &1F...
    sta hero_x,x                        ; ...
    lda #&64 ; 'd'                      ; ...and a &64 marker in the returning queue
    sta returning_hero_queue,y          ; ...
    iny                                 ; ...
; &06f0 referenced 1 time by &06cc
.remove_absent_heroes_next
    inx                                 ; Next hero
    cpx #4                              ; ...
    bne remove_absent_heroes_loop       ; ...
    rts                                 ; Return
    equb &00, &00
; &06f8 used as index base 6 times by &040f, &0412, &041b, &06b4, &06bf, &0ef3
.hero_score_ten_thousands
    equs "iiii"
; &06fc used as index base 4 times by &05b0, &05b5, &05cb, &06c9
.hero_absent
    equb &00, &00, &00, &00
; ***************************************************************************************
; Leftovers in the line-input buffer
;
; Not used by the game. &0700 is the MOS line-input buffer, and these bytes are what it
; held when Coder was saved: the command *SA. CODER 400+3FF 740, then the ends of shorter
; earlier lines and the fragment of BBC BASIC assembler (label+2:LDA#255:.label JSR&30)
; that the Model B images and the cassette lineage's &0400 images also hold.
.line_buffer_leftovers
    equs "*SA. CODER 400+3FF 740"
    equb &0d
    equs " 740"
    equb &0d, &54, &50, &0d, &0d, &50, &0d
    equs "Alabel+2:LDA#255:.label JSR&30"
; ***************************************************************************************
; Coder: save the MOS's page &0D, load the game and start it
;
; Run with *RUN CODER (or from Coder2). Set the bell sound, copy page &0D, which the MOS
; and the filing system use for their NMI code and workspace, to &C400 in private RAM so
; that start_level can put it back before each level is loaded, *LOAD the four other game
; files, restore the display that *DUNJUNZ blanked, select COLOUR 2 and start a new game
; at &0E00.
.coder_start
    jsr set_bell                        ; Set the bell sound
    ldx #0                              ; Copy page &0D...
; &0745 referenced 1 time by &074c
.loop_0745
    lda scratch,x                       ; ...
    sta saved_page_0d,x                 ; ...to &C400 in private RAM
    dex                                 ; ...
    bne loop_0745                       ; ...
    ldx #&7a ; 'z'                      ; *L. DUNJ2 (&6E80-&7FFF)
    ldy #7                              ; ...
    jsr oscli                           ; ...
    ldx #&83                            ; *L. DUNJ3 (&08C0-&0CFE)
    ldy #7                              ; ...
    jsr oscli                           ; ...
    ldx #&8c                            ; *L. DUNJ4 (&0E00-&1FFF)
    ldy #7                              ; ...
    jsr oscli                           ; ...
    ldx #&95                            ; *L. DUNJ5 (&2000-&2FFF)
    ldy #7                              ; ...
    jsr oscli                           ; ...
    ldx #0                              ; Send the 21 bytes of coder_display_vdu
; &076c referenced 1 time by &0775
.loop_076c
    lda coder_display_vdu,x             ; ...
    jsr oswrch                          ; ...
    inx                                 ; ...
    cpx #&15                            ; ...
    bne loop_076c                       ; ...
    jmp code_07c0                       ; ...
.load_dunj_commands
    equs "L. DUNJ2"
    equb &0d
    equs "L. DUNJ3"
    equb &0d
    equs "L. DUNJ4"
    equb &0d
    equs "L. DUNJ5"
    equb &0d
; &079e used as index base 1 time by &076c
.coder_display_vdu
    equb &06, &17, &00, &06, &19, &00, &00, &00, &00, &00, &00
    equb &17, &00, &01, &50, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
; &07c0 referenced 1 time by &0777
.code_07c0
    lda #&11                            ; COLOUR 2...
    jsr oswrch                          ; ...
    lda #2                              ; ...
    jsr oswrch                          ; ...
    jmp new_game                        ; ...and start a new game
    equb &00, &00, &00
; ***************************************************************************************
; Set the bell sound
;
; OSBYTEs &D3-&D6: the BEL character's sound on channel &13, envelope 0 (fixed
; amplitude), pitch &64, duration 1. The cassette game's start-up sets the same sound on
; channel &11.
; &07d0 referenced 1 time by &0740
.set_bell
    lda #osbyte_bell_channel            ; OSBYTE &D3: bell channel...
    ldx #&13                            ; ...&13
    ldy #0                              ; ...
    jsr osbyte                          ; ...  osbyte: bell channel
    lda #osbyte_bell_envelope           ; OSBYTE &D4: bell envelope...
    ldx #0                              ; ...0, a fixed amplitude
    ldy #0                              ; ...
    jsr osbyte                          ; ...  osbyte: bell envelope
    lda #osbyte_bell_frequency          ; OSBYTE &D5: bell pitch...
    ldx #&64 ; 'd'                      ; ...&64
    ldy #0                              ; ...
    jsr osbyte                          ; ...  osbyte: bell frequency
    lda #osbyte_bell_duration           ; OSBYTE &D6: bell duration...
    ldx #1                              ; ...1
    ldy #0                              ; ...
    jsr osbyte                          ; ...  osbyte: bell duration
    rts                                 ; Return
; ***************************************************************************************
; Leftover filename
;
; The end of "Dunjunz1", the name the cassette lineage's &0400 images hold at &07F0, part
; overwritten by set_bell.
    equs "nz1"
    equb &0d, &00, &00, &00, &00, &00, &00
.dasmos_coder_end

    org &08c0

.dasmos_dunj3_start
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
; On this side start_music overwrites the first three bytes with JMP &D800, so from the first level on every sprite is plotted by the identical copy in Code3, plot_sprite_hazel. The menu, before start_music first runs, uses this one.
; &0900 referenced 21 times by &042e, &043d, &0f79, &1daa, &1e20, &1e7d, &20ca, &7276, &7286, &72cf, &72df, &72ef, &72ff, &7613, &7838, &7842, &78aa, &78c4, &78de, &78f8, &c726
.plot_sprite
; &0901 referenced 1 time by &c72b
    ldx sprite_number                   ; X = sprite number
; &0902 referenced 1 time by &c730
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
.plot_sprite_row
    lda screen_ptr                      ; Remember where this pixel row starts...
    sta row_start_ptr                   ; ...
    lda screen_ptr_hi                   ; ...
    sta row_start_ptr_hi                ; ...in row_start_ptr
    txa                                 ; Save the row count
    pha                                 ; ...
    ldx sprite_width                    ; X counts the bytes across this row
; &0929 referenced 1 time by &093f
.plot_sprite_byte
    lda (sprite_data_ptr),y             ; Copy one sprite byte...
    sta (screen_ptr),y                  ; ...to the screen
    clc                                 ; Step screen_ptr right one byte column: 8 bytes on
    lda screen_ptr                      ; ...
    adc #8                              ; ...
    sta screen_ptr                      ; ...
    bcc plot_sprite_next_data           ; ...
    inc screen_ptr_hi                   ; ...with carry into the high byte
; &0938 referenced 1 time by &0934
.plot_sprite_next_data
    inc sprite_data_ptr                 ; Next sprite data byte
    bne plot_sprite_count_byte          ; ...
    inc sprite_data_ptr_hi              ; ...with carry into the high byte
; &093e referenced 1 time by &093a
.plot_sprite_count_byte
    dex                                 ; Count the bytes across
    bne plot_sprite_byte                ; Loop until the row is done
    clc                                 ; screen_ptr = row start + 1: the next pixel row down
    lda row_start_ptr                   ; ...
    adc #1                              ; ...
    sta screen_ptr                      ; ...
    lda row_start_ptr_hi                ; ...
    adc #0                              ; ...
    sta screen_ptr_hi                   ; ...
    lda screen_ptr                      ; Has it crossed into the next character row?
    and #7                              ; ...(pixel row within the character now 0)
    bne plot_sprite_next_row            ; No: carry on
    clc                                 ; Yes: add 640-8 to reach the top pixel row of the...
    lda screen_ptr                      ; ...character row below
    adc #&78 ; 'x'                      ; ...
    sta screen_ptr                      ; ...
    lda screen_ptr_hi                   ; ...
    adc #2                              ; ...
    sta screen_ptr_hi                   ; ...
; &0961 referenced 1 time by &0952
.plot_sprite_next_row
    pla                                 ; Recover the row count
    tax                                 ; ...
    dex                                 ; Count the pixel rows
    bne plot_sprite_row                 ; Loop until the sprite is done
    rts                                 ; Return
; ***************************************************************************************
; Calculate a screen address
;
; Set screen_ptr to the screen address of byte column plot_x on pixel row plot_y: &3000 +
; 640 x (plot_y DIV 8) + (plot_y MOD 8) + 8 x plot_x. The multiplication by 640 uses
; row_offsets in Table, this side's copy of the MOS 1.20 table, in private RAM.
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
    lda row_offsets,y                   ; High byte of row x 640, from Table's copy of the MOS 1.20 table in private RAM...
    clc                                 ; ...
    adc #&30 ; '0'                      ; ...plus &30: the screen starts at &3000
    sta screen_ptr_hi                   ; ...
    lda row_offsets_lo,y                ; Low byte of row x 640
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
; &099f referenced 1 time by &099b
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
; &09f0 referenced 4 times by &1f7a, &1fa7, &1fd3, &2026
.exit_saved_x
    equb &04
; &09f1 referenced 4 times by &1f80, &1fad, &1fd9, &202c
.exit_saved_y
    equb &2c
; &09f2 referenced 5 times by &151a, &1f10, &1f96, &2034, &2078
.exit_busy
    equb &00
; &09f3 referenced 5 times by &1fbe, &1fc3, &1fce, &1ff4, &2086
.exit_spin
    equb &ff
; &09f4 referenced 3 times by &1fdf, &1ff7, &208b
.exit_shrinks_left
    equb &00
; &09f5 referenced 3 times by &1f9e, &1fba, &207e
.exiting_hero
    equb &03
; &09f6 referenced 1 time by &2042; also used as index base 1 time by &1fe2
.exit_offsets_x
    equb &04
; &09f7 referenced 1 time by &152b
.exit_offset_x_1
    equb &01
; &09f8 referenced 1 time by &152e
.exit_offset_x_2
    equb &01
; &09f9 referenced 1 time by &151d
.exit_offset_x_3
    equb &00
; &09fa referenced 1 time by &1520; also used as index base 1 time by &1fe7
.exit_offsets_y
    equb &00
; &09fb referenced 1 time by &153b
.exit_offset_y_1
    equb &05
; &09fc referenced 1 time by &1540
.exit_offset_y_2
    equb &03
; &09fd referenced 1 time by &1531
.exit_offset_y_3
    equb &01
; &09fe referenced 1 time by &1523
.exit_offset_y_4
    equb &00
; &09ff referenced 4 times by &1536, &1f2d, &2045, &2081
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
; &0b20 used as index base 9 times by &0ed2, &0f2b, &0f30, &6f22, &751a, &751d, &7526, &75c5, &75ca
.hero_max_missiles
    equb &03, &02, &01, &03
; &0b24 used as index base 1 time by &7624
.hero_magic_key
    equb inkey_key_ctrl, inkey_key_keypad_enter
; &0b26 used as index base 3 times by &7619, &7621, &7644
.hero_magic_delay
    equb &01, &01
; &0b28 referenced 3 times by &765e, &768f, &7699
.magic_kill_count
    equb &00, &10
; &0b2a referenced 3 times by &7421, &742b, &7432; also used as index base 6 times by &06ec, &15fd, &16b4, &16bb, &7256, &725f
.returning_hero_queue
; &0b2b referenced 2 times by &742f, &7438
; &0b2c referenced 2 times by &7435, &743e
; &0b2d referenced 2 times by &743b, &7441
    equb &03, &02, &01, &04, &10
; &0b2f referenced 5 times by &1526, &7cb3, &7cb6, &7cbf, &7cc2
.next_trapdoor
    equb &04
; &0b30 used as index base 1 time by &76f2
.hero_appearance_sprites
    equb &16, &17, &18, &19
    equs "defgh"
    equb &10, &10, &10, &10, &10, &10, &10
; &0b40 used as index base 4 times by &15f3, &758d, &759e, &75a6
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
    equb &02, &02, &02, &03, &03, &04, &09, &09
    equb &10, &03, &03, &03, &10, &10, &10, &10
; &0b90 used as index base 2 times by &15b5, &7cc5
.trapdoor_x
; &0b97 used as index base 1 time by &79d3
    equb &0b, &15, &17, &10, &03, &17, &0d, &1a
; &0b98 used as index base 2 times by &15bb, &7ccb
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
; &0bfc referenced 2 times by &1d0f, &1d1d
    equb &13, &00
    equb &02, &00
    equb &c8, &00
    equb &02, &00
; &0c00 used as index base 1 time by &15c8
.room_walls
    equs "TIKP$UTHO[KF,D]/DYW3CZD\8V\;VHRVao"
    equb &02
    equs "brlu"
    equb &07, &00, &6a, &03, &0b, &1d, &14, &16
    equb &19, &10
    equs "pgtafb"
    equb &19, &71, &19
; &0c3a used as index base 1 time by &10ba
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
    equb &89, &9e, &87, &f3, &95, &9b, &92, &f7
    equb &90, &98, &8a, &8b, &85, &fd, &9a, &8a
    equb &ae, &a6, &a7, &ac, &aa, &ac, &a8, &a0
    equb &c9, &00, &00, &00, &00, &00, &00, &00
.hit_sound
; &0cf4 referenced 2 times by &7481, &7491
    equb &10, &00
    equb &01, &00
    equb &06, &00
    equb &06, &00
    equb &12, &00, &03, &00, &c8, &00, &0a
.dasmos_dunj3_end

    org &0e00

.dasmos_dunj4_start
; &0e00 referenced 2 times by &07ca, &0ecc
.new_game
    lda #0                              ; New game: level 0...
    sta level_number                    ; ...
    sta level_bcd                       ; ...
    tax                                 ; Give each hero their starting attributes
; &0e09 referenced 1 time by &0e0f
.reset_each_hero
    jsr reset_hero                      ; ...
    inx                                 ; ...
    cpx #4                              ; ...
    bne reset_each_hero                 ; ...
    jsr hero_menu                       ; ...
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
    bcs two_level_digits                ; ...
    ldx #0                              ; X = 0: one digit
    beq store_level_units               ; ...(always branches)
; &0e34 referenced 1 time by &0e2e
.two_level_digits
    ldx #1                              ; X = 1: two digits
; &0e36 referenced 1 time by &0e32
.store_level_units
    lda level_bcd                       ; Units digit...
    and #&0f                            ; ...
    clc                                 ; ...as ASCII...
    adc #&30 ; '0'                      ; ...
    sta level_filename_digits,x         ; ...into the filename
    cpx #0                              ; Two digits?
    beq end_level_filename              ; No
    lda level_bcd                       ; Yes: the tens digit...
    lsr a                               ; ...
    lsr a                               ; ...
    lsr a                               ; ...
    lsr a                               ; ...
    clc                                 ; ...as ASCII...
    adc #&30 ; '0'                      ; ...
    sta level_filename_digits           ; ...goes first
; &0e52 referenced 1 time by &0e43
.end_level_filename
    lda #&0d                            ; Terminate the filename with a carriage return
    sta level_filename_digits + 1,x     ; ...
    jsr start_level                     ; Load and draw the level
    jsr draw_status_panel               ; Draw the status panel
    jsr remove_absent_heroes            ; Take out the heroes nobody plays
    lda #1                              ; Let one vertical sync pass before play starts
    sta os_vsync_counter                ; ...
    jsr play_level                      ; Play the level until it ends
    ldx #0                              ; Count the heroes who died, giving each back their starting attributes
    stx count                           ; ...
; &0e6d referenced 1 time by &0e7d
.check_hero_dead
    lda hero_health_tens,x              ; Dead?
    cmp #&1d                            ; ...
    bne next_hero_dead                  ; ...
    jsr reset_hero                      ; Yes: reset them
    inc count                           ; ...and count them
; &0e7a referenced 1 time by &0e72
.next_hero_dead
    inx                                 ; Next hero
    cpx #4                              ; ...
    bne check_hero_dead                 ; ...
    lda count                           ; Any hero alive?
    cmp #4                              ; ...
    bne level_loop                      ; Yes: on to the next level
    jsr game_over_music                 ; All dead: stop the music and start VDU 28,0,24,16,0, a text window on the left...
    nop                                 ; Padding
    nop                                 ; ...
    lda #0                              ; ...
    jsr oswrch                          ; ...
    lda #&18                            ; ...
    jsr oswrch                          ; ...
    lda #&10                            ; ...
    jsr oswrch                          ; ...
    lda #0                              ; ...
    jsr oswrch                          ; ...
    lda #&0c                            ; ...VDU 12 to clear it
    jsr oswrch                          ; ...
    ldx #4                              ; Put spaces back over the four message bytes used as counters
    lda #&20 ; ' '                      ; ...
; &0ea8 referenced 1 time by &0eac
.restore_message_spaces
    sta panel_hero - 1,x                ; ...
    dex                                 ; ...
    bne restore_message_spaces          ; ...
; &0eae referenced 1 time by &0eb7
.print_game_over
    lda game_over_message,x             ; Print game_over_message...
    jsr osasci                          ; ...
    inx                                 ; ...
    cmp #0                              ; ...up to its zero byte
    bne print_game_over                 ; ...
; &0eb9 referenced 1 time by &0ebc
.wait_vsync_game_over
    lda os_vsync_counter                ; Wait for the vertical sync counter to run out
    bne wait_vsync_game_over            ; ...
    lda #osbyte_flush_buffer_class      ; Flush the input buffers
    jsr osbyte                          ; ...  Flush selected class of buffer
    ldx #&f4                            ; Wait up to &1F4 centiseconds (5 s) for a key...
    ldy #1                              ; ...
    lda #osbyte_inkey                   ; ...
    jsr osbyte                          ; ...  Read a key, waiting up to 500 centiseconds
    jmp new_game                        ; ...then start a new game
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
.draw_panel_hero
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
.draw_missile_icons
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
    bcc draw_missile_icons              ; ...
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
    bne draw_panel_hero                 ; ...
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
    adc workspace_template + 208,x      ; ...(read from workspace_template, which page &0D copies)
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
; ***************************************************************************************
; Game-over message
;
; Eleven lines of seventeen characters, each ended by a carriage return, then a line feed
; and a last line ended by a zero byte. Two bytes of it (&0FF1, &0FF2) double as
; counters, and are overwritten with spaces before printing, so the full stop after "YOU
; ALL" never appears.
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
.game_over_you_all
; &0ff0 used as index base 1 time by &0ea8
; &0ff1 referenced 8 times by &0ef9, &0efc, &0f18, &0f28, &0f4d, &0f5d, &0f60, &0f6d
panel_hero = game_over_you_all+7
; &0ff2 referenced 5 times by &0e6a, &0e77, &0e7f, &0f35, &0f48
count = game_over_you_all+8
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
; &1070 referenced 1 time by &1f0a
.check_for_victory
    lda level_number                    ; Only on level 25
    cmp #&19                            ; ...
    bne return_2                        ; ...
    ldx #0                              ; Is a hero on one of the Chalice's cells, x &1A or &1B...
; &1079 referenced 1 time by &1087
.check_door_x
    lda hero_door_x,x                   ; ...
    cmp #&1a                            ; ...
    beq check_door_y                    ; ...
    cmp #&1b                            ; ...
    beq check_door_y                    ; ...
; &1084 referenced 1 time by &1095
.next_hero_victory
    inx                                 ; Next hero
    cpx #4                              ; ...
    bne check_door_x                    ; ...
; &1089 referenced 1 time by &1075
.return_2
    rts                                 ; Return
; &108a referenced 2 times by &107e, &1082
.check_door_y
    lda hero_door_y,x                   ; ...and y 4 or 5?
    cmp #4                              ; ...
    beq start_victory                   ; ...
    cmp #5                              ; ...
    beq start_victory                   ; ...
    bne next_hero_victory               ; No: next hero
; &1097 referenced 2 times by &108f, &1093
.start_victory
    jsr victory_sequence                ; Yes: play the victory sequence
    lda #&1c                            ; VDU 28,0,24,16,0: a text window on the left...
    jsr oswrch                          ; ...
    lda #0                              ; ...
    jsr oswrch                          ; ...
    lda #&18                            ; ...
    jsr oswrch                          ; ...
    lda #&10                            ; ...
    jsr oswrch                          ; ...
    lda #0                              ; ...
    jsr oswrch                          ; ...
    lda #&0c                            ; ...VDU 12 to clear it
    jsr oswrch                          ; ...
    ldx #0                              ; Print 140 bytes from room_walls + &3A...
; &10ba referenced 1 time by &10c3
.print_victory_text
    lda room_walls + 58,x               ; ...
    jsr osasci                          ; ...
    inx                                 ; ...
    cpx #&8c                            ; ...
    bne print_victory_text              ; ...
    ldx #0                              ; ...then the string at object_free_map + &3A: on level 25, the ending message
; &10c7 referenced 1 time by &10d0
.print_ending_message
    lda object_free_map + 58,x          ; ...
    jsr osasci                          ; ...
    inx                                 ; ...
    cmp #0                              ; ...
    bne print_ending_message            ; ...
    lda #osbyte_flush_buffer_class      ; Flush the input buffers
    jsr osbyte                          ; ...  Flush selected class of buffer
    jsr osrdch                          ; Wait for a key
    lda reset_vector                    ; Copy the RESET vector into the JSR below...
    sta reset_call_address              ; ...
    lda reset_vector + 1                ; ...
    sta reset_call_address + 1          ; ...
.reset_call
; &10e7 referenced 1 time by &10dd
reset_call_address = reset_call+1
; &10e8 referenced 1 time by &10e3
    jsr &00                             ; ...and call it: reset the machine
; ***************************************************************************************
; Play the victory sequence
;
; Spin sprites round the Chalice with a rising tone, then dissolve it.
; &10e9 referenced 1 time by &1097
.victory_sequence
    lda #osbyte_bell_envelope           ; OSBYTE &D4: the bell's envelope...
    ldx #8                              ; ...8
    jsr osbyte                          ; ...  osbyte: bell envelope
    lda #0                              ; No pixel offsets
    sta plot_offset_x                   ; ...
    sta plot_offset_y                   ; ...
    lda #&16                            ; The ring starts with the first sparkle
    sta victory_sprite                  ; ...
    lda #0                              ; Tone starts at pitch 0...
    sta victory_pitch                   ; ...
    lda #&e6                            ; ...with the frames &E6 units apart...
    sta victory_delay                   ; ...
    lda #&32 ; '2'                      ; ...for &32 rises...
    sta victory_steps_left              ; ...
    lda #1                              ; ...each by 1 to begin with
    sta victory_pitch_step              ; ...
; &110a referenced 1 time by &1146
.raise_victory_pitch
    clc                                 ; Raise the pitch
    lda victory_pitch                   ; ...
    adc victory_pitch_step              ; ...
    sta victory_pitch                   ; ...
    bcc shorten_victory_delay           ; No carry: carry on
    inc victory_pitch_step              ; Carry: rise faster...
    dec victory_steps_left              ; ...and count a rise
    bne shorten_victory_delay           ; More to come
    jmp erase_victory_ring              ; Done: finish
; &111c referenced 2 times by &1111, &1117
.shorten_victory_delay
    dec victory_delay                   ; Shorten the delay...
    bne sound_victory_bell              ; ...
    lda #1                              ; ...to at least 1
    sta victory_delay                   ; ...
; &1124 referenced 1 time by &111e
.sound_victory_bell
    ldx victory_pitch                   ; OSBYTE &D5: the bell's pitch...
    lda #osbyte_bell_frequency          ; ...
    jsr osbyte                          ; ...  osbyte: bell frequency
    lda #7                              ; ...and sound the bell
    jsr oswrch                          ; ...
    jsr draw_victory_ring               ; Draw the ring
    lda victory_delay                   ; At full speed, dissolve the Chalice a byte at a time
    cmp #1                              ; ...
    bne victory_delay_loop              ; ...
    jsr dissolve_chalice                ; ...
; &113c referenced 1 time by &1137
.victory_delay_loop
    ldx victory_delay                   ; Wait for the delay
; &113e referenced 1 time by &1144
.victory_delay_outer
    ldy #&ff                            ; ...
; &1140 referenced 1 time by &1141
.victory_delay_inner
    dey                                 ; ...
    bne victory_delay_inner             ; ...
    dex                                 ; ...
    bne victory_delay_outer             ; ...
    jmp raise_victory_pitch             ; Next frame
; ***************************************************************************************
; Draw the ring of sprites round the Chalice
;
; Plot the current victory sprite at the twelve cells round the Chalice, changing sprite
; as it goes.
; &1149 referenced 2 times by &1130, &11d7
.draw_victory_ring
    lda #&1c                            ; Start at x &1C, y 3: the ring runs round the Chalice's four cells
    sta ring_x                          ; ...
    lda #3                              ; ...
    sta ring_y                          ; ...
    jsr plot_victory_sprite             ; ...
    dec ring_x                          ; Left...
    jsr plot_victory_sprite             ; ...
    dec ring_x                          ; Left...
    jsr plot_victory_sprite             ; ...
    lda victory_sprite                  ; Keep the sprite...
    sta victory_sprite_copy             ; ...
    jsr next_victory_sprite             ; ...and change it
    dec ring_x                          ; Left...
    jsr plot_victory_sprite             ; ...
    inc ring_y                          ; Down...
    jsr plot_victory_sprite             ; ...
    inc ring_y                          ; Down...
    jsr plot_victory_sprite             ; ...
    jsr next_victory_sprite             ; Change sprite
    inc ring_y                          ; Down...
    jsr plot_victory_sprite             ; ...
    inc ring_x                          ; Right...
    jsr plot_victory_sprite             ; ...
    inc ring_x                          ; Right...
    jsr plot_victory_sprite             ; ...
    jsr next_victory_sprite             ; Change sprite
    inc ring_x                          ; Right...
    jsr plot_victory_sprite             ; ...
    dec ring_y                          ; Up...
    jsr plot_victory_sprite             ; ...
    dec ring_y                          ; Up...
    jsr plot_victory_sprite             ; ...
    rts                                 ; Return
; ***************************************************************************************
; Plot a victory sprite at a cell
;
; Plot the current victory sprite at the map cell in &80, &81.
; &119a referenced 12 times by &1151, &1156, &115b, &1168, &116d, &1172, &117a, &117f, &1184, &118c, &1191, &1196
.plot_victory_sprite
    lda ring_x                          ; Plot the victory sprite at the ring cell
    sta cell_x                          ; ...
    lda ring_y                          ; ...
    sta cell_y                          ; ...
    lda victory_sprite                  ; ...
    sta sprite_number                   ; ...
    jsr plot_at_cell                    ; ...
    rts                                 ; Return
; ***************************************************************************************
; Choose the next victory sprite
;
; Step the victory sprite through &16-&19.
; &11ac referenced 3 times by &1163, &1175, &1187
.next_victory_sprite
    lda victory_sprite                  ; Erasing (sprite &15)? Keep it
    cmp #&15                            ; ...
    beq store_victory_sprite            ; ...
    clc                                 ; Next sparkle, &16-&19 in turn
    adc #1                              ; ...
    cmp #&1a                            ; ...
    bne store_victory_sprite            ; ...
    lda #&16                            ; ...
; &11bb referenced 2 times by &11b0, &11b7
.store_victory_sprite
    sta victory_sprite                  ; ...
    rts                                 ; Return
; ***************************************************************************************
; Clear a random byte of the Chalice
;
; Use the System VIA timer to pick a byte of the Chalice sprite, clear it, and redraw the
; Chalice.
; &11be referenced 1 time by &1139
.dissolve_chalice
    lda system_via_t1c_l                ; Pick a byte of the Chalice at random...
    eor os_irq_a                        ; ...
    eor os_zp_fa                        ; ...
    cmp #&c0                            ; ...if it is within the sprite
    bcs return_3                        ; ...
    tax                                 ; Clear it...
    lda #0                              ; ...
    sta sprite_chalice,x                ; ...
    jsr plot_chalice                    ; ...and redraw the Chalice
; &11d2 referenced 1 time by &11c7
.return_3
    rts                                 ; Return
; &11d3 referenced 1 time by &1119
.erase_victory_ring
    lda #&15                            ; Erase the ring
    sta victory_sprite                  ; ...
    jsr draw_victory_ring               ; ...
    ldx #&c1                            ; Clear the whole Chalice sprite...
    lda #0                              ; ...
; &11de referenced 1 time by &11e2
.clear_chalice_sprite
    sta sprite_chalice - 1,x            ; ...
    dex                                 ; ...
    bne clear_chalice_sprite            ; ...
    jsr plot_chalice                    ; ...and redraw it, now blank
    lda #&ff                            ; Wait 255 vertical syncs (about five seconds)
    sta os_vsync_counter                ; ...
; &11ec referenced 1 time by &11ef
.wait_vsync_chalice
    lda os_vsync_counter                ; ...
    bne wait_vsync_chalice              ; ...
    rts                                 ; Return
; ***************************************************************************************
; Plot the Chalice
;
; Plot the Chalice sprite at its place on the map.
; &11f2 referenced 2 times by &11cf, &11e4
.plot_chalice
    lda #&1a                            ; The Chalice's top-left cell, x &1A, y 4...
    sta cell_x                          ; ...
    lda #4                              ; ...
    sta cell_y                          ; ...
    lda #&73 ; 's'                      ; ...sprite &73...
    sta sprite_number                   ; ...
    jsr plot_at_cell                    ; ...plotted in every view showing it
    rts                                 ; Return
    equs "Rx`(&1900+F%"
; &1210 used as index base 1 time by &11cc
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
.saved_wrchv
    equb &a4, &e0, &00, &73
; ***************************************************************************************
; Font: letters A-Z
;
; Eight bytes per letter, copied into the definition of character 128 by the WRCHV
; handler.
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
; Stop the music (saving its place after the first level), count the level, put the MOS's
; page &0D back and load the level, unpack it, reset the workspace and monsters, clear
; the text area, show 25 rows, draw the view frames and views, and restart the music,
; from where it was after the first level.
; &1400 referenced 1 time by &0e57
.start_level
    lda first_level_flag                ; First level?
    cmp #&7b ; '{'                      ; ...
    bne code_1419                       ; ...
    lda music_rhythm_step               ; No: keep the music's place on the stack: its step...
    pha                                 ; ...
    lda music_transpose                 ; ...transposition...
    pha                                 ; ...
    lda music_section                   ; ...section...
    pha                                 ; ...
    lda tune_ptr                        ; ...and tune pointer (zero page &00-&01)
    pha                                 ; ...
    lda tune_ptr + 1                    ; ...
    pha                                 ; ...
; &1419 referenced 1 time by &1405
.code_1419
    jsr stop_music                      ; Stop the music
    jsr count_level                     ; Clear the text area and count the level
    jsr load_level                      ; Put page &0D back and load the level
    jsr unpack_level                    ; Copy it into the game's tables
    jsr reset_workspace                 ; Reset page &0D for play
    jsr reset_monsters                  ; Reset the monsters and keys
    jsr clear_text_area                 ; Clear the text area
    lda #&17                            ; VDU 23,0,6,25,0,0,0,0,0,0: set 6845 register 6...
    jsr oswrch                          ; ...
    lda #0                              ; ...
    jsr oswrch                          ; ...
    lda #6                              ; ...
    jsr oswrch                          ; ...
    lda #&19                            ; ...to 25 character rows displayed
    jsr oswrch                          ; ...
    lda #0                              ; ...
    jsr oswrch                          ; ...
    jsr oswrch                          ; ...
    jsr oswrch                          ; ...
    jsr oswrch                          ; ...
    jsr oswrch                          ; ...
    jsr oswrch                          ; ...
    lda #&3a ; ':'                      ; Point at view_frame_plots...
    sta plot_x                          ; ...
    lda #&16                            ; ...
    sta plot_y                          ; ...
    jsr draw_view_frames                ; ...and draw the frames and the views
    jsr start_music                     ; Start the music
    lda first_level_flag                ; First level?
    cmp #&7b ; '{'                      ; ...
    bne code_147d                       ; ...
    pla                                 ; No: put the music's place back: tune pointer...
    sta tune_ptr + 1                    ; ...
    pla                                 ; ...
    sta tune_ptr                        ; ...
    pla                                 ; ...section...
    sta music_section                   ; ...
    pla                                 ; ...transposition...
    sta music_transpose                 ; ...
    pla                                 ; ...and rhythm step
    sta music_rhythm_step               ; ...
; &147d referenced 1 time by &1469
.code_147d
    lda #&7b ; '{'                      ; Mark the first level done
    sta first_level_flag                ; ...
    rts                                 ; Return
; ***************************************************************************************
; Put the MOS's page &0D back and load the level
;
; Copy the MOS's page &0D back from &C400 (Coder saved it there), so that the filing
; system's NMI code and workspace are intact, write the level number's digits into
; level_command, show 15 rows while loading, and *LOAD LEVELnn 6B00 (level 25 comes from
; Stones, via load_stones in Table). Then decrypt and check it.
; &1483 referenced 1 time by &141f
.load_level
    ldx #0                              ; Copy &C400-&C4FF back to page &0D...
; &1485 referenced 1 time by &148c
.loop_1485
    lda saved_page_0d,x                 ; ...
    sta scratch,x                       ; ...
    dex                                 ; ...
    bne loop_1485                       ; ...
    lda level_bcd                       ; Level 10 or more (in BCD)?
    cmp #&0a                            ; ...
    bcs code_14a7                       ; ...
    lda #&20 ; ' '                      ; No: units digit then a space
    sta level_command_digits + 1        ; ...
    lda level_bcd                       ; ...
    and #&0f                            ; ...
    clc                                 ; ...
    adc #&30 ; '0'                      ; ...
    sta level_command_digits            ; ...
    bne code_14bf                       ; ...(always branches)
; &14a7 referenced 1 time by &1493
.code_14a7
    lda level_bcd                       ; Yes: tens digit...
    lsr a                               ; ...
    lsr a                               ; ...
    lsr a                               ; ...
    lsr a                               ; ...
    clc                                 ; ...
    adc #&30 ; '0'                      ; ...
    sta level_command_digits            ; ...
    lda level_bcd                       ; ...then units digit
    and #&0f                            ; ...
    clc                                 ; ...
    adc #&30 ; '0'                      ; ...
    sta level_command_digits + 1        ; ...
; &14bf referenced 1 time by &14a5
.code_14bf
    lda #&17                            ; VDU 23,0,6,15,0,0,0,0,0,0: show 15 character rows while loading...
    jsr oswrch                          ; ...
    lda #0                              ; ...
    jsr oswrch                          ; ...
    lda #6                              ; ...
    jsr oswrch                          ; ...
    lda #&0f                            ; ...
    jsr oswrch                          ; ...
    lda #0                              ; ...
    jsr oswrch                          ; ...
    jsr oswrch                          ; ...
    jsr oswrch                          ; ...
    jsr oswrch                          ; ...
    jsr oswrch                          ; ...
    jsr oswrch                          ; ...
    lda level_number                    ; Level 25?
    cmp #&19                            ; ...
    bne code_14f1                       ; ...
    jmp load_stones                     ; Yes: load it from Stones (and check it there)
; &14f1 referenced 1 time by &14ec
.code_14f1
    ldx #&fb                            ; No: *LOAD LEVELnn 6B00
    ldy #&14                            ; ...
    jsr oscli                           ; ...
    jmp decrypt_level                   ; Decrypt and check it, and return from there
.level_command
; &1505 referenced 2 times by &14a2, &14b1
level_command_digits = level_command+10
; &1506 referenced 2 times by &1497, &14bc
    equs "LOAD LEVEL11 6B00"
    equb &0d
; ***************************************************************************************
; Reset the game workspace for a new level
;
; Copy workspace_template into page &0D and clear the per-level state.
; &150d referenced 1 time by &1425
.reset_workspace
    ldx #0                              ; Copy workspace_template to page &0D
; &150f referenced 1 time by &1516
.copy_workspace_template
    lda workspace_template,x            ; ...
    sta scratch,x                       ; ...
    inx                                 ; ...
    bne copy_workspace_template         ; ...
    lda #0                              ; Reset the exit and other per-level state
    sta exit_busy                       ; ...
    sta exit_offset_x_3                 ; ...
    sta exit_offsets_y                  ; ...
    sta exit_offset_y_4                 ; ...
    sta next_trapdoor                   ; First monster emerges from trapdoor 0
    lda #1                              ; Offsets for the exit animation, and no hero shrunk
    sta exit_offset_x_1                 ; ...
    sta exit_offset_x_2                 ; ...
    sta exit_offset_y_3                 ; ...
    lda #&ff                            ; ...
    sta shrunk_hero                     ; ...
    lda #5                              ; ...
    sta exit_offset_y_1                 ; ...
    lda #3                              ; ...
    sta exit_offset_y_2                 ; ...
    rts                                 ; Return
; ***************************************************************************************
; Draw the frames round the four views
;
; Send the twenty PLOT commands of view_frame_plots, draw the four views, then point
; WRCHV at &7F8F, which on this side passes every character straight to the MOS.
;
; On Entry:
;     PLOT_X: address of view_frame_plots, low byte
;     PLOT_Y: address of view_frame_plots, high byte
; &1544 referenced 1 time by &145e
.draw_view_frames
    ldx #&14                            ; Twenty PLOT commands
; &1546 referenced 1 time by &1561
.draw_view_frame
    lda #&19                            ; VDU 25...
    jsr oswrch                          ; ...
    ldy #0                              ; ...then the five bytes of the command
; &154d referenced 1 time by &1555
.send_frame_vdu
    lda (plot_x),y                      ; ...
    jsr oswrch                          ; ...
    iny                                 ; ...
    cpy #5                              ; ...
    bne send_frame_vdu                  ; ...
    clc                                 ; Next command
    lda plot_x                          ; ...
    adc #5                              ; ...
    sta plot_x                          ; ...
    ldy #0                              ; ...
    dex                                 ; ...
    bne draw_view_frame                 ; ...
    jsr draw_all_views                  ; Draw the four views
    lda #&8f                            ; Point WRCHV at &7F8F...
    sta wrchv                           ; ...
    lda #&7f                            ; ...
    sta wrchv + 1                       ; ...
    rts                                 ; Return
; ***************************************************************************************
; Copy the loaded level into the game's tables
;
; Distribute the level file at &6B00 into the object, door, key, trapdoor and map tables
; and the wall sprite.
; &1571 referenced 1 time by &1422
.unpack_level
    ldx #&1e                            ; Objects 30 to 1: position and type
; &1573 referenced 1 time by &1586
.unpack_objects
    lda level_object_x,x                ; ...
    sta object_x,x                      ; ...
    lda level_object_y,x                ; ...
    sta object_y,x                      ; ...
    lda level_object_type,x             ; ...
    sta object_type,x                   ; ...
    dex                                 ; ...
    bne unpack_objects                  ; ...
    ldx #&14                            ; Doors 20 to 1: position and sprite
; &158a referenced 1 time by &159d
.unpack_doors
    lda level_door_x,x                  ; ...
    sta door_x,x                        ; ...
    lda level_door_y,x                  ; ...
    sta door_y,x                        ; ...
    lda level_door_sprite,x             ; ...
    sta door_sprite,x                   ; ...
    dex                                 ; ...
    bne unpack_doors                    ; ...
    ldx #&14                            ; Keys 20 to 1: position
; &15a1 referenced 1 time by &15ae
.unpack_keys
    lda level_key_x,x                   ; ...
    sta key_x,x                         ; ...
    lda level_key_y,x                   ; ...
    sta key_y,x                         ; ...
    dex                                 ; ...
    bne unpack_keys                     ; ...
    ldx #0                              ; Trapdoors 0 to 7: position
; &15b2 referenced 1 time by &15c1
.unpack_trapdoors
    lda level_trapdoor_x,x              ; ...
    sta trapdoor_x,x                    ; ...
    lda level_trapdoor_y,x              ; ...
    sta trapdoor_y,x                    ; ...
    inx                                 ; ...
    cpx #8                              ; ...
    bne unpack_trapdoors                ; ...
    ldx #0                              ; Wall map and object-free map, &C9 bytes each
; &15c5 referenced 1 time by &15d4
.unpack_walls
    lda level_walls,x                   ; ...
    sta room_walls,x                    ; ...
    lda level_object_free_map,x         ; ...
    sta object_free_map,x               ; ...
    inx                                 ; ...
    cpx #&c9                            ; ...
    bne unpack_walls                    ; ...
    ldx #0                              ; The level's wall sprite, &30 bytes
; &15d8 referenced 1 time by &15e1
.unpack_wall_sprite
    lda level_wall_sprite,x             ; ...
    sta wall_sprite,x                   ; ...
    inx                                 ; ...
    cpx #&30 ; '0'                      ; ...
    bne unpack_wall_sprite              ; ...
    rts                                 ; Return
; ***************************************************************************************
; Clear the monsters for a new level
;
; Mark every monster as not yet appeared, give each the level's starting hit points, and
; clear the heroes' keys and the returning_hero_queue.
; &15e4 referenced 1 time by &1428
.reset_monsters
    ldx #&1e                            ; Monsters 30 to 1...
; &15e6 referenced 1 time by &15f7
.reset_each_monster
    lda #&15                            ; ...dying, so that they emerge from the trapdoors...
    sta monster_sprite,x                ; ...
    lda #&ff                            ; ...off the map...
    sta monster_x,x                     ; ...
    lda monster_start_hit_points        ; ...with this level's hit points
    sta monster_hit_points,x            ; ...
    dex                                 ; ...
    bne reset_each_monster              ; ...
    ldx #0                              ; For each hero: clear the returning queue, the key carried and the door-check position
    lda #0                              ; ...
; &15fd referenced 1 time by &160f
.clear_hero_carrying
    sta returning_hero_queue,x          ; ...
    sta hero_key,x                      ; ...
    sta hero_key_dropped,x              ; ...
    sta hero_door_x,x                   ; ...
    sta hero_door_y,x                   ; ...
    inx                                 ; ...
    cpx #4                              ; ...
    bne clear_hero_carrying             ; ...
    rts                                 ; Return
; ***************************************************************************************
; Clear the text area and count the level
;
; The cassette game's show_level_number also plots LEVEL and the number; this side shows
; no level number.
; &1612 referenced 1 time by &141c
.count_level
    jsr clear_text_area                 ; Clear the text area
    inc level_number                    ; Count the level
    rts                                 ; Return
; ***************************************************************************************
; Clear the left of the screen
;
; Set a text window over the left of the screen and clear it.
; &1619 referenced 2 times by &142b, &1612
.clear_text_area
    lda #&1c                            ; VDU 28: a text window over the whole of the left of the screen...
    jsr oswrch                          ; ...
    lda #0                              ; ...
    jsr oswrch                          ; ...
    lda #&18                            ; ...
    jsr oswrch                          ; ...
    lda #&13                            ; ...
    jsr oswrch                          ; ...
.code_162d
; &162e referenced 1 time by &c60a
clear_text_area_top = code_162d+1
    lda #0                              ; ...
    jsr oswrch                          ; ...
    lda #&0c                            ; ...VDU 12 to clear it
    jsr oswrch                          ; ...
    rts                                 ; Return
; &1638 referenced 3 times by &1400, &1464, &147f
.first_level_flag
    equb &ea
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
; &169f referenced 7 times by &0477, &0e02, &0e14, &0e29, &1070, &14e7, &1615
.level_number
    equb &01
; ***************************************************************************************
; Sound the exit and add a queue marker
;
; Play the exit sound and put a &64 entry in the first free slot of returning_hero_queue.
; &16a0 referenced 1 time by &203d
.queue_exit_marker
    ldx #<(exit_envelope)               ; Define the exit envelope...
    ldy #>(exit_envelope)               ; ...
    lda #osword_envelope                ; ...
    jsr osword                          ; ENVELOPE command
    ldx #<(exit_sound)                  ; ...and play the exit sound
    ldy #>(exit_sound)                  ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; SOUND command
    ldx #0                              ; Find the end of returning_hero_queue...
; &16b4 referenced 1 time by &16c0
.find_queue_end
    lda returning_hero_queue,x          ; ...
    bne next_queue_entry                ; ...
    lda #&64 ; 'd'                      ; ...and add a &64 marker there
    sta returning_hero_queue,x          ; ...
    rts                                 ; Return
; &16bf referenced 1 time by &16b7
.next_queue_entry
    inx                                 ; Next entry
    bne find_queue_end                  ; ...
    equb &02, &02, &00, &00, &83, &00, &00, &00
    equb &00, &00, &00, &31, &00, &8d
    equs "LEVEL"
; &16d5 referenced 1 time by &0e4f; also used as index base 1 time by &0e3e
.level_filename_digits
; &16d6 used as index base 1 time by &0e54
    equb &31, &0d, &0d, &70, &00, &8d, &35, &f8
    equb &00, &00, &00, &00
    equs "code"
    equb &00, &54, &12, &03, &17, &74, &00, &8c
    equb &50, &00, &00, &00, &fa, &16, &78, &00
    equb &8c, &50, &20, &00, &00, &02, &00, &79
    equb &00, &8c
; &16ff referenced 9 times by &0e05, &0e20, &0e25, &0e36, &0e45, &148e, &149a, &14a7, &14b4
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
; &1ae0 used as index base 2 times by &0902, &d802
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
; &1b58 used as index base 2 times by &0907, &d807
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
; &1bd0 used as index base 4 times by &090c, &2009, &205f, &d80c
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
; &1c48 used as index base 5 times by &0911, &2015, &201a, &206c, &d811
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
    jsr move_heroes                     ; Move the heroes
    ldx #0                              ; For each hero...
; &1cc5 referenced 1 time by &1dbf
.check_doors
    stx scratch                         ; ...look for a door at the cell the hero is moving into
    lda hero_door_x,x                   ; ...
    sta cell_x                          ; ...
    lda hero_door_y,x                   ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    ldx #&14                            ; Doors 20 to 1
; &1cd8 referenced 1 time by &1db5
.check_door
    lda door_x,x                        ; This door's x?
    cmp cell_x                          ; ...
    beq check_door_cell_y               ; ...
    jmp next_door                       ; No: next door
; &1ce3 referenced 1 time by &1cde
.check_door_cell_y
    lda door_y,x                        ; ...and y?
    cmp cell_y                          ; ...
    beq check_door_key                  ; ...
    jmp next_door                       ; No: next door
; &1cee referenced 1 time by &1ce9
.check_door_key
    pla                                 ; Does the hero carry this door's key?
    tay                                 ; ...
    pha                                 ; ...
    txa                                 ; ...
    cmp hero_key,y                      ; ...
    beq open_door                       ; Yes
    jmp next_door                       ; No: next door
; &1cfa referenced 1 time by &1cf5
.open_door
    txa                                 ; Open the door: 7 points...
    pha                                 ; ...
    tya                                 ; ...
    pha                                 ; ...
    ldy #7                              ; ...
    ldx scratch                         ; ...
; &1d03 referenced 1 time by &1d0b
.erase_door_loop
    tya                                 ; ...
    pha                                 ; ...
    jsr add_point                       ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    bne erase_door_loop                 ; ...
    lda #&96                            ; ...play the food sound at a lower pitch...
    sta food_sound + 4                  ; ...
    ldx #<(food_sound)                  ; ...
    ldy #>(food_sound)                  ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; ...  SOUND command
    lda #&c8                            ; ...and put its pitch back
    sta food_sound + 4                  ; ...
    lda cell_y                          ; Keep the door's cell in spare bytes beyond the monster tables, as plot_at_cell changes cell_x and cell_y...
    sta monster_y + 35                  ; ...
    lda cell_x                          ; ...
    sta monster_x + 35                  ; ...
    lda #&15                            ; ...erase the door...
    sta sprite_number                   ; ...
    lda #0                              ; ...
    sta plot_offset_x                   ; ...
    sta plot_offset_y                   ; ...
    jsr plot_at_cell                    ; ...
    lda monster_x + 35                  ; ...and recover its cell
    sta cell_x                          ; ...
    lda monster_y + 35                  ; ...
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
    sta map_ptr                         ; ...
    lda cell_x                          ; ...
    and #&f8                            ; ...
    adc map_ptr                         ; ...
    sta map_ptr                         ; ...
    lda #&0c                            ; ...in room_walls...
    sta map_ptr_hi                      ; ...
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
    lda (map_ptr),y                     ; ...clear the bit
    and scratch                         ; ...
    sta (map_ptr),y                     ; ...
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
    jmp next_hero_doors                 ; Next hero
; &1db2 referenced 3 times by &1ce0, &1ceb, &1cf7
.next_door
    dex                                 ; Next door
    beq doors_done                      ; ...
    jmp check_door                      ; ...
; &1db8 referenced 1 time by &1db3
.doors_done
    pla                                 ; ...
    tax                                 ; ...
; &1dba referenced 1 time by &1daf
.next_hero_doors
    inx                                 ; Next hero
    cpx #4                              ; ...
    beq draw_keys                       ; ...
    jmp check_doors                     ; ...
; &1dc2 referenced 1 time by &1dbd
.draw_keys
    lda #0                              ; Draw the keys on the floor, 20 to 1
    sta plot_offset_x                   ; ...
    sta plot_offset_y                   ; ...
    lda #&1b                            ; ...
    sta sprite_number                   ; ...
    ldx #&14                            ; ...
; &1dce referenced 1 time by &1de2
.draw_each_key
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
    bne draw_each_key                   ; ...
    ldx #0                              ; For each hero...
; &1de6 referenced 1 time by &1ecb
.check_hero_keys
    lda hero_direction,x                ; In play?
    bne check_key_swap                  ; Yes
    lda hero_key,x                      ; Out of play: carrying a key?
    bne check_death_finished            ; Yes
    jmp next_hero_keys                  ; No: next hero
; &1df3 referenced 1 time by &1dee
.check_death_finished
    lda hero_frame,x                    ; Death animation finished?
    cmp #8                              ; ...
    bne check_key_swap                  ; Not yet
    ldy hero_key,x                      ; Yes: drop the key where the hero fell
    lda hero_x,x                        ; ...
    sta key_x,y                         ; ...
    lda hero_y,x                        ; ...
    sta key_y,y                         ; ...
    lda #0                              ; ...
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
    jmp next_hero_keys                  ; Next hero
; &1e28 referenced 2 times by &1de9, &1df8
.check_key_swap
    lda hero_key_dropped,x              ; Just swapped keys?
    beq check_key_cell                  ; No
    lda #0                              ; Yes: not again until the hero moves on
    sta hero_key_dropped,x              ; ...
    jmp next_hero_keys                  ; ...
; &1e35 referenced 1 time by &1e2b
.check_key_cell
    lda hero_x,x                        ; Is there a key at the hero's cell?
    sta cell_x                          ; ...
    lda hero_y,x                        ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    ldx #&14                            ; ...keys 20 to 1
; &1e45 referenced 1 time by &1ec1
.check_key
    lda key_x,x                         ; ...
    cmp cell_x                          ; ...
    bne next_key                        ; ...
    lda key_y,x                         ; ...
    cmp cell_y                          ; ...
    bne next_key                        ; ...
    lda #&15                            ; Yes: erase it from the floor
    sta sprite_number                   ; ...
    lda #0                              ; ...
    sta plot_offset_x                   ; ...
    sta plot_offset_y                   ; ...
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
    jmp next_hero_keys                  ; Next hero
; &1ebe referenced 2 times by &1e4b, &1e53
.next_key
    dex                                 ; Next key
    beq keys_done                       ; ...
    jmp check_key                       ; ...
; &1ec4 referenced 1 time by &1ebf
.keys_done
    pla                                 ; ...
    tax                                 ; ...
; &1ec6 referenced 4 times by &1df0, &1e25, &1e32, &1ebb
.next_hero_keys
    inx                                 ; Next hero
    cpx #4                              ; ...
    beq update_rest                     ; ...
    jmp check_hero_keys                 ; ...
; &1ece referenced 1 time by &1ec9
.update_rest
    jsr draw_objects                    ; Draw the objects
    jsr move_missiles                   ; Move the missiles
    jsr update_monsters                 ; Move the monsters
.check_pause
    jmp pause_check                     ; Check the pause key (the routine is in Table)
; ***************************************************************************************
; Unused
;
; The rest of the cassette game's f1 pause routine, never run since check_pause jumps to
; pause_check in Table.
    equb &60, &ff, &e0, &71, &d0, &15, &20, &f4
    equb &ff, &e0, &71, &f0, &f9, &20, &f4, &ff
    equb &e0, &71, &d0, &f9, &20, &f4, &ff, &e0
    equb &71, &f0, &f9, &60, &00
    equb &00, &00, &00, &00, &00
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
; &1f00 referenced 7 times by &0e65, &1f03, &1f9b, &1fef, &2023, &2037, &208e
.play_level
    lda os_vsync_counter                ; Wait for the vertical sync counter to pass zero...
    bpl play_level                      ; ...
    lda #2                              ; ...and set it for three syncs from now
    sta os_vsync_counter                ; ...
    jsr check_for_victory               ; Has the Chalice been found?
    jsr update_game                     ; Run a frame
    lda exit_busy                       ; A hero going down the exit?
    bne check_exit                      ; Yes: carry on
    ldx #4                              ; Is any hero in play, or still dying?
; &1f17 referenced 1 time by &1f2b
.count_heroes_in_play
    lda hero_direction - 1,x            ; In play?
    bne check_exit                      ; Yes: carry on
    lda hero_health_tens - 1,x          ; Dead...
    cmp #&1d                            ; ...
    bne next_hero_in_play               ; ...
    lda hero_frame - 1,x                ; ...with the death animation unfinished?
    cmp #8                              ; ...
    bcc check_exit                      ; Yes: carry on
; &1f2a referenced 1 time by &1f21
.next_hero_in_play
    dex                                 ; Next hero
    bne count_heroes_in_play            ; ...
    ldx shrunk_hero                     ; The level is over: restore the last exiting hero's sprites
    bmi return_4                        ; ...
    jsr restore_hero_sprites            ; ...
; &1f35 referenced 1 time by &1f30
.return_4
    rts                                 ; Return
; &1f36 referenced 3 times by &1f13, &1f1a, &1f28
.check_exit
    ldx #0                              ; Is a hero on the exit?
; &1f38 referenced 1 time by &1f94
.check_hero_on_exit
    lda hero_x,x                        ; ...
    cmp exit_x                          ; ...
    bne next_hero_exit                  ; ...
    lda hero_y,x                        ; ...
    cmp exit_y                          ; ...
    bne next_hero_exit                  ; ...
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
    sta plot_offset_x                   ; ...
    sta plot_offset_y                   ; ...
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
    jmp check_exit_busy                 ; Reached by the RTS at the end of the level
; &1f91 referenced 2 times by &1f3e, &1f46
.next_hero_exit
    inx                                 ; Next hero
    cpx #4                              ; ...
    bne check_hero_on_exit              ; ...
; &1f96 referenced 1 time by &1f8e
.check_exit_busy
    lda exit_busy                       ; A hero going down the exit?
    bne redraw_exit                     ; Yes
    jmp play_level                      ; No: next frame
; &1f9e referenced 1 time by &1f99
.redraw_exit
    ldx exiting_hero                    ; Redraw the exit
    lda #0                              ; ...
    sta plot_offset_x                   ; ...
    sta plot_offset_y                   ; ...
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
    beq next_turn                       ; Yes: shrink the hero
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
    sta plot_offset_x                   ; ...
    lda exit_offsets_y,x                ; ...
    sta plot_offset_y                   ; ...
    jsr plot_at_cell                    ; ...
    jmp play_level                      ; Next frame
; &1ff2 referenced 1 time by &1fc8
.next_turn
    lda #&ff                            ; Start the next turn
    sta exit_spin                       ; ...
    dec exit_shrinks_left               ; Last turn done?
    beq restore_exit                    ; Yes: the hero has gone
    clc                                 ; Shrink the hero's eight sprites: one byte narrower...
    lda hero_sprites,x                  ; ...
.dasmos_dunj4_end

    org &2000

.dasmos_dunj5_start
    adc #1                              ; ...
    tay                                 ; ...
    tax                                 ; ...
    adc #7                              ; ...
    sta scratch                         ; ...
; &2009 referenced 1 time by &2010
.shrink_hero_width
    dec sprite_widths,x                 ; ...
    inx                                 ; ...
    cpx scratch                         ; ...
    bne shrink_hero_width               ; ...
    tya                                 ; Three rows shorter...
    tax                                 ; ...
; &2014 referenced 1 time by &2021
.shrink_hero_height
    sec                                 ; ...
    lda sprite_heights,x                ; ...
    sbc #3                              ; ...
    sta sprite_heights,x                ; ...
    inx                                 ; ...
    cpx scratch                         ; ...
    bne shrink_hero_height              ; ...
    jmp play_level                      ; ...three rows shorter. Next frame
; &2026 referenced 1 time by &1ffa
.restore_exit
    lda exit_saved_x                    ; Put the exit back...
    sta exit_x                          ; ...
    lda exit_saved_y                    ; ...
    sta exit_y                          ; ...
    lda #0                              ; ...and end the animation
    sta exit_busy                       ; ...
    jmp play_level                      ; Next frame
; ***************************************************************************************
; Start a hero going down the exit
;
; Play the exit sound, restore any hero shrunk before, and start the animation of hero X
; spinning and shrinking on the exit. Ends by jumping to play_level rather than
; returning.
;
; On Entry:
;     X: hero number (0-3)
; &203a referenced 1 time by &1f8b
.hero_enters_exit
    stx scratch2                        ; Keep the hero number
    jsr queue_exit_marker               ; Sound the exit and queue a marker
    lda #4                              ; ...
    sta exit_offsets_x                  ; ...
    ldx shrunk_hero                     ; Restore the sprites of any hero shrunk before
    bmi start_hero_animation            ; ...
    jsr restore_hero_sprites            ; ...
    jmp start_hero_animation            ; ...
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
    clc                                 ; The hero's eight sprites, from base + 1
    lda hero_sprites,x                  ; ...
    adc #1                              ; ...
    tax                                 ; ...
    tay                                 ; ...
    adc #7                              ; ...
    sta scratch                         ; ...
    lda #4                              ; Widths back to 4...
; &205f referenced 1 time by &2066
.restore_sprite_widths
    sta sprite_widths,y                 ; ...
    iny                                 ; ...
    cpy scratch                         ; ...
    bne restore_sprite_widths           ; ...
    txa                                 ; ...
    tay                                 ; ...
    lda #&0c                            ; ...heights back to 12
; &206c referenced 1 time by &2073
.restore_sprite_heights
    sta sprite_heights,y                ; ...
    iny                                 ; ...
    cpy scratch                         ; ...
    bne restore_sprite_heights          ; ...
    rts                                 ; Return
; &2076 referenced 2 times by &2048, &204d
.start_hero_animation
    lda #1                              ; Start the animation for this hero...
    sta exit_busy                       ; ...
    lda scratch2                        ; ...
    sta exiting_hero                    ; ...
    sta shrunk_hero                     ; ...
    lda #&ff                            ; ...turning from the start...
    sta exit_spin                       ; ...
    lda #4                              ; ...for four turns
    sta exit_shrinks_left               ; ...
    jmp play_level                      ; Back to play_level, without returning
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
    lda hero_x,x                        ; From the hero's cell...
    sta cell_x                          ; ...
    lda hero_y,x                        ; ...
    sta cell_y                          ; ...
    txa                                 ; ...find a free cell next to it
    pha                                 ; ...
    jsr find_open_neighbour             ; ...
    pla                                 ; ...
    tax                                 ; ...
    ldy hero_key,x                      ; Put the hero's key there
    lda cell_x                          ; ...
    sta key_x,y                         ; ...
    lda cell_y                          ; ...
    sta key_y,y                         ; ...
    lda #0                              ; The hero carries no key
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
    rts                                 ; Return
; ***************************************************************************************
; Find a free cell next to a cell
;
; Starting with cell_x, cell_y, try the cells above, to the right, below and to the left,
; and leave cell_x, cell_y at the first without a wall.
; &20d0 referenced 1 time by &209f
.find_open_neighbour
    dec cell_y                          ; The cell above
    jsr test_wall                       ; ...free?
    cpy #0                              ; ...
    bne try_cell_right                  ; No
    rts                                 ; Yes: return
; &20db referenced 1 time by &20d8
.try_cell_right
    inc cell_y                          ; The cell to the right
    inc cell_x                          ; ...
    jsr test_wall                       ; ...free?
    cpy #0                              ; ...
    bne try_cell_below                  ; No
    rts                                 ; Yes: return
; &20e9 referenced 1 time by &20e6
.try_cell_below
    dec cell_x                          ; The cell below
    inc cell_y                          ; ...
    jsr test_wall                       ; ...free?
    cpy #0                              ; ...
    bne try_cell_left                   ; No
    rts                                 ; Yes: return
; &20f7 referenced 1 time by &20f4
.try_cell_left
    dec cell_y                          ; Otherwise the cell to the left
    dec cell_x                          ; ...
    rts                                 ; Return
    equb &01, &3f
; &2100 used as index base 1 time by &15ce
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
; &2200 used as index base 4 times by &158d, &1cd8, &1d8b, &77fe
.door_x
    equb &ff, &ff, &ff, &04, &ff, &ff, &06, &ff
    equb &11, &ff, &ff, &ff, &1a, &03, &03, &0b
    equb &ff, &03, &09, &12, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
; &2220 used as index base 4 times by &1593, &1ce3, &1d8e, &7804
.door_y
    equb &ff, &ff, &ff, &0d, &ff, &ff, &11, &ff
    equb &16, &ff, &ff, &ff, &1a
    equs "#'%"
    equb &ff
    equs "+.+"
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff
; &2240 used as index base 2 times by &1599, &7810
.door_sprite
    equb &ff, &1c, &1c, &1d, &1c, &1c, &1d, &1d
    equb &1d, &1d, &1d, &1c, &1c, &1d, &1d, &1c
    equb &1d, &1d, &1c, &1c, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
; &2260 used as index base 7 times by &15a4, &1dce, &1e00, &1e45, &1e8c, &1ea1, &20aa
.key_x
    equb &13, &ff, &ff, &1b, &ff, &ff, &17, &ff
    equb &1c, &ff, &ff, &ff, &02, &15, &04, &09
    equb &ff, &04, &19, &17, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
; &2280 used as index base 7 times by &15aa, &1dd4, &1e06, &1e4d, &1e92, &1ea4, &20b0
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
; &22e0 used as index base 10 times by &1600, &1cf2, &1d95, &1deb, &1dfa, &1e0b, &1e86, &1e97, &20a4, &20b5
.hero_key
    equb &00, &00, &00, &00, &00
; &22e5 used as index base 4 times by &1603, &1e28, &1e2f, &1e9c
.hero_key_dropped
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00
; &22f0 used as index base 4 times by &1079, &1606, &1cc8, &6f9b
.hero_door_x
    equb &1a, &09, &00, &16, &00
; &22f5 used as index base 4 times by &108a, &1609, &1cce, &6fa1
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
; &2d00 used as index base 1 time by &15db
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
.dasmos_dunj5_end

    org &6e80

.dasmos_dunj2_start
; ***************************************************************************************
; Move the heroes
;
; For each hero in play: continue a step between cells, or read the hero's keys (and, for
; heroes 0 and 1, the magic key) and start a step or fire a missile; check the new cell
; for walls, monsters, other heroes and objects, change view when the hero enters another
; room, and draw the hero.
; &6e80 referenced 1 time by &1cc0
.move_heroes
    ldx #0                              ; For each hero...
; &6e82 referenced 1 time by &70c6
.move_hero
    lda hero_direction,x                ; In play?
    bne remember_hero_position          ; Yes
    lda hero_step,x                     ; Out of play: never playing (step &63)?
    cmp #&63 ; 'c'                      ; ...
    bne animate_absent                  ; ...
    jmp next_hero                       ; Yes: nothing to do
; &6e91 referenced 1 time by &6e8c
.animate_absent
    jsr animate_absent_hero             ; No: dying or returning, so animate them
    jmp next_hero                       ; ...
; &6e97 referenced 1 time by &6e85
.remember_hero_position
    lda hero_x,x                        ; Remember the hero's position and offsets before moving
    sta previous_x                      ; ...
    lda hero_y,x                        ; ...
    sta previous_y                      ; ...
    lda hero_offset_x,x                 ; ...
    sta previous_offset_x               ; ...
    lda hero_offset_y,x                 ; ...
    sta previous_offset_y               ; ...
    lda hero_step,x                     ; Part way through a step?
    beq check_magic_key                 ; No: read the keys
    jsr continue_hero_step              ; Yes: continue it...
    jmp erase_hero                      ; ...and redraw
; &6eba referenced 1 time by &6eb2
.check_magic_key
    cpx #2                              ; Heroes 0 and 1 check their magic key first
    bcs read_hero_keys                  ; ...
    jmp check_magic                     ; ...
; &6ec1 referenced 2 times by &6ebc, &76ab
.read_hero_keys
    lda hero_key_up,x                   ; Up key?
    jsr test_key                        ; ...
    bne check_key_down                  ; No
    lda #1                              ; Yes: face up...
    sta hero_direction,x                ; ...
    jsr start_hero_step                 ; ...start the step...
    jmp step_hero                       ; ...and move
; &6ed4 referenced 1 time by &6ec7
.check_key_down
    lda hero_key_down,x                 ; Down key?
    jsr test_key                        ; ...
    bne check_key_right                 ; No
    lda #5                              ; Yes: face down...
    sta hero_direction,x                ; ...
    jsr start_hero_step                 ; ...start the step...
    jmp step_hero                       ; ...and move
; &6ee7 referenced 1 time by &6eda
.check_key_right
    lda hero_key_right,x                ; Right key?
    jsr test_key                        ; ...
    bne check_key_left                  ; No
    lda #3                              ; Yes: face right...
    sta hero_direction,x                ; ...
    jsr start_hero_step                 ; ...start the step...
    jmp step_hero                       ; ...and move
; &6efa referenced 1 time by &6eed
.check_key_left
    lda hero_key_left,x                 ; Left key?
    jsr test_key                        ; ...
    bne check_key_fire                  ; No
    lda #7                              ; Yes: face left...
    sta hero_direction,x                ; ...
    jsr start_hero_step                 ; ...start the step...
    jmp step_hero                       ; ...and move
; &6f0d referenced 1 time by &6f00
.check_key_fire
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
.find_missile_slot
    lda missile_direction,y             ; Slot free?
    bne next_missile_slot               ; No: try the next
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
    nop                                 ; Padding where the cassette game sounds the bell (VDU 7)
    nop                                 ; ...
    nop                                 ; ...
    nop                                 ; ...
    nop                                 ; ...
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
.next_missile_slot
    iny                                 ; Next slot
    cpy scratch                         ; ...
    bne find_missile_slot               ; ...
    jmp draw_moved_hero                 ; All in flight: just redraw the hero
; &6f79 referenced 4 times by &6ed1, &6ee4, &6ef7, &6f0a
.step_hero
    lda hero_direction,x                ; Move the hero's cell in the direction faced: up...
    cmp #1                              ; ...
    bne step_right                      ; ...
    dec hero_y,x                        ; ...
; &6f83 referenced 1 time by &6f7e
.step_right
    cmp #3                              ; ...right...
    bne step_down                       ; ...
    inc hero_x,x                        ; ...
; &6f8a referenced 1 time by &6f85
.step_down
    cmp #5                              ; ...down...
    bne step_left                       ; ...
    inc hero_y,x                        ; ...
; &6f91 referenced 1 time by &6f8c
.step_left
    cmp #7                              ; ...left
    bne note_new_cell                   ; ...
    dec hero_x,x                        ; ...
; &6f98 referenced 1 time by &6f93
.note_new_cell
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
    beq check_monster_in_cell           ; No
    lda previous_x                      ; Yes: stay put...
    sta hero_x,x                        ; ...
    lda previous_y                      ; ...
    sta hero_y,x                        ; ...
; &6fc7 referenced 1 time by &7050
.cancel_hero_step
    lda #0                              ; Cancel the step
    sta hero_step,x                     ; ...
    sta hero_offset_x,x                 ; ...
    sta hero_offset_y,x                 ; ...
    jmp erase_hero                      ; ...and redraw
; &6fd5 referenced 1 time by &6fb9
.check_monster_in_cell
    lda #0                              ; Is there a monster in the new cell?
    sta scratch                         ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr find_creature                   ; ...
    pla                                 ; ...
    tax                                 ; ...
    cpy #0                              ; ...
    beq check_hero_in_cell              ; No
    lda previous_x                      ; Yes: stay put, cancel the step...
    sta hero_x,x                        ; ...
    lda previous_y                      ; ...
    sta hero_y,x                        ; ...
    lda #0                              ; ...
    sta hero_step,x                     ; ...
    sta hero_offset_x,x                 ; ...
    sta hero_offset_y,x                 ; ...
    jsr lose_health_point               ; ...and lose a health point for bumping into it
    jmp erase_hero                      ; Redraw
; &7002 referenced 1 time by &6fe3
.check_hero_in_cell
    stx scratch                         ; Is another hero in play in the new cell?
    ldy #0                              ; ...
; &7007 referenced 1 time by &703e
.check_other_hero
    cpy scratch                         ; Not this hero
    beq next_other_hero                 ; ...
    lda hero_x,y                        ; ...
    cmp cell_x                          ; ...
    bne next_other_hero                 ; ...
    lda hero_y,y                        ; ...
    cmp cell_y                          ; ...
    bne next_other_hero                 ; ...
    lda hero_direction,y                ; ...
    beq next_other_hero                 ; ...
    lda previous_x                      ; Yes: stay put, cancel the step and redraw
    sta hero_x,x                        ; ...
    lda previous_y                      ; ...
    sta hero_y,x                        ; ...
    lda #0                              ; ...
    sta hero_step,x                     ; ...
    sta hero_offset_x,x                 ; ...
    sta hero_offset_y,x                 ; ...
    jmp erase_hero                      ; ...
; &703b referenced 4 times by &700a, &7012, &701a, &701f
.next_other_hero
    iny                                 ; Next hero
    cpy #4                              ; ...
    bne check_other_hero                ; ...
    txa                                 ; Has the hero moved into another room?
    asl a                               ; ...
    tax                                 ; ...
    lda view_room,x                     ; ...
    cmp map_ptr                         ; ...
    beq check_boots                     ; No
    txa                                 ; Yes: change this hero's view to the new room...
    lsr a                               ; ...
    tax                                 ; ...
    jsr show_hero_room                  ; ...
    jmp cancel_hero_step                ; ...and cancel the step
; &7053 referenced 1 time by &7048
.check_boots
    txa                                 ; Same room. Wearing Boots of Speed?
    lsr a                               ; ...
    tax                                 ; ...
    lda hero_has_boots,x                ; ...
    beq stay_in_old_cell                ; No
    lda #0                              ; Yes: arrive in the cell at once, with no step
    sta hero_offset_x,x                 ; ...
    sta hero_offset_y,x                 ; ...
    sta hero_step,x                     ; ...
    jmp erase_hero                      ; ...
; &7069 referenced 1 time by &7059
.stay_in_old_cell
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
    sta plot_offset_x                   ; ...
    lda previous_offset_y               ; ...
    sta plot_offset_y                   ; ...
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
    beq return_5                        ; ...
    jmp move_hero                       ; ...
; &70c9 referenced 1 time by &70c4
.return_5
    rts                                 ; Return
; ***************************************************************************************
; Move the missiles
;
; Advance every missile in flight one cell. A missile stops at a wall, damages a monster
; or hero it meets, and bounces back off an energy drainer, wearing it down.
; &70ca referenced 1 time by &1ed1
.move_missiles
    lda #0                              ; No pixel offsets for missiles
    sta plot_offset_x                   ; ...
    sta plot_offset_y                   ; ...
    ldx #0                              ; For each of the twelve missile slots...
; &70d2 referenced 1 time by &721d
.move_missile
    lda missile_direction,x             ; In flight?
    bne check_just_fired                ; Yes
    jmp next_missile                    ; No: next slot
; &70da referenced 1 time by &70d5
.check_just_fired
    bpl erase_missile                   ; Just fired (bit 7 set)?
    and #&7f                            ; Yes: clear the flag...
    sta missile_direction,x             ; ...
    jsr flip_firer_frame                ; ...animate the hero who fired it...
    jmp missile_up                      ; ...and move it without erasing (it is on the hero)
; &70e7 referenced 1 time by &70da
.erase_missile
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
.missile_up
    lda missile_direction,x             ; Move it one cell: up...
    cmp #1                              ; ...
    bne missile_right                   ; ...
    dec missile_y,x                     ; ...
; &7108 referenced 1 time by &7103
.missile_right
    cmp #2                              ; ...right...
    bne missile_down                    ; ...
    inc missile_x,x                     ; ...
; &710f referenced 1 time by &710a
.missile_down
    cmp #3                              ; ...down...
    bne missile_left                    ; ...
    inc missile_y,x                     ; ...
; &7116 referenced 1 time by &7111
.missile_left
    cmp #4                              ; ...left
    bne check_missile_wall              ; ...
    dec missile_x,x                     ; ...
; &711d referenced 1 time by &7118
.check_missile_wall
    lda missile_x,x                     ; Wall in the new cell?
    sta cell_x                          ; ...
    lda missile_y,x                     ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr test_wall                       ; ...
    beq check_missile_monster           ; No
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
.check_missile_monster
    lda #0                              ; Monster in the new cell (not checking heroes)?
    sta scratch                         ; ...
    jsr find_creature                   ; ...
    beq check_missile_object            ; No
    lda monster_sprite,x                ; Yes, but is it alive?
    cmp #&16                            ; ...
    bcs check_missile_object            ; No: fly on
    pla                                 ; Alive: hit it
    tay                                 ; ...
    jmp monster_hit                     ; ...
; &7150 referenced 1 time by &75a3
.monster_killed
    jsr credit_missile_owner            ; Monster killed: a point to the hero who fired...
    jmp missile_spent                   ; ...and the missile is spent
; &7156 referenced 2 times by &7142, &7149
.check_missile_object
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
    bne check_missile_hero              ; No: check for heroes
    txa                                 ; Look for an energy drainer at the cell...
    pha                                 ; ...
    ldx #&1e                            ; ...objects 30 to 1
; &7173 referenced 1 time by &71d5
.check_object_drainer
    lda object_x,x                      ; ...
    cmp cell_x                          ; ...
    bne next_object_drainer             ; ...
    lda object_y,x                      ; ...
    cmp cell_y                          ; ...
    bne next_object_drainer             ; ...
    lda object_type,x                   ; Is it a drainer (&53-&5E)?
    cmp #&53 ; 'S'                      ; ...
    bcc no_drainer                      ; No
    cmp #&5f ; '_'                      ; ...
    bcs no_drainer                      ; No
    inc object_type,x                   ; Yes: wear it down a stage
    lda object_type,x                   ; ...
    cmp #&5f ; '_'                      ; Worn away?
    bne credit_drainer_hit              ; No
    lda #&ff                            ; Yes: remove it from the level
    sta object_x,x                      ; ...
    sta object_y,x                      ; ...
; &71a0 referenced 1 time by &7196
.credit_drainer_hit
    pla                                 ; A point to the hero who fired
    tax                                 ; ...
    jsr credit_missile_owner            ; ...
    lda missile_direction,x             ; Bounce the missile back: up becomes down...
    cmp #1                              ; ...
    bne reverse_right                   ; ...
    lda #3                              ; ...
    sta missile_direction,x             ; ...
    jmp check_missile_hero              ; ...
; &71b4 referenced 1 time by &71aa
.reverse_right
    cmp #2                              ; ...right becomes left...
    bne reverse_down                    ; ...
    lda #4                              ; ...
    sta missile_direction,x             ; ...
    jmp check_missile_hero              ; ...
; &71c0 referenced 1 time by &71b6
.reverse_down
    cmp #3                              ; ...down becomes up...
    bne reverse_left                    ; ...
    lda #1                              ; ...
    sta missile_direction,x             ; ...
    jmp check_missile_hero              ; ...
; &71cc referenced 1 time by &71c2
.reverse_left
    lda #2                              ; ...and left becomes right
    sta missile_direction,x             ; ...
    jmp check_missile_hero              ; ...
; &71d4 referenced 2 times by &7179, &7181
.next_object_drainer
    dex                                 ; Next object
    bne check_object_drainer            ; ...
; &71d7 referenced 2 times by &7188, &718c
.no_drainer
    pla                                 ; No drainer here
    tax                                 ; ...
; &71d9 referenced 5 times by &716d, &71b1, &71bd, &71c9, &71d1
.check_missile_hero
    txa                                 ; Is a hero in the new cell?
    pha                                 ; ...
    ldx #0                              ; ...
; &71dd referenced 1 time by &7204
.check_hero_hit
    pla                                 ; ...
    tay                                 ; ...
    pha                                 ; ...
    lda hero_x,x                        ; ...
    cmp cell_x                          ; ...
    bne next_hero_hit                   ; ...
    lda hero_y,x                        ; ...
    cmp cell_y                          ; ...
    bne next_hero_hit                   ; ...
    lda missile_damage,y                ; Yes: they lose the missile's damage in health...
    tay                                 ; ...
; &71f4 referenced 1 time by &71fc
.take_missile_damage
    tya                                 ; ...
    pha                                 ; ...
    jsr lose_health_point               ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    bne take_missile_damage             ; ...
    jmp missile_spent_pop               ; ...and the missile is spent
; &7201 referenced 2 times by &71e6, &71ee
.next_hero_hit
    inx                                 ; Next hero
    cpx #4                              ; ...
    bne check_hero_hit                  ; ...
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
    beq return_6                        ; ...
    jmp move_missile                    ; ...
; &7220 referenced 1 time by &721b
.return_6
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
; &7221 referenced 8 times by &0eff, &6ffc, &71f6, &749a, &7512, &7654, &772a, &79ac
.lose_health_point
    lda hero_direction,x                ; Is the hero in play?
    bne take_health_unit                ; Yes
    rts                                 ; No: return
; &7227 referenced 1 time by &7224
.take_health_unit
    dec hero_health_units,x             ; Take one from the units digit
    lda hero_health_units,x             ; ...
    cmp #&1d                            ; Below 0?
    bne draw_health                     ; No: redraw
    lda #&27                            ; Yes: units 9...
    sta hero_health_units,x             ; ...
    dec hero_health_tens,x              ; ...and take one from the tens
    lda hero_health_tens,x              ; ...
    cmp #&1d                            ; Below 0: the hero has died
    bne draw_health                     ; No: redraw
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
.find_queue_slot
    lda returning_hero_queue,y          ; ...
    bne next_queue_slot                 ; ...
    txa                                 ; ...
    clc                                 ; ...
    adc #1                              ; ...
    sta returning_hero_queue,y          ; ...
    rts                                 ; Return
; &7263 referenced 1 time by &7259
.next_queue_slot
    iny                                 ; ...
    bne find_queue_slot                 ; ...
; &7266 referenced 3 times by &722f, &723e, &73a2
.draw_health
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
    bne draw_score                      ; No: redraw
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
    bne draw_score                      ; No: redraw
    lda #&1e                            ; Yes: tens 0...
    sta hero_score_tens,x               ; ...
    inc hero_score_hundreds,x           ; ...and add one to the hundreds
    lda hero_score_hundreds,x           ; ...
    cmp #&28 ; '('                      ; Past 9?
    bne draw_score                      ; No: redraw
    lda #&1e                            ; Yes: hundreds 0...
    sta hero_score_hundreds,x           ; ...
    jsr add_thousand_points             ; ...and add a thousand
; &72bc referenced 3 times by &7294, &72a3, &72b2
.draw_score
    clc                                 ; Draw the score twelve rows below the health: thousands at column &45...
    lda hero_panel_y,x                  ; ...
    adc #&0c                            ; ...
    sta plot_y                          ; ...
    lda #&45 ; 'E'                      ; ...
    sta plot_x                          ; ...
    lda hero_score_thousands,x          ; ...
    sta sprite_number                   ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_sprite                     ; ...
    pla                                 ; ...
    tax                                 ; ...
    lda hero_score_hundreds,x           ; ...hundreds at &48...
    sta sprite_number                   ; ...
    lda #&48 ; 'H'                      ; ...
    sta plot_x                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_sprite                     ; ...
    pla                                 ; ...
    tax                                 ; ...
    lda hero_score_tens,x               ; ...tens at &4B...
    sta sprite_number                   ; ...
    lda #&4b ; 'K'                      ; ...
    sta plot_x                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_sprite                     ; ...
    pla                                 ; ...
    tax                                 ; ...
    lda hero_score_units,x              ; ...units at &4E
    sta sprite_number                   ; ...
    lda #&4e ; 'N'                      ; ...
    sta plot_x                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_sprite                     ; ...
    pla                                 ; ...
    tax                                 ; ...
    rts                                 ; Return
; ***************************************************************************************
; Draw the level's objects
;
; Plot each of objects 30 to 1 at its cell in every view that shows it, with no pixel
; offset.
;
; On Exit:
;     A: corrupted
;     X: 0
;     Y: corrupted
; &7305 referenced 1 time by &1ece
.draw_objects
    lda #0                              ; No pixel offsets
    sta plot_offset_x                   ; ...
    sta plot_offset_y                   ; ...
    ldx #&1e                            ; Objects 30 to 1: plot each at its cell
; &730d referenced 1 time by &7326
.draw_each_object
    lda object_x,x                      ; ...
    sta cell_x                          ; ...
    lda object_y,x                      ; ...
    sta cell_y                          ; ...
    lda object_type,x                   ; ...
    sta sprite_number                   ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_at_cell                    ; ...
    pla                                 ; ...
    tax                                 ; ...
    dex                                 ; ...
    bne draw_each_object                ; ...
    rts                                 ; Return
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
.check_object
    lda object_x,y                      ; ...
    cmp cell_x                          ; ...
    beq check_object_y                  ; ...
    jmp next_object                     ; ...
; &7342 referenced 1 time by &733d
.check_object_y
    lda object_y,y                      ; ...
    cmp cell_y                          ; ...
    beq object_found                    ; ...
    jmp next_object                     ; ...
; &734d referenced 1 time by &7348
.object_found
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
    bne check_food                      ; No
    txa                                 ; Yes: play the treasure sound
    pha                                 ; ...
    tya                                 ; ...
    pha                                 ; ...
    ldx #<(treasure_envelope)           ; ...
    ldy #>(treasure_envelope)           ; ...
    lda #osword_envelope                ; ...
    jsr osword                          ; ENVELOPE command
    ldx #<(treasure_sound)              ; ...
    ldy #>(treasure_sound)              ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; SOUND command
    pla                                 ; ...
    tay                                 ; ...
    pla                                 ; ...
    tax                                 ; ...
    tya                                 ; 20 points
    pha                                 ; ...
    jsr add_ten_points                  ; ...
    jsr add_ten_points                  ; ...
    pla                                 ; ...
    tay                                 ; ...
    jmp remove_object                   ; Remove it
; &738a referenced 1 time by &7361
.check_food
    cmp #&29 ; ')'                      ; Food?
    bne check_teleporter                ; No
    inc hero_health_tens,x              ; Yes: 10 health...
    lda hero_health_tens,x              ; ...
    cmp #&28 ; '('                      ; ...to at most 99
    bne redraw_health                   ; ...
    lda #&27                            ; ...
    sta hero_health_tens,x              ; ...
    sta hero_health_units,x             ; ...
; &73a0 referenced 1 time by &7396
.redraw_health
    tya                                 ; Redraw the health
    pha                                 ; ...
    jsr draw_health                     ; ...
    ldy #5                              ; 5 points
; &73a7 referenced 1 time by &73af
.redraw_health_loop
    tya                                 ; ...
    pha                                 ; ...
    jsr add_point                       ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    bne redraw_health_loop              ; ...
    txa                                 ; Play the food sound
    pha                                 ; ...
    ldx #<(food_sound)                  ; ...
    ldy #>(food_sound)                  ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; SOUND command
    pla                                 ; ...
    tax                                 ; ...
    pla                                 ; ...
    tay                                 ; ...
    jmp remove_object                   ; Remove it
; &73c3 referenced 1 time by &738c
.check_teleporter
    cmp #&2b ; '+'                      ; Teleporter?
    bne check_cross                     ; No
; &73c7 referenced 2 times by &73d1, &73d6
.find_previous_teleporter
    dey                                 ; Yes: find the previous teleporter in the list...
    lda object_type,y                   ; ...
    cmp #&2b ; '+'                      ; ...
    beq teleport                        ; ...
    cpy #0                              ; ...
    bne find_previous_teleporter        ; ...
    ldy teleport_last                   ; ...wrapping round to the end
    jmp find_previous_teleporter        ; ...
; &73d9 referenced 1 time by &73cd
.teleport
    txa                                 ; Play the teleport sound
    pha                                 ; ...
    tya                                 ; ...
    pha                                 ; ...
    ldx #<(teleport_sound)              ; ...
    ldy #>(teleport_sound)              ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; SOUND command
    pla                                 ; ...
    tay                                 ; ...
    pla                                 ; ...
    tax                                 ; ...
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
.check_cross
    cmp #&2a ; '*'                      ; Cross of Resurrection?
    bne check_magic_item                ; No
    lda #&ff                            ; Yes: remove it
    sta object_x,y                      ; ...
    sta object_y,y                      ; ...
    jsr add_ten_points                  ; 10 points
    txa                                 ; ...
    pha                                 ; ...
    jsr play_pickup_sound               ; Play the pickup sound
    lda returning_hero_queue            ; Anyone waiting to return?
    bne take_returning_hero             ; Yes
    pla                                 ; No: return
    tax                                 ; ...
    rts                                 ; ...
; &7429 referenced 1 time by &7424
.take_returning_hero
    ldy #0                              ; Take the first entry off the queue, appending 0...
; &742b referenced 1 time by &744a
.shift_returning_queue
    ldx returning_hero_queue            ; ...
    dex                                 ; ...
    lda returning_hero_queue + 1        ; ...
    sta returning_hero_queue            ; ...
    lda returning_hero_queue + 2        ; ...
    sta returning_hero_queue + 1        ; ...
    lda returning_hero_queue + 3        ; ...
    sta returning_hero_queue + 2        ; ...
    sty returning_hero_queue + 3        ; ...
    cpx #&63 ; 'c'                      ; A &64 marker?
    bne check_queue_empty               ; No
    ldy #&64 ; 'd'                      ; Yes: move it to the back and take the next entry
    bne shift_returning_queue           ; ...
; &744c referenced 1 time by &7446
.check_queue_empty
    cpx #&ff                            ; Queue empty?
    beq cross_done                      ; Yes: nobody returns
    lda #0                              ; Start hero X returning: out of play...
    sta hero_direction,x                ; ...
    lda #8                              ; ...from the last appearance sprite...
    sta hero_frame,x                    ; ...
    lda #&ff                            ; ...stepping backwards...
    sta hero_offset_x,x                 ; ...
    lda #1                              ; ...every other frame
    sta hero_offset_y,x                 ; ...
; &7464 referenced 1 time by &744e
.cross_done
    pla                                 ; Return
    tax                                 ; ...
    rts                                 ; ...
; &7467 referenced 2 times by &7387, &73c0
.remove_object
    lda #&ff                            ; Remove object Y from the level
    sta object_x,y                      ; ...
    sta object_y,y                      ; ...
    rts                                 ; Return
; &7470 referenced 3 times by &733f, &734a, &747d
.next_object
    dey                                 ; Next object
    beq return_7                        ; ...
    jmp check_object                    ; ...
; &7476 referenced 1 time by &7471
.return_7
    rts                                 ; Return
; &7477 referenced 1 time by &740f
.check_magic_item
    cmp #&5f ; '_'                      ; One of the magic items (&5F and up)?
    bcs magic_item                      ; Yes
    cmp #&51 ; 'Q'                      ; The exit? Nothing to do here
    beq next_object                     ; ...
    lda #&32 ; '2'                      ; An energy drainer: play the hit sound louder...
    sta hit_sound + 4                   ; ...
    txa                                 ; ...
    pha                                 ; ...
    ldx #<(hit_sound)                   ; ...
    ldy #>(hit_sound)                   ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; ...  SOUND command
    lda #6                              ; ...then put the volume back
    sta hit_sound + 4                   ; ...
    pla                                 ; ...
    tax                                 ; ...
    ldy #&0a                            ; ...and take 10 health
; &7498 referenced 1 time by &74a0
.take_ten_health
    tya                                 ; ...
    pha                                 ; ...
    jsr lose_health_point               ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    bne take_ten_health                 ; ...
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
.magic_item
    sta scratch                         ; A magic item: keep its type
    lda #&ff                            ; Remove it from the level
    sta object_x,y                      ; ...
    sta object_y,y                      ; ...
    txa                                 ; Play the pickup sound
    pha                                 ; ...
    lda scratch                         ; ...
    and #7                              ; ...
    asl a                               ; ...
    asl a                               ; ...
    jsr play_pickup_sound               ; ...
    pla                                 ; ...
    tax                                 ; ...
    lda hero_score_units,x              ; Keep the score's units digit, for a potion
    sta scratch2                        ; ...
    jsr add_ten_points                  ; 10 points
    lda scratch                         ; Boots of Speed?
    cmp #&5f ; '_'                      ; ...
    bne check_helmet                    ; No
    jsr point_at_boots_icon             ; Yes: show the bolt in the panel...
    jsr plot_boots_icon                 ; ...
    lda #1                              ; ...and wear them
    sta hero_has_boots,x                ; ...
    rts                                 ; Return
; &74eb referenced 1 time by &74dd
.check_helmet
    cmp #&60 ; '`'                      ; Magic helmet?
    bne check_potion                    ; No
    dec hero_damage_taken,x             ; Yes: lose one less health per hit...
    lda hero_damage_taken,x             ; ...
    cmp #3                              ; ...but never fewer than 3
    bcs redraw_armour                   ; ...
    inc hero_damage_taken,x             ; ...
; &74fc referenced 1 time by &74f7
.redraw_armour
    jmp draw_armour_rating              ; Redraw the armour rating
; &74ff referenced 1 time by &74ed
.check_potion
    cmp #&61 ; 'a'                      ; Potion of healing?
    bne check_weapons                   ; No
    lda scratch2                        ; Yes: health tens = the score's units digit...
    sta hero_health_tens,x              ; ...
    inc scratch2                        ; ...units one more, then take a point to draw it
    lda scratch2                        ; ...
    sta hero_health_units,x             ; ...
    jsr lose_health_point               ; ...
    rts                                 ; Return
; &7516 referenced 1 time by &7501
.check_weapons
    cmp #&62 ; 'b'                      ; Pile of weapons?
    bne magic_sword                     ; No: a magic sword
    inc hero_max_missiles,x             ; Yes: one more missile in flight...
    lda hero_max_missiles,x             ; ...
    cmp #4                              ; ...to at most 3
    bne draw_missile_icon               ; ...
    lda #3                              ; ...
    sta hero_max_missiles,x             ; ...
; &7529 referenced 1 time by &7522
.draw_missile_icon
    jmp draw_new_missile_icon           ; Draw the new missile icon
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
    sta cell_x                          ; ...
    lda hero_y,x                        ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr test_wall                       ; ...
    pla                                 ; ...
    tax                                 ; ...
    pha                                 ; Keep X
    asl a                               ; view_room entry for this hero...
    tay                                 ; ...
    lda map_ptr                         ; ...
    sta view_room,y                     ; ...now this room
    cpx #0                              ; Redraw this hero's view
    bne check_view_1                    ; Top-left view?
    jsr draw_view_0                     ; Yes: draw it
    pla                                 ; ...
    tax                                 ; ...
    rts                                 ; Return
; &7551 referenced 1 time by &7549
.check_view_1
    cpx #1                              ; Top-right view?
    bne check_view_2                    ; ...
    jsr draw_view_1                     ; Yes: draw it
    pla                                 ; ...
    tax                                 ; ...
    rts                                 ; Return
; &755b referenced 1 time by &7553
.check_view_2
    cpx #2                              ; Bottom-left view?
    bne show_view_3                     ; ...
    jsr draw_view_2                     ; Yes: draw it
    pla                                 ; ...
    tax                                 ; ...
    rts                                 ; Return
; &7565 referenced 1 time by &755d
.show_view_3
    jsr draw_view_3                     ; Otherwise the bottom-right view
    pla                                 ; ...
    tax                                 ; ...
    rts                                 ; Return
; &756b referenced 1 time by &7518
.magic_sword
    inc hero_missile_damage,x           ; A magic sword: more missile damage...
    lda hero_missile_damage,x           ; ...
    cmp #&0a                            ; ...to at most 9
    bne draw_missile_damage             ; ...
    lda #9                              ; ...
    sta hero_missile_damage,x           ; ...
    bne draw_missile_damage             ; ...
; &757c referenced 1 time by &714d
.monster_hit
    txa                                 ; Play the hit sound
    pha                                 ; ...
    tya                                 ; ...
    pha                                 ; ...
    ldx #<(hit_sound)                   ; ...
    ldy #>(hit_sound)                   ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; SOUND command
    pla                                 ; ...
    tay                                 ; ...
    pla                                 ; ...
    tax                                 ; ...
    lda monster_hit_points,x            ; Take the missile's damage from the monster's hit points
    sec                                 ; ...
    sbc missile_damage,y                ; ...
    bpl store_monster_health            ; Still alive?
    lda #&15                            ; No: start it dying...
    sta monster_sprite,x                ; ...
    lda monster_start_hit_points        ; ...and give the slot fresh hit points for its next appearance
    sta monster_hit_points,x            ; ...
    tya                                 ; Missile slot back in X...
    tax                                 ; ...
    jmp monster_killed                  ; ...a point to its hero, and the missile is spent
; &75a6 referenced 1 time by &7594
.store_monster_health
    sta monster_hit_points,x            ; Alive: store the hit points left
    tya                                 ; ...
    pha                                 ; ...
    jmp missile_spent_pop               ; The missile is spent
; &75ae referenced 1 time by &74fc
.draw_armour_rating
    sec                                 ; Armour rating: 10 - health lost per hit, as a small digit on the shield...
    lda hero_panel_y,x                  ; ...
    sbc #&0c                            ; ...
    sta plot_y                          ; ...
    lda #&4e ; 'N'                      ; ...
    sta plot_x                          ; ...
    lda #&73 ; 's'                      ; ...
    sec                                 ; ...
    sbc hero_damage_taken,x             ; ...
    sta sprite_number                   ; ...
    jmp plot_keeping_x                  ; ...plotted
; &75c5 referenced 1 time by &7529
.draw_new_missile_icon
    lda hero_max_missiles,x             ; The newest missile icon: row = 3 x missiles allowed...
    asl a                               ; ...
    clc                                 ; ...
    adc hero_max_missiles,x             ; ...
    adc #&0d                            ; ...
    adc hero_panel_y,x                  ; ...
    sec                                 ; ...
    sbc #&0e                            ; ...
    sta plot_y                          ; ...
    lda #&4b ; 'K'                      ; ...column &4B...
    sta plot_x                          ; ...
    lda #&74 ; 't'                      ; ...missile icon...
    sta sprite_number                   ; ...
    jmp plot_keeping_x                  ; ...plotted
; &75e2 referenced 2 times by &7573, &757a
.draw_missile_damage
    lda #&4c ; 'L'                      ; Missile damage: column &4C...
    sta plot_x                          ; ...
    sec                                 ; ...
    lda hero_panel_y,x                  ; ...
    sbc #4                              ; ...
    sta plot_y                          ; ...
    lda hero_missile_damage,x           ; ...as a small digit...
    clc                                 ; ...
    adc #&69 ; 'i'                      ; ...
    sta sprite_number                   ; ...
    jmp plot_keeping_x                  ; ...plotted
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
    lda #&4a ; 'J'                      ; Column &4A...
    sta plot_x                          ; ...
    sec                                 ; ...row 8 above the section's top
    lda hero_panel_y,x                  ; ...
    sbc #8                              ; ...
    sta plot_y                          ; ...
    rts                                 ; Return
; ***************************************************************************************
; Show a hero's boots icon
;
; Plot the lightning bolt at plot_x, plot_y.
;
; On Exit:
;     X: preserved
; &7606 referenced 1 time by &74e2
.plot_boots_icon
    lda #&75 ; 'u'                      ; Lightning bolt...
    sta sprite_number                   ; ...
    jmp plot_keeping_x                  ; ...plotted
; ***************************************************************************************
; Remove a hero's boots icon
;
; Plot the blank sprite over the lightning bolt at plot_x, plot_y.
;
; On Exit:
;     X: preserved
; &760d referenced 1 time by &7357
.erase_boots_icon
    lda #&77 ; 'w'                      ; Blank...
    sta sprite_number                   ; ...
; &7611 referenced 4 times by &75c2, &75df, &75f6, &760a
.plot_keeping_x
    txa                                 ; Plot, preserving X
    pha                                 ; ...
    jsr plot_sprite                     ; ...
    pla                                 ; ...
    tax                                 ; ...
    rts                                 ; Return
; &7619 referenced 1 time by &6ebe
.check_magic
    dec hero_magic_delay,x              ; Count down the magic key delay
    beq check_magic_every_frame         ; ...
    rts                                 ; Not yet: return, which leaves move_heroes for this frame
; &761f referenced 1 time by &761c
.check_magic_every_frame
    lda #1                              ; Check the key every frame from now on
    sta hero_magic_delay,x              ; ...
    lda hero_magic_key,x                ; Magic key pressed?
    jsr test_key                        ; ...
    bne no_magic                        ; No: carry on reading the keys
    txa                                 ; Yes: play the magic sound
    pha                                 ; ...
    ldx #<(magic_envelope)              ; ...
    ldy #>(magic_envelope)              ; ...
    lda #osword_envelope                ; ...
    jsr osword                          ; ENVELOPE command
    ldx #<(magic_sound)                 ; ...
    ldy #>(magic_sound)                 ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; SOUND command
    pla                                 ; ...
    tax                                 ; ...
    lda #4                              ; Ignore the key for the next three frames
    sta hero_magic_delay,x              ; ...
    cpx #1                              ; Health cost: 3 for the Magic-User...
    beq magic_user_cost                 ; ...
    ldy #6                              ; ...6 for the Ranger
    jmp take_magic_cost                 ; ...
; &7650 referenced 1 time by &7649
.magic_user_cost
    ldy #3                              ; ...
; &7652 referenced 2 times by &764d, &765a
.take_magic_cost
    tya                                 ; Take the cost
    pha                                 ; ...
    jsr lose_health_point               ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    bne take_magic_cost                 ; ...
    lda #0                              ; No monsters killed yet
    sta magic_kill_count                ; ...
    txa                                 ; sprite_number = 2 x hero, an index into view_room
    asl a                               ; ...
    sta sprite_number                   ; ...
    ldx #&1e                            ; For each monster...
; &7667 referenced 1 time by &7693
.find_monster_room
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
    cmp map_ptr                         ; ...
    bne next_monster_magic              ; No
    lda monster_sprite,x                ; Alive?
    cmp #&15                            ; ...
    bcs next_monster_magic              ; No
    lda #&15                            ; Yes: start it dying...
    sta monster_sprite,x                ; ...
    inc magic_kill_count                ; ...and count it
; &7692 referenced 2 times by &7681, &7688
.next_monster_magic
    dex                                 ; Next monster
    bne find_monster_room               ; ...
    lda sprite_number                   ; One point for each monster killed
    lsr a                               ; ...
    tax                                 ; ...
    ldy magic_kill_count                ; ...
; &769c referenced 1 time by &76a8
.check_kills
    cpy #0                              ; ...
    beq magic_cast                      ; ...
    tya                                 ; ...
    pha                                 ; ...
    jsr add_point                       ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    jmp check_kills                     ; ...
; &76ab referenced 1 time by &762a
.no_magic
    jmp read_hero_keys                  ; No magic: carry on with the keys
; &76ae referenced 1 time by &769e
.magic_cast
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
    bne owner_fireball                  ; ...
    ldx #0                              ; ...
    jmp credit_owner                    ; ...
; &76c0 referenced 1 time by &76b9
.owner_fireball
    cmp #&44 ; 'D'                      ; Fireballs: the Magic-User
    bne owner_axe                       ; ...
    ldx #1                              ; ...
    jmp credit_owner                    ; ...
; &76c9 referenced 1 time by &76c2
.owner_axe
    cmp #&4c ; 'L'                      ; Axes: the Barbarian
    bne owner_sword                     ; ...
    ldx #2                              ; ...
    jmp credit_owner                    ; ...
; &76d2 referenced 1 time by &76cb
.owner_sword
    ldx #3                              ; Otherwise swords: the Fighter
; &76d4 referenced 3 times by &76bd, &76c6, &76cf
.credit_owner
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
    beq absent_frame_due                ; ...
    rts                                 ; ...
; &76e0 referenced 1 time by &76dd
.absent_frame_due
    lda #2                              ; ...
    sta hero_offset_y,x                 ; ...
    jsr get_hero_cell                   ; Plot the current appearance sprite at the hero's cell
    lda #0                              ; ...
    sta plot_offset_x                   ; ...
    sta plot_offset_y                   ; ...
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
    bcc check_first_sprite              ; ...
    lda #8                              ; ...
; &770b referenced 1 time by &7707
.check_first_sprite
    cmp #0                              ; Reached the first sprite (returning)?
    bne store_hero_frame                ; No
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
.store_hero_frame
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
    sta plot_offset_x                   ; ...
    lda hero_offset_y,x                 ; ...
    sta plot_offset_y                   ; ...
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
    bne firer_fireball                  ; ...
    lda hero_frame                      ; ...
    eor #1                              ; ...
    sta hero_frame                      ; ...
    rts                                 ; Return
; &7757 referenced 1 time by &774c
.firer_fireball
    cmp #&44 ; 'D'                      ; Fireballs: the Magic-User's
    bne firer_axe                       ; ...
    lda hero_frame + 1                  ; ...
    eor #1                              ; ...
    sta hero_frame + 1                  ; ...
    rts                                 ; Return
; &7764 referenced 1 time by &7759
.firer_axe
    cmp #&4c ; 'L'                      ; Axes: the Barbarian's
    bne firer_sword                     ; ...
    lda hero_frame + 2                  ; ...
    eor #1                              ; ...
    sta hero_frame + 2                  ; ...
    rts                                 ; Return
; &7771 referenced 1 time by &7766
.firer_sword
    lda hero_frame + 3                  ; Otherwise swords: the Fighter's
    eor #1                              ; ...
    sta hero_frame + 3                  ; ...
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
; &7788 referenced 1 time by &1563
.draw_all_views
    jsr draw_view_0                     ; Top-left view
    jsr draw_view_1                     ; Top-right view
    jsr draw_view_2                     ; Bottom-left view
    jsr draw_view_3                     ; Bottom-right view
    rts                                 ; Return
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
    sta map_ptr                         ; ...
    jsr draw_room                       ; Draw it
    rts                                 ; Return
; ***************************************************************************************
; Draw the top-right view
;
; Draw the room in hero 1's view.
; &77a7 referenced 2 times by &7555, &778b
.draw_view_1
    lda #1                              ; Top-right view: row 1...
    sta plot_y                          ; ...
    lda #&23 ; '#'                      ; ...column &23...
    sta cell_x                          ; ...
    lda view_room + 2                   ; ...hero 1's room
    sta map_ptr                         ; ...
    jsr draw_room                       ; Draw it
    rts                                 ; Return
; ***************************************************************************************
; Draw the bottom-left view
;
; Draw the room in hero 2's view.
; &77b9 referenced 2 times by &755f, &778e
.draw_view_2
    lda #&67 ; 'g'                      ; Bottom-left view: row &67...
    sta plot_y                          ; ...
    lda #1                              ; ...column 1...
    sta cell_x                          ; ...
    lda view_room + 4                   ; ...hero 2's room
    sta map_ptr                         ; ...
    jsr draw_room                       ; Draw it
    rts                                 ; Return
; ***************************************************************************************
; Draw the bottom-right view
;
; Draw the room in hero 3's view.
; &77cb referenced 2 times by &7565, &7791
.draw_view_3
    lda #&67 ; 'g'                      ; Bottom-right view: row &67...
    sta plot_y                          ; ...
    lda #&23 ; '#'                      ; ...column &23...
    sta cell_x                          ; ...
    lda view_room + 6                   ; ...hero 3's room
    sta map_ptr                         ; ...
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
    sta map_ptr_hi                      ; ...
    ldy #0                              ; For each of the eight rows...
; &77e4 referenced 1 time by &77fa
.draw_room_walls
    lda (map_ptr),y                     ; ...take its eight wall bits...
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
    bne draw_room_walls                 ; ...
    ldx #&14                            ; Then the doors 20 to 1, in every view showing them
; &77fe referenced 1 time by &781d
.draw_room_doors
    lda door_x,x                        ; ...
    sta cell_x                          ; ...
    lda door_y,x                        ; ...
    sta cell_y                          ; ...
    lda #0                              ; ...
    sta plot_offset_x                   ; ...
    sta plot_offset_y                   ; ...
    lda door_sprite,x                   ; ...
    sta sprite_number                   ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_at_cell                    ; ...
    pla                                 ; ...
    tax                                 ; ...
    dex                                 ; ...
    bne draw_room_doors                 ; ...
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
.draw_room_cell
    txa                                 ; ...
    pha                                 ; ...
    sta scratch2                        ; ...
    lda scratch                         ; Wall here?
    and scratch2                        ; ...
    beq plot_blank                      ; No: plot the blank
    lda #0                              ; Yes: plot the wall block (sprite 0)
    sta sprite_number                   ; ...
    jsr plot_sprite                     ; ...
    jmp next_room_cell                  ; ...
; &783e referenced 1 time by &7832
.plot_blank
    lda #&15                            ; Plot the blank (sprite &15)
    sta sprite_number                   ; ...
    jsr plot_sprite                     ; ...
; &7845 referenced 1 time by &783b
.next_room_cell
    clc                                 ; Four byte columns right
    lda plot_x                          ; ...
    adc #4                              ; ...
    sta plot_x                          ; ...
    pla                                 ; Next bit...
    lsr a                               ; ...
    tax                                 ; ...
    bne draw_room_cell                  ; ...until all eight are done
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
    adc plot_offset_x                   ; ...
    sta cell_x                          ; ...
    lda cell_y                          ; Row within the view = (cell_y AND 7) x 12 + offset_y
    and #7                              ; ...
    asl a                               ; ...
    asl a                               ; ...
    sta scratch                         ; ...
    asl a                               ; ...
    clc                                 ; ...
    adc scratch                         ; ...
    adc plot_offset_y                   ; ...
    sta cell_y                          ; ...
    lda view_room                       ; Does the top-left view show this room?
    cmp cell_room                       ; ...
    bne check_view_1_room               ; No
    clc                                 ; Yes: plot at column 1, row 1 of the screen, plus the position in the room
    lda #1                              ; ...
    adc cell_x                          ; ...
    sta plot_x                          ; ...
    lda #1                              ; ...
    adc cell_y                          ; ...
    sta plot_y                          ; ...
    jsr plot_sprite                     ; ...
; &78ad referenced 1 time by &7899
.check_view_1_room
    lda view_room + 2                   ; Does the top-right view show it?
    cmp cell_room                       ; ...
    bne check_view_2_room               ; No
    clc                                 ; Yes: plot at column &23, row 1
    lda #&23 ; '#'                      ; ...
    adc cell_x                          ; ...
    sta plot_x                          ; ...
    lda #1                              ; ...
    adc cell_y                          ; ...
    sta plot_y                          ; ...
    jsr plot_sprite                     ; ...
; &78c7 referenced 1 time by &78b3
.check_view_2_room
    lda view_room + 4                   ; Does the bottom-left view show it?
    cmp cell_room                       ; ...
    bne check_view_3_room               ; No
    clc                                 ; Yes: plot at column 1, row &67
    lda #1                              ; ...
    adc cell_x                          ; ...
    sta plot_x                          ; ...
    lda #&67 ; 'g'                      ; ...
    adc cell_y                          ; ...
    sta plot_y                          ; ...
    jsr plot_sprite                     ; ...
; &78e1 referenced 1 time by &78cd
.check_view_3_room
    lda view_room + 6                   ; Does the bottom-right view show it?
    cmp cell_room                       ; ...
    bne return_8                        ; No
    clc                                 ; Yes: plot at column &23, row &67
    lda #&23 ; '#'                      ; ...
    adc cell_x                          ; ...
    sta plot_x                          ; ...
    lda #&67 ; 'g'                      ; ...
    adc cell_y                          ; ...
    sta plot_y                          ; ...
    jsr plot_sprite                     ; ...
; &78fb referenced 1 time by &78e7
.return_8
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
    and #&f8                            ; ...
    sta scratch                         ; ...
    clc                                 ; ...
    adc scratch                         ; ...
    adc scratch                         ; ...
    adc scratch                         ; ...
    sta map_ptr                         ; ...low byte of the pointer
    lda cell_x                          ; ...
    and #&f8                            ; ...
    adc map_ptr                         ; ...
    sta map_ptr                         ; ...
    lda #&0c                            ; ...into room_walls at &0C00
    sta map_ptr_hi                      ; ...
    lda cell_x                          ; Bit for the column within the room
    and #7                              ; ...
    tax                                 ; ...
    lda bit_masks,x                     ; ...
    sta scratch                         ; ...
    lda cell_y                          ; Byte for the row within the room
    and #7                              ; ...
    tay                                 ; ...
    lda (map_ptr),y                     ; Isolate the cell's bit...
    and scratch                         ; ...
    sta victory_pitch                   ; ...keep it in &8F...
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
    and #&f8                            ; ...
    sta scratch                         ; ...
    clc                                 ; ...
    adc scratch                         ; ...
    adc scratch                         ; ...
    adc scratch                         ; ...
    sta map_ptr                         ; ...low byte of the pointer
    lda cell_x                          ; ...
    and #&f8                            ; ...
    adc map_ptr                         ; ...
    sta map_ptr                         ; ...
    lda #&21 ; '!'                      ; ...into object_free_map at &2100
    sta map_ptr_hi                      ; ...
    lda cell_x                          ; Bit for the column within the room
    and #7                              ; ...
    tax                                 ; ...
    lda bit_masks,x                     ; ...
    sta scratch                         ; ...
    lda cell_y                          ; Byte for the row within the room
    and #7                              ; ...
    tay                                 ; ...
    lda (map_ptr),y                     ; Isolate the cell's bit...
    and scratch                         ; ...
    sta victory_pitch                   ; ...keep it in &8F...
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
.check_monster
    cpx scratch                         ; ...except the one being moved
    beq next_monster_find               ; ...
    lda cell_x                          ; At cell_x...
    cmp monster_x,x                     ; ...
    bne next_monster_find               ; ...
    lda cell_y                          ; ...and cell_y?
    cmp monster_y,x                     ; ...
    bne next_monster_find               ; ...
    tay                                 ; Yes: return with Y and A non-zero
    rts                                 ; ...
; &798d referenced 3 times by &7979, &7981, &7989
.next_monster_find
    dex                                 ; Next monster
    bne check_monster                   ; ...
    lda scratch                         ; No monster. Check for heroes too?
    beq nothing_found                   ; No: return 0
    ldx #0                              ; For each hero...
; &7997 referenced 1 time by &79ba
.check_hero
    lda cell_x                          ; ...at cell_x...
    cmp hero_x,x                        ; ...
    bne next_hero_find                  ; ...
    lda cell_y                          ; ...and cell_y?
    cmp hero_y,x                        ; ...
    bne next_hero_find                  ; ...
    ldy hero_damage_taken,x             ; Yes: take hero_damage_taken health points
; &79aa referenced 1 time by &79b2
.check_hero_loop
    tya                                 ; ...
    pha                                 ; ...
    jsr lose_health_point               ; ...
    pla                                 ; ...
    tay                                 ; ...
    dey                                 ; ...
    bne check_hero_loop                 ; ...
    lda #1                              ; Return A = 1: a hero was there
    rts                                 ; ...
; &79b7 referenced 2 times by &799d, &79a5
.next_hero_find
    inx                                 ; Next hero
    cpx #4                              ; ...
    bne check_hero                      ; ...
; &79bc referenced 1 time by &7993
.nothing_found
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
    ldx #8                              ; Draw the eight trapdoors (sprite &2C)...
    lda #0                              ; ...
    sta plot_offset_x                   ; ...
    sta plot_offset_y                   ; ...
    lda #&2c ; ','                      ; ...
    sta sprite_number                   ; ...
; &79cd referenced 1 time by &79e1
.check_trapdoor
    lda trapdoor_x - 1,x                ; ...
    sta cell_x                          ; ...
    lda trapdoor_y - 1,x                ; ...
    sta cell_y                          ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_at_cell                    ; ...
    pla                                 ; ...
    tax                                 ; ...
    dex                                 ; ...
    bne check_trapdoor                  ; ...
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
    sta plot_offset_x                   ; ...
    lda monster_offset_y,x              ; ...
    sta plot_offset_y                   ; ...
    jsr plot_at_cell                    ; ...
    pla                                 ; ...
    pha                                 ; ...
    tax                                 ; ...
    lda monster_sprite,x                ; Dying?
    cmp #&15                            ; ...
    bcc check_monster_step              ; No
    jmp advance_dying_monster           ; Yes: advance the death animation
; &7a17 referenced 1 time by &7a12
.check_monster_step
    lda monster_step,x                  ; Part way through a step?
    beq start_monster_move              ; No
    jsr continue_monster_step           ; Yes: continue it and draw
    pla                                 ; ...
    jmp draw_monster                    ; ...
; &7a23 referenced 1 time by &7a1a
.start_monster_move
    lda monster_sprite,x                ; Start a step: move the cell in the direction it faces, up...
    cmp #9                              ; ...
    bne monster_right                   ; ...
    dec monster_y,x                     ; ...
; &7a2d referenced 1 time by &7a28
.monster_right
    cmp #&0b                            ; ...right...
    bne monster_down                    ; ...
    inc monster_x,x                     ; ...
; &7a34 referenced 1 time by &7a2f
.monster_down
    cmp #&0d                            ; ...down...
    bne monster_left                    ; ...
    inc monster_y,x                     ; ...
; &7a3b referenced 1 time by &7a36
.monster_left
    cmp #&0f                            ; ...left
    bne set_monster_step                ; ...
    dec monster_x,x                     ; ...
; &7a42 referenced 1 time by &7a3d
.set_monster_step
    jsr start_monster_step              ; Set the step's offsets
    lda monster_x,x                     ; Wall in the new cell?
    sta cell_x                          ; ...
    lda monster_y,x                     ; ...
    sta cell_y                          ; ...
    jsr test_wall                       ; ...
    beq check_monster_blocked           ; No
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
    beq turn_monster                    ; ...
    jmp draw_monster                    ; ...
; &7a81 referenced 1 time by &7a7c
.turn_monster
    inc monster_sprite,x                ; ...
    jmp draw_monster                    ; ...
; &7a87 referenced 1 time by &7a54
.check_monster_blocked
    pla                                 ; Is another monster, or a hero, in the new cell? (A hero there is hurt)
    pha                                 ; ...
    sta scratch                         ; ...
    jsr find_creature                   ; ...
    cmp #0                              ; ...
    beq monster_vertical                ; No
    pla                                 ; Yes: stay put, with no step, and turn a random way
    tax                                 ; Stay in the old cell...
    lda previous_x                      ; ...
    sta monster_x,x                     ; ...
    lda previous_y                      ; ...
    sta monster_y,x                     ; ...
    lda #0                              ; ...with no step...
    sta monster_step,x                  ; ...
    sta monster_offset_x,x              ; ...
    sta monster_offset_y,x              ; ...
    lda system_via_t1c_l                ; ...and turn a random way: 8 + (timer AND 7), made odd
    and #7                              ; ...
    clc                                 ; ...
    adc #8                              ; ...
    sta monster_sprite,x                ; ...
    and #1                              ; ...
    bne draw_monster                    ; ...
    inc monster_sprite,x                ; ...
    jmp draw_monster                    ; ...
; &7ac1 referenced 1 time by &7a91
.monster_vertical
    pla                                 ; Moving vertically...
    tax                                 ; ...
    lda monster_sprite,x                ; ...
    cmp #9                              ; ...
    beq check_room_edge                 ; ...
    cmp #&0d                            ; ...
    beq check_room_edge                 ; ...
    lda monster_x,x                     ; No: at the left or right edge of a room?
    and #7                              ; ...
    beq monster_at_edge                 ; ...
    cmp #7                              ; ...
    beq monster_at_edge                 ; ...
    jmp monster_move_on                 ; No: move on
; &7adc referenced 2 times by &7ac8, &7acc
.check_room_edge
    lda monster_y,x                     ; Yes: at the top or bottom edge of a room?
    and #7                              ; ...
    beq monster_at_edge                 ; ...
    cmp #7                              ; ...
    beq monster_at_edge                 ; ...
    jmp monster_move_on                 ; No: move on
; &7aea referenced 4 times by &7ad3, &7ad7, &7ae1, &7ae5
.monster_at_edge
    lda #0                              ; At a room edge: cancel the step, so it arrives at once
    sta monster_step,x                  ; ...
    sta monster_offset_x,x              ; ...
    sta monster_offset_y,x              ; ...
    jmp draw_monster                    ; ...
; &7af8 referenced 2 times by &7ad9, &7ae7
.monster_move_on
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
    sta plot_offset_x                   ; ...
    lda monster_offset_y,x              ; ...
    sta plot_offset_y                   ; ...
    txa                                 ; ...
    pha                                 ; ...
    jsr plot_at_cell                    ; ...
; &7b28 referenced 3 times by &7b5f, &7cf8, &7cfb
.monster_done
    pla                                 ; ...
    tax                                 ; ...
    dex                                 ; Next monster
    beq return_9                        ; ...
    jmp next_monster_update             ; ...
; &7b30 referenced 1 time by &7b2b
.return_9
    rts                                 ; Return
; &7b31 referenced 1 time by &7a14
.advance_dying_monster
    pla                                 ; ...
    inc monster_sprite,x                ; Next death frame
    lda monster_sprite,x                ; ...
    cmp #&1a                            ; Animation over?
    bne draw_monster_death              ; No
    jmp monster_reappears               ; Yes: bring it back at a trapdoor
; &7b3f referenced 1 time by &7b3a
.draw_monster_death
    txa                                 ; Draw the death frame
    pha                                 ; ...
    lda monster_x,x                     ; ...
    sta cell_x                          ; ...
    lda monster_y,x                     ; ...
    sta cell_y                          ; ...
    lda monster_sprite,x                ; ...
    sta sprite_number                   ; ...
    lda monster_offset_x,x              ; ...
    sta plot_offset_x                   ; ...
    lda monster_offset_y,x              ; ...
    sta plot_offset_y                   ; ...
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
    bne hero_step_right                 ; ...
    lda #0                              ; ...
    sta hero_offset_x,x                 ; ...
    lda #&fa                            ; ...
    sta hero_offset_y,x                 ; ...
    rts                                 ; Return
; &7b79 referenced 1 time by &7b6c
.hero_step_right
    cmp #3                              ; Facing right: 2 columns right
    bne hero_step_down                  ; ...
    lda #0                              ; ...
    sta hero_offset_y,x                 ; ...
    lda #2                              ; ...
    sta hero_offset_x,x                 ; ...
    rts                                 ; Return
; &7b88 referenced 1 time by &7b7b
.hero_step_down
    cmp #5                              ; Facing down: 6 rows down
    bne hero_step_left                  ; ...
    lda #0                              ; ...
    sta hero_offset_x,x                 ; ...
    lda #6                              ; ...
    sta hero_offset_y,x                 ; ...
    rts                                 ; Return
; &7b97 referenced 1 time by &7b8a
.hero_step_left
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
    bne double_offsets                  ; Not over
    lda hero_direction,x                ; Over: move the cell on in the direction faced, up...
    cmp #1                              ; ...
    bne continue_right                  ; ...
    dec hero_y,x                        ; ...
; &7bb9 referenced 1 time by &7bb4
.continue_right
    cmp #3                              ; ...right...
    bne continue_down                   ; ...
    inc hero_x,x                        ; ...
; &7bc0 referenced 1 time by &7bbb
.continue_down
    cmp #5                              ; ...down...
    bne continue_left                   ; ...
    inc hero_y,x                        ; ...
; &7bc7 referenced 1 time by &7bc2
.continue_left
    cmp #7                              ; ...left
    bne hero_no_offsets                 ; ...
    dec hero_x,x                        ; ...
; &7bce referenced 1 time by &7bc9
.hero_no_offsets
    lda #0                              ; ...with no offsets
    sta hero_offset_x,x                 ; ...
    sta hero_offset_y,x                 ; ...
; &7bd6 referenced 1 time by &7bad
.double_offsets
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
    bne monster_step_right              ; ...
    lda #0                              ; ...
    sta monster_offset_x,x              ; ...
    lda #&fd                            ; ...3 rows up
    sta monster_offset_y,x              ; ...
    rts                                 ; Return
; &7c02 referenced 1 time by &7bf5
.monster_step_right
    cmp #&0b                            ; Moving right...
    bne monster_step_down               ; ...
    lda #0                              ; ...
    sta monster_offset_y,x              ; ...
    lda #1                              ; ...1 column right
    sta monster_offset_x,x              ; ...
    rts                                 ; Return
; &7c11 referenced 1 time by &7c04
.monster_step_down
    cmp #&0d                            ; Moving down...
    bne monster_step_left               ; ...
    lda #0                              ; ...
    sta monster_offset_x,x              ; ...
    lda #3                              ; ...3 rows down
    sta monster_offset_y,x              ; ...
    rts                                 ; Return
; &7c20 referenced 1 time by &7c13
.monster_step_left
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
    bne grow_offset_x                   ; Not over: grow the offsets
    lda monster_sprite,x                ; Over: move the cell on in its direction, up...
    cmp #9                              ; ...
    bne monster_continue_right          ; ...
    dec monster_y,x                     ; ...
; &7c42 referenced 1 time by &7c3d
.monster_continue_right
    cmp #&0b                            ; ...right...
    bne monster_continue_down           ; ...
    inc monster_x,x                     ; ...
; &7c49 referenced 1 time by &7c44
.monster_continue_down
    cmp #&0d                            ; ...down...
    bne monster_continue_left           ; ...
    inc monster_y,x                     ; ...
; &7c50 referenced 1 time by &7c4b
.monster_continue_left
    cmp #&0f                            ; ...left
    bne monster_no_offsets              ; ...
    dec monster_x,x                     ; ...
; &7c57 referenced 1 time by &7c52
.monster_no_offsets
    lda #0                              ; ...with no offsets
    sta monster_offset_x,x              ; ...
    sta monster_offset_y,x              ; ...
; &7c5f referenced 1 time by &7c36
.grow_offset_x
    lda monster_offset_x,x              ; Grow the horizontal offset by a column, away from zero
    beq grow_offset_y                   ; ...
    bpl grow_offset_x_right             ; ...
    dec monster_offset_x,x              ; ...
    jmp grow_offset_y                   ; ...
; &7c6c referenced 1 time by &7c64
.grow_offset_x_right
    inc monster_offset_x,x              ; ...
; &7c6f referenced 2 times by &7c62, &7c69
.grow_offset_y
    lda monster_offset_y,x              ; Grow the vertical offset by three rows, away from zero
    beq return_10                       ; ...
    bpl grow_offset_y_down              ; ...
    sec                                 ; ...
    lda monster_offset_y,x              ; ...
    sbc #3                              ; ...
    sta monster_offset_y,x              ; ...
    jmp return_10                       ; ...
; &7c82 referenced 1 time by &7c74
.grow_offset_y_down
    clc                                 ; ...
    lda monster_offset_y,x              ; ...
    adc #3                              ; ...
    sta monster_offset_y,x              ; ...
; &7c8b referenced 2 times by &7c72, &7c7f
.return_10
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
    jsr osbyte                          ; ...  Test whether the key with negative INKEY number X is pressed
    cpy #&ff                            ; X = Y = &FF if it is pressed
    bne key_not_pressed                 ; ...
    cpx #&ff                            ; ...
    bne key_not_pressed                 ; ...
    pla                                 ; Pressed: restore X and return A = 0, Z set
    tax                                 ; ...
    lda #0                              ; ...
    rts                                 ; ...
; &7cae referenced 2 times by &7ca3, &7ca7
.key_not_pressed
    pla                                 ; Not pressed: restore X and return A = 1
    tax                                 ; ...
    lda #1                              ; ...
    rts                                 ; ...
; &7cb3 referenced 1 time by &7b3c
.monster_reappears
    inc next_trapdoor                   ; Next trapdoor, 0-7 in turn
    lda next_trapdoor                   ; ...
    cmp #8                              ; ...
    bne emerge_at_trapdoor              ; ...
    lda #0                              ; ...
    sta next_trapdoor                   ; ...
; &7cc2 referenced 1 time by &7cbb
.emerge_at_trapdoor
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
    beq emerge_done                     ; No: done
    pla                                 ; Yes: wait off the map, to try again next frame
    pha                                 ; ...
    tax                                 ; ...
    lda #&ff                            ; ...
    sta monster_x,x                     ; ...
    sta monster_y,x                     ; ...
    jmp monster_done                    ; ...
; &7cfb referenced 1 time by &7ceb
.emerge_done
    jmp monster_done                    ; Done
    equb &00
; &7cff referenced 3 times by &0e1b, &15f0, &759b
.monster_start_hit_points
    equb &08
; ***************************************************************************************
; Workspace template
;
; The starting contents of page &0D for each level, copied there by reset_workspace: the
; heroes' starting positions, directions, keys (hero_key_up etc. at +&70), health of 99 +
; 1 (at +&90, +&95), the views' rooms (+&A0), sprite bases (+&B0, +&B5), bit masks (+&C0)
; and panel rows (+&D0).
; &7d00 used as index base 1 time by &150f
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
    equb inkey_key_caps_lock, inkey_key_keypad_hash, inkey_key_g, inkey_key_underscore
    equb inkey_key_shift_lock, inkey_key_keypad_del, inkey_key_b, inkey_key_return
    equb inkey_key_z, inkey_key_keypad_comma, inkey_key_m, inkey_key_copy
    equb inkey_key_shift, inkey_key_keypad_3, inkey_key_n, inkey_key_delete
    equb inkey_key_tab, inkey_key_keypad_asterisk, inkey_key_space, inkey_key_left_square_bracket
    equb &0d, &c9, &05, &d0, &09, &18, &bd, &04
    equb &0d, &69, &03, &9d
    equs "''''"
    equb &d0
    equs "(((("
    equb &18, &bd, &08, &0d, &6d, &40, &0d, &28
    equb &0c, &28, &0c, &28, &0c, &28, &0c, &00
    equb &00, &bd, &04, &0d, &85, &71, &8a, &10
    equs "DLHh"
    equb &00
    equs ",4<"
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
; &7e00 used as index base 17 times by &15ed, &7667, &797e, &79e7, &7a31, &7a3f, &7a45, &7a5b, &7a98, &7ace, &7afb, &7b04, &7b41, &7c46, &7c54, &7cc8, &7cf2
.monster_x
; &7e23 referenced 2 times by &1d29, &1d39
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
    equb &14, &27, &0d, &20, &01, &26, &0a, &01
    equb &12, &05, &20, &29, &0d, &26, &27, &08
    equb &06, &1a, &14, &03, &1d, &07, &0d, &17
    equb &00, &00, &00, &00, &1b, &00, &00, &00
    equb &00, &00
; &7e52 used as index base 19 times by &15e8, &7144, &7598, &7683, &768c, &7a0d, &7a23, &7a77, &7a81, &7ab4, &7abb, &7ac3, &7b11, &7b32, &7b35, &7b4d, &7bf0, &7c38, &7cd3
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
; &7f20 used as index base 9 times by &1576, &7173, &719a, &730d, &7337, &73ea, &7413, &7469, &74bb
.object_x
    equb &00, &ff, &ff, &ff, &ff, &ff, &18, &04
    equb &04, &05, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &01, &07, &04
    equb &04, &ff, &ff, &ff, &ff, &ff
; &7f3e referenced 4 times by &1f3b, &1f77, &1f85, &2029
.exit_x
    equb &04
; &7f3f used as index base 9 times by &157c, &717b, &719d, &7313, &7342, &73f3, &7416, &746c, &74be
.object_y
    equb &00, &ff, &ff, &ff, &ff, &ff, &15, &18
    equb &19, &19, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff
    equs "**+."
    equb &ff, &ff, &ff, &ff, &ff
; &7f5d referenced 4 times by &1f43, &1f7d, &1f88, &202f
.exit_y
    equb &2c
; &7f5e used as index base 7 times by &1582, &7183, &718e, &7191, &7319, &735c, &73c8
.object_type
    equb &00
    equs "___)c_S+S((``(*b(()(++++)(()(Q"
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00
    equb &4c, &22, &e8                  ; Pass every character straight to MOS 3.20's OSWRCH (&E822)
; ***************************************************************************************
; The game-font WRCHV handler, unused
;
; The rest of the cassette game's wrch_handler, which prints letters and digits in the
; game's own font. On this side WRCHV's entry at &7F8F jumps straight to the MOS, so none
; of this runs and text appears in the MOS font.
.data_7f92
capital_letter = data_7f92+35
glyph_offset = data_7f92+38
copy_glyph = data_7f92+43
copy_letter_glyph = data_7f92+51
restore_registers = data_7f92+63
digit_glyph = data_7f92+72
copy_digit_glyph = data_7f92+86
pass_character = data_7f92+100
    equb &48, &98, &48, &a5, &70, &c9, &30, &90
    equb &5b, &c9, &3a, &90, &3b, &c9, &41, &90
    equb &53, &c9, &5b, &90, &0e, &c9, &61, &90
    equb &4b, &c9, &7b, &b0, &47, &38, &e9, &61
    equb &4c, &b8, &7f, &38, &e9, &41, &0a, &0a
    equb &0a, &d0, &00, &aa, &18, &69, &08, &85
    equb &70, &a0, &00, &bd, &d7, &12, &99, &00
    equb &0c, &c8, &e8, &e4, &70, &d0, &f4, &68
    equb &a8, &68, &aa, &a9, &80, &4c, &a4, &e0
    equb &38, &e9, &30, &0a, &0a, &0a, &aa, &18
    equb &69, &08, &85, &70, &a0, &00, &bd, &a7
    equb &13, &99, &00, &0c, &c8, &e8, &e4, &70
    equb &d0, &f4, &f0, &db, &68, &a8, &68, &aa
    equb &a5, &70, &4c, &a4, &e0, &00   ; ...  ...and Y  ...  Classify the character  Below '0': print it unchanged  ...  '0'-'9': a digit  ...  ':'-'@': print it unchanged  ...  'A'-'Z': a capital letter  ...  '['-'`': print it unchanged  ...  Above 'z': print it unchanged  ...  A lower-case letter: letter number 0-25  ...  ...  A capital letter: letter number 0-25  ...  x 8: offset of the glyph in font_letters  ...  ...  Branch to the next instruction either way  X = offset of the first glyph byte  Stop after eight bytes  ...  ...  Y indexes the character 128 definition  Copy a glyph byte...  ...into the character 128 definition  ...  ...  ...  Loop for eight bytes  Restore Y...  ...  ...and X  ...  Print character 128, now showing the glyph...  ...through the MOS 1.20 OSWRCH routine  A digit: digit number 0-9  ...  x 8: offset of the glyph in font_digits  ...  ...  X = offset of the first glyph byte  Stop after eight bytes  ...  ...  Y indexes the character 128 definition  Copy a glyph byte...  ...into the character 128 definition  ...  ...  ...  Loop for eight bytes  Print character 128 (always branches)  Any other character: restore Y...  ...  ...and X  ...  Recover the character  ...and print it through the MOS 1.20 OSWRCH routine
.dasmos_dunj2_end

    org &c500

.dasmos_code_start
; ***************************************************************************************
; BYTEV handler: read a joystick for the Barbarian's keys
;
; Installed by Coder2. Answers OSBYTE &81 scans of the third hero's keys from the
; analogue port: N (&AA) and M (&9A) from channel 1 at its extremes, B (&9B) and G (&AC)
; from channel 2, and fire (SPACE, &9D) from the fire buttons. Every other call goes to
; the MOS 3.20 OSBYTE routine at &EEB1 directly. It is the Model B side's handler with
; this side's keys and MOS.
;
; On Entry:
;     A: OSBYTE number
;     X: OSBYTE X
;
; On Exit:
;     X: &FF if the key is pressed, 0 if not
.joystick_bytev
    cmp #&81                            ; OSBYTE &81 (INKEY)?
    bne code_c569                       ; No: pass it on
    cpx #&aa                            ; N (left)?
    beq code_c51b                       ; ...
    cpx #&9b                            ; B (down)?
    beq code_c546                       ; ...
    cpx #&ac                            ; G (up)?
    beq code_c538                       ; ...
    cpx #&9a                            ; M (right)?
    beq code_c529                       ; ...
    cpx #&9d                            ; SPACE (fire)?
    beq code_c555                       ; ...
    jmp mos320_osbyte_default           ; Another key: pass it on
; &c51b referenced 1 time by &c506
.code_c51b
    ldx #1                              ; N: channel 1 high byte &FF?
    lda #osbyte_read_adc_or_get_buffer_status  ; ...
    jsr osbyte                          ; Read ADC channel X or buffer status  ...
    cpy #&ff                            ; ...
    bne code_c566                       ; No: not pressed
    ldx #&ff                            ; Yes: pressed
    rts                                 ; Return
; &c529 referenced 1 time by &c512
.code_c529
    ldx #1                              ; M: channel 1 high byte 0?
    lda #osbyte_read_adc_or_get_buffer_status  ; ...
    jsr osbyte                          ; Read ADC channel X or buffer status  ...
    cpy #0                              ; ...
    bne code_c566                       ; No: not pressed
    dey                                 ; Yes: pressed (Y = &FF)
    ldx #&ff                            ; ...
    rts                                 ; Return
; &c538 referenced 1 time by &c50e
.code_c538
    ldx #2                              ; G: channel 2 high byte &FF?
    lda #osbyte_read_adc_or_get_buffer_status  ; ...
    jsr osbyte                          ; Read ADC channel X or buffer status  ...
    cpy #&ff                            ; ...
    bne code_c566                       ; No: not pressed
    ldx #&ff                            ; Yes: pressed
    rts                                 ; Return
; &c546 referenced 1 time by &c50a
.code_c546
    ldx #2                              ; B: channel 2 high byte 0?
    lda #osbyte_read_adc_or_get_buffer_status  ; ...
    jsr osbyte                          ; Read ADC channel X or buffer status  ...
    cpy #0                              ; ...
    bne code_c566                       ; No: not pressed
    dey                                 ; Yes: pressed (Y = &FF)
    ldx #&ff                            ; ...
    rts                                 ; Return
; &c555 referenced 1 time by &c516
.code_c555
    ldx #0                              ; Fire: either fire button?
    lda #osbyte_read_adc_or_get_buffer_status  ; ...
    jsr osbyte                          ; ...  Read ADC channel X or buffer status
    txa                                 ; ...
    and #3                              ; ...
    beq code_c566                       ; No: not pressed
    ldx #&ff                            ; Yes: pressed
    ldy #&ff                            ; ...
    rts                                 ; Return
; &c566 referenced 5 times by &c524, &c532, &c541, &c54f, &c55f
.code_c566
    ldx #0                              ; Not pressed
    rts                                 ; Return
; &c569 referenced 1 time by &c502
.code_c569
    jmp mos320_osbyte_default           ; Pass the call on to the MOS 3.20 OSBYTE routine
.dasmos_code_end

    org &c5a0

.dasmos_table_start
; ***************************************************************************************
; Load level 25 from Stones
;
; Level 25 has no file of its own: Stones ends with its data, so *LOAD STONES 6680 puts
; it at &6B00. Then decrypt and check it.
; &c5a0 referenced 1 time by &14ee
.load_stones
    ldx #&aa                            ; *LOAD STONES 6680
    ldy #&c5                            ; ...
    jsr oscli                           ; ...
    jmp decrypt_level                   ; Decrypt and check it, and return from there
.stones_command
    equs "LOAD STONES 6680"
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
; Stop the music for the game-over message
;
; Stop the music, send the VDU 28 that the game-over code's text window begins with, and
; set the top row in clear_text_area's window to 0.
; &c600 referenced 1 time by &0e86
.game_over_music
    jsr stop_music                      ; Stop the music
    lda #&1c                            ; VDU 28: the game-over text window...
    jsr oswrch                          ; ...
    lda #0                              ; Top row 0 in clear_text_area's window
    sta clear_text_area_top             ; ...
    rts                                 ; Return
; ***************************************************************************************
; Unused
;
; Leftover bytes: the end of a routine that selects COLOUR 2 and runs *DUNJUNZ (its
; command follows), and zeros.
    equb &ee, &ff, &a9, &02, &20, &ee, &ff
    equb &a2, &1c, &a0, &c6, &20, &f7, &ff
    equs "DUNJUNZ"
    equb &0d, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00
; ***************************************************************************************
; Screen row offsets
;
; Row x 640 for character rows 0-24, high byte first: the table screen_address and the
; title's star plotter read here instead of in MOS 1.20.
; &c675 used as index base 2 times by &096e, &d86e
.row_offsets
; &c676 used as index base 2 times by &0976, &d876
row_offsets_lo = row_offsets+1
    equb &00, &00, &02, &80, &05, &00, &07, &80, &0a, &00
    equb &0c, &80, &0f, &00, &11, &80, &14, &00, &16, &80
    equb &19, &00, &1b, &80, &1e, &00, &20, &80, &23, &00
    equb &25, &80, &28, &00, &2a, &80, &2d, &00, &2f, &80
    equb &32, &00, &34, &80, &37, &00, &39, &80, &3c, &00
    equb &3e, &80, &41, &00, &43, &80, &46, &00
    equb &48, &80, &4b, &00, &4d, &80, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00
; ***************************************************************************************
; *FREE
;
; Show the disc's free space. The game never calls it: *EDITOR does, after cataloguing
; the disc, relying on Table being in private RAM.
.show_free_space
    ldx #<(free_command)                ; *FREE...
    ldy #>(free_command)                ; ...
    jsr oscli                           ; ...
    rts                                 ; Return
.free_command
    equs "FREE"
    equb &0d
    equb &00, &00, &00
; ***************************************************************************************
; Pause while P is pressed
;
; Called from check_pause in the game's update. If P (internal key &37) is held, wait for
; it to be released, pressed again and released, then restart the frame timing. The Model
; B side uses the same key.
; &c6d0 referenced 1 time by &1ed7
.pause_check
    lda #osbyte_scan_keyboard_from_16   ; OSBYTE &7A: which key is pressed?
    jsr osbyte                          ; ...  Scan keyboard from key 16
    cpx #&37 ; '7'                      ; P?
    bne return_11                       ; No: return
    jsr wait_p_released                 ; Paused: wait for P to be released...
; &c6dc referenced 1 time by &c6e3
.loop_c6dc
    lda #osbyte_scan_keyboard_from_16   ; ...pressed again...
    jsr osbyte                          ; ...  Scan keyboard from key 16
    cpx #&37 ; '7'                      ; ...
    bne loop_c6dc                       ; ...
    jsr wait_p_released                 ; ...and released
    lda #2                              ; Restart the frame timing
    sta os_vsync_counter                ; ...
; &c6ed referenced 1 time by &c6d7
.return_11
    rts                                 ; Return
; ***************************************************************************************
; Wait until P is not pressed
; &c6ee referenced 3 times by &c6d9, &c6e5, &c6f5
.wait_p_released
    lda #osbyte_scan_keyboard_from_16   ; OSBYTE &7A: which key is pressed?
    jsr osbyte                          ; ...  Scan keyboard from key 16
    cpx #&37 ; '7'                      ; Still P?
    beq wait_p_released                 ; Yes: keep waiting
    rts                                 ; Return
.dasmos_table_end

    org &c700

.dasmos_code2_start
; ***************************************************************************************
; Start the music
;
; Define envelopes 6-9, redirect the game's plot_sprite to the copy in Code3, point the
; tune at its first section, and play it on the interval timer: EVNTV is pointed at
; music_event and the interval timer event enabled. Then play the first step.
; &c700 referenced 1 time by &1461
.start_music
    ldx #<(envelope_6)                  ; ENVELOPE 6...
    ldy #>(envelope_6)                  ; ...
    lda #osword_envelope                ; ...
    jsr osword                          ; ...  ENVELOPE command
    ldx #<(envelope_7)                  ; ENVELOPE 7...
    ldy #>(envelope_7)                  ; ...
    lda #osword_envelope                ; ...
    jsr osword                          ; ...  ENVELOPE command
    ldx #<(envelope_8)                  ; ENVELOPE 8...
    ldy #>(envelope_8)                  ; ...
    lda #osword_envelope                ; ...
    jsr osword                          ; ...  ENVELOPE command
    ldx #<(envelope_9)                  ; ENVELOPE 9
    ldy #>(envelope_9)                  ; ...
    lda #osword_envelope                ; ...
    jsr osword                          ; ...  ENVELOPE command
    lda #&4c ; 'L'                      ; Make plot_sprite JMP &D800, the copy in Code3...
    sta plot_sprite                     ; ...
    lda #0                              ; ...
    sta plot_sprite + 1                 ; ...
    lda #&d8                            ; ...
    sta plot_sprite + 2                 ; ...
    lda #&cd                            ; Tune pointer (zero page &00-&01) = the first section...
    sta tune_ptr                        ; ...
    lda #&c8                            ; ...
    sta tune_ptr + 1                    ; ...
    lda #0                              ; Section 0
    sta music_section                   ; ...
    lda #&ff                            ; Rhythm step -1, so the first step plays step 0
    sta music_rhythm_step               ; ...
    lda #0                              ; No transposition
    sta music_transpose                 ; ...
    lda #&6c ; 'l'                      ; EVNTV = music_event...
    sta evntv                           ; ...
    lda #&c7                            ; ...
    sta evntv + 1                       ; ...
    lda #osbyte_enable_event            ; OSBYTE 14, 5: enable the interval timer event
    ldx #event_interval_timer_crossing_zero  ; ...
    ldy #0                              ; ...
    jsr osbyte                          ; ...  Enable event
    jmp music_event                     ; Play the first step, and return from there
; ***************************************************************************************
; Stop the music
;
; OSBYTE 13, 5: disable the interval timer event.
; &c760 referenced 2 times by &1419, &c600
.stop_music
    lda #osbyte_disable_event           ; OSBYTE 13, 5: disable the interval timer event
    ldx #event_interval_timer_crossing_zero  ; ...
    ldy #0                              ; ...
    jmp osbyte                          ; ...  Disable event
; &c769 referenced 6 times by &1407, &147a, &c742, &c7b2, &c7be, &c803
.music_rhythm_step
    equb &ff
; &c76a referenced 5 times by &140b, &1476, &c747, &c77e, &c7c8
.music_transpose
    equb &ea
; &c76b referenced 6 times by &140f, &1472, &c73d, &c7f7, &c7fa, &c808
.music_section
    equb &ea
; ***************************************************************************************
; Event handler: play one step of the music
;
; Called through EVNTV for the interval timer event, which start_music sets to recur
; every 12 centiseconds. A tune step is three bytes: a transposition for the rhythm (0
; for no change) or &FF to end the section, a pitch for channel 2 and a pitch for channel
; 3 (0 for silence). Each step also plays the next of the 32 steps of rhythm_pattern on
; channel 1 and the noise channel. At the end of a section the next byte sets channel 3's
; envelope and the next section starts; after section 24 the tune goes back to section 1.
; The interval timer is then reset.
;
; On Exit:
;     A: preserved
;     X: preserved
;     Y: preserved
; &c76c referenced 1 time by &c75d
.music_event
    php                                 ; Save the flags and registers
    pha                                 ; ...
    tya                                 ; ...
    pha                                 ; ...
    txa                                 ; ...
    pha                                 ; ...
    ldy #0                              ; First byte of the step...
    lda (tune_ptr),y                    ; ...
    cmp #&ff                            ; ...&FF?
    beq code_c7f0                       ; Yes: end of the section
; &c77a referenced 1 time by &c81a
.code_c77a
    cmp #0                              ; Non-zero: a new transposition
    beq code_c781                       ; ...
    sta music_transpose                 ; ...
; &c781 referenced 1 time by &c77c
.code_c781
    ldy #1                              ; Second byte: channel 2's pitch...
    lda (tune_ptr),y                    ; ...
    beq code_c793                       ; ...0 for none
    sta channel_2_sound + 4             ; ...
    ldx #<(channel_2_sound)             ; SOUND channel_2_sound...
    ldy #>(channel_2_sound)             ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; ...  SOUND command
; &c793 referenced 1 time by &c785
.code_c793
    ldy #2                              ; Third byte: channel 3's pitch...
    lda (tune_ptr),y                    ; ...
    beq code_c7a5                       ; ...0 for none
    sta channel_3_sound + 4             ; ...
    ldx #<(channel_3_sound)             ; SOUND channel_3_sound...
    ldy #>(channel_3_sound)             ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; ...  SOUND command
; &c7a5 referenced 1 time by &c797
.code_c7a5
    lda tune_ptr                        ; Next step: tune_ptr += 3...
    clc                                 ; ...
    adc #3                              ; ...
    sta tune_ptr                        ; ...
    lda tune_ptr + 1                    ; ...
    adc #0                              ; ...
    sta tune_ptr + 1                    ; ...
    lda music_rhythm_step               ; Next rhythm step, 0-31...
    clc                                 ; ...
    adc #1                              ; ...
    cmp #&20 ; ' '                      ; ...
    bmi code_c7be                       ; ...
    lda #0                              ; ...
; &c7be referenced 1 time by &c7ba
.code_c7be
    sta music_rhythm_step               ; ...
    tay                                 ; Its pitch, 0 for a rest...
    lda rhythm_pattern,y                ; ...
    beq code_c7e0                       ; ...
    clc                                 ; ...transposed...
    adc music_transpose                 ; ...
    sta channel_1_sound + 4             ; ...
    ldx #<(channel_1_sound)             ; ...on channel 1...
    ldy #>(channel_1_sound)             ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; ...  SOUND command
    ldx #<(noise_sound)                 ; ...with the noise channel
    ldy #>(noise_sound)                 ; ...
    lda #osword_sound                   ; ...
    jsr osword                          ; ...  SOUND command
; &c7e0 referenced 1 time by &c7c5
.code_c7e0
    ldx #<(music_interval)              ; OSWORD 4: interval timer = -12 centiseconds, for the next step
    ldy #>(music_interval)              ; ...
    lda #osword_write_interval_timer    ; ...
    jsr osword                          ; ...  Write interval timer
    pla                                 ; Restore the registers and flags
    tax                                 ; ...
    pla                                 ; ...
    tay                                 ; ...
    pla                                 ; ...
    plp                                 ; ...
    rts                                 ; Return
; &c7f0 referenced 1 time by &c778
.code_c7f0
    ldy #1                              ; End of section: the next byte is channel 3's envelope
    lda (tune_ptr),y                    ; ...
    sta channel_3_sound + 2             ; ...
    inc music_section                   ; Next section...
    lda music_section                   ; ...
    cmp #&19                            ; ...
    bne code_c80b                       ; ...past 24?
    lda #&ff                            ; Yes: back to section 1, with the rhythm restarting
    sta music_rhythm_step               ; ...
    lda #1                              ; ...
    sta music_section                   ; ...
; &c80b referenced 1 time by &c7ff
.code_c80b
    tay                                 ; Point tune_ptr at the section...
    lda section_ptrs_lo,y               ; ...
    sta tune_ptr                        ; ...
    lda section_ptrs_hi,y               ; ...
    sta tune_ptr + 1                    ; ...
    ldy #0                              ; ...and play its first step
    lda (tune_ptr),y                    ; ...
    jmp code_c77a                       ; ...
.channel_1_sound
; &c821 referenced 1 time by &c7cb
    equb &11, &00, &09, &00, &00, &00, &01, &00
.noise_sound
    equb &10, &00, &07, &00, &03, &00, &03, &00
.channel_2_sound
; &c831 referenced 1 time by &c787
    equb &12, &00, &08, &00, &00, &00, &0a, &00
.channel_3_sound
; &c837 referenced 1 time by &c7f4
; &c839 referenced 1 time by &c799
    equb &13, &00, &06, &00, &00, &00, &08, &00
; &c83d used as index base 1 time by &c80c
.section_ptrs_lo
    equb &cd, &8f, &11, &11, &cd, &7d, &7d, &cd, &33, &33, &b5, &77, &77
    equb &cd, &11, &39, &5b, &5b, &3f, &3f, &c1, &43, &43, &c5, &cd
; &c856 used as index base 1 time by &c811
.section_ptrs_hi
    equb &c8, &c9, &cb, &cb, &c8, &d1, &d1, &c8, &cc, &cc, &cd, &ce, &ce
    equb &c8, &cb, &cf, &d0, &d0, &d2, &d2, &d3, &d5, &d5, &d6, &c8
.envelope_6
    equb &06, &05, &00, &ff, &01, &01, &01, &01, &01, &ff, &ff, &ff, &78, &00
.envelope_7
    equb &07, &01, &00, &00, &00, &00, &00, &00, &7e, &fe, &ff, &fc, &50, &7e
.envelope_8
    equb &08, &07, &00, &ff, &01, &01, &01, &01, &50, &ff, &ff, &ff, &7e, &64
.envelope_9
    equb &09, &04, &00, &ff, &01, &01, &01, &01, &00, &00, &00, &00, &00, &00
.music_interval
    equb &f4, &ff, &ff, &ff, &ff
; &c8ac used as index base 1 time by &c7c2
.rhythm_pattern
    equb &74, &74, &74, &74, &a4, &00, &74, &74, &00, &74, &74, &00, &a4, &00, &00, &a4
    equb &74, &74, &74, &00, &a4, &00, &74, &74, &00, &74, &74, &00, &a4, &00, &00, &a4
; ***************************************************************************************
; The tune
;
; The music's data: sections of three-byte steps (transposition or &FF, channel 2 pitch,
; channel 3 pitch), reached through section_ptrs_lo and section_ptrs_hi.
    equb &74
.tune
    equb &04, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &ff, &06, &04, &4d, &1d, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &1d, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &1d, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &1d, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &1d, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &1d, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &1d, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &1d, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &4d, &29, &00
    equb &00, &00, &fc, &45, &15, &00, &00, &00, &00, &00, &25, &00
    equb &00, &00, &00, &00, &31, &00, &00, &00, &00, &00, &25, &00
    equb &00, &00, &00, &00, &15, &00, &00, &00, &00, &00, &25, &00
    equb &00, &00, &00, &00, &31, &00, &00, &00, &00, &00, &25, &00
    equb &00, &00, &00, &00, &15, &00, &00, &00, &00, &00, &25, &00
    equb &00, &00, &00, &00, &31, &00, &00, &00, &00, &00, &25, &00
    equb &00, &00, &00, &00, &15, &00, &00, &00, &00, &00, &25, &00
    equb &00, &00, &00, &00, &31, &00, &00, &00, &00, &00, &25, &00
    equb &00, &00, &04, &4d, &1d, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &1d, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &1d, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &1d, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &29, &00
    equb &00, &00, &ff, &06, &04, &00, &1d, &00, &00, &00, &00, &00
    equb &29, &00, &00, &00, &00, &00, &39, &00, &00, &00, &00, &00
    equb &29, &00, &00, &00, &00, &00, &1d, &00, &00, &00, &00, &00
    equb &29, &00, &00, &00, &00, &00, &39, &00, &00, &00, &00, &00
    equb &29, &00, &00, &00, &00, &00, &1d, &00, &00, &00, &00, &00
    equb &29, &00, &00, &00, &00, &00, &39, &00, &00, &00, &00, &00
    equb &29, &00, &00, &00, &00, &00, &1d, &00, &00, &00, &00, &00
    equb &29, &00, &00, &00, &00, &00, &39, &00, &00, &00, &00, &4d
    equb &29, &00, &55, &00, &00, &59, &1d, &00, &00, &00, &00, &00
    equb &29, &00, &00, &00, &00, &00, &39, &00, &00, &00, &00, &00
    equb &29, &00, &00, &00, &00, &55, &1d, &00, &00, &00, &00, &4d
    equb &29, &00, &00, &00, &00, &00, &39, &00, &00, &00, &00, &45
    equb &29, &00, &00, &00, &fc, &00, &15, &00, &00, &00, &00, &00
    equb &25, &00, &00, &00, &00, &00, &31, &00, &00, &00, &00, &00
    equb &25, &00, &00, &00, &00, &00, &15, &00, &00, &00, &00, &00
    equb &25, &00, &00, &00, &00, &00, &31, &00, &00, &00, &00, &4d
    equb &25, &00, &55, &00, &04, &59, &1d, &00, &00, &00, &00, &00
    equb &29, &00, &00, &00, &00, &00, &39, &00, &00, &00, &00, &00
    equb &29, &00, &00, &00, &00, &55, &1d, &00, &00, &00, &00, &59
    equb &29, &00, &00, &00, &00, &00, &39, &00, &00, &00, &00, &61
    equb &29, &00, &00, &00, &fc, &00, &15, &00, &00, &00, &00, &00
    equb &25, &00, &00, &00, &00, &00, &31, &00, &00, &00, &00, &00
    equb &25, &00, &00, &00, &00, &00, &15, &00, &00, &00, &00, &59
    equb &25, &00, &00, &00, &00, &55, &31, &00, &00, &00, &00, &4d
    equb &1d, &00, &00, &00, &ff, &06, &04, &59, &00, &00, &55, &00
    equb &00, &59, &00, &00, &4d, &00, &00, &55, &00, &00, &4d, &00
    equb &00, &55, &00, &00, &45, &00, &00, &4d, &59, &00, &45, &55
    equb &00, &4d, &59, &00, &3d, &4d, &00, &45, &55, &00, &3d, &4d
    equb &00, &59, &55, &00, &4d, &45, &00, &59, &4d, &00, &55, &45
    equb &00, &59, &4d, &00, &4d, &3d, &00, &55, &45, &00, &4d, &3d
    equb &00, &55, &59, &00, &61, &4d, &00, &00, &59, &00, &00, &55
    equb &00, &00, &59, &00, &00, &4d, &00, &00, &55, &00, &00, &4d
    equb &00, &00, &55, &00, &00, &61, &fc, &59, &00, &00, &55, &00
    equb &00, &59, &00, &00, &4d, &00, &00, &55, &00, &00, &4d, &00
    equb &00, &55, &00, &00, &45, &00, &00, &4d, &59, &00, &45, &55
    equb &00, &4d, &59, &00, &3d, &4d, &00, &45, &55, &00, &3d, &4d
    equb &00, &59, &55, &00, &4d, &45, &00, &59, &4d, &00, &55, &45
    equb &00, &59, &4d, &00, &4d, &3d, &00, &55, &45, &00, &4d, &3d
    equb &00, &55, &59, &00, &61, &4d, &00, &00, &59, &00, &00, &55
    equb &00, &00, &59, &00, &00, &4d, &00, &00, &55, &00, &00, &4d
    equb &00, &00, &55, &00, &00, &61, &f4, &59, &00, &00, &55, &00
    equb &00, &59, &00, &00, &4d, &00, &00, &55, &00, &00, &4d, &00
    equb &00, &55, &00, &00, &45, &00, &00, &4d, &59, &00, &45, &55
    equb &00, &4d, &59, &00, &3d, &4d, &00, &45, &55, &00, &3d, &4d
    equb &00, &59, &55, &00, &4d, &45, &00, &59, &4d, &00, &55, &45
    equb &00, &59, &4d, &00, &4d, &3d, &00, &55, &45, &00, &4d, &3d
    equb &00, &55, &59, &00, &61, &4d, &00, &00, &59, &00, &00, &55
    equb &00, &00, &59, &00, &00, &4d, &00, &00, &55, &00, &00, &4d
    equb &00, &00, &55, &00, &00, &61, &00, &59, &00, &00, &55, &00
    equb &f0, &59, &00, &00, &4d, &00, &00, &55, &00, &00, &4d, &00
    equb &00, &55, &00, &00, &45, &00, &00, &4d, &59, &00, &45, &55
    equb &00, &4d, &59, &00, &3d, &4d, &00, &45, &55, &00, &3d, &4d
    equb &00, &59, &55, &00, &4d, &45, &00, &59, &4d, &00, &55, &45
    equb &00, &59, &4d, &00, &4d, &3d, &00, &55, &45, &00, &4d, &3d
    equb &00, &55, &59, &00, &61, &4d, &00, &00, &59, &00, &00, &55
    equb &00, &00, &59, &00, &00, &4d, &00, &00, &55, &00, &00, &4d
    equb &00, &00, &55, &00, &00, &61, &ff, &06, &04, &59, &00, &00
    equb &00, &00, &00, &55, &00, &00, &00, &00, &00, &59, &00, &00
    equb &00, &00, &00, &4d, &00, &00, &00, &00, &00, &55, &00, &00
    equb &00, &00, &00, &4d, &00, &00, &00, &00, &00, &55, &00, &00
    equb &00, &00, &00, &45, &00, &00, &00, &00, &00, &59, &00, &00
    equb &00, &00, &00, &55, &00, &00, &00, &00, &00, &59, &00, &00
    equb &00, &00, &00, &4d, &00, &00, &00, &00, &00, &55, &00, &00
    equb &00, &00, &00, &4d, &00, &00, &00, &00, &00, &55, &00, &00
    equb &00, &00, &00, &45, &00, &00, &00, &00, &00, &59, &69, &00
    equb &00, &00, &00, &55, &61, &00, &00, &00, &00, &59, &69, &00
    equb &00, &00, &00, &4d, &59, &00, &00, &00, &00, &55, &61, &00
    equb &00, &00, &00, &4d, &59, &00, &00, &00, &00, &55, &61, &00
    equb &00, &00, &00, &45, &55, &00, &00, &00, &00, &59, &69, &00
    equb &00, &00, &00, &55, &61, &00, &00, &00, &00, &59, &69, &00
    equb &00, &00, &00, &4d, &59, &00, &00, &00, &00, &55, &61, &00
    equb &00, &00, &00, &4d, &59, &00, &00, &00, &00, &55, &61, &00
    equb &00, &00, &00, &45, &55, &00, &00, &00, &ff, &08, &04, &59
    equb &55, &00, &61, &00, &00, &59, &4d, &00, &61, &00, &00, &59
    equb &55, &00, &61, &00, &00, &69, &59, &00, &00, &00, &00, &00
    equb &61, &00, &00, &00, &00, &00, &59, &00, &00, &00, &00, &00
    equb &55, &00, &00, &00, &00, &00, &4d, &00, &00, &00, &00, &59
    equb &55, &00, &61, &00, &00, &59, &4d, &00, &61, &00, &00, &59
    equb &55, &00, &61, &00, &00, &69, &59, &00, &00, &00, &00, &00
    equb &61, &00, &00, &00, &00, &00, &59, &00, &00, &00, &00, &00
    equb &55, &00, &00, &00, &00, &00, &4d, &00, &00, &00, &fc, &55
    equb &55, &00, &59, &00, &00, &55, &4d, &00, &59, &00, &00, &55
    equb &55, &00, &59, &00, &00, &61, &59, &00, &00, &00, &00, &00
    equb &61, &00, &00, &00, &00, &00, &59, &00, &00, &00, &00, &00
    equb &55, &00, &00, &00, &00, &00, &4d, &00, &00, &00, &00, &55
    equb &55, &00, &59, &00, &00, &55, &4d, &00, &59, &00, &00, &55
    equb &55, &00, &59, &00, &00, &61, &59, &00, &00, &00, &00, &00
    equb &61, &00, &00, &00, &00, &00, &59, &00, &00, &00, &00, &00
    equb &55, &00, &00, &00, &00, &00, &4d, &00, &00, &00, &ff, &06
    equb &0c, &00, &25, &00, &00, &00, &00, &00, &31, &00, &00, &00
    equb &00, &00, &3d, &00, &00, &00, &00, &00, &31, &00, &00, &00
    equb &00, &00, &25, &00, &00, &00, &00, &00, &31, &00, &00, &00
    equb &00, &00, &3d, &00, &00, &00, &00, &00, &31, &00, &00, &00
    equb &00, &00, &25, &00, &00, &00, &00, &00, &31, &00, &00, &00
    equb &00, &00, &3d, &00, &00, &00, &00, &00, &31, &00, &00, &00
    equb &00, &00, &25, &00, &00, &00, &00, &00, &31, &00, &00, &00
    equb &00, &00, &3d, &00, &00, &00, &00, &55, &31, &00, &59, &00
    equb &00, &61, &25, &00, &00, &00, &00, &00, &31, &00, &00, &00
    equb &00, &00, &3d, &00, &00, &00, &00, &00, &31, &00, &00, &00
    equb &00, &59, &25, &00, &00, &00, &00, &55, &31, &00, &00, &00
    equb &00, &00, &3d, &00, &00, &00, &00, &4d, &31, &00, &00, &00
    equb &04, &00, &1d, &00, &00, &00, &00, &00, &29, &00, &00, &00
    equb &00, &00, &39, &00, &00, &00, &00, &00, &29, &00, &00, &00
    equb &00, &00, &1d, &00, &00, &00, &00, &00, &29, &00, &00, &00
    equb &00, &00, &39, &00, &00, &00, &00, &55, &29, &00, &59, &00
    equb &00, &61, &1d, &00, &00, &00, &00, &00, &29, &00, &00, &00
    equb &00, &00, &39, &00, &00, &00, &00, &00, &29, &00, &00, &00
    equb &00, &59, &1d, &00, &00, &00, &00, &61, &29, &00, &00, &00
    equb &00, &00, &39, &00, &00, &00, &00, &69, &29, &00, &00, &00
    equb &00, &00, &1d, &00, &00, &00, &00, &00, &29, &00, &00, &00
    equb &00, &00, &39, &00, &00, &00, &00, &00, &29, &00, &00, &00
    equb &00, &00, &1d, &00, &00, &00, &00, &61, &29, &00, &00, &00
    equb &00, &59, &39, &00, &00, &00, &00, &4d, &29, &00, &00, &00
    equb &ff, &06, &fc, &59, &00, &00, &00, &00, &00, &61, &00, &00
    equb &00, &00, &00, &69, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &f0, &4d, &00, &00, &00, &00, &00, &55, &00, &00
    equb &00, &00, &00, &59, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &4d, &00, &00, &00, &00, &00, &55, &00, &00
    equb &00, &00, &00, &59, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &61, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &04, &55, &00, &00, &00, &00, &00, &59, &00, &00
    equb &00, &00, &00, &61, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &69, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &59, &00, &00, &00, &00, &00, &61, &00, &00
    equb &00, &00, &00, &69, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &ff, &08, &04, &1d, &09, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &29, &1d, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &fc, &25, &15, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &f4, &1d, &0d, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &ff, &08, &10, &00, &1d, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &29, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &39, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &29, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &45, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &39, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &59, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &45, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &04, &55, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &59, &00, &00, &55, &00, &00, &4d, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &f4, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &0d, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &15, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &0d, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &1d, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &1d, &00, &00, &00, &00, &00, &15, &00, &00, &00, &00
    equb &00, &0d, &00, &00, &00, &00, &f0, &09, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &09, &00, &00, &00, &00, &00, &0d, &00, &00, &00, &00
    equb &00, &15, &00, &00, &00, &00, &00, &1d, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &25, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &ff, &08, &04, &00, &1d, &00
    equb &00, &00, &00, &00, &25, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &29, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &31, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &31, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &29, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &25, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &15, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &25, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &29, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &31, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &31, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &29, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &25, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &15, &00, &00, &00, &fc, &00, &1d, &00
    equb &00, &00, &00, &00, &25, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &29, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &31, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &31, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &29, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &25, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &15, &00, &00, &00, &f4, &00, &1d, &00
    equb &00, &00, &00, &00, &25, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &29, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &31, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &39, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &31, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &29, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &25, &00, &00, &00, &00, &00, &1d, &00
    equb &00, &00, &00, &00, &15, &00, &00, &00, &ff, &07, &04, &4d
    equb &1d, &00, &00, &00, &00, &00, &25, &00, &00, &00, &00, &45
    equb &1d, &00, &00, &00, &00, &55, &29, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &31, &00, &00, &00, &00, &59
    equb &1d, &00, &00, &00, &00, &4d, &39, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &31, &00, &00, &00, &00, &39
    equb &1d, &00, &00, &00, &00, &45, &29, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &25, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &39, &15, &00, &00, &00, &00, &4d
    equb &1d, &00, &00, &00, &00, &00, &25, &00, &00, &00, &00, &45
    equb &1d, &00, &00, &00, &00, &55, &29, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &31, &00, &00, &00, &00, &59
    equb &1d, &00, &00, &00, &00, &4d, &39, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &31, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &29, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &25, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &15, &00, &00, &00, &fc, &4d
    equb &1d, &00, &00, &00, &00, &00, &25, &00, &00, &00, &00, &45
    equb &1d, &00, &00, &00, &00, &55, &29, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &31, &00, &00, &00, &00, &59
    equb &1d, &00, &00, &00, &00, &4d, &39, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &31, &00, &00, &00, &00, &39
    equb &1d, &00, &00, &00, &00, &45, &29, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &25, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &39, &15, &00, &00, &00, &f4, &4d
    equb &1d, &00, &00, &00, &00, &00, &25, &00, &00, &00, &00, &45
    equb &1d, &00, &00, &00, &00, &55, &29, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &31, &00, &00, &00, &00, &59
    equb &1d, &00, &00, &00, &00, &4d, &39, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &31, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &29, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &25, &00, &00, &00, &00, &00
    equb &1d, &00, &00, &00, &00, &00, &15, &00, &00, &00, &ff, &07
    equb &04, &55, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &59, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &4d, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &59, &29, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &55, &25, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &4d, &1d, &ff, &08
.dasmos_code2_end

    org &d800

.dasmos_code3_start
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
; Code3's copy of plot_sprite, reached by the JMP &D800 that start_music writes at &0900. It differs from the original only in its JSR to screen_address_hazel.
.plot_sprite_hazel
    ldx sprite_number                   ; X = sprite number
    lda sprite_addr_lo,x                ; Point sprite_data_ptr at the sprite's data...
    sta sprite_data_ptr                 ; ...low byte
    lda sprite_addr_hi,x                ; ...high byte from its own table
    sta sprite_data_ptr_hi              ; ...
    lda sprite_widths,x                 ; Width in screen bytes
    sta sprite_width                    ; ...for the inner loop
    lda sprite_heights,x                ; Height in pixel rows
    sta sprite_height                   ; ...for the outer loop
    jsr screen_address_hazel            ; screen_ptr = address of the top-left byte
    ldy #0                              ; Index stays 0: the pointers themselves advance
    ldx sprite_height                   ; X counts the pixel rows still to plot
; &d81d referenced 1 time by &d864
.plot_sprite_row_hazel
    lda screen_ptr                      ; Remember where this pixel row starts...
    sta row_start_ptr                   ; ...
    lda screen_ptr_hi                   ; ...
    sta row_start_ptr_hi                ; ...in row_start_ptr
    txa                                 ; Save the row count
    pha                                 ; ...
    ldx sprite_width                    ; X counts the bytes across this row
; &d829 referenced 1 time by &d83f
.plot_sprite_byte_hazel
    lda (sprite_data_ptr),y             ; Copy one sprite byte...
    sta (screen_ptr),y                  ; ...to the screen
    clc                                 ; Step screen_ptr right one byte column: 8 bytes on
    lda screen_ptr                      ; ...
    adc #8                              ; ...
    sta screen_ptr                      ; ...
    bcc plot_sprite_next_data_hazel     ; ...
    inc screen_ptr_hi                   ; ...with carry into the high byte
; &d838 referenced 1 time by &d834
.plot_sprite_next_data_hazel
    inc sprite_data_ptr                 ; Next sprite data byte
    bne plot_sprite_count_byte_hazel    ; ...
    inc sprite_data_ptr_hi              ; ...with carry into the high byte
; &d83e referenced 1 time by &d83a
.plot_sprite_count_byte_hazel
    dex                                 ; Count the bytes across
    bne plot_sprite_byte_hazel          ; Loop until the row is done
    clc                                 ; screen_ptr = row start + 1: the next pixel row down
    lda row_start_ptr                   ; ...
    adc #1                              ; ...
    sta screen_ptr                      ; ...
    lda row_start_ptr_hi                ; ...
    adc #0                              ; ...
    sta screen_ptr_hi                   ; ...
    lda screen_ptr                      ; Has it crossed into the next character row?
    and #7                              ; ...(pixel row within the character now 0)
    bne plot_sprite_next_row_hazel      ; No: carry on
    clc                                 ; Yes: add 640-8 to reach the top pixel row of the...
    lda screen_ptr                      ; ...character row below
    adc #&78 ; 'x'                      ; ...
    sta screen_ptr                      ; ...
    lda screen_ptr_hi                   ; ...
    adc #2                              ; ...
    sta screen_ptr_hi                   ; ...
; &d861 referenced 1 time by &d852
.plot_sprite_next_row_hazel
    pla                                 ; Recover the row count
    tax                                 ; ...
    dex                                 ; Count the pixel rows
    bne plot_sprite_row_hazel           ; Loop until the sprite is done
    rts                                 ; Return
; ***************************************************************************************
; Calculate a screen address
;
; Set screen_ptr to the screen address of byte column plot_x on pixel row plot_y: &3000 +
; 640 x (plot_y DIV 8) + (plot_y MOD 8) + 8 x plot_x. The multiplication by 640 uses
; row_offsets in Table, this side's copy of the MOS 1.20 table, in private RAM.
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
; &d867 referenced 1 time by &d816
.screen_address_hazel
    lda plot_y                          ; Character row = plot_y DIV 8...
    lsr a                               ; ...
    lsr a                               ; ...
    and #&fe                            ; ...times 2 to index the table's byte pairs
    tay                                 ; ...
    lda row_offsets,y                   ; High byte of row x 640, from Table's copy of the MOS 1.20 table...
    clc                                 ; ...
    adc #&30 ; '0'                      ; ...plus &30: the screen starts at &3000
    sta screen_ptr_hi                   ; ...
    lda row_offsets_lo,y                ; Low byte of row x 640
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
    bcc return_12                       ; ...
    inc screen_ptr_hi                   ; ...with carry into the high byte
; &d89f referenced 1 time by &d89b
.return_12
    rts                                 ; Return
; ***************************************************************************************
; Copied data
;
; The rest of the copy of the game's &0900-&09FE: the bytes that follow screen_address
; there, including the exit workspace's initial values. Not used here.
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
    equb &01, &00, &00, &05, &03, &01, &00
.dasmos_code3_end

save "Coder", dasmos_coder_start, dasmos_coder_end, &0740, &0400
save "Dunj3", dasmos_dunj3_start, dasmos_dunj3_end, &08c0, &08c0
save "Dunj4", dasmos_dunj4_start, dasmos_dunj4_end, &0e00, &0e00
save "Dunj5", dasmos_dunj5_start, dasmos_dunj5_end, &2000, &2000
save "Dunj2", dasmos_dunj2_start, dasmos_dunj2_end, &6e80, &6e80
save "Code", dasmos_code_start, dasmos_code_end, &c500, &c500
save "Table", dasmos_table_start, dasmos_table_end, &c5a0, &c5a0
save "Code2", dasmos_code2_start, dasmos_code2_end, &c700, &c700
save "Code3", dasmos_code3_start, dasmos_code3_end, &d800, &d800

; Label references by decreasing frequency:
;     cell_x:                        59
;     cell_y:                        55
;     oswrch:                        54
;     scratch:                       52
;     sprite_number:                 45
;     plot_x:                        41
;     plot_y:                        30
;     hero_x:                        29
;     hero_y:                        27
;     screen_ptr:                    26
;     osword:                        24
;     osbyte:                        23
;     map_ptr:                       21
;     plot_sprite:                   21
;     hero_offset_y:                 20
;     hero_offset_x:                 19
;     monster_sprite:                19
;     plot_at_cell:                  19
;     hero_direction:                18
;     plot_offset_x:                 18
;     plot_offset_y:                 18
;     screen_ptr_hi:                 18
;     monster_offset_y:              17
;     monster_x:                     17
;     monster_y:                     16
;     monster_offset_x:              15
;     hero_frame:                    14
;     hero_step:                     12
;     missile_direction:             12
;     plot_victory_sprite:           12
;     previous_x:                    11
;     previous_y:                    11
;     tune_ptr:                      11
;     hero_health_tens:              10
;     hero_key:                      10
;     hero_panel_y:                  10
;     hero_max_missiles:              9
;     level_bcd:                      9
;     object_x:                       9
;     object_y:                       9
;     returning_hero_queue:           9
;     lose_health_point:              8
;     panel_hero:                     8
;     ring_x:                         8
;     scratch2:                       8
;     sprite_width:                   8
;     test_wall:                      8
;     cell_room:                      7
;     hero_damage_taken:              7
;     hero_health_units:              7
;     hero_missile_damage:            7
;     hero_score_units:               7
;     key_x:                          7
;     key_y:                          7
;     level_number:                   7
;     menu_text:                      7
;     monster_step:                   7
;     object_type:                    7
;     os_vsync_counter:               7
;     oscli:                          7
;     play_level:                     7
;     ring_y:                         7
;     draw_monster:                   6
;     hero_score_ten_thousands:       6
;     menu_key_loop:                  6
;     missile_x:                      6
;     missile_y:                      6
;     music_rhythm_step:              6
;     music_section:                  6
;     sprite_data_ptr:                6
;     test_key:                       6
;     tune_ptr + 1:                   6
;     victory_pitch:                  6
;     victory_sprite:                 6
;     add_point:                      5
;     check_missile_hero:             5
;     code_c566:                      5
;     count:                          5
;     erase_hero:                     5
;     exit_busy:                      5
;     exit_spin:                      5
;     hero_score_hundreds:            5
;     hero_score_tens:                5
;     hero_score_thousands:           5
;     music_transpose:                5
;     next_trapdoor:                  5
;     plot_panel_sprite:              5
;     sprite_heights:                 5
;     victory_delay:                  5
;     view_room:                      5
;     add_ten_points:                 4
;     door_x:                         4
;     door_y:                         4
;     draw_moved_hero:                4
;     draw_room:                      4
;     exit_saved_x:                   4
;     exit_saved_y:                   4
;     exit_x:                         4
;     exit_y:                         4
;     find_creature:                  4
;     hero_absent:                    4
;     hero_door_x:                    4
;     hero_door_y:                    4
;     hero_key_dropped:               4
;     hero_sprites:                   4
;     map_ptr_hi:                     4
;     menu_text + 1:                  4
;     missile_sprite_base:            4
;     monster_at_edge:                4
;     monster_hit_points:             4
;     next_hero:                      4
;     next_hero_keys:                 4
;     next_other_hero:                4
;     plot_keeping_x:                 4
;     row_start_ptr:                  4
;     row_start_ptr_hi:               4
;     shrunk_hero:                    4
;     sprite_data_ptr_hi:             4
;     sprite_height:                  4
;     sprite_widths:                  4
;     start_hero_step:                4
;     step_hero:                      4
;     bit_masks:                      3
;     check_exit:                     3
;     credit_owner:                   3
;     draw_health:                    3
;     draw_score:                     3
;     exit_shrinks_left:              3
;     exiting_hero:                   3
;     first_level_flag:               3
;     hero_has_boots:                 3
;     hero_magic_delay:               3
;     magic_kill_count:               3
;     missile_damage:                 3
;     monster_done:                   3
;     monster_frame:                  3
;     monster_start_hit_points:       3
;     next_door:                      3
;     next_monster_find:              3
;     next_object:                    3
;     next_victory_sprite:            3
;     osasci:                         3
;     print_menu:                     3
;     system_via_t1c_l:               3
;     victory_pitch_step:             3
;     wait_p_released:                3
;     check_door_y:                   2
;     check_key_swap:                 2
;     check_missile_object:           2
;     check_room_edge:                2
;     clear_text_area:                2
;     credit_missile_owner:           2
;     decrypt_level:                  2
;     decrypt_level_loop:             2
;     door_sprite:                    2
;     draw_hero:                      2
;     draw_missile_damage:            2
;     draw_ten_thousands:             2
;     draw_victory_ring:              2
;     draw_view_0:                    2
;     draw_view_1:                    2
;     draw_view_2:                    2
;     draw_view_3:                    2
;     exit_offsets_x:                 2
;     exit_offsets_y:                 2
;     find_previous_teleporter:       2
;     food_sound + 4:                 2
;     get_hero_cell:                  2
;     grow_offset_y:                  2
;     hero_frame + 1:                 2
;     hero_frame + 2:                 2
;     hero_frame + 3:                 2
;     hit_sound + 4:                  2
;     key_not_pressed:                2
;     level_command_digits:           2
;     level_command_digits + 1:       2
;     level_filename_digits:          2
;     menu_text + 2:                  2
;     missile_spent_pop:              2
;     monster_move_on:                2
;     monster_x + 35:                 2
;     monster_y + 35:                 2
;     mos320_osbyte_default:          2
;     new_game:                       2
;     next_hero_exit:                 2
;     next_hero_find:                 2
;     next_hero_hit:                  2
;     next_key:                       2
;     next_missile:                   2
;     next_monster_magic:             2
;     next_object_drainer:            2
;     no_drainer:                     2
;     osrdch:                         2
;     play_pickup_sound:              2
;     plot_chalice:                   2
;     point_at_boots_icon:            2
;     previous_offset_x:              2
;     previous_offset_y:              2
;     read_hero_keys:                 2
;     remove_object:                  2
;     reset_hero:                     2
;     restore_hero_sprites:           2
;     return_10:                      2
;     returning_hero_queue + 1:       2
;     returning_hero_queue + 2:       2
;     returning_hero_queue + 3:       2
;     row_offsets:                    2
;     row_offsets_lo:                 2
;     saved_page_0d:                  2
;     shorten_victory_delay:          2
;     show_hero_room:                 2
;     sprite_addr_hi:                 2
;     sprite_addr_lo:                 2
;     start_hero_animation:           2
;     start_victory:                  2
;     stop_music:                     2
;     store_victory_sprite:           2
;     take_magic_cost:                2
;     test_object_free:               2
;     trapdoor_x:                     2
;     trapdoor_y:                     2
;     victory_steps_left:             2
;     view_room + 2:                  2
;     view_room + 4:                  2
;     view_room + 6:                  2
;     workspace_template + 208:       2
;     absent_frame_due:               1
;     add_thousand_points:            1
;     add_thousand_points_done:       1
;     advance_dying_monster:          1
;     animate_absent:                 1
;     animate_absent_hero:            1
;     cancel_hero_step:               1
;     channel_1_sound + 4:            1
;     channel_2_sound + 4:            1
;     channel_3_sound + 2:            1
;     channel_3_sound + 4:            1
;     check_boots:                    1
;     check_cross:                    1
;     check_death_finished:           1
;     check_door:                     1
;     check_door_cell_y:              1
;     check_door_key:                 1
;     check_door_x:                   1
;     check_doors:                    1
;     check_exit_busy:                1
;     check_first_sprite:             1
;     check_food:                     1
;     check_for_victory:              1
;     check_helmet:                   1
;     check_hero:                     1
;     check_hero_dead:                1
;     check_hero_hit:                 1
;     check_hero_in_cell:             1
;     check_hero_keys:                1
;     check_hero_loop:                1
;     check_hero_on_exit:             1
;     check_just_fired:               1
;     check_key:                      1
;     check_key_cell:                 1
;     check_key_down:                 1
;     check_key_fire:                 1
;     check_key_left:                 1
;     check_key_right:                1
;     check_kills:                    1
;     check_magic:                    1
;     check_magic_every_frame:        1
;     check_magic_item:               1
;     check_magic_key:                1
;     check_missile_monster:          1
;     check_missile_wall:             1
;     check_monster:                  1
;     check_monster_blocked:          1
;     check_monster_in_cell:          1
;     check_monster_step:             1
;     check_object:                   1
;     check_object_drainer:           1
;     check_object_y:                 1
;     check_other_hero:               1
;     check_potion:                   1
;     check_queue_empty:              1
;     check_teleporter:               1
;     check_trapdoor:                 1
;     check_view_1:                   1
;     check_view_1_room:              1
;     check_view_2:                   1
;     check_view_2_room:              1
;     check_view_3_room:              1
;     check_weapons:                  1
;     clear_chalice_sprite:           1
;     clear_hero_carrying:            1
;     clear_text_area_top:            1
;     code_07c0:                      1
;     code_1419:                      1
;     code_147d:                      1
;     code_14a7:                      1
;     code_14bf:                      1
;     code_14f1:                      1
;     code_c51b:                      1
;     code_c529:                      1
;     code_c538:                      1
;     code_c546:                      1
;     code_c555:                      1
;     code_c569:                      1
;     code_c77a:                      1
;     code_c781:                      1
;     code_c793:                      1
;     code_c7a5:                      1
;     code_c7be:                      1
;     code_c7e0:                      1
;     code_c7f0:                      1
;     code_c80b:                      1
;     coder_display_vdu:              1
;     collect_objects:                1
;     continue_down:                  1
;     continue_hero_step:             1
;     continue_left:                  1
;     continue_monster_step:          1
;     continue_right:                 1
;     copy_workspace_template:        1
;     count_heroes_in_play:           1
;     count_level:                    1
;     credit_drainer_hit:             1
;     cross_done:                     1
;     dasmos_start:                   1
;     decrypt_level_done:             1
;     decrypt_level_next:             1
;     dissolve_chalice:               1
;     doors_done:                     1
;     double_offsets:                 1
;     draw_all_views:                 1
;     draw_armour_rating:             1
;     draw_each_key:                  1
;     draw_each_object:               1
;     draw_keys:                      1
;     draw_missile_icon:              1
;     draw_missile_icons:             1
;     draw_monster_death:             1
;     draw_new_missile_icon:          1
;     draw_objects:                   1
;     draw_panel_hero:                1
;     draw_room_cell:                 1
;     draw_room_doors:                1
;     draw_room_row:                  1
;     draw_room_walls:                1
;     draw_status_panel:              1
;     draw_ten_thousands_loop:        1
;     draw_view_frame:                1
;     draw_view_frames:               1
;     drop_key:                       1
;     emerge_at_trapdoor:             1
;     emerge_done:                    1
;     end_level_filename:             1
;     erase_boots_icon:               1
;     erase_door_loop:                1
;     erase_missile:                  1
;     erase_victory_ring:             1
;     evntv:                          1
;     evntv + 1:                      1
;     exit_offset_x_1:                1
;     exit_offset_x_2:                1
;     exit_offset_x_3:                1
;     exit_offset_y_1:                1
;     exit_offset_y_2:                1
;     exit_offset_y_3:                1
;     exit_offset_y_4:                1
;     find_missile_slot:              1
;     find_monster_room:              1
;     find_open_neighbour:            1
;     find_queue_end:                 1
;     find_queue_slot:                1
;     fire_missile:                   1
;     firer_axe:                      1
;     firer_fireball:                 1
;     firer_sword:                    1
;     flip_firer_frame:               1
;     game_over_message:              1
;     game_over_music:                1
;     grow_offset_x:                  1
;     grow_offset_x_right:            1
;     grow_offset_y_down:             1
;     hero_appearance_sprites:        1
;     hero_direction - 1:             1
;     hero_enters_exit:               1
;     hero_faces:                     1
;     hero_frame - 1:                 1
;     hero_health_tens - 1:           1
;     hero_key_down:                  1
;     hero_key_fire:                  1
;     hero_key_left:                  1
;     hero_key_right:                 1
;     hero_key_up:                    1
;     hero_magic_key:                 1
;     hero_menu:                      1
;     hero_missile_sprites:           1
;     hero_no_offsets:                1
;     hero_start_damage_taken:        1
;     hero_start_max_missiles:        1
;     hero_start_missile_damage:      1
;     hero_step_down:                 1
;     hero_step_left:                 1
;     hero_step_right:                1
;     keys_done:                      1
;     level_checksums:                1
;     level_door_sprite:              1
;     level_door_x:                   1
;     level_door_y:                   1
;     level_filename_digits + 1:      1
;     level_key_x:                    1
;     level_key_y:                    1
;     level_loop:                     1
;     level_object_free_map:          1
;     level_object_type:              1
;     level_object_x:                 1
;     level_object_y:                 1
;     level_trapdoor_x:               1
;     level_trapdoor_y:               1
;     level_wall_sprite:              1
;     level_walls:                    1
;     load_level:                     1
;     load_stones:                    1
;     loop_0745:                      1
;     loop_076c:                      1
;     loop_1485:                      1
;     loop_c6dc:                      1
;     magic_cast:                     1
;     magic_item:                     1
;     magic_sword:                    1
;     magic_user_cost:                1
;     menu_done:                      1
;     menu_hero_off:                  1
;     menu_reprint:                   1
;     menu_set_sound:                 1
;     menu_sound_key:                 1
;     menu_sound_off:                 1
;     menu_space:                     1
;     menu_space_check_hero:          1
;     missile_down:                   1
;     missile_left:                   1
;     missile_right:                  1
;     missile_spent:                  1
;     missile_up:                     1
;     monster_continue_down:          1
;     monster_continue_left:          1
;     monster_continue_right:         1
;     monster_down:                   1
;     monster_hit:                    1
;     monster_killed:                 1
;     monster_left:                   1
;     monster_no_offsets:             1
;     monster_reappears:              1
;     monster_right:                  1
;     monster_step_down:              1
;     monster_step_left:              1
;     monster_step_right:             1
;     monster_vertical:               1
;     mos120_reset_entry:             1
;     move_hero:                      1
;     move_heroes:                    1
;     move_missile:                   1
;     move_missiles:                  1
;     music_event:                    1
;     next_hero_dead:                 1
;     next_hero_doors:                1
;     next_hero_in_play:              1
;     next_hero_victory:              1
;     next_missile_slot:              1
;     next_monster_update:            1
;     next_queue_entry:               1
;     next_queue_slot:                1
;     next_room_cell:                 1
;     next_turn:                      1
;     no_magic:                       1
;     note_new_cell:                  1
;     nothing_found:                  1
;     object_found:                   1
;     object_free_map:                1
;     object_free_map + 58:           1
;     open_door:                      1
;     os_irq_a:                       1
;     os_zp_fa:                       1
;     owner_axe:                      1
;     owner_fireball:                 1
;     owner_sword:                    1
;     panel_hero - 1:                 1
;     pause_check:                    1
;     plot_blank:                     1
;     plot_boots_icon:                1
;     plot_sprite + 1:                1
;     plot_sprite + 2:                1
;     plot_sprite_byte:               1
;     plot_sprite_byte_hazel:         1
;     plot_sprite_count_byte:         1
;     plot_sprite_count_byte_hazel:   1
;     plot_sprite_next_data:          1
;     plot_sprite_next_data_hazel:    1
;     plot_sprite_next_row:           1
;     plot_sprite_next_row_hazel:     1
;     plot_sprite_row:                1
;     plot_sprite_row_hazel:          1
;     print_ending_message:           1
;     print_game_over:                1
;     print_menu_loop:                1
;     print_menu_string:              1
;     print_menu_string_loop:         1
;     print_victory_text:             1
;     queue_exit_marker:              1
;     raise_victory_pitch:            1
;     redraw_armour:                  1
;     redraw_exit:                    1
;     redraw_health:                  1
;     redraw_health_loop:             1
;     remember_hero_position:         1
;     remove_absent_heroes:           1
;     remove_absent_heroes_check:     1
;     remove_absent_heroes_loop:      1
;     remove_absent_heroes_next:      1
;     reset_call_address:             1
;     reset_call_address + 1:         1
;     reset_each_hero:                1
;     reset_each_monster:             1
;     reset_monsters:                 1
;     reset_vector:                   1
;     reset_vector + 1:               1
;     reset_workspace:                1
;     restore_exit:                   1
;     restore_message_spaces:         1
;     restore_sprite_heights:         1
;     restore_sprite_widths:          1
;     return_1:                       1
;     return_11:                      1
;     return_12:                      1
;     return_2:                       1
;     return_3:                       1
;     return_4:                       1
;     return_5:                       1
;     return_6:                       1
;     return_7:                       1
;     return_8:                       1
;     return_9:                       1
;     reverse_down:                   1
;     reverse_left:                   1
;     reverse_right:                  1
;     rhythm_pattern:                 1
;     room_walls:                     1
;     room_walls + 58:                1
;     screen_address:                 1
;     screen_address_hazel:           1
;     section_ptrs_hi:                1
;     section_ptrs_lo:                1
;     send_frame_vdu:                 1
;     set_bell:                       1
;     set_menu_no:                    1
;     set_menu_off:                   1
;     set_menu_on:                    1
;     set_menu_yes:                   1
;     set_monster_step:               1
;     shift_returning_queue:          1
;     show_view_3:                    1
;     shrink_hero_height:             1
;     shrink_hero_width:              1
;     sound_victory_bell:             1
;     sprite_chalice:                 1
;     sprite_chalice - 1:             1
;     start_level:                    1
;     start_monster_move:             1
;     start_monster_step:             1
;     start_music:                    1
;     stay_in_old_cell:               1
;     step_down:                      1
;     step_left:                      1
;     step_right:                     1
;     store_hero_frame:               1
;     store_level_units:              1
;     store_monster_health:           1
;     take_health_unit:               1
;     take_missile_damage:            1
;     take_returning_hero:            1
;     take_ten_health:                1
;     teleport:                       1
;     teleport_last:                  1
;     trapdoor_x - 1:                 1
;     trapdoor_y - 1:                 1
;     try_cell_below:                 1
;     try_cell_left:                  1
;     try_cell_right:                 1
;     turn_monster:                   1
;     two_level_digits:               1
;     unpack_doors:                   1
;     unpack_keys:                    1
;     unpack_level:                   1
;     unpack_objects:                 1
;     unpack_trapdoors:               1
;     unpack_wall_sprite:             1
;     unpack_walls:                   1
;     update_game:                    1
;     update_monsters:                1
;     update_rest:                    1
;     victory_delay_inner:            1
;     victory_delay_loop:             1
;     victory_delay_outer:            1
;     victory_sequence:               1
;     victory_sprite_copy:            1
;     wait_vsync_chalice:             1
;     wait_vsync_game_over:           1
;     wall_sprite:                    1
;     workspace_template:             1
;     wrchv:                          1
;     wrchv + 1:                      1

; Automatically generated labels:
;     code_07c0
;     code_1419
;     code_147d
;     code_14a7
;     code_14bf
;     code_14f1
;     code_162d
;     code_c51b
;     code_c529
;     code_c538
;     code_c546
;     code_c555
;     code_c566
;     code_c569
;     code_c77a
;     code_c781
;     code_c793
;     code_c7a5
;     code_c7be
;     code_c7e0
;     code_c7f0
;     code_c80b
;     data_7f92
;     loop_0745
;     loop_076c
;     loop_1485
;     loop_c6dc
;     return_1
;     return_10
;     return_11
;     return_12
;     return_2
;     return_3
;     return_4
;     return_5
;     return_6
;     return_7
;     return_8
;     return_9

; Stats:
;     Total size (Code + Data) = 20187 bytes
;     Code                     = 7444 bytes (37%)
;     Data                     = 12743 bytes (63%)
;
;     Number of instructions   = 3434
;     Number of data bytes     = 11925 bytes
;     Number of data words     = 0 bytes
;     Number of string bytes   = 818 bytes
;     Number of strings        = 102
