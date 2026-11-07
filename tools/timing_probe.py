"""Measure the game's timing behaviours in beebium (see docs/findings.md).

    uv run python tools/timing_probe.py {hack_pause,game_over,monster_step,disc_repause}

hack_pause    The sideways RAM hack: pause with f1 for several lengths of
              time, and count the vsyncs from the end of the pause to the
              next frame (play_level's wait on os_vsync_counter).
game_over     The hack: make all four heroes dead, and count the vsyncs
              that the wait at &0EB9 (os_vsync_counter = 0) takes.
monster_step  The hack: follow every monster for 80 frames and report the
              frames each step between cells takes: inside a room, onto a
              room's edge cell, and into the next room.
disc_repause  The official disc's Model B side: pause with P, then hold P
              down through the unpausing press, and see whether the game
              pauses again.

Times are in vsyncs (fields), 50 a second, read from the CRTC's field
count at breakpoints.
"""

import sys
import tempfile

sys.path.insert(0, "tools")
from disc_level_probe import SSD_FILEPATH, make_preset, peek, run_until  # noqa: E402
from dunjunz_beebium import boot_to, launched_machine  # noqa: E402

from beebium.client import Beebium  # noqa: E402

UPDATE_GAME = 0x1CC0
PAUSE_TEST = 0x1ED7                    # pause key test, last in update_game
WAIT_PAUSE_RELEASE, WAIT_PAUSE_PRESS = 0x1EE0, 0x1EE7
HACK_NOT_PAUSED, DISC_NOT_PAUSED = 0x1EF5, 0x1EF3
PLAY_LEVEL_WAITED = 0x1F05             # play_level, past its vsync wait
UPDATE_MONSTERS = 0x79C1
GAME_OVER, GAME_OVER_WAIT, GAME_OVER_WAITED = 0x0E86, 0x0EB9, 0x0EBE
OS_VSYNC_COUNTER = 0x0240
HERO_DIRECTION, HERO_FRAME, HERO_HEALTH_TENS = 0x0D1A, 0x0D20, 0x0D90
DEAD_TENS = 0x1D                       # spr_digit_0 - 1
MONSTER_X, MONSTER_Y, MONSTER_STEP = 0x7E00, 0x7E29, 0x7EF6
F1, P = (7, 1), (3, 7)                 # keyboard matrix (row, column)


def field(bbc):
    return bbc.crtc.state.field


def poke(bbc, addr, value):
    bbc.memory.address.bus.write(addr, bytes([value]))


def stop_at(bbc, addr, seconds=30):
    """Run from where the machine is to the next arrival at addr, and stop
    there (a server-side breakpoint, so no arrival is missed)."""
    bbc.debugger.run_to(addr, skip_current=True, timeout=seconds)


def reaches(bbc, addr, emulated_seconds):
    """Whether the machine arrives at addr within emulated_seconds."""
    with bbc.debugger.breakpoint(addr):
        bbc.run_for_emulated_seconds(emulated_seconds)
        return bbc.cpu.pc == addr


def hack_in_play(bbc):
    assert boot_to(bbc, UPDATE_GAME), "never reached play"


def hack_pause():
    with launched_machine() as bbc:
        hack_in_play(bbc)
        for pause_seconds in (1.0, 2.0, 3.0, 3.5, 4.0, 5.0):
            stop_at(bbc, PAUSE_TEST)
            bbc.keyboard.matrix_down(*F1)
            stop_at(bbc, WAIT_PAUSE_RELEASE)
            bbc.keyboard.matrix_up(*F1)
            stop_at(bbc, WAIT_PAUSE_PRESS)
            paused_field = field(bbc)
            bbc.run_for_emulated_seconds(pause_seconds)
            bbc.keyboard.matrix_down(*F1)
            bbc.run_for_emulated_seconds(0.1)
            bbc.keyboard.matrix_up(*F1)
            stop_at(bbc, HACK_NOT_PAUSED)
            resumed_field = field(bbc)
            counter = peek(bbc, OS_VSYNC_COUNTER, 1)[0]
            stop_at(bbc, PLAY_LEVEL_WAITED, 10)
            stall = field(bbc) - resumed_field
            print(f"paused {resumed_field - paused_field:4d} vsyncs; "
                  f"os_vsync_counter at resume &{counter:02X}; "
                  f"next frame after {stall:3d} vsyncs ({stall / 50:.2f} s)")


