---
id: em:24465c
type: concept
title: recitation
description: The agent-design practice of repeatedly rewriting current objectives (e.g. a todo list) into the recent end of the context, keeping the plan at the point of attention instead of letting it decay with distance.
provenance: "Agent-distilled glossary definition, 2026-07-25 session"
verified: false
tags: [glossary, context-engineering, agent-architecture, terminology]
sense: common
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T19:42:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-25 journal-skill thread and first journal entry"
---

# recitation

Popularized by Manus's context-engineering write-up: the agent maintains a `todo.md` and re-writes it as work proceeds, so the overall goal rides the end of the context rather than sitting stale at the top — a direct counter to [lost in the middle](/beliefs/glossary/lost-in-the-middle.md). Modern harnesses (including Claude Code's task tracking and reminders) build a form of this in; whether reciting *brain-level* objectives — doctrine, priorities, the active plan's intent — adds behavior the harness's mechanical task reminders don't is tracked by the [priorities-recitation eval](/meta/evals/priorities-recitation-vs-harness-reminders.md). This brain's `/priorities` and `mix brain.session_init` are recitation at session granularity.

*Seen in:* [2026-07-25 journal-skill thread](/meta/threads/2026-07-25-journal-skill-and-first-entry.md), [journal 2026-07-25](/journal/2026-07-25.md)
