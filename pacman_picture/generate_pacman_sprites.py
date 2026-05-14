#!/usr/bin/env python3
"""
生成两张 32x32 经典风格吃豆人精灵：张嘴朝右、闭嘴整圆；水平居中靠上为 3x3 黑色方格眼睛。
输出 PNG（RGBA，背景透明）、每行 RRGGBB 的文本，以及 Vivado Block RAM 用的 .coe（RGB888，行优先）。
"""

from __future__ import annotations

import math
from pathlib import Path

from PIL import Image


W = H = 32
CX = 15.5
CY = 15.5
R = 14.0
YELLOW = (255, 255, 0, 255)
BLACK = (0, 0, 0, 255)
TRANSPARENT = (0, 0, 0, 0)

# 透明像素写入 ROM 的颜色（与当前 VGA 背景黑一致，便于直接覆盖绘制）
TRANSPARENT_RGB888 = (0x00, 0x00, 0x00)

# 水平居中、靠画布垂直中线上方：3x3 黑格（列 14–16，行 8–10）
EYE_X0, EYE_X1 = 14, 16
EYE_Y0, EYE_Y1 = 8, 10


def in_eye_square(x: int, y: int) -> bool:
    return EYE_X0 <= x <= EYE_X1 and EYE_Y0 <= y <= EYE_Y1


def pixel_rgba(
    x: int,
    y: int,
    mouth_half_rad: float,
) -> tuple[int, int, int, int]:
    dx = x - CX
    dy = y - CY
    dist_sq = dx * dx + dy * dy
    if dist_sq > R * R:
        return TRANSPARENT
    if mouth_half_rad <= 0.0:
        body = YELLOW
    else:
        ang = math.atan2(dy, dx)
        if -mouth_half_rad <= ang <= mouth_half_rad:
            return TRANSPARENT
        body = YELLOW
    if in_eye_square(x, y):
        return BLACK
    return body


def build_image(mouth_half_rad: float) -> Image.Image:
    im = Image.new("RGBA", (W, H), TRANSPARENT)
    for y in range(H):
        for x in range(W):
            im.putpixel((x, y), pixel_rgba(x, y, mouth_half_rad))
    return im


def write_hex_rows(img: Image.Image, path: Path) -> None:
    """每行 32 个像素，格式 RRGGBB（无 alpha；透明写为 000000）。"""
    lines: list[str] = []
    for y in range(H):
        row: list[str] = []
        for x in range(W):
            r, g, b, a = img.getpixel((x, y))
            if a < 128:
                row.append("000000")
            else:
                row.append(f"{r:02X}{g:02X}{b:02X}")
        lines.append(" ".join(row))
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def rgb888_for_coe(img: Image.Image, x: int, y: int) -> int:
    r, g, b, a = img.getpixel((x, y))
    if a < 128:
        r, g, b = TRANSPARENT_RGB888
    return (r << 16) | (g << 8) | b


def write_coe(img: Image.Image, path: Path, header_comment: str) -> None:
    """Xilinx COE：radix 16，每地址一行，RGB888（6 位十六进制），行优先 scan。"""
    words: list[str] = []
    for y in range(H):
        for x in range(W):
            words.append(f"{rgb888_for_coe(img, x, y):06x}")
    lines = [
        f"// {header_comment}",
        "memory_initialization_radix = 16;",
        "memory_initialization_vector =",
    ]
    for i, w in enumerate(words):
        sep = ";" if i == len(words) - 1 else ","
        lines.append(f"{w}{sep}")
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> None:
    out_dir = Path(__file__).resolve().parent
    # 张嘴：约 70° 总开口，朝 +X
    open_half = math.radians(35.0)
    img_open = build_image(open_half)
    path_open = out_dir / "pacman_mouth_open.png"
    img_open.save(path_open)
    write_hex_rows(img_open, out_dir / "pacman_mouth_open_pixels.txt")
    write_coe(
        img_open,
        out_dir / "pacman_mouth_open.coe",
        "32x32 Pac-Man mouth open, RGB888, row-major (y then x), depth=1024, transparent=000000",
    )

    # 闭嘴：整圆（mouth_half_rad=0 走全填充分支）
    img_closed = build_image(0.0)
    path_closed = out_dir / "pacman_mouth_closed.png"
    img_closed.save(path_closed)
    write_hex_rows(img_closed, out_dir / "pacman_mouth_closed_pixels.txt")
    write_coe(
        img_closed,
        out_dir / "pacman_mouth_closed.coe",
        "32x32 Pac-Man mouth closed, RGB888, row-major (y then x), depth=1024, transparent=000000",
    )

    print("Written:")
    print(f"  {path_open}")
    print(f"  {path_closed}")
    print(f"  {out_dir / 'pacman_mouth_open_pixels.txt'}")
    print(f"  {out_dir / 'pacman_mouth_closed_pixels.txt'}")
    print(f"  {out_dir / 'pacman_mouth_open.coe'}")
    print(f"  {out_dir / 'pacman_mouth_closed.coe'}")


if __name__ == "__main__":
    main()
