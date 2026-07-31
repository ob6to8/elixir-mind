---
id: em:119990
type: concept
title: git plumbing
description: Git's low-level, scriptable commands (hash-object, mktree, commit-tree, update-ref, ...) that operate directly on objects and refs without touching the working tree or the index — as distinct from the high-level "porcelain" commands (commit, checkout, merge) built on top of them for interactive use.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, git, version-control]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 GitLord intake thread (commits are built with plumbing so parallel writers on different branches never contend on the working tree or index)"
---

# git plumbing

The name comes from git's own documentation, which splits its commands into
plumbing (the pipes carrying data) and porcelain (the fixtures a user
interacts with). Because plumbing commands write objects and move refs
directly — bypassing the working directory and staging area entirely — a
program can construct arbitrary commits and trees programmatically, without
ever checking anything out, and without the working-tree/index contention
that limits how many processes can safely operate on one checkout at once.
This is what lets a tool use a git repository purely as a data store: commits
as records, refs as pointers, with no filesystem checkout in the loop.

*Seen in:* [2026-07-31 GitLord intake thread](/meta/threads/2026-07-31-gitlord-git-backed-agent-orchestration-intake.md)
