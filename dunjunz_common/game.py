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
    annotate_level_file(a)
    annotate_core_comments(a)
    annotate_sprites(a)
    annotate_data(a)
    annotate_hero_comments(a)
    annotate_play_loop(a)
    annotate_missile_and_object_comments(a)
    annotate_monster_comments(a)
    annotate_update_game_comments(a)


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
    a.label(0x0B30, "hero_appearance_sprites", length=9, description=(
        "Sprites of a hero dying, in order (sparkles &16-&19, then skulls "
        "&64-&68, ending as the skull left where the hero fell), or "
        "returning, in reverse."))
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
        "WRCHV handler overwrites with each glyph it prints; the level is "
        "unpacked only after the level number has been printed."))

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
    a.label(0x2100, "object_free_map", length=0xC9, description=(
        "Map of the cells that cannot hold an object, in the same layout as "
        "room_walls, from the level file: a bit is clear where an object "
        "lies (and on a few other cells), so the object list need only be "
        "searched when a hero steps onto a clear bit."))
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
    a.label(0x2D00, "wall_sprite", length=0x30, description=(
        "Data of sprite 0, the wall block (4 bytes x 12 rows), replaced by "
        "each level's own from the level file."))

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
          "trapdoor and map tables and the wall sprite.")
    a.sub(0x1583, "reset_monsters", "Clear the monsters for a new level",
          "Mark every monster as not yet appeared, give each the level's "
          "starting hit points, and clear the heroes' keys and the "
          "returning_hero_queue.")
    a.sub(0x161A, "clear_text_area", "Clear the left of the screen",
          "Set a text window over the left of the screen and clear it.")

    # Winning
    a.sub(0x1070, "check_for_victory", "Check whether the Chalice has been found",
          "On level 25, if a hero stands on the cell where the Chalice is, "
          "play the victory sequence, print the ending message, wait for a "
          "key and reset the machine through the RESET vector. The message "
          "is not part of the program: it is the 140 bytes at room_walls + "
          "&3A followed by the string at object_free_map + &3A, which on "
          "level 25 hold the ending text instead of map data.")
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
          "Play the exit sound, restore any hero shrunk before, and start "
          "the animation of hero X spinning and shrinking on the exit. Ends "
          "by jumping to play_level rather than returning.", on_entry=X_HERO)
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
    a.sub(0x76DA, "animate_absent_hero", "Animate a hero who is out of play",
          "Every other frame, step hero_frame by hero_offset_x through "
          "hero_appearance_sprites and plot the sprite at the hero's cell: "
          "forwards (+1) for a hero dying, stopping at the skull; backwards "
          "(-1) for a hero returning through a Cross of Resurrection. When a "
          "returning hero reaches the first sprite, put them in play facing "
          "down with health 32 (set to 33 and drawn by taking a point).",
          on_entry=X_HERO)
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
    a.sub(0x752C, "show_hero_room", "Show the room a hero has moved into",
          "Set hero X's view to the room containing their cell and redraw "
          "that view.", on_entry=X_HERO, on_exit=X_KEPT)
    for addr, text in [
        (0x752C, "Find the room of the hero's cell (test_wall leaves it in "
                 "&7B)"),
        (0x753F, "Keep X"),
        (0x7540, "view_room entry for this hero..."),
        (0x7541, "..."), (0x7542, "..."), (0x7544, "...now this room"),
        (0x7547, "Redraw this hero's view"),
    ]:
        a.c(addr, text)
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
    a.sub(0x7938, "test_object_free", "Test whether a map cell can hold an object",
          "Return the object_free_map bit for cell cell_x, cell_y: zero if "
          "an object may lie there.",
          on_exit={"A": "map bit", "Y": "map bit",
                   "Z": "set if an object may lie there"})
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
          "Set monster X's step counter to 3 and its pixel offsets to one "
          "step in its direction of travel: 3 rows up or down, or one byte "
          "column left or right.", on_entry={"X": "monster number"})
    a.sub(0x7C2B, "continue_monster_step", "Continue a monster's step between cells",
          "Toggle monster X's frame and count down its step. When it ends, "
          "move the monster one cell on and clear its offsets; otherwise "
          "grow the offsets by another column or three rows.",
          on_entry={"X": "monster number"})

    # Keyboard
    a.sub(0x7C95, "test_key", "Test whether a key is pressed",
          "Scan the key whose INKEY number is in A with OSBYTE &81.",
          on_entry={"A": "INKEY key number (negative, as a byte)"},
          on_exit={"A": "0 if the key is pressed, 1 if not",
                   "Z": "set if the key is pressed", "X": "preserved"})


# ---------------------------------------------------------------------------
# Code present in some versions only. Each driver calls the functions that
# match its bytes (see tools/runtime_images.py).


def annotate_game_entry(a: Annotator) -> None:
    """&0D31-&0D6A: identical in every version. In the crack it is never
    run (its start-up code at &5000 does the same job)."""
    a.sub(0x0D31, "game_entry", "Start the game",
          "Set the bell sound (the BEL character's channel, envelope, pitch "
          "and duration), save WRCHV in saved_wrchv and point WRCHV at "
          "wrch_handler. The code here is run once only: from &0D40 its "
          "bytes are then reused as the missile tables and other workspace "
          "in page &0D, which reset_workspace refreshes for each level.")
    a.c(0x0D31, "OSBYTE &D3: bell channel...")
    a.c(0x0D33, "...channel &11")
    a.c(0x0D37, "...")
    a.c(0x0D3A, "OSBYTE &D4: bell envelope...")
    a.c(0x0D3C, "...0, a fixed amplitude")
    a.c(0x0D40, "...")
    a.c(0x0D43, "OSBYTE &D5: bell pitch...")
    a.c(0x0D45, "...&64")
    a.c(0x0D49, "...")
    a.c(0x0D4C, "OSBYTE &D6: bell duration...")
    a.c(0x0D4E, "...1")
    a.c(0x0D52, "...")
    a.c(0x0D55, "Save WRCHV...")
    a.c(0x0D58, "...")
    a.c(0x0D5B, "...")
    a.c(0x0D5E, "...in saved_wrchv")
    a.c(0x0D61, "Point WRCHV at wrch_handler...")
    a.c(0x0D63, "...")
    a.c(0x0D66, "...")
    a.c(0x0D68, "...")
    a.label(0xD9CD, "mos_reset_entry", group="mos_internals", description=(
        "MOS 1.20 reset entry, the target of the RESET vector. Called "
        "directly to reset the machine."))


def annotate_level_check(a: Annotator) -> None:
    """&0450-&04A9: the level decrypt-and-check routine and its table, in
    the official disc release and the sideways RAM hack."""
    a.sub(0x0450, "decrypt_level", "Decrypt and check the level just loaded",
          "Decrypt the level at &6B00-&6DAF in place, XORing each byte with "
          "the low byte of its own address, and sum the decrypted bytes. If "
          "the sum does not match the level's entry in level_checksums, "
          "reset the machine.",
          on_entry={"level_number": "level loaded (1-25)"})
    a.c(0x0450, "Point at &6B00, the start of the level...")
    a.c(0x0452, "...low byte")
    a.c(0x0454, "Start the sum at zero")
    a.c(0x0456, "...")
    a.c(0x0458, "...high byte")
    a.c(0x045A, "Fetch a byte...")
    a.c(0x045C, "...XOR it with the low byte of its address...")
    a.c(0x045E, "...and store it back decrypted")
    a.c(0x0460, "Add it to the sum")
    a.c(0x0461, "...")
    a.c(0x0463, "...")
    a.c(0x0465, "Next byte...")
    a.c(0x0467, "...")
    a.c(0x0469, "...with carry into the high byte")
    a.c(0x046B, "Stop at &6DB0, the end of the level...")
    a.c(0x046D, "...")
    a.c(0x046F, "...")
    a.c(0x0471, "...")
    a.c(0x0473, "...")
    a.c(0x0475, "...")
    a.c(0x0477, "X = level number")
    a.c(0x047A, "Compare the sum...")
    a.c(0x047C, "...with this level's checksum")
    a.c(0x047F, "Match: return")
    a.c(0x0481, "No match: reset the machine (MOS 1.20 only)")
    a.c(0x0484, "Return")
    a.index_base(0x0490, "level_checksums", group="game_data", description=(
        "The expected sum of each decrypted level, for levels 1-25 at "
        "level_checksums+1 to level_checksums+25."))
    a.byte(0x0491, 25, cols=5)
    a.banner(0x0491, "Level checksums",
             "One byte per level, 1-25: the sum, modulo 256, of the level's "
             "decrypted bytes.")


def annotate_start_level(a: Annotator) -> None:
    """&1400-&1445: identical in every version (what the routines it calls
    do differs)."""
    a.label(0x169F, "level_number", description="The current level, 1-25.")
    a.label(0x16FF, "level_bcd", description=(
        "The current level in binary-coded decimal, for printing and for the "
        "level's filename."))
    a.label(0x163A, "view_frame_plots", length=100, description=(
        "Twenty VDU 25 (PLOT) commands, five bytes each, that draw the "
        "frames round the four views."))
    a.byte(0x163A, 100, cols=5)
    a.banner(0x163A, "View frame PLOT commands",
             "Twenty five-byte VDU 25 commands (plot code, x, y) sent by "
             "draw_view_frames.")
    a.sub(0x1400, "start_level", "Set up and draw a new level",
          "Show the level number, load and unpack the level, reset the "
          "workspace and monsters, then clear the text area, set the screen "
          "to its full 25-row height and draw the view frames and views.")
    a.c(0x1400, "Show the level number")
    a.c(0x1403, "Load the level")
    a.c(0x1406, "Copy it into the game's tables")
    a.c(0x1409, "Reset page &0D")
    a.c(0x140C, "Reset the monsters and keys")
    a.c(0x140F, "Clear the text area")
    a.c(0x1412, "VDU 23,0,6,25,0,0,0,0,0,0: set 6845 register 6...")
    a.c(0x1414, "...")
    a.c(0x1417, "...")
    a.c(0x141C, "...")
    a.c(0x1421, "...to 25 character rows displayed")
    a.c(0x1426, "...")
    a.c(0x143A, "Point at view_frame_plots...")
    a.c(0x143E, "...")
    a.c(0x1442, "...and draw the frames and the views")
    a.c(0x1445, "Return")


def annotate_cassette_level_loop(a: Annotator) -> None:
    """&0E14-&0ECE and &15B1-&1619: the level loop and level display of the
    crack and the sideways RAM hack, which derive from the cassette."""
    a.label(0x16D5, "level_filename_digits", description=(
        "Where the level number's digits are written into the level's "
        "filename."))
    a.label(0x0E14, "level_loop")
    a.block(0x0E14, "Play each level in turn until every hero is dead.")
    a.c(0x0E14, "Monster hit points = 8 + 2 x (levels played)...")
    a.c(0x0E17, "...")
    a.c(0x0E18, "...")
    a.c(0x0E19, "...")
    a.c(0x0E1B, "...")
    a.c(0x0E1E, "Add 1 to the level number in decimal...")
    a.c(0x0E1F, "...")
    a.c(0x0E20, "...")
    a.c(0x0E23, "...")
    a.c(0x0E25, "...")
    a.c(0x0E28, "...")
    a.c(0x0E29, "One digit for levels 1-9, two from 10 (the count is "
                "incremented later, in show_level_number)")
    a.c(0x0E2C, "...")
    a.c(0x0E2E, "...")
    a.c(0x0E30, "X = 0: one digit")
    a.c(0x0E34, "X = 1: two digits")
    a.c(0x0E36, "Units digit...")
    a.c(0x0E39, "...")
    a.c(0x0E3B, "...as ASCII...")
    a.c(0x0E3C, "...")
    a.c(0x0E3E, "...into the filename")
    a.c(0x0E41, "Two digits?")
    a.c(0x0E43, "No")
    a.c(0x0E45, "Yes: the tens digit...")
    a.c(0x0E48, "...")
    a.c(0x0E4C, "...as ASCII...")
    a.c(0x0E4D, "...")
    a.c(0x0E4F, "...goes first")
    a.c(0x0E52, "Terminate the filename with a carriage return")
    a.c(0x0E54, "...")
    a.c(0x0EC3, "Wait up to 6000 centiseconds (60 s) for a key...")
    a.c(0x0EC5, "...")
    a.c(0x0EC7, "...")
    a.c(0x0EC9, "...")
    a.c(0x0ECC, "...then start a new game")

    a.sub(0x15B1, "show_level_number", "Show the number of the level about to start",
          "Clear the text area, count the level, plot the word LEVEL and "
          "print the number in the game's font, then set a text window and "
          "colour for later messages.")
    a.c(0x15B1, "Clear the text area")
    a.c(0x15B4, "COLOUR 6...")
    a.c(0x15B9, "...")
    a.c(0x15BE, "Count the level")
    a.c(0x15C1, "Plot the word LEVEL...")
    a.c(0x15C5, "...")
    a.c(0x15C9, "...")
    a.c(0x15CD, "...")
    a.c(0x15D0, "TAB(10,5)...")
    a.c(0x15D5, "...")
    a.c(0x15DA, "...")
    a.c(0x15DF, "Print the tens digit...")
    a.c(0x15E2, "...")
    a.c(0x15E3, "...")
    a.c(0x15E8, "...")
    a.c(0x15EA, "...in the game's font")
    a.c(0x15ED, "Print the units digit...")
    a.c(0x15EE, "...")
    a.c(0x15F1, "...")
    a.c(0x15F3, "...in the game's font")
    a.c(0x15F6, "VDU 28,1,22,14,17: a text window...")
    a.c(0x1605, "...")
    a.c(0x160A, "COLOUR 2...")
    a.c(0x1614, "...")
    a.c(0x1619, "Return")


