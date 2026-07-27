---
id: em:9e945b
type: concept
title: GGUF
description: The single-file container format for quantized model weights used by llama.cpp — tensors plus all metadata needed to load and run the model, designed for memory-mapped loading without a separate config or tokenizer file.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, llm-inference, quantization, file-format, local-inference]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Beyond Refusal paper intake (arXiv:2607.05842)"
---

# GGUF

Self-description is the design point: architecture, hyperparameters, tokenizer, and quantization scheme all travel inside the file, so a single artifact is loadable without the surrounding repository the weights came from. Quantization variants are named in the filename by scheme and bit width — `Q4_K_M` denoting a 4-bit K-quant at medium quality — which is how a published artifact advertises its own accuracy/size tradeoff.

Because conversion to GGUF and quantization happen together, a community-published GGUF derivative differs from its upstream parent in more than whatever edit motivated the release. Treating such an artifact as a clean experimental variant of its parent overstates the control; it is a released deployment endpoint that bundles several changes.

*Seen in:* [Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md), <https://arxiv.org/abs/2607.05842>

*See also:* [llama.cpp](/beliefs/glossary/llama-cpp.md), [quantization](/beliefs/glossary/quantization.md), [open weights](/beliefs/glossary/open-weights.md)
