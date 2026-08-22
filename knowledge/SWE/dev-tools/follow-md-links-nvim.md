---
id: em:444c00
type: reference
title: "follow-md-links.nvim"
description: A Neovim plugin that turns Enter, on a markdown link under the cursor, into browser-style navigation — local file paths (with line/heading targeting), reference-style links, web URLs, and man-page links.
resource: https://github.com/jghauser/follow-md-links.nvim
provenance: "jghauser/follow-md-links.nvim, GitHub, fetched 2026-08-21"
tags: [neovim, markdown, dev-tools, editor-integration]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# follow-md-links.nvim

A Neovim plugin that maps Enter (in normal mode, on a markdown file) to
following the link under the cursor, the way a browser follows a hyperlink.

## What it follows

- **Local file paths** — absolute (`/home/user/file.md`), relative
  (`../file.txt`), and home-relative (`~/folder/file`)
- **Line/heading targeting** — a path suffixed with `:42` or `#heading`
  positions the cursor after opening
- **Reference-style links** — both labeled (`[text][label]`) and implicit
  reference forms
- **Web links** — `http(s)://` URLs open in the system default browser
- **Man pages** — `man://printf(3)`
- **Heading-only links** — `#chapter-1` jumps within the current file

The only binding it adds is Enter to follow; a `<bs>` mapping to
`:edit #<cr>` gives a "back" motion to the previously edited file. Installs
via any standard plugin manager (Packer, lazy.nvim).

# Citations

- <https://github.com/jghauser/follow-md-links.nvim>
