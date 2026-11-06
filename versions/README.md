# Versions

Three versions of Dunjunz are disassembled here. The reference version is
the official 1987 flippy disc; the other two are variations on the game.
Each directory holds its artefacts exactly as received, plus anything
derived from them.

| Directory | Artefact | Source | SHA-256 |
|---|---|---|---|
| `dunjunz-disc/` | `Dunjunz_D1S1_40T_HG3_8518BF40_1.hfe` (Master side) and `Dunjunz_D1S2_40T_HG3_54F4B47A_1.hfe` (Model B side): HFE v3 captures of the official flippy disc, dated 26 September 2020. Beside each, the `.ssd` and `.json` that `tools/read_disc_image.py` derives from it. `binary/` holds `Dun1` and `Coder` exported from the Model B side's SSD | Captured by VectorEyes for the "beeb_hfe" archive of original discs (<https://drive.google.com/drive/folders/140xzJarpb3HX04MaqR_m8AzDoG3Bdyky>; catalogue <https://docs.google.com/spreadsheets/d/1q006avySqZMcUGuqPlpFOgKLgdRTOzj9gucy3pS2Uks/edit?gid=0#gid=0>, Bug Byte / Dunjunz, variant 1); passed to the project by the stardot user Pernod | `d36a3816cf976a902678a69e03d097bb90a469a3ac5d97149956c5a9155f18ea`, `e0f0a56b1d6ecbca1a50b40c2d41dc6fccea525e3f16f196eb173210b7854e43` |
| `dunjunz-disc/` | `Dunjunz.zip`: the same disc's files, as directories `2/` (Master side) and `0/` (Model B side), byte-identical to the captures' | <https://rk.nvg.ntnu.no/bbc/sw/BugByte/Dunjunz.zip> | `eb63b8a5d43c204416b393015564259cfa5dc786430bd107bd277c7f71366f01` |
| `dunjunz-tape_crack_ole/` | `Dunjunz-tape.zip`: a crack of the cassette, files with `.inf` (`DUNJ`, `DUNJ2`–`DUNJ4`, `EXPAND`, `GIRL1`, `PLOAD`, `L1`–`L25`) | <https://rk.nvg.ntnu.no/bbc/sw/BugByte/Dunjunz-tape.zip> | `d5bb5d5b50aeed51696a9d120ae55c970ef51c0417559ee7ea9d4cf24927d547` |
| `dunjunz-swram_hack/` | `Disc060-DunjunzRx2.ssd`: an unofficial sideways RAM hack with the levels in ROMFS | BBC Micro Games Archive, <https://bbcmicro.co.uk/game.php?id=1068> | `868bbd3beedd8657ceb7fd8038e550375ff71888f19d941d2471bf9c26eac754` |

An image of the original cassette would go in `dunjunz-tape/`.

- **The official disc** has no copy protection. Its Model B side carries
  the game, `Coder`, the level editor (`Editor`, `Default`), the loading
  screen and `Level1`–`Level24`; its Master side carries the Master 128
  conversion and a README. Free space on the Master side holds an earlier
  draft of `BOOT`. See
  [`../docs/history-and-provenance.md`](../docs/history-and-provenance.md).
- **The tape archive is a crack.** `PLOAD` scrolls "Cracked by Ole, The
  great Demon from Denmark" over the `GIRL1` picture (unpacked by
  `EXPAND`), and the loader `DUNJ` prints "Dunjunz Was Cracked By Ole
  Cracker (MCC)". `DUNJ` adds a start-level cheat (press `@`; it pokes
  `?&5100`), loads `DUNJ2` (loading screen at &3280) and `DUNJ3` (code at
  &6E80), and runs `DUNJ4`. That file is the &0400–&2FFF game image stored
  &2000 higher, at &2400, followed by start-up code at &5000 that selects
  `*TAPE`, applies the cheat and copies the image into place. The
  original protected tape is reported on bbcmicro.co.uk as
  `Dunjunz_B.uef` (stardot thread, see `../docs`).
- **The sideways RAM disc is a hack of Ole's crack.** Its intro
  (`DUNJUNZ` lines 510–570) is `PLOAD` with new text and picture, its game
  code is the crack's with a rewritten level loader, and its level files
  come from the official disc release. See
  [`../docs/findings.md`](../docs/findings.md).
