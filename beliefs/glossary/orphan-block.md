---
id: em:3ee2d2
type: concept
title: orphan block
description: A block of generated output whose source has vanished — here, a dated per-thread block in a sink's excerpt log whose thread no longer tags that sink; the log fidelity check fails on it.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, routing, route-tagging, generated-artifacts]
sense: repo
timestamp: 2026-07-16
attribution:
  when: 2026-07-11T08:02:52+00:00
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the captured sources cited in Seen in (backfilled)"
---

# orphan block

A block of generated output whose source has vanished, leaving derived content
with nothing to re-derive it from. Three causes land in the same shape: the
[tag](/beliefs/glossary/route-tag.md) feeding a [sink](/beliefs/glossary/route-tag-sink.md)
is removed or re-pointed, its thread is deleted, or — the case a hand-written
block produces — **the named thread never existed at all**, since the
[excerpt log](/beliefs/glossary/excerpt-log.md) is a generated section and a
block placed there by any other writer cites a source the verifier cannot
resolve. `mix brain.route_tags`'s `log fidelity` check fails on orphans, and
[materialization](/beliefs/glossary/materialize.md) removes them automatically —
the two-directional projection built as P1 of the
[code-review toolchain hardening plan](/meta/plans/code-review-toolchain-hardening.md).
The third case went undetected for a time despite the check's intent: its
implementation bound the candidate thread via a plain map lookup inside a
[comprehension](/beliefs/glossary/comprehension.md)'s filter position, so a
`nil` lookup (the never-existed case) silently dropped the row before the
`nil`-handling branch could run — fixed with a
[sentinel value](/beliefs/glossary/sentinel-value.md).

*Seen in:* [two-directional materialize elaboration](/meta/elaborations/two-directional-materialize.md), [route_tags materialize issue](/meta/issues/route-tags-materialize-leaves-orphan-blocks.md), [code-review toolchain hardening plan](/meta/plans/code-review-toolchain-hardening.md), [2026-07-31 survey batch, intakes, and the /review-pr skill audit](/meta/threads/2026-07-31-survey-batch-intakes-and-review-pr-skill-audit.md)
