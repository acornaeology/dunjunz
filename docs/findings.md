# Findings

Facts discovered during the disassembly that matter beyond it: emulator
compatibility, bugs, inaccuracies in the game's own instructions, and
candidate fixes. Each entry gives the evidence so it can be acted on
later without re-deriving it.

## Loader (`DUNK`)

### Sideways RAM detection assumes empty sockets read &80

`PROCROMSLOTS` (`DUNK` lines 560–720) never tests whether a socket can be
written. For each socket 15 down to 0 it reads, through OSRDRM, the
copyright-offset byte at &8007 and the three bytes after the offset it
points to, and stores them after a fixed &80 at &77:

- `!&77 = &29432880` (&80 then `(C)`): a ROM; not a candidate.
- `!&77 = &80808080`: treated as an empty socket; not a candidate.
- anything else: marked as available RAM (`B%(SOCKET)=1`).

The &80 test assumes an empty socket reads back the high byte of the
address bus (&80 for every byte read from &8000–&80FF). An empty socket
that reads any other value (&FF, &00, or noise) is taken for RAM. The
image is then copied into it, `FNtest` reads back a mismatch, and the
loader stops with "Image has not loaded".

Consequences:
- An emulator whose empty sockets do not read &80 makes the loader choose
  an empty socket ahead of real RAM in a higher-numbered socket.
- Write-protected sideways RAM holding no ROM is chosen too, and fails
  the same way.

Possible fix: write and read back a test byte in each candidate socket
before choosing it.

### Bank choice is "first two candidates above 3", not banks 4 and 5

`PROCROM` (`DUNK` lines 180–330) starts with `B%=3` and, for each image,
increments `B%` until `B%(B%)=1` or `B%=15`. `DUNJUN1` (levels 22–25) goes
to the first candidate socket in 4–14 and `DUNJUN2` (levels 1–21) to the
next. If no candidate is found below 15 it stops with "NO ROM AVAILABLE IN
MACHINE".

### Socket 15 is checked for being writable

`PROCROM` writes `DUNJUNTEST` to &8000 in main memory, reads ten bytes of
socket 15 with OSRDRM and stops with "SOCKET 15 NOT WRITE PROTECTED" if
they match. The sockets used for the levels must be below 15.

### Master 128 refused

`DUNK` line 20 stops with "Dunjunz does not work on a Master 128." when
`INKEY(-256)` returns &FD or &F5.

## Instructions (`DUNJUNZ`)

### The banks the instructions name are not the ones the loader uses

Lines 410–430 say: "This version of the game has been set to load levels
1-21 into BANK 5 and levels 22-25 into BANK 4. If these slots are not
available in your machine then you must change the code in the DUNK file
accordingly". The loader does not use fixed banks (see above): it takes
the first two candidate sockets above 3, and no change to `DUNK` is
needed when banks 4 and 5 are absent. The text is correct only for a
machine whose lowest two sideways RAM sockets are 4 and 5 and whose
sockets 0–3 hold ROMs or read as empty.

Possible fix: say that the levels need two sideways RAM banks in sockets
4–14, and that socket 15 must not be writable.

### Wizard and Ranger descriptions are swapped

Lines 210–240 give the "Magic-User/Wizard" 3 arrows, leather armour and
magic that "drains his energy badly", and the "Ranger" 2 fireballs, a
robe that "takes maximum damage" and magic that "uses hardly any energy".
The story text (lines 130–140) says the opposite: "The Ranger uses a bow",
"The Wizard has been taught how to cast powerful fireballs". The game
code agrees with the story text, so the two headings in lines 210–240 are
swapped. In the code (hero 0 Ranger, hero 1 Magic-User, matching the menu
and the top-left/top-right views):

| | Ranger (hero 0) | Magic-User (hero 1) | Where |
|---|---|---|---|
| Missiles | arrows (sprites 17–20) | fireballs (69–72) | `hero_missile_sprites` |
| Missiles in flight | 3 | 2 | starting table at &0F80 |
| Missile damage | 2 | 3 | starting table at &0F84 |
| Health lost per hit | 7 (armour 3) | 9 (armour 1, the worst) | starting table at &0F88 |
| Health cost of magic | 6 | 3 | magic code at &7647 |

(The instructions' "each fireball does the same damage as two arrows"
does not match 3 against 2 either.)

### The Cross of Resurrection resurrects; it does not raise armour

Line 340 describes the Cross with the same words as the Magic Helmet:
"Increases armour rating by 1 point". In the code, collecting a Cross
(object type &2A, `collect_objects`) scores ten points and brings back
the first hero waiting in `returning_hero_queue`, a hero who died on this
level. The hero materialises and returns with health 32. Only the helmet
(&60) lowers `hero_damage_taken`.

### Energy drainers take 10 health a frame, so 20 for a crossing

Line 310 says an Energy Drainer makes you "Lose 20 health points".
`collect_objects` calls `lose_health_point` ten times when it finds a
drainer (types &53–&5E) in the hero's cell, and leaves the drainer there.
It is called through `draw_moved_hero` (&70BE) on every frame a hero in
play is handled: standing still (&6F15), firing (&6F6C, &6F76), the
half-step frame and arrival. On the half-step frame of leaving,
`stay_in_old_cell` keeps the hero in the drainer's cell. So walking
across a drainer within a room costs 20, as the instructions say; leaving
it into another room, which is instant, costs 10; and every frame spent
standing on it, or bumping into something from it, costs 10 more
**[confirmed from the code; not measured in play]**.

