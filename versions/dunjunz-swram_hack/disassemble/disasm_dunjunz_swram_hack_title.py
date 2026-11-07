"""dasmos driver for `TITLE` (&3800, exec &38C6), the sideways RAM hack's
title page.

The BASIC program `DUNJUNZ` runs it with `*/TITLE` after the intro. It
selects MODE 5, stripes the screen, copies the Bug-Byte logo picture it
carries into character rows 1-8, prints the credits and the keys, and waits
up to 7.67 seconds for a key before returning to BASIC, which chains `DUNK`.
"""

import os
from pathlib import Path

import dasmos
from dasmos.expr import hexlit, hi, lo, sym

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-swram_hack-title.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-swram_hack-title.json"))

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "TITLE", 0x3800, name="TITLE", exec_addr=0x38C6)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")

INLINE = dasmos.Align.INLINE


def comments(pairs):
    for addr, text in pairs:
        d.comment(addr, text, align=INLINE)


def operand(addr, expression):
    d.expr(addr, expression)


# ---------------------------------------------------------------------------
# Workspace and screen addresses outside the file.

d.label(0x70, "copy_from", group="zero_page")
d.label(0x71, "copy_from_high", group="zero_page")
d.label(0x80, "copy_to", group="zero_page")
d.label(0x81, "copy_to_high", group="zero_page")
d.label(0x5800, "mode5_screen", group="screen",
        description="The start of MODE 5's screen memory (&5800-&7FFF)")
d.label(0x5940, "title_picture_screen", group="screen",
        description="Character row 1 of the MODE 5 screen, where the logo "
                    "picture is copied (&5940-&633F)")

# ---------------------------------------------------------------------------
# Data at the start of the file.

d.label(0x3800, "stripe_pattern")
d.banner(0x3800, title="Background stripe pattern",
         description="One MODE 5 character cell, copied over the whole "
                     "screen: even pixel rows black (&00), odd rows four "
                     "pixels of colour 2 (&F0), which mode_vdu makes blue.")
d.byte(0x3800, 8)
d.comment(0x3800, "Rows 0-7 of the cell, black and colour 2 alternately", align=INLINE)

d.label(0x3808, "mode_vdu")
d.banner(0x3808, title="VDU codes: MODE 5, colour 2 blue",
         description="Eight bytes sent by title_start before anything is "
                     "drawn: VDU 22,5 (MODE 5) and VDU 19,2,4,0,0,0 (logical "
                     "colour 2 shows as blue).")
d.byte(0x3808, 2)
d.comment(0x3808, "VDU 22,5: MODE 5", align=INLINE)
d.byte(0x380A, 6)
d.comment(0x380A, "VDU 19,2,4,0,0,0: logical colour 2 is blue", align=INLINE)

d.label(0x3810, "page_text")
d.banner(0x3810, title="VDU codes: credits, title and keys",
         description="Printed by title_start up to the &FF terminator. The "
                     "credits go at fixed text positions on the striped "
                     "background; the title is printed in a text window "
                     "cleared to black at columns 6-13, rows 10-12; the keys "
                     "in a window cleared to white at columns 1-18, rows "
                     "18-24, in black text, as four lines of 18 characters.")
d.byte(0x3810, 3)
d.comment(0x3810, "VDU 31,7,14: text cursor to column 7, row 14", align=INLINE)
d.string(0x3813, 6)
d.comment(0x3813, "...", align=INLINE)
d.byte(0x3819, 3)
d.comment(0x3819, "VDU 31,4,16: column 4, row 16", align=INLINE)
d.string(0x381C, 12)
d.comment(0x381C, "...", align=INLINE)
d.byte(0x3828, 3)
d.comment(0x3828, "VDU 31,2,30: column 2, row 30", align=INLINE)
d.string(0x382B, 16)
d.comment(0x382B, "...", align=INLINE)
d.byte(0x383B, 5)
d.comment(0x383B, "VDU 28,6,12,13,10: text window, columns 6-13, rows 10-12", align=INLINE)
d.byte(0x3840, 2)
d.comment(0x3840, "CLS (to black), then down to the window's middle row", align=INLINE)
d.string(0x3842, 8)
d.comment(0x3842, "The title, filling the window's width", align=INLINE)
d.byte(0x384A, 5)
d.comment(0x384A, "VDU 28,1,24,18,18: text window, columns 1-18, rows 18-24", align=INLINE)
d.byte(0x384F, 1)
d.comment(0x384F, "CLS", align=INLINE)
d.byte(0x3850, 2)
d.comment(0x3850, "COLOUR 131: white text background", align=INLINE)
d.byte(0x3852, 2)
d.comment(0x3852, "COLOUR 0: black text", align=INLINE)
d.byte(0x3854, 2)
d.comment(0x3854, "CLS (to white), then down a row", align=INLINE)
d.string(0x3856, 72)
d.comment(0x3856, "The keys: a blank line, then f1, 5 and 6, a line each", align=INLINE)
d.byte(0x389E, 1)
d.comment(0x389E, "Terminator", align=INLINE)