def annotate_level_end(a: Annotator) -> None:
    """&0E57-&0EC2: playing a level and the game-over message, identical in
    every version apart from where the branches lead."""
    a.label(0x0F90, "game_over_message", description=(
        "The message printed when every hero has died, terminated by a zero "
        "byte."))
    a.label(0x0FF1, "panel_hero", description=(
        "Hero counter for draw_status_panel. It is a byte of "
        "game_over_message, which is repaired before printing."))
    a.label(0x0FF2, "count", description=(
        "Counter, used for the dead heroes at the end of a level and the "
        "rows of missile icons. It is a byte of game_over_message."))
    a.c(0x0E57, "Load and draw the level")
    a.c(0x0E5A, "Draw the status panel")
    a.c(0x0E5D, "Take out the heroes nobody plays")
    a.c(0x0E60, "Let one vertical sync pass before play starts")
    a.c(0x0E62, "...")
    a.c(0x0E65, "Play the level until it ends")
    a.c(0x0E68, "Count the heroes who died, giving each back their "
                "starting attributes")
    a.c(0x0E6A, "...")
    a.c(0x0E6D, "Dead?")
    a.c(0x0E70, "...")
    a.c(0x0E72, "...")
    a.c(0x0E74, "Yes: reset them")
    a.c(0x0E77, "...and count them")
    a.c(0x0E7A, "Next hero")
    a.c(0x0E7B, "...")
    a.c(0x0E7D, "...")
    a.c(0x0E7F, "Any hero alive?")
    a.c(0x0E82, "...")
    a.c(0x0E84, "Yes: on to the next level")
    a.c(0x0E86, "All dead: VDU 28,0,24,16,0, a text window on the left...")
    a.c(0x0E9F, "...VDU 12 to clear it")
    a.c(0x0EA4, "Put spaces back over the four message bytes used as "
                "counters")
    a.c(0x0EA6, "...")
    a.c(0x0EA8, "...")
    a.c(0x0EAB, "...")
    a.c(0x0EAC, "...")
    a.c(0x0EAE, "Print game_over_message...")
    a.c(0x0EB1, "...")
    a.c(0x0EB4, "...")
    a.c(0x0EB5, "...up to its zero byte")
    a.c(0x0EB7, "...")
    a.c(0x0EB9, "Wait for the vertical sync counter to run out")
    a.c(0x0EBC, "...")
    a.c(0x0EBE, "Flush the input buffers")
    a.c(0x0EC0, "...")


def annotate_menu_tables(a: Annotator, base: int) -> None:
    """The per-hero table pair the menu and score code use: at &06F8 in the
    cassette lineage, moved to &08B0 in the official disc release, where
    page &04-&07 is reloaded for every level."""
    a.label(base, "hero_score_ten_thousands", length=4, group="game_state", description=(
        "Each hero's score ten-thousands digit as a small digit sprite "
        "(&69 for none, &6A-&72 for 1-9)."))
    a.label(base + 4, "hero_absent", length=4, group="game_state", description=(
        "Non-zero for each hero switched off on the menu."))


def annotate_level_file(a: Annotator) -> None:
    """The level file as loaded at &6B00, and the routines that use it."""
    g = dict(group="level_file")
    for addr, name, length, what in [
        (0x6B00, "level_object_x", 0x20, "Objects' map x (entries 1-30, entry 30 the exit)"),
        (0x6B20, "level_object_y", 0x20, "Objects' map y"),
        (0x6B40, "level_object_type", 0x20, "Objects' types"),
        (0x6B60, "level_door_x", 0x15, "Doors' map x (entries 1-20)"),
        (0x6B75, "level_door_y", 0x15, "Doors' map y"),
        (0x6B8A, "level_door_sprite", 0x16, "Doors' sprites"),
        (0x6BA0, "level_key_x", 0x15, "Keys' map x (entries 1-20)"),
        (0x6BB5, "level_key_y", 0x1B, "Keys' map y"),
        (0x6BD0, "level_trapdoor_x", 8, "Trapdoors' map x (entries 0-7)"),
        (0x6BD8, "level_trapdoor_y", 8, "Trapdoors' map y"),
        (0x6BE0, "level_walls", 0xD0, "Wall map (&C9 bytes used)"),
        (0x6CB0, "level_object_free_map", 0xD0, "Map of cells without objects (&C9 bytes used)"),
        (0x6D80, "level_wall_sprite", 0x30, "The level's wall block, copied to wall_sprite"),
    ]:
        a.label(addr, name, length=length, description=f"Level file: {what}.", **g)

    a.label(0x0F80, "hero_start_max_missiles", length=4, description=(
        "Starting hero_max_missiles for each hero: 3, 2, 1, 2."))
    a.label(0x0F84, "hero_start_missile_damage", length=4, description=(
        "Starting hero_missile_damage for each hero: 2, 3, 9, 5."))
    a.label(0x0F88, "hero_start_damage_taken", length=4, description=(
        "Starting hero_damage_taken for each hero: 7, 9, 6, 4 (armour "
        "ratings 3, 1, 4, 6)."))
    a.label(0x0F8C, "hero_faces", length=4, description=(
        "Sprite shown for each hero in the status panel."))
    for base in (0x0F80, 0x0F84, 0x0F88, 0x0F8C):
        a.byte(base, 4)
    a.banner(0x0F80, "Heroes' starting attributes",
             "Four tables of one byte per hero (Ranger, Magic-User, "
             "Barbarian, Fighter): missiles in flight, missile damage, "
             "health lost per hit, and the face sprite for the panel.")

    for addr, text in [
        (0x0ECF, "Starting missile limit..."), (0x0ED2, "..."),
        (0x0ED5, "...missile damage..."), (0x0ED8, "..."),
        (0x0EDB, "...and health lost per hit"), (0x0EDE, "..."),
        (0x0EE1, "Score 000..."), (0x0EE3, "..."), (0x0EE6, "..."), (0x0EE9, "..."),
        (0x0EEC, "...with the units one below 0, for draw_status_panel to "
                 "add a point"),
        (0x0EEE, "..."),
        (0x0EF1, "No ten-thousands digit"), (0x0EF3, "..."), (0x0EF6, "Return"),

        (0x0EF7, "For each hero..."), (0x0EF9, "..."),
        (0x0EFC, "..."),
        (0x0EFF, "Draw the health (from the template's 99+1)"),
        (0x0F02, "Draw the score (from its starting 000 and one below 0)"),
        (0x0F05, "Face, at column &45, row 0 of the section"),
        (0x0F08, "..."), (0x0F0A, "..."), (0x0F0C, "..."),
        (0x0F0F, "Shield, at column &4D, row 0"),
        (0x0F11, "..."), (0x0F13, "..."), (0x0F15, "..."),
        (0x0F18, "Armour rating 10 - health lost per hit, as a small "
                 "digit on the shield"),
        (0x0F1B, "..."), (0x0F1C, "..."), (0x0F1E, "..."),
        (0x0F21, "..."), (0x0F23, "..."), (0x0F25, "..."),
        (0x0F28, "One missile icon every three rows from row &10, for each "
                 "missile allowed..."),
        (0x0F2B, "..."), (0x0F2E, "..."), (0x0F2F, "..."), (0x0F30, "..."),
        (0x0F33, "..."), (0x0F35, "...(end row in count)"),
        (0x0F38, "..."), (0x0F3A, "..."), (0x0F3B, "..."),
        (0x0F3C, "...at column &4B"), (0x0F3E, "..."), (0x0F40, "..."),
        (0x0F43, "..."), (0x0F44, "..."), (0x0F45, "..."), (0x0F47, "..."),
        (0x0F48, "..."), (0x0F4B, "..."),
        (0x0F4D, "Missile damage, as a small digit at column &4C, row &0A"),
        (0x0F50, "..."), (0x0F53, "..."), (0x0F54, "..."),
        (0x0F56, "..."), (0x0F58, "..."), (0x0F5A, "..."),
        (0x0F5D, "Next hero"), (0x0F60, "..."), (0x0F63, "..."),
        (0x0F65, "..."), (0x0F67, "Return"),

        (0x0F68, "Column"), (0x0F6A, "Sprite"),
        (0x0F6C, "Row = Y + this hero's panel row - 14..."),
        (0x0F6D, "..."), (0x0F70, "..."),
        (0x0F71, "...(read from workspace_template, which page &0D copies)"),
        (0x0F74, "..."), (0x0F75, "..."), (0x0F77, "..."),
        (0x0F79, "Plot it"), (0x0F7C, "Return"),

        (0x14A0, "Copy workspace_template to page &0D"),
        (0x14A2, "..."), (0x14A5, "..."), (0x14A8, "..."), (0x14A9, "..."),
        (0x14AB, "Reset the exit and other per-level state"),
        (0x14B9, "First monster emerges from trapdoor 0"),
        (0x14D6, "Return"),

        (0x14D7, "Restore the MOS's own WRCHV for the PLOT commands..."),
        (0x14DA, "..."), (0x14DD, "..."), (0x14E0, "..."),
        (0x14E3, "Twenty PLOT commands"),
        (0x14E5, "VDU 25..."), (0x14E7, "..."),
        (0x14EA, "...then the five bytes of the command"),
        (0x14EC, "..."), (0x14EE, "..."), (0x14F1, "..."), (0x14F2, "..."),
        (0x14F4, "..."),
        (0x14F6, "Next command"), (0x14F7, "..."), (0x14F9, "..."),
        (0x14FB, "..."), (0x14FD, "..."),
        (0x14FF, "..."), (0x1500, "..."),
        (0x1502, "Draw the four views"),
        (0x1505, "Point WRCHV back at wrch_handler..."),
        (0x1507, "..."), (0x150A, "..."), (0x150C, "..."), (0x150F, "Return"),

        (0x1510, "Objects 30 to 1: position and type"),
        (0x1524, "..."), (0x1525, "..."),
        (0x1527, "Doors 20 to 1: position and sprite"),
        (0x153B, "..."), (0x153C, "..."),
        (0x153E, "Keys 20 to 1: position"),
        (0x154C, "..."), (0x154D, "..."),
        (0x154F, "Trapdoors 0 to 7: position"),
        (0x155D, "..."), (0x155E, "..."), (0x1560, "..."),
        (0x1562, "Wall map and object-free map, &C9 bytes each"),
        (0x1570, "..."), (0x1571, "..."), (0x1573, "..."),
        (0x1575, "The level's wall sprite, &30 bytes"),
        (0x157D, "..."), (0x157E, "..."), (0x1580, "..."), (0x1582, "Return"),

        (0x1583, "Monsters 30 to 1..."),
        (0x1585, "...dying, so that they emerge from the trapdoors..."),
        (0x1587, "..."),
        (0x158A, "...off the map..."), (0x158C, "..."),
        (0x158F, "...with this level's hit points"), (0x1592, "..."),
        (0x1595, "..."), (0x1596, "..."),
        (0x1598, "For each hero: clear the returning queue, the key carried "
                 "and the door-check position"),
        (0x15AB, "..."), (0x15AC, "..."), (0x15AE, "..."), (0x15B0, "Return"),
    ]:
        a.c(addr, text)


