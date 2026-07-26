---
id: em:62a63e
type: concept
title: context isolation
description: Giving each unit of an agent's work its own separate context — usually by delegating to a subagent — so token growth and confusion in one unit never accumulate in the others.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, context-engineering, multi-agent, agentic-loop, subagents]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# context isolation

Two payoffs, one cost. Growth stays bounded because the delegating agent sees
only a returned result rather than every step that produced it, and pattern ruts
break because a fresh context carries none of the parent's self-generated
repetition — which is why isolation, not injected variation, has become the usual
answer to
[few-shot](/beliefs/glossary/few-shot-prompting.md) lock-in. The cost is that the
isolated worker lacks everything the parent knows, so the briefing handed across
the boundary becomes the real design problem: too thin and the subagent solves
the wrong task, too thick and the isolation saved nothing. Scales to deliberate
parallelism — Manus's Wide Research fans a single task across 100+ concurrent
subagents on exactly this basis.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
