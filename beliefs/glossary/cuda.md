---
id: em:8bf85e
type: concept
title: CUDA
description: NVIDIA's proprietary GPU programming toolchain and runtime, historically required to compile and launch code on NVIDIA GPUs — the toolchain that LLVM-based paths emitting PTX directly aim to bypass.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, cuda, nvidia, gpu-programming, runtimes]
sense: common
timestamp: 2026-07-29
attribution:
  when: 2026-07-29
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Zig GPU blog intake thread"
---

# CUDA

Zig's LLVM path already avoids needing CUDA's compiler by emitting
[PTX](/beliefs/glossary/ptx.md) directly, but launching that PTX still needs a
CUDA-compatible *runtime* — bindings for which are named as planned future
work in [Zig and GPUs](/knowledge/SWE/gpu-programming/zig-gpu-backends.md). The
AMD counterpart toolchain is [HIP](/beliefs/glossary/hip.md).

*Seen in:* [2026-07-29 Zig GPU blog intake](/meta/threads/2026-07-29-zig-gpu-blog-intake.md), [Zig and GPUs (Ali Cheraghi)](/knowledge/SWE/gpu-programming/zig-gpu-backends.md)
