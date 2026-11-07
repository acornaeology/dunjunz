"""Suggest calling conventions from a dasmos JSON listing.

    uv run python tools/registers.py LISTING_JSON_FILEPATH [NAME ...]

For each subroutine (or those named), follow its code from the entry,
through branches, to every RTS, and report for A, X and Y:

- read before written on some path (a likely input);
- written on some path (corrupted, unless every path restores it);
- the routines it calls, whose own effects are not followed.

It is a reading aid for writing on_entry/on_exit, not an oracle: calls
are treated as leaving registers unknown, and pushes and pulls are only
matched when they balance in the obvious way.
"""

import json
import sys
from pathlib import Path

READS = {
    "a": {"sta", "pha", "tax", "tay", "cmp", "adc", "sbc", "and", "ora", "eor", "bit"},
    "x": {"stx", "txa", "txs", "cpx", "inx", "dex"},
    "y": {"sty", "tya", "cpy", "iny", "dey"},
}
WRITES = {
    "a": {"lda", "pla", "txa", "tya", "adc", "sbc", "and", "ora", "eor"},
    "x": {"ldx", "tax", "tsx", "inx", "dex"},
    "y": {"ldy", "tay", "iny", "dey"},
}
ACCUMULATOR_SHIFTS = {"asl", "lsr", "rol", "ror"}
BRANCHES = {"bcc", "bcs", "beq", "bne", "bmi", "bpl", "bvc", "bvs", "bra"}


def operand_regs(operand):
    regs = set()
    if operand.endswith(",x") or operand.endswith(",x)"):
        regs.add("x")
    if operand.endswith(",y") or ",y" in operand:
        regs.add("y")
    return regs


def analyse(listing, start, end):
    code = {i["addr"]: i for i in listing["items"]
            if i["type"] == "code" and start <= i["addr"] < end}
    inputs, written, calls, exits = set(), set(), set(), []
    seen = set()
    stack = [(start, frozenset())]
    while stack:
        addr, done = stack.pop()
        if (addr, done) in seen or addr not in code:
            continue
        seen.add((addr, done))
        item = code[addr]
        mnemonic = item["mnemonic"]
        operand = item.get("operand", "")
        reads = {r for r, ms in READS.items() if mnemonic in ms}
        reads |= operand_regs(operand)
        if mnemonic in ACCUMULATOR_SHIFTS and operand in ("", "a"):
            reads.add("a")
        writes = {r for r, ms in WRITES.items() if mnemonic in ms}
        if mnemonic in ACCUMULATOR_SHIFTS and operand in ("", "a"):
            writes.add("a")
        inputs |= reads - done
        written |= writes
        done = done | writes
        nxt = addr + len(item["bytes"])
        if mnemonic == "jsr":
            calls.add(item.get("target_label") or operand)
            stack.append((nxt, done))
        elif mnemonic in ("rts", "rti"):
            exits.append(addr)
        elif mnemonic == "jmp":
            target = item.get("target")
            if target is not None and start <= target < end and "(" not in operand:
                stack.append((target, done))
            else:
                calls.add(f"jmp {item.get('target_label') or operand}")
        elif mnemonic in BRANCHES:
            target = item.get("target")
            if target is not None:
                stack.append((target, done))
            stack.append((nxt, done))
        else:
            stack.append((nxt, done))
    return inputs, written, calls, exits


# What the MOS calls the game makes leave in A, X and Y (MOS 1.20 user guide).
OS_EFFECTS = {
    "oswrch": (set("a"), set()), "osasci": (set("a"), set()),
    "osnewl": (set(), set()), "osrdch": (set(), set("a")),
    "osbyte": (set("axy"), set("axy")), "osword": (set("axy"), set("axy")),
    "oscli": (set("xy"), set("axy")), "osfile": (set("axy"), set("axy")),
    "osargs": (set("axy"), set("axy")), "osfind": (set("axy"), set("axy")),
}


def closure(listing, subs, starts):
    """Inputs and corrupted registers of every routine, following calls."""
    by_name = {name: addr for addr, name, _ in subs}
    raw = {}
    for addr, name, _ in subs:
        end = next((s for s in starts if s > addr), addr + 0x400)
        raw[name] = analyse(listing, addr, end)
    effects = {name: (set(r[0]), set(r[1])) for name, r in raw.items()}
    effects.update(OS_EFFECTS)
    for _ in range(10):
        changed = False
        for name, (inputs, written, calls, _) in raw.items():
            ins, outs = effects[name]
            for call in calls:
                callee = call.removeprefix("jmp ")
                if callee in effects:
                    c_in, c_out = effects[callee]
                    new_outs = outs | c_out
                    if new_outs != outs:
                        outs |= c_out
                        changed = True
                elif callee not in by_name:
                    if not outs >= set("axy"):
                        outs |= set("axy")
                        changed = True
            effects[name] = (ins, outs)
        if not changed:
            break
    return raw, effects


def main():
    listing = json.loads(Path(sys.argv[1]).read_text())
    wanted = set(sys.argv[2:])
    subs = sorted((s["addr"], s["name"], s) for s in listing["subroutines"] if "title" in s)
    starts = sorted({s[0] for s in subs} | {i["addr"] for i in listing["items"]
                                             if i["type"] != "code"})
    raw, effects = closure(listing, subs, starts)
    for addr, name, sub in subs:
        if wanted and name not in wanted:
            continue
        inputs, _, calls, exits = raw[name]
        written = effects[name][1]
        print(f"&{addr:04X} {name}: inputs {''.join(sorted(inputs)).upper() or '-'}; "
              f"corrupts {''.join(sorted(written)).upper() or '-'}; "
              f"calls {', '.join(sorted(calls)) or '-'}; "
              f"have on_entry={sub.get('on_entry')} on_exit={sub.get('on_exit')}")


if __name__ == "__main__":
    main()
