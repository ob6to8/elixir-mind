---
id: em:a01073
type: reference
title: "Single-machine inference hardware, mid-2026"
description: The three workstation tiers that hold a useful model locally — unified-memory CUDA, discrete high-bandwidth CUDA, and Apple Silicon — and the two axes that actually decide between them: memory capacity versus bandwidth, and whether the CUDA-only serving engines are needed.
provenance: "Distilled from 2026 local-inference hardware comparisons and buyer guides, fetched 2026-07-27"
tags: [hardware, local-inference, self-hosting, gpu, apple-silicon, vram]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, secure-financial-agent architecture session"
  why: "the hardware decision for a locally-hosted system needed the current tier landscape, which is true independent of that system"
---

# Single-machine inference hardware, mid-2026

Three tiers can hold a useful model on one machine. They differ less in raw
speed than in two axes that are easy to conflate.

| | Memory | Bandwidth | Price | CUDA |
|---|---|---|---|---|
| **NVIDIA DGX Spark** | 128GB unified LPDDR5X | modest | $4,699 (from $3,999; raised on memory supply) | yes |
| **RTX PRO 6000 Blackwell** | 96GB GDDR7 ECC | high | ~$8,565 + host | yes |
| **Mac Studio M3 Ultra** | up to 512GB unified | 819 GB/s | varies | **no** |

## The two axes

**Capacity versus bandwidth.** Capacity decides *whether a model runs*;
bandwidth decides *how fast it decodes*. They trade against each other at every
price point: the Spark's GB10 Grace Blackwell superchip carries more memory than
the RTX PRO 6000 for half the price, but LPDDR5X moves data far slower than
GDDR7. Which axis binds depends entirely on the workload — a batch pipeline that
runs overnight is capacity-bound and barely notices bandwidth, while interactive
use inverts that.

**CUDA or not.** This is the axis most often discovered too late. Apple Silicon
offers the largest single-machine unified memory available outside enterprise
hardware, and the M3 Ultra's 819 GB/s is genuinely competitive — but it rules out
[vLLM and SGLang](/knowledge/SWE/llm-engineering/local-inference-serving-stacks.md),
leaving MLX or llama.cpp. Choosing Apple therefore chooses a serving stack, and
that choice propagates into throughput characteristics and structured-output
tooling. It is a software decision wearing hardware clothes.

## Reference points

Independent testing on the RTX PRO 6000 in LM Studio clocked Llama 3.1 70B at
31.84 tok/s and Llama 3.3 70B at 31.74; its 96GB holds a 70B model at FP16 or a
109B-class MoE at Q4. The M3 Ultra pushes 70B decode to roughly 25–30 tok/s.
Spark-class small desktops and laptops from ASUS, Dell, HP, Lenovo, Microsoft,
and MSI are scheduled for Fall 2026, which will widen this tier rather than
change its shape.

## Sizing discipline

Three budgets stack, and omitting any of them produces a machine that cannot run
what it was bought for: the weights (at **total** parameters — see
[active parameters](/beliefs/glossary/active-parameters.md)), framework overhead
of roughly 0.5–2GB, and the KV cache. On long-context models the cache is
routinely the binding constraint rather than the weights, so a machine sized
exactly to a model's file size will fail on the first long document.

# Citations

- <https://www.blogarama.com/internet-blogs/1385826-codersera-blog/77195228-local-llm-hardware-showdown-june-2026-dgx-spark-strix-halo-rtx-6000-pro-max> — June 2026 hardware showdown
- <https://www.newegg.com/insider/nvidia-rtx-pro-6000-blackwell-workstation-96gb-gddr7-for-serious-local-ai/> — RTX PRO 6000 Blackwell specifications
- <https://www.vaditaslim.com/blog/ai/local-llm-benchmarks-rtx-pro-6000> — measured throughput across eight models
- <https://pinggy.io/blog/best_hardware_for_self_hosting_local_llms/> — tier selection guidance
- <https://www.digitalapplied.com/blog/best-hardware-run-local-ai-models-2026-price-brackets-guide> — price-bracket buyer guide

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:a01073">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-secure-financial-agent-and-projects-namespace (2026-07-27)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:a01073`]**  (co-feeds: `em:6e97e5`)

They're in `spec-completion.md`, which is on the unmerged PR #148 branch — not on `main` yet, which is likely why you couldn't find them.
