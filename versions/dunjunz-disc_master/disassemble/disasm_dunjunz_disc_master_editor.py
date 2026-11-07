"""dasmos driver for *EDITOR (`Editor`, &1910, exec &23B2), the Master 128
side's level editor.

*EDITOR copies its sprite plotter page to &0900 and starts. It loads a
level file at &2700 (or starts an empty one), decrypts it, and unpacks it
into its own tables: up to 80 items in slots at &0C00 (x), &0C60 (y) and
&0CB0 (the item's editor sprite), the wall map at &2F00, the object-free
map at &7E00, and the door-key links at &2EA0/&2EC0. The map is drawn in
MODE 2, two screen bytes by five pixel rows per cell, and edited with a
cursor. On saving, the tables are packed back into the level file at
&2700, a wall block is chosen from the 24 in Stones, the level's unused
first byte is set so that its sum matches the game's checksum table, and
the level is encrypted and saved.

Two routines run from the game's workspace at &7B00 and &7D80, and the
plotter page runs at &0900; the annotations model all three copies as
moves. They are shared with the Model B side's Editor, in
dunjunz_common/editor.py.
"""

import os
import sys
from pathlib import Path

import dasmos

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
REPO_DIRPATH = VERSION_DIRPATH.parent.parent
sys.path.insert(0, str(REPO_DIRPATH))

from dunjunz_common import editor  # noqa: E402

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-disc_master-editor.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-disc_master-editor.json"))

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "Editor", 0x1910, name="Editor", exec_addr=0x23B2)
d.use_environment("acorn_mos")
d.use_environment("acorn_master_hardware")

editor.annotate(d)

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
