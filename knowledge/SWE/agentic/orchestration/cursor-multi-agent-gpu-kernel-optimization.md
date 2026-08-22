---
id: em:ff70fc
type: reference
title: "Multi-agent GPU kernel optimization (Cursor)"
description: A planner-distributed multi-agent swarm optimized 235 CUDA kernels for NVIDIA Blackwell GPUs over three weeks — a 38% geometric-mean speedup and 63% success rate, working across abstraction levels from inline-PTX assembly reasoning to a novel high-level DSL learned from documentation alone.
resource: https://cursor.com/blog/multi-agent-kernels
provenance: "Cursor blog, \"Multi-agent kernels\", fetched 2026-08-21"
tags: [agent-orchestration, multi-agent, gpu, cuda, kernel-optimization, cursor]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Multi-agent GPU kernel optimization

Cursor applied its multi-agent architecture to a domain distant from
application code: optimizing 235 CUDA kernels for NVIDIA Blackwell GPUs over
three weeks — hardware-level work normally requiring months of specialist
engineer time.

## Results

- **38% geometric-mean speedup** across all 235 problems.
- **63% success rate** — 149 of 235 kernels outperformed their baseline.
- **19%** of optimizations exceeded a 2x improvement.
- Median Speed-of-Light score of 0.56, indicating headroom for further gains
  remained even after the run.
- Two specific results cited: an 84% speedup on an attention-mechanism
  kernel, and 86% performance parity with hand-optimized cuBLAS on matrix
  multiplication — the latter notable because cuBLAS is NVIDIA's own
  professionally hand-tuned library, the bar specialist engineers benchmark
  against.

## Architecture

A planner agent distributed work across autonomous workers with
performance-based rebalancing — reassigning kernels toward agents that were
succeeding rather than holding a fixed static assignment. The entire
collaboration protocol lived in one shared markdown file specifying output
formats and tests, rather than in bespoke coordination code. Agents
"independently learned to call the benchmarking pipeline during its runs" —
an autonomous debug-test-optimize feedback loop that emerged from the setup
rather than being explicitly programmed in.

## Working across abstraction levels

The same multi-agent setup worked both in low-level CUDA C with inline PTX
(assembly-level reasoning about the target hardware) and in the high-level
CuTe DSL — a case of agents learning a genuinely novel API from its own
documentation rather than from familiarity baked into training data, at both
ends of the abstraction spectrum a human GPU-kernel specialist would need to
span.

## Conclusion

Cursor's stated takeaway: "multi-agent architectures will quickly become the
default approach to building software" specifically for open-ended problems
that fall outside a single model's training distribution — kernel
optimization for a newly released GPU architecture (Blackwell) being close to
maximally out-of-distribution, since no training corpus can contain
extensive tuned examples for hardware that only recently existed.

## Reading against this bundle

This is the same planner/worker shape as the companion posts on
[agent swarm model economics](/knowledge/SWE/agentic/orchestration/cursor-agent-swarm-model-economics.md)
and [scaling long-running autonomous coding](/knowledge/SWE/agentic/orchestration/cursor-scaling-long-running-agents.md),
applied to a domain where the ground truth (a benchmark number) is
unambiguous and cheap to compute per-attempt — arguably the easiest domain
for this architecture to succeed in, since the judge role that the scaling
post identifies as load-bearing needs no LLM judgment at all here, only a
benchmark run.

# Citations

- Cursor blog, "Multi-agent kernels" — <https://cursor.com/blog/multi-agent-kernels>
