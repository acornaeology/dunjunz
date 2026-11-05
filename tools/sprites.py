"""Render the game's sprites as a labelled contact sheet.

Reads the sprite tables (sprite_addr_lo/hi at &1AE0/&1B58, widths at
&1BD0, heights at &1C48) from a version's resident image and draws every
sprite in the default MODE 2 colours, scaled up, with its number.

Usage: uv run python tools/sprites.py OUT_FILEPATH [swr|tape|disc]
"""

import sys
from pathlib import Path

from PIL import Image, ImageDraw

sys.path.insert(0, str(Path(__file__).resolve().parent))
from runtime_images import disc_image, swr_image, tape_image  # noqa: E402

PALETTE = [(0, 0, 0), (255, 0, 0), (0, 255, 0), (255, 255, 0),
           (0, 0, 255), (255, 0, 255), (0, 255, 255), (255, 255, 255)] * 2
SPRITE_COUNT = 120
SCALE = 4
CELL_W, CELL_H = 30 * SCALE, 40 * SCALE


def mode2_pixels(byte):
    left = ((byte >> 7) & 1) << 3 | ((byte >> 5) & 1) << 2 | ((byte >> 3) & 1) << 1 | ((byte >> 1) & 1)
    right = ((byte >> 6) & 1) << 3 | ((byte >> 4) & 1) << 2 | ((byte >> 2) & 1) << 1 | (byte & 1)
    return left, right


def main():
    out_filepath = Path(sys.argv[1])
    version = sys.argv[2] if len(sys.argv) > 2 else "swr"
    image = {"swr": swr_image, "tape": tape_image, "disc": disc_image}[version]()
    cols = 12
    rows = (SPRITE_COUNT + cols - 1) // cols
    sheet = Image.new("RGB", (cols * CELL_W, rows * CELL_H), (40, 40, 40))
    draw = ImageDraw.Draw(sheet)
    for n in range(SPRITE_COUNT):
        addr = image.get(0x1AE0 + n, 0) | image.get(0x1B58 + n, 0) << 8
        width, height = image.get(0x1BD0 + n, 0), image.get(0x1C48 + n, 0)
        ox, oy = (n % cols) * CELL_W, (n // cols) * CELL_H
        draw.text((ox + 2, oy + 2), f"{n} &{n:02X}", fill=(200, 200, 200))
        draw.text((ox + 2, oy + 12), f"&{addr:04X} {width}x{height}", fill=(150, 150, 150))
        for row in range(min(height, 32)):
            for col in range(min(width, 12)):
                byte = image.get(addr + row * width + col, 0)
                for half, colour in enumerate(mode2_pixels(byte)):
                    x = ox + 4 + (col * 2 + half) * SCALE
                    y = oy + 26 + row * (SCALE // 2 + 1)
                    draw.rectangle([x, y, x + SCALE - 1, y + SCALE // 2], fill=PALETTE[colour])
    sheet.save(out_filepath)


if __name__ == "__main__":
    main()
