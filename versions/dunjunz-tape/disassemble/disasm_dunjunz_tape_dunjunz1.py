"""dasmos driver for `Dunjunz1` (&2000, exec &2000), the cassette's game
loader.

`DUNK`'s loader at &0740 loads it from tape to &2000 and jumps to it. It
prepares the game's screen while the colours are all black, loads the
loading screen (`Dunjunz2`) and then two of the game's three remaining
files (`Dunjunz3` to &6E80 and `Dunjunz4` to &08C0), and jumps to &0D00 in
`Dunjunz4`, which loads the last file, `Dunjunz5`, over this one.
"""

import os
from pathlib import Path

import dasmos
from dasmos.expr import hi, lo, sym

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-tape-dunjunz1.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-tape-dunjunz1.json"))

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "Dunjunz1", 0x2000, name="Dunjunz1", exec_addr=0x2000)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")

INLINE = dasmos.Align.INLINE


def comments(pairs):
    for addr, text in pairs:
        d.comment(addr, text, align=INLINE)


# ---------------------------------------------------------------------------
# Addresses outside the file.

d.label(0x2170, "osfile_block", group="workspace", description=(
    "The OSFILE control block that load_file passes to FILEV's routine, "
    "just past the end of the file: bytes 0-1 the filename's address, "
    "bytes 2-5 the load address. Byte 6, the exec address's low byte, is "
    "never set; whatever it holds, each file loads at the load address "
    "given here or, if the byte is not 0, at its own, which is the same."))
d.label(0x2172, "osfile_load_addr", group="workspace",
        description="Bytes 2-5 of osfile_block: the load address.")
d.label(0x2174, "osfile_load_addr_high", group="workspace",
        description="Bytes 4-5 of osfile_block: the load address's top half, 0.")
d.label(0x0D00, "load_core", group="game", description=(
    "In Dunjunz4: loads Dunjunz5 to &2000, over this loader, and falls "
    "into game_entry (&0D31)."))
d.label(0x08C0, "dunjunz4_start", group="game",
        description="Where Dunjunz4, the game's &08C0-&1FFF, loads.")
d.label(0x6E80, "dunjunz3_start", group="game",
        description="Where Dunjunz3, the game's &6E80-&7FFF, loads.")
d.label(0x3280, "loading_screen", group="screen",
        description="Where Dunjunz2, the MODE 2 loading screen, loads.")

# ---------------------------------------------------------------------------
# The program.

