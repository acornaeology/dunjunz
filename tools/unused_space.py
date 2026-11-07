"""List the bytes a listing marks as unused, as space a revised version
could recover.

    uv run python tools/unused_space.py LISTING_JSON [--in-play] [--min BYTES]

Two kinds, from the listing's own annotations:

- unused: memory nothing reads or writes: data commented "Not
  referenced", "Zeros", "Padding" or "Leftover", or covered by an
  "Unused" banner (up to the next labelled item);
- overwritten: initial contents the program replaces before reading them
  ("Not read: ..."); they cost file space, not memory, since the memory
  is the program's workspace.

Only the first row of a multi-row table carries the "Not read" comment,
so overwritten totals are lower bounds. --in-play leaves out what is not
resident during play in the game listings: the screen (&3000-&6E7F, where
the stored copies lie) and the official disc's joystick image of page
&04-&07 (the keyboard image's unused bytes are counted once). --min hides
runs shorter than BYTES (totals still count them).

The listing's markings are only as good as the annotation: a byte the
listing calls unused may still be reached by an indexed access past a
table's end, or be code that doubles as data, so check each run before
reusing it.
"""

import argparse
import json
import re

UNUSED = re.compile(r"^(Not referenced|Unused|Zeros?\b|Padding|Leftover)", re.I)


def unused_runs(listing, in_play):
    banner_at = {(b["addr"], b.get("move")): b["title"] for b in listing["banners"]}
    current = {}
    runs = {"unused": [], "overwritten": []}
    for item in listing["items"]:
        move = item.get("move") or ""
        key = (item["addr"], item.get("move"))
        if key in banner_at:
            current[move] = banner_at[key]
        elif item.get("labels") or item["type"] == "code":
            current[move] = None
        if item["type"] == "code":
            continue
        comment = item.get("comment_inline") or ""
        title = current.get(move) or ""
        if comment.startswith("Not read"):
            kind = "overwritten"
        elif (UNUSED.match(comment) or title.startswith("Unused")
              or "not referenced" in comment.lower()):
            kind = "unused"
        else:
            continue
        if in_play and (move == "low_joystick"
                        or (not move and 0x3000 <= item["addr"] < 0x6E80)):
            continue
        runs[kind].append([item["addr"], len(item["bytes"]), move, title, comment])
    for kind, items in runs.items():
        merged = []
        for addr, n, move, title, comment in sorted(items, key=lambda r: (r[2], r[0])):
            if merged and merged[-1][2] == move and merged[-1][0] + merged[-1][1] == addr:
                merged[-1][1] += n
            else:
                merged.append([addr, n, move, title, comment])
        runs[kind] = merged
    return runs


def main():
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument("listing_json_filepath")
    parser.add_argument("--in-play", action="store_true")
    parser.add_argument("--min", type=int, default=1)
    args = parser.parse_args()
    listing = json.load(open(args.listing_json_filepath))
    for kind, merged in unused_runs(listing, args.in_play).items():
        total = sum(run[1] for run in merged)
        print(f"{kind}: {total} bytes in {len(merged)} runs")
        for addr, n, move, title, comment in merged:
            if n >= args.min:
                where = f" ({move})" if move else ""
                print(f"  &{addr:04X}-&{addr + n - 1:04X} {n:5d}{where:15s} "
                      f"{title[:28]:28s} {comment[:50]}")


if __name__ == "__main__":
    main()
