---
id: sb:683301
type: concept
title: drift class
description: A category of staleness whose instances share one detection mechanism — e.g. unresolved internal links, or files present in a directory but missing from its index — making the class as a whole checkable by a single detector.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, enforcement, corpus-health, tooling]
timestamp: 2026-07-12
---

# drift class

The docs audit identified two such classes — both now announced by the docs-freshness [warn pass](/beliefs/glossary/warn-pass.md). Classifying drift this way separates what can be made structural from what stays editorial: a drift class with a mechanical oracle gets a [detector](/beliefs/glossary/detector.md); staleness without one (a README paragraph describing retired behavior) must be minimized by design instead, e.g. by keeping such prose a thin pointer into generated surfaces.

*Seen in:* [docs-surface evaluation and the wiki question](/meta/analysis/docs-surface-evaluation-and-wiki-question.md), [2026-07-12 docs-audit thread](/meta/threads/2026-07-12-docs-audit-wiki-verdict-and-freshness-warnings.md)
