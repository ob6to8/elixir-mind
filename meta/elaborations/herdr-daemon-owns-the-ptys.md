---
type: elaboration
title: "the daemon owns the PTYs; clients attach and detach"
description: Unpacks herdr's architecture sentence — what the background daemon is actually doing (holding the master end of one pseudoterminal per agent pane, and the session state around them), what "owning" a PTY means concretely, and why that ownership is what makes detach, reattach, and SSH-reachability first-class rather than workarounds.
provenance: "Phrase from the DEBEDb post of 2026-07-26 (https://blog.debedb.com/2026/07/26/herdr-and-cmux-two-shapes-of-the-same-agent-multiplexer/); expansion agent-authored via /elaborate, Claude Opus 5, 2026-08-07"
tags: [elaboration, terminal, pty, daemon, herdr, architecture]
timestamp: 2026-08-07
attribution:
  when: 2026-08-07T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, /elaborate via /intake"
  why: "operator asked what herdr's daemon is actually doing and in what way it owns the PTYs"
---

# the daemon owns the PTYs; clients attach and detach

> "herdr is a daemon plus a TUI client that runs inside the terminal you
> already have. The daemon owns the PTYs; clients attach and detach."
> — [herdr and cmux: two shapes of the same agent multiplexer](https://blog.debedb.com/2026/07/26/herdr-and-cmux-two-shapes-of-the-same-agent-multiplexer/),
> DEBEDb, 2026-07-26

## In plain terms

herdr is split into two programs that happen to ship in one binary. One is a
**background service** that never draws anything on screen: it starts the
coding agents, holds the invisible plumbing each agent talks through, and keeps
track of what every agent is doing. The other is the **thing you look at** — a
full-screen program you run in your ordinary terminal window, which draws the
panes and the sidebar and sends your keystrokes onward.

The important part is which of the two is holding the agents. It is the
background service, not the window. So the window is disposable: close it, lose
the network, walk to another machine and open a terminal there, and the agents
never noticed, because nothing that was actually running lived in the window
you closed. Reconnecting just means starting a new viewer and pointing it at
the same background service.

That is what "owns" is doing in the sentence. It is not a claim about
permissions or licensing — it names *which process is holding the handle that
the agent's terminal session hangs from*. Whoever holds it can keep the session
alive, feed it keystrokes, and read its screen; whoever does not is only ever
looking at a copy.

## The terms

- **[daemon](/beliefs/glossary/daemon.md)** — a long-running background process
  with no controlling terminal and no interface of its own, which outlives the
  sessions that talk to it. Here: herdr's server, started implicitly by the
  first `herdr` invocation and left running afterwards.
- **[TUI](/beliefs/glossary/tui.md)** (terminal user interface) — a full-screen
  interactive program that paints itself with terminal escape sequences inside
  whatever [terminal emulator](/beliefs/glossary/terminal-emulator.md) is
  already open. Here: the client, which is why herdr needs no window of its own
  and works unchanged over SSH — contrast
  [cmux](/knowledge/SWE/dev-tools/cmux.md), which *is* the terminal emulator.
- **[PTY](/beliefs/glossary/pty.md)** (pseudoterminal) — a kernel-provided pair
  of devices impersonating a hardware terminal. The child process is handed the
  *slave* end and sees an ordinary tty; the creator keeps the *master* end,
  where the child's output arrives and through which keystrokes are injected.
- **attach / detach** — connecting a client to an already-running session, and
  disconnecting it without stopping that session. Both are only meaningful
  because the session is held somewhere other than the client.
- **[terminal multiplexer](/beliefs/glossary/terminal-multiplexer.md)** — the
  general shape herdr instantiates, tmux being canonical: a layer between the
  emulator and the programs it hosts, multiplexing several sessions into panes.

## What the daemon is actually doing

Four jobs, of which PTY ownership is the first and the one the others rest on.

**1. It creates and holds one PTY per agent pane.** When a pane is opened,
the daemon allocates a pseudoterminal pair, forks the agent CLI (Claude Code,
Codex, whatever) with the *slave* end wired to its stdin, stdout, and stderr,
and retains the *master* end itself. The agent therefore believes it is talking
to a real terminal — it prints colour, redraws its status line, responds to
`Ctrl-C`, and prompts interactively — while in fact every byte it emits lands
in the daemon's buffer and every keystroke it receives was written there by the
daemon. herdr does this through the `portable-pty` crate; tmux, `sshd`, and
`script` all do the same thing.

**2. It is the parent process.** Because the daemon forked the agents, they are
its children, and their lifetime is bound to the daemon rather than to your
terminal window. This is the mechanical reason closing the laptop does not kill
them, and equally the reason the article concedes the limit: "a power cycle
kills the herdr daemon too, and nothing resurrects a dead PTY."

**3. It keeps the terminal state each client needs to redraw.** Owning the
master end means owning the scrollback, the current screen contents, the
window dimensions, and each pane's inferred agent state
(`blocked`/`working`/`done`/`idle`). A newly attached client has none of that
and asks for it; this is why reattaching restores the layout and history rather
than showing empty panes. herdr derives the agent state by evaluating manifests
against a terminal snapshot — a consequence of PTY ownership, since the screen
is the only signal a process reading a character stream actually has, and the
contrast the article draws with cmux's hook-reported state.

**4. It serves the socket API.** Because the daemon is the single holder of
every pane, it is also the only process that can arbitrate access to them, so
the programmatic surface belongs there: `read`, `send`, `split`, `attach`, and
`agent wait --until done|blocked`. The `wait` verb is possible precisely
because the daemon sees each pane's output as it arrives — it can resolve the
wait on an event rather than by polling, and can pin the pane's occupant so a
replacement agent cannot satisfy someone else's wait.

## In what way it "owns" them

Concretely, ownership is three things held together by one process:

- **It holds the master file descriptor.** Only the holder can read the
  session's output or write input into it. A client never touches the PTY; it
  receives a rendered view over the socket and sends keystrokes back as
  messages.
- **It is the parent in the process tree**, so it controls lifetime, receives
  the child's exit status, and can restart or replace an occupant.
- **It is the single writer**, which makes concurrent clients coherent. Two
  attached viewers — your laptop and your phone over SSH — see the same session
  because both are reading one authoritative copy, not two independent
  connections to the agent.

The negative case makes it clearest: a terminal emulator that creates its own
PTYs owns them the same way, but *it is also the window*. Killing the window
kills the owner, and the session goes with it. herdr's split moves ownership
one process away from the window, and that single move is what turns detach,
reattach, SSH-reachability, and remote mirroring from workarounds into ordinary
operations — the point the article is making when it says almost everything
else follows from that one choice.

## See also

- [herdr and cmux — two shapes of the same agent multiplexer](/knowledge/SWE/dev-tools/herdr-and-cmux-two-shapes.md) —
  the capture of the post this phrase comes from
- [herdr](/knowledge/SWE/dev-tools/herdr.md) — the product capture
- [loopback daemon](/beliefs/glossary/loopback-daemon.md) — the same
  daemon/client split named for its localhost socket
