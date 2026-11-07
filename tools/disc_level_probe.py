"""Run the official disc's Model B side in beebium and test the
ten-thousands score digit across a level change.

    uv run python tools/disc_level_probe.py OUT_DIRPATH

Boots the Model B side with DFS 0.90 (a preset made on the fly: the 8271
with acorn-dfs_0_90.rom, which beebium bundles), runs *DUNJUNZ, presses
SPACE through the title and menu into level 1, gives hero 0 a
ten-thousands digit of 1 (&6A at &06F8, where add_thousand_points keeps
it), then jumps to next_level_by_reset (&1460) as the end of a level
does. At level 2, once remove_absent_heroes has drawn the panel (&0E60),
it reports &06F8-&06FB and &08B0-&08B3 and saves the screen.
"""

import json
import sys
import tempfile
import zipfile
from pathlib import Path

from beebium.client import Beebium

REPO_DIRPATH = Path(__file__).resolve().parent.parent
SSD_FILEPATH = REPO_DIRPATH / "versions" / "dunjunz-disc" / "Dunjunz_D1S2_40T_HG3_54F4B47A_1.ssd"
UPDATE_GAME, AFTER_PANEL, NEXT_LEVEL_BY_RESET = 0x1CC0, 0x0E60, 0x1460


def make_preset(dirpath):
    preset_filepath = Path(dirpath) / "model-b-8271-dfs090.beebium-preset"
    with zipfile.ZipFile(preset_filepath, "w") as z:
        z.writestr("preset.json", json.dumps({
            "model": "model-b", "name": "Model B (8271 DFS 0.90)", "release_date": "1982",
            "description": "32K Model B, 8271 DFS 0.90",
            "storage": {"fdc_socket": {"id": "acorn-8271"}},
            "sideways_bank": {"slots": [{"slot": 14, "type": "rom", "image_uri": "acorn-dfs_0_90.rom"}]},
        }))
    return preset_filepath


def run_until(bbc, address, seconds, press_space=False):
    bp = bbc.debugger.add_breakpoint(address)
    try:
        for _ in range(int(seconds / 0.5)):
            bbc.run_for_emulated_seconds(0.5)
            if bbc.cpu.pc == address:
                return True
            bbc.debugger.run()
            if press_space:
                bbc.keyboard.press_space()
        return False
    finally:
        bp.remove()


def peek(bbc, start, length):
    return bytes(bbc.memory.address.peek[start:start + length])


def main():
    out_dirpath = Path(sys.argv[1])
    out_dirpath.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory() as tmp_dirpath, \
            Beebium.launch(variant="model-b", preset=make_preset(tmp_dirpath)) as bbc:
        bbc.system.set_speed_multiplier(0.0)
        bbc.run_for_emulated_seconds(1)
        bbc.disc.drive0.insert(SSD_FILEPATH, write_protect=True)
        bbc.keyboard.type("*DUNJUNZ\r")
        if not run_until(bbc, UPDATE_GAME, 120, press_space=True):
            print("never reached play; PC", hex(bbc.cpu.pc))
            print(bbc.video.screen_text().text)
            return
        print("level 1: &06F8", peek(bbc, 0x06F8, 4).hex(" "), "&08B0", peek(bbc, 0x08B0, 4).hex(" "),
              "levels_started", peek(bbc, 0x08BC, 1).hex())
        bbc.memory.address.bus.write(0x06F8, bytes([0x6A]))
        bbc.cpu.pc = NEXT_LEVEL_BY_RESET
        bbc.debugger.run()
        if not run_until(bbc, AFTER_PANEL, 120):
            print("never reached the level 2 panel; PC", hex(bbc.cpu.pc))
            return
        print("level 2: &06F8", peek(bbc, 0x06F8, 4).hex(" "), "&08B0", peek(bbc, 0x08B0, 4).hex(" "),
              "levels_started", peek(bbc, 0x08BC, 1).hex())
        bbc.video.capture_frame().save_png(out_dirpath / "level2_panel.png")


if __name__ == "__main__":
    main()
