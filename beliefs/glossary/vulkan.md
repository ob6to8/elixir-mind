---
id: em:28cf8e
type: concept
title: Vulkan
description: A low-level, cross-vendor graphics-and-compute API from the Khronos Group, consuming SPIR-V as its shader/kernel intermediate representation; its baseline compute profile guarantees less pointer and floating-point behavior than OpenCL.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, vulkan, gpu-programming, graphics-apis, khronos, spir-v]
sense: common
timestamp: 2026-07-29
attribution:
  when: 2026-07-29
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Zig GPU blog intake thread"
---

# Vulkan

Vulkan's *baseline* compute profile — the guaranteed-portable subset every
conformant implementation must support — is markedly more restrictive than
[OpenCL](/beliefs/glossary/opencl.md)'s: it lacks `OpPtrCastToGeneric` (so
pointers can't move freely between [address spaces](/beliefs/glossary/address-space.md)),
and doesn't guarantee [correctly rounded](/beliefs/glossary/correctly-rounded.md)
results for common math functions. A compiler backend targeting Vulkan through
[SPIR-V](/beliefs/glossary/spir-v.md), like Zig's, inherits those weaker
guarantees rather than the stronger ones OpenCL offers for the same IR.

*Seen in:* [2026-07-29 Zig GPU blog intake](/meta/threads/2026-07-29-zig-gpu-blog-intake.md), [Zig and GPUs (Ali Cheraghi)](/knowledge/SWE/gpu-programming/zig-gpu-backends.md)
