# Dunjunz

[![Verify disassembly](https://github.com/acornaeology/dunjunz/actions/workflows/verify.yml/badge.svg)](https://github.com/acornaeology/dunjunz/actions/workflows/verify.yml)

Annotated disassembly of **Dunjunz** by Julian Avis (Bug-Byte, 1986), a
four-player dungeon game for the BBC Micro Model B. The aim is to
understand how the game works, so that emulators can support it better,
fixes can be made, and a version that works with more disc filing
systems becomes possible.

## Releases

The reference version is the official 1987 flippy disc's Model B side,
disassembled from flux captures of both its sides; the disc's Master 128
side, the official conversion for the Master, is a version of its own.
The other two are variations on the game: a crack of the 1986 cassette, and an unofficial hack built
from that crack and the disc. No image of the original cassette has
turned up yet. See
[docs/history-and-provenance.md](docs/history-and-provenance.md).

| Directory | Release |
|---|---|
| `versions/dunjunz-disc/` | The official 1987 flippy disc, Model B side, from HFE captures (both sides' captures are kept here) |
| `versions/dunjunz-disc_master/` | The same disc's Master 128 side |
| `versions/dunjunz-tape_crack_ole/` | Ole's crack of the 1986 cassette |
| `versions/dunjunz-swram_hack/` | An unofficial sideways RAM hack, with the levels in ROMFS |

The game code is annotated once, in `dunjunz_common/`, keyed by run-time
address, and applied to each release by its driver
(`versions/*/disassemble/`). Every instruction of each release's game
code is commented, and each listing reassembles byte-for-byte to the
original files.

## Documentation

- [How the game works](docs/analysis/how-the-game-works.md)
- [The Master 128 version](docs/analysis/the-master-128-version.md): what
  it shares and changes, its use of private RAM, and how it works with the
  WD1770 and DFS 2.24
- [Level format](docs/level-format.md)
- [Findings](docs/findings.md): emulator-compatibility hazards, bugs,
  inaccuracies in the instructions, candidate fixes
- [Disc contents and loading](docs/disc-contents-and-loading.md) (the
  sideways RAM hack's disc)
- [Notes from the stardot versions thread](docs/stardot-dunjunz-versions-thread.md)

## Building and verifying

Requires [uv](https://docs.astral.sh/uv/) and
[beebasm](https://github.com/stardot/beebasm) (v1.10+).

```sh
uv sync
uv run fantasm disassemble disc           # official disc, Model B side
uv run fantasm disassemble disc_master    # official disc, Master 128 side
uv run fantasm disassemble tape_crack_ole # Ole's crack
uv run fantasm disassemble swram_hack     # sideways RAM hack
uv run fantasm verify --all               # reassemble and compare every file
```

## Tools

| Tool | Purpose |
|---|---|
| `tools/listing.py` | Address-keyed listing of a range, for writing annotations |
| `tools/runtime_images.py` | Rebuild each release's resident image and compare them |
| `tools/sprites.py` | Render the 120 sprites as a contact sheet |
| `tools/levels.py` | Decode a level and draw its map |
| `tools/romfs.py` | Read and check the files in a ROMFS image |
| `tools/snapshot_game.py`, `tools/coverage.py` | Run the game in [beebium](https://github.com/rob-smallshire/beebium): memory snapshots; find executed code |
