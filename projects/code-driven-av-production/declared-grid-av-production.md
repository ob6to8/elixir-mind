---
id: em:78d356
type: analysis
title: "Declared grids vs. measured timelines: what grounds code-driven AV production"
description: "Evaluates the shift from measuring a timeline (onset-detecting rendered audio to recover cut points) to declaring one (a BPM grid both audio and picture render from); finds the sync problem dissolves structurally, quantifies the error budget with in-container measurements (scsynth NRT is sample-exact at blockSize 1, 1.3 ms early at the default 64), and bounds the approach: it optimizes everything countable while judgment of sound and picture stays with the operator."
provenance: "Claude Code session, 2026-07-28 — SuperCollider measurements run live in the session container (Ubuntu 24.04, SC 3.13.0); the predecessor measured-pipeline account supplied by the operator; gen~ concepts from Wakefield's course notes (artificialnature.net/courses/gen/Gen.pdf, fetched 2026-07-28)"
tags: [projects, music, video, timing, supercollider, ffmpeg, nrt, architecture, analysis]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T21:10:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "operator asked for an analysis of the general concept behind the session's grid-driven music+video rendering findings"
---

# Declared grids vs. measured timelines

**Question.** A working pipeline already exists in which an agent edits video to
music by *measuring*: onset-detect a rendered stem in 5 ms slices → 53 hit
timestamps → 53 frame-accurate ffmpeg cuts. When the agent also *produces* the
music, should the timeline stay measured — or be declared up front, with music
and picture both rendered from it? What does declaring buy, and where does the
whole code-driven approach stop?

**Thesis.** Declaring the grid dissolves the synchronization problem rather
than solving it: audio and picture stop being two systems needing alignment and
become two renderings of one arrangement. The claim is grounded by measurement
— a SuperCollider non-realtime render lands events sample-exactly once one
default is overridden — and bounded by an honest limit: the approach optimizes
everything countable, and nothing else.

## Finding 1 — measurement is a workaround for not owning the timeline

The measured pipeline exists because the music arrived as an opaque rendered
WAV: onset detection recovers, with error, structure that the producing session
once had exactly. When the same system writes the music, recovering its own
timing by signal analysis is a round trip through the least reliable
representation. At 120 BPM the grid is closed-form — beat 0.5 s, bar 2.0 s,
sixteenth 0.125 s — and every kick, snare, and cut is an integer times
0.125 s. One arrangement structure, three renderers:

```
arrangement { bpm, grid_offset, bars, seed, samples, patterns, cut_rules }
        │
        ├──► SuperCollider NRT  → stems/*.wav  (+ beat.mid)
        ├──► cut-list builder   → ffmpeg chunks → picture.mp4
        └──► mux                → final.mp4
```

There is no sync step to get wrong; agreement is by construction. Onset
detection keeps exactly one job: analyzing *source material* the pipeline did
not generate (where does the jaw-harp attack sit inside this clip; does the
guide track carry a lead-in that becomes a global `grid_offset`).

## Finding 2 — the render path is sample-exact, measured, with one trap

Verified in-container (Ubuntu 24.04, SuperCollider 3.13.0, no audio hardware):
an 8-bar 120 BPM kick/snare score rendered via `Score.recordNRT` produced a
17.001 s WAV whose detected onsets deviate from the ideal grid by at most
5.2 ms — the onset detector's own 5 ms hop floor. The sub-millisecond truth
came from a second measurement: clicks at deliberately off-block times land
**snapped early to the 64-sample control-block boundary** (−1.3 ms) at the
default `blockSize`, and **exactly on target** at `blockSize 1`. Full tables
and reproduction scripts:
[the tutorial](/projects/code-driven-av-production/headless-supercollider-grid-render.md).

The error budget, ranked, with who cares:

| Source | Size | Audible? | Visible? |
|---|---|---|---|
| ffmpeg keyframe seek (`-ss` before `-i`) | up to ~500 ms | — | ruins cuts outright |
| onset-detection hop (analysis only) | 5 ms | measurement floor, not render error | no |
| scsynth block quantisation @ 64 | 1.3 ms, always early | yes — flam/combing against sample-placed layers | no (0.04 frame) |
| scsynth @ blockSize 1 | 0 samples | — | — |

The pattern generalizes: each subsystem has one default that silently costs
milliseconds, each is a one-line fix, and audio and picture have *different*
tolerance thresholds — a 1.3 ms error is invisible to the eye and audible to
the ear, a 40 ms error is one frame to the eye and a disaster to the ear.

## Finding 3 — a declared timeline upgrades from event lists to a ramp

Event lists (`kick at indices 0, 4, 8, 12`) are the trigger model. The stronger
form — the organizing idea of Wakefield & Taylor's *Generating Sound &
Organizing Time*, examined in
[the DSL analysis](/projects/code-driven-av-production/gen-inspired-music-dsl.md) —
is one continuous bar-phase ramp from which every rhythmic and visual event
derives by arithmetic: multiplication gives divisions and cut density, offsets
give swing and anticipation, non-integer multipliers give polymeter (an edit
cycling in 3 against music in 4), and slow drift of a multiplier gives phasing.
Because ffmpeg accepts expressions in filter parameters, the same ramp drives
*continuous* picture — zoom, speed, opacity — making cut points one consumer of
the timeline among several rather than the only product.

## Finding 4 — reproducibility is the compounding asset

The measured pipeline's revision property (every change a one-line edit and a
fast re-render) survives and strengthens, on three disciplines: every random
choice (sample selection) flows from a **seeded** RNG with the seed reported;
the arrangement is one config file, so "snare a 16th late" and "cuts on eighths
for the last eight bars" are single-line diffs; and the render emits **stems
and a MIDI file** alongside the mix, so the work is portable into a DAW the
moment taste demands tools this pipeline lacks.

## The boundary

The agent verifies numbers, and only numbers. It can prove a kick sits at
sample 4410; it cannot judge that the kick is boomy, the mix muddy, or the edit
slack at bar 40. Sample *classification* (picking a kick out of an unlabelled
folder by spectral centroid, zero-crossing rate, decay) is the single most
error-prone stage and warrants operator confirmation before rendering. The
working loop this implies is the division of labor: the machine produces
precisely-timed drafts in seconds; the operator listens, watches, and returns
adjustments as numbers.

**Judgment.** Declare the grid; reserve measurement for foreign material. The
arrangement structure becomes the single source of truth for both media, which
is precisely what makes a small timing language attractive — the question
[the DSL analysis](/projects/code-driven-av-production/gen-inspired-music-dsl.md)
takes up.
