---
id: em:3c848d
type: concept
title: next edit suggestion (NES)
description: A completion mode that predicts the developer's next edit anywhere in the file rather than the next tokens at the cursor, surfacing it as a reviewable diff to jump to and apply.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, editors, completion, copilot, tooling]
sense: common
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T06:08:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term of art surfaced by the 2026-07-30 session's survey of Neovim AI plugins"
---

# next edit suggestion (NES)

The step between inline completion and an agent: cursor-anchored ghost text can
only continue what is being typed, while a full agent needs an instruction. NES
infers the *consequences* of an edit already made — rename a parameter and it
proposes the four call sites that follow — and is fetched on a pause or cursor
move rather than on request.

Delivered through the Copilot language server and consumed by editor plugins
(sidekick.nvim renders them as Treesitter-highlighted, word-granular diffs
navigated hunk by hunk). Because the unit is a reviewable diff rather than text
at a cursor, it is the completion tier that most resembles supervision.

*Seen in:* [Neovim agent tooling landscape](/knowledge/SWE/agentic/editor-integration/neovim-agent-tooling-landscape.md)
