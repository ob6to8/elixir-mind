---
id: em:7eb410
type: concept
title: non-realtime rendering
description: "Rendering audio by processing a time-stamped command file as fast as the CPU allows and writing the result to disk, rather than computing samples against a live audio clock — deterministic, hardware-free, and faster than realtime."
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, nrt, rendering, audio, supercollider, determinism]
sense: common
timestamp: 2026-07-28T22:40:00Z
attribution:
  when: 2026-07-28T22:40:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the render mode every verified measurement in the 2026-07-28 code-driven AV production thread runs through"
---

# non-realtime rendering

Abbreviated **NRT**. The mode inverts the usual audio contract: instead of a
server racing a soundcard clock, the full event schedule is known up front, so
the renderer consumes it offline — no audio device, reproducible output,
wall-clock bound only by CPU. This is what lets a headless container (or a CI
job) produce and verify music. The bundle's operational facts — SuperCollider's
`scsynth -N`, the `.osc` command-file format, and the `blockSize 1` setting
that makes event timing sample-exact — are filed in
[SuperCollider non-realtime rendering](/knowledge/media-production/audio-synthesis/supercollider-nrt-rendering.md).

*Seen in:* [2026-07-28 code-driven AV production thread](/meta/threads/2026-07-28-code-driven-av-production-and-declared-cadence.md), [headless-supercollider-grid-render tutorial](/projects/code-driven-av-production/headless-supercollider-grid-render.md), [declared-grid-av-production analysis](/projects/code-driven-av-production/declared-grid-av-production.md)
