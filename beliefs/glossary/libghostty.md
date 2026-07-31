---
id: em:5dec1d
type: concept
title: libghostty
description: A C-ABI library that extracts Ghostty's terminal-emulation core — currently libghostty-vt, zero-dependency VT-sequence parsing and terminal-state management — so other applications can embed correct terminal rendering instead of writing their own ad-hoc ANSI parser.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, terminal, tooling, developer-tools]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 herdr/cmux terminal-tool comparison thread"
---

# libghostty

Created by Mitchell Hashimoto by extracting [Ghostty](/knowledge/SWE/dev-tools/superlogical.md#origin)'s
proven [terminal emulator](/beliefs/glossary/terminal-emulator.md) core into a
reusable, cross-platform library, on the observation that terminal emulation
shows up far beyond dedicated terminal apps — IDEs, CI tools, and platforms all
parse VT sequences, usually with incomplete, buggy, one-off implementations.
Adoption so far tracks a clean split: apps that render their own terminal
content pick it up ([cmux](/knowledge/SWE/dev-tools/cmux.md) wraps it directly;
[Superlogical](/knowledge/SWE/dev-tools/superlogical.md)'s multiplexer clients
build on it), while pure [terminal multiplexers](/beliefs/glossary/terminal-multiplexer.md)
that host inside an existing terminal and do no rendering of their own
([herdr](/knowledge/SWE/dev-tools/herdr.md), tmux) have no surface where it
would apply. Warp predates it with its own GPU renderer, so its absence there
reflects prior art rather than rejection.

*Seen in:* [2026-07-31 herdr/cmux terminal-tool comparison thread](/meta/threads/2026-07-31-herdr-cmux-terminal-tool-comparison-intake.md)
