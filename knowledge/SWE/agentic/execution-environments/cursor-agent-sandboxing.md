---
id: em:611de0
type: reference
title: "Implementing a secure sandbox for local agents (Cursor)"
description: Cursor's cross-platform sandbox (Seatbelt on macOS, Landlock+seccomp on Linux, WSL2 on Windows) lets agents run terminal commands freely inside constrained boundaries and ask permission only when crossing them, cutting agent stop-and-ask interruptions by 40% versus unsandboxed operation.
resource: https://cursor.com/blog/agent-sandboxing
provenance: "Cursor blog, \"Agent sandboxing\", fetched 2026-08-21"
tags: [sandboxing, security, agent-infrastructure, seatbelt, landlock, seccomp, cursor]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Implementing a secure sandbox for local agents

Cursor's problem statement: per-command human approval is the default
safety mechanism for agent terminal access, but it degrades into approval
fatigue rather than staying protective — "Requiring human approval for every
command mitigates that risk, but often only temporarily... This gets worse
when engineers run multiple agents in parallel." The fix is not weaker
approval but a narrower one: run the agent unconfined *inside* a sandbox
boundary, and ask for permission only at the boundary — network access, or a
path outside the workspace — instead of on every command.

## Measured effect

"Sandboxed agents stop 40% less often than unsandboxed ones" — the headline
number, and the point of the whole design: most terminal commands an agent
runs need no human judgment at all, and the sandbox is what lets the system
know that without asking each time.

## Platform implementations

- **macOS** — Seatbelt, via `sandbox-exec`: a deprecated but still-functional
  Apple sandboxing technology. Cursor generates dynamic policies per session,
  constraining syscalls and file access according to the workspace's own
  settings and its `.cursorignore` file.
- **Linux** — Landlock (filesystem-access restriction) combined with seccomp
  (blocking unsafe syscalls outright). Workspaces are mapped into overlay
  filesystems, so files matched by `.cursorignore` are not merely
  policy-blocked but structurally absent from what the agent's process can
  see.
- **Windows** — no native sandboxing primitive judged adequate for developer
  tooling, so the Linux sandbox runs inside WSL2 rather than a native Windows
  mechanism being built.

## Making the agent sandbox-aware

Confining the agent's *execution* is only half the problem — the agent also
has to behave sensibly once confined, which required: rewriting the Shell
tool's own description so the model understands the constraints it is
operating under; explicit failure messaging that names which specific
sandbox restriction blocked a given operation (rather than an opaque
permission error); and built-in guidance for when and how to ask for
permission escalation, so a legitimately-needed action outside the boundary
becomes a clean ask rather than a silent retry loop.

## Forward framing

"As agents cross from generating code to operating production systems,
providing execution boundaries is paramount" — sandboxing here is framed as
infrastructure for a future where agents run with more autonomy against real
systems, not only a stopgap for today's approval-fatigue problem.

## Reading against this bundle

This sits beside this bundle's existing
[execution-environments](/knowledge/SWE/agentic/execution-environments/index.md)
material at a different layer: Fly.io and Shellbox sell *where* an agent's
process runs (a whole disposable microVM); Cursor's sandbox constrains *what
a process already running locally can touch* (syscalls, filesystem, network)
without provisioning a separate machine at all. The two are complementary
rather than competing — a microVM is itself a coarser-grained sandbox
boundary, and Cursor's own default is host-local because most of its editor
integration assumes a filesystem the local machine already has open. The
40%-fewer-interruptions result is also a concrete data point for the
approval-fatigue problem this bundle's own permission-allowlisting practice
(`.claude/settings.json`, per the
[session-capture policy](/meta/policy/session-capture.md)'s note on flaky
tool-permission popups) addresses by a different mechanism — allowlisting
known-safe tools rather than sandboxing the process itself.

# Citations

- Cursor blog, "Agent sandboxing" — <https://cursor.com/blog/agent-sandboxing>
