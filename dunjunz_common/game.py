"""Annotations for the resident Dunjunz game, shared by every version.

Everything here is keyed by runtime address and describes code or data
that is byte-identical in the sideways RAM hack, Ole's crack and the
official disc release (see tools/runtime_images.py for the differences).
Where the versions differ, the drivers add their own annotations.
"""

from dunjunz_common.annotator import Annotator


def annotate(a: Annotator) -> None:
    _zero_page(a)
    _os_workspace(a)
    _screen(a)
    _text_output(a)
    annotate_state(a)
    annotate_routines(a)


# ---------------------------------------------------------------------------
# Zero page


def _zero_page(a: Annotator) -> None:
    zp = dict(group="zero_page", access="rw")
    a.label(0x70, "plot_x", description=(
        "Sprite position: screen byte column, 0-79 (two MODE 2 pixels per "
        "byte). Also used as a scratch byte and pointer low byte by other "
        "routines."), **zp)
    a.label(0x71, "plot_y", description=(
        "Sprite position: pixel row from the top of the screen. Also used as "
        "a pointer high byte by other routines."), **zp)
    a.label(0x72, "sprite_width", description=(
        "Width of the sprite being plotted, in screen bytes."), **zp)
    a.label(0x73, "sprite_height", description=(
        "Height of the sprite being plotted, in pixel rows."), **zp)
    for addr, name, what in [
        (0x74, "screen_ptr", "Screen address being written"),
        (0x76, "row_start_ptr",
         "Screen address of the first byte of the sprite row being plotted"),
        (0x78, "sprite_data_ptr", "Address of the next sprite data byte to plot"),
    ]:
        a.label(addr, name, description=what + ", low byte.", **zp)
        a.label(addr + 1, name + "_hi", description=what + ", high byte.", **zp)
    a.label(0x7A, "sprite_number", description=(
        "Sprite to plot: an index into the sprite tables at "
        "sprite_addr_lo, sprite_addr_hi, sprite_widths and sprite_heights."),
        **zp)


# ---------------------------------------------------------------------------
# OS workspace and MOS 1.20 internals


def _os_workspace(a: Annotator) -> None:
    a.label(0x0240, "os_vsync_counter", group="os_workspace", access="rw",
            description=(
                "MOS 1.20 counter decremented on every vertical sync "
                "interrupt. The game sets it and waits for it to run out to "
                "pace itself."))
    a.label(0x0C00, "user_char_128", group="os_workspace", access="w",
            length=8, description=(
                "MOS 1.20 storage for the definition of character 128 (eight "
                "bytes, one per pixel row). The WRCHV handler copies each "
                "letter or digit glyph here and prints character 128."))
    a.label(0xC375, "mos_row_offsets", group="mos_internals", access="r",
            description=(
                "MOS 1.20 table of screen row offsets for 640-byte rows "
                "(row x 640, high byte then low byte, one pair per character "
                "row). Read directly by screen_address; it is not part of any "
                "documented interface."))
    a.optional_label(0xC376, "mos_row_offsets_lo", group="mos_internals",
                     description="Low bytes of mos_row_offsets.")
    a.label(0xE0A4, "mos_oswrch_default", group="mos_internals",
            description=(
                "MOS 1.20 default OSWRCH routine, WRCHV's initial value. "
                "The WRCHV handler jumps here directly instead of through "
                "the saved vector."))


# ---------------------------------------------------------------------------
# Screen addressing and sprite plotting


