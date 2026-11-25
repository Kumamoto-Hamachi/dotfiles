#!/usr/bin/env python3
"""Antigravity CLI status line using braille progress bars (based on _.claude/statusline.py)."""
import json
import sys

BRAILLE = ' ⣀⣄⣤⣦⣶⣷⣿'
R = '\033[0m'
DIM = '\033[2m'


def gradient(pct):
    pct = min(max(pct, 0), 100)
    if pct < 50:
        r = int(pct * 5.1)
        return f'\033[38;2;{r};200;80m'
    g = int(200 - (pct - 50) * 4)
    return f'\033[38;2;255;{max(g, 0)};60m'


def braille_bar(pct, width=8):
    pct = min(max(pct, 0), 100)
    level = pct / 100
    bar = ''
    for i in range(width):
        seg_start = i / width
        seg_end = (i + 1) / width
        if level >= seg_end:
            bar += BRAILLE[7]
        elif level <= seg_start:
            bar += BRAILLE[0]
        else:
            frac = (level - seg_start) / (seg_end - seg_start)
            bar += BRAILLE[min(int(frac * 7), 7)]
    return bar


def fmt_used(label, pct):
    p = round(pct)
    return f'{DIM}{label}{R} {gradient(pct)}{braille_bar(pct)}{R} {p}%'


def fmt_remaining(label, pct):
    p = round(pct)
    return f'{DIM}{label}{R} {gradient(100 - pct)}{braille_bar(pct)}{R} {p}%'


def main():
    try:
        data = json.load(sys.stdin)
    except (json.JSONDecodeError, ValueError):
        return

    if not isinstance(data, dict):
        return

    model_info = data.get('model') or {}
    model = model_info.get('display_name') or model_info.get('id') or 'Antigravity'
    parts = [model]

    # effort はモデルが複数 effort 非対応のとき JSON に含まれない
    effort = model_info.get('effort')
    if effort:
        parts.append(f'{DIM}effort{R} {effort}')

    ctx_info = data.get('context_window') or {}
    ctx = ctx_info.get('used_percentage')
    if ctx is not None:
        parts.append(fmt_used('ctx', ctx))

    quota = data.get('quota') or {}
    for bucket, info in quota.items():
        if not isinstance(info, dict) or info.get('disabled'):
            continue
        rem_frac = info.get('remaining_fraction')
        if rem_frac is not None:
            rem_pct = min(max(rem_frac * 100, 0), 100)
            parts.append(fmt_remaining(bucket, rem_pct))
        elif info.get('remaining_amount') is not None:
            parts.append(f"{DIM}{bucket}{R} {info['remaining_amount']}")

    print(f' {DIM}│{R} '.join(parts), end='')


if __name__ == '__main__':
    main()
