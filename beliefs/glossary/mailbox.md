---
id: em:e76937
type: concept
title: mailbox
description: In the actor model, the per-process queue where messages sent to an actor accumulate until it processes them — the sole channel into an actor's private state, giving each process ordered, asynchronous, one-at-a-time message consumption without locks.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, concurrency, actor-model, beam, messaging]
sense: common
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-26 agent-teams intake thread"
---

# mailbox

On the [BEAM](/beliefs/glossary/beam.md) every process has one: `send` appends
to the recipient's mailbox, `receive` consumes selectively, and because a
[GenServer](/beliefs/glossary/genserver.md) handles one message at a time, the
mailbox is also the serialization point that makes shared-state races
impossible by construction — and the natural site of
[backpressure](/beliefs/glossary/backpressure.md) (a growing mailbox *is* the
overload signal). The term travels beyond the runtime: Claude Code's
[agent teams](/beliefs/glossary/agent-teams.md) reuse it for their JSON-file
inboxes, an on-disk approximation of the same construct without a runtime
underneath.

*Seen in:* [2026-07-26 agent-teams intake thread](/meta/threads/2026-07-26-agent-teams-intake-and-beam-jido-comparison.md), [agent teams vs. BEAM/Jido analysis](/meta/analysis/agent-teams-vs-beam-jido.md), [Claude Managed Agents vs. Jido/BEAM analysis](/meta/analysis/claude-managed-agents-vs-beam-jido.md)
