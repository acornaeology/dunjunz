# Dunjunz: releases, cracks and hacks

Dunjunz was written by Julian Avis and published by Bug-Byte (cassette
1986; disc 1987). This document records what the surviving copies are,
how they relate to one another, and the evidence for each relationship.

The reference copy is the official 1987 flippy disc, from flux captures
of both its sides (`versions/dunjunz-disc/`). The other copies are
variations on the game: an archive of the same disc's files, a crack of
the 1986 cassette, and an unofficial sideways RAM hack built from the
crack and the disc. No image of the original cassette has been found.
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

The disassembly's copy of this release is a pair of flux captures, one
per side, in `versions/dunjunz-disc/` (see
[The HFE captures](#the-hfe-captures) below). The same directory keeps
`Dunjunz.zip` from the NVG archive, which holds the files of the two
sides as directories `2/` and `0/`; they are byte-identical to the
captures' **[confirmed]**. The contents of the two sides are:

- **Side 2, the boot side, is the Master version.** Its `!BOOT` chains
  `BOOT`, whose first line reads "(c) Bug Byte 1987. Mastered by S
  Benfield". `BOOT` checks `INKEY-256`. On a Master 128 (253) it shows
  `README` and runs `*DUNJUNZ` from this side. On anything else it says
  "BBC Version on the flip side of this disc. please turn over the disc
  and press the Space Bar." This side's files are locked, and several
  load into the Master's &C000–&DFFF private RAM (`Code` &C500, `Code2`
  &C700, `Code3` &D800, `Table` &C5A0) **[confirmed]**. It is disassembled
  in `versions/dunjunz-disc_master/` and described in
  [the-master-128-version.md](analysis/the-master-128-version.md).
- **The Master game descends from the cassette game, not from the Model B
  disc's.** Its resident level loop, its menu tables at &06F8, and the
  leftover "…nz1" of the cassette images' "Dunjunz1" at &07F5 are the
  cassette lineage's. The level checksum routine and table, the P pause
  key, the joystick handler and the `*DUNJUNZ` loader are taken from the
  Model B disc **[confirmed]**. So the conversion was made from the
  cassette game's code, with the disc release's parts added
  **[inference]**.
- **Side 0 is the Model B version.** `Dunjunz` (load &26C0, exec &2700),
  the game `Dun1` (&2000, &6000 bytes, up to &8000), `Screen` (&3280, the
  loading screen), `Stones` (&6E80), `Coder` (&5000), `Editor`,
  `Default`, and `Level1`–`Level24` at &6B00 **[confirmed]**. There is no
  `Level25`: `Coder` loads level 25 with `*LOAD STONES 6680`, because
  `Stones` ends with that level's data **[confirmed]**.
- The README says to turn the disc over after choosing the heroes "in
  order to access the levels of play". It describes `*EDITOR` (a level
  editor) and `*DEFAULT` (restores an edited level to its original form),
  "for the BBC model B ONLY" **[confirmed]**. Each side in fact has its own
  `Editor` and `Default`. The Master side's are conversions of the Model B
  side's, and are disassembled with it.
- **The disc's levels were edited with `*EDITOR`.** Eight of the disc's
  levels (1, 2, 4, 5, 6, 12, 22, 24) differ from the cassette's, with
  their tables reversed as `*EDITOR` saves them and their checksums kept
  **[confirmed]**. Seven have real changes to walls, objects, doors or
  keys, and level 6 was only loaded and saved. The Master `Default`
  carries the disc's versions of the other seven but the cassette's
  level 6. So level 6 was re-saved after that file was built **[inference]**.
  See [findings.md](findings.md).
- The disc's levels use the same encryption and checksum scheme as the
  sideways RAM hack (see below), and its game, `Coder` and `Editor` all
  carry the same checksum table. That table holds &4D for level 5
  **[confirmed]**.

### The HFE captures

`versions/dunjunz-disc/` holds two HFE v3 files, one per side, dated
26 September 2020. They were supplied by the stardot user Pernod by
personal communication **[reported: Pernod]**. They are captures from a
community archive of original BBC Micro discs, catalogued in the
spreadsheet "BBC discs and fingerprints" (see below). `D1S1` is the Master side and `D1S2` the
Model B side. Each is a 41-track, single-sided FM capture at 250 kbit/s.
`tools/read_disc_image.py` reads every track through beebium's emulated
8271 (sector IDs, then data) and writes the `.ssd` and a per-track
`.json` report beside each capture.

What they show **[confirmed]**:

