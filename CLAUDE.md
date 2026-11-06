# CLAUDE.md

## What this is

Annotated disassembly of **Dunjunz** by Julian Avis (Bug-Byte, 1986) for the
BBC Micro Model B, produced with dasmos and verified by reassembly. The aim is
to understand how the game works so that emulators can support it better and
fixes can be made, and to publish a buildable, annotated reassembly via the
sibling `acornaeology.github.io` site, like the other acornaeology projects.
Follow the `disassembly-skills:6502-disassembly` skill's method.

## Source artefacts and history

Three versions live under `versions/` (see `versions/README.md`):

- `dunjunz-disc/`: the reference version, the official 1987 flippy disc.
  It holds HFE flux captures of both sides, the SSDs and track reports
  derived from them (`tools/read_disc_image.py`), and the NVG archive's
  `Dunjunz.zip`, whose files are identical. `binary/` holds `Dun1` and
  `Coder` exported from the Model B side's SSD.
- `dunjunz-tape_crack_ole/`: Ole's crack of the 1986 cassette. No image of
  the original cassette has been found; it would go in `dunjunz-tape/`.
- `dunjunz-swram_hack/`: the unofficial sideways RAM hack, built from the
  crack and the disc (the BBC Micro Games Archive "Sideways RAM version",
  `Disc060-DunjunzRx2.ssd`; see `docs/disc-contents-and-loading.md` for
  its catalogue, boot chain and runtime memory map).

How they relate is written up in `docs/history-and-provenance.md`; keep
it current as evidence accumulates, tagging statements [confirmed],
[reported] or [inference]. Describe the crack and the hack as variations
on the official release.

## Binaries


| File | Load | Exec | Size | Notes |
|---|---|---|---|---|
| `Dun1` (disc) | &2000 | &2000 | &6000 | the whole game; Coder builds the resident game from it at each level (see the disc driver's docstring) |
| `Coder` (disc) | &5000 | &5000 | &09B0 | level loader, run for every level; holds the keyboard and joystick &0400 images |
| `DUNJ4` (crack) | &2400 | &5000 | &2C50 | the &0400–&2FFF game image stored &2000 high, plus start-up at &5000 |
| `DUNJ3` (crack) | &6E80 | — | &2E80 | its first &1180 bytes are the game's &6E80–&7FFF |
| `Dunjun4` (hack) | &0400 | — | &0900 | game code/data |
| `Dunjun7` (hack) | &0D00 | — | &0400 | game code/data; loaded at &3000 then copied to &0D00; game entry &0D31 |
| `Dunjun5` (hack) | &1100 | — | &1F00 | game code/data |
| `Dunjun6` (hack) | &6E80 | — | &1180 | game code/data, just above the play screen |
| `TITLE` (hack) | &3800 | &38C6 | &0C00 | title page machine code (separate program) |
| `Dunjun1`/`Dunjun2` | SWR | — | &0D00/&4000 | Beebug ROMFS images holding `LEVEL1`–`LEVEL25` |
| `DUNJUNZ`, `DUNK` | &1900, &2500 | — | — | tokenised BASIC (instructions/intro; SWR and game loader) |
| `PIC`, `Dunjun3` | &3000, &3280 | — | — | MODE 2 pictures (intro face; loading screen) |

- CPU: 6502 (NMOS), BBC Model B. The disc's Master 128 side (not yet
  disassembled) is a separate conversion; the hack's loader refuses to run
  on a Master.
- Game screen: &3000–&6E7F (6845 programmed by the game; 21 rows on the
  menu, 25 rows in play).
- Levels: the disc loads `LevelN` through DFS (`Coder`, at each level);
  the crack loads `Ln` with `*LOAD`; the hack reads them from ROMFS in
  sideways RAM (`*TAPE` then `*ROM`).

## Tools

- `uv sync` installs fantasm, dasmos, oaknut-basic and (dev group) beebium.
- `oaknut-disc` (on PATH) for the disc image: `oaknut-disc ls IMAGE`,
  `get-load`, `get-exec`, `export`.
- `uvx oaknut-basic detokenise FILE` for the BASIC programs.
- `uv run python tools/snapshot_game.py OUT_DIRPATH [STOP_ADDR_HEX]` boots
  the disc in beebium (`model-b-romram` variant, preset
  `model-b-romram-disc`, sideways RAM configured in slots 4 and 5), taps
  SPACE through the BASIC, stops at the game entry, and writes memory
  snapshots and frame captures. The variant must be passed alongside the
  preset or the server refuses to start.

## Conventions

- Hex as &XXXX in prose and comments, 0xXXXX in Python.
- Comment every instruction; banner every routine and data region.
- Published text describes the program as it is; no history of the
  disassembly in comments, banners or docs.
- Variable/function suffixes: `_filename`, `_filepath`, `_dirname`,
  `_dirpath` (never `_dir` or `_file`).

## Findings log

Record anything discovered that matters beyond the disassembly itself
(emulator-compatibility hazards, bugs, inaccurate instructions, candidate
fixes) in `docs/findings.md` as it is found, with the evidence.

## Tooling workarounds and upstream requests

We own beebium, dasmos and fantasm: file a GitHub issue for any missing
feature or defect met along the way, and note the workaround here.

- Multi-file output: each driver loads every file with
  `d.load(..., name=, exec_addr=)` and dasmos saves each (dasmos 4.3.0).
  The disc's `Coder` is a part of `Dun1`, so it cannot be a second loaded
  image; `dunjunz_common.rendering.ExtraSavesBeebasmRenderer` adds its
  `save` through the public `disassembly_end` hook. `fantasm.toml`
  declares one target per file sharing one driver and listing
  (acornaeology/fantasm#25). fantasm's version graph (annotation porting)
  also assumes one binary per version, so annotations shared between
  releases live in `dunjunz_common/`, keyed by runtime address.
- Index regions cannot be declared inside a dasmos move, so
  `Annotator.region` gives each offset in a moved table an `expr_label`
  instead (`trapdoor_x - 1`).
- The official disc's two &0400-&07FF images are two moves to one run
  address. Explicit labels with `move=` render in their own image (the
  joystick image's carry a `_joystick` suffix), but auto-labels and
  `expr_label`s referenced from both images render once, in the keyboard
  image, and the joystick image's operands use them
  (acornaeology/dasmos#54). So every branch target in &0400-&07FF is named
  explicitly in `dunjunz_common/game.py`; `menu_text + 1` in the joystick
  image still names the keyboard image's table.
- fantasm adds a target for every `versions/dunjunz-<id>` directory even
  when `[[targets]]` is configured, and `verify --all` counts those as
  failures (acornaeology/fantasm#26). Each version's main target
  therefore carries the version id (`swram_hack`, `tape_crack_ole`,
  `disc`) so the two coincide.
- No execution coverage in beebium: `tools/coverage.py` uses range
  breakpoints over data plus single-stepping (rob-smallshire/beebium#268).
- oaknut cannot open HFE captures (rob-smallshire/oaknut#93).
  `tools/read_disc_image.py` reads them sector by sector through beebium's
  8271 (preset `model-b-8271-disc`, which has DFS 1.20) and writes an SSD.
  It uses a machine-code OSWORD &7F stub instead of typed BASIC, because
  `basic.wait_for_prompt` returns while a line is still being typed
  (rob-smallshire/beebium#270). With the 1770 preset (DFS 2.26), OSWORD
  &7F read ID returns no IDs.
- `Beebium.launch` needs `variant=` repeated alongside `preset=`
  (rob-smallshire/beebium#269).
