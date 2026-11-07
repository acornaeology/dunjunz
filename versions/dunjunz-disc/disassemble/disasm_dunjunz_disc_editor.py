"""dasmos driver for *EDITOR (`Editor`, &1910, exec &239D), the Model B
side's level editor.

The same program as the Master 128 side's Editor, and annotated by the
same code (dunjunz_common/editor.py): it reads the screen's row offsets
from MOS 1.20 and resets through MOS 1.20's reset entry, where the Master
side's loads Table into private RAM and uses MOS 3.20's. The bytes after
`catalogue` are a leftover copy of its end.
"""

import os
import sys
from pathlib import Path

import dasmos

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
REPO_DIRPATH = VERSION_DIRPATH.parent.parent
sys.path.insert(0, str(REPO_DIRPATH))

from dunjunz_common import editor  # noqa: E402
from dunjunz_common.annotator import Annotator  # noqa: E402

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-disc-editor.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-disc-editor.json"))

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "Editor", 0x1910, name="Editor", exec_addr=0x239D)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")

editor.annotate(d, model_b=True)

main = Annotator(d, "disc", lambda addr: [(None, "")])
main.banner(0x23E8, "Unused",
            "Leftover bytes: &FF, then a stale copy of the end of catalogue "
            "(new line, choose disc or tape, new line, *CAT, new line, ask "
            "for the level number again) assembled at other addresses.")
main.byte(0x23E8, 0x2400 - 0x23E8, cols=8)
main.c(0x23E8, "Not used")
main.byte(0x25FF, 1)
main.c(0x25FF, "Not referenced on this side (the Master's table_loaded_flag)")

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
