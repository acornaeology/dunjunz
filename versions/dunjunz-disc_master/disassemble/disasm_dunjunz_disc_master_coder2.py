"""dasmos driver for `Coder2` (&2000), the Master 128 side's joystick
installer, which *DUNJUNZ runs instead of `Coder` when a joystick is
present: it loads `Code` into private RAM, points BYTEV at it and runs
`Coder`.
"""

import os
import sys
from pathlib import Path

import dasmos
from dasmos.expr import hi, lo, sym

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
           "it, and *CODER is run, which does not return. From then on every "
           "OSBYTE call passes through the handler, which answers the "
           "game's INKEY scans of one hero's movement and fire keys from "
           "the joystick and passes every other call on to the MOS. "
           "BYTEV's old value is not saved: the handler passes calls on "
           "through a fixed address.")
comments(coder2, [
    (0x2000, "*L. Code: load the joystick handler at &C500"),
    (0x2002, "...(X, Y) = the command line"), (0x2004, "...loaded into HAZEL, which MOS 3.20 leaves paged in"),
    (0x2007, "Point BYTEV at the handler, so every OSBYTE..."),
    (0x2009, "...goes through it first..."), (0x200C, "...(the handler's page)..."), (0x200E, "...and INKEY scans for the hero's keys read the stick"),
    (0x2011, "*CODER: load and start the game"),
    (0x2013, "...(X, Y) = the command line"), (0x2015, "...never returns: the game takes over the machine"),
])
coder2.label(0x2018, "load_code_command")
coder2.stringcr(0x2018)
coder2.label(0x2020, "coder_command")
coder2.stringcr(0x2020)

coder2.label(0xC500, "joystick_handler", group="private_ram", description=(
    "Code's joystick handler in private RAM (HAZEL), which BYTEV is "
    "pointed at."))
for lo_addr, hi_addr, name in [(0x2001, 0x2003, "load_code_command"),
                               (0x2008, 0x200D, "joystick_handler"),
                               (0x2012, 0x2014, "coder_command")]:
    d.expr(lo_addr, lo(sym(name)))
    d.expr(hi_addr, hi(sym(name)))

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
