---
id: sb:fd9873
type: concept
title: restricted Boltzmann machine
description: A two-layer undirected generative network (visible and hidden units) whose bipartite connectivity — no within-layer edges — makes the hidden units conditionally independent given the visible ones, so it can be trained efficiently.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, deep-learning, neural-networks, generative-models]
timestamp: 2026-07-12
---

# restricted Boltzmann machine

The "restricted" in the name is the bipartite constraint. It learns a probability distribution over its inputs, trained by [contrastive divergence](/beliefs/glossary/contrastive-divergence.md). Stacking RBMs is what builds a [deep belief network](/beliefs/glossary/deep-belief-network.md).

*Seen in:* [2026-07-12 deep-belief-networks research spike](/meta/threads/2026-07-12-deep-belief-networks-research-spike-and-refile.md)
