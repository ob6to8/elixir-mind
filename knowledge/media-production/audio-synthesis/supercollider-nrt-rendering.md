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

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:ff1ed5">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-code-driven-av-production-and-declared-cadence (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:ff1ed5`]**  (co-feeds: `em:0b9d92`)

**SuperCollider, locally: yes — verified**

Everything below I ran in this container just now.

Installed SuperCollider 3.13.0 from Ubuntu's repos (`supercollider-server`, `supercollider-language`, no GUI packages). It needs two environment variables to start headless as root, or `sclang` aborts on Qt WebEngine:


Then I rendered 8 bars of the exact beat from my last message — synthesized kick and snare, four on the floor with backbeat, 120 BPM — via `Score.recordNRT`, which drives `scsynth` in **non-realtime mode**: no audio device, no soundcard, no clock. It renders as fast as the CPU allows and writes a file.

Result: `drums.wav`, 17.001 s, 44.1 kHz stereo, peak 1.000. I then ran the same 5 ms-RMS onset detector from your video pipeline over the render and compared every detected hit to the ideal 120 BPM grid — **max deviation 5.2 ms, which is the 4.99 ms analysis-hop quantisation floor, not render error.**

**The setting that matters**

`scsynth` schedules events to control-block boundaries, and the default block is 64 samples. I tested this by rendering clicks at deliberately off-block times and measuring where they actually landed:

| `blockSize` | Target 4410 | Target 8825 | Target 13240 | Error |
|---|---|---|---|---|
| 64 (default) | 4352 | 8768 | 13184 | **−1.27 to −1.32 ms** |
| 1 | 4410 | 8825 | 13240 | **0 samples** |

Every event lands *early*, snapped down to the preceding block. For picture sync 1.3 ms is nothing — 0.04 of a frame. For audio it isn't: layer a block-quantised SC render against a sample-placed one-shot bus and you get flam and comb filtering that you'll hear as a phasey kick and never diagnose. Set `ServerOptions.blockSize = 1` for NRT renders. It costs CPU you aren't using anyway, since nothing is running in realtime.

**How it slots into the video render**


Both branches consume the same ramp, so the drums and the cuts cannot disagree — there's no sync step to get wrong. And SC renders faster than realtime, so a full re-render after a parameter change is seconds.
