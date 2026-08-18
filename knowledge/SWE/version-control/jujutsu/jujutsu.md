---
id: em:3a1493
type: reference
title: "Jujutsu (jj) — a Git-compatible version control system"
description: A Rust VCS that uses a Git repo as its storage backend, replacing the staging area with a working-copy-as-commit model, tracking conflicts as first-class objects inside commits, and recording every repo operation in an undoable operation log.
resource: https://github.com/jj-vcs/jj
provenance: "Distilled from the jj-vcs/jj GitHub README, fetched 2026-08-18"
tags: [version-control, vcs, git, jujutsu, rust, working-copy-as-commit, conflict-handling, operation-log, commit-rewriting]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# Jujutsu (jj) — a Git-compatible version control system

**Jujutsu** ("jj") is an experimental version control system, written in Rust,
aimed at being easy to use for newcomers and experienced developers alike, on
solo projects and large-scale codebases. It uses a **Git repository as its
storage backend** by default, so it interoperates with existing Git remotes,
hosting, and tooling — a Jujutsu-managed repo can be pushed to and pulled from
GitHub/GitLab exactly like a Git one.

## Key differences from git

- **No staging area — the working copy *is* a commit.** Every change is
  automatically recorded as a commit and amended as you keep editing; there is
  no `git add`, no index, no stash. What you're working on is always a real,
  addressable commit in the history.
- **First-class conflicts.** Conflicts are stored as objects inside a commit
  rather than halting the operation that produced them. A rebase, merge, or
  rewrite that produces a conflict still *succeeds* — the conflict travels
  with the commit and is resolved later, without blocking the rest of the
  workflow.
- **Operation log and undo.** Every repository operation (not just every
  commit) is snapshotted, so `jj undo` or `jj op log` can inspect and reverse
  any past operation — a general undo the project frames as bringing VCS into
  a much later decade on that front than git's commit-only history.
- **Automatic rebase.** Amending a commit automatically rebases every
  descendant commit, propagating conflict markers forward through the tree
  rather than requiring a manual interactive rebase.
- **Rich history rewriting** as a core, low-friction workflow: splitting
  commits, editing descriptions, and moving hunks/changes between commits.

## Origin and maintenance

Started by Martin von Zweigbergk in 2019 as a personal project; it became his
full-time project at Google, though the project states explicitly that it is
not a supported Google product — support is community-driven. The project
moved to the `jj-vcs` GitHub organization in December 2024. The core
developers use `jj` for jj's own development.

**License:** Apache 2.0.

# Citations

- Jujutsu repository — <https://github.com/jj-vcs/jj>
