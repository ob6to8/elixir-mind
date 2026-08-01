---
id: em:8ca1b6
type: concept
title: read-back
description: A separate call, issued after a state-changing action, that reads the target system's own record of the resulting state — as opposed to trusting the acting call's own return value or status code as evidence the action succeeded.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, verification, agent-output, observability]
sense: repo
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-29 post-action-readback thread; central to both beliefs it filed and the plan applying them"
---

# read-back

A `200` from a write call is evidence the request was *accepted*, a fact about the
request — not about whether the write landed. A read-back is a distinct call,
issued afterward, against the [source of truth](/beliefs/glossary/source-of-truth.md)
for the state in question, capable of returning an answer that contradicts what the
acting call claimed. Folding the confirmation into the acting call itself — a write
endpoint that echoes back what it says it stored — reintroduces the defect a
read-back exists to remove, since the echo shares the same code path and the same
transaction that may not commit.

Not every read qualifies: a check built from material the acting side itself
produced is testimony wearing a read-back's shape, and is worse than no check at
all, since its failure mode is a false positive exactly when the real failure has
occurred (see
[only what the other side produced is evidence](/beliefs/only-what-the-other-side-produced-is-evidence.md)).

*Seen in:* [2026-07-29 post-action read-back belief and plan thread](/meta/threads/2026-07-29-post-action-readback-belief-and-plan.md)
