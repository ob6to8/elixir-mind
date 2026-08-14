---
id: em:f8d2bb
type: concept
title: "open sound control"
description: "A network protocol for realtime control of sound and media software: each message carries a URL-style address pattern (/track/3/volume) plus typed arguments (int32, float32, string…), usually one message per UDP datagram — no fixed vocabulary, so every server (a DAW extension, a synth engine) publishes its own address space over the same wire format."
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, osc, protocol, audio, daw-control, networking]
sense: common
timestamp: 2026-08-14
attribution:
  when: 2026-08-14T22:58:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-14 bitwig-shell-control thread"
---

# open sound control

Where MIDI fixes both the vocabulary (notes, 7-bit CCs) and the semantics,
OSC fixes only the envelope: address strings are self-describing and
arguments are typed at full resolution, so a control surface is whatever
address space its server documents. Servers conventionally listen on one UDP
port and send state feedback to a different one. In this bundle it is the
common wire under three otherwise-unrelated surfaces: the
[DrivenByMoss register](/knowledge/media-production/daw-control/bitwig/drivenbymoss-osc.md)
for Bitwig, [AbletonOSC](/knowledge/media-production/daw-control/ableton/ableton-control-surfaces.md)
for Live, and the time-stamped command files scsynth renders in
[SuperCollider NRT mode](/knowledge/media-production/audio-synthesis/supercollider-nrt-rendering.md).
Shell tooling: [realtime OSC from the shell](/knowledge/media-production/daw-control/osc-from-the-shell.md).

*Seen in:* [2026-08-14 bitwig-shell-control thread](/meta/threads/2026-08-14-bitwig-shell-control-incubation-and-agentic-daw-fit.md), [DrivenByMoss OSC](/knowledge/media-production/daw-control/bitwig/drivenbymoss-osc.md), [realtime OSC from the shell](/knowledge/media-production/daw-control/osc-from-the-shell.md), [Ableton Live's programmatic control surfaces](/knowledge/media-production/daw-control/ableton/ableton-control-surfaces.md)
