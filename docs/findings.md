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

Lines 210–240 give the Magic-User/Wizard "3 arrows at a time" and the
Ranger "2 fireballs" with strong magic, whereas the story text (lines
130–140) says "The Ranger uses a bow" and "The Wizard has been taught how
to cast powerful fireballs". To be confirmed against the game code
(weapon type and limit per hero).

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

Origin, from the archives at
<https://rk.nvg.ntnu.no/bbc/sw/BugByte/> (`Dunjunz.zip`, a disc release
with a level editor, and `Dunjunz-tape.zip`):
- The tape release's `DUNJ4` carries the same table as this disc
  (&1A for level 5).
- The disc release's game (`0/Dun1`) and its `Coder` and `Editor`
  programs carry &4D for level 5. Its `0/Level5` sums to &4D, matching.
- This disc's level files decrypt with the same scheme as the disc
  release's levels, and its `LEVEL5` has the same sum (&4D).

So this sideways RAM version appears to combine code derived from the
tape release with the disc release's level files, whose level 5 does not
match the table carried by the tape code. (The tape's own level files are
encoded differently and have not yet been compared.) Fix: set &0495 in `Dunjun4` to &4D (or restore
the tape's level 5).

## Provenance of this disc

The sideways RAM version is described on stardot as an unofficial hack
(<https://stardot.org.uk/forums/viewtopic.php?t=16227>). Its game files
match the tape release except for:
- &0450–&0484: the tape release's code here is a different routine; the
  hack has the level decrypt/checksum routine described above.
- &1447–&149F: the level loader, rewritten to load `LEVELn` by calling
  the filing system's FILEV handler with an OSFILE block at &6E60.
- &0E00–&0E06 and the filename at &16D0: the new-game entry and the
  level filename.
- Workspace and table bytes in &0800–&08BF, &0D2F–&0D30 and &0D80–&0D85,
  where the hack's files differ from the tape's file contents. These look
  like values from a running game, i.e. the files were saved from memory.
  To be confirmed.

`Dunjun6` is byte-identical to the first &1180 bytes of the tape's
`DUNJ3`.

## Official disc release (`Dunjunz.zip`, Model B side 0)

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

Which player the joystick replaces, and whether the &80 test detects a
joystick reliably, are to be confirmed.
