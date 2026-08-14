---
id: em:5a2280
type: note
title: Neovim command-discovery plugins — the genre map
description: The four genres that answer "what's the command?" inside Neovim — cheatsheet search, config palettes, mapping introspection, and prefix discovery — with a maintained exemplar of each and the corpus model none of them uses.
verified: false
provenance: "Claude Fable 5 — synthesized from the cited repositories' READMEs and web search results"
tags: [neovim, vim, plugins, fuzzy-finding, dev-tools, reference-tooling, telescope]
timestamp: 2026-08-14
attribution:
  when: 2026-08-14T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed project spec session"
  why: "the plugin landscape for in-editor command lookup was surveyed while specing a command-reference tool; the genre map holds regardless of that tool"
---

# Neovim command-discovery plugins — the genre map

Plugins that answer "what's the command?" inside Neovim split into four
genres, distinguished by what corpus they search and whether they teach the
command or run it.

**1. Cheatsheet search — a knowledge corpus, fuzzy-searched, answer
displayed.**
[cheatsheet.nvim](https://github.com/sudormrfbin/cheatsheet.nvim) (707 stars;
[dotfyle](https://dotfyle.com/plugins/sudormrfbin/cheatsheet.nvim) showed an
update 3 days before 2026-08-14) fronts bundled and user-written
`cheatsheet.txt` files with a Telescope picker, falling back to a floating
window. Its corpus is line-per-cheat: each entry is
"description | key/command", with `##` metadata lines naming sections and
`@tag` search aliases. Its picker-action vocabulary is the genre's reference
set: `<CR>` autofills the command line stopping at `{`/`[` placeholders,
`<A-CR>` executes directly, `<C-Y>` yanks the cheat, `<C-E>` edits the user
sheet.

**2. Config palettes — execute what you already configured.**
[legendary.nvim](https://github.com/mrjones2014/legendary.nvim) is the
maintained exemplar: keymaps, commands, and autocmds are defined as Lua
tables, then fuzzy-found and executed VS-Code-palette style, with
which-key.nvim integration. Smaller kin:
[command-palette.nvim](https://github.com/Gtollm/command-palette.nvim),
[commanderly.nvim](https://github.com/jvs/commanderly.nvim). The corpus is
the user's own configuration — a palette teaches nothing that isn't already
bound.

**3. Mapping introspection — search the live keymap table.** Telescope's
builtin `keymaps` picker searches whatever mappings currently exist,
displaying lhs/rhs. It needs no data file, and for the same reason it carries
no intent descriptions and no knowledge of unbound stock commands.

**4. Prefix discovery — browse forward from keys already pressed.**
[which-key.nvim](https://github.com/folke/which-key.nvim) pops available
continuations after a prefix; discovery runs keycap-first, so it answers
"what can follow `g`?", never "how do I switch tabs?".

The corpus models in use are one-liner cheat rows (genre 1), Lua config
tables (genre 2), and the editor's own runtime state (genres 3–4). A
file-per-entry corpus — one document per intent, categorized by directory,
versioned in git, searchable by any tool because it is plain files — appears
in none of the surveyed plugins. Scope of that finding: three web searches
(2026-08-14: cheatsheet.nvim, the command-palette genre, and an exact-phrase
"neovim-commands" name check) plus README-level reads of cheatsheet.nvim and
its dotfyle page; the dotfyle and awesome-neovim registries were not swept
systematically. The adjacent task-manager genre was surveyed separately and
deeper in [the matter-surface plan](/meta/plans/matter-cli-and-neovim-surface.md)
(15 repos); its "external store, picker front-end" architecture finding is
consistent with this map.

# Citations

- <https://github.com/sudormrfbin/cheatsheet.nvim> — README: format rules,
  picker actions, Telescope-with-fallback design
- <https://dotfyle.com/plugins/sudormrfbin/cheatsheet.nvim> — stars and
  last-update recency
- <https://github.com/mrjones2014/legendary.nvim> — palette over Lua-defined
  keymaps/commands/autocmds
- <https://github.com/Gtollm/command-palette.nvim>,
  <https://github.com/jvs/commanderly.nvim> — smaller palette-genre entries
- <https://github.com/folke/which-key.nvim> — prefix discovery
