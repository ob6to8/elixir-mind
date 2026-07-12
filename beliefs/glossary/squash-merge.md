---
id: sb:4a235a
type: concept
title: squash merge
description: A merge that flattens a branch's commits into one brand-new commit on the target, abandoning the originals — linearizing history at the cost of per-commit provenance (messages, trailers, cited SHAs, blame granularity).
provenance: "Agent-distilled glossary definition; pointer to the reachability tutorial"
verified: false
tags: [glossary, git, merge, provenance]
timestamp: 2026-07-12
---

# squash merge

The cited-SHA cost bites concretely: SHAs cited in durable docs become
garbage-collectible once the branch is deleted. Canonically explained
in [why a true merge keeps cited commits reachable](/meta/tutorials/why-a-true-merge-keeps-cited-commits-reachable.md);
disallowed here by the [merge-strategy policy](/meta/policy/merge-strategy.md).
Contrast [true merge](/beliefs/glossary/true-merge.md).

*Seen in:* [2026-07-10 merge-tutorial thread](/meta/threads/2026-07-10-merge-commit-reachability-tutorial.md), [2026-07-11 session-init thread](/meta/threads/2026-07-11-session-init-digest-and-priorities.md)
