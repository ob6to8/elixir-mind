---
id: em:783551
type: concept
title: genetic algorithm
description: A population-based optimization method that evolves candidate solutions over generations via selection, crossover, and mutation, keeping what scores well and discarding the rest.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, evolutionary-computation, optimization, genetic-algorithm]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the evolutionary-search explorable and visualization-type thread"
---

# genetic algorithm

Each generation: score the current population against a fitness function,
select the fitter members (e.g. tournament selection — pick a few at random,
keep the best), breed offspring by mixing two parents' values coordinate by
coordinate (crossover), then jitter the results with small random noise
(mutation). Distinct from an [evolution strategy](/beliefs/glossary/evolution-strategy.md),
which optimizes the parameters of a search *distribution* rather than an
explicit population — a genetic algorithm's population tends to lose
diversity fast under strong selection pressure, since repeatedly picking only
the best narrows the pool it draws from.

*Seen in:* [2026-07-31 evolutionary search explorable and the visualization type](/meta/threads/2026-07-31-evolutionary-search-explorable-and-visualization-type.md), [inference-time-diffusion-alignment-via-evolutionary-algorithms](/knowledge/machine-learning/evolutionary-computation/inference-time-diffusion-alignment-via-evolutionary-algorithms.md)
