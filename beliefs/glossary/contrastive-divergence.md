---
id: sb:e1e447
type: concept
title: contrastive divergence
description: A fast approximate training algorithm for restricted Boltzmann machines that updates weights from a short (often single-step) Gibbs-sampling run instead of the intractable exact maximum-likelihood gradient.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, deep-learning, machine-learning, training]
timestamp: 2026-07-12
---

# contrastive divergence

Introduced by Hinton, and applicable to [restricted Boltzmann machines](/beliefs/glossary/restricted-boltzmann-machine.md) and similar energy-based models generally. The Gibbs chain is started at the training data rather than run to equilibrium, trading exactness for speed. It is the per-layer learning step inside [greedy layer-wise pretraining](/beliefs/glossary/greedy-layer-wise-pretraining.md).

*Seen in:* [2026-07-12 deep-belief-networks research spike](/meta/threads/2026-07-12-deep-belief-networks-research-spike-and-refile.md)
