---
id: em:ae82a8
type: reference
title: "Defeating Nondeterminism in LLM Inference (Thinking Machines Lab)"
description: "Horace He's argument that temperature-0 LLM inference is nondeterministic not because of GPU concurrency but because kernels lack batch invariance — a request's numerics depend on the server load it was batched with — plus batch-invariant RMSNorm, matmul, and attention kernels that make 1,000 completions bitwise identical at roughly 1.6× the latency."
resource: https://thinkingmachines.ai/blog/defeating-nondeterminism-in-llm-inference/
provenance: "Distilled from the full article text (Horace He and Thinking Machines Lab, 'Defeating Nondeterminism in LLM Inference', Thinking Machines Lab: Connectionism, 10 September 2025, doi:10.64434/tml.20250910), fetched 2026-07-28"
tags: [llm-inference, determinism, reproducibility, batch-invariance, gpu-kernels, floating-point, vllm, reinforcement-learning, numerics]
timestamp: 2026-07-28T18:39:50Z
attribution:
  when: 2026-07-28T18:39:50Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "the article was cited as a bare URL from the glossary and the swarm-eval analysis but had never been captured as a filed reference"
---

# Defeating Nondeterminism in LLM Inference

## Summary

Ask a language model the same question twice with randomness turned off and you
can still get two different answers. The usual explanation is that graphics
chips do arithmetic in parallel, thousands of operations at once, finishing in
whatever order they finish; since computer arithmetic on fractional numbers
gives slightly different totals depending on the order you add things up, the
results wobble. He argues this explanation is wrong — or at least not the part
that matters. Run the same multiplication of two large number-grids a thousand
times on the same chip and you get a thousand identical answers. The parallelism
is there, the rounding behavior is there, and yet nothing wobbles.

The real cause is that an inference server processes many users' requests
together in a group, and the size of that group changes constantly with how busy
the server is. The routines that do the heavy arithmetic silently switch
strategies depending on how much work they've been handed — splitting the
addition across more processors when there's little work, keeping it in one
place when there's plenty. A different strategy means a different addition
order, which means a slightly different number. So your answer depends on how
many strangers happened to be querying the same server at the same moment.
Nothing leaks between requests; the arithmetic simply takes a different route.

The fix is to write the arithmetic routines so they always add in the same order
regardless of group size, accepting some lost speed. He applies this to the
three routines that involve adding things up — the normalization step, the
matrix multiplications, and the attention mechanism — and shows the payoff: a
thousand runs of the same prompt that previously produced 80 different answers
now produce exactly one, at roughly 1.6 times the running time. A second payoff
lands in reinforcement learning, where the mismatch between the arithmetic used
to generate text and the arithmetic used to learn from it quietly corrupts
training; removing the mismatch entirely lets training proceed without the usual
corrective machinery.

## Key terms

- **Floating-point non-associativity** — the reason order matters at all.
  Fractional numbers are stored with a fixed budget of significant digits, so
  adding two numbers of very different magnitudes discards the small one's tail.
  Consequently `(a + b) + c ≠ a + (b + c)`. He notes the irony: "breaking
  associativity is what makes floating-point numbers useful," because the same
  mechanism is what lets one format span very large and very small values.
  Summing a four-element array and its negation in random order yields 102
  distinct results.
- **Run-to-run determinism** — the narrow property of getting bitwise identical
  output from the same kernel on the same inputs twice. He stresses that LLM
  forward passes already have this; it is not the property users are missing.
- **Atomic add** — a hardware primitive letting many independent processors
  accumulate into one location, with order determined by whichever finishes
  first. This is the mechanism the popular explanation blames. He shows it is
  "completely uninvolved": the forward pass of an LLM contains essentially none,
  because there is enough parallelism along the batch dimension, and because
  libraries adopted deterministic alternatives (split/tree reductions,
  semaphores) at negligible cost.
