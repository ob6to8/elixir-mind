---
id: em:11b2ad
type: concept
title: file-canonical
description: A memory-architecture polarity in which human-readable files under version control are the source of truth and every index or database over them is derived, disposable, and rebuildable — against store-canonical designs, where the database is the record and files, if any, are an export.
provenance: "Agent-distilled glossary definition, Claude Fable 5"
verified: false
tags: [glossary, agent-memory, architecture, coined]
sense: repo
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T21:27:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-01 memory-system research-spike thread, naming the polarity its landscape and project docs turn on"
---

# file-canonical

Coined in this bundle as the compact name for the "files as source of truth,
index derived" architecture — what this brain is, what the 2026 memory
field's leaders converged toward, and the design center of the
[elixir-agent-memory](/projects/elixir-agent-memory.md) sidecar. The test is
deletion: destroying a derived index loses nothing (rebuild it from the
files), while destroying a store-canonical system's database loses the
memory itself. Most 2026 memory products (Mem0-mold extraction pipelines,
the young Elixir memory crop) are store-canonical; the polarity — not the
file format — is what the field's convergence is about: memory that is
versioned, reviewable, and attributable.

*Seen in:* [2026-08-01 memory-system research-spike thread](/meta/threads/2026-08-01-memory-system-research-spike.md), [Memory systems for coding agents — the 2026 landscape](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md), [The agent-memory strategy read against this bundle](/meta/analysis/agent-memory-strategy-for-elixir-mind.md)
