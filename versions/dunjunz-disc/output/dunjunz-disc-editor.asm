; Constants
spr_wall                     = &00  ; Editor sprite &00
spr_exit                     = &01  ; Editor sprite &01
spr_drainer                  = &02  ; Editor sprite &02
spr_trapdoor                 = &03  ; Editor sprite &03
spr_treasure                 = &04  ; Editor sprite &04
spr_food                     = &05  ; Editor sprite &05
spr_teleporter               = &06  ; Editor sprite &06
spr_magic_sword              = &07  ; Editor sprite &07
spr_helmet                   = &08  ; Editor sprite &08
spr_potion                   = &09  ; Editor sprite &09
spr_weapons                  = &0a  ; Editor sprite &0A
spr_cross                    = &0b  ; Editor sprite &0B
spr_boots                    = &0c  ; Editor sprite &0C
spr_door_vertical            = &0d  ; Editor sprite &0D
spr_door_horizontal          = &0e  ; Editor sprite &0E
spr_key                      = &0f  ; Editor sprite &0F
spr_blank                    = &10  ; Editor sprite &10
spr_waiting_door             = &11  ; Editor sprite &11
spr_wall_block_0             = &12  ; Editor sprite &12
spr_chooser_frame            = &2a  ; Editor sprite &2A
spr_chooser_blank            = &2b  ; Editor sprite &2B
spr_cursor                   = &2c  ; Editor sprite &2C
max_slot                     = &4f  ; Item slots are numbered 0 to &4F
max_link                     = &13  ; Door-key links are numbered 0 to 19
max_object                   = &1e  ; The level file's objects are numbered 1 to 30; the exit is 30
max_door                     = &14  ; Doors are numbered 1 to 20
map_width                    = &20  ; The map is 32 cells wide...
map_height                   = &30  ; ...and 48 cells high
opcode_jmp                   = &4c  ; The JMP opcode, which arms the MOS BREAK intercept
level_file_end               = &29b0  ; The end of the level file at &2700
game_chalice_type            = &73  ; The game's object type for the Chalice
screen_start                 = &3000  ; The start of MODE 2 screen memory
map_bytes                    = &c9  ; The length of the wall and object-free maps
off_map                      = &ff  ; A map x or y that leaves an object out of the level
no_link                      = &ff  ; A free door-key link, or no door waiting
max_level                    = &18  ; The highest level number the editor saves
wall_block_count             = &18  ; The wall blocks in Stones
wall_block_bytes             = &30  ; The length of a wall block, 4 bytes by 12 rows
game_exit_type               = &51  ; The game's object type for the exit
osbyte_escape_break_effect   = &c8
osbyte_flush_buffer_class    = &0f
osbyte_scan_keyboard_from_16 = &7a
osword_read_line             = &00
osbyte_set_cursor_editing    = &04
osbyte_vsync                 = &13
osbyte_inkey                 = &81
inkey_key_f0                 = &df
inkey_key_s                  = &ae
inkey_key_shift              = &ff
inkey_key_up                 = &c6
inkey_key_down               = &d6
inkey_key_1                  = &cf
inkey_key_2                  = &ce
inkey_key_space              = &9d
inkey_key_tab                = &9f
inkey_key_b                  = &9b
inkey_key_ctrl               = &fe
inkey_key_comma              = &99
inkey_key_full_stop          = &98
inkey_key_a                  = &be
inkey_key_z                  = &9e

