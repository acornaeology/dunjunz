; Constants
spr_wall                             = &00  ; Sprite &00
spr_ranger_up_0                      = &01  ; Sprite &01
spr_monster_up_0                     = &09  ; Sprite &09
spr_monster_right_0                  = &0b  ; Sprite &0B
spr_monster_down_0                   = &0d  ; Sprite &0D
spr_monster_left_0                   = &0f  ; Sprite &0F
spr_arrow_up                         = &11  ; Sprite &11
spr_blank                            = &15  ; Sprite &15
spr_sparkle_0                        = &16  ; Sprite &16
spr_sparkle_3                        = &19  ; Sprite &19
spr_blank_key_icon                   = &1a  ; Sprite &1A
spr_key                              = &1b  ; Sprite &1B
spr_digit_0                          = &1e  ; Sprite &1E
spr_digit_3                          = &21  ; Sprite &21
spr_digit_9                          = &27  ; Sprite &27
spr_treasure                         = &28  ; Sprite &28
spr_food                             = &29  ; Sprite &29
spr_cross                            = &2a  ; Sprite &2A
spr_teleporter                       = &2b  ; Sprite &2B
spr_trapdoor                         = &2c  ; Sprite &2C
spr_magic_user_up_0                  = &2d  ; Sprite &2D
spr_barbarian_up_0                   = &35  ; Sprite &35
spr_fighter_up_0                     = &3d  ; Sprite &3D
spr_fireball_up                      = &45  ; Sprite &45
spr_sword_up                         = &49  ; Sprite &49
spr_axe_up                           = &4d  ; Sprite &4D
spr_exit                             = &51  ; Sprite &51
spr_key_icon                         = &52  ; Sprite &52
spr_drainer_0                        = &53  ; Sprite &53
spr_drainer_11                       = &5e  ; Sprite &5E
spr_boots                            = &5f  ; Sprite &5F
spr_helmet                           = &60  ; Sprite &60
spr_potion                           = &61  ; Sprite &61
spr_weapons                          = &62  ; Sprite &62
spr_shield                           = &69  ; Sprite &69
spr_small_digit_1                    = &6a  ; Sprite &6A
spr_small_digit_8                    = &71  ; Sprite &71
spr_small_digit_9                    = &72  ; Sprite &72
spr_chalice                          = &73  ; Sprite &73
spr_missile_icon                     = &74  ; Sprite &74
spr_boots_icon                       = &75  ; Sprite &75
spr_level_word                       = &76  ; Sprite &76
spr_blank_boots_icon                 = &77  ; Sprite &77
max_object                           = &1e  ; Objects are numbered 1 to 30
max_monster                          = &1e  ; Monsters are numbered 1 to 30
max_door                             = &14  ; Doors are numbered 1 to 20
max_key                              = &14  ; Keys are numbered 1 to 20; key n opens door n
screen_start                         = &3000  ; The start of screen memory, as the game programs the 6845
off_map                              = &ff  ; A map x or y that puts a door, key, object, monster or the exit off the map
nobody_returns                       = &64  ; A returning_hero_queue entry that brings nobody back
step_out_of_play                     = &63  ; hero_step of a hero out of play, never animated
view_right_column                    = &23  ; The screen byte column of the two right-hand views
view_bottom_row                      = &67  ; The pixel row of the two lower views
panel_left                           = &45  ; The status panel's leftmost screen byte column
level_file_end                       = &6db0  ; The end of the level file at &6B00
last_level                           = &19  ; The level with the Chalice
map_bytes                            = &c9  ; The length of the wall and object-free maps
chalice_x                            = &1a  ; Map x of the Chalice's left cells
chalice_y                            = &04  ; Map y of the Chalice's top cells
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
tune_ptr              = &00  ; The music's place in the tune: the current three-byte step.
; &00 referenced 11 times by &1413, &146f, &c735, &c774, &c783, &c795, &c7a5, &c7aa, &c7f2, &c80f, &c818
plot_x                = &70  ; Sprite position: screen byte column, 0-79 (two MODE 2 pixels per byte). Also used as a scratch byte and pointer low byte by other routines.
; &70 referenced 47 times by &0422, &0439, &043b, &0452, &045a, &045c, &045e, &0465, &046b, &05a7, &05ab, &0984, &0991, &0f68, &1458, &154d, &1558, &155c, &1da6, &1e1c, &1e77, &20c6, &726d, &7282, &72c6, &72db, &72eb, &72fb, &75b8, &75d9, &75e4, &75fb, &7823, &7846, &784a, &78a1, &78bb, &78d5, &78ef, &7f95, &7fc1, &7fcd, &7fe4, &7ff0, &7ffa, &d884, &d891
plot_y                = &71  ; Sprite position: pixel row from the top of the screen. Also used as a pointer high byte by other routines.
; &71 referenced 30 times by &042a, &0458, &0469, &0471, &0967, &097b, &0f77, &145c, &1da2, &1e18, &1e73, &20c2, &7269, &72c2, &75b4, &75d5, &75ec, &7603, &7797, &77a9, &77bb, &77cd, &77ef, &77f3, &78a8, &78c2, &78dc, &78f6, &d867, &d87b
sprite_width          = &72  ; Width of the sprite being plotted, in screen bytes.
; &72 referenced 8 times by &0454, &0461, &0463, &047a, &090f, &0927, &d80f, &d827
sprite_height         = &73  ; Height of the sprite being plotted, in pixel rows.
; &73 referenced 4 times by &0914, &091b, &d814, &d81b
screen_ptr            = &74  ; Screen address being written, low byte.
; &74 referenced 26 times by &091d, &092b, &092e, &0932, &0946, &094e, &0955, &0959, &0979, &097f, &0981, &0997, &0999, &d81d, &d82b, &d82e, &d832, &d846, &d84e, &d855, &d859, &d879, &d87f, &d881, &d897, &d899
screen_ptr_hi         = &75  ; Screen address being written, high byte.
; &75 referenced 18 times by &0921, &0936, &094c, &095b, &095f, &0974, &098d, &098f, &099d, &d821, &d836, &d84c, &d85b, &d85f, &d874, &d88d, &d88f, &d89d
row_start_ptr         = &76  ; Screen address of the first byte of the sprite row being plotted, low byte.
; &76 referenced 4 times by &091f, &0942, &d81f, &d842
row_start_ptr_hi      = &77  ; Screen address of the first byte of the sprite row being plotted, high byte.
; &77 referenced 4 times by &0923, &0948, &d823, &d848
sprite_data_ptr       = &78  ; Address of the next sprite data byte to plot, low byte.
; &78 referenced 6 times by &0905, &0929, &0938, &d805, &d829, &d838
sprite_data_ptr_hi    = &79  ; Address of the next sprite data byte to plot, high byte.
; &79 referenced 4 times by &090a, &093c, &d80a, &d83c
sprite_number         = &7a  ; Sprite to plot: an index into the sprite tables at sprite_addr_lo, sprite_addr_hi, sprite_widths and sprite_heights.
; &7a referenced 45 times by &041e, &0433, &0900, &0f6a, &11a6, &11fe, &1d2e, &1d9a, &1dca, &1e10, &1e57, &1e6b, &1f69, &1fb5, &1fd1, &20ba, &7077, &70a2, &70e9, &720f, &7242, &7272, &727e, &72cb, &72d7, &72e7, &72f7, &731c, &75c0, &75dd, &75f4, &7608, &760f, &7663, &767a, &7695, &76f5, &7813, &7836, &7840, &79cb, &79fb, &7b17, &7b50, &d800
map_ptr               = &7b  ; Pointer into room_walls or object_free_map at a cell's room, low byte; set by test_wall and test_object_free.
; &7b referenced 21 times by &1d5b, &1d62, &1d64, &1d80, &1d85, &7046, &7542, &767f, &77a1, &77b3, &77c5, &77d7, &77e4, &790e, &7915, &7917, &792f, &794a, &7951, &7953, &796b
map_ptr_hi            = &7c  ; Pointer into a map, high byte.
; &7c referenced 4 times by &1d68, &77e0, &791b, &7957
plot_offset_x         = &7d  ; Horizontal pixel offset added by plot_at_cell (in byte columns).
; &7d referenced 18 times by &10f2, &1d32, &1dc4, &1e5b, &1f63, &1fa3, &1fe5, &7088, &70cc, &7307, &76ea, &7738, &780c, &787a, &79c5, &7a00, &7b1c, &7b55
plot_offset_y         = &7e  ; Vertical pixel offset added by plot_at_cell (in pixel rows).
; &7e referenced 18 times by &10f4, &1d34, &1dc6, &1e5d, &1f65, &1fa5, &1fea, &708d, &70ce, &7309, &76ec, &773d, &780e, &788e, &79c7, &7a05, &7b21, &7b5a
ring_x                = &80  ; Map x of the cell being drawn in the victory ring.
; &80 referenced 8 times by &114b, &1154, &1159, &1166, &117d, &1182, &118a, &119a
ring_y                = &81  ; Map y of the cell being drawn in the victory ring.
; &81 referenced 7 times by &114f, &116b, &1170, &1178, &118f, &1194, &119f
victory_sprite        = &82  ; Sprite drawn in the victory ring.
; &82 referenced 6 times by &10f8, &115e, &11a4, &11ac, &11bb, &11d5
victory_delay         = &84  ; Delay between frames of the victory sequence.
; &84 referenced 5 times by &1100, &111c, &1122, &1133, &113c
victory_pitch_step    = &8d  ; Amount the victory tone rises each frame.
; &8d referenced 3 times by &1108, &110d, &1113
victory_steps_left    = &8e  ; Rises left in the victory tone.
; &8e referenced 2 times by &1104, &1115
victory_pitch         = &8f  ; Pitch of the victory tone.
; &8f referenced 6 times by &10fc, &110b, &110f, &1124, &7934, &7970
os_zp_fa              = &fa  ; MOS zero-page workspace, read by dissolve_chalice to vary its random choice.
; &fa referenced 1 time by &11c3
os_irq_a              = &fc  ; MOS 1.20: A at the last interrupt, read by dissolve_chalice to vary its random choice.
; &fc referenced 1 time by &11c1
wrchv                 = &020e
; &020e referenced 1 time by &1568
evntv                 = &0220
; &0220 referenced 1 time by &c74c
os_vsync_counter      = &0240  ; MOS 1.20 counter decremented on every vertical sync interrupt. The game sets it and waits for it to run out to pace itself.
; &0240 referenced 7 times by &0e62, &0eb9, &11e9, &11ec, &1f00, &1f07, &c6ea
os_break_intercept    = &0287  ; MOS BREAK intercept: a JMP here is called during a reset. *DUNJUNZ sets its address but leaves it disabled.
unread_digit_table    = &08b0  ; In Dunj3: four bytes *DUNJUNZ sets to &69, which the game never reads.
unread_hero_table     = &08b4  ; In Dunj3: four bytes *DUNJUNZ sets to 0, which the game never reads.
unread_level_count    = &08bc  ; In Dunj3: a byte *DUNJUNZ sets to 0, which the game never reads.
unread_level_digits   = &08bd  ; In Dunj3: two bytes *DUNJUNZ sets to "0 ", which the game never reads.
scratch               = &0d00  ; General-purpose scratch byte.
; &0d00 referenced 49 times by &1cc5, &1d00, &1d4e, &1d52, &1d55, &1d58, &1d77, &1d82, &2006, &200d, &201e, &205a, &2063, &2070, &6f19, &6f1e, &6f25, &6f71, &6fd7, &7002, &7007, &713c, &74b6, &74c3, &74d8, &77e6, &782c, &7857, &785b, &785e, &7861, &7886, &788b, &7901, &7905, &7908, &790b, &7926, &7931, &793d, &7941, &7944, &7947, &7962, &796d, &7976, &7990, &7a89, &7ce3; also used as index base 3 times by &0745, &1488, &1512
scratch2              = &0d01  ; Second scratch byte.
; &0d01 referenced 8 times by &203a, &207b, &74d2, &7503, &7509, &750c, &7829, &782f
cell_x                = &0d02  ; Map x of the cell being drawn, tested or moved to. plot_at_cell replaces it with the pixel offset within the room.
; &0d02 referenced 59 times by &119c, &11f4, &1ccb, &1cdb, &1d26, &1d3c, &1d5d, &1d6c, &1dd1, &1e38, &1e48, &1f58, &1faa, &1fd6, &2094, &20a7, &20de, &20e9, &20fa, &6fa7, &700f, &707c, &70aa, &70ee, &7120, &715b, &7176, &71e3, &7310, &732c, &733a, &73f0, &752f, &766a, &777d, &779b, &77ad, &77bf, &77d1, &7801, &7820, &7867, &7872, &787c, &789e, &78b8, &78d2, &78ec, &7910, &791d, &794c, &7959, &797b, &7997, &79d0, &79ea, &7a48, &7b07, &7b44
cell_y                = &0d03  ; Map y of the cell being drawn, tested or moved to. plot_at_cell replaces it with the pixel offset within the room.
; &0d03 referenced 55 times by &11a1, &11f9, &1cd1, &1ce6, &1d20, &1d42, &1d49, &1d7a, &1dd7, &1e3e, &1e50, &1f5e, &1fb0, &1fdc, &209a, &20ad, &20d0, &20db, &20ec, &20f7, &6fad, &7017, &7082, &70b0, &70f4, &7126, &7161, &717e, &71eb, &7316, &7332, &7345, &73fc, &7535, &7670, &7783, &7807, &7852, &787f, &7890, &78a5, &78bf, &78d9, &78f3, &78fc, &7929, &7938, &7965, &7983, &799f, &79d6, &79f3, &7a4e, &7b0d, &7b4a
cell_room             = &0d04  ; Room of the cell being drawn, as an offset into room_walls.
; &0d04 referenced 7 times by &7864, &786c, &786f, &7896, &78b0, &78ca, &78e4
previous_x            = &0d06  ; Map x of the creature being moved, before the move.
; &0d06 referenced 11 times by &6e9a, &6f56, &6fbb, &6fe5, &7021, &7069, &7079, &79ed, &7a58, &7a95, &7af8
previous_y            = &0d07  ; Map y of the creature being moved, before the move.
; &0d07 referenced 11 times by &6ea0, &6f5c, &6fc1, &6feb, &7027, &706f, &707f, &79f6, &7a5e, &7a9b, &7afe
previous_offset_x     = &0d08  ; Pixel offset of the hero being moved, before the move.
; &0d08 referenced 2 times by &6ea6, &7085
previous_offset_y     = &0d09  ; Pixel offset of the hero being moved, before the move.
; &0d09 referenced 2 times by &6eac, &708a
hero_x                = &0d10  ; Map x of each hero.
; &0d10 used as index base 29 times by &06e7, &1dfd, &1e35, &1e89, &1f38, &1f55, &1f74, &2091, &6e97, &6f39, &6f59, &6f87, &6f95, &6f98, &6fa4, &6fbe, &6fe8, &700c, &7024, &706c, &70a7, &71e0, &7329, &73ed, &752c, &777a, &799a, &7bbd, &7bcb
hero_y                = &0d15  ; Map y of each hero.
; &0d15 used as index base 27 times by &1e03, &1e3b, &1e8f, &1f40, &1f5b, &2097, &6e9d, &6f3f, &6f5f, &6f80, &6f8e, &6f9e, &6faa, &6fc4, &6fee, &7014, &702a, &7072, &70ad, &71e8, &732f, &73f9, &7532, &7780, &79a2, &7bb6, &7bc4
hero_direction        = &0d1a  ; Direction each hero faces: 1 up, 3 right, 5 down, 7 left; 0 when the hero is not in play.
; &0d1a used as index base 18 times by &06d0, &1de6, &1f52, &6e82, &6ecb, &6ede, &6ef1, &6f04, &6f2d, &6f79, &701c, &7097, &7221, &7249, &7452, &7711, &7b67, &7baf
hero_frame            = &0d20  ; Animation frame of each hero (0 or 1), added to its sprite.
; &0d20 referenced 2 times by &774e, &7753; also used as index base 12 times by &06da, &1df3, &6f62, &6f67, &709c, &7457, &76ee, &76ff, &771f, &772e, &7ba2, &7ba7
hero_step             = &0d25  ; Frames left in each hero's step between cells.
; &0d25 used as index base 12 times by &06d5, &1f4d, &6e87, &6eaf, &6fc9, &6ff3, &702f, &7063, &7401, &7716, &7b64, &7baa
hero_offset_x         = &0d2a  ; Each hero's horizontal pixel offset while between cells.
; &0d2a used as index base 19 times by &6ea3, &6fcc, &6ff6, &7032, &705d, &724e, &7404, &745c, &7702, &7719, &7735, &7b70, &7b84, &7b8e, &7b9e, &7bd0, &7bd7, &7bda, &7bdd
hero_offset_y         = &0d30  ; Each hero's vertical pixel offset while between cells.
; &0d30 used as index base 20 times by &6ea9, &6fcf, &6ff9, &7035, &7060, &7251, &7407, &7461, &76da, &76e2, &771c, &773a, &7b75, &7b7f, &7b93, &7b99, &7bd3, &7be1, &7be4, &7be7
missile_x             = &0d40  ; Map x of each missile (12 slots, three per hero).
; &0d40 used as index base 6 times by &6f3c, &70eb, &710c, &711a, &711d, &7158
missile_y             = &0d4c  ; Map y of each missile.
; &0d4c used as index base 6 times by &6f42, &70f1, &7105, &7113, &7123, &715e
missile_direction     = &0d58  ; Direction of each missile: 1 up, 2 right, 3 down, 4 left; bit 7 set for a missile just fired; 0 for an empty slot.
; &0d58 used as index base 12 times by &6f28, &6f36, &70d2, &70de, &70fe, &7134, &71a5, &71ae, &71ba, &71c6, &71ce, &720c
set_wrchv_low         = &0d63
missile_sprite_base   = &0d64  ; Sprite base of each missile, to which its direction is added; also identifies the hero who fired it.
; &0d64 used as index base 4 times by &6f53, &7209, &76b1, &7747
hero_key_up           = &0d70  ; INKEY key number of each hero's up key.
; &0d70 used as index base 1 time by &6ec1
hero_key_down         = &0d74  ; INKEY key number of each hero's down key.
; &0d74 used as index base 1 time by &6ed4
hero_key_right        = &0d78  ; INKEY key number of each hero's right key.
; &0d78 used as index base 1 time by &6ee7
hero_key_left         = &0d7c  ; INKEY key number of each hero's left key.
; &0d7c used as index base 1 time by &6efa
hero_key_fire         = &0d80  ; INKEY key number of each hero's fire key.
; &0d80 used as index base 1 time by &6f0d
hero_health_tens      = &0d90  ; Health tens digit, as a digit sprite (&1E-&27); &1D when the hero is dead.
; &0d90 used as index base 10 times by &06df, &0e6d, &7236, &7239, &726f, &738e, &7391, &739a, &7506, &7724
hero_health_units     = &0d95  ; Health units digit, as a digit sprite.
; &0d95 used as index base 7 times by &7227, &722a, &7233, &727b, &739d, &750f, &7727
view_room             = &0da0  ; The room each hero's view shows: a pointer into room_walls, low byte then high byte, for each hero in turn (hero x at view_room + 2x).
; &0da0 referenced 2 times by &779e, &7893; also used as index base 3 times by &7043, &7544, &767c
hero_missile_sprites  = &0db0  ; Sprite base of each hero's missiles: arrows, fireballs, axes, swords.
; &0db0 used as index base 1 time by &6f50
hero_sprites          = &0db5  ; Sprite base of each hero, to which direction and frame are added.
; &0db5 used as index base 4 times by &1fcb, &1ffd, &2051, &709f
hero_has_boots        = &0dbc  ; Non-zero while the hero wears Boots of Speed.
; &0dbc used as index base 3 times by &7056, &7351, &74e7
bit_masks             = &0dc0  ; Bit masks for the cells of a room row, left to right: &80, &40 ... &01.
; &0dc0 used as index base 3 times by &1d72, &7923, &795f
hero_panel_y          = &0dd0  ; Pixel row of each hero's section of the status panel.
; &0dd0 used as index base 10 times by &1d9c, &1e12, &1e6d, &20bc, &7266, &72bd, &75af, &75cf, &75e7, &75fe
teleport_last         = &0dfd  ; Index of the last object to search when looking backwards for a teleporter (&1E, from workspace_template).
; &0dfd referenced 1 time by &73d3
victory_sprite_copy   = &0dff  ; Written by draw_victory_ring; not read.
; &0dff referenced 1 time by &1160
level_object_x        = &6b00  ; Level file: Objects' map x (entries 1-30, entry 30 the exit).
; &6b00 used as index base 1 time by &1573
level_object_y        = &6b20  ; Level file: Objects' map y.
; &6b20 used as index base 1 time by &1579
level_object_type     = &6b40  ; Level file: Objects' types.
; &6b40 used as index base 1 time by &157f
level_door_x          = &6b60  ; Level file: Doors' map x (entries 1-20).
; &6b60 used as index base 1 time by &158a
level_door_y          = &6b75  ; Level file: Doors' map y.
; &6b75 used as index base 1 time by &1590
level_door_sprite     = &6b8a  ; Level file: Doors' sprites.
; &6b8a used as index base 1 time by &1596
level_key_x           = &6ba0  ; Level file: Keys' map x (entries 1-20).
; &6ba0 used as index base 1 time by &15a1
level_key_y           = &6bb5  ; Level file: Keys' map y.
; &6bb5 used as index base 1 time by &15a7
level_trapdoor_x      = &6bd0  ; Level file: Trapdoors' map x (entries 0-7).
; &6bd0 used as index base 1 time by &15b2
level_trapdoor_y      = &6bd8  ; Level file: Trapdoors' map y.
; &6bd8 used as index base 1 time by &15b8
level_walls           = &6be0  ; Level file: Wall map (&C9 bytes used).
; &6be0 used as index base 1 time by &15c5
level_object_free_map = &6cb0  ; Level file: Map of cells without objects (&C9 bytes used).
; &6cb0 used as index base 1 time by &15cb
level_wall_sprite     = &6d80  ; Level file: The level's wall block, copied to wall_sprite.
; &6d80 used as index base 1 time by &15d8
saved_page_0d         = &c400  ; The MOS's page &0D (the filing system's NMI code and workspace), saved here by Coder and copied back by load_level before each level is loaded.
; &c400 used as index base 2 times by &0748, &1485
mos120_reset_entry    = &d9cd  ; The MOS 1.20 reset entry, which decrypt_level calls on a failed checksum. On a Master, with private RAM paged in, it is HAZEL.
; &d9cd referenced 1 time by &0481
mos120_oswrch_default = &e0a4  ; MOS 1.20's default OSWRCH routine, where the unused handler would pass characters on; MOS 3.20's is elsewhere.
; &e0a4 referenced 2 times by &7fd7, &7ffc
mos320_oswrch_default = &e822  ; MOS 3.20's default OSWRCH routine, WRCHV's initial value.
; &e822 referenced 1 time by &7f8f
mos320_osbyte_default = &eeb1  ; MOS 3.20's default OSBYTE routine, BYTEV's initial value.
; &eeb1 referenced 2 times by &c518, &c569
system_via_t1c_l      = &fe44
; &fe44 referenced 3 times by &11be, &7a6f, &7aac
osrdch                = &ffe0
; &ffe0 referenced 2 times by &058f, &10d7
osasci                = &ffe3
; &ffe3 referenced 3 times by &0eb1, &10bd, &10ca
oswrch                = &ffee
; &ffee referenced 54 times by &0502, &0507, &050c, &0511, &0516, &051b, &0530, &0536, &053d, &0544, &076f, &07c2, &07c7, &0e8d, &0e92, &0e97, &0e9c, &0ea1, &109c, &10a1, &10a6, &10ab, &10b0, &10b5, &112d, &1430, &1435, &143a, &143f, &1444, &1447, &144a, &144d, &1450, &1453, &14c1, &14c6, &14cb, &14d0, &14d5, &14d8, &14db, &14de, &14e1, &14e4, &1548, &154f, &161b, &1620, &1625, &162a, &162f, &1634, &c605
osword                = &fff1
; &fff1 referenced 24 times by &16a6, &16af, &1d18, &1ead, &1eb6, &736d, &7376, &73b9, &73e3, &748c, &74a9, &74b2, &7586, &7634, &763d, &c706, &c70f, &c718, &c721, &c790, &c7a2, &c7d4, &c7dd, &c7e6
osbyte                = &fff4
; &fff4 referenced 23 times by &0583, &058c, &05ed, &07d6, &07df, &07e8, &07f1, &0ec0, &0ec9, &10d4, &10ed, &1128, &7c9e, &c51f, &c52d, &c53c, &c54a, &c559, &c6d2, &c6de, &c6f0, &c75a, &c766
oscli                 = &fff7
; &fff7 referenced 7 times by &0752, &0759, &0760, &0767, &14f5, &c5a4, &c6c4
reset_vector          = &fffc  ; 6502 RESET vector, in the MOS ROM.
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
    lda hero_score_thousands,x          ; ...and check the new digit
    cmp #spr_digit_9 + 1                ; Past 9?
    bne add_thousand_points_done        ; No: return
    lda #spr_digit_0                    ; Yes: thousands 0...
    sta hero_score_thousands,x          ; ...stored for this hero
    inc hero_score_ten_thousands,x      ; ...and add one to the ten-thousands digit
    lda hero_score_ten_thousands,x      ; ...and check the new digit
    cmp #spr_small_digit_9 + 1          ; Past 9?
    bne draw_ten_thousands              ; No: draw ten thousands
    lda #spr_small_digit_9              ; Yes: keep it at 9
    sta hero_score_ten_thousands,x      ; ...stored for this hero
; &041e referenced 2 times by &0417, &06c2
.draw_ten_thousands
    sta sprite_number                   ; Plot it below the score...
    lda #panel_left                     ; ...at the panel's left column
    sta plot_x                          ; ...as the plot column
    lda workspace_template + 208,x      ; ...this hero's panel row, from the template
    clc                                 ; ...(carry clear for the add)
    adc #&18                            ; ...+ &18 rows: below the score
    sta plot_y                          ; ...as the plot row
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack while plotting
    jsr plot_sprite                     ; Plot the ten-thousands digit
    lda #spr_small_digit_8              ; ...with four of sprite &71 beside it
    sta sprite_number                   ; ...as the sprite to plot
    ldy #4                              ; ...four times
; &0437 referenced 1 time by &0443
.draw_ten_thousands_loop
    tya                                 ; Keep the count...
    pha                                 ; ...on the stack while plotting
    inc plot_x                          ; Two byte columns right...
    inc plot_x                          ; ...(second step)
    jsr plot_sprite                     ; Plot sprite &71 there
    pla                                 ; Recover the count...
    tay                                 ; ...into Y
    dey                                 ; One fewer to plot
    bne draw_ten_thousands_loop         ; More to plot: loop
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
; &0447 referenced 1 time by &0408
.add_thousand_points_done
    rts                                 ; Return
; ***************************************************************************************
; Unused
;
; Zero bytes, which nothing reads.
    equb &00, &00, &00, &00, &00, &00, &00, &00  ; Zeros
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
    lda #>(level_object_x)              ; High byte &6B: the level buffer's page
    sta plot_y                          ; ...high byte
; &045a referenced 2 times by &046f, &0475
.decrypt_level_loop
    lda (plot_x),y                      ; Fetch a byte...
    eor plot_x                          ; ...XOR it with the low byte of its address...
    sta (plot_x),y                      ; ...and store it back decrypted
    clc                                 ; Add it to the sum
    adc sprite_width                    ; ...plus the sum so far
    sta sprite_width                    ; ...kept in sprite_width
    inc plot_x                          ; Next byte...
    bne decrypt_level_next              ; No carry: same page
    inc plot_y                          ; ...with carry into the high byte
; &046b referenced 1 time by &0467
.decrypt_level_next
    lda plot_x                          ; Stop at &6DB0, the end of the level...
    cmp #<(level_file_end)              ; ...low byte &B0?
    bne decrypt_level_loop              ; No: decrypt the next byte
    lda plot_y                          ; ...and high byte &6D?
    cmp #>(level_file_end)              ; ...(the end page)
    bne decrypt_level_loop              ; No: decrypt the next byte
    ldx level_number                    ; X = level number
    lda sprite_width                    ; Compare the sum...
    cmp level_checksums,x               ; ...with this level's checksum
    beq decrypt_level_done              ; Match: return
    jsr mos120_reset_entry              ; No match: call &D9CD, private RAM that no file fills
; &0484 referenced 1 time by &047f
.decrypt_level_done
    rts                                 ; Return
; ***************************************************************************************
; Unused
;
; Zero bytes, which nothing reads.
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00  ; Zeros
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
    equb &71, &b2, &6f, &f3, &f1        ; Levels 1-25, five to a row
; ***************************************************************************************
; Unused
;
; Zero bytes, which nothing reads.
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00  ; Zeros
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00  ; Zeros
    equb &00, &00, &00, &00, &00        ; Zeros
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
    equb &00                            ; Not referenced
; ***************************************************************************************
; Choose the heroes and the sound
;
; Clear the left of the screen, print the menu and let the players toggle each hero (keys
; 1-4) and the sound (5 on, 6 off). SPACE starts the game if at least one hero is
; playing.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &0500 referenced 1 time by &0e11
.hero_menu
    lda #&1c                            ; VDU 28: a text window over the left of the screen...
    jsr oswrch                          ; Send VDU 28
    lda #0                              ; Left column 0
    jsr oswrch                          ; Send the left column
    lda #&18                            ; Bottom row 24
    jsr oswrch                          ; Send the bottom row
    lda #&13                            ; Right column 19
    jsr oswrch                          ; Send the right column
    lda #0                              ; Top row 0
    jsr oswrch                          ; Send the top row
    lda #&0c                            ; ...VDU 12 to clear it
    jsr oswrch                          ; Send VDU 12: clear the window
    jsr print_menu                      ; Print the menu
    jmp menu_key_loop                   ; Read the players' choices
; ***************************************************************************************
; Print the menu text
;
; Print the sixteen positioned strings of menu_text.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &0524 referenced 3 times by &051e, &05c3, &05f0
.print_menu
    ldx #&0f                            ; Fifteen strings, then one more by falling through
    ldy #0                              ; Y walks through menu_text from its start
; &0528 referenced 1 time by &052c
.print_menu_loop
    jsr print_menu_string               ; Print one menu string
    dex                                 ; One fewer to print
    bne print_menu_loop                 ; More to print: loop
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
    jsr oswrch                          ; Send VDU 31
    lda menu_text,y                     ; ...to the string's column...
    jsr oswrch                          ; Send the column
    iny                                 ; Step to the row byte
    lda menu_text,y                     ; ...and row
    jsr oswrch                          ; Send the row
; &0540 referenced 1 time by &0549
.print_menu_string_loop
    iny                                 ; Print the characters...
    lda menu_text,y                     ; ...the next character...
    jsr oswrch                          ; ...printed
    cmp #&0d                            ; ...up to and including the carriage return
    bne print_menu_string_loop          ; Not the CR yet: next character
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
    lda #'N'                            ; "NO "
    sta menu_text,y                     ; ...into the entry's first letter
    lda #'O'                            ; O second...
    sta menu_text + 1,y                 ; ...into the second letter
    lda #' '                            ; A space third, over YES's S...
    sta menu_text + 2,y                 ; ...into the third letter
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
    lda #'Y'                            ; "YES"
    sta menu_text,y                     ; ...into the entry's first letter
    lda #'E'                            ; E second...
    sta menu_text + 1,y                 ; ...into the second letter
    lda #'S'                            ; S third...
    sta menu_text + 2,y                 ; ...into the third letter
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
    lda #'F'                            ; "FF" after the O
    sta menu_text,y                     ; ...over the N of ON...
    sta menu_text + 1,y                 ; ...and the space after it
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
    lda #'N'                            ; "N " after the O
    sta menu_text,y                     ; ...over OFF's first F
    lda #' '                            ; A space...
    sta menu_text + 1,y                 ; ...over OFF's second F
    rts                                 ; Return
; &0581 referenced 6 times by &0521, &0598, &059c, &05c6, &05d3, &05f3
.menu_key_loop
    lda #osbyte_flush_buffer_class      ; Flush the input buffers
    jsr osbyte                          ; Discard keys pressed before the menu  Flush selected class of buffer
    lda #osbyte_kbd_status              ; OSBYTE &CA: keyboard status &20, CAPS LOCK on and SHIFT LOCK off
    ldx #&20 ; ' '                      ; X = &20: CAPS LOCK on, SHIFT LOCK off
    ldy #0                              ; Y = 0: replace the status with X
    jsr osbyte                          ; Set it: CAPS LOCK on, so the menu reads capitals  osbyte: kbd status
    jsr osrdch                          ; Wait for a key
    cmp #' '                            ; SPACE?
    beq menu_space                      ; Yes: start, if anyone is playing
    cmp #'1'                            ; Ignore anything but 1-6
    bcc menu_key_loop                   ; Below '1': ignore it
    cmp #'7'                            ; Above '6'?
    bcs menu_key_loop                   ; Yes: ignore it
    sec                                 ; X = 0-5
    sbc #'1'                            ; Key '1'-'6' becomes 0-5...
    tax                                 ; ...in X
    cmp #4                              ; 5 or 6: the sound
    bcs menu_sound_key                  ; Yes: the sound switch
    asl a                               ; 1-4: Y = offset of the hero's YES/NO, 6 x X + &51...
    sta plot_x                          ; Keep 2 x the hero number
    asl a                               ; 4 x the hero number...
    clc                                 ; ...(carry clear for the add)
    adc plot_x                          ; ...+ 2 x: 6 x the hero number
    adc #&51 ; 'Q'                      ; ...+ &51: this hero's YES/NO text
    tay                                 ; Y = its offset in menu_text
    lda hero_absent,x                   ; Toggle the hero
    eor #1                              ; ...by flipping the absent flag
    sta hero_absent,x                   ; ...stored back
    bne menu_hero_off                   ; Now absent?
    jsr set_menu_yes                    ; No: YES
    jmp menu_reprint                    ; ...then reprint
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
    lda hero_absent,x                   ; This hero switched off?
    beq menu_done                       ; Yes: return and start
    dex                                 ; Yes: try the previous hero
    bpl menu_space_check_hero           ; Heroes left to check: loop
    jmp menu_key_loop                   ; No: next key
; &05d6 referenced 1 time by &05ce
.menu_done
    rts                                 ; Return
; &05d7 referenced 1 time by &05a4
.menu_sound_key
    ldy #&99                            ; Sound: Y = offset of the second letter of ON/OFF
    cmp #5                              ; Key 6 (A = key - "1")?
    beq menu_sound_off                  ; Yes: menu sound off
    jsr set_menu_on                     ; Key 5: ON...
    ldx #0                              ; ...with X = 0 to enable the sound
    beq menu_set_sound                  ; Always: set the sound
; &05e4 referenced 1 time by &05db
.menu_sound_off
    jsr set_menu_off                    ; Key 6: OFF...
    ldx #1                              ; ...with X = 1 to suppress it
