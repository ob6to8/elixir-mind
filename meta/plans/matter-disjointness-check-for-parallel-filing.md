---
type: plan
title: "Matter-disjointness check for parallel filing"
description: Build one near-match comparator over newly-filed governance documents and invoke it at the two moments both sides of a duplicate first become visible — Workflow fold-back and pull-request time — closing the gap where the fan-out readiness gate partitions files but not matters, and where parallel sessions already file duplicate artifacts that git cannot catch.
status: proposed
provenance: "Claude Code session (model undisclosed — the environment withholds the identifier from committed artifacts), 2026-07-31 — the actionable residue of the agent-substrate analysis's finding 3"
tags: [meta, plan, fan-out, workflow, deduplication, governance, parallel-sessions, tooling]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T02:55:00Z
  channel: agent-authored
  agent: "Claude Code agent, agent-substrate analysis session"
  why: "operator ratified extending the fan-out readiness gate to matter-disjointness before the pilot runs; the same comparator also closes the already-documented cross-session duplicate-filing failure"
  from: [/meta/threads/2026-07-31-agent-substrate-talks-intake-analysis-and-ratifications.md]
---

# Matter-disjointness check for parallel filing

## Problem

[Parallel sessions file duplicate governance artifacts](/meta/issues/parallel-sessions-file-duplicate-artifacts.md)
records three instances in one day where two workers each searched `main`, each
correctly found nothing, and each filed. The paths differ, so "**Git cannot catch
this.**" One instance reached bundle documents under two minted permanent ids.

The [fan-out execution convention](/meta/analysis/executing-ratified-plans-via-workflow-fan-out.md)
would multiply the exposure. Its readiness gate requires that "no two parallel
workstreams claim the same files or the same derived surface" — **file**
disjointness. Two workstreams with provably disjoint file sets can still produce
two artifacts for one matter, because the collision is semantic and the paths
differ by construction. The convention names
[three-level documentation](/meta/plans/three-level-documentation.md) as its
recommended pilot, so this is a near-term dependency rather than a hypothetical.

The issue's own preferred resolution is its option 3 — reconcile at merge,
"at the one moment both sides are visible." That insight generalizes: the check
belongs wherever two independently-authored candidate sets first meet. Under
fan-out that moment is **fold-back**; across sessions it is **pull-request
time**. One comparator serves both.

## Current state — where a duplicate can pass

```
parallel work
├── workstream / session A ── searches main ── files meta/todos/x.md ──┐
├── workstream / session B ── searches main ── files meta/todos/y.md ──┤
│                                                    (same matter)     │
├── readiness gate ....... checks FILE disjointness ......... passes ──┤
├── fold-back ............ no cross-workstream comparison ... passes ──┤
├── gate suite ........... verify/route-tags/glossary ....... passes ──┤
└── merge ................ different paths, no conflict ..... passes ──┘
                                                       duplicate lands
```

## Desired state

```
parallel work
├── workstream / session A ── files meta/todos/x.md ──┐
├── workstream / session B ── files meta/todos/y.md ──┤
├── readiness gate ....... FILE disjointness (unchanged) ─────┤
├── fold-back ............ + matter check over returned set ──┤ warn
├── PR time .............. + matter check vs origin/main ─────┤ warn
└── merge ................ agent reconciled or recorded why ──┘
```

Both new call sites run the same comparator; neither blocks. A warning names
the candidate pair and the agent reconciles or records why the two are
legitimately distinct — the issue itself documents a correct non-merge (two
analyses kept as cross-linked siblings because "neither subsumes the other").

## File-tree diff

```
lib/elixir_mind/
  matter_overlap.ex          # NEW — enumerate governance docs, index, compare pairwise
lib/mix/tasks/
  brain.matter_overlap.ex    # NEW — CLI: --against <ref> | --among <paths>
test/elixir_mind/
  matter_overlap_test.exs    # NEW — pinned on the issue's three documented instances
.claude/skills/create-pull-request/
  SKILL.md                   # MODIFIED — run the check vs origin/main before commit
meta/analysis/
  executing-ratified-plans-via-workflow-fan-out.md  # MODIFIED — fold-back gains the check
```

## Signatures

```elixir
@type candidate :: %{path: String.t(), title: String.t(), description: String.t(), type: String.t()}
@type pair :: %{a: candidate, b: candidate, score: float, shared: [String.t()]}

@spec candidates(root :: String.t(), paths :: [String.t()]) :: [candidate]
@spec against(root :: String.t(), ref :: String.t()) :: [pair]
@spec among(root :: String.t(), paths :: [String.t()]) :: [pair]
@spec report([pair]) :: String.t()
```

## Boundary decisions

- **Enumeration** is by path under `meta/`, not by `em:` id — governance docs
  carry no id, which is why the existing registry-and-id machinery does not
  already cover this class.
- **Comparison** reuses the indexing shape of
  [`ElixirMind.DedupProbe.search_index/1`](/lib/elixir_mind/dedup_probe.ex)
  (title + description + tags + body → searchable text) rather than inventing a
  second one; the probe's index is keyed on ids, so the shape transfers but the
  enumeration does not.
- **The comparator warns and never fails.** Adjacent-but-distinct artifacts are
  common and correct here; a gate would train agents to suppress it. This
  matches the route-tag cross-check and dedup-probe posture.
- **Reconciliation is the agent's**, at the call site — the tool reports pairs,
  it never merges or deletes.
- **Offline and dependency-free**, so it satisfies the contract's standing
  admission rule and can later earn a gate if the false-positive rate proves low.

## Known limit, stated up front

Lexical comparison catches the issue's **channels-register todo pair** (near-identical
titles) and misses its **plan/issue pair**, where two artifacts reached the same
diagnosis from opposite directions with entirely different wording. That miss is
accepted: converting some silent failures into noisy ones is the gain, and the
issue documents that the hard case was caught only by a human reading both.
A semantic judge would be network-dependent and non-deterministic, failing the
admission rule and — per
[intent-is-the-source](/meta/doctrine/intent-is-the-source.md) — moving the
oracle rather than building one. The report is input to agent judgment, not a
replacement for it.

## Build order

1. `ElixirMind.MatterOverlap` + `mix brain.matter_overlap`, with the test pinned
   on the three documented instances (two must warn; the sibling-analyses pair
   must be reconcilable as a correct non-merge).
2. Wire into `/create-pull-request` against `origin/main` — this alone closes the
   documented cross-session case, independent of any fan-out work.
3. Wire into the fan-out convention's fold-back phase, and note in its readiness
   gate that file disjointness does not imply matter disjointness.

Step 2 delivers value with no dependency on fan-out ever shipping; step 3 is the
part that must precede the pilot.

## Decision list

- **Recommended shape.** One comparator, two call sites, warn-only.
- **Rejected: extend the readiness gate instead.** At readiness time nothing has
  been written, so only declared intent could be compared — weaker evidence than
  the artifacts themselves, and the issue's own diagnosis is that detection
  requires both sides to exist.
- **Rejected: a semantic/LLM judge.** See the known limit above.
- **Rejected: fold into the dedup probe.** That probe measures *recall of an
  entry search* against a gold set; this measures *pairwise overlap in a candidate
  set*. Different question, different input, and merging them would muddy a
  trend metric the intake flow already depends on.
- **Open — the threshold.** What score surfaces a pair? To be set from the
  documented instances rather than guessed, during step 1.
- **Open — scope beyond `meta/`.** The issue's third instance reached
  `beliefs/glossary/`, i.e. bundle documents with ids. Extending enumeration past
  `meta/` is deferred until the governance case is working.
