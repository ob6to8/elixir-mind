---
id: em:738593
type: reference
title: "Atuin — encrypted, synced shell history"
description: A shell history replacement that stores commands (with exit code, directory, hostname, duration metadata) in a local SQLite database and optionally end-to-end-encrypted-syncs them across machines, with a full-screen fuzzy search UI and an opt-in in-shell AI assistant.
resource: https://atuin.sh/
provenance: "atuin.sh and the atuinsh/atuin GitHub README, fetched 2026-08-18"
tags: [shell, shell-history, cli, developer-tools, rust, encryption]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# Atuin

Atuin replaces plain-text shell history files with a local SQLite database of
richly-tagged command records, plus optional end-to-end-encrypted sync across
machines via an Atuin server (hosted, or self-hosted). Open source, MIT
licensed, maintained by the `atuinsh` org.

## Features

- **Rich metadata per command**: exit code, working directory, hostname,
  session ID, duration — not just the command text.
- **Search UI**: rebindable full-screen fuzzy search (default `Ctrl-R`),
  filterable to current session, directory, or global history.
- **Encrypted sync**: history is end-to-end encrypted before leaving the
  machine, so even a self-hosted or Atuin-operated sync server cannot read
  it. Fully usable offline with sync disabled.
- **Multi-shell**: zsh, bash, fish, nushell, xonsh, PowerShell.
- **In-shell AI assistant**: invoked with `?` on an empty prompt.

## Install

```
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
atuin setup
```

# Citations

- atuin.sh — <https://atuin.sh/>
- GitHub: atuinsh/atuin — <https://github.com/atuinsh/atuin>
