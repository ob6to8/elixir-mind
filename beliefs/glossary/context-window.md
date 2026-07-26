---
id: em:b3f6bd
type: concept
title: context window
description: The maximum span of tokens a model can attend to in one pass — the hard ceiling on everything it can see at once, including instructions, tool definitions, accumulated history, and its own output.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, llm-inference, context-engineering, transformers]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# context window

It is a limit on a single request, not a memory: nothing survives between calls
unless it is re-sent, which is why durable state has to live in
[agent memory](/beliefs/glossary/agent-memory.md) outside the window. Nominal
capacity has grown from a few thousand tokens to a million and beyond, but usable
capacity lags the number on the box in two ways — reliability falls off well
before the ceiling
([context rot](/beliefs/glossary/context-rot.md),
[lost-in-the-middle](/beliefs/glossary/lost-in-the-middle.md)), and cost and
latency scale with how much of it you actually occupy. Both are why larger
windows shifted the practice of
[context offloading](/beliefs/glossary/context-offloading.md) from a workaround
to a design default rather than making it unnecessary.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
