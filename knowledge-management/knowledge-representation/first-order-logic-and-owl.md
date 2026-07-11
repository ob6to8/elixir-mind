---
id: sb:8255b8
type: reference
title: "FOL and OWL: fully formal knowledge representation"
description: First-order logic and the W3C Web Ontology Language (OWL 2) — the fully formal end of the knowledge-representation spectrum, with provable semantics, decidability trade-offs, and the authoring cost that motivates semiformal middle layers.
resource: https://www.w3.org/TR/owl2-overview/
provenance: "Distilled from the Wikipedia article on first-order logic and the W3C OWL 2 overview, fetched 2026-07-11"
tags: [knowledge-representation, logic, first-order-logic, owl, description-logic, ontology, semantic-web, formal-methods]
timestamp: 2026-07-11
---

# FOL and OWL: fully formal knowledge representation

The fully formal end of the knowledge-representation spectrum: languages whose
statements have machine-checkable, model-theoretic meaning, so entailment is a
theorem rather than a judgment call.

## First-order logic (FOL)

FOL extends propositional logic with **predicates** and **quantified
variables** (∀, ∃) — "for all x, if x is a human, x is mortal" instead of
opaque propositions. Its properties frame every downstream KR trade-off:

- **Sound and complete** — Gödel's 1929 completeness theorem: a formula is
  derivable iff it is logically valid, making FOL mathematically robust enough
  to axiomatize arithmetic (Peano) and set theory (ZFC).
- **But only semidecidable** — by Church–Turing, no algorithm decides whether
  an arbitrary formula follows from another. Full expressiveness costs
  guaranteed termination.

## OWL 2 (Web Ontology Language)

The W3C's ontology language for the semantic web (Recommendation 2009, second
edition 2012): classes, properties, individuals, and data values, exchanged as
RDF. Its **Direct Semantics** aligns with the **SROIQ description logic** — a
decidable FOL fragment — so decades of DL reasoning research apply directly.
Three profiles trade expressiveness for tractability guarantees: **EL**
(polynomial-time reasoning, very large ontologies), **QL** (query answering
over relational databases), **RL** (rule engines over RDF triples).

## Why it is in this brain

FOL/OWL mark the *fully formal* pole against which a semiformal epistemic
substrate defines itself. They demonstrate both what full formalization buys
(provable entailment, mechanical consistency checks — e.g. detecting a
[minimal inconsistent subset](/glossary/minimal-inconsistent-subset.md) is
well-defined) and what it costs: ontology authoring is expensive, and real
prose resists complete formalization — the brittleness that motivates keeping
beliefs in natural language with an LLM as the local entailment oracle. See
the [belief-decomposition analysis](/meta/analysis/belief-decomposition-derived-vs-authored.md).

# Citations

- First-order logic — Wikipedia: <https://en.wikipedia.org/wiki/First-order_logic>
- OWL 2 Web Ontology Language Document Overview (Second Edition) — W3C:
  <https://www.w3.org/TR/owl2-overview/>
