---
id: em:98a026
type: source
title: "Wakefield — Gen course notes (Cycling '74)"
description: "Verbatim extracts from Graham Wakefield's course notes on Gen, the sample-level DSP compiler embedded in Max: the operator-count claim, single-sample feedback via the history operator, the no-triggers time model, and the patch-as-compiler-specification framing, with a compiled GenExpr example."
resource: https://artificialnature.net/courses/gen/Gen.pdf
provenance: "Extracted from the resource PDF via pdftotext, 2026-07-28; Wakefield was the primary author of gen~ for Max"
tags: [media-production, dsp, gen, max-msp, compilation, primary-source]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T21:40:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "primary-source grounding for the gen~ reduction and ramps-as-time concepts distilled in the same session"
---

# Wakefield — Gen course notes

Supporting passages, verbatim, from the course notes by gen~'s primary author.

On what Gen is:

> "Consider patch as specification for compiler, rather than interpreted
> network of black-box objects
> Embed compiler in Max, invoke it at each edit
> Embed results in Max, or export as C++"

On the operator vocabulary:

> "< 100 operators in total, mostly inspired by Max/MSP objects
> Objects are mostly low-level; for oscillators, filters etc. see gen~ examples folder."

> "e.g. binary operators with an argument have only one inlet"

On single-sample feedback:

> "The flow of data inside the gen~ object is like MSP in that it's synchronous,
> but instead of operating on a block of samples, we're working with one sample at a time
> – which lets us do things with single-sample feedback that we could never do before."

> "[history]
> - The Z-1 of gen patching
> - Provides one sample of delay
> - Allows feedback patching
> - Essential to filter design, signal analysis etc."

On the time model:

> "No messages means no [trigger] etc.; use 0/1 signals."

A compiled patch (nested comb filters, after Ahn & Dudas, ICMC 2013) —
straight-line two-input arithmetic plus delay-line reads and writes:

> ```
> Delay delay_1(44100);
> Delay delay_2(44100);
> tap_3 = delay_1.read(in6);
> mul_4 = in4 * -1.;
> mul_5 = tap_3 * mul_4;
> tap_6 = delay_2.read(in5);
> mul_7 = tap_6 * in3;
> add_8 = mul_7 + mul_5;
> mul_9 = add_8 * in4;
> add_10 = mul_9 + tap_3;
> add_11 = in1 + add_10;
> mul_12 = add_11 * in2;
> add_13 = mul_12 + add_10;
> out1 = add_13;
> delay_1.write(add_8);
> delay_2.write(add_11);
> ```

On the textual form:

> "This simplified C-like language is called GenExpr."

> "Easy to port existing DSP code (e.g. musicdsp.org) to GenExpr!"

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:98a026">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-code-driven-av-production-and-declared-cadence (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:98a026`]**  (co-feeds: `em:d5ca81`)

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
