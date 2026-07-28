---
id: em:367dbd
type: concept
title: Argument Interchange Format (AIF)
description: The argumentation community's standard ontology for exchanging arguments — information nodes joined through inference and conflict application nodes — expressed in OWL but used purely as a schema language, with no reasoner in the loop.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, argumentation, knowledge-representation, semantic-web, epistemics]
sense: common
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T07:12:25Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the vocabulary precedent the OWL/belief-layer analysis recommends for a future derived belief graph"
---

# Argument Interchange Format (AIF)

A community standard (2006) for representing and exchanging arguments across
tools: **information nodes** carry propositional content, and they are joined
only through **scheme application nodes** — inference nodes for support,
conflict nodes for attack — giving the bipartite shape in which every
derivation step is itself an addressable node carrying its warrant. That is
the same structure this brain's
[belief-decomposition plan](/meta/plans/belief-decomposition-analysis-mode.md)
specifies independently. Its instructive detail is how it uses
[OWL](/beliefs/glossary/owl.md): the ontology names the node and edge kinds so
external tools can consume the data, while the reasoning stays in
[argumentation semantics](/beliefs/glossary/argumentation-framework.md) — the
schema-not-reasoner role that is the one sanctioned use of OWL here.

*Seen in:* [OWL and the belief layer](/meta/analysis/owl-and-the-belief-layer.md), [2026-07-28 OWL/RDF/SKOS thread](/meta/threads/2026-07-28-owl-rdf-skos-and-the-belief-layer.md)
