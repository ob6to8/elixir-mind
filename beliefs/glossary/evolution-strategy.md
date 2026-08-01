---
id: em:d6c279
type: concept
title: evolution strategy
description: A population-based optimization method that maintains a probability distribution over candidate solutions and nudges its parameters toward higher-scoring regions, rather than evolving an explicit population through selection and crossover.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, evolutionary-computation, optimization, evolution-strategy]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the evolutionary-search explorable and visualization-type thread"
---

# evolution strategy

Each step, a population is sampled from the current search distribution
(commonly a Gaussian with a mean and covariance), scored, and used to nudge
the distribution's parameters toward the higher-scoring samples via a
natural-gradient-style update — with no explicit selection, crossover, or
mutation step the way a [genetic algorithm](/beliefs/glossary/genetic-algorithm.md)
has. That structural difference is also why it tends to sustain more
diversity over long optimization runs: there is no tournament-style pressure
that can be cranked up to collapse the distribution's spread.

*Seen in:* [2026-07-31 evolutionary search explorable and the visualization type](/meta/threads/2026-07-31-evolutionary-search-explorable-and-visualization-type.md), [inference-time-diffusion-alignment-via-evolutionary-algorithms](/knowledge/machine-learning/evolutionary-computation/inference-time-diffusion-alignment-via-evolutionary-algorithms.md)
