---
id: em:d845c0
type: concept
title: open world assumption (OWA)
description: The semantic stance that unstated facts are unknown rather than false — so absence of evidence licenses no negative conclusion, in contrast to the closed world assumption databases and constraint languages adopt.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, knowledge-representation, logic, owl, semantics]
sense: common
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T08:30:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-28 ontology-guardrails thread as a load-bearing reason OWL cannot express a once-only constraint"
---

# open world assumption (OWA)

[OWL](/beliefs/glossary/owl.md) and RDF adopt it: a knowledge graph is a partial
description of a world that extends beyond it, so failing to find a triple means
only that the graph does not record it. Its opposite — the **closed world
assumption** — treats the store as complete, which is why a database answers
"no such row" as a fact and why a constraint language like
[SHACL](/beliefs/glossary/shacl.md) can report a violation at all.

The distinction is operationally decisive for agent guardrails: any check of the
form *has this already happened* is a closed-world question. Under OWA a
reasoner will never conclude that an order has not yet been refunded merely
because no refund is asserted, so the constraint has to live in a closed-world
layer rather than in the ontology (see the
[ontology-guardrails analysis](/meta/analysis/ontology-guardrails-vs-schema-validation.md)).

*Seen in:* [ontology guardrails vs. schema validation](/meta/analysis/ontology-guardrails-vs-schema-validation.md), [FOL and OWL reference](/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md)
