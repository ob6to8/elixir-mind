---
id: sb:a9113e
type: concept
title: orphaned branch
description: In this brain's git workflow, a remote session branch left lingering after its work concluded — merged-but-undeleted (deletable on sight) or unmerged (never deleted without operator ratification); distinct from git's own parentless orphan branch.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, git, branches, workflow]
timestamp: 2026-07-12
---

# orphaned branch

The opposite handling of the two kinds comes from the [git-branch-deletion policy](/meta/policy/git-branch-deletion.md): a merged branch is fully contained in the default branch's history, so deleting it loses nothing, while an unmerged branch carries commits with no other home. A *false* orphan is an unmerged branch whose content already landed on `main` via a different branch, making it superseded rather than stranded. (Git's own *orphan branch* is the one created with `git checkout --orphan`.)

*Seen in:* [2026-07-11 branch-deletion/contract thread](/meta/threads/2026-07-11-branch-deletion-policy-and-contract-as-abstraction.md)
