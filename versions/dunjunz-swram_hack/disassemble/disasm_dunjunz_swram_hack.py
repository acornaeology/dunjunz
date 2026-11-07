"""dasmos driver for the Dunjunz game code.

The resident game is four DFS files that the DUNK loader places at their
load addresses before jumping to the entry point at &0D31:

    Dunjun4  &0400-&0CFF
    Dunjun7  &0D00-&10FF   (loaded at &3000 and copied to &0D00)
    Dunjun5  &1100-&2FFF
    Dunjun6  &6E80-&7FFF

They are disassembled together as one memory image so that references
between files are traced and labelled directly. The listing saves each
file separately, and fantasm verifies each one against its original.
"""

import os
import sys
from pathlib import Path

import dasmos
from dasmos.expr import hexlit, hi, lo, sym

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
REPO_DIRPATH = VERSION_DIRPATH.parent.parent
sys.path.insert(0, str(REPO_DIRPATH))

from dunjunz_common import game  # noqa: E402
from dunjunz_common.annotator import Annotator  # noqa: E402

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-swram_hack.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-swram_hack.json"))

# (DFS name, load address, length), in address order.
GAME_FILES = [
    ("Dunjun4", 0x0400, 0x0900),
    ("Dunjun7", 0x0D00, 0x0400),
    ("Dunjun5", 0x1100, 0x1F00),
    ("Dunjun6", 0x6E80, 0x1180),
]

GAME_ENTRY = 0x0D31

d = dasmos.Disassembler.create(cpu="6502")
for name, addr, length in GAME_FILES:
    d.load(BINARY_DIRPATH / name, addr, name=name, exec_addr=addr)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")


annotator = Annotator(d, "swr")
game.annotate(annotator)
game.annotate_game_entry(annotator)
game.annotate_level_check(annotator)
game.annotate_start_level(annotator)
game.annotate_level_end(annotator)
game.annotate_cassette_pause(annotator)
game.annotate_cassette_continuations(annotator)
game.annotate_hack_continuations(annotator)
game.annotate_menu_tables(annotator, 0x06F8)
game.declare_boot_osfile_block(d)
game.annotate_page7_leftovers(annotator, "*SAVE Dunjunz.K 400 7FF 740")
game.annotate_boot_loader(annotator, stored_call=0xF27D, operand_note=(" The JSR's stored operand is &F27D, the MOS 1.20 FILEV handler for the cassette and ROM filing systems, so the image was saved after this loader had run with one of them selected."))
game.annotate_cassette_level_loop(annotator)

# ---------------------------------------------------------------------------
# Specific to the sideways RAM hack: loading a level from ROMFS.

annotator.label(0x16D0, "level_filename", length=8, description=(
    "The level's filename, \"LEVEL\" followed by the level number and a "
    "carriage return, written by level_loop."))
annotator.region(0x6E60, "level_osfile_block", (0, 17), group="screen_workspace",
                description=(
                    "OSFILE parameter block for loading the level, built in "
                    "screen memory below Dunjun6."))
annotator.expr(0x149B, hexlit(0x3000))  # patched with FILEV before the call
annotator.region(0x149B, "filev_call_address", (0, 1), description=(
    "Operand of the JSR at load_level_call, set to the contents of FILEV."))
annotator.sub(0x1446, "load_level", "Load the level file",
              "Show 23 character rows while loading, then load the file named "
              "in level_filename at &6B00 by calling the filing system's FILEV "
              "routine directly with an OSFILE block, and finally decrypt and "
              "check it. The block's byte 6 (the exec address's low byte, "
              "which must be 0 for the load address to be used) is not set "
              "here: it relies on show_level_number having cleared the screen, "
              "which the block lies in.",
               on_exit={"A": "corrupted", "X": "corrupted", "Y": "corrupted"})
for addr, text in [
    (0x1446, "VDU 23,0,6,23,0,0,0,0,0,0: set 6845 register 6..."),
    (0x1450, "...register 6, rows displayed..."),
    (0x1455, "...to 23 character rows displayed"),
    (0x145A, "...then six zeros to finish the command"),
    (0x146E, "X, Y = address of the OSFILE block"),
    (0x1470, "...high byte"),
    (0x1472, "Filename address = level_filename..."),
    (0x1474, "...low byte..."),
    (0x1477, "...high byte..."),
    (0x1479, "...in the block's first two bytes"),
    (0x147C, "Load address = &00006B00..."),
    (0x147E, "...byte 0 is 0..."),
    (0x1481, "...byte 2 is 0..."),
    (0x1484, "...byte 3 is 0..."),
    (0x1487, "...byte 1 is &6B..."),
    (0x1489, "...completing &00006B00"),
    (0x148C, "Copy FILEV into the operand of the JSR below..."),
    (0x148F, "...low byte"),
    (0x1492, "...high byte"),
    (0x1495, "...so the JSR goes straight to the filing system"),
    (0x1498, "A = &FF: load the file"),
    (0x149A, "Call the filing system's OSFILE routine directly"),
    (0x149D, "Decrypt and check the level, and return from there"),
]:
    annotator.c(addr, text)
annotator.label(0x149A, "load_level_call")

for lo_addr, hi_addr, name in [(0x146F, 0x1471, "level_osfile_block"),
                               (0x1473, 0x1478, "level_filename")]:
    annotator.expr(lo_addr, lo(sym(name)))
    annotator.expr(hi_addr, hi(sym(name)))
annotator.expr(0x1488, hi(sym("level_object_x")))  # the level file's page, &6B

annotator.c(0x0D6E, "Not referenced")  # after game_entry
annotator.c(0x0772, "Not referenced")
annotator.c(0x07F8, "Not referenced")

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
