---
id: em:16581e
type: reference
title: "cmux — Ghostty-based macOS terminal for parallel AI coding agents"
description: An open-source (GPL), native macOS terminal built in Swift/AppKit on libghostty for GPU-accelerated rendering, adding vertical tabs with per-pane git branch/PR/port status and agent-attention notification rings for running several AI coding agents side by side.
resource: https://cmux.com/
provenance: "Distilled from cmux.com and the manaflow-ai/cmux GitHub repository, fetched 2026-07-29"
tags: [terminal, terminal-emulator, ai-agents, developer-tools, macos, libghostty]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked to compare cmux against herdr/warp/tmux/ghostty/superlogical and to file whichever of those tools weren't already captured"
---

# cmux

cmux (Manaflow AI) is a native macOS [terminal emulator](/beliefs/glossary/terminal-emulator.md) —
not a multiplexer layered over one — built in Swift/AppKit rather than
Electron, using [libghostty](https://mitchellh.com/writing/libghostty-is-coming)
as its rendering engine ("not a Ghostty fork") for GPU-accelerated drawing,
fast startup, and low memory use. It is free, open source, and GPL-licensed,
with an optional paid "Founders Edition" for early access to features (cmux
AI, an iOS companion app, cloud VMs) layered on top of a fully-functional free
core. A Windows port, `wmux`, exists as a separate project.

## What it adds over a plain terminal

cmux's organizing idea is that AI coding agents running in parallel panes
generate background state (which branch, which PR, which port, who needs
attention) that a plain terminal makes the operator hunt for manually. It
surfaces that state directly:

- **Vertical tabs/sidebar** showing, per pane: git branch, linked PR
  status/number, working directory, listening ports, and the latest
  notification text.
- **Notification rings** around a pane, sidebar unread badges, a notification
  popover, and a native macOS desktop notification when a process needs
  attention.
- Any terminal-based agent works unmodified — Claude Code, Codex, OpenCode,
  Gemini CLI, Kiro, Aider, Goose, Amp, Cline, Cursor Agent, or anything else
  launched from the command line.
- **Remote capabilities**: SSH workspaces and the ability to attach to
  existing tmux sessions — cmux's own multi-agent orchestration turns
  subagents into native panes instead of hidden background processes.
- Split panes, an embedded scriptable browser, a programmable CLI/socket API,
  session persistence across app restarts and reboots, and an iOS companion
  app with real-time terminal syncing.

## Relationship to libghostty and the field

cmux is one of libghostty's clearest current consumers: it takes the
GPU-accelerated VT rendering libghostty extracted out of
[Ghostty](/knowledge/SWE/dev-tools/superlogical.md#origin) and wraps it in a
native macOS shell purpose-built for the agent-parallelism workflow, the same
adoption shape [Superlogical](/knowledge/SWE/dev-tools/superlogical.md) takes
for its multiplexer. Unlike [herdr](/knowledge/SWE/dev-tools/herdr.md) or
[tmux](/beliefs/glossary/terminal-multiplexer.md), which run *inside* an
existing terminal and do no rendering of their own, cmux *is* the terminal —
which is exactly the axis libherdr's own comparison matrix uses to place
"cmux/Warp" opposite "Herdr"/"tmux/Zellij" (see the matrix on
[herdr](/knowledge/SWE/dev-tools/herdr.md#positioning-against-the-field)).
Unlike Warp, which built its own proprietary GPU renderer (WarpUI, on `wgpu`)
before libghostty existed, cmux reuses libghostty rather than maintaining a
competing renderer.

# Citations

- cmux.com — <https://cmux.com/>
- GitHub: manaflow-ai/cmux — <https://github.com/manaflow-ai/cmux>
- GitHub: amirlehmam/wmux (Windows port) — <https://github.com/amirlehmam/wmux>
