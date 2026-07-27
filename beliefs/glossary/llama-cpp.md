---
id: em:4b5735
type: concept
title: llama.cpp
description: A dependency-light C/C++ inference engine for running quantized language models on ordinary CPUs and consumer GPUs, and the de-facto reference implementation for local open-weights serving.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, llm-inference, local-inference, quantization, serving]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Beyond Refusal paper intake (arXiv:2607.05842)"
---

# llama.cpp

Where [vLLM](/beliefs/glossary/vllm.md) targets datacenter throughput, llama.cpp targets running a model at all on hardware that has no business running one — its design centers on aggressive [quantization](/beliefs/glossary/quantization.md) and memory mapping rather than on batching. Its bundled `llama-server` exposes an [OpenAI-compatible](/beliefs/glossary/openai-compatible-api.md) endpoint, which is what makes it a drop-in evaluation backend.

Its GGUF file format has become the distribution standard for community model artifacts, so a checkpoint published as GGUF is implicitly published for this runtime. For research use its value is reproducibility: local weights plus pinned decoding parameters remove the silent model-version churn that makes hosted-API results unrepeatable.

*Seen in:* [Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md), <https://arxiv.org/abs/2607.05842>
