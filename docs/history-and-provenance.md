# Dunjunz: releases, cracks and hacks

Dunjunz was written by Julian Avis and published by Bug-Byte (cassette
1986; disc 1987). This document records what the surviving copies are,
how they relate to one another, and the evidence for each relationship.
Statements are tagged by their basis:

- **[confirmed]**: checked against the files or by running them in
  beebium during this project.
- **[reported]**: stated by someone else (with the source); not yet
  checked here.
- **[inference]**: our reading of the evidence, not proven.

## The original releases

### Cassette (1986)

The cassette version was the first release. The 1986 date comes from the
sideways RAM hack's title page (`TITLE`: "(c) Bugbyte 1986") and
instructions ("(c) Bug Byte 1986"); no date appears in the files of Ole's
crack **[confirmed]**. The cassette loads each level from tape as the game
progresses.

No pristine image of the original protected cassette has been found for
this project. The stardot thread on Dunjunz versions reports a tape image,
`Dunjunz_B.uef`, on bbcmicro.co.uk **[reported]**.

### Flippy disc (1987)

The disc release was a double-sided "flippy" disc with the Master 128
version on one side and the Model B version on the other
**[reported: billcarr2005, stardot]**. The thread dates it to
September 1987, from everygamegoing.com **[reported]**.

No original image of this disc has been found either. The closest copy is
`Dunjunz.zip` from the NVG archive (`versions/nvg-dunjunz-disc/`), which
holds the two sides as directories `2/` and `0/` **[confirmed]**:

- **Side 2, the boot side, is the Master version.** Its `!BOOT` chains
  `BOOT`, whose first line reads "(c) Bug Byte 1987. Mastered by S
  Benfield". `BOOT` checks `INKEY-256`. On a Master 128 (253) it shows
  `README` and runs `*DUNJUNZ` from this side. On anything else it says
  "BBC Version on the flip side of this disc. please turn over the disc
  and press the Space Bar." This side's files are locked, and several
  load into the Master's &C000–&DFFF private RAM (`Code` &C500, `Code2`
  &C700, `Code3` &D800, `Table` &C5A0) **[confirmed]**.
- **Side 0 is the Model B version.** `Dunjunz` (load &26C0, exec &2700),
  the game `Dun1` (&2000, &6000 bytes, up to &8000), `Screen` (&3280, the
  loading screen), `Stones` (&6E80), `Coder` (&5000), `Editor`,
  `Default`, and `Level1`–`Level24` at &6B00 **[confirmed]**. `Level25`
  is not present on this side in the archive **[confirmed]**; where the
  disc version gets level 25 from is not yet known.
- The README says to turn the disc over after choosing the heroes "in
  order to access the levels of play". It describes `*EDITOR` (a level
  editor) and `*DEFAULT` (restores an edited level to its original form),
  "for the BBC model B ONLY" **[confirmed]**.
- The disc's levels use the same encryption and checksum scheme as the
  sideways RAM hack (see below), and its game, `Coder` and `Editor` all
  carry the same checksum table. That table holds &4D for level 5
  **[confirmed]**.

The disc version only runs on real hardware with DFS 0.90. With DFS 1.20
and later it fails with "Bad command", and with Watford DFS it hangs
after level 2 loads **[reported: billcarr2005, lurkio, richardtoohey,
stardot]**. The game overwrites &0D00–&10FF, the DFS's NMI and workspace
area, so later levels cannot be loaded through DFS
**[reported: duikkie, stardot]**.

## Ole's crack of the cassette

`Dunjunz-tape.zip` from the NVG archive (`versions/nvg-dunjunz-tape/`) is
not the original cassette. It is a crack **[confirmed]**:

