---
id: em:bab1d2
type: reference
title: "Zig and GPUs (Ali Cheraghi)"
description: "Ali Cheraghi's overview of Zig's two GPU compilation paths — a self-hosted SPIR-V backend for Vulkan/OpenCL and an LLVM-based path to native PTX/AMDGCN — and the OpenCL-vs-Vulkan capability gaps (pointer casting, correctly-rounded math) that hold Vulkan's behavior-test pass rate below OpenCL's."
resource: https://alichraghi.github.io/blog/zig-gpu/
provenance: "Distilled from Ali Cheraghi's blog post; layered breakdown via /summarize-technical"
tags: [zig, gpu-programming, spir-v, vulkan, opencl, llvm, ptx, amdgcn, compilers, systems-programming]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked to capture the Zig and GPUs blog post"
---

# Zig and GPUs (Ali Cheraghi)

## Plain-language summary

GPU programming has traditionally meant working through heavyweight,
vendor-specific toolchains — NVIDIA's CUDA, AMD's ROCm/HIP, or the sprawling
C++ compiler stacks that back them. The Zig programming language is building
its own path onto GPUs directly, without requiring those vendor SDKs, in two
ways. First, Zig can compile code down to a portable intermediate format that
both Vulkan (a graphics/compute API) and OpenCL (a compute API) know how to
run — after roughly four years of work, this self-hosted compiler backend is
far enough along to experiment with. Second, for the highest performance, Zig
can skip that intermediate format entirely and use the LLVM compiler
infrastructure it already relies on to generate machine code specific to a
given GPU vendor — one flavor for NVIDIA cards, another for AMD cards.

The catch is that "run on a GPU" doesn't mean the same thing everywhere.
OpenCL, an older and more mature standard, guarantees things Zig's compiler
quietly depends on: that pointers can be freely cast and moved between memory
regions, and that common math operations — fused multiply-add, square root,
exponential, logarithm — return the mathematically exact, correctly-rounded
answer. Vulkan's baseline compute profile promises neither of those: pointer
casting between memory kinds isn't supported at all, so Zig has to fall back
to treating every pointer as if it lives in fast local memory, and those same
math functions are allowed to be merely approximate. Zig's own test suite
reflects the gap: about three-quarters of its behavior tests pass when
targeting OpenCL, versus roughly half when targeting bare Vulkan 1.2. The
article closes by pointing at what's still ahead: supporting wider integer
types, tightening spec compliance, and eventually offering CUDA/HIP-compatible
runtime bindings plus GPU-tuned standard-library algorithms like parallel
prefix sum and reduction.

## Key terms

- **SPIR-V** — Standard Portable Intermediate Representation for Vulkan; a
  typed intermediate representation (IR) that Vulkan and OpenCL both consume
  (and DirectX is expected to), letting one compiler backend target multiple
  GPU APIs instead of one per vendor.
- **Vulkan** — a low-level, cross-vendor graphics-and-compute API from the
  Khronos Group; its *baseline* compute profile is the more restrictive of
  Zig's two SPIR-V-consuming targets.
- **OpenCL** — Khronos's older, compute-focused API; guarantees a broader set
  of pointer and floating-point behaviors than baseline Vulkan, which is why
  it currently passes more of Zig's tests.
- **LLVM** — the compiler infrastructure Zig already uses for CPU code
  generation, reused here to lower Zig code straight to a GPU vendor's native
  instruction set instead of going through SPIR-V.
- **PTX** — NVIDIA's intermediate assembly for CUDA-capable GPUs; Zig emits it
  via LLVM to run on NVIDIA hardware without the CUDA toolchain.
- **AMDGCN** — AMD's GPU instruction set architecture; Zig's LLVM path emits
  it directly to run on AMD hardware without the ROCm/HIP toolchain.
- **Address space** — the memory-region tag (e.g. local, global, private) a
  pointer must carry in SPIR-V/Vulkan/OpenCL kernels; which address spaces a
  pointer can move between is exactly where Vulkan's and OpenCL's guarantees
  diverge.
- **`OpPtrCastToGeneric`** — the SPIR-V instruction for casting a pointer into
  a generic, address-space-agnostic form; OpenCL supports it, baseline Vulkan
  does not, forcing Zig's Vulkan backend to default every pointer to the local
  address space instead.
