---
id: em:d70706
type: concept
title: LLVM
description: A compiler infrastructure — a shared toolkit of reusable optimization passes and code generators built around a common intermediate representation — that language front ends (including Zig's) target to reach many CPU and GPU instruction sets without writing a native backend per target.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, llvm, compilers, gpu-programming, code-generation]
sense: common
timestamp: 2026-07-29
attribution:
  when: 2026-07-29
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Zig GPU blog intake thread"
---

# LLVM

Zig already uses LLVM for CPU code generation, and reuses the same
infrastructure for GPUs: instead of going through [SPIR-V](/beliefs/glossary/spir-v.md),
its LLVM path lowers Zig code straight to a GPU vendor's native instruction
set — [PTX](/beliefs/glossary/ptx.md) for NVIDIA, [AMDGCN](/beliefs/glossary/amdgcn.md)
for AMD — without needing [CUDA](/beliefs/glossary/cuda.md) or [HIP](/beliefs/glossary/hip.md)
as an intermediary compiler.

*Seen in:* [2026-07-29 Zig GPU blog intake](/meta/threads/2026-07-29-zig-gpu-blog-intake.md), [Zig and GPUs (Ali Cheraghi)](/knowledge/SWE/gpu-programming/zig-gpu-backends.md)
