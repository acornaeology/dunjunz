# How Dunjunz works

This is a tour of the resident game code, which is the same in all three
surviving releases apart from how each starts up and loads levels (see
[history-and-provenance.md](../history-and-provenance.md)). Names in
`code` are labels in the annotated listings; addresses are run-time
addresses.

## Memory

| Range | Contents |
|---|---|
| &0070–&008F | Zero-page workspace: sprite plotting (`plot_x`, `plot_y`, `sprite_number`, pointers), map pointer, pixel offsets, victory sequence |
| &0400–&07FF | Score overflow, level check, hero menu and its text |
| &0800–&0CFF | Item sprites, per-hero attributes and scores, trapdoors, sound blocks; `room_walls` at &0C00 |
| &0D00–&0DFF | Per-level workspace: heroes, missiles, keys, views. Refreshed from `workspace_template` (&7D00) for each level; when first loaded, &0D31–&0D6A holds the start-up code, which runs once |
| &0E00–&10FF | Level loop, status panel, starting attributes, game-over text, victory check |
| &1100–&16FF | Victory sequence, the Chalice sprite, the font, level start-up and loading |
| &1700–&1CBF | Sprites, sound blocks, the four sprite tables |
| &1CC0–&20FF | The frame update (`update_game`), the main loop (`play_level`) and the exit |
| &2100–&22FF | `object_free_map`, doors and keys |
| &2300–&2FFF | Sprites; `wall_sprite` (sprite 0) at &2D00 is replaced by each level |
| &3000–&6E7F | Screen |
| &6B00–&6DAF | The level file, loaded into screen memory before the screen is redrawn |
| &6E80–&7FFF | Heroes, missiles, objects, the views, monsters, keyboard, `workspace_template`, monster and object tables, and the WRCHV handler |

## The screen

The game keeps MODE 2's layout (640-byte character rows from &3000) but
reprograms the 6845 to show 25 character rows instead of 32 (VDU
23,0,6,25 in `start_level`). The left 80% holds four views, one per hero:
Ranger top left, Magic-User top right, Barbarian bottom left, Fighter
bottom right. Each view shows one room of the dungeon. A room is 8×8
cells and a cell is 4 bytes (8 pixels) wide and 12 rows high. The right
column is the status panel.

`plot_sprite` copies a sprite's bytes straight to the screen, without
masking, and `screen_address` converts a byte column and pixel row to an
address, using a table inside MOS 1.20 to multiply by 640.
`plot_at_cell` plots a sprite at a map cell, plus a pixel offset, in
every view whose room contains that cell; this is how heroes, monsters,
missiles, objects and doors appear in all the views that can see them.

There are 120 sprites, described by four tables indexed by sprite
number: data address (`sprite_addr_lo`, `sprite_addr_hi`), width and
height. Some routines change the tables while the game runs: the exit
animation shrinks a hero by rewriting their sprites' sizes, and the
victory sequence clears the Chalice's data byte by byte.

Text is printed by the MOS, but with the game's font. The WRCHV handler
(`wrch_handler`) copies the glyph of each letter or digit over the
definition of character 128 at &0C00 and prints character 128 instead.
&0C00 is also where each level's wall map goes, so the level is unpacked
only after the level number has been printed.

## The level loop

`level_loop` (&0E14) starts a level: it counts the level, writes its
number into the level's filename, and calls `start_level`:

1. `show_level_number`: clear the screen, plot the word LEVEL and print
   the number.
2. Load the level file at &6B00 and decrypt and check it (`load_level`,
   `decrypt_level`; this differs between releases).
3. `unpack_level`: copy objects, doors, keys, trapdoors, the two maps and
   the wall sprite into the game's tables (see
   [level-format.md](../level-format.md)).
4. `reset_workspace` and `reset_monsters`.
5. Draw the view frames with PLOT commands and draw the four views.

After `draw_status_panel` and `remove_absent_heroes`, `play_level` runs
the level. When it returns, every hero who died is given their starting
attributes back, and if all four died the game-over message is shown.

