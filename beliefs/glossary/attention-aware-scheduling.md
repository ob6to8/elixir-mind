---
id: em:954be1
type: concept
title: attention-aware scheduling
description: Feeding an operator's live focus — cursor, visible region, active buffer — back to an agent as a scheduling input, so it works ahead where the human is not looking and yields where they are.
provenance: "Agent-distilled glossary definition — named in the 2026-07-30 agent-pairing session"
verified: false
tags: [glossary, agents, supervision, scheduling, human-in-the-loop]
sense: repo
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T06:12:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "names the deferred agent-pairing capability that closes the loop between editor-as-sensor and agent behavior"
---

# attention-aware scheduling

It resolves buffer contention between a human and an agent working the same live
session by scheduling rather than locking: no write token, no handoff ritual —
the agent simply does not go where the human is. The same signal supports pacing
by attention, blocking for acknowledgement only on the file being read and
running unthrottled elsewhere.

It requires the editor to be readable as a sensor, and is the point at which
observation stops being passive: the [observer effect](/beliefs/glossary/observer-effect.md)
becomes the mechanism rather than a distortion, since the agent's behavior
changes *because* it is being watched, by design.

*Seen in:* [agent pairing architecture](/projects/agent-pairing/architecture-and-build-order.md), [the pair-programming inversion](/knowledge/SWE/agentic/supervision/agent-as-driver-pairing-inversion.md)
