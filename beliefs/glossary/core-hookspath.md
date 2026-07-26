---
id: em:ffbaec
type: concept
title: core.hooksPath
description: The git config key that overrides git's default `.git/hooks/` directory with a path of your choice, so a repository can activate hooks checked into the tree (`git config core.hooksPath .githooks`); because git config is not copied by a clone, it starts unset in every fresh checkout and must be set once per clone to take effect.
provenance: "Agent-distilled glossary definition, 2026-07-23 session-start-hook thread"
verified: false
tags: [glossary, git, tooling, ci, pre-commit]
sense: common
timestamp: 2026-07-23
attribution:
  when: 2026-07-23T18:48:28Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-23 session-start-hook-gate thread's explanation of why a fresh web sandbox skips the local gate"
---

# core.hooksPath

Setting it is idempotent — re-running `git config core.hooksPath <dir>` just
rewrites the same value — which makes it safe to run unconditionally from a
provisioning step. The failure mode it creates in practice: a freshly-cloned
ephemeral sandbox (such as a Claude-on-web session) has the checked-in hook files
on disk but no `core.hooksPath` set, so git silently falls back to the empty
`.git/hooks/` and the local checks never run — a red result then surfaces only in
CI. The hook *script* and the setting that activates it are separate concerns: the
script is a tracked file that clones, the setting is config that does not. See
[git hook](/beliefs/glossary/git-hook.md).

*Seen in:* [2026-07-23 session-start-hook-gate thread](/meta/threads/2026-07-23-session-start-hook-gate-and-machinery-reference-plan.md)
