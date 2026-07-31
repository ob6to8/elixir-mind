---
id: em:88dd10
type: concept
title: AMDGCN
description: AMD's GPU instruction set architecture (Graphics Core Next), targeted by LLVM as a compilation output so a language can run on AMD hardware without going through AMD's own ROCm/HIP compiler toolchain.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, amdgcn, amd, gpu-programming, hip, llvm]
sense: common
timestamp: 2026-07-29
attribution:
  when: 2026-07-29
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Zig GPU blog intake thread"
---

# AMDGCN

Zig's [LLVM](/beliefs/glossary/llvm.md)-based GPU path emits AMDGCN directly
for AMD targets — the NVIDIA-hardware counterpart is [PTX](/beliefs/glossary/ptx.md)
— letting Zig code run on AMD cards without depending on [HIP](/beliefs/glossary/hip.md)'s
own compiler.

*Seen in:* [2026-07-29 Zig GPU blog intake](/meta/threads/2026-07-29-zig-gpu-blog-intake.md), [Zig and GPUs (Ali Cheraghi)](/knowledge/SWE/gpu-programming/zig-gpu-backends.md)
