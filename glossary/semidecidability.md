---
id: sb:b7760e
type: concept
title: semidecidability
description: The property of a question answerable by an always-terminating procedure only on the "yes" side — first-order entailment can be confirmed by proof search, but no algorithm decides arbitrary non-entailment.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, logic, computability, limits]
timestamp: 2026-07-11
---

# semidecidability

The property of a question for which a mechanical procedure exists that always
(eventually) confirms "yes" instances but may run forever on "no" instances.
First-order [entailment](/glossary/entailment.md) is the canonical case
(Church–Turing): if a sentence does follow, exhaustive proof search will find
a proof; if it doesn't, the absence of a proof so far tells you nothing. The
fundamental ceiling on fully mechanical auditing, and one reason guaranteed
reasoning (OWL profiles, description logics) is always bought by restricting
expressiveness.

*Seen in:* [FOL and OWL reference](/knowledge-management/knowledge-representation/first-order-logic-and-owl.md)