def game_over():
    with launched_machine() as bbc:
        hack_in_play(bbc)
        for hero in range(4):
            poke(bbc, HERO_DIRECTION + hero, 0)
            poke(bbc, HERO_FRAME + hero, 8)
            poke(bbc, HERO_HEALTH_TENS + hero, DEAD_TENS)
        stop_at(bbc, GAME_OVER, 30)
        start = field(bbc)
        print(f"game over: os_vsync_counter &{peek(bbc, OS_VSYNC_COUNTER, 1)[0]:02X}")
        stop_at(bbc, GAME_OVER_WAIT)
        at_wait = field(bbc)
        print(f"message printed after {at_wait - start} vsyncs; "
              f"os_vsync_counter &{peek(bbc, OS_VSYNC_COUNTER, 1)[0]:02X}")
        stop_at(bbc, GAME_OVER_WAITED, 20)
        waited = field(bbc) - at_wait
        print(f"the wait at &0EB9 took {waited} vsyncs ({waited / 50:.2f} s)")


def monster_step():
    with launched_machine() as bbc:
        hack_in_play(bbc)
        bbc.run_for_emulated_seconds(4)  # let the monsters emerge
        history = []
        for _ in range(80):
            stop_at(bbc, UPDATE_MONSTERS)
            history.append((peek(bbc, MONSTER_X, 31), peek(bbc, MONSTER_Y, 31)))
        intervals = {"same room, inside": {}, "same room, onto the edge": {}, "new room": {}}
        for monster in range(1, 31):
            last_change = None
            for frame in range(1, len(history)):
                (x0, y0), (x1, y1) = ((h[0][monster], h[1][monster]) for h in history[frame - 1:frame + 1])
                if (x0, y0) == (x1, y1) or 0xFF in (x0, y0, x1, y1):
                    continue
                if last_change is not None:
                    dx, dy = x1 - x0, y1 - y0
                    on_edge = ((dx == 1 and x1 & 7 == 7) or (dx == -1 and x1 & 7 == 0)
                               or (dy == 1 and y1 & 7 == 7) or (dy == -1 and y1 & 7 == 0))
                    kind = ("new room" if (x0 >> 3, y0 >> 3) != (x1 >> 3, y1 >> 3)
                            else "same room, onto the edge" if on_edge
                            else "same room, inside")
                    n = frame - last_change
                    intervals[kind][n] = intervals[kind].get(n, 0) + 1
                last_change = frame
        for kind, counts in intervals.items():
            print(f"{kind}: frames since the previous cell change -> count:", dict(sorted(counts.items())))


def disc_repause():
    with tempfile.TemporaryDirectory() as tmp_dirpath, \
            Beebium.launch(variant="model-b", preset=make_preset(tmp_dirpath)) as bbc:
        bbc.system.set_speed_multiplier(0.0)
        bbc.run_for_emulated_seconds(1)
        bbc.disc.drive0.insert(SSD_FILEPATH, write_protect=True)
        bbc.keyboard.type("*DUNJUNZ\r")
        assert run_until(bbc, UPDATE_GAME, 120, press_space=True), "never reached play"
        stop_at(bbc, PAUSE_TEST)
        bbc.keyboard.matrix_down(*P)
        stop_at(bbc, WAIT_PAUSE_RELEASE)
        bbc.keyboard.matrix_up(*P)
        stop_at(bbc, WAIT_PAUSE_PRESS)
        bbc.run_for_emulated_seconds(1)
        bbc.keyboard.matrix_down(*P)          # unpause, and keep holding P
        stop_at(bbc, DISC_NOT_PAUSED)
        resumed = field(bbc)
        print(f"resumed; os_vsync_counter &{peek(bbc, OS_VSYNC_COUNTER, 1)[0]:02X}")
        stop_at(bbc, PAUSE_TEST)
        print(f"next pause test after {field(bbc) - resumed} vsyncs, P still held")
        repaused = reaches(bbc, WAIT_PAUSE_RELEASE, 2)
        print("paused again" if repaused else "not paused again",
              f"(PC &{bbc.cpu.pc:04X})")
        bbc.keyboard.matrix_up(*P)


if __name__ == "__main__":
    {"hack_pause": hack_pause, "game_over": game_over,
     "monster_step": monster_step, "disc_repause": disc_repause}[sys.argv[1]]()
