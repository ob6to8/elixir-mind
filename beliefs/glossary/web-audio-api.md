---
id: em:21524a
type: concept
title: Web Audio API
description: "The browser's audio-processing interface: a graph of connected nodes — sources, filters, gains, panners, convolvers — driven by a sample-accurate scheduler that events are booked against ahead of time."
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, web-audio, browser, audio-synthesis, javascript, sonification]
sense: common
timestamp: 2026-07-30T00:00:00Z
attribution:
  when: 2026-07-30T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the implementation substrate proposed for the browser sonification designed in the 2026-07-30 incident-replay session"
---

# Web Audio API

The scheduler is the part that matters for a browser
[sonification](/beliefs/glossary/sonification.md). Because parameter changes are
booked against `AudioContext.currentTime` rather than fired from JavaScript
callbacks, a deterministic timeline can be scheduled up front and stays exact
regardless of frame-rate jitter — which makes the audio clock the natural
timebase for an animation to follow, rather than the reverse.

Two constraints shape any design built on it. An `AudioContext` cannot start
without a user gesture, so autoplay is unavailable and a play control has to
double as the audio unlock. And per-event node allocation stops scaling in the
low tens of events per second, so high-rate streams switch to a sustained source
under an envelope — a substitution the ear does not notice, because it happens
where the events were fusing anyway.

*Seen in:* [2026-07-30 sonifying an incident replay thread](/meta/threads/2026-07-30-sonifying-an-incident-replay.md), [sonifying-an-incident-replay analysis](/meta/analysis/sonifying-an-incident-replay.md)