def annotate_core_comments(a: Annotator) -> None:
    """Inline comments for the core primitives."""
    C = a.c
    # plot_at_cell
    for addr, text in [
        (0x7852, "Room = (cell_y AND &F8) x 4 + (cell_x AND &F8)..."),
        (0x7855, "..."), (0x7857, "..."), (0x785A, "..."), (0x785B, "..."),
        (0x785E, "..."), (0x7861, "..."), (0x7864, "..."),
        (0x7867, "..."), (0x786A, "..."), (0x786C, "..."),
        (0x786F, "...in cell_room"),
        (0x7872, "Column within the view = (cell_x AND 7) x 4 + offset_x"),
        (0x7875, "..."), (0x7877, "..."), (0x7878, "..."), (0x7879, "..."),
        (0x787A, "..."), (0x787C, "..."),
        (0x787F, "Row within the view = (cell_y AND 7) x 12 + offset_y"),
        (0x7882, "..."), (0x7884, "..."), (0x7885, "..."), (0x7886, "..."),
        (0x7889, "..."), (0x788A, "..."), (0x788B, "..."), (0x788E, "..."),
        (0x7890, "..."),
        (0x7893, "Does the top-left view show this room?"),
        (0x7896, "..."), (0x7899, "No"),
        (0x789B, "Yes: plot at column 1, row 1 of the screen, plus the "
                 "position in the room"),
        (0x789C, "..."), (0x789E, "..."), (0x78A1, "..."), (0x78A3, "..."),
        (0x78A5, "..."), (0x78A8, "..."), (0x78AA, "..."),
        (0x78AD, "Does the top-right view show it?"),
        (0x78B0, "..."), (0x78B3, "No"),
        (0x78B5, "Yes: plot at column &23, row 1"),
        (0x78C7, "Does the bottom-left view show it?"),
        (0x78CA, "..."), (0x78CD, "No"),
        (0x78CF, "Yes: plot at column 1, row &67"),
        (0x78E1, "Does the bottom-right view show it?"),
        (0x78E4, "..."), (0x78E7, "No"),
        (0x78E9, "Yes: plot at column &23, row &67"),
        (0x78FB, "Return"),
        # test_wall
        (0x78FC, "Room offset = (cell_y AND &F8) x 4 + (cell_x AND &F8)..."),
        (0x790E, "...low byte of the pointer"),
        (0x7919, "...into room_walls at &0C00"),
        (0x791B, "..."),
        (0x791D, "Bit for the column within the room"),
        (0x7920, "..."), (0x7922, "..."), (0x7923, "..."), (0x7926, "..."),
        (0x7929, "Byte for the row within the room"),
        (0x792C, "..."), (0x792E, "..."),
        (0x792F, "Isolate the cell's bit..."),
        (0x7931, "..."),
        (0x7934, "...keep it in &8F..."),
        (0x7936, "...and Y"),
        (0x7937, "Return"),
        # test_object_free
        (0x7938, "Room offset = (cell_y AND &F8) x 4 + (cell_x AND &F8)..."),
        (0x794A, "...low byte of the pointer"),
        (0x7955, "...into object_free_map at &2100"),
        (0x7957, "..."),
        (0x7959, "Bit for the column within the room"),
        (0x7965, "Byte for the row within the room"),
        (0x796B, "Isolate the cell's bit..."),
        (0x7970, "...keep it in &8F..."),
        (0x7972, "...and Y"),
        (0x7973, "Return"),
        # find_creature
        (0x7974, "Monsters 30 to 1..."),
        (0x7976, "...except the one being moved"),
        (0x7979, "..."),
        (0x797B, "At cell_x..."), (0x797E, "..."), (0x7981, "..."),
        (0x7983, "...and cell_y?"), (0x7986, "..."), (0x7989, "..."),
        (0x798B, "Yes: return with Y and A non-zero"),
        (0x798C, "..."),
        (0x798D, "Next monster"), (0x798E, "..."),
        (0x7990, "No monster. Check for heroes too?"),
        (0x7993, "No: return 0"),
        (0x7995, "For each hero..."),
        (0x7997, "...at cell_x..."), (0x799A, "..."), (0x799D, "..."),
        (0x799F, "...and cell_y?"), (0x79A2, "..."), (0x79A5, "..."),
        (0x79A7, "Yes: take hero_damage_taken health points"),
        (0x79AA, "..."), (0x79AB, "..."), (0x79AC, "..."), (0x79AF, "..."),
        (0x79B0, "..."), (0x79B1, "..."), (0x79B2, "..."),
        (0x79B4, "Return A = 1: a hero was there"),
        (0x79B6, "..."),
        (0x79B7, "Next hero"), (0x79B8, "..."), (0x79BA, "..."),
        (0x79BC, "Nothing there: return A = Y = 0"),
        (0x79BE, "..."), (0x79C0, "..."),
        # lose_health_point
        (0x7221, "Is the hero in play?"),
        (0x7224, "Yes"),
        (0x7226, "No: return"),
        (0x7227, "Take one from the units digit"),
        (0x722A, "..."),
        (0x722D, "Below 0?"),
        (0x722F, "No: redraw"),
        (0x7231, "Yes: units 9..."),
        (0x7233, "..."),
        (0x7236, "...and take one from the tens"),
        (0x7239, "..."),
        (0x723C, "Below 0: the hero has died"),
        (0x723E, "No: redraw"),
        (0x7240, "Erase the hero..."),
        (0x7242, "..."),
        (0x7244, "..."),
        (0x7247, "...take them out of play..."),
        (0x7249, "..."),
        (0x724C, "...and start the death animation: step +1 through "
                 "hero_appearance_sprites, every other frame"),
        (0x724E, "..."), (0x7251, "..."),
        (0x7254, "Add hero number + 1 at the end of returning_hero_queue"),
        (0x7256, "..."), (0x7259, "..."), (0x725B, "..."), (0x725C, "..."),
        (0x725D, "..."), (0x725F, "..."), (0x7262, "Return"),
        (0x7263, "..."), (0x7264, "..."),
        (0x7266, "Draw the health: tens digit at column &45..."),
        (0x7269, "..."), (0x726B, "..."), (0x726D, "..."), (0x726F, "..."),
        (0x7272, "..."), (0x7274, "..."), (0x7275, "..."), (0x7276, "..."),
        (0x7279, "..."), (0x727A, "..."),
        (0x727B, "...units digit at column &48"),
        (0x727E, "..."), (0x7280, "..."), (0x7282, "..."), (0x7284, "..."),
        (0x7285, "..."), (0x7286, "..."), (0x7289, "..."), (0x728A, "..."),
        (0x728B, "Return"),
        # add_point, add_ten_points
        (0x728C, "Add one to the units digit"),
        (0x728F, "..."), (0x7292, "Past 9?"), (0x7294, "No: redraw"),
        (0x7296, "Yes: units 0, and carry into the tens"),
        (0x7298, "..."),
        (0x729B, "Add one to the tens digit"),
        (0x729E, "..."), (0x72A1, "Past 9?"), (0x72A3, "No: redraw"),
        (0x72A5, "Yes: tens 0..."), (0x72A7, "..."),
        (0x72AA, "...and add one to the hundreds"),
        (0x72AD, "..."), (0x72B0, "Past 9?"), (0x72B2, "No: redraw"),
        (0x72B4, "Yes: hundreds 0..."), (0x72B6, "..."),
        (0x72B9, "...and add a thousand"),
        (0x72BC, "Draw the score twelve rows below the health: thousands "
                 "at column &45..."),
        (0x72D4, "...hundreds at &48..."),
        (0x72E4, "...tens at &4B..."),
        (0x72F4, "...units at &4E"),
        (0x7304, "Return"),
        # test_key
        (0x7C95, "Key number to X, keeping X on the stack"),
        (0x7C96, "..."), (0x7C97, "..."), (0x7C98, "..."), (0x7C99, "..."),
        (0x7C9A, "OSBYTE &81 with Y = &FF: scan the key"),
        (0x7C9C, "..."), (0x7C9E, "..."),
        (0x7CA1, "X = Y = &FF if it is pressed"),
        (0x7CA3, "..."), (0x7CA5, "..."), (0x7CA7, "..."),
        (0x7CA9, "Pressed: restore X and return A = 0, Z set"),
        (0x7CAA, "..."), (0x7CAB, "..."), (0x7CAD, "..."),
        (0x7CAE, "Not pressed: restore X and return A = 1"),
        (0x7CAF, "..."), (0x7CB0, "..."), (0x7CB2, "..."),
        # draw_hero, get_hero_cell
        (0x7732, "Hero's cell"),
        (0x7735, "...and pixel offsets"),
        (0x7738, "..."), (0x773A, "..."), (0x773D, "..."),
        (0x773F, "Plot in every view showing it, preserving X"),
        (0x7740, "..."), (0x7741, "..."), (0x7744, "..."), (0x7745, "..."),
        (0x7746, "Return"),
        (0x777A, "cell_x = hero_x"), (0x777D, "..."),
        (0x7780, "cell_y = hero_y"), (0x7783, "..."), (0x7786, "Return"),
        # draw views
        (0x7795, "Top-left view: row 1..."), (0x7797, "..."),
        (0x7799, "...column 1..."), (0x779B, "..."),
        (0x779E, "...hero 0's room"), (0x77A1, "..."),
        (0x77A3, "Draw it"), (0x77A6, "Return"),
        (0x77A7, "Top-right view: row 1..."), (0x77AB, "...column &23..."),
        (0x77B0, "...hero 1's room"), (0x77B5, "Draw it"), (0x77B8, "Return"),
        (0x77B9, "Bottom-left view: row &67..."), (0x77BD, "...column 1..."),
        (0x77C2, "...hero 2's room"), (0x77C7, "Draw it"), (0x77CA, "Return"),
        (0x77CB, "Bottom-right view: row &67..."), (0x77CF, "...column &23..."),
        (0x77D4, "...hero 3's room"), (0x77D9, "Draw it"), (0x77DC, "Return"),
        (0x77DE, "The room's walls are in page &0C"),
        (0x77E0, "..."),
        (0x77E2, "For each of the eight rows..."),
        (0x77E4, "...take its eight wall bits..."),
        (0x77E6, "..."), (0x77E9, "..."), (0x77EA, "..."),
        (0x77EB, "...and draw them"),
        (0x77EE, "Twelve pixel rows down"),
        (0x77EF, "..."), (0x77F1, "..."), (0x77F3, "..."),
        (0x77F5, "..."), (0x77F6, "..."), (0x77F7, "..."), (0x77F8, "..."),
        (0x77FA, "..."),
        (0x77FC, "Then the doors 20 to 1, in every view showing them"),
        (0x781C, "..."), (0x781D, "..."), (0x781F, "Return"),
        (0x7820, "Start at the room's left edge"),
        (0x7823, "..."),
        (0x7825, "Bit mask, starting with the leftmost cell"),
        (0x7827, "..."), (0x7828, "..."), (0x7829, "..."),
        (0x782C, "Wall here?"), (0x782F, "..."),
        (0x7832, "No: plot the blank"),
        (0x7834, "Yes: plot the wall block (sprite 0)"),
        (0x7836, "..."), (0x7838, "..."), (0x783B, "..."),
        (0x783E, "Plot the blank (sprite &15)"),
        (0x7840, "..."), (0x7842, "..."),
        (0x7845, "Four byte columns right"),
        (0x7846, "..."), (0x7848, "..."), (0x784A, "..."),
        (0x784C, "Next bit..."), (0x784D, "..."), (0x784E, "..."),
        (0x784F, "...until all eight are done"),
        (0x7851, "Return"),
    ]:
        C(addr, text)


# ---------------------------------------------------------------------------
# Sprites: (number, name, data address, width in bytes, height in rows), as
# held in the sprite tables when the game starts. The exit animation and the
# victory sequence change some entries and data while the game runs, and
# each level replaces the wall sprite's data.

