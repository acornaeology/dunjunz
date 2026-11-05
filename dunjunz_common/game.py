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
