"""Run the disc's Master 128 side in beebjit and report the machine's state
when a breakpoint is reached.

beebium cannot yet emulate a Master 128 (rob-smallshire/beebium#189), so
this drives beebjit's headless debugger instead. It boots the Master
side's HFE capture as a Master 128 with MOS 3.20, taps SPACE every 20
million cycles (enough to get through BOOT, the title and the menu), and
prints the registers, ACCCON and the requested memory when the
breakpoint is first hit. With --then, it replays the same input up to the
hit and runs further debugger commands there (for example a write
watchpoint, `bmw c400 d8ff`).

usage: master_probe.py BEEBJIT_FILEPATH BREAK_ADDR_HEX [DUMP_ADDR_HEX ...]
                       [--then 'cmd;cmd'] [--max-cycles N]

beebjit must be run from its checkout (it loads its ROMs from roms/), set
by BEEBJIT_DIRPATH (default ~/Code/beebjit). To build it on macOS without
touching the checkout:

    sed 's|-o beebjit|-o OUT_FILEPATH|; s/ -flto//' build_mac_opt.sh > build.sh
    SDKROOT=$(xcrun --show-sdk-path) sh build.sh
"""

import os
import subprocess
import sys
from pathlib import Path

REPO_DIRPATH = Path(__file__).resolve().parent.parent
HFE_FILEPATH = REPO_DIRPATH / "versions/dunjunz-disc/Dunjunz_D1S1_40T_HG3_8518BF40_1.hfe"
BEEBJIT_DIRPATH = Path(os.environ.get("BEEBJIT_DIRPATH", Path.home() / "Code/beebjit"))
STEP_CYCLES = 20_000_000
FIRST_CYCLES = 60_000_000
REPORT_END = "MARK"  # an unknown command: beebjit answers "???"


def run(beebjit_filepath, commands):
    proc = subprocess.run(
        [str(beebjit_filepath), "-master", "-headless", "-debug", "-autoboot",
         "-0", str(HFE_FILEPATH)],
        input="\n".join(commands + ["q"]) + "\n", capture_output=True,
        text=True, cwd=BEEBJIT_DIRPATH, timeout=1800)
    return (proc.stdout + proc.stderr).replace("(6502db) ", "\n")


def main(argv):
    then = None
    max_cycles = 600_000_000
    if "--then" in argv:
        i = argv.index("--then")
        then = argv[i + 1].split(";")
        del argv[i:i + 2]
    if "--max-cycles" in argv:
        i = argv.index("--max-cycles")
        max_cycles = int(argv[i + 1])
        del argv[i:i + 2]
    beebjit_filepath, target, *dumps = argv
    report = ["r", "bbc"] + [f"m {addr}" for addr in dumps] + [REPORT_END]

    commands = [f"b {target}"]
    cycles = FIRST_CYCLES
    while cycles < max_cycles:
        for key_command in ("keydown 32", "keyup 32"):
            commands += [f"breakat {cycles}", "c"] + report + [key_command]
            cycles += STEP_CYCLES

    out = run(beebjit_filepath, commands)
    hit = out.find("breakpoint 0 hit")
    if hit < 0:
        print("breakpoint not reached")
        return 1
    end = out.find("???", hit)
    print(out[hit:end if end > 0 else hit + 6000])

    if then:
        # The emulation is deterministic: replay the commands up to the
        # stop at which the breakpoint was hit, then run the extra ones.
        stops_before = out[:hit].count("???")
        prefix, seen = [], 0
        for command in commands:
            prefix.append(command)
            if command == REPORT_END:
                seen += 1
                if seen == stops_before:
                    break
        j = len(prefix) if stops_before else 1
        prefix = commands[:j]
        while commands[j] != "c":
            prefix.append(commands[j])
            j += 1
        prefix.append("c")
        out2 = run(beebjit_filepath, prefix + then)
        print("=== then ===")
        print(out2[out2.find("breakpoint 0 hit"):][:8000])
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
