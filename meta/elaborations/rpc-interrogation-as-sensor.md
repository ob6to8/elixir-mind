---
type: elaboration
title: "RPC-driving shines at interrogation rather than editing — the agent querying LSP diagnostics and editor state as a sensor"
description: Unpacks why agent control of a live editor over its RPC socket pays off as a read channel (asking the editor what it knows) rather than a write channel, and why that read half is the part likely to be absorbed into mainstream agent-editor integrations.
provenance: "Assistant answer of 2026-07-30 on whether devs are adopting agent-driven Neovim, this session; expansion agent-authored"
tags: [elaboration, neovim, agents, rpc, lsp, architecture, editors]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T04:59:08Z
  channel: agent-authored
  agent: "Claude Code agent, /elaborate"
  why: "operator asked to expand the interrogation-vs-editing sentence from the agent-driven-Neovim answer"
---

# RPC-driving shines at interrogation rather than editing

> "The exception where RPC-driving shines is interrogation rather than editing:
> letting the agent query LSP diagnostics and editor state as a sensor. That
> part I'd expect to get absorbed into the mainstream integrations." — from the
> assistant's 2026-07-30 answer on whether developers are adopting agent-driven
> Neovim.

## In plain terms

Programs can control a running editor from the outside. Most attempts at this
have the outside program *change* the text, which mostly duplicates what it
could already do by editing files directly, while adding new ways to get in the
way of the person using the editor. The genuinely useful direction is the
opposite one: letting the outside program *ask questions*. A running editor
already knows things nobody else has cheaply — which errors and warnings the
language tooling has computed for this exact file right now, what the person is
looking at, what is open, what changed. An assistant that can ask for those
answers gets a live picture of the work that it would otherwise have to
recompute from scratch or guess at. The prediction attached to the sentence is
that this asking-questions ability is useful enough that it will stop being a
niche add-on and become a standard part of how assistants connect to editors.

## The terms

- **[RPC](/beliefs/glossary/remote-procedure-call.md) (remote procedure call),
  and "RPC-driving"** — one process invoking functions inside another as if
  they were local, arguments and return values carried over a transport such as
  a socket. *RPC-driving* here means an agent controlling a live editor through
  that channel. Neovim exposes its whole editor API over MessagePack-RPC on an
  auto-created socket; the
  [agent-drivable-apps analysis](/meta/analysis/agent-drivable-apps-shared-state-dual-interfaces.md)
  demonstrated it against the operator's own running instances with no plugin
  installed.
- **interrogation vs. editing** — the two directions of that channel. *Editing*
  is the write direction: the agent mutates buffers, moves the cursor, applies
  changes inside the live session. *Interrogation* is the read direction: the
  agent asks the editor for facts it holds and receives typed answers. The
  sentence claims the value is asymmetric between the two.
- **LSP (Language Server Protocol) diagnostics** — LSP is the standard protocol
  by which an editor talks to a per-language analysis server (`gopls`,
  `rust-analyzer`, `elixir-ls`). *Diagnostics* are that server's stream of
  errors, warnings, and hints for a file — type errors, unresolved symbols,
  unused variables — computed continuously against the file's current state,
  including unsaved changes. The editor holds them in memory; nothing on disk
  contains them.
- **editor state** — everything the running editor knows that the filesystem
  does not: open buffers and their unsaved contents, cursor and selection, the
  quickfix list, marks, window layout, which project root is active. It is live
  and per-session.
- **sensor** — used metaphorically: a component whose job is to *report a
  measurement of current conditions* to a controller, which then decides what
  to do. Casting the editor as a sensor frames it as an instrument the agent
  reads, rather than a surface the agent operates —
  [shared state, dual interfaces](/beliefs/glossary/shared-state-dual-interfaces.md)
  with only the read half in play.
- **mainstream integrations** — the widely-adopted agent↔editor bridges rather
  than the niche RPC servers: the official IDE extensions and their
  protocol-compatible ports (VS Code, JetBrains, and coder/claudecode.nvim for
  Neovim), which speak
  [MCP](/beliefs/glossary/model-context-protocol.md) over a local socket.
- **absorbed** — the prediction's verb: the capability stops being a separate
  tool a user installs and becomes a built-in feature of the standard bridge,
  so the standalone project's reason to exist evaporates.

## What's actually happening

Start with why the write direction disappoints. An agent that edits through the
editor's RPC socket is doing, at greater cost, what it already does by writing
files: the same text ends up in the same place, but now there is a second
writer inside a session a human is also using, and a new class of failure —
cursor fights, a change landing in the wrong window, an edit racing the human's
own typing. The one real gain (buffer-level edits join the editor's undo
history) does not outweigh that, and the mainstream bridges get the same
outcome more safely by writing files and rendering the result as a diff the
human accepts or rejects.

The read direction has no such substitute, and that is the asymmetry the
sentence names. Consider an agent that has just changed six files and wants to
know whether it broke anything. Its default move is to shell out — run the
compiler, run the test suite — which costs seconds to minutes and only sees
saved files. Meanwhile the editor already has the answer: language servers have
been analyzing those buffers continuously, including edits not yet written to
disk, and the diagnostics are sitting in memory a socket call away. The same
holds for the softer facts — what the human is currently looking at, what is
selected, what is in the quickfix list — which are the difference between an
agent that has to ask "which file do you mean?" and one that already knows.

So the useful arrangement is: the agent reads the editor as an instrument and
writes through the ordinary file-and-diff path. The editor becomes the agent's
view of live conditions — roughly a dashboard it can glance at, not a set of
controls it grabs.

The final clause is a prediction about where that capability ends up living.
Today it requires a separate MCP server bolted onto the editor's socket, which
is why adoption is thin. But nothing about reading diagnostics is
Neovim-specific or exotic: the mainstream bridges already hold an open channel
to the editor and already push context (current file, selection) across it, so
extending that channel to also carry diagnostics and editor state is an
increment on an existing connection rather than a new architecture. The write
half is where the standalone RPC servers keep their distinctiveness and their
risk; the read half is a feature the standard bridge can simply have — and once
it does, the standalone server is a niche tool for a solved problem.
