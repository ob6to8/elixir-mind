---
id: sb:c68b6d
type: concept
title: dependency-directed backtracking
description: On contradiction, tracing the recorded justification structure backwards to the assumptions actually responsible and retracting a culprit — instead of undoing choices in chronological order.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, epistemics, truth-maintenance, search, backtracking]
timestamp: 2026-07-11
---

# dependency-directed backtracking

The TMS repair move: when a contradiction is derived, trace the recorded
justification structure *backwards* from the contradiction to the set of
[assumptions](/glossary/assumption.md) actually contributing to it, and
retract one culprit — rather than chronological backtracking, which blindly
undoes the most recent choice whether or not it was involved. The recorded
inconsistent assumption set becomes a [nogood](/glossary/nogood.md), so the
same dead end is never rebuilt.

*Seen in:* [TMS reference](/knowledge-management/knowledge-representation/truth-maintenance-systems.md), [Doyle 1979 capture](/knowledge-management/knowledge-representation/doyle-1979-a-truth-maintenance-system.md), [de Kleer 1986 capture](/knowledge-management/knowledge-representation/de-kleer-1986-an-assumption-based-tms.md)
