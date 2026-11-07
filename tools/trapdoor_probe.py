"""Run the disc's Model B side in beebium and test monster_reappears' check
that the trapdoor is free (see docs/findings.md).

    uv run python tools/trapdoor_probe.py
"""
import sys, tempfile
sys.path.insert(0, "tools")
from pathlib import Path
from beebium.client import Beebium
from disc_level_probe import make_preset, run_until, peek, SSD_FILEPATH, UPDATE_GAME

UPDATE_MONSTERS = 0x79C1
MX, MY, MS, MSTEP = 0x7E00, 0x7E29, 0x7E52, 0x7EF6
NEXT_TRAP, TX, TY = 0x0B2F, 0x0B90, 0x0B98

def poke(bbc, addr, value): bbc.memory.address.bus.write(addr, bytes([value]))

with tempfile.TemporaryDirectory() as tmp, Beebium.launch(variant="model-b", preset=make_preset(tmp)) as bbc:
    bbc.system.set_speed_multiplier(0.0)
    bbc.run_for_emulated_seconds(1)
    bbc.disc.drive0.insert(SSD_FILEPATH, write_protect=True)
    bbc.keyboard.type("*DUNJUNZ\r")
    assert run_until(bbc, UPDATE_GAME, 120, press_space=True), "no play"
    bbc.debugger.run(); bbc.run_for_emulated_seconds(3)
    assert run_until(bbc, UPDATE_MONSTERS, 5)
    t = (peek(bbc, NEXT_TRAP, 1)[0] + 1) % 8
    tx, ty = peek(bbc, TX + t, 1)[0], peek(bbc, TY + t, 1)[0]
    print("next trapdoor", t, "at", hex(tx), hex(ty))
    # Monster 1: last death frame, so it reappears this frame; monster 2 alive on that trapdoor.
    poke(bbc, MS + 1, 0x19); poke(bbc, MSTEP + 1, 0)
    dx, dy = peek(bbc, MX + 1, 1)[0], peek(bbc, MY + 1, 1)[0]
    print("monster 1 dies at", hex(dx), hex(dy))
    poke(bbc, MX + 2, dx); poke(bbc, MY + 2, dy); poke(bbc, MS + 2, 0x09); poke(bbc, MSTEP + 2, 0)
    bbc.debugger.run()
    assert run_until(bbc, 0x7CE6, 5), "find_creature call not reached"
    print("at the occupancy check: cell_x, cell_y =", peek(bbc, 0x0D02, 2).hex(" "),
          "scratch =", peek(bbc, 0x0D00, 1).hex(), "monster 1 now at", peek(bbc, MX + 1, 1).hex(), peek(bbc, MY + 1, 1).hex())
    bbc.debugger.run()
    for frame in range(4):
        assert run_until(bbc, UPDATE_MONSTERS, 5)
        print("frame", frame, "monster 1 x,y,sprite", peek(bbc, MX + 1, 1).hex(), peek(bbc, MY + 1, 1).hex(), peek(bbc, MS + 1, 1).hex(),
              "| monster 2", peek(bbc, MX + 2, 1).hex(), peek(bbc, MY + 2, 1).hex())
        bbc.debugger.run()
    # Move monster 2 well away; see whether monster 1 ever comes back to a trapdoor.
    assert run_until(bbc, UPDATE_MONSTERS, 5)
    poke(bbc, MX + 2, 0x05); poke(bbc, MY + 2, 0x05)
    bbc.debugger.run(); bbc.run_for_emulated_seconds(20)
    assert run_until(bbc, UPDATE_MONSTERS, 5)
    print("after 20 s: monster 1 x,y,sprite", peek(bbc, MX + 1, 1).hex(), peek(bbc, MY + 1, 1).hex(), peek(bbc, MS + 1, 1).hex())
