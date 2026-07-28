---
type: issue
title: "Parallel sessions file duplicate governance artifacts for the same matter, and nothing detects it"
description: Sessions working the same day independently file separate artifacts for identical matters — todos, an issue/plan pair, and glossary terms that reached two minted em: ids; where the paths differ there is no merge conflict, so the duplication is invisible to git and to every gate.
status: open
provenance: "Claude Code session, 2026-07-28 — two instances encountered in a single session while merging main and reading the priorities digest"
tags: [meta, issue, parallel-sessions, deduplication, governance, update-in-place]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, ledger-strand reconciliation sweep"
  why: "two documented instances in one day, each costing reconciliation work and each caught only by accident, with no mechanical detector for the class"
  from: [/meta/threads/2026-07-28-routing-ledger-orphan-sweep-and-record-queue-split.md, /meta/threads/2026-07-28-owl-rdf-skos-and-the-belief-layer.md]
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

## Encountered again, same day — and the class is wider than governance

A third session that afternoon hit the same failure twice more, against a
*different* parallel session (the ontology-guardrails intake, PR #163):

| Matter | This session drafted | The parallel session filed |
|---|---|---|
| SHACL glossary term | `beliefs/glossary/shacl.md`, id `em:136984` | [`shacl`](/beliefs/glossary/shacl.md), id `em:4d3462` |
| Open-world assumption glossary term | `beliefs/glossary/open-world-assumption.md`, id `em:2674dd` | [`open-world-assumption`](/beliefs/glossary/open-world-assumption.md), id `em:d845c0` |
| OWL's fit for a formal layer | [OWL and the belief layer](/meta/analysis/owl-and-the-belief-layer.md) | [ontology guardrails vs. schema validation](/meta/analysis/ontology-guardrails-vs-schema-validation.md) |

Two things this instance adds to the diagnosis:

- **The class is not confined to governance artifacts.** These were **bundle
  documents**, and both had already been through `mix brain.id`, so the same
  term existed under two minted, permanent ids. Had the branch merged
  unreconciled, [`meta/registry.md`](/meta/registry.md) would have carried both
  and every future `verified_by` or route-tag ref would have had two equally
  valid targets to choose between. Ids are immutable by policy
  ([stable-identity](/meta/policy/stable-identity.md)), so the cleanup cost here
  is strictly higher than for a duplicate todo.
- **Same-path duplicates are the one variant git *does* catch.** The glossary
  pair collided on identical filenames, so the merge refused to proceed — which
  is why it was found. The analysis pair did not collide, was silent exactly as
  described above, and was noticed only because the glossary collision forced a
  close reading of what else `main` had landed. One noisy failure surfaced one
  silent one; nothing would have surfaced the silent one alone.

The dispositions differed by artifact kind, and the split is worth keeping: the
duplicate **terms** were dropped in favor of the already-merged ones (one term,
one id — the branch's ids were discarded before they could enter the registry),
while the two **analyses** were kept as cross-linked siblings, since they answer
different questions (enforcement at an agent loop's boundary vs. epistemic audit
of a belief corpus) and neither subsumes the other. Duplicate identity is always
a defect; overlapping *treatment* of adjacent questions is not necessarily one.

This is the third documented instance in a single day, and the first to reach
bundle documents — evidence for **candidate resolution 3** below, which is also
the only one that would have caught the analysis pair: both branches had to
exist before the overlap was visible at all.

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
