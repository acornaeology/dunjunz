"""dasmos driver for `EXPAND` (&2E00), the compressed-picture unpacker on
Ole's crack of the cassette ("(C) 1985 Rhys E. Davies").

`PLOAD` runs it as *EXPAND GIRL1 in MODE 2. It loads the named file so
that it ends at &8000, the top of screen memory, and unpacks it run by
run from &3000 upwards until the screen is full. Each packed byte holds a
screen byte in its low six bits and a run length in its top two: 0-2 mean
a run of 1-3, and 3 means the next byte holds the run length less one.
"""

import os
from pathlib import Path

import dasmos
from dasmos import Align
from dasmos.expr import hi, lo, sym

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-tape_crack_ole-expand.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-tape_crack_ole-expand.json"))

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "EXPAND", 0x2E00, name="EXPAND", exec_addr=0x2E00)
d.use_environment("acorn_mos")


def comments(pairs):
    for addr, text in pairs:
        d.comment(addr, text, align=Align.INLINE)


# ---------------------------------------------------------------------------
# Workspace

d.index_region(0x0080, "packed_ptr", window=(0, 1), group="zero_page")
d.index_region(0x0082, "screen_ptr", window=(0, 1), group="zero_page")
d.index_region(0x0084, "command_ptr", window=(0, 3), group="zero_page")
d.index_region(0x0C00, "osfile_block", window=(0, 0x11), group="expand_workspace")

# ---------------------------------------------------------------------------
# Header

d.subroutine(0x2E00, "expand_start", title="EXPAND: unpack a compressed MODE 2 picture",
             description="*EXPAND <filename>. Entered at the load address, "
             "which jumps over the copyright notice.")
comments([(0x2E00, "Skip the copyright notice"),
          (0x2E03, "The author's copyright")])
d.label(0x2E03, "copyright_notice")
d.string(0x2E03, 24)
d.banner(0x2E03, title="Copyright notice")

# ---------------------------------------------------------------------------
# skip_separators

d.subroutine(0x2E1B, "skip_separators",
             title="Find the next argument on the command line",
             description="Step command_ptr past spaces and commas. A carriage "
             "return (the end of the line) is left for the next call.",
             on_exit={"C": "set if the line has no more arguments; clear if "
                      "command_ptr is one past the argument's first character"})
comments([
    (0x2E1B, "Y = 0 throughout: command_ptr itself advances"),
    (0x2E1D, "Read the next character of the command line"),
    (0x2E1F, "Advance command_ptr past it..."),
    (0x2E21, "..."), (0x2E23, "..."),
    (0x2E25, "Skip spaces"),
    (0x2E27, "..."),
    (0x2E29, "Skip commas"),
    (0x2E2B, "..."),
    (0x2E2D, "The end of the line?"),
    (0x2E2F, "No: an argument starts here"),
    (0x2E31, "Step command_ptr back onto the carriage return..."),
    (0x2E33, "..."), (0x2E35, "..."), (0x2E37, "..."), (0x2E39, "..."),
    (0x2E3B, "Carry set: no argument"),
    (0x2E3C, "Return"),
    (0x2E3D, "Carry clear: an argument found"),
    (0x2E3E, "Return"),
])
d.label(0x2E1D, "skip_separators_loop")
d.label(0x2E3B, "no_argument")
d.label(0x2E3D, "argument_found")
d.label(0x2E25, "check_separator")

# ---------------------------------------------------------------------------
# expand: the command

d.subroutine(0x2E3F, "expand",
             title="Load the named picture and unpack it onto the screen",
             description="Refuses to run outside MODE 2. Finds the filename "
             "on the command line, opens the file to learn its length, and "
             "loads it so that it ends at &8000, with all sixteen logical "
             "colours black so that neither the packed bytes nor the "
             "unpacking show. Unpacks it from &3000 until the screen is full, "
             "restores the zero page and page &0C bytes it used, and resets "
             "the palette (VDU 20) to reveal the picture.")
