---
id: em:ba3dac
type: concept
title: comprehension
description: A construct that walks one or more collections, keeps the elements satisfying its conditions, and assembles a new collection from an expression evaluated per element — Elixir spells it `for x <- list, cond, into: %{}, do: expr`.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, comprehension, elixir, functional-programming, syntax]
sense: common
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-29 Elixir comprehension tutorial thread"
---

# comprehension

Three parts do the work. Anything containing `<-` is a **generator**; anything else
before `do:` is a **filter**, discarding elements it evaluates falsy. The optional
`into:` names what receives the results — anything implementing the `Collectable`
protocol — and defaults to a list, so `into: %{}` is what turns emitted
`{key, value}` tuples into a map.

The generator's left side is a full [pattern](/beliefs/glossary/pattern-matching.md),
not merely a variable name, and this is where the construct behaves unlike the rest
of the language: an element failing to match is **skipped in silence** where a
function head or `case` clause would raise. Destructuring and discarding thus happen
in the same stroke, which is powerful and easy to miss on a first read.

Against an equivalent `Enum.filter |> Enum.map |> Enum.into` pipeline the win is one
traversal instead of three, and each extracted value named once. The limit arrives
when outputs must be *combined* rather than merely accumulated — grouping, tallying,
deduplicating — because a receiving map overwrites on a repeated key; that is
`Enum.reduce/3` or `Enum.group_by/3` territory. Python, Haskell, and Scala carry the
same idea under the same name, differing mostly in whether the target container is
selectable.

**A bare assignment before `do:` is a filter, not a binding, and this reads as a
bug in disguise.** `x = expr` is "anything else before `do:`", so it both binds `x`
*and* discards the row if `expr` is falsy — the same silent-skip behavior the
generator's pattern match has, but on code that looks like ordinary variable
assignment. When `expr` can legitimately be `nil` (a map lookup, `get_in`), the
row vanishes before any later clause written to test for that `nil` ever runs,
making the intended branch dead code. `Map.get(map, key, sentinel)` with a
non-falsy [sentinel value](/beliefs/glossary/sentinel-value.md) is the fix: any
non-`nil`, non-`false` binding survives the implicit filter.

*Seen in:* [2026-07-29 Elixir comprehension tutorial thread](/meta/threads/2026-07-29-elixir-comprehension-tutorial.md), [Reading an Elixir comprehension that builds a map](/meta/tutorials/elixir/comprehensions-that-build-maps.md), [2026-07-31 survey batch, intakes, and the /review-pr skill audit](/meta/threads/2026-07-31-survey-batch-intakes-and-review-pr-skill-audit.md)
