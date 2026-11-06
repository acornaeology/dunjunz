# Dunjunz disc: contents and loading sequence

Source image: `versions/dunjunz-swram_hack/Disc060-DunjunzRx2.ssd` (BBC Micro
Games Archive, "Sideways RAM version"). Single-sided 40-track DFS, title
`DUNJUNZ`, boot option 3 (EXEC), 12 files.

## Catalogue

| File | Load | Exec | Length | Range | Content |
|---|---|---|---|---|---|
| `!BOOT` | — | — | &0030 | — | `*EXEC` text: `*BASIC`, `PAGE=&1900`, `*FX21`, `CHAIN "DUNJUNZ"` |
| `DUNJUNZ` | &1900 | &1900 | &2200 | &1900–&3AFF | Tokenised BASIC: instructions and intro sequence; a MODE 7 controls screen is stored after the program at &3700–&3AFF |
| `PIC` | &3000 | &3000 | &4FFF | &3000–&7FFE | MODE 2 screen: digitised face of Mackscrane, flashed by the intro |
| `TITLE` | &3800 | &38C6 | &0C00 | &3800–&43FF | Machine code (MODE 4): title/credits and keys page ("f1 Pause On/Off", "5 Sound On", "6 Sound Off") |
| `DUNK` | &2500 | &8023 | &09E5 | &2500–&2EE4 | Tokenised BASIC: sideways RAM loader and game loader |
| `Dunjun1` | &8000 | &D9CD | &0D00 | — | Sideways RAM image: Beebug ROMFS, `LEVEL22`–`LEVEL25` |
| `Dunjun2` | &8000 | &D9CD | &4000 | — | Sideways RAM image: Beebug ROMFS, `LEVEL1`–`LEVEL21`, `!HELP` |
| `Dunjun3` | &3280 | &3280 | &3200 | &3280–&647F | MODE 2 screen rows 1–20: loading-screen title art |
| `Dunjun4` | &0400 | &0400 | &0900 | &0400–&0CFF | Game code/data |
| `Dunjun5` | &1100 | &1100 | &1F00 | &1100–&2FFF | Game code/data |
| `Dunjun6` | &6E80 | &6E80 | &1180 | &6E80–&7FFF | Game code/data |
| `Dunjun7` | &0D00 | &0D00 | &0400 | &0D00–&10FF | Game code/data; contains the game entry &0D31. Loaded at &3000 and copied to &0D00 |

The load/exec addresses of `Dunjun1`/`Dunjun2` (&8000/&D9CD) are not used:
`DUNK` loads them with an explicit address.

## Loading sequence

1. **`!BOOT`** selects BASIC, sets `PAGE=&1900`, flushes buffers
   (`*FX21`) and chains `DUNJUNZ`.
2. **`DUNJUNZ`** (BASIC) refuses to run if `PAGE>&1900`; if `PAGE<=&1100`
   it copies itself down to &1100 and re-runs (line 650). It shows the
   instruction pages (MODE 7), then copies its trailing &3700–&3AFF to the
   MODE 7 screen at &7C00 (the controls table), waits for a key, loads
   `PIC` into MODE 2 and plays the scrolling intro (ESCAPE skips it). It
   then runs `*/TITLE` in MODE 4, does `*FX225` and `*TV255`, sets
   `PAGE=&2500` and chains `DUNK`.
3. **`TITLE`** (machine code at &3800, entry &38C6) shows the title/credits
   page.
4. **`DUNK`** (BASIC, `HIMEM=&3C00`):
   - refuses to run on a Master 128 (`INKEY(-256)` = &FD or &F5);
   - `PROCROM` checks that socket 15 is not writable RAM, surveys the
     sockets (`PROCROMSLOTS`), then for each of `DUNJUN1` and `DUNJUN2`
     takes the next candidate socket above 3, `*LOAD`s the image at &3C00
     and copies 16 KB (`?&75=S%*4` = 64 pages) from &3C00 into the
     socket with a small copier assembled at &0380. `FNtest` reads the
     first four bytes back with OSRDRM and reports "Image has not loaded"
     if they differ. `Dunjun1` (levels 22–25) therefore goes to the lower
     socket and `Dunjun2` (levels 1–21) to the next one: banks 4 and 5 on
     a machine with RAM there.
   - It programs `*KEY10` (BREAK) to re-enter the game after a reset,
     enters MODE 2 with all colours black and a text window over rows
     0–20, and assembles and calls a machine-code loader at &6480.