SPRITES = [
    (0x00, "wall", 0x2D00, 4, 12),
    (0x01, "ranger_up_0", 0x2D30, 4, 12),
    (0x02, "ranger_up_1", 0x2D60, 4, 12),
    (0x03, "ranger_right_0", 0x2D90, 4, 12),
    (0x04, "ranger_right_1", 0x2DC0, 4, 12),
    (0x05, "ranger_down_0", 0x2DF0, 4, 12),
    (0x06, "ranger_down_1", 0x2E20, 4, 12),
    (0x07, "ranger_left_0", 0x2E50, 4, 12),
    (0x08, "ranger_left_1", 0x19C0, 4, 12),
    (0x09, "monster_up_0", 0x2E80, 4, 12),
    (0x0A, "monster_up_1", 0x2EB0, 4, 12),
    (0x0B, "monster_right_0", 0x2EE0, 4, 12),
    (0x0C, "monster_right_1", 0x2F10, 4, 12),
    (0x0D, "monster_down_0", 0x2F40, 4, 12),
    (0x0E, "monster_down_1", 0x2F70, 4, 12),
    (0x0F, "monster_left_0", 0x2FA0, 4, 12),
    (0x10, "monster_left_1", 0x2FD0, 4, 12),
    (0x11, "arrow_up", 0x2C00, 4, 12),
    (0x12, "arrow_right", 0x2C30, 4, 12),
    (0x13, "arrow_down", 0x2C60, 4, 12),
    (0x14, "arrow_left", 0x2C90, 4, 12),
    (0x15, "blank", 0x04CF, 4, 12),
    (0x16, "sparkle_0", 0x2B00, 4, 12),
    (0x17, "sparkle_1", 0x2B30, 4, 12),
    (0x18, "sparkle_2", 0x2B60, 4, 12),
    (0x19, "sparkle_3", 0x2B90, 4, 12),
    (0x1A, "blank_key_icon", 0x04CF, 2, 3),
    (0x1B, "key", 0x2900, 4, 12),
    (0x1C, "door_vertical", 0x2CC0, 4, 12),
    (0x1D, "door_horizontal", 0x2AC8, 4, 12),
    (0x1E, "digit_0", 0x2A00, 2, 10),
    (0x1F, "digit_1", 0x2A14, 2, 10),
    (0x20, "digit_2", 0x2A28, 2, 10),
    (0x21, "digit_3", 0x2A3C, 2, 10),
    (0x22, "digit_4", 0x2A50, 2, 10),
    (0x23, "digit_5", 0x2A64, 2, 10),
    (0x24, "digit_6", 0x2A78, 2, 10),
    (0x25, "digit_7", 0x2A8C, 2, 10),
    (0x26, "digit_8", 0x2AA0, 2, 10),
    (0x27, "digit_9", 0x2AB4, 2, 10),
    (0x28, "treasure", 0x2930, 4, 12),
    (0x29, "food", 0x2960, 4, 12),
    (0x2A, "cross", 0x0AF0, 4, 12),
    (0x2B, "teleporter", 0x29C0, 4, 12),
    (0x2C, "trapdoor", 0x2BC0, 4, 12),
    (0x2D, "magic_user_up_0", 0x2300, 4, 12),
    (0x2E, "magic_user_up_1", 0x2330, 4, 12),
    (0x2F, "magic_user_right_0", 0x2360, 4, 12),
    (0x30, "magic_user_right_1", 0x2390, 4, 12),
    (0x31, "magic_user_down_0", 0x23C0, 4, 12),
    (0x32, "magic_user_down_1", 0x23F0, 4, 12),
    (0x33, "magic_user_left_0", 0x2420, 4, 12),
    (0x34, "magic_user_left_1", 0x2450, 4, 12),
    (0x35, "barbarian_up_0", 0x2480, 4, 12),
    (0x36, "barbarian_up_1", 0x24B0, 4, 12),
    (0x37, "barbarian_right_0", 0x24E0, 4, 12),
    (0x38, "barbarian_right_1", 0x2510, 4, 12),
    (0x39, "barbarian_down_0", 0x2540, 4, 12),
    (0x3A, "barbarian_down_1", 0x2570, 4, 12),
    (0x3B, "barbarian_left_0", 0x25A0, 4, 12),
    (0x3C, "barbarian_left_1", 0x25D0, 4, 12),
    (0x3D, "fighter_up_0", 0x2600, 4, 12),
    (0x3E, "fighter_up_1", 0x2630, 4, 12),
    (0x3F, "fighter_right_0", 0x2660, 4, 12),
    (0x40, "fighter_right_1", 0x2690, 4, 12),
    (0x41, "fighter_down_0", 0x26C0, 4, 12),
    (0x42, "fighter_down_1", 0x26F0, 4, 12),
    (0x43, "fighter_left_0", 0x2720, 4, 12),
    (0x44, "fighter_left_1", 0x2750, 4, 12),
    (0x45, "fireball_up", 0x2780, 4, 12),
    (0x46, "fireball_right", 0x27B0, 4, 12),
    (0x47, "fireball_down", 0x27E0, 4, 12),
    (0x48, "fireball_left", 0x2810, 4, 12),
    (0x49, "sword_up", 0x1700, 4, 12),
    (0x4A, "sword_right", 0x1730, 4, 12),
    (0x4B, "sword_down", 0x1760, 4, 12),
    (0x4C, "sword_left", 0x1790, 4, 12),
    (0x4D, "axe_up", 0x2840, 4, 12),
    (0x4E, "axe_right", 0x2870, 4, 12),
    (0x4F, "axe_down", 0x28A0, 4, 12),
    (0x50, "axe_left", 0x28D0, 4, 12),
    (0x51, "exit", 0x22A0, 4, 12),
    (0x52, "key_icon", 0x22D0, 2, 3),
    (0x53, "drainer_0", 0x21D0, 4, 12),
    (0x54, "drainer_1", 0x21D0, 4, 12),
    (0x55, "drainer_2", 0x21D0, 4, 12),
    (0x56, "drainer_3", 0x21D0, 4, 12),
    (0x57, "drainer_4", 0x21D0, 4, 12),
    (0x58, "drainer_5", 0x21D0, 4, 12),
    (0x59, "drainer_6", 0x21D0, 4, 12),
    (0x5A, "drainer_7", 0x21D0, 4, 12),
    (0x5B, "drainer_8", 0x21D0, 4, 12),
    (0x5C, "drainer_9", 0x21D0, 4, 12),
    (0x5D, "drainer_10", 0x21D0, 4, 12),
    (0x5E, "drainer_11", 0x21D0, 4, 12),
    (0x5F, "boots", 0x0A00, 4, 12),
    (0x60, "helmet", 0x0A30, 4, 12),
    (0x61, "potion", 0x0A60, 4, 12),
    (0x62, "weapons", 0x0AC0, 4, 12),
    (0x63, "magic_sword", 0x0A90, 4, 12),
    (0x64, "skull_0", 0x19F0, 4, 12),
    (0x65, "skull_1", 0x1A20, 4, 12),
    (0x66, "skull_2", 0x1A50, 4, 12),
    (0x67, "skull_3", 0x1A80, 4, 12),
    (0x68, "skull_4", 0x1AB0, 4, 12),
    (0x69, "shield", 0x1800, 3, 12),
    (0x6A, "small_digit_1", 0x1824, 1, 5),
    (0x6B, "small_digit_2", 0x1829, 1, 5),
    (0x6C, "small_digit_3", 0x182E, 1, 5),
    (0x6D, "small_digit_4", 0x1833, 1, 5),
    (0x6E, "small_digit_5", 0x1838, 1, 5),
    (0x6F, "small_digit_6", 0x183D, 1, 5),
    (0x70, "small_digit_7", 0x1842, 1, 5),
    (0x71, "small_digit_8", 0x1847, 1, 5),
    (0x72, "small_digit_9", 0x184C, 1, 5),
    (0x73, "chalice", 0x1210, 8, 24),
    (0x74, "missile_icon", 0x1860, 4, 3),
    (0x75, "boots_icon", 0x186C, 2, 6),
    (0x76, "level_word", 0x1878, 12, 8),
    (0x77, "blank_boots_icon", 0x04CF, 2, 6),
]


def annotate_sprites(a: Annotator) -> None:
    declared = {}
    for number, name, addr, width, height in SPRITES:
        size = width * height
        if addr in declared:
            continue
        sharing = [n for n, _, ad, _, _ in SPRITES if ad == addr]
        label = "wall_sprite" if addr == 0x2D00 else (
            "sprite_drainer" if name.startswith("drainer") else (
                "sprite_blank" if addr == 0x04CF else "sprite_" + name))
        size = max(w * h for n, _, ad, w, h in SPRITES if ad == addr)
        declared[addr] = size
        numbers = ", ".join(f"&{n:02X}" for n in sharing)
        if addr != 0x2D00:
            a.label(addr, label, length=size, group="sprites", description=(
                f"Data of sprite {numbers}: {width} bytes x {height} rows."))
        a.byte(addr, size, cols=width)


MENU_STRINGS = [
    (0x0600, 7), (0x060A, 4), (0x0611, 7), (0x061B, 8), (0x0626, 12),
    (0x0635, 11), (0x0643, 9), (0x064F, 3), (0x0655, 3), (0x065B, 3),
    (0x0661, 3), (0x0667, 11), (0x0675, 9), (0x0681, 18), (0x0696, 3),
    (0x069C, 13),
]

SOUND_BLOCKS = [
    # (address, name, is_envelope, use)
    (0x1900, "magic_envelope", True, "casting magic"),
    (0x190E, "magic_sound", False, "casting magic"),
    (0x1916, "treasure_envelope", True, "collecting treasure"),
    (0x1924, "treasure_sound", False, "collecting treasure"),
    (0x192C, "pickup_envelope", True, "collecting an item"),
    (0x193A, "pickup_sound", False, "collecting an item"),
    (0x1942, "key_envelope", True, "picking up a key"),
    (0x1950, "key_sound", False, "picking up a key"),
    (0x1958, "exit_envelope", True, "a hero going down the exit"),
    (0x1966, "exit_sound", False, "a hero going down the exit"),
    (0x0BF0, "teleport_sound", False, "teleporting"),
    (0x0BF8, "food_sound", False, "eating food, and (with its pitch changed) "
                                  "opening a door"),
    (0x0CF0, "hit_sound", False, "a monster hit, and (louder) touching an "
                                 "energy drainer"),
]


def annotate_data(a: Annotator) -> None:
    # Menu text
    a.label(0x0600, "menu_text", group="text", description=(
        "The hero menu: sixteen strings, each a text column and row followed "
        "by the characters and a carriage return. The YES/NO and ON/OFF "
        "entries are rewritten as the players toggle them."))
    a.banner(0x0600, "Hero menu text",
             "Sixteen entries of: column, row, text, carriage return; printed "
             "by print_menu.")
    for addr, length in MENU_STRINGS:
        a.byte(addr, 2)
        a.string(addr + 2, length)
        a.byte(addr + 2 + length, 1)

    # The game-over message
    a.banner(0x0F90, "Game-over message",
             "Eleven lines of seventeen characters, each ended by a carriage "
             "return, then a line feed and a last line ended by a zero byte. "
             "Two bytes of it (&0FF1, &0FF2) double as counters, and are "
             "overwritten with spaces before printing, so the full stop after "
             "\"YOU ALL\" never appears.")
    addr = 0x0F90
    for _ in range(11):
        a.string(addr, 17)
        a.byte(addr + 17, 1)
        addr += 18
    a.byte(addr, 1)
    a.string(addr + 1, 17)
    a.byte(addr + 18, 1)

    # Sound blocks
    for addr, name, is_envelope, use in SOUND_BLOCKS:
        kind = "OSWORD 8 (ENVELOPE)" if is_envelope else "OSWORD 7 (SOUND)"
        length = 14 if is_envelope else 8
        a.label(addr, name, length=length, group="sound", description=(
            f"{kind} parameter block for {use}."))
        a.byte(addr, length, cols=length if is_envelope else 2)

    # Sprite tables
    for addr in (0x1AE0, 0x1B58, 0x1BD0, 0x1C48):
        a.byte(addr, 120, cols=8)
    a.banner(0x1AE0, "Sprite tables",
             "Four tables of 120 entries, indexed by sprite number: data "
             "address low bytes, high bytes, widths in bytes and heights in "
             "rows.")

    # Workspace template
    a.banner(0x7D00, "Workspace template",
             "The starting contents of page &0D for each level, copied there "
             "by reset_workspace: the heroes' starting positions, directions, "
             "keys (hero_key_up etc. at +&70), health of 99 + 1 (at +&90, "
             "+&95), the views' rooms (+&A0), sprite bases (+&B0, +&B5), bit "
             "masks (+&C0) and panel rows (+&D0).")