; Memory locations
plot_x                = &70  ; Sprite position for plot_sprite: screen byte column. Also a pointer's low byte.
; &70 referenced 13 times by &1cb4, &1cba, &1cc0, &244b, &2454, &2458, &2462, &2519, &2532, &2784, &2791, &2b67, &2ce6
plot_y                = &71  ; Sprite position for plot_sprite: pixel row. Also a pointer's high byte.
; &71 referenced 16 times by &1cb6, &2432, &243b, &243f, &2446, &244d, &2451, &245a, &245e, &2527, &2534, &2538, &2767, &277b, &2b70, &2cf1
scratch               = &72  ; Scratch: a pointer's low byte, a key number, a count or a length.
; &72 referenced 31 times by &1c6a, &1ca5, &1ceb, &1e6a, &1e88, &20e4, &20ed, &20f2, &210b, &2150, &2156, &215d, &215f, &2165, &21df, &21e5, &22c8, &22cd, &230a, &2310, &2317, &231d, &236f, &2385, &243d, &2443, &2449, &251f, &2523, &270f, &2727
scratch_hi            = &73  ; Scratch: a pointer's high byte or a second key number.
; &73 referenced 14 times by &1c6e, &1cef, &210f, &2154, &2163, &216b, &230e, &231b, &2323, &2389, &2441, &244f, &2714, &271b
screen_ptr            = &74  ; plot_sprite's screen address, low byte; also a running sum.
; &74 referenced 21 times by &2158, &215a, &2308, &2313, &2315, &2329, &2333, &2342, &271d, &272b, &272e, &2732, &2746, &274e, &2755, &2759, &2779, &277f, &2781, &2797, &2799
screen_ptr_hi         = &75  ; plot_sprite's screen address, high byte.
; &75 referenced 9 times by &2721, &2736, &274c, &275b, &275f, &2774, &278d, &278f, &279d
row_start_ptr         = &76  ; plot_sprite: start of the sprite row, low byte.
; &76 referenced 2 times by &271f, &2742
row_start_ptr_hi      = &77  ; plot_sprite: start of the sprite row, high byte.
; &77 referenced 2 times by &2723, &2748
sprite_data_ptr       = &78  ; plot_sprite: next sprite data byte, low byte.
; &78 referenced 3 times by &2705, &2729, &2738
sprite_data_ptr_hi    = &79  ; plot_sprite: next sprite data byte, high byte.
; &79 referenced 2 times by &270a, &273c
sprite_number         = &7a  ; The sprite plot_sprite plots.
; &7a referenced 6 times by &249a, &252a, &2549, &2700, &2b62, &2ce0
cursor_x              = &80  ; The cursor's cell, x (0-31).
; &80 referenced 25 times by &1a11, &1a1e, &1f47, &1f53, &1f55, &1f8d, &2092, &21d0, &221a, &2221, &222c, &223c, &2b19, &2b24, &2b2a, &2b48, &2b50, &2b64, &2b7b, &2bad, &2bba, &2bf2, &2d68, &2d85, &2da5
cursor_y              = &81  ; The cursor's cell, y (0-47).
; &81 referenced 26 times by &1a00, &1a08, &1f43, &1f5b, &1f5d, &1f8f, &209a, &21d9, &2216, &2226, &2230, &2237, &2b33, &2b39, &2b44, &2b52, &2b5a, &2b69, &2b6e, &2b82, &2b9c, &2ba4, &2bf7, &2d6d, &2d8a, &2daa
current_item          = &82  ; The item SPACE places (0-&0F): 0 a wall, 1 the exit, 3 a trapdoor, &0D/&0E doors, &0F a key, the rest objects.
; &82 referenced 16 times by &1f93, &2012, &2066, &206c, &2077, &2079, &207f, &2088, &20af, &20c7, &2212, &2b5c, &2bda, &2bfc, &2c39, &2ca3
last_slot             = &83  ; The highest item slot, &4F: 80 slots.
; &83 referenced 3 times by &1c4c, &2b76, &2be8
bit_mask              = &84  ; A map bit's mask; also scratch, such as a slot number.
; &84 referenced 25 times by &19ce, &19d5, &1a22, &1a27, &1a38, &1a3e, &2681, &2688, &2b92, &2bbe, &2bc3, &2bd2, &2be3, &2c1c, &2c20, &2c24, &2c75, &2ca9, &2cb0, &2cba, &2d1d, &2d48, &2d77, &2dda, &2de9
map_ptr               = &85  ; Address of a map byte, low byte.
; &85 referenced 19 times by &1a06, &1a0d, &1a0f, &1a16, &1a18, &1a3c, &1a40, &2b90, &2ba2, &2ba9, &2bab, &2bb2, &2bb4, &2be1, &2be5, &2c22, &2c26, &2c73, &2c77
map_ptr_hi            = &86  ; Address of a map byte, high byte.
; &86 referenced 2 times by &1a1c, &2bb8
key_left              = &87  ; INKEY number of the cursor-left key: ',' (&99).
; &87 referenced 2 times by &1c3c, &2b1d
key_right             = &88  ; INKEY number of the cursor-right key: '.' (&98).
; &88 referenced 2 times by &1c40, &2b12
key_up                = &89  ; INKEY number of the cursor-up key: 'A' (&BE).
; &89 referenced 2 times by &1c44, &2b2c
key_down              = &8a  ; INKEY number of the cursor-down key: 'Z' (&9E).
; &8a referenced 2 times by &1c48, &2b3d
object_count          = &8b  ; Objects placed (at most 29).
; &8b referenced 9 times by &1914, &1916, &192d, &1f0a, &21b4, &2c51, &2c53, &2c59, &2d33
trapdoor_count        = &8c  ; Trapdoors placed (8 are needed to save).
; &8c referenced 8 times by &191a, &1f04, &1fe4, &21bd, &2c65, &2c67, &2c6d, &2d3d
exit_placed           = &8d  ; Non-zero once the exit is placed (needed to save).
; &8d referenced 6 times by &1f08, &1f65, &1fdb, &2c5c, &2c60, &2d39
door_count            = &8e  ; Doors placed (at most 20).
; &8e referenced 10 times by &1912, &1954, &1f06, &20f4, &21c6, &2c79, &2c7b, &2c81, &2d41, &2d98
brkv                  = &0202
; &0202 referenced 2 times by &1c2d, &2255
os_break_intercept    = &0287  ; MOS BREAK intercept: a JMP here is called twice during a reset, with C clear and then set.
; &0287 referenced 4 times by &1c1e, &1ebd, &2246, &2397
os_break_intercept_lo = &0288
; &0288 referenced 2 times by &1c23, &224b
os_break_intercept_hi = &0289
; &0289 referenced 2 times by &1c28, &2250
slot_x                = &0c00  ; Each item slot's x (80 slots).
; &0c00 used as index base 17 times by &1932, &196e, &198a, &19a6, &1ea1, &262b, &2642, &2653, &2675, &2698, &2b78, &2bf4, &2ce2, &2d0a, &2d82, &2e40, &2e58
slot_y                = &0c60  ; Each item slot's y.
; &0c60 used as index base 17 times by &1938, &1974, &1990, &19ac, &2631, &2648, &2659, &267b, &269e, &2b7f, &2bf9, &2ce8, &2cee, &2d0d, &2d87, &2e46, &2e5e
slot_item             = &0cb0  ; Each item slot's editor sprite (0: free).
; &0cb0 used as index base 12 times by &1944, &1980, &1995, &19b1, &260d, &2b86, &2bea, &2bfe, &2cc8, &2cd3, &2cdd, &2d07
line_x                = &0dd0  ; The cell a link line is drawn from or to, x; also where delete_item keeps the cursor.
; &0dd0 referenced 6 times by &2d6a, &2da2, &2dba, &2e08, &2e43, &2e5b
line_y                = &0dd1  ; The cell a link line is drawn from or to, y.
; &0dd1 referenced 6 times by &2d6f, &2da7, &2dd5, &2e0e, &2e49, &2e61
line_gx               = &0dd2  ; That cell's graphics x, low byte (high byte at &0DD3).
; &0dd2 referenced 3 times by &2db4, &2dc9, &2e1d
line_gx_hi            = &0dd3  ; That cell's graphics x, high byte.
; &0dd3 referenced 4 times by &2db7, &2dc2, &2dc6, &2e23
line_gy               = &0dd4  ; That cell's graphics y, low byte (high byte at &0DD5).
; &0dd4 referenced 6 times by &2dcf, &2de5, &2deb, &2df9, &2dfc, &2e29
line_gy_hi            = &0dd5  ; That cell's graphics y, high byte.
; &0dd5 referenced 8 times by &2dd2, &2dde, &2de2, &2dee, &2df3, &2e01, &2e04, &2e2f
pending_door_item     = &0dd6  ; The sprite of the door waiting for its key, or &FF if none.
; &0dd6 referenced 6 times by &1ef2, &2c84, &2c9a, &2cbc, &2ccb, &2cda
pending_door_slot     = &0dd7  ; The slot of the door waiting for its key.
; &0dd7 referenced 3 times by &2c8f, &2cce, &2cd7
link_index            = &0dd8  ; The door-key link being made: an index into link_door and link_key.
; &0dd8 referenced 5 times by &1eae, &1f1a, &2c06, &2c8c, &2d01
level_object_x        = &2700  ; The level file at &2700: objects' x (entries 1-30). Entry 0, unused by the game, is set on saving so that the level's sum matches its checksum.
; &2700 used as index base 1 time by &239f
level_object_y        = &2720  ; The level file: objects' y.
; &2720 used as index base 5 times by &1935, &1f35, &1f6e, &2634, &264b
level_object_type     = &2740  ; The level file: objects' types.
; &2740 used as index base 4 times by &193b, &1f24, &2628, &263f
level_door_x          = &2760  ; The level file: doors' x (entries 1-20).
; &2760 used as index base 4 times by &194f, &1968, &1f76, &2678
level_door_y          = &2775  ; The level file: doors' y.
; &2775 used as index base 3 times by &1971, &1f79, &267e
level_door_sprite     = &278a  ; The level file: doors' sprites.
; &278a used as index base 2 times by &1977, &2672
level_key_x           = &27a0  ; The level file: keys' x.
; &27a0 used as index base 3 times by &1987, &1f7c, &269b
level_key_y           = &27b5  ; The level file: keys' y.
; &27b5 used as index base 3 times by &198d, &1f7f, &26a1
level_trapdoor_x      = &27d0  ; The level file: trapdoors' x (entries 0-7).
; &27d0 used as index base 2 times by &19a0, &2656
level_trapdoor_y      = &27d8  ; The level file: trapdoors' y.
; &27d8 used as index base 2 times by &19a9, &265c
level_walls           = &27e0  ; The level file: the wall map.
; &27e0 referenced 2 times by &22fa, &22ff; also used as index base 2 times by &19bc, &26b1
plotter_image_page_2  = &2800  ; The second page of the stored plotter page, copied to &0A00.
; &2800 used as index base 1 time by &23a8
level_object_free     = &28b0  ; The level file: the object-free map.
; &28b0 used as index base 2 times by &19c2, &26b7
link_door             = &2ea0  ; Each of 20 door-key links' door slot, or &FF if unused.
; &2ea0 used as index base 12 times by &195c, &1ee7, &20e8, &2685, &2c92, &2cad, &2cf9, &2d45, &2d4e, &2d7d, &2d9c, &2e3a
link_key              = &2ec0  ; Each door-key link's key slot.
; &2ec0 used as index base 7 times by &1962, &1eea, &2691, &2c09, &2d51, &2d74, &2e54
wall_map              = &2f00  ; The wall map being edited (the level's &C9 bytes, laid out as in the game).
; &2f00 used as index base 3 times by &19bf, &1e9b, &26ae
unpack_slot           = &2ff0  ; unpack_level's next free slot, counting down.
; &2ff0 referenced 11 times by &191e, &192f, &1941, &1947, &1956, &196b, &197d, &1983, &1998, &19a3, &19b4
unpack_link           = &2ff1  ; unpack_level's next free link, counting down.
; &2ff1 referenced 3 times by &1923, &1959, &1965
wall_blocks           = &6e80  ; Stones, loaded here by choose_wall_block: the 24 wall blocks (&30 bytes each) that a level can use.
object_free_map       = &7e00  ; The object-free map being edited (&C9 bytes): a clear bit marks a cell where an object may lie.
; &7e00 used as index base 3 times by &19c5, &1ee1, &26b4
blank_sprite          = &7ff0  ; Zeros, plotted as the blank sprite &10.
mos_row_offsets       = &c375  ; MOS 1.20's table of the screen's character row offsets, high byte then low byte.
; &c375 used as index base 1 time by &276e
mos_row_offsets_lo    = &c376
; &c376 used as index base 1 time by &2776
mos120_reset_entry    = &d9cd  ; MOS 1.20's reset entry, the target of the 6502 reset vector.
; &d9cd referenced 1 time by &239a
osnewl                = &ffe7
; &ffe7 referenced 1 time by &1e8a
oswrch                = &ffee
; &ffee referenced 57 times by &1c57, &1c5c, &1c61, &1c94, &1cbc, &1ce6, &1e1c, &1e21, &1e24, &1e40, &1e72, &1e79, &1e81, &1eb3, &1eb8, &1ef7, &1efc, &1eff, &2003, &2008, &2143, &2174, &2179, &217f, &2184, &2187, &218a, &2190, &2195, &219d, &21a7, &21ac, &21f7, &21fb, &21ff, &2206, &220c, &2268, &2275, &22ef, &2363, &237c, &23b6, &23bd, &23c5, &23ca, &23cf, &2402, &2560, &26d2, &26de, &2e16, &2e1a, &2e20, &2e26, &2e2c, &2e32
osword                = &fff1
; &fff1 referenced 2 times by &1e67, &22a4
osbyte                = &fff4
; &fff4 referenced 14 times by &1c19, &1cc8, &1ccd, &1e35, &1f10, &1fa1, &1faf, &20fb, &2263, &226d, &2475, &2506, &2b02, &2e94
oscli                 = &fff7
; &fff7 referenced 10 times by &1c52, &1cad, &1fee, &1ff5, &211c, &2132, &213a, &2377, &23df, &26d9


    org &1910
.unpack_level_image

; Move 1: &1910 to &7b00 for length 206
    org &7b00
; ***************************************************************************************
; Unpack the loaded level into the slots
;
; Called by start_editing for a loaded, decrypted level. Read the level file's tables
; from the last entry back, putting each item in the next slot down from &4F: objects 30
; to 1 (the exit, 30, first, into slot &4F), skipping any whose x is &80 or more, with
; their editor items found from item_types; doors 20 to 1, each followed by its key in
; the slot below and the pair recorded as a door-key link, from link 19 down; then all
; eight trapdoors. Copy the wall map and object-free map into the editor's own.
; object_count leaves out the exit (it starts at -1), door_count counts the doors and
; trapdoor_count is set to 8.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &7b00 referenced 1 time by &1f38; also used as index base 1 time by &1ec8
.unpack_level
    lda #0                              ; No doors...
    sta door_count                      ; ...for the count shown
    sta object_count                    ; ...and no objects (the exit is counted too, so -1)
    dec object_count                    ; ...starting at -1
    lda #8                              ; All 8 trapdoors
    sta trapdoor_count                  ; ...as the level file has them all
    lda #max_slot                       ; Slots from &4F down...
    sta unpack_slot                     ; ...the next slot to fill
    lda #max_link                       ; ...links from 19 down
    sta unpack_link                     ; ...the next link to fill
    ldx #max_object                     ; For objects 30 to 1...
; &7b18 referenced 1 time by &194b
.unpack_object
    lda level_object_x,x                ; ...its x: on the map?
    bmi next_object                     ; &80 or more (&FF): not in this level
    inc object_count                    ; Yes: count it...
    ldy unpack_slot                     ; ...and put it in the next slot...
    sta slot_x,y                        ; ...its x...
    lda level_object_y,x                ; ...then its y...
    sta slot_y,y                        ; ...into the slot too
    lda level_object_type,x             ; ...as the editor's item for its type
    jsr item_for_type                   ; ...from item_types...
    ldy unpack_slot                     ; ...back to the slot being filled...
    sta slot_item,y                     ; ...stored with it...
    dec unpack_slot                     ; ...and move to the next slot down
; &7b3a referenced 1 time by &192b
.next_object
    dex                                 ; Next object
    bne unpack_object                   ; ...down to object 1
    ldx #max_door                       ; For doors 20 to 1...
; &7b3f referenced 1 time by &199c
.unpack_door
    lda level_door_x,x                  ; ...its x: on the map?
    bmi next_door                       ; &80 or more (&FF): no door here
    inc door_count                      ; Yes: count it...
    lda unpack_slot                     ; ...link it: the door's slot...
    ldy unpack_link                     ; ...in this link...
    sta link_door,y                     ; ...recorded as the link's door...
    sec                                 ; ...and the key's, the slot below...
    sbc #1                              ; ...one below...
    sta link_key,y                      ; ...is the key's slot...
    dec unpack_link                     ; ...and move to the next link down
    lda level_door_x,x                  ; ...put the door in its slot...
    ldy unpack_slot                     ; ...in the slot being filled...
    sta slot_x,y                        ; ...its x...
    lda level_door_y,x                  ; ...then its y...
    sta slot_y,y                        ; ...into the slot too
    lda level_door_sprite,x             ; ...and its sprite...
    jsr item_for_type                   ; ...as the editor's door item...
    ldy unpack_slot                     ; ...back to the slot being filled...
    sta slot_item,y                     ; ...stored with it...
    dec unpack_slot                     ; ...and move to the next slot down
    dey                                 ; Y = the door's slot - 1: the key's slot
    lda level_key_x,x                   ; ...its x...
    sta slot_x,y                        ; ...into the slot below...
    lda level_key_y,x                   ; ...then its y...
    sta slot_y,y                        ; ...stored with it, in the slot below...
    lda #spr_key                        ; ...the key item...
    sta slot_item,y                     ; ...as the slot's item...
    dec unpack_slot                     ; ...and move to the next slot down
; &7b8b referenced 1 time by &1952
.next_door
    dex                                 ; Next door
    bne unpack_door                     ; ...down to door 1
    ldx #7                              ; For trapdoors 7 to 0, all of them present...
; &7b90 referenced 1 time by &19b8
.unpack_trapdoor
    lda level_trapdoor_x,x              ; ...put each in the next slot
    ldy unpack_slot                     ; ...in the slot being filled...
    sta slot_x,y                        ; ...its x...
    lda level_trapdoor_y,x              ; ...then its y...
    sta slot_y,y                        ; ...into the slot too
    lda #3                              ; ...as the trapdoor item...
    sta slot_item,y                     ; ...stored with it...
    dec unpack_slot                     ; ...and move to the next slot down
    dex                                 ; ...the next trapdoor down...
    bpl unpack_trapdoor                 ; ...to trapdoor 0
    ldx #0                              ; Copy the &C9 bytes of each map
; &7bac referenced 1 time by &19cb
.unpack_maps
    lda level_walls,x                   ; Wall bits from the level...
    sta wall_map,x                      ; ...into the wall map being edited...
    lda level_object_free,x             ; ...object-free bits from the level...
    sta object_free_map,x               ; ...into the map being edited...
    inx                                 ; ...the next byte...
    cpx #map_bytes                      ; ...for the maps' &C9 bytes...
    bne unpack_maps                     ; ...until both are copied
    rts                                 ; Return
; ***************************************************************************************
; Find the editor's item for a level type
;
; Search item_types from entry 1 for the type: an object's type, or a door's sprite &1C
; or &1D. A type with no item would be matched against the bytes beyond item_types (the
; checksums and sprite tables), and with no match at all Y would wrap to 0 and run on
; past the routine's end.
;
; On Entry:
;     A: level type
;
; On Exit:
;     A: item
;     Y: item
; &7bbe referenced 2 times by &193e, &197a
.item_for_type
    sta bit_mask                        ; Keep the type to compare with
    ldy #1                              ; From item 1...
; &7bc2 referenced 1 time by &19dc
.search_types
    lda item_types,y                    ; ...a match?
    cmp bit_mask                        ; ...the type being looked up?
    bne next_type                       ; No: next type
    tya                                 ; Yes: return the item
    rts                                 ; ...the item number in A
; &7bcb referenced 1 time by &19d7
.next_type
    iny                                 ; No: next
    bne search_types                    ; ...trying every item until one matches


    ; Copy the newly assembled block of code back to it's proper place in the binary
    ; file.
    ; (Note the parameter order: 'copyblock <start>,<end>,<dest>')
    copyblock unpack_level, *, unpack_level_image

    ; Clear the area of memory we just temporarily used to assemble the new block,
    ; allowing us to assemble there again if needed
    clear unpack_level, &7bce

    ; Set the program counter to the next position in the binary file.
    org unpack_level_image + (* - unpack_level)


    org &1a00
.mark_object_cell_image

; Move 2: &1a00 to &7d80 for length 67
    org &7d80
; ***************************************************************************************
; Mark the cursor's cell as holding an object
;
; Clear its bit in the object-free map (laid out as the wall map), so the game will look
; for an object there. put_item calls it for every item placed, walls included. It runs
; at &7D80, copied there by start_editing, in screen memory below the 30 rows shown
; (&3000-&7AFF).
;
; On Entry:
;     CURSOR_X: the cell's column
;     CURSOR_Y: the cell's row
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &7d80 referenced 1 time by &2bd7; also used as index base 1 time by &1ed5
.mark_object_cell
    lda cursor_y                        ; (y AND &F8) x 4...
    and #&f8                            ; ...the room row, as a multiple of 8...
    asl a                               ; ...x 2...
    asl a                               ; ...x 4: 32 bytes per row of rooms
    sta map_ptr                         ; ...kept
    lda cursor_y                        ; ...+ (y AND 7)...
    and #7                              ; ...the cell's row within the room
    clc                                 ; ...C clear for the addition
    adc map_ptr                         ; ...added
    sta map_ptr                         ; ...kept
    lda cursor_x                        ; ...+ (x AND &F8)...
    and #&f8                            ; ...the room's column x 8: its 8 bytes
    clc                                 ; ...C clear for the addition
    adc map_ptr                         ; ...added
    sta map_ptr                         ; ...map_ptr: the cell's byte
    lda #>(object_free_map)             ; ...in object_free_map
    sta map_ptr_hi                      ; ...high byte
    lda cursor_x                        ; Bit 7 - (x AND 7)...
    and #7                              ; ...the cell's column within the room...
    sta bit_mask                        ; ...kept...
    lda #7                              ; ...from 7...
    sec                                 ; ...C set for the subtraction
    sbc bit_mask                        ; ...7 - it: the bit, leftmost cell in bit 7
    beq mark_bit_0                      ; Bit 0: the mask is 1
    tax                                 ; ...as a count...
    lda #1                              ; ...from bit 0...
; &7dae referenced 1 time by &1a30
.mark_shift_bit
    asl a                               ; Shift the mask up a bit...
    dex                                 ; ...counted
    bne mark_shift_bit                  ; ...until it is in place
    beq mark_bit_found                  ; ...(always branches)
; &7db4 referenced 1 time by &1a29
.mark_bit_0
    lda #1                              ; ...mask 1
; &7db6 referenced 1 time by &1a32
.mark_bit_found
    eor #&ff                            ; Clear it
    sta bit_mask                        ; ...as a mask
    ldy #0                              ; ...Y = 0
    lda (map_ptr),y                     ; ...the map byte...
    and bit_mask                        ; ...with the cell's bit cleared: objects may lie here
    sta (map_ptr),y                     ; ...back in the map
    rts                                 ; Return


    ; Copy the newly assembled block of code back to it's proper place in the binary
    ; file.
    ; (Note the parameter order: 'copyblock <start>,<end>,<dest>')
    copyblock mark_object_cell, *, mark_object_cell_image

    ; Clear the area of memory we just temporarily used to assemble the new block,
    ; allowing us to assemble there again if needed
    clear mark_object_cell, &7dc3

    ; Set the program counter to the next position in the binary file.
    org mark_object_cell_image + (* - mark_object_cell)


    org &2700
.plotter_image

; Move 3: &2700 to &0900 for length 512
    org &0900
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
; &0900 referenced 5 times by &24a0, &253a, &254b, &2b72, &2cf3; also used as index base 1 time by &23a2
.plot_sprite
    ldx sprite_number                   ; X = sprite number, indexing the four sprite tables
    lda sprite_addr_lo,x                ; Point sprite_data_ptr at the editor sprite's data...
    sta sprite_data_ptr                 ; ...low byte
    lda sprite_addr_hi,x                ; ...high byte, from the editor's sprite tables...
    sta sprite_data_ptr_hi              ; ...so sprite_data_ptr walks through the data
    lda sprite_widths,x                 ; Width in screen bytes, from sprite_widths...
    sta scratch                         ; ...counted across each row
    lda sprite_heights,x                ; Height in pixel rows, from sprite_heights...
    sta scratch_hi                      ; ...counted down the sprite
    jsr screen_address                  ; screen_ptr = address of the top-left byte
    ldy #0                              ; Index stays 0: the pointers themselves advance
    ldx scratch_hi                      ; X counts the pixel rows still to plot
; &091d referenced 1 time by &2764
.plot_sprite_row
.plot_row
    lda screen_ptr                      ; Remember where this pixel row starts...
    sta row_start_ptr                   ; ...low byte
    lda screen_ptr_hi                   ; ...and high byte...
    sta row_start_ptr_hi                ; ...in row_start_ptr, to step down from later
    txa                                 ; Save the row count
    pha                                 ; ...on the stack: X now counts bytes
    ldx scratch                         ; X counts the bytes across this row
; &0929 referenced 1 time by &273f
.plot_sprite_byte
.plot_byte
    lda (sprite_data_ptr),y             ; Copy one sprite byte...
    sta (screen_ptr),y                  ; ...to the screen, over whatever was there
    clc                                 ; Step screen_ptr right one byte column: 8 bytes on
    lda screen_ptr                      ; ...the screen address's low byte...
    adc #8                              ; ...+ 8, the next byte column...
    sta screen_ptr                      ; ...stored back
    bcc plot_sprite_next_data           ; No carry: the high byte stands
    inc screen_ptr_hi                   ; ...with carry into the high byte
; &0938 referenced 1 time by &2734
.plot_sprite_next_data
.plot_next_data
    inc sprite_data_ptr                 ; Next sprite data byte
    bne plot_sprite_count_byte          ; No carry: the high byte stands
    inc sprite_data_ptr_hi              ; ...with carry into the high byte
; &093e referenced 1 time by &273a
.plot_sprite_count_byte
.plot_count_byte
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
; &0961 referenced 1 time by &2752
.plot_sprite_next_row
.plot_next_row
    pla                                 ; Recover the row count
    tax                                 ; ...back into X
    dex                                 ; One pixel row fewer to plot
    bne plot_sprite_row                 ; More rows: plot the next
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
; &0967 referenced 1 time by &2716
.screen_address
    lda plot_y                          ; Table index = 2 x (plot_y DIV 8), the character row...
    lsr a                               ; ...plot_y / 2...
    lsr a                               ; ...plot_y / 4...
    and #&fe                            ; ...bit 0 cleared: the row's pair of table bytes
    tay                                 ; ...as the index into the MOS table
    lda mos_row_offsets,y               ; High byte of row x 640, from the MOS table...
    clc                                 ; ...(carry clear for the add)
    adc #>(screen_start)                ; ...plus &30: the screen starts at &3000
    sta screen_ptr_hi                   ; ...as the screen address high byte
    lda mos_row_offsets_lo,y            ; Low byte of row x 640
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
; &099f referenced 1 time by &279b
.screen_address_done
    rts                                 ; Return
; ***************************************************************************************
; Unused
;
; Leftover bytes.
    equb &20, &20, &20, &20, &44, &20, &20, &20
    equb &20, &20, &20, &20, &44, &20, &20, &20  ; Not used
; &09b0 referenced 3 times by &2602, &261e, &2625
.packed_objects
    equb &20
; &09b1 referenced 3 times by &2605, &2650, &265f
.packed_trapdoors
    equb &20
; &09b2 referenced 4 times by &2608, &2668, &266f, &2695
.packed_doors
    equb &20
    equb &20, &44, &20, &20, &20, &20, &20, &20
    equb &20, &44, &20, &20, &20        ; Not used: leftover spaces and Ds
; ***************************************************************************************
; Item types and checksums
;
; The level type for each of the editor's items, and a copy of the game's level checksum
; table.
; &09c0 used as index base 3 times by &19d2, &2622, &266c
.item_types
; &27cf used as index base 1 time by &22e7
    equb &22, &51, &53, &00, &28, &29, &2b, &63, &60, &61, &62, &2a, &5f, &1c, &1d, &31
.level_checksums
    equb &62, &cd, &0c, &44, &4d, &22, &f6, &42, &21, &7d, &5d, &d8, &a0
    equb &f1, &0f, &cc, &d3, &53, &3b, &83, &71, &b2, &6f, &f3, &f1
; ***************************************************************************************
; Unused
;
; Leftover bytes.
    equb &00, &3a, &20, &20, &20, &3a, &20, &20
    equb &20, &3a, &20, &20, &20, &3a, &20, &20
    equb &20, &3a, &20, &20, &20, &3a, &20  ; Not used
; ***************************************************************************************
; Sprite tables
;
; Each of the editor's 51 sprites' data address (low and high bytes), width in bytes and
; height in pixel rows. 0-&0F are the items (two bytes by five rows, at &2A00), &10 is
; blank (zeros at &7FF0), &11 a door waiting for its key, &12-&29 the 24 wall blocks in
; Stones (&6E80), &2A the wall-block chooser's frame and &2B a blank part of the screen
; that erases it, and &2C the cursor. Entries &2D-&32 are not used.
; &0a00 used as index base 2 times by &23ab, &2702
.sprite_addr_lo
    equb &00, &0a, &14, &1e, &28, &32, &3c, &46, &50, &5a, &64, &6e, &78, &82, &8c, &96, &f0
    equb &a0, &80, &b0, &e0, &10, &40, &70, &a0, &d0, &00, &30, &60, &90, &c0, &f0, &20, &50
    equb &80, &b0, &e0, &10, &40, &70, &a0, &d0, &80, &00, &f6, &0a, &25, &00, &05, &00, &00
; &0a33 used as index base 1 time by &2707
.sprite_addr_hi
    equb &2a, &2a, &2a, &2a, &2a, &2a, &2a, &2a, &2a, &2a, &2a, &2a, &2a, &2a, &2a, &2a, &7f
    equb &2a, &6e, &6e, &6e, &6f, &6f, &6f, &6f, &6f, &70, &70, &70, &70, &70, &70, &71, &71
    equb &71, &71, &71, &72, &72, &72, &72, &72, &25, &32, &29, &00, &00, &00, &00, &00, &00
; &0a66 used as index base 1 time by &270c
.sprite_widths
    equb &02, &02, &02, &02, &02, &02, &02, &02, &02, &02, &02, &02, &02, &02, &02, &02, &02
    equb &02, &04, &04, &04, &04, &04, &04, &04, &04, &04, &04, &04, &04, &04, &04, &04, &04
    equb &04, &04, &04, &04, &04, &04, &04, &04, &06, &06, &02, &00, &9d, &0a, &79, &25, &00
; &0a99 used as index base 1 time by &2711
.sprite_heights
    equb &05, &05, &05, &05, &05, &05, &05, &05, &05, &05, &05, &05, &05, &05, &05, &05, &05
    equb &05, &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c
    equb &0c, &0c, &0c, &0c, &0c, &0c, &0c, &0c, &12, &12, &05, &00, &bf, &21, &d1, &0a, &63
; ***************************************************************************************
; Unused
;
; Leftover bytes.
    equb &68, &61, &00, &5a, &22, &d9, &0a, &64
    equb &69, &73, &00, &21, &1e, &00, &00, &61
    equb &64, &64, &00, &90, &22, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &ff             ; Not used


    ; Copy the newly assembled block of code back to it's proper place in the binary
    ; file.
    ; (Note the parameter order: 'copyblock <start>,<end>,<dest>')
    copyblock plot_sprite, *, plotter_image

    ; Clear the area of memory we just temporarily used to assemble the new block,
    ; allowing us to assemble there again if needed
    clear plot_sprite, &0b00

    ; Set the program counter to the next position in the binary file.
    org plotter_image + (* - plot_sprite)


    org &1910

.dasmos_start

    org &19de
; ***************************************************************************************
; Unused
;
; Leftover bytes after unpack_level's image.
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00                       ; Not used

    org &1a43
; ***************************************************************************************
; Unused
;
; Leftover bytes, among them the text PAGE.
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &01, &00, &46, &42, &01, &01, &06, &06, &7c, &60, &02, &02, &00, &01, &00, &ff
    equb &ff, &8a, &b6, &8e, &b6, &0d, &00, &00, &00, &00, &00, &00, &00, &20, &02, &43
    equb &45, &07, &50, &41, &47, &45, &20, &02, &50, &50, &07, &0d, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &ff, &0d, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &8b, &8e, &91
    equb &93, &95, &95, &95, &95, &95, &95, &95, &1b, &2d, &01, &1b, &2d, &00, &1b, &47
    equb &1b, &48, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &ff, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00  ; Not used
; ***************************************************************************************
; BREAK intercept: start again
;
; Called twice during a reset; on the second call, with C set, go back to editor_init,
; keeping the editor in memory.
.break_to_start
    bcs editor_init                     ; Second call (after the reset)? Start again
    rts                                 ; First call: return
; ***************************************************************************************
; Set up and choose a level
;
; Disable ESCAPE, point the BREAK intercept at break_to_start (so BREAK at a prompt
; starts again) and BRKV at MOS 1.20's reset entry (so any error, such as a missing file,
; resets the machine), and note that no level has been encrypted. Set the map cursor's
; keys to ',' '.' 'A' 'Z', *TV255 1 (applied by the MODE 7 that follows) and ask whether
; to edit a level or start a new one. A new level goes to new_level. To edit, choose disc
; or tape (and the drive), read the filename into load_command, *LOAD the file at &2700
; and go to start_editing. Reached from editor_start, from break_to_start and after a
; save when another level is asked for.
; &1c13 referenced 3 times by &1c10, &2392, &23b1
.editor_init
    lda #osbyte_escape_break_effect     ; OSBYTE &C8 with X=1, Y=0: disable ESCAPE
    ldx #1                              ; X = 1: ESCAPE does nothing while editing
    ldy #0                              ; Y = 0: replace the whole setting
    jsr osbyte                          ; Set it, so ESCAPE cannot stop the editor  osbyte: escape break effect
    lda #opcode_jmp                     ; BREAK intercept = JMP break_to_start...
    sta os_break_intercept              ; Arm the intercept with a JMP...
    lda #<(break_to_start)              ; ...whose target is break_to_start...
    sta os_break_intercept_lo           ; ...its low byte...
    lda #>(break_to_start)              ; ...high byte of the target...
    sta os_break_intercept_hi           ; ...so BREAK at a prompt restarts the editor
    lda #<(mos120_reset_entry)          ; BRKV = &D9CD, MOS 1.20's reset entry: an error resets
    sta brkv                            ; ...low byte of the error handler...
    lda #>(mos120_reset_entry)          ; ...high byte of the error handler...
    sta brkv + 1                        ; ...so any error (File not found...) resets
    lda #0                              ; No level saved yet (so the buffer is not encrypted)
    sta level_encrypted                 ; ...so the level at &2700 is plain until saved
    lda #inkey_key_comma                ; Map cursor keys: left...
    sta key_left                        ; Comma moves the map cursor left
    lda #inkey_key_full_stop            ; ...right...
    sta key_right                       ; Full stop moves it right
    lda #inkey_key_a                    ; ...up...
    sta key_up                          ; A moves it up
    lda #inkey_key_z                    ; ...down
    sta key_down                        ; Z moves it down
    lda #max_slot                       ; 80 item slots, 0-&4F
    sta last_slot                       ; Slots are searched from the last, &4F, down
    ldx #<(tv_command)                  ; *TV255 1: shift the picture a line, interlace off
    ldy #>(tv_command)                  ; ...high byte of the command
    jsr oscli                           ; ...taking effect at the MODE 7 change below
    lda #3                              ; VDU 3: printer off
    jsr oswrch                          ; Stop any printer output
    lda #&16                            ; VDU 22,7: MODE 7
    jsr oswrch                          ; Send the mode change...
    lda #7                              ; ...for MODE 7...
    jsr oswrch                          ; ...where the questions are asked
    ldx #<(edit_or_new_prompt)          ; Ask: edit (E) or new level (N)
    ldy #>(edit_or_new_prompt)          ; ...high byte of the prompt
    lda #&22                            ; Internal key &22, E: answer 0, edit...
    sta scratch                         ; ...as ask_key's first key
    lda #&55 ; 'U'                      ; Internal key &55, N: answer 1, new level...
    sta scratch_hi                      ; ...as ask_key's second key
    lda #0                              ; A = 0: take one of the two keys
    jsr ask_key                         ; Ask, and get 0 for edit or 1 for new
    sta new_level_flag                  ; Remember the choice for start_editing: 1 for new
    beq edit_level                      ; E: edit a level file
    jmp new_level                       ; N: start with an empty level
; &1c7d referenced 1 time by &1c78
.edit_level
    jsr new_lines                       ; Leave a blank line under the question
    jsr choose_filing_system            ; Choose disc or tape (and the drive)
    lda #' '                            ; Blank the filename in load_command...
    ldx #5                              ; From the name field at load_command+5...
; &1c87 referenced 1 time by &1c8d
.blank_load_name
    sta load_command,x                  ; ...put a space...
    inx                                 ; ...in each character...
    cpx #&0c                            ; ...up to load_command+11...
    bne blank_load_name                 ; ...so no longer earlier name is left in it
    jsr ask_filename                    ; Read the filename (L if none is typed)
    lda #&0a                            ; Line feed
    jsr oswrch                          ; Leave a blank line under the typed name
    lda #' '                            ; A space at the name's last character...
    sta load_command + 11               ; ...already blank: the space at +12 ends the name
    ldx #0                              ; Copy the filename typed into load_command...
; &1c9e referenced 1 time by &1ca7
.copy_load_name
    lda filename_buffer,x               ; Take a character of the typed name...
    sta load_command + 5,x              ; ...into the command's name field...
    inx                                 ; ...the next character...
    cpx scratch                         ; ...for the name's length, without its CR...
    bne copy_load_name                  ; ...until the name is copied
    ldx #<(load_command)                ; *LOAD name 2700
    ldy #>(load_command)                ; ...high byte of the command
    jsr oscli                           ; Load the level file at &2700, still encrypted
    jmp start_editing                   ; Edit it: start_editing decrypts and draws it
