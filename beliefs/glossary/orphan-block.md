---
id: sb:3ee2d2
type: concept
title: orphan block
description: A block of generated output whose source has vanished — here, a dated per-thread block in a sink's excerpt log whose thread no longer tags that sink; the log fidelity check fails on it.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, routing, route-tagging, generated-artifacts]
timestamp: 2026-07-12
---

# orphan block

The [tag](/beliefs/glossary/route-tag.md) was removed or re-pointed, or the thread deleted, leaving the derived block in the [sink](/beliefs/glossary/route-tag-sink.md)'s [excerpt log](/beliefs/glossary/excerpt-log.md) with nothing to re-derive it from. The failing check is `mix brain.route_tags`'s `log fidelity` pass, and [materialization](/beliefs/glossary/materialize.md) removes orphans automatically — the two-directional projection built as P1 of the [code-review toolchain hardening plan](/meta/plans/code-review-toolchain-hardening.md).

*Seen in:* [two-directional materialize elaboration](/meta/elaborations/two-directional-materialize.md), [route_tags materialize issue](/meta/issues/route-tags-materialize-leaves-orphan-blocks.md), [code-review toolchain hardening plan](/meta/plans/code-review-toolchain-hardening.md)
