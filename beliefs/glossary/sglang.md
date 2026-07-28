---
id: em:9e4920
type: concept
title: SGLang
description: An open-source LLM serving engine tuned for structured generation and agent loops, delivering lower latency than throughput-oriented engines on constrained JSON output and tool-call encoding.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, llm-inference, serving, structured-output, agents]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /create-pull-request"
  why: "term surfaced by the serving-stack evaluation in the secure-financial-agent session"
---

# SGLang

Where [vLLM](/beliefs/glossary/vllm.md) optimizes the many-concurrent-requests case, SGLang optimizes the shape most agentic pipelines actually have: emit into a schema, call a tool, observe, repeat. That makes it the engine to benchmark first whenever the workload is extraction or tool use rather than open-ended chat — a distinction easy to miss, since throughput benchmarks are the ones usually published.

It shares the [OpenAI-compatible](/beliefs/glossary/openai-compatible-api.md) endpoint convention with its peers, so substituting it for another engine is a base-URL change rather than an application rewrite.

*Seen in:* [local inference serving stacks](/knowledge/SWE/llm-engineering/local-inference-serving-stacks.md)
