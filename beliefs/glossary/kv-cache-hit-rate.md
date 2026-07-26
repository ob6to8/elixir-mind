---
id: em:3e204b
type: concept
title: KV-cache hit rate
description: The fraction of an inference request's input tokens served from previously computed cache rather than processed afresh — the single lever that most directly moves an agent's per-step latency and token cost.
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

# KV-cache hit rate

Agents are unusually exposed to this number because of their token shape: context
accumulates every turn while the model's replies stay short, so an agentic
workload can run two orders of magnitude more input than output tokens. When
almost all spend is on input, almost all available savings are in not
recomputing it. The rate is also brittle rather than gradual — caching matches on
an exact leading prefix, so one mutated byte early in the context (the canonical
own-goal being a timestamp in the system prompt) forfeits every cached token
after it. Keeping the rate high is therefore a discipline about *shape*, not a
tuning parameter: stable prefix, [append-only](/beliefs/glossary/append-only.md)
growth, and
[deterministic serialization](/beliefs/glossary/deterministic-serialization.md).

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
