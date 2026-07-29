---
id: em:ee3948
type: reference
title: "Generating Sound & Organizing Time: Thinking with gen~ (Book 1)"
description: "Wakefield & Taylor's 2022 book teaching per-sample DSP in gen~ (Cycling '74): ten chapters running from the operator bestiary through ramp-based time, unit shaping, noise and chaos, binary/Euclidean sequencing, filters, delays, modulation synthesis, wavetables, and windowed/granular time — the full-text pedagogy behind this bundle's ramps-as-time and primitive-reduction concepts, captured here from the publisher's own table of contents."
resource: https://cycling74.com/books/go
provenance: "Distilled from the publisher's book page and table-of-contents PDF (fetched 2026-07-28), the authors' Cycling '74 interview, and the Google Books listing; the book body itself remains unread — the ResearchGate listing the operator supplied returns 403 to this environment"
tags: [media-production, dsp, gen, max-msp, book, rhythm, synthesis, sequencing]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T23:20:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked for the gen~ book itself to be filed, having earlier probed its approach of reducing DSP operations toward binary primitives"
---

# Generating Sound & Organizing Time: Thinking with gen~ (Book 1)

Graham Wakefield and Gregory Taylor, Cycling '74, 2022 (ISBN 9781732590311).
The publisher frames it as being about "the astonishing things you can do—and
the insights you can find—when you work at the atomic sample-by-sample
structure of digital audio." Wakefield wrote gen~ itself; the book is its
pedagogy — the applied companion to the operator-level design his
[course notes](/knowledge/media-production/audio-synthesis/wakefield-gen-course-notes.md)
document. Two of this bundle's concepts distill its central moves:
[the primitive reduction](/knowledge/media-production/audio-synthesis/gen-dsp-primitive-reduction.md)
and [ramps as time](/knowledge/media-production/sequencing/ramps-as-time.md).

# Structure

The table of contents (publisher's PDF, captured verbatim at chapter level):

1. **Patching One Sample at a Time** — what gen~ is; "A Bestiary of signals
   and operators"; the "go" library that accompanies the book.
2. **Modular (Arithmetic of) Time** — counting by sample frames, `phasor`,
   "Ramps as cyclical time", ramp clock multiplication/division, phase
   rotation, "Getting triggers from a cyclic ramp", musical ratios, modulating
   ramps with ramps. The chapter-length source of the ramp model.
3. **Unit Shaping** — "Swing and warping time", ramps → LFOs (triangles,
   sinusoids, pulses, trapezoids), easing and window functions, waveshaping,
   sigmoids.
4. **Noise, Uncertainty, and Unpredictability** — stepped/smooth random,
   Bernoulli gates, distributions, random walks, urn models, chaos (Lorenz),
   "adding natural looseness to a tempo clock".
5. **Stepping in Time and Space** — logic-gate step patterns, sample-and-hold,
   shift-register canons, "Sequencing algorithms with binary shift registers",
   xor pseudo-random sequences, binary decoding, "Integers as patterns",
   "Working with the bits of an integer", Euclidean rhythms as "digitized
   ratios" and Euclidean ramps, pitch quantization.
6. **Filters, Diagrams, and the Balance of Time** — one-pole, lowpass gate,
   allpass/phaser, biquads, trapezoidal/state-variable filters, slew limiting.
7. **The Effects of Delay** — feedback loops and their care (decay, DC,
   limiting, clicks), Doppler, comb and allpass-delay filtering, Karplus-style
   strings with damping.
8. **Frequent Modulations** — AM/RM/FM/PM, sidebands and harmonicity ratios,
   cascade and cross-coupled feedback modulation, aliasing and bandlimiting.
9. **Navigating Waves of Data** — 1D/2D/3D wavetables and morphing,
   band-limiting (sinc interpolation, mipmapping), wave terrains.
10. **Windows of Time** — hard/windowed sync, sub-sample accuracy, pulsar
    synthesis, polyphony, granulation, "Subsample-accurate events from phasor
    ramps", bandlimited saw with hard sync.

# What the structure settles

Two claims this bundle previously held on secondhand evidence are now
chapter-grounded. The ramp doctrine is confirmed as the book's backbone:
chapter 2 is entirely the arithmetic-of-time model, chapter 3 opens with time
warping, and even the granular techniques of chapter 10 derive
"subsample-accurate events from phasor ramps". And the phrase "reducing
operations down to binary primitives" turns out to have **two** correct
referents, not one: gen~'s *binary operators* (two-input arithmetic — arity,
per the [course notes](/knowledge/media-production/audio-synthesis/wakefield-gen-course-notes.md)),
and chapter 5's genuinely *binary-digit* sequencing — shift registers, xor
sequences, integers-as-patterns, bit manipulation, and Euclidean rhythms as
digitized ratios — where bitwise structure is itself the musical material.
The [DSL analysis](/projects/code-driven-av-production/gen-inspired-music-dsl.md)'s
arity-only correction was written before this TOC was obtained and is
narrowed accordingly.

# Citations

- Publisher's book page (resource): https://cycling74.com/books/go
- Table-of-contents PDF (publisher asset): https://us-east-1.graphassets.com/AYPey75xpR2CpIG3owsnAz/jP8gt3kT7KZT6qqX8o3g
- Authors' interview: https://cycling74.com/articles/generating-sound-and-organizing-time-an-interview-with-graham-wakefield-and-gregory-taylor-1
- Google Books listing: https://books.google.com/books/about/Generating_Sound_Organizing_Time.html?id=yvV4zwEACAAJ
- ResearchGate listing (operator-supplied; 403 to this environment): https://www.researchgate.net/publication/366394855_Generating_Sound_Organizing_Time_Thinking_with_gen_Book_1

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:ee3948">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-code-driven-av-production-and-declared-cadence (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:ee3948`]**

The mentions are all secondhand references to the book — no doc *is* the book, so this files as new. And the TOC contains a finding that corrects this session's own record: Chapter 5 ("binary shift registers", "using xor for pseudo-random sequences", "working with the bits of an integer") means your original "binary primitives" instinct had a real referent beyond operator-arity after all. Checking the survey register mention first:
