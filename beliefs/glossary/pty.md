---
id: em:519b70
type: concept
title: PTY (pseudoterminal)
description: A kernel-provided pair of character devices that impersonates a hardware terminal — a master end a program reads and writes, a slave end that looks to the child process like a real terminal — so shells and TUIs behave interactively even when no physical terminal exists.
provenance: "Agent-distilled glossary definition, Claude Opus 5"
verified: false
tags: [glossary, systems, terminal, process, unix]
sense: common
timestamp: 2026-08-07
attribution:
  when: 2026-08-07T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "operator asked for daemon, TUI, and PTY alongside the herdr daemon/PTY-ownership explanation"
---

# PTY (pseudoterminal)

A PTY is the kernel object that lets software stand where hardware used to. It
comes as a **pair**: the *slave* end is handed to a child process as its
standard input, output, and error, and is indistinguishable from a serial
terminal — the child sees a tty, so it enables line editing, job control,
signal delivery on `Ctrl-C`, colour, and full-screen redraw. The *master* end
is held by whatever created the pair; bytes written there arrive as the child's
keystrokes, and bytes the child prints arrive there to be rendered, logged, or
forwarded.

The distinction that matters in practice is **PTY versus pipe**. A program
whose output is a pipe usually detects that (`isatty` returns false) and
switches to non-interactive behaviour: no colour, block-buffered output, no
progress redraw, sometimes a refusal to prompt at all. This is why driving an
interactive CLI — a shell, `vim`, a coding agent — requires allocating a PTY
rather than merely capturing stdout, and why terminal automation is built on
PTYs rather than subprocess pipes.

Because the PTY carries the terminal *state* — the child's process group, the
window size, the termios settings, and the emulator's screen buffer — whoever
holds the master end holds the live session. A
[terminal multiplexer](/beliefs/glossary/terminal-multiplexer.md) or a
[daemon](/beliefs/glossary/daemon.md) that keeps master ends open keeps the
sessions alive across disconnects, while
[terminal emulators](/beliefs/glossary/terminal-emulator.md) create PTYs and
paint their output. A PTY does not survive the process holding it: kill that
process and the children are orphaned or hung up.

*Seen in:* [herdr and cmux — two shapes of the same agent multiplexer](/knowledge/SWE/dev-tools/herdr-and-cmux-two-shapes.md), [the daemon owns the PTYs](/meta/elaborations/herdr-daemon-owns-the-ptys.md)
