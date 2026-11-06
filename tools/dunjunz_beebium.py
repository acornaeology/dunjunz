"""Shared helpers for running Dunjunz in beebium.

The disc needs sideways RAM for its ROMFS level images, so the machine is the
ROM/RAM-board Model B with RAM configured in slots 4 and 5 (the variant must be
given with the preset, or the server refuses to start).
"""

from contextlib import contextmanager
from pathlib import Path

from beebium.client import Beebium
from beebium.client.sideways import SlotType

REPO_DIRPATH = Path(__file__).resolve().parent.parent
DISC_FILEPATH = REPO_DIRPATH / "versions" / "dunjunz-swram_hack" / "Disc060-DunjunzRx2.ssd"
GAME_ENTRY = 0x0D31

# Keyboard matrix (row, column) of each player's controls, from the controls
# screen stored in DUNJUNZ at &3700: up, down, left, right, fire, magic.
PLAYER_KEYS = {
    1: {"up": (4, 0), "down": (5, 0), "left": (0, 0), "right": (6, 1), "fire": (6, 0), "magic": (0, 1)},
    2: {"up": (7, 9), "down": (3, 9), "left": (5, 9), "right": (6, 9), "fire": (2, 9), "magic": (4, 9)},
    3: {"up": (4, 6), "down": (6, 6), "left": (6, 7), "right": (6, 8), "fire": (6, 2), "magic": (1, 7)},
    4: {"up": (5, 3), "down": (6, 4), "left": (3, 5), "right": (2, 5), "fire": (3, 6)},
}


@contextmanager
def launched_machine(speed_multiplier: float = 0.0):
    """A beebium Model B with sideways RAM in slots 4 and 5."""
    with Beebium.launch(variant="model-b-romram", preset="model-b-romram-disc") as bbc:
        bbc.system.set_speed_multiplier(speed_multiplier)
        for slot in (4, 5):
            bbc.sideways.configure_slot(slot, SlotType.RAM)
        yield bbc


def boot_to(bbc, stop_address: int = GAME_ENTRY, max_seconds: float = 200.0) -> bool:
    """Boot the disc and tap SPACE through the BASIC until the PC reaches
    `stop_address`. Leaves the machine stopped there; returns whether it got
    there."""
    bbc.boot_disc(DISC_FILEPATH)
    bp = bbc.debugger.add_breakpoint(stop_address)
    try:
        for _ in range(int(max_seconds / 0.5)):
            bbc.run_for_emulated_seconds(0.5)
            if bbc.cpu.pc == stop_address:
                return True
            bbc.debugger.run()
            bbc.keyboard.press_space()
        return False
    finally:
        bp.remove()
