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
