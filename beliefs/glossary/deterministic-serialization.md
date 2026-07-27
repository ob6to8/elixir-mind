---
id: em:e369d4
type: concept
title: deterministic serialization
description: Emitting a given structured value as byte-identical text every time — most often by fixing key order — so consumers that compare or hash the bytes behave consistently.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, serialization, reproducibility, kv-cache, json]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# deterministic serialization

The hazard is that it is not the default: many JSON implementations make no
ordering guarantee, so semantically identical objects legitimately serialize to
different strings across runs, versions, or platforms. Anything downstream that
treats the text as an identity — content-addressed storage, reproducible builds,
diffs, signature verification — breaks silently rather than loudly, since nothing
is *wrong*, only different. In agent contexts the specific casualty is
[prefix caching](/beliefs/glossary/prefix-caching.md): a reshuffled key in a
serialized tool definition or observation forfeits the cached prefix from that
point on, and the resulting
[hit-rate](/beliefs/glossary/kv-cache-hit-rate.md) collapse shows up as an
unexplained cost increase rather than an error.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
