---
id: em:1b3160
type: concept
title: lost-in-the-middle
description: The tendency of a language model to use information at the start and end of a long input far more reliably than information buried in its middle, producing a U-shaped accuracy curve by position.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, llm-inference, context-engineering, attention, long-context]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# lost-in-the-middle

Established through retrieval and question-answering experiments that held
content constant and varied only *where* the needed fact sat, isolating position
as the cause. For agents the consequence is a slow failure rather than a visible
one: an objective stated once at the top of a long run keeps being technically
present while steadily losing its grip on behavior, and the agent drifts without
ever contradicting its instructions. Countermeasures split into positional —
re-emit what matters into the tail, as
[recitation](/beliefs/glossary/recitation.md) does — and structural: shrink the
input so there is less middle to get lost in. Related to but narrower than
[context rot](/beliefs/glossary/context-rot.md), which concerns degradation with
occupancy generally rather than position specifically.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>, [2026-07-25 journal-skill thread](/meta/threads/2026-07-25-journal-skill-and-first-entry.md), [journal 2026-07-25](/journal/2026-07-25.md)
