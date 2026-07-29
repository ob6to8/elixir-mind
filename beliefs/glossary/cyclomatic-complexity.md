---
id: em:08a552
type: concept
title: cyclomatic complexity
description: A count of the linearly independent paths through a function's control flow, computed from its decision points (branches, loops, conditionals); higher values mark code that is harder to test exhaustively and harder to reason about.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, code-quality, metrics, testing]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /create-pull-request"
  why: "term surfaced by the 2026-07-29 research digest, where SlopCodeBench uses it to define structural erosion"
---

# cyclomatic complexity

Introduced by Thomas McCabe (1976) as a graph-theoretic measure — count the
decision points in a function's control-flow graph and the metric follows
directly. It's used two ways in practice: as a proxy for how hard a function
is to unit-test thoroughly (each independent path is a case worth covering),
and as a code-smell threshold flagging functions that should be split.
[SlopCodeBench](/knowledge/SWE/agentic/agentic-loop/slopcodebench-iterative-degradation.md)
uses a threshold of 10 to define "structural erosion" — the fraction of a
codebase's total complexity concentrated in functions above that bar — as one
of its two measures of how coding-agent output degrades over iterative
extension.

*Seen in:* [SlopCodeBench](/knowledge/SWE/agentic/agentic-loop/slopcodebench-iterative-degradation.md), [2026-07-29 research digest thread](/meta/threads/2026-07-29-research-digest-mcp-spec-security-and-reliability.md)
