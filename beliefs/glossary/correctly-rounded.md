---
id: em:318d41
type: concept
title: Correctly rounded
description: A floating-point operation's guarantee that its result is the exact mathematical answer rounded to the nearest representable value, rather than a hardware- or driver-dependent approximation.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, correctly-rounded, floating-point, numerical-computing, gpu-programming]
sense: common
timestamp: 2026-07-29
attribution:
  when: 2026-07-29
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Zig GPU blog intake thread"
---

# Correctly rounded

[OpenCL](/beliefs/glossary/opencl.md) requires `fma`, `sqrt`, `exp`, and `log`
to be correctly rounded; baseline [Vulkan](/beliefs/glossary/vulkan.md) does
not, so the same kernel compiled through [SPIR-V](/beliefs/glossary/spir-v.md)
can return numerically different results for those functions depending on
which API and driver run it.

*Seen in:* [2026-07-29 Zig GPU blog intake](/meta/threads/2026-07-29-zig-gpu-blog-intake.md), [Zig and GPUs (Ali Cheraghi)](/knowledge/SWE/gpu-programming/zig-gpu-backends.md)
