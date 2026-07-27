---
id: em:b35eea
type: concept
title: Dynamic Workflows
description: Anthropic's Claude Code feature (research preview, May 2026) in which Claude writes a JavaScript orchestration script that a separate runtime executes in the background, fanning a task out to up to ~1,000 stateless subagents whose results feed back through one deterministic control plane.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, anthropic, claude-code, dynamic-workflows, orchestration, multi-agent, agents]
sense: common
timestamp: 2026-07-16
attribution:
  when: 2026-07-16T10:20:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-16 Dynamic Workflows vs. BEAM/Jido 2 analysis thread"
---

# Dynamic Workflows

A Claude Code capability (Anthropic, research preview May 2026) for coordinating
large numbers of subagents on one task. Claude authors a JavaScript
**orchestration script** — built from combinators like `agent()`, `parallel()`,
and `pipeline()` — which a separate runtime executes in the background (up to
~1,000 subagents, ~16 concurrent). The design deliberately splits a
**[deterministic](/beliefs/glossary/deterministic-spine.md) control plane** (the
script's loops, conditionals, and fan-out) from the **non-deterministic**
intelligence (the subagent calls): subagents are effectively functions — prompt in,
optionally schema-validated data out, back to the orchestrator — that hold no state
between calls and never message each other, communicating only through the script
and a shared filesystem. Because the script is constrained to be deterministic
(`Date.now`/`Math.random` are unavailable), a run can be **resumed**, with the
unchanged prefix of subagent calls returning cached results — event-sourced replay
aimed at cost and iteration speed. It is an *ephemeral, session-scoped* orchestrator
that computes one answer and exits — an application of the
[orchestrator pattern](/beliefs/glossary/orchestrator-pattern.md) to a bounded
fan-out of inference, distinct from a standing
[actor-model](/beliefs/glossary/actor-model.md) fleet and from the hosted
long-running sessions of [Claude Managed Agents](/beliefs/glossary/claude-managed-agents.md).

*Seen in:* [Dynamic Workflows vs. BEAM/Jido 2 analysis](/meta/analysis/dynamic-workflows-vs-beam-jido.md), [2026-07-16 Dynamic Workflows vs. BEAM/Jido thread](/meta/threads/2026-07-16-dynamic-workflows-vs-beam-jido.md)
