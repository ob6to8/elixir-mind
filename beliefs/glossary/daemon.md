---
id: em:fadc83
type: concept
title: daemon
description: A long-running background process with no controlling terminal and no user interface of its own, which outlives the sessions that talk to it and serves them over a socket — the tmux server, dockerd, sshd, herdr's PTY-owning server.
provenance: "Agent-distilled glossary definition, Claude Opus 5"
verified: false
tags: [glossary, systems, process, architecture, terminal]
sense: common
timestamp: 2026-08-07
attribution:
  when: 2026-08-07T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "operator asked for daemon, TUI, and PTY alongside the herdr daemon/PTY-ownership explanation"
---

# daemon

The defining property is **detachment from the session that started it**. A
daemon has no controlling terminal, so nothing it holds dies when the terminal
that launched it closes — which is exactly why a daemon is the natural home for
state that must outlive a connection: open sockets, running child processes,
[PTYs](/beliefs/glossary/pty.md). The counterpart shape is the **client**: a
short-lived process that connects, issues requests, renders whatever it is
shown, and exits without taking the state with it.

That split is what makes *attach and detach* possible at all. The tmux server,
`dockerd`, `sshd`, and herdr's background server are all the same arrangement —
one durable process holding the real resources, many disposable clients
speaking to it over a Unix socket. The narrower
[loopback daemon](/beliefs/glossary/loopback-daemon.md) adds only that the
rendezvous point is a localhost-bound socket, so file permissions are typically
the entire access control.

*Seen in:* [herdr and cmux — two shapes of the same agent multiplexer](/knowledge/SWE/dev-tools/herdr-and-cmux-two-shapes.md), [the daemon owns the PTYs](/meta/elaborations/herdr-daemon-owns-the-ptys.md)
