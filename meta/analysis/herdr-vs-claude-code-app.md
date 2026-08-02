---
type: analysis
title: "Herdr vs. the Claude Code app: a multiplexer for agents next to one of the agents it multiplexes"
description: Herdr is a self-hosted, vendor-agnostic terminal multiplexer that gives any CLI coding agent persistent, remote-reattachable PTY sessions behind a mouse-driven pane UI and a control API; the Claude Code app is Anthropic's own agent bundled with a first-party harness (CLI, Anthropic-hosted cloud runtime, desktop/mobile, IDE extensions) that already ships persistence, remote access, and peer multi-agent coordination for its own sessions but nothing that hosts other vendors' agents — so the two overlap on capability more than they compete on category, and herdr lists Claude Code as one of its native backends rather than as a rival.
provenance: "Claude Code session (Claude Sonnet 5), 2026-08-02 — operator asked for a compare-and-contrast analysis of herdr (https://herdr.dev/) against the Claude Code app; herdr.dev fetched directly this session, Claude Code facts grounded against this bundle's existing documented/verified notes on Claude Code's cloud runtime and agent teams, plus this session's own live Claude Code tool roster (Monitor, ScheduleWakeup, mcp__Claude_Code_Remote__* triggers) as direct evidence of its remote/background surface."
tags: [meta, analysis, claude-code, herdr, agentic, terminal, multiplexer, remote-access, comparison]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02
  channel: agent-authored
  agent: "Claude Code agent, operator request in chat"
  why: "operator asked for a compare-and-contrast analysis of herdr against the Anthropic Claude Code app"
---

# Herdr vs. the Claude Code app

