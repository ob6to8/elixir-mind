---
id: em:d504b3
type: concept
title: "gen~"
description: "The sample-level DSP environment embedded in Max: patches (or GenExpr code) built from a small operator vocabulary are compiled to C-family code at each edit, enabling single-sample feedback that block-based signal chains cannot express."
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, gen, dsp, max-msp, compilation, audio]
sense: common
timestamp: 2026-07-28T22:40:00Z
attribution:
  when: 2026-07-28T22:40:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term anchors the 2026-07-28 code-driven AV production thread's book investigation and two filed concepts"
---

# gen~

Graham Wakefield's per-sample DSP compiler inside Max (Cycling '74): where
MSP processes blocks of samples through opaque objects, gen~ treats the patch
as "specification for a compiler", works one sample at a time, and exposes a
deliberately small operator set — under a hundred, dominated by two-input
arithmetic plus the one-sample `history` delay. Wakefield & Taylor's
*Generating Sound & Organizing Time* is its pedagogy. The bundle's distillations:
[the primitive reduction](/knowledge/media-production/audio-synthesis/gen-dsp-primitive-reduction.md)
(what the vocabulary is and why compilation makes it viable),
[ramps as time](/knowledge/media-production/sequencing/ramps-as-time.md) (its
trigger-free time model), and the verbatim
[course-notes capture](/knowledge/media-production/audio-synthesis/wakefield-gen-course-notes.md).

*Seen in:* [2026-07-28 code-driven AV production thread](/meta/threads/2026-07-28-code-driven-av-production-and-declared-cadence.md), [gen-inspired-music-dsl analysis](/projects/code-driven-av-production/gen-inspired-music-dsl.md), [declared-cadence-swarm-auditability analysis](/meta/analysis/declared-cadence-swarm-auditability.md)
