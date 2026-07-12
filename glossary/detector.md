---
id: sb:0da4a3
type: concept
title: detector
description: A mechanical check that converts a rule violation or drift from a silent state into an announced signal (a failing gate or a printed warning), thereby creating the repair signal that probabilistic enforcement lacks.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, enforcement, tooling, ci]
timestamp: 2026-07-12
---

# detector

A mechanical check that converts a rule violation or drift from a silent state into an announced signal, thereby creating the *repair signal* that [probabilistic enforcement](/glossary/probabilistic-enforcement.md) lacks — a violation with a detector gets fixed once; a violation without one compounds. Detectors come in two strengths: **gates** (the signal is a failure — CI blocks the merge) and [warn passes](/glossary/warn-pass.md) (the signal is advisory — printed, never blocking). The recurring design move in this brain is shrinking the set of surfaces that rely on discipline by giving each [drift class](/glossary/drift-class.md) a detector; what remains detector-less (README prose accuracy, semantic duplication) is known and named rather than assumed covered.

*Seen in:* [docs-surface evaluation and the wiki question](/meta/analysis/docs-surface-evaluation-and-wiki-question.md), [the gate suite tutorial](/meta/tutorials/the-gate-suite-and-where-it-runs.md)