; ***************************************************************************************
; Print a prompt and wait for one of its keys
;
; Print the text at XY up to its '*', flush the input buffer and scan the keyboard until
; an answer is pressed. With A=0 the answers are the two keys whose internal numbers are
; in scratch and scratch_hi, and A returns 0 or 1. Otherwise the answers are the digits
; 0-3 (drive_keys), and the digit is printed. The keys are read by scanning, so the key
; pressed is left in the input buffer; ask_filename flushes it. Used for edit or new,
; disc or tape, the drive, and another level or quit.
;
; On Entry:
;     A: 0 for two keys, else a drive digit
;     X: prompt address, low byte
;     Y: prompt address, high byte
;     SCRATCH: first key's internal number (A=0)
;     SCRATCH_HI: second key's internal number (A=0)
;
; On Exit:
;     A: 0 or 1 for the key pressed (A=0 on entry); else the digit's character
;     Y: the digit, 0-3 (A non-zero on entry)
; &1cb3 referenced 4 times by &1c72, &2113, &2128, &238d
.ask_key
    pha                                 ; Keep the mode: 0 for two answer keys, else digits
    stx plot_x                          ; Point plot_x/plot_y at the prompt...
    sty plot_y                          ; ...high byte: the prompt's address
    ldy #0                              ; Print it up to the '*'...
; &1cba referenced 1 time by &1cc4
.print_prompt
    lda (plot_x),y                      ; Take a character of the prompt...
    jsr oswrch                          ; ...show it...
    iny                                 ; ...move to the next...
    lda (plot_x),y                      ; ...and look ahead at it:
    cmp #'*'                            ; The '*' ends the prompt...
    bne print_prompt                    ; ...so print until it
    lda #osbyte_flush_buffer_class      ; Flush the input buffer
    jsr osbyte                          ; Discard keys pressed before the prompt  Flush selected class of buffer
; &1ccb referenced 2 times by &1cdf, &1cf1
.scan_keys
    lda #osbyte_scan_keyboard_from_16   ; OSBYTE &7A: scan the keyboard from key 16...
    jsr osbyte                          ; ...X = the internal number of a key held, or &FF  Scan keyboard from key 16
    pla                                 ; Which mode?
    pha                                 ; ...keeping the mode for the next pass
    beq check_two_keys                  ; Two keys
    ldy #3                              ; Digits: is it 0, 1, 2 or 3?
; &1cd6 referenced 1 time by &1cdd
.check_digit
    txa                                 ; The internal key number pressed...
    cmp drive_keys,y                    ; ...against digit Y's key...
    beq digit_pressed                   ; Match: digit Y was pressed
    dey                                 ; No: try the digit below...
    bpl check_digit                     ; ...down to 0
    bmi scan_keys                       ; Not a drive digit: scan again
; &1ce1 referenced 1 time by &1cda
.digit_pressed
    pla                                 ; Drop the kept mode
    tya                                 ; The digit's value, 0-3...
    clc                                 ; ...plus '0'...
    adc #'0'                            ; ...as its character...
    jsr oswrch                          ; ...echoed after the prompt
    rts                                 ; Return the digit's character, for *DRIVE
; &1cea referenced 1 time by &1cd2
.check_two_keys
    txa                                 ; The first key?
    cmp scratch                         ; Is it the first answer's key...
    beq first_key                       ; Yes: first key
    cmp scratch_hi                      ; The second key?
    bne scan_keys                       ; Neither answer: scan again
    pla                                 ; Second: drop the kept mode
    lda #1                              ; The second answer: 1
    rts                                 ; Return the answer in A
; &1cf7 referenced 1 time by &1ced
.first_key
    pla                                 ; First: drop the kept mode
    lda #0                              ; The first answer: 0
    rts                                 ; Return the answer in A
; ***************************************************************************************
; Prompts and commands
;
; Prompts end with '*' (for ask_key) or a zero (printed by callers); commands end with
; CR. load_command's filename is copied in from the filename buffer.
.edit_or_new_prompt
    equs "Edit (E) or start new level (N) *"  ; editor_init's first question, for ask_key
.disc_or_tape_prompt
    equs "Disc (D) or tape (T) *"       ; choose_filing_system's question, for ask_key
; &1d32 used as index base 1 time by &1e3d
.filename_prompt
    equs "Filename "                    ; Printed by ask_filename; the name is typed after it
    equb &00                            ; Zero: the end
.drive_prompt
    equs "Which drive *"                ; Asked after *DISC; answered with a digit 0-3
.drive_command
    equs "DRIVE"
; &1d4e referenced 1 time by &212b
.drive_digit
    equb &20                            ; The drive digit
    equb &0d                            ; CR
; &1d50 referenced 4 times by &1e84, &2283, &22b5, &22bd; also used as index base 2 times by &1c9e, &2368
.filename_buffer
; &1d51 referenced 3 times by &2286, &22ae, &22cf
    equb &2a, &2a, &2a, &2a, &2a, &2a, &2a, &2a
; &1d58 referenced 2 times by &1e4e, &228b
.read_line_block
; &1d59 referenced 2 times by &1e53, &2290
; &1d5a referenced 2 times by &1e58, &2295
; &1d5b referenced 2 times by &1e5d, &229a
; &1d5c referenced 2 times by &1e62, &229f
    equb &2a, &2a, &2a, &2a, &2a
; &1d5d used as index base 1 time by &1c87
.load_command
; &1d62 used as index base 1 time by &1ca1
; &1d68 referenced 1 time by &1c99
    equs "LOAD LEVEL11 2700", &0d
.drive_0_command
    equs "DRIVE0", &0d
.disc_command
    equs "DISC", &0d
.tv_command
    equs "TV255 1", &0d
.tape_command
    equs "TAPE", &0d
.cat_command
    equs "CAT", &0d
; &1d8c used as index base 1 time by &219a
.count_labels
    equb &1f, &10, &00                  ; VDU 31,16,0: TAB(16,0)
    equs "Objs"
    equb &1f, &10, &04                  ; VDU 31,16,4: TAB(16,4)
    equs "Mons"
    equb &1f, &10, &08                  ; VDU 31,16,8: TAB(16,8)
    equs "Dors"
    equb &0d                            ; CR: the end
; &1da2 used as index base 1 time by &2140
.edit_screen_vdu
    equb &17, &00, &0a, &20, &00, &00, &00, &00, &00, &00  ; VDU 23,0,10,32: 6845 register 10 = &20, no cursor
    equb &00                            ; VDU 0: does nothing
    equb &17, &00, &06, &1e, &00, &00, &00, &00, &00, &00  ; VDU 23,0,6,30: 6845 register 6 = 30 character rows displayed
    equb &13, &0a, &01, &00, &00, &00   ; VDU 19,10,1: logical colour 10 shows red
    equb &13, &09, &03, &00, &00, &00   ; VDU 19,9,3: logical colour 9 shows yellow
; ***************************************************************************************
; Unused
;
; Four asterisks, not sent.
.edit_screen_vdu_end
    equb &2a, &2a, &2a, &2a             ; Not used
; &1dc7 used as index base 1 time by &2272
.level_number_prompt
    equs "Level in the Dunjunz complex ", &00  ; Asked when saving: the level number
; &1de5 used as index base 1 time by &2356
.save_command
; &1dea used as index base 1 time by &236b
    equs "SAVE LEVEL22 2700+2B0", &0d   ; *SAVE the &2B0-byte level file from &2700
.another_prompt
    equs "Another level (A) or quit (Q) *"  ; Asked after a save, for ask_key
; ***************************************************************************************
; Print a new line and a blank line
;
; CR, LF, LF: spaces out the MODE 7 questions.
;
; On Exit:
;     A: corrupted
;     X: preserved
;     Y: preserved
; &1e1a referenced 6 times by &1c7d, &1e38, &211f, &23d2, &23d8, &23e2
.new_lines
    lda #&0d                            ; CR
    jsr oswrch                          ; Start a new line
    lda #&0a                            ; LF, twice
    jsr oswrch                          ; Down one line...
    jsr oswrch                          ; ...and another, leaving a blank line
    rts                                 ; Return
; ***************************************************************************************
; Ask for a filename
;
; Pause, flush the input buffer (which still holds the key that answered ask_key's last
; question), prompt and read up to seven characters into filename_buffer with OSWORD 0.
; If only RETURN is typed, write 'L' after the prompt and use the name L. Used for both
; the file to load and the file to save.
;
; On Exit:
;     SCRATCH: the name's length, without its CR (at least 1)
; &1e28 referenced 2 times by &1c8f, &235e
.ask_filename
    ldx #0                              ; Pause for 256 x 256 loops...
; &1e2a referenced 1 time by &1e31
.pause_outer
    ldy #0                              ; Each outer pass...
; &1e2c referenced 1 time by &1e2e
.pause_inner
    nop                                 ; ...wastes time...
    dey                                 ; ...256 times...
    bne pause_inner                     ; ...in the inner loop...
    dex                                 ; ...for 256 outer passes...
    bne pause_outer                     ; ...a short wait after the last answer
    lda #osbyte_flush_buffer_class      ; Flush buffers (X = 0: all)
    jsr osbyte                          ; Drop the answer key, so it is not read as the name  Flush selected class of buffer
    jsr new_lines                       ; Leave a blank line before the prompt
    ldx #0                              ; Print the filename prompt, up to and including its zero
; &1e3d referenced 1 time by &1e46
.print_filename_prompt
    lda filename_prompt,x               ; Take a character of the prompt...
    jsr oswrch                          ; ...show it...
    inx                                 ; ...the next...
    cmp #0                              ; ...the zero ends it...
    bne print_filename_prompt           ; ...and is printed too
    ldx #<(read_line_block)             ; Point XY at read_line_block...
    ldy #>(read_line_block)             ; ...high byte of the block
    lda #<(filename_buffer)             ; ...buffer filename_buffer...
    sta read_line_block                 ; ...low byte of the buffer...
    lda #>(filename_buffer)             ; ...high byte of the buffer...
    sta read_line_block + 1             ; ...high byte
    lda #7                              ; ...at most 7 characters...
    sta read_line_block + 2             ; ...a DFS filename's length
    lda #' '                            ; ...from space...
    sta read_line_block + 3             ; ...lowest character accepted...
    lda #'~'                            ; ...to '~'
    sta read_line_block + 4             ; ...highest character accepted
    lda #osword_read_line               ; OSWORD 0: read the name
    jsr osword                          ; Read the filename the user types  Read line from input stream (exits with C=1 if ESCAPE pressed)
    sty scratch                         ; Keep its length, not counting the CR
    cpy #0                              ; Anything typed?
    bne filename_read                   ; A name was typed: return
    lda #&0b                            ; Only RETURN: VDU 11, up a line...
    jsr oswrch                          ; ...back onto the prompt line
    lda #9                              ; ...and VDU 9, right...
    ldy #9                              ; ...nine times...
; &1e79 referenced 1 time by &1e7d
.move_right
    jsr oswrch                          ; ...stepping right...
    dey                                 ; ...counting the steps...
    bne move_right                      ; ...past 'Filename '
    lda #'L'                            ; ...show 'L'...
    jsr oswrch                          ; ...as if typed
    sta filename_buffer                 ; ...and use it as the name
    iny                                 ; Length 1 (Y is 0 after the loop)
    sty scratch                         ; ...as the name's length
    jsr osnewl                          ; New line, as RETURN gave before
; &1e8d referenced 1 time by &1e6e
.filename_read
    rts                                 ; Return
; ***************************************************************************************
; Start a new, empty level
;
; Reached from editor_init when N is chosen. Fill the level's wall block (&30 bytes at
; &2980) with &03, which choose_wall_block replaces with a block from Stones when the
; level is saved, then fall into start_editing, which sees new_level_flag set and draws
; an empty map.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: preserved
; &1e8e referenced 1 time by &1c7a
.new_level
    lda #3                              ; Fill level_wall_block with &03...
    ldx #wall_block_bytes - 1           ; ...for all &30 bytes...
; &1e92 referenced 1 time by &1e96
.fill_wall_block
    sta level_wall_block,x              ; ...the block a new level starts with...
    dex                                 ; ...from the last byte...
    bpl fill_wall_block                 ; ...to the first, then fall into start_editing
; ***************************************************************************************
; Set up the editing screen and edit
;
; Reached from editor_init once a level file is loaded, and from new_level. Clear the
; wall map and the item slots, select MODE 2, disarm the BREAK intercept, set up the edit
; screen (no cursor, 30 rows, colours 10 and 9), copy unpack_level and mark_object_cell
; to &7B00 and &7D80, set every bit of the object-free map, free every door-key link, set
; GCOL 3,3 for the link lines, zero the counts and turn off cursor editing. For a loaded
; level, decrypt it, take any object of type &73 off the map (the Chalice, which only
; level 25 has and the editor has no item for), unpack it into the slots and maps, plot
; every occupied cell and take the exit as placed. Then fill the level file's object,
; door and key tables with &FF, ready for pack_level to pack the slots into, show the
; labels and counts, put the cursor at (11, 11) with the wall as the item, the slow
; cursor on and colour 10 red, and fall into edit_loop.
; &1e98 referenced 1 time by &1cb0
.start_editing
    lda #0                              ; Clear wall_map...
    tax                                 ; ...from offset 0...
; &1e9b referenced 1 time by &1e9f
.clear_walls
    sta wall_map,x                      ; ...no walls in this byte...
    dex                                 ; ...the next byte down...
    bne clear_walls                     ; ...through all 256
; &1ea1 referenced 1 time by &1ea5
.clear_slots
    sta slot_x,x                        ; ...and the item slots (&0C00-&0CFF)
    dex                                 ; ...one byte of the slot tables...
    bne clear_slots                     ; ...through all 256: every slot free
    lda #0                              ; Cursor flash phase 0...
    sta cursor_flash                    ; ...so the first wall pass plots the cursor
    lda #0                              ; Door-key link 0...
    sta link_index                      ; ...is the first to be made
    lda #&16                            ; VDU 22,2: MODE 2
    jsr oswrch                          ; Send the mode change...
    lda #2                              ; ...for MODE 2...
    jsr oswrch                          ; ...the 16-colour screen the map is drawn on
    lda #0                              ; Not a JMP: disarm the BREAK intercept...
    sta os_break_intercept              ; ...so BREAK while editing is an ordinary reset
    jsr set_edit_screen                 ; No cursor, 30 rows, colours 10 and 9
    ldx #0                              ; Copy unpack_level to &7B00...
; &1ec5 referenced 1 time by &1ece
.copy_unpack
    lda unpack_level_image,x            ; Take a byte of the stored routine...
    sta unpack_level,x                  ; ...to &7B00, where it runs...
    inx                                 ; ...the next...
    cpx #&ce                            ; ...for unpack_level's &CE bytes...
    bne copy_unpack                     ; ...until it is all copied
    ldx #0                              ; ...and mark_object_cell to &7D80
; &1ed2 referenced 1 time by &1edb
.copy_mark_object_cell
    lda mark_object_cell_image,x        ; Take a byte of the stored routine...
    sta mark_object_cell,x              ; ...to &7D80, where it runs...
    inx                                 ; ...the next...
    cpx #&43 ; 'C'                      ; ...for mark_object_cell's &43 bytes...
    bne copy_mark_object_cell           ; ...until it is all copied
    lda #&ff                            ; Every cell object-free...
    ldx #0                              ; ...from offset 0...
; &1ee1 referenced 1 time by &1ee5
.clear_free_map
    sta object_free_map,x               ; ...set every bit: no object anywhere...
    dex                                 ; ...the next byte down...
    bne clear_free_map                  ; ...through all 256
; &1ee7 referenced 1 time by &1ef0
.clear_links
    sta link_door,x                     ; ...and &FF: all 20 door-key links unused
    sta link_key,x                      ; ...no key for it...
    inx                                 ; ...the next link...
    cpx #max_link + 1                   ; ...all 20 of them...
    bne clear_links                     ; ...until every link is free
    sta pending_door_item               ; &FF: no door waiting for its key
    lda #&12                            ; VDU 18,3,3: GCOL 3,3 (exclusive-OR, for the link lines)
    jsr oswrch                          ; Send GCOL...
    lda #3                              ; ...mode 3: exclusive-OR, so a line...
    jsr oswrch                          ; ...drawn twice is erased...
    jsr oswrch                          ; ...in colour 3
    lda #0                              ; No trapdoors, objects, exit or doors
    sta trapdoor_count                  ; No trapdoors yet
    sta door_count                      ; No doors yet
    sta exit_placed                     ; No exit yet
    sta object_count                    ; No objects yet
    lda #osbyte_set_cursor_editing      ; OSBYTE 4,1: cursor editing off...
    ldx #1                              ; ...X = 1: the arrow keys give codes &88-&8B
    jsr osbyte                          ; Set it; the editor reads the arrow keys by scanning  Set cursor editing keys
    lda new_level_flag                  ; New level?
    beq unpack_loaded                   ; No: unpack the loaded one
    lda #0                              ; Yes: link_index = 0...
    sta link_index                      ; ...again (it was set above)
    beq clear_level_tables              ; ...and clear the level tables (always branches)
; &1f1f referenced 1 time by &1f16
.unpack_loaded
    jsr crypt_level                     ; Decrypt the loaded level in place at &2700
    ldx #max_object - 1                 ; Find an object of type &73 (the Chalice)...
; &1f24 referenced 1 time by &1f2c
.find_chalice
    lda level_object_type,x             ; This object's type...
    cmp #game_chalice_type              ; ...the Chalice?
    beq drop_chalice                    ; Yes: take it off the map
    dex                                 ; No: the next object down...
    bne find_chalice                    ; ...to object 1 (not the exit, 30)
    beq draw_loaded                     ; No Chalice: unpack the level as it is
; &1f30 referenced 1 time by &1f29
.drop_chalice
    lda #off_map                        ; Drop it: x and y &FF
    sta level_object_x,x                ; ...so unpack_level skips it: the editor...
    sta level_object_y,x                ; ...has no item for the Chalice
; &1f38 referenced 1 time by &1f2e
.draw_loaded
    jsr unpack_level                    ; Unpack the level into the slots and maps
    jsr show_labels                     ; Show the labels...
    jsr show_counts                     ; ...and the unpacked level's counts
    lda #0                              ; Draw every cell: rows 0-47...
    sta cursor_y                        ; ...from the top row
; &1f45 referenced 1 time by &1f61
.draw_row
    lda #0                              ; ...columns 0-31...
    sta cursor_x                        ; ...from the left column
; &1f49 referenced 1 time by &1f59
.draw_cell
    jsr item_at_cursor                  ; ...the item in this cell, if any
    cmp #&ff                            ; &FF: nothing here
    beq next_cell                       ; Empty: nothing to plot
    jsr plot_at_cursor                  ; Plot the item's sprite in the cell
; &1f53 referenced 1 time by &1f4e
.next_cell
    inc cursor_x                        ; Next column
    lda cursor_x                        ; Which column now?
    cmp #map_width                      ; Past the last column?
    bne draw_cell                       ; No: draw the next cell
    inc cursor_y                        ; Next row
    lda cursor_y                        ; Which row now?
    cmp #map_height                     ; Past the last row?
    bne draw_row                        ; No: draw the next row
    lda #1                              ; Take a loaded level to have its exit...
    sta exit_placed                     ; ...which SHIFT+S needs before it saves
; &1f67 referenced 1 time by &1f1d
.clear_level_tables
    lda #off_map                        ; Clear the level file's object tables...
    ldx #max_object - 1                 ; ...objects 29 to 1 (the exit is 30)...
; &1f6b referenced 1 time by &1f72
.clear_object_entries
    sta level_object_x,x                ; ...off the map...
    sta level_object_y,x                ; ...both x and y...
    dex                                 ; ...the next object down...
    bne clear_object_entries            ; ...until all are cleared
    ldx #max_door                       ; ...and the door and key tables, for pack_level
; &1f76 referenced 1 time by &1f83
.clear_door_entries
    sta level_door_x,x                  ; ...door off the map...
    sta level_door_y,x                  ; ...its y too...
    sta level_key_x,x                   ; ...its key off the map...
    sta level_key_y,x                   ; ...and its y
    dex                                 ; ...the next door down...
    bne clear_door_entries              ; ...until doors 20 to 1 are cleared
    jsr show_labels                     ; Show the labels (again, for a loaded level)...
    jsr show_counts                     ; ...and the counts
    lda #&0b                            ; Cursor at (11, 11)...
    sta cursor_x                        ; ...column 11...
    sta cursor_y                        ; ...row 11: a corner of the heroes' start
    lda #0                              ; ...placing walls
    sta current_item                    ; ...item 0, the wall
    lda #1                              ; Slow cursor on, colour 10 = 1
    sta slow_cursor                     ; Move the cursor every third frame
    sta colour_10                       ; Logical colour 10 shows red, as set above
    lda #osbyte_set_cursor_editing      ; OSBYTE 4,1 again...
    ldx #1                              ; ...X = 1: cursor editing off...
    jsr osbyte                          ; ...a repeat of the call above  Set cursor editing keys
