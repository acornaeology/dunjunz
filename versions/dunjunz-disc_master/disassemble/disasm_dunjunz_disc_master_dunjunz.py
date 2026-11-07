"""dasmos driver for *DUNJUNZ (`Dunjunz`, &2649), the Master 128 side's
loader and title screen.

BOOT runs it after showing README. It loads `Code2`, `Code3` and `Table` into the
Master's private RAM (HAZEL), loads and shows the title screen with its
twinkling stars, and runs the game's loader `Coder`, through `Coder2` when
a joystick is present. It is the Model B side's `Dunjunz` (load &26C0)
with &2649-&26BF added in front and four bytes changed; the annotations
are shared with it, in dunjunz_common/title_loader.py.
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

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-disc_master-dunjunz.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-disc_master-dunjunz.json"))

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "Dunjunz", 0x2649, name="Dunjunz", exec_addr=0x2649)
d.use_environment("acorn_mos")
d.use_environment("acorn_master_hardware")


title_loader.annotate(d)

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
