---
id: em:4a62a3
type: concept
title: call-stack tree
description: A compact indented-tree rendering of a program's call hierarchy — which functions invoke which, in order — drafted as a program-design artifact so composition and control flow can be reviewed before implementation.
provenance: "Agent-distilled glossary definition, 2026-07-26 session"
verified: false
sense: common
tags: [glossary, program-design, planning, coding-agents]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T22:20:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-26 structured-plan-bodies thread (wsff.md and the Mulroy post)"
---

# call-stack tree

Diff syntax (`+`/`-` lines) marks the calls a change adds or removes, making the delta reviewable at a glance. Practitioners draft the tree **twice** — the production topology and the test topology — so which seams get substituted under test (an in-memory layer for a SQL executor, say) is a planned decision rather than an implementation discovery. In this brain it is artifact 3 of the [structured-plan-bodies policy](/meta/policy/structured-plan-bodies.md)'s kit, alongside the [file-tree diff](/beliefs/glossary/file-tree-diff.md).

*Seen in:* [2026-07-26 structured-plan-bodies thread](/meta/threads/2026-07-26-structured-plan-bodies-and-belief-layer.md), https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/wsff.md, https://x.com/dillon_mulroy/status/2059985696148849025
