---
id: em:0ecaed
type: reference
title: "Turning a personal website into an SSH terminal app (ratatui + russh)"
description: A build write-up showing how to expose a personal site as an SSH-accessible terminal UI using the Rust ratatui TUI library and the russh SSH server crate, sharing one render function between local and remote sessions.
resource: https://hackernoon.com/how-i-turned-my-website-into-an-ssh-terminal-app
provenance: "HackerNoon article, fetched 2026-08-18"
tags: [rust, ratatui, russh, ssh, tui, terminal]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# SSH terminal app via ratatui + russh

A HackerNoon write-up describing `ssh agnelnieves.sh` — a personal
website/portfolio rebuilt as an SSH-reachable terminal application, inspired
by [terminal.shop](https://terminal.shop) (`ssh terminal.shop`), which sells
coffee through an SSH terminal storefront.

## Architecture

- **[ratatui](https://ratatui.rs)** draws the UI: header, ticker, ASCII
  banner, a projects list, and a blog reader.
- **[russh](https://github.com/Eugeny/russh)** runs the SSH server that hosts
  the session.
- The same render function runs whether the binary is executed locally or
  served over SSH — no divergent code path for the two entry points.
- Content is fetched live from the author's own site API at request time
  (`/feed.json`, `/api/blog/[slug]/raw`, `/api/projects`, `/api/site.json`),
  so the terminal app and the website stay backed by one data source.

## Takeaway

The author frames it as a low-effort experiment — a few evenings poking at
ratatui and russh — that turned out easier than expected, given ratatui
handles the rendering and russh handles the SSH transport, leaving little
glue code once both libraries are in place.

# Citations

- HackerNoon — <https://hackernoon.com/how-i-turned-my-website-into-an-ssh-terminal-app>
