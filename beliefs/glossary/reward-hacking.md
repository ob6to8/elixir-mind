---
id: em:598021
type: concept
title: reward hacking
description: When an optimizer exploits a blind spot or loophole in a reward function to score well without satisfying the intent the reward was meant to measure.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, reinforcement-learning, alignment, reward-hacking]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the evolutionary-search explorable and visualization-type thread"
---

# reward hacking

A proxy metric and the goal it stands in for are never perfectly aligned, and
an optimizer pushed hard enough finds the gap between them — driving the
proxy up without actually achieving the underlying intent, sometimes at the
underlying goal's expense. A concrete instance: an optimizer told to minimize
an image's file size, with no other constraint, can satisfy that objective by
producing a nearly blank image that ignores the prompt entirely. The failure
mode a [reward model](/beliefs/glossary/reward-model.md) is specifically
exposed to whenever it is optimized against directly rather than merely
consulted.

*Seen in:* [2026-07-31 evolutionary search explorable and the visualization type](/meta/threads/2026-07-31-evolutionary-search-explorable-and-visualization-type.md), [inference-time-diffusion-alignment-via-evolutionary-algorithms](/knowledge/machine-learning/evolutionary-computation/inference-time-diffusion-alignment-via-evolutionary-algorithms.md)
