---
id: em:f617da
type: reference
title: "bottom (btm)"
description: A cross-platform (Linux/macOS/Windows), graphical terminal system-and-process monitor written in Rust, covering CPU, memory, network, disk, and temperature widgets with a customizable dashboard layout.
resource: https://github.com/ClementTsang/bottom
provenance: "ClementTsang/bottom GitHub repo, fetched 2026-08-21"
tags: [rust, cli, terminal, system-monitoring, tui]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# bottom (btm)

A terminal system monitor written in Rust, positioned against `htop`/`top`
by leaning into graphical time-series widgets rather than plain tabular text,
while still shipping a `htop`-inspired "basic mode" for a more familiar view.

## What it shows

Zoomable graphs for per-core and average CPU usage, memory/swap, and
network/disk I/O, plus disk capacity, temperature sensors, and battery
status. The process widget supports searching, sorting, sending signals to
processes, and viewing them as a hierarchical tree. Individual widgets can be
expanded to full-screen for focused monitoring.

## Customization

Configurable via CLI flags or an auto-generated config file — color themes,
per-widget behavior, and overall dashboard layout are all adjustable, and
individual displays support filtering out specific entries.

## Lineage and platform reach

Inspired by `gotop` and `gtop`, extending their concept with more
customization and — notably for a tool in this space — first-class Windows
support alongside Linux and macOS.

# Citations

- ClementTsang/bottom (repo) — <https://github.com/ClementTsang/bottom>
