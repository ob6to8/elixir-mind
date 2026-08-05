---
id: em:41ab78
type: reference
title: "Profiling Rust NIFs in Elixir (Paul Ricks)"
description: A worked recipe for wiring hotpath's function-timing and allocation profiler into a rustler-based Rust NIF crate, driving it from an Elixir Benchee benchmark run via the on_load callback and a manual guard, since hotpath's usual main-function macro has nothing to attach to in a NIF.
resource: https://blog.smaller-infinity.com/posts/profiling-rust-nifs-in-elixir/
provenance: "Paul Ricks, Smaller Infinity blog, published 2026-08-02"
tags: [elixir, rust, nif, rustler, profiling, benchmarking, hotpath, performance]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing"
---

# Profiling Rust NIFs in Elixir

Paul Ricks's recipe for getting function-level timing and allocation data out
of a Rust NIF called from Elixir. The starting problem: language-native
profiling tools (Elixir's own, or Rust's `hotpath`) generally assume you
never leave the language, and a `rustler`-based NIF crosses that boundary by
design — Elixir for the scalable system, Rust NIFs for the CPU-bound inner
loop.

## The core obstacle

`hotpath` is normally wired up via its own `hotpath::main` macro, which
instruments a Rust binary's `main` function. A NIF crate has no `main` — the
crate is loaded into the BEAM, not run standalone — so that automatic setup
has nothing to attach to.

## The recipe

1. **Gate the dependency behind a Cargo feature** (`hotpath = { version =
   "0.21", optional = true }`, plus `hotpath`/`hotpath-alloc` feature flags)
   so the profiler adds zero overhead in a normal build.
2. **Pass the feature through from Elixir at compile time**, via an
   `@hotpath_features` module attribute read from an environment variable and
   forwarded into `use Rustler, features: @hotpath_features` — because
   `use Rustler` and the attribute are both evaluated at compile time, `mix
   compile --force` picks the feature flags up.
3. **Mark each function** `#[cfg_attr(feature = "hotpath", hotpath::measure)]`
   so `hotpath` times it only when the feature is active.
4. **Do `hotpath::main`'s job manually** in `rustler::init!`'s `load`
   callback (`on_load`): build a `HotpathGuardBuilder` (percentiles, JSON
   output path, which sections to collect), store the guard in a
   `static Mutex<Option<HotpathGuard>>` — the guard's lifetime is what
   controls collection start/stop, RAII-style. Register
   `#[global_allocator]` with `hotpath::CountingAllocator` when the
   `hotpath-alloc` feature is on, to get allocation-byte data alongside
   timing.
5. **Add an explicit `hotpath_finish/0` NIF** that drops the guard (flushing
   the JSON report), and call it at the end of the Elixir benchmark script —
   there's no natural end-of-`main` moment to hook, so the Elixir side has to
   trigger the flush itself.

The output is a `hotpath_report` JSON file with per-function call counts,
average/p50/p95/p99 timings, and (with `hotpath-alloc`) exclusive allocation
bytes per function — e.g. in the article's toy example, one function
accounted for 100% of the 1.6GB allocated across ~2.1M calls, immediately
pointing at the allocation hotspot the wall-clock numbers alone wouldn't have
isolated.

## Gotchas worth carrying forward

- **Dirty NIFs.** Long-running NIFs need to run on a dirty scheduler
  (`rustler` supports this); the timing data from this setup is exactly what
  tells you which functions need that reclassification.
- **JSON-per-run doesn't diff well.** Raw JSON profiling output checked into
  git history is hard to compare across runs; the author added `bench.show`
  and `bench.compare` mix tasks specifically to make historical comparison
  usable, and recommends the same for any similar setup.

# Citations

- Source: <https://blog.smaller-infinity.com/posts/profiling-rust-nifs-in-elixir/>
