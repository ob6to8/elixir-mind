---
id: sb:184bae
type: concept
title: git worktree
description: A linked working directory attached to one git repository — its own HEAD, index, and file tree over a shared .git object store — letting multiple branches (and agents) be checked out at once.
provenance: "Agent-distilled glossary definition, pointer to the defining doc"
verified: false
tags: [glossary, git, worktree, parallel-agents]
timestamp: 2026-07-12
---

# git worktree

Git enforces one branch per worktree. It is the primitive that isolates
parallel coding agents — each on its own branch — pushing their conflicts to visible
merge time. Defined by [Git worktrees for parallel AI agents](/knowledge/SWE/version-control/git/git-worktrees-for-parallel-agents.md).

*Seen in:* [2026-07-11 news-digest thread](/meta/threads/2026-07-11-news-digest-intake-and-daily-read.md), [Git worktrees for parallel AI agents](/knowledge/SWE/version-control/git/git-worktrees-for-parallel-agents.md)
