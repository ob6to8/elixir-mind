---
id: em:1af093
type: concept
title: graph engineering
description: Structuring an agentic task as a graph of nodes (each an agent working in its own isolated context) connected by edges (which route one node's output to the next), run concurrently — contrasted with "loop engineering," where a single agent iterates toward a goal in a straight line.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, agents, orchestration, multi-agent, fan-out]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T04:10:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 agent-substrate-talks thread's graph-engineering capture and analysis"
---

# graph engineering

An emerging term (2026) in AI-agent practitioner circles for splitting a task
across many agents that run concurrently rather than handing it to one agent
looping through the work in sequence — the multi-agent generalization of
[loop engineering](/knowledge/SWE/agentic/agentic-loop/the-art-of-loop-engineering.md).
A **node** is one agent doing one sub-task in its own isolated context window;
an **edge** routes a node's output to the next node(s) it feeds. Common
shapes include the *diamond* (fan out to sub-agents, then narrow back into one
synthesizing agent) and *fan-in at a barrier* (the same problem sent to several
agents, each judging from a different angle, with nothing proceeding until
every agent reports).

The pattern trades wall-clock speed and per-node cost control (cheap models on
cheap sub-tasks) for a failure mode straight-line loops mostly avoid: a single
bad node can silently corrupt the merged output, and because only the finished
result is visible, tracing which node caused it is hard — the central argument
of
[graph-engineering-and-verification-skills](/knowledge/SWE/agentic/agentic-loop/graph-engineering-and-verification-skills.md).
Distinct from [fan-out](/beliefs/glossary/fan-out.md) itself (the general
concurrent-decomposition pattern): graph engineering is fan-out applied
specifically to agent orchestration, named as its own practice with its own
failure modes and verification discipline.

*Seen in:* [2026-07-31 agent-substrate-talks-intake-analysis-and-ratifications thread](/meta/threads/2026-07-31-agent-substrate-talks-intake-analysis-and-ratifications.md), [graph-engineering-and-verification-skills](/knowledge/SWE/agentic/agentic-loop/graph-engineering-and-verification-skills.md), [agent-substrate-talks-read-against-this-brain](/meta/analysis/agent-substrate-talks-read-against-this-brain.md)
