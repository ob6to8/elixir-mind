---
id: em:d138ff
type: reference
title: "Catppuccin — pastel theme project (Neovim and tmux ports)"
description: A community-maintained soothing pastel color theme, distributed as per-application ports across dozens of tools; covers the Neovim port (the project's origin) and the tmux port, each offering four flavors (Latte, Frappé, Macchiato, Mocha).
resource: https://github.com/catppuccin/nvim
provenance: "catppuccin/nvim and catppuccin/tmux GitHub READMEs, fetched 2026-08-18"
tags: [theme, neovim, tmux, developer-tools, color-scheme]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# Catppuccin

Catppuccin is a community theming project built around a single "soothing
pastel" palette, ported to dozens of individual applications as separate
repos under the `catppuccin` GitHub org. Every port ships the same four
flavors — **Latte** (light), **Frappé**, **Macchiato**, **Mocha** — so a user
can apply one consistent look across their whole toolchain. MIT licensed.

## Neovim port (`catppuccin/nvim`)

The origin of the whole project. Supports Neovim 0.8+, ships a compiled
configuration for fast startup, and integrates with 40+ plugins plus LSP and
Treesitter highlighting. Installable via Neovim 0.12's `vim.pack`,
lazy.nvim, packer.nvim, or rocks.nvim. Activated via `colorscheme catppuccin`
with optional Lua setup for color and highlight-group overrides.

## tmux port (`catppuccin/tmux`)

Applies the same four flavors to tmux's status line, with configurable
window status styles (e.g. rounded) and pre-built status modules for CPU,
RAM, battery, session, and uptime, using Nerd Font icons. Requires tmux 3.2+
(special configuration provided for earlier versions). Install manually
(clone into `~/.config/tmux/plugins/catppuccin/tmux`, `run` it from
`.tmux.conf`) or via TPM (`set -g @plugin 'catppuccin/tmux#v2.3.0'`).

# Citations

- GitHub: catppuccin/nvim — <https://github.com/catppuccin/nvim>
- GitHub: catppuccin/tmux — <https://github.com/catppuccin/tmux>
