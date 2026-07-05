---
type: policy
title: Verification grounding
description: Provenance is immutable history; verified flips only when a concept is grounded by a resource or by verified_by edges to verified source excerpts, and verification prose is derived, never committed.
section: verification
order: 2
status: active
tags: [meta, governance, verification, provenance, evidence]
timestamp: 2026-07-05
---
- **Provenance and verification are orthogonal.** `provenance` records where a
  statement came from and is **immutable history** — verifying a claim never
  rewrites its provenance.
- **`verified: true` requires grounding.** A concept may be marked verified only when
  it has a `resource` (it *is* primary evidence — e.g. a verbatim excerpt of an
  official document) or a non-empty `verified_by` (derived evidence). Ungrounded
  "verified" is a defect; `mix brain.verify` enforces this.
- **Evidence edges live in `verified_by` only** — an inline list of stable ids whose
  targets must exist and be themselves `verified: true`. Do not duplicate the edge
  list in prose: the verification narrative is **derived on demand**
  (`mix brain.evidence <id>`), never committed, so there is exactly one source of
  truth for what supports a concept.
- **Verify technical claims from primary sources.** Extract the supporting passages
  from authoritative documentation into `type: source` concepts (verbatim quotes;
  `resource` = the official URL; provenance = extracted from that resource), then
  aggregate them via `verified_by` on the claim. A `claim` that becomes grounded
  this way may graduate to `concept`.
