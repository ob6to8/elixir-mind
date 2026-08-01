---
id: em:d5ca81
type: concept
title: "DSP reduces to a small primitive vocabulary plus one sample of memory"
description: "The mental model gen~ demonstrates: complex audio processes — filters, physical models, oscillators — compile down to straight-line two-input arithmetic (add, multiply, compare) over per-sample state held in a one-sample delay (history) and delay lines, with a compiler rather than an interpreter making that reduction efficient."
verified: true
verified_by: [em:98a026]
provenance: "Distilled from Wakefield's Gen course notes; Wakefield was gen~'s primary author"
tags: [media-production, dsp, gen, primitives, compilation, mental-model]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T21:40:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "the reduction claim recurred across a session on code-driven music production and grounds the choice to target existing DSP compilers rather than build one"
---

# DSP reduces to a small primitive vocabulary plus one sample of memory

gen~ — the sample-level DSP environment in Max, whose design its author
documents in the
[course notes capture](/knowledge/media-production/audio-synthesis/wakefield-gen-course-notes.md)
— demonstrates a general claim: the enormous surface of audio DSP (filters,
oscillators, physical models, effects) is built from a **vocabulary of under a
hundred low-level operators**, and the load-bearing ones are fewer still:

- **two-input ("binary") arithmetic** — add, multiply, compare. *Binary* here
  is arity (two inlets), a term easily misread as bitwise or binary-digit
  logic, which is a different thing entirely;
- **one sample of memory** — the `history` operator, "The Z-1 of gen patching",
  which is what makes feedback (and therefore most filters and oscillators)
  expressible at all;
- **delay lines** — multi-sample memory with read/write taps.

The capture's compiled comb-filter example makes the claim concrete: a
physical-model resonator is fourteen lines of straight-line scalar arithmetic
plus two delay reads and two delay writes.

Two conditions make the reduction usable rather than merely true. Working
**per-sample** (against the block-based processing of conventional DSP chains)
is what allows single-sample feedback. And the patch is treated as a
**specification for a compiler** — gen~ compiles to C-family code at each edit —
because an interpreter dispatching per sample would be unusably slow; the
reduction and the compiler come as a pair. A practical corollary: a scripting
language's interpreter loop is the wrong home for per-sample DSP, and systems
wanting this model should emit code for an existing compiler (a SuperCollider
synth graph, GenExpr, C) rather than evaluate samples natively.

The companion concept — what the same environment teaches about *time* — is
[ramps as time](/knowledge/media-production/sequencing/ramps-as-time.md).

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:d5ca81">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-code-driven-av-production-and-declared-cadence (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:d5ca81`]**  (co-feeds: `em:98a026`)

The pedagogy, from the Cycling '74 interview, is that a large repertoire collapses to a small one — "so many synthesis and sound processing techniques come down to a pretty small number of common circuits and patterns," presented as a "bestiary of simple and reusable ideas that can be recombined" ([Cycling '74](https://cycling74.com/articles/generating-sound-and-organizing-time-an-interview-with-graham-wakefield-and-gregory-taylor-1)).

Wakefield's course notes put numbers on the primitive set:

> "< 100 operators in total, mostly inspired by Max/MSP objects
> Objects are mostly low-level"

and name the single mechanism the whole thing pivots on:

> "instead of operating on a block of samples, we're working with one sample at a time – which lets us do things with single-sample feedback that we could never do before."
> "[history] - The Z-1 of gen patching - Provides one sample of delay - Allows feedback patching - Essential to filter design, signal analysis etc."
> — [Wakefield, *Gen* course notes](https://artificialnature.net/courses/gen/Gen.pdf)

The reduction you're intuiting is real and visible in what gen~ emits. This is his own example of a nested comb-filter patch after compilation:

```
tap_3  = delay_1.read(in6);
mul_4  = in4 * -1.;
mul_5  = tap_3 * mul_4;
tap_6  = delay_2.read(in5);
mul_7  = tap_6 * in3;
add_8  = mul_7 + mul_5;
...
delay_1.write(add_8);
delay_2.write(add_11);
```

A physical-model resonator is straight-line scalar arithmetic plus two delay-line reads and writes. That's the claim in its strongest form: **multiply, add, compare, and one sample of memory**. Everything else is arrangement. The framing that makes it work is treating the patch "as specification for compiler, rather than interpreted network of black-box objects."