5. **Loader at &6480** (assembled by `DUNK` lines 60–170):
   - `*L.Dunjun3` (loading screen into MODE 2 screen memory), VDU 20 to
     restore the palette and reveal it;
   - `*L.Dunjun4`, then OSBYTE &81 with a &01FF centisecond timeout
     (about 5 s, or until a key);
   - `*L.Dunjun5`, `*L.Dunjun6`;
   - all 16 logical colours set to black, CLS (clears the text window,
     &3000–&647F, wiping the loading screen);
   - `*L.Dunjun7 3000`, then OSBYTE 140 (`*TAPE`);
   - copies &3000–&33FF to &0D00–&10FF (`Dunjun7` to its run address);
   - CLS, VDU 20, `COLOUR 2`, `*ROM`, `*OPT1,0`, `JMP &0D31`.

## Game memory map at entry (&0D31)

Confirmed by snapshotting main memory in beebium when the PC first reaches
&0D31 (`tools/snapshot_game.py`): `Dunjun4`, `Dunjun7`, `Dunjun5` and
`Dunjun6` are byte-identical to the files at &0400, &0D00, &1100 and &6E80;
&3000–&647F is all zero; sideways RAM banks 4 and 5 hold `Dunjun1` and
`Dunjun2` exactly.

| Range | Content |
|---|---|
| &0000–&03FF | Zero page, stack, OS workspace |
| &0400–&0CFF | `Dunjun4` |
| &0D00–&10FF | `Dunjun7` (entry &0D31) |
| &1100–&2FFF | `Dunjun5` |
| &3000–&6E7F | Screen memory (see below) |
| &6E80–&7FFF | `Dunjun6` |
| SWR bank 4 | ROMFS: `LEVEL22`–`LEVEL25` |
| SWR bank 5 | ROMFS: `LEVEL1`–`LEVEL21`, `!HELP` |

The game programs the 6845 itself. On the hero-selection menu the screen
starts at &3000 with 21 character rows of 80 bytes per row-line
(R1=&50, R6=&15): &3000–&647F. During play it shows 25 rows (16000 bytes),
&3000–&6E7F, ending exactly where `Dunjun6` begins. The play screen is four
quarter views (top left Ranger, top right Wizard, bottom left Barbarian,
bottom right Warrior) plus a status column on the right.

The game code is therefore resident in &0400–&2FFF (11 KB in three files)
and &6E80–&7FFF (4.4 KB). The bytes `Dunjun3` puts at &3280–&647F are only a
loading screen and are erased before the game starts.

## Levels

The level files are stored in Beebug ROMFS images (the header reads
`RFS (C) BEEBUG`): each `LEVELn` is a 3-block ROMFS file of about &2ED bytes
with load and exec address 0. The game selects the cassette filing system
(OSBYTE 140) and then `*ROM`, so levels are read through the MOS's ROM
filing system, the same code path as the original cassette version's
loading of levels from tape.

## Notes for emulator compatibility

See [findings.md](findings.md) for the loader's sideways RAM detection,
its socket choice, and where the instructions disagree with the loader.

## Answered since

- How a level is loaded: `load_level` (&1446) calls the filing system's
  FILEV routine directly with an OSFILE block at &6E60, loading `LEVELn`
  from ROMFS to &6B00; `decrypt_level` (&0450) decrypts and checks it.
- The level format: see [level-format.md](level-format.md).
- What the game files contain: see
  [analysis/how-the-game-works.md](analysis/how-the-game-works.md).

## Open questions

- What `TITLE` (&3800) does beyond drawing the title page; it has not
  been disassembled.
