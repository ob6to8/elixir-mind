---
id: em:3cbfb6
type: concept
title: agent-as-driver
description: The supervision posture that assigns the pair-programming driver role to the agent and the navigator role to the human — the agent types while the operator watches, corrects at the moment of divergence, and holds strategy.
provenance: "Agent-distilled glossary definition — named in the 2026-07-30 agent-pairing session"
verified: false
tags: [glossary, agents, supervision, pair-programming, workflow]
sense: repo
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T06:10:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "names the posture the agent-pairing project is built to serve"
---

# agent-as-driver

The role assignment is the natural one for agentic coding — the agent supplies
throughput, the human supplies judgment — and is precisely the arrangement
mainstream tooling does *not* implement: an agent that works out of sight and
presents a finished changeset is doing asynchronous code review, not pairing.
The operator formulation is *driving the driver*.

What separates the posture from diff review is interruption latency: a wrong
turn is corrected while it happens rather than after it has been built out.
Its cost is full attention, which places it opposite
[monitor by exception](/beliefs/glossary/monitor-by-exception.md) on the
supervision spectrum, making it a per-task posture rather than a mode. Canonical
treatment in
[the pair-programming inversion](/knowledge/SWE/agentic/supervision/agent-as-driver-pairing-inversion.md).

*Seen in:* [the pair-programming inversion](/knowledge/SWE/agentic/supervision/agent-as-driver-pairing-inversion.md), [agent pairing](/projects/agent-pairing.md)
