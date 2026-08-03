---
id: em:ab825a
type: concept
title: Messages API
description: Anthropic's core HTTP endpoint (POST /v1/messages) for conversing with Claude models — tool use, structured outputs, and extended thinking are all features of this single endpoint rather than separate APIs.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, anthropic, api, inference]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T03:05:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-03 stack-direction thread's eval-instrument evaluation"
---

# Messages API

The API is stateless: each request carries the full conversation, and the
server holds nothing between calls. One consequence is that the integration
surface is small — a language without an official SDK, Elixir among them,
speaks to it with a plain HTTP client, while the official SDKs add
conveniences (streaming accumulation, tool-runner loops) over the same wire
calls. Distinct from the
[OpenAI-compatible API](/beliefs/glossary/openai-compatible-api.md) dialect
that self-hosted inference servers expose — a
[harness](/beliefs/glossary/harness.md) driving both Claude and open-weights
endpoints speaks two similar but different HTTP dialects.

*Seen in:* [2026-08-03 stack-direction thread](/meta/threads/2026-08-03-stack-direction-journal-and-eval-stack-evaluation.md)
