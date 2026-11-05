"""dasmos driver for the game code of the official Dunjunz disc (Model B side).

Coder (&5000) runs at the start of every level: it reloads Dun1, loads the
level, and builds the resident game from Dun1's contents:

    Dun1 &2000-&2FFF   runs in place
    Dun1 &3000-&473F   copied to &08C0-&1FFF
    Dun1 &5000-&59AF   Coder itself, which holds two &0400-&07FF images:
                         &51B0  keyboard only
                         &55B0  with a joystick handler on BYTEV
    Dun1 &6E80-&7FFF   runs in place

The two &0400 images are modelled as moves to the same run address. The
listing saves Dun1 and, from the same bytes, the separate Coder file.
"""

import os
import sys
from pathlib import Path

import dasmos

VERSION_DIRPATH = Path(__file__).resolve().parent.parent
REPO_DIRPATH = VERSION_DIRPATH.parent.parent
sys.path.insert(0, str(REPO_DIRPATH))

from dunjunz_common import game  # noqa: E402
from dunjunz_common.annotator import Annotator  # noqa: E402
from dunjunz_common.rendering import MultiFileBeebasmRenderer, SavedFile  # noqa: E402

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-disc.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-disc.json"))

SAVED_FILES = [
    SavedFile("Dun1", start=0x2000, end=0x8000, exec_addr=0x2000, load_addr=0x2000),
    SavedFile("Coder", start=0x5000, end=0x59B0, exec_addr=0x5000, load_addr=0x5000),
]

d = dasmos.Disassembler.create(cpu="6502")
d.load(BINARY_DIRPATH / "Dun1", 0x2000)
d.use_environment("acorn_mos")
d.use_environment("acorn_model_b_hardware")

game_core = d.add_move(0x08C0, 0x3000, 0x1880, name="game_core")
low_keyboard = d.add_move(0x0400, 0x51B0, 0x0400, name="low_keyboard")
low_joystick = d.add_move(0x0400, 0x55B0, 0x0400, name="low_joystick")

# Routines in the &0400-&07FF images, called from the rest of the game.
# With two images at the same run address, each entry must be declared
# within the move it belongs to.
LOW_ENTRIES = [0x0400, 0x0450, 0x0500, 0x06B0]
for move in (low_keyboard, low_joystick):
    with move:
        for addr in LOW_ENTRIES:
            d.entry(addr)
with low_joystick:
    d.entry(0x0780)  # BYTEV handler installed by Coder in joystick mode

d.entry(0x5000, "coder_start")
d.entry(0x0D31, "game_entry")


def placements(addr):
    """Where runtime address addr lives in Dun1: which move(s), and the
    suffix for labels in each (the joystick image's names end _joy)."""
    if 0x0400 <= addr < 0x0800:
        return [(low_keyboard, ""), (low_joystick, "_joy")]
    if 0x08C0 <= addr < 0x2000:
        return [(game_core, "")]
    return [(None, "")]


game.annotate(Annotator(d, "disc", placements))

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render(MultiFileBeebasmRenderer(SAVED_FILES))), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
