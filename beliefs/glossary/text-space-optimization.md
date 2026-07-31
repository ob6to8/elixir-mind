---
id: em:a2a2bb
type: concept
title: text-space optimization
description: Improving an LLM system by iteratively rewriting the natural-language artifacts that steer it — prompts, instructions, skill files — while the model's weights stay untouched, in contrast to weight-space optimization, which trains the numeric parameters.
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

# text-space optimization

The family the term names includes TextGrad, GEPA, and
[SkillOpt](/knowledge/SWE/agentic/skill-optimization/skillopt.md): each borrows a
training discipline — iteration, a scored objective, gated acceptance of a
candidate change — and applies it to editing text rather than computing a
gradient over weights. The payoff over ordinary prompt engineering is that the
loop is repeatable and its stopping condition is measured rather than judged by
feel.

*Seen in:* [2026-07-31 Microsoft SkillOpt intake](/meta/threads/2026-07-31-microsoft-skillopt-intake.md)

*See also:* [validation gate](/beliefs/glossary/validation-gate.md), [frozen model](/beliefs/glossary/frozen-model.md)