; ***************************************************************************************
; The editing loop
;
; Each pass: wait three frames when the slow cursor is on; f0 toggles it. SHIFT+S saves,
; once the exit, all eight trapdoors and a key for every door are placed. Then move the
; cursor (',' '.' 'A' 'Z'), flash it when placing walls, change colour 10 (cursor up and
; down), choose the item ('1' and '2'), place it (SPACE, repeating while held), delete
; what is under the cursor (TAB) and show the door-key links while CTRL is held.
; &1fa4 referenced 2 times by &208f, &20df
.edit_loop
    lda slow_cursor                     ; Slow cursor?
    beq check_f0                        ; No: a pass as fast as it runs
    ldx #3                              ; Yes: wait for three frames...
; &1fab referenced 1 time by &1fb5
.slow_wait
    txa                                 ; Keep the frame count...
    pha                                 ; ...across the call...
    lda #osbyte_vsync                   ; OSBYTE &13: wait for the next frame
    jsr osbyte                          ; ...so the cursor steps one cell per three frames  Wait for vertical sync
    pla                                 ; Recover the frame count...
    tax                                 ; ...into X
    dex                                 ; One frame done...
    bne slow_wait                       ; ...until three have passed
; &1fb7 referenced 1 time by &1fa7
.check_f0
    ldx #inkey_key_f0                   ; f0?
    jsr key_pressed                     ; ...held?
    bne check_save                      ; No: check for SHIFT+S
    lda slow_cursor                     ; Yes: toggle the slow cursor...
    eor #1                              ; ...between on and off...
    sta slow_cursor                     ; ...and keep the new setting
; &1fc6 referenced 1 time by &1fcb
.wait_f0_released
    ldx #inkey_key_f0                   ; ...and wait for f0 to be released
    jsr key_pressed                     ; ...still held?
    beq wait_f0_released                ; Still held: keep waiting
; &1fcd referenced 1 time by &1fbc
.check_save
    ldx #inkey_key_s                    ; S...
    jsr key_pressed                     ; ...held?
    bne edit_keys                       ; No: the editing keys
    ldx #inkey_key_shift                ; ...with SHIFT?
    jsr key_pressed                     ; ...held as well?
    bne edit_keys                       ; No: the editing keys
    lda exit_placed                     ; Yes: is the exit placed...
    beq edit_keys                       ; No: cannot save yet
    jsr check_door_keys                 ; ...does every door have its key...
    bne edit_keys                       ; No: cannot save yet
    lda trapdoor_count                  ; ...and are all 8 trapdoors placed?
    cmp #8                              ; ...all 8?
    bne edit_keys                       ; No: cannot save yet
    ldx #<(disc_command)                ; Yes: *DISC...
    ldy #>(disc_command)                ; ...(Stones, the wall blocks, is read from disc)
    jsr oscli                           ; ...select the disc filing system
    ldx #<(drive_0_command)             ; ...*DRIVE 0
    ldy #>(drive_0_command)             ; ...high byte of the command's address
    jsr oscli                           ; ...select drive 0, where Stones is
    jsr wall_edges                      ; Wall in the map's four edges
    jsr pack_level                      ; Pack the slots and maps into the level file
    jsr choose_wall_block               ; Choose its wall block from Stones
    lda #&16                            ; VDU 22,7: MODE 7
    jsr oswrch                          ; ...send the MODE number
    lda #7                              ; ...7, so the save prompts are in text
    jsr oswrch                          ; ...send it
    jsr save_level                      ; Save it: ends by restarting the editor or resetting
    rts                                 ; Not reached: save_level never returns
; &200f referenced 5 times by &1fd2, &1fd9, &1fdd, &1fe2, &1fe8
.edit_keys
    jsr move_cursor                     ; Move the cursor, redrawing the cell it leaves
    lda current_item                    ; Placing walls?
    bne check_cursor_up                 ; Not walls: the item itself shows as the cursor
    lda cursor_flash                    ; Yes: flash the cursor sprite over the wall...
    eor #1                              ; ...toggling cursor_flash each pass...
    sta cursor_flash                    ; ...and keeping it
    beq check_cursor_up                 ; Off this pass: move_cursor's wall sprite shows
    lda #spr_cursor                     ; On: the cursor sprite...
    jsr plot_at_cursor                  ; ...over the wall move_cursor drew
; &2025 referenced 2 times by &2014, &201e
.check_cursor_up
    ldx #inkey_key_up                   ; Cursor up?
    jsr key_pressed                     ; ...(Z set if pressed)
    bne check_cursor_down               ; Not pressed: try cursor down
    inc colour_10                       ; Yes: colour 10 up, to at most 7...
    lda colour_10                       ; ...read the new colour...
    cmp #8                              ; ...past 7 (white)?
    bne set_colour_up                   ; No: use it
    dec colour_10                       ; Yes: back to 7
; &2039 referenced 1 time by &2034
.set_colour_up
    jsr set_colour_10                   ; ...set it...
; &203c referenced 1 time by &2041
.wait_up_released
    ldx #inkey_key_up                   ; ...and wait for the key to be released
    jsr key_pressed                     ; ...(Z set while held)
    beq wait_up_released                ; Still held: keep waiting, one step a press
; &2043 referenced 1 time by &202a
.check_cursor_down
    ldx #inkey_key_down                 ; Cursor down?
    jsr key_pressed                     ; ...(Z set if pressed)
    bne check_item_keys                 ; Not pressed: go on to the item keys
    dec colour_10                       ; Yes: colour 10 down, to at least 1...
    bne set_colour_down                 ; Still 1 or more: use it
    inc colour_10                       ; Down to 0 (black): back to 1
; &2052 referenced 1 time by &204d
.set_colour_down
    jsr set_colour_10                   ; ...set it...
; &2055 referenced 1 time by &205a
.wait_down_released
    ldx #inkey_key_down                 ; ...and wait for the key to be released
    jsr key_pressed                     ; ...(Z set while held)
    beq wait_down_released              ; Still held: keep waiting, one step a press
; &205c referenced 1 time by &2048
.check_item_keys
    jsr show_cursor_position            ; Print the cursor's x and y beside the map
    ldx #inkey_key_1                    ; '1'?
    jsr key_pressed                     ; ...(Z set if pressed)
    bne check_next_item                 ; Not pressed: try '2'
    dec current_item                    ; Yes: the previous item, to at least 0
    bpl check_space                     ; Still 0 or more: go on
    lda #0                              ; Below item 0: stay at item 0 (walls)
    sta current_item                    ; ...keep it at item 0
    beq check_space                     ; Go on to SPACE (always branches)
; &2070 referenced 1 time by &2064
.check_next_item
    ldx #inkey_key_2                    ; '2'?
    jsr key_pressed                     ; ...(Z set if pressed)
    bne check_space                     ; Not pressed: go on to SPACE
    inc current_item                    ; Yes: the next item, to at most &0F
    lda current_item                    ; ...read it...
    cmp #spr_blank                      ; ...past the last item, the key (&0F)?
    bne check_space                     ; No: keep it
    dec current_item                    ; Yes: back to the key
; &2081 referenced 4 times by &2068, &206e, &2075, &207d
.check_space
    ldx #inkey_key_space                ; SPACE?
    jsr key_pressed                     ; ...(Z set if pressed)
    bne check_tab                       ; Not pressed: try TAB
    lda current_item                    ; Placing walls?
    bne place_not_edge                  ; No: an item, which may not go on the edge
    jsr place_item                      ; Yes: place a wall, anywhere
    jmp edit_loop                       ; Next pass: walls repeat while SPACE is held
; &2092 referenced 1 time by &208a
.place_not_edge
    lda cursor_x                        ; Other items: not on the edges, which are walled...
    beq next_pass                       ; Column 0: refuse
    cmp #map_width - 1                  ; ...the right-hand column?
    beq next_pass                       ; Yes: refuse
    lda cursor_y                        ; ...row 0...
    beq next_pass                       ; Row 0: refuse
    cmp #map_height - 1                 ; ...or the bottom row?
    beq next_pass                       ; Yes: refuse
    jsr place_item                      ; Place the item, within its limits
    jsr show_counts                     ; Update the counts beside the map
; &20a8 referenced 1 time by &20b1
.wait_space_released
    ldx #inkey_key_space                ; Wait for SPACE to be released...
    jsr key_pressed                     ; ...(Z set while held)
    bne check_tab                       ; Released: go on to TAB
    lda current_item                    ; ...an item, never walls, is chosen here...
    bne wait_space_released             ; ...so keep waiting: one item per press
; &20b3 referenced 2 times by &2086, &20ad
.check_tab
    ldx #inkey_key_tab                  ; TAB?
    jsr key_pressed                     ; ...(Z set if pressed)
    bne check_ctrl                      ; Not pressed: try CTRL
    jsr delete_item                     ; Yes: delete what is under the cursor...
    jsr show_counts                     ; ...and update the counts
; &20c0 referenced 1 time by &20c9
.wait_b_released
    ldx #inkey_key_b                    ; Wait while B (not TAB) is held, with an item chosen...
    jsr key_pressed                     ; ...(Z set while held)
    bne check_ctrl                      ; B not held: go on to CTRL
    lda current_item                    ; ...is an item chosen?
    bne wait_b_released                 ; Yes: keep waiting while B is held
; &20cb referenced 2 times by &20b8, &20c5
.check_ctrl
    ldx #inkey_key_ctrl                 ; CTRL?
    jsr key_pressed                     ; ...(Z set if pressed)
    bne next_pass                       ; Not pressed: next pass
    jsr draw_links                      ; Yes: draw the door-key links...
; &20d5 referenced 1 time by &20da
.wait_ctrl_released
    ldx #inkey_key_ctrl                 ; ...while CTRL is held...
    jsr key_pressed                     ; ...(Z set while held)
    beq wait_ctrl_released              ; Still held: keep the lines showing
    jsr draw_links                      ; ...then draw them again, which erases them
; &20df referenced 5 times by &2094, &2098, &209c, &20a0, &20d0
.next_pass
    jmp edit_loop                       ; Next pass
; ***************************************************************************************
; Check that every door has its key
;
; Count the door-key links in use and compare with door_count. A link is made only when a
; key is placed for a waiting door, and each door has at most one, so equal counts mean
; that no door lacks its key. The edit loop requires it before saving.
;
; On Exit:
;     Z: set if every door has a key
; &20e2 referenced 1 time by &1fdf
.check_door_keys
    lda #0                              ; Count the links in use...
    sta scratch                         ; ...in scratch...
    ldx #max_link                       ; ...over links 19 to 0
; &20e8 referenced 1 time by &20f0
.count_links
    lda link_door,x                     ; This link's door slot...
    bmi next_link                       ; ...negative: the link is free
    inc scratch                         ; In use: count it
; &20ef referenced 1 time by &20eb
.next_link
    dex                                 ; Next link
    bpl count_links                     ; ...until all 20 are counted
    lda scratch                         ; ...and compare with the doors
    cmp door_count                      ; ...Z set if every door has its key
    rts                                 ; Return
; ***************************************************************************************
; Test a key
;
; The edit loop's key test: OSBYTE &81 with the INKEY number in X.
;
; On Entry:
;     X: INKEY number (negative, as a byte)
;
; On Exit:
;     Z: set if the key is pressed
; &20f7 referenced 16 times by &1fb9, &1fc8, &1fcf, &1fd6, &2027, &203e, &2045, &2057, &2061, &2072, &2083, &20aa, &20b5, &20c2, &20cd, &20d7
.key_pressed
    lda #osbyte_inkey                   ; OSBYTE &81: scan the key...
    ldy #&ff                            ; ...Y = &FF: test the key whose INKEY number is X
    jsr osbyte                          ; Scan it: X = Y = &FF if the key is held  Test whether the key with negative INKEY number X is pressed
    cpy #&ff                            ; Z set if X and Y are both &FF
    bne key_pressed_done                ; Y not &FF: not pressed (Z clear)
    cpx #&ff                            ; ...Z set if X is &FF too: pressed
; &2104 referenced 1 time by &2100
.key_pressed_done
    rts                                 ; Return
; ***************************************************************************************
; Ask for disc or tape
;
; Called before a level is loaded, by save_level before the filename, and by catalogue
; before *CAT. Disc: *DISC, then ask for the drive (0-3) and *DRIVE it. Tape: *TAPE.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &2105 referenced 3 times by &1c80, &234f, &23d5
.choose_filing_system
    ldx #<(disc_or_tape_prompt)         ; Ask: disc (D) or tape (T)
    ldy #>(disc_or_tape_prompt)         ; ...high byte of the prompt
    lda #&32 ; '2'                      ; ...first answer: D (internal key &32)...
    sta scratch                         ; ...for ask_key
    lda #&23 ; '#'                      ; ...second answer: T (internal key &23)
    sta scratch_hi                      ; ...for ask_key
    lda #0                              ; ...A = 0: one of two keys
    jsr ask_key                         ; ...ask, A = 0 for D or 1 for T
    bne choose_tape                     ; T: tape
    ldx #<(disc_command)                ; D: *DISC
    ldy #>(disc_command)                ; ...high byte of the command
    jsr oscli                           ; ...select the disc filing system
    jsr new_lines                       ; New line
    ldx #<(drive_prompt)                ; Ask which drive...
    ldy #>(drive_prompt)                ; ...high byte of the prompt
    lda #1                              ; ...A = 1: answer with a drive digit
    jsr ask_key                         ; ...ask, A = the digit typed
    sta drive_digit                     ; ...and put the digit in drive_command
    ldx #<(drive_command)               ; *DRIVE n
    ldy #>(drive_command)               ; ...high byte of the command
    jsr oscli                           ; ...select that drive
    rts                                 ; Return
; &2136 referenced 1 time by &2116
.choose_tape
    ldx #<(tape_command)                ; Tape: *TAPE
    ldy #>(tape_command)                ; ...high byte of the command
    jsr oscli                           ; ...select the cassette filing system
    rts                                 ; Return
; ***************************************************************************************
; Send edit_screen_vdu
;
; No cursor, 30 rows, and colours 10 and 9.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: preserved
; &213e referenced 1 time by &1ec0
.set_edit_screen
    ldx #0                              ; Send its &21 bytes
; &2140 referenced 1 time by &2149
.send_edit_screen
    lda edit_screen_vdu,x               ; Next byte of the VDU commands...
    jsr oswrch                          ; ...send it
    inx                                 ; ...on to the next
    cpx #edit_screen_vdu_end - edit_screen_vdu  ; ...all &21 sent?
    bne send_edit_screen                ; No: send the next
    rts                                 ; Return
; ***************************************************************************************
; Encrypt or decrypt the level file
;
; Exclusive-OR each byte of &2700-&29AF with the low byte of its address, as the game's
; decrypt_level does at &6B00. Doing it twice restores the bytes. It decrypts a level
; once loaded, and save_level uses it to encrypt the level (decrypting it first when it
; was encrypted by an earlier save).
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &214c referenced 3 times by &1f1f, &22f7, &2347
.crypt_level
    lda #0                              ; Point at &2700, X counting the offset...
    tax                                 ; ...X = 0: the offset within the level
    tay                                 ; ...Y = 0: scratch itself steps
    sta scratch                         ; ...low byte of &2700
    lda #>(level_object_x)              ; ...page &27, the level file
    sta scratch_hi                      ; ...high byte
; &2156 referenced 2 times by &2169, &216f
.crypt_byte
    lda (scratch),y                     ; Exclusive-OR the byte with the offset's low byte...
    stx screen_ptr                      ; ...the offset's low byte, as the key...
    eor screen_ptr                      ; ...applied: XOR again undoes it
    inx                                 ; ...next offset
    sta (scratch),y                     ; ...put the byte back
    inc scratch                         ; Next byte
    bne crypt_check_end                 ; No page crossed
    inc scratch_hi                      ; ...into the next page of the level
; &2165 referenced 1 time by &2161
.crypt_check_end
    lda scratch                         ; Until &29B0
    cmp #<(level_file_end)              ; ...the low byte of &29B0?
    bne crypt_byte                      ; No: next byte
    lda scratch_hi                      ; ...and the high byte?
    cmp #>(level_file_end)              ; ...of &29B0?
    bne crypt_byte                      ; No: next byte
    rts                                 ; Return
; ***************************************************************************************
; Show logical colour 10 as the chosen colour
;
; VDU 19,10,n,0,0,0 with n from colour_10. The edit loop calls it after cursor up or down
; changes colour_10.
;
; On Entry:
;     COLOUR_10: the colour to show
;
; On Exit:
;     A: corrupted
;     X: preserved
;     Y: preserved
; &2172 referenced 2 times by &2039, &2052
.set_colour_10
    lda #&13                            ; VDU 19,10...
    jsr oswrch                          ; ...send VDU 19, redefine a logical colour
    lda #&0a                            ; ...logical colour 10
    jsr oswrch                          ; ...send it
    lda colour_10                       ; ...n...
    jsr oswrch                          ; ...send it
    lda #0                              ; ...0,0,0
    jsr oswrch                          ; ...first
    jsr oswrch                          ; ...second
    jsr oswrch                          ; ...third
    rts                                 ; Return
; ***************************************************************************************
; Print the counts' labels
;
; In colour 1, at column 16 beside the map, on rows 0, 4 and 8: Objs, Mons (the
; trapdoors) and Dors, each above its count. Leaves colour 7 set for the counts.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: preserved
; &218e referenced 2 times by &1f3b, &1f85
.show_labels
    lda #&11                            ; COLOUR 1
    jsr oswrch                          ; ...send the COLOUR code
    lda #1                              ; ...red, for the labels
    jsr oswrch                          ; ...send it
    ldx #0                              ; Print count_labels up to its CR
; &219a referenced 1 time by &21a3
.print_labels
    lda count_labels,x                  ; Next label character...
    jsr oswrch                          ; ...print it
    inx                                 ; ...on to the next
    cmp #&0d                            ; ...the CR at the end?
    bne print_labels                    ; No: print the next
    lda #&11                            ; COLOUR 7
    jsr oswrch                          ; ...send the COLOUR code
    lda #7                              ; ...white, for the counts
    jsr oswrch                          ; ...send it
    rts                                 ; Return
; ***************************************************************************************
; Print the counts
;
; Objects at (17, 2), trapdoors at (17, 6) and doors at (17, 10), each under its label.
; Called when the editor starts and after each SPACE or TAB in the edit loop.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &21b0 referenced 4 times by &1f3e, &1f88, &20a5, &20bd
.show_counts
    ldx #&11                            ; Objects at (17, 2)
    ldy #2                              ; ...row 2
    lda object_count                    ; ...the number of objects placed
    jsr print_number                    ; ...print it
    ldx #&11                            ; Trapdoors at (17, 6)
    ldy #6                              ; ...row 6
    lda trapdoor_count                  ; ...the trapdoors placed, under Mons
    jsr print_number                    ; ...print it
    ldx #&11                            ; Doors at (17, 10)
    ldy #&0a                            ; ...row 10
    lda door_count                      ; ...the number of doors placed
    jsr print_number                    ; ...print it
    rts                                 ; Return
; ***************************************************************************************
; Print the cursor's cell
;
; x at (17, 20) and y at (17, 21), beside the map. The edit loop calls it every pass.
;
; On Entry:
;     CURSOR_X: the cell's column
;     CURSOR_Y: the cell's row
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &21cc referenced 1 time by &205c
.show_cursor_position
    ldx #&11                            ; x at (17, 20)
    ldy #&14                            ; ...row 20
    lda cursor_x                        ; ...the cursor's column
    jsr print_number                    ; ...print it
    ldx #&11                            ; y at (17, 21)
    ldy #&15                            ; ...row 21
    lda cursor_y                        ; ...the cursor's row
    jsr print_number                    ; ...print it
    rts                                 ; Return
; ***************************************************************************************
; Print a two-digit number at a text position
;
; Move the text cursor to (X, Y) with VDU 31 and print A (0-99) as two digits.
;
; On Entry:
;     A: the number
;     X: column
;     Y: row
; &21df referenced 5 times by &21b6, &21bf, &21c8, &21d2, &21db
.print_number
    sta scratch                         ; Keep the number
    tya                                 ; Keep the position...
    pha                                 ; ...row on the stack
    txa                                 ; ...and column
    pha                                 ; ...on the stack
    lda scratch                         ; Tens: count the 10s...
    sec                                 ; ...C set for the subtractions
    ldx #0                              ; ...X counts them
; &21ea referenced 1 time by &21ef
.count_tens
    sbc #&0a                            ; Take away 10...
    bcc tens_counted                    ; ...gone below 0: X is the tens digit
    inx                                 ; ...one more ten
    bne count_tens                      ; ...and again (always branches)