def annotate_hero_comments(a: Annotator) -> None:
    a.label(0x6EC1, "read_hero_keys")
    a.label(0x6F18, "fire_missile")
    a.label(0x6F79, "step_hero")
    a.label(0x7075, "erase_hero")
    a.label(0x7096, "draw_moved_hero")
    a.label(0x70C1, "next_hero")
    a.label(0x7619, "check_magic")
    for addr, text in [
        (0x6E80, "For each hero..."),
        (0x6E82, "In play?"),
        (0x6E85, "Yes"),
        (0x6E87, "Out of play: never playing (step &63)?"),
        (0x6E8A, "..."), (0x6E8C, "..."),
        (0x6E8E, "Yes: nothing to do"),
        (0x6E91, "No: dying or returning, so animate them"),
        (0x6E94, "..."),
        (0x6E97, "Remember the hero's position and offsets before moving"),
        (0x6E9A, "..."), (0x6E9D, "..."), (0x6EA0, "..."), (0x6EA3, "..."),
        (0x6EA6, "..."), (0x6EA9, "..."), (0x6EAC, "..."),
        (0x6EAF, "Part way through a step?"),
        (0x6EB2, "No: read the keys"),
        (0x6EB4, "Yes: continue it..."),
        (0x6EB7, "...and redraw"),
        (0x6EBA, "Heroes 0 and 1 check their magic key first"),
        (0x6EBC, "..."), (0x6EBE, "..."),
        (0x6EC1, "Up key?"), (0x6EC4, "..."), (0x6EC7, "No"),
        (0x6EC9, "Yes: face up..."), (0x6ECB, "..."),
        (0x6ECE, "...start the step..."), (0x6ED1, "...and move"),
        (0x6ED4, "Down key?"), (0x6ED7, "..."), (0x6EDA, "No"),
        (0x6EDC, "Yes: face down..."), (0x6EDE, "..."),
        (0x6EE1, "...start the step..."), (0x6EE4, "...and move"),
        (0x6EE7, "Right key?"), (0x6EEA, "..."), (0x6EED, "No"),
        (0x6EEF, "Yes: face right..."), (0x6EF1, "..."),
        (0x6EF4, "...start the step..."), (0x6EF7, "...and move"),
        (0x6EFA, "Left key?"), (0x6EFD, "..."), (0x6F00, "No"),
        (0x6F02, "Yes: face left..."), (0x6F04, "..."),
        (0x6F07, "...start the step..."), (0x6F0A, "...and move"),
        (0x6F0D, "Fire key?"), (0x6F10, "..."), (0x6F13, "Yes"),
        (0x6F15, "No key: just redraw the hero"),
        (0x6F18, "This hero's missile slots are 3x to 3x + "
                 "hero_max_missiles - 1"),
        (0x6F19, "..."), (0x6F1C, "..."), (0x6F1D, "..."), (0x6F1E, "..."),
        (0x6F21, "..."), (0x6F22, "..."), (0x6F25, "...end of the range"),
        (0x6F28, "Slot free?"), (0x6F2B, "No: try the next"),
        (0x6F2D, "Missile direction = (hero direction + 1) / 2, so 1-4, "
                 "with bit 7 marking it just fired"),
        (0x6F30, "..."), (0x6F31, "..."), (0x6F33, "..."), (0x6F34, "..."),
        (0x6F36, "..."),
        (0x6F39, "It starts at the hero's cell"),
        (0x6F3C, "..."), (0x6F3F, "..."), (0x6F42, "..."),
        (0x6F45, "Sound the bell"),
        (0x6F47, "..."),
        (0x6F4A, "The missile carries the hero's missile damage..."),
        (0x6F4D, "..."),
        (0x6F50, "...and sprites"),
        (0x6F53, "..."),
        (0x6F56, "The hero stays where they were"),
        (0x6F59, "..."), (0x6F5C, "..."), (0x6F5F, "..."),
        (0x6F62, "Toggle the hero's frame"),
        (0x6F65, "..."), (0x6F67, "..."),
        (0x6F6A, "Redraw the hero"),
        (0x6F70, "Next slot"), (0x6F71, "..."), (0x6F74, "..."),
        (0x6F76, "All in flight: just redraw the hero"),
        (0x6F79, "Move the hero's cell in the direction faced: up..."),
        (0x6F7C, "..."), (0x6F7E, "..."), (0x6F80, "..."),
        (0x6F83, "...right..."), (0x6F85, "..."), (0x6F87, "..."),
        (0x6F8A, "...down..."), (0x6F8C, "..."), (0x6F8E, "..."),
        (0x6F91, "...left"), (0x6F93, "..."), (0x6F95, "..."),
        (0x6F98, "Note the new cell for the door and key checks"),
        (0x6F9B, "..."), (0x6F9E, "..."), (0x6FA1, "..."),
        (0x6FA4, "Is there a wall in the new cell?"),
        (0x6FA7, "..."), (0x6FAA, "..."), (0x6FAD, "..."), (0x6FB0, "..."),
        (0x6FB1, "..."), (0x6FB2, "..."), (0x6FB5, "..."), (0x6FB6, "..."),
        (0x6FB7, "..."),
        (0x6FB9, "No"),
        (0x6FBB, "Yes: stay put..."),
        (0x6FBE, "..."), (0x6FC1, "..."), (0x6FC4, "..."),
        (0x6FC7, "Cancel the step"),
        (0x6FC9, "..."), (0x6FCC, "..."), (0x6FCF, "..."),
        (0x6FD2, "...and redraw"),
        (0x6FD5, "Is there a monster in the new cell?"),
        (0x6FD7, "..."), (0x6FDA, "..."), (0x6FDB, "..."), (0x6FDC, "..."),
        (0x6FDF, "..."), (0x6FE0, "..."), (0x6FE1, "..."),
        (0x6FE3, "No"),
        (0x6FE5, "Yes: stay put, cancel the step..."),
        (0x6FFC, "...and lose a health point for bumping into it"),
        (0x6FFF, "Redraw"),
        (0x7002, "Is another hero in play in the new cell?"),
        (0x7005, "..."), (0x7007, "Not this hero"), (0x700A, "..."),
        (0x700C, "..."), (0x700F, "..."), (0x7012, "..."), (0x7014, "..."),
        (0x7017, "..."), (0x701A, "..."), (0x701C, "..."), (0x701F, "..."),
        (0x7021, "Yes: stay put, cancel the step and redraw"),
        (0x703B, "Next hero"), (0x703C, "..."), (0x703E, "..."),
        (0x7040, "Has the hero moved into another room?"),
        (0x7041, "..."), (0x7042, "..."), (0x7043, "..."), (0x7046, "..."),
        (0x7048, "No"),
        (0x704A, "Yes: change this hero's view to the new room..."),
        (0x704B, "..."), (0x704C, "..."), (0x704D, "..."),
        (0x7050, "...and cancel the step"),
        (0x7053, "Same room. Wearing Boots of Speed?"),
        (0x7054, "..."), (0x7055, "..."), (0x7056, "..."),
        (0x7059, "No"),
        (0x705B, "Yes: arrive in the cell at once, with no step"),
        (0x705D, "..."), (0x7060, "..."), (0x7063, "..."), (0x7066, "..."),
        (0x7069, "No boots: stay in the old cell for now; "
                 "continue_hero_step moves on at the end of the step"),
        (0x706C, "..."), (0x706F, "..."), (0x7072, "..."),
        (0x7075, "Erase the hero at the old position (blank sprite)"),
        (0x7077, "..."), (0x7079, "..."), (0x707C, "..."), (0x707F, "..."),
        (0x7082, "..."), (0x7085, "..."), (0x7088, "..."), (0x708A, "..."),
        (0x708D, "..."), (0x708F, "..."), (0x7090, "..."), (0x7091, "..."),
        (0x7094, "..."), (0x7095, "..."),
        (0x7096, "Still in play?"),
        (0x7097, "..."), (0x709A, "No"),
        (0x709C, "Sprite = direction + frame + the hero's sprite base"),
        (0x709F, "..."), (0x70A2, "..."),
        (0x70A4, "Draw the hero"),
        (0x70A7, "Can the hero's cell hold an object?"),
        (0x70AA, "..."), (0x70AD, "..."), (0x70B0, "..."), (0x70B3, "..."),
        (0x70B4, "..."), (0x70B5, "..."), (0x70B8, "..."), (0x70B9, "..."),
        (0x70BA, "..."),
        (0x70BC, "No"),
        (0x70BE, "Yes: pick up whatever is there"),
        (0x70C1, "Next hero"), (0x70C2, "..."), (0x70C4, "..."),
        (0x70C6, "..."), (0x70C9, "Return"),

        (0x7619, "Count down the magic key delay"),
        (0x761C, "..."),
        (0x761E, "Not yet: return, which leaves move_heroes for this frame"),
        (0x761F, "Check the key every frame from now on"),
        (0x7621, "..."),
        (0x7624, "Magic key pressed?"),
        (0x7627, "..."),
        (0x762A, "No: carry on reading the keys"),
        (0x762C, "Yes: play the magic sound"),
        (0x7642, "Ignore the key for the next three frames"),
        (0x7644, "..."),
        (0x7647, "Health cost: 3 for the Magic-User..."),
        (0x7649, "..."),
        (0x764B, "...6 for the Ranger"),
        (0x7650, "..."),
        (0x7652, "Take the cost"),
        (0x7653, "..."), (0x7654, "..."), (0x7657, "..."), (0x7658, "..."),
        (0x7659, "..."), (0x765A, "..."),
        (0x765C, "No monsters killed yet"),
        (0x765E, "..."),
        (0x7661, "sprite_number = 2 x hero, an index into view_room"),
        (0x7662, "..."), (0x7663, "..."),
        (0x7665, "For each monster..."),
        (0x7667, "...find its room"),
        (0x766A, "..."), (0x766D, "..."), (0x7670, "..."), (0x7673, "..."),
        (0x7674, "..."), (0x7675, "..."), (0x7678, "..."), (0x7679, "..."),
        (0x767A, "In the room this hero's view shows?"),
        (0x767C, "..."), (0x767F, "..."), (0x7681, "No"),
        (0x7683, "Alive?"), (0x7686, "..."), (0x7688, "No"),
        (0x768A, "Yes: start it dying..."), (0x768C, "..."),
        (0x768F, "...and count it"),
        (0x7692, "Next monster"), (0x7693, "..."),
        (0x7695, "One point for each monster killed"),
        (0x7697, "..."), (0x7698, "..."), (0x7699, "..."), (0x769C, "..."),
        (0x769E, "..."), (0x76A0, "..."), (0x76A1, "..."), (0x76A2, "..."),
        (0x76A5, "..."), (0x76A6, "..."), (0x76A7, "..."), (0x76A8, "..."),
        (0x76AB, "No magic: carry on with the keys"),
        (0x76AE, "Magic cast: redraw the hero"),
    ]:
        a.c(addr, text)


def annotate_play_loop(a: Annotator) -> None:
    for addr, name, description in [
        (0x09F0, "exit_saved_x", "The exit's map x, kept while a hero goes down it."),
        (0x09F1, "exit_saved_y", "The exit's map y, kept while a hero goes down it."),
        (0x09F2, "exit_busy", "Non-zero while a hero is going down the exit."),
        (0x09F3, "exit_spin", "Direction (1, 3, 5, 7) of the hero spinning on the exit."),
        (0x09F4, "exit_shrinks_left", "Spins left before the hero has gone (4 to 1)."),
        (0x09F5, "exiting_hero", "The hero going down the exit."),
        (0x09FF, "shrunk_hero", "The hero whose sprites are shrunk, or &FF."),
    ]:
        a.label(addr, name, description=description)
    a.index_base(0x09F6, "exit_offsets_x", group="game_state", description=(
        "Horizontal pixel offset of the shrinking hero, entries 1-4 by "
        "exit_shrinks_left."))
    a.label(0x09FA, "exit_offsets_y", description=(
        "Vertical pixel offset of the shrinking hero, entries 1-4 by "
        "exit_shrinks_left (at exit_offsets_y+1 to +4). Also entry 4 of "
        "exit_offsets_x."))

    a.sub(0x1F00, "play_level", "Play a level until it ends",
          "Run one frame every three vertical syncs: check for victory and "
          "update the game, take any hero standing on the exit down it, and "
          "animate one going down. Return when no hero is in play and every "
          "death animation has finished. Each hero_enters_exit leaves its "
          "return address on the stack (it ends with a jump back here), so "
          "the first RTS at the end of a level returns into this loop, once "
          "for each hero who left by the exit, before the last returns to "
          "the caller.")
    for addr, text in [
        (0x1F00, "Wait for the vertical sync counter to pass zero..."),
        (0x1F03, "..."),
        (0x1F05, "...and set it for three syncs from now"),
        (0x1F07, "..."),
        (0x1F0A, "Has the Chalice been found?"),
        (0x1F0D, "Run a frame"),
        (0x1F10, "A hero going down the exit?"),
        (0x1F13, "Yes: carry on"),
        (0x1F15, "Is any hero in play, or still dying?"),
        (0x1F17, "In play?"),
        (0x1F1A, "Yes: carry on"),
        (0x1F1C, "Dead..."),
        (0x1F1F, "..."), (0x1F21, "..."),
        (0x1F23, "...with the death animation unfinished?"),
        (0x1F26, "..."),
        (0x1F28, "Yes: carry on"),
        (0x1F2A, "Next hero"),
        (0x1F2B, "..."),
        (0x1F2D, "The level is over: restore the last exiting hero's sprites"),
        (0x1F30, "..."), (0x1F32, "..."),
        (0x1F35, "Return"),
        (0x1F36, "Is a hero on the exit?"),
        (0x1F38, "..."), (0x1F3B, "..."), (0x1F3E, "..."),
        (0x1F40, "..."), (0x1F43, "..."), (0x1F46, "..."),
        (0x1F48, "Yes: drop their key beside it"),
        (0x1F4B, "Take them out of play for the rest of the level"),
        (0x1F4D, "..."), (0x1F50, "..."), (0x1F52, "..."),
        (0x1F55, "Erase them"),
        (0x1F58, "..."), (0x1F5B, "..."), (0x1F5E, "..."), (0x1F61, "..."),
        (0x1F63, "..."), (0x1F65, "..."), (0x1F67, "..."), (0x1F69, "..."),
        (0x1F6B, "..."), (0x1F6C, "..."), (0x1F6D, "..."), (0x1F70, "..."),
        (0x1F71, "..."),
        (0x1F72, "Move them off the map"),
        (0x1F74, "..."),
        (0x1F77, "Hide the exit while they go down it, keeping its position"),
        (0x1F7A, "..."), (0x1F7D, "..."), (0x1F80, "..."), (0x1F83, "..."),
        (0x1F85, "..."), (0x1F88, "..."),
        (0x1F8B, "Start the exit animation (which jumps back to play_level)"),
        (0x1F8E, "Reached by the RTS at the end of the level"),
        (0x1F91, "Next hero"),
        (0x1F92, "..."), (0x1F94, "..."),
        (0x1F96, "A hero going down the exit?"),
        (0x1F99, "Yes"),
        (0x1F9B, "No: next frame"),
        (0x1F9E, "Redraw the exit"),
        (0x1FA1, "..."), (0x1FA3, "..."), (0x1FA5, "..."), (0x1FA7, "..."),
        (0x1FAA, "..."), (0x1FAD, "..."), (0x1FB0, "..."), (0x1FB3, "..."),
        (0x1FB5, "..."), (0x1FB7, "..."),
        (0x1FBA, "Turn the hero a quarter (frames 1, 3, 5, 7)"),
        (0x1FBD, "..."), (0x1FBE, "..."), (0x1FC1, "..."), (0x1FC3, "..."),
        (0x1FC6, "A full turn?"),
        (0x1FC8, "Yes: shrink the hero"),
        (0x1FCA, "Plot the hero on the exit, centred for its current size"),
        (0x1FCB, "..."), (0x1FCE, "..."), (0x1FD1, "..."), (0x1FD3, "..."),
        (0x1FD6, "..."), (0x1FD9, "..."), (0x1FDC, "..."), (0x1FDF, "..."),
        (0x1FE2, "..."), (0x1FE5, "..."), (0x1FE7, "..."), (0x1FEA, "..."),
        (0x1FEC, "..."),
        (0x1FEF, "Next frame"),
        (0x1FF2, "Start the next turn"),
        (0x1FF4, "..."),
        (0x1FF7, "Last turn done?"),
        (0x1FFA, "Yes: the hero has gone"),
        (0x1FFC, "Shrink the hero's eight sprites: one byte narrower..."),
        (0x2023, "...three rows shorter. Next frame"),
        (0x2026, "Put the exit back..."),
        (0x2029, "..."), (0x202C, "..."), (0x202F, "..."),
        (0x2032, "...and end the animation"),
        (0x2034, "..."),
        (0x2037, "Next frame"),

        (0x203A, "Keep the hero number"),
        (0x203D, "Sound the exit and queue a marker"),
        (0x2040, "..."), (0x2042, "..."),
        (0x2045, "Restore the sprites of any hero shrunk before"),
        (0x2048, "..."), (0x204A, "..."), (0x204D, "..."),
        (0x2076, "Start the animation for this hero..."),
        (0x2078, "..."), (0x207B, "..."), (0x207E, "..."), (0x2081, "..."),
        (0x2084, "...turning from the start..."), (0x2086, "..."),
        (0x2089, "...for four turns"), (0x208B, "..."),
        (0x208E, "Back to play_level, without returning"),
    ]:
        a.c(addr, text)


