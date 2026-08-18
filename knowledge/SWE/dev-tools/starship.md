---
id: em:edcaa2
type: reference
title: "Starship — cross-shell prompt"
description: A fast, minimal, infinitely customizable shell prompt written in Rust that works identically across Bash, Zsh, Fish, PowerShell, and most other shells.
resource: https://starship.rs/guide/
provenance: "starship.rs/guide/, fetched 2026-08-18"
tags: [shell, prompt, cli, developer-tools, rust]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# Starship

Starship is a shell prompt, self-described as "the minimal, blazing-fast, and
infinitely customizable prompt for any shell." Maintained by Starship
Contributors since 2019, ISC licensed.

## Features

- Fast (implemented in Rust) and context-aware — surfaces relevant info (git
  status, language/runtime versions, cloud context, etc.) per directory.
- Fully customizable prompt segments and formatting.
- One config drives a consistent prompt across every supported shell.

## Shell support

Bash, Zsh, Fish, PowerShell, Elvish, Ion, Nushell, Tcsh, Xonsh, and Cmd (via
Clink).

## Install

- Linux: `curl -sS https://starship.rs/install.sh | sh`
- macOS: `brew install starship`
- Windows: MSI installer
- Any platform with Rust: `cargo install starship --locked`

Then add the shell-specific init snippet to your shell's rc file.

# Citations

- starship.rs — <https://starship.rs/guide/>
