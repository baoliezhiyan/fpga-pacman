#!/usr/bin/env python3
"""
生成两张 32×32 幽灵精灵 PNG，以及 Vivado 用的 .coe（RGB888 行优先）：
  - ghost_skirt_4_v2.png / ghost_skirt_4_v2.coe：下摆四齿
  - ghost_skirt_3_v2.png / ghost_skirt_3_v2.coe：下摆三齿

点阵在下方 GRID_* 元组中编辑，脚本只做映射与导出：
  - R → 身体红  - W → 眼白白  - B → 纯黑（瞳孔等）  - . → 背景（渲染为纯黑，与 B 同色）

不再自动生成像素 .txt，也不在脚本里二次绘制瞳孔；图中一切由你的阵列决定。
"""

from __future__ import annotations

from pathlib import Path

from PIL import Image

W = H = 32

BLACK = (0, 0, 0)
RED = (255, 0, 0)
WHITE = (255, 255, 255)
BLUE = (0, 0, 255)


def _grid_from_chars(rows: tuple[str, ...]) -> list[list[tuple[int, int, int]]]:
    """将点阵字符转为 RGB：R 红、W 白、B 黑、. 背景（同为纯黑 RGB，便于编辑区分语义）。"""
    if len(rows) != H:
        raise ValueError(f"expect {H} rows, got {len(rows)}")
    buf: list[list[tuple[int, int, int]]] = []
    for row in rows:
        if len(row) != W:
            raise ValueError(f"each row must be length {W}")
        line: list[tuple[int, int, int]] = []
        for ch in row:
            if ch == ".":
                line.append(BLACK)
            elif ch == "R":
                line.append(RED)
            elif ch == "W":
                line.append(WHITE)
            elif ch == "B":
                line.append(BLUE)
            else:
                raise ValueError(f"bad char {ch!r} (use R W B .)")
        buf.append(line)
    return buf


def _image_from_grid(grid: list[list[tuple[int, int, int]]]) -> Image.Image:
    im = Image.new("RGB", (W, H), BLACK)
    pix = im.load()
    for y in range(H):
        for x in range(W):
            pix[x, y] = grid[y][x]
    return im


# --- 32×32 点阵（自行编辑下方 GRID_* 元组）---
# R=红，W=白，B=黑（瞳孔等），.=背景

# 版本 2：下摆四片（四齿），完全对称，最大化占满 32x32
GRID_SKIRT_4_V2_ROWS: tuple[str, ...] = (
    "................................",
    "................................",
    ".............RRRRRR.............",
    "...........RRRRRRRRRR...........",
    ".......RRRRRRRRRRRRRRRRRR.......",
    "......RRRRRRRRRRRRRRRRRRRR......",
    "....RRRRRRRRRRRRRRRRRRRRRRRR....",
    "..RRRRRRRRRRRRRRRRRRRRRRRRRRRR..",
    "..RRRRRRRRRRRRRRRRRRRRRRRRRRRR..",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRWWWRRRRRRRRRWWWRRRRRRRR.",
    ".RRRRRRWBBBWRRRRRRRWBBBWRRRRRRR.",
    ".RRRRRRWBBBWRRRRRRRWBBBWRRRRRRR.",
    ".RRRRRRWBBBWRRRRRRRWBBBWRRRRRRR.",
    ".RRRRRRWWWWWRRRRRRRWWWWWRRRRRRR.",
    ".RRRRRRRWWWRRRRRRRRRWWWRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRR..RRRRRR......RRRRRR..RRRR.",
    ".RRR....RRRRR......RRRRR....RRR.",
    ".RRR.....RRRR......RRRR.....RRR.",
    ".RR.......RRR......RRR.......RR.",
    ".R.........RR......RR.........R.",
    "................................",
    "................................",
)

# 版本 2：下摆三片（三齿），完全对称，最大化占满 32x32
GRID_SKIRT_3_V2_ROWS: tuple[str, ...] = (
    "................................",
    "................................",
    ".............RRRRRR.............",
    "...........RRRRRRRRRR...........",
    ".......RRRRRRRRRRRRRRRRRR.......",
    "......RRRRRRRRRRRRRRRRRRRR......",
    "....RRRRRRRRRRRRRRRRRRRRRRRR....",
    "..RRRRRRRRRRRRRRRRRRRRRRRRRRRR..",
    "..RRRRRRRRRRRRRRRRRRRRRRRRRRRR..",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRWWWRRRRRRRRRWWWRRRRRRRR.",
    ".RRRRRRWWWWWRRRRRRRWWWWWRRRRRRR.",
    ".RRRRRRWBBBWRRRRRRRWBBBWRRRRRRR.",
    ".RRRRRRWBBBWRRRRRRRWBBBWRRRRRRR.",
    ".RRRRRRWBBBWRRRRRRRWBBBWRRRRRRR.",
    ".RRRRRRRWWWRRRRRRRRRWWWRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR.",
    ".RRRRRRRR..RRRRRRRRRR..RRRRRRRR.",
    ".RRRRRRR....RRRRRRRR....RRRRRRR.",
    ".RRRRRR......RRRRRR......RRRRRR.",
    "..RRRR........RRRR........RRRR..",
    "...RR..........RR..........RR...",
    "................................",
    "................................",
)


def write_coe(im: Image.Image, path: Path, header_comment: str) -> None:
    words: list[str] = []
    for y in range(H):
        for x in range(W):
            r, g, b = im.getpixel((x, y))
            v = (r << 16) | (g << 8) | b
            words.append(f"{v:06x}")
    lines = [
        f"// {header_comment}",
        "memory_initialization_radix = 16;",
        "memory_initialization_vector =",
    ]
    for i, word in enumerate(words):
        sep = ";" if i == len(words) - 1 else ","
        lines.append(f"{word}{sep}")
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> None:
    out_dir = Path(__file__).resolve().parent

    g4 = _grid_from_chars(GRID_SKIRT_4_V2_ROWS)
    im4 = _image_from_grid(g4)
    p4 = out_dir / "ghost_skirt_4_v2.png"
    im4.save(p4)

    g3 = _grid_from_chars(GRID_SKIRT_3_V2_ROWS)
    im3 = _image_from_grid(g3)
    p3 = out_dir / "ghost_skirt_3_v2.png"
    im3.save(p3)

    write_coe(
        im4,
        out_dir / "ghost_skirt_4_v2.coe",
        "32x32 ghost R/W/B/. grid, skirt 4 lobes, RGB888 row-major, depth=1024",
    )
    write_coe(
        im3,
        out_dir / "ghost_skirt_3_v2.coe",
        "32x32 ghost R/W/B/. grid, skirt 3 lobes, RGB888 row-major, depth=1024",
    )

    print("Written:")
    print(f"  {p4}")
    print(f"  {p3}")
    print(f"  {out_dir / 'ghost_skirt_4_v2.coe'}")
    print(f"  {out_dir / 'ghost_skirt_3_v2.coe'}")


if __name__ == "__main__":
    main()