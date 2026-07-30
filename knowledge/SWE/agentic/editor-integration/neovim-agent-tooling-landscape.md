---
id: em:ca359c
type: reference
title: "Neovim agent tooling landscape"
description: The ecosystem connecting coding agents to Neovim — the MCP IDE bridge that ports the official extension protocol, three tiers of in-editor assistance, and the terminal-side runners that treat the editor as one pane among several.
provenance: "Distilled from project repositories and documentation fetched 2026-07-30: github.com/coder/claudecode.nvim, github.com/folke/sidekick.nvim, github.com/yetone/avante.nvim, github.com/yigitkonur/awesome-herdr, herdr.dev, hunk.dev"
tags: [neovim, editor-integration, agentic, mcp, plugins, tooling]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T05:40:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed research session on Neovim adoption in the agentic era"
  why: "the tool landscape was load-bearing for the agent-pairing project's design and existed nowhere in the taxonomy"
---

# Neovim agent tooling landscape

Neovim's position in agentic workflows follows from one architectural property:
it is **scriptable in two stacked senses**. It embeds a Lua runtime, so plugins
are ordinary programs with access to the full editor API; and it exposes that
same API to *external* processes over an auto-created MessagePack-RPC socket, so
an agent connecting to it is architecturally the same kind of client as a GUI.
Agents therefore integrate as external clients rather than being embedded as a
vendor-built chat panel — the integration is agent-agnostic, moves at plugin
pace rather than release pace, and leaves the editor as shared state both the
human and the agent address.

## The MCP IDE bridge

Anthropic ships first-party Claude Code extensions for VS Code and JetBrains
that speak an MCP-over-WebSocket protocol.
[coder/claudecode.nvim](https://github.com/coder/claudecode.nvim) is a pure-Lua
reimplementation of that protocol: the plugin starts a WebSocket server inside
the editor and writes its port to a lock file under `~/.claude/ide/`; the Claude
Code CLI discovers the lock file and connects. Context flows out (current
buffer, visual selection), proposed edits flow back and render as native Neovim
diffs to accept or reject. Requires Neovim ≥ 0.8.

Community wrappers exist that toggle an agent in a terminal split without
speaking the protocol; they are launchers rather than integrations.

## Three tiers of in-editor assistance

| Tier | Plugin | What it does |
|---|---|---|
| Inline completion | [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | ghost-text suggestions at the cursor, integrating with `nvim-cmp`/`blink.cmp` |
| Predicted edits | [sidekick.nvim](https://github.com/folke/sidekick.nvim) (NES) | next-edit suggestions from the Copilot **LSP** — predicts the next edit *anywhere in the file*, rendered as Treesitter-highlighted word-granular diffs walked with `<Tab>`; requires Neovim ≥ 0.11.2 and a Copilot subscription |
| Sidebar refactor | [avante.nvim](https://github.com/yetone/avante.nvim) | describe a change, get a planned multi-file diff applied hunk-by-hunk; multi-provider (Claude, OpenAI, Gemini, Copilot, Ollama) |
| Buffer-native chat | codecompanion.nvim | chat in an ordinary buffer with `@buffer`/`@lsp` context variables and inline transformation |

sidekick.nvim's second subsystem is independent of its first: a provider-agnostic
terminal manager preconfiguring twelve agent CLIs (aider, amazon_q, claude,
codex, copilot, crush, cursor, gemini, grok, opencode, pi, qwen), each in its own
scratch terminal with session persistence via tmux or zellij and automatic file
reloading. On top sits a prompt library (`changes`, `diagnostics`, `explain`,
`fix`, `optimize`, `review`, `tests`, `quickfix`) composed with context
variables — `{file}`, `{selection}`, `{position}`, `{diagnostics}`,
`{diagnostics_all}`, `{function}`, `{class}`, `{buffers}`, `{quickfix}`,
`{this}`.

The two integration styles differ in who holds context. sidekick manages the
agent as a terminal session it owns and injects context by prompt templating;
claudecode.nvim speaks the IDE protocol, so the agent pulls context and pushes
diffs natively.

## The terminal side

[herdr](https://herdr.dev/) treats the editor as one pane in an agent workspace
rather than the center of the workflow, and carries a first-party Neovim
integration story: unified `Ctrl+h/j/k/l` navigation that flows from a Vim split
into an adjacent herdr pane and back, plus community plugins for context staging
([herdr-context.nvim](https://github.com/makyinmars/herdr-context.nvim) stages a
visual selection into a chosen live agent's prompt without submitting),
workspace launching ([herdr-deck](https://github.com/ctbaum/herdr-deck) opens a
project or worktree as a ready-made Neovim + agent + shell + lazygit deck), pane
navigation, split management, and REPL spawning. herdr is also a session backend
for sidekick.nvim alongside tmux and zellij.

[hunk](https://www.hunk.dev/) is the review-side complement: a viewer-only
terminal diff tool whose watch mode keeps a live-updating changeset view open
while an agent edits the tree in another pane, with agent-authored annotations
rendered beside the code they discuss. Because it never writes, it sits next to
an editor without contending for the buffer.

## Citations

- [coder/claudecode.nvim](https://github.com/coder/claudecode.nvim)
- [folke/sidekick.nvim](https://github.com/folke/sidekick.nvim)
- [yetone/avante.nvim](https://github.com/yetone/avante.nvim)
- [awesome-herdr](https://github.com/yigitkonur/awesome-herdr)
- [herdr.dev](https://herdr.dev/)
- [hunk.dev](https://www.hunk.dev/)
