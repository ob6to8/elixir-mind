---
id: em:708db6
type: analysis
title: "A gen~-inspired music-programming DSL: timing first, DSP by backend"
description: "Asks what a music-programming DSL modeled on the reductions in Wakefield & Taylor's Generating Sound & Organizing Time would offer for timing (MIDI, automation, cut lists) versus DSP generation; finds the book's real transferable asset is ramps-as-time rather than the primitive operator set, that the DSP-DSL space is already well occupied (SuperCollider UGen graphs, Faust, gen~ itself), and that the differentiated, buildable artifact is a small non-realtime timing DSL — one phase function compiled to MIDI, SuperCollider NRT scores, and ffmpeg cut lists/automation alike."
provenance: "Claude Code session, 2026-07-28 — gen~ operator-set and feedback quotes extracted verbatim from Wakefield's course notes PDF (artificialnature.net/courses/gen/Gen.pdf, via pdftotext); book framing from the publisher description (Google Books) and the Cycling '74 authors' interview (paraphrased — full book text was not accessible); prior-art DSL landscape from training knowledge, marked in place"
tags: [projects, dsl, music, dsp, gen, supercollider, midi, timing, language-design, analysis]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T21:10:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "operator asked what a DSL for music programming based on the gen~ book's approach might make possible, for timing/MIDI/automation and for DSP generation"
---

# A gen~-inspired music-programming DSL

**Question.** Wakefield & Taylor's *Generating Sound & Organizing Time:
Thinking with gen~* teaches DSP by reduction to small primitive operations.
What would a music-programming DSL built on those reductions offer this
project, in two candidate domains — **timing** (MIDI, automation, arrangement)
and **DSP generation** (synthesizing the sounds themselves) — and which is
worth building?

**Thesis.** The book's transferable asset for this project is not the primitive
operator set — it is the *time model*. A DSL for timing, treating one phase
ramp as the program and MIDI/SuperCollider-scores/ffmpeg-cut-lists as
compilation targets, is small, differentiated, and agent-fit. A DSL for DSP is
re-entering a space that gen~, Faust, and SuperCollider's own synthesis graphs
already occupy; the right move there is *targeting* an existing backend, and
that judgment stands unless a concrete DSP need outgrows what those backends
express.

