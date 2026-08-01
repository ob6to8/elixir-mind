---
id: em:811803
type: concept
title: picker
description: An editor UI that presents a candidate list against a live fuzzy-filter prompt and returns the operator's selection to an action, making it the general shape by which a plugin exposes any queryable set without designing a bespoke interface for it.
provenance: "Agent-distilled glossary definition, 2026-07-31 session"
verified: false
sense: common
tags: [glossary, editors, neovim, user-interface, terminology]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 todo-surface thread cited in Seen in"
---

# picker

In Neovim the pattern is supplied by Telescope, `fzf-lua`, and `snacks.nvim`,
with a minimal built-in form at `vim.ui.select`. Files, buffers, git commits,
LSP symbols, and diagnostics are all conventionally surfaced this way, which is
why a plugin adding a new data source typically writes a picker over it rather
than a window: the interaction is already familiar, and the filtering is
someone else's code.

The shape it imposes on a data source is worth noting — a picker wants the
whole candidate list up front so it can filter locally, so a source behind a
slow call is fetched once per session rather than queried per keystroke.

*Seen in:* [2026-07-31 todo-surface thread](/meta/threads/2026-07-31-todo-surface-cli-and-neovim-plan.md)
