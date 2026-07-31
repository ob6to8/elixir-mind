---
id: em:a9efbd
type: concept
title: textual learning rate
description: In text-space optimization, the maximum number (or size) of edit patches a single optimization step may apply to the text artifact being trained — the textual analogue of a weight-space learning rate, bounding how much a single step can change.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, prompt-optimization, agentic, llm-training]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 Microsoft SkillOpt intake thread"
---

# textual learning rate

Distinct from a [validation gate](/beliefs/glossary/validation-gate.md): the gate
decides *whether* a step's result is kept, the learning rate decides *how big*
a step is allowed to be before it's even scored — the textual equivalent of
gradient clipping. [SkillOpt](/knowledge/SWE/agentic/skill-optimization/skillopt.md)
exposes it as `optimizer.learning_rate` (a patch count, e.g. 4 per step,
decaying on a schedule such as `cosine`), decoupled from `evaluation.use_gate`.

*Seen in:* [2026-07-31 Microsoft SkillOpt intake](/meta/threads/2026-07-31-microsoft-skillopt-intake.md)

*See also:* [validation gate](/beliefs/glossary/validation-gate.md), [text-space optimization](/beliefs/glossary/text-space-optimization.md)