- **[Batch invariance](/beliefs/glossary/batch-invariance.md)** — the property
  the article is actually about: an element's numerical result does not change
  when the batch it sits in grows or shrinks. Mathematically it *should* hold,
  since batch elements are independent; empirically it does not. A `torch.mm` on
  one row versus the same row inside a 2048-row batch differs by up to 1669.
- **Batch-position invariance** — the weaker property of results not depending
  on *where* in the batch an element sits. Most matmul libraries have this even
  without batch invariance; the `stream-k` strategy lacks even this.
- **Reduction strategy** — how a summation is split across processors. Batch
  invariance breaks precisely when batch size changes this strategy, not when
  the strategy is merely complex.
- **Data-parallel strategy** — assigning each batch element (or output tile) to
  a single processor so its whole summation stays local. The default for all
  three reduction kernels, and naturally batch-invariant — until the batch gets
  small enough to leave processors idle.
- **Split-K matmul / split reduction** — splitting along the summed dimension to
  recover parallelism when the batch is too small. This is the specific move
  that destroys batch invariance.
- **Tensor-core instruction** — specialized matrix instructions operating on
  fixed-size tiles, each with its own internal accumulation order. Switching to
  a smaller instruction (or abandoning tensor cores at batch size 1) for
  efficiency is another batch-invariance break.
- **Split-KV / FlashDecoding** — the attention analogue of split-K, splitting
  along the key/value sequence. Unlike RMSNorm and matmul, attention genuinely
  needs it: during decoding the query length is tiny, so without it the GPU
  starves on long contexts.
- **Fixed split-size strategy** — He's remedy for attention: fix the *size* of
  each split and let the *count* vary, rather than the conventional inverse. A
  1000-element KV length becomes three 256-splits and one 232-split instead of
  four 250-splits, holding reduction order constant across query counts.
- **Chunked prefill / prefix caching** — inference optimizations that slice one
  sequence differently across calls. They mean batch invariance must hold not
  only across *how many requests* are processed but across *how each request is
  sliced*.
- **[vLLM](/beliefs/glossary/vllm.md) / FlexAttention / `torch.Library`** — the
  serving engine, the attention backend, and the operator-substitution mechanism
  used to build the demonstration without invasive changes.
- **On-policy RL** — reinforcement learning where the policy generating samples
  is the policy being trained. Numerical mismatch between sampler and trainer
  silently violates this.
- **Importance weighting / off-policy correction** — the corrective term that
  compensates for sampler-trainer divergence. Bitwise equivalence removes the
  need for it.

## Technical summary

The "concurrency + floating point" hypothesis — that GPU parallelism plus
non-associativity yields nondeterminism through order-dependent accumulation —
is widely repeated (He quotes an arXiv preprint and several other sources
asserting it) and is not the operative cause. Its falsification is immediate:
repeated `torch.mm` on identical bfloat16 inputs is bitwise stable across 1000
trials. The hypothesis's mechanism, atomic adds, is absent from the LLM forward
pass, since batch-dimension parallelism usually suffices and deterministic
split/tree reductions with semaphore ordering cover the rest at negligible cost.
(FlashAttention *backward* is the notable exception, and the Triton
implementation avoids atomics by recomputing at 40% more FLOPs.) Four statements
therefore hold simultaneously: some GPU kernels are nondeterministic; every
kernel in an LLM forward pass is deterministic; the server's forward pass is
deterministic; and the user still observes nondeterminism.

The resolution is that run-to-run determinism is not closure under composition.
The forward pass is deterministic *given its actual inputs*, but those inputs
include the concurrent batch. Kernels are not batch-invariant, so a request's
numerics are a function of server load — and load is nondeterministic from any
single user's vantage. Composing a property the kernel is not invariant to with
nondeterminism in that property yields a nondeterministic system. This is
architecture-independent: CPU and TPU endpoints inherit it.

