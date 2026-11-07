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
victory_sprite        = &82  ; Sprite drawn in the victory ring: a sparkle, &16-&19, or the blank, &15, to erase it.
; &82 referenced 6 times by &10f8, &115e, &11a4, &11ac, &11bb, &11d5
victory_delay         = &84  ; Wait between passes of the victory sequence, in units of 255 loops: &E6 at the start, one less each pass, down to 1.
; &84 referenced 5 times by &1100, &111c, &1122, &1133, &113c
victory_pitch_step    = &8d  ; Amount the victory tone's pitch rises each pass: 1 at the start, one more each time the pitch wraps past 255.
; &8d referenced 3 times by &1108, &110d, &1113
victory_steps_left    = &8e  ; Pitch wraps left before the victory sequence ends: &32 (50) at the start.
; &8e referenced 2 times by &1104, &1115
victory_pitch         = &8f  ; Pitch of the bell in the victory sequence, set with OSBYTE &D5.
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
; Advance the thousands digit of hero X's score. It is called from add_ten_points when
; the hundreds digit carries, and returns to draw_score there, which redraws the four
; large score digits. The panel has room for only those four, so when the thousands digit
; passes 9 it goes back to 0 and a separate ten-thousands digit, held as a small digit
; sprite, goes up, sticking at 9. That digit is then drawn under the score at
; draw_ten_thousands, followed by four of sprite &71. Sprite &71, the small 8, is a solid
; bar two pixels wide, the same shape a small 0 would have, so the line reads as a small
; N0000. remove_absent_heroes enters at draw_ten_thousands to redraw the line at the
; start of each level.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &0400 referenced 1 time by &72b9
.add_thousand_points
    inc hero_score_thousands,x          ; One more thousand: the hundreds digit carried
    lda hero_score_thousands,x          ; ...and check the new digit
    cmp #spr_digit_9 + 1                ; Past 9?
    bne add_thousand_points_done        ; No: return; draw_score shows the new digit
    lda #spr_digit_0                    ; Yes: thousands 0...
    sta hero_score_thousands,x          ; ...stored for this hero
    inc hero_score_ten_thousands,x      ; ...and carry into the small ten-thousands digit
    lda hero_score_ten_thousands,x      ; ...and check the new digit
    cmp #spr_small_digit_9 + 1          ; Past 9?
    bne draw_ten_thousands              ; No: draw it under the score
    lda #spr_small_digit_9              ; Yes: it sticks at 9
    sta hero_score_ten_thousands,x      ; ...stored for this hero
; &041e referenced 2 times by &0417, &06c2
.draw_ten_thousands
    sta sprite_number                   ; Plot the ten-thousands digit under the score...
    lda #panel_left                     ; ...at the panel's left column
    sta plot_x                          ; ...as the plot column
    lda workspace_template + 208,x      ; ...hero_panel_y, read from workspace_template
    clc                                 ; ...(carry clear for the add)
    adc #&18                            ; ...+ &18: below the score's rows, &0C-&15
    sta plot_y                          ; ...as the plot row
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack while plotting
    jsr plot_sprite                     ; Plot the ten-thousands digit
    lda #spr_small_digit_8              ; ...then four small 0s after it: sprite &71...
    sta sprite_number                   ; ...(small 8, a solid bar, the shape of a small 0)
    ldy #4                              ; ...four of them, for the 0000
