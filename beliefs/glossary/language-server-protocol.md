---
id: em:cfaa13
type: concept
title: Language Server Protocol (LSP)
description: The open protocol by which an editor delegates language intelligence — completion, go-to-definition, and diagnostics — to a per-language analysis server, so each language is supported once rather than once per editor.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, editors, tooling, protocol, lsp]
sense: common
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T06:06:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "load-bearing term throughout the 2026-07-30 agent-pairing session and absent from the glossary"
---

# Language Server Protocol (LSP)

Introduced by Microsoft for VS Code and since adopted broadly (Neovim ships a
built-in client), it collapses the N×M editor-language integration cost the same
way [MCP](/beliefs/glossary/model-context-protocol.md) does for agent tooling.
Servers such as `gopls`, `rust-analyzer`, and `elixir-ls` run as separate
processes speaking JSON-RPC.

**Diagnostics** — the server's stream of errors, warnings, and hints for a
file — matter disproportionately for agent supervision: they are computed
continuously against the buffer's *current* state including unsaved edits, and
held in editor memory, so nothing on disk contains them. An agent that can query
them gets a correctness signal covering work-in-progress without paying for a
compile or a test run, which is the concrete payoff of treating the editor as a
sensor.

*Seen in:* [Neovim agent tooling landscape](/knowledge/SWE/agentic/editor-integration/neovim-agent-tooling-landscape.md), [ambient agent observability](/knowledge/SWE/agentic/supervision/ambient-agent-observability.md)
