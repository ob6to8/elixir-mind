---
type: analysis
title: "Matters vs. plans: the delivery unit, the decision record, and the register"
description: Settles the operator's row-1 question — a matter is a review quantum and a plan a decision record whose build order emits matters — finds the register's global order irreducibly a store, and resolves the store-vs-view tension by ratifying the matter-doc architecture; todo folds into matter, issue survives, and the term matter is kept against todo/task/pr/feature.
provenance: "Claude Fable 5, matter-register consumption session, in ratification dialog with the operator"
tags: [meta, analysis, matters, plans, work-queue, terminology, types]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T07:25:00Z
  channel: agent-authored
  agent: "Claude Code agent, matter-register consumption session (row 1)"
  why: "row 1 of the matter register — the operator's matters-vs-plans question — required a persisted judgment, and the dialog ratified an architecture worth recording"
  from: [/meta/threads/2026-08-02-deferred-work-policy-and-consumed-matters-log.md]
---

# Matters vs. plans

## The question

Operator-raised, verbatim: "what's the difference between matters and plans? is
it just scope? if so, plans should really just be aggregated collections of
sequential matters that done sequentially would implement the complete scope of
the plan. are we unecessarily creating a new data type?"

## A matter is a review quantum; a plan is a decision record

Not scope — role. A matter is defined by the review boundary: "one coherent
intent a reviewer can approve or reject as a whole"
([atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md)), the quantum
of the delivery lane. A plan is defined by
[persist-plans](/meta/policy/persist-plans.md): "a durable record of *decisions
and their rationale*", plus a build order. They relate as source to emission —
a plan's build order emits a sequence of matters — and a matter needs no plan
behind it.

The operator's reduction — plans as "aggregated collections of sequential
matters" — is exactly true of the build-order dimension and silently drops the
decision record. The proof is lifecycle: when a plan's last matter is consumed,
the plan does not vanish; it flips `status: done` and is kept, because "the
decision history is the point" ([persist-plans](/meta/policy/persist-plans.md)).
What remains at that moment is everything the reduction leaves out.

And no data type had been minted: the seeded register's rows were dispatch
pointers with no `type`, no frontmatter, no id. The redundancy the question
worried about was real only as *hand-copy drift* — a row's scope cell
restating a plan's step and diverging from it after an edit.

## The order is irreducibly a store

Two alternatives were weighed. The conservative one: keep the register a
hand-kept store and contain drift by row discipline — a planned-work row
quotes or refs its plan step, never restates it. The operator-proposed one:
make plan build-orders verbatim copies of register rows, "which would then
imply the matter registry should be derived". The derivation implication is
sound — hand-kept verbatim copies in two files would be the worst shape, so
unified formats demand generation — but the generator would have incomplete
sources. Three gaps, all present in the register as it stood:

- **The cross-plan order.** Every plan can order its own steps; none can say
  whose step goes first across initiatives. That interleave is an operator
  decision, and whatever file records it is, by definition, a store.
  Derivation can relocate packet *content*; the *order* has nothing to be
  derived from.
- **Plan-less matters.** Rows existed with inline scope and no plan document
  behind them (the `/matter` skill row, the `/create-pull-request` scoping
  row).
- **Cross-initiative context.** One row's scope read "sequenced after row 1,
  which may revise it" — a sentence relating two initiatives, homeless in
  either one's plan.

## The resolution: matter docs, register as the order-only view (ratified 2026-08-02)

The ratified architecture dissolves the tension instead of picking a
side: each matter becomes a document (`type: matter`) carrying its own packet,
with an optional `plan` association and an `order` position inside that plan's
sequence; plans back-link as superstructure; and the register thins to "a
pointer registry … an opnionated view - the only data being stored would be
order" (operator, verbatim). The packets stop being copies of anything — the
docs are canonical — and the register stores exactly the one thing only it can
hold, the global sequence.

