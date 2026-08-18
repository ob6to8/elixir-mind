---
id: em:f13f81
type: reference
title: "Sebastien Rousseau's AI-aware dotfiles — declarative, security-first workstation setup"
description: A chezmoi-based, multi-shell dotfiles repo and its companion 2026 design writeup, treating the developer workstation as reproducible infrastructure with encrypted secrets, cryptographic attestation, and MCP-bounded AI agent access.
resource: https://github.com/sebastienrousseau/dotfiles
provenance: "sebastienrousseau/dotfiles GitHub README and the companion 2026-06-16 design post on sebastienrousseau.com, fetched 2026-08-18"
tags: [dotfiles, chezmoi, developer-tools, security, ai-agents, workstation, reproducibility]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# Sebastien Rousseau's AI-aware dotfiles

A dotfiles repository built on [chezmoi](/knowledge/SWE/dev-tools/chezmoi.md),
paired with a design writeup arguing developer workstations should be treated
as critical infrastructure — declaratively configured, reproducible, and
security-audited — rather than manually-tweaked "snowflake laptops," with
particular attention to the risk that a terminal-resident AI coding agent
(e.g. Claude Code) introduces to credential handling.

## Stack

- **Shells**: Zsh, Fish, Bash, Nushell, PowerShell, kept at documented parity.
- **Editor**: Neovim, fully Lua-configured, as the primary editor.
- **Terminal**: tmux as multiplexer; Starship, Zoxide, Atuin, and fzf for
  prompt/navigation/history.
- **Runtime/package management**: Mise for per-user language versions, Nix
  Flakes for reproducible builds, Pueue for task queueing.
- **Theming**: wallpaper-driven palette generation via K-means clustering in
  CIELAB color space, enforcing WCAG AAA contrast, applied uniformly across
  Ghostty, Alacritty, Kitty, WezTerm, and iTerm2.

## Security and AI-agent posture

- **Secrets**: age and SOPS encryption; nothing sensitive committed in
  plaintext.
- **Supply-chain integrity**: signed commits, OIDC trusted publishing, SLSA
  Level 3 cryptographic attestation on bootstrap scripts.
- **AI agent containment**: Model Context Protocol (MCP) policy enforcement
  restricts local AI tools to approved commands/directories via named agent
  profiles (ask / plan / apply / audit).
- **`dot ai`**: a command for AI-assisted commit messages and fleet
  management across machines.
- Framed explicitly around regulatory posture (DORA, NIST CSF 2.0) — secure
  developer endpoints as a fiduciary-accountability concern, not just
  convenience.

License: MIT.

# Citations

- GitHub: sebastienrousseau/dotfiles — <https://github.com/sebastienrousseau/dotfiles>
- Design writeup — <https://sebastienrousseau.com/2026-06-16-ai-aware-dotfiles-secure-reproducible-workstation-2026/>
