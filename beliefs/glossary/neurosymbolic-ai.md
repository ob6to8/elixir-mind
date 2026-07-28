---
id: em:9eca36
type: concept
title: neurosymbolic AI
description: Architectures pairing a neural, probabilistic component with a symbolic, rule-based one — in the agent-guardrails usage, an LLM whose proposals are checked by external logic rather than constrained by prompting alone.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, neurosymbolic-ai, agents, knowledge-representation, guardrails]
sense: common
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T08:30:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-28 ontology-guardrails thread and its source talk"
---

# neurosymbolic AI

The neural half supplies pattern recognition and generation over messy inputs;
the symbolic half supplies explicit structure — rules, typed entities,
constraints — whose behavior is inspectable and whose failures are traceable.
The pairing is old (it names the reconciliation of the connectionist and
expert-systems traditions), but the mid-2020s agent usage is narrow and
architectural: keep probabilistic reasoning *inside* the model and put logic
*outside* it, so a proposal the model generates is adjudicated by machinery that
does not itself hallucinate. Coyle's framing — guardrails around a probabilistic
core — is this usage; the
[ontology-guardrails analysis](/meta/analysis/ontology-guardrails-vs-schema-validation.md)
finds the term does not by itself say *which* symbolic formalism, and that the
choice between an inference logic and a closed-world constraint language decides
what the layer can actually catch.

*Seen in:* [why agentic systems need ontologies](/knowledge/SWE/agentic/agentic-loop/why-agentic-systems-need-ontologies.md), [ontology guardrails vs. schema validation](/meta/analysis/ontology-guardrails-vs-schema-validation.md)
