---
id: em:05fab0
type: concept
title: unique name assumption (UNA)
description: The stance that distinct identifiers denote distinct things; OWL declines it, so two differently-named individuals may be inferred identical rather than treated as a conflict.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, knowledge-representation, logic, owl, semantics, identity]
sense: common
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T08:30:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-28 ontology-guardrails thread as the reason an OWL functional property infers sameAs instead of raising an error"
---

# unique name assumption (UNA)

Relational databases and most programming languages take it for granted: two
different keys are two different rows. [OWL](/beliefs/glossary/owl.md)
deliberately does **not**, because the web it was designed for has many names for
the same thing — the same person may be identified by a dozen URIs across
datasets, and merging them is a feature.

The consequence catches guardrail designers out. Declaring a property functional
(at most one value) and then asserting two values does not raise a conflict; the
reasoner concludes the two values are `owl:sameAs` each other. Getting an
inconsistency instead requires explicitly asserting the individuals distinct
(`owl:differentFrom`, `owl:AllDifferent`) or having them carry contradictory
values elsewhere. This is why a "can only happen once" rule is not expressible as
an OWL functional property alone — see the
[ontology-guardrails analysis](/meta/analysis/ontology-guardrails-vs-schema-validation.md).

*Seen in:* [ontology guardrails vs. schema validation](/meta/analysis/ontology-guardrails-vs-schema-validation.md)