def annotate_missile_and_object_comments(a: Annotator) -> None:
    a.label(0x7130, "missile_spent_pop")
    a.label(0x7132, "missile_spent")
    a.label(0x7218, "next_missile")
    for addr, text in [
        # move_missiles
        (0x70CA, "No pixel offsets for missiles"),
        (0x70CC, "..."), (0x70CE, "..."),
        (0x70D0, "For each of the twelve missile slots..."),
        (0x70D2, "In flight?"),
        (0x70D5, "Yes"),
        (0x70D7, "No: next slot"),
        (0x70DA, "Just fired (bit 7 set)?"),
        (0x70DC, "Yes: clear the flag..."),
        (0x70DE, "..."),
        (0x70E1, "...animate the hero who fired it..."),
        (0x70E4, "...and move it without erasing (it is on the hero)"),
        (0x70E7, "Erase the missile at its old cell"),
        (0x70E9, "..."), (0x70EB, "..."), (0x70EE, "..."), (0x70F1, "..."),
        (0x70F4, "..."), (0x70F7, "..."), (0x70F8, "..."), (0x70F9, "..."),
        (0x70FC, "..."), (0x70FD, "..."),
        (0x70FE, "Move it one cell: up..."),
        (0x7101, "..."), (0x7103, "..."), (0x7105, "..."),
        (0x7108, "...right..."), (0x710A, "..."), (0x710C, "..."),
        (0x710F, "...down..."), (0x7111, "..."), (0x7113, "..."),
        (0x7116, "...left"), (0x7118, "..."), (0x711A, "..."),
        (0x711D, "Wall in the new cell?"),
        (0x7120, "..."), (0x7123, "..."), (0x7126, "..."), (0x7129, "..."),
        (0x712A, "..."), (0x712B, "..."),
        (0x712E, "No"),
        (0x7130, "Yes: the missile is spent"),
        (0x7131, "..."),
        (0x7132, "Free the slot"),
        (0x7134, "..."),
        (0x7137, "Next slot"),
        (0x713A, "Monster in the new cell (not checking heroes)?"),
        (0x713C, "..."), (0x713F, "..."),
        (0x7142, "No"),
        (0x7144, "Yes, but is it alive?"),
        (0x7147, "..."), (0x7149, "No: fly on"),
        (0x714B, "Alive: hit it"),
        (0x714C, "..."), (0x714D, "..."),
        (0x7150, "Monster killed: a point to the hero who fired..."),
        (0x7153, "...and the missile is spent"),
        (0x7156, "Can the new cell hold an object?"),
        (0x7157, "..."), (0x7158, "..."), (0x715B, "..."), (0x715E, "..."),
        (0x7161, "..."), (0x7164, "..."), (0x7165, "..."), (0x7166, "..."),
        (0x7169, "..."), (0x716A, "..."), (0x716B, "..."),
        (0x716D, "No: check for heroes"),
        (0x716F, "Look for an energy drainer at the cell..."),
        (0x7170, "..."), (0x7171, "...objects 30 to 1"),
        (0x7173, "..."), (0x7176, "..."), (0x7179, "..."), (0x717B, "..."),
        (0x717E, "..."), (0x7181, "..."),
        (0x7183, "Is it a drainer (&53-&5E)?"),
        (0x7186, "..."), (0x7188, "No"),
        (0x718A, "..."), (0x718C, "No"),
        (0x718E, "Yes: wear it down a stage"),
        (0x7191, "..."), (0x7194, "Worn away?"), (0x7196, "No"),
        (0x7198, "Yes: remove it from the level"),
        (0x719A, "..."), (0x719D, "..."),
        (0x71A0, "A point to the hero who fired"),
        (0x71A1, "..."), (0x71A2, "..."),
        (0x71A5, "Bounce the missile back: up becomes down..."),
        (0x71A8, "..."), (0x71AA, "..."), (0x71AC, "..."), (0x71AE, "..."),
        (0x71B1, "..."),
        (0x71B4, "...right becomes left..."),
        (0x71B6, "..."), (0x71B8, "..."), (0x71BA, "..."), (0x71BD, "..."),
        (0x71C0, "...down becomes up..."),
        (0x71C2, "..."), (0x71C4, "..."), (0x71C6, "..."), (0x71C9, "..."),
        (0x71CC, "...and left becomes right"),
        (0x71CE, "..."), (0x71D1, "..."),
        (0x71D4, "Next object"),
        (0x71D5, "..."),
        (0x71D7, "No drainer here"),
        (0x71D8, "..."),
        (0x71D9, "Is a hero in the new cell?"),
        (0x71DA, "..."), (0x71DB, "..."),
        (0x71DD, "..."), (0x71DE, "..."), (0x71DF, "..."),
        (0x71E0, "..."), (0x71E3, "..."), (0x71E6, "..."),
        (0x71E8, "..."), (0x71EB, "..."), (0x71EE, "..."),
        (0x71F0, "Yes: they lose the missile's damage in health..."),
        (0x71F3, "..."), (0x71F4, "..."), (0x71F5, "..."), (0x71F6, "..."),
        (0x71F9, "..."), (0x71FA, "..."), (0x71FB, "..."), (0x71FC, "..."),
        (0x71FE, "...and the missile is spent"),
        (0x7201, "Next hero"), (0x7202, "..."), (0x7204, "..."),
        (0x7206, "Nothing hit: draw the missile in its new cell"),
        (0x7207, "..."), (0x7208, "..."), (0x7209, "..."), (0x720C, "..."),
        (0x720F, "..."), (0x7211, "..."), (0x7212, "..."), (0x7213, "..."),
        (0x7216, "..."), (0x7217, "..."),
        (0x7218, "Next slot"), (0x7219, "..."), (0x721B, "..."),
        (0x721D, "..."), (0x7220, "Return"),

        # A missile hits a monster (reached from move_missiles)
        (0x757C, "Play the hit sound"),
        (0x758D, "Take the missile's damage from the monster's hit points"),
        (0x7590, "..."), (0x7591, "..."),
        (0x7594, "Still alive?"),
        (0x7596, "No: start it dying..."), (0x7598, "..."),
        (0x759B, "...and give the slot fresh hit points for its next "
                 "appearance"),
        (0x759E, "..."),
        (0x75A1, "Missile slot back in X..."),
        (0x75A2, "..."),
        (0x75A3, "...a point to its hero, and the missile is spent"),
        (0x75A6, "Alive: store the hit points left"),
        (0x75A9, "..."), (0x75AA, "..."),
        (0x75AB, "The missile is spent"),

        # credit_missile_owner, flip_firer_frame
        (0x76B1, "Which hero fired it? Its sprite base says"),
        (0x76B4, "..."), (0x76B5, "..."), (0x76B6, "..."),
        (0x76B7, "Arrows: the Ranger"), (0x76B9, "..."), (0x76BB, "..."),
        (0x76BD, "..."),
        (0x76C0, "Fireballs: the Magic-User"), (0x76C2, "..."), (0x76C4, "..."),
        (0x76C6, "..."),
        (0x76C9, "Axes: the Barbarian"), (0x76CB, "..."), (0x76CD, "..."),
        (0x76CF, "..."),
        (0x76D2, "Otherwise swords: the Fighter"),
        (0x76D4, "One point to that hero"),
        (0x76D7, "..."), (0x76D8, "..."), (0x76D9, "Return"),
        (0x7747, "Which hero fired it? Arrows: toggle the Ranger's frame"),
        (0x774A, "..."), (0x774C, "..."), (0x774E, "..."), (0x7751, "..."),
        (0x7753, "..."), (0x7756, "Return"),
        (0x7757, "Fireballs: the Magic-User's"),
        (0x7759, "..."), (0x775B, "..."), (0x775E, "..."), (0x7760, "..."),
        (0x7763, "Return"),
        (0x7764, "Axes: the Barbarian's"),
        (0x7766, "..."), (0x7768, "..."), (0x776B, "..."), (0x776D, "..."),
        (0x7770, "Return"),
        (0x7771, "Otherwise swords: the Fighter's"),
        (0x7774, "..."), (0x7776, "..."), (0x7779, "Return"),

        # collect_objects
        (0x7329, "Look for an object at the hero's cell"),
        (0x732C, "..."), (0x732F, "..."), (0x7332, "..."),
        (0x7335, "...objects 30 to 1"),
        (0x7337, "..."), (0x733A, "..."), (0x733D, "..."), (0x733F, "..."),
        (0x7342, "..."), (0x7345, "..."), (0x7348, "..."), (0x734A, "..."),
        (0x734D, "Found: picking up anything loses Boots of Speed"),
        (0x734E, "..."), (0x734F, "..."), (0x7351, "..."),
        (0x7354, "...remove the bolt from the panel"),
        (0x7357, "..."),
        (0x735A, "..."), (0x735B, "..."),
        (0x735C, "Treasure?"), (0x735F, "..."), (0x7361, "No"),
        (0x7363, "Yes: play the treasure sound"),
        (0x737D, "20 points"),
        (0x737E, "..."), (0x737F, "..."), (0x7382, "..."),
        (0x7385, "..."), (0x7386, "..."),
        (0x7387, "Remove it"),
        (0x738A, "Food?"), (0x738C, "No"),
        (0x738E, "Yes: 10 health..."),
        (0x7391, "..."), (0x7394, "...to at most 99"), (0x7396, "..."),
        (0x7398, "..."), (0x739A, "..."), (0x739D, "..."),
        (0x73A0, "Redraw the health"),
        (0x73A1, "..."), (0x73A2, "..."),
        (0x73A5, "5 points"),
        (0x73A7, "..."), (0x73A8, "..."), (0x73A9, "..."), (0x73AC, "..."),
        (0x73AD, "..."), (0x73AE, "..."), (0x73AF, "..."),
        (0x73B1, "Play the food sound"),
        (0x73C0, "Remove it"),
        (0x73C3, "Teleporter?"), (0x73C5, "No"),
        (0x73C7, "Yes: find the previous teleporter in the list..."),
        (0x73C8, "..."), (0x73CB, "..."), (0x73CD, "..."),
        (0x73CF, "..."), (0x73D1, "..."),
        (0x73D3, "...wrapping round to the end"),
        (0x73D6, "..."),
        (0x73D9, "Play the teleport sound"),
        (0x73EA, "Move the hero to the cell above it"),
        (0x73ED, "..."), (0x73F0, "..."), (0x73F3, "..."), (0x73F6, "..."),
        (0x73F7, "..."), (0x73F9, "..."), (0x73FC, "..."),
        (0x73FF, "...with no step in progress"),
        (0x7401, "..."), (0x7404, "..."), (0x7407, "..."),
        (0x740A, "Show the room they arrive in"),
        (0x740D, "Cross of Resurrection?"), (0x740F, "No"),
        (0x7411, "Yes: remove it"),
        (0x7413, "..."), (0x7416, "..."),
        (0x7419, "10 points"),
        (0x741C, "..."), (0x741D, "..."),
        (0x741E, "Play the pickup sound"),
        (0x7421, "Anyone waiting to return?"),
        (0x7424, "Yes"),
        (0x7426, "No: return"), (0x7427, "..."), (0x7428, "..."),
        (0x7429, "Take the first entry off the queue, appending 0..."),
        (0x742B, "..."), (0x742E, "..."), (0x742F, "..."), (0x7432, "..."),
        (0x7435, "..."), (0x7438, "..."), (0x743B, "..."), (0x743E, "..."),
        (0x7441, "..."),
        (0x7444, "A &64 marker?"), (0x7446, "No"),
        (0x7448, "Yes: move it to the back and take the next entry"),
        (0x744A, "..."),
        (0x744C, "Queue empty?"), (0x744E, "Yes: nobody returns"),
        (0x7450, "Start hero X returning: out of play..."),
        (0x7452, "..."),
        (0x7455, "...from the last appearance sprite..."),
        (0x7457, "..."),
        (0x745A, "...stepping backwards..."),
        (0x745C, "..."),
        (0x745F, "...every other frame"),
        (0x7461, "..."),
        (0x7464, "Return"), (0x7465, "..."), (0x7466, "..."),
        (0x7467, "Remove object Y from the level"),
        (0x7469, "..."), (0x746C, "..."), (0x746F, "Return"),
        (0x7470, "Next object"), (0x7471, "..."), (0x7473, "..."),
        (0x7476, "Return"),
        (0x7477, "One of the magic items (&5F and up)?"),
        (0x7479, "Yes"),
        (0x747B, "The exit? Nothing to do here"),
        (0x747D, "..."),
        (0x747F, "An energy drainer: play the hit sound louder..."),
        (0x7481, "..."), (0x7484, "..."), (0x7485, "..."), (0x7486, "..."),
        (0x7488, "..."), (0x748A, "..."), (0x748C, "..."),
        (0x748F, "...then put the volume back"),
        (0x7491, "..."), (0x7494, "..."), (0x7495, "..."),
        (0x7496, "...and take 10 health"),
        (0x7498, "..."), (0x7499, "..."), (0x749A, "..."), (0x749D, "..."),
        (0x749E, "..."), (0x749F, "..."), (0x74A0, "..."),
        (0x74A2, "Return"),
        (0x74A3, "Define the envelope..."),
        (0x74A5, "..."), (0x74A7, "..."), (0x74A9, "..."),
        (0x74AC, "...and play the sound"),
        (0x74AE, "..."), (0x74B0, "..."), (0x74B2, "..."),
        (0x74B5, "Return"),
        (0x74B6, "A magic item: keep its type"),
        (0x74B9, "Remove it from the level"),
        (0x74BB, "..."), (0x74BE, "..."),
        (0x74C1, "Play the pickup sound"),
        (0x74CF, "Keep the score's units digit, for a potion"),
        (0x74D2, "..."),
        (0x74D5, "10 points"),
        (0x74D8, "Boots of Speed?"), (0x74DB, "..."), (0x74DD, "No"),
        (0x74DF, "Yes: show the bolt in the panel..."),
        (0x74E2, "..."),
        (0x74E5, "...and wear them"),
        (0x74E7, "..."), (0x74EA, "Return"),
        (0x74EB, "Magic helmet?"), (0x74ED, "No"),
        (0x74EF, "Yes: lose one less health per hit..."),
        (0x74F2, "..."), (0x74F5, "...but never fewer than 3"),
        (0x74F7, "..."), (0x74F9, "..."),
        (0x74FC, "Redraw the armour rating"),
        (0x74FF, "Potion of healing?"), (0x7501, "No"),
        (0x7503, "Yes: health tens = the score's units digit..."),
        (0x7506, "..."),
        (0x7509, "...units one more, then take a point to draw it"),
        (0x750C, "..."), (0x750F, "..."), (0x7512, "..."),
        (0x7515, "Return"),
        (0x7516, "Pile of weapons?"), (0x7518, "No: a magic sword"),
        (0x751A, "Yes: one more missile in flight..."),
        (0x751D, "..."), (0x7520, "...to at most 3"),
        (0x7522, "..."), (0x7524, "..."), (0x7526, "..."),
        (0x7529, "Draw the new missile icon"),
        (0x756B, "A magic sword: more missile damage..."),
        (0x756E, "..."), (0x7571, "...to at most 9"),
        (0x7573, "..."), (0x7575, "..."), (0x7577, "..."), (0x757A, "..."),
    ]:
        a.c(addr, text)


