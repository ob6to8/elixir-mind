---
type: plan
title: "A /extract-into-belief skill: decompose compound statements into atomic beliefs"
description: Build a skill that takes a compound synthesized statement, decomposes it into atomic single-predicate beliefs ratified in chat, and files each as a type belief doc under /beliefs/ with verbatim quotation and provenance tracing back to the artifact it was extracted from.
status: accepted
provenance: "Claude Code session (claude-fable-5), 2026-07-26 — commissioned by the operator in the pseudocode-plans session, with the decomposition worked example supplied verbatim by the operator"
tags: [meta, plan, skills, beliefs, extraction, provenance]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T21:51:55Z
  channel: agent-authored
  agent: "Claude Code agent, pseudocode-plans session"
  why: "operator commissioned the skill and directed authoring it as a structured plan for fresh-context execution, dogfooding the structured-plan-bodies format"
---

# A /extract-into-belief skill: decompose compound statements into atomic beliefs

## Problem

The belief layer (ratified 2026-07-26, see the
[belief-layer plan](/meta/plans/belief-type-and-beliefs-namespace.md)) stores
operator-held decision priors as `type: belief` docs under
[`/beliefs/`](/beliefs/index.md). But the statements worth holding usually
arrive *compound* — a delivered response or source passage packing several
predicates into one sentence. Filed whole, a compound belief can't be cited,
depended on (`depends_on`), or deduplicated at the granularity reasoning
actually uses. The layer's seed beliefs were decomposed by hand; this skill
makes the motion repeatable.

## The worked example (operator-supplied, verbatim)

The operator specified the transformation with this example. Input, a compound
statement from a delivered response:

> "Prose transfers intent but leaves the shape to be re-derived; a signature
> block and file-tree diff transfer the shape exactly, collapsing the fresh
> agent's degrees of freedom where they matter (interfaces, layout, call order)
> while leaving implementation freedom where it's cheap."

Output, the atomic decomposition:

> "Prose transfers intent"
> "Prose leaves the shape to be re-derived"
> "a signature block transfers the shape exactly"
> "a file-tree diff transfers the shape exactly"
> "a signature block collapses the fresh agent's degrees of freedom where they matter" (example prop: interfaces, layout, call order)
> "a file-tree collapses the fresh agent's degrees of freedom where they matter" (example prop: interfaces, layout, call order)
> "a signature block leaves implementation freedom where it's cheap"
> "a file tree leaves implementation freedom where it's cheap"

— "tracing provenance back to the artifact it was extracted from."

The example fixes the granularity rule: **one subject, one predicate** per
belief; a conjunction of subjects ("a signature block and file-tree diff")
fans out into one belief per subject; parenthetical enumerations are kept as
**example props**, not promoted to their own beliefs.

## The skill's flow

```
/extract-into-belief <statement | doc-path + quoted passage>
├── Locate the source artifact and lift the target statement verbatim
│     (quote-primary-sources policy: the quote is reproduced exactly, cited)
├── Decompose → candidate atomic beliefs
│     one subject + one predicate each; conjunctions fan out;
│     parentheticals become "(example prop: …)" annotations
├── Present the decomposition in chat for operator ratification
│     (inline chat, never the dialog box — session-capture policy;
│      operator edits/drops/merges candidates before filing)
├── Dedup each survivor against /beliefs/ and the glossary
│     (update-in-place: merge into an existing belief over near-duplicating it)
├── File each as type: belief under /beliefs/
│     ├── body: the atomic statement + the verbatim source quote + citation
│     ├── provenance: the source artifact (doc path, URL, or session thread)
│     └── depends_on: [em:…] where one belief presupposes a sibling
└── Close the spine: update /beliefs/index.md,
      mix brain.id → mix brain.registry → mix brain.verify
```

**Test topology:** the spine (id → registry → verify) is already pinned by the
intake scenario test; the skill adds no code, so no new suite — the
decomposition and ratification steps are judgment-layer, exercised editorially.

## File-tree diff

```diff
 .claude/skills
+└── extract-into-belief
+    └── SKILL.md            # NEW — the procedure above
 meta/policy
~└── skills-registry.md      # MODIFIED — register the skill (until the
                             #   compile-skills-registry plan inverts this)
 CLAUDE.md                   # REGENERATED — mix brain.contract
```

## Boundary decisions

- **The skill decomposes and files; the operator ratifies.** Every candidate
  belief passes through inline chat before filing — beliefs are
  *operator-held* priors, so agent extraction without ratification would put
  words in the operator's mouth.
- **Provenance always names the extraction source.** A statement from a bundle
  doc cites its path; an external passage cites its URL; a statement
  synthesized in-session cites the session (thread doc once captured, route
  tags binding the passages). The verbatim quote travels in the body per
  [quote-primary-sources](/meta/policy/quote-primary-sources.md).
- **Dependency edges are frontmatter (`depends_on`), prose-mirrored.** An
  inline id list, exactly like the seed pair
  ([em:0c4913](/beliefs/dont-review-code-length-specs.md) →
  [em:1eebdf](/beliefs/spec-detail-approaches-code-length.md)). Unvalidated by
  the verifier today; graduates to a checked typed edge when the
  [epistemic overlay](/meta/plans/epistemic-overlay.md) lands.

## Decision list

- **Recommended:** build as specified; pilot on the operator's worked example
  above (filing its eight beliefs is the acceptance test).
- **Alternatives rejected:** filing compound beliefs whole (loses citability
  and dedup granularity — the problem statement); auto-filing without
  ratification (beliefs are operator-held); a `mix brain.beliefs` code path
  (no deterministic spine beyond what id/registry/verify already give).
- **Open questions:** should the skill also *retire* a compound belief when
  its atoms supersede it (`status`-like lifecycle on beliefs is undefined);
  how aggressively to dedup near-synonymous priors (merge vs. `depends_on`).