**Question.** How does herdr (a terminal-based agent multiplexer) compare to the
Claude Code app (Anthropic's own coding agent plus its harness)?

**Bottom line.** They sit at different layers and are not a clean substitute for
one another. Herdr is a **session host**: a self-hosted binary that gives *any*
CLI coding agent — Claude Code included — a persistent PTY, a mouse-driven pane
UI, remote reattachment, and a control API, without opinions about which agent
runs inside it. The Claude Code app is an **agent plus its own first-party
harness**: one vendor's model, wrapped in a CLI, an Anthropic-hosted cloud
runtime, a desktop/mobile surface, IDE extensions, and (experimentally) peer
multi-agent coordination among its own sessions. Much of what herdr adds on top
of a bare terminal agent — persistence past disconnect, remote/mobile
reattachment, live status, multi-session visibility — Claude Code already ships
natively for its *own* sessions through its cloud runtime. What herdr adds that
Claude Code does not is **agent-agnosticism**: one pane-based UI and one control
API across Claude Code, Codex, OpenCode, Cursor, and other terminal agents at
once, self-hosted on infrastructure the operator controls. The two compose more
than they compete — herdr names Claude Code as one of its native integrations.

## What each thing is

### Herdr — a self-hosted, agent-agnostic terminal multiplexer

Fetched from herdr.dev (2026-08-02). Herdr's own framing: *"One terminal. The
whole herd,"* and *"a binary, not an app."* It is a multiplexer purpose-built
for running several coding agents at once, not a coding agent itself:

- **Persistent PTY sessions.** Each agent runs *"in its own real terminal, on a
  server that keeps it alive when you close the laptop,"* so a session survives
  disconnect the way a `tmux`/`screen` session does — the persistence lives in
  the terminal process, on the operator's own server.
- **Remote/mobile reattachment.** Detach and reattach from any terminal,
  including over SSH or as a thin client, with a mobile-responsive UI and
  clipboard bridging.
- **Visual, multi-agent surface.** A mouse-driven pane layout with tabs and
  workspaces, and real-time per-pane status (blocked / working / done / idle /
  explore) — *"See blocked, working, and done at a glance, and reattach from
  your phone."*
- **Programmable control.** A CLI for workspace/pane/tab management and a JSON
  socket API that lets agents control the multiplexer itself (spawn panes,
  read status, and so on).
- **Backend-agnostic.** *"Native integrations include Claude Code, Codex,
  OpenCode, Cursor, and others. Any terminal agent works out of the box."*
- **Distribution.** Open-source; self-hosted (script or Homebrew install on
  Linux/macOS, Windows in public beta); *"no Electron, no account, no
  telemetry"*; a plugin ecosystem of *"150+ community extensions"* installable
  via GitHub topics.

### The Claude Code app — one vendor's agent, with its own harness attached

Claude Code is not a multiplexer; it is the agent plus the harness Anthropic
ships around it. Distilled from this bundle's grounded notes on Claude Code
(cited inline) and this session's own operating context:

- **Multiple runtime surfaces, one vendor.** CLI (local terminal), a
  cloud runtime reachable from the web app, a desktop/mobile app, and IDE
  extensions (VS Code, JetBrains) — all running the same underlying agent, not
  a container for other vendors' agents.
- **Cloud persistence and remote access, natively.** The cloud runtime (CCR)
  maps each session to an operator-defined **environment**, provisions a VM
  from a per-environment filesystem snapshot, and — per the official docs
  quoted in this bundle's grounded note — *"Cloud sessions stop after a period
  of inactivity and the underlying environment is reclaimed"*
  ([Claude Code cloud (CCR) — environment and orchestration architecture](/knowledge/SWE/agentic/anthropic/claude-code/cloud-environment-architecture.md),
  `em:52aefa`, `verified: false` — grounded against Anthropic's docs but still
  carrying unverified forensic detail). So cloud persistence is real but
  **bounded** — reclaimed on inactivity — unlike herdr's own-server session,
  which stays alive as long as the operator's box does.
- **Background/remote control surface, observed directly this session.** This
  session's own tool roster is itself evidence: scheduled wake-ups
  (`ScheduleWakeup`, `CronCreate`), a `Monitor` tool for streaming background
  process events, and `mcp__Claude_Code_Remote__*` tools for creating,
  listing, firing, and updating **Routines** (scheduled triggers that resume a
  session or spawn a fresh one) — Anthropic's own answer to "reattach and get
  notified remotely," architecturally distinct from herdr's SSH/thin-client
  reattachment but functionally adjacent.
- **Multi-agent coordination, Claude-only.** *Agent teams* (experimental) let
  several full Claude Code sessions coordinate as peers through a shared,
  file-locked task list and JSON mailboxes, messaging each other by name and
  remaining individually steerable by the operator
  ([Claude Code agent teams](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md),
  `em:33e0c7`). This is Claude Code's structural analog to herdr's multi-pane
  view — but it coordinates *only* Claude Code instances; there is no
  documented surface for teaming a Claude Code session with a Codex or Cursor
  session the way herdr's panes can sit side by side regardless of vendor.
- **Extensibility is prompt/config-level, not session-level.** Hooks, skills,
  subagents, MCP servers, and slash commands extend *what one agent does*;
  none of them multiplex a different agent binary the way herdr's plugin
  ecosystem and socket API do.
- **Cost model.** Anthropic's commercial product: the harness (CLI, IDE
  extensions) installs freely, but running the agent draws on a Claude
  subscription or API usage — the inverse of herdr's open-source,
  no-account, no-telemetry stance, which charges nothing for the multiplexer
  itself but assumes the operator is already paying for whatever agent(s) run
  inside it.

## Feature-by-feature

