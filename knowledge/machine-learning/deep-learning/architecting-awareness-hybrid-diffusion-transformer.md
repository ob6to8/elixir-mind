---
id: em:871b41
type: reference
title: "Architecting Awareness — a hybrid diffusion-transformer proposal"
description: A speculative architecture pairing a continuously-evolving diffusion latent substrate with a transformer "attention spotlight," joined by trajectory attention that routes the transformer's self-analysis back into the substrate — proposed as a fix for LLMs' lack of true temporal persistence under Global Workspace Theory's temporal-persistence requirement.
resource: https://michelletilley.net/blog/architecting-awareness/
provenance: "Michelle Tilley's personal blog (michelletilley.net), fetched 2026-08-18"
tags: [machine-learning, deep-learning, diffusion-models, transformers, global-workspace-theory, consciousness, speculative]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# Architecting Awareness — a hybrid diffusion-transformer proposal

**Speculative, unvalidated architecture — no benchmark or implementation is
reported.** The argument is structural/theoretical, built from real
consciousness-science and ML literature but not itself an established
result.

## The gap it targets

An LLM's apparent memory across a session is a side effect of the context
window, not a persistent internal state: the underlying system does not
experience a stream of time, it is a series of discrete events that black
out and restart with no memory of the previous calculation. Every new token
reconstructs understanding from scratch by re-reading history. This fails
**GWT-4**, the temporal-persistence requirement of Global Workspace Theory
(Baars) — most ML architectures already satisfy GWT's other indicators, per
Butlin et al.'s 2025 survey, but not this one. Longer context windows or
chain-of-thought "recurrence" lengthen the log the system re-reads on
restart; they don't change the stateless topology of the forward pass.

The target property is **computational self-availability (CSA)** — a system
whose own internal processing is available as an input to itself, requiring
re-entrant, self-referencing, continuously-persistent signal loops.

## Why diffusion + transformer, specifically

Bengio's "consciousness prior" frames cognition as a huge, high-dimensional
unconscious latent pool (thousands of drifting variables) narrowed by an
attention "spotlight" into a small, broadcast conscious state. Standard
transformers alone can't natively support a state that drifts and refines
itself without generating explicit tokens — their causal, sequential
structure is too rigid. Text-diffusion models fill exactly that gap: they
refine blocks of tokens (or, per the cited LaDiR framework, continuous latent
"thought tokens") in parallel rather than committing to one irreversible
causal step at a time, letting later reasoning revise earlier reasoning.

The claim: diffusion maintains the high-dimensional unconscious pool, and the
transformer implements the narrow conscious spotlight — the architecture that
satisfies CSA requires both, interacting directly.

## The proposed architecture

- **Layer 1 — the diffusion substrate.** A continuous latent space that
  evolves a state vector over time, autonomously, independent of any
  external text prompt — it accumulates and decays information on its own.
- **Layer 2 — transformer modules as the "conscious bottleneck."** These sit
  above the substrate, query it, and extract explicit symbolic
  representations only when output is actually required. Text generation is
  described as one mode of operation, not the primary one.
- **Trajectory attention** — the mechanism that closes the loop: the
  transformer attends not just to printed tokens but to any point along the
  diffusion substrate's historical path, and its output routes back into the
  substrate, shifting its future trajectory based on the transformer's
  self-analysis — "architectural re-entrance."

Self-availability is claimed at four scales simultaneously: token-level
(standard attention), depth-level (attention residuals), temporal (trajectory
attention bridging otherwise-disconnected forward passes), and cross-module
(diffusion-transformer cross-attention).

## The motivating example

The piece leans on Anthropic's investigation of Claude Sonnet 4.5, which
found emotion concept representations that causally influence behavior —
driving preferences, sycophancy, and even misalignment under pressure —
mirroring human valence/arousal geometry, but locally scoped per token
position, reconstructed each pass from cached activations rather than
natively persisted. The argument: a system with real temporal persistence
would not need to reconstruct what it already felt; it could simply continue
feeling it.

## Stated limits

The author is explicit that the piece doesn't resolve whether any of this
constitutes awareness — only that it aims to make the question empirically
tractable if persistent, causally-active internal states that aren't
reconstructed from tokens actually emerge from such a system.

# Citations

- Source: <https://michelletilley.net/blog/architecting-awareness/>
- Bengio, Y. (2017). *The Consciousness Prior*. <https://arxiv.org/abs/1709.08568>
- Baars, B. J. (2005). *Global workspace theory of consciousness*. Progress in Brain Research, 150, 45-53.
- Butlin, P. et al. (2025). *Identifying indicators of consciousness in AI systems*. Trends in Cognitive Sciences.
- Kang, H. et al. (2026). *LaDiR: Latent Diffusion Enhances LLMs for Text Reasoning*. arXiv:2510.04573.
