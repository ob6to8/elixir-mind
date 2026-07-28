---
id: em:b50c01
type: concept
title: "Ramps as time: derive events from a phase, don't schedule triggers"
description: "The time model gen~ enforces and Wakefield & Taylor's book builds on: represent musical time as a continuous 0→1 phase ramp and derive every event — beats, subdivisions, swing, polymeter, phasing, and non-audio consumers like video cut points — by arithmetic on that phase, instead of scheduling discrete trigger events one by one."
verified: true
verified_by: [em:98a026]
provenance: "Distilled from Wakefield's Gen course notes and the Cycling '74 authors' interview for Generating Sound & Organizing Time"
tags: [media-production, sequencing, timing, gen, phasor, rhythm, mental-model]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T21:40:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "the organizing idea behind grid-driven AV rendering and the proposed timing DSL; filed so future sequencing work starts from the ramp model rather than rediscovering it"
---

# Ramps as time: derive events from a phase, don't schedule triggers

Two representations of musical time compete. The **trigger model** stores
events — a list of timestamps or sixteenth-indices per bar — and plays them
back. The **ramp model** stores one continuous function — a phase that cycles
0→1 per bar (a phasor) — and *derives* events from it by arithmetic. gen~
enforces the ramp model by construction ("No messages means no [trigger] etc.;
use 0/1 signals" — the
[course notes capture](/knowledge/media-production/audio-synthesis/wakefield-gen-course-notes.md)),
and Wakefield & Taylor's *Generating Sound & Organizing Time* develops it into
a full rhythm pedagogy: starting from a ramp, sample-accurate rhythms, swing,
divisions and ratchets, polymeter, and phasing (per the authors'
[interview](https://cycling74.com/articles/generating-sound-and-organizing-time-an-interview-with-graham-wakefield-and-gregory-taylor-1),
paraphrased).

The derivations are one-liners because rhythmic structure *is* modular
arithmetic:

| Operation on the phase | Result |
|---|---|
| multiply by k, wrap | k-fold subdivision; ratchets |
| add a constant | swing, offset, anticipation |
| multiply by a non-integer | polymeter (k against the base cycle) |
| drift a multiplier slowly | phasing |
| warp the ramp nonlinearly | accelerando, rubato |
| threshold / edge-detect | discrete events, when actually needed |
| leave continuous | LFOs, envelopes, automation curves |

What the trigger model makes laborious, the ramp model makes parametric: a
pattern in 3 against 4 is the digit 3, not a hand-placed event list that only
coheres in aggregate.

Two properties give the model reach beyond audio:

- **Events and automation unify.** A ramp thresholded yields events; left
  continuous it is an automation curve. One representation feeds both
  consumers, so they cannot drift apart.
- **Any timeline consumer can subscribe.** Nothing in the model is
  audio-specific — video cut points, zoom/speed curves, lighting cues are
  derivations of the same phase, inheriting the same swing, polymeter, and
  phrase structure as the music. Time is data, and a single declared phase is
  the one clock every renderer reads.