def _screen(a: Annotator) -> None:
    a.label(0x1AE0, "sprite_addr_lo", length=120, description=(
        "Low bytes of the sprite data addresses, indexed by sprite number "
        "(120 entries)."))
    a.label(0x1B58, "sprite_addr_hi", length=120, description=(
        "High bytes of the sprite data addresses, indexed by sprite number."))
    a.label(0x1BD0, "sprite_widths", length=120, description=(
        "Sprite widths in screen bytes, indexed by sprite number."))
    a.label(0x1C48, "sprite_heights", length=120, description=(
        "Sprite heights in pixel rows, indexed by sprite number."))

    a.sub(0x0900, "plot_sprite", "Plot a sprite",
          description=(
              "Copy sprite sprite_number to the screen with its top-left "
              "corner at byte column plot_x, pixel row plot_y. The sprite "
              "tables give the address of its data and its size; the data "
              "is stored row by row, sprite_width bytes to a row, and is "
              "written over the screen contents without masking. The "
              "screen is laid out like MODE 2 with 640-byte character rows "
              "from &3000, so successive bytes of a sprite row are 8 bytes "
              "apart, and each pixel row starts one byte below the last, "
              "or 640-7 bytes on when it crosses into the next character "
              "row."),
          on_entry={"plot_x": "screen byte column (0-79)",
                    "plot_y": "pixel row",
                    "sprite_number": "sprite to plot"},
          on_exit={"A": "corrupted", "X": "0", "Y": "0"})
    a.c(0x0900, "X = sprite number")
    a.c(0x0902, "Point sprite_data_ptr at the sprite's data...")
    a.c(0x0905, "...low byte")
    a.c(0x0907, "...high byte from its own table")
    a.c(0x090A, "...")
    a.c(0x090C, "Width in screen bytes")
    a.c(0x090F, "...for the inner loop")
    a.c(0x0911, "Height in pixel rows")
    a.c(0x0914, "...for the outer loop")
    a.c(0x0916, "screen_ptr = address of the top-left byte")
    a.c(0x0919, "Index stays 0: the pointers themselves advance")
    a.c(0x091B, "X counts the pixel rows still to plot")
    a.c(0x091D, "Remember where this pixel row starts...")
    a.c(0x091F, "...")
    a.c(0x0921, "...")
    a.c(0x0923, "...in row_start_ptr")
    a.c(0x0925, "Save the row count")
    a.c(0x0926, "...")
    a.c(0x0927, "X counts the bytes across this row")
    a.c(0x0929, "Copy one sprite byte...")
    a.c(0x092B, "...to the screen")
    a.c(0x092D, "Step screen_ptr right one byte column: 8 bytes on")
    a.c(0x092E, "...")
    a.c(0x0930, "...")
    a.c(0x0932, "...")
    a.c(0x0934, "...")
    a.c(0x0936, "...with carry into the high byte")
    a.c(0x0938, "Next sprite data byte")
    a.c(0x093A, "...")
    a.c(0x093C, "...with carry into the high byte")
    a.c(0x093E, "Count the bytes across")
    a.c(0x093F, "Loop until the row is done")
    a.c(0x0941, "screen_ptr = row start + 1: the next pixel row down")
    a.c(0x0942, "...")
    a.c(0x0944, "...")
    a.c(0x0946, "...")
    a.c(0x0948, "...")
    a.c(0x094A, "...")
    a.c(0x094C, "...")
    a.c(0x094E, "Has it crossed into the next character row?")
    a.c(0x0950, "...(pixel row within the character now 0)")
    a.c(0x0952, "No: carry on")
    a.c(0x0954, "Yes: add 640-8 to reach the top pixel row of the...")
    a.c(0x0955, "...character row below")
    a.c(0x0957, "...")
    a.c(0x0959, "...")
    a.c(0x095B, "...")
    a.c(0x095D, "...")
    a.c(0x095F, "...")
    a.c(0x0961, "Recover the row count")
    a.c(0x0962, "...")
    a.c(0x0963, "Count the pixel rows")
    a.c(0x0964, "Loop until the sprite is done")
    a.c(0x0966, "Return")

    a.sub(0x0967, "screen_address", "Calculate a screen address",
          description=(
              "Set screen_ptr to the screen address of byte column plot_x "
              "on pixel row plot_y: &3000 + 640 x (plot_y DIV 8) + "
              "(plot_y MOD 8) + 8 x plot_x. The multiplication by 640 is "
              "done with a table inside MOS 1.20 (mos_row_offsets), so this "
              "only works with that MOS."),
          on_entry={"plot_x": "screen byte column (0-79)",
                    "plot_y": "pixel row"},
          on_exit={"screen_ptr": "screen address", "A": "corrupted",
                   "Y": "corrupted", "X": "preserved"})
    a.c(0x0967, "Character row = plot_y DIV 8...")
    a.c(0x0969, "...")
    a.c(0x096A, "...")
    a.c(0x096B, "...times 2 to index the table's byte pairs")
    a.c(0x096D, "...")
    a.c(0x096E, "High byte of row x 640, from the MOS table...")
    a.c(0x0971, "...")
    a.c(0x0972, "...plus &30: the screen starts at &3000")
    a.c(0x0974, "...")
    a.c(0x0976, "Low byte of row x 640")
    a.c(0x0979, "...")
    a.c(0x097B, "Add the pixel row within the character...")
    a.c(0x097D, "...")
    a.c(0x097F, "...(no carry: the low byte is &00 or &80)")
    a.c(0x0981, "...")
    a.c(0x0983, "Add 8 x plot_x: first its top three bits...")
    a.c(0x0984, "...")
    a.c(0x0986, "...")
    a.c(0x0988, "...rotated down to bits 0-2...")
    a.c(0x0989, "...")
    a.c(0x098A, "...")
    a.c(0x098B, "...")
    a.c(0x098C, "...")
    a.c(0x098D, "...into the high byte")
    a.c(0x098F, "...")
    a.c(0x0991, "...then plot_x x 8 into the low byte")
    a.c(0x0993, "...")
    a.c(0x0994, "...")
    a.c(0x0995, "...")
    a.c(0x0996, "...")
    a.c(0x0997, "...")
    a.c(0x0999, "...")
    a.c(0x099B, "...")
    a.c(0x099D, "...with carry into the high byte")
    a.c(0x099F, "Return")


# ---------------------------------------------------------------------------
# Text output: the WRCHV handler and its font


