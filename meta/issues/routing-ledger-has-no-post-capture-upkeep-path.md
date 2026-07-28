---
type: issue
title: "Routing ledger has no post-capture upkeep path: who closes a strand resolved in a later session?"
description: The routing-ledger policy has /capture maintain the ledger "at capture time" over a frozen thread body, but open and paused strands are by design expected to resolve later — and no policy names who updates the row, in which doc, when that happens.
status: open
provenance: "Claude Code session, 2026-07-28 — surfaced while closing two strands from the previous day's thread, whose ledger rows had no sanctioned update path"
tags: [meta, issue, routing-ledger, session-capture, policy-gap]
timestamp: 2026-07-28T09:30:00Z
attribution:
  when: 2026-07-28T09:30:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator ratified filing the ledger-upkeep gap as an issue after it blocked a clean strand closure"
  from: [/meta/threads/2026-07-28-ontology-guardrails-intake-and-jido-comparison.md]
---

# Routing ledger has no post-capture upkeep path

## Summary

A thread's [routing ledger](/meta/policy/routing-ledger.md) carries a **State**
column with three values — `open` (live), `paused` (waiting on a dangling
question), `closed` (resolved; nothing further expected). Two of those three
describe strands that are *expected to resolve later*, in some future session.

But the policy specifies exactly one upkeep motion, and it is bound to the
originating session:

> **In-doc, maintained at capture time.** The ledger is a section of the thread
> doc itself (not a sibling file), written and updated by `/capture` in the same
> motion that routes content — routing and ledger update are one act, not a
> regeneration step that can be forgotten.

[session-capture](/meta/policy/session-capture.md) reinforces the freeze:
`/capture` runs once at close, and "the body is frozen when written; tagging and
ledger upkeep are one finalization motion over that frozen body."

So when session B resolves a strand session A left `open`, nothing says whether
B edits A's ledger row, records the closure only in B's own ledger, or leaves A's
row permanently stale. All three are defensible readings of the current text.

## Why it matters

The ledger's stated job is to answer "what would I need to know to reply to this
thread without re-reading it?" A row that says `open` when the matter is settled
answers that question **wrongly** — and it fails in the direction the brain
already treats as its characteristic hazard: stale text retrieved and trusted as
current state (see
[living-text-is-present-tense](/meta/policy/living-text-is-present-tense.md)).
Worse, the failure accumulates silently. There is no gate on ledger *accuracy* —
`mix brain.route_tags`'s ledger cross-check warns only that a routed-to concept
lacks a tag, never that a `State` value has gone stale — so drift here is
invisible by construction.

## Encountered

Two rows in
[2026-07-28-ontology-guardrails-intake-and-jido-comparison](/meta/threads/2026-07-28-ontology-guardrails-intake-and-jido-comparison.md)
("Split enforcement stack by world assumption", `open`; "No mature OWL reasoner
on the BEAM", `paused`) were resolved the following session by the
[ontology-guardrails analysis](/meta/analysis/ontology-guardrails-vs-schema-validation.md)'s
existence-proof section. Both rows were edited to `closed` in place, because
leaving them stale would misreport settled matters — but that edit is an
improvisation the policy does not sanction, which is what surfaced this issue.

## Candidate resolutions

Not yet decided — this issue records the gap, not its fix.

1. **Edit in place, explicitly permitted.** Add a carve-out to the
   routing-ledger policy: the **State** column is mutable by any later session
   that resolves the strand, while **Topic**, **Routed to**, and the thread
   *body* stay frozen. Narrow, matches what the states already imply, and keeps
   one row per matter. The cost is a second writer to a doc otherwise governed
   as frozen.
2. **Forward-only.** A later session never touches the old ledger; it records
   the closure in its own, and readers follow the routed-to doc for current
   state. Preserves the freeze absolutely, but leaves `open` rows lying in the
   corpus forever and pushes the reconciliation onto every future reader.
3. **Derive the state.** Stop hand-keeping **State** and compile it — a strand
   is `closed` when its routed-to doc says so. Fits the brain's
   generated-artifact pattern and would make the column gate-able, but needs a
   machine-readable resolution marker that does not exist today.

Option 1 is the cheapest correct fix and the one provisionally applied; option 3
is the one consistent with how the brain handles every other freshness problem.
The choice is the operator's.

## Related

- [routing-ledger](/meta/policy/routing-ledger.md) — the policy with the gap
- [session-capture](/meta/policy/session-capture.md) — the freeze rule it
  interacts with
- [route-tagging](/meta/policy/route-tagging.md) — where the ledger cross-check
  lives, and where a state-accuracy check would go if one is ever built
