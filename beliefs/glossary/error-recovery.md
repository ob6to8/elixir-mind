---
id: em:bce124
type: concept
title: error recovery
description: An agent's capacity to adapt after a failed action — revising its approach based on the observed failure rather than retrying blindly or abandoning the goal.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, agentic-loop, ai-agents, evaluation, robustness]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# error recovery

Often treated as the sharpest available test of whether a system is genuinely
agentic, precisely because it cannot be scripted: a fixed plan handles
anticipated branches, while recovery requires responding to a failure nobody
enumerated. It has a hard prerequisite that is easy to violate by accident —
the evidence must survive in context. Stripping failed calls and stack traces
produces a clean transcript in which nothing appears to have gone wrong, leaving
the model no basis for adapting and a strong prior toward repeating the move.
Mechanisms that hide failure instead of exposing it (silent retries, resampling
at a different temperature) treat the symptom while removing the signal.
Benchmarks under-measure the capability because most score task success under
ideal conditions, where recovery never has to happen.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