; &0437 referenced 1 time by &0443
.draw_ten_thousands_loop
    tya                                 ; Keep the count...
    pha                                 ; ...on the stack while plotting
    inc plot_x                          ; Two byte columns right...
    inc plot_x                          ; ...(second step)
    jsr plot_sprite                     ; Plot a 0 there
    pla                                 ; Recover the count...
    tay                                 ; ...into Y
    dey                                 ; One fewer 0 to plot
    bne draw_ten_thousands_loop         ; More 0s: loop
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
; in level_checksums, reset the machine, so a damaged or altered level file is never
; played. It runs once the level file is in memory. The pointer and the sum borrow the
; plotter's zero-page workspace (plot_x and plot_y, sprite_width).
;
; On Entry:
;     LEVEL_NUMBER: level loaded (1-25)
; &0450 referenced 2 times by &14f8, &c5a7
.decrypt_level
    ldy #0                              ; Point at &6B00, the start of the level...
    sty plot_x                          ; ...low byte 0, in plot_x (the pointer's low half)
    sty sprite_width                    ; Checksum 0, kept in sprite_width
    lda #>(level_object_x)              ; High byte &6B: the level buffer's page
    sta plot_y                          ; ...in plot_y (the pointer's high half)
; &045a referenced 2 times by &046f, &0475
.decrypt_level_loop
    lda (plot_x),y                      ; Fetch a level byte...
    eor plot_x                          ; ...XOR it with the low byte of its address...
    sta (plot_x),y                      ; ...and store it back decrypted
    clc                                 ; Add the decrypted byte to the checksum...
    adc sprite_width                    ; ...plus the sum so far
    sta sprite_width                    ; ...modulo 256
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
    ldx level_number                    ; X = the level just loaded (1-25)
    lda sprite_width                    ; Compare the checksum...
    cmp level_checksums,x               ; ...with this level's entry in the table
    beq decrypt_level_done              ; Match: the level is intact; return
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
; Called by new_game once the heroes are reset. Set a text window the full width of the
; screen (MODE 2's 20 columns) and clear it, print the menu and read keys. Keys 1-4
; toggle a hero between YES and NO by flipping hero_absent and rewriting the menu text; 5
; and 6 switch the sound on and off with OSBYTE &D2. SPACE returns, so the game starts,
; only if at least one hero is playing. Neither hero_absent nor the menu text is reset
; here.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &0500 referenced 1 time by &0e11
.hero_menu
    lda #&1c                            ; VDU 28: the menu's window, the screen's full width...
    jsr oswrch                          ; Send VDU 28
    lda #0                              ; Left column 0
    jsr oswrch                          ; Send the left column
    lda #&18                            ; Bottom row of the window
    jsr oswrch                          ; Send the bottom row
    lda #&13                            ; Right column 19, MODE 2's last
    jsr oswrch                          ; Send the right column
    lda #0                              ; Top row 0
    jsr oswrch                          ; Send the top row
    lda #&0c                            ; ...VDU 12 to clear it
    jsr oswrch                          ; Send VDU 12: clear the window
    jsr print_menu                      ; Print the menu
    jmp menu_key_loop                   ; Read keys until the players start the game
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
; Read one key and act on it, then come back for the next, until SPACE starts the game.
; &0581 referenced 6 times by &0521, &0598, &059c, &05c6, &05d3, &05f3
.menu_key_loop
    lda #osbyte_flush_buffer_class      ; Flush the input buffers
    jsr osbyte                          ; Discard any keys already waiting  Flush selected class of buffer
    lda #osbyte_kbd_status              ; OSBYTE &CA: set the keyboard lock states...
    ldx #&20 ; ' '                      ; X = &20: CAPS LOCK on, SHIFT LOCK off
    ldy #0                              ; Y = 0: replace the status with X
    jsr osbyte                          ; Set it, whatever the Ranger's lock keys left  osbyte: kbd status
    jsr osrdch                          ; Wait for a key
    cmp #' '                            ; SPACE?
    beq menu_space                      ; Yes: start, if anyone is playing
    cmp #'1'                            ; Ignore anything but 1-6
    bcc menu_key_loop                   ; Below '1': ignore it
    cmp #'7'                            ; Above '6'?
    bcs menu_key_loop                   ; Yes: ignore it
    sec                                 ; Subtract '1'...
    sbc #'1'                            ; ...so keys '1'-'6' become 0-5...
    tax                                 ; ...in X: a hero 0-3, or 4-5 for the sound
    cmp #4                              ; Key 5 or 6?
    bcs menu_sound_key                  ; Yes: the sound switch
    asl a                               ; 1-4: Y = offset of the hero's YES/NO, 6 x X + &51...
    sta plot_x                          ; Keep 2 x the hero number
    asl a                               ; 4 x the hero number...
    clc                                 ; ...(carry clear for the add)
    adc plot_x                          ; ...+ 2 x: 6 x the hero number
    adc #&51 ; 'Q'                      ; ...+ &51: this hero's YES/NO text
    tay                                 ; Y = its offset in menu_text
    lda hero_absent,x                   ; Toggle the hero between playing and absent...
    eor #1                              ; ...by flipping the absent flag
    sta hero_absent,x                   ; ...stored back
    bne menu_hero_off                   ; Now absent?
    jsr set_menu_yes                    ; No: playing, so YES
    jmp menu_reprint                    ; ...then reprint
; &05c0 referenced 1 time by &05b8
.menu_hero_off
    jsr set_menu_no                     ; Absent: NO
; &05c3 referenced 1 time by &05bd
.menu_reprint
    jsr print_menu                      ; Reprint the menu with the change
    jmp menu_key_loop                   ; Next key
; &05c9 referenced 1 time by &0594
.menu_space
    ldx #3                              ; SPACE: is any hero playing?
; &05cb referenced 1 time by &05d1
.menu_space_check_hero
    lda hero_absent,x                   ; Is this hero playing (absent flag 0)?
    beq menu_done                       ; Yes: return, and the game starts
    dex                                 ; Absent: try the previous hero
    bpl menu_space_check_hero           ; Heroes left to check: loop
    jmp menu_key_loop                   ; Nobody playing: ignore SPACE
; &05d6 referenced 1 time by &05ce
.menu_done
    rts                                 ; Return to new_game
; &05d7 referenced 1 time by &05a4
.menu_sound_key
    ldy #&99                            ; Sound: Y = offset of the second letter of ON/OFF
    cmp #5                              ; Key 6 (A = key - "1")?
    beq menu_sound_off                  ; Yes: sound off
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
    jsr print_menu                      ; Reprint the menu with the change
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
; Take the heroes nobody plays out of the level
;
; Called by level_loop after draw_status_panel. First redraw the small ten-thousands line
; under each score that has one, since start_level cleared the screen and
; draw_status_panel draws only the four large digits. Then take every hero switched off
; on the menu out of play: direction 0; step_out_of_play, so move_heroes passes over
; them; frame 8 and dead health, so that play_level treats them as dead with their death
; animation over, and level_loop counts them among the dead; and a nobody_returns entry
; in returning_hero_queue, which a Cross of Resurrection skips. Their panel section keeps
; the health and score just drawn.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &06b0 referenced 1 time by &0e5d
.remove_absent_heroes
    ldx #0                              ; Hero 0 first...
    ldy #0                              ; ...Y = the queue entry for the next absent hero
; &06b4 referenced 1 time by &06f3
.remove_absent_heroes_loop
    lda hero_score_ten_thousands,x      ; Score of 10000 or more?
    cmp #spr_small_digit_1              ; ...ten-thousands sprite small 1 or above?
    bcc remove_absent_heroes_check      ; No: nothing under the score; check absence
    txa                                 ; Yes: redraw it, lost when the screen was cleared
    pha                                 ; Keep the hero number...
    tya                                 ; ...and the queue entry...
    pha                                 ; ...on the stack
    lda hero_score_ten_thousands,x      ; The digit's sprite...
    jsr draw_ten_thousands              ; ...drawn under the score with its 0000
    pla                                 ; Recover the queue entry...
    tay                                 ; ...into Y
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
; Take the hero out of play if nobody is playing them.
; &06c9 referenced 1 time by &06b9
.remove_absent_heroes_check
    lda hero_absent,x                   ; Switched off on the menu?
    beq remove_absent_heroes_next       ; No: playing; next hero
    lda #0                              ; Yes: take them out of play...
    sta hero_direction,x                ; ...direction 0: not in play
    lda #step_out_of_play               ; ...step &63, so move_heroes passes them over...
    sta hero_step,x                     ; ...as the hero's step count
    lda #8                              ; ...frame 8: their death animation is over...
    sta hero_frame,x                    ; ...as the hero's frame
    lda #spr_digit_0 - 1                ; ...health tens below 0: dead...
    sta hero_health_tens,x              ; ...as the health tens digit
    dec hero_score_units,x              ; ...units back below 0, undoing the panel's point
    lda #&1f                            ; ...map x &1F, the dungeon's last column...
    sta hero_x,x                        ; ...as the hero's map x
    lda #nobody_returns                 ; ...and a nobody_returns entry in the queue...
    sta returning_hero_queue,y          ; ...which a Cross of Resurrection skips
    iny                                 ; The next absent hero takes the next entry
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
; Run with *RUN CODER (or from Coder2), once per game session: the game then stays
; resident and loads each level itself. Set the bell sound. Copy page &0D, which the MOS
; and the filing system use for their NMI code and workspace, to &C400 in private RAM:
; the game's per-level workspace lives in page &0D, so load_level puts the MOS's copy
; back before each level is loaded. *LOAD the four other game files, restore the display
; that *DUNJUNZ blanked, select COLOUR 2 and start a new game at &0E00. Page &0D is saved
; before any file is loaded, while it still holds the filing system's own contents.
.coder_start
    jsr set_bell                        ; BEL's sound, used by the game's VDU 7s
    ldx #0                              ; Save the MOS's page &0D...
; &0745 referenced 1 time by &074c
.save_page_0d_byte
    lda scratch,x                       ; ...each byte the filing system uses...
    sta saved_page_0d,x                 ; ...to &C400 in private RAM, for load_level
    dex                                 ; ...next byte (X wraps from 0)
    bne save_page_0d_byte               ; Until all 256 are saved
    ldx #<(load_dunj2_command)          ; *L. DUNJ2: heroes, monsters, views (&6E80-&7FFF)
    ldy #>(load_dunj2_command)          ; ...high byte of the command
    jsr oscli                           ; ...loaded
    ldx #<(load_dunj3_command)          ; *L. DUNJ3: hero attributes, room_walls (&08C0-&0CFE)
    ldy #>(load_dunj3_command)          ; ...high byte of the command
    jsr oscli                           ; ...loaded
    ldx #<(load_dunj4_command)          ; *L. DUNJ4: level loop to frame update (&0E00-&1FFF)
    ldy #>(load_dunj4_command)          ; ...high byte of the command
    jsr oscli                           ; ...loaded
    ldx #<(load_dunj5_command)          ; *L. DUNJ5: object_free_map, sprites (&2000-&2FFF)
    ldy #>(load_dunj5_command)          ; ...high byte of the command
    jsr oscli                           ; ...loaded
    ldx #0                              ; Show the display again: coder_display_vdu's 21 bytes
; &076c referenced 1 time by &0775
.send_coder_vdu
    lda coder_display_vdu,x             ; ...the next VDU byte...
    jsr oswrch                          ; ...to the VDU
    inx                                 ; ...on to the next
    cpx #coder_leftovers - coder_display_vdu  ; ...until all of coder_display_vdu is sent
    bne send_coder_vdu                  ; More to send
    jmp select_colour_2                 ; Over the leftovers to colour 2 and a new game
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
    jmp new_game                        ; ...and start a new game: the hero menu, then level 1
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
    ldx sprite_number                   ; X = sprite number, indexing the four sprite tables
; &0902 referenced 1 time by &c730
    lda sprite_addr_lo,x                ; Point sprite_data_ptr at the sprite's data...
    sta sprite_data_ptr                 ; ...low byte
    lda sprite_addr_hi,x                ; ...high byte from its own table
    sta sprite_data_ptr_hi              ; ...so sprite_data_ptr walks through the data
    lda sprite_widths,x                 ; Bytes in each sprite row...
    sta sprite_width                    ; ...counted across each row
    lda sprite_heights,x                ; Pixel rows in the sprite...
    sta sprite_height                   ; ...counted down the sprite
    jsr screen_address                  ; screen_ptr = address of the top-left byte
    ldy #0                              ; Index stays 0: the pointers themselves advance
    ldx sprite_height                   ; X counts the pixel rows still to plot
; &091d referenced 1 time by &0964
.plot_sprite_row
    lda screen_ptr                      ; Remember where this pixel row starts...
    sta row_start_ptr                   ; ...low byte
    lda screen_ptr_hi                   ; ...and high byte...
    sta row_start_ptr_hi                ; ...in row_start_ptr, to step down from later
    txa                                 ; Save the row count
    pha                                 ; ...on the stack: X now counts bytes
    ldx sprite_width                    ; X counts the bytes across this row
; &0929 referenced 1 time by &093f
.plot_sprite_byte
    lda (sprite_data_ptr),y             ; Copy one sprite byte...
    sta (screen_ptr),y                  ; ...to the screen, over whatever was there
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
    dex                                 ; One byte fewer left in this row
    bne plot_sprite_byte                ; More of the row: plot the next byte
    clc                                 ; screen_ptr = row start + 1: the next pixel row down
    lda row_start_ptr                   ; The row start's low byte...
    adc #1                              ; ...+ 1...
    sta screen_ptr                      ; ...is the new low byte
    lda row_start_ptr_hi                ; The row start's high byte...
    adc #0                              ; ...plus the carry...
    sta screen_ptr_hi                   ; ...is the new high byte
    lda screen_ptr                      ; Has it crossed into the next character row?
    and #7                              ; ...(pixel row within the character now 0)
    bne plot_sprite_next_row            ; No: still within the character row
    clc                                 ; Yes: add &278 more, to the top of the character...
    lda screen_ptr                      ; ...row below (row start + 1 + &278 = + 640 - 7)
    adc #&78 ; 'x'                      ; ...low byte + &78 (640 - 8 = &278)...
    sta screen_ptr                      ; ...stored
    lda screen_ptr_hi                   ; ...high byte...
    adc #2                              ; ...+ 2 and the carry...
    sta screen_ptr_hi                   ; ...stored
; &0961 referenced 1 time by &0952
.plot_sprite_next_row
    pla                                 ; Recover the row count
    tax                                 ; ...back into X
    dex                                 ; One pixel row fewer to plot
    bne plot_sprite_row                 ; More rows: plot the next
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
    lsr a                               ; ...plot_y / 2...
    lsr a                               ; ...plot_y / 4...
    and #&fe                            ; ...bit 0 cleared: the row's pair of table bytes
    tay                                 ; ...as the index into the MOS table
    lda row_offsets,y                   ; High byte of row x 640, from Table's copy in HAZEL...
    clc                                 ; ...(carry clear for the add)
    adc #>(screen_start)                ; ...plus &30: the screen starts at &3000
    sta screen_ptr_hi                   ; ...as the screen address high byte
    lda row_offsets_lo,y                ; Low byte of row x 640
    sta screen_ptr                      ; ...as the low byte
    lda plot_y                          ; Add the pixel row within the character...
    and #7                              ; ...plot_y MOD 8...
    adc screen_ptr                      ; ...(carry clear: adding &30 to the high byte cannot carry)
    sta screen_ptr                      ; ...stored in the low byte
    clc                                 ; Add 8 x plot_x: its high byte is plot_x DIV 32...
    lda plot_x                          ; ...from plot_x...
    and #&e0                            ; ...bits 7-5 kept...
    rol a                               ; ...four ROLs through the carry: bit 7 out...
    rol a                               ; ...bit 7 in at bit 0, bit 6 out
    rol a                               ; ...bits 7-6 at bits 1-0, bit 5 out
    rol a                               ; ...bits 7-5 now in bits 2-0
    clc                                 ; ...(carry clear for the add)
    adc screen_ptr_hi                   ; ...added to the high byte
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
    lda #0                              ; New game: no levels played yet...
    sta level_number                    ; ...level_number 0, counted up by show_level_number...
    sta level_bcd                       ; ...and level_bcd 0, counted up by level_loop
    tax                                 ; Give each hero their starting attributes and score
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
    lda level_number                    ; Monsters' hit points: 8 + 2 x levels already played...
    asl a                               ; ...x 2...
    clc                                 ; ...(carry clear for the add)
    adc #8                              ; ...+ 8...
    sta monster_start_hit_points        ; ...for every monster on this level
    sed                                 ; Count the level in decimal, for its filename...
    clc                                 ; ...(carry clear for the add)
    lda level_bcd                       ; ...the BCD count...
    adc #1                              ; ...+ 1...
    sta level_bcd                       ; ...stored
    cld                                 ; Back to binary arithmetic
    lda level_number                    ; Filename digits: two once 9 levels are played
    cmp #9                              ; ...(show_level_number counts level_number later)
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
    sta level_filename_digits,x         ; ...as the name's last digit
    cpx #0                              ; Two digits?
    beq end_level_filename              ; No: terminate the name
    lda level_bcd                       ; Yes: the tens digit...
    lsr a                               ; ...high nibble: first shift down...
    lsr a                               ; ...shifting the tens digit...
    lsr a                               ; ...down four bits...
    lsr a                               ; ...to the low nibble
    clc                                 ; ...as ASCII...
    adc #'0'                            ; ...+ '0'...
    sta level_filename_digits           ; ...as the name's first digit
; &0e52 referenced 1 time by &0e43
.end_level_filename
    lda #&0d                            ; Terminate the filename with a carriage return
    sta level_filename_digits + 1,x     ; ...after the last digit
    jsr start_level                     ; Load and draw the level
    jsr draw_status_panel               ; Draw every hero's panel section
    jsr remove_absent_heroes            ; Take out the heroes nobody plays
    lda #1                              ; Vsync count 1: play_level's first wait is two vsyncs
    sta os_vsync_counter                ; ...counted down at each vertical sync
    jsr play_level                      ; Play until no hero is left in play
; The level is over. Reset every hero who died, and end the game if all four did.
    ldx #0                              ; Count the dead, giving each their starting attributes
    stx count                           ; ...none dead so far
; &0e6d referenced 1 time by &0e7d
.check_hero_dead
    lda hero_health_tens,x              ; Dead (heroes nobody plays count as dead)?
    cmp #spr_digit_0 - 1                ; ...health tens one below 0?
    bne next_hero_dead                  ; No: survived, so not reset
    jsr reset_hero                      ; Yes: start them afresh on the next level
    inc count                           ; ...and count them
; &0e7a referenced 1 time by &0e72
.next_hero_dead
    inx                                 ; Next hero
    cpx #4                              ; All four checked?
    bne check_hero_dead                 ; No: next hero
    lda count                           ; Any hero survived?
    cmp #4                              ; ...fewer than four dead?
    bne level_loop                      ; Yes: on to the next level
    jsr game_over_music                 ; All dead: stop the music; VDU 28,0,24,16,0 on the left...
    nop                                 ; Padding
    nop                                 ; ...a second padding byte
    lda #0                              ; Left column 0
    jsr oswrch                          ; Send the left column
    lda #&18                            ; Bottom row 24
    jsr oswrch                          ; Send the bottom row
    lda #&10                            ; Right column 16, short of the status panel
    jsr oswrch                          ; Send the right column
    lda #0                              ; Top row 0
    jsr oswrch                          ; Send the top row
    lda #&0c                            ; ...VDU 12 to clear it
    jsr oswrch                          ; Send VDU 12: clear the window
    ldx #4                              ; Spaces over &0FF1-&0FF4, two of them the counters
    lda #&20 ; ' '                      ; ...a space
; &0ea8 referenced 1 time by &0eac
.restore_message_spaces
    sta panel_hero - 1,x                ; ...into each (&0FF1 held YOU ALL's full stop)
    dex                                 ; Next byte down
    bne restore_message_spaces          ; Until all four are spaces
; &0eae referenced 1 time by &0eb7
.print_game_over
    lda game_over_message,x             ; Print game_over_message...
    jsr osasci                          ; ...through OSASCI, so each CR starts a new line
    inx                                 ; Next character
    cmp #0                              ; ...up to its zero byte
    bne print_game_over                 ; Not the end: next
; &0eb9 referenced 1 time by &0ebc
.wait_vsync_game_over
    lda os_vsync_counter                ; Wait for the vsync counter, still running, to reach 0
    bne wait_vsync_game_over            ; Not yet: keep waiting
    lda #osbyte_flush_buffer_class      ; Flush the input buffers
    jsr osbyte                          ; Discard keys pressed during play  Flush selected class of buffer
    ldx #&f4                            ; Game over: wait up to &1F4 cs (5 s) for a key...
    ldy #1                              ; ...Y = &01: the time limit's high byte
    lda #osbyte_inkey                   ; OSBYTE &81: read a key within that time
    jsr osbyte                          ; A key, or the time running out, ends the message  Read a key, waiting up to 500 centiseconds
    jmp new_game                        ; ...then start a new game
; ***************************************************************************************
; Give a hero their starting attributes
;
; Set hero X's missile limit, missile damage and damage taken from the starting tables,
; and their score to zero with no ten-thousands digit. new_game calls it for every hero,
; and level_loop for each hero who died (or was not playing) when a level ends, so
; survivors keep their scores, missile limits, missile damage and armour. The units digit
; is set one below 0 because draw_status_panel draws the score by adding a point.
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
    lda #spr_digit_0                    ; Score 0000...
    sta hero_score_thousands,x          ; ...thousands...
    sta hero_score_hundreds,x           ; ...hundreds...
    sta hero_score_tens,x               ; ...tens...
    lda #spr_digit_0 - 1                ; ...units one below 0: draw_status_panel adds a point
    sta hero_score_units,x              ; ...as the units digit
    lda #spr_small_digit_1 - 1          ; No ten-thousands digit (&69, one below small 1)
    sta hero_score_ten_thousands,x      ; ...as the ten-thousands digit
    rts                                 ; Return
; ***************************************************************************************
; Draw the status panel
;
; Draw each hero's section of the status panel to the right of the views, after
; start_level has cleared the screen. The health and score are drawn by taking a health
; point and adding a score point: the health comes from the workspace template as 99 + 1,
; so it is 99 at the start of every level, and a hero just reset has a score one below
; 0000. A hero who survived the last level keeps their score, so gains a point here at
; every new level. Above the health go the face and the shield with the armour rating on
; it, and the missile damage; beside the health, one icon per missile allowed in flight.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &0ef7 referenced 1 time by &0e5a
.draw_status_panel
    lda #0                              ; For each hero's section...
    sta panel_hero                      ; ...starting with the Ranger's, at the top
; &0efc referenced 1 time by &0f65
.draw_panel_hero
    ldx panel_hero                      ; X = this hero
    jsr lose_health_point               ; Take a point from the template's 99 + 1: draws 99
    jsr add_point                       ; Add a point: draws the score (0000 if just reset)
    lda hero_faces,x                    ; The hero's face (their facing-down sprite)...
    ldx #panel_left                     ; ...at column &45, the panel's left...
    ldy #0                              ; ...on the section's top row...
    jsr plot_panel_sprite               ; ...plotted
    ldx #panel_left + 8                 ; Shield at column &4D, the section's top right
    ldy #0                              ; ...on the top row...
    lda #spr_shield                     ; ...the shield sprite...
    jsr plot_panel_sprite               ; ...plotted
    ldx panel_hero                      ; Armour rating on the shield: 10 - health lost per hit
    sec                                 ; ...(no borrow into the subtract)
    lda #spr_small_digit_1 + 9          ; ...from &73, small digit 1 + 9...
    sbc hero_damage_taken,x             ; ...less the damage per hit
    ldx #panel_left + 9                 ; ...at column &4E...
    ldy #2                              ; ...row 2...
    jsr plot_panel_sprite               ; ...plotted on the shield
    ldx panel_hero                      ; Missile icons, one per missile allowed in flight...
    lda hero_max_missiles,x             ; ...missile limit...
    asl a                               ; ...x 2...
    clc                                 ; ...(carry clear for the add)
    adc hero_max_missiles,x             ; ...+ limit: 3 rows per icon...
    adc #&10                            ; ...+ &10: the row after the last icon
    sta count                           ; ...(end row in count)
    ldy #&10                            ; ...first icon at row &10, beside the health
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
    ldx panel_hero                      ; Missile damage as a small digit, above the icons
    lda hero_missile_damage,x           ; ...the hero's missile damage...
    clc                                 ; ...(carry clear for the add)
    adc #spr_small_digit_1 - 1          ; ...+ &69: small digit 1 for damage 1
    ldx #panel_left + 7                 ; ...at column &4C...
    ldy #&0a                            ; ...row &0A...
    jsr plot_panel_sprite               ; ...plotted
    inc panel_hero                      ; Next hero's section
    lda panel_hero                      ; All four heroes drawn?
    cmp #4                              ; ...(four of them)
    bne draw_panel_hero                 ; No: the next hero
    rts                                 ; Return
; ***************************************************************************************
; Plot a sprite in a hero's panel section
;
; Plot sprite A at byte column X and pixel row Y + hero_panel_y - 14 for the hero being
; drawn (draw_status_panel's loop counter). Row 0 of a section is thus 14 rows above the
; health digits. The panel row is read from workspace_template, whose copy in page &0D is
; hero_panel_y.
;
; On Entry:
;     A: sprite number
;     X: byte column
;     Y: row within the hero's panel section
; &0f68 referenced 5 times by &0f0c, &0f15, &0f25, &0f40, &0f5a
.plot_panel_sprite
    stx plot_x                          ; Byte column from X
    sta sprite_number                   ; Sprite from A
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
; Called by play_level at the start of every frame. On level 25, if any hero's
; hero_door_x, hero_door_y (the cell they last stepped or tried to step into, kept even
; when a wall stops them) is one of the Chalice's four cells, x &1A-&1B and y 4-5, the
; game is won: play the victory sequence, print the ending text over the views, wait for
; a key and reset the machine through the RESET vector, so this never returns. The text
; is not part of the program: it is the 140 bytes at room_walls + &3A followed by the
; zero-terminated string at object_free_map + &3A, which on level 25 hold the ending text
; instead of map data. Otherwise return at once.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: preserved
; &1070 referenced 1 time by &1f0a
.check_for_victory
    lda level_number                    ; Which level is this?
    cmp #last_level                     ; The Chalice lies only on level 25
    bne no_victory                      ; Another level: no Chalice to find
    ldx #0                              ; Has a hero reached a Chalice cell, x &1A-&1B, y 4-5?
; &1079 referenced 1 time by &1087
.check_door_x
    lda hero_door_x,x                   ; The cell hero X last stepped or bumped into...
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
    rts                                 ; No hero at the Chalice: on with the frame
; &108a referenced 2 times by &107e, &1082
.check_door_y
    lda hero_door_y,x                   ; ...and that cell's row...
    cmp #chalice_y                      ; ...in the Chalice's top row?
    beq start_victory                   ; Yes: the Chalice is found
    cmp #chalice_y + 1                  ; ...or its bottom row?
    beq start_victory                   ; Yes: the Chalice is found
    bne next_hero_victory               ; No: next hero
; &1097 referenced 2 times by &108f, &1093
.start_victory
    jsr victory_sequence                ; Sparkles, rising tone, the Chalice dissolves
; The game is won. Over the views, print the ending text that level 25's maps hold, wait for a key, and reset.
    lda #&1c                            ; VDU 28,0,24,16,0: a window over the four views...
    jsr oswrch                          ; Send VDU 28
    lda #0                              ; Left column 0
    jsr oswrch                          ; Send the left column
    lda #&18                            ; Bottom row 24, the last on show
    jsr oswrch                          ; Send the bottom row
    lda #&10                            ; Right column 16: the status panel stays
    jsr oswrch                          ; Send the right column
    lda #0                              ; Top row 0
    jsr oswrch                          ; Send the top row
    lda #&0c                            ; ...VDU 12 to clear it
    jsr oswrch                          ; Clear the views for the ending text
    ldx #0                              ; The ending text: 140 bytes from room_walls + &3A...
; &10ba referenced 1 time by &10c3
.print_victory_text
    lda room_walls + 58,x               ; Next byte of level 25's wall map, which is text
    jsr osasci                          ; Print it in the game's font
    inx                                 ; Next byte
    cpx #&8c                            ; All 140 printed?
    bne print_victory_text              ; No: print the next
    ldx #0                              ; ...then the ending message, at object_free_map + &3A
; &10c7 referenced 1 time by &10d0
.print_ending_message
    lda object_free_map + 58,x          ; Next character of the ending message
    jsr osasci                          ; Print it, the zero included
    inx                                 ; Next character
    cmp #0                              ; The zero that ends the message?
    bne print_ending_message            ; No: print the next
    lda #osbyte_flush_buffer_class      ; OSBYTE &0F, X non-zero: flush the input buffer...
    jsr osbyte                          ; ...so keys pressed in the sequence cannot skip the text  Flush selected class of buffer
    jsr osrdch                          ; Wait for a key once the ending text has been read
    lda reset_vector                    ; Copy the RESET vector into the JSR below...
    sta reset_call_address              ; ...low byte
    lda reset_vector + 1                ; ...high byte...
    sta reset_call_address + 1          ; ...into the JSR's operand
.reset_call
; &10e7 referenced 1 time by &10dd
reset_call_address = reset_call+1
; &10e8 referenced 1 time by &10e3
    jsr &00                             ; ...and call it: the game ends with a reset
; ***************************************************************************************
; Play the victory sequence
;
; Called by check_for_victory once a hero reaches the Chalice. Each pass sounds the bell,
; draws the ring of sparkles round the Chalice, and waits. The bell's pitch climbs by a
; step each pass and wraps past 255, and each time it wraps the step grows by 1, so the
; tone repeats as ever faster sweeps. The wait starts at &E6 units of about 1,280 cycles
; each and shortens by one a pass down to 1; from then on each pass also clears one
; random byte of the Chalice. After the 50th wrap, erase the ring, blank the Chalice and
; wait 255 vertical syncs. OSBYTEs &D4 and &D5 set (old AND Y) EOR X, and Y is never set
; for them: the bell's envelope byte takes Y left over from the frame, and the first
; pitch takes the Y that OSBYTE &D4 returns; later passes have Y = 0 from the wait loop,
; so the pitch is exactly victory_pitch.
;
; On Exit:
;     A: 0
;     X: corrupted
;     Y: corrupted
; &10e9 referenced 1 time by &1097
.victory_sequence
    lda #osbyte_bell_envelope           ; OSBYTE &D4: the bell's envelope byte...
    ldx #8                              ; ...EOR 8; Y, not set, is the AND mask
    jsr osbyte                          ; Set the bell's envelope for the victory tone  osbyte: bell envelope
    lda #0                              ; No pixel offsets
    sta plot_offset_x                   ; ...across...
    sta plot_offset_y                   ; ...or down, so sprites sit square in their cells
    lda #spr_sparkle_0                  ; The ring starts with the first sparkle
    sta victory_sprite                  ; ...as the ring's sprite
    lda #0                              ; Tone starts at pitch 0...
    sta victory_pitch                   ; ...for the bell
    lda #&e6                            ; ...with the passes &E6 wait units apart...
    sta victory_delay                   ; ...the delay loop's outer count
    lda #&32 ; '2'                      ; ...for &32 (50) sweeps of the pitch...
    sta victory_steps_left              ; ...counted down as the pitch wraps
    lda #1                              ; ...rising by 1 a pass in the first sweep
    sta victory_pitch_step              ; ...the pitch's first step
; One pass of the sequence: raise the pitch, shorten the wait, sound the bell, draw the ring, dissolve a byte of the Chalice once at full speed, and wait.
; &110a referenced 1 time by &1146
.raise_victory_pitch
    clc                                 ; Start a pass: raise the bell's pitch
    lda victory_pitch                   ; ...current pitch...
    adc victory_pitch_step              ; ...plus the step...
    sta victory_pitch                   ; ...becomes the new pitch, wrapping past 255
    bcc shorten_victory_delay           ; No wrap: the sweep goes on
    inc victory_pitch_step              ; Wrapped: the next sweep climbs one step faster...
    dec victory_steps_left              ; ...and one fewer sweep is left
    bne shorten_victory_delay           ; Sweeps left: go on
    jmp erase_victory_ring              ; 50 sweeps done: erase the ring and the Chalice
; &111c referenced 2 times by &1111, &1117
.shorten_victory_delay
    dec victory_delay                   ; Shorten the wait: the passes come faster...
    bne sound_victory_bell              ; Not yet zero: keep it
    lda #1                              ; ...but never below 1...
    sta victory_delay                   ; ...the full speed the rest of the sequence runs at
; &1124 referenced 1 time by &111e
.sound_victory_bell
    ldx victory_pitch                   ; OSBYTE &D5: the bell's pitch...
    lda #osbyte_bell_frequency          ; ...set it from victory_pitch
    jsr osbyte                          ; Set it: the bell now sounds at that pitch  osbyte: bell frequency
    lda #7                              ; ...and sound the bell
    jsr oswrch                          ; Send BEL: the bell sounds at the new pitch
    jsr draw_victory_ring               ; Draw the ring, the sparkles one side further round
    lda victory_delay                   ; At full speed, dissolve the Chalice a byte at a time
    cmp #1                              ; Delay down to 1: the sequence is at full speed
    bne victory_delay_loop              ; Not yet: just wait
    jsr dissolve_chalice                ; Full speed: clear one more byte of the Chalice
; &113c referenced 1 time by &1137
.victory_delay_loop
    ldx victory_delay                   ; Wait victory_delay units before the next pass
; &113e referenced 1 time by &1144
.victory_delay_outer
    ldy #&ff                            ; Each unit is 255 inner loops, about 1,280 cycles
; &1140 referenced 1 time by &1141
.victory_delay_inner
    dey                                 ; Count down the inner loop
    bne victory_delay_inner             ; Until it reaches zero
    dex                                 ; Count down the delay units
    bne victory_delay_outer             ; Until the delay is spent (Y = 0 for the next OSBYTE)
    jmp raise_victory_pitch             ; Next pass
; ***************************************************************************************
; Draw the ring of sprites round the Chalice
;
; Plot victory_sprite at the twelve cells round the Chalice's 2 x 2 block, from x &1C, y
; 3 leftwards along the top, down the left side, along the bottom and up the right side,
; three cells to a side. The sprite moves on to the next sparkle (next_victory_sprite)
; after each of the first three sides and is left at the fourth side's, so the next ring
; starts with it and the sparkles move one side round the ring each pass. With the blank
; sprite, it erases the ring.
;
; On Entry:
;     VICTORY_SPRITE: the sprite for the top side
;
; On Exit:
;     VICTORY_SPRITE: the sprite of the right side
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &1149 referenced 2 times by &1130, &11d7
.draw_victory_ring
    lda #chalice_x + 2                  ; Start at x &1C, y 3: the ring runs round the Chalice's four cells
    sta ring_x                          ; ...as the ring's x...
    lda #chalice_y - 1                  ; ...one row above the Chalice...
    sta ring_y                          ; ...as the ring's y
    jsr plot_victory_sprite             ; Plot the top-right corner, first of the top side
    dec ring_x                          ; Left...
    jsr plot_victory_sprite             ; Plot the next cell along the top
    dec ring_x                          ; Left...
    jsr plot_victory_sprite             ; Plot the last of the top side's three
    lda victory_sprite                  ; Keep the sprite...
    sta victory_sprite_copy             ; ...in victory_sprite_copy, which nothing reads
    jsr next_victory_sprite             ; ...and move to the next sparkle for the left side
    dec ring_x                          ; Left...
    jsr plot_victory_sprite             ; Plot the top-left corner
    inc ring_y                          ; Down...
    jsr plot_victory_sprite             ; Plot down the left side
    inc ring_y                          ; Down...
    jsr plot_victory_sprite             ; Plot down the left side
    jsr next_victory_sprite             ; Next sparkle for the bottom side
    inc ring_y                          ; Down...
    jsr plot_victory_sprite             ; Plot the bottom-left corner
    inc ring_x                          ; Right...
    jsr plot_victory_sprite             ; Plot along the bottom
    inc ring_x                          ; Right...
    jsr plot_victory_sprite             ; Plot along the bottom
    jsr next_victory_sprite             ; Next sparkle for the right side, kept for the next ring
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
; Plot victory_sprite at the cell ring_x, ring_y in every view showing it, with the pixel
; offsets victory_sequence cleared.
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
; Step victory_sprite through the four sparkles, &16-&19, wrapping back to &16. The blank
; sprite, &15, used to erase the ring, is left alone.
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
; Make a random number from the System VIA's timer 1 low byte mixed with two bytes of MOS
; workspace. If it is below &C0, the size of the Chalice's 8 x 24-byte sprite, zero that
; byte of sprite_chalice and replot the Chalice, so it dissolves into black a pixel pair
; at a time; otherwise do nothing this pass.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &11be referenced 1 time by &1139
.dissolve_chalice
    lda system_via_t1c_l                ; Pick a byte of the Chalice: System VIA timer 1...
    eor os_irq_a                        ; ...mixed with the MOS's last interrupt A...
    eor os_zp_fa                        ; ...and more MOS workspace, for randomness
    cmp #&c0                            ; Within the Chalice's &C0 bytes?
    bcs dissolve_done                   ; No: nothing dissolves this pass
    tax                                 ; Clear it...
    lda #0                              ; ...to zero, a black pair of pixels...
    sta sprite_chalice,x                ; ...in the Chalice's sprite data
    jsr plot_chalice                    ; ...and replot the Chalice with the hole in it
; &11d2 referenced 1 time by &11c7
.dissolve_done
    rts                                 ; Return
; &11d3 referenced 1 time by &1119
.erase_victory_ring
    lda #spr_blank                      ; Erase the ring
    sta victory_sprite                  ; ...by making the blank the ring's sprite...
    jsr draw_victory_ring               ; ...and drawing the ring with it
    ldx #&c1                            ; Clear what is left of the Chalice...
    lda #0                              ; ...to zeros
; &11de referenced 1 time by &11e2
.clear_chalice_sprite
    sta sprite_chalice - 1,x            ; Clear a byte of the Chalice's sprite data
    dex                                 ; Next byte down
    bne clear_chalice_sprite            ; &C1 bytes: the &C0 and the unused byte after
    jsr plot_chalice                    ; ...and replot it, now black: the Chalice is gone
    lda #&ff                            ; Pause 255 vertical syncs (about five seconds)
    sta os_vsync_counter                ; ...which the MOS counts down at each vsync
; &11ec referenced 1 time by &11ef
.wait_vsync_chalice
    lda os_vsync_counter                ; Read the count
    bne wait_vsync_chalice              ; Until it reaches zero
    rts                                 ; Return to check_for_victory for the ending text
; ***************************************************************************************
; Plot the Chalice
;
; Plot sprite &73, the Chalice, at its top-left cell (x &1A, y 4) in every view showing
; it. The sprite is two cells wide and two high, so it covers the four cells
; check_for_victory tests.
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
    lda #spr_chalice                    ; ...sprite &73, 2 x 2 cells...
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
; Called by level_loop for every level. Stop the music, which plays on the interval timer
; event, until the level is drawn; after the first level its place (rhythm step,
; transposition, section and tune_ptr) is kept on the stack. Count the level, put the
; MOS's page &0D back and load the level, unpack it, reset the workspace and monsters,
; clear the text area, show 25 rows, and draw the view frames and views. Then restart the
; music: start_music always plays the tune's first step, after which the saved place, if
; any, is put back, so that the tune carries on from where the last level left it.
; first_level_flag tells the two cases apart.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &1400 referenced 1 time by &0e57
.start_level
    lda first_level_flag                ; First level of the session?
    cmp #&7b ; '{'                      ; ...&7B once the first level is done
    bne stop_music_and_load             ; Yes: no music playing to save
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
    jsr stop_music                      ; Silence the music while the level loads
    jsr count_level                     ; Clear the text area and count the level
    jsr load_level                      ; Put the MOS's page &0D back and load the level
    jsr unpack_level                    ; Copy it into the game's tables
    jsr reset_workspace                 ; Page &0D back to the game's workspace
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
    jsr start_music                     ; Start the music from the top (plays its first step)
    lda first_level_flag                ; First level of the session?
    cmp #&7b ; '{'                      ; ...&7B once the first level is done
    bne mark_first_level_done           ; Yes: nothing saved; the tune plays from the top
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
    lda #&7b ; '{'                      ; Mark the first level done...
    sta first_level_flag                ; ...so later levels, and later games, keep the music's place
    rts                                 ; Return
; ***************************************************************************************
; Put the MOS's page &0D back and load the level
;
; Copy the MOS's page &0D back from &C400 (Coder saved it there), over the game's
; workspace, so that the filing system's NMI code and workspace are intact for the load;
; reset_workspace gives the page back to the game afterwards. Write level_bcd's digits
; into level_command, show only 15 character rows, so that the level file arriving at
; &6B00 (rows 23-24 of the screen) is not seen, and *LOAD LEVELnn 6B00 (level 25 comes
; from Stones, via load_stones in Table). Then decrypt and check it.
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
    lda level_bcd                       ; Level 10 or more? (level_bcd &01-&09 or &10-&25)
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
    jsr oswrch                          ; ...hiding rows 15-24, where &6B00 lies
    lda #0                              ; ...then six zeros to finish the command
    jsr oswrch                          ; ...zero 1 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 2 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 3 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 4 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 5 of 6 ending the VDU 23
    jsr oswrch                          ; ...zero 6 of 6: the VDU 23 is complete
    lda level_number                    ; Level 25, the last, with no file of its own?
    cmp #&19                            ; ...level_number &19 (counted by count_level)?
    bne load_level_file                 ; No: load its LEVELnn file
    jmp load_stones                     ; Yes: load it from Stones (and check it there)
; &14f1 referenced 1 time by &14ec
.load_level_file
    ldx #<(level_command)               ; No: *LOAD LEVELnn 6B00
    ldy #>(level_command)               ; ...high byte of the command
    jsr oscli                           ; ...the level file to &6B00, for decrypt_level
    jmp decrypt_level                   ; Decrypt and check it, and return from there
.level_command
; &1505 referenced 2 times by &14a2, &14b1
level_command_digits = level_command+10
; &1506 referenced 2 times by &1497, &14bc
    equs "LOAD LEVEL11 6B00", &0d
; ***************************************************************************************
; Reset the game workspace for a new level
;
; Called by start_level. Copy the 256 bytes of workspace_template over page &0D, which
; puts the heroes, missiles and views back to their starting state, then reset the exit
; animation's state: no hero going down the exit or shrunk, the shrinking hero's pixel
; offsets (x 1, 1, 0, 0 and y 5, 3, 1, 0 for exit_shrinks_left 1-4), and trapdoor 0 as
; the next one a monster comes out of.
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
    bne copy_workspace_template         ; Until all 256 are copied: heroes back at the start
    lda #0                              ; Reset the exit animation and the trapdoor turn
    sta exit_busy                       ; No hero is going down the exit
    sta exit_offset_x_3                 ; Shrinking hero's x offset at shrink 3: 0...
    sta exit_offsets_y                  ; ...at shrink 4 (exit_offsets_y doubles as x 4)...
    sta exit_offset_y_4                 ; ...and the y offset at shrink 4
    sta next_trapdoor                   ; First monster emerges from trapdoor 0
    lda #1                              ; Offsets of 1 for the exit animation
    sta exit_offset_x_1                 ; ...x offset at shrink 1...
    sta exit_offset_x_2                 ; ...x offset at shrink 2...
    sta exit_offset_y_3                 ; ...and y offset at shrink 3
    lda #&ff                            ; &FF: no hero is shrunk
    sta shrunk_hero                     ; ...so no hero's sprites need restoring
    lda #5                              ; Shrinking hero's y offset at shrink 1: 5...
    sta exit_offset_y_1                 ; ...for y offset 1
    lda #3                              ; ...and at shrink 2: 3
    sta exit_offset_y_2                 ; ...for y offset 2
    rts                                 ; Return to start_level
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
    ldx #&14                            ; Twenty PLOT commands: five for each view's frame
; &1546 referenced 1 time by &1561
.draw_view_frame
    lda #&19                            ; VDU 25...
    jsr oswrch                          ; Send VDU 25: a PLOT command follows
    ldy #0                              ; ...then the five bytes of the command
; &154d referenced 1 time by &1555
.send_frame_vdu
    lda (plot_x),y                      ; Next byte of this PLOT: K, then X and Y
    jsr oswrch                          ; Send it to the VDU drivers
    iny                                 ; Next byte
    cpy #5                              ; All five sent?
    bne send_frame_vdu                  ; No: send the next
    clc                                 ; Next command
    lda plot_x                          ; ...pointer...
    adc #5                              ; ...moves on five bytes...
    sta plot_x                          ; ...to the next PLOT (the table is all in one page)
    ldy #0                              ; Start the next PLOT at its first byte
    dex                                 ; Count the PLOT done
    bne draw_view_frame                 ; Until all twenty are drawn
    jsr draw_all_views                  ; Draw each hero's room inside their frame
    lda #<(wrch_handler)                ; Point WRCHV at &7F8F...
    sta wrchv                           ; ...low byte...
    lda #>(wrch_handler)                ; ...high byte...
    sta wrchv + 1                       ; ...the WRCHV entry again, for text
    rts                                 ; Return
; ***************************************************************************************
; Copy the loaded level into the game's tables
;
; Called by start_level once the level file at &6B00 has been decrypted and checked. Copy
; objects 1-30 (position and type), doors 1-20 (position and sprite), keys 1-20,
; trapdoors 0-7, &C9 bytes each of the wall map (into room_walls) and object-free map,
; and the level's 4 x 12 wall block into sprite 0. Entry 0 of the object, door and key
; tables is not touched. room_walls is also character 128's definition, which the game's
; text output overwrites, so this must follow the printing of the level number.
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
    lda level_object_type,x             ; Its type, which is also its sprite...
    sta object_type,x                   ; ...becomes its object type
    dex                                 ; Next object down
    bne unpack_objects                  ; Until object 1 is done (entry 0 is unused)
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
    ldx #0                              ; Trapdoors 0 to 7: where dead monsters come back
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
    sta room_walls,x                    ; ...into room_walls, which test_wall reads
    lda level_object_free_map,x         ; Byte of the level's object-free map...
    sta object_free_map,x               ; ...into object_free_map, which test_object_free reads
    inx                                 ; Next byte
    cpx #map_bytes                      ; Both maps copied?
    bne unpack_walls                    ; No: copy the next
    ldx #0                              ; The level's own wall block, &30 bytes
; &15d8 referenced 1 time by &15e1
.unpack_wall_sprite
    lda level_wall_sprite,x             ; Byte of the level's wall block...
    sta wall_sprite,x                   ; ...becomes sprite 0, the wall in every room
    inx                                 ; Next byte
    cpx #&30 ; '0'                      ; All 4 x 12 bytes copied?
    bne unpack_wall_sprite              ; No: copy the next
    rts                                 ; Return
; ***************************************************************************************
; Clear the monsters for a new level
;
; Called by start_level. Give monsters 1-30 the blank sprite (the first stage of dying)
; off the map, so each comes out of a trapdoor in turn, with this level's starting hit
; points. Then, for each of the four heroes, clear their returning_hero_queue entry, the
; key they carry and swapped, and the cell kept for the door checks.
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
    ldx #0                              ; Each hero: clear queue place, key carried, door cell
    lda #0                              ; Zero for every entry cleared
; &15fd referenced 1 time by &160f
.clear_hero_carrying
    sta returning_hero_queue,x          ; Queue entry X empty: nobody waits to return
    sta hero_key,x                      ; Hero X carries no key
    sta hero_key_dropped,x              ; ...and has swapped none
    sta hero_door_x,x                   ; No door-check cell...
    sta hero_door_y,x                   ; ...in x or y
    inx                                 ; Next hero
    cpx #4                              ; All four done?
    bne clear_hero_carrying             ; No: clear the next
    rts                                 ; Return to start_level
; ***************************************************************************************
; Clear the text area and count the level
;
; start_level's first call after the music stops. Count the level in level_number (1-25),
; which picks the level's checksum, Stones for level 25 and the Chalice. No level number
; is shown.
;
; On Exit:
;     A: corrupted
;     X: preserved
;     Y: preserved
; &1612 referenced 1 time by &141c
.count_level
    jsr clear_text_area                 ; Clear the text area
    inc level_number                    ; level_number + 1: the level about to load
    rts                                 ; Return
; ***************************************************************************************
; Clear the screen
;
; Set a text window the full 20 columns wide, from row 0 to the bottom row, and clear it
; with VDU 12. The window is left set.
;
; On Exit:
;     A: corrupted
;     X: preserved
;     Y: preserved
; &1619 referenced 2 times by &142b, &1612
.clear_text_area
    lda #&1c                            ; VDU 28: a text window over the whole screen...
    jsr oswrch                          ; Send VDU 28
    lda #0                              ; Left column 0
    jsr oswrch                          ; Send the left column
    lda #&18                            ; Bottom row of the window (24 in play)
    jsr oswrch                          ; Send the bottom row
    lda #&13                            ; Right column 19: the full MODE 2 width
    jsr oswrch                          ; Send the right column
.set_text_window_top
; &162e referenced 1 time by &c60a
clear_text_area_top = set_text_window_top+1
    lda #0                              ; Top row 0
    jsr oswrch                          ; Send the top row
    lda #&0c                            ; ...VDU 12 to clear it
    jsr oswrch                          ; Send it: the window clears to the background
    rts                                 ; Return
; &1638 referenced 3 times by &1400, &1464, &147f
.first_level_flag
    equb &ea
    equb &60                            ; Not referenced
; ***************************************************************************************
; View frame PLOT commands
;
; Twenty five-byte VDU 25 commands (plot code, then x and y as 16-bit words) sent by
; draw_view_frames, five for each view's frame: PLOT 4 moves to the top-left corner,
; three PLOT 1s draw relative lines down 388, right 520 and up 388, and PLOT 5 draws back
; to the corner. The corners are (8,1022), (552,1022), (8,614) and (552,614); the second
; frame's first line is 389 long.
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
; Called by hero_enters_exit. Define exit_envelope and play exit_sound, then put a &64
; (nobody_returns) entry in the first empty (zero) entry of returning_hero_queue, as
; remove_absent_heroes does for each hero nobody plays. At most four entries are ever in
; use, so an empty one is always found.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &16a0 referenced 1 time by &203d
.queue_exit_marker
    ldx #<(exit_envelope)               ; Define the exit envelope...
    ldy #>(exit_envelope)               ; ...high byte
    lda #osword_envelope                ; ...OSWORD 8: ENVELOPE...
    jsr osword                          ; ENVELOPE command
    ldx #<(exit_sound)                  ; ...and play the exit sound
    ldy #>(exit_sound)                  ; ...high byte
    lda #osword_sound                   ; ...OSWORD 7: SOUND...
    jsr osword                          ; SOUND command
    ldx #0                              ; Append a marker to returning_hero_queue...
; &16b4 referenced 1 time by &16c0
.find_queue_end
    lda returning_hero_queue,x          ; Entry X of the queue
    bne next_queue_entry                ; In use: try the next
    lda #nobody_returns                 ; Empty: add a &64 marker there
    sta returning_hero_queue,x          ; ...in the first empty entry, behind those waiting
    rts                                 ; Return to hero_enters_exit
; &16bf referenced 1 time by &16b7
.next_queue_entry
    inx                                 ; Next entry
    bne find_queue_end                  ; Keep looking (at most four entries are in use)
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
; Called by play_level each frame, after check_for_victory. Move the heroes; then, for
; each hero, look for a door at the cell they last stepped or tried to step into
; (hero_door_x, hero_door_y): if they carry that door's key, the door opens, the hero
; scores 7 and the key is used up. Then draw the keys, pick up and swap keys, draw the
; objects, move the missiles and the monsters, and handle the pause key.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &1cc0 referenced 1 time by &1f0d
.update_game
    jsr move_heroes                     ; Move the heroes: steps, shots, magic, pick-ups
    ldx #0                              ; For each hero, 0-3...
; &1cc5 referenced 1 time by &1dbf
.check_doors
    stx scratch                         ; ...hero number in scratch, for the door's points
    lda hero_door_x,x                   ; The cell hero X last stepped or bumped into...
    sta cell_x                          ; ...is the cell to test
    lda hero_door_y,x                   ; ...and its y...
    sta cell_y                          ; ...is the cell's y
    txa                                 ; Keep the hero's number...
    pha                                 ; ...on the stack for the key check
    ldx #max_door                       ; Doors 20 to 1: is one in that cell?
; &1cd8 referenced 1 time by &1db5
.check_door
    lda door_x,x                        ; This door's x (&FF once opened)...
    cmp cell_x                          ; ...the cell being tested?
    beq check_door_cell_y               ; Yes: check its y
    jmp next_door                       ; No: next door
; &1ce3 referenced 1 time by &1cde
.check_door_cell_y
    lda door_y,x                        ; ...and y?
    cmp cell_y                          ; ...the cell being tested?
    beq check_door_key                  ; Yes: the hero has walked into this door
    jmp next_door                       ; No: next door
; &1cee referenced 1 time by &1ce9
.check_door_key
    pla                                 ; Does the hero carry this door's key?
    tay                                 ; Y = the hero's number...
    pha                                 ; ...kept on the stack
    txa                                 ; A = the door's number: key n opens door n
    cmp hero_key,y                      ; Is it the number of the key the hero carries?
    beq open_door                       ; Yes: open door
    jmp next_door                       ; No key, or the wrong one: the door stays shut
; &1cfa referenced 1 time by &1cf5
.open_door
    txa                                 ; Open the door: 7 points...
    pha                                 ; Keep the door's number...
    tya                                 ; ...and the hero's...
    pha                                 ; ...on the stack
    ldy #7                              ; Seven points, one per add_point call
    ldx scratch                         ; ...X = the hero who opened the door, for add_point
; &1d03 referenced 1 time by &1d0b
.door_points_loop
    tya                                 ; Keep the count of points still to give
    pha                                 ; ...on the stack, as add_point uses Y
    jsr add_point                       ; One point to the hero's score, redrawn
    pla                                 ; Recover the count of points to give
    tay                                 ; ...back into Y
    dey                                 ; One fewer to give
    bne door_points_loop                ; More to give: add the next point
    lda #&96                            ; The door sound is the food sound, lower...
    sta food_sound + 4                  ; ...pitch 150 instead of food's 200
    ldx #<(food_sound)                  ; SOUND food_sound: block address low...
    ldy #>(food_sound)                  ; ...and high
    lda #osword_sound                   ; OSWORD 7: SOUND
    jsr osword                          ; Sound the door opening  SOUND command
    lda #&c8                            ; ...then put food's pitch back...
    sta food_sound + 4                  ; ...to 200, for the next food eaten
    lda cell_y                          ; Save the door's cell; plot_at_cell changes cell_x/y...
    sta monster_y + 35                  ; ...y into the spare byte at monster_y + 35...
    lda cell_x                          ; ...then the door's x...
    sta monster_x + 35                  ; ...into the spare byte at monster_x + 35
    lda #spr_blank                      ; Erase the door from the screen...
    sta sprite_number                   ; ...the blank as the sprite to plot
    lda #0                              ; ...on the cell itself: no pixel offset...
    sta plot_offset_x                   ; ...horizontally...
    sta plot_offset_y                   ; ...or vertically
    jsr plot_at_cell                    ; Blank the door in every view showing its room
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
    lda (map_ptr),y                     ; ...the row of walls holding the door...
    and scratch                         ; ...knock out the door's bit...
    sta (map_ptr),y                     ; ...so the doorway no longer blocks anyone
    pla                                 ; Recover the door number...
    tax                                 ; ...into X
    lda #off_map                        ; Take the door out of the level...
    sta door_x,x                        ; ...x off the map: no hero matches it again...
    sta door_y,x                        ; ...and y off the map
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    lda #0                              ; The key is used up: the hero carries none
    sta hero_key,x                      ; ...in the hero's key slot
    lda #spr_blank_key_icon             ; Erase the key icon from the hero's panel
    sta sprite_number                   ; ...as the sprite to plot
    lda hero_panel_y,x                  ; ...from the hero's panel row...
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
    jmp next_hero_doors                 ; One door a frame per hero: on to the next hero
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
; Keys. Redraw the keys on the floor, then for each hero: drop a dead hero's key where they fell, or pick up the key at the hero's cell, leaving any key carried in its place. The swap flag only skips the frame after a swap, so a hero who stays on the cell swaps back on the frame after that.
; &1dc2 referenced 1 time by &1dbd
.draw_keys
    lda #0                              ; Redraw every key lying on the floor, 20 to 1
    sta plot_offset_x                   ; ...on their cells: no pixel offset...
    sta plot_offset_y                   ; ...either way
    lda #spr_key                        ; ...in the key sprite...
    sta sprite_number                   ; ...as the sprite to plot
    ldx #max_key                        ; ...counting keys down from 20; entry 0 is never drawn
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
    ldx #0                              ; For each hero, from hero 0...
; &1de6 referenced 1 time by &1ecb
.check_hero_keys
    lda hero_direction,x                ; Still in play (a direction set)?
    bne check_key_swap                  ; Yes: look for a key to pick up
    lda hero_key,x                      ; Out of play: dead, dying or gone. Holding a key?
    bne check_death_finished            ; Yes: see whether the death has played out
    jmp next_hero_keys                  ; No key: nothing to do for this hero
; &1df3 referenced 1 time by &1dee
.check_death_finished
    lda hero_frame,x                    ; Has the death animation reached its end?
    cmp #8                              ; ...frame 8 is the last of the death
    bne check_key_swap                  ; Still dying: key checks go on as if in play
    ldy hero_key,x                      ; Yes: drop the key where the hero fell
    lda hero_x,x                        ; ...at the hero's x...
    sta key_x,y                         ; ...as the key's x...
    lda hero_y,x                        ; ...and the hero's y...
    sta key_y,y                         ; ...as the key's y
    lda #0                              ; The dead hero carries no key now...
    sta hero_key,x                      ; ...so this is done only once
    lda #spr_blank_key_icon             ; Erase the key icon from the hero's panel
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
    lda hero_key_dropped,x              ; Swapped keys on the last frame?
    beq check_key_cell                  ; No: look for a key at the hero's cell
    lda #0                              ; Yes: skip this frame, clearing the flag
    sta hero_key_dropped,x              ; ...so next frame's check may swap again
    jmp next_hero_keys                  ; ...and move on to the next hero
; &1e35 referenced 1 time by &1e2b
.check_key_cell
    lda hero_x,x                        ; Is there a key at the hero's cell? Its x...
    sta cell_x                          ; ...as cell_x...
    lda hero_y,x                        ; ...and the hero's y...
    sta cell_y                          ; ...as cell_y
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack while X counts the keys
    ldx #max_key                        ; ...keys 20 to 1; entry 0 is never picked up
; &1e45 referenced 1 time by &1ec1
.check_key
    lda key_x,x                         ; This key's x...
    cmp cell_x                          ; ...at the hero's x?
    bne next_key                        ; No: try the next key
    lda key_y,x                         ; ...and its y...
    cmp cell_y                          ; ...at the hero's y?
    bne next_key                        ; No: try the next key
    lda #spr_blank                      ; Yes: pick it up, erasing it from the floor
    sta sprite_number                   ; ...as the sprite to plot...
    lda #0                              ; ...on the cell itself: no pixel offset...
    sta plot_offset_x                   ; ...horizontally...
    sta plot_offset_y                   ; ...or vertically
    txa                                 ; Keep the key number...
    pha                                 ; ...on the stack across plot_at_cell
    jsr plot_at_cell                    ; Blank the key in every view showing it
    pla                                 ; Recover the key number...
    tax                                 ; ...into X
    pla                                 ; Show the key icon in the hero's panel: hero...
    tay                                 ; ...into Y...
    pha                                 ; ...and back on the stack for later
    lda #spr_key_icon                   ; ...in the key icon sprite...
    sta sprite_number                   ; ...as the sprite to plot
    lda hero_panel_y,y                  ; ...from the hero's panel row...
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
    ldx hero_key,y                      ; ...the old key, or unseen entry 0 if none...
    lda hero_x,y                        ; ...goes to the hero's x...
    sta key_x,x                         ; ...as its x...
    lda hero_y,y                        ; ...and the hero's y...
    sta key_y,x                         ; ...as its y
    pla                                 ; Recover the new key's number...
    tax                                 ; ...into X, and in A to carry
    sta hero_key,y                      ; ...and carry the new one
    lda #1                              ; Mark the swap
    sta hero_key_dropped,y              ; ...so the dropped key is left alone next frame
    lda #off_map                        ; Take the new key off the floor
    sta key_x,x                         ; ...x off the map, so draw_keys skips it...
    sta key_y,x                         ; ...and y off the map
    ldx #<(key_envelope)                ; Sound the pickup: ENVELOPE key_envelope low...
    ldy #>(key_envelope)                ; ...and high
    lda #osword_envelope                ; OSWORD 8: ENVELOPE
    jsr osword                          ; Define the key pickup envelope  ENVELOPE command
    ldx #<(key_sound)                   ; SOUND key_sound: block address low...
    ldy #>(key_sound)                   ; ...and high
    lda #osword_sound                   ; OSWORD 7: SOUND
    jsr osword                          ; Play the key pickup sound  SOUND command
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    jmp next_hero_keys                  ; One key a frame per hero: next hero
; &1ebe referenced 2 times by &1e4b, &1e53
.next_key
    dex                                 ; Next key
    beq keys_done                       ; Keys all checked: this hero is done
    jmp check_key                       ; Otherwise check the next key
; &1ec4 referenced 1 time by &1ebf
.keys_done
    pla                                 ; Recover the hero number pushed at check_key_cell...
    tax                                 ; ...into X
; &1ec6 referenced 4 times by &1df0, &1e25, &1e32, &1ebb
.next_hero_keys
    inx                                 ; Next hero
    cpx #4                              ; All four heroes done?
    beq update_rest                     ; Yes: on with the rest of the frame
    jmp check_hero_keys                 ; No: check this hero's keys
; &1ece referenced 1 time by &1ec9
.update_rest
    jsr draw_objects                    ; Draw the objects over the floor
    jsr move_missiles                   ; Move the missiles a cell each
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
; end of a level returns into this loop, once for each hero who left by the exit, and
; each of those runs one more frame before the next RTS; the last returns to the caller.
; Only one hero goes down the exit at a time: the exit is taken off the map until the
; animation ends.
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
    jsr check_for_victory               ; On level 25: has a hero reached the Chalice?
    jsr update_game                     ; Run a frame: heroes, keys, objects, monsters
    lda exit_busy                       ; A hero going down the exit?
    bne check_exit                      ; Yes: the level goes on
    ldx #4                              ; Is any hero in play, or still dying? Heroes 3 to 0
; &1f17 referenced 1 time by &1f2b
.count_heroes_in_play
    lda hero_direction - 1,x            ; In play (a direction set)?
    bne check_exit                      ; Yes: the level goes on
    lda hero_health_tens - 1,x          ; Out of play: dead...
    cmp #spr_digit_0 - 1                ; ...(health tens digit below 0)...
    bne next_hero_in_play               ; No: alive but out of play; next hero
    lda hero_frame - 1,x                ; ...with the death animation unfinished?
    cmp #8                              ; ...frame 8 is the last of the death
    bcc check_exit                      ; Yes: the level goes on
; &1f2a referenced 1 time by &1f21
.next_hero_in_play
    dex                                 ; Next hero
    bne count_heroes_in_play            ; More heroes: check the next
    ldx shrunk_hero                     ; The level is over: restore the last exiting hero's sprites
    bmi play_level_done                 ; None (&FF): nothing to restore
    jsr restore_hero_sprites            ; Give them back their full-size sprites
; &1f35 referenced 1 time by &1f30
.play_level_done
    rts                                 ; Return, perhaps into this loop at &1F8E
; &1f36 referenced 3 times by &1f13, &1f1a, &1f28
.check_exit
    ldx #0                              ; Is a hero on the exit? From hero 0
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
    lda hero_x,x                        ; Erase them from the exit's cell
    sta cell_x                          ; ...as cell_x...
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
    jmp check_exit_busy                 ; Reached by the RTS at the end of the level: one more frame
; &1f91 referenced 2 times by &1f3e, &1f46
.next_hero_exit
    inx                                 ; Next hero
    cpx #4                              ; All four heroes checked?
    bne check_hero_on_exit              ; No: check the next
; &1f96 referenced 1 time by &1f8e
.check_exit_busy
    lda exit_busy                       ; A hero going down the exit?
    bne redraw_exit                     ; Yes: draw this frame of the descent
    jmp play_level                      ; No: next frame
; &1f9e referenced 1 time by &1f99
.redraw_exit
    ldx exiting_hero                    ; Redraw the exit under the spinning hero
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
    ldx exiting_hero                    ; Turn the hero a quarter: up, right, down, left
    clc                                 ; ...clear carry for the add
    lda exit_spin                       ; ...from the current direction...
    adc #2                              ; ...two sprites on: the next direction...
    sta exit_spin                       ; ...kept for the next frame
    cmp #9                              ; Past left (9): a full turn?
    beq next_turn                       ; Yes: shrink the hero, showing just the exit
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
    lda #&ff                            ; Start the next turn from facing up
    sta exit_spin                       ; ...-1, so the next frame's +2 gives 1
    dec exit_shrinks_left               ; Fourth turn done?
    beq restore_exit                    ; Yes: the hero has gone; bring the exit back
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
    dec sprite_widths,x                 ; One byte (two pixels) narrower
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
    lda exit_saved_x                    ; Put the exit back where it was...
    sta exit_x                          ; ...x...
    lda exit_saved_y                    ; ...and its saved y...
    sta exit_y                          ; ...as its y, so the next hero can use it
    lda #0                              ; ...and end the animation
    sta exit_busy                       ; ...exit no longer busy
    jmp play_level                      ; Next frame
; ***************************************************************************************
; Start a hero going down the exit
;
; Called by play_level for hero X, who has just stepped onto the exit. Play the exit
; sound and put a marker in returning_hero_queue, give any hero shrunk on an earlier exit
; back their full-size sprites, then mark the exit busy and set up four turns of the spin
; for hero X. Ends by jumping to play_level rather than returning, so its return address
; stays on the stack until the level ends.
;
; On Entry:
;     X: hero number (0-3)
; &203a referenced 1 time by &1f8b
.hero_enters_exit
    stx scratch2                        ; Keep the hero number
    jsr queue_exit_marker               ; Sound the exit; mark the hero queue
    lda #4                              ; exit_offsets_x entry 0 = 4...
    sta exit_offsets_x                  ; ...never read: shrinks run from 4 down to 1
    ldx shrunk_hero                     ; Restore the sprites of any hero shrunk before
    bmi start_hero_animation            ; None (&FF): go straight on
    jsr restore_hero_sprites            ; Give that hero back their full-size sprites
    jmp start_hero_animation            ; ...then start this hero's spin
; ***************************************************************************************
; Restore a hero's sprite sizes
;
; Set the seven sprites base + 1 to base + 7 of hero X (base from hero_sprites), which
; the exit animation shrinks, back to the full cell: 4 bytes wide and 12 rows high. Used
; when the next hero takes the exit and when the level ends.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     A: 12
;     X: base + 1
;     Y: base + 8
; &2050 referenced 2 times by &1f32, &204a
.restore_hero_sprites
    clc                                 ; The hero's sprites base + 1 to base + 7
    lda hero_sprites,x                  ; ...the hero's sprite base...
    adc #1                              ; ...+1: their first sprite...
    tax                                 ; ...in X, for the height loop...
    tay                                 ; ...and in Y, for the width loop
    adc #7                              ; ...+7: stop before base + 8, left frame 1
    sta scratch                         ; ...kept as the end
    lda #4                              ; Widths back to 4 bytes, a whole cell...
; &205f referenced 1 time by &2066
.restore_sprite_widths
    sta sprite_widths,y                 ; Full width
    iny                                 ; Next sprite
    cpy scratch                         ; Reached the end?
    bne restore_sprite_widths           ; No: widen the next
    txa                                 ; ...from the first sprite again
    tay                                 ; ...into Y
    lda #&0c                            ; ...heights back to 12 rows, a whole cell
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
    lda #4                              ; ...for four turns, shrinking after the first three
    sta exit_shrinks_left               ; ...as exit_shrinks_left
    jmp play_level                      ; Back to play_level, leaving the JSR's return address
; ***************************************************************************************
; Drop the key a hero carries
;
; Called when hero X steps onto the exit. Put their key in a cell next to them with no
; wall (see find_open_neighbour; another key or an object may already lie there), and
; erase the key icon from their panel section. A hero with no key moves key entry 0,
; which is never drawn or picked up.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &2091 referenced 1 time by &1f48
.drop_key
    lda hero_x,x                        ; From the hero's cell (the exit)...
    sta cell_x                          ; ...as cell_x...
    lda hero_y,x                        ; ...and the hero's y...
    sta cell_y                          ; ...as cell_y
    txa                                 ; ...find a wall-free cell next to it
    pha                                 ; Keep the hero number...
    jsr find_open_neighbour             ; ...on the stack across the search
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    ldy hero_key,x                      ; Put the hero's key there (entry 0 if none)
    lda cell_x                          ; ...the free cell's x...
    sta key_x,y                         ; ...as the key's x...
    lda cell_y                          ; ...and its y...
    sta key_y,y                         ; ...as the key's y
    lda #0                              ; The hero carries no key
    sta hero_key,x                      ; ...in the hero's key slot
    lda #spr_blank_key_icon             ; Erase the key icon from the hero's panel
    sta sprite_number                   ; ...as the sprite to plot
    lda hero_panel_y,x                  ; ...from the hero's panel row...
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
; Starting with cell_x, cell_y, try the cells above, to the right and below, and leave
; cell_x, cell_y at the first without a wall; failing those, leave them at the cell to
; the left without testing it. Only walls are tested, not keys, objects or creatures.
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
    dec cell_y                          ; Try the cell above first
    jsr test_wall                       ; ...is there a wall in it?
    cpy #0                              ; Y = 0 if no wall there
    bne try_cell_right                  ; Wall: try the cell to the right
    rts                                 ; No wall: leave cell_x, cell_y on it
; &20db referenced 1 time by &20d8
.try_cell_right
    inc cell_y                          ; Then the cell to the right
    inc cell_x                          ; ...x + 1 (y back to the starting row)
    jsr test_wall                       ; ...is there a wall in it?
    cpy #0                              ; Y = 0 if no wall there
    bne try_cell_below                  ; Wall: try the cell below
    rts                                 ; No wall: leave cell_x, cell_y on it
; &20e9 referenced 1 time by &20e6
.try_cell_below
    dec cell_x                          ; Then the cell below
    inc cell_y                          ; ...y + 1 (x back to the starting column)
    jsr test_wall                       ; ...is there a wall in it?
    cpy #0                              ; Y = 0 if no wall there
    bne try_cell_left                   ; Wall: fall back on the cell to the left
    rts                                 ; No wall: leave cell_x, cell_y on it
; &20f7 referenced 1 time by &20f4
.try_cell_left
    dec cell_y                          ; Otherwise the cell to the left
    dec cell_x                          ; ...x - 1: unchecked, the last resort
    rts                                 ; Return, Y non-zero
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
; Called by update_game at the start of each frame. A hero out of play is skipped if
; nobody plays them (step &63), or animated by animate_absent_hero if dying or returning
; through a Cross. A hero part way through a step finishes it. Otherwise heroes 0 and 1
; first try their magic key (check_magic, whose delay can return from move_heroes before
; the later heroes move), then the keys are tried in the order up, down, right, left,
; fire, and the first held one wins. A move records the cell tried in hero_door_x/y, for
; update_game's door test, before a wall, a monster (which costs a health point) or
; another hero in play can refuse it. A move into another room is made at once and
; switches the hero's view; within a room the Boots of Speed also make it at once, and
; without them the hero is drawn half a cell along and arrives on the next frame through
; continue_hero_step. Fire puts a missile in the hero's first free slot. A hero who moved
; is erased at their old position; every hero in play is then drawn and picks up any
; object in their cell.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &6e80 referenced 1 time by &1cc0
.move_heroes
    ldx #0                              ; Hero 0, the Ranger, first
; &6e82 referenced 1 time by &70c6
.move_hero
    lda hero_direction,x                ; A direction (1, 3, 5, 7) means the hero is in play
    bne remember_hero_position          ; In play: remember where they are, then move them
    lda hero_step,x                     ; Out of play: why? The step says
    cmp #step_out_of_play               ; Step &63 marks a hero nobody plays
    bne animate_absent                  ; Not &63: the hero is dying or returning
    jmp next_hero                       ; Nobody plays them: nothing to move or draw
; &6e91 referenced 1 time by &6e8c
.animate_absent
    jsr animate_absent_hero             ; Step the skull or resurrection animation
    jmp next_hero                       ; Then on to the next hero
; In play: keep the cell and offsets now drawn, to erase the hero there and to put them back if blocked.
; &6e97 referenced 1 time by &6e85
.remember_hero_position
    lda hero_x,x                        ; Remember the hero's cell and offsets before moving
    sta previous_x                      ; previous_x: where to put the hero back if blocked
    lda hero_y,x                        ; The cell's y...
    sta previous_y                      ; ...in previous_y, for the same
    lda hero_offset_x,x                 ; The horizontal pixel offset now drawn...
    sta previous_offset_x               ; ...so erase_hero blanks the image where it is
    lda hero_offset_y,x                 ; And the vertical pixel offset...
    sta previous_offset_y               ; ...for the same erase
    lda hero_step,x                     ; Half way between cells (step 1)?
    beq check_magic_key                 ; No: standing in a cell, so read the keys
    jsr continue_hero_step              ; Yes: arrive in the next cell; no keys this frame
    jmp erase_hero                      ; Erase the half-way image, draw the arrival
; &6eba referenced 1 time by &6eb2
.check_magic_key
    cpx #2                              ; Hero 0 or 1 (the two with magic)?
    bcs read_hero_keys                  ; Barbarian or Fighter: no magic, straight to the keys
    jmp check_magic                     ; Ranger or Magic-User: magic key, then back
; Standing in a cell: the first held key of up, down, right, left and fire decides what the hero does.
; &6ec1 referenced 2 times by &6ebc, &76ab
.read_hero_keys
    lda hero_key_up,x                   ; Up key held? (directions beat fire, up first)
    jsr test_key                        ; Z set if held
    bne check_key_down                  ; Not held: try down
    lda #1                              ; Held: face up...
    sta hero_direction,x                ; ...direction 1: drawn as sprite base + 1 or + 2
    jsr start_hero_step                 ; ...set the half-cell offsets for the step...
    jmp step_hero                       ; ...and try the cell above
; &6ed4 referenced 1 time by &6ec7
.check_key_down
    lda hero_key_down,x                 ; Down key held?
    jsr test_key                        ; Z set if held
    bne check_key_right                 ; Not held: try right
    lda #5                              ; Held: face down...
    sta hero_direction,x                ; ...direction 5: drawn as sprite base + 5 or + 6
    jsr start_hero_step                 ; ...set the half-cell offsets for the step...
    jmp step_hero                       ; ...and try the cell below
; &6ee7 referenced 1 time by &6eda
.check_key_right
    lda hero_key_right,x                ; Right key held?
    jsr test_key                        ; Z set if held
    bne check_key_left                  ; Not held: try left
    lda #3                              ; Held: face right...
    sta hero_direction,x                ; ...direction 3: drawn as sprite base + 3 or + 4
    jsr start_hero_step                 ; ...set the half-cell offsets for the step...
    jmp step_hero                       ; ...and try the cell to the right
; &6efa referenced 1 time by &6eed
.check_key_left
    lda hero_key_left,x                 ; Left key held?
    jsr test_key                        ; Z set if held
    bne check_key_fire                  ; Not held: try fire
    lda #7                              ; Held: face left...
    sta hero_direction,x                ; ...direction 7: drawn as sprite base + 7 or + 8
    jsr start_hero_step                 ; ...set the half-cell offsets for the step...
    jmp step_hero                       ; ...and try the cell to the left
; &6f0d referenced 1 time by &6f00
.check_key_fire
    lda hero_key_fire,x                 ; Fire key held? (only when no direction is)
    jsr test_key                        ; Z set if held
    beq fire_missile                    ; Held: launch a missile the way the hero faces
    jmp draw_moved_hero                 ; No key: the hero stands still, drawn in place
; Fire: put a missile in the hero's first free slot, in the hero's cell, flying the way the hero faces.
; &6f18 referenced 1 time by &6f13
.fire_missile
    txa                                 ; Slots 3 x hero to 3 x hero + hero_max_missiles - 1
    sta scratch                         ; Hero number kept to add...
    asl a                               ; ...x 2...
    clc                                 ; ...(no carry in)...
    adc scratch                         ; ...+ hero: 3 x hero, the hero's first slot
    tay                                 ; Y walks the hero's slots
    adc hero_max_missiles,x             ; - how many missiles the hero may have in flight...
    sta scratch                         ; ...the first slot past the hero's own
; &6f28 referenced 1 time by &6f74
.find_missile_slot
    lda missile_direction,y             ; This slot's missile still flying?
    bne next_missile_slot               ; Yes: look at the hero's next slot
    lda hero_direction,x                ; Free: missile direction = (hero direction + 1) / 2
    clc                                 ; Hero direction 1, 3, 5 or 7...
    adc #1                              ; ...+ 1...
    lsr a                               ; ...halved: 1-4, up, right, down, left
    ora #&80                            ; Bit 7: just fired, so not erased off the hero
    sta missile_direction,y             ; The slot is now in flight
    lda hero_x,x                        ; It starts in the hero's cell; move_missiles moves it on
    sta missile_x,y                     ; ...missile x = hero x...
    lda hero_y,x                        ; ...and the hero's y...
    sta missile_y,y                     ; ...as missile y
    nop                                 ; Padding: no bell when a missile is fired
    nop                                 ; Padding: does nothing
    nop                                 ; Padding: does nothing
    nop                                 ; Padding: does nothing
    nop                                 ; Padding: does nothing
    lda hero_missile_damage,x           ; The hero's current missile damage...
    sta missile_damage,y                ; ...goes with this missile, for whatever it hits
    lda hero_missile_sprites,x          ; The hero's weapon sprites (arrow, fireball, axe, sword)...
    sta missile_sprite_base,y           ; ...so it is drawn, and its owner known, by these
    lda previous_x                      ; Put back the cell remembered at the start...
    sta hero_x,x                        ; ...the same cell: nothing has moved the hero here
    lda previous_y                      ; And the y...
    sta hero_y,x                        ; ...likewise
    lda hero_frame,x                    ; Next animation frame...
    eor #1                              ; ...0 and 1 alternate...
    sta hero_frame,x                    ; ...so the hero is seen to throw
    jmp draw_moved_hero                 ; Draw the hero where they stand; no erase needed
; Unreachable after the JMP: DEY and BNE find_missile_slot.
    equb &88, &d0, &b8                  ; Not referenced
; &6f70 referenced 1 time by &6f2b
.next_missile_slot
    iny                                 ; The hero's next slot
    cpy scratch                         ; Past the hero's last slot?
    bne find_missile_slot               ; No: is that one free?
    jmp draw_moved_hero                 ; All the hero's missiles in flight: no shot
; Move: try the next cell the way the hero faces. A wall or closed door, a monster, or another hero in play refuses it.
; &6f79 referenced 4 times by &6ed1, &6ee4, &6ef7, &6f0a
.step_hero
    lda hero_direction,x                ; Move the hero's cell in the direction faced: up...
    cmp #1                              ; Facing up?
    bne step_right                      ; No: try right
    dec hero_y,x                        ; Up: one row up the map
; &6f83 referenced 1 time by &6f7e
.step_right
    cmp #3                              ; ...right...
    bne step_down                       ; No: try down
    inc hero_x,x                        ; Right: one column along
; &6f8a referenced 1 time by &6f85
.step_down
    cmp #5                              ; ...down...
    bne step_left                       ; No: try left
    inc hero_y,x                        ; Down: one row down the map
; &6f91 referenced 1 time by &6f8c
.step_left
    cmp #7                              ; ...left
    bne note_new_cell                   ; No: the cell is moved
    dec hero_x,x                        ; Left: one column back
; &6f98 referenced 1 time by &6f93
.note_new_cell
    lda hero_x,x                        ; Record the cell tried, wall or not...
    sta hero_door_x,x                   ; ...so update_game finds a door the hero walks into
    lda hero_y,x                        ; And the y tried...
    sta hero_door_y,x                   ; ...in hero_door_y
    lda hero_x,x                        ; Is the cell tried a wall (or a closed door)?
    sta cell_x                          ; cell_x: the cell for test_wall
    lda hero_y,x                        ; And the y tried...
    sta cell_y                          ; ...in cell_y
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack across test_wall
    jsr test_wall                       ; Y = the cell's wall bit; map_ptr = its room
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    cpy #0                              ; Wall bit clear?
    beq check_monster_in_cell           ; Clear: is a monster in the way?
    lda previous_x                      ; A wall: the hero stays in the old cell...
    sta hero_x,x                        ; ...x back...
    lda previous_y                      ; ...and y back...
    sta hero_y,x                        ; ...so the hero does not enter the wall
; &6fc7 referenced 1 time by &7050
.cancel_hero_step
    lda #0                              ; The move is over: the hero stands in a whole cell
    sta hero_step,x                     ; No step under way...
    sta hero_offset_x,x                 ; ...no horizontal offset...
    sta hero_offset_y,x                 ; ...and no vertical offset
    jmp erase_hero                      ; Erase the old image, draw the hero in their cell
; &6fd5 referenced 1 time by &6fb9
.check_monster_in_cell
    lda #0                              ; Is a monster in the cell tried?
    sta scratch                         ; scratch 0: look for monsters only, not heroes
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack across find_creature
    jsr find_creature                   ; Y non-zero if a monster is in the cell
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    cpy #0                              ; A monster there?
    beq check_hero_in_cell              ; No: is another hero in the way?
    lda previous_x                      ; Yes: the hero stays in the old cell...
    sta hero_x,x                        ; ...x back...
    lda previous_y                      ; ...and y back...
    sta hero_y,x                        ; ...so the hero stays out of the monster's cell
    lda #0                              ; The move is over: the hero stands in a whole cell...
    sta hero_step,x                     ; ...no step under way...
    sta hero_offset_x,x                 ; ...no horizontal offset...
    sta hero_offset_y,x                 ; ...and no vertical offset
    jsr lose_health_point               ; ...and pays a health point for walking into it
    jmp erase_hero                      ; Erase the old image, draw the hero in their cell
; &7002 referenced 1 time by &6fe3
.check_hero_in_cell
    stx scratch                         ; Is another hero in play in the cell tried?
    ldy #0                              ; From hero 0
; &7007 referenced 1 time by &703e
.check_other_hero
    cpy scratch                         ; The moving hero itself?
    beq next_other_hero                 ; Yes: skip it
    lda hero_x,y                        ; Other hero's x...
    cmp cell_x                          ; ...the cell tried's x?
    bne next_other_hero                 ; No: not in the way
    lda hero_y,y                        ; Other hero's y...
    cmp cell_y                          ; ...the cell tried's y?
    bne next_other_hero                 ; No: not in the way
    lda hero_direction,y                ; There, but in play?
    beq next_other_hero                 ; No (a skull, say): not in the way
    lda previous_x                      ; In play there: the hero stays in the old cell...
    sta hero_x,x                        ; ...x back...
    lda previous_y                      ; ...and y back...
    sta hero_y,x                        ; ...so heroes in play never share a cell
    lda #0                              ; The move is over: the hero stands in a whole cell...
    sta hero_step,x                     ; ...no step under way...
    sta hero_offset_x,x                 ; ...no horizontal offset...
    sta hero_offset_y,x                 ; ...and no vertical offset
    jmp erase_hero                      ; Erase the old image, draw the hero in their cell
; &703b referenced 4 times by &700a, &7012, &701a, &701f
.next_other_hero
    iny                                 ; Next hero
    cpy #4                              ; Checked all four?
    bne check_other_hero                ; No: check that one
; The cell is free. A move into another room is made at once, as is one with the Boots of Speed; otherwise the hero is drawn half way and arrives on the next frame.
    txa                                 ; The way is clear. Is the cell tried in another room?
    asl a                               ; Two bytes per view_room entry...
    tax                                 ; ...so X = 2 x hero indexes the hero's view
    lda view_room,x                     ; The low byte of the room the hero's view shows...
    cmp map_ptr                         ; ...against the cell's room, left by test_wall
    beq check_boots                     ; Same room: the boots decide the pace
    txa                                 ; New room: the hero arrives at once...
    lsr a                               ; Halve the index...
    tax                                 ; ...back to the hero number
    jsr show_hero_room                  ; Switch the hero's view to the new room and draw it
    jmp cancel_hero_step                ; ...and the move ends in the new cell, no half step
; &7053 referenced 1 time by &7048
.check_boots
    txa                                 ; Wearing the Boots of Speed?
    lsr a                               ; Halve the view index...
    tax                                 ; ...back to the hero number
    lda hero_has_boots,x                ; Non-zero while the hero wears the boots
    beq stay_in_old_cell                ; No: a half step this frame
    lda #0                              ; Yes: arrive in the cell at once, with no step
    sta hero_offset_x,x                 ; No horizontal offset...
    sta hero_offset_y,x                 ; ...no vertical offset...
    sta hero_step,x                     ; ...and no step: one cell a frame, twice the pace
    jmp erase_hero                      ; Erase the old position and draw the new
; &7069 referenced 1 time by &7059
.stay_in_old_cell
    lda previous_x                      ; No boots: hero stays in the old cell, drawn half way
    sta hero_x,x                        ; ...by start_hero_step's offsets; next frame it arrives
    lda previous_y                      ; And the old y...
    sta hero_y,x                        ; ...so others still meet the hero in the old cell
; Erase the hero's image from where it was drawn last.
; &7075 referenced 5 times by &6eb7, &6fd2, &6fff, &7038, &7066
.erase_hero
    lda #spr_blank                      ; Erase the hero's image as it was before this frame
    sta sprite_number                   ; The blank sprite...
    lda previous_x                      ; ...at the hero's old cell...
    sta cell_x                          ; ...as the cell to plot at
    lda previous_y                      ; And the old y...
    sta cell_y                          ; ...in cell_y
    lda previous_offset_x               ; With the old pixel offsets too...
    sta plot_offset_x                   ; ...across...
    lda previous_offset_y               ; ...and down...
    sta plot_offset_y                   ; ...so a half-way image is blanked where it was
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack across plot_at_cell
    jsr plot_at_cell                    ; Blank the hero in every view showing that cell
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
; Draw the hero, then pick up any object in their cell.
; &7096 referenced 4 times by &6f15, &6f6a, &6f76, &76ae
.draw_moved_hero
    clc                                 ; Clear carry for the sprite sum
    lda hero_direction,x                ; Still in play? A bump or magic's cost may have killed
    beq next_hero                       ; Direction 0: out of play, not drawn
    adc hero_frame,x                    ; Sprite = direction + frame (0 or 1)...
    adc hero_sprites,x                  ; ...+ the hero's base: Ranger, Magic-User, and so on
    sta sprite_number                   ; The sprite to draw
    jsr draw_hero                       ; Draw them in every view showing their cell
    lda hero_x,x                        ; Can the hero's cell hold an object?
    sta cell_x                          ; The hero's cell, to test for an object...
    lda hero_y,x                        ; And the hero's y...
    sta cell_y                          ; ...in cell_y
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack across test_object_free
    jsr test_object_free                ; Y zero if an object may lie in the cell
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    cpy #0                              ; Can an object lie there?
    bne next_hero                       ; No: nothing to pick up; next hero
    jsr collect_objects                 ; Yes: pick up whatever is there
; &70c1 referenced 4 times by &6e8e, &6e94, &709a, &70bc
.next_hero
    inx                                 ; Next hero
    cpx #4                              ; All four heroes moved?
    beq move_heroes_done                ; Yes: done
    jmp move_hero                       ; No: move the next hero
; &70c9 referenced 1 time by &70c4
.move_heroes_done
    rts                                 ; Return to update_game
; ***************************************************************************************
; Move the missiles
;
; Called by update_game each frame, after move_heroes and draw_objects and before
; update_monsters. Each of the twelve slots (three per hero, from 3 x hero) whose missile
; is in flight is erased from its cell, unless fired this frame and so still on its hero,
; and moved one cell in its direction (1-4: up, right, down, left). The new cell is then
; tried in turn. A wall spends the missile. A live monster takes its damage through
; monster_hit, which spends the missile and, for a kill, gives the firer a point; a
; monster already sparkling lets it through. The test for live is a sprite below the
; first sparkle, so a monster killed earlier in the frame (sprite blank until
; update_monsters runs) can be hit again. An energy drainer is worn down a stage, and
; removed after its last; the firer scores a point and the missile is turned round in the
; drainer's cell. Any hero in the cell, the firer included and whether in play or not,
; spends the missile, and lose_health_point takes its damage from a hero in play.
; Otherwise the missile is drawn in its new cell, pointing the way it flies.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &70ca referenced 1 time by &1ed1
.move_missiles
    lda #0                              ; Missiles move a whole cell a frame...
    sta plot_offset_x                   ; ...so they are plotted with no horizontal offset...
    sta plot_offset_y                   ; ...and no vertical offset
    ldx #0                              ; Slot 0 first: the Ranger's first missile
; &70d2 referenced 1 time by &721d
.move_missile
    lda missile_direction,x             ; A direction means this slot's missile is flying
    bne check_just_fired                ; Flying: erase and move it
    jmp next_missile                    ; Empty slot: nothing to move
; &70da referenced 1 time by &70d5
.check_just_fired
    bpl erase_missile                   ; Bit 7 clear: flying since an earlier frame
    and #&7f                            ; Fired this frame: drop the just-fired bit...
    sta missile_direction,x             ; ...leaving direction 1-4
    jsr flip_firer_frame                ; ...flip the firer's animation frame again...
    jmp missile_up                      ; ...and move it unerased: its cell is the hero's
; Erase the missile and move it one cell.
; &70e7 referenced 1 time by &70da
.erase_missile
    lda #spr_blank                      ; Erase the missile from the cell it flew to last frame
    sta sprite_number                   ; The blank sprite
    lda missile_x,x                     ; The missile's x...
    sta cell_x                          ; ...as the cell to plot at
    lda missile_y,x                     ; And its y...
    sta cell_y                          ; ...in cell_y
    txa                                 ; Keep the missile slot...
    pha                                 ; ...on the stack across plot_at_cell
    jsr plot_at_cell                    ; Blank it in every view showing that cell
    pla                                 ; Recover the missile slot...
    tax                                 ; ...into X
; &70fe referenced 1 time by &70e4
.missile_up
    lda missile_direction,x             ; Move it one cell the way it flies: up...
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
    bne check_missile_wall              ; No: the cell is moved
    dec missile_x,x                     ; Left: one column back
; Try the new cell: wall, monster, energy drainer, then hero. The slot stays on the stack through the tests.
; &711d referenced 1 time by &7118
.check_missile_wall
    lda missile_x,x                     ; Does the missile's new cell hold a wall or door?
    sta cell_x                          ; ...as the cell to test
    lda missile_y,x                     ; And its y...
    sta cell_y                          ; ...in cell_y
    txa                                 ; Keep the missile slot...
    pha                                 ; ...on the stack across the tests
    jsr test_wall                       ; Z set if the cell is clear of walls
    beq check_missile_monster           ; Clear: is a monster there?
; &7130 referenced 2 times by &71fe, &75ab
.missile_spent_pop
    pla                                 ; A wall: the missile stops, never drawn there
    tax                                 ; Recover the missile slot
; &7132 referenced 1 time by &7153
.missile_spent
    lda #0                              ; The missile is spent: free its slot...
    sta missile_direction,x             ; ...direction 0, so the hero may fire again
    jmp next_missile                    ; On to the next slot
; &713a referenced 1 time by &712e
.check_missile_monster
    lda #0                              ; Is a monster in the new cell?
    sta scratch                         ; scratch 0: look for monsters only, not heroes
    jsr find_creature                   ; Z clear, X = the monster, if one is in the cell
    beq check_missile_object            ; None: an object or a hero?
    lda monster_sprite,x                ; One there: is it still alive?
    cmp #spr_sparkle_0                  ; Sparkles on: dying; the blank (just killed) is live
    bcs check_missile_object            ; Dying: the missile flies through it
    pla                                 ; Alive: hit it, with the slot off the stack...
    tay                                 ; ...in Y, for monster_hit
    jmp monster_hit                     ; Hit sound, damage; it spends the missile
; &7150 referenced 1 time by &75a3
.monster_killed
    jsr credit_missile_owner            ; monster_hit's kill: a point to the firer...
    jmp missile_spent                   ; ...and the missile is spent
; &7156 referenced 2 times by &7142, &7149
.check_missile_object
    pla                                 ; Could the new cell hold an object (a drainer)?
    tax                                 ; Recover the missile slot
    lda missile_x,x                     ; The missile's x...
    sta cell_x                          ; ...as the cell to test
    lda missile_y,x                     ; And its y...
    sta cell_y                          ; ...in cell_y
    txa                                 ; Keep the missile slot...
    pha                                 ; ...on the stack across test_object_free
    jsr test_object_free                ; Y zero if an object may lie in the cell
    pla                                 ; Recover the missile slot...
    tax                                 ; ...into X
    cpy #0                              ; Can an object lie there?
    bne check_missile_hero              ; No: no drainer; is a hero there?
; A missile hitting an energy drainer wears it down, scores for the firer and turns round in its cell.
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
    lda object_type,x                   ; The object in the cell: a drainer (&53-&5E)?
    cmp #spr_drainer_0                  ; Below the drainer sprites?
    bcc no_drainer                      ; Yes: some other object; stop looking
    cmp #spr_drainer_11 + 1             ; Past the last drainer stage?
    bcs no_drainer                      ; Yes: some other object; stop looking
    inc object_type,x                   ; A drainer: the hit wears it down a stage
    lda object_type,x                   ; Its new stage...
    cmp #spr_drainer_11 + 1             ; Past the last (12 hits from the first stage)?
    bne credit_drainer_hit              ; No: it survives; score and bounce
    lda #off_map                        ; Worn away: take it out of the level
    sta object_x,x                      ; Off the map in x...
    sta object_y,x                      ; ...and y, so it is never drawn or met again
; &71a0 referenced 1 time by &7196
.credit_drainer_hit
    pla                                 ; A point to the hero who fired, for every hit
    tax                                 ; Recover the missile slot
    jsr credit_missile_owner            ; The missile's sprites say whose it is
    lda missile_direction,x             ; Turn the missile round, still in the drainer's cell
    cmp #1                              ; Flying up?
    bne reverse_right                   ; No: try right
    lda #3                              ; Up turns to down...
    sta missile_direction,x             ; ...back the way it came
    jmp check_missile_hero              ; Is a hero in the drainer's cell?
; &71b4 referenced 1 time by &71aa
.reverse_right
    cmp #2                              ; ...right...
    bne reverse_down                    ; No: try down
    lda #4                              ; Right turns to left...
    sta missile_direction,x             ; ...back the way it came
    jmp check_missile_hero              ; Is a hero in the drainer's cell?
; &71c0 referenced 1 time by &71b6
.reverse_down
    cmp #3                              ; ...down...
    bne reverse_left                    ; No: it was flying left
    lda #1                              ; Down turns to up...
    sta missile_direction,x             ; ...back the way it came
    jmp check_missile_hero              ; Is a hero in the drainer's cell?
; &71cc referenced 1 time by &71c2
.reverse_left
    lda #2                              ; Left turns to right...
    sta missile_direction,x             ; ...back the way it came
    jmp check_missile_hero              ; Is a hero in the drainer's cell?
; &71d4 referenced 2 times by &7179, &7181
.next_object_drainer
    dex                                 ; Next object
    bne check_object_drainer            ; Until all 30 are checked
; &71d7 referenced 2 times by &7188, &718c
.no_drainer
    pla                                 ; No drainer in the cell: drop the saved slot...
    tax                                 ; ...back into X
; The first hero in the cell, in play or not, stops the missile.
; &71d9 referenced 5 times by &716d, &71b1, &71bd, &71c9, &71d1
.check_missile_hero
    txa                                 ; Is a hero in the new cell? Any hero, even the firer
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
    lda missile_damage,y                ; Hit: the hero loses the missile's damage...
    tay                                 ; ...Y health points, one at a time
; &71f4 referenced 1 time by &71fc
.take_missile_damage
    tya                                 ; Keep the count...
    pha                                 ; ...on the stack across the call
    jsr lose_health_point               ; One point (none if out of play, as a skull)
    pla                                 ; Recover the count...
    tay                                 ; ...into Y
    dey                                 ; One fewer to take
    bne take_missile_damage             ; More to take: take the next
    jmp missile_spent_pop               ; The missile is spent, slot still on the stack
; &7201 referenced 2 times by &71e6, &71ee
.next_hero_hit
    inx                                 ; Next hero
    cpx #4                              ; All four heroes checked?
    bne check_hero_hit                  ; No: check the next hero against the missile's cell
    pla                                 ; Nothing hit: the missile flies on, drawn in its new cell
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
    cpx #&0c                            ; Past the twelfth slot (three per hero)?
    beq move_missiles_done              ; Yes: every missile moved this frame
    jmp move_missile                    ; No: move this slot's missile
; &7220 referenced 1 time by &721b
.move_missiles_done
    rts                                 ; Return
; ***************************************************************************************
; Take one health point from a hero
;
; If hero X is in play, take one from their health and redraw it in the status panel.
; Every kind of harm comes through here one point at a time: a monster's touch or bump, a
; missile, an energy drainer, the cost of magic. draw_status_panel, the potion and a
; returning hero also call it, to draw a health set one point high. Health is two digit
; sprites, so the units digit wraps from 0 to 9 with a borrow from the tens. Health 00 is
; still alive; the hero dies when a point is taken from 00. Then their sprite is erased,
; they leave play (direction 0), the death animation is started (frame step +1, counter
; 1) and their number + 1 is added at the end of returning_hero_queue, for a Cross of
; Resurrection to bring back. A hero out of play, dying or returning, loses nothing. The
; health is not redrawn on death.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &7221 referenced 8 times by &0eff, &6ffc, &71f6, &749a, &7512, &7654, &772a, &79ac
.lose_health_point
    lda hero_direction,x                ; Direction 0: out of play, dying or returning
    bne take_health_unit                ; In play: they can be hurt
    rts                                 ; Out of play: nothing to lose
; &7227 referenced 1 time by &7224
.take_health_unit
    dec hero_health_units,x             ; Health down one: the units digit sprite
    lda hero_health_units,x             ; ...and look at the new units digit
    cmp #spr_digit_0 - 1                ; Gone below the 0 sprite?
    bne draw_health                     ; No: the tens are untouched, redraw the health
    lda #spr_digit_9                    ; Yes: units back to 9...
    sta hero_health_units,x             ; ...so 30 becomes 29
    dec hero_health_tens,x              ; ...and borrow from the tens
    lda hero_health_tens,x              ; ...and look at the new tens digit
    cmp #spr_digit_0 - 1                ; Below 0? The point was taken from 00
    bne draw_health                     ; No: still alive, redraw the health
    lda #spr_blank                      ; The hero has died: erase them...
    sta sprite_number                   ; ...with the blank sprite...
    jsr draw_hero                       ; ...at their cell in every view showing it
    lda #0                              ; ...take them out of play...
    sta hero_direction,x                ; ...so they neither move nor take more harm
    lda #1                              ; ...and start the death animation:
    sta hero_offset_x,x                 ; ...frame step +1: forwards to the skull...
    sta hero_offset_y,x                 ; ...frame counter 1: the first step comes next frame
    ldy #0                              ; Queue them for a Cross: from the queue's front...
; &7256 referenced 1 time by &7264
.find_queue_slot
    lda returning_hero_queue,y          ; ...look at this queue entry
    bne next_queue_slot                 ; Taken: try the next entry
    txa                                 ; Free: hero number...
    clc                                 ; ...plus one...
    adc #1                              ; ...(entries are hero + 1, so 0 can mean free)...
    sta returning_hero_queue,y          ; ...queued behind those already waiting
    rts                                 ; Return, health not redrawn
; &7263 referenced 1 time by &7259
.next_queue_slot
    iny                                 ; Next queue entry
    bne find_queue_slot                 ; Keep looking (an empty entry is always found)
; Draw hero X's health, two digit sprites on the top row of their panel section. lose_health_point and the food reach it.
; &7266 referenced 3 times by &722f, &723e, &73a2
.draw_health
    lda hero_panel_y,x                  ; Health on the top row of the hero's panel section...
    sta plot_y                          ; ...as the plotting row
    lda #panel_left                     ; Tens in the panel's left column...
    sta plot_x                          ; ...as the plotting column
    lda hero_health_tens,x              ; The tens digit sprite...
    sta sprite_number                   ; ...as the sprite to plot
    txa                                 ; Keep the hero number...
    pha                                 ; ...across the plot
    jsr plot_sprite                     ; Plot the health's tens digit
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    lda hero_health_units,x             ; The units digit sprite...
    sta sprite_number                   ; ...as the sprite to plot
    lda #panel_left + 3                 ; ...three byte columns right of the tens...
    sta plot_x                          ; ...on the same row
    txa                                 ; Keep the hero number...
    pha                                 ; ...across the plot
    jsr plot_sprite                     ; Plot the health's units digit
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    rts                                 ; Return
; ***************************************************************************************
; Add one point to a hero's score
;
; Add one to hero X's score, carrying into the tens and above, and redraw the score in
; the status panel. The score is four digit sprites (thousands to units), with
; add_thousand_points handling the ten-thousands.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &728c referenced 5 times by &0f02, &1d05, &73a9, &76a2, &76d4
.add_point
    inc hero_score_units,x              ; Score up one: the units digit sprite
    lda hero_score_units,x              ; ...and look at the new units digit
    cmp #spr_digit_9 + 1                ; Past the 9 sprite?
    bne draw_score                      ; No: nothing to carry, redraw the score
    lda #spr_digit_0                    ; Yes: units back to 0...
    sta hero_score_units,x              ; ...and carry by falling into add_ten_points
; ***************************************************************************************
; Add ten points to a hero's score
;
; Add ten to hero X's score, carrying into the hundreds and through add_thousand_points,
; and redraw the score. add_point falls into this entry to carry from the units. The
; units digit is left as it is.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &729b referenced 4 times by &737f, &7382, &7419, &74d5
.add_ten_points
    inc hero_score_tens,x               ; Score up ten: the tens digit sprite
    lda hero_score_tens,x               ; ...and look at the new tens digit
    cmp #spr_digit_9 + 1                ; Past the 9 sprite?
    bne draw_score                      ; No: nothing to carry, redraw the score
    lda #spr_digit_0                    ; Yes: tens back to 0...
    sta hero_score_tens,x               ; ...stored for this hero
    inc hero_score_hundreds,x           ; ...and carry into the hundreds
    lda hero_score_hundreds,x           ; ...and look at the new hundreds digit
    cmp #spr_digit_9 + 1                ; Past the 9 sprite?
    bne draw_score                      ; No: redraw the score
    lda #spr_digit_0                    ; Yes: hundreds back to 0...
    sta hero_score_hundreds,x           ; ...stored for this hero
    jsr add_thousand_points             ; ...and carry into the thousands and beyond
; Draw hero X's score, four digit sprites twelve rows below the health.
; &72bc referenced 3 times by &7294, &72a3, &72b2
.draw_score
    clc                                 ; Score: all four digits, twelve rows below the health
    lda hero_panel_y,x                  ; Row: the hero's panel section...
    adc #&0c                            ; ...twelve rows down, below the health
    sta plot_y                          ; ...as the plotting row
    lda #panel_left                     ; Thousands digit in the panel's left column
    sta plot_x                          ; ...as the plotting column
    lda hero_score_thousands,x          ; The thousands digit sprite...
    sta sprite_number                   ; ...as the sprite to plot
    txa                                 ; Keep the hero number...
    pha                                 ; ...across the plot
    jsr plot_sprite                     ; Plot the thousands digit
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    lda hero_score_hundreds,x           ; The hundreds digit sprite...
    sta sprite_number                   ; ...as the sprite to plot
    lda #panel_left + 3                 ; ...three byte columns right (&48)...
    sta plot_x                          ; ...as the plotting column
    txa                                 ; Keep the hero number...
    pha                                 ; ...across the plot
    jsr plot_sprite                     ; Plot the hundreds digit
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    lda hero_score_tens,x               ; The tens digit sprite...
    sta sprite_number                   ; ...as the sprite to plot
    lda #panel_left + 6                 ; ...six byte columns right (&4B)...
    sta plot_x                          ; ...as the plotting column
    txa                                 ; Keep the hero number...
    pha                                 ; ...across the plot
    jsr plot_sprite                     ; Plot the tens digit
    pla                                 ; Recover the hero number...
    tax                                 ; ...into X
    lda hero_score_units,x              ; The units digit sprite...
    sta sprite_number                   ; ...as the sprite to plot
    lda #panel_left + 9                 ; ...nine byte columns right (&4E)...
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
; Plot each of objects 30 to 1, using its type as the sprite, at its cell in every view
; that shows it, with no pixel offset. update_game calls this every frame, before the
; missiles and monsters move, so objects are put back wherever a moving sprite has
; crossed them. An object that has been collected or worn away has map x and y &FF
; (off_map).
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
    lda object_type,x                   ; Its type, which is also its sprite...
    sta sprite_number                   ; ...as the sprite to plot
    txa                                 ; Keep the object number...
    pha                                 ; ...across the plot
    jsr plot_at_cell                    ; Plot it in every view showing its cell
    pla                                 ; Recover the object number...
    tax                                 ; ...into X
    dex                                 ; Next object down
    bne draw_each_object                ; Until object 1 is drawn (object 0 is not drawn)
    rts                                 ; Return
; ***************************************************************************************
; Pick up the object in a hero's cell
;
; Search objects 30 down to 1 for one at hero X's cell and act on the first found.
; move_heroes calls this after drawing a hero who has moved, when object_free_map says
; the cell can hold an object.
;
; Finding any object at all takes off the hero's Boots of Speed and erases the bolt from
; the panel, before the type is looked at, so the boots are lost to a teleporter, a
; drainer or the exit as well as to a pickup. Then, by type: treasure gives 20 points;
; food 10 health (to at most 99) and 5 points; a teleporter moves the hero to the cell
; above the previous teleporter in the list (wrapping from object 1 to 29), with no test
; of that cell, and shows the room; the Cross of Resurrection gives 10 points and starts
; the first hero in returning_hero_queue materialising; the exit is passed over and the
; search goes on; every type from &5F up is a magic item (10 points, then boots, helmet,
; potion, weapons, or otherwise the sword); any other type is taken as an energy drainer,
; which costs 10 health and stays. Treasure, food, the Cross and magic items are removed
; from the level.
;
; On Entry:
;     X: hero number (0-3)
; &7329 referenced 1 time by &70be
.collect_objects
    lda hero_x,x                        ; The hero's cell: map x...
    sta cell_x                          ; ...as the cell to search
    lda hero_y,x                        ; ...and map y...
    sta cell_y                          ; ...likewise
    ldy #max_object                     ; Search from object 30, the exit, down to 1
; &7337 referenced 1 time by &7473
.check_object
    lda object_x,y                      ; Object Y's map x...
    cmp cell_x                          ; ...the hero's column?
    beq check_object_y                  ; Yes: compare the row
    jmp next_object                     ; No: try the next object
; &7342 referenced 1 time by &733d
.check_object_y
    lda object_y,y                      ; Object Y's map y...
    cmp cell_y                          ; ...the hero's row?
    beq object_found                    ; Yes: the hero is on object Y
    jmp next_object                     ; No: try the next object
; &734d referenced 1 time by &7348
.object_found
    tya                                 ; Found: any object at all costs the Boots of Speed
    pha                                 ; Keep the object number...
    lda #0                              ; ...take the boots off...
    sta hero_has_boots,x                ; ...this hero: back to normal speed
    jsr point_at_boots_icon             ; Point at the hero's bolt in the panel...
    jsr erase_boots_icon                ; ...and erase it
    pla                                 ; Recover the object number...
    tay                                 ; ...into Y
    lda object_type,y                   ; The object's type, which is its sprite
    cmp #spr_treasure                   ; Treasure?
    bne check_food                      ; No: try food
    txa                                 ; Treasure: its sound, keeping hero and object
    pha                                 ; Keep the hero...
    tya                                 ; ...and the object...
    pha                                 ; ...across the OSWORD calls
    ldx #<(treasure_envelope)           ; Envelope 3 as the treasure envelope...
    ldy #>(treasure_envelope)           ; ...high byte...
    lda #osword_envelope                ; ...OSWORD 8, ENVELOPE
    jsr osword                          ; ENVELOPE command
    ldx #<(treasure_sound)              ; ...then the treasure sound with it
    ldy #>(treasure_sound)              ; ...high byte...
    lda #osword_sound                   ; ...OSWORD 7, SOUND
    jsr osword                          ; SOUND command
    pla                                 ; Recover the object...
    tay                                 ; ...into Y...
    pla                                 ; ...and the hero...
    tax                                 ; ...into X
    tya                                 ; Treasure is worth 20 points:
    pha                                 ; ...keeping the object number
    jsr add_ten_points                  ; Ten points...
    jsr add_ten_points                  ; ...and ten more
    pla                                 ; Recover the object number...
    tay                                 ; ...into Y
    jmp remove_object                   ; Take the treasure off the level
; &738a referenced 1 time by &7361
.check_food
    cmp #spr_food                       ; Food?
    bne check_teleporter                ; No: try a teleporter
    inc hero_health_tens,x              ; Food: +10 health, one on the tens digit...
    lda hero_health_tens,x              ; ...and look at the new tens digit
    cmp #spr_digit_9 + 1                ; Past the 9 sprite?
    bne redraw_health                   ; No: health is up by 10
    lda #spr_digit_9                    ; Yes: health is capped at 99...
    sta hero_health_tens,x              ; ...tens 9...
    sta hero_health_units,x             ; ...units 9
; &73a0 referenced 1 time by &7396
.redraw_health
    tya                                 ; Show the new health and score 5 points:
    pha                                 ; Keep the object number
    jsr draw_health                     ; Redraw the health in the panel
    ldy #5                              ; Food is worth 5 points
; &73a7 referenced 1 time by &73af
.add_food_points
    tya                                 ; Keep the count of points to add...
    pha                                 ; ...across add_point
    jsr add_point                       ; One point
    pla                                 ; Recover the count...
    tay                                 ; ...into Y
    dey                                 ; One fewer to add
    bne add_food_points                 ; Until all five are added
    txa                                 ; The food sound, keeping the hero
    pha                                 ; Keep the hero across the OSWORD call
    ldx #<(food_sound)                  ; SOUND food_sound...
    ldy #>(food_sound)                  ; ...high byte...
    lda #osword_sound                   ; ...OSWORD 7, SOUND
    jsr osword                          ; SOUND command
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    pla                                 ; Recover the object number...
    tay                                 ; ...into Y
    jmp remove_object                   ; Take the food off the level
; &73c3 referenced 1 time by &738c
.check_teleporter
    cmp #spr_teleporter                 ; Teleporter?
    bne check_cross                     ; No: try the Cross
; &73c7 referenced 2 times by &73d1, &73d6
.find_previous_teleporter
    dey                                 ; Teleporter: search back from it for the previous...
    lda object_type,y                   ; ...object's type...
    cmp #spr_teleporter                 ; ...a teleporter too?
    beq teleport                        ; Yes: it is the destination
    cpy #0                              ; Searched down to object 0?
    bne find_previous_teleporter        ; No: keep looking backwards
    ldy teleport_last                   ; Yes: wrap round to 30, so the search goes on at 29
    jmp find_previous_teleporter        ; ...(the one found may be this teleporter itself)
; Y is the destination teleporter. The hero arrives on the cell above it, whatever is there.
; &73d9 referenced 1 time by &73cd
.teleport
    txa                                 ; The teleport sound, keeping hero and destination
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
    lda object_x,y                      ; Move the hero to the cell above the destination...
    sta hero_x,x                        ; ...the destination's column...
    sta cell_x                          ; ...and cell_x (show_hero_room sets it again)
    lda object_y,y                      ; ...and its row...
    sec                                 ; ...less one...
    sbc #1                              ; ...so the hero does not stand on it and teleport back
    sta hero_y,x                        ; ...as the hero's row (wall or not: it is not tested)
    sta cell_y                          ; ...and cell_y, likewise
    lda #0                              ; Arrive standing still:
    sta hero_step,x                     ; ...not part way through a step
    sta hero_offset_x,x                 ; ...and no pixel offsets...
    sta hero_offset_y,x                 ; ...in either direction
    jmp show_hero_room                  ; Point the hero's view at the room arrived in
; &740d referenced 1 time by &73c5
.check_cross
    cmp #spr_cross                      ; Cross of Resurrection?
    bne check_magic_item                ; No: try the exit, drainers and magic items
    lda #off_map                        ; Cross: take it off the level...
    sta object_x,y                      ; ...off the map in x...
    sta object_y,y                      ; ...and y, even if nobody comes back
    jsr add_ten_points                  ; The Cross is worth 10 points
    txa                                 ; Keep the hero...
    pha                                 ; ...across the sound and the queue
    jsr play_pickup_sound               ; Play the pickup sound
    lda returning_hero_queue            ; First queue entry used (a hero or a &64 marker)?
    bne take_returning_hero             ; Yes: bring back the first hero waiting
    pla                                 ; No: wasted. Recover the hero...
    tax                                 ; ...into X...
    rts                                 ; ...and return
; Bring back the first hero waiting in returning_hero_queue. &64 markers, which stand for heroes left out on the menu, are passed to the back of the queue.
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
    cpx #nobody_returns - 1             ; A &64 marker (a hero absent from the menu)?
    bne check_queue_empty               ; No: a hero, or nobody
    ldy #nobody_returns                 ; Yes: send it to the back and take the next entry
    bne shift_returning_queue           ; ...(always taken)
; &744c referenced 1 time by &7446
.check_queue_empty
    cpx #&ff                            ; Queue empty?
    beq cross_done                      ; Yes: nobody returns
    lda #0                              ; Start hero X materialising: out of play...
    sta hero_direction,x                ; ...direction 0: not in play while the sprites run
    lda #8                              ; ...from the skull back...
    sta hero_frame,x                    ; ...frame 8, the last of hero_appearance_sprites
    lda #&ff                            ; ...stepping backwards...
    sta hero_offset_x,x                 ; ...frame step -1
    lda #1                              ; ...the first step next frame
    sta hero_offset_y,x                 ; ...the frame counter
; &7464 referenced 1 time by &744e
.cross_done
    pla                                 ; Recover the hero who picked up the Cross...
    tax                                 ; ...into X
    rts                                 ; Return
; &7467 referenced 2 times by &7387, &73c0
.remove_object
    lda #off_map                        ; Take object Y off the level:
    sta object_x,y                      ; ...off the map in x...
    sta object_y,y                      ; ...and y, so it is neither drawn nor found again
    rts                                 ; Return
; &7470 referenced 3 times by &733f, &734a, &747d
.next_object
    dey                                 ; Next object down
    beq collect_objects_done            ; Past object 1: nothing in the cell
    jmp check_object                    ; Check this object
; &7476 referenced 1 time by &7471
.collect_objects_done
    rts                                 ; Return
; Not treasure, food, a teleporter or the Cross: the exit, an energy drainer or a magic item, told apart by type ranges alone.
; &7477 referenced 1 time by &740f
.check_magic_item
    cmp #spr_boots                      ; Type &5F or above: a magic item?
    bcs magic_item                      ; Yes: collect the magic item
    cmp #spr_exit                       ; The exit? The main loop deals with it...
    beq next_object                     ; ...so search on for another object in the cell
    lda #&32 ; '2'                      ; Any other type is an energy drainer: pitch &32...
    sta hit_sound + 4                   ; ...instead of 6 in hit_sound, the drainer's noise
    txa                                 ; Keep the hero...
    pha                                 ; ...across the OSWORD call
    ldx #<(hit_sound)                   ; SOUND hit_sound...
    ldy #>(hit_sound)                   ; ...high byte...
    lda #osword_sound                   ; ...OSWORD 7, SOUND
    jsr osword                          ; The drainer's noise:  SOUND command
    lda #6                              ; ...then pitch 6 again...
    sta hit_sound + 4                   ; ...for monster_hit's blow
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    ldy #&0a                            ; The drainer takes 10 health and stays
; &7498 referenced 1 time by &74a0
.take_ten_health
    tya                                 ; Keep the count...
    pha                                 ; ...across lose_health_point
    jsr lose_health_point               ; One point of the hero's health
    pla                                 ; Recover the count...
    tay                                 ; ...into Y
    dey                                 ; One fewer to take
    bne take_ten_health                 ; Until all ten are taken
    rts                                 ; Return
; ***************************************************************************************
; Play the pickup sound
;
; Define envelope 3 as the pickup envelope and play the pickup sound on the noise
; channel, from the OSWORD parameter blocks at &192C and &193A. Envelope 3 is shared with
; the treasure, key and exit sounds, which define their own, so it is defined again each
; time.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &74a3 referenced 2 times by &741e, &74ca
.play_pickup_sound
    ldx #<(pickup_envelope)             ; Envelope 3 as the pickup envelope...
    ldy #>(pickup_envelope)             ; ...high byte...
    lda #osword_envelope                ; ...OSWORD 8, ENVELOPE
    jsr osword                          ; Define it:  ENVELOPE command
    ldx #<(pickup_sound)                ; ...then the pickup sound...
    ldy #>(pickup_sound)                ; ...high byte...
    lda #osword_sound                   ; ...OSWORD 7, SOUND
    jsr osword                          ; Play it:  SOUND command
    rts                                 ; Return
; A magic item, type &5F or above. Each gives 10 points; the type then picks boots, helmet, potion or weapons, and any other type counts as a magic sword.
; &74b6 referenced 1 time by &7479
.magic_item
    sta scratch                         ; A magic item: keep its type for the tests below
    lda #off_map                        ; Take it off the level...
    sta object_x,y                      ; ...off the map in x...
    sta object_y,y                      ; ...and y
    txa                                 ; The pickup sound, keeping the hero
    pha                                 ; Keep the hero across the sound
    lda scratch                         ; A = (type AND 7) x 4: unused, as play_pickup_sound...
    and #7                              ; ...sets its own registers...
    asl a                               ; ...x 2...
    asl a                               ; ...x 4
    jsr play_pickup_sound               ; Play the pickup sound
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    lda hero_score_units,x              ; The score's units digit sprite...
    sta scratch2                        ; ...kept for a potion (add_ten_points leaves it)
    jsr add_ten_points                  ; Every magic item is worth 10 points
    lda scratch                         ; The item's type...
    cmp #spr_boots                      ; ...Boots of Speed?
    bne check_helmet                    ; No: try the helmet
    jsr point_at_boots_icon             ; Boots: point at the hero's bolt in the panel...
    jsr plot_boots_icon                 ; ...and show it
    lda #1                              ; ...and wear them...
    sta hero_has_boots,x                ; ...so the hero moves a whole cell per step
    rts                                 ; Return
; &74eb referenced 1 time by &74dd
.check_helmet
    cmp #spr_helmet                     ; Magic helmet?
    bne check_potion                    ; No: try the potion
    dec hero_damage_taken,x             ; Helmet: one less health lost per hit...
    lda hero_damage_taken,x             ; ...and look at it
    cmp #3                              ; ...below 3 (armour 7, the best)?
    bcs redraw_armour                   ; No: keep it
    inc hero_damage_taken,x             ; Yes: back to 3
; &74fc referenced 1 time by &74f7
.redraw_armour
    jmp draw_armour_rating              ; Redraw the armour rating on the shield
; &74ff referenced 1 time by &74ed
.check_potion
    cmp #spr_potion                     ; Potion of healing?
    bne check_weapons                   ; No: try the weapons
    lda scratch2                        ; Potion: health = the score's last digit twice...
    sta hero_health_tens,x              ; ...as the tens (so a score ending in 0 gives 00)
    inc scratch2                        ; ...and the units one higher...
    lda scratch2                        ; ...the sprite after it...
    sta hero_health_units,x             ; ...as the health's units
    jsr lose_health_point               ; ...less a point, which also draws the health
    rts                                 ; Return
; &7516 referenced 1 time by &7501
.check_weapons
    cmp #spr_weapons                    ; Pile of weapons?
    bne magic_sword                     ; No: anything else is taken as a magic sword
    inc hero_max_missiles,x             ; Weapons: one more missile in flight at once...
    lda hero_max_missiles,x             ; ...and look at it
    cmp #4                              ; ...past 3, the hero's missile slots?
    bne draw_missile_icon               ; No: add its icon to the panel
    lda #3                              ; Yes: back to 3...
    sta hero_max_missiles,x             ; ...as the missiles allowed
; &7529 referenced 1 time by &7522
.draw_missile_icon
    jmp draw_new_missile_icon           ; Draw the newest missile icon
; ***************************************************************************************
; Show the room a hero has moved into
;
; Point hero X's view at the room containing their cell and redraw that view. Each hero
; has a fixed view (0 top left to 3 bottom right); view_room holds a pointer per view
; into room_walls, and only its low byte changes, to the room offset that test_wall
; leaves in map_ptr. move_heroes calls this when a hero steps into another room, and a
; teleporter jumps here after moving the hero.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &752c referenced 2 times by &704d, &740a
.show_hero_room
    lda hero_x,x                        ; The hero's cell, for test_wall to find its room
    sta cell_x                          ; ...as cell_x...
    lda hero_y,x                        ; ...and its map y...
    sta cell_y                          ; ...as cell_y
    txa                                 ; Keep the hero...
    pha                                 ; ...across test_wall
    jsr test_wall                       ; Only for map_ptr: the offset of the cell's room
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    pha                                 ; Keep the hero number across the view draw
    asl a                               ; Hero x 2: their view's entry in view_room...
    tay                                 ; ...two bytes, a pointer into room_walls
    lda map_ptr                         ; The room's offset that test_wall left...
    sta view_room,y                     ; ...becomes the view's room
    cpx #0                              ; Redraw this hero's own view: hero 0's?
    bne check_view_1                    ; No: try hero 1
    jsr draw_view_0                     ; Hero 0: redraw the top-left view
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    rts                                 ; Return
; &7551 referenced 1 time by &7549
.check_view_1
    cpx #1                              ; Hero 1, the top-right view?
    bne check_view_2                    ; No: try hero 2
    jsr draw_view_1                     ; Yes: redraw it
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    rts                                 ; Return
; &755b referenced 1 time by &7553
.check_view_2
    cpx #2                              ; Hero 2, the bottom-left view?
    bne show_view_3                     ; No: hero 3
    jsr draw_view_2                     ; Yes: redraw it
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    rts                                 ; Return
; &7565 referenced 1 time by &755d
.show_view_3
    jsr draw_view_3                     ; Hero 3: redraw the bottom-right view
    pla                                 ; Recover the hero...
    tax                                 ; ...into X
    rts                                 ; Return
; &756b referenced 1 time by &7518
.magic_sword
    inc hero_missile_damage,x           ; Magic sword: one more damage per missile...
    lda hero_missile_damage,x           ; ...and look at it
    cmp #&0a                            ; ...past 9?
    bne draw_missile_damage             ; No: draw the new damage in the panel
    lda #9                              ; Yes: back to 9...
    sta hero_missile_damage,x           ; ...as the missile damage
    bne draw_missile_damage             ; ...and draw it (always taken)
; A missile has hit a live monster: X is the monster, Y the missile slot. Reached by JMP from move_missiles, and leaves by jumping back into it.
; &757c referenced 1 time by &714d
.monster_hit
    txa                                 ; Hit: sound the blow
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
    lda monster_hit_points,x            ; The monster's hit points...
    sec                                 ; ...set the carry for the subtraction...
    sbc missile_damage,y                ; ...less this missile's damage
    bpl store_monster_health            ; 0 or more: alive (0 hit points survives a hit)
    lda #spr_blank                      ; Below 0: killed. Start it dying...
    sta monster_sprite,x                ; ...from the blank sprite through the sparkles
    lda monster_start_hit_points        ; ...and give the slot this level's hit points...
    sta monster_hit_points,x            ; ...ready for when it comes back at a trapdoor
    tya                                 ; Missile slot back in X...
    tax                                 ; ...for monster_killed
    jmp monster_killed                  ; ...a point to its hero, and the missile is spent
; &75a6 referenced 1 time by &7594
.store_monster_health
    sta monster_hit_points,x            ; Alive: store the hit points left
    tya                                 ; Push the missile slot, as missile_spent_pop...
    pha                                 ; ...expects to find it on the stack
    jmp missile_spent_pop               ; The missile is spent: one hit per missile
; Redraw hero X's armour rating after a magic helmet: the small digit 10 - hero_damage_taken on the shield in their panel section.
; &75ae referenced 1 time by &74fc
.draw_armour_rating
    sec                                 ; Armour rating = 10 - health lost per hit, drawn...
    lda hero_panel_y,x                  ; ...on the shield: the hero's panel row...
    sbc #&0c                            ; ...less twelve pixel rows...
    sta plot_y                          ; ...as the plotting row
    lda #panel_left + 9                 ; ...byte column &4E, nine right of the panel's left...
    sta plot_x                          ; ...as the plotting column
    lda #spr_small_digit_1 + 9          ; Small digit 10...
    sec                                 ; ...set the carry for the subtraction...
    sbc hero_damage_taken,x             ; ...less the health lost per hit: 1 to 7
    sta sprite_number                   ; ...as the sprite to plot
    jmp plot_keeping_x                  ; Plot it, keeping X, and return
; Add the icon for hero X's newest missile after a pile of weapons, at the row draw_status_panel would give it (icon n at its row &0D + 3n, which plot_panel_sprite offsets by the panel row - &0E).
; &75c5 referenced 1 time by &7529
.draw_new_missile_icon
    lda hero_max_missiles,x             ; Icon for the newest missile allowed: missiles x 2...
    asl a                               ; ...(the shift)...
    clc                                 ; ...clear the carry for the addition...
    adc hero_max_missiles,x             ; ...+ missiles again: 3 rows per icon...
    adc #&0d                            ; ...+ &0D, as in draw_status_panel's icon rows...
    adc hero_panel_y,x                  ; ...+ the hero's panel row...
    sec                                 ; ...set the carry for the subtraction...
    sbc #&0e                            ; ...- &0E, plot_panel_sprite's bias: the same row
    sta plot_y                          ; ...as the plotting row
    lda #panel_left + 6                 ; ...byte column &4B, the icons' column...
    sta plot_x                          ; ...as the plotting column
    lda #spr_missile_icon               ; The missile icon...
    sta sprite_number                   ; ...as the sprite to plot
    jmp plot_keeping_x                  ; Plot it, keeping X, and return
; Redraw hero X's missile damage after a magic sword, as a small digit four rows above their panel row.
; &75e2 referenced 2 times by &7573, &757a
.draw_missile_damage
    lda #panel_left + 7                 ; Missile damage: byte column &4C...
    sta plot_x                          ; ...as the plotting column
    sec                                 ; ...set the carry for the subtraction...
    lda hero_panel_y,x                  ; ...the hero's panel row...
    sbc #4                              ; ...less four pixel rows...
    sta plot_y                          ; ...as the plotting row
    lda hero_missile_damage,x           ; The damage, 1-9...
    clc                                 ; ...clear the carry for the addition...
    adc #spr_small_digit_1 - 1          ; ...+ one before small digit 1: its small digit
    sta sprite_number                   ; ...as the sprite to plot
    jmp plot_keeping_x                  ; Plot it, keeping X, and return
; ***************************************************************************************
; Set the position of a hero's boots icon
;
; Set plot_x to the panel's column &4A and plot_y to eight pixel rows above hero X's
; panel row (hero_panel_y), where the lightning bolt shows that the hero wears Boots of
; Speed. plot_boots_icon or erase_boots_icon then plots there.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     PLOT_X: &4A
;     PLOT_Y: hero_panel_y - 8
;     X: preserved
; &75f9 referenced 2 times by &7354, &74df
.point_at_boots_icon
    lda #panel_left + 5                 ; The bolt's byte column, &4A...
    sta plot_x                          ; ...as the plotting column
    sec                                 ; ...set the carry for the subtraction...
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
    lda #spr_boots_icon                 ; The lightning bolt: the hero has Boots of Speed...
    sta sprite_number                   ; ...as the sprite to plot
    jmp plot_keeping_x                  ; ...plotted where point_at_boots_icon pointed
; ***************************************************************************************
; Remove a hero's boots icon
;
; Plot the blank sprite over the lightning bolt at plot_x, plot_y.
;
; On Exit:
;     X: preserved
; &760d referenced 1 time by &7357
.erase_boots_icon
    lda #spr_blank_boots_icon           ; The blank: the boots are lost...
    sta sprite_number                   ; ...as the sprite to plot
; &7611 referenced 4 times by &75c2, &75df, &75f6, &760a
.plot_keeping_x
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack: plot_sprite leaves X = 0
    jsr plot_sprite                     ; Plot the icon in the hero's panel section
    pla                                 ; Recover the hero number...
    tax                                 ; ...in X again for the caller
    rts                                 ; Return
; &7619 referenced 1 time by &6ebe
.check_magic
    dec hero_magic_delay,x              ; Count down this hero's magic key delay
    beq check_magic_every_frame         ; Zero: time to look at the magic key
    rts                                 ; Not yet: RTS ends move_heroes; later heroes wait too
; &761f referenced 1 time by &761c
.check_magic_every_frame
    lda #1                              ; Delay 1: the key is read every frame from now on
    sta hero_magic_delay,x              ; ...so the next press is seen at once
    lda hero_magic_key,x                ; This hero's magic key, an INKEY number...
    jsr test_key                        ; ...scanned: Z set if held
    bne no_magic                        ; Not held: read the movement and fire keys
; Cast the magic: play its sound, take the caster's health, then kill every live monster in the room the caster's view shows, a point each.
    txa                                 ; Held: cast. Keep the hero number...
    pha                                 ; ...on the stack: X carries the OSWORD blocks
    ldx #<(magic_envelope)              ; XY = magic_envelope...
    ldy #>(magic_envelope)              ; ...its high byte
    lda #osword_envelope                ; OSWORD 8: define the magic envelope
    jsr osword                          ; ENVELOPE command
    ldx #<(magic_sound)                 ; XY = magic_sound...
    ldy #>(magic_sound)                 ; ...its high byte
    lda #osword_sound                   ; OSWORD 7: make the magic sound
    jsr osword                          ; SOUND command
    pla                                 ; Recover the hero number...
    tax                                 ; ...the caster, in X again
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
    tya                                 ; Pay the cost one health point at a time
    pha                                 ; ...the points left on the stack
    jsr lose_health_point               ; One point off the caster, redrawn (it can kill them)
    pla                                 ; Recover the points left...
    tay                                 ; ...into Y
    dey                                 ; One point fewer to take
    bne take_magic_cost                 ; Until the whole cost is paid
    lda #0                              ; No monsters killed yet
    sta magic_kill_count                ; ...in magic_kill_count
    txa                                 ; The caster's view_room index, 2 x hero...
    asl a                               ; ...x 2: view_room holds two bytes per hero
    sta sprite_number                   ; ...kept in sprite_number, free as scratch here
; Kill every live monster in the caster's room. A monster parked off the map (&FF) is in no room and survives.
    ldx #max_monster                    ; For each monster, 30 to 1...
; &7667 referenced 1 time by &7693
.find_monster_room
    lda monster_x,x                     ; ...find its room from its cell: map x...
    sta cell_x                          ; ...as cell_x...
    lda monster_y,x                     ; ...and map y...
    sta cell_y                          ; ...as cell_y
    txa                                 ; Keep the monster number...
    pha                                 ; ...on the stack across test_wall
    jsr test_wall                       ; test_wall leaves the monster's room in map_ptr
    pla                                 ; Recover the monster number...
    tax                                 ; ...into X
    ldy sprite_number                   ; Y = the caster's view_room index
    lda view_room,y                     ; The room the caster's view shows...
    cmp map_ptr                         ; ...is it the monster's room?
    bne next_monster_magic              ; Another room: the monster is spared
    lda monster_sprite,x                ; Alive? (dying ones are sprite &15 up)
    cmp #spr_blank                      ; Below the first death frame: alive
    bcs next_monster_magic              ; Already dying: not counted again
    lda #spr_blank                      ; Alive: the first death frame, &15...
    sta monster_sprite,x                ; ...and update_monsters plays out its death
    inc magic_kill_count                ; ...a kill to score
; &7692 referenced 2 times by &7681, &7688
.next_monster_magic
    dex                                 ; Next monster
    bne find_monster_room               ; Until monster 1 is done
    lda sprite_number                   ; One point for each monster killed
    lsr a                               ; ...halve the view_room index back to the hero
    tax                                 ; ...X = the caster, who scores the points
    ldy magic_kill_count                ; ...Y = the monsters killed
; &769c referenced 1 time by &76a8
.score_magic_kills
    cpy #0                              ; Any kills left to score?
    beq magic_cast                      ; None left: redraw the caster
    tya                                 ; Keep the kills left...
    pha                                 ; ...on the stack across add_point
    jsr add_point                       ; One point to the caster
    pla                                 ; Recover the kills left...
    tay                                 ; ...into Y
    dey                                 ; One kill fewer to score
    jmp score_magic_kills               ; Score the next
; &76ab referenced 1 time by &762a
.no_magic
    jmp read_hero_keys                  ; No cast: read the movement and fire keys
; &76ae referenced 1 time by &769e
.magic_cast
    jmp draw_moved_hero                 ; Cast: no move this frame; redraw the caster
; ***************************************************************************************
; Give a point to the hero who fired a missile
;
; move_missiles calls this when a missile kills a monster and when it hits an energy
; drainer. The firer is told by the missile's sprite base, as in flip_firer_frame, and
; add_point gives them one point.
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
    pha                                 ; ...on the stack: X becomes the hero
    tya                                 ; The sprite base, to compare
    cmp #spr_arrow_up - 1               ; ...arrows?
    bne owner_fireball                  ; Not arrows: try fireballs
    ldx #0                              ; Arrows: the Ranger, hero 0
    jmp credit_owner                    ; Credit the Ranger
; &76c0 referenced 1 time by &76b9
.owner_fireball
    cmp #spr_fireball_up - 1            ; ...fireballs?
    bne owner_axe                       ; Not fireballs: try axes
    ldx #1                              ; Fireballs: the Magic-User, hero 1
    jmp credit_owner                    ; Credit the Magic-User
; &76c9 referenced 1 time by &76c2
.owner_axe
    cmp #spr_axe_up - 1                 ; ...axes?
    bne owner_sword                     ; Not axes: so it must be swords
    ldx #2                              ; Axes: the Barbarian, hero 2
    jmp credit_owner                    ; Credit the Barbarian
; &76d2 referenced 1 time by &76cb
.owner_sword
    ldx #3                              ; Otherwise swords: the Fighter, hero 3
; &76d4 referenced 3 times by &76bd, &76c6, &76cf
.credit_owner
    jsr add_point                       ; One point to the firer's score
    pla                                 ; Recover the missile slot...
    tax                                 ; ...in X again for move_missiles
    rts                                 ; Return
; ***************************************************************************************
; Animate a hero who is out of play
;
; move_heroes calls this for a hero out of play (direction 0) unless nobody plays them
; (step &63). While out of play, hero_offset_y is a two-frame timer and hero_offset_x the
; step through the sequence.
;
; Every other frame, plot hero_appearance_sprites entry hero_frame at the hero's cell,
; then step hero_frame by hero_offset_x: forwards (+1) for a hero dying, stopping at the
; skull (entry 8), which then stays on the map; backwards (-1) for a hero returning
; through a Cross of Resurrection, from entry 8. A dying hero starts from their walking
; frame (0 or 1), which lose_health_point does not reset, so the first sparkle may be
; skipped. A returning hero is put in play as hero_frame reaches 0, so entry 0 is never
; shown on the way back. They come back facing down with health 32 (set to 33 and drawn
; by taking a point).
;
; On Entry:
;     X: hero number (0-3)
; &76da referenced 1 time by &6e91
.animate_absent_hero
    dec hero_offset_y,x                 ; Every other frame: count down the timer...
    beq absent_frame_due                ; Timer run out: show the next sprite
    rts                                 ; Not yet: nothing to draw this frame
; &76e0 referenced 1 time by &76dd
.absent_frame_due
    lda #2                              ; Restart the two-frame timer...
    sta hero_offset_y,x                 ; ...which an absent hero keeps in hero_offset_y
    jsr get_hero_cell                   ; Plot the current appearance sprite at the hero's cell
    lda #0                              ; No pixel offsets (those bytes hold timer and step)...
    sta plot_offset_x                   ; ...across...
    sta plot_offset_y                   ; ...or down
    lda hero_frame,x                    ; The hero's place in the appearance sequence...
    tay                                 ; ...as an index...
    lda hero_appearance_sprites,y       ; ...picks the sparkle or skull to show
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
    lda #8                              ; Yes: a dead hero stays on the skull
; &770b referenced 1 time by &7707
.check_first_sprite
    cmp #0                              ; Place 0? Only a returning hero gets there
    bne store_hero_frame                ; No: store the new place for the next plot
    lda #5                              ; Yes: back in play before place 0 is shown...
    sta hero_direction,x                ; ...facing down (direction 5)
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
; Plot sprite_number at hero X's cell, shifted by their pixel offsets, in every view that
; shows it. move_heroes calls it with the hero's own sprite; lose_health_point calls it
; with the blank to erase a hero who has just died. cell_x and cell_y are left as
; plot_at_cell leaves them.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &7732 referenced 2 times by &70a4, &7244
.draw_hero
    jsr get_hero_cell                   ; The hero's map cell...
    lda hero_offset_x,x                 ; ...and the pixel offsets of a step in progress
    sta plot_offset_x                   ; ...across...
    lda hero_offset_y,x                 ; ...and down...
    sta plot_offset_y                   ; ...as plot_offset_y
    txa                                 ; Keep the hero number...
    pha                                 ; ...on the stack: each plot leaves X = 0
    jsr plot_at_cell                    ; Plot the hero in every view showing it
    pla                                 ; Recover the hero number...
    tax                                 ; ...in X again for the caller
    rts                                 ; Return
; ***************************************************************************************
; Animate the hero who fired a missile
;
; Toggle the animation frame of the hero whose missile is in slot X, so the hero's sprite
; changes as they throw. move_missiles calls this on a missile's first move, while bit 7
; of its direction still marks it as just fired. The firer is told by the missile's
; sprite base: arrows the Ranger, fireballs the Magic-User, axes the Barbarian, and
; anything else the Fighter.
;
; On Entry:
;     X: missile slot
;
; On Exit:
;     A: corrupted
;     X: preserved
; &7747 referenced 1 time by &70e1
.flip_firer_frame
    lda missile_sprite_base,x           ; Which hero fired it? Its sprite base says
    cmp #spr_arrow_up - 1               ; ...arrows?
    bne firer_fireball                  ; Not arrows: try fireballs
    lda hero_frame                      ; The Ranger's animation frame...
    eor #1                              ; ...flipped between 0 and 1...
    sta hero_frame                      ; ...so the Ranger's sprite changes as they fire
    rts                                 ; Return
; &7757 referenced 1 time by &774c
.firer_fireball
    cmp #spr_fireball_up - 1            ; ...fireballs?
    bne firer_axe                       ; Not fireballs: try axes
    lda hero_frame + 1                  ; The Magic-User's animation frame...
    eor #1                              ; ...flipped between 0 and 1...
    sta hero_frame + 1                  ; ...so the Magic-User's sprite changes as they cast
    rts                                 ; Return
; &7764 referenced 1 time by &7759
.firer_axe
    cmp #spr_axe_up - 1                 ; ...axes?
    bne firer_sword                     ; Not axes: so it must be swords
    lda hero_frame + 2                  ; The Barbarian's animation frame...
    eor #1                              ; ...flipped between 0 and 1...
    sta hero_frame + 2                  ; ...so the Barbarian's sprite changes as they throw
    rts                                 ; Return
; &7771 referenced 1 time by &7766
.firer_sword
    lda hero_frame + 3                  ; Otherwise swords: the Fighter's frame...
    eor #1                              ; ...flipped between 0 and 1...
    sta hero_frame + 3                  ; ...so the Fighter's sprite changes as they throw
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
; Draw the walls and doors of the room each hero's view shows, top left, top right,
; bottom left, bottom right. Called once as a level starts, after the view frames are
; drawn.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &7788 referenced 1 time by &1563
.draw_all_views
    jsr draw_view_0                     ; The Ranger's view, top left
    jsr draw_view_1                     ; The Magic-User's view, top right
    jsr draw_view_2                     ; The Barbarian's view, bottom left
    jsr draw_view_3                     ; The Fighter's view, bottom right
    rts                                 ; Return
; ***************************************************************************************
; Draw the top-left view
;
; Draw the room in hero 0's view, the Ranger's, whose top-left is byte column 1, pixel
; row 1. draw_all_views calls this as a level starts, and show_hero_room when hero 0
; enters another room.
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
    lda #1                              ; Top-left view: pixel row 1...
    sta plot_y                          ; ...as the view's top pixel row
    lda #1                              ; ...byte column 1...
    sta cell_x                          ; ...in cell_x, as draw_room expects
    lda view_room                       ; ...the room the Ranger's view shows
    sta map_ptr                         ; ...whose walls draw_room reads
    jsr draw_room                       ; Draw its walls and doors
    rts                                 ; Return
; ***************************************************************************************
; Draw the top-right view
;
; Draw the room in hero 1's view, the Magic-User's, whose top-left is byte column &23,
; pixel row 1. Called as draw_view_0 is.
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
    lda #1                              ; Top-right view: pixel row 1...
    sta plot_y                          ; ...as the view's top pixel row
    lda #view_right_column              ; ...byte column &23...
    sta cell_x                          ; ...as the view's left screen column
    lda view_room + 2                   ; ...the room the Magic-User's view shows
    sta map_ptr                         ; ...whose walls draw_room reads
    jsr draw_room                       ; Draw its walls and doors
    rts                                 ; Return
; ***************************************************************************************
; Draw the bottom-left view
;
; Draw the room in hero 2's view, the Barbarian's, whose top-left is byte column 1, pixel
; row &67. Called as draw_view_0 is.
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
    lda #view_bottom_row                ; Bottom-left view: pixel row &67...
    sta plot_y                          ; ...as the view's top pixel row
    lda #1                              ; ...byte column 1...
    sta cell_x                          ; ...as the view's left screen column
    lda view_room + 4                   ; ...the room the Barbarian's view shows
    sta map_ptr                         ; ...whose walls draw_room reads
    jsr draw_room                       ; Draw its walls and doors
    rts                                 ; Return
; ***************************************************************************************
; Draw the bottom-right view
;
; Draw the room in hero 3's view, the Fighter's, whose top-left is byte column &23, pixel
; row &67. Called as draw_view_0 is.
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
    lda #view_bottom_row                ; Bottom-right view: pixel row &67...
    sta plot_y                          ; ...as the view's top pixel row
    lda #view_right_column              ; ...byte column &23...
    sta cell_x                          ; ...as the view's left screen column
    lda view_room + 6                   ; ...the room the Fighter's view shows
    sta map_ptr                         ; ...whose walls draw_room reads
    jsr draw_room                       ; Draw its walls and doors
    rts                                 ; Return
    equb &60                            ; Not referenced
; ***************************************************************************************
; Draw a room
;
; Draw the eight rows of walls of the room at &7B, &7C (a pointer into room_walls) with
; its top-left at plot_y and the column in cell_x, a wall block or a blank in every cell,
; then draw the doors. Nothing else in the room is drawn here. The doors go through
; plot_at_cell, so every door is drawn again in every view that shows its room, not just
; in this one.
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
    ldy #0                              ; For each of the room's eight rows of cells...
; &77e4 referenced 1 time by &77fa
.draw_room_walls
    lda (map_ptr),y                     ; ...take its eight wall bits...
    sta scratch                         ; ...in scratch for draw_room_row
    tya                                 ; Keep the row number...
    pha                                 ; ...on the stack across the row
    jsr draw_room_row                   ; ...and draw the row's walls and blanks
    clc                                 ; Twelve pixel rows down
    lda plot_y                          ; Down to the next row of cells...
    adc #&0c                            ; ...each 12 pixel rows tall
    sta plot_y                          ; ...ready for the next row
    pla                                 ; Recover the row number...
    tay                                 ; ...into Y
    iny                                 ; Next row
    cpy #8                              ; All eight rows done?
    bne draw_room_walls                 ; No: draw the next row
    ldx #max_door                       ; Then doors 20 to 1, wherever they are on the map
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
    bne draw_room_doors                 ; Until door 1 is drawn
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
    lda cell_x                          ; Start at the view's left edge
    sta plot_x                          ; ...as the first cell's screen column
    ldx #&80                            ; Bit mask, starting with the leftmost cell
; &7827 referenced 1 time by &784f
.draw_room_cell
    txa                                 ; Keep this cell's bit mask...
    pha                                 ; ...on the stack...
    sta scratch2                        ; ...and in scratch2 for the test
    lda scratch                         ; Wall in this cell?
    and scratch2                        ; ...against the row's wall bits
    beq plot_blank                      ; No: an open cell, blanked
    lda #spr_wall                       ; Yes: plot the wall block (sprite 0)
    sta sprite_number                   ; ...to plot
    jsr plot_sprite                     ; Draw the wall block in this cell
    jmp next_room_cell                  ; On to the next cell
; &783e referenced 1 time by &7832
.plot_blank
    lda #spr_blank                      ; Plot the blank (sprite &15)
    sta sprite_number                   ; ...to plot
    jsr plot_sprite                     ; Clear whatever the view showed there
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
; twelve pixel rows high. Heroes, monsters, missiles, objects, doors and trapdoors are
; all drawn and erased through here (the walls are not), so a cell in a room that two
; heroes share is drawn in both views, and one in a room that no view shows is not drawn
; at all. Only the low byte of each view_room entry is compared.
;
; cell_x and cell_y are overwritten with the position within the room, so a caller that
; needs the map cell again sets them again.
;
; On Entry:
;     CELL_X: map x
;     CELL_Y: map y
;     SPRITE_NUMBER: sprite to plot
;     PLOT_OFFSET_X: byte columns to shift right
;     PLOT_OFFSET_Y: pixel rows to shift down
;
; On Exit:
;     CELL_X: byte column within the room
;     CELL_Y: pixel row within the room
;     CELL_ROOM: the cell's room, as an offset into room_walls
; &7852 referenced 19 times by &11a8, &1200, &1d36, &1ddc, &1e61, &1f6d, &1fb7, &1fec, &7091, &70f9, &7213, &7320, &76f9, &7741, &7817, &79db, &7a07, &7b25, &7b5c
.plot_at_cell
    lda cell_y                          ; Room = (cell_y AND &F8) x 4 + (cell_x AND &F8)...
    and #&f8                            ; ...the room's top row of cells (y AND &F8)
    sta scratch                         ; ...kept to multiply...
    clc                                 ; ...(no carry into the sum)
    adc scratch                         ; ...x 2...
    adc scratch                         ; ...x 3...
    adc scratch                         ; ...x 4: a room row is 32 bytes of room_walls
    sta cell_room                       ; ...where its row of rooms starts, so far
    lda cell_x                          ; Add the room's left column of cells...
    and #&f8                            ; ...cell_x AND &F8: 8 bytes per room across
    adc cell_room                       ; ...giving the room's offset in room_walls
    sta cell_room                       ; ...in cell_room, to match against the views
    lda cell_x                          ; Column within the view = (cell_x AND 7) x 4 + offset_x
    and #7                              ; ...the cell's column within its room...
    asl a                               ; ...x 2...
    asl a                               ; ...x 4: each cell is 4 screen bytes wide
    clc                                 ; ...(no carry)
    adc plot_offset_x                   ; ...plus the sprite's offset in byte columns
    sta cell_x                          ; ...replacing cell_x: the map x is lost
    lda cell_y                          ; Row within the view = (cell_y AND 7) x 12 + offset_y
    and #7                              ; ...the cell's row within its room...
    asl a                               ; ...x 2...
    asl a                               ; ...x 4...
    sta scratch                         ; ...kept...
    asl a                               ; ...x 8...
    clc                                 ; ...(no carry)
    adc scratch                         ; ...+ x 4 = x 12: each cell is 12 rows tall
    adc plot_offset_y                   ; ...plus the sprite's offset in pixel rows
    sta cell_y                          ; ...replacing cell_y: the map y is lost
    lda view_room                       ; The Ranger's view (top left): this room?
    cmp cell_room                       ; ...is it the room of the cell?
    bne check_view_1_room               ; Not shown there: try the top-right view
    clc                                 ; Shown: plot at the view's corner (column 1, row 1)...
    lda #1                              ; ...view's left column, 1...
    adc cell_x                          ; ...plus the column within the room
    sta plot_x                          ; ...as the screen column
    lda #1                              ; ...view's top row, 1...
    adc cell_y                          ; ...plus the row within the room
    sta plot_y                          ; ...as the screen row
    jsr plot_sprite                     ; Draw it in the top-left view
; &78ad referenced 1 time by &7899
.check_view_1_room
    lda view_room + 2                   ; The Magic-User's view (top right): this room?
    cmp cell_room                       ; ...is it the room of the cell?
    bne check_view_2_room               ; Not shown there: try the bottom-left view
    clc                                 ; Shown: plot from column &23, row 1
    lda #view_right_column              ; ...view's left column...
    adc cell_x                          ; ...plus the column within the room
    sta plot_x                          ; ...as the screen column
    lda #1                              ; ...view's top row, 1...
    adc cell_y                          ; ...plus the row within the room
    sta plot_y                          ; ...as the screen row
    jsr plot_sprite                     ; Draw it in the top-right view
; &78c7 referenced 1 time by &78b3
.check_view_2_room
    lda view_room + 4                   ; The Barbarian's view (bottom left): this room?
    cmp cell_room                       ; ...is it the room of the cell?
    bne check_view_3_room               ; Not shown there: try the bottom-right view
    clc                                 ; Shown: plot from column 1, row &67
    lda #1                              ; ...view's left column, 1...
    adc cell_x                          ; ...plus the column within the room
    sta plot_x                          ; ...as the screen column
    lda #view_bottom_row                ; ...view's top row...
    adc cell_y                          ; ...plus the row within the room
    sta plot_y                          ; ...as the screen row
    jsr plot_sprite                     ; Draw it in the bottom-left view
; &78e1 referenced 1 time by &78cd
.check_view_3_room
    lda view_room + 6                   ; The Fighter's view (bottom right): this room?
    cmp cell_room                       ; ...is it the room of the cell?
    bne plot_at_cell_done               ; Not shown there: done
    clc                                 ; Shown: plot from column &23, row &67
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
; leaves &7B, &7C pointing at the cell's room. Heroes, missiles and monsters test the
; cell they are about to enter here; the magic and show_hero_room call it only for the
; room pointer. The bit is also stored in &8F, which no caller reads.
;
; On Entry:
;     CELL_X: map x
;     CELL_Y: map y
;
; On Exit:
;     A: wall bit
;     Y: wall bit
;     Z: set if no wall
;     X: corrupted (the column within the room)
;     MAP_PTR: the cell's room in room_walls
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
    sta victory_pitch                   ; ...a copy in &8F, which no caller reads...
    tay                                 ; ...and in Y, so callers can pull X and test Y
    rts                                 ; Return
; ***************************************************************************************
; Test whether a map cell can hold an object
;
; Return the object_free_map bit for cell cell_x, cell_y: zero if an object may lie
; there. The same calculation as test_wall, on object_free_map at &2100 instead of
; room_walls. A hero who has moved, and a missile, look up the object list only when this
; returns zero. The bit is also stored in &8F, which no caller reads.
;
; On Entry:
;     CELL_X: map x
;     CELL_Y: map y
;
; On Exit:
;     A: map bit
;     Y: map bit
;     Z: set if an object may lie there
;     X: corrupted (the column within the room)
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
    sta victory_pitch                   ; ...a copy in &8F, which no caller reads...
    tay                                 ; ...and in Y, which callers test after pulling X
    rts                                 ; Return
; ***************************************************************************************
; Look for a monster or hero at a cell
;
; Look for a monster, other than monster number scratch, at cell_x, cell_y. If scratch is
; non-zero, also look for a hero there, and if one is found take hero_damage_taken points
; of their health.
;
; A moving hero or missile passes scratch = 0, so only monsters are looked for. A moving
; or reappearing monster passes its own number, so it skips itself and also finds heroes:
; a monster that walks onto a hero hurts them and is blocked. Neither search looks at
; state: a dying monster still fills its cell, and a hero out of play (a skull) blocks a
; monster too, though lose_health_point takes nothing from them.
;
; On Entry:
;     SCRATCH: the monster moving (1-30), or 0
;     CELL_X: map x
;     CELL_Y: map y
;
; On Exit:
;     A: cell_y if a monster was found, 1 if a hero, else 0
;     Y: cell_y if a monster was found, else 0
;     X: the monster or hero found
; &7974 referenced 4 times by &6fdc, &713f, &7a8c, &7ce6
.find_creature
    ldx #max_monster                    ; Monsters 30 to 1, alive or dying...
; &7976 referenced 1 time by &798e
.check_monster
    cpx scratch                         ; ...except the one being moved (scratch)
    beq next_monster_find               ; The mover itself: skip it
    lda cell_x                          ; The cell's map x...
    cmp monster_x,x                     ; ...this monster's x?
    bne next_monster_find               ; No: not this monster
    lda cell_y                          ; ...and its map y...
    cmp monster_y,x                     ; ...this monster's y?
    bne next_monster_find               ; No: not this monster
    tay                                 ; Found: Y = A = cell_y, X = the monster
    rts                                 ; ...so the caller sees the cell taken
; &798d referenced 3 times by &7979, &7981, &7989
.next_monster_find
    dex                                 ; Next monster
    bne check_monster                   ; Until monster 1 is done
    lda scratch                         ; No monster. A monster moving (scratch > 0)?
    beq nothing_found                   ; No, a hero or missile: heroes don't count
    ldx #0                              ; Yes: look at heroes 0 to 3 too...
; &7997 referenced 1 time by &79ba
.check_hero
    lda cell_x                          ; ...the cell's map x...
    cmp hero_x,x                        ; ...this hero's x?
    bne next_hero_find                  ; No: not this hero
    lda cell_y                          ; ...and its map y...
    cmp hero_y,x                        ; ...this hero's y?
    bne next_hero_find                  ; No: not this hero
    ldy hero_damage_taken,x             ; Yes, in play or not: their armour sets the damage
; &79aa referenced 1 time by &79b2
.take_hero_damage
    tya                                 ; Keep the points still to take...
    pha                                 ; ...on the stack
    jsr lose_health_point               ; One point off the hero (none if out of play)
    pla                                 ; Recover the points still to take...
    tay                                 ; ...into Y
    dey                                 ; One point fewer to take
    bne take_hero_damage                ; Until the hero has taken them all
    lda #1                              ; Return A = 1 (Y = 0): a hero was there
    rts                                 ; ...so the monster is blocked or parked
; &79b7 referenced 2 times by &799d, &79a5
.next_hero_find
    inx                                 ; Next hero
    cpx #4                              ; All four heroes checked?
    bne check_hero                      ; No: check the next
; &79bc referenced 1 time by &7993
.nothing_found
    lda #0                              ; Nothing there: return A = Y = 0
    ldy #0                              ; ...the cell is free of creatures
    rts                                 ; Return
; ***************************************************************************************
; Draw the trapdoors and move the monsters
;
; Draw the eight trapdoors, then for each monster continue its step or start a new one,
; turning a random way when it is blocked, and advance dying monsters until they reappear
; at a trapdoor. The trapdoors are redrawn every frame, because erasing a creature or
; missile that has crossed one blanks its cell.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &79c1 referenced 1 time by &1ed4
.update_monsters
    ldx #8                              ; Redraw trapdoors 8 to 1 (sprite &2C)...
    lda #0                              ; Trapdoors sit squarely in their cells:
    sta plot_offset_x                   ; ...no horizontal offset...
    sta plot_offset_y                   ; ...and no vertical offset
    lda #spr_trapdoor                   ; The trapdoor sprite...
    sta sprite_number                   ; ...the same for all eight
; &79cd referenced 1 time by &79e1
.draw_trapdoor
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
    bne draw_trapdoor                   ; Until trapdoor 1 is drawn
    ldx #max_monster                    ; Then each monster, 30 to 1...
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
    sta plot_offset_x                   ; ...for the erase
    lda monster_offset_y,x              ; ...and its vertical offset...
    sta plot_offset_y                   ; ...so the blank covers it where it was drawn
    jsr plot_at_cell                    ; Rub the monster out in every view showing it
    pla                                 ; The monster number back from the stack...
    pha                                 ; ...left there for monster_done
    tax                                 ; ...in X again
    lda monster_sprite,x                ; Is the monster dying?
    cmp #spr_blank                      ; Sprite &15 (the blank) and up: killed
    bcc check_monster_step              ; Below &15: alive, so it moves
    jmp advance_dying_monster           ; Killed: show its next sparkle
; &7a17 referenced 1 time by &7a12
.check_monster_step
    lda monster_step,x                  ; Part way through a step?
    beq start_monster_move              ; No: try a step to the next cell
    jsr continue_monster_step           ; Yes: slide it a quarter cell further
    pla                                 ; Drop the stacked number (X still has it)...
    jmp draw_monster                    ; ...as draw_monster pushes it again
; A monster that is not stepping tries the next cell the way it faces. A wall or a creature there (a hero there is hurt) keeps it where it is and turns it a random way to try next frame. Otherwise the step goes ahead: monster_x and monster_y keep the old cell and the offsets carry the sprite across over four frames.
; &7a23 referenced 1 time by &7a1a
.start_monster_move
    lda monster_sprite,x                ; Step into the next cell in the way it faces: up...
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
    jsr start_monster_step              ; First quarter-cell offsets of the step
    lda monster_x,x                     ; Is the new cell a wall (or a closed door)?
    sta cell_x                          ; ...the new x as cell_x
    lda monster_y,x                     ; The new y...
    sta cell_y                          ; ...as cell_y
    jsr test_wall                       ; Z set if the cell is open
    beq check_monster_blocked           ; Open: is a creature in the way?
    pla                                 ; Wall: the monster stays where it is...
    tax                                 ; ...its number back in X, which test_wall changed
    lda previous_x                      ; The cell it was in...
    sta monster_x,x                     ; ...back in monster_x
    lda previous_y                      ; ...and its row...
    sta monster_y,x                     ; ...back in monster_y
    lda #0                              ; No step under way:
    sta monster_step,x                  ; ...step count 0
    sta monster_offset_x,x              ; ...no horizontal offset
    sta monster_offset_y,x              ; ...no vertical offset
    lda system_via_t1c_l                ; Turn a random way, from the System VIA's timer
    and #7                              ; A random 0-7...
    clc                                 ; ...plus 8...
    adc #8                              ; ...a sprite &08-&0F
    sta monster_sprite,x                ; Face the monster that way
    and #1                              ; Odd sprites (9, &0B, &0D, &0F) are the facings
    beq turn_monster                    ; Even: round it up to the next facing
    jmp draw_monster                    ; Odd: draw it; it tries the new way next frame
; &7a81 referenced 1 time by &7a7c
.turn_monster
    inc monster_sprite,x                ; Round up: each way is equally likely, 2 in 8
    jmp draw_monster                    ; Draw it; it tries the new way next frame
; &7a87 referenced 1 time by &7a54
.check_monster_blocked
    pla                                 ; Monster or hero in the new cell? (a hero there is hurt)
    pha                                 ; ...left stacked for later
    sta scratch                         ; Non-zero scratch: skip this monster, check heroes
    jsr find_creature                   ; A = 0 if no creature is at cell_x, cell_y
    cmp #0                              ; Anything there?
    beq monster_vertical                ; No: the cell is free, so the step goes ahead
    pla                                 ; Yes: stay put, with no step, and turn a random way
    tax                                 ; ...its number back in X, which find_creature changed
    lda previous_x                      ; The cell it was in...
    sta monster_x,x                     ; ...back in monster_x
    lda previous_y                      ; ...and its row...
    sta monster_y,x                     ; ...back in monster_y
    lda #0                              ; No step under way:
    sta monster_step,x                  ; ...step count 0
    sta monster_offset_x,x              ; ...no horizontal offset
    sta monster_offset_y,x              ; ...no vertical offset
    lda system_via_t1c_l                ; Turn a random way, from the System VIA's timer
    and #7                              ; A random 0-7...
    clc                                 ; ...plus 8...
    adc #8                              ; ...a sprite &08-&0F
    sta monster_sprite,x                ; Face the monster that way
    and #1                              ; Odd sprites (9, &0B, &0D, &0F) are the facings
    bne draw_monster                    ; Odd: draw it; it tries the new way next frame
    inc monster_sprite,x                ; Even: round it up to the next facing
    jmp draw_monster                    ; Draw it; it tries the new way next frame
; A step into a cell on a room's edge row (moving up or down) or edge column (moving across) is made at once, with no slide, so the sprite is never drawn part way between two rooms.
; &7ac1 referenced 1 time by &7a91
.monster_vertical
    pla                                 ; The step goes ahead...
    tax                                 ; ...its number back in X, which find_creature changed
    lda monster_sprite,x                ; Which way is it going?
    cmp #spr_monster_up_0               ; Facing up?
    beq check_room_edge                 ; Yes: check the new row
    cmp #spr_monster_down_0             ; Facing down?
    beq check_room_edge                 ; Yes: check the new row
    lda monster_x,x                     ; Across: is the new cell in a room's edge column?
    and #7                              ; Column within its eight-cell room
    beq monster_at_edge                 ; Column 0: the left edge
    cmp #7                              ; Column 7, the right edge?
    beq monster_at_edge                 ; Yes: an edge
    jmp monster_move_on                 ; No: slide there over the coming frames
; &7adc referenced 2 times by &7ac8, &7acc
.check_room_edge
    lda monster_y,x                     ; Up or down: is the new cell in a room's edge row?
    and #7                              ; Row within its eight-cell room
    beq monster_at_edge                 ; Row 0: the top edge
    cmp #7                              ; Row 7, the bottom edge?
    beq monster_at_edge                 ; Yes: an edge
    jmp monster_move_on                 ; No: slide there over the coming frames
; &7aea referenced 4 times by &7ad3, &7ad7, &7ae1, &7ae5
.monster_at_edge
    lda #0                              ; Edge: jump straight in, so no slide crosses rooms
    sta monster_step,x                  ; ...step count 0
    sta monster_offset_x,x              ; ...no horizontal offset
    sta monster_offset_y,x              ; ...no vertical offset
    jmp draw_monster                    ; Draw it squarely in the new cell
; &7af8 referenced 2 times by &7ad9, &7ae7
.monster_move_on
    lda previous_x                      ; Slide: keep the old cell until the step ends...
    sta monster_x,x                     ; ...back in monster_x
    lda previous_y                      ; ...and its row...
    sta monster_y,x                     ; ...back in monster_y: drawn offset from there
; &7b04 referenced 6 times by &7a20, &7a7e, &7a84, &7ab9, &7abe, &7af5
.draw_monster
    lda monster_x,x                     ; Draw it: its cell, facing + frame, offsets
    sta cell_x                          ; ...as cell_x
    lda monster_y,x                     ; Its row...
    sta cell_y                          ; ...as cell_y
    clc                                 ; Ready to add the frame
    lda monster_sprite,x                ; Its facing sprite...
    adc monster_frame,x                 ; ...plus walking frame 0 or 1...
    sta sprite_number                   ; ...is the sprite to plot
    lda monster_offset_x,x              ; How far it has slid across...
    sta plot_offset_x                   ; ...as the horizontal offset
    lda monster_offset_y,x              ; How far it has slid down...
    sta plot_offset_y                   ; ...as the vertical offset
    txa                                 ; Keep the monster number...
    pha                                 ; ...across the plot, which changes X
    jsr plot_at_cell                    ; Draw it in every view whose room shows it
; &7b28 referenced 3 times by &7b5f, &7cf8, &7cfb
.monster_done
    pla                                 ; The monster number back from the stack...
    tax                                 ; ...in X
    dex                                 ; Next monster down
    beq update_monsters_done            ; Past monster 1: all 30 updated
    jmp next_monster_update             ; Otherwise update the next one
; &7b30 referenced 1 time by &7b2b
.update_monsters_done
    rts                                 ; Return
; A killed monster is set to sprite &15 (the blank). Each frame the sprite advances, showing the sparkles &16-&19 at the cell and offsets it died at; after the last the monster reappears.
; &7b31 referenced 1 time by &7a14
.advance_dying_monster
    pla                                 ; Drop the stacked number (X still has it)
    inc monster_sprite,x                ; Next death frame: &16-&19 are the sparkles
    lda monster_sprite,x                ; Which frame now?
    cmp #spr_sparkle_3 + 1              ; Past the last sparkle (&19)?
    bne draw_monster_death              ; No: draw this sparkle
    jmp monster_reappears               ; Yes: bring it back at a trapdoor
; &7b3f referenced 1 time by &7b3a
.draw_monster_death
    txa                                 ; Draw the sparkle where the monster died...
    pha                                 ; ...keeping the monster number across the plot
    lda monster_x,x                     ; Its cell...
    sta cell_x                          ; ...as cell_x
    lda monster_y,x                     ; ...and row...
    sta cell_y                          ; ...as cell_y
    lda monster_sprite,x                ; The sparkle sprite, with no walking frame...
    sta sprite_number                   ; ...is the sprite to plot
    lda monster_offset_x,x              ; Offsets frozen at the moment it died...
    sta plot_offset_x                   ; ...across
    lda monster_offset_y,x              ; ...and down
    sta plot_offset_y                   ; ...so it sparkles exactly where it died
    jsr plot_at_cell                    ; Draw the sparkle in every view showing it
    jmp monster_done                    ; Pull the monster number and on to the next
; ***************************************************************************************
; Start a hero's step between cells
;
; Called by move_heroes when a direction key starts a move. Set hero X's step counter to
; 1 and their pixel offsets to half a cell in the direction they face: 6 rows up or down,
; or 2 byte columns left or right. move_heroes then draws the hero there, half way to the
; next cell, for one frame.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &7b62 referenced 4 times by &6ece, &6ee1, &6ef4, &6f07
.start_hero_step
    lda #1                              ; One frame to go before the hero is in the new cell
    sta hero_step,x                     ; ...as hero_step: continue_hero_step ends it
    lda hero_direction,x                ; Draw the hero half a cell along the way they face
    cmp #1                              ; Facing up?
    bne hero_step_right                 ; No: try right
    lda #0                              ; Up: not across...
    sta hero_offset_x,x                 ; ...no horizontal offset
    lda #&fa                            ; -6: half a 12-row cell up...
    sta hero_offset_y,x                 ; ...as the vertical offset
    rts                                 ; Return
; &7b79 referenced 1 time by &7b6c
.hero_step_right
    cmp #3                              ; Facing right?
    bne hero_step_down                  ; No: try down
    lda #0                              ; Right: not up or down...
    sta hero_offset_y,x                 ; ...no vertical offset
    lda #2                              ; +2: half a 4-byte cell right...
    sta hero_offset_x,x                 ; ...as the horizontal offset
    rts                                 ; Return
; &7b88 referenced 1 time by &7b7b
.hero_step_down
    cmp #5                              ; Facing down?
    bne hero_step_left                  ; No: they face left
    lda #0                              ; Down: not across...
    sta hero_offset_x,x                 ; ...no horizontal offset
    lda #6                              ; +6: half a cell down...
    sta hero_offset_y,x                 ; ...as the vertical offset
    rts                                 ; Return
; &7b97 referenced 1 time by &7b8a
.hero_step_left
    lda #0                              ; Left: not up or down...
    sta hero_offset_y,x                 ; ...no vertical offset
    lda #&fe                            ; -2: half a cell left...
    sta hero_offset_x,x                 ; ...as the horizontal offset
    rts                                 ; Return
; ***************************************************************************************
; Continue a hero's step between cells
;
; Called by move_heroes on the frame after a step starts. Toggle hero X's animation frame
; and count down their step. When it ends, move the hero one cell in the direction they
; face and clear the pixel offsets. The offsets are then doubled. Since start_hero_step
; sets the counter to 1 and nothing else gives an in-play hero a non-zero step, the step
; always ends here, so the doubling only ever doubles zero offsets.
;
; On Entry:
;     X: hero number (0-3)
;
; On Exit:
;     X: preserved
; &7ba2 referenced 1 time by &6eb4
.continue_hero_step
    lda hero_frame,x                    ; Swap the hero's walking frame...
    eor #1                              ; ...0 to 1 or 1 to 0...
    sta hero_frame,x                    ; ...so their legs move
    dec hero_step,x                     ; One frame fewer to the new cell
    bne double_offsets                  ; Not there yet (never taken: the step is 1)
    lda hero_direction,x                ; Arrived: move their cell on the way they face: up...
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
    lda #0                              ; Drawn squarely in the new cell:
    sta hero_offset_x,x                 ; ...no horizontal offset
    sta hero_offset_y,x                 ; ...no vertical offset
; &7bd6 referenced 1 time by &7bad
.double_offsets
    clc                                 ; Double the offsets, which are always zero by now
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
; Called by update_monsters as a monster starts a move. Set monster X's step counter to 3
; and its offsets to the first quarter of a cell in the direction it faces: 3 rows up or
; down, or one byte column left or right.
;
; On Entry:
;     X: monster number
;
; On Exit:
;     X: preserved
; &7beb referenced 1 time by &7a42
.start_monster_step
    lda #3                              ; Three more frames to reach the new cell...
    sta monster_step,x                  ; ...as the step count
    lda monster_sprite,x                ; Draw it a quarter cell along the way it faces: up...
    cmp #spr_monster_up_0               ; Facing up?
    bne monster_step_right              ; No: try right
    lda #0                              ; Up: not across...
    sta monster_offset_x,x              ; ...no horizontal offset
    lda #&fd                            ; -3: a quarter of a 12-row cell up...
    sta monster_offset_y,x              ; ...as the vertical offset
    rts                                 ; Return
; &7c02 referenced 1 time by &7bf5
.monster_step_right
    cmp #spr_monster_right_0            ; Facing right?
    bne monster_step_down               ; No: try down
    lda #0                              ; Right: not up or down...
    sta monster_offset_y,x              ; ...no vertical offset
    lda #1                              ; +1: a quarter of a 4-byte cell right...
    sta monster_offset_x,x              ; ...as the horizontal offset
    rts                                 ; Return
; &7c11 referenced 1 time by &7c04
.monster_step_down
    cmp #spr_monster_down_0             ; Facing down?
    bne monster_step_left               ; No: it faces left
    lda #0                              ; Down: not across...
    sta monster_offset_x,x              ; ...no horizontal offset
    lda #3                              ; +3: a quarter of a cell down...
    sta monster_offset_y,x              ; ...as the vertical offset
    rts                                 ; Return
; &7c20 referenced 1 time by &7c13
.monster_step_left
    lda #0                              ; Left: not up or down...
    sta monster_offset_y,x              ; ...no vertical offset
    lda #&ff                            ; -1: a quarter of a cell left...
    sta monster_offset_x,x              ; ...as the horizontal offset
    rts                                 ; Return
; ***************************************************************************************
; Continue a monster's step between cells
;
; Called by update_monsters each frame while monster X's step is under way. Toggle its
; frame and count down its step. On the first two calls, grow the offsets by another
; quarter of a cell (a byte column or three rows), to a half and three quarters. On the
; third the step ends: the monster moves one cell on and its offsets are cleared. A
; monster so crosses a cell in four frames.
;
; On Entry:
;     X: monster number
;
; On Exit:
;     X: preserved
; &7c2b referenced 1 time by &7a1c
.continue_monster_step
    lda monster_frame,x                 ; Swap the monster's walking frame...
    eor #1                              ; ...0 to 1 or 1 to 0...
    sta monster_frame,x                 ; ...so its legs move as it slides
    dec monster_step,x                  ; One frame fewer to the new cell
    bne grow_offset_x                   ; Not there yet: slide a quarter cell further
    lda monster_sprite,x                ; Arrived: move its cell on the way it faces: up...
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
    lda #0                              ; Drawn squarely in the new cell:
    sta monster_offset_x,x              ; ...no horizontal offset
    sta monster_offset_y,x              ; ...no vertical offset (zeros don't grow)
; &7c5f referenced 1 time by &7c36
.grow_offset_x
    lda monster_offset_x,x              ; Slide across a further quarter cell (a byte column)
    beq grow_offset_y                   ; Zero: moving up or down, or arrived
    bpl grow_offset_x_right             ; Positive: moving right
    dec monster_offset_x,x              ; Negative: one more column left
    jmp grow_offset_y                   ; Now the vertical offset
; &7c6c referenced 1 time by &7c64
.grow_offset_x_right
    inc monster_offset_x,x              ; One more column right
; &7c6f referenced 2 times by &7c62, &7c69
.grow_offset_y
    lda monster_offset_y,x              ; Slide down or up a further quarter cell (3 rows)
    beq monster_step_done               ; Zero: moving across, or arrived
    bpl grow_offset_y_down              ; Positive: moving down
    sec                                 ; Moving up: three more rows up...
    lda monster_offset_y,x              ; ...from the vertical offset...
    sbc #3                              ; ...less three...
    sta monster_offset_y,x              ; ...to -6 or -9
    jmp monster_step_done               ; Done
; &7c82 referenced 1 time by &7c74
.grow_offset_y_down
    clc                                 ; Moving down: three more rows down...
    lda monster_offset_y,x              ; ...from the vertical offset...
    adc #3                              ; ...plus three...
    sta monster_offset_y,x              ; ...to 6 or 9
; &7c8b referenced 2 times by &7c72, &7c7f
.monster_step_done
    rts                                 ; Return
    equb &de, &35, &0d, &bd, &35, &0d, &d0, &00
    equb &60                            ; Not referenced
; ***************************************************************************************
; Test whether a key is pressed
;
; Scan the key whose negative INKEY number is in A with OSBYTE &81 (Y = &FF), which
; returns X = Y = &FF if it is held. move_heroes uses it for each hero's direction and
; fire keys, and check_magic for the magic keys.
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
    tay                                 ; Park the INKEY number in Y for a moment
    txa                                 ; Keep the caller's X (the hero number)...
    pha                                 ; ...on the stack, as OSBYTE returns in X
    tya                                 ; The INKEY number...
    tax                                 ; ...in X, as OSBYTE &81 wants it
    lda #osbyte_inkey                   ; OSBYTE &81 with Y = &FF: scan the key
    ldy #&ff                            ; Y = &FF: scan the one key, not wait
    jsr osbyte                          ; Scan it: X = Y = &FF if the hero's key is held  Test whether the key with negative INKEY number X is pressed
    cpy #&ff                            ; Held only if both Y and X come back &FF
    bne key_not_pressed                 ; Y not &FF: the key is up
    cpx #&ff                            ; X = &FF too?
    bne key_not_pressed                 ; No: the key is up
    pla                                 ; Held: the caller's X back from the stack...
    tax                                 ; ...the hero number again
    lda #0                              ; A = 0, Z set: the key is held
    rts                                 ; Return
; &7cae referenced 2 times by &7ca3, &7ca7
.key_not_pressed
    pla                                 ; Up: the caller's X back from the stack...
    tax                                 ; ...the hero number again
    lda #1                              ; A = 1, Z clear: the key is up
    rts                                 ; Return
; The monster comes back facing up on the next trapdoor in turn. It is not drawn until next frame. The creature test that follows reads cell_x and cell_y, which still hold the dying monster's position within its view, as the erase's plot_at_cell left them, not the trapdoor's cell. So a creature already on the trapdoor does not stop the monster emerging; one that happens to stand at the unrelated cell the leftovers name parks the monster at &FF,&FF, still alive, where nothing returns it to a trapdoor (and a hero there is hurt).
; &7cb3 referenced 1 time by &7b3c
.monster_reappears
    inc next_trapdoor                   ; Each reappearance uses the next trapdoor in turn
    lda next_trapdoor                   ; Which trapdoor now?
    cmp #8                              ; Past the eighth (7)?
    bne emerge_at_trapdoor              ; No: emerge there
    lda #0                              ; Yes: wrap round to trapdoor 0...
    sta next_trapdoor                   ; ...for this monster and the next
; &7cc2 referenced 1 time by &7cbb
.emerge_at_trapdoor
    ldy next_trapdoor                   ; Y = the trapdoor to emerge from
    lda trapdoor_x,y                    ; Put the monster on it, facing up, with no step
    sta monster_x,x                     ; ...the trapdoor's x as the monster's
    lda trapdoor_y,y                    ; The trapdoor's y...
    sta monster_y,x                     ; ...as the monster's
    lda #spr_monster_up_0               ; Facing up (sprite 9)...
    sta monster_sprite,x                ; ...ends the death: alive again, drawn next frame
    lda #0                              ; No step under way:
    sta monster_step,x                  ; ...step count 0
    sta monster_offset_x,x              ; ...no horizontal offset
    sta monster_offset_y,x              ; ...no vertical offset
    txa                                 ; Test for a creature at cell_x, cell_y...
    pha                                 ; ...stacking the number for monster_done
    stx scratch                         ; Non-zero scratch: skip this monster, check heroes
    jsr find_creature                   ; cell_x/y: plot_at_cell's leftovers, not the trapdoor
    cmp #0                              ; A = 0 if nothing is at that cell
    beq emerge_done                     ; Nothing there: the monster stays on the trapdoor
    pla                                 ; Something there: park it off the map, still alive
    pha                                 ; ...keeping it stacked for monster_done
    tax                                 ; ...its number in X, which find_creature changed
    lda #off_map                        ; Off the map...
    sta monster_x,x                     ; ...as its x
    sta monster_y,x                     ; ...and its y: no trapdoor will take it back
    jmp monster_done                    ; Pull the monster number and on to the next
; &7cfb referenced 1 time by &7ceb
.emerge_done
    jmp monster_done                    ; Pull the monster number and on to the next
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
    equb spr_digit_9 + 1, spr_digit_9 + 1, spr_digit_9 + 1, spr_digit_9 + 1  ; hero_health_units: ...9 + 1: health 99 once a point is taken
    equb &18, &bd, &08, &0d, &6d, &40, &0d  ; Copied to &0D99: no variable starts here
    equb <(room_walls + &28), >(room_walls + &28), <(room_walls + &28), >(room_walls + &28), <(room_walls + &28), >(room_walls + &28), <(room_walls + &28), >(room_walls + &28)  ; view_room: every view starts on the heroes' room, &0C28
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
    tya                                 ; ...and the caller's Y
    pha                                 ; ...on the stack: OSWRCH must preserve both
    lda plot_x                          ; Classify the character by range
    cmp #'0'                            ; Below '0'?
    bcc pass_character                  ; Controls, space, punctuation: the MOS font
    cmp #':'                            ; '0'-'9'?
    bcc digit_glyph                     ; A digit: use the game's digit glyph
    cmp #'A'                            ; ':'-'@'?
    bcc pass_character                  ; Punctuation: the MOS font
    cmp #'['                            ; 'A'-'Z'?
    bcc capital_letter                  ; A capital: use the game's letter glyph
    cmp #'a'                            ; '['-'`'?
    bcc pass_character                  ; Punctuation: the MOS font
    cmp #'{'                            ; Beyond 'z'?
    bcs pass_character                  ; '{' and above: the MOS font
    sec                                 ; Lower case: letter number 0-25...
    sbc #'a'                            ; ...so it is drawn with the capital's glyph
    jmp glyph_offset                    ; Join the capitals' path
; &7fb5 referenced 1 time by &7fa5
.capital_letter
    sec                                 ; Capital: letter number 0-25...
    sbc #'A'                            ; ...0 for 'A'
; &7fb8 referenced 1 time by &7fb2
.glyph_offset
    asl a                               ; x 2: eight bytes a glyph in font_letters...
    asl a                               ; ...x 4...
    asl a                               ; ...x 8: the glyph's offset (at most 200)
    bne copy_glyph                      ; Branch to the next instruction either way
; &7fbd referenced 1 time by &7fbb
.copy_glyph
    tax                                 ; X indexes the glyph in font_letters
    clc                                 ; End offset = start + 8...
    adc #8                              ; ...one glyph's eight rows...
    sta plot_x                          ; ...in plot_x, the character no longer needed
    ldy #0                              ; Y indexes character 128's definition at &0C00
; &7fc5 referenced 1 time by &7fcf
.copy_letter_glyph
    lda font_letters,x                  ; Copy a row of the letter's glyph...
    sta room_walls,y                    ; ...over character 128's definition
    iny                                 ; Next row of character 128
    inx                                 ; Next row of the glyph
    cpx plot_x                          ; All eight rows copied?
    bne copy_letter_glyph               ; No: copy the next row
; &7fd1 referenced 1 time by &7ff4
.restore_registers
    pla                                 ; Restore the caller's Y...
    tay                                 ; ...from the stack
    pla                                 ; ...and the caller's X
    tax                                 ; ...from the stack
    lda #&80                            ; Character 128, which now looks like the glyph...
    jmp mos120_oswrch_default           ; ...printed by the MOS 1.20 OSWRCH routine itself
; &7fda referenced 1 time by &7f9d
.digit_glyph
    sec                                 ; Digit: digit number 0-9...
    sbc #'0'                            ; ...0 for '0'
    asl a                               ; x 2: eight bytes a glyph in font_digits...
    asl a                               ; ...x 4...
    asl a                               ; ...x 8: the glyph's offset
    tax                                 ; X indexes the glyph in font_digits
    clc                                 ; End offset = start + 8...
    adc #8                              ; ...one glyph's eight rows...
    sta plot_x                          ; ...in plot_x, the character no longer needed
    ldy #0                              ; Y indexes character 128's definition at &0C00
; &7fe8 referenced 1 time by &7ff2
.copy_digit_glyph
    lda font_digits,x                   ; Copy a row of the digit's glyph...
    sta room_walls,y                    ; ...over character 128's definition
    iny                                 ; Next row of character 128
    inx                                 ; Next row of the glyph
    cpx plot_x                          ; All eight rows copied?
    bne copy_digit_glyph                ; No: copy the next row
    beq restore_registers               ; Done (always taken): print character 128
; &7ff6 referenced 4 times by &7f99, &7fa1, &7fa9, &7fad
.pass_character
    pla                                 ; Not a letter or digit: restore the caller's Y...
    tay                                 ; ...from the stack
    pla                                 ; ...and the caller's X
    tax                                 ; ...from the stack
    lda plot_x                          ; The character, unchanged, from plot_x...
    jmp mos120_oswrch_default           ; ...printed by the MOS 1.20 OSWRCH routine itself
    equb &00                            ; Not referenced
.dasmos_dunj2_end

    org &c500

.dasmos_code_start
; ***************************************************************************************
; BYTEV handler: read a joystick for the Barbarian's keys
;
; Installed on BYTEV by Coder2. Answers test_key's OSBYTE &81 scans of the Barbarian's
; (hero 2's) keys from the analogue port, so that a joystick plays the Barbarian: left (N
; &AA) and right (M &9A) from channel 1, up (G &AC) and down (B &9B) from channel 2, and
; fire (SPACE &9D) from either fire button. A direction counts only at the stick's
; extreme, when the channel's high byte is &FF or 0. Every other call goes to the MOS
; 3.20 OSBYTE routine at &EEB1 directly.
;
; On Entry:
;     A: OSBYTE number
;     X: OSBYTE X
;
; On Exit:
;     X: &FF if the key is pressed, 0 if not
;     Y: &FF if the key is pressed
.joystick_bytev
    cmp #&81                            ; OSBYTE &81 (INKEY)?
    bne joystick_pass_on                ; No: let the MOS handle it
    cpx #inkey_key_n                    ; The Barbarian's left key (N)?
    beq joystick_left                   ; Yes: read the stick for left
    cpx #inkey_key_b                    ; The Barbarian's down key (B)?
    beq joystick_down                   ; Yes: read the stick for down
    cpx #inkey_key_g                    ; The Barbarian's up key (G)?
    beq joystick_up                     ; Yes: read the stick for up
    cpx #inkey_key_m                    ; The Barbarian's right key (M)?
    beq joystick_right                  ; Yes: read the stick for right
    cpx #inkey_key_space                ; The Barbarian's fire key (SPACE)?
    beq joystick_fire                   ; Yes: read the fire buttons
    jmp mos320_osbyte_default           ; Any other key: scan the keyboard as usual
; &c51b referenced 1 time by &c506
.joystick_left
    ldx #1                              ; N: channel 1 high byte &FF?
    lda #osbyte_read_adc_or_get_buffer_status  ; ...with OSBYTE &80, reading the ADC
    jsr osbyte                          ; ...the stick's left-right position  Read ADC channel X or buffer status
    cpy #&ff                            ; ...high byte &FF: pushed fully left?
    bne joystick_not_pressed            ; No: not pressed
    ldx #&ff                            ; Yes: pressed (Y is already &FF)
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
    ldx #&ff                            ; Yes: pressed (Y is already &FF)
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
    ldx #0                              ; Not pressed: X = 0, which test_key reads as not held
    rts                                 ; Return
; &c569 referenced 1 time by &c502
.joystick_pass_on
    jmp mos320_osbyte_default           ; Not INKEY: on to the MOS 3.20 OSBYTE routine
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
; Called by level_loop's game-over code when all four heroes are dead. Stop the music,
; send the VDU 28 that the game-over text window begins with (the caller sends its four
; edges), and write 0 into the top-row operand of clear_text_area's VDU 28. That operand
; already holds 0 and nothing else writes it, so the store changes nothing.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &c600 referenced 1 time by &0e86
.game_over_music
    jsr stop_music                      ; Silence the music for the game-over message
    lda #&1c                            ; VDU 28: the game-over text window...
    jsr oswrch                          ; ...whose four edges the caller sends next
    lda #0                              ; Top row 0 in clear_text_area's window...
    sta clear_text_area_top             ; ...where it is already 0
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
; Reached by check_pause's JMP, last in each frame's update, so its RTS returns from
; update_game. If P (internal key &37) is held, wait for it to be released, pressed again
; and released, then give the next frame its usual three vertical syncs. OSBYTE &7A
; reports a single key, so P is seen only when the scan finds it rather than another key
; held with it.
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
    bne not_paused                      ; No: on with play
    jsr wait_p_released                 ; Paused: wait for P to be released...
; &c6dc referenced 1 time by &c6e3
.wait_p_pressed
    lda #osbyte_scan_keyboard_from_16   ; ...pressed again...
    jsr osbyte                          ; ...X = the key held  Scan keyboard from key 16
    cpx #&37 ; '7'                      ; ...P?
    bne wait_p_pressed                  ; No: stay paused
    jsr wait_p_released                 ; ...and released, so the next frame cannot re-pause
    lda #2                              ; Restart the frame timing: 2...
    sta os_vsync_counter                ; ...gives the next frame the usual three vsyncs
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
; Called by start_level once each level is drawn. Define envelopes 6-9, redirect the
; game's plot_sprite to the copy in Code3 (from the first level on, so the hero menu
; before it uses the original), point the tune at its first section, and play it on the
; interval timer: EVNTV is pointed at music_event and the interval timer event enabled.
; Then play the first step, which also sets the timer for the next.
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
; Called through EVNTV for the interval timer event, and once directly by start_music.
; Each call sets the interval timer to fire again 12 centiseconds later, so a step plays
; every 12 cs until stop_music disables the event. The event number in A is not checked:
; the game enables no other event. A tune step is three bytes: a transposition for the
; rhythm (0 for no change) or &FF to end the section, a pitch for channel 2 and a pitch
; for channel 3 (0 for silence). Each step also plays the next of the 32 steps of
; rhythm_pattern on channel 1 and the noise channel. At the end of a section the next
; byte sets channel 3's envelope and the next section starts; after section 24 the tune
; goes back to section 1. The interval timer is then reset.
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
    cmp #&19                            ; ...25, past the last?
    bne start_section                   ; No: start it
    lda #&ff                            ; Yes: loop to section 1 (0 plays only once), rhythm too
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
    ldx sprite_number                   ; X = sprite number, indexing the four sprite tables
    lda sprite_addr_lo,x                ; Point sprite_data_ptr at the sprite's data...
    sta sprite_data_ptr                 ; ...low byte
    lda sprite_addr_hi,x                ; ...high byte from its own table
    sta sprite_data_ptr_hi              ; ...so sprite_data_ptr walks through the data
    lda sprite_widths,x                 ; Bytes in each sprite row...
    sta sprite_width                    ; ...counted across each row
    lda sprite_heights,x                ; Pixel rows in the sprite...
    sta sprite_height                   ; ...counted down the sprite
    jsr screen_address_hazel            ; screen_ptr = address of the top-left byte
    ldy #0                              ; Index stays 0: the pointers themselves advance
    ldx sprite_height                   ; X counts the pixel rows still to plot
; &d81d referenced 1 time by &d864
.plot_sprite_row_hazel
    lda screen_ptr                      ; Remember where this pixel row starts...
    sta row_start_ptr                   ; ...low byte
    lda screen_ptr_hi                   ; ...and high byte...
    sta row_start_ptr_hi                ; ...in row_start_ptr, to step down from later
    txa                                 ; Save the row count
    pha                                 ; ...on the stack: X now counts bytes
    ldx sprite_width                    ; X counts the bytes across this row
; &d829 referenced 1 time by &d83f
.plot_sprite_byte_hazel
    lda (sprite_data_ptr),y             ; Copy one sprite byte...
    sta (screen_ptr),y                  ; ...to the screen, over whatever was there
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
    dex                                 ; One byte fewer left in this row
    bne plot_sprite_byte_hazel          ; More of the row: plot the next byte
    clc                                 ; screen_ptr = row start + 1: the next pixel row down
    lda row_start_ptr                   ; The row start's low byte...
    adc #1                              ; ...+ 1...
    sta screen_ptr                      ; ...is the new low byte
    lda row_start_ptr_hi                ; The row start's high byte...
    adc #0                              ; ...plus the carry...
    sta screen_ptr_hi                   ; ...is the new high byte
    lda screen_ptr                      ; Has it crossed into the next character row?
    and #7                              ; ...(pixel row within the character now 0)
    bne plot_sprite_next_row_hazel      ; No: still within the character row
    clc                                 ; Yes: add &278 more, to the top of the character...
    lda screen_ptr                      ; ...row below (row start + 1 + &278 = + 640 - 7)
    adc #&78 ; 'x'                      ; ...low byte + &78 (640 - 8 = &278)...
    sta screen_ptr                      ; ...stored
    lda screen_ptr_hi                   ; ...high byte...
    adc #2                              ; ...+ 2 and the carry...
    sta screen_ptr_hi                   ; ...stored
; &d861 referenced 1 time by &d852
.plot_sprite_next_row_hazel
    pla                                 ; Recover the row count
    tax                                 ; ...back into X
    dex                                 ; One pixel row fewer to plot
    bne plot_sprite_row_hazel           ; More rows: plot the next
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
    lsr a                               ; ...plot_y / 2...
    lsr a                               ; ...plot_y / 4...
    and #&fe                            ; ...bit 0 cleared: the row's pair of table bytes
    tay                                 ; ...as the index into the MOS table
    lda row_offsets,y                   ; High byte of row x 640, from Table's copy...
    clc                                 ; ...(carry clear for the add)
    adc #>(screen_start)                ; ...plus &30: the screen starts at &3000
    sta screen_ptr_hi                   ; ...as the screen address high byte
    lda row_offsets_lo,y                ; Low byte of row x 640
    sta screen_ptr                      ; ...as the low byte
    lda plot_y                          ; Add the pixel row within the character...
    and #7                              ; ...plot_y MOD 8...
    adc screen_ptr                      ; ...(carry clear: adding &30 to the high byte cannot carry)
    sta screen_ptr                      ; ...stored in the low byte
    clc                                 ; Add 8 x plot_x: its high byte is plot_x DIV 32...
    lda plot_x                          ; ...from plot_x...
    and #&e0                            ; ...bits 7-5 kept...
    rol a                               ; ...four ROLs through the carry: bit 7 out...
    rol a                               ; ...bit 7 in at bit 0, bit 6 out
    rol a                               ; ...bits 7-6 at bits 1-0, bit 5 out
    rol a                               ; ...bits 7-5 now in bits 2-0
    clc                                 ; ...(carry clear for the add)
    adc screen_ptr_hi                   ; ...added to the high byte
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
;     add_food_points:                1
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
;     check_hero_on_exit:             1
;     check_just_fired:               1
;     check_key:                      1
;     check_key_cell:                 1
;     check_key_down:                 1
;     check_key_fire:                 1
;     check_key_left:                 1
;     check_key_right:                1
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
;     draw_trapdoor:                  1
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
;     score_magic_kills:              1
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
;     take_hero_damage:               1
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