comments([
    (0x2E3F, "Read the screen mode into Y"),
    (0x2E41, "..."),
    (0x2E44, "MODE 2?"),
    (0x2E46, "Yes: carry on"),
    (0x2E48, "No: error 25, \"Bad Mode\""),
    (0x2E49, "Error number 25 (BASIC's own \"Bad MODE\" number)"),
    (0x2E4A, "Error message"),
    (0x2E52, "End of the message"),
    (0x2E53, "Save the four zero-page bytes OSARGS will overwrite..."),
    (0x2E55, "..."), (0x2E56, "..."), (0x2E58, "..."), (0x2E59, "..."),
    (0x2E5B, "..."), (0x2E5C, "..."), (0x2E5E, "..."),
    (0x2E5F, "OSARGS 1: command_ptr = the address of the command line "
              "after \"EXPAND\"..."),
    (0x2E61, "..."), (0x2E63, "..."), (0x2E65, "..."),
    (0x2E68, "Find the filename"),
    (0x2E6B, "Found: open it"),
    (0x2E6D, "None: restore command_ptr..."),
    (0x2E6E, "..."), (0x2E70, "..."), (0x2E71, "..."), (0x2E73, "..."),
    (0x2E74, "..."), (0x2E76, "..."), (0x2E77, "..."),
    (0x2E79, "...and give error 0, \"Filename expected\""),
    (0x2E7A, "Error number 0"),
    (0x2E7B, "Error message"),
    (0x2E8C, "End of the message"),
    (0x2E8D, "Step command_ptr back one, onto the filename's first "
              "character..."),
    (0x2E8F, "..."), (0x2E91, "..."), (0x2E92, "..."), (0x2E94, "..."),
    (0x2E96, "..."), (0x2E97, "..."), (0x2E99, "..."),
    (0x2E9B, "Open the file for input (X, Y = the filename)"),
    (0x2E9D, "..."),
    (0x2EA0, "Y = the file handle"),
    (0x2EA1, "Opened: go on"),
    (0x2EA3, "Not found: restore command_ptr..."),
    (0x2EA4, "..."), (0x2EA6, "..."), (0x2EA7, "..."), (0x2EA9, "..."),
    (0x2EAA, "..."), (0x2EAC, "..."), (0x2EAD, "..."),
    (0x2EAF, "...and give error 0, \"No such compressed picture\""),
    (0x2EB0, "Error number 0"),
    (0x2EB1, "Error message"),
    (0x2ECB, "End of the message"),
    (0x2ECC, "For each of the 18 bytes of the OSFILE block at &0C00, "
              "last first:"),
    (0x2ECE, "Save the byte already there"),
    (0x2ED1, "..."),
    (0x2ED2, "Replace it with the template's"),
    (0x2ED5, "..."),
    (0x2ED8, "Next byte"),
    (0x2ED9, "..."),
    (0x2EDB, "Point the block at the filename..."),
    (0x2EDD, "..."), (0x2EE0, "..."), (0x2EE2, "..."),
    (0x2EE5, "Save the four zero-page bytes OSARGS will overwrite..."),
    (0x2EE7, "..."), (0x2EE8, "..."), (0x2EEA, "..."), (0x2EEB, "..."),
    (0x2EED, "..."), (0x2EEE, "..."), (0x2EF0, "..."),
    (0x2EF1, "OSARGS 2 (Y = the handle): packed_ptr = the file's length "
              "(EXT#)..."),
    (0x2EF3, "..."), (0x2EF5, "..."),
    (0x2EF8, "Load address = &8000 - length, so that the file ends at the "
              "top of screen memory..."),
    (0x2EFA, "..."), (0x2EFB, "..."), (0x2EFD, "..."),
    (0x2F00, "...and keep it on the stack"),
    (0x2F01, "..."), (0x2F03, "..."), (0x2F05, "..."), (0x2F08, "..."),
    (0x2F09, "Close the file (Y = its handle)"),
    (0x2F0B, "..."),
    (0x2F0E, "For logical colours 15 down to 0:"),
    (0x2F10, "VDU 19,colour,0,0,0,0: make it black..."),
    (0x2F12, "..."), (0x2F15, "..."), (0x2F16, "..."), (0x2F19, "..."),
    (0x2F1B, "..."), (0x2F1D, "..."), (0x2F20, "..."), (0x2F21, "..."),
    (0x2F23, "Next colour"),
    (0x2F24, "..."),
    (0x2F26, "Load the file at its load address in the block (exec byte "
              "0: use the block's address)..."),
    (0x2F28, "..."), (0x2F2A, "..."), (0x2F2C, "..."),
    (0x2F2F, "packed_ptr = the load address, the first packed byte..."),
    (0x2F30, "..."), (0x2F32, "..."), (0x2F33, "..."),
    (0x2F35, "screen_ptr = &3000, the start of the MODE 2 screen; Y = 0 "
              "throughout..."),
    (0x2F37, "..."), (0x2F38, "..."), (0x2F3A, "..."), (0x2F3C, "..."),
    (0x2F3E, "Read a packed byte"),
    (0x2F41, "Keep it"),
    (0x2F42, "Top two bits: the run length code..."),
    (0x2F44, "...moved down to bits 1-0 (through the carry)"),
    (0x2F45, "..."), (0x2F46, "..."), (0x2F47, "..."),
    (0x2F48, "Code 3?"),
    (0x2F4A, "No: the run is the code + 1 bytes"),
    (0x2F4C, "Yes: the run is the next byte + 1 (0 = 256)"),
    (0x2F4F, "X = the run length..."),
    (0x2F50, "..."),
    (0x2F51, "A = the screen byte, the low six bits (so each pixel is one "
              "of colours 0-7)"),
    (0x2F52, "..."),
    (0x2F54, "Write it to the screen"),
    (0x2F56, "Advance screen_ptr..."),
    (0x2F58, "..."), (0x2F5A, "..."),
    (0x2F5C, "Reached &8000: the screen is full"),
    (0x2F5E, "Count down the run"),
    (0x2F5F, "..."),
    (0x2F61, "Next packed byte"),
    (0x2F64, "Restore the zero-page bytes..."),
    (0x2F65, "..."), (0x2F67, "..."), (0x2F68, "..."), (0x2F6A, "..."),
    (0x2F6B, "..."), (0x2F6D, "..."), (0x2F6E, "..."),
    (0x2F70, "Restore the 18 bytes at &0C00..."),
    (0x2F72, "..."), (0x2F73, "..."), (0x2F76, "..."), (0x2F77, "..."),
    (0x2F79, "..."),
    (0x2F7B, "Restore command_ptr..."),
    (0x2F7C, "..."), (0x2F7E, "..."), (0x2F7F, "..."), (0x2F81, "..."),
    (0x2F82, "..."), (0x2F84, "..."), (0x2F85, "..."),
    (0x2F87, "VDU 20: restore the default colours, revealing the "
              "picture, and return"),
    (0x2F89, "..."),
])
d.label(0x2E53, "mode_ok")
d.label(0x2E4A, "bad_mode_message")
d.label(0x2E7B, "filename_expected_message")
d.label(0x2E8D, "open_picture")
d.label(0x2E97, "filename_found")
d.label(0x2EB1, "no_such_picture_message")
d.label(0x2ECC, "load_picture")
d.label(0x2ECE, "set_up_osfile_block")
d.label(0x2F10, "blacken_colours")
d.label(0x2F1D, "send_zeros")
d.label(0x2F3E, "unpack_run")
d.label(0x2F4F, "run_length_known")
d.label(0x2F54, "write_run")
d.label(0x2F5E, "next_in_run")
d.label(0x2F64, "unpacked")
d.label(0x2F72, "restore_osfile_block")
d.expr(0x2E62, sym("command_ptr"))
d.expr(0x2EF2, sym("packed_ptr"))
d.expr(0x2F29, lo(sym("osfile_block")))
d.expr(0x2F2B, hi(sym("osfile_block")))

