---
id: em:4956f3
type: reference
title: "Circles, Sines, and Signals"
description: "Jack Schaedler's interactive introduction to the Discrete Fourier Transform, teaching each concept — orthogonality, phasors, Euler's formula, frequency resolution — through a draggable D3.js widget the reader manipulates directly, rather than through equations read passively."
resource: "https://jackschaedler.github.io/circles-sines-signals/"
provenance: "Jack Schaedler, jackschaedler.github.io"
tags: [technical-communication, explorable-explanations, visualization, pedagogy, signal-processing, fourier-transform, d3js, interactive-media]
timestamp: 2026-07-31T00:00:00Z
attribution:
  when: 2026-07-31T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator wants to use this resource's interactive-teaching approach as a model for expressing equations in the evolutionary-algorithms diffusion-alignment paper"
---

# Circles, Sines, and Signals

An interactive, single-scroll introduction to the Discrete Fourier Transform
(DFT), by **Jack Schaedler**. It replaces the usual dense-notation approach
to digital signal processing with pages the reader manipulates directly —
built with D3.js, animation, and sound — on the explicit premise that
readers "learn concepts and absorb information *visually* instead of
linguistically," while deliberately avoiding interactivity for its own sake
after encountering Bret Victor's critique of gratuitous interaction.

## Structure

A roughly 30-page progression, each page one small idea, ending in the DFT
itself: `signals` → `discrete_signals` → `sampling` (×4) → `aliasing` →
`sine_wave_properties` → `coordinates` → `trig_review` → `sincos` →
`complex` → `euler` → `dotproduct` (×4) → `notation` → `dft_introduction` →
`dft_frequency` → `dft_walkthrough` → `dft_deeper` → `dft_leakage` →
`zeropadding` → `convolution` → `fft` → `conclusion`. Each page is a small,
self-contained widget-plus-prose unit rather than a chapter of continuous
exposition.

## The teaching mechanism, page by page

What makes this resource worth citing isn't the DFT content — it's *how*
each equation is made tangible. A sample of the pattern, from pages actually
fetched:

- **`sine_wave_properties`** — states the (non-obvious) fact that sine waves
  of different frequencies are always orthogonal regardless of phase, and
  that summing two sinusoids at the *same* frequency always yields another
  sinusoid at that frequency, and no other periodic signal has that
  property. Two widgets follow immediately: one with **phase-shift and
  frequency sliders** that computes the dot product live, so the reader
  watches it snap to zero except when the frequencies match; another with
  **phase and amplitude sliders on a second sine wave**, showing the summed
  frequency staying fixed no matter what the sliders do. The claim isn't
  argued — it's made falsifiable in real time.
- **`coordinates`** — introduces representations/bases/orthogonality through
  Cartesian vs. polar coordinates of a single point, with the conversion
  equations (`rotation = arctan(y/x)`, `length = √(x²+y²)`) shown as two
  *views of the same object*, priming the DFT as itself "just" a coordinate
  transform (time-domain ↔ frequency-domain) before the DFT is introduced at
  all.
- **`dotproduct`** — defines the dot product (`Σ a[n]·b[n]`) as "the main
  operation of the DFT," then gives a widget where the reader **drags a
  vector's endpoint** and watches the dot product value change continuously
  as the angle between the two vectors changes — sign flips, zero at
  perpendicular, maximum at parallel — turning "dot product measures
  similarity" from an assertion into something watched happening.
- **`euler`** — states Euler's formula (`e^(φi) = cos(φ) + sin(φ)i`) and
  visualizes `e^(φi)` as a point tracing the unit circle as `φ` varies,
  labeled explicitly as a **complex phasor** — a rotating vector — so the
  DFT's substitution of `cos − i·sin` for `e^(−φi)` reads as "the same
  rotating arrow," not a notational trick.
- **`dft_frequency`** — chains **five linked phasor widgets** the reader
  adjusts to build sawtooth and square waves from harmonically-related
  sine components, then shows a **draggable input-length slider** that
  visibly sharpens two adjacent frequency peaks from indistinguishable into
  separated — making the resolution/sample-count tradeoff (`bin frequency =
  k · sample_rate / N`) a thing the reader does, not a formula they read.

## The recurring move

Across every page fetched, the same shape recurs: **state the equation in
one line, then hand the reader a control over one of its variables and let
them watch the output change continuously.** The prose is short and never
carries the "aha" alone — the widget does, by making the relationship
between symbols and behavior directly manipulable rather than merely
described. This pattern is generalized (beyond DFT, beyond this resource)
in [explorable-explanations](/knowledge/knowledge-management/technical-communication/explorable-explanations.md).

## Relation to other captures

Intake'd at the operator's prompt alongside
[the diffusion-alignment evolutionary-algorithms paper](/knowledge/machine-learning/evolutionary-computation/inference-time-diffusion-alignment-via-evolutionary-algorithms.md),
as the model for whether that paper's equations could be taught the same
way.

# Citations

- Jack Schaedler, *Circles, Sines, and Signals* — <https://jackschaedler.github.io/circles-sines-signals/>
