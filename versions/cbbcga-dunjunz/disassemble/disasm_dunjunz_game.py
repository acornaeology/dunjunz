"""dasmos driver for the Dunjunz game code.

The resident game is four DFS files that the DUNK loader places at their
load addresses before jumping to the entry point at &0D31:

    Dunjun4  &0400-&0CFF
    Dunjun7  &0D00-&10FF   (loaded at &3000 and copied to &0D00)
    Dunjun5  &1100-&2FFF
    Dunjun6  &6E80-&7FFF

They are disassembled together as one memory image so that references
between files are traced and labelled directly. The listing saves each
file separately, and fantasm verifies each one against its original.
"""

import os
from pathlib import Path

import dasmos
from dasmos.ext.renderers.beebasm.renderer import BeebasmRenderer

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-game.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-game.json"))

# (DFS name, load address, length), in address order.
GAME_FILES = [
    ("Dunjun4", 0x0400, 0x0900),
    ("Dunjun7", 0x0D00, 0x0400),
    ("Dunjun5", 0x1100, 0x1F00),
    ("Dunjun6", 0x6E80, 0x1180),
]

GAME_ENTRY = 0x0D31


class GameFilesRenderer(BeebasmRenderer):
    """beebasm renderer that saves each game file as its own output.

    The loaded image has a gap (&3000-&6E7F, the screen) between Dunjun5
    and Dunjun6, and each file has its own DFS name and addresses, so a
    single save of the whole loaded range would not reproduce the files.
    """

    def _save_directive(self, load_start, load_end, program=None) -> str:
        return "\n".join(
            f'save "{name}", {self.hex4(addr)}, {self.hex4(addr + length)}, '
            f"{self.hex4(addr)}, {self.hex4(addr)}"
            for name, addr, length in GAME_FILES
        )


d = dasmos.Disassembler.create(cpu="6502")
for name, addr, length in GAME_FILES:
    d.load(BINARY_DIRPATH / name, addr)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")

d.entry(GAME_ENTRY, "game_entry")
# The entry code points WRCHV at &7F8F; the original vector is restored later.
d.entry(0x7F8F, "wrch_handler")

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render(GameFilesRenderer())), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
