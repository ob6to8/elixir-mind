---
id: em:eea0d0
type: concept
title: HIP
description: AMD's GPU programming toolchain and runtime (part of ROCm), the AMD-side counterpart to NVIDIA's CUDA — historically required to compile and launch code on AMD GPUs.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, hip, amd, rocm, gpu-programming, runtimes]
sense: common
timestamp: 2026-07-29
attribution:
  when: 2026-07-29
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Zig GPU blog intake thread"
---

# HIP

Zig's LLVM path already avoids needing HIP's compiler by emitting
[AMDGCN](/beliefs/glossary/amdgcn.md) directly, but launching that AMDGCN
still needs a HIP-compatible *runtime* — bindings for which are named as
planned future work in [Zig and GPUs](/knowledge/SWE/gpu-programming/zig-gpu-backends.md).
The NVIDIA counterpart toolchain is [CUDA](/beliefs/glossary/cuda.md).

*Seen in:* [2026-07-29 Zig GPU blog intake](/meta/threads/2026-07-29-zig-gpu-blog-intake.md), [Zig and GPUs (Ali Cheraghi)](/knowledge/SWE/gpu-programming/zig-gpu-backends.md)
