---
id: em:96a4d0
type: reference
title: "TurboFieldfare — running Gemma 4 26B-A4B in ~2GB RAM on Apple Silicon"
description: A purpose-built Swift/Metal runtime that streams MoE expert weights from SSD instead of loading them into RAM, letting Gemma 4's 26B-A4B checkpoint run on 8GB Apple Silicon Macs.
resource: "https://github.com/drumih/turbo-fieldfare"
provenance: "Fetched from the project's GitHub README, 2026-07-29"
tags: [llm-inference, apple-silicon, metal, moe, quantization, on-device, swift]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator pasted the repo link to file it into the brain"
---

# TurboFieldfare — running Gemma 4 26B-A4B in ~2GB RAM on Apple Silicon

TurboFieldfare is a custom Swift 6.2 / Metal 4 runtime, purpose-built for one
model — Google's Gemma 4 26B-A4B instruction-tuned checkpoint — rather than a
general-purpose inference wrapper. It targets macOS 26+ on Apple Silicon
(arm64-only).

## The memory trick

The full checkpoint is 14.3GB. Instead of loading it whole, TurboFieldfare
keeps roughly 2GB resident — the 1.35GB shared core plus an FP16 KV cache —
and **streams routed MoE experts from SSD on demand** rather than holding
every expert in RAM. This is the same total-vs-active-parameters distinction
that governs
[MoE sizing on any stack](/knowledge/SWE/llm-engineering/local-inference-workstation-tiers.md#sizing-discipline):
what changes here is that TurboFieldfare pushes the *inactive* experts off the
resident-memory budget entirely, onto disk, since only a handful of experts
are active per token. This is what makes the model runnable on Macs with as
little as 8GB total RAM.

## Design

Unlike [llama.cpp](/knowledge/SWE/llm-engineering/local-inference-serving-stacks.md)-style
general quantization/mmap wrappers, TurboFieldfare ships custom Metal kernels
written specifically for this model's shape: quantized GEMV, attention, MoE
routing, normalization, RoPE, sampling, and fused production kernels.

It ships four products from one codebase:
- a native SwiftUI/AppKit Mac app
- a CLI for instruction chat and raw completions
- an experimental OpenAI-compatible loopback Chat Completions server
- a Swift library exposing the runtime and Metal kernels directly

An installer streams and verifies the model weights, which are downloaded
separately from Hugging Face and remain under their own license.

## Measured performance

- M2 MacBook Air: 5.1–6.3 tokens/second decode
- M5 Pro: 31–35 tokens/second decode

The repo's `docs/` records 103 measured optimization experiments taken during
development, alongside system-architecture writeups and benchmarking
guidance for community contributors.

## Licensing

Apache 2.0 for the source and documentation. Model weights are separate and
governed by their Hugging Face source terms. Independent project, not
affiliated with Google.

# Citations

- <https://github.com/drumih/turbo-fieldfare> — project repository and README