- **Correctly rounded** — a floating-point operation guaranteed to return the
  exact mathematical result rounded to the nearest representable value, rather
  than a hardware-dependent approximation; OpenCL guarantees this for `fma`,
  `sqrt`, `exp`, and `log`, baseline Vulkan does not.
- **Behavior tests** — Zig's own compiler test suite, used here as the
  pass-rate metric (~75% under OpenCL, ~50% under baseline Vulkan 1.2) that
  quantifies how much of Zig's semantics each backend can currently support.
- **CUDA / HIP** — NVIDIA's and AMD's respective proprietary GPU programming
  toolchains and runtimes; Zig's LLVM path already avoids needing their
  compilers, and runtime-compatible bindings for launching PTX/AMDGCN code
  without those toolchains are planned future work.

## Technical summary

Zig currently offers two compilation paths onto the GPU. The first is a
self-hosted SPIR-V backend — roughly four years in development and now viable
for experimentation — targeting Vulkan and OpenCL (and eventually DirectX) as
SPIR-V consumers. The second bypasses SPIR-V and reuses Zig's existing LLVM
backend to lower code directly to vendor-native ISA: PTX for NVIDIA, AMDGCN
for AMD, without requiring the CUDA or HIP toolchains.

The two SPIR-V consumers expose different baseline guarantees, and that gap
constrains what the SPIR-V backend can assume. OpenCL guarantees free pointer
arithmetic and casting across address spaces (via `OpPtrCastToGeneric`) and
correctly rounded results for `fma`, `sqrt`, `exp`, and `log`. Baseline Vulkan
lacks `OpPtrCastToGeneric` entirely, so pointers cannot move between address
spaces the way OpenCL allows; Zig's backend works around this by defaulting
every pointer to the local address space. Vulkan also does not guarantee
correctly rounded output for the same math functions OpenCL does, so results
can diverge slightly by hardware and driver. These gaps show up directly in
Zig's own behavior-test pass rate: ~75% passing under the OpenCL target versus
~50% for baseline Vulkan 1.2 via SPIR-V.

Forward work targets closing both gaps and extending reach: composite integer
support, tighter SPIR-V validation compliance (to raise the Vulkan pass rate),
CUDA/HIP-compatible runtime bindings (so LLVM-emitted PTX/AMDGCN code can be
launched without vendor toolchains), and GPU-oriented standard-library
algorithms (prefix sum, reduction, matrix multiplication) built on top of
these backends.

# Citations

- Ali Cheraghi, "Zig and GPUs": <https://alichraghi.github.io/blog/zig-gpu/> —
  the captured resource.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:bab1d2">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-29-zig-gpu-blog-intake (2026-07-29)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:bab1d2`]**

Bundle verifies cleanly. Now let's grow the dedup gold set per step 8 — this
intake was a bare URL paste, so I check whether there's a natural operator
phrasing to harvest.

The intake was invoked with just a bare URL and no accompanying text, so
there's no natural phrasing to harvest — per the skill, I skip that silently.
Let's still refresh the dedup baseline.

---

**[`em:bab1d2`]**

**Summary**

I filed the blog post "Zig and GPUs" (Ali Cheraghi) as a new `type: reference`
document, using the layered `/summarize-technical` breakdown since it's
technical enough to warrant it.

**What I created**

| Doc | Type | Why |
|---|---|---|
| [`knowledge/SWE/gpu-programming/zig-gpu-backends.md`](https://github.com/ob6to8/elixir-mind/blob/claude/zig-gpu-blog-intake-rvzi6v/knowledge/SWE/gpu-programming/zig-gpu-backends.md) (`em:bab1d2`) | `reference` | Layered breakdown of Zig's SPIR-V and LLVM-native GPU backends and the OpenCL-vs-Vulkan capability gaps |
| `knowledge/SWE/gpu-programming/index.md` | index | Listing for the new subdirectory |

**What I modified**

| File | Change |
|---|---|
| `knowledge/SWE/index.md` | Added the new `gpu-programming` subdirectory to the contents list |
| `meta/registry.md` | Regenerated after minting the new id |
