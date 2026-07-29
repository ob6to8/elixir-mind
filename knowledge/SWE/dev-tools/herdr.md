---
id: em:eb9f29
type: reference
title: "herdr — agent-aware terminal multiplexer"
description: An open-source (Apache-2.0), single-binary Rust terminal multiplexer that runs inside whatever terminal emulator you already have and tracks AI coding agents as first-class runtime objects — blocked/working/done/idle per pane, detach/reattach over SSH, and a CLI/socket API agents can drive.
resource: https://herdr.dev/
provenance: "Distilled from herdr.dev, its /compare comparison matrix (https://herdr.dev/compare/#matrix), and the ogulcancelik/herdr GitHub repository, fetched 2026-07-29"
tags: [terminal, terminal-multiplexer, ai-agents, developer-tools, rust]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked to compare herdr against warp/cmux/tmux/ghostty/superlogical, citing herdr's own comparison matrix, and to file whichever of those tools weren't already captured"
---

# herdr

Herdr is a [terminal multiplexer](/beliefs/glossary/terminal-multiplexer.md) —
architecturally a peer of tmux and Zellij, not a
[terminal emulator](/beliefs/glossary/terminal-emulator.md) — built by
Ogulcancelik (open source, Apache-2.0, GitHub) and distributed as a single Rust
binary with "no Electron, no account, no telemetry." It runs *inside* an
existing terminal rather than replacing it, and ships tmux-style keybindings
(`ctrl+b q` to detach). Install via `curl -fsSL https://herdr.dev/install.sh |
sh`, `brew install herdr`, or `mise use -g herdr`; stable on Linux/macOS, beta
on Windows.

## What it adds over a plain multiplexer

Herdr's differentiator is treating agents as first-class runtime objects
rather than opaque processes in a pane:

- **Semantic agent state** per pane — `blocked` / `working` / `done` / `idle` —
  rather than a multiplexer's usual "process running or not."
- **Direct attach to a single agent's terminal**, not just a whole session.
- **Detach, reattach, and SSH access**, matching tmux/Zellij.
- **Agent-shaped API**: `read`, `send`, `wait`, `split`, `attach` — a CLI and
  socket API through which an agent (or another program) can drive Herdr
  itself, not just be hosted by it.
- **150+ community plugins** via a GitHub-based marketplace.
- **Remote attachment** from a phone or any SSH client, with a responsive
  mobile interface.

## Positioning against the field

Herdr's own [comparison matrix](https://herdr.dev/compare/#matrix) frames the
market as five positions, reproduced here (Herdr's own framing, not this
bundle's judgment):

| Capability | Herdr | tmux/Zellij | cmux/Warp | Solo | Conductor/Emdash/Superset |
|---|---|---|---|---|---|
| Runs inside existing terminal | yes | yes | no, terminal app | no, desktop app | no, app workspace |
| Persistent PTY session runtime | yes | yes | session/app restore | managed processes | embedded terminals |
| Detach, reattach, SSH access | yes | yes | partial | no | remote projects |
| Direct attach to single agent terminal | yes | no | no | no | no |
| Semantic agent state | blocked/working/done/idle | no | attention or native-agent status | process status | workspace status |
| Agent-shaped API | read, send, wait, split, attach | terminal scripting | app APIs | MCP for processes | workflow APIs |
| Git worktree and diff review flow | pairs with it | no | partial | no | yes |

Herdr's own summary: it is "the intersection other tools miss" — persistent,
terminal-native runtime (tmux's territory) crossed with agent-lifecycle
awareness (which terminal apps like [cmux](/knowledge/SWE/dev-tools/cmux.md)
and Warp have, but only for agents running inside their own app, not
arbitrary remote sessions).

## Relationship to libghostty

Herdr does **not** use [libghostty](https://mitchellh.com/writing/libghostty-is-coming).
It is not a terminal emulator and does no rendering of its own — like tmux, it
runs *inside* whichever terminal emulator the operator already uses, so it has
no surface where an embeddable rendering/VT-parsing library like libghostty
would apply. This mirrors tmux's position: both are pure multiplexers sitting
above the emulator layer, architecturally orthogonal to the GUI-terminal wave
(Ghostty, [cmux](/knowledge/SWE/dev-tools/cmux.md),
[Superlogical](/knowledge/SWE/dev-tools/superlogical.md)) that libghostty is
consumed by.

# Citations

- herdr.dev — <https://herdr.dev/>
- herdr comparison matrix — <https://herdr.dev/compare/#matrix>
- GitHub: ogulcancelik/herdr — <https://github.com/ogulcancelik/herdr>
