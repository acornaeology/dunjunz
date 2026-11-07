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
    a.c(0x0900, "X = sprite number")
    a.c(0x0902, "Point sprite_data_ptr at the sprite's data...")
    a.c(0x0905, "...low byte")
    a.c(0x0907, "...high byte from its own table")
    a.c(0x090A, "...into sprite_data_ptr")
    a.c(0x090C, "Width in screen bytes")
    a.c(0x090F, "...for the inner loop")
    a.c(0x0911, "Height in pixel rows")
    a.c(0x0914, "...for the outer loop")
    a.c(0x0916, "screen_ptr = address of the top-left byte")
    a.c(0x0919, "Index stays 0: the pointers themselves advance")
    a.c(0x091B, "X counts the pixel rows still to plot")
    a.c(0x091D, "Remember where this pixel row starts...")
    a.c(0x091F, "...low byte")
    a.c(0x0921, "...and high byte...")
    a.c(0x0923, "...in row_start_ptr")
    a.c(0x0925, "Save the row count")
    a.c(0x0926, "...on the stack: X now counts bytes")
    a.c(0x0927, "X counts the bytes across this row")
    a.c(0x0929, "Copy one sprite byte...")
    a.c(0x092B, "...to the screen")
    a.c(0x092D, "Step screen_ptr right one byte column: 8 bytes on")
    a.c(0x092E, "...the screen address's low byte...")
    a.c(0x0930, "...+ 8, the next byte column...")
    a.c(0x0932, "...stored back")
    a.c(0x0934, "No carry: the high byte stands")
    a.c(0x0936, "...with carry into the high byte")
    a.c(0x0938, "Next sprite data byte")
    a.c(0x093A, "No carry: the high byte stands")
    a.c(0x093C, "...with carry into the high byte")
    a.c(0x093E, "Count the bytes across")
    a.c(0x093F, "Loop until the row is done")
    a.c(0x0941, "screen_ptr = row start + 1: the next pixel row down")
    a.c(0x0942, "The row start's low byte...")
    a.c(0x0944, "...+ 1...")
    a.c(0x0946, "...is the new low byte")
    a.c(0x0948, "The row start's high byte...")
    a.c(0x094A, "...plus the carry...")
    a.c(0x094C, "...is the new high byte")
    a.c(0x094E, "Has it crossed into the next character row?")
    a.c(0x0950, "...(pixel row within the character now 0)")
    a.c(0x0952, "No: carry on")
    a.c(0x0954, "Yes: add 640-8 to reach the top pixel row of the...")
    a.c(0x0955, "...character row below")
    a.c(0x0957, "...low byte + &78 (640 - 8 = &278)...")
    a.c(0x0959, "...stored")
    a.c(0x095B, "...high byte...")
    a.c(0x095D, "...+ 2 and the carry...")
    a.c(0x095F, "...stored")
    a.c(0x0961, "Recover the row count")
    a.c(0x0962, "...back into X")
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
    a.c(0x0969, "...halved...")
    a.c(0x096A, "...and halved again...")
    a.c(0x096B, "...times 2 to index the table's byte pairs")
    a.c(0x096D, "...as the index into the MOS table")
    a.c(0x096E, "High byte of row x 640, from the MOS table...")
    a.c(0x0971, "...(carry clear for the add)")
    a.c(0x0972, "...plus &30: the screen starts at &3000")
    a.c(0x0974, "...as the screen address high byte")
    a.c(0x0976, "Low byte of row x 640")
    a.c(0x0979, "...as the low byte")
    a.c(0x097B, "Add the pixel row within the character...")
    a.c(0x097D, "...plot_y MOD 8...")
    a.c(0x097F, "...(no carry: the low byte is &00 or &80)")
    a.c(0x0981, "...stored in the low byte")
    a.c(0x0983, "Add 8 x plot_x: first its top three bits...")
    a.c(0x0984, "...from plot_x...")
    a.c(0x0986, "...bits 7-5 kept...")
    a.c(0x0988, "...rotated down to bits 0-2...")
    a.c(0x0989, "...bit 7 into bit 0 via the carry")
    a.c(0x098A, "...then bit 6; bit 7 to bit 1")
    a.c(0x098B, "...bits 7-5 now in bits 2-0")
    a.c(0x098C, "...(carry clear for the add)")
    a.c(0x098D, "...into the high byte")
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
              "saved at start-up."),
          on_entry={"A": "character to print"},
          on_exit={"A": "corrupted", "X": "preserved", "Y": "preserved"})
    a.c(0x7F8F, "Keep the character")
    a.c(0x7F91, "Save X...")
    a.c(0x7F92, "...on the stack")
    a.c(0x7F93, "...and Y")
    a.c(0x7F94, "...on the stack")
    a.c(0x7F95, "Classify the character")
    a.c(0x7F97, "Below '0': print it unchanged")
    a.c(0x7F99, "Controls, space, punctuation: print as they are")
    a.c(0x7F9B, "'0'-'9': a digit")
    a.c(0x7F9D, "A digit: print the game's digit glyph")
    a.c(0x7F9F, "':'-'@': print it unchanged")
    a.c(0x7FA1, "Punctuation: print it as it is")
    a.c(0x7FA3, "'A'-'Z': a capital letter")
    a.c(0x7FA5, "A capital: print the game's letter glyph")
    a.c(0x7FA7, "'['-'`': print it unchanged")
    a.c(0x7FA9, "Punctuation: print it as it is")
    a.c(0x7FAB, "Above 'z': print it unchanged")
    a.c(0x7FAD, "Beyond 'z': print it as it is")
    a.c(0x7FAF, "A lower-case letter: letter number 0-25")
    a.c(0x7FB0, "...lower case uses the capitals' glyphs")
    a.c(0x7FB2, "...then find its glyph")
    a.c(0x7FB5, "A capital letter: letter number 0-25")
    a.c(0x7FB6, "...0 for A")
    a.c(0x7FB8, "x 8: offset of the glyph in font_letters")
    a.c(0x7FB9, "...x 4...")
    a.c(0x7FBA, "...x 8")
    a.c(0x7FBB, "Branch to the next instruction either way")
    a.c(0x7FBD, "X = offset of the first glyph byte")
    a.c(0x7FBE, "Stop after eight bytes")
    a.c(0x7FBF, "...the end offset, start + 8...")
    a.c(0x7FC1, "...kept in plot_x")
    a.c(0x7FC3, "Y indexes the character 128 definition")
    a.c(0x7FC5, "Copy a glyph byte...")
    a.c(0x7FC8, "...into the character 128 definition")
    a.c(0x7FCB, "Next row of character 128")
    a.c(0x7FCC, "Next glyph byte")
    a.c(0x7FCD, "All eight rows copied?")
    a.c(0x7FCF, "Loop for eight bytes")
    a.c(0x7FD1, "Restore Y...")
    a.c(0x7FD2, "...from the stack")
    a.c(0x7FD3, "...and X")
    a.c(0x7FD4, "...from the stack")
    a.c(0x7FD5, "Print character 128, now showing the glyph...")
    a.c(0x7FD7, "...through the MOS 1.20 OSWRCH routine")
    a.c(0x7FDA, "A digit: digit number 0-9")
    a.c(0x7FDB, "...0 for '0'")
    a.c(0x7FDD, "x 8: offset of the glyph in font_digits")
    a.c(0x7FDE, "...x 4...")
    a.c(0x7FDF, "...x 8")
    a.c(0x7FE0, "X = offset of the first glyph byte")
    a.c(0x7FE1, "Stop after eight bytes")
    a.c(0x7FE2, "...the end offset, start + 8...")
    a.c(0x7FE4, "...kept in plot_x")
    a.c(0x7FE6, "Y indexes the character 128 definition")
    a.c(0x7FE8, "Copy a glyph byte...")
    a.c(0x7FEB, "...into the character 128 definition")
    a.c(0x7FEE, "Next row of character 128")
    a.c(0x7FEF, "Next glyph byte")
    a.c(0x7FF0, "All eight rows copied?")
    a.c(0x7FF2, "Loop for eight bytes")
    a.c(0x7FF4, "Print character 128 (always branches)")
    a.c(0x7FF6, "Any other character: restore Y...")
    a.c(0x7FF7, "...from the stack")
    a.c(0x7FF8, "...and X")
    a.c(0x7FF9, "...from the stack")
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
          "missile damage.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
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
          "starts the game if at least one hero is playing.",
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
    a.sub(0x06B0, "remove_absent_heroes", "Take the heroes nobody plays out of the game",
          "Draw any ten-thousands score digits, then put every hero switched "
          "off on the menu out of play, with a &64 entry in "
          "returning_hero_queue in their place.",
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
          "Copy workspace_template into page &0D and clear the per-level "
          "state.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    a.sub(0x14D7, "draw_view_frames", "Draw the frames round the four views",
          "With the MOS's own text output restored, send the twenty PLOT "
          "commands of view_frame_plots, draw the four views, then put the "
          "game's WRCHV handler back.",
          on_entry={"plot_x": "address of view_frame_plots, low byte",
                    "plot_y": "address of view_frame_plots, high byte"})
    a.sub(0x1510, "unpack_level", "Copy the loaded level into the game's tables",
          "Distribute the level file at &6B00 into the object, door, key, "
          "trapdoor and map tables and the wall sprite.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "preserved"})
    a.sub(0x1583, "reset_monsters", "Clear the monsters for a new level",
          "Mark every monster as not yet appeared, give each the level's "
          "starting hit points, and clear the heroes' keys and the "
          "returning_hero_queue.",
           on_exit={"A": "0", "X": "4", "Y": "preserved"})
    a.sub(0x161A, "clear_text_area", "Clear the left of the screen",
          "Set a text window over the left of the screen and clear it.",
           on_exit={"A": "corrupted", "X": "preserved", "Y": "preserved"})

    # Winning
    a.sub(0x1070, "check_for_victory", "Check whether the Chalice has been found",
          "On level 25, if a hero stands on the cell where the Chalice is, "
          "play the victory sequence, print the ending message, wait for a "
          "key and reset the machine through the RESET vector. The message "
          "is not part of the program: it is the 140 bytes at room_walls + "
          "&3A followed by the string at object_free_map + &3A, which on "
          "level 25 hold the ending text instead of map data.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x10E9, "victory_sequence", "Play the victory sequence",
          "Spin sprites round the Chalice with a rising tone, then dissolve "
          "it.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x1149, "draw_victory_ring", "Draw the ring of sprites round the Chalice",
          "Plot the current victory sprite at the twelve cells round the "
          "Chalice, changing sprite as it goes.",
           on_entry={"victory_sprite": "the sprite to plot"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x119A, "plot_victory_sprite", "Plot a victory sprite at a cell",
          "Plot the current victory sprite at the map cell in &80, &81.",
           on_entry={"ring_x": "cell x", "ring_y": "cell y", "victory_sprite": "the sprite"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x11AC, "next_victory_sprite", "Choose the next victory sprite",
          "Step the victory sprite through &16-&19.",
           on_entry={"victory_sprite": "the current sprite"}, on_exit={"victory_sprite": "the next sparkle, &16-&19 in turn; &15 (erasing) is kept", "A": "victory_sprite", "X": "preserved", "Y": "preserved"})
    a.sub(0x11BE, "dissolve_chalice", "Clear a random byte of the Chalice",
          "Use the System VIA timer to pick a byte of the Chalice sprite, "
          "clear it, and redraw the Chalice.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x11F2, "plot_chalice", "Plot the Chalice",
          "Plot the Chalice sprite at its place on the map.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})

    # The main loop
    a.sub(0x1CC0, "update_game", "Run one frame of play",
          "Move the heroes, open doors for heroes carrying the right key, "
          "pick up and swap keys, then draw the objects, move the missiles "
          "and the monsters, and handle the pause key.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
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
          "without a wall.",
           on_entry={"cell_x": "cell x", "cell_y": "cell y"}, on_exit={"cell_x": "x of the first free neighbour, trying above, right and below; otherwise the cell to the left, unchecked", "cell_y": "its y", "Y": "0 if a free neighbour was found", "A": "corrupted", "X": "corrupted"})
    a.sub(0x16A0, "queue_exit_marker", "Sound the exit and add a queue marker",
          "Play the exit sound and put a &64 entry in the first free slot of "
          "returning_hero_queue.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})

    # Heroes
    a.sub(0x6E80, "move_heroes", "Move the heroes",
          "For each hero in play: continue a step between cells, or read the "
          "hero's keys (and, for heroes 0 and 1, the magic key) and start a "
          "step or fire a missile; check the new cell for walls, monsters, "
          "other heroes and objects, change view when the hero enters "
          "another room, and draw the hero.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
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
    a.sub(0x7305, "draw_objects", "Draw the level's objects",
          "Plot each of objects 30 to 1 at its cell in every view that shows "
          "it, with no pixel offset.",
          on_exit={"A": "corrupted", "X": "0", "Y": "corrupted"})
    a.sub(0x7329, "collect_objects", "Pick up the object in a hero's cell",
          "Find the object at hero X's cell and act on it: score, health, "
          "teleport, resurrection, energy drain, or one of the magic items.",
          on_entry=X_HERO)
    a.sub(0x74A3, "play_pickup_sound", "Play the pickup sound",
          "Define the pickup envelope and play the pickup sound, from the "
          "OSWORD parameter blocks at &192C and &193A.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})

    # Missiles
    a.sub(0x70CA, "move_missiles", "Move the missiles",
          "Advance every missile in flight one cell. A missile stops at a "
          "wall, damages a monster or hero it meets, and bounces back off an "
          "energy drainer, wearing it down.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x7747, "flip_firer_frame", "Animate the hero who fired a missile",
          "Toggle the animation frame of the hero whose missile is in slot X.",
          on_entry={"X": "missile slot"})
    a.sub(0x76B1, "credit_missile_owner", "Give a point to the hero who fired a missile",
          on_entry={"X": "missile slot"}, on_exit=X_KEPT)

    # The views
    a.sub(0x7788, "draw_all_views", "Draw all four views",
          "Draw the room each hero's view shows.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x752C, "show_hero_room", "Show the room a hero has moved into",
          "Set hero X's view to the room containing their cell and redraw "
          "that view.", on_entry=X_HERO, on_exit=X_KEPT)
    for addr, text in [
        (0x752C, "Find the room of the hero's cell (test_wall leaves it in "
                 "&7B)"),
        (0x753F, "Keep X"),
        (0x7540, "view_room entry for this hero..."),
        (0x7541, "...(two bytes per hero)..."), (0x7542, "...the room found by test_wall..."), (0x7544, "...now this room"),
        (0x7547, "Redraw this hero's view"),
    ]:
        a.c(addr, text)
    a.sub(0x7795, "draw_view_0", "Draw the top-left view",
          "Draw the room in hero 0's view.",
           on_entry={"view_room": "the room hero 0 is in"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x77A7, "draw_view_1", "Draw the top-right view",
          "Draw the room in hero 1's view.",
           on_entry={"view_room + 2": "the room hero 1 is in"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x77B9, "draw_view_2", "Draw the bottom-left view",
          "Draw the room in hero 2's view.",
           on_entry={"view_room + 4": "the room hero 2 is in"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x77CB, "draw_view_3", "Draw the bottom-right view",
          "Draw the room in hero 3's view.",
           on_entry={"view_room + 6": "the room hero 3 is in"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.sub(0x77DE, "draw_room", "Draw a room",
          "Draw the eight rows of walls of the room at &7B, &7C (a pointer "
          "into room_walls) with its top-left at plot_y and the column in "
          "cell_x, then draw the doors.",
           on_entry={"map_ptr": "the room's offset in room_walls (the low byte)", "cell_x": "the view's left column", "plot_y": "the view's top pixel row"}, on_exit={"A": "corrupted", "X": "0", "Y": "corrupted"})
    a.sub(0x7820, "draw_room_row", "Draw one row of a room",
          "Plot a wall or a blank for each of the eight bits of scratch, "
          "four byte columns apart, starting at byte column cell_x.",
           on_entry={"scratch": "the row's eight wall bits, the leftmost cell in bit 7", "cell_x": "the view's left column", "plot_y": "the row's top pixel row"}, on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
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
          "advance dying monsters until they reappear at a trapdoor.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
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
          "in page &0D, which reset_workspace refreshes for each level. It "
          "does not return: it starts a new game.")
    a.c(0x0D31, "OSBYTE &D3: bell channel...")
    a.c(0x0D33, "...channel &11")
    a.c(0x0D37, "Set it: BEL sounds on channel &11")
    a.c(0x0D3A, "OSBYTE &D4: bell envelope...")
    a.c(0x0D3C, "...0, a fixed amplitude")
    a.c(0x0D40, "Set it: BEL plays at a fixed amplitude")
    a.c(0x0D43, "OSBYTE &D5: bell pitch...")
    a.c(0x0D45, "...&64")
    a.c(0x0D49, "Set it: BEL plays at pitch &64")
    a.c(0x0D4C, "OSBYTE &D6: bell duration...")
    a.c(0x0D4E, "...1")
    a.c(0x0D52, "Set it: BEL lasts a twentieth of a second")
    a.c(0x0D55, "Save WRCHV...")
    a.c(0x0D58, "...low byte...")
    a.c(0x0D5B, "...high byte...")
    a.c(0x0D5E, "...in saved_wrchv")
    a.c(0x0D61, "Point WRCHV at wrch_handler...")
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
          "reset the machine.",
          on_entry={"level_number": "level loaded (1-25)"})
    for addr, name in [
        (0x045A, "decrypt_level_loop"),
        (0x046B, "decrypt_level_next"),
        (0x0484, "decrypt_level_done"),
    ]:
        a.label(addr, name)
    a.c(0x0450, "Point at &6B00, the start of the level...")
    a.c(0x0452, "...low byte")
    a.c(0x0454, "Start the sum at zero")
    a.c(0x0456, "High byte &6B: the level buffer's page")
    a.c(0x0458, "...high byte")
    a.c(0x045A, "Fetch a byte...")
    a.c(0x045C, "...XOR it with the low byte of its address...")
    a.c(0x045E, "...and store it back decrypted")
    a.c(0x0460, "Add it to the sum")
    a.c(0x0461, "...plus the sum so far")
    a.c(0x0463, "...kept in sprite_width")
    a.c(0x0465, "Next byte...")
    a.c(0x0467, "No carry: same page")
    a.c(0x0469, "...with carry into the high byte")
    a.c(0x046B, "Stop at &6DB0, the end of the level...")
    a.c(0x046D, "...low byte &B0?")
    a.c(0x046F, "No: decrypt the next byte")
    a.c(0x0471, "...and high byte &6D?")
    a.c(0x0473, "...(the end page)")
    a.c(0x0475, "No: decrypt the next byte")
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
             "Twenty five-byte VDU 25 commands (plot code, x, y) sent by "
             "draw_view_frames.")
    a.sub(0x1400, "start_level", "Set up and draw a new level",
          "Show the level number, load and unpack the level, reset the "
          "workspace and monsters, then clear the text area, set the screen "
          "to its full 25-row height and draw the view frames and views.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.c(0x1400, "Show the level number")
    a.c(0x1403, "Load the level")
    a.c(0x1406, "Copy it into the game's tables")
    a.c(0x1409, "Reset page &0D")
    a.c(0x140C, "Reset the monsters and keys")
    a.c(0x140F, "Clear the text area")
    a.c(0x1412, "VDU 23,0,6,25,0,0,0,0,0,0: set 6845 register 6...")
    a.c(0x1414, "Send VDU 23")
    a.c(0x1417, "0: a 6845 register setting follows")
    a.c(0x141C, "Register 6: character rows displayed")
    a.c(0x1421, "...to 25 character rows displayed")
    a.c(0x1426, "Six zero bytes complete the VDU 23")
    a.c(0x143A, "Point at view_frame_plots...")
    a.expr(0x143B, lo(sym("view_frame_plots")))
    a.expr(0x143F, hi(sym("view_frame_plots")))
    a.c(0x143E, "...high byte...")
    a.c(0x1442, "...and draw the frames and the views")
    a.c(0x1445, "Return")


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
    a.c(0x0E14, "Monster hit points = 8 + 2 x (levels played)...")
    a.c(0x0E17, "...x 2...")
    a.c(0x0E18, "...(carry clear for the add)")
    a.c(0x0E19, "...+ 8...")
    a.c(0x0E1B, "...for this level's monsters")
    a.c(0x0E1E, "Add 1 to the level number in decimal...")
    a.c(0x0E1F, "...(carry clear for the add)")
    a.c(0x0E20, "...the BCD count...")
    a.c(0x0E23, "...+ 1...")
    a.c(0x0E25, "...stored")
    a.c(0x0E28, "Back to binary arithmetic")
    a.c(0x0E29, "One digit for levels 1-9, two from 10 (the count is "
                "incremented later, in show_level_number)")
    a.c(0x0E2C, "...9 or more played: level 10 on?")
    a.c(0x0E2E, "Yes: two digits")
    a.c(0x0E30, "X = 0: one digit")
    a.c(0x0E34, "X = 1: two digits")
    a.c(0x0E36, "Units digit...")
    a.c(0x0E39, "...its low nibble...")
    a.c(0x0E3B, "...as ASCII...")
    a.c(0x0E3C, "...+ '0'...")
    a.c(0x0E3E, "...into the filename")
    a.c(0x0E41, "Two digits?")
    a.c(0x0E43, "No: end level filename")
    a.c(0x0E45, "Yes: the tens digit...")
    a.c(0x0E48, "...high nibble: first shift down...")
    a.c(0x0E4C, "...as ASCII...")
    a.c(0x0E4D, "...+ '0'...")
    a.c(0x0E4F, "...goes first")
    a.c(0x0E52, "Terminate the filename with a carriage return")
    a.c(0x0E54, "...after the last digit")
    a.c(0x0EC3, "Wait up to 6000 centiseconds (60 s) for a key...")
    a.c(0x0EC5, "...&1770 centiseconds: X low, Y high")
    a.c(0x0EC7, "OSBYTE &81: read a key within that time")
    a.c(0x0EC9, "Wait up to a minute for a key before a new game")
    a.c(0x0ECC, "...then start a new game")

    a.sub(0x15B1, "show_level_number", "Show the number of the level about to start",
          "Clear the text area, count the level, plot the word LEVEL and "
          "print the number in the game's font, then set a text window and "
          "colour for later messages.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    a.c(0x15B1, "Clear the text area")
    a.c(0x15B4, "COLOUR 6...")
    a.c(0x15B9, "Colour 6: the level number's colour")
    a.c(0x15BE, "Count the level")
    a.c(0x15C1, "Plot the word LEVEL...")
    a.c(0x15C5, "...pixel row 40...")
    a.c(0x15C9, "...the word LEVEL's sprite...")
    a.c(0x15CD, "Plot it")
    a.c(0x15D0, "TAB(10,5)...")
    a.c(0x15D5, "Column 10...")
    a.c(0x15DA, "...row 5: just right of LEVEL")
    a.c(0x15DF, "Print the tens digit...")
    a.c(0x15E2, "Keep the BCD level for the units")
    a.c(0x15E3, "Shift the tens digit...")
    a.c(0x15E8, "Make it an ASCII digit")
    a.c(0x15EA, "...in the game's font")
    a.c(0x15ED, "Print the units digit...")
    a.c(0x15EE, "Keep only the units digit")
    a.c(0x15F1, "Make it an ASCII digit")
    a.c(0x15F3, "...in the game's font")
    a.c(0x15F6, "VDU 28,1,22,14,17: a text window...")
    a.c(0x1605, "Right column 14")
    a.c(0x160A, "...top row 17")
    a.c(0x1614, "...colour 2")
    a.c(0x1619, "Return")


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
        "Hero counter for draw_status_panel. It is a byte of "
        "game_over_message, which is repaired before printing."))
    a.label(0x0FF2, "count", description=(
        "Counter, used for the dead heroes at the end of a level and the "
        "rows of missile icons. It is a byte of game_over_message."))
    a.c(0x0E57, "Load and draw the level")
    a.c(0x0E5A, "Draw the status panel")
    a.c(0x0E5D, "Take out the heroes nobody plays")
    a.c(0x0E60, "Let one vertical sync pass before play starts")
    a.c(0x0E62, "...counted down at each vertical sync")
    a.c(0x0E65, "Play the level until it ends")
    a.c(0x0E68, "Count the heroes who died, giving each back their "
                "starting attributes")
    a.c(0x0E6A, "...none dead so far")
    a.c(0x0E6D, "Dead?")
    a.c(0x0E70, "...health tens one below 0?")
    a.c(0x0E72, "No: alive")
    a.c(0x0E74, "Yes: reset them")
    a.c(0x0E77, "...and count them")
    a.c(0x0E7A, "Next hero")
    a.c(0x0E7B, "All four checked?")
    a.c(0x0E7D, "No: next hero")
    a.c(0x0E7F, "Any hero alive?")
    a.c(0x0E82, "...fewer than four dead?")
    a.c(0x0E84, "Yes: on to the next level")
    a.c(0x0E86, "All dead: VDU 28,0,24,16,0, a text window on the left...")
    a.c(0x0E9F, "...VDU 12 to clear it")
    a.c(0x0EA4, "Put spaces back over the four message bytes used as "
                "counters")
    a.c(0x0EA6, "...a space")
    a.c(0x0EA8, "...into each of the four bytes")
    a.c(0x0EAB, "Next byte down")
    a.c(0x0EAC, "Until all four are spaces")
    a.c(0x0EAE, "Print game_over_message...")
    a.c(0x0EB1, "...printed...")
    a.c(0x0EB4, "Next character")
    a.c(0x0EB5, "...up to its zero byte")
    a.c(0x0EB7, "Not the end: next")
    a.c(0x0EB9, "Wait for the vertical sync counter to run out")
    a.c(0x0EBC, "Not yet: keep waiting")
    a.c(0x0EBE, "Flush the input buffers")
    a.c(0x0EC0, "Discard keys pressed while the message showed")


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
        (0x2A, "OSFILE &FF: load the file"),
        (0x2C, "Call FILEV (operand patched above)"),
        (0x2F, "Run the game"),
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
        (0x0EE1, "Score 000..."), (0x0EE3, "...thousands..."), (0x0EE6, "...hundreds..."), (0x0EE9, "...tens..."),
        (0x0EEC, "...with the units one below 0, for draw_status_panel to "
                 "add a point"),
        (0x0EEE, "...as the units digit"),
        (0x0EF1, "No ten-thousands digit"), (0x0EF3, "...as the ten-thousands digit"), (0x0EF6, "Return"),

        (0x0EF7, "For each hero..."), (0x0EF9, "...starting with hero 0"),
        (0x0EFC, "X = this hero"),
        (0x0EFF, "Draw the health (from the template's 99+1)"),
        (0x0F02, "Draw the score (from its starting 000 and one below 0)"),
        (0x0F05, "Face, at column &45, row 0 of the section"),
        (0x0F08, "...column &45..."), (0x0F0A, "...row 0..."), (0x0F0C, "...plotted"),
        (0x0F0F, "Shield, at column &4D, row 0"),
        (0x0F11, "...row 0..."), (0x0F13, "...the shield sprite..."), (0x0F15, "...plotted"),
        (0x0F18, "Armour rating 10 - health lost per hit, as a small "
                 "digit on the shield"),
        (0x0F1B, "...(no borrow into the subtract)"), (0x0F1C, "...from the small digit sprite for 10..."), (0x0F1E, "...less the damage per hit"),
        (0x0F21, "...at column &4E..."), (0x0F23, "...row 2..."), (0x0F25, "...plotted on the shield"),
        (0x0F28, "One missile icon every three rows from row &10, for each "
                 "missile allowed..."),
        (0x0F2B, "...missile limit..."), (0x0F2E, "...x 2..."), (0x0F2F, "...(carry clear for the add)"), (0x0F30, "...+ limit: 3 rows per icon..."),
        (0x0F33, "...+ &10: the row after the last icon"), (0x0F35, "...(end row in count)"),
        (0x0F38, "...first icon at row &10"), (0x0F3A, "Keep the row..."), (0x0F3B, "...on the stack"),
        (0x0F3C, "...at column &4B"), (0x0F3E, "...the missile icon..."), (0x0F40, "...plotted at row Y"),
        (0x0F43, "Recover the row..."), (0x0F44, "...(carry clear for the add)"), (0x0F45, "...3 rows down..."), (0x0F47, "...for the next icon"),
        (0x0F48, "Past the last icon's row?"), (0x0F4B, "No: plot another"),
        (0x0F4D, "Missile damage, as a small digit at column &4C, row &0A"),
        (0x0F50, "...the hero's missile damage..."), (0x0F53, "...(carry clear for the add)"), (0x0F54, "...as a small digit sprite"),
        (0x0F56, "...at column &4C..."), (0x0F58, "...row &0A..."), (0x0F5A, "...plotted"),
        (0x0F5D, "Next hero"), (0x0F60, "All four heroes drawn?"), (0x0F63, "...(four of them)"),
        (0x0F65, "No: the next hero"), (0x0F67, "Return"),

        (0x0F68, "Column"), (0x0F6A, "Sprite"),
        (0x0F6C, "Row = Y + this hero's panel row - 14..."),
        (0x0F6D, "...for the hero being drawn..."), (0x0F70, "...(carry clear for the add)"),
        (0x0F71, "...(read from workspace_template, which page &0D copies)"),
        (0x0F74, "...(no borrow into the subtract)"), (0x0F75, "...less 14..."), (0x0F77, "...is the plot row"),
        (0x0F79, "Plot it"), (0x0F7C, "Return"),

        (0x14A0, "Copy workspace_template to page &0D"),
        (0x14A2, "Byte of the starting values..."), (0x14A5, "...becomes page &0D's byte"), (0x14A8, "Next byte"), (0x14A9, "Until all 256 are copied"),
        (0x14AB, "Reset the exit and other per-level state"),
        (0x14B9, "First monster emerges from trapdoor 0"),
        (0x14D6, "Return"),

        (0x14D7, "Restore the MOS's own WRCHV for the PLOT commands..."),
        (0x14DA, "...low byte..."), (0x14DD, "...high byte..."), (0x14E0, "...so the PLOTs draw lines, not the game's font"),
        (0x14E3, "Twenty PLOT commands"),
        (0x14E5, "VDU 25..."), (0x14E7, "Send VDU 25: a PLOT command follows"),
        (0x14EA, "...then the five bytes of the command"),
        (0x14EC, "Next byte of this PLOT: K, then X and Y"), (0x14EE, "Send it"), (0x14F1, "Next byte"), (0x14F2, "All five sent?"),
        (0x14F4, "No: send the next"),
        (0x14F6, "Next command"), (0x14F7, "...pointer..."), (0x14F9, "...moves on five bytes..."),
        (0x14FB, "...to the next PLOT"), (0x14FD, "Start the next PLOT at its first byte"),
        (0x14FF, "Count the PLOT done"), (0x1500, "Until all twenty are drawn"),
        (0x1502, "Draw the four views"),
        (0x1505, "Point WRCHV back at wrch_handler..."),
        (0x1507, "...low byte..."), (0x150A, "...high byte..."), (0x150C, "...so text is drawn in the game's font again"), (0x150F, "Return"),

        (0x1510, "Objects 30 to 1: position and type"),
        (0x1524, "Next object down"), (0x1525, "Until object 1 is done"),
        (0x1527, "Doors 20 to 1: position and sprite"),
        (0x153B, "Next door down"), (0x153C, "Until door 1 is done"),
        (0x153E, "Keys 20 to 1: position"),
        (0x154C, "Next key down"), (0x154D, "Until key 1 is done"),
        (0x154F, "Trapdoors 0 to 7: position"),
        (0x155D, "Next trapdoor"), (0x155E, "All eight done?"), (0x1560, "No: copy the next"),
        (0x1562, "Wall map and object-free map, &C9 bytes each"),
        (0x1570, "Next byte"), (0x1571, "Both maps copied?"), (0x1573, "No: copy the next"),
        (0x1575, "The level's wall sprite, &30 bytes"),
        (0x157D, "Next byte"), (0x157E, "All 4 x 12 bytes copied?"), (0x1580, "No: copy the next"), (0x1582, "Return"),

        (0x1583, "Monsters 30 to 1..."),
        (0x1585, "...dying, so that they emerge from the trapdoors..."),
        (0x1587, "...as monster X's sprite..."),
        (0x158A, "...off the map..."), (0x158C, "...as monster X's x..."),
        (0x158F, "...with this level's hit points"), (0x1592, "...as monster X's hit points"),
        (0x1595, "Next monster down"), (0x1596, "Until monster 1 is done"),
        (0x1598, "For each hero: clear the returning queue, the key carried "
                 "and the door-check position"),
        (0x15AB, "Next hero"), (0x15AC, "All four done?"), (0x15AE, "No: clear the next"), (0x15B0, "Return"),
    ]:
        a.c(addr, text)


def annotate_core_comments(a: Annotator) -> None:
    """Inline comments for the core primitives."""
    C = a.c
    # plot_at_cell
    for addr, text in [
        (0x7852, "Room = (cell_y AND &F8) x 4 + (cell_x AND &F8)..."),
        (0x7855, "...the room's top row of cells (y AND &F8)"), (0x7857, "...kept to multiply..."), (0x785A, "...(no carry into the sum)"), (0x785B, "...x 2..."),
        (0x785E, "...x 3..."), (0x7861, "...x 4: a room row is 32 bytes of room_walls"), (0x7864, "...partial room offset"),
        (0x7867, "Add the room's left column of cells..."), (0x786A, "...cell_x AND &F8: 8 bytes per room across"), (0x786C, "...giving the room's offset in room_walls"),
        (0x786F, "...in cell_room"),
        (0x7872, "Column within the view = (cell_x AND 7) x 4 + offset_x"),
        (0x7875, "...the cell's column within its room..."), (0x7877, "...x 2..."), (0x7878, "...x 4: each cell is 4 screen bytes wide"), (0x7879, "...(no carry)"),
        (0x787A, "...plus the creature's horizontal offset"), (0x787C, "...replacing cell_x"),
        (0x787F, "Row within the view = (cell_y AND 7) x 12 + offset_y"),
        (0x7882, "...the cell's row within its room..."), (0x7884, "...x 2..."), (0x7885, "...x 4..."), (0x7886, "...kept..."),
        (0x7889, "...x 8..."), (0x788A, "...(no carry)"), (0x788B, "...+ x 4 = x 12: each cell is 12 rows tall"), (0x788E, "...plus the creature's vertical offset"),
        (0x7890, "...replacing cell_y"),
        (0x7893, "Does the top-left view show this room?"),
        (0x7896, "...is it the room of the cell?"), (0x7899, "No: check view 1 room"),
        (0x789B, "Yes: plot at column 1, row 1 of the screen, plus the "
                 "position in the room"),
        (0x789C, "...view's left column, 1..."), (0x789E, "...plus the column within the room"), (0x78A1, "...as the screen column"), (0x78A3, "...view's top row, 1..."),
        (0x78A5, "...plus the row within the room"), (0x78A8, "...as the screen row"), (0x78AA, "Draw it in the top-left view"),
        (0x78AD, "Does the top-right view show it?"),
        (0x78B0, "...is it the room of the cell?"), (0x78B3, "No: check view 2 room"),
        (0x78B5, "Yes: plot at column &23, row 1"),
        (0x78C7, "Does the bottom-left view show it?"),
        (0x78CA, "...is it the room of the cell?"), (0x78CD, "No: check view 3 room"),
        (0x78CF, "Yes: plot at column 1, row &67"),
        (0x78E1, "Does the bottom-right view show it?"),
        (0x78E4, "...is it the room of the cell?"), (0x78E7, "No: plot at cell done"),
        (0x78E9, "Yes: plot at column &23, row &67"),
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
        (0x7934, "...keep it in &8F..."),
        (0x7936, "...and Y"),
        (0x7937, "Return"),
        # test_object_free
        (0x7938, "Room offset = (cell_y AND &F8) x 4 + (cell_x AND &F8)..."),
        (0x794A, "...low byte of the pointer"),
        (0x7955, "...into object_free_map at &2100"),
        (0x7957, "...as the pointer's high byte"),
        (0x7959, "Bit for the column within the room"),
        (0x7965, "Byte for the row within the room"),
        (0x796B, "Isolate the cell's bit..."),
        (0x7970, "...keep it in &8F..."),
        (0x7972, "...and Y"),
        (0x7973, "Return"),
        # find_creature
        (0x7974, "Monsters 30 to 1..."),
        (0x7976, "...except the one being moved"),
        (0x7979, "The mover itself: skip it"),
        (0x797B, "At cell_x..."), (0x797E, "...this monster's x?"), (0x7981, "No: next monster"),
        (0x7983, "...and cell_y?"), (0x7986, "...this monster's y?"), (0x7989, "No: next monster"),
        (0x798B, "Yes: return with Y and A non-zero"),
        (0x798C, "...a monster is in the cell"),
        (0x798D, "Next monster"), (0x798E, "Until all 30 are checked"),
        (0x7990, "No monster. Check for heroes too?"),
        (0x7993, "No: return 0"),
        (0x7995, "For each hero..."),
        (0x7997, "...at cell_x..."), (0x799A, "...this hero's x?"), (0x799D, "No: next hero"),
        (0x799F, "...and cell_y?"), (0x79A2, "...this hero's y?"), (0x79A5, "No: next hero"),
        (0x79A7, "Yes: take hero_damage_taken health points"),
        (0x79AA, "Keep the count of points to take..."), (0x79AB, "...on the stack"), (0x79AC, "The hero there is hurt: one point"), (0x79AF, "Recover the count..."),
        (0x79B0, "...into Y"), (0x79B1, "One point fewer to take"), (0x79B2, "Until the hero has taken them all"),
        (0x79B4, "Return A = 1: a hero was there"),
        (0x79B6, "...so the caller treats the cell as taken"),
        (0x79B7, "Next hero"), (0x79B8, "All four heroes checked?"), (0x79BA, "No: check the next"),
        (0x79BC, "Nothing there: return A = Y = 0"),
        (0x79BE, "...the cell is empty"), (0x79C0, "Return"),
        # lose_health_point
        (0x7221, "Is the hero in play?"),
        (0x7224, "Yes: take health unit"),
        (0x7226, "No: return"),
        (0x7227, "Take one from the units digit"),
        (0x722A, "...and look at the new units digit"),
        (0x722D, "Below 0?"),
        (0x722F, "No: redraw"),
        (0x7231, "Yes: units 9..."),
        (0x7233, "...so the units wrap from 0 to 9"),
        (0x7236, "...and take one from the tens"),
        (0x7239, "...and look at the new tens digit"),
        (0x723C, "Below 0: the hero has died"),
        (0x723E, "No: redraw"),
        (0x7240, "Erase the hero..."),
        (0x7242, "...by plotting the blank sprite..."),
        (0x7244, "...at the hero's cell in every view"),
        (0x7247, "...take them out of play..."),
        (0x7249, "...direction 0 means not in play"),
        (0x724C, "...and start the death animation: step +1 through "
                 "hero_appearance_sprites, every other frame"),
        (0x724E, "...frame step +1: forwards through the sprites..."), (0x7251, "...frame counter 1: the first step comes next frame"),
        (0x7254, "Add hero number + 1 at the end of returning_hero_queue"),
        (0x7256, "Look at this queue entry..."), (0x7259, "In use: try the next entry"), (0x725B, "Empty: hero number..."), (0x725C, "...plus one..."),
        (0x725D, "...(entries are hero + 1, so 0 can mean empty)..."), (0x725F, "...queued behind those already waiting"), (0x7262, "Return"),
        (0x7263, "Next queue entry"), (0x7264, "Keep looking (an empty entry is always found)"),
        (0x7266, "Draw the health: tens digit at column &45..."),
        (0x7269, "...on the top row of the hero's panel section..."), (0x726B, "...in the panel's left column..."), (0x726D, "...as the plotting column"), (0x726F, "...as a digit sprite"),
        (0x7272, "...as the sprite to plot"), (0x7274, "Keep the hero number..."), (0x7275, "...across the plot"), (0x7276, "Plot the tens digit"),
        (0x7279, "Recover the hero number..."), (0x727A, "...into X"),
        (0x727B, "...units digit at column &48"),
        (0x727E, "...as the sprite to plot"), (0x7280, "...three columns right of the tens..."), (0x7282, "...on the same row"), (0x7284, "Keep the hero number..."),
        (0x7285, "...across the plot"), (0x7286, "Plot the units digit"), (0x7289, "Recover the hero number..."), (0x728A, "...into X"),
        (0x728B, "Return"),
        # add_point, add_ten_points
        (0x728C, "Add one to the units digit"),
        (0x728F, "...and look at the new units digit"), (0x7292, "Past 9?"), (0x7294, "No: redraw"),
        (0x7296, "Yes: units 0, and carry into the tens"),
        (0x7298, "...falling into add_ten_points to carry"),
        (0x729B, "Add one to the tens digit"),
        (0x729E, "...and look at the new tens digit"), (0x72A1, "Past 9?"), (0x72A3, "No: redraw"),
        (0x72A5, "Yes: tens 0..."), (0x72A7, "...as the tens digit"),
        (0x72AA, "...and add one to the hundreds"),
        (0x72AD, "...and look at the new hundreds digit"), (0x72B0, "Past 9?"), (0x72B2, "No: redraw"),
        (0x72B4, "Yes: hundreds 0..."), (0x72B6, "...as the hundreds digit"),
        (0x72B9, "...and add a thousand"),
        (0x72BC, "Draw the score twelve rows below the health: thousands "
                 "at column &45..."),
        (0x72D4, "...hundreds at &48..."),
        (0x72E4, "...tens at &4B..."),
        (0x72F4, "...units at &4E"),
        (0x7304, "Return"),
        # test_key
        (0x7C95, "Key number to X, keeping X on the stack"),
        (0x7C96, "Keep the caller's X..."), (0x7C97, "...on the stack"), (0x7C98, "Key number..."), (0x7C99, "...in X for OSBYTE"),
        (0x7C9A, "OSBYTE &81 with Y = &FF: scan the key"),
        (0x7C9C, "Y = &FF: test the one key"), (0x7C9E, "Scan it: X = Y = &FF if the hero's key is held"),
        (0x7CA1, "X = Y = &FF if it is pressed"),
        (0x7CA3, "Y not &FF: not pressed"), (0x7CA5, "X = &FF too?"), (0x7CA7, "No: not pressed"),
        (0x7CA9, "Pressed: restore X and return A = 0, Z set"),
        (0x7CAA, "...restoring the caller's X"), (0x7CAB, "A = 0, Z set: pressed"), (0x7CAD, "Return"),
        (0x7CAE, "Not pressed: restore X and return A = 1"),
        (0x7CAF, "...restoring the caller's X"), (0x7CB0, "A = 1, Z clear: not pressed"), (0x7CB2, "Return"),
        # draw_hero, get_hero_cell
        (0x7732, "Hero's cell"),
        (0x7735, "...and pixel offsets"),
        (0x7738, "...across..."), (0x773A, "...and down..."), (0x773D, "...as plot_offset_y"),
        (0x773F, "Plot in every view showing it, preserving X"),
        (0x7740, "...keeping the hero number on the stack"), (0x7741, "Plot the hero in every view showing it"), (0x7744, "Recover the hero number..."), (0x7745, "...into X"),
        (0x7746, "Return"),
        (0x777A, "cell_x = hero_x"), (0x777D, "...for the plotting and testing routines"),
        (0x7780, "cell_y = hero_y"), (0x7783, "...likewise"), (0x7786, "Return"),
        # draw views
        (0x7795, "Top-left view: row 1..."), (0x7797, "...as the view's top pixel row"),
        (0x7799, "...column 1..."), (0x779B, "...as the view's left screen column"),
        (0x779E, "...hero 0's room"), (0x77A1, "...whose walls draw_room reads"),
        (0x77A3, "Draw it"), (0x77A6, "Return"),
        (0x77A7, "Top-right view: row 1..."), (0x77AB, "...column &23..."),
        (0x77B0, "...hero 1's room"), (0x77B5, "Draw it"), (0x77B8, "Return"),
        (0x77B9, "Bottom-left view: row &67..."), (0x77BD, "...column 1..."),
        (0x77C2, "...hero 2's room"), (0x77C7, "Draw it"), (0x77CA, "Return"),
        (0x77CB, "Bottom-right view: row &67..."), (0x77CF, "...column &23..."),
        (0x77D4, "...hero 3's room"), (0x77D9, "Draw it"), (0x77DC, "Return"),
        (0x77DE, "The room's walls are in page &0C"),
        (0x77E0, "...so map_ptr points at the room's wall bytes"),
        (0x77E2, "For each of the eight rows..."),
        (0x77E4, "...take its eight wall bits..."),
        (0x77E6, "...in scratch for draw_room_row"), (0x77E9, "Keep the row number..."), (0x77EA, "...on the stack across the row"),
        (0x77EB, "...and draw them"),
        (0x77EE, "Twelve pixel rows down"),
        (0x77EF, "Down to the next row of cells..."), (0x77F1, "...each 12 pixel rows tall"), (0x77F3, "...ready for the next row"),
        (0x77F5, "Recover the row number..."), (0x77F6, "...into Y"), (0x77F7, "Next row"), (0x77F8, "All eight rows done?"),
        (0x77FA, "No: draw the next row"),
        (0x77FC, "Then the doors 20 to 1, in every view showing them"),
        (0x781C, "Next door"), (0x781D, "Until all 20 are drawn"), (0x781F, "Return"),
        (0x7820, "Start at the room's left edge"),
        (0x7823, "...as the first cell's screen column"),
        (0x7825, "Bit mask, starting with the leftmost cell"),
        (0x7827, "Keep this cell's bit mask..."), (0x7828, "...on the stack..."), (0x7829, "...and in scratch2 for the test"),
        (0x782C, "Wall here?"), (0x782F, "...against the row's wall bits"),
        (0x7832, "No: plot the blank"),
        (0x7834, "Yes: plot the wall block (sprite 0)"),
        (0x7836, "...to plot"), (0x7838, "Draw the wall block in this cell"), (0x783B, "On to the next cell"),
        (0x783E, "Plot the blank (sprite &15)"),
        (0x7840, "...to plot"), (0x7842, "Clear this cell"),
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
    "hero_health_units": "hero_health_units: ...and one past 9: health 99 + 1, which draw_status_panel takes a point from",
    "view_room": "view_room: every view starts on room &0C28",
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
        (0x6E80, "For each hero..."),
        (0x6E82, "In play?"),
        (0x6E85, "Yes: remember hero position"),
        (0x6E87, "Out of play: never playing (step &63)?"),
        (0x6E8A, "Step &63 marks a hero nobody plays"), (0x6E8C, "Not &63: the hero is dying or returning"),
        (0x6E8E, "Yes: nothing to do"),
        (0x6E91, "No: dying or returning, so animate them"),
        (0x6E94, "Then on to the next hero"),
        (0x6E97, "Remember the hero's position and offsets before moving"),
        (0x6E9A, "previous_x: where to put the hero back if blocked"), (0x6E9D, "Same for the hero's y..."), (0x6EA0, "...into previous_y"), (0x6EA3, "And the pixel offset across..."),
        (0x6EA6, "...kept so the old position can be erased"), (0x6EA9, "And the pixel offset down..."), (0x6EAC, "...kept with it"),
        (0x6EAF, "Part way through a step?"),
        (0x6EB2, "No: read the keys"),
        (0x6EB4, "Yes: continue it..."),
        (0x6EB7, "...and redraw"),
        (0x6EBA, "Heroes 0 and 1 check their magic key first"),
        (0x6EBC, "Heroes 2 and 3 have no magic: straight to the keys"), (0x6EBE, "Heroes 0 and 1: check the magic key first"),
        (0x6EC1, "Up key?"), (0x6EC4, "Scan it: Z set if held"), (0x6EC7, "No: check key down"),
        (0x6EC9, "Yes: face up..."), (0x6ECB, "Direction 1 means up"),
        (0x6ECE, "...start the step..."), (0x6ED1, "...and move"),
        (0x6ED4, "Down key?"), (0x6ED7, "Scan it: Z set if held"), (0x6EDA, "No: check key right"),
        (0x6EDC, "Yes: face down..."), (0x6EDE, "Direction 5 means down"),
        (0x6EE1, "...start the step..."), (0x6EE4, "...and move"),
        (0x6EE7, "Right key?"), (0x6EEA, "Scan it: Z set if held"), (0x6EED, "No: check key left"),
        (0x6EEF, "Yes: face right..."), (0x6EF1, "Direction 3 means right"),
        (0x6EF4, "...start the step..."), (0x6EF7, "...and move"),
        (0x6EFA, "Left key?"), (0x6EFD, "Scan it: Z set if held"), (0x6F00, "No: check key fire"),
        (0x6F02, "Yes: face left..."), (0x6F04, "Direction 7 means left"),
        (0x6F07, "...start the step..."), (0x6F0A, "...and move"),
        (0x6F0D, "Fire key?"), (0x6F10, "Scan it: Z set if held"), (0x6F13, "Yes: fire missile"),
        (0x6F15, "No key: just redraw the hero"),
        (0x6F18, "This hero's missile slots are 3x to 3x + "
                 "hero_max_missiles - 1"),
        (0x6F19, "Keep the hero number..."), (0x6F1C, "...double it..."), (0x6F1D, "...(no carry in)..."), (0x6F1E, "...and add it again: 3 x hero, the first slot"),
        (0x6F21, "Y = the hero's first missile slot"), (0x6F22, "Add the number of missiles the hero may have..."), (0x6F25, "...end of the range"),
        (0x6F28, "Slot free?"), (0x6F2B, "No: try the next"),
        (0x6F2D, "Missile direction = (hero direction + 1) / 2, so 1-4, "
                 "with bit 7 marking it just fired"),
        (0x6F30, "Direction 1, 3, 5 or 7..."), (0x6F31, "...plus 1..."), (0x6F33, "...halved: missile direction 1-4"), (0x6F34, "Bit 7: just fired, so not erased off the hero"),
        (0x6F36, "The slot is now in use"),
        (0x6F39, "It starts at the hero's cell"),
        (0x6F3C, "Missile x = hero x"), (0x6F3F, "And the hero's y..."), (0x6F42, "...is the missile's y"),
        (0x6F45, "Sound the bell"),
        (0x6F47, "BEL: the firing sound"),
        (0x6F4A, "The missile carries the hero's missile damage..."),
        (0x6F4D, "...into this missile, for whatever it hits"),
        (0x6F50, "...and sprites"),
        (0x6F53, "...so it is drawn as the hero's weapon"),
        (0x6F56, "The hero stays where they were"),
        (0x6F59, "Hero x unchanged: firing does not move the hero"), (0x6F5C, "And the hero's y..."), (0x6F5F, "...unchanged too"),
        (0x6F62, "Toggle the hero's frame"),
        (0x6F65, "Flip between frames 0 and 1..."), (0x6F67, "...so the hero is seen to throw"),
        (0x6F6A, "Redraw the hero"),
        (0x6F70, "Next slot"), (0x6F71, "Past the hero's last slot?"), (0x6F74, "No: try that slot"),
        (0x6F76, "All in flight: just redraw the hero"),
        (0x6F79, "Move the hero's cell in the direction faced: up..."),
        (0x6F7C, "Facing up?"), (0x6F7E, "No: try right"), (0x6F80, "Up: one row up the map"),
        (0x6F83, "...right..."), (0x6F85, "Facing right?"), (0x6F87, "Right: one column along"),
        (0x6F8A, "...down..."), (0x6F8C, "Facing down?"), (0x6F8E, "Down: one row down the map"),
        (0x6F91, "...left"), (0x6F93, "Facing left?"), (0x6F95, "Left: one column back"),
        (0x6F98, "Note the new cell for the door and key checks"),
        (0x6F9B, "hero_door_x: the cell update_game tests for doors"), (0x6F9E, "And the new y..."), (0x6FA1, "...into hero_door_y"),
        (0x6FA4, "Is there a wall in the new cell?"),
        (0x6FA7, "cell_x: the cell for test_wall"), (0x6FAA, "And the new y..."), (0x6FAD, "...into cell_y"), (0x6FB0, "Keep the hero number..."),
        (0x6FB1, "...on the stack across test_wall"), (0x6FB2, "Y non-zero if the cell has a wall"), (0x6FB5, "Recover the hero number..."), (0x6FB6, "...into X"),
        (0x6FB7, "Wall bit clear?"),
        (0x6FB9, "No: check monster in cell"),
        (0x6FBB, "Yes: stay put..."),
        (0x6FBE, "...put the hero back at x..."), (0x6FC1, "And the old y..."), (0x6FC4, "...so the hero does not enter the wall"),
        (0x6FC7, "Cancel the step"),
        (0x6FC9, "No step under way..."), (0x6FCC, "...no horizontal offset..."), (0x6FCF, "...and no vertical offset"),
        (0x6FD2, "...and redraw"),
        (0x6FD5, "Is there a monster in the new cell?"),
        (0x6FD7, "scratch 0: look for monsters only, not heroes"), (0x6FDA, "Keep the hero number..."), (0x6FDB, "...on the stack across find_creature"), (0x6FDC, "Y non-zero if a monster is in the cell"),
        (0x6FDF, "Recover the hero number..."), (0x6FE0, "...into X"), (0x6FE1, "A monster there?"),
        (0x6FE3, "No: check hero in cell"),
        (0x6FE5, "Yes: stay put, cancel the step..."),
        (0x6FFC, "...and lose a health point for bumping into it"),
        (0x6FFF, "Redraw"),
        (0x7002, "Is another hero in play in the new cell?"),
        (0x7005, "Start from hero 0"), (0x7007, "Not this hero"), (0x700A, "This hero: skip it"),
        (0x700C, "Other hero's x..."), (0x700F, "...the same as the new cell's?"), (0x7012, "No: not in the way"), (0x7014, "Other hero's y..."),
        (0x7017, "...the same too?"), (0x701A, "No: not in the way"), (0x701C, "Is that hero in play?"), (0x701F, "No (dead or absent): not in the way"),
        (0x7021, "Yes: stay put, cancel the step and redraw"),
        (0x703B, "Next hero"), (0x703C, "Checked all four?"), (0x703E, "No: the next one"),
        (0x7040, "Has the hero moved into another room?"),
        (0x7041, "Two bytes per view_room entry..."), (0x7042, "...so X indexes this hero's"), (0x7043, "The room this hero's view shows (low byte)..."), (0x7046, "...against the new cell's room, from test_wall"),
        (0x7048, "No: check boots"),
        (0x704A, "Yes: change this hero's view to the new room..."),
        (0x704B, "Halve the index..."), (0x704C, "...back to the hero number"), (0x704D, "Point the hero's view at the new room and redraw it"),
        (0x7050, "...and cancel the step"),
        (0x7053, "Same room. Wearing Boots of Speed?"),
        (0x7054, "Halve the view index..."), (0x7055, "...back to the hero number"), (0x7056, "Non-zero while the hero wears the boots"),
        (0x7059, "No: stay in old cell"),
        (0x705B, "Yes: arrive in the cell at once, with no step"),
        (0x705D, "No horizontal offset..."), (0x7060, "...no vertical offset..."), (0x7063, "...and no step: the move is complete"), (0x7066, "Erase the old position and draw the new"),
        (0x7069, "No boots: stay in the old cell for now; "
                 "continue_hero_step moves on at the end of the step"),
        (0x706C, "...the step's pixel offsets carry the hero across"), (0x706F, "And the old y..."), (0x7072, "...until the step finishes"),
        (0x7075, "Erase the hero at the old position (blank sprite)"),
        (0x7077, "The sprite to plot over the hero"), (0x7079, "The hero's position before this frame..."), (0x707C, "...as the cell to plot at"), (0x707F, "And the old y..."),
        (0x7082, "...into cell_y"), (0x7085, "The old pixel offsets too..."), (0x7088, "...across..."), (0x708A, "...and down..."),
        (0x708D, "...so the blank lands exactly on the old image"), (0x708F, "Keep the hero number..."), (0x7090, "...on the stack across plot_at_cell"), (0x7091, "Blank the hero in every view showing that cell"),
        (0x7094, "Recover the hero number..."), (0x7095, "...into X"),
        (0x7096, "Still in play?"),
        (0x7097, "Direction 0: out of play"), (0x709A, "No: next hero"),
        (0x709C, "Sprite = direction + frame + the hero's sprite base"),
        (0x709F, "...plus Ranger, Magic-User, Barbarian or Fighter base"), (0x70A2, "The sprite to draw"),
        (0x70A4, "Draw the hero"),
        (0x70A7, "Can the hero's cell hold an object?"),
        (0x70AA, "The hero's cell, to test for an object..."), (0x70AD, "And the hero's y..."), (0x70B0, "...into cell_y"), (0x70B3, "Keep the hero number..."),
        (0x70B4, "...on the stack across test_object_free"), (0x70B5, "Y zero if an object may lie in the cell"), (0x70B8, "Recover the hero number..."), (0x70B9, "...into X"),
        (0x70BA, "Can an object lie there?"),
        (0x70BC, "No: next hero"),
        (0x70BE, "Yes: pick up whatever is there"),
        (0x70C1, "Next hero"), (0x70C2, "All four heroes moved?"), (0x70C4, "Yes: done"),
        (0x70C6, "No: move the next hero"), (0x70C9, "Return"),

        (0x7619, "Count down the magic key delay"),
        (0x761C, "Zero: time to look at the magic key"),
        (0x761E, "Not yet: return, which leaves move_heroes for this frame"),
        (0x761F, "Check the key every frame from now on"),
        (0x7621, "...so the next press is seen at once"),
        (0x7624, "Magic key pressed?"),
        (0x7627, "Scan it: Z set if pressed"),
        (0x762A, "No: carry on reading the keys"),
        (0x762C, "Yes: play the magic sound"),
        (0x7642, "Ignore the key for the next three frames"),
        (0x7644, "...so one press casts only once"),
        (0x7647, "Health cost: 3 for the Magic-User..."),
        (0x7649, "Magic-User (hero 1): the cheaper rate"),
        (0x764B, "...6 for the Ranger"),
        (0x7650, "Magic-User: 3 points"),
        (0x7652, "Take the cost"),
        (0x7653, "Keep the count of points still to take"), (0x7654, "Take one point of the caster's health"), (0x7657, "Recover the count..."), (0x7658, "...into Y"),
        (0x7659, "One point fewer to take"), (0x765A, "Until the whole cost is paid"),
        (0x765C, "No monsters killed yet"),
        (0x765E, "...in magic_kill_count"),
        (0x7661, "sprite_number = 2 x hero, an index into view_room"),
        (0x7662, "...x 2: view_room holds two bytes per hero"), (0x7663, "...kept in sprite_number, free as scratch here"),
        (0x7665, "For each monster..."),
        (0x7667, "...find its room"),
        (0x766A, "...from its map x..."), (0x766D, "...and its map y"), (0x7670, "...set as the cell to test"), (0x7673, "Keep the monster number..."),
        (0x7674, "...on the stack"), (0x7675, "Work out the monster's room in map_ptr"), (0x7678, "Recover the monster number..."), (0x7679, "...into X"),
        (0x767A, "In the room this hero's view shows?"),
        (0x767C, "The room the caster's view shows..."), (0x767F, "...is it the monster's room?"), (0x7681, "No: next monster magic"),
        (0x7683, "Alive?"), (0x7686, "Below the blank sprite: alive"), (0x7688, "No: next monster magic"),
        (0x768A, "Yes: start it dying..."), (0x768C, "...so the magic kills it"),
        (0x768F, "...and count it"),
        (0x7692, "Next monster"), (0x7693, "Until all 30 monsters are checked"),
        (0x7695, "One point for each monster killed"),
        (0x7697, "...halve the view_room index back to the hero"), (0x7698, "...X = the caster, who scores the points"), (0x7699, "...Y = the monsters killed"), (0x769C, "Any kills left to score?"),
        (0x769E, "None: the magic is done"), (0x76A0, "Keep the count..."), (0x76A1, "...on the stack"), (0x76A2, "One point to the caster"),
        (0x76A5, "Recover the count..."), (0x76A6, "...into Y"), (0x76A7, "One kill fewer to score"), (0x76A8, "Score the next"),
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
          "for each hero who left by the exit, before the last returns to "
          "the caller.",
           on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    for addr, text in [
        (0x1F00, "Wait for the vertical sync counter to pass zero..."),
        (0x1F03, "Not yet negative: keep waiting"),
        (0x1F05, "...and set it for three syncs from now"),
        (0x1F07, "...in the MOS's vertical sync counter"),
        (0x1F0A, "Has the Chalice been found?"),
        (0x1F0D, "Run a frame"),
        (0x1F10, "A hero going down the exit?"),
        (0x1F13, "Yes: carry on"),
        (0x1F15, "Is any hero in play, or still dying?"),
        (0x1F17, "In play?"),
        (0x1F1A, "Yes: carry on"),
        (0x1F1C, "Dead..."),
        (0x1F1F, "...(health tens digit below 0)..."), (0x1F21, "No: alive but out of play; next hero"),
        (0x1F23, "...with the death animation unfinished?"),
        (0x1F26, "...frame 8 is the last of the death"),
        (0x1F28, "Yes: carry on"),
        (0x1F2A, "Next hero"),
        (0x1F2B, "More heroes: check the next"),
        (0x1F2D, "The level is over: restore the last exiting hero's sprites"),
        (0x1F30, "None (&FF): nothing to restore"), (0x1F32, "Give them back their full-size sprites"),
        (0x1F35, "Return"),
        (0x1F36, "Is a hero on the exit?"),
        (0x1F38, "The hero's x..."), (0x1F3B, "...at the exit's x?"), (0x1F3E, "No: next hero"),
        (0x1F40, "...and y..."), (0x1F43, "...at the exit's y?"), (0x1F46, "No: next hero"),
        (0x1F48, "Yes: drop their key beside it"),
        (0x1F4B, "Take them out of play for the rest of the level"),
        (0x1F4D, "...so they are never animated..."), (0x1F50, "...and no direction..."), (0x1F52, "...so move_heroes skips them"),
        (0x1F55, "Erase them"),
        (0x1F58, "...from cell_x..."), (0x1F5B, "...and the hero's y..."), (0x1F5E, "...in cell_y..."), (0x1F61, "...on the cell itself: no pixel offset..."),
        (0x1F63, "...horizontally..."), (0x1F65, "...or vertically..."), (0x1F67, "...with the blank sprite"), (0x1F69, "...as the sprite to plot"),
        (0x1F6B, "Keep the hero number..."), (0x1F6C, "...on the stack across plot_at_cell"), (0x1F6D, "Plot the blank in every view showing them"), (0x1F70, "Recover the hero number..."),
        (0x1F71, "...into X"),
        (0x1F72, "Move them off the map"),
        (0x1F74, "...x off the map, so nothing meets them"),
        (0x1F77, "Hide the exit while they go down it, keeping its position"),
        (0x1F7A, "...x saved..."), (0x1F7D, "...and its y..."), (0x1F80, "...saved too"), (0x1F83, "...then put the exit off the map..."),
        (0x1F85, "...x..."), (0x1F88, "...and y, so no other hero can enter it"),
        (0x1F8B, "Start the exit animation (which jumps back to play_level)"),
        (0x1F8E, "Reached by the RTS at the end of the level"),
        (0x1F91, "Next hero"),
        (0x1F92, "All four heroes checked?"), (0x1F94, "No: check the next"),
        (0x1F96, "A hero going down the exit?"),
        (0x1F99, "Yes: redraw exit"),
        (0x1F9B, "No: next frame"),
        (0x1F9E, "Redraw the exit"),
        (0x1FA1, "...on its cell: no pixel offset..."), (0x1FA3, "...horizontally..."), (0x1FA5, "...or vertically..."), (0x1FA7, "...at its saved x..."),
        (0x1FAA, "...as cell_x..."), (0x1FAD, "...and saved y..."), (0x1FB0, "...as cell_y..."), (0x1FB3, "...with the exit sprite..."),
        (0x1FB5, "...as the sprite to plot"), (0x1FB7, "Plot it in every view showing it"),
        (0x1FBA, "Turn the hero a quarter (frames 1, 3, 5, 7)"),
        (0x1FBD, "...clear carry for the add"), (0x1FBE, "...from the current direction..."), (0x1FC1, "...two sprites on: the next direction..."), (0x1FC3, "...kept for the next frame"),
        (0x1FC6, "A full turn?"),
        (0x1FC8, "Yes: shrink the hero"),
        (0x1FCA, "Plot the hero on the exit, centred for its current size"),
        (0x1FCB, "...the hero's sprite base..."), (0x1FCE, "...plus the direction's frame..."), (0x1FD1, "...as the sprite to plot"), (0x1FD3, "...on the exit's cell: its x..."),
        (0x1FD6, "...as cell_x..."), (0x1FD9, "...and its y..."), (0x1FDC, "...as cell_y"), (0x1FDF, "...with offsets for its size, by turns left..."),
        (0x1FE2, "...horizontal offset..."), (0x1FE5, "...as plot_offset_x..."), (0x1FE7, "...vertical offset..."), (0x1FEA, "...as plot_offset_y"),
        (0x1FEC, "Plot the hero in every view showing the exit"),
        (0x1FEF, "Next frame"),
        (0x1FF2, "Start the next turn"),
        (0x1FF4, "...-1, so the next frame's +2 gives 1"),
        (0x1FF7, "Last turn done?"),
        (0x1FFA, "Yes: the hero has gone"),
        (0x1FFC, "Shrink sprites base + 1 to + 7: a byte narrower..."),
        (0x2023, "...three rows shorter. Next frame"),
        (0x2026, "Put the exit back..."),
        (0x2029, "...x..."), (0x202C, "...and its saved y..."), (0x202F, "...as its y"),
        (0x2032, "...and end the animation"),
        (0x2034, "...exit no longer busy"),
        (0x2037, "Next frame"),

        (0x203A, "Keep the hero number"),
        (0x203D, "Sound the exit and queue a marker"),
        (0x2040, "exit_offsets_x entry 0 = 4..."), (0x2042, "...never read: shrinks run from 4 down to 1"),
        (0x2045, "Restore the sprites of any hero shrunk before"),
        (0x2048, "None (&FF): go straight on"), (0x204A, "Give that hero back their full-size sprites"), (0x204D, "...then start this hero's spin"),
        (0x2076, "Start the animation for this hero..."),
        (0x2078, "...the exit is busy..."), (0x207B, "...the hero kept by hero_enters_exit..."), (0x207E, "...is the one going down..."), (0x2081, "...and the one whose sprites will shrink"),
        (0x2084, "...turning from the start..."), (0x2086, "...-1, so the first frame's +2 gives 1"),
        (0x2089, "...for four turns"), (0x208B, "...as exit_shrinks_left"),
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
        (0x70CC, "Missiles are drawn whole cells at a time..."), (0x70CE, "...so no vertical offset either"),
        (0x70D0, "For each of the twelve missile slots..."),
        (0x70D2, "In flight?"),
        (0x70D5, "Yes: check just fired"),
        (0x70D7, "No: next slot"),
        (0x70DA, "Just fired (bit 7 set)?"),
        (0x70DC, "Yes: clear the flag..."),
        (0x70DE, "Store the direction without the flag"),
        (0x70E1, "...animate the hero who fired it..."),
        (0x70E4, "...and move it without erasing (it is on the hero)"),
        (0x70E7, "Erase the missile at its old cell"),
        (0x70E9, "The sprite to plot over the missile"), (0x70EB, "The missile's x..."), (0x70EE, "...as the cell to plot at"), (0x70F1, "And its y..."),
        (0x70F4, "...into cell_y"), (0x70F7, "Keep the missile slot..."), (0x70F8, "...on the stack across plot_at_cell"), (0x70F9, "Blank it in every view showing that cell"),
        (0x70FC, "Recover the missile slot..."), (0x70FD, "...into X"),
        (0x70FE, "Move it one cell: up..."),
        (0x7101, "Direction 1: up"), (0x7103, "No: try right"), (0x7105, "Up: one row up the map"),
        (0x7108, "...right..."), (0x710A, "No: try down"), (0x710C, "Right: one column along"),
        (0x710F, "...down..."), (0x7111, "No: try left"), (0x7113, "Down: one row down the map"),
        (0x7116, "...left"), (0x7118, "No: it has moved"), (0x711A, "Left: one column back"),
        (0x711D, "Wall in the new cell?"),
        (0x7120, "...as the cell to test"), (0x7123, "And its y..."), (0x7126, "...into cell_y"), (0x7129, "Keep the missile slot..."),
        (0x712A, "...on the stack across the tests"), (0x712B, "Z set if the cell is clear of walls"),
        (0x712E, "No: check missile monster"),
        (0x7130, "Yes: the missile is spent"),
        (0x7131, "Recover the missile slot"),
        (0x7132, "Free the slot"),
        (0x7134, "Direction 0: the slot is empty"),
        (0x7137, "Next slot"),
        (0x713A, "Monster in the new cell (not checking heroes)?"),
        (0x713C, "scratch 0: look for monsters only, not heroes"), (0x713F, "Z clear, X = the monster, if one is in the cell"),
        (0x7142, "No: check missile object"),
        (0x7144, "Yes, but is it alive?"),
        (0x7147, "Sprites from the first sparkle on are dying"), (0x7149, "No: fly on"),
        (0x714B, "Alive: hit it"),
        (0x714C, "Y = the missile slot, for monster_hit"), (0x714D, "Take its damage from the monster's hit points"),
        (0x7150, "Monster killed: a point to the hero who fired..."),
        (0x7153, "...and the missile is spent"),
        (0x7156, "Can the new cell hold an object?"),
        (0x7157, "Recover the missile slot"), (0x7158, "The missile's x..."), (0x715B, "...as the cell to test"), (0x715E, "And its y..."),
        (0x7161, "...into cell_y"), (0x7164, "Keep the missile slot..."), (0x7165, "...on the stack across test_object_free"), (0x7166, "Y zero if an object may lie in the cell"),
        (0x7169, "Recover the missile slot..."), (0x716A, "...into X"), (0x716B, "Can an object lie there?"),
        (0x716D, "No: check for heroes"),
        (0x716F, "Look for an energy drainer at the cell..."),
        (0x7170, "Keep the missile slot while X runs over objects"), (0x7171, "...objects 30 to 1"),
        (0x7173, "This object's x..."), (0x7176, "...the missile's cell?"), (0x7179, "No: the next object"), (0x717B, "This object's y..."),
        (0x717E, "...the missile's cell too?"), (0x7181, "No: the next object"),
        (0x7183, "Is it a drainer (&53-&5E)?"),
        (0x7186, "Below the drainer sprites?"), (0x7188, "No: no drainer"),
        (0x718A, "Past the last drainer stage?"), (0x718C, "No: no drainer"),
        (0x718E, "Yes: wear it down a stage"),
        (0x7191, "Its new stage..."), (0x7194, "Worn away?"), (0x7196, "No: credit drainer hit"),
        (0x7198, "Yes: remove it from the level"),
        (0x719A, "Off the map in x..."), (0x719D, "...and y, so it is never drawn or met again"),
        (0x71A0, "A point to the hero who fired"),
        (0x71A1, "Recover the missile slot"), (0x71A2, "Which hero's weapon it is decides who scores"),
        (0x71A5, "Bounce the missile back: up becomes down..."),
        (0x71A8, "Flying up?"), (0x71AA, "No: try right"), (0x71AC, "Down instead"), (0x71AE, "Send it back the way it came"),
        (0x71B1, "Then see whether it hits a hero"),
        (0x71B4, "...right becomes left..."),
        (0x71B6, "No: try down"), (0x71B8, "Left instead"), (0x71BA, "Send it back the way it came"), (0x71BD, "Then see whether it hits a hero"),
        (0x71C0, "...down becomes up..."),
        (0x71C2, "No: it was flying left"), (0x71C4, "Up instead"), (0x71C6, "Send it back the way it came"), (0x71C9, "Then see whether it hits a hero"),
        (0x71CC, "...and left becomes right"),
        (0x71CE, "Send it back the way it came"), (0x71D1, "Then see whether it hits a hero"),
        (0x71D4, "Next object"),
        (0x71D5, "Until all 30 are checked"),
        (0x71D7, "No drainer here"),
        (0x71D8, "Recover the missile slot"),
        (0x71D9, "Is a hero in the new cell?"),
        (0x71DA, "Keep the missile slot while X runs over heroes"), (0x71DB, "From hero 0"),
        (0x71DD, "Fetch the missile slot..."), (0x71DE, "...into Y..."), (0x71DF, "...leaving it on the stack"),
        (0x71E0, "This hero's x..."), (0x71E3, "...the missile's cell?"), (0x71E6, "No: the next hero"),
        (0x71E8, "This hero's y..."), (0x71EB, "...the missile's cell too?"), (0x71EE, "No: the next hero"),
        (0x71F0, "Yes: they lose the missile's damage in health..."),
        (0x71F3, "Y counts the points to take"), (0x71F4, "Keep the count..."), (0x71F5, "...on the stack across the call"), (0x71F6, "One point of health"),
        (0x71F9, "Recover the count..."), (0x71FA, "...into Y"), (0x71FB, "One fewer to take"), (0x71FC, "More to take: again"),
        (0x71FE, "...and the missile is spent"),
        (0x7201, "Next hero"), (0x7202, "All four heroes checked?"), (0x7204, "No: check the next hero against the missile's cell"),
        (0x7206, "Nothing hit: draw the missile in its new cell"),
        (0x7207, "Missile slot back in X"), (0x7208, "Sprite = the missile's base..."), (0x7209, "...(its hero's weapon, the sprite before its up sprite)..."), (0x720C, "...plus its direction, 1-4: the weapon pointing that way"),
        (0x720F, "...is the sprite to plot"), (0x7211, "Keep the missile slot..."), (0x7212, "...across the plot"), (0x7213, "Plot the missile in every view showing its cell"),
        (0x7216, "Recover the missile slot..."), (0x7217, "...into X"),
        (0x7218, "Next slot"), (0x7219, "Past the twelfth slot?"), (0x721B, "Yes: every missile moved"),
        (0x721D, "No: move this slot's missile"), (0x7220, "Return"),

        # A missile hits a monster (reached from move_missiles)
        (0x757C, "Play the hit sound"),
        (0x758D, "Take the missile's damage from the monster's hit points"),
        (0x7590, "...set the carry for the subtraction..."), (0x7591, "...minus the hitting missile's damage"),
        (0x7594, "Still alive?"),
        (0x7596, "No: start it dying..."), (0x7598, "...from the blank sprite through the sparkles"),
        (0x759B, "...and give the slot fresh hit points for its next "
                 "appearance"),
        (0x759E, "...as its hit points"),
        (0x75A1, "Missile slot back in X..."),
        (0x75A2, "...for monster_killed"),
        (0x75A3, "...a point to its hero, and the missile is spent"),
        (0x75A6, "Alive: store the hit points left"),
        (0x75A9, "Push the missile slot, as missile_spent_pop..."), (0x75AA, "...expects to find it on the stack"),
        (0x75AB, "The missile is spent"),

        # credit_missile_owner, flip_firer_frame
        (0x76B1, "Which hero fired it? Its sprite base says"),
        (0x76B4, "Keep the missile slot..."), (0x76B5, "...on the stack"), (0x76B6, "Compare the missile's sprite base"),
        (0x76B7, "Arrows: the Ranger"), (0x76B9, "Not arrows: try fireballs"), (0x76BB, "Arrows: the Ranger, hero 0"),
        (0x76BD, "Score it"),
        (0x76C0, "Fireballs: the Magic-User"), (0x76C2, "Not fireballs: try axes"), (0x76C4, "Fireballs: the Magic-User, hero 1"),
        (0x76C6, "Score it"),
        (0x76C9, "Axes: the Barbarian"), (0x76CB, "Not axes: so it must be swords"), (0x76CD, "Axes: the Barbarian, hero 2"),
        (0x76CF, "Score it"),
        (0x76D2, "Otherwise swords: the Fighter"),
        (0x76D4, "One point to that hero"),
        (0x76D7, "Recover the missile slot..."), (0x76D8, "...into X"), (0x76D9, "Return"),
        (0x7747, "Which hero fired it? Arrows: toggle the Ranger's frame"),
        (0x774A, "...arrows?"), (0x774C, "Not arrows: try fireballs"), (0x774E, "The Ranger's animation frame..."), (0x7751, "...flipped between 0 and 1..."),
        (0x7753, "...so the Ranger moves as it fires"), (0x7756, "Return"),
        (0x7757, "Fireballs: the Magic-User's"),
        (0x7759, "Not fireballs: try axes"), (0x775B, "The Magic-User's animation frame..."), (0x775E, "...flipped between 0 and 1..."), (0x7760, "...so the Magic-User moves as it casts"),
        (0x7763, "Return"),
        (0x7764, "Axes: the Barbarian's"),
        (0x7766, "Not axes: so it must be swords"), (0x7768, "The Barbarian's animation frame..."), (0x776B, "...flipped between 0 and 1..."), (0x776D, "...so the Barbarian moves as it throws"),
        (0x7770, "Return"),
        (0x7771, "Otherwise swords: the Fighter's"),
        (0x7774, "...flipped between 0 and 1..."), (0x7776, "...so the Fighter moves as it throws"), (0x7779, "Return"),

        # collect_objects
        (0x7329, "Look for an object at the hero's cell"),
        (0x732C, "...: its map x..."), (0x732F, "...and map y..."), (0x7332, "...as the cell to look in"),
        (0x7335, "...objects 30 to 1"),
        (0x7337, "Object Y's map x..."), (0x733A, "...the same as the hero's?"), (0x733D, "Yes: compare the y"), (0x733F, "No: try the next object"),
        (0x7342, "Object Y's map y..."), (0x7345, "...the same as the hero's?"), (0x7348, "Yes: the hero is on this object"), (0x734A, "No: try the next object"),
        (0x734D, "Found: picking up anything loses Boots of Speed"),
        (0x734E, "Keep the object number..."), (0x734F, "...take the boots off..."), (0x7351, "...this hero"),
        (0x7354, "...remove the bolt from the panel"),
        (0x7357, "...by plotting the blank in its place"),
        (0x735A, "Recover the object number..."), (0x735B, "...into Y"),
        (0x735C, "Treasure?"), (0x735F, "...is it treasure?"), (0x7361, "No: check food"),
        (0x7363, "Yes: play the treasure sound"),
        (0x737D, "20 points"),
        (0x737E, "...keeping the object number"), (0x737F, "Ten points..."), (0x7382, "...and ten more"),
        (0x7385, "Recover the object number..."), (0x7386, "...into Y"),
        (0x7387, "Remove it"),
        (0x738A, "Food?"), (0x738C, "No: check teleporter"),
        (0x738E, "Yes: 10 health..."),
        (0x7391, "...and look at the new tens digit"), (0x7394, "...to at most 99"), (0x7396, "Not past 9: health is up by 10"),
        (0x7398, "Past 9: health is 99..."), (0x739A, "...tens 9..."), (0x739D, "...units 9"),
        (0x73A0, "Redraw the health"),
        (0x73A1, "Keep the object number"), (0x73A2, "Draw the new health in the panel"),
        (0x73A5, "5 points"),
        (0x73A7, "Keep the count of points to add..."), (0x73A8, "...across add_point"), (0x73A9, "One point"), (0x73AC, "Recover the count..."),
        (0x73AD, "...into Y"), (0x73AE, "One fewer to add"), (0x73AF, "Until all five are added"),
        (0x73B1, "Play the food sound"),
        (0x73C0, "Remove it"),
        (0x73C3, "Teleporter?"), (0x73C5, "No: check cross"),
        (0x73C7, "Yes: find the previous teleporter in the list..."),
        (0x73C8, "...is it a teleporter?"), (0x73CB, "...type matches a teleporter's?"), (0x73CD, "Yes: teleport to it"),
        (0x73CF, "Reached the start of the list?"), (0x73D1, "No: keep looking backwards"),
        (0x73D3, "...wrapping round to the end"),
        (0x73D6, "...and keep looking"),
        (0x73D9, "Play the teleport sound"),
        (0x73EA, "Move the hero to the cell above it"),
        (0x73ED, "...same column as the teleporter..."), (0x73F0, "...and the cell for drawing"), (0x73F3, "...one row above it..."), (0x73F6, "...subtract 1 from the teleporter's row..."),
        (0x73F7, "...(so the hero does not land on it and teleport again)"), (0x73F9, "...as the hero's row"), (0x73FC, "...and the cell for drawing"),
        (0x73FF, "...with no step in progress"),
        (0x7401, "...not part way through a step"), (0x7404, "...and no pixel offsets"), (0x7407, "...in either direction"),
        (0x740A, "Show the room they arrive in"),
        (0x740D, "Cross of Resurrection?"), (0x740F, "No: check magic item"),
        (0x7411, "Yes: remove it"),
        (0x7413, "...off the map..."), (0x7416, "...in both x and y"),
        (0x7419, "10 points"),
        (0x741C, "Keep the hero..."), (0x741D, "...across the sound"),
        (0x741E, "Play the pickup sound"),
        (0x7421, "Anyone waiting to return?"),
        (0x7424, "Yes: take returning hero"),
        (0x7426, "No: return"), (0x7427, "...the hero number into X..."), (0x7428, "...and return"),
        (0x7429, "Take the first entry off the queue, appending 0..."),
        (0x742B, "First entry: a hero number + 1, the &64 marker or 0..."), (0x742E, "...minus 1: the hero, &63 for the marker, &FF for none"), (0x742F, "Shift the queue up one: the second entry..."), (0x7432, "...becomes the first..."),
        (0x7435, "...the third..."), (0x7438, "...becomes the second..."), (0x743B, "...the fourth..."), (0x743E, "...becomes the third..."),
        (0x7441, "...and Y fills the last (0, or the marker sent back)"),
        (0x7444, "A &64 marker?"), (0x7446, "No: check queue empty"),
        (0x7448, "Yes: move it to the back and take the next entry"),
        (0x744A, "...(always taken)"),
        (0x744C, "Queue empty?"), (0x744E, "Yes: nobody returns"),
        (0x7450, "Start hero X returning: out of play..."),
        (0x7452, "...direction 0: not in play while the sprites run"),
        (0x7455, "...from the last appearance sprite..."),
        (0x7457, "...frame 8, the last of hero_appearance_sprites"),
        (0x745A, "...stepping backwards..."),
        (0x745C, "...frame step -1"),
        (0x745F, "...every other frame"),
        (0x7461, "...the frame counter"),
        (0x7464, "Return"), (0x7465, "...hero number back into X"), (0x7466, "...and return"),
        (0x7467, "Remove object Y from the level"),
        (0x7469, "...off the map in x..."), (0x746C, "...and y, so it is neither drawn nor found again"), (0x746F, "Return"),
        (0x7470, "Next object"), (0x7471, "Past object 1: nothing here"), (0x7473, "Check this object"),
        (0x7476, "Return"),
        (0x7477, "One of the magic items (&5F and up)?"),
        (0x7479, "Yes: magic item"),
        (0x747B, "The exit? Nothing to do here"),
        (0x747D, "...so look no further"),
        (0x747F, "An energy drainer: play the hit sound louder..."),
        (0x7481, "...a louder volume in hit_sound..."), (0x7484, "Keep the hero..."), (0x7485, "...across the OSWORD call"), (0x7486, "SOUND hit_sound..."),
        (0x7488, "...high byte..."), (0x748A, "...OSWORD 7, SOUND"), (0x748C, "Play the drainer's louder hit sound"),
        (0x748F, "...then put the volume back"),
        (0x7491, "...for monsters being hit"), (0x7494, "Recover the hero..."), (0x7495, "...into X"),
        (0x7496, "...and take 10 health"),
        (0x7498, "Keep the count..."), (0x7499, "...across lose_health_point"), (0x749A, "Take one health point"), (0x749D, "Recover the count..."),
        (0x749E, "...into Y"), (0x749F, "One fewer to take"), (0x74A0, "Until all ten are taken"),
        (0x74A2, "Return"),
        (0x74A3, "Define the envelope..."),
        (0x74A5, "...high byte..."), (0x74A7, "...OSWORD 8, ENVELOPE"), (0x74A9, "Define the pickup envelope"),
        (0x74AC, "...and play the sound"),
        (0x74AE, "...high byte..."), (0x74B0, "...OSWORD 7, SOUND"), (0x74B2, "Play the pickup sound"),
        (0x74B5, "Return"),
        (0x74B6, "A magic item: keep its type"),
        (0x74B9, "Remove it from the level"),
        (0x74BB, "...off the map in x..."), (0x74BE, "...and y"),
        (0x74C1, "Play the pickup sound"),
        (0x74CF, "Keep the score's units digit, for a potion"),
        (0x74D2, "...in scratch2, before the points change it"),
        (0x74D5, "10 points"),
        (0x74D8, "Boots of Speed?"), (0x74DB, "...is it Boots of Speed?"), (0x74DD, "No: check helmet"),
        (0x74DF, "Yes: show the bolt in the panel..."),
        (0x74E2, "...lightning bolt"),
        (0x74E5, "...and wear them"),
        (0x74E7, "...so the hero steps faster"), (0x74EA, "Return"),
        (0x74EB, "Magic helmet?"), (0x74ED, "No: check potion"),
        (0x74EF, "Yes: lose one less health per hit..."),
        (0x74F2, "...and look at it"), (0x74F5, "...but never fewer than 3"),
        (0x74F7, "3 or more: keep it"), (0x74F9, "Below 3: put it back to 3"),
        (0x74FC, "Redraw the armour rating"),
        (0x74FF, "Potion of healing?"), (0x7501, "No: check weapons"),
        (0x7503, "Yes: health tens = the score's units digit..."),
        (0x7506, "...as the health's tens digit"),
        (0x7509, "...units one more, then take a point to draw it"),
        (0x750C, "...the units digit one higher..."), (0x750F, "...as the health's units"), (0x7512, "...which also redraws the health"),
        (0x7515, "Return"),
        (0x7516, "Pile of weapons?"), (0x7518, "No: a magic sword"),
        (0x751A, "Yes: one more missile in flight..."),
        (0x751D, "...and look at it"), (0x7520, "...to at most 3"),
        (0x7522, "Not past 3: draw the new icon"), (0x7524, "Past 3: back to 3..."), (0x7526, "...as the missiles allowed"),
        (0x7529, "Draw the new missile icon"),
        (0x756B, "A magic sword: more missile damage..."),
        (0x756E, "...and look at it"), (0x7571, "...to at most 9"),
        (0x7573, "Not past 9: draw the new damage"), (0x7575, "Past 9: back to 9..."), (0x7577, "...as the missile damage"), (0x757A, "...and draw it (always taken)"),
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
        (0x79C3, "Trapdoors sit squarely in their cells:"), (0x79C5, "...no horizontal offset..."), (0x79C7, "...and no vertical offset"), (0x79C9, "The trapdoor sprite..."),
        (0x79CB, "...to plot"),
        (0x79CD, "This trapdoor's map x..."), (0x79D0, "...as the cell to plot"), (0x79D3, "...and its map y"), (0x79D6, "...likewise"),
        (0x79D9, "Keep the trapdoor number..."), (0x79DA, "...on the stack"), (0x79DB, "Draw it in every view showing its cell"), (0x79DE, "Recover the trapdoor number..."),
        (0x79DF, "...into X"), (0x79E0, "Next trapdoor"), (0x79E1, "Until all eight are drawn"),
        (0x79E3, "For each monster, 30 to 1..."),
        (0x79E5, "Keep the monster number..."), (0x79E6, "...on the stack while it moves"),
        (0x79E7, "Erase it at its cell and offsets, remembering the cell"),
        (0x79EA, "...as the cell to erase..."), (0x79ED, "...and as where it came from"), (0x79F0, "...and its map y..."), (0x79F3, "...as the cell to erase..."),
        (0x79F6, "...and as where it came from"), (0x79F9, "The blank sprite..."), (0x79FB, "...to rub it out"), (0x79FD, "Its horizontal offset..."),
        (0x7A00, "...set for the erase"), (0x7A02, "Its vertical offset..."), (0x7A05, "...set for the erase"), (0x7A07, "Plot the blank over the monster, wherever it is"),
        (0x7A0A, "Recover the monster number..."), (0x7A0B, "...keeping it stacked for later"), (0x7A0C, "...in X"),
        (0x7A0D, "Dying? Death frames are sprite &15 and up"),
        (0x7A10, "Sprites &15 and up are death frames"),
        (0x7A12, "No: check monster step"),
        (0x7A14, "Yes: advance the death animation"),
        (0x7A17, "Part way through a step?"),
        (0x7A1A, "No: start monster move"),
        (0x7A1C, "Yes: continue it and draw"),
        (0x7A1F, "Drop the stacked monster number (X still has it)"), (0x7A20, "Draw it at its grown offsets"),
        (0x7A23, "Start a step: move the cell in the direction it faces, "
                 "up..."),
        (0x7A26, "Facing up?"), (0x7A28, "No: try right"), (0x7A2A, "Yes: one row up"),
        (0x7A2D, "...right..."), (0x7A2F, "No: try down"), (0x7A31, "Yes: one column right"),
        (0x7A34, "...down..."), (0x7A36, "No: try left"), (0x7A38, "Yes: one row down"),
        (0x7A3B, "...left"), (0x7A3D, "No: it does not move"), (0x7A3F, "Yes: one column left"),
        (0x7A42, "Set the step's offsets"),
        (0x7A45, "Wall in the new cell?"),
        (0x7A48, "...as cell_x for the test"), (0x7A4B, "Its new y..."), (0x7A4E, "...as cell_y"), (0x7A51, "Z set if the cell is open"),
        (0x7A54, "No: check monster blocked"),
        (0x7A56, "Yes: stay put, with no step..."),
        (0x7A57, "...recovering its number in X"), (0x7A58, "Its old x..."), (0x7A5B, "...back in monster_x"), (0x7A5E, "Its old y..."),
        (0x7A61, "...back in monster_y"), (0x7A64, "Nothing to animate:"), (0x7A66, "...no step count"), (0x7A69, "...no horizontal offset"),
        (0x7A6C, "...no vertical offset"),
        (0x7A6F, "...and turn a random way: sprite 8 + (timer AND 7)..."),
        (0x7A72, "A random 0-7..."), (0x7A74, "...plus 8..."), (0x7A75, "...gives a sprite &08-&0F"), (0x7A77, "Face the monster that way"),
        (0x7A7A, "Odd sprites (9, &0B, &0D, &0F) face a way"),
        (0x7A7C, "Even: not a facing sprite"), (0x7A7E, "Odd: a facing sprite, so draw it"), (0x7A81, "Up to the odd facing sprite after it"), (0x7A84, "Draw it"),
        (0x7A87, "Is another monster, or a hero, in the new cell? (A hero "
                 "there is hurt)"),
        (0x7A88, "...keeping it stacked"), (0x7A89, "Leave this monster out of the search"), (0x7A8C, "Look for a creature at the new cell"), (0x7A8F, "A = 0 if the cell is free"),
        (0x7A91, "No: monster vertical"),
        (0x7A93, "Yes: stay put, with no step, and turn a random way"),
        (0x7AC1, "Moving vertically..."),
        (0x7AC2, "...recovering the monster number in X"), (0x7AC3, "Its facing, as its sprite"), (0x7AC6, "Facing up?"), (0x7AC8, "Yes: check the top and bottom edges"),
        (0x7ACA, "Facing down?"), (0x7ACC, "Yes: check the top and bottom edges"),
        (0x7ACE, "No: at the left or right edge of a room?"),
        (0x7AD1, "Column within its eight-cell room"), (0x7AD3, "Column 0, the left edge"), (0x7AD5, "Column 7, the right edge?"), (0x7AD7, "Yes: at an edge"),
        (0x7AD9, "No: move on"),
        (0x7ADC, "Yes: at the top or bottom edge of a room?"),
        (0x7ADF, "Row within its eight-cell room"), (0x7AE1, "Row 0, the top edge"), (0x7AE3, "Row 7, the bottom edge?"), (0x7AE5, "Yes: at an edge"),
        (0x7AE7, "No: move on"),
        (0x7AEA, "At a room edge: cancel the step, so it arrives at once"),
        (0x7AEC, "...no step count"), (0x7AEF, "...no horizontal offset"), (0x7AF2, "...no vertical offset"), (0x7AF5, "Draw it in the new cell"),
        (0x7AF8, "Move on: stay in the old cell until the step ends"),
        (0x7AFB, "...back in monster_x"), (0x7AFE, "Old y..."), (0x7B01, "...back in monster_y"),
        (0x7B04, "Draw it: sprite = direction + frame, at its cell and "
                 "offsets"),
        (0x7B07, "...as cell_x"), (0x7B0A, "Its y..."), (0x7B0D, "...as cell_y"), (0x7B10, "Ready to add the frame"),
        (0x7B11, "Its facing sprite..."), (0x7B14, "...plus frame 0 or 1..."), (0x7B17, "...is the sprite to plot"), (0x7B19, "Horizontal offset of its step..."),
        (0x7B1C, "...for plot_at_cell"), (0x7B1E, "Vertical offset of its step..."), (0x7B21, "...for plot_at_cell"), (0x7B23, "Keep the monster number..."),
        (0x7B24, "...over the plot"), (0x7B25, "Plot it in every view that shows it"), (0x7B28, "Recover the monster number..."), (0x7B29, "...in X"),
        (0x7B2A, "Next monster"), (0x7B2B, "Monster 0: all 30 done"), (0x7B2D, "Otherwise update the next one"),
        (0x7B30, "Return"),
        (0x7B31, "Drop the stacked monster number (X still has it)"),
        (0x7B32, "Next death frame"),
        (0x7B35, "Read back the new frame"), (0x7B38, "Animation over?"),
        (0x7B3A, "No: draw monster death"),
        (0x7B3C, "Yes: bring it back at a trapdoor"),
        (0x7B3F, "Draw the death frame"),
        (0x7B40, "...keeping the monster number"), (0x7B41, "Its x..."), (0x7B44, "...as cell_x"), (0x7B47, "Its y..."),
        (0x7B4A, "...as cell_y"), (0x7B4D, "The death frame..."), (0x7B50, "...is the sprite"), (0x7B52, "Offsets as when it died..."),
        (0x7B55, "...across"), (0x7B57, "...and down"), (0x7B5A, "...for plot_at_cell"), (0x7B5C, "Plot the death frame in every view"),
        (0x7B5F, "On to the next monster"),
        (0x7CB3, "Next trapdoor, 0-7 in turn"),
        (0x7CB6, "Which trapdoor now?"), (0x7CB9, "Past the eighth?"), (0x7CBB, "No: use it"), (0x7CBD, "Yes: round to trapdoor 0..."),
        (0x7CBF, "...stored"), (0x7CC2, "Y = the trapdoor to emerge from"),
        (0x7CC5, "Put the monster on it, facing up, with no step"),
        (0x7CC8, "...as the monster's x"), (0x7CCB, "The trapdoor's y..."), (0x7CCE, "...as the monster's y"), (0x7CD1, "Facing up..."),
        (0x7CD3, "...as its sprite: alive again"), (0x7CD6, "No step:"), (0x7CD8, "...clear the step count"), (0x7CDB, "...the horizontal offset"),
        (0x7CDE, "...and the vertical offset"),
        (0x7CE1, "Is anything else on the trapdoor? (A hero there is hurt)"),
        (0x7CE2, "...keeping the monster number"), (0x7CE3, "Leave this monster out of the search"), (0x7CE6, "Look for a creature on the trapdoor"), (0x7CE9, "A = 0 if the trapdoor is free"),
        (0x7CEB, "No: done"),
        (0x7CED, "Taken: park it off the map, still alive"),
        (0x7CEE, "...keeping it stacked for monster_done"), (0x7CEF, "...the monster number in X"), (0x7CF0, "Off the map..."), (0x7CF2, "...as its x"),
        (0x7CF5, "...and its y"), (0x7CF8, "On to the next monster"),
        (0x7CFB, "Done"),

        (0x7BEB, "Three frames per step"),
        (0x7BED, "...as the step count"),
        (0x7BF0, "First frame's offsets, in the direction of travel: up..."),
        (0x7BF3, "Facing up?"), (0x7BF5, "No: try right"), (0x7BF7, "Up: no horizontal offset..."), (0x7BF9, "...cleared"),
        (0x7BFC, "...3 rows up"), (0x7BFE, "...as the vertical offset"), (0x7C01, "Return"),
        (0x7C02, "Moving right..."), (0x7C04, "No: try down"), (0x7C06, "Right: no vertical offset..."),
        (0x7C08, "...cleared"), (0x7C0B, "...1 column right"),
        (0x7C0D, "...as the horizontal offset"), (0x7C10, "Return"),
        (0x7C11, "Moving down..."), (0x7C13, "No: it moves left"), (0x7C15, "Down: no horizontal offset..."),
        (0x7C17, "...cleared"), (0x7C1A, "...3 rows down"),
        (0x7C1C, "...as the vertical offset"), (0x7C1F, "Return"),
        (0x7C20, "Left: 1 column left"),
        (0x7C22, "...no vertical offset"), (0x7C25, "-1: one byte column left..."), (0x7C27, "...as the horizontal offset"), (0x7C2A, "Return"),
        (0x7C2B, "Toggle the monster's frame"),
        (0x7C2E, "...between frames 0 and 1..."), (0x7C30, "...so the monster walks"),
        (0x7C33, "Count down the step"),
        (0x7C36, "Not over: grow the offsets"),
        (0x7C38, "Over: move the cell on in its direction, up..."),
        (0x7C3B, "Facing up?"), (0x7C3D, "No: try right"), (0x7C3F, "Yes: one row up"),
        (0x7C42, "...right..."), (0x7C44, "No: try down"), (0x7C46, "Yes: one column right"),
        (0x7C49, "...down..."), (0x7C4B, "No: try left"), (0x7C4D, "Yes: one row down"),
        (0x7C50, "...left"), (0x7C52, "No: no move"), (0x7C54, "Yes: one column left"),
        (0x7C57, "...with no offsets"),
        (0x7C59, "...clear the horizontal offset"), (0x7C5C, "...and the vertical offset"),
        (0x7C5F, "Grow the horizontal offset by a column, away from zero"),
        (0x7C62, "Zero: not moving across"), (0x7C64, "Positive: moving right"), (0x7C66, "Negative: one more column left"), (0x7C69, "Now the vertical offset"),
        (0x7C6C, "Moving right: one more column right"),
        (0x7C6F, "Grow the vertical offset by three rows, away from zero"),
        (0x7C72, "Zero: not moving up or down"), (0x7C74, "Positive: moving down"), (0x7C76, "Moving up: three more rows up..."), (0x7C77, "...from the vertical offset..."),
        (0x7C7A, "...less three..."), (0x7C7C, "...stored"), (0x7C7F, "Done"), (0x7C82, "Moving down: three more rows down..."),
        (0x7C83, "...from the vertical offset..."), (0x7C86, "...plus three..."), (0x7C88, "...stored"),
        (0x7C8B, "Return"),

        (0x7B62, "Step in progress"),
        (0x7B64, "...the step ends at the next frame"),
        (0x7B67, "Facing up: drawn 6 rows up"),
        (0x7B6A, "Facing up?"), (0x7B6C, "No: try right"), (0x7B6E, "Up: no horizontal offset..."), (0x7B70, "...cleared"),
        (0x7B73, "-6: drawn six pixel rows up..."), (0x7B75, "...as the vertical offset"), (0x7B78, "Return"),
        (0x7B79, "Facing right: 2 columns right"),
        (0x7B7B, "No: try down"), (0x7B7D, "Right: no vertical offset..."), (0x7B7F, "...cleared"), (0x7B82, "+2: drawn two byte columns right..."),
        (0x7B84, "...as the horizontal offset"), (0x7B87, "Return"),
        (0x7B88, "Facing down: 6 rows down"),
        (0x7B8A, "No: it faces left"), (0x7B8C, "Down: no horizontal offset..."), (0x7B8E, "...cleared"), (0x7B91, "+6: drawn six pixel rows down..."),
        (0x7B93, "...as the vertical offset"), (0x7B96, "Return"),
        (0x7B97, "Facing left: 2 columns left"),
        (0x7B99, "...no vertical offset"), (0x7B9C, "-2: drawn two byte columns left..."), (0x7B9E, "...as the horizontal offset"), (0x7BA1, "Return"),
        (0x7BA2, "Toggle the hero's frame"),
        (0x7BA5, "...between frames 0 and 1..."), (0x7BA7, "...so the hero walks"),
        (0x7BAA, "Count down the step"),
        (0x7BAD, "Not over"),
        (0x7BAF, "Over: move the cell on in the direction faced, up..."),
        (0x7BB2, "Facing up?"), (0x7BB4, "No: try right"), (0x7BB6, "Yes: one row up"),
        (0x7BB9, "...right..."), (0x7BBB, "No: try down"), (0x7BBD, "Yes: one column right"),
        (0x7BC0, "...down..."), (0x7BC2, "No: try left"), (0x7BC4, "Yes: one row down"),
        (0x7BC7, "...left"), (0x7BC9, "No: no move"), (0x7BCB, "Yes: one column left"),
        (0x7BCE, "...with no offsets"),
        (0x7BD0, "...clear the horizontal offset"), (0x7BD3, "...and the vertical offset"),
        (0x7BD6, "Double the offsets"),
        (0x7BD7, "Horizontal offset..."), (0x7BDA, "...plus itself..."), (0x7BDD, "...doubled"), (0x7BE0, "Ready for the vertical offset"),
        (0x7BE1, "Vertical offset..."), (0x7BE4, "...plus itself..."), (0x7BE7, "...doubled"),
        (0x7BEA, "Return"),

        (0x76DA, "Every other frame..."),
        (0x76DD, "Timer run out: show the next sprite"), (0x76DF, "Not yet: nothing to draw this frame"),
        (0x76E0, "Restart the two-frame timer..."), (0x76E2, "...which an absent hero keeps in hero_offset_y"),
        (0x76E5, "Plot the current appearance sprite at the hero's cell"),
        (0x76E8, "No pixel offsets..."), (0x76EA, "...across..."), (0x76EC, "...or down"), (0x76EE, "The hero's place in the appearance sequence..."),
        (0x76F1, "...as an index..."), (0x76F2, "...picks the sprite to show"), (0x76F5, "...to plot"), (0x76F7, "Keep the hero number..."),
        (0x76F8, "...on the stack"), (0x76F9, "Plot it in every view that shows the hero"), (0x76FC, "Recover the hero number..."), (0x76FD, "...into X"),
        (0x76FE, "Step to the next (+1 dying, -1 returning), stopping at 8"),
        (0x76FF, "Current place in the sequence..."), (0x7702, "...plus the step kept in hero_offset_x"), (0x7705, "Past the skull (place 8)?"), (0x7707, "No: keep the new place"),
        (0x7709, "Yes: stay on the skull"),
        (0x770B, "Reached the first sprite (returning)?"),
        (0x770D, "No: store hero frame"),
        (0x770F, "Yes: in play, facing down..."),
        (0x7711, "...back in play"),
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
        (0x1CC0, "Move the heroes"),
        (0x1CC3, "For each hero..."),
        (0x1CC5, "...look for a door at the cell the hero is moving into"),
        (0x1CC8, "Hero X's x when doors were last checked..."), (0x1CCB, "...is the cell to test"), (0x1CCE, "...and its y..."), (0x1CD1, "...is the cell's y"),
        (0x1CD4, "Keep the hero's number..."), (0x1CD5, "...on the stack for the key check"),
        (0x1CD6, "Doors 20 to 1"),
        (0x1CD8, "This door's x?"), (0x1CDB, "...the cell being tested?"), (0x1CDE, "Yes: check its y"),
        (0x1CE0, "No: next door"),
        (0x1CE3, "...and y?"), (0x1CE6, "...the cell being tested?"), (0x1CE9, "Yes: a door is here"),
        (0x1CEB, "No: next door"),
        (0x1CEE, "Does the hero carry this door's key?"),
        (0x1CEF, "Y = the hero's number..."), (0x1CF0, "...kept on the stack"), (0x1CF1, "A = the door's number"), (0x1CF2, "Is it the number of the key the hero carries?"),
        (0x1CF5, "Yes: open door"),
        (0x1CF7, "No: next door"),
        (0x1CFA, "Open the door: 7 points..."),
        (0x1CFB, "Keep the door's number..."), (0x1CFC, "...and the hero's..."), (0x1CFD, "...on the stack"), (0x1CFE, "Seven points, one per add_point call"),
        (0x1D00, "...given to the hero opening the door"), (0x1D03, "Keep the count of points still to give"), (0x1D04, "...on the stack across add_point"), (0x1D05, "One point to hero X"),
        (0x1D08, "Recover the count of points to give"), (0x1D09, "...back into Y"), (0x1D0A, "One fewer to give"), (0x1D0B, "More to give: add the next point"),
        (0x1D0D, "...play the food sound at a lower pitch..."),
        (0x1D0F, "...pitch 150 instead of food's 200"), (0x1D12, "SOUND food_sound: block address low..."), (0x1D14, "...and high"), (0x1D16, "OSWORD 7: SOUND"),
        (0x1D18, "Play the door-opening sound"),
        (0x1D1B, "...and put its pitch back"),
        (0x1D1D, "...to 200, food's own pitch"),
        (0x1D20, "Keep the door's cell in spare bytes beyond the monster "
                 "tables, as plot_at_cell changes cell_x and cell_y..."),
        (0x1D23, "...y into the spare byte at monster_y + 35..."), (0x1D26, "...then the door's x..."), (0x1D29, "...into the spare byte at monster_x + 35"),
        (0x1D2C, "...erase the door..."),
        (0x1D2E, "...as the sprite to plot"), (0x1D30, "...on the cell itself: no pixel offset..."), (0x1D32, "...horizontally..."), (0x1D34, "...or vertically"),
        (0x1D36, "Plot the blank in every view showing the door"),
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
        (0x1D80, "...clear the bit"), (0x1D82, "...knock out the door's bit..."), (0x1D85, "...so the doorway no longer blocks anyone"),
        (0x1D87, "Recover the door number..."), (0x1D88, "...into X"),
        (0x1D89, "Remove the door..."), (0x1D8B, "...x off the map..."), (0x1D8E, "...and y off the map"),
        (0x1D91, "Recover the hero number..."), (0x1D92, "...into X"),
        (0x1D93, "...and the key, which is used up"), (0x1D95, "...in the hero's key slot"),
        (0x1D98, "Erase the key icon from the panel"),
        (0x1D9A, "...as the sprite to plot"), (0x1D9C, "...using the hero's panel row..."), (0x1D9F, "...set carry to subtract"), (0x1DA0, "...less 13: the key icon's row..."),
        (0x1DA2, "...as plot_y"), (0x1DA4, "...in panel column panel_left + 5..."), (0x1DA6, "...as plot_x"), (0x1DA8, "Keep the hero number..."),
        (0x1DA9, "...on the stack across plot_sprite"), (0x1DAA, "Plot the blank icon over the key icon"), (0x1DAD, "Recover the hero number..."), (0x1DAE, "...into X"),
        (0x1DAF, "Next hero"),
        (0x1DB2, "Next door"), (0x1DB3, "Doors all checked: this hero is done"), (0x1DB5, "Otherwise check the next door"),
        (0x1DB8, "Recover the hero number pushed at check_doors..."), (0x1DB9, "...into X"),
        (0x1DBA, "Next hero"), (0x1DBB, "All four heroes done?"), (0x1DBD, "Yes: on to the keys"), (0x1DBF, "No: check this hero against the doors"),
        (0x1DC2, "Draw the keys on the floor, 20 to 1"),
        (0x1DC4, "...on their cells: no pixel offset..."), (0x1DC6, "...either way"), (0x1DC8, "...in the key sprite..."), (0x1DCA, "...as the sprite to plot"),
        (0x1DCC, "...counting keys down from 20"),
        (0x1DCE, "The key's x..."), (0x1DD1, "...as cell_x..."), (0x1DD4, "...and y (off the map if it is carried)..."), (0x1DD7, "...as cell_y"),
        (0x1DDA, "Keep the key number..."), (0x1DDB, "...on the stack across plot_at_cell"), (0x1DDC, "Plot it in every view showing its cell"), (0x1DDF, "Recover the key number..."),
        (0x1DE0, "...into X"), (0x1DE1, "Next key down"), (0x1DE2, "More keys: draw the next"),
        (0x1DE4, "For each hero..."),
        (0x1DE6, "In play?"),
        (0x1DE9, "Yes: check key swap"),
        (0x1DEB, "Out of play: carrying a key?"),
        (0x1DEE, "Yes: check death finished"),
        (0x1DF0, "No: next hero"),
        (0x1DF3, "Death animation finished?"),
        (0x1DF6, "...frame 8 is the last of the death"), (0x1DF8, "Not yet"),
        (0x1DFA, "Yes: drop the key where the hero fell"),
        (0x1DFD, "...at the hero's x..."), (0x1E00, "...as the key's x..."), (0x1E03, "...and the hero's y..."), (0x1E06, "...as the key's y"),
        (0x1E09, "The dead hero carries no key now..."), (0x1E0B, "...in their key slot"),
        (0x1E0E, "Erase the key icon from the panel"),
        (0x1E25, "Next hero"),
        (0x1E28, "Just swapped keys?"),
        (0x1E2B, "No: check key cell"),
        (0x1E2D, "Yes: not again until the hero moves on"),
        (0x1E2F, "...clearing the hero's swap flag"), (0x1E32, "...and moving on to the next hero"),
        (0x1E35, "Is there a key at the hero's cell?"),
        (0x1E38, "...as cell_x..."), (0x1E3B, "...and the hero's y..."), (0x1E3E, "...as cell_y"), (0x1E41, "Keep the hero number..."),
        (0x1E42, "...on the stack while X counts the keys"), (0x1E43, "...keys 20 to 1"),
        (0x1E45, "This key's x..."), (0x1E48, "...at the hero's x?"), (0x1E4B, "No: try the next key"),
        (0x1E4D, "...and its y..."), (0x1E50, "...at the hero's y?"), (0x1E53, "No: try the next key"),
        (0x1E55, "Yes: erase it from the floor"),
        (0x1E57, "...as the sprite to plot..."), (0x1E59, "...on the cell itself: no pixel offset..."), (0x1E5B, "...horizontally..."), (0x1E5D, "...or vertically"),
        (0x1E5F, "Keep the key number..."), (0x1E60, "...on the stack across plot_at_cell"), (0x1E61, "Plot the blank in every view showing it"), (0x1E64, "Recover the key number..."),
        (0x1E65, "...into X"),
        (0x1E66, "Show the key icon in the hero's panel"),
        (0x1E67, "...into Y..."), (0x1E68, "...and back on the stack for later"), (0x1E69, "...in the key icon sprite..."), (0x1E6B, "...as the sprite to plot"),
        (0x1E6D, "...using the hero's panel row..."), (0x1E70, "...set carry to subtract"), (0x1E71, "...less 13: the key icon's row..."), (0x1E73, "...as plot_y"),
        (0x1E75, "...in panel column panel_left + 5..."), (0x1E77, "...as plot_x"), (0x1E79, "Keep the hero number..."), (0x1E7A, "...on the stack..."),
        (0x1E7B, "...and the key number..."), (0x1E7C, "...across plot_sprite"), (0x1E7D, "Plot the key icon"), (0x1E80, "Recover the key number..."),
        (0x1E81, "...into X..."), (0x1E82, "...and the hero number..."), (0x1E83, "...into Y"),
        (0x1E84, "Drop the key carried (if any) in this cell..."),
        (0x1E85, "...keeping the new key's number on the stack..."), (0x1E86, "...the old key, or entry 0 if none..."), (0x1E89, "...goes to the hero's x..."), (0x1E8C, "...as its x..."),
        (0x1E8F, "...and the hero's y..."), (0x1E92, "...as its y"), (0x1E95, "Recover the new key's number..."), (0x1E96, "...into X, and in A to carry"),
        (0x1E97, "...and carry the new one"),
        (0x1E9A, "Mark the swap"), (0x1E9C, "...so it isn't picked straight back up"),
        (0x1E9F, "Take the new key off the floor"),
        (0x1EA1, "...x off the map..."), (0x1EA4, "...and y off the map"),
        (0x1EA7, "Play the key sound"),
        (0x1EA9, "...ENVELOPE block high byte"), (0x1EAB, "OSWORD 8: define the envelope"), (0x1EAD, "Define the key envelope"), (0x1EB0, "SOUND key_sound: block address low..."),
        (0x1EB2, "...and high"), (0x1EB4, "OSWORD 7: SOUND"), (0x1EB6, "Play the key pickup sound"),
        (0x1EB9, "Recover the hero number..."), (0x1EBA, "...into X"), (0x1EBB, "Next hero"),
        (0x1EBE, "Next key"), (0x1EBF, "Keys all checked: this hero is done"), (0x1EC1, "Otherwise check the next key"),
        (0x1EC4, "Recover the hero number pushed above..."), (0x1EC5, "...into X"),
        (0x1EC6, "Next hero"), (0x1EC7, "All four heroes done?"), (0x1EC9, "Yes: on with the rest of the frame"), (0x1ECB, "No: check this hero's keys"),
        (0x1ECE, "Draw the objects"),
        (0x1ED1, "Move the missiles"),
        (0x1ED4, "Move the monsters"),
    ]:
        a.c(addr, text)


def annotate_cassette_pause(a: Annotator) -> None:
    """The pause key in the crack and the hack: f1 (internal key &71)."""
    for addr, text in [
        (0x1ED7, "OSBYTE &7A: which key is pressed?"),
        (0x1ED9, "Scan: X = the internal number of a key held"),
        (0x1EDC, "f1 (internal key &71)?"),
        (0x1EDE, "No: return"),
        (0x1EE0, "Paused: wait for f1 to be released..."),
        (0x1EE3, "...is f1 still held?"), (0x1EE5, "Yes: keep waiting for its release"),
        (0x1EE7, "...pressed again..."),
        (0x1EEA, "...is it f1?"), (0x1EEC, "No: keep waiting for f1"),
        (0x1EEE, "...and released"),
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
    for addr, text in [
        (0x0500, "VDU 28: a text window over the left of the screen..."),
        (0x0502, "Send VDU 28"), (0x0505, "Left column 0"), (0x0507, "Send the left column"), (0x050A, "Bottom row 24"),
        (0x050C, "Send the bottom row"), (0x050F, "Right column 19"), (0x0511, "Send the right column"), (0x0514, "Top row 0"),
        (0x0516, "Send the top row"),
        (0x0519, "...VDU 12 to clear it"),
        (0x051B, "Send VDU 12: clear the window"),
        (0x051E, "Print the menu"),
        (0x0521, "Read the players' choices"),
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
        (0x0583, "Discard keys pressed before the menu"),
        (0x0586, "OSBYTE &CA: keyboard status &20, CAPS LOCK on and SHIFT "
                 "LOCK off"),
        (0x0588, "X = &20: CAPS LOCK on, SHIFT LOCK off"), (0x058A, "Y = 0: replace the status with X"), (0x058C, "Set it: CAPS LOCK on, so the menu reads capitals"),
        (0x058F, "Wait for a key"),
        (0x0592, "SPACE?"), (0x0594, "Yes: start, if anyone is playing"),
        (0x0596, "Ignore anything but 1-6"),
        (0x0598, "Below '1': ignore it"), (0x059A, "Above '6'?"), (0x059C, "Yes: ignore it"),
        (0x059E, "X = 0-5"), (0x059F, "Key '1'-'6' becomes 0-5..."), (0x05A1, "...in X"),
        (0x05A2, "5 or 6: the sound"), (0x05A4, "Yes: the sound switch"),
        (0x05A6, "1-4: Y = offset of the hero's YES/NO, 6 x X + &51..."),
        (0x05A7, "Keep 2 x the hero number"), (0x05A9, "4 x the hero number..."), (0x05AA, "...(carry clear for the add)"), (0x05AB, "...+ 2 x: 6 x the hero number"),
        (0x05AD, "...+ &51: this hero's YES/NO text"), (0x05AF, "Y = its offset in menu_text"),
        (0x05B0, "Toggle the hero"),
        (0x05B3, "...by flipping the absent flag"), (0x05B5, "...stored back"),
        (0x05B8, "Now absent?"),
        (0x05BA, "No: YES"),
        (0x05BD, "...then reprint"),
        (0x05C0, "Yes: NO"),
        (0x05C3, "Reprint the menu"),
        (0x05C6, "Next key"),
        (0x05C9, "SPACE: is any hero playing?"),
        (0x05CB, "This hero switched off?"), (0x05CE, "Yes: return and start"),
        (0x05D0, "Yes: try the previous hero"), (0x05D1, "Heroes left to check: loop"),
        (0x05D3, "No: next key"),
        (0x05D6, "Return"),
        (0x05D7, "Sound: Y = offset of the second letter of ON/OFF"),
        (0x05D9, "Key 6 (A = key - \"1\")?"), (0x05DB, "Yes: menu sound off"),
        (0x05DD, "Key 5: ON..."),
        (0x05E0, "...with X = 0 to enable the sound"),
        (0x05E2, "Always: set the sound"),
        (0x05E4, "Key 6: OFF..."),
        (0x05E7, "...with X = 1 to suppress it"),
        (0x05E9, "OSBYTE &D2: sound suppression"),
        (0x05EB, "Y = 0: replace the setting with X"), (0x05ED, "Turn the sound on or off as chosen"),
        (0x05F0, "Reprint the menu"),
        (0x05F3, "Next key"),

        (0x06B0, "For each hero, keeping a count of absent heroes in Y..."),
        (0x06B2, "...in Y, which also indexes the queue"),
        (0x06B4, "Score of 10000 or more?"),
        (0x06B7, "...digit sprite at least that for 1?"), (0x06B9, "No: remove absent heroes check"),
        (0x06BB, "Yes: draw the ten-thousands digit"),
        (0x06BC, "Keep the hero number..."), (0x06BD, "...and the absent count..."), (0x06BE, "...on the stack"), (0x06BF, "The digit's sprite..."),
        (0x06C2, "...drawn below the score"), (0x06C5, "Recover the absent count..."), (0x06C6, "...into Y"), (0x06C7, "Recover the hero number..."),
        (0x06C8, "...into X"),
        (0x06C9, "Switched off on the menu?"),
        (0x06CC, "No: remove absent heroes next"),
        (0x06CE, "Yes: out of play..."), (0x06D0, "...direction 0: not in play"),
        (0x06D3, "...never to be animated (step &63)..."), (0x06D5, "...as the hero's step count"),
        (0x06D8, "...frame 8..."), (0x06DA, "...as the hero's frame"),
        (0x06DD, "...dead..."), (0x06DF, "...as the health tens digit"),
        (0x06E2, "...score units digit back one..."),
        (0x06E5, "...at x &1F..."), (0x06E7, "...as the hero's map x"),
        (0x06EA, "...and a &64 marker in the returning queue"),
        (0x06EC, "...in the next queue entry"), (0x06EF, "One more absent hero"),
        (0x06F0, "Next hero"), (0x06F1, "All four heroes done?"), (0x06F3, "No: next hero"),
        (0x06F5, "Return"),

        (0x0400, "Add one to the thousands digit"),
        (0x0403, "...and check the new digit"), (0x0406, "Past 9?"), (0x0408, "No: return"),
        (0x040A, "Yes: thousands 0..."), (0x040C, "...stored for this hero"),
        (0x040F, "...and add one to the ten-thousands digit"),
        (0x0412, "...and check the new digit"), (0x0415, "Past 9?"), (0x0417, "No: draw ten thousands"),
        (0x0419, "Yes: keep it at 9"), (0x041B, "...stored for this hero"),
        (0x041E, "Plot it below the score..."),
        (0x0420, "...at the panel's left column"), (0x0422, "...as the plot column"), (0x0424, "...this hero's panel row, from the template"), (0x0427, "...(carry clear for the add)"),
        (0x0428, "...+ &18 rows: below the score"), (0x042A, "...as the plot row"), (0x042C, "Keep the hero number..."), (0x042D, "...on the stack while plotting"),
        (0x042E, "Plot the ten-thousands digit"),
        (0x0431, "...with four of sprite &71 beside it"),
        (0x0433, "...as the sprite to plot"), (0x0435, "...four times"), (0x0437, "Keep the count..."), (0x0438, "...on the stack while plotting"),
        (0x0439, "Two byte columns right..."), (0x043B, "...(second step)"), (0x043D, "Plot sprite &71 there"), (0x0440, "Recover the count..."),
        (0x0441, "...into Y"), (0x0442, "One fewer to plot"), (0x0443, "More to plot: loop"), (0x0445, "Recover the hero number..."),
        (0x0446, "...into X"),
        (0x0447, "Return"),

        (0x75AE, "Armour rating: 10 - health lost per hit, as a small digit "
                 "on the shield..."),
        (0x75AF, "...on the shield, twelve rows above the panel row..."), (0x75B2, "...minus twelve rows..."), (0x75B4, "...as the plotting row"), (0x75B6, "...nine columns right of the panel's left..."),
        (0x75B8, "...as the plotting column"), (0x75BA, "...as the small digit 10 minus..."), (0x75BC, "...set the carry for the subtraction..."), (0x75BD, "...the health lost per hit"),
        (0x75C0, "...as the sprite to plot"),
        (0x75C2, "...plotted"),
        (0x75C5, "The newest missile icon: row = 3 x missiles allowed..."),
        (0x75C8, "...x 2..."), (0x75C9, "...clear the carry for the addition..."), (0x75CA, "...+ itself: x 3..."), (0x75CD, "...+ &0D..."),
        (0x75CF, "...+ the hero's panel row..."), (0x75D2, "...set the carry for the subtraction..."), (0x75D3, "...- &0E: the row draw_status_panel gives the last icon"), (0x75D5, "...as the plotting row"),
        (0x75D7, "...column &4B..."), (0x75D9, "...as the plotting column"),
        (0x75DB, "...missile icon..."), (0x75DD, "...as the sprite to plot"),
        (0x75DF, "...plotted"),
        (0x75E2, "Missile damage: column &4C..."), (0x75E4, "...as the plotting column"),
        (0x75E6, "...four rows above the panel row..."), (0x75E7, "...the hero's panel row..."), (0x75EA, "...minus four rows..."), (0x75EC, "...as the plotting row"),
        (0x75EE, "...as a small digit..."), (0x75F1, "...clear the carry for the addition..."), (0x75F2, "...one before small digit 1, plus the damage"),
        (0x75F4, "...as the sprite to plot"),
        (0x75F6, "...plotted"),
        (0x75F9, "Column &4A..."), (0x75FB, "...as the plotting column"),
        (0x75FD, "...row 8 above the section's top"),
        (0x75FE, "...the hero's panel row..."), (0x7601, "...8 rows above the hero's panel section"), (0x7603, "...as the icon's pixel row"),
        (0x7605, "Return"),
        (0x7606, "Lightning bolt..."), (0x7608, "...as the sprite to plot"),
        (0x760A, "...plotted"),
        (0x760D, "Blank..."), (0x760F, "...as the sprite to plot"),
        (0x7611, "Plot, preserving X"),
        (0x7612, "Keep the hero number across the plot"), (0x7613, "Plot the icon on the status panel"), (0x7616, "Recover the hero number..."), (0x7617, "...into X"),
        (0x7618, "Return"),
    ]:
        a.c(addr, text)


def annotate_victory_and_helpers(a: Annotator) -> None:
    a.label(0x10E6, "reset_call")
    a.expr(0x10E7, hexlit(0x0000))
    for addr, name, description in [
        (0x0080, "ring_x", "Map x of the cell being drawn in the victory ring."),
        (0x0081, "ring_y", "Map y of the cell being drawn in the victory ring."),
        (0x0082, "victory_sprite", "Sprite drawn in the victory ring."),
        (0x0084, "victory_delay", "Delay between frames of the victory sequence."),
        (0x008D, "victory_pitch_step", "Amount the victory tone rises each frame."),
        (0x008E, "victory_steps_left", "Rises left in the victory tone."),
        (0x008F, "victory_pitch", "Pitch of the victory tone."),
    ]:
        a.label(addr, name, group="zero_page", access="rw", description=description)
    for addr, text in [
        (0x1070, "Only on level 25"),
        (0x1073, "The Chalice lies only on level 25"), (0x1075, "Another level: no Chalice to find"),
        (0x1077, "Is a hero on one of the Chalice's cells, x &1A or &1B..."),
        (0x1079, "Hero X's position from the last door check..."), (0x107C, "...in the Chalice's left column?"), (0x107E, "Yes: check the row"), (0x1080, "...or its right column?"),
        (0x1082, "Yes: check the row"),
        (0x1084, "Next hero"), (0x1085, "Past hero 3?"), (0x1087, "No: check the next hero"),
        (0x1089, "Return"),
        (0x108A, "...and y 4 or 5?"),
        (0x108D, "...in the Chalice's top row?"), (0x108F, "Yes: the Chalice is found"), (0x1091, "...or its bottom row?"), (0x1093, "Yes: the Chalice is found"),
        (0x1095, "No: next hero"),
        (0x1097, "Yes: play the victory sequence"),
        (0x109A, "VDU 28,0,24,16,0: a text window on the left..."),
        (0x10B3, "...VDU 12 to clear it"),
        (0x10B8, "Print 140 bytes from room_walls + &3A..."),
        (0x10BA, "Next byte of level 25's wall map, which is text"), (0x10BD, "Print it"), (0x10C0, "Next byte"), (0x10C1, "All 140 printed?"),
        (0x10C3, "No: print the next"),
        (0x10C5, "...then the string at object_free_map + &3A: on level 25, "
                 "the ending message"),
        (0x10C7, "Next character of the ending message"), (0x10CA, "Print it"), (0x10CD, "Next character"), (0x10CE, "The zero that ends the message?"),
        (0x10D0, "No: print the next"),
        (0x10D2, "Flush the input buffers"),
        (0x10D4, "Discard keys pressed during the victory"),
        (0x10D7, "Wait for a key"),
        (0x10DA, "Copy the RESET vector into the JSR below..."),
        (0x10DD, "...low byte"), (0x10E0, "...high byte..."), (0x10E3, "...into the JSR's operand"),
        (0x10E6, "...and call it: reset the machine"),
        (0x10E9, "OSBYTE &D4: the bell's envelope..."),
        (0x10EB, "...8"), (0x10ED, "Set the bell's envelope for the victory tone"),
        (0x10F0, "No pixel offsets"),
        (0x10F2, "...across..."), (0x10F4, "...or down, so sprites sit square in their cells"),
        (0x10F6, "The ring starts with the first sparkle"),
        (0x10F8, "...as the ring's sprite"),
        (0x10FA, "Tone starts at pitch 0..."), (0x10FC, "...for the bell"),
        (0x10FE, "...with the frames &E6 units apart..."), (0x1100, "...the delay loop's outer count"),
        (0x1102, "...for &32 rises..."), (0x1104, "...pitch rises before the sequence ends"),
        (0x1106, "...each by 1 to begin with"), (0x1108, "...the pitch's first step"),
        (0x110A, "Raise the pitch"),
        (0x110B, "...current pitch..."), (0x110D, "...plus the step..."), (0x110F, "...becomes the new pitch"),
        (0x1111, "No carry: carry on"),
        (0x1113, "Carry: rise faster..."),
        (0x1115, "...and count a rise"),
        (0x1117, "More to come"),
        (0x1119, "Done: finish"),
        (0x111C, "Shorten the delay..."), (0x111E, "Not yet zero: keep it"),
        (0x1120, "...to at least 1"), (0x1122, "...so the frames never stop entirely"),
        (0x1124, "OSBYTE &D5: the bell's pitch..."),
        (0x1126, "...set it from victory_pitch"), (0x1128, "Set it: the bell now sounds at that pitch"),
        (0x112B, "...and sound the bell"), (0x112D, "Send BEL: the bell sounds at the new pitch"),
        (0x1130, "Draw the ring"),
        (0x1133, "At full speed, dissolve the Chalice a byte at a time"),
        (0x1135, "Delay down to 1: the sequence is at full speed"), (0x1137, "Not yet: just wait"), (0x1139, "Full speed: clear one more byte of the Chalice"),
        (0x113C, "Wait for the delay"),
        (0x113E, "Each delay unit is 255 inner loops"), (0x1140, "Count down the inner loop"), (0x1141, "Until it reaches zero"), (0x1143, "Count down the delay units"),
        (0x1144, "Until the delay is spent"),
        (0x1146, "Next frame"),
        (0x1149, "Start at x &1C, y 3: the ring runs round the Chalice's "
                 "four cells"),
        (0x114B, "...as the ring's x..."), (0x114D, "...one row above the Chalice..."), (0x114F, "...as the ring's y"),
        (0x1151, "Plot the first cell of the ring"), (0x1154, "Left..."), (0x1156, "Plot the next cell along the top"),
        (0x1159, "Left..."), (0x115B, "Plot the next cell along the top"),
        (0x115E, "Keep the sprite..."), (0x1160, "...in victory_sprite_copy"),
        (0x1163, "...and change it"),
        (0x1166, "Left..."), (0x1168, "Plot the top-left corner"),
        (0x116B, "Down..."), (0x116D, "Plot down the left side"),
        (0x1170, "Down..."), (0x1172, "Plot down the left side"),
        (0x1175, "Change sprite"),
        (0x1178, "Down..."), (0x117A, "Plot the bottom-left corner"),
        (0x117D, "Right..."), (0x117F, "Plot along the bottom"),
        (0x1182, "Right..."), (0x1184, "Plot along the bottom"),
        (0x1187, "Change sprite"),
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
        (0x11BE, "Pick a byte of the Chalice at random..."),
        (0x11C1, "...mixed with the MOS's last interrupt A..."), (0x11C3, "...and more MOS workspace, for randomness"),
        (0x11C5, "...if it is within the sprite"),
        (0x11C7, "Outside the Chalice's &C0 bytes: leave it"),
        (0x11C9, "Clear it..."), (0x11CA, "...to zero, a black pair of pixels..."), (0x11CC, "...in the Chalice's sprite data"),
        (0x11CF, "...and redraw the Chalice"),
        (0x11D2, "Return"),
        (0x11D3, "Erase the ring"),
        (0x11D5, "...by making the blank the ring's sprite..."), (0x11D7, "...and drawing the ring with it"),
        (0x11DA, "Clear the whole Chalice sprite..."),
        (0x11DC, "...to zeros"), (0x11DE, "Clear a byte of the Chalice's sprite data"), (0x11E1, "Next byte down"), (0x11E2, "Until all &C1 bytes are clear"),
        (0x11E4, "...and redraw it, now blank"),
        (0x11E7, "Wait 255 vertical syncs (about five seconds)"),
        (0x11E9, "...which the MOS counts down at each vsync"), (0x11EC, "Read the count"), (0x11EF, "Until it reaches zero"),
        (0x11F1, "Return"),
        (0x11F2, "The Chalice's top-left cell, x &1A, y 4..."),
        (0x11F4, "...as the cell's x"), (0x11F7, "...and y 4..."), (0x11F9, "...as the cell's y"),
        (0x11FC, "...sprite &73..."), (0x11FE, "...as the sprite to plot..."),
        (0x1200, "...plotted in every view showing it"),
        (0x1203, "Return"),

        (0x2050, "The hero's sprites base + 1 to base + 7"),
        (0x2051, "...the hero's sprite base..."), (0x2054, "...+1: their first sprite..."), (0x2056, "...in X, for the height loop..."), (0x2057, "...and in Y, for the width loop"),
        (0x2058, "...+7: stop before base + 8, left frame 1"), (0x205A, "...kept as the end"),
        (0x205D, "Widths back to 4..."),
        (0x205F, "Full width"), (0x2062, "Next sprite"), (0x2063, "Reached the end?"), (0x2066, "No: widen the next"),
        (0x2068, "...from the first sprite again"), (0x2069, "...into Y"),
        (0x206A, "...heights back to 12"),
        (0x206C, "Full height"), (0x206F, "Next sprite"), (0x2070, "Reached the end?"), (0x2073, "No: restore the next"),
        (0x2075, "Return"),
        (0x2091, "From the hero's cell..."),
        (0x2094, "...as cell_x..."), (0x2097, "...and the hero's y..."), (0x209A, "...as cell_y"),
        (0x209D, "...find a free cell next to it"),
        (0x209E, "Keep the hero number..."), (0x209F, "...on the stack across the search"), (0x20A2, "Recover the hero number..."), (0x20A3, "...into X"),
        (0x20A4, "Put the hero's key there"),
        (0x20A7, "...the free cell's x..."), (0x20AA, "...as the key's x..."), (0x20AD, "...and its y..."), (0x20B0, "...as the key's y"),
        (0x20B3, "The hero carries no key"),
        (0x20B5, "...in the hero's key slot"),
        (0x20B8, "Erase the key icon from the panel"),
        (0x20BA, "...as the sprite to plot"), (0x20BC, "...using the hero's panel row..."), (0x20BF, "...set carry to subtract"), (0x20C0, "...less 13: the key icon's row..."),
        (0x20C2, "...as plot_y"), (0x20C4, "...in panel column panel_left + 5..."), (0x20C6, "...as plot_x"), (0x20C8, "Keep the hero number..."),
        (0x20C9, "...on the stack across plot_sprite"), (0x20CA, "Plot the blank icon over the key icon"), (0x20CD, "Recover the hero number..."), (0x20CE, "...into X"),
        (0x20CF, "Return"),
        (0x20D0, "The cell above"),
        (0x20D3, "...free?"), (0x20D6, "Y = 0 if no wall there"), (0x20D8, "No: try cell right"),
        (0x20DA, "Yes: return"),
        (0x20DB, "The cell to the right"),
        (0x20DE, "...x + 1 (y back to the hero's row)"), (0x20E1, "...free?"), (0x20E4, "Y = 0 if no wall there"),
        (0x20E6, "No: try cell below"), (0x20E8, "Yes: return"),
        (0x20E9, "The cell below"),
        (0x20EC, "...y + 1 (x back to the hero's column)"), (0x20EF, "...free?"), (0x20F2, "Y = 0 if no wall there"),
        (0x20F4, "No: try cell left"), (0x20F6, "Yes: return"),
        (0x20F7, "Otherwise the cell to the left"),
        (0x20FA, "...x - 1: unchecked, the last resort"), (0x20FD, "Return"),

        (0x7305, "No pixel offsets"),
        (0x7307, "...across the cell horizontally..."), (0x7309, "...and vertically: objects sit squarely in their cells"),
        (0x730B, "Objects 30 to 1: plot each at its cell"),
        (0x730D, "This object's map x..."), (0x7310, "...is the cell to plot at..."), (0x7313, "...and its map y..."), (0x7316, "...the cell's row"),
        (0x7319, "Its type is the sprite to plot"), (0x731C, "...as the sprite to plot"), (0x731E, "Keep the object number..."), (0x731F, "...across the plot"),
        (0x7320, "Plot it in every view showing its cell"), (0x7323, "Recover the object number..."), (0x7324, "...into X"), (0x7325, "Next object down"),
        (0x7326, "Until object 1 is drawn (object 0 is unused)"), (0x7328, "Return"),

        (0x7A94, "Stay in the old cell..."),
        (0x7A95, "Its old x..."), (0x7A98, "...back in monster_x"), (0x7A9B, "Its old y..."), (0x7A9E, "...back in monster_y"),
        (0x7AA1, "...with no step..."),
        (0x7AA3, "Clear the step count"), (0x7AA6, "...the horizontal offset"), (0x7AA9, "...and the vertical offset"),
        (0x7AAC, "...and turn a random way: 8 + (timer AND 7), made odd"),
        (0x7AAF, "A random 0-7..."), (0x7AB1, "...plus 8..."), (0x7AB2, "...gives a sprite &08-&0F"), (0x7AB4, "Face the monster that way"),
        (0x7AB7, "Even?"), (0x7AB9, "Odd: a facing sprite, so draw it"), (0x7ABB, "Even: up to the odd sprite after it"), (0x7ABE, "Draw it"),
    ]:
        a.c(addr, text)


def annotate_shared_continuations(a: Annotator) -> None:
    for addr, text in [
        (0x0D35, "Y = 0: replace the setting with X"),
        (0x0D3E, "Y = 0: replace the setting with X"),
        (0x0D47, "Y = 0: replace the setting with X"),
        (0x0D50, "Y = 0: replace the setting with X"),
        (0x0E08, 'Give each hero their starting attributes'),
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
        (0x0E95, "Right column 16"),
        (0x0E97, "Send the right column"),
        (0x0E9A, "Top row 0"),
        (0x0E9C, "Send the top row"),
        (0x0EA1, "Send VDU 12: clear the window"),
        (0x109C, "Send VDU 28"),
        (0x109F, "Left column 0"),
        (0x10A1, "Send it"),
        (0x10A4, "Bottom row 24"),
        (0x10A6, "Send it"),
        (0x10A9, "Right column 16"),
        (0x10AB, "Send it"),
        (0x10AE, "Top row 0"),
        (0x10B0, "Send it"),
        (0x10B5, "Clear the window for the ending text"),
        (0x1419, "Send it"),
        (0x141E, "Send it"),
        (0x1423, "Send it: show all 25 rows for play"),
        (0x1428, "Send the first zero"),
        (0x142B, "Send the second zero"),
        (0x142E, "Send the third zero"),
        (0x1431, "Send the fourth zero"),
        (0x1434, "Send the fifth zero"),
        (0x1437, "Send the sixth zero"),
        (0x143C, "...as the frame commands' pointer, low byte..."),
        (0x1440, "...in plot_y"),
        (0x14AD, "No hero is going down the exit"),
        (0x14B0, "Exit animation x offset 3 starts at 0..."),
        (0x14B3, "...as does y offset 0..."),
        (0x14B6, "...and y offset 4"),
        (0x14BC, 'Offsets for the exit animation, and no hero shrunk'),
        (0x14BE, "...as x offset 1..."),
        (0x14C1, "...x offset 2..."),
        (0x14C4, "...and y offset 3"),
        (0x14C7, "&FF: no hero is shrunk"),
        (0x14C9, "...as shrunk_hero"),
        (0x14CC, "Exit animation offset of 5..."),
        (0x14CE, "...for y offset 1"),
        (0x14D1, "Offset of 3..."),
        (0x14D3, "...for y offset 2"),
        (0x1512, "Object's x in the level file..."),
        (0x1515, "...becomes its map x"),
        (0x1518, "Its y..."),
        (0x151B, "...becomes its map y"),
        (0x151E, "Its type..."),
        (0x1521, "...becomes its sprite"),
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
        (0x1567, "...into room_walls"),
        (0x156A, "Byte of the level's object-free map..."),
        (0x156D, "...into object_free_map"),
        (0x1577, "Byte of the level's wall block..."),
        (0x157A, "...becomes sprite 0, the wall"),
        (0x159A, "Zero for every entry cleared"),
        (0x159C, "Empty the returning-hero queue"),
        (0x159F, "Hero X carries no key"),
        (0x15A2, "...and has swapped none"),
        (0x15A5, "No door-check position..."),
        (0x15A8, "...in x or y"),
        (0x161A, 'VDU 28: a text window over the whole of the left of the screen...'),
        (0x161C, "Send VDU 28"),
        (0x161F, "Left column 0"),
        (0x1621, "Send it"),
        (0x1624, "Bottom row 24"),
        (0x1626, "Send it"),
        (0x1629, "Right column 19"),
        (0x162B, "Send it"),
        (0x162E, "Top row 0"),
        (0x1630, "Send it"),
        (0x1633, '...VDU 12 to clear it'),
        (0x1635, "Send it"),
        (0x1638, 'Return'),
        (0x16A0, 'Define the exit envelope...'),
        (0x16A2, "...high byte"),
        (0x16A4, "...OSWORD 8..."),
        (0x16A9, '...and play the exit sound'),
        (0x16AB, "...high byte"),
        (0x16AD, "...OSWORD 7..."),
        (0x16B2, 'Find the end of returning_hero_queue...'),
        (0x16B4, "Entry X of the queue"),
        (0x16B7, "In use: try the next"),
        (0x16B9, '...and add a &64 marker there'),
        (0x16BB, "...in the first empty entry"),
        (0x16BE, 'Return'),
        (0x16BF, 'Next entry'),
        (0x16C0, "X not wrapped: check the next entry"),
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
        (0x2009, "One byte narrower"),
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
        (0x6FE8, "...x back to the old cell..."),
        (0x6FEB, "And the old y..."),
        (0x6FEE, "...so the hero stays out of the monster's cell"),
        (0x6FF1, "No step under way..."),
        (0x6FF3, "...clear the step..."),
        (0x6FF6, "...the horizontal offset..."),
        (0x6FF9, "...and the vertical offset"),
        (0x7024, "...x back to the old cell..."),
        (0x7027, "And the old y..."),
        (0x702A, "...so heroes never share a cell"),
        (0x702D, "No step under way..."),
        (0x702F, "...clear the step..."),
        (0x7032, "...the horizontal offset..."),
        (0x7035, "...and the vertical offset"),
        (0x7038, "...and redraw the hero"),
        (0x72BD, "Row: the hero's panel section..."),
        (0x72C0, "...twelve rows down, below the health"),
        (0x72C2, "...as the plotting row"),
        (0x72C4, "Thousands digit in the panel's left column"),
        (0x72C6, "...as the plotting column"),
        (0x72C8, "...as a digit sprite"),
        (0x72CB, "...as the sprite to plot"),
        (0x72CD, "Keep the hero number..."),
        (0x72CE, "...across the plot"),
        (0x72CF, "Plot the thousands digit"),
        (0x72D2, "Recover the hero number..."),
        (0x72D3, "...into X"),
        (0x72D7, "...as the sprite to plot"),
        (0x72D9, "...three columns right..."),
        (0x72DB, "...as the plotting column"),
        (0x72DD, "Keep the hero number..."),
        (0x72DE, "...across the plot"),
        (0x72DF, "Plot the hundreds digit"),
        (0x72E2, "Recover the hero number..."),
        (0x72E3, "...into X"),
        (0x72E7, "...as the sprite to plot"),
        (0x72E9, "...six columns right..."),
        (0x72EB, "...as the plotting column"),
        (0x72ED, "Keep the hero number..."),
        (0x72EE, "...across the plot"),
        (0x72EF, "Plot the tens digit"),
        (0x72F2, "Recover the hero number..."),
        (0x72F3, "...into X"),
        (0x72F7, "...as the sprite to plot"),
        (0x72F9, "...nine columns right"),
        (0x72FB, "...as the plotting column"),
        (0x72FD, "Keep the hero number..."),
        (0x72FE, "...across the plot"),
        (0x72FF, "Plot the units digit"),
        (0x7302, "Recover the hero number..."),
        (0x7303, "...into X"),
        (0x7364, "Keep the hero..."),
        (0x7365, "...and the object..."),
        (0x7366, "...across the OSWORD calls"),
        (0x7367, "Define the treasure envelope..."),
        (0x7369, "...high byte..."),
        (0x736B, "...OSWORD 8, ENVELOPE"),
        (0x7370, "...then sound it"),
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
        (0x752F, "...as the cell to test..."),
        (0x7532, "...and its map y..."),
        (0x7535, "...as the cell to test"),
        (0x7538, "Keep the hero..."),
        (0x7539, "...across test_wall"),
        (0x753A, "...which finds the cell's room"),
        (0x753D, "Recover the hero..."),
        (0x753E, "...into X"),
        (0x7549, 'Top-left view?'),
        (0x754B, 'Yes: draw it'),
        (0x754E, "Recover the hero..."),
        (0x754F, "...into X"),
        (0x7550, 'Return'),
        (0x7551, 'Top-right view?'),
        (0x7553, "No: next view"),
        (0x7555, 'Yes: draw it'),
        (0x7558, "Recover the hero..."),
        (0x7559, "...into X"),
        (0x755A, 'Return'),
        (0x755B, 'Bottom-left view?'),
        (0x755D, "No: it is the bottom-right view"),
        (0x755F, 'Yes: draw it'),
        (0x7562, "Recover the hero..."),
        (0x7563, "...into X"),
        (0x7564, 'Return'),
        (0x7565, 'Otherwise the bottom-right view'),
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
        (0x762D, "Keep the hero number while the sound plays"),
        (0x762E, "XY = magic_envelope..."),
        (0x7630, "...its high byte"),
        (0x7632, "OSWORD 8: define the magic envelope"),
        (0x7637, "XY = magic_sound..."),
        (0x7639, "...its high byte"),
        (0x763B, "OSWORD 7: make the magic sound"),
        (0x7640, "Recover the hero number..."),
        (0x7641, "...into X"),
        (0x764D, "Ranger: go and take 6 points"),
        (0x7788, 'Top-left view'),
        (0x778B, 'Top-right view'),
        (0x778E, 'Bottom-left view'),
        (0x7791, 'Bottom-right view'),
        (0x7794, 'Return'),
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
        (0x15B6, "Send VDU 17"),
        (0x15BB, "Send it"),
        (0x15C3, "...at screen column 27..."),
        (0x15C7, "...as plot_y"),
        (0x15CB, "...as the sprite to plot"),
        (0x15D2, "Send VDU 31"),
        (0x15D7, "Send it"),
        (0x15DC, "Send it"),
        (0x15E4, "...down..."),
        (0x15E5, "...to the..."),
        (0x15E6, "...low nibble"),
        (0x15E7, "Clear the carry for the add"),
        (0x15F0, "Clear the carry for the add"),
        (0x15F8, "Send VDU 28"),
        (0x15FB, "Left column 1"),
        (0x15FD, "Send it"),
        (0x1600, "Bottom row 22"),
        (0x1602, "Send it"),
        (0x1607, "Send it"),
        (0x160C, "...send the window's top row"),
        (0x160F, "COLOUR 2: text in colour 2 from now on..."),
        (0x1611, "...send VDU 17 (COLOUR)"),
        (0x1616, "...send it"),
        (0x1EF5, 'Return'),
    ]:
        a.c(addr, text)




def annotate_hack_continuations(a: Annotator) -> None:
    for addr, text in [
        (0x0E00, 'New game: level 0...'),
        (0x0E02, "...as level_number..."),
        (0x0E05, "...and as the BCD level count"),
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
        0x73A7: "redraw_health_loop",
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
        0x769C: "check_kills",
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
        0x79AA: "check_hero_loop",
        0x79B7: "next_hero_find",
        0x79BC: "nothing_found",
        0x79CD: "check_trapdoor",
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
