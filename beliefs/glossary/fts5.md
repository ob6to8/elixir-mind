---
id: em:ecafe4
type: concept
title: FTS5
description: SQLite's built-in full-text-search extension — virtual tables with BM25 ranking, prefix and phrase queries — giving a single-file database ranked lexical search with no external service; compiled into Elixir's exqlite by default.
provenance: "Agent-distilled glossary definition, Claude Fable 5"
verified: false
tags: [glossary, search, sqlite, retrieval]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T21:27:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-01 memory-system research-spike thread"
---

# FTS5

What it buys over grep is exactly [BM25](/beliefs/glossary/bm25.md)'s tier:
ranking, stemming-adjacent tokenization, and phrase/prefix queries, while
staying embedded and zero-service — which is why it is tier L of the
[elixir-agent-memory plan](/projects/elixir-agent-memory/design-and-build-order.md),
the step the file-based memory school's search progression prescribes before
any embedding index.

*Seen in:* [2026-08-01 memory-system research-spike thread](/meta/threads/2026-08-01-memory-system-research-spike.md), [Elixir agent memory — design and build order](/projects/elixir-agent-memory/design-and-build-order.md)