; &21f1 referenced 1 time by &21ec
.tens_counted
    sec                                 ; Units: add the last 10 back
    sbc #&f6                            ; ...(A - &F6 = A + 10)
    tay                                 ; ...Y = the units
    lda #&1f                            ; VDU 31, column, row
    jsr oswrch                          ; ...send VDU 31
    pla                                 ; ...the column
    jsr oswrch                          ; ...send it
    pla                                 ; ...the row
    jsr oswrch                          ; ...send it
    txa                                 ; Tens digit
    clc                                 ; ...C clear for the addition
    adc #'0'                            ; ...as an ASCII digit
    jsr oswrch                          ; ...print it
    tya                                 ; Units digit (C clear)
    adc #'0'                            ; ...as an ASCII digit
    jsr oswrch                          ; ...print it
    rts                                 ; Return
; ***************************************************************************************
; Put walls round the edge of the map
;
; Place a wall in every cell of columns 0 and 31 and rows 0 and 47, through place_item,
; before a level is packed for saving. It leaves cursor_x, cursor_y and current_item
; changed. place_item takes the top-left cell, (0, 0), for a wall already whenever a slot
; is free (see item_at_cursor), so that cell's wall bit is left to save_level.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &2210 referenced 1 time by &1ff8
.wall_edges
    lda #0                              ; Walls...
    sta current_item                    ; ...are the item place_item puts down
    lda #map_height - 1                 ; ...for rows 47 to 0...
    sta cursor_y                        ; ...moving the cursor to each in turn
; &2218 referenced 1 time by &2228
.wall_left_right
    lda #0                              ; ...in column 0...
    sta cursor_x                        ; ...the left edge
    jsr place_item                      ; ...wall it
    lda #map_width - 1                  ; ...and column 31
    sta cursor_x                        ; ...the right edge
    jsr place_item                      ; ...wall it
    dec cursor_y                        ; ...row up
    bpl wall_left_right                 ; ...until row 0 is done
    lda #map_width - 1                  ; For columns 31 to 0...
    sta cursor_x                        ; ...moving the cursor to each in turn
; &222e referenced 1 time by &223e
.wall_top_bottom
    lda #0                              ; ...in row 0...
    sta cursor_y                        ; ...the top edge
    jsr place_item                      ; ...wall it
    lda #map_height - 1                 ; ...and row 47
    sta cursor_y                        ; ...the bottom edge
    jsr place_item                      ; ...wall it
    dec cursor_x                        ; ...column left
    bpl wall_top_bottom                 ; ...until column 0 is done
    rts                                 ; Return
; ***************************************************************************************
; BREAK intercept: back to saving
;
; Called twice during a reset; on the second call, with C set, go back to save_level,
; keeping the packed level in memory.
.break_to_save
    bcs save_level                      ; Second call (after the reset)? Save again
    rts                                 ; First call: return
; ***************************************************************************************
; Save the level
;
; Reached from the edit loop once the level is walled in, packed and given its wall
; block. Point the BREAK intercept at break_to_save and BRKV at the reset entry, disable
; ESCAPE, ask for the level's number (nothing typed: catalogue), take its checksum from
; the game's level_checksums, wall the top-left cell, set the level's first byte so that
; its bytes sum to that checksum, encrypt it, choose disc or tape and the filename, *SAVE
; it and offer another level. Levels 1-24 can be saved; level 25 is in Stones. It never
; returns: another level restarts the editor at editor_init, and quitting resets the
; machine.
; &2244 referenced 5 times by &200b, &2241, &22c2, &22d9, &22e0
.save_level
    lda #opcode_jmp                     ; BREAK intercept = JMP break_to_save...
    sta os_break_intercept              ; ...so BREAK while saving comes back here
    lda #<(break_to_save)               ; ...break_to_save's low byte...
    sta os_break_intercept_lo           ; ...low byte of the intercept's address
    lda #>(break_to_save)               ; ...and high byte...
    sta os_break_intercept_hi           ; ...high byte
    lda #<(mos120_reset_entry)          ; BRKV = MOS 1.20's reset entry
    sta brkv                            ; ...low byte
    lda #>(mos120_reset_entry)          ; ...its high byte...
    sta brkv + 1                        ; ...high byte: an error resets the machine
    lda #osbyte_escape_break_effect     ; OSBYTE &C8 with X=1, Y=0: disable ESCAPE
    ldx #1                              ; ...X = 1: ESCAPE does nothing
    ldy #0                              ; ...Y = 0: replace the setting
    jsr osbyte                          ; Set it, so ESCAPE cannot stop the save  osbyte: escape break effect
    lda #&0c                            ; VDU 12: clear the screen
    jsr oswrch                          ; ...send it
; &226b referenced 1 time by &23e5
.ask_level_number
    lda #osbyte_flush_buffer_class      ; Flush buffers
    jsr osbyte                          ; Discard keys pressed before the level prompt  Flush selected class of buffer
    ldx #0                              ; Ask for the level number
; &2272 referenced 1 time by &227b
.print_level_prompt
    lda level_number_prompt,x           ; Next prompt character...
    jsr oswrch                          ; ...print it
    inx                                 ; ...on to the next
    cmp #0                              ; ...the zero at its end?
    bne print_level_prompt              ; No: print the next
    ldx #<(read_line_block)             ; Point XY at read_line_block...
    ldy #>(read_line_block)             ; ...high byte
    lda #'0'                            ; ...digits '0' '0' to start with...
    sta filename_buffer                 ; ...first digit
    sta filename_buffer + 1             ; ...second digit
    lda #<(filename_buffer)             ; ...buffer filename_buffer...
    sta read_line_block                 ; ...low byte of the buffer
    lda #>(filename_buffer)             ; ...high byte...
    sta read_line_block + 1             ; ...of the buffer
    lda #2                              ; ...two characters...
    sta read_line_block + 2             ; ...as the maximum length
    lda #'0'                            ; ...'0' to '9'
    sta read_line_block + 3             ; ...lowest character accepted
    lda #'9'                            ; ...to '9'...
    sta read_line_block + 4             ; ...highest character accepted
    lda #osword_read_line               ; OSWORD 0: read it
    jsr osword                          ; Read the level number the user types  Read line from input stream (exits with C=1 if ESCAPE pressed)
    cpy #0                              ; Anything typed?
    bne level_typed                     ; Yes: level typed
    jmp catalogue                       ; Nothing: catalogue, then ask again
; &22ae referenced 1 time by &22a9
.level_typed
    lda filename_buffer + 1             ; One digit?
    cmp #&0d                            ; ...the second character a CR?
    bne two_digits                      ; No: two digits
    lda filename_buffer                 ; Yes: the level is the digit
    sec                                 ; ...C set for the subtraction
    sbc #'0'                            ; ...ASCII to its value
    bpl check_level_number              ; ...(always branches)
; &22bd referenced 1 time by &22b3
.two_digits
    lda filename_buffer                 ; Two: tens...
    cmp #&0d                            ; ...a CR in the first place?
    beq save_level                      ; Yes: ask again
    sec                                 ; ...C set for the subtraction
    sbc #'0'                            ; ...ASCII to its value
    asl a                               ; ...x 2...
    sta scratch                         ; ...kept...
    asl a                               ; ...x 4...
    asl a                               ; ...x 8...
    clc                                 ; ...C clear for the addition
    adc scratch                         ; ...+ x 2: x 10
    adc filename_buffer + 1             ; ...plus units
    sec                                 ; ...C set for the subtraction
    sbc #'0'                            ; ...less the units digit's ASCII bias
; &22d5 referenced 1 time by &22bb
.check_level_number
    cmp #0                              ; Level 0?
    bne level_not_zero                  ; No: check the top
    jmp save_level                      ; Yes: ask again
; &22dc referenced 1 time by &22d7
.level_not_zero
    cmp #max_level + 1                  ; 25 or more?
    bcc level_number_ok                 ; No: 1-24, a level the game loads from a file
    jmp save_level                      ; Yes: ask again
; &22e3 referenced 1 time by &22de
.level_number_ok
    sta level_number                    ; Keep the level number...
    tax                                 ; ...X = level, to index the checksums
    lda level_checksums - 1,x           ; ...the game's checksum for that level...
    sta level_checksum                  ; ...which the level's bytes must sum to
    lda #&0a                            ; Line feed
    jsr oswrch                          ; ...send it
    lda level_encrypted                 ; Saved already (so encrypted)?
    beq set_checksum                    ; No: the level is still plain
    jsr crypt_level                     ; Yes: decrypt it again
; &22fa referenced 1 time by &22f5
.set_checksum
    lda level_walls                     ; Wall cell (0, 0), which wall_edges may have missed
    ora #&80                            ; ...bit 7 of the wall map's first byte...
    sta level_walls                     ; ...set in the level file
    lda #0                              ; Sum the level's bytes, with the first byte 0...
    tay                                 ; ...Y = 0: scratch steps through the file
    sta level_object_x                  ; ...first byte 0, so it adds nothing
    sta screen_ptr                      ; ...the sum starts at 0
    sta scratch                         ; ...pointer at &2700, low byte...
    lda #>(level_object_x)              ; ...page &27, the level file
    sta scratch_hi                      ; ...high byte
; &2310 referenced 2 times by &2321, &2327
.sum_level
    lda (scratch),y                     ; Next byte of the level...
    clc                                 ; ...C clear for the addition
    adc screen_ptr                      ; ...added to the sum...
    sta screen_ptr                      ; ...modulo 256
    inc scratch                         ; Next byte
    bne sum_check_end                   ; No page crossed
    inc scratch_hi                      ; ...into the next page
; &231d referenced 1 time by &2319
.sum_check_end
    lda scratch                         ; ...to &29AF
    cmp #<(level_file_end)              ; ...the low byte of &29B0?
    bne sum_level                       ; No: next byte
    lda scratch_hi                      ; ...and the high byte?
    cmp #>(level_file_end)              ; ...of &29B0?
    bne sum_level                       ; No: next byte
    lda screen_ptr                      ; First byte = checksum - sum (modulo 256)...
    cmp level_checksum                  ; ...compared with the checksum
    bcc sum_below                       ; Sum below the checksum
    sec                                 ; ...(sum above the checksum: &FF - sum + checksum + 1)...
    lda #&ff                            ; ...&FF...
    sbc screen_ptr                      ; ...less the sum...
    clc                                 ; ...C clear for the addition
    adc level_checksum                  ; ...plus the checksum...
    adc #1                              ; ...plus 1
    jmp store_first_byte                ; ...store it
; &233e referenced 1 time by &232e
.sum_below
    sec                                 ; ...(otherwise checksum - sum)
    lda level_checksum                  ; ...the checksum...
    sbc screen_ptr                      ; ...less the sum
; &2344 referenced 1 time by &233b
.store_first_byte
    sta level_object_x                  ; ...so that the level's sum is its checksum
    jsr crypt_level                     ; Encrypt it
    lda #1                              ; Mark it encrypted
    sta level_encrypted                 ; ...so a second save decrypts it first
    jsr choose_filing_system            ; Choose disc or tape
    lda #' '                            ; Blank the filename in save_command...
    ldx #5                              ; ...offset 5, where the name goes...
; &2356 referenced 1 time by &235c
.blank_save_name
    sta save_command,x                  ; ...a space...
    inx                                 ; ...on to the next
    cpx #&0c                            ; ...up to offset 11?
    bne blank_save_name                 ; No: blank the next
    jsr ask_filename                    ; Ask for the filename
    lda #&0a                            ; Line feed
    jsr oswrch                          ; ...send it
    ldx #0                              ; Copy it into save_command...
; &2368 referenced 1 time by &2371
.copy_save_name
    lda filename_buffer,x               ; Next filename character...
    sta save_command + 5,x              ; ...into the command
    inx                                 ; ...on to the next
    cpx scratch                         ; ...all the characters typed?
    bne copy_save_name                  ; No: copy the next
    ldx #<(save_command)                ; *SAVE name 2700+2B0
    ldy #>(save_command)                ; ...high byte
    jsr oscli                           ; ...save the level file
    lda #&0a                            ; Line feed
    jsr oswrch                          ; ...send it
    ldx #<(another_prompt)              ; Ask: another level (A) or quit (Q)
    ldy #>(another_prompt)              ; ...high byte of the prompt
    lda #&41 ; 'A'                      ; ...first answer: A (internal key &41)...
    sta scratch                         ; ...for ask_key
    lda #&10                            ; ...second answer: Q (internal key &10)
    sta scratch_hi                      ; ...for ask_key
    lda #0                              ; ...A = 0: one of two keys
    jsr ask_key                         ; ...ask, A = 0 for A or 1 for Q
    bne quit                            ; Quit?
    jmp editor_init                     ; A: restart the editor for another level
; &2395 referenced 1 time by &2390
.quit
    lda #0                              ; Quit: disable the BREAK intercept...
    sta os_break_intercept              ; ...so the reset starts the machine afresh
    jmp mos120_reset_entry              ; ...and reset
; ***************************************************************************************
; *EDITOR: copy the plotter page and start
;
; Copy &2700-&28FF to &0900-&0AFF (the plotter, screen_address, the item types and
; checksums, and the sprite tables), freeing &2700 for the level file, then start.
.editor_start
    ldx #0                              ; Copy &2700-&27FF to &0900...
; &239f referenced 1 time by &23a6
.copy_plotter_lo
    lda plotter_image,x                 ; Next byte of the stored plotter page...
    sta plot_sprite,x                   ; ...to its run address
    dex                                 ; ...on to the next
    bne copy_plotter_lo                 ; ...until all 256 are copied
; &23a8 referenced 1 time by &23af
.copy_plotter_hi
    lda plotter_image_page_2,x          ; ...and &2800-&28FF to &0A00
    sta sprite_addr_lo,x                ; ...to its run address
    dex                                 ; ...on to the next
    bne copy_plotter_hi                 ; ...until all 256 are copied
    jmp editor_init                     ; Start
; ***************************************************************************************
; Catalogue the disc or tape
;
; Reached from save_level when RETURN is pressed with no level number. Show CAT after the
; prompt, as the answer, choose disc or tape, *CAT, then ask for the level number again.
; &23b4 referenced 1 time by &22ab
.catalogue
    lda #&0b                            ; Move up a line...
    jsr oswrch                          ; ...back onto the prompt's line
    lda #9                              ; ...and right past its 29 characters...
    ldx #&1d                            ; ...29 times...
; &23bd referenced 1 time by &23c1
.move_right_29
    jsr oswrch                          ; ...one place right...
    dex                                 ; ...counted
    bne move_right_29                   ; ...until all 29 are done
    lda #'C'                            ; ...and show CAT
    jsr oswrch                          ; ...print it
    lda #'A'                            ; ...'A'...
    jsr oswrch                          ; ...print it
    lda #'T'                            ; ...'T'
    jsr oswrch                          ; ...print it
    jsr new_lines                       ; New line
    jsr choose_filing_system            ; Choose disc or tape
    jsr new_lines                       ; New line
    ldx #<(cat_command)                 ; *CAT
    ldy #>(cat_command)                 ; ...high byte
    jsr oscli                           ; ...list the files
    jsr new_lines                       ; New line
    jmp ask_level_number                ; Ask for the level number again
; ***************************************************************************************
; Unused
;
; Leftover bytes: &FF, then a stale copy of the end of catalogue (new line, choose disc
; or tape, new line, *CAT, new line, ask for the level number again) assembled at other
; addresses.
    equb &ff, &20, &17, &1e, &20, &04, &21, &20
    equb &17, &1e, &a2, &85, &a0, &1d, &20, &f7
    equb &ff, &20, &17, &1e, &4c, &82, &22, &20  ; Not used
; ***************************************************************************************
; Choose the level's wall block
;
; Called from the edit loop when saving, after the level is packed. Clear the screen,
; show 25 rows, load Stones (the 24 wall blocks) at &6E80, draw them in a grid of four by
; six and frame block 0. Move the frame with ',' '.' (one) and 'A' 'Z' (a row), paced by
; a delay loop; SPACE copies the chosen block into the level's wall block and returns.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &2400 referenced 1 time by &1ffe
.choose_wall_block
    lda #&0c                            ; VDU 12: clear the screen
    jsr oswrch                          ; ...send it
    jsr show_25_rows                    ; Show 25 rows, hiding &6E80 on, where Stones goes
    jsr load_stones                     ; Load Stones
    nop                                 ; (padding)
    nop                                 ; Padding
    nop                                 ; Padding
    nop                                 ; Padding
    lda #0                              ; Block 0 chosen
    sta chosen_block                    ; ...to start with
    jsr draw_wall_blocks                ; Draw the 24 blocks
    lda #spr_chooser_frame              ; Frame block 0
    jsr frame_block                     ; ...draw the frame round it
; &241c referenced 2 times by &2471, &2490
.chooser_loop
    ldx #&64 ; 'd'                      ; Pause...
; &241e referenced 1 time by &2424
.chooser_pause
    ldy #&ff                            ; ...255 x 100 loops...
; &2420 referenced 1 time by &2421
.chooser_pause_inner
    dey                                 ; ...inner count
    bne chooser_pause_inner             ; ...until 0
    dex                                 ; ...outer count
    bne chooser_pause                   ; ...until 0: slow enough to steer
    jsr move_chooser                    ; Read the movement keys
    ldx #inkey_key_space                ; SPACE?
    jsr chooser_key_pressed             ; ...(Z set if pressed)
    bne chooser_moved                   ; Not pressed: redraw if the choice moved
    lda #0                              ; Yes: the block's address, &6E80 + block x &30...
    sta plot_y                          ; ...high byte, in plot_y, starts at 0
    lda chosen_block                    ; ...the chosen block number...
    asl a                               ; ...x 2...
    asl a                               ; ...x 4...
    asl a                               ; ...x 8...
    asl a                               ; ...x 16, the carry...
    rol plot_y                          ; ...into the high byte
    sta scratch                         ; ...block x 16, low byte...
    lda plot_y                          ; ...and high byte...
    sta scratch_hi                      ; ...kept
    lda scratch                         ; ...block x 16 again...
    asl a                               ; ...x 2: block x 32...
    rol plot_y                          ; ...carry into the high byte
    clc                                 ; ...C clear for the addition
    adc scratch                         ; ...+ x 16: block x 48 (&30), low byte...
    sta plot_x                          ; ...kept in plot_x
    lda plot_y                          ; ...high byte...
    adc scratch_hi                      ; ...plus x 16's high byte, with the carry
    sta plot_y                          ; ...kept in plot_y
    clc                                 ; ...C clear for the addition
    lda plot_x                          ; ...offset low byte...
    adc #<(wall_blocks)                 ; ...plus where Stones' blocks start...
    sta plot_x                          ; ...pointer low byte
    lda plot_y                          ; ...offset high byte...
    adc #>(wall_blocks)                 ; ...plus the start's high byte
    sta plot_y                          ; ...pointer high byte
    ldy #wall_block_bytes - 1           ; Copy its &30 bytes into level_wall_block
; &2462 referenced 1 time by &2468
.copy_wall_block
    lda (plot_x),y                      ; Next byte of the chosen block...
    sta level_wall_block,y              ; ...into the level file
    dey                                 ; ...down to the first
    bpl copy_wall_block                 ; ...until all &30 are copied
    rts                                 ; Return
; &246b referenced 1 time by &242e
.chooser_moved
    lda previous_block                  ; Did the keys move the choice?
    cmp chosen_block                    ; ...still the block chosen before?
    beq chooser_loop                    ; Not moved: pause and read the keys again
    lda #osbyte_vsync                   ; Yes: wait for the frame...
    jsr osbyte                          ; Pace the chooser to the display  Wait for vertical sync
    lda chosen_block                    ; ...erase the old frame...
    pha                                 ; ...the new choice kept
    lda previous_block                  ; ...the old one...
    sta chosen_block                    ; ...made current for the frame
    lda #spr_chooser_blank              ; ...the blank frame sprite...
    jsr frame_block                     ; ...rubbed out round the old block
    pla                                 ; ...the new choice back
    sta chosen_block                    ; ...as the chosen block
    lda #spr_chooser_frame              ; ...and frame the new block
    jsr frame_block                     ; ...drawn round it
    jmp chooser_loop                    ; Pause and read the keys again
; ***************************************************************************************
; Draw the 24 wall blocks
;
; Plot sprites &12-&29 at their places in the grid.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &2493 referenced 1 time by &2414
.draw_wall_blocks
    ldx #wall_block_count - 1           ; For blocks 23 to 0...
; &2495 referenced 1 time by &24a6
.draw_wall_block
    txa                                 ; Keep the block number...
    pha                                 ; ...on the stack
    clc                                 ; ...sprite &12 + block...
    adc #spr_wall_block_0               ; ...its sprite in the editor's tables
    sta sprite_number                   ; ...to plot
    txa                                 ; ...at the block's place
    jsr block_place                     ; ...set plot_x, plot_y for it
    jsr plot_sprite                     ; ...plot the block
    pla                                 ; ...the block number back
    tax                                 ; ...into X
    dex                                 ; ...the block before
    bpl draw_wall_block                 ; ...until block 0 is drawn
    rts                                 ; Return
