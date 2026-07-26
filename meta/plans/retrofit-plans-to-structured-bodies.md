---
type: plan
title: Retrofit active plans (and flow docs) to structured bodies
description: Sweep every active plan through the structured-plan-bodies format — trees, file-tree diffs, signatures, decision lists — with the frontmatter-parser plan as the completed pilot; absorb the tree syntax into flow docs where clearer; defer a warn-only anchor-staleness sweep as a candidate guardrail.
status: accepted
provenance: "Claude Code session (claude-fable-5), 2026-07-26 — commissioned by the operator in the pseudocode-plans session alongside the structured-plan-bodies policy ratification"
tags: [meta, plan, plans, retrofit, program-design, flows, staleness]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T21:51:55Z
  channel: agent-authored
  agent: "Claude Code agent, pseudocode-plans session"
  why: "operator directed a plan to retrofit all existing plans to the newly ratified structured format, executed in fresh contexts as format dogfooding"
---

# Retrofit active plans (and flow docs) to structured bodies

## Problem

The [structured-plan-bodies policy](/meta/policy/structured-plan-bodies.md)
(ratified 2026-07-26) governs how plan shapes are written, but the existing
plan corpus predates it: every active plan describes its shape in prose
paragraphs — exactly the material that is "a decision you'd otherwise be
making implicitly during code review"
([em:6c7e85](/beliefs/plan-artifacts-surface-implicit-review-decisions.md)).
Most active plans are *deferred, cold-handoff* work — the case where exact
shape transfer matters most
([plan-vs-capture](/meta/policy/plan-vs-capture.md)). The
[frontmatter-parser plan](/meta/plans/frontmatter-parser-profile-rewrite.md)
was retrofitted in the ratifying session as the pilot; this plan sweeps the
rest.

## Current state → desired state

```diff
 meta/plans/ (active docs)
-  shape sections: prose paragraphs describing modules, files, and flows
+  shape sections: file-tree diffs, call/flow trees (production + test),
+    signatures, boundary decisions, anchors-last, closing decision list
+  prose unchanged: problem, rationale, alternatives, open questions
 meta/flows/ (all docs)
-  touch-sequences: prose step lists
+  touch-sequences: tree syntax where a tree is clearer; prose where not
+  genre name: "flow" — unchanged (prefer-established-terminology)
```

## Scope and triage

**In scope: active plans only** (`proposed` / `accepted` / `in-progress`).
`done` and `superseded` plans are **excluded**: they are historical decision
records, and rewriting a record's body after the fact falsifies what was
decided against ([fit each layer to its purpose](/meta/doctrine/fit-each-layer-to-its-purpose.md)
— the record layer optimizes for fidelity).

Triage rule per plan: a plan whose subject has structure gets the full artifact
kit; a plan whose subject is prose-shaped (pure vocabulary/policy changes)
gets, at most, a closing decision list — the policy's scope clause, applied.

| Target (active plans at authoring time) | Expected artifacts |
|---|---|
| [derived-index-listings](/meta/plans/derived-index-listings.md) — **named first target** | file-tree diff (`lib/`, task), signatures (`mix brain.index` API), flow tree (derive → compare → check) |
| [reconcile-dangling-ledger-strands](/meta/plans/reconcile-dangling-ledger-strands.md) (`mix brain.strands`) — **named first target** | signatures (scan/report API), flow tree (sweep → disposition), file-tree diff |
| [compile-skills-registry-from-skill-frontmatter](/meta/plans/compile-skills-registry-from-skill-frontmatter.md) | signatures (skills scanner), call tree (contract compose), file-tree diff |
| [decision-extraction-and-compiled-decision-graph](/meta/plans/decision-extraction-and-compiled-decision-graph.md) | flow trees (capture-time mint; materialize), signatures, file-tree diff |
| [thin-jido-brain-host](/meta/plans/thin-jido-brain-host.md) | component/call trees (host anatomy), boundary decisions |
| [library-spin-out-and-dependency-distribution](/meta/plans/library-spin-out-and-dependency-distribution.md) | file-tree diffs (two repos), boundary decisions (config manifest) |
| [inkling-beam-swarm-eval-harness](/meta/plans/inkling-beam-swarm-eval-harness.md) | component trees per rung, boundary decisions |
| [separate-okf-bundle-and-elixir-mind-library](/meta/plans/separate-okf-bundle-and-elixir-mind-library.md) | bundle-tree diff, boundary decisions |
| [epistemic-overlay](/meta/plans/epistemic-overlay.md) | schema signatures (edge types), flow tree (`mix brain.graph`) |
| [belief-decomposition-analysis-mode](/meta/plans/belief-decomposition-analysis-mode.md) | flow tree, signatures |
| [auto-intake-escape-rate-sampling](/meta/plans/auto-intake-escape-rate-sampling.md) | flow tree (git-history oracle), signatures (`mix brain.escape_rate`) |
| [council-skill](/meta/plans/council-skill.md) | skill flow tree (round protocol) |
| [three-level-documentation](/meta/plans/three-level-documentation.md) | schema signature (`implemented_by`), doc-tree sketch |
| [concept-terminology-and-type-redefinition](/meta/plans/concept-terminology-and-type-redefinition.md) | prose-scope: decision list only |
| [transplant-surviving-unmerged-branches](/meta/plans/transplant-surviving-unmerged-branches.md) | prose-scope (near-done): decision list only |
| [glossary-single-overview-and-dedup-check](/meta/plans/glossary-single-overview-and-dedup-check.md) | skip if flipped to `done` first (executed per its index entry) |

