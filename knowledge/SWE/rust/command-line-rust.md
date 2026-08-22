---
id: em:c765b5
type: reference
title: "Command-Line Rust (Ken Youens-Clark)"
description: Companion code repository for the O'Reilly book Command-Line Rust, which teaches the language by having readers rebuild classic Unix utilities (cat, head, wc, grep, cut, tail, uniq, and more) as small, complete, tested Rust programs.
resource: https://github.com/kyclark/command-line-rust
provenance: "kyclark/command-line-rust GitHub repo, fetched 2026-08-21"
tags: [rust, learning, cli, unix, book]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Command-Line Rust

Companion repository for **Command-Line Rust** (O'Reilly, 2024, ISBN
9781098109417) by Ken Youens-Clark — a book that teaches Rust by having the
reader reimplement classic Unix command-line tools, one per chapter, each a
"single small, complete, focused program."

## Approach

Rather than teaching language features in the abstract, each chapter builds
and tests a real tool end to end, covering along the way: standard-library
I/O and data types, CLI argument parsing/validation, error handling, raw and
delimited text parsing, regular expressions, and control flow.

## Tools implemented

Rust rewrites of `echo`, `cat`, `head`, `wc`, `grep`, `cut`, `tail`, plus
`find`, `uniq`, `comm`, and `cal` (as `echor`, `catr`, `headr`, `wcr`,
`grepr`, `cutr`, `tailr`, `findr`, `uniqr`, `commr`, `calr`).

## Versioning

Three branches track different `clap` argument-parser versions/styles: the
main branch uses `clap` v4 with its derive macros, with alternate branches
for the v4 builder pattern and v2 compatibility.

# Citations

- kyclark/command-line-rust (repo) — <https://github.com/kyclark/command-line-rust>
