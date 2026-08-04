---
id: em:f116ac
type: concept
title: LongMemEval
description: An academic long-term-memory benchmark (ICLR 2025) testing five abilities — information extraction, multi-session reasoning, temporal reasoning, knowledge updates, and abstention — over freely scalable chat histories, generally treated as more rigorous than LoCoMo because it is vendor-independent and tests supersession and knowing-when-not-to-answer.
provenance: "Agent-distilled glossary definition, Claude Fable 5"
verified: false
tags: [glossary, agent-memory, benchmarks, evals]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T21:27:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-01 memory-system research-spike thread"
---

# LongMemEval

The knowledge-update and abstention categories are what distinguish it from
recall-only instruments like [LoCoMo](/beliefs/glossary/locomo.md): they test
whether a memory system tracks facts that change over time and declines to
answer what it does not hold — the temporal-validity property
knowledge-graph memory systems (Zep/Graphiti) build for.

*Seen in:* [2026-08-01 memory-system research-spike thread](/meta/threads/2026-08-01-memory-system-research-spike.md), [Memory systems for coding agents — the 2026 landscape](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md)
