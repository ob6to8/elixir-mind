---
id: em:ff1ed5
type: note
title: "SuperCollider non-realtime rendering: deterministic WAVs, one timing trap"
description: "scsynth's NRT mode renders a time-stamped OSC command file to a WAV deterministically, faster than realtime, with no audio hardware — but events quantise early to the 64-sample control-block boundary (≈1.3 ms at 44.1 kHz) unless blockSize is set to 1, which NRT can afford."
verified: false
provenance: "Session measurements, SuperCollider 3.13.0 on Ubuntu 24.04, 2026-07-28"
tags: [media-production, supercollider, nrt, rendering, timing, determinism]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T21:40:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "the render-side facts a headless or scripted music pipeline stands on, measured once and filed so they need not be re-measured"
---

# SuperCollider non-realtime rendering

`scsynth`, SuperCollider's synthesis server, has a **non-realtime (NRT) mode**
(`scsynth -N`): it reads a time-stamped OSC command file — synth definitions,
node creations, parameter changes, each at an explicit time — and writes the
rendered audio to a file, as fast as the CPU allows. Properties that make it
the natural render backend for scripted music production:

- **No audio stack.** Runs on machines with no soundcard, no JACK, no GUI —
  CI containers included (on a display-less Linux host, `sclang` needs
  `QT_QPA_PLATFORM=offscreen` and WebEngine sandbox flags to start; `scsynth`
  itself does not).
- **Deterministic.** The same command file renders the same samples; renders
  are reproducible and diffable by measurement.
- **Language-independent input.** The `.osc` command file is a plain binary
  format any program can emit; `sclang` is convenient for compiling
  `SynthDef`s but is not required to drive a render.

**The trap: control-block quantisation.** The server schedules events on
control-block boundaries, default 64 samples. Measured (SC 3.13.0): events at
off-block times land snapped *down* — early — by up to a full block, ≈1.3 ms at
44.1 kHz, while `blockSize 1` lands them sample-exactly. 1.3 ms is invisible
against picture but audible as flam/comb-filtering when a quantised render is
layered with sample-placed audio. NRT renders should set `blockSize 1`; the
realtime CPU objection to tiny blocks does not apply when nothing is realtime.
Measurement tables and reproduction scripts:
[the AV-production tutorial](/projects/code-driven-av-production/headless-supercollider-grid-render.md).
