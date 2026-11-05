"""dasmos driver for the game code of Ole's crack of the Dunjunz cassette.

The crack's loader DUNJ loads two code files and runs the second:

    DUNJ3  load &6E80  &2E80 bytes: code for &6E80-&7FFF; the bytes past
                       &7FFF fall in the sideways ROM area and never reach RAM
    DUNJ4  load &2400  exec &5000: the game's &0400-&2FFF image, stored
                       &2000 higher, followed by a short start-up routine at
                       &5000 that copies it down and starts the game

Both files are disassembled together. DUNJ4's game image is disassembled
at its run address, &0400, and its start-up code at &5000; before saving,
the listing copies the assembled image up to &2400, where the file stores
it. (Modelling the image as a dasmos move instead trips over the overlap
between &0400-&2FFF and &2400-&4FFF: acornaeology/dasmos#51, #52.)
"""

import os
import sys
import tempfile
from pathlib import Path

import dasmos

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
REPO_DIRPATH = VERSION_DIRPATH.parent.parent
sys.path.insert(0, str(REPO_DIRPATH))

from dunjunz_common.rendering import MultiFileBeebasmRenderer, SavedFile  # noqa: E402

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-tape.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-tape.json"))

SAVED_FILES = [
    SavedFile("DUNJ4", start=0x2400, end=0x5050, exec_addr=0x5000, load_addr=0x2400),
    SavedFile("DUNJ3", start=0x6E80, end=0x9D00, exec_addr=0x0000, load_addr=0x6E80),
]

# DUNJ4 = the &0400-&2FFF image (stored at &2400) + start-up code at &5000.
IMAGE_RUN_ADDR, IMAGE_STORED_ADDR, IMAGE_LENGTH = 0x0400, 0x2400, 0x2C00
START_UP_ADDR = IMAGE_STORED_ADDR + IMAGE_LENGTH

d = dasmos.Disassembler.create(cpu="6502")
dunj4 = (BINARY_DIRPATH / "DUNJ4").read_bytes()
with tempfile.TemporaryDirectory(prefix="dunjunz-tape-") as split_dirname:
    split_dirpath = Path(split_dirname)
    (split_dirpath / "image").write_bytes(dunj4[:IMAGE_LENGTH])
    (split_dirpath / "start_up").write_bytes(dunj4[IMAGE_LENGTH:])
    d.load(split_dirpath / "image", IMAGE_RUN_ADDR)
    d.load(split_dirpath / "start_up", START_UP_ADDR)
d.load(BINARY_DIRPATH / "DUNJ3", 0x6E80)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")

d.entry(0x5000, "start")
d.entry(0x7F8F, "wrch_handler")

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render(MultiFileBeebasmRenderer(
    SAVED_FILES,
    pre_save_lines=[
        "",
        "; DUNJ4 stores the game image &2000 above its run address.",
        f"copyblock &{IMAGE_RUN_ADDR:04x}, &{IMAGE_RUN_ADDR + IMAGE_LENGTH:04x}, &{IMAGE_STORED_ADDR:04x}",
    ],
))), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
