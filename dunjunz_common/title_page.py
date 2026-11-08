"""Annotations for `TITLE`, the title page of the cassette and of the
sideways RAM hack.

The hack's `TITLE` (&3800) is the cassette's (&2800) moved up &1000 bytes,
with its addresses changed to match, a different line of text in the white
window, and a different ending: the cassette's runs the next file on the
tape, the hack's waits for a key and returns to BASIC. `annotate` applies
the shared annotations at either base, with the differences from
`CASSETTE` or `HACK`.
"""

import dasmos
from dasmos.expr import hexlit, hi, lo, sym

INLINE = dasmos.Align.INLINE

CASSETTE = {
    "context": (
        "TITLE is the title page the cassette shows between its intro and "
        "the game: PLOAD runs it with */, the next file on the tape, and it "
        "ends by running the next file after it, DUNK."),
    "window_text": "a note to see the inlay card",
    "window_text_comment": "\"See Inlay Card For Play instructions and Keys\", four lines of 18",
    "next_program": "the loader that runs next, Dunjunz1, selects MODE 2",
    "commands_title": "Commands: select the cassette and run the next file",
    "commands_description": (
        "Two CR-terminated OSCLI commands, *TAPE and */, that title_start "
        "issues at the end. */ with no name runs the next file on the tape, "
        "DUNK."),
    "start_description": (
        "The title page between the intro and the game. PLOAD runs it with "
        "*/, the next file on the tape; the file's execution address is "
        "title_entry, two instructions into the loop that sends mode_vdu, "
        "not this LDX #0 (see title_entry). "
        "The run is a straight line in four phases, marked by block comments "
        "below. Screen: MODE 5 with colour 2 blue, then stripe_pattern "
        "copied into every character cell from &5800 to &7FFF. Picture: "
        "title_picture, &A00 bytes, copied a byte at a time over character "
        "rows 1-8. Text: page_text (the credits, the title in a black window "
        "and a white window of text), then blank_line_text unless "
        "INKEY(-256) reports an Electron, then black_window_vdu. "
        "End: *TAPE, then */ runs the next file on the tape, DUNK, whose "
        "loader brings in the rest of the game and does not return."),
    "code_end": 0x183,
    "tail_block": "Select the cassette filing system and run the next file, DUNK.",
    "tail_comments": [
        (0x174, "*TAPE: the cassette filing system..."),
        (0x176, "...the command's high byte..."), (0x178, "...through OSCLI"),
        (0x17B, "*/: run the next file on the tape..."),
        (0x17D, "...the command's high byte..."),
        (0x17F, "...DUNK, which loads the rest of the game; it does not return"),
        (0x182, "Not reached: DUNK's loader never returns"),
    ],
}

# The cassette's TITLE is entered at &28CE (its exec address), not at
# title_start: see CASSETTE_ENTRY_NOTE.
CASSETTE_ENTRY_NOTE = (
    "The file's execution address, where */ enters TITLE: the INX of the "
    "loop that sends mode_vdu, two instructions after title_start's LDX "
    "#0. So the loop starts from whatever X the MOS enters with, plus "
    "one, and sends from mode_vdu + X until X wraps round to 8. Run from "
    "PLOAD on MOS 1.20, X is &E4, so 27 bytes of this code (&28ED-&2907) "
    "go to the VDU drivers first: a few characters and a VDU 24 that sets "
    "a graphics window, both undone by the MODE 5 that follows intact.")

