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