def _text_output(a: Annotator) -> None:
    a.label(0x12D3, "saved_wrchv", length=2, description=(
        "The WRCHV contents found at start-up, restored while the game "
        "uses the MOS's own text output."))
    a.label(0x12D7, "font_letters", length=26 * 8, description=(
        "The game's font for the letters A-Z: eight bytes per letter, one "
        "per pixel row, in MOS character-definition format."))
    a.banner(0x12D7, "Font: letters A-Z",
             "Eight bytes per letter, copied into the definition of "
             "character 128 by the WRCHV handler.")
    a.label(0x13A7, "font_digits", length=10 * 8, description=(
        "The game's font for the digits 0-9, in the same format as "
        "font_letters."))
    a.banner(0x13A7, "Font: digits 0-9",
             "Eight bytes per digit, copied into the definition of character "
             "128 by the WRCHV handler.")

    a.sub(0x7F8F, "wrch_handler", "WRCHV handler: print letters and digits in the game font",
          description=(
              "Installed on WRCHV while the game runs. A letter (either "
              "case) or a digit is printed in the game's own font: its "
              "eight-byte glyph is copied over the definition of character "
              "128 (user_char_128) and character 128 is printed instead. "
              "Every other character is printed unchanged. Both paths "
              "finish in the MOS 1.20 OSWRCH routine at mos_oswrch_default, "
              "jumped to directly rather than through the WRCHV value "
              "saved at start-up."),
          on_entry={"A": "character to print"},
          on_exit={"A": "corrupted", "X": "preserved", "Y": "preserved"})
    a.c(0x7F8F, "Keep the character")
    a.c(0x7F91, "Save X...")
    a.c(0x7F92, "...")
    a.c(0x7F93, "...and Y")
    a.c(0x7F94, "...")
    a.c(0x7F95, "Classify the character")
    a.c(0x7F97, "Below '0': print it unchanged")
    a.c(0x7F99, "...")
    a.c(0x7F9B, "'0'-'9': a digit")
    a.c(0x7F9D, "...")
    a.c(0x7F9F, "':'-'@': print it unchanged")
    a.c(0x7FA1, "...")
    a.c(0x7FA3, "'A'-'Z': a capital letter")
    a.c(0x7FA5, "...")
    a.c(0x7FA7, "'['-'`': print it unchanged")
    a.c(0x7FA9, "...")
    a.c(0x7FAB, "Above 'z': print it unchanged")
    a.c(0x7FAD, "...")
    a.c(0x7FAF, "A lower-case letter: letter number 0-25")
    a.c(0x7FB0, "...")
    a.c(0x7FB2, "...")
    a.c(0x7FB5, "A capital letter: letter number 0-25")
    a.c(0x7FB6, "...")
    a.c(0x7FB8, "x 8: offset of the glyph in font_letters")
    a.c(0x7FB9, "...")
    a.c(0x7FBA, "...")
    a.c(0x7FBB, "Branch to the next instruction either way")
    a.c(0x7FBD, "X = offset of the first glyph byte")
    a.c(0x7FBE, "Stop after eight bytes")
    a.c(0x7FBF, "...")
    a.c(0x7FC1, "...")
    a.c(0x7FC3, "Y indexes the character 128 definition")
    a.c(0x7FC5, "Copy a glyph byte...")
    a.c(0x7FC8, "...into the character 128 definition")
    a.c(0x7FCB, "...")
    a.c(0x7FCC, "...")
    a.c(0x7FCD, "...")
    a.c(0x7FCF, "Loop for eight bytes")
    a.c(0x7FD1, "Restore Y...")
    a.c(0x7FD2, "...")
    a.c(0x7FD3, "...and X")
    a.c(0x7FD4, "...")
    a.c(0x7FD5, "Print character 128, now showing the glyph...")
    a.c(0x7FD7, "...through the MOS 1.20 OSWRCH routine")
    a.c(0x7FDA, "A digit: digit number 0-9")
    a.c(0x7FDB, "...")
    a.c(0x7FDD, "x 8: offset of the glyph in font_digits")
    a.c(0x7FDE, "...")
    a.c(0x7FDF, "...")
    a.c(0x7FE0, "X = offset of the first glyph byte")
    a.c(0x7FE1, "Stop after eight bytes")
    a.c(0x7FE2, "...")
    a.c(0x7FE4, "...")
    a.c(0x7FE6, "Y indexes the character 128 definition")
    a.c(0x7FE8, "Copy a glyph byte...")
    a.c(0x7FEB, "...into the character 128 definition")
    a.c(0x7FEE, "...")
    a.c(0x7FEF, "...")
    a.c(0x7FF0, "...")
    a.c(0x7FF2, "Loop for eight bytes")
    a.c(0x7FF4, "Print character 128 (always branches)")
    a.c(0x7FF6, "Any other character: restore Y...")
    a.c(0x7FF7, "...")
    a.c(0x7FF8, "...and X")
    a.c(0x7FF9, "...")
    a.c(0x7FFA, "Recover the character")
    a.c(0x7FFC, "...and print it through the MOS 1.20 OSWRCH routine")


