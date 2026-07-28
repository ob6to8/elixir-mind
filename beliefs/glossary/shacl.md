---
id: em:4d3462
type: concept
title: SHACL (Shapes Constraint Language)
description: The W3C language (Recommendation 2017) for validating RDF graphs against declared shapes — closed-world constraint checking that reports violations, as distinct from OWL's open-world inference.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, knowledge-representation, rdf, shacl, validation, semantic-web]
sense: common
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T08:30:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-28 ontology-guardrails thread as the formalism that encodes the constraints OWL cannot"
---

# SHACL (Shapes Constraint Language)

A *shape* names a target set of nodes in an RDF graph and the conditions their
properties must meet — cardinality (`sh:minCount`/`sh:maxCount`), datatypes,
value ranges, permitted classes — and validation returns a report of violations
rather than a set of entailments.

The contrast with [OWL](/beliefs/glossary/owl.md) is the point, and the two are
routinely confused because both describe RDF vocabularies. OWL is an inference
logic under the [open world assumption](/beliefs/glossary/open-world-assumption.md):
it derives what must also be true, and a "functional" property yields an identity
inference rather than an error. SHACL is a validator under a closed-world reading
of the data graph: it reports what is missing or excessive. For agent guardrails
this makes SHACL the formalism that expresses the common invariants — at most one
refund per order, a required field, a bounded value set — that an ontology alone
cannot enforce (see the
[ontology-guardrails analysis](/meta/analysis/ontology-guardrails-vs-schema-validation.md)).

*Seen in:* [ontology guardrails vs. schema validation](/meta/analysis/ontology-guardrails-vs-schema-validation.md)
