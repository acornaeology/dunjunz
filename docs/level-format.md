# Dunjunz level format

Each of the 25 levels is a file of &2B0 bytes, loaded at &6B00–&6DAF. The
layout below comes from the routine that unpacks it (`unpack_level`,
&1510) and the code that uses the tables it fills; `tools/levels.py`
decodes a level and draws its map as text.

## Storage and protection

| Release | Files | Form |
|---|---|---|
| Official disc | `Level1`–`Level24`, and level 25 at the end of `Stones` (`*LOAD STONES 6680`) | Encrypted |
| Ole's crack | `L1`–`L25` | Decrypted |
| Sideways RAM hack | `LEVEL1`–`LEVEL25` in two Beebug ROMFS images | Encrypted |

All three hold the same level data. In the encrypted form each byte is
XORed with the low byte of its own address (&6B00 + offset).
`decrypt_level` (&0450) reverses this in place and checks the sum of the
decrypted bytes, modulo 256, against `level_checksums` (&0491–&04A9),
resetting the machine on a mismatch. See [findings.md](findings.md) for
level 5, whose sum (&4D) differs from the table in the crack and the hack
(&1A).

## Layout

Tables of positions are 1-based: entry *n* of a table at *T* is at
*T* + *n*, and the byte at *T* itself is not used. Unused entries hold &FF.

| Offset | Address | Length | Contents | Copied to |
|---|---|---|---|---|
| &000 | &6B00 | &20 | Objects' x (entries 1–30) | `object_x` &7F20 |
| &020 | &6B20 | &20 | Objects' y | `object_y` &7F3F |
| &040 | &6B40 | &20 | Objects' types | `object_type` &7F5E |
| &060 | &6B60 | &15 | Doors' x (entries 1–20) | `door_x` &2200 |
| &075 | &6B75 | &15 | Doors' y | `door_y` &2220 |
| &08A | &6B8A | &15 | Doors' sprites | `door_sprite` &2240 |
| &0A0 | &6BA0 | &15 | Keys' x (entries 1–20) | `key_x` &2260 |
| &0B5 | &6BB5 | &15 | Keys' y | `key_y` &2280 |
| &0D0 | &6BD0 | 8 | Trapdoors' x (entries 0–7) | `trapdoor_x` &0B90 |
| &0D8 | &6BD8 | 8 | Trapdoors' y | `trapdoor_y` &0B98 |
| &0E0 | &6BE0 | &C9 | Wall map | `room_walls` &0C00 |
| &1B0 | &6CB0 | &C9 | Object-free map | `object_free_map` &2100 |
| &280 | &6D80 | &30 | The level's wall block: sprite 0, 4 bytes × 12 rows | `wall_sprite` &2D00 |

Bytes not listed (for example &6B8A+&15 to &6B9F) are not copied.

## The map

The dungeon is a grid of rooms of 8×8 cells, four rooms across and six
down (32×48 cells); each hero's view shows one room. Level 1 uses only the
top four rows of rooms. A cell (x, y) is in
the room whose eight bytes start at (y AND &F8) × 4 + (x AND &F8) in a
map, and its bit is bit 7 − (x AND 7) of the byte at offset y AND 7 within
the room. The game copies &C9 bytes of each map; the 32×48 grid needs &C0.

- **Wall map**: a set bit is a wall. Doors are walls in this map until
  opened, when `update_game` clears the bit.
- **Object-free map**: a clear bit marks a cell where an object may lie.
  After each step `move_heroes` searches the object list only when the
  hero's new cell is clear in this map. On every level each object's cell
  is clear, along with a few other cells on some levels.

## Objects

Object 30 is always the exit (type &51). An object's type is also its
sprite number.

| Type | Object | Effect (`collect_objects`, &7329) |
|---|---|---|
| &28 | Treasure | 20 points |
| &29 | Food | +10 health (at most 99), 5 points |
| &2A | Cross of Resurrection | Brings back the first hero waiting in `returning_hero_queue`; 10 points |
| &2B | Teleporter | Moves the hero to the cell above the previous teleporter in the list |
| &51 | Exit | Handled by the main loop (`exit_x`, `exit_y`) |
| &53–&5E | Energy drainer | −10 health on contact; each missile hit advances the type, and at &5F it disappears |
| &5F | Boots of Speed | Worn until lost; 10 points |
| &60 | Magic helmet | Health lost per hit −1 (to at least 3); 10 points |
| &61 | Potion of healing | Health becomes the score's last digit, doubled (e.g. 77); 10 points |
| &62 | Pile of weapons | One more missile in flight (at most 3); 10 points |
| &63 | Magic sword | Missile damage +1 (at most 9); 10 points |

## Doors, keys and trapdoors

Key *n* opens door *n*. A hero carries one key at a time (`hero_key`); in
`update_game`, walking onto a key swaps it with the one carried, and
walking into the matching door opens it. The level's monsters emerge, in
turn, from its eight trapdoors.

## Level 25 carries the ending message

When a hero reaches the Chalice on level 25, `check_for_victory` prints
140 bytes from &0C3A (`room_walls` + &3A) and then a zero-terminated
string from &213A (`object_free_map` + &3A). On level 25 those bytes are
the end of the game's text, stored in the level's two maps:

> THE SPELL HIDING THE CHALICE HAS  BEEN BROKEN AND  IT IS NOW BACK INTHE
> GODS HANDS.  FOR THE TIME THE WORLD IS A SAFE  PLACE AGAIN,AND  YOU ARE
> HAILED ASTHE WORLDS GREAT HEROES.          BUT MACKSCRANE   STILL LIVES ...

That is why level 25's lower rooms (map offsets &3A onwards) show an
irregular wall pattern and no objects, and why its object-free map has
many clear bits that are not objects. Editing those rooms of level 25
changes the ending text.

## Cross-check

David Boddie's DunjunzMaps tools
(<https://github.com/stardot/DunjunzMaps>, `dunjunz.py`) read the same
offsets for objects, doors, keys, trapdoors and both maps, treat a clear
bit of the second map as "collectable", read the map as 48 rows, take the
level's wall sprite from its last bytes, and carry a checksum table with
&4D for level 5 (the official disc's). Its `add_checksum` makes an edited
level pass the check by adjusting the level's last byte.

## Open questions

- How the win check's cells (x &1A–&1B, y 4–5 on level 25) relate to the
  objects placed there.
- Whether the map rows below the ending message on level 25 are reachable.
