---
type: policy
title: Git branch deletion
description: Merged PR head branches are deleted as part of the merge motion; later sessions leave lingering branches alone and never survey them, and the default branch and any branch with unmerged commits are never deleted without operator approval.
section: git-workflow
order: 1
status: active
tags: [meta, governance, git, branches]
timestamp: 2026-07-27
attribution:
  when: 2026-07-11T09:36:40+00:00
  channel: backfill
  agent: "reconstructed by mix brain.attribution --backfill, 2026-07-13"
  from: [/meta/threads/2026-07-12-beam-jido-evaluation-and-dark-factory-scenario.md, /meta/threads/2026-07-27-secure-financial-agent-and-projects-namespace.md]
---
- **Session branches are ephemeral; the default branch is durable.** Work enters
  the repo on a short-lived head branch (e.g. `claude/<slug>`) and lands in the
  default branch via a pull request. The branch is scaffolding, not history — the
  merge is the record.
- **Delete the head branch when its PR merges.** A merged branch is fully contained
  in the default branch's history, so deleting it loses nothing (its commits stay
  reachable through the merge, and GitHub can restore the branch). Deletion is part
  of the merge motion: prefer the repository's **"Automatically delete head
  branches"** setting; failing that, delete the branch manually right after
  merging.
- **Deletion belongs to the merge motion, not to later sessions.** A merged
  branch noticed in passing is left alone: cleaning up someone else's leftovers
  is not part of the work at hand, and surveying branches to find them turns an
  unrelated session into an audit. Sweeping merged branches is its own
  deliberate cleanup task, run when the operator asks for one — and a session
  that is not that task does not survey, propose, or report on branch state.
- **Never delete without the operator:** the default branch (never), and any branch
  carrying **unmerged** commits — including branches whose PR was closed without
  merging. Those hold work with no other home; propose deletion and wait for the
  operator to ratify, as with any destructive change.
