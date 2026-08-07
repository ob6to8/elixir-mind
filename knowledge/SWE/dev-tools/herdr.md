---
id: em:eb9f29
type: reference
title: "herdr — agent-aware terminal multiplexer"
description: An open-source (Apache-2.0), single-binary Rust terminal multiplexer that runs inside whatever terminal emulator you already have and tracks AI coding agents as first-class runtime objects — blocked/working/done/idle per pane, detach/reattach over SSH, and a CLI/socket API agents can drive.
resource: https://herdr.dev/
provenance: "Distilled from herdr.dev, its /compare comparison matrix (https://herdr.dev/compare/#matrix), and the ogulcancelik/herdr GitHub repository, fetched 2026-07-29"
tags: [terminal, terminal-multiplexer, ai-agents, developer-tools, rust]
timestamp: 2026-08-07
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

## Architecture: a daemon plus a TUI client

herdr splits into a background [daemon](/beliefs/glossary/daemon.md) and a
[TUI](/beliefs/glossary/tui.md) client that runs inside the operator's existing
terminal. The daemon owns the [PTYs](/beliefs/glossary/pty.md) — it allocates
one pseudoterminal per agent pane, forks the agent CLI against the slave end,
and retains the master end — so it is the parent process of every agent, the
holder of all terminal state, and the only process that can arbitrate access to
a pane. Clients attach and detach (`ctrl+b q`) without disturbing any of that,
which is what makes detach/reattach and SSH-reachability first-class rather
than workarounds, and what places the socket API (including the event-driven
`agent wait --until done|blocked`) in the daemon. The limit is inherent: a
power cycle kills the daemon, and nothing resurrects a dead PTY.

Because state is inferred by evaluating manifests against a terminal snapshot
rather than reported by agent hooks, screen detection is the primary path — the
contrast [cmux](/knowledge/SWE/dev-tools/cmux.md) is judged on in
[two shapes of the same agent multiplexer](/knowledge/SWE/dev-tools/herdr-and-cmux-two-shapes.md).
The full unpacking of the ownership claim is in
[the daemon owns the PTYs](/meta/elaborations/herdr-daemon-owns-the-ptys.md).

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

Herdr does **not** use [libghostty](/beliefs/glossary/libghostty.md).
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
- Compared against the Claude Code app, with a concrete build for
  approximating Claude Code's cloud architecture using herdr plus Fly.io/Shellbox,
  in [Herdr vs. the Claude Code app](/meta/analysis/herdr-vs-claude-code-app.md).

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:eb9f29">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-31-herdr-cmux-terminal-tool-comparison-intake (2026-07-31)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:eb9f29`]**  (co-feeds: `em:16581e`)

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
