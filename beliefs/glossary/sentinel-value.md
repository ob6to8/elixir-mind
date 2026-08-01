---
id: em:21e292
type: concept
title: sentinel value
description: A dedicated, out-of-band value substituted for the ordinary "nothing found" result so that a lookup's absence case can be tested without colliding with a legitimate falsy value the lookup might otherwise return.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, elixir, functional-programming, defensive-programming]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 route-tag orphan-check bugfix, cited from comprehension and orphan-block"
---

# sentinel value

A lookup that can legitimately return `nil` — a map miss, an unset field — makes
`nil` ambiguous between "the key is absent" and "the key maps to nothing". A
sentinel breaks the tie: `Map.get(map, key, :absent)` returns a value no real
entry would ever hold, so testing `result == :absent` distinguishes the miss
from every other outcome cleanly.

The pattern matters beyond simple lookups wherever `nil` is also treated as
*falsy* by the surrounding control flow — an Elixir
[comprehension](/beliefs/glossary/comprehension.md)'s filter clauses, an `if`,
a `&&`/`||` chain. There, a plain `nil`-returning lookup used as a binding is
silently swallowed by the control flow before any later clause can test for it,
and the fix is the same substitution: pick a sentinel that is never falsy, and
the value survives to the point that needs to inspect it.

*Seen in:* [2026-07-31 survey batch, intakes, and the /review-pr skill audit](/meta/threads/2026-07-31-survey-batch-intakes-and-review-pr-skill-audit.md)
