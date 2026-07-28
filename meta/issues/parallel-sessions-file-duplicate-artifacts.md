---
type: issue
title: "Parallel sessions file duplicate governance artifacts for the same matter, and nothing detects it"
description: Two sessions working the same day independently filed separate todos and separate issue/plan pairs for identical matters; because the files differ in name and path there is no merge conflict, so the duplication is invisible to git and to every gate.
status: open
provenance: "Claude Code session, 2026-07-28 — two instances encountered in a single session while merging main and reading the priorities digest"
tags: [meta, issue, parallel-sessions, deduplication, governance, update-in-place]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, ledger-strand reconciliation sweep"
  why: "two documented instances in one day, each costing reconciliation work and each caught only by accident, with no mechanical detector for the class"
  from: [/meta/threads/2026-07-28-routing-ledger-orphan-sweep-and-record-queue-split.md]
---

# Parallel sessions file duplicate governance artifacts

## Summary

[update-in-place](/meta/policy/update-in-place.md) requires searching the bundle
before creating a file, and
[governance-artifact-routing](/meta/policy/governance-artifact-routing.md)
restates it as **one artifact per matter**. Both rules assume the duplicate
already exists *on disk when the search runs*.

For sessions working in parallel on separate branches, it does not. Session A
searches `main`, finds nothing, and files. Session B searches the same `main`,
finds nothing, and files. Both are correct at the moment they check, and the
bundle ends up with two artifacts for one matter.

**Git cannot catch this.** The two files have different names and different
paths, so the merge is clean — there is no conflict to resolve and no gate that
fires. The duplication is silent by construction, which makes it worse than the
noisy conflict class tracked in
[generated artifacts are recurring merge-conflict magnets](/meta/issues/generated-artifact-merge-conflicts.md).
A conflict stops you; a duplicate does not.

## Encountered — two instances in one session, 2026-07-28

| Matter | This session filed | A parallel session filed |
|---|---|---|
| Generate the channels register's `Ingested` column | `generate-the-channels-register-ingested-column.md` | [`generate-the-channels-ingested-column.md`](/meta/todos/generate-the-channels-ingested-column.md) |
| Ledger has no post-capture upkeep path for a resolved strand | the [strand plan](/meta/plans/reconcile-dangling-ledger-strands.md)'s core design section | [`routing-ledger-has-no-post-capture-upkeep-path`](/meta/issues/routing-ledger-has-no-post-capture-upkeep-path.md) |

Both were caught by accident, not by any check — the first surfaced only because
an unrelated index conflict forced a `main` merge, the second only because the
priorities digest happened to rank it beside its twin. Neither would have been
noticed otherwise, and both cost reconciliation work after the fact.

The second is the more instructive: the two artifacts were different *types*
(`plan` vs `issue`) reaching the same diagnosis from opposite directions, so even
a filename-similarity check would have missed it.

## Why it matters

The brain already treats intake dedup as a first-class problem — `/intake` runs a
synonym-expanded search, and [`mix brain.dedup_probe`](/meta/evals/dedup-probe.md)
measures whether that search actually recalls existing documents. **Governance
artifacts have no equivalent.** There is no probe, no gate, and no step in
`/todo`, `/issue`, or the plan-filing flow that searches beyond the working tree.

Left alone the failure compounds: each duplicate splits a matter's history across
two documents, so the next session reads one, misses the other, and may file a
third.

## Candidate resolutions

Not decided — this issue records the problem.

1. **Search `origin/main` at filing time, not just the working tree.** Cheapest
   and narrowest: a filing flow fetches and searches the remote default branch
   before creating a governance doc. Catches session A→B only when A has already
   merged, which covers the channels case but not simultaneous work.
2. **A duplicate-matter probe over `meta/`.** Extend the `dedup_probe` shape to
   governance artifacts — title and description similarity across
   `todos`/`plans`/`issues`, reported as a warning. Would have caught the
   channels pair; the plan/issue pair is a harder target, since the wording
   differs entirely.
3. **Reconcile at merge rather than at filing.** Accept that parallel filing will
   happen and make the *merge* motion responsible: `/create-pull-request` diffs
   the branch's new governance docs against `main`'s and surfaces near-matches
   for the agent to reconcile. Catches both instances above, at the one moment
   both sides are visible.

Option 3 is the one that fits the failure's actual shape — the duplication is
only detectable once both branches exist, which is exactly what merge time means.
Options 1 and 2 are cheaper but each miss a documented instance.

## Related

- [update-in-place](/meta/policy/update-in-place.md) — the rule this defeats
- [governance-artifact-routing](/meta/policy/governance-artifact-routing.md) — "one artifact per matter"
- [generated-artifact-merge-conflicts](/meta/issues/generated-artifact-merge-conflicts.md) — the noisy sibling class
- [dedup-probe](/meta/evals/dedup-probe.md) — the instrument that exists for intake and not for governance