- **No copy protection.** On both sides, tracks 0–39 are standard DFS
  tracks: ten 256-byte sectors numbered 0–9, each ID carrying its own
  track number. Every sector reads without error. Tracks 40 and 41 are
  unformatted (8271 result &18, sector not found). Track 40 is the last
  in the captures. oaknut's HFE decoder, reading the flux independently,
  finds the same layout and no deleted-data marks, and flattens each side
  to an SSD byte-identical to the 8271 reading.
- **The same files as the NVG archive.** All 19 files on the Master side
  and all 31 on the Model B side are byte-identical to `Dunjunz.zip`'s
  `2/` and `0/`, with the same load and exec addresses. The Master
  side's files are locked; the Model B side's are not.
- **Catalogues.** The Master side is titled "MASTER 128 V", with boot
  option 3 (EXEC) and 400 sectors. The Model B side is titled "Dunjunz",
  with boot option 0. Its catalogue gives 800 sectors (80 tracks),
  although the side is formatted with 40.
- **Free space.** Sectors 362–399 on the Model B side and 282–399 on the
  Master side hold &E5, the fill a fresh format leaves. On the Master
  side, sectors 274–281 hold an earlier draft of `BOOT`. It has the same
  logo procedure and flip-side message. Its Master test is the other way
  round, though: it shows "BBC Version on the flip side" on a Master, and
  has only a `REM **** MASTER MESSAGE ****` placeholder for the Master
  path.
- **Slack.** 26 files on the Model B side have non-zero bytes after their
  end, in their last sector.

### The archive catalogue

The captures' file names follow the archive's convention
(`<Title>_<Disc>_<Tracks>_<HFE grab version>_<CRC32>_<Variant>.hfe`).
The catalogue lists both under Bug Byte, Dunjunz **[reported: catalogue]**:

| Disc | Tracks | CRC32 | Variant | DFS title | Cycle | Submitter | Duplicates |
|---|---|---|---|---|---|---|---|
| D1S1 (boot, Master) | 40 | 8518BF40 | 1 | MASTER 128 V | 42 | VectorEyes | VectorEyes, pumpkin, ip |
| D1S2 (model B) | 40 | 54F4B47A | 1 | Dunjunz | 59 | VectorEyes | VectorEyes, pumpkin, ip |

The DFS titles and cycle numbers (&42, &59) match the captures'
catalogues **[confirmed]**. The catalogue gives no "birthday" date and
no copy-protection notes for either side, and lists only one variant.
VectorEyes submitted the captures. Discs owned by pumpkin and ip have the
same fingerprints.

Three copies owned by different people having identical fingerprints
shows that this is the disc as Bug-Byte duplicated it, not a one-off
copy **[inference]**. If so, the draft `BOOT` in the Master side's free
space and the Model B side's 80-track catalogue were on every copy sold,
copied sector for sector from the master disc.

### The NVG archive copy

`Dunjunz.zip` from the NVG archive (dated 31 July 1996 inside the
archive) is the files of this disc and nothing else. Its `2/` holds the
Master side's 19 files and its `0/` the Model B side's 31, all
byte-identical to the captures', with the same load and exec addresses
**[confirmed]**.

### DFS compatibility

The disc version only runs on real hardware with DFS 0.90. With DFS 1.20
and later it fails with "Bad command", and with Watford DFS it hangs
after level 2 loads **[reported: billcarr2005, lurkio, richardtoohey,
stardot]**. The game overwrites &0D00–&10FF, the DFS's NMI and workspace
area, so later levels cannot be loaded through DFS
**[reported: duikkie, stardot]**.

The Master side avoids the problem rather than depending on a DFS
version **[confirmed]**:
- the game stays resident and loads each level through OSCLI;
- it saves the filing system's page &0D in private RAM, and puts it back
  before every load;
- DFS 2.24 keeps the rest of its workspace in private RAM, away from the
  game.