HACK = {
    "context": (
        "TITLE is the title page shown between the intro and the game's "
        "loader: the BASIC program DUNJUNZ runs it with */TITLE, and it "
        "returns to BASIC, which chains DUNK."),
    "window_text": "the keys",
    "window_text_comment": "The keys: a blank line, then f1, 5 and 6, a line each",
    "next_program": "DUNK, which runs next, starts with MODE 7",
    "commands_title": "Unused command strings",
    "commands_description": (
        "Two CR-terminated OSCLI commands, *TAPE and */, that nothing in "
        "TITLE refers to."),
    "start_description": (
        "The title page between the intro and the game's loader. Entered by "
        "*/TITLE from the BASIC program DUNJUNZ, after its \"Please "
        "wait....\" screen in MODE 4; it returns to BASIC, which does "
        "*FX225 and *TV255 and chains DUNK, the sideways RAM loader. "
        "The run is a straight line in four phases, marked by block comments "
        "below. Screen: MODE 5 with colour 2 blue, then stripe_pattern "
        "copied into every character cell from &5800 to &7FFF. Picture: "
        "title_picture, &A00 bytes, copied a byte at a time over character "
        "rows 1-8. Text: page_text (the credits, the title in a black window "
        "and a white window of text), then blank_line_text unless "
        "INKEY(-256) reports an Electron, then black_window_vdu. "
        "Wait: the cursor is turned off by writing the 6845 directly "
        "(register 10 = &20, at &FE00/&FE01, even on an Electron), the input "
        "buffer is flushed and OSBYTE &81 waits up to &2FF centiseconds "
        "(7.67 s) for a key. It leaves the page on the screen, with the "
        "last text window (columns 2-17, rows 26-28) still set, the cursor "
        "off, and the key, if one was pressed, read from the buffer."),
    "code_end": 0x18D,
    "tail_block": "Hide the cursor and wait for a key or the time limit.",
    "tail_comments": [
        (0x174, "6845 register 10 (cursor start) = &20: no cursor"),
        (0x176, "...selected in the 6845..."), (0x179, "...&20: cursor display off..."),
        (0x17B, "...written straight to the 6845, not through VDU 23"),
        (0x17E, "OSBYTE &0F, X = &0A from the loop above: flush input"),
        (0x180, "...so an early key press doesn't end the page"),
        (0x183, "Wait up to &2FF centiseconds (7.67 s) for a key"),
        (0x185, "...X and Y: the time limit, &2FF centiseconds..."),
        (0x187, "...high byte of the limit"), (0x189, "...a key, or the time, ends the title page"),
        (0x18C, "Return to BASIC, which chains DUNK"),
    ],
}