## Level data

### Levels are encrypted and checksummed; a failed checksum resets the machine

Each level file is &2B0 bytes, loaded at &6B00–&6DAF. The routine at &0450
decrypts it in place, XORing each byte with the low byte of its own
address, and sums the decrypted bytes modulo 256. It compares the sum with
the entry for the current level (1–25, held at &169F) in the table at
&0491–&04A9. On a mismatch it calls &D9CD, the reset entry of MOS 1.20,
so a tampered level resets the machine.

Consequences:
- A level editor must re-encrypt the level and update the table, or the
  game resets on loading the level.
- On any MOS other than 1.20, &D9CD is not the reset entry, so a failed
  checksum jumps into the middle of unrelated MOS code.

### This disc resets the machine on reaching level 5

`LEVEL5` in the `Dunjun2` ROMFS image decrypts to a sum of &4D, but the
table in `Dunjun4` holds &1A for level 5. The other 24 levels match.
Confirmed in beebium: with the level counters set so that the next level
is 5, the game reaches `JSR &D9CD` at &0481 with &72=&4D. With level 4 it
returns normally.

Origin **[confirmed by comparing the archived releases]**:
- The crack's `L1`–`L25` are the hack's `LEVELn` files already
  decrypted. The official disc's `LevelN` and `Stones` hold the same
  levels in encrypted form, except for eight it revises (see "The disc
  revises eight of the cassette's levels" below). Level 5 sums to &4D in
  all of them.
- The checksum table at &0491 is the same in the crack and the hack, with
  &1A for level 5. The official disc's table has &4D.
- The crack never checks the sum: Ole replaced the routine at &0450 with
  his own level loader, so level 5 loads normally there.
- The hack restored the checksum routine from the official disc release
  (its &0450–&0484 is byte-identical to the disc's) but kept the crack's
  table, so it resets at level 5.

Whether the original cassette had the same mismatch (its table entry
wrong, or a different level 5) can't be told without an image of the
original cassette.

Fix: set &0495 in `Dunjun4` to &4D. Confirmed in beebium: with that byte
changed, loading level 5 passes the check.

### The disc revises eight of the cassette's levels

Seventeen of the official disc's levels decrypt to exactly the cassette's
(the crack's `Ln` and the hack's `LEVELn`). Levels 1, 2, 4, 5, 6, 12, 22
and 24 differ **[confirmed by comparing the files]**:

| Level | What changes on the disc |
|---|---|
| 1 | walls (34 bytes) and the object-free map |
| 2 | walls (37 bytes), the object-free map, and one key moved (30,14 to 28,11) |
| 4 | walls (19 bytes), the object-free map, and one object at (30,30) changed from &28 to &2A |
| 5 | one wall byte, and a door at (4,45) and a key at (7,23) removed |
| 6 | nothing in play: only the tables' order and one byte of the wall block |
| 12 | the object at (13,20) changed from &28 to &61 |
| 22 | walls (6 bytes), the object-free map, and three objects and three keys moved |
| 24 | one byte of the object-free map |

The details:
- **Every changed level was re-saved.** In all eight, entries 1–29 of the
  object table are in reverse order (the exit, entry 30, stays last), and
  the door, key and trapdoor tables are reordered too. On level 6 that,
  plus a stray &D7 in the unused entry 0, is the only change
  **[confirmed]**. So the eight were saved by a tool that writes the
  tables backwards, presumably the level editor **[inference]**.
- **Each revised level keeps the cassette level's sum, so it passes the
  same checksum table.** On level 6 the &D7 in entry 0 (&28 below the
  cassette's &FF) is offset by &28 added to &6D80, the first byte of the
  level's wall block. So on the disc, level 6's wall graphic differs in
  its top-left pixels **[confirmed in the bytes]**.
- **The Master side's `Default` has the cassette's level 6** but the
  disc's versions of the other seven. Its other copies match the Model B
  side's level files **[confirmed]**. So level 6 was evidently re-saved
  after the Master `Default` was built **[inference]**. `*DEFAULT` on a
  Master therefore "restores" level 6 to a version the disc never
  shipped.

### The level editor reverses the tables and balances the checksum in entry 0

`*EDITOR` (on both sides) unpacks a level's tables from the last entry
back into item slots counting down from &4F. It packs them again from
slot &4F up to slot 0. So each load and save reverses the order of the
objects (except the exit, always entry 30), the doors with their keys,
and the trapdoors. On saving, it sets the level's first byte (entry 0 of
the objects' x, which the game never reads) to whatever makes the
level's sum equal its entry in the checksum table **[confirmed from the
code]**. That accounts exactly for the disc's eight revised levels. Each
has reversed tables and keeps its checksum, and level 6 changed only by
being loaded and saved **[confirmed]**.

Other things worth knowing about `*EDITOR` **[confirmed from the code]**:
- It cannot save level 25 (it accepts 1–24), and on loading it drops the
  Chalice (type &73), which only level 25 has.
- Saving needs exactly eight trapdoors, the exit, and a key for every
  door. It walls in the map's edges first.
- BRKV points at the MOS reset entry (&D9CD on the Model B side, &E364
  on the Master side), so any filing system error, such as a missing
  file, restarts the machine.
- The wall block comes from `Stones`. Its first &480 bytes are 24 wall
  blocks, and the game's `*LOAD STONES 6680` puts the level 25 data that
  follows them at &6B00.

### The level editor waits for B, not TAB, after deleting

After TAB deletes the item under the cursor, `*EDITOR` loops at &20D5
(the Model B side's &20C0) while key &9B is held and an item is chosen.
&9B is INKEY -101, the B key; TAB is &9F, tested just before at &20C8
**[confirmed from the code, both sides]**. So holding TAB does not wait
for its release: the delete repeats on every pass of the edit loop
while TAB is held, at whichever cell the cursor is on. Holding B with an item chosen stalls the
editor until B is released. &9B looks like a slip for &9F **[inference]**.

### The level editor's top-left cell always reads as a wall

Free item slots are left as item 0, a wall, at (0, 0) (&1EB6, &2D05),
and `item_at_cursor` (&2B76) checks every slot, free ones included. So
cell (0, 0) always reports a wall, and `save_level` sets that cell's wall
bit directly (&230F on the Master side) **[confirmed from the code]**.

### The level editor leaves walls behind refused and deleted doors

`place_door` (&2C70) sets the cell's wall bit before checking the door
count, so a refused 21st door leaves a wall. Deleting a door with TAB
(`remove_at_cursor`, &2C14) frees its slot but not its wall bit; deleting
it through its key does clear the wall (&2D9F) **[confirmed from the
code; Master-side addresses]**.

### `*DEFAULT` writes level files the game never reads

`*DEFAULT` accepts levels 1–25. Level 25 is saved as `Level25`, but the
game reads level 25 from `Stones`, so restoring it has no effect. A
leading zero typed is also kept in the filename, so `05` is saved as
`Level05` rather than `Level5` **[confirmed from the code]**. The Master
side's copy restores level 6 to the cassette's version, which the disc
never shipped (see above). The Model B side's `Default` is a separate
program that accepts 1–24 only, so on that side only the leading zero
applies; its copies are that side's level files.

## Provenance of this disc

The sideways RAM version is described on stardot as an unofficial hack
(<https://stardot.org.uk/forums/viewtopic.php?t=16227>). Its game files
match the tape release except for:
- &0450–&0484: the crack has the cracker's own routine here. The hack has
  the level decrypt/checksum routine, byte-identical to the official disc
  release's.
- &1447–&149F: the level loader, rewritten to load `LEVELn` by calling
  the filing system's FILEV handler with an OSFILE block at &6E60.
- &0E00–&0E06 (the new-game entry; identical to the official disc's) and
  the filename at &16D0.
- Workspace and table bytes in &0800–&08BF, &0D2F–&0D30 and &0D80–&0D85,
  where the hack's files differ from the tape's file contents. These look
  like values from a running game, i.e. the files were saved from memory.
  To be confirmed.

`Dunjun6` is byte-identical to the first &1180 bytes of the tape's
`DUNJ3`.

## Official disc release (Model B side)

### The game is reloaded from disc for every level

`Coder` (&5000) runs at the start of each level. It advances the level
number (ASCII digits at &08BD–&08BE, count at &08BC) and does
`*LOAD DUN1`, reloading the whole of &2000–&7FFF; `Dun1` contains its own
copy of `Coder` at &5000. It then loads the level: `*LOAD LEVELnn 6B00`,
or for level 25 `*LOAD STONES 6680`, since `Stones` ends with level 25's
data at &6B00–&6DAF. Next it copies a &0400–&07FF image from &51B0 or &55B0
and copies &3000–&473F down to &08C0–&1FFF (from &3440 to &0D00 after the
first level, leaving &08C0–&0CFF alone). Finally it jumps to &0D31.

So the filing system must survive each level of play. The game uses
&0D00–&10FF (DFS 1.20's NMI and workspace area), which is consistent with
the reports that only DFS 0.90 works (see
[stardot-dunjunz-versions-thread.md](stardot-dunjunz-versions-thread.md)).
How the game uses &0D00 in this version is still to be traced.

### Each new level starts with a reset of the machine

At the end of a level the game does not call `Coder` directly. At &1460
it sets the MOS 1.20 BREAK intercept (&0287 = `JMP`, &0288–&0289 =
&15B5) and jumps to &D9CD, the MOS reset entry. During the reset the MOS
calls the intercept. On its second call (carry set, once the filing
system has been initialised) the code at &15B5 selects MODE 2 and issues
`*DISC` and `*RUN CODER`, which loads the next level and the game afresh.
Game over works the same way, with the intercept at &1472 issuing `*DISC`
and `*DUNJUNZ` to restart from the loader (the code at &144F sets this up
after a timed wait at &0EC4).

So moving between levels depends on: the MOS 1.20 reset entry at &D9CD;
the BREAK intercept at &0287 being honoured; the reset leaving page &08
(where the level number and hero tables are kept) intact; and the filing
system coming back up with `*DISC` and `*RUN` working after a reset that
followed the game's use of &0D00. It is a likely point of failure on
other filing systems and DFS versions (compare the stardot reports of
"Bad command" after level 1).

### Optional joystick support with a hard-coded MOS 1.20 address

`Coder` reads ADC channel 1 with OSBYTE &80. If Y returns &80 (taken to
mean a joystick at rest; inference) it copies the &0400–&07FF image from
&55B0 instead of &51B0 and points BYTEV at &0780. That handler answers
INKEY scans (OSBYTE &81) of internal key numbers &97, &98, &99, &B9 and &9D
from ADC channels 1 and 2 and the fire buttons (OSBYTE &80 with X=0), so
one player can use a joystick. Every other OSBYTE call is passed on with
`JMP &E772`, the OSBYTE entry of MOS 1.20, not through the previous
contents of BYTEV. On any other MOS, or with anything else hooked into
BYTEV, joystick mode breaks every OSBYTE call. Neither the crack nor the
sideways RAM hack has this code.

The key numbers it answers are exactly the third player's keys in the
workspace template (&B9 up K, &99 down `<`, &97 right `?`, &98 left `>`,
&9D fire SPACE), so the joystick replaces the Barbarian's keys. Whether
the &80 test detects a joystick reliably is to be confirmed.

### The ten-thousands score digit is lost at each new level (bug)

A score's ten-thousands digit is kept apart from the other digits, as a
small digit sprite (&69 for none, &6A–&72 for 1–9). In the cassette
lineage (the crack and the hack) the four heroes' digits are at
&06F8–&06FB, and every routine uses that table. The disc release reloads
&0400–&07FF for every level, so it moved the table to &08B0
(`hero_score_ten_thousands`), and `reset_hero` (&0EF3) and
`remove_absent_heroes` (&06B4, &06BF) use the new address.
`add_thousand_points` (&040F, &0412, &041B, in both &0400 images) still
uses &06F8. Searching all of `Dun1` for absolute operands confirms that
no instruction writes &08B0–&08B3 except `reset_hero`.

So in the official disc release:

- while a level lasts, the digit is counted and drawn correctly from
  &06F8;
- at the next level, `Coder` reloads &06F8 with &69 ("none"), and
  `remove_absent_heroes` redraws the digit from &08B0, which is still &69,
  so the score shows only its last four digits;
- the next time the thousands digit passes 9 the count starts again from
  1, so a score of 20,000 or more is shown wrongly.

**[confirmed in beebium]** `tools/disc_level_probe.py` boots the Model B
side with DFS 0.90 on the 8271, plays into level 1, sets hero 0's digit
at &06F8 to &6A (1), and takes the end-of-level path through
`next_level_by_reset`. At level 2, after `remove_absent_heroes` has drawn
the panel, &06F8-&06FB and &08B0-&08B3 all hold &69, and the panel shows
no ten-thousands digit. A fix is to change the three operands at &040F,
&0412 and &041B, in both images, from &06F8 to &08B0. Those instructions
are at `Dun1` file offsets &31BF, &31C2 and &31CB (keyboard image) and
&35BF, &35C2 and &35CB (joystick image), each with its operand in the next
two bytes (&F8 &06 to become &B0 &08).

### Leftovers from development in page &07

&0700–&07FF of every &0400 image is a snapshot of the development
machine's memory: &0700 is MOS 1.20's line-input buffer. Each image holds
the last command typed before it was saved, followed by a fragment of
BBC BASIC assembler (`label+2:LDA#255:.label JSR&30`):

| Image | Command in the buffer |
|---|---|
| Disc, keyboard (`Dun1` &51B0) | `*SA. DANK 400+3FF 740` |
| Disc, joystick (`Dun1` &55B0) | `*SA. Control 400+3FF` |
| Crack and hack | `*SAVE Dunjunz.K 400 7FF 740` |
| Master side's `Coder` | `*SA. CODER 400+3FF 740` |

So on the Model B side the keyboard image was saved as `DANK` and the
joystick image as `Control`; the cassette's was `Dunjunz.K`.

At &0740 each image also holds a short loader, which is the exec address
of those saves. It builds an OSFILE block at &6B00 for the filename at
&07F0 (`Dun1` on the disc, `Dunjunz1` in the cassette lineage), with
load address &2000. It copies FILEV into its own `JSR` operand, calls it
to load the file, and jumps to &2000. Nothing in the three releases'
game code reaches it. The listings annotate it as `boot_loader`. In the
disc's joystick image it first points BYTEV at the joystick handler.

The `JSR`'s stored operand records whether the loader had run before
the image was saved:

- in the disc's images and the crack's, it is &3000, a placeholder
  never patched;
- in the sideways RAM hack's `Dunjun4`, it is &F27D. That is the FILEV
  handler of MOS 1.20 for both the cassette and the ROM filing systems
  (FILEV reads &F27D after either `*TAPE` or `*ROM` in beebium, and &FF1B
  under DFS) **[confirmed]**.

The hack's own loader, `DUNK`, jumps straight to &0D31 and never runs
&0740. So the image the hack was saved from had run this loader with the
cassette or ROM filing system selected. That could be the original
cassette loading itself, or something in the hack's making
**[inference]**.

The Master side's `Coder` (load &0400, exec &0740, length &3FF) is
another such image, with a different program at &0740. That program
copies page &0D to &C400 (in the Master's private RAM), `*LOAD`s `DUNJ2`
to `DUNJ5` through OSCLI, sends VDU 17,2 and jumps to &0E00. Its &07F5
still holds "nz1", the end of the cassette lineage's "Dunjunz1": the
Master conversion was built over a cassette-lineage &0400 image, not the
Model B disc's **[confirmed]**. See
[the-master-128-version.md](analysis/the-master-128-version.md).

## Dependence on MOS 1.20

The game uses three MOS 1.20 internal addresses directly, confirmed
against the MOS 1.20 ROM in beebium:

| Address | In MOS 1.20 | Used by |
|---|---|---|
| &C375 | Table of screen row offsets, row × 640, as high/low byte pairs | The screen address routine at &0967, for every sprite plot (all releases) |
| &D9CD | The reset entry (the RESET vector's target) | `JSR &D9CD` when a level fails its checksum (official disc, sideways RAM hack) |
| &E772 | The default OSBYTE handler (BYTEV's initial value) | The joystick BYTEV handler's fall-through (official disc, joystick mode) |
| &E0A4 | The default OSWRCH handler (WRCHV's initial value) | The game's WRCHV handler at &7F8F passes every character on with `JMP &E0A4`, not through the WRCHV value it saved (all releases) |
| &0C00 | Definition of character 128 (user-defined characters, default font arrangement) | The WRCHV handler copies each letter or digit glyph there and prints character 128 (all releases) |

The Model B side's loader, `Dunjunz`, also reads &C375: its title-screen
star plotter at &2876 indexes the table at &287D and &2885
**[confirmed]**. The Master conversion handles each of these addresses:
it carries its own copy of the row table, passes on to MOS 3.20's entry
points, and bypasses the font routine (see
[the-master-128-version.md](analysis/the-master-128-version.md)).

On another MOS, sprites are drawn at wrong addresses, a failed checksum
jumps into unrelated code, joystick mode breaks OSBYTE, and text output
bypasses anything else hooked into WRCHV. A portable version would need
its own 640-byte row table, would chain to the saved vectors, and would
define character 128 with VDU 23.

## Official disc release (Master 128 side)

The full account is in
[the-master-128-version.md](analysis/the-master-128-version.md). The
findings that matter beyond the listing:

### It works with the WD1770 and DFS 2.24 by protecting page &0D

The Master game never drives the disc controller. Every file and level is
loaded with `*LOAD` through OSCLI. The one piece of filing-system state it
damages is page &0D, which holds the DFS's NMI routine (on a Master its
first bytes are `PHA : LDA &FE28`, the 1770 status register) and which
the game uses as its per-level workspace. So `Coder` saves the page at
&C400 in private RAM at start-up, and `load_level` (&1483) puts it back
before every `*LOAD`. Only then is the game's workspace rebuilt from
`workspace_template`. Between levels the game stays resident: there is no
reset and no BREAK intercept. Confirmed in beebjit's Master 128 (MOS
3.20, DFS 2.24): just before level 1's `*LOAD`, page &0D and &C400 are
identical, and the DFS writes nothing to the game's private-RAM files
(&C400–&D8FF) while it loads.

**Bearing on a DFS-portable Model B build [inference]:**
- **What carries over:** the same approach would remove the Model B
  disc's reset between levels and its dependence on DFS 0.90's memory
  use. That means keeping the game resident, loading levels through
  OSCLI, and putting the filing system's pages back before each load.
- **What makes it harder:** on a Model B the filing system's workspace
  includes &0E00–&10FF, where the game has code, not just page &0D. A
  port would need somewhere to keep both while a level loads.

### It runs with the Master's private RAM paged in, and never pages it

Four files load into HAZEL (&C500–&D8FF), and page &0D is saved at
&C400. The game reads and calls these addresses directly without writing
ACCCON, which no file touches. It relies on MOS 3.20 starting `*RUN`
programs with ACCCON bit 3 set: in beebjit ACCCON is &18 at `*DUNJUNZ`'s
entry, at `Coder`'s &0740, and inside the music's event handler
**[confirmed]**. On a Master configured or emulated otherwise, the game's
row-offset reads would hit the MOS ROM at &C675, and its calls into
&C500–&D8FF would run ROM code.

### A failed level checksum executes BRK on a Master

The checksum routine, shared with the Model B disc, still calls &D9CD,
the MOS 1.20 reset entry, on a mismatch. With private RAM paged in, &D9CD
on a Master is HAZEL, which holds zeros in beebjit. So a tampered or
mis-checksummed level hits `BRK` there instead of resetting **[confirmed
that &D9CD holds 0; the outcome is an inference]**. The Master side's
table has the correct &4D for level 5, so the shipped levels pass.

### The Master version adds music, and changes keys and text

- **Music:** in-game music plays from an interval-timer event. Its
  player and tune occupy `Code2`.
- **Keys:** the Magic-User plays on the numeric keypad, and the Barbarian
  and Fighter have new keys.
- **Text:** text is printed in the MOS font, because the WRCHV handler
  now jumps straight to MOS 3.20's OSWRCH.
- **Timing:** the game-over wait is 5 s.
- **Level screen:** the "LEVEL n" screen is dropped.

All **[confirmed]**; see the analysis document for the details.

The Model B side's lost ten-thousands digit does not arise here: the game
is resident, and every routine uses the cassette's tables at &06F8
(`hero_score_ten_thousands`) **[confirmed]**.

## Ole's crack of the cassette

### `EXPAND` finds a picture's length with OSARGS 2

`EXPAND` (&2E00), which `PLOAD` runs as `*EXPAND GIRL1`, opens the file
only to read its length with OSARGS 2 (EXT#). It then loads the file with
OSFILE so that it ends at &8000, ignoring the load address in its
catalogue entry **[confirmed from the code]**. `GIRL1`'s catalogue load
address, &FF463B, is not where it is loaded (&4A3B), so the mismatch does
no harm. Whether the cassette filing system answers OSARGS 2 has not been
checked. If it does not, the crack's intro would fail when run from tape.

The packed format **[confirmed by decoding `GIRL1`]**:
- Each byte holds a MODE 2 screen byte in bits 5–0 and a run code in
  bits 7–6. Codes 0–2 give a run of 1–3 bytes; code 3 takes the run, n+1
  bytes, from the next byte.
- Unpacking writes from &3000 and stops at &8000, even within a run;
  there is no end marker.
- A pixel's bit 3 (screen-byte bits 7 and 6) is always clear, so a picture
  uses logical colours 0–7 only.

Decoded with this format, `GIRL1`'s 13,765 bytes give exactly &5000
bytes, a full MODE 2 screen, and a coherent picture.

### `EXPAND` does not check that unpacking cannot overtake the file

The packed file is loaded to end at &8000 and unpacked from &3000 into
the same memory, which is safe only while each packed unit gives at
least as many screen bytes as it takes. A code-3 pair with a run length
of 1 takes two bytes for one; enough of them near the end of a file
would overwrite packed bytes before they are read **[inference from the
code]**.

### The start-level cheat in `DUNJ` is broken

Line 120 pokes `?&5100=sl%-1` in binary, but `first_level` holds BCD, so
only start levels 1-10 are right (17 gives &10, level 11). `new_game`
still sets `level_number` to 0, and `level_loop` uses that count of
levels played to choose a one- or two-digit filename (`CMP #9` at &0E2C)
and the Chalice test uses it too (&1070), so later files are misnamed
and a game started this way cannot be won **[inference from the code;
not tested]**.

## Sideways RAM hack

### `TITLE` writes the 6845 directly, even on an Electron

`TITLE` detects an Electron (INKEY(-256) = 1) only to skip a line of
spaces, then writes the cursor setting to &FE00/&FE01. On an Electron
those are ULA registers **[inference from the code; not tested]**.

## Game (all releases)

### A monster emerges onto a trapdoor whatever stands there

When a monster's death animation ends, `monster_reappears` (&7CB3) puts
it on the next trapdoor, facing up, then calls `find_creature` (&7CE6) to
see whether anything else is there. It never loads `cell_x`/`cell_y`
with the trapdoor's cell, so `find_creature` tests whatever they still
hold from the erase at &7A07. That is `plot_at_cell`'s leftovers, not a
map cell.

**[confirmed in beebium]** On the disc's Model B side in level 1,
monster 1 was set to its last death frame and monster 2 placed on the
trapdoor it would use (&0C,&06). At the `find_creature` call, `cell_x`
and `cell_y` held &00,&48; row &48 is off the 48-row map. Monster 1
emerged on top of monster 2. With monster 2 placed where monster 1 had
died instead, it emerged the same way.

What they hold is the dying monster's place within its view:
`plot_at_cell` replaces `cell_x` with (x AND 7) x 4 + the horizontal
offset and `cell_y` with (y AND 7) x 12 + the vertical offset. A monster
that dies in the bottom four rows of its room leaves `cell_y` at 48 or
more, off the map, so nothing is found and the monster emerges whatever
is on the trapdoor. One that dies in the top four rows leaves a real
cell (rows 0, 12, 24 or 36, in the top-left part of the dungeon), and if
a hero or monster happens to stand there the branch at &7CED is taken.
That branch parks the monster at &FF,&FF but leaves its sprite alive, so
nothing brings it back to a trapdoor **[inference from the code]**. A
parked monster is still moved every frame; its coordinates can wrap to 0
and `test_wall` then reads bytes beyond `room_walls`, so whether it can
walk back onto the map's top row or left column is not known.

`find_creature` is called with `scratch` non-zero, and in that mode it
takes `hero_damage_taken` health from any hero it finds (&79A7-&79B2). So
a hero who happens to stand at the leftover cell is hurt by a monster
emerging elsewhere **[confirmed from the code]**.

### A missile stops at a dead hero's skull

A dead hero keeps their map position while the skull shows. The missile
loop at &71DD compares a missile's new cell with every hero's, whether
in play or not. On a match it calls `lose_health_point`, which does
nothing for a hero out of play, and then spends the missile. So a skull
stops missiles, though the dead hero loses nothing **[confirmed from the
code]**.

### "YOU ALL" loses its full stop

The game-over message (&0F90) contains "YOU ALL." with the full stop at
&0FF1. &0FF1 and &0FF2 are also used as counters (the hero being drawn by
`draw_status_panel`, and the count of dead heroes), so before printing
the message the code writes spaces over &0FF1–&0FF4. The message always
appears as "YOU ALL" with no full stop.

### Casting magic briefly stops the other heroes moving (likely bug)

`move_heroes` handles heroes 0 and 1 (the two with magic) by jumping to
the magic code at &7619. That code counts down `hero_magic_delay` and,
while it is not yet zero, executes `RTS`. Because the code was entered by
`JMP` from `move_heroes`, this returns from `move_heroes` altogether, so
the heroes after it are not moved on that frame. The delay normally sits
at 1, so nothing is skipped; after a cast it is set to 4, so for the next
three frames every hero is frozen when the Ranger (hero 0) cast, and the
Barbarian and Fighter are frozen when the Magic-User (hero 1) cast. The
delay seems meant to stop the magic key repeating, and skipping the
other heroes looks unintended.

Confirmed in beebium on the sideways RAM hack, with a breakpoint counting
how often `move_heroes` reaches hero 3 in each frame. It does so once
every frame, except for the three frames after the Ranger casts (CTRL),
when it is not reached at all. A fix: while the delay runs, carry on
with the hero's other keys (`read_hero_keys`, &6EC1) instead of
returning. The `RTS` at &761E is one byte and &6EC1 is out of branch
range, so this needs a few bytes elsewhere for a `JMP`.

### A monster on exactly 0 hit points survives

At &7594 a hit subtracts the missile's damage and branches with `BPL`,
so a monster dies only when its hit points go below zero. On level 1
(8 hit points) the Ranger's arrows (damage 2) take five hits, not four
**[confirmed from the code]**.

### A monster killed this frame can be hit again

A kill sets the monster's sprite to `spr_blank` (&15); it moves on to
the first sparkle only in `update_monsters`, which runs after
`move_missiles`. The missile test at &7147 counts any sprite below &16
as live, so a second missile reaching the same cell in that frame hits
again: the sound plays, the missile is spent, and if its damage is at
least the reset hit points the firer scores a second kill. The same
holds for a monster killed by magic earlier in the frame **[inference
from the code; not seen in play]**.

### A missile bounced by an energy drainer can hit its firer

After turning round at &71A5 the missile heads back, and the hero test
at &71DD does not ask who fired it **[confirmed from the code]**.

### Finding any object costs the Boots of Speed

`collect_objects` takes the boots off and erases their icon (&734D-&7357)
before it looks at the object's type, so stepping onto a teleporter, an
energy drainer or the exit loses them too **[confirmed from the code]**.

### A Potion of Healing can leave a hero on 00 health

The potion (&7503-&7512) sets health's tens digit to the score's units
digit d and its units digit to d + 1, then takes one point, giving "dd"
(77 for a score ending in 7). A score ending in 0 gives 00 health: alive,
one point from death **[confirmed from the code]**.

### Teleport landings are not checked

The hero is put one row above the destination teleporter (&73EA-&73F9)
without a test for a wall, monster or hero there. A level with one
teleporter sends the hero back to it **[confirmed from the code]**.

### A Cross of Resurrection is used up when nobody is waiting

The object is removed (&7411) before the returning queue is tested
(&7421); the 10 points are still given **[confirmed from the code]**.

### Casting magic can kill the caster

Magic's cost is taken through `lose_health_point`, which can end the
caster's life; `draw_moved_hero` (&7096) checks that the caster is still
in play before drawing **[confirmed from the code]**. Nothing after the
cost loop (&7652-&765A) checks, so a caster killed by the cost still
kills the room's monsters and scores for them **[confirmed from the
code]**.

### A hero standing on a key swaps keys every other frame

A swap (&1E84-&1E9C) sets `hero_key_dropped`; the next frame only clears
it (&1E2D), and on the frame after that the key just dropped is under the
hero again, so they swap back. A hero arriving with no key is not
affected **[confirmed from the code]**. Dying heroes go on doing this:
at &1DF8 a hero out of play whose death animation has not reached frame 8
still reaches `check_key_swap` **[confirmed from the code]**.

### Survivors gain a free point at every new level

`draw_status_panel` calls `add_point` (&0F02) to draw each score, and
only heroes who died (&0E74) are reset first, so each surviving hero
gains a point per level **[confirmed from the code]**.

### Pause can be missed while another key is held

OSBYTE &7A reports only the lowest-numbered key held from 16 up, so the
pause key (P, or f1 in the crack and hack) goes unseen while a key
numbered below it is held, as most movement keys are. The same applies
to the press that ends the pause **[confirmed from the code]**. On the
disc's Model B side the game does not wait for P to be released after
the second press, so a P still held at the next frame's check pauses
again **[confirmed in beebium]**: with P held through the unpausing press,
the next pause test, 19 vsyncs later (the counter is set to &10), went
straight back into `wait_pause_release` (`tools/timing_probe.py
disc_repause`).

### The victory bell is set with a stale Y

OSBYTE &D4 (&10E9) and &D5 (&1124) set their value to (old AND Y) EOR X,
and Y is not loaded first, so the first pass uses whatever Y the previous
code left **[confirmed from the code]**.

### Leftover code in `move_heroes`

The bytes at &6F6D, `88 D0 B8` (`DEY: BNE find_missile_slot`), follow a
`JMP` and are never reached **[confirmed from the code]**.

### A monster killed by magic comes back still wounded

The magic kill (&768A) only sets the sprite to the blank. Hit points are
written only by `reset_monsters`, the missile kill (&759E, which resets
them) and a surviving hit (&75A6), and `monster_reappears` does not touch
them. So a monster wounded by missiles and then killed by magic returns
from its trapdoor with the hit points it had left **[confirmed from the
code]**.

### Walking into a monster costs one point, whatever the armour

A hero's move into a monster's cell calls `lose_health_point` once
(&6FFC); a monster moving into a hero takes `hero_damage_taken` points
(&79A7). `find_creature` ignores the sprite, so a dying monster still
blocks heroes and costs the point, though missiles pass through it
(&7147) **[confirmed from the code]**.

### Monsters move faster across room boundaries

A step into a cell inside a room takes four frames (`start_monster_step`
draws a quarter of the way, `continue_monster_step` a half, three
quarters, then the cell). A cell on a room's edge, in the direction of
travel, is entered at once, and so is the first cell of the next room,
so a monster crosses a room boundary two cells in two frames.

**[confirmed in beebium]** On the sideways RAM hack's level 1, following
every monster for 80 frames (`tools/timing_probe.py monster_step`): of
the steps inside a room, 394 took four frames and none fewer (longer
gaps are monsters that were blocked and turned); 43 of 54 steps onto an
edge cell, and 47 of 52 into the next room, came one frame after the
previous step.

### All the monsters emerge together at the start of a level

`reset_monsters` gives all 30 the blank sprite at x &FF, so they sparkle
together and emerge on the same frame, round-robin over the eight
trapdoors, three or four to a trapdoor **[confirmed from the code]**.
While a monster slides between cells its `monster_x`/`monster_y` hold the
cell it is leaving and arrival is not tested, so creatures can end up
sharing a cell; stacked monsters can slide out together **[inference
from the code]**.

### Each hero who leaves by the exit adds a frame to the level's end

Each hero who goes down the exit leaves a return address on the stack,
so the `RTS` at the level's end comes back into `check_exit` once per
such hero, each time running a full frame **[confirmed from the code]**.

### A key dropped at the exit can land in a wall

`find_open_neighbour` tests the cells above, right of and below the exit
for walls, and falls back on the cell to the left without testing it
(&20F7) **[confirmed from the code]**. It does not test for keys or
objects either.

### The game can stall after a pause in the crack and the hack

The pause loop (&1ED7-&1EF5) does not set `os_vsync_counter` (&0240)
again. The MOS counts it down at every vsync throughout the pause, so it
can be positive when play resumes and `play_level` then waits up to 128
vsyncs, about 2.6 seconds, for the next frame. Both disc sides reset the
counter after a pause.

**[confirmed in beebium]** On the sideways RAM hack (the crack's pause
code is the same), pausing with f1 for various times and measuring from
the unpause to the next frame (`tools/timing_probe.py hack_pause`):

| Paused (vsyncs) | Counter at resume | Next frame after |
|---|---|---|
| 55 | &C8 | 0 vsyncs |
| 105 | &96 | 0 vsyncs |
| 155 | &64 | 101 vsyncs (2.02 s) |
| 180 | &4C | 77 vsyncs (1.54 s) |
| 205 | &32 | 51 vsyncs (1.02 s) |
| 255 | &00 | 1 vsync |

The game freezes for the counter's value plus one vsync after any pause
of between about 2.6 and 5.1 seconds (and of the same lengths plus
multiples of 5.1 seconds).

### Game over waits for the vsync counter to reach exactly 0

At &0EB9 the game waits for &0240 to be 0. `play_level` last set it to 2
and the MOS goes on counting it down, so if the window clear and message
take more than two vsyncs the wait lasts until it wraps, up to 256
vsyncs (about 5 s), before the keys are flushed and the timed wait starts.

**[confirmed in beebium]** On the sideways RAM hack, with all four
heroes made dead in play (`tools/timing_probe.py game_over`), the window
clear and message took 18 vsyncs, leaving the counter at &EF, and the
wait at &0EB9 then took 239 vsyncs (4.78 s). Keys pressed during it are
flushed afterwards, so the message cannot be skipped for those seconds.

### The hero menu keeps the last game's choices

Neither `hero_absent` nor `menu_text` is reset after a game over, so the
menu opens with the previous game's YES/NO and sound choices, and its
ON/OFF entry shows the last choice made rather than the sound
suppression in force **[confirmed from the code]**.

## Official disc release: further notes

### `*DUNJUNZ` (Model B) arms the BREAK intercept only while Coder loads

`title_start` stores the JMP at &0287 just before `*CODER`, and Coder
stores 0 there within its first few instructions **[confirmed from the
code]**. On the first run after power-on, &15B5 does not yet hold
`next_level_intercept`, so a BREAK during that load would jump into
whatever is there **[inference]**. Each level's reset arms the intercept
again itself (&1460).

### Coder reads the joystick's ADC channel twice

Once at &50A3 to choose which &0400 image to copy, and again at &50D0 to
decide whether to point BYTEV at &0780. If the readings disagreed, the
joystick image would run with the MOS's BYTEV, or BYTEV would point at
the keyboard image's &0780, which is zeros (BRK) **[confirmed from the
code; whether readings can disagree is untested]**.

### The Master's `stones_command` ends with a zero byte

`stones_command` (&C5AA) is `LOAD STONES 6680` followed by &00, not a CR;
the first CR after it is at &C623, ending a leftover "DUNJUNZ"
**[confirmed from the bytes]**. Whether MOS 3.20 and DFS 2.24 accept the
command, so that level 25 loads, is untested.

## Level editor: further notes

### The level number typed when saving only chooses the checksum

`level_number` (&25F1, Master side) is written at &22F8 and never read;
the filename is asked for separately (&2373). A level saved under another
level's filename carries the wrong checksum and fails the game's test
when it is loaded **[confirmed from the code; the failure inferred]**.

### Loading a level trusts the file

For a loaded level `start_editing` sets `exit_placed` to 1 and
`unpack_level` sets `trapdoor_count` to 8 without checking, and each
door's key is taken whether or not it is on the map. Only a malformed
file is affected **[confirmed from the code]**.

### Errors during the Editor's questions may restart it

`editor_init` arms the BREAK intercept and points BRKV at the reset
entry, so an error such as File not found should come back to
`editor_init` through `break_to_start` **[inference; depends on the MOS
reset path, untested]**.
