# Performance

Profiling, benchmarking, and optimization technique — measuring where time
and memory actually go, including across a language boundary.

## Contents

- [Profiling Rust NIFs in Elixir (Paul Ricks)](/knowledge/SWE/performance/profiling-rust-nifs-in-elixir.md) — wiring `hotpath`'s function-timing and allocation profiler into a `rustler` NIF crate via the `on_load` callback, driven from an Elixir Benchee run, since `hotpath`'s usual main-function macro has no `main` to attach to inside a NIF.