**Evidence base and its limit.** The book's full text was not accessible in
session — ResearchGate returned 403 and no full text surfaced via web search
beyond retailer and publisher listings — so this analysis grounds the book's
approach in the primary material that was: Graham Wakefield's own course notes
on Gen ([PDF](https://artificialnature.net/courses/gen/Gen.pdf), quoted
verbatim below), the publisher's description
([Google Books](https://books.google.com/books/about/Generating_Sound_Organizing_Time.html?id=yvV4zwEACAAJ)),
and the authors' interview
([Cycling '74](https://cycling74.com/articles/generating-sound-and-organizing-time-an-interview-with-graham-wakefield-and-gregory-taylor-1),
paraphrased). Claims about the book beyond these sources are inference, not
reading.

## What gen~ actually reduces to

The publisher frames the subject as work "at the atomic sample-by-sample
structure of digital audio"
([Google Books](https://books.google.com/books/about/Generating_Sound_Organizing_Time.html?id=yvV4zwEACAAJ)).
Wakefield's course notes put numbers and mechanisms on it:

> "< 100 operators in total, mostly inspired by Max/MSP objects"

> "instead of operating on a block of samples, we're working with one sample at
> a time – which lets us do things with single-sample feedback that we could
> never do before."

> "[history] - The Z-1 of gen patching - Provides one sample of delay - Allows
> feedback patching - Essential to filter design, signal analysis etc."

> "Consider patch as specification for compiler, rather than interpreted
> network of black-box objects"

— [Wakefield, *Gen* course notes](https://artificialnature.net/courses/gen/Gen.pdf)

One terminological correction matters for anyone reading "binary primitives"
into this: gen~'s "binary operators" are *two-input arithmetic operators*
(add, multiply, compare) — the term as used in
[the notes](https://artificialnature.net/courses/gen/Gen.pdf) ("binary
operators with an argument have only one inlet"), and in operator taxonomy
generally, means arity, and bitwise/binary-digit logic is a different thing.
The reduction claim in its strong form: **multiply, add, compare, plus one
sample of memory (`history`) and delay lines** — and complex processes are
straight-line arithmetic over those. His compiled nested-comb-filter example is
the claim made visible:

```
tap_3  = delay_1.read(in6);
mul_4  = in4 * -1.;
mul_5  = tap_3 * mul_4;
...
delay_1.write(add_8);
delay_2.write(add_11);
```

Two further mechanisms complete the picture: the whole patch **compiles**
(GenExpr → C, invoked at each edit), and — decisive for this project — time is
handled without discrete events at all:

> "No messages means no [trigger] etc.; use 0/1 signals."

The interview develops that constraint into the book's second-half doctrine
(paraphrase): treat cyclical time as modular, start from a ramp rather than
individual triggers, and derive sample-accurate rhythms, swing, divisions,
ratchets, polymeter, and phasing from arithmetic on it
([Cycling '74](https://cycling74.com/articles/generating-sound-and-organizing-time-an-interview-with-graham-wakefield-and-gregory-taylor-1)).

## The timing half: a ramp algebra with three compilation targets

The DSL this suggests is small. Its one primitive value is a **phase ramp** —
`phase(n)` cycles 0→1 every `n` bars — and its operator set is the arithmetic
the book prescribes, each operation carrying a named musical meaning:

| Ramp operation | Musical result | Picture result |
|---|---|---|
| multiply by k | k-fold division, ratchets | cut density |
| add a constant | swing, offset, anticipation | cuts leading/trailing the beat |
| non-integer multiply | polymeter | edit cycling against the music's cycle |
| drift a multiplier | phasing | edit sliding out of and back into lock |
| warp the ramp itself | accelerando, rubato | cuts compressing into a drop |
| threshold/edge-detect | events (notes, hits) | cut points |
| the ramp, un-thresholded | LFOs, envelopes | zoom/speed/opacity automation |

The last two rows are the design's load-bearing pair: **events and automation
are the same object before the final step** — a ramp either passes through an
edge detector (yielding MIDI notes, drum hits, cut points) or doesn't (yielding
CC curves, filter sweeps, Ken Burns zooms). A program is a pure function from
time to ramps; everything else is a backend:

1. **MIDI files** — notes from edges, CC automation from raw ramps; a MIDI
   writer is Python-stdlib territory, and this target is the DAW escape hatch.
2. **SuperCollider NRT scores** — the `.osc` command file format
   [already verified in this project](/projects/code-driven-av-production/headless-supercollider-grid-render.md)
   as sample-exact; any language can emit it.
3. **ffmpeg cut lists and filter expressions** — the same ramps driving
   picture, which no music DSL below offers.

Because every backend is deterministic and non-realtime, output correctness is
*checkable by measurement* — render, onset-detect, diff against the declared
grid — which suits an agent author that verifies numbers but cannot listen.

**Prior art (training knowledge, unchecked against current versions).**
TidalCycles is the closest relative — its core abstraction, patterns as
functions over a repeating cycle, *is* the ramp model — but it is built for
live realtime performance atop SuperDirt, in Haskell. Sonic Pi is imperative
live coding; LilyPond and ABC are notation, not performance timing; Csound's
score model is event lists, i.e. the trigger model. The unoccupied niche is
exactly this project's intersection: **non-realtime, file-emitting, verifiable,
and driving picture and sound from one clock**. The niche justifies a small
DSL; it does not justify reimplementing pattern-language research that
TidalCycles has already done — its combinator vocabulary is the reference to
raid for the event layer.

## The DSP half: target a backend, don't build one

A DSP DSL in the gen~ mold means scalar expressions plus `history`/`delay`
compiled to a per-sample loop. That space is occupied by mature compilers —
gen~/GenExpr itself, Faust (block-diagram algebra → C and much else), Cmajor,
and SuperCollider's UGen graph, which this project has
[already rendered through headlessly](/projects/code-driven-av-production/headless-supercollider-grid-render.md)
(all prior-art identifications from training knowledge). Building another buys
none of this project's goals: the goal is arrangements rendered locally, and a
`SynthDef` is already a compileable, text-authored, agent-writable DSP
specification with sample-accurate NRT scheduling.

Per-sample DSP in the *timing DSL's own host language* is also ruled out by
arithmetic: a 4-minute stereo render is ~21 million samples, minutes-to-tens of
minutes in a Python inner loop, which forfeits the fast-revision property the
pipeline exists for. gen~'s own answer — compile — is the answer here too, with
compilation delegated to `scsynth`. If a concrete need ever outgrows UGen
graphs (single-sample feedback topologies scsynth cannot express at reasonable
cost), the escape hatch is a thin GenExpr-like scalar layer emitted as C and
compiled with `cc -O2` — deferred until that need is demonstrated, not
declined outright.

**Judgment.** Build the timing DSL; feed SuperCollider, MIDI, and ffmpeg from
it; write no DSP compiler. This matches the operator's prior that timing is the
suitable half, and sharpens it: timing is where a small DSL is *differentiated*
(no existing language unifies sound and picture targets), while DSP is where a
small DSL would be *redundant*. Committing to the build graduates this
analysis's sketch into a `type: plan` in this project with the artifact kit the
[structured-plan-bodies policy](/meta/policy/structured-plan-bodies.md)
prescribes — grammar, backend interfaces, and build order.