d.subroutine(0x2000, "loader_start", title="Prepare the screen and load the game",
             description=(
                 "Entered from DUNK's loader at &0740, which loads this file "
                 "to &2000 and jumps here. It does *FX 200,3 (clear memory on "
                 "BREAK), selects MODE 2 with the cursor off and the 6845 "
                 "showing 25 character rows, as in play, and makes logical "
                 "colours 1-7 black and colour 8 green, so the loading "
                 "screen arrives unseen. It sets a three-row text window at "
                 "the bottom, rows 22-24, in colour 8, then calls load_files "
                 "and jumps to load_core in the game, which loads the last "
                 "file and starts it."),
             on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
d.label(0x206A, "blacken_colour")
d.comment(0x200B, "MODE 2, with the cursor off and 25 rows of text shown")
d.comment(0x2068, "Logical colours 7 down to 1 black, colour 8 green: the "
                  "loading screen is drawn unseen")
d.comment(0x20A8, "A text window at the bottom, columns 0-19, rows 22-24")
comments([
    (0x2000, "A = &78..."), (0x2002, "...clear the carry..."),
    (0x2003, "...plus &50: OSBYTE &C8, the BREAK and ESCAPE effect"),
    (0x2005, "X = 2..."), (0x2007, "...plus 1: 3, clear memory on BREAK"),
    (0x2008, "*FX 200,3"),
    (0x200B, "VDU 22: select a mode..."), (0x200D, "...send it"),
    (0x2010, "...2"), (0x2012, "...send it: MODE 2"),
    (0x2015, "VDU 23,0: write a 6845 register..."), (0x2017, "...send the 23"),
    (0x201A, "...0: a 6845 register follows"), (0x201C, "...send it"),
    (0x201F, "...register 10, cursor start..."), (0x2021, "...send the number"),
    (0x2024, "...&20: cursor off"), (0x2026, "...send the value"),
    (0x2029, "...then six zeros to finish the command"),
    (0x202B, "...the first"), (0x202E, "...the second"), (0x2031, "...the third"),
    (0x2034, "...the fourth"), (0x2037, "...the fifth"), (0x203A, "...the sixth"),
    (0x203D, "A seventh 0: a VDU 0, which does nothing"),
    (0x2040, "VDU 23,0: write another 6845 register..."), (0x2042, "...send the 23"),
    (0x2045, "...0: a 6845 register follows"), (0x2047, "...send it"),
    (0x204A, "...register 6, character rows displayed..."), (0x204C, "...send the number"),
    (0x204F, "...25 rows, as in play"), (0x2051, "...send the value"),
    (0x2054, "...then six zeros to finish the command"),
    (0x2056, "...the first"), (0x2059, "...the second"), (0x205C, "...the third"),
    (0x205F, "...the fourth"), (0x2062, "...the fifth"), (0x2065, "...the sixth"),
    (0x2068, "From logical colour 7 down to 1..."),
    (0x206A, "VDU 19: set a logical colour..."), (0x206C, "...send the 19"),
    (0x206F, "...this one..."), (0x2070, "...send its number"),
    (0x2073, "...to physical colour 0, black, and three zeros"),
    (0x2075, "...send the black"), (0x2078, "...the first zero"),
    (0x207B, "...the second"), (0x207E, "...the third"),
    (0x2081, "Next colour down..."), (0x2082, "...until colour 1 is black"),
    (0x2084, "VDU 19: set a logical colour..."), (0x2086, "...send the 19"),
    (0x2089, "...colour 8..."), (0x208B, "...send its number"),
    (0x208E, "...to physical colour 2, green..."), (0x2090, "...send it"),
    (0x2093, "...then three zeros"), (0x2095, "...the first"),
    (0x2098, "...the second"), (0x209B, "...the third"),
    (0x209E, "VDU 17: set the text colour..."), (0x20A0, "...send the 17"),
    (0x20A3, "...colour 8, green"), (0x20A5, "...send it"),
    (0x20A8, "VDU 28: set a text window..."), (0x20AA, "...send the 28"),
    (0x20AD, "...left column 0"), (0x20AF, "...send it"),
    (0x20B2, "...bottom row 24"), (0x20B4, "...send it"),
    (0x20B7, "...right column 19"), (0x20B9, "...send it"),
    (0x20BC, "...top row 22"), (0x20BE, "...send it: the window is set"),
    (0x20C1, "Load the loading screen, Dunjunz3 and Dunjunz4"),
    (0x20C4, "Load Dunjunz5 and start the game; this file is overwritten"),
])

d.subroutine(0x20C7, "load_file", title="Load a file through FILEV",
             description=(
                 "Load the file that osfile_block names to the load address "
                 "in it, by calling the filing system's FILEV routine "
                 "directly: its address is copied into the operand of this "
                 "routine's own JSR, then called with A = &FF (load). With "
                 "*TAPE selected, as TITLE left it, the file comes from the "
                 "cassette. The caller sets the filename's address and the "
                 "load address's low two bytes; this routine clears the top "
                 "two."),
             on_entry={"osfile_block": "filename address and load address, bytes 0-3"},
             on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
d.label(0x20E1, "load_file_call")
d.index_region(0x20E2, "load_file_call_address", window=(0, 1), description=(
    "Operand of the JSR at load_file_call. Stored as &3000; load_file "
    "overwrites it with the contents of FILEV before each call."))
d.expr(0x20C8, lo(sym("osfile_block")))
d.expr(0x20CA, hi(sym("osfile_block")))
d.expr(0x20E2, dasmos.expr.hexlit(0x3000))
comments([
    (0x20C7, "X, Y = osfile_block..."), (0x20C9, "...its page"),
    (0x20CB, "The load address's top two bytes are 0..."),
    (0x20CD, "...byte 4..."), (0x20D0, "...and byte 5: the I/O processor"),
    (0x20D3, "Copy FILEV into the JSR below..."),
    (0x20D6, "...its low byte..."), (0x20D9, "...and its high byte..."),
    (0x20DC, "...so the JSR calls the filing system's routine"),
    (0x20DF, "A = &FF: load the file"),
    (0x20E1, "Call FILEV's routine; the operand, &3000 as stored, is set above"),
    (0x20E4, "Return with the file loaded"),
])

d.subroutine(0x20E5, "load_files", title="Load the loading screen and two game files",
             description=(
                 "Load Dunjunz2, the loading screen, to &3280; restore the "
                 "default colours (VDU 20), which shows it at once, clear the "
                 "text window and set colour 2; then load Dunjunz3 to &6E80 "
                 "and Dunjunz4 to &08C0. Each file is named by one of the "
                 "filenames after the code and loaded by load_file."),
             on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
for addr, name in [(0x20E6, "screen_filename"), (0x2111, "dunjunz3_filename"),
                   (0x2123, "dunjunz4_filename")]:
    d.expr(addr, lo(sym(name)))
d.expr(0x20EB, hi(sym("screen_filename")))
d.expr(0x20E8, sym("osfile_block"))
d.expr(0x20ED, sym("osfile_block") + 1)
d.expr(0x2113, sym("osfile_block"))
d.expr(0x2125, sym("osfile_block"))
for addr in (0x20F2, 0x2118, 0x212A):
    d.expr(addr, sym("osfile_load_addr"))
for addr in (0x20F7, 0x211D, 0x212F):
    d.expr(addr, sym("osfile_load_addr") + 1)
d.expr(0x20F0, lo(sym("loading_screen")))
d.expr(0x20F5, hi(sym("loading_screen")))
d.expr(0x2116, lo(sym("dunjunz3_start")))
d.expr(0x211B, hi(sym("dunjunz3_start")))
d.expr(0x2128, lo(sym("dunjunz4_start")))
d.expr(0x212D, hi(sym("dunjunz4_start")))
d.expr(0x20CE, sym("osfile_load_addr_high"))
d.expr(0x20D1, sym("osfile_load_addr_high") + 1)
d.expr(0x20C5, sym("load_core"))
comments([
    (0x20E5, "Filename: screen_filename, \"Dunjunz2\"..."),
    (0x20E7, "...its low byte into the block..."),
    (0x20EA, "...and its page..."), (0x20EC, "...into byte 1"),
    (0x20EF, "Load address &3280, loading_screen..."),
    (0x20F1, "...low byte..."), (0x20F4, "...and page..."),
    (0x20F6, "...into bytes 2-3"),
    (0x20F9, "Load the loading screen, in black"),
    (0x20FC, "VDU 20: the default colours..."),
    (0x20FE, "...so the loading screen appears"),
    (0x2101, "VDU 12: clear the text window..."), (0x2103, "...send it"),
    (0x2106, "VDU 17: set the text colour..."), (0x2108, "...send the 17"),
    (0x210B, "...colour 2, green"), (0x210D, "...send it"),
    (0x2110, "Filename: dunjunz3_filename (same page)..."),
    (0x2112, "...into the block"),
    (0x2115, "Load address &6E80, dunjunz3_start..."),
    (0x2117, "...low byte..."), (0x211A, "...and page..."),
    (0x211C, "...into bytes 2-3"),
    (0x211F, "Load Dunjunz3, the game's &6E80-&7FFF"),
    (0x2122, "Filename: dunjunz4_filename (same page)..."),
    (0x2124, "...into the block"),
    (0x2127, "Load address &08C0, dunjunz4_start..."),
    (0x2129, "...low byte..."), (0x212C, "...and page..."),
    (0x212E, "...into bytes 2-3"),
    (0x2131, "Load Dunjunz4, the game's &08C0-&1FFF"),
    (0x2134, "Return to loader_start"),
])

# ---------------------------------------------------------------------------
# Data after the code.

d.banner(0x2135, title="Unused",
         description="Leftover bytes from the machine the file was saved "
                     "on: the end of a filename and fragments of code.")
d.byte(0x2135, 0x0B)
d.comment(0x2135, "Not referenced: \"on2\", a CR, then leftover bytes", align=INLINE)
for addr, name, file_name, start in [
        (0x2140, "screen_filename", "Dunjunz2", "the loading screen"),
        (0x2150, "dunjunz3_filename", "Dunjunz3", "the game's &6E80-&7FFF"),
        (0x2160, "dunjunz4_filename", "Dunjunz4", "the game's &08C0-&1FFF")]:
    d.label(addr, name)
    d.banner(addr, title=f"Filename: {file_name}",
             description=f"The name of {file_name}, {start}, CR-terminated.")
    d.stringcr(addr)
    d.comment(addr, f"\"{file_name}\" and a CR", align=INLINE)
for addr, length in [(0x2149, 7), (0x2159, 7)]:
    d.banner(addr, title="Unused", description="Leftover bytes.")
    d.byte(addr, length)
    d.comment(addr, "Not referenced", align=INLINE)

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