## The frame

`play_level` (&1F00) runs a frame every three vertical syncs. It sets the
MOS's vsync counter at &0240 to 2 and waits for it to go negative, so the
game runs at about 17 frames a second. Each frame:

- `check_for_victory`
- `update_game`:
  - `move_heroes`
  - open doors for heroes who walk into them with the right key, and
    pick up or swap keys
  - `draw_objects`, `move_missiles`, `update_monsters`
  - the pause key
- take any hero standing on the exit down it, and animate the descent.

The level ends when no hero is in play and every death animation has
finished.

## Heroes

Each hero has a cell (`hero_x`, `hero_y`), a direction, an animation
frame, and a step in progress with pixel offsets. `move_heroes` reads
each hero's keys with `test_key` (OSBYTE &81 on negative INKEY numbers
from `workspace_template`). A direction key starts a step: the hero is
drawn half a cell along for one frame, then moves into the next cell.
With Boots of Speed the hero moves straight into the cell, so twice as
fast.

Before moving, the new cell is checked for a wall (`test_wall`), a
monster (`find_creature`; bumping into one costs a health point) and
another hero. Moving into another room switches the hero's view to it
(`show_hero_room`). After moving, if `object_free_map` shows the cell
can hold an object, `collect_objects` looks for one.

The fire key launches a missile into a free slot of the hero's three,
up to `hero_max_missiles`; the bell sounds. Heroes 0 and 1 (Ranger and
Magic-User) also have a magic key, which kills every monster in the
room their view shows, for a health cost of 6 (Ranger) or 3
(Magic-User).

Health is two digit sprites (`hero_health_tens`, `hero_health_units`).
`lose_health_point` takes one point; at 00 the hero dies, leaving a
skull, and joins `returning_hero_queue`. A Cross of Resurrection brings
back the first hero in the queue, who reappears with 32 health.

## Missiles

`move_missiles` moves each of the twelve missiles one cell a frame. A
missile stops at a wall. It damages a monster (subtracting its damage
from `monster_hit_points`; below zero the monster dies and the firer
gets a point) or a hero it meets. It bounces off an energy drainer, wearing it
down a stage per hit, and the firer gets a point for each hit.

## Monsters

Up to 30 monsters (`monster_x`, `monster_y`, `monster_sprite`) move one
cell every three frames in a straight line, sliding there pixel by
pixel. When blocked by a wall or another creature they turn a random way,
using the System VIA timer. A monster that walks into a hero hurts it
(`hero_damage_taken` points). A monster killed by a missile or by magic
plays a short death animation and then reappears at the next of the
level's eight trapdoors, with `monster_start_hit_points` (8 on level 1,
two more on each later level).

## Objects, doors and keys

Objects are listed in `object_x`, `object_y` and `object_type`; an
object's type is its sprite. See [level-format.md](../level-format.md)
for what each does. Key *n* opens door *n*. A hero carries one key at a
time, swapping it for any key they walk onto. Walking into a door with
its key opens it: the door's wall bit is cleared, the key is used up,
and the hero scores 7.

## The exit

When a hero reaches the exit (object 30) they drop any key beside it,
leave play for the rest of the level, and spin round on the exit while
shrinking. `hero_enters_exit` and the code at &1FF2 do this by cutting
the width and height in the hero's sprite table entries. The exit
reappears when the animation ends.

## Winning

On level 25, a hero reaching one of the Chalice's four cells triggers
`victory_sequence`: a rising tone on the bell while sparkles circle the
Chalice, which then dissolves. The ending message that follows is not in
the program: it is read from level 25's map data. The machine is then
reset through the RESET vector.

## Dependence on the MOS

The game assumes MOS 1.20 throughout: it reads the MOS's 640-row table,
calls its reset and default OSWRCH routines directly, relies on the
vsync counter at &0240 and on character 128's definition being at &0C00,
and in the disc release chains BYTEV to a fixed address. See
[findings.md](../findings.md).
