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

A matter is also a first-class document: the controlled `type: matter` in the
[vocabulary](/meta/policy/controlled-type-vocabulary.md) files each one as a
governance doc — `status` `open`/`done`/`cancelled`, plus optional
`plan`/`order` props naming the plan whose build order emits it and its
position in that plan's sequence, both omitted on standalone matters. The type
spans the scale from a plain small task (a title, a sentence of packet) to a
plan-emitted build step; an open matter outside the register is **backlog** —
filed, awaiting queueing or pickup.

*Seen in:* [the TDD research-spike thread](/meta/threads/2026-08-01-tdd-research-spike-and-methodology-adoption.md), [git-atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md), [2026-08-02 methodology-finalization thread](/meta/threads/2026-08-02-methodology-finalization.md), [2026-08-02 matters-vs-plans thread](/meta/threads/2026-08-02-matters-vs-plans-and-matter-docs.md), [2026-08-02 matter-type-vocabulary-adoption thread](/meta/threads/2026-08-02-matter-type-vocabulary-adoption.md), [2026-08-02 stand-up-meta-matters thread](/meta/threads/2026-08-02-stand-up-meta-matters-and-thin-the-register.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:4c629e">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-02-todo-fold-into-matters (2026-08-02)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:4c629e`]**  (co-feeds: `em:d7e3c5 meta/matters/codify-routes-ref-maintenance-on-file-moves.md meta/plans/matter-cli-and-neovim-surface.md`)

**3 — Judgment calls inside the approval**

| # | Call | My recommendation |
|---|---|---|
| 1 | TDD todo vs queued matter duplicate | Fold the todo's body into `tdd-bookmark-promotions.md`; no separate migration |
| 2 | Timestamps on migrated docs | Preserve — container move, not content change; keeps recency signal in the digest |
| 3 | `/todo` alias window (plan's open question) | Retire outright now; `/matter create` (build 4, next in queue) absorbs it |
| 4 | Digest queued/backlog distinction | Annotate queued matters from the register parse; plain rename is the minimal fallback if you'd rather defer register-reading to build 5 |
| 5 | `todo-cli-and-neovim-surface` plan (proposed) — its subject is renamed under it | Mechanical link repoints only; retitle/supersede stays your call, surfaced at delivery |
| 6 | Frozen threads' `<routes ref>` attributes | Update the four refs to the new paths (tag metadata maintenance; required for the hard gate) |
| 7 | `todo-type` glossary entry | Revise to retired-term pointer, keep the `em:` id |

Awaiting your approval — say the word (or adjust any of 1–7) and I'll execute.
