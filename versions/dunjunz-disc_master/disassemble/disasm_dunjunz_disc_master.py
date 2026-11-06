"""dasmos driver for the Master 128 side of the official Dunjunz disc.

*DUNJUNZ (`Dunjunz`, &2649) loads the code that lives in the Master's
private RAM (HAZEL, &C000-&DFFF), runs `Coder2`, which installs the
joystick handler and runs `Coder`; Coder's loader at &0740 saves the
MOS's page &0D in HAZEL, loads the game and starts it at &0E00:

    Coder   &0400-&07FE   the game's &0400-&07FF (the loader at &0740)
    Dunj3   &08C0-&0CFE
    Dunj4   &0E00-&1FFF
    Dunj5   &2000-&2FFF
    Dunj2   &6E80-&7FFF
    Code    &C500-&C56B   joystick handler for BYTEV          (HAZEL)
    Table   &C5A0-&C6F7   level 25, game over, row offsets, pause (HAZEL)
    Code2   &C700-&D759   music                               (HAZEL)
    Code3   &D800-&D8FE   copy of the sprite plotter          (HAZEL)

The game stays resident from level to level, as on cassette. The two
loaders, `Dunjunz` (&2649) and `Coder2` (&2000), run where `Dunj5` later
loads. All three are therefore stored at spare addresses in the screen
area and modelled as moves to their run addresses, so that every
annotation at &2000-&2FFF names the file it belongs to; each is saved
with its DFS load address.

MOS 3.20 starts *RUN programs with HAZEL paged in (ACCCON bit 3 set), and
the game never changes ACCCON, so its reads and calls of &C000-&DFFF reach
these files rather than the MOS ROM.
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

BINARY_DIRPATH = VERSION_DIRPATH / "binary"
OUTPUT_DIRPATH = VERSION_DIRPATH / "output"

asm_filepath = Path(os.environ.get("FANTASM_ASM", OUTPUT_DIRPATH / "dunjunz-disc_master.asm"))
json_filepath = Path(os.environ.get("FANTASM_JSON", OUTPUT_DIRPATH / "dunjunz-disc_master.json"))

# (DFS name, load address, exec address), in address order. Each loads
# at its run address.
RESIDENT_FILES = [
    ("Coder", 0x0400, 0x0740),
    ("Dunj3", 0x08C0, 0x08C0),
    ("Dunj4", 0x0E00, 0x0E00),
    ("Dunj2", 0x6E80, 0x6E80),
    ("Code", 0xC500, 0xC500),
    ("Table", 0xC5A0, 0xC5A0),
    ("Code2", 0xC700, 0xC700),
    ("Code3", 0xD800, 0xD800),
]

# (DFS name, stored address, run address, length): the files that run at
# &2000-&2FFF, game first so that it is the default copy there.
MOVED_FILES = [
    ("Dunj5", 0x4000, 0x2000, 0x1000),
    ("Dunjunz", 0x3649, 0x2649, 0x0913),
    ("Coder2", 0x3000, 0x2000, 0x0026),
]

d = dasmos.Disassembler.create(cpu="6502")
for name, addr, exec_addr in RESIDENT_FILES:
    d.load(BINARY_DIRPATH / name, addr, name=name, exec_addr=exec_addr)
moves = {}
for name, stored, run, length in MOVED_FILES:
    d.load(BINARY_DIRPATH / name, stored, name=name, exec_addr=run, reload_addr=run)
    moves[name] = d.add_move(run, stored, length, name=name.lower())
dunj5 = moves["Dunj5"]
d.use_environment("acorn_mos")
d.use_environment("acorn_master_hardware")


# Runtime addresses where the Master game's code differs from the
# cassette-derived game the shared annotations describe. The shared
# annotations skip them, and this driver annotates them itself.
DIFFERENT_RANGES = [
    (0x0481, 0x0484),  # the failed-checksum call: not a reset on a Master
    (0x0700, 0x0800),  # Coder's leftovers and the loader at &0740
    (0x096E, 0x0970),  # row offsets read from Table, not the MOS
    (0x0976, 0x0978),
    (0x0E86, 0x0E8B),  # game over: stop the music
    (0x0EC3, 0x0EC7),  # a shorter wait after game over
    (0x1400, 0x163A),  # starting a level: rewritten for DFS loading
    (0x1ED7, 0x1EF7),  # the pause key, moved to Table
    (0x6F45, 0x6F4A),  # the bell, removed
    (0x7F8F, 0x7F92),  # WRCHV handler: straight to the MOS
]


def differs(addr):
    return any(lo <= addr < hi for lo, hi in DIFFERENT_RANGES)


def placements(addr):
    if 0x2000 <= addr < 0x3000:
        return [(dunj5, "")]
    return [(None, "")]


annotator = Annotator(d, "disc_master", placements, skip=differs)
game.annotate(annotator)
game.annotate_level_check(annotator)
game.annotate_start_level(annotator)
game.annotate_level_end(annotator)
game.annotate_hack_continuations(annotator)
game.annotate_menu_tables(annotator, 0x06F8)
game.annotate_cassette_level_loop(annotator)

ir = d.disassemble()
asm_filepath.parent.mkdir(parents=True, exist_ok=True)
asm_filepath.write_text(str(ir.render("beebasm")), encoding="utf-8")
json_filepath.write_text(str(ir.render("json")), encoding="utf-8")