*(The [extract-into-belief](/meta/plans/extract-into-belief-skill.md) and
[policy-canonical-skill-guidance](/meta/plans/policy-canonical-skill-guidance.md)
plans were born in the format; the
[frontmatter-parser pilot](/meta/plans/frontmatter-parser-profile-rewrite.md)
is done. Re-derive this table against `meta/plans/index.md` at execution — the
policy's refresh rule applies to this plan too.)*

## Build order

1. **Refresh** (policy refresh rule): re-list active plans; drop any that went
   `done`/`superseded` since authoring; re-triage.
2. **Retrofit per plan**, one commit each ("retrofit <plan> to structured
   body"): add the artifact section (pilot's pattern: a `## The shape,
   structured` section marked as a retrofit, prose untouched), bump
   `timestamp`. Never alter the plan's decisions — a retrofit that surfaces a
   design *question* records it under the plan's open questions instead of
   answering it.
3. **Flow-doc absorption pass** (the operator's Q2, decided in the ratifying
   session): keep the genre name **"flow"**
   ([prefer-established-terminology](/meta/policy/prefer-established-terminology.md)
   — "flow" is the established term; "state-tree" would be the bespoke
   coinage), and rewrite each flow doc's touch-sequence as a tree where the
   prose list obscures branching; leave already-clear prose alone. Amend the
   flows index note if the genre description needs the tree syntax mentioned.
4. **Update** `meta/plans/index.md` blurbs where a retrofit changes what a
   reader should know; run the gate suite.

## Deferred: a warn-only anchor-staleness sweep (`mix brain.anchors`)

The operator's Q3: structured bodies bind plans and flow docs to concrete
paths and names that rot as `main` moves. Candidate guardrail: a `mix
brain.anchors` task that extracts path-shaped refs from tree/diff/signature
blocks in **active** plans and flow docs and **warns** (never fails) on refs
that don't resolve at `HEAD` — the same warn-tier as the routing-ledger
coverage check, because a prospective plan legitimately references paths that
don't exist yet (`# NEW` entries must be excluded, and even `~ MODIFIED` refs
can validly lag). Admission is governed by the
[coding-standards gate rule](/meta/policy/elixir-coding-standards.md): build
it only if, after the retrofit sweep, stale anchors are actually observed to
mislead an executing session — signal before machinery. Until then, the
policy's refresh-at-execution step is the mitigation.

## Decision list

- **Recommended:** execute in a fresh session per the plan-vs-capture
  cold-handoff case; batch several retrofits per PR but one commit per plan.
- **Alternatives rejected:** retrofitting `done`/`superseded` plans (falsifies
  the record); renaming "flow" to "state-tree" (bespoke term displacing an
  established one); building `mix brain.anchors` now (no observed signal yet);
  a hard CI gate diffing plan trees against the implemented codebase
  (prospective artifacts drift by design — near-pure false positives).
- **Open questions:** whether retrofit commits should also normalize older
  plans' section headings to the pilot's (`## The shape, structured`) or leave
  heading style per-plan; whether the flows index genre description needs a
  policy-side mirror.
