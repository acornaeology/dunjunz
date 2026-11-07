# CLAUDE.md

## What this is

Annotated disassembly of **Dunjunz** by Julian Avis (Bug-Byte, 1986) for the
BBC Micro Model B, produced with dasmos and verified by reassembly. The aim is
to understand how the game works so that emulators can support it better and
fixes can be made, and to publish a buildable, annotated reassembly via the
sibling `acornaeology.github.io` site, like the other acornaeology projects.
Follow the `disassembly-skills:6502-disassembly` skill's method.

## Source artefacts and history

Four versions live under `versions/` (see `versions/README.md`):

- `dunjunz-disc/`: the reference version, the official 1987 flippy disc's
  Model B side.
  It holds HFE flux captures of both sides, the SSDs and track reports
  derived from them (`tools/read_disc_image.py`), and the NVG archive's
  `Dunjunz.zip`, whose files are identical. `binary/` holds `Dun1` and
  `Coder` (the game) and `Dunjunz`, `Editor` and `Default` (separate
  programs) exported from the Model B side's SSD.
- `dunjunz-disc_master/`: the same disc's Master 128 side, the official
  Master conversion (`docs/analysis/the-master-128-version.md`). `binary/`
  holds its machine-code files, exported from the Master side's HFE in
  `dunjunz-disc/`. Each separate program has its own driver and listing
  (`disasm_dunjunz_disc_master_<program>.py`), declared to the site under
  `disassemblies` in `binary.json`; the game (nine files) is the primary
  listing.
- `dunjunz-tape_crack_ole/`: Ole's crack of the 1986 cassette. No image of
  the original cassette has been found; it would go in `dunjunz-tape/`.
  `EXPAND` (the intro's picture unpacker) is a separate listing; the BASIC
  `PLOAD` and `DUNJ`, and the manual `DUNJ` carries, are source files
  (`basic/`, `text/`).
- `dunjunz-swram_hack/`: the unofficial sideways RAM hack, built from the
  crack and the disc (the BBC Micro Games Archive "Sideways RAM version",
  `Disc060-DunjunzRx2.ssd`; see `docs/disc-contents-and-loading.md` for
  its catalogue, boot chain and runtime memory map). `TITLE` is a separate
  listing; `!BOOT`, `DUNJUNZ` (with its controls page) and `DUNK` are
  source files.

In every version each separate program has its own driver and listing
(`disasm_dunjunz_<version>_<program>.py`), declared to the site under
`disassemblies` in `binary.json`, and the game is the primary listing.
Programs are not merged into one listing even when they share addresses.
BASIC and text files are declared under `source_files`. Annotations for a
program on both sides of the disc live in `dunjunz_common/` (`editor.py`,
`title_loader.py`); `editor.Remapped` moves the Master side's addresses
to the Model B side's.

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
| `TITLE` (hack) | &3800 | &38C6 | &0C00 | title page (MODE 5), its own listing |
| `Dunjun1`/`Dunjun2` | SWR | — | &0D00/&4000 | Beebug ROMFS images holding `LEVEL1`–`LEVEL25` |
| `DUNJUNZ`, `DUNK` | &1900, &2500 | — | — | tokenised BASIC (instructions/intro; SWR and game loader) |
| `PIC`, `Dunjun3` | &3000, &3280 | — | — | MODE 2 pictures (intro face; loading screen) |
| `Dunjunz` (disc) | &26C0 | &2700 | &089C | `*DUNJUNZ`: page &08 set-up, title stars, arms the BREAK intercept, `*CODER` |
| `Editor` (disc) | &1910 | &239D | &158E | `*EDITOR`; the Master's, for MOS 1.20, code from &1C3A on &13–&15 bytes lower |
| `Default` (disc) | &1900 | &1900 | &4530 | `*DEFAULT`; levels 1–24 encrypted at &1DB0 |
| `EXPAND` (crack) | &2E00 | &2E00 | &01A7 | `*EXPAND`, run-length picture unpacker (Rhys E. Davies, 1985) |
| `Dunjunz` (Master) | &2649 | &2649 | &0913 | `*DUNJUNZ`: loads the HAZEL files, title stars, runs `CODER2`/`CODER` |
| `Coder2` (Master) | &2000 | &2000 | &0026 | `*L. Code`, BYTEV = &C500, `*CODER` |
| `Coder` (Master) | &0400 | &0740 | &03FF | game &0400–&07FE; loader at &0740 saves page &0D at &C400, loads `Dunj2`–`Dunj5`, enters &0E00 |
| `Dunj3`/`Dunj4`/`Dunj5`/`Dunj2` (Master) | &08C0/&0E00/&2000/&6E80 | same | &43F/&1200/&1000/&1180 | the resident game |
| `Code`/`Table`/`Code2`/`Code3` (Master) | &C500/&C5A0/&C700/&D800 | same | &6C/&158/&105A/&FF | HAZEL: joystick handler; level 25, game over, row offsets, pause; music; plotter copy |
| `Editor` (Master) | &1910 | &23B2 | &158E | `*EDITOR`, the level editor; copies &2700–&28FF to &0900, &1910 to &7B00 and &1A00 to &7D80 |
| `Default` (Master) | &0E00 | &0E00 | &47E0 | `*DEFAULT`, the level restorer; levels 1–25 encrypted at &12B0 |

- CPU: 6502 (NMOS), BBC Model B. The disc's Master 128 side runs on the
  65C12 but uses no 65C12-only instruction, so it is disassembled as 6502
  too; it relies on MOS 3.20 leaving HAZEL paged in (ACCCON &18). The
  hack's loader refuses to run on a Master.
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

- `uv run python tools/disc_level_probe.py OUT_DIRPATH` runs the official
  disc's Model B side in beebium with DFS 0.90 (a preset made on the fly
  from the bundled `acorn-dfs_0_90.rom` and the 8271), plays into a level
  and follows the end-of-level reset to the next: a pattern for testing
  the disc release at run time.

