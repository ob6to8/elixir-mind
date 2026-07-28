---
id: em:801f40
type: concept
title: Pydantic
description: The Python library that turns type annotations into runtime validation and coercion, widely used to type LLM tool-call arguments and structured outputs at the boundary of an agent loop.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, python, validation, agents, tool-use, function-calling]
sense: common
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T08:30:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-28 ontology-guardrails thread and its source talk"
---

# Pydantic

A model is an ordinary annotated Python class; instantiating it parses, coerces,
and validates the input, raising on mismatch — supplying at runtime the guarantee
Python's gradual typing does not enforce. Its JSON Schema export is why it became
the default vehicle for [function-calling](/beliefs/glossary/function-calling.md)
argument definitions: the same model can describe a tool's parameters to a model
and validate what comes back.

That dual use is also where its limit shows. The schema sent to the LLM and the
model guarding execution are separate artifacts in most codebases and can drift
apart — a seam that [Jido](/beliefs/glossary/jido.md)'s Action schemas close by
deriving the tool definition from the validating declaration. And validation is
per-call and structural: it decides whether a value is well-formed, never whether
an action is *permitted* given everything else that has happened (see the
[ontology-guardrails analysis](/meta/analysis/ontology-guardrails-vs-schema-validation.md)).

*Seen in:* [why agentic systems need ontologies](/knowledge/SWE/agentic/agentic-loop/why-agentic-systems-need-ontologies.md), [ontology guardrails vs. schema validation](/meta/analysis/ontology-guardrails-vs-schema-validation.md)
