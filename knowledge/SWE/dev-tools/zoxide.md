---
id: em:84512b
type: reference
title: "zoxide"
description: A Rust-written smarter cd replacement (inspired by z and autojump) that ranks directories by frecency and jumps to the best match on a fuzzy query, with shell integration across bash, zsh, fish, PowerShell, and more.
resource: https://github.com/ajeetdsouza/zoxide
provenance: "ajeetdsouza/zoxide GitHub repo, fetched 2026-08-21"
tags: [rust, cli, shell, navigation, dotfiles]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# zoxide

A "smarter cd command," written in Rust and inspired by `z` and `autojump`:
it learns which directories are visited most, then jumps to the best match
for a short query instead of requiring a full path.

## How matching works

- `z foo` — jumps to the highest-ranked directory matching `foo`, using a
  frequency/recency ("frecency") score built from past navigation.
- `z foo bar` — matches directories satisfying both terms.
- `zi foo` — interactive selection among matches via `fzf`, when installed.
- Plain relative/absolute paths still work exactly like `cd`.

The ranking database is built purely from observed usage, so it personalizes
automatically without configuration.

## Setup and interop

Cross-shell support spans bash, zsh, fish, PowerShell, Nushell, Elvish, tcsh,
and POSIX shells. Setup is: install the binary, hook shell init, optionally
install `fzf` for interactive mode, and optionally import history from
`autojump`, `z`, `fasd`, or similar tools. It also integrates with a range of
third-party file managers, editors, and terminal multiplexers.

# Citations

- ajeetdsouza/zoxide (repo) — <https://github.com/ajeetdsouza/zoxide>
