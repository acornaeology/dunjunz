# CLAUDE.md

## What this is

Annotated disassembly of **Dunjunz** by Julian Avis (Bug-Byte, 1986) for the
BBC Micro Model B, produced with dasmos and verified by reassembly. The aim is
to understand how the game works so that emulators can support it better and
fixes can be made, and to publish a buildable, annotated reassembly via the
sibling `acornaeology.github.io` site, like the other acornaeology projects.
Follow the `disassembly-skills:6502-disassembly` skill's method.

## Source artefacts and history

Three releases live under `versions/` (see `versions/README.md`): Ole's
crack of the cassette, an archive of the 1987 flippy disc, and the
unofficial sideways RAM hack. None is a pristine original. How they
relate is written up in `docs/history-and-provenance.md`; keep it current
as evidence accumulates, tagging statements [confirmed], [reported] or
[inference].

The first version disassembled:

`versions/cbbcga-dunjunz/Disc060-DunjunzRx2.ssd` — the BBC Micro Games
Archive "Sideways RAM version". See `docs/disc-contents-and-loading.md` for
the full catalogue, the boot chain and the confirmed runtime memory map.

## Binaries

| File | Load | Exec | Size | Notes |
|---|---|---|---|---|
| `Dunjun4` | &0400 | — | &0900 | game code/data |
| `Dunjun7` | &0D00 | — | &0400 | game code/data; loaded at &3000 then copied to &0D00; game entry &0D31 |
| `Dunjun5` | &1100 | — | &1F00 | game code/data |
| `Dunjun6` | &6E80 | — | &1180 | game code/data, just above the play screen |
| `TITLE` | &3800 | &38C6 | &0C00 | title page machine code (separate program) |
| `Dunjun1`/`Dunjun2` | SWR | — | &0D00/&4000 | Beebug ROMFS images holding `LEVEL1`–`LEVEL25` |
| `DUNJUNZ`, `DUNK` | &1900, &2500 | — | — | tokenised BASIC (instructions/intro; SWR and game loader) |
| `PIC`, `Dunjun3` | &3000, &3280 | — | — | MODE 2 pictures (intro face; loading screen) |

- CPU: 6502 (NMOS), BBC Model B. The game refuses to run on a Master 128.
- Game screen: &3000–&6E7F (6845 programmed by the game; 21 rows on the
  menu, 25 rows in play).
- Levels are read from ROMFS in sideways RAM (`*TAPE` then `*ROM`).

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

- Multi-file output: `dunjunz_common.rendering.MultiFileBeebasmRenderer`
  overrides the beebasm renderer's private `_save_directive` to save each
  original file (acornaeology/dasmos#49), and `fantasm.toml` declares one
  target per file sharing one driver and listing
  (acornaeology/fantasm#25). fantasm's version graph (annotation porting)
  also assumes one binary per version, so annotations shared between
  releases live in `dunjunz_common/`, keyed by runtime address.
- Overlapping moves: the crack's `DUNJ4` stores &0400-&2FFF at &2400. A
  dasmos move over that overlap breaks reassembly (acornaeology/dasmos#51,
  #52), so the tape driver loads the image at its run address and emits a
  `copyblock` before saving.
- The official disc's two &0400-&07FF images are two moves to one run
  address. dasmos renders every label at such an address in the first
  move's section (acornaeology/dasmos#53), so labels go only in the
  keyboard image; the joystick image gets comments, banners and entries
  (placement suffix None in `dunjunz_common.annotator`).
- Synthesised offset bases inside data are named `sub_XXXX`; they are not
  subroutines (acornaeology/dasmos#50). Declaring the data removes them.
- No execution coverage in beebium: `tools/coverage.py` uses range
  breakpoints over data plus single-stepping (rob-smallshire/beebium#268).
- `Beebium.launch` needs `variant=` repeated alongside `preset=`
  (rob-smallshire/beebium#269).