See [the-master-128-version.md](analysis/the-master-128-version.md#the-disc-controller-and-the-dfs).

## Variations

### Ole's crack of the cassette

`Dunjunz-tape.zip` from the NVG archive (`versions/dunjunz-tape_crack_ole/`) is
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
  hack's files]**. Its start-up code at &5000 selects `*TAPE`, copies
  the cheat's start level into the image, and copies the image down to
  &0400 **[confirmed]**.
- The levels `L1`–`L25` (&2B0 bytes each, load &6B00) are stored
  decrypted. They are the same levels as the disc release's, whose files
  are encrypted (each byte XORed with the low byte of its address)
  **[confirmed]**.
- The code still carries the level checksum table at &0491 (&1A for
  level 5), but the routine at &0450 that would decrypt and check a level
  has been replaced by the cracker's own code **[confirmed]**. The
  cassette presumably had the decrypt-and-check routine that the disc
  release has at &0450 **[inference]**.

duikkie reports that the tape version works reliably where the disc
versions do not, because it "uses &A00 rather than &D00"
**[reported, stardot]**.

### The sideways RAM hack

`Disc060-DunjunzRx2.ssd` (`versions/dunjunz-swram_hack/`), from the BBC
Micro Games Archive, is an unofficial conversion that keeps all 25 levels
in two banks of sideways RAM as ROMFS images and loads them through the
MOS's ROM filing system **[reported as unofficial: billcarr2005,
stardot]**. Its credits say only "(c) Bug Byte 1986"; whoever made it is
not named. It is built mostly from Ole's crack, with pieces of the official disc
release:

- **Intro.** Lines 510–570 of its `DUNJUNZ` are `PLOAD`'s scroller and
  palette effects, with new text and the `PIC` picture (a face, presented
  as Mackscrane the Demon) in place of `GIRL1` **[confirmed]**.
- **Game code.** `Dunjun6` is byte-identical to the first &1180 bytes of
  the crack's `DUNJ3` **[confirmed]**. `Dunjun4`, `Dunjun7` and `Dunjun5`
  match the crack's `DUNJ4` except at:
  - &0450–&0484, which holds the routine that decrypts a level and checks
    its checksum, byte-identical to the official disc release's;
  - &1447–&149F, the level loader, rewritten to load `LEVELn` by calling
    the filing system's FILEV handler directly, with an OSFILE block at
    &6E60;
  - &0E00–&0E06, identical to the official disc release's, and the
    filename at &16D0;
  - bytes in &0800–&08BF, &0D2F–&0D30 and &0D80–&0D85. These look like
    values from a running game, i.e. the files were saved from memory
    **[inference]**.
- **Levels.** Its 25 `LEVELn` files, in Beebug ROMFS images (`RFS (C)
  BEEBUG`), decrypt with the disc release's scheme, and their sums match
  the disc release's table **[confirmed]**. (The same level data appears,
  decrypted, as the crack's `L1`–`L25`.) Its `LEVEL25` is
  byte-identical to the level 25 data at the end of the disc release's
  `Stones` **[confirmed]**. The checksum table, however, is the crack's,
  with &1A for level 5 where the disc's has &4D. With the disc's checksum
  routine restored, the hack therefore resets the machine on reaching
  level 5 **[confirmed in beebium]**; see [findings.md](findings.md).
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
        │                          code, intro, checksum table
        v                                        v
Flippy disc (Bug-Byte, 1987) ──levels, checksum routine──> Sideways RAM hack
  (HFE captures, both sides;                                 (BBC Micro Games Archive
   files archived as NVG Dunjunz.zip)                         Disc060-DunjunzRx2.ssd)
```

That the crack's code comes from the cassette, and that the 1987 disc's
code descends from the cassette's, are **[inference]**; the original
images needed to confirm them have not been found.

## Wanted

- An image of the original protected cassette (reportedly
  `Dunjunz_B.uef` on bbcmicro.co.uk).
- The stardot thread mentions STH archive images
  `Dunjunz-Master-side0_M.ssd` and `Dunjunz-Master-side1_B.ssd`
  **[reported]**, which could be compared with the captures.

## Sources

- Stardot, "Dunjunz versions": <https://stardot.org.uk/forums/viewtopic.php?t=16227>;
  notes in [stardot-dunjunz-versions-thread.md](stardot-dunjunz-versions-thread.md).
- HFE captures of the flippy disc: Pernod (stardot), personal
  communication. Captured by VectorEyes for the community archive of
  original discs ("beeb_hfe", <https://drive.google.com/drive/folders/140xzJarpb3HX04MaqR_m8AzDoG3Bdyky>), catalogued in "BBC discs and
  fingerprints" (<https://docs.google.com/spreadsheets/d/1q006avySqZMcUGuqPlpFOgKLgdRTOzj9gucy3pS2Uks/edit?gid=0#gid=0>).
- NVG archive: <https://rk.nvg.ntnu.no/bbc/sw/BugByte/>.
- BBC Micro Games Archive: <https://bbcmicro.co.uk/game.php?id=1068>.
- File-level details: [disc-contents-and-loading.md](disc-contents-and-loading.md),
  [`versions/README.md`](https://github.com/acornaeology/dunjunz/blob/master/versions/README.md).
