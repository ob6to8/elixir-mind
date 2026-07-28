---
id: em:fc8797
type: concept
title: MXFP4
description: A 4-bit floating-point tensor format from the Open Compute Project's microscaling specification, in which a block of FP4 values shares one scale factor, and which executes natively on NVIDIA Blackwell and AMD MI400 accelerators.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, quantization, ml-infrastructure, gpu, model-serving]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Kimi K3 model-card intake"
---

# MXFP4

The shared per-block exponent is what makes four bits usable at all: a flat 4-bit
float has too little dynamic range to represent a weight tensor, but rescaling
every small block independently recovers most of it, so the error stays local
rather than accumulating across the tensor. The practical effect is a 4×
reduction against FP16 — the difference between a 5.6TB and a 1.4TB checkpoint at
frontier scale — usually paired with MXFP8 for activations, where precision
matters more for numerical stability.

Native hardware support is the load-bearing part. Because Blackwell and MI400
execute the format directly rather than upconverting it, MXFP4 is a viable
*distribution* format for weights rather than a lossy convenience applied at
load time, which is what makes shipping a frontier model in four bits coherent.
Its value is greatest when the model was trained with
[quantization-aware training](/beliefs/glossary/quantization-aware-training.md)
rather than compressed after the fact.

*Seen in:* [Kimi K3](/knowledge/machine-learning/kimi-k3.md)

*See also:* [quantization](/beliefs/glossary/quantization.md), [quantization-aware training](/beliefs/glossary/quantization-aware-training.md)
