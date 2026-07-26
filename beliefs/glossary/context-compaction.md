---
id: em:6c71f6
type: concept
title: context compaction
description: Periodically shrinking an agent's accumulated context in place — pruning or summarizing earlier turns — so a long-running loop keeps fitting inside its window.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, context-engineering, agentic-loop, agent-memory, long-context]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# context compaction

The whole difficulty is deciding what is safe to lose, and practice has converged
on two rules that cut against naive summarization. Keep material **verbatim**
while it is still task-relevant: compressing a precise error string into a
description of the error destroys the agent's ability to match or search on it,
so exact tokens should be retained or dropped, never paraphrased. And prefer
dropping resolved state over summarizing it, since stale detail is not merely
redundant but actively misleading when the agent treats it as current. The known
hazard is cumulative: repeated summarization can quietly erode constraints given
early in a run, so the agent ends up unbound by rules it was never told to
forget. Server-side implementations additionally take care to evict without
disturbing the cached prefix, which is what makes compaction compatible with
[prefix caching](/beliefs/glossary/prefix-caching.md) instead of a way to defeat
it. Contrast [context offloading](/beliefs/glossary/context-offloading.md), whose
externalized reference makes the same shrink reversible.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
