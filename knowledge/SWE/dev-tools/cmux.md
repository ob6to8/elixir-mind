---
id: em:16581e
type: reference
title: "cmux — Ghostty-based macOS terminal for parallel AI coding agents"
description: An open-source (GPL), native macOS terminal built in Swift/AppKit on libghostty for GPU-accelerated rendering, adding vertical tabs with per-pane git branch/PR/port status and agent-attention notification rings for running several AI coding agents side by side.
resource: https://cmux.com/
provenance: "Distilled from cmux.com and the manaflow-ai/cmux GitHub repository, fetched 2026-07-29"
tags: [terminal, terminal-emulator, ai-agents, developer-tools, macos, libghostty]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked to compare cmux against herdr/warp/tmux/ghostty/superlogical and to file whichever of those tools weren't already captured"
---

# cmux

Compared head-to-head against [herdr](/knowledge/SWE/dev-tools/herdr.md) — the
human-scheduler seat versus the agent-scheduler seat — in
[two shapes of the same agent multiplexer](/knowledge/SWE/dev-tools/herdr-and-cmux-two-shapes.md).

cmux (Manaflow AI) is a native macOS [terminal emulator](/beliefs/glossary/terminal-emulator.md) —
not a multiplexer layered over one — built in Swift/AppKit rather than
Electron, using [libghostty](/beliefs/glossary/libghostty.md)
as its rendering engine ("not a Ghostty fork") for GPU-accelerated drawing,
fast startup, and low memory use. It is free, open source, and GPL-licensed,
with an optional paid "Founders Edition" for early access to features (cmux
AI, an iOS companion app, cloud VMs) layered on top of a fully-functional free
core. A Windows port, `wmux`, exists as a separate project.

## What it adds over a plain terminal

cmux's organizing idea is that AI coding agents running in parallel panes
generate background state (which branch, which PR, which port, who needs
attention) that a plain terminal makes the operator hunt for manually. It
surfaces that state directly:

- **Vertical tabs/sidebar** showing, per pane: git branch, linked PR
  status/number, working directory, listening ports, and the latest
  notification text.
- **Notification rings** around a pane, sidebar unread badges, a notification
  popover, and a native macOS desktop notification when a process needs
  attention.
- Any terminal-based agent works unmodified — Claude Code, Codex, OpenCode,
  Gemini CLI, Kiro, Aider, Goose, Amp, Cline, Cursor Agent, or anything else
  launched from the command line.
- **Remote capabilities**: SSH workspaces and the ability to attach to
  existing tmux sessions — cmux's own multi-agent orchestration turns
  subagents into native panes instead of hidden background processes.
- Split panes, an embedded scriptable browser, a programmable CLI/socket API,
  session persistence across app restarts and reboots, and an iOS companion
  app with real-time terminal syncing.

## Relationship to libghostty and the field

