---
id: sb:e8c1a9
type: concept
title: probabilistic enforcement
description: An integrity model in which rules live as prose an agent promises to follow, so each operation has a roughly constant chance of violating them — meaning violations scale with operation count and, absent a detector, compound silently.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, enforcement, failure-modes, governance]
timestamp: 2026-07-12
---

# probabilistic enforcement

An integrity model in which the rules live as prose (a `CLAUDE.md` convention, a style guide) and are followed only as reliably as the agent or human executing them — giving every operation a roughly constant probability of violation. Because operation count scales with the corpus while the per-operation rate stays flat, total violations grow with scale, and without a [detector](/glossary/detector.md) there is no repair signal, so errors compound into [invisible degradation](/glossary/invisible-degradation.md). The contrast is *structural* enforcement — converting the rule into a machine check (a CI gate, a compiled artifact with `--check`) whose violation is an announced failure rather than a silent state. The 2026 second-brain field survey found probabilistic ("advisory") enforcement to be the near-universal norm, and names it root cause (a) of the 500+ concept failure chain.

*Seen in:* [comparison with the 2026 second-brain field](/meta/analysis/comparison-with-the-2026-second-brain-field.md), [docs-surface evaluation and the wiki question](/meta/analysis/docs-surface-evaluation-and-wiki-question.md)
