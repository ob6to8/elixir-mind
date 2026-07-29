---
id: em:2a8b9e
type: concept
title: PTX
description: NVIDIA's intermediate assembly language for CUDA-capable GPUs, targeted by LLVM as a compilation output so a language can run on NVIDIA hardware without going through NVIDIA's own CUDA compiler toolchain.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, ptx, nvidia, gpu-programming, cuda, llvm]
sense: common
timestamp: 2026-07-29
attribution:
  when: 2026-07-29
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Zig GPU blog intake thread"
---

# PTX

Zig's [LLVM](/beliefs/glossary/llvm.md)-based GPU path emits PTX directly for
NVIDIA targets — the AMD-hardware counterpart is [AMDGCN](/beliefs/glossary/amdgcn.md)
— letting Zig code run on NVIDIA cards without depending on
[CUDA](/beliefs/glossary/cuda.md)'s own compiler.

*Seen in:* [2026-07-29 Zig GPU blog intake](/meta/threads/2026-07-29-zig-gpu-blog-intake.md), [Zig and GPUs (Ali Cheraghi)](/knowledge/SWE/gpu-programming/zig-gpu-backends.md)
