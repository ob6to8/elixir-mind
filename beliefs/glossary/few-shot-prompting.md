---
id: em:5e1788
type: concept
title: few-shot prompting
description: Supplying a handful of worked examples in the prompt so the model infers the pattern and imitates it on a new input, with no weight updates involved.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, prompting, in-context-learning, agentic-loop, llm]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# few-shot prompting

The classic application of
[in-context learning](/beliefs/glossary/in-context-learning.md), and reliable
enough for single-shot tasks that its failure mode in agent loops is easy to miss:
the examples need not be deliberate. An agent's own history fills with
near-identical action and observation pairs, which function as demonstrations
whether or not anyone intended them, and the model continues the established
rhythm past the point where it is the right move — surfacing as drift off the
objective, overgeneralization of a pattern beyond where it applies, and
hallucinated steps that merely fit the shape. Mitigations run in two directions:
inject controlled variation into serialization, phrasing, and ordering so the
context reads less like a pattern to continue, or avoid the accumulation
altogether with
[context isolation](/beliefs/glossary/context-isolation.md).

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
