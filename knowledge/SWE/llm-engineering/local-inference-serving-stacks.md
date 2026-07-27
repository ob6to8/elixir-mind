---
id: em:f5914d
type: reference
title: "Local inference serving stacks — vLLM, SGLang, llama.cpp, Ollama"
description: How the four dominant open-source inference engines divide the problem as of mid-2026 — datacenter throughput, structured/agentic latency, run-it-anywhere portability, and packaging — and the sizing facts that decide which one a self-hosted deployment wants.
provenance: "Distilled from 2026 inference-engine comparisons and self-hosting guides, fetched 2026-07-27"
tags: [inference, serving, vllm, sglang, llama-cpp, ollama, quantization, self-hosting]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, secure-financial-agent architecture session"
  why: "the serving-layer decision for a locally-hosted system needed the current engine landscape, which is true independent of that system"
---

# Local inference serving stacks — vLLM, SGLang, llama.cpp, Ollama

The production-grade open-source engines — vLLM, llama.cpp, SGLang, LMDeploy,
Aphrodite, LightLLM — are not competing on the same axis. Picking one is mostly a
matter of naming which axis the deployment actually cares about.

## The four that matter

**vLLM** is the datacenter-throughput default. PagedAttention for memory-efficient
attention, continuous batching, speculative decoding, and the broadest
quantization coverage of the group: FP8, MXFP8/MXFP4, NVFP4, INT8, INT4,
GPTQ/AWQ, and GGUF. If the question is "serve many concurrent requests fast on
CUDA hardware," this is the answer.

**SGLang** targets a different bottleneck: **structured generation and agent
loops**. It delivers lower latency than vLLM for constrained JSON output,
tool-call encoding, and multi-turn agentic workloads. Any pipeline whose shape is
*extract into a schema* or *call a tool, observe, repeat* should benchmark SGLang
before defaulting to vLLM — the workload it optimizes for is exactly that one.

**llama.cpp** optimizes for running a model *at all* on hardware that has no
business running one — aggressive quantization and memory mapping rather than
batching. Its GGUF format is the community distribution standard, and its bundled
`llama-server` exposes an OpenAI-compatible endpoint. On CUDA hardware serving
concurrent traffic, vLLM with AWQ or FP8 is faster; llama.cpp wins on CPU offload,
Apple Silicon, and portability. See [llama.cpp](/beliefs/glossary/llama-cpp.md).

**Ollama** is a packaging and lifecycle layer over the llama.cpp lineage —
pull-a-model ergonomics, a local daemon, an OpenAI-compatible endpoint. It
optimizes for developer friction, not throughput, which makes it the right first
stop and the wrong last one.

## The interface that makes them interchangeable

All four expose an **OpenAI-compatible HTTP endpoint**, which is why the serving
engine is one of the cheapest decisions in a local stack to reverse: a client
library pointed at a base URL does not care what is behind it. Prototype on
Ollama, move to vLLM or SGLang for production, and the application code is
unchanged. Treat engine choice as a tuning decision made after the pipeline
works, not an architectural commitment made before.

## Sizing facts that decide the outcome

- **Size on total parameters, not active ones.** MoE models must hold every
  expert in memory; the active count governs speed, not footprint.
- **Budget framework overhead.** vLLM, SGLang, or TGI add roughly 0.5–2GB on top
  of the weights.
- **Budget the KV cache separately, and generously.** Long-context models make
  the cache, not the weights, the binding constraint on how many documents fit
  in one request.
- **FP4 is not the production default as of mid-2026.** Calibration tooling is
  still maturing and accuracy varies by model and task — a high-value bet on
  Blackwell-class hardware, but one to validate on real evaluations rather than
  assume.

# Citations

- <https://builderai.tools/blog/state-of-open-source-llm-inference-engines-2026> — engine landscape and SGLang's structured-output advantage
- <https://dev.to/sreeraj-sreenivasan/the-complete-guide-to-local-llm-inference-tools-in-july-2026-llamacpp-ollama-vllm-sglang-and-4mh1> — July 2026 local inference tool guide
- <https://vrlatech.com/llm-inference-engine-comparison-2026/> — vLLM vs Ollama vs llama.cpp vs SGLang
- <https://www.spheron.network/blog/best-open-source-llms-self-host-2026-vram-guide/> — VRAM tiering, framework overhead, and the FP4 maturity caveat

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:f5914d">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-secure-financial-agent-and-projects-namespace (2026-07-27)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:f5914d`]**

**Serving stack**

- **vLLM** — the production default. PagedAttention, continuous batching, and it takes FP8/MXFP4/NVFP4/INT4/GPTQ/AWQ/GGUF.
- **SGLang** — [lower latency than vLLM for structured JSON output, tool calls, and agent loops](https://builderai.tools/blog/state-of-open-source-llm-inference-engines-2026). Your workload is *exactly* structured extraction and tool calls, so benchmark this one seriously.
- **llama.cpp / Ollama** — laptop tier and CPU offload. `llama-server` gives an OpenAI-compatible endpoint, which matters below.

One caveat worth respecting: **FP4 is not the production default yet** — calibration tooling is still maturing and accuracy varies by model and task. Validate on your own documents before trusting a 4-bit quant with your taxes.
