---
id: sb:401ff6
type: reference
title: Truth maintenance systems (TMS / RMS)
description: Classic-AI knowledge-representation machinery (Doyle's JTMS, de Kleer's ATMS) that tracks beliefs together with the justifications that support them, revising belief when premises change — the original bipartite belief/justification dependency graph.
resource: https://en.wikipedia.org/wiki/Reason_maintenance
provenance: "Distilled from the Wikipedia article on reason maintenance, fetched 2026-07-11"
tags: [knowledge-representation, epistemics, truth-maintenance, belief-revision, classic-ai, dependency-graph]
timestamp: 2026-07-11
---

# Truth maintenance systems (TMS / RMS)

A **truth maintenance system** (also *reason maintenance system*) is knowledge-base
machinery that records not just what is currently believed but **why** — every
belief is linked to the justifications that support it, so when a premise is
retracted or contradicted the system can revise exactly the dependent beliefs
instead of recomputing from scratch.

## Core model

- **Dependency network.** Nodes are knowledge-base entries (beliefs); arcs are
  inference steps. The structure is effectively a
  [bipartite graph](/glossary/bipartite-graph.md) of belief nodes and
  *justification* nodes: a justification bundles the premises that jointly
  license a conclusion, and the same conclusion may carry several independent
  justifications.
- **Premises vs. derived beliefs.** Premises are fundamental, unjustified
  beliefs; everything else derives from them through justifications. Base facts
  can be *defeated* — a key departure from monotonic logic.
- **Dependency-directed backtracking.** When a contradiction arises, the system
  walks the dependency network to find the offending assumptions, rather than
  blindly undoing recent steps. This is also what makes the
  [blast radius of a retracted premise](/glossary/blast-radius.md) computable:
  the set of dependents reachable from the retraction.

## History

- **1978–1979 — Jon Doyle** develops the justification-based TMS (JTMS) and
  publishes "A Truth Maintenance System" in *Artificial Intelligence* (1979).
- **1986 — Johan de Kleer** introduces the **assumption-based TMS (ATMS)**,
  widely used in KEE systems on Lisp machines. The ATMS labels each belief with
  the *assumption environments* (sets of assumptions) under which it holds,
  enabling **multi-context reasoning**: several mutually inconsistent contexts
  can coexist, each internally consistent — a form of paraconsistency.

## Why it is in this brain

The TMS is the closest classic-AI ancestor of the epistemic-substrate idea this
brain is exploring: an
[epistemic overlay](/glossary/epistemic-overlay.md) of atomic beliefs and
justification edges over artifacts, audited mechanically. The ATMS environment
concept in particular answers how to compare two internally-coherent but
mutually-contradictory documents without merging them into one inconsistent
store. See the
[belief-decomposition analysis](/meta/analysis/belief-decomposition-derived-vs-authored.md)
and the [derived analysis-mode plan](/meta/plans/belief-decomposition-analysis-mode.md).

# Citations

Reason maintenance — Wikipedia:
<https://en.wikipedia.org/wiki/Reason_maintenance>
