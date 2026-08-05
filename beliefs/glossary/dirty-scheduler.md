---
id: em:0410b1
type: concept
title: dirty scheduler
description: A separate BEAM scheduler pool set aside for long-running or CPU/IO-heavy native code (typically a NIF), so it can't starve the regular schedulers that keep ordinary Elixir/Erlang processes preemptively switching every ~2,000 reductions.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, elixir, erlang, otp, beam, nif, concurrency]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-05 reading-list batch intake"
---

# dirty scheduler

The BEAM's normal scheduling model assumes native calls return quickly enough
to preempt cooperatively; a NIF that blocks or burns CPU for milliseconds or
longer instead starves every other process pinned to that scheduler thread. A
**dirty NIF** — one declared to run on the dirty CPU or dirty I/O scheduler
pool instead of a regular one — sidesteps this by running off the regular
pool entirely, at the cost of that call no longer competing for the same
fairness guarantees. `rustler` (the Rust NIF bridge for Elixir) supports
declaring a NIF dirty; per-function timing data from a profiler is exactly
what tells you which functions have crossed the threshold where they need
the reclassification.

*Seen in:* [Profiling Rust NIFs in Elixir](/knowledge/SWE/performance/profiling-rust-nifs-in-elixir.md)
