---
id: em:0ad3bb
type: concept
title: response prefill
description: Seeding the opening tokens of a model's reply so generation must continue from them, narrowing what can plausibly follow without altering the prompt.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, llm-inference, tool-use, constrained-generation]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# response prefill

The constraint is positional rather than instructional: instead of asking for a
particular output shape and hoping, the shape is already begun and the model's
only option is continuation. Common uses are forcing a structured payload by
opening its first delimiter, or committing the model to a tool call by writing
the call's opening tokens. It is the cheapest form of steering available — no
extra tokens of instruction, no cache disruption — and it composes with
[logit masking](/beliefs/glossary/logit-masking.md), which handles the tokens
after the seed. Provider support is uneven, and a prefill that fights the model's
natural continuation can degrade quality rather than direct it.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
