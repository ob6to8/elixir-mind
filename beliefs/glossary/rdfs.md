---
id: em:cf2db9
type: concept
title: RDFS (RDF Schema)
description: The lightweight W3C vocabulary layer over RDF supplying classes, subclass/subproperty hierarchies, and property domain/range — enough to derive types that were never asserted, well below OWL's expressiveness.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, knowledge-representation, rdf, rdfs, semantic-web, inference]
sense: common
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T08:30:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-28 ontology-guardrails thread and its source talk"
---

# RDFS (RDF Schema)

Its working parts are few: `rdfs:Class` and `rdf:type` for membership,
`rdfs:subClassOf` and `rdfs:subPropertyOf` for hierarchy, and `rdfs:domain` and
`rdfs:range` for the classes a property's subject and object belong to.

Those last two do the characteristic work — they are **inference** rules, not
type checks. Declaring `teaches` to have domain `Teacher` and range `Student`
means that asserting "Bob teaches Scooter" *derives* that Bob is a Teacher and
Scooter a Student; it never rejects the statement. A reader expecting the
constraint reading (only teachers may teach) has the semantics backwards, which
is a recurring source of confusion when RDFS is reached for as a validation
layer. [OWL](/beliefs/glossary/owl.md) extends the same inference-first stance
with far richer axioms;
[SHACL](/beliefs/glossary/shacl.md) is where the constraint reading lives.

*Seen in:* [why agentic systems need ontologies](/knowledge/SWE/agentic/agentic-loop/why-agentic-systems-need-ontologies.md), [ontology guardrails vs. schema validation](/meta/analysis/ontology-guardrails-vs-schema-validation.md)
