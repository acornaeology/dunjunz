# The Master 128 version

The official 1987 flippy disc has the Master 128 conversion on its boot side,
side 2. Its `BOOT` is signed "Mastered by S Benfield". This document covers
what that side shares with the Model B releases, what it changes, which
Master features it uses, and how it copes with the Master's WD1770 disc
controller and DFS 2.24 (the DFS that beebjit's Master 128 runs, sideways ROM
bank 9 reading "DFS 2.24 (C)1985 Acorn" **[confirmed]**).

The listings are in `versions/dunjunz-disc_master/`, one for each program
on the side: the game (`disasm_dunjunz_disc_master.py`, which applies the
shared game annotations and adds the Master's own), `*DUNJUNZ`, `Coder2`,
`*EDITOR` and `*DEFAULT`. `BOOT` is detokenised in `basic/boot.bas`. Statements are tagged **[confirmed]** (by the bytes,
or by running the side in beebjit's Master 128 with MOS 3.20), or
**[inference]**.

## In brief

- **It is the cassette game, made resident on disc.** It keeps the whole
  game in memory from level to level and loads each level through the
  filing system. The Model B side instead reloads the game and resets the
  machine between levels. 95% of the resident game's bytes match the
  sideways RAM hack's **[confirmed]**.
- **It never touches the disc controller.** Every file, levels included,
  is loaded with `*LOAD` through the filing system, so the WD1770 is
  DFS 2.24's business. The only DFS state the game has to protect is
  page &0D, which DFS uses for its NMI routine. The game saves that page
  at start-up and puts it back before every `*LOAD` **[confirmed]**.
- **It uses the Master's private RAM.** Four files (about 4.9 KB) load
  into HAZEL at &C400–&D8FF: a joystick handler, the screen row offsets
  that MOS 1.20 used to supply, the pause key, and new in-game music
  **[confirmed]**.
- **It relies on MOS 3.20 leaving HAZEL paged in.** No file writes
  ACCCON. The game reads and calls &C000–&DFFF directly, and finds its own
  code there **[confirmed]**.
- **Other Master features used:** MOS 3.20's own entry points, and the
  numeric keypad for one player. It uses no 65C12 instructions, no shadow
  RAM and no CMOS settings **[confirmed]**.

## The files

| File | Load | Exec | Length | Runs at | Contents |
|---|---|---|---|---|---|
| `!BOOT` | — | — | 10 | — | `CH."BOOT"` |
| `BOOT` | &0E00 | &802B | 668 | — | BASIC: on a Master shows `README` and runs `*DUNJUNZ`; otherwise asks for the flip side |
| `README` | — | — | 544 | — | text: turn the disc over after choosing the heroes |
| `Dunjunz` | &2649 | &2649 | &913 | &2649 | `*DUNJUNZ`, the loader and title screen |
| `Coder2` | &2000 | &2000 | &26 | &2000 | installs the joystick handler, then runs `Coder` |
| `Coder` | &0400 | &0740 | &3FF | &0400 | the game's &0400–&07FE, with a loader at &0740 |
| `Dunj3` | &08C0 | &08C0 | &43F | &08C0 | the game's &08C0–&0CFE |
| `Dunj4` | &0E00 | &0E00 | &1200 | &0E00 | the game's &0E00–&1FFF; a new game starts at &0E00 |
| `Dunj5` | &2000 | &2000 | &1000 | &2000 | the game's &2000–&2FFF |
| `Dunj2` | &6E80 | &6E80 | &1180 | &6E80 | the game's &6E80–&7FFF |
| `Code` | &C500 | &C500 | &6C | HAZEL | the joystick handler for BYTEV |
| `Table` | &C5A0 | &C5A0 | &158 | HAZEL | level 25, game over, screen row offsets, pause key |
| `Code2` | &C700 | &C700 | &105A | HAZEL | the music player and its tune |
| `Code3` | &D800 | &D800 | &FF | HAZEL | a copy of the sprite plotter |
| `Screen` | &3280 | &3280 | — | — | the title picture (identical to the Model B side's) |
| `Stones` | &6E80 | &6E80 | &730 | — | ends with level 25 (identical to the Model B side's) |
| `Level1` | &6B00 | &6B00 | &2B0 | — | level 1 (identical to the Model B side's) |
| `Editor` | &1910 | &23B2 | &158E | &1910 | `*EDITOR`, the level editor (see below) |
| `Default` | &0E00 | &0E00 | &47E0 | &0E00 | `*DEFAULT`, which restores a level file from the copies it carries |

Only level 1 is on this side. The README tells the players to turn the
disc over once they have chosen their heroes, "in order to access the
levels of play". The game then loads `LevelN` and `Stones` from the Model
B side **[confirmed by the catalogue and the code]**.

## Starting up

1. **`BOOT`** (BASIC) tests `INKEY-256`. On a Master 128 (253) it types
   `README` in a text window, waits for SPACE and runs `*DUNJUNZ`.
2. **`*DUNJUNZ`** (&2649) loads `Code2`, `Code3` and `Table` into HAZEL.
   It then runs the Model B side's loader start-up, which this file
   contains almost unchanged.
   - It sets ESCAPE off and makes the cursor keys return codes.
   - It sets up the Model B game's level counter and menu tables in page
     &08, which this side's game never reads.
   - It loads the title picture with VDU output disabled and every colour
     black, then reveals it.
   - It twinkles stars on the picture until a key is pressed.
3. **Choosing the next program.** `*DUNJUNZ` reads joystick channel 1. A
   reading near the middle (high byte &80 or &81) means a joystick is
   present, and it runs `CODER2`, which loads `Code` (`*L. Code`), points
   BYTEV at it, and runs `CODER`. Any other reading runs `CODER`
   directly.
4. **`Coder`'s loader** (&0740) does the following, in order:
   - sets the bell sound;
   - copies page &0D to &C400;
   - loads `Dunj2` to `Dunj5`;
   - restores the display that `*DUNJUNZ` blanked;
   - selects COLOUR 2;
   - jumps to &0E00, a new game.

The Master `*DUNJUNZ` is the Model B side's `Dunjunz` (load &26C0) with
&2649–&26BF added in front. Only four of the bytes they share differ:
- &26D2: the final `*CODER` becomes the joystick check.
- &278D: the BREAK intercept at &0287 is left disabled, where the Model B
  loader arms it as `JMP &15B5` to chain levels through a reset.
- &287F and &2887: the row-offset table, &C375 → &C675.

All four are **[confirmed]**.

## What is shared

The resident game has the same layout as the cassette game:
- &0400–&07FF;
- &08C0–&0CFE;
- page &0D, as workspace;
- &0E00–&2FFF;
- &6E80–&7FFF.

Compared byte for byte at the addresses they share (15,294 bytes,
page &0D excluded), the Master game matches the sideways RAM hack in
14,534, the Model B disc in 14,490 and Ole's crack in 14,468
**[confirmed]**.

Its pieces come from several releases:
- **From the cassette game** (as the crack and the hack preserve it):
  - the resident level loop at &0E00–&0ECE;
  - the per-hero menu tables at &06F8;
  - the remains of the cassette level filename at &16D5;
  - the leftover filename "…nz1" at &07F5. The cassette lineage's &0400
    images hold "Dunjunz1" at &07F0.

  So `Coder` was built over a cassette-lineage &0400 image, not over one
  of the Model B disc's, which hold "Dun1" there **[confirmed]**.
- **From the Model B disc:**
  - the level decryption and checksum routine at &0450–&0484;
  - its checksum table, with the correct &4D for level 5, unlike the
    crack's and the hack's &1A (see [findings](../findings.md));
  - the P pause key;
  - the joystick handler;
  - the `*DUNJUNZ` loader.

  All **[confirmed]**.

Several routines in &1400–&1638 are byte for byte the cassette game's, at
new addresses. The listing applies their shared annotations through an
address shift:

| Routine | Cassette lineage | Master |
|---|---|---|
| `reset_workspace` | &14A0 | &150D |
| `draw_view_frames` (its second half) | &14E3 | &1544 |
| `unpack_level` | &1510 | &1571 |
| `reset_monsters` | &1583 | &15E4 |
| `clear_text_area` | &161A | &1619 |

## What is different

- **Starting a level** (`start_level`, &1400, rewritten). In order, it:
  - stops the music;
  - counts the level;
  - puts the MOS's page &0D back from &C400;
  - shows 15 rows;
  - loads `LEVELnn` with `*LOAD LEVELnn 6B00` (level 25 from `Stones`,
    via `Table`);
  - decrypts and checks the level;
  - unpacks it and rebuilds page &0D as the game's workspace;
  - resets the monsters;
  - draws the views;
  - restarts the music.

  After the first level the music's position is saved on the stack and
  restored, so the tune carries on from level to level. The cassette's
  "LEVEL n" screen is gone **[confirmed]**.
- **Screen addresses.** `screen_address` (&0967) and the title's star
  plotter read the row × 640 table from `Table` at &C675, a copy of the
  MOS 1.20 table at &C375. MOS 3.20 has no such table **[confirmed
  against the MOS 3.20 ROM]**.
- **Text.** The WRCHV handler's first instruction (&7F8F) is now
  `JMP &E822`, MOS 3.20's OSWRCH. So the game's own font routine never
  runs, and text appears in the MOS font **[confirmed; &E822 is WRCHV's
  value under MOS 3.20 in beebjit]**.
- **Keys.** Three of the four heroes' keys change, and the Magic-User
  moves to the Master's numeric keypad:

  | Hero | Up, down, right, left, fire (as the game's tables name them); magic | Model B side |
  |---|---|---|
  | Ranger | CAPS LOCK, SHIFT LOCK, Z, SHIFT, TAB; CTRL | the same |
  | Magic-User | keypad #, keypad DELETE, keypad `,`, keypad 3, keypad `*`; keypad ENTER | →, ↑, COPY, DELETE, ↓; RETURN |
  | Barbarian | G, B, M, N, SPACE | K, `,`, `/`, `.`, SPACE |
  | Fighter | `_`, RETURN, COPY, DELETE, `[` | G, B, I, U, O |

  The joystick handler drives the Barbarian's keys, as it does on the
  Model B side **[confirmed]**.
- **Joystick.** `Code` (&C500) is the Model B side's BYTEV handler, moved
  to HAZEL, with the Barbarian's new keys. It passes every other call to
  &EEB1, MOS 3.20's OSBYTE **[confirmed; BYTEV holds &EEB1 under MOS 3.20
  in beebjit]**. It is installed only when the joystick reads as present
  at start-up.
- **Music.** `Code2` adds music during play, which the Model B releases do
  not have.
  - **Set-up:** `start_music` defines envelopes 6–9 and points EVNTV at
    `music_event`. It enables the interval-timer event and sets the timer
    to −12 centiseconds.
  - **Each step:** each event plays a three-byte tune step (a
    transposition, a channel 2 pitch and a channel 3 pitch). It also
    plays one step of a 32-step rhythm on channel 1 with the noise
    channel.
  - **Song:** the tune is 24 sections long and then loops.
  - **Firing:** the bell (VDU 7) that sounds when a missile is fired is
    replaced by NOPs at &6F45.

  The event handler runs with HAZEL paged in (ACCCON &18 at &C76C)
  **[confirmed]**.
- **The sprite plotter is redirected to a copy.** `start_music` overwrites
  the first three bytes of `plot_sprite` (&0900) with `JMP &D800`. `Code3`
  at &D800 is a copy of &0900–&09FE. It is identical apart from the
  relocated `JSR screen_address`, so every sprite is then plotted from
  HAZEL **[confirmed]**. Why the copy was made is not clear from the code.
- **Pause** is P, as on the Model B side, handled by `pause_check` in
  `Table` (&C6D0). The game's own pause routine at &1ED7 now just jumps
  there **[confirmed]**.
- **Game over** stops the music. The wait for a key before a new game is
  &1F4 centiseconds (5 s), against 60 s in the crack and the hack and
  &246 in the Model B disc **[confirmed]**.

## The disc controller and the DFS

The Model B disc works only with DFS 0.90 on real hardware (see
[findings](../findings.md) and the [stardot
notes](../stardot-dunjunz-versions-thread.md)). The game overwrites
&0D00–&10FF, the DFS 1.20 NMI and workspace area, and moves between
levels by resetting the machine through a BREAK intercept.

The Master version avoids every part of that:

- **No reset between levels.** The game stays resident, the BREAK
  intercept is left disabled, and nothing jumps to a reset entry except
  a failed level checksum (below) **[confirmed]**.
- **No direct disc access.** All loading is `*LOAD` through OSCLI, so the
  1770's driver is DFS 2.24's own. Nothing in the eleven files touches
  &FE24–&FE2F **[confirmed]**.
- **Page &0D is saved and restored.** On the Master, page &0D holds the
  filing system's NMI code: in beebjit its first bytes are
  `PHA : LDA &FE28 …`, reading the 1770's status register. `Coder`
  copies the page to &C400 in HAZEL before loading the game, and
  `load_level` copies it back before every `*LOAD`. Only after the load
  does `reset_workspace` rebuild page &0D as the game's workspace from
  `workspace_template`. Just before the first level's `*LOAD`, page &0D
  and &C400 hold identical bytes **[confirmed in beebjit]**.
- **&0E00–&10FF is free on a Master.** DFS 2.24 keeps its workspace in
  HAZEL; its catalogue is at &C000 in beebjit **[confirmed]**. So the game
  can occupy page &0E onwards without harming the filing system
  **[inference from the layout; the game runs]**.
- **HAZEL is shared without collisions.** The game's HAZEL files occupy
  &C400–&D8FF. While level 1 loads, nothing writes anywhere in that range
  until the game's own `start_music` runs **[confirmed with a beebjit
  write watchpoint]**. Before the game starts, DFS had left part of
  `README`'s text at &C500, which `Code` then overwrites. So DFS uses some
  of that area as a buffer, and the game's files must load after any file
  reading such as `*TYPE` **[confirmed]**.

In short, the conversion accommodates the WD1770 and DFS 2.24 by not
competing with them. It lets the DFS do all the loading and keeps the
DFS's NMI page intact whenever the DFS runs.

## The level editor and the level restorer

The README offers two more programs: `*EDITOR` to edit levels and
`*DEFAULT` to restore a level "back to its original format". Both work on
the level files of the side in the drive, so the disc is turned over for
them too. The Model B side has its own copies, which the README says are
"for the BBC model B ONLY".

**`*EDITOR`** (&1910, run at &23B2) **[confirmed from its code]**:
- **Start-up.** It copies its plotter page (&2700–&28FF) to &0900, the
  game's sprite plotter's home. That page holds the game's `plot_sprite`
  and `screen_address`, unchanged except that they read the editor's own
  sprite tables, together with those tables and a copy of the game's
  level checksum table. It also copies two routines to &7B00 and &7D80.
- **Choosing a level.** It asks whether to edit a level or start a new
  one, then whether to use disc or tape (and, for disc, which drive), and
  `*LOAD`s the file at &2700, over the plotter page's old copy.
- **Unpacking.** It decrypts the level and unpacks it into 80 item slots,
  a wall map and an object-free map. It drops any object of type &73, the
  Chalice, which only level 25 has and the editor has no sprite for. It
  draws the 32 × 48 map in MODE 2, each cell two bytes wide and five pixel
  rows high.
- **Editing.** The cursor moves with `,` `.` `A` `Z`; f0 slows it down.
  `1` and `2` choose the item: a wall, the exit, a trapdoor (labelled
  "Mons"), a door, a key, or one of eleven objects. SPACE places the item
  and TAB deletes. To give a door its key, choose the key, press SPACE on
  the door, then place the key. Holding CTRL draws each door–key link as
  a line. The limits are one exit, eight trapdoors, 20 doors and 29
  objects.
- **Saving.** SHIFT+S saves, once the exit, all eight trapdoors and every
  door's key are placed:
  - It walls in the map's edges and packs the slots into the level file.
  - It loads `Stones` and lets the player choose one of its 24 wall
    blocks.
  - It asks for the level's number (1–24). It sets the level's unused
    first byte so that the bytes sum to that level's entry in the
    checksum table, encrypts the level and saves it under the filename
    typed.
  - Pressing nothing at the level-number prompt catalogues the disc and
    calls `Table`'s `*FREE` routine at &C6C0, which the game itself never
    uses.
- **Errors and BREAK.** BRKV points at MOS 3.20's reset entry (&E364), so
  any filing system error restarts the machine. BREAK returns to the
  start, or to the save prompt while saving, through the BREAK intercept.

The packing walks the slots from the last to the first, while unpacking
fills them from the last down. So every load and save reverses the order
of each table (the exit stays in entry 30). That is the signature of the
eight revised levels on the disc (see [findings](../findings.md)).

The Master conversion of the editor changes only a handful of things from
the Model B side's **[confirmed by comparing the two]**:
- BRKV &D9CD (MOS 1.20's reset entry) → &E364 (MOS 3.20's), and the final
  `JMP &D9CD` → `JMP (&FFFC)`;
- the screen row table &C375 → &C675, with `*L. TABLE` on the first run;
- the catalogue's free-space display, now `Table`'s routine.

The rest is the same code, moved 19–21 bytes by those changes.

**`*DEFAULT`** (&0E00) asks for a level number and saves that level's
original file. It carries all 25 levels, encrypted, at &12B0 **[confirmed]**:
- **Its copies.** They match the Model B side's files, except level 6,
  which is the cassette's version (see [findings](../findings.md)).
- **Level 25 is accepted.** It is saved as `Level25`, a file the game
  never reads, since the game takes level 25 from `Stones`. A typed
  leading zero is kept too, so `05` is saved as `Level05`.
- **Its leftovers.** Between the code and the levels lies the end of
  `*DEFAULT`'s own tokenised BBC BASIC assembler source, lines 1150–1370.
  The listing shows it line by line.

The Model B side's `Default` carries only levels 1–24.

## Hazards and oddities

- **A failed checksum on a Master runs `BRK`.** The checksum routine
  still ends with `JSR &D9CD`, the MOS 1.20 reset entry. With HAZEL paged
  in, &D9CD is private RAM, which holds zeros in beebjit, so a tampered
  level executes BRK rather than resetting **[confirmed that &D9CD holds
  0; the effect is an inference]**. The conversion of `*EDITOR` did
  replace its uses of &D9CD with MOS 3.20's reset entry, &E364, so this
  one was missed rather than unknown **[inference]**.
- **The Model B side's title animation also uses MOS 1.20.** Its star
  plotter reads the row table at &C375 (`Dunjunz` &287D and &2885 on the
  Model B side) **[confirmed]**.
- **Leftovers:**
  - the Model B loader's page &08 set-up;
  - the BREAK intercept address &15B5;
  - part of a `*DUNJUNZ` restart routine at &C60E;
  - the rest of the cassette pause routine at &1EDA;
  - the unused body of the game-font WRCHV handler at &7F92;
  - the line-input buffer leftovers at &0700, including the command
    `*SA. CODER 400+3FF 740`.

  All **[confirmed]**.

## Not yet examined

- **What happens if the disc is not turned over**, against the README's
  instructions. The Master side has only `Level1`, so asking for level 2
  there should give a DFS error, which the game does not trap. In beebjit,
  with the level digit changed to 2 just before the first load, the
  emulation reached none of the probe's later breakpoints, so the outcome
  is not yet known.
- **The remainder of `Code2`**, its tune data, has not been transcribed
  into notes.
