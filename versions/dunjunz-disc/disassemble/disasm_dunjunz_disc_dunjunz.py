"""dasmos driver for `Dunjunz` (load &26C0, exec &2700), the Model B
side's loader and title screen.

This side has no !BOOT. Booted on a Model B, the other side's BOOT asks
for the disc to be turned over and runs *DUNJUNZ, which is this file; the
game's game-over intercept runs it again. It sets up page &08 for Coder
and the game, points the BREAK intercept at the game's next-level
intercept, loads and shows the title screen with its twinkling stars,
then arms the intercept and runs `Coder`. The Master 128 side's
`*DUNJUNZ` is this program with a prefix added and four bytes changed;
the annotations are shared with it, in dunjunz_common/title_loader.py.
"""

import os
import sys
from pathlib import Path

import dasmos

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
REPO_DIRPATH = VERSION_DIRPATH.parent.parent
sys.path.insert(0, str(REPO_DIRPATH))

from dunjunz_common import title_loader  # noqa: E402

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-disc-dunjunz.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-disc-dunjunz.json"))

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "Dunjunz", 0x26C0, name="Dunjunz", exec_addr=0x2700)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")

title_loader.annotate(d, model_b=True)

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
