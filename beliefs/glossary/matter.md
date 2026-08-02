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
several strands. [The matter register](/meta/matters.md) sequences pending
matters across sessions, consumed top-down by fresh threads with each row a
self-contained handoff packet, per the
[matter-queue plan](/meta/plans/matter-queue-and-present-matters.md).

*Seen in:* [the TDD research-spike thread](/meta/threads/2026-08-01-tdd-research-spike-and-methodology-adoption.md), [git-atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md), [2026-08-02 methodology-finalization thread](/meta/threads/2026-08-02-methodology-finalization.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:4c629e">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-02-deferred-work-policy-and-consumed-matters-log (2026-08-02)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:4c629e`]**  (co-feeds: `meta/matters.md`)

it seems like essentially what we have done with matters is create an ordered fifo queue of work, like an ordered list of steps that should all break down to being atomic (single concern) PR's. my question at this point is - what's the difference between matters and plans? is it just scope? if so, plans should really just be aggregated collections of sequential matters that done sequentially would implement the complete scope of the plan. are we unecessarily creating a new data type?

this is an important question that needs to be discussed, but as you've pointed out this PR has already extended to 2 concerns, which is more that 1, which is the goal. so my guess is: we should punt, describe this question as a new matter, and bump that to the top of the matter list to be handled next, and it would be the next session that may or may not reconfigure how matters are defined and handled

---

**[`em:4c629e`]**  (co-feeds: `meta/matters.md`)

Punted per your direction, so only my seed read, which I also compressed into the row for the next session: the reduction is nearly right, with one inversion and one gap. A `plan` carries the *decision record* — rationale, alternatives, shape — plus a per-initiative build order; a matter is a unit of *delivery*. For planned work, rows are exactly what you say: the plan's build order projected into the queue. But the register holds the one thing no individual plan can — the global delivery order across initiatives (bias-taxonomy rows interleave with dev-history rows) — and micro-matters exist with no plan behind them. So "plans = aggregated sequential matters" captures the delivery dimension while dropping the decision-record dimension. The sharper form of your redundancy worry, and what the next session should settle: whether rows for planned work ought to be *derived projections* of plan build-orders rather than hand-copies — i.e., is the register a store or a view. (A new controlled `type` was never minted — rows are dispatch, not documents — so the "new data type" risk lives in that hand-copy duplication, not in the vocabulary.)
