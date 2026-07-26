---
id: em:5ab369
type: concept
title: recitation
description: Deliberately re-emitting a task's plan or objective into the tail of an agent's context — canonically by rewriting a todo file as steps complete — so the goal keeps sitting in the region the model attends to most reliably.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, context-engineering, agentic-loop, attention, agent-memory, terminology]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# recitation

The mechanism is positional, not semantic: because a rewrite is an append, the
restated plan lands at the end of the context, where attention is strongest, and
it lands again on every update. Nothing about the model or the system prompt
changes — the agent's own output does the steering, which is what makes the
technique available to anyone with a file-writing tool and no access to the
serving stack. It directly counters
[lost-in-the-middle](/beliefs/glossary/lost-in-the-middle.md) attenuation over
long runs, and it is now standard in mainstream coding agents, which maintain
explicit plan or todo state and rewrite it as work proceeds.

Whether reciting *brain-level* objectives — doctrine, priorities, the active
plan's intent — adds behavior a harness's mechanical task reminders don't is
tracked by the
[priorities-recitation eval](/meta/evals/priorities-recitation-vs-harness-reminders.md);
this brain's `/priorities` and `mix brain.session_init` are recitation at
session granularity.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>, [2026-07-25 journal-skill thread](/meta/threads/2026-07-25-journal-skill-and-first-entry.md), [journal 2026-07-25](/journal/2026-07-25.md)
