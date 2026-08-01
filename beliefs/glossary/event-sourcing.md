---
id: em:8eb851
type: concept
title: event sourcing
description: A persistence pattern where every change to a system's state is stored as an immutable, append-only sequence of events, and current state is derived — never stored directly — by replaying that sequence; the log is the source of truth, and any materialized view is a disposable projection of it.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, architecture, persistence, event-sourcing, immutability]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T04:10:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 agent-substrate-talks thread, describing ActiveGraph's event-log-as-agent-state design"
---

# event sourcing

Standard software-architecture pattern (associated with CQRS, Martin Fowler's
writing, and systems like Kafka and event-store databases): instead of
overwriting a record in place, every state change is appended to a log as an
immutable event, and the current state is *computed* by folding over that log
rather than read from a mutable table. The payoff is the log itself becomes a
complete audit trail — replay, rollback to any prior point, and forking an
alternate history are properties of the storage model, not features that must
be separately built.

It generalizes past databases to agent architecture: an agent's own state
(prompts, tool configuration, memory) can be modeled the same way, with the log
as ground truth and the agent's runnable configuration as one queryable
[projection](/beliefs/glossary/materialize.md) of it — the pattern behind
[activegraph-event-sourced-agent-runtime](/knowledge/SWE/agentic/agentic-loop/activegraph-event-sourced-agent-runtime.md).
A git commit graph is a naturally-occurring instance of the same shape: commits
are the immutable log, and every checked-out working tree is a projection of
it.

*Seen in:* [2026-07-31 agent-substrate-talks-intake-analysis-and-ratifications thread](/meta/threads/2026-07-31-agent-substrate-talks-intake-analysis-and-ratifications.md), [activegraph-event-sourced-agent-runtime](/knowledge/SWE/agentic/agentic-loop/activegraph-event-sourced-agent-runtime.md)
