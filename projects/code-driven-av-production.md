---
id: em:2cbef7
type: project
title: Code-driven AV production
description: A scriptable music-and-video production pipeline — ffmpeg for frame-accurate picture cuts, SuperCollider in non-realtime mode for sample-accurate sound, both rendered from one declared timing grid — built and run on the operator's local machine, incubating here.
status: incubating
tags: [projects, music, video, dsp, supercollider, ffmpeg, gen, timing, dsl]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T21:10:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "operator asked for the session's verified findings on grid-driven music+video rendering to be written up as actionable documents runnable locally"
---

# Code-driven AV production

A production pipeline in which a music video's *edit* and its *music* are both
rendered by code from a single declared timing structure — no timeline UI, no
DAW in the render path. Picture cuts are executed by ffmpeg from a computed cut
list; drums and synthesized parts are rendered by SuperCollider's synthesis
server in non-realtime mode; both consume the same grid, so they cannot drift
apart. The system runs on the operator's macOS machine; this repo incubates its
design records, verified measurements, and research.

The predecessor workflow measured its timeline (onset-detecting a rendered stem
to recover 53 cut points); this system inverts that: the timeline is *declared*
first — at 120 BPM every event is an integer multiple of 0.125 s — and audio and
picture are two renderings of it.

## Design records

- [Recreating the headless SuperCollider grid render](/projects/code-driven-av-production/headless-supercollider-grid-render.md)
  — the runnable tutorial: install, render a verified 120 BPM beat to WAV with
  no audio hardware, measure that every hit is sample-exact, wire the result
  into ffmpeg.
- [Declared grids vs. measured timelines](/projects/code-driven-av-production/declared-grid-av-production.md)
  — the analysis grounding the whole approach: what declaring the grid buys,
  the measured error budget, and where the approach stops (it cannot hear).
- [A gen~-inspired music-programming DSL](/projects/code-driven-av-production/gen-inspired-music-dsl.md)
  — what the *Generating Sound & Organizing Time* reductions (small operator
  vocabulary, single-sample feedback, ramps instead of triggers) offer a DSL
  for timing/MIDI/automation and for DSP generation, and which half is worth
  building.

## Status and open ends

- **Incubating.** The render path is verified end to end for sound
  (SuperCollider NRT → WAV → onset-checked against the grid) inside a Linux
  container; local macOS recreation is the tutorial's job. The picture half
  (ffmpeg cut execution) is designed and its failure modes are catalogued, but
  has not been run against real footage.
- **Knowledge filed.** The generalizable findings live in
  [knowledge/media-production](/knowledge/media-production/index.md), per the
  split rule:
  [ramps as time](/knowledge/media-production/sequencing/ramps-as-time.md),
  [the gen~ primitive reduction](/knowledge/media-production/audio-synthesis/gen-dsp-primitive-reduction.md)
  (both grounded in the
  [Wakefield course-notes capture](/knowledge/media-production/audio-synthesis/wakefield-gen-course-notes.md)),
  [SuperCollider NRT rendering](/knowledge/media-production/audio-synthesis/supercollider-nrt-rendering.md),
  and [ffmpeg frame-accurate assembly](/knowledge/media-production/video-editing/ffmpeg-frame-accurate-assembly.md).
- **Next decision.** Whether to commit to building the timing DSL the
  [DSL analysis](/projects/code-driven-av-production/gen-inspired-music-dsl.md)
  recommends; committing graduates that analysis's sketch into a `type: plan`
  here.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:2cbef7">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-code-driven-av-production-and-declared-cadence (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:2cbef7`]**  (co-feeds: `em:78d356`)

**The architecture: one arrangement, three renderers**


The video-only pipeline derived timestamps from audio via onset detection, which carries measurement error. Here the grid is *declared*, so the cuts land on the same integers the kick does by construction. No drift, no rounding disagreement between the two halves.
