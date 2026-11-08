"""dasmos driver for `TITLE` (&3800, exec &38C6), the sideways RAM hack's
title page.

The BASIC program `DUNJUNZ` runs it with `*/TITLE` after the intro. It
selects MODE 5, stripes the screen, copies the Bug-Byte logo picture it
carries into character rows 1-8, prints the credits and the keys, and waits
up to 7.67 seconds for a key before returning to BASIC, which chains `DUNK`.
"""

import os
import sys
from pathlib import Path

import dasmos

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(VERSION_DIRPATH.parent.parent))

from dunjunz_common import title_page  # noqa: E402

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-swram_hack-title.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-swram_hack-title.json"))

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "TITLE", 0x3800, name="TITLE", exec_addr=0x38C6)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")

title_page.annotate(d, 0x3800, title_page.HACK)

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