; ***************************************************************************************
; Move the chosen wall block
;
; '.' and ',' move one block on or back, 'Z' and 'A' a row of four; a move off the grid
; is undone. Only one key is taken each call. choose_wall_block compares the two blocks
; afterwards to see whether the frame must be moved.
;
; On Exit:
;     CHOSEN_BLOCK: the block now chosen
;     PREVIOUS_BLOCK: the block chosen before
; &24a9 referenced 1 time by &2426
.move_chooser
    lda chosen_block                    ; Remember the block chosen
    sta previous_block                  ; ...to compare after moving
    ldx #inkey_key_full_stop            ; '.' pressed?
    jsr chooser_key_pressed             ; ...(Z set if pressed)
    bne check_back                      ; Not pressed: try ','
    inc chosen_block                    ; Yes: the next block...
    lda chosen_block                    ; ...read it
    cmp #wall_block_count               ; ...past the last block?
    bne chooser_moved_ok                ; No: the move stands
    beq undo_move                       ; Past 23: undo it
; &24c2 referenced 1 time by &24b4
.check_back
    ldx #inkey_key_comma                ; ',' pressed?
    jsr chooser_key_pressed             ; ...(Z set if pressed)
    bne check_row_on                    ; Not pressed: try Z
    dec chosen_block                    ; Yes: the previous block...
    bpl chooser_moved_ok                ; Still 0 or more: the move stands
    bmi undo_move                       ; Below 0: undo it
; &24d0 referenced 1 time by &24c7
.check_row_on
    ldx #inkey_key_z                    ; 'Z' pressed?
    jsr chooser_key_pressed             ; ...(Z set if pressed)
    bne check_row_back                  ; Not pressed: try A
    clc                                 ; Yes: a row on...
    lda chosen_block                    ; ...the chosen block...
    adc #4                              ; ...4 on, the block below in the grid
    sta chosen_block                    ; ...kept
    cmp #wall_block_count               ; ...past the last block?
    bcc chooser_moved_ok                ; Within the 24: the move stands
    bcs undo_move                       ; Past 23: undo it
; &24e6 referenced 1 time by &24d5
.check_row_back
    ldx #inkey_key_a                    ; 'A' pressed?
    jsr chooser_key_pressed             ; ...(Z set if pressed)
    bne chooser_moved_ok                ; Not pressed: no move
    sec                                 ; Yes: a row back...
    lda chosen_block                    ; ...the chosen block...
    sbc #4                              ; ...4 back, the block above in the grid
    sta chosen_block                    ; ...kept
    bpl chooser_moved_ok                ; Still 0 or more: the move stands
    bmi undo_move                       ; Below 0: undo it
; &24fa referenced 5 times by &24be, &24cc, &24e2, &24eb, &24f6
.chooser_moved_ok
    rts                                 ; Return
; &24fb referenced 4 times by &24c0, &24ce, &24e4, &24f8
.undo_move
    lda previous_block                  ; Off the grid: undo the move
    sta chosen_block                    ; ...restore the block chosen before
    rts                                 ; Return
; ***************************************************************************************
; Test a key
;
; OSBYTE &81 with the INKEY number in X, as key_pressed.
;
; On Entry:
;     X: INKEY number
;
; On Exit:
;     Z: set if pressed
; &2502 referenced 5 times by &242b, &24b1, &24c4, &24d2, &24e8
.chooser_key_pressed
    lda #osbyte_inkey                   ; OSBYTE &81: scan the key...
    ldy #&ff                            ; ...Y = &FF: test the key whose INKEY number is X
    jsr osbyte                          ; Scan it: X = Y = &FF if the key is held  Test for a key pressed
    cpx #&ff                            ; Z set if X and Y are both &FF
    bne chooser_key_done                ; X not &FF: not pressed (Z clear)
    cpy #&ff                            ; ...Z set if Y is &FF too: pressed
; &250f referenced 1 time by &250b
.chooser_key_done
    rts                                 ; Return
; ***************************************************************************************
; Find a wall block's place in the grid
;
; Block n is at column n mod 4, row n div 4: plot_x = 8 x column + &1A, plot_y = 24 x row
; + &14. Each block is 4 bytes by 12 rows, so the grid leaves room for the frame between
; them.
;
; On Entry:
;     A: block number
;
; On Exit:
;     PLOT_X: the block's screen byte column
;     PLOT_Y: its pixel row
;     X: the block number
;     C: clear
; &2510 referenced 3 times by &249d, &252f, &2540
.block_place
    tax                                 ; Keep the block number
    and #3                              ; plot_x = (n mod 4) x 8 + &1A
    asl a                               ; ...x 2...
    asl a                               ; ...x 4...
    asl a                               ; ...x 8 bytes across...
    clc                                 ; ...C clear for the addition
    adc #&1a                            ; ...from column &1A
    sta plot_x                          ; ...as plot_x
    txa                                 ; plot_y = (n div 4) x 24 + &14
    and #&fc                            ; ...the block's grid row x 4...
    asl a                               ; ...x 8...
    sta scratch                         ; ...kept...
    asl a                               ; ...x 16...
    clc                                 ; ...C clear for the addition
    adc scratch                         ; ...+ x 8: the row x 24 pixel rows
    adc #&14                            ; ...from pixel row &14
    sta plot_y                          ; ...as plot_y
    rts                                 ; Return
; ***************************************************************************************
; Draw or erase the frame round the chosen block
;
; Plot sprite A (&2A the frame, &2B a blank), 6 bytes by 18 rows, one byte left of and
; three rows above the chosen block, so that it surrounds the 4-byte by 12-row block,
; then plot the block again inside it.
;
; On Entry:
;     A: &2A to frame, &2B to erase
; &252a referenced 3 times by &2419, &2484, &248d
.frame_block
    sta sprite_number                   ; The frame sprite...
    lda chosen_block                    ; ...at the chosen block's place...
    jsr block_place                     ; ...set plot_x, plot_y
    dec plot_x                          ; ...one byte left...
    lda plot_y                          ; ...and up (C is clear from block_place)...
    sbc #2                              ; ...SBC #2 with C clear: three rows up
    sta plot_y                          ; ...kept
    jsr plot_sprite                     ; Plot it
    lda chosen_block                    ; Then the block itself
    jsr block_place                     ; ...set plot_x, plot_y
    lda chosen_block                    ; ...its number...
    clc                                 ; ...C clear for the addition
    adc #spr_wall_block_0               ; ...as its sprite
    sta sprite_number                   ; ...to plot
    jsr plot_sprite                     ; ...plot it inside the frame
    rts                                 ; Return
.load_stones_command
    equs "LOAD STONES", &0d
; ***************************************************************************************
; Show 25 rows
;
; Send VDU 23,0,6,25,0,0,0,0,0,0: 6845 register 6, the rows displayed, = 25. Row 25
; starts at &6E80, where load_stones puts Stones, so the wall-block chooser does not show
; it.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: preserved
; &255b referenced 1 time by &2405
.show_25_rows
    ldx #0                              ; Send rows_25_vdu
; &255d referenced 1 time by &2566
.send_25_rows
    lda rows_25_vdu,x                   ; Next byte of the VDU command...
    jsr oswrch                          ; ...send it
    inx                                 ; ...on to the next
    cpx #&0a                            ; ...all ten sent?
    bne send_25_rows                    ; No: send the next
    rts                                 ; Return
; &2569 used as index base 1 time by &255d
.rows_25_vdu
    equb &17, &00, &06, &19, &00, &00, &00, &00, &00, &00
; ***************************************************************************************
; Unused
;
; Leftover bytes: a fragment of BBC BASIC assembler.
    equs "A#255:LDX#0:."
; ***************************************************************************************
; The chooser's frame
;
; Sprite &2A: 6 bytes by 18 pixel rows.
.frame_sprite
    equb &3f, &3f, &3f, &3f, &3f, &3f
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &2a, &00, &00, &00, &00, &15
    equb &3f, &3f, &3f, &3f, &3f, &3f
; ***************************************************************************************
; Unused
;
; Leftover bytes.
    equb &0d, &09, &d8, &2e             ; Not used
; ***************************************************************************************
; Variables
; &25f0 referenced 2 times by &1c75, &1f13
.new_level_flag
    equb &00
; &25f1 referenced 1 time by &22e3
.level_number
    equb &01
; &25f2 referenced 4 times by &22ea, &232b, &2336, &233f
.level_checksum
    equb &62
; &25f3 referenced 4 times by &1f97, &1fa4, &1fbe, &1fc3
.slow_cursor
    equb &01
; &25f4 referenced 7 times by &1f9a, &202c, &202f, &2036, &204a, &204f, &217c
.colour_10
    equb &01
; &25f5 referenced 3 times by &1ea9, &2016, &201b
.cursor_flash
    equb &01
    equb &00, &00                       ; Not referenced
; &25f8 referenced 18 times by &2411, &2434, &246e, &2478, &247f, &2488, &24a9, &24b6, &24b9, &24c9, &24d8, &24dd, &24ee, &24f3, &24fe, &252c, &253d, &2543
.chosen_block
    equb &00
; &25f9 referenced 4 times by &246b, &247c, &24ac, &24fb
.previous_block
    equb &00
; &25fa referenced 3 times by &1c37, &22f2, &234c
.level_encrypted
    equb &00
; &25fb used as index base 1 time by &1cd7
.drive_keys
    equb &27, &30, &31, &11
    equb &00                            ; Not referenced
; ***************************************************************************************
; Pack the item slots into the level file
;
; Go through the slots from the last (&4F) to the first, so that the tables come out in
; the reverse of the order unpack_level read them: objects into entries 1 upwards (the
; exit always into entry 30), trapdoors into entries 0-7, and each door with its linked
; key into the next door entry. Keys and free slots are skipped.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &2600 referenced 1 time by &26a9
.pack_items
    lda #0                              ; No objects, trapdoors or doors packed yet
    sta packed_objects                  ; ...objects
    sta packed_trapdoors                ; ...trapdoors
    sta packed_doors                    ; ...doors
    ldx #max_slot                       ; For slots &4F to 0...
; &260d referenced 1 time by &2638
.pack_slot
    lda slot_item,x                     ; ...what is in it?
    beq pack_next                       ; Free slot: skip it
    cmp #1                              ; The exit?
    beq pack_exit                       ; Yes: always object entry 30
    cmp #3                              ; A trapdoor?
    beq pack_trapdoor                   ; Yes: the trapdoor table
    cmp #spr_door_vertical              ; A door or key?
    bcs pack_door                       ; Yes: the door tables
    inc packed_objects                  ; An object: the next entry...
    tay                                 ; ...its level type...
    lda item_types,y                    ; ...as the game's object type
    ldy packed_objects                  ; ...the entry number
    sta level_object_type,y             ; ...into the level's object types
    lda slot_x,x                        ; ...and position
    sta level_object_x,y                ; ...into the level's object x
    lda slot_y,x                        ; ...y...
    sta level_object_y,y                ; ...into the level's object y
; &2637 referenced 5 times by &2610, &264e, &2662, &2666, &26a6
.pack_next
    dex                                 ; Next slot
    bpl pack_slot                       ; ...until slot 0 is done
    rts                                 ; Return
; &263b referenced 1 time by &2614
.pack_exit
    lda #game_exit_type                 ; The exit: entry 30, type &51
    ldy #max_object                     ; ...the exit's entry in the object tables
    sta level_object_type,y             ; ...its type
    lda slot_x,x                        ; ...its x...
    sta level_object_x,y                ; ...into the level
    lda slot_y,x                        ; ...its y...
    sta level_object_y,y                ; ...into the level
    bpl pack_next                       ; Next slot (always branches)
; &2650 referenced 1 time by &2618
.pack_trapdoor
    ldy packed_trapdoors                ; A trapdoor: the next trapdoor entry
    lda slot_x,x                        ; ...its x...
    sta level_trapdoor_x,y              ; ...into the level's trapdoor table
    lda slot_y,x                        ; ...its y...
    sta level_trapdoor_y,y              ; ...into the level's trapdoor table
    inc packed_trapdoors                ; ...count it
    bne pack_next                       ; Next slot (always branches)
; &2664 referenced 1 time by &261c
.pack_door
    cmp #spr_key                        ; A key?
    beq pack_next                       ; Yes: skip it, as it is packed with its door
    inc packed_doors                    ; A door: the next door entry...
    tay                                 ; ...its sprite...
    lda item_types,y                    ; ...as the game's door sprite
    ldy packed_doors                    ; ...the entry number
    sta level_door_sprite,y             ; ...into the level's door sprites
    lda slot_x,x                        ; ...and position
    sta level_door_x,y                  ; ...into the level's door x
    lda slot_y,x                        ; ...y...
    sta level_door_y,y                  ; ...into the level's door y
    stx bit_mask                        ; Find the link whose door is this slot...
    ldy #max_link                       ; ...over links 19 to 0
; &2685 referenced 1 time by &268d
.find_door_link
    lda link_door,y                     ; This link's door slot...
    cmp bit_mask                        ; ...the door's slot?
    beq pack_key                        ; Yes: Y is its link
    dey                                 ; ...next link
    bpl find_door_link                  ; ...until all 20 are tried
; &268f referenced 1 time by &268a
.pack_key
    txa                                 ; ...and put its key's position in the same entry
    pha                                 ; ...keeping the door's slot
    lda link_key,y                      ; ...the key's slot...
    tax                                 ; ...into X
    ldy packed_doors                    ; ...the door's entry number
    lda slot_x,x                        ; ...the key's x...
    sta level_key_x,y                   ; ...as the door's key x
    lda slot_y,x                        ; ...the key's y...
    sta level_key_y,y                   ; ...as the door's key y
    pla                                 ; ...the door's slot back
    tax                                 ; ...into X
    jmp pack_next                       ; Next slot
; ***************************************************************************************
; Pack the level for saving
;
; Called from the edit loop when saving, after wall_edges. Pack the item slots, then copy
; the wall map and the object-free map into the level file.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &26a9 referenced 1 time by &1ffb
.pack_level
    jsr pack_items                      ; Pack the items
    ldx #0                              ; Copy the &C9 bytes of each map
; &26ae referenced 1 time by &26bd
.copy_maps
    lda wall_map,x                      ; Next wall-map byte...
    sta level_walls,x                   ; ...into the level file
    lda object_free_map,x               ; ...and the object-free map byte...
    sta level_object_free,x             ; ...into the level file
    inx                                 ; ...on to the next
    cpx #map_bytes                      ; ...all &C9 copied?
    bne copy_maps                       ; No: copy the next
    rts                                 ; Return
; ***************************************************************************************
; Unused
;
; Zeros.
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00  ; Not used
; ***************************************************************************************
; Load the wall blocks
;
; *LOAD STONES (at its own address, &6E80) with VDU output off. Called by
; choose_wall_block, with the disc already selected.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &26d0 referenced 1 time by &2408
.load_stones
    lda #&15                            ; VDU 21: output off
    jsr oswrch                          ; ...so the *LOAD message does not show
    ldx #<(load_stones_command)         ; *LOAD STONES
    ldy #>(load_stones_command)         ; ...high byte
    jsr oscli                           ; ...load the 24 wall blocks
    lda #6                              ; VDU 6: output on
    jsr oswrch                          ; ...send it
    rts                                 ; Return
; ***************************************************************************************
; Unused
;
; Zeros.
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00   ; Not used

    org &2900
; ***************************************************************************************
; Unused
;
; Leftover bytes, covered by the level file (&2700-&29AF) when one is loaded.
    equb &ff, &ff, &ff, &bf, &ff, &7f, &ff, &ff
    equb &fe, &fe, &fe, &fe, &fe, &fe, &fe, &f6
    equb &7f, &7f, &3f, &7f, &7f, &7f, &7f, &7f
    equb &ff, &ef, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &fe, &fe, &7e, &fe, &fe, &fe, &fe, &fe
    equb &7f, &7f, &7f, &7f, &7f, &7f, &7f, &7f
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &fe, &fe, &fe, &fe, &fe, &fe, &fe, &fe
    equb &7f, &7f, &7f, &7f, &7f, &7f, &7f, &00
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &00
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &00
    equb &fe, &fe, &fe, &fe, &fe, &fe, &fe, &00
    equb &ff, &ff, &ff, &ff, &ff, &ff, &ff, &ff
    equb &ff, &00, &00, &00, &00, &00, &00, &00  ; Not used: the level file's &2900-&29AF when one is loaded
; &2980 used as index base 2 times by &1e92, &2464
.level_wall_block
    equb &14, &3c, &3c, &28, &29, &03, &03, &16
    equb &29, &03, &03, &16, &29, &03, &03, &16
    equb &29, &03, &03, &16, &14, &3c, &3c, &28
    equb &3c, &28, &14, &3c, &03, &16, &29, &03
    equb &03, &16, &29, &03, &03, &16, &29, &03
    equb &03, &16, &29, &03, &3c, &28, &14, &3c  ; Not used: the level's wall block when one is loaded
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00   ; Not used
; ***************************************************************************************
; Sprites
;
; The cursor (sprite &2C), then the 16 items (sprites 0-&0F) and the door waiting for its
; key (&11), each two bytes by five pixel rows.
.cursor_sprite
    equb &cc, &cc, &88, &44, &88, &44, &88, &44, &cc, &cc
.item_sprites
    equb &cc, &cc
    equb &cc, &cc
    equb &cc, &cc
    equb &cc, &cc
    equb &cc, &cc                       ; Sprite &00: wall
    equb &03, &03
    equb &02, &01
    equb &02, &01
    equb &02, &01
    equb &03, &03                       ; Sprite &01: exit
    equb &33, &33
    equb &62, &bb
    equb &62, &bb
    equb &62, &bb
    equb &33, &33                       ; Sprite &02: drainer
    equb &3c, &3c
    equb &29, &16
    equb &29, &16
    equb &29, &16
    equb &3c, &3c                       ; Sprite &03: trapdoor
    equb &03, &01
    equb &43, &a9
    equb &53, &a1
    equb &47, &83
    equb &03, &01                       ; Sprite &04: treasure
    equb &2a, &00
    equb &3f, &0a
    equb &01, &0b
    equb &05, &0b
    equb &00, &02                       ; Sprite &05: food
    equb &3f, &3f
    equb &3e, &38
    equb &3e, &38
    equb &3e, &38
    equb &30, &30                       ; Sprite &06: teleporter
    equb &a8, &41
    equb &00, &02
    equb &3f, &03
    equb &00, &02
    equb &82, &54                       ; Sprite &07: magic sword
    equb &00, &28
    equb &14, &3c
    equb &10, &30
    equb &14, &34
    equb &14, &3c                       ; Sprite &08: helmet
    equb &00, &2a
    equb &00, &0a
    equb &05, &0b
    equb &05, &03
    equb &00, &02                       ; Sprite &09: potion
    equb &05, &01
    equb &0a, &2b
    equb &00, &2b
    equb &18, &2b
    equb &08, &2a                       ; Sprite &0A: weapons
    equb &00, &0a
    equb &05, &0f
    equb &00, &0a
    equb &00, &0a
    equb &00, &00                       ; Sprite &0B: cross
    equb &00, &05
    equb &00, &07
    equb &01, &22
    equb &13, &22
    equb &00, &00                       ; Sprite &0C: boots
    equb &14, &2a
    equb &14, &2a
    equb &14, &2a
    equb &14, &2a
    equb &14, &2a                       ; Sprite &0D: door vertical
    equb &00, &00
    equb &3c, &3c
    equb &3f, &3f
    equb &00, &00
    equb &00, &00                       ; Sprite &0E: door horizontal
    equb &00, &00
    equb &00, &05
    equb &0f, &0f
    equb &0f, &05
    equb &00, &00                       ; Sprite &0F: key
.waiting_door_sprite
    equb &45, &8a, &cf, &cf, &cf, &cf, &cf, &cf, &45, &8a
; ***************************************************************************************
; Unused
;
; Leftover bytes.
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00, &00, &00
    equb &00, &00, &00, &00, &00, &00   ; Not used
; ***************************************************************************************
; Move the cursor
;
; Called at the start of every edit-loop pass. Wait for the frame, rub out the cursor and
; put back what is under it, move with ',' '.' 'A' 'Z' within the 32 by 48 map (one step
; in x and one in y at most), and plot the current item there as the cursor. So the
; cursor shows what SPACE would place.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &2b00 referenced 1 time by &200f
.move_cursor
    lda #osbyte_vsync                   ; Wait for the frame
    jsr osbyte                          ; Pace the cursor's movement to the display  Wait for vertical sync
    lda #spr_blank                      ; Rub out the cursor (the blank sprite)
    jsr plot_at_cursor                  ; ...at the cursor's cell
    jsr item_at_cursor                  ; Anything here?
    bmi check_right                     ; Empty: leave the cell blank
    jsr plot_at_cursor                  ; Yes: redraw the wall or item the cursor covered
; &2b12 referenced 1 time by &2b0d
.check_right
    ldx key_right                       ; '.' (key_right) pressed?
    jsr cursor_key_pressed              ; ...(Z set if pressed)
    bne check_left                      ; Not pressed: try left
    inc cursor_x                        ; Yes: one column right...
    bpl check_up                        ; ...always branches; clamp_cursor limits it