# ---------------------------------------------------------------------------
# read_packed_byte

d.subroutine(0x2F8C, "read_packed_byte", title="Read the next packed byte",
             on_entry={"Y": "0"},
             on_exit={"A": "the byte at packed_ptr, which advances past it"})
comments([
    (0x2F8C, "Read the byte"),
    (0x2F8E, "Advance packed_ptr..."),
    (0x2F90, "..."), (0x2F92, "..."),
    (0x2F94, "Return"),
])
d.label(0x2F94, "read_packed_byte_done")

# ---------------------------------------------------------------------------
# OSFILE block template

d.label(0x2F95, "osfile_block_template")
d.banner(0x2F95, title="OSFILE block template",
         description="Copied to &0C00. The filename address (+0) and the "
         "low half of the load address (+2) are filled in; the high half, "
         "&FFFF, loads into the I/O processor, and exec address byte 0 (+6) "
         "tells OSFILE to use this load address. The start and end "
         "addresses (+10, +14) are unused by a load.")
d.byte(0x2F95, 2)
d.byte(0x2F97, 4)
d.byte(0x2F9B, 4)
d.byte(0x2F9F, 4)
d.byte(0x2FA3, 4)
comments([
    (0x2F95, "+0 filename address (filled in)"),
    (0x2F97, "+2 load address (low half filled in)"),
    (0x2F9B, "+6 exec address: low byte 0 means load at +2"),
    (0x2F9F, "+10 start address (unused)"),
    (0x2FA3, "+14 end address (unused)"),
])

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
