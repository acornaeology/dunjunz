"""Find game code that static tracing missed by watching the game run.

Boots Dunjunz in beebium, then sets breakpoints over every byte range the
current disassembly classifies as data within the four game files. Whenever
one fires, the code there is single-stepped while it stays inside
unclassified bytes, recording each executed instruction; the breakpoints are
then re-armed over the remaining unexecuted data. Random presses of the four
players' controls keep the game moving.

Writes a JSON report of the executed instruction addresses found in data
regions, grouped into contiguous blocks, for seeding the driver's entries.

Usage: uv run python tools/coverage.py REPORT_FILEPATH [EMULATED_SECONDS] [SEED]
"""

import json
import random
import sys
from pathlib import Path

from dasmos.ext.cpus.cpu6502.cpu import OPCODES

from dunjunz_beebium import PLAYER_KEYS, REPO_DIRPATH, boot_to, launched_machine

JSON_FILEPATH = REPO_DIRPATH / "versions" / "dunjunz-swram_hack" / "output" / "dunjunz-swram_hack.json"
GAME_RANGES = [(0x0400, 0x3000), (0x6E80, 0x8000)]
MAX_STEPS_PER_HIT = 5000


def data_bytes_from_listing() -> set[int]:
    listing = json.loads(JSON_FILEPATH.read_text())
    data = set()
    for item in listing["items"]:
        if item["type"] != "code":
            data.update(range(item["addr"], item["addr"] + len(item["bytes"])))
    return data


def runs(addresses: set[int]) -> list[tuple[int, int]]:
    """Maximal [start, end) runs of consecutive addresses."""
    result = []
    for addr in sorted(addresses):
        if result and result[-1][1] == addr:
            result[-1][1] = addr + 1
        else:
            result.append([addr, addr + 1])
    return [tuple(r) for r in result]


def arm(bbc, unexplored: set[int]) -> None:
    bbc.debugger.clear_breakpoints()
    for start, end in runs(unexplored):
        bbc.debugger.add_breakpoint(start, end_address=end)


def explore_from_stop(bbc, unexplored: set[int], executed: dict[int, int]) -> None:
    """Step from the current PC while it executes unexplored bytes."""
    for _ in range(MAX_STEPS_PER_HIT):
        pc = bbc.cpu.pc
        if pc not in unexplored and pc not in executed:
            return
        opcode = bbc.memory.address.peek[pc]
        length = OPCODES[opcode].length if opcode in OPCODES else 1
        executed.setdefault(pc, length)
        unexplored.difference_update(range(pc, pc + length))
        bbc.debugger.step(1)


def press_random_controls(bbc, rng: random.Random, held: set) -> None:
    for key in list(held):
        bbc.keyboard.matrix_up(*key)
    held.clear()
    for keys in PLAYER_KEYS.values():
        for _ in range(rng.randint(0, 2)):
            key = keys[rng.choice(list(keys))]
            bbc.keyboard.matrix_down(*key)
            held.add(key)


def main() -> None:
    report_filepath = Path(sys.argv[1])
    emulated_seconds = float(sys.argv[2]) if len(sys.argv) > 2 else 120.0
    rng = random.Random(int(sys.argv[3]) if len(sys.argv) > 3 else 1)

    data = data_bytes_from_listing()
    unexplored = {a for a in data if any(lo <= a < hi for lo, hi in GAME_RANGES)}
    executed: dict[int, int] = {}

    with launched_machine() as bbc:
        if not boot_to(bbc):
            sys.exit("did not reach the game entry")
        arm(bbc, unexplored)
        held: set = set()
        elapsed = 0.0
        chunk = 0.25
        started = False
        while elapsed < emulated_seconds:
            before = bbc.debugger.cycle_count
            bbc.run_for_emulated_seconds(chunk)
            elapsed += (bbc.debugger.cycle_count - before) / 2_000_000
            if bbc.cpu.pc in unexplored:
                explore_from_stop(bbc, unexplored, executed)
                arm(bbc, unexplored)
                continue
            if not started:
                # Hero-selection menu: SPACE starts the game.
                bbc.debugger.run()
                bbc.keyboard.press_space()
                started = True
            press_random_controls(bbc, rng, held)
        bbc.video.capture_frame().save_png(report_filepath.with_suffix(".png"))

    blocks = runs({a for pc, n in executed.items() for a in range(pc, pc + n)})
    report = {
        "emulated_seconds": emulated_seconds,
        "executed_instructions": [f"&{pc:04X}" for pc in sorted(executed)],
        "blocks": [{"start": f"&{s:04X}", "end": f"&{e:04X}"} for s, e in blocks],
    }
    report_filepath.write_text(json.dumps(report, indent=2))
    print(f"{len(executed)} instructions in {len(blocks)} blocks")
    for s, e in blocks:
        print(f"  &{s:04X}-&{e - 1:04X}")


if __name__ == "__main__":
    main()
