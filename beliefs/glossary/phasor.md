---
id: em:094aff
type: concept
title: phasor
description: "A signal that ramps linearly from 0 to 1 and wraps, cycling at a set rate — the continuous representation of cyclical time from which rhythmic events, subdivisions, and automation curves are derived by arithmetic."
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, phasor, ramp, timing, sequencing, dsp]
sense: common
timestamp: 2026-07-28T22:40:00Z
attribution:
  when: 2026-07-28T22:40:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the primitive underlying the ramps-as-time model the 2026-07-28 thread filed and built on"
---

# phasor

The workhorse of ramp-based sequencing: one phasor per cycle (a bar, a round,
a loop) makes time itself a value every consumer can compute against —
multiply it for subdivisions, offset it for swing, threshold it for discrete
events, or use it raw as an LFO or automation curve. The full model, its
operation-to-musical-result table, and its reach beyond audio (video cuts,
orchestration cadence) are filed as
[ramps as time](/knowledge/media-production/sequencing/ramps-as-time.md).

*Seen in:* [2026-07-28 code-driven AV production thread](/meta/threads/2026-07-28-code-driven-av-production-and-declared-cadence.md), [gen-inspired-music-dsl analysis](/projects/code-driven-av-production/gen-inspired-music-dsl.md)