- `uv run python tools/timing_probe.py TEST` measures the timing findings
  in vsyncs (`hack_pause`, `game_over`, `monster_step`, `disc_repause`),
  stopping with `debugger.run_to(addr, skip_current=True)`; the polling
  `run_until` in `disc_level_probe.py` can miss an arrival.

- `uv run python tools/master_probe.py BEEBJIT_FILEPATH ADDR [DUMP ...]
  [--then 'cmds']` runs the Master side in beebjit (beebium has no Master
  yet, rob-smallshire/beebium#189) and reports registers, ACCCON and
  memory at a breakpoint. Its docstring says how to build beebjit outside
  its checkout.

- `uv run python tools/quality.py LISTING_JSON ... [--list KIND]` reports what
  comment coverage does not: dasmos-generated labels, routines without a
  calling convention, uncommented data, raw-address operands and hex
  immediates. `tools/registers.py` suggests a routine's register inputs
  and what it corrupts (following calls); `tools/address_pairs.py` finds
  immediate pairs that are the halves of a labelled address.
  `tools/cross_check.py REFERENCE_JSON OTHER_JSON ...` flags shared
  operand expressions that land on different code in another version,
  which a passing round trip cannot catch when the values coincide.

## Conventions

- Hex as &XXXX in prose and comments, 0xXXXX in Python.
- No dasmos-generated label names: name every branch target (the
  game's are in `game.annotate_branch_labels`). Sprite numbers are `spr_`
  constants from `game.SPRITES`; counts, pages and addresses are written
  from labels and constants rather than as numbers.
  VDU parameter bytes, bit masks, sound pitches and similar values stay
  as numbers, explained by their inline comments.
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
  `save` through the public `disassembly_end` hook. `fantasm.toml` has one
  target per listing, listing a multi-file game's files under `images`
  (fantasm 1.4.0); the disc target lists `Coder` too, which verify checks
  against the extra save. fantasm's version graph (annotation porting)
  assumes one binary per version, so annotations shared between
  releases live in `dunjunz_common/`, keyed by runtime address.
- Index regions cannot be declared inside a dasmos move
  (acornaeology/dasmos#60), so `Annotator.region` gives each offset in a
  moved table an `expr_label` instead (`trapdoor_x - 1`). Each expression
  label starts a new item, so on the disc those tables list one entry per
  line; the disc driver's `DISC_TABLE_ENTRIES` comments them.
- The official disc's two &0400-&07FF images are two moves to one run
  address. Each image's labels are its own (the joystick image's carry a
  `_joystick` suffix), and every branch target in the page is named in
  `dunjunz_common/game.py`.
- No execution coverage in beebium: `tools/coverage.py` uses range
  breakpoints over data plus single-stepping (rob-smallshire/beebium#268).
- oaknut cannot open HFE captures (rob-smallshire/oaknut#93).
  `tools/read_disc_image.py` reads them sector by sector through beebium's
  8271 (preset `model-b-8271-disc`, which has DFS 1.20) and writes an SSD.
  It uses a machine-code OSWORD &7F stub instead of typed BASIC, because
  `basic.wait_for_prompt` returns while a line is still being typed
  (rob-smallshire/beebium#270). With the 1770 preset (DFS 2.26), OSWORD
  &7F read ID returns no IDs.
- dasmos drops `description=` for labels inside a loaded image
  (acornaeology/dasmos#61); `Annotator.label` and `Annotator.region`
  repeat it as a block comment where the address is loaded.
- An inline comment on an OS call is joined to the environment's own
  description of the call, with a single space in the JSON
  (acornaeology/dasmos#62); end such comments so the join still reads.
- A block comment at a routine's own address renders as part of its
  banner in the beebasm output (acornaeology/dasmos#63); put a phase
  comment for a routine's start into its description instead.
- `Beebium.launch` needs `variant=` repeated alongside `preset=`
  (rob-smallshire/beebium#269).
- Shared annotations meet the Master side's differing code through
  `Annotator(skip=...)` (ignore calls at addresses where the code
  differs), `default_group=` (memory-map groups for labels outside plain
  images), and the Master driver's `Shifted` proxy, which re-applies the
  shared annotations to routines that sit at other addresses (and to
  `Code3`, the plotter copy, with a `_hazel` suffix).
