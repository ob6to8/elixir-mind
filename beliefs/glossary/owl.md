---
id: em:410879
type: concept
title: OWL (Web Ontology Language)
description: The W3C standard for publishing ontologies on the web (OWL 2, 2009/2012) — description-logic semantics (SROIQ), RDF exchange, and the EL/QL/RL profiles trading expressiveness for guaranteed-fast reasoning.
provenance: "Agent-distilled glossary definition, pointer to the defining doc"
verified: false
tags: [glossary, knowledge-representation, owl, ontology, semantic-web]
sense: common
timestamp: 2026-07-11
attribution:
  when: 2026-07-11T20:14:11+00:00
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "extracted in the glossary run over the eight epistemic prior-art docs"
---

# OWL (Web Ontology Language)

The W3C standard language for publishing
[ontologies](/beliefs/glossary/ontology.md) on the web (OWL 2: Recommendation 2009,
second edition 2012): classes, properties, individuals, and axioms exchanged
as RDF, with a [description-logic](/beliefs/glossary/description-logic.md) Direct
Semantics (SROIQ) for the decidable OWL 2 DL species and an unrestricted
RDF-Based Semantics for OWL 2 Full, plus the EL/QL/RL profiles trading
expressiveness for complexity guarantees. Canonically covered in
[FOL and OWL: fully formal knowledge representation](/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md).

*Seen in:* [FOL and OWL reference](/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:410879">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-owl-rdf-skos-and-the-belief-layer (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:410879`]**

**The mismatch, in three parts**

**1. OWL reasons about categories; a belief layer reasons about claims.** Look at what the lecture's construct table actually offers: `intersectionOf`, `allValuesFrom`, `minCardinality`, `disjointWith` — vocabulary for carving up a *domain of individuals* into classes and checking subsumption ("is every Man a Human?"). A belief like [`em:2ecdd2` "review is not an oracle"](https://ob6to8.github.io/elixir-mind/beliefs/review-is-not-an-oracle.html) is a proposition, not a class. To get any leverage from a DL reasoner you'd have to formalize the *content* of each belief into class axioms — which is exactly the authoring cost your own [FOL/OWL reference](https://ob6to8.github.io/elixir-mind/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.html) flags: "real prose does not compile into either." The questions the [analysis-mode plan](https://ob6to8.github.io/elixir-mind/meta/plans/belief-decomposition-analysis-mode.html) wants answered — does this span assert this? do these premises license this conclusion? can these both hold? — are entailment judgments over natural language. The plan already assigns those to per-edge LLM calls, with *pure graph algorithms* doing the mechanical audit on top. A DL reasoner slots into neither half.

**2. Monotonic vs. defeasible.** OWL is monotonic: adding axioms never retracts conclusions, and a contradiction makes the whole ontology inconsistent — at which point everything is trivially entailed and the reasoner's answers become useless. But the belief layer's *entire point* is to represent retractable priors and live conflicts: the plan explicitly makes conflict "a separate symmetric relation, allowed to be cyclic, **resolved by semantics rather than prohibited by construction**." That is verbatim the shape of nonmonotonic formalisms — [TMS/ATMS](https://ob6to8.github.io/elixir-mind/knowledge/knowledge-management/knowledge-representation/truth-maintenance-systems.html) (the plan even says "the artifact is its ATMS-style assumption environment") and [Dung argumentation semantics](https://ob6to8.github.io/elixir-mind/beliefs/glossary/argumentation-framework.html), which compute *which sets of conflicting arguments can rationally stand together*. OWL refuses the very state these formalisms are built to manage.

**3. Open world vs. closed world.** "Find every ungrounded inference" is a closed-world query — absence of support must register as failure. OWL's open-world assumption says absence of an axiom means *unknown*, not *absent*. As with the gate suite, the semantic-web tool that matches is SHACL, not OWL.
