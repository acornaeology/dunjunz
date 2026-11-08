"""Run the 1986 cassette in beebjit and report the machine's state when a
breakpoint is reached.

beebium has no cassette (and oaknut no UEF), so this drives beebjit's
headless debugger, as tools/master_probe.py does for the Master side. It
starts a Model B (MOS 1.20, with DFS), types *TAPE and CHAIN"" at the
BASIC prompt with the UEF image in the tape deck (-fasttape), and prints
the registers and the requested memory when the breakpoint is first hit.

usage: tape_probe.py BEEBJIT_FILEPATH BREAK_ADDR_HEX [DUMP_ADDR_HEX ...]
                     [--max-cycles N]

The emulation runs at about real speed under the debugger, so reaching
TITLE (about 735 million cycles) takes some six minutes. beebjit must be
run from its checkout (BEEBJIT_DIRPATH, default ~/Code/beebjit); see
tools/master_probe.py for building it.
"""

import os
import subprocess
import sys
from pathlib import Path

REPO_DIRPATH = Path(__file__).resolve().parent.parent
UEF_FILEPATH = REPO_DIRPATH / "versions/dunjunz-tape/Dunjunz_B.uef"
BEEBJIT_DIRPATH = Path(os.environ.get("BEEBJIT_DIRPATH", Path.home() / "Code/beebjit"))
BOOT_CYCLES = 4_000_000
KEY_CYCLES = 100_000
SHIFT = 133   # beebjit's key codes: ASCII for letters and digits,
RETURN = 131  # host "'" for the BBC's ":" key


def typing_commands():
    commands, cycles = [], BOOT_CYCLES

    def wait(n):
        nonlocal cycles
        cycles += n
        commands.extend([f"breakat {cycles}", "c"])

    def key(code, shift=False):
        if shift:
            commands.append(f"keydown {SHIFT}")
        commands.append(f"keydown {code}")
        wait(KEY_CYCLES)
        commands.append(f"keyup {code}")
        if shift:
            commands.append(f"keyup {SHIFT}")
        wait(KEY_CYCLES)

    wait(0)
    key(ord("'"), shift=True)  # *
    for ch in "TAPE":
        key(ord(ch))
    key(RETURN)
    for ch in "CHAIN":
        key(ord(ch))
    key(ord("2"), shift=True)  # "
    key(ord("2"), shift=True)
    key(RETURN)
    return commands


def main(argv):
    max_cycles = 1_600_000_000
    if "--max-cycles" in argv:
        i = argv.index("--max-cycles")
        max_cycles = int(argv[i + 1])
        del argv[i:i + 2]
    beebjit_filepath, target, *dumps = argv
    commands = typing_commands() + [f"b {target}", f"breakat {max_cycles}", "c", "r", "bbc"]
    commands += [f"m {addr}" for addr in dumps] + ["q"]
    proc = subprocess.run(
        [str(beebjit_filepath), "-headless", "-debug", "-fasttape",
         "-tape", str(UEF_FILEPATH)],
        input="\n".join(commands) + "\n", capture_output=True, text=True,
        cwd=BEEBJIT_DIRPATH, timeout=3600)
    out = (proc.stdout + proc.stderr).replace("(6502db) ", "\n")
    hit = out.find("breakpoint 0 hit")
    if hit < 0:
        print("breakpoint not reached")
        return 1
    print(out[hit:hit + 6000])
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