; &2b1d referenced 1 time by &2b17
.check_left
    ldx key_left                        ; ',' (key_left) pressed?
    jsr cursor_key_pressed              ; ...(Z set if pressed)
    bne check_up                        ; Not pressed: try up
    dec cursor_x                        ; Yes: left, to at least 0
    bpl check_up                        ; Still 0 or more: done
    lda #0                              ; Off the left: back to column 0
    sta cursor_x                        ; ...as the cursor's column
; &2b2c referenced 3 times by &2b1b, &2b22, &2b26
.check_up
    ldx key_up                          ; 'A' (key_up) pressed?
    jsr cursor_key_pressed              ; ...(Z set if pressed)
    bne check_down                      ; Not pressed: try down
    dec cursor_y                        ; Yes: up, to at least 0
    bpl clamp_cursor                    ; Still 0 or more: done
    lda #0                              ; Off the top: back to row 0
    sta cursor_y                        ; ...as the cursor's row
    beq clamp_cursor                    ; ...(always branches)
; &2b3d referenced 1 time by &2b31
.check_down
    ldx key_down                        ; 'Z' (key_down) pressed?
    jsr cursor_key_pressed              ; ...(Z set if pressed)
    bne clamp_cursor                    ; Not pressed: done
    inc cursor_y                        ; Yes: one row down...
    bpl clamp_cursor                    ; ...always branches; clamp_y limits it
; &2b48 referenced 4 times by &2b35, &2b3b, &2b42, &2b46
.clamp_cursor
    lda cursor_x                        ; At most column 31...
    cmp #map_width                      ; ...one past the right-hand column?
    bne clamp_y                         ; No: keep it
    lda #map_width - 1                  ; Yes: back to the right-hand column
    sta cursor_x                        ; ...as the cursor's column
; &2b52 referenced 1 time by &2b4c
.clamp_y
    lda cursor_y                        ; ...and row 47
    cmp #map_height                     ; ...one past the bottom row?
    bne plot_cursor                     ; No: keep it
    lda #map_height - 1                 ; Yes: back to the bottom row
    sta cursor_y                        ; ...as the cursor's row
; &2b5c referenced 1 time by &2b56
.plot_cursor
    lda current_item                    ; Plot the current item at the cursor...
    jsr plot_at_cursor                  ; ...as the cursor, over whatever is there
    rts                                 ; Return
; ***************************************************************************************
; Plot a sprite in the cursor's cell
;
; At screen byte column 2x and pixel row 5y.
;
; On Entry:
;     A: sprite number
; &2b62 referenced 5 times by &1f50, &2022, &2b07, &2b0f, &2b5e
.plot_at_cursor
    sta sprite_number                   ; The sprite...
    lda cursor_x                        ; ...at column 2x...
    asl a                               ; ...two screen bytes per cell...
    sta plot_x                          ; ...as plot_x
    lda cursor_y                        ; ...and row 5y
    asl a                               ; ...x 2...
    asl a                               ; ...x 4...
    clc                                 ; ...C clear for the addition
    adc cursor_y                        ; ...+ y: five pixel rows per cell
    sta plot_y                          ; ...as plot_y
    jsr plot_sprite                     ; Plot it
    rts                                 ; Return
; ***************************************************************************************
; Find what is in the cursor's cell
;
; Search the slots for an item at the cursor; failing that, look at the wall map. A free
; slot is item 0 at (0, 0) (see free_slot), so whenever a slot is free the top-left cell
; reports a wall, whatever the wall map holds there.
;
; On Exit:
;     A: the item's sprite and X its slot; 0 for a wall; &FF for nothing
;     N: set for nothing
; &2b76 referenced 5 times by &1f49, &2b0a, &2c0d, &2c29, &2d11
.item_at_cursor
    ldx last_slot                       ; For slots &4F to 0, free ones included...
; &2b78 referenced 1 time by &2b8b
.search_slots
    lda slot_x,x                        ; ...x matches...
    cmp cursor_x                        ; ...the cursor's column?
    bne next_slot                       ; No: next slot
    lda slot_y,x                        ; ...and y matches?
    cmp cursor_y                        ; ...the cursor's row?
    bne next_slot                       ; No: next slot
    lda slot_item,x                     ; Yes: return its item (0 for a free slot)...
    rts                                 ; ...with X its slot
; &2b8a referenced 2 times by &2b7d, &2b84
.next_slot
    dex                                 ; Next slot
    bpl search_slots                    ; ...until slot 0 is tried
    jsr wall_bit                        ; No item: is there a wall?
    lda (map_ptr),y                     ; ...the map byte...
    and bit_mask                        ; ...its bit for the cell
    beq nothing_here                    ; Clear: nothing here
    lda #0                              ; Set: item 0, the wall
    rts                                 ; ...0: a wall (Z set)
; &2b99 referenced 1 time by &2b94
.nothing_here
    ora #&ff                            ; No wall: &FF
    rts                                 ; ...&FF: nothing (N set)
; ***************************************************************************************
; Find the cursor's bit in the wall map
;
; As the game lays out its maps: the byte at (y AND &F8) x 4 + (y AND 7) + (x AND &F8),
; bit 7 - (x AND 7). Used to test, set and clear walls, a door's included.
;
; On Exit:
;     MAP_PTR: address of the byte
;     BIT_MASK: the bit
;     Y: 0
; &2b9c referenced 4 times by &2b8d, &2bde, &2c19, &2c70
.wall_bit
    lda cursor_y                        ; (y AND &F8) x 4...
    and #&f8                            ; ...the room row, as a multiple of 8...
    asl a                               ; ...x 2...
    asl a                               ; ...x 4: 32 bytes per row of rooms
    sta map_ptr                         ; ...kept
    lda cursor_y                        ; ...+ (y AND 7)...
    and #7                              ; ...the cell's row within the room
    clc                                 ; ...C clear for the addition
    adc map_ptr                         ; ...added
    sta map_ptr                         ; ...kept
    lda cursor_x                        ; ...+ (x AND &F8)...
    and #&f8                            ; ...the room's column x 8: its 8 bytes
    clc                                 ; ...C clear for the addition
    adc map_ptr                         ; ...added
    sta map_ptr                         ; ...map_ptr: the cell's byte
    lda #>(wall_map)                    ; ...in wall_map
    sta map_ptr_hi                      ; ...high byte
    lda cursor_x                        ; Bit 7 - (x AND 7)...
    and #7                              ; ...the cell's column within the room...
    sta bit_mask                        ; ...kept...
    lda #7                              ; ...from 7...
    sec                                 ; ...C set for the subtraction
    sbc bit_mask                        ; ...7 - it: the bit, leftmost cell in bit 7
    beq bit_0                           ; ...(bit 0)...
    tax                                 ; ...as a count...
    lda #1                              ; ...from bit 0...
; &2bca referenced 1 time by &2bcc
.shift_bit
    asl a                               ; Shift the mask up a bit...
    dex                                 ; ...counted
    bne shift_bit                       ; ...until it is in place
    beq bit_found                       ; ...(always branches)
; &2bd0 referenced 1 time by &2bc5
.bit_0
    lda #1                              ; ...mask 1
; &2bd2 referenced 1 time by &2bce
.bit_found
    sta bit_mask                        ; ...as bit_mask
    ldy #0                              ; Y = 0
    rts                                 ; Return
; ***************************************************************************************
; Put the current item in the cursor's cell
;
; place_item's last step, once the item is allowed. Clear the cell's object-free bit, for
; every item, walls included; nothing in the editor sets it again, so deleted items leave
; clear bits. A wall sets the wall map's bit; anything else takes a free slot, and a key
; is recorded as the key of the link being made.
;
; On Entry:
;     CURSOR_X: the cell's column
;     CURSOR_Y: the cell's row
;     CURRENT_ITEM: the item to put there
;     LINK_INDEX: for a key, its door's link
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &2bd7 referenced 1 time by &2ca0
.put_item
    jsr mark_object_cell                ; Clear the cell's object-free bit, whatever the item
    lda current_item                    ; A wall?
    bne put_in_slot                     ; No: put it in a slot
    jsr wall_bit                        ; Yes: set its bit in the wall map
    lda (map_ptr),y                     ; ...the cell's map byte...
    ora bit_mask                        ; ...with the cell's bit set...
    sta (map_ptr),y                     ; ...back in the map
    rts                                 ; Return
; &2be8 referenced 1 time by &2bdc
.put_in_slot
    ldx last_slot                       ; Find a free slot...
; &2bea referenced 1 time by &2bf0
.find_free_slot
    lda slot_item,x                     ; ...is its item 0?
    beq free_slot_found                 ; Yes: use it
    dex                                 ; ...next slot down
    bpl find_free_slot                  ; ...until slot 0 is tried
; &2bf2 referenced 1 time by &2bed
.free_slot_found
    lda cursor_x                        ; ...and put the item in it
    sta slot_x,x                        ; ...as its column
    lda cursor_y                        ; ...the cursor's row...
    sta slot_y,x                        ; ...as its row
    lda current_item                    ; ...the item...
    sta slot_item,x                     ; ...in the slot
    cmp #spr_key                        ; A key?
    bne put_item_done                   ; No: done
    txa                                 ; Yes: this slot is the link's key...
    ldx link_index                      ; ...of the link taken for the waiting door
    sta link_key,x                      ; ...the key's slot in the link
; &2c0c referenced 1 time by &2c03
.put_item_done
    rts                                 ; Return
; ***************************************************************************************
; Remove what is in the cursor's cell
;
; delete_item's last step. Free an item's slot, or clear a wall's bit in the wall map.
; Freeing a door's slot leaves its wall bit set, so the cell then shows a wall.
;
; On Entry:
;     CURSOR_X: the cell's column
;     CURSOR_Y: the cell's row
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &2c0d referenced 1 time by &2d65
.remove_at_cursor
    jsr item_at_cursor                  ; What is here?
    beq clear_wall                      ; A wall: clear its bit
    bmi remove_done                     ; Nothing here: done
    jsr free_slot                       ; An item: free its slot, X from item_at_cursor
    beq remove_done                     ; Return (always branches)
; ***************************************************************************************
; Clear the cursor's wall
;
; Clear its bit in the wall map.
; &2c19 referenced 2 times by &2c10, &2d9f
.clear_wall
    jsr wall_bit                        ; Clear the cell's bit in the wall map
    lda bit_mask                        ; ...the cell's bit...
    eor #&ff                            ; ...inverted...
    sta bit_mask                        ; ...as a mask
    lda (map_ptr),y                     ; ...the map byte...
    and bit_mask                        ; ...with the cell's bit cleared...
    sta (map_ptr),y                     ; ...back in the map
; &2c28 referenced 2 times by &2c12, &2c17
.remove_done
    rts                                 ; Return
; ***************************************************************************************
; Place the current item at the cursor
;
; In an empty cell, place the current item within the limits: one exit, eight trapdoors,
; 20 doors (a door is also a wall), 29 objects, and a key only when a door is waiting for
; one, which links the two. With a key chosen, SPACE on an unlinked door makes it the
; door waiting for its key (sprite &11), in place of any door waiting before. A door sets
; its wall bit before its count is checked, so a 21st door is refused but leaves a wall.
; Called from the edit loop on SPACE and by wall_edges.
;
; On Entry:
;     CURSOR_X: the cell's column
;     CURSOR_Y: the cell's row
;     CURRENT_ITEM: the item to place
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &2c29 referenced 6 times by &208c, &20a2, &221c, &2223, &2232, &2239
.place_item
    jsr item_at_cursor                  ; What is here?
    bmi place_in_empty                  ; Nothing: place the item
    beq place_done                      ; A wall: nothing more can go here
    cmp #spr_door_vertical              ; A door?
    beq choose_door                     ; Yes: perhaps make it wait for a key
    cmp #spr_door_horizontal            ; ...the other door?
    beq choose_door                     ; Yes: perhaps make it wait for a key
; &2c38 referenced 1 time by &2c2e
.place_done
    rts                                 ; Occupied: refuse
; &2c39 referenced 1 time by &2c2c
.place_in_empty
    lda current_item                    ; The current item: a wall?
    beq place_put                       ; Yes: put it in the map
    cmp #1                              ; The exit?
    beq place_exit                      ; Yes: only one
    cmp #3                              ; A trapdoor?
    beq place_trapdoor                  ; Yes: at most 8
    cmp #spr_door_vertical              ; A door?
    beq place_door                      ; Yes: at most 20
    cmp #spr_door_horizontal            ; ...the other door?
    beq place_door                      ; Yes: at most 20
    cmp #spr_key                        ; A key?
    beq place_key                       ; Yes: only with a door waiting
    inc object_count                    ; An object: count it...
    lda object_count                    ; ...how many now?
    cmp #max_object                     ; ...30, one too many?
    bne place_put                       ; ...and place it if there are now at most 29
    dec object_count                    ; Too many: uncount it
    rts                                 ; ...and refuse
; &2c5c referenced 1 time by &2c3f
.place_exit
    lda exit_placed                     ; The exit: only one
    bne place_refused                   ; Placed already: refuse
    inc exit_placed                     ; ...it is placed now...
    bne place_put                       ; ...put it in (always branches)
; &2c64 referenced 3 times by &2c5e, &2c87, &2ca7
.place_refused
    rts                                 ; Refuse
; &2c65 referenced 1 time by &2c43
.place_trapdoor
    inc trapdoor_count                  ; A trapdoor: at most 8
    lda trapdoor_count                  ; ...how many now?
    cmp #9                              ; ...9, one too many?
    bne place_put                       ; No: put it in
    dec trapdoor_count                  ; Yes: uncount it and refuse
    rts                                 ; ...(refused)
; &2c70 referenced 2 times by &2c47, &2c4b
.place_door
    jsr wall_bit                        ; A door: it is a wall too, set before the count...
    lda (map_ptr),y                     ; ...the cell's map byte...
    ora bit_mask                        ; ...with its bit set...
    sta (map_ptr),y                     ; ...back in the map
    inc door_count                      ; ...at most 20
    lda door_count                      ; ...how many now?
    cmp #max_door + 1                   ; ...21, one too many?
    bne place_put                       ; No: put it in
    dec door_count                      ; Yes: uncount it and refuse...
    rts                                 ; ...leaving its wall bit set
; &2c84 referenced 1 time by &2c4f
.place_key
    lda pending_door_item               ; A key: is a door waiting for one?
    bmi place_refused                   ; No door waiting: refuse
    jsr find_free_link                  ; Yes: take a free link...
    ldx link_index                      ; ...for the waiting door...
    lda pending_door_slot               ; ...the waiting door's slot...
    sta link_door,x                     ; ...as the link's door
    jsr restore_waiting_door            ; ...give the door back its own sprite...
    lda #no_link                        ; ...and nothing waiting
    sta pending_door_item               ; ...no door is waiting now
    jmp place_put                       ; Place the key, recorded in link_index's link
; &2ca0 referenced 6 times by &2c3b, &2c57, &2c62, &2c6b, &2c7f, &2c9d
.place_put
    jmp put_item                        ; Put the item in the wall map or a slot
; &2ca3 referenced 2 times by &2c32, &2c36
.choose_door
    lda current_item                    ; A door with a key chosen?
    cmp #spr_key                        ; ...the key?
    bne place_refused                   ; No: refuse
    stx bit_mask                        ; Yes: is the door linked already?
    ldx #max_link                       ; ...over links 19 to 0
; &2cad referenced 1 time by &2cb5
.find_linked_door
    lda link_door,x                     ; This link's door slot...
    cmp bit_mask                        ; ...this door's?
    beq door_linked                     ; Yes: it is linked
    dex                                 ; ...next link
    bpl find_linked_door                ; ...until all 20 are tried
    bmi door_not_linked                 ; No: door not linked
; &2cb9 referenced 1 time by &2cb2
.door_linked
    rts                                 ; Linked already: nothing to do
