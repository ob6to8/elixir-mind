---
id: em:6169f2
type: reference
title: "Rustlings"
description: The official Rust project's command-line exercise course — small, incremental coding exercises with a watch-mode runner — meant to be worked through alongside the Rust book.
resource: https://github.com/rust-lang/rustlings/
provenance: "rust-lang/rustlings GitHub repo and rustlings.rust-lang.org, fetched 2026-08-21"
tags: [rust, learning, cli, exercises, official]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Rustlings

**Rustlings** is the official Rust project's exercise course: "small
exercises to get you used to reading and writing Rust code," meant to be
worked through in parallel with
[the Rust book](/knowledge/SWE/rust/rust-lang-org-learn.md) rather than in
place of it.

## How it works

Install and run via Cargo (`cargo install rustlings`, then `rustlings init`
and `rustlings`, per its own quick-start). The runner watches the exercises
directory, recompiling and re-checking on save, and walks the learner through
exercises of increasing difficulty — each one a small broken or incomplete
program to fix.

## Repository shape

- `exercises/` — the practice problems themselves.
- `solutions/` — reference solutions.
- `src/` — the runner/watch-mode application code.
- `tests/` — the project's own test suite.
- `website/` — the source for rustlings.rust-lang.org, its landing/docs site.

It is an official Rust project (MIT-licensed) with substantial adoption
(tens of thousands of GitHub stars at the time of fetch).

# Citations

- rust-lang/rustlings (repo) — <https://github.com/rust-lang/rustlings/>
- Rustlings landing page — <https://rustlings.rust-lang.org/>