def annotate_monster_comments(a: Annotator) -> None:
    a.label(0x79E5, "next_monster_update")
    a.label(0x7B04, "draw_monster")
    a.label(0x7B28, "monster_done")
    a.label(0x7B31, "advance_dying_monster")
    a.label(0x7CB3, "monster_reappears")
    for addr, text in [
        (0x79C1, "Draw the eight trapdoors (sprite &2C)..."),
        (0x79C3, "..."), (0x79C5, "..."), (0x79C7, "..."), (0x79C9, "..."),
        (0x79CB, "..."),
        (0x79CD, "..."), (0x79D0, "..."), (0x79D3, "..."), (0x79D6, "..."),
        (0x79D9, "..."), (0x79DA, "..."), (0x79DB, "..."), (0x79DE, "..."),
        (0x79DF, "..."), (0x79E0, "..."), (0x79E1, "..."),
        (0x79E3, "For each monster, 30 to 1..."),
        (0x79E5, "..."), (0x79E6, "..."),
        (0x79E7, "Erase it at its cell and offsets, remembering the cell"),
        (0x79EA, "..."), (0x79ED, "..."), (0x79F0, "..."), (0x79F3, "..."),
        (0x79F6, "..."), (0x79F9, "..."), (0x79FB, "..."), (0x79FD, "..."),
        (0x7A00, "..."), (0x7A02, "..."), (0x7A05, "..."), (0x7A07, "..."),
        (0x7A0A, "..."), (0x7A0B, "..."), (0x7A0C, "..."),
        (0x7A0D, "Dying?"),
        (0x7A10, "..."),
        (0x7A12, "No"),
        (0x7A14, "Yes: advance the death animation"),
        (0x7A17, "Part way through a step?"),
        (0x7A1A, "No"),
        (0x7A1C, "Yes: continue it and draw"),
        (0x7A1F, "..."), (0x7A20, "..."),
        (0x7A23, "Start a step: move the cell in the direction it faces, "
                 "up..."),
        (0x7A26, "..."), (0x7A28, "..."), (0x7A2A, "..."),
        (0x7A2D, "...right..."), (0x7A2F, "..."), (0x7A31, "..."),
        (0x7A34, "...down..."), (0x7A36, "..."), (0x7A38, "..."),
        (0x7A3B, "...left"), (0x7A3D, "..."), (0x7A3F, "..."),
        (0x7A42, "Set the step's offsets"),
        (0x7A45, "Wall in the new cell?"),
        (0x7A48, "..."), (0x7A4B, "..."), (0x7A4E, "..."), (0x7A51, "..."),
        (0x7A54, "No"),
        (0x7A56, "Yes: stay put, with no step..."),
        (0x7A57, "..."), (0x7A58, "..."), (0x7A5B, "..."), (0x7A5E, "..."),
        (0x7A61, "..."), (0x7A64, "..."), (0x7A66, "..."), (0x7A69, "..."),
        (0x7A6C, "..."),
        (0x7A6F, "...and turn a random way: sprite 8 + (timer AND 7)..."),
        (0x7A72, "..."), (0x7A74, "..."), (0x7A75, "..."), (0x7A77, "..."),
        (0x7A7A, "...made odd (9, &0B, &0D or &0F)"),
        (0x7A7C, "..."), (0x7A7E, "..."), (0x7A81, "..."), (0x7A84, "..."),
        (0x7A87, "Is another monster, or a hero, in the new cell? (A hero "
                 "there is hurt)"),
        (0x7A88, "..."), (0x7A89, "..."), (0x7A8C, "..."), (0x7A8F, "..."),
        (0x7A91, "No"),
        (0x7A93, "Yes: stay put, with no step, and turn a random way"),
        (0x7AC1, "Moving vertically..."),
        (0x7AC2, "..."), (0x7AC3, "..."), (0x7AC6, "..."), (0x7AC8, "..."),
        (0x7ACA, "..."), (0x7ACC, "..."),
        (0x7ACE, "No: at the left or right edge of a room?"),
        (0x7AD1, "..."), (0x7AD3, "..."), (0x7AD5, "..."), (0x7AD7, "..."),
        (0x7AD9, "No: move on"),
        (0x7ADC, "Yes: at the top or bottom edge of a room?"),
        (0x7ADF, "..."), (0x7AE1, "..."), (0x7AE3, "..."), (0x7AE5, "..."),
        (0x7AE7, "No: move on"),
        (0x7AEA, "At a room edge: cancel the step, so it arrives at once"),
        (0x7AEC, "..."), (0x7AEF, "..."), (0x7AF2, "..."), (0x7AF5, "..."),
        (0x7AF8, "Move on: stay in the old cell until the step ends"),
        (0x7AFB, "..."), (0x7AFE, "..."), (0x7B01, "..."),
        (0x7B04, "Draw it: sprite = direction + frame, at its cell and "
                 "offsets"),
        (0x7B07, "..."), (0x7B0A, "..."), (0x7B0D, "..."), (0x7B10, "..."),
        (0x7B11, "..."), (0x7B14, "..."), (0x7B17, "..."), (0x7B19, "..."),
        (0x7B1C, "..."), (0x7B1E, "..."), (0x7B21, "..."), (0x7B23, "..."),
        (0x7B24, "..."), (0x7B25, "..."), (0x7B28, "..."), (0x7B29, "..."),
        (0x7B2A, "Next monster"), (0x7B2B, "..."), (0x7B2D, "..."),
        (0x7B30, "Return"),
        (0x7B31, "..."),
        (0x7B32, "Next death frame"),
        (0x7B35, "..."), (0x7B38, "Animation over?"),
        (0x7B3A, "No"),
        (0x7B3C, "Yes: bring it back at a trapdoor"),
        (0x7B3F, "Draw the death frame"),
        (0x7B40, "..."), (0x7B41, "..."), (0x7B44, "..."), (0x7B47, "..."),
        (0x7B4A, "..."), (0x7B4D, "..."), (0x7B50, "..."), (0x7B52, "..."),
        (0x7B55, "..."), (0x7B57, "..."), (0x7B5A, "..."), (0x7B5C, "..."),
        (0x7B5F, "..."),
        (0x7CB3, "Next trapdoor, 0-7 in turn"),
        (0x7CB6, "..."), (0x7CB9, "..."), (0x7CBB, "..."), (0x7CBD, "..."),
        (0x7CBF, "..."), (0x7CC2, "..."),
        (0x7CC5, "Put the monster on it, facing up, with no step"),
        (0x7CC8, "..."), (0x7CCB, "..."), (0x7CCE, "..."), (0x7CD1, "..."),
        (0x7CD3, "..."), (0x7CD6, "..."), (0x7CD8, "..."), (0x7CDB, "..."),
        (0x7CDE, "..."),
        (0x7CE1, "Is anything else on the trapdoor? (A hero there is hurt)"),
        (0x7CE2, "..."), (0x7CE3, "..."), (0x7CE6, "..."), (0x7CE9, "..."),
        (0x7CEB, "No: done"),
        (0x7CED, "Yes: wait off the map, to try again next frame"),
        (0x7CEE, "..."), (0x7CEF, "..."), (0x7CF0, "..."), (0x7CF2, "..."),
        (0x7CF5, "..."), (0x7CF8, "..."),
        (0x7CFB, "Done"),

        (0x7BEB, "Three frames per step"),
        (0x7BED, "..."),
        (0x7BF0, "First frame's offsets, in the direction of travel: up..."),
        (0x7BF3, "..."), (0x7BF5, "..."), (0x7BF7, "..."), (0x7BF9, "..."),
        (0x7BFC, "...3 rows up"), (0x7BFE, "..."), (0x7C01, "Return"),
        (0x7C02, "Moving right..."), (0x7C04, "..."), (0x7C06, "..."),
        (0x7C08, "..."), (0x7C0B, "...1 column right"),
        (0x7C0D, "..."), (0x7C10, "Return"),
        (0x7C11, "Moving down..."), (0x7C13, "..."), (0x7C15, "..."),
        (0x7C17, "..."), (0x7C1A, "...3 rows down"),
        (0x7C1C, "..."), (0x7C1F, "Return"),
        (0x7C20, "Left: 1 column left"),
        (0x7C22, "..."), (0x7C25, "..."), (0x7C27, "..."), (0x7C2A, "Return"),
        (0x7C2B, "Toggle the monster's frame"),
        (0x7C2E, "..."), (0x7C30, "..."),
        (0x7C33, "Count down the step"),
        (0x7C36, "Not over: grow the offsets"),
        (0x7C38, "Over: move the cell on in its direction, up..."),
        (0x7C3B, "..."), (0x7C3D, "..."), (0x7C3F, "..."),
        (0x7C42, "...right..."), (0x7C44, "..."), (0x7C46, "..."),
        (0x7C49, "...down..."), (0x7C4B, "..."), (0x7C4D, "..."),
        (0x7C50, "...left"), (0x7C52, "..."), (0x7C54, "..."),
        (0x7C57, "...with no offsets"),
        (0x7C59, "..."), (0x7C5C, "..."),
        (0x7C5F, "Grow the horizontal offset by a column, away from zero"),
        (0x7C62, "..."), (0x7C64, "..."), (0x7C66, "..."), (0x7C69, "..."),
        (0x7C6C, "..."),
        (0x7C6F, "Grow the vertical offset by three rows, away from zero"),
        (0x7C72, "..."), (0x7C74, "..."), (0x7C76, "..."), (0x7C77, "..."),
        (0x7C7A, "..."), (0x7C7C, "..."), (0x7C7F, "..."), (0x7C82, "..."),
        (0x7C83, "..."), (0x7C86, "..."), (0x7C88, "..."),
        (0x7C8B, "Return"),

        (0x7B62, "Step in progress"),
        (0x7B64, "..."),
        (0x7B67, "Facing up: drawn 6 rows up"),
        (0x7B6A, "..."), (0x7B6C, "..."), (0x7B6E, "..."), (0x7B70, "..."),
        (0x7B73, "..."), (0x7B75, "..."), (0x7B78, "Return"),
        (0x7B79, "Facing right: 2 columns right"),
        (0x7B7B, "..."), (0x7B7D, "..."), (0x7B7F, "..."), (0x7B82, "..."),
        (0x7B84, "..."), (0x7B87, "Return"),
        (0x7B88, "Facing down: 6 rows down"),
        (0x7B8A, "..."), (0x7B8C, "..."), (0x7B8E, "..."), (0x7B91, "..."),
        (0x7B93, "..."), (0x7B96, "Return"),
        (0x7B97, "Facing left: 2 columns left"),
        (0x7B99, "..."), (0x7B9C, "..."), (0x7B9E, "..."), (0x7BA1, "Return"),
        (0x7BA2, "Toggle the hero's frame"),
        (0x7BA5, "..."), (0x7BA7, "..."),
        (0x7BAA, "Count down the step"),
        (0x7BAD, "Not over"),
        (0x7BAF, "Over: move the cell on in the direction faced, up..."),
        (0x7BB2, "..."), (0x7BB4, "..."), (0x7BB6, "..."),
        (0x7BB9, "...right..."), (0x7BBB, "..."), (0x7BBD, "..."),
        (0x7BC0, "...down..."), (0x7BC2, "..."), (0x7BC4, "..."),
        (0x7BC7, "...left"), (0x7BC9, "..."), (0x7BCB, "..."),
        (0x7BCE, "...with no offsets"),
        (0x7BD0, "..."), (0x7BD3, "..."),
        (0x7BD6, "Double the offsets"),
        (0x7BD7, "..."), (0x7BDA, "..."), (0x7BDD, "..."), (0x7BE0, "..."),
        (0x7BE1, "..."), (0x7BE4, "..."), (0x7BE7, "..."),
        (0x7BEA, "Return"),

        (0x76DA, "Every other frame..."),
        (0x76DD, "..."), (0x76DF, "..."),
        (0x76E0, "..."), (0x76E2, "..."),
        (0x76E5, "Plot the current appearance sprite at the hero's cell"),
        (0x76E8, "..."), (0x76EA, "..."), (0x76EC, "..."), (0x76EE, "..."),
        (0x76F1, "..."), (0x76F2, "..."), (0x76F5, "..."), (0x76F7, "..."),
        (0x76F8, "..."), (0x76F9, "..."), (0x76FC, "..."), (0x76FD, "..."),
        (0x76FE, "Step to the next (+1 dying, -1 returning), stopping at 8"),
        (0x76FF, "..."), (0x7702, "..."), (0x7705, "..."), (0x7707, "..."),
        (0x7709, "..."),
        (0x770B, "Reached the first sprite (returning)?"),
        (0x770D, "No"),
        (0x770F, "Yes: in play, facing down..."),
        (0x7711, "..."),
        (0x7714, "...with no step or offsets..."),
        (0x7716, "..."), (0x7719, "..."), (0x771C, "..."), (0x771F, "..."),
        (0x7722, "...and health 33, drawn by taking a point"),
        (0x7724, "..."), (0x7727, "..."), (0x772A, "..."),
        (0x772D, "Return"),
        (0x772E, "Store the frame"), (0x7731, "Return"),
    ]:
        a.c(addr, text)


