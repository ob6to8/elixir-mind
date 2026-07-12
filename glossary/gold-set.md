---
id: sb:24a13d
type: concept
title: gold set
description: A curated set of evaluation inputs each labeled with its known-correct answer(s), used as ground truth to score a system's output against.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, evaluation, search]
timestamp: 2026-07-12
---

# gold set

A curated collection of evaluation inputs, each paired with the answer a correct system *should* produce, used as ground truth for scoring. For the [dedup-recall probe](/meta/plans/dedup-recall-probe.md) the gold set is a table of natural-phrasing queries, each keyed to the [`sb:` id(s)](/glossary/stable-id.md) intake dedup ought to surface for it — with acceptable-id *sets* (several concepts can legitimately answer one phrasing) and adjudication notes. A design point of that plan: gold pairs are **harvested from real intake phrasing** rather than synthesized, because synthetic paraphrases share their generator's vocabulary and are systematically too easy.

*Seen in:* [dedup-recall-probe plan](/meta/plans/dedup-recall-probe.md)

*See also:* [recall probe](/glossary/recall-probe.md), [recall](/glossary/recall.md), [recall@k](/glossary/recall-at-k.md)
