---
id: sb:96a610
type: concept
title: residual fragmentation
description: The near-duplicate or fragmented concepts that remain after automated intake dedup has done its cheap best, left for a human editorial pass to catch and merge.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, intake, dedup, editorial]
timestamp: 2026-07-12
---

# residual fragmentation

The duplicated or split-apart concepts that survive automated intake [deduplication](/glossary/deduplication.md) — the leftover after the machine has done the cheap merges it can (e.g. updating in place on a known `relates to sb:` hint). It names a division of labor in the [auto-intake model](/meta/plans/auto-intake-featured-news.md): automation handles the *bulk* of don't-fragment via update-in-place, and the operator's editorial pass reconciles the *residual* that lexical [recall](/glossary/recall.md) missed. The cost asymmetry matters — reconciling a fragmentation already committed to history (reassigning ids, redirecting [`verified_by`](/glossary/verified-by.md) edges) is dearer than avoiding it at write time, which is why the residual is kept small rather than left to grow.

*Seen in:* [auto-intake-featured-news plan](/meta/plans/auto-intake-featured-news.md)

*See also:* [deduplication](/glossary/deduplication.md), [recall](/glossary/recall.md), [cognitive debt](/glossary/cognitive-debt.md)
