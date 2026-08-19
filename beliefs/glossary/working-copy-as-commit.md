---
id: em:a86bdf
type: concept
title: working-copy-as-commit
description: A version-control design where the uncommitted working directory is itself always a real, addressable commit rather than a separate staging area — every edit amends that commit automatically, so there is no `git add`, no index, and no stash.
sense: common
provenance: "agent-distilled from the Jujutsu (jj) project documentation"
verified: false
tags: [version-control, vcs, jujutsu, git]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-18 reading-list batch intake thread, filing Jujutsu"
---

# working-copy-as-commit

This inverts Git's model, where the working directory is provisional state
that must be explicitly staged and committed before it becomes part of
history. Under working-copy-as-commit, provisionality is removed: what
you're actively editing is never "unsaved" — it is always a real commit,
continuously amended, that other tooling (diffing, rebasing, sharing) can
address like any other. The tradeoff this buys is a simpler mental model
(no staging area to reason about) at the cost of every keystroke being, in
principle, part of the permanent history unless deliberately squashed away.

*Seen in:* [Jujutsu (jj) — a Git-compatible version control system](/knowledge/SWE/version-control/jujutsu/jujutsu.md)
