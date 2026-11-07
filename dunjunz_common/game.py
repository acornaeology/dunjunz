"""Annotations for the resident Dunjunz game, shared by every version.

Everything here is keyed by runtime address and describes code or data
that is byte-identical in the sideways RAM hack, Ole's crack and the
official disc release (see tools/runtime_images.py for the differences).
Where the versions differ, the drivers add their own annotations.
"""

import dasmos
from dasmos.expr import char, hexlit, hi, lo, sym

from dunjunz_common.annotator import Annotator


def annotate(a: Annotator) -> None:
    annotate_regions(a)
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
    annotate_menu_and_panel_comments(a)
    annotate_victory_and_helpers(a)
    annotate_shared_continuations(a)
    annotate_branch_labels(a)
    annotate_sprite_numbers(a)
    annotate_named_operands(a)
    annotate_runtime_tables(a)
    annotate_unreferenced(a)
    a.expr(0x1506, lo(sym("wrch_handler")))
    a.expr(0x150B, hi(sym("wrch_handler")))


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
    a.label(0x7B, "map_ptr", description=(
        "Pointer into room_walls or object_free_map at a cell's room, low "
        "byte; set by test_wall and test_object_free."), **zp)
    a.label(0x7C, "map_ptr_hi", description="Pointer into a map, high byte.", **zp)
    a.label(0x7D, "plot_offset_x", description=(
        "Horizontal pixel offset added by plot_at_cell (in byte columns)."), **zp)
    a.label(0x7E, "plot_offset_y", description=(
        "Vertical pixel offset added by plot_at_cell (in pixel rows)."), **zp)
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
    a.c(0x0900, "X = sprite number, indexing the four sprite tables")
    a.c(0x0902, "Point sprite_data_ptr at the sprite's data...")
    a.c(0x0905, "...low byte")
    a.c(0x0907, "...high byte from its own table")
    a.c(0x090A, "...so sprite_data_ptr walks through the data")
    a.c(0x090C, "Bytes in each sprite row...")
    a.c(0x090F, "...counted across each row")
    a.c(0x0911, "Pixel rows in the sprite...")
    a.c(0x0914, "...counted down the sprite")
    a.c(0x0916, "screen_ptr = address of the top-left byte")
    a.c(0x0919, "Index stays 0: the pointers themselves advance")
    a.c(0x091B, "X counts the pixel rows still to plot")
    a.c(0x091D, "Remember where this pixel row starts...")
    a.c(0x091F, "...low byte")
    a.c(0x0921, "...and high byte...")
    a.c(0x0923, "...in row_start_ptr, to step down from later")
    a.c(0x0925, "Save the row count")
    a.c(0x0926, "...on the stack: X now counts bytes")
    a.c(0x0927, "X counts the bytes across this row")
    a.c(0x0929, "Copy one sprite byte...")
    a.c(0x092B, "...to the screen, over whatever was there")
    a.c(0x092D, "Step screen_ptr right one byte column: 8 bytes on")
    a.c(0x092E, "...the screen address's low byte...")
    a.c(0x0930, "...+ 8, the next byte column...")
    a.c(0x0932, "...stored back")
    a.c(0x0934, "No carry: the high byte stands")
    a.c(0x0936, "...with carry into the high byte")
    a.c(0x0938, "Next sprite data byte")
    a.c(0x093A, "No carry: the high byte stands")
    a.c(0x093C, "...with carry into the high byte")
    a.c(0x093E, "One byte fewer left in this row")
    a.c(0x093F, "More of the row: plot the next byte")
    a.c(0x0941, "screen_ptr = row start + 1: the next pixel row down")
    a.c(0x0942, "The row start's low byte...")
    a.c(0x0944, "...+ 1...")
    a.c(0x0946, "...is the new low byte")
    a.c(0x0948, "The row start's high byte...")
    a.c(0x094A, "...plus the carry...")
    a.c(0x094C, "...is the new high byte")
    a.c(0x094E, "Has it crossed into the next character row?")
    a.c(0x0950, "...(pixel row within the character now 0)")
    a.c(0x0952, "No: still within the character row")
    a.c(0x0954, "Yes: add &278 more, to the top of the character...")
    a.c(0x0955, "...row below (row start + 1 + &278 = + 640 - 7)")
    a.c(0x0957, "...low byte + &78 (640 - 8 = &278)...")
    a.c(0x0959, "...stored")
    a.c(0x095B, "...high byte...")
    a.c(0x095D, "...+ 2 and the carry...")
    a.c(0x095F, "...stored")
    a.c(0x0961, "Recover the row count")
    a.c(0x0962, "...back into X")
    a.c(0x0963, "One pixel row fewer to plot")
    a.c(0x0964, "More rows: plot the next")
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
    a.c(0x0967, "Table index = 2 x (plot_y DIV 8), the character row...")
    a.c(0x0969, "...plot_y / 2...")
    a.c(0x096A, "...plot_y / 4...")
    a.c(0x096B, "...bit 0 cleared: the row's pair of table bytes")
    a.c(0x096D, "...as the index into the MOS table")
    a.c(0x096E, "High byte of row x 640, from the MOS table...")
    a.c(0x0971, "...(carry clear for the add)")
    a.c(0x0972, "...plus &30: the screen starts at &3000")
    a.c(0x0974, "...as the screen address high byte")
    a.c(0x0976, "Low byte of row x 640")
    a.c(0x0979, "...as the low byte")
    a.c(0x097B, "Add the pixel row within the character...")
    a.c(0x097D, "...plot_y MOD 8...")
    a.c(0x097F, "...(carry clear: adding &30 to the high byte cannot carry)")
    a.c(0x0981, "...stored in the low byte")
    a.c(0x0983, "Add 8 x plot_x: its high byte is plot_x DIV 32...")
    a.c(0x0984, "...from plot_x...")
    a.c(0x0986, "...bits 7-5 kept...")
    a.c(0x0988, "...four ROLs through the carry: bit 7 out...")
    a.c(0x0989, "...bit 7 in at bit 0, bit 6 out")
    a.c(0x098A, "...bits 7-6 at bits 1-0, bit 5 out")
    a.c(0x098B, "...bits 7-5 now in bits 2-0")
    a.c(0x098C, "...(carry clear for the add)")
    a.c(0x098D, "...added to the high byte")
    a.c(0x098F, "...stored")
    a.c(0x0991, "...then plot_x x 8 into the low byte")
    a.c(0x0993, "...x 2...")
    a.c(0x0994, "...x 4...")
    a.c(0x0995, "...x 8, its top bits dropping out")
    a.c(0x0996, "...(carry clear for the add)")
    a.c(0x0997, "...added to the low byte")
    a.c(0x0999, "...stored")
    a.c(0x099B, "No carry: done")
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
    for base, chars in [(0x12D7, "ABCDEFGHIJKLMNOPQRSTUVWXYZ"), (0x13A7, "0123456789")]:
        for i, ch in enumerate(chars):
            for row in range(8):
                addr = base + 8 * i + row
                a.byte(addr, 1)
                a.format_hint(addr, dasmos.FormatHint.BINARY)
            a.c(base + 8 * i, f"'{ch}'")

    a.sub(0x7F8F, "wrch_handler", "WRCHV handler: print letters and digits in the game font",
          description=(
              "Installed on WRCHV while the game runs. A letter (either "
              "case) or a digit is printed in the game's own font: its "
              "eight-byte glyph is copied over the definition of character "
              "128 (user_char_128) and character 128 is printed instead. "
              "Every other character is printed unchanged. Both paths "
              "finish in the MOS 1.20 OSWRCH routine at mos_oswrch_default, "
              "jumped to directly rather than through the WRCHV value "
              "saved at start-up. Lower-case letters share the capitals' "
              "glyphs. The handler keeps the character in plot_x, the "
              "sprite plotter's zero-page column, and it looks at every "
              "byte alone, with no notion of a VDU sequence: a VDU "
              "parameter byte that falls in '0'-'9', 'A'-'Z' or 'a'-'z' "
              "is sent as &80 too."),
          on_entry={"A": "character to print"},
          on_exit={"A": "corrupted", "X": "preserved", "Y": "preserved",
                   "plot_x": "corrupted"})
    a.c(0x7F8F, "Keep the character in plot_x, borrowed as scratch")
    a.c(0x7F91, "Save the caller's X...")
    a.c(0x7F92, "...on the stack")
    a.c(0x7F93, "...and the caller's Y")
    a.c(0x7F94, "...on the stack: OSWRCH must preserve both")
    a.c(0x7F95, "Classify the character by range")
    a.c(0x7F97, "Below '0'?")
    a.c(0x7F99, "Controls, space, punctuation: the MOS font")
    a.c(0x7F9B, "'0'-'9'?")
    a.c(0x7F9D, "A digit: use the game's digit glyph")
    a.c(0x7F9F, "':'-'@'?")
    a.c(0x7FA1, "Punctuation: the MOS font")
    a.c(0x7FA3, "'A'-'Z'?")
    a.c(0x7FA5, "A capital: use the game's letter glyph")
    a.c(0x7FA7, "'['-'`'?")
    a.c(0x7FA9, "Punctuation: the MOS font")
    a.c(0x7FAB, "Beyond 'z'?")
    a.c(0x7FAD, "'{' and above: the MOS font")
    a.c(0x7FAF, "Lower case: letter number 0-25...")
    a.c(0x7FB0, "...so it is drawn with the capital's glyph")
    a.c(0x7FB2, "Join the capitals' path")
    a.c(0x7FB5, "Capital: letter number 0-25...")
    a.c(0x7FB6, "...0 for 'A'")
    a.c(0x7FB8, "x 2: eight bytes a glyph in font_letters...")
    a.c(0x7FB9, "...x 4...")
    a.c(0x7FBA, "...x 8: the glyph's offset (at most 200)")
    a.c(0x7FBB, "Branch to the next instruction either way")
    a.c(0x7FBD, "X indexes the glyph in font_letters")
    a.c(0x7FBE, "End offset = start + 8...")
    a.c(0x7FBF, "...one glyph's eight rows...")
    a.c(0x7FC1, "...in plot_x, the character no longer needed")
    a.c(0x7FC3, "Y indexes character 128's definition at &0C00")
    a.c(0x7FC5, "Copy a row of the letter's glyph...")
    a.c(0x7FC8, "...over character 128's definition")
    a.c(0x7FCB, "Next row of character 128")
    a.c(0x7FCC, "Next row of the glyph")
    a.c(0x7FCD, "All eight rows copied?")
    a.c(0x7FCF, "No: copy the next row")
    a.c(0x7FD1, "Restore the caller's Y...")
    a.c(0x7FD2, "...from the stack")
    a.c(0x7FD3, "...and the caller's X")
    a.c(0x7FD4, "...from the stack")
    a.c(0x7FD5, "Character 128, which now looks like the glyph...")
    a.c(0x7FD7, "...printed by the MOS 1.20 OSWRCH routine itself")
    a.c(0x7FDA, "Digit: digit number 0-9...")
    a.c(0x7FDB, "...0 for '0'")
    a.c(0x7FDD, "x 2: eight bytes a glyph in font_digits...")
    a.c(0x7FDE, "...x 4...")
    a.c(0x7FDF, "...x 8: the glyph's offset")
    a.c(0x7FE0, "X indexes the glyph in font_digits")
    a.c(0x7FE1, "End offset = start + 8...")
    a.c(0x7FE2, "...one glyph's eight rows...")
    a.c(0x7FE4, "...in plot_x, the character no longer needed")
    a.c(0x7FE6, "Y indexes character 128's definition at &0C00")
    a.c(0x7FE8, "Copy a row of the digit's glyph...")
    a.c(0x7FEB, "...over character 128's definition")
    a.c(0x7FEE, "Next row of character 128")
    a.c(0x7FEF, "Next row of the glyph")
    a.c(0x7FF0, "All eight rows copied?")
    a.c(0x7FF2, "No: copy the next row")
    a.c(0x7FF4, "Done (always taken): print character 128")
    a.c(0x7FF6, "Not a letter or digit: restore the caller's Y...")
    a.c(0x7FF7, "...from the stack")
    a.c(0x7FF8, "...and the caller's X")
    a.c(0x7FF9, "...from the stack")
    a.c(0x7FFA, "The character, unchanged, from plot_x...")
    a.c(0x7FFC, "...printed by the MOS 1.20 OSWRCH routine itself")


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
    a.label(0x7E00, "monster_x", length=0x29, description=(
        "Map x of each monster (entries 1-30). During a step it stays the "
        "cell the monster is leaving until the step ends."))
    a.label(0x7E29, "monster_y", length=0x29, description=(
        "Map y of each monster, kept like monster_x."))
    a.label(0x7E52, "monster_sprite", length=0x29, description=(
        "Each monster's state as a sprite number: 9, &0B, &0D or &0F facing "
        "up, right, down or left; &15 (the blank) when just killed, then "
        "&16-&19, the sparkles of its death, one a frame. It reaches &1A "
        "only for the moment before monster_reappears resets it to 9."))
    a.label(0x7E7B, "monster_frame", length=0x29, description=(
        "Each monster's animation frame (0 or 1), added to its facing "
        "sprite; toggled on each frame of a step."))
    a.label(0x7EA4, "monster_offset_x", length=0x29, description=(
        "How far each monster is drawn across from its cell during a step, "
        "in byte columns: 0, or +/-1 to 3."))
    a.label(0x7ECD, "monster_offset_y", length=0x29, description=(
        "How far each monster is drawn down from its cell during a step, "
        "in pixel rows: 0, or +/-3, 6 or 9."))
    a.label(0x7EF6, "monster_step", length=0x29, description=(
        "Frames left in each monster's step between cells: 3 when the step "
        "starts, 0 when the monster is not stepping."))
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
          "Advance the thousands digit of hero X's score. It is called from "
          "add_ten_points when the hundreds digit carries, and returns to "
          "draw_score there, which redraws the four large score digits. The "
          "panel has room for only those four, so when the thousands digit "
          "passes 9 it goes back to 0 and a separate ten-thousands digit, "
          "held as a small digit sprite, goes up, sticking at 9. That digit "
          "is then drawn under the score at draw_ten_thousands, followed by "
          "four of sprite &71. Sprite &71, the small 8, is a solid bar two "
          "pixels wide, the same shape a small 0 would have, so the line "
          "reads as a small N0000. remove_absent_heroes enters at "
          "draw_ten_thousands to redraw the line at the start of each level.",
          on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x0ECF, "reset_hero", "Give a hero their starting attributes",
          "Set hero X's missile limit, missile damage and damage taken from "
          "the starting tables, and their score to zero with no "
          "ten-thousands digit. new_game calls it for every hero, and "
          "level_loop for each hero who died (or was not playing) when a "
          "level ends, so survivors keep their scores, missile limits, "
          "missile damage and armour. The units digit is set one below 0 because "
          "draw_status_panel draws the score by adding a point.",
          on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x0EF7, "draw_status_panel", "Draw the status panel",
          "Draw each hero's section of the status panel to the right of the "
          "views, after start_level has cleared the screen. The health and "
          "score are drawn by taking a health point and adding a score "
          "point: the health comes from the workspace template as 99 + 1, "
          "so it is 99 at the start of every level, and a hero just reset "
          "has a score one below 0000. A hero who survived the last level "
          "keeps their score, so gains a point here at every new level. Above "
          "the health go the face and the shield with the armour rating on "
          "it, and the missile damage; beside the health, one icon per "
          "missile allowed in flight.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x0F68, "plot_panel_sprite", "Plot a sprite in a hero's panel section",
          "Plot sprite A at byte column X and pixel row Y + hero_panel_y - "
          "14 for the hero being drawn (draw_status_panel's loop counter). "
          "Row 0 of a section is thus 14 rows above the health digits. The "
          "panel row is read from workspace_template, whose copy in page "
          "&0D is hero_panel_y.",
          on_entry={"A": "sprite number", "X": "byte column",
                    "Y": "row within the hero's panel section"})
    a.sub(0x7221, "lose_health_point", "Take one health point from a hero",
          "If hero X is in play, take one from their health and redraw it in "
          "the status panel. Every kind of harm comes through here one point "
          "at a time: a monster's touch or bump, a missile, an energy "
          "drainer, the cost of magic. draw_status_panel, the potion and a "
          "returning hero also call it, to draw a health set one point "
          "high. Health is two digit sprites, so the "
          "units digit wraps from 0 to 9 with a borrow from the tens. "
          "Health 00 is still alive; the hero dies when a point is taken "
          "from 00. Then their sprite is erased, they leave play (direction "
          "0), the death animation is started (frame step +1, counter 1) and "
          "their number + 1 is added at the end of returning_hero_queue, for "
          "a Cross of Resurrection to bring back. A hero out of play, dying "
          "or returning, loses nothing. The health is not redrawn on death.",
          on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x728C, "add_point", "Add one point to a hero's score",
          "Add one to hero X's score, carrying into the tens and above, and "
          "redraw the score in the status panel. The score is four digit "
          "sprites (thousands to units), with add_thousand_points handling "
          "the ten-thousands.", on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x729B, "add_ten_points", "Add ten points to a hero's score",
          "Add ten to hero X's score, carrying into the hundreds and through "
          "add_thousand_points, and redraw the score. add_point falls into "
          "this entry to carry from the units. The units digit is left as "
          "it is.", on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x75F9, "point_at_boots_icon", "Set the position of a hero's boots icon",
          "Set plot_x to the panel's column &4A and plot_y to eight pixel "
          "rows above hero X's panel row (hero_panel_y), where the lightning "
          "bolt shows that the hero wears Boots of Speed. plot_boots_icon or "
          "erase_boots_icon then plots there.", on_entry=X_HERO,
          on_exit={"plot_x": "&4A", "plot_y": "hero_panel_y - 8",
                   "X": "preserved"})
    a.sub(0x7606, "plot_boots_icon", "Show a hero's boots icon",
          "Plot the lightning bolt at plot_x, plot_y.", on_exit=X_KEPT)
    a.sub(0x760D, "erase_boots_icon", "Remove a hero's boots icon",
          "Plot the blank sprite over the lightning bolt at plot_x, plot_y.",
          on_exit=X_KEPT)

    # The hero-selection menu
    a.sub(0x0500, "hero_menu", "Choose the heroes and the sound",
          "Called by new_game once the heroes are reset. Set a text window "
          "the full width of the screen (MODE 2's 20 columns) and clear it, "
          "print the menu and read keys. Keys 1-4 toggle a hero between YES "
          "and NO by flipping hero_absent and rewriting the menu text; 5 and "
          "6 switch the sound on and off with OSBYTE &D2. SPACE returns, so "
          "the game starts, only if at least one hero is playing. Neither "
          "hero_absent nor the menu text is reset here.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x0524, "print_menu", "Print the menu text",
          "Print the sixteen positioned strings of menu_text.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
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
    a.sub(0x06B0, "remove_absent_heroes", "Take the heroes nobody plays out of the level",
          "Called by level_loop after draw_status_panel. First redraw the "
          "small ten-thousands line under each score that has one, since "
          "start_level cleared the screen and draw_status_panel draws only "
          "the four large digits. Then take every hero switched off on the "
          "menu out of play: direction 0; step_out_of_play, so move_heroes "
          "passes over them; frame 8 and dead health, so that play_level "
          "treats them as dead with their death animation over, and "
          "level_loop counts them among the dead; and a nobody_returns "
          "entry in returning_hero_queue, which a Cross of Resurrection "
          "skips. Their panel section keeps the health and score just "
          "drawn.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})

    # Branch targets within the routines above
    for addr, name in [
        (0x041E, "draw_ten_thousands"),
        (0x0437, "draw_ten_thousands_loop"),
        (0x0447, "add_thousand_points_done"),
        (0x0528, "print_menu_loop"),
        (0x0540, "print_menu_string_loop"),
        (0x05C0, "menu_hero_off"),
        (0x05C3, "menu_reprint"),
        (0x05C9, "menu_space"),
        (0x05CB, "menu_space_check_hero"),
        (0x05D6, "menu_done"),
        (0x05D7, "menu_sound_key"),
        (0x05E4, "menu_sound_off"),
        (0x05E9, "menu_set_sound"),
        (0x06B4, "remove_absent_heroes_loop"),
        (0x06C9, "remove_absent_heroes_check"),
        (0x06F0, "remove_absent_heroes_next"),
    ]:
        a.label(addr, name)

    # Levels
    a.sub(0x14A0, "reset_workspace", "Reset the game workspace for a new level",
          "Called by start_level. Copy the 256 bytes of workspace_template "
          "over page &0D, which puts the heroes, missiles and views back to "
          "their starting state, then reset the exit animation's state: no "
          "hero going down the exit or shrunk, the shrinking hero's pixel "
          "offsets (x 1, 1, 0, 0 and y 5, 3, 1, 0 for exit_shrinks_left 1-4), "
          "and trapdoor 0 as the next one a monster comes out of.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    a.sub(0x14D7, "draw_view_frames", "Draw the frames round the four views",
          "Called by start_level. Point WRCHV back at the MOS's own routine, "
          "so the PLOT bytes reach the VDU drivers instead of being turned "
          "into the game's font, send the twenty five-byte commands at "
          "(plot_x), draw the room each view shows, then point WRCHV at "
          "wrch_handler again.",
          on_entry={"plot_x": "address of view_frame_plots, low byte",
                    "plot_y": "address of view_frame_plots, high byte"},
          on_exit={"plot_x": "advanced by 100", "A": "corrupted",
                   "X": "corrupted", "Y": "corrupted"})
    a.sub(0x1510, "unpack_level", "Copy the loaded level into the game's tables",
          "Called by start_level once the level file at &6B00 has been "
          "decrypted and checked. Copy objects 1-30 (position and type), "
          "doors 1-20 (position and sprite), keys 1-20, trapdoors 0-7, &C9 "
          "bytes each of the wall map (into room_walls) and object-free map, "
          "and the level's 4 x 12 wall block into sprite 0. Entry 0 of the "
          "object, door and key tables is not touched. room_walls is also "
          "character 128's definition, which the game's text output "
          "overwrites, so this must follow the printing of the level number.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    a.sub(0x1583, "reset_monsters", "Clear the monsters for a new level",
          "Called by start_level. Give monsters 1-30 the blank sprite (the "
          "first stage of dying) off the map, so each comes out of a "
          "trapdoor in turn, with this level's starting hit points. Then, "
          "for each of the four heroes, clear their returning_hero_queue "
          "entry, the key they carry and swapped, and the cell kept for the "
          "door checks.",
           on_exit={"A": "0", "X": "4", "Y": "preserved"})
    a.sub(0x161A, "clear_text_area", "Clear the screen",
          "Set a text window the full 20 columns wide, from row 0 to the "
          "bottom row, and clear it with VDU 12. The window is left set.",
           on_exit={"A": "corrupted", "X": "preserved", "Y": "preserved"})

    # Winning
    a.sub(0x1070, "check_for_victory", "Check whether the Chalice has been found",
          "Called by play_level at the start of every frame. On level 25, "
          "if any hero's hero_door_x, hero_door_y (the cell they last "
          "stepped or tried to step into, kept even when a wall stops them) "
          "is one of the Chalice's four cells, x &1A-&1B and y 4-5, the game "
          "is won: play the victory sequence, print the ending text over the "
          "views, wait for a key and reset the machine through the RESET "
          "vector, so this never returns. The text is not part of the "
          "program: it is the 140 bytes at room_walls + &3A followed by the "
          "zero-terminated string at object_free_map + &3A, which on level "
          "25 hold the ending text instead of map data. Otherwise return at "
          "once.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    a.sub(0x10E9, "victory_sequence", "Play the victory sequence",
          "Called by check_for_victory once a hero reaches the Chalice. Each "
          "pass sounds the bell, draws the ring of sparkles round the "
          "Chalice, and waits. The bell's pitch climbs by a step each pass "
          "and wraps past 255, and each time it wraps the step grows by 1, "
          "so the tone repeats as ever faster sweeps. The wait starts at &E6 "
          "units of about 1,280 cycles each and shortens by one a pass down "
          "to 1; from then on each pass also clears one random byte of the "
          "Chalice. After the 50th wrap, erase the ring, blank the Chalice "
          "and wait 255 vertical syncs. OSBYTEs &D4 and &D5 set (old AND Y) "
          "EOR X, and Y is never set for them: the bell's envelope byte "
          "takes Y left over from the frame, and the first pitch takes the "
          "Y that OSBYTE &D4 returns; later passes have Y = 0 from the wait "
          "loop, so the pitch is exactly victory_pitch.",
           on_exit={"A": "0", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x1149, "draw_victory_ring", "Draw the ring of sprites round the Chalice",
          "Plot victory_sprite at the twelve cells round the Chalice's 2 x 2 "
          "block, from x &1C, y 3 leftwards along the top, down the left "
          "side, along the bottom and up the right side, three cells to a "
          "side. The sprite moves on to the next sparkle (next_victory_sprite) "
          "after each of the first three sides and is left at the fourth "
          "side's, so the next ring starts with it and the sparkles move one "
          "side round the ring each pass. With the blank sprite, it erases "
          "the ring.",
           on_entry={"victory_sprite": "the sprite for the top side"},
           on_exit={"victory_sprite": "the sprite of the right side",
                    "A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x119A, "plot_victory_sprite", "Plot a victory sprite at a cell",
          "Plot victory_sprite at the cell ring_x, ring_y in every view "
          "showing it, with the pixel offsets victory_sequence cleared.",
           on_entry={"ring_x": "cell x", "ring_y": "cell y", "victory_sprite": "the sprite"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x11AC, "next_victory_sprite", "Choose the next victory sprite",
          "Step victory_sprite through the four sparkles, &16-&19, wrapping "
          "back to &16. The blank sprite, &15, used to erase the ring, is "
          "left alone.",
           on_entry={"victory_sprite": "the current sprite"}, on_exit={"victory_sprite": "the next sparkle, &16-&19 in turn; &15 (erasing) is kept", "A": "victory_sprite", "X": "preserved", "Y": "preserved"})
    a.sub(0x11BE, "dissolve_chalice", "Clear a random byte of the Chalice",
          "Make a random number from the System VIA's timer 1 low byte "
          "mixed with two bytes of MOS workspace. If it is below &C0, the "
          "size of the Chalice's 8 x 24-byte sprite, zero that byte of "
          "sprite_chalice and replot the Chalice, so it dissolves into black "
          "a pixel pair at a time; otherwise do nothing this pass.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x11F2, "plot_chalice", "Plot the Chalice",
          "Plot sprite &73, the Chalice, at its top-left cell (x &1A, y 4) "
          "in every view showing it. The sprite is two cells wide and two "
          "high, so it covers the four cells check_for_victory tests.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})

    # The main loop
    a.sub(0x1CC0, "update_game", "Run one frame of play",
          "Called by play_level each frame, after check_for_victory. Move "
          "the heroes; then, for each hero, look for a door at the cell they "
          "last stepped or tried to step into (hero_door_x, hero_door_y): "
          "if they carry that door's key, the door opens, the hero scores 7 "
          "and the key is used up. Then draw the keys, pick up and swap "
          "keys, draw the objects, move the missiles and the monsters, and "
          "handle the pause key.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x203A, "hero_enters_exit", "Start a hero going down the exit",
          "Called by play_level for hero X, who has just stepped onto the "
          "exit. Play the exit sound and put a marker in "
          "returning_hero_queue, give any hero shrunk on an earlier exit "
          "back their full-size sprites, then mark the exit busy and set "
          "up four turns of the spin for hero X. Ends by jumping to "
          "play_level rather than returning, so its return address stays "
          "on the stack until the level ends.", on_entry=X_HERO)
    a.sub(0x2050, "restore_hero_sprites", "Restore a hero's sprite sizes",
          "Set the seven sprites base + 1 to base + 7 of hero X (base from "
          "hero_sprites), which the exit animation shrinks, back to the "
          "full cell: 4 bytes wide and 12 rows high. Used when the next "
          "hero takes the exit and when the level ends.", on_entry=X_HERO,
          on_exit={"A": "12", "X": "base + 1", "Y": "base + 8"})
    a.sub(0x2091, "drop_key", "Drop the key a hero carries",
          "Called when hero X steps onto the exit. Put their key in a cell "
          "next to them with no wall (see find_open_neighbour; another key "
          "or an object may already lie there), and erase the key icon "
          "from their panel section. A hero with no key moves key entry "
          "0, which is never drawn or picked up.", on_entry=X_HERO,
          on_exit=X_KEPT)
    a.sub(0x20D0, "find_open_neighbour", "Find a free cell next to a cell",
          "Starting with cell_x, cell_y, try the cells above, to the right "
          "and below, and leave cell_x, cell_y at the first without a "
          "wall; failing those, leave them at the cell to the left without "
          "testing it. Only walls are tested, not keys, objects or "
          "creatures.",
           on_entry={"cell_x": "cell x", "cell_y": "cell y"}, on_exit={"cell_x": "x of the first free neighbour, trying above, right and below; otherwise the cell to the left, unchecked", "cell_y": "its y", "Y": "0 if a free neighbour was found", "A": "corrupted", "X": "corrupted"})
    a.sub(0x16A0, "queue_exit_marker", "Sound the exit and add a queue marker",
          "Called by hero_enters_exit. Define exit_envelope and play "
          "exit_sound, then put a &64 (nobody_returns) entry in the first "
          "empty (zero) entry of returning_hero_queue, as "
          "remove_absent_heroes does for each hero nobody plays. At most "
          "four entries are ever in use, so an empty one is always found.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})

    # Heroes
    a.sub(0x6E80, "move_heroes", "Move the heroes",
          "Called by update_game at the start of each frame. A hero out of "
          "play is skipped if nobody plays them (step &63), or animated by "
          "animate_absent_hero if dying or returning through a Cross. A "
          "hero part way through a step finishes it. Otherwise heroes 0 and "
          "1 first try their magic key (check_magic, whose delay can return "
          "from move_heroes before the later heroes move), then the keys are "
          "tried in the order up, down, right, left, fire, and the first "
          "held one wins. A move records the cell tried in hero_door_x/y, "
          "for update_game's door test, before a wall, a monster (which "
          "costs a health point) or another hero in play can refuse it. A "
          "move into another room is made at once and switches the hero's "
          "view; within a room the Boots of Speed also make it at once, and "
          "without them the hero is drawn half a cell along and arrives on "
          "the next frame through continue_hero_step. Fire puts a missile "
          "in the hero's first free slot. A hero who moved is erased at "
          "their old position; every hero in play is then drawn and picks "
          "up any object in their cell.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x7B62, "start_hero_step", "Start a hero's step between cells",
          "Called by move_heroes when a direction key starts a move. Set "
          "hero X's step counter to 1 and their pixel offsets to half a "
          "cell in the direction they face: 6 rows up or down, or 2 byte "
          "columns left or right. move_heroes then draws the hero there, "
          "half way to the next cell, for one frame.",
          on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x7BA2, "continue_hero_step", "Continue a hero's step between cells",
          "Called by move_heroes on the frame after a step starts. Toggle "
          "hero X's animation frame and count down their step. When it "
          "ends, move the hero one cell in the direction they face and "
          "clear the pixel offsets. The offsets are then doubled. Since "
          "start_hero_step sets the counter to 1 and nothing else gives an "
          "in-play hero a non-zero step, the step always ends here, so the "
          "doubling only ever doubles zero offsets.",
          on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x76DA, "animate_absent_hero", "Animate a hero who is out of play",
          "move_heroes calls this for a hero out of play (direction 0) "
          "unless nobody plays them (step &63). While out of play, "
          "hero_offset_y is a two-frame timer and hero_offset_x the step "
          "through the sequence."
          "\n\n"
          "Every other frame, plot hero_appearance_sprites entry hero_frame "
          "at the hero's cell, then step hero_frame by hero_offset_x: "
          "forwards (+1) for a hero dying, stopping at the skull (entry 8), "
          "which then stays on the map; backwards (-1) for a hero returning "
          "through a Cross of Resurrection, from entry 8. A dying hero starts "
          "from their walking frame (0 or 1), which lose_health_point does "
          "not reset, so the first sparkle may be skipped. A returning hero "
          "is put in play as hero_frame reaches 0, so entry 0 is never shown "
          "on the way back. They come back facing down with health 32 (set "
          "to 33 and drawn by taking a point).",
          on_entry=X_HERO)
    a.sub(0x7732, "draw_hero", "Draw a hero",
          "Plot sprite_number at hero X's cell, shifted by their pixel "
          "offsets, in every view that shows it. move_heroes calls it with "
          "the hero's own sprite; lose_health_point calls it with the blank "
          "to erase a hero who has just died. cell_x and cell_y are left "
          "as plot_at_cell leaves them.", on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x777A, "get_hero_cell", "Copy a hero's position to cell_x, cell_y",
          on_entry=X_HERO, on_exit=X_KEPT)
    a.sub(0x7305, "draw_objects", "Draw the level's objects",
          "Plot each of objects 30 to 1, using its type as the sprite, at "
          "its cell in every view that shows it, with no pixel offset. "
          "update_game calls this every frame, before the missiles and "
          "monsters move, so objects are put back wherever a moving sprite "
          "has crossed them. An object that has been collected or worn away "
          "has map x and y &FF (off_map).",
          on_exit={"A": "corrupted", "X": "0", "Y": "corrupted"})
    a.sub(0x7329, "collect_objects", "Pick up the object in a hero's cell",
          "Search objects 30 down to 1 for one at hero X's cell and act on "
          "the first found. move_heroes calls this after drawing a hero who "
          "has moved, when object_free_map says the cell can hold an object."
          "\n\n"
          "Finding any object at all takes off the hero's Boots of Speed and "
          "erases the bolt from the panel, before the type is looked at, so "
          "the boots are lost to a teleporter, a drainer or the exit as well "
          "as to a pickup. Then, by type: treasure gives 20 points; food 10 "
          "health (to at most 99) and 5 points; a teleporter moves the hero "
          "to the cell above the previous teleporter in the list (wrapping "
          "from object 1 to 29), with no test of that cell, and shows the "
          "room; the Cross of Resurrection gives 10 points and starts the "
          "first hero in returning_hero_queue materialising; the exit is "
          "passed over and the search goes on; every type from &5F up is a "
          "magic item (10 points, then boots, helmet, potion, weapons, or "
          "otherwise the sword); any other type is taken as an energy "
          "drainer, which costs 10 health and stays. Treasure, food, the "
          "Cross and magic items are removed from the level.",
          on_entry=X_HERO)
    a.sub(0x74A3, "play_pickup_sound", "Play the pickup sound",
          "Define envelope 3 as the pickup envelope and play the pickup "
          "sound on the noise channel, from the OSWORD parameter blocks at "
          "&192C and &193A. Envelope 3 is shared with the treasure, key and "
          "exit sounds, which define their own, so it is defined again each "
          "time.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})

    # Missiles
    a.sub(0x70CA, "move_missiles", "Move the missiles",
          "Called by update_game each frame, after move_heroes and "
          "draw_objects and before update_monsters. Each of the twelve "
          "slots (three per hero, from 3 x hero) whose missile is in flight "
          "is erased from its cell, unless fired this frame and so still on "
          "its hero, and moved one cell in its direction (1-4: up, right, "
          "down, left). The new cell is then tried in turn. A wall spends "
          "the missile. A live monster takes its damage through monster_hit, "
          "which spends the missile and, for a kill, gives the firer a "
          "point; a monster already sparkling lets it through. The test for "
          "live is a sprite below the first sparkle, so a monster killed "
          "earlier in the frame (sprite blank until update_monsters runs) "
          "can be hit again. An energy drainer is worn down a stage, and "
          "removed after its last; the firer scores a point and the missile "
          "is turned round in the drainer's cell. Any hero in the cell, the "
          "firer included and whether in play or not, spends the missile, "
          "and lose_health_point takes its damage from a hero in play. "
          "Otherwise the missile is drawn in its new cell, pointing the way "
          "it flies.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x7747, "flip_firer_frame", "Animate the hero who fired a missile",
          "Toggle the animation frame of the hero whose missile is in slot X, "
          "so the hero's sprite changes as they throw. move_missiles calls "
          "this on a missile's first move, while bit 7 of its direction "
          "still marks it as just fired. The firer is told by the missile's "
          "sprite base: arrows the Ranger, fireballs the Magic-User, axes "
          "the Barbarian, and anything else the Fighter.",
          on_entry={"X": "missile slot"},
          on_exit={"A": "corrupted", "X": "preserved"})
    a.sub(0x76B1, "credit_missile_owner", "Give a point to the hero who fired a missile",
          "move_missiles calls this when a missile kills a monster and when "
          "it hits an energy drainer. The firer is told by the missile's "
          "sprite base, as in flip_firer_frame, and add_point gives them "
          "one point.",
          on_entry={"X": "missile slot"}, on_exit=X_KEPT)

    # The views
    a.sub(0x7788, "draw_all_views", "Draw all four views",
          "Draw the walls and doors of the room each hero's view shows, top "
          "left, top right, bottom left, bottom right. Called once as a "
          "level starts, after the view frames are drawn.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x752C, "show_hero_room", "Show the room a hero has moved into",
          "Point hero X's view at the room containing their cell and redraw "
          "that view. Each hero has a fixed view (0 top left to 3 bottom "
          "right); view_room holds a pointer per view into room_walls, and "
          "only its low byte changes, to the room offset that test_wall "
          "leaves in map_ptr. move_heroes calls this when a hero steps into "
          "another room, and a teleporter jumps here after moving the hero.",
          on_entry=X_HERO, on_exit=X_KEPT)
    for addr, text in [
        (0x752C, "The hero's cell, for test_wall to find its room"),
        (0x753F, "Keep the hero number across the view draw"),
        (0x7540, "Hero x 2: their view's entry in view_room..."),
        (0x7541, "...two bytes, a pointer into room_walls"), (0x7542, "The room's offset that test_wall left..."), (0x7544, "...becomes the view's room"),
        (0x7547, "Redraw this hero's own view: hero 0's?"),
    ]:
        a.c(addr, text)
    a.sub(0x7795, "draw_view_0", "Draw the top-left view",
          "Draw the room in hero 0's view, the Ranger's, whose top-left is "
          "byte column 1, pixel row 1. draw_all_views calls this as a level "
          "starts, and show_hero_room when hero 0 enters another room.",
           on_entry={"view_room": "the room hero 0 is in"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x77A7, "draw_view_1", "Draw the top-right view",
          "Draw the room in hero 1's view, the Magic-User's, whose top-left "
          "is byte column &23, pixel row 1. Called as draw_view_0 is.",
           on_entry={"view_room + 2": "the room hero 1 is in"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x77B9, "draw_view_2", "Draw the bottom-left view",
          "Draw the room in hero 2's view, the Barbarian's, whose top-left "
          "is byte column 1, pixel row &67. Called as draw_view_0 is.",
           on_entry={"view_room + 4": "the room hero 2 is in"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x77CB, "draw_view_3", "Draw the bottom-right view",
          "Draw the room in hero 3's view, the Fighter's, whose top-left is "
          "byte column &23, pixel row &67. Called as draw_view_0 is.",
           on_entry={"view_room + 6": "the room hero 3 is in"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x77DE, "draw_room", "Draw a room",
          "Draw the eight rows of walls of the room at &7B, &7C (a pointer "
          "into room_walls) with its top-left at plot_y and the column in "
          "cell_x, a wall block or a blank in every cell, then draw the "
          "doors. Nothing else in the room is drawn here. The doors go "
          "through plot_at_cell, so every door is drawn again in every view "
          "that shows its room, not just in this one.",
           on_entry={"map_ptr": "the room's offset in room_walls (the low byte)", "cell_x": "the view's left column", "plot_y": "the view's top pixel row"}, on_exit={"A": "corrupted", "X": "0", "Y": "corrupted"})
    a.sub(0x7820, "draw_room_row", "Draw one row of a room",
          "Plot a wall or a blank for each of the eight bits of scratch, "
          "four byte columns apart, starting at byte column cell_x.",
           on_entry={"scratch": "the row's eight wall bits, the leftmost cell in bit 7", "cell_x": "the view's left column", "plot_y": "the row's top pixel row"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x7852, "plot_at_cell", "Plot a sprite at a map cell in every view",
          "Plot sprite_number at map cell cell_x, cell_y, shifted by the "
          "pixel offsets in &7D, &7E, in each view that shows the cell's "
          "room. Cells are four byte columns wide and twelve pixel rows "
          "high. Heroes, monsters, missiles, objects, doors and trapdoors "
          "are all drawn and erased through here (the walls are not), so a "
          "cell in a room that two heroes share is drawn in both views, and "
          "one in a room that no view shows is not drawn at all. Only the "
          "low byte of each view_room entry is compared."
          "\n\n"
          "cell_x and cell_y are overwritten with the position within the "
          "room, so a caller that needs the map cell again sets them again.",
          on_entry={"cell_x": "map x", "cell_y": "map y",
                    "sprite_number": "sprite to plot",
                    "plot_offset_x": "byte columns to shift right",
                    "plot_offset_y": "pixel rows to shift down"},
          on_exit={"cell_x": "byte column within the room",
                   "cell_y": "pixel row within the room",
                   "cell_room": "the cell's room, as an offset into room_walls"})
    a.sub(0x78FC, "test_wall", "Test for a wall at a map cell",
          "Return the room_walls bit for cell cell_x, cell_y: non-zero if "
          "there is a wall. Also leaves &7B, &7C pointing at the cell's room. "
          "Heroes, missiles and monsters test the cell they are about to "
          "enter here; the magic and show_hero_room call it only for the "
          "room pointer. The bit is also stored in &8F, which no caller "
          "reads.",
          on_entry={"cell_x": "map x", "cell_y": "map y"},
          on_exit={"A": "wall bit", "Y": "wall bit", "Z": "set if no wall",
                   "X": "corrupted (the column within the room)",
                   "map_ptr": "the cell's room in room_walls"})
    a.sub(0x7938, "test_object_free", "Test whether a map cell can hold an object",
          "Return the object_free_map bit for cell cell_x, cell_y: zero if "
          "an object may lie there. The same calculation as test_wall, on "
          "object_free_map at &2100 instead of room_walls. A hero who has "
          "moved, and a missile, look up the object list only when this "
          "returns zero. The bit is also stored in &8F, which no caller "
          "reads.",
          on_entry={"cell_x": "map x", "cell_y": "map y"},
          on_exit={"A": "map bit", "Y": "map bit",
                   "Z": "set if an object may lie there",
                   "X": "corrupted (the column within the room)"})
    a.sub(0x7974, "find_creature", "Look for a monster or hero at a cell",
          "Look for a monster, other than monster number scratch, at cell_x, "
          "cell_y. If scratch is non-zero, also look for a hero there, and "
          "if one is found take hero_damage_taken points of their health."
          "\n\n"
          "A moving hero or missile passes scratch = 0, so only monsters "
          "are looked for. A moving or reappearing monster passes its own "
          "number, so it skips itself and also finds heroes: a monster "
          "that walks onto a hero hurts them and is blocked. "
          "Neither search looks at state: a dying monster still fills its "
          "cell, and a hero out of play (a skull) blocks a monster too, "
          "though lose_health_point takes nothing from them.",
          on_entry={"scratch": "the monster moving (1-30), or 0",
                    "cell_x": "map x", "cell_y": "map y"},
          on_exit={"A": "cell_y if a monster was found, 1 if a hero, else 0",
                   "Y": "cell_y if a monster was found, else 0",
                   "X": "the monster or hero found"})

    # Monsters
    a.sub(0x79C1, "update_monsters", "Draw the trapdoors and move the monsters",
          "Draw the eight trapdoors, then for each monster continue its step "
          "or start a new one, turning a random way when it is blocked, and "
          "advance dying monsters until they reappear at a trapdoor. The "
          "trapdoors are redrawn every frame, because erasing a creature "
          "or missile that has crossed one blanks its cell.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x7BEB, "start_monster_step", "Start a monster's step between cells",
          "Called by update_monsters as a monster starts a move. Set "
          "monster X's step counter to 3 and its offsets to the first "
          "quarter of a cell in the direction it faces: 3 rows up or down, "
          "or one byte column left or right.",
          on_entry={"X": "monster number"}, on_exit={"X": "preserved"})
    a.sub(0x7C2B, "continue_monster_step", "Continue a monster's step between cells",
          "Called by update_monsters each frame while monster X's step is "
          "under way. Toggle its frame and count down its step. On the "
          "first two calls, grow the offsets by another quarter of a cell "
          "(a byte column or three rows), to a half and three quarters. On "
          "the third the step ends: the monster moves one cell on and its "
          "offsets are cleared. A monster so crosses a cell in four frames.",
          on_entry={"X": "monster number"}, on_exit={"X": "preserved"})

    # Keyboard
    a.sub(0x7C95, "test_key", "Test whether a key is pressed",
          "Scan the key whose negative INKEY number is in A with OSBYTE &81 "
          "(Y = &FF), which returns X = Y = &FF if it is held. move_heroes "
          "uses it for each hero's direction and fire keys, and "
          "check_magic for the magic keys.",
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
          "and duration): the bell is what sounds when a hero fires. Then "
          "save the MOS's WRCHV in saved_wrchv, for start_level to put back "
          "while it sends the view frames' PLOT commands, and point WRCHV "
          "at wrch_handler, so that the game's text is printed in its own "
          "font. The code here is run once only: from &0D40 its "
          "bytes are then reused as the missile tables and other workspace "
          "in page &0D, which reset_workspace refreshes for each level. It "
          "does not return: it starts a new game.")
    a.c(0x0D31, "OSBYTE &D3: bell channel...")
    a.c(0x0D33, "...&11: channel 1 in its low bits")
    a.c(0x0D37, "Set it: the firing bell sounds on channel 1")
    a.c(0x0D3A, "OSBYTE &D4: bell envelope...")
    a.c(0x0D3C, "...0, a fixed amplitude")
    a.c(0x0D40, "Set it: BEL plays at a fixed amplitude")
    a.c(0x0D43, "OSBYTE &D5: bell pitch...")
    a.c(0x0D45, "...&64")
    a.c(0x0D49, "Set it: BEL plays at pitch &64")
    a.c(0x0D4C, "OSBYTE &D6: bell duration...")
    a.c(0x0D4E, "...1")
    a.c(0x0D52, "Set it: BEL lasts a twentieth of a second")
    a.c(0x0D55, "Save the MOS's WRCHV...")
    a.c(0x0D58, "...low byte...")
    a.c(0x0D5B, "...high byte...")
    a.c(0x0D5E, "...in saved_wrchv, for drawing the view frames")
    a.c(0x0D61, "Point WRCHV at wrch_handler, the game's font...")
    a.expr(0x0D62, lo(sym("wrch_handler")))
    a.expr(0x0D67, hi(sym("wrch_handler")))
    a.c(0x0D63, "...low byte...")
    a.c(0x0D66, "...high byte...")
    a.c(0x0D68, "...stored: text now goes through it")
    a.label(0xD9CD, "mos_reset_entry", group="mos_internals", description=(
        "MOS 1.20 reset entry, the target of the RESET vector. Called "
        "directly to reset the machine."))


def annotate_level_check(a: Annotator) -> None:
    """&0450-&04A9: the level decrypt-and-check routine and its table, in
    the official disc release and the sideways RAM hack."""
    a.expr(0x0457, hi(sym("level_object_x")))
    a.expr(0x046E, lo(sym("level_file_end")))
    a.expr(0x0474, hi(sym("level_file_end")))
    a.sub(0x0450, "decrypt_level", "Decrypt and check the level just loaded",
          "Decrypt the level at &6B00-&6DAF in place, XORing each byte with "
          "the low byte of its own address, and sum the decrypted bytes. If "
          "the sum does not match the level's entry in level_checksums, "
          "reset the machine, so a damaged or altered level file is never "
          "played. It runs once the level file is in memory. The pointer and the sum borrow the plotter's zero-page "
          "workspace (plot_x and plot_y, sprite_width).",
          on_entry={"level_number": "level loaded (1-25)"})
    for addr, name in [
        (0x045A, "decrypt_level_loop"),
        (0x046B, "decrypt_level_next"),
        (0x0484, "decrypt_level_done"),
    ]:
        a.label(addr, name)
    a.c(0x0450, "Point at &6B00, the start of the level...")
    a.c(0x0452, "...low byte 0, in plot_x (the pointer's low half)")
    a.c(0x0454, "Checksum 0, kept in sprite_width")
    a.c(0x0456, "High byte &6B: the level buffer's page")
    a.c(0x0458, "...in plot_y (the pointer's high half)")
    a.c(0x045A, "Fetch a level byte...")
    a.c(0x045C, "...XOR it with the low byte of its address...")
    a.c(0x045E, "...and store it back decrypted")
    a.c(0x0460, "Add the decrypted byte to the checksum...")
    a.c(0x0461, "...plus the sum so far")
    a.c(0x0463, "...modulo 256")
    a.c(0x0465, "Next byte...")
    a.c(0x0467, "No carry: same page")
    a.c(0x0469, "...with carry into the high byte")
    a.c(0x046B, "Stop at &6DB0, the end of the level...")
    a.c(0x046D, "...low byte &B0?")
    a.c(0x046F, "No: decrypt the next byte")
    a.c(0x0471, "...and high byte &6D?")
    a.c(0x0473, "...(the end page)")
    a.c(0x0475, "No: decrypt the next byte")
    a.c(0x0477, "X = the level just loaded (1-25)")
    a.c(0x047A, "Compare the checksum...")
    a.c(0x047C, "...with this level's entry in the table")
    a.c(0x047F, "Match: the level is intact; return")
    a.c(0x0481, "No match: reset the machine (a MOS 1.20 address)")
    a.c(0x0484, "Return")
    a.index_base(0x0490, "level_checksums", group="game_data", description=(
        "The expected sum of each decrypted level, for levels 1-25 at "
        "level_checksums+1 to level_checksums+25."))
    a.byte(0x0491, 25, cols=5)
    a.c(0x0491, "Levels 1-25, five to a row")
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
             "Twenty five-byte VDU 25 commands (plot code, then x and y as "
             "16-bit words) sent by draw_view_frames, five for each view's "
             "frame: PLOT 4 moves to the top-left corner, three PLOT 1s draw "
             "relative lines down 388, right 520 and up 388, and PLOT 5 "
             "draws back to the corner. The corners are (8,1022), "
             "(552,1022), (8,614) and (552,614); the second frame's first "
             "line is 389 long.")
    a.sub(0x1400, "start_level", "Set up and draw a new level",
          "Called by the level loop for each level. Prepare the text area, "
          "get the level file at &6B00 decrypted and checked, unpack it into "
          "the game's tables, reset page &0D and the monsters, then clear "
          "the screen, set the 6845 to show all 25 character rows the play "
          "screen uses, and draw the view frames and the four views.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.c(0x1400, "Prepare the text area for the new level")
    a.c(0x1403, "Get the level file at &6B00 decrypted and checked")
    a.c(0x1406, "Copy its objects, doors, keys and maps into play")
    a.c(0x1409, "Put the heroes, missiles and views back to the start")
    a.c(0x140C, "Monsters to the trapdoors; heroes carry no keys")
    a.c(0x140F, "Clear the screen, LEVEL and all, for the play screen")
    a.c(0x1412, "VDU 23,0,6,25,0,0,0,0,0,0: set 6845 register 6...")
    a.c(0x1414, "Send VDU 23")
    a.c(0x1417, "0: a 6845 register setting follows")
    a.c(0x141C, "Register 6: character rows displayed")
    a.c(0x1421, "...to 25: the views and panel fill rows 0-24")
    a.c(0x1426, "Six zero bytes complete the VDU 23")
    a.c(0x143A, "(plot_x) points at the frames' PLOT commands...")
    a.expr(0x143B, lo(sym("view_frame_plots")))
    a.expr(0x143F, hi(sym("view_frame_plots")))
    a.c(0x143E, "...high byte...")
    a.c(0x1442, "Draw the four frames, then the room in each view")
    a.c(0x1445, "Return to the level loop to draw the panel and play")


def annotate_cassette_level_loop(a: Annotator) -> None:
    """&0E14-&0ECE and &15B1-&1619: the level loop and level display of the
    crack and the sideways RAM hack, which derive from the cassette."""
    a.label(0x16D5, "level_filename_digits", description=(
        "Where the level number's digits are written into the level's "
        "filename."))
    for addr, name in [(0x0E00, "new_game"), (0x0E34, "two_level_digits"),
                       (0x0E36, "store_level_units"),
                       (0x0E52, "end_level_filename")]:
        a.label(addr, name)
    a.label(0x0E14, "level_loop")
    a.block(0x0E14, "Play each level in turn until every hero is dead.")
    a.c(0x0E14, "Monsters' hit points: 8 + 2 x levels already played...")
    a.c(0x0E17, "...x 2...")
    a.c(0x0E18, "...(carry clear for the add)")
    a.c(0x0E19, "...+ 8...")
    a.c(0x0E1B, "...for every monster on this level")
    a.c(0x0E1E, "Count the level in decimal, for its filename...")
    a.c(0x0E1F, "...(carry clear for the add)")
    a.c(0x0E20, "...the BCD count...")
    a.c(0x0E23, "...+ 1...")
    a.c(0x0E25, "...stored")
    a.c(0x0E28, "Back to binary arithmetic")
    a.c(0x0E29, "Filename digits: two once 9 levels are played")
    a.c(0x0E2C, "...(show_level_number counts level_number later)")
    a.c(0x0E2E, "Yes: two digits")
    a.c(0x0E30, "X = 0: one digit")
    a.c(0x0E34, "X = 1: two digits")
    a.c(0x0E36, "Units digit...")
    a.c(0x0E39, "...its low nibble...")
    a.c(0x0E3B, "...as ASCII...")
    a.c(0x0E3C, "...+ '0'...")
    a.c(0x0E3E, "...as the name's last digit")
    a.c(0x0E41, "Two digits?")
    a.c(0x0E43, "No: terminate the name")
    a.c(0x0E45, "Yes: the tens digit...")
    a.c(0x0E48, "...high nibble: first shift down...")
    a.c(0x0E4C, "...as ASCII...")
    a.c(0x0E4D, "...+ '0'...")
    a.c(0x0E4F, "...as the name's first digit")
    a.c(0x0E52, "Terminate the filename with a carriage return")
    a.c(0x0E54, "...after the last digit")
    a.c(0x0EC3, "Wait up to 6000 centiseconds (60 s) for a key...")
    a.c(0x0EC5, "...&1770 centiseconds: X low, Y high")
    a.c(0x0EC7, "OSBYTE &81: read a key within that time")
    a.c(0x0EC9, "A key, or the time running out, ends the message")
    a.c(0x0ECC, "...then start a new game")

    a.sub(0x15B1, "show_level_number", "Show the number of the level about to start",
          "Called first by start_level. Clear the screen, count the level "
          "in level_number (level_loop has already counted level_bcd), plot "
          "the LEVEL sprite at byte column 27, pixel row 40, and print the "
          "two BCD digits after it in colour 6 through wrch_handler, so in "
          "the game's font; levels 1-9 show a leading 0. Then set a text "
          "window over columns 1-14, rows 17-22, and colour 2: the setting "
          "in force while the level loads, until start_level clears the "
          "screen again.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.c(0x15B1, "Clear the screen for the level-number display")
    a.c(0x15B4, "COLOUR 6...")
    a.c(0x15B9, "Colour 6: the level number's colour")
    a.c(0x15BE, "Count the level in level_number, 1-25")
    a.c(0x15C1, "Plot the word LEVEL...")
    a.c(0x15C5, "...pixel row 40, character row 5...")
    a.c(0x15C9, "...the word LEVEL's sprite...")
    a.c(0x15CD, "Plot it, 12 bytes wide, 8 rows high")
    a.c(0x15D0, "TAB(10,5)...")
    a.c(0x15D5, "Column 10: byte column 40, just past LEVEL's 27-38")
    a.c(0x15DA, "...row 5: level with LEVEL")
    a.c(0x15DF, "The level in BCD, tens digit first...")
    a.c(0x15E2, "Keep the BCD level for the units")
    a.c(0x15E3, "Shift the tens digit...")
    a.c(0x15E8, "Make it an ASCII digit, '0' for levels 1-9")
    a.c(0x15EA, "Print it; wrch_handler draws it in the game's font")
    a.c(0x15ED, "Print the units digit...")
    a.c(0x15EE, "Keep only the units digit")
    a.c(0x15F1, "Make it an ASCII digit")
    a.c(0x15F3, "Print it after the tens")
    a.c(0x15F6, "VDU 28,1,22,14,17: the window used while loading...")
    a.c(0x1605, "Right column 14")
    a.c(0x160A, "...top row 17")
    a.c(0x1614, "...colour 2")
    a.c(0x1619, "Return to start_level to load the level")


def annotate_level_end(a: Annotator) -> None:
    """&0E57-&0EC2: playing a level and the game-over message, identical in
    every version apart from where the branches lead."""
    a.label(0x0F90, "game_over_message", description=(
        "The message printed when every hero has died, terminated by a zero "
        "byte."))
    a.label(0x0FEA, "game_over_you_all", description=(
        "The \"YOU ALL.\" line of game_over_message, whose bytes after the "
        "text double as panel_hero and count."))
    a.label(0x0FF1, "panel_hero", description=(
        "Hero counter for draw_status_panel. It is the full stop of "
        "game_over_message's \"YOU ALL.\", which is overwritten with a space "
        "before the message is printed."))
    a.label(0x0FF2, "count", description=(
        "Counter, used for the dead heroes at the end of a level and the "
        "rows of missile icons. It is a byte of game_over_message."))
    a.c(0x0E57, "Load and draw the level")
    a.c(0x0E5A, "Draw every hero's panel section")
    a.c(0x0E5D, "Take out the heroes nobody plays")
    a.c(0x0E60, "Vsync count 1: play_level's first wait is two vsyncs")
    a.c(0x0E62, "...counted down at each vertical sync")
    a.c(0x0E65, "Play until no hero is left in play")
    a.block(0x0E68, "The level is over. Reset every hero who died, and "
                    "end the game if all four did.")
    a.block(0x0E86, "Every hero is dead: print the game-over message over "
                    "the views, then wait for a key, or for the time limit, "
                    "before starting again.")
    a.c(0x0E68, "Count the dead, giving each their starting attributes")
    a.c(0x0E6A, "...none dead so far")
    a.c(0x0E6D, "Dead (heroes nobody plays count as dead)?")
    a.c(0x0E70, "...health tens one below 0?")
    a.c(0x0E72, "No: survived, so not reset")
    a.c(0x0E74, "Yes: start them afresh on the next level")
    a.c(0x0E77, "...and count them")
    a.c(0x0E7A, "Next hero")
    a.c(0x0E7B, "All four checked?")
    a.c(0x0E7D, "No: next hero")
    a.c(0x0E7F, "Any hero survived?")
    a.c(0x0E82, "...fewer than four dead?")
    a.c(0x0E84, "Yes: on to the next level")
    a.c(0x0E86, "All dead: VDU 28,0,24,16,0, a window over the views...")
    a.c(0x0E9F, "...VDU 12 to clear it")
    a.c(0x0EA4, "Spaces over &0FF1-&0FF4, two of them the counters")
    a.c(0x0EA6, "...a space")
    a.c(0x0EA8, "...into each (&0FF1 held YOU ALL's full stop)")
    a.c(0x0EAB, "Next byte down")
    a.c(0x0EAC, "Until all four are spaces")
    a.c(0x0EAE, "Print game_over_message...")
    a.c(0x0EB1, "...through OSASCI, so each CR starts a new line")
    a.c(0x0EB4, "Next character")
    a.c(0x0EB5, "...up to its zero byte")
    a.c(0x0EB7, "Not the end: next")
    a.c(0x0EB9, "Wait for the vsync counter, still running, to reach 0")
    a.c(0x0EBC, "Not yet: keep waiting")
    a.c(0x0EBE, "Flush the input buffers")
    a.c(0x0EC0, "Discard keys pressed during play")


BOOT_OSFILE_BLOCK = 0x6B00
BOOT_FILENAME_ADDR = 0x07F0


def declare_boot_osfile_block(d) -> None:
    """The control block the page &07 loader builds; once per driver."""
    d.constant(BOOT_OSFILE_BLOCK, "boot_osfile_block",
               comment="OSFILE control block built by boot_loader (in the level buffer)")


def annotate_page7_leftovers(a: Annotator, saved_as: str) -> None:
    """&0700-&073F of a &0400-&07FF image: what the development machine's
    line-input buffer held when the image was saved."""
    a.label(0x0700, "line_buffer_leftovers", group="leftovers", description=(
        "Leftover contents of the MOS 1.20 line-input buffer (&0700) from "
        "the machine the image was saved on."))
    a.banner(0x0700, "Leftovers in the line-input buffer",
             "Not used by the game. &0700 is the MOS 1.20 line-input buffer, "
             "and these bytes are what it held when this image was saved: the "
             f"command {saved_as}, then a fragment of BBC BASIC assembler "
             "(label+2:LDA#255:.label JSR&30).")


def annotate_boot_loader(a: Annotator, operand_note: str = "", sets_bytev: bool = False,
                         stored_call: int = 0x3000) -> None:
    """A loader left in page &07 of each &0400-&07FF image, at the
    execution address of the *SAVE command left in the line buffer. It
    loads the game file named at &07F0 to &2000 through FILEV and jumps
    there. Nothing in these releases runs it."""
    from dasmos.expr import hexlit, hi, lo, ref, sym

    block = sym("boot_osfile_block")
    entry = 0x0740
    start = entry + (10 if sets_bytev else 0)
    prelude = ("Point BYTEV at joystick_bytev (&0780), then build"
               if sets_bytev else "Build")
    a.sub(entry, "boot_loader", "Load the game file and run it (not used)",
          prelude + " an OSFILE control block at &6B00 naming boot_filename with "
          "load address &2000, call the filing system's FILEV handler to "
          "load the file, and jump to &2000. &0740 is the execution address "
          "in the *SAVE command left at &0700, so this is the image's own "
          "entry point when it is *RUN, but nothing in this release reaches "
          "it." + operand_note)
    call = start + 0x2C
    a.region(call, "boot_load_call", (0, 2))
    a.label(BOOT_FILENAME_ADDR, "boot_filename", group="leftovers",
            description="Name of the file boot_loader loads, CR-terminated.")
    a.expr(start + 0x01, lo(block))
    a.expr(start + 0x03, hi(block))
    a.expr(start + 0x05, lo(ref(BOOT_FILENAME_ADDR)))
    a.expr(start + 0x07, block)
    a.expr(start + 0x0A, hi(ref(BOOT_FILENAME_ADDR)))
    a.expr(start + 0x0C, block + 1)
    a.expr(start + 0x11, block + 2)
    a.expr(start + 0x14, block + 4)
    a.expr(start + 0x17, block + 5)
    a.expr(start + 0x1C, block + 3)
    a.expr(start + 0x2D, hexlit(stored_call))
    a.expr(start + 0x30, hexlit(0x2000))
    if sets_bytev:
        a.expr(entry + 0x01, lo(ref(0x0780)))
        a.expr(entry + 0x06, hi(ref(0x0780)))
    for offset, text in [
        (0x00, "X/Y = &6B00, the control block..."),
        (0x02, "...high byte"),
        (0x04, "Filename address: boot_filename..."),
        (0x06, "...into the block's filename pointer, low byte"),
        (0x09, "...boot_filename's high byte"),
        (0x0B, "...into the filename pointer's high byte"),
        (0x0E, "Load address &00002000..."),
        (0x10, "...load address byte 0 = 0"),
        (0x13, "...byte 2 = 0"),
        (0x16, "...byte 3 = 0"),
        (0x19, "...byte 1 = &20"),
        (0x1B, "...so the file loads at &00002000"),
        (0x1E, "Copy FILEV into the JSR below..."),
        (0x21, "...FILEV low byte into the JSR's operand"),
        (0x24, "...FILEV high byte"),
        (0x27, "...so the JSR calls the filing system directly"),
        (0x2A, "OSFILE &FF: load the file at the block's address"),
        (0x2C, "Call FILEV (operand patched above)"),
        (0x2F, "Enter the loaded game at &2000"),
    ]:
        a.c(start + offset, text)
    if sets_bytev:
        for offset, text in [
            (0x00, "BYTEV = &0780, joystick_bytev..."),
            (0x02, "...joystick_bytev's low byte into BYTEV"),
            (0x05, "...its high byte"),
            (0x07, "...so INKEY scans reach the joystick handler"),
        ]:
            a.c(entry + offset, text)
    a.banner(BOOT_FILENAME_ADDR, "Name of the file boot_loader loads")


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
        (0x0ECF, "Starting missile limit..."), (0x0ED2, "...as hero X's missile limit"),
        (0x0ED5, "...missile damage..."), (0x0ED8, "...as their missile damage"),
        (0x0EDB, "...and health lost per hit"), (0x0EDE, "...as their health lost per hit"),
        (0x0EE1, "Score 0000..."), (0x0EE3, "...thousands..."), (0x0EE6, "...hundreds..."), (0x0EE9, "...tens..."),
        (0x0EEC, "...units one below 0: draw_status_panel adds a point"),
        (0x0EEE, "...as the units digit"),
        (0x0EF1, "No ten-thousands digit (&69, one below small 1)"), (0x0EF3, "...as the ten-thousands digit"), (0x0EF6, "Return"),

        (0x0EF7, "For each hero's section..."), (0x0EF9, "...starting with the Ranger's, at the top"),
        (0x0EFC, "X = this hero"),
        (0x0EFF, "Take a point from the template's 99 + 1: draws 99"),
        (0x0F02, "Add a point: draws the score (0000 if just reset)"),
        (0x0F05, "The hero's face (their facing-down sprite)..."),
        (0x0F08, "...at column &45, the panel's left..."), (0x0F0A, "...on the section's top row..."), (0x0F0C, "...plotted"),
        (0x0F0F, "Shield at column &4D, the section's top right"),
        (0x0F11, "...on the top row..."), (0x0F13, "...the shield sprite..."), (0x0F15, "...plotted"),
        (0x0F18, "Armour rating on the shield: 10 - health lost per hit"),
        (0x0F1B, "...(no borrow into the subtract)"), (0x0F1C, "...from &73, small digit 1 + 9..."), (0x0F1E, "...less the damage per hit"),
        (0x0F21, "...at column &4E..."), (0x0F23, "...row 2..."), (0x0F25, "...plotted on the shield"),
        (0x0F28, "Missile icons, one per missile allowed in flight..."),
        (0x0F2B, "...missile limit..."), (0x0F2E, "...x 2..."), (0x0F2F, "...(carry clear for the add)"), (0x0F30, "...+ limit: 3 rows per icon..."),
        (0x0F33, "...+ &10: the row after the last icon"), (0x0F35, "...(end row in count)"),
        (0x0F38, "...first icon at row &10, beside the health"), (0x0F3A, "Keep the row..."), (0x0F3B, "...on the stack"),
        (0x0F3C, "...at column &4B"), (0x0F3E, "...the missile icon..."), (0x0F40, "...plotted at row Y"),
        (0x0F43, "Recover the row..."), (0x0F44, "...(carry clear for the add)"), (0x0F45, "...3 rows down..."), (0x0F47, "...for the next icon"),
        (0x0F48, "Past the last icon's row?"), (0x0F4B, "No: plot another"),
        (0x0F4D, "Missile damage as a small digit, above the icons"),
        (0x0F50, "...the hero's missile damage..."), (0x0F53, "...(carry clear for the add)"), (0x0F54, "...+ &69: small digit 1 for damage 1"),
        (0x0F56, "...at column &4C..."), (0x0F58, "...row &0A..."), (0x0F5A, "...plotted"),
        (0x0F5D, "Next hero's section"), (0x0F60, "All four heroes drawn?"), (0x0F63, "...(four of them)"),
        (0x0F65, "No: the next hero"), (0x0F67, "Return"),

        (0x0F68, "Byte column from X"), (0x0F6A, "Sprite from A"),
        (0x0F6C, "Row = Y + this hero's panel row - 14..."),
        (0x0F6D, "...for the hero being drawn..."), (0x0F70, "...(carry clear for the add)"),
        (0x0F71, "...(read from workspace_template, which page &0D copies)"),
        (0x0F74, "...(no borrow into the subtract)"), (0x0F75, "...less 14..."), (0x0F77, "...is the plot row"),
        (0x0F79, "Plot it"), (0x0F7C, "Return"),

        (0x14A0, "Copy workspace_template to page &0D"),
        (0x14A2, "Byte of the starting values..."), (0x14A5, "...becomes page &0D's byte"), (0x14A8, "Next byte"), (0x14A9, "Until all 256 are copied: heroes back at the start"),
        (0x14AB, "Reset the exit animation and the trapdoor turn"),
        (0x14B9, "First monster emerges from trapdoor 0"),
        (0x14D6, "Return to start_level"),

        (0x14D7, "Restore the MOS's own WRCHV for the PLOT commands..."),
        (0x14DA, "...low byte..."), (0x14DD, "...high byte..."), (0x14E0, "...so the PLOTs draw lines, not the game's font"),
        (0x14E3, "Twenty PLOT commands: five for each view's frame"),
        (0x14E5, "VDU 25..."), (0x14E7, "Send VDU 25: a PLOT command follows"),
        (0x14EA, "...then the five bytes of the command"),
        (0x14EC, "Next byte of this PLOT: K, then X and Y"), (0x14EE, "Send it to the VDU drivers"), (0x14F1, "Next byte"), (0x14F2, "All five sent?"),
        (0x14F4, "No: send the next"),
        (0x14F6, "Next command"), (0x14F7, "...pointer..."), (0x14F9, "...moves on five bytes..."),
        (0x14FB, "...to the next PLOT (the table is all in one page)"), (0x14FD, "Start the next PLOT at its first byte"),
        (0x14FF, "Count the PLOT done"), (0x1500, "Until all twenty are drawn"),
        (0x1502, "Draw each hero's room inside their frame"),
        (0x1505, "Point WRCHV back at wrch_handler..."),
        (0x1507, "...low byte..."), (0x150A, "...high byte..."), (0x150C, "...so text is drawn in the game's font again"), (0x150F, "Return"),

        (0x1510, "Objects 30 to 1: position and type"),
        (0x1524, "Next object down"), (0x1525, "Until object 1 is done (entry 0 is unused)"),
        (0x1527, "Doors 20 to 1: position and sprite"),
        (0x153B, "Next door down"), (0x153C, "Until door 1 is done"),
        (0x153E, "Keys 20 to 1: position"),
        (0x154C, "Next key down"), (0x154D, "Until key 1 is done"),
        (0x154F, "Trapdoors 0 to 7: where dead monsters come back"),
        (0x155D, "Next trapdoor"), (0x155E, "All eight done?"), (0x1560, "No: copy the next"),
        (0x1562, "Wall map and object-free map, &C9 bytes each"),
        (0x1570, "Next byte"), (0x1571, "Both maps copied?"), (0x1573, "No: copy the next"),
        (0x1575, "The level's own wall block, &30 bytes"),
        (0x157D, "Next byte"), (0x157E, "All 4 x 12 bytes copied?"), (0x1580, "No: copy the next"), (0x1582, "Return"),

        (0x1583, "Monsters 30 to 1..."),
        (0x1585, "...dying, so that they emerge from the trapdoors..."),
        (0x1587, "...as monster X's sprite..."),
        (0x158A, "...off the map..."), (0x158C, "...as monster X's x..."),
        (0x158F, "...with this level's hit points"), (0x1592, "...as monster X's hit points"),
        (0x1595, "Next monster down"), (0x1596, "Until monster 1 is done"),
        (0x1598, "Each hero: clear queue place, key carried, door cell"),
        (0x15AB, "Next hero"), (0x15AC, "All four done?"), (0x15AE, "No: clear the next"), (0x15B0, "Return to start_level"),
    ]:
        a.c(addr, text)


def annotate_core_comments(a: Annotator) -> None:
    """Inline comments for the core primitives."""
    C = a.c
    # plot_at_cell
    for addr, text in [
        (0x7852, "Room = (cell_y AND &F8) x 4 + (cell_x AND &F8)..."),
        (0x7855, "...the room's top row of cells (y AND &F8)"), (0x7857, "...kept to multiply..."), (0x785A, "...(no carry into the sum)"), (0x785B, "...x 2..."),
        (0x785E, "...x 3..."), (0x7861, "...x 4: a room row is 32 bytes of room_walls"), (0x7864, "...where its row of rooms starts, so far"),
        (0x7867, "Add the room's left column of cells..."), (0x786A, "...cell_x AND &F8: 8 bytes per room across"), (0x786C, "...giving the room's offset in room_walls"),
        (0x786F, "...in cell_room, to match against the views"),
        (0x7872, "Column within the view = (cell_x AND 7) x 4 + offset_x"),
        (0x7875, "...the cell's column within its room..."), (0x7877, "...x 2..."), (0x7878, "...x 4: each cell is 4 screen bytes wide"), (0x7879, "...(no carry)"),
        (0x787A, "...plus the sprite's offset in byte columns"), (0x787C, "...replacing cell_x: the map x is lost"),
        (0x787F, "Row within the view = (cell_y AND 7) x 12 + offset_y"),
        (0x7882, "...the cell's row within its room..."), (0x7884, "...x 2..."), (0x7885, "...x 4..."), (0x7886, "...kept..."),
        (0x7889, "...x 8..."), (0x788A, "...(no carry)"), (0x788B, "...+ x 4 = x 12: each cell is 12 rows tall"), (0x788E, "...plus the sprite's offset in pixel rows"),
        (0x7890, "...replacing cell_y: the map y is lost"),
        (0x7893, "The Ranger's view (top left): this room?"),
        (0x7896, "...is it the room of the cell?"), (0x7899, "Not shown there: try the top-right view"),
        (0x789B, "Shown: plot at the view's corner (column 1, row 1)..."),
        (0x789C, "...view's left column, 1..."), (0x789E, "...plus the column within the room"), (0x78A1, "...as the screen column"), (0x78A3, "...view's top row, 1..."),
        (0x78A5, "...plus the row within the room"), (0x78A8, "...as the screen row"), (0x78AA, "Draw it in the top-left view"),
        (0x78AD, "The Magic-User's view (top right): this room?"),
        (0x78B0, "...is it the room of the cell?"), (0x78B3, "Not shown there: try the bottom-left view"),
        (0x78B5, "Shown: plot from column &23, row 1"),
        (0x78C7, "The Barbarian's view (bottom left): this room?"),
        (0x78CA, "...is it the room of the cell?"), (0x78CD, "Not shown there: try the bottom-right view"),
        (0x78CF, "Shown: plot from column 1, row &67"),
        (0x78E1, "The Fighter's view (bottom right): this room?"),
        (0x78E4, "...is it the room of the cell?"), (0x78E7, "Not shown there: done"),
        (0x78E9, "Shown: plot from column &23, row &67"),
        (0x78FB, "Return"),
        # test_wall
        (0x78FC, "Room offset = (cell_y AND &F8) x 4 + (cell_x AND &F8)..."),
        (0x790E, "...low byte of the pointer"),
        (0x7919, "...into room_walls at &0C00"),
        (0x791B, "...as the pointer's high byte"),
        (0x791D, "Bit for the column within the room"),
        (0x7920, "...cell_x AND 7..."), (0x7922, "...indexes bit_masks..."), (0x7923, "...for the cell's bit, leftmost bit 7"), (0x7926, "...kept in scratch"),
        (0x7929, "Byte for the row within the room"),
        (0x792C, "...cell_y AND 7..."), (0x792E, "...indexes the room's bytes"),
        (0x792F, "Isolate the cell's bit..."),
        (0x7931, "...with the column's mask: non-zero if a wall"),
        (0x7934, "...a copy in &8F, which no caller reads..."),
        (0x7936, "...and in Y, so callers can pull X and test Y"),
        (0x7937, "Return"),
        # test_object_free
        (0x7938, "Room offset = (cell_y AND &F8) x 4 + (cell_x AND &F8)..."),
        (0x794A, "...low byte of the pointer"),
        (0x7955, "...into object_free_map at &2100"),
        (0x7957, "...as the pointer's high byte"),
        (0x7959, "Bit for the column within the room"),
        (0x7965, "Byte for the row within the room"),
        (0x796B, "Isolate the cell's bit..."),
        (0x7970, "...a copy in &8F, which no caller reads..."),
        (0x7972, "...and in Y, which callers test after pulling X"),
        (0x7973, "Return"),
        # find_creature
        (0x7974, "Monsters 30 to 1, alive or dying..."),
        (0x7976, "...except the one being moved (scratch)"),
        (0x7979, "The mover itself: skip it"),
        (0x797B, "The cell's map x..."), (0x797E, "...this monster's x?"), (0x7981, "No: not this monster"),
        (0x7983, "...and its map y..."), (0x7986, "...this monster's y?"), (0x7989, "No: not this monster"),
        (0x798B, "Found: Y = A = cell_y, X = the monster"),
        (0x798C, "...so the caller sees the cell taken"),
        (0x798D, "Next monster"), (0x798E, "Until monster 1 is done"),
        (0x7990, "No monster. A monster moving (scratch > 0)?"),
        (0x7993, "No, a hero or missile: heroes don't count"),
        (0x7995, "Yes: look at heroes 0 to 3 too..."),
        (0x7997, "...the cell's map x..."), (0x799A, "...this hero's x?"), (0x799D, "No: not this hero"),
        (0x799F, "...and its map y..."), (0x79A2, "...this hero's y?"), (0x79A5, "No: not this hero"),
        (0x79A7, "Yes, in play or not: their armour sets the damage"),
        (0x79AA, "Keep the points still to take..."), (0x79AB, "...on the stack"), (0x79AC, "One point off the hero (none if out of play)"), (0x79AF, "Recover the points still to take..."),
        (0x79B0, "...into Y"), (0x79B1, "One point fewer to take"), (0x79B2, "Until the hero has taken them all"),
        (0x79B4, "Return A = 1 (Y = 0): a hero was there"),
        (0x79B6, "...so the monster is blocked or parked"),
        (0x79B7, "Next hero"), (0x79B8, "All four heroes checked?"), (0x79BA, "No: check the next"),
        (0x79BC, "Nothing there: return A = Y = 0"),
        (0x79BE, "...the cell is free of creatures"), (0x79C0, "Return"),
        # lose_health_point
        (0x7221, "Direction 0: out of play, dying or returning"),
        (0x7224, "In play: they can be hurt"),
        (0x7226, "Out of play: nothing to lose"),
        (0x7227, "Health down one: the units digit sprite"),
        (0x722A, "...and look at the new units digit"),
        (0x722D, "Gone below the 0 sprite?"),
        (0x722F, "No: the tens are untouched, redraw the health"),
        (0x7231, "Yes: units back to 9..."),
        (0x7233, "...so 30 becomes 29"),
        (0x7236, "...and borrow from the tens"),
        (0x7239, "...and look at the new tens digit"),
        (0x723C, "Below 0? The point was taken from 00"),
        (0x723E, "No: still alive, redraw the health"),
        (0x7240, "The hero has died: erase them..."),
        (0x7242, "...with the blank sprite..."),
        (0x7244, "...at their cell in every view showing it"),
        (0x7247, "...take them out of play..."),
        (0x7249, "...so they neither move nor take more harm"),
        (0x724C, "...and start the death animation:"),
        (0x724E, "...frame step +1: forwards to the skull..."), (0x7251, "...frame counter 1: the first step comes next frame"),
        (0x7254, "Queue them for a Cross: from the queue's front..."),
        (0x7256, "...look at this queue entry"), (0x7259, "Taken: try the next entry"), (0x725B, "Free: hero number..."), (0x725C, "...plus one..."),
        (0x725D, "...(entries are hero + 1, so 0 can mean free)..."), (0x725F, "...queued behind those already waiting"), (0x7262, "Return, health not redrawn"),
        (0x7263, "Next queue entry"), (0x7264, "Keep looking (an empty entry is always found)"),
        (0x7266, "Health on the top row of the hero's panel section..."),
        (0x7269, "...as the plotting row"), (0x726B, "Tens in the panel's left column..."), (0x726D, "...as the plotting column"), (0x726F, "The tens digit sprite..."),
        (0x7272, "...as the sprite to plot"), (0x7274, "Keep the hero number..."), (0x7275, "...across the plot"), (0x7276, "Plot the health's tens digit"),
        (0x7279, "Recover the hero number..."), (0x727A, "...into X"),
        (0x727B, "The units digit sprite..."),
        (0x727E, "...as the sprite to plot"), (0x7280, "...three byte columns right of the tens..."), (0x7282, "...on the same row"), (0x7284, "Keep the hero number..."),
        (0x7285, "...across the plot"), (0x7286, "Plot the health's units digit"), (0x7289, "Recover the hero number..."), (0x728A, "...into X"),
        (0x728B, "Return"),
        # add_point, add_ten_points
        (0x728C, "Score up one: the units digit sprite"),
        (0x728F, "...and look at the new units digit"), (0x7292, "Past the 9 sprite?"), (0x7294, "No: nothing to carry, redraw the score"),
        (0x7296, "Yes: units back to 0..."),
        (0x7298, "...and carry by falling into add_ten_points"),
        (0x729B, "Score up ten: the tens digit sprite"),
        (0x729E, "...and look at the new tens digit"), (0x72A1, "Past the 9 sprite?"), (0x72A3, "No: nothing to carry, redraw the score"),
        (0x72A5, "Yes: tens back to 0..."), (0x72A7, "...stored for this hero"),
        (0x72AA, "...and carry into the hundreds"),
        (0x72AD, "...and look at the new hundreds digit"), (0x72B0, "Past the 9 sprite?"), (0x72B2, "No: redraw the score"),
        (0x72B4, "Yes: hundreds back to 0..."), (0x72B6, "...stored for this hero"),
        (0x72B9, "...and carry into the thousands and beyond"),
        (0x72BC, "Score: all four digits, twelve rows below the health"),
        (0x72D4, "The hundreds digit sprite..."),
        (0x72E4, "The tens digit sprite..."),
        (0x72F4, "The units digit sprite..."),
        (0x7304, "Return"),
        # test_key
        (0x7C95, "Park the INKEY number in Y for a moment"),
        (0x7C96, "Keep the caller's X (the hero number)..."), (0x7C97, "...on the stack, as OSBYTE returns in X"), (0x7C98, "The INKEY number..."), (0x7C99, "...in X, as OSBYTE &81 wants it"),
        (0x7C9A, "OSBYTE &81 with Y = &FF: scan the key"),
        (0x7C9C, "Y = &FF: scan the one key, not wait"), (0x7C9E, "Scan it: X = Y = &FF if the hero's key is held"),
        (0x7CA1, "Held only if both Y and X come back &FF"),
        (0x7CA3, "Y not &FF: the key is up"), (0x7CA5, "X = &FF too?"), (0x7CA7, "No: the key is up"),
        (0x7CA9, "Held: the caller's X back from the stack..."),
        (0x7CAA, "...the hero number again"), (0x7CAB, "A = 0, Z set: the key is held"), (0x7CAD, "Return"),
        (0x7CAE, "Up: the caller's X back from the stack..."),
        (0x7CAF, "...the hero number again"), (0x7CB0, "A = 1, Z clear: the key is up"), (0x7CB2, "Return"),
        # draw_hero, get_hero_cell
        (0x7732, "The hero's map cell..."),
        (0x7735, "...and the pixel offsets of a step in progress"),
        (0x7738, "...across..."), (0x773A, "...and down..."), (0x773D, "...as plot_offset_y"),
        (0x773F, "Keep the hero number..."),
        (0x7740, "...on the stack: each plot leaves X = 0"), (0x7741, "Plot the hero in every view showing it"), (0x7744, "Recover the hero number..."), (0x7745, "...in X again for the caller"),
        (0x7746, "Return"),
        (0x777A, "cell_x = hero_x"), (0x777D, "...for the plotting and testing routines"),
        (0x7780, "cell_y = hero_y"), (0x7783, "...likewise"), (0x7786, "Return"),
        # draw views
        (0x7795, "Top-left view: pixel row 1..."), (0x7797, "...as the view's top pixel row"),
        (0x7799, "...byte column 1..."), (0x779B, "...in cell_x, as draw_room expects"),
        (0x779E, "...the room the Ranger's view shows"), (0x77A1, "...whose walls draw_room reads"),
        (0x77A3, "Draw its walls and doors"), (0x77A6, "Return"),
        (0x77A7, "Top-right view: pixel row 1..."), (0x77AB, "...byte column &23..."),
        (0x77B0, "...the room the Magic-User's view shows"), (0x77B5, "Draw its walls and doors"), (0x77B8, "Return"),
        (0x77B9, "Bottom-left view: pixel row &67..."), (0x77BD, "...byte column 1..."),
        (0x77C2, "...the room the Barbarian's view shows"), (0x77C7, "Draw its walls and doors"), (0x77CA, "Return"),
        (0x77CB, "Bottom-right view: pixel row &67..."), (0x77CF, "...byte column &23..."),
        (0x77D4, "...the room the Fighter's view shows"), (0x77D9, "Draw its walls and doors"), (0x77DC, "Return"),
        (0x77DE, "The room's walls are in page &0C"),
        (0x77E0, "...so map_ptr points at the room's wall bytes"),
        (0x77E2, "For each of the room's eight rows of cells..."),
        (0x77E4, "...take its eight wall bits..."),
        (0x77E6, "...in scratch for draw_room_row"), (0x77E9, "Keep the row number..."), (0x77EA, "...on the stack across the row"),
        (0x77EB, "...and draw the row's walls and blanks"),
        (0x77EE, "Twelve pixel rows down"),
        (0x77EF, "Down to the next row of cells..."), (0x77F1, "...each 12 pixel rows tall"), (0x77F3, "...ready for the next row"),
        (0x77F5, "Recover the row number..."), (0x77F6, "...into Y"), (0x77F7, "Next row"), (0x77F8, "All eight rows done?"),
        (0x77FA, "No: draw the next row"),
        (0x77FC, "Then doors 20 to 1, wherever they are on the map"),
        (0x781C, "Next door"), (0x781D, "Until door 1 is drawn"), (0x781F, "Return"),
        (0x7820, "Start at the view's left edge"),
        (0x7823, "...as the first cell's screen column"),
        (0x7825, "Bit mask, starting with the leftmost cell"),
        (0x7827, "Keep this cell's bit mask..."), (0x7828, "...on the stack..."), (0x7829, "...and in scratch2 for the test"),
        (0x782C, "Wall in this cell?"), (0x782F, "...against the row's wall bits"),
        (0x7832, "No: an open cell, blanked"),
        (0x7834, "Yes: plot the wall block (sprite 0)"),
        (0x7836, "...to plot"), (0x7838, "Draw the wall block in this cell"), (0x783B, "On to the next cell"),
        (0x783E, "Plot the blank (sprite &15)"),
        (0x7840, "...to plot"), (0x7842, "Clear whatever the view showed there"),
        (0x7845, "Four byte columns right"),
        (0x7846, "Next cell's screen column..."), (0x7848, "...four bytes, one cell's width, along"), (0x784A, "...stored for the next plot"),
        (0x784C, "Next bit..."), (0x784D, "...the mask moves to the next cell right"), (0x784E, "...into X; zero once the eighth cell is done"),
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



def _signed(value):
    return value - 256 if value >= 128 else value


def annotate_sound_block(a: Annotator, addr: int) -> None:
    """An OSWORD 7 block: channel, amplitude, pitch and duration words."""
    words = [a.word_value(addr + 2 * i) for i in range(4)]
    if None in words:
        return
    channel, amplitude, pitch, duration = words
    a.word(addr, 8, cols=4)
    flags = []
    if channel & 0x0F00:
        flags.append(f"synchronised with {(channel >> 8) & 3} other")
    if channel & 0x0010:
        flags.append("flush")
    if channel & 0x1000:
        flags.append("hold")
    level = (f"envelope {amplitude}" if 1 <= amplitude <= 16
             else f"volume {-_signed(amplitude & 0xFF)}")
    a.c(addr, f"SOUND channel {channel & 0x0F}"
        + (f" ({', '.join(flags)})" if flags else "")
        + f", {level}, pitch {pitch}, duration {duration}")


def annotate_envelope_block(a: Annotator, addr: int) -> None:
    """An OSWORD 8 block: the fourteen parameters of ENVELOPE."""
    values = [a.byte_value(addr + i) for i in range(14)]
    if None in values:
        return
    for offset, length, text in [
        (0, 1, f"Envelope {values[0]}"),
        (1, 1, f"Step length {values[1] & 0x7F} centisecond"
               + ("" if values[1] & 0x7F == 1 else "s")
               + (", no auto-repeat" if values[1] & 0x80 else "")),
        (2, 3, "Pitch change per step in sections 1-3: "
               + ", ".join(str(_signed(v)) for v in values[2:5])),
        (5, 3, "Steps in pitch sections 1-3: "
               + ", ".join(str(v) for v in values[5:8])),
        (8, 4, "Amplitude change per step in attack, decay, sustain, "
               "release: " + ", ".join(str(_signed(v)) for v in values[8:12])),
        (12, 2, f"Target levels at the end of attack and decay: "
                f"{values[12]}, {values[13]}"),
    ]:
        a.byte(addr + offset, length, cols=length)
        a.c(addr + offset, text)


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
        column, row = a.byte_value(addr), a.byte_value(addr + 1)
        a.byte(addr, 2, cols=2)
        if column is not None:
            a.c(addr, f"Column {column}, row {row}")
        a.stringcr(addr + 2)

    # The game-over message
    a.banner(0x0F90, "Game-over message",
             "Eleven lines of seventeen characters, each ended by a carriage "
             "return, then a line feed and a last line ended by a zero byte. "
             "Two bytes of it (&0FF1, &0FF2) double as counters, and are "
             "overwritten with spaces before printing, so the full stop after "
             "\"YOU ALL\" never appears.")
    addr = 0x0F90
    for _ in range(11):
        a.stringcr(addr)
        addr += 18
    a.byte(addr, 1)
    a.c(addr, "Line feed: a blank line")
    a.stringz(addr + 1)
    a.banner(0x1069, "Unused", "Leftover bytes: \"ND!\" and a zero, the end of "
             "an earlier message, then \"&C2\".")
    a.byte(0x1069, 0x1070 - 0x1069, cols=7)

    # Sound blocks
    for addr, name, is_envelope, use in SOUND_BLOCKS:
        kind = "OSWORD 8 (ENVELOPE)" if is_envelope else "OSWORD 7 (SOUND)"
        length = 14 if is_envelope else 8
        a.label(addr, name, length=length, group="sound", description=(
            f"{kind} parameter block for {use}."))
        if is_envelope:
            annotate_envelope_block(a, addr)
        else:
            annotate_sound_block(a, addr)

    # Sprite tables
    for addr in (0x1AE0, 0x1B58, 0x1BD0, 0x1C48):
        a.byte(addr, 120, cols=8)
    a.banner(0x1AE0, "Sprite tables",
             "Four tables of 120 entries, indexed by sprite number: data "
             "address low bytes, high bytes, widths in bytes and heights in "
             "rows.")

    # The heroes' magic keys
    a.inkey_number(0x0B24, 2)
    annotate_workspace_template(a)

    a.banner(0x7D00, "Workspace template",
             "The starting contents of page &0D for each level, copied there "
             "by reset_workspace: the heroes' starting positions, directions, "
             "keys (hero_key_up etc. at +&70), health of 99 + 1 (at +&90, "
             "+&95), the views' rooms (+&A0), sprite bases (+&B0, +&B5), bit "
             "masks (+&C0) and panel rows (+&D0).")



# Page &0D's variables, as workspace_template holds their starting values:
# (offset in the page, variable, length).
WORKSPACE_FIELDS = [
    (0x00, "scratch", 1), (0x01, "scratch2", 1), (0x02, "cell_x", 1),
    (0x03, "cell_y", 1), (0x04, "cell_room", 1), (0x06, "previous_x", 1),
    (0x07, "previous_y", 1), (0x08, "previous_offset_x", 1),
    (0x09, "previous_offset_y", 1), (0x10, "hero_x", 4), (0x15, "hero_y", 4),
    (0x1A, "hero_direction", 4), (0x20, "hero_frame", 4), (0x25, "hero_step", 4),
    (0x2A, "hero_offset_x", 4), (0x30, "hero_offset_y", 4),
    (0x40, "missile_x", 12), (0x4C, "missile_y", 12),
    (0x58, "missile_direction", 12), (0x64, "missile_sprite_base", 12),
    (0x70, "hero_key_up", 4), (0x74, "hero_key_down", 4),
    (0x78, "hero_key_right", 4), (0x7C, "hero_key_left", 4),
    (0x80, "hero_key_fire", 4), (0x90, "hero_health_tens", 4),
    (0x95, "hero_health_units", 4), (0xA0, "view_room", 8),
    (0xB0, "hero_missile_sprites", 4), (0xB5, "hero_sprites", 4),
    (0xBC, "hero_has_boots", 4), (0xC0, "bit_masks", 8),
    (0xD0, "hero_panel_y", 4), (0xFD, "teleport_last", 1),
    (0xFF, "victory_sprite_copy", 1),
]


WORKSPACE_NOTES = {
    "scratch": "scratch: working byte",
    "scratch2": "scratch2: working byte",
    "cell_x": "cell_x: set before use",
    "cell_y": "cell_y: set before use",
    "cell_room": "cell_room: set before use",
    "previous_x": "previous_x: set before use",
    "previous_y": "previous_y: set before use",
    "previous_offset_x": "previous_offset_x: set before use",
    "previous_offset_y": "previous_offset_y: set before use",
    "hero_x": "hero_x: the heroes start at x 11, 11, 12, 12...",
    "hero_y": "hero_y: ...and y 11, 12, 11, 12, the four cells of the start",
    "hero_direction": "hero_direction: facing up, right, down and left",
    "hero_frame": "hero_frame: frame 1",
    "hero_step": "hero_step: not stepping",
    "hero_offset_x": "hero_offset_x: no offset",
    "hero_offset_y": "hero_offset_y: no offset",
    "missile_x": "missile_x: unused while the slots are empty",
    "missile_y": "missile_y: unused while the slots are empty",
    "missile_direction": "missile_direction: every slot empty",
    "missile_sprite_base": "missile_sprite_base: set when a missile is fired",
    "hero_key_up": "hero_key_up: each hero's up key",
    "hero_key_down": "hero_key_down",
    "hero_key_right": "hero_key_right",
    "hero_key_left": "hero_key_left",
    "hero_key_fire": "hero_key_fire",
    "hero_health_tens": "hero_health_tens: 9...",
    "hero_health_units": "hero_health_units: ...9 + 1: health 99 once a point is taken",
    "view_room": "view_room: every view starts on the heroes' room, &0C28",
    "hero_missile_sprites": "hero_missile_sprites: arrows, fireballs, axes, swords",
    "hero_sprites": "hero_sprites: Ranger, Magic-User, Barbarian, Fighter",
    "hero_has_boots": "hero_has_boots: none",
    "bit_masks": "bit_masks: &80 down to &01",
    "hero_panel_y": "hero_panel_y: the four sections of the status panel",
    "teleport_last": "teleport_last: object &1E, the last",
    "victory_sprite_copy": "victory_sprite_copy: set before use",
}


def annotate_workspace_template(a: Annotator) -> None:
    """Lay out workspace_template as the page &0D variables it starts."""
    base = 0x7D00
    offset = 0
    for field_offset, name, length in WORKSPACE_FIELDS:
        if field_offset > offset:
            a.byte(base + offset, field_offset - offset, cols=8)
            a.c(base + offset, f"Copied to &{0x0D00 + offset:04X}: no variable "
                f"starts here")
        a.byte(base + field_offset, length, cols=min(length, 8))
        a.c(base + field_offset, WORKSPACE_NOTES.get(name, name))
        offset = field_offset + length
    if offset < 0x100:
        a.byte(base + offset, 0x100 - offset, cols=8)
    a.inkey_number(0x7D70, 0x14)
    # Starting values that are sprite numbers and a room address.
    for i, name in enumerate(("arrow_up", "fireball_up", "axe_up", "sword_up")):
        a.expr(0x7DB0 + i, sym(f"spr_{name}") - 1)
    for i, name in enumerate(("ranger_up_0", "magic_user_up_0", "barbarian_up_0", "fighter_up_0")):
        a.expr(0x7DB5 + i, sym(f"spr_{name}") - 1)
    for i in range(4):
        a.expr(0x7D90 + i, sym("spr_digit_9"))
        a.expr(0x7D95 + i, sym("spr_digit_9") + 1)
        a.expr(0x7DA0 + 2 * i, lo(sym("room_walls") + 0x28))
        a.expr(0x7DA1 + 2 * i, hi(sym("room_walls") + 0x28))


def annotate_hero_comments(a: Annotator) -> None:
    a.label(0x6EC1, "read_hero_keys")
    a.label(0x6F18, "fire_missile")
    a.label(0x6F79, "step_hero")
    a.label(0x7075, "erase_hero")
    a.label(0x7096, "draw_moved_hero")
    a.label(0x70C1, "next_hero")
    a.label(0x7619, "check_magic")
    for addr, text in [
        (0x6E97, "In play: keep the cell and offsets now drawn, to "
                 "erase the hero there and to put them back if blocked."),
        (0x6EC1, "Standing in a cell: the first held key of up, down, "
                 "right, left and fire decides what the hero does."),
        (0x6F18, "Fire: put a missile in the hero's first free slot, in "
                 "the hero's cell, flying the way the hero faces."),
        (0x6F6D, "Unreachable after the JMP: DEY and BNE find_missile_slot."),
        (0x6F79, "Move: try the next cell the way the hero faces. A wall "
                 "or closed door, a monster, or another hero in play "
                 "refuses it."),
        (0x7040, "The cell is free. A move into another room is made at "
                 "once, as is one with the Boots of Speed; otherwise the "
                 "hero is drawn half way and arrives on the next frame."),
        (0x7075, "Erase the hero's image from where it was drawn last."),
        (0x7096, "Draw the hero, then pick up any object in their cell."),
    ]:
        a.block(addr, text)
    for addr, text in [
        (0x6E80, "Hero 0, the Ranger, first"),
        (0x6E82, "A direction (1, 3, 5, 7) means the hero is in play"),
        (0x6E85, "In play: remember where they are, then move them"),
        (0x6E87, "Out of play: why? The step says"),
        (0x6E8A, "Step &63 marks a hero nobody plays"), (0x6E8C, "Not &63: the hero is dying or returning"),
        (0x6E8E, "Nobody plays them: nothing to move or draw"),
        (0x6E91, "Step the skull or resurrection animation"),
        (0x6E94, "Then on to the next hero"),
        (0x6E97, "Remember the hero's cell and offsets before moving"),
        (0x6E9A, "previous_x: where to put the hero back if blocked"), (0x6E9D, "The cell's y..."), (0x6EA0, "...in previous_y, for the same"), (0x6EA3, "The horizontal pixel offset now drawn..."),
        (0x6EA6, "...so erase_hero blanks the image where it is"), (0x6EA9, "And the vertical pixel offset..."), (0x6EAC, "...for the same erase"),
        (0x6EAF, "Half way between cells (step 1)?"),
        (0x6EB2, "No: standing in a cell, so read the keys"),
        (0x6EB4, "Yes: arrive in the next cell; no keys this frame"),
        (0x6EB7, "Erase the half-way image, draw the arrival"),
        (0x6EBA, "Hero 0 or 1 (the two with magic)?"),
        (0x6EBC, "Barbarian or Fighter: no magic, straight to the keys"), (0x6EBE, "Ranger or Magic-User: magic key, then back"),
        (0x6EC1, "Up key held? (directions beat fire, up first)"), (0x6EC4, "Z set if held"), (0x6EC7, "Not held: try down"),
        (0x6EC9, "Held: face up..."), (0x6ECB, "...direction 1: drawn as sprite base + 1 or + 2"),
        (0x6ECE, "...set the half-cell offsets for the step..."), (0x6ED1, "...and try the cell above"),
        (0x6ED4, "Down key held?"), (0x6ED7, "Z set if held"), (0x6EDA, "Not held: try right"),
        (0x6EDC, "Held: face down..."), (0x6EDE, "...direction 5: drawn as sprite base + 5 or + 6"),
        (0x6EE1, "...set the half-cell offsets for the step..."), (0x6EE4, "...and try the cell below"),
        (0x6EE7, "Right key held?"), (0x6EEA, "Z set if held"), (0x6EED, "Not held: try left"),
        (0x6EEF, "Held: face right..."), (0x6EF1, "...direction 3: drawn as sprite base + 3 or + 4"),
        (0x6EF4, "...set the half-cell offsets for the step..."), (0x6EF7, "...and try the cell to the right"),
        (0x6EFA, "Left key held?"), (0x6EFD, "Z set if held"), (0x6F00, "Not held: try fire"),
        (0x6F02, "Held: face left..."), (0x6F04, "...direction 7: drawn as sprite base + 7 or + 8"),
        (0x6F07, "...set the half-cell offsets for the step..."), (0x6F0A, "...and try the cell to the left"),
        (0x6F0D, "Fire key held? (only when no direction is)"), (0x6F10, "Z set if held"), (0x6F13, "Held: launch a missile the way the hero faces"),
        (0x6F15, "No key: the hero stands still, drawn in place"),
        (0x6F18, "Slots 3 x hero to 3 x hero + hero_max_missiles - 1"),
        (0x6F19, "Hero number kept to add..."), (0x6F1C, "...x 2..."), (0x6F1D, "...(no carry in)..."), (0x6F1E, "...+ hero: 3 x hero, the hero's first slot"),
        (0x6F21, "Y walks the hero's slots"), (0x6F22, "+ how many missiles the hero may have in flight..."), (0x6F25, "...the first slot past the hero's own"),
        (0x6F28, "This slot's missile still flying?"), (0x6F2B, "Yes: look at the hero's next slot"),
        (0x6F2D, "Free: missile direction = (hero direction + 1) / 2"),
        (0x6F30, "Hero direction 1, 3, 5 or 7..."), (0x6F31, "...+ 1..."), (0x6F33, "...halved: 1-4, up, right, down, left"), (0x6F34, "Bit 7: just fired, so not erased off the hero"),
        (0x6F36, "The slot is now in flight"),
        (0x6F39, "It starts in the hero's cell; move_missiles moves it on"),
        (0x6F3C, "...missile x = hero x..."), (0x6F3F, "...and the hero's y..."), (0x6F42, "...as missile y"),
        (0x6F45, "VDU 7..."),
        (0x6F47, "...the bell: the firing sound"),
        (0x6F4A, "The hero's current missile damage..."),
        (0x6F4D, "...goes with this missile, for whatever it hits"),
        (0x6F50, "The hero's weapon sprites (arrow, fireball, axe, sword)..."),
        (0x6F53, "...so it is drawn, and its owner known, by these"),
        (0x6F56, "Put back the cell remembered at the start..."),
        (0x6F59, "...the same cell: nothing has moved the hero here"), (0x6F5C, "And the y..."), (0x6F5F, "...likewise"),
        (0x6F62, "Next animation frame..."),
        (0x6F65, "...0 and 1 alternate..."), (0x6F67, "...so the hero is seen to throw"),
        (0x6F6A, "Draw the hero where they stand; no erase needed"),
        (0x6F70, "The hero's next slot"), (0x6F71, "Past the hero's last slot?"), (0x6F74, "No: is that one free?"),
        (0x6F76, "All the hero's missiles in flight: no shot"),
        (0x6F79, "Move the hero's cell in the direction faced: up..."),
        (0x6F7C, "Facing up?"), (0x6F7E, "No: try right"), (0x6F80, "Up: one row up the map"),
        (0x6F83, "...right..."), (0x6F85, "No: try down"), (0x6F87, "Right: one column along"),
        (0x6F8A, "...down..."), (0x6F8C, "No: try left"), (0x6F8E, "Down: one row down the map"),
        (0x6F91, "...left"), (0x6F93, "No: the cell is moved"), (0x6F95, "Left: one column back"),
        (0x6F98, "Record the cell tried, wall or not..."),
        (0x6F9B, "...so update_game finds a door the hero walks into"), (0x6F9E, "And the y tried..."), (0x6FA1, "...in hero_door_y"),
        (0x6FA4, "Is the cell tried a wall (or a closed door)?"),
        (0x6FA7, "cell_x: the cell for test_wall"), (0x6FAA, "And the y tried..."), (0x6FAD, "...in cell_y"), (0x6FB0, "Keep the hero number..."),
        (0x6FB1, "...on the stack across test_wall"), (0x6FB2, "Y = the cell's wall bit; map_ptr = its room"), (0x6FB5, "Recover the hero number..."), (0x6FB6, "...into X"),
        (0x6FB7, "Wall bit clear?"),
        (0x6FB9, "Clear: is a monster in the way?"),
        (0x6FBB, "A wall: the hero stays in the old cell..."),
        (0x6FBE, "...x back..."), (0x6FC1, "...and y back..."), (0x6FC4, "...so the hero does not enter the wall"),
        (0x6FC7, "The move is over: the hero stands in a whole cell"),
        (0x6FC9, "No step under way..."), (0x6FCC, "...no horizontal offset..."), (0x6FCF, "...and no vertical offset"),
        (0x6FD2, "Erase the old image, draw the hero in their cell"),
        (0x6FD5, "Is a monster in the cell tried?"),
        (0x6FD7, "scratch 0: look for monsters only, not heroes"), (0x6FDA, "Keep the hero number..."), (0x6FDB, "...on the stack across find_creature"), (0x6FDC, "Y non-zero if a monster is in the cell"),
        (0x6FDF, "Recover the hero number..."), (0x6FE0, "...into X"), (0x6FE1, "A monster there?"),
        (0x6FE3, "No: is another hero in the way?"),
        (0x6FE5, "Yes: the hero stays in the old cell..."),
        (0x6FFC, "...and pays a health point for walking into it"),
        (0x6FFF, "Erase the old image, draw the hero in their cell"),
        (0x7002, "Is another hero in play in the cell tried?"),
        (0x7005, "From hero 0"), (0x7007, "The moving hero itself?"), (0x700A, "Yes: skip it"),
        (0x700C, "Other hero's x..."), (0x700F, "...the cell tried's x?"), (0x7012, "No: not in the way"), (0x7014, "Other hero's y..."),
        (0x7017, "...the cell tried's y?"), (0x701A, "No: not in the way"), (0x701C, "There, but in play?"), (0x701F, "No (a skull, say): not in the way"),
        (0x7021, "In play there: the hero stays in the old cell..."),
        (0x703B, "Next hero"), (0x703C, "Checked all four?"), (0x703E, "No: check that one"),
        (0x7040, "The way is clear. Is the cell tried in another room?"),
        (0x7041, "Two bytes per view_room entry..."), (0x7042, "...so X = 2 x hero indexes the hero's view"), (0x7043, "The low byte of the room the hero's view shows..."), (0x7046, "...against the cell's room, left by test_wall"),
        (0x7048, "Same room: the boots decide the pace"),
        (0x704A, "New room: the hero arrives at once..."),
        (0x704B, "Halve the index..."), (0x704C, "...back to the hero number"), (0x704D, "Switch the hero's view to the new room and draw it"),
        (0x7050, "...and the move ends in the new cell, no half step"),
        (0x7053, "Wearing the Boots of Speed?"),
        (0x7054, "Halve the view index..."), (0x7055, "...back to the hero number"), (0x7056, "Non-zero while the hero wears the boots"),
        (0x7059, "No: a half step this frame"),
        (0x705B, "Yes: arrive in the cell at once, with no step"),
        (0x705D, "No horizontal offset..."), (0x7060, "...no vertical offset..."), (0x7063, "...and no step: one cell a frame, twice the pace"), (0x7066, "Erase the old position and draw the new"),
        (0x7069, "No boots: hero stays in the old cell, drawn half way"),
        (0x706C, "...by start_hero_step's offsets; next frame it arrives"), (0x706F, "And the old y..."), (0x7072, "...so others still meet the hero in the old cell"),
        (0x7075, "Erase the hero's image as it was before this frame"),
        (0x7077, "The blank sprite..."), (0x7079, "...at the hero's old cell..."), (0x707C, "...as the cell to plot at"), (0x707F, "And the old y..."),
        (0x7082, "...in cell_y"), (0x7085, "With the old pixel offsets too..."), (0x7088, "...across..."), (0x708A, "...and down..."),
        (0x708D, "...so a half-way image is blanked where it was"), (0x708F, "Keep the hero number..."), (0x7090, "...on the stack across plot_at_cell"), (0x7091, "Blank the hero in every view showing that cell"),
        (0x7094, "Recover the hero number..."), (0x7095, "...into X"),
        (0x7096, "Clear carry for the sprite sum"),
        (0x7097, "Still in play? A bump or magic's cost may have killed"), (0x709A, "Direction 0: out of play, not drawn"),
        (0x709C, "Sprite = direction + frame (0 or 1)..."),
        (0x709F, "...+ the hero's base: Ranger, Magic-User, and so on"), (0x70A2, "The sprite to draw"),
        (0x70A4, "Draw them in every view showing their cell"),
        (0x70A7, "Can the hero's cell hold an object?"),
        (0x70AA, "The hero's cell, to test for an object..."), (0x70AD, "And the hero's y..."), (0x70B0, "...in cell_y"), (0x70B3, "Keep the hero number..."),
        (0x70B4, "...on the stack across test_object_free"), (0x70B5, "Y zero if an object may lie in the cell"), (0x70B8, "Recover the hero number..."), (0x70B9, "...into X"),
        (0x70BA, "Can an object lie there?"),
        (0x70BC, "No: nothing to pick up; next hero"),
        (0x70BE, "Yes: pick up whatever is there"),
        (0x70C1, "Next hero"), (0x70C2, "All four heroes moved?"), (0x70C4, "Yes: done"),
        (0x70C6, "No: move the next hero"), (0x70C9, "Return to update_game"),

        (0x7619, "Count down this hero's magic key delay"),
        (0x761C, "Zero: time to look at the magic key"),
        (0x761E, "Not yet: RTS ends move_heroes; later heroes wait too"),
        (0x761F, "Delay 1: the key is read every frame from now on"),
        (0x7621, "...so the next press is seen at once"),
        (0x7624, "This hero's magic key, an INKEY number..."),
        (0x7627, "...scanned: Z set if held"),
        (0x762A, "Not held: read the movement and fire keys"),
        (0x762C, "Held: cast. Keep the hero number..."),
        (0x7642, "Ignore the key for the next three frames"),
        (0x7644, "...so one press casts only once"),
        (0x7647, "Health cost: 3 for the Magic-User..."),
        (0x7649, "Magic-User (hero 1): the cheaper rate"),
        (0x764B, "...6 for the Ranger"),
        (0x7650, "Magic-User: 3 points"),
        (0x7652, "Pay the cost one health point at a time"),
        (0x7653, "...the points left on the stack"), (0x7654, "One point off the caster, redrawn (it can kill them)"), (0x7657, "Recover the points left..."), (0x7658, "...into Y"),
        (0x7659, "One point fewer to take"), (0x765A, "Until the whole cost is paid"),
        (0x765C, "No monsters killed yet"),
        (0x765E, "...in magic_kill_count"),
        (0x7661, "The caster's view_room index, 2 x hero..."),
        (0x7662, "...x 2: view_room holds two bytes per hero"), (0x7663, "...kept in sprite_number, free as scratch here"),
        (0x7665, "For each monster, 30 to 1..."),
        (0x7667, "...find its room from its cell: map x..."),
        (0x766A, "...as cell_x..."), (0x766D, "...and map y..."), (0x7670, "...as cell_y"), (0x7673, "Keep the monster number..."),
        (0x7674, "...on the stack across test_wall"), (0x7675, "test_wall leaves the monster's room in map_ptr"), (0x7678, "Recover the monster number..."), (0x7679, "...into X"),
        (0x767A, "Y = the caster's view_room index"),
        (0x767C, "The room the caster's view shows..."), (0x767F, "...is it the monster's room?"), (0x7681, "Another room: the monster is spared"),
        (0x7683, "Alive? (dying ones are sprite &15 up)"), (0x7686, "Below the first death frame: alive"), (0x7688, "Already dying: not counted again"),
        (0x768A, "Alive: the first death frame, &15..."), (0x768C, "...and update_monsters plays out its death"),
        (0x768F, "...a kill to score"),
        (0x7692, "Next monster"), (0x7693, "Until monster 1 is done"),
        (0x7695, "One point for each monster killed"),
        (0x7697, "...halve the view_room index back to the hero"), (0x7698, "...X = the caster, who scores the points"), (0x7699, "...Y = the monsters killed"), (0x769C, "Any kills left to score?"),
        (0x769E, "None left: redraw the caster"), (0x76A0, "Keep the kills left..."), (0x76A1, "...on the stack across add_point"), (0x76A2, "One point to the caster"),
        (0x76A5, "Recover the kills left..."), (0x76A6, "...into Y"), (0x76A7, "One kill fewer to score"), (0x76A8, "Score the next"),
        (0x76AB, "No cast: read the movement and fire keys"),
        (0x76AE, "Cast: no move this frame; redraw the caster"),
    ]:
        a.c(addr, text)
    a.block(0x762C, "Cast the magic: play its sound, take the caster's "
            "health, then kill every live monster in the room the caster's "
            "view shows, a point each.")
    a.block(0x7665, "Kill every live monster in the caster's room. A monster "
            "parked off the map (&FF) is in no room and survives.")


def annotate_play_loop(a: Annotator) -> None:
    for addr, name, description in [
        (0x09F0, "exit_saved_x", "The exit's map x, kept while a hero goes down it."),
        (0x09F1, "exit_saved_y", "The exit's map y, kept while a hero goes down it."),
        (0x09F2, "exit_busy", "Non-zero while a hero is going down the exit."),
        (0x09F3, "exit_spin", "Direction (1, 3, 5, 7) of the hero spinning on the exit."),
        (0x09F4, "exit_shrinks_left", "Spins left before the hero has gone (4 to 1)."),
        (0x09F5, "exiting_hero", "The hero going down the exit."),
        (0x09FF, "shrunk_hero", "The hero whose sprites are shrunk, or &FF."),
        (0x09F7, "exit_offset_x_1", "exit_offsets_x entry 1."),
        (0x09F8, "exit_offset_x_2", "exit_offsets_x entry 2."),
        (0x09F9, "exit_offset_x_3", "exit_offsets_x entry 3."),
        (0x09FB, "exit_offset_y_1", "exit_offsets_y entry 1."),
        (0x09FC, "exit_offset_y_2", "exit_offsets_y entry 2."),
        (0x09FD, "exit_offset_y_3", "exit_offsets_y entry 3."),
        (0x09FE, "exit_offset_y_4", "exit_offsets_y entry 4."),
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
          "for each hero who left by the exit, and each of those runs one "
          "more frame before the next RTS; the last returns to the caller. "
          "Only one hero goes down the exit at a time: the exit is taken "
          "off the map until the animation ends.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    for addr, text in [
        (0x1F00, "Wait for the vertical sync counter to pass zero..."),
        (0x1F03, "Not yet negative: keep waiting"),
        (0x1F05, "...and set it for three syncs from now"),
        (0x1F07, "...in the MOS's vertical sync counter"),
        (0x1F0A, "On level 25: has a hero reached the Chalice?"),
        (0x1F0D, "Run a frame: heroes, keys, objects, monsters"),
        (0x1F10, "A hero going down the exit?"),
        (0x1F13, "Yes: the level goes on"),
        (0x1F15, "Is any hero in play, or still dying? Heroes 3 to 0"),
        (0x1F17, "In play (a direction set)?"),
        (0x1F1A, "Yes: the level goes on"),
        (0x1F1C, "Out of play: dead..."),
        (0x1F1F, "...(health tens digit below 0)..."), (0x1F21, "No: alive but out of play; next hero"),
        (0x1F23, "...with the death animation unfinished?"),
        (0x1F26, "...frame 8 is the last of the death"),
        (0x1F28, "Yes: the level goes on"),
        (0x1F2A, "Next hero"),
        (0x1F2B, "More heroes: check the next"),
        (0x1F2D, "The level is over: restore the last exiting hero's sprites"),
        (0x1F30, "None (&FF): nothing to restore"), (0x1F32, "Give them back their full-size sprites"),
        (0x1F35, "Return, perhaps into this loop at &1F8E"),
        (0x1F36, "Is a hero on the exit? From hero 0"),
        (0x1F38, "The hero's x..."), (0x1F3B, "...at the exit's x?"), (0x1F3E, "No: next hero"),
        (0x1F40, "...and y..."), (0x1F43, "...at the exit's y?"), (0x1F46, "No: next hero"),
        (0x1F48, "Yes: drop their key beside it"),
        (0x1F4B, "Take them out of play for the rest of the level"),
        (0x1F4D, "...so they are never animated..."), (0x1F50, "...and no direction..."), (0x1F52, "...so move_heroes skips them"),
        (0x1F55, "Erase them from the exit's cell"),
        (0x1F58, "...as cell_x..."), (0x1F5B, "...and the hero's y..."), (0x1F5E, "...in cell_y..."), (0x1F61, "...on the cell itself: no pixel offset..."),
        (0x1F63, "...horizontally..."), (0x1F65, "...or vertically..."), (0x1F67, "...with the blank sprite"), (0x1F69, "...as the sprite to plot"),
        (0x1F6B, "Keep the hero number..."), (0x1F6C, "...on the stack across plot_at_cell"), (0x1F6D, "Plot the blank in every view showing them"), (0x1F70, "Recover the hero number..."),
        (0x1F71, "...into X"),
        (0x1F72, "Move them off the map"),
        (0x1F74, "...x off the map, so nothing meets them"),
        (0x1F77, "Hide the exit while they go down it, keeping its position"),
        (0x1F7A, "...x saved..."), (0x1F7D, "...and its y..."), (0x1F80, "...saved too"), (0x1F83, "...then put the exit off the map..."),
        (0x1F85, "...x..."), (0x1F88, "...and y, so no other hero can enter it"),
        (0x1F8B, "Start the exit animation (which jumps back to play_level)"),
        (0x1F8E, "Reached by the RTS at the end of the level: one more frame"),
        (0x1F91, "Next hero"),
        (0x1F92, "All four heroes checked?"), (0x1F94, "No: check the next"),
        (0x1F96, "A hero going down the exit?"),
        (0x1F99, "Yes: draw this frame of the descent"),
        (0x1F9B, "No: next frame"),
        (0x1F9E, "Redraw the exit under the spinning hero"),
        (0x1FA1, "...on its cell: no pixel offset..."), (0x1FA3, "...horizontally..."), (0x1FA5, "...or vertically..."), (0x1FA7, "...at its saved x..."),
        (0x1FAA, "...as cell_x..."), (0x1FAD, "...and saved y..."), (0x1FB0, "...as cell_y..."), (0x1FB3, "...with the exit sprite..."),
        (0x1FB5, "...as the sprite to plot"), (0x1FB7, "Plot it in every view showing it"),
        (0x1FBA, "Turn the hero a quarter: up, right, down, left"),
        (0x1FBD, "...clear carry for the add"), (0x1FBE, "...from the current direction..."), (0x1FC1, "...two sprites on: the next direction..."), (0x1FC3, "...kept for the next frame"),
        (0x1FC6, "Past left (9): a full turn?"),
        (0x1FC8, "Yes: shrink the hero, showing just the exit"),
        (0x1FCA, "Plot the hero on the exit, centred for its current size"),
        (0x1FCB, "...the hero's sprite base..."), (0x1FCE, "...plus the direction's frame..."), (0x1FD1, "...as the sprite to plot"), (0x1FD3, "...on the exit's cell: its x..."),
        (0x1FD6, "...as cell_x..."), (0x1FD9, "...and its y..."), (0x1FDC, "...as cell_y"), (0x1FDF, "...with offsets for its size, by turns left..."),
        (0x1FE2, "...horizontal offset..."), (0x1FE5, "...as plot_offset_x..."), (0x1FE7, "...vertical offset..."), (0x1FEA, "...as plot_offset_y"),
        (0x1FEC, "Plot the hero in every view showing the exit"),
        (0x1FEF, "Next frame"),
        (0x1FF2, "Start the next turn from facing up"),
        (0x1FF4, "...-1, so the next frame's +2 gives 1"),
        (0x1FF7, "Fourth turn done?"),
        (0x1FFA, "Yes: the hero has gone; bring the exit back"),
        (0x1FFC, "Shrink sprites base + 1 to + 7: a byte narrower..."),
        (0x2023, "...three rows shorter. Next frame"),
        (0x2026, "Put the exit back where it was..."),
        (0x2029, "...x..."), (0x202C, "...and its saved y..."), (0x202F, "...as its y, so the next hero can use it"),
        (0x2032, "...and end the animation"),
        (0x2034, "...exit no longer busy"),
        (0x2037, "Next frame"),

        (0x203A, "Keep the hero number"),
        (0x203D, "Sound the exit; mark the hero queue"),
        (0x2040, "exit_offsets_x entry 0 = 4..."), (0x2042, "...never read: shrinks run from 4 down to 1"),
        (0x2045, "Restore the sprites of any hero shrunk before"),
        (0x2048, "None (&FF): go straight on"), (0x204A, "Give that hero back their full-size sprites"), (0x204D, "...then start this hero's spin"),
        (0x2076, "Start the animation for this hero..."),
        (0x2078, "...the exit is busy..."), (0x207B, "...the hero kept by hero_enters_exit..."), (0x207E, "...is the one going down..."), (0x2081, "...and the one whose sprites will shrink"),
        (0x2084, "...turning from the start..."), (0x2086, "...-1, so the first frame's +2 gives 1"),
        (0x2089, "...for four turns, shrinking after the first three"), (0x208B, "...as exit_shrinks_left"),
        (0x208E, "Back to play_level, leaving the JSR's return address"),
    ]:
        a.c(addr, text)


def annotate_missile_and_object_comments(a: Annotator) -> None:
    a.label(0x7130, "missile_spent_pop")
    a.label(0x7132, "missile_spent")
    a.label(0x7218, "next_missile")
    a.block(0x7266, "Draw hero X's health, two digit sprites on the top row of their "
                    "panel section. lose_health_point and the food reach it.")
    a.block(0x72BC, "Draw hero X's score, four digit sprites twelve rows below the "
                    "health.")
    a.block(0x73D9, "Y is the destination teleporter. The hero arrives on the cell "
                    "above it, whatever is there.")
    a.block(0x7429, "Bring back the first hero waiting in returning_hero_queue. &64 "
                    "markers, which stand for heroes left out on the menu, are passed "
                    "to the back of the queue.")
    a.block(0x7477, "Not treasure, food, a teleporter or the Cross: the exit, an energy "
                    "drainer or a magic item, told apart by type ranges alone.")
    a.block(0x74B6, "A magic item, type &5F or above. Each gives 10 points; the type "
                    "then picks boots, helmet, potion or weapons, and any other type "
                    "counts as a magic sword.")
    a.block(0x757C, "A missile has hit a live monster: X is the monster, Y the missile "
                    "slot. Reached by JMP from move_missiles, and leaves by jumping "
                    "back into it.")
    for addr, text in [
        (0x70E7, "Erase the missile and move it one cell."),
        (0x711D, "Try the new cell: wall, monster, energy drainer, then "
                 "hero. The slot stays on the stack through the tests."),
        (0x716F, "A missile hitting an energy drainer wears it down, "
                 "scores for the firer and turns round in its cell."),
        (0x71D9, "The first hero in the cell, in play or not, stops the "
                 "missile."),
    ]:
        a.block(addr, text)
    for addr, text in [
        # move_missiles
        (0x70CA, "Missiles move a whole cell a frame..."),
        (0x70CC, "...so they are plotted with no horizontal offset..."), (0x70CE, "...and no vertical offset"),
        (0x70D0, "Slot 0 first: the Ranger's first missile"),
        (0x70D2, "A direction means this slot's missile is flying"),
        (0x70D5, "Flying: erase and move it"),
        (0x70D7, "Empty slot: nothing to move"),
        (0x70DA, "Bit 7 clear: flying since an earlier frame"),
        (0x70DC, "Fired this frame: drop the just-fired bit..."),
        (0x70DE, "...leaving direction 1-4"),
        (0x70E1, "...flip the firer's animation frame again..."),
        (0x70E4, "...and move it unerased: its cell is the hero's"),
        (0x70E7, "Erase the missile from the cell it flew to last frame"),
        (0x70E9, "The blank sprite"), (0x70EB, "The missile's x..."), (0x70EE, "...as the cell to plot at"), (0x70F1, "And its y..."),
        (0x70F4, "...in cell_y"), (0x70F7, "Keep the missile slot..."), (0x70F8, "...on the stack across plot_at_cell"), (0x70F9, "Blank it in every view showing that cell"),
        (0x70FC, "Recover the missile slot..."), (0x70FD, "...into X"),
        (0x70FE, "Move it one cell the way it flies: up..."),
        (0x7101, "Direction 1: up"), (0x7103, "No: try right"), (0x7105, "Up: one row up the map"),
        (0x7108, "...right..."), (0x710A, "No: try down"), (0x710C, "Right: one column along"),
        (0x710F, "...down..."), (0x7111, "No: try left"), (0x7113, "Down: one row down the map"),
        (0x7116, "...left"), (0x7118, "No: the cell is moved"), (0x711A, "Left: one column back"),
        (0x711D, "Does the missile's new cell hold a wall or door?"),
        (0x7120, "...as the cell to test"), (0x7123, "And its y..."), (0x7126, "...in cell_y"), (0x7129, "Keep the missile slot..."),
        (0x712A, "...on the stack across the tests"), (0x712B, "Z set if the cell is clear of walls"),
        (0x712E, "Clear: is a monster there?"),
        (0x7130, "A wall: the missile stops, never drawn there"),
        (0x7131, "Recover the missile slot"),
        (0x7132, "The missile is spent: free its slot..."),
        (0x7134, "...direction 0, so the hero may fire again"),
        (0x7137, "On to the next slot"),
        (0x713A, "Is a monster in the new cell?"),
        (0x713C, "scratch 0: look for monsters only, not heroes"), (0x713F, "Z clear, X = the monster, if one is in the cell"),
        (0x7142, "None: an object or a hero?"),
        (0x7144, "One there: is it still alive?"),
        (0x7147, "Sparkles on: dying; the blank (just killed) is live"), (0x7149, "Dying: the missile flies through it"),
        (0x714B, "Alive: hit it, with the slot off the stack..."),
        (0x714C, "...in Y, for monster_hit"), (0x714D, "Hit sound, damage; it spends the missile"),
        (0x7150, "monster_hit's kill: a point to the firer..."),
        (0x7153, "...and the missile is spent"),
        (0x7156, "Could the new cell hold an object (a drainer)?"),
        (0x7157, "Recover the missile slot"), (0x7158, "The missile's x..."), (0x715B, "...as the cell to test"), (0x715E, "And its y..."),
        (0x7161, "...in cell_y"), (0x7164, "Keep the missile slot..."), (0x7165, "...on the stack across test_object_free"), (0x7166, "Y zero if an object may lie in the cell"),
        (0x7169, "Recover the missile slot..."), (0x716A, "...into X"), (0x716B, "Can an object lie there?"),
        (0x716D, "No: no drainer; is a hero there?"),
        (0x716F, "Look for an energy drainer at the cell..."),
        (0x7170, "Keep the missile slot while X runs over objects"), (0x7171, "...objects 30 to 1"),
        (0x7173, "This object's x..."), (0x7176, "...the missile's cell?"), (0x7179, "No: the next object"), (0x717B, "This object's y..."),
        (0x717E, "...the missile's cell too?"), (0x7181, "No: the next object"),
        (0x7183, "The object in the cell: a drainer (&53-&5E)?"),
        (0x7186, "Below the drainer sprites?"), (0x7188, "Yes: some other object; stop looking"),
        (0x718A, "Past the last drainer stage?"), (0x718C, "Yes: some other object; stop looking"),
        (0x718E, "A drainer: the hit wears it down a stage"),
        (0x7191, "Its new stage..."), (0x7194, "Past the last (12 hits from the first stage)?"), (0x7196, "No: it survives; score and bounce"),
        (0x7198, "Worn away: take it out of the level"),
        (0x719A, "Off the map in x..."), (0x719D, "...and y, so it is never drawn or met again"),
        (0x71A0, "A point to the hero who fired, for every hit"),
        (0x71A1, "Recover the missile slot"), (0x71A2, "The missile's sprites say whose it is"),
        (0x71A5, "Turn the missile round, still in the drainer's cell"),
        (0x71A8, "Flying up?"), (0x71AA, "No: try right"), (0x71AC, "Up turns to down..."), (0x71AE, "...back the way it came"),
        (0x71B1, "Is a hero in the drainer's cell?"),
        (0x71B4, "...right..."),
        (0x71B6, "No: try down"), (0x71B8, "Right turns to left..."), (0x71BA, "...back the way it came"), (0x71BD, "Is a hero in the drainer's cell?"),
        (0x71C0, "...down..."),
        (0x71C2, "No: it was flying left"), (0x71C4, "Down turns to up..."), (0x71C6, "...back the way it came"), (0x71C9, "Is a hero in the drainer's cell?"),
        (0x71CC, "Left turns to right..."),
        (0x71CE, "...back the way it came"), (0x71D1, "Is a hero in the drainer's cell?"),
        (0x71D4, "Next object"),
        (0x71D5, "Until all 30 are checked"),
        (0x71D7, "No drainer in the cell: drop the saved slot..."),
        (0x71D8, "...back into X"),
        (0x71D9, "Is a hero in the new cell? Any hero, even the firer"),
        (0x71DA, "Keep the missile slot while X runs over heroes"), (0x71DB, "From hero 0"),
        (0x71DD, "Fetch the missile slot..."), (0x71DE, "...into Y..."), (0x71DF, "...leaving it on the stack"),
        (0x71E0, "This hero's x..."), (0x71E3, "...the missile's cell?"), (0x71E6, "No: the next hero"),
        (0x71E8, "This hero's y..."), (0x71EB, "...the missile's cell too?"), (0x71EE, "No: the next hero"),
        (0x71F0, "Hit: the hero loses the missile's damage..."),
        (0x71F3, "...Y health points, one at a time"), (0x71F4, "Keep the count..."), (0x71F5, "...on the stack across the call"), (0x71F6, "One point (none if out of play, as a skull)"),
        (0x71F9, "Recover the count..."), (0x71FA, "...into Y"), (0x71FB, "One fewer to take"), (0x71FC, "More to take: take the next"),
        (0x71FE, "The missile is spent, slot still on the stack"),
        (0x7201, "Next hero"), (0x7202, "All four heroes checked?"), (0x7204, "No: check the next hero against the missile's cell"),
        (0x7206, "Nothing hit: the missile flies on, drawn in its new cell"),
        (0x7207, "Missile slot back in X"), (0x7208, "Sprite = the missile's base..."), (0x7209, "...(its hero's weapon, the sprite before its up sprite)..."), (0x720C, "...plus its direction, 1-4: the weapon pointing that way"),
        (0x720F, "...is the sprite to plot"), (0x7211, "Keep the missile slot..."), (0x7212, "...across the plot"), (0x7213, "Plot the missile in every view showing its cell"),
        (0x7216, "Recover the missile slot..."), (0x7217, "...into X"),
        (0x7218, "Next slot"), (0x7219, "Past the twelfth slot (three per hero)?"), (0x721B, "Yes: every missile moved this frame"),
        (0x721D, "No: move this slot's missile"), (0x7220, "Return"),

        # A missile hits a monster (reached from move_missiles)
        (0x757C, "Hit: sound the blow"),
        (0x758D, "The monster's hit points..."),
        (0x7590, "...set the carry for the subtraction..."), (0x7591, "...less this missile's damage"),
        (0x7594, "0 or more: alive (0 hit points survives a hit)"),
        (0x7596, "Below 0: killed. Start it dying..."), (0x7598, "...from the blank sprite through the sparkles"),
        (0x759B, "...and give the slot this level's hit points..."),
        (0x759E, "...ready for when it comes back at a trapdoor"),
        (0x75A1, "Missile slot back in X..."),
        (0x75A2, "...for monster_killed"),
        (0x75A3, "...a point to its hero, and the missile is spent"),
        (0x75A6, "Alive: store the hit points left"),
        (0x75A9, "Push the missile slot, as missile_spent_pop..."), (0x75AA, "...expects to find it on the stack"),
        (0x75AB, "The missile is spent: one hit per missile"),

        # credit_missile_owner, flip_firer_frame
        (0x76B1, "Which hero fired it? Its sprite base says"),
        (0x76B4, "Keep the missile slot..."), (0x76B5, "...on the stack: X becomes the hero"), (0x76B6, "The sprite base, to compare"),
        (0x76B7, "...arrows?"), (0x76B9, "Not arrows: try fireballs"), (0x76BB, "Arrows: the Ranger, hero 0"),
        (0x76BD, "Credit the Ranger"),
        (0x76C0, "...fireballs?"), (0x76C2, "Not fireballs: try axes"), (0x76C4, "Fireballs: the Magic-User, hero 1"),
        (0x76C6, "Credit the Magic-User"),
        (0x76C9, "...axes?"), (0x76CB, "Not axes: so it must be swords"), (0x76CD, "Axes: the Barbarian, hero 2"),
        (0x76CF, "Credit the Barbarian"),
        (0x76D2, "Otherwise swords: the Fighter, hero 3"),
        (0x76D4, "One point to the firer's score"),
        (0x76D7, "Recover the missile slot..."), (0x76D8, "...in X again for move_missiles"), (0x76D9, "Return"),
        (0x7747, "Which hero fired it? Its sprite base says"),
        (0x774A, "...arrows?"), (0x774C, "Not arrows: try fireballs"), (0x774E, "The Ranger's animation frame..."), (0x7751, "...flipped between 0 and 1..."),
        (0x7753, "...so the Ranger's sprite changes as they fire"), (0x7756, "Return"),
        (0x7757, "...fireballs?"),
        (0x7759, "Not fireballs: try axes"), (0x775B, "The Magic-User's animation frame..."), (0x775E, "...flipped between 0 and 1..."), (0x7760, "...so the Magic-User's sprite changes as they cast"),
        (0x7763, "Return"),
        (0x7764, "...axes?"),
        (0x7766, "Not axes: so it must be swords"), (0x7768, "The Barbarian's animation frame..."), (0x776B, "...flipped between 0 and 1..."), (0x776D, "...so the Barbarian's sprite changes as they throw"),
        (0x7770, "Return"),
        (0x7771, "Otherwise swords: the Fighter's frame..."),
        (0x7774, "...flipped between 0 and 1..."), (0x7776, "...so the Fighter's sprite changes as they throw"), (0x7779, "Return"),

        # collect_objects
        (0x7329, "The hero's cell: map x..."),
        (0x732C, "...as the cell to search"), (0x732F, "...and map y..."), (0x7332, "...likewise"),
        (0x7335, "Search from object 30, the exit, down to 1"),
        (0x7337, "Object Y's map x..."), (0x733A, "...the hero's column?"), (0x733D, "Yes: compare the row"), (0x733F, "No: try the next object"),
        (0x7342, "Object Y's map y..."), (0x7345, "...the hero's row?"), (0x7348, "Yes: the hero is on object Y"), (0x734A, "No: try the next object"),
        (0x734D, "Found: any object at all costs the Boots of Speed"),
        (0x734E, "Keep the object number..."), (0x734F, "...take the boots off..."), (0x7351, "...this hero: back to normal speed"),
        (0x7354, "Point at the hero's bolt in the panel..."),
        (0x7357, "...and erase it"),
        (0x735A, "Recover the object number..."), (0x735B, "...into Y"),
        (0x735C, "The object's type, which is its sprite"), (0x735F, "Treasure?"), (0x7361, "No: try food"),
        (0x7363, "Treasure: its sound, keeping hero and object"),
        (0x737D, "Treasure is worth 20 points:"),
        (0x737E, "...keeping the object number"), (0x737F, "Ten points..."), (0x7382, "...and ten more"),
        (0x7385, "Recover the object number..."), (0x7386, "...into Y"),
        (0x7387, "Take the treasure off the level"),
        (0x738A, "Food?"), (0x738C, "No: try a teleporter"),
        (0x738E, "Food: +10 health, one on the tens digit..."),
        (0x7391, "...and look at the new tens digit"), (0x7394, "Past the 9 sprite?"), (0x7396, "No: health is up by 10"),
        (0x7398, "Yes: health is capped at 99..."), (0x739A, "...tens 9..."), (0x739D, "...units 9"),
        (0x73A0, "Show the new health and score 5 points:"),
        (0x73A1, "Keep the object number"), (0x73A2, "Redraw the health in the panel"),
        (0x73A5, "Food is worth 5 points"),
        (0x73A7, "Keep the count of points to add..."), (0x73A8, "...across add_point"), (0x73A9, "One point"), (0x73AC, "Recover the count..."),
        (0x73AD, "...into Y"), (0x73AE, "One fewer to add"), (0x73AF, "Until all five are added"),
        (0x73B1, "The food sound, keeping the hero"),
        (0x73C0, "Take the food off the level"),
        (0x73C3, "Teleporter?"), (0x73C5, "No: try the Cross"),
        (0x73C7, "Teleporter: search back from it for the previous..."),
        (0x73C8, "...object's type..."), (0x73CB, "...a teleporter too?"), (0x73CD, "Yes: it is the destination"),
        (0x73CF, "Searched down to object 0?"), (0x73D1, "No: keep looking backwards"),
        (0x73D3, "Yes: wrap round to 30, so the search goes on at 29"),
        (0x73D6, "...(the one found may be this teleporter itself)"),
        (0x73D9, "The teleport sound, keeping hero and destination"),
        (0x73EA, "Move the hero to the cell above the destination..."),
        (0x73ED, "...the destination's column..."), (0x73F0, "...and cell_x (show_hero_room sets it again)"), (0x73F3, "...and its row..."), (0x73F6, "...less one..."),
        (0x73F7, "...so the hero does not stand on it and teleport back"), (0x73F9, "...as the hero's row (wall or not: it is not tested)"), (0x73FC, "...and cell_y, likewise"),
        (0x73FF, "Arrive standing still:"),
        (0x7401, "...not part way through a step"), (0x7404, "...and no pixel offsets..."), (0x7407, "...in either direction"),
        (0x740A, "Point the hero's view at the room arrived in"),
        (0x740D, "Cross of Resurrection?"), (0x740F, "No: try the exit, drainers and magic items"),
        (0x7411, "Cross: take it off the level..."),
        (0x7413, "...off the map in x..."), (0x7416, "...and y, even if nobody comes back"),
        (0x7419, "The Cross is worth 10 points"),
        (0x741C, "Keep the hero..."), (0x741D, "...across the sound and the queue"),
        (0x741E, "Play the pickup sound"),
        (0x7421, "First queue entry used (a hero or a &64 marker)?"),
        (0x7424, "Yes: bring back the first hero waiting"),
        (0x7426, "No: wasted. Recover the hero..."), (0x7427, "...into X..."), (0x7428, "...and return"),
        (0x7429, "Take the first entry off the queue, appending 0..."),
        (0x742B, "First entry: a hero number + 1, the &64 marker or 0..."), (0x742E, "...minus 1: the hero, &63 for the marker, &FF for none"), (0x742F, "Shift the queue up one: the second entry..."), (0x7432, "...becomes the first..."),
        (0x7435, "...the third..."), (0x7438, "...becomes the second..."), (0x743B, "...the fourth..."), (0x743E, "...becomes the third..."),
        (0x7441, "...and Y fills the last (0, or the marker sent back)"),
        (0x7444, "A &64 marker (a hero absent from the menu)?"), (0x7446, "No: a hero, or nobody"),
        (0x7448, "Yes: send it to the back and take the next entry"),
        (0x744A, "...(always taken)"),
        (0x744C, "Queue empty?"), (0x744E, "Yes: nobody returns"),
        (0x7450, "Start hero X materialising: out of play..."),
        (0x7452, "...direction 0: not in play while the sprites run"),
        (0x7455, "...from the skull back..."),
        (0x7457, "...frame 8, the last of hero_appearance_sprites"),
        (0x745A, "...stepping backwards..."),
        (0x745C, "...frame step -1"),
        (0x745F, "...the first step next frame"),
        (0x7461, "...the frame counter"),
        (0x7464, "Recover the hero who picked up the Cross..."), (0x7465, "...into X"), (0x7466, "Return"),
        (0x7467, "Take object Y off the level:"),
        (0x7469, "...off the map in x..."), (0x746C, "...and y, so it is neither drawn nor found again"), (0x746F, "Return"),
        (0x7470, "Next object down"), (0x7471, "Past object 1: nothing in the cell"), (0x7473, "Check this object"),
        (0x7476, "Return"),
        (0x7477, "Type &5F or above: a magic item?"),
        (0x7479, "Yes: collect the magic item"),
        (0x747B, "The exit? The main loop deals with it..."),
        (0x747D, "...so search on for another object in the cell"),
        (0x747F, "Any other type is an energy drainer: pitch &32..."),
        (0x7481, "...instead of 6 in hit_sound, the drainer's noise"), (0x7484, "Keep the hero..."), (0x7485, "...across the OSWORD call"), (0x7486, "SOUND hit_sound..."),
        (0x7488, "...high byte..."), (0x748A, "...OSWORD 7, SOUND"), (0x748C, "The drainer's noise:"),
        (0x748F, "...then pitch 6 again..."),
        (0x7491, "...for monster_hit's blow"), (0x7494, "Recover the hero..."), (0x7495, "...into X"),
        (0x7496, "The drainer takes 10 health and stays"),
        (0x7498, "Keep the count..."), (0x7499, "...across lose_health_point"), (0x749A, "One point of the hero's health"), (0x749D, "Recover the count..."),
        (0x749E, "...into Y"), (0x749F, "One fewer to take"), (0x74A0, "Until all ten are taken"),
        (0x74A2, "Return"),
        (0x74A3, "Envelope 3 as the pickup envelope..."),
        (0x74A5, "...high byte..."), (0x74A7, "...OSWORD 8, ENVELOPE"), (0x74A9, "Define it:"),
        (0x74AC, "...then the pickup sound..."),
        (0x74AE, "...high byte..."), (0x74B0, "...OSWORD 7, SOUND"), (0x74B2, "Play it:"),
        (0x74B5, "Return"),
        (0x74B6, "A magic item: keep its type for the tests below"),
        (0x74B9, "Take it off the level..."),
        (0x74BB, "...off the map in x..."), (0x74BE, "...and y"),
        (0x74C1, "The pickup sound, keeping the hero"),
        (0x74CF, "The score's units digit sprite..."),
        (0x74D2, "...kept for a potion (add_ten_points leaves it)"),
        (0x74D5, "Every magic item is worth 10 points"),
        (0x74D8, "The item's type..."), (0x74DB, "...Boots of Speed?"), (0x74DD, "No: try the helmet"),
        (0x74DF, "Boots: point at the hero's bolt in the panel..."),
        (0x74E2, "...and show it"),
        (0x74E5, "...and wear them..."),
        (0x74E7, "...so the hero moves a whole cell per step"), (0x74EA, "Return"),
        (0x74EB, "Magic helmet?"), (0x74ED, "No: try the potion"),
        (0x74EF, "Helmet: one less health lost per hit..."),
        (0x74F2, "...and look at it"), (0x74F5, "...below 3 (armour 7, the best)?"),
        (0x74F7, "No: keep it"), (0x74F9, "Yes: back to 3"),
        (0x74FC, "Redraw the armour rating on the shield"),
        (0x74FF, "Potion of healing?"), (0x7501, "No: try the weapons"),
        (0x7503, "Potion: health = the score's last digit twice..."),
        (0x7506, "...as the tens (so a score ending in 0 gives 00)"),
        (0x7509, "...and the units one higher..."),
        (0x750C, "...the sprite after it..."), (0x750F, "...as the health's units"), (0x7512, "...less a point, which also draws the health"),
        (0x7515, "Return"),
        (0x7516, "Pile of weapons?"), (0x7518, "No: anything else is taken as a magic sword"),
        (0x751A, "Weapons: one more missile in flight at once..."),
        (0x751D, "...and look at it"), (0x7520, "...past 3, the hero's missile slots?"),
        (0x7522, "No: add its icon to the panel"), (0x7524, "Yes: back to 3..."), (0x7526, "...as the missiles allowed"),
        (0x7529, "Draw the newest missile icon"),
        (0x756B, "Magic sword: one more damage per missile..."),
        (0x756E, "...and look at it"), (0x7571, "...past 9?"),
        (0x7573, "No: draw the new damage in the panel"), (0x7575, "Yes: back to 9..."), (0x7577, "...as the missile damage"), (0x757A, "...and draw it (always taken)"),
    ]:
        a.c(addr, text)


def annotate_monster_comments(a: Annotator) -> None:
    a.label(0x79E5, "next_monster_update")
    a.label(0x7B04, "draw_monster")
    a.label(0x7B28, "monster_done")
    a.label(0x7B31, "advance_dying_monster")
    a.label(0x7CB3, "monster_reappears")
    a.block(0x7A23, (
        "A monster that is not stepping tries the next cell the way it "
        "faces. A wall or a creature there (a hero there is hurt) keeps it "
        "where it is and turns it a random way to try next frame. Otherwise "
        "the step goes ahead: monster_x and monster_y keep the old cell and "
        "the offsets carry the sprite across over four frames."))
    a.block(0x7AC1, (
        "A step into a cell on a room's edge row (moving up or down) or "
        "edge column (moving across) is made at once, with no slide, so the "
        "sprite is never drawn part way between two rooms."))
    a.block(0x7B31, (
        "A killed monster is set to sprite &15 (the blank). Each frame the "
        "sprite advances, showing the sparkles &16-&19 at the cell and "
        "offsets it died at; after the last the monster reappears."))
    a.block(0x7CB3, (
        "The monster comes back facing up on the next trapdoor in turn. "
        "It is not drawn until next frame. The creature test that follows "
        "reads cell_x and cell_y, which still hold the dying monster's "
        "position within its view, as the erase's plot_at_cell left them, "
        "not the trapdoor's cell. So a creature already on the trapdoor "
        "does not stop the monster emerging; one that happens to stand at "
        "the unrelated cell the leftovers name parks the monster at &FF,&FF, "
        "still alive, where nothing returns it to a trapdoor (and a hero "
        "there is hurt)."))
    for addr, text in [
        (0x79C1, "Redraw trapdoors 8 to 1 (sprite &2C)..."),
        (0x79C3, "Trapdoors sit squarely in their cells:"), (0x79C5, "...no horizontal offset..."), (0x79C7, "...and no vertical offset"), (0x79C9, "The trapdoor sprite..."),
        (0x79CB, "...the same for all eight"),
        (0x79CD, "This trapdoor's map x..."), (0x79D0, "...as the cell to plot"), (0x79D3, "...and its map y"), (0x79D6, "...likewise"),
        (0x79D9, "Keep the trapdoor number..."), (0x79DA, "...on the stack"), (0x79DB, "Draw it in every view showing its cell"), (0x79DE, "Recover the trapdoor number..."),
        (0x79DF, "...into X"), (0x79E0, "Next trapdoor"), (0x79E1, "Until trapdoor 1 is drawn"),
        (0x79E3, "Then each monster, 30 to 1..."),
        (0x79E5, "Keep the monster number..."), (0x79E6, "...on the stack while it moves"),
        (0x79E7, "Erase it at its cell and offsets, remembering the cell"),
        (0x79EA, "...as the cell to erase..."), (0x79ED, "...and as where it came from"), (0x79F0, "...and its map y..."), (0x79F3, "...as the cell to erase..."),
        (0x79F6, "...and as where it came from"), (0x79F9, "The blank sprite..."), (0x79FB, "...to rub it out"), (0x79FD, "Its horizontal offset..."),
        (0x7A00, "...for the erase"), (0x7A02, "...and its vertical offset..."), (0x7A05, "...so the blank covers it where it was drawn"), (0x7A07, "Rub the monster out in every view showing it"),
        (0x7A0A, "The monster number back from the stack..."), (0x7A0B, "...left there for monster_done"), (0x7A0C, "...in X again"),
        (0x7A0D, "Is the monster dying?"),
        (0x7A10, "Sprite &15 (the blank) and up: killed"),
        (0x7A12, "Below &15: alive, so it moves"),
        (0x7A14, "Killed: show its next sparkle"),
        (0x7A17, "Part way through a step?"),
        (0x7A1A, "No: try a step to the next cell"),
        (0x7A1C, "Yes: slide it a quarter cell further"),
        (0x7A1F, "Drop the stacked number (X still has it)..."), (0x7A20, "...as draw_monster pushes it again"),
        (0x7A23, "Step into the next cell in the way it faces: up..."),
        (0x7A26, "Facing up?"), (0x7A28, "No: try right"), (0x7A2A, "Yes: one row up"),
        (0x7A2D, "...right..."), (0x7A2F, "No: try down"), (0x7A31, "Yes: one column right"),
        (0x7A34, "...down..."), (0x7A36, "No: try left"), (0x7A38, "Yes: one row down"),
        (0x7A3B, "...left"), (0x7A3D, "No: it does not move"), (0x7A3F, "Yes: one column left"),
        (0x7A42, "First quarter-cell offsets of the step"),
        (0x7A45, "Is the new cell a wall (or a closed door)?"),
        (0x7A48, "...the new x as cell_x"), (0x7A4B, "The new y..."), (0x7A4E, "...as cell_y"), (0x7A51, "Z set if the cell is open"),
        (0x7A54, "Open: is a creature in the way?"),
        (0x7A56, "Wall: the monster stays where it is..."),
        (0x7A57, "...its number back in X, which test_wall changed"), (0x7A58, "The cell it was in..."), (0x7A5B, "...back in monster_x"), (0x7A5E, "...and its row..."),
        (0x7A61, "...back in monster_y"), (0x7A64, "No step under way:"), (0x7A66, "...step count 0"), (0x7A69, "...no horizontal offset"),
        (0x7A6C, "...no vertical offset"),
        (0x7A6F, "Turn a random way, from the System VIA's timer"),
        (0x7A72, "A random 0-7..."), (0x7A74, "...plus 8..."), (0x7A75, "...a sprite &08-&0F"), (0x7A77, "Face the monster that way"),
        (0x7A7A, "Odd sprites (9, &0B, &0D, &0F) are the facings"),
        (0x7A7C, "Even: round it up to the next facing"), (0x7A7E, "Odd: draw it; it tries the new way next frame"), (0x7A81, "Round up: each way is equally likely, 2 in 8"), (0x7A84, "Draw it; it tries the new way next frame"),
        (0x7A87, "Monster or hero in the new cell? (a hero there is hurt)"),
        (0x7A88, "...left stacked for later"), (0x7A89, "Non-zero scratch: skip this monster, check heroes"), (0x7A8C, "A = 0 if no creature is at cell_x, cell_y"), (0x7A8F, "Anything there?"),
        (0x7A91, "No: the cell is free, so the step goes ahead"),
        (0x7A93, "Yes: stay put, with no step, and turn a random way"),
        (0x7AC1, "The step goes ahead..."),
        (0x7AC2, "...its number back in X, which find_creature changed"), (0x7AC3, "Which way is it going?"), (0x7AC6, "Facing up?"), (0x7AC8, "Yes: check the new row"),
        (0x7ACA, "Facing down?"), (0x7ACC, "Yes: check the new row"),
        (0x7ACE, "Across: is the new cell in a room's edge column?"),
        (0x7AD1, "Column within its eight-cell room"), (0x7AD3, "Column 0: the left edge"), (0x7AD5, "Column 7, the right edge?"), (0x7AD7, "Yes: an edge"),
        (0x7AD9, "No: slide there over the coming frames"),
        (0x7ADC, "Up or down: is the new cell in a room's edge row?"),
        (0x7ADF, "Row within its eight-cell room"), (0x7AE1, "Row 0: the top edge"), (0x7AE3, "Row 7, the bottom edge?"), (0x7AE5, "Yes: an edge"),
        (0x7AE7, "No: slide there over the coming frames"),
        (0x7AEA, "Edge: jump straight in, so no slide crosses rooms"),
        (0x7AEC, "...step count 0"), (0x7AEF, "...no horizontal offset"), (0x7AF2, "...no vertical offset"), (0x7AF5, "Draw it squarely in the new cell"),
        (0x7AF8, "Slide: keep the old cell until the step ends..."),
        (0x7AFB, "...back in monster_x"), (0x7AFE, "...and its row..."), (0x7B01, "...back in monster_y: drawn offset from there"),
        (0x7B04, "Draw it: its cell, facing + frame, offsets"),
        (0x7B07, "...as cell_x"), (0x7B0A, "Its row..."), (0x7B0D, "...as cell_y"), (0x7B10, "Ready to add the frame"),
        (0x7B11, "Its facing sprite..."), (0x7B14, "...plus walking frame 0 or 1..."), (0x7B17, "...is the sprite to plot"), (0x7B19, "How far it has slid across..."),
        (0x7B1C, "...as the horizontal offset"), (0x7B1E, "How far it has slid down..."), (0x7B21, "...as the vertical offset"), (0x7B23, "Keep the monster number..."),
        (0x7B24, "...across the plot, which changes X"), (0x7B25, "Draw it in every view whose room shows it"), (0x7B28, "The monster number back from the stack..."), (0x7B29, "...in X"),
        (0x7B2A, "Next monster down"), (0x7B2B, "Past monster 1: all 30 updated"), (0x7B2D, "Otherwise update the next one"),
        (0x7B30, "Return"),
        (0x7B31, "Drop the stacked number (X still has it)"),
        (0x7B32, "Next death frame: &16-&19 are the sparkles"),
        (0x7B35, "Which frame now?"), (0x7B38, "Past the last sparkle (&19)?"),
        (0x7B3A, "No: draw this sparkle"),
        (0x7B3C, "Yes: bring it back at a trapdoor"),
        (0x7B3F, "Draw the sparkle where the monster died..."),
        (0x7B40, "...keeping the monster number across the plot"), (0x7B41, "Its cell..."), (0x7B44, "...as cell_x"), (0x7B47, "...and row..."),
        (0x7B4A, "...as cell_y"), (0x7B4D, "The sparkle sprite, with no walking frame..."), (0x7B50, "...is the sprite to plot"), (0x7B52, "Offsets frozen at the moment it died..."),
        (0x7B55, "...across"), (0x7B57, "...and down"), (0x7B5A, "...so it sparkles exactly where it died"), (0x7B5C, "Draw the sparkle in every view showing it"),
        (0x7B5F, "Pull the monster number and on to the next"),
        (0x7CB3, "Each reappearance uses the next trapdoor in turn"),
        (0x7CB6, "Which trapdoor now?"), (0x7CB9, "Past the eighth (7)?"), (0x7CBB, "No: emerge there"), (0x7CBD, "Yes: wrap round to trapdoor 0..."),
        (0x7CBF, "...for this monster and the next"), (0x7CC2, "Y = the trapdoor to emerge from"),
        (0x7CC5, "Put the monster on it, facing up, with no step"),
        (0x7CC8, "...the trapdoor's x as the monster's"), (0x7CCB, "The trapdoor's y..."), (0x7CCE, "...as the monster's"), (0x7CD1, "Facing up (sprite 9)..."),
        (0x7CD3, "...ends the death: alive again, drawn next frame"), (0x7CD6, "No step under way:"), (0x7CD8, "...step count 0"), (0x7CDB, "...no horizontal offset"),
        (0x7CDE, "...no vertical offset"),
        (0x7CE1, "Test for a creature at cell_x, cell_y..."),
        (0x7CE2, "...stacking the number for monster_done"), (0x7CE3, "Non-zero scratch: skip this monster, check heroes"), (0x7CE6, "cell_x/y: plot_at_cell's leftovers, not the trapdoor"), (0x7CE9, "A = 0 if nothing is at that cell"),
        (0x7CEB, "Nothing there: the monster stays on the trapdoor"),
        (0x7CED, "Something there: park it off the map, still alive"),
        (0x7CEE, "...keeping it stacked for monster_done"), (0x7CEF, "...its number in X, which find_creature changed"), (0x7CF0, "Off the map..."), (0x7CF2, "...as its x"),
        (0x7CF5, "...and its y: no trapdoor will take it back"), (0x7CF8, "Pull the monster number and on to the next"),
        (0x7CFB, "Pull the monster number and on to the next"),

        (0x7BEB, "Three more frames to reach the new cell..."),
        (0x7BED, "...as the step count"),
        (0x7BF0, "Draw it a quarter cell along the way it faces: up..."),
        (0x7BF3, "Facing up?"), (0x7BF5, "No: try right"), (0x7BF7, "Up: not across..."), (0x7BF9, "...no horizontal offset"),
        (0x7BFC, "-3: a quarter of a 12-row cell up..."), (0x7BFE, "...as the vertical offset"), (0x7C01, "Return"),
        (0x7C02, "Facing right?"), (0x7C04, "No: try down"), (0x7C06, "Right: not up or down..."),
        (0x7C08, "...no vertical offset"), (0x7C0B, "+1: a quarter of a 4-byte cell right..."),
        (0x7C0D, "...as the horizontal offset"), (0x7C10, "Return"),
        (0x7C11, "Facing down?"), (0x7C13, "No: it faces left"), (0x7C15, "Down: not across..."),
        (0x7C17, "...no horizontal offset"), (0x7C1A, "+3: a quarter of a cell down..."),
        (0x7C1C, "...as the vertical offset"), (0x7C1F, "Return"),
        (0x7C20, "Left: not up or down..."),
        (0x7C22, "...no vertical offset"), (0x7C25, "-1: a quarter of a cell left..."), (0x7C27, "...as the horizontal offset"), (0x7C2A, "Return"),
        (0x7C2B, "Swap the monster's walking frame..."),
        (0x7C2E, "...0 to 1 or 1 to 0..."), (0x7C30, "...so its legs move as it slides"),
        (0x7C33, "One frame fewer to the new cell"),
        (0x7C36, "Not there yet: slide a quarter cell further"),
        (0x7C38, "Arrived: move its cell on the way it faces: up..."),
        (0x7C3B, "Facing up?"), (0x7C3D, "No: try right"), (0x7C3F, "Yes: one row up"),
        (0x7C42, "...right..."), (0x7C44, "No: try down"), (0x7C46, "Yes: one column right"),
        (0x7C49, "...down..."), (0x7C4B, "No: try left"), (0x7C4D, "Yes: one row down"),
        (0x7C50, "...left"), (0x7C52, "No: no move"), (0x7C54, "Yes: one column left"),
        (0x7C57, "Drawn squarely in the new cell:"),
        (0x7C59, "...no horizontal offset"), (0x7C5C, "...no vertical offset (zeros don't grow)"),
        (0x7C5F, "Slide across a further quarter cell (a byte column)"),
        (0x7C62, "Zero: moving up or down, or arrived"), (0x7C64, "Positive: moving right"), (0x7C66, "Negative: one more column left"), (0x7C69, "Now the vertical offset"),
        (0x7C6C, "One more column right"),
        (0x7C6F, "Slide down or up a further quarter cell (3 rows)"),
        (0x7C72, "Zero: moving across, or arrived"), (0x7C74, "Positive: moving down"), (0x7C76, "Moving up: three more rows up..."), (0x7C77, "...from the vertical offset..."),
        (0x7C7A, "...less three..."), (0x7C7C, "...to -6 or -9"), (0x7C7F, "Done"), (0x7C82, "Moving down: three more rows down..."),
        (0x7C83, "...from the vertical offset..."), (0x7C86, "...plus three..."), (0x7C88, "...to 6 or 9"),
        (0x7C8B, "Return"),

        (0x7B62, "One frame to go before the hero is in the new cell"),
        (0x7B64, "...as hero_step: continue_hero_step ends it"),
        (0x7B67, "Draw the hero half a cell along the way they face"),
        (0x7B6A, "Facing up?"), (0x7B6C, "No: try right"), (0x7B6E, "Up: not across..."), (0x7B70, "...no horizontal offset"),
        (0x7B73, "-6: half a 12-row cell up..."), (0x7B75, "...as the vertical offset"), (0x7B78, "Return"),
        (0x7B79, "Facing right?"),
        (0x7B7B, "No: try down"), (0x7B7D, "Right: not up or down..."), (0x7B7F, "...no vertical offset"), (0x7B82, "+2: half a 4-byte cell right..."),
        (0x7B84, "...as the horizontal offset"), (0x7B87, "Return"),
        (0x7B88, "Facing down?"),
        (0x7B8A, "No: they face left"), (0x7B8C, "Down: not across..."), (0x7B8E, "...no horizontal offset"), (0x7B91, "+6: half a cell down..."),
        (0x7B93, "...as the vertical offset"), (0x7B96, "Return"),
        (0x7B97, "Left: not up or down..."),
        (0x7B99, "...no vertical offset"), (0x7B9C, "-2: half a cell left..."), (0x7B9E, "...as the horizontal offset"), (0x7BA1, "Return"),
        (0x7BA2, "Swap the hero's walking frame..."),
        (0x7BA5, "...0 to 1 or 1 to 0..."), (0x7BA7, "...so their legs move"),
        (0x7BAA, "One frame fewer to the new cell"),
        (0x7BAD, "Not there yet (never taken: the step is 1)"),
        (0x7BAF, "Arrived: move their cell on the way they face: up..."),
        (0x7BB2, "Facing up?"), (0x7BB4, "No: try right"), (0x7BB6, "Yes: one row up"),
        (0x7BB9, "...right..."), (0x7BBB, "No: try down"), (0x7BBD, "Yes: one column right"),
        (0x7BC0, "...down..."), (0x7BC2, "No: try left"), (0x7BC4, "Yes: one row down"),
        (0x7BC7, "...left"), (0x7BC9, "No: no move"), (0x7BCB, "Yes: one column left"),
        (0x7BCE, "Drawn squarely in the new cell:"),
        (0x7BD0, "...no horizontal offset"), (0x7BD3, "...no vertical offset"),
        (0x7BD6, "Double the offsets, which are always zero by now"),
        (0x7BD7, "Horizontal offset..."), (0x7BDA, "...plus itself..."), (0x7BDD, "...doubled"), (0x7BE0, "Ready for the vertical offset"),
        (0x7BE1, "Vertical offset..."), (0x7BE4, "...plus itself..."), (0x7BE7, "...doubled"),
        (0x7BEA, "Return"),

        (0x76DA, "Every other frame: count down the timer..."),
        (0x76DD, "Timer run out: show the next sprite"), (0x76DF, "Not yet: nothing to draw this frame"),
        (0x76E0, "Restart the two-frame timer..."), (0x76E2, "...which an absent hero keeps in hero_offset_y"),
        (0x76E5, "Plot the current appearance sprite at the hero's cell"),
        (0x76E8, "No pixel offsets (those bytes hold timer and step)..."), (0x76EA, "...across..."), (0x76EC, "...or down"), (0x76EE, "The hero's place in the appearance sequence..."),
        (0x76F1, "...as an index..."), (0x76F2, "...picks the sparkle or skull to show"), (0x76F5, "...to plot"), (0x76F7, "Keep the hero number..."),
        (0x76F8, "...on the stack"), (0x76F9, "Plot it in every view that shows the hero"), (0x76FC, "Recover the hero number..."), (0x76FD, "...into X"),
        (0x76FE, "Step to the next (+1 dying, -1 returning), stopping at 8"),
        (0x76FF, "Current place in the sequence..."), (0x7702, "...plus the step kept in hero_offset_x"), (0x7705, "Past the skull (place 8)?"), (0x7707, "No: keep the new place"),
        (0x7709, "Yes: a dead hero stays on the skull"),
        (0x770B, "Place 0? Only a returning hero gets there"),
        (0x770D, "No: store the new place for the next plot"),
        (0x770F, "Yes: back in play before place 0 is shown..."),
        (0x7711, "...facing down (direction 5)"),
        (0x7714, "...with no step or offsets..."),
        (0x7716, "...not mid-step..."), (0x7719, "...no horizontal offset..."), (0x771C, "...no vertical offset..."), (0x771F, "...and animation frame 0"),
        (0x7722, "...and health 33, drawn by taking a point"),
        (0x7724, "...tens digit 3..."), (0x7727, "...units digit 3..."), (0x772A, "...less a point, which also draws it: 32"),
        (0x772D, "Return"),
        (0x772E, "Store the frame"), (0x7731, "Return"),
    ]:
        a.c(addr, text)


def annotate_update_game_comments(a: Annotator) -> None:
    a.label(0x1DC2, "draw_keys")
    a.label(0x1DE6, "check_hero_keys")
    a.label(0x1ECE, "update_rest")
    for addr, text in [
        (0x1CC0, "Move the heroes: steps, shots, magic, pick-ups"),
        (0x1CC3, "For each hero, 0-3..."),
        (0x1CC5, "...hero number in scratch, for the door's points"),
        (0x1CC8, "The cell hero X last stepped or bumped into..."), (0x1CCB, "...is the cell to test"), (0x1CCE, "...and its y..."), (0x1CD1, "...is the cell's y"),
        (0x1CD4, "Keep the hero's number..."), (0x1CD5, "...on the stack for the key check"),
        (0x1CD6, "Doors 20 to 1: is one in that cell?"),
        (0x1CD8, "This door's x (&FF once opened)..."), (0x1CDB, "...the cell being tested?"), (0x1CDE, "Yes: check its y"),
        (0x1CE0, "No: next door"),
        (0x1CE3, "...and y?"), (0x1CE6, "...the cell being tested?"), (0x1CE9, "Yes: the hero has walked into this door"),
        (0x1CEB, "No: next door"),
        (0x1CEE, "Does the hero carry this door's key?"),
        (0x1CEF, "Y = the hero's number..."), (0x1CF0, "...kept on the stack"), (0x1CF1, "A = the door's number: key n opens door n"), (0x1CF2, "Is it the number of the key the hero carries?"),
        (0x1CF5, "Yes: open door"),
        (0x1CF7, "No key, or the wrong one: the door stays shut"),
        (0x1CFA, "Open the door: 7 points..."),
        (0x1CFB, "Keep the door's number..."), (0x1CFC, "...and the hero's..."), (0x1CFD, "...on the stack"), (0x1CFE, "Seven points, one per add_point call"),
        (0x1D00, "...X = the hero who opened the door, for add_point"), (0x1D03, "Keep the count of points still to give"), (0x1D04, "...on the stack, as add_point uses Y"), (0x1D05, "One point to the hero's score, redrawn"),
        (0x1D08, "Recover the count of points to give"), (0x1D09, "...back into Y"), (0x1D0A, "One fewer to give"), (0x1D0B, "More to give: add the next point"),
        (0x1D0D, "The door sound is the food sound, lower..."),
        (0x1D0F, "...pitch 150 instead of food's 200"), (0x1D12, "SOUND food_sound: block address low..."), (0x1D14, "...and high"), (0x1D16, "OSWORD 7: SOUND"),
        (0x1D18, "Sound the door opening"),
        (0x1D1B, "...then put food's pitch back..."),
        (0x1D1D, "...to 200, for the next food eaten"),
        (0x1D20, "Save the door's cell; plot_at_cell changes cell_x/y..."),
        (0x1D23, "...y into the spare byte at monster_y + 35..."), (0x1D26, "...then the door's x..."), (0x1D29, "...into the spare byte at monster_x + 35"),
        (0x1D2C, "Erase the door from the screen..."),
        (0x1D2E, "...the blank as the sprite to plot"), (0x1D30, "...on the cell itself: no pixel offset..."), (0x1D32, "...horizontally..."), (0x1D34, "...or vertically"),
        (0x1D36, "Blank the door in every view showing its room"),
        (0x1D39, "...and recover its cell"),
        (0x1D3C, "...back into cell_x..."), (0x1D3F, "...then the door's y..."), (0x1D42, "...back into cell_y"),
        (0x1D45, "Recover the hero number pushed at open_door..."), (0x1D46, "...into Y"), (0x1D47, "Recover the door number..."), (0x1D48, "...into X"),
        (0x1D49, "Clear the door's wall bit: room offset..."),
        (0x1D4C, "...room row: y AND &F8, 8 cell rows per room..."), (0x1D4E, "...kept to add in again"), (0x1D51, "...clear carry for the three adds"), (0x1D52, "...twice..."),
        (0x1D55, "...three times..."), (0x1D58, "...four: 32 bytes per row of four rooms"), (0x1D5B, "...as the low byte of map_ptr"), (0x1D5D, "...plus the room column..."),
        (0x1D60, "...x AND &F8: 8 bytes per room..."), (0x1D62, "...added on..."), (0x1D64, "...giving the room's offset in room_walls"),
        (0x1D66, "...in room_walls..."), (0x1D68, "...as map_ptr's high byte"),
        (0x1D6A, "Keep the door number..."), (0x1D6B, "...on the stack while X is used for the bit"),
        (0x1D6C, "...mask for the column..."), (0x1D6F, "...x AND 7, the cell's column in the room..."), (0x1D71, "...as the index into bit_masks..."),
        (0x1D72, "...for the cell's bit in its row byte..."), (0x1D75, "...inverted, to keep every other wall..."), (0x1D77, "...as the mask to clear it with"),
        (0x1D7A, "...byte for the row..."), (0x1D7D, "...y AND 7, the cell's row in the room..."), (0x1D7F, "...indexes the room's eight row bytes"),
        (0x1D80, "...the row of walls holding the door..."), (0x1D82, "...knock out the door's bit..."), (0x1D85, "...so the doorway no longer blocks anyone"),
        (0x1D87, "Recover the door number..."), (0x1D88, "...into X"),
        (0x1D89, "Take the door out of the level..."), (0x1D8B, "...x off the map: no hero matches it again..."), (0x1D8E, "...and y off the map"),
        (0x1D91, "Recover the hero number..."), (0x1D92, "...into X"),
        (0x1D93, "The key is used up: the hero carries none"), (0x1D95, "...in the hero's key slot"),
        (0x1D98, "Erase the key icon from the hero's panel"),
        (0x1D9A, "...as the sprite to plot"), (0x1D9C, "...from the hero's panel row..."), (0x1D9F, "...set carry to subtract"), (0x1DA0, "...less 13: the key icon's row..."),
        (0x1DA2, "...as plot_y"), (0x1DA4, "...in panel column panel_left + 5..."), (0x1DA6, "...as plot_x"), (0x1DA8, "Keep the hero number..."),
        (0x1DA9, "...on the stack across plot_sprite"), (0x1DAA, "Plot the blank icon over the key icon"), (0x1DAD, "Recover the hero number..."), (0x1DAE, "...into X"),
        (0x1DAF, "One door a frame per hero: on to the next hero"),
        (0x1DB2, "Next door"), (0x1DB3, "Doors all checked: this hero is done"), (0x1DB5, "Otherwise check the next door"),
        (0x1DB8, "Recover the hero number pushed at check_doors..."), (0x1DB9, "...into X"),
        (0x1DBA, "Next hero"), (0x1DBB, "All four heroes done?"), (0x1DBD, "Yes: on to the keys"), (0x1DBF, "No: check this hero against the doors"),
        (0x1DC2, "Redraw every key lying on the floor, 20 to 1"),
        (0x1DC4, "...on their cells: no pixel offset..."), (0x1DC6, "...either way"), (0x1DC8, "...in the key sprite..."), (0x1DCA, "...as the sprite to plot"),
        (0x1DCC, "...counting keys down from 20; entry 0 is never drawn"),
        (0x1DCE, "The key's x..."), (0x1DD1, "...as cell_x..."), (0x1DD4, "...and y (off the map if it is carried)..."), (0x1DD7, "...as cell_y"),
        (0x1DDA, "Keep the key number..."), (0x1DDB, "...on the stack across plot_at_cell"), (0x1DDC, "Plot it in every view showing its cell"), (0x1DDF, "Recover the key number..."),
        (0x1DE0, "...into X"), (0x1DE1, "Next key down"), (0x1DE2, "More keys: draw the next"),
        (0x1DE4, "For each hero, from hero 0..."),
        (0x1DE6, "Still in play (a direction set)?"),
        (0x1DE9, "Yes: look for a key to pick up"),
        (0x1DEB, "Out of play: dead, dying or gone. Holding a key?"),
        (0x1DEE, "Yes: see whether the death has played out"),
        (0x1DF0, "No key: nothing to do for this hero"),
        (0x1DF3, "Has the death animation reached its end?"),
        (0x1DF6, "...frame 8 is the last of the death"), (0x1DF8, "Still dying: key checks go on as if in play"),
        (0x1DFA, "Yes: drop the key where the hero fell"),
        (0x1DFD, "...at the hero's x..."), (0x1E00, "...as the key's x..."), (0x1E03, "...and the hero's y..."), (0x1E06, "...as the key's y"),
        (0x1E09, "The dead hero carries no key now..."), (0x1E0B, "...so this is done only once"),
        (0x1E0E, "Erase the key icon from the hero's panel"),
        (0x1E25, "Next hero"),
        (0x1E28, "Swapped keys on the last frame?"),
        (0x1E2B, "No: look for a key at the hero's cell"),
        (0x1E2D, "Yes: skip this frame, clearing the flag"),
        (0x1E2F, "...so next frame's check may swap again"), (0x1E32, "...and move on to the next hero"),
        (0x1E35, "Is there a key at the hero's cell? Its x..."),
        (0x1E38, "...as cell_x..."), (0x1E3B, "...and the hero's y..."), (0x1E3E, "...as cell_y"), (0x1E41, "Keep the hero number..."),
        (0x1E42, "...on the stack while X counts the keys"), (0x1E43, "...keys 20 to 1; entry 0 is never picked up"),
        (0x1E45, "This key's x..."), (0x1E48, "...at the hero's x?"), (0x1E4B, "No: try the next key"),
        (0x1E4D, "...and its y..."), (0x1E50, "...at the hero's y?"), (0x1E53, "No: try the next key"),
        (0x1E55, "Yes: pick it up, erasing it from the floor"),
        (0x1E57, "...as the sprite to plot..."), (0x1E59, "...on the cell itself: no pixel offset..."), (0x1E5B, "...horizontally..."), (0x1E5D, "...or vertically"),
        (0x1E5F, "Keep the key number..."), (0x1E60, "...on the stack across plot_at_cell"), (0x1E61, "Blank the key in every view showing it"), (0x1E64, "Recover the key number..."),
        (0x1E65, "...into X"),
        (0x1E66, "Show the key icon in the hero's panel: hero..."),
        (0x1E67, "...into Y..."), (0x1E68, "...and back on the stack for later"), (0x1E69, "...in the key icon sprite..."), (0x1E6B, "...as the sprite to plot"),
        (0x1E6D, "...from the hero's panel row..."), (0x1E70, "...set carry to subtract"), (0x1E71, "...less 13: the key icon's row..."), (0x1E73, "...as plot_y"),
        (0x1E75, "...in panel column panel_left + 5..."), (0x1E77, "...as plot_x"), (0x1E79, "Keep the hero number..."), (0x1E7A, "...on the stack..."),
        (0x1E7B, "...and the key number..."), (0x1E7C, "...across plot_sprite"), (0x1E7D, "Plot the key icon"), (0x1E80, "Recover the key number..."),
        (0x1E81, "...into X..."), (0x1E82, "...and the hero number..."), (0x1E83, "...into Y"),
        (0x1E84, "Drop the key carried (if any) in this cell..."),
        (0x1E85, "...keeping the new key's number on the stack..."), (0x1E86, "...the old key, or unseen entry 0 if none..."), (0x1E89, "...goes to the hero's x..."), (0x1E8C, "...as its x..."),
        (0x1E8F, "...and the hero's y..."), (0x1E92, "...as its y"), (0x1E95, "Recover the new key's number..."), (0x1E96, "...into X, and in A to carry"),
        (0x1E97, "...and carry the new one"),
        (0x1E9A, "Mark the swap"), (0x1E9C, "...so the dropped key is left alone next frame"),
        (0x1E9F, "Take the new key off the floor"),
        (0x1EA1, "...x off the map, so draw_keys skips it..."), (0x1EA4, "...and y off the map"),
        (0x1EA7, "Sound the pickup: ENVELOPE key_envelope low..."),
        (0x1EA9, "...and high"), (0x1EAB, "OSWORD 8: ENVELOPE"), (0x1EAD, "Define the key pickup envelope"), (0x1EB0, "SOUND key_sound: block address low..."),
        (0x1EB2, "...and high"), (0x1EB4, "OSWORD 7: SOUND"), (0x1EB6, "Play the key pickup sound"),
        (0x1EB9, "Recover the hero number..."), (0x1EBA, "...into X"), (0x1EBB, "One key a frame per hero: next hero"),
        (0x1EBE, "Next key"), (0x1EBF, "Keys all checked: this hero is done"), (0x1EC1, "Otherwise check the next key"),
        (0x1EC4, "Recover the hero number pushed at check_key_cell..."), (0x1EC5, "...into X"),
        (0x1EC6, "Next hero"), (0x1EC7, "All four heroes done?"), (0x1EC9, "Yes: on with the rest of the frame"), (0x1ECB, "No: check this hero's keys"),
        (0x1ECE, "Draw the objects over the floor"),
        (0x1ED1, "Move the missiles a cell each"),
        (0x1ED4, "Move the monsters"),
    ]:
        a.c(addr, text)
    a.block(0x1DC2, "Keys. Redraw the keys on the floor, then for each "
            "hero: drop a dead hero's key where they fell, or pick up the "
            "key at the hero's cell, leaving any key carried in its place. "
            "The swap flag only skips the frame after a swap, so a hero "
            "who stays on the cell swaps back on the frame after that.")


def annotate_cassette_pause(a: Annotator) -> None:
    """The pause key in the crack and the hack: f1 (internal key &71)."""
    for addr, text in [
        (0x1ED7, "Pause key: OSBYTE &7A, lowest-numbered key held"),
        (0x1ED9, "X = its internal number, or &FF if none."),
        (0x1EDC, "f1 (&71)? A held key numbered below &71 hides it"),
        (0x1EDE, "No: the frame is over"),
        (0x1EE0, "Paused, the game frozen: wait for f1 to go up..."),
        (0x1EE3, "...is f1 still held?"), (0x1EE5, "Yes: keep waiting for its release"),
        (0x1EE7, "...then for f1 to be pressed again..."),
        (0x1EEA, "...is it f1?"), (0x1EEC, "No: stay paused"),
        (0x1EEE, "...and released, so it does not pause again"),
        (0x1EF1, "...is f1 still held?"), (0x1EF3, "Yes: keep waiting, then play on"),
    ]:
        a.c(addr, text)
    for addr, name in [(0x1EE0, "wait_pause_release"), (0x1EE7, "wait_pause_press"),
                       (0x1EEE, "wait_pause_release_again"), (0x1EF5, "not_paused")]:
        a.label(addr, name)


def annotate_menu_and_panel_comments(a: Annotator) -> None:
    a.label(0x0581, "menu_key_loop")
    a.label(0x75AE, "draw_armour_rating")
    a.label(0x75C5, "draw_new_missile_icon")
    a.label(0x75E2, "draw_missile_damage")
    a.label(0x7611, "plot_keeping_x")
    a.block(0x75AE, "Redraw hero X's armour rating after a magic helmet: the small "
                    "digit 10 - hero_damage_taken on the shield in their panel "
                    "section.")
    a.block(0x75C5, "Add the icon for hero X's newest missile after a pile of weapons, "
                    "at the row draw_status_panel would give it (icon n at its row "
                    "&0D + 3n, which plot_panel_sprite offsets by the panel row "
                    "- &0E).")
    a.block(0x75E2, "Redraw hero X's missile damage after a magic sword, as a small "
                    "digit four rows above their panel row.")
    a.block(0x0581, "Read one key and act on it, then come back for the "
                    "next, until SPACE starts the game.")
    a.block(0x06C9, "Take the hero out of play if nobody is playing them.")
    for addr, text in [
        (0x0500, "VDU 28: the menu's window, the screen's full width..."),
        (0x0502, "Send VDU 28"), (0x0505, "Left column 0"), (0x0507, "Send the left column"), (0x050A, "Bottom row of the window"),
        (0x050C, "Send the bottom row"), (0x050F, "Right column 19, MODE 2's last"), (0x0511, "Send the right column"), (0x0514, "Top row 0"),
        (0x0516, "Send the top row"),
        (0x0519, "...VDU 12 to clear it"),
        (0x051B, "Send VDU 12: clear the window"),
        (0x051E, "Print the menu"),
        (0x0521, "Read keys until the players start the game"),
        (0x0524, "Fifteen strings, then one more by falling through"),
        (0x0526, "Y walks through menu_text from its start"), (0x0528, "Print one menu string"), (0x052B, "One fewer to print"), (0x052C, "More to print: loop"),
        (0x052E, "VDU 31: move the text cursor..."),
        (0x0530, "Send VDU 31"),
        (0x0533, "...to the string's column..."), (0x0536, "Send the column"),
        (0x0539, "Step to the row byte"),
        (0x053A, "...and row"), (0x053D, "Send the row"),
        (0x0540, "Print the characters..."), (0x0541, "...the next character..."), (0x0544, "...printed"),
        (0x0547, "...up to and including the carriage return"),
        (0x0549, "Not the CR yet: next character"),
        (0x054B, "Point at the next string"),
        (0x054C, "Return"),
        (0x054D, "\"NO \""), (0x054F, "...into the entry's first letter"), (0x0552, "O second..."), (0x0554, "...into the second letter"),
        (0x0557, "A space third, over YES's S..."), (0x0559, "...into the third letter"), (0x055C, "Return"),
        (0x055D, "\"YES\""), (0x055F, "...into the entry's first letter"), (0x0562, "E second..."), (0x0564, "...into the second letter"),
        (0x0567, "S third..."), (0x0569, "...into the third letter"), (0x056C, "Return"),
        (0x056D, "\"FF\" after the O"), (0x056F, "...over the N of ON..."), (0x0572, "...and the space after it"),
        (0x0575, "Return"),
        (0x0576, "\"N \" after the O"), (0x0578, "...over OFF's first F"), (0x057B, "A space..."),
        (0x057D, "...over OFF's second F"), (0x0580, "Return"),
        (0x0581, "Flush the input buffers"),
        (0x0583, "Discard any keys already waiting"),
        (0x0586, "OSBYTE &CA: set the keyboard lock states..."),
        (0x0588, "X = &20: CAPS LOCK on, SHIFT LOCK off"), (0x058A, "Y = 0: replace the status with X"),
        (0x058C, "Set it, whatever the Ranger's lock keys left"),
        (0x058F, "Wait for a key"),
        (0x0592, "SPACE?"), (0x0594, "Yes: start, if anyone is playing"),
        (0x0596, "Ignore anything but 1-6"),
        (0x0598, "Below '1': ignore it"), (0x059A, "Above '6'?"), (0x059C, "Yes: ignore it"),
        (0x059E, "Subtract '1'..."), (0x059F, "...so keys '1'-'6' become 0-5..."), (0x05A1, "...in X: a hero 0-3, or 4-5 for the sound"),
        (0x05A2, "Key 5 or 6?"), (0x05A4, "Yes: the sound switch"),
        (0x05A6, "1-4: Y = offset of the hero's YES/NO, 6 x X + &51..."),
        (0x05A7, "Keep 2 x the hero number"), (0x05A9, "4 x the hero number..."), (0x05AA, "...(carry clear for the add)"), (0x05AB, "...+ 2 x: 6 x the hero number"),
        (0x05AD, "...+ &51: this hero's YES/NO text"), (0x05AF, "Y = its offset in menu_text"),
        (0x05B0, "Toggle the hero between playing and absent..."),
        (0x05B3, "...by flipping the absent flag"), (0x05B5, "...stored back"),
        (0x05B8, "Now absent?"),
        (0x05BA, "No: playing, so YES"),
        (0x05BD, "...then reprint"),
        (0x05C0, "Absent: NO"),
        (0x05C3, "Reprint the menu with the change"),
        (0x05C6, "Next key"),
        (0x05C9, "SPACE: is any hero playing?"),
        (0x05CB, "Is this hero playing (absent flag 0)?"), (0x05CE, "Yes: return, and the game starts"),
        (0x05D0, "Absent: try the previous hero"), (0x05D1, "Heroes left to check: loop"),
        (0x05D3, "Nobody playing: ignore SPACE"),
        (0x05D6, "Return to new_game"),
        (0x05D7, "Sound: Y = offset of the second letter of ON/OFF"),
        (0x05D9, "Key 6 (A = key - \"1\")?"), (0x05DB, "Yes: sound off"),
        (0x05DD, "Key 5: ON..."),
        (0x05E0, "...with X = 0 to enable the sound"),
        (0x05E2, "Always: set the sound"),
        (0x05E4, "Key 6: OFF..."),
        (0x05E7, "...with X = 1 to suppress it"),
        (0x05E9, "OSBYTE &D2: sound suppression"),
        (0x05EB, "Y = 0: replace the setting with X"), (0x05ED, "Turn the sound on or off as chosen"),
        (0x05F0, "Reprint the menu with the change"),
        (0x05F3, "Next key"),

        (0x06B0, "Hero 0 first..."),
        (0x06B2, "...Y = the queue entry for the next absent hero"),
        (0x06B4, "Score of 10000 or more?"),
        (0x06B7, "...ten-thousands sprite small 1 or above?"), (0x06B9, "No: nothing under the score; check absence"),
        (0x06BB, "Yes: redraw it, lost when the screen was cleared"),
        (0x06BC, "Keep the hero number..."), (0x06BD, "...and the queue entry..."), (0x06BE, "...on the stack"), (0x06BF, "The digit's sprite..."),
        (0x06C2, "...drawn under the score with its 0000"), (0x06C5, "Recover the queue entry..."), (0x06C6, "...into Y"), (0x06C7, "Recover the hero number..."),
        (0x06C8, "...into X"),
        (0x06C9, "Switched off on the menu?"),
        (0x06CC, "No: playing; next hero"),
        (0x06CE, "Yes: take them out of play..."), (0x06D0, "...direction 0: not in play"),
        (0x06D3, "...step &63, so move_heroes passes them over..."), (0x06D5, "...as the hero's step count"),
        (0x06D8, "...frame 8: their death animation is over..."), (0x06DA, "...as the hero's frame"),
        (0x06DD, "...health tens below 0: dead..."), (0x06DF, "...as the health tens digit"),
        (0x06E2, "...units back below 0, undoing the panel's point"),
        (0x06E5, "...map x &1F, the dungeon's last column..."), (0x06E7, "...as the hero's map x"),
        (0x06EA, "...and a nobody_returns entry in the queue..."),
        (0x06EC, "...which a Cross of Resurrection skips"), (0x06EF, "The next absent hero takes the next entry"),
        (0x06F0, "Next hero"), (0x06F1, "All four heroes done?"), (0x06F3, "No: next hero"),
        (0x06F5, "Return"),

        (0x0400, "One more thousand: the hundreds digit carried"),
        (0x0403, "...and check the new digit"), (0x0406, "Past 9?"), (0x0408, "No: return; draw_score shows the new digit"),
        (0x040A, "Yes: thousands 0..."), (0x040C, "...stored for this hero"),
        (0x040F, "...and carry into the small ten-thousands digit"),
        (0x0412, "...and check the new digit"), (0x0415, "Past 9?"), (0x0417, "No: draw it under the score"),
        (0x0419, "Yes: it sticks at 9"), (0x041B, "...stored for this hero"),
        (0x041E, "Plot the ten-thousands digit under the score..."),
        (0x0420, "...at the panel's left column"), (0x0422, "...as the plot column"), (0x0424, "...hero_panel_y, read from workspace_template"), (0x0427, "...(carry clear for the add)"),
        (0x0428, "...+ &18: below the score's rows, &0C-&15"), (0x042A, "...as the plot row"), (0x042C, "Keep the hero number..."), (0x042D, "...on the stack while plotting"),
        (0x042E, "Plot the ten-thousands digit"),
        (0x0431, "...then four small 0s after it: sprite &71..."),
        (0x0433, "...(small 8, a solid bar, the shape of a small 0)"), (0x0435, "...four of them, for the 0000"), (0x0437, "Keep the count..."), (0x0438, "...on the stack while plotting"),
        (0x0439, "Two byte columns right..."), (0x043B, "...(second step)"), (0x043D, "Plot a 0 there"), (0x0440, "Recover the count..."),
        (0x0441, "...into Y"), (0x0442, "One fewer 0 to plot"), (0x0443, "More 0s: loop"), (0x0445, "Recover the hero number..."),
        (0x0446, "...into X"),
        (0x0447, "Return"),

        (0x75AE, "Armour rating = 10 - health lost per hit, drawn..."),
        (0x75AF, "...on the shield: the hero's panel row..."), (0x75B2, "...less twelve pixel rows..."), (0x75B4, "...as the plotting row"), (0x75B6, "...byte column &4E, nine right of the panel's left..."),
        (0x75B8, "...as the plotting column"), (0x75BA, "Small digit 10..."), (0x75BC, "...set the carry for the subtraction..."), (0x75BD, "...less the health lost per hit: 1 to 7"),
        (0x75C0, "...as the sprite to plot"),
        (0x75C2, "Plot it, keeping X, and return"),
        (0x75C5, "Icon for the newest missile allowed: missiles x 2..."),
        (0x75C8, "...(the shift)..."), (0x75C9, "...clear the carry for the addition..."), (0x75CA, "...+ missiles again: 3 rows per icon..."), (0x75CD, "...+ &0D, as in draw_status_panel's icon rows..."),
        (0x75CF, "...+ the hero's panel row..."), (0x75D2, "...set the carry for the subtraction..."), (0x75D3, "...- &0E, plot_panel_sprite's bias: the same row"), (0x75D5, "...as the plotting row"),
        (0x75D7, "...byte column &4B, the icons' column..."), (0x75D9, "...as the plotting column"),
        (0x75DB, "The missile icon..."), (0x75DD, "...as the sprite to plot"),
        (0x75DF, "Plot it, keeping X, and return"),
        (0x75E2, "Missile damage: byte column &4C..."), (0x75E4, "...as the plotting column"),
        (0x75E6, "...set the carry for the subtraction..."), (0x75E7, "...the hero's panel row..."), (0x75EA, "...less four pixel rows..."), (0x75EC, "...as the plotting row"),
        (0x75EE, "The damage, 1-9..."), (0x75F1, "...clear the carry for the addition..."), (0x75F2, "...+ one before small digit 1: its small digit"),
        (0x75F4, "...as the sprite to plot"),
        (0x75F6, "Plot it, keeping X, and return"),
        (0x75F9, "The bolt's byte column, &4A..."), (0x75FB, "...as the plotting column"),
        (0x75FD, "...set the carry for the subtraction..."),
        (0x75FE, "...the hero's panel row..."), (0x7601, "...8 rows above the hero's panel section"), (0x7603, "...as the icon's pixel row"),
        (0x7605, "Return"),
        (0x7606, "The lightning bolt: the hero has Boots of Speed..."), (0x7608, "...as the sprite to plot"),
        (0x760A, "...plotted where point_at_boots_icon pointed"),
        (0x760D, "The blank: the boots are lost..."), (0x760F, "...as the sprite to plot"),
        (0x7611, "Keep the hero number..."),
        (0x7612, "...on the stack: plot_sprite leaves X = 0"), (0x7613, "Plot the icon in the hero's panel section"), (0x7616, "Recover the hero number..."), (0x7617, "...in X again for the caller"),
        (0x7618, "Return"),
    ]:
        a.c(addr, text)


def annotate_victory_and_helpers(a: Annotator) -> None:
    a.label(0x10E6, "reset_call")
    a.expr(0x10E7, hexlit(0x0000))
    a.block(0x109A, "The game is won. Over the views, print the ending text "
                    "that level 25's maps hold, wait for a key, and reset.")
    a.block(0x110A, "One pass of the sequence: raise the pitch, shorten the "
                    "wait, sound the bell, draw the ring, dissolve a byte of "
                    "the Chalice once at full speed, and wait.")
    for addr, name, description in [
        (0x0080, "ring_x", "Map x of the cell being drawn in the victory ring."),
        (0x0081, "ring_y", "Map y of the cell being drawn in the victory ring."),
        (0x0082, "victory_sprite", "Sprite drawn in the victory ring: a sparkle, &16-&19, or the blank, &15, to erase it."),
        (0x0084, "victory_delay", "Wait between passes of the victory sequence, in units of 255 loops: &E6 at the start, one less each pass, down to 1."),
        (0x008D, "victory_pitch_step", "Amount the victory tone's pitch rises each pass: 1 at the start, one more each time the pitch wraps past 255."),
        (0x008E, "victory_steps_left", "Pitch wraps left before the victory sequence ends: &32 (50) at the start."),
        (0x008F, "victory_pitch", "Pitch of the bell in the victory sequence, set with OSBYTE &D5."),
    ]:
        a.label(addr, name, group="zero_page", access="rw", description=description)
    for addr, text in [
        (0x1070, "Which level is this?"),
        (0x1073, "The Chalice lies only on level 25"), (0x1075, "Another level: no Chalice to find"),
        (0x1077, "Has a hero reached a Chalice cell, x &1A-&1B, y 4-5?"),
        (0x1079, "The cell hero X last stepped or bumped into..."), (0x107C, "...in the Chalice's left column?"), (0x107E, "Yes: check the row"), (0x1080, "...or its right column?"),
        (0x1082, "Yes: check the row"),
        (0x1084, "Next hero"), (0x1085, "Past hero 3?"), (0x1087, "No: check the next hero"),
        (0x1089, "No hero at the Chalice: on with the frame"),
        (0x108A, "...and that cell's row..."),
        (0x108D, "...in the Chalice's top row?"), (0x108F, "Yes: the Chalice is found"), (0x1091, "...or its bottom row?"), (0x1093, "Yes: the Chalice is found"),
        (0x1095, "No: next hero"),
        (0x1097, "Sparkles, rising tone, the Chalice dissolves"),
        (0x109A, "VDU 28,0,24,16,0: a window over the four views..."),
        (0x10B3, "...VDU 12 to clear it"),
        (0x10B8, "The ending text: 140 bytes from room_walls + &3A..."),
        (0x10BA, "Next byte of level 25's wall map, which is text"), (0x10BD, "Print it in the game's font"), (0x10C0, "Next byte"), (0x10C1, "All 140 printed?"),
        (0x10C3, "No: print the next"),
        (0x10C5, "...then the ending message, at object_free_map + &3A"),
        (0x10C7, "Next character of the ending message"), (0x10CA, "Print it, the zero included"), (0x10CD, "Next character"), (0x10CE, "The zero that ends the message?"),
        (0x10D0, "No: print the next"),
        (0x10D2, "OSBYTE &0F, X non-zero: flush the input buffer..."),
        (0x10D4, "...so keys pressed in the sequence cannot skip the text"),
        (0x10D7, "Wait for a key once the ending text has been read"),
        (0x10DA, "Copy the RESET vector into the JSR below..."),
        (0x10DD, "...low byte"), (0x10E0, "...high byte..."), (0x10E3, "...into the JSR's operand"),
        (0x10E6, "...and call it: the game ends with a reset"),
        (0x10E9, "OSBYTE &D4: the bell's envelope byte..."),
        (0x10EB, "...EOR 8; Y, not set, is the AND mask"), (0x10ED, "Set the bell's envelope for the victory tone"),
        (0x10F0, "No pixel offsets"),
        (0x10F2, "...across..."), (0x10F4, "...or down, so sprites sit square in their cells"),
        (0x10F6, "The ring starts with the first sparkle"),
        (0x10F8, "...as the ring's sprite"),
        (0x10FA, "Tone starts at pitch 0..."), (0x10FC, "...for the bell"),
        (0x10FE, "...with the passes &E6 wait units apart..."), (0x1100, "...the delay loop's outer count"),
        (0x1102, "...for &32 (50) sweeps of the pitch..."), (0x1104, "...counted down as the pitch wraps"),
        (0x1106, "...rising by 1 a pass in the first sweep"), (0x1108, "...the pitch's first step"),
        (0x110A, "Start a pass: raise the bell's pitch"),
        (0x110B, "...current pitch..."), (0x110D, "...plus the step..."), (0x110F, "...becomes the new pitch, wrapping past 255"),
        (0x1111, "No wrap: the sweep goes on"),
        (0x1113, "Wrapped: the next sweep climbs one step faster..."),
        (0x1115, "...and one fewer sweep is left"),
        (0x1117, "Sweeps left: go on"),
        (0x1119, "50 sweeps done: erase the ring and the Chalice"),
        (0x111C, "Shorten the wait: the passes come faster..."), (0x111E, "Not yet zero: keep it"),
        (0x1120, "...but never below 1..."), (0x1122, "...the full speed the rest of the sequence runs at"),
        (0x1124, "OSBYTE &D5: the bell's pitch..."),
        (0x1126, "...set it from victory_pitch"), (0x1128, "Set it: the bell now sounds at that pitch"),
        (0x112B, "...and sound the bell"), (0x112D, "Send BEL: the bell sounds at the new pitch"),
        (0x1130, "Draw the ring, the sparkles one side further round"),
        (0x1133, "At full speed, dissolve the Chalice a byte at a time"),
        (0x1135, "Delay down to 1: the sequence is at full speed"), (0x1137, "Not yet: just wait"), (0x1139, "Full speed: clear one more byte of the Chalice"),
        (0x113C, "Wait victory_delay units before the next pass"),
        (0x113E, "Each unit is 255 inner loops, about 1,280 cycles"), (0x1140, "Count down the inner loop"), (0x1141, "Until it reaches zero"), (0x1143, "Count down the delay units"),
        (0x1144, "Until the delay is spent (Y = 0 for the next OSBYTE)"),
        (0x1146, "Next pass"),
        (0x1149, "Start at x &1C, y 3: the ring runs round the Chalice's "
                 "four cells"),
        (0x114B, "...as the ring's x..."), (0x114D, "...one row above the Chalice..."), (0x114F, "...as the ring's y"),
        (0x1151, "Plot the top-right corner, first of the top side"), (0x1154, "Left..."), (0x1156, "Plot the next cell along the top"),
        (0x1159, "Left..."), (0x115B, "Plot the last of the top side's three"),
        (0x115E, "Keep the sprite..."), (0x1160, "...in victory_sprite_copy, which nothing reads"),
        (0x1163, "...and move to the next sparkle for the left side"),
        (0x1166, "Left..."), (0x1168, "Plot the top-left corner"),
        (0x116B, "Down..."), (0x116D, "Plot down the left side"),
        (0x1170, "Down..."), (0x1172, "Plot down the left side"),
        (0x1175, "Next sparkle for the bottom side"),
        (0x1178, "Down..."), (0x117A, "Plot the bottom-left corner"),
        (0x117D, "Right..."), (0x117F, "Plot along the bottom"),
        (0x1182, "Right..."), (0x1184, "Plot along the bottom"),
        (0x1187, "Next sparkle for the right side, kept for the next ring"),
        (0x118A, "Right..."), (0x118C, "Plot the bottom-right corner"),
        (0x118F, "Up..."), (0x1191, "Plot up the right side"),
        (0x1194, "Up..."), (0x1196, "Plot up the right side, closing the ring"),
        (0x1199, "Return"),
        (0x119A, "Plot the victory sprite at the ring cell"),
        (0x119C, "...as the cell's x"), (0x119F, "...and its y..."), (0x11A1, "...as the cell's y"), (0x11A4, "...with the ring's current sprite..."),
        (0x11A6, "...as the sprite to plot"), (0x11A8, "...in every view that shows the cell"), (0x11AB, "Return"),
        (0x11AC, "Erasing (sprite &15)? Keep it"),
        (0x11AE, "...the blank sprite?"), (0x11B0, "Yes: keep erasing"),
        (0x11B2, "Next sparkle, &16-&19 in turn"),
        (0x11B3, "...the next sparkle sprite"), (0x11B5, "Past the last sparkle?"), (0x11B7, "No: use it"), (0x11B9, "Yes: back to the first sparkle"),
        (0x11BB, "Make it the ring's sprite"), (0x11BD, "Return"),
        (0x11BE, "Pick a byte of the Chalice: System VIA timer 1..."),
        (0x11C1, "...mixed with the MOS's last interrupt A..."), (0x11C3, "...and more MOS workspace, for randomness"),
        (0x11C5, "Within the Chalice's &C0 bytes?"),
        (0x11C7, "No: nothing dissolves this pass"),
        (0x11C9, "Clear it..."), (0x11CA, "...to zero, a black pair of pixels..."), (0x11CC, "...in the Chalice's sprite data"),
        (0x11CF, "...and replot the Chalice with the hole in it"),
        (0x11D2, "Return"),
        (0x11D3, "Erase the ring"),
        (0x11D5, "...by making the blank the ring's sprite..."), (0x11D7, "...and drawing the ring with it"),
        (0x11DA, "Clear what is left of the Chalice..."),
        (0x11DC, "...to zeros"), (0x11DE, "Clear a byte of the Chalice's sprite data"), (0x11E1, "Next byte down"), (0x11E2, "&C1 bytes: the &C0 and the unused byte after"),
        (0x11E4, "...and replot it, now black: the Chalice is gone"),
        (0x11E7, "Pause 255 vertical syncs (about five seconds)"),
        (0x11E9, "...which the MOS counts down at each vsync"), (0x11EC, "Read the count"), (0x11EF, "Until it reaches zero"),
        (0x11F1, "Return to check_for_victory for the ending text"),
        (0x11F2, "The Chalice's top-left cell, x &1A, y 4..."),
        (0x11F4, "...as the cell's x"), (0x11F7, "...and y 4..."), (0x11F9, "...as the cell's y"),
        (0x11FC, "...sprite &73, 2 x 2 cells..."), (0x11FE, "...as the sprite to plot..."),
        (0x1200, "...plotted in every view showing it"),
        (0x1203, "Return"),

        (0x2050, "The hero's sprites base + 1 to base + 7"),
        (0x2051, "...the hero's sprite base..."), (0x2054, "...+1: their first sprite..."), (0x2056, "...in X, for the height loop..."), (0x2057, "...and in Y, for the width loop"),
        (0x2058, "...+7: stop before base + 8, left frame 1"), (0x205A, "...kept as the end"),
        (0x205D, "Widths back to 4 bytes, a whole cell..."),
        (0x205F, "Full width"), (0x2062, "Next sprite"), (0x2063, "Reached the end?"), (0x2066, "No: widen the next"),
        (0x2068, "...from the first sprite again"), (0x2069, "...into Y"),
        (0x206A, "...heights back to 12 rows, a whole cell"),
        (0x206C, "Full height"), (0x206F, "Next sprite"), (0x2070, "Reached the end?"), (0x2073, "No: restore the next"),
        (0x2075, "Return"),
        (0x2091, "From the hero's cell (the exit)..."),
        (0x2094, "...as cell_x..."), (0x2097, "...and the hero's y..."), (0x209A, "...as cell_y"),
        (0x209D, "...find a wall-free cell next to it"),
        (0x209E, "Keep the hero number..."), (0x209F, "...on the stack across the search"), (0x20A2, "Recover the hero number..."), (0x20A3, "...into X"),
        (0x20A4, "Put the hero's key there (entry 0 if none)"),
        (0x20A7, "...the free cell's x..."), (0x20AA, "...as the key's x..."), (0x20AD, "...and its y..."), (0x20B0, "...as the key's y"),
        (0x20B3, "The hero carries no key"),
        (0x20B5, "...in the hero's key slot"),
        (0x20B8, "Erase the key icon from the hero's panel"),
        (0x20BA, "...as the sprite to plot"), (0x20BC, "...from the hero's panel row..."), (0x20BF, "...set carry to subtract"), (0x20C0, "...less 13: the key icon's row..."),
        (0x20C2, "...as plot_y"), (0x20C4, "...in panel column panel_left + 5..."), (0x20C6, "...as plot_x"), (0x20C8, "Keep the hero number..."),
        (0x20C9, "...on the stack across plot_sprite"), (0x20CA, "Plot the blank icon over the key icon"), (0x20CD, "Recover the hero number..."), (0x20CE, "...into X"),
        (0x20CF, "Return"),
        (0x20D0, "Try the cell above first"),
        (0x20D3, "...is there a wall in it?"), (0x20D6, "Y = 0 if no wall there"), (0x20D8, "Wall: try the cell to the right"),
        (0x20DA, "No wall: leave cell_x, cell_y on it"),
        (0x20DB, "Then the cell to the right"),
        (0x20DE, "...x + 1 (y back to the starting row)"), (0x20E1, "...is there a wall in it?"), (0x20E4, "Y = 0 if no wall there"),
        (0x20E6, "Wall: try the cell below"), (0x20E8, "No wall: leave cell_x, cell_y on it"),
        (0x20E9, "Then the cell below"),
        (0x20EC, "...y + 1 (x back to the starting column)"), (0x20EF, "...is there a wall in it?"), (0x20F2, "Y = 0 if no wall there"),
        (0x20F4, "Wall: fall back on the cell to the left"), (0x20F6, "No wall: leave cell_x, cell_y on it"),
        (0x20F7, "Otherwise the cell to the left"),
        (0x20FA, "...x - 1: unchecked, the last resort"), (0x20FD, "Return, Y non-zero"),

        (0x7305, "No pixel offsets"),
        (0x7307, "...across the cell horizontally..."), (0x7309, "...and vertically: objects sit squarely in their cells"),
        (0x730B, "Objects 30 to 1: plot each at its cell"),
        (0x730D, "This object's map x..."), (0x7310, "...is the cell to plot at..."), (0x7313, "...and its map y..."), (0x7316, "...the cell's row"),
        (0x7319, "Its type, which is also its sprite..."), (0x731C, "...as the sprite to plot"), (0x731E, "Keep the object number..."), (0x731F, "...across the plot"),
        (0x7320, "Plot it in every view showing its cell"), (0x7323, "Recover the object number..."), (0x7324, "...into X"), (0x7325, "Next object down"),
        (0x7326, "Until object 1 is drawn (object 0 is not drawn)"), (0x7328, "Return"),

        (0x7A94, "...its number back in X, which find_creature changed"),
        (0x7A95, "The cell it was in..."), (0x7A98, "...back in monster_x"), (0x7A9B, "...and its row..."), (0x7A9E, "...back in monster_y"),
        (0x7AA1, "No step under way:"),
        (0x7AA3, "...step count 0"), (0x7AA6, "...no horizontal offset"), (0x7AA9, "...no vertical offset"),
        (0x7AAC, "Turn a random way, from the System VIA's timer"),
        (0x7AAF, "A random 0-7..."), (0x7AB1, "...plus 8..."), (0x7AB2, "...a sprite &08-&0F"), (0x7AB4, "Face the monster that way"),
        (0x7AB7, "Odd sprites (9, &0B, &0D, &0F) are the facings"), (0x7AB9, "Odd: draw it; it tries the new way next frame"), (0x7ABB, "Even: round it up to the next facing"), (0x7ABE, "Draw it; it tries the new way next frame"),
    ]:
        a.c(addr, text)


def annotate_shared_continuations(a: Annotator) -> None:
    for addr, text in [
        (0x0D35, "Y = 0: replace the setting with X"),
        (0x0D3E, "Y = 0: replace the setting with X"),
        (0x0D47, "Y = 0: replace the setting with X"),
        (0x0D50, "Y = 0: replace the setting with X"),
        (0x0E08, 'Give each hero their starting attributes and score'),
        (0x0E09, "Reset hero X"),
        (0x0E0C, "Next hero"),
        (0x0E0D, "All four done?"),
        (0x0E0F, "No: reset the next"),
        (0x0E11, "Then the players choose heroes and sound"),
        (0x0E88, "Send VDU 28"),
        (0x0E8B, "Left column 0"),
        (0x0E8D, "Send the left column"),
        (0x0E90, "Bottom row 24"),
        (0x0E92, "Send the bottom row"),
        (0x0E95, "Right column 16, short of the status panel"),
        (0x0E97, "Send the right column"),
        (0x0E9A, "Top row 0"),
        (0x0E9C, "Send the top row"),
        (0x0EA1, "Send VDU 12: clear the window"),
        (0x109C, "Send VDU 28"),
        (0x109F, "Left column 0"),
        (0x10A1, "Send the left column"),
        (0x10A4, "Bottom row 24, the last on show"),
        (0x10A6, "Send the bottom row"),
        (0x10A9, "Right column 16: the status panel stays"),
        (0x10AB, "Send the right column"),
        (0x10AE, "Top row 0"),
        (0x10B0, "Send the top row"),
        (0x10B5, "Clear the views for the ending text"),
        (0x1419, "Send it"),
        (0x141E, "Send the register number"),
        (0x1423, "Send it: show all 25 rows for play"),
        (0x1428, "Send the first zero"),
        (0x142B, "Send the second zero"),
        (0x142E, "Send the third zero"),
        (0x1431, "Send the fourth zero"),
        (0x1434, "Send the fifth zero"),
        (0x1437, "Send the sixth zero"),
        (0x143C, "...low byte in plot_x..."),
        (0x1440, "...in plot_y, as draw_view_frames expects"),
        (0x14AD, "No hero is going down the exit"),
        (0x14B0, "Shrinking hero's x offset at shrink 3: 0..."),
        (0x14B3, "...at shrink 4 (exit_offsets_y doubles as x 4)..."),
        (0x14B6, "...and the y offset at shrink 4"),
        (0x14BC, 'Offsets of 1 for the exit animation'),
        (0x14BE, "...x offset at shrink 1..."),
        (0x14C1, "...x offset at shrink 2..."),
        (0x14C4, "...and y offset at shrink 3"),
        (0x14C7, "&FF: no hero is shrunk"),
        (0x14C9, "...so no hero's sprites need restoring"),
        (0x14CC, "Shrinking hero's y offset at shrink 1: 5..."),
        (0x14CE, "...for y offset 1"),
        (0x14D1, "...and at shrink 2: 3"),
        (0x14D3, "...for y offset 2"),
        (0x1512, "Object's x in the level file..."),
        (0x1515, "...becomes its map x"),
        (0x1518, "Its y..."),
        (0x151B, "...becomes its map y"),
        (0x151E, "Its type, which is also its sprite..."),
        (0x1521, "...becomes its object type"),
        (0x1529, "Door's x in the level file..."),
        (0x152C, "...becomes its map x"),
        (0x152F, "Its y..."),
        (0x1532, "...becomes its map y"),
        (0x1535, "Its sprite, upright or across..."),
        (0x1538, "...becomes its sprite"),
        (0x1540, "Key's x in the level file..."),
        (0x1543, "...becomes its map x"),
        (0x1546, "Its y..."),
        (0x1549, "...becomes its map y"),
        (0x1551, "Trapdoor's x in the level file..."),
        (0x1554, "...becomes its map x"),
        (0x1557, "Its y..."),
        (0x155A, "...becomes its map y"),
        (0x1564, "Byte of the level's wall map..."),
        (0x1567, "...into room_walls, which test_wall reads"),
        (0x156A, "Byte of the level's object-free map..."),
        (0x156D, "...into object_free_map, which test_object_free reads"),
        (0x1577, "Byte of the level's wall block..."),
        (0x157A, "...becomes sprite 0, the wall in every room"),
        (0x159A, "Zero for every entry cleared"),
        (0x159C, "Queue entry X empty: nobody waits to return"),
        (0x159F, "Hero X carries no key"),
        (0x15A2, "...and has swapped none"),
        (0x15A5, "No door-check cell..."),
        (0x15A8, "...in x or y"),
        (0x161A, 'VDU 28: a text window over the whole screen...'),
        (0x161C, "Send VDU 28"),
        (0x161F, "Left column 0"),
        (0x1621, "Send the left column"),
        (0x1624, "Bottom row of the window (24 in play)"),
        (0x1626, "Send the bottom row"),
        (0x1629, "Right column 19: the full MODE 2 width"),
        (0x162B, "Send the right column"),
        (0x162E, "Top row 0"),
        (0x1630, "Send the top row"),
        (0x1633, '...VDU 12 to clear it'),
        (0x1635, "Send it: the window clears to the background"),
        (0x1638, 'Return'),
        (0x16A0, 'Define the exit envelope...'),
        (0x16A2, "...high byte"),
        (0x16A4, "...OSWORD 8: ENVELOPE..."),
        (0x16A9, '...and play the exit sound'),
        (0x16AB, "...high byte"),
        (0x16AD, "...OSWORD 7: SOUND..."),
        (0x16B2, 'Append a marker to returning_hero_queue...'),
        (0x16B4, "Entry X of the queue"),
        (0x16B7, "In use: try the next"),
        (0x16B9, 'Empty: add a &64 marker there'),
        (0x16BB, "...in the first empty entry, behind those waiting"),
        (0x16BE, 'Return to hero_enters_exit'),
        (0x16BF, 'Next entry'),
        (0x16C0, "Keep looking (at most four entries are in use)"),
        (0x1E10, "...as the sprite to plot"),
        (0x1E12, "...using the hero's panel row..."),
        (0x1E15, "...set carry to subtract"),
        (0x1E16, "...less 13: the key icon's row..."),
        (0x1E18, "...as plot_y"),
        (0x1E1A, "...in panel column panel_left + 5..."),
        (0x1E1C, "...as plot_x"),
        (0x1E1E, "Keep the hero number..."),
        (0x1E1F, "...on the stack across plot_sprite"),
        (0x1E20, "Plot the blank icon over the key icon"),
        (0x1E23, "Recover the hero number..."),
        (0x1E24, "...into X"),
        (0x1FFD, "...the hero's sprite base..."),
        (0x2000, "...+1: their first sprite..."),
        (0x2002, "...in Y, for the height loop..."),
        (0x2003, "...and in X, for the width loop"),
        (0x2004, "...+7: stop before base + 8, left frame 1"),
        (0x2006, "...kept as the end"),
        (0x2009, "One byte (two pixels) narrower"),
        (0x200C, "Next sprite"),
        (0x200D, "Reached the end?"),
        (0x2010, "No: narrow the next"),
        (0x2012, 'Three rows shorter...'),
        (0x2013, "...from the first sprite again"),
        (0x2014, "...set carry to subtract"),
        (0x2015, "This sprite's height..."),
        (0x2018, "...less three rows..."),
        (0x201A, "...stored back"),
        (0x201D, "Next sprite"),
        (0x201E, "Reached the end?"),
        (0x2021, "No: shorten the next"),
        (0x6FE8, "...x back..."),
        (0x6FEB, "...and y back..."),
        (0x6FEE, "...so the hero stays out of the monster's cell"),
        (0x6FF1, "The move is over: the hero stands in a whole cell..."),
        (0x6FF3, "...no step under way..."),
        (0x6FF6, "...no horizontal offset..."),
        (0x6FF9, "...and no vertical offset"),
        (0x7024, "...x back..."),
        (0x7027, "...and y back..."),
        (0x702A, "...so heroes in play never share a cell"),
        (0x702D, "The move is over: the hero stands in a whole cell..."),
        (0x702F, "...no step under way..."),
        (0x7032, "...no horizontal offset..."),
        (0x7035, "...and no vertical offset"),
        (0x7038, "Erase the old image, draw the hero in their cell"),
        (0x72BD, "Row: the hero's panel section..."),
        (0x72C0, "...twelve rows down, below the health"),
        (0x72C2, "...as the plotting row"),
        (0x72C4, "Thousands digit in the panel's left column"),
        (0x72C6, "...as the plotting column"),
        (0x72C8, "The thousands digit sprite..."),
        (0x72CB, "...as the sprite to plot"),
        (0x72CD, "Keep the hero number..."),
        (0x72CE, "...across the plot"),
        (0x72CF, "Plot the thousands digit"),
        (0x72D2, "Recover the hero number..."),
        (0x72D3, "...into X"),
        (0x72D7, "...as the sprite to plot"),
        (0x72D9, "...three byte columns right (&48)..."),
        (0x72DB, "...as the plotting column"),
        (0x72DD, "Keep the hero number..."),
        (0x72DE, "...across the plot"),
        (0x72DF, "Plot the hundreds digit"),
        (0x72E2, "Recover the hero number..."),
        (0x72E3, "...into X"),
        (0x72E7, "...as the sprite to plot"),
        (0x72E9, "...six byte columns right (&4B)..."),
        (0x72EB, "...as the plotting column"),
        (0x72ED, "Keep the hero number..."),
        (0x72EE, "...across the plot"),
        (0x72EF, "Plot the tens digit"),
        (0x72F2, "Recover the hero number..."),
        (0x72F3, "...into X"),
        (0x72F7, "...as the sprite to plot"),
        (0x72F9, "...nine byte columns right (&4E)..."),
        (0x72FB, "...as the plotting column"),
        (0x72FD, "Keep the hero number..."),
        (0x72FE, "...across the plot"),
        (0x72FF, "Plot the units digit"),
        (0x7302, "Recover the hero number..."),
        (0x7303, "...into X"),
        (0x7364, "Keep the hero..."),
        (0x7365, "...and the object..."),
        (0x7366, "...across the OSWORD calls"),
        (0x7367, "Envelope 3 as the treasure envelope..."),
        (0x7369, "...high byte..."),
        (0x736B, "...OSWORD 8, ENVELOPE"),
        (0x7370, "...then the treasure sound with it"),
        (0x7372, "...high byte..."),
        (0x7374, "...OSWORD 7, SOUND"),
        (0x7379, "Recover the object..."),
        (0x737A, "...into Y..."),
        (0x737B, "...and the hero..."),
        (0x737C, "...into X"),
        (0x73B2, "Keep the hero across the OSWORD call"),
        (0x73B3, "SOUND food_sound..."),
        (0x73B5, "...high byte..."),
        (0x73B7, "...OSWORD 7, SOUND"),
        (0x73BC, "Recover the hero..."),
        (0x73BD, "...into X"),
        (0x73BE, "Recover the object number..."),
        (0x73BF, "...into Y"),
        (0x73DA, "Keep the hero..."),
        (0x73DB, "...and the destination teleporter..."),
        (0x73DC, "...across the OSWORD call"),
        (0x73DD, "SOUND teleport_sound..."),
        (0x73DF, "...high byte..."),
        (0x73E1, "...OSWORD 7, SOUND"),
        (0x73E6, "Recover the destination..."),
        (0x73E7, "...into Y..."),
        (0x73E8, "...and the hero..."),
        (0x73E9, "...into X"),
        (0x74C2, "Keep the hero across the sound"),
        (0x74C3, "A = (type AND 7) x 4: unused, as play_pickup_sound..."),
        (0x74C6, "...sets its own registers..."),
        (0x74C8, "...x 2..."),
        (0x74C9, "...x 4"),
        (0x74CA, "Play the pickup sound"),
        (0x74CD, "Recover the hero..."),
        (0x74CE, "...into X"),
        (0x752F, "...as cell_x..."),
        (0x7532, "...and its map y..."),
        (0x7535, "...as cell_y"),
        (0x7538, "Keep the hero..."),
        (0x7539, "...across test_wall"),
        (0x753A, "Only for map_ptr: the offset of the cell's room"),
        (0x753D, "Recover the hero..."),
        (0x753E, "...into X"),
        (0x7549, "No: try hero 1"),
        (0x754B, "Hero 0: redraw the top-left view"),
        (0x754E, "Recover the hero..."),
        (0x754F, "...into X"),
        (0x7550, 'Return'),
        (0x7551, "Hero 1, the top-right view?"),
        (0x7553, "No: try hero 2"),
        (0x7555, "Yes: redraw it"),
        (0x7558, "Recover the hero..."),
        (0x7559, "...into X"),
        (0x755A, 'Return'),
        (0x755B, "Hero 2, the bottom-left view?"),
        (0x755D, "No: hero 3"),
        (0x755F, "Yes: redraw it"),
        (0x7562, "Recover the hero..."),
        (0x7563, "...into X"),
        (0x7564, 'Return'),
        (0x7565, "Hero 3: redraw the bottom-right view"),
        (0x7568, "Recover the hero..."),
        (0x7569, "...into X"),
        (0x756A, 'Return'),
        (0x757D, "Keep the monster..."),
        (0x757E, "...and the missile slot..."),
        (0x757F, "...across the OSWORD call"),
        (0x7580, "SOUND hit_sound..."),
        (0x7582, "...high byte..."),
        (0x7584, "...OSWORD 7, SOUND"),
        (0x7589, "Recover the missile slot..."),
        (0x758A, "...into Y..."),
        (0x758B, "...and the monster..."),
        (0x758C, "...into X"),
        (0x762D, "...on the stack: X carries the OSWORD blocks"),
        (0x762E, "XY = magic_envelope..."),
        (0x7630, "...its high byte"),
        (0x7632, "OSWORD 8: define the magic envelope"),
        (0x7637, "XY = magic_sound..."),
        (0x7639, "...its high byte"),
        (0x763B, "OSWORD 7: make the magic sound"),
        (0x7640, "Recover the hero number..."),
        (0x7641, "...the caster, in X again"),
        (0x764D, "Ranger: go and take 6 points"),
        (0x7788, "The Ranger's view, top left"),
        (0x778B, "The Magic-User's view, top right"),
        (0x778E, "The Barbarian's view, bottom left"),
        (0x7791, "The Fighter's view, bottom right"),
        (0x7794, "Return"),
        (0x77A9, "...as the view's top pixel row"),
        (0x77AD, "...as the view's left screen column"),
        (0x77B3, "...whose walls draw_room reads"),
        (0x77BB, "...as the view's top pixel row"),
        (0x77BF, "...as the view's left screen column"),
        (0x77C5, "...whose walls draw_room reads"),
        (0x77CD, "...as the view's top pixel row"),
        (0x77D1, "...as the view's left screen column"),
        (0x77D7, "...whose walls draw_room reads"),
        (0x77FE, "This door's map x..."),
        (0x7801, "...as the cell to plot"),
        (0x7804, "...and its map y"),
        (0x7807, "...likewise"),
        (0x780A, "Doors sit squarely in their cells:"),
        (0x780C, "...no horizontal offset..."),
        (0x780E, "...and no vertical offset"),
        (0x7810, "Its sprite, vertical or horizontal..."),
        (0x7813, "...to plot"),
        (0x7815, "Keep the door number..."),
        (0x7816, "...on the stack"),
        (0x7817, "Plot it in every view showing its cell"),
        (0x781A, "Recover the door number..."),
        (0x781B, "...into X"),
        (0x78B6, "...view's left column..."),
        (0x78B8, "...plus the column within the room"),
        (0x78BB, "...as the screen column"),
        (0x78BD, "...view's top row, 1..."),
        (0x78BF, "...plus the row within the room"),
        (0x78C2, "...as the screen row"),
        (0x78C4, "Draw it in the top-right view"),
        (0x78D0, "...view's left column, 1..."),
        (0x78D2, "...plus the column within the room"),
        (0x78D5, "...as the screen column"),
        (0x78D7, "...view's top row..."),
        (0x78D9, "...plus the row within the room"),
        (0x78DC, "...as the screen row"),
        (0x78DE, "Draw it in the bottom-left view"),
        (0x78EA, "...view's left column..."),
        (0x78EC, "...plus the column within the room"),
        (0x78EF, "...as the screen column"),
        (0x78F1, "...view's top row..."),
        (0x78F3, "...plus the row within the room"),
        (0x78F6, "...as the screen row"),
        (0x78F8, "Draw it in the bottom-right view"),
        (0x78FF, "...the room's top row of cells (y AND &F8)"),
        (0x7901, "...kept to multiply..."),
        (0x7904, "...(no carry into the sum)"),
        (0x7905, "...x 2..."),
        (0x7908, "...x 3..."),
        (0x790B, "...x 4: a room row is 32 bytes of room_walls"),
        (0x7910, "Add the room's left column of cells..."),
        (0x7913, "...cell_x AND &F8: 8 bytes per room across"),
        (0x7915, "...to the pointer's low byte..."),
        (0x7917, "...map_ptr: the room's eight wall bytes"),
        (0x793B, "...the room's top row of cells (y AND &F8)"),
        (0x793D, "...kept to multiply..."),
        (0x7940, "...(no carry into the sum)"),
        (0x7941, "...x 2..."),
        (0x7944, "...x 3..."),
        (0x7947, "...x 4: the map has room_walls' layout"),
        (0x794C, "Add the room's left column of cells..."),
        (0x794F, "...cell_x AND &F8: 8 bytes per room across"),
        (0x7951, "...to the pointer's low byte..."),
        (0x7953, "...map_ptr: the room's eight map bytes"),
        (0x795C, "...cell_x AND 7..."),
        (0x795E, "...indexes bit_masks..."),
        (0x795F, "...for the cell's bit, leftmost bit 7"),
        (0x7962, "...kept in scratch"),
        (0x7968, "...cell_y AND 7..."),
        (0x796A, "...indexes the room's bytes"),
        (0x796D, "...with the mask: zero if an object may lie here"),
    ]:
        a.c(addr, text)


def annotate_cassette_continuations(a: Annotator) -> None:
    for addr, text in [
        (0x0D6B, 'Start a new game'),
        (0x0E32, '...(always branches)'),
        (0x0E49, "...second..."),
        (0x0E4A, "...third..."),
        (0x0E4B, "...fourth: the tens digit"),
        (0x15B6, "Send VDU 17: set the text colour"),
        (0x15BB, "Send it: the digits print in colour 6"),
        (0x15C3, "...at byte column 27, as plot_x..."),
        (0x15C7, "...as plot_y"),
        (0x15CB, "...as the sprite to plot"),
        (0x15D2, "Send VDU 31: move the text cursor"),
        (0x15D7, "Send the column"),
        (0x15DC, "Send the row: the digits go just right of LEVEL"),
        (0x15E4, "...down..."),
        (0x15E5, "...to the..."),
        (0x15E6, "...low nibble: the tens, 0-2"),
        (0x15E7, "Clear the carry for the add"),
        (0x15F0, "Clear the carry for the add"),
        (0x15F8, "Send VDU 28"),
        (0x15FB, "Left column 1"),
        (0x15FD, "Send the left column"),
        (0x1600, "Bottom row 22"),
        (0x1602, "Send the bottom row"),
        (0x1607, "Send the right column"),
        (0x160C, "...send the window's top row"),
        (0x160F, "COLOUR 2: text in colour 2 from now on..."),
        (0x1611, "...send VDU 17 (COLOUR)"),
        (0x1616, "...send it"),
        (0x1EF5, 'Return to play_level'),
    ]:
        a.c(addr, text)




def annotate_hack_continuations(a: Annotator) -> None:
    for addr, text in [
        (0x0E00, 'New game: no levels played yet...'),
        (0x0E02, "...level_number 0, counted up by show_level_number..."),
        (0x0E05, "...and level_bcd 0, counted up by level_loop"),
        (0x1448, "Send VDU 23"),
        (0x144B, "0: a 6845 register setting follows"),
        (0x144D, "Send it"),
        (0x1452, "Send it"),
        (0x1457, "Send it: the bottom two rows go blank while loading"),
        (0x145C, "Send the first zero of six"),
        (0x145F, "Send the second zero"),
        (0x1462, "Send the third zero"),
        (0x1465, "Send the fourth zero"),
        (0x1468, "Send the fifth zero"),
        (0x146B, "Send the sixth zero"),
    ]:
        a.c(addr, text)



def annotate_branch_labels(a: Annotator) -> None:
    """Names for the branch targets within the game's routines."""
    for addr, name in {
        0x091D: "plot_sprite_row",
        0x0929: "plot_sprite_byte",
        0x0938: "plot_sprite_next_data",
        0x093E: "plot_sprite_count_byte",
        0x0961: "plot_sprite_next_row",
        0x0D63: "set_wrchv_low",
        0x099F: "screen_address_done", 0x1089: "no_victory",
        0x11D2: "dissolve_done", 0x1F35: "play_level_done",
        0x70C9: "move_heroes_done", 0x7220: "move_missiles_done",
        0x7476: "collect_objects_done", 0x78FB: "plot_at_cell_done",
        0x7B30: "update_monsters_done", 0x7C8B: "monster_step_done",
        0x0E09: "reset_each_hero",
        0x0E6D: "check_hero_dead",
        0x0E7A: "next_hero_dead",
        0x0EA8: "restore_message_spaces",
        0x0EAE: "print_game_over",
        0x0EB9: "wait_vsync_game_over",
        0x0EFC: "draw_panel_hero",
        0x0F3A: "draw_missile_icons",
        0x1079: "check_door_x",
        0x1084: "next_hero_victory",
        0x108A: "check_door_y",
        0x1097: "start_victory",
        0x10BA: "print_victory_text",
        0x10C7: "print_ending_message",
        0x110A: "raise_victory_pitch",
        0x111C: "shorten_victory_delay",
        0x1124: "sound_victory_bell",
        0x113C: "victory_delay_loop",
        0x113E: "victory_delay_outer",
        0x1140: "victory_delay_inner",
        0x11BB: "store_victory_sprite",
        0x11D3: "erase_victory_ring",
        0x11DE: "clear_chalice_sprite",
        0x11EC: "wait_vsync_chalice",
        0x14A2: "copy_workspace_template",
        0x14E5: "draw_view_frame",
        0x14EC: "send_frame_vdu",
        0x1512: "unpack_objects",
        0x1529: "unpack_doors",
        0x1540: "unpack_keys",
        0x1551: "unpack_trapdoors",
        0x1564: "unpack_walls",
        0x1577: "unpack_wall_sprite",
        0x1585: "reset_each_monster",
        0x159C: "clear_hero_carrying",
        0x16B4: "find_queue_end",
        0x16BF: "next_queue_entry",
        0x1CC5: "check_doors",
        0x1CD8: "check_door",
        0x1CE3: "check_door_cell_y",
        0x1CEE: "check_door_key",
        0x1CFA: "open_door",
        0x1D03: "door_points_loop",
        0x1DB2: "next_door",
        0x1DB8: "doors_done",
        0x1DBA: "next_hero_doors",
        0x1DCE: "draw_each_key",
        0x1DF3: "check_death_finished",
        0x1E28: "check_key_swap",
        0x1E35: "check_key_cell",
        0x1E45: "check_key",
        0x1EBE: "next_key",
        0x1EC4: "keys_done",
        0x1EC6: "next_hero_keys",
        0x1F17: "count_heroes_in_play",
        0x1F2A: "next_hero_in_play",
        0x1F36: "check_exit",
        0x1F38: "check_hero_on_exit",
        0x1F91: "next_hero_exit",
        0x1F96: "check_exit_busy",
        0x1F9E: "redraw_exit",
        0x1FF2: "next_turn",
        0x2009: "shrink_hero_width",
        0x2014: "shrink_hero_height",
        0x2026: "restore_exit",
        0x205F: "restore_sprite_widths",
        0x206C: "restore_sprite_heights",
        0x2076: "start_hero_animation",
        0x20DB: "try_cell_right",
        0x20E9: "try_cell_below",
        0x20F7: "try_cell_left",
        0x6E82: "move_hero",
        0x6E91: "animate_absent",
        0x6E97: "remember_hero_position",
        0x6EBA: "check_magic_key",
        0x6ED4: "check_key_down",
        0x6EE7: "check_key_right",
        0x6EFA: "check_key_left",
        0x6F0D: "check_key_fire",
        0x6F28: "find_missile_slot",
        0x6F70: "next_missile_slot",
        0x6F83: "step_right",
        0x6F8A: "step_down",
        0x6F91: "step_left",
        0x6F98: "note_new_cell",
        0x6FC7: "cancel_hero_step",
        0x6FD5: "check_monster_in_cell",
        0x7002: "check_hero_in_cell",
        0x7007: "check_other_hero",
        0x703B: "next_other_hero",
        0x7053: "check_boots",
        0x7069: "stay_in_old_cell",
        0x70D2: "move_missile",
        0x70DA: "check_just_fired",
        0x70E7: "erase_missile",
        0x70FE: "missile_up",
        0x7108: "missile_right",
        0x710F: "missile_down",
        0x7116: "missile_left",
        0x711D: "check_missile_wall",
        0x713A: "check_missile_monster",
        0x7150: "monster_killed",
        0x7156: "check_missile_object",
        0x7173: "check_object_drainer",
        0x71A0: "credit_drainer_hit",
        0x71B4: "reverse_right",
        0x71C0: "reverse_down",
        0x71CC: "reverse_left",
        0x71D4: "next_object_drainer",
        0x71D7: "no_drainer",
        0x71D9: "check_missile_hero",
        0x71DD: "check_hero_hit",
        0x71F4: "take_missile_damage",
        0x7201: "next_hero_hit",
        0x7227: "take_health_unit",
        0x7256: "find_queue_slot",
        0x7263: "next_queue_slot",
        0x7266: "draw_health",
        0x72BC: "draw_score",
        0x730D: "draw_each_object",
        0x7337: "check_object",
        0x7342: "check_object_y",
        0x734D: "object_found",
        0x738A: "check_food",
        0x73A0: "redraw_health",
        0x73A7: "add_food_points",
        0x73C3: "check_teleporter",
        0x73C7: "find_previous_teleporter",
        0x73D9: "teleport",
        0x740D: "check_cross",
        0x7429: "take_returning_hero",
        0x742B: "shift_returning_queue",
        0x744C: "check_queue_empty",
        0x7464: "cross_done",
        0x7467: "remove_object",
        0x7470: "next_object",
        0x7477: "check_magic_item",
        0x7498: "take_ten_health",
        0x74B6: "magic_item",
        0x74EB: "check_helmet",
        0x74FC: "redraw_armour",
        0x74FF: "check_potion",
        0x7516: "check_weapons",
        0x7529: "draw_missile_icon",
        0x7551: "check_view_1",
        0x755B: "check_view_2",
        0x7565: "show_view_3",
        0x756B: "magic_sword",
        0x757C: "monster_hit",
        0x75A6: "store_monster_health",
        0x761F: "check_magic_every_frame",
        0x7650: "magic_user_cost",
        0x7652: "take_magic_cost",
        0x7667: "find_monster_room",
        0x7692: "next_monster_magic",
        0x769C: "score_magic_kills",
        0x76AB: "no_magic",
        0x76AE: "magic_cast",
        0x76C0: "owner_fireball",
        0x76C9: "owner_axe",
        0x76D2: "owner_sword",
        0x76D4: "credit_owner",
        0x76E0: "absent_frame_due",
        0x770B: "check_first_sprite",
        0x772E: "store_hero_frame",
        0x7757: "firer_fireball",
        0x7764: "firer_axe",
        0x7771: "firer_sword",
        0x77E4: "draw_room_walls",
        0x77FE: "draw_room_doors",
        0x7827: "draw_room_cell",
        0x783E: "plot_blank",
        0x7845: "next_room_cell",
        0x78AD: "check_view_1_room",
        0x78C7: "check_view_2_room",
        0x78E1: "check_view_3_room",
        0x7976: "check_monster",
        0x798D: "next_monster_find",
        0x7997: "check_hero",
        0x79AA: "take_hero_damage",
        0x79B7: "next_hero_find",
        0x79BC: "nothing_found",
        0x79CD: "draw_trapdoor",
        0x7A17: "check_monster_step",
        0x7A23: "start_monster_move",
        0x7A2D: "monster_right",
        0x7A34: "monster_down",
        0x7A3B: "monster_left",
        0x7A42: "set_monster_step",
        0x7A81: "turn_monster",
        0x7A87: "check_monster_blocked",
        0x7AC1: "monster_vertical",
        0x7ADC: "check_room_edge",
        0x7AEA: "monster_at_edge",
        0x7AF8: "monster_move_on",
        0x7B3F: "draw_monster_death",
        0x7B79: "hero_step_right",
        0x7B88: "hero_step_down",
        0x7B97: "hero_step_left",
        0x7BB9: "continue_right",
        0x7BC0: "continue_down",
        0x7BC7: "continue_left",
        0x7BCE: "hero_no_offsets",
        0x7BD6: "double_offsets",
        0x7C02: "monster_step_right",
        0x7C11: "monster_step_down",
        0x7C20: "monster_step_left",
        0x7C42: "monster_continue_right",
        0x7C49: "monster_continue_down",
        0x7C50: "monster_continue_left",
        0x7C57: "monster_no_offsets",
        0x7C5F: "grow_offset_x",
        0x7C6C: "grow_offset_x_right",
        0x7C6F: "grow_offset_y",
        0x7C82: "grow_offset_y_down",
        0x7CAE: "key_not_pressed",
        0x7CC2: "emerge_at_trapdoor",
        0x7CFB: "emerge_done",
        0x7FB5: "capital_letter",
        0x7FB8: "glyph_offset",
        0x7FBD: "copy_glyph",
        0x7FC5: "copy_letter_glyph",
        0x7FD1: "restore_registers",
        0x7FDA: "digit_glyph",
        0x7FE8: "copy_digit_glyph",
        0x7FF6: "pass_character",
    }.items():
        a.label(addr, name)



# Operands that are sprite numbers, as expressions in the sprite constants.
# A digit "past 9" is the sprite after digit 9, and a dead hero's health
# digit is the one before digit 0; missile sprite bases are the sprite
# before each weapon's up sprite.
SPRITE_OPERANDS = [
    (0x0407, "digit_9", 1), (0x040B, "digit_0", 0),
    (0x0416, "small_digit_9", 1), (0x041A, "small_digit_9", 0),
    (0x0432, "small_digit_8", 0), (0x06B8, "small_digit_1", 0),
    (0x06DE, "digit_0", -1), (0x0E71, "digit_0", -1),
    (0x0EE2, "digit_0", 0), (0x0EED, "digit_0", -1),
    (0x0EF2, "small_digit_1", -1), (0x0F14, "shield", 0),
    (0x0F3F, "missile_icon", 0), (0x0F55, "small_digit_1", -1),
    (0x10F7, "sparkle_0", 0), (0x11AF, "blank", 0), (0x11B6, "sparkle_3", 1),
    (0x11BA, "sparkle_0", 0), (0x11D4, "blank", 0), (0x11FD, "chalice", 0),
    (0x1586, "blank", 0), (0x15CA, "level_word", 0), (0x1D2D, "blank", 0),
    (0x1D99, "blank_key_icon", 0), (0x1DC9, "key", 0),
    (0x1E0F, "blank_key_icon", 0), (0x1E56, "blank", 0), (0x1E6A, "key_icon", 0),
    (0x1F20, "digit_0", -1), (0x1F68, "blank", 0), (0x1FB4, "exit", 0),
    (0x20B9, "blank_key_icon", 0), (0x7076, "blank", 0), (0x70E8, "blank", 0),
    (0x7148, "sparkle_0", 0), (0x7187, "drainer_0", 0), (0x718B, "drainer_11", 1),
    (0x7195, "drainer_11", 1), (0x722E, "digit_0", -1), (0x7232, "digit_9", 0),
    (0x723D, "digit_0", -1), (0x7241, "blank", 0),
    (0x7293, "digit_9", 1), (0x7297, "digit_0", 0), (0x72A2, "digit_9", 1),
    (0x72A6, "digit_0", 0), (0x72B1, "digit_9", 1), (0x72B5, "digit_0", 0),
    (0x7360, "treasure", 0), (0x738B, "food", 0), (0x7395, "digit_9", 1),
    (0x7399, "digit_9", 0), (0x73C4, "teleporter", 0), (0x73CC, "teleporter", 0),
    (0x740E, "cross", 0), (0x7478, "boots", 0), (0x74DC, "boots", 0),
    (0x74EC, "helmet", 0), (0x7500, "potion", 0), (0x7517, "weapons", 0),
    (0x7597, "blank", 0), (0x75DC, "missile_icon", 0),
    (0x75F3, "small_digit_1", -1), (0x7607, "boots_icon", 0),
    (0x760E, "blank_boots_icon", 0), (0x7687, "blank", 0), (0x768B, "blank", 0),
    (0x76B8, "arrow_up", -1), (0x76C1, "fireball_up", -1), (0x76CA, "axe_up", -1),
    (0x7723, "digit_3", 0), (0x774B, "arrow_up", -1), (0x7758, "fireball_up", -1),
    (0x7765, "axe_up", -1), (0x7835, "wall", 0), (0x783F, "blank", 0),
    (0x79CA, "trapdoor", 0), (0x79FA, "blank", 0), (0x7A11, "blank", 0),
    (0x7A27, "monster_up_0", 0), (0x7AC7, "monster_up_0", 0),
    (0x7ACB, "monster_down_0", 0), (0x7B39, "sparkle_3", 1),
    (0x7BF4, "monster_up_0", 0), (0x7C3C, "monster_up_0", 0),
    (0x7CD2, "monster_up_0", 0), (0x747C, "exit", 0),
]


def _annotates_game(a: Annotator) -> bool:
    """Whether a covers the game itself, rather than a few of its routines
    reused in another program (such as the editor's copy of the plotter);
    only then does it define the game's constants."""
    return a.skip is None or not a.skip(0x0E00)


def annotate_sprite_numbers(a: Annotator) -> None:
    numbers = {name: number for number, name, *_ in SPRITES}
    used = {name for _, name, _ in SPRITE_OPERANDS} | {
        "sword_up", "ranger_up_0", "magic_user_up_0", "barbarian_up_0", "fighter_up_0",
        "monster_right_0", "monster_left_0"}
    for name in sorted(used, key=numbers.get) if _annotates_game(a) else ():
        a.d.constant(numbers[name], f"spr_{name}", comment=f"Sprite &{numbers[name]:02X}")
    for operand_addr, name, offset in SPRITE_OPERANDS:
        expression = sym(f"spr_{name}")
        if offset:
            expression = expression + offset if offset > 0 else expression - (-offset)
        a.expr(operand_addr, expression)



# Loop counts and other operands that are named quantities.
COUNT_CONSTANTS = [
    (30, "max_object", "Objects are numbered 1 to 30"),
    (30, "max_monster", "Monsters are numbered 1 to 30"),
    (20, "max_door", "Doors are numbered 1 to 20"),
    (20, "max_key", "Keys are numbered 1 to 20; key n opens door n"),
    (0x3000, "screen_start", "The start of screen memory, as the game programs the 6845"),
    (0xFF, "off_map", "A map x or y that puts a door, key, object, monster or the exit off the map"),
    (0x64, "nobody_returns", "A returning_hero_queue entry that brings nobody back"),
    (0x63, "step_out_of_play", "hero_step of a hero out of play, never animated"),
    (0x23, "view_right_column", "The screen byte column of the two right-hand views"),
    (0x67, "view_bottom_row", "The pixel row of the two lower views"),
    (0x45, "panel_left", "The status panel's leftmost screen byte column"),
    (0x6DB0, "level_file_end", "The end of the level file at &6B00"),
    (25, "last_level", "The level with the Chalice"),
    (0xC9, "map_bytes", "The length of the wall and object-free maps"),
    (0x1A, "chalice_x", "Map x of the Chalice's left cells"),
    (4, "chalice_y", "Map y of the Chalice's top cells"),
]
COUNT_OPERANDS = [
    (0x1511, "max_object"), (0x7172, "max_object"), (0x730C, "max_object"),
    (0x7336, "max_object"),
    (0x1584, "max_monster"), (0x7666, "max_monster"), (0x7975, "max_monster"),
    (0x79E4, "max_monster"),
    (0x1528, "max_door"), (0x1CD7, "max_door"), (0x77FD, "max_door"),
    (0x153F, "max_key"), (0x1DCD, "max_key"), (0x1E44, "max_key"),
]
COUNT_OPERANDS += [(addr, "off_map") for addr in (
    0x158B, 0x1D8A, 0x1EA0, 0x1F73, 0x1F84, 0x7199, 0x7412, 0x7468, 0x74BA, 0x7CF1)]
COUNT_OPERANDS += [(addr, "nobody_returns") for addr in (0x06EB, 0x16BA, 0x7449)]
COUNT_OPERANDS += [(addr, "step_out_of_play") for addr in (0x06D4, 0x1F4C, 0x6E8B)]
COUNT_OPERANDS += [(addr, "view_right_column") for addr in (0x77AC, 0x77D0, 0x78B7, 0x78EB)]
COUNT_OPERANDS += [(addr, "view_bottom_row") for addr in (0x77BA, 0x77CC, 0x78D8, 0x78F2)]
COUNT_OPERANDS += [(0x1572, "map_bytes")]
COUNT_OPERANDS += [(0x1074, "last_level"), (0x107D, "chalice_x"), (0x108E, "chalice_y"),
                   (0x11F3, "chalice_x"), (0x11F8, "chalice_y")]
# Expressions: (operand address, symbol, offset).
OFFSET_OPERANDS = [
    (0x7445, "nobody_returns", -1),
    (0x1081, "chalice_x", 1), (0x1092, "chalice_y", 1),
    (0x114A, "chalice_x", 2), (0x114E, "chalice_y", -1),
    (0x0421, "panel_left", 0), (0x0F09, "panel_left", 0), (0x0F10, "panel_left", 8),
    (0x0F22, "panel_left", 9), (0x0F3D, "panel_left", 6), (0x0F57, "panel_left", 7),
    (0x1DA5, "panel_left", 5), (0x1E1B, "panel_left", 5), (0x1E76, "panel_left", 5),
    (0x20C5, "panel_left", 5), (0x726C, "panel_left", 0), (0x7281, "panel_left", 3),
    (0x72C5, "panel_left", 0), (0x72DA, "panel_left", 3), (0x72EA, "panel_left", 6),
    (0x72FA, "panel_left", 9), (0x75B7, "panel_left", 9), (0x75D8, "panel_left", 6),
    (0x75E3, "panel_left", 7), (0x75FA, "panel_left", 5),
    (0x0F1D, "spr_small_digit_1", 9),
    (0x75BB, "spr_small_digit_1", 9),
]
PAGE_OPERANDS = [(0x1D67, "room_walls"), (0x77DF, "room_walls"), (0x791A, "room_walls"),
                 (0x0973, "screen_start"), (0x7956, "object_free_map")]
MONSTER_SPRITE_OPERANDS = [
    (0x7A2E, "monster_right_0"), (0x7A35, "monster_down_0"), (0x7A3C, "monster_left_0"),
    (0x7C03, "monster_right_0"), (0x7C12, "monster_down_0"),
    (0x7C43, "monster_right_0"), (0x7C4A, "monster_down_0"), (0x7C51, "monster_left_0"),
]
CHAR_OPERANDS = [0x0597, 0x05A0, 0x0E3D, 0x0E4E, 0x15E9, 0x15F2, 0x7F98, 0x7FA0,
                 0x7FA8, 0x7FB1, 0x7FB7, 0x7FDC, 0x7F9C, 0x7FA4, 0x7FAC,
                 0x054E, 0x0553, 0x0558, 0x055E, 0x0563, 0x0568, 0x056E, 0x0577,
                 0x057C, 0x0593, 0x059B]


def annotate_named_operands(a: Annotator) -> None:
    for value, name, text in COUNT_CONSTANTS if _annotates_game(a) else ():
        a.d.constant(value, name, comment=text)
    for operand_addr, name in COUNT_OPERANDS:
        a.expr(operand_addr, sym(name))
    for operand_addr, name, offset in OFFSET_OPERANDS:
        expression = sym(name)
        if offset:
            expression = expression + offset if offset > 0 else expression - (-offset)
        a.expr(operand_addr, expression)
    for operand_addr, name in PAGE_OPERANDS:
        a.expr(operand_addr, hi(sym(name)))
    for operand_addr, name in MONSTER_SPRITE_OPERANDS:
        a.expr(operand_addr, sym(f"spr_{name}"))
    for operand_addr in CHAR_OPERANDS:
        value = a.byte_value(operand_addr)
        if value is not None:
            a.expr(operand_addr, char(value))



# Tables that the game fills at run time, so the bytes the file holds in
# them are never read: (address, length, what fills them).
RUNTIME_TABLES = [
    (0x0C00, 0xC9, "unpack_level copies each level's wall map here"),
    (0x2100, 0xC9, "unpack_level copies each level's object-free map here"),
    (0x2200, 21, "unpack_level copies each level's doors here"),
    (0x2220, 21, "unpack_level copies each level's doors here"),
    (0x2240, 21, "unpack_level copies each level's door sprites here"),
    (0x2260, 21, "unpack_level copies each level's keys here"),
    (0x2280, 21, "unpack_level copies each level's keys here"),
    (0x7E00, 0x29, "reset_monsters and the trapdoors set the monsters"),
    (0x7E29, 0x29, "reset_monsters and the trapdoors set the monsters"),
    (0x7F20, 0x1F, "unpack_level copies each level's objects here"),
    (0x7F3F, 0x1F, "unpack_level copies each level's objects here"),
    (0x7F5E, 0x1F, "unpack_level copies each level's objects here"),
]
# Runs of zero bytes between routines and tables, which nothing reads.
PADDING = [(0x0448, 8), (0x0485, 11), (0x04AA, 0x25), (0x06F6, 2), (0x09A0, 0x50),
           (0x1EF6, 6), (0x22D6, 10)]


def annotate_runtime_tables(a: Annotator) -> None:
    for addr, length, filler in RUNTIME_TABLES:
        # The object tables end with the exit's entry, object 30.
        rows = [16, 14, 1] if length == 0x1F else [16] * (length // 16) + [length % 16]
        offset = 0
        for size in filter(None, rows):
            a.byte(addr + offset, size, cols=16)
            a.c(addr + offset, f"Not read: {filler}" if offset == 0 else (
                "...the exit's entry" if size == 1 and length == 0x1F
                else f"...entries {offset}-{offset + size - 1}, not read"))
            offset += size
    for addr, length in PADDING:
        values = [a.byte_value(addr + i) for i in range(length)]
        if None in values or any(values):
            continue
        a.banner(addr, "Unused", "Zero bytes, which nothing reads.")
        for row in range(0, length, 16):
            a.byte(addr + row, min(16, length - row), cols=16)
            a.c(addr + row, "Zeros")



# Bytes between the game's tables and routines that no instruction
# refers to: (address, length).
UNREFERENCED = [
    (0x04FF, 1), (0x05F6, 10), (0x06AC, 4), (0x071B, 7),
    (0x09A0, 80),
    (0x0B39, 7),
    (0x0CC9, 7),
    (0x0CF8, 8),
    (0x0D99, 7),
    (0x0DB9, 3),
    (0x0DED, 16),
    (0x0F7D, 3),
    (0x1069, 7),
    (0x12D0, 3),
    (0x13FB, 5),
    (0x1639, 1),
    (0x169E, 1),
    (0x16C2, 14),
    (0x16E5, 26),
    (0x17C0, 5),
    (0x17C8, 6),
    (0x17DD, 1),
    (0x17F8, 8),
    (0x1851, 15),
    (0x18D8, 40),
    (0x196E, 5),
    (0x197A, 22),
    (0x1994, 7),
    (0x199E, 13),
    (0x19AE, 18),
    (0x20FE, 2),
    (0x21C9, 7),
    (0x2215, 11),
    (0x2235, 11),
    (0x2255, 11),
    (0x2275, 11),
    (0x2295, 11),
    (0x2990, 48),
    (0x29F0, 16),
    (0x2AF8, 8),
    (0x2BF0, 16),
    (0x2CF0, 16),
    (0x6F6D, 3),
    (0x7787, 1),
    (0x77DD, 1),
    (0x7C8C, 9),
    (0x7CFE, 1),
    (0x7F7D, 18),
    (0x7FFF, 1),
]


def annotate_unreferenced(a: Annotator) -> None:
    for addr, _ in UNREFERENCED:
        a.c(addr, "Not referenced")


def annotate_regions(a: Annotator) -> None:
    """Index regions, so that references to table elements read as offsets
    from the table. Call before the tables' own labels are declared."""
    for addr, name, window, kw in [
        (0x0600, "menu_text", (0, 2), {}),
        (0x0B2A, "returning_hero_queue", (0, 4), {}),
        (0x0B90, "trapdoor_x", (-1, 6), {}),
        (0x0B98, "trapdoor_y", (-1, 7), {}),
        (0x0BF8, "food_sound", (0, 7), {}),
        (0x0CF0, "hit_sound", (0, 7), {}),
        (0x0C00, "room_walls", (0, 0xC8), {}),
        (0x0D1A, "hero_direction", (-1, 3), {}),
        (0x0D20, "hero_frame", (-1, 3), {}),
        (0x0D90, "hero_health_tens", (-1, 3), {}),
        (0x0DA0, "view_room", (0, 7), {}),
        (0x0FF1, "panel_hero", (-1, 0), {}),
        (0x120F + 1, "sprite_chalice", (-1, 191), {}),
        (0x12D3, "saved_wrchv", (0, 1), {}),
        (0x16D5, "level_filename_digits", (0, 1), {}),
        (0x2100, "object_free_map", (0, 0xC8), {}),
        (0x7D00, "workspace_template", (0, 0xFF), {}),
        (0x7E00, "monster_x", (0, 0x28), {}),
        (0x7E29, "monster_y", (0, 0x28), {}),
    ]:
        a.region(addr, name, window, **kw)
    a.label(0x0DFD, "teleport_last", description=(
        "Index of the last object to search when looking backwards for a "
        "teleporter (&1E, from workspace_template)."))
    a.label(0x0DFF, "victory_sprite_copy", description=(
        "Written by draw_victory_ring; not read."))
    a.label(0x00FA, "os_zp_fa", group="os_workspace", description=(
        "MOS zero-page workspace, read by dissolve_chalice to vary its "
        "random choice."))
    a.label(0x00FC, "os_irq_a", group="os_workspace", description=(
        "MOS 1.20: A at the last interrupt, read by dissolve_chalice to vary "
        "its random choice."))
    a.region(0xFFFC, "reset_vector", (0, 1), group="os_entry_points",
             description="6502 RESET vector, in the MOS ROM.")
    a.region(0x10E7, "reset_call_address", (0, 1), description=(
        "Operand of the JSR at reset_call, set from the RESET vector."))
