---
id: em:22ad57
type: concept
title: auditory stream segregation
description: "The perceptual process by which a listener parses one mixed acoustic signal into separate concurrent sources — instruments, voices, machines — grouping components by proximity in pitch, timbre, onset time, and spatial position."
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, perception, psychoacoustics, sonification, auditory-display]
sense: common
timestamp: 2026-07-30T00:00:00Z
attribution:
  when: 2026-07-30T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the constraint that set the layer count in the 2026-07-30 incident-replay mapping — nine data phases could not become nine streams"
---

# auditory stream segregation

Studied as *auditory scene analysis*, it is what makes hearing a genuinely
parallel channel: several sources are tracked at once, without being attended
to in turn and without being aimed anywhere, which is the property a
[sonification](/beliefs/glossary/sonification.md) trades on when a visual
display has more simultaneous state than a gaze can visit.

The capacity is bounded, and the bound is a design constraint rather than a
detail: only a handful of concurrent streams can be reliably followed, so a
mapping with more data dimensions than that must group them — a few continuous
voices for the high-rate dimensions, discrete
[earcons](/beliefs/glossary/earcon.md) for the rare ones. Segregation also
*fails* by design: components close enough in time or timbre fuse into one
percept instead, which is exactly why a click train above roughly ten events per
second stops being countable and becomes texture.

*Seen in:* [2026-07-30 sonifying an incident replay thread](/meta/threads/2026-07-30-sonifying-an-incident-replay.md), [sonifying-an-incident-replay analysis](/meta/analysis/sonifying-an-incident-replay.md)
