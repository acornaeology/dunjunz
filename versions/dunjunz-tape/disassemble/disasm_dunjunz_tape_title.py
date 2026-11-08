"""dasmos driver for `TITLE` (&2800, exec &28CE), the cassette's title
page.

`PLOAD` runs it with `*/` after the intro. It selects MODE 5, stripes the
screen, copies the Bug-Byte logo picture it carries into character rows
1-8, prints the credits and a note to see the inlay card, then selects
the cassette filing system and runs the next file on the tape, `DUNK`.
"""

import os
import sys
from pathlib import Path

import dasmos
from dasmos.expr import hi, lo, sym

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(VERSION_DIRPATH.parent.parent))

from dunjunz_common import title_page  # noqa: E402

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-tape-title.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-tape-title.json"))

BASE = 0x2800
EXEC_ADDR = 0x28CE

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "TITLE", BASE, name="TITLE", exec_addr=EXEC_ADDR)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")

title_page.annotate(d, BASE, title_page.CASSETTE)

for lo_addr, hi_addr, name in [(0x2975, 0x2977, "tape_command"),
                               (0x297C, 0x297E, "run_command")]:
    d.expr(lo_addr, lo(sym(name)))
    d.expr(hi_addr, hi(sym(name)))

d.label(EXEC_ADDR, "title_entry")
d.comment(EXEC_ADDR, title_page.CASSETTE_ENTRY_NOTE)

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
