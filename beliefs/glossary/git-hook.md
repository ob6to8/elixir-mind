---
id: em:80c65c
type: concept
title: git hook
description: A script git runs automatically at a point in its lifecycle — most commonly `pre-commit`, just before a commit is recorded — to enforce or automate local checks, aborting the operation on a non-zero exit; git looks for them in the un-versioned `.git/hooks/` by default, so a hook ships with a repository only when checked in elsewhere and git is pointed at it via core.hooksPath.
provenance: "Agent-distilled glossary definition, 2026-07-23 session-start-hook thread"
verified: false
tags: [glossary, git, tooling, ci, pre-commit]
sense: common
timestamp: 2026-07-23
attribution:
  when: 2026-07-23T18:48:28Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-23 session-start-hook-gate thread's concept-by-concept explanation of the session-start.sh core.hooksPath comment"
---

# git hook

Distinct from an agent-harness lifecycle hook such as Claude Code's
[SessionStart hook](/beliefs/glossary/sessionstart-hook.md) or
[PostToolUse hook](/beliefs/glossary/posttooluse-hook.md): those fire around a
coding agent's turns, whereas a git hook fires around git operations. Because the
default location sits inside `.git/` — which is not part of the tree a clone
copies — a project that wants to *share* a hook keeps it as a tracked file (for
example a `.githooks/` directory) and redirects git there with
[core.hooksPath](/beliefs/glossary/core-hookspath.md). The redirect is itself git
config and does not travel with the clone, so it must be set once per checkout for
the shared hook to run.

*Seen in:* [2026-07-23 session-start-hook-gate thread](/meta/threads/2026-07-23-session-start-hook-gate-and-machinery-reference-plan.md)
