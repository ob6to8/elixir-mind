---
id: em:6e6dd5
type: concept
title: TUI (terminal user interface)
description: A full-screen interactive program that paints its interface with terminal escape sequences inside whatever terminal emulator it runs in — vim, lazygit, htop, Claude Code — portable anywhere a terminal works.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, terminal, tooling]
sense: common
timestamp: 2026-07-18
attribution:
  when: 2026-07-18T07:05:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-18 agent-drivable-apps thread"
---

# TUI (terminal user interface)

The portability follows from the layering: because the program only emits
escape codes, it renders identically in any
[terminal emulator](/beliefs/glossary/terminal-emulator.md), over SSH, or in a
[multiplexer](/beliefs/glossary/terminal-multiplexer.md) pane. A TUI that also
listens on a socket (Neovim, the hunk diff viewer) can be driven by another
process while a human watches it — the pattern this bundle records as
[shared state, dual interfaces](/beliefs/glossary/shared-state-dual-interfaces.md).

A TUI is also the natural **client half** of a
[daemon](/beliefs/glossary/daemon.md)-plus-client split: because it borrows an
existing terminal rather than owning a window, it costs nothing to close and
reopen, and it works unchanged over SSH — which is why herdr's viewer is a TUI
while the [PTYs](/beliefs/glossary/pty.md) stay with its daemon.

*Seen in:* [2026-07-18 agent-drivable-apps thread](/meta/threads/2026-07-18-agent-drivable-apps-warp-hunk-nvim.md), [agent-drivable-apps analysis](/meta/analysis/agent-drivable-apps-shared-state-dual-interfaces.md), [the daemon owns the PTYs](/meta/elaborations/herdr-daemon-owns-the-ptys.md)