Achieving batch invariance requires fixing reduction order in the three
reduction kernels; pointwise operations are already invariant. **RMSNorm**: the
data-parallel assignment of one row per core is invariant under growth (cores
loop over rows) but breaks under shrinkage, when a kernel engineer would reach
for split reductions to fill idle cores. **Matmul**: identical in structure, but
2D output tiling is forced by arithmetic intensity and tensor-core constraints,
so both split-K and instruction-size switching threaten invariance; compiling a
single kernel configuration for all shapes costs roughly 20% against cuBLAS in
an unoptimized Triton kernel, with losses concentrated at small batch sizes and
a jigsaw pattern from tile and wave quantization. **Attention** adds two
wrinkles: reduction spans the sequence dimension as well as the feature
dimension, and inference-engine slicing (chunked prefill, prefix caching) varies
how a sequence is presented. Handling cached and current K/V separately — as
vLLM's Triton attention kernel does — breaks invariance through block boundary
conditions, so the KV cache and page table must be updated *before* the kernel
runs. Attention cannot simply forgo split reductions the way RMSNorm and matmul
can, since decode-stage query length starves parallelism on long KV caches;
hence the fixed-split-size strategy, which requires unreleased FlexAttention
changes.

Empirically, Qwen3-235B-A22B-Instruct-2507 sampled 1000× at temperature 0 on
"Tell me about Richard Feynman" (1000 tokens each) yields **80 unique
completions**, the modal one occurring 78 times. Divergence is not gradual:
all 1000 share their first 102 tokens, splitting at token 103 where 992 continue
"Queens, New York" against 8 producing "New York City". With batch-invariant
kernels, all 1000 are identical. Cost on a single-GPU Qwen3-8B server over 1000
sequences: 26 s default, 55 s unoptimized deterministic, 42 s with the improved
attention kernel — attributed largely to vLLM's unoptimized FlexAttention
integration.

The RL result follows from bitwise sampler/trainer equivalence. In an RLVR setup
on Bigmath (policy initialized from Qwen 2.5-VL instruct 8B, 4096 max rollout),
training without importance weighting collapses — a loss spike near step 318
coinciding with a KL-divergence spike — while off-policy correction holds
logprob KL near 0.001 with occasional spikes. True on-policy training sits flat
at exactly 0 KL and needs no correction term.

He frames the conclusion as a rejection of numerical fatalism — the reflex to
loosen a failing test's tolerance or dismiss a trainer-sampler logprob gap
because the system is "already probabilistic": "We reject this defeatism. With a
little bit of work, we can understand the root causes of our nondeterminism and
even solve them!"

## Why it matters here

The bundle already carries this result as a
[glossary term](/beliefs/glossary/batch-invariance.md) and leans on it in the
[Inkling/BEAM swarm-eval analysis](/meta/analysis/inkling-beam-swarm-eval-substrate.md),
where bitwise-replayable rollouts are argued to be the property an eval
substrate for emergent multi-agent failures cannot do without — a failure you
cannot replay you cannot ablate. This capture supplies the mechanism behind that
claim, and sharpens its caveat: the guarantee is a property of the **inference
deployment**, not of the model or its weights, so it is forfeited on any shared
endpoint whose batch composition you do not control.

# Citations

- Horace He and Thinking Machines Lab, ["Defeating Nondeterminism in LLM
  Inference"](https://thinkingmachines.ai/blog/defeating-nondeterminism-in-llm-inference/),
  *Thinking Machines Lab: Connectionism*, 10 September 2025.
  doi:[10.64434/tml.20250910](https://doi.org/10.64434/tml.20250910)
- [`thinking-machines-lab/batch-invariant-ops`](https://github.com/thinking-machines-lab/batch-invariant-ops)
  — the released batch-invariant kernel library and the vLLM deterministic-mode
  example.
- [SGLang deterministic inference](https://www.lmsys.org/blog/2025-09-22-sglang-deterministic/)
  (22 September 2025) — the follow-on work extending determinism past greedy
  decoding via seeded sampling, cited in the bundle's existing glossary entry
  rather than in this article.
