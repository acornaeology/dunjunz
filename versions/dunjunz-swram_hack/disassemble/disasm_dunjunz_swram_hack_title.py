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
d.comment(0x3813, "The author credit's heading", align=INLINE)
d.byte(0x3819, 3)
d.comment(0x3819, "VDU 31,4,16: column 4, row 16", align=INLINE)
d.string(0x381C, 12)
d.comment(0x381C, "The author's name", align=INLINE)
d.byte(0x3828, 3)
d.comment(0x3828, "VDU 31,2,30: column 2, row 30", align=INLINE)
d.string(0x382B, 16)
d.comment(0x382B, "The copyright line", align=INLINE)
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
                         "7.67 seconds for a key, then return to BASIC.",
             on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
d.label(0x38C8, "send_mode_vdu")
d.label(0x38E4, "fill_stripes")
d.label(0x3913, "copy_picture")
d.label(0x3939, "print_page_text")
d.label(0x3956, "print_blank_line")
d.label(0x3964, "open_black_window")
d.label(0x3966, "print_black_window")

operand(0x38C9, sym("mode_vdu"))
operand(0x38D1, sym("page_text") - sym("mode_vdu"))
d.constant(0x8000, "screen_end", comment="The top of screen memory")
d.constant(0xFF, "text_end", comment="The byte that ends TITLE's text")
operand(0x3900, hi(sym("screen_end")))
for operand_addr in (0x3944, 0x3961, 0x3971):
    operand(operand_addr, sym("text_end"))
operand(0x38D5, hi(sym("stripe_pattern")))
operand(0x38DF, hi(sym("mode5_screen")))
operand(0x3904, hi(sym("title_picture")))
operand(0x390C, lo(sym("title_picture_screen")))
operand(0x3910, hi(sym("title_picture_screen")))
operand(0x3934, hi(sym("title_picture") + hexlit(0xA00)))

