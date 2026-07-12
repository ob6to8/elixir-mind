---
id: sb:1c53dc
type: concept
title: cross-reference drift
description: The failure mode in which a change that should update many interlinked documents only updates some, leaving the rest silently stale — the known killer of LLM-maintained wikis, and stage 3 of the second-brain failure chain.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, failure-modes, links, corpus-health]
timestamp: 2026-07-12
---

# cross-reference drift

The failure mode in which a change that should touch many interlinked documents — Karpathy's arithmetic puts one ingested source at 10–15 affected wiki pages — only updates some of them, leaving the rest pointing at retired facts, renamed files, or superseded claims. A partial-view agent updates what it retrieved; the rest rots silently ([invisible degradation](/glossary/invisible-degradation.md)). It is the known killer of LLM-maintained wikis and stage 3 of the 500+ concept failure chain; the advisory countermeasure (a periodic LLM lint pass) has the same context ceiling as the agent that caused the drift. This brain's defenses are structural where possible — compiled artifacts can't drift from their sources, and the docs-freshness [warn pass](/glossary/warn-pass.md) announces unresolved links — with the remainder held editorially.

*Seen in:* [comparison with the 2026 second-brain field](/meta/analysis/comparison-with-the-2026-second-brain-field.md), [docs-surface evaluation and the wiki question](/meta/analysis/docs-surface-evaluation-and-wiki-question.md)
