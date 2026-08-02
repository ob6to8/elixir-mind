---
id: em:4c629e
type: concept
title: matter
description: One coherent intent a reviewer can approve or reject as a whole — the unit of delivery under the atomic-pull-requests policy, tested by independence — if the operator could plausibly want to merge one part while rejecting another, those are two matters.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, git, pull-requests, review, atomicity]
sense: repo
timestamp: 2026-08-02
attribution:
  when: 2026-08-01T23:20:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary over the TDD research-spike thread"
  why: "coined as the atomic-PR policy's unit of delivery in the methodology-adoption session"
---

# matter

Defined and enforced by
[atomic pull requests](/meta/policy/git-atomic-pull-requests.md): one matter
per PR, with size only a signal — a large diff carrying one mechanical intent
(a rename, a regeneration, a verbatim capture) is one matter, while a small
diff carrying two separable decisions is two. Examples of one matter: an
intake batch on one subject, a policy adoption with its contract recompile, an
analysis, a feature with its tests.

Distinct from a [strand](/beliefs/glossary/strand.md) — a routing-ledger row
tracks a *topic* through a session's record, while a matter is a unit of
*delivery*; one strand may produce several matters, and one matter may close
several strands. Distinct also from a plan — a plan is a *decision record*
(rationale, alternatives, shape) whose build order emits a sequence of
matters, while a matter is the delivery unit itself and may stand alone with
no plan behind it
([matters vs. plans](/meta/analysis/matters-vs-plans.md)).
[The matter register](/meta/matters.md) sequences pending matters across
sessions, consumed top-down by fresh threads, per the
[matter-docs plan](/meta/plans/matter-docs-architecture.md): the global
delivery order across initiatives is the one datum it alone holds.

*Seen in:* [the TDD research-spike thread](/meta/threads/2026-08-01-tdd-research-spike-and-methodology-adoption.md), [git-atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md), [2026-08-02 methodology-finalization thread](/meta/threads/2026-08-02-methodology-finalization.md), [2026-08-02 matters-vs-plans thread](/meta/threads/2026-08-02-matters-vs-plans-and-matter-docs.md)
