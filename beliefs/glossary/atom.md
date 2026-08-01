---
id: em:33ce3c
type: concept
title: atom
description: A constant whose name is its own value (`:ok`, `:fm`, `true`) — the interned symbol type of Erlang and Elixir, stored once per name in a global table and therefore compared in constant time.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, atom, elixir, erlang, beam, data-types]
sense: common
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-29 Elixir comprehension tutorial thread"
---

# atom

Much of the language is built out of them without looking like it: `true`, `false`,
and `nil` are three; every module name is one (`Enum` is sugar for `:"Elixir.Enum"`);
and the tuple conventions `{:ok, result}` / `{:error, reason}` that carry outcomes
across almost every [OTP](/beliefs/glossary/otp.md) boundary are built on them.

The trap is that the global table is **never garbage-collected**, and the
[BEAM](/beliefs/glossary/beam.md) caps its size. Converting arbitrary external input
with `String.to_atom/1` therefore leaks until the node dies — which is why
`String.to_existing_atom/1` exists, and why parsed JSON and YAML conventionally keep
their keys as strings. That convention produces the mixed-key
[pattern](/beliefs/glossary/pattern-matching.md) common in Elixir code that touches
external documents: `%{fm: %{"id" => id}}`, with an internally-built structure keyed
one way and parsed data keyed the other. `%{fm: v}` is only sugar for `%{:fm => v}`,
and the two key types never interchange — `map.key` requires this type, while a
string key needs bracket access.

*Seen in:* [2026-07-29 Elixir comprehension tutorial thread](/meta/threads/2026-07-29-elixir-comprehension-tutorial.md), [Reading an Elixir comprehension that builds a map](/meta/tutorials/elixir/comprehensions-that-build-maps.md)