d.label(0x389F, "blank_line_text")
d.banner(0x389F, title="Text: a line of spaces",
         description="Eighteen spaces and the &FF terminator, the width of "
                     "the keys window. title_start prints them after the "
                     "keys on any machine but an Electron; they fall on the "
                     "window's next line, which is already white.")
d.string(0x389F, 18)
d.comment(0x389F, "One line of the keys window", align=INLINE)
d.byte(0x38B1, 1)
d.comment(0x38B1, "Terminator", align=INLINE)

d.label(0x38B2, "black_window_vdu")
d.banner(0x38B2, title="VDU codes: an empty black window",
         description="Printed last: a text window at columns 2-17, rows "
                     "26-28, cleared to black with white text. TITLE prints "
                     "nothing in it, and DUNK, which runs next, starts with "
                     "MODE 7.")
d.byte(0x38B2, 5)
d.comment(0x38B2, "VDU 28,2,28,17,26: text window, columns 2-17, rows 26-28", align=INLINE)
d.byte(0x38B7, 2)
d.comment(0x38B7, "COLOUR 128: black text background", align=INLINE)
d.byte(0x38B9, 2)
d.comment(0x38B9, "COLOUR 3: white text", align=INLINE)
d.byte(0x38BB, 1)
d.comment(0x38BB, "CLS", align=INLINE)
d.byte(0x38BC, 1)
d.comment(0x38BC, "Terminator", align=INLINE)

d.label(0x38BD, "tape_command")
d.banner(0x38BD, title="Unused command strings",
         description="Two CR-terminated OSCLI commands, *TAPE and */, that "
                     "nothing in TITLE refers to.")
d.string(0x38BD, 5)
d.comment(0x38BD, "*TAPE", align=INLINE)
d.byte(0x38C2, 1)
d.comment(0x38C2, "CR", align=INLINE)
d.label(0x38C3, "run_command")
d.string(0x38C3, 2)
d.comment(0x38C3, "*/ (run a file whose name is not given)", align=INLINE)
d.byte(0x38C5, 1)
d.comment(0x38C5, "CR", align=INLINE)

# ---------------------------------------------------------------------------
# The program.

d.subroutine(0x38C6, "title_start", title="TITLE: draw the title page and wait for a key",
             description="Entered by */TITLE from the BASIC program DUNJUNZ. "
                         "Select MODE 5 with colour 2 blue, fill the screen "
                         "with stripe_pattern, copy title_picture into "
                         "character rows 1-8, print the credits, title and "
                         "keys, open an empty black window at the bottom, hide "
                         "the cursor, flush the keyboard buffer and wait up to "
                         "7.67 seconds for a key, then return to BASIC.")
d.label(0x38C8, "send_mode_vdu")
d.label(0x38E4, "fill_stripes")
d.label(0x3913, "copy_picture")
d.label(0x3939, "print_page_text")
d.label(0x3956, "print_blank_line")
d.label(0x3964, "open_black_window")
d.label(0x3966, "print_black_window")

operand(0x38C9, sym("mode_vdu"))
operand(0x38D1, hexlit(8))
operand(0x38D5, hi(sym("stripe_pattern")))
operand(0x38DF, hi(sym("mode5_screen")))
operand(0x3904, hi(sym("title_picture")))
operand(0x390C, lo(sym("title_picture_screen")))
operand(0x3910, hi(sym("title_picture_screen")))
operand(0x3934, hi(sym("title_picture") + hexlit(0xA00)))