def annotate(d, B, v):
    """Annotate TITLE loaded at base B, with the variant's differences v."""

    def comments(pairs):
        for addr, text in pairs:
            d.comment(addr, text, align=INLINE)

    def operand(addr, expression):
        d.expr(addr, expression)

    # ---------------------------------------------------------------------------
    # Workspace and screen addresses outside the file.

    d.label(0x70, "copy_from", group="zero_page", description=(
        "Source pointer, low byte: stripe_pattern while striping, then the "
        "next byte of title_picture."))
    d.label(0x71, "copy_from_high", group="zero_page", description=(
        "Source pointer, high byte."))
    d.label(0x80, "copy_to", group="zero_page", description=(
        "Screen pointer, low byte: the next character cell while striping, "
        "then the next screen byte of the picture."))
    d.label(0x81, "copy_to_high", group="zero_page", description=(
        "Screen pointer, high byte."))
    d.label(0x5800, "mode5_screen", group="screen",
            description="The start of MODE 5's screen memory (&5800-&7FFF)")
    d.label(0x5940, "title_picture_screen", group="screen",
            description="Character row 1 of the MODE 5 screen, where the logo "
                        "picture is copied (&5940-&633F)")

    # ---------------------------------------------------------------------------
    # Data at the start of the file.

    d.label(B + 0x000, "stripe_pattern")
    d.banner(B + 0x000, title="Background stripe pattern",
             description=v["context"] + " Its data comes first and the code, "
                         f"title_start (&{B + 0xC6:04X}), after it; title_start's "
                         "banner describes the run. "
                         "This first table is one MODE 5 character cell, copied "
                         "over the whole screen: even pixel rows black (&00), "
                         "odd rows four pixels of colour 2 (&F0), which "
                         "mode_vdu makes blue.")
    d.byte(B + 0x000, 8)
    d.comment(B + 0x000, "Rows 0-7 of the cell, black and colour 2 alternately", align=INLINE)

    d.label(B + 0x008, "mode_vdu")
    d.banner(B + 0x008, title="VDU codes: MODE 5, colour 2 blue",
             description="Eight bytes sent by title_start before anything is "
                         "drawn: VDU 22,5 (MODE 5) and VDU 19,2,4,0,0,0 (logical "
                         "colour 2 shows as blue).")
    d.byte(B + 0x008, 2)
    d.comment(B + 0x008, "VDU 22,5: MODE 5", align=INLINE)
    d.byte(B + 0x00A, 6)
    d.comment(B + 0x00A, "VDU 19,2,4,0,0,0: logical colour 2 is blue", align=INLINE)

    d.label(B + 0x010, "page_text")
    d.banner(B + 0x010, title="VDU codes: credits, title and keys",
             description="Printed by title_start up to the &FF terminator. The "
                         "credits go at fixed text positions on the striped "
                         "background; the title is printed in a text window "
                         "cleared to black at columns 6-13, rows 10-12; "
                         + v["window_text"] + " in a window cleared to white at "
                         "columns 1-18, rows 18-24, in black text, as four lines "
                         "of 18 characters.")
    d.byte(B + 0x010, 3)
    d.comment(B + 0x010, "VDU 31,7,14: text cursor to column 7, row 14", align=INLINE)
    d.string(B + 0x013, 6)
    d.comment(B + 0x013, "The author credit's heading", align=INLINE)
    d.byte(B + 0x019, 3)
    d.comment(B + 0x019, "VDU 31,4,16: column 4, row 16", align=INLINE)
    d.string(B + 0x01C, 12)
    d.comment(B + 0x01C, "The author's name", align=INLINE)
    d.byte(B + 0x028, 3)
    d.comment(B + 0x028, "VDU 31,2,30: column 2, row 30", align=INLINE)
    d.string(B + 0x02B, 16)
    d.comment(B + 0x02B, "The copyright line", align=INLINE)
    d.byte(B + 0x03B, 5)
    d.comment(B + 0x03B, "VDU 28,6,12,13,10: text window, columns 6-13, rows 10-12", align=INLINE)
    d.byte(B + 0x040, 2)
    d.comment(B + 0x040, "CLS (to black), then down to the window's middle row", align=INLINE)
    d.string(B + 0x042, 8)
    d.comment(B + 0x042, "The title, filling the window's width", align=INLINE)
    d.byte(B + 0x04A, 5)
    d.comment(B + 0x04A, "VDU 28,1,24,18,18: text window, columns 1-18, rows 18-24", align=INLINE)
    d.byte(B + 0x04F, 1)
    d.comment(B + 0x04F, "CLS", align=INLINE)
    d.byte(B + 0x050, 2)
    d.comment(B + 0x050, "COLOUR 131: white text background", align=INLINE)
    d.byte(B + 0x052, 2)
    d.comment(B + 0x052, "COLOUR 0: black text", align=INLINE)
    d.byte(B + 0x054, 2)
    d.comment(B + 0x054, "CLS (to white), then down a row", align=INLINE)
    d.string(B + 0x056, 72)
    d.comment(B + 0x056, v["window_text_comment"], align=INLINE)
    d.byte(B + 0x09E, 1)
    d.comment(B + 0x09E, "Terminator", align=INLINE)

    d.label(B + 0x09F, "blank_line_text")
    d.banner(B + 0x09F, title="Text: a line of spaces",
             description="Eighteen spaces and the &FF terminator, the width of "
                         "the white window. title_start prints them after its "
                         "text on any machine but an Electron; they fall on the "
                         "window's next line, which is already white.")
    d.string(B + 0x09F, 18)
    d.comment(B + 0x09F, "One line of the keys window", align=INLINE)
    d.byte(B + 0x0B1, 1)
    d.comment(B + 0x0B1, "Terminator", align=INLINE)

    d.label(B + 0x0B2, "black_window_vdu")
    d.banner(B + 0x0B2, title="VDU codes: an empty black window",
             description="Printed last: a text window at columns 2-17, rows "
                         "26-28, cleared to black with white text. TITLE prints "
                         "nothing in it, and " + v["next_program"] + ".")
    d.byte(B + 0x0B2, 5)
    d.comment(B + 0x0B2, "VDU 28,2,28,17,26: text window, columns 2-17, rows 26-28", align=INLINE)
    d.byte(B + 0x0B7, 2)
    d.comment(B + 0x0B7, "COLOUR 128: black text background", align=INLINE)
    d.byte(B + 0x0B9, 2)
    d.comment(B + 0x0B9, "COLOUR 3: white text", align=INLINE)
    d.byte(B + 0x0BB, 1)
    d.comment(B + 0x0BB, "CLS", align=INLINE)
    d.byte(B + 0x0BC, 1)
    d.comment(B + 0x0BC, "Terminator", align=INLINE)

    d.label(B + 0x0BD, "tape_command")
    d.banner(B + 0x0BD, title=v["commands_title"], description=v["commands_description"])
    d.string(B + 0x0BD, 5)
    d.comment(B + 0x0BD, "*TAPE", align=INLINE)
    d.byte(B + 0x0C2, 1)
    d.comment(B + 0x0C2, "CR", align=INLINE)
    d.label(B + 0x0C3, "run_command")
    d.string(B + 0x0C3, 2)
    d.comment(B + 0x0C3, "*/ (run a file whose name is not given)", align=INLINE)
    d.byte(B + 0x0C5, 1)
    d.comment(B + 0x0C5, "CR", align=INLINE)

    # ---------------------------------------------------------------------------
    # The program.

    d.subroutine(B + 0x0C6, "title_start", title="TITLE: draw the title page and wait for a key",
                 description=v["start_description"],
                 on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
    d.label(B + 0x0C8, "send_mode_vdu")
    d.label(B + 0x0E4, "fill_stripes")
    d.label(B + 0x113, "copy_picture")
    d.label(B + 0x139, "print_page_text")
    d.label(B + 0x156, "print_blank_line")
    d.label(B + 0x164, "open_black_window")
    d.label(B + 0x166, "print_black_window")

    operand(B + 0x0C9, sym("mode_vdu"))
    operand(B + 0x0D1, sym("page_text") - sym("mode_vdu"))
    d.constant(0x8000, "screen_end", comment="The top of screen memory")
    d.constant(0xFF, "text_end", comment="The byte that ends TITLE's text")
    operand(B + 0x100, hi(sym("screen_end")))
    for operand_addr in (B + 0x144, B + 0x161, B + 0x171):
        operand(operand_addr, sym("text_end"))
    operand(B + 0x0D5, hi(sym("stripe_pattern")))
    operand(B + 0x0DF, hi(sym("mode5_screen")))
    operand(B + 0x104, hi(sym("title_picture")))
    operand(B + 0x10C, lo(sym("title_picture_screen")))
    operand(B + 0x110, hi(sym("title_picture_screen")))
    operand(B + 0x134, hi(sym("title_picture") + hexlit(0xA00)))

    comments([(B + offset, text) for offset, text in v["tail_comments"]])
    comments([
        (B + 0x0C6, "Send the eight bytes of mode_vdu"),
        (B + 0x0C8, "Next byte of the MODE 5 and palette set-up..."), (B + 0x0CB, "...to the VDU drivers"), (B + 0x0CE, "...on to the next"),
        (B + 0x0CF, "...count into A for the test"), (B + 0x0D0, "...all eight sent?"), (B + 0x0D2, "No: send the next"),
        (B + 0x0D4, "Point copy_from at stripe_pattern and copy_to at mode5_screen"),
        (B + 0x0D6, "...copy_from's high byte"),
        (B + 0x0D8, "Both low bytes are 0"),
        (B + 0x0DA, "...copy_from's low byte"), (B + 0x0DC, "...copy_to's low byte"), (B + 0x0DE, "...the MODE 5 screen's page..."), (B + 0x0E0, "...as copy_to's high byte"),
        (B + 0x0E2, "Start at the cell's first byte"),
        (B + 0x0E4, "Copy the pattern's eight bytes into the next cell"),
        (B + 0x0E6, "...stripes on alternate pixel rows"), (B + 0x0E8, "...next byte of the cell"), (B + 0x0E9, "...count into A for the test"),
        (B + 0x0EA, "...all eight rows of the cell?"), (B + 0x0EC, "No: copy the next row"),
        (B + 0x0EE, "copy_to += 8: on to the next cell"),
        (B + 0x0EF, "...copy_to's low byte..."), (B + 0x0F1, "...plus 8: one character cell"), (B + 0x0F3, "...the cell to the right, or the next row's first"),
        (B + 0x0F5, "...then copy_to's page..."), (B + 0x0F7, "...with the carry"), (B + 0x0F9, "...completing the next cell's address"),
        (B + 0x0FB, "Back to the pattern's first byte"),
        (B + 0x0FD, "Repeat until copy_to reaches &8000, the top of the screen"),
        (B + 0x0FF, "...at the top of screen memory?"), (B + 0x101, "No: stripe the next cell"),
        (B + 0x103, f"copy_from = title_picture, at &{B + 0x200:04X}..."),
        (B + 0x105, "...as copy_from's high byte"), (B + 0x107, "...which is page-aligned..."), (B + 0x109, "...so copy_from's low byte is 0"),
        (B + 0x10B, "copy_to = title_picture_screen (Y stays 0 from here)"),
        (B + 0x10D, "...low byte: character row 1, below a striped row"),
        (B + 0x10F, "...then the page of &5940..."), (B + 0x111, "...as copy_to's high byte"),
        (B + 0x113, "Copy one byte of the picture to the screen"),
        (B + 0x115, "...over the stripes"),
        (B + 0x117, "Advance copy_from to the picture's next byte..."),
        (B + 0x118, "...copy_from's low byte..."), (B + 0x11A, "...plus one, carry into the page"), (B + 0x11C, "...the picture's next byte"),
        (B + 0x11E, "...then copy_from's page..."), (B + 0x120, "...with the carry"), (B + 0x122, "...crossing into its next page"),
        (B + 0x124, "Advance copy_to to the screen's next byte..."),
        (B + 0x125, "...copy_to's low byte..."), (B + 0x127, "...plus one, carry into the page"), (B + 0x129, "...the screen's next byte"),
        (B + 0x12B, "...then copy_to's page..."), (B + 0x12D, "...with the carry"), (B + 0x12F, "...completing the next screen address"),
        (B + 0x131, f"Repeat until copy_from reaches the end of the file, &{B + 0xC00:04X}"),
        (B + 0x133, "...past the picture's last page?"), (B + 0x135, "No: copy the next byte"),
        (B + 0x137, "Print page_text up to its &FF terminator"),
        (B + 0x139, "...this byte of the credits, title and text..."), (B + 0x13C, "...printed or obeyed as VDU codes"), (B + 0x13F, "...on to the next"),
        (B + 0x140, "...look at it..."), (B + 0x143, "...is it the terminator?"), (B + 0x145, "No: print it"),
        (B + 0x147, "Read the machine type, INKEY(-256)"),
        (B + 0x149, "...X = 0 and Y = &FF ask for the machine type..."), (B + 0x14B, "...rather than a key"), (B + 0x14D, "...X = 1 on an Electron"),
        (B + 0x150, "1: an Electron?"),
        (B + 0x152, "Yes: leave out the line of spaces"),
        (B + 0x154, "Print blank_line_text up to its &FF terminator"),
        (B + 0x156, "...this byte of the line..."), (B + 0x159, "...printed: a space"), (B + 0x15C, "...on to the next"),
        (B + 0x15D, "...look at it..."), (B + 0x160, "...is it the terminator?"), (B + 0x162, "No: print it"),
        (B + 0x164, "Print black_window_vdu up to its &FF terminator"),
        (B + 0x166, "...this byte of the window set-up..."), (B + 0x169, "...obeyed as VDU codes"), (B + 0x16C, "...on to the next"),
        (B + 0x16D, "...look at it..."), (B + 0x170, "...is it the terminator?"), (B + 0x172, "No: send it"),
    ])
    for addr, text in [
        (B + 0x0D4, "Screen, with MODE 5 set: stripe all of it, &5800-&7FFF, "
                 "one character cell at a time."),
        (B + 0x103, "Copy the logo picture, a byte at a time, over character rows "
                 "1-8."),
        (B + 0x137, "Print the credits, the title and the white window's text, then (except on an "
                 "Electron) a line of spaces, then open the black window."),
        (B + 0x174, v["tail_block"]),
    ]:
        d.comment(addr, text)

    # ---------------------------------------------------------------------------
    # Data after the code.

    d.banner(B + v["code_end"], title="Unused",
             description="Zeros up to the picture, which starts on a page "
                         "boundary.")
    d.byte(B + v["code_end"], 0x200 - v["code_end"], cols=16)
    d.comment(B + v["code_end"], "Zeros", align=dasmos.Align.INLINE)

    d.label(B + 0x200, "title_picture")
    d.banner(B + 0x200, title="The title picture",
             description="Eight MODE 5 character rows (&A00 bytes, &140 a row, "
                         "eight bytes a cell, top pixel row first), copied by "
                         "title_start to character rows 1-8. A blue frame holds "
                         "a white panel at the left, the name BUG BYTE in large "
                         "white letters and a red and blue face at the right.")
    for row in range(8):
        addr = B + 0x200 + row * 0x140
        d.comment(addr, "Character row %d (screen &%04X)" % (row + 1, 0x5940 + row * 0x140),
                  align=dasmos.Align.INLINE)
        d.byte(addr, 0x140, cols=8)
