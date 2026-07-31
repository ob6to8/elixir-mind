---
id: em:4218e7
type: concept
title: SPIR-V
description: Standard Portable Intermediate Representation for Vulkan — a typed, binary intermediate representation (IR) that Vulkan and OpenCL both consume (DirectX is expected to), letting a compiler emit one IR and reach multiple GPU APIs instead of one native backend per vendor.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, spir-v, gpu-programming, compilers, vulkan, opencl]
sense: common
timestamp: 2026-07-29
attribution:
  when: 2026-07-29
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Zig GPU blog intake thread"
---

# SPIR-V

A single SPIR-V module can be handed to a Vulkan driver as a compute or
graphics shader, or to an OpenCL runtime as a kernel — the consuming API, not
the source language, decides how it's executed. Zig's [self-hosted SPIR-V backend](/knowledge/SWE/gpu-programming/zig-gpu-backends.md)
targets it directly, but the capability *guaranteed* to a SPIR-V module still
depends on which API loads it: baseline Vulkan supports a narrower subset of
SPIR-V's addressing and math instructions than OpenCL does.

*Seen in:* [2026-07-29 Zig GPU blog intake](/meta/threads/2026-07-29-zig-gpu-blog-intake.md), [Zig and GPUs (Ali Cheraghi)](/knowledge/SWE/gpu-programming/zig-gpu-backends.md)
