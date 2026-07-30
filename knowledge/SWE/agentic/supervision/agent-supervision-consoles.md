---
id: em:b4bb5e
type: reference
title: "Agent supervision consoles"
description: The tools that multiplex concurrent coding agents into one attention surface — terminal multiplexers, native workspace managers, parallel-agent applications, task boards, mobile relays, and session recorders — and the granularity each one supervises at.
provenance: "Distilled from project sites and repositories fetched 2026-07-30: herdr.dev, cmux.com, github.com/coder/mux, vibe-kb.com, github.com/entireio/cli, plus tool roundups at nimbalyst.com and munderdiffl.in"
tags: [supervision, agentic, multiplexer, orchestration, tooling, worktrees]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T05:46:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed research session on agent supervision tooling"
  why: "the console landscape grounds the agent-pairing project's competitive analysis and is true independent of it"
---

# Agent supervision consoles

Running several coding agents concurrently creates an attention-routing problem:
which agent is blocked, which finished, which touched the wrong file, which
branch is safe to merge. The tools that answer it differ mainly in **what they
multiplex** and **what granularity they supervise at** — and that granularity,
rather than feature count, is what decides whether two of them compose or
compete.

## Terminal multiplexers with agent awareness

[**herdr**](https://herdr.dev/) is a single ~10MB Rust binary giving each agent
its own real PTY pane, with a background server for detach/reattach (including
over SSH) and a sidebar that classifies every agent as **blocked / working /
done / idle** by inspecting process names and terminal output. It detects Claude
Code, Codex, Amp, Devin CLI, Pi, OpenCode, Cursor and others; Linux and macOS
are fully supported, Windows in beta; everything runs on the operator's own
machine. It carries a first-class Neovim story (unified split navigation, a
plugin ecosystem for context staging and workspace launching) and is a session
backend for sidekick.nvim. It went to #1 in Rust on GitHub Trending in late June
2026.

[**cmux**](https://cmux.com/) (Manaflow, GPL, `manaflow-ai/cmux`) is a native
macOS terminal — Swift + AppKit on libghostty, GPU-accelerated, no Electron —
built around the same problem from the terminal-emulator side: vertical tabs
showing git branch, working directory, ports and notification text;
"notification rings" that light panes needing attention; horizontal and vertical
splits; a **CLI and socket API for automation and scripting**; a built-in
scriptable browser pane; and an iOS companion syncing terminals in real time
(beta). It wraps the git-worktree lifecycle into single commands, exposes
workspace contents programmatically (`cmux list-workspaces`), supports OSC
9/99/777 notification escapes, and integrates with Claude Code hooks.

## Parallel-agent applications

[**coder/mux**](https://github.com/coder/mux) (AGPL, ~1.9k stars) is a desktop
and browser application for parallel agentic development, running isolated
workspaces with git-divergence tracking across **Local, Worktree, and SSH**
runtimes, multi-model (Claude, GPT-5, Grok, Ollama, OpenRouter), with VS Code
integration for jumping into a workspace. It runs a custom agent loop rather
than only hosting third-party CLIs.

**Claude Squad** takes the terminal-first route — tmux plus git worktrees, each
task in a detached background session that survives closing the pane. **amux**
is a minimal TUI for the same spawn-agents-in-worktrees pattern.

## Task boards and relays

[**Vibe Kanban**](https://vibe-kb.com/) models the work rather than the process:
cards assigned to agents (agent-agnostic across Claude Code, Gemini, Codex),
moved through columns to a review state. Orchestration is the human moving
cards — no shared memory between agents, no inter-agent messaging, no
auto-routing.

**Omnara** relays agent questions and blockers to a phone, with a real mobile
companion — start an agent, open a terminal, dictate a prompt, by voice, synced
to the desktop over an end-to-end encrypted relay. It is the one widely-used
tool supervising at *decision* granularity rather than session granularity.

## Session recorders

[**Entire**](https://github.com/entireio/cli) is a CLI-first system of record
for agent-assisted development: hooks capture sessions (prompts, responses, tool
calls, file changes) as you work, checkpoints are created on commit, and all
session metadata lands on a separate `entire/checkpoints/v1` shadow branch that
functions as an append-only audit log — active-branch commits stay clean. Each
checkpoint carries a 10-character id (`cp-abc123def`) tagged to commits, giving
a session ↔ commit join. `entire rewind` rolls code back to a past checkpoint.

**Agent Note** does the lighter version, saving the *why* behind AI-assisted
code into git notes.

## The granularity axis

| Granularity | Question answered | Tools |
|---|---|---|
| Pane / session | which agent should I look at | herdr, cmux, Claude Squad, amux |
| Workspace / task | which unit of work is where | coder/mux, Vibe Kanban |
| Decision | which agent needs me *now* | Omnara |
| Edit | what is this agent doing right now | — |
| Commit / session record | how was this code produced | Entire, Agent Note |

The edit row is where the shipped tooling thins out: consoles route attention to
an agent, then hand off to whatever the agent renders in its own pane.
