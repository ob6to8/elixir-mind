---
id: em:da2ffb
type: reference
title: "Inference-time alignment of diffusion models via evolutionary algorithms"
description: "A black-box inference-time alignment framework that searches a diffusion model's initial latent noise — or an orthonormal rotation of it — with genetic algorithms and evolution strategies to maximize a reward objective, gaining 3-35% higher ImageReward than gradient-based/free baselines at 55-76% less GPU memory."
resource: "https://arxiv.org/abs/2506.00299"
provenance: "Purvish Jajal, Nick John Eliopoulos, Benjamin Shiue-Hal Chou, George K. Thiruvathukal, James C. Davis, Yung-Hsiang Lu; arXiv:2506.00299v2, 25 Nov 2025"
tags: [machine-learning, evolutionary-computation, diffusion-models, genetic-algorithms, evolution-strategies, inference-time-alignment, generative-models, latent-space-search]
timestamp: 2026-07-31T00:00:00Z
attribution:
  when: 2026-07-31T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator wants to explore whether this paper's equations can be taught through interactive visualization modeled on circles-sines-signals"
---

# Inference-time alignment of diffusion models via evolutionary algorithms

**Purvish Jajal, Nick John Eliopoulos, Benjamin Shiue-Hal Chou, George K.
Thiruvathukal, James C. Davis, Yung-Hsiang Lu** (Purdue / Loyola Chicago),
arXiv:2506.00299v2, 25 Nov 2025. *(Summarized — full paper and appendix at the
resource link.)*

## Summary

