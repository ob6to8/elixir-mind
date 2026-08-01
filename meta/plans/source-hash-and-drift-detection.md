---
type: plan
title: "Hash captured sources and detect drift: closing the evidence-layer gap terse-brain's Raw provenance exposed"
description: Add an optional content hash to any document carrying a resource URI, captured at intake time, plus a new mix brain.source_drift task that re-fetches each hashed resource and reports which have changed or gone dark since capture — closing the one asymmetry terse-brain's provenance layer has over this bundle's verification ladder, which guarantees a verified_by target exists but not that it still says what it said when cited.
status: proposed
provenance: "Claude Code session (Claude Sonnet 5), 2026-08-01 — designed from the terse-brain evaluation's source-hashing finding; persisted rather than executed because it needs a network-boundary design decision (opt-in vs. mandatory, re-fetch cadence) the operator should set before code lands"
tags: [meta, plan, verification, provenance, tooling, elixir, drift, terse]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, terse-brain-evaluation session"
  why: "operator selected this action from the terse-brain evaluation, which named it the one idea worth a design pass rather than a direct port"
  from: [/meta/threads/2026-08-01-terse-brain-evaluation-and-index-coverage-gate.md]
---

# Hash captured sources and detect drift

Grounded in one finding from the
[terse-brain evaluation](/meta/analysis/terse-lang-terse-brain-evaluation.md):
`terse-brain`'s `register-source` computes a sha256 of every registered
source, mirrors its bytes into content-addressed storage, and flags
`BRAIN-C raw-drift` when the hash or origin path stops matching. This
bundle's verification ladder is stricter than terse-brain's at the
*statement* layer — `verified_by` requires its target to exist, `verified:
true` is rejected on any capture — but it has no equivalent at the *evidence*
layer: nothing detects a cited article being silently edited, paywalled, or
taken down after a `resource` URI was captured. 124 documents currently carry
a `resource` field; 32 are `type: source` — the tier the verification ladder
treats as trusted evidence for a `verified: true` claim.

## The problem

`quote-primary-sources` already requires a verbatim span for anything quoted
or used to back `verified: true`; the ladder assumes the cited resource still
says what it said at capture time. Nothing checks that assumption after the
fact. A source drifting silently is exactly the failure terse-brain's
`BRAIN-C` targets, and it is the sharper of the two asymmetries the
evaluation found (the other — index-listing coverage — is already closed).

## Current-state tree

```
Intake (agent reads a URL, distills, files a document)
├── frontmatter.resource = <URI>              # the only record of the source
├── frontmatter.provenance = <free text>       # origin, not a checkable value
└── (nothing captured about the fetched bytes — no hash, no fetch timestamp)

mix brain.verify
└── grounding_errors/1                         # verified_by resolution only —
                                                 # never re-reads what a resource points at
```

## Desired-state tree

```
Intake (unchanged distillation; one new optional step)
├── frontmatter.resource = <URI>                (unchanged)
├── frontmatter.provenance = <free text>        (unchanged)
└── frontmatter.resource_hash: {                # NEW, optional — omitted when not captured
      sha256: "<hex>",
      captured: <ISO date>
    }

mix brain.source_drift                          # NEW mix task, network, non-gating
├── selects every doc with both resource + resource_hash
├── re-fetches each resource (reuses the existing fetch path already used
│   by /intake and /bookmarks — no second HTTP client)
├── re-hashes the response body
└── reports: unchanged | changed (hash mismatch) | unreachable (fetch failed)
    — never fails the task; a report, like `mix brain.orphans`
```

## File-tree diff

```
lib/elixir_mind/
  source_drift.ex          # NEW — hashing + report-building logic (pure, given fetched bytes)
lib/mix/tasks/
  brain.source_drift.ex    # NEW — the network-boundary task; thin wrapper calling SourceDrift
                            #   plus whatever fetch primitive /intake already uses
test/elixir_mind/
  source_drift_test.exs    # NEW — pure hashing/report logic, no network (fixture bytes in/out)
meta/policy/
  frontmatter-schema.md    # MODIFIED — document resource_hash as an optional sub-map,
                            #   same tier as verified_by: present only when captured
.claude/skills/intake/
  SKILL.md                 # MODIFIED — offer resource_hash capture as an opt-in step
                            #   (see open question 1: opt-in vs. mandatory)
```

