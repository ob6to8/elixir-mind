---
id: em:4aa691
type: concept
title: vLLM
description: An open-source inference and serving engine for large language models, widely used for self-hosted deployment, whose paged attention design underpins high-throughput batching and prefix-cache reuse.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, llm-inference, serving, open-source, kv-cache]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# vLLM

The name recurs in context-engineering advice because self-hosting relocates
cache behavior from the provider's problem to yours. Reuse is a serving-level
feature you enable, and enabling it is not sufficient: in a multi-worker
deployment a conversation's requests also have to land on the worker that
actually holds its cached blocks, typically by routing on a session identifier,
or hits never materialize despite the feature being on. Paged attention — managing
[KV-cache](/beliefs/glossary/kv-cache.md) in fixed-size blocks rather than one
contiguous span per sequence — is what makes both the sharing and the batching
practical.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
