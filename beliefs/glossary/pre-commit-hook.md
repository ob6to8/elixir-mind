---
id: em:69676f
type: concept
title: pre-commit hook
description: A git hook that runs before a commit is recorded and can reject it — the earliest surface for the gate suite, giving feedback locally instead of waiting for CI.
provenance: "Agent-distilled glossary definition, surfaced wiring the repo's hook into fresh web sessions"
verified: false
tags: [glossary, git, hooks, gates, ci, workflow]
sense: repo
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the mechanism the version-control audit's highest-leverage recommendation wires into every session"
---

# pre-commit hook

In this repo it lives at `.githooks/pre-commit` and mirrors the
[gate suite](/beliefs/glossary/gate-suite.md) that CI runs, so a red gate is found
before a [presubmit](/beliefs/glossary/presubmit.md) ever starts. Two properties make
it a convenience rather than a dependency: git only consults it when `core.hooksPath`
points at the directory, and it exits `0` with a notice when `mix` is absent instead
of blocking the commit. Because fresh web-session sandboxes clone without that config,
[`session-start.sh`](/.claude/hooks/session-start.sh) now sets it automatically —
otherwise the local surface silently does nothing in the sessions that use it most.

*Seen in:* [2026-07-26 version-control-audit thread](/meta/threads/2026-07-26-version-control-audit-and-response-format-policies.md)
