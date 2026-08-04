---
type: matter
title: "Union-safe attribution.from lists"
description: Make governance from lists block-style YAML (one entry per line) so parallel sessions appending different threads produce line insertions the union merge driver resolves — parser support confirmed or extended first, the resource-attribution policy's inline-list wording amended and the contract recompiled, the existing from-carrying docs reformatted in one sweep, and meta/evals/dedup-probe.md added to the union entries with its generated baseline self-healing via mix brain.regen.
status: open
model: Claude Fable 5
provenance: "Claude Fable 5, /scope-unit-of-work session"
tags: [meta, matter, git, merge, attribution, frontmatter, gold-set]
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T04:50:00Z
  channel: agent-authored
  agent: "Claude Code agent, /scope-unit-of-work"
  why: "the operator asked which of the session's residual conflict surfaces recur and directed the fix be queued at the head of the register"
---

# Union-safe attribution.from lists

The one *recurring* merge-conflict magnet left after
[the rebuild-on-merge fix](/meta/issues/generated-artifact-merge-conflicts.md):
every `/intake` session appends both a gold row and an entry to
[`meta/evals/dedup-probe.md`](/meta/evals/dedup-probe.md)'s **one-line**
`attribution.from` list, so two parallel sessions collide as a same-line edit —
the shape the `union` driver would corrupt into a duplicated YAML key, which is
why that file was excluded from the driver rollout. Block-style lists turn
those collisions into line insertions, which union merges cleanly.

Delivery order inside the one intent:

1. **Parser first.** Confirm the hand-written frontmatter parser accepts
   block-style YAML lists for `from` (and `verified_by`, if trivially shared);
   extend it with tests if not. Nothing else lands until this is green.
2. **Policy wording.** Amend
   [resource-attribution](/meta/policy/resource-attribution.md)'s "Inline YAML
   list" phrasing for `from` to block-style (one bundle-absolute path per
   line), state the merge rationale in one clause, and `/render-contract`.
3. **Reformat sweep.** Convert every doc carrying `from` in one mechanical
   pass; `mix brain.verify` gates ref resolution throughout.
4. **`.gitattributes`.** Add `meta/evals/dedup-probe.md merge=union`, noting
   that its generated `## Baseline` may union-duplicate on merge and is
   re-derived by `mix brain.regen` — the same self-healing contract as the
   regen-class artifacts. The matter register stays manual: its row order is
   semantic.

## Model

The contract-facing schema wording is the anchoring motion — policies stay at
Fable however small the edit; the parser extension and sweep beneath it are
suite-gated.
