---
id: em:15b0e0
type: concept
title: context offloading
description: Moving bulky content out of a model's context into external storage — a file, a path, a database row — and keeping only a reference to it, so the material stays reachable without occupying the window.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, context-engineering, agent-memory, agentic-loop]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# context offloading

The property that makes this more than eviction is **restorability**: because the
reference survives, dropping a payload is reversible, and shrinking the context
stops being a bet on which detail will turn out to matter forty steps later. That
is the decisive contrast with truncation or summarization, which discard
irrecoverably and so have to be right about relevance in advance. The pattern's
natural home is a file system the agent can already read and write, which makes
the store unlimited, persistent, and directly operable without new tooling — the
context degrades into an index over external state rather than the state itself.
Compare [context compaction](/beliefs/glossary/context-compaction.md), which
shrinks in place, and [context isolation](/beliefs/glossary/context-isolation.md),
which partitions instead of externalizing.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
