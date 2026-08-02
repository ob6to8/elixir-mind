---
type: matter
title: "Reconcile the plans index against plan status, and gate the agreement"
description: Three plans sit under the plans index's `## Proposed` heading while their frontmatter reads `accepted` or `in-progress`, because the existing index gate checks that an entry exists and not which section it sits under — move the three and add the section↔status agreement check that keeps them there.
status: open
priority: 3
model: Claude Opus 5
provenance: "Claude Opus 5, scope-unit-of-work form-evaluation session"
tags: [meta, matter, tooling, elixir, verifier, index, plans, gates]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work form-evaluation session"
  why: "an eval run scoping an unrelated spec reported the drift in passing; confirmed against frontmatter across the whole index and found to be three rows and a missing gate, not a one-off typo"
  from: [/meta/threads/2026-08-02-skill-body-layout-ab-and-section-vocabulary.md]
---

# Reconcile the plans index against plan status, and gate the agreement

[`meta/plans/index.md`](/meta/plans/index.md) groups plans under three
headings — `## Proposed`, `## Accepted / In progress`, `## Done / Superseded` —
and three entries sit under the wrong one. Each doc's own gloss already ends
with its correct status, so the index disagrees with itself as well as with the
frontmatter:

| Listed under | Frontmatter says | Plan |
|---|---|---|
| `## Proposed` | `accepted` | [separate-the-model-roster-concerns](/meta/plans/separate-the-model-roster-concerns.md) |
| `## Proposed` | `accepted` | [model-column-in-the-matter-register](/meta/plans/model-column-in-the-matter-register.md) |
| `## Proposed` | `in-progress` | [reconcile-dangling-ledger-strands](/meta/plans/reconcile-dangling-ledger-strands.md) |

**Why it recurred, and why moving the rows alone does not fix it.** The
[index-listing coverage gate](/meta/matters/gate-index-listing-coverage.md)
(done, PR 216) made a *missing* entry a hard `mix brain.verify` failure — but
its subject is presence, not placement. An entry filed under the wrong heading
is present, so the gate is silent, and `/plan list` reads the docs rather than
the index, so nothing else surfaces the disagreement either. The drift is
therefore invisible until a reader trusts the index and gets a stale answer,
which is the failure mode
[a surface that must be remembered will be forgotten](/beliefs/remembered-surfaces-are-forgotten-surfaces.md)
names.

**Decisions already made.**

- **The check belongs beside the existing index pass** in
  `ElixirMind.Links`, not in a new task — the traversal that already reads
  every `index.md` for coverage can compare a plan entry's section against the
  linked doc's `status` in the same walk.
- **`mix brain.matters`'s row↔doc agreement check is the precedent** for the
  shape: read the register/index, read the docs, fail on disagreement, name the
  offending rows.
- **Scope is the plans index only.** The matters index has its own
  Open/Done split and `mix brain.matters` already covers register↔doc
  agreement; whether the same check should generalize to every status-sectioned
  index is a question for the delivering session to raise, not to settle here.

**Open decision for the delivering session:** severity. The coverage gate went
straight to hard-fail; this one could warn first, since a plan's status changes
more often than its existence. Recommend hard-fail for consistency with the
neighbouring check, but the ruling is the operator's at the gate — the same
call [gate-model-values-against-the-roster](/meta/matters/gate-model-values-against-the-roster.md)
defers.

## Model

`Claude Opus 5` — the mechanical half (moving three rows) is trivial, but the
matter's weight sits in its hardest motion: a new gate in `lib/` whose severity
and generalization boundary are design calls with no oracle behind them, which
is the roster's Opus row. Per the roster, a matter that splits across weights
is stamped for its hardest motion.
