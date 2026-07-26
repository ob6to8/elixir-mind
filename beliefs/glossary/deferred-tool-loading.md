---
id: em:da5194
type: concept
title: deferred tool loading
description: Withholding tool definitions from a model's context and fetching them on demand through a search tool, so a large catalog costs only the tokens of the tools actually needed.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, tool-use, context-engineering, mcp, agentic-loop]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# deferred tool loading

It answers definition bloat: a catalog of several dozen tools can consume tens of
thousands of tokens before the agent does anything, and selection accuracy
degrades as the list grows, so the tokens buy negative value past a point. The
mechanism marks definitions as deferred, exposes only a small search facility
plus whatever must stay resident, and expands matches into full definitions when
the model asks — Anthropic's Tool Search Tool (2025-11) ships regex and BM25
variants of exactly this, with reported reductions around 85% of tool-definition
tokens and substantial gains on tool-selection evaluations. Note what it does
*not* do: definitions arrive as appends late in the context rather than as edits
to the front of it, so the practice is compatible with
[prefix caching](/beliefs/glossary/prefix-caching.md) despite looking like the
dynamic tool mutation that cache discipline forbids.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
