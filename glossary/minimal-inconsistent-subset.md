---
id: sb:577155
type: concept
title: minimal inconsistent subset
description: A set of beliefs that is jointly contradictory while every proper subset is consistent — the smallest witness that localizes a conflict, analogous to a minimal unsatisfiable core in SAT solving.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, epistemics, consistency, conflict, logic]
timestamp: 2026-07-11
---

# minimal inconsistent subset

A set of beliefs that is jointly contradictory while every proper subset is
consistent: remove any one member and the contradiction disappears. Computing
these localizes a conflict to its smallest witness — instead of "these two
documents disagree," the audit names the exact beliefs that cannot all stand
together. The notion is borrowed from minimal unsatisfiable subsets (MUS /
unsat cores) in SAT solving, where it is well-defined precisely because the
underlying language is [fully formal](/knowledge-management/knowledge-representation/first-order-logic-and-owl.md);
in a semiformal belief graph the membership judgments are LLM-local but the
minimization itself stays mechanical.

*Seen in:* [FOL and OWL](/knowledge-management/knowledge-representation/first-order-logic-and-owl.md), [belief-decomposition analysis](/meta/analysis/belief-decomposition-derived-vs-authored.md)