; &05e9 referenced 1 time by &05e2
.menu_set_sound
    lda #osbyte_sound_suppression       ; OSBYTE &D2: sound suppression
    ldy #0                              ; Y = 0: replace the setting with X
    jsr osbyte                          ; Turn the sound on or off as chosen  osbyte: sound suppression
    jsr print_menu                      ; Reprint the menu
    jmp menu_key_loop                   ; Next key
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &4f                       ; Not referenced
; ***************************************************************************************
; Hero menu text
;
; Sixteen entries of: column, row, text, carriage return; printed by print_menu.
; &0600 used as index base 7 times by &0533, &053a, &0541, &054f, &055f, &056f, &0578
.menu_text
; &0601 used as index base 4 times by &0554, &0564, &0572, &057d
    equb &06, &00                       ; Column 6, row 0
; &0602 used as index base 2 times by &0559, &0569
    equs "DUNJUNZ", &0d
    equb &00, &02                       ; Column 0, row 2
    equs "HERO", &0d
    equb &0c, &02                       ; Column 12, row 2
    equs "PLAYING", &0d
    equb &00, &04                       ; Column 0, row 4
    equs "1 RANGER", &0d
    equb &00, &05                       ; Column 0, row 5
    equs "2 MAGIC-USER", &0d
    equb &00, &06                       ; Column 0, row 6
    equs "3 BARBARIAN", &0d
    equb &00, &07                       ; Column 0, row 7
    equs "4 FIGHTER", &0d
    equb &0e, &04                       ; Column 14, row 4
    equs "YES", &0d
    equb &0e, &05                       ; Column 14, row 5
    equs "YES", &0d
    equb &0e, &06                       ; Column 14, row 6
    equs "YES", &0d
    equb &0e, &07                       ; Column 14, row 7
    equs "YES", &0d
    equb &00, &09                       ; Column 0, row 9
    equs "TYPE NUMBER", &0d
    equb &00, &0a                       ; Column 0, row 10
    equs "TO TOGGLE", &0d
    equb &00, &0d                       ; Column 0, row 13
    equs "SOUND ON(5) OFF(6)", &0d
    equb &07, &0f                       ; Column 7, row 15
    equs "ON ", &0d
    equb &03, &14                       ; Column 3, row 20
    equs "SPACE TO PLAY", &0d
    equb &00, &0d, &a9, &63             ; Not referenced
; ***************************************************************************************
; Take the heroes nobody plays out of the game
;
; Draw any ten-thousands score digits, then put every hero switched off on the menu out
; of play, with a &64 entry in returning_hero_queue in their place.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &06b0 referenced 1 time by &0e5d
.remove_absent_heroes
    ldx #0                              ; For each hero, keeping a count of absent heroes in Y...
    ldy #0                              ; ...in Y, which also indexes the queue
; &06b4 referenced 1 time by &06f3
.remove_absent_heroes_loop
    lda hero_score_ten_thousands,x      ; Score of 10000 or more?
    cmp #spr_small_digit_1              ; ...digit sprite at least that for 1?
    bcc remove_absent_heroes_check      ; No: remove absent heroes check
    txa                                 ; Yes: draw the ten-thousands digit
    pha                                 ; Keep the hero number...
    tya                                 ; ...and the absent count...
    pha                                 ; ...on the stack
    lda hero_score_ten_thousands,x      ; The digit's sprite...
    jsr draw_ten_thousands              ; ...drawn below the score
    pla                                 ; Recover the absent count...
    tay                                 ; ...into Y
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
; &06c9 referenced 1 time by &06b9
.remove_absent_heroes_check
    lda hero_absent,x                   ; Switched off on the menu?
    beq remove_absent_heroes_next       ; No: remove absent heroes next
    lda #0                              ; Yes: out of play...
    sta hero_direction,x                ; ...direction 0: not in play
    lda #step_out_of_play               ; ...never to be animated (step &63)...
    sta hero_step,x                     ; ...as the hero's step count
    lda #8                              ; ...frame 8...
    sta hero_frame,x                    ; ...as the hero's frame
    lda #spr_digit_0 - 1                ; ...dead...
    sta hero_health_tens,x              ; ...as the health tens digit
    dec hero_score_units,x              ; ...score units digit back one...
    lda #&1f                            ; ...at x &1F...
    sta hero_x,x                        ; ...as the hero's map x
    lda #nobody_returns                 ; ...and a &64 marker in the returning queue
    sta returning_hero_queue,y          ; ...in the next queue entry
    iny                                 ; One more absent hero
; &06f0 referenced 1 time by &06cc
.remove_absent_heroes_next
    inx                                 ; Next hero
    cpx #4                              ; All four heroes done?
    bne remove_absent_heroes_loop       ; No: next hero
    rts                                 ; Return
; ***************************************************************************************
; Unused
;
; Zero bytes, which nothing reads.
    equb &00, &00                       ; Zeros
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
; earlier lines and the fragment of BBC BASIC assembler (label+2:LDA#255:.label JSR&30).
.line_buffer_leftovers
    equs "*SA. CODER 400+3FF 740"
    equb &0d                            ; CR: the end of that line
    equs " 740"
    equb &0d, &54, &50, &0d, &0d, &50, &0d  ; Ends of shorter lines
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
.save_page_0d_byte
    lda scratch,x                       ; ...each byte the filing system uses...
    sta saved_page_0d,x                 ; ...to &C400 in private RAM
    dex                                 ; ...next byte (X wraps from 0)
    bne save_page_0d_byte               ; Until all 256 are saved
    ldx #<(load_dunj2_command)          ; *L. DUNJ2 (&6E80-&7FFF)
    ldy #>(load_dunj2_command)          ; ...high byte of the command
    jsr oscli                           ; ...load &6E80-&7FFF
    ldx #<(load_dunj3_command)          ; *L. DUNJ3 (&08C0-&0CFE)
    ldy #>(load_dunj3_command)          ; ...high byte of the command
    jsr oscli                           ; ...load &08C0-&0CFE
    ldx #<(load_dunj4_command)          ; *L. DUNJ4 (&0E00-&1FFF)
    ldy #>(load_dunj4_command)          ; ...high byte of the command
    jsr oscli                           ; ...load &0E00-&1FFF
    ldx #<(load_dunj5_command)          ; *L. DUNJ5 (&2000-&2FFF)
    ldy #>(load_dunj5_command)          ; ...high byte of the command
    jsr oscli                           ; ...load &2000-&2FFF
    ldx #0                              ; Send the 21 bytes of coder_display_vdu
; &076c referenced 1 time by &0775
.send_coder_vdu
    lda coder_display_vdu,x             ; ...the next VDU byte...
    jsr oswrch                          ; ...to the VDU
    inx                                 ; ...on to the next
    cpx #coder_leftovers - coder_display_vdu  ; ...until all of coder_display_vdu is sent
    bne send_coder_vdu                  ; More to send
    jmp select_colour_2                 ; ...then colour 2 and a new game
.load_dunj2_command
    equs "L. DUNJ2", &0d
.load_dunj3_command
    equs "L. DUNJ3", &0d
.load_dunj4_command
    equs "L. DUNJ4", &0d
.load_dunj5_command
    equs "L. DUNJ5", &0d
; &079e used as index base 1 time by &076c
.coder_display_vdu
    equb &06                            ; VDU 6: enable VDU output
    equb &17, &00, &06, &19, &00, &00, &00, &00, &00, &00  ; VDU 23,0,6,25: 6845 register 6 = 25 character rows displayed
    equb &17, &00, &01, &50, &00, &00, &00, &00, &00, &00  ; VDU 23,0,1,80: 6845 register 1 = 80 characters per row
; ***************************************************************************************
; Unused
;
; Leftover bytes, all zero.
.coder_leftovers
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
; &07c0 referenced 1 time by &0777
.select_colour_2
    lda #&11                            ; COLOUR 2...
    jsr oswrch                          ; ...VDU 17...
    lda #2                              ; ...text colour 2...
    jsr oswrch                          ; ...for the game's messages
    jmp new_game                        ; ...and start a new game
    equb &00, &00, &00                  ; Not referenced
; ***************************************************************************************
; Set the bell sound
;
; OSBYTEs &D3-&D6: the BEL character's sound on channel &13, envelope 0 (fixed
; amplitude), pitch &64, duration 1.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &07d0 referenced 1 time by &0740
.set_bell
    lda #osbyte_bell_channel            ; OSBYTE &D3: bell channel...
    ldx #&13                            ; ...&13
    ldy #0                              ; ...Y = 0: X replaces the old setting
    jsr osbyte                          ; ...the bell's sound channel  osbyte: bell channel
    lda #osbyte_bell_envelope           ; OSBYTE &D4: bell envelope...
    ldx #0                              ; ...0, a fixed amplitude
    ldy #0                              ; ...Y = 0: X replaces the old setting
    jsr osbyte                          ; ...the bell's envelope  osbyte: bell envelope
    lda #osbyte_bell_frequency          ; OSBYTE &D5: bell pitch...
    ldx #&64 ; 'd'                      ; ...&64
    ldy #0                              ; ...Y = 0: X replaces the old setting
    jsr osbyte                          ; ...the bell's pitch  osbyte: bell frequency
    lda #osbyte_bell_duration           ; OSBYTE &D6: bell duration...
    ldx #1                              ; ...1
    ldy #0                              ; ...Y = 0: X replaces the old setting
    jsr osbyte                          ; ...the bell's duration  osbyte: bell duration
    rts                                 ; Return
; ***************************************************************************************
; Leftover filename
;
; The end of the filename "Dunjunz1", whose start set_bell overwrites.
    equs "nz1"
    equb &0d, &00, &00, &00, &00, &00, &00  ; Not referenced
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
    equb &00, &00, &ff, &80, &80, &00, &00, &00  ; Not referenced
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
; start_music overwrites the first three bytes with JMP &D800, so from the first level on every sprite is plotted by the identical copy in Code3, plot_sprite_hazel. The menu, before start_music first runs, uses this one.
; &0900 referenced 21 times by &042e, &043d, &0f79, &1daa, &1e20, &1e7d, &20ca, &7276, &7286, &72cf, &72df, &72ef, &72ff, &7613, &7838, &7842, &78aa, &78c4, &78de, &78f8, &c726
.plot_sprite
; &0901 referenced 1 time by &c72b
    ldx sprite_number                   ; X = sprite number
; &0902 referenced 1 time by &c730
    lda sprite_addr_lo,x                ; Point sprite_data_ptr at the sprite's data...
    sta sprite_data_ptr                 ; ...low byte
    lda sprite_addr_hi,x                ; ...high byte from its own table
    sta sprite_data_ptr_hi              ; ...into sprite_data_ptr
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
    sta row_start_ptr                   ; ...low byte
    lda screen_ptr_hi                   ; ...and high byte...
    sta row_start_ptr_hi                ; ...in row_start_ptr
    txa                                 ; Save the row count
    pha                                 ; ...on the stack: X now counts bytes
    ldx sprite_width                    ; X counts the bytes across this row
; &0929 referenced 1 time by &093f
.plot_sprite_byte
    lda (sprite_data_ptr),y             ; Copy one sprite byte...
    sta (screen_ptr),y                  ; ...to the screen
    clc                                 ; Step screen_ptr right one byte column: 8 bytes on
    lda screen_ptr                      ; ...the screen address's low byte...
    adc #8                              ; ...+ 8, the next byte column...
    sta screen_ptr                      ; ...stored back
    bcc plot_sprite_next_data           ; No carry: the high byte stands
    inc screen_ptr_hi                   ; ...with carry into the high byte
; &0938 referenced 1 time by &0934
.plot_sprite_next_data
    inc sprite_data_ptr                 ; Next sprite data byte
    bne plot_sprite_count_byte          ; No carry: the high byte stands
    inc sprite_data_ptr_hi              ; ...with carry into the high byte
; &093e referenced 1 time by &093a
.plot_sprite_count_byte
    dex                                 ; Count the bytes across
    bne plot_sprite_byte                ; Loop until the row is done
    clc                                 ; screen_ptr = row start + 1: the next pixel row down
    lda row_start_ptr                   ; The row start's low byte...
    adc #1                              ; ...+ 1...
    sta screen_ptr                      ; ...is the new low byte
    lda row_start_ptr_hi                ; The row start's high byte...
    adc #0                              ; ...plus the carry...
    sta screen_ptr_hi                   ; ...is the new high byte
    lda screen_ptr                      ; Has it crossed into the next character row?
    and #7                              ; ...(pixel row within the character now 0)
    bne plot_sprite_next_row            ; No: carry on
    clc                                 ; Yes: add 640-8 to reach the top pixel row of the...
    lda screen_ptr                      ; ...character row below
    adc #&78 ; 'x'                      ; ...low byte + &78 (640 - 8 = &278)...
    sta screen_ptr                      ; ...stored
    lda screen_ptr_hi                   ; ...high byte...
    adc #2                              ; ...+ 2 and the carry...
    sta screen_ptr_hi                   ; ...stored
; &0961 referenced 1 time by &0952
.plot_sprite_next_row
    pla                                 ; Recover the row count
    tax                                 ; ...back into X
    dex                                 ; Count the pixel rows
    bne plot_sprite_row                 ; Loop until the sprite is done
    rts                                 ; Return
; ***************************************************************************************
; Calculate a screen address
;
; Set screen_ptr to the screen address of byte column plot_x on pixel row plot_y: &3000 +
; 640 x (plot_y DIV 8) + (plot_y MOD 8) + 8 x plot_x. The multiplication by 640 uses
; row_offsets in Table, a copy of the MOS 1.20 table, in private RAM.
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
    lsr a                               ; ...halved...
    lsr a                               ; ...and halved again...
    and #&fe                            ; ...times 2 to index the table's byte pairs
    tay                                 ; ...as the index into the MOS table
    lda row_offsets,y                   ; High byte of row x 640, from Table's copy of the MOS 1.20 table in private RAM...
    clc                                 ; ...(carry clear for the add)
    adc #>(screen_start)                ; ...plus &30: the screen starts at &3000
    sta screen_ptr_hi                   ; ...as the screen address high byte
    lda row_offsets_lo,y                ; Low byte of row x 640
    sta screen_ptr                      ; ...as the low byte
    lda plot_y                          ; Add the pixel row within the character...
    and #7                              ; ...plot_y MOD 8...
    adc screen_ptr                      ; ...(no carry: the low byte is &00 or &80)
    sta screen_ptr                      ; ...stored in the low byte
    clc                                 ; Add 8 x plot_x: first its top three bits...
    lda plot_x                          ; ...from plot_x...
    and #&e0                            ; ...bits 7-5 kept...
    rol a                               ; ...rotated down to bits 0-2...
    rol a                               ; ...bit 7 into bit 0 via the carry
    rol a                               ; ...then bit 6; bit 7 to bit 1
    rol a                               ; ...bits 7-5 now in bits 2-0
    clc                                 ; ...(carry clear for the add)
    adc screen_ptr_hi                   ; ...into the high byte
    sta screen_ptr_hi                   ; ...stored
    lda plot_x                          ; ...then plot_x x 8 into the low byte
    asl a                               ; ...x 2...
    asl a                               ; ...x 4...
    asl a                               ; ...x 8, its top bits dropping out
    clc                                 ; ...(carry clear for the add)
    adc screen_ptr                      ; ...added to the low byte
    sta screen_ptr                      ; ...stored
    bcc screen_address_done             ; No carry: done
    inc screen_ptr_hi                   ; ...with carry into the high byte
; &099f referenced 1 time by &099b
.screen_address_done
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
    equb &00, &00, &00, &00, &00, &00, &00, &00  ; Not referenced
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
    equb &10, &10, &10, &10, &10, &10, &10  ; Not referenced
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
    equw &0013, &0004, &0064, &001e     ; SOUND channel 3 (flush), envelope 4, pitch 100, duration 30
.food_sound
; &0bfc referenced 2 times by &1d0f, &1d1d
    equw &0013, &0002, &00c8, &0002     ; SOUND channel 3 (flush), envelope 2, pitch 200, duration 2
; &0c00 used as index base 3 times by &15c8, &7fc8, &7feb
.room_walls
    equb &54, &49, &4b, &50, &24, &55, &54, &48, &4f, &5b, &4b, &46, &2c, &44, &5d, &2f  ; Not read: unpack_level copies each level's wall map here
    equb &44, &59, &57, &33, &43, &5a, &44, &5c, &38, &56, &5c, &3b, &56, &48, &52, &56  ; ...entries 16-31, not read
    equb &61, &6f, &02, &62, &72, &6c, &75, &07, &00, &6a, &03, &0b, &1d, &14, &16, &19  ; ...entries 32-47, not read
    equb &10, &70, &67, &74, &61, &66, &62, &19, &71, &19, &72, &7a, &6a, &78, &1e, &78  ; ...entries 48-63, not read
    equb &09, &17, &07, &0d, &64, &0b, &09, &05, &07, &0d, &13, &6b, &1c, &08, &1c, &02  ; ...entries 64-79, not read
    equb &19, &02, &01, &1a, &1b, &1b, &76, &03, &17, &79, &17, &1a, &0e, &16, &1b, &0b  ; ...entries 80-95, not read
    equb &40, &35, &2a, &2a, &37, &45, &21, &26, &25, &2c, &4a, &32, &29, &39, &4e, &2e  ; ...entries 96-111, not read
    equb &3e, &35, &52, &32, &3a, &2c, &56, &38, &36, &3c, &5a, &29, &39, &3c, &3a, &36  ; ...entries 112-127, not read
    equb &ce, &c6, &a2, &d7, &cc, &cc, &d5, &a7, &c1, &da, &aa, &ca, &ac, &cb, &a4, &a5  ; ...entries 128-143, not read
    equb &ba, &bb, &b8, &d4, &b4, &d7, &bc, &bd, &b2, &b3, &b0, &df, &bc, &d4, &d8, &bf  ; ...entries 144-159, not read
    equb &f4, &e9, &e7, &fa, &84, &e4, &f4, &e2, &88, &ea, &e5, &e5, &ff, &e4, &ea, &ea  ; ...entries 160-175, not read
    equb &e2, &f8, &fc, &f4, &94, &f0, &e4, &f6, &eb, &f0, &f4, &fc, &9c, &e9, &f6, &f6  ; ...entries 176-191, not read
    equb &93, &e1, &8f, &86, &97, &96, &87, &80, &8d  ; ...entries 192-200, not read
    equb &e7, &9e, &83, &8d, &83, &85, &90  ; Not referenced
; &0cd0 used as index base 7 times by &0ede, &0f1e, &74ef, &74f2, &74f9, &75bd, &79a7
.hero_damage_taken
    equb &89, &9e, &87, &f3, &95, &9b, &92, &f7
    equb &90, &98, &8a, &8b, &85, &fd, &9a, &8a
    equb &ae, &a6, &a7, &ac, &aa, &ac, &a8, &a0
    equb &c9, &00, &00, &00, &00, &00, &00, &00
.hit_sound
; &0cf4 referenced 2 times by &7481, &7491
    equw &0010, tune_ptr + 1, &0006, &0006  ; SOUND channel 0 (flush), envelope 1, pitch 6, duration 6
    equb &12, &00, &03, &00, &c8, &00, &0a  ; Not referenced
.dasmos_dunj3_end

    org &0e00

.dasmos_dunj4_start
; &0e00 referenced 2 times by &07ca, &0ecc
.new_game
    lda #0                              ; New game: level 0...
    sta level_number                    ; ...as level_number...
    sta level_bcd                       ; ...and as the BCD level count
    tax                                 ; Give each hero their starting attributes
; &0e09 referenced 1 time by &0e0f
.reset_each_hero
    jsr reset_hero                      ; Reset hero X
    inx                                 ; Next hero
    cpx #4                              ; All four done?
    bne reset_each_hero                 ; No: reset the next
    jsr hero_menu                       ; Then the players choose heroes and sound
; Play each level in turn until every hero is dead.
; &0e14 referenced 1 time by &0e84
.level_loop
    lda level_number                    ; Monster hit points = 8 + 2 x (levels played)...
    asl a                               ; ...x 2...
    clc                                 ; ...(carry clear for the add)
    adc #8                              ; ...+ 8...
    sta monster_start_hit_points        ; ...for this level's monsters
    sed                                 ; Add 1 to the level number in decimal...
    clc                                 ; ...(carry clear for the add)
    lda level_bcd                       ; ...the BCD count...
    adc #1                              ; ...+ 1...
    sta level_bcd                       ; ...stored
    cld                                 ; Back to binary arithmetic
    lda level_number                    ; One digit for levels 1-9, two from 10 (the count is incremented later, in show_level_number)
    cmp #9                              ; ...9 or more played: level 10 on?
    bcs two_level_digits                ; Yes: two digits
    ldx #0                              ; X = 0: one digit
    beq store_level_units               ; ...(always branches)
; &0e34 referenced 1 time by &0e2e
.two_level_digits
    ldx #1                              ; X = 1: two digits
; &0e36 referenced 1 time by &0e32
.store_level_units
    lda level_bcd                       ; Units digit...
    and #&0f                            ; ...its low nibble...
    clc                                 ; ...as ASCII...
    adc #'0'                            ; ...+ '0'...
    sta level_filename_digits,x         ; ...into the filename
    cpx #0                              ; Two digits?
    beq end_level_filename              ; No: end level filename
    lda level_bcd                       ; Yes: the tens digit...
    lsr a                               ; ...high nibble: first shift down...
    lsr a                               ; ...shifting the tens digit...
    lsr a                               ; ...down four bits...
    lsr a                               ; ...to the low nibble
    clc                                 ; ...as ASCII...
    adc #'0'                            ; ...+ '0'...
    sta level_filename_digits           ; ...goes first
; &0e52 referenced 1 time by &0e43
.end_level_filename
    lda #&0d                            ; Terminate the filename with a carriage return
    sta level_filename_digits + 1,x     ; ...after the last digit
    jsr start_level                     ; Load and draw the level
    jsr draw_status_panel               ; Draw the status panel
    jsr remove_absent_heroes            ; Take out the heroes nobody plays
    lda #1                              ; Let one vertical sync pass before play starts
    sta os_vsync_counter                ; ...counted down at each vertical sync
    jsr play_level                      ; Play the level until it ends
    ldx #0                              ; Count the heroes who died, giving each back their starting attributes
    stx count                           ; ...none dead so far
; &0e6d referenced 1 time by &0e7d
.check_hero_dead
    lda hero_health_tens,x              ; Dead?
    cmp #spr_digit_0 - 1                ; ...health tens one below 0?
    bne next_hero_dead                  ; No: alive
    jsr reset_hero                      ; Yes: reset them
    inc count                           ; ...and count them
; &0e7a referenced 1 time by &0e72
.next_hero_dead
    inx                                 ; Next hero
    cpx #4                              ; All four checked?
    bne check_hero_dead                 ; No: next hero
    lda count                           ; Any hero alive?
    cmp #4                              ; ...fewer than four dead?
    bne level_loop                      ; Yes: on to the next level
    jsr game_over_music                 ; All dead: stop the music and start VDU 28,0,24,16,0, a text window on the left...
    nop                                 ; Padding
    nop                                 ; ...a second padding byte
    lda #0                              ; Left column 0
    jsr oswrch                          ; Send the left column
    lda #&18                            ; Bottom row 24
    jsr oswrch                          ; Send the bottom row
    lda #&10                            ; Right column 16
    jsr oswrch                          ; Send the right column
    lda #0                              ; Top row 0
    jsr oswrch                          ; Send the top row
    lda #&0c                            ; ...VDU 12 to clear it
    jsr oswrch                          ; Send VDU 12: clear the window
    ldx #4                              ; Put spaces back over the four message bytes used as counters
    lda #&20 ; ' '                      ; ...a space
; &0ea8 referenced 1 time by &0eac
.restore_message_spaces
    sta panel_hero - 1,x                ; ...into each of the four bytes
    dex                                 ; Next byte down
    bne restore_message_spaces          ; Until all four are spaces
; &0eae referenced 1 time by &0eb7
.print_game_over
    lda game_over_message,x             ; Print game_over_message...
    jsr osasci                          ; ...printed...
    inx                                 ; Next character
    cmp #0                              ; ...up to its zero byte
    bne print_game_over                 ; Not the end: next
; &0eb9 referenced 1 time by &0ebc
.wait_vsync_game_over
    lda os_vsync_counter                ; Wait for the vertical sync counter to run out
    bne wait_vsync_game_over            ; Not yet: keep waiting
    lda #osbyte_flush_buffer_class      ; Flush the input buffers
    jsr osbyte                          ; Discard keys pressed while the message showed  Flush selected class of buffer
    ldx #&f4                            ; Wait up to &1F4 centiseconds (5 s) for a key...
    ldy #1                              ; ...Y = &01: the time limit's high byte
    lda #osbyte_inkey                   ; OSBYTE &81: read a key within that time
    jsr osbyte                          ; Wait up to a minute for a key before a new game  Read a key, waiting up to 500 centiseconds
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
    sta hero_max_missiles,x             ; ...as hero X's missile limit
    lda hero_start_missile_damage,x     ; ...missile damage...
    sta hero_missile_damage,x           ; ...as their missile damage
    lda hero_start_damage_taken,x       ; ...and health lost per hit
    sta hero_damage_taken,x             ; ...as their health lost per hit
    lda #spr_digit_0                    ; Score 000...
    sta hero_score_thousands,x          ; ...thousands...
    sta hero_score_hundreds,x           ; ...hundreds...
    sta hero_score_tens,x               ; ...tens...
    lda #spr_digit_0 - 1                ; ...with the units one below 0, for draw_status_panel to add a point
    sta hero_score_units,x              ; ...as the units digit
    lda #spr_small_digit_1 - 1          ; No ten-thousands digit
    sta hero_score_ten_thousands,x      ; ...as the ten-thousands digit
    rts                                 ; Return
; ***************************************************************************************
; Draw the status panel
;
; Draw each hero's section of the status panel to the right of the views: health and
; score (by taking a health point and adding a score point, from starting values one
; beyond those wanted), face, shield and armour rating, one icon per missile allowed, and
; missile damage.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &0ef7 referenced 1 time by &0e5a
.draw_status_panel
    lda #0                              ; For each hero...
    sta panel_hero                      ; ...starting with hero 0
