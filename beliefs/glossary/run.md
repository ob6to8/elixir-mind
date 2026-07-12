---
id: sb:e55bda
type: concept
title: run (canonical run)
description: A single end-to-end execution of a flow or task — the unit a flow doc narrates as its touch-sequence, and the unit a scheduled Routine produces on each firing.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, flows, workflow, tooling]
timestamp: 2026-07-12
---

# run (canonical run)

In both senses a run is an *instance* — from invocation to its last file touched — distinct from the flow (the repeatable shape) and the skill (the procedure). In the flow-doc sense, the "touch-sequence of a canonical run" lists every file one representative execution touches, in order, and is also the unit a [scenario test](/beliefs/glossary/scenario-test.md) pins the deterministic spine of. In the [Routine](/beliefs/glossary/routine.md) sense, each firing yields one run (as in the open issue about daily `/research` runs not landing).

*Seen in:* [the intake flow](/meta/flows/intake.md), [the research-inbox flow](/meta/flows/research-inbox.md), [daily /research Routine runs not landing](/meta/issues/daily-news-routine-runs-not-landing.md), [2026-07-12 docs-audit thread](/meta/threads/2026-07-12-docs-audit-wiki-verdict-and-freshness-warnings.md)
