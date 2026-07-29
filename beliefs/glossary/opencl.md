---
id: em:a1a049
type: concept
title: OpenCL
description: Khronos's older, compute-focused cross-vendor API, consuming SPIR-V like Vulkan but guaranteeing a broader baseline — free pointer casting across address spaces and correctly-rounded results for common math functions.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, opencl, gpu-programming, compute-apis, khronos, spir-v]
sense: common
timestamp: 2026-07-29
attribution:
  when: 2026-07-29
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Zig GPU blog intake thread"
---

# OpenCL

Where [Vulkan](/beliefs/glossary/vulkan.md)'s baseline compute profile treats
pointer-casting and precise math as optional, OpenCL guarantees both: kernels
can cast pointers between [address spaces](/beliefs/glossary/address-space.md)
via `OpPtrCastToGeneric`, and `fma`/`sqrt`/`exp`/`log` are required to be
[correctly rounded](/beliefs/glossary/correctly-rounded.md). That gap is
concrete in Zig's own compiler test suite: its [self-hosted SPIR-V backend](/knowledge/SWE/gpu-programming/zig-gpu-backends.md)
passes roughly 75% of behavior tests under OpenCL versus roughly 50% under
baseline Vulkan 1.2, for the same underlying IR.

*Seen in:* [2026-07-29 Zig GPU blog intake](/meta/threads/2026-07-29-zig-gpu-blog-intake.md), [Zig and GPUs (Ali Cheraghi)](/knowledge/SWE/gpu-programming/zig-gpu-backends.md)
