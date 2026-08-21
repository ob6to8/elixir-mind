---
id: em:55df1d
type: reference
title: "zinit"
description: A Zsh plugin manager built around asynchronous "Turbo mode" loading and per-plugin "ice" modifiers, aiming for faster shell startup and finer-grained control than typical framework-based plugin managers.
resource: https://github.com/zdharma-continuum/zinit
provenance: "zdharma-continuum/zinit GitHub repo, fetched 2026-08-21"
tags: [zsh, shell, plugin-manager, dotfiles, cli]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# zinit

A Zsh plugin manager (community continuation of the original `zdharma/zinit`,
now under the `zdharma-continuum` org) built for fast startup and detailed
introspection of what each plugin does to the shell.

## Turbo mode

Plugins can be deferred with a `wait` ice modifier and loaded asynchronously
after prompt draw, paired with `lucid` to suppress the verbose load report
during background loading. This is the mechanism behind zinit's headline
performance claim — 50-80% faster startup versus loading everything
synchronously at shell init.

## Ice modifiers

"Ice" is zinit's term for one-shot options attached to the *next* zinit
command only — controlling clone behavior, which files within a plugin get
sourced, conditional loading, and post-install hooks. This keeps
per-plugin configuration declarative and colocated with the plugin's load
line, rather than living in separate config blocks.

## Introspection and cleanliness

`load` reports what a plugin contributed (aliases, functions, keybindings,
completions, `$PATH` changes); `light` loads the same way without the
reporting overhead. Unlike some plugin managers, zinit avoids piling multiple
entries into `$FPATH` per plugin, and it can load plugins sourced from Oh My
Zsh or Prezto without pulling in those frameworks wholesale. An "annex"
system extends zinit itself with new commands and hooks.

# Citations

- zdharma-continuum/zinit (repo) — <https://github.com/zdharma-continuum/zinit>
