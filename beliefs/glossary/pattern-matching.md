---
id: em:eae2bf
type: concept
title: pattern matching
description: Binding variables by asserting the shape of a value rather than assigning into a name — the left side of `=` is a template the right side must satisfy, pulling the wanted pieces out as it succeeds and failing loudly when it does not.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, pattern-matching, elixir, erlang, functional-programming, destructuring]
sense: common
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-29 Elixir comprehension tutorial thread"
---

# pattern matching

In Erlang and Elixir `=` is the match operator, so `%{"id" => id} = doc` succeeds
only against a map carrying that key, and `^id` (the pin operator) forces comparison
against an already-bound value instead of rebinding it.

Its main use is dispatch, not extraction: multiple function heads or `case` clauses
list alternative shapes, and the runtime selects the first that fits, which replaces
most conditional branching. Failure raises — `MatchError`, `FunctionClauseError` —
and that noisiness is deliberate, since a value of unexpected shape is caught at the
boundary it crosses rather than several frames later.

Two mechanics recur. Map templates are **partial**: naming one key still fits a map
of twenty, so a template states requirements rather than a full description. And
`template = whole` binds both the extracted pieces and the intact value at once,
which is how a single expression can name an inner field and the container holding
it. The one place failure stays quiet is a
[comprehension's](/beliefs/glossary/comprehension.md) generator, where a
non-conforming element drops out with no error at all.

*Seen in:* [2026-07-29 Elixir comprehension tutorial thread](/meta/threads/2026-07-29-elixir-comprehension-tutorial.md), [Reading an Elixir comprehension that builds a map](/meta/tutorials/elixir/comprehensions-that-build-maps.md)
