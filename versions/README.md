# Versions

Four versions of Dunjunz are disassembled here. The reference version is
the official 1987 flippy disc's Model B side; the disc's Master 128 side
is the official Master conversion; the other two are variations on the
game.
Each directory holds its artefacts exactly as received, plus anything
derived from them.

| Directory | Artefact | Source | SHA-256 |
|---|---|---|---|
| `dunjunz-disc/` | `Dunjunz_D1S1_40T_HG3_8518BF40_1.hfe` (Master side) and `Dunjunz_D1S2_40T_HG3_54F4B47A_1.hfe` (Model B side): HFE v3 captures of the official flippy disc, dated 26 September 2020. Beside each, the `.ssd` and `.json` that `tools/read_disc_image.py` derives from it. `binary/` holds `Dun1` and `Coder` exported from the Model B side's SSD | Captured by VectorEyes for the "beeb_hfe" archive of original discs (<https://drive.google.com/drive/folders/140xzJarpb3HX04MaqR_m8AzDoG3Bdyky>; catalogue <https://docs.google.com/spreadsheets/d/1q006avySqZMcUGuqPlpFOgKLgdRTOzj9gucy3pS2Uks/edit?gid=0#gid=0>, Bug Byte / Dunjunz, variant 1); passed to the project by the stardot user Pernod | `d36a3816cf976a902678a69e03d097bb90a469a3ac5d97149956c5a9155f18ea`, `e0f0a56b1d6ecbca1a50b40c2d41dc6fccea525e3f16f196eb173210b7854e43` |
| `dunjunz-disc/` | `Dunjunz.zip`: the same disc's files, as directories `2/` (Master side) and `0/` (Model B side), byte-identical to the captures' | <https://rk.nvg.ntnu.no/bbc/sw/BugByte/Dunjunz.zip> | `eb63b8a5d43c204416b393015564259cfa5dc786430bd107bd277c7f71366f01` |
| `dunjunz-disc_master/` | `binary/`: the Master side's thirteen machine-code files (the game's `Coder`, `Dunj2`–`Dunj5`, `Code`, `Code2`, `Code3`, `Table`; the loaders `Dunjunz` and `Coder2`; `Editor`; `Default`), `BOOT`, `!BOOT` and `README`, exported with oaknut-hfe from `../dunjunz-disc/Dunjunz_D1S1_40T_HG3_8518BF40_1.hfe` and byte-identical to the NVG archive's directory `2/` | The Master side of the same capture | `Dunj4` `eea3437a16b47ce67a0827624bcfd1423e18874c71bb44dac2381a5cfcc12fda`; `Dunj2` `beaf537792185dd503fc75c7ee270031ea2419f320ae590afa6b48f9e183252b`; `Dunj3` `7bd2914816b9e7cd78c9d2e2c32476ca7a5b31ea0762f30f091d535d7b3bc09b`; `Dunj5` `9570db6679b6891014282d340787d1b285190c5e0a52e4bb2230928796f69599`; `Coder` `5644ad487550f31773733036717cac829049c779f72c21ca61b00a5caccbd5da`; `Coder2` `a32ffa23236c7aae944d6d3201bf41ded524362436f8002ca9b1713a276c8770`; `Dunjunz` `0aa7fe8a18a33d4a06fdbc24c0fdb1e73996cadc371c71f1d0045c9e6b025edc`; `Code` `74334c347574b3ddde2453cff2af1407fff26c3df86935202c0913de8494ca46`; `Table` `d1e827713b361d9aae10867625d720ee7a6ebf8886e27c8ee12fc61aaca766f6`; `Code2` `3932a404d63de87ab4a57a538cc0dff42baceff89a198d92ba8426eab2b8c565`; `Code3` `6b928cb975a0c5b5b77b12ec0f114af0796cf97fde85e29054227dc7245c416f`; `Editor` `b97927871258742ac7a1da946c64aa404042c73cc05b7f50392b972f113266e6`; `Default` `5595a8c171a280816365f1654d0a7c76732382d398a8cb301ba7ae28e71c4873`; `BOOT` `d779f055abdc816925da91b4a66f6c1a0baacf36f117df7aadef5fc47e74a4ef` |
| `dunjunz-tape_crack_ole/` | `Dunjunz-tape.zip`: a crack of the cassette, files with `.inf` (`DUNJ`, `DUNJ2`–`DUNJ4`, `EXPAND`, `GIRL1`, `PLOAD`, `L1`–`L25`) | <https://rk.nvg.ntnu.no/bbc/sw/BugByte/Dunjunz-tape.zip> | `d5bb5d5b50aeed51696a9d120ae55c970ef51c0417559ee7ea9d4cf24927d547` |
| `dunjunz-swram_hack/` | `Disc060-DunjunzRx2.ssd`: an unofficial sideways RAM hack with the levels in ROMFS | BBC Micro Games Archive, <https://bbcmicro.co.uk/game.php?id=1068> | `868bbd3beedd8657ceb7fd8038e550375ff71888f19d941d2471bf9c26eac754` |

An image of the original cassette would go in `dunjunz-tape/`.

- **The official disc** has no copy protection. Its Model B side carries
  the game, `Coder`, the level editor (`Editor`, `Default`), the loading
  screen and `Level1`–`Level24`; its Master side carries the Master 128
  conversion and a README. Free space on the Master side holds an earlier
  draft of `BOOT`. The two sides are separate versions here:
  `dunjunz-disc/` (Model B) and `dunjunz-disc_master/` (Master 128),
  the captures living in the former. See
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
