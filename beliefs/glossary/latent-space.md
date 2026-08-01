---
id: em:9c0e16
type: concept
title: latent space
description: The internal, learned coordinate space a generative model maps inputs into or samples from, where proximity between points tends to correspond to similarity between the outputs they produce.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, machine-learning, generative-models, latent-space]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the evolutionary-search explorable and visualization-type thread"
---

# latent space

Not directly observed in the training data — it's the compressed internal
representation a model constructs, whose geometry the model itself learns.
Because nearby points tend to decode to similar outputs, the space can be
searched, interpolated, or perturbed as a way of steering what a
[generative model](/beliefs/glossary/generative-model.md) produces without
touching its weights; a [diffusion model](/beliefs/glossary/diffusion-model.md)'s
starting noise vector is one instance, and its geometry is not uniform — see
the [Gaussian Annulus](/beliefs/glossary/gaussian-annulus.md) for the
concentration effect that shapes what a valid perturbation looks like there.

*Seen in:* [2026-07-31 evolutionary search explorable and the visualization type](/meta/threads/2026-07-31-evolutionary-search-explorable-and-visualization-type.md), [inference-time-diffusion-alignment-via-evolutionary-algorithms](/knowledge/machine-learning/evolutionary-computation/inference-time-diffusion-alignment-via-evolutionary-algorithms.md)