; &2cba referenced 1 time by &2cb7
.door_not_linked
    ldx bit_mask                        ; Another door waiting?
    lda pending_door_item               ; ...(the waiting door's sprite)
    bmi door_waits                      ; None: make this door wait
    txa                                 ; Yes: show it as it was
    pha                                 ; ...keeping this door's slot
    jsr restore_waiting_door            ; ...put its own sprite back
    pla                                 ; ...this door's slot back
    tax                                 ; ...into X
; &2cc8 referenced 1 time by &2cbf
.door_waits
    lda slot_item,x                     ; This door is waiting: remember its sprite and slot...
    sta pending_door_item               ; ...as pending_door_item...
    stx pending_door_slot               ; ...and its slot
    lda #spr_waiting_door               ; ...and show it as waiting (sprite &11)
    sta slot_item,x                     ; ...in place of the door's own
    rts                                 ; Return
; ***************************************************************************************
; Show the waiting door as it was
;
; Put the waiting door's own sprite back in its slot and plot it, by falling into
; plot_slot. Used when its key is placed, and when another door is chosen to wait
; instead.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: preserved
; &2cd7 referenced 2 times by &2c95, &2cc3
.restore_waiting_door
    ldx pending_door_slot               ; The waiting door's slot...
    lda pending_door_item               ; ...and sprite...
    sta slot_item,x                     ; ...back in the slot
; ***************************************************************************************
; Plot a sprite at a slot's cell
;
; At screen byte column 2x and pixel row 5y of slot X's cell: plot_at_cursor for a cell
; away from the cursor, such as a deleted door's key.
;
; On Entry:
;     A: sprite number
;     X: slot
; &2ce0 referenced 2 times by &2d58, &2d8e
.plot_slot
    sta sprite_number                   ; The sprite...
    lda slot_x,x                        ; ...at column 2x...
    asl a                               ; ...x 2: two screen bytes per cell
    sta plot_x                          ; ...as plot_x
    lda slot_y,x                        ; ...and row 5y
    asl a                               ; ...x 2...
    asl a                               ; ...x 4...
    clc                                 ; ...C clear for the addition
    adc slot_y,x                        ; ...+ the row: five pixel rows per cell
    sta plot_y                          ; ...as plot_y
    jsr plot_sprite                     ; Plot it
    rts                                 ; Return
; ***************************************************************************************
; Find a free door-key link
;
; The highest link whose door is &FF, for the key being placed for the waiting door. Were
; none free, link_index would be &FF.
;
; On Exit:
;     LINK_INDEX: the link
; &2cf7 referenced 1 time by &2c89
.find_free_link
    ldx #max_link                       ; For links 19 down...
; &2cf9 referenced 1 time by &2cff
.search_links
    lda link_door,x                     ; ...unused?
    bmi free_link_found                 ; ...negative: free
    dex                                 ; ...next link
    bpl search_links                    ; ...until all 20 are tried
; &2d01 referenced 1 time by &2cfc
.free_link_found
    stx link_index                      ; Use it
    rts                                 ; Return
; ***************************************************************************************
; Free a slot
;
; Zero its item and position. A free slot is therefore item 0 at (0, 0), as start_editing
; leaves every slot; item_at_cursor reads that as a wall in the top-left cell.
;
; On Entry:
;     X: slot
;
; On Exit:
;     A: 0
;     Z: set
; &2d05 referenced 3 times by &2c14, &2d5d, &2d93
.free_slot
    lda #0                              ; Zero its item...
    sta slot_item,x                     ; ...so the slot is free
    sta slot_x,x                        ; ...and position: column 0...
    sta slot_y,x                        ; ...row 0
    rts                                 ; Return
; ***************************************************************************************
; Delete what is in the cursor's cell
;
; TAB in the edit loop. Uncount the item and remove it. Deleting a door removes its key
; too but leaves the door's wall bit, so a wall shows where the door was; deleting a key
; removes its door and the door's wall. A waiting door is left alone. A wall is cleared.
;
; On Entry:
;     CURSOR_X: the cell's column
;     CURSOR_Y: the cell's row
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: corrupted
; &2d11 referenced 1 time by &20ba
.delete_item
    jsr item_at_cursor                  ; What is here?
    bmi delete_remove                   ; Nothing: remove_at_cursor finds nothing either
    beq delete_remove                   ; A wall: clear it
    cmp #spr_waiting_door               ; A waiting door?
    bne delete_item_slot                ; No: delete the item
    rts                                 ; Yes: it cannot be deleted
; &2d1d referenced 1 time by &2d1a
.delete_item_slot
    stx bit_mask                        ; Keep the item's slot, to match against links
    cmp #1                              ; The exit?
    beq delete_exit                     ; Yes: the exit is no longer placed
    cmp #3                              ; A trapdoor?
    beq delete_trapdoor                 ; Yes: one fewer trapdoor
    cmp #spr_door_vertical              ; A door?
    beq delete_door                     ; Yes: unlink it and delete its key
    cmp #spr_door_horizontal            ; ...the other door?
    beq delete_door                     ; Yes: unlink it and delete its key
    cmp #spr_key                        ; A key?
    beq delete_key                      ; Yes: delete its door too
    dec object_count                    ; An object: one fewer
    bpl delete_remove                   ; ...(always branches)
; &2d37 referenced 1 time by &2d21
.delete_exit
    lda #0                              ; The exit: none placed
    sta exit_placed                     ; ...clear exit_placed
    beq delete_remove                   ; ...(always branches)
; &2d3d referenced 1 time by &2d25
.delete_trapdoor
    dec trapdoor_count                  ; A trapdoor: one fewer
    bpl delete_remove                   ; ...(always branches)
; &2d41 referenced 2 times by &2d29, &2d2d
.delete_door
    dec door_count                      ; A door: uncount it...
    ldx #max_link                       ; ...find its link...
; &2d45 referenced 1 time by &2d63
.find_door_link_to_delete
    lda link_door,x                     ; This link's door slot...
    cmp bit_mask                        ; ...this door's?
    bne next_door_link                  ; No: next link
    lda #no_link                        ; ...free it...
    sta link_door,x                     ; ...in the link table
    lda link_key,x                      ; ...rub out its key...
    tax                                 ; ...into X
    pha                                 ; ...kept
    lda #spr_blank                      ; ...the blank sprite...
    jsr plot_slot                       ; ...rub it out in its cell
    pla                                 ; ...the key's slot back...
    tax                                 ; ...into X
    jsr free_slot                       ; ...and free the key's slot
    beq delete_remove                   ; ...(always branches)
; &2d62 referenced 1 time by &2d4a
.next_door_link
    dex                                 ; Next link
    bpl find_door_link_to_delete        ; ...until all 20 are tried
; &2d65 referenced 7 times by &2d14, &2d16, &2d35, &2d3b, &2d3f, &2d60, &2dac
.delete_remove
    jmp remove_at_cursor                ; Remove the item itself, or clear the wall
; &2d68 referenced 1 time by &2d31
.delete_key
    lda cursor_x                        ; A key: keep its cell, the cursor's...
    sta line_x                          ; ...in line_x...
    lda cursor_y                        ; ...and row...
    sta line_y                          ; ...in line_y
    ldx #max_link                       ; Find the key's link...
; &2d74 referenced 1 time by &2db0
.find_key_link
    lda link_key,x                      ; This link's key slot...
    cmp bit_mask                        ; ...this key's?
    bne next_key_link                   ; No: next link
    txa                                 ; ...keep it...
    pha                                 ; ...on the stack
    lda link_door,x                     ; ...take its door's slot...
    tax                                 ; ...into X
    pha                                 ; ...kept
    lda slot_x,x                        ; ...and move the cursor to the door's cell...
    sta cursor_x                        ; ...as the cursor's column...
    lda slot_y,x                        ; ...row...
    sta cursor_y                        ; ...as the cursor's row
    lda #spr_blank                      ; ...rub out the door...
    jsr plot_slot                       ; ...in its cell
    pla                                 ; ...free its slot...
    tax                                 ; ...into X
    jsr free_slot                       ; ...free it
    pla                                 ; ...uncount it...
    tax                                 ; ...the link number back into X
    dec door_count                      ; ...one fewer door
    lda #no_link                        ; ...free the link...
    sta link_door,x                     ; ...in the link table
    jsr clear_wall                      ; ...clear the door's wall, at the cursor...
    lda line_x                          ; ...and move the cursor back to the key's cell
    sta cursor_x                        ; ...as the cursor's column
    lda line_y                          ; ...the key's row...
    sta cursor_y                        ; ...as the cursor's row
    jmp delete_remove                   ; Remove the key
; &2daf referenced 1 time by &2d79
.next_key_link
    dex                                 ; Next link
    bpl find_key_link                   ; ...until all 20 are tried; none: fall through
; ***************************************************************************************
; Convert line_x to graphics x
;
; line_gx = line_x x 32: a cell is two screen bytes, four MODE 2 pixels, 32 graphics
; units wide. (delete_item also falls into it, harmlessly, when a key has no link.)
;
; On Entry:
;     LINE_X: a map column
;
; On Exit:
;     LINE_GX: its graphics x, column x 32
;     A: corrupted
;     X: preserved
;     Y: preserved
; &2db2 referenced 1 time by &2e0b
.line_x_to_graphics
    lda #0                              ; Clear the result
    sta line_gx                         ; ...low byte
    sta line_gx_hi                      ; ...high byte
    lda line_x                          ; x x 8...
    asl a                               ; ...x 2...
    asl a                               ; ...x 4...
    asl a                               ; ...x 8 (a column is below 32: no carry)
    clc                                 ; ...C clear (the ASL sets it anyway)
    asl a                               ; ...x 16...
    rol line_gx_hi                      ; ...carry into the high byte
    asl a                               ; ...x 32, with the carries in the high byte
    rol line_gx_hi                      ; ...carry into the high byte
    sta line_gx                         ; ...low byte
    rts                                 ; Return
; ***************************************************************************************
; Convert line_y to graphics y
;
; line_gy = &3FF - line_y x 20: a cell is five pixel rows, 20 graphics units, counted
; down from the top of the screen.
;
; On Entry:
;     LINE_Y: a map row
;
; On Exit:
;     LINE_GY: its graphics y, &3FF - row x 20
;     A: corrupted
;     X: preserved
;     Y: preserved
; &2dcd referenced 1 time by &2e11
.line_y_to_graphics
    lda #0                              ; Clear the result
    sta line_gy                         ; ...low byte
    sta line_gy_hi                      ; ...high byte
    lda line_y                          ; y x 4...
    asl a                               ; ...x 2...
    asl a                               ; ...x 4 (a row is below 48: no carry)
    sta bit_mask                        ; ...kept
    clc                                 ; ...C clear (the ASL sets it anyway)
    asl a                               ; ...x 8...
    rol line_gy_hi                      ; ...carry into the high byte
    asl a                               ; ...x 16...
    rol line_gy_hi                      ; ...carry into the high byte
    sta line_gy                         ; ...low byte kept
    clc                                 ; ...plus x 4: x 20 graphics units a row
    adc bit_mask                        ; ...y x 4 added...
    sta line_gy                         ; ...low byte
    lda line_gy_hi                      ; ...high byte...
    adc #0                              ; ...with the carry
    sta line_gy_hi                      ; ...kept
    lda #&ff                            ; &3FF - y x 20
    sec                                 ; ...C set for the subtraction
    sbc line_gy                         ; ...less y x 20, low byte...
    sta line_gy                         ; ...kept
    lda #3                              ; ...&3FF's high byte...
    sbc line_gy_hi                      ; ...less the high byte...
    sta line_gy_hi                      ; ...kept: row 0 at the top
    rts                                 ; Return
; ***************************************************************************************
; PLOT to a cell
;
; VDU 25 with plot code X and the graphics position of (line_x, line_y).
;
; On Entry:
;     X: PLOT code
; &2e08 referenced 2 times by &2e4e, &2e66
.plot_line_point
    lda line_x                          ; The cell's graphics position...
    jsr line_x_to_graphics              ; ...converted to graphics x
    lda line_y                          ; ...and the cell's y...
    jsr line_y_to_graphics              ; ...converted to graphics y
    lda #&19                            ; VDU 25, X...
    jsr oswrch                          ; ...send VDU 25, PLOT
    txa                                 ; ...the PLOT code, in X
    jsr oswrch                          ; ...send it
    lda line_gx                         ; ...x...
    jsr oswrch                          ; ...send the x low byte
    lda line_gx_hi                      ; ...x high byte
    jsr oswrch                          ; ...send it
    lda line_gy                         ; ...y
    jsr oswrch                          ; ...send the y low byte
    lda line_gy_hi                      ; ...y high byte
    jsr oswrch                          ; ...send it
    rts                                 ; Return
; ***************************************************************************************
; Draw each door-key link as a line
;
; For each link in use, move to the door's cell (PLOT 68) and draw a line to its key's
; (PLOT 5). The lines are exclusive-OR (GCOL 3, set at start-up), so the edit loop draws
; them when CTRL is pressed and again, rubbing them out, when it is released. Each line
; runs between the cells' top-left corners.
;
; On Exit:
;     A: corrupted
;     X: corrupted
;     Y: preserved
; &2e36 referenced 2 times by &20d2, &20dc
.draw_links
    ldx #max_link                       ; For links 19 to 0...
; &2e38 referenced 1 time by &2e6c
.draw_link
    txa                                 ; Keep the link number...
    pha                                 ; ...kept on the stack
    lda link_door,x                     ; ...in use?
    bmi next_drawn_link                 ; Free: next link
    tax                                 ; Yes: from the door's cell...
    lda slot_x,x                        ; ...its column...
    sta line_x                          ; ...as line_x
    lda slot_y,x                        ; ...its row...
    sta line_y                          ; ...as line_y
    ldx #&44 ; 'D'                      ; ...PLOT 68: move absolute...
    jsr plot_line_point                 ; ...to the door's cell, drawing nothing
    pla                                 ; ...to the key's cell...
    pha                                 ; ...kept
    tax                                 ; ...link number into X
    lda link_key,x                      ; ...the key's slot...
    tax                                 ; ...into X
    lda slot_x,x                        ; ...its column...
    sta line_x                          ; ...as line_x
    lda slot_y,x                        ; ...its row...
    sta line_y                          ; ...as line_y
    ldx #5                              ; ...PLOT 5: line to there...
    jsr plot_line_point                 ; ...draw the link, exclusive-OR (GCOL 3)
; &2e69 referenced 1 time by &2e3d
.next_drawn_link
    pla                                 ; Next link
    tax                                 ; ...back into X
    dex                                 ; ...the link before
    bpl draw_link                       ; ...until link 0 is done
    rts                                 ; Return
; ***************************************************************************************
; Unused
;
; Leftover bytes.
    equb &f8, &a5, &6a, &60, &20, &a6, &11, &a2
    equb &0b, &a0, &18, &a9, &94, &85, &0a, &a9
    equb &2e, &85, &0b, &20, &a6, &11, &a2, &08
    equb &a0, &1a, &a9, &a8, &85, &0a, &a9, &2e
    equb &85                            ; Not used
; ***************************************************************************************
; Test a key
;
; OSBYTE &81 with the INKEY number in X, as key_pressed.
;
; On Entry:
;     X: INKEY number
;
; On Exit:
;     Z: set if pressed
; &2e90 referenced 4 times by &2b14, &2b1f, &2b2e, &2b3f
.cursor_key_pressed
    ldy #&ff                            ; OSBYTE &81: scan the key...
    lda #osbyte_inkey                   ; ...Y = &FF: test the key whose INKEY number is X
    jsr osbyte                          ; Scan it: X = Y = &FF if the key is held  Test whether the key with negative INKEY number X is pressed
    cpx #&ff                            ; Z set if X and Y are both &FF
    bne cursor_key_done                 ; X not &FF: not pressed (Z clear)
    cpy #&ff                            ; ...Z set if Y is &FF too: pressed
; &2e9d referenced 1 time by &2e99
.cursor_key_done
    rts                                 ; Return
.dasmos_end

save "Editor", dasmos_start, dasmos_end, &239d, &1910

; Label references by decreasing frequency:
;     oswrch:                    57
;     scratch:                   31
;     cursor_y:                  26
;     bit_mask:                  25
;     cursor_x:                  25
;     screen_ptr:                21
;     map_ptr:                   19
;     chosen_block:              18
;     slot_x:                    17
;     slot_y:                    17
;     current_item:              16
;     key_pressed:               16
;     plot_y:                    16
;     osbyte:                    14
;     scratch_hi:                14
;     plot_x:                    13
;     link_door:                 12
;     slot_item:                 12
;     unpack_slot:               11
;     door_count:                10
;     oscli:                     10
;     object_count:               9
;     screen_ptr_hi:              9
;     line_gy_hi:                 8
;     trapdoor_count:             8
;     colour_10:                  7
;     delete_remove:              7
;     link_key:                   7
;     exit_placed:                6
;     filename_buffer:            6
;     line_gy:                    6
;     line_x:                     6
;     line_y:                     6
;     new_lines:                  6
;     pending_door_item:          6
;     place_item:                 6
;     place_put:                  6
;     plot_sprite:                6
;     sprite_number:              6
;     chooser_key_pressed:        5
;     chooser_moved_ok:           5
;     edit_keys:                  5
;     item_at_cursor:             5
;     level_object_y:             5
;     link_index:                 5
;     next_pass:                  5
;     pack_next:                  5
;     plot_at_cursor:             5
;     print_number:               5
;     save_level:                 5
;     ask_key:                    4
;     check_space:                4
;     clamp_cursor:               4
;     cursor_key_pressed:         4
;     level_checksum:             4
;     level_door_x:               4
;     level_object_type:          4
;     level_walls:                4
;     line_gx_hi:                 4
;     os_break_intercept:         4
;     packed_doors:               4
;     previous_block:             4
;     show_counts:                4
;     slow_cursor:                4
;     undo_move:                  4
;     wall_bit:                   4
;     block_place:                3
;     check_up:                   3
;     choose_filing_system:       3
;     crypt_level:                3
;     cursor_flash:               3
;     editor_init:                3
;     filename_buffer + 1:        3
;     frame_block:                3
;     free_slot:                  3
;     item_types:                 3
;     last_slot:                  3
;     level_door_y:               3
;     level_encrypted:            3
;     level_key_x:                3
;     level_key_y:                3
;     line_gx:                    3
;     object_free_map:            3
;     packed_objects:             3
;     packed_trapdoors:           3
;     pending_door_slot:          3
;     place_refused:              3
;     sprite_data_ptr:            3
;     unpack_link:                3
;     wall_map:                   3
;     ask_filename:               2
;     brkv:                       2
;     brkv + 1:                   2
;     check_ctrl:                 2
;     check_cursor_up:            2
;     check_tab:                  2
;     choose_door:                2
;     chooser_loop:               2
;     clear_wall:                 2
;     crypt_byte:                 2
;     delete_door:                2
;     draw_links:                 2
;     edit_loop:                  2
;     item_for_type:              2
;     key_down:                   2
;     key_left:                   2
;     key_right:                  2
;     key_up:                     2
;     level_door_sprite:          2
;     level_object_free:          2
;     level_trapdoor_x:           2
;     level_trapdoor_y:           2
;     level_wall_block:           2
;     map_ptr_hi:                 2
;     mark_object_cell:           2
;     new_level_flag:             2
;     next_slot:                  2
;     os_break_intercept_hi:      2
;     os_break_intercept_lo:      2
;     osword:                     2
;     place_door:                 2
;     plot_line_point:            2
;     plot_slot:                  2
;     read_line_block:            2
;     read_line_block + 1:        2
;     read_line_block + 2:        2
;     read_line_block + 3:        2
;     read_line_block + 4:        2
;     remove_done:                2
;     restore_waiting_door:       2
;     row_start_ptr:              2
;     row_start_ptr_hi:           2
;     scan_keys:                  2
;     set_colour_10:              2
;     show_labels:                2
;     sprite_addr_lo:             2
;     sprite_data_ptr_hi:         2
;     sum_level:                  2
;     unpack_level:               2
;     ask_level_number:           1
;     bit_0:                      1
;     bit_found:                  1
;     blank_load_name:            1
;     blank_save_name:            1
;     catalogue:                  1
;     check_back:                 1
;     check_cursor_down:          1
;     check_digit:                1
;     check_door_keys:            1
;     check_down:                 1
;     check_f0:                   1
;     check_item_keys:            1
;     check_left:                 1
;     check_level_number:         1
;     check_next_item:            1
;     check_right:                1
;     check_row_back:             1
;     check_row_on:               1
;     check_save:                 1
;     check_two_keys:             1
;     choose_tape:                1
;     choose_wall_block:          1
;     chooser_key_done:           1
;     chooser_moved:              1
;     chooser_pause:              1
;     chooser_pause_inner:        1
;     clamp_y:                    1
;     clear_door_entries:         1
;     clear_free_map:             1
;     clear_level_tables:         1
;     clear_links:                1
;     clear_object_entries:       1
;     clear_slots:                1
;     clear_walls:                1
;     copy_load_name:             1
;     copy_maps:                  1
;     copy_mark_object_cell:      1
;     copy_plotter_hi:            1
;     copy_plotter_lo:            1
;     copy_save_name:             1
;     copy_unpack:                1
;     copy_wall_block:            1
;     count_labels:               1
;     count_links:                1
;     count_tens:                 1
;     crypt_check_end:            1
;     cursor_key_done:            1
;     dasmos_start:               1
;     delete_exit:                1
;     delete_item:                1
;     delete_item_slot:           1
;     delete_key:                 1
;     delete_trapdoor:            1
;     digit_pressed:              1
;     door_linked:                1
;     door_not_linked:            1
;     door_waits:                 1
;     draw_cell:                  1
;     draw_link:                  1
;     draw_loaded:                1
;     draw_row:                   1
;     draw_wall_block:            1
;     draw_wall_blocks:           1
;     drive_digit:                1
;     drive_keys:                 1
;     drop_chalice:               1
;     edit_level:                 1
;     edit_screen_vdu:            1
;     filename_prompt:            1
;     filename_read:              1
;     fill_wall_block:            1
;     find_chalice:               1
;     find_door_link:             1
;     find_door_link_to_delete:   1
;     find_free_link:             1
;     find_free_slot:             1
;     find_key_link:              1
;     find_linked_door:           1
;     first_key:                  1
;     free_link_found:            1
;     free_slot_found:            1
;     key_pressed_done:           1
;     level_checksums - 1:        1
;     level_not_zero:             1
;     level_number:               1
;     level_number_ok:            1
;     level_number_prompt:        1
;     level_object_x:             1
;     level_typed:                1
;     line_x_to_graphics:         1
;     line_y_to_graphics:         1
;     load_command:               1
;     load_command + 11:          1
;     load_command + 5:           1
;     load_stones:                1
;     mark_bit_0:                 1
;     mark_bit_found:             1
;     mark_object_cell_image:     1
;     mark_shift_bit:             1
;     mos120_reset_entry:         1
;     mos_row_offsets:            1
;     mos_row_offsets_lo:         1
;     move_chooser:               1
;     move_cursor:                1
;     move_right:                 1
;     move_right_29:              1
;     new_level:                  1
;     next_cell:                  1
;     next_door:                  1
;     next_door_link:             1
;     next_drawn_link:            1
;     next_key_link:              1
;     next_link:                  1
;     next_object:                1
;     next_type:                  1
;     nothing_here:               1
;     osnewl:                     1
;     pack_door:                  1
;     pack_exit:                  1
;     pack_items:                 1
;     pack_key:                   1
;     pack_level:                 1
;     pack_slot:                  1
;     pack_trapdoor:              1
;     pause_inner:                1
;     pause_outer:                1
;     place_done:                 1
;     place_exit:                 1
;     place_in_empty:             1
;     place_key:                  1
;     place_not_edge:             1
;     place_trapdoor:             1
;     plot_byte:                  1
;     plot_count_byte:            1
;     plot_cursor:                1
;     plot_next_data:             1
;     plot_next_row:              1
;     plot_row:                   1
;     plot_sprite_byte:           1
;     plot_sprite_count_byte:     1
;     plot_sprite_next_data:      1
;     plot_sprite_next_row:       1
;     plot_sprite_row:            1
;     plotter_image:              1
;     plotter_image_page_2:       1
;     print_filename_prompt:      1
;     print_labels:               1
;     print_level_prompt:         1
;     print_prompt:               1
;     put_in_slot:                1
;     put_item:                   1
;     put_item_done:              1
;     quit:                       1
;     remove_at_cursor:           1
;     rows_25_vdu:                1
;     save_command:               1
;     save_command + 5:           1
;     screen_address:             1
;     screen_address_done:        1
;     search_links:               1
;     search_slots:               1
;     search_types:               1
;     send_25_rows:               1
;     send_edit_screen:           1
;     set_checksum:               1
;     set_colour_down:            1
;     set_colour_up:              1
;     set_edit_screen:            1
;     shift_bit:                  1
;     show_25_rows:               1
;     show_cursor_position:       1
;     slow_wait:                  1
;     sprite_addr_hi:             1
;     sprite_heights:             1
;     sprite_widths:              1
;     start_editing:              1
;     store_first_byte:           1
;     sum_below:                  1
;     sum_check_end:              1
;     tens_counted:               1
;     two_digits:                 1
;     unpack_door:                1
;     unpack_level_image:         1
;     unpack_loaded:              1
;     unpack_maps:                1
;     unpack_object:              1
;     unpack_trapdoor:            1
;     wait_b_released:            1
;     wait_ctrl_released:         1
;     wait_down_released:         1
;     wait_f0_released:           1
;     wait_space_released:        1
;     wait_up_released:           1
;     wall_edges:                 1
;     wall_left_right:            1
;     wall_top_bottom:            1

; Stats:
;     Total size (Code + Data) = 5518 bytes
;     Code                     = 3606 bytes (65%)
;     Data                     = 1912 bytes (35%)
;
;     Number of instructions   = 1687
;     Number of data bytes     = 1663 bytes
;     Number of data words     = 0 bytes
;     Number of string bytes   = 249 bytes
;     Number of strings        = 19
