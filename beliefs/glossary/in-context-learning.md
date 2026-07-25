---
id: em:942b13
type: concept
title: in-context learning
description: A model's ability to adapt its behavior from information supplied in the prompt alone — examples, instructions, retrieved material — with no change to its weights.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, prompting, llm, few-shot, context-engineering]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# in-context learning

The adaptation is real but entirely transient: it lasts exactly as long as the
material stays in the
[context window](/beliefs/glossary/context-window.md), and vanishes on the next
request that omits it — which is why durable behavior has to be re-supplied every
turn by the harness rather than assumed. Its discovery is what made
[few-shot prompting](/beliefs/glossary/few-shot-prompting.md) work at all, and by
extension what makes an agent's whole accumulated history behaviorally active
rather than inert record. That cuts both ways: everything in context teaches,
including the agent's own repetitive output and its stale mistakes.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
