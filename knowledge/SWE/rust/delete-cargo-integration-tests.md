---
id: em:45d98e
type: reference
title: "Delete Cargo Integration Tests (matklad)"
description: Alex Kladov's argument that a project's tests/ directory should hold at most one Cargo integration-test binary — because Cargo compiles and links each file under tests/ as its own binary — with unit tests preferred for internal code and a single consolidated crate for public-API tests.
resource: https://matklad.github.io/2021/02/27/delete-cargo-integration-tests.html
provenance: "Alex Kladov (matklad), blog post, 2021-02-27, fetched 2026-08-21"
tags: [rust, testing, cargo, compile-time, build-performance]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Delete Cargo Integration Tests

Alex Kladov (matklad) argues that Cargo's convention of one binary per file
under `tests/` is a compile-time trap most projects hit without noticing.

## The mechanism behind the cost

Cargo compiles the crate's library once, then **relinks it separately against
every file in `tests/`** — `tests/foo.rs` and `tests/bar.rs` each become their
own binary. Each of those binaries repeats the linking step, and Cargo runs
them sequentially, so build and test-run time both grow linearly with the
number of test files, independent of how much test code they actually
contain.

## The recommended structure

Collapse every integration test file into **one** binary by nesting them
under a single entry point:

```
tests/
  it/
    main.rs   # declares `mod foo; mod bar;` and re-exports test fns
    foo.rs
    bar.rs
```

This keeps the tests organized as separate files while producing exactly one
`tests/it` binary for Cargo to link and run — turning N relinks into one.

## Measured effect

Applying this to Cargo's own test suite produced a claimed **3x decrease in
test-compilation time** and a **5x reduction in artifact size**; one project's
end-to-end test run dropped from 20 seconds to 13.

## Where it does and doesn't apply

- **Small projects** — the effect is negligible; not worth restructuring for.
- **Published libraries** — still keep one integration-test crate to exercise
  the crate the way an external consumer would, against its public API only.
- **Internal-only code** — prefer ordinary `#[cfg(test)]` unit tests inside
  `src/`, since those compile into the existing library binary and never pay
  a separate linking cost at all.

## Discussion note

The post's own r/rust discussion thread was checked for substantial
counter-arguments to fold in here, but the thread was **not reachable** —
`old.reddit.com` and `www.reddit.com` both refused the fetch outright (no
partial content, no error detail beyond a blocked-host response). No
counter-arguments could be recovered from it.

# Citations

- Alex Kladov (matklad), "Delete Cargo Integration Tests", 2021-02-27 — <https://matklad.github.io/2021/02/27/delete-cargo-integration-tests.html>
- Discussion thread (unreachable): <https://old.reddit.com/r/rust/comments/lto0qa/blog_post_delete_cargo_integration_tests/>
