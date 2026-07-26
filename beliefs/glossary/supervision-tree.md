---
id: em:025b76
type: concept
title: supervision tree
description: The hierarchical process structure at the heart of OTP fault tolerance — supervisor processes whose only job is to watch child processes (workers or further supervisors) and restart them according to a declared strategy when they crash, so failure handling is a structural property of the tree rather than code inside each worker.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, otp, beam, fault-tolerance, supervision]
sense: common
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-26 agent-teams intake thread"
---

# supervision tree

The mechanism behind [let-it-crash](/beliefs/glossary/let-it-crash.md): workers
don't defensively handle their own failures — they crash, and the supervisor
above them applies its restart strategy (one-for-one, one-for-all,
rest-for-one) with backoff, isolating the blast radius to the failed subtree.
Trees compose, so an application's fault-tolerance topology is declared once as
structure. [Jido](/beliefs/glossary/jido.md) hosts each agent under one; the
contrast term in this bundle's multi-agent analyses is manual recovery — e.g.
Claude Code [agent teams](/beliefs/glossary/agent-teams.md), where a stopped
teammate is replaced by hand.

*Seen in:* [2026-07-26 agent-teams intake thread](/meta/threads/2026-07-26-agent-teams-intake-and-beam-jido-comparison.md), [agent teams vs. BEAM/Jido analysis](/meta/analysis/agent-teams-vs-beam-jido.md), [BEAM/Jido evaluation](/meta/analysis/beam-deployment-and-jido-2-evaluation.md)
