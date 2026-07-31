---
id: em:b56f3f
type: concept
title: Address space
description: A memory-region tag (e.g. local, global, private) that a pointer must carry in GPU kernel IRs like SPIR-V — which address spaces a pointer can validly move between is a portability boundary between GPU APIs, not just a performance detail.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, address-space, gpu-programming, spir-v, memory-model]
sense: common
timestamp: 2026-07-29
attribution:
  when: 2026-07-29
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Zig GPU blog intake thread"
---

# Address space

[OpenCL](/beliefs/glossary/opencl.md) supports casting a pointer into a
generic, address-space-agnostic form (`OpPtrCastToGeneric`), so a kernel can
move a pointer freely between memory regions. Baseline [Vulkan](/beliefs/glossary/vulkan.md)
doesn't support that instruction at all, so a compiler backend targeting it —
like Zig's [SPIR-V](/beliefs/glossary/spir-v.md) backend — has to default every
pointer to a single address space (local memory) rather than letting it move.

*Seen in:* [2026-07-29 Zig GPU blog intake](/meta/threads/2026-07-29-zig-gpu-blog-intake.md), [Zig and GPUs (Ali Cheraghi)](/knowledge/SWE/gpu-programming/zig-gpu-backends.md)
