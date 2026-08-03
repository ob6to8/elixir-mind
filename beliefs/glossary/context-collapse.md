---
id: em:a6bed8
type: concept
title: context collapse
description: A failure mode of self-rewriting memory and context stores in which iterative LLM rewriting erodes accumulated detail — a single bad consolidation pass can destroy most of a store's value — named by the ACE (Agentic Context Engineering) work and taken as an argument for append-only or delta-based memory designs over rewrite-in-place.
provenance: "Agent-distilled glossary definition, Claude Fable 5"
verified: false
tags: [glossary, context-engineering, agent-memory, failure-modes]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T21:27:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-01 memory-system research-spike thread"
---

# context collapse

Distinct from [context rot](/beliefs/glossary/context-rot.md), which is
degradation of a model's *attention* as input grows: collapse is degradation
of the *store itself* under its own maintenance loop. ACE pairs it with
"brevity bias" (summaries dropping domain insight) as the two ways an LLM
curating its own memory quietly destroys it — the evidence stream behind
write-gated and append-only memory designs.

*Seen in:* [2026-08-01 memory-system research-spike thread](/meta/threads/2026-08-01-memory-system-research-spike.md), [Memory systems for coding agents — the 2026 landscape](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md)
