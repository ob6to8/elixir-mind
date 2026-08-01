---
type: plan
title: "Tag governance: decide what the tags axis is, then keep it consistent"
description: Resolve the never-ratified status of the tags frontmatter field — currently an ungoverned second taxonomy axis whose sprawl erodes intake-dedup recall — by measuring sprawl first (a tags report in the style-fingerprint instrument), normalizing near-duplicate tags mechanically, and deferring the heavier controlled-vocabulary question until trend data exists.
status: accepted
provenance: "Claude Code session (2026-07-27) — operator directed the plan's creation after the scar-tissue analysis decomposed tag sprawl into an epistemic root (ungoverned axis) and a mechanical symptom (tagging-practice inconsistency)"
tags: [meta, plan, tags, taxonomy, governance, dedup, fingerprinting]
timestamp: 2026-08-01
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator dialogue on the code-cleanliness-trust branch"
  why: "operator directed: create tag governance plan — persisting the epistemic question the scar-tissue analysis surfaced but could not settle"
  from: [/meta/analysis/scar-tissue-drift-defenses-and-persistence.md, /meta/threads/2026-07-27-scar-tissue-drift-doctrine-and-link-policy.md]
---

# Tag governance: decide what the tags axis is, then keep it consistent

## Problem

`tags` is the bundle's only ungoverned metadata axis. The contract makes the
directory tree the canonical taxonomy and gates its evolution through
ratification; the `type` field is a controlled vocabulary that grows only by
ratification; but `tags` are free strings, merely "recommended," with no
vocabulary, no gate, and no check. That is an *implicit* decision —
folksonomy by default — that was never actually made.

Two distinct problems hide under "tag sprawl":

1. **The epistemic question** — what is the tags axis *for*, given that the
   tree already carries the taxonomy? Cross-cutting retrieval facets the tree
   cannot express (a `git` doc and an `agentic-loop` doc both tagged
   `reliability`)? Or nothing the tree plus links doesn't already do?
2. **The mechanical symptom** — tagging-practice inconsistency: synonym tags,
   singular/plural variants, per-session idiolects. Live specimens from a
   single 2026-07-27 session: one doc tagged `agentic-ai`, another `agentic`;
   and the `coined` tag, introduced to mark *operator*-coined glossary terms,
   stretched in the same session to a *field*-coined term because no tag has
   defined semantics anywhere.

The sprawl is not cosmetic: `/intake`'s dedup search explicitly includes
tags, so tag idiolects directly erode the entry gate's recall — the same
failure surface the [dedup probe](/meta/evals/dedup-probe.md) measures.

## Options

- **(a) Status quo, measured.** Keep folksonomy; add a tags report
  (distinct-tag count vs. corpus growth, singleton-tag fraction,
  near-duplicate pairs by edit distance/containment) to the proposed
  style-fingerprint instrument. Cheap; converts the implicit decision into an
  explicit, monitored one.
- **(b) Controlled tag vocabulary.** Symmetric with `type`: a ratified list,
  verifier-gated, growing by proposal. Maximal consistency; heavy — every
  intake needs the list in context, and the list becomes a second taxonomy to
  govern (the exact burden the tree already carries).
- **(c) Mechanical normalization.** An alias map (e.g. `agentic-ai →
  agentic`) applied at write time or checked by the verifier as a warn;
  near-duplicate detection in the tags report. Kills the symptom without
  deciding the epistemic question.
- **(d) Retire tags.** Tree + links + full-text search carry retrieval;
  delete the axis. Rejected as an opener: tags are searched by dedup today,
  and cross-cutting facets have no other home — retiring them is a decision
  the trend data should inform, not precede.

## Recommendation

**(a) + (c), in that order; defer (b); hold (d) as a falsifiable outcome.**
Measure first — the tags report rides the style-fingerprint instrument
(itself a proposed rider on the
[escape-rate plan](/meta/plans/auto-intake-escape-rate-sampling.md)) — then
normalize the near-duplicates the report surfaces. If the trend shows sprawl
recurring faster than normalization absorbs it, that is the evidence that
either (b) or (d) is warranted, and *which one* depends on whether the report
shows tags doing real retrieval work (many multi-directory tag facets → (b))
or none (singleton tags dominating → (d)).

## Build order

1. **Ratify the direction** (operator): the (a)+(c) sequence and the
   defer/hold dispositions above.
2. **Tags report** — lands with the style-fingerprint instrument (or as a
   standalone `mix brain.tags` if the fingerprint stalls): distinct-tag
   growth, singleton fraction, near-duplicate pairs, per-tag document counts.
   Committed baseline, warn-never-fail, dedup-probe pattern.
3. **Normalization pass** — adjudicate the surfaced near-duplicates into an
   alias map; apply as a one-time sweep; verifier warns on future alias hits.
4. **Revisit** — with two or more baselines of trend data, decide (b)/(d) or
   close as governed-folksonomy.

**Ratified 2026-07-27** — the operator accepted the recommendation as written
(the (a)+(c) sequence; (b) deferred, (d) held). The open questions below were
not individually answered and carry to execution.

## Refinement — the epistemic question answered (ratified 2026-08-01)

The 2026-08-01 schema-formalization dialogue settled problem 1 directly:
**tags are cross-cutting facets, disjoint from the path; the flat search
index is derived, not stored.**

- **Storage: facets only.** A stored tag never duplicates a segment of the
  doc's own path — the path already carries that fact canonically, and a
  stored duplicate is denormalization that drifts on every file move. A
  tier-2 lint (per the
  [schema-formalization plan](/meta/plans/schema-formalization-and-evaluator-lane.md))
  errors on `tag ∈ own-path-segments`. Worked example: `em:712e01` at
  `knowledge/SWE/agentic/supervision/` tags both `supervision` and `agentic`
  (path duplicates — drop under the lint) alongside `compliance`, `audit`,
  `observability` (true facets — keep).
- **Query: union with the path, label the basis.** A tag query unions stored
  tags with path segments at query time, so flat search still finds every
  doc under `supervision/` without storing the tag. Each hit is labeled
  `[path]` (canonically filed here) or `[tag]` (touches the facet from
  elsewhere) — the two matches mean different things and the result surface
  keeps the distinction. The disjointness lint is what keeps the labels
  trustworthy. The implicit union excludes namespace roots shared by
  effectively every document (`knowledge`): a tag the whole bundle matches
  retrieves nothing.
- **Consequence for the build order:** `mix brain.tags` (step 2) gains a
  query mode beside the report — same scan, two outputs — and the
  normalization pass (step 3) gets a mechanical head start: every
  path-duplicate tag surfaced by the lint is an adjudication-free removal.

This narrows, rather than reopens, the deferred (b)/(d) decision: with path
duplicates removed and queries unioning the tree, the trend data measures
only true facet usage — a cleaner signal for whichever way that call goes.

## Open questions (carried to execution)

- Should tag *semantics* be documented anywhere short of a controlled
  vocabulary — e.g. a conventions note defining the handful of load-bearing
  tags (`coined`, `glossary`, `meta`) — or is that (b) by the back door?
- Does the alias map live in config (code) or in a governance doc the
  verifier reads?
- Are glossary-entry tags (`glossary`, domain markers) in scope, or does the
  glossary's own machinery exempt it?