| Dimension | Herdr | Claude Code app |
|---|---|---|
| What it fundamentally is | A terminal multiplexer / session host (a binary) | An agent (model + harness), not a multiplexer |
| Agents it can run | Agent-agnostic — Claude Code, Codex, OpenCode, Cursor, "any terminal agent" | Itself only |
| Session persistence | PTY kept alive on the operator's own server, indefinitely | Cloud sessions persist independent of the local machine but are reclaimed after inactivity (documented) |
| Remote / mobile access | SSH, thin client, mobile-responsive UI, clipboard bridging | Web app (claude.ai/code), plus this session's own observed surface: push notifications, scheduled wake-ups/Routines, background task monitoring |
| Multi-agent view | One pane grid across any mix of agent vendors, with live per-pane status | Agent teams: peer Claude Code sessions only, coordinated via shared task list + mailboxes |
| Control surface | CLI + JSON socket API for scripting the multiplexer itself | Hooks, skills, subagents, MCP — extend one agent's behavior, not a fleet of different agents |
| Hosting | Self-hosted, on infrastructure the operator controls | Client-side (CLI/IDE/desktop) and/or Anthropic-hosted cloud VMs; no self-hosting option |
| Extension ecosystem | "150+ community extensions" via GitHub topics | Skills, MCP servers, hooks — Anthropic/community-authored, scoped to one session |
| Openness / telemetry | Open-source; "no Electron, no account, no telemetry" | Commercial product; harness install is free, agent usage is metered |

## Where they actually meet

The overlap is real but narrower than it first looks. Herdr's headline
value — *persistence past disconnect* and *remote/mobile reattachment* — is
functionality Claude Code already ships for its own sessions via CCR and the
Routines/notification surface, just architecturally different: Anthropic-hosted
and ephemeral-on-inactivity versus operator-hosted and alive for as long as the
box is. A Claude Code operator who only ever runs Claude Code gains comparatively
little from herdr on the persistence/remote axis specifically, since that axis
is already covered.

What herdr adds that nothing in Claude Code's own surface does is running
**several different agent vendors in one place** with one UI and one control
API — the use case is an operator who wants Codex, Cursor, and Claude Code side
by side, not an operator committed to one vendor. Consistent with that, herdr
does not position itself as a Claude Code competitor: Claude Code is one of its
listed native integrations, so the two compose — an operator could run this
bundle's own Claude Code sessions *inside* herdr instead of (or alongside) CCR,
trading Anthropic-hosted ephemeral persistence for self-hosted indefinite
persistence and cross-vendor panes, at the cost of running and securing that
server themselves.

## Verdict

- **Not a strict substitute.** Herdr is infrastructure for hosting agent
  processes; Claude Code is one such agent (with its own competing
  infrastructure attached). Comparing them head-to-head only makes sense on
  the specific axis of "how do I get a persistent, remote-reachable coding
  agent session" — where they are genuine alternatives — not on agent
  capability, where they aren't comparable at all.
- **Pick herdr** when the requirement is vendor-agnostic multi-agent hosting,
  self-hosted infrastructure, or a terminal-native pane UI with a scriptable
  control API — especially if more than one agent vendor is in play.
- **Pick Claude Code's own remote surface (CCR/Routines)** when the
  requirement is zero-ops (Anthropic hosts the VM), tight integration with
  Claude Code's own feature set (skills, hooks, MCP, agent teams), and only
  one vendor is in use.
- **They are not mutually exclusive**: herdr's own claimed integration list
  means the more likely real-world shape is Claude Code sessions running
  *inside* herdr, not one replacing the other.

## Source notes

Herdr facts are quoted verbatim from a direct fetch of <https://herdr.dev/> on
2026-08-02; no further pages (docs, pricing, GitHub repo) were fetched, so this
analysis is scoped to what the homepage states and does not claim completeness
about herdr's plugin API, its exact pricing/support model beyond "open-source,"
or version-specific behavior. Claude Code facts are drawn from two bundle notes
grounded against Anthropic's official docs —
[cloud-environment-architecture.md](/knowledge/SWE/agentic/anthropic/claude-code/cloud-environment-architecture.md)
(fetched/grounded 2026-07-05/06) and
[agent-teams.md](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md)
(fetched 2026-07-26, official docs stated as of v2.1.178–v2.1.207) — plus this
session's own live tool roster (observed 2026-08-02) as direct, checked
evidence of the remote/background/notification surface currently shipped.
Claude Code's pricing model is stated from general product knowledge, not a
source fetched this session, and should be treated as recalled rather than
freshly checked.
