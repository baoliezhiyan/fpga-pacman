#!/usr/bin/env python3
"""
从 maze_40x30.txt 读取迷宫：支持
  - 嵌套大括号：最外一层 { ... }，每行一行 {1, 0, ...},（1=墙，0=通道）
  - 或旧格式：每行 40 个空格分隔数字
渲染 pacman_maze_preview.png（640×480），并生成 maze_40x30_rows.coe。
.coe 说明见 write_coe_rows。编辑 txt 后运行本脚本；不会改写 txt。
"""

from __future__ import annotations

import re
from pathlib import Path

from PIL import Image

COLS, ROWS = 40, 30
CELL = 16
TXT_NAME = "maze_40x30.txt"
PNG_NAME = "pacman_maze_preview.png"
COE_NAME = "maze_40x30_rows.coe"


_ROW_BRACE = re.compile(r"^\s*\{([^}]*)\}\s*,?\s*$")


def load_maze_txt(path: Path) -> list[list[int]]:
    text = path.read_text(encoding="utf-8")
    rows: list[list[int]] = []
    for line_no, raw in enumerate(text.splitlines(), start=1):
        line = raw.strip()
        if not line:
            continue
        if line in ("{", "}"):
            continue
        mo = _ROW_BRACE.match(line)
        if mo:
            inner = mo.group(1).strip()
            parts = [p.strip() for p in inner.split(",") if p.strip() != ""]
        else:
            parts = line.split()
        if len(parts) != COLS:
            raise ValueError(
                f"{path}: 第 {line_no} 行应有 {COLS} 个数，实际 {len(parts)}"
            )
        row: list[int] = []
        for p in parts:
            if p not in ("0", "1"):
                raise ValueError(f"{path}: 第 {line_no} 行含非法字符 {p!r}，仅允许 0 或 1")
            row.append(int(p))
        rows.append(row)
    if len(rows) != ROWS:
        raise ValueError(f"{path}: 应有 {ROWS} 行数据，实际 {len(rows)}")
    return rows


def render_png(m: list[list[int]], path: Path) -> None:
    wpx, hpx = COLS * CELL, ROWS * CELL
    img = Image.new("RGB", (wpx, hpx), (0, 0, 0))
    wall = (0, 0, 210)
    path_c = (10, 10, 10)
    px = img.load()
    for r in range(ROWS):
        for c in range(COLS):
            color = wall if m[r][c] == 1 else path_c
            y0, x0 = r * CELL, c * CELL
            for dy in range(CELL):
                for dx in range(CELL):
                    px[x0 + dx, y0 + dy] = color
    img.save(path)


def write_coe_rows(m: list[list[int]], path: Path) -> None:
    """Vivado COE：每地址一行，40 位一行数据；列 c → 位 c（列 0 = LSB）。无注释头。"""
    lines = [
        "memory_initialization_radix = 16;",
        "memory_initialization_vector =",
    ]
    words: list[str] = []
    for r in range(ROWS):
        w = 0
        for c in range(COLS):
            if m[r][c]:
                w |= 1 << c
        words.append(f"{w:010x}")
    for i, w in enumerate(words):
        sep = ";" if i == len(words) - 1 else ","
        lines.append(f"{w}{sep}")
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> None:
    out_dir = Path(__file__).resolve().parent
    txt_path = out_dir / TXT_NAME
    png_path = out_dir / PNG_NAME
    m = load_maze_txt(txt_path)
    render_png(m, png_path)
    coe_path = out_dir / COE_NAME
    write_coe_rows(m, coe_path)
    print("Read:", txt_path)
    print("Written:", png_path)
    print("Written:", coe_path)


if __name__ == "__main__":
    main()