def annotate_update_game_comments(a: Annotator) -> None:
    a.label(0x1DC2, "draw_keys")
    a.label(0x1DE6, "check_hero_keys")
    a.label(0x1ECE, "update_rest")
    for addr, text in [
        (0x1CC0, "Move the heroes"),
        (0x1CC3, "For each hero..."),
        (0x1CC5, "...look for a door at the cell the hero is moving into"),
        (0x1CC8, "..."), (0x1CCB, "..."), (0x1CCE, "..."), (0x1CD1, "..."),
        (0x1CD4, "..."), (0x1CD5, "..."),
        (0x1CD6, "Doors 20 to 1"),
        (0x1CD8, "This door's x?"), (0x1CDB, "..."), (0x1CDE, "..."),
        (0x1CE0, "No: next door"),
        (0x1CE3, "...and y?"), (0x1CE6, "..."), (0x1CE9, "..."),
        (0x1CEB, "No: next door"),
        (0x1CEE, "Does the hero carry this door's key?"),
        (0x1CEF, "..."), (0x1CF0, "..."), (0x1CF1, "..."), (0x1CF2, "..."),
        (0x1CF5, "Yes"),
        (0x1CF7, "No: next door"),
        (0x1CFA, "Open the door: 7 points..."),
        (0x1CFB, "..."), (0x1CFC, "..."), (0x1CFD, "..."), (0x1CFE, "..."),
        (0x1D00, "..."), (0x1D03, "..."), (0x1D04, "..."), (0x1D05, "..."),
        (0x1D08, "..."), (0x1D09, "..."), (0x1D0A, "..."), (0x1D0B, "..."),
        (0x1D0D, "...play the food sound at a lower pitch..."),
        (0x1D0F, "..."), (0x1D12, "..."), (0x1D14, "..."), (0x1D16, "..."),
        (0x1D18, "..."),
        (0x1D1B, "...and put its pitch back"),
        (0x1D1D, "..."),
        (0x1D20, "Keep the door's cell in spare bytes beyond the monster "
                 "tables, as plot_at_cell changes cell_x and cell_y..."),
        (0x1D23, "..."), (0x1D26, "..."), (0x1D29, "..."),
        (0x1D2C, "...erase the door..."),
        (0x1D2E, "..."), (0x1D30, "..."), (0x1D32, "..."), (0x1D34, "..."),
        (0x1D36, "..."),
        (0x1D39, "...and recover its cell"),
        (0x1D3C, "..."), (0x1D3F, "..."), (0x1D42, "..."),
        (0x1D45, "..."), (0x1D46, "..."), (0x1D47, "..."), (0x1D48, "..."),
        (0x1D49, "Clear the door's wall bit: room offset..."),
        (0x1D4C, "..."), (0x1D4E, "..."), (0x1D51, "..."), (0x1D52, "..."),
        (0x1D55, "..."), (0x1D58, "..."), (0x1D5B, "..."), (0x1D5D, "..."),
        (0x1D60, "..."), (0x1D62, "..."), (0x1D64, "..."),
        (0x1D66, "...in room_walls..."), (0x1D68, "..."),
        (0x1D6A, "..."), (0x1D6B, "..."),
        (0x1D6C, "...mask for the column..."), (0x1D6F, "..."), (0x1D71, "..."),
        (0x1D72, "..."), (0x1D75, "..."), (0x1D77, "..."),
        (0x1D7A, "...byte for the row..."), (0x1D7D, "..."), (0x1D7F, "..."),
        (0x1D80, "...clear the bit"), (0x1D82, "..."), (0x1D85, "..."),
        (0x1D87, "..."), (0x1D88, "..."),
        (0x1D89, "Remove the door..."), (0x1D8B, "..."), (0x1D8E, "..."),
        (0x1D91, "..."), (0x1D92, "..."),
        (0x1D93, "...and the key, which is used up"), (0x1D95, "..."),
        (0x1D98, "Erase the key icon from the panel"),
        (0x1D9A, "..."), (0x1D9C, "..."), (0x1D9F, "..."), (0x1DA0, "..."),
        (0x1DA2, "..."), (0x1DA4, "..."), (0x1DA6, "..."), (0x1DA8, "..."),
        (0x1DA9, "..."), (0x1DAA, "..."), (0x1DAD, "..."), (0x1DAE, "..."),
        (0x1DAF, "Next hero"),
        (0x1DB2, "Next door"), (0x1DB3, "..."), (0x1DB5, "..."),
        (0x1DB8, "..."), (0x1DB9, "..."),
        (0x1DBA, "Next hero"), (0x1DBB, "..."), (0x1DBD, "..."), (0x1DBF, "..."),
        (0x1DC2, "Draw the keys on the floor, 20 to 1"),
        (0x1DC4, "..."), (0x1DC6, "..."), (0x1DC8, "..."), (0x1DCA, "..."),
        (0x1DCC, "..."),
        (0x1DCE, "..."), (0x1DD1, "..."), (0x1DD4, "..."), (0x1DD7, "..."),
        (0x1DDA, "..."), (0x1DDB, "..."), (0x1DDC, "..."), (0x1DDF, "..."),
        (0x1DE0, "..."), (0x1DE1, "..."), (0x1DE2, "..."),
        (0x1DE4, "For each hero..."),
        (0x1DE6, "In play?"),
        (0x1DE9, "Yes"),
        (0x1DEB, "Out of play: carrying a key?"),
        (0x1DEE, "Yes"),
        (0x1DF0, "No: next hero"),
        (0x1DF3, "Death animation finished?"),
        (0x1DF6, "..."), (0x1DF8, "Not yet"),
        (0x1DFA, "Yes: drop the key where the hero fell"),
        (0x1DFD, "..."), (0x1E00, "..."), (0x1E03, "..."), (0x1E06, "..."),
        (0x1E09, "..."), (0x1E0B, "..."),
        (0x1E0E, "Erase the key icon from the panel"),
        (0x1E25, "Next hero"),
        (0x1E28, "Just swapped keys?"),
        (0x1E2B, "No"),
        (0x1E2D, "Yes: not again until the hero moves on"),
        (0x1E2F, "..."), (0x1E32, "..."),
        (0x1E35, "Is there a key at the hero's cell?"),
        (0x1E38, "..."), (0x1E3B, "..."), (0x1E3E, "..."), (0x1E41, "..."),
        (0x1E42, "..."), (0x1E43, "...keys 20 to 1"),
        (0x1E45, "..."), (0x1E48, "..."), (0x1E4B, "..."),
        (0x1E4D, "..."), (0x1E50, "..."), (0x1E53, "..."),
        (0x1E55, "Yes: erase it from the floor"),
        (0x1E57, "..."), (0x1E59, "..."), (0x1E5B, "..."), (0x1E5D, "..."),
        (0x1E5F, "..."), (0x1E60, "..."), (0x1E61, "..."), (0x1E64, "..."),
        (0x1E65, "..."),
        (0x1E66, "Show the key icon in the hero's panel"),
        (0x1E67, "..."), (0x1E68, "..."), (0x1E69, "..."), (0x1E6B, "..."),
        (0x1E6D, "..."), (0x1E70, "..."), (0x1E71, "..."), (0x1E73, "..."),
        (0x1E75, "..."), (0x1E77, "..."), (0x1E79, "..."), (0x1E7A, "..."),
        (0x1E7B, "..."), (0x1E7C, "..."), (0x1E7D, "..."), (0x1E80, "..."),
        (0x1E81, "..."), (0x1E82, "..."), (0x1E83, "..."),
        (0x1E84, "Drop the key carried (if any) in this cell..."),
        (0x1E85, "..."), (0x1E86, "..."), (0x1E89, "..."), (0x1E8C, "..."),
        (0x1E8F, "..."), (0x1E92, "..."), (0x1E95, "..."), (0x1E96, "..."),
        (0x1E97, "...and carry the new one"),
        (0x1E9A, "Mark the swap"), (0x1E9C, "..."),
        (0x1E9F, "Take the new key off the floor"),
        (0x1EA1, "..."), (0x1EA4, "..."),
        (0x1EA7, "Play the key sound"),
        (0x1EA9, "..."), (0x1EAB, "..."), (0x1EAD, "..."), (0x1EB0, "..."),
        (0x1EB2, "..."), (0x1EB4, "..."), (0x1EB6, "..."),
        (0x1EB9, "..."), (0x1EBA, "..."), (0x1EBB, "Next hero"),
        (0x1EBE, "Next key"), (0x1EBF, "..."), (0x1EC1, "..."),
        (0x1EC4, "..."), (0x1EC5, "..."),
        (0x1EC6, "Next hero"), (0x1EC7, "..."), (0x1EC9, "..."), (0x1ECB, "..."),
        (0x1ECE, "Draw the objects"),
        (0x1ED1, "Move the missiles"),
        (0x1ED4, "Move the monsters"),
    ]:
        a.c(addr, text)


def annotate_cassette_pause(a: Annotator) -> None:
    """The pause key in the crack and the hack: f1 (internal key &71)."""
    for addr, text in [
        (0x1ED7, "OSBYTE &7A: which key is pressed?"),
        (0x1ED9, "..."),
        (0x1EDC, "f1 (internal key &71)?"),
        (0x1EDE, "No: return"),
        (0x1EE0, "Paused: wait for f1 to be released..."),
        (0x1EE3, "..."), (0x1EE5, "..."),
        (0x1EE7, "...pressed again..."),
        (0x1EEA, "..."), (0x1EEC, "..."),
        (0x1EEE, "...and released"),
        (0x1EF1, "..."), (0x1EF3, "..."),
    ]:
        a.c(addr, text)
