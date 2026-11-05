"""Boot the Dunjunz disc in beebium and snapshot memory at the game entry.

Configures sideways RAM in slots 4 and 5 (where the DUNK loader puts the
ROMFS level images), boots the disc with SHIFT-BREAK, taps SPACE through the
instruction pages and intro, and stops when the PC reaches the game entry at
&0D31. Writes the 64K main-memory image plus both sideways RAM banks to the
directory given on the command line.

Usage: uv run python tools/snapshot_game.py OUT_DIRPATH [STOP_ADDRESS_HEX]
"""

import sys
from pathlib import Path

from beebium.client import Beebium
from beebium.client.sideways import SlotType

REPO_DIRPATH = Path(__file__).resolve().parent.parent
DISC_FILEPATH = REPO_DIRPATH / "versions" / "cbbcga-dunjunz" / "Disc060-DunjunzRx2.ssd"
GAME_ENTRY = 0x0D31


def main() -> None:
    out_dirpath = Path(sys.argv[1])
    stop_address = int(sys.argv[2], 16) if len(sys.argv) > 2 else GAME_ENTRY
    out_dirpath.mkdir(parents=True, exist_ok=True)
    with Beebium.launch(variant="model-b-romram", preset="model-b-romram-disc") as bbc:
        bbc.system.set_speed_multiplier(0.0)
        for slot in (4, 5):
            bbc.sideways.configure_slot(slot, SlotType.RAM)
        bbc.boot_disc(DISC_FILEPATH)
        bp = bbc.debugger.add_breakpoint(stop_address)
        reached = False
        for _ in range(400):
            bbc.run_for_emulated_seconds(0.5)
            if bbc.cpu.pc == stop_address:
                reached = True
                break
            bbc.debugger.run()
            bbc.keyboard.press_space()
        if not reached:
            print(f"did not reach &{stop_address:04X}; PC=&{bbc.cpu.pc:04X}")
            print(bbc.video.screen_text().text)
        bbc.debugger.stop()
        print(bbc.cpu.registers)
        ram = bytes(bbc.memory.address.peek[0x0000:0x8000])
        (out_dirpath / "main_ram.bin").write_bytes(ram)
        for slot in (4, 5):
            (out_dirpath / f"swram_{slot}.bin").write_bytes(bbc.sideways.read_slot_data(slot))
        bbc.video.capture_frame().save_png(out_dirpath / "entry.png")
        for seconds in (3, 10):
            bbc.debugger.clear_breakpoints()
            bbc.run_for_emulated_seconds(seconds)
            bbc.debugger.run()
            bbc.video.capture_frame().save_png(out_dirpath / f"after_{seconds}s.png")
            bbc.debugger.stop()
            print(f"+{seconds}s PC=&{bbc.cpu.pc:04X}", bbc.video.screen_region())
            print(bbc.crtc.state)
            (out_dirpath / f"main_ram_after_{seconds}s.bin").write_bytes(
                bytes(bbc.memory.address.peek[0x0000:0x8000]))
        bbc.debugger.run()
        bbc.keyboard.press_space()
        bbc.run_for_emulated_seconds(8)
        bbc.debugger.run()
        bbc.video.capture_frame().save_png(out_dirpath / "playing.png")
        bbc.debugger.stop()
        print(f"playing PC=&{bbc.cpu.pc:04X}", bbc.video.screen_region())
        (out_dirpath / "main_ram_playing.bin").write_bytes(
            bytes(bbc.memory.address.peek[0x0000:0x8000]))
        print("wrote", out_dirpath)


if __name__ == "__main__":
    main()