; &0efc referenced 1 time by &0f65
.draw_panel_hero
    ldx panel_hero                      ; X = this hero
    jsr lose_health_point               ; Draw the health (from the template's 99+1)
    jsr add_point                       ; Draw the score (from its starting 000 and one below 0)
    lda hero_faces,x                    ; Face, at column &45, row 0 of the section
    ldx #panel_left                     ; ...column &45...
    ldy #0                              ; ...row 0...
    jsr plot_panel_sprite               ; ...plotted
    ldx #panel_left + 8                 ; Shield, at column &4D, row 0
    ldy #0                              ; ...row 0...
    lda #spr_shield                     ; ...the shield sprite...
    jsr plot_panel_sprite               ; ...plotted
    ldx panel_hero                      ; Armour rating 10 - health lost per hit, as a small digit on the shield
    sec                                 ; ...(no borrow into the subtract)
    lda #spr_small_digit_1 + 9          ; ...from the small digit sprite for 10...
    sbc hero_damage_taken,x             ; ...less the damage per hit
    ldx #panel_left + 9                 ; ...at column &4E...
    ldy #2                              ; ...row 2...
    jsr plot_panel_sprite               ; ...plotted on the shield
    ldx panel_hero                      ; One missile icon every three rows from row &10, for each missile allowed...
    lda hero_max_missiles,x             ; ...missile limit...
    asl a                               ; ...x 2...
    clc                                 ; ...(carry clear for the add)
    adc hero_max_missiles,x             ; ...+ limit: 3 rows per icon...
    adc #&10                            ; ...+ &10: the row after the last icon
    sta count                           ; ...(end row in count)
    ldy #&10                            ; ...first icon at row &10
; &0f3a referenced 1 time by &0f4b
.draw_missile_icons
    tya                                 ; Keep the row...
    pha                                 ; ...on the stack
    ldx #panel_left + 6                 ; ...at column &4B
    lda #spr_missile_icon               ; ...the missile icon...
    jsr plot_panel_sprite               ; ...plotted at row Y
    pla                                 ; Recover the row...
    clc                                 ; ...(carry clear for the add)
    adc #3                              ; ...3 rows down...
    tay                                 ; ...for the next icon
    cpy count                           ; Past the last icon's row?
    bcc draw_missile_icons              ; No: plot another
    ldx panel_hero                      ; Missile damage, as a small digit at column &4C, row &0A
    lda hero_missile_damage,x           ; ...the hero's missile damage...
    clc                                 ; ...(carry clear for the add)
    adc #spr_small_digit_1 - 1          ; ...as a small digit sprite
    ldx #panel_left + 7                 ; ...at column &4C...
    ldy #&0a                            ; ...row &0A...
    jsr plot_panel_sprite               ; ...plotted
    inc panel_hero                      ; Next hero
    lda panel_hero                      ; All four heroes drawn?
    cmp #4                              ; ...(four of them)
    bne draw_panel_hero                 ; No: the next hero
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
    ldx panel_hero                      ; ...for the hero being drawn...
    clc                                 ; ...(carry clear for the add)
    adc workspace_template + 208,x      ; ...(read from workspace_template, which page &0D copies)
    sec                                 ; ...(no borrow into the subtract)
    sbc #&0e                            ; ...less 14...
    sta plot_y                          ; ...is the plot row
    jsr plot_sprite                     ; Plot it
    rts                                 ; Return
    equb &00, &09, &60                  ; Not referenced
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
    equs "FAREWELL!        ", &0d
    equs "THE QUEST HAS    ", &0d
    equs "FAILED AND THE   ", &0d
    equs "GODS ARE IN NO   ", &0d
    equs "MOOD TO RESURRECT", &0d
.game_over_you_all
; &0ff0 used as index base 1 time by &0ea8
; &0ff1 referenced 8 times by &0ef9, &0efc, &0f18, &0f28, &0f4d, &0f5d, &0f60, &0f6d
panel_hero = game_over_you_all+7
; &0ff2 referenced 5 times by &0e6a, &0e77, &0e7f, &0f35, &0f48
count = game_over_you_all+8
    equs "YOU ALL.         ", &0d
    equs "NEW ADVENTURERS  ", &0d
    equs "MUST TAKE YOUR   ", &0d
    equs "PLACE,BEGINNING  ", &0d
    equs "BACK ON THE UPPER", &0d
    equs "MOST LEVEL.      ", &0d
    equb &0a                            ; Line feed: a blank line
    equs "FIND THE CHALICE!", &00
; ***************************************************************************************
; Unused
;
; Leftover bytes: "ND!" and a zero, the end of an earlier message, then "&C2".
    equb &4e, &44, &21, &00, &26, &43, &32  ; Not referenced
; ***************************************************************************************
; Check whether the Chalice has been found
;
; On level 25, if a hero stands on the cell where the Chalice is, play the victory
; sequence, print the ending message, wait for a key and reset the machine through the
; RESET vector. The message is not part of the program: it is the 140 bytes at room_walls
; + &3A followed by the string at object_free_map + &3A, which on level 25 hold the
; ending text instead of map data.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &1070 referenced 1 time by &1f0a
.check_for_victory
    lda level_number                    ; Only on level 25
    cmp #last_level                     ; The Chalice lies only on level 25
    bne no_victory                      ; Another level: no Chalice to find
    ldx #0                              ; Is a hero on one of the Chalice's cells, x &1A or &1B...
; &1079 referenced 1 time by &1087
.check_door_x
    lda hero_door_x,x                   ; Hero X's position from the last door check...
    cmp #chalice_x                      ; ...in the Chalice's left column?
    beq check_door_y                    ; Yes: check the row
    cmp #chalice_x + 1                  ; ...or its right column?
    beq check_door_y                    ; Yes: check the row
; &1084 referenced 1 time by &1095
.next_hero_victory
    inx                                 ; Next hero
    cpx #4                              ; Past hero 3?
    bne check_door_x                    ; No: check the next hero
; &1089 referenced 1 time by &1075
.no_victory
    rts                                 ; Return
; &108a referenced 2 times by &107e, &1082
.check_door_y
    lda hero_door_y,x                   ; ...and y 4 or 5?
    cmp #chalice_y                      ; ...in the Chalice's top row?
    beq start_victory                   ; Yes: the Chalice is found
    cmp #chalice_y + 1                  ; ...or its bottom row?
    beq start_victory                   ; Yes: the Chalice is found
    bne next_hero_victory               ; No: next hero
; &1097 referenced 2 times by &108f, &1093
.start_victory
    jsr victory_sequence                ; Yes: play the victory sequence
    lda #&1c                            ; VDU 28,0,24,16,0: a text window on the left...
    jsr oswrch                          ; Send VDU 28
    lda #0                              ; Left column 0
    jsr oswrch                          ; Send it
    lda #&18                            ; Bottom row 24
    jsr oswrch                          ; Send it
    lda #&10                            ; Right column 16
    jsr oswrch                          ; Send it
    lda #0                              ; Top row 0
    jsr oswrch                          ; Send it
    lda #&0c                            ; ...VDU 12 to clear it
    jsr oswrch                          ; Clear the window for the ending text
    ldx #0                              ; Print 140 bytes from room_walls + &3A...
; &10ba referenced 1 time by &10c3
.print_victory_text
    lda room_walls + 58,x               ; Next byte of level 25's wall map, which is text
    jsr osasci                          ; Print it
    inx                                 ; Next byte
    cpx #&8c                            ; All 140 printed?
    bne print_victory_text              ; No: print the next
    ldx #0                              ; ...then the string at object_free_map + &3A: on level 25, the ending message
; &10c7 referenced 1 time by &10d0
.print_ending_message
    lda object_free_map + 58,x          ; Next character of the ending message
    jsr osasci                          ; Print it
    inx                                 ; Next character
    cmp #0                              ; The zero that ends the message?
    bne print_ending_message            ; No: print the next
    lda #osbyte_flush_buffer_class      ; Flush the input buffers
    jsr osbyte                          ; Discard keys pressed during the victory  Flush selected class of buffer
    jsr osrdch                          ; Wait for a key
    lda reset_vector                    ; Copy the RESET vector into the JSR below...
    sta reset_call_address              ; ...low byte
    lda reset_vector + 1                ; ...high byte...
    sta reset_call_address + 1          ; ...into the JSR's operand
.reset_call
; &10e7 referenced 1 time by &10dd
reset_call_address = reset_call+1
; &10e8 referenced 1 time by &10e3
    jsr &00                             ; ...and call it: reset the machine
; ***************************************************************************************
; Play the victory sequence
;
; Spin sprites round the Chalice with a rising tone, then dissolve it.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &10e9 referenced 1 time by &1097
.victory_sequence
    lda #osbyte_bell_envelope           ; OSBYTE &D4: the bell's envelope...
    ldx #8                              ; ...8
    jsr osbyte                          ; Set the bell's envelope for the victory tone  osbyte: bell envelope
    lda #0                              ; No pixel offsets
    sta plot_offset_x                   ; ...across...
    sta plot_offset_y                   ; ...or down, so sprites sit square in their cells
    lda #spr_sparkle_0                  ; The ring starts with the first sparkle
    sta victory_sprite                  ; ...as the ring's sprite
    lda #0                              ; Tone starts at pitch 0...
    sta victory_pitch                   ; ...for the bell
    lda #&e6                            ; ...with the frames &E6 units apart...
    sta victory_delay                   ; ...the delay loop's outer count
    lda #&32 ; '2'                      ; ...for &32 rises...
    sta victory_steps_left              ; ...pitch rises before the sequence ends
    lda #1                              ; ...each by 1 to begin with
    sta victory_pitch_step              ; ...the pitch's first step
; &110a referenced 1 time by &1146
.raise_victory_pitch
    clc                                 ; Raise the pitch
    lda victory_pitch                   ; ...current pitch...
    adc victory_pitch_step              ; ...plus the step...
    sta victory_pitch                   ; ...becomes the new pitch
    bcc shorten_victory_delay           ; No carry: carry on
    inc victory_pitch_step              ; Carry: rise faster...
    dec victory_steps_left              ; ...and count a rise
    bne shorten_victory_delay           ; More to come
    jmp erase_victory_ring              ; Done: finish
; &111c referenced 2 times by &1111, &1117
.shorten_victory_delay
    dec victory_delay                   ; Shorten the delay...
    bne sound_victory_bell              ; Not yet zero: keep it
    lda #1                              ; ...to at least 1
    sta victory_delay                   ; ...so the frames never stop entirely
; &1124 referenced 1 time by &111e
.sound_victory_bell
    ldx victory_pitch                   ; OSBYTE &D5: the bell's pitch...
    lda #osbyte_bell_frequency          ; ...set it from victory_pitch
    jsr osbyte                          ; Set it: the bell now sounds at that pitch  osbyte: bell frequency
    lda #7                              ; ...and sound the bell
    jsr oswrch                          ; Send BEL: the bell sounds at the new pitch
    jsr draw_victory_ring               ; Draw the ring
    lda victory_delay                   ; At full speed, dissolve the Chalice a byte at a time
    cmp #1                              ; Delay down to 1: the sequence is at full speed
    bne victory_delay_loop              ; Not yet: just wait
    jsr dissolve_chalice                ; Full speed: clear one more byte of the Chalice
; &113c referenced 1 time by &1137
.victory_delay_loop
    ldx victory_delay                   ; Wait for the delay
; &113e referenced 1 time by &1144
.victory_delay_outer
    ldy #&ff                            ; Each delay unit is 255 inner loops
; &1140 referenced 1 time by &1141
.victory_delay_inner
    dey                                 ; Count down the inner loop
    bne victory_delay_inner             ; Until it reaches zero
    dex                                 ; Count down the delay units
    bne victory_delay_outer             ; Until the delay is spent
    jmp raise_victory_pitch             ; Next frame
; ***************************************************************************************
; Draw the ring of sprites round the Chalice
;
; Plot the current victory sprite at the twelve cells round the Chalice, changing sprite
; as it goes.
;
; On Entry:
;     VICTORY_SPRITE: the sprite to plot
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &1149 referenced 2 times by &1130, &11d7
.draw_victory_ring
    lda #chalice_x + 2                  ; Start at x &1C, y 3: the ring runs round the Chalice's four cells
    sta ring_x                          ; ...as the ring's x...
    lda #chalice_y - 1                  ; ...one row above the Chalice...
    sta ring_y                          ; ...as the ring's y
    jsr plot_victory_sprite             ; Plot the first cell of the ring
    dec ring_x                          ; Left...
    jsr plot_victory_sprite             ; Plot the next cell along the top
    dec ring_x                          ; Left...
    jsr plot_victory_sprite             ; Plot the next cell along the top
    lda victory_sprite                  ; Keep the sprite...
    sta victory_sprite_copy             ; ...in victory_sprite_copy
    jsr next_victory_sprite             ; ...and change it
    dec ring_x                          ; Left...
    jsr plot_victory_sprite             ; Plot the top-left corner
    inc ring_y                          ; Down...
    jsr plot_victory_sprite             ; Plot down the left side
    inc ring_y                          ; Down...
    jsr plot_victory_sprite             ; Plot down the left side
    jsr next_victory_sprite             ; Change sprite
    inc ring_y                          ; Down...
    jsr plot_victory_sprite             ; Plot the bottom-left corner
    inc ring_x                          ; Right...
    jsr plot_victory_sprite             ; Plot along the bottom
    inc ring_x                          ; Right...
    jsr plot_victory_sprite             ; Plot along the bottom
    jsr next_victory_sprite             ; Change sprite
    inc ring_x                          ; Right...
    jsr plot_victory_sprite             ; Plot the bottom-right corner
    dec ring_y                          ; Up...
    jsr plot_victory_sprite             ; Plot up the right side
    dec ring_y                          ; Up...
    jsr plot_victory_sprite             ; Plot up the right side, closing the ring
    rts                                 ; Return
; ***************************************************************************************
; Plot a victory sprite at a cell
;
; Plot the current victory sprite at the map cell in &80, &81.
;
; On Entry:
;     RING_X: cell x
;     RING_Y: cell y
;     VICTORY_SPRITE: the sprite
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &119a referenced 12 times by &1151, &1156, &115b, &1168, &116d, &1172, &117a, &117f, &1184, &118c, &1191, &1196
.plot_victory_sprite
    lda ring_x                          ; Plot the victory sprite at the ring cell
    sta cell_x                          ; ...as the cell's x
    lda ring_y                          ; ...and its y...
    sta cell_y                          ; ...as the cell's y
    lda victory_sprite                  ; ...with the ring's current sprite...
    sta sprite_number                   ; ...as the sprite to plot
    jsr plot_at_cell                    ; ...in every view that shows the cell
    rts                                 ; Return
; ***************************************************************************************
; Choose the next victory sprite
;
; Step the victory sprite through &16-&19.
;
; On Entry:
;     VICTORY_SPRITE: the current sprite
;
; On Exit:
;     VICTORY_SPRITE: the next sparkle, &16-&19 in turn; &15 (erasing) is kept
;     A: victory_sprite
;     X: preserved
;     Y: preserved
; &11ac referenced 3 times by &1163, &1175, &1187
.next_victory_sprite
    lda victory_sprite                  ; Erasing (sprite &15)? Keep it
    cmp #spr_blank                      ; ...the blank sprite?
    beq store_victory_sprite            ; Yes: keep erasing
    clc                                 ; Next sparkle, &16-&19 in turn
    adc #1                              ; ...the next sparkle sprite
    cmp #spr_sparkle_3 + 1              ; Past the last sparkle?
    bne store_victory_sprite            ; No: use it
    lda #spr_sparkle_0                  ; Yes: back to the first sparkle
; &11bb referenced 2 times by &11b0, &11b7
.store_victory_sprite
    sta victory_sprite                  ; Make it the ring's sprite
    rts                                 ; Return
; ***************************************************************************************
; Clear a random byte of the Chalice
;
; Use the System VIA timer to pick a byte of the Chalice sprite, clear it, and redraw the
; Chalice.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &11be referenced 1 time by &1139
.dissolve_chalice
    lda system_via_t1c_l                ; Pick a byte of the Chalice at random...
    eor os_irq_a                        ; ...mixed with the MOS's last interrupt A...
    eor os_zp_fa                        ; ...and more MOS workspace, for randomness
    cmp #&c0                            ; ...if it is within the sprite
    bcs dissolve_done                   ; Outside the Chalice's &C0 bytes: leave it
    tax                                 ; Clear it...
    lda #0                              ; ...to zero, a black pair of pixels...
    sta sprite_chalice,x                ; ...in the Chalice's sprite data
    jsr plot_chalice                    ; ...and redraw the Chalice
; &11d2 referenced 1 time by &11c7
.dissolve_done
    rts                                 ; Return
; &11d3 referenced 1 time by &1119
.erase_victory_ring
    lda #spr_blank                      ; Erase the ring
    sta victory_sprite                  ; ...by making the blank the ring's sprite...
    jsr draw_victory_ring               ; ...and drawing the ring with it
    ldx #&c1                            ; Clear the whole Chalice sprite...
    lda #0                              ; ...to zeros
; &11de referenced 1 time by &11e2
.clear_chalice_sprite
    sta sprite_chalice - 1,x            ; Clear a byte of the Chalice's sprite data
    dex                                 ; Next byte down
    bne clear_chalice_sprite            ; Until all &C1 bytes are clear
    jsr plot_chalice                    ; ...and redraw it, now blank
    lda #&ff                            ; Wait 255 vertical syncs (about five seconds)
    sta os_vsync_counter                ; ...which the MOS counts down at each vsync
; &11ec referenced 1 time by &11ef
.wait_vsync_chalice
    lda os_vsync_counter                ; Read the count
    bne wait_vsync_chalice              ; Until it reaches zero
    rts                                 ; Return
; ***************************************************************************************
; Plot the Chalice
;
; Plot the Chalice sprite at its place on the map.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &11f2 referenced 2 times by &11cf, &11e4
.plot_chalice
    lda #chalice_x                      ; The Chalice's top-left cell, x &1A, y 4...
    sta cell_x                          ; ...as the cell's x
    lda #chalice_y                      ; ...and y 4...
    sta cell_y                          ; ...as the cell's y
    lda #spr_chalice                    ; ...sprite &73...
    sta sprite_number                   ; ...as the sprite to plot...
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
    equb &3d, &26, &00                  ; Not referenced
.saved_wrchv
    equb &a4, &e0, &00, &73
; ***************************************************************************************
; Font: letters A-Z
;
; Eight bytes per letter, copied into the definition of character 128 by the WRCHV
; handler.
; &12d7 used as index base 1 time by &7fc5
.font_letters
    equb %00111100                      ; 'A'
    equb %01000010
    equb %01000010
    equb %10001110
    equb %11110010
    equb %10000010
    equb %11000110
    equb %00000000
    equb %01111000                      ; 'B'
    equb %01000100
    equb %01000010
    equb %10111100
    equb %10000010
    equb %10000010
    equb %11111100
    equb %00000000
    equb %00111100                      ; 'C'
    equb %01000010
    equb %01000000
    equb %10000000
    equb %10000000
    equb %10000010
    equb %01111100
    equb %00000000
    equb %01111100                      ; 'D'
    equb %10000010
    equb %10000010
    equb %10000010
    equb %10000100
    equb %10000100
    equb %11111000
    equb %00000000
    equb %00001110                      ; 'E'
    equb %01110000
    equb %01000000
    equb %11001110
    equb %11110000
    equb %10000000
    equb %11111110
    equb %00000000
    equb %00011110                      ; 'F'
    equb %11100000
    equb %10000000
    equb %10001110
    equb %11110000
    equb %10000000
    equb %11000000
    equb %00000000
    equb %00111100                      ; 'G'
    equb %01000010
    equb %01000010
    equb %10000000
    equb %10011110
    equb %10000010
    equb %01111110
    equb %00000000
    equb %01100010                      ; 'H'
    equb %01000010
    equb %01000010
    equb %10011110
    equb %11100010
    equb %10000010
    equb %11000110
    equb %00000000
    equb %00011110                      ; 'I'
    equb %00001000
    equb %00001000
    equb %00010000
    equb %00010000
    equb %00010000
    equb %01111100
    equb %00000000
    equb %11111110                      ; 'J'
    equb %00000010
    equb %00000010
    equb %00000100
    equb %11000100
    equb %10000100
    equb %01111000
    equb %00000000
    equb %01000000                      ; 'K'
    equb %01001110
    equb %01110000
    equb %10001000
    equb %10001000
    equb %10000100
    equb %11000010
    equb %00000000
    equb %01100000                      ; 'L'
    equb %01000000
    equb %01000000
    equb %10000000
    equb %10000000
    equb %10000010
    equb %11111110
    equb %00000000
    equb %01000110                      ; 'M'
    equb %01101110
    equb %01101010
    equb %11011010
    equb %10010010
    equb %10000010
    equb %11000110
    equb %00000000
    equb %01100110                      ; 'N'
    equb %01010010
    equb %01010010
    equb %10001010
    equb %10001010
    equb %10001010
    equb %11000110
    equb %00000000
    equb %00111100                      ; 'O'
    equb %01000010
    equb %01000010
    equb %10000010
    equb %10000010
    equb %10000010
    equb %01111100
    equb %00000000
    equb %01111100                      ; 'P'
    equb %01000010
    equb %01000010
    equb %10111100
    equb %10000000
    equb %10000000
    equb %11000000
    equb %00000000
    equb %00111100                      ; 'Q'
    equb %01000010
    equb %01000010
    equb %10011010
    equb %10001010
    equb %10000110
    equb %01111110
    equb %00000000
    equb %01111100                      ; 'R'
    equb %01000010
    equb %01000010
    equb %10111100
    equb %10001000
    equb %10000100
    equb %11000010
    equb %00000000
    equb %00011110                      ; 'S'
    equb %00100010
    equb %01000000
    equb %00111100
    equb %00000010
    equb %10000010
    equb %11111100
    equb %00000000
    equb %11111110                      ; 'T'
    equb %10010010
    equb %00010000
    equb %00100000
    equb %00100000
    equb %00100000
    equb %01110000
    equb %00000000
    equb %01100110                      ; 'U'
    equb %01000010
    equb %01000010
    equb %10000010
    equb %10000010
    equb %10000010
    equb %01111100
    equb %00000000
    equb %11000110                      ; 'V'
    equb %01000010
    equb %01000010
    equb %10000010
    equb %10000100
    equb %01001000
    equb %00110000
    equb %00000000
    equb %01100110                      ; 'W'
    equb %01000010
    equb %01000010
    equb %10010010
    equb %10101010
    equb %01001010
    equb %01000100
    equb %00000000
    equb %01100110                      ; 'X'
    equb %00100010
    equb %00100100
    equb %00011000
    equb %00011000
    equb %00100100
    equb %11000110
    equb %00000000
    equb %10000110                      ; 'Y'
    equb %01000010
    equb %00110010
    equb %00001100
    equb %00001000
    equb %00010000
    equb %01110000
    equb %00000000
    equb %01111110                      ; 'Z'
    equb %00000010
    equb %00000100
    equb %00011000
    equb %00100000
    equb %01000010
    equb %11111110
    equb %00000000
; ***************************************************************************************
; Font: digits 0-9
;
; Eight bytes per digit, copied into the definition of character 128 by the WRCHV
; handler.
; &13a7 used as index base 1 time by &7fe8
.font_digits
    equb %00111100                      ; '0'
    equb %01000110
    equb %01001010
    equb %10010010
    equb %10100010
    equb %11000100
    equb %01111000
    equb %00000000
    equb %00001000                      ; '1'
    equb %00011000
    equb %00001000
    equb %00010000
    equb %00010000
    equb %00010000
    equb %00111100
    equb %00000000
    equb %00111100                      ; '2'
    equb %01000010
    equb %00000010
    equb %00001100
    equb %00110000
    equb %01000010
    equb %11111100
    equb %00000000
    equb %01111110                      ; '3'
    equb %00000010
    equb %00000100
    equb %00011000
    equb %00000110
    equb %10000010
    equb %01111100
    equb %00000000
    equb %00011000                      ; '4'
    equb %00101000
    equb %01001000
    equb %10010000
    equb %11111100
    equb %00010000
    equb %00111000
    equb %00000000
    equb %00011111                      ; '5'
    equb %00100000
    equb %00100000
    equb %00011000
    equb %00000100
    equb %10000010
    equb %01111100
    equb %00000000
    equb %00001110                      ; '6'
    equb %00010000
    equb %00100000
    equb %01111100
    equb %10000010
    equb %10000010
    equb %01111100
    equb %00000000
    equb %01111110                      ; '7'
    equb %00000010
    equb %00000010
    equb %00000100
    equb %00001000
    equb %00010000
    equb %01111000
    equb %00000000
    equb %00011100                      ; '8'
    equb %00100010
    equb %00100010
    equb %01111100
    equb %10000010
    equb %10000010
    equb %01111100
    equb %00000000
    equb %00111100                      ; '9'
    equb %01000010
    equb %01000010
    equb %00111110
    equb %00000010
    equb %00000100
    equb %00011000
    equb %00000000
    equs "<BB>"
    equb &02, &04, &18, &00, &74        ; Not referenced
; ***************************************************************************************
; Set up and draw a new level
;
; Stop the music (saving its place after the first level), count the level, put the MOS's
; page &0D back and load the level, unpack it, reset the workspace and monsters, clear
; the text area, show 25 rows, draw the view frames and views, and restart the music,
; from where it was after the first level.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &1400 referenced 1 time by &0e57
.start_level
    lda first_level_flag                ; First level?
    cmp #&7b ; '{'                      ; ...&7B once the first level is done
    bne stop_music_and_load             ; First level: no music to save
    lda music_rhythm_step               ; No: keep the music's place on the stack: its step...
    pha                                 ; ...pushed
    lda music_transpose                 ; ...transposition...
    pha                                 ; ...pushed
    lda music_section                   ; ...section...
    pha                                 ; ...pushed
    lda tune_ptr                        ; ...and tune pointer (zero page &00-&01)
    pha                                 ; ...low byte pushed
    lda tune_ptr + 1                    ; ...high byte...
    pha                                 ; ...pushed last
; &1419 referenced 1 time by &1405
.stop_music_and_load
    jsr stop_music                      ; Stop the music
    jsr count_level                     ; Clear the text area and count the level
    jsr load_level                      ; Put page &0D back and load the level
    jsr unpack_level                    ; Copy it into the game's tables
    jsr reset_workspace                 ; Reset page &0D for play
    jsr reset_monsters                  ; Reset the monsters and keys
    jsr clear_text_area                 ; Clear the text area
    lda #&17                            ; VDU 23,0,6,25,0,0,0,0,0,0: set 6845 register 6...
    jsr oswrch                          ; ...VDU 23...
    lda #0                              ; ...0: write a 6845 register...
    jsr oswrch                          ; ...sent
    lda #6                              ; ...register 6, rows displayed...
    jsr oswrch                          ; ...sent
    lda #&19                            ; ...to 25 character rows displayed
    jsr oswrch                          ; ...so play uses all 25 rows
    lda #0                              ; ...then six zeros to finish the command
    jsr oswrch                          ; ...zero 1 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 2 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 3 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 4 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 5 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 6 of 6: the VDU 23 is complete
    lda #<(view_frame_plots)            ; Point at view_frame_plots...
    sta plot_x                          ; ...low byte in plot_x
    lda #>(view_frame_plots)            ; ...high byte...
    sta plot_y                          ; ...in plot_y, as draw_view_frames expects
    jsr draw_view_frames                ; ...and draw the frames and the views
    jsr start_music                     ; Start the music
    lda first_level_flag                ; First level?
    cmp #&7b ; '{'                      ; ...&7B once the first level is done
    bne mark_first_level_done           ; First level: no music to restore
    pla                                 ; No: put the music's place back: tune pointer...
    sta tune_ptr + 1                    ; ...high byte...
    pla                                 ; ...then the low byte...
    sta tune_ptr                        ; ...restored
    pla                                 ; ...section...
    sta music_section                   ; ...restored
    pla                                 ; ...transposition...
    sta music_transpose                 ; ...restored
    pla                                 ; ...and rhythm step
    sta music_rhythm_step               ; ...restored: the tune resumes where it was
; &147d referenced 1 time by &1469
.mark_first_level_done
    lda #&7b ; '{'                      ; Mark the first level done
    sta first_level_flag                ; ...so later levels keep the music's place
    rts                                 ; Return
; ***************************************************************************************
; Put the MOS's page &0D back and load the level
;
; Copy the MOS's page &0D back from &C400 (Coder saved it there), so that the filing
; system's NMI code and workspace are intact, write the level number's digits into
; level_command, show 15 rows while loading, and *LOAD LEVELnn 6B00 (level 25 comes from
; Stones, via load_stones in Table). Then decrypt and check it.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &1483 referenced 1 time by &141f
.load_level
    ldx #0                              ; Copy &C400-&C4FF back to page &0D...
; &1485 referenced 1 time by &148c
.restore_page_0d_byte
    lda saved_page_0d,x                 ; ...each byte saved at &C400...
    sta scratch,x                       ; ...back where the filing system needs it
    dex                                 ; ...next byte (X wraps from 0)
    bne restore_page_0d_byte            ; Until all 256 are back
    lda level_bcd                       ; Level 10 or more (in BCD)?
    cmp #&0a                            ; ...&0A or more means two digits
    bcs level_command_two_digits        ; Yes: two digits
    lda #&20 ; ' '                      ; No: units digit then a space
    sta level_command_digits + 1        ; ...second digit a space
    lda level_bcd                       ; ...the units digit...
    and #&0f                            ; ...from the low nibble...
    clc                                 ; ...as ASCII...
    adc #&30 ; '0'                      ; ...'0' plus the digit
    sta level_command_digits            ; ...is the first digit
    bne shrink_display_for_loading      ; ...(always branches)
; &14a7 referenced 1 time by &1493
.level_command_two_digits
    lda level_bcd                       ; Yes: tens digit...
    lsr a                               ; ...shifting the tens digit...
    lsr a                               ; ...down four bits...
    lsr a                               ; ...to the...
    lsr a                               ; ...low nibble
    clc                                 ; ...as ASCII...
    adc #&30 ; '0'                      ; ...'0' plus the digit
    sta level_command_digits            ; ...is the first digit
    lda level_bcd                       ; ...then units digit
    and #&0f                            ; ...from the low nibble...
    clc                                 ; ...as ASCII...
    adc #&30 ; '0'                      ; ...'0' plus the digit
    sta level_command_digits + 1        ; ...is the second digit
; &14bf referenced 1 time by &14a5
.shrink_display_for_loading
    lda #&17                            ; VDU 23,0,6,15,0,0,0,0,0,0: show 15 character rows while loading...
    jsr oswrch                          ; ...VDU 23...
    lda #0                              ; ...0: write a 6845 register...
    jsr oswrch                          ; ...sent
    lda #6                              ; ...register 6, rows displayed...
    jsr oswrch                          ; ...sent
    lda #&0f                            ; ...15 rows...
    jsr oswrch                          ; ...hiding the lower rows while loading
    lda #0                              ; ...then six zeros to finish the command
    jsr oswrch                          ; ...zero 1 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 2 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 3 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 4 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 5 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 6 of 6: the VDU 23 is complete
    lda level_number                    ; Level 25?
    cmp #&19                            ; ...0-based 25?
    bne load_level_file                 ; No: load its LEVELnn file
    jmp load_stones                     ; Yes: load it from Stones (and check it there)
; &14f1 referenced 1 time by &14ec
.load_level_file
    ldx #<(level_command)               ; No: *LOAD LEVELnn 6B00
    ldy #>(level_command)               ; ...high byte of the command
    jsr oscli                           ; ...*LOAD the level to &6B00
    jmp decrypt_level                   ; Decrypt and check it, and return from there
.level_command
; &1505 referenced 2 times by &14a2, &14b1
level_command_digits = level_command+10
; &1506 referenced 2 times by &1497, &14bc
    equs "LOAD LEVEL11 6B00", &0d
; ***************************************************************************************
; Reset the game workspace for a new level
;
; Copy workspace_template into page &0D and clear the per-level state.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: preserved
; &150d referenced 1 time by &1425
.reset_workspace
    ldx #0                              ; Copy workspace_template to page &0D
; &150f referenced 1 time by &1516
.copy_workspace_template
    lda workspace_template,x            ; Byte of the starting values...
    sta scratch,x                       ; ...becomes page &0D's byte
    inx                                 ; Next byte
    bne copy_workspace_template         ; Until all 256 are copied
    lda #0                              ; Reset the exit and other per-level state
    sta exit_busy                       ; No hero is going down the exit
    sta exit_offset_x_3                 ; Exit animation x offset 3 starts at 0...
    sta exit_offsets_y                  ; ...as does y offset 0...
    sta exit_offset_y_4                 ; ...and y offset 4
    sta next_trapdoor                   ; First monster emerges from trapdoor 0
    lda #1                              ; Offsets for the exit animation, and no hero shrunk
    sta exit_offset_x_1                 ; ...as x offset 1...
    sta exit_offset_x_2                 ; ...x offset 2...
    sta exit_offset_y_3                 ; ...and y offset 3
    lda #&ff                            ; &FF: no hero is shrunk
    sta shrunk_hero                     ; ...as shrunk_hero
    lda #5                              ; Exit animation offset of 5...
    sta exit_offset_y_1                 ; ...for y offset 1
    lda #3                              ; Offset of 3...
    sta exit_offset_y_2                 ; ...for y offset 2
    rts                                 ; Return
; ***************************************************************************************
; Draw the frames round the four views
;
; Send the twenty PLOT commands of view_frame_plots, draw the four views, then point
; WRCHV at &7F8F, which passes every character straight to the MOS.
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
    jsr oswrch                          ; Send VDU 25: a PLOT command follows
    ldy #0                              ; ...then the five bytes of the command
; &154d referenced 1 time by &1555
.send_frame_vdu
    lda (plot_x),y                      ; Next byte of this PLOT: K, then X and Y
    jsr oswrch                          ; Send it
    iny                                 ; Next byte
    cpy #5                              ; All five sent?
    bne send_frame_vdu                  ; No: send the next
    clc                                 ; Next command
    lda plot_x                          ; ...pointer...
    adc #5                              ; ...moves on five bytes...
    sta plot_x                          ; ...to the next PLOT
    ldy #0                              ; Start the next PLOT at its first byte
    dex                                 ; Count the PLOT done
    bne draw_view_frame                 ; Until all twenty are drawn
    jsr draw_all_views                  ; Draw the four views
    lda #<(wrch_handler)                ; Point WRCHV at &7F8F...
    sta wrchv                           ; ...low byte...
    lda #>(wrch_handler)                ; ...high byte...
    sta wrchv + 1                       ; ...the WRCHV entry again, for text
    rts                                 ; Return
; ***************************************************************************************
; Copy the loaded level into the game's tables
;
; Distribute the level file at &6B00 into the object, door, key, trapdoor and map tables
; and the wall sprite.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: preserved
; &1571 referenced 1 time by &1422
.unpack_level
    ldx #max_object                     ; Objects 30 to 1: position and type
; &1573 referenced 1 time by &1586
.unpack_objects
    lda level_object_x,x                ; Object's x in the level file...
    sta object_x,x                      ; ...becomes its map x
    lda level_object_y,x                ; Its y...
    sta object_y,x                      ; ...becomes its map y
    lda level_object_type,x             ; Its type...
    sta object_type,x                   ; ...becomes its sprite
    dex                                 ; Next object down
    bne unpack_objects                  ; Until object 1 is done
    ldx #max_door                       ; Doors 20 to 1: position and sprite
; &158a referenced 1 time by &159d
.unpack_doors
    lda level_door_x,x                  ; Door's x in the level file...
    sta door_x,x                        ; ...becomes its map x
    lda level_door_y,x                  ; Its y...
    sta door_y,x                        ; ...becomes its map y
    lda level_door_sprite,x             ; Its sprite, upright or across...
    sta door_sprite,x                   ; ...becomes its sprite
    dex                                 ; Next door down
    bne unpack_doors                    ; Until door 1 is done
    ldx #max_key                        ; Keys 20 to 1: position
; &15a1 referenced 1 time by &15ae
.unpack_keys
    lda level_key_x,x                   ; Key's x in the level file...
    sta key_x,x                         ; ...becomes its map x
    lda level_key_y,x                   ; Its y...
    sta key_y,x                         ; ...becomes its map y
    dex                                 ; Next key down
    bne unpack_keys                     ; Until key 1 is done
    ldx #0                              ; Trapdoors 0 to 7: position
; &15b2 referenced 1 time by &15c1
.unpack_trapdoors
    lda level_trapdoor_x,x              ; Trapdoor's x in the level file...
    sta trapdoor_x,x                    ; ...becomes its map x
    lda level_trapdoor_y,x              ; Its y...
    sta trapdoor_y,x                    ; ...becomes its map y
    inx                                 ; Next trapdoor
    cpx #8                              ; All eight done?
    bne unpack_trapdoors                ; No: copy the next
    ldx #0                              ; Wall map and object-free map, &C9 bytes each
; &15c5 referenced 1 time by &15d4
.unpack_walls
    lda level_walls,x                   ; Byte of the level's wall map...
    sta room_walls,x                    ; ...into room_walls
    lda level_object_free_map,x         ; Byte of the level's object-free map...
    sta object_free_map,x               ; ...into object_free_map
    inx                                 ; Next byte
    cpx #map_bytes                      ; Both maps copied?
    bne unpack_walls                    ; No: copy the next
    ldx #0                              ; The level's wall sprite, &30 bytes
; &15d8 referenced 1 time by &15e1
.unpack_wall_sprite
    lda level_wall_sprite,x             ; Byte of the level's wall block...
    sta wall_sprite,x                   ; ...becomes sprite 0, the wall
    inx                                 ; Next byte
    cpx #&30 ; '0'                      ; All 4 x 12 bytes copied?
    bne unpack_wall_sprite              ; No: copy the next
    rts                                 ; Return
; ***************************************************************************************
; Clear the monsters for a new level
;
; Mark every monster as not yet appeared, give each the level's starting hit points, and
; clear the heroes' keys and the returning_hero_queue.
;
; On Exit:
;     A: 0
;     X: 4
;     Y: preserved
; &15e4 referenced 1 time by &1428
.reset_monsters
    ldx #max_monster                    ; Monsters 30 to 1...
; &15e6 referenced 1 time by &15f7
.reset_each_monster
    lda #spr_blank                      ; ...dying, so that they emerge from the trapdoors...
    sta monster_sprite,x                ; ...as monster X's sprite...
    lda #off_map                        ; ...off the map...
    sta monster_x,x                     ; ...as monster X's x...
    lda monster_start_hit_points        ; ...with this level's hit points
    sta monster_hit_points,x            ; ...as monster X's hit points
    dex                                 ; Next monster down
    bne reset_each_monster              ; Until monster 1 is done
    ldx #0                              ; For each hero: clear the returning queue, the key carried and the door-check position
    lda #0                              ; Zero for every entry cleared
; &15fd referenced 1 time by &160f
.clear_hero_carrying
    sta returning_hero_queue,x          ; Empty the returning-hero queue
    sta hero_key,x                      ; Hero X carries no key
    sta hero_key_dropped,x              ; ...and has swapped none
    sta hero_door_x,x                   ; No door-check position...
    sta hero_door_y,x                   ; ...in x or y
    inx                                 ; Next hero
    cpx #4                              ; All four done?
    bne clear_hero_carrying             ; No: clear the next
    rts                                 ; Return
; ***************************************************************************************
; Clear the text area and count the level
;
; No level number is shown.
;
; On Exit:
;     A: corrupted
;     X: preserved
;     Y: preserved
; &1612 referenced 1 time by &141c
.count_level
    jsr clear_text_area                 ; Clear the text area
    inc level_number                    ; Count the level
    rts                                 ; Return
; ***************************************************************************************
; Clear the left of the screen
;
; Set a text window over the left of the screen and clear it.
;
; On Exit:
;     A: corrupted
;     X: preserved
;     Y: preserved
; &1619 referenced 2 times by &142b, &1612
.clear_text_area
    lda #&1c                            ; VDU 28: a text window over the whole of the left of the screen...
    jsr oswrch                          ; Send VDU 28
    lda #0                              ; Left column 0
    jsr oswrch                          ; Send it
    lda #&18                            ; Bottom row 24
    jsr oswrch                          ; Send it
    lda #&13                            ; Right column 19
    jsr oswrch                          ; Send it
.set_text_window_top
; &162e referenced 1 time by &c60a
clear_text_area_top = set_text_window_top+1
    lda #0                              ; Top row 0
    jsr oswrch                          ; Send it
    lda #&0c                            ; ...VDU 12 to clear it
    jsr oswrch                          ; Send it
    rts                                 ; Return
; &1638 referenced 3 times by &1400, &1464, &147f
.first_level_flag
    equb &ea
    equb &60                            ; Not referenced
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
    equb &08                            ; Not referenced
; &169f referenced 7 times by &0477, &0e02, &0e14, &0e29, &1070, &14e7, &1615
.level_number
    equb &01
; ***************************************************************************************
; Sound the exit and add a queue marker
;
; Play the exit sound and put a &64 entry in the first free slot of returning_hero_queue.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &16a0 referenced 1 time by &203d
.queue_exit_marker
    ldx #<(exit_envelope)               ; Define the exit envelope...
    ldy #>(exit_envelope)               ; ...high byte
    lda #osword_envelope                ; ...OSWORD 8...
    jsr osword                          ; ENVELOPE command
    ldx #<(exit_sound)                  ; ...and play the exit sound
    ldy #>(exit_sound)                  ; ...high byte
    lda #osword_sound                   ; ...OSWORD 7...
    jsr osword                          ; SOUND command
    ldx #0                              ; Find the end of returning_hero_queue...
; &16b4 referenced 1 time by &16c0
.find_queue_end
    lda returning_hero_queue,x          ; Entry X of the queue
    bne next_queue_entry                ; In use: try the next
    lda #nobody_returns                 ; ...and add a &64 marker there
    sta returning_hero_queue,x          ; ...in the first empty entry
    rts                                 ; Return
; &16bf referenced 1 time by &16b7
.next_queue_entry
    inx                                 ; Next entry
    bne find_queue_end                  ; X not wrapped: check the next entry
    equb &02, &02, &00, &00, &83, &00, &00, &00
    equb &00, &00, &00, &31, &00, &8d   ; Not referenced
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
    equb &00, &8c                       ; Not referenced
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
    equb &80, &00, &00, &32, &00        ; Not referenced
    equs "eco"
    equb &00, &8e, &0b, &94, &00, &00   ; Not referenced
    equs "?&A66=(rx%-lx%)"
    equb &81                            ; Not referenced
    equs "2+1:sprite%?&A99=by%-ty%+1"
    equb &0d, &03, &d4, &1d, &20, &d4, &31, &2c  ; Not referenced
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
    equb &05, &00, &00, &00, &0a, &00, &05  ; Not referenced
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
    equb &00, &00, &00, &6d, &19, &00, &00, &00  ; Not referenced
.magic_envelope
    equb &03                            ; Envelope 3
    equb &01                            ; Step length 1 centisecond
    equb &0a, &0a, &ec                  ; Pitch change per step in sections 1-3: 10, 10, -20
    equb &03, &03, &03                  ; Steps in pitch sections 1-3: 3, 3, 3
    equb &80, &00, &00, &ff             ; Amplitude change per step in attack, decay, sustain, release: -128, 0, 0, -1
    equb &80, &80                       ; Target levels at the end of attack and decay: 128, 128
.magic_sound
    equw &0012, &0003, tune_ptr, &0002  ; SOUND channel 2 (flush), envelope 3, pitch 0, duration 2
.treasure_envelope
    equb &03                            ; Envelope 3
    equb &02                            ; Step length 2 centiseconds
    equb &01, &01, &01                  ; Pitch change per step in sections 1-3: 1, 1, 1
    equb &01, &01, &01                  ; Steps in pitch sections 1-3: 1, 1, 1
    equb &80, &00, &00, &f8             ; Amplitude change per step in attack, decay, sustain, release: -128, 0, 0, -8
    equb &80, &80                       ; Target levels at the end of attack and decay: 128, 128
.treasure_sound
    equw &0012, &0003, &00c8, &0005     ; SOUND channel 2 (flush), envelope 3, pitch 200, duration 5
.pickup_envelope
    equb &03                            ; Envelope 3
    equb &80                            ; Step length 0 centiseconds, no auto-repeat
    equb &00, &00, &00                  ; Pitch change per step in sections 1-3: 0, 0, 0
    equb &0a, &0a, &0a                  ; Steps in pitch sections 1-3: 10, 10, 10
    equb &0a, &00, &00, &fd             ; Amplitude change per step in attack, decay, sustain, release: 10, 0, 0, -3
    equb &80, &80                       ; Target levels at the end of attack and decay: 128, 128
.pickup_sound
    equw &0010, &0003, &000a, &0005     ; SOUND channel 0 (flush), envelope 3, pitch 10, duration 5
.key_envelope
    equb &03                            ; Envelope 3
    equb &80                            ; Step length 0 centiseconds, no auto-repeat
    equb &00, &00, &00                  ; Pitch change per step in sections 1-3: 0, 0, 0
    equb &01, &1e, &1e                  ; Steps in pitch sections 1-3: 1, 30, 30
    equb &80, &00, &00, &fe             ; Amplitude change per step in attack, decay, sustain, release: -128, 0, 0, -2
    equb &80, &80                       ; Target levels at the end of attack and decay: 128, 128
.key_sound
    equw &0012, &0003, &00f0, tune_ptr + 1  ; SOUND channel 2 (flush), envelope 3, pitch 240, duration 1
.exit_envelope
    equb &03                            ; Envelope 3
    equb &82                            ; Step length 2 centiseconds, no auto-repeat
    equb &ff, &ff, &fe                  ; Pitch change per step in sections 1-3: -1, -1, -2
    equb &01, &01, &80                  ; Steps in pitch sections 1-3: 1, 1, 128
    equb &80, &00, &00, &ff             ; Amplitude change per step in attack, decay, sustain, release: -128, 0, 0, -1
    equb &80, &80                       ; Target levels at the end of attack and decay: 128, 128
.exit_sound
    equw &0012, &0003, os_zp_fa, tune_ptr + 1  ; SOUND channel 2 (flush), envelope 3, pitch 250, duration 1
    equb &00, &00, &00, &00, &04        ; Not referenced
    equs "50:50:$"
    equb &0c, &0c, &08, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &0a, &00, &00, &00
    equb &00, &14, &34, &38, &03, &03   ; Not referenced
    equs "4<:%"
    equb &0f, &0f, &0f, &1e, &31, &38, &03  ; Not referenced
    equs "48<"
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &04        ; Not referenced
    equs "5?:"
    equb &18, &3f, &3a, &0c, &0c, &08, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &35, &00                       ; Not referenced
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
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &1cc0 referenced 1 time by &1f0d
.update_game
    jsr move_heroes                     ; Move the heroes
    ldx #0                              ; For each hero...
; &1cc5 referenced 1 time by &1dbf
.check_doors
    stx scratch                         ; ...look for a door at the cell the hero is moving into
    lda hero_door_x,x                   ; Hero X's x when doors were last checked...
    sta cell_x                          ; ...is the cell to test
    lda hero_door_y,x                   ; ...and its y...
    sta cell_y                          ; ...is the cell's y
    txa                                 ; Keep the hero's number...
    pha                                 ; ...on the stack for the key check
    ldx #max_door                       ; Doors 20 to 1
; &1cd8 referenced 1 time by &1db5
.check_door
    lda door_x,x                        ; This door's x?
    cmp cell_x                          ; ...the cell being tested?
    beq check_door_cell_y               ; Yes: check its y
    jmp next_door                       ; No: next door
; &1ce3 referenced 1 time by &1cde
.check_door_cell_y
    lda door_y,x                        ; ...and y?
    cmp cell_y                          ; ...the cell being tested?
    beq check_door_key                  ; Yes: a door is here
    jmp next_door                       ; No: next door
; &1cee referenced 1 time by &1ce9
.check_door_key
    pla                                 ; Does the hero carry this door's key?
    tay                                 ; Y = the hero's number...
    pha                                 ; ...kept on the stack
    txa                                 ; A = the door's number
    cmp hero_key,y                      ; Is it the number of the key the hero carries?
    beq open_door                       ; Yes: open door
    jmp next_door                       ; No: next door
; &1cfa referenced 1 time by &1cf5
.open_door
    txa                                 ; Open the door: 7 points...
    pha                                 ; Keep the door's number...
    tya                                 ; ...and the hero's...
    pha                                 ; ...on the stack
    ldy #7                              ; Seven points, one per add_point call
    ldx scratch                         ; ...given to the hero opening the door
; &1d03 referenced 1 time by &1d0b
.door_points_loop
    tya                                 ; Keep the count of points still to give
    pha                                 ; ...on the stack across add_point
    jsr add_point                       ; One point to hero X
    pla                                 ; Recover the count of points to give
    tay                                 ; ...back into Y
    dey                                 ; One fewer to give
    bne door_points_loop                ; More to give: add the next point
    lda #&96                            ; ...play the food sound at a lower pitch...
    sta food_sound + 4                  ; ...pitch 150 instead of food's 200
    ldx #<(food_sound)                  ; SOUND food_sound: block address low...
    ldy #>(food_sound)                  ; ...and high
    lda #osword_sound                   ; OSWORD 7: SOUND
    jsr osword                          ; Play the door-opening sound  SOUND command
    lda #&c8                            ; ...and put its pitch back
    sta food_sound + 4                  ; ...to 200, food's own pitch
    lda cell_y                          ; Keep the door's cell in spare bytes beyond the monster tables, as plot_at_cell changes cell_x and cell_y...
    sta monster_y + 35                  ; ...y into the spare byte at monster_y + 35...
    lda cell_x                          ; ...then the door's x...
    sta monster_x + 35                  ; ...into the spare byte at monster_x + 35
    lda #spr_blank                      ; ...erase the door...
    sta sprite_number                   ; ...as the sprite to plot
    lda #0                              ; ...on the cell itself: no pixel offset...
    sta plot_offset_x                   ; ...horizontally...
    sta plot_offset_y                   ; ...or vertically
    jsr plot_at_cell                    ; Plot the blank in every view showing the door
    lda monster_x + 35                  ; ...and recover its cell
    sta cell_x                          ; ...back into cell_x...
    lda monster_y + 35                  ; ...then the door's y...
    sta cell_y                          ; ...back into cell_y
    pla                                 ; Recover the hero number pushed at open_door...
    tay                                 ; ...into Y
    pla                                 ; Recover the door number...
    tax                                 ; ...into X
    lda cell_y                          ; Clear the door's wall bit: room offset...
    and #&f8                            ; ...room row: y AND &F8, 8 cell rows per room...
    sta scratch                         ; ...kept to add in again
    clc                                 ; ...clear carry for the three adds
    adc scratch                         ; ...twice...
    adc scratch                         ; ...three times...
    adc scratch                         ; ...four: 32 bytes per row of four rooms
    sta map_ptr                         ; ...as the low byte of map_ptr
    lda cell_x                          ; ...plus the room column...
    and #&f8                            ; ...x AND &F8: 8 bytes per room...
    adc map_ptr                         ; ...added on...
    sta map_ptr                         ; ...giving the room's offset in room_walls
    lda #>(room_walls)                  ; ...in room_walls...
    sta map_ptr_hi                      ; ...as map_ptr's high byte
    txa                                 ; Keep the door number...
    pha                                 ; ...on the stack while X is used for the bit
    lda cell_x                          ; ...mask for the column...
    and #7                              ; ...x AND 7, the cell's column in the room...
    tax                                 ; ...as the index into bit_masks...
    lda bit_masks,x                     ; ...for the cell's bit in its row byte...
    eor #&ff                            ; ...inverted, to keep every other wall...
    sta scratch                         ; ...as the mask to clear it with
    lda cell_y                          ; ...byte for the row...
    and #7                              ; ...y AND 7, the cell's row in the room...
    tay                                 ; ...indexes the room's eight row bytes
    lda (map_ptr),y                     ; ...clear the bit
    and scratch                         ; ...knock out the door's bit...
    sta (map_ptr),y                     ; ...so the doorway no longer blocks anyone
    pla                                 ; Recover the door number...
    tax                                 ; ...into X
    lda #off_map                        ; Remove the door...
    sta door_x,x                        ; ...x off the map...
    sta door_y,x                        ; ...and y off the map
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    lda #0                              ; ...and the key, which is used up
    sta hero_key,x                      ; ...in the hero's key slot
    lda #spr_blank_key_icon             ; Erase the key icon from the panel
    sta sprite_number                   ; ...as the sprite to plot
    lda hero_panel_y,x                  ; ...using the hero's panel row...
    sec                                 ; ...set carry to subtract
    sbc #&0d                            ; ...less 13: the key icon's row...
    sta plot_y                          ; ...as plot_y
    lda #panel_left + 5                 ; ...in panel column panel_left + 5...
    sta plot_x                          ; ...as plot_x
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack across plot_sprite
    jsr plot_sprite                     ; Plot the blank icon over the key icon
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    jmp next_hero_doors                 ; Next hero
; &1db2 referenced 3 times by &1ce0, &1ceb, &1cf7
.next_door
    dex                                 ; Next door
    beq doors_done                      ; Doors all checked: this hero is done
    jmp check_door                      ; Otherwise check the next door
; &1db8 referenced 1 time by &1db3
.doors_done
    pla                                 ; Recover the hero number pushed at check_doors...
    tax                                 ; ...into X
; &1dba referenced 1 time by &1daf
.next_hero_doors
    inx                                 ; Next hero
    cpx #4                              ; All four heroes done?
    beq draw_keys                       ; Yes: on to the keys
    jmp check_doors                     ; No: check this hero against the doors
; &1dc2 referenced 1 time by &1dbd
.draw_keys
    lda #0                              ; Draw the keys on the floor, 20 to 1
    sta plot_offset_x                   ; ...on their cells: no pixel offset...
    sta plot_offset_y                   ; ...either way
    lda #spr_key                        ; ...in the key sprite...
    sta sprite_number                   ; ...as the sprite to plot
    ldx #max_key                        ; ...counting keys down from 20
; &1dce referenced 1 time by &1de2
.draw_each_key
    lda key_x,x                         ; The key's x...
    sta cell_x                          ; ...as cell_x...
    lda key_y,x                         ; ...and y (off the map if it is carried)...
    sta cell_y                          ; ...as cell_y
    txa                                 ; Keep the key number...
    pha                                 ; ...on the stack across plot_at_cell
    jsr plot_at_cell                    ; Plot it in every view showing its cell
    pla                                 ; Recover the key number...
    tax                                 ; ...into X
    dex                                 ; Next key down
    bne draw_each_key                   ; More keys: draw the next
    ldx #0                              ; For each hero...
; &1de6 referenced 1 time by &1ecb
.check_hero_keys
    lda hero_direction,x                ; In play?
    bne check_key_swap                  ; Yes: check key swap
    lda hero_key,x                      ; Out of play: carrying a key?
    bne check_death_finished            ; Yes: check death finished
    jmp next_hero_keys                  ; No: next hero
; &1df3 referenced 1 time by &1dee
.check_death_finished
    lda hero_frame,x                    ; Death animation finished?
    cmp #8                              ; ...frame 8 is the last of the death
    bne check_key_swap                  ; Not yet
    ldy hero_key,x                      ; Yes: drop the key where the hero fell
    lda hero_x,x                        ; ...at the hero's x...
    sta key_x,y                         ; ...as the key's x...
    lda hero_y,x                        ; ...and the hero's y...
    sta key_y,y                         ; ...as the key's y
    lda #0                              ; The dead hero carries no key now...
    sta hero_key,x                      ; ...in their key slot
    lda #spr_blank_key_icon             ; Erase the key icon from the panel
    sta sprite_number                   ; ...as the sprite to plot
    lda hero_panel_y,x                  ; ...using the hero's panel row...
    sec                                 ; ...set carry to subtract
    sbc #&0d                            ; ...less 13: the key icon's row...
    sta plot_y                          ; ...as plot_y
    lda #panel_left + 5                 ; ...in panel column panel_left + 5...
    sta plot_x                          ; ...as plot_x
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack across plot_sprite
    jsr plot_sprite                     ; Plot the blank icon over the key icon
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    jmp next_hero_keys                  ; Next hero
; &1e28 referenced 2 times by &1de9, &1df8
.check_key_swap
    lda hero_key_dropped,x              ; Just swapped keys?
    beq check_key_cell                  ; No: check key cell
    lda #0                              ; Yes: not again until the hero moves on
    sta hero_key_dropped,x              ; ...clearing the hero's swap flag
    jmp next_hero_keys                  ; ...and moving on to the next hero
; &1e35 referenced 1 time by &1e2b
.check_key_cell
    lda hero_x,x                        ; Is there a key at the hero's cell?
    sta cell_x                          ; ...as cell_x...
    lda hero_y,x                        ; ...and the hero's y...
    sta cell_y                          ; ...as cell_y
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack while X counts the keys
    ldx #max_key                        ; ...keys 20 to 1
; &1e45 referenced 1 time by &1ec1
.check_key
    lda key_x,x                         ; This key's x...
    cmp cell_x                          ; ...at the hero's x?
    bne next_key                        ; No: try the next key
    lda key_y,x                         ; ...and its y...
    cmp cell_y                          ; ...at the hero's y?
    bne next_key                        ; No: try the next key
    lda #spr_blank                      ; Yes: erase it from the floor
    sta sprite_number                   ; ...as the sprite to plot...
    lda #0                              ; ...on the cell itself: no pixel offset...
    sta plot_offset_x                   ; ...horizontally...
    sta plot_offset_y                   ; ...or vertically
    txa                                 ; Keep the key number...
    pha                                 ; ...on the stack across plot_at_cell
    jsr plot_at_cell                    ; Plot the blank in every view showing it
    pla                                 ; Recover the key number...
    tax                                 ; ...into X
    pla                                 ; Show the key icon in the hero's panel
    tay                                 ; ...into Y...
    pha                                 ; ...and back on the stack for later
    lda #spr_key_icon                   ; ...in the key icon sprite...
    sta sprite_number                   ; ...as the sprite to plot
    lda hero_panel_y,y                  ; ...using the hero's panel row...
    sec                                 ; ...set carry to subtract
    sbc #&0d                            ; ...less 13: the key icon's row...
    sta plot_y                          ; ...as plot_y
    lda #panel_left + 5                 ; ...in panel column panel_left + 5...
    sta plot_x                          ; ...as plot_x
    tya                                 ; Keep the hero number...
    pha                                 ; ...on the stack...
    txa                                 ; ...and the key number...
    pha                                 ; ...across plot_sprite
    jsr plot_sprite                     ; Plot the key icon
    pla                                 ; Recover the key number...
    tax                                 ; ...into X...
    pla                                 ; ...and the hero number...
    tay                                 ; ...into Y
    txa                                 ; Drop the key carried (if any) in this cell...
    pha                                 ; ...keeping the new key's number on the stack...
    ldx hero_key,y                      ; ...the old key, or entry 0 if none...
    lda hero_x,y                        ; ...goes to the hero's x...
    sta key_x,x                         ; ...as its x...
    lda hero_y,y                        ; ...and the hero's y...
    sta key_y,x                         ; ...as its y
    pla                                 ; Recover the new key's number...
    tax                                 ; ...into X, and in A to carry
    sta hero_key,y                      ; ...and carry the new one
    lda #1                              ; Mark the swap
    sta hero_key_dropped,y              ; ...so it isn't picked straight back up
    lda #off_map                        ; Take the new key off the floor
    sta key_x,x                         ; ...x off the map...
    sta key_y,x                         ; ...and y off the map
    ldx #<(key_envelope)                ; Play the key sound
    ldy #>(key_envelope)                ; ...ENVELOPE block high byte
    lda #osword_envelope                ; OSWORD 8: define the envelope
    jsr osword                          ; Define the key envelope  ENVELOPE command
    ldx #<(key_sound)                   ; SOUND key_sound: block address low...
    ldy #>(key_sound)                   ; ...and high
    lda #osword_sound                   ; OSWORD 7: SOUND
    jsr osword                          ; Play the key pickup sound  SOUND command
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    jmp next_hero_keys                  ; Next hero
; &1ebe referenced 2 times by &1e4b, &1e53
.next_key
    dex                                 ; Next key
    beq keys_done                       ; Keys all checked: this hero is done
    jmp check_key                       ; Otherwise check the next key
; &1ec4 referenced 1 time by &1ebf
.keys_done
    pla                                 ; Recover the hero number pushed above...
    tax                                 ; ...into X
; &1ec6 referenced 4 times by &1df0, &1e25, &1e32, &1ebb
.next_hero_keys
    inx                                 ; Next hero
    cpx #4                              ; All four heroes done?
    beq update_rest                     ; Yes: on with the rest of the frame
    jmp check_hero_keys                 ; No: check this hero's keys
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
; The rest of an f1 pause routine, never run since check_pause jumps to pause_check in
; Table.
    equb &60, &ff, &e0, &71, &d0, &15, &20, &f4
    equb &ff, &e0, &71, &f0, &f9, &20, &f4, &ff
    equb &e0, &71, &d0, &f9, &20, &f4, &ff, &e0
    equb &71, &f0, &f9, &60, &00        ; Not used
    equb &00, &00, &00, &00, &00        ; Not referenced
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
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &1f00 referenced 7 times by &0e65, &1f03, &1f9b, &1fef, &2023, &2037, &208e
.play_level
    lda os_vsync_counter                ; Wait for the vertical sync counter to pass zero...
    bpl play_level                      ; Not yet negative: keep waiting
    lda #2                              ; ...and set it for three syncs from now
    sta os_vsync_counter                ; ...in the MOS's vertical sync counter
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
    cmp #spr_digit_0 - 1                ; ...(health tens digit below 0)...
    bne next_hero_in_play               ; No: alive but out of play; next hero
    lda hero_frame - 1,x                ; ...with the death animation unfinished?
    cmp #8                              ; ...frame 8 is the last of the death
    bcc check_exit                      ; Yes: carry on
; &1f2a referenced 1 time by &1f21
.next_hero_in_play
    dex                                 ; Next hero
    bne count_heroes_in_play            ; More heroes: check the next
    ldx shrunk_hero                     ; The level is over: restore the last exiting hero's sprites
    bmi play_level_done                 ; None (&FF): nothing to restore
    jsr restore_hero_sprites            ; Give them back their full-size sprites
; &1f35 referenced 1 time by &1f30
.play_level_done
    rts                                 ; Return
; &1f36 referenced 3 times by &1f13, &1f1a, &1f28
.check_exit
    ldx #0                              ; Is a hero on the exit?
; &1f38 referenced 1 time by &1f94
.check_hero_on_exit
    lda hero_x,x                        ; The hero's x...
    cmp exit_x                          ; ...at the exit's x?
    bne next_hero_exit                  ; No: next hero
    lda hero_y,x                        ; ...and y...
    cmp exit_y                          ; ...at the exit's y?
    bne next_hero_exit                  ; No: next hero
    jsr drop_key                        ; Yes: drop their key beside it
    lda #step_out_of_play               ; Take them out of play for the rest of the level
    sta hero_step,x                     ; ...so they are never animated...
    lda #0                              ; ...and no direction...
    sta hero_direction,x                ; ...so move_heroes skips them
    lda hero_x,x                        ; Erase them
    sta cell_x                          ; ...from cell_x...
    lda hero_y,x                        ; ...and the hero's y...
    sta cell_y                          ; ...in cell_y...
    lda #0                              ; ...on the cell itself: no pixel offset...
    sta plot_offset_x                   ; ...horizontally...
    sta plot_offset_y                   ; ...or vertically...
    lda #spr_blank                      ; ...with the blank sprite
    sta sprite_number                   ; ...as the sprite to plot
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack across plot_at_cell
    jsr plot_at_cell                    ; Plot the blank in every view showing them
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    lda #off_map                        ; Move them off the map
    sta hero_x,x                        ; ...x off the map, so nothing meets them
    lda exit_x                          ; Hide the exit while they go down it, keeping its position
    sta exit_saved_x                    ; ...x saved...
    lda exit_y                          ; ...and its y...
    sta exit_saved_y                    ; ...saved too
    lda #off_map                        ; ...then put the exit off the map...
    sta exit_x                          ; ...x...
    sta exit_y                          ; ...and y, so no other hero can enter it
    jsr hero_enters_exit                ; Start the exit animation (which jumps back to play_level)
    jmp check_exit_busy                 ; Reached by the RTS at the end of the level
; &1f91 referenced 2 times by &1f3e, &1f46
.next_hero_exit
    inx                                 ; Next hero
    cpx #4                              ; All four heroes checked?
    bne check_hero_on_exit              ; No: check the next
; &1f96 referenced 1 time by &1f8e
.check_exit_busy
    lda exit_busy                       ; A hero going down the exit?
    bne redraw_exit                     ; Yes: redraw exit
    jmp play_level                      ; No: next frame
; &1f9e referenced 1 time by &1f99
.redraw_exit
    ldx exiting_hero                    ; Redraw the exit
    lda #0                              ; ...on its cell: no pixel offset...
    sta plot_offset_x                   ; ...horizontally...
    sta plot_offset_y                   ; ...or vertically...
    lda exit_saved_x                    ; ...at its saved x...
    sta cell_x                          ; ...as cell_x...
    lda exit_saved_y                    ; ...and saved y...
    sta cell_y                          ; ...as cell_y...
    lda #spr_exit                       ; ...with the exit sprite...
    sta sprite_number                   ; ...as the sprite to plot
    jsr plot_at_cell                    ; Plot it in every view showing it
    ldx exiting_hero                    ; Turn the hero a quarter (frames 1, 3, 5, 7)
    clc                                 ; ...clear carry for the add
    lda exit_spin                       ; ...from the current direction...
    adc #2                              ; ...two sprites on: the next direction...
    sta exit_spin                       ; ...kept for the next frame
    cmp #9                              ; A full turn?
    beq next_turn                       ; Yes: shrink the hero
    clc                                 ; Plot the hero on the exit, centred for its current size
    lda hero_sprites,x                  ; ...the hero's sprite base...
    adc exit_spin                       ; ...plus the direction's frame...
    sta sprite_number                   ; ...as the sprite to plot
    lda exit_saved_x                    ; ...on the exit's cell: its x...
    sta cell_x                          ; ...as cell_x...
    lda exit_saved_y                    ; ...and its y...
    sta cell_y                          ; ...as cell_y
    ldx exit_shrinks_left               ; ...with offsets for its size, by turns left...
    lda exit_offsets_x,x                ; ...horizontal offset...
    sta plot_offset_x                   ; ...as plot_offset_x...
    lda exit_offsets_y,x                ; ...vertical offset...
    sta plot_offset_y                   ; ...as plot_offset_y
    jsr plot_at_cell                    ; Plot the hero in every view showing the exit
    jmp play_level                      ; Next frame
; &1ff2 referenced 1 time by &1fc8
.next_turn
    lda #&ff                            ; Start the next turn
    sta exit_spin                       ; ...-1, so the next frame's +2 gives 1
    dec exit_shrinks_left               ; Last turn done?
    beq restore_exit                    ; Yes: the hero has gone
    clc                                 ; Shrink sprites base + 1 to + 7: a byte narrower...
    lda hero_sprites,x                  ; ...the hero's sprite base...
.dasmos_dunj4_end

    org &2000

.dasmos_dunj5_start
    adc #1                              ; ...+1: their first sprite...
    tay                                 ; ...in Y, for the height loop...
    tax                                 ; ...and in X, for the width loop
    adc #7                              ; ...+7: stop before base + 8, left frame 1
    sta scratch                         ; ...kept as the end
; &2009 referenced 1 time by &2010
.shrink_hero_width
    dec sprite_widths,x                 ; One byte narrower
    inx                                 ; Next sprite
    cpx scratch                         ; Reached the end?
    bne shrink_hero_width               ; No: narrow the next
    tya                                 ; Three rows shorter...
    tax                                 ; ...from the first sprite again
; &2014 referenced 1 time by &2021
.shrink_hero_height
    sec                                 ; ...set carry to subtract
    lda sprite_heights,x                ; This sprite's height...
    sbc #3                              ; ...less three rows...
    sta sprite_heights,x                ; ...stored back
    inx                                 ; Next sprite
    cpx scratch                         ; Reached the end?
    bne shrink_hero_height              ; No: shorten the next
    jmp play_level                      ; ...three rows shorter. Next frame
; &2026 referenced 1 time by &1ffa
.restore_exit
    lda exit_saved_x                    ; Put the exit back...
    sta exit_x                          ; ...x...
    lda exit_saved_y                    ; ...and its saved y...
    sta exit_y                          ; ...as its y
    lda #0                              ; ...and end the animation
    sta exit_busy                       ; ...exit no longer busy
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
    lda #4                              ; exit_offsets_x entry 0 = 4...
    sta exit_offsets_x                  ; ...never read: shrinks run from 4 down to 1
    ldx shrunk_hero                     ; Restore the sprites of any hero shrunk before
    bmi start_hero_animation            ; None (&FF): go straight on
    jsr restore_hero_sprites            ; Give that hero back their full-size sprites
    jmp start_hero_animation            ; ...then start this hero's spin
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
    clc                                 ; The hero's sprites base + 1 to base + 7
    lda hero_sprites,x                  ; ...the hero's sprite base...
    adc #1                              ; ...+1: their first sprite...
    tax                                 ; ...in X, for the height loop...
    tay                                 ; ...and in Y, for the width loop
    adc #7                              ; ...+7: stop before base + 8, left frame 1
    sta scratch                         ; ...kept as the end
    lda #4                              ; Widths back to 4...
; &205f referenced 1 time by &2066
.restore_sprite_widths
    sta sprite_widths,y                 ; Full width
    iny                                 ; Next sprite
    cpy scratch                         ; Reached the end?
    bne restore_sprite_widths           ; No: widen the next
    txa                                 ; ...from the first sprite again
    tay                                 ; ...into Y
    lda #&0c                            ; ...heights back to 12
; &206c referenced 1 time by &2073
.restore_sprite_heights
    sta sprite_heights,y                ; Full height
    iny                                 ; Next sprite
    cpy scratch                         ; Reached the end?
    bne restore_sprite_heights          ; No: restore the next
    rts                                 ; Return
; &2076 referenced 2 times by &2048, &204d
.start_hero_animation
    lda #1                              ; Start the animation for this hero...
    sta exit_busy                       ; ...the exit is busy...
    lda scratch2                        ; ...the hero kept by hero_enters_exit...
    sta exiting_hero                    ; ...is the one going down...
    sta shrunk_hero                     ; ...and the one whose sprites will shrink
    lda #&ff                            ; ...turning from the start...
    sta exit_spin                       ; ...-1, so the first frame's +2 gives 1
    lda #4                              ; ...for four turns
    sta exit_shrinks_left               ; ...as exit_shrinks_left
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
    sta cell_x                          ; ...as cell_x...
    lda hero_y,x                        ; ...and the hero's y...
    sta cell_y                          ; ...as cell_y
    txa                                 ; ...find a free cell next to it
    pha                                 ; Keep the hero number...
    jsr find_open_neighbour             ; ...on the stack across the search
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    ldy hero_key,x                      ; Put the hero's key there
    lda cell_x                          ; ...the free cell's x...
    sta key_x,y                         ; ...as the key's x...
    lda cell_y                          ; ...and its y...
    sta key_y,y                         ; ...as the key's y
    lda #0                              ; The hero carries no key
    sta hero_key,x                      ; ...in the hero's key slot
    lda #spr_blank_key_icon             ; Erase the key icon from the panel
    sta sprite_number                   ; ...as the sprite to plot
    lda hero_panel_y,x                  ; ...using the hero's panel row...
    sec                                 ; ...set carry to subtract
    sbc #&0d                            ; ...less 13: the key icon's row...
    sta plot_y                          ; ...as plot_y
    lda #panel_left + 5                 ; ...in panel column panel_left + 5...
    sta plot_x                          ; ...as plot_x
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack across plot_sprite
    jsr plot_sprite                     ; Plot the blank icon over the key icon
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    rts                                 ; Return
; ***************************************************************************************
; Find a free cell next to a cell
;
; Starting with cell_x, cell_y, try the cells above, to the right, below and to the left,
; and leave cell_x, cell_y at the first without a wall.
;
; On Entry:
;     CELL_X: cell x
;     CELL_Y: cell y
;
; On Exit:
;     CELL_X: x of the first free neighbour, trying above, right and below; otherwise the cell to the left, unchecked
;     CELL_Y: its y
;     Y: 0 if a free neighbour was found
;     A: corrupted
;     X: corrupted
; &20d0 referenced 1 time by &209f
.find_open_neighbour
    dec cell_y                          ; The cell above
    jsr test_wall                       ; ...free?
    cpy #0                              ; Y = 0 if no wall there
    bne try_cell_right                  ; No: try cell right
    rts                                 ; Yes: return
; &20db referenced 1 time by &20d8
.try_cell_right
    inc cell_y                          ; The cell to the right
    inc cell_x                          ; ...x + 1 (y back to the hero's row)
    jsr test_wall                       ; ...free?
    cpy #0                              ; Y = 0 if no wall there
    bne try_cell_below                  ; No: try cell below
    rts                                 ; Yes: return
; &20e9 referenced 1 time by &20e6
.try_cell_below
    dec cell_x                          ; The cell below
    inc cell_y                          ; ...y + 1 (x back to the hero's column)
    jsr test_wall                       ; ...free?
    cpy #0                              ; Y = 0 if no wall there
    bne try_cell_left                   ; No: try cell left
    rts                                 ; Yes: return
; &20f7 referenced 1 time by &20f4
.try_cell_left
    dec cell_y                          ; Otherwise the cell to the left
    dec cell_x                          ; ...x - 1: unchecked, the last resort
    rts                                 ; Return
    equb &01, &3f                       ; Not referenced
; &2100 used as index base 1 time by &15ce
.object_free_map
    equb &00, &02, &07, &07, &1f, &3f, &7d, &7f, &00, &30, &78, &fd, &7f, &ff, &80, &00  ; Not read: unpack_level copies each level's object-free map here
    equb &00, &60, &e0, &c0, &df, &c0, &1f, &0f, &00, &58, &58, &58, &d8, &18, &f8, &80  ; ...entries 16-31, not read
    equb &76, &3e, &5f, &6e, &7e, &00, &7f, &7f, &00, &66, &66, &7e, &7e, &66, &66, &00  ; ...entries 32-47, not read
    equb &1f, &1f, &03, &03, &ff, &03, &03, &03, &80, &80, &80, &80, &80, &f6, &fe, &f6  ; ...entries 48-63, not read
    equb &7f, &00, &3f, &2f, &37, &37, &2f, &37, &c0, &03, &c4, &86, &40, &00, &80, &c1  ; ...entries 64-79, not read
    equb &03, &e3, &e0, &e1, &41, &41, &00, &ff, &fe, &fe, &00, &00, &00, &00, &00, &8a  ; ...entries 80-95, not read
    equb &00, &00, &00, &00, &7e, &7f, &7e, &00, &01, &01, &01, &3f, &3f, &bf, &3f, &3f  ; ...entries 96-111, not read
    equb &f7, &ff, &c1, &f7, &c1, &ff, &f7, &bf, &8e, &9e, &de, &9c, &9e, &8e, &8e, &80  ; ...entries 112-127, not read
    equb &7e, &3e, &7e, &00, &7c, &7a, &7e, &00, &2f, &1f, &00, &00, &00, &ce, &ae, &5e  ; ...entries 128-143, not read
    equb &1f, &1f, &1f, &1b, &17, &1f, &00, &01, &80, &80, &80, &80, &80, &80, &02, &02  ; ...entries 144-159, not read
    equb &7e, &7a, &7e, &00, &7e, &3e, &7f, &00, &be, &0e, &0e, &0f, &0e, &0e, &be, &00  ; ...entries 160-175, not read
    equb &01, &01, &0f, &df, &07, &03, &01, &00, &08, &08, &5a, &fe, &fe, &fc, &b8, &00  ; ...entries 176-191, not read
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00  ; ...entries 192-200, not read
    equb &08, &2a, &00, &00, &00, &00, &00  ; Not referenced
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
    equb &ff, &ff, &ff, &04, &ff, &ff, &06, &ff, &11, &ff, &ff, &ff, &1a, &03, &03, &0b  ; Not read: unpack_level copies each level's doors here
    equb &ff, &03, &09, &12, &ff        ; ...entries 16-20, not read
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff                  ; Not referenced
; &2220 used as index base 4 times by &1593, &1ce3, &1d8e, &7804
.door_y
    equb &ff, &ff, &ff, &0d, &ff, &ff, &11, &ff, &16, &ff, &ff, &ff, &1a, &23, &27, &25  ; Not read: unpack_level copies each level's doors here
    equb &ff, &2b, &2e, &2b, &ff        ; ...entries 16-20, not read
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff                  ; Not referenced
; &2240 used as index base 2 times by &1599, &7810
.door_sprite
    equb &ff, &1c, &1c, &1d, &1c, &1c, &1d, &1d, &1d, &1d, &1d, &1c, &1c, &1d, &1d, &1c  ; Not read: unpack_level copies each level's door sprites here
    equb &1d, &1d, &1c, &1c, &ff        ; ...entries 16-20, not read
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff                  ; Not referenced
; &2260 used as index base 7 times by &15a4, &1dce, &1e00, &1e45, &1e8c, &1ea1, &20aa
.key_x
    equb &13, &ff, &ff, &1b, &ff, &ff, &17, &ff, &1c, &ff, &ff, &ff, &02, &15, &04, &09  ; Not read: unpack_level copies each level's keys here
    equb &ff, &04, &19, &17, &ff        ; ...entries 16-20, not read
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff                  ; Not referenced
; &2280 used as index base 7 times by &15aa, &1dd4, &1e06, &1e4d, &1e92, &1ea4, &20b0
.key_y
    equb &25, &ff, &ff, &06, &ff, &ff, &09, &ff, &18, &ff, &ff, &ff, &29, &04, &0c, &14  ; Not read: unpack_level copies each level's keys here
    equb &ff, &0f, &03, &04, &ff        ; ...entries 16-20, not read
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff                  ; Not referenced
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
; ***************************************************************************************
; Unused
;
; Zero bytes, which nothing reads.
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00  ; Zeros
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
    equb &05, &00, &00, &0a, &00, &0f, &0f, &00  ; Not referenced
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
    equb &00, &0c, &08, &00, &04, &0f, &0e, &00  ; Not referenced
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
    equb &0f, &1a, &30, &20, &00, &00, &00, &25  ; Not referenced
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
    equb &20, &00, &00, &00, &fd, &14, &93, &00  ; Not referenced
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
    equb &17, &00, &00, &00, &00, &00, &00, &00  ; Not referenced
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
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &6e80 referenced 1 time by &1cc0
.move_heroes
    ldx #0                              ; For each hero...
; &6e82 referenced 1 time by &70c6
.move_hero
    lda hero_direction,x                ; In play?
    bne remember_hero_position          ; Yes: remember hero position
    lda hero_step,x                     ; Out of play: never playing (step &63)?
    cmp #step_out_of_play               ; Step &63 marks a hero nobody plays
    bne animate_absent                  ; Not &63: the hero is dying or returning
    jmp next_hero                       ; Yes: nothing to do
; &6e91 referenced 1 time by &6e8c
.animate_absent
    jsr animate_absent_hero             ; No: dying or returning, so animate them
    jmp next_hero                       ; Then on to the next hero
; &6e97 referenced 1 time by &6e85
.remember_hero_position
    lda hero_x,x                        ; Remember the hero's position and offsets before moving
    sta previous_x                      ; previous_x: where to put the hero back if blocked
    lda hero_y,x                        ; Same for the hero's y...
    sta previous_y                      ; ...into previous_y
    lda hero_offset_x,x                 ; And the pixel offset across...
    sta previous_offset_x               ; ...kept so the old position can be erased
    lda hero_offset_y,x                 ; And the pixel offset down...
    sta previous_offset_y               ; ...kept with it
    lda hero_step,x                     ; Part way through a step?
    beq check_magic_key                 ; No: read the keys
    jsr continue_hero_step              ; Yes: continue it...
    jmp erase_hero                      ; ...and redraw
; &6eba referenced 1 time by &6eb2
.check_magic_key
    cpx #2                              ; Heroes 0 and 1 check their magic key first
    bcs read_hero_keys                  ; Heroes 2 and 3 have no magic: straight to the keys
    jmp check_magic                     ; Heroes 0 and 1: check the magic key first
; &6ec1 referenced 2 times by &6ebc, &76ab
.read_hero_keys
    lda hero_key_up,x                   ; Up key?
    jsr test_key                        ; Scan it: Z set if held
    bne check_key_down                  ; No: check key down
    lda #1                              ; Yes: face up...
    sta hero_direction,x                ; Direction 1 means up
    jsr start_hero_step                 ; ...start the step...
    jmp step_hero                       ; ...and move
; &6ed4 referenced 1 time by &6ec7
.check_key_down
    lda hero_key_down,x                 ; Down key?
    jsr test_key                        ; Scan it: Z set if held
    bne check_key_right                 ; No: check key right
    lda #5                              ; Yes: face down...
    sta hero_direction,x                ; Direction 5 means down
    jsr start_hero_step                 ; ...start the step...
    jmp step_hero                       ; ...and move
; &6ee7 referenced 1 time by &6eda
.check_key_right
    lda hero_key_right,x                ; Right key?
    jsr test_key                        ; Scan it: Z set if held
    bne check_key_left                  ; No: check key left
    lda #3                              ; Yes: face right...
    sta hero_direction,x                ; Direction 3 means right
    jsr start_hero_step                 ; ...start the step...
    jmp step_hero                       ; ...and move
; &6efa referenced 1 time by &6eed
.check_key_left
    lda hero_key_left,x                 ; Left key?
    jsr test_key                        ; Scan it: Z set if held
    bne check_key_fire                  ; No: check key fire
    lda #7                              ; Yes: face left...
    sta hero_direction,x                ; Direction 7 means left
    jsr start_hero_step                 ; ...start the step...
    jmp step_hero                       ; ...and move
; &6f0d referenced 1 time by &6f00
.check_key_fire
    lda hero_key_fire,x                 ; Fire key?
    jsr test_key                        ; Scan it: Z set if held
    beq fire_missile                    ; Yes: fire missile
    jmp draw_moved_hero                 ; No key: just redraw the hero
; &6f18 referenced 1 time by &6f13
.fire_missile
    txa                                 ; This hero's missile slots are 3x to 3x + hero_max_missiles - 1
    sta scratch                         ; Keep the hero number...
    asl a                               ; ...double it...
    clc                                 ; ...(no carry in)...
    adc scratch                         ; ...and add it again: 3 x hero, the first slot
    tay                                 ; Y = the hero's first missile slot
    adc hero_max_missiles,x             ; Add the number of missiles the hero may have...
    sta scratch                         ; ...end of the range
; &6f28 referenced 1 time by &6f74
.find_missile_slot
    lda missile_direction,y             ; Slot free?
    bne next_missile_slot               ; No: try the next
    lda hero_direction,x                ; Missile direction = (hero direction + 1) / 2, so 1-4, with bit 7 marking it just fired
    clc                                 ; Direction 1, 3, 5 or 7...
    adc #1                              ; ...plus 1...
    lsr a                               ; ...halved: missile direction 1-4
    ora #&80                            ; Bit 7: just fired, so not erased off the hero
    sta missile_direction,y             ; The slot is now in use
    lda hero_x,x                        ; It starts at the hero's cell
    sta missile_x,y                     ; Missile x = hero x
    lda hero_y,x                        ; And the hero's y...
    sta missile_y,y                     ; ...is the missile's y
    nop                                 ; Padding: no bell when a missile is fired
    nop                                 ; Padding: does nothing
    nop                                 ; Padding: does nothing
    nop                                 ; Padding: does nothing
    nop                                 ; Padding: does nothing
    lda hero_missile_damage,x           ; The missile carries the hero's missile damage...
    sta missile_damage,y                ; ...into this missile, for whatever it hits
    lda hero_missile_sprites,x          ; ...and sprites
    sta missile_sprite_base,y           ; ...so it is drawn as the hero's weapon
    lda previous_x                      ; The hero stays where they were
    sta hero_x,x                        ; Hero x unchanged: firing does not move the hero
    lda previous_y                      ; And the hero's y...
    sta hero_y,x                        ; ...unchanged too
    lda hero_frame,x                    ; Toggle the hero's frame
    eor #1                              ; Flip between frames 0 and 1...
    sta hero_frame,x                    ; ...so the hero is seen to throw
    jmp draw_moved_hero                 ; Redraw the hero
    equb &88, &d0, &b8                  ; Not referenced
; &6f70 referenced 1 time by &6f2b
.next_missile_slot
    iny                                 ; Next slot
    cpy scratch                         ; Past the hero's last slot?
    bne find_missile_slot               ; No: try that slot
    jmp draw_moved_hero                 ; All in flight: just redraw the hero
; &6f79 referenced 4 times by &6ed1, &6ee4, &6ef7, &6f0a
.step_hero
    lda hero_direction,x                ; Move the hero's cell in the direction faced: up...
    cmp #1                              ; Facing up?
    bne step_right                      ; No: try right
    dec hero_y,x                        ; Up: one row up the map
; &6f83 referenced 1 time by &6f7e
.step_right
    cmp #3                              ; ...right...
    bne step_down                       ; Facing right?
    inc hero_x,x                        ; Right: one column along
; &6f8a referenced 1 time by &6f85
.step_down
    cmp #5                              ; ...down...
    bne step_left                       ; Facing down?
    inc hero_y,x                        ; Down: one row down the map
; &6f91 referenced 1 time by &6f8c
.step_left
    cmp #7                              ; ...left
    bne note_new_cell                   ; Facing left?
    dec hero_x,x                        ; Left: one column back
; &6f98 referenced 1 time by &6f93
.note_new_cell
    lda hero_x,x                        ; Note the new cell for the door and key checks
    sta hero_door_x,x                   ; hero_door_x: the cell update_game tests for doors
    lda hero_y,x                        ; And the new y...
    sta hero_door_y,x                   ; ...into hero_door_y
    lda hero_x,x                        ; Is there a wall in the new cell?
    sta cell_x                          ; cell_x: the cell for test_wall
    lda hero_y,x                        ; And the new y...
    sta cell_y                          ; ...into cell_y
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack across test_wall
    jsr test_wall                       ; Y non-zero if the cell has a wall
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    cpy #0                              ; Wall bit clear?
    beq check_monster_in_cell           ; No: check monster in cell
    lda previous_x                      ; Yes: stay put...
    sta hero_x,x                        ; ...put the hero back at x...
    lda previous_y                      ; And the old y...
    sta hero_y,x                        ; ...so the hero does not enter the wall
; &6fc7 referenced 1 time by &7050
.cancel_hero_step
    lda #0                              ; Cancel the step
    sta hero_step,x                     ; No step under way...
    sta hero_offset_x,x                 ; ...no horizontal offset...
    sta hero_offset_y,x                 ; ...and no vertical offset
    jmp erase_hero                      ; ...and redraw
; &6fd5 referenced 1 time by &6fb9
.check_monster_in_cell
    lda #0                              ; Is there a monster in the new cell?
    sta scratch                         ; scratch 0: look for monsters only, not heroes
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack across find_creature
    jsr find_creature                   ; Y non-zero if a monster is in the cell
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    cpy #0                              ; A monster there?
    beq check_hero_in_cell              ; No: check hero in cell
    lda previous_x                      ; Yes: stay put, cancel the step...
    sta hero_x,x                        ; ...x back to the old cell...
    lda previous_y                      ; And the old y...
    sta hero_y,x                        ; ...so the hero stays out of the monster's cell
    lda #0                              ; No step under way...
    sta hero_step,x                     ; ...clear the step...
    sta hero_offset_x,x                 ; ...the horizontal offset...
    sta hero_offset_y,x                 ; ...and the vertical offset
    jsr lose_health_point               ; ...and lose a health point for bumping into it
    jmp erase_hero                      ; Redraw
; &7002 referenced 1 time by &6fe3
.check_hero_in_cell
    stx scratch                         ; Is another hero in play in the new cell?
    ldy #0                              ; Start from hero 0
; &7007 referenced 1 time by &703e
.check_other_hero
    cpy scratch                         ; Not this hero
    beq next_other_hero                 ; This hero: skip it
    lda hero_x,y                        ; Other hero's x...
    cmp cell_x                          ; ...the same as the new cell's?
    bne next_other_hero                 ; No: not in the way
    lda hero_y,y                        ; Other hero's y...
    cmp cell_y                          ; ...the same too?
    bne next_other_hero                 ; No: not in the way
    lda hero_direction,y                ; Is that hero in play?
    beq next_other_hero                 ; No (dead or absent): not in the way
    lda previous_x                      ; Yes: stay put, cancel the step and redraw
    sta hero_x,x                        ; ...x back to the old cell...
    lda previous_y                      ; And the old y...
    sta hero_y,x                        ; ...so heroes never share a cell
    lda #0                              ; No step under way...
    sta hero_step,x                     ; ...clear the step...
    sta hero_offset_x,x                 ; ...the horizontal offset...
    sta hero_offset_y,x                 ; ...and the vertical offset
    jmp erase_hero                      ; ...and redraw the hero
; &703b referenced 4 times by &700a, &7012, &701a, &701f
.next_other_hero
    iny                                 ; Next hero
    cpy #4                              ; Checked all four?
    bne check_other_hero                ; No: the next one
    txa                                 ; Has the hero moved into another room?
    asl a                               ; Two bytes per view_room entry...
    tax                                 ; ...so X indexes this hero's
    lda view_room,x                     ; The room this hero's view shows (low byte)...
    cmp map_ptr                         ; ...against the new cell's room, from test_wall
    beq check_boots                     ; No: check boots
    txa                                 ; Yes: change this hero's view to the new room...
    lsr a                               ; Halve the index...
    tax                                 ; ...back to the hero number
    jsr show_hero_room                  ; Point the hero's view at the new room and redraw it
    jmp cancel_hero_step                ; ...and cancel the step
; &7053 referenced 1 time by &7048
.check_boots
    txa                                 ; Same room. Wearing Boots of Speed?
    lsr a                               ; Halve the view index...
    tax                                 ; ...back to the hero number
    lda hero_has_boots,x                ; Non-zero while the hero wears the boots
    beq stay_in_old_cell                ; No: stay in old cell
    lda #0                              ; Yes: arrive in the cell at once, with no step
    sta hero_offset_x,x                 ; No horizontal offset...
    sta hero_offset_y,x                 ; ...no vertical offset...
    sta hero_step,x                     ; ...and no step: the move is complete
    jmp erase_hero                      ; Erase the old position and draw the new
; &7069 referenced 1 time by &7059
.stay_in_old_cell
    lda previous_x                      ; No boots: stay in the old cell for now; continue_hero_step moves on at the end of the step
    sta hero_x,x                        ; ...the step's pixel offsets carry the hero across
    lda previous_y                      ; And the old y...
    sta hero_y,x                        ; ...until the step finishes
; &7075 referenced 5 times by &6eb7, &6fd2, &6fff, &7038, &7066
.erase_hero
    lda #spr_blank                      ; Erase the hero at the old position (blank sprite)
    sta sprite_number                   ; The sprite to plot over the hero
    lda previous_x                      ; The hero's position before this frame...
    sta cell_x                          ; ...as the cell to plot at
    lda previous_y                      ; And the old y...
    sta cell_y                          ; ...into cell_y
    lda previous_offset_x               ; The old pixel offsets too...
    sta plot_offset_x                   ; ...across...
    lda previous_offset_y               ; ...and down...
    sta plot_offset_y                   ; ...so the blank lands exactly on the old image
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack across plot_at_cell
    jsr plot_at_cell                    ; Blank the hero in every view showing that cell
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
; &7096 referenced 4 times by &6f15, &6f6a, &6f76, &76ae
.draw_moved_hero
    clc                                 ; Still in play?
    lda hero_direction,x                ; Direction 0: out of play
    beq next_hero                       ; No: next hero
    adc hero_frame,x                    ; Sprite = direction + frame + the hero's sprite base
    adc hero_sprites,x                  ; ...plus Ranger, Magic-User, Barbarian or Fighter base
    sta sprite_number                   ; The sprite to draw
    jsr draw_hero                       ; Draw the hero
    lda hero_x,x                        ; Can the hero's cell hold an object?
    sta cell_x                          ; The hero's cell, to test for an object...
    lda hero_y,x                        ; And the hero's y...
    sta cell_y                          ; ...into cell_y
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack across test_object_free
    jsr test_object_free                ; Y zero if an object may lie in the cell
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    cpy #0                              ; Can an object lie there?
    bne next_hero                       ; No: next hero
    jsr collect_objects                 ; Yes: pick up whatever is there
; &70c1 referenced 4 times by &6e8e, &6e94, &709a, &70bc
.next_hero
    inx                                 ; Next hero
    cpx #4                              ; All four heroes moved?
    beq move_heroes_done                ; Yes: done
    jmp move_hero                       ; No: move the next hero
; &70c9 referenced 1 time by &70c4
.move_heroes_done
    rts                                 ; Return
; ***************************************************************************************
; Move the missiles
;
; Advance every missile in flight one cell. A missile stops at a wall, damages a monster
; or hero it meets, and bounces back off an energy drainer, wearing it down.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &70ca referenced 1 time by &1ed1
.move_missiles
    lda #0                              ; No pixel offsets for missiles
    sta plot_offset_x                   ; Missiles are drawn whole cells at a time...
    sta plot_offset_y                   ; ...so no vertical offset either
    ldx #0                              ; For each of the twelve missile slots...
; &70d2 referenced 1 time by &721d
.move_missile
    lda missile_direction,x             ; In flight?
    bne check_just_fired                ; Yes: check just fired
    jmp next_missile                    ; No: next slot
; &70da referenced 1 time by &70d5
.check_just_fired
    bpl erase_missile                   ; Just fired (bit 7 set)?
    and #&7f                            ; Yes: clear the flag...
    sta missile_direction,x             ; Store the direction without the flag
    jsr flip_firer_frame                ; ...animate the hero who fired it...
    jmp missile_up                      ; ...and move it without erasing (it is on the hero)
; &70e7 referenced 1 time by &70da
.erase_missile
    lda #spr_blank                      ; Erase the missile at its old cell
    sta sprite_number                   ; The sprite to plot over the missile
    lda missile_x,x                     ; The missile's x...
    sta cell_x                          ; ...as the cell to plot at
    lda missile_y,x                     ; And its y...
    sta cell_y                          ; ...into cell_y
    txa                                 ; Keep the missile slot...
    pha                                 ; ...on the stack across plot_at_cell
    jsr plot_at_cell                    ; Blank it in every view showing that cell
    pla                                 ; Recover the missile slot...
    tax                                 ; ...into X
; &70fe referenced 1 time by &70e4
.missile_up
    lda missile_direction,x             ; Move it one cell: up...
    cmp #1                              ; Direction 1: up
    bne missile_right                   ; No: try right
    dec missile_y,x                     ; Up: one row up the map
; &7108 referenced 1 time by &7103
.missile_right
    cmp #2                              ; ...right...
    bne missile_down                    ; No: try down
    inc missile_x,x                     ; Right: one column along
; &710f referenced 1 time by &710a
.missile_down
    cmp #3                              ; ...down...
    bne missile_left                    ; No: try left
    inc missile_y,x                     ; Down: one row down the map
; &7116 referenced 1 time by &7111
.missile_left
    cmp #4                              ; ...left
    bne check_missile_wall              ; No: it has moved
    dec missile_x,x                     ; Left: one column back
; &711d referenced 1 time by &7118
.check_missile_wall
    lda missile_x,x                     ; Wall in the new cell?
    sta cell_x                          ; ...as the cell to test
    lda missile_y,x                     ; And its y...
    sta cell_y                          ; ...into cell_y
    txa                                 ; Keep the missile slot...
    pha                                 ; ...on the stack across the tests
    jsr test_wall                       ; Z set if the cell is clear of walls
    beq check_missile_monster           ; No: check missile monster
; &7130 referenced 2 times by &71fe, &75ab
.missile_spent_pop
    pla                                 ; Yes: the missile is spent
    tax                                 ; Recover the missile slot
; &7132 referenced 1 time by &7153
.missile_spent
    lda #0                              ; Free the slot
    sta missile_direction,x             ; Direction 0: the slot is empty
    jmp next_missile                    ; Next slot
; &713a referenced 1 time by &712e
.check_missile_monster
    lda #0                              ; Monster in the new cell (not checking heroes)?
    sta scratch                         ; scratch 0: look for monsters only, not heroes
    jsr find_creature                   ; Z clear, X = the monster, if one is in the cell
    beq check_missile_object            ; No: check missile object
    lda monster_sprite,x                ; Yes, but is it alive?
    cmp #spr_sparkle_0                  ; Sprites from the first sparkle on are dying
    bcs check_missile_object            ; No: fly on
    pla                                 ; Alive: hit it
    tay                                 ; Y = the missile slot, for monster_hit
    jmp monster_hit                     ; Take its damage from the monster's hit points
; &7150 referenced 1 time by &75a3
.monster_killed
    jsr credit_missile_owner            ; Monster killed: a point to the hero who fired...
    jmp missile_spent                   ; ...and the missile is spent
; &7156 referenced 2 times by &7142, &7149
.check_missile_object
    pla                                 ; Can the new cell hold an object?
    tax                                 ; Recover the missile slot
    lda missile_x,x                     ; The missile's x...
    sta cell_x                          ; ...as the cell to test
    lda missile_y,x                     ; And its y...
    sta cell_y                          ; ...into cell_y
    txa                                 ; Keep the missile slot...
    pha                                 ; ...on the stack across test_object_free
    jsr test_object_free                ; Y zero if an object may lie in the cell
    pla                                 ; Recover the missile slot...
    tax                                 ; ...into X
    cpy #0                              ; Can an object lie there?
    bne check_missile_hero              ; No: check for heroes
    txa                                 ; Look for an energy drainer at the cell...
    pha                                 ; Keep the missile slot while X runs over objects
    ldx #max_object                     ; ...objects 30 to 1
; &7173 referenced 1 time by &71d5
.check_object_drainer
    lda object_x,x                      ; This object's x...
    cmp cell_x                          ; ...the missile's cell?
    bne next_object_drainer             ; No: the next object
    lda object_y,x                      ; This object's y...
    cmp cell_y                          ; ...the missile's cell too?
    bne next_object_drainer             ; No: the next object
    lda object_type,x                   ; Is it a drainer (&53-&5E)?
    cmp #spr_drainer_0                  ; Below the drainer sprites?
    bcc no_drainer                      ; No: no drainer
    cmp #spr_drainer_11 + 1             ; Past the last drainer stage?
    bcs no_drainer                      ; No: no drainer
    inc object_type,x                   ; Yes: wear it down a stage
    lda object_type,x                   ; Its new stage...
    cmp #spr_drainer_11 + 1             ; Worn away?
    bne credit_drainer_hit              ; No: credit drainer hit
    lda #off_map                        ; Yes: remove it from the level
    sta object_x,x                      ; Off the map in x...
    sta object_y,x                      ; ...and y, so it is never drawn or met again
; &71a0 referenced 1 time by &7196
.credit_drainer_hit
    pla                                 ; A point to the hero who fired
    tax                                 ; Recover the missile slot
    jsr credit_missile_owner            ; Which hero's weapon it is decides who scores
    lda missile_direction,x             ; Bounce the missile back: up becomes down...
    cmp #1                              ; Flying up?
    bne reverse_right                   ; No: try right
    lda #3                              ; Down instead
    sta missile_direction,x             ; Send it back the way it came
    jmp check_missile_hero              ; Then see whether it hits a hero
; &71b4 referenced 1 time by &71aa
.reverse_right
    cmp #2                              ; ...right becomes left...
    bne reverse_down                    ; No: try down
    lda #4                              ; Left instead
    sta missile_direction,x             ; Send it back the way it came
    jmp check_missile_hero              ; Then see whether it hits a hero
; &71c0 referenced 1 time by &71b6
.reverse_down
    cmp #3                              ; ...down becomes up...
    bne reverse_left                    ; No: it was flying left
    lda #1                              ; Up instead
    sta missile_direction,x             ; Send it back the way it came
    jmp check_missile_hero              ; Then see whether it hits a hero
; &71cc referenced 1 time by &71c2
.reverse_left
    lda #2                              ; ...and left becomes right
    sta missile_direction,x             ; Send it back the way it came
    jmp check_missile_hero              ; Then see whether it hits a hero
; &71d4 referenced 2 times by &7179, &7181
.next_object_drainer
    dex                                 ; Next object
    bne check_object_drainer            ; Until all 30 are checked
; &71d7 referenced 2 times by &7188, &718c
.no_drainer
    pla                                 ; No drainer here
    tax                                 ; Recover the missile slot
; &71d9 referenced 5 times by &716d, &71b1, &71bd, &71c9, &71d1
.check_missile_hero
    txa                                 ; Is a hero in the new cell?
    pha                                 ; Keep the missile slot while X runs over heroes
    ldx #0                              ; From hero 0
; &71dd referenced 1 time by &7204
.check_hero_hit
    pla                                 ; Fetch the missile slot...
    tay                                 ; ...into Y...
    pha                                 ; ...leaving it on the stack
    lda hero_x,x                        ; This hero's x...
    cmp cell_x                          ; ...the missile's cell?
    bne next_hero_hit                   ; No: the next hero
    lda hero_y,x                        ; This hero's y...
    cmp cell_y                          ; ...the missile's cell too?
    bne next_hero_hit                   ; No: the next hero
    lda missile_damage,y                ; Yes: they lose the missile's damage in health...
    tay                                 ; Y counts the points to take
; &71f4 referenced 1 time by &71fc
.take_missile_damage
    tya                                 ; Keep the count...
    pha                                 ; ...on the stack across the call
    jsr lose_health_point               ; One point of health
    pla                                 ; Recover the count...
    tay                                 ; ...into Y
    dey                                 ; One fewer to take
    bne take_missile_damage             ; More to take: again
    jmp missile_spent_pop               ; ...and the missile is spent
; &7201 referenced 2 times by &71e6, &71ee
.next_hero_hit
    inx                                 ; Next hero
    cpx #4                              ; All four heroes checked?
    bne check_hero_hit                  ; No: check the next hero against the missile's cell
    pla                                 ; Nothing hit: draw the missile in its new cell
    tax                                 ; Missile slot back in X
    clc                                 ; Sprite = the missile's base...
    lda missile_sprite_base,x           ; ...(its hero's weapon, the sprite before its up sprite)...
    adc missile_direction,x             ; ...plus its direction, 1-4: the weapon pointing that way
    sta sprite_number                   ; ...is the sprite to plot
    txa                                 ; Keep the missile slot...
    pha                                 ; ...across the plot
    jsr plot_at_cell                    ; Plot the missile in every view showing its cell
    pla                                 ; Recover the missile slot...
    tax                                 ; ...into X
; &7218 referenced 2 times by &70d7, &7137
.next_missile
    inx                                 ; Next slot
    cpx #&0c                            ; Past the twelfth slot?
    beq move_missiles_done              ; Yes: every missile moved
    jmp move_missile                    ; No: move this slot's missile
; &7220 referenced 1 time by &721b
.move_missiles_done
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
    bne take_health_unit                ; Yes: take health unit
    rts                                 ; No: return
; &7227 referenced 1 time by &7224
.take_health_unit
    dec hero_health_units,x             ; Take one from the units digit
    lda hero_health_units,x             ; ...and look at the new units digit
    cmp #spr_digit_0 - 1                ; Below 0?
    bne draw_health                     ; No: redraw
    lda #spr_digit_9                    ; Yes: units 9...
    sta hero_health_units,x             ; ...so the units wrap from 0 to 9
    dec hero_health_tens,x              ; ...and take one from the tens
    lda hero_health_tens,x              ; ...and look at the new tens digit
    cmp #spr_digit_0 - 1                ; Below 0: the hero has died
    bne draw_health                     ; No: redraw
    lda #spr_blank                      ; Erase the hero...
    sta sprite_number                   ; ...by plotting the blank sprite...
    jsr draw_hero                       ; ...at the hero's cell in every view
    lda #0                              ; ...take them out of play...
    sta hero_direction,x                ; ...direction 0 means not in play
    lda #1                              ; ...and start the death animation: step +1 through hero_appearance_sprites, every other frame
    sta hero_offset_x,x                 ; ...frame step +1: forwards through the sprites...
    sta hero_offset_y,x                 ; ...frame counter 1: the first step comes next frame
    ldy #0                              ; Add hero number + 1 at the end of returning_hero_queue
; &7256 referenced 1 time by &7264
.find_queue_slot
    lda returning_hero_queue,y          ; Look at this queue entry...
    bne next_queue_slot                 ; In use: try the next entry
    txa                                 ; Empty: hero number...
    clc                                 ; ...plus one...
    adc #1                              ; ...(entries are hero + 1, so 0 can mean empty)...
    sta returning_hero_queue,y          ; ...queued behind those already waiting
    rts                                 ; Return
; &7263 referenced 1 time by &7259
.next_queue_slot
    iny                                 ; Next queue entry
    bne find_queue_slot                 ; Keep looking (an empty entry is always found)
; &7266 referenced 3 times by &722f, &723e, &73a2
.draw_health
    lda hero_panel_y,x                  ; Draw the health: tens digit at column &45...
    sta plot_y                          ; ...on the top row of the hero's panel section...
    lda #panel_left                     ; ...in the panel's left column...
    sta plot_x                          ; ...as the plotting column
    lda hero_health_tens,x              ; ...as a digit sprite
    sta sprite_number                   ; ...as the sprite to plot
    txa                                 ; Keep the hero number...
    pha                                 ; ...across the plot
    jsr plot_sprite                     ; Plot the tens digit
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    lda hero_health_units,x             ; ...units digit at column &48
    sta sprite_number                   ; ...as the sprite to plot
    lda #panel_left + 3                 ; ...three columns right of the tens...
    sta plot_x                          ; ...on the same row
    txa                                 ; Keep the hero number...
    pha                                 ; ...across the plot
    jsr plot_sprite                     ; Plot the units digit
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
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
    lda hero_score_units,x              ; ...and look at the new units digit
    cmp #spr_digit_9 + 1                ; Past 9?
    bne draw_score                      ; No: redraw
    lda #spr_digit_0                    ; Yes: units 0, and carry into the tens
    sta hero_score_units,x              ; ...falling into add_ten_points to carry
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
    lda hero_score_tens,x               ; ...and look at the new tens digit
    cmp #spr_digit_9 + 1                ; Past 9?
    bne draw_score                      ; No: redraw
    lda #spr_digit_0                    ; Yes: tens 0...
    sta hero_score_tens,x               ; ...as the tens digit
    inc hero_score_hundreds,x           ; ...and add one to the hundreds
    lda hero_score_hundreds,x           ; ...and look at the new hundreds digit
    cmp #spr_digit_9 + 1                ; Past 9?
    bne draw_score                      ; No: redraw
    lda #spr_digit_0                    ; Yes: hundreds 0...
    sta hero_score_hundreds,x           ; ...as the hundreds digit
    jsr add_thousand_points             ; ...and add a thousand
; &72bc referenced 3 times by &7294, &72a3, &72b2
.draw_score
    clc                                 ; Draw the score twelve rows below the health: thousands at column &45...
    lda hero_panel_y,x                  ; Row: the hero's panel section...
    adc #&0c                            ; ...twelve rows down, below the health
    sta plot_y                          ; ...as the plotting row
    lda #panel_left                     ; Thousands digit in the panel's left column
    sta plot_x                          ; ...as the plotting column
    lda hero_score_thousands,x          ; ...as a digit sprite
    sta sprite_number                   ; ...as the sprite to plot
    txa                                 ; Keep the hero number...
    pha                                 ; ...across the plot
    jsr plot_sprite                     ; Plot the thousands digit
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    lda hero_score_hundreds,x           ; ...hundreds at &48...
    sta sprite_number                   ; ...as the sprite to plot
    lda #panel_left + 3                 ; ...three columns right...
    sta plot_x                          ; ...as the plotting column
    txa                                 ; Keep the hero number...
    pha                                 ; ...across the plot
    jsr plot_sprite                     ; Plot the hundreds digit
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    lda hero_score_tens,x               ; ...tens at &4B...
    sta sprite_number                   ; ...as the sprite to plot
    lda #panel_left + 6                 ; ...six columns right...
    sta plot_x                          ; ...as the plotting column
    txa                                 ; Keep the hero number...
    pha                                 ; ...across the plot
    jsr plot_sprite                     ; Plot the tens digit
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    lda hero_score_units,x              ; ...units at &4E
    sta sprite_number                   ; ...as the sprite to plot
    lda #panel_left + 9                 ; ...nine columns right
    sta plot_x                          ; ...as the plotting column
    txa                                 ; Keep the hero number...
    pha                                 ; ...across the plot
    jsr plot_sprite                     ; Plot the units digit
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
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
    sta plot_offset_x                   ; ...across the cell horizontally...
    sta plot_offset_y                   ; ...and vertically: objects sit squarely in their cells
    ldx #max_object                     ; Objects 30 to 1: plot each at its cell
; &730d referenced 1 time by &7326
.draw_each_object
    lda object_x,x                      ; This object's map x...
    sta cell_x                          ; ...is the cell to plot at...
    lda object_y,x                      ; ...and its map y...
    sta cell_y                          ; ...the cell's row
    lda object_type,x                   ; Its type is the sprite to plot
    sta sprite_number                   ; ...as the sprite to plot
    txa                                 ; Keep the object number...
    pha                                 ; ...across the plot
    jsr plot_at_cell                    ; Plot it in every view showing its cell
    pla                                 ; Recover the object number...
    tax                                 ; ...into X
    dex                                 ; Next object down
    bne draw_each_object                ; Until object 1 is drawn (object 0 is unused)
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
    sta cell_x                          ; ...: its map x...
    lda hero_y,x                        ; ...and map y...
    sta cell_y                          ; ...as the cell to look in
    ldy #max_object                     ; ...objects 30 to 1
; &7337 referenced 1 time by &7473
.check_object
    lda object_x,y                      ; Object Y's map x...
    cmp cell_x                          ; ...the same as the hero's?
    beq check_object_y                  ; Yes: compare the y
    jmp next_object                     ; No: try the next object
; &7342 referenced 1 time by &733d
.check_object_y
    lda object_y,y                      ; Object Y's map y...
    cmp cell_y                          ; ...the same as the hero's?
    beq object_found                    ; Yes: the hero is on this object
    jmp next_object                     ; No: try the next object
; &734d referenced 1 time by &7348
.object_found
    tya                                 ; Found: picking up anything loses Boots of Speed
    pha                                 ; Keep the object number...
    lda #0                              ; ...take the boots off...
    sta hero_has_boots,x                ; ...this hero
    jsr point_at_boots_icon             ; ...remove the bolt from the panel
    jsr erase_boots_icon                ; ...by plotting the blank in its place
    pla                                 ; Recover the object number...
    tay                                 ; ...into Y
    lda object_type,y                   ; Treasure?
    cmp #spr_treasure                   ; ...is it treasure?
    bne check_food                      ; No: check food
    txa                                 ; Yes: play the treasure sound
    pha                                 ; Keep the hero...
    tya                                 ; ...and the object...
    pha                                 ; ...across the OSWORD calls
    ldx #<(treasure_envelope)           ; Define the treasure envelope...
    ldy #>(treasure_envelope)           ; ...high byte...
    lda #osword_envelope                ; ...OSWORD 8, ENVELOPE
    jsr osword                          ; ENVELOPE command
    ldx #<(treasure_sound)              ; ...then sound it
    ldy #>(treasure_sound)              ; ...high byte...
    lda #osword_sound                   ; ...OSWORD 7, SOUND
    jsr osword                          ; SOUND command
    pla                                 ; Recover the object...
    tay                                 ; ...into Y...
    pla                                 ; ...and the hero...
    tax                                 ; ...into X
    tya                                 ; 20 points
    pha                                 ; ...keeping the object number
    jsr add_ten_points                  ; Ten points...
    jsr add_ten_points                  ; ...and ten more
    pla                                 ; Recover the object number...
    tay                                 ; ...into Y
    jmp remove_object                   ; Remove it
; &738a referenced 1 time by &7361
.check_food
    cmp #spr_food                       ; Food?
    bne check_teleporter                ; No: check teleporter
    inc hero_health_tens,x              ; Yes: 10 health...
    lda hero_health_tens,x              ; ...and look at the new tens digit
    cmp #spr_digit_9 + 1                ; ...to at most 99
    bne redraw_health                   ; Not past 9: health is up by 10
    lda #spr_digit_9                    ; Past 9: health is 99...
    sta hero_health_tens,x              ; ...tens 9...
    sta hero_health_units,x             ; ...units 9
; &73a0 referenced 1 time by &7396
.redraw_health
    tya                                 ; Redraw the health
    pha                                 ; Keep the object number
    jsr draw_health                     ; Draw the new health in the panel
    ldy #5                              ; 5 points
; &73a7 referenced 1 time by &73af
.redraw_health_loop
    tya                                 ; Keep the count of points to add...
    pha                                 ; ...across add_point
    jsr add_point                       ; One point
    pla                                 ; Recover the count...
    tay                                 ; ...into Y
    dey                                 ; One fewer to add
    bne redraw_health_loop              ; Until all five are added
    txa                                 ; Play the food sound
    pha                                 ; Keep the hero across the OSWORD call
    ldx #<(food_sound)                  ; SOUND food_sound...
    ldy #>(food_sound)                  ; ...high byte...
    lda #osword_sound                   ; ...OSWORD 7, SOUND
    jsr osword                          ; SOUND command
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    pla                                 ; Recover the object number...
    tay                                 ; ...into Y
    jmp remove_object                   ; Remove it
; &73c3 referenced 1 time by &738c
.check_teleporter
    cmp #spr_teleporter                 ; Teleporter?
    bne check_cross                     ; No: check cross
; &73c7 referenced 2 times by &73d1, &73d6
.find_previous_teleporter
    dey                                 ; Yes: find the previous teleporter in the list...
    lda object_type,y                   ; ...is it a teleporter?
    cmp #spr_teleporter                 ; ...type matches a teleporter's?
    beq teleport                        ; Yes: teleport to it
    cpy #0                              ; Reached the start of the list?
    bne find_previous_teleporter        ; No: keep looking backwards
    ldy teleport_last                   ; ...wrapping round to the end
    jmp find_previous_teleporter        ; ...and keep looking
; &73d9 referenced 1 time by &73cd
.teleport
    txa                                 ; Play the teleport sound
    pha                                 ; Keep the hero...
    tya                                 ; ...and the destination teleporter...
    pha                                 ; ...across the OSWORD call
    ldx #<(teleport_sound)              ; SOUND teleport_sound...
    ldy #>(teleport_sound)              ; ...high byte...
    lda #osword_sound                   ; ...OSWORD 7, SOUND
    jsr osword                          ; SOUND command
    pla                                 ; Recover the destination...
    tay                                 ; ...into Y...
    pla                                 ; ...and the hero...
    tax                                 ; ...into X
    lda object_x,y                      ; Move the hero to the cell above it
    sta hero_x,x                        ; ...same column as the teleporter...
    sta cell_x                          ; ...and the cell for drawing
    lda object_y,y                      ; ...one row above it...
    sec                                 ; ...subtract 1 from the teleporter's row...
    sbc #1                              ; ...(so the hero does not land on it and teleport again)
    sta hero_y,x                        ; ...as the hero's row
    sta cell_y                          ; ...and the cell for drawing
    lda #0                              ; ...with no step in progress
    sta hero_step,x                     ; ...not part way through a step
    sta hero_offset_x,x                 ; ...and no pixel offsets
    sta hero_offset_y,x                 ; ...in either direction
    jmp show_hero_room                  ; Show the room they arrive in
; &740d referenced 1 time by &73c5
.check_cross
    cmp #spr_cross                      ; Cross of Resurrection?
    bne check_magic_item                ; No: check magic item
    lda #off_map                        ; Yes: remove it
    sta object_x,y                      ; ...off the map...
    sta object_y,y                      ; ...in both x and y
    jsr add_ten_points                  ; 10 points
    txa                                 ; Keep the hero...
    pha                                 ; ...across the sound
    jsr play_pickup_sound               ; Play the pickup sound
    lda returning_hero_queue            ; Anyone waiting to return?
    bne take_returning_hero             ; Yes: take returning hero
    pla                                 ; No: return
    tax                                 ; ...the hero number into X...
    rts                                 ; ...and return
; &7429 referenced 1 time by &7424
.take_returning_hero
    ldy #0                              ; Take the first entry off the queue, appending 0...
; &742b referenced 1 time by &744a
.shift_returning_queue
    ldx returning_hero_queue            ; First entry: a hero number + 1, the &64 marker or 0...
    dex                                 ; ...minus 1: the hero, &63 for the marker, &FF for none
    lda returning_hero_queue + 1        ; Shift the queue up one: the second entry...
    sta returning_hero_queue            ; ...becomes the first...
    lda returning_hero_queue + 2        ; ...the third...
    sta returning_hero_queue + 1        ; ...becomes the second...
    lda returning_hero_queue + 3        ; ...the fourth...
    sta returning_hero_queue + 2        ; ...becomes the third...
    sty returning_hero_queue + 3        ; ...and Y fills the last (0, or the marker sent back)
    cpx #nobody_returns - 1             ; A &64 marker?
    bne check_queue_empty               ; No: check queue empty
    ldy #nobody_returns                 ; Yes: move it to the back and take the next entry
    bne shift_returning_queue           ; ...(always taken)
; &744c referenced 1 time by &7446
.check_queue_empty
    cpx #&ff                            ; Queue empty?
    beq cross_done                      ; Yes: nobody returns
    lda #0                              ; Start hero X returning: out of play...
    sta hero_direction,x                ; ...direction 0: not in play while the sprites run
    lda #8                              ; ...from the last appearance sprite...
    sta hero_frame,x                    ; ...frame 8, the last of hero_appearance_sprites
    lda #&ff                            ; ...stepping backwards...
    sta hero_offset_x,x                 ; ...frame step -1
    lda #1                              ; ...every other frame
    sta hero_offset_y,x                 ; ...the frame counter
; &7464 referenced 1 time by &744e
.cross_done
    pla                                 ; Return
    tax                                 ; ...hero number back into X
    rts                                 ; ...and return
; &7467 referenced 2 times by &7387, &73c0
.remove_object
    lda #off_map                        ; Remove object Y from the level
    sta object_x,y                      ; ...off the map in x...
    sta object_y,y                      ; ...and y, so it is neither drawn nor found again
    rts                                 ; Return
; &7470 referenced 3 times by &733f, &734a, &747d
.next_object
    dey                                 ; Next object
    beq collect_objects_done            ; Past object 1: nothing here
    jmp check_object                    ; Check this object
; &7476 referenced 1 time by &7471
.collect_objects_done
    rts                                 ; Return
; &7477 referenced 1 time by &740f
.check_magic_item
    cmp #spr_boots                      ; One of the magic items (&5F and up)?
    bcs magic_item                      ; Yes: magic item
    cmp #spr_exit                       ; The exit? Nothing to do here
    beq next_object                     ; ...so look no further
    lda #&32 ; '2'                      ; An energy drainer: play the hit sound louder...
    sta hit_sound + 4                   ; ...a louder volume in hit_sound...
    txa                                 ; Keep the hero...
    pha                                 ; ...across the OSWORD call
    ldx #<(hit_sound)                   ; SOUND hit_sound...
    ldy #>(hit_sound)                   ; ...high byte...
    lda #osword_sound                   ; ...OSWORD 7, SOUND
    jsr osword                          ; Play the drainer's louder hit sound  SOUND command
    lda #6                              ; ...then put the volume back
    sta hit_sound + 4                   ; ...for monsters being hit
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    ldy #&0a                            ; ...and take 10 health
; &7498 referenced 1 time by &74a0
.take_ten_health
    tya                                 ; Keep the count...
    pha                                 ; ...across lose_health_point
    jsr lose_health_point               ; Take one health point
    pla                                 ; Recover the count...
    tay                                 ; ...into Y
    dey                                 ; One fewer to take
    bne take_ten_health                 ; Until all ten are taken
    rts                                 ; Return
; ***************************************************************************************
; Play the pickup sound
;
; Define the pickup envelope and play the pickup sound, from the OSWORD parameter blocks
; at &192C and &193A.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &74a3 referenced 2 times by &741e, &74ca
.play_pickup_sound
    ldx #<(pickup_envelope)             ; Define the envelope...
    ldy #>(pickup_envelope)             ; ...high byte...
    lda #osword_envelope                ; ...OSWORD 8, ENVELOPE
    jsr osword                          ; Define the pickup envelope  ENVELOPE command
    ldx #<(pickup_sound)                ; ...and play the sound
    ldy #>(pickup_sound)                ; ...high byte...
    lda #osword_sound                   ; ...OSWORD 7, SOUND
    jsr osword                          ; Play the pickup sound  SOUND command
    rts                                 ; Return
; &74b6 referenced 1 time by &7479
.magic_item
    sta scratch                         ; A magic item: keep its type
    lda #off_map                        ; Remove it from the level
    sta object_x,y                      ; ...off the map in x...
    sta object_y,y                      ; ...and y
    txa                                 ; Play the pickup sound
    pha                                 ; Keep the hero across the sound
    lda scratch                         ; A = (type AND 7) x 4: unused, as play_pickup_sound...
    and #7                              ; ...sets its own registers...
    asl a                               ; ...x 2...
    asl a                               ; ...x 4
    jsr play_pickup_sound               ; Play the pickup sound
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    lda hero_score_units,x              ; Keep the score's units digit, for a potion
    sta scratch2                        ; ...in scratch2, before the points change it
    jsr add_ten_points                  ; 10 points
    lda scratch                         ; Boots of Speed?
    cmp #spr_boots                      ; ...is it Boots of Speed?
    bne check_helmet                    ; No: check helmet
    jsr point_at_boots_icon             ; Yes: show the bolt in the panel...
    jsr plot_boots_icon                 ; ...lightning bolt
    lda #1                              ; ...and wear them
    sta hero_has_boots,x                ; ...so the hero steps faster
    rts                                 ; Return
; &74eb referenced 1 time by &74dd
.check_helmet
    cmp #spr_helmet                     ; Magic helmet?
    bne check_potion                    ; No: check potion
    dec hero_damage_taken,x             ; Yes: lose one less health per hit...
    lda hero_damage_taken,x             ; ...and look at it
    cmp #3                              ; ...but never fewer than 3
    bcs redraw_armour                   ; 3 or more: keep it
    inc hero_damage_taken,x             ; Below 3: put it back to 3
; &74fc referenced 1 time by &74f7
.redraw_armour
    jmp draw_armour_rating              ; Redraw the armour rating
; &74ff referenced 1 time by &74ed
.check_potion
    cmp #spr_potion                     ; Potion of healing?
    bne check_weapons                   ; No: check weapons
    lda scratch2                        ; Yes: health tens = the score's units digit...
    sta hero_health_tens,x              ; ...as the health's tens digit
    inc scratch2                        ; ...units one more, then take a point to draw it
    lda scratch2                        ; ...the units digit one higher...
    sta hero_health_units,x             ; ...as the health's units
    jsr lose_health_point               ; ...which also redraws the health
    rts                                 ; Return
; &7516 referenced 1 time by &7501
.check_weapons
    cmp #spr_weapons                    ; Pile of weapons?
    bne magic_sword                     ; No: a magic sword
    inc hero_max_missiles,x             ; Yes: one more missile in flight...
    lda hero_max_missiles,x             ; ...and look at it
    cmp #4                              ; ...to at most 3
    bne draw_missile_icon               ; Not past 3: draw the new icon
    lda #3                              ; Past 3: back to 3...
    sta hero_max_missiles,x             ; ...as the missiles allowed
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
    sta cell_x                          ; ...as the cell to test...
    lda hero_y,x                        ; ...and its map y...
    sta cell_y                          ; ...as the cell to test
    txa                                 ; Keep the hero...
    pha                                 ; ...across test_wall
    jsr test_wall                       ; ...which finds the cell's room
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    pha                                 ; Keep X
    asl a                               ; view_room entry for this hero...
    tay                                 ; ...(two bytes per hero)...
    lda map_ptr                         ; ...the room found by test_wall...
    sta view_room,y                     ; ...now this room
    cpx #0                              ; Redraw this hero's view
    bne check_view_1                    ; Top-left view?
    jsr draw_view_0                     ; Yes: draw it
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    rts                                 ; Return
; &7551 referenced 1 time by &7549
.check_view_1
    cpx #1                              ; Top-right view?
    bne check_view_2                    ; No: next view
    jsr draw_view_1                     ; Yes: draw it
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    rts                                 ; Return
; &755b referenced 1 time by &7553
.check_view_2
    cpx #2                              ; Bottom-left view?
    bne show_view_3                     ; No: it is the bottom-right view
    jsr draw_view_2                     ; Yes: draw it
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    rts                                 ; Return
; &7565 referenced 1 time by &755d
.show_view_3
    jsr draw_view_3                     ; Otherwise the bottom-right view
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    rts                                 ; Return
; &756b referenced 1 time by &7518
.magic_sword
    inc hero_missile_damage,x           ; A magic sword: more missile damage...
    lda hero_missile_damage,x           ; ...and look at it
    cmp #&0a                            ; ...to at most 9
    bne draw_missile_damage             ; Not past 9: draw the new damage
    lda #9                              ; Past 9: back to 9...
    sta hero_missile_damage,x           ; ...as the missile damage
    bne draw_missile_damage             ; ...and draw it (always taken)
; &757c referenced 1 time by &714d
.monster_hit
    txa                                 ; Play the hit sound
    pha                                 ; Keep the monster...
    tya                                 ; ...and the missile slot...
    pha                                 ; ...across the OSWORD call
    ldx #<(hit_sound)                   ; SOUND hit_sound...
    ldy #>(hit_sound)                   ; ...high byte...
    lda #osword_sound                   ; ...OSWORD 7, SOUND
    jsr osword                          ; SOUND command
    pla                                 ; Recover the missile slot...
    tay                                 ; ...into Y...
    pla                                 ; ...and the monster...
    tax                                 ; ...into X
    lda monster_hit_points,x            ; Take the missile's damage from the monster's hit points
    sec                                 ; ...set the carry for the subtraction...
    sbc missile_damage,y                ; ...minus the hitting missile's damage
    bpl store_monster_health            ; Still alive?
    lda #spr_blank                      ; No: start it dying...
    sta monster_sprite,x                ; ...from the blank sprite through the sparkles
    lda monster_start_hit_points        ; ...and give the slot fresh hit points for its next appearance
    sta monster_hit_points,x            ; ...as its hit points
    tya                                 ; Missile slot back in X...
    tax                                 ; ...for monster_killed
    jmp monster_killed                  ; ...a point to its hero, and the missile is spent
; &75a6 referenced 1 time by &7594
.store_monster_health
    sta monster_hit_points,x            ; Alive: store the hit points left
    tya                                 ; Push the missile slot, as missile_spent_pop...
    pha                                 ; ...expects to find it on the stack
    jmp missile_spent_pop               ; The missile is spent
; &75ae referenced 1 time by &74fc
.draw_armour_rating
    sec                                 ; Armour rating: 10 - health lost per hit, as a small digit on the shield...
    lda hero_panel_y,x                  ; ...on the shield, twelve rows above the panel row...
    sbc #&0c                            ; ...minus twelve rows...
    sta plot_y                          ; ...as the plotting row
    lda #panel_left + 9                 ; ...nine columns right of the panel's left...
    sta plot_x                          ; ...as the plotting column
    lda #spr_small_digit_1 + 9          ; ...as the small digit 10 minus...
    sec                                 ; ...set the carry for the subtraction...
    sbc hero_damage_taken,x             ; ...the health lost per hit
    sta sprite_number                   ; ...as the sprite to plot
    jmp plot_keeping_x                  ; ...plotted
; &75c5 referenced 1 time by &7529
.draw_new_missile_icon
    lda hero_max_missiles,x             ; The newest missile icon: row = 3 x missiles allowed...
    asl a                               ; ...x 2...
    clc                                 ; ...clear the carry for the addition...
    adc hero_max_missiles,x             ; ...+ itself: x 3...
    adc #&0d                            ; ...+ &0D...
    adc hero_panel_y,x                  ; ...+ the hero's panel row...
    sec                                 ; ...set the carry for the subtraction...
    sbc #&0e                            ; ...- &0E: the row draw_status_panel gives the last icon
    sta plot_y                          ; ...as the plotting row
    lda #panel_left + 6                 ; ...column &4B...
    sta plot_x                          ; ...as the plotting column
    lda #spr_missile_icon               ; ...missile icon...
    sta sprite_number                   ; ...as the sprite to plot
    jmp plot_keeping_x                  ; ...plotted
; &75e2 referenced 2 times by &7573, &757a
.draw_missile_damage
    lda #panel_left + 7                 ; Missile damage: column &4C...
    sta plot_x                          ; ...as the plotting column
    sec                                 ; ...four rows above the panel row...
    lda hero_panel_y,x                  ; ...the hero's panel row...
    sbc #4                              ; ...minus four rows...
    sta plot_y                          ; ...as the plotting row
    lda hero_missile_damage,x           ; ...as a small digit...
    clc                                 ; ...clear the carry for the addition...
    adc #spr_small_digit_1 - 1          ; ...one before small digit 1, plus the damage
    sta sprite_number                   ; ...as the sprite to plot
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
    lda #panel_left + 5                 ; Column &4A...
    sta plot_x                          ; ...as the plotting column
    sec                                 ; ...row 8 above the section's top
    lda hero_panel_y,x                  ; ...the hero's panel row...
    sbc #8                              ; ...8 rows above the hero's panel section
    sta plot_y                          ; ...as the icon's pixel row
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
    lda #spr_boots_icon                 ; Lightning bolt...
    sta sprite_number                   ; ...as the sprite to plot
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
    lda #spr_blank_boots_icon           ; Blank...
    sta sprite_number                   ; ...as the sprite to plot
; &7611 referenced 4 times by &75c2, &75df, &75f6, &760a
.plot_keeping_x
    txa                                 ; Plot, preserving X
    pha                                 ; Keep the hero number across the plot
    jsr plot_sprite                     ; Plot the icon on the status panel
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    rts                                 ; Return
; &7619 referenced 1 time by &6ebe
.check_magic
    dec hero_magic_delay,x              ; Count down the magic key delay
    beq check_magic_every_frame         ; Zero: time to look at the magic key
    rts                                 ; Not yet: return, which leaves move_heroes for this frame
; &761f referenced 1 time by &761c
.check_magic_every_frame
    lda #1                              ; Check the key every frame from now on
    sta hero_magic_delay,x              ; ...so the next press is seen at once
    lda hero_magic_key,x                ; Magic key pressed?
    jsr test_key                        ; Scan it: Z set if pressed
    bne no_magic                        ; No: carry on reading the keys
    txa                                 ; Yes: play the magic sound
    pha                                 ; Keep the hero number while the sound plays
    ldx #<(magic_envelope)              ; XY = magic_envelope...
    ldy #>(magic_envelope)              ; ...its high byte
    lda #osword_envelope                ; OSWORD 8: define the magic envelope
    jsr osword                          ; ENVELOPE command
    ldx #<(magic_sound)                 ; XY = magic_sound...
    ldy #>(magic_sound)                 ; ...its high byte
    lda #osword_sound                   ; OSWORD 7: make the magic sound
    jsr osword                          ; SOUND command
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    lda #4                              ; Ignore the key for the next three frames
    sta hero_magic_delay,x              ; ...so one press casts only once
    cpx #1                              ; Health cost: 3 for the Magic-User...
    beq magic_user_cost                 ; Magic-User (hero 1): the cheaper rate
    ldy #6                              ; ...6 for the Ranger
    jmp take_magic_cost                 ; Ranger: go and take 6 points
; &7650 referenced 1 time by &7649
.magic_user_cost
    ldy #3                              ; Magic-User: 3 points
; &7652 referenced 2 times by &764d, &765a
.take_magic_cost
    tya                                 ; Take the cost
    pha                                 ; Keep the count of points still to take
    jsr lose_health_point               ; Take one point of the caster's health
    pla                                 ; Recover the count...
    tay                                 ; ...into Y
    dey                                 ; One point fewer to take
    bne take_magic_cost                 ; Until the whole cost is paid
    lda #0                              ; No monsters killed yet
    sta magic_kill_count                ; ...in magic_kill_count
    txa                                 ; sprite_number = 2 x hero, an index into view_room
    asl a                               ; ...x 2: view_room holds two bytes per hero
    sta sprite_number                   ; ...kept in sprite_number, free as scratch here
    ldx #max_monster                    ; For each monster...
; &7667 referenced 1 time by &7693
.find_monster_room
    lda monster_x,x                     ; ...find its room
    sta cell_x                          ; ...from its map x...
    lda monster_y,x                     ; ...and its map y
    sta cell_y                          ; ...set as the cell to test
    txa                                 ; Keep the monster number...
    pha                                 ; ...on the stack
    jsr test_wall                       ; Work out the monster's room in map_ptr
    pla                                 ; Recover the monster number...
    tax                                 ; ...into X
    ldy sprite_number                   ; In the room this hero's view shows?
    lda view_room,y                     ; The room the caster's view shows...
    cmp map_ptr                         ; ...is it the monster's room?
    bne next_monster_magic              ; No: next monster magic
    lda monster_sprite,x                ; Alive?
    cmp #spr_blank                      ; Below the blank sprite: alive
    bcs next_monster_magic              ; No: next monster magic
    lda #spr_blank                      ; Yes: start it dying...
    sta monster_sprite,x                ; ...so the magic kills it
    inc magic_kill_count                ; ...and count it
; &7692 referenced 2 times by &7681, &7688
.next_monster_magic
    dex                                 ; Next monster
    bne find_monster_room               ; Until all 30 monsters are checked
    lda sprite_number                   ; One point for each monster killed
    lsr a                               ; ...halve the view_room index back to the hero
    tax                                 ; ...X = the caster, who scores the points
    ldy magic_kill_count                ; ...Y = the monsters killed
; &769c referenced 1 time by &76a8
.check_kills
    cpy #0                              ; Any kills left to score?
    beq magic_cast                      ; None: the magic is done
    tya                                 ; Keep the count...
    pha                                 ; ...on the stack
    jsr add_point                       ; One point to the caster
    pla                                 ; Recover the count...
    tay                                 ; ...into Y
    dey                                 ; One kill fewer to score
    jmp check_kills                     ; Score the next
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
    txa                                 ; Keep the missile slot...
    pha                                 ; ...on the stack
    tya                                 ; Compare the missile's sprite base
    cmp #spr_arrow_up - 1               ; Arrows: the Ranger
    bne owner_fireball                  ; Not arrows: try fireballs
    ldx #0                              ; Arrows: the Ranger, hero 0
    jmp credit_owner                    ; Score it
; &76c0 referenced 1 time by &76b9
.owner_fireball
    cmp #spr_fireball_up - 1            ; Fireballs: the Magic-User
    bne owner_axe                       ; Not fireballs: try axes
    ldx #1                              ; Fireballs: the Magic-User, hero 1
    jmp credit_owner                    ; Score it
; &76c9 referenced 1 time by &76c2
.owner_axe
    cmp #spr_axe_up - 1                 ; Axes: the Barbarian
    bne owner_sword                     ; Not axes: so it must be swords
    ldx #2                              ; Axes: the Barbarian, hero 2
    jmp credit_owner                    ; Score it
; &76d2 referenced 1 time by &76cb
.owner_sword
    ldx #3                              ; Otherwise swords: the Fighter
; &76d4 referenced 3 times by &76bd, &76c6, &76cf
.credit_owner
    jsr add_point                       ; One point to that hero
    pla                                 ; Recover the missile slot...
    tax                                 ; ...into X
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
    beq absent_frame_due                ; Timer run out: show the next sprite
    rts                                 ; Not yet: nothing to draw this frame
; &76e0 referenced 1 time by &76dd
.absent_frame_due
    lda #2                              ; Restart the two-frame timer...
    sta hero_offset_y,x                 ; ...which an absent hero keeps in hero_offset_y
    jsr get_hero_cell                   ; Plot the current appearance sprite at the hero's cell
    lda #0                              ; No pixel offsets...
    sta plot_offset_x                   ; ...across...
    sta plot_offset_y                   ; ...or down
    lda hero_frame,x                    ; The hero's place in the appearance sequence...
    tay                                 ; ...as an index...
    lda hero_appearance_sprites,y       ; ...picks the sprite to show
    sta sprite_number                   ; ...to plot
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack
    jsr plot_at_cell                    ; Plot it in every view that shows the hero
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    clc                                 ; Step to the next (+1 dying, -1 returning), stopping at 8
    lda hero_frame,x                    ; Current place in the sequence...
    adc hero_offset_x,x                 ; ...plus the step kept in hero_offset_x
    cmp #9                              ; Past the skull (place 8)?
    bcc check_first_sprite              ; No: keep the new place
    lda #8                              ; Yes: stay on the skull
; &770b referenced 1 time by &7707
.check_first_sprite
    cmp #0                              ; Reached the first sprite (returning)?
    bne store_hero_frame                ; No: store hero frame
    lda #5                              ; Yes: in play, facing down...
    sta hero_direction,x                ; ...back in play
    lda #0                              ; ...with no step or offsets...
    sta hero_step,x                     ; ...not mid-step...
    sta hero_offset_x,x                 ; ...no horizontal offset...
    sta hero_offset_y,x                 ; ...no vertical offset...
    sta hero_frame,x                    ; ...and animation frame 0
    lda #spr_digit_3                    ; ...and health 33, drawn by taking a point
    sta hero_health_tens,x              ; ...tens digit 3...
    sta hero_health_units,x             ; ...units digit 3...
    jsr lose_health_point               ; ...less a point, which also draws it: 32
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
    sta plot_offset_x                   ; ...across...
    lda hero_offset_y,x                 ; ...and down...
    sta plot_offset_y                   ; ...as plot_offset_y
    txa                                 ; Plot in every view showing it, preserving X
    pha                                 ; ...keeping the hero number on the stack
    jsr plot_at_cell                    ; Plot the hero in every view showing it
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
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
    cmp #spr_arrow_up - 1               ; ...arrows?
    bne firer_fireball                  ; Not arrows: try fireballs
    lda hero_frame                      ; The Ranger's animation frame...
    eor #1                              ; ...flipped between 0 and 1...
    sta hero_frame                      ; ...so the Ranger moves as it fires
    rts                                 ; Return
; &7757 referenced 1 time by &774c
.firer_fireball
    cmp #spr_fireball_up - 1            ; Fireballs: the Magic-User's
    bne firer_axe                       ; Not fireballs: try axes
    lda hero_frame + 1                  ; The Magic-User's animation frame...
    eor #1                              ; ...flipped between 0 and 1...
    sta hero_frame + 1                  ; ...so the Magic-User moves as it casts
    rts                                 ; Return
; &7764 referenced 1 time by &7759
.firer_axe
    cmp #spr_axe_up - 1                 ; Axes: the Barbarian's
    bne firer_sword                     ; Not axes: so it must be swords
    lda hero_frame + 2                  ; The Barbarian's animation frame...
    eor #1                              ; ...flipped between 0 and 1...
    sta hero_frame + 2                  ; ...so the Barbarian moves as it throws
    rts                                 ; Return
; &7771 referenced 1 time by &7766
.firer_sword
    lda hero_frame + 3                  ; Otherwise swords: the Fighter's
    eor #1                              ; ...flipped between 0 and 1...
    sta hero_frame + 3                  ; ...so the Fighter moves as it throws
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
    sta cell_x                          ; ...for the plotting and testing routines
    lda hero_y,x                        ; cell_y = hero_y
    sta cell_y                          ; ...likewise
    rts                                 ; Return
    equb &73                            ; Not referenced
; ***************************************************************************************
; Draw all four views
;
; Draw the room each hero's view shows.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
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
;
; On Entry:
;     VIEW_ROOM: the room hero 0 is in
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &7795 referenced 2 times by &754b, &7788
.draw_view_0
    lda #1                              ; Top-left view: row 1...
    sta plot_y                          ; ...as the view's top pixel row
    lda #1                              ; ...column 1...
    sta cell_x                          ; ...as the view's left screen column
    lda view_room                       ; ...hero 0's room
    sta map_ptr                         ; ...whose walls draw_room reads
    jsr draw_room                       ; Draw it
    rts                                 ; Return
; ***************************************************************************************
; Draw the top-right view
;
; Draw the room in hero 1's view.
;
; On Entry:
;     VIEW_ROOM + 2: the room hero 1 is in
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &77a7 referenced 2 times by &7555, &778b
.draw_view_1
    lda #1                              ; Top-right view: row 1...
    sta plot_y                          ; ...as the view's top pixel row
    lda #view_right_column              ; ...column &23...
    sta cell_x                          ; ...as the view's left screen column
    lda view_room + 2                   ; ...hero 1's room
    sta map_ptr                         ; ...whose walls draw_room reads
    jsr draw_room                       ; Draw it
    rts                                 ; Return
; ***************************************************************************************
; Draw the bottom-left view
;
; Draw the room in hero 2's view.
;
; On Entry:
;     VIEW_ROOM + 4: the room hero 2 is in
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &77b9 referenced 2 times by &755f, &778e
.draw_view_2
    lda #view_bottom_row                ; Bottom-left view: row &67...
    sta plot_y                          ; ...as the view's top pixel row
    lda #1                              ; ...column 1...
    sta cell_x                          ; ...as the view's left screen column
    lda view_room + 4                   ; ...hero 2's room
    sta map_ptr                         ; ...whose walls draw_room reads
    jsr draw_room                       ; Draw it
    rts                                 ; Return
; ***************************************************************************************
; Draw the bottom-right view
;
; Draw the room in hero 3's view.
;
; On Entry:
;     VIEW_ROOM + 6: the room hero 3 is in
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &77cb referenced 2 times by &7565, &7791
.draw_view_3
    lda #view_bottom_row                ; Bottom-right view: row &67...
    sta plot_y                          ; ...as the view's top pixel row
    lda #view_right_column              ; ...column &23...
    sta cell_x                          ; ...as the view's left screen column
    lda view_room + 6                   ; ...hero 3's room
    sta map_ptr                         ; ...whose walls draw_room reads
    jsr draw_room                       ; Draw it
    rts                                 ; Return
    equb &60                            ; Not referenced
; ***************************************************************************************
; Draw a room
;
; Draw the eight rows of walls of the room at &7B, &7C (a pointer into room_walls) with
; its top-left at plot_y and the column in cell_x, then draw the doors.
;
; On Entry:
;     MAP_PTR: the room's offset in room_walls (the low byte)
;     CELL_X: the view's left column
;     PLOT_Y: the view's top pixel row
;
; On Exit:
;     A: corrupted
;     X: 0
;     Y: corrupted
; &77de referenced 4 times by &77a3, &77b5, &77c7, &77d9
.draw_room
    lda #>(room_walls)                  ; The room's walls are in page &0C
    sta map_ptr_hi                      ; ...so map_ptr points at the room's wall bytes
    ldy #0                              ; For each of the eight rows...
; &77e4 referenced 1 time by &77fa
.draw_room_walls
    lda (map_ptr),y                     ; ...take its eight wall bits...
    sta scratch                         ; ...in scratch for draw_room_row
    tya                                 ; Keep the row number...
    pha                                 ; ...on the stack across the row
    jsr draw_room_row                   ; ...and draw them
    clc                                 ; Twelve pixel rows down
    lda plot_y                          ; Down to the next row of cells...
    adc #&0c                            ; ...each 12 pixel rows tall
    sta plot_y                          ; ...ready for the next row
    pla                                 ; Recover the row number...
    tay                                 ; ...into Y
    iny                                 ; Next row
    cpy #8                              ; All eight rows done?
    bne draw_room_walls                 ; No: draw the next row
    ldx #max_door                       ; Then the doors 20 to 1, in every view showing them
; &77fe referenced 1 time by &781d
.draw_room_doors
    lda door_x,x                        ; This door's map x...
    sta cell_x                          ; ...as the cell to plot
    lda door_y,x                        ; ...and its map y
    sta cell_y                          ; ...likewise
    lda #0                              ; Doors sit squarely in their cells:
    sta plot_offset_x                   ; ...no horizontal offset...
    sta plot_offset_y                   ; ...and no vertical offset
    lda door_sprite,x                   ; Its sprite, vertical or horizontal...
    sta sprite_number                   ; ...to plot
    txa                                 ; Keep the door number...
    pha                                 ; ...on the stack
    jsr plot_at_cell                    ; Plot it in every view showing its cell
    pla                                 ; Recover the door number...
    tax                                 ; ...into X
    dex                                 ; Next door
    bne draw_room_doors                 ; Until all 20 are drawn
    rts                                 ; Return
; ***************************************************************************************
; Draw one row of a room
;
; Plot a wall or a blank for each of the eight bits of scratch, four byte columns apart,
; starting at byte column cell_x.
;
; On Entry:
;     SCRATCH: the row's eight wall bits, the leftmost cell in bit 7
;     CELL_X: the view's left column
;     PLOT_Y: the row's top pixel row
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &7820 referenced 1 time by &77eb
.draw_room_row
    lda cell_x                          ; Start at the room's left edge
    sta plot_x                          ; ...as the first cell's screen column
    ldx #&80                            ; Bit mask, starting with the leftmost cell
; &7827 referenced 1 time by &784f
.draw_room_cell
    txa                                 ; Keep this cell's bit mask...
    pha                                 ; ...on the stack...
    sta scratch2                        ; ...and in scratch2 for the test
    lda scratch                         ; Wall here?
    and scratch2                        ; ...against the row's wall bits
    beq plot_blank                      ; No: plot the blank
    lda #spr_wall                       ; Yes: plot the wall block (sprite 0)
    sta sprite_number                   ; ...to plot
    jsr plot_sprite                     ; Draw the wall block in this cell
    jmp next_room_cell                  ; On to the next cell
; &783e referenced 1 time by &7832
.plot_blank
    lda #spr_blank                      ; Plot the blank (sprite &15)
    sta sprite_number                   ; ...to plot
    jsr plot_sprite                     ; Clear this cell
; &7845 referenced 1 time by &783b
.next_room_cell
    clc                                 ; Four byte columns right
    lda plot_x                          ; Next cell's screen column...
    adc #4                              ; ...four bytes, one cell's width, along
    sta plot_x                          ; ...stored for the next plot
    pla                                 ; Next bit...
    lsr a                               ; ...the mask moves to the next cell right
    tax                                 ; ...into X; zero once the eighth cell is done
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
    and #&f8                            ; ...the room's top row of cells (y AND &F8)
    sta scratch                         ; ...kept to multiply...
    clc                                 ; ...(no carry into the sum)
    adc scratch                         ; ...x 2...
    adc scratch                         ; ...x 3...
    adc scratch                         ; ...x 4: a room row is 32 bytes of room_walls
    sta cell_room                       ; ...partial room offset
    lda cell_x                          ; Add the room's left column of cells...
    and #&f8                            ; ...cell_x AND &F8: 8 bytes per room across
    adc cell_room                       ; ...giving the room's offset in room_walls
    sta cell_room                       ; ...in cell_room
    lda cell_x                          ; Column within the view = (cell_x AND 7) x 4 + offset_x
    and #7                              ; ...the cell's column within its room...
    asl a                               ; ...x 2...
    asl a                               ; ...x 4: each cell is 4 screen bytes wide
    clc                                 ; ...(no carry)
    adc plot_offset_x                   ; ...plus the creature's horizontal offset
    sta cell_x                          ; ...replacing cell_x
    lda cell_y                          ; Row within the view = (cell_y AND 7) x 12 + offset_y
    and #7                              ; ...the cell's row within its room...
    asl a                               ; ...x 2...
    asl a                               ; ...x 4...
    sta scratch                         ; ...kept...
    asl a                               ; ...x 8...
    clc                                 ; ...(no carry)
    adc scratch                         ; ...+ x 4 = x 12: each cell is 12 rows tall
    adc plot_offset_y                   ; ...plus the creature's vertical offset
    sta cell_y                          ; ...replacing cell_y
    lda view_room                       ; Does the top-left view show this room?
    cmp cell_room                       ; ...is it the room of the cell?
    bne check_view_1_room               ; No: check view 1 room
    clc                                 ; Yes: plot at column 1, row 1 of the screen, plus the position in the room
    lda #1                              ; ...view's left column, 1...
    adc cell_x                          ; ...plus the column within the room
    sta plot_x                          ; ...as the screen column
    lda #1                              ; ...view's top row, 1...
    adc cell_y                          ; ...plus the row within the room
    sta plot_y                          ; ...as the screen row
    jsr plot_sprite                     ; Draw it in the top-left view
; &78ad referenced 1 time by &7899
.check_view_1_room
    lda view_room + 2                   ; Does the top-right view show it?
    cmp cell_room                       ; ...is it the room of the cell?
    bne check_view_2_room               ; No: check view 2 room
    clc                                 ; Yes: plot at column &23, row 1
    lda #view_right_column              ; ...view's left column...
    adc cell_x                          ; ...plus the column within the room
    sta plot_x                          ; ...as the screen column
    lda #1                              ; ...view's top row, 1...
    adc cell_y                          ; ...plus the row within the room
    sta plot_y                          ; ...as the screen row
    jsr plot_sprite                     ; Draw it in the top-right view
; &78c7 referenced 1 time by &78b3
.check_view_2_room
    lda view_room + 4                   ; Does the bottom-left view show it?
    cmp cell_room                       ; ...is it the room of the cell?
    bne check_view_3_room               ; No: check view 3 room
    clc                                 ; Yes: plot at column 1, row &67
    lda #1                              ; ...view's left column, 1...
    adc cell_x                          ; ...plus the column within the room
    sta plot_x                          ; ...as the screen column
    lda #view_bottom_row                ; ...view's top row...
    adc cell_y                          ; ...plus the row within the room
    sta plot_y                          ; ...as the screen row
    jsr plot_sprite                     ; Draw it in the bottom-left view
; &78e1 referenced 1 time by &78cd
.check_view_3_room
    lda view_room + 6                   ; Does the bottom-right view show it?
    cmp cell_room                       ; ...is it the room of the cell?
    bne plot_at_cell_done               ; No: plot at cell done
    clc                                 ; Yes: plot at column &23, row &67
    lda #view_right_column              ; ...view's left column...
    adc cell_x                          ; ...plus the column within the room
    sta plot_x                          ; ...as the screen column
    lda #view_bottom_row                ; ...view's top row...
    adc cell_y                          ; ...plus the row within the room
    sta plot_y                          ; ...as the screen row
    jsr plot_sprite                     ; Draw it in the bottom-right view
; &78fb referenced 1 time by &78e7
.plot_at_cell_done
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
    and #&f8                            ; ...the room's top row of cells (y AND &F8)
    sta scratch                         ; ...kept to multiply...
    clc                                 ; ...(no carry into the sum)
    adc scratch                         ; ...x 2...
    adc scratch                         ; ...x 3...
    adc scratch                         ; ...x 4: a room row is 32 bytes of room_walls
    sta map_ptr                         ; ...low byte of the pointer
    lda cell_x                          ; Add the room's left column of cells...
    and #&f8                            ; ...cell_x AND &F8: 8 bytes per room across
    adc map_ptr                         ; ...to the pointer's low byte...
    sta map_ptr                         ; ...map_ptr: the room's eight wall bytes
    lda #>(room_walls)                  ; ...into room_walls at &0C00
    sta map_ptr_hi                      ; ...as the pointer's high byte
    lda cell_x                          ; Bit for the column within the room
    and #7                              ; ...cell_x AND 7...
    tax                                 ; ...indexes bit_masks...
    lda bit_masks,x                     ; ...for the cell's bit, leftmost bit 7
    sta scratch                         ; ...kept in scratch
    lda cell_y                          ; Byte for the row within the room
    and #7                              ; ...cell_y AND 7...
    tay                                 ; ...indexes the room's bytes
    lda (map_ptr),y                     ; Isolate the cell's bit...
    and scratch                         ; ...with the column's mask: non-zero if a wall
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
    and #&f8                            ; ...the room's top row of cells (y AND &F8)
    sta scratch                         ; ...kept to multiply...
    clc                                 ; ...(no carry into the sum)
    adc scratch                         ; ...x 2...
    adc scratch                         ; ...x 3...
    adc scratch                         ; ...x 4: the map has room_walls' layout
    sta map_ptr                         ; ...low byte of the pointer
    lda cell_x                          ; Add the room's left column of cells...
    and #&f8                            ; ...cell_x AND &F8: 8 bytes per room across
    adc map_ptr                         ; ...to the pointer's low byte...
    sta map_ptr                         ; ...map_ptr: the room's eight map bytes
    lda #>(object_free_map)             ; ...into object_free_map at &2100
    sta map_ptr_hi                      ; ...as the pointer's high byte
    lda cell_x                          ; Bit for the column within the room
    and #7                              ; ...cell_x AND 7...
    tax                                 ; ...indexes bit_masks...
    lda bit_masks,x                     ; ...for the cell's bit, leftmost bit 7
    sta scratch                         ; ...kept in scratch
    lda cell_y                          ; Byte for the row within the room
    and #7                              ; ...cell_y AND 7...
    tay                                 ; ...indexes the room's bytes
    lda (map_ptr),y                     ; Isolate the cell's bit...
    and scratch                         ; ...with the mask: zero if an object may lie here
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
    ldx #max_monster                    ; Monsters 30 to 1...
; &7976 referenced 1 time by &798e
.check_monster
    cpx scratch                         ; ...except the one being moved
    beq next_monster_find               ; The mover itself: skip it
    lda cell_x                          ; At cell_x...
    cmp monster_x,x                     ; ...this monster's x?
    bne next_monster_find               ; No: next monster
    lda cell_y                          ; ...and cell_y?
    cmp monster_y,x                     ; ...this monster's y?
    bne next_monster_find               ; No: next monster
    tay                                 ; Yes: return with Y and A non-zero
    rts                                 ; ...a monster is in the cell
; &798d referenced 3 times by &7979, &7981, &7989
.next_monster_find
    dex                                 ; Next monster
    bne check_monster                   ; Until all 30 are checked
    lda scratch                         ; No monster. Check for heroes too?
    beq nothing_found                   ; No: return 0
    ldx #0                              ; For each hero...
; &7997 referenced 1 time by &79ba
.check_hero
    lda cell_x                          ; ...at cell_x...
    cmp hero_x,x                        ; ...this hero's x?
    bne next_hero_find                  ; No: next hero
    lda cell_y                          ; ...and cell_y?
    cmp hero_y,x                        ; ...this hero's y?
    bne next_hero_find                  ; No: next hero
    ldy hero_damage_taken,x             ; Yes: take hero_damage_taken health points
; &79aa referenced 1 time by &79b2
.check_hero_loop
    tya                                 ; Keep the count of points to take...
    pha                                 ; ...on the stack
    jsr lose_health_point               ; The hero there is hurt: one point
    pla                                 ; Recover the count...
    tay                                 ; ...into Y
    dey                                 ; One point fewer to take
    bne check_hero_loop                 ; Until the hero has taken them all
    lda #1                              ; Return A = 1: a hero was there
    rts                                 ; ...so the caller treats the cell as taken
; &79b7 referenced 2 times by &799d, &79a5
.next_hero_find
    inx                                 ; Next hero
    cpx #4                              ; All four heroes checked?
    bne check_hero                      ; No: check the next
; &79bc referenced 1 time by &7993
.nothing_found
    lda #0                              ; Nothing there: return A = Y = 0
    ldy #0                              ; ...the cell is empty
    rts                                 ; Return
; ***************************************************************************************
; Draw the trapdoors and move the monsters
;
; Draw the eight trapdoors, then for each monster continue its step or start a new one,
; turning a random way when it is blocked, and advance dying monsters until they reappear
; at a trapdoor.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &79c1 referenced 1 time by &1ed4
.update_monsters
    ldx #8                              ; Draw the eight trapdoors (sprite &2C)...
    lda #0                              ; Trapdoors sit squarely in their cells:
    sta plot_offset_x                   ; ...no horizontal offset...
    sta plot_offset_y                   ; ...and no vertical offset
    lda #spr_trapdoor                   ; The trapdoor sprite...
    sta sprite_number                   ; ...to plot
; &79cd referenced 1 time by &79e1
.check_trapdoor
    lda trapdoor_x - 1,x                ; This trapdoor's map x...
    sta cell_x                          ; ...as the cell to plot
    lda trapdoor_y - 1,x                ; ...and its map y
    sta cell_y                          ; ...likewise
    txa                                 ; Keep the trapdoor number...
    pha                                 ; ...on the stack
    jsr plot_at_cell                    ; Draw it in every view showing its cell
    pla                                 ; Recover the trapdoor number...
    tax                                 ; ...into X
    dex                                 ; Next trapdoor
    bne check_trapdoor                  ; Until all eight are drawn
    ldx #max_monster                    ; For each monster, 30 to 1...
; &79e5 referenced 1 time by &7b2d
.next_monster_update
    txa                                 ; Keep the monster number...
    pha                                 ; ...on the stack while it moves
    lda monster_x,x                     ; Erase it at its cell and offsets, remembering the cell
    sta cell_x                          ; ...as the cell to erase...
    sta previous_x                      ; ...and as where it came from
    lda monster_y,x                     ; ...and its map y...
    sta cell_y                          ; ...as the cell to erase...
    sta previous_y                      ; ...and as where it came from
    lda #spr_blank                      ; The blank sprite...
    sta sprite_number                   ; ...to rub it out
    lda monster_offset_x,x              ; Its horizontal offset...
    sta plot_offset_x                   ; ...set for the erase
    lda monster_offset_y,x              ; Its vertical offset...
    sta plot_offset_y                   ; ...set for the erase
    jsr plot_at_cell                    ; Plot the blank over the monster, wherever it is
    pla                                 ; Recover the monster number...
    pha                                 ; ...keeping it stacked for later
    tax                                 ; ...in X
    lda monster_sprite,x                ; Dying? Death frames are sprite &15 and up
    cmp #spr_blank                      ; Sprites &15 and up are death frames
    bcc check_monster_step              ; No: check monster step
    jmp advance_dying_monster           ; Yes: advance the death animation
; &7a17 referenced 1 time by &7a12
.check_monster_step
    lda monster_step,x                  ; Part way through a step?
    beq start_monster_move              ; No: start monster move
    jsr continue_monster_step           ; Yes: continue it and draw
    pla                                 ; Drop the stacked monster number (X still has it)
    jmp draw_monster                    ; Draw it at its grown offsets
; &7a23 referenced 1 time by &7a1a
.start_monster_move
    lda monster_sprite,x                ; Start a step: move the cell in the direction it faces, up...
    cmp #spr_monster_up_0               ; Facing up?
    bne monster_right                   ; No: try right
    dec monster_y,x                     ; Yes: one row up
; &7a2d referenced 1 time by &7a28
.monster_right
    cmp #spr_monster_right_0            ; ...right...
    bne monster_down                    ; No: try down
    inc monster_x,x                     ; Yes: one column right
; &7a34 referenced 1 time by &7a2f
.monster_down
    cmp #spr_monster_down_0             ; ...down...
    bne monster_left                    ; No: try left
    inc monster_y,x                     ; Yes: one row down
; &7a3b referenced 1 time by &7a36
.monster_left
    cmp #spr_monster_left_0             ; ...left
    bne set_monster_step                ; No: it does not move
    dec monster_x,x                     ; Yes: one column left
; &7a42 referenced 1 time by &7a3d
.set_monster_step
    jsr start_monster_step              ; Set the step's offsets
    lda monster_x,x                     ; Wall in the new cell?
    sta cell_x                          ; ...as cell_x for the test
    lda monster_y,x                     ; Its new y...
    sta cell_y                          ; ...as cell_y
    jsr test_wall                       ; Z set if the cell is open
    beq check_monster_blocked           ; No: check monster blocked
    pla                                 ; Yes: stay put, with no step...
    tax                                 ; ...recovering its number in X
    lda previous_x                      ; Its old x...
    sta monster_x,x                     ; ...back in monster_x
    lda previous_y                      ; Its old y...
    sta monster_y,x                     ; ...back in monster_y
    lda #0                              ; Nothing to animate:
    sta monster_step,x                  ; ...no step count
    sta monster_offset_x,x              ; ...no horizontal offset
    sta monster_offset_y,x              ; ...no vertical offset
    lda system_via_t1c_l                ; ...and turn a random way: sprite 8 + (timer AND 7)...
    and #7                              ; A random 0-7...
    clc                                 ; ...plus 8...
    adc #8                              ; ...gives a sprite &08-&0F
    sta monster_sprite,x                ; Face the monster that way
    and #1                              ; Odd sprites (9, &0B, &0D, &0F) face a way
    beq turn_monster                    ; Even: not a facing sprite
    jmp draw_monster                    ; Odd: a facing sprite, so draw it
; &7a81 referenced 1 time by &7a7c
.turn_monster
    inc monster_sprite,x                ; Up to the odd facing sprite after it
    jmp draw_monster                    ; Draw it
; &7a87 referenced 1 time by &7a54
.check_monster_blocked
    pla                                 ; Is another monster, or a hero, in the new cell? (A hero there is hurt)
    pha                                 ; ...keeping it stacked
    sta scratch                         ; Leave this monster out of the search
    jsr find_creature                   ; Look for a creature at the new cell
    cmp #0                              ; A = 0 if the cell is free
    beq monster_vertical                ; No: monster vertical
    pla                                 ; Yes: stay put, with no step, and turn a random way
    tax                                 ; Stay in the old cell...
    lda previous_x                      ; Its old x...
    sta monster_x,x                     ; ...back in monster_x
    lda previous_y                      ; Its old y...
    sta monster_y,x                     ; ...back in monster_y
    lda #0                              ; ...with no step...
    sta monster_step,x                  ; Clear the step count
    sta monster_offset_x,x              ; ...the horizontal offset
    sta monster_offset_y,x              ; ...and the vertical offset
    lda system_via_t1c_l                ; ...and turn a random way: 8 + (timer AND 7), made odd
    and #7                              ; A random 0-7...
    clc                                 ; ...plus 8...
    adc #8                              ; ...gives a sprite &08-&0F
    sta monster_sprite,x                ; Face the monster that way
    and #1                              ; Even?
    bne draw_monster                    ; Odd: a facing sprite, so draw it
    inc monster_sprite,x                ; Even: up to the odd sprite after it
    jmp draw_monster                    ; Draw it
; &7ac1 referenced 1 time by &7a91
.monster_vertical
    pla                                 ; Moving vertically...
    tax                                 ; ...recovering the monster number in X
    lda monster_sprite,x                ; Its facing, as its sprite
    cmp #spr_monster_up_0               ; Facing up?
    beq check_room_edge                 ; Yes: check the top and bottom edges
    cmp #spr_monster_down_0             ; Facing down?
    beq check_room_edge                 ; Yes: check the top and bottom edges
    lda monster_x,x                     ; No: at the left or right edge of a room?
    and #7                              ; Column within its eight-cell room
    beq monster_at_edge                 ; Column 0, the left edge
    cmp #7                              ; Column 7, the right edge?
    beq monster_at_edge                 ; Yes: at an edge
    jmp monster_move_on                 ; No: move on
; &7adc referenced 2 times by &7ac8, &7acc
.check_room_edge
    lda monster_y,x                     ; Yes: at the top or bottom edge of a room?
    and #7                              ; Row within its eight-cell room
    beq monster_at_edge                 ; Row 0, the top edge
    cmp #7                              ; Row 7, the bottom edge?
    beq monster_at_edge                 ; Yes: at an edge
    jmp monster_move_on                 ; No: move on
; &7aea referenced 4 times by &7ad3, &7ad7, &7ae1, &7ae5
.monster_at_edge
    lda #0                              ; At a room edge: cancel the step, so it arrives at once
    sta monster_step,x                  ; ...no step count
    sta monster_offset_x,x              ; ...no horizontal offset
    sta monster_offset_y,x              ; ...no vertical offset
    jmp draw_monster                    ; Draw it in the new cell
; &7af8 referenced 2 times by &7ad9, &7ae7
.monster_move_on
    lda previous_x                      ; Move on: stay in the old cell until the step ends
    sta monster_x,x                     ; ...back in monster_x
    lda previous_y                      ; Old y...
    sta monster_y,x                     ; ...back in monster_y
; &7b04 referenced 6 times by &7a20, &7a7e, &7a84, &7ab9, &7abe, &7af5
.draw_monster
    lda monster_x,x                     ; Draw it: sprite = direction + frame, at its cell and offsets
    sta cell_x                          ; ...as cell_x
    lda monster_y,x                     ; Its y...
    sta cell_y                          ; ...as cell_y
    clc                                 ; Ready to add the frame
    lda monster_sprite,x                ; Its facing sprite...
    adc monster_frame,x                 ; ...plus frame 0 or 1...
    sta sprite_number                   ; ...is the sprite to plot
    lda monster_offset_x,x              ; Horizontal offset of its step...
    sta plot_offset_x                   ; ...for plot_at_cell
    lda monster_offset_y,x              ; Vertical offset of its step...
    sta plot_offset_y                   ; ...for plot_at_cell
    txa                                 ; Keep the monster number...
    pha                                 ; ...over the plot
    jsr plot_at_cell                    ; Plot it in every view that shows it
; &7b28 referenced 3 times by &7b5f, &7cf8, &7cfb
.monster_done
    pla                                 ; Recover the monster number...
    tax                                 ; ...in X
    dex                                 ; Next monster
    beq update_monsters_done            ; Monster 0: all 30 done
    jmp next_monster_update             ; Otherwise update the next one
; &7b30 referenced 1 time by &7b2b
.update_monsters_done
    rts                                 ; Return
; &7b31 referenced 1 time by &7a14
.advance_dying_monster
    pla                                 ; Drop the stacked monster number (X still has it)
    inc monster_sprite,x                ; Next death frame
    lda monster_sprite,x                ; Read back the new frame
    cmp #spr_sparkle_3 + 1              ; Animation over?
    bne draw_monster_death              ; No: draw monster death
    jmp monster_reappears               ; Yes: bring it back at a trapdoor
; &7b3f referenced 1 time by &7b3a
.draw_monster_death
    txa                                 ; Draw the death frame
    pha                                 ; ...keeping the monster number
    lda monster_x,x                     ; Its x...
    sta cell_x                          ; ...as cell_x
    lda monster_y,x                     ; Its y...
    sta cell_y                          ; ...as cell_y
    lda monster_sprite,x                ; The death frame...
    sta sprite_number                   ; ...is the sprite
    lda monster_offset_x,x              ; Offsets as when it died...
    sta plot_offset_x                   ; ...across
    lda monster_offset_y,x              ; ...and down
    sta plot_offset_y                   ; ...for plot_at_cell
    jsr plot_at_cell                    ; Plot the death frame in every view
    jmp monster_done                    ; On to the next monster
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
    sta hero_step,x                     ; ...the step ends at the next frame
    lda hero_direction,x                ; Facing up: drawn 6 rows up
    cmp #1                              ; Facing up?
    bne hero_step_right                 ; No: try right
    lda #0                              ; Up: no horizontal offset...
    sta hero_offset_x,x                 ; ...cleared
    lda #&fa                            ; -6: drawn six pixel rows up...
    sta hero_offset_y,x                 ; ...as the vertical offset
    rts                                 ; Return
; &7b79 referenced 1 time by &7b6c
.hero_step_right
    cmp #3                              ; Facing right: 2 columns right
    bne hero_step_down                  ; No: try down
    lda #0                              ; Right: no vertical offset...
    sta hero_offset_y,x                 ; ...cleared
    lda #2                              ; +2: drawn two byte columns right...
    sta hero_offset_x,x                 ; ...as the horizontal offset
    rts                                 ; Return
; &7b88 referenced 1 time by &7b7b
.hero_step_down
    cmp #5                              ; Facing down: 6 rows down
    bne hero_step_left                  ; No: it faces left
    lda #0                              ; Down: no horizontal offset...
    sta hero_offset_x,x                 ; ...cleared
    lda #6                              ; +6: drawn six pixel rows down...
    sta hero_offset_y,x                 ; ...as the vertical offset
    rts                                 ; Return
; &7b97 referenced 1 time by &7b8a
.hero_step_left
    lda #0                              ; Facing left: 2 columns left
    sta hero_offset_y,x                 ; ...no vertical offset
    lda #&fe                            ; -2: drawn two byte columns left...
    sta hero_offset_x,x                 ; ...as the horizontal offset
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
    eor #1                              ; ...between frames 0 and 1...
    sta hero_frame,x                    ; ...so the hero walks
    dec hero_step,x                     ; Count down the step
    bne double_offsets                  ; Not over
    lda hero_direction,x                ; Over: move the cell on in the direction faced, up...
    cmp #1                              ; Facing up?
    bne continue_right                  ; No: try right
    dec hero_y,x                        ; Yes: one row up
; &7bb9 referenced 1 time by &7bb4
.continue_right
    cmp #3                              ; ...right...
    bne continue_down                   ; No: try down
    inc hero_x,x                        ; Yes: one column right
; &7bc0 referenced 1 time by &7bbb
.continue_down
    cmp #5                              ; ...down...
    bne continue_left                   ; No: try left
    inc hero_y,x                        ; Yes: one row down
; &7bc7 referenced 1 time by &7bc2
.continue_left
    cmp #7                              ; ...left
    bne hero_no_offsets                 ; No: no move
    dec hero_x,x                        ; Yes: one column left
; &7bce referenced 1 time by &7bc9
.hero_no_offsets
    lda #0                              ; ...with no offsets
    sta hero_offset_x,x                 ; ...clear the horizontal offset
    sta hero_offset_y,x                 ; ...and the vertical offset
; &7bd6 referenced 1 time by &7bad
.double_offsets
    clc                                 ; Double the offsets
    lda hero_offset_x,x                 ; Horizontal offset...
    adc hero_offset_x,x                 ; ...plus itself...
    sta hero_offset_x,x                 ; ...doubled
    clc                                 ; Ready for the vertical offset
    lda hero_offset_y,x                 ; Vertical offset...
    adc hero_offset_y,x                 ; ...plus itself...
    sta hero_offset_y,x                 ; ...doubled
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
    sta monster_step,x                  ; ...as the step count
    lda monster_sprite,x                ; First frame's offsets, in the direction of travel: up...
    cmp #spr_monster_up_0               ; Facing up?
    bne monster_step_right              ; No: try right
    lda #0                              ; Up: no horizontal offset...
    sta monster_offset_x,x              ; ...cleared
    lda #&fd                            ; ...3 rows up
    sta monster_offset_y,x              ; ...as the vertical offset
    rts                                 ; Return
; &7c02 referenced 1 time by &7bf5
.monster_step_right
    cmp #spr_monster_right_0            ; Moving right...
    bne monster_step_down               ; No: try down
    lda #0                              ; Right: no vertical offset...
    sta monster_offset_y,x              ; ...cleared
    lda #1                              ; ...1 column right
    sta monster_offset_x,x              ; ...as the horizontal offset
    rts                                 ; Return
; &7c11 referenced 1 time by &7c04
.monster_step_down
    cmp #spr_monster_down_0             ; Moving down...
    bne monster_step_left               ; No: it moves left
    lda #0                              ; Down: no horizontal offset...
    sta monster_offset_x,x              ; ...cleared
    lda #3                              ; ...3 rows down
    sta monster_offset_y,x              ; ...as the vertical offset
    rts                                 ; Return
; &7c20 referenced 1 time by &7c13
.monster_step_left
    lda #0                              ; Left: 1 column left
    sta monster_offset_y,x              ; ...no vertical offset
    lda #&ff                            ; -1: one byte column left...
    sta monster_offset_x,x              ; ...as the horizontal offset
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
    eor #1                              ; ...between frames 0 and 1...
    sta monster_frame,x                 ; ...so the monster walks
    dec monster_step,x                  ; Count down the step
    bne grow_offset_x                   ; Not over: grow the offsets
    lda monster_sprite,x                ; Over: move the cell on in its direction, up...
    cmp #spr_monster_up_0               ; Facing up?
    bne monster_continue_right          ; No: try right
    dec monster_y,x                     ; Yes: one row up
; &7c42 referenced 1 time by &7c3d
.monster_continue_right
    cmp #spr_monster_right_0            ; ...right...
    bne monster_continue_down           ; No: try down
    inc monster_x,x                     ; Yes: one column right
; &7c49 referenced 1 time by &7c44
.monster_continue_down
    cmp #spr_monster_down_0             ; ...down...
    bne monster_continue_left           ; No: try left
    inc monster_y,x                     ; Yes: one row down
; &7c50 referenced 1 time by &7c4b
.monster_continue_left
    cmp #spr_monster_left_0             ; ...left
    bne monster_no_offsets              ; No: no move
    dec monster_x,x                     ; Yes: one column left
; &7c57 referenced 1 time by &7c52
.monster_no_offsets
    lda #0                              ; ...with no offsets
    sta monster_offset_x,x              ; ...clear the horizontal offset
    sta monster_offset_y,x              ; ...and the vertical offset
; &7c5f referenced 1 time by &7c36
.grow_offset_x
    lda monster_offset_x,x              ; Grow the horizontal offset by a column, away from zero
    beq grow_offset_y                   ; Zero: not moving across
    bpl grow_offset_x_right             ; Positive: moving right
    dec monster_offset_x,x              ; Negative: one more column left
    jmp grow_offset_y                   ; Now the vertical offset
; &7c6c referenced 1 time by &7c64
.grow_offset_x_right
    inc monster_offset_x,x              ; Moving right: one more column right
; &7c6f referenced 2 times by &7c62, &7c69
.grow_offset_y
    lda monster_offset_y,x              ; Grow the vertical offset by three rows, away from zero
    beq monster_step_done               ; Zero: not moving up or down
    bpl grow_offset_y_down              ; Positive: moving down
    sec                                 ; Moving up: three more rows up...
    lda monster_offset_y,x              ; ...from the vertical offset...
    sbc #3                              ; ...less three...
    sta monster_offset_y,x              ; ...stored
    jmp monster_step_done               ; Done
; &7c82 referenced 1 time by &7c74
.grow_offset_y_down
    clc                                 ; Moving down: three more rows down...
    lda monster_offset_y,x              ; ...from the vertical offset...
    adc #3                              ; ...plus three...
    sta monster_offset_y,x              ; ...stored
; &7c8b referenced 2 times by &7c72, &7c7f
.monster_step_done
    rts                                 ; Return
    equb &de, &35, &0d, &bd, &35, &0d, &d0, &00
    equb &60                            ; Not referenced
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
    txa                                 ; Keep the caller's X...
    pha                                 ; ...on the stack
    tya                                 ; Key number...
    tax                                 ; ...in X for OSBYTE
    lda #osbyte_inkey                   ; OSBYTE &81 with Y = &FF: scan the key
    ldy #&ff                            ; Y = &FF: test the one key
    jsr osbyte                          ; Scan it: X = Y = &FF if the hero's key is held  Test whether the key with negative INKEY number X is pressed
    cpy #&ff                            ; X = Y = &FF if it is pressed
    bne key_not_pressed                 ; Y not &FF: not pressed
    cpx #&ff                            ; X = &FF too?
    bne key_not_pressed                 ; No: not pressed
    pla                                 ; Pressed: restore X and return A = 0, Z set
    tax                                 ; ...restoring the caller's X
    lda #0                              ; A = 0, Z set: pressed
    rts                                 ; Return
; &7cae referenced 2 times by &7ca3, &7ca7
.key_not_pressed
    pla                                 ; Not pressed: restore X and return A = 1
    tax                                 ; ...restoring the caller's X
    lda #1                              ; A = 1, Z clear: not pressed
    rts                                 ; Return
; &7cb3 referenced 1 time by &7b3c
.monster_reappears
    inc next_trapdoor                   ; Next trapdoor, 0-7 in turn
    lda next_trapdoor                   ; Which trapdoor now?
    cmp #8                              ; Past the eighth?
    bne emerge_at_trapdoor              ; No: use it
    lda #0                              ; Yes: round to trapdoor 0...
    sta next_trapdoor                   ; ...stored
; &7cc2 referenced 1 time by &7cbb
.emerge_at_trapdoor
    ldy next_trapdoor                   ; Y = the trapdoor to emerge from
    lda trapdoor_x,y                    ; Put the monster on it, facing up, with no step
    sta monster_x,x                     ; ...as the monster's x
    lda trapdoor_y,y                    ; The trapdoor's y...
    sta monster_y,x                     ; ...as the monster's y
    lda #spr_monster_up_0               ; Facing up...
    sta monster_sprite,x                ; ...as its sprite: alive again
    lda #0                              ; No step:
    sta monster_step,x                  ; ...clear the step count
    sta monster_offset_x,x              ; ...the horizontal offset
    sta monster_offset_y,x              ; ...and the vertical offset
    txa                                 ; Is anything else on the trapdoor? (A hero there is hurt)
    pha                                 ; ...keeping the monster number
    stx scratch                         ; Leave this monster out of the search
    jsr find_creature                   ; Look for a creature on the trapdoor
    cmp #0                              ; A = 0 if the trapdoor is free
    beq emerge_done                     ; No: done
    pla                                 ; Taken: park it off the map, still alive
    pha                                 ; ...keeping it stacked for monster_done
    tax                                 ; ...the monster number in X
    lda #off_map                        ; Off the map...
    sta monster_x,x                     ; ...as its x
    sta monster_y,x                     ; ...and its y
    jmp monster_done                    ; On to the next monster
; &7cfb referenced 1 time by &7ceb
.emerge_done
    jmp monster_done                    ; Done
    equb &00                            ; Not referenced
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
    equb &00                            ; scratch: working byte
    equb &00                            ; scratch2: working byte
    equb &1f                            ; cell_x: set before use
    equb &1f                            ; cell_y: set before use
    equb &d2                            ; cell_room: set before use
    equb &d2                            ; Copied to &0D05: no variable starts here
    equb &cc                            ; previous_x: set before use
    equb &b1                            ; previous_y: set before use
    equb &07                            ; previous_offset_x: set before use
    equb &07                            ; previous_offset_y: set before use
    equb &01, &01, &00, &2c, &34, &3c   ; Copied to &0D0A: no variable starts here
    equb &0b, &0b, &0c, &0c             ; hero_x: the heroes start at x 11, 11, 12, 12...
    equb &2f                            ; Copied to &0D14: no variable starts here
    equb &0b, &0c, &0b, &0c             ; hero_y: ...and y 11, 12, 11, 12, the four cells of the start
    equb &26                            ; Copied to &0D19: no variable starts here
    equb &01, &03, &05, &07             ; hero_direction: facing up, right, down and left
    equb &2d, &2f                       ; Copied to &0D1E: no variable starts here
    equb &01, &01, &01, &01             ; hero_frame: frame 1
    equb &5d                            ; Copied to &0D24: no variable starts here
    equb &00, &00, &00, &00             ; hero_step: not stepping
    equb &16                            ; Copied to &0D29: no variable starts here
    equb &00, &00, &00, &00             ; hero_offset_x: no offset
    equb &1d, &1f                       ; Copied to &0D2E: no variable starts here
    equb &00, &00, &00, &00             ; hero_offset_y: no offset
    equb &03, &05, &07, &05, &07, &36, &35, &37
    equb &3c, &3e, &3d, &3f             ; Copied to &0D34: no variable starts here
    equb &01, &82, &81, &83, &88, &8a, &89, &8b
    equb &84, &86, &85, &87             ; missile_x: unused while the slots are empty
    equb &8c, &8e, &8d, &8f, &08, &48, &8a, &48
    equb &98, &48, &ae, &ff             ; missile_y: unused while the slots are empty
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00             ; missile_direction: every slot empty
    equb &15, &85, &7a, &8a, &48, &20, &00, &09
    equb &68, &aa, &bd, &08             ; missile_sprite_base: set when a missile is fired
    equb inkey_key_caps_lock, inkey_key_keypad_hash, inkey_key_g, inkey_key_underscore  ; hero_key_up: each hero's up key
    equb inkey_key_shift_lock, inkey_key_keypad_del, inkey_key_b, inkey_key_return  ; hero_key_down
    equb inkey_key_z, inkey_key_keypad_comma, inkey_key_m, inkey_key_copy  ; hero_key_right
    equb inkey_key_shift, inkey_key_keypad_3, inkey_key_n, inkey_key_delete  ; hero_key_left
    equb inkey_key_tab, inkey_key_keypad_asterisk, inkey_key_space, inkey_key_left_square_bracket  ; hero_key_fire
    equb &0d, &c9, &05, &d0, &09, &18, &bd, &04
    equb &0d, &69, &03, &9d             ; Copied to &0D84: no variable starts here
    equb spr_digit_9, spr_digit_9, spr_digit_9, spr_digit_9  ; hero_health_tens: 9...
    equb &d0                            ; Copied to &0D94: no variable starts here
    equb spr_digit_9 + 1, spr_digit_9 + 1, spr_digit_9 + 1, spr_digit_9 + 1  ; hero_health_units: ...and one past 9: health 99 + 1, which draw_status_panel takes a point from
    equb &18, &bd, &08, &0d, &6d, &40, &0d  ; Copied to &0D99: no variable starts here
    equb <(room_walls + &28), >(room_walls + &28), <(room_walls + &28), >(room_walls + &28), <(room_walls + &28), >(room_walls + &28), <(room_walls + &28), >(room_walls + &28)  ; view_room: every view starts on room &0C28
    equb &00, &00, &bd, &04, &0d, &85, &71, &8a  ; Copied to &0DA8: no variable starts here
    equb spr_arrow_up - 1, spr_fireball_up - 1, spr_axe_up - 1, spr_sword_up - 1  ; hero_missile_sprites: arrows, fireballs, axes, swords
    equb &68                            ; Copied to &0DB4: no variable starts here
    equb spr_ranger_up_0 - 1, spr_magic_user_up_0 - 1, spr_barbarian_up_0 - 1, spr_fighter_up_0 - 1  ; hero_sprites: Ranger, Magic-User, Barbarian, Fighter
    equb &00, &0d, &d9                  ; Copied to &0DB9: no variable starts here
    equb &00, &00, &00, &00             ; hero_has_boots: none
    equb &80, &40, &20, &10, &08, &04, &02, &01  ; bit_masks: &80 down to &01
    equb &b9, &30, &0d, &9d, &08, &0d, &4c, &d4  ; Copied to &0DC8: no variable starts here
; &7dd0 used as index base 2 times by &0424, &0f71
    equb &18, &46, &74, &a2             ; hero_panel_y: the four sections of the status panel
    equb &e8, &e0, &04, &d0, &0a, &a2, &00, &ad
    equb &40, &0d, &49, &01, &8d, &40, &0d, &8e
    equb &ff, &0d, &68, &a8, &68, &aa, &68, &28
    equb &60, &de, &dd, &df, &f0, &f2, &f1, &f3
    equb &f8, &fa, &f9, &fb, &f4, &f6, &f5, &f7
    equb &fc                            ; Copied to &0DD4: no variable starts here
    equb &1e                            ; teleport_last: object &1E, the last
    equb &fd                            ; Copied to &0DFE: no variable starts here
    equb &00                            ; victory_sprite_copy: set before use
; &7e00 used as index base 17 times by &15ed, &7667, &797e, &79e7, &7a31, &7a3f, &7a45, &7a5b, &7a98, &7ace, &7afb, &7b04, &7b41, &7c46, &7c54, &7cc8, &7cf2
.monster_x
    equb &00, &04, &0b, &09, &1d, &08, &01, &06, &07, &0a, &01, &0b, &1a, &06, &0b, &16  ; Not read: reset_monsters and the trapdoors set the monsters
    equb &15, &0d, &1b, &14, &1a, &09, &1c, &0f, &1e, &02, &1a, &0b, &1c, &0e, &16, &00  ; ...entries 16-31, not read
    equb &00, &00, &00, &1a, &00, &00, &00, &00, &00  ; ...entries 32-40, not read
; &7e29 used as index base 16 times by &766d, &7986, &79f0, &7a2a, &7a38, &7a4b, &7a61, &7a9e, &7adc, &7b01, &7b0a, &7b47, &7c3f, &7c4d, &7cce, &7cf5
.monster_y
    equb &00, &24, &17, &25, &20, &24, &22, &14, &27, &0d, &20, &01, &26, &0a, &01, &12  ; Not read: reset_monsters and the trapdoors set the monsters
    equb &05, &20, &29, &0d, &26, &27, &08, &06, &1a, &14, &03, &1d, &07, &0d, &17, &00  ; ...entries 16-31, not read
    equb &00, &00, &00, &1b, &00, &00, &00, &00, &00  ; ...entries 32-40, not read
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
    equb &00, &ff, &ff, &ff, &ff, &ff, &18, &04, &04, &05, &ff, &ff, &ff, &ff, &ff, &ff  ; Not read: unpack_level copies each level's objects here
    equb &ff, &ff, &ff, &ff, &ff, &01, &07, &04, &04, &ff, &ff, &ff, &ff, &ff  ; ...entries 16-29, not read
; &7f3e referenced 4 times by &1f3b, &1f77, &1f85, &2029
.exit_x
    equb &04                            ; ...the exit's entry
; &7f3f used as index base 9 times by &157c, &717b, &719d, &7313, &7342, &73f3, &7416, &746c, &74be
.object_y
    equb &00, &ff, &ff, &ff, &ff, &ff, &15, &18, &19, &19, &ff, &ff, &ff, &ff, &ff, &ff  ; Not read: unpack_level copies each level's objects here
    equb &ff, &ff, &ff, &ff, &ff, &2a, &2a, &2b, &2e, &ff, &ff, &ff, &ff, &ff  ; ...entries 16-29, not read
; &7f5d referenced 4 times by &1f43, &1f7d, &1f88, &202f
.exit_y
    equb &2c                            ; ...the exit's entry
; &7f5e used as index base 7 times by &1582, &7183, &718e, &7191, &7319, &735c, &73c8
.object_type
    equb &00, &5f, &5f, &5f, &29, &63, &5f, &53, &2b, &53, &28, &28, &60, &60, &28, &2a  ; Not read: unpack_level copies each level's objects here
    equb &62, &28, &28, &29, &28, &2b, &2b, &2b, &2b, &29, &28, &28, &29, &28  ; ...entries 16-29, not read
    equb &51                            ; ...the exit's entry
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00                       ; Not referenced
; ***************************************************************************************
; WRCHV handler: pass every character to the MOS
;
; The game points WRCHV here; it jumps straight to MOS 3.20's OSWRCH, so text appears in
; the MOS font.
;
; On Entry:
;     A: the character
;
; On Exit:
;     A: preserved
.wrch_handler
    jmp mos320_oswrch_default           ; Pass every character straight to MOS 3.20's OSWRCH (&E822)
; ***************************************************************************************
; The game-font WRCHV handler, unused
;
; The rest of a WRCHV handler that prints letters and digits in the game's own font
; (font_letters, font_digits). WRCHV's entry at &7F8F jumps straight to the MOS, so none
; of this runs and text appears in the MOS font.
.unused_font_handler
    pha                                 ; Save X (the TXA before it is now the JMP's operand)...
    tya                                 ; ...and Y
    pha                                 ; ...on the stack
    lda plot_x                          ; Classify the character
    cmp #'0'                            ; Below '0': print it unchanged
    bcc pass_character                  ; Controls, space, punctuation: print as they are
    cmp #':'                            ; '0'-'9': a digit
    bcc digit_glyph                     ; A digit: print the game's digit glyph
    cmp #'A'                            ; ':'-'@': print it unchanged
    bcc pass_character                  ; Punctuation: print it as it is
    cmp #'['                            ; 'A'-'Z': a capital letter
    bcc capital_letter                  ; A capital: print the game's letter glyph
    cmp #'a'                            ; '['-'`': print it unchanged
    bcc pass_character                  ; Punctuation: print it as it is
    cmp #'{'                            ; Above 'z': print it unchanged
    bcs pass_character                  ; Beyond 'z': print it as it is
    sec                                 ; A lower-case letter: letter number 0-25
    sbc #'a'                            ; ...lower case uses the capitals' glyphs
    jmp glyph_offset                    ; ...then find its glyph
; &7fb5 referenced 1 time by &7fa5
.capital_letter
    sec                                 ; A capital letter: letter number 0-25
    sbc #'A'                            ; ...0 for A
; &7fb8 referenced 1 time by &7fb2
.glyph_offset
    asl a                               ; x 8: offset of the glyph in font_letters
    asl a                               ; ...x 4...
    asl a                               ; ...x 8
    bne copy_glyph                      ; Branch to the next instruction either way
; &7fbd referenced 1 time by &7fbb
.copy_glyph
    tax                                 ; X = offset of the first glyph byte
    clc                                 ; Stop after eight bytes
    adc #8                              ; ...the end offset, start + 8...
    sta plot_x                          ; ...kept in plot_x
    ldy #0                              ; Y indexes the character 128 definition
; &7fc5 referenced 1 time by &7fcf
.copy_letter_glyph
    lda font_letters,x                  ; Copy a glyph byte...
    sta room_walls,y                    ; ...into the character 128 definition
    iny                                 ; Next row of character 128
    inx                                 ; Next glyph byte
    cpx plot_x                          ; All eight rows copied?
    bne copy_letter_glyph               ; Loop for eight bytes
; &7fd1 referenced 1 time by &7ff4
.restore_registers
    pla                                 ; Restore Y...
    tay                                 ; ...from the stack
    pla                                 ; ...and X
    tax                                 ; ...from the stack
    lda #&80                            ; Print character 128, now showing the glyph...
    jmp mos120_oswrch_default           ; ...through the MOS 1.20 OSWRCH routine
; &7fda referenced 1 time by &7f9d
.digit_glyph
    sec                                 ; A digit: digit number 0-9
    sbc #'0'                            ; ...0 for '0'
    asl a                               ; x 8: offset of the glyph in font_digits
    asl a                               ; ...x 4...
    asl a                               ; ...x 8
    tax                                 ; X = offset of the first glyph byte
    clc                                 ; Stop after eight bytes
    adc #8                              ; ...the end offset, start + 8...
    sta plot_x                          ; ...kept in plot_x
    ldy #0                              ; Y indexes the character 128 definition
; &7fe8 referenced 1 time by &7ff2
.copy_digit_glyph
    lda font_digits,x                   ; Copy a glyph byte...
    sta room_walls,y                    ; ...into the character 128 definition
    iny                                 ; Next row of character 128
    inx                                 ; Next glyph byte
    cpx plot_x                          ; All eight rows copied?
    bne copy_digit_glyph                ; Loop for eight bytes
    beq restore_registers               ; Print character 128 (always branches)
; &7ff6 referenced 4 times by &7f99, &7fa1, &7fa9, &7fad
.pass_character
    pla                                 ; Any other character: restore Y...
    tay                                 ; ...from the stack
    pla                                 ; ...and X
    tax                                 ; ...from the stack
    lda plot_x                          ; Recover the character
    jmp mos120_oswrch_default           ; ...and print it through the MOS 1.20 OSWRCH routine
    equb &00                            ; Not referenced
.dasmos_dunj2_end

    org &c500

.dasmos_code_start
; ***************************************************************************************
; BYTEV handler: read a joystick for the Barbarian's keys
;
; Installed by Coder2. Answers OSBYTE &81 scans of the third hero's keys from the
; analogue port: N (&AA) and M (&9A) from channel 1 at its extremes, B (&9B) and G (&AC)
; from channel 2, and fire (SPACE, &9D) from the fire buttons. Every other call goes to
; the MOS 3.20 OSBYTE routine at &EEB1 directly.
;
; On Entry:
;     A: OSBYTE number
;     X: OSBYTE X
;
; On Exit:
;     X: &FF if the key is pressed, 0 if not
.joystick_bytev
    cmp #&81                            ; OSBYTE &81 (INKEY)?
    bne joystick_pass_on                ; No: pass it on
    cpx #inkey_key_n                    ; N (left)?
    beq joystick_left                   ; Yes: read the stick for left
    cpx #inkey_key_b                    ; B (down)?
    beq joystick_down                   ; Yes: read the stick for down
    cpx #inkey_key_g                    ; G (up)?
    beq joystick_up                     ; Yes: read the stick for up
    cpx #inkey_key_m                    ; M (right)?
    beq joystick_right                  ; Yes: read the stick for right
    cpx #inkey_key_space                ; SPACE (fire)?
    beq joystick_fire                   ; Yes: read the fire buttons
    jmp mos320_osbyte_default           ; Another key: pass it on
; &c51b referenced 1 time by &c506
.joystick_left
    ldx #1                              ; N: channel 1 high byte &FF?
    lda #osbyte_read_adc_or_get_buffer_status  ; ...with OSBYTE &80, reading the ADC
    jsr osbyte                          ; ...the stick's left-right position  Read ADC channel X or buffer status
    cpy #&ff                            ; ...high byte &FF: pushed fully left?
    bne joystick_not_pressed            ; No: not pressed
    ldx #&ff                            ; Yes: pressed
    rts                                 ; Return
; &c529 referenced 1 time by &c512
.joystick_right
    ldx #1                              ; M: channel 1 high byte 0?
    lda #osbyte_read_adc_or_get_buffer_status  ; ...with OSBYTE &80, reading the ADC
    jsr osbyte                          ; ...the stick's left-right position  Read ADC channel X or buffer status
    cpy #0                              ; ...high byte 0: pushed fully right?
    bne joystick_not_pressed            ; No: not pressed
    dey                                 ; Yes: pressed (Y = &FF)
    ldx #&ff                            ; ...X = Y = &FF, as INKEY reports a key held
    rts                                 ; Return
; &c538 referenced 1 time by &c50e
.joystick_up
    ldx #2                              ; G: channel 2 high byte &FF?
    lda #osbyte_read_adc_or_get_buffer_status  ; ...with OSBYTE &80, reading the ADC
    jsr osbyte                          ; ...the stick's up-down position  Read ADC channel X or buffer status
    cpy #&ff                            ; ...high byte &FF: pushed fully up?
    bne joystick_not_pressed            ; No: not pressed
    ldx #&ff                            ; Yes: pressed
    rts                                 ; Return
; &c546 referenced 1 time by &c50a
.joystick_down
    ldx #2                              ; B: channel 2 high byte 0?
    lda #osbyte_read_adc_or_get_buffer_status  ; ...with OSBYTE &80, reading the ADC
    jsr osbyte                          ; ...the stick's up-down position  Read ADC channel X or buffer status
    cpy #0                              ; ...high byte 0: pushed fully down?
    bne joystick_not_pressed            ; No: not pressed
    dey                                 ; Yes: pressed (Y = &FF)
    ldx #&ff                            ; ...X = Y = &FF, as INKEY reports a key held
    rts                                 ; Return
; &c555 referenced 1 time by &c516
.joystick_fire
    ldx #0                              ; Fire: either fire button?
    lda #osbyte_read_adc_or_get_buffer_status  ; ...OSBYTE &80, X = 0: the fire buttons in X
    jsr osbyte                          ; ...read them  Read ADC channel X or buffer status
    txa                                 ; ...the button bits...
    and #3                              ; ...bits 0-1: either button held?
    beq joystick_not_pressed            ; No: not pressed
    ldx #&ff                            ; Yes: pressed
    ldy #&ff                            ; ...X = Y = &FF, as INKEY reports a key held
    rts                                 ; Return
; &c566 referenced 5 times by &c524, &c532, &c541, &c54f, &c55f
.joystick_not_pressed
    ldx #0                              ; Not pressed
    rts                                 ; Return
; &c569 referenced 1 time by &c502
.joystick_pass_on
    jmp mos320_osbyte_default           ; Pass the call on to the MOS 3.20 OSBYTE routine
.dasmos_code_end

    org &c5a0

.dasmos_table_start
; ***************************************************************************************
; Load level 25 from Stones
;
; Level 25 has no file of its own: Stones ends with its data, so *LOAD STONES 6680 puts
; it at &6B00. Then decrypt and check it.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &c5a0 referenced 1 time by &14ee
.load_stones
    ldx #<(stones_command)              ; *LOAD STONES 6680
    ldy #>(stones_command)              ; ...high byte of the command
    jsr oscli                           ; ...level 25 is at the end of Stones
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
    equb &00, &00, &00, &00, &00, &00   ; Not referenced
; ***************************************************************************************
; Stop the music for the game-over message
;
; Stop the music, send the VDU 28 that the game-over code's text window begins with, and
; set the top row in clear_text_area's window to 0.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &c600 referenced 1 time by &0e86
.game_over_music
    jsr stop_music                      ; Stop the music
    lda #&1c                            ; VDU 28: the game-over text window...
    jsr oswrch                          ; ...game_entry sends its four edges next
    lda #0                              ; Top row 0 in clear_text_area's window
    sta clear_text_area_top             ; ...patched into clear_text_area's VDU 28
    rts                                 ; Return
; ***************************************************************************************
; Unused
;
; Leftover bytes: the end of a routine that selects COLOUR 2 and runs *DUNJUNZ (its
; command follows), and zeros.
    equb &ee, &ff, &a9, &02, &20, &ee, &ff
    equb &a2, &1c, &a0, &c6, &20, &f7, &ff  ; Not used
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
    equb &00, &00                       ; Not referenced
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
    equb &00                            ; Not referenced
; ***************************************************************************************
; *FREE
;
; Show the disc's free space. The game never calls it: *EDITOR does, after cataloguing
; the disc, relying on Table being in private RAM.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
.show_free_space
    ldx #<(free_command)                ; *FREE...
    ldy #>(free_command)                ; ...high byte of the command
    jsr oscli                           ; ...print the disc's free space
    rts                                 ; Return
.free_command
    equs "FREE", &0d
    equb &00, &00, &00                  ; Not referenced
; ***************************************************************************************
; Pause while P is pressed
;
; Called from check_pause in the game's update. If P (internal key &37) is held, wait for
; it to be released, pressed again and released, then restart the frame timing.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &c6d0 referenced 1 time by &1ed7
.pause_check
    lda #osbyte_scan_keyboard_from_16   ; OSBYTE &7A: which key is pressed?
    jsr osbyte                          ; ...X = the key held, if any  Scan keyboard from key 16
    cpx #&37 ; '7'                      ; P?
    bne not_paused                      ; No: return
    jsr wait_p_released                 ; Paused: wait for P to be released...
; &c6dc referenced 1 time by &c6e3
.wait_p_pressed
    lda #osbyte_scan_keyboard_from_16   ; ...pressed again...
    jsr osbyte                          ; ...X = the key held  Scan keyboard from key 16
    cpx #&37 ; '7'                      ; ...P?
    bne wait_p_pressed                  ; No: stay paused
    jsr wait_p_released                 ; ...and released
    lda #2                              ; Restart the frame timing
    sta os_vsync_counter                ; ...so play resumes with a full frame delay
; &c6ed referenced 1 time by &c6d7
.not_paused
    rts                                 ; Return
; ***************************************************************************************
; Wait until P is not pressed
;
; Scan the keyboard with OSBYTE &7A until the key found is no longer P (internal key
; &37).
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &c6ee referenced 3 times by &c6d9, &c6e5, &c6f5
.wait_p_released
    lda #osbyte_scan_keyboard_from_16   ; OSBYTE &7A: which key is pressed?
    jsr osbyte                          ; ...X = the key held  Scan keyboard from key 16
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
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &c700 referenced 1 time by &1461
.start_music
    ldx #<(envelope_6)                  ; ENVELOPE 6...
    ldy #>(envelope_6)                  ; ...high byte
    lda #osword_envelope                ; ...OSWORD 8 defines it
    jsr osword                          ; ...for the tune's notes  ENVELOPE command
    ldx #<(envelope_7)                  ; ENVELOPE 7...
    ldy #>(envelope_7)                  ; ...high byte
    lda #osword_envelope                ; ...OSWORD 8 defines it
    jsr osword                          ; ...for the tune's notes  ENVELOPE command
    ldx #<(envelope_8)                  ; ENVELOPE 8...
    ldy #>(envelope_8)                  ; ...high byte
    lda #osword_envelope                ; ...OSWORD 8 defines it
    jsr osword                          ; ...for the tune's notes  ENVELOPE command
    ldx #<(envelope_9)                  ; ENVELOPE 9
    ldy #>(envelope_9)                  ; ...high byte
    lda #osword_envelope                ; ...OSWORD 8 defines it
    jsr osword                          ; ...for the tune's notes  ENVELOPE command
    lda #&4c ; 'L'                      ; Make plot_sprite JMP &D800, the copy in Code3...
    sta plot_sprite                     ; ...over plot_sprite's first byte
    lda #<(plot_sprite_hazel)           ; ...JMP to the copy: address low byte...
    sta plot_sprite + 1                 ; ...stored
    lda #>(plot_sprite_hazel)           ; ...high byte...
    sta plot_sprite + 2                 ; ...stored: sprites now plot from HAZEL
    lda #<(tune)                        ; Tune pointer (zero page &00-&01) = the first section...
    sta tune_ptr                        ; ...low byte stored
    lda #>(tune)                        ; ...high byte...
    sta tune_ptr + 1                    ; ...stored
    lda #0                              ; Section 0
    sta music_section                   ; ...stored
    lda #&ff                            ; Rhythm step -1, so the first step plays step 0
    sta music_rhythm_step               ; ...stored
    lda #0                              ; No transposition
    sta music_transpose                 ; ...stored
    lda #<(music_event)                 ; EVNTV = music_event...
    sta evntv                           ; ...low byte
    lda #>(music_event)                 ; ...high byte
    sta evntv + 1                       ; ...so each timer event plays a step
    lda #osbyte_enable_event            ; OSBYTE 14, 5: enable the interval timer event
    ldx #event_interval_timer_crossing_zero  ; ...event 5, the interval timer...
    ldy #0                              ; ...Y = 0
    jsr osbyte                          ; ...enabled  Enable event
    jmp music_event                     ; Play the first step, and return from there
; ***************************************************************************************
; Stop the music
;
; OSBYTE 13, 5: disable the interval timer event.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &c760 referenced 2 times by &1419, &c600
.stop_music
    lda #osbyte_disable_event           ; OSBYTE 13, 5: disable the interval timer event
    ldx #event_interval_timer_crossing_zero  ; ...event 5, the interval timer...
    ldy #0                              ; ...Y = 0
    jmp osbyte                          ; ...disabled, returning from there  Disable event
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
    pha                                 ; ...A...
    tya                                 ; ...Y, via A...
    pha                                 ; ...pushed
    txa                                 ; ...X, via A...
    pha                                 ; ...pushed: the interrupted code keeps them
    ldy #0                              ; First byte of the step...
    lda (tune_ptr),y                    ; ...the step's transposition byte
    cmp #&ff                            ; ...&FF?
    beq end_of_section                  ; Yes: end of the section
; &c77a referenced 1 time by &c81a
.play_step
    cmp #0                              ; Non-zero: a new transposition
    beq play_channel_2                  ; Zero: keep the transposition
    sta music_transpose                 ; ...as the new transposition
; &c781 referenced 1 time by &c77c
.play_channel_2
    ldy #1                              ; Second byte: channel 2's pitch...
    lda (tune_ptr),y                    ; ...read
    beq play_channel_3                  ; ...0 for none
    sta channel_2_sound + 4             ; ...into its SOUND block's pitch
    ldx #<(channel_2_sound)             ; SOUND channel_2_sound...
    ldy #>(channel_2_sound)             ; ...high byte
    lda #osword_sound                   ; ...OSWORD 7: SOUND
    jsr osword                          ; ...play the note  SOUND command
; &c793 referenced 1 time by &c785
.play_channel_3
    ldy #2                              ; Third byte: channel 3's pitch...
    lda (tune_ptr),y                    ; ...read
    beq next_step                       ; ...0 for none
    sta channel_3_sound + 4             ; ...into its SOUND block's pitch
    ldx #<(channel_3_sound)             ; SOUND channel_3_sound...
    ldy #>(channel_3_sound)             ; ...high byte
    lda #osword_sound                   ; ...OSWORD 7: SOUND
    jsr osword                          ; ...play the note  SOUND command
; &c7a5 referenced 1 time by &c797
.next_step
    lda tune_ptr                        ; Next step: tune_ptr += 3...
    clc                                 ; ...three bytes...
    adc #3                              ; ...past this step
    sta tune_ptr                        ; ...low byte
    lda tune_ptr + 1                    ; ...high byte...
    adc #0                              ; ...with the carry
    sta tune_ptr + 1                    ; ...stored
    lda music_rhythm_step               ; Next rhythm step, 0-31...
    clc                                 ; ...one...
    adc #1                              ; ...on
    cmp #&20 ; ' '                      ; ...past 31?
    bmi store_rhythm_step               ; No: keep it
    lda #0                              ; Yes: back to step 0
; &c7be referenced 1 time by &c7ba
.store_rhythm_step
    sta music_rhythm_step               ; ...the step to play
    tay                                 ; Its pitch, 0 for a rest...
    lda rhythm_pattern,y                ; ...the bass pitch for this step
    beq set_step_timer                  ; Zero: a rest, no note
    clc                                 ; ...transposed...
    adc music_transpose                 ; ...plus the transposition
    sta channel_1_sound + 4             ; ...into channel 1's SOUND block
    ldx #<(channel_1_sound)             ; ...on channel 1...
    ldy #>(channel_1_sound)             ; ...high byte
    lda #osword_sound                   ; ...OSWORD 7: SOUND
    jsr osword                          ; ...play the bass note  SOUND command
    ldx #<(noise_sound)                 ; ...with the noise channel
    ldy #>(noise_sound)                 ; ...high byte
    lda #osword_sound                   ; ...OSWORD 7: SOUND
    jsr osword                          ; ...play the beat  SOUND command
; &c7e0 referenced 1 time by &c7c5
.set_step_timer
    ldx #<(music_interval)              ; OSWORD 4: interval timer = -12 centiseconds, for the next step
    ldy #>(music_interval)              ; ...high byte
    lda #osword_write_interval_timer    ; ...OSWORD 4: write the interval timer
    jsr osword                          ; ...so the next event comes 12 cs on  Write interval timer
    pla                                 ; Restore the registers and flags
    tax                                 ; ...X...
    pla                                 ; ...then Y's byte...
    tay                                 ; ...Y...
    pla                                 ; ...A...
    plp                                 ; ...and the flags
    rts                                 ; Return
; &c7f0 referenced 1 time by &c778
.end_of_section
    ldy #1                              ; End of section: the next byte is channel 3's envelope
    lda (tune_ptr),y                    ; ...read
    sta channel_3_sound + 2             ; ...into its SOUND block
    inc music_section                   ; Next section...
    lda music_section                   ; ...the new section...
    cmp #&19                            ; ...25?
    bne start_section                   ; ...past 24?
    lda #&ff                            ; Yes: back to section 1, with the rhythm restarting
    sta music_rhythm_step               ; ...rhythm step -1 again...
    lda #1                              ; ...section 1...
    sta music_section                   ; ...stored
; &c80b referenced 1 time by &c7ff
.start_section
    tay                                 ; Point tune_ptr at the section...
    lda section_ptrs_lo,y               ; ...address low byte...
    sta tune_ptr                        ; ...into tune_ptr
    lda section_ptrs_hi,y               ; ...high byte...
    sta tune_ptr + 1                    ; ...complete
    ldy #0                              ; ...and play its first step
    lda (tune_ptr),y                    ; ...its first byte, the transposition
    jmp play_step                       ; ...played as any other step
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
    equb &74                            ; Not referenced
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
    sta sprite_data_ptr_hi              ; ...into sprite_data_ptr
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
    sta row_start_ptr                   ; ...low byte
    lda screen_ptr_hi                   ; ...and high byte...
    sta row_start_ptr_hi                ; ...in row_start_ptr
    txa                                 ; Save the row count
    pha                                 ; ...on the stack: X now counts bytes
    ldx sprite_width                    ; X counts the bytes across this row
; &d829 referenced 1 time by &d83f
.plot_sprite_byte_hazel
    lda (sprite_data_ptr),y             ; Copy one sprite byte...
    sta (screen_ptr),y                  ; ...to the screen
    clc                                 ; Step screen_ptr right one byte column: 8 bytes on
    lda screen_ptr                      ; ...the screen address's low byte...
    adc #8                              ; ...+ 8, the next byte column...
    sta screen_ptr                      ; ...stored back
    bcc plot_sprite_next_data_hazel     ; No carry: the high byte stands
    inc screen_ptr_hi                   ; ...with carry into the high byte
; &d838 referenced 1 time by &d834
.plot_sprite_next_data_hazel
    inc sprite_data_ptr                 ; Next sprite data byte
    bne plot_sprite_count_byte_hazel    ; No carry: the high byte stands
    inc sprite_data_ptr_hi              ; ...with carry into the high byte
; &d83e referenced 1 time by &d83a
.plot_sprite_count_byte_hazel
    dex                                 ; Count the bytes across
    bne plot_sprite_byte_hazel          ; Loop until the row is done
    clc                                 ; screen_ptr = row start + 1: the next pixel row down
    lda row_start_ptr                   ; The row start's low byte...
    adc #1                              ; ...+ 1...
    sta screen_ptr                      ; ...is the new low byte
    lda row_start_ptr_hi                ; The row start's high byte...
    adc #0                              ; ...plus the carry...
    sta screen_ptr_hi                   ; ...is the new high byte
    lda screen_ptr                      ; Has it crossed into the next character row?
    and #7                              ; ...(pixel row within the character now 0)
    bne plot_sprite_next_row_hazel      ; No: carry on
    clc                                 ; Yes: add 640-8 to reach the top pixel row of the...
    lda screen_ptr                      ; ...character row below
    adc #&78 ; 'x'                      ; ...low byte + &78 (640 - 8 = &278)...
    sta screen_ptr                      ; ...stored
    lda screen_ptr_hi                   ; ...high byte...
    adc #2                              ; ...+ 2 and the carry...
    sta screen_ptr_hi                   ; ...stored
; &d861 referenced 1 time by &d852
.plot_sprite_next_row_hazel
    pla                                 ; Recover the row count
    tax                                 ; ...back into X
    dex                                 ; Count the pixel rows
    bne plot_sprite_row_hazel           ; Loop until the sprite is done
    rts                                 ; Return
; ***************************************************************************************
; Calculate a screen address
;
; Set screen_ptr to the screen address of byte column plot_x on pixel row plot_y: &3000 +
; 640 x (plot_y DIV 8) + (plot_y MOD 8) + 8 x plot_x. The multiplication by 640 uses
; row_offsets in Table, a copy of the MOS 1.20 table, in private RAM.
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
    lsr a                               ; ...halved...
    lsr a                               ; ...and halved again...
    and #&fe                            ; ...times 2 to index the table's byte pairs
    tay                                 ; ...as the index into the MOS table
    lda row_offsets,y                   ; High byte of row x 640, from Table's copy of the MOS 1.20 table...
    clc                                 ; ...(carry clear for the add)
    adc #>(screen_start)                ; ...plus &30: the screen starts at &3000
    sta screen_ptr_hi                   ; ...as the screen address high byte
    lda row_offsets_lo,y                ; Low byte of row x 640
    sta screen_ptr                      ; ...as the low byte
    lda plot_y                          ; Add the pixel row within the character...
    and #7                              ; ...plot_y MOD 8...
    adc screen_ptr                      ; ...(no carry: the low byte is &00 or &80)
    sta screen_ptr                      ; ...stored in the low byte
    clc                                 ; Add 8 x plot_x: first its top three bits...
    lda plot_x                          ; ...from plot_x...
    and #&e0                            ; ...bits 7-5 kept...
    rol a                               ; ...rotated down to bits 0-2...
    rol a                               ; ...bit 7 into bit 0 via the carry
    rol a                               ; ...then bit 6; bit 7 to bit 1
    rol a                               ; ...bits 7-5 now in bits 2-0
    clc                                 ; ...(carry clear for the add)
    adc screen_ptr_hi                   ; ...into the high byte
    sta screen_ptr_hi                   ; ...stored
    lda plot_x                          ; ...then plot_x x 8 into the low byte
    asl a                               ; ...x 2...
    asl a                               ; ...x 4...
    asl a                               ; ...x 8, its top bits dropping out
    clc                                 ; ...(carry clear for the add)
    adc screen_ptr                      ; ...added to the low byte
    sta screen_ptr                      ; ...stored
    bcc screen_address_done_hazel       ; No carry: done
    inc screen_ptr_hi                   ; ...with carry into the high byte
; &d89f referenced 1 time by &d89b
.screen_address_done_hazel
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
    equb &01, &00, &00, &05, &03, &01, &00  ; Not used
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
;     plot_x:                        47
;     sprite_number:                 45
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
;     count:                          5
;     erase_hero:                     5
;     exit_busy:                      5
;     exit_spin:                      5
;     hero_score_hundreds:            5
;     hero_score_tens:                5
;     hero_score_thousands:           5
;     joystick_not_pressed:           5
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
;     pass_character:                 4
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
;     room_walls:                     3
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
;     monster_step_done:              2
;     monster_x + 35:                 2
;     monster_y + 35:                 2
;     mos120_oswrch_default:          2
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
;     capital_letter:                 1
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
;     coder_display_vdu:              1
;     collect_objects:                1
;     collect_objects_done:           1
;     continue_down:                  1
;     continue_hero_step:             1
;     continue_left:                  1
;     continue_monster_step:          1
;     continue_right:                 1
;     copy_digit_glyph:               1
;     copy_glyph:                     1
;     copy_letter_glyph:              1
;     copy_workspace_template:        1
;     count_heroes_in_play:           1
;     count_level:                    1
;     credit_drainer_hit:             1
;     cross_done:                     1
;     dasmos_start:                   1
;     decrypt_level_done:             1
;     decrypt_level_next:             1
;     digit_glyph:                    1
;     dissolve_chalice:               1
;     dissolve_done:                  1
;     door_points_loop:               1
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
;     end_of_section:                 1
;     erase_boots_icon:               1
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
;     font_digits:                    1
;     font_letters:                   1
;     game_over_message:              1
;     game_over_music:                1
;     glyph_offset:                   1
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
;     joystick_down:                  1
;     joystick_fire:                  1
;     joystick_left:                  1
;     joystick_pass_on:               1
;     joystick_right:                 1
;     joystick_up:                    1
;     keys_done:                      1
;     level_checksums:                1
;     level_command_two_digits:       1
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
;     load_level_file:                1
;     load_stones:                    1
;     magic_cast:                     1
;     magic_item:                     1
;     magic_sword:                    1
;     magic_user_cost:                1
;     mark_first_level_done:          1
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
;     mos320_oswrch_default:          1
;     move_hero:                      1
;     move_heroes:                    1
;     move_heroes_done:               1
;     move_missile:                   1
;     move_missiles:                  1
;     move_missiles_done:             1
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
;     next_step:                      1
;     next_turn:                      1
;     no_magic:                       1
;     no_victory:                     1
;     not_paused:                     1
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
;     play_channel_2:                 1
;     play_channel_3:                 1
;     play_level_done:                1
;     play_step:                      1
;     plot_at_cell_done:              1
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
;     restore_page_0d_byte:           1
;     restore_registers:              1
;     restore_sprite_heights:         1
;     restore_sprite_widths:          1
;     reverse_down:                   1
;     reverse_left:                   1
;     reverse_right:                  1
;     rhythm_pattern:                 1
;     room_walls + 58:                1
;     save_page_0d_byte:              1
;     screen_address:                 1
;     screen_address_done:            1
;     screen_address_done_hazel:      1
;     screen_address_hazel:           1
;     section_ptrs_hi:                1
;     section_ptrs_lo:                1
;     select_colour_2:                1
;     send_coder_vdu:                 1
;     send_frame_vdu:                 1
;     set_bell:                       1
;     set_menu_no:                    1
;     set_menu_off:                   1
;     set_menu_on:                    1
;     set_menu_yes:                   1
;     set_monster_step:               1
;     set_step_timer:                 1
;     shift_returning_queue:          1
;     show_view_3:                    1
;     shrink_display_for_loading:     1
;     shrink_hero_height:             1
;     shrink_hero_width:              1
;     sound_victory_bell:             1
;     sprite_chalice:                 1
;     sprite_chalice - 1:             1
;     start_level:                    1
;     start_monster_move:             1
;     start_monster_step:             1
;     start_music:                    1
;     start_section:                  1
;     stay_in_old_cell:               1
;     step_down:                      1
;     step_left:                      1
;     step_right:                     1
;     stop_music_and_load:            1
;     store_hero_frame:               1
;     store_level_units:              1
;     store_monster_health:           1
;     store_rhythm_step:              1
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
;     update_monsters_done:           1
;     update_rest:                    1
;     victory_delay_inner:            1
;     victory_delay_loop:             1
;     victory_delay_outer:            1
;     victory_sequence:               1
;     victory_sprite_copy:            1
;     wait_p_pressed:                 1
;     wait_vsync_chalice:             1
;     wait_vsync_game_over:           1
;     wall_sprite:                    1
;     workspace_template:             1
;     wrchv:                          1
;     wrchv + 1:                      1

; Stats:
;     Total size (Code + Data) = 20187 bytes
;     Code                     = 7556 bytes (37%)
;     Data                     = 12631 bytes (63%)
;
;     Number of instructions   = 3500
;     Number of data bytes     = 11967 bytes
;     Number of data words     = 64 bytes
;     Number of string bytes   = 600 bytes
;     Number of strings        = 55