- `PLOAD` (BASIC) runs `EXPAND` (an image unpacker, "(C) 1985 Rhys E.
  Davies") to unpack the picture `GIRL1`, and scrolls
  "D U N J U N Z Cracked by Ole , The great Demon from Denmark .You can
  CH. this program with out Pload - GIRL1 and Expand."
- `DUNJ` (BASIC, the real loader) starts with `REM" HI SIMON PRESS @` and
  prints "Dunjunz Was Cracked By Ole Cracker (MCC)". Pressing `@` asks
  "Start level?" and pokes the answer less one into `?&5100`: a
  start-level cheat added by the cracker. Pressing `I` lists instructions
  stored after the program. It then loads `DUNJ2` (the loading screen at
  &3280) and `DUNJ3` (code at &6E80), and runs `DUNJ4`.
- `DUNJ4` (load &2400, exec &5000) holds the game's &0400–&2FFF image
  stored &2000 above where it runs **[confirmed by comparison with the
  hack's files]**. The code at &5000 presumably moves it into place; it
  has not yet been examined.
- The levels `L1`–`L25` (&2B0 bytes each, load &6B00) are encoded
  differently from the disc release's levels **[confirmed]**. How the
  crack decodes them has not yet been worked out.
- The code's level checksum table holds &1A for level 5 **[confirmed]**.

duikkie reports that the tape version works reliably where the disc
versions do not, because it "uses &A00 rather than &D00"
**[reported, stardot]**.

## The sideways RAM hack

`Disc060-DunjunzRx2.ssd` (`versions/cbbcga-dunjunz/`), from the BBC
Micro Games Archive, is an unofficial conversion that keeps all 25 levels
in two banks of sideways RAM as ROMFS images and loads them through the
MOS's ROM filing system **[reported as unofficial: billcarr2005,
stardot]**. Its credits say only "(c) Bug Byte 1986"; whoever made it is
not named. It descends from Ole's crack, not from either original:

- **Intro.** Lines 510–570 of its `DUNJUNZ` are `PLOAD`'s scroller and
  palette effects, with new text and the `PIC` picture (a face, presented
  as Mackscrane the Demon) in place of `GIRL1` **[confirmed]**.
- **Game code.** `Dunjun6` is byte-identical to the first &1180 bytes of
  the crack's `DUNJ3` **[confirmed]**. `Dunjun4`, `Dunjun7` and `Dunjun5`
  match the crack's `DUNJ4` except at:
  - &0450–&0484, which now holds the routine that decrypts a level and
    checks its checksum;
  - &1447–&149F, the level loader, rewritten to load `LEVELn` by calling
    the filing system's FILEV handler directly, with an OSFILE block at
    &6E60;
  - &0E00–&0E06 and the filename at &16D0;
  - bytes in &0800–&08BF, &0D2F–&0D30 and &0D80–&0D85. These look like
    values from a running game, i.e. the files were saved from memory
    **[inference]**.
- **Levels.** Its 25 `LEVELn` files, in Beebug ROMFS images (`RFS (C)
  BEEBUG`), decrypt with the disc release's scheme, and their sums match
  the disc release's table **[confirmed]**. So the levels came from the
  disc release (or its editor) while the code came from the crack, whose
  table differs for level 5. As a result the hack resets the machine on
  reaching level 5 **[confirmed in beebium]**; see
  [findings.md](findings.md).
- **Loading.** It selects `*TAPE` then `*ROM` and reads levels through
  ROMFS, so after start-up it never needs DFS, whose workspace the game
  overwrites. Whether this was the reason for the design is
  **[inference]**.
- **Loader.** `DUNK` copies the two ROMFS images into the first two
  sockets above 3 that look like sideways RAM, refuses to run on a
  Master 128, and assembles a machine-code loader at &6480. Its
  instructions say banks 4 and 5 are required, but the loader does not
  fix the banks; see [findings.md](findings.md)
  **[confirmed]**.

## Summary of relationships

```
Cassette (Bug-Byte, 1986) ──cracked──> Ole's crack (NVG Dunjunz-tape.zip)
        │                                        │
        │                                        └─code, intro──┐
        v                                                       v
Flippy disc (Bug-Byte, 1987) ──levels (and level 5's sum)──> Sideways RAM hack
  (NVG Dunjunz.zip; Master side 2,                           (BBC Micro Games Archive
   Model B side 0, level editor)                              Disc060-DunjunzRx2.ssd)
```

That the crack's code comes from the cassette, and that the 1987 disc's
code descends from the cassette's, are **[inference]**; the original
images needed to confirm them have not been found.

## Wanted

- An image of the original protected cassette (reportedly
  `Dunjunz_B.uef` on bbcmicro.co.uk).
- An image of the original flippy disc, both sides. The stardot thread
  mentions STH archive images `Dunjunz-Master-side0_M.ssd` and
  `Dunjunz-Master-side1_B.ssd` **[reported]**.

## Sources

- Stardot, "Dunjunz versions": <https://stardot.org.uk/forums/viewtopic.php?t=16227>;
  notes in [stardot-dunjunz-versions-thread.md](stardot-dunjunz-versions-thread.md).
- NVG archive: <https://rk.nvg.ntnu.no/bbc/sw/BugByte/>.
- BBC Micro Games Archive: <https://bbcmicro.co.uk/game.php?id=1068>.
- File-level details: [disc-contents-and-loading.md](disc-contents-and-loading.md),
  [`../versions/README.md`](../versions/README.md).