cmux is one of [libghostty](/beliefs/glossary/libghostty.md)'s clearest current consumers: it takes the
GPU-accelerated VT rendering libghostty extracted out of
[Ghostty](/knowledge/SWE/dev-tools/superlogical.md#origin) and wraps it in a
native macOS shell purpose-built for the agent-parallelism workflow, the same
adoption shape [Superlogical](/knowledge/SWE/dev-tools/superlogical.md) takes
for its multiplexer. Unlike [herdr](/knowledge/SWE/dev-tools/herdr.md) or
[tmux](/beliefs/glossary/terminal-multiplexer.md), which run *inside* an
existing terminal and do no rendering of their own, cmux *is* the terminal —
which is exactly the axis libherdr's own comparison matrix uses to place
"cmux/Warp" opposite "Herdr"/"tmux/Zellij" (see the matrix on
[herdr](/knowledge/SWE/dev-tools/herdr.md#positioning-against-the-field)).
Unlike Warp, which built its own proprietary GPU renderer (WarpUI, on `wgpu`)
before libghostty existed, cmux reuses libghostty rather than maintaining a
competing renderer.

# Citations

- cmux.com — <https://cmux.com/>
- GitHub: manaflow-ai/cmux — <https://github.com/manaflow-ai/cmux>
- GitHub: amirlehmam/wmux (Windows port) — <https://github.com/amirlehmam/wmux>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:16581e">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-31-herdr-cmux-terminal-tool-comparison-intake (2026-07-31)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:16581e`]**  (co-feeds: `em:eb9f29`)

Pushed to `claude/terminal-multiplexer-compare-dmzt6h`. Here's the comparison and what got filed.

**In plain terms**

You asked how six terminal tools stack up and where `libghostty` fits. The short version: two different games are being played. **tmux** and **herdr** are multiplexers — they run *inside* whatever terminal you already have and just manage panes/sessions; herdr's twist is that it also tracks whether an AI agent in each pane is blocked, working, or done. **Warp**, **cmux**, **Ghostty**, and **Superlogical**'s upcoming multiplexer are all terminal *emulators* — they own the window and do the actual pixel rendering. `libghostty` is Ghostty's rendering engine, pulled out into a reusable library — and it's being picked up specifically by that second group (cmux and Superlogical build on it directly; Ghostty *is* its origin), while Warp built its own renderer from scratch before libghostty existed, and the pure multiplexers (tmux, herdr) don't render anything themselves so libghostty doesn't apply to them at all. Two of the six — **herdr** and **cmux** — weren't in the bundle yet, so I filed them; Warp, tmux, and Ghostty were already covered (glossary terms plus the existing Superlogical capture), and Superlogical itself was captured in this same session's earlier turn.

**The comparison**

**The two axes.** Herdr's own [comparison matrix](https://herdr.dev/compare/#matrix) draws exactly this line: "runs inside existing terminal" (Herdr, tmux/Zellij) vs. "no, terminal app" (cmux/Warp). That's the load-bearing distinction across all six:

| Tool | Kind | Renders its own pixels? | Uses `libghostty`? | Agent-aware? |
|---|---|---|---|---|
| [herdr](https://herdr.dev/) | multiplexer (Rust) | No — hosted by another terminal | No — nothing to render | Yes, per-pane state: blocked/working/done/idle |
| tmux | multiplexer (C) | No | No | No |
| [cmux](https://cmux.com/) | terminal emulator (Swift/AppKit, macOS) | Yes, via libghostty | **Yes** — rendering engine | Yes, sidebar + notifications |
| Warp | terminal emulator (Rust) | Yes, custom `WarpUI` on `wgpu` | No — predates libghostty, own renderer | Yes, native "Agentic Development Environment" |
| Ghostty | terminal emulator (Zig) | Yes | Is the source of libghostty | No (general-purpose) |
| [Superlogical](/knowledge/SWE/dev-tools/superlogical.md) | multiplexer (pre-launch) | Yes (its clients render) | **Yes**, explicitly built atop it | Framed around durable sessions across human/automated/agent work |

**libghostty's actual role.** It's a C-ABI library (currently just `libghostty-vt`: VT-sequence parsing + terminal state, extracted from Ghostty's proven core, zero dependencies) meant to let anyone embed correct terminal rendering instead of writing another ad-hoc ANSI parser. Its adopters so far are, unsurprisingly, exactly the tools that need a renderer and didn't want to build one: cmux wraps it in a native macOS shell; Superlogical's multiplexer clients build on it. tmux and herdr have no rendering surface to put it in — libghostty's own pitch does name multiplexers like tmux/zellij as *potential* future consumers (for VT parsing rather than rendering), but neither has adopted it. Warp is the interesting outlier: it needs exactly what libghostty offers but built `WarpUI` in-house years before libghostty existed, so it's a case of prior art rather than rejection.

**Where herdr and cmux actually differ from each other**, despite both being "agent-aware": herdr is infrastructure-first (SSH-reachable, remote, tmux-compatible keybindings, tracks *any* terminal-based agent anywhere) while cmux is experience-first (native macOS chrome, git/PR/port status in a sidebar, notification rings) — they're solving the same problem (agent visibility) from opposite ends of the stack (headless multiplexer vs. polished native app), which is exactly the pairing herdr/cmux occupy on opposite sides of its own matrix.

**What I did**

| Doc | Type | Why this type |
|---|---|---|
| `knowledge/SWE/dev-tools/herdr.md` (`em:eb9f29`) | `reference` | Captured/summarized external material (herdr.dev, its compare matrix, GitHub repo) |
| `knowledge/SWE/dev-tools/cmux.md` (`em:16581e`) | `reference` | Captured/summarized external material (cmux.com, GitHub repo) |

| File | Change |
|---|---|
| `knowledge/SWE/dev-tools/index.md` | Added herdr and cmux entries |
| `meta/registry.md` | Regenerated for the two new ids |
| `meta/evals/dedup-probe.md` | Harvested a gold row from your comparison phrasing; refreshed baseline (6/20, no regression) |

| Action | Result |
|---|---|
| Dedup search (herdr/cmux/warp/tmux/ghostty/libghostty) | No existing docs for herdr or cmux; warp/tmux/ghostty already represented via glossary + the Superlogical capture, so skipped per your instruction |
| Full pre-commit gate suite (`format`, `xref`, `verify`, `route_tags`, `glossary`, `lineage`, `test`) | All green — 188 tests passing |
| Committed and pushed | `40345be` on `claude/terminal-multiplexer-compare-dmzt6h` |

No new directory or type was needed (both filed autonomously under the already-established `dev-tools`), so nothing is awaiting ratification. No PR opened, since none was requested — let me know if you'd like one.