comments([
    (0x38C6, "Send the eight bytes of mode_vdu"),
    (0x38C8, "Next byte of the MODE 5 and palette set-up..."), (0x38CB, "...to the VDU drivers"), (0x38CE, "...on to the next"),
    (0x38CF, "...count into A for the test"), (0x38D0, "...all eight sent?"), (0x38D2, "No: send the next"),
    (0x38D4, "Point copy_from at stripe_pattern and copy_to at mode5_screen"),
    (0x38D6, "...copy_from's high byte"),
    (0x38D8, "Both low bytes are 0"),
    (0x38DA, "...copy_from's low byte"), (0x38DC, "...copy_to's low byte"), (0x38DE, "...the MODE 5 screen's page..."), (0x38E0, "...as copy_to's high byte"),
    (0x38E2, "Start at the cell's first byte"),
    (0x38E4, "Copy the pattern's eight bytes into the next cell"),
    (0x38E6, "...stripes on alternate pixel rows"), (0x38E8, "...next byte of the cell"), (0x38E9, "...count into A for the test"),
    (0x38EA, "...all eight rows of the cell?"), (0x38EC, "No: copy the next row"),
    (0x38EE, "copy_to += 8: on to the next cell"),
    (0x38EF, "...low byte..."), (0x38F1, "...plus 8: one character cell"), (0x38F3, "...the cell to the right, or the next row's first"),
    (0x38F5, "...high byte..."), (0x38F7, "...with the carry"), (0x38F9, "...completing the next cell's address"),
    (0x38FB, "Back to the pattern's first byte"),
    (0x38FD, "Repeat until copy_to reaches &8000, the top of the screen"),
    (0x38FF, "...at the top of screen memory?"), (0x3901, "No: stripe the next cell"),
    (0x3903, "copy_from = title_picture"),
    (0x3905, "...as copy_from's high byte"), (0x3907, "...page-aligned..."), (0x3909, "...so copy_from's low byte is 0"),
    (0x390B, "copy_to = title_picture_screen (Y stays 0 from here)"),
    (0x390D, "...low byte: character row 1, below a striped row"), (0x390F, "...high byte..."), (0x3911, "...as copy_to's high byte"),
    (0x3913, "Copy one byte of the picture to the screen"),
    (0x3915, "...over the stripes"),
    (0x3917, "copy_from += 1"),
    (0x3918, "...low byte..."), (0x391A, "...plus one"), (0x391C, "...the picture's next byte"),
    (0x391E, "...high byte..."), (0x3920, "...with the carry"), (0x3922, "...crossing into its next page"),
    (0x3924, "copy_to += 1"),
    (0x3925, "...low byte..."), (0x3927, "...plus one"), (0x3929, "...the screen's next byte"),
    (0x392B, "...high byte..."), (0x392D, "...with the carry"), (0x392F, "...completing the next screen address"),
    (0x3931, "Repeat until copy_from reaches the end of the file, &4400"),
    (0x3933, "...past the picture's last page?"), (0x3935, "No: copy the next byte"),
    (0x3937, "Print page_text up to its &FF terminator"),
    (0x3939, "...this byte of the credits, title and keys..."), (0x393C, "...printed or obeyed as VDU codes"), (0x393F, "...on to the next"),
    (0x3940, "...look at it..."), (0x3943, "...is it the terminator?"), (0x3945, "No: print it"),
    (0x3947, "Read the machine type, INKEY(-256)"),
    (0x3949, "...X = 0 and Y = &FF ask for the machine type..."), (0x394B, "...rather than a key"), (0x394D, "...X = 1 on an Electron"),
    (0x3950, "1: an Electron?"),
    (0x3952, "Yes: leave out the line of spaces"),
    (0x3954, "Print blank_line_text up to its &FF terminator"),
    (0x3956, "...this byte of the line..."), (0x3959, "...printed"), (0x395C, "...on to the next"),
    (0x395D, "...look at it..."), (0x3960, "...is it the terminator?"), (0x3962, "No: print it"),
    (0x3964, "Print black_window_vdu up to its &FF terminator"),
    (0x3966, "...this byte of the window set-up..."), (0x3969, "...obeyed as VDU codes"), (0x396C, "...on to the next"),
    (0x396D, "...look at it..."), (0x3970, "...is it the terminator?"), (0x3972, "No: send it"),
    (0x3974, "6845 register 10 (cursor start) = &20: no cursor"),
    (0x3976, "...selected in the 6845..."), (0x3979, "...&20: cursor display off..."), (0x397B, "...written straight to the 6845, not through VDU 23"),
    (0x397E, "OSBYTE &0F, X = &0A from the loop above: flush input"),
    (0x3980, "...so an early key press doesn't end the page"),
    (0x3983, "Wait up to &2FF centiseconds (7.67 s) for a key"),
    (0x3985, "...X and Y: the time limit, &2FF centiseconds..."), (0x3987, "...high byte of the limit"), (0x3989, "...a key, or the time, ends the title page"),
    (0x398C, "Return to BASIC, which chains DUNK"),
])
for addr, text in [
    (0x38D4, "Stripe the whole MODE 5 screen, &5800-&7FFF, one character "
             "cell at a time."),
    (0x3903, "Copy the logo picture, a byte at a time, over character rows "
             "1-8."),
    (0x3937, "Print the credits, title and keys, then (except on an "
             "Electron) a line of spaces, then open the black window."),
    (0x3974, "Hide the cursor and wait for a key or the time limit."),
]:
    d.comment(addr, text)

# ---------------------------------------------------------------------------
# Data after the code.

d.banner(0x398D, title="Unused",
         description="Zeros up to the picture, which starts on a page "
                     "boundary.")
d.byte(0x398D, 0x3A00 - 0x398D, cols=16)
d.comment(0x398D, "Zeros", align=dasmos.Align.INLINE)

d.label(0x3A00, "title_picture")
d.banner(0x3A00, title="The title picture",
         description="Eight MODE 5 character rows (&A00 bytes, &140 a row, "
                     "eight bytes a cell, top pixel row first), copied by "
                     "title_start to character rows 1-8. A blue frame holds "
                     "a white panel at the left, the name BUG BYTE in large "
                     "white letters and a red and blue face at the right.")
for row in range(8):
    addr = 0x3A00 + row * 0x140
    d.comment(addr, "Character row %d (screen &%04X)" % (row + 1, 0x5940 + row * 0x140),
              align=dasmos.Align.INLINE)
    d.byte(addr, 0x140, cols=8)

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
