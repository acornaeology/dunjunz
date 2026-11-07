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
           "Coder2 is the Master side's joystick installer, 38 bytes at "
           "&2000. *DUNJUNZ's run_coder runs it as *CODER2, in place of "
           "*CODER, when joystick channel 1 reads as a stick at rest; the "
           "display is already blanked and VDU output disabled. The run is "
           "three steps in a straight line: *L. Code loads the joystick "
           "handler into private RAM (HAZEL) at &C500, which MOS 3.20 "
           "leaves paged in; BYTEV is pointed at it; and *CODER loads and "
           "starts the game, and does not return. There is no RTS: the two "
           "command strings follow the last call. "
           "It leaves BYTEV pointing at the handler for the whole game. "
           "Every OSBYTE call then passes through it: INKEY scans of the "
           "Barbarian's (hero 2's) keys N, M, G, B and SPACE are answered "
           "from the joystick's two axes and fire buttons, so the joystick "
           "plays the Barbarian, and every other call goes straight to the "
           "MOS 3.20 OSBYTE routine at &EEB1. BYTEV's old value is not "
           "saved, so anything hooked into BYTEV before is bypassed.")
comments(coder2, [
    (0x2000, "*L. Code: load the joystick handler at &C500"),
    (0x2002, "...(X, Y) = the command line"), (0x2004, "...loaded into HAZEL, which MOS 3.20 leaves paged in"),
    (0x2007, "Point BYTEV at the handler, so every OSBYTE..."),
    (0x2009, "...goes through it first..."), (0x200C, "...(the handler's page)..."), (0x200E, "...and INKEY scans for the hero's keys read the stick"),
    (0x2011, "*CODER: load and start the game"),
    (0x2013, "...(X, Y) = the command line"), (0x2015, "...never returns: the game takes over the machine"),
])
coder2.block(0x2018, "The OSCLI command lines, each ended by a carriage "
             "return.")
coder2.label(0x2018, "load_code_command")
coder2.stringcr(0x2018)
coder2.c(0x2018, "Load the joystick handler at its own &C500")
coder2.label(0x2020, "coder_command")
coder2.stringcr(0x2020)
coder2.c(0x2020, "Run Coder, which loads and starts the game")

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
