---
id: em:6d4051
type: reference
title: "Numerology: generative MIDI sequencing via CV-style modular routing"
description: Five12's modular MIDI/CV sequencer app — cell-based generator algorithms, X/Y/Z Evolve transformations, and a CV/Gate/Clock/Audio signal-routing model borrowed directly from analog modular synthesis, applied to pattern generation rather than raw audio DSP.
resource: https://files.five12.com/Numerology4Manual.pdf
provenance: "Five12 Inc., Numerology 4 User Documentation, v4.0, October 2014"
tags: [media-production, sequencing, generative-music, midi, modular, algorithmic-composition, cv]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# Numerology: generative MIDI sequencing via CV-style modular routing

Numerology (Five12) is a modular MIDI/CV sequencing environment, not a
plugin built around one fixed step grid. Its note sequencers (MonoNote,
PolyNote, ChordSeq, DrumSeq, MatrixSeq) sit on top of a signal-routing layer
explicitly modeled on analog modular synthesis (Moog/Buchla-style Control
Voltage), and that layer is what makes the generative features possible.

## The signal model

Four stream types move between modules on a patchable back panel: **Clock**
(high-resolution absolute beat position, fed to every sequencer), **CV**
(control-rate floats, with named sub-types — Gate: on/off at 0.0/1.0;
Trigger: the off-to-on edge of a gate; Modulation: arbitrary-range CV; Pitch
Interval: semitone offsets, not absolute note numbers — several interval
streams can be summed, e.g. a per-eighth-note melody stream added to a
per-bar chord-change stream, then quantized together), **Audio**, and
**MIDI** (internally floating-point rather than 7-bit, for resolution).
Modules connect via drag-routing or bus references (Bus A-H); Numerology
auto-connects Clock and obvious MIDI/Audio chains but leaves CV routing
manual. Feedback connections (routing a module's output back to an earlier
module's input) are explicitly supported as a one-render-pass delay, not an
error condition. Parameter Modulation is a second, orthogonal communication
channel — any CV source can drive almost any module parameter directly (not
just a signal-typed port), analogous to DAW automation lanes.

## What makes it generative: cell-based Generate & Evolve

**Generate** and **Evolve** are the two features that separate this from a
plain step sequencer. Both apply small, partly-randomized musical
transformations rather than placing individual steps by hand:

- **Cells.** A generator algorithm picks a short phrase length (2-8 steps, a
  "cell"), fills only specific parameters of that cell (pitch, gate length,
  velocity, step length), then copies the cell out to the sequence's full
  length either by strict repetition (`1,2,3,1,2,3,1,2`) or irregular
  repetition — the same cell copied with per-copy length variation
  (`1,2,3,1,2,1,2,3`), explicitly credited to early minimalist-composition
  technique. Cells can also be reversed, inverted around a center value, or
  transposed on each copy.
- **Named generator presets** apply this recipe with musical-style targets —
  `Acid01`/`Acid02` (16th notes, octave/fifth-weighted vs. dissonant pitch
  emphasis), `Berlin01` (major-chord-tone weighting), `Minmal`, `Obliq`, plus
  pure-randomization presets (`RndFew`/`RndSome`/`RndMost`/`RndAll`). A
  generator only touches the parameters it needs — direction, key, octave,
  quantization, mute/skip steps, and sequence length are left for the user
  to set before or after running it, so algorithm and manual editing compose
  rather than compete.
- **Evolve** is Generate's smaller-magnitude sibling: it nudges an existing
  running pattern rather than generating a new one, via named
  transformations ("swap two pitch values", "move one step a minor third")
  grouped into three independently-configurable dimensions (X/Y/Z, each up
  to 8 transformations with a per-transformation probability), triggerable
  manually, on a bar/beat timer ("auto evolve"), or via Parameter Modulation
  for event-driven triggering.

## Contrast with a plain step sequencer

A plain step sequencer is a fixed grid the user populates by hand, one value
per cell. Numerology's note sequencers are such a grid underneath, but three
things sit above it: algorithmic population of that grid from a small cell
primitive plus controlled indeterminacy; an explicit CV/Gate/Trigger
patching layer beneath the sequencer, so a pitch-interval stream, a gate
stream, and a modulation stream can each come from a different generator and
be summed/routed independently; and a live-evolution mechanism that keeps
mutating an already-running pattern in small, probability-weighted steps
rather than requiring a full regeneration.

## Relation to this bundle's time model

Numerology's note sequencers are squarely on the trigger-list side of
[Ramps as time](/knowledge/media-production/sequencing/ramps-as-time.md)'s
trigger-vs-ramp dichotomy — pitch/gate/velocity values live at discrete step
indices, not derived by arithmetic on a continuous phase. What Numerology
adds on that side of the divide is algorithmic population and mutation of
the trigger list (cells, irregular repetition, Evolve), which the ramp model
achieves differently — by parametric arithmetic on the phase itself. The two
are complementary sequencing paradigms rather than competitors.

# Citations

- Five12 Inc., *Numerology 4 User Documentation*, v4.0, October 2014 — <https://files.five12.com/Numerology4Manual.pdf> (chapters 9-12: Signals, Routing, Parameter Modulation, Generate & Evolve)
