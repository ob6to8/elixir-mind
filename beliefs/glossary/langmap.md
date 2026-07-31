---
id: em:2fd346
type: concept
title: langmap
description: A Vim option that translates keystrokes typed on the active keyboard layout into the characters Vim's own command mappings expect, letting a user type on a layout other than the one Vim's defaults assume without remapping every command by hand.
verified: false
sense: common
tags: [glossary, vim, keyboard-layouts, configuration]
timestamp: 2026-07-31
provenance: "Agent-distilled glossary definition"
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 Dvorak-vim thread"
---

# langmap

Vim also ships a stock `$VIMRUNTIME/macros/dvorak` macro alongside it. Exactly
which modes and command categories `langmap` covers — reportedly insert,
search, and command-line text entry, leaving normal-mode command characters
untouched — was unverified as of the thread that surfaced this term; check
`:h langmap` directly rather than relying on this entry for that detail.

*Seen in:* [2026-07-31 — Dvorak vim reference and practice project](/meta/threads/2026-07-31-dvorak-vim-reference-and-practice-project.md)
