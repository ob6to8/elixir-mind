---
id: em:2b3010
type: concept
title: agentic search
description: Retrieval performed by the model itself navigating a corpus with search tools (grep, glob, file reads) inside its agentic loop, rather than querying a pre-built embedding index — the retrieval posture Claude Code adopted after dropping its early RAG pipeline.
provenance: "Agent-distilled glossary definition, Claude Fable 5"
verified: false
tags: [glossary, retrieval, agentic, context-engineering]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T21:27:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-01 memory-system research-spike thread"
---

# agentic search

One pole of a three-way retrieval-posture axis: agentic pull (the model
searches just-in-time), external index (a
[vector database](/beliefs/glossary/vector-database.md) or
[RAG](/beliefs/glossary/retrieval-augmented-generation.md) stack retrieves
for it), and graph pre-load (a deterministic pass packs ranked context into
the prompt up front). Its trade is tokens for freshness and simplicity: no
index to sync or secure, at the cost of exploration turns — the cost the
other two postures sell against.

*Seen in:* [2026-08-01 memory-system research-spike thread](/meta/threads/2026-08-01-memory-system-research-spike.md), [Memory systems for coding agents — the 2026 landscape](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md), [GrapeRoot](/knowledge/SWE/agentic/code-context/graperoot.md)