# ---------------------------------------------------------------------------
# Workspace and game state


def annotate_state(a: Annotator) -> None:
    """Names for the game's workspace tables. Hero tables have one entry
    per hero, indexed 0-3 (Ranger, Magic-User, Barbarian, Fighter: the
    top-left, top-right, bottom-left and bottom-right views)."""

    def hero_table(addr, name, description):
        a.label(addr, name, length=4, description=description)

    # Page &0B
    hero_table(0x0B20, "hero_max_missiles",
               "Number of missiles each hero may have in flight at once, 1-3 "
               "(raised by a pile of weapons).")
    a.label(0x0B24, "hero_magic_key", length=2, description=(
        "INKEY key numbers of the magic keys of heroes 0 and 1, the only "
        "heroes with magic."))
    a.label(0x0B26, "hero_magic_delay", length=2, description=(
        "Frames until heroes 0 and 1 next check their magic key."))
    a.label(0x0B28, "magic_kill_count", description=(
        "Monsters killed by the magic being cast, each worth a point."))
    a.label(0x0B2A, "returning_hero_queue", length=5, description=(
        "Queue of heroes waiting to come back: each entry is a hero number "
        "plus 1, or &64 for a slot that brings nobody back; 0 ends the "
        "queue. A Cross of Resurrection takes the first entry."))
    a.label(0x0B2F, "next_trapdoor", description=(
        "Index (0-7) of the trapdoor from which the next monster emerges."))
    a.label(0x0B30, "hero_arrival_sprites", length=9, description=(
        "Sprites shown, in turn, while a hero materialises."))
    a.label(0x0B40, "monster_hit_points", length=31, description=(
        "Hit points left for each monster (entries 1-30); a hit subtracts "
        "the missile's damage."))
    hero_table(0x0B70, "hero_missile_damage",
               "Damage each hero's missiles do, 1-9 (raised by a magic sword).")
    a.label(0x0B80, "missile_damage", length=12, description=(
        "Damage each missile in flight will do (12 slots, three per hero)."))
    a.label(0x0B90, "trapdoor_x", length=8, description=(
        "Map x of the level's eight trapdoors, from the level file."))
    a.label(0x0B98, "trapdoor_y", length=8, description=(
        "Map y of the level's eight trapdoors, from the level file."))
    hero_table(0x0BA0, "hero_score_hundreds",
               "Score hundreds digit, as a digit sprite (&1E-&27 for 0-9).")
    hero_table(0x0BA4, "hero_score_tens",
               "Score tens digit, as a digit sprite.")
    hero_table(0x0BA8, "hero_score_units",
               "Score units digit, as a digit sprite.")
    hero_table(0x0BAC, "hero_score_thousands",
               "Score thousands digit, as a digit sprite.")
    hero_table(0x0CD0, "hero_damage_taken",
               "Health each hero loses when a monster touches it, 3-9 "
               "(lowered by a magic helmet). The status panel shows "
               "10 minus this as the armour rating.")
    a.label(0x0C00, "room_walls", length=0xC9, description=(
        "The level's wall map, from the level file: eight bytes per room, "
        "one per row of cells, one bit per cell (bit 7 at the left). Rooms "
        "are 8x8 cells and run four to a row of the map. The first eight "
        "bytes are also the MOS 1.20 definition of character 128, which the "
        "WRCHV handler overwrites; the level is unpacked after the level "
        "number has been printed."))

    # Page &0D: refreshed from workspace_template at the start of each level
    a.label(0x0D00, "scratch", description="General-purpose scratch byte.")
    a.label(0x0D01, "scratch2", description="Second scratch byte.")
    a.label(0x0D02, "cell_x", description=(
        "Map x of the cell being drawn, tested or moved to. plot_at_cell "
        "replaces it with the pixel offset within the room."))
    a.label(0x0D03, "cell_y", description=(
        "Map y of the cell being drawn, tested or moved to. plot_at_cell "
        "replaces it with the pixel offset within the room."))
    a.label(0x0D04, "cell_room", description=(
        "Room of the cell being drawn, as an offset into room_walls."))
    a.label(0x0D06, "previous_x", description=(
        "Map x of the creature being moved, before the move."))
    a.label(0x0D07, "previous_y", description=(
        "Map y of the creature being moved, before the move."))
    a.label(0x0D08, "previous_offset_x", description=(
        "Pixel offset of the hero being moved, before the move."))
    a.label(0x0D09, "previous_offset_y", description=(
        "Pixel offset of the hero being moved, before the move."))
    hero_table(0x0D10, "hero_x", "Map x of each hero.")
    hero_table(0x0D15, "hero_y", "Map y of each hero.")
    hero_table(0x0D1A, "hero_direction",
               "Direction each hero faces: 1 up, 3 right, 5 down, 7 left; 0 "
               "when the hero is not in play.")
    hero_table(0x0D20, "hero_frame",
               "Animation frame of each hero (0 or 1), added to its sprite.")
    hero_table(0x0D25, "hero_step",
               "Frames left in each hero's step between cells.")
    hero_table(0x0D2A, "hero_offset_x",
               "Each hero's horizontal pixel offset while between cells.")
    a.label(0x0D30, "hero_offset_y", length=4, description=(
        "Each hero's vertical pixel offset while between cells."))
    a.label(0x0D40, "missile_x", length=12, description=(
        "Map x of each missile (12 slots, three per hero)."))
    a.label(0x0D4C, "missile_y", length=12, description="Map y of each missile.")
    a.label(0x0D58, "missile_direction", length=12, description=(
        "Direction of each missile: 1 up, 2 right, 3 down, 4 left; bit 7 "
        "set for a missile just fired; 0 for an empty slot."))
    a.label(0x0D64, "missile_sprite_base", length=12, description=(
        "Sprite base of each missile, to which its direction is added; also "
        "identifies the hero who fired it."))
    hero_table(0x0D70, "hero_key_up", "INKEY key number of each hero's up key.")
    hero_table(0x0D74, "hero_key_down", "INKEY key number of each hero's down key.")
    hero_table(0x0D78, "hero_key_right", "INKEY key number of each hero's right key.")
    hero_table(0x0D7C, "hero_key_left", "INKEY key number of each hero's left key.")
    hero_table(0x0D80, "hero_key_fire", "INKEY key number of each hero's fire key.")
    hero_table(0x0D90, "hero_health_tens",
               "Health tens digit, as a digit sprite (&1E-&27); &1D when the "
               "hero is dead.")
    hero_table(0x0D95, "hero_health_units", "Health units digit, as a digit sprite.")
    a.label(0x0DA0, "view_room", length=8, description=(
        "The room each hero's view shows: a pointer into room_walls, low "
        "byte then high byte, for each hero in turn (hero x at "
        "view_room + 2x)."))
    hero_table(0x0DB0, "hero_missile_sprites",
               "Sprite base of each hero's missiles: arrows, fireballs, axes, "
               "swords.")
    hero_table(0x0DB5, "hero_sprites",
               "Sprite base of each hero, to which direction and frame are added.")
    hero_table(0x0DBC, "hero_has_boots", "Non-zero while the hero wears Boots of Speed.")
    a.label(0x0DC0, "bit_masks", length=8, description=(
        "Bit masks for the cells of a room row, left to right: &80, &40 ... &01."))
    hero_table(0x0DD0, "hero_panel_y",
               "Pixel row of each hero's section of the status panel.")

    # Level data unpacked into the game's own tables
    a.label(0x2100, "object_map", length=0xC9, description=(
        "Map of the cells that hold an object, in the same layout as "
        "room_walls; from the level file."))
    a.label(0x2200, "door_x", length=21, description="Map x of each door (entries 1-20).")
    a.label(0x2220, "door_y", length=21, description="Map y of each door.")
    a.label(0x2240, "door_sprite", length=21, description="Sprite of each door.")
    a.label(0x2260, "key_x", length=21, description=(
        "Map x of each key lying on the floor (entries 1-20); key n opens "
        "door n."))
    a.label(0x2280, "key_y", length=21, description="Map y of each key on the floor.")
    hero_table(0x22E0, "hero_key", "Number of the key each hero carries, or 0.")
    hero_table(0x22E5, "hero_key_dropped",
               "Set when the hero has just swapped keys, so the key dropped "
               "is not picked straight back up.")
    hero_table(0x22F0, "hero_door_x", "Hero map x, kept for the door and key checks.")
    hero_table(0x22F5, "hero_door_y", "Hero map y, kept for the door and key checks.")
    a.label(0x2D00, "level_tail", length=0x30, description=(
        "The last &30 bytes of the level file."))

    a.label(0x7CFF, "monster_start_hit_points", description=(
        "Hit points a monster starts with on this level: 6 + 2 x the level number (8 on level 1)."))
    a.label(0x7D00, "workspace_template", length=0x100, description=(
        "Initial contents of page &0D, copied there at the start of every "
        "level."))
    a.label(0x7E00, "monster_x", length=0x29, description="Map x of each monster (entries 1-30).")
    a.label(0x7E29, "monster_y", length=0x29, description="Map y of each monster.")
    a.label(0x7E52, "monster_sprite", length=0x29, description=(
        "Each monster's state as a sprite number: 9, &0B, &0D or &0F moving "
        "up, right, down or left; &15-&19 dying; &1A ready to reappear."))
    a.label(0x7E7B, "monster_frame", length=0x29, description=(
        "Each monster's animation frame (0 or 1), added to its sprite."))
    a.label(0x7EA4, "monster_offset_x", length=0x29, description=(
        "Each monster's horizontal pixel offset while between cells."))
    a.label(0x7ECD, "monster_offset_y", length=0x29, description=(
        "Each monster's vertical pixel offset while between cells."))
    a.label(0x7EF6, "monster_step", length=0x29, description=(
        "Frames left in each monster's step between cells."))
    a.label(0x7F20, "object_x", length=0x1F, description=(
        "Map x of each object on the level (entries 1-30), from the level "
        "file; &FF once collected. Entry 30 is the exit."))
    a.label(0x7F3E, "exit_x", description="Map x of the exit (object 30).")
    a.label(0x7F3F, "object_y", length=0x1F, description="Map y of each object.")
    a.label(0x7F5D, "exit_y", description="Map y of the exit (object 30).")
    a.label(0x7F5E, "object_type", length=0x1F, description=(
        "Each object's type, which is also its sprite: &28 treasure, &29 "
        "food, &2A Cross of Resurrection, &2B teleporter, &51 exit, &53-&5E "
        "energy drainer (advancing with each hit), &5F Boots of Speed, &60 "
        "magic helmet, &61 potion of healing, &62 pile of weapons, &63 "
        "magic sword."))