comments([
    (0x38C6, "Send the eight bytes of mode_vdu"),
    (0x38C8, "..."), (0x38CB, "..."), (0x38CE, "..."),
    (0x38CF, "..."), (0x38D0, "..."), (0x38D2, "..."),
    (0x38D4, "Point copy_from at stripe_pattern and copy_to at mode5_screen"),
    (0x38D6, "..."),
    (0x38D8, "Both low bytes are 0"),
    (0x38DA, "..."), (0x38DC, "..."), (0x38DE, "..."), (0x38E0, "..."),
    (0x38E2, "Start at the cell's first byte"),
    (0x38E4, "Copy the pattern's eight bytes into the next cell"),
    (0x38E6, "..."), (0x38E8, "..."), (0x38E9, "..."),
    (0x38EA, "..."), (0x38EC, "..."),
    (0x38EE, "copy_to += 8: on to the next cell"),
    (0x38EF, "..."), (0x38F1, "..."), (0x38F3, "..."),
    (0x38F5, "..."), (0x38F7, "..."), (0x38F9, "..."),
    (0x38FB, "Back to the pattern's first byte"),
    (0x38FD, "Repeat until copy_to reaches &8000, the top of the screen"),
    (0x38FF, "..."), (0x3901, "..."),
    (0x3903, "copy_from = title_picture"),
    (0x3905, "..."), (0x3907, "..."), (0x3909, "..."),
    (0x390B, "copy_to = title_picture_screen (Y stays 0 from here)"),
    (0x390D, "..."), (0x390F, "..."), (0x3911, "..."),
    (0x3913, "Copy one byte of the picture to the screen"),
    (0x3915, "..."),
    (0x3917, "copy_from += 1"),
    (0x3918, "..."), (0x391A, "..."), (0x391C, "..."),
    (0x391E, "..."), (0x3920, "..."), (0x3922, "..."),
    (0x3924, "copy_to += 1"),
    (0x3925, "..."), (0x3927, "..."), (0x3929, "..."),
    (0x392B, "..."), (0x392D, "..."), (0x392F, "..."),
    (0x3931, "Repeat until copy_from reaches the end of the file, &4400"),
    (0x3933, "..."), (0x3935, "..."),
    (0x3937, "Print page_text up to its &FF terminator"),
    (0x3939, "..."), (0x393C, "..."), (0x393F, "..."),
    (0x3940, "..."), (0x3943, "..."), (0x3945, "..."),
    (0x3947, "Read the machine type, INKEY(-256)"),
    (0x3949, "..."), (0x394B, "..."), (0x394D, "..."),
    (0x3950, "1 is an Electron: skip the line of spaces"),
    (0x3952, "..."),
    (0x3954, "Print blank_line_text up to its &FF terminator"),
    (0x3956, "..."), (0x3959, "..."), (0x395C, "..."),
    (0x395D, "..."), (0x3960, "..."), (0x3962, "..."),
    (0x3964, "Print black_window_vdu up to its &FF terminator"),
    (0x3966, "..."), (0x3969, "..."), (0x396C, "..."),
    (0x396D, "..."), (0x3970, "..."), (0x3972, "..."),
    (0x3974, "6845 register 10 (cursor start) = &20: no cursor"),
    (0x3976, "..."), (0x3979, "..."), (0x397B, "..."),
    (0x397E, "Flush the keyboard buffer (X is &0B, non-zero, from the loop above)"),
    (0x3980, "..."),
    (0x3983, "Wait up to &2FF centiseconds (7.67 s) for a key"),
    (0x3985, "..."), (0x3987, "..."), (0x3989, "..."),
    (0x398C, "Return to BASIC, which chains DUNK"),
])

# ---------------------------------------------------------------------------
# Data after the code.

d.banner(0x398D, title="Unused",
         description="Zeros up to the picture, which starts on a page "
                     "boundary.")
d.byte(0x398D, 0x3A00 - 0x398D)

d.label(0x3A00, "title_picture")
d.banner(0x3A00, title="The title picture",
         description="Eight MODE 5 character rows (&A00 bytes, &140 a row, "
                     "eight bytes a cell, top pixel row first), copied by "
                     "title_start to character rows 1-8. A blue frame holds "
                     "a white panel at the left, the name BUG BYTE in large "
                     "white letters and a red and blue face at the right.")
for row in range(8):
    addr = 0x3A00 + row * 0x140
    d.comment(addr, "Character row %d (screen &%04X)" % (row + 1, 0x5940 + row * 0x140))
    d.byte(addr, 0x140, cols=8)

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
