---
type: matter
title: "/create-pull-request scoping edit"
description: Scope /create-pull-request's commit step to the finished matter and define its repeat-invocation behavior in a continued session.
status: open
provenance: "Claude Fable 5, matter-register consumption session (matter-docs build 2)"
tags: [meta, matter, skills, git]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T08:32:00Z
  channel: agent-authored
  agent: "Claude Code agent, matter-register consumption session (matter-docs build 2)"
  why: "migrated from the matters register's row packet when the register thinned to the order-only pointer view"
  from: [/meta/matters.md, /meta/threads/2026-08-02-stand-up-meta-matters-and-thin-the-register.md]
---

# /create-pull-request scoping edit

Two gaps, identified in the origin session: the commit step says "the current
working changes" and needs *scope to the finished matter*; a repeat invocation
in one session appends capture per `brain.thread_tail`, skips re-glossarying
already-captured content, and records the follow-up PR in thread prose (`pr:`
stays origin — already policy).
