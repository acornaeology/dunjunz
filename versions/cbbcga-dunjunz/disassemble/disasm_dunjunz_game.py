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

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
REPO_DIRPATH = VERSION_DIRPATH.parent.parent
sys.path.insert(0, str(REPO_DIRPATH))

from dunjunz_common import game  # noqa: E402
from dunjunz_common.annotator import Annotator  # noqa: E402
from dunjunz_common.rendering import MultiFileBeebasmRenderer, SavedFile  # noqa: E402

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-game.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-game.json"))

# (DFS name, load address, length), in address order.
GAME_FILES = [
    ("Dunjun4", 0x0400, 0x0900),
    ("Dunjun7", 0x0D00, 0x0400),
    ("Dunjun5", 0x1100, 0x1F00),
    ("Dunjun6", 0x6E80, 0x1180),
]

GAME_ENTRY = 0x0D31


SAVED_FILES = [
    SavedFile(name, start=addr, end=addr + length, exec_addr=addr, load_addr=addr)
    for name, addr, length in GAME_FILES
]

d = dasmos.Disassembler.create(cpu="6502")
for name, addr, length in GAME_FILES:
    d.load(BINARY_DIRPATH / name, addr)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")


annotator = Annotator(d, "swr")
game.annotate(annotator)
game.annotate_game_entry(annotator)
game.annotate_level_check(annotator)
game.annotate_start_level(annotator)
game.annotate_level_end(annotator)
game.annotate_menu_tables(annotator, 0x06F8)
game.annotate_cassette_level_loop(annotator)

# ---------------------------------------------------------------------------
# Specific to the sideways RAM hack: loading a level from ROMFS.

annotator.label(0x16D0, "level_filename", length=8, description=(
    "The level's filename, \"LEVEL\" followed by the level number and a "
    "carriage return, written by level_loop."))
annotator.label(0x6E60, "level_osfile_block", length=18, group="screen_workspace",
                description=(
                    "OSFILE parameter block for loading the level, built in "
                    "screen memory below Dunjun6."))
annotator.label(0x149B, "filev_call_address", length=2, description=(
    "Operand of the JSR at load_level_call, set to the contents of FILEV."))
annotator.sub(0x1446, "load_level", "Load the level file",
              "Show 23 character rows while loading, then load the file named "
              "in level_filename at &6B00 by calling the filing system's FILEV "
              "routine directly with an OSFILE block, and finally decrypt and "
              "check it. The block's byte 6 (the exec address's low byte, "
              "which must be 0 for the load address to be used) is not set "
              "here: it relies on show_level_number having cleared the screen, "
              "which the block lies in.")
for addr, text in [
    (0x1446, "VDU 23,0,6,23,0,0,0,0,0,0: set 6845 register 6..."),
    (0x1450, "..."),
    (0x1455, "...to 23 character rows displayed"),
    (0x145A, "..."),
    (0x146E, "X, Y = address of the OSFILE block"),
    (0x1470, "..."),
    (0x1472, "Filename address = level_filename..."),
    (0x1474, "..."),
    (0x1477, "..."),
    (0x1479, "..."),
    (0x147C, "Load address = &00006B00..."),
    (0x147E, "..."),
    (0x1481, "..."),
    (0x1484, "..."),
    (0x1487, "..."),
    (0x1489, "..."),
    (0x148C, "Copy FILEV into the operand of the JSR below..."),
    (0x148F, "..."),
    (0x1492, "..."),
    (0x1495, "..."),
    (0x1498, "A = &FF: load the file"),
    (0x149A, "Call the filing system's OSFILE routine directly"),
    (0x149D, "Decrypt and check the level, and return from there"),
]:
    annotator.c(addr, text)
annotator.label(0x149A, "load_level_call")

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render(MultiFileBeebasmRenderer(SAVED_FILES))), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
