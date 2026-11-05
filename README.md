# Dunjunz

Annotated disassembly of **Dunjunz** by Julian Avis (Bug-Byte, 1986), a
four-player dungeon game for the BBC Micro Model B. The aim is to
understand how the game works, so that emulators can support it better,
fixes can be made, and a version that works with more disc filing
systems becomes possible.

## Releases

Three surviving releases are disassembled; none is a pristine original.
See [docs/history-and-provenance.md](docs/history-and-provenance.md).

| Directory | Release |
|---|---|
| `versions/nvg-dunjunz-tape/` | Ole's crack of the 1986 cassette |
| `versions/nvg-dunjunz-disc/` | The 1987 flippy disc (Model B side; Master side archived) |
| `versions/cbbcga-dunjunz/` | An unofficial sideways RAM hack, with the levels in ROMFS |

The game code is annotated once, in `dunjunz_common/`, keyed by run-time
address, and applied to each release by its driver
(`versions/*/disassemble/`). Every instruction of each release's game
code is commented, and each listing reassembles byte-for-byte to the
original files.

## Documentation

- [How the game works](docs/analysis/how-the-game-works.md)
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
uv run fantasm disassemble dunjun7      # sideways RAM hack
uv run fantasm disassemble tape-dunj4   # Ole's crack
uv run fantasm disassemble disc-dun1    # official disc
uv run fantasm verify --all             # reassemble and compare every file
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
