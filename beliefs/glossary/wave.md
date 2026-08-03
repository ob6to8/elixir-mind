---
id: em:7eaa13
type: concept
title: wave
description: A set of work units executed concurrently with a barrier before the next set begins — units within a wave are mutually independent, every dependency points backward across a barrier; standard parallel-scheduling vocabulary (wavefront/level scheduling), used the same way by the get-shit-done framework and by this bundle's wave-delivery methodology.
sense: common
provenance: "Claude Fable 5, distilled from the wave-delivery methodology, 2026-08-03"
verified: false
tags: [glossary, concurrency, scheduling, orchestration, waves]
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T06:05:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary over the matter-list audit thread"
  why: "the term became load-bearing when the wave-delivery methodology was filed and the operator asked where it came from; glossaried so the answer is citable rather than re-derived"
---

# wave

The dependency-leveled batch of parallel execution: topologically level a
dependency graph, run each level's items concurrently, run the levels in
sequence. Within a wave, items are mutually independent; across waves, every
dependency points backward through a barrier. An established term of art
(*wavefront* or *level scheduling* in parallel computing), and the
[get-shit-done](https://github.com/gsd-build/get-shit-done) Claude Code
framework uses it identically — "GSD groups plans into waves (parallel where
independent, sequential where dependent)"
([USER-GUIDE](https://github.com/gsd-build/get-shit-done/blob/main/docs/USER-GUIDE.md)).

This bundle's usage and its added discipline — merge-surface partitioning for
units that land as separately reviewed merges into one trunk — are defined in
[wave-based concurrent delivery](/knowledge/SWE/agentic/orchestration/wave-based-concurrent-delivery.md),
which is the canonical statement; this entry is the pointer.

*Seen in:* [2026-08-03-matter-list-audit-and-wave-delivery-methodology](/meta/threads/2026-08-03-matter-list-audit-and-wave-delivery-methodology.md)
