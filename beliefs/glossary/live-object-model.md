---
id: em:67a6f6
type: concept
title: "live object model"
description: "Ableton Live's hierarchical API object tree — Song → Tracks → ClipSlots/Clips → Devices → DeviceParameters — exposed to Max for Live devices and MIDI Remote Scripts; the reach of any programmatic control of Live is set by what the LOM exposes, and bridges like AbletonOSC deliberately mirror its naming and hierarchy."
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, ableton, api, live-object-model, daw-control]
sense: common
timestamp: 2026-08-14
attribution:
  when: 2026-08-14T22:58:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-14 bitwig-shell-control thread"
---

# live object model

Reached from inside a running Live: Max for Live devices address it through
`live.object` / `live.observer` (and JS), MIDI Remote Scripts through Python.
It is writable at the structure level — tracks, scenes, and clips can be
created and notes added programmatically — which lets a bridge grow a set
rather than only turn its knobs. The plane-by-plane map:
[Ableton Live's programmatic control surfaces](/knowledge/media-production/daw-control/ableton/ableton-control-surfaces.md).

*Seen in:* [2026-08-14 bitwig-shell-control thread](/meta/threads/2026-08-14-bitwig-shell-control-incubation-and-agentic-daw-fit.md), [Ableton Live's programmatic control surfaces](/knowledge/media-production/daw-control/ableton/ableton-control-surfaces.md), [Max for Live as a programmable DSP substrate](/knowledge/media-production/daw-control/ableton/max-for-live-programmability.md)
