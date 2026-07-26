---
id: em:6e8813
type: concept
title: prefix caching
description: Reuse of the stored attention state for a request's leading tokens when they match a previous request byte-for-byte, so the matched span is billed and computed at a fraction of its normal cost instead of being processed again.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, kv-cache, llm-inference, context-engineering, cost-optimization]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# prefix caching

The exact-match-on-a-prefix semantics are the whole story operationally: matching
walks forward from token zero and stops at the first difference, so the cost of a
change is everything downstream of it, not the change itself. That is why static
content belongs at the front and volatile content at the back, and why cache
entries carry a time-to-live — a conversation resumed after the window lapses
pays full price for its history. Self-hosted serving adds a second requirement
beyond enabling the feature: a conversation's requests must be routed back to the
worker actually holding its cached blocks, usually by hashing a session
identifier, or the hit rate collapses even though caching is "on".

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
