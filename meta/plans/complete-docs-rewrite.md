---
type: plan
title: "Complete docs rewrite: the reader-facing surfaces"
description: A wholesale rewrite pass over the reader-facing documentation — README, tutorials, flow docs, index glosses, and the root index — read and rewritten whole rather than patched per finding, sequenced after the decision-queue rulings and contract-synchronization sweep land, and absorbing or explicitly deferring to the bundle/library separation plan's doc-first phase.
status: proposed
provenance: "Claude Fable 5, Claude Code session"
tags: [meta, plan, documentation, rewrite, reader-facing]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T19:43:00Z
  channel: agent-authored
  agent: "Claude Code agent, decision-queue session"
  why: "operator-commissioned during the decision-queue session: a wholesale reader-facing docs pass, kept distinct from the review program's corrective sweeps, filed with its sequencing ratified up front"
---

# Complete docs rewrite: the reader-facing surfaces

## Problem

The reader-facing documentation accreted change-by-change across the repo's
eras; no pass has ever read it *whole*. The comprehensive review's corrective
work — the staleness sweep (tooling review findings 8–13) and the
contract-synchronization sweep (epistemology review §2–3) — fixes point
defects where prose contradicts the machine. It does not make the surfaces
read as one coherent, current account of the system. That is a different kind
of work: read each surface end to end as its intended reader would, and
rewrite for coherence, currency, and register — not patch the lines a finding
names.

## Scope

**In scope — the reader-facing surfaces** (inventory at 2026-08-01):

| Surface | What it is |
|---|---|
| `README.md` | the repo's front door |
| `meta/tutorials/` (16 docs) | the durable explainers |
| `meta/flows/` (10 docs) | the canonical-run touch sequences |
| Index glosses | the one-line listing descriptions in every `index.md` |
| `/index.md` | the bundle root — the taxonomy's front door |

**Explicitly not absorbed** — the review program's corrective sweeps stay
where they are, and this plan does not restate them:

- The staleness sweep (tooling review findings 8–13) — landed with the fix
  thread (PR #223).
- The contract-synchronization sweep
  ([epistemology review §2–3](/meta/analysis/epistemology-and-governance-review.md))
  — matter 1 of the
  [decision-queue matter sequence](/meta/plans/decision-queue-matter-sequence.md).

## Ratified sequencing (operator, 2026-08-01)

1. **Runs only after the decision-queue rulings and the
   contract-synchronization sweep land** — since 2026-08-02, matters 1–5 of
   the [decision-queue matter sequence](/meta/plans/decision-queue-matter-sequence.md).
   Rewriting against rules that are about to change does the work twice.
2. **One artifact per matter with the separation plan.** The
   [bundle/library separation plan](/meta/plans/separate-okf-bundle-and-elixir-mind-library.md)
   owns a doc-first phase 1: the README / `meta/preamble.md` / root-index
   reframing around the two-concerns boundary. This rewrite **absorbs that
   phase or explicitly defers to it** — the boundary reframing is decided in
   one place, not restated here as new work.

## Open questions (the operator's, at acceptance)

1. Is **policy prose beyond the synchronization sweep** in scope — a
   register/coherence pass over `meta/policy/` bodies — or do policies stay
   ruling-scoped, touched only by their own ratifications?
2. Is the **site chrome** in scope — the shell `mix brain.site` renders
   around documents on the Pages site — or is this pass markdown-only?

## Decision list

- **Recommended shape**: one read-and-rewrite session per surface class
  (README + root index; tutorials; flows; glosses), each ending in a
  reviewable PR — bounded diffs over one mega-pass.
- **Alternatives rejected**: folding this into the review program's
  corrective sweeps (sweeps fix named findings; this rereads surfaces whole);
  running before the queue and sweep land (ratified against, above).
- **Open**: the two scope questions above; whether the flow docs' scenario
  tests are re-read alongside their docs (they are the flows' oracles).