This completes the escalation shape the
[matter-queue plan](/meta/plans/matter-queue-and-present-matters.md) had
reserved ("the register becomes a `meta/matters/` directory, one file per
matter with a derived ordered view"), adding the controlled type, the props,
and the fold below. The executable spec and build order live in the
[matter-docs plan](/meta/plans/matter-docs-architecture.md), which carries the
refinements: matters live in the governance namespace (no `em:` ids, like the
todos they absorb; `plan` is a bundle-absolute path); absence is key omission,
not an explicit null; `order` is an integer renumbered on insert; the
canonical edge is matter→plan with plan-side links as prose; and the global
sequence must never invert a plan's internal order — a `mix brain.matters`
check once the structure exists.

## Todos and issues

**Issue survives.** A matter is committed work — it will be delivered as a PR.
An issue is a tracked condition that may never become work; `wontfix` is a
lifecycle outcome no delivery unit has, and an issue with no known fix cannot
be queued for delivery. The types form a pipeline — an issue spawns a matter
when its fix is decided — not a duplication.

**Todo folds into matter** (ratified 2026-08-02). A todo is near-isomorphic to
a standalone matter: same status vocabulary, same plain-task content, no plan
behind it. The one real difference — most of the 19 open todos are parked, not
sequenced — becomes a *state* rather than a type: **register membership is the
queue marker.** An open matter in the register is committed and globally
ordered; an open matter outside it is backlog, which is the todo of
convention. Forcing a total order over the parked pool was rejected as fake
precision.

## The term: `matter`, weighed and kept (ratified 2026-08-02)

With todos folding in, the operator asked whether the type should take a
conventional name instead — "it almost seems like todo is closer to convention
… we could also consider other words: task, pr, feature, etc, and weigh matter
against them". The weighing turns on what the unit fundamentally is: a
*review* quantum, not a *doing* quantum — the delivery doctrine is
review-centric ("generation is cheap and review attention is the bottleneck,
so work is shaped to fit review"), so the name should carry the review
boundary.

| Term | Fails on |
|---|---|
| `todo` | Connotes exactly the backlog half — informal, parked, no review semantics (the [coding standards](/meta/policy/elixir-coding-standards.md) define `TODO` comments as what *filed* work is not); keeping the name while adding props and PR-quantization is stealth redefinition under 19 live docs. |
| `task` | The strongest conventional candidate, disqualified in-repo: the toolchain is built of Mix *tasks*, so a `type: task` beside the `mix brain.*` tasks guarantees ambiguity exactly where precision matters. |
| `pr` | Names the shipping container, not the intent: a queued unit has no PR yet, and the atomic rule needs both words to be sayable ("one X per PR"). |
| `feature` | Most units here aren't features — policy adoptions, analyses, intake batches. |
| `ticket` / `story` / `increment` / `concern` | Tracker-object sits in `issue` territory; story demands user-value framing; increment isn't a count noun for single units in convention; in-repo "concern" already leans issue-ward (an issue is "a tracked … open concern"). |
| `matter` | Kept — its established general-English/legal sense (a discrete concern brought for disposition) *is* the review boundary; bespoke only as software jargon, and that cost is already paid: glossaried with `sense: repo`, ratified into policy, in fluent use. |

[prefer-established-terminology](/meta/policy/prefer-established-terminology.md)
decides it in both directions: its tie-breaker ("an approximate standard term
with a one-line qualification beats an exact bespoke one") is what made `task`
the real contender, the Mix-task collision breaks the tie back, and its churn
clause ("a rename's cost … usually exceeds a marginal terminology gain")
prices the switch above its gain.

## A tagging mis-route

The operator's question had been route-tagged into the *matter* glossary
entry's excerpt log, and the operator challenged the placement: "this is a
development concern, my dialog does not help define the term." Correct — and
the cause is mechanical rather than editorial: only `em:`-id documents
aggregate excerpts, and the glossary concept was the only id-bearing document
near the matter system, so system-development dialog defaulted into a
definitional surface. Both regions are retagged to path refs (the plan and
the register). The rule of thumb it leaves: **a term's excerpt log carries
definitional development only; system-development discussion back-links by
path to the governance docs it concerns.**

## Conclusions

1. Matter and plan differ by role, not scope: review quantum vs. decision
   record; a plan's build order emits matters; a matter needs no plan.
2. The register's global order is irreducibly a store; packet content is not —
   so packets move into `type: matter` docs and the register thins to the
   order-only pointer view.
3. `todo` folds into `matter` (backlog = open matter outside the register);
   `issue` survives (tracked condition vs. committed work).
4. The term `matter` is kept against `todo`, `task`, `pr`, `feature`, and kin.
5. Execution is the [matter-docs plan](/meta/plans/matter-docs-architecture.md)'s
   five-step build order, queued as register rows 1–5.