# ---------------------------------------------------------------------------
# Routines


def annotate_routines(a: Annotator) -> None:
    X_HERO = {"X": "hero number (0-3)"}
    X_KEPT = {"X": "preserved"}

    # Scores and the status panel
    a.sub(0x0400, "add_thousand_points", "Add 1000 to a hero's score",
          "Advance the thousands digit of hero X's score. When it passes 9 it "
          "goes back to 0 and the ten-thousands digit, kept separately as one "
          "of the small digit sprites, goes up (to at most 9); that digit is "
          "then drawn below the score, with four further small sprites beside "
          "it.", on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x0ECF, "reset_hero", "Give a hero their starting attributes",
          "Set hero X's missile limit, missile damage and damage taken from "
          "the starting tables, and their score to zero. The units digit is "
          "set one below 0 because draw_status_panel draws the score by "
          "adding a point.", on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x0EF7, "draw_status_panel", "Draw the status panel",
          "Draw each hero's section of the status panel to the right of the "
          "views: health and score (by taking a health point and adding a "
          "score point, from starting values one beyond those wanted), face, "
          "shield and armour rating, one icon per missile allowed, and "
          "missile damage.")
    a.sub(0x0F68, "plot_panel_sprite", "Plot a sprite in a hero's panel section",
          "Plot sprite A at byte column X and pixel row Y + hero_panel_y - "
          "14 for the hero being drawn (draw_status_panel's loop counter).",
          on_entry={"A": "sprite number", "X": "byte column",
                    "Y": "row within the hero's panel section"})
    a.sub(0x7221, "lose_health_point", "Take one health point from a hero",
          "If hero X is in play, take one from their health and redraw it. "
          "When it falls below 00 the hero dies: their sprite is erased, "
          "they leave play, and their number joins returning_hero_queue.",
          on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x728C, "add_point", "Add one point to a hero's score",
          "Add one to hero X's score, carrying into the higher digits, and "
          "redraw it.", on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x729B, "add_ten_points", "Add ten points to a hero's score",
          "Add ten to hero X's score, carrying into the higher digits, and "
          "redraw it.", on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x75F9, "point_at_boots_icon", "Set the position of a hero's boots icon",
          "Set plot_x and plot_y to the place in hero X's panel section that "
          "shows the lightning bolt for Boots of Speed.", on_entry=X_HERO)
    a.sub(0x7606, "plot_boots_icon", "Show a hero's boots icon",
          "Plot the lightning bolt at plot_x, plot_y.", on_exit=X_KEPT)
    a.sub(0x760D, "erase_boots_icon", "Remove a hero's boots icon",
          "Plot the blank sprite over the lightning bolt at plot_x, plot_y.",
          on_exit=X_KEPT)

    # The hero-selection menu
    a.sub(0x0500, "hero_menu", "Choose the heroes and the sound",
          "Clear the left of the screen, print the menu and let the players "
          "toggle each hero (keys 1-4) and the sound (5 on, 6 off). SPACE "
          "starts the game if at least one hero is playing.")
    a.sub(0x0524, "print_menu", "Print the menu text",
          "Print the sixteen positioned strings of menu_text.")
    a.sub(0x052E, "print_menu_string", "Print one menu string",
          "Move the text cursor to the column and row in the two bytes at "
          "menu_text+Y, then print the following characters up to and "
          "including a carriage return.",
          on_entry={"Y": "offset of the string in menu_text"},
          on_exit={"Y": "offset of the next string"})
    a.sub(0x054D, "set_menu_no", "Change a menu entry to NO",
          "Write \"NO \" at menu_text+Y.", on_entry={"Y": "offset of the entry"})
    a.sub(0x055D, "set_menu_yes", "Change a menu entry to YES",
          "Write \"YES\" at menu_text+Y.", on_entry={"Y": "offset of the entry"})
    a.sub(0x056D, "set_menu_off", "Change the sound entry to OFF",
          "Write \"FF\" at menu_text+Y, after its \"O\".",
          on_entry={"Y": "offset of the entry's second character"})
    a.sub(0x0576, "set_menu_on", "Change the sound entry to ON",
          "Write \"N \" at menu_text+Y, after its \"O\".",
          on_entry={"Y": "offset of the entry's second character"})
    a.sub(0x06B0, "remove_absent_heroes", "Take the heroes nobody plays out of the game",
          "Draw any ten-thousands score digits, then put every hero switched "
          "off on the menu out of play, with a &64 entry in "
          "returning_hero_queue in their place.")

    # Levels
    a.sub(0x14A0, "reset_workspace", "Reset the game workspace for a new level",
          "Copy workspace_template into page &0D and clear the per-level "
          "state.")
    a.sub(0x14D7, "draw_view_frames", "Draw the frames round the four views",
          "With the MOS's own text output restored, send the twenty PLOT "
          "commands of view_frame_plots, draw the four views, then put the "
          "game's WRCHV handler back.",
          on_entry={"plot_x": "address of view_frame_plots, low byte",
                    "plot_y": "address of view_frame_plots, high byte"})
    a.sub(0x1510, "unpack_level", "Copy the loaded level into the game's tables",
          "Distribute the level file at &6B00 into the object, door, key, "
          "trapdoor and map tables.")
    a.sub(0x1583, "reset_monsters", "Clear the monsters for a new level",
          "Mark every monster as not yet appeared, give each the level's "
          "starting hit points, and clear the heroes' keys and the "
          "returning_hero_queue.")
    a.sub(0x161A, "clear_text_area", "Clear the left of the screen",
          "Set a text window over the left of the screen and clear it.")

    # Winning
    a.sub(0x1070, "check_for_victory", "Check whether the Chalice has been found",
          "On level 25, if a hero stands on the cell where the Chalice is, "
          "play the victory sequence, print the closing message, wait for a "
          "key and reset the machine through the RESET vector.")
    a.sub(0x10E9, "victory_sequence", "Play the victory sequence",
          "Spin sprites round the Chalice with a rising tone, then dissolve "
          "it.")
    a.sub(0x1149, "draw_victory_ring", "Draw the ring of sprites round the Chalice",
          "Plot the current victory sprite at the twelve cells round the "
          "Chalice, changing sprite as it goes.")
    a.sub(0x119A, "plot_victory_sprite", "Plot a victory sprite at a cell",
          "Plot the current victory sprite at the map cell in &80, &81.")
    a.sub(0x11AC, "next_victory_sprite", "Choose the next victory sprite",
          "Step the victory sprite through &16-&19.")
    a.sub(0x11BE, "dissolve_chalice", "Clear a random byte of the Chalice",
          "Use the System VIA timer to pick a byte of the Chalice sprite, "
          "clear it, and redraw the Chalice.")
    a.sub(0x11F2, "plot_chalice", "Plot the Chalice",
          "Plot the Chalice sprite at its place on the map.")

    # The main loop
    a.sub(0x1CC0, "update_game", "Run one frame of play",
          "Move the heroes, open doors for heroes carrying the right key, "
          "pick up and swap keys, then draw the objects, move the missiles "
          "and the monsters, and handle the pause key.")
    a.sub(0x203A, "hero_enters_exit", "Start a hero going down the exit",
          "Play the exit sound and begin shrinking the hero's sprites.",
          on_entry=X_HERO)
    a.sub(0x2050, "restore_hero_sprites", "Restore a hero's sprite sizes",
          "Put back the width and height of all eight of hero X's sprites, "
          "which the exit animation shrinks.", on_entry=X_HERO)
    a.sub(0x2091, "drop_key", "Drop the key a hero carries",
          "Put hero X's key in a free cell next to them, and remove it from "
          "their panel section.", on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x20D0, "find_open_neighbour", "Find a free cell next to a cell",
          "Starting with cell_x, cell_y, try the cells above, to the right, "
          "below and to the left, and leave cell_x, cell_y at the first "
          "without a wall.")
    a.sub(0x16A0, "queue_exit_marker", "Sound the exit and add a queue marker",
          "Play the exit sound and put a &64 entry in the first free slot of "
          "returning_hero_queue.")

    # Heroes
    a.sub(0x6E80, "move_heroes", "Move the heroes",
          "For each hero in play: continue a step between cells, or read the "
          "hero's keys (and, for heroes 0 and 1, the magic key) and start a "
          "step or fire a missile; check the new cell for walls, monsters, "
          "other heroes and objects, change view when the hero enters "
          "another room, and draw the hero.")
    a.sub(0x7B62, "start_hero_step", "Start a hero's step between cells",
          "Set hero X's step counter to 1 and their pixel offsets for the "
          "direction they face: 6 rows up or down, or 2 byte columns left or "
          "right.",
          on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x7BA2, "continue_hero_step", "Continue a hero's step between cells",
          "Toggle hero X's animation frame and count down their step. When "
          "it ends, move the hero one cell in the direction they face and "
          "clear the pixel offsets. The offsets are then doubled.",
          on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x76DA, "hero_arrives", "Bring a returning hero into play",
          "Every other frame, show the next of the hero's arrival sprites. "
          "After the last, put the hero in play facing down with health 32 "
          "(set to 33 and drawn by taking a point).", on_entry=X_HERO)
    a.sub(0x7732, "draw_hero", "Draw a hero",
          "Plot sprite_number at hero X's cell and pixel offset in every view "
          "that shows it.", on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x777A, "get_hero_cell", "Copy a hero's position to cell_x, cell_y",
          on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x7329, "collect_objects", "Pick up the object in a hero's cell",
          "Find the object at hero X's cell and act on it: score, health, "
          "teleport, resurrection, energy drain, or one of the magic items.",
          on_entry=X_HERO)
    a.sub(0x74A3, "play_pickup_sound", "Play the pickup sound",
          "Define the pickup envelope and play the pickup sound, from the "
          "OSWORD parameter blocks at &192C and &193A.")

    # Missiles
    a.sub(0x70CA, "move_missiles", "Move the missiles",
          "Advance every missile in flight one cell. A missile stops at a "
          "wall, damages a monster or hero it meets, and bounces back off an "
          "energy drainer, wearing it down.")
    a.sub(0x7747, "flip_firer_frame", "Animate the hero who fired a missile",
          "Toggle the animation frame of the hero whose missile is in slot X.",
          on_entry={"X": "missile slot"})
    a.sub(0x76B1, "credit_missile_owner", "Give a point to the hero who fired a missile",
          on_entry={"X": "missile slot"}, on_exit=X_KEPT)

    # The views
    a.sub(0x7788, "draw_all_views", "Draw all four views",
          "Draw the room each hero's view shows.")
    a.sub(0x7795, "draw_view_0", "Draw the top-left view",
          "Draw the room in hero 0's view.")
    a.sub(0x77A7, "draw_view_1", "Draw the top-right view",
          "Draw the room in hero 1's view.")
    a.sub(0x77B9, "draw_view_2", "Draw the bottom-left view",
          "Draw the room in hero 2's view.")
    a.sub(0x77CB, "draw_view_3", "Draw the bottom-right view",
          "Draw the room in hero 3's view.")
    a.sub(0x77DE, "draw_room", "Draw a room",
          "Draw the eight rows of walls of the room at &7B, &7C (a pointer "
          "into room_walls) with its top-left at plot_y and the column in "
          "cell_x, then draw the doors.")
    a.sub(0x7820, "draw_room_row", "Draw one row of a room",
          "Plot a wall or a blank for each of the eight bits of scratch, "
          "four byte columns apart, starting at byte column cell_x.")
    a.sub(0x7852, "plot_at_cell", "Plot a sprite at a map cell in every view",
          "Plot sprite_number at map cell cell_x, cell_y, shifted by the "
          "pixel offsets in &7D, &7E, in each view that shows the cell's "
          "room. Cells are four byte columns wide and twelve pixel rows "
          "high.", on_entry={"cell_x": "map x", "cell_y": "map y",
                             "sprite_number": "sprite to plot"})
    a.sub(0x78FC, "test_wall", "Test for a wall at a map cell",
          "Return the room_walls bit for cell cell_x, cell_y: non-zero if "
          "there is a wall. Also leaves &7B, &7C pointing at the cell's room.",
          on_exit={"A": "wall bit", "Y": "wall bit", "Z": "set if no wall"})
    a.sub(0x7938, "test_object_map", "Test for an object at a map cell",
          "Return the object_map bit for cell cell_x, cell_y: non-zero if an "
          "object may lie there.",
          on_exit={"A": "object bit", "Y": "object bit", "Z": "set if none"})
    a.sub(0x7974, "find_creature", "Look for a monster or hero at a cell",
          "Look for a monster, other than monster number scratch, at cell_x, "
          "cell_y. If scratch is non-zero, also look for a hero there, and "
          "if one is found take hero_damage_taken points of their health.",
          on_exit={"A": "non-zero if something was found",
                   "Y": "non-zero if a monster was found"})

    # Monsters
    a.sub(0x79C1, "update_monsters", "Draw the trapdoors and move the monsters",
          "Draw the eight trapdoors, then for each monster continue its step "
          "or start a new one, turning a random way when it is blocked, and "
          "advance dying monsters until they reappear at a trapdoor.")
    a.sub(0x7BEB, "start_monster_step", "Start a monster's step between cells",
          "Set the step counter and the pixel offsets for monster X's "
          "direction.", on_entry={"X": "monster number"})
    a.sub(0x7C2B, "continue_monster_step", "Continue a monster's step between cells",
          "Toggle monster X's frame and move its pixel offsets towards zero, "
          "moving it to the next cell when the step ends.",
          on_entry={"X": "monster number"})

    # Keyboard
    a.sub(0x7C95, "test_key", "Test whether a key is pressed",
          "Scan the key whose INKEY number is in A with OSBYTE &81.",
          on_entry={"A": "INKEY key number (negative, as a byte)"},
          on_exit={"A": "0 if the key is pressed, 1 if not",
                   "Z": "set if the key is pressed", "X": "preserved"})
