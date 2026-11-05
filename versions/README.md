# Versions

Three releases of Dunjunz are disassembled here. Each directory holds the
original artefact exactly as downloaded.

| Directory | Artefact | Source | SHA-256 |
|---|---|---|---|
| `nvg-dunjunz-tape/` | `Dunjunz-tape.zip`: the tape release, files with `.inf` (`DUNJ`, `DUNJ2`–`DUNJ4`, `EXPAND`, `GIRL1`, `PLOAD`, `L1`–`L25`) | <https://rk.nvg.ntnu.no/bbc/sw/BugByte/Dunjunz-tape.zip> | `d5bb5d5b50aeed51696a9d120ae55c970ef51c0417559ee7ea9d4cf24927d547` |
| `nvg-dunjunz-disc/` | `Dunjunz.zip`: the official disc release, both sides of the flippy disc as directories `0/` and `2/`, including the level editor | <https://rk.nvg.ntnu.no/bbc/sw/BugByte/Dunjunz.zip> | `eb63b8a5d43c204416b393015564259cfa5dc786430bd107bd277c7f71366f01` |
| `cbbcga-dunjunz/` | `Disc060-DunjunzRx2.ssd`: an unofficial sideways RAM hack with the levels in ROMFS | BBC Micro Games Archive, <https://bbcmicro.co.uk/game.php?id=1068> | `868bbd3beedd8657ceb7fd8038e550375ff71888f19d941d2471bf9c26eac754` |

None of these is a pristine original:

- **The tape archive is a crack.** `PLOAD` scrolls "Cracked by Ole, The
  great Demon from Denmark" over the `GIRL1` picture (unpacked by
  `EXPAND`), and the loader `DUNJ` prints "Dunjunz Was Cracked By Ole
  Cracker (MCC)". `DUNJ` adds a start-level cheat (press `@`; it pokes
  `?&5100`), loads `DUNJ2` (loading screen at &3280) and `DUNJ3` (code at
  &6E80), and runs `DUNJ4`. That file is the &0400–&2FFF game image stored
  &2000 higher, at &2400, with a relocator at its exec address &5000. The
  original protected tape is reported on bbcmicro.co.uk as
  `Dunjunz_B.uef` (stardot thread, see `../docs`).
- **The official disc release** (`Dunjunz.zip`) includes Bug-Byte's level
  editor (`EDITOR`, `CODER`, `DEFAULT`) and a README.
- **The sideways RAM disc is a hack of Ole's crack.** Its intro
  (`DUNJUNZ` lines 510–570) is `PLOAD` with new text and picture, its game
  code is the crack's with a rewritten level loader, and its level files
  come from the official disc release. See
  [`../docs/findings.md`](../docs/findings.md).
