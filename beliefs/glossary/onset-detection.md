---
id: em:5a4acb
type: concept
title: onset detection
description: "Recovering event start-times (drum hits, note attacks) from rendered audio by detecting sudden energy rises — e.g. short-window RMS loudness with a jump threshold — measurement with error, as opposed to reading times from a declared schedule."
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, onset-detection, audio-analysis, timing, verification]
sense: common
timestamp: 2026-07-28T22:40:00Z
attribution:
  when: 2026-07-28T22:40:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the measurement half of the declared-vs-measured distinction running through the 2026-07-28 thread's filings"
---

# onset detection

In this bundle the term does double duty. Literally: the 5 ms-RMS jump
detector used to verify rendered beats against their declared grid (scripts in
[the tutorial](/projects/code-driven-av-production/headless-supercollider-grid-render.md)),
with its window size as the measurement's quantisation floor. Figuratively: the
[declared-grid analysis](/projects/code-driven-av-production/declared-grid-av-production.md)
and the
[declared-cadence swarm analysis](/meta/analysis/declared-cadence-swarm-auditability.md)
use it as the name for a whole pattern — recovering, with error, temporal
structure that was never written down (cut points from a mix, agent
interleavings from logs) — the pattern that declaring the timeline exists to
replace.

*Seen in:* [2026-07-28 code-driven AV production thread](/meta/threads/2026-07-28-code-driven-av-production-and-declared-cadence.md)
