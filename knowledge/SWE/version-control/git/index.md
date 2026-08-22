# Git

Concepts, claims, and references about the git distributed version control system.

## Concepts

- [Git local branches don't auto-advance on fetch](/knowledge/SWE/version-control/git/git-local-branches-dont-auto-advance-on-fetch.md) — `fetch` only updates remote-tracking refs; local branches move only on pull/merge/reset/commit. `em:4c9e1f` _(concept, verified)_
- [Git worktrees for parallel AI agents](/knowledge/SWE/version-control/git/git-worktrees-for-parallel-agents.md) — a linked working dir sharing one `.git` object store but with its own HEAD/index/tree; the primitive that isolates N parallel agents, pushing conflicts to visible merge time. `em:8b9548` _(concept)_

## References

- [Git at any scale — Cursor's Origin Git-hosting architecture](/knowledge/SWE/version-control/git/cursor-git-at-any-scale.md) — hosting Git at scale on S3's atomic compare-and-swap operations, using write-ahead logging plus compaction to separate object storage from reference management, without a separate consensus layer. _(reference)_

## Subdirectories

- [sources](/knowledge/SWE/version-control/git/sources/index.md) — primary-source excerpts from official git documentation
