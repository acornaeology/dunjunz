# Notes from the stardot "Dunjunz versions" thread

Source: <https://stardot.org.uk/forums/viewtopic.php?t=16227> (three
pages, December 2018 to May 2021). These are claims made in the thread,
attributed to their authors. Where the disassembly has confirmed or
contradicted a claim, that is noted; everything else is unverified.

## Releases

- The official release was a "flippy" disc with the Master version on one
  side and the Model B version on the other (billcarr2005, 2018-12-23).
  The game expects the disc to be turned over, with both sides read in
  drive 0 (lurkio). The README in `Dunjunz.zip` agrees: "After You have
  selected your Charcter types. Turn over the disc inorder to access the
  levels of play."
- The sideways RAM version, the one in this repository, is an unofficial
  hack (billcarr2005). It has no `LEVELS` files, many `DUNJUNZ` files,
  and the levels in RFS (brooksoid, lurkio). lurkio saw it use banks 6
  and 7 in BeebEm.
  *Disassembly:* consistent. Its code derives from the tape release with
  a rewritten level loader; see [findings.md](findings.md).
- A tape version exists (`Dunjunz_B.uef` on bbcmicro.co.uk). duikkie
  (2021-05-06) says the disc version lost "someones face and other info"
  compared with the tape. (The tape archive has a `GIRL1` file.)

## Why the disc versions fail on most DFSs

- The official Model B disc version runs on real hardware only with
  DFS 0.90 (lurkio, 2021-05-05). With DFS 1.20 or 1.44 it stops with
  "Bad command"; with Watford DFS 1.30/1.43 it hangs after level 2 loads,
  in a loop at &1F00 that polls &0240 (billcarr2005, 2018-12-23).
- richardtoohey (2018-12-29) traced "Bad command" to an OSCLI (&FFF7) of
  `*DISC`, issued after the game has overwritten workspace DFS 1.20
  needs. Replacing `*DISC` with `*CARD` (MMC) or with spaces gets past
  level 1, but loading later levels still fails.
- duikkie (2021-05) says the game overwrites &0D00–&10FF, the DFS NMI
  and workspace area, in every version, so a later level cannot be loaded
  through DFS. The tape version "works every time because it uses &A00
  rather than &D00". The next-level load follows a level calculation at
  &0E14, with the load at &0E57. Memory use: &0400–&0800, &08C0–&3000,
  loading screen at &3280, levels at &6B00, other code at &6E80–&8000.
  *Disassembly (sideways RAM hack):* &0E14 is the top of the level loop
  and the level is loaded to &6B00. The routine at &14A0 copies
  &7D00–&7DFF over &0D00–&0DFF before each level is played, and the
  start-up code at &0D31 is reused as table space. The hack loads levels
  through ROMFS after `*TAPE`, `*ROM` rather than through DFS. This
  presumably avoids the overwritten DFS workspace, though that motive is
  inference.
- *Disassembly:* the &1F00 loop waits for &0240, which the game sets to 1
  just before (&0E63–&0E68), to return to zero. In MOS 1.20 the IRQ
  handler counts &0240 down on each vertical sync. To be confirmed in the
  MOS, and to be checked why the loop never ends under Watford DFS.
- After level 1 under DFS 1.20 the printer appears enabled (Caps Lock and
  Shift Lock lights), and `VDU 3` restores command entry (BeebMaster,
  lurkio, 2021-05-04).
- With a 6502 second processor, BREAK gives "Bad command" and then a
  supervisor prompt (BeebMaster, 2021-05-09).

## Disc release structure (duikkie, 2021-05-05)

- `DUN1` loads at &2000, &6000 bytes long, up to &8000. The loader at
  &5000 shares code with `CODER`.
- Compacting the disc after removing a level can move files and break
  loading (duikkie, 2021-05-06).

## Playing tips

- To finish level 1 quickly: switch off every hero except the Fighter
  (Warrior; keys G, B, U, I) and go to the far south-east corner
  (lurkio, 2018-12-28 and 2021-05-05).

## Related links from the thread

- Dunjunz Compatibility Matrix: <https://stardot.org.uk/forums/viewtopic.php?t=13214>
  (billcarr2005 calls it misleading).
- Tape version discussion: <https://stardot.org.uk/forums/viewtopic.php?p=223370#p223370>
- Continuation: <https://stardot.org.uk/forums/viewtopic.php?p=323153#p323153>
- Test images posted in the thread: `DunjunzB.ssd`, `DEBUG-DunjunzB.ssd`,
  `HAK-DunjunzB.ssd`, `dunprob1.ssd`, `dunprob2.ssd`.
