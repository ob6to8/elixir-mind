---
id: em:fa8852
type: concept
title: intensional definition
description: A definition that fixes a concept by naming the broader concept it falls under and the characteristics separating it from its siblings, rather than by enumerating the things it covers.
provenance: "Agent-distilled glossary definition (Claude Opus 5)"
verified: false
tags: [glossary, terminology, definitions, logic, schema]
sense: common
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T07:45:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the template a per-type description grammar checks concept summaries against"
---

# intensional definition

Classically *genus proximum et differentia specifica*, and the form
[ISO 704](/beliefs/glossary/iso-704.md) prescribes for terminological work. Its
counterpart, the **extensional** definition, instead lists members or
subtypes — serviceable for a closed set, useless where the set is open or
unknown. The practical test is substitution: a good intensional definition can
replace the term in running text without changing what the sentence says.

Its usefulness to a machine check is that the form decomposes: the genus and
the delimiting characteristics are separable fragments a deterministic parse
can locate, leaving only the fuzzy question — does the differentia actually
delimit? — to a judge. That split is what lets definition quality be enforced
structurally without pretending the semantics are mechanical.

*Seen in:* [schema formalization and the advisory evaluator lane](/meta/plans/schema-formalization-and-evaluator-lane.md), [2026-08-01 schema-formalization thread](/meta/threads/2026-08-01-schema-formalization-and-span-attribution-plans.md)
