---
id: em:7564a7
type: concept
title: context engineering
description: The practice of deliberately curating what occupies a model's context — instructions, tool definitions, history, retrieved material — and in what arrangement, treating that assembly rather than the model's weights as the primary lever on behavior.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, context-engineering, agentic-loop, prompting, ai-agents]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# context engineering

It supersedes prompt engineering by scope rather than by contradiction: a prompt
is authored once, whereas an agent's context is assembled anew every turn from
accumulating history, so the object of design becomes a *process* for deciding
what enters, what stays, what gets externalized, and where each thing sits. The
discipline exists because two assumptions turned out false — that a larger
[context window](/beliefs/glossary/context-window.md) makes curation unnecessary
(reliability degrades before the ceiling), and that more relevant material is
monotonically better (irrelevant or stale content actively misleads). Its standard
moves are
[offloading](/beliefs/glossary/context-offloading.md),
[compaction](/beliefs/glossary/context-compaction.md),
[isolation](/beliefs/glossary/context-isolation.md), just-in-time retrieval, and
[caching](/beliefs/glossary/prefix-caching.md). The term went from coinage to
industry standard vocabulary over 2025.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