Diffusion models like Stable Diffusion turn noise into images, but the raw
output often doesn't satisfy what you actually want from it — safety
constraints, a particular aesthetic, or fidelity to a prompt. The usual fixes
either need to reach inside the model and compute gradients through it
(expensive, and impossible for objectives that aren't differentiable) or need
a large compute budget to search around its outputs. This paper's approach
treats the diffusion model as a sealed black box and never touches its
weights or internals. Instead, it exploits a simple fact: a diffusion model
is a (near-)deterministic function from a starting noise vector to an image,
so different starting points produce different images — some of which score
far better on a target metric ("reward") than others. The problem becomes:
search the space of possible starting noise vectors for one that produces a
high-reward image.

That search is framed as an evolutionary-computation problem. A **genetic
algorithm** variant keeps an explicit population of candidate noise vectors,
scores each by generating its full image and reading off the reward, then
selects the best performers, mixes pairs of them, and jitters the results —
repeating for many generations. An **evolution-strategies** variant instead
keeps a whole probability cloud over candidate vectors and nudges the cloud's
parameters toward higher-scoring regions, without an explicit
selection/crossover/mutation cycle. The one geometric wrinkle both have to
respect: in the very high dimensions these latents live in, "random noise" is
not spread everywhere — it concentrates almost entirely on the surface of a
thin sphere, and a candidate that drifts off that sphere produces garbage
images. So the search methods are built to stay on it, sometimes by only ever
*rotating* the noise (a rotation preserves distance from the center) and
sometimes by keeping mutation steps small. Across four different reward
objectives, this out-scores both the gradient-based competitor and simpler
black-box baselines per unit of compute and memory, though — as the authors
are explicit about — its advantage shrinks over very long searches, where
gradient-based methods start to catch up.

## Key terms

- **Diffusion model** — a generative model that produces samples (typically
  images) by iteratively denoising a starting noise vector; treated here as
  an opaque function `x = f_θ(ψ)` from noise/control input `ψ` to output `x`.
- **Inference-time alignment** — steering a *pretrained* model's output
  toward some objective without changing its weights, as opposed to
  fine-tuning or RLHF-style training.
- **Control variable (`ψ`)** — whatever an inference-time method is allowed
  to adjust. In this paper it's either the initial latent noise vector itself
  or an affine transform applied to a fixed base noise.
- **Reward function (`R(x)`)** — a scalar score an output is judged against.
  The paper evaluates four: **ImageReward** and **HPSv2** (learned
  human-preference models), **CLIP score** (text-image alignment), and
  **JPEG file size** (a compressibility proxy, minimized).
- **Search distribution (`q_ϕ`)** — a probability distribution over
  candidate control variables `ψ`, whose parameters `ϕ` are what the
  optimizer actually updates. Reframing "find the best `ψ`" as "find the best
  `ϕ` of a distribution over `ψ`" is what lets genetic algorithms and
  evolution strategies share one objective (see Eq. 2 below).
- **Genetic algorithm (GA) / CoSyNE** — maintains an explicit population
  `{ψ_i}`, and evolves it each generation via **selection** (keep the
  fitter), **crossover** (uniform crossover — swap each coordinate
  independently between two parents), and **mutation** (add small Gaussian
  noise). CoSyNE (Cooperative Synapse Neuroevolution) is the specific GA
  variant tested, via the EvoTorch library.
- **Evolution strategy (ES) / PGPE, SNES** — maintains the *parameters* of a
  continuous search distribution (e.g. a Gaussian's mean and covariance)
  rather than a discrete population, and updates them via a natural-gradient
  estimate of expected reward — no explicit crossover or mutation step, and
  no backpropagation through the diffusion model. PGPE and SNES are the two
  variants tested.
- **Gaussian Annulus (shell) phenomenon** — in high dimensions, almost all of
  a standard Gaussian's probability mass concentrates near a thin spherical
  shell at radius `≈√d`, not near the mean. A diffusion model trained on such
  noise implicitly relies on inputs staying near that shell.
- **Noise Transformation Search** — rather than searching the noise vector
  directly, search an **orthonormal rotation matrix** (obtained via QR
  decomposition) applied to a fixed base noise vector — a move that, by the
  rotational invariance of the Gaussian, structurally guarantees the result
  stays on the shell.
- **Reward hacking** — the optimizer exploiting a blind spot in the reward
  function rather than satisfying the intent behind it, e.g. driving JPEG
  size down by producing a nearly monochromatic image that ignores the
  prompt entirely.

## Technical summary

The paper casts inference-time alignment generally as

```
ψ* = argmax_{ψ ∈ Ψ}  E_{x ~ p_θ(x|ψ)} [ R(x) ]                    (Eq. 1)
```

— find the control variable `ψ` in the admissible space `Ψ` that maximizes
the expected reward of samples drawn from the frozen model `p_θ(x|ψ)`. Its
own contribution generalizes this to a **search over a distribution of
control variables** rather than a single point:

```
ϕ* = argmax_ϕ  E_{ψ ~ q_ϕ(ψ)} [ E_{x ~ p_θ(x|ψ)} [ R(x) ] ]        (Eq. 2)
```

GAs and ES are then two different ways of representing and optimizing `q_ϕ`:
a GA's `ϕ` is (implicitly) its current population, an ES's `ϕ` is explicit
distribution parameters (mean `μ`, covariance `Σ`). Both instantiate the same
outer loop (**Algorithm 1**, Direct Noise Search): sample a population of
`ψ_i` from `q_ϕ`, generate the corresponding images `x_i = f_θ(ψ_i)`, score
them `r_i = R(x_i)`, then run an algorithm-specific `EAUpdate` — GA's
selection/crossover/mutation, or ES's natural-gradient step on `μ, Σ` — to
produce the next `q_ϕ`.

The second solution space, **Noise Transformation Search** (**Algorithm 2**),
instead searches an affine map `z'_T = A z_T + b` applied to a fixed base
noise `z_T`, with `b` fixed to 0 and `A` constrained to its orthonormal
component `Q(A)` (via QR decomposition) — so `ψ = A` and `z'_T = Q(A) z_T`.
Because rotations preserve the Gaussian's shell structure, this variant is
shell-safe by construction, independent of step size.

Two mechanisms handle the **shell-confinement problem** for the variants
that aren't structurally safe by construction:

- **GA mutation** is small-step additive Gaussian noise, `x = x + ε, ε ~
  N(0, σ)` with `σ ≈ 0.1` in practice — gentle enough not to push offspring
  off the shell.
- **GA crossover is provably shell-preserving.** The paper proves (Sec. B.5)
  that uniform crossover — flip an independent `Bernoulli(p)` coin per
  coordinate `i` to choose which parent's value `X_i` or `Y_i` the child
  inherits — yields a child `Z` with `Z_i ~ N(0,1)` per coordinate (by the
  law of total probability: `P(Z_i≤z) = pΦ(z) + (1-p)Φ(z) = Φ(z)`), hence
  `Z ~ N(0, I_d)` overall: children of two shell-resident parents remain, in
  distribution, on the shell too.
- **ES initialization** is the trickiest case: naively starting `q_ϕ` at
  `μ=0, Σ=I` and letting the natural-gradient update run quickly drifts the
  distribution off the shell (Fig. 7), degrading sample quality. The fix is
  to center `μ` on an already-shell-resident point `z_0 ~ N(0,I)` with a
  small initial covariance `σ_0 I`, rather than the isotropic default.

Evaluated on Stable Diffusion 1.5 (with SD3 and PixArt-α ablations) across
DrawBench and Open Image Preferences prompts, against gradient-based DNO,
white-box gradient-free methods (SVDD, DSearch-R, FKS), and simple black-box
baselines (Best-of-N, Zero-Order): the paper's methods reach **3–35% higher
ImageReward** than baselines at equal or lower runtime, using **55–76% less
GPU memory** and running **72–80% faster** than the gradient-based baseline,
which additionally hits GPU out-of-memory at batch sizes ≥16 where the
evolutionary methods scale gracefully. CoSyNE (GA) dominates at short
optimization horizons (its population's reward variance collapses quickly
under selection pressure — high early exploration, fast convergence), while
SNES (ES) sustains diversity longer and is more competitive at long
horizons. The two families are also composable with weight-based alignment:
stacking CoSyNE on a Diffusion-DPO fine-tuned model raises ImageReward
further than either technique alone.

The authors are explicit about where the approach loses: over very long
optimization horizons, white-box gradient-based methods are "likely" to
retain the advantage in pure reward maximization, and effectiveness varies
by the underlying diffusion model — gains largely vanish on PixArt-α (an LCM
variant), suggesting some latent spaces are more "searchable" than others,
which the authors pose as an open question for future model design. Reward
hacking shows up concretely: PGPE minimizing JPEG size consistently produces
near-monochromatic, prompt-ignoring images, a documented failure mode of
optimizing a proxy too hard. No diffusion forward/reverse-process equations
(noise schedules, score-matching loss, DDPM/DDIM updates) appear anywhere in
the paper — the model stays a black box throughout, and the four reward
functions themselves are treated as external, cited scoring functions rather
than derived formulas.

## Relation to other captures

Five of this paper's claims are manipulable directly in
[Evolutionary search in a diffusion model's latent space](/knowledge/machine-learning/evolutionary-computation/evolutionary-search-in-latent-space.md)
— the Gaussian shell, the rotation invariance, the crossover proof, the
GA/ES diversity contrast, and reward-as-similarity.

Intake'd alongside
[Circles, Sines, and Signals](/knowledge/knowledge-management/technical-communication/circles-sines-signals.md)
and the
[explorable-explanations methodology](/knowledge/knowledge-management/technical-communication/explorable-explanations.md)
it fed, at the operator's prompt: whether this paper's equations — the
Gaussian-shell geometry, the GA-vs-ES population dynamics, the
rotation-preserves-the-shell argument — could be taught the way that
resource teaches the Discrete Fourier Transform, through direct manipulation
rather than static notation.

# Citations

- Jajal, Eliopoulos, Chou, Thiruvathukal, Davis, Lu, "Inference-Time
  Alignment of Diffusion Models via Evolutionary Algorithms," arXiv:2506.00299v2,
  25 Nov 2025 — <https://arxiv.org/abs/2506.00299>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:da2ffb">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-31-evolutionary-search-explorable-and-visualization-type (2026-07-31)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:da2ffb`]**  (co-feeds: `em:4956f3 em:e12137`)

Filed and pushed. Here's the rundown.

Both sources are in the brain now, and I used them together to actually test the idea instead of just speculating about it: I distilled the teaching *mechanism* Circles, Sines, and Signals uses into a reusable method, then ran the evolutionary-algorithms paper's own equations through it. They map directly — not approximately. The paper's real content (a rotation that keeps noise on a probability "shell," a population's diversity collapsing over generations, a reward function that's really a similarity measure) is exactly the kind of *relationship-in-motion* that resource's drag-a-slider approach is built for, not decoration bolted onto static notation.
