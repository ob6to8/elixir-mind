---
id: sb:2b6117
type: concept
title: soundness and completeness
description: The paired correctness properties of a proof system — sound: everything derivable is valid; complete: everything valid is derivable. Gödel (1929) proved first-order logic has both, aligning syntax with semantics.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, logic, proof-theory, metatheory]
timestamp: 2026-07-11
---

# soundness and completeness

The paired correctness properties of a deductive system relative to a
semantics: **sound** — everything derivable is semantically valid (the system
proves no falsehoods); **complete** — everything semantically valid is
derivable (no truth is out of reach). Gödel's 1929 completeness theorem
established both for first-order logic, making syntactic derivation and
semantic [entailment](/glossary/entailment.md) coincide. The same vocabulary
recurs wherever a mechanical procedure answers for a semantic notion — e.g. an
ATMS [label](/glossary/label-atms.md) is required to be sound *and* complete
with respect to derivability from environments.

*Seen in:* [FOL and OWL reference](/knowledge-management/knowledge-representation/first-order-logic-and-owl.md), [de Kleer 1986 capture](/knowledge-management/knowledge-representation/de-kleer-1986-an-assumption-based-tms.md)
