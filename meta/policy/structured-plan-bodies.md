---
type: policy
title: Structured plan bodies
description: A plan encodes the shape of its change as structured artifacts — trees, file-tree diffs, and signatures — and keeps prose for the problem, rationale, alternatives, and open questions; artifacts stay at outline level, never code level.
section: filing
order: 8
status: active
tags: [meta, governance, plans, program-design, pseudocode, planning]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T21:51:55Z
  channel: agent-authored
  agent: "Claude Code agent, pseudocode-plans session"
  why: "operator ratified adopting the structured plan-body format after reviewing the wsff.md program-design method and the Mulroy/Horthy/Jain posts on pseudocode plans"
---
**Encode a plan's shape as structured artifacts; keep prose for the why.** When
a plan's subject has structure — code, a skill's control flow, the bundle tree,
a frontmatter schema — the *shape of the change* is written as compact
structured artifacts, not described in paragraphs. Prose still carries the
problem, the rationale, the alternatives weighed, and the open questions
(unchanged from [persist-plans](/meta/policy/persist-plans.md)); the artifacts
carry the shape. Rationale, held as beliefs: each artifact
"is a decision you'd otherwise be making implicitly during code review — at the
most expensive possible time to change your mind"
([em:6c7e85](/beliefs/plan-artifacts-surface-implicit-review-decisions.md),
quoting [wsff.md](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/wsff.md)),
and the artifacts "compress the *decisions* (interfaces, layout, call order)
while leaving function bodies to the agent"
([em:a96688](/beliefs/plan-artifacts-compress-decisions-not-bodies.md)).

**The artifact kit** — use what the change calls for, in this order:

1. **Current-state tree, then desired-state tree** — the flow or structure as it
   is, then as it should be (behavior → layer → anchor per level). Equivalent
   encoding: one tree in `diff` syntax (`+`/`-`/`~` lines) when the delta is
   small. For changes to an existing flow, the flow doc under
   [`meta/flows/`](/meta/flows/index.md) *is* the current-state record — cite
   it instead of restating it.
2. **File-tree diff** — where new and modified files live (`# NEW` / `# MODIFIED`
   annotations with a one-clause purpose each).
3. **Call/flow trees** — for control-flow changes, the production topology *and*
   the test topology (which seams are substituted under test), separately.
4. **Signatures** — types and specs for the key new functions; in the Elixir
   tooling, literal `@spec` lines per the
   [coding standards](/meta/policy/elixir-coding-standards.md).
5. **Boundary decisions** — one bullet per layered responsibility: which layer
   detects the condition, owns side effects, persists state.
6. **Anchors last** — concrete file paths, function names, abstractions to
   reuse, and the tests that should cover the flow are attached *after* the
   trees, never before, so the plan is anchored to intended behavior rather
   than incidental existing code.
7. **Decision list** — recommended shape, alternatives rejected, open questions
   and assumptions. This closes every structured plan.

**The granularity bound.** Artifacts stay at signature/tree/outline level —
interfaces, layout, call order — and stop there, because "a spec that is
sufficiently detailed to generate code with a reliable degree of quality is
roughly the same length and detail as the code itself"
([em:1eebdf](/beliefs/spec-detail-approaches-code-length.md), quoting
[Dex Horthy](https://x.com/dexhorthy/status/2033980486813684181)) — and such a
spec gets no separate review pass
([em:0c4913](/beliefs/dont-review-code-length-specs.md)). A plan whose
pseudocode has crept to code granularity is over-specified, not thorough.

**The refresh rule.** A structured plan binds to concrete names, so a deferred
plan's anchors can go stale as `main` moves. Executing any structured plan
therefore begins with a **refresh step**: re-derive the current-state tree
against `HEAD`, diff it against the plan's, and update anchors before building.
Anchors-last (item 6) is what keeps this step cheap — the stale layer is
segregated, not woven through the prose.

**Scope.** Applies to plans whose subject has structure; a plan for a pure
policy or doctrine change may be all prose (its "shape" is the rule text
itself). Retrofit of pre-existing plans is governed by the
[retrofit plan](/meta/plans/retrofit-plans-to-structured-bodies.md), not
demanded by this policy.
