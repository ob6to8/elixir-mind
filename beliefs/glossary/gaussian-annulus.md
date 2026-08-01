---
id: em:9fd6fb
type: concept
title: Gaussian Annulus
description: The fact that a high-dimensional standard Gaussian's probability mass concentrates near a thin spherical shell at radius approximately the square root of the dimension, rather than spreading evenly or clustering near the mean.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, high-dimensional-geometry, probability, gaussian-annulus]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the evolutionary-search explorable and visualization-type thread"
---

# Gaussian Annulus

A counterintuitive consequence of high dimensionality: intuition from two or
three dimensions suggests random noise sits mostly near the origin, but as
dimension grows almost every sample's distance from the origin concentrates
tightly around `√d`, leaving the region near the mean nearly empty. Practical
consequence for anything that samples or perturbs high-dimensional Gaussian
noise — a [diffusion model](/beliefs/glossary/diffusion-model.md)'s latent
space among them — is that only transformations preserving distance from the
origin (such as a rotation) are guaranteed to keep a sample on this shell;
an arbitrary perturbation can push it into a region the model was never
trained on.

*Seen in:* [2026-07-31 evolutionary search explorable and the visualization type](/meta/threads/2026-07-31-evolutionary-search-explorable-and-visualization-type.md), [inference-time-diffusion-alignment-via-evolutionary-algorithms](/knowledge/machine-learning/evolutionary-computation/inference-time-diffusion-alignment-via-evolutionary-algorithms.md), [evolutionary-search-in-latent-space](/knowledge/machine-learning/evolutionary-computation/evolutionary-search-in-latent-space.md)
