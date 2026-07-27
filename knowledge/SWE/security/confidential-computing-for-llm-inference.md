---
id: em:f96824
type: concept
title: "Confidential computing for LLM inference"
description: Running inference inside a hardware trusted execution environment spanning CPU and GPU, so weights and prompts stay encrypted in memory and in transit and the host operator is removed from the trust boundary — at roughly 2–5% throughput cost.
verified: false
tags: [security, confidential-computing, tee, gpu, attestation, inference, privacy]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, secure-financial-agent architecture session"
  why: "evaluated as the middle tier between self-hosting and a hosted API; the mechanism is true independent of the system that prompted the question"
---

# Confidential computing for LLM inference

A **trusted execution environment** (TEE) is a hardware-enforced region whose
memory the host cannot read, even with physical access or a compromised
hypervisor. Applied to inference, it changes the question "do I trust this
provider?" into "do I trust this silicon vendor's attestation?" — a materially
different and more checkable claim.

## The composite architecture

Neither half suffices alone, so 2026 deployments compose two TEEs:

- **CPU side** — a confidential VM under Intel TDX or AMD SEV-SNP, or an AWS
  Nitro Enclave.
- **GPU side** — NVIDIA H100/H200 in **Confidential Computing mode**, where VRAM
  is encrypted and the CVM↔GPU link becomes an encrypted, TLS-like channel rather
  than unprotected shared memory.

The result is end-to-end confidentiality: model weights and inference inputs stay
protected in CPU memory, in GPU memory, and in transit between them.

**Attestation is the part that matters.** A TEE's value is not the encryption but
the signed measurement it produces — a claim about exactly what code is running
inside the enclave, verifiable by the client before any secret is sent. Composite
attestation covers both the CPU and GPU TEEs. Without attestation, an enclave is
an unfalsifiable promise; with it, the guarantee is cryptographic rather than
contractual.

## The cost is low enough to ignore

NVIDIA publishes **2–5% throughput overhead** for CC mode on H100 across most LLM
inference workloads, with independent reporting putting delivered performance at
95–99% of native. For nearly every workload this is not the deciding factor —
which is unusual for a security control and worth noting, because it means the
tradeoff being made is about trust model and availability, not speed.

Available on Azure Confidential GPU VMs, via Phala on Intel TDX + H100/H200, and
through AWS Nitro Enclaves for the CPU-side case.

## Where it sits

Confidential computing occupies the tier between owning hardware and trusting a
provider's terms of service:

| | Trust boundary | Cost |
|---|---|---|
| Own hardware | yourself only | capital, one-time |
| **Confidential computing** | silicon vendor's attestation chain | cloud GPU + ~2–5% |
| Zero-retention API | the provider's contract | lowest |

Its distinctive use is running a model **too large to own** without extending
trust to the host operator — which makes it the natural escape hatch for
frontier-scale open weights, whose footprints have grown past what an individual
can host. Where a model fits on hardware you physically possess, owning it
remains strictly simpler and strictly more private: no attestation chain to
verify, no enclave-escape research to track, no availability dependency.

# Citations

- <https://appscale.blog/en/blog/confidential-computing-ai-inference-tees-nitro-enclaves-nvidia-h100-h200-2026> — composite attestation and overhead figures
- <https://www.spheron.network/blog/confidential-gpu-computing-nvidia-tee-encrypted-vram/> — encrypted VRAM and the CVM↔GPU channel
- <https://arxiv.org/html/2607.19353> — benchmarking confidential GPU inference on H100 under Intel TDX
- <https://arxiv.org/html/2606.11145> — OpenPcc: open and confidential LLM serving on commodity TEEs
- <https://phala.com/learn/Confidential-LLMs> — confidential LLM serving in practice

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:f96824">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-secure-financial-agent-and-projects-namespace (2026-07-27)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:f96824`]**

Tier 2 is the underrated one. It's how you'd use GLM-5.2 at full size without a $200k rack, and attestation gives you a *cryptographic* claim rather than a promise.