## Boundary decisions

- **Hashing is captured at intake time, by the same fetch that already reads
  the resource to distill it** — no second network round-trip, and no new
  fetch path to maintain alongside `/intake`'s and `/bookmarks`'s existing
  ones.
- **Drift detection is a separate, non-gating `mix` task**, not folded into
  `mix brain.verify`. It needs the network, which fails the
  [admission rule for new guardrails](/meta/policy/elixir-coding-standards.md)'s
  offline requirement outright — the same reasoning that already keeps
  `mix brain.verify`'s docs-freshness warnings advisory rather than gating,
  and the same shape as the deferred
  [`mix brain.staleness`](/meta/todos/build-mix-brain-staleness-when-dated-resources-grow.md)
  todo for dated-revision resources (a close cousin worth reconciling at
  build time — see open question 3).
- **The hash lives beside `resource`, not inside it** — `resource` stays a
  bare URI (its existing contract elsewhere in the bundle, e.g. `verified_by`
  targets, is unaffected); `resource_hash` is a new, independently optional
  sub-map, so every existing document with a bare `resource` and no hash
  stays valid without a backfill.
- **No byte mirroring.** terse-brain copies the full source into a `raw/`
  directory; this bundle already declines that
  ([capture-knowledge-cite-the-source](/meta/policy/capture-knowledge-cite-the-source.md):
  distill the knowledge, cite the source) and a hash needs no accompanying
  copy to detect drift.

## Anchors

- `ElixirMind.Frontmatter` — the parser `resource_hash` would round-trip
  through; confirm it tolerates an unrecognized nested map today (it should,
  per "arbitrary extra keys are allowed and must be preserved") before
  building the field.
- `ElixirMind.Verifier` — no new rule; `resource_hash` presence is optional
  and never gates. If a doc claims `resource_hash` with a malformed shape
  (missing `sha256` or `captured`), that *is* a `mix brain.verify` shape
  error, matching how `attribution`'s shape (not its presence) is enforced.
- Whatever `/intake` and `/bookmarks` already use to fetch a URL — reuse it
  rather than adding a second HTTP path; this is why hashing happens inside
  intake's existing fetch and not as a separate step.

## Decisions and open questions

**Recommended shape:** as above — optional `resource_hash` captured
opportunistically at intake, a separate non-gating report task, no byte
mirroring.

**Alternatives rejected:**

- Mirroring full source bytes (terse-brain's approach) — rejected outright;
  contradicts the standing capture-the-knowledge-cite-the-source filing rule.
- Folding drift detection into `mix brain.verify` as a hard gate — rejected;
  needs the network, which the admission rule for new guardrails excludes
  from any gate.

**Open questions for ratification:**

1. **Opt-in or mandatory at intake?** Mandatory raises `/intake`'s cost on
   every capture (a hash for something never re-checked is waste); opt-in
   risks the same silent-coverage-gap shape flagged in the
   [escape-rate plan](/meta/plans/auto-intake-escape-rate-sampling.md) —
   whichever is chosen, the report must state coverage (how many
   resource-bearing docs carry no hash), not just findings among the hashed.
2. **Re-fetch cadence.** Run on demand only (like `brain.orphans`), or wired
   into a Routine (like `/research`)? A Routine needs the same
   `send_later`/check-in discipline the existing daily-digest issue already
   exposes gaps in.
3. **Reconcile with the staleness todo.** `resource_hash` drift (content
   changed) and dated-revision staleness (a newer spec version exists) are
   different failure modes over the same `resource`-bearing surface;
   decide at build time whether they share one task or stay two.
