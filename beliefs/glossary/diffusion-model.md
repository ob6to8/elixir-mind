---
id: em:cc8785
type: concept
title: diffusion model
description: A generative model that learns to reverse a gradual noising process, generating samples by iteratively denoising a starting point of pure noise.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, machine-learning, generative-models, diffusion-models]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the evolutionary-search explorable and visualization-type thread"
---

# diffusion model

Training corrupts real data by adding noise in small steps until nothing but
noise remains, and a network learns to predict and undo each step; generation
runs that learned reversal from a fresh random noise sample all the way back
to a clean output. A [generative model](/beliefs/glossary/generative-model.md)
like a GAN or VAE, but distinguished by this iterative denoising process
rather than a single forward pass — the resulting starting noise vector (the
"latent") is itself a meaningful object: nearby noise vectors tend to decode
to similar outputs, which is what makes searching or steering that noise
(rather than the model's weights) a viable way to influence the output.

*Seen in:* [2026-07-31 evolutionary search explorable and the visualization type](/meta/threads/2026-07-31-evolutionary-search-explorable-and-visualization-type.md), [inference-time-diffusion-alignment-via-evolutionary-algorithms](/knowledge/machine-learning/evolutionary-computation/inference-time-diffusion-alignment-via-evolutionary-algorithms.md)
