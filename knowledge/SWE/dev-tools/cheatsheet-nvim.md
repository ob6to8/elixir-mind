---
id: em:c06647
type: reference
title: "cheatsheet.nvim — searchable in-editor cheatsheet for Neovim"
description: A Neovim plugin providing a Telescope-backed fuzzy-searchable cheatsheet of commands, mappings, and shortcuts, bundled with cheatsheets for Neovim itself, popular plugins, nerd-fonts, regex, and Unicode.
resource: https://github.com/sudormrfbin/cheatsheet.nvim
provenance: "sudormrfbin/cheatsheet.nvim GitHub README, fetched 2026-08-18"
tags: [neovim, editor, plugin, telescope, developer-tools]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# cheatsheet.nvim

A Neovim plugin by **sudormrfbin** that surfaces a searchable cheatsheet
inside the editor, so commands, mappings, and shortcuts can be looked up
without leaving the current buffer or breaking flow.

## Features

- **Telescope-based fuzzy finder** as the primary interface, with a floating
  window fallback when Telescope isn't installed.
- **Auto-completion**: selecting an entry drops its command straight onto the
  command line.
- **Bundled cheatsheets** for Neovim core, popular plugins, nerd-fonts, regex,
  and Unicode — shown in a simple, portable plain-text format.
- **Plugin-aware loading**: only shows cheatsheets for plugins actually
  installed.
- Default invocation is `<leader>?`; keymaps, which bundled sheets load, and
  plugin-cheatsheet visibility are all configurable.

## Install

Works with vim-plug, dein, or packer.nvim. Requires `plenary.nvim`, and
`telescope.nvim` + `popup.nvim` for the recommended interface.

# Citations

- GitHub: sudormrfbin/cheatsheet.nvim — <https://github.com/sudormrfbin/cheatsheet.nvim>
