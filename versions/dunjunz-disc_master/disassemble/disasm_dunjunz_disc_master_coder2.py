"""dasmos driver for `Coder2` (&2000), the Master 128 side's joystick
installer, which *DUNJUNZ runs instead of `Coder` when a joystick is
present: it loads `Code` into private RAM, points BYTEV at it and runs
`Coder`.
"""

import os
import sys
from pathlib import Path

import dasmos
from dasmos.expr import sym

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
REPO_DIRPATH = VERSION_DIRPATH.parent.parent
sys.path.insert(0, str(REPO_DIRPATH))

from dunjunz_common.annotator import Annotator  # noqa: E402

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-disc_master-coder2.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-disc_master-coder2.json"))

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "Coder2", 0x2000, name="Coder2", exec_addr=0x2000)
d.use_environment("acorn_mos")
d.use_environment("acorn_master_hardware")


def comments(a, pairs):
    for addr, text in pairs:
        a.c(addr, text)


# ---------------------------------------------------------------------------
# Coder2: install the joystick handler, then run Coder.
#
# The OSCLI that runs *CODER never returns; the command strings follow it.

coder2 = Annotator(d, "disc_master", lambda addr: [(None, "")],
                   default_group=lambda addr: "loader")
coder2.sub(0x2000, "coder2_start", "Coder2: install the joystick handler and run Coder",
           "Run by *DUNJUNZ when a joystick is present. *L. Code loads the "
           "joystick handler into private RAM at &C500, BYTEV is pointed at "
           "it, and *CODER is run, which does not return.")
comments(coder2, [
    (0x2000, "*L. Code: load the joystick handler at &C500"),
    (0x2002, "..."), (0x2004, "..."),
    (0x2007, "BYTEV = &C500, the joystick handler..."),
    (0x2009, "..."), (0x200C, "..."), (0x200E, "..."),
    (0x2011, "*CODER: load and start the game (no return)"),
    (0x2013, "..."), (0x2015, "..."),
])
coder2.label(0x2018, "load_code_command")
coder2.string(0x2018, 7)
coder2.byte(0x201F)
coder2.label(0x2020, "coder_command2")
coder2.string(0x2020, 5)
coder2.byte(0x2025)

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
